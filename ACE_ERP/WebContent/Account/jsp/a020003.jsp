<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 반제
+ 프로그램 ID	:  A020003.html
+ 기 능 정 의	:  반제관리
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2006.02.23
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 반제전표조회,반제전표상세,반제전표조회 추가 
+ 수   정  자 :  구 자 헌
+ 수 정 일 자 :  2006.04.06
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 반제처리, 내역조회, 반제전표조회, 반제전표상세, 반제현황조회 변경
+ 수   정  자 :  정영식
+ 수 정 일 자 :  2006.05.01
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 상계처리 반영
+ 수   정  자 :  정영식
+ 수 정 일 자 :  2006.06.28
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 1. 엑셀버튼추가(내역조회)
+ 수   정  자 :  정  영  식
+ 수 정 일 자 :  2007.06.13
-----------------------------------------------------------------------------
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html> 
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>반제처리</title>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">

</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;

var custcd = "";
var vendcd = "";
var gdbldeamt=0;
var gdblcramt=0;
var gstrGubun="";  //T-종합만 가능

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
  
     ln_DispChk(0);

	gcem_actdat_fr.text = "19900101";
	gcem_actdat_to.text = gs_date;
  //gcem_actdat03_fr.text = gcurdate.substring(0,4) + "0101";
	gcem_actdat03_fr.text = "19900101";
	gcem_actdat03_to.text = gs_date;
  //gcem_actdat05_fr.text = gcurdate.substring(0,4) +"0101";
	gcem_actdat05_fr.text = "19900101";
	gcem_actdat05_to.text = gs_date;
	gcra_gubun.codevalue="N";
    ln_Before();

	//임시-----------------
	gclx_fdcode.bindcolval ="02";
    gclx_fdcode03.bindcolval ="02";
	 gclx_fdcode05.bindcolval ="02";
	
	//-------------------
}

/******************************************************************************
	Description : 조회 (전표작성)
	            : 계정 : 필수              
                거래처 : 선택안하면 전체 거래처를 모두 조회함.
								관리항목 : 거래처 선택시 ==>  해당거래처의 해당 관리항목 조회
								           거래처 선택안할 시 ==> 모든거래처의 관리항목 조회
******************************************************************************/
function ln_Query(){
  gstrGubun="";
	var strCustcd="";
	var date_fr="";
	var date_to="";
	var fsrefcd2="";

  if(ln_Chk('01')){
	  if(txt_custcd_fr.value==""){
			strCustcd="All";  //모든 거래처 조회
		}else{
			strCustcd =txt_custcd_fr.value;
		}

    //종합체크 :::  거래처가 존재하고, 관리항목 from, to가 동일해야만 가능
		if(txt_custcd_fr.value!=""&&txt_custnm_fr.value!=""){
			if(gclx_fsrefcd.bindcolval!=""&&txt_fsrefcd_fr.value!=""&&txt_fsrefcd_to.value!=""){
				if(txt_fsrefcd_fr.value==txt_fsrefcd_to.value){
					gstrGubun="T";
				}
			}
		}

   //가수금의 경우 가수일자로 조회 가능함.
	 if(txt_atcode_fr.value=="2101300"){
			date_fr=gcem_date_fr.text;
			date_to=gcem_date_to.text;
			if(gcem_date_fr.text!=""&&gcem_date_to.text!=""){
				fsrefcd2="1125";
			}else{
				fsrefcd2="";
			}
		}

    //gcgd_data01.DataID ="";
		gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_s1?v_str1="+gclx_fdcode.bindcolval //지점       
																										+"&v_str2="+gcem_actdat_fr.text			//처리기간FR 
																										+"&v_str3="+gcem_actdat_to.text			//처리기간TO 
																										+"&v_str4="+gcra_gubun.codevalue		//구분       
																										+"&v_str5="+strCustcd			          //거래처FR   
																										+"&v_str6="+txt_atcode_fr.value     //계정과목FR 
																										+"&v_str7="+gclx_fsrefcd.bindcolval  //관리항목 
																										+"&v_str8="+txt_fsrefcd_fr.value     //관리항목FR  
																										+"&v_str9="+txt_fsrefcd_to.value     //관리항목FR   
																										+"&v_str10="+date_fr                 //from 일자          
																										+"&v_str11="+date_to                 //to 일자            
																										+"&v_str12="+fsrefcd2;               //관리항목2   
	  //prompt("gcds_data01",gcds_data01.DataID);
	  gcds_data01.Reset();

	}
}     

/******************************************************************************
	Description : 잔액과 dtl 금액 체크
******************************************************************************/               
function ln_Banjae_Amt_Chk(){
  var dblChaamt=0;
	var dblDaeamt=0;
	for(i=1;i<=gcds_data01.countrow;i++){
	  dblDaeamt=0;
		dblChaamt=0;
			for(k=1;k<=gcds_banjae.countrow;k++){
				if(gcds_data01.namevalue(i,"FDCODE")==gcds_banjae.namevalue(k,"FDCODE")&&
					 gcds_data01.namevalue(i,"FSDAT")==gcds_banjae.namevalue(k,"TSDAT")&&
					 gcds_data01.namevalue(i,"FSNBR")==gcds_banjae.namevalue(k,"TSNBR")&&
					 gcds_data01.namevalue(i,"FSSEQ")==gcds_banjae.namevalue(k,"TSSEQ")){
          
					 if(gcds_data01.namevalue(i,"DAEAMT")==0){       //차변발생
							dblDaeamt += gcds_banjae.namevalue(k,"BJCRAMT");
					 }else if(gcds_data01.namevalue(i,"CHAAMT")==0){ //대변발생
							dblChaamt+= gcds_banjae.namevalue(k,"BJDEAMT"); 
					 }else{ //차변 대변 둘다 0 이 아닌 경우
							if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")>0){      //차변이 큰 경우 차변발생
								 dblDaeamt += gcds_banjae.namevalue(k,"BJCRAMT");
							}else if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")<0){//대변이 큰 경우 대변발생
								 dblChaamt+= gcds_banjae.namevalue(k,"BJDEAMT"); 
							}
					 }
				}//if
			}// k for
		
		if(gcds_data01.namevalue(i,"DAEAMT")==0){
			gcds_data01.namevalue(i,"JANAMT") = gcds_data01.namevalue(i,"CHAAMT")-dblDaeamt;
		}else if(gcds_data01.namevalue(i,"CHAAMT")==0) {
			gcds_data01.namevalue(i,"JANAMT") = gcds_data01.namevalue(i,"DAEAMT")-dblChaamt;
		}else{
			if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")>0){      //차변이 큰 경우
				 gcds_data01.namevalue(i,"JANAMT") = gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")-dblDaeamt;
			}else if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")<0){//대변이 큰 경우
				 gcds_data01.namevalue(i,"JANAMT") = gcds_data01.namevalue(i,"DAEAMT")-gcds_data01.namevalue(i,"CHAAMT")-dblChaamt;
			}
		}
	}// i for 
}

/******************************************************************************
	Description : 잔액과 gcds_banjae 금액 체크 Row별로 Retrun;
	Parameter   : i - 반제원장의 row
	              gubun - return 값 구분
******************************************************************************/               
function ln_Dtl_Amt_Chk_Return(i,gubun){
	var dblChaamt=0;
	var dblDaeamt=0;

	///alert("ln_Dtl_Amt_Chk_Return");
	for(k=1;k<=gcds_banjae.countrow;k++){
		if(gcds_data01.namevalue(i,"FDCODE")==gcds_banjae.namevalue(k,"FDCODE")&&
			 gcds_data01.namevalue(i,"FSDAT")==gcds_banjae.namevalue(k,"TSDAT")&&
			 gcds_data01.namevalue(i,"FSNBR")==gcds_banjae.namevalue(k,"TSNBR")&&
			 gcds_data01.namevalue(i,"FSSEQ")==gcds_banjae.namevalue(k,"TSSEQ")){
        
			 if(gcds_data01.namevalue(i,"DAEAMT")==0){ 
					dblDaeamt += gcds_banjae.namevalue(k,"BJCRAMT"); 
			 }else if(gcds_data01.namevalue(i,"CHAAMT")==0){
					dblChaamt+= gcds_banjae.namevalue(k,"BJDEAMT");
			 }else{
					if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")>0){
             //dblDaeamt=dblDaeamt+gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")+gcds_banjae.namevalue(k,"BJDEAMT");
						 dblDaeamt=dblDaeamt+gcds_banjae.namevalue(k,"BJCRAMT");
					}else if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")<0){
             //dblChaamt=dblChaamt+gcds_data01.namevalue(i,"DAEAMT")-gcds_data01.namevalue(i,"CHAAMT")+gcds_banjae.namevalue(k,"BJCRAMT");
						 dblChaamt=dblChaamt+gcds_banjae.namevalue(k,"BJDEAMT");
					}
			 }
		}//if
	}// k for
			
	if(gcds_data01.namevalue(i,"DAEAMT")==0){
		gcds_data01.namevalue(i,"JANAMT")=gcds_data01.namevalue(i,"CHAAMT")-dblDaeamt;
	}else if(gcds_data01.namevalue(i,"CHAAMT")==0){
		gcds_data01.namevalue(i,"JANAMT")=gcds_data01.namevalue(i,"DAEAMT")-dblChaamt;
	}else{
		if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")>0){
      gcds_data01.namevalue(i,"JANAMT")=gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")-dblDaeamt;
		}else if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")<0){
			gcds_data01.namevalue(i,"JANAMT")=gcds_data01.namevalue(i,"DAEAMT")-gcds_data01.namevalue(i,"CHAAMT")-dblChaamt;
		}
	}

	if(gubun=="2"){
		return dblDaeamt+dblChaamt;
	}else{
		return gcds_data01.namevalue(i,"JANAMT");
	}
}

/******************************************************************************
	Description : 잔액 계산시 적용
	prameter    : p1 - 01 차변금액만 존재
	                   02 대변금액만 존재
******************************************************************************/
function ln_Amt_Chk(p1,i){
  var tempbjdeamt=0;
	var tempbjcramt=0;
	if(gcds_banjae.countrow>0){
		for(j=1;j<=gcds_banjae.countrow;j++){
			if(gcds_data01.namevalue(i,"FDCODE")==gcds_banjae.namevalue(j,"FDCODE")&&
				 gcds_data01.namevalue(i,"FSDAT")==gcds_banjae.namevalue(j,"TSDAT")&&
				 gcds_data01.namevalue(i,"FSNBR")==gcds_banjae.namevalue(j,"TSNBR")&&
				 gcds_data01.namevalue(i,"FSSEQ")==gcds_banjae.namevalue(j,"TSSEQ")){
				 
				 if(p1=="02") {
					 tempbjdeamt += gcds_banjae.namevalue(j,"BJDEAMT");
				 }else if(p1=="01") {
					 tempbjcramt += gcds_banjae.namevalue(j,"BJCRAMT");
				 }
			}
		}//for j
	}//if
  if (p1=="02"){
		return  tempbjdeamt; 
	}else if(p1=="01"){
		return  tempbjcramt; 
	}
}



/******************************************************************************
	Description : 반제내역조회
******************************************************************************/               
function ln_Query2(p1,p2,p3,p4,p5,p6,p7,p8){

   if(p7==""&&p8==""){
			p7="0002";
	 }
	 gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_s2?v_str1="+p1    //지점    
																										+"&v_str2="+p2		//접수일자
																										+"&v_str3="+p3		//접수번호
																										+"&v_str4="+p4		//접수행번호    
																										+"&v_str5="+p5		//계정    
																										+"&v_str6="+p6  	//거래처  
																										+"&v_str7="+p7		//관리항목    
																										+"&v_str8="+p8;		//관리항목값  
	/// prompt("",gcds_data02.DataID);																								
	 gcds_data02.Reset();

}	

/******************************************************************************
	Description : 반제전표조회
******************************************************************************/               
function ln_Query3(){

	 gcds_data03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_s3?v_str1="+gcem_actdat03_fr.text    //회계일자 FR   
																										+"&v_str2="+gcem_actdat03_to.text		 //회계일자 TO		
																										+"&v_str3="+gclx_fsstat03.bindcolval		  //구분
																										+"&v_str4="+gclx_fdcode03.bindcolval		//지점    
																										+"&v_str5="+txt_remark03.value;		      //적요  
																										
	 //prompt("",gcds_data03.DataID);																								
	 gcds_data03.Reset();															
																										
}	

/******************************************************************************
	Description : 반제전표상세
******************************************************************************/               
function ln_Query4(p1,p2,p3){

	 gcds_data04.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_s4?v_str1="+p1    //지점    
																										+"&v_str2="+p2		//반제전표일자
																										+"&v_str3="+p3;		//반제전표번호
	 //prompt("",gcds_data04.DataID);																								
	 gcds_data04.Reset();
   gcds_data04_2.ClearAll();
}	

/******************************************************************************
	Description : 반제전표상세 - 원전표 찾기
******************************************************************************/               
function ln_Query4_2(p1,p2,p3,p4){

	 gcds_data04_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_s4_2?v_str1="+p1    //지점    
																									     	+"&v_str2="+p2		//원전표접수일자
																										    +"&v_str3="+p3    //원전표접수번호 
																												+"&v_str4="+p4;		//원전표접수행번호
	 //prompt("",gcds_data04_2.DataID);																								
	 gcds_data04_2.Reset();

}	


/******************************************************************************
	Description : 반제현황조회
******************************************************************************/               
function ln_Query5(){
  var strCustcd="";
	if(txt_custcd05_fr.value==""){
		strCustcd="All";  //모든 거래처 조회
	}else{
		strCustcd =txt_custcd05_fr.value;
	}
   /*
	 gcds_data05.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_s5?v_str1="+gclx_fdcode05.bindcolval //지점         
																										+"&v_str2="+gcem_actdat05_fr.text		 //회계일자FR   
																										+"&v_str3="+gcem_actdat05_to.text		 //회계일자TO   
																										+"&v_str4="+gclx_fsstat05.bindcolval //전표상태     
																										+"&v_str5="+txt_atcode05_fr.value		 //계정과목     
																										+"&v_str6="+txt_fsrefcd05_fr.value	 //관리항목 FR  
																										+"&v_str7="+txt_fsrefcd05_to.value 	 //관리항목 TO 
																										+"&v_str8="+gclx_fsrefcd05.bindcolval; //관리항목코드
																									
	 //prompt("",gcds_data05.DataID);																								
	 gcds_data05.Reset();
   */
	// alert("gstrGubun"+gstrGubun);
	gcds_data05.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_s5?v_str1="+gclx_fdcode05.bindcolval //지점       
																									+"&v_str2="+gcem_actdat05_fr.text			//처리기간FR 
																									+"&v_str3="+gcem_actdat05_to.text			//처리기간TO 
																									+"&v_str4="+gclx_gubun05.bindcolval		//구분       
																									+"&v_str5="+strCustcd			             //거래처FR   
																									+"&v_str6="+txt_atcode05_fr.value     //계정과목FR 
																									+"&v_str7="+gclx_fsrefcd05.bindcolval  //관리항목 
																									+"&v_str8="+txt_fsrefcd05_fr.value     //관리항목FR  
																									+"&v_str9="+txt_fsrefcd05_to.value;    //관리항목FR   
	////^^alert("gcds_data05",gcds_data05.DataID);
	gcds_data05.Reset();
	gcds_data05_2.ClearAll();
}	

/******************************************************************************
	Description : 반제현황조회 - 원전표 찾기
******************************************************************************/               
function ln_Query5_2(p1,p2,p3,p4,p5,p6,p7,p8){
	/*
	 gcds_data05_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_s4_2?v_str1="+p1    //지점    
																									     	+"&v_str2="+p2		//원전표접수일자
																										    +"&v_str3="+p3    //원전표접수번호 
																												+"&v_str4="+p4;		//원전표접수행번호
	 //^^alert("gcds_data05_2",gcds_data05_2.DataID);																								
	 gcds_data05_2.Reset();
*/
	  if(p7==""&&p8==""){
			p7="0002";
	 }

	 gcds_data05_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_s2?v_str1="+p1    //지점    
																										+"&v_str2="+p2		//접수일자
																										+"&v_str3="+p3		//접수번호
																										+"&v_str4="+p4		//접수행번호    
																										+"&v_str5="+p5		//계정    
																										+"&v_str6="+p6  	//거래처  
																										+"&v_str7="+p7		//관리항목    
																										+"&v_str8="+p8;		//관리항목값  
	 ////^^alert("gcds_data05_2",gcds_data05_2.DataID);																								
	 gcds_data05_2.Reset();
}	

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : 체크
	Parameter   : p1  - 01 : 필수항목체크 (조회시)
	                    02 : 반제계정 생성시 체크
											03 : 건별 및 종합 생성시
******************************************************************************/
function ln_Chk(p1){

  if(p1=="01"){
		if(gclx_fdcode.bindcolval==""){
			alert("지점은 필수항목입니다.")
			return false;
		}

		if(gcem_actdat_fr.text==""||gcem_actdat_to.text==""){
			alert("기간은 필수항목입니다.")
			return false;
		}

    if(txt_atcodenm_fr.value==""||txt_atcode_fr.value==""){
			alert("계정과목은 필수항목입니다.")
			return false;
		}

/*
    if(txt_custnm_fr.value==""||txt_custcd_fr.value==""||txt_custnm_to.value==""||txt_custcd_to.value==""){
			alert("거래처는 필수항목입니다.")
			return false;
		}
*/

	}else if(p1=="02"){
	  //^^alert("aaa");
		for(i=1;i<=gcds_data01.countrow;i++){
			if(gcds_data01.namevalue(i,"CHK")=="T"){
			  //^^alert("true");
				return true;
			}
		}
		alert("선택된 항목이 없습니다.");
    return false;

	}else if(p1=="03"){
		if(gcds_data01.sum(16,0,0)==0 || gcds_data01.sum(16,0,0)==""){ //BANJAEAMT
			alert("반제금액이 존재하지 않습니다.");
			return false;
		}
  }
	return true;
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
  gcds_comfield.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	gcds_comfield.Reset();//지점구분

	gcds_comfield02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	gcds_comfield02.Reset();

	gcds_comfield03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	gcds_comfield03.Reset();

	gcds_comfield04.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	gcds_comfield04.Reset();

	gcds_comfield05.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	gcds_comfield05.Reset();

	//본부검색
	gcds_divcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_divcd_s1?";  
	////^^alert("gcds_divcd.DataID",gcds_divcd.DataID);
	gcds_divcd.Reset();

	//관리항목[검색]
	gcds_fsrefcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0050";  
	gcds_fsrefcd.Reset();

	//관리항목5[검색]
	gcds_fsrefcd05.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0050";  
	gcds_fsrefcd05.Reset();

}
/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){
	
}


/******************************************************************************
	Description : 삭제 - 접수번호를 기준으로 반제데이타를 삭제함.
******************************************************************************/
function ln_Delete3(){
  var row = gcds_data03.rowposition;
	if(row<1){
		alert("항목을 선택하십시요");
	}

	if(gcds_data03.namevalue(row,"FSSTAT")=="N"||gcds_data03.namevalue(row,"FSSTAT")=="B"){
		gcds_del03.clearall();
		ln_SetDataHeader("DTL_03"); 
		gcds_del03.addrow();
		gcds_del03.namevalue(gcds_del03.rowposition,"FDCODE")=gcds_data03.namevalue(row,"FDCODE");
		gcds_del03.namevalue(gcds_del03.rowposition,"BTSDAT")=gcds_data03.namevalue(row,"BTSDAT");
		gcds_del03.namevalue(gcds_del03.rowposition,"BTSNBR")=gcds_data03.namevalue(row,"BTSNBR");
		gcds_del03.namevalue(gcds_del03.rowposition,"TSDAT")="";
		gcds_del03.namevalue(gcds_del03.rowposition,"TSNBR")="";
		gcds_del03.namevalue(gcds_del03.rowposition,"TSSEQ")="";

		if(confirm("삭제하시겠습니까?")){	
			gctr_data03.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_t3?";
			//prompt("gcds_del03",gcds_del03.text);
			gctr_data03.post();
		}	
	}else{
		alert("전표상태가 삭제건이 아닙니다.");
	}
}


