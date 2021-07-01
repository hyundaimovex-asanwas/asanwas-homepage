<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  회계관리 - 부동산 임대 공급가액 명세서
+ 프로그램 ID	:  a050020.jsp
+ 기 능 정 의	:  부동산 임대 공급가액 명세서 엑셀파일을 업로드 하여 
                              부동산 임대 공급가액 명세서  테이블에 저장하고, 이 데이터로 부터 
			      텍스트 파일을 생성하기 위해 내려받기 한다.
+ 작   성  자      :  정 영 식
+ 작성 일 자      :  2015.05.27
+ 서 블 릿 명	:  excel_upload_t3, a050020_s1, a050020_t1
-----------------------------------------------------------------------------
+ 수 정 내 용     :	         
+ 수   정  자      : 
+ 수 정 일 자     : 
+ 서 블 릿 명     :
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>부동산임대공급가액명세서</title>

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
var gs_hf_gb="";  //반기구분
var gs_hf_seq=""; //반기내순번



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
	gcem_saccyy.text    = gs_date2;	 //년도
	gclx_saccyyqt.index = 0;		 //기수

	//지점코드
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();
}

/******************************************************************************
	Description : 엑셀 적용 버튼 작업시 엑셀Data ==> Grid로 업로드 함               
******************************************************************************/
function ln_Excel_Apply(){
  	var s_temp = "";
	
	//데이터 초기화 ( 화면 Clear ) 
	gcds_head_a.clearAll();
	gcds_tail_b.clearAll();

   
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

	gctr_data_excel.KeyValue = "excel_upload_t3(I:USER=gcds_excel,O:USER2=gcds_excel_grid)";
	//gctr_data_excel.Action = g_servlet+"/Account.excel_upload_t2?";
	gctr_data_excel.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>excel_upload_t3?";
	gctr_data_excel.post();
	
}

/******************************************************************************************
	Description : 테이블 빈값지정
******************************************************************************************/
function ln_Upload_Grid(){
	var strFDCODE=gclx_fdcode.bindcolval;
	var strRD_GB="ED";
	var strYYYY=gcem_saccyy.text;
	var strCO_CRNO="2218113834";
	var strRD_SEQ_GB="1";
 
    //EHDT002 엑셀이외 DATA 입력 
	for(var i=1;i<=gcds_excel_grid.countrow;i++ ){
		gcds_excel_grid.namevalue(i,"FDCODE")=strFDCODE;
		gcds_excel_grid.namevalue(i,"RD_GB")=strRD_GB;
		gcds_excel_grid.namevalue(i,"YYYY")=strYYYY;
		gcds_excel_grid.namevalue(i,"HF_GB")=gs_hf_gb;
		gcds_excel_grid.namevalue(i,"HF_SEQ")=gs_hf_seq;
		gcds_excel_grid.namevalue(i,"CO_CRNO")=strCO_CRNO;
		gcds_excel_grid.namevalue(i,"RD_SEQ_GB")=strRD_SEQ_GB;
		gcds_excel_grid.namevalue(i,"RD_SEQ")=i;
		gcds_excel_grid.namevalue(i,"UND_YN")="";
		gcds_excel_grid.namevalue(i,"MINOR_NO")=gcem_s_bizplace.text;
	}

	//EHDT001 HEAD 테이블 입력값 셋팅
	ln_Head_Setting(strFDCODE,"EH",strYYYY,strCO_CRNO );

	//EHDT003 Tail 테이블 입력값 셋팅
    ln_Tail_Setting(strFDCODE,"ET",strYYYY,strCO_CRNO, strRD_SEQ_GB );
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
		gs_hf_gb ="1";
		gs_hf_seq="3";  //예정
	}else if(gisu=="2"){
		gs_frdt = yyyy+"0401";
		gs_todt = yyyy+"0630";
		gs_hf_gb ="1";
		gs_hf_seq="6";  //확정
	}else if(gisu=="3"){
		gs_frdt = yyyy+"0701";
		gs_todt = yyyy+"0930";
		gs_hf_gb ="2";
		gs_hf_seq="3";  //예정
	}else if(gisu=="4"){
		gs_frdt = yyyy+"1001";
		gs_todt = yyyy+"1231";
		gs_hf_gb ="2";
		gs_hf_seq="6";  //확정
	}
}