/******************************************************************************
	Description : 데이터셋삭제
******************************************************************************/
function ln_Row_Del(){
  var dbl_janamt_back = 0;
  
	//반제연결테이블 삭제
	//alert("gcds_banjae.countrow"+gcds_banjae.countrow);
	//alert("ln_Row_Del  SEQ:::"+gcds_dtl.namevalue(gcds_dtl.rowposition,"SEQ"));

	if(gcds_dtl.namevalue(gcds_dtl.rowposition,"SEQ")!="0"){ //종합
	  //원전표잔액복구
		for(k=1;k<=gcds_data01.countrow;k++){
			for(j=1;j<=gcds_banjae.countrow;j++){
				dbl_janamt_back=0;
				//alert("k::"+k+"::j::"+j);
				////^^alert("gcds_banjae",gcds_banjae.text);
				////^^alert("gcds_dtl",gcds_dtl.text);
				//alert("SEQ::"+gcds_banjae.namevalue(j,"SEQ")+"::gcds_dtl::"+gcds_dtl.namevalue(gcds_dtl.rowposition,"SEQ"));
				if(gcds_banjae.namevalue(j,"SEQ")==gcds_dtl.namevalue(gcds_dtl.rowposition,"SEQ")){
					if(gcds_banjae.namevalue(j,"BJCRAMT")==0){
						dbl_janamt_back += gcds_banjae.namevalue(j,"BJDEAMT");
					}else if(gcds_banjae.namevalue(j,"BJDEAMT")==0){
						dbl_janamt_back += gcds_banjae.namevalue(j,"BJCRAMT");
					}
					
				//	alert("FDCODE"+gcds_banjae.namevalue(j,"FDCODE")+"::gcds_data01::"+gcds_data01.namevalue(k,"FDCODE"));
				//	alert("TSDAT"+gcds_banjae.namevalue(j,"TSDAT")+"::FSDAT::"+gcds_data01.namevalue(k,"FSDAT"));
				//	alert("TSNBR"+gcds_banjae.namevalue(j,"TSNBR")+"::FSNBR::"+gcds_data01.namevalue(k,"FSNBR"));
				//	alert("TSSEQ"+gcds_banjae.namevalue(j,"TSSEQ")+"::FSSEQ::"+gcds_data01.namevalue(k,"FSSEQ"));
					if(gcds_banjae.namevalue(j,"FDCODE")==gcds_data01.namevalue(k,"FDCODE")&&
						 gcds_banjae.namevalue(j,"TSDAT")==gcds_data01.namevalue(k,"FSDAT")&&
						 gcds_banjae.namevalue(j,"TSNBR")==gcds_data01.namevalue(k,"FSNBR")&&
						 gcds_banjae.namevalue(j,"TSSEQ")==gcds_data01.namevalue(k,"FSSEQ")){

						//alert("k:"+k+":j:"+j+":dbl_janamt_back:"+dbl_janamt_back+":JANAMT:"+gcds_data01.namevalue(k,"JANAMT") );
						//원접수번호가 같을 경우 잔액에 더해줌
						gcds_data01.namevalue(k,"JANAMT") += dbl_janamt_back;
						gcds_data01.namevalue(k,"CHK")="F";
						//gcds_data01.namevalue(k,"BANJAEAMT")-= dbl_janamt_back;
					}
					//gcds_banjae.DeleteRow(j);
				}
			}//for j
		} //for k
    
	
		/*
		 //^^alert("gcds_dtl",gcds_dtl.text);
		 //^^alert("gcds_banjae",gcds_banjae.text);
		 //^^alert("gcds_banjaemst",gcds_banjaemst.text);
    */
     //반제MST 데이타셋 삭제
		 //dtl의 반제전표 == banjae의 반제전표 && 
		 //banjae의 원전표 == banjaemst의 원전표를 찾아서 Delete 
		for(j=1;j<=gcds_banjae.countrow;j++){
			for(k=1;k<=gcds_banjaemst.countrow;k++){
				if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")==gcds_banjae.namevalue(j,"FDCODE")&&
				   gcds_dtl.namevalue(gcds_dtl.rowposition,"FSDAT")==gcds_banjae.namevalue(j,"BTSDAT")&&
          			 gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNBR")==gcds_banjae.namevalue(j,"BTSNBR")&&
					 gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")==gcds_banjae.namevalue(j,"BTSSEQ")){    

						if(gcds_banjae.namevalue(j,"FDCODE")==gcds_banjaemst.namevalue(k,"FDCODE")&&
							 gcds_banjae.namevalue(j,"TSDAT")==gcds_banjaemst.namevalue(k,"TSDAT")&&
							 gcds_banjae.namevalue(j,"TSNBR")==gcds_banjaemst.namevalue(k,"TSNBR")&&
							 gcds_banjae.namevalue(j,"TSSEQ")==gcds_banjaemst.namevalue(k,"TSSEQ")){

							if(gcds_banjae.namevalue(j,"BJCRAMT")==0){       //반제 대변이 0인경우
								if(gcds_banjae.namevalue(j,"BJDEAMT")==gcds_banjaemst.namevalue(k,"DEAMT")){  
								  //alert("delete_deamt");
									gcds_banjaemst.DeleteRow(k);
								}else{
								  //alert("delete_deamt--");
									gcds_banjaemst.namevalue(k,"DEAMT") -= gcds_banjae.namevalue(j,"BJCRAMT");
								}
							}else if(gcds_banjae.namevalue(j,"BJDEAMT")==0){ //반제 차변이 0인경우
								if(gcds_banjae.namevalue(j,"BJCRAMT")==gcds_banjaemst.namevalue(k,"CRAMT")){  
								  //alert("delete_cramt");
									gcds_banjaemst.DeleteRow(k);
								}else{
								 //  alert("delete_cramt--");
									gcds_banjaemst.namevalue(k,"CRAMT") -= gcds_banjae.namevalue(j,"BJDEAMT");
								}
							}
						}//if
				}//if
			}//for k
		}//for j

    ////반제데이타셋 삭제
		var dblcnt = gcds_banjae.countrow;
		for(j=dblcnt;j>=1;j--){
			if(gcds_banjae.namevalue(j,"SEQ")==gcds_dtl.namevalue(gcds_dtl.rowposition,"SEQ")){
				 gcds_banjae.DeleteRow(j);
			}
		}
  }else{//건별
	  if(gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")==0){
			dbl_janamt_back = gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT");
	  }else if(gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")==0){
			dbl_janamt_back = gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT");
		}

		//원전표 잔액 복구
		for(k=1;k<=gcds_data01.countrow;k++){
		  /*  
        alert("FDCODE"+gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")+"::gcds_data01::"+gcds_data01.namevalue(k,"FDCODE"));
				alert("TSDAT"+gcds_dtl.namevalue(gcds_dtl.rowposition,"TSDAT")+"::FSDAT::"+gcds_data01.namevalue(k,"FSDAT"));
				alert("TSNBR"+gcds_dtl.namevalue(gcds_dtl.rowposition,"TSNBR")+"::FSNBR::"+gcds_data01.namevalue(k,"FSNBR"));
				alert("TSSEQ"+gcds_dtl.namevalue(gcds_dtl.rowposition,"TSSEQ")+"::FSSEQ::"+gcds_data01.namevalue(k,"FSSEQ"));
       */ 
				
			if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")==gcds_data01.namevalue(k,"FDCODE")&&
				 gcds_dtl.namevalue(gcds_dtl.rowposition,"TSDAT")==gcds_data01.namevalue(k,"FSDAT")&&
				 gcds_dtl.namevalue(gcds_dtl.rowposition,"TSNBR")==gcds_data01.namevalue(k,"FSNBR")&&
				 gcds_dtl.namevalue(gcds_dtl.rowposition,"TSSEQ")==gcds_data01.namevalue(k,"FSSEQ")){

				 //alert("K::"+ k+"::gcds_dtl.rowposition::"+gcds_dtl.rowposition);
				 //alert("dbl_janamt_back::"+dbl_janamt_back);
        
				 gcds_data01.namevalue(k,"JANAMT")+=dbl_janamt_back;
				 gcds_data01.namevalue(k,"CHK")="F";
			}
    }

    //반제데이타셋 삭제
		for(j=1;j<=gcds_banjae.countrow;j++){
			if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")==gcds_banjae.namevalue(j,"FDCODE")&&
				 gcds_dtl.namevalue(gcds_dtl.rowposition,"TSDAT")==gcds_banjae.namevalue(j,"TSDAT")&&
				 gcds_dtl.namevalue(gcds_dtl.rowposition,"TSNBR")==gcds_banjae.namevalue(j,"TSNBR")&&
				 gcds_dtl.namevalue(gcds_dtl.rowposition,"TSSEQ")==gcds_banjae.namevalue(j,"TSSEQ")){
         gcds_banjae.DeleteRow(j);
			}
		}

    //반제MST 데이타셋 삭제
		for(j=1;j<=gcds_banjaemst.countrow;j++){
			if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")==gcds_banjaemst.namevalue(j,"FDCODE")&&
				 gcds_dtl.namevalue(gcds_dtl.rowposition,"TSDAT")==gcds_banjaemst.namevalue(j,"TSDAT")&&
				 gcds_dtl.namevalue(gcds_dtl.rowposition,"TSNBR")==gcds_banjaemst.namevalue(j,"TSNBR")&&
				 gcds_dtl.namevalue(gcds_dtl.rowposition,"TSSEQ")==gcds_banjaemst.namevalue(j,"TSSEQ")){
				 
				 //alert("banjaemst j:"+j);
				 //alert("CHAAMT"+gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT"));
				 //alert("DAEAMT"+gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT"));
				 if(gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")==0){       //대변이 0인경우
						if(gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")==gcds_banjaemst.namevalue(j,"DEAMT")){  
							gcds_banjaemst.DeleteRow(j);
						}else{
							gcds_banjaemst.namevalue(j,"DEAMT") -= gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT");
						}
				 }else if(gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")==0){ //차변이 0인경우
            //alert("CHAAMT==0");
            //alert("DAEAMT"+gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT"));
						//alert("CRAMT::"+gcds_banjaemst.namevalue(j,"CRAMT"));
						if(gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")==gcds_banjaemst.namevalue(j,"CRAMT")){
							gcds_banjaemst.DeleteRow(j);
						}else{
							gcds_banjaemst.namevalue(j,"CRAMT") -= gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT");
						}
			 	 }
			}
		}
	}

	//alert("dbl_janamt_back::" + dbl_janamt_back);
	gcds_dtl.DeleteRow(gcds_dtl.rowposition);
	////^^alert("gcds_banjae.text",gcds_banjae.text);	
}


/******************************************************************************
	Description : 행 추가 
******************************************************************************/
function ln_Row_Add(){
  var tempcnt = 0;
	tempcnt = gcds_dtl.Countrow;
	gcds_dtl.Addrow();	
	ln_Data_Dtl_B('01',tempcnt);
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

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	gcgd_data01.GridToExcel("반제","",2);
}


function ln_Excel2(){
	gcgd_disp02.GridToExcel("반제내역조회","",2);
}


function ln_Excel3(){

}

function ln_Excel4(){
	gcgd_disp04.GridToExcel("반제전표상세","",2);
}

function ln_Excel5(){
	 gcgd_disp05.RunExcelEx('반제현황조회',0, 0);
}

/******************************************************************************
	Description : 반제저장용 데이타 (반제 mst 테이블에 저장함)
******************************************************************************/
/*
function ln_Data_Banjaemst(seq,i,strAtcode, strDeptcd, strVendcd,strFsrefcd, strFsrefval, dblAmt){

	alert("ln_Data_Banjaemst::i"+i+"strAtcode"+strAtcode+"strDeptcd"+strDeptcd+"strVendcd"+strVendcd+"strFsrefcd"+strFsrefcd+"strFsrefval"+strFsrefval+"dblAmt"+dblAmt);

	if(ln_Banjaemst_find()){ //UPDATE
		for(m=1;m<=gcds_banjaemst.countrow;m++){
			if(gcds_banjaemst.namevalue(m,"FDCODE")==gcds_banjae.namevalue(i,"FDCODE")&&
				 gcds_banjaemst.namevalue(m,"TSDAT")==gcds_banjae.namevalue(i,"TSDAT")&&
				 gcds_banjaemst.namevalue(m,"TSNBR")==gcds_banjae.namevalue(i,"TSNBR")&&
				 gcds_banjaemst.namevalue(m,"TSSEQ")==gcds_banjae.namevalue(i,"TSSEQ")){

				 gcds_banjaemst.namevalue(m,"DEAMT")+=gcds_banjae.namevalue(i,"BJDEAMT");
				 gcds_banjaemst.namevalue(m,"CRAMT")+=gcds_banjae.namevalue(i,"BJCRAMT");
			}
		}//for
	}else{ //INSERT
		ln_Data_Banjaemst_Add(seq,i,strAtcode,strDeptcd,strVendcd,strFsrefcd,strFsrefval,dblAmt);
	}
	
}
*/
/******************************************************************************
	Description : 반제mst에 데이타 확인(존재 - update, 미존재 - addrow);
******************************************************************************/
/*
function ln_Banjaemst_find(i){
	for(m=1;m<=gcds_banjaemst.countrow;m++){
		if(gcds_banjaemst.namevalue(m,"FDCODE")==gcds_banjae.namevalue(i,"FDCODE")&&
			 gcds_banjaemst.namevalue(m,"TSDAT")==gcds_banjae.namevalue(i,"TSDAT")&&
			 gcds_banjaemst.namevalue(m,"TSNBR")==gcds_banjae.namevalue(i,"TSNBR")&&
			 gcds_banjaemst.namevalue(m,"TSSEQ")==gcds_banjae.namevalue(i,"TSSEQ")){
			 return true;
		}
	}
	return false;
}
*/
/******************************************************************************
	Description : 반제mst에 data 추가
	Parameter :   seq - 종합의 경우 동일하게 생성된 건에 대한 seq  삭제시 필요함
	              i - 
								strAtcode - 계정코드,  strDeptcd - 부서,  strVendcd - 거래처
								strFsrefcd - 관리항목  strFsrefval - 관리항목값,  strremark - 적요
                dblAmt - 반제 원전표의 최초금액
******************************************************************************/
function ln_Data_Banjaemst_Add(seq,i,dblAmt,dbldeamt,dblcramt,strseq){
  if(gcds_banjaemst.countrow<=0){
		ln_SetDataHeader("04");
	}
	///alert("ln_Data_Banjaemst_Add::::i:"+i+"seq:"+seq+"dblAmt:"+dblAmt+"dbldeamt:"+dbldeamt+"dblcramt:"+dblcramt);
//	alert("ln_Data_Banjaemst_Add::::i:"+i+"seq:"+seq+"strseq"+strseq);
	gcds_banjaemst.addrow();
	//alert("position"+gcds_banjae.rowposition);
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"SEQ") = strseq;
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"FDCODE") = gcds_data01.namevalue(i,"FDCODE");
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"TSDAT")  = gcds_data01.namevalue(i,"FSDAT");
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"TSNBR")  = gcds_data01.namevalue(i,"FSNBR");
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"TSSEQ")  = gcds_data01.namevalue(i,"FSSEQ");   
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"ATCODE") = gcds_data01.namevalue(i,"ATCODE");
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"DEPTCD") = gcds_data01.namevalue(i,"DEPTCD");
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"VENDCD") = gcds_data01.namevalue(i,"VENDCD");
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"FSREFCD")= gcds_data01.namevalue(i,"FSREFCD");
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"FSREFVAL")	= gcds_data01.namevalue(i,"FSREFVAL");
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"DEAMT") = dbldeamt;   
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"CRAMT") = dblcramt;   
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"STATUS")= "";//저장시 금액체크해서 차변대변 같을경우 1-완료 다를경우 0-반제진행중
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"SSDAT") = gcds_data01.namevalue(i,"SSDAT");  
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"SSNBR") = gcds_data01.namevalue(i,"SSNBR");  
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"FSNUM") = gcds_data01.namevalue(i,"FSNUM");  
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"REMARK")= gcds_data01.namevalue(i,"REMARK"); 
	//alert("gcds_banjaemstREMARK::"+gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"REMARK"));
 // alert("gcds_data01REMARK::"+gcds_data01.namevalue(i,"REMARK"));
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"WRDT") = gs_date;
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"WRID") = gs_userid;
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"UPDT") = "";
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"UPID") = "";
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"AMT")=dblAmt;
	
}
/******************************************************************************
	Description : 반제저장용 데이타 (반제 연결테이블에 저장함)
  Parameter   : seq ='' 건별	
	              seq!='' 종합
******************************************************************************/
function ln_Data_Banjaerel(seq){
 // alert("ln_Data_Banjaerel :::: seq::"+seq);
	//alert("ln_Data_Banjaerel::건별")
	
	var strFtstat ="Y";
	var dblSum=0;
	var dblTotal=0;
	var dblTemp=0;
	var dblAmt=0;        //반제 mst에 insert시 원전표의 금액
	var dbldeamt=0;
	var dblcramt=0;
	gs_banjaeyn="0";

  if(!ln_Chk('03')){
		return 
	}
 
	//^^alert("ln_Data_Banjaerel.countrow::"+gcds_banjae.countrow);
	if(gcds_banjae.countrow<=0){
		ln_SetDataHeader("03");
	}
  
  for (i=1;i<=gcds_data01.countrow;i++){
		if(gcds_data01.namevalue(i,"CHK")=="T"&& gcds_data01.namevalue(i,"BANJAEAMT")!=0){ //체크된 항목&&반제금액이 0이 아닌경우
			
			strseq = gcds_dtl.countrow + 1;  
			strseq = ln_Seqno_Format(strseq,5); 
			//alert("22gcds_dtl.countrow"+gcds_dtl.countrow);

			if(seq!=0 && seq!=""){ //종합
			  //alert("종합");
			}else{                 //건별
				//alert("건별");
				ln_Data_Dtl('01',i,strseq);
			}

			//alert(seq+"seq::"+"strseq::::"+strseq);
		  gcds_banjae.addrow();
			//alert("position"+gcds_banjae.rowposition);
			gcds_banjae.namevalue(gcds_banjae.rowposition,"SEQ") = seq;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"FTSTAT") = strFtstat;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"FDCODE") = gcds_data01.namevalue(i,"FDCODE");
			gcds_banjae.namevalue(gcds_banjae.rowposition,"TSDAT")  = gcds_data01.namevalue(i,"FSDAT");
			gcds_banjae.namevalue(gcds_banjae.rowposition,"TSNBR")  = gcds_data01.namevalue(i,"FSNBR");
			gcds_banjae.namevalue(gcds_banjae.rowposition,"TSSEQ")  = gcds_data01.namevalue(i,"FSSEQ");
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BTSDAT") = "A"+gs_date;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BTSNBR") = "";     //저장시 생성
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BTSSEQ") = strseq; //생성
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BANJAEYN") = gs_banjaeyn; //Y - 반제(원전표) 0-반제전표(진행중), 1-반제전표(반제완료), N-반제전표아님.
			
			//신규추가 
			//alert("i::"+i+":FSNUM:"+gcds_data01.namevalue(i,"FSNUM"));
			gcds_banjae.namevalue(gcds_banjae.rowposition,"SSDAT") = gcds_data01.namevalue(i,"SSDAT");
			gcds_banjae.namevalue(gcds_banjae.rowposition,"SSNBR") = gcds_data01.namevalue(i,"SSNBR"); 
			gcds_banjae.namevalue(gcds_banjae.rowposition,"FSNUM") = gcds_data01.namevalue(i,"FSNUM");  

			if(gcds_data01.namevalue(i,"CHAAMT")==0){ 
				gcds_banjae.namevalue(gcds_banjae.rowposition,"BJDEAMT") = gcds_data01.namevalue(i,"BANJAEAMT"); 
				gcds_banjae.namevalue(gcds_banjae.rowposition,"BJCRAMT") = 0;
				dblAmt = gcds_data01.namevalue(i,"DAEAMT");
				dbldeamt=gcds_data01.namevalue(i,"BANJAEAMT");
				dblcramt=0;
			}else if(gcds_data01.namevalue(i,"DAEAMT")==0){
				gcds_banjae.namevalue(gcds_banjae.rowposition,"BJDEAMT") = 0; 
				gcds_banjae.namevalue(gcds_banjae.rowposition,"BJCRAMT") = gcds_data01.namevalue(i,"BANJAEAMT");
				dblAmt = gcds_data01.namevalue(i,"CHAAMT");
				dbldeamt=0;
				dblcramt = gcds_data01.namevalue(i,"BANJAEAMT");
			}else{
				if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")>0){
					gcds_banjae.namevalue(gcds_banjae.rowposition,"BJDEAMT") = 0; 
					gcds_banjae.namevalue(gcds_banjae.rowposition,"BJCRAMT") = gcds_data01.namevalue(i,"BANJAEAMT");
					//dblAmt = gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT");
					dblAmt = gcds_data01.namevalue(i,"CHAAMT");
					dbldeamt=0;
					dblcramt = gcds_data01.namevalue(i,"BANJAEAMT");
				}else if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")<0){
					gcds_banjae.namevalue(gcds_banjae.rowposition,"BJDEAMT") = gcds_data01.namevalue(i,"BANJAEAMT"); 
					gcds_banjae.namevalue(gcds_banjae.rowposition,"BJCRAMT") = 0;
					//dblAmt = gcds_data01.namevalue(i,"DAEAMT")-gcds_data01.namevalue(i,"CHAAMT");
					dblAmt = gcds_data01.namevalue(i,"DAEAMT");
					dbldeamt=gcds_data01.namevalue(i,"BANJAEAMT");
					dblcramt=0;
				}
			}

			gcds_banjae.namevalue(gcds_banjae.rowposition,"BSDAT") = ""; //결재시 생성
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BSNBR") = ""; //결재시 생성 
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BSNUM") = ""; //결재시 생성

			gcds_banjae.namevalue(gcds_banjae.rowposition,"WRDT") = gs_date;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"WRID") = gs_userid;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"UPDT") = gs_date;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"UPID") = gs_userid;

      if(seq!=0 && seq!=""){ //종합
			}else{  //건별
				gcds_data01.namevalue(i,"BANJAEAMT")=0;
			}
			//ln_Data_Banjaemst_Add(seq,i,strAtcode,strDeptcd,strVendcd,strFsrefcd,strFsrefval,dblAmt);
			//alert("DETPCD" +gcds_data01.namevalue(i,"DEPTCD"));
			ln_Data_Banjaemst_Add(seq,i,dblAmt,dbldeamt, dblcramt,strseq);
    }
	}//for
}

/******************************************************************************
	Description : 반제원전표 조회 == > 건별 또는 종합으로 집계
	Parameter   : 01 - 반제 건별
	              02 - 반제 종합
******************************************************************************/
function ln_Data_Banjae(p){
	var row=gcds_data01.countrow;
	var strseq="";	

	if(ln_Chk('02')){ 
		if(p=="01"){                 //건별 
			if(gcds_mst.countrow<=0){
				ln_Data_Mst();           //MST DATA저장
			}
      		ln_Data_Banjaerel('');     //반제연결&&반제MST(반제원장)
		}else if(p=="02"){           //종합
		  //alert("gstrGubun::"+gstrGubun);	
		   if(gstrGubun=="T"||gs_userid=="3170009"){
				if (gcds_mst.countrow<=0){
					ln_Data_Mst();          //MST DATA저장 
				}
			  	strseq = gcds_dtl.countrow + 1;  
				ln_Data_Banjaerel(strseq);  
				strseq = ln_Seqno_Format(strseq,5); 
				ln_Data_Dtl('02','',strseq);     //화면상의 DTL DATA 저장
			}else{
				alert("해당건은 종합으로 반제할 수 없습니다.");
				
			}
		}//if
	}
}

/******************************************************************************
	Description : 전표작성 조회시 Mst Data 저장(전표mst)
  parameter   : 
******************************************************************************/
function ln_Data_Mst(){
  //alert("gcds_mst:"+gcds_mst.countrow);
	if(gcds_mst.countrow<=0){
		ln_SetDataHeader("01");
	}
  gcds_mst.Addrow();
  gcds_mst.namevalue(gcds_mst.rowposition,"FDCODE")=gcds_data01.namevalue(gcds_data01.rowposition,"FDCODE");
	gcds_mst.namevalue(gcds_mst.rowposition,"FSDAT")="A"+gs_date;
	gcds_mst.namevalue(gcds_mst.rowposition,"FSNBR")="";
	gcds_mst.namevalue(gcds_mst.rowposition,"FSKND")=""; //대체전표 수동기표 (6 자동기표 --slipno_popup에서 적용)
	gcds_mst.namevalue(gcds_mst.rowposition,"FSWRTDAT")=gs_date;
	gcds_mst.namevalue(gcds_mst.rowposition,"COCODE")=gs_cocode;
	gcds_mst.namevalue(gcds_mst.rowposition,"DEPTCD")=gs_deptcd;
	gcds_mst.namevalue(gcds_mst.rowposition,"EMPNO")=gs_userid;
	gcds_mst.namevalue(gcds_mst.rowposition,"DIVCD")=""; //부서코드로 본부찾기
	gcds_mst.namevalue(gcds_mst.rowposition,"FSAMT")=0;  //DTL의 금액 SUM
	gcds_mst.namevalue(gcds_mst.rowposition,"FSVAT")=0;
	gcds_mst.namevalue(gcds_mst.rowposition,"DETOT")=0;
	gcds_mst.namevalue(gcds_mst.rowposition,"CRTOT")=0;
	gcds_mst.namevalue(gcds_mst.rowposition,"REMARK")=gcds_data01.namevalue(gcds_data01.rowposition,"REMARK");
	gcds_mst.namevalue(gcds_mst.rowposition,"SGNDAT")="";
	gcds_mst.namevalue(gcds_mst.rowposition,"FSSTAT")="N";
	gcds_mst.namevalue(gcds_mst.rowposition,"SSDAT")="";
	gcds_mst.namevalue(gcds_mst.rowposition,"SSNBR")="";
  gcds_mst.namevalue(gcds_mst.rowposition,"WRDT")=gs_userid;
	gcds_mst.namevalue(gcds_mst.rowposition,"WRID")=gs_date;
	gcds_mst.namevalue(gcds_mst.rowposition,"UPDT")="";
	gcds_mst.namevalue(gcds_mst.rowposition,"UPID")="";
}

/******************************************************************************
	Description : 전표작성 - 화면상 보이는 부분
  parameter   : p1 - 구분 (01-건별, 02-종합)
	              i - row의 위치
******************************************************************************/
function ln_Data_Dtl(p1,i,strseq){
  if(gcds_dtl.countrow<=0){
		ln_SetDataHeader("02");
	}
	//alert("ln_Data_Dtl :: p1"+p1+"i"+i+"strseq"+strseq);
	gcds_dtl.Addrow();
	//공통
	if(p1=="01"){  //건별
	  gcds_dtl.namevalue(gcds_dtl.rowposition,"SEQ")='';  //
    gcds_dtl.namevalue(gcds_dtl.rowposition,"GUBUN")="D";  //DTL 계정
		gcds_dtl.namevalue(gcds_dtl.rowposition,"CHK")="T";
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")=gcds_data01.namevalue(i,"FDCODE");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSDAT")="A"+gs_date;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNBR")="";       //저장시 생성
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")=strseq;   //저장시 생성
		gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")=gcds_data01.namevalue(i,"ATCODE");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"ATKORNAM")=gcds_data01.namevalue(i,"ATKORNAM");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATCODE")="";   //화면에서 입력 (상대계정)
		gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATKORNAM")=""; //화면에서 입력 (상대계정)
		//gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(i,"CHAAMT");
		//gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcds_data01.namevalue(i,"DAEAMT");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"BANJAEYN")="0";
		gcds_dtl.namevalue(gcds_dtl.rowposition,"REMARK")=gcds_data01.namevalue(i,"REMARK");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDCD")=gcds_data01.namevalue(i,"VENDCD");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDNM")=gcds_data01.namevalue(i,"VENDNM");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTCD")=gcds_data01.namevalue(i,"DEPTCD");
    gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTNM")=gcds_data01.namevalue(i,"DEPTNM");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"DIVCD")=gcds_data01.namevalue(i,"DIVCD"); //본부찾기
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")=""; //화면에서 자동생성
		gcds_dtl.namevalue(gcds_dtl.rowposition,"WRDT")=gs_date;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"WRID")=gs_userid;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"UPDT")=gs_date;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"UPID")=gs_userid;

    //삭제시 사용할 HIDDEN
		gcds_dtl.namevalue(gcds_dtl.rowposition,"TSDAT")=gcds_data01.namevalue(i,"FSDAT");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"TSNBR")=gcds_data01.namevalue(i,"FSNBR");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"TSSEQ")=gcds_data01.namevalue(i,"FSSEQ");
		
    ///alert("BANJAEAMT::"+gcds_data01.namevalue(i,"BANJAEAMT"));
		///alert("CHAAMT"+gcds_data01.namevalue(i,"CHAAMT"));
    ///alert("DAEAMT"+gcds_data01.namevalue(i,"DAEAMT"));
		
		if(gcds_data01.namevalue(i,"CHAAMT")==0){
			///alert("1111111BANJAEAMT::"+gcds_data01.namevalue(i,"BANJAEAMT"));
			gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(i,"BANJAEAMT");  //차변과 대변의 금액을 바꿈
			gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=0;
		}else if(gcds_data01.namevalue(i,"DAEAMT")==0){
			gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=0;     //차변과 대변의 금액을 바꿈
			gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcds_data01.namevalue(i,"BANJAEAMT");
			///alert("2222222222BANJAEAMT::"+gcds_data01.namevalue(i,"BANJAEAMT"));
		}else{
		  if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")>0){
					gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=0;  //차변과 대변의 금액을 바꿈
					gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcds_data01.namevalue(i,"BANJAEAMT");
			}else if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")<0){
					gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(i,"BANJAEAMT");  //차변과 대변의 금액을 바꿈
					gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=0;
			}
		}
   
	  ///alert("rowposition::"+gcds_dtl.rowposition);
		///alert("DAEAMT::"+gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT"));
    ///alert("CHAAMT::"+gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT"));


		//관리항목코드 추가(반제세목관련)
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD")=gcds_data01.namevalue(i,"FSREFCD");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL")=gcds_data01.namevalue(i,"FSREFVAL");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM")=gcds_data01.namevalue(i,"FSREFNM");

		//관리항목코드와 연결되는 코드 (예...관리항목코드 : 카드번호 일경우 현대카드||외환카드 같은 코드값을 가져옴.)
		//alert("FSREFCD2"+gcds_data01.namevalue(i,"FSREFCD2"));
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD2")=gcds_data01.namevalue(i,"FSREFCD2");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL2")=gcds_data01.namevalue(i,"FSREFVAL2");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM2")=gcds_data01.namevalue(i,"FSREFNM2");

    //가수금일 경우 가져옴
		if(gcds_data01.namevalue(i,"ATCODE")=="2101300"){
			gcds_dtl.namevalue(gcds_dtl.rowposition,"REFCD2")=gcds_data01.namevalue(i,"REFCD2");
			gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVAL2")=gcds_data01.namevalue(i,"REFVAL2");
			
		}else if(gcds_data01.namevalue(i,"ATCODE")=="2100520"){ //법인카드
			gcds_dtl.namevalue(gcds_dtl.rowposition,"REFCD2")=gcds_data01.namevalue(i,"REFCD2");
			gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVAL2")=gcds_data01.namevalue(i,"REFVAL2");
      		gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVALNM2")=gcds_data01.namevalue(i,"REFVALNM2");
      
		}else if(gcds_data01.namevalue(i,"ATCODE")=="2100120"){ //외상매입금(지급어음)
			gcds_dtl.namevalue(gcds_dtl.rowposition,"REFCD2")=gcds_data01.namevalue(i,"REFCD2");
			gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVAL2")=gcds_data01.namevalue(i,"REFVAL2");
      		gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVALNM2")=gcds_data01.namevalue(i,"REFVALNM2");
      		      
		}else{
      		gcds_dtl.namevalue(gcds_dtl.rowposition,"REFCD2")="";
			gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVAL2")="";
			gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVALNM2")="";
		}


	}else if(p1=="02"){ //종함 - 반제금액 합계를 Sum
		var cnt=0; //체크건수 확인
		for(j=1;j<=gcds_data01.countrow;j++){
			if(gcds_data01.namevalue(j,"CHK")=="T") {  
			  cnt+=1;
				//alert("cnt"+cnt);
				//alert("BANJAEAMT::"+gcds_data01.namevalue(j,"BANJAEAMT"));
				if(gcds_data01.namevalue(j,"CHAAMT")==0){
					gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")+=gcds_data01.namevalue(j,"BANJAEAMT");  //차변과 대변의 금액을 바꿈
					gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")+=gcds_data01.namevalue(j,"CHAAMT");
				}else if(gcds_data01.namevalue(j,"DAEAMT")==0){
					gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")+=gcds_data01.namevalue(j,"DAEAMT");  //차변과 대변의 금액을 바꿈
					gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")+=gcds_data01.namevalue(j,"BANJAEAMT");
				}else{
					if(gcds_data01.namevalue(j,"CHAAMT")-gcds_data01.namevalue(j,"DAEAMT")>0){
							gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=0;  //차변과 대변의 금액을 바꿈
							gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")+=gcds_data01.namevalue(j,"BANJAEAMT");
					}else if(gcds_data01.namevalue(j,"CHAAMT")-gcds_data01.namevalue(j,"DAEAMT")<0){
							gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(j,"BANJAEAMT");  //차변과 대변의 금액을 바꿈
							gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=0;
					}
				}
				
				//if
				gcds_data01.namevalue(j,"BANJAEAMT")=0;

        //여러건 중 첫 번째건을 기준으로 넘김.
				if(cnt==1){
				  gcds_dtl.namevalue(gcds_dtl.rowposition,"SEQ")=gcds_dtl.countrow; 
				  gcds_dtl.namevalue(gcds_dtl.rowposition,"GUBUN")="D";  //DTL 계정
					gcds_dtl.namevalue(gcds_dtl.rowposition,"CHK")="T";
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")=gcds_data01.namevalue(j,"FDCODE");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSDAT")="A"+gs_date;
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNBR")="";  //저장시 생성
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")=strseq; 
					gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")=gcds_data01.namevalue(j,"ATCODE");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"ATKORNAM")=gcds_data01.namevalue(j,"ATKORNAM");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATCODE")="";   //화면에서 입력 (상대계정)
					gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATKORNAM")=""; //화면에서 입력 (상대계정)
					//gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(i,"CHAAMT");
					//gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcds_data01.namevalue(i,"DAEAMT");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"BANJAEYN")="0";
					gcds_dtl.namevalue(gcds_dtl.rowposition,"REMARK")=gcds_data01.namevalue(j,"REMARK");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDCD")=gcds_data01.namevalue(j,"VENDCD");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDNM")=gcds_data01.namevalue(j,"VENDNM");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTCD")=gcds_data01.namevalue(j,"DEPTCD");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTNM")=gcds_data01.namevalue(j,"DEPTNM");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"DIVCD")=gcds_data01.namevalue(j,"DIVCD"); //본부찾기
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")=""; //화면에서 자동생성
					gcds_dtl.namevalue(gcds_dtl.rowposition,"WRDT")=gs_date;
					gcds_dtl.namevalue(gcds_dtl.rowposition,"WRID")=gs_userid;
					gcds_dtl.namevalue(gcds_dtl.rowposition,"UPDT")=gs_date;
					gcds_dtl.namevalue(gcds_dtl.rowposition,"UPID")=gs_userid;

					//관리항목코드 추가(반제세목관련)
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD")=gcds_data01.namevalue(j,"FSREFCD");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL")=gcds_data01.namevalue(j,"FSREFVAL");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM")=gcds_data01.namevalue(j,"FSREFNM");
						
					//관리항목코드와 연결되는 코드 (예...관리항목코드 : 카드번호 일경우 현대카드||외환카드 같은 코드값을 가져옴.)
					//alert("FSREFCD2"+gcds_data01.namevalue(i,"FSREFCD2"));
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD2")=gcds_data01.namevalue(j,"FSREFCD2");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL2")=gcds_data01.namevalue(j,"FSREFVAL2");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM2")=gcds_data01.namevalue(j,"FSREFNM2");

					//가수금//법인카드 일경우 가져옴
					if(gcds_data01.namevalue(j,"ATCODE")=="2101300"){
						gcds_dtl.namevalue(gcds_dtl.rowposition,"REFCD2")=gcds_data01.namevalue(j,"REFCD2");
						gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVAL2")=gcds_data01.namevalue(j,"REFVAL2");
					}else if(gcds_data01.namevalue(j,"ATCODE")=="2100520"){ //법인카드
						gcds_dtl.namevalue(gcds_dtl.rowposition,"REFCD2")=gcds_data01.namevalue(j,"REFCD2");
						gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVAL2")=gcds_data01.namevalue(j,"REFVAL2");
						gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVALNM2")=gcds_data01.namevalue(j,"REFVALNM2");
					}else{
						gcds_dtl.namevalue(gcds_dtl.rowposition,"REFCD2")="";
						gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVAL2")="";
					}
				}	
			}//if
		}//for
	}
}

/******************************************************************************
	Description : 전표작성 - 상대계정부분
  parameter   : p1 - 구분 (01-건별
	              i - Addrow 이전 위치
******************************************************************************/

function ln_Data_Dtl_B(p1,i){
  if(gcds_dtl.countrow<=0){
		ln_SetDataHeader("02");
	}
 
  var strseq = gcds_dtl.countrow;  
			strseq = ln_Seqno_Format(strseq,5); 
  //공통
	if(p1=="01"){
    gcds_dtl.namevalue(gcds_dtl.rowposition,"GUBUN")="B";  //DTL 상대계정
		gcds_dtl.namevalue(gcds_dtl.rowposition,"CHK")="T";
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")=gcds_dtl.namevalue(i,"FDCODE");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSDAT")="A"+gs_date;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNBR")="";  //저장시 생성
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")=strseq;  
		gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")="";
		gcds_dtl.namevalue(gcds_dtl.rowposition,"ATKORNAM")="";
		gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATCODE")="";  //화면에서 입력 (상대계정)
		gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATKORNAM")=""; //화면에서 이별 (상대계정)
		//gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(i,"CHAAMT");
		//gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcds_data01.namevalue(i,"DAEAMT");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"BANJAEYN")="";
		gcds_dtl.namevalue(gcds_dtl.rowposition,"REMARK")=gcds_dtl.namevalue(i,"REMARK");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDCD")=gcds_dtl.namevalue(i,"VENDCD");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDNM")=gcds_dtl.namevalue(i,"VENDNM");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTCD")=gcds_dtl.namevalue(i,"DEPTCD");
    gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTNM")=gcds_dtl.namevalue(i,"DEPTNM");

		gcds_dtl.namevalue(gcds_dtl.rowposition,"DIVCD")=ln_Find_Divcd(gcds_dtl.namevalue(i,"DEPTCD"));//본부찾기
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")=""; //화면에서 자동생성
		gcds_dtl.namevalue(gcds_dtl.rowposition,"WRDT")=gs_date;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"WRID")=gs_userid;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"UPDT")=gs_date;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"UPID")=gs_userid;

    //금액은 입력가능하게 함.
		gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=0;  //차변과 대변의 금액을 바꿈
		gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=0;

		/*
		if(gcds_data01.namevalue(i,"CHAAMT")==0){
			gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(i,"BANJAEAMT");  //차변과 대변의 금액을 바꿈
			gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcds_data01.namevalue(i,"CHAAMT");
		}else if(gcds_data01.namevalue(i,"DAEAMT")==0){
			gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(i,"DAEAMT");    //차변과 대변의 금액을 바꿈
			gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcds_data01.namevalue(i,"BANJAEAMT");
		}
		*/
	}
}

/************************************************************************************************************
	Description : 반제//상계에서 상단 데이타를 가지고 올 때 중복해서 가지고 오는 경우를 체크함.
	parameter   :
*************************************************************************************************************/
function ln_Chk_Temp_Data(){


}

/************************************************************************************************************
	Description : 본부코드 찾기
	parameter   :
*************************************************************************************************************/
function ln_Find_Divcd(strdeptcd){
    
		for(i=1;i<=gcds_divcd.countrow;i++){
			if(strdeptcd==gcds_divcd.namevalue(i,"DEPTCD")){
					return gcds_divcd.namevalue(i,"DIVCD");		
			}
		}
}
/******************************************************************************
	Description : 내역조회- 상단부분
  parameter   :
******************************************************************************/
function ln_Data2(row){
 
	gclx_fdcode02.bindcolval=gcds_data01.namevalue(row,"FDCODE"); 
  gcem_fsdatnbr02.text=gcds_data01.namevalue(row,"SSNBR1");
	gcem_actdat02.text=gcds_data01.namevalue(row,"ACTDAT");
	gclx_fsstat02.bindcolval=gcds_data01.namevalue(row,"FSSTAT");
	txt_atcode02.value=gcds_data01.namevalue(row,"ATCODE");
	gcem_atcodenm02.text=gcds_data01.namevalue(row,"ATKORNAM");
	gcem_chaamt02.text=gcds_data01.namevalue(row,"CHAAMT");
	gcem_daeamt02.text=gcds_data01.namevalue(row,"DAEAMT");
	gcem_janamt02.text=gcds_data01.OrgNameValue(row,"JANAMT");
	txt_remark02.value=gcds_data01.namevalue(row,"REMARK");
  txt_custcd02.value=gcds_data01.namevalue(row,"VENDCD");
  txt_custnm02.value=gcds_data01.namevalue(row,"VENDNM");
	//gcem_chaamt03.text=0;
	//gcem_daeamt03.text=0;
}

/******************************************************************************
	Description : 반제전표상세-상단부분
  parameter   :
******************************************************************************/
function ln_Data4(row){

	gclx_fdcode04.bindcolval=gcds_data03.namevalue(row,"FDCODE"); 
	gcem_bsdatnbr04.text=gcds_data03.namevalue(row,"SSDATNBR"); 
	gcem_btsdatnbr04.text=gcds_data03.namevalue(row,"FSDATNBR"); 
	gclx_fsstat04.bindcolval=gcds_data03.namevalue(row,"FSSTAT");
	txt_remark04.value=gcds_data03.namevalue(row,"REMARK");
	gcem_chaamt04.text=gcds_data03.namevalue(row,"DETOT");
	gcem_daeamt04.text=gcds_data03.namevalue(row,"CRTOT");
 
}