/******************************************************************************
	Description : Head(A,B 테이블) 설정  OK
******************************************************************************/
function ln_SetDataHeader(){
    var s_tmp1="";
	var s_tmp2="";
	var s_tmp3="";

	s_tmp1 = "FDCODE:STRING,RD_GB:STRING,YYYY:STRING,HF_GB:STRING,HF_SEQ:STRING,"
		   + "CO_CRNO:STRING,CO_NM:STRING,CO_RENM:STRING,CO_NO:STRING,CO_DT:STRING,"
		   + "PH_NO:STRING,SPACE:STRING,CREATE_ID:STRING,UPDATE_ID:STRING" ;
	gcds_head_a.SetDataHeader(s_tmp1);

	/** 이 데이터 셋은 gcds_excel_grid로 대체함 
	s_tmp2 = "FDCODE:STRING,RD_GB:STRING,YYYY:STRING,HF_GB:STRING,HF_SEQ:STRING,"
		   + "CO_CRNO:STRING,RD_SEQ_GB:DECIMAL,RD_SEQ:DECIMAL,FLOOR:STRING,FR_NO:STRING,"
		   + "AREA:DECIMAL,HI_NM:STRING,HI_CRNO:STRING,RE_IN_DT:STRING,RE_OUT_DT:STRING,"
		   + "RE_DEP_AMT:DECIMAL,RE_MON_AMT:DECIMAL,RE_SUM_AMT:DECIMAL,RE_DEP_INT_AMT:DECIMAL,RE_INCOME_AMT:DECIMAL,"
		   + "UND_YN:STRING,MINOR_NO:DECIMAL,COMPLEX:STRING,UP_DT:STRING,SPACE:STRING,"
		   + "CREATE_ID:STRING,UPDATE_ID:STRING";
	gcds_tail_b.SetDataHeader(s_tmp2);
	**/
	
	s_tmp3 = "FDCODE:STRING,RD_GB:STRING,YYYY:STRING,HF_GB:STRING,HF_SEQ:STRING,"
		   + "CO_CRNO:STRING,DATA_CNT:STRING,RD_SEQ_GB:STRING,RE_POSITION:STRING,RE_DEP_SUM:DECIMAL,"
		   + "RE_MON_SUM:DECIMAL,RE_SUM_SUM:DECIMAL,RE_DEP_INT_SUM:DECIMAL,RE_INCOME_SUM:DECIMAL,RE_CNT:DECIMAL,"
		   + "MINOR_NO:STRING,SPACE:STRING,CREATE_ID:STRING,UPDATE_ID:STRING" ;
	gcds_tail_b.SetDataHeader(s_tmp3);
 }


/******************************************************************************************
	Description : A 테이블 설정
	ln_Head_Setting(strFDCODE,"EH",strYYYY,strCO_CRNO );
******************************************************************************************/
function ln_Head_Setting(p1,p2,p3,p4){ 

	gcds_head_a.Addrow();
	gcds_head_a.namevalue(gcds_head_a.rowposition,"FDCODE")=p1;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"RD_GB")=p2;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"YYYY")=p3;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"HF_GB")=gs_hf_gb;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"HF_SEQ")=gs_hf_seq;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"CO_CRNO")=p4;
	gcds_head_a.namevalue(gcds_head_a.rowposition,"CO_NM")="현대아산 주식회사";
	gcds_head_a.namevalue(gcds_head_a.rowposition,"CO_RENM")="배국환";
	gcds_head_a.namevalue(gcds_head_a.rowposition,"CO_NO")="1401110011714";
	gcds_head_a.namevalue(gcds_head_a.rowposition,"CO_DT")=gs_date;
    gcds_head_a.namevalue(gcds_head_a.rowposition,"PH_NO")="0236693921";
	gcds_head_a.namevalue(gcds_head_a.rowposition,"SPACE")="";

}

/******************************************************************************************
	Description : B 테이블 설정
	ln_Tail_Setting(strFDCODE,"ET",strYYYY,strCO_CRNO, strRD_SEQ_GB );
******************************************************************************************/
function ln_Tail_Setting(p1,p2,p3,p4,p5){

	gcds_tail_b.Addrow();
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"FDCODE")=p1;
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"RD_GB")=p2;
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"YYYY")=p3;
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"HF_GB")=gs_hf_gb;
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"HF_SEQ")=gs_hf_seq;
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"CO_CRNO")=p4;
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"DATA_CNT")=gcds_excel_grid.countrow;           // 일단 한건으로 인식 ( 추후 확인해야함. )
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"RD_SEQ_GB")=p5;
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"RE_POSITION")="충성남도 홍성군 홍북면 충남대로 36 (빌앤더스오피스텔)";
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"RE_DEP_SUM")=gcds_excel_grid.sum(10,0,0);
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"RE_MON_SUM")=gcds_excel_grid.sum(11,0,0);
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"RE_SUM_SUM")=gcds_excel_grid.sum(12,0,0);
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"RE_DEP_INT_SUM")=gcds_excel_grid.sum(13,0,0);
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"RE_INCOME_SUM")=gcds_excel_grid.sum(14,0,0);
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"RE_CNT")=gcds_excel_grid.countrow;
	gcds_tail_b.namevalue(gcds_tail_b.rowposition,"MINOR_NO")=gcem_s_bizplace.text;
    gcds_tail_b.namevalue(gcds_tail_b.rowposition,"SPACE")="";
}