/******************************************************************************
	Description : 저장할 Data를 위한 DataSetHead 설정
  parameter   : p - 01 : 전표 mst 데이타셋
	                - 02 : 화면 display용 데이타셋
									- 03 : 실제 저장할 dtl 데이타셋 (dtl & ref)
									- 04 : 반제mst
******************************************************************************/
function ln_SetDataHeader(p){
	if(p=="01"){
		var s_fslipmst = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSKND:STRING,FSWRTDAT:STRING,"
									 + "COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,DIVCD:STRING,FSAMT:DECIAML,"
									 + "FSVAT:DECIAML,DETOT:DECIAML,CRTOT:DECIAML,REMARK:STRING,"
									 + "SGNDAT:STRING,FSSTAT:STRING,SSDAT:STRING,SSNBR:STRING,"
									 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";
		gcds_mst.SetDataHeader(s_fslipmst);
	}else if(p=="02"){
		var s_temp ="CHK:STRING,FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,"
	             + "ATCODE:STRING,ATKORNAM:STRING,BJATCODE:STRING,BJATKORNAM:STRING,CHAAMT:DECIMAL,"
						   + "DAEAMT:DECIMAL,BANJAEYN:STRING,REMARK:STRING,VENDCD:STRING,VENDNM:STRING,"
						   + "DEPTCD:STRING,DEPTNM:STRING,DIVCD:STRING,FSNUM:STRING,"
						   + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,NUMBER:DECIMAL,GUBUN:STRING,SEQ:DECIMAL,"
						   + "TSDAT:STRING,TSNBR:STRING,TSSEQ:STRING,FSREFCD:STRING,FSREFVAL:STRING,FSREFNM:STRING,"
						   + "FSREFCD2:STRING,FSREFVAL2:STRING,FSREFNM2:STRING,REFCD2:STRING,REFVAL2:STRING,REFVALNM2:STRING,ATDECR:STRING"; 
		gcds_dtl.SetDataHeader(s_temp);
	}else if(p=="03"){
		var s_temp = "FTSTAT:STRING,FDCODE:STRING,TSDAT:STRING,TSNBR:STRING,TSSEQ:STRING,"
		           + "BTSDAT:STRING,BTSNBR:STRING,BTSSEQ:STRING,BANJAEYN:STRING,SSDAT:STRING,"
	             + "SSNBR:STRING,FSNUM:STRING,BJDEAMT:DECIMAL,BJCRAMT:DECIMAL,BSDAT:STRING,"
						   + "BSNBR:STRING,BSNUM:STRING,"
						   + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,SEQ:DECIMAL"; 
		gcds_banjae.SetDataHeader(s_temp);
	}else if(p=="04"){
		var s_temp = "FDCODE:STRING,TSDAT:STRING,TSNBR:STRING,TSSEQ:STRING,ATCODE:STRING,"
		           + "DEPTCD:STRING,VENDCD:STRING,FSREFCD:STRING,FSREFVAL:STRING,DEAMT:DECIMAL,"
	             + "CRAMT:DECIMAL,STATUS:STRING,SSDAT:STRING,SSNBR:STRING,FSNUM:STRING,"
						   + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,SEQ:STRING,AMT:DECIMAL,REMARK:STRING"; 
		gcds_banjaemst.SetDataHeader(s_temp);
  }else if(p=="03"){
		var s_temp = "FTSTAT:STRING,FDCODE:STRING,TSDAT:STRING,TSNBR:STRING,TSSEQ:STRING,"
		         + "BTSDAT:STRING,BTSNBR:STRING,BTSSEQ:STRING,BANJAEYN:STRING,SSDAT:STRING,"
	           + "SSNBR:STRING,FSNUM:STRING,BJDEAMT:DECIMAL,BJCRAMT:DECIMAL,BSDAT:STRING,"
						 + "BSNBR:STRING,BSNUM:STRING,"
						 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,SEQ:DECIMAL"; 
		gcds_check_temp.SetDataHeader(s_temp);

	}else if(p=="DTL_03"){
		if (gcds_del03.countrow<1){ 
			var s_temp = "FDCODE:STRING,BTSDAT:STRING,BTSNBR:STRING,TSDAT:STRING,TSNBR:STRING,TSSEQ";               
			gcds_del03.SetDataHeader(s_temp);
		}
  }
}

/***********************************************************************************************
	Description : 계정코드 및 거래처 찾기
	parameter   : p1 - 구분  p2-구분2, p3 -row obj
**********************************************************************************************/
function ln_Popup(p1,p2,p3,obj){ 
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	if (p1=="01"){//계정과목
		strURL = "./actcode_popup.jsp";
		arrParam[0]="ATUSEYN";
		arrParam[1]=eval(obj).value;
		arrParam[2]="ATDEBTYN";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			//eval(e).value  = arrParam[0];
			//alert("GG::"+arrParam[4]);	
			 if(p2=="fr"){
				txt_atcode_fr.value = arrParam[0];
				txt_atcodenm_fr.value = arrParam[1];

				if(txt_atcode_fr.value=="2101300"){
					txt_label.value="입금일자";
					gcem_date_fr.enable = true;
          gcem_date_to.enable = true;
          gcem_date_fr.text = gcurdate.substring(0,4) + gcurdate.substring(5,7)+"01";
					gcem_date_to.text = gs_date;
				}else{
          txt_label.value="";
					gcem_date_fr.text="";
          gcem_date_to.text=""; 
					gcem_date_fr.enable = false;
          gcem_date_to.enable = false;
				}

				//반제단위가 존재할 경우 거래처를 막고 관리항목 입력,
				if(arrParam[4]!=""){
					txt_custcd_fr.value=""; 
					txt_custnm_fr.value="";	
					gclx_fsrefcd.bindcolval = arrParam[4];
					gclx_fsrefcd.Enable=false;
				}else{
					gclx_fsrefcd.bindcolval = arrParam[4];
					gclx_fsrefcd.Enable=false;
				}
      }else if(p2=="05fr"){
				txt_atcode05_fr.value = arrParam[0];
				txt_atcodenm05_fr.value = arrParam[1];

				//반제단위가 존재할 경우 거래처를 막고 관리항목 입력,
				if(arrParam[4]!=""){
					txt_custcd05_fr.value=""; 
					txt_custnm05_fr.value="";	
					gclx_fsrefcd05.bindcolval = arrParam[4];
					gclx_fsrefcd05.Enable=false;
				}else{
					gclx_fsrefcd05.bindcolval = arrParam[4];
					gclx_fsrefcd05.Enable=false;
				}
			}

		} else {
			if(p2=="fr") {
			  txt_atcode_fr.value="";
				txt_atcodenm_fr.value="";
			  txt_custcd_fr.value=""; 
				txt_custnm_fr.value="";	
				txt_fsrefcd_fr.value = "";
				txt_fsrefnm_fr.value = "";
				txt_fsrefcd_to.value = "";
				txt_fsrefnm_to.value = "";
        gclx_fsrefcd.bindcolval = "";
				gclx_fsrefcd.Enable=false;
			}else if(p2=="05fr") {
			  txt_atcode05_fr.value="";
				txt_atcodenm05_fr.value="";
			  txt_custcd05_fr.value=""; 
				txt_custnm05_fr.value="";	
				txt_fsrefcd05_fr.value = "";
				txt_fsrefnm05_fr.value = "";
				txt_fsrefcd05_to.value = "";
				txt_fsrefnm05_to.value = "";
        gclx_fsrefcd05.bindcolval = "";
				gclx_fsrefcd05.Enable=false;
			}
		}
		
	}else if(p1=="02"){//거래처
    arrParam[0]="";
		arrParam[1]=eval(obj).value;
		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		//ln_Popup('02','fr','','txt_custnm_fr')

		if (arrResult != null) {
				arrParam = arrResult.split(";");
      
			 if(p2=="fr") {    
			    txt_custcd_fr.value = arrParam[0];
					txt_custnm_fr.value = arrParam[1];
			 }else if(p2=="05fr"){
					txt_custcd05_fr.value = arrParam[0];
					txt_custnm05_fr.value = arrParam[1];
			 }
		} else {
			if(p2=="fr") {
			  txt_custcd_fr.value="";
				txt_custnm_fr.value ="";
			}else if(p2=="05fr"){
			  txt_custcd05_fr.value="";
				txt_custnm05_fr.value ="";
			}
		}
		custcd="";

	}else if(p1=="03"){//관리항목
 
		//strURL = "./Commdtil_popup_ifrm.html";
		strURL = "./commdtil_popup_banjae.jsp";
		if(p2=="fr"||p2=="to"){
			arrParam[0]=gclx_fsrefcd.bindcolval;
		}else if(p2=="05fr"||p2=="05to"){
			arrParam[0]=gclx_fsrefcd05.bindcolval;
		}else{
      arrParam[0]="";
		}

		arrParam[1]=eval(obj).value;
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
				arrParam = arrResult.split(";");
			 if(p2=="fr") {
			    txt_fsrefcd_fr.value = arrParam[0];
					txt_fsrefnm_fr.value = arrParam[1];
					txt_fsrefcd_to.value = arrParam[0];
					txt_fsrefnm_to.value = arrParam[1];
			 }else if(p2=="to"){
			    txt_fsrefcd_to.value = arrParam[0];
				 	txt_fsrefnm_to.value = arrParam[1];
			 }else if(p2=="05fr") {
			    txt_fsrefcd05_fr.value = arrParam[0];
					txt_fsrefnm05_fr.value = arrParam[1];
					txt_fsrefcd05_to.value = arrParam[0];
					txt_fsrefnm05_to.value = arrParam[1];
			 }else if(p2=="05to"){
			    txt_fsrefcd05_to.value = arrParam[0];
				 	txt_fsrefnm05_to.value = arrParam[1];
		   }
		} else {
			if(p2=="fr") {
			  txt_fsrefcd_fr.value="";
				txt_fsrefnm_fr.value ="";
				txt_fsrefcd_to.value="";
				txt_fsrefnm_to.value ="";
			}else if(p2=="to"){
			  txt_fsrefcd_to.value="";
				txt_fsrefnm_to.value = "";
			}else if(p2=="05fr") {
			  txt_fsrefcd05_fr.value="";
				txt_fsrefnm05_fr.value ="";
				txt_fsrefcd05_to.value="";
				txt_fsrefnm05_to.value ="";
			}else if(p2=="05to"){
			  txt_fsrefcd05_to.value="";
				txt_fsrefnm05_to.value = "";
			}
		}
		vendcd="";
/*
	}else if(p1=="05"){

		strURL = "./Actcode_popup.html";
		arrParam[0]="ATUSEYN";
		arrParam[1]="";
		arrParam[2]="ATDEBTYN";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			//eval(e).value  = arrParam[0];
			 if(p2=="fr"){
			    txt_atcode05_fr.value = arrParam[0];
					txt_atcodenm05_fr.value = arrParam[1];
		   }
		} else {
			if(p2=="fr") {
			  txt_atcode05_fr.value="";
				txt_atcodenm05_fr.value="";
			}
		}

	}else if(p1=="06"){

		strURL = "./Commdtil_popup_ifrm.html";
		arrParam[0]=gclx_fsrefcd05.bindcolval;
		arrParam[1]="";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
				arrParam = arrResult.split(";");
			 if(p2=="fr") {
			    txt_fsrefcd05_fr.value = arrParam[0];
					txt_fsrefnm05_fr.value = arrParam[1];

					if(txt_fsrefcd05_to.value==""&&txt_fsrefnm05_to.value==""){
						txt_fsrefcd05_to.value = arrParam[0];
						txt_fsrefnm05_to.value = arrParam[1];
					}

			 }else if(p2=="to"){
			    txt_fsrefcd05_to.value = arrParam[0];
					txt_fsrefnm05_to.value = arrParam[1];
			 }
		} else {
			if(p2=="fr") {
			  txt_fsrefcd05_fr.value="";
				txt_fsrefnm05_fr.value ="";
				txt_fsrefcd05_to.value="";
				txt_fsrefnm05_to.value ="";
			}else if(p2=="to"){
			  txt_fsrefcd05_to.value="";
				txt_fsrefnm05_to.value = "";
			}
		}
	*/
	}else if(p1=="gcgd_dtl"){   //반제 상대계정
		strURL = "./actcode_popup.jsp";
		arrParam[0]="ATUSEYN";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			//eval(e).value  = arrParam[0];
				gcds_dtl.namevalue(p3,"ATCODE") = arrParam[0];
				gcds_dtl.namevalue(p3,"ATKORNAM") = arrParam[1];
				gcds_dtl.namevalue(p3,"ATDECR") = arrParam[2];
		}else{
			  gcds_dtl.namevalue(p3,"ATCODE")="";
				gcds_dtl.namevalue(p3,"ATKORNAM")="";
				gcds_dtl.namevalue(p3,"ATDECR") = "";
		}
	}
}


/***********************************************************************************************
	Description :  전표 찾기
	parameter   : strfdcode - 지점코드, strfsdat - 접수일자, strfsnbr - 접수번호
**********************************************************************************************/
function ln_Popup2(strfdcode,strfsdat,strfsnbr){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = strfdcode;//지점코드
	arrParam[1] = strfsdat;//접수일자
	arrParam[2] = strfsnbr;//접수번호

	strURL = "./slipno_popup.jsp";
	strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}


/***********************************************************************************************
	Description : 계정코드 및 거래처 클리어
	parameter   : 
**********************************************************************************************/
function ln_Clear(p1){

	if (p1=="01"){
		txt_custcd_fr.value = "";
		txt_custnm_fr.value = "";
		//txt_custcd_to.value = "";
		//txt_custnm_to.value = "";
		custcd = "";
	}	else if(p1 == "02"){
		txt_fsrefcd_fr.value = "";
		txt_fsrefnm_fr.value = "";
		txt_fsrefcd_to.value = "";
		txt_fsrefnm_to.value = "";
		vendcd = "";
	}	else if(p1 == "06"){
		txt_fsrefcd05_fr.value = "";
		txt_fsrefnm05_fr.value = "";
		txt_fsrefcd05_to.value = "";
		txt_fsrefnm05_to.value = "";
	}
}

/******************************************************************************
	Description : 반제 전표 생성 팝업
	parameter   : p - 01 전표생성
	                  02 전표조회
******************************************************************************/
function ln_Popup_Slip(p,row){

  var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

  if (p=="01"){
		var dblchaamt = 0; 
		var dbldaeamt = 0;

		if(ln_Chk2()){        //금액체크
	 
			//전표MST 데이타 넘기기
			arrParam[0] = "B";   //구분 - 반제화면에서 넘어감.
			arrParam[1] = gcds_mst.namevalue(gcds_mst.rowposition,"FDCODE"); 
			arrParam[2] = gcds_mst.namevalue(gcds_mst.rowposition,"FSDAT"); 
			arrParam[3] = gcds_mst.namevalue(gcds_mst.rowposition,"FSNBR");  
			arrParam[4] = gcds_mst.namevalue(gcds_mst.rowposition,"FSKND");  
			arrParam[5] = gcds_mst.namevalue(gcds_mst.rowposition,"COCODE"); 
			arrParam[6] = gcds_mst.namevalue(gcds_mst.rowposition,"DEPTCD"); 
			arrParam[7] = gcds_mst.namevalue(gcds_mst.rowposition,"EMPNO");  
			arrParam[8] = gcds_mst.namevalue(gcds_mst.rowposition,"DIVCD");  
			arrParam[13] = gs_usernm;  
			arrParam[17] = gs_deptnm;  

		  //prompt('gcds_banjaemst:;',gcds_banjaemst.text);
	
			/*
			for(int j=1;j<=gcds_dtl.countrow;j++){
				dblchaamt+=gcds_dtl.namevalue(j,"CHAAMT");
				dbldaeamt+=gcds_dtl.namevalue(j,"DAEAMT");
			}*/

			strURL = "./slipno_popup.jsp";
			strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,window,strPos);

			gcte_disp.ActiveIndex=1;
			ln_Query();
			//dtl, 반제원장, 반제연결 Clear
			gcds_dtl.ClearData();
			gcds_banjae.ClearData();
			gcds_banjaemst.ClearData();

    }
	}else if(p=="02"){
		arrParam[0] = gcds_banjae.namevalue(row,"FDCODE");
		arrParam[1] = gcds_banjae.namevalue(row,"BTSDAT");
		arrParam[2] = gcds_banjae.namevalue(row,"BTSNBR");

		strURL = "./slipno_popup.jsp";
		strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);
	}
}

/******************************************************************************
	Description : 탭구분
	prameter    : 
******************************************************************************/
function ln_DispChk(index){
	
  var div_cm = new Array("div_disp1","div_disp2","div_disp3","div_disp4","div_disp5");
	for(var i=0;i<=4;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}

}

/******************************************************************************
	Description : 전표발행시 금액체크
	prameter    : 
******************************************************************************/
function ln_Chk2(){

    if(gcds_dtl.countrow<=0){
			alert("전표발행 데이타가 없습니다. 확인 하십시요.");
			return false;
		}
    
		/****
		//2008.06.19 정영식 수정 
    if(gcds_dtl.sum(10,0,gcds_dtl.countrow)==0||gcds_dtl.sum(11,0,gcds_dtl.countrow)==0){
			alert("차변과 대변의 금액을 확인 하십시요.");
			return false;
		}
		****/

	  if(gcds_dtl.sum(10,0,gcds_dtl.countrow)!=gcds_dtl.sum(11,0,gcds_dtl.countrow)){
			alert("차변과 대변의 금액이 다릅니다.");
			return false;
		}
    
		return true;
}

/******************************************************************************
	Description : lost focus 시 
	prameter    : p1 - 01 전표작성
	                   02 내역조회
								p2 - atcode:계정
								obj
******************************************************************************/
function ln_Blur(p1,p2,obj){
	if(p1=="01"){
		if(p2=="atcode"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 또는 Enter 
			 if (obj=="txt_atcodenm_fr"||obj=="txt_atcodecd_fr"){
					ln_Popup('01','fr','',obj);
			 }else{
					ln_Popup('01','05fr','',obj);
			 }
		}else if(p2=="cust"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 또는 Enter 
			 if (obj=="txt_custnm05_fr"||obj=="txt_custcd05_fr"){
					ln_Popup('02','05fr','',obj);			
			 }else{
					ln_Popup('02','fr','',obj);			
		   }
		}else if(p2=="fsref_fr"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 또는 Enter 
			 ln_Popup('03','fr','',obj);
		}else if(p2=="fsref_to"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 또는 Enter 
			 ln_Popup('03','to','',obj);
	  }else if(p2=="fsref05_fr"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 또는 Enter 
			 ln_Popup('03','05fr','',obj);
		}else if(p2=="fsref05_to"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 또는 Enter 
			 ln_Popup('03','05to','',obj);
		}
	}
}

function ln_Numeric(){
  txt_banjaesum.value=fn_trim(txt_banjaesum.value);
	txt_banjaesum.value=gf_setnum(txt_banjaesum.value);
}


/******************************************************************************
	Description : 상계처리
	prameter    :
******************************************************************************/
function ln_Setoff(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

  if(!ln_Setoff_Chk()) return;

	strURL = "./comm_setoff_popup.jsp";
	strPos = "dialogWidth:730px;dialogHeight:400px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,window,strPos);	

	if(arrResult != null){
	  arrParam = arrResult.split(";");	

    if(arrParam[0]=="02"){ //종합
      gstrGubun="T";
		}else{
			gstrGubun="";
		}

		ln_Data_Banjae(arrParam[0]);       //기존
		
		ln_Data_Setoff_Add(arrParam,arrParam[0]);   //상계(상대계정)

		////prompt("gcds_data01:",gcds_data01.text);
		////prompt("gcds_dtl:",gcds_dtl.text);
		///prompt("gcds_banjae:",gcds_banjae.text);    //banjaerel
		///prompt("gcds_banjaemst:",gcds_banjaemst.text);
	}
  gstrGubun="";
}

/******************************************************************************
	Description : 상계데이타 추가
	prameter    : strArray  ==> 상계 데이타 배열
	참       고 :  
******************************************************************************/
function ln_Data_Setoff_Add(strArray,p1){
  var cnt=0;
	var seq=0;
	var strseq=0;

  ///alert("ln_Data_Setoff_Add::strArray::"+strArray+"::p1::"+p1);

	if(gcds_mst.countrow<=0){
		ln_Data_Mst();                //MST DATA저장
	}

  seq = gcds_dtl.countrow + 1;  
	cnt = (strArray.length-1)/32

  ///alert("ln_Data_Banjaerel_Setoff");
	ln_Data_Banjaerel_Setoff(seq,strArray,cnt);       //상계데이타를 반제연결에 넣음
	///alert("step3");
	strseq = gcds_dtl.countrow + 1; 
	strseq = ln_Seqno_Format(strseq,5); 

	//alert("step::::");
  ln_Data_Dtl_Setoff(p1,strArray,strseq,seq);	      //상계데이타를 Dtl에 넣음.
	
  
  //prompt("gcds_data01",gcds_data01.text);
	//prompt("gcds_banjaerel",gcds_banjae.text);
	//prompt("gcds_banjaemst",gcds_banjaemst.text);
	//prompt("gcds_dtl",gcds_dtl.text);
}

/******************************************************************************
	Description : 상계처리 체크
	prameter    :
	참       고 : 특정계정만 거래처 체크함. 
******************************************************************************/
function ln_Setoff_Chk(){
	var strTemp="";
	var cnt =0;

  if(fn_trim(txt_atcode_fr.value)==""){
		alert("계정과목은 필수항목입니다.");
		return false;
	}

  if(txt_atcode_fr.value!="1110310"&&txt_atcode_fr.value!="1110610"&&txt_atcode_fr.value!="2100110"&&txt_atcode_fr.value!="2100510"){
		alert("상계 가능한 계정이 아닙니다.");
    return false;
	}

	//외상매출금 || 미수금 || 외상매입금 || 미지급금  
	if(txt_atcode_fr.value=="1110310"||txt_atcode_fr.value=="1110610"||txt_atcode_fr.value=="2100110"||txt_atcode_fr.value=="2100510"){
		if(fn_trim(txt_custcd_fr.value)==""){
			alert("거래처는 필수항목입니다.");
			return false;
		}
	}
	
	/*
	for(var i=1;i<=gcds_data01.countrow;i++){
		if(gcds_data01.namevalue(i,"CHK")=="T"){
			break;
		}else{
		  alert("데이타를 선택 하십시요.");
			return false;
		}
	}
  */
  
	for(var i=1;i<=gcds_data01.countrow;i++){
		if(gcds_data01.namevalue(i,"CHK")=="T"){
			strTemp="T"; //체크된건이 존재할경우
			break;
		}
	}

	if(strTemp!="T") {
		alert("데이타를 선택 하십시요.");
		return false;
	}

  
	//선택한 건이 2건 이상인 경우 상계못함.
  for(var i=1;i<=gcds_data01.countrow;i++){
		if(gcds_data01.namevalue(i,"CHK")=="T"){
			cnt+=1;
		}
	}

	if(cnt>1){
		alert("상계는 1건만 가능합니다. 확인 하십시요.");
		cnt=0;
		return false;
	}


	//반제금액이 0 인 경우가 존재할 경우 체크함
  for(var i=1;i<=gcds_data01.countrow;i++){
		if(gcds_data01.namevalue(i,"CHK")=="T"&&gcds_data01.namevalue(i,"BANJAEAMT")==0){
			alert("대상 금액이 0 입니다.");
			return false;
		}
	}

	return true;
}

/******************************************************************************
	Description : 상계데이타의 반제저장용 데이타 (반제 연결테이블에 저장함)
  Parameter   : seq ='' 건별	
	              seq!='' 종합
								strArray 데이타
								cnt = 레코드 갯수
								
******************************************************************************/
function ln_Data_Banjaerel_Setoff(seq,strArray,cnt){

	//alert("ln_Data_Banjaerel_Setoff::seq::"+seq+"::strArray::"+strArray+"::cnt::"+cnt)
	//prompt('strArray',strArray);

	var strFtstat ="Y";
	var dblTemp=0;
	var dblAmt=0;        //반제 mst에 insert시 원전표의 금액
	var dbldeamt=0;
	var dblcramt=0;
	var s=0; //배열 누적
	var dbldeamt_Sum=0;  //차변누적금액
  var dblcramt_Sum=0;  //대변누적금액

	gs_banjaeyn="0";

	if(gcds_banjae.countrow<=0){
		ln_SetDataHeader("03");
	}
  
  for(i=0;i<cnt;i++){
			strseq = gcds_dtl.countrow + 1;  
			strseq = ln_Seqno_Format(strseq,5); 
	
		  gcds_banjae.addrow();
			//alert("position"+gcds_banjae.rowposition);
			gcds_banjae.namevalue(gcds_banjae.rowposition,"SEQ") = seq;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"FTSTAT") = strFtstat;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"FDCODE") = strArray[3+s];
			gcds_banjae.namevalue(gcds_banjae.rowposition,"TSDAT")  = strArray[4+s];
			gcds_banjae.namevalue(gcds_banjae.rowposition,"TSNBR")  = strArray[5+s];
			gcds_banjae.namevalue(gcds_banjae.rowposition,"TSSEQ")  = strArray[6+s];
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BTSDAT") = "A"+gs_date;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BTSNBR") = "";     //저장시 생성
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BTSSEQ") = strseq; //생성
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BANJAEYN") = gs_banjaeyn; //Y - 반제(원전표) 0-반제전표(진행중), 1-반제전표(반제완료), N-반제전표아님.
			
			//신규추가 
			//alert("i::"+s+":FSNUM:"+gcds_data01.namevalue(s,"FSNUM"));
			gcds_banjae.namevalue(gcds_banjae.rowposition,"SSDAT") = strArray[9+s];
			gcds_banjae.namevalue(gcds_banjae.rowposition,"SSNBR") = strArray[10+s];
			gcds_banjae.namevalue(gcds_banjae.rowposition,"FSNUM") = strArray[11+s];

			if(strArray[13+s]==0){ //차변=0
			  if(Number(strArray[31+s])>=Number(strArray[15+s])){ //strArray[15] 잔액
					dblTemp = strArray[15+s];
				}else if(Number(strArray[31+s])<Number(strArray[15+s])){
          dblTemp = strArray[31+s];
				}
        
				dbldeamt_Sum = Number(dbldeamt_Sum)+Number(dblTemp);
        if(Number(dbldeamt_Sum)-Number(strArray[31+s])>0){
					dblTemp = Number(strArray[31+s])-Number(dbldeamt_Sum)+Number(dblTemp);
				}

				gcds_banjae.namevalue(gcds_banjae.rowposition,"BJDEAMT") = dblTemp;
				gcds_banjae.namevalue(gcds_banjae.rowposition,"BJCRAMT") = 0;

				dblAmt = strArray[14+s];
				dbldeamt=dblTemp;
				dblcramt=0;
			}else if(strArray[14+s]==0){ //대변=0
			  if(Number(strArray[31+s])>=Number(strArray[15+s])){
					dblTemp = strArray[15+s];
				}else if(Number(strArray[31+s])<Number(strArray[15+s])){
          dblTemp = strArray[31+s];
				}

				dbldeamt_Sum = Number(dbldeamt_Sum)+Number(dblTemp);
        if(Number(dbldeamt_Sum)-Number(strArray[31+s])>0){
					dblTemp = Number(strArray[31+s])-Number(dbldeamt_Sum)+Number(dblTemp);
				}
				///alert("대변dblTemp"+dblTemp);
        dblcramt_Sum += dblTemp;
				gcds_banjae.namevalue(gcds_banjae.rowposition,"BJDEAMT") = 0; 
				gcds_banjae.namevalue(gcds_banjae.rowposition,"BJCRAMT") = dblTemp;
				
				dblAmt = strArray[13+s];
				dbldeamt=0;
				dblcramt = dblTemp;
			}else{
				if(Number(strArray[13+s])-Number(strArray[14+s])>0){  //차변
					if(Number(strArray[31+s])>=Number(strArray[15+s])){ //strArray[15] 잔액
						dblTemp = strArray[15+s];
					}else if(Number(strArray[31+s])<Number(strArray[15+s])){
						dblTemp = strArray[31+s];
					}

					dbldeamt_Sum = Number(dbldeamt_Sum)+Number(dblTemp);
					if(Number(dbldeamt_Sum)-Number(strArray[31+s])>0){
						dblTemp = Number(strArray[31+s])-Number(dbldeamt_Sum)+Number(dblTemp);
					}

					///alert("22차변dblTemp"+dblTemp);
					Number(dbldeamt_Sum) += Number(dblTemp);
					gcds_banjae.namevalue(gcds_banjae.rowposition,"BJDEAMT") = 0;
					gcds_banjae.namevalue(gcds_banjae.rowposition,"BJCRAMT") = dblTemp;
          
					dblAmt = strArray[13+s];
					dbldeamt=0;
					dblcramt = dblTemp;

				}else if(Number(strArray[13+s])-Number(strArray[14+s])<0){ //대변
					if(Number(strArray[31+s])>=Number(strArray[15+s])){
						dblTemp = strArray[15+s];
					}else if(Number(strArray[31+s])<Number(strArray[15+s])){
						dblTemp = strArray[31+s];
					}

				  dbldeamt_Sum = Number(dbldeamt_Sum)+Number(dblTemp);
					if(Number(dbldeamt_Sum)-Number(strArray[31+s])>0){
						dblTemp = Number(strArray[31+s])-Number(dbldeamt_Sum)+Number(dblTemp);
					}
					////alert("22대변dblTemp"+dblTemp);
					
					gcds_banjae.namevalue(gcds_banjae.rowposition,"BJDEAMT") = dblTemp; 
					gcds_banjae.namevalue(gcds_banjae.rowposition,"BJCRAMT") = 0;
					
					dblAmt = strArray[14+s];
					dbldeamt=dblTemp;
					dblcramt=0;
					
				}
			}

			gcds_banjae.namevalue(gcds_banjae.rowposition,"BSDAT") = ""; //결재시 생성
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BSNBR") = ""; //결재시 생성 
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BSNUM") = ""; //결재시 생성

			gcds_banjae.namevalue(gcds_banjae.rowposition,"WRDT") = gs_date;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"WRID") = gs_userid;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"UPDT") = gs_date;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"UPID") = gs_userid;

			ln_Data_Banjaemst_Add_Setoff(seq,i,dblAmt,dbldeamt, dblcramt,strArray,strseq);

			s+=32; //배열 누적
	}//for i
}

/******************************************************************************
	Description : 반제mst에 data 추가
	Parameter :   seq - 종합의 경우 동일하게 생성된 건에 대한 seq  삭제시 필요함
	              i - 
								strAtcode -  계정코드,  strDeptcd - 부서,          strVendcd - 거래처
								strFsrefcd - 관리항목   strFsrefval - 관리항목값,  strremark - 적요
                dblAmt - 반제 원전표의 최초금액
								strseq - BTSSEQ 추가함
******************************************************************************/
function ln_Data_Banjaemst_Add_Setoff(seq,i,dblAmt,dbldeamt,dblcramt,strArray,strseq){
	//alert("ln_Data_Banjaemst_Add_Setoff::"+i);
  if(gcds_banjaemst.countrow<=0){
		ln_SetDataHeader("04");
	}
	
	//alert("dblAmt:"+dblAmt+"dbldeamt:"+dbldeamt+"dblcramt:"+dblcramt);
	gcds_banjaemst.addrow();

	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"SEQ") = strseq;
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"FDCODE") = strArray[3];
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"TSDAT")  = strArray[4];
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"TSNBR")  = strArray[5];
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"TSSEQ")  = strArray[6];   
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"ATCODE") = strArray[7];
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"DEPTCD") = strArray[16];
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"VENDCD") = strArray[18];
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"FSREFCD")= strArray[20];
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"FSREFVAL")	= strArray[21];
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"DEAMT") = dbldeamt;   
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"CRAMT") = dblcramt;   
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"STATUS")= "";//저장시 금액체크해서 차변대변 같을경우 1-완료 다를경우 0-반제진행중
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"SSDAT") = strArray[9];  
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"SSNBR") = strArray[10];  
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"FSNUM") = strArray[11];  
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"REMARK")= strArray[12]; 
	//alert("gcds_banjaemstREMARK::"+gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"REMARK"));
 // alert("gcds_data01REMARK::"+gcds_data01.namevalue(i,"REMARK"));
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"WRDT") = gs_date;
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"WRID") = gs_userid;
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"UPDT") = "";
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"UPID") = "";
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"AMT")=dblAmt;
}


/******************************************************************************
	Description : 상계처리부분
  parameter   : p1 - 구분 (01-건별, 02-종합)
	              strArray - 배열값
								strseq 
******************************************************************************/
function ln_Data_Dtl_Setoff(p1,strArray,strseq,seq){
  //alert("ln_Data_Dtl_Setoff::::"+p1);

	///prompt("Array",strArray);

  if(gcds_dtl.countrow<=0){
		ln_SetDataHeader("02");
	}

	gcds_dtl.Addrow();
	//공통
	if(p1=="01"){  //건별
	  //^^alert("gcds_dtl.rowposition::"+gcds_dtl.rowposition);
	  gcds_dtl.namevalue(gcds_dtl.rowposition,"SEQ")=seq;  //
    gcds_dtl.namevalue(gcds_dtl.rowposition,"GUBUN")="D";  //DTL 계정
		gcds_dtl.namevalue(gcds_dtl.rowposition,"CHK")="T";
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")=strArray[3];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSDAT")="A"+gs_date;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNBR")="";       //저장시 생성
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")=strseq;   //저장시 생성
		gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")=strArray[7];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"ATKORNAM")=strArray[8];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATCODE")="";   //화면에서 입력 (상대계정)
		gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATKORNAM")=""; //화면에서 입력 (상대계정)
		//gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(i,"CHAAMT");
		//gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcds_data01.namevalue(i,"DAEAMT");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"BANJAEYN")="0";
		gcds_dtl.namevalue(gcds_dtl.rowposition,"REMARK")=strArray[12];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDCD")=strArray[18];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDNM")=strArray[19];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTCD")=strArray[16];
        gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTNM")=strArray[17];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"DIVCD")=strArray[24]; //본부찾기
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")="";           //화면에서 자동생성
		gcds_dtl.namevalue(gcds_dtl.rowposition,"WRDT")=gs_date;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"WRID")=gs_userid;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"UPDT")=gs_date;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"UPID")=gs_userid;

    //삭제시 사용할 HIDDEN
		gcds_dtl.namevalue(gcds_dtl.rowposition,"TSDAT")=strArray[4];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"TSNBR")=strArray[5];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"TSSEQ")=strArray[6];

		///alert("strArray[13]"+strArray[13]);
		///alert("strArray[14]"+strArray[14]);
		///alert("strArray[31]"+strArray[31]);
		
		if(strArray[13]==0){ //차변
			gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=strArray[31];   //차변과 대변 위치변경
			gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=0;
		}else if(strArray[14]==0){ //대변
		  gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=0;  
			gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=strArray[31];
		}else{
			if(Number(strArray[13])-Number(strArray[14])>0){
				gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=0;  
			  gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=strArray[31];
			}else if(Number(strArray[13])-Number(strArray[14])<0){
				gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=strArray[31];   //차변과 대변 위치변경
			  gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=0;
			}
		}

		//관리항목코드 추가(반제세목관련)
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD")=strArray[20];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL")=strArray[21];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM")=strArray[22];

		//관리항목코드와 연결되는 코드 (예...관리항목코드 : 카드번호 일경우 현대카드||외환카드 같은 코드값을 가져옴.)
		//alert("FSREFCD2"+gcds_data01.namevalue(i,"FSREFCD2"));
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD2")=strArray[28];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL2")=strArray[29];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM2")=strArray[30];

	}else if(p1=="02"){ //종함 - 반제금액 합계를 Sum
		var cnt =(strArray.length-1)/32;
		var m=0;
		var tempAmt=0;
		var tempAmtSum=0;

		for(j=1;j<=cnt;j++){
		  
			//여러건 중 첫 번째건을 기준으로 넘김.
      if(j==1){ 
				if(Number(strArray[13])==0){       //차변
					gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=Number(strArray[31]);   //차변과 대변 위치변경
					gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=0;
				}else if(Number(strArray[14])==0){ //대변
					gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=0;   //차변과 대변 위치변경
					gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=Number(strArray[31]);
				}else{ //차변 대변 둘다 0이 아닌경우
					if(Number(strArray[13])>Number(strArray[14])){
						gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=0;          //차변과 대변 위치변경
						gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=Number(strArray[31]);
					}else{
						gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=Number(strArray[31]);   //차변과 대변 위치변경
						gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=0;
					}
				}

				//^^alert("gcds_dtl.rowposition::"+gcds_dtl.rowposition);
				gcds_dtl.namevalue(gcds_dtl.rowposition,"SEQ")=seq;  //
				gcds_dtl.namevalue(gcds_dtl.rowposition,"GUBUN")="D";  //DTL 계정
				gcds_dtl.namevalue(gcds_dtl.rowposition,"CHK")="T";
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")=strArray[3];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSDAT")="A"+gs_date;
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNBR")="";       //저장시 생성
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")=strseq;   //저장시 생성
				gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")=strArray[7];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"ATKORNAM")=strArray[8];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATCODE")="";   //화면에서 입력 (상대계정)
				gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATKORNAM")=""; //화면에서 입력 (상대계정)
				//gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(i,"CHAAMT");
				//gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcds_data01.namevalue(i,"DAEAMT");
				gcds_dtl.namevalue(gcds_dtl.rowposition,"BANJAEYN")="0";
				gcds_dtl.namevalue(gcds_dtl.rowposition,"REMARK")=strArray[12];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDCD")=strArray[18];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDNM")=strArray[19];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTCD")=strArray[16];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTNM")=strArray[17];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"DIVCD")=strArray[24]; //본부찾기
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")="";           //화면에서 자동생성
				gcds_dtl.namevalue(gcds_dtl.rowposition,"WRDT")=gs_date;
				gcds_dtl.namevalue(gcds_dtl.rowposition,"WRID")=gs_userid;
				gcds_dtl.namevalue(gcds_dtl.rowposition,"UPDT")=gs_date;
				gcds_dtl.namevalue(gcds_dtl.rowposition,"UPID")=gs_userid;

				//삭제시 사용할 HIDDEN
				gcds_dtl.namevalue(gcds_dtl.rowposition,"TSDAT")=strArray[4];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"TSNBR")=strArray[5];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"TSSEQ")=strArray[6];
				

				//관리항목코드 추가(반제세목관련)
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD")=strArray[20];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL")=strArray[21];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM")=strArray[22];

				//관리항목코드와 연결되는 코드 (예...관리항목코드 : 카드번호 일경우 현대카드||외환카드 같은 코드값을 가져옴.)
				//alert("FSREFCD2"+gcds_data01.namevalue(i,"FSREFCD2"));
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD2")=strArray[28];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL2")=strArray[29];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM2")=strArray[30];
			}
		}//for
	}
}

/******************************************************************************
	Description : 비용수익체크 - 비용계정과 수익계정 입력시 차대 체크
	parameter   : 2008.06.19 정영식 추가 
******************************************************************************/
function ln_Chk_Atcode_Amt(row){

	 var temp = gcds_dtl.namevalue(row,"ATCODE");
	 var str1char = temp.substring(0,1);

	 if(str1char=="4"){ //비용 수익계정
			if(gcds_dtl.namevalue(row,"ATDECR")=="1"){ //차변
				if(gcds_dtl.namevalue(row,"DAEAMT")!=0&&gcds_dtl.namevalue(row,"DAEAMT")!=""){
					alert("해당계정은 대변에 입력할 수 없습니다.");
					gcds_dtl.namevalue(row,"DAEAMT")=0;
					//gcds_dtl.namevalue(row,"CHAAMT").focus();
					return;
				}
			}else if(gcds_dtl.namevalue(row,"ATDECR")=="2"){//대변
				if(gcds_dtl.namevalue(row,"CHAAMT")!=0&&gcds_dtl.namevalue(row,"CHAAMT")!=""){
					alert("해당계정은 차변에 입력할 수 없습니다.");
					gcds_dtl.namevalue(row,"CHAAMT")=0;
					//gcds_dtl.namevalue(row,"DAEAMT").focus();
					return;
				}
			}
	 }

	if((gcds_dtl.namevalue(row,"CHAAMT")!=0)&&(gcds_dtl.namevalue(row,"DAEAMT")!=0)){
			alert("차변금액과 대변금액을 확인 하십시요");
			gcds_dtl.namevalue(row,"DAEAMT")=0;
			return;
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- 전표작성 -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 전표mst -->
<comment id="__NSID__"><object  id=gcds_mst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 화면상 dtl-->
<comment id="__NSID__"><object  id=gcds_dtl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 반제연결-->
<comment id="__NSID__"><object  id=gcds_banjae classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 반제mst-->
<comment id="__NSID__"><object  id=gcds_banjaemst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 내역조회 -->
<comment id="__NSID__"><object  id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 반제전표조회 -->
<comment id="__NSID__"><object  id=gcds_data03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 반제전표상세 -->
<comment id="__NSID__"><object  id=gcds_data04 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 반제전표상세- 원전표조회 -->
<comment id="__NSID__"><object  id=gcds_data04_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data05 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data05_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 본부찾기 -->
<comment id="__NSID__"><object  id=gcds_divcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 반제연결테이블건수 -->
<comment id="__NSID__"><object  id=gcds_data15 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_comfield classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> <!--지점구분-->

<comment id="__NSID__"><object  id=gcds_comfield02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!--지점구분-->

<comment id="__NSID__"><object  id=gcds_comfield03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!--지점구분-->

<comment id="__NSID__"><object  id=gcds_comfield04 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!--지점구분-->

<comment id="__NSID__"><object  id=gcds_comfield05 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!--지점구분-->

<comment id="__NSID__"><object  id=gcds_fsrefcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME=SortExpr	value="+CDNAM">
</object></comment><script>__ws__(__NSID__);</script> <!--관리항목-->

<comment id="__NSID__"><object  id=gcds_fsrefcd05 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME=SortExpr	value="+CDNAM">
</object></comment><script>__ws__(__NSID__);</script> <!--관리항목-->

<comment id="__NSID__"><object  id=gcds_fsrefval classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!--전표작성 룩업-->

<comment id="__NSID__"><object  id=gcds_check_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!--반제, 상계처리시 처리금액을 임시로 저장해서 체크함.-->

<!-- 반제전표조회 ==>삭제버튼 -->
<comment id="__NSID__"><object  id=gcds_del03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<!--param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t5(I:USER=gcds_banjae)"-->   
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 반제데이타 삭제 -->
<comment id="__NSID__"><object  id=gctr_data03 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020003_t3(I:USER=gcds_del03)">   
</object></comment><script>__ws__(__NSID__);</script> 
<!--==========================================================================
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
==========================================================================-->

<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
  
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";

	if(gcds_data01.countrow<=0){
		alert("조회된 데이타가 없습니다.");
	}else{
	 //2007.06.28 추가한 내용
		if(gcds_data01.namevalue(row,"ATCODE")=="2100520"){ 
			gcgd_data01.ColumnProp("REFVALNM2", "Show") = "true";
			gcgd_data01.ColumnProp("REFVAL2", "Show") = "false";
			gcgd_data01.ColumnProp("REFVALNM2","Name")="법인카드거래처";
		}else{
			gcgd_data01.ColumnProp("REFVALNM2", "Show") = "false";
			gcgd_data01.ColumnProp("REFVAL2", "Show") = "true";
			gcgd_data01.ColumnProp("REFVALNM2","Name")="관리항목2";
		}		  
		
		//반제연결테이블에 데이타가 존재할 경우
		if(gcds_dtl.countrow>0){
			//잔액 재계산
      ln_Banjae_Amt_Chk();
		}//if
	}

  //gcgd_data01.DataID = "gcds_data01";
  gcgd_data01.ViewSummary ="1";
</script>

<!-- 2008.06.19 정영식 수정 -->
<script language=JavaScript for=gcds_dtl event=onColumnChanged(row,colid)>
	if (colid == "CHAAMT"||colid == "DAEAMT" ) {
		ln_Chk_Atcode_Amt(row);
  }

</script>



<script language="javascript" for="gcds_data02" event="OnLoadStarted()">
	ft_cnt02.innerText="데이타 조회중입니다.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data02" event="onloadCompleted(row,colid)">

  ft_cnt02.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";

	if(gcds_data02.countrow<=0){
		alert("조회된 데이타가 없습니다.");
	}
</script>


<script language="javascript" for="gcds_data03" event="OnLoadStarted()">
  document.all.LowerFrame.style.visibility="visible";
	ft_cnt03.innerText="데이타 조회중입니다.";
	
</script>

<script language="javascript" for="gcds_data03" event="onloadCompleted(row,colid)">
  ft_cnt03.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";

	if(gcds_data03.countrow<=0){
		alert("조회된 데이타가 없습니다.");
	}
</script>

<script language="javascript" for="gcds_data04" event="OnLoadStarted()">
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data04" event="onloadCompleted(row,colid)">
 	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";

	if(gcds_data04.countrow<=0){
		alert("조회된 데이타가 없습니다.");
	}
</script>

<script language="javascript" for="gcds_data05" event="OnLoadStarted()">
  
	document.all.LowerFrame.style.visibility="visible";

</script>

<script language="javascript" for="gcds_data05" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";

	if(gcds_data05.countrow<=0){
		alert("조회된 데이타가 없습니다.");
	}
</script>

<!-- 관리항목 -->
<script language="javascript" for="gcds_fsrefcd" event="onloadCompleted(row,colid)">
	gcds_fsrefcd.InsertRow(1);
	gcds_fsrefcd.NameValue(1,"CDCODE")="";
	gcds_fsrefcd.NameValue(1,"CDNAM")="";
	gclx_fsrefcd.index=0;
</script>

<!-- 관리항목 -->
<script language="javascript" for="gcds_fsrefcd05" event="onloadCompleted(row,colid)">
	gcds_fsrefcd05.InsertRow(1);
	gcds_fsrefcd05.NameValue(1,"CDCODE")="";
	gcds_fsrefcd05.NameValue(1,"CDNAM")="";
	gclx_fsrefcd05.index=0;
</script>

<!-- 지점구분 -->
<script language="javascript" for="gcds_comfield" event="onloadCompleted(row,colid)">
	//gcds_comfield.InsertRow(1);
	//gcds_comfield.NameValue(1,"FDCODE")="";
	//gcds_comfield.NameValue(1,"FDNAME")="전체";
	//gclx_sfdcode.index=0;
	if(gfdcode == null) {
		gfdcode="01";
	}
	gclx_fdcode.BindColVal = gfdcode;
</script>

<!-- 지점구분 -->
<script language="javascript" for="gcds_comfield02" event="onloadCompleted(row,colid)">
	//gcds_comfield.InsertRow(1);
	//gcds_comfield.NameValue(1,"FDCODE")="";
	//gcds_comfield.NameValue(1,"FDNAME")="전체";
	//gclx_sfdcode.index=0;
	if(gfdcode == null) {
		gfdcode="01";
	}
	gclx_fdcode02.BindColVal = gfdcode;
</script>

<!-- 지점구분 -->
<script language="javascript" for="gcds_comfield03" event="onloadCompleted(row,colid)">
	//gcds_comfield.InsertRow(1);
	//gcds_comfield.NameValue(1,"FDCODE")="";
	//gcds_comfield.NameValue(1,"FDNAME")="전체";
	//gclx_sfdcode.index=0;
	if(gfdcode == null) {
		gfdcode="01";
	}
	gclx_fdcode03.BindColVal = gfdcode;
</script>

<!-- 지점구분 -->
<script language="javascript" for="gcds_comfield04" event="onloadCompleted(row,colid)">
	//gcds_comfield.InsertRow(1);
	//gcds_comfield.NameValue(1,"FDCODE")="";
	//gcds_comfield.NameValue(1,"FDNAME")="전체";
	//gclx_sfdcode.index=0;
	if(gfdcode == null) {
		gfdcode="01";
	}
	gclx_fdcode04.BindColVal = gfdcode;
</script>

<!-- 지점구분 -->
<script language="javascript" for="gcds_comfield05" event="onloadCompleted(row,colid)">
	//gcds_comfield.InsertRow(1);
	//gcds_comfield.NameValue(1,"FDCODE")="";
	//gcds_comfield.NameValue(1,"FDNAME")="전체";
	//gclx_sfdcode.index=0;
	if(gfdcode == null) {
		gfdcode="01";
	}
	gclx_fdcode05.BindColVal = gfdcode;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- 계정코드 -->
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1));
</script>

<script language="javascript" for="gcgd_data01" event="OnClick(row,colid)">
  //GUBUN - N:정산진행중    Y:정산완료
  var dbltemp=0;
	if(row<1) {
	  if(row==0 && colid=="CHK"){ //전체선택              
		  if(gcds_data01.namevalue(1,"CHK")=="T"){
				if(gcds_dtl.countrow<=0){
					for(i=1;i<=gcds_data01.Countrow;i++){
						if(gcds_data01.namevalue(i,"GUBUN")=="N"){
							gcds_data01.namevalue(i,"CHK") = "F";
							gcds_data01.namevalue(i,"JANAMT") = gcds_data01.OrgNameValue(i,"JANAMT");
							gcds_data01.namevalue(i,"BANJAEAMT")=0;
						}
					}//for
				}else{
					for(i=1;i<=gcds_data01.Countrow;i++){
						if(gcds_data01.namevalue(i,"GUBUN")=="N"){
							gcds_data01.namevalue(i,"CHK") = "F";
							dbltemp=ln_Dtl_Amt_Chk_Return(i,'');
							gcds_data01.namevalue(i,"JANAMT")=dbltemp;
							gcds_data01.namevalue(i,"BANJAEAMT")=0;
						}
					}//for
				}
			}else{
				if(gcds_dtl.countrow<=0){
					for(i=1;i<=gcds_data01.Countrow;i++){
						if(gcds_data01.namevalue(i,"GUBUN")=="N"){
							gcds_data01.namevalue(i,"CHK")="T";
							gcds_data01.namevalue(i,"BANJAEAMT")=gcds_data01.namevalue(i,"JANAMT");
							gcds_data01.namevalue(i,"JANAMT")=gcds_data01.namevalue(i,"JANAMT")-gcds_data01.namevalue(i,"BANJAEAMT");
						}
					}//for
				}else{
					for(i=1;i<=gcds_data01.Countrow;i++){
						if(gcds_data01.namevalue(i,"GUBUN")=="N"){
							gcds_data01.namevalue(i,"CHK") = "T";
							dbltemp=ln_Dtl_Amt_Chk_Return(i,'');
							//alert("dbltemp::"+dbltemp);
							gcds_data01.namevalue(i,"BANJAEAMT")=Number(dbltemp);
							gcds_data01.namevalue(i,"JANAMT")=dbltemp-gcds_data01.namevalue(i,"BANJAEAMT");
						}
					}//for
				}
			}
		}

		gcgd_data01.editable="false";
		return;
	}else{   //개별선택
		if(colid=="CHK") {
			if(gcds_data01.namevalue(row,"CHK") == "T"){
				if(gcds_dtl.countrow<=0){
					gcds_data01.namevalue(row,"CHK") = "F";
					gcds_data01.namevalue(row,"JANAMT") = gcds_data01.OrgNameValue(row,"JANAMT");
					gcds_data01.namevalue(row,"BANJAEAMT")=0;
				}else{
					gcds_data01.namevalue(row,"CHK") = "F";
					dbltemp=ln_Dtl_Amt_Chk_Return(row,'');
					gcds_data01.namevalue(row,"JANAMT") =dbltemp;
					gcds_data01.namevalue(row,"BANJAEAMT")=0;
				}
			}else{
				if(gcds_data01.namevalue(row,"GUBUN")=="N"){
					if(gcds_dtl.countrow<=0){
						gcds_data01.namevalue(row,"CHK") = "T";
						gcds_data01.namevalue(row,"BANJAEAMT")=gcds_data01.namevalue(row,"JANAMT");
						gcds_data01.namevalue(row,"JANAMT")=gcds_data01.namevalue(row,"JANAMT")-gcds_data01.namevalue(row,"BANJAEAMT");
					}else{
						gcds_data01.namevalue(row,"CHK") = "T";
						dbltemp=ln_Dtl_Amt_Chk_Return(row,'');
						gcds_data01.namevalue(row,"BANJAEAMT")=dbltemp;
						gcds_data01.namevalue(row,"JANAMT")=dbltemp-gcds_data01.namevalue(row,"BANJAEAMT");
					}
				}
			}
		}
	}

	if(colid=="BANJAEAMT"&&gcds_data01.namevalue(row,"CHK")=="T") {
		gcgd_data01.editable="true";
	}	else {
		gcgd_data01.editable="false";
	}

  txt_banjaesum.value=""; 
	txt_banjaesum.value = gf_setnum(gcds_data01.Sum(16,0,0));

</script>

<script language=JavaScript for=gcgd_data01 event=OnDblClick(row,colid)>
	 if(colid!="BANJAEAMT"&&colid!="CHK"){
		 ln_Data2(row)
		 ln_Query2(gcds_data01.namevalue(row,"FDCODE"),gcds_data01.namevalue(row,"FSDAT"),  
							 gcds_data01.namevalue(row,"FSNBR"),gcds_data01.namevalue(row,"FSSEQ"),
					     gcds_data01.namevalue(row,"ATCODE"),gcds_data01.namevalue(row,"VENDCD"),
							 gcds_data01.namevalue(row,"FSREFCD"),gcds_data01.namevalue(row,"FSREFVAL"));
		 ln_DispChk(1);
		 gcte_disp.ActiveIndex=2;
	 }
</script>

<script language="javascript" for="gcgd_dtl" event="OnClick(row,colid)">
	if(gcds_dtl.namevalue(row,"GUBUN")=="B"&&(colid=="CHAAMT"||colid=="DAEAMT")){ //반제계정
		 gcgd_dtl.ColumnProp('CHAAMT','Edit')="RealNumeric";
		 gcgd_dtl.ColumnProp('DAEAMT','Edit')="RealNumeric";
	}else{
		 gcgd_dtl.ColumnProp('CHAAMT','Edit')="None";
		 gcgd_dtl.ColumnProp('DAEAMT','Edit')="None";
	}

	//2008.04.03. 정영식 추가.....적요 복사 기능 추가
	if(row==0){
		 if(colid =="REMARK"){
				if(txt_atcode_fr.value=="2101300"||txt_atcode_fr.value=="1110310"){ //가수금, 외상매출금
					 for(i=2;i<=gcds_dtl.countrow;i++){
							gcds_dtl.namevalue(i,"REMARK") = gcds_dtl.namevalue(1,"REMARK"); 										
					 }
				}
		 }
	 }
</script>

<script language="javascript"  for=gcgd_data01 event=OnExit(row,colid,olddata)>
	
	var dblAmt=0;
	var dblAmt2=0;
	var tempamt=0;
  
	if(colid=="BANJAEAMT"){
		if(gcds_data01.namevalue(row,"CHAAMT")!=0&&gcds_data01.namevalue(row,"DAEAMT")==0){
			tempamt = ln_Amt_Chk("01",row);
			dblAmt=gcds_data01.namevalue(row,"CHAAMT")-gcds_data01.namevalue(row,"DAEAMT");
		}else if(gcds_data01.namevalue(row,"CHAAMT")==0&&gcds_data01.namevalue(row,"DAEAMT")!=0){
			tempamt = ln_Amt_Chk("02",row);
			dblAmt=gcds_data01.namevalue(row,"DAEAMT")-gcds_data01.namevalue(row,"CHAAMT");
		}else{
		  if(gcds_data01.namevalue(row,"CHAAMT")-gcds_data01.namevalue(row,"DAEAMT")>0){
				dblAmt=gcds_data01.namevalue(row,"CHAAMT")-gcds_data01.namevalue(row,"DAEAMT");
      }else if(gcds_data01.namevalue(row,"CHAAMT")-gcds_data01.namevalue(row,"DAEAMT")<0){
        dblAmt=gcds_data01.namevalue(row,"DAEAMT")-gcds_data01.namevalue(row,"CHAAMT");
			}
		}

		if(dblAmt <gcds_data01.namevalue(row,"BANJAEAMT")+tempamt) {
			alert("반제금액이 잔액보다 클 수 없습니다.");
			gcds_data01.namevalue(row,"BANJAEAMT")=olddata;
		}else{
			gcds_data01.namevalue(row,"JANAMT")=dblAmt-gcds_data01.namevalue(row,"BANJAEAMT")-tempamt;
		}
	}  
</script>


<script language=JavaScript for=gcgd_disp02 event=OnDblClick(row,colid)>
	if(row>0){
		ln_Popup2(gcds_data02.namevalue(row,"FDCODE"),gcds_data02.namevalue(row,"BTSDAT"),gcds_data02.namevalue(row,"BTSNBR") );
	}
</script>

<script language=JavaScript for=gcem_chaamt03 event=OnKillFocus()>
  var temp1 = gcem_chaamt03.text ; 
	var temp2 = gcem_janamt02.text ;
	var temp3 = Number(temp1)-Number(temp2); 
 
  if(gcem_chaamt03.text!=0){
		if(gcem_chaamt02.text!=0 && gcem_daeamt02.text==0 ){ 
			alert("차변에 금액을 입력할 수 없습니다.")
			gcem_chaamt03.text=0;
			return;
		}
    if(temp3>0){
			alert("차변금액이 잔금보다 클 수 없습니다.");
		}
	}
</script>

<script language=JavaScript for=gcem_daeamt03 event=OnKillFocus()>
  var temp1 = gcem_daeamt03.text ; 
	var temp2 = gcem_janamt02.text ;
	var temp3 = Number(temp1)-Number(temp2); 

  if(gcem_daeamt03.text!=0){
		if(gcem_chaamt02.text ==0 && gcem_daeamt02.text!=0){ 
			alert("대변에 금액을 입력할 수 없습니다.")
			gcem_daeamt03.text=0;
			return;
		}

		if(temp3>0){
			alert("대변금액이 잔금보다 클 수 없습니다.");
		}
	}
</script>

<script language=JavaScript for=gclx_fsrefcd event=oncloseup()>
	//관리항목1[검색]
	gcds_fsrefval.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd.bindcolval;  
	gcds_fsrefval.Reset();
</script>


<script language=JavaScript for=gcgd_dtl event=OnPopup(row,colid,data)>
	ln_Popup('gcgd_dtl','',row,'');
</script>

<script language=JavaScript for=gcgd_disp03 event=OnDblClick(row,colid)>
   ln_Data4(row);
	 //반제전표로 Detail찾기
   ln_Query4(gcds_data03.namevalue(row,"FDCODE"),gcds_data03.namevalue(row,"BTSDAT"),gcds_data03.namevalue(row,"BTSNBR"));
	 ln_DispChk(3);
	 gcte_disp.ActiveIndex=4;
</script>

<script language=JavaScript for=gcgd_disp04 event=OnDblClick(row,colid)>
	 //반제전표로 원전표 찾기 (지점, 반제전표일자, 반제전표번호, 반제전표행번호)
   ln_Query4_2(gcds_data04.namevalue(row,"FDCODE"),gcds_data04.namevalue(row,"TSDAT"),gcds_data04.namevalue(row,"TSNBR"),gcds_data04.namevalue(row,"TSSEQ"));
</script>

<script language=JavaScript for=gcgd_disp05 event=OnDblClick(row,colid)>
	 //원전표로 반제전표찾기 (지점, 원전표접수일자, 원전표접수번호, 원전표접수행번호)
  // ln_Query5_2(gcds_data05.namevalue(row,"FDCODE"),gcds_data05.namevalue(row,"TSDAT"),gcds_data05.namevalue(row,"TSNBR"),gcds_data05.namevalue(row,"TSSEQ"));

   ln_Query5_2(gcds_data05.namevalue(row,"FDCODE"),gcds_data05.namevalue(row,"FSDAT"),  
					  	 gcds_data05.namevalue(row,"FSNBR"),gcds_data05.namevalue(row,"FSSEQ"),
					     '','','','');
</script>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data01 event=OnSuccess()>
	//alert("작업이 성공적으로 완료되었습니다.");
	//gs_save="Y";
</script>

<script language=JavaScript for=gctr_data01 event=OnFail()>
	//alert("작업이 성공적으로 완료되지 못했습니다.");
	//gs_save="N";
</script>

<script language=JavaScript for=gctr_data03 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
	//gs_save="Y";
</script>

<script language=JavaScript for=gctr_data03 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data03.ErrorCode + "\n" + "Error Message : " + gctr_data03.ErrorMsg + "\n");
	//gs_save="N";
</script>


</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="876px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td><img src="../img/a020003_head.gif"></td>
		<td width="876px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
		</td>
	</tr>
  <tr> 
    <td colspan=2>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr>
					<td width="0" align=right>
						<comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;position:relative;right:1px;">
							<PARAM NAME="BackColor"					VALUE="#cccccc">
   					  <PARAM NAME="titleHeight"				VALUE="20px">
						  <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
						  <PARAM NAME="Format"						VALUE="
								<T>divid=div_1		title='  전표작성  '</T>									
							  <T>divid=div_2		title='  내역조회  '</T>
								<T>divid=div_3    title='반제전표조회'</T>
								<T>divid=div_4    title='반제전표상세'</T>
								<T>divid=div_5    title='반제현황조회'</T>
							">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
			</table>
		</td>
  </tr>
</table>

<!--==1.전표작성 =========================================================================================-->
<table id="div_disp1"  cellpadding="0" cellspacing="0" border="0"  style="dispaly:block;position:relative;left:3px;" >
 <tr>
 <td>
	<table width="876px" cellpadding="0" cellspacing="0" border="0" >
		<tr> 
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab15" align=center><nobr>&nbsp;지점구분</nobr></td>
			<td class="tab18" style="height:30px;width:110px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
						<param name=ComboDataID    value="gcds_comfield">
						<param name=CBDataColumns	 value="FDCODE,FDNAME">
						<param name=SearchColumn	 value=FDNAME>
						<param name=Sort			     value=false>
						<!--param name=Enable         value="false"-->
						<param name=ListExprFormat value="FDNAME^0^150">								
						<param name=BindColumn		 value="FDCODE">
				</object></comment><script>__ws__(__NSID__);</script> </nobr>
				<input id="txt_param"  type="hidden"   style= "width:90px; height:20px;" maxlength="7">
			 </td>

			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;기간&nbsp;</nobr></td>
			<td class="tab18" style="height:30px;width:250px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_actdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
				 </object></comment><script>__ws__(__NSID__);</script> 
				 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat_fr', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
					~&nbsp;<comment id="__NSID__">
				 <object  id=gcem_actdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">				
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat_to', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
					</nobr> 
			</td>
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;구분&nbsp;</nobr></td>
			<td class="tab31" style="height:30px;width:220px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcra_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="position:relative;left:0px;top:2px;height:24;width:210;cursor:hand;">
					  <param name=Cols     value="3">								 
						<param name=Format   value="N^미정산,Y^정산완료">
			  </object></comment><script>__ws__(__NSID__);</script> 
				</nobr>
			</td> 
			<td class="tab18" style="height:30px;width:250px;"  align=right>
       		<img src="../../Common/img/btn/com_b_taxissue.gif" style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Popup_Slip('01','')" >
					<!-- <img src="../../common/img/btn/com_b_print.gif"	   style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Print()" > -->
					<img src="../../Common/img/btn/com_b_excel.gif"	  style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Excel()" >
			    <img src="../../Common/img/btn/com_b_query.gif"    style="cursor:hand;position:relative;right:2px;top:2px;" onclick="ln_Query()">
			</td>
		</tr>
		<tr>
		  <td width="70px"  height="30px" style="" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;계정과목&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:100px;" colspan=3><nobr>&nbsp;
				<input id="txt_atcodenm_fr" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:260px; height:20px;ime-mode:active;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcodenm_fr')">
				<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정과목을 검색합니다" style="cursor:hand;position:relative;left:-4px;top:0px;" align=center onclick="ln_Popup('01','fr','','txt_atcodenm_fr');">
				<input id="txt_atcode_fr" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:60px; height:20px;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode_fr')" >
				</nobr>
			</td> 
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;거래처&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:150px;" colspan=2><nobr>&nbsp;
				<input id="txt_custnm_fr" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:250px; height:20px;" maxlength="36"  onkeydown="ln_Blur('01','cust','txt_custnm_fr')">
				<img src="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:-4px;top:0px;ime-mode:active;" align=center onclick="ln_Popup('02','fr','','txt_custnm_fr');">				
				<input id="txt_custcd_fr" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:60px; height:20px;" maxlength="13"   onkeydown="ln_Blur('01','cust','txt_custcd_fr')">	
				</nobr>
			</td> 
		</tr>
		<tr>
			<td width="70px"  style="height:30px" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;관리항목&nbsp;</nobr></td>
			<td class="tab19" style="width:100px;height:30px" colspan=6>
			<nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fsrefcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:5px;font-size:12px;width:100px;">
						<param name=ComboDataID    value="gcds_fsrefcd">
						<param name=CBDataColumns	 value="CDCODE,CDNAM">
						<param name=SearchColumn	 value=CDNAM>
						<param name=Sort			     value=false>
						<param name=ListExprFormat value="CDNAM^0^180">								
						<param name=BindColumn		 value="CDCODE">
				</object></comment><script>__ws__(__NSID__);</script> &nbsp;
				<input id="txt_fsrefnm_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:155px; height:20px;ime-mode:active; " maxlength="36" onkeydown="ln_Blur('01','fsref_fr','txt_fsrefnm_fr')">
				<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="관리항목을 검색합니다" style="cursor:hand;position:relative;left:-4px;top:0px;" align=center onclick="ln_Popup('03','fr','','txt_fsrefnm_fr');">
				<input id="txt_fsrefcd_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:60px; height:20px;" maxlength="8" onkeydown="ln_Blur('01','fsref_fr','txt_fsrefcd_fr')">~&nbsp;
				<input id="txt_fsrefnm_to" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:155px; height:20px;ime-mode:active; " maxlength="36" onkeydown="ln_Blur('01','fsref_to','txt_fsrefnm_to')">				
				<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="관리항목을 검색합니다" style="cursor:hand;position:relative;left:-4px;top:0px;" align=center onclick="ln_Popup('03','to','','txt_fsrefnm_to');">
				<input id="txt_fsrefcd_to" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:60px; height:20px;" maxlength="8" onkeydown="ln_Blur('01','fsref_to','txt_fsrefcd_to')" >
				<img SRC="../../Common/img/btn/com_b_clear.gif" BORDER="0" style="cursor:hand;position:relative;left:0px;top:0px" align=center onclick="ln_Clear('02');">
			 <!--  <img src="../../common/img/btn/com_b_choice.gif"		style="cursor:hand;position:relative;top:6px;left:0px" onClick="ln_Popup_Choice('02')">  -->
				</nobr>
			</td> 	
		</tr>

    <tr>
			<td class="tab17" width="70px"  height="30px" style="" bgcolor="#eeeeee"  align=center >
				<input id="txt_label" type="text"  class="txt41" style= "width:50px;height:20px;position:relative;left:0px;background-color:#eeeeee"  readOnly="true";> 
			</td>
			<td class="tab19" style="height:30px;width:250px;"  colspan=6 ><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_date_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
				 </object></comment><script>__ws__(__NSID__);</script> 
				 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_date_fr', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
					~&nbsp;<comment id="__NSID__">
				 <object  id=gcem_date_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">				
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_date_to', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
					</nobr> 
			</td>
		</tr>

		<tr>
			<td height=3  colspan =7> </td>
		</tr>
	</table>

	<table width="876px" cellpadding="0" cellspacing="0" border="0">
		<tr>
		<td width="876px"  class="tab15" align="right">
			<nobr>				
			  <font style="position:relative;top:-4px;left:0px">반제금액</font>&nbsp;
				<input id="txt_banjaesum" type="text"  class="txtbox"  style= "position:relative;top:-1px;left:0px;width:100px; height:20px; text-align:right; color:#0000ff " onBlur="ln_Numeric()" maxlength="15" readOnly=false >
				<img src="../../Common/img/btn/com_b_setoff.gif"		style="cursor:hand;position:relative;top:3px;left:0px" onClick="ln_Setoff()">
				<img src="../../Common/img/btn/com_b_rowdel.gif"		style="cursor:hand;position:relative;top:3px;left:0px" onClick="ln_Row_Del()">
				<img src="../../Common/img/btn/com_b_rowadd.gif"    style="cursor:hand;position:relative;top:3px;left:0px" onclick="ln_Row_Add()">
				<img src="../../Common/img/btn/com_b_ban.gif"		    style="cursor:hand;position:relative;top:3px;left:0px" onClick="ln_Data_Banjae('01')">
				<img src="../../Common/img/btn/com_b_bantot.gif"		style="cursor:hand;position:relative;top:3px;left:0px" onClick="ln_Data_Banjae('02')">&nbsp;
				</nobr>
		  </td>
		</tr>

		<tr>
			<td height=3  colspan=8> </td>
		</tr>
	</table>

	<table width="876px" cellpadding="0" cellspacing="0" border="0" >
		<tr> 
			<td>                                      
				<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data01  
				style="position:relative;left:0px;width:875px; height:155px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			 VALUE="gcds_data01">
					<PARAM NAME="IndWidth"		 VALUE ="0">
					<PARAM NAME="BorderStyle"  VALUE="0">
					<PARAM NAME="Fillarea"		 VALUE="true">
					<PARAM NAME="Sortview"		 VALUE="left">
					<param name="ColSizing"    value="true">
					<param name="Editable"     value="false">
					<param name="ViewSummary"	 value=1>
					<PARAM NAME="Format"			 VALUE="           
					<FC> Name='선택'		  ID=CHK 	     HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center	 SumBgColor=#C3D0DB  editstyle=checkbox</FC> 
					<FC> Name='구분'		  ID=GUBUN     HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center	 SumBgColor=#C3D0DB  editStyle=Combo Data='N:미,Y:완료' edit=none </FC> 
					<FC> Name='전표번호'  ID=SSNBR1	   HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center	 SumBgColor=#C3D0DB  edit=none  sumText='합 계' sort=true</FC> 
					<FC> Name='순번'			ID=FSNUM		 HeadAlign=Center HeadBgColor=#B9D4DC Width=28    align=center	 SumBgColor=#C3D0DB  edit=none </FC> 
					<C> Name='차변'			  ID=CHAAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right	   SumBgColor=#C3D0DB  edit=none  color=#0000FF SumColor=#0000FF  sumText=@sum</C> 
					<C> Name='대변'			  ID=DAEAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right    SumBgColor=#C3D0DB  edit=none  color=#FF0000 SumColor=#FF0000  sumText=@sum</C> 
					<C> Name='잔액'			  ID=JANAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right    SumBgColor=#C3D0DB  edit=none  sort=true</C> 
					<C> Name='반제금액'		ID=BANJAEAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=80  	align=right    SumBgColor=#C3D0DB  edit=RealNumeric bgColor=#ffffcc </C> 
					<C> Name='적요'		    ID=REMARK 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=130	  align=left     SumBgColor=#C3D0DB  edit=none </C> 
					<C> Name='거래처'		  ID=VENDNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=95	  align=left     SumBgColor=#C3D0DB  edit=none sort=true</C> 
					<C> Name='관리항목'		ID=FSREFNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=121	  align=left     SumBgColor=#C3D0DB  edit=none  EditStyle=Lookup Data='gcds_fsrefval:CDCODE:CDNAM' sort=true</C> 
					<C> Name='입력일자'	  ID=REFVAL2 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=left     SumBgColor=#C3D0DB  edit=none  Mask='XXXX/XX/XX'  </C> 
					<C> Name='관리항목'	  ID=REFVALNM2 HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=reft     SumBgColor=#C3D0DB  edit=none  </C> 
					">
				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
		</tr>
		<tr>
				<!--fieldset style="position:relative;left:0px;width:877px;height:5px;border:0 solid #708090;border-top-width:0px;border-bottom-width:0px;text-align:left;">
					&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
				</fieldset-->
			<td height=5  colspan=8> </td>
		</tr>
		<tr> 
			<td>
				<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_dtl  
				style="position:relative;left:0px;width:875px; height:150px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_dtl">
					<PARAM NAME="IndWidth"		VALUE ="0">
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM NAME="Sortview"		VALUE="left">
					<param name="ColSizing"   value="true">
					<param name="Editable"    value="true">
					<param name="ViewSummary"	value=1>
					<PARAM NAME="Format"			VALUE="              
					<FC> Name='선택'		  ID=CHK 	       HeadAlign=Center HeadBgColor=#B9D4DC Width=30	 align=center	 SumBgColor=#C3D0DB edit=none editstyle=checkbox</FC> 
					<FC> Name='계정'		  ID=ATKORNAM    HeadAlign=Center HeadBgColor=#B9D4DC Width=170	 align=left	   SumBgColor=#C3D0DB BgColor=#ffffcc  EditStyle=Popup sumText='합 계' </FC> 
					<C> Name='반제차변'	  ID=CHAAMT      HeadAlign=Center HeadBgColor=#B9D4DC Width=100	 align=right	 SumBgColor=#C3D0DB BgColor=#ffffcc  color=#0000FF edit=none sumText=@sum</C> 
					<C> Name='반제대변'		ID=DAEAMT      HeadAlign=Center HeadBgColor=#B9D4DC Width=100	 align=right   SumBgColor=#C3D0DB BgColor=#ffffcc  color=#FF0000 edit=none sumText=@sum</C> 
					<C> Name='적요 √'		  ID=REMARK 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=200	 align=left    SumBgColor=#C3D0DB BgColor=#ffffcc  SumText={sum(CHAAMT)-sum(DAEAMT)} SumTextAlign=right</C> 
					<C> Name='거래처'		  ID=VENDNM 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=130	 align=left    SumBgColor=#C3D0DB edit=none </C> 
					<C> Name='관리항목'		ID=FSREFNM 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=121	 align=reft    SumBgColor=#C3D0DB edit=none EditStyle=Lookup Data='gcds_fsrefval:CDCODE:CDNAM'</C> 
					<C> Name='입력일자'	  ID=REFVAL2 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=70	 align=reft    SumBgColor=#C3D0DB edit=none  Mask='XXXX/XX/XX'  </C> 
					<C> Name='부서'		    ID=DEPTNM 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=125	 align=left    SumBgColor=#C3D0DB edit=none </C> 
					">
				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
		</tr>
	</table>

</td>	
</tr>	
</table>

<!--==2.내역조회 =========================================================================================-->
<table id="div_disp2"  cellpadding="0" cellspacing="0" border=0 style="display:none">
<tr>
<td>
	<table width="876px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab15" align=center><nobr>&nbsp;지점구분</nobr></td>
			<td class="tab18" style="height:30px;width:140px;" ><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fdcode02 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
						<param name=ComboDataID    value="gcds_comfield02">
						<param name=CBDataColumns	 value="FDCODE,FDNAME">
						<param name=SearchColumn	 value=FDNAME>
						<param name=Sort			     value=false>
						<param name=Enable         value="false">
						<param name=ListExprFormat value="FDNAME^0^150">								
						<param name=BindColumn		 value="FDCODE">
				</object></comment><script>__ws__(__NSID__);</script> </nobr>
			</td>

			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;전표번호&nbsp;</nobr></td>
			<td class="tab18" style="height:30px;width:140px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_fsdatnbr02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=PromptChar    value="_">
									<param name=ReadOnly      value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=ReadOnlyBackColor   value="#D7D7D7">
									<param name=InheritColor  value=false>
				 </object></comment><script>__ws__(__NSID__);</script> </nobr> 
			</td>
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;회계일자&nbsp;</nobr></td>
			<td class="tab18" style="height:30px;width:140px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_actdat02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">				
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=ReadOnly      value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=ReadOnlyBackColor   value="#D7D7D7">
									<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> </nobr> 
			</td> 
			
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;전표상태&nbsp;</nobr></td>
			<td class="tab18" style="height:30px;width:250px;"><nobr>&nbsp;<comment id="__NSID__">	
				<object  id=gclx_fsstat02 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:2px;font-size:12px;width:110px;">
						<param name=CBData			   value="Y^결재완료,R^결재요청,N^결재대기,C^결재취소,B^반송">
						<param name=CBDataColumns	 value="CODE,NAME">
						<param name=SearchColumn	 value=NAME>
						<param name=Sort			     value=false>
						<param name=Enable         value="false">
						<param name=ListExprFormat value="NAME^0^150">								
						<param name=BindColumn		 value="CODE">
				</object></comment><script>__ws__(__NSID__);</script> 

        <img src="../../Common/img/btn/com_b_excel.gif"	  style="cursor:hand;position:relative;left:17px;top:2px;" onClick="ln_Excel2()" > 
				<img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand;position:relative;left:17px;top:2px;" onclick="ln_Query2()">
				</nobr> 
			</td>
			
		</tr>
		<tr>   
		  <td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;&nbsp;계정과목&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:140px;"><nobr>&nbsp;<comment id="__NSID__">	
				<input id="txt_atcode02"  type="hidden"   style= "width:90px; height:20px;" maxlength="7">
				<object  id=gcem_atcodenm02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:-4px;top:3px">				
						<param name=Text					value="">
						<param name=GeneralEdit   value="true">
						<param name=Border        value=true>
						<param name=ReadOnly      value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=ReadOnlyBackColor   value="#D7D7D7">
						<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>	
		  </td>
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;차변금액&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:140px;"><nobr>&nbsp;<comment id="__NSID__">	
				<object  id=gcem_chaamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=Alignment     value=2>
						<param name=Numeric       value="true">
						<param name=IsComma       value=true>
						<param name=MaxLength     value=12>
						<param name=ReadOnly      value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=ReadOnlyBackColor   value="#D7D7D7">
						<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>	
			</td>
      <td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;대변금액&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:140px;"><nobr>&nbsp;<comment id="__NSID__">	
				<object  id=gcem_daeamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=Alignment     value=2>
						<param name=Numeric       value="true">
						<param name=IsComma       value=true>
						<param name=MaxLength     value=12>
						<param name=ReadOnly      value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=ReadOnlyBackColor   value="#D7D7D7">
						<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>	
			</td>
      <td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;잔액&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:300px;"><nobr>&nbsp;<comment id="__NSID__">	
				<object  id=gcem_janamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=Alignment     value=2>
						<param name=Numeric       value="true">
						<param name=IsComma       value=true>
						<param name=MaxLength     value=12>
						<param name=ReadOnly      value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=ReadOnlyBackColor   value="#D7D7D7">
						<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>	
			</td>

		</tr>
		<tr>
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;&nbsp;적요&nbsp;</nobr></td>
			<td class="tab19" style="width:280px;height:30px" colspan=3><nobr>&nbsp;
				<input id="txt_remark02" type="text" class="txtbox" readOnly=true  style= "position:relative;top:0px;left:-4px;width:325px; height:20px;background-color:#d7d7d7" maxlength="60" bgColor="#D7D7D7"  >
				</nobr>
			</td>
			<td width="70px"  style="height:30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;거래처&nbsp;</nobr></td>
			<td class="tab19" style="width:300px;height:30px" colspan=3><nobr>&nbsp;
				<input id="txt_custcd02" type="hidden" class="txtbox"  readOnly=true style= "position:relative;top:0px;left:-4px;width:30px; height:20px;" maxlength="30" >
				<input id="txt_custnm02" type="text" class="txtbox"  readOnly=true   style= "position:relative;top:0px;left:-8px;width:313px; height:20px;background-color:#d7d7d7"  maxlength="60" bgColor="#D7D7D7" >			
				</nobr>
			</td> 	
		</tr>
		<tr>
			<td height=3  colspan =8> </td>
		</tr>
	</table>

	<table width="876px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td>
				<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
				style="position:relative;left:0px;width:875px; height:344px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data02">
					<PARAM NAME="IndWidth"		VALUE ='0'>
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM NAME="Sortview"		VALUE="left">
					<param name="Editable"    value="false">
					<param name="ColSizing"   value="true">
					<param name="ViewSummary"	value=1>
					<PARAM NAME="Format"			VALUE="              
					<C> Name='전표상태'		    ID=FSSTAT    HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=center	 SumBgColor=#C3D0DB EditStyle=Combo Data='N:결재대기,R:결재요청,Y:결재완료' edit=none </C> 
					<C> Name='반제전표번호'		ID=SSDATNBR	 HeadAlign=Center HeadBgColor=#B9D4DC Width=102	  align=center	 SumBgColor=#C3D0DB sort=true	edit=none sumText='합 계' </C> 
					<C> Name='순번'		        ID=FSNUM     HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center   SumBgColor=#C3D0DB edit=none </C> 
					<C> Name='차변'			      ID=CHAAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right	   SumBgColor=#C3D0DB edit=none  SumColor=#0000FF color=#0000FF sumText=@sum </C> 
					<C> Name='대변'			      ID=DAEAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right    SumBgColor=#C3D0DB edit=none  SumColor=#FF0000 color=#FF0000 sumText=@sum </C> 
					<C> Name='적요'		        ID=REMARK 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=245	  align=reft     SumBgColor=#C3D0DB edit=none </C> 
					<C> Name='거래처'		      ID=VENDNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=130	  align=reft     SumBgColor=#C3D0DB	sort=true edit=none  </C> 
					<C> Name='관리항목'		    ID=FSREFNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=130	  align=reft     SumBgColor=#C3D0DB	edit=none  </C> 
					<C> Name='법인카드거래처' ID=FSREFNM2	 HeadAlign=Center HeadBgColor=#B9D4DC Width=130	  align=reft     SumBgColor=#C3D0DB	edit=none show=false </C> 
					">
				</object></comment><script>__ws__(__NSID__);</script> 
				<fieldset style="position:relative;left:0px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt02 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</td>
</tr>
</table>

<!--==3.반제전표조회 =========================================================================================-->
<table id="div_disp3"  cellpadding="0" cellspacing="0" border=0 style="display:none">
<tr>
<td>
	<table width="876px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab15" align=center><nobr>회계일자</nobr></td>
			<td class="tab18" style="height:30px;width:290px;" align=left><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_actdat03_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:2px;top:3px">		
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
				 </object></comment><script>__ws__(__NSID__);</script> 
				 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat03_fr', 'Text')" style="position:relative;width:20px;left:4px;cursor:hand;"></nobr>
					~&nbsp;<comment id="__NSID__">
				 <object  id=gcem_actdat03_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:2px;top:3px">				
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat03_to', 'Text')" style="position:relative;width:20px;left:4px;cursor:hand;"></nobr>
			 </td>
      <td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;전표상태&nbsp;</nobr></td>
			<td class="tab18" style="height:30px;width:150px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fsstat03 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:2px;font-size:12px;width:110px;">
						<param name=CBData			   value="Y^결재완료,R^결재요청,N^결재대기,C^결재취소,B^반송">
						<param name=CBDataColumns	 value="CODE,NAME">
						<param name=SearchColumn	 value=NAME>
						<param name=Sort			     value=false>
						<param name=Enable         value="true">
						<param name=ListExprFormat value="NAME^0^150">								
						<param name=BindColumn		 value="CODE">
				</object></comment><script>__ws__(__NSID__);</script> 
				</nobr>
			</td> 
 
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>지점구분</nobr></td>
			<td class="tab18" style="height:30px;width:190px;"><nobr>&nbsp;
				<comment id="__NSID__"><object  id=gclx_fdcode03 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:2px;font-size:12px;width:70px;">
						<param name=ComboDataID    value="gcds_comfield03">
						<param name=CBDataColumns	 value="FDCODE,FDNAME">
						<param name=SearchColumn	 value=FDNAME>
						<param name=Sort			     value=false>
						<param name=ListExprFormat value="FDNAME^0^150">								
						<param name=BindColumn		 value="FDCODE">
				</object></comment><script>__ws__(__NSID__);</script> 
				</nobr>
			</td> 
			<td class="tab18" style="height;30px;width:220px;"  align=right><nobr>
        	<!-- <img src="../../common/img/btn/com_b_taxselect.gif"	  style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Query3()" > -->
					<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Delete3()" >
			    <img src="../../Common/img/btn/com_b_print.gif"   style="cursor:hand;position:relative;right:2px;top:2px;" onclick="ln_Print3()">
        	<img src="../../Common/img/btn/com_b_excel.gif"	  style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Excel3()" >
			    <img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand;position:relative;right:2px;top:2px;" onclick="ln_Query3()"></nobr>
			</td>
		</tr>
		<tr>
			<td width="70px"  style="height:30px" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;&nbsp;적요&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:420px;height:20px" colspan=6><nobr>&nbsp;
				<input id="txt_remark03" type="text" class="txtbox"  style= "position:relative;top:0px;left:-2px;width:410px; height:20px;" maxlength="60" bgColor="#D7D7D7"  >
				</nobr>
			</td> 	
		</tr>
    
		<tr>
			<td height=3  colspan =8> </td>
		</tr>
	</table>

	<table width="876px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td>
				<comment id="__NSID__"><object id=gcgd_disp03  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  
				style="position:relative;left:0px;width:875px; height:374px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data03">
					<PARAM NAME="IndWidth"		VALUE ='0'>
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM NAME="Sortview"		VALUE="left">
					<param name="ColSizing"   value="true">
					<param name="Editable"    value="false">
					<param name="ViewSummary"	value=1>
					<PARAM NAME="Format"			VALUE="              
					<C> Name='지점'		        ID=FDNAME	   HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=center	 SumBgColor=#C3D0DB sort=true	edit=none </C> 
					<C> Name='전표번호'		    ID=SSDATNBR  HeadAlign=Center HeadBgColor=#B9D4DC Width=110	  align=center	 SumBgColor=#C3D0DB sort=true  edit=none  sumText='합 계' </C> 
					<C> Name='적요'			      ID=REMARK    HeadAlign=Center HeadBgColor=#B9D4DC Width=360	  align=left	   SumBgColor=#C3D0DB edit=none  sumText=@sum </C> 
					<C> Name='금액'			      ID=FSAMT     HeadAlign=Center HeadBgColor=#B9D4DC Width=110	  align=right    SumBgColor=#C3D0DB edit=none  sumText=@sum </C> 
					<C> Name='접수번호'		    ID=FSDATNBR  HeadAlign=Center HeadBgColor=#B9D4DC Width=110	  align=center   SumBgColor=#C3D0DB sort=true edit=none </C> 
					<C> Name='전표상태'		    ID=FSSTAT    HeadAlign=Center HeadBgColor=#B9D4DC Width=95	  align=center	 SumBgColor=#C3D0DB EditStyle=Combo Data='Y:결재완료,R:결재요청,N:결재대기,C:결재취소,B:반송' edit=none </C> 
					">                                                                                                                                                        
				</object></comment><script>__ws__(__NSID__);</script> 
				<fieldset style="position:relative;left:0px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</td>
</tr>
</table>

<!--==4.반제전표상세 =========================================================================================-->
<table id="div_disp4"  cellpadding="0" cellspacing="0" border=0 style="display:none">
<tr>
<td>
	<table width="876px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab15" align=center><nobr>&nbsp;지점구분</nobr></td>
			<td class="tab18" style="height:30px;width:120px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fdcode04 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
						<param name=ComboDataID    value="gcds_comfield04">
						<param name=CBDataColumns	 value="FDCODE,FDNAME">
						<param name=SearchColumn	 value=FDNAME>
						<param name=Sort			     value=false>
						<param name=Enable         value="false">
						<param name=ListExprFormat value="FDNAME^0^150">								
						<param name=BindColumn		 value="FDCODE">
				</object></comment><script>__ws__(__NSID__);</script> </nobr>
			</td>

			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;&nbsp;전표번호&nbsp;</nobr></td>
			<td class="tab18" style="height:30px;width:150px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_bsdatnbr04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=PromptChar    value="_">
									<param name=ReadOnly      value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=ReadOnlyBackColor   value="#D7D7D7">
									<param name=InheritColor  value=false>
				 </object></comment><script>__ws__(__NSID__);</script> 
				</nobr> 
			</td>
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center>
				<nobr>&nbsp;&nbsp;접수번호&nbsp;</nobr>
			</td>
			<td class="tab18" style="height:30px;width:150px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_btsdatnbr04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=PromptChar    value="_">
									<param name=ReadOnly      value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=ReadOnlyBackColor   value="#D7D7D7">
									<param name=InheritColor  value=false>
				 </object></comment><script>__ws__(__NSID__);</script> 
				</nobr>
			</td>
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center>
				<nobr>&nbsp;전표상태&nbsp;</nobr></td>
			<td class="tab31" style="height:30px;width:200px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fsstat04 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:-2px;top:2px;font-size:12px;width:90px;">
						<param name=CBData         value="Y^결재완료,R^결재요청,N^결재대기,C^결재취소,B^반송">
						<param name=CBDataColumns	 value="FSCODE,FSSTAT">
						<param name=SearchColumn	 value=FSSTAT>
						<param name=Sort			     value=false>
						<param name=ListExprFormat value="FSSTAT^0^150"">								
						<param name=BindColumn		 value="FSCODE">
				</object></comment><script>__ws__(__NSID__);</script> 

				</nobr>
			</td> 
			<td class="tab18" style="height:30px;width:250px;"  align=right>
        	<!-- <img src="../../common/img/btn/com_b_print.gif"	  style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Print()" > -->
			    <!-- <img src="../../common/img/btn/com_b_query.gif"   style="cursor:hand;position:relative;right:2px;top:2px;" onclick="ln_Query()"> -->
					<img src="../../Common/img/btn/com_b_excel.gif"	  style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Excel4()" >
			</td>
		</tr>
		<tr>
			<td width="70px"  style="height:30px" bgcolor="#eeeeee" class="tab17" align=center>
				<nobr>&nbsp;&nbsp;적요&nbsp;</nobr></td>
			<td class="tab19" style="width:340px;height:30px" colspan=3><nobr>&nbsp;
				<input id="txt_remark04" type="text" class="txtbox" readOnly=true  style= "position:relative;top:0px;left:-4px;width:300px; height:20px;background-color:#d7d7d7" maxlength="30" bgColor="#D7D7D7"  >
			</td>
			
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab19" align=center >
				<nobr>&nbsp;&nbsp;차변금액&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:150px;"><nobr>&nbsp;<comment id="__NSID__">	
				<object  id=gcem_chaamt04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=Alignment     value=2>
						<param name=Numeric       value="true">
						<param name=IsComma       value=true>
						<param name=MaxLength     value=12>
						<param name=ReadOnly      value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=ReadOnlyBackColor   value="#D7D7D7">
						<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>	
			</td>
      <td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab19" align=center >
				<nobr>&nbsp;&nbsp;대변금액&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:150px;" colspan=2><nobr>&nbsp;<comment id="__NSID__">	
				<object  id=gcem_daeamt04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=Alignment     value=2>
						<param name=Numeric       value="true">
						<param name=IsComma       value=true>
						<param name=MaxLength     value=12>
						<param name=ReadOnly      value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=ReadOnlyBackColor   value="#D7D7D7">
						<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>	
			</td>
			<td>
			</td>
		</tr>
		<tr>
			<td height=3  colspan=8> </td>
		</tr>
	</table>

	<table width="876px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td>
				<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp04  
				style="position:relative;left:0px;width:875px; height:194px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data04">
					<PARAM NAME="IndWidth"		VALUE ='0'>
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM NAME="Sortview"		VALUE="left">
					<param name="ColSizing"   value="true">
					<param name="Editable"    value="true">
					<param name="ViewSummary"	value=1>
					<PARAM NAME="Format"			VALUE="              
					<C> Name='순번'		        ID=FSNUM     HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center	 SumBgColor=#C3D0DB edit=none </C> 
					<C> Name='계정과목'		    ID=ATKORNAM	 HeadAlign=Center HeadBgColor=#B9D4DC Width=150	  align=left  	 SumBgColor=#C3D0DB sort=true	edit=none sumText='합 계' </C> 
					<C> Name='차변'		        ID=CHAAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=right	   SumBgColor=#C3D0DB edit=none color=#0000FF SumColor=#0000FF sumText=@sum </C> 
					<C> Name='대변'			      ID=DAEAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=right	   SumBgColor=#C3D0DB edit=none color=#FF0000 SumColor=#FF0000 sumText=@sum </C> 
					<C> Name='적요'			      ID=REMARK    HeadAlign=Center HeadBgColor=#B9D4DC Width=213	  align=left     SumBgColor=#C3D0DB edit=none  </C> 
					<C> Name='거래처'		      ID=VENDNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=140	  align=reft     SumBgColor=#C3D0DB sort=true edit=none </C> 
					<C> Name='관리항목'		    ID=FSREFNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=140	  align=reft     SumBgColor=#C3D0DB sort=true edit=none </C> 
					">
				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
		</tr>
		<tr>
				<!--fieldset style="position:relative;left:0px;width:877px;height:5px;border:0 solid #708090;border-top-width:0px;border-bottom-width:0px;text-align:left;">
					&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
				</fieldset-->
			<td height=5  colspan=8> </td>
		</tr>
		<tr> 
			<td>
				<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp14  
				style="position:relative;left:0px;width:875px; height:194px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data04_2">
					<PARAM NAME="IndWidth"		VALUE ='0'>
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM NAME="Sortview"		VALUE="left">
					<param name="ColSizing"   value="true">
					<param name="Editable"    value="true">
					<param name="ViewSummary"	value=1>
					<PARAM NAME="Format"			VALUE="              
					<C> Name='전표번호'		    ID=SSDATNBR  HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center	 SumBgColor=#C3D0DB edit=none sumText='합 계'</C> 
					<C> Name='순번'		        ID=FSNUM	   HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center	 SumBgColor=#C3D0DB edit=none </C> 
					<C> Name='차변'		        ID=CHAAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=right	   SumBgColor=#C3D0DB edit=none  color=#0000FF  SumColor=#0000FF sumText=@sum  </C> 
					<C> Name='대변'			      ID=DAEAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=right	   SumBgColor=#C3D0DB edit=none  color=#FF0000  SumColor=#FF0000 sumText=@sum </C> 
					<C> Name='잔액'			      ID=JANAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=right    SumBgColor=#C3D0DB edit=none  sumText=@sum </C> 
					<C> Name='적요'		        ID=REMARK 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=264	  align=reft     SumBgColor=#C3D0DB edit=none </C> 
					<C> Name='거래처'		      ID=VENDNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=150	  align=reft     SumBgColor=#C3D0DB	edit=none  </C> 
					">
				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
		</tr>
	</table>
</td>
</tr>
</table>

<!--==5.반제현황조회 =========================================================================================-->
<table id="div_disp5"  cellpadding="0" cellspacing="0" border="0"  style="display:none" >
 <tr>
 <td>
	<table width="876px" cellpadding="0" cellspacing="0" border="0"  style="position:relative;left:3px">
		<tr> 
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab15" align=center><nobr>&nbsp;지점구분</nobr></td>
			<td class="tab18" style="height:30px;width:110px;" align=center><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fdcode05 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:-2px;top:2px;font-size:12px;width:100px;">
						<param name=ComboDataID    value="gcds_comfield05">
						<param name=CBDataColumns	 value="FDCODE,FDNAME">
						<param name=SearchColumn	 value=FDNAME>
						<param name=Sort			     value=false>
						<param name=Enable         value="true">
						<param name=ListExprFormat value="FDNAME^0^150">								
						<param name=BindColumn		 value="FDCODE">
				</object></comment><script>__ws__(__NSID__);</script> </nobr>
			 </td>

			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;기간&nbsp;</nobr></td>
			<td class="tab18" style="height:30px;width:250px;"><nobr>&nbsp;
				<comment id="__NSID__"><object  id=gcem_actdat05_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
				 </object></comment><script>__ws__(__NSID__);</script> 
				 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat05_fr', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
					~&nbsp;
				 <comment id="__NSID__"><object  id=gcem_actdat05_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">				
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat05_to', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
					</nobr> 
			</td>
       
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;구분&nbsp;</nobr></td>
			<td class="tab31" style="height:30px;width:150px;"><nobr>&nbsp;<comment id="__NSID__">
				 <object  id=gclx_gubun05 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:-2px;top:2px;font-size:12px;width:90px;">
						<param name=CBData         value="N^미정산,Y^미결완료,A^전체">
						<param name=CBDataColumns	 value="CODE,NAME">
						<param name=SearchColumn	 value=NAME>
						<param name=Sort			     value=false>
						<param name=Enable         value="true">
						<param name=ListExprFormat value="NAME^0^150">							
						<param name=BindColumn		 value="CODE">
				</object></comment><script>__ws__(__NSID__);</script> 
       
				</nobr>
			</td> 
			
			<td class="tab18" style="height:30px;width:250px;"  align=right>
        	<img src="../../Common/img/btn/com_b_print.gif"	  style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Print()" >
			    	<img src="../../Common/img/btn/com_b_excel.gif"	  style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Excel5()" >
					<img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand;position:relative;right:2px;top:2px;" onclick="ln_Query5()">
			</td>
		</tr>
		<tr>
		  <td width="70px"  height="30px" style="" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;계정과목&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:100px;" colspan=3><nobr>&nbsp;
				<input id="txt_atcodenm05_fr" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:260px; height:20px;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcodenm05_fr');">
				<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정과목을 검색합니다" style="cursor:hand;position:relative;left:-4px;top:0px;" align=center onclick="ln_Popup('01','05fr','','txt_atcodenm05_fr');">
				<input id="txt_atcode05_fr" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:60px; height:20px;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode05_fr')" >
				<!--input id="txt_atcodenm_fr" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:235px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);">
				~&nbsp;
				<input id="txt_atcode_to" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:90px; height:20px;" maxlength="7" onBlur="bytelength(this,this.value,36);" >
				<img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="계정과목을 검색합니다" style="cursor:hand;position:relative;left:-4px;top:0px;" align=center onclick="ln_Popup('01','to');">
				<input id="txt_atcodenm_to" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:235px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" -->
				</nobr>
			</td> 

			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;거래처&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:150px;" colspan=2><nobr>&nbsp;
				<input id="txt_custnm05_fr" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:250px; height:20px;" maxlength="36"  onkeydown="ln_Blur('01','cust','txt_custnm05_fr')">
				<img src="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:-4px;top:0px;ime-mode:active;" align=center onclick="ln_Popup('02','05fr','','txt_custnm05_fr');">				
				<input id="txt_custcd05_fr" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:60px; height:20px;" maxlength="13"   onkeydown="ln_Blur('01','cust','txt_custcd05_fr')">	
				</nobr>
			</td> 
		</tr>
		<tr>
			<td width="70px"  style="height:30px" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;관리항목&nbsp;</nobr></td>
			<td class="tab19" style="width:100px;height:30px" colspan=6>
			<nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fsrefcd05 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:5px;font-size:12px;width:100px;">
						<param name=ComboDataID    value="gcds_fsrefcd05">
						<param name=CBDataColumns	 value="CDCODE,CDNAM">
						<param name=SearchColumn	 value=CDNAM>
						<param name=Sort			     value=false>
						<param name=ListExprFormat value="CDNAM^0^150">								
						<param name=BindColumn		 value="CDCODE">
				</object></comment><script>__ws__(__NSID__);</script> &nbsp;
				<input id="txt_fsrefnm05_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:155px; height:20px;" maxlength="36" onkeydown="ln_Blur('03','fsref05_fr','txt_fsrefnm05_fr')">
				<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="관리항목을 검색합니다" style="cursor:hand;position:relative;left:-4px;top:0px;" align=center onclick="ln_Popup('03','05fr','','txt_fsrefnm05_fr');">
				<input id="txt_fsrefcd05_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:60px; height:20px;" maxlength="7" onkeydown="ln_Blur('03','fsref05_fr','txt_fsrefcd05_fr');">				
				~&nbsp;
				<input id="txt_fsrefnm05_to" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:155px; height:20px;" maxlength="36" onkeydown="ln_Blur('03','fsref05_to','txt_fsrefnm05_to');">				
				<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="관리항목을 검색합니다" style="cursor:hand;position:relative;left:-4px;top:0px;" align=center onclick="ln_Popup('03','05to','','txt_fsrefnm05_to');">
				<input id="txt_fsrefcd05_to" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:60px; height:20px;" maxlength="7"    onkeydown="ln_Blur('03','fsref05_to','txt_fsrefcd05_to');" >
				<img SRC="../../Common/img/btn/com_b_clear.gif" BORDER="0" style="cursor:hand;position:relative;left:0px;top:0px" align=center onclick="ln_Clear('06');">
			  <!-- <img src="../../common/img/btn/com_b_choice.gif"		style="cursor:hand;position:relative;top:6px;left:0px" onClick="ln_Popup_Slip('01','')"> -->
				</nobr>
			</td> 	
		</tr>
		<tr>
			<td height=3  colspan =7> </td>
		</tr>
	</table>
	<table width="876px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td>
				<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp05  
				style="position:relative;left:0px;width:875px; height:177px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data05">
					<PARAM NAME="IndWidth"		VALUE ='0'>
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM NAME="Sortview"		VALUE="left">
					<param name="ColSizing"   value="true">
					<param name="Editable"    value="true">
					<param name="ViewSummary"	value=1>
					<PARAM NAME="Format"			VALUE="              
					<C> Name='전표번호'		 ID=SSNBR1    HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center	SumBgColor=#C3D0DB edit=none  sumText='합계'</C> 
					<C> Name='순번'		     ID=FSNUM     HeadAlign=Center HeadBgColor=#B9D4DC Width=28	    align=center	SumBgColor=#C3D0DB edit=none  </C> 
					<C> Name='차변'		     ID=CHAAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	    align=right	  SumBgColor=#C3D0DB edit=none  color=#0000FF  SumColor=#0000FF sumText=@sum </C> 
					<C> Name='대변'			   ID=DAEAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	    align=right	  SumBgColor=#C3D0DB edit=none  color=#FF0000  SumColor=#FF0000 sumText=@sum </C> 
					<C> Name='잔액'			   ID=JANAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	    align=right	  SumBgColor=#C3D0DB edit=none  sumText=@sum </C> 
					<C> Name='적요'			   ID=REMARK    HeadAlign=Center HeadBgColor=#B9D4DC Width=213	  align=left    SumBgColor=#C3D0DB sort=true edit=none  </C> 
					<C> Name='거래처'		   ID=VENDNM 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=120	  align=reft    SumBgColor=#C3D0DB sort=true edit=none </C> 
					<C> Name='관리항목'		 ID=FSREFNM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=120	  align=reft    SumBgColor=#C3D0DB sort=true edit=none </C> 
					">

				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
		</tr>
		<tr>
				<!--fieldset style="position:relative;left:0px;width:877px;height:5px;border:0 solid #708090;border-top-width:0px;border-bottom-width:0px;text-align:left;">
					&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
				</fieldset-->
			<td height=5  colspan=8> </td>
		</tr>
		<tr> 
			<td>
				<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp5_2  
				style="position:relative;left:0px;width:875px; height:177px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data05_2">
					<PARAM NAME="IndWidth"		VALUE ='0'>
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM NAME="Sortview"		VALUE="left">
					<param name="ColSizing"   value="true">
					<param name="Editable"    value="true">
					<param name="ViewSummary"	value=1>
					<PARAM NAME="Format"			VALUE="              
					<C> Name='전표번호'		    ID=SSDATNBR  HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center	 SumBgColor=#C3D0DB edit=none sumText='합 계'</C> 
					<C> Name='순번'		        ID=FSNUM	   HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center	 SumBgColor=#C3D0DB edit=none </C> 
					<C> Name='차변'		        ID=CHAAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=right	   SumBgColor=#C3D0DB edit=none   color=#0000FF  SumColor=#0000FF sumText=@sum  </C> 
					<C> Name='대변'			      ID=DAEAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=right	   SumBgColor=#C3D0DB edit=none   color=#FF0000  SumColor=#FF0000 sumText=@sum </C> 
					<C> Name='잔액'			      ID=JANAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=right    SumBgColor=#C3D0DB edit=none  sumText=@sum </C> 
					<C> Name='적요'		        ID=REMARK 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=213	  align=reft     SumBgColor=#C3D0DB edit=none </C> 
					<C> Name='거래처'		      ID=VENDNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=120	  align=reft     SumBgColor=#C3D0DB	edit=none </C> 
					<C> Name='관리항목'		    ID=FSREFNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=120	  align=reft     SumBgColor=#C3D0DB	edit=none </C> 
					">
				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
		</tr>
	</table>

</td>	
</tr>	
</table>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