/******************************************************************************************
	Description : 부동산임대명세서 DB INSERT
*****************************************************************************************/
function ln_Create(){

	if(gcds_head_a.IsUpdated) {	
		if (confirm("부동산임대공급가액명세서  데이터를 생성 하시겠습니까?")){	
			//gctr_data.KeyValue = "Account.a050020_t1(I:USER=gcds_head_a,I:USER2=gcds_tail_b,I:USER3=gcds_excel_grid)";
			
			gctr_data.KeyValue = "Account.a050020_t11(I:USER=gcds_head_a,I:USER2=gcds_tail_b,I:USER3=gcds_excel_grid)";
			
			gctr_data.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050020_t11?";
			gctr_data.Parameters = "v_str1="+gs_userid;
			
			//prompt('gcds_head_a',gcds_head_a.text);
            //prompt('gcds_tail_b',gcds_tail_b.text);
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
	var str1 = gclx_fdcode.bindcolval;		//사업소
	var gisu = gclx_saccyyqt.BindColVal;	//기수
	var stryy = gcem_saccyy.text;			//년도

	if(gcem_saccyy.text==""){
		alert("년도를 입력하십시요.");
		return;
	}
	 
	if(gisu=="1"){
		stryymm=stryy+"03";
		gs_hf_gb ="1";
		gs_hf_seq="3";  //예정
	}else if(gisu=="2"){
    	stryymm=stryy+"06";
    	gs_hf_gb ="1";
		gs_hf_seq="6";  //확정
	}else if(gisu=="3"){
    	stryymm=stryy+"09";
    	gs_hf_gb ="2";
		gs_hf_seq="3";  //예정
	}else if(gisu=="4"){
		stryymm=stryy+"12";
		gs_hf_gb ="2";
		gs_hf_seq="6";  //확정
	}

	//데이터 있는지 조회....있으면...그것 조회 없으면 생성해서 보여줌..
	//head Record
	gcds_head_a.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050020_s1?v_str1="+str1+"&v_str2="+stryy+"&v_str3="+gs_hf_gb +"&v_str4="+gs_hf_seq;																																
	gcds_head_a.Reset();

	//tail Record
	gcds_tail_b.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050020_s2?v_str1="+str1+"&v_str2="+stryy+"&v_str3="+gs_hf_gb +"&v_str4="+gs_hf_seq;		
	gcds_tail_b.Reset();

	//data Recode 
    gcds_excel_grid.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050020_s3?v_str1="+str1+"&v_str2="+stryy+"&v_str3="+gs_hf_gb +"&v_str4="+gs_hf_seq;		
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
  var strfilenm = "E2218113834.V120";
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
	var str1 = gclx_fdcode.bindcolval;		//지점
	var gisu = gclx_saccyyqt.BindColVal;	//기수
	var stryy = gcem_saccyy.text;			//년도
	var stryymm="";


	if(gcem_saccyy.text==""){
		alert("년도를 입력하십시요.");
		return;
	}

	if(gisu=="1"){
		stryymm=stryy+"03";
		gs_hf_gb ="1";
		gs_hf_seq="3";  //예정
	}else if(gisu=="2"){
        stryymm=stryy+"06";
        gs_hf_gb ="1";
		gs_hf_seq="6";  //확정
	}else if(gisu=="3"){
        stryymm=stryy+"09";
        gs_hf_gb ="2";
		gs_hf_seq="3";  //예정
	}else if(gisu=="4"){
		stryymm=stryy+"12";
		gs_hf_gb ="2";
		gs_hf_seq="6";  //확정
	}

    gcds_data99.clearAll();
	var s_temp = "DISKET:STRING";
	gcds_data99.SetDataHeader(s_temp);


	//데이터 있는지 조회....있으면...그것 조회 없으면 생성해서 보여줌..

	//HEADER A(1건)
	gcds_down_head.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050020_s1?v_str1="+str1+"&v_str2="+stryy+"&v_str3="+gs_hf_gb +"&v_str4="+gs_hf_seq;	
	gcds_down_head.Reset();

	//TAIL SUM B(1건)
	gcds_down_tail.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050020_s2?v_str1="+str1+"&v_str2="+stryy+"&v_str3="+gs_hf_gb +"&v_str4="+gs_hf_seq;	
	gcds_down_tail.Reset();

    //DATA(N개)
	gcds_down_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050020_s3?v_str1="+str1+"&v_str2="+stryy+"&v_str3="+gs_hf_gb +"&v_str4="+gs_hf_seq;	
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
  
  for(i=1;i<=gcds_down_data.countrow;i++){
    ln_Forward_Batch_data(i);
  }

  for(i=1;i<=gcds_down_tail.countrow;i++){
    ln_Forward_Batch_tail(i);
  }
}

/******************************************************************************
	Description : head
******************************************************************************/
function ln_Forward_Batch_head(i){
	var DISKET = "";
	DISKET+=strStr(gcds_down_head.namevalue(i,"RD_GB")   ,"2");    //레코득구분
	DISKET+=strStr(gcds_down_head.namevalue(i,"YYYY")    ,"4");    //귀속년도
	DISKET+=strStr(gcds_down_head.namevalue(i,"HF_GB")   ,"1");    //반기구분
	DISKET+=strStr(gcds_down_head.namevalue(i,"HF_SEQ")  ,"1");    //반기내월순번
	DISKET+=strStr(gcds_down_head.namevalue(i,"CO_CRNO") ,"10");   //제출자사업자등록번호
	DISKET+=strStr(gcds_down_head.namevalue(i,"CO_NM")   ,"60");   //상호(법인명)
	DISKET+=strStr(gcds_down_head.namevalue(i,"CO_RENM") ,"30");   //성명(대표자)
	DISKET+=strStr(gcds_down_head.namevalue(i,"CO_NO")   ,"13");   //법인등록번호
	DISKET+=strStr(gcds_down_head.namevalue(i,"CO_DT")   ,"8");    //제출일자
	DISKET+=strStr(gcds_down_head.namevalue(i,"PH_NO")   ,"12");   //제출자전화번호
	DISKET+=strStr(gcds_down_head.namevalue(i,"SPACE")   ,"109");  //공란

	gcds_data99.addrow();
	gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}

/******************************************************************************
Description :
             
******************************************************************************/
function ln_Forward_Batch_data(i){
	var DISKET = "";
	
	DISKET+=strStr(gcds_down_data.namevalue(i,"RD_GB")         ,"2");    //레코득구분
	DISKET+=strStr(gcds_down_data.namevalue(i,"YYYY")          ,"4");    //귀속년도
	DISKET+=strStr(gcds_down_data.namevalue(i,"HF_GB")         ,"1");    //반기구분
	DISKET+=strStr(gcds_down_data.namevalue(i,"HF_SEQ")        ,"1");    //반기내월순번
	DISKET+=strStr(gcds_down_data.namevalue(i,"CO_CRNO")       ,"10");   //제출자사업자등록번호  
	DISKET+=intStr(gcds_down_data.namevalue(i,"RD_SEQ_GB")     ,"6");    //일련번호구분
	DISKET+=intStr(gcds_down_data.namevalue(i,"RD_SEQ")        ,"6");    //일련번호
	DISKET+=strStr(gcds_down_data.namevalue(i,"FLOOR")         ,"10");   //층
	DISKET+=strStr(gcds_down_data.namevalue(i,"FR_NO")         ,"10");   //호수
	DISKET+=strStr(gcds_down_data.namevalue(i,"AREA")          ,"10");   //면적
	DISKET+=strStr(gcds_down_data.namevalue(i,"HI_NM")         ,"30");   //임차인상호(성명)
	DISKET+=strStr(gcds_down_data.namevalue(i,"HI_CRNO")       ,"13");   //임차인사업자등록번호
	DISKET+=strStr(gcds_down_data.namevalue(i,"RE_IN_DT")      ,"8");    //임대계약입주일
	DISKET+=strStr(gcds_down_data.namevalue(i,"RE_OUT_DT")     ,"8");    //임대계약퇴거일
	DISKET+=intStr(gcds_down_data.namevalue(i,"RE_DEP_AMT")    ,"13");   //임대계약내용보증금
	DISKET+=intStr(gcds_down_data.namevalue(i,"RE_MON_AMT")    ,"13");   //임대계약내용월임대료
	DISKET+=intStr(gcds_down_data.namevalue(i,"RE_SUM_AMT")    ,"13");   //임대료수입금액계(과세표준)
	DISKET+=intStr(gcds_down_data.namevalue(i,"RE_DEP_INT_AMT"),"13");   //임대료보증금이자
	DISKET+=intStr(gcds_down_data.namevalue(i,"RE_INCOME_AMT") ,"13");   //임대료수입금월임대료
	DISKET+=strStr(gcds_down_data.namevalue(i,"UND_YN")        ,"1");    //지하여부
	DISKET+=intStr(gcds_down_data.namevalue(i,"MINOR_NO")      ,"4");    //종사업자일련번호
	DISKET+=strStr(gcds_down_data.namevalue(i,"COMPLEX")       ,"20");   //동
	DISKET+=strStr(gcds_down_data.namevalue(i,"UP_DT")         ,"8");    //갱신일
	DISKET+=strStr(gcds_down_data.namevalue(i,"SPACE")         ,"33");   //공란
	 
	gcds_data99.addrow();
	gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Forward_Batch_tail(i){
 
 	var DISKET = "";
 
 	DISKET+=strStr(gcds_down_tail.namevalue(i,"RD_GB")         ,"2");    //레코득구분
	DISKET+=strStr(gcds_down_tail.namevalue(i,"YYYY")          ,"4");    //귀속년도
	DISKET+=intStr(gcds_down_tail.namevalue(i,"HF_GB")         ,"1");    //반기구분
	DISKET+=intStr(gcds_down_tail.namevalue(i,"HF_SEQ")        ,"1");    //반기내월순번
	DISKET+=strStr(gcds_down_tail.namevalue(i,"CO_CRNO")       ,"10");   //제출자사업자등록번호  
	DISKET+=intStr(gcds_down_tail.namevalue(i,"DATA_CNT")      ,"7");    //Data건수
	DISKET+=intStr(gcds_down_tail.namevalue(i,"RD_SEQ_GB")     ,"6");    //일련번호구분
    DISKET+=strStr(gcds_down_tail.namevalue(i,"RE_POSITION")   ,"70");   //부동산소재지
	DISKET+=intStr(gcds_down_tail.namevalue(i,"RE_DEP_SUM")    ,"15");   //임대계약내용보증금합계
	DISKET+=intStr(gcds_down_tail.namevalue(i,"RE_MON_SUM")    ,"15");   //임대계약내용월세등합계
    DISKET+=intStr(gcds_down_tail.namevalue(i,"RE_SUM_SUM")    ,"15");   //임대료수입금액합계
	DISKET+=intStr(gcds_down_tail.namevalue(i,"RE_DEP_INT_SUM"),"15");   //입대료수입보증금이자합계
	DISKET+=intStr(gcds_down_tail.namevalue(i,"RE_INCOME_SUM") ,"15");   //임대료수입월세등합계
	DISKET+=intStr(gcds_down_tail.namevalue(i,"RE_CNT")        ,"6");    //임대건수
	DISKET+=intStr(gcds_down_tail.namevalue(i,"MINOR_NO")      ,"4");    //종사업자일련번호
	DISKET+=strStr(gcds_down_tail.namevalue(i,"SPACE")         ,"64");   //공란

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
	var alength=tmpa.length;
	 
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
  
	var alength=tmpa.length;
	splitString = tmpa.split('.');
	
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
 
  	var tmpa = new String(a);
  	var alength=tmpa.length;
  
 	splitString = tmpa.split('.');
  
  
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

	gcgd_disp01.GridToExcel("부동산임대공급가액명세서","",2);
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

<!--엑셀 -->
<object  id=gcds_excel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--엑셀업로드 후 그리드 DATA -->
<object  id=gcds_excel_grid classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--그리드 Data를 Table에 insert HEAD -->
<object  id=gcds_head_a classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--그리드 Data를 Table에 insert Tail -->
<object  id=gcds_tail_b classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--변환파일 내려받기 -->
<object  id=gcds_data99 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_down_head classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_down_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_down_tail classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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


<script language="javascript" for="gcds_head_a" event="onloadCompleted(row,colid)">
	//alert("gcds_head_a:row:"+row);
</script>

<script language="javascript" for="gcds_tail_b" event="onloadCompleted(row,colid)">
	//alert("gcds_tail_b:row:"+row);
</script>

<script language="javascript" for="gcds_excel_grid" event="onloadCompleted(row,colid)">
	//alert("gcds_excel_grid:row:"+row);
</script>

<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	
	gclx_fdcode.index =1;
	gclx_cocode.index =0;
	gcem_s_bizplace.text ="0003";
	
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcip_file" event=OnClick()>
	if (fn_trim(gcip_file.value)!="") {		
		file_path.value = gcip_file.value;
	}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("데이터 생성이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("데이터 생성이 성공적으로 완료되지 못했습니다.");
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
<table width="950" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr><td height=20></td></tr>
</table>

<!--  ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="2px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table  cellpadding="0" cellspacing="0" style="width:950px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr width="950px"> 
					<td width="100px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>엑셀파일</nobr></td>
					<td class="tab18" ><nobr>&nbsp;
							<input type="text" name="file_path" value="" style="width:630px;position:relative;top:-2px" >&nbsp;
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
			<table cellpadding="1" cellspacing="0" border="0" style='width:950px;height:20px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>지점</nobr></td>
					<td class="tab23" style="width:90px">
						<comment id="__NSID__"><object         id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:1px;font-size:12px;width:70px;height:200px;">
							    <param name=ComboDataID			value="gcds_fdcode">
								<param name=CBDataColumns		value="FDCODE,FDNAME">
								<param name=SearchColumn		value="FDNAME">
								<param name=Sort				value=false>
								<param name=Enable				value=false>
								<param name=ListExprFormat	    value="FDNAME^0^70">
								<param name=BindColumn			value="FDCODE">

							</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>사업장</nobr></td>
					<td class="tab23" style="width:190px">
						<comment id="__NSID__"><object          id=gclx_cocode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:5px;top:1px;font-size:12px;width:50px;height:200px;">
								<param name=CBData				value="04^홍성">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=Enable				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^70">
								<param name=BindColumn			value="CDCODE">
							</object>
							<font color="" style="position:relative;left:5px;top:-5px;" >종사업장</font>
							<object  id=gcem_s_bizplace classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:35px;height:20px;position:relative;left:10px;top:2px">		
								<param name=Text		  value="0003">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>년&nbsp;도</nobr></td>
					<td class="tab23" style="width:60px"><comment id="__NSID__">
						<object id=gcem_saccyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px;width:35px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>분기수</nobr></td>
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
					<table cellpadding="1" cellspacing="0" border="0" style='width:950px;height:30px;border:1 solid #708090'>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>상호(법인명)</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object id=gcem_co_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:230px">
									<param name=Text			value="">
									<param name=Alignment		value=0>
									<param name=Border			value=true>
									<param name=GeneralEdit     value="true">
									<param name=Language		value=1>
									<param name=ReadOnly        value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>사업자등록번호</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_co_crno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:110px;height:20px;position:relative;left:5px;top:0px">		
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
								<object id=gcem_co_renm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:230px">
									<param name=Text			value="">
									<param name=Alignment		value=0>
									<param name=Border			value=true>
									<param name=GeneralEdit     value="true">
									<param name=Language		value=1>
									<param name=ReadOnly        value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>법인등록번호</nobr></td>
							<td style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_co_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:110px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text		  value="">
									<param name=Border        value=true>
									<param name=PromptChar	  value="_">
									<param name=Format		  value="000000-0000000">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language	  value=1>
									<param name=ReadOnly      value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr><!-- 매입2 ----------------------------------------------------------------------------------------->
				<td style="position:relative;left:6px;top:2px">
					<table cellpadding="1" cellspacing="0" border="0" style='width:950px;height:30px;border:1 solid #708090'>
						
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr><td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:948px;HEIGHT:335px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_excel_grid">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name=SortView        value="Left">
							<PARAM NAME="viewSummary"	VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<C> Name='일련번호'	    ID=RD_SEQ	        HeadAlign=Center HeadBgColor=#B9D4DC Width=55	   	align=center	SumBgColor='#C3D0DB' SumText=@count	 </C> 
								<C> Name='동'  	        ID=COMPLEX 	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30   	align=center	SumBgColor='#C3D0DB' SumText='계'	 </C>
								<C> Name='층'     	    ID=FLOOR  	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center	SumBgColor='#C3D0DB' SumText=''	     </C>
								<C> Name='호수'	        ID=FR_NO		    HeadAlign=Center HeadBgColor=#B9D4DC Width=30   	align=center	SumBgColor='#C3D0DB' </C>
								<C> Name='임대\\면적'	    ID=AREA  		    HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	SumBgColor='#C3D0DB' </C>
							  <G> Name='임차인 인적사항 및 임대차 계약내용 '          HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='상호'	    	ID=HI_NM 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=left		SumBgColor='#C3D0DB' SumText=''	 </C>
								<C> Name='사업자등록번호'	ID=HI_CRNO		    HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=center	SumBgColor='#C3D0DB' SumText=''	 mask='XXX-XX-XXXXXX' </C>
								<C> Name='입주일'   	    ID=RE_IN_DT	        HeadAlign=Center HeadBgColor=#B9D4DC Width=70 		align=center	SumBgColor='#C3D0DB' SumText=''	 mask='XXXX-XX-XX' </C>
								<C> Name='갱신일'     	ID=UP_DT            HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	    align=center	SumBgColor='#C3D0DB' SumText=''	 mask='XXXX-XX-XX' </C>
								<C> Name='퇴거일'     	ID=RE_OUT_DT        HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	    align=center	SumBgColor='#C3D0DB' SumText=''	 mask='XXXX-XX-XX' </C>
								<C> Name='보증금'	    	ID=RE_DEP_AMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumBgColor='#C3D0DB' SumText=@sum	 </C>
								<C> Name='월임대료'	    ID=RE_MON_AMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumBgColor='#C3D0DB' SumText=@sum	 </C>
							  </G>
							  <G> Name='임대수입금액(과세표준) '       HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='합계'	    	ID=RE_SUM_AMT 		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumBgColor='#C3D0DB' SumText=@sum	 </C>
								<C> Name='보증금이자계'	ID=RE_DEP_INT_AMT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumBgColor='#C3D0DB' SumText=@sum	 </C>
								<C> Name='월임대료계'	    ID=RE_INCOME_AMT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumBgColor='#C3D0DB' SumText=@sum	 </C>
							  </G>	
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:950px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
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
						<OBJECT id=gcgd_data01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="width:948px;height:220px;position:relative;left:5px;border:1 solid #777777;">
							<PARAM NAME="DataID"			VALUE="gcds_data99">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<param name="ColSelect"		value="false">
							<param name="ColSizing"		value="true">
							<PARAM NAME="Format"			VALUE="  
								<C> Name=''	ID=DISKET	HeadAlign=Center HeadBgColor=#B9D4DC Width=920	align=left</C>
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
		<C>Col=CO_NM			Ctrl=gcem_co_nm				Param=text</C>
		<C>Col=CO_CRNO			Ctrl=gcem_co_crno	    	Param=text</C>
		<C>Col=CO_RENM	        Ctrl=gcem_co_renm			Param=text</C>
		<C>Col=CO_NO	        Ctrl=gcem_co_no   			Param=text</C>
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