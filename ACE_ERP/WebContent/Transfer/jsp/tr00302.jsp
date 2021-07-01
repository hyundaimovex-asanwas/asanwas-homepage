<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:  출입계획관리 - 출입계획관리		
+ 프로그램 ID	:  TR00302.html
+ 기 능 정 의	:  출입계획관리를 조회, 저장, 삭제하는 화면이다
+ 작   성  자 :  이민정
+ 작성일자 :
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 :
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 :
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="transfer.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 및 기타 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());
%>


<!-- HTML 시작-->
<html>
	<head>
   <jsp:include page="/Transfer/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script 시작
=============================================================================*/
%>


<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
		var gacc_no="";
		var gs_sdate="";
		var gs_stime="";
		var gs_rdate="";
		var gs_rtime="";
		
		
		var gs_la="";
		var gs_accsectioni="I";
		var gs_accsectiono="O";
		var gs_tabindex = 1;
		
		get_cookdata();

		var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
		var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
		var gs_userid = gusrid;
		var gs_hisdat = gs_date;
		var gs_date01 = gcurdate.substring(0,4) + "." +gcurdate.substring(5,7) + "." +gcurdate.substring(8,10);
		var gs_date03 = gcurdate.substring(0,4) + "년" +gcurdate.substring(5,7) + "월" +gcurdate.substring(8,10)+"일";
		
		var now = new Date();
		/* getDay()는 요일정보를 가져온다. 
		요일별로 일=0, 월=1, 화=2, 수=3, 목=4, 금=5, 토=6와 같이 지정되어 있다. */
		var myday = now.getDay();
		
		var strtxt = "";
		
		strtxt += now.getYear() +"년 ";
		strtxt += now.getMonth()+1 +"월 ";
		strtxt += now.getDate() +"일 ";
		
		switch (myday) {
		 case 0 : strtxt += "(일요일)";
		  break;
		 case 1 : strtxt += "(월요일)";
		  break;
		 case 2 : strtxt += "(화요일)";
		  break;
		 case 3 : strtxt += "(수요일)";
		  break;
		 case 4 : strtxt += "(목요일)";
		  break;
		 case 5 : strtxt += "(금요일)";
		  break;
		 case 6 : strtxt += "(토요일)";
		  break;}


	/*----------------------------------------------------------------------------
	 * 페이지로딩
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]

			ln_Start();//선조회

			window.status="완료";

		}


/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){

		ln_Before();
		ln_Enable("f");
		GetParam();
}

/******************************************************************************
	Description : 선 조회
******************************************************************************/
function ln_Before() {


	//프로젝트[검색]
	gcds_project_cd.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0002"; 
	gcds_project_cd.Reset();
	
	//물류비 부담[검색]
	gcds_project.DataID = "<%=dirPath%>/servlet/Account.commdtil_s1?v_str1=0030";  
	gcds_project.Reset();

	//출경목적지[검색]
	gcds_sreach_ciq.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  
	gcds_sreach_ciq.Reset();

	//입경목적지[검색]
	gcds_rreach_ciq.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  
	gcds_rreach_ciq.Reset();

	//소속[검색]
	gcds_prsn_cmpy.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0015";  
	gcds_prsn_cmpy.Reset();

	//소속[검색]
	gcds_prsn_cmpy04.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0015";  
	gcds_prsn_cmpy04.Reset();

	//차종[검색]
	gcds_car_type.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00512_s1?NOH=Y";  
	gcds_car_type.Reset();

	 //차종[검색]
	gcds_car_type03.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00512_s1?NOH=Y";  
	gcds_car_type03.Reset();
	
	 //운전자명[검색]
	gcds_person_no.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00302_popup_s2?v_str1=";  
	gcds_person_no.Reset();

	//운전자명[검색]
	gcds_person_no03.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00302_popup_s2?v_str1=";  
	gcds_person_no03.Reset();

	//출경-인원(남-->북) 
	gcds_acc_area_a.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  
	gcds_acc_area_a.Reset();

  //입경-인원(북-->남)
	gcds_acc_area_b.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  
	gcds_acc_area_b.Reset();

	//지역[통행개요-출경]
	gcds_project_cd_a.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0004"; 
	gcds_project_cd_a.Reset();

	//지역[통행개요-입경]
	gcds_project_cd_b.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0004"; 
	gcds_project_cd_b.Reset();

	//통행개요[출경]
	gcds_acc_area_aa.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  
	gcds_acc_area_aa.Reset();

	//통행개요[입경]
	gcds_acc_area_bb.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  
	gcds_acc_area_bb.Reset();

}

function GetParam(){

	if(location.search){ //주소중 파라메터 부분이 있으면,
	   	
	   var str0=location.search.split("&")[0]; //첫번째 파라메터를 str0에 담고
	   
	   var str1=location.search.split("&")[1]; //2번째 파라메터를 str1에 담고
	   
	   var str2=location.search.split("&")[2]; //3번째 파라메터를 str2에 담고
  
		gacc_no=str0.substring(6,16);
		
		gcem_accessno.text=gacc_no;
		
		gs_sdate=str1;

		gs_stime=str1.substring(10,16);

		gs_rdate=str2;

		gs_rtime=str2.substring(10,16);

		ln_Query();
	
		}
}

/******************************************************************************
	Description : 조회(출경차량)
******************************************************************************/
function ln_Query(){ 

	var str1 = gclx_project_cd.BindColVal;           //프로젝트
	var str2 = gclx_project.BindColVal;              //물류비 부담
	var str3 = gcem_acc_date_fr.text;                //출경일자 from
	var str4 = gcem_acc_date_to.text;                //출경일자 to
	var str5 = gcem_rtrn_date_fr.text;				 //입경일자 from
	var str6 = gcem_rtrn_date_to.text;				 //입경일자 to
	var str7 = gclx_sreach_ciq.BindColVal;			 //출경목적지
	var str8 = gclx_rreach_ciq.BindColVal;			 //입경목적지
	var str9 = gcem_accessno.text;					 //출입번호
	
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00302_s1"
									  + "?v_str1="+str1+"&v_str2="+str2
									  + "&v_str3="+str3+"&v_str4="+str4
									  + "&v_str5="+str5+"&v_str6="+str6
									  + "&v_str7="+str7+"&v_str8="+str8
									  + "&v_str9="+str9;

	ln_Enable("f");
	if(ln_Chk()){
	
	gcds_code01.Reset(); 

	}
}

/******************************************************************************
	Description : 조회(출경인원)
******************************************************************************/
function ln_Query02(){ 

	var str1 = gclx_project_cd.BindColVal;           //프로젝트
	var str2 = gclx_project.BindColVal;              //물류비 부담
	var str3 = gcem_acc_date_fr.text;                //출경일자 from
	var str4 = gcem_acc_date_to.text;                //출경일자 to
	var str5 = gcem_rtrn_date_fr.text;				 //입경일자 from
	var str6 = gcem_rtrn_date_to.text;				 //입경일자 to
	var str7 = gclx_sreach_ciq.BindColVal;			 //출경목적지
	var str8 = gclx_rreach_ciq.BindColVal;			 //입경목적지
	var str9 = gcem_accessno.text;					 //출입번호
	 
	gcds_code02.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00302_s2"
									  + "?v_str1="+str1+"&v_str2="+str2
									  + "&v_str3="+str3+"&v_str4="+str4
									  + "&v_str5="+str5+"&v_str6="+str6
									  + "&v_str7="+str7+"&v_str8="+str8
									  + "&v_str9="+str9;

	gcds_person.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsTotal_s1?v_str1="+str9;  
	gcds_person.Reset();
	
	gcds_car.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsCarTotal_s1?v_str1="+str9;  
	gcds_car.Reset();

	gcds_personn.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsTotal_s2?v_str1="+str9;  
	gcds_personn.Reset();
	
	gcds_carr.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsCarTotal_s2?v_str1="+str9;  
	gcds_carr.Reset();

	ln_Enable("f");

	gcds_code02.Reset(); 

	
}

/******************************************************************************
	Description : 조회(입경차량)
******************************************************************************/
function ln_Query03(){ 

	var str1 = gclx_project_cd.BindColVal;           //프로젝트
	var str2 = gclx_project.BindColVal;              //물류비 부담
	var str3 = gcem_acc_date_fr.text;                //출경일자 from
	var str4 = gcem_acc_date_to.text;                //출경일자 to
	var str5 = gcem_rtrn_date_fr.text;				 //입경일자 from
	var str6 = gcem_rtrn_date_to.text;				 //입경일자 to
	var str7 = gclx_sreach_ciq.BindColVal;			 //출경목적지
	var str8 = gclx_rreach_ciq.BindColVal;			 //입경목적지
	var str9 = gcem_accessno.text;					 //출입번호
		
	gcds_code03.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00302_s3"
									  + "?v_str1="+str1+"&v_str2="+str2
									  + "&v_str3="+str3+"&v_str4="+str4
									  + "&v_str5="+str5+"&v_str6="+str6
									  + "&v_str7="+str7+"&v_str8="+str8
									  + "&v_str9="+str9;

ln_Enable("f");
	
if(ln_Chk()){
	gcds_code03.Reset(); 

	}
}

/******************************************************************************
	Description : 조회(입경인원)
******************************************************************************/
function ln_Query04(){ 

	var str1 = gclx_project_cd.BindColVal;           //프로젝트
	var str2 = gclx_project.BindColVal;              //물류비 부담
	var str3 = gcem_acc_date_fr.text;                //출경일자 from
	var str4 = gcem_acc_date_to.text;                //출경일자 to
	var str5 = gcem_rtrn_date_fr.text;				 //입경일자 from
	var str6 = gcem_rtrn_date_to.text;				 //입경일자 to
	var str7 = gclx_sreach_ciq.BindColVal;			 //출경목적지
	var str8 = gclx_rreach_ciq.BindColVal;			 //입경목적지
	var str9 = gcem_accessno.text;					 //출입번호
		
	gcds_code04.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00302_s4"
									  + "?v_str1="+str1+"&v_str2="+str2
									  + "&v_str3="+str3+"&v_str4="+str4
									  + "&v_str5="+str5+"&v_str6="+str6
									  + "&v_str7="+str7+"&v_str8="+str8
									  + "&v_str9="+str9;
ln_Enable("f");

if(ln_Chk()){
	gcds_code04.Reset(); 
	//prompt("",gcds_code04.DataID )
	}
}

/******************************************************************************
	Description : 조회(입경인원)
******************************************************************************/
function ln_Query05(){ 

	var str1 = gclx_project_cd.BindColVal;           //프로젝트
	var str2 = gclx_project.BindColVal;              //물류비 부담
	var str3 = gcem_acc_date_fr.text;                //출경일자 from
	var str4 = gcem_acc_date_to.text;                //출경일자 to
	var str5 = gcem_rtrn_date_fr.text;				 //입경일자 from
	var str6 = gcem_rtrn_date_to.text;				 //입경일자 to
	var str7 = gclx_sreach_ciq.BindColVal;			 //출경목적지
	var str8 = gclx_rreach_ciq.BindColVal;			 //입경목적지
	var str9 = gcem_accessno.text;					 //출입번호
 	
	gcds_code05.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00302_s5"
									  + "?v_str1="+str1+"&v_str2="+str2
									  + "&v_str3="+str3+"&v_str4="+str4
									  + "&v_str5="+str5+"&v_str6="+str6
										+ "&v_str7="+str7+"&v_str8="+str8
										+ "&v_str9="+str9;

if(ln_Chk()){
	gcds_code05.Reset(); 
	//prompt("",gcds_code05.DataID )
	}	
}
/******************************************************************************
	Description : 등록
******************************************************************************/
function ln_Add(){

	gcds_code01.addrow();
	
	ln_Enable("t");
	
	gcem_start_date.text = gs_sdate;
	gcem_start_time.text = gs_stime;
	
	
	//gcds_code01.ClearData();
}

/******************************************************************************
	Description : 등록
******************************************************************************/
function ln_Add02(){

	gcds_code02.addrow();
	ln_Enable("t");
	gclx_drive.index = 1 ; 

	gcem_start_date02.text = gs_sdate;
	gcem_start_time02.text = gs_stime;

	
}

/******************************************************************************
	Description : 등록
******************************************************************************/
function ln_Add03(){

	gcds_code03.addrow();
	ln_Enable("t");

	gcem_rtrn_date03.text = gs_rdate;
	gcem_rtrn_time03.text = gs_rtime;

	//gs_rdate=str2;

}

/******************************************************************************
	Description : 등록
******************************************************************************/
function ln_Add04(){

	gcds_code04.addrow();
	ln_Enable("t");
	gclx_drive04.index = 1 ; 

	gcem_rtrn_date04.text = gs_rdate;
	gcem_rtrn_time04.text = gs_rtime;

}

/******************************************************************************
	Description : 저장(출경차량)
******************************************************************************/
function ln_Save(){

if (gcds_code01.IsUpdated){
		
		 if (gcds_code01.RowStatus(gcds_code01.rowposition) == "1" ){
				var seq= txt_seq.value;
				var sumValue = Number(seq)+ 1;

				gcds_code01.namevalue(gcds_code01.rowposition,"ACCSECTION") = gs_accsectiono;
				gcds_code01.namevalue(gcds_code01.rowposition,"ACCESS_NO") = gcem_accessno.text;
				gcds_code01.namevalue(gcds_code01.rowposition,"SEQ_NO") = sumValue;
								
		}

		if (gcds_code01.IsUpdated){
				if(ln_Chk('01')){
		//prompt('',gcds_code01.Text) ;
				if (confirm("저장하시겠습니까?")){	
					//if(ln_Chk('01')){

					gctr_code01.Action = g_servlet+"/Transfer.tr00302_t1?";
					gctr_code01.Parameters = "v_str1=" + gs_userid +",v_str2=" + gs_userid + ",v_str3=" ; txt_prsn_name.value;		
					gctr_code01.post();
			}
	}
}

}
}

/******************************************************************************
	Description : 저장(출경인원)
******************************************************************************/
function ln_Save02(){

if (gcds_code02.IsUpdated){
		
		 if (gcds_code02.RowStatus(gcds_code02.rowposition) == "1" ){
				var seq= txt_seq02.value;
				var sumValue = Number(seq)+ 1;

				gcds_code02.namevalue(gcds_code02.rowposition,"ACCSECTION") = gs_accsectiono;
				gcds_code02.namevalue(gcds_code02.rowposition,"ACCESSNO") = gcem_accessno.text;
				gcds_code02.namevalue(gcds_code02.rowposition,"SEQ_NO") = sumValue;
		}

		if (gcds_code02.IsUpdated){
				if(ln_Chk('02')){

//prompt('',gcds_code02.Text) ; 
				if (confirm("저장하시겠습니까?")){	
					//prompt('',gcds_code02.Text) ; 
					gctr_code02.Action = g_servlet+"/Transfer.tr00302_t2?";
					gctr_code02.Parameters = "v_str1=" + gs_userid +",v_str2=" + gs_userid;		
					gctr_code02.post();
				}
			}
		}
	}
}

/******************************************************************************
	Description : 저장(출경인원)
******************************************************************************/
function ln_Save03(){

if (gcds_code03.IsUpdated){

		 if (gcds_code03.RowStatus(gcds_code03.rowposition) == "1" ){
				var seq= txt_seq03.value;
				var sumValue = Number(seq)+ 1;

				gcds_code03.namevalue(gcds_code03.rowposition,"ACCSECTION") = gs_accsectioni;
				gcds_code03.namevalue(gcds_code03.rowposition,"ACCESS_NO") = gcem_accessno.text;
				gcds_code03.namevalue(gcds_code03.rowposition,"SEQ_NO") = sumValue;
		}

		if (gcds_code03.IsUpdated){
				if(ln_Chk('03')){
		
				if (confirm("저장하시겠습니까?")){	
					//prompt('',gcds_code03.Text) ; 
					gctr_code03.Action = g_servlet+"/Transfer.tr00302_t3?";
					gctr_code03.Parameters = "v_str1=" + gs_userid +",v_str2=" + gs_userid + ",v_str3=" ; txt_prsn_name03.value;		
					gctr_code03.post();
	
			}
		}
}
}
}


/******************************************************************************
	Description : 저장(출경인원)
******************************************************************************/
function ln_Save04(){

if (gcds_code04.IsUpdated){

	if (gcds_code04.RowStatus(gcds_code04.rowposition) == "1" ){

				var seq= txt_seq04.value;
				var sumValue = Number(seq)+ 1;

				gcds_code04.namevalue(gcds_code04.rowposition,"ACCSECTION") = gs_accsectioni;
				gcds_code04.namevalue(gcds_code04.rowposition,"ACCESSNO") = gcem_accessno.text;
				gcds_code04.namevalue(gcds_code04.rowposition,"SEQ_NO") = sumValue;

	}	

		if (gcds_code04.IsUpdated){
			if(ln_Chk('04')){
				if (confirm("저장하시겠습니까?")){	
//	prompt('',gcds_code04.Text) ; 
					gctr_code04.Action = g_servlet+"/Transfer.tr00302_t4?";
					gctr_code04.Parameters = "v_str1=" + gs_userid +",v_str2=" + gs_userid;		
					gctr_code04.post();
				}
			}
		}
	}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){

	if (gcds_code01.RowStatus(gcds_code01.rowposition) == "1" ){
//alert("!!");
 gcds_code01.Undo(gcds_code01.RowPosition);
 }

	else if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_code01.deleterow(gcds_code01.rowposition);
		gctr_code01.KeyValue = "tr00302_t1(I:USER=gcds_code01)";
		gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00302_t1";
		gctr_code01.post();
	
	}
}


/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete02(){

if (gcds_code02.RowStatus(gcds_code02.rowposition) == "1" ){

//alert("!!");
gcds_code02.Undo(gcds_code02.RowPosition);

} else if (gcds_code02.namevalue(gcds_code02.rowposition,"DRIVE_DIV")=="N"){
	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_code02.deleterow(gcds_code02.rowposition);
		gctr_code02.KeyValue = "tr00302_t2(I:USER=gcds_code02)";
  	gctr_code02.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00302_t2";
  	gctr_code02.post();
	} 
}else {
	alert("운전자는 삭제하실수 없습니다");
}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete03(){

if (gcds_code03.RowStatus(gcds_code03.rowposition) == "1" ){

//alert("!!");
gcds_code03.Undo(gcds_code03.RowPosition);
	} else if((gcds_code03.namevalue(gcds_code03.rowposition,"CAR_NO"))!=(gcds_code01.namevalue(gcds_code01.rowposition,"CAR_NO"))){
	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_code03.deleterow(gcds_code03.rowposition);
		gctr_code03.KeyValue = "tr00302_t3(I:USER=gcds_code03)";
		gctr_code03.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00302_t3";
		gctr_code03.post();
	}
	
	}else{
	alert("선택하신 차량은 삭제하실 수 없습니다.");
	}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete04(){

if (gcds_code04.RowStatus(gcds_code04.rowposition) == "1" ){

//alert("!!");
gcds_code04.Undo(gcds_code04.RowPosition);

} else
if (gcds_code04.namevalue(gcds_code04.rowposition,"DRIVE_DIV")=="N"){
	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_code04.deleterow(gcds_code04.rowposition);
		gctr_code04.KeyValue = "tr00302_t4(I:USER=gcds_code04)";
  		gctr_code04.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00302_t4";
  		gctr_code04.post();
		} 
	}else {
	alert("운전자는 삭제하실수 없습니다");
	}
}

/******************************************************************************
	Description : 출력(방문명단)
******************************************************************************/
function ln_Print(){
	if (gcds_code02.countrow<1) {
		alert("출력하실 정보가 없습니다");
	} else {
		
		gs_la=false;

		gcds_print.ClearData();
			
		var ls_temp = "CUDATE:STRING,A_AREA:STRING,S_DATE:STRING,PRSN_NAME:STRING,SEX:STRING,PR_REGNO:STRING,PRSN_CMPY:STRING,"
		+"JOB_DUTY:STRING,ADDRESS1:STRING,IMAGE:STRING,PERSON_NO:STRING,RT_DATE:STRING,P_CMPY:STRING";
		gcds_print.SetDataHeader(ls_temp);
	
		for (i=1;i<=gcds_code02.countrow;i++) {
			gcds_print.Addrow();
			gcds_print.namevalue(i,"CUDATE")=gs_date01;
			gcds_print.namevalue(i,"A_AREA")=gcds_code02.namevalue(i,"A_AREA");
			gcds_print.namevalue(i,"S_DATE")=gcds_code02.namevalue(i,"S_DATE");
			gcds_print.namevalue(i,"RT_DATE")=gcds_code02.namevalue(i,"RT_DATE");
			gcds_print.namevalue(i,"PRSN_NAME")=gcds_code02.namevalue(i,"PRSN_NAME");
			gcds_print.namevalue(i,"SEX")=gcds_code02.namevalue(i,"SEX");
			gcds_print.namevalue(i,"PR_REGNO")=gcds_code02.namevalue(i,"PR_REGNO");
			gcds_print.namevalue(i,"PRSN_CMPY")=gcds_code02.namevalue(i,"PRSN_CMPY");
			gcds_print.namevalue(i,"JOB_DUTY")=gcds_code02.namevalue(i,"JOB_DUTY");
			gcds_print.namevalue(i,"ADDRESS1")=gcds_code02.namevalue(i,"ADDRESS1");
			gcds_print.namevalue(i,"IMAGE")=gcds_code02.namevalue(i,"IMAGE");
			gcds_print.namevalue(i,"P_CMPY")=gcds_code02.namevalue(i,"P_CMPY");
		}
		gcrp_print.preview();	

		gs_la=true;
	}
}

/******************************************************************************
	Description : 출력(출입계획 - 군사분계선 통행계획[남])
******************************************************************************/
function ln_Print01(){

	if (gcds_code01.countrow<1) {
		alert("출력하실 정보가 없습니다");
	} else {
	
		gs_la='false';

		gcds_print01.ClearData();
		gcds_print02.ClearData();
		gcds_print03.ClearData();
		gcds_print04.ClearData();
			
		var ls_temp = "START_D:STRING,START_DA:STRING,START_TIME:STRING,P_POSE:STRING,SPERSON_CNT:DECIMAL,PSN_KNAME:STRING,"
       + "SCAR_CNT:DECIMAL,REMARK:STRING,PRSN_CMPY:STRING,JOB_DUTY:STRING,RTRN_TIME:STRING,RPERSON_CNT:DECIMAL,"
	  + "RCAR_CNT:DECIMAL,ACC_COURSE:STRING,START_DATE:STRING,PRSN_NAME:STRING,SEX:STRING,RTRN_COURSE:STRING,"
	+ "ACC_AREA:STRING,ADDRESS1:STRING,R_DATE:STRING,S_CIQ:STRING,A_COURSE:STRING,PURPOSE:STRING,RTRN_T:STRING,"
	+ "RDS_GOODS:STRING,RT_DATE:STRING,CAR_NAME:STRING,P_CMPY:STRING,P_REGNO:STRING,CAR_NO:STRING,"
	+ "CAR_TYPE:STRING,PERSON_CNT:DECIMAL,GOODS:STRING,GOODS_PSN:STRING,START_T:STRING";
		gcds_print01.SetDataHeader(ls_temp);
		gcds_print02.SetDataHeader(ls_temp);
		gcds_print03.SetDataHeader(ls_temp);
		gcds_print04.SetDataHeader(ls_temp);
				
			ln_Query04();
			ln_Query03();
			ln_Query02();
			//ln_Query05();

	for (i=1;i<=gcds_code01.countrow;i++) {
			gcds_print01.Addrow();			
			
			gcds_print01.namevalue(i,"START_D")=gcds_code01.namevalue(i,"START_D"); //차량정보
			gcds_print01.namevalue(i,"START_DA")=gcds_code01.namevalue(i,"START_DA");
			gcds_print01.namevalue(i,"RDS_GOODS")=gcds_code01.namevalue(i,"RDS_GOODS");
			gcds_print01.namevalue(i,"CAR_TYPE")=gcds_code01.namevalue(i,"CAR_TYPE");
			gcds_print01.namevalue(i,"CAR_NO")=gcds_code01.namevalue(i,"CAR_NO");
			gcds_print01.namevalue(i,"PERSON_CNT")=gcds_code01.namevalue(i,"PERSON_CNT");
			gcds_print01.namevalue(i,"GOODS")=gcds_code01.namevalue(i,"GOODS");
			gcds_print01.namevalue(i,"GOODS_PSN")=gcds_code01.namevalue(i,"GOODS_PSN");
			gcds_print01.namevalue(i,"R_DATE")=gcds_code01.namevalue(i,"R_DATE");
			gcds_print01.namevalue(i,"REMARK")=gcds_code01.namevalue(i,"REMARK");
			gcds_print01.namevalue(i,"P_POSE")=gcds_code01.namevalue(i,"P_POSE");
			gcds_print01.namevalue(i,"PSN_KNAME")=gcds_code01.namevalue(i,"PSN_KNAME");
			gcds_print01.namevalue(i,"CAR_NAME")=gcds_code01.namevalue(i,"CAR_NAME");
}
//alert(gcds_print01.countrow);
		for (j=1;j<=gcds_code02.countrow;j++) {
	
				gcds_print02.Addrow();			

			gcds_print02.namevalue(j,"P_CMPY")=gcds_code02.namevalue(j,"P_CMPY"); //인적정보
			gcds_print02.namevalue(j,"JOB_DUTY")=gcds_code02.namevalue(j,"JOB_DUTY");
			gcds_print02.namevalue(j,"PRSN_NAME")=gcds_code02.namevalue(j,"PRSN_NAME");
			gcds_print02.namevalue(j,"SEX")=gcds_code02.namevalue(j,"SEX");
			gcds_print02.namevalue(j,"P_REGNO")=gcds_code02.namevalue(j,"P_REGNO");
			gcds_print02.namevalue(j,"ADDRESS1")=gcds_code02.namevalue(j,"ADDRESS1");
			gcds_print02.namevalue(j,"RT_DATE")=gcds_code02.namevalue(j,"RT_DATE");
		
			}
//alert(gcds_print02.countrow);
			for (k=1;k<=gcds_code03.countrow;k++) {
			gcds_print03.Addrow();			
			
			gcds_print03.namevalue(k,"START_D")=gcds_code03.namevalue(k,"START_D"); //차량정보
			gcds_print03.namevalue(k,"START_DA")=gcds_code03.namevalue(k,"START_DA");
			gcds_print03.namevalue(k,"RDS_GOODS")=gcds_code03.namevalue(k,"RDS_GOODS");
			gcds_print03.namevalue(k,"CAR_TYPE")=gcds_code03.namevalue(k,"CAR_TYPE");
			gcds_print03.namevalue(k,"CAR_NO")=gcds_code03.namevalue(k,"CAR_NO");
			gcds_print03.namevalue(k,"PERSON_CNT")=gcds_code03.namevalue(k,"PERSON_CNT");
			gcds_print03.namevalue(k,"GOODS")=gcds_code03.namevalue(k,"GOODS");
			gcds_print03.namevalue(k,"GOODS_PSN")=gcds_code03.namevalue(k,"GOODS_PSN");
			gcds_print03.namevalue(k,"R_DATE")=gcds_code03.namevalue(k,"R_DATE");
			gcds_print03.namevalue(k,"REMARK")=gcds_code03.namevalue(k,"REMARK");
			gcds_print03.namevalue(k,"P_POSE")=gcds_code03.namevalue(k,"P_POSE");
			gcds_print03.namevalue(k,"PSN_KNAME")=gcds_code03.namevalue(k,"PSN_KNAME");
			gcds_print03.namevalue(k,"CAR_NAME")=gcds_code03.namevalue(k,"CAR_NAME");
}
//alert(gcds_print03.countrow);

		for (m=1;m<=gcds_code04.countrow;m++) {
	
				gcds_print04.Addrow();			

			gcds_print04.namevalue(m,"P_CMPY")=gcds_code04.namevalue(m,"P_CMPY"); //인적정보
			gcds_print04.namevalue(m,"JOB_DUTY")=gcds_code04.namevalue(m,"JOB_DUTY");
			gcds_print04.namevalue(m,"PRSN_NAME")=gcds_code04.namevalue(m,"PRSN_NAME");
			gcds_print04.namevalue(m,"SEX")=gcds_code04.namevalue(m,"SEX");
			gcds_print04.namevalue(m,"P_REGNO")=gcds_code04.namevalue(m,"P_REGNO");
			gcds_print04.namevalue(m,"ADDRESS1")=gcds_code04.namevalue(m,"ADDRESS1");
			gcds_print04.namevalue(m,"RT_DATE")=gcds_code04.namevalue(m,"RT_DATE");
		
			}
//alert(gcds_print04.countrow);

			gcds_print01.namevalue(1,"START_TIME")=gcds_code01.namevalue(gcds_code01.rowposition,"START_TIME");
			gcds_print01.namevalue(1,"RTRN_TIME")=gcds_code01.namevalue(gcds_code01.rowposition,"RTRN_TIME");
			gcds_print01.namevalue(1,"RPERSON_CNT")=gcds_code01.namevalue(gcds_code01.rowposition,"RPERSON_CNT");
			gcds_print01.namevalue(1,"RCAR_CNT")=gcds_code01.namevalue(gcds_code01.rowposition,"RCAR_CNT");
			gcds_print01.namevalue(1,"SPERSON_CNT")=gcds_code01.namevalue(gcds_code01.rowposition,"SPERSON_CNT");
			gcds_print01.namevalue(1,"SCAR_CNT")=gcds_code01.namevalue(gcds_code01.rowposition,"SCAR_CNT");
			gcds_print01.namevalue(1,"PURPOSE")=gcds_code01.namevalue(gcds_code01.rowposition,"PURPOSE");
			gcds_print01.namevalue(1,"START_T")=gcds_code01.namevalue(gcds_code01.rowposition,"START_T");
			gcds_print01.namevalue(1,"RTRN_T")=gcds_code01.namevalue(gcds_code01.rowposition,"RTRN_T");
		
			gcrp_print01.preview();	
			gs_la='true';
	}

}

/******************************************************************************
	Description : 출력(출입계획 - 군사분계선 통행계획[북])
******************************************************************************/
function ln_Print02(){

	if (gcds_code01.countrow<1) {
		alert("출력하실 정보가 없습니다");
	} else {

		gs_la='false';
	
		gcds_print01.ClearData();
		gcds_print02.ClearData();
		gcds_print03.ClearData();
		gcds_print04.ClearData();
			
	var ls_temp = "START_D:STRING,START_DA:STRING,START_TIME:STRING,P_POSE:STRING,SPERSON_CNT:DECIMAL,PSN_KNAME:STRING,"
    + "SCAR_CNT:DECIMAL,REMARK:STRING,PRSN_CMPY:STRING,JOB_DUTY:STRING,RTRN_TIME:STRING,RPERSON_CNT:DECIMAL,"
 + "RCAR_CNT:DECIMAL,ACC_COURSE:STRING,START_DATE:STRING,PRSN_NAME:STRING,SEX:STRING,RTRN_COURSE:STRING,"
+ "ACC_AREA:STRING,ADDRESS1:STRING,R_DATE:STRING,A_COURSE:STRING,PURPOSE:STRING,RTRN_T:STRING,"
+ "RDS_GOODS:STRING,RT_DATE:STRING,CAR_NAME:STRING,P_CMPY:STRING,P_REGNO:STRING,CAR_NO:STRING,"
+ "CAR_TYPE:STRING,PERSON_CNT:DECIMAL,GOODS:STRING,GOODS_PSN:STRING,START_T:STRING";
		gcds_print01.SetDataHeader(ls_temp);
		gcds_print02.SetDataHeader(ls_temp);
		gcds_print03.SetDataHeader(ls_temp);
		gcds_print04.SetDataHeader(ls_temp);

			ln_Query04();
			ln_Query03();
			ln_Query02();
			//ln_Query05();

	for (i=1;i<=gcds_code01.countrow;i++) {
			gcds_print01.Addrow();			
			
			gcds_print01.namevalue(i,"START_D")=gcds_code01.namevalue(i,"START_D"); //차량정보
			gcds_print01.namevalue(i,"START_DA")=gcds_code01.namevalue(i,"START_DA");
			gcds_print01.namevalue(i,"RDS_GOODS")=gcds_code01.namevalue(i,"RDS_GOODS");
			gcds_print01.namevalue(i,"CAR_TYPE")=gcds_code01.namevalue(i,"CAR_TYPE");
			gcds_print01.namevalue(i,"CAR_NO")=gcds_code01.namevalue(i,"CAR_NO");
			gcds_print01.namevalue(i,"PERSON_CNT")=gcds_code01.namevalue(i,"PERSON_CNT");
			gcds_print01.namevalue(i,"GOODS")=gcds_code01.namevalue(i,"GOODS");
			gcds_print01.namevalue(i,"GOODS_PSN")=gcds_code01.namevalue(i,"GOODS_PSN");
			gcds_print01.namevalue(i,"R_DATE")=gcds_code01.namevalue(i,"R_DATE");
			gcds_print01.namevalue(i,"REMARK")=gcds_code01.namevalue(i,"REMARK");
			gcds_print01.namevalue(i,"P_POSE")=gcds_code01.namevalue(i,"P_POSE");
			gcds_print01.namevalue(i,"PSN_KNAME")=gcds_code01.namevalue(i,"PSN_KNAME");
			gcds_print01.namevalue(i,"CAR_NAME")=gcds_code01.namevalue(i,"CAR_NAME");
}
//alert(gcds_print01.countrow);
		for (j=1;j<=gcds_code02.countrow;j++) {
	
				gcds_print02.Addrow();			

			gcds_print02.namevalue(j,"P_CMPY")=gcds_code02.namevalue(j,"P_CMPY"); //인적정보
			gcds_print02.namevalue(j,"JOB_DUTY")=gcds_code02.namevalue(j,"JOB_DUTY");
			gcds_print02.namevalue(j,"PRSN_NAME")=gcds_code02.namevalue(j,"PRSN_NAME");
			gcds_print02.namevalue(j,"SEX")=gcds_code02.namevalue(j,"SEX");
			gcds_print02.namevalue(j,"P_REGNO")=gcds_code02.namevalue(j,"P_REGNO");
			gcds_print02.namevalue(j,"ADDRESS1")=gcds_code02.namevalue(j,"ADDRESS1");
			gcds_print02.namevalue(j,"RT_DATE")=gcds_code02.namevalue(j,"RT_DATE");
		
			}
//alert(gcds_print02.countrow);
			for (k=1;k<=gcds_code03.countrow;k++) {
			gcds_print03.Addrow();		
			
			gcds_print03.namevalue(k,"START_D")=gcds_code03.namevalue(k,"START_D"); //차량정보
			gcds_print03.namevalue(k,"START_DA")=gcds_code03.namevalue(k,"START_DA");
			gcds_print03.namevalue(k,"RDS_GOODS")=gcds_code03.namevalue(k,"RDS_GOODS");
			gcds_print03.namevalue(k,"CAR_TYPE")=gcds_code03.namevalue(k,"CAR_TYPE");
			gcds_print03.namevalue(k,"CAR_NO")=gcds_code03.namevalue(k,"CAR_NO");
			gcds_print03.namevalue(k,"PERSON_CNT")=gcds_code03.namevalue(k,"PERSON_CNT");
			gcds_print03.namevalue(k,"GOODS")=gcds_code03.namevalue(k,"GOODS");
			gcds_print03.namevalue(k,"GOODS_PSN")=gcds_code03.namevalue(k,"GOODS_PSN");
			gcds_print03.namevalue(k,"R_DATE")=gcds_code03.namevalue(k,"R_DATE");
			gcds_print03.namevalue(k,"REMARK")=gcds_code03.namevalue(k,"REMARK");
			gcds_print03.namevalue(k,"P_POSE")=gcds_code03.namevalue(k,"P_POSE");
			gcds_print03.namevalue(k,"PSN_KNAME")=gcds_code03.namevalue(k,"PSN_KNAME");
			gcds_print03.namevalue(k,"CAR_NAME")=gcds_code03.namevalue(k,"CAR_NAME");
}
//alert(gcds_print03.countrow);

		for (m=1;m<=gcds_code04.countrow;m++) {
	
				gcds_print04.Addrow();			

			gcds_print04.namevalue(m,"P_CMPY")=gcds_code04.namevalue(m,"P_CMPY"); //인적정보
			gcds_print04.namevalue(m,"JOB_DUTY")=gcds_code04.namevalue(m,"JOB_DUTY");
			gcds_print04.namevalue(m,"PRSN_NAME")=gcds_code04.namevalue(m,"PRSN_NAME");
			gcds_print04.namevalue(m,"SEX")=gcds_code04.namevalue(m,"SEX");
			gcds_print04.namevalue(m,"P_REGNO")=gcds_code04.namevalue(m,"P_REGNO");
			gcds_print04.namevalue(m,"ADDRESS1")=gcds_code04.namevalue(m,"ADDRESS1");
			gcds_print04.namevalue(m,"RT_DATE")=gcds_code04.namevalue(m,"RT_DATE");
		
			}
//alert(gcds_print04.countrow);

			gcds_print01.namevalue(1,"START_TIME")=gcds_code01.namevalue(gcds_code01.rowposition,"START_TIME");
			gcds_print01.namevalue(1,"RTRN_TIME")=gcds_code01.namevalue(gcds_code01.rowposition,"RTRN_TIME");
			gcds_print01.namevalue(1,"RPERSON_CNT")=gcds_code01.namevalue(gcds_code01.rowposition,"RPERSON_CNT");
			gcds_print01.namevalue(1,"RCAR_CNT")=gcds_code01.namevalue(gcds_code01.rowposition,"RCAR_CNT");
			gcds_print01.namevalue(1,"SPERSON_CNT")=gcds_code01.namevalue(gcds_code01.rowposition,"SPERSON_CNT");
			gcds_print01.namevalue(1,"SCAR_CNT")=gcds_code01.namevalue(gcds_code01.rowposition,"SCAR_CNT");
			gcds_print01.namevalue(1,"START_T")=gcds_code01.namevalue(gcds_code01.rowposition,"START_T");
			gcds_print01.namevalue(1,"RTRN_T")=gcds_code01.namevalue(gcds_code01.rowposition,"RTRN_T");
			gcds_print01.namevalue(1,"PURPOSE")=gcds_code01.namevalue(gcds_code01.rowposition,"PURPOSE");
		
			gcrp_print02.preview();	
			gs_la='true';
	}
}

/******************************************************************************
	Description : 출력(출입계획 - 군사분계선 통행신청서[UNC])
******************************************************************************/
function ln_Print03(){

	if (gcds_code01.countrow<1) {
		alert("출력하실 정보가 없습니다");
	} else {

		gs_la='false';
	
		gcds_print03.ClearData();
		gcds_print04.ClearData();
			
		var ls_temp = "START_D:STRING,START_DA:STRING,START_TIME:STRING,P_POSE:STRING,SPERSON_CNT:DECIMAL,"
	 + "SCAR_CNT:DECIMAL,REMARK:STRING,PRSN_CMPY:STRING,JOB_DUTY:STRING,RTRN_TIME:STRING,RPERSON_CNT:DECIMAL,"
	 + "RCAR_CNT:DECIMAL,ACC_COURSE:STRING,START_DATE:STRING,PRSN_NAME:STRING,SEX:STRING,RTRN_COURSE:STRING,"
	+ "ACC_AREA:STRING,ADDRESS1:STRING,R_DATE:STRING,S_CIQ:STRING,A_COURSE:STRING,P_CMPY:STRING,"
	+ "L_CARGO:STRING,O_CARGO:STRING,R_CIQ:STRING,RDS_GOODS:STRING,RT_DATE:STRING,PURPOSE:STRING,CAR_NAME:STRING,"
	+ "P_REGNO:STRING,CAR_NO:STRING,CAR_TYPE:STRING,PERSON_CNT:DECIMAL,GOODS:STRING,GOODS_PSN:STRING";
		gcds_print03.SetDataHeader(ls_temp);
		gcds_print04.SetDataHeader(ls_temp);
				
			ln_Query02();
			ln_Query03();
			ln_Query04();
			//ln_Query05();

	for (i=1;i<=gcds_code01.countrow;i++) {
			gcds_print03.Addrow();			
			
			gcds_print03.namevalue(i,"START_D")=gcds_code01.namevalue(i,"START_D"); //차량정보
			gcds_print03.namevalue(i,"START_DA")=gcds_code01.namevalue(i,"START_DA");
			gcds_print03.namevalue(i,"L_CARGO")=gcds_code01.namevalue(i,"L_CARGO");
			gcds_print03.namevalue(i,"O_CARGO")=gcds_code01.namevalue(i,"O_CARGO");
			gcds_print03.namevalue(i,"S_CIQ")=gcds_code01.namevalue(i,"S_CIQ");
			gcds_print03.namevalue(i,"R_CIQ")=gcds_code01.namevalue(i,"R_CIQ");
			gcds_print03.namevalue(i,"RDS_GOODS")=gcds_code01.namevalue(i,"RDS_GOODS");
			gcds_print03.namevalue(i,"CAR_TYPE")=gcds_code01.namevalue(i,"CAR_TYPE");
			gcds_print03.namevalue(i,"CAR_NO")=gcds_code01.namevalue(i,"CAR_NO");
			gcds_print03.namevalue(i,"PERSON_CNT")=gcds_code01.namevalue(i,"PERSON_CNT");
			gcds_print03.namevalue(i,"GOODS")=gcds_code01.namevalue(i,"GOODS");
			gcds_print03.namevalue(i,"GOODS_PSN")=gcds_code01.namevalue(i,"GOODS_PSN");
			gcds_print03.namevalue(i,"R_DATE")=gcds_code01.namevalue(i,"R_DATE");
			gcds_print03.namevalue(i,"REMARK")=gcds_code01.namevalue(i,"REMARK");
			gcds_print03.namevalue(i,"P_POSE")=gcds_code01.namevalue(i,"P_POSE");
			gcds_print03.namevalue(i,"PRSN_NAME")=gcds_code02.namevalue(i,"PRSN_NAME");
			gcds_print03.namevalue(i,"CAR_NAME")=gcds_code01.namevalue(i,"CAR_NAME");
}
		
		for (j=1;j<=gcds_code02.countrow;j++) {
	
				gcds_print04.Addrow();			

			row = gcds_print04.rowposition;

			gcds_print04.namevalue(row,"P_CMPY")=gcds_code02.namevalue(j,"P_CMPY"); //인적정보
			gcds_print04.namevalue(row,"JOB_DUTY")=gcds_code02.namevalue(j,"JOB_DUTY");
			gcds_print04.namevalue(row,"PRSN_NAME")=gcds_code02.namevalue(j,"PRSN_NAME");
			gcds_print04.namevalue(row,"SEX")=gcds_code02.namevalue(j,"SEX");
			gcds_print04.namevalue(row,"P_REGNO")=gcds_code02.namevalue(j,"P_REGNO");
			gcds_print04.namevalue(row,"ADDRESS1")=gcds_code02.namevalue(j,"ADDRESS1");
			gcds_print04.namevalue(row,"RT_DATE")=gcds_code02.namevalue(j,"RT_DATE");

			}

			gcds_print03.namevalue(1,"START_TIME")=gcds_code01.namevalue(gcds_code01.rowposition,"START_TIME");
			gcds_print03.namevalue(1,"RTRN_TIME")=gcds_code01.namevalue(gcds_code01.rowposition,"RTRN_TIME");
			gcds_print03.namevalue(1,"RPERSON_CNT")=gcds_code01.namevalue(gcds_code01.rowposition,"RPERSON_CNT");
			gcds_print03.namevalue(1,"RCAR_CNT")=gcds_code01.namevalue(gcds_code01.rowposition,"RCAR_CNT");
			gcds_print03.namevalue(1,"SPERSON_CNT")=gcds_code01.namevalue(gcds_code01.rowposition,"SPERSON_CNT");
			gcds_print03.namevalue(1,"SCAR_CNT")=gcds_code01.namevalue(gcds_code01.rowposition,"SCAR_CNT");
			gcds_print03.namevalue(1,"PURPOSE")=gcds_code05.namevalue(gcds_code05.rowposition,"PURPOSE");

			gcrp_print03.preview();	
			gs_la='true';
	}
}

/******************************************************************************
	Description : 출력(조선인민공화국])
******************************************************************************/
function ln_Print04(){

	if (gcds_code01.countrow<1) {
		alert("출력하실 정보가 없습니다");
		
	} else if  (gcds_code01.namevalue(gcds_code01.rowposition,"PROJECT_CD")!="0001") {

		alert("개성공단 프로젝트만 출력이 됩니다.");
	
	} else  {
	
		gs_la='false';

		gcds_print05.ClearData();
			
	var ls_temp = "START_DATE:STRING,START_DA:STRING,ST_DATE:STRING";
	 
	gcds_print05.SetDataHeader(ls_temp);
	
	var gs_da = gcem_start_date.text;
	var gs_daa = gs_da.substring(0,4)+"년" + gs_da.substring(4,6) +"월"+gs_da.substring(6,8)+"일";
	
		for (i=1;i<=gcds_code01.countrow;i++) {
			gcds_print05.Addrow();
		
			gcds_print05.namevalue(i,"START_DATE")=gs_daa;
			gcds_print05.namevalue(i,"START_DA")=gcds_code01.namevalue(i,"START_DA")+"요일";
			gcds_print05.namevalue(i,"ST_DATE")=strtxt;

		}

		gcrp_print04.preview();	
		//gcrp_print05.preview();	
		ln_Print05();

		gs_la='true';
	}
}

/******************************************************************************
	Description : 출력(개성공업지구 방문계획)
******************************************************************************/
function ln_Print05(){

	if (gcds_code01.countrow<1) {
		alert("출력하실 정보가 없습니다");
	} else {
	
		gs_la='false';

		gcds_print06.ClearData();
			
		var ls_temp = "START_DATE:STRING,"
		 + "TOT_PER_CNT:DECIMAL,PER_CNT:DECIMAL,DRIVER_CNT:STRINGL,START_TIME:STRING,"
		 + "TOT_PER_CNT2:DECIMAL,PER_CNT2:DECIMAL,DRIVER_CNT2:DECIMAL,START_TIME2:STRING,"
		 + "TOT_PER_CNT3:DECIMAL,PER_CNT3:DECIMAL,DRIVER_CNT3:DECIMAL,START_TIME3:STRING,"

		 + "TOT_PER_CN:DECIMAL,PER_CN:DECIMAL,DRIVER_CN:DECIMAL,RTRN_TIME:STRING,"
		 + "TOT_PER_CN2:DECIMAL,PER_CN2:DECIMAL,DRIVER_CN2:DECIMAL,RTRN_TIME2:STRING,"
		 + "TOT_PER_CN3:DECIMAL,PER_CN3:DECIMAL,DRIVER_CN3:DECIMAL,RTRN_TIME3:STRING,"

		 + "TOT_CNT:DECIMAL,BUS_CNT:DECIMAL,CAR_CNT:DECIMAL,TRUCK_CNT:DECIMAL,"
		 + "ETC_CNT:DECIMAL,TRAIL_CNT:DECIMAL,"
		 + "TOT_CNT2:DECIMAL,BUS_CNT2:DECIMAL,CAR_CNT2:DECIMAL,TRUCK_CNT2:DECIMAL,"
		 + "ETC_CNT2:DECIMAL,TRAIL_CNT2:DECIMAL,"
		 + "TOT_CNT3:DECIMAL,BUS_CNT3:DECIMAL,CAR_CNT3:DECIMAL,TRUCK_CNT3:DECIMAL,"
		 + "ETC_CNT3:DECIMAL,TRAIL_CNT3:DECIMAL,"

		 + "TOT_CN:DECIMAL,BUS_CN:DECIMAL,CAR_CN:DECIMAL,TRUCK_CN:DECIMAL,"
		 + "ETC_CN:DECIMAL,TRAIL_CN:DECIMAL,"
		 + "TOT_CN2:DECIMAL,BUS_CN2:DECIMAL,CAR_CN2:DECIMAL,TRUCK_CN2:DECIMAL,"
		 + "ETC_CN2:DECIMAL,TRAIL_CN2:DECIMAL,"
		 + "TOT_CN3:DECIMAL,BUS_CN3:DECIMAL,CAR_CN3:DECIMAL,TRUCK_CN3:DECIMAL,"
		 + "ETC_CN3:DECIMAL,TRAIL_CN3:DECIMAL";

		
		gcds_print06.SetDataHeader(ls_temp);

		ln_Query02();
		ln_Query03();
		ln_Query04();

	var gs_da01 = gcem_start_date.text;
	var gs_daa01 = gs_da01.substring(4,6)+"." + gs_da01.substring(6,9) ;
	
		for (i=1;i<=gcds_code01.countrow;i++) {
			gcds_print06.Addrow();
		
			gcds_print06.namevalue(i,"START_DATE")=gs_daa01;

		}
		
			gcds_print06.namevalue(1,"START_TIME")=gcds_person.namevalue(1,"START_TIME");
			gcds_print06.namevalue(1,"TOT_PER_CNT")=gcds_person.namevalue(1,"TOT_PER_CNT");
			gcds_print06.namevalue(1,"PER_CNT")=gcds_person.namevalue(1,"PER_CNT");
			gcds_print06.namevalue(1,"DRIVER_CNT")=gcds_person.namevalue(1,"DRIVER_CNT");

			gcds_print06.namevalue(1,"START_TIME2")=gcds_person.namevalue(2,"START_TIME");
			gcds_print06.namevalue(1,"TOT_PER_CNT2")=gcds_person.namevalue(2,"TOT_PER_CNT");
			gcds_print06.namevalue(1,"PER_CNT2")=gcds_person.namevalue(2,"PER_CNT");
			gcds_print06.namevalue(1,"DRIVER_CNT2")=gcds_person.namevalue(2,"DRIVER_CNT");
			gcds_print06.namevalue(1,"START_TIME3")=gcds_person.namevalue(3,"START_TIME");
			gcds_print06.namevalue(1,"TOT_PER_CNT3")=gcds_person.namevalue(3,"TOT_PER_CNT");
			gcds_print06.namevalue(1,"PER_CNT3")=gcds_person.namevalue(3,"PER_CNT");
			gcds_print06.namevalue(1,"DRIVER_CNT3")=gcds_person.namevalue(3,"DRIVER_CNT");

			gcds_print06.namevalue(1,"RTRN_TIME")=gcds_personn.namevalue(1,"RTRN_TIME");
			gcds_print06.namevalue(1,"TOT_PER_CN")=gcds_personn.namevalue(1,"TOT_PER_CNT");
			gcds_print06.namevalue(1,"PER_CN")=gcds_personn.namevalue(1,"PER_CNT");
			gcds_print06.namevalue(1,"DRIVER_CN")=gcds_personn.namevalue(1,"DRIVER_CNT");

			gcds_print06.namevalue(1,"RTRN_TIME2")=gcds_personn.namevalue(2,"RTRN_TIME");
			gcds_print06.namevalue(1,"TOT_PER_CN2")=gcds_personn.namevalue(2,"TOT_PER_CNT");
			gcds_print06.namevalue(1,"PER_CN2")=gcds_personn.namevalue(2,"PER_CNT");
			gcds_print06.namevalue(1,"DRIVER_CN2")=gcds_personn.namevalue(2,"DRIVER_CNT");

			gcds_print06.namevalue(1,"RTRN_TIME3")=gcds_personn.namevalue(3,"RTRN_TIME");
			gcds_print06.namevalue(1,"TOT_PER_CN3")=gcds_personn.namevalue(3,"TOT_PER_CNT");
			gcds_print06.namevalue(1,"PER_CN3")=gcds_personn.namevalue(3,"PER_CNT");
			gcds_print06.namevalue(1,"DRIVER_CN3")=gcds_personn.namevalue(3,"DRIVER_CNT");

			gcds_print06.namevalue(1,"TOT_CNT")=gcds_car.namevalue(1,"TOT_CNT");
			gcds_print06.namevalue(1,"BUS_CNT")=gcds_car.namevalue(1,"BUS_CNT");
			gcds_print06.namevalue(1,"CAR_CNT")=gcds_car.namevalue(1,"CAR_CNT");
			gcds_print06.namevalue(1,"TRUCK_CNT")=gcds_car.namevalue(1,"TRUCK_CNT");
			gcds_print06.namevalue(1,"TRAIL_CNT")=gcds_car.namevalue(1,"TRAIL_CNT");
			gcds_print06.namevalue(1,"ETC_CNT")=gcds_car.namevalue(1,"ETC_CNT");

			gcds_print06.namevalue(1,"TOT_CNT2")=gcds_car.namevalue(2,"TOT_CNT");
			gcds_print06.namevalue(1,"BUS_CNT2")=gcds_car.namevalue(2,"BUS_CNT");
			gcds_print06.namevalue(1,"CAR_CNT2")=gcds_car.namevalue(2,"CAR_CNT");
			gcds_print06.namevalue(1,"TRUCK_CNT2")=gcds_car.namevalue(2,"TRUCK_CNT");
			gcds_print06.namevalue(1,"TRAIL_CNT2")=gcds_car.namevalue(2,"TRAIL_CNT");
			gcds_print06.namevalue(1,"ETC_CNT2")=gcds_car.namevalue(2,"ETC_CNT");

			gcds_print06.namevalue(1,"TOT_CNT3")=gcds_car.namevalue(3,"TOT_CNT");
			gcds_print06.namevalue(1,"BUS_CNT3")=gcds_car.namevalue(3,"BUS_CNT");
			gcds_print06.namevalue(1,"CAR_CNT3")=gcds_car.namevalue(3,"CAR_CNT");
			gcds_print06.namevalue(1,"TRUCK_CNT3")=gcds_car.namevalue(3,"TRUCK_CNT");
			gcds_print06.namevalue(1,"TRAIL_CNT3")=gcds_car.namevalue(3,"TRAIL_CNT");
			gcds_print06.namevalue(1,"ETC_CNT3")=gcds_car.namevalue(3,"ETC_CNT");

			gcds_print06.namevalue(1,"TOT_CN")=gcds_carr.namevalue(1,"TOT_CNT");
			gcds_print06.namevalue(1,"BUS_CN")=gcds_carr.namevalue(1,"BUS_CNT");
			gcds_print06.namevalue(1,"CAR_CN")=gcds_carr.namevalue(1,"CAR_CNT");
			gcds_print06.namevalue(1,"TRUCK_CN")=gcds_carr.namevalue(1,"TRUCK_CNT");
			gcds_print06.namevalue(1,"TRAIL_CN")=gcds_carr.namevalue(1,"TRAIL_CNT");
			gcds_print06.namevalue(1,"ETC_CN")=gcds_carr.namevalue(1,"ETC_CNT");

			gcds_print06.namevalue(1,"TOT_CN2")=gcds_carr.namevalue(2,"TOT_CNT");
			gcds_print06.namevalue(1,"BUS_CN2")=gcds_carr.namevalue(2,"BUS_CNT");
			gcds_print06.namevalue(1,"CAR_CN2")=gcds_carr.namevalue(2,"CAR_CNT");
			gcds_print06.namevalue(1,"TRUCK_CN2")=gcds_carr.namevalue(2,"TRUCK_CNT");
			gcds_print06.namevalue(1,"TRAIL_CN2")=gcds_carr.namevalue(2,"TRAIL_CNT");
			gcds_print06.namevalue(1,"ETC_CN2")=gcds_carr.namevalue(2,"ETC_CNT");

			gcds_print06.namevalue(1,"TOT_CN3")=gcds_carr.namevalue(3,"TOT_CNT");
			gcds_print06.namevalue(1,"BUS_CN3")=gcds_carr.namevalue(3,"BUS_CNT");
			gcds_print06.namevalue(1,"CAR_CN3")=gcds_carr.namevalue(3,"CAR_CNT");
			gcds_print06.namevalue(1,"TRUCK_CN3")=gcds_carr.namevalue(3,"TRUCK_CNT");
			gcds_print06.namevalue(1,"TRAIL_CN3")=gcds_carr.namevalue(3,"TRAIL_CNT");
			gcds_print06.namevalue(1,"ETC_CN3")=gcds_carr.namevalue(3,"ETC_CNT");

			gcrp_print05.preview();	
			ln_Print06();

		gs_la='true';
	}
}

/******************************************************************************
	Description : 출력(복귀인원)
******************************************************************************/
function ln_Print06(){

	if (gcds_code01.countrow<1) {
		alert("출력하실 정보가 없습니다");
	} else {

		gs_la='false';
	
		gcds_print07.ClearData();
		gcds_print08.ClearData();
		gcds_print09.ClearData();
		gcds_print10.ClearData();
			
		var ls_temp = "START_TIME:STRING,P_POSE:STRING,SPERSON_CNT:DECIMAL,PSN_KNAME:STRING,"
	+ "SCAR_CNT:DECIMAL,REMARK:STRING,PRSN_CMPY:STRING,JOB_DUTY:STRING,RTRN_TIME:STRING,RPERSON_CNT:DECIMAL,"
    + "START_DATE:STRING,PRSN_NAME:STRING,SEX:STRING,RTRN_COURSE:STRING,START_D:STRING,"
	+ "ACC_AREA:STRING,ADDRESS1:STRING,R_DATE:STRING,P_CMPY:STRING,"
	+ "RT_DATE:STRING,PURPOSE:STRING,CAR_NAME:STRING,ST_DATE_TIME:STRING,S_DATE:STRING,"
	+ "P_REGNO:STRING,PR_REGNO:STRING,CAR_NO:STRING,CAR_TYPE:STRING,PERSON_CNT:DECIMAL,RTRN_TIME2:STRING";
	
		gcds_print07.SetDataHeader(ls_temp);
		gcds_print08.SetDataHeader(ls_temp);
		gcds_print09.SetDataHeader(ls_temp);
		gcds_print10.SetDataHeader(ls_temp);
		
			ln_Query04();
			ln_Query03();
			ln_Query02();

		
	for (i=1;i<=gcds_code01.countrow;i++) {
			gcds_print07.Addrow();			
			
			gcds_print07.namevalue(i,"START_D")=gcds_code01.namevalue(i,"START_D"); //출입차량정보
			gcds_print07.namevalue(i,"START_DA")=gcds_code01.namevalue(i,"START_DA");
			gcds_print07.namevalue(i,"CAR_TYPE")=gcds_code01.namevalue(i,"CAR_TYPE");
			gcds_print07.namevalue(i,"CAR_NO")=gcds_code01.namevalue(i,"CAR_NO");
			gcds_print07.namevalue(i,"PERSON_CNT")=gcds_code01.namevalue(i,"PERSON_CNT");
			gcds_print07.namevalue(i,"R_DATE")=gcds_code01.namevalue(i,"R_DATE");
			gcds_print07.namevalue(i,"REMARK")=gcds_code01.namevalue(i,"REMARK");
			gcds_print07.namevalue(i,"P_POSE")=gcds_code01.namevalue(i,"P_POSE");
			gcds_print07.namevalue(i,"PSN_KNAME")=gcds_code01.namevalue(i,"PSN_KNAME");
			gcds_print07.namevalue(i,"CAR_NAME")=gcds_code01.namevalue(i,"CAR_NAME");
			gcds_print07.namevalue(i,"START_TIME")=gcds_code02.namevalue(i,"START_TIME");//출입시간


	}


		for (j=1;j<=gcds_code02.countrow;j++) {
	
				gcds_print08.Addrow();			

			gcds_print08.namevalue(j,"P_CMPY")=gcds_code02.namevalue(j,"P_CMPY"); //출입인적정보
			gcds_print08.namevalue(j,"JOB_DUTY")=gcds_code02.namevalue(j,"JOB_DUTY");//소속
			gcds_print08.namevalue(j,"PRSN_NAME")=gcds_code02.namevalue(j,"PRSN_NAME");//이름
			gcds_print08.namevalue(j,"SEX")=gcds_code02.namevalue(j,"SEX");//성별
			gcds_print08.namevalue(j,"PR_REGNO")=gcds_code02.namevalue(j,"PR_REGNO");//생년월일
			gcds_print08.namevalue(j,"ADDRESS1")=gcds_code02.namevalue(j,"ADDRESS1");//주소
			gcds_print08.namevalue(j,"START_TIME")=gcds_code02.namevalue(j,"START_TIME");//출입시간
			gcds_print08.namevalue(j,"START_D")=gcds_code01.namevalue(j,"START_D");


		}


		for (k=1;k<=gcds_code03.countrow;k++) {
			gcds_print09.Addrow();			
			
			gcds_print09.namevalue(k,"START_D")=gcds_code03.namevalue(k,"START_D"); //복귀차량
			gcds_print09.namevalue(k,"START_DA")=gcds_code03.namevalue(k,"START_DA");
			gcds_print09.namevalue(k,"RDS_GOODS")=gcds_code03.namevalue(k,"RDS_GOODS");
			gcds_print09.namevalue(k,"CAR_TYPE")=gcds_code03.namevalue(k,"CAR_TYPE");
			gcds_print09.namevalue(k,"CAR_NO")=gcds_code03.namevalue(k,"CAR_NO");
			gcds_print09.namevalue(k,"PERSON_CNT")=gcds_code03.namevalue(k,"PERSON_CNT");
			gcds_print09.namevalue(k,"GOODS")=gcds_code03.namevalue(k,"GOODS");
			gcds_print09.namevalue(k,"GOODS_PSN")=gcds_code03.namevalue(k,"GOODS_PSN");
			gcds_print09.namevalue(k,"R_DATE")=gcds_code03.namevalue(k,"R_DATE");
			gcds_print09.namevalue(k,"REMARK")=gcds_code03.namevalue(k,"REMARK");
			gcds_print09.namevalue(k,"P_POSE")=gcds_code03.namevalue(k,"P_POSE");
			gcds_print09.namevalue(k,"PSN_KNAME")=gcds_code03.namevalue(k,"PSN_KNAME");
			gcds_print09.namevalue(k,"CAR_NAME")=gcds_code03.namevalue(k,"CAR_NAME");
			gcds_print09.namevalue(k,"RTRN_TIME")=gcds_code04.namevalue(k,"RTRN_TIME");
	}


		for (m=1;m<=gcds_code04.countrow;m++) {
	
				gcds_print10.Addrow();			



			gcds_print10.namevalue(m,"P_CMPY")=gcds_code04.namevalue(m,"P_CMPY"); //복귀인원
			gcds_print10.namevalue(m,"JOB_DUTY")=gcds_code04.namevalue(m,"JOB_DUTY");
			gcds_print10.namevalue(m,"PRSN_NAME")=gcds_code04.namevalue(m,"PRSN_NAME");
			gcds_print10.namevalue(m,"SEX")=gcds_code04.namevalue(m,"SEX");
			gcds_print10.namevalue(m,"PR_REGNO")=gcds_code04.namevalue(m,"PR_REGNO");
			gcds_print10.namevalue(m,"ADDRESS1")=gcds_code04.namevalue(m,"ADDRESS1");
			gcds_print10.namevalue(m,"RT_DATE")=gcds_code04.namevalue(m,"RT_DATE");
			gcds_print10.namevalue(m,"RTRN_TIME")=gcds_code04.namevalue(m,"RTRN_TIME");
			gcds_print10.namevalue(m,"START_D")=gcds_code03.namevalue(m,"START_D"); 
	
	}

			
			gcrp_print06.preview();	
			gcrp_print07.preview();	
			gcrp_print08.preview();	
			gcrp_print09.preview();	
			ln_Print10();
			
			gs_la='true';
	}
}

/******************************************************************************
	Description : 출력(출입시간)
******************************************************************************/
function ln_Print10(){

	if (gcds_code01.countrow<1) {
		alert("출력하실 정보가 없습니다");
	} else {
	
		gs_la='false';

		gcds_print06.ClearData();
			
		var ls_temp = "ST_DATE_TIME:STRING,ST_DATE_TIME2:STRING,ST_DATE_TIME3:STRING,"
		 + "S_DATE_TIME:STRING,S_DATE_TIME2:STRING,S_DATE_TIME3:STRING,"
		 + "RT_DATE_TIME:STRING,RT_DATE_TIME2:STRING,RT_DATE_TIME3:STRING,"
		 + "R_DATE_TIME:STRING,R_DATE_TIME2:STRING,R_DATE_TIME3:STRING";
		
		gcds_print06.SetDataHeader(ls_temp);
	
		ln_Query02();
		ln_Query03();
		ln_Query04();
	
	var gs_time01 = gcds_person.namevalue(1,"S_DATE_TIME");
	var gs_time011 = gs_time01.substring(0,10) + ' ' +gs_time01.substring(11,13)+':'+gs_time01.substring(14,16) ;


	var gs_time02 = gcds_personn.namevalue(1,"R_DATE_TIME");
	var gs_time022 = gs_time02.substring(0,10) + ' ' +gs_time02.substring(11,13)+':'+gs_time02.substring(14,16) ;

	if((gcds_print06.namevalue(1,"S_DATE_TIME2"))==(gcds_person.namevalue(2,"S_DATE_TIME"))){



	}else if ((gcds_print06.namevalue(1,"S_DATE_TIME3"))==(gcds_person.namevalue(3,"S_DATE_TIME"))){	



	var gs_time001 = gcds_person.namevalue(2,"S_DATE_TIME");

	var gs_time0011 = gs_time001.substring(0,10) + ' ' +gs_time001.substring(11,13)+':'+gs_time001.substring(14,16) ;



	} else {


	var gs_time001 = gcds_person.namevalue(2,"S_DATE_TIME");

	var gs_time0011 = gs_time001.substring(0,10) + ' ' +gs_time001.substring(11,13)+':'+gs_time001.substring(14,16) ;


	var gs_time0001 = gcds_person.namevalue(3,"S_DATE_TIME");
	var gs_time00011 = gs_time0001.substring(0,10) + ' ' +gs_time0001.substring(11,13)+':'+gs_time0001.substring(14,16) ;

}

	if((gcds_print06.namevalue(1,"R_DATE_TIME2"))==(gcds_personn.namevalue(2,"R_DATE_TIME"))){


	}else if ((gcds_print06.namevalue(1,"R_DATE_TIME3"))==(gcds_personn.namevalue(3,"R_DATE_TIME"))){	


	var gs_time002 = gcds_personn.namevalue(2,"R_DATE_TIME");

	var gs_time0022 = gs_time002.substring(0,10) + ' ' +gs_time002.substring(11,13)+':'+gs_time002.substring(14,16) ;

	} else {


	var gs_time002 = gcds_personn.namevalue(2,"R_DATE_TIME");

	var gs_time0022 = gs_time002.substring(0,10) + ' ' +gs_time002.substring(11,13)+':'+gs_time002.substring(14,16) ;


	var gs_time0002 = gcds_personn.namevalue(3,"R_DATE_TIME");
	var gs_time00022 = gs_time0002.substring(0,10) + ' ' +gs_time0002.substring(11,13)+':'+gs_time0002.substring(14,16) ;

}

			gcds_print06.Addrow();

			gcds_print06.namevalue(1,"ST_DATE_TIME")=gcds_person.namevalue(1,"ST_DATE_TIME");
			gcds_print06.namevalue(1,"ST_DATE_TIME2")=gcds_person.namevalue(2,"ST_DATE_TIME");
			gcds_print06.namevalue(1,"ST_DATE_TIME3")=gcds_person.namevalue(3,"ST_DATE_TIME");

			gcds_print06.namevalue(1,"S_DATE_TIME")=gs_time011;
			gcds_print06.namevalue(1,"S_DATE_TIME2")=gs_time0011;
			gcds_print06.namevalue(1,"S_DATE_TIME3")=gs_time00011;
	
			gcds_print06.namevalue(1,"RT_DATE_TIME")=gcds_personn.namevalue(1,"RT_DATE_TIME");
			gcds_print06.namevalue(1,"RT_DATE_TIME2")=gcds_personn.namevalue(2,"RT_DATE_TIME");
			gcds_print06.namevalue(1,"RT_DATE_TIME3")=gcds_personn.namevalue(3,"RT_DATE_TIME");

			gcds_print06.namevalue(1,"R_DATE_TIME")=gs_time022;
			gcds_print06.namevalue(1,"R_DATE_TIME2")=gs_time0022;
			gcds_print06.namevalue(1,"R_DATE_TIME3")=gs_time00022;

			gcrp_print10.preview();	

		gs_la='true';
	}
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	
}

/******************************************************************************
	Description : FILE 
******************************************************************************/
function ln_File(){

}

/******************************************************************************
	Description : 입력체크 
******************************************************************************/
function ln_Chk(p){

		//출입번호체크
		if (fn_trim(gcem_accessno.text)=="" ){
			alert("출입번호를 입력하십시요.");
			gcem_accessno.focus();
			return false; 
		}
	if(p=="01") {

			if (fn_trim(txt_car_no.value)=="" ){
				alert("차량번호를 입력하십시요.");

				return false; 
		}
	
			if (fn_trim(txt_prsn_name.value)=="" ){
				alert("운전자명을 입력하십시요.");

				return false; 
		}
			if (fn_trim(gcem_start_date.text)=="" ){
				alert("출경날짜를 입력하십시요.");

				return false; 
		}
			if (fn_trim(gcem_start_time.text)=="" ){
				alert("출경시간을 입력하십시요.");

				return false; 
		}

			
	}else if(p=="02") {

	}else if(p=="03") {
			if (fn_trim(gcem_rtrn_date03.text)=="" ){
				alert("복귀날짜를 입력하십시요.");

				return false; 
	}

	}else if(p=="04") {

}
	return true; 
}

/******************************************************************************
	Description : 탭에서 넘어갈때  
	parameter   : p==> 01-출경차량, 02-출경인원, 03-입경차량, 04-입경인원
******************************************************************************/
function ln_ll(p){

	if(p=="01") {
		
		 if (gcds_code01.RowStatus(gcds_code01.rowposition) == "1" ){
				var seq= txt_seq.value;
				var sumValue = Number(seq)+ 1;

				gcds_code01.namevalue(gcds_code01.rowposition,"ACCSECTION") = gs_accsectiono;
				gcds_code01.namevalue(gcds_code01.rowposition,"ACCESS_NO") = gcem_accessno.text;
				gcds_code01.namevalue(gcds_code01.rowposition,"SEQ_NO") = sumValue;

}
		gctr_code01.Action = g_servlet+"/Transfer.tr00302_t1?";
		gctr_code01.Parameters = "v_str1=" + gs_userid +",v_str2=" + gs_userid + ",v_str3=" + txt_prsn_name.value;	
		gctr_code01.post();
		
		
	}else if(p=="02") {
	
		if (gcds_code02.RowStatus(gcds_code02.rowposition) == "1" ){
				var seq= txt_seq02.value;
				var sumValue = Number(seq)+ 1;

				gcds_code02.namevalue(gcds_code02.rowposition,"ACCSECTION") = gs_accsectiono;
				gcds_code02.namevalue(gcds_code02.rowposition,"ACCESSNO") = gcem_accessno.text;
				gcds_code02.namevalue(gcds_code02.rowposition,"SEQ_NO") = sumValue;
		}

		gctr_code02.Action = g_servlet+"/Transfer.tr00302_t2?";
		gctr_code02.Parameters = "v_str1=" + gs_userid +",v_str2=" + gs_userid;		
		gctr_code02.post();

	}else if(p=="03") {

		if (gcds_code03.RowStatus(gcds_code03.rowposition) == "1" ){
				var seq= txt_seq03.value;
				var sumValue = Number(seq)+ 1;

				gcds_code03.namevalue(gcds_code03.rowposition,"ACCSECTION") = gs_accsectioni;
				gcds_code03.namevalue(gcds_code03.rowposition,"ACCESS_NO") = gcem_accessno.text;
				gcds_code03.namevalue(gcds_code03.rowposition,"SEQ_NO") = sumValue;

}
		gctr_code03.Action = g_servlet+"/Transfer.tr00302_t3?";
		gctr_code03.Parameters = "v_str1=" + gs_userid +",v_str2=" + gs_userid + ",v_str3=" + txt_prsn_name.value;	
		gctr_code03.post();

	}else if(p=="04") {

	if (gcds_code04.RowStatus(gcds_code04.rowposition) == "1" ){
				var seq= txt_seq04.value;
				var sumValue = Number(seq)+ 1;

				gcds_code04.namevalue(gcds_code04.rowposition,"ACCSECTION") = gs_accsectioni;
				gcds_code04.namevalue(gcds_code04.rowposition,"ACCESS_NO") = gcem_accessno.text;
				gcds_code04.namevalue(gcds_code04.rowposition,"SEQ_NO") = sumValue;

}
		gctr_code04.Action = g_servlet+"/Transfer.tr00302_t4?";
		gctr_code04.Parameters = "v_str1=" + gs_userid +",v_str2=" + gs_userid;		
		gctr_code04.post();
	}
}

/******************************************************************************
	Description : Enable _ Disabled 
	parameter   : p==> t - Enable, f - Disable
******************************************************************************/
function ln_Enable(p2) {

	if (p2=="t")	{ //등록
			//gclx_prsn_cmpy04.enable=true;
			gcem_start_date.enable=true;
			gcem_start_date02.enable=true;
			gcem_rtrn_date03.enable=true;
			gcem_rtrn_date04.enable=true;
			
			gcem_start_time02.enable=true;
			gcem_rtrn_time04.enable=true;
			
			txt_purpose02.disabled=false;
			gclx_acc_area_a.enable=true;
			txt_job_duty02.disabled=false;
			txt_job_duty04.disabled=false;
			gclx_gender.enable=true;
			gclx_gender04.enable=true;
			gcem_prsn_regno.enable=true;
			gcem_prsn_regno04.enable=true;
			txt_address1.disabled=false;
			txt_address104.disabled=false;
			gclx_drive.enable=true;
			txt_remark02.disabled=false;
			txt_remark04.disabled=false;
			
		} else if (p2=="f") { //조회
			
			gclx_prsn_cmpy.enable=false;
			gclx_prsn_cmpy04.enable=false;
			gcem_start_date.enable=false;
			gcem_start_date02.enable=false;
			gcem_rtrn_date03.enable=false;
			gcem_rtrn_date04.enable=false;
			gcem_start_time02.enable=false;
			txt_purpose02.disabled=true;
			gclx_acc_area_a.enable=false;
			gclx_drive.enable=false;
			gclx_drive04.enable=false;
			txt_job_duty02.disabled=true;
			txt_job_duty04.disabled=true;
			gclx_gender.enable=false;
			gclx_gender04.enable=false;
			gcem_prsn_regno.enable=false;
			gcem_prsn_regno04.enable=false;
			txt_address1.disabled=true;
			txt_address104.disabled=true;
			txt_remark02.disabled=true;
			txt_remark04.disabled=true;
			gclx_acc_area_b.enable=false;

	}
}

/******************************************************************************
	Description : 출입계획 팝업
******************************************************************************/
function ln_Popup01(p){             

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	strURL = "/Transfer/html/TR00302_popup.html";
	strPos = "dialogWidth:370px;dialogHeight:220px;status:no;scroll:no;resizable:no";
 	arrResult = showModalDialog(strURL,'',strPos);

if (p=="01"){
	if (arrResult != null) {
		arrParam = arrResult.split(";");
	
		var str1 = arrParam[0];

			if (str1=="1"){

			ln_Print01();

	}else if(str1=="2") {

		ln_Print02();


	}else if(str1=="3") {

		ln_Print03();

	} else {
	alert("인쇄를 원하는 종목을 선택하십시오");
	}
}
}else if(p=='02'){

if (arrResult != null) {
		arrParam = arrResult.split(";");
	
		var str1 = arrParam[0];

			if (str1=="1"){

			ln_Print01();
			}else if(str1=="2") {

		ln_Print02();
		


	}else if(str1=="3") {
			ln_Print03();
	} else {
		alert("인쇄를 원하는 종목을 선택하십시오");
	}
}
}else if(p=='03'){

if (arrResult != null) {
		arrParam = arrResult.split(";");
	
		var str1 = arrParam[0];

			if (str1=="1"){

				ln_Print01();
			}else if(str1=="2") {
	
				ln_Print02();
		


	}else if(str1=="3") {

		ln_Print03();
			} else {
	alert("인쇄를 원하는 종목을 선택하십시오");
	}
}
}else if(p=='04'){

if (arrResult != null) {
		arrParam = arrResult.split(";");
	
	var str1 = arrParam[0];

		if (str1=="1"){
				ln_Print01();
		}else if(str1=="2") {
				ln_Print02();
		


		}else if(str1=="3") {

		ln_Print03();
		} else {
		alert("인쇄를 원하는 종목을 선택하십시오");
	}
}
}else if(p=='05'){

if (arrResult != null) {
		arrParam = arrResult.split(";");
	
		var str1 = arrParam[0];

			if (str1=="1"){

				ln_Print01();
			}else if(str1=="2") {
	
				ln_Print02();
		


	}else if(str1=="3") {

		ln_Print03();
			} else {
	alert("인쇄를 원하는 종목을 선택하십시오");
	}
}
}
}

/******************************************************************************
	Description : 차량번호 찾기(팝업)
******************************************************************************/
function ln_Popup02(p){             

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	row= gcds_code01.rowposition;

	strURL = "/Transfer/html/TR00302_popup02.html?gstr="+p
				+ "&" +gcds_code01.NameValue(row,"START_DATE") ; 
	strPos = "dialogWidth:383px;dialogHeight:499px;status:no;scroll:no;resizable:no";
 	arrResult = showModalDialog(strURL,'',strPos);

if(p=="01") {
	if (arrResult != null) {

			arrParam = arrResult.split(";");
			txt_car_no.value = arrParam[0];
			gcds_code01.NameValue(gcds_code01.Rowposition,"CAR_TYPE")  = arrParam[2];
			txt_car_type.value = arrParam[3];

			txt_prsn_name.value = arrParam[4];
			gcds_code01.NameValue(gcds_code01.Rowposition,"PERSON_NO")  = arrParam[5];


	}
}else if(p=="02") {
	if (gcds_code02.namevalue(gcds_code02.rowposition,"DRIVE_DIV")=="N"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_car_no02.value = arrParam[0];
			gcds_code03.NameValue(gcds_code03.Rowposition,"PERSON_NO")  = arrParam[4];
		}
	} else {
	alert("차량번호는 변경할 수 없습니다");
	}

}else if(p=="03") {
	if (arrResult != null) {

			arrParam = arrResult.split(";");
			txt_car_no03.value = arrParam[0];

			gcds_code03.NameValue(gcds_code03.Rowposition,"CAR_TYPE")  = arrParam[2];

			txt_car_type03.value = arrParam[3];

			txt_prsn_name03.value = arrParam[4];
			gcds_code03.NameValue(gcds_code03.Rowposition,"PERSON_NO")  = arrParam[5];
	
	}
}else if(p=="04") {
	if (arrResult != null) {
		if (gcds_code04.namevalue(gcds_code04.rowposition,"DRIVE_DIV")=="N"){
			arrParam = arrResult.split(";");
			txt_car_no04.value = arrParam[0];

			gcds_code03.NameValue(gcds_code03.Rowposition,"PERSON_NO")  = arrParam[4];
		}
	} else {

	}
}
}

/******************************************************************************
	Description : 운전자명 찾기(팝업)
******************************************************************************/
function ln_Popup03(p){             

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;


	row= gcds_code01.rowposition;

	strURL = "/Transfer/html/TR00302_popup03.html?gstr="+p
				+ "&" +gcds_code01.NameValue(row,"START_DATE") ; 
	strPos = "dialogWidth:537px;dialogHeight:499px;status:no;scroll:no;resizable:no";
 	arrResult = showModalDialog(strURL,'',strPos);

if(p=="01") {
	if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_prsn_name.value = arrParam[0];
			gcds_code01.NameValue(gcds_code01.Rowposition,"PERSON_NO")  = arrParam[7];
	}

}else if(p=="02") {
	if (gcds_code02.namevalue(gcds_code02.rowposition,"DRIVE_DIV")=="N"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");

			txt_prsn_name02.value = arrParam[0];
			gcds_code02.NameValue(gcds_code02.Rowposition,"COMPANY")  = arrParam[1];

			gcds_code02.NameValue(gcds_code02.Rowposition,"PRSN_CMPY")  = arrParam[1];

			txt_job_duty02.value = arrParam[3];
			gclx_gender.BindColVal = arrParam[4];
			gcem_prsn_regno.text = arrParam[5];
			txt_address1.value = arrParam[6];
			gcds_code02.NameValue(gcds_code02.Rowposition,"PERSON_NO")  = arrParam[7];
			}
	} else {
	alert("운전자는 변경할 수 없습니다");
	}

}else if(p=="03") {
	if (arrResult != null) {
			arrParam = arrResult.split(";");
		
			txt_prsn_name03.value = arrParam[0];
			gcds_code03.NameValue(gcds_code03.Rowposition,"PERSON_NO")  = arrParam[7];
	}
}else if(p=="04") {
	if (gcds_code04.namevalue(gcds_code04.rowposition,"DRIVE_DIV")=="N"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_prsn_name04.value = arrParam[0];
			gcds_code04.NameValue(gcds_code04.Rowposition,"COMPANY")  = arrParam[1];

			gcds_code04.NameValue(gcds_code04.Rowposition,"PRSN_CMPY")  = arrParam[1];

			txt_job_duty04.value = arrParam[3];
			gclx_gender04.BindColVal = arrParam[4];
			gcem_prsn_regno04.text = arrParam[5];
			txt_address104.value = arrParam[6];
			gcds_code04.NameValue(gcds_code04.Rowposition,"PERSON_NO")  = arrParam[7];
		}
	} else {
		alert("운전자는 변경할 수 없습니다");
	}
}
}

/******************************************************************************
	Description : 탭구분
	prameter    : 0-출경차량, 1-출경인원, 2-입경차량, 3-입경인원, 4-통행개요 
******************************************************************************/
function ln_DispChk(index,e){

  var div_cm = new Array("div_disp1","div_disp2","div_disp3","div_disp4","div_disp5");
	for(var i=0;i<5;i++)	{
		var v_cm = eval(div_cm[i]);
		v_cm.style.display = 'none';
	}

	var v_cm2 = eval(div_cm[index]);
	v_cm2.style.display = 'block';
	gs_tabindex = e;

	if (index==0) {
		if (gcds_code01.IsUpdated){
	
	}else {
		ln_Query();
	}
	}else if (index==1) {
	//alert("2");
		if (gcds_code02.IsUpdated){
	//alert(index);
	} else {
	//alert("aa");
		ln_Query02(); 
	}
	}else if(index==2) {
		if (gcds_code03.IsUpdated){
	} else {
		ln_Query03(); 
	
	}

	}else if(index==3) {
		if (gcds_code04.IsUpdated){
	} else {
		ln_Query04();
	}

	} else ln_Query05();

}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_code02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_code03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_code04 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_code05 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 프로젝트 -->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_project_cd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 물류비 부담 -->
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcds_project" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 출경목적지 -->
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcds_sreach_ciq" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 입력목적지 -->
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcds_rreach_ciq" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 출경-인원 -->
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcds_prsn_cmpy" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 입경-인원 -->
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcds_prsn_cmpy04" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!--  차종  -->
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcds_car_type" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>


<%=HDConstant.COMMENT_START%>
<OBJECT id="gcds_person" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id="gcds_personn" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id="gcds_car_type03" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!--  운전자명  -->
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcds_person_no" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!--  운전자명  -->
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcds_person_no03" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 출경-인원 -->
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcds_acc_area_a" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 입경-인원 -->
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcds_acc_area_b" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 통행개요[출경] -->
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcds_acc_area_aa" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 통행개요[출경] -->
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcds_acc_area_bb" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 차량인원 -->
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcds_car" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 차량인원 -->
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcds_carr" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 프로젝트 (통행개요-출경) -->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_project_cd_a classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 프로젝트 (통행개요-입경)-->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_project_cd_b classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 출력화면 (방문인원)-->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 출력화면 (군사분계선 통행계획[남])-->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_print01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 출력화면 (군사분계선 통행계획[북])-->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_print02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 출력화면군사분계선 통행신청서[UNC] )-->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_print03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_print04 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 조선인민공화국 -->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_print05 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 개성공업지구 방문계획 -->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_print06 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 복귀인원 -->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_print07 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 복귀인원 -->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_print08 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_print09 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_print10 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id="gcbn_code01" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id="gcbn_code02" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id="gcbn_code03" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id="gcbn_code04" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id="gcbn_code05" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gctr_code01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="tr00302_t1(I:USER=gcds_code01)"> 
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gctr_code02 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="tr00302_t2(I:USER=gcds_code02)"> 
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gctr_code03 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="tr00302_t3(I:USER=gcds_code03)"> 
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gctr_code04 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="tr00302_t4(I:USER=gcds_code04)"> 
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gctr_code05 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="tr00302_t5(I:USER=gcds_code05)"> 
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- 출경차량 -->
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";

</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";

	if (row <1 && gs_la==false) alert("검색된 데이터가 없습니다.");
</script>

<!-- 출경인원 -->
<script language="javascript" for="gcds_code02" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";

</script>

<script language="javascript" for="gcds_code02" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt02.innerText = "조회건수 : " + row + " 건";

	if (row <1 && gs_la==false) alert("검색된 데이터가 없습니다.");
</script>

<!-- 입경차량 -->
<script language="javascript" for="gcds_code03" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";

</script>

<script language="javascript" for="gcds_code03" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt03.innerText = "조회건수 : " + row + " 건";

	if (row <1 && gs_la==false) alert("검색된 데이터가 없습니다.");
</script>

<!-- 입경인원 -->
<script language="javascript" for="gcds_code04" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";

</script>

<script language="javascript" for="gcds_code04" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	
	ft_cnt04.innerText = "조회건수 : " + row + " 건";

	if (row <1 && gs_la==false) alert("검색된 데이터가 없습니다.");
</script>

<!-- 통행개요 -->
<script language="javascript" for="gcds_code05" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";

</script>

<script language="javascript" for="gcds_code05" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";

	if (row <1 && gs_la==false) alert("검색된 데이터가 없습니다.");
</script>

<!-- 프로젝트 -->
<script language="javascript" for="gcds_project_cd" event="onloadCompleted(row,colid)">
	gcds_project_cd.InsertRow(1);
	gcds_project_cd.NameValue(1,"MINORCD")="";
	gcds_project_cd.NameValue(1,"MINORNM")="전체";
	gclx_project_cd.index=0;
</script>

<!-- 물류비 부담 -->
<script language="javascript" for="gcds_project" event="onloadCompleted(row,colid)">
	gcds_project.InsertRow(1);
	gcds_project.NameValue(1,"CDCODE")="";
	gcds_project.NameValue(1,"CDNAM")="전체";
	gclx_project.index=0;
</script>

<!-- 프로젝트 (통행개요-출경) -->
<script language="javascript" for="gcds_project_cd_a" event="onloadCompleted(row,colid)">
	gcds_project_cd_a.InsertRow(1);
	gcds_project_cd_a.NameValue(1,"MINORCD")="";
	gcds_project_cd_a.NameValue(1,"MINORNM")="전체";
	gclx_project_cd_a.index=0;
</script>

<!-- 프로젝트 (통행개요-출경) -->
<script language="javascript" for="gcds_project_cd_b" event="onloadCompleted(row,colid)">
	gcds_project_cd_b.InsertRow(1);
	gcds_project_cd_b.NameValue(1,"MINORCD")="";
	gcds_project_cd_b.NameValue(1,"MINORNM")="전체";
	gclx_project_cd_b.index=0;
</script>


<!-- 출경목적지 -->
<script language="javascript" for="gcds_sreach_ciq" event="onloadCompleted(row,colid)">
	gcds_sreach_ciq.InsertRow(1);
	gcds_sreach_ciq.NameValue(1,"MINORCD")="";
	gcds_sreach_ciq.NameValue(1,"MINORNM")="전체";
	gclx_sreach_ciq.index=0;
</script>

<!-- 출경-인원 -->
<script language="javascript" for="gcds_prsn_cmpy" event="onloadCompleted(row,colid)">
	gcds_prsn_cmpy.InsertRow(1);
	gcds_prsn_cmpy.NameValue(1,"MINORCD")="";
	gcds_prsn_cmpy.NameValue(1,"MINORNM")="";
	gclx_prsn_cmpy.index=0;
</script> 

<!-- 입경-인원 -->
<script language="javascript" for="gcds_prsn_cmpy04" event="onloadCompleted(row,colid)">
	gcds_prsn_cmpy04.InsertRow(1);
	gcds_prsn_cmpy04.NameValue(1,"MINORCD")="";
	gcds_prsn_cmpy04.NameValue(1,"MINORNM")="";
	gclx_prsn_cmpy04.index=0;
</script> 

<!-- 출경-인원 -->
<script language="javascript" for="gcds_acc_area_a" event="onloadCompleted(row,colid)">
	gcds_acc_area_a.InsertRow(1);
	gcds_acc_area_a.NameValue(1,"MINORCD")="";
	gcds_acc_area_a.NameValue(1,"MINORNM")="";
	gclx_acc_area_a.index=0;
</script> 

<!-- 입경-인원 -->
 <script language="javascript" for="gcds_acc_area_b" event="onloadCompleted(row,colid)">
	gcds_acc_area_b.InsertRow(1);
	gcds_acc_area_b.NameValue(1,"MINORCD")="";
	gcds_acc_area_b.NameValue(1,"MINORNM")="";
	gclx_acc_area_b.index=0;
</script>  

<!-- 통행개요[출경] -->
<script language="javascript" for="gcds_acc_area_aa" event="onloadCompleted(row,colid)">
	gcds_acc_area_aa.InsertRow(1);
	gcds_acc_area_aa.NameValue(1,"MINORCD")="";
	gcds_acc_area_aa.NameValue(1,"MINORNM")="";
	gclx_acc_area_aa.index=0;
	
</script> 

<!-- 통행개요[입경] -->
<script language="javascript" for="gcds_acc_area_bb" event="onloadCompleted(row,colid)">
	gcds_acc_area_bb.InsertRow(1);
	gcds_acc_area_bb.NameValue(1,"MINORCD")="";
	gcds_acc_area_bb.NameValue(1,"MINORNM")="";
	gclx_acc_area_bb.index=0;
</script> 


<!-- 입경목적지 -->
<script language="javascript" for="gcds_rreach_ciq" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";   
	gcds_rreach_ciq.InsertRow(1);
	gcds_rreach_ciq.NameValue(1,"MINORCD")="";
	gcds_rreach_ciq.NameValue(1,"MINORNM")="전체";
	gclx_rreach_ciq.index=0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- 출입계획 -->
<script language="javascript" for="gcte_disp" event="CanSelChange(index)">
	if (eval("gcds_code0"+gs_tabindex).isUpdated) {

			if (confirm("변경된 정보가 있습니다.\n 저장하시겠습니까?")){	
				if(ln_Chk('0'+gs_tabindex)){
					ln_ll('0'+gs_tabindex);
		return true;
	} else { 
		return false;
		} 
	}
}
</script>

<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk(index-1,index);
</script>

<!-- 출경차량 -->
<script language="javascript"  for=gcds_code01 event=OnRowPosChanged(row)>

	txt_seq.value=gcgd_disp01.VirtualString(row,"seq");
	
</script>

<script language=JavaScript for="gcgd_disp01" event=OnClick(row,colid)>
	if (row < 1) ln_Enable("f");
	return; 
</script>   

<!-- 출경인원 -->
<script language="javascript"  for=gcds_code02 event=OnRowPosChanged(row)>

	txt_seq02.value=gcgd_disp02.VirtualString(row,"seq");
	if (gcds_code02.RowStatus(row) == "1" ) ln_Enable("t");
	else ln_Enable("f");
</script>

<script language=JavaScript for="gcgd_disp02" event=OnClick(row,colid)>
	if (gcds_code02.namevalue(gcds_code02.rowposition,"DRIVE_DIV")=="N"){ //비운전
		gclx_drive.enable=true; //등록 운전여부
		txt_remark02.disabled=false; //비고
		txt_job_duty02.disabled=false; //직책
		//gclx_gender.enable=true;
	} else { //운전
		gclx_drive.enable=false; //조회
		gclx_prsn_cmpy.enable=false;
		gclx_gender.enable=false;
		gcem_prsn_regno.enable=false;
		gcem_start_date02.enable=false;
		gcem_start_time02.enable=false;
		gclx_acc_area_a.enable=false;
		
		txt_job_duty02.disabled=true;
		txt_address1.disabled=true;
		txt_purpose02.disabled=true;
		txt_remark02.disabled=true;
		
	}
	if (row < 1)  ln_Enable("f");
	return; 
</script> 

<!-- 입경차량 -->
<script language="javascript"  for=gcds_code03 event=OnRowPosChanged(row)>

	txt_seq03.value=gcgd_disp03.VirtualString(row,"seq");
</script>

<script language=JavaScript for="gcgd_disp03" event=OnClick(row,colid)>
	if (row < 1)  ln_Enable("f");
	return; 
</script> 

<!-- 입경인원 -->
<script language="javascript"  for=gcds_code04 event=OnRowPosChanged(row)>

	txt_seq04.value=gcgd_disp04.VirtualString(row,"seq");
	if (gcds_code04.RowStatus(row) == "1" ) ln_Enable("t");
	else ln_Enable("f");
</script>

<script language=JavaScript for="gcgd_disp04" event=OnClick(row,colid)>
if (gcds_code04.namevalue(gcds_code04.rowposition,"DRIVE_DIV")=="N"){
		gclx_drive04.enable=true; //등록 운전여부
		txt_remark04.disabled=false; //비고
		txt_job_duty04.disabled=false; //직책
		
	} else {

		gclx_drive04.enable=false; //조회
		gclx_prsn_cmpy04.enable=false;
		gclx_gender04.enable=false;
		gcem_prsn_regno04.enable=false;
		gcem_rtrn_date04.enable=false;
		gcem_rtrn_time04.enable=false;
		gclx_acc_area_b.enable=false;
		
		txt_job_duty04.disabled=true;
		txt_address104.disabled=true;
		txt_purpose04.disabled=true;
		txt_remark04.disabled=true;

	}
	if (row < 1)  ln_Enable("f");
	return; 
</script> 

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_code01" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
	ln_Query();
</script>

<script language="javascript" for="gctr_code01" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language="javascript" for="gctr_code02" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
	ln_Query02();
</script>

<script language="javascript" for="gctr_code02" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language="javascript" for="gctr_code03" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
	ln_Query03();
</script>

<script language="javascript" for="gctr_code03" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language="javascript" for="gctr_code04" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
	ln_Query04();
</script>

<script language="javascript" for="gctr_code04" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language="javascript" for="gctr_code05" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
	ln_Query05();
</script>

<script language="javascript" for="gctr_code05" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s07.jsp"  flush="true"/>
<BODY>
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">

  <tr> 
	 <td background="../../../Common/img/com_t_bg.gif"><img src="../../../Common/img/com_t_bg.gif" ></td>
	 <td background="../../../Common/img/com_t_bg.gif"  align=right></td>
  </tr>

  		<tr> 
		<td colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        		<tr> 
				 <td width="70px"  style="" bgcolor="#eeeeee" class="tab21" align=center >프로젝트</td>
					<td class="tab21" >
					<%=HDConstant.COMMENT_START%>
					<OBJECT id=gclx_project_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_project_cd">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^160">
								<param name=BindColumn			value=MINORCD>
							</OBJECT>
					<%=HDConstant.COMMENT_END%>
						</td> 
						<td width="70px"  style="" bgcolor="#eeeeee" class="tab21" align=center >물류비 부담</td>
					<td class="tab21" >
					<%=HDConstant.COMMENT_START%>
					<OBJECT id=gclx_project classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_project">
								<param name=CBDataColumns		value="CDCODE, CDNAM">
								<param name=SearchColumn		value=CDNAM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="CDNAM^0^180">
								<param name=BindColumn			value=CDCODE>
							</OBJECT>
<%=HDConstant.COMMENT_END%>
						</td> 
					<td width="70px" class="tab21" bgcolor="#eeeeee" align="center">출경일자</td> 
					 <td  class="tab21" width="180px;" >  
						<%=HDConstant.COMMENT_START%>
<OBJECT id=gcem_acc_date_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
						style="position:relative;top:2px;left:5px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</OBJECT>
<%=HDConstant.COMMENT_END%>&nbsp;&nbsp;~
           <%=HDConstant.COMMENT_START%>
<OBJECT id=gcem_acc_date_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
						style="position:relative;top:2px;left:0px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</OBJECT>
<%=HDConstant.COMMENT_END%>
					
					</td> 
					<td width="70px" class="tab21" bgcolor="#eeeeee" align="center">입경일자</td> 
				  <td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:1px;text-align;height:30px;font-family:굴림;font-size:9pt;" width="180px;" >&nbsp;    
						<%=HDConstant.COMMENT_START%>
<OBJECT id=gcem_rtrn_date_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
						style="position:relative;top:2px;left:0px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</OBJECT>
<%=HDConstant.COMMENT_END%><!-- &nbsp; -->
					~
	          <%=HDConstant.COMMENT_START%>
<OBJECT id=gcem_rtrn_date_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
						style="position:relative;top:2px;left:0px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</OBJECT>
<%=HDConstant.COMMENT_END%>
				
					</td> 
					<tr>
						<td width="70px" class="tab12" bgcolor="#eeeeee" align=center>출경목적지</td>
						<td class="tab12" >
							<%=HDConstant.COMMENT_START%>
<OBJECT id=gclx_sreach_ciq classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:1px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_sreach_ciq">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^80">
								<param name=BindColumn			value=MINORCD>
							</OBJECT>
<%=HDConstant.COMMENT_END%>
						</td> 
						<td width="70px" class="tab12" bgcolor="#eeeeee" align=center>입경목적지</td>
						<td class="tab12" >
							<%=HDConstant.COMMENT_START%>
<OBJECT id=gclx_rreach_ciq classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:1px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_rreach_ciq">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^80">
								<param name=BindColumn			value=MINORCD>
							</OBJECT>
<%=HDConstant.COMMENT_END%>
						</td> 
						<td class="tab12" bgcolor="#eeeeee" align=center>출입번호</td>
										
					 <td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:9pt; " onkeydown="if(event.keyCode==13) ln_Query();">
								<%=HDConstant.COMMENT_START%>
<OBJECT id=gcem_accessno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="##########">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
							</OBJECT>
<%=HDConstant.COMMENT_END%>
						</td>
						<td width="70px"class="tab12" bgcolor="#eeeeee" align=center>&nbsp;</td>
						<td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;" >
					</td> 
				</tr>
			</table>
		</td>
	</tr> 
	
<td height="5px" colspan =2>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr>
					<td width="0" align=right>
						 <%=HDConstant.COMMENT_START%>
<OBJECT id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:640px;height:20px;">
							<PARAM NAME="BackColor"					VALUE="#cccccc">
   							<PARAM NAME="titleHeight"				VALUE="20px">
							<PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
							<PARAM NAME="Format"						VALUE="
							  <T>divid=div_1		title='출경-차량(남-->북)'</T>								
							  <T>divid=div_2		title='출경-인원(남-->북)'</T>
							  <T>divid=div_3		title='입경-차량(북-->남)'</T>
							  <T>divid=div_4		title='입경-인원(북-->남)'</T>
   							  <T>divid=div_5		title='통행개요 및 기타물품'</T>
						  ">
						</OBJECT>
<%=HDConstant.COMMENT_END%> 
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!-- 출경-차량(남->북)===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td align ="top" colspan=2>
			<img src="../../../Common/img/btn/com_b_query.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Query()"> 
			<img src="../../../Common/img/btn/com_b_save.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Save()">
			<img src="../../../Common/img/btn/com_b_insert.gif"	align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Add()"> 
			<img src="../../../Common/img/btn/com_b_delete.gif"	align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Delete()">
			<img src="../../../Common/img/btn/com_btn_start_print.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Popup01('01')">
			<img src="../../../Common/img/btn/com_btn_person_cnt.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Print()">
			<img src="../../../Common/img/btn/btn_print3.gif"		 align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Print04()"> 
						
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:866px;border:0 solid #708090;">
		<tr> 			
			<td style="width:875;height:270px" ALIGN=LEFT VALIGN=TOP>
				<%=HDConstant.COMMENT_START%>
				<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
					style="position:relative;left:3px;width:875px; height:260px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_code01">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<PARAM NAME="Sort"		    VALUE="true"> 
						<PARAM NAME="ColSizing"   VALUE="true"> 
						<Param Name="Editable"    VALUE="false"> 
						<PARAM NAME="Format"			VALUE="  
						<F> Name='순번'	     	    ID=SEQ 		  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	align=center    
						Value={ToString(CurRow)}</F>
						<C> Name='차량번호'	      ID=CAR_NO		    HeadAlign=Center HeadBgColor=#B9D4DC Width=84	align=center	 </C> 
						<C> Name='차종'		        ID=CAR_NAME     HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=left EditStyle=Lookup
						Data='gcds_car_type:car_type:car_name' 	  </C> 
						<C> Name='인원'					  ID=PERSON_CNT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=right    </C> 
						<C> Name='화물'					  ID=RDS_GOODS	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left	   </C>
						<C> Name='운전자'					ID=PSN_KNAME  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=center  
						EditStyle=Lookup Data='gcds_person_no:person_no:prsn_name'</C>
						<G> Name='출경일시'												HeadAlign=Center HeadBgColor=#B9D4DC 
						<C> Name='출경날짜'				ID=START_DATE   HeadAlign=Center HeadBgColor=#B9D4DC Width=70	 align=center 
						MASK='XXXX/XX/XX' </C> 
						<C> Name='출경시간'				ID=START_TIME   HeadAlign=Center HeadBgColor=#B9D4DC Width=54	 align=center
						MASK='XX:XX' </C> </G>
						<C> Name='출입목적'				ID=PURPOSE      HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=left    </C> 
						<C> Name='비고'						ID=REMARK       HeadAlign=Center HeadBgColor=#B9D4DC Width=310	align=left    </C> 
						">
				</OBJECT>
				<%=HDConstant.COMMENT_END%>
					<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
				&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table> 
	<tr>
		<td align ="top">
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:4px;width:877px;border:1 solid #708090;">
				<tr> 				
				<td width="30px"   height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >순번</td>
			    <td width="120px"  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >차량번호</td>
				<td width="110px"  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >차종</td>
				<td width="30px"   height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >인원</td>
				<td width="120px"  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >화물</td>
				<td width="120px"  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >운전자</td>
				<td width="80px"   height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >출경날짜</td>
				<td width="70px"   height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >출경시간</td>
				<td width="160px"  height ="30px" style="" bgcolor="#eeeeee" class="tab22" align=center>출입목적</td>
			</tr>
			<tr>
				<td class="tab11" >
					<input id="txt_seq" type="text" class="txtbox"  style= "position:relative;left:0px;top:1px;width:24px; height:20px;" maxlength="3" onBlur="bytelength(this,this.value,3);" disabled> </td>
				<td class="tab11" >
					<input id="txt_car_no" type="text" class="txtbox"  style= "position:relative;left:2px;top:3px;width:90px; height:20px;" maxlength="12" onBlur="bytelength(this,this.value,36);" disabled>
					<img SRC="../../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="차량을 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px" align=center onclick="if (gcds_code01.RowStatus(gcds_code01.rowposition) == '1' ) ln_Popup02('01');" >   </td>
				<td class="tab11" >
					 <input id="txt_car_type" type="text" class="txtbox"  style= "position:relative;top:1px;width:100px; height:20px;" maxlength="20" onBlur="bytelength(this,this.value,20);" disabled> </td>  
				<td class="tab11" >
					<input id="txt_person_cnt" type="text" class="txtbox"  style= "position:relative;top:1px;width:20px; height:20px;" maxlength="5" onBlur="bytelength(this,this.value,5);" > </td>
				<td class="tab11" >
					<input id="txt_rds_goods" type="text" class="txtbox"  style= "position:relative;top:1px;width:110px; height:20px;" maxlength="50" onBlur="bytelength(this,this.value,50);" > </td>
				<td class="tab11" >
					<input id="txt_prsn_name" type="text" class="txtbox"  style= "position:relative;left:0px;top:3px;width:60px; height:20px;" maxlength="20" onBlur="bytelength(this,this.value,20);" disabled> 
					<img SRC="../../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="운전자명을 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px" align=center  onclick="if  
					(gcds_code01.RowStatus(gcds_code01.rowposition) == '1' ) ln_Popup03('01');" > 
				</td>
				<td class="tab11" >
					<%=HDConstant.COMMENT_START%>
					<OBJECT id=gcem_start_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:0px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="YYYY/MM/DD">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false> 
										<param name=PromptChar	value="_">
							</OBJECT>
						<%=HDConstant.COMMENT_END%></td>
						<td class="tab19" >
						 <%=HDConstant.COMMENT_START%>
						<OBJECT id=gcem_start_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="00:00">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false> 
										<param name=PromptChar	value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%></td>
						<td class="tab22" >
							<input id="txt_purpose" type="text" class="txtbox"  style= "position:relative;left:4px;top:1px;width:150px; height:20px;" maxlength="100" onBlur="bytelength(this,this.value,100);" > </td>  
					</tr>
					<tr> 	
						<td height ="30px" class="tab22" bgcolor="#eeeeee" align=center colspan="9">비고</td>
					</tr>
					<tr>
						 <td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:9pt; "  colspan="9"> 
						 <textarea id="txt_remark" class="txtbox"  style= "width:860px; height:23px; overflow:auto;position:relative;left:4px" maxlength="512" onBlur="bytelength(this,this.value,512);"></textarea></td> 
					</tr>
				</table>
			</td>
		</tr>
</table>		

<!-- 출경-인원(남->북)============================================================================================================-->
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="display:none">
<tr>
		<td align ="top" colspan=2>
			<img src="../../../Common/img/btn/com_b_query.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Query02()"> 
			<img src="../../../Common/img/btn/com_b_save.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Save02()">
			<img src="../../../Common/img/btn/com_b_insert.gif"	align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Add02()"> 
			<img src="../../../Common/img/btn/com_b_delete.gif"	align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Delete02()">
			<img src="../../../Common/img/btn/com_btn_start_print.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Popup01('02')">
			<img src="../../../Common/img/btn/com_btn_person_cnt.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Print()">
			<img src="../../../Common/img/btn/btn_print3.gif"		 align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Print04()">
				
	<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:866px;border:0 solid #708090;">
		<tr> 			
			<td style="width:875" ALIGN=LEFT VALIGN=TOP>
				<%=HDConstant.COMMENT_START%>
				<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
					style="position:relative;left:3px;width:875px; height:260px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_code02">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<PARAM NAME="Sort"		    VALUE="true"> 
						<PARAM NAME="ColSizing"   VALUE="true"> 
						<Param Name="Editable"    VALUE="false"> 
						<PARAM NAME="Format"			VALUE="  
						<F> Name='순번'	     		  ID=SEQ 		  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center  Edit=true  			Value={ToString(CurRow)}</F>
						<C> Name='성명'				  ID=PRSN_NAME		  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=center	  	EditStyle=Lookup Data='gcds_person_no:person_no:prsn_name'</C> 
						<C> Name='소속'				  ID=PRSN_CMPY      HeadAlign=Center HeadBgColor=#B9D4DC Width=96  	align=left	  EditStyle=Lookup	 
						Data='gcds_prsn_cmpy:MINORCD:MINORNM' </C> 
						<C> Name='직책'				  ID=JOB_DUTY 	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=center   
						</C> 
						<C> Name='성별'				  ID=GENDER		      HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center
						EditStyle=Combo		Data='M:남,F:여' 				</C> 
						<C> Name='주민번호'			  ID=PRSN_REGNO   	HeadAlign=Center HeadBgColor=#B9D4DC Width=96	  align=center    
						 MASK ='XXXXXX-XXXXXXX' </C>
						<C> Name='주소'				  ID=ADDRESS1	      HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=left      </C>
						<G> Name='출경일시'				HeadAlign=Center HeadBgColor=#B9D4DC 
						<C> Name='출경날짜'		      ID=START_DATE     HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=center    
						MASK='XXXX/XX/XX' </C>
						<C> Name='출경시간'			  ID=START_TIME     HeadAlign=Center HeadBgColor=#B9D4DC Width=54	  align=center    		MASK='XX:XX' 				</C></G>
						<C> Name='출입목적'			  ID=PURPOSE        HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=left     </C>
						<C> Name='출입지역'			  ID=ACC_AREA       HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left   EditStyle=Lookup
						Data='gcds_acc_area_a:MINORCD:MINORNM'</C> 
						<C> Name='차량번호'			  ID=CAR_NO         HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=left     </C> 
						<C> Name='운전'				  ID=DRIVE_DIV		  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=center
						EditStyle=Combo		Data='Y:운전,N:비운전' </C> 
						<C> Name='비고'				  ID=REMARK         HeadAlign=Center HeadBgColor=#B9D4DC Width=320	align=left     </C> 
						">
				</OBJECT>
					<%=HDConstant.COMMENT_END%>
					<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
				&nbsp;<font id=ft_cnt02 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
<tr>
		<td align ="top" colspan=2>
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:4px;width:877px;border:1 solid #708090;">
					<tr> 	
						<td width="30px"  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >순번</td>
					  <td width="120px" height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >성명</td>
						<td width="120px" height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >소속</td>
						<td width="80px"  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >직책</td>
						<td width="70px"  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >성별</td>
						<td width="100px" height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >주민번호</td>
						<td width="140px" height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >주소</td>
						<td width="80px"  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >출경날짜</td>
						<td width="70px"  height ="30px" style="" bgcolor="#eeeeee" class="tab22" align=center >출경시간</td>
					</tr>
					<tr>
					<td class="tab11" >
						<input id="txt_seq02" type="text" class="txtbox"  style= "position:relative;top:1px;width:24px; height:20px;" maxlength="3" onBlur="bytelength(this,this.value,3);" disabled> </td>
					<td class="tab11" >
						<input id="txt_prsn_name02" type="text" class="txtbox"  style= "position:relative;top:3px;width:60px; height:20px;" maxlength="20" onBlur="bytelength(this,this.value,20);"  disabled> 
						<img SRC="../../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="운전자명을 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px" align=center  onclick="if 
						(gcds_code02.namevalue(gcds_code02.rowposition,'DRIVE_DIV')=='N') ln_Popup03('02');" > 
							</td>
					<td class="tab11" >
						<%=HDConstant.COMMENT_START%>
							<OBJECT id=gclx_prsn_cmpy classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:4px;top:1px;font-size:12px;width:110px;">
									<param name=ComboDataID			value="gcds_prsn_cmpy">
									<param name=CBDataColumns		value="MINORCD, MINORNM">
									<param name=SearchColumn		value=MINORNM>
									<param name=SortColumn      value="MINORCD"> 
									<param name=Sort			      value=True>
									<param name=ListExprFormat	value="MINORCD^0^70,MINORNM^0^100">
									<param name=BindColumn			value=MINORCD>
							</OBJECT>
						<%=HDConstant.COMMENT_END%> </td> 
						<td class="tab11" >	
							<input id="txt_job_duty02" type="text" class="txtbox"  style= "position:relative;left:0px;top:1px;width:70px; height:20px;" maxlength="30" onBlur="bytelength(this,this.value,30);" > </td>
						<td class="tab11" >	
							<%=HDConstant.COMMENT_START%>
						<OBJECT id=gclx_gender classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:0px;top:1px;font-size:12px;width:60px;height:200px;" >
								<param name=CBData					value="M^남,F^여">
								<param name=CBDataColumns		value="Code,Parm">
								<param name=SearchColumn		value="Parm">
 								<param name=Sort						value="false">
								<param name=ListExprFormat	value="Parm^0^40">
								<param name=BindColumn			value="Code">
						</OBJECT>
					<%=HDConstant.COMMENT_END%>
					<td class="tab11" >	
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=gcem_prsn_regno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:0px;top:0px">		
										<param name=Text					value="">  
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=ClipMode	    value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="000000-0000000">
										<param name=PromptChar    value="_">
								    <param name=BackColor     value="#CCCCCC"> 
								</OBJECT>
						<%=HDConstant.COMMENT_END%></td>
						<td class="tab11_left" >	
							<input id="txt_address1" type="text" class="txtbox"  style= "position:relative;top:1px;width:110px; height:20px;left:4px;" maxlength="36" onBlur="bytelength(this,this.value,36);" > </td>
						<td class="tab11" >	
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=gcem_start_date02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:0px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="YYYY/MM/DD">
										<param name=PromptChar    value="_">
										<param name=BackColor     value="#CCCCCC">
									</OBJECT>
								<%=HDConstant.COMMENT_END%></td>
							<td class="tab22" >
							 <%=HDConstant.COMMENT_START%>
							<OBJECT id=gcem_start_time02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="00:00">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false> 
										<param name=PromptChar	value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%></td>
					</tr>
					<tr>
						<td  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center colspan="3" >출입목적</td>
						<td  width="80px"   style="" bgcolor="#eeeeee" class="tab21" align=center  >출입지역</td>
						<td  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center colspan="2" >차량번호</td>
						<td  height ="30px" width="70px"  style="" bgcolor="#eeeeee" class="tab21" align=center  >운전</td>
						<td  height ="30px" style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:1px;text-align;height:25px;font-family:굴림;font-size:9pt;" bgcolor="#eeeeee" class="tab21" align=center  colspan="8">비고</td>
					</tr>
					<tr> 
						<td class="tab12_left"  colspan="3"> 
							 <input id="txt_purpose02" type="text" class="txtbox"  style= "position:relative;left:4px;top:1px;width:120px; height:20px;" maxlength="100" onBlur="bytelength(this,this.value,100);" > </td> 
						<td class="tab12"  >
							<%=HDConstant.COMMENT_START%>
						<OBJECT id=gclx_acc_area_a classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:4px;top:1px;font-size:12px;width:70px;">
									<param name=ComboDataID			value="gcds_acc_area_a">
									<param name=CBDataColumns		value="MINORCD, MINORNM">
									<param name=SearchColumn		value=MINORNM>
									<param name=SortColumn      value="MINORCD"> 
									<param name=Sort			      value=True>
									<param name=ListExprFormat	value="MINORCD^0^50,MINORNM^0^70">
									<param name=BindColumn			value=MINORCD>
							</OBJECT>
							<%=HDConstant.COMMENT_END%> </td> 
						 <td class="tab12_left" colspan="2" > 
							<input id="txt_car_no02" type="text" class="txtbox"  style= "position:relative;left:4px;top:3px;width:90px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> 
							<img SRC="../../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="차량번호를 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px" align=center  onclick="if 
						(gcds_code02.namevalue(gcds_code02.rowposition,'DRIVE_DIV')=='N') ln_Popup02('02');" > 
							</td>  
						 <td class="tab12_left"  > 
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=gclx_drive classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:1px;font-size:12px;width:60px;height:200px;" >
									<param name=CBData					value="Y^운전,N^비운전">
									<param name=CBDataColumns		value="Code, Parm">
									<param name=SearchColumn		value="Parm">
 									<param name=Sort						value="false">
									<param name=ListExprFormat	value="Parm^0^60">
									<param name=BindColumn			value="Code">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;text-align;height:23px;font-family:굴림;font-size:9pt; " colspan="8">
						 <textarea id="txt_remark02" class="txtbox"  style= "width:150px; height:20px; overflow:auto;position:relative;left:4px" maxlength="512" onBlur="bytelength(this,this.value,512);"></textarea></td> 
						</tr>
				</table>
			</td>
		</tr>

</table>		
<!-- 입경-차량(북->남)============================================================================================================-->
<table id="div_disp3" cellpadding="0" cellspacing="0" border="0" style="display:none">
<tr>
		<td align ="top" colspan=2>
			<img src="../../../Common/img/btn/com_b_query.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Query03()"> 
			<img src="../../../Common/img/btn/com_b_save.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Save03()">
			<img src="../../../Common/img/btn/com_b_insert.gif"	align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Add03()"> 
			<img src="../../../Common/img/btn/com_b_delete.gif"	align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Delete03()">
			<img src="../../../Common/img/btn/com_btn_start_print.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Popup01('03')">
			<img src="../../../Common/img/btn/com_btn_person_cnt.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Print()">
			<img src="../../../Common/img/btn/btn_print3.gif"		 align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Print04()">
			

	<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:866px;border:0 solid #708090;">
		<tr> 			
			<td style="width:875" ALIGN=LEFT VALIGN=TOP>
				<%=HDConstant.COMMENT_START%>
					<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp03  
					style="position:relative;left:3px;width:875px; height:260px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_code03">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<PARAM NAME="Sort"		    VALUE="true"> 
						<PARAM NAME="ColSizing"   VALUE="true"> 
						<Param Name="Editable"    VALUE="false"> 
						<PARAM NAME="Format"			VALUE="  
						<F> Name='순번'	     	    ID=SEQ 		  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	 align=center    
						Value={ToString(CurRow)}</F>
						<C> Name='차량번호'	      ID=CAR_NO		    HeadAlign=Center HeadBgColor=#B9D4DC Width=84	 align=center	 </C> 
						<C> Name='차종'		        ID=CAR_NAME     HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=left	  
						 EditStyle=Lookup 	Data='gcds_car_type:car_type:car_name' 	</C> 
						<C> Name='인원'					  ID=PERSON_CNT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=30	 align=right    
						</C> 
						<C> Name='화물'					  ID=RDS_GOODS	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90	 align=left	    </C> 
						<C> Name='운전자'					ID=PSN_KNAME   	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	 align=center   
						EditStyle=Lookup Data='gcds_person_no:person_no:prsn_name' </C>
						<G> Name='복귀일시'												HeadAlign=Center HeadBgColor=#B9D4DC 
						<C> Name='복귀날짜'				ID=RTRN_DATE    HeadAlign=Center HeadBgColor=#B9D4DC Width=70	 align=center  
						MASK='XXXX/XX/XX' </C> 
						<C> Name='복귀시간'				ID=RTRN_TIME    HeadAlign=Center HeadBgColor=#B9D4DC Width=54	 align=center   
						MASK='XX:XX'</C> </G>
						<C> Name='출입목적'				ID=PURPOSE      HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=left    </C> 
						<C> Name='비고'						ID=REMARK       HeadAlign=Center HeadBgColor=#B9D4DC Width=320	align=left    </C> 
						</C>
						">
					</OBJECT>
					<%=HDConstant.COMMENT_END%>
					<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
				&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
<tr>
		<td align ="top" colspan=2>
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:4px;width:877px;border:1 solid #708090;">
					<tr> 	
					  <td width="30px"   height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >순번</td>
					  <td width="120px"  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >차량번호</td>
						<td width="110px"  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >차종</td>
						<td width="30px"   height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >인원</td>
						<td width="120px"  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >화물</td>
						<td width="120px"  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >운전자</td>
						<td width="80px"   height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >복귀날짜</td>
						<td width="70px"   height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >복귀시간</td>
						<td width="160px"  height ="30px" style="" bgcolor="#eeeeee" class="tab22" align=center>출입목적</td>
					</tr>
				<tr>
					<td class="tab11" >
						<input id="txt_seq03" type="text" class="txtbox"  style= "position:relative;top:1px;width:24px; height:20px;" maxlength="3" onBlur="bytelength(this,this.value,3);" disabled> </td>
					<td class="tab11" >
						<input id="txt_car_no03" type="text" class="txtbox"  style= "position:relative;top:3px;width:90px; height:20px;" maxlength="12" onBlur="bytelength(this,this.value,36);" disabled>
						<img SRC="../../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="차량을 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px" align=center onclick="if (gcds_code03.RowStatus(gcds_code03.rowposition) == '1' ) ln_Popup02('03');" >   </td>
					<td class="tab11" >
						<input id="txt_car_type03" type="text" class="txtbox"  style= "position:relative;top:1px;width:100px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> </td>
					<td class="tab11" >
						<input id="txt_person_cnt03" type="text" class="txtbox"  style= "position:relative;top:1px;width:20px; height:20px;" maxlength="5" onBlur="bytelength(this,this.value,5);" > </td>
					<td class="tab11" >
						<input id="txt_rds_goods03" type="text" class="txtbox"  style= "position:relative;top:1px;width:100px; height:20px;" maxlength="40" onBlur="bytelength(this,this.value,40);" > </td>
					<td class="tab11" >
						<input id="txt_prsn_name03" type="text" class="txtbox"  style= "position:relative;top:3px;width:60px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> 
						<img SRC="../../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="운전자명을 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px" align=center  onclick="if  
						(gcds_code03.RowStatus(gcds_code03.rowposition) == '1' ) 					 ln_Popup03('03');" > </td>
					<td class="tab11" >
						<%=HDConstant.COMMENT_START%>
							<OBJECT id=gcem_rtrn_date03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:0px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="YYYY/MM/DD">
										<param name=PromptChar    value="_">
										<param name=BackColor     value="#CCCCCC">
							</OBJECT>
							<%=HDConstant.COMMENT_END%></td>
						<td class="tab19" >
						  <%=HDConstant.COMMENT_START%>
						<OBJECT id=gcem_rtrn_time03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="00:00">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false> 
										<param name=PromptChar	value="_">
						 	</OBJECT>
							<%=HDConstant.COMMENT_END%></td>
						<td class="tab22" >
							<input id="txt_purpose03" type="text" class="txtbox"  style= "position:relative;left:4px;top:1px;width:140px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" > </td>  
						</tr>		 
						<tr>
							<td height ="30px" class="tab22" bgcolor="#eeeeee" align=center colspan="9">비고</td>
						</tr>
						<tr>
							<td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:9pt; "  colspan="9"> 
							 <textarea id="txt_remark03" class="txtbox"  style= "width:860px; height:23px; overflow:auto;position:relative;left:4px" maxlength="30" onBlur="bytelength(this,this.value,30);"></textarea></td> 
						</tr>
				</table>
			</td>
		</tr>
</table>		

<!-- 입경-인원(북->남)============================================================================================================-->
<table id="div_disp4" cellpadding="0" cellspacing="0" border="0" style="display:none">
<tr>
		<td align ="top" colspan=2>
				<img src="../../../Common/img/btn/com_b_query.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Query04()"> 
				<img src="../../../Common/img/btn/com_b_save.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Save04()">
				<img src="../../../Common/img/btn/com_b_insert.gif"	align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Add04()"> 
				<img src="../../../Common/img/btn/com_b_delete.gif"	align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Delete04()">
				<img src="../../../Common/img/btn/com_btn_start_print.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Popup01('04')">
				<img src="../../../Common/img/btn/com_btn_person_cnt.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Print()">
				<img src="../../../Common/img/btn/btn_print3.gif"		 align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Print04()">

		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:866px;border:0 solid #708090;">
			<tr> 			
			<td style="width:875" ALIGN=LEFT VALIGN=TOP>
				<%=HDConstant.COMMENT_START%>
				<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp04
					style="position:relative;left:3px;width:875px; height:260px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_code04">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<PARAM NAME="Sort"		    VALUE="true"> 
						<PARAM NAME="ColSizing"   VALUE="true"> 
						<Param Name="Editable"    VALUE="false"> 
						<PARAM NAME="Format"			VALUE="  
						<F> Name='순번'	     	  ID=SEQ 		  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center  Edit=true  
						Value={ToString(CurRow)}</F>
						<C> Name='성명'					ID=PRSN_NAME		  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=center	Edit=none  </C> 
						<C> Name='소속'					ID=PRSN_CMPY      HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left	  EditStyle=Lookup  
						Data='gcds_prsn_cmpy04:MINORCD:MINORNM' </C> 
						<C> Name='직책'				  ID=JOB_DUTY 	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=center  Edit=none 
						</C> 
						<C> Name='성별'				  ID=GENDER		        HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center	
						Value = {Decode(GENDER,'M','남','F','여')} </C> 
						<C> Name='주민번호'			ID=PRSN_REGNO	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=96	  align=center  Edit=none  
						MASK ='XXXXXX-XXXXXXX' </C>
						<C> Name='주소'					ID=ADDRESS1	      HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=left  Edit=none  </C>
						<G> Name='복귀일시'												HeadAlign=Center HeadBgColor=#B9D4DC 
						<C> Name='복귀날짜'			ID=RTRN_DATE      HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=center  Edit=none  
						MASK='XXXX/XX/XX' </C>
						<C> Name='복귀시간'			ID=RTRN_TIME      HeadAlign=Center HeadBgColor=#B9D4DC Width=54	  align=center  Edit=none  
						MASK='XX:XX' </C></G>
						<C> Name='출입목적'			ID=PURPOSE       HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=left   Edit=none  </C>
						<C> Name='출입지역'			ID=ACC_AREA         HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left    EditStyle=Lookup Data='gcds_acc_area_b:MINORCD:MINORNM'</C>  
						<C> Name='차량번호'			ID=CAR_NO         HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left   Edit=none  </C> 
						<C> Name='운전'					ID=DRIVE_DIV      HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=left   Edit=none 
						Value={Decode(DRIVE_DIV,'Y','운전','N','비운전')} </C> 
						<C> Name='비고'					ID=REMARK         HeadAlign=Center HeadBgColor=#B9D4DC Width=310	align=left   Edit=none  </C> 
						</C>
						">
				</OBJECT>
				<%=HDConstant.COMMENT_END%>
					<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
				&nbsp;<font id=ft_cnt04 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
<tr>
		<td align ="top" colspan=2>
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:4px;width:877px;border:1 solid #708090;">
					<tr> 	
						<td width="30px"  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >순번</td>
		   			    <td width="120px" height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >성명</td>
						<td width="120px"  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >소속</td>
						<td width="80px"  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >직책</td>
						<td width="70px"  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >성별</td>
						<td width="100px" height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >주민번호</td>
						<td width="120px" height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >주소</td>
						<td width="80px"  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >복귀날짜</td>
						<td width="70px"  height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center >복귀시간</td>
						<td width="70px"  height ="30px" style="" bgcolor="#eeeeee" class="tab22" align=center>출입목적</td>
					</tr>
				<tr>
				<td class="tab11" >
				 	<input id="txt_seq04" type="text" class="txtbox"  style= "position:relative;left:0px;top:1px;width:24px; height:20px;" maxlength="3" onBlur="bytelength(this,this.value,3);" disabled > </td>
				<td class="tab11" >
					<input id="txt_prsn_name04" type="text" class="txtbox"  style= "position:relative;top:3px;width:60px; height:20px;" maxlength="12" onBlur="bytelength(this,this.value,36);" disabled> 
					<img SRC="../../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="운자자명을 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px" align=center onclick="if 
					(gcds_code04.namevalue(gcds_code04.rowposition,'DRIVE_DIV')=='N') ln_Popup03('04');" onclick="ln_Popup03('04');">  </td>
					
				<td class="tab11" >
					<%=HDConstant.COMMENT_START%>
					<OBJECT id=gclx_prsn_cmpy04 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:4px;top:1px;font-size:12px;width:110px;">
									<param name=ComboDataID			value="gcds_prsn_cmpy04">
									<param name=CBDataColumns		value="MINORCD, MINORNM">
									<param name=SearchColumn		value=MINORNM>
									<param name=SortColumn      value="MINORCD"> 
									<param name=Sort			      value=True>
									<param name=ListExprFormat	value="MINORCD^0^70,MINORNM^0^100">
									<param name=BindColumn			value=MINORCD>
							</OBJECT>
					<%=HDConstant.COMMENT_END%> </td> 
					<td class="tab11" >
						<input id="txt_job_duty04" type="text" class="txtbox"  style= "position:relative;left:0px;top:1px;width:70px; height:20px;" maxlength="20" onBlur="bytelength(this,this.value,20);" > </td>
					<td class="tab11" >
					<%=HDConstant.COMMENT_START%>
					<OBJECT id=gclx_gender04 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:4px;top:1px;font-size:12px;width:60px;height:200px;" >
									<param name=CBData					value="M^남,F^여">
									<param name=CBDataColumns		value="Code, Parm">
									<param name=SearchColumn		value="Parm">
 									<param name=Sort						value="false">
									<param name=ListExprFormat	value="Parm^0^60">
									<param name=BindColumn			value="Code">
							</OBJECT>
						<%=HDConstant.COMMENT_END%>
					<td class="tab11" >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=gcem_prsn_regno04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=ClipMode	    value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="000000-0000000">
										<param name=PromptChar    value="_">
								    <param name=BackColor     value="#CCCCCC"> 
								</OBJECT>
						<%=HDConstant.COMMENT_END%></td>
					<td class="tab11" >
						<input id="txt_address104" type="text" class="txtbox"  style= "position:relative;left:0px;top:1px;width:110px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" > </td>
					<td class="tab11" >
					<%=HDConstant.COMMENT_START%>
						<OBJECT id=gcem_rtrn_date04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="YYYY/MM/DD">
										<param name=PromptChar    value="_">
										<param name=BackColor     value="#CCCCCC">
							</OBJECT>
					<%=HDConstant.COMMENT_END%></td>
 					<td class="tab11_left" > 
					 <%=HDConstant.COMMENT_START%>
					<OBJECT id=gcem_rtrn_time04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="00:00">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false> 
										<param name=PromptChar	value="_">
						 	</OBJECT>
					<%=HDConstant.COMMENT_END%></td>
				<td class="tab22" >
					<input id="txt_purpose04" type="text" class="txtbox"  style= "position:relative;left:4px;top:1px;width:60px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" > </td>
					</tr>
				<tr>
							<td width="70px" height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center colspan="2" >출입지역</td>
							<td width="70px" height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center colspan="2" >차량번호</td>
							<td width="70px" height ="30px" style="" bgcolor="#eeeeee" class="tab21" align=center  >운전</td>
							<td width="70px" height ="30px" style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:1px;text-align;height:30px;font-family:굴림;font-size:9pt;" bgcolor="#eeeeee" class="tab21" align=center  colspan="8">비고</td>
						</tr>
						<tr>
							<td class="tab12_left" colspan="2">
							<%=HDConstant.COMMENT_START%>
					<OBJECT id=gclx_acc_area_b classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:4px;top:1px;font-size:12px;width:80px;">
									<param name=ComboDataID			value="gcds_acc_area_b">
									<param name=CBDataColumns		value="MINORCD, MINORNM">
									<param name=SearchColumn		value=MINORNM>
									<param name=Sort						value=false>
									<param name=Index		value=0>
									<param name=SortColumn  value="MINORCD"> 
									<param name=ListExprFormat	value="MINORCD^0^30,MINORNM^0^100">
									<param name=BindColumn			value=MINORCD>
								</OBJECT>
					<%=HDConstant.COMMENT_END%> </td>
								
				<td class="tab12_left" colspan="2">
							<input id="txt_car_no04" type="text" class="txtbox"  style= "position:relative;left:4px;top:3px;width:90px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> 
							<img SRC="../../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="차량번호를 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px" align=center  onclick="if 
							(gcds_code04.namevalue(gcds_code04.rowposition,'DRIVE_DIV')=='N') ln_Popup02('04');" > 
							</td>  
						<td class="tab12_left" >
							<%=HDConstant.COMMENT_START%>
					<OBJECT id=gclx_drive04 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:8px;top:1px;font-size:12px;width:60px;height:200px;" >
								<param name=CBData					value="Y^운전,N^비운전">
								<param name=CBDataColumns		value="Code, Parm">
								<param name=SearchColumn		value="Parm">
 								<param name=Sort						value="false">
								<param name=ListExprFormat	value="Parm^0^60">
								<param name=BindColumn			value="Code">
						</OBJECT>
					<%=HDConstant.COMMENT_END%> 
					 </td>  
						<td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:9pt; " colspan="8">
						 <textarea id="txt_remark04" class="txtbox"  style= "width:150px; height:23px; overflow:auto;position:relative;left:4px" maxlength="512" onBlur="bytelength(this,this.value,512);"></textarea></td> 
						</tr>
				</table>
			</td>
		</tr>

</table>		
<!-- 통행개요 및 기타물품============================================================================================================-->
<table id="div_disp5" cellpadding="0" cellspacing="0" border="0" style="display:none">
<tr>
		<td align ="top" colspan=2>
				<img src="../../../Common/img/btn/com_b_query.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Query05()"> 
				<img src="../../../Common/img/btn/com_b_save.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Save05()">
				<img src="../../../Common/img/btn/com_b_delete.gif"	align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Delete05()">
				<img src="../../../Common/img/btn/com_btn_start_print.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Popup01('05')">
				<img src="../../../Common/img/btn/com_btn_person_cnt.gif"		align=right style="cursor:hand;position:relative;top:-118px" onClick="ln_Print()">

				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:866px;border:0 solid #708090;">
				
		<tr> 		
		<td colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" bgcolor="#eeeeee" style="position:relative;left:3px;width:875px;border:0 solid #708090;">
			 <tr> 
				<td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:20pt;left:10px;" bgcolor="#eeeeee">   통행개요 </td> 
			 </tr> 
		 <table cellpadding="0" cellspacing="0" border="0" bgcolor="#eeeeee" style="position:relative;left:3px;width:875px;border:1 solid #708090;">
			<tr> 	
			 <td class="tab17" bgcolor="#eeeeee" align=center></td>
			 <td class="tab16" bgcolor="#eeeeee" align=center width="110px" height ="30px">일시</td>
			 <td class="tab12" bgcolor="#eeeeee" align=center width="100px" height ="30px">지역</td>
			 <td class="tab12" bgcolor="#eeeeee" align=center width="200px" height ="30px">목적</td>
			 <td class="tab12" bgcolor="#eeeeee" align=center width="100px" height ="30px">목적지</td>
			 <td class="tab12" bgcolor="#eeeeee" align=center width="30px" height ="30px">인원</td>
			 <td class="tab12" bgcolor="#eeeeee" align=center width="30px" height ="30px">차량</td>
		 	<td width="150px" height ="30px" style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:9pt;" bgcolor="#eeeeee"  align=center > 비고</td>&nbsp;
					</tr>
					<tr>
						 <td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:1px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:9pt; " width="100px" bgcolor="#eeeeee" align="center"> 출경(남-->북)</td>
						 <td class="tab32" bgcolor="#eeeeee" >
							<input id="txt_start_date05" type="text" class="txtbox"  style= "position:relative;left:4px;top:1px;width:60px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> 
							<input id="txt_start_time05" type="text" class="txtbox"  style= "position:relative;left:2px;top:1px;width:40px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> </td>
						<td class="tab40">
						<%=HDConstant.COMMENT_START%>
					<OBJECT id=gclx_project_cd_a classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;top:1px;font-size:12px;width:90px;">
								<param name=ComboDataID			value="gcds_project_cd_a">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value=MINORCD>
							</OBJECT>
							<%=HDConstant.COMMENT_END%> </td>
						<td class="tab40">
							<input id="txt_purpose05" type="text" class="txtbox"  style= "position:relative;top:1px;width:180px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> </td>
						<td class="tab40">
							<%=HDConstant.COMMENT_START%>
						<OBJECT id=gclx_acc_area_aa classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;top:1px;font-size:12px;width:90px;">
								<param name=ComboDataID			value="gcds_acc_area_aa">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value=MINORCD>
							</OBJECT>
					<%=HDConstant.COMMENT_END%> </td>
					<td class="tab40">
						<input id="txt_sperson_cnt05" type="text" class="txtbox"  style= "position:relative;top:1px;width:26px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> </td>
					<td class="tab40">
						<input id="txt_scar_cnt05" type="text" class="txtbox"  style= "position:relative;top:1px;width:26px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> </td>
					<td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:1px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:9pt; ">
						<textarea id="txt_remark05" class="txtbox"  style= "width:150px; height:23px; overflow:auto;position:relative;left:4px" maxlength="30" onBlur="bytelength(this,this.value,30);"></textarea></td>
				</tr>
			<tr>
				<td class="tab31"  width="100px" bgcolor="#eeeeee" align="center">입경(북-->남)</td>
				<td class="tab37"  bgcolor="#eeeeee" >
					<input id="txt_rtrn_date05" type="text" class="txtbox"  style= "position:relative;left:2px;top:1px;width:60px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> 
					<input id="txt_rtrn_time05" type="text" class="txtbox"  style= "position:relative;left:0px;top:1px;width:40px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> </td>
				<td class="tab14">
					<%=HDConstant.COMMENT_START%>
				<OBJECT id=gclx_project_cd_b classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:1px;font-size:12px;width:90px;">
								<param name=ComboDataID			value="gcds_project_cd_b">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value=MINORCD>
							</OBJECT>
						<%=HDConstant.COMMENT_END%> </td>
					<td class="tab14">
						<input id="txt_purpose06" type="text" class="txtbox"  style= "position:relative;top:1px;width:180px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> </td>
					<td class="tab14">
						<%=HDConstant.COMMENT_START%>
					<OBJECT id=gclx_acc_area_bb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;top:1px;font-size:12px;width:90px;">
								<param name=ComboDataID			value="gcds_acc_area_bb">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value=MINORCD>
							</OBJECT>
						<%=HDConstant.COMMENT_END%> </td>
					<td class="tab14">
						<input id="txt_rperson_cnt05" type="text" class="txtbox"  style= "position:relative;top:1px;width:26px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> </td>
					<td class="tab14">
						<input id="txt_rcar_cnt05" type="text" class="txtbox"  style= "position:relative;top:1px;width:26px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> </td>
					<td class="tab31">
						<textarea id="txt_remark06" class="txtbox"  style= "width:150px; height:23px; overflow:auto;position:relative;left:4px" maxlength="30" onBlur="bytelength(this,this.value,30);"></textarea></td>
					</tr>
					<tr>
						<td class="tab40"  colspan="7"> </td>
					</tr>
					<tr>
					<td class="tab40" width="100px" bgcolor="#eeeeee" align="center">입력자 및 일시 </td>
					<td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:1px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:9pt; " bgcolor="#eeeeee" colspan="3">&nbsp; by
						<input id="txt_create_usr05" type="text" class="txtbox"  style= "position:relative;left:4px;top:1px;width:70px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled>&nbsp;  at 
						<input id="txt_create_dt" type="text" class="txtbox"  style= "position:relative;left:6px;top:1px;width:130px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> </td>
					<td class="tab40"  align="center"> 수정자 및 일시 </td>
					<td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:1px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:9pt; " bgcolor="#eeeeee" colspan="3">&nbsp; by
								<input id="txt_update_ust" type="text" class="txtbox"  style= "position:relative;left:4px;top:1px;width:70px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled>&nbsp;  at 
								<input id="txt_update_dt" type="text" class="txtbox"  style= "position:relative;left:6px;top:1px;width:130px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> </td>
				</tr>
	</table>

</table>		
<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->
<iframe id="LowerFrame" name="work" style="visibility:hidden;position:absolute;left:280px;top:220px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcbn_code01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_code01>
	<param name=BindInfo  value='  
	<C>Col=CAR_NO       Ctrl=txt_car_no           Param=value </C>
	<C>Col=CAR_NAME     Ctrl=txt_car_type         Param=value </C>
	<C>Col=PERSON_CNT   Ctrl=txt_person_cnt	      Param=value</C>
	<C>Col=RDS_GOODS    Ctrl=txt_rds_goods		  Param=value</C>
	<C>Col=R_GOODS      Ctrl=txt_r_goods		  Param=value</C>
	<C>Col=PSN_KNAME    Ctrl=txt_prsn_name        Param=value</C>
    <C>Col=START_DATE   Ctrl=gcem_start_date      Param=text</C>
	<C>Col=START_TIME   Ctrl=gcem_start_time      Param=text</C>
	<C>Col=PURPOSE      Ctrl=txt_purpose          Param=value</C>
	<C>Col=CAR_SEQ_NO   Ctrl=gcem_car_seq_no      Param=text</C>
	<C>Col=REMARK       Ctrl=txt_remark     	  Param=value</C>
	'>
</OBJECT>
<%=HDConstant.COMMENT_END%>  

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcbn_code02 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_code02>
	<param name=BindInfo  value='  
	<C>Col=PRSN_NAME    Ctrl=txt_prsn_name02       Param=value </C>
	<C>Col=PRSN_CMPY    Ctrl=gclx_prsn_cmpy        Param=BindColVal </C>
	<C>Col=JOB_DUTY	    Ctrl=txt_job_duty02	       Param=value</C>
	<C>Col=GENDER       Ctrl=gclx_gender		   Param=BindColVal</C>
	<C>Col=PRSN_REGNO   Ctrl=gcem_prsn_regno       Param=text</C>
	<C>Col=ADDRESS1     Ctrl=txt_address1          Param=value</C>
	<C>Col=START_DATE   Ctrl=gcem_start_date02     Param=text</C>
	<C>Col=START_TIME   Ctrl=gcem_start_time02     Param=text</C>
	<C>Col=PURPOSE      Ctrl=txt_purpose02         Param=value</C>
	<C>Col=ACC_AREA     Ctrl=gclx_acc_area_a       Param=BindColVal</C>

	<C>Col=CAR_NO       Ctrl=txt_car_no02          Param=value</C>
	<C>Col=DRIVE_DIV    Ctrl=gclx_drive            Param=BindColVal</C>
	<C>Col=REMARK       Ctrl=txt_remark02     	   Param=value</C>
	'>
</OBJECT>
<%=HDConstant.COMMENT_END%>  

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcbn_code03 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_code03>
	<param name=BindInfo  value='  
	<C>Col=CAR_NO       Ctrl=txt_car_no03           Param=value </C>
	<C>Col=CAR_NAME     Ctrl=txt_car_type03         Param=value </C>
	<C>Col=PERSON_CNT	Ctrl=txt_person_cnt03	      Param=value</C>
	<C>Col=RDS_GOODS    Ctrl=txt_rds_goods03		    Param=value</C>
	<C>Col=R_GOODS      Ctrl=txt_r_goods03		      Param=value</C>
	<C>Col=PSN_KNAME    Ctrl=txt_prsn_name03        Param=value</C>
	<C>Col=RTRN_DATE    Ctrl=gcem_rtrn_date03       Param=text</C>
	<C>Col=RTRN_TIME    Ctrl=gcem_rtrn_time03       Param=text</C>
	<C>Col=PURPOSE      Ctrl=txt_purpose03          Param=value</C>
	<C>Col=BAECHA_NO    Ctrl=txt_baecha_no03        Param=value</C>
	<C>Col=REMARK       Ctrl=txt_remark03     		  Param=value</C>
	'>
</OBJECT>
<%=HDConstant.COMMENT_END%>  

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcbn_code04 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_code04>
	<param name=BindInfo  value='  
	<C>Col=PRSN_NAME    Ctrl=txt_prsn_name04         Param=value </C>
	<C>Col=PRSN_CMPY    Ctrl=gclx_prsn_cmpy04          Param=BindColVal </C>
	<C>Col=JOB_DUTY	    Ctrl=txt_job_duty04	         Param=value</C>
	<C>Col=GENDER       Ctrl=gclx_gender04		       Param=BindColVal</C>
	<C>Col=PRSN_REGNO   Ctrl=gcem_prsn_regno04        Param=text</C>
	<C>Col=ADDRESS1     Ctrl=txt_address104          Param=value</C>
	<C>Col=RTRN_DATE    Ctrl=gcem_rtrn_date04        Param=text</C>
	<C>Col=RTRN_TIME    Ctrl=gcem_rtrn_time04        Param=text</C>
	<C>Col=PURPOSE      Ctrl=txt_purpose04           Param=value</C>
	<C>Col=ACC_AREA     Ctrl=gclx_acc_area_b         Param=BindColVal</C>
	<C>Col=CAR_NO       Ctrl=txt_car_no04            Param=value</C>
	<C>Col=DRIVE_DIV    Ctrl=gclx_drive04            Param=BindColVal</C>
	<C>Col=REMARK       Ctrl=txt_remark04     		   Param=value</C>
	'>
</OBJECT>
<%=HDConstant.COMMENT_END%>  

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcbn_code05 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_code05>
	<param name=BindInfo  value='  
	<C>Col=ACC_DATE     Ctrl=txt_start_date05        Param=value</C>
	<C>Col=START_TIME   Ctrl=txt_start_time05        Param=value</C>
	<C>Col=ACC_COURSE   Ctrl=gclx_project_cd_a       Param=BindColVal</C>
	<C>Col=ACC_NAME     Ctrl=txt_purpose05           Param=value</C>

  <C>Col=SREACH_CIQ   Ctrl=gclx_acc_area_aa        Param=BindColVal</C>
	<C>Col=SPERSON_CNT  Ctrl=txt_sperson_cnt05       Param=value</C>
	<C>Col=SCAR_CNT     Ctrl=txt_scar_cnt05          Param=value</C>
	<C>Col=REMARK       Ctrl=txt_remark05     		   Param=value</C>

	<C>Col=RTRN_DATE    Ctrl=txt_rtrn_date05         Param=value</C>
	<C>Col=RTRN_TIME    Ctrl=txt_rtrn_time05         Param=value</C>
	<C>Col=RTRN_COURSE  Ctrl=gclx_project_cd_b       Param=BindColVal</C>
	<C>Col=PURPOSE       Ctrl=txt_purpose06           Param=value</C>
	<C>Col=RREACH_CIQ   Ctrl=gclx_acc_area_bb        Param=BindColVal</C>
	<C>Col=RPERSON_CNT  Ctrl=txt_rperson_cnt05       Param=value</C>
	<C>Col=RCAR_CNT     Ctrl=txt_rcar_cnt05          Param=value</C>
	<C>Col=REMARK       Ctrl=txt_remark06     		   Param=value</C>

	<C>Col=C_USR        Ctrl=txt_create_usr05          Param=value</C>
	<C>Col=C_DT         Ctrl=txt_create_dt           Param=value</C>
	<C>Col=U_UST        Ctrl=txt_update_ust          Param=value</C>
	<C>Col=U_DT         Ctrl=txt_update_dt           Param=value</C>
	
	'>
</OBJECT>
<%=HDConstant.COMMENT_END%>  

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   방문명단 출력
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="gcds_print">
	<param NAME="DetailDataID"				VALUE="gcds_print">
	<PARAM NAME="PaperSize"						VALUE="A4">	
	<PARAM NAME="LandScape"					  VALUE="False">
  <PARAM NAME="PrintSetupDlgFlag"		VALUE="true">
	<PARAM NAME="PreviewZoom"					VALUE="100">
	<PARAM NAME="Format"							VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=185 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=158 ,top=111 ,right=1848 ,bottom=111 </L>
	<T>id='개성공업지구 방문인원 명단 ' ,left=353 ,top=26 ,right=1208 ,bottom=93 ,face='굴림' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CUDATE', left=1234, top=32, right=1835, bottom=93, face='굴림', size=15, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Default ,left=0,top=0 ,right=2001 ,bottom=489 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=61 ,top=56 ,right=1885 ,bottom=447 ,border=true</X>
	<C>id='S_DATE', left=1437, top=77, right=1595, bottom=137, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='체류기간' ,left=1247 ,top=77 ,right=1405 ,bottom=137 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='번호' ,left=554 ,top=77 ,right=712 ,bottom=137 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=190 ,top=56 ,right=190 ,bottom=447 </L>
	<L> left=535 ,top=56 ,right=535 ,bottom=447 </L>
	<L> left=538 ,top=235 ,right=1885 ,bottom=235 </L>
	<L> left=538 ,top=156 ,right=1883 ,bottom=156 </L>
	<L> left=728 ,top=56 ,right=728 ,bottom=447 </L>
	<L> left=538 ,top=341 ,right=1885 ,bottom=341 </L>
	<L> left=1231 ,top=58 ,right=1231 ,bottom=344 </L>
	<L> left=1416 ,top=58 ,right=1416 ,bottom=344 </L>
	<T>id='직장/직위' ,left=1247 ,top=262 ,right=1405 ,bottom=322 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성별' ,left=1247 ,top=169 ,right=1405 ,bottom=230 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SEX', left=1437, top=167, right=1859, bottom=227, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{CURROW}', left=74, top=74, right=179, bottom=428, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='성명' ,left=554 ,top=167 ,right=712 ,bottom=227 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='생년월일' ,left=554 ,top=262 ,right=712 ,bottom=322 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주지' ,left=554 ,top=367 ,right=712 ,bottom=428 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P_CMPY', left=1434, top=259, right=1648, bottom=320, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='/' ,left=1656 ,top=259 ,right=1701 ,bottom=320 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='JOB_DUTY', left=1706, top=259, right=1872, bottom=320, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PRSN_NAME', left=767, top=167, right=1216, bottom=227, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PR_REGNO', left=767, top=262, right=1216, bottom=322, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ADDRESS1', left=767, top=367, right=1867, bottom=428, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{CURROW}', left=1005, top=77, right=1197, bottom=137, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='/' ,left=954 ,top=77 ,right=999 ,bottom=137 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='A_AREA', left=759, top=77, right=947, bottom=137, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='Image' ,left=203 ,top=74 ,right=519 ,bottom=431</I>
	<T>id='~' ,left=1600 ,top=77 ,right=1645 ,bottom=137 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RT_DATE', left=1651, top=77, right=1835, bottom=137, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
</B>

">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcrp_print01  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="gcds_print01"> 
	<param NAME="DetailDataID"				VALUE="gcds_print02">
	<PARAM NAME="PaperSize"						VALUE="A4">	
	<PARAM NAME="LandScape"					  VALUE="False">
    <PARAM NAME="PrintSetupDlgFlag"		VALUE="true">
	<PARAM NAME="PreviewZoom"					VALUE="100">
	<PARAM NAME="Format"							VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='군사분계선 통행계획(남).sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_print01'
<B>id=Header ,left=0,top=0 ,right=2001 ,bottom=460 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='MDL Crossing Request' ,left=548 ,top=283 ,right=986 ,bottom=349 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='START_D', left=999, top=285, right=1374, bottom=346, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=464 ,top=272 ,right=1458 ,bottom=272 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='군사분계선 통행계획' ,left=548 ,top=196 ,right=1129 ,bottom=264 ,face='굴림' ,size=17 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(' ,left=1134 ,top=196 ,right=1176 ,bottom=264 ,face='굴림' ,size=17 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='START_D', left=1179, top=201, right=1366, bottom=270, face='굴림', size=17,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=')' ,left=1368 ,top=209 ,right=1397 ,bottom=278 ,face='굴림' ,size=17 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=648 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=53 ,top=539 ,right=1864 ,bottom=648 ,border=true ,penstyle=solid ,penwidth=2</X>
	<X>left=53 ,top=90 ,right=1864 ,bottom=367 ,border=true ,penstyle=solid ,penwidth=3</X>
	<L> left=638 ,top=542 ,right=638 ,bottom=648 </L>
	<L> left=475 ,top=539 ,right=475 ,bottom=645 </L>
	<L> left=177 ,top=542 ,right=177 ,bottom=648 </L>
	<L> left=1382 ,top=90 ,right=1382 ,bottom=365 </L>
	<L> left=1295 ,top=90 ,right=1295 ,bottom=365 </L>
	<L> left=1208 ,top=90 ,right=1208 ,bottom=365 </L>
	<L> left=1010 ,top=90 ,right=1010 ,bottom=365 </L>
	<L> left=638 ,top=90 ,right=638 ,bottom=365 </L>
	<L> left=475 ,top=90 ,right=475 ,bottom=365 </L>
	<L> left=319 ,top=90 ,right=319 ,bottom=365 </L>
	<L> left=177 ,top=90 ,right=177 ,bottom=365 </L>
	<L> left=925 ,top=542 ,right=925 ,bottom=648 </L>
	<L> left=831 ,top=539 ,right=831 ,bottom=645 </L>
	<L> left=1658 ,top=539 ,right=1658 ,bottom=645 </L>
	<L> left=1276 ,top=542 ,right=1276 ,bottom=648 </L>
	<C>id='RTRN_T', left=480, top=285, right=633, bottom=362, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=55 ,top=280 ,right=1862 ,bottom=280 </L>
	<T>id='방향' ,left=182 ,top=100 ,right=314 ,bottom=188 ,face='굴림' ,size=8 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P_POSE', left=643, top=285, right=1007, bottom=362, align='left', face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='일자' ,left=63 ,top=98 ,right=171 ,bottom=143 ,face='굴림' ,size=8 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지역' ,left=327 ,top=98 ,right=472 ,bottom=143 ,face='굴림' ,size=8 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='MDL time' ,left=480 ,top=145 ,right=633 ,bottom=190 ,face='굴림' ,size=8 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='통과시간' ,left=480 ,top=98 ,right=633 ,bottom=143 ,face='굴림' ,size=8 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Corridor' ,left=327 ,top=145 ,right=472 ,bottom=190 ,face='굴림' ,size=8 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Date' ,left=63 ,top=145 ,right=171 ,bottom=190 ,face='굴림' ,size=8 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='목적' ,left=643 ,top=98 ,right=1007 ,bottom=143 ,face='굴림' ,size=8 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Purpose' ,left=643 ,top=145 ,right=1007 ,bottom=190 ,face='굴림' ,size=8 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Destination' ,left=1018 ,top=145 ,right=1205 ,bottom=190 ,face='굴림' ,size=8 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='목적지' ,left=1018 ,top=98 ,right=1205 ,bottom=143 ,face='굴림' ,size=8 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='R_CIQ', left=1018, top=285, right=1205, bottom=362, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='N => S' ,left=182 ,top=285 ,right=314 ,bottom=362 ,face='굴림' ,size=8 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='O_CARGO', left=324, top=285, right=469, bottom=362, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='START_D', left=61, top=285, right=171, bottom=362, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='인원' ,left=1216 ,top=98 ,right=1292 ,bottom=143 ,face='굴림' ,size=8 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량' ,left=1300 ,top=98 ,right=1376 ,bottom=143 ,face='굴림' ,size=8 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Pax' ,left=1216 ,top=145 ,right=1292 ,bottom=190 ,face='굴림' ,size=8 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Veh' ,left=1300 ,top=145 ,right=1376 ,bottom=190 ,face='굴림' ,size=8 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RPERSON_CNT', left=1216, top=285, right=1292, bottom=362, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='비고' ,left=1390 ,top=98 ,right=1854 ,bottom=143 ,face='굴림' ,size=8 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Remarks' ,left=1390 ,top=145 ,right=1854 ,bottom=190 ,face='굴림' ,size=8 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RCAR_CNT', left=1303, top=285, right=1379, bottom=362, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=1390, top=285, right=1854, bottom=362, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='START_D', left=61, top=204, right=171, bottom=278, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='L_CARGO', left=324, top=204, right=469, bottom=278, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='S => N' ,left=182 ,top=204 ,right=314 ,bottom=278 ,face='굴림' ,size=8 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='START_T', left=480, top=204, right=633, bottom=278, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PURPOSE', left=643, top=204, right=1007, bottom=278, align='left', face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='S_CIQ', left=1018, top=204, right=1205, bottom=278, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SPERSON_CNT', left=1216, top=204, right=1292, bottom=278, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SCAR_CNT', left=1303, top=204, right=1379, bottom=278, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=1390, top=204, right=1854, bottom=278, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='성별' ,left=838 ,top=545 ,right=920 ,bottom=589 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='생년월일' ,left=931 ,top=545 ,right=1271 ,bottom=589 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주소' ,left=1284 ,top=545 ,right=1653 ,bottom=589 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='복귀예정일' ,left=1666 ,top=545 ,right=1856 ,bottom=589 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Name' ,left=646 ,top=592 ,right=825 ,bottom=637 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Sex' ,left=838 ,top=592 ,right=920 ,bottom=637 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='KID' ,left=931 ,top=592 ,right=1271 ,bottom=637 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Address' ,left=1284 ,top=592 ,right=1653 ,bottom=637 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Depart date' ,left=1666 ,top=592 ,right=1856 ,bottom=637 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=646 ,top=545 ,right=825 ,bottom=589 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Duty' ,left=480 ,top=592 ,right=633 ,bottom=637 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직책' ,left=480 ,top=545 ,right=633 ,bottom=589 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Job' ,left=185 ,top=592 ,right=469 ,bottom=637 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소속' ,left=185 ,top=545 ,right=469 ,bottom=589 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Order' ,left=61 ,top=592 ,right=171 ,bottom=637 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='순번' ,left=61 ,top=545 ,right=171 ,bottom=589 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=53 ,top=196 ,right=1862 ,bottom=196 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='1. 통행개요 SUMMERY' ,left=53 ,top=37 ,right=1864 ,bottom=85 ,align='left' ,face='굴림' ,size=12 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2. 인적사항 Personnal data' ,left=53 ,top=484 ,right=1864 ,bottom=531 ,align='left' ,face='굴림' ,size=12 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='START_D', left=55, top=418, right=179, bottom=478, face='굴림', size=14,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(' ,left=182 ,top=418 ,right=219 ,bottom=478 ,face='굴림' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='START_DA', left=221, top=418, right=332, bottom=478, face='굴림', size=14,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='남 => 북' ,left=367 ,top=418 ,right=575 ,bottom=478 ,face='굴림' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=')' ,left=335 ,top=418 ,right=364 ,bottom=478 ,face='굴림' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

</R>
</A>

<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=141
	<R>id='인적사항_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='gcds_print02' 
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=88 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='RT_DATE', left=1666, top=5, right=1856, bottom=79, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ADDRESS1', left=1284, top=5, right=1653, bottom=79, align='left', face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P_REGNO', left=931, top=5, right=1271, bottom=79, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SEX', left=838, top=5, right=920, bottom=79, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PRSN_NAME', left=646, top=5, right=825, bottom=79, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_DUTY', left=480, top=5, right=633, bottom=79, align='left', face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P_CMPY', left=185, top=5, right=469, bottom=79, align='left', face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{CURROW}', left=61, top=5, right=171, bottom=79, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=53 ,top=85 ,right=1864 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=177 ,top=0 ,right=177 ,bottom=85 </L>
	<L> left=475 ,top=0 ,right=475 ,bottom=85 </L>
	<L> left=638 ,top=0 ,right=638 ,bottom=85 </L>
	<L> left=831 ,top=0 ,right=831 ,bottom=85 </L>
	<L> left=925 ,top=0 ,right=925 ,bottom=85 </L>
	<L> left=1276 ,top=0 ,right=1276 ,bottom=85 </L>
	<L> left=1658 ,top=0 ,right=1658 ,bottom=85 </L>
	<L> left=1864 ,top=0 ,right=1864 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=53 ,top=0 ,right=53 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

</R>
</A>

<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=133
	<R>id='차량현황.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 , MasterDataID='gcds_print02' 

<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=214 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=53 ,top=116 ,right=1864 ,bottom=214 ,border=true ,penstyle=solid ,penwidth=2</X>
	<L> left=997 ,top=172 ,right=997 ,bottom=214 </L>
	<T>id='Driver' ,left=1392 ,top=169 ,right=1645 ,bottom=214 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='운전자' ,left=1392 ,top=122 ,right=1645 ,bottom=167 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1384 ,top=119 ,right=1384 ,bottom=214 </L>
	<T>id='복귀예정일' ,left=1658 ,top=122 ,right=1856 ,bottom=167 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Depart date' ,left=1658 ,top=169 ,right=1856 ,bottom=214 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Veh. No' ,left=485 ,top=169 ,right=820 ,bottom=214 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량번호' ,left=485 ,top=122 ,right=820 ,bottom=167 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량유형' ,left=185 ,top=122 ,right=469 ,bottom=167 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Type' ,left=185 ,top=169 ,right=469 ,bottom=214 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='순서' ,left=58 ,top=122 ,right=171 ,bottom=167 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Order' ,left=58 ,top=169 ,right=171 ,bottom=214 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1651 ,top=116 ,right=1651 ,bottom=214 </L>
	<L> left=828 ,top=116 ,right=828 ,bottom=214 </L>
	<L> left=475 ,top=116 ,right=475 ,bottom=214 </L>
	<L> left=177 ,top=116 ,right=177 ,bottom=214 </L>
	<T>id='적재 Contents' ,left=841 ,top=122 ,right=1376 ,bottom=167 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=831 ,top=169 ,right=1384 ,bottom=169 </L>
	<T>id='인원 PAX' ,left=838 ,top=177 ,right=983 ,bottom=211 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='화물 CARGO' ,left=1005 ,top=174 ,right=1379 ,bottom=211 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3. 차량 현황 Vehicles ' ,left=55 ,top=61 ,right=1867 ,bottom=108 ,align='left' ,face='굴림' ,size=12 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

</R>
</A>
<A>id=Area4 ,left=0,top=0 ,right=2871 ,bottom=141
	<R>id='차량현황_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='gcds_print01' 
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=88 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1651 ,top=0 ,right=1651 ,bottom=87 </L>
	<L> left=177 ,top=0 ,right=177 ,bottom=87 </L>
	<L> left=475 ,top=0 ,right=475 ,bottom=87 </L>
	<L> left=997 ,top=0 ,right=997 ,bottom=87 </L>
	<L> left=828 ,top=0 ,right=828 ,bottom=87 </L>
	<L> left=1384 ,top=0 ,right=1384 ,bottom=87 </L>
	<C>id='R_DATE', left=1658, top=5, right=1856, bottom=85, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PSN_KNAME', left=1392, top=5, right=1645, bottom=85, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RDS_GOODS', left=1005, top=5, right=1379, bottom=85, align='left', face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PERSON_CNT', left=838, top=5, right=983, bottom=85, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CAR_NO', left=485, top=5, right=820, bottom=85, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CAR_NAME', left=185, top=5, right=469, bottom=85, align='left', face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{CURROW}', left=63, top=5, right=171, bottom=85, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=53 ,top=90 ,right=1864 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1864 ,top=0 ,right=1864 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=53 ,top=0 ,right=53 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

</R>
</A>

<A>id=Area5 ,left=0,top=0 ,right=2871 ,bottom=133
	<R>id='기타(인적사항).sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 , MasterDataID='gcds_print03' 
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=700 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=58 ,top=592 ,right=1869 ,bottom=700 ,border=true ,penstyle=solid ,penwidth=2</X>
	<X>left=58 ,top=151 ,right=1869 ,bottom=357 ,border=true ,penstyle=solid ,penwidth=2</X>
	<T>id='적재품' ,left=488 ,top=156 ,right=1176 ,bottom=201 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=643 ,top=592 ,right=643 ,bottom=698 </L>
	<T>id='휴대품' ,left=1197 ,top=156 ,right=1859 ,bottom=201 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Belongings' ,left=1197 ,top=204 ,right=1859 ,bottom=248 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='순번' ,left=66 ,top=600 ,right=179 ,bottom=645 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Order' ,left=66 ,top=650 ,right=179 ,bottom=695 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Job' ,left=192 ,top=650 ,right=477 ,bottom=695 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소속' ,left=192 ,top=600 ,right=477 ,bottom=645 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직책' ,left=490 ,top=600 ,right=641 ,bottom=645 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Duty' ,left=490 ,top=650 ,right=641 ,bottom=695 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Name' ,left=654 ,top=650 ,right=825 ,bottom=695 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=654 ,top=600 ,right=825 ,bottom=645 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성별' ,left=838 ,top=600 ,right=920 ,bottom=645 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Sex' ,left=838 ,top=650 ,right=920 ,bottom=695 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='생년월일' ,left=931 ,top=600 ,right=1271 ,bottom=645 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='KID' ,left=931 ,top=650 ,right=1271 ,bottom=695 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1276 ,top=595 ,right=1276 ,bottom=700 </L>
	<T>id='Address' ,left=1284 ,top=650 ,right=1653 ,bottom=695 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주소' ,left=1284 ,top=600 ,right=1653 ,bottom=645 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1658 ,top=592 ,right=1658 ,bottom=698 </L>
	<T>id='복귀예정일' ,left=1666 ,top=600 ,right=1864 ,bottom=645 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Depart date' ,left=1666 ,top=650 ,right=1864 ,bottom=695 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=185 ,top=592 ,right=185 ,bottom=698 </L>
	<L> left=483 ,top=592 ,right=483 ,bottom=698 </L>
	<L> left=831 ,top=592 ,right=831 ,bottom=698 </L>
	<L> left=925 ,top=595 ,right=925 ,bottom=700 </L>
	<T>id='구분' ,left=63 ,top=156 ,right=475 ,bottom=201 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=61 ,top=251 ,right=1867 ,bottom=251 </L>
	<T>id='Section' ,left=63 ,top=204 ,right=475 ,bottom=248 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내용' ,left=63 ,top=259 ,right=475 ,bottom=304 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='contents' ,left=63 ,top=307 ,right=475 ,bottom=352 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=480 ,top=153 ,right=480 ,bottom=354 </L>
	<L> left=1189 ,top=153 ,right=1189 ,bottom=354 </L>
	<C>id='GOODS', left=490, top=259, right=1179, bottom=349, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Cargo' ,left=488 ,top=204 ,right=1176 ,bottom=248 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='GOODS_PSN', left=1200, top=259, right=1862, bottom=349, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='2-1. 인적사항 Personnal data' ,left=58 ,top=537 ,right=1869 ,bottom=584 ,align='left' ,face='굴림' ,size=12 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4.기타물품 Cargo/Equipment materials' ,left=58 ,top=90 ,right=1869 ,bottom=145 ,align='left' ,face='굴림' ,size=12 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='START_D', left=61, top=463, right=185, bottom=523, face='굴림', size=13,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(' ,left=187 ,top=463 ,right=224 ,bottom=523 ,face='굴림' ,size=13 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='START_DA', left=227, top=463, right=311, bottom=523, face='굴림', size=13,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=')' ,left=314 ,top=463 ,right=343 ,bottom=523 ,face='굴림' ,size=13 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='북 => 남' ,left=345 ,top=463 ,right=501 ,bottom=523 ,face='굴림' ,size=13 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

</R>
</A>
<A>id=Area6 ,left=0,top=0 ,right=2871 ,bottom=141
	<R>id='2-1인적사항_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='gcds_print04' 
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=84 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='{CURROW}', left=66, top=5, right=179, bottom=79, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P_CMPY', left=192, top=5, right=477, bottom=79, align='left', face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_DUTY', left=490, top=5, right=641, bottom=79, align='left', face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PRSN_NAME', left=654, top=5, right=823, bottom=79, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SEX', left=838, top=5, right=920, bottom=79, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P_REGNO', left=931, top=5, right=1271, bottom=79, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ADDRESS1', left=1284, top=5, right=1653, bottom=79, align='left', face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RT_DATE', left=1666, top=5, right=1864, bottom=79, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=58 ,top=85 ,right=1869 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=483 ,top=0 ,right=483 ,bottom=85 </L>
	<L> left=185 ,top=0 ,right=185 ,bottom=85 </L>
	<L> left=646 ,top=0 ,right=646 ,bottom=85 </L>
	<L> left=925 ,top=0 ,right=925 ,bottom=85 </L>
	<L> left=831 ,top=0 ,right=831 ,bottom=85 </L>
	<L> left=1658 ,top=0 ,right=1658 ,bottom=85 </L>
	<L> left=1276 ,top=0 ,right=1276 ,bottom=85 </L>
	<L> left=58 ,top=0 ,right=58 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1869 ,top=0 ,right=1869 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

</R>
</A>

<A>id=Area7 ,left=0,top=0 ,right=2871 ,bottom=133
	<R>id='3-1차량.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 , MasterDataID='gcds_print04' 
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=217 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=53 ,top=116 ,right=1864 ,bottom=217 ,border=true ,penstyle=solid ,penwidth=2</X>
	<L> left=997 ,top=172 ,right=997 ,bottom=217 </L>
	<T>id='Driver' ,left=1392 ,top=169 ,right=1645 ,bottom=214 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='운전자' ,left=1392 ,top=122 ,right=1645 ,bottom=167 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1384 ,top=119 ,right=1384 ,bottom=217 </L>
	<T>id='복귀예정일' ,left=1658 ,top=122 ,right=1856 ,bottom=167 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Depart date' ,left=1658 ,top=169 ,right=1856 ,bottom=214 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Veh. No' ,left=485 ,top=169 ,right=820 ,bottom=214 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량번호' ,left=485 ,top=122 ,right=820 ,bottom=167 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량유형' ,left=185 ,top=122 ,right=469 ,bottom=167 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Type' ,left=185 ,top=169 ,right=469 ,bottom=214 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='순서' ,left=58 ,top=122 ,right=171 ,bottom=167 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Order' ,left=58 ,top=169 ,right=171 ,bottom=214 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1651 ,top=116 ,right=1651 ,bottom=217 </L>
	<L> left=828 ,top=116 ,right=828 ,bottom=217 </L>
	<L> left=475 ,top=116 ,right=475 ,bottom=217 </L>
	<L> left=177 ,top=116 ,right=177 ,bottom=217 </L>
	<T>id='적재 Contents' ,left=841 ,top=122 ,right=1376 ,bottom=167 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=831 ,top=169 ,right=1384 ,bottom=169 </L>
	<T>id='인원 PAX' ,left=838 ,top=177 ,right=983 ,bottom=211 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='화물 CARGO' ,left=1005 ,top=174 ,right=1379 ,bottom=211 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3-1. 차량 현황 Vehicles ' ,left=53 ,top=61 ,right=1864 ,bottom=108 ,align='left' ,face='굴림' ,size=12 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

</R>
</A>
<A>id=Area8 ,left=0,top=0 ,right=2871 ,bottom=141
	<R>id='3-1차량현황_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='gcds_print03' 
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=87 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1650 ,top=0 ,right=1650 ,bottom=87 </L>
	<L> left=178 ,top=0 ,right=178 ,bottom=87 </L>
	<L> left=475 ,top=0 ,right=475 ,bottom=87 </L>
	<L> left=997 ,top=0 ,right=997 ,bottom=87 </L>
	<L> left=828 ,top=0 ,right=828 ,bottom=87 </L>
	<L> left=1384 ,top=0 ,right=1384 ,bottom=87 </L>
	<C>id='R_DATE', left=1659, top=6, right=1856, bottom=84, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PSN_KNAME', left=1391, top=6, right=1644, bottom=84, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RDS_GOODS', left=1006, top=6, right=1378, bottom=84, align='left', face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PERSON_CNT', left=838, top=6, right=984, bottom=84, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CAR_NO', left=484, top=6, right=819, bottom=84, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CAR_NAME', left=184, top=6, right=469, bottom=84, align='left', face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{CURROW}', left=63, top=6, right=172, bottom=84, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=53 ,top=91 ,right=1863 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1863 ,top=0 ,right=1863 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=53 ,top=0 ,right=53 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>



</R>
</A>

<A>id=Area9 ,left=0,top=0 ,right=2871 ,bottom=133
	<R>id='4-1기타.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 , MasterDataID='gcds_print03' 
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=381 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=58 ,top=151 ,right=1869 ,bottom=357 ,border=true ,penstyle=solid ,penwidth=2</X>
	<L> left=1189 ,top=153 ,right=1189 ,bottom=354 </L>
	<L> left=480 ,top=153 ,right=480 ,bottom=354 </L>
	<L> left=61 ,top=251 ,right=1867 ,bottom=251 </L>
	<C>id='', left=1200, top=259, right=1862, bottom=349, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=490, top=259, right=1179, bottom=349, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='contents' ,left=63 ,top=307 ,right=475 ,bottom=352 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내용' ,left=63 ,top=259 ,right=475 ,bottom=304 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Belongings' ,left=1200 ,top=204 ,right=1862 ,bottom=248 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='휴대품' ,left=1200 ,top=156 ,right=1862 ,bottom=201 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Cargo' ,left=488 ,top=204 ,right=1176 ,bottom=248 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='적재품' ,left=490 ,top=156 ,right=1179 ,bottom=201 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Section' ,left=63 ,top=204 ,right=475 ,bottom=248 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구분' ,left=63 ,top=156 ,right=475 ,bottom=201 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4-1.기타물품 Cargo/Equipment materials' ,left=58 ,top=90 ,right=1869 ,bottom=145 ,align='left' ,face='굴림' ,size=12 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
</R>
</A>
<B>id=Footer ,left=0 ,top=2733 ,right=2001 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=396 ,top=26 ,right=1453 ,bottom=106</T>
</B>

">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcrp_print02  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="gcds_print01">
	<param NAME="DetailDataID"				VALUE="gcds_print02">
	<PARAM NAME="PaperSize"						VALUE="A4">	
	<PARAM NAME="LandScape"					  VALUE="false">
  <PARAM NAME="PrintSetupDlgFlag"		VALUE="true">
	<PARAM NAME="PreviewZoom"					VALUE="100">
	<PARAM NAME="Format"							VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='군사분계선 통행계획(북).sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_print01'
<B>id=Header ,left=0,top=0 ,right=2001 ,bottom=291 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=477 ,top=161 ,right=1471 ,bottom=161 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='군사분계선 통행계획' ,left=562 ,top=85 ,right=1142 ,bottom=153 ,face='굴림' ,size=17 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(' ,left=1147 ,top=85 ,right=1189 ,bottom=153 ,face='굴림' ,size=17 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='START_D', left=1192, top=93, right=1379, bottom=161, face='굴림', size=16,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=')' ,left=1382 ,top=95 ,right=1411 ,bottom=164 ,face='굴림' ,size=17 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=648 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=53 ,top=539 ,right=1864 ,bottom=648 ,border=true ,penstyle=solid ,penwidth=2</X>
	<X>left=53 ,top=90 ,right=1864 ,bottom=367 ,border=true ,penstyle=solid ,penwidth=2</X>
	<L> left=1295 ,top=93 ,right=1295 ,bottom=367 </L>
	<C>id='REMARK', left=1390, top=285, right=1854, bottom=362, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RCAR_CNT', left=1303, top=285, right=1379, bottom=362, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=1390, top=198, right=1854, bottom=275, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SCAR_CNT', left=1303, top=198, right=1379, bottom=275, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RPERSON_CNT', left=1216, top=285, right=1292, bottom=362, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SPERSON_CNT', left=1216, top=198, right=1292, bottom=275, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='O_CARGO', left=324, top=285, right=469, bottom=362, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='N => S' ,left=182 ,top=285 ,right=314 ,bottom=362 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='S_CIQ', left=1018, top=198, right=1205, bottom=275, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='R_CIQ', left=1018, top=285, right=1205, bottom=362, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PURPOSE', left=643, top=198, right=1007, bottom=275, align='left', face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='START_T', left=480, top=201, right=633, bottom=278, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P_POSE', left=643, top=285, right=1007, bottom=362, align='left', face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='L_CARGO', left=324, top=201, right=469, bottom=275, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=55 ,top=280 ,right=1862 ,bottom=280 </L>
	<L> left=1010 ,top=93 ,right=1010 ,bottom=367 </L>
	<L> left=1382 ,top=93 ,right=1382 ,bottom=367 </L>
	<L> left=1208 ,top=93 ,right=1208 ,bottom=367 </L>
	<L> left=638 ,top=93 ,right=638 ,bottom=367 </L>
	<L> left=475 ,top=93 ,right=475 ,bottom=367 </L>
	<L> left=319 ,top=93 ,right=319 ,bottom=367 </L>
	<L> left=177 ,top=93 ,right=177 ,bottom=367 </L>
	<L> left=53 ,top=193 ,right=1862 ,bottom=193 </L>
	<C>id='RTRN_T', left=480, top=285, right=633, bottom=362, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1276 ,top=542 ,right=1276 ,bottom=648 </L>
	<L> left=1658 ,top=539 ,right=1658 ,bottom=645 </L>
	<L> left=831 ,top=539 ,right=831 ,bottom=645 </L>
	<L> left=925 ,top=542 ,right=925 ,bottom=648 </L>
	<T>id='목적지' ,left=1018 ,top=100 ,right=1205 ,bottom=188 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인원' ,left=1216 ,top=100 ,right=1292 ,bottom=188 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량' ,left=1300 ,top=100 ,right=1376 ,bottom=188 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비고' ,left=1390 ,top=100 ,right=1854 ,bottom=188 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='일자' ,left=61 ,top=100 ,right=171 ,bottom=188 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='방향' ,left=182 ,top=100 ,right=314 ,bottom=188 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지역' ,left=324 ,top=100 ,right=469 ,bottom=188 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='통과시간' ,left=480 ,top=100 ,right=633 ,bottom=188 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='목적' ,left=643 ,top=100 ,right=1007 ,bottom=188 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='순번' ,left=61 ,top=547 ,right=171 ,bottom=640 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=177 ,top=539 ,right=177 ,bottom=645 </L>
	<L> left=475 ,top=542 ,right=475 ,bottom=648 </L>
	<T>id='소속' ,left=185 ,top=547 ,right=469 ,bottom=640 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=646 ,top=547 ,right=825 ,bottom=640 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직책' ,left=483 ,top=547 ,right=633 ,bottom=640 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=638 ,top=542 ,right=638 ,bottom=648 </L>
	<T>id='복귀예정일' ,left=1666 ,top=547 ,right=1856 ,bottom=640 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주소' ,left=1284 ,top=547 ,right=1653 ,bottom=640 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='생년월일' ,left=931 ,top=547 ,right=1271 ,bottom=640 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성별' ,left=838 ,top=547 ,right=920 ,bottom=640 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='S => N' ,left=182 ,top=201 ,right=314 ,bottom=275 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='START_D', left=61, top=285, right=171, bottom=362, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='START_D', left=61, top=201, right=171, bottom=275, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='2. 인적사항 ' ,left=53 ,top=481 ,right=1864 ,bottom=534 ,align='left' ,face='굴림' ,size=13 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1. 통행개요 ' ,left=53 ,top=32 ,right=1864 ,bottom=85 ,align='left' ,face='굴림' ,size=13 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='남 => 북' ,left=287 ,top=404 ,right=417 ,bottom=465 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=')' ,left=256 ,top=404 ,right=285 ,bottom=465 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='START_DA', left=195, top=404, right=253, bottom=465, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(' ,left=156 ,top=404 ,right=192 ,bottom=465 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='START_D', left=55, top=404, right=153, bottom=465, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
</B>

</R>
</A>

<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=141
	<R>id='인적사항_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='gcds_print02' 
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=87 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='{CURROW}', left=61, top=5, right=171, bottom=82, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RT_DATE', left=1666, top=5, right=1856, bottom=82, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ADDRESS1', left=1284, top=5, right=1653, bottom=82, align='left', face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P_REGNO', left=931, top=5, right=1271, bottom=82, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SEX', left=838, top=5, right=920, bottom=82, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PRSN_NAME', left=646, top=5, right=825, bottom=82, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_DUTY', left=483, top=5, right=633, bottom=82, align='left', face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P_CMPY', left=185, top=5, right=469, bottom=82, align='left', face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=53 ,top=87 ,right=1864 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=177 ,top=0 ,right=177 ,bottom=87 </L>
	<L> left=638 ,top=0 ,right=638 ,bottom=87 </L>
	<L> left=475 ,top=0 ,right=475 ,bottom=87 </L>
	<L> left=53 ,top=0 ,right=53 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1276 ,top=0 ,right=1276 ,bottom=87 </L>
	<L> left=1658 ,top=0 ,right=1658 ,bottom=87 </L>
	<L> left=925 ,top=0 ,right=925 ,bottom=87 </L>
	<L> left=831 ,top=0 ,right=831 ,bottom=87 </L>
	<L> left=1864 ,top=0 ,right=1864 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

</R>
</A>

<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=133
	<R>id='차량현황.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 , MasterDataID='gcds_print02' 

<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=215 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=55 ,top=116 ,right=1867 ,bottom=214 ,border=true ,penstyle=solid ,penwidth=2</X>
	<L> left=999 ,top=172 ,right=999 ,bottom=214 </L>
	<L> left=1387 ,top=119 ,right=1387 ,bottom=214 </L>
	<L> left=1653 ,top=116 ,right=1653 ,bottom=214 </L>
	<L> left=831 ,top=116 ,right=831 ,bottom=214 </L>
	<L> left=477 ,top=116 ,right=477 ,bottom=214 </L>
	<L> left=179 ,top=116 ,right=179 ,bottom=214 </L>
	<T>id='적재' ,left=844 ,top=122 ,right=1379 ,bottom=167 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=833 ,top=169 ,right=1387 ,bottom=169 </L>
	<T>id='인원' ,left=841 ,top=177 ,right=986 ,bottom=211 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='화물 ' ,left=1007 ,top=174 ,right=1382 ,bottom=211 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='순서' ,left=63 ,top=124 ,right=177 ,bottom=209 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량유형' ,left=187 ,top=124 ,right=472 ,bottom=209 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량번호' ,left=488 ,top=124 ,right=823 ,bottom=209 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='운전자' ,left=1395 ,top=124 ,right=1648 ,bottom=209 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='복귀예정일' ,left=1661 ,top=124 ,right=1859 ,bottom=209 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3. 차량 현황 ' ,left=55 ,top=61 ,right=1867 ,bottom=108 ,align='left' ,face='굴림' ,size=13 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
</R>
</A>
<A>id=Area4 ,left=0,top=0 ,right=2871 ,bottom=141
	<R>id='차량현황_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='gcds_print01' 
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=87 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='R_DATE', left=1663, top=6, right=1859, bottom=81, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PSN_KNAME', left=1394, top=6, right=1647, bottom=81, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RDS_GOODS', left=1006, top=6, right=1381, bottom=81, align='left', face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PERSON_CNT', left=841, top=6, right=988, bottom=81, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CAR_NO', left=488, top=6, right=822, bottom=81, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CAR_NAME', left=188, top=6, right=472, bottom=81, align='left', face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{CURROW}', left=66, top=6, right=175, bottom=81, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=56 ,top=87 ,right=1866 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=178 ,top=0 ,right=178 ,bottom=87 </L>
	<L> left=56 ,top=0 ,right=56 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=478 ,top=0 ,right=478 ,bottom=87 </L>
	<L> left=1866 ,top=0 ,right=1866 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1653 ,top=0 ,right=1653 ,bottom=87 </L>
	<L> left=1388 ,top=0 ,right=1388 ,bottom=87 </L>
	<L> left=1000 ,top=0 ,right=1000 ,bottom=87 </L>
	<L> left=831 ,top=0 ,right=831 ,bottom=87 </L>
</B>


</R>
</A>

<A>id=Area5 ,left=0,top=0 ,right=2871 ,bottom=133
	<R>id='기타(인적사항).sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 , MasterDataID='gcds_print03' 
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=698 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=55 ,top=592 ,right=1867 ,bottom=698 ,border=true ,penstyle=solid ,penwidth=2</X>
	<X>left=55 ,top=151 ,right=1867 ,bottom=357 ,border=true ,penstyle=solid ,penwidth=2</X>
	<C>id='GOODS_PSN', left=1197, top=259, right=1859, bottom=349, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='GOODS', left=488, top=259, right=1176, bottom=349, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1187 ,top=153 ,right=1187 ,bottom=354 </L>
	<L> left=477 ,top=153 ,right=477 ,bottom=354 </L>
	<L> left=58 ,top=251 ,right=1864 ,bottom=251 </L>
	<L> left=923 ,top=595 ,right=923 ,bottom=698 </L>
	<L> left=828 ,top=592 ,right=828 ,bottom=698 </L>
	<L> left=643 ,top=592 ,right=643 ,bottom=698 </L>
	<L> left=480 ,top=592 ,right=480 ,bottom=698 </L>
	<L> left=182 ,top=592 ,right=182 ,bottom=698 </L>
	<L> left=1656 ,top=592 ,right=1656 ,bottom=698 </L>
	<L> left=1274 ,top=595 ,right=1274 ,bottom=698 </L>
	<T>id='북 => 남' ,left=293 ,top=423 ,right=422 ,bottom=484 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=')' ,left=261 ,top=423 ,right=290 ,bottom=484 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='START_DA', left=200, top=423, right=258, bottom=484, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(' ,left=161 ,top=423 ,right=198 ,bottom=484 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='START_D', left=61, top=423, right=158, bottom=484, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='구분' ,left=61 ,top=156 ,right=472 ,bottom=246 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='적재품' ,left=488 ,top=156 ,right=1176 ,bottom=246 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='휴대품' ,left=1197 ,top=156 ,right=1859 ,bottom=246 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내용' ,left=61 ,top=259 ,right=472 ,bottom=349 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='순번' ,left=63 ,top=600 ,right=177 ,bottom=693 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소속' ,left=190 ,top=600 ,right=475 ,bottom=693 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직책' ,left=488 ,top=600 ,right=638 ,bottom=693 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=651 ,top=600 ,right=823 ,bottom=693 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성별' ,left=836 ,top=600 ,right=918 ,bottom=693 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='복귀예정일' ,left=1664 ,top=600 ,right=1862 ,bottom=693 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주소' ,left=1281 ,top=600 ,right=1651 ,bottom=693 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='생년월일' ,left=928 ,top=600 ,right=1268 ,bottom=693 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4.기타물품 ' ,left=55 ,top=95 ,right=1867 ,bottom=148 ,align='left' ,face='굴림' ,size=13 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2-1. 인적사항 ' ,left=55 ,top=531 ,right=1867 ,bottom=584 ,align='left' ,face='굴림' ,size=13 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
</R>
</A>
<A>id=Area6 ,left=0,top=0 ,right=2871 ,bottom=141
	<R>id='2-1인적사항_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='gcds_print04' 
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=87 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='RT_DATE', left=1663, top=6, right=1863, bottom=81, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ADDRESS1', left=1281, top=6, right=1650, bottom=81, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P_REGNO', left=928, top=6, right=1269, bottom=81, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SEX', left=838, top=6, right=919, bottom=81, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PRSN_NAME', left=650, top=6, right=819, bottom=81, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_DUTY', left=488, top=6, right=638, bottom=81, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P_CMPY', left=191, top=6, right=475, bottom=81, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{CURROW}', left=63, top=6, right=178, bottom=81, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=59 ,top=87 ,right=1869 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=644 ,top=0 ,right=644 ,bottom=87 </L>
	<L> left=481 ,top=0 ,right=481 ,bottom=87 </L>
	<L> left=181 ,top=0 ,right=181 ,bottom=87 </L>
	<L> left=828 ,top=0 ,right=828 ,bottom=87 </L>
	<L> left=56 ,top=0 ,right=56 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1866 ,top=0 ,right=1866 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1656 ,top=0 ,right=1656 ,bottom=87 </L>
	<L> left=1275 ,top=0 ,right=1275 ,bottom=87 </L>
	<L> left=922 ,top=0 ,right=922 ,bottom=87 </L>
</B>

</R>
</A>

<A>id=Area7 ,left=0,top=0 ,right=2871 ,bottom=133
	<R>id='3-1차량.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 , MasterDataID='gcds_print04' 
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=215 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=55 ,top=116 ,right=1867 ,bottom=214 ,border=true ,penstyle=solid ,penwidth=2</X>
	<L> left=999 ,top=172 ,right=999 ,bottom=214 </L>
	<L> left=1387 ,top=119 ,right=1387 ,bottom=214 </L>
	<L> left=1653 ,top=116 ,right=1653 ,bottom=214 </L>
	<L> left=831 ,top=116 ,right=831 ,bottom=214 </L>
	<L> left=477 ,top=116 ,right=477 ,bottom=214 </L>
	<L> left=179 ,top=116 ,right=179 ,bottom=214 </L>
	<T>id='적재' ,left=844 ,top=122 ,right=1379 ,bottom=167 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=833 ,top=169 ,right=1387 ,bottom=169 </L>
	<T>id='인원' ,left=841 ,top=177 ,right=986 ,bottom=211 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='화물 ' ,left=1007 ,top=174 ,right=1382 ,bottom=211 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='순서' ,left=63 ,top=124 ,right=177 ,bottom=209 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량유형' ,left=187 ,top=124 ,right=472 ,bottom=209 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량번호' ,left=488 ,top=124 ,right=823 ,bottom=209 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='운전자' ,left=1395 ,top=124 ,right=1648 ,bottom=209 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='복귀예정일' ,left=1661 ,top=124 ,right=1859 ,bottom=209 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3. 차량 현황 ' ,left=55 ,top=61 ,right=1867 ,bottom=108 ,align='left' ,face='굴림' ,size=13 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

</R>
</A>
<A>id=Area8 ,left=0,top=0 ,right=2871 ,bottom=141
	<R>id='3-1차량현황_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='gcds_print03' 
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=87 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1650 ,top=0 ,right=1650 ,bottom=87 </L>
	<L> left=178 ,top=0 ,right=178 ,bottom=87 </L>
	<L> left=475 ,top=0 ,right=475 ,bottom=87 </L>
	<L> left=997 ,top=0 ,right=997 ,bottom=87 </L>
	<L> left=828 ,top=0 ,right=828 ,bottom=87 </L>
	<L> left=1384 ,top=0 ,right=1384 ,bottom=87 </L>
	<C>id='R_DATE', left=1659, top=6, right=1856, bottom=84, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PSN_KNAME', left=1391, top=6, right=1644, bottom=84, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RDS_GOODS', left=1006, top=6, right=1378, bottom=84, align='left', face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PERSON_CNT', left=838, top=6, right=984, bottom=84, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CAR_NO', left=484, top=6, right=819, bottom=84, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CAR_NAME', left=184, top=6, right=469, bottom=84, align='left', face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{CURROW}', left=63, top=6, right=172, bottom=84, face='굴림', size=8,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=53 ,top=91 ,right=1863 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1863 ,top=0 ,right=1863 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=53 ,top=0 ,right=53 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

</R>
</A>

<A>id=Area9 ,left=0,top=0 ,right=2871 ,bottom=133
	<R>id='4-1기타.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 , MasterDataID='gcds_print03' 
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=381 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=63 ,top=151 ,right=1875 ,bottom=357 ,border=true ,penstyle=solid ,penwidth=2</X>
	<C>id='', left=1205, top=259, right=1867, bottom=349, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=496, top=259, right=1184, bottom=349, face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1194 ,top=153 ,right=1194 ,bottom=354 </L>
	<L> left=485 ,top=153 ,right=485 ,bottom=354 </L>
	<L> left=66 ,top=251 ,right=1872 ,bottom=251 </L>
	<T>id='휴대품' ,left=1205 ,top=159 ,right=1867 ,bottom=246 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구분' ,left=69 ,top=159 ,right=480 ,bottom=246 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='적재품' ,left=496 ,top=159 ,right=1184 ,bottom=246 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내용' ,left=69 ,top=259 ,right=480 ,bottom=349 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4-1.기타물품 ' ,left=63 ,top=95 ,right=1875 ,bottom=148 ,align='left' ,face='굴림' ,size=13 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
</R>
</A>
<B>id=Footer ,left=0 ,top=2733 ,right=2001 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=396 ,top=26 ,right=1453 ,bottom=106</T>
</B>

">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcrp_print03  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="gcds_print03">
	<param NAME="DetailDataID"				VALUE="gcds_print04">
	<PARAM NAME="PaperSize"						VALUE="A4">	
	<PARAM NAME="LandScape"					  VALUE="true">
    <PARAM NAME="PrintSetupDlgFlag"		VALUE="true">
	<PARAM NAME="PreviewZoom"					VALUE="100">
	<PARAM NAME="Format"							VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='군사분계선 통행 신청서.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_print03'

<B>id=Header ,left=0,top=0 ,right=2869 ,bottom=249 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='군사분계선 통행 신청서' ,left=1081 ,top=48 ,right=1661 ,bottom=119 ,face='굴림' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='MDL Crossing Request' ,left=1002 ,top=124 ,right=1756 ,bottom=190 ,face='굴림' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=622 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=88 ,top=94 ,right=2688 ,bottom=369 ,border=true</X>
	<X>left=88 ,top=503 ,right=2688 ,bottom=622 ,border=true</X>
	<C>id='GOODS', left=2144, top=316, right=2678, bottom=366, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='GOODS', left=2144, top=262, right=2678, bottom=309, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='CARGO' ,left=2144 ,top=178 ,right=2678 ,bottom=247 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='화물' ,left=2144 ,top=100 ,right=2678 ,bottom=172 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량' ,left=2000 ,top=100 ,right=2128 ,bottom=172 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RCAR_CNT', left=2000, top=316, right=2128, bottom=366, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SCAR_CNT', left=1856, top=262, right=1984, bottom=309, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='VEH(S-N)' ,left=1856 ,top=178 ,right=1984 ,bottom=247 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SPERSON_CNT', left=1713, top=316, right=1844, bottom=366, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SPERSON_CNT', left=1572, top=262, right=1700, bottom=309, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='VEH(N-S)' ,left=2000 ,top=178 ,right=2128 ,bottom=247 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2134 ,top=94 ,right=2134 ,bottom=369 </L>
	<T>id='차량' ,left=1856 ,top=100 ,right=1984 ,bottom=172 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='PAX(N-S)' ,left=1713 ,top=178 ,right=1844 ,bottom=247 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1991 ,top=94 ,right=1991 ,bottom=369 </L>
	<T>id='인원' ,left=1713 ,top=100 ,right=1844 ,bottom=172 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1847 ,top=94 ,right=1847 ,bottom=366 </L>
	<T>id='인원' ,left=1572 ,top=100 ,right=1700 ,bottom=172 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='PAX(S-N)' ,left=1572 ,top=178 ,right=1700 ,bottom=247 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1706 ,top=94 ,right=1706 ,bottom=369 </L>
	<C>id='P_POSE', left=1047, top=316, right=1556, bottom=366, align='left', face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P_POSE', left=1047, top=262, right=1556, bottom=309, align='left', face='굴림', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='PURPOSE' ,left=1047 ,top=178 ,right=1556 ,bottom=247 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='목적' ,left=1047 ,top=100 ,right=1556 ,bottom=172 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='N-S' ,left=866 ,top=316 ,right=1031 ,bottom=366 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RTRN_TIME', left=713, top=316, right=853, bottom=366, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='S-N ' ,left=534 ,top=262 ,right=700 ,bottom=309 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='START_TIME', left=388, top=262, right=528, bottom=309, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='START_D', left=234, top=316, right=375, bottom=366, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='START_D', left=234, top=262, right=375, bottom=309, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1563 ,top=94 ,right=1563 ,bottom=369 </L>
	<L> left=1038 ,top=94 ,right=1038 ,bottom=366 </L>
	<T>id='DIR(N-S)' ,left=866 ,top=181 ,right=1031 ,bottom=247 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='북-남' ,left=866 ,top=141 ,right=1031 ,bottom=181 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='방향' ,left=866 ,top=97 ,right=1031 ,bottom=137 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='방향' ,left=534 ,top=97 ,right=700 ,bottom=137 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='남-북' ,left=534 ,top=141 ,right=700 ,bottom=181 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='DIR(S-N)' ,left=534 ,top=181 ,right=700 ,bottom=247 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=856 ,top=94 ,right=856 ,bottom=369 </L>
	<T>id='통행시간' ,left=713 ,top=97 ,right=853 ,bottom=131 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='S-N' ,left=713 ,top=212 ,right=853 ,bottom=247 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='MDL_TIME' ,left=713 ,top=175 ,right=853 ,bottom=209 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='북-남' ,left=713 ,top=134 ,right=853 ,bottom=169 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=88 ,top=312 ,right=2688 ,bottom=312 </L>
	<L> left=706 ,top=94 ,right=706 ,bottom=366 </L>
	<T>id='S-N' ,left=388 ,top=212 ,right=528 ,bottom=247 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='MDL_TIME' ,left=388 ,top=175 ,right=528 ,bottom=209 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='남-북' ,left=388 ,top=134 ,right=528 ,bottom=169 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='통행시간' ,left=388 ,top=97 ,right=528 ,bottom=131 ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=531 ,top=94 ,right=531 ,bottom=369 </L>
	<L> left=381 ,top=94 ,right=381 ,bottom=369 </L>
	<T>id='일자' ,left=234 ,top=97 ,right=375 ,bottom=169 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='DATE' ,left=234 ,top=181 ,right=375 ,bottom=247 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=228 ,top=94 ,right=228 ,bottom=369 </L>
	<T>id='TCN' ,left=94 ,top=181 ,right=225 ,bottom=247 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관리번호' ,left=94 ,top=141 ,right=225 ,bottom=181 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='동행' ,left=94 ,top=97 ,right=225 ,bottom=137 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=88 ,top=253 ,right=2688 ,bottom=253 </L>
	<T>id='순서' ,left=94 ,top=509 ,right=222 ,bottom=559 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Order' ,left=94 ,top=566 ,right=222 ,bottom=616 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소속' ,left=234 ,top=509 ,right=525 ,bottom=559 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Company' ,left=234 ,top=566 ,right=525 ,bottom=616 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직책' ,left=538 ,top=509 ,right=850 ,bottom=559 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Title' ,left=538 ,top=566 ,right=850 ,bottom=616 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이름' ,left=866 ,top=509 ,right=1309 ,bottom=559 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Name' ,left=866 ,top=566 ,right=1309 ,bottom=616 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성별' ,left=1325 ,top=509 ,right=1497 ,bottom=559 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Sex' ,left=1325 ,top=566 ,right=1497 ,bottom=616 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주소' ,left=1928 ,top=509 ,right=2413 ,bottom=559 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='복귀예정일' ,left=2428 ,top=509 ,right=2681 ,bottom=559 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Return Date' ,left=2428 ,top=566 ,right=2681 ,bottom=616 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Address' ,left=1928 ,top=562 ,right=2413 ,bottom=612 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민등록번호' ,left=1516 ,top=509 ,right=1913 ,bottom=559 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='KID' ,left=1516 ,top=566 ,right=1913 ,bottom=616 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=531 ,top=503 ,right=531 ,bottom=622 </L>
	<L> left=228 ,top=503 ,right=228 ,bottom=622 </L>
	<L> left=1319 ,top=503 ,right=1319 ,bottom=622 </L>
	<L> left=1506 ,top=503 ,right=1506 ,bottom=622 </L>
	<L> left=1919 ,top=503 ,right=1919 ,bottom=622 </L>
	<L> left=2419 ,top=503 ,right=2419 ,bottom=622 </L>
	<L> left=856 ,top=503 ,right=856 ,bottom=622 </L>
	<T>id='1. SUMMERY / 요약' ,left=88 ,top=25 ,right=2688 ,bottom=91 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2. Personnel data / 인원현황' ,left=88 ,top=431 ,right=2688 ,bottom=497 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

</R>
</A>
<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=141
	<R>id='인원현황_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='gcds_print04' 

<B>id=default ,left=0,top=0 ,right=2869 ,bottom=60 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='{CURROW}', left=95, top=8, right=221, bottom=56, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P_CMPY', left=235, top=8, right=525, bottom=56, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_DUTY', left=538, top=8, right=849, bottom=56, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=87 ,top=61 ,right=2689 ,bottom=61 </L>
	<L> left=87 ,top=0 ,right=87 ,bottom=61 </L>
	<L> left=530 ,top=0 ,right=530 ,bottom=61 </L>
	<L> left=857 ,top=0 ,right=857 ,bottom=61 </L>
	<L> left=227 ,top=0 ,right=227 ,bottom=61 </L>
	<C>id='PRSN_NAME', left=867, top=8, right=1310, bottom=56, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SEX', left=1326, top=8, right=1498, bottom=56, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P_REGNO', left=1516, top=8, right=1914, bottom=56, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1506 ,top=0 ,right=1506 ,bottom=61 </L>
	<L> left=1318 ,top=0 ,right=1318 ,bottom=61 </L>
	<L> left=1920 ,top=0 ,right=1920 ,bottom=61 </L>
	<L> left=2687 ,top=0 ,right=2687 ,bottom=61 </L>
	<L> left=2418 ,top=0 ,right=2418 ,bottom=61 </L>
	<C>id='ADDRESS1', left=1927, top=8, right=2413, bottom=56, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='R_DATE', left=2426, top=8, right=2679, bottom=58, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
</B>

</R>
</A>

<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='군사분계선 통행 신청서(차량현황).sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_print03'
<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=322 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=88 ,top=144 ,right=2688 ,bottom=322 ,border=true</X>
	<T>id='Pax ' ,left=1128 ,top=269 ,right=1238 ,bottom=319 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='/ 화물' ,left=1688 ,top=269 ,right=1822 ,bottom=319 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1378 ,top=266 ,right=1378 ,bottom=322 </L>
	<L> left=1094 ,top=144 ,right=1094 ,bottom=322 </L>
	<L> left=531 ,top=144 ,right=531 ,bottom=322 </L>
	<T>id='Contents' ,left=1103 ,top=209 ,right=2047 ,bottom=259 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Driver' ,left=2059 ,top=237 ,right=2413 ,bottom=316 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='운전자' ,left=2059 ,top=153 ,right=2413 ,bottom=231 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Return Date' ,left=2428 ,top=237 ,right=2681 ,bottom=316 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='복귀예정일' ,left=2428 ,top=153 ,right=2681 ,bottom=231 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2050 ,top=144 ,right=2050 ,bottom=322 </L>
	<L> left=2419 ,top=144 ,right=2419 ,bottom=322 </L>
	<T>id='Veh #' ,left=538 ,top=237 ,right=1088 ,bottom=316 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량 번호' ,left=538 ,top=153 ,right=1088 ,bottom=231 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Mode' ,left=234 ,top=237 ,right=525 ,bottom=316 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량 유형' ,left=234 ,top=153 ,right=525 ,bottom=231 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Order' ,left=94 ,top=237 ,right=222 ,bottom=316 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=228 ,top=144 ,right=228 ,bottom=322 </L>
	<T>id='순서' ,left=94 ,top=153 ,right=222 ,bottom=231 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='/ 인원' ,left=1238 ,top=269 ,right=1375 ,bottom=319 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Cargos ' ,left=1481 ,top=269 ,right=1681 ,bottom=319 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1097 ,top=262 ,right=2050 ,bottom=262 </L>
	<T>id='내용' ,left=1103 ,top=153 ,right=2047 ,bottom=203 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3. Vehicles / 차량 현황' ,left=88 ,top=75 ,right=2688 ,bottom=141 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

</R>
</A>

<A>id=Area4 ,left=0,top=0 ,right=2871 ,bottom=141
	<R>id='군사분계선 통행 신청서(차량현황)_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='gcds_print03' 
<B>id=default ,left=0,top=0 ,right=2869 ,bottom=63 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='{CURROW}', left=95, top=8, right=221, bottom=56, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CAR_NAME', left=235, top=8, right=525, bottom=56, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=87 ,top=0 ,right=87 ,bottom=63 </L>
	<L> left=227 ,top=0 ,right=227 ,bottom=63 </L>
	<C>id='R_DATE', left=2426, top=8, right=2679, bottom=58, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2418 ,top=0 ,right=2418 ,bottom=63 </L>
	<L> left=530 ,top=0 ,right=530 ,bottom=63 </L>
	<L> left=1094 ,top=0 ,right=1094 ,bottom=63 </L>
	<C>id='CAR_NO', left=538, top=8, right=1086, bottom=56, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1379 ,top=0 ,right=1379 ,bottom=63 </L>
	<C>id='PERSON_CNT', left=1102, top=8, right=1374, bottom=56, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PRSN_NAME', left=2059, top=8, right=2413, bottom=56, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2051 ,top=0 ,right=2051 ,bottom=63 </L>
	<C>id='RDS_GOODS', left=1387, top=8, right=2046, bottom=56, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2687 ,top=0 ,right=2687 ,bottom=63 </L>
	<L> left=87 ,top=61 ,right=2687 ,bottom=61 </L>
</B>

</R>
</A>

<A>id=Area5 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='군사분계선 통행 신청서(cargos manifest).sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_print03'
	<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=419 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=88 ,top=144 ,right=2688 ,bottom=378 ,border=true</X>
	<T>id='방향' ,left=94 ,top=153 ,right=525 ,bottom=200 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Direction' ,left=94 ,top=203 ,right=525 ,bottom=250 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자재 & 장비' ,left=538 ,top=153 ,right=1728 ,bottom=200 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='개인 소지품' ,left=1747 ,top=153 ,right=2678 ,bottom=200 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Material & Equipment' ,left=538 ,top=203 ,right=1728 ,bottom=250 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Driver' ,left=1747 ,top=203 ,right=2678 ,bottom=250 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=91 ,top=256 ,right=2688 ,bottom=256 </L>
	<T>id='S-N' ,left=94 ,top=262 ,right=525 ,bottom=312 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='N-S' ,left=94 ,top=322 ,right=525 ,bottom=369 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=91 ,top=316 ,right=2688 ,bottom=316 </L>
	<L> left=531 ,top=144 ,right=531 ,bottom=375 </L>
	<C>id='RDS_GOODS', left=538, top=262, right=1728, bottom=312, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RDS_GOODS', left=538, top=322, right=1728, bottom=369, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1734 ,top=144 ,right=1734 ,bottom=375 </L>
	<C>id='RDS_GOODS', left=1747, top=262, right=2678, bottom=312, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RDS_GOODS', left=1747, top=322, right=2678, bottom=369, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='4. Cargos Manifest / 화물 목록' ,left=88 ,top=75 ,right=2688 ,bottom=141 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

</R>
</A>
<B>id=Footer ,left=0 ,top=1871 ,right=2869 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=775 ,top=21 ,right=1833 ,bottom=100</T>
</B>

">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcrp_print04  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="gcds_print05">
	<param NAME="DetailDataID"				VALUE="gcds_print05">
	<PARAM NAME="PaperSize"						VALUE="A4">	
	<PARAM NAME="LandScape"					  VALUE="False">
    <PARAM NAME="PrintSetupDlgFlag"		VALUE="true">
	<PARAM NAME="PreviewZoom"					VALUE="100">
	<PARAM NAME="Format"							VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2541 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='현 대 아 산' ,left=253 ,top=2375 ,right=1638 ,bottom=2475 ,face='HY견명조' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='START_DATE', left=900, top=866, right=1403, bottom=962, face='HY견명조', size=18,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='START_DA', left=1447, top=866, right=1619, bottom=962, face='HY견명조', size=18,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='첨부 : 개성공업지구 방문계획.  끝.' ,left=150 ,top=1575 ,right=1853 ,bottom=1678 ,align='left' ,face='HY견명조' ,size=18 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='첨부와 같이 알려 드립니다.' ,left=78 ,top=1119 ,right=1781 ,bottom=1216 ,align='left' ,face='HY견명조' ,size=18 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공업지구를 방문하는 현대아산 및 협력업체 임직원들의 명단을' ,left=78 ,top=991 ,right=1781 ,bottom=1087 ,align='left' ,face='HY견명조' ,size=18 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='개성공단 건설공사를 위하여 ' ,left=78 ,top=866 ,right=888 ,bottom=962 ,align='left' ,face='HY견명조' ,size=18 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='개성' ,left=1666 ,top=866 ,right=1822 ,bottom=962 ,align='left' ,face='HY견명조' ,size=18 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(' ,left=1409 ,top=866 ,right=1438 ,bottom=962 ,align='left' ,face='HY견명조' ,size=18 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='))' ,left=1628 ,top=866 ,right=1656 ,bottom=962 ,align='left' ,face='HY견명조' ,size=18 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='조선민주주의인민공화국' ,left=0 ,top=341 ,right=1934 ,bottom=462 ,face='HY견명조' ,size=26 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ST_DATE', left=88, top=2022, right=1791, bottom=2119, face='HY견명조', size=18,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='개성공업지구 출입국 사업부 앞' ,left=0 ,top=469 ,right=1934 ,bottom=591 ,face='HY견명조' ,size=26 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcrp_print05  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="gcds_print06">
	<param NAME="DetailDataID"				VALUE="gcds_print06">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="False">
    <PARAM NAME="PrintSetupDlgFlag"		    VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"							VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2716 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=131 ,top=1778 ,right=1831 ,bottom=2653 ,border=true</X>
	<X>left=131 ,top=781 ,right=1831 ,bottom=1656 ,border=true</X>
	<T>id='1. 출입인원 및 차량 총괄' ,left=138 ,top=544 ,right=1841 ,bottom=641 ,align='left' ,face='HY견명조' ,size=18 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='o 인 원' ,left=138 ,top=650 ,right=1841 ,bottom=747 ,align='left' ,face='HY견명조' ,size=18 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=425 ,top=353 ,right=1569 ,bottom=353 </L>
	<L> left=134 ,top=934 ,right=1828 ,bottom=934 </L>
	<L> left=134 ,top=1931 ,right=1828 ,bottom=1931 </L>
	<T>id='기타' ,left=1684 ,top=1787 ,right=1825 ,bottom=1928 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='트레' ,left=1525 ,top=1784 ,right=1672 ,bottom=1853 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='일러' ,left=1525 ,top=1856 ,right=1672 ,bottom=1925 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='화물차' ,left=1366 ,top=1787 ,right=1513 ,bottom=1928 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='승용차' ,left=1203 ,top=1787 ,right=1350 ,bottom=1928 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='버스' ,left=1047 ,top=1787 ,right=1194 ,bottom=1928 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=891 ,top=1787 ,right=1038 ,bottom=1928 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구 분' ,left=138 ,top=1787 ,right=306 ,bottom=1928 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='일 자' ,left=322 ,top=1787 ,right=881 ,bottom=1928 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=719 ,top=2050 ,right=1828 ,bottom=2050 </L>
	<L> left=719 ,top=2169 ,right=1825 ,bottom=2169 </L>
	<L> left=516 ,top=2287 ,right=1831 ,bottom=2287 </L>
	<L> left=719 ,top=2406 ,right=1825 ,bottom=2406 </L>
	<L> left=719 ,top=2528 ,right=1825 ,bottom=2528 </L>
	<L> left=884 ,top=1781 ,right=884 ,bottom=2653 </L>
	<L> left=1356 ,top=1781 ,right=1356 ,bottom=2653 </L>
	<L> left=1197 ,top=1781 ,right=1197 ,bottom=2653 </L>
	<L> left=1519 ,top=1781 ,right=1519 ,bottom=2653 </L>
	<L> left=1675 ,top=1781 ,right=1675 ,bottom=2653 </L>
	<L> left=719 ,top=1931 ,right=719 ,bottom=2653 </L>
	<L> left=513 ,top=1931 ,right=513 ,bottom=2653 </L>
	<L> left=313 ,top=1781 ,right=313 ,bottom=2653 </L>
	<T>id='남->북' ,left=522 ,top=1941 ,right=713 ,bottom=2281 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='북->남' ,left=522 ,top=2300 ,right=713 ,bottom=2641 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='START_DATE', left=322, top=1941, right=509, bottom=2644, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(대수)' ,left=144 ,top=2300 ,right=300 ,bottom=2378 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='o 차량 / 장비' ,left=131 ,top=1669 ,right=1834 ,bottom=1766 ,align='left' ,face='HY견명조' ,size=18 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구 분' ,left=138 ,top=791 ,right=306 ,bottom=931 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=513 ,top=937 ,right=513 ,bottom=1650 </L>
	<L> left=719 ,top=937 ,right=719 ,bottom=1650 </L>
	<C>id='START_DATE', left=322, top=944, right=509, bottom=1647, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='일 자' ,left=322 ,top=791 ,right=881 ,bottom=931 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='남->북' ,left=522 ,top=944 ,right=713 ,bottom=1284 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=313 ,top=781 ,right=313 ,bottom=1650 </L>
	<L> left=884 ,top=781 ,right=884 ,bottom=1650 </L>
	<C>id='START_TIME', left=725, top=944, right=881, bottom=1053, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=719 ,top=1059 ,right=1828 ,bottom=1059 </L>
	<C>id='START_TIME2', left=725, top=1066, right=881, bottom=1175, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='북->남' ,left=522 ,top=1309 ,right=713 ,bottom=1650 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=719 ,top=1178 ,right=1828 ,bottom=1178 </L>
	<C>id='START_TIME3', left=725, top=1184, right=881, bottom=1294, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=516 ,top=1297 ,right=1831 ,bottom=1297 </L>
	<L> left=719 ,top=1534 ,right=1828 ,bottom=1534 </L>
	<L> left=719 ,top=1416 ,right=1828 ,bottom=1416 </L>
	<T>id='계' ,left=894 ,top=791 ,right=1191 ,bottom=931 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사 업 자' ,left=1209 ,top=791 ,right=1506 ,bottom=931 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='운 전 자' ,left=1525 ,top=791 ,right=1822 ,bottom=931 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량' ,left=144 ,top=2219 ,right=300 ,bottom=2297 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(명)' ,left=144 ,top=1281 ,right=300 ,bottom=1359 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인원' ,left=144 ,top=1200 ,right=300 ,bottom=1278 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='개성공업지구 방문계획' ,left=31 ,top=219 ,right=1966 ,bottom=347 ,face='HY견명조' ,size=26 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='START_TIME', left=725, top=1937, right=881, bottom=2047, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(DRIVER_CNT,0,'-',DRIVER_CNT)}, left=1525, top=944, right=1822, bottom=1053, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(DRIVER_CNT3,0,'-',DRIVER_CNT3)}, left=1525, top=1184, right=1822, bottom=1294, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(DRIVER_CNT2,0,'-',DRIVER_CNT2)}, left=1525, top=1066, right=1822, bottom=1175, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TOT_PER_CNT3,0,'-',TOT_PER_CNT3)}, left=894, top=1184, right=1191, bottom=1294, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TOT_PER_CNT2,0,'-',TOT_PER_CNT2)}, left=894, top=1066, right=1191, bottom=1175, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(PER_CNT,0,'-',PER_CNT)}, left=1209, top=944, right=1506, bottom=1053, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RTRN_TIME2', left=725, top=1422, right=881, bottom=1531, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RTRN_TIME', left=725, top=1303, right=881, bottom=1412, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TOT_PER_CNT,0,'-',TOT_PER_CNT)}, left=894, top=944, right=1191, bottom=1053, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='START_TIME2', left=725, top=2056, right=881, bottom=2166, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(PER_CNT2,0,'-',PER_CNT2)}, left=1209, top=1066, right=1506, bottom=1175, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(PER_CNT3,0,'-',PER_CNT3)}, left=1209, top=1184, right=1506, bottom=1294, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RTRN_TIME3', left=725, top=1541, right=881, bottom=1650, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TOT_PER_CN,0,'-',TOT_PER_CN)}, left=894, top=1303, right=1191, bottom=1412, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(PER_CN,0,'-',PER_CN)}, left=1209, top=1303, right=1506, bottom=1412, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(DRIVER_CN,0,'-',DRIVER_CN)}, left=1525, top=1303, right=1822, bottom=1412, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TOT_PER_CN2,0,'-',TOT_PER_CN2)}, left=894, top=1422, right=1191, bottom=1531, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(PER_CNT2,0,'-',PER_CNT2)}, left=1209, top=1422, right=1506, bottom=1531, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(DRIVER_CN2,0,'-',DRIVER_CN2)}, left=1525, top=1422, right=1822, bottom=1531, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(PER_CN3,0,'-',PER_CN3)}, left=1209, top=1541, right=1506, bottom=1650, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(DRIVER_CN3,0,'-',DRIVER_CN3)}, left=1525, top=1541, right=1822, bottom=1650, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='START_TIME3', left=725, top=2175, right=881, bottom=2284, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RTRN_TIME', left=725, top=2294, right=881, bottom=2403, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RTRN_TIME2', left=725, top=2412, right=881, bottom=2522, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RTRN_TIME3', left=725, top=2537, right=881, bottom=2647, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TRUCK_CNT,0,'-',TRUCK_CNT)}, left=1366, top=1937, right=1513, bottom=2047, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TRAIL_CNT,0,'-',TRAIL_CNT)}, left=1525, top=1937, right=1672, bottom=2047, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TOT_CNT2,0,'-',TOT_CNT2)}, left=894, top=2056, right=1034, bottom=2166, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(CAR_CNT2,0,'-',CAR_CNT2)}, left=1203, top=2056, right=1350, bottom=2166, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TRUCK_CNT2,0,'-',TRUCK_CNT2)}, left=1366, top=2056, right=1513, bottom=2166, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TRAIL_CNT2,0,'-',TRAIL_CNT2)}, left=1525, top=2056, right=1672, bottom=2166, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(CAR_CNT3,0,'-',CAR_CNT3)}, left=1203, top=2175, right=1350, bottom=2284, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TRUCK_CNT3,0,'-',TRUCK_CNT3)}, left=1366, top=2175, right=1513, bottom=2284, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TRAIL_CNT3,0,'-',TRAIL_CNT3)}, left=1525, top=2175, right=1672, bottom=2284, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TRUCK_CN,0,'-',TRUCK_CN)}, left=1366, top=2294, right=1513, bottom=2403, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TRAIL_CN,0,'-',TRAIL_CN)}, left=1525, top=2294, right=1672, bottom=2403, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TRUCK_CN2,0,'-',TRUCK_CN2)}, left=1366, top=2412, right=1513, bottom=2522, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TRAIL_CN2,0,'-',TRAIL_CN2)}, left=1525, top=2412, right=1672, bottom=2522, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TRUCK_CN3,0,'-',TRUCK_CN3)}, left=1366, top=2537, right=1513, bottom=2647, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TRAIL_CN3,0,'-',TRAIL_CN3)}, left=1525, top=2537, right=1672, bottom=2647, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TOT_PER_CN3,0,'-',TOT_PER_CN3)}, left=894, top=1541, right=1191, bottom=1650, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(BUS_CN,0,'-',BUS_CN)}, left=1047, top=2294, right=1194, bottom=2403, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(BUS_CN3,0,'-',BUS_CN3)}, left=1047, top=2537, right=1194, bottom=2647, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(BUS_CN2,0,'-',BUS_CN2)}, left=1047, top=2412, right=1194, bottom=2522, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(CAR_CN3,0,'-',CAR_CN3)}, left=1203, top=2537, right=1350, bottom=2647, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(CAR_CN2,0,'-',CAR_CN2)}, left=1203, top=2412, right=1350, bottom=2522, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(CAR_CN,0,'-',CAR_CN)}, left=1203, top=2294, right=1350, bottom=2403, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(ETC_CN3,0,'-',ETC_CN3)}, left=1684, top=2537, right=1825, bottom=2647, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(ETC_CNT,0,'-',ETC_CNT)}, left=1684, top=1937, right=1825, bottom=2047, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(ETC_CNT2,0,'-',ETC_CNT2)}, left=1684, top=2056, right=1825, bottom=2166, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(ETC_CNT3,0,'-',ETC_CNT3)}, left=1684, top=2175, right=1825, bottom=2284, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(ETC_CN,0,'-',ETC_CN)}, left=1681, top=2297, right=1822, bottom=2406, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(ETC_CN2,0,'-',ETC_CN2)}, left=1684, top=2412, right=1825, bottom=2522, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1519 ,top=781 ,right=1519 ,bottom=1650 </L>
	<C>id={DECODE(CAR_CNT,0,'-',CAR_CNT)}, left=1203, top=1937, right=1350, bottom=2047, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1197 ,top=781 ,right=1197 ,bottom=1650 </L>
	<L> left=1041 ,top=1781 ,right=1041 ,bottom=2653 </L>
	<C>id={DECODE(TOT_CNT3,0,'-',TOT_CNT3)}, left=894, top=2175, right=1034, bottom=2284, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TOT_CN,0,'-',TOT_CN)}, left=894, top=2294, right=1034, bottom=2403, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TOT_CN2,0,'-',TOT_CN2)}, left=894, top=2412, right=1034, bottom=2522, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TOT_CN3,0,'-',TOT_CN3)}, left=894, top=2537, right=1034, bottom=2647, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(TOT_CNT,0,'-',TOT_CNT)}, left=894, top=1937, right=1034, bottom=2047, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(BUS_CNT,0,'-',BUS_CNT)}, left=1047, top=1937, right=1194, bottom=2047, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(BUS_CNT2,0,'-',BUS_CNT2)}, left=1047, top=2056, right=1194, bottom=2166, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id={DECODE(BUS_CNT3,0,'-',BUS_CNT3)}, left=1047, top=2175, right=1194, bottom=2284, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
</B>
">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<object id=gcrp_print06 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="DetailDataID"		value="gcds_print10">
	<param name="PaperSize"			value="A4">
	<PARAM NAME="LandScape"					VALUE="false">
	<PARAM NAME="PrintSetupDlgFlag"		    VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<param name="SuppressColumns"	value="1:PageSkip,RTRN_TIME;">
	<param name="MargineX"                        value="20">
	<param name="Format"			value="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=250 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='2. 복귀인원' ,left=53 ,top=144 ,right=1888 ,bottom=241 ,align='left' ,face='HY견명조' ,size=20 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=293 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=53 ,top=169 ,right=1888 ,bottom=294 ,border=true</X>
	<L> left=1078 ,top=172 ,right=1078 ,bottom=294 </L>
	<L> left=975 ,top=169 ,right=975 ,bottom=294 </L>
	<L> left=756 ,top=169 ,right=756 ,bottom=294 </L>
	<L> left=575 ,top=169 ,right=575 ,bottom=294 </L>
	<L> left=169 ,top=169 ,right=169 ,bottom=294 </L>
	<L> left=1338 ,top=172 ,right=1338 ,bottom=294 </L>
	<L> left=344 ,top=172 ,right=344 ,bottom=294 </L>
	<L> left=1669 ,top=172 ,right=1669 ,bottom=294 </L>
	<T>id='순번' ,left=59 ,top=178 ,right=163 ,bottom=287 ,face='HY견명조' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직위' ,left=584 ,top=178 ,right=750 ,bottom=287 ,face='HY견명조' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소속' ,left=350 ,top=178 ,right=572 ,bottom=287 ,face='HY견명조' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관련업무' ,left=175 ,top=178 ,right=341 ,bottom=287 ,face='HY견명조' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='생년월일' ,left=1084 ,top=178 ,right=1331 ,bottom=287 ,face='HY견명조' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성별' ,left=984 ,top=178 ,right=1075 ,bottom=287 ,face='HY견명조' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=766 ,top=178 ,right=969 ,bottom=287 ,face='HY견명조' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주소' ,left=1347 ,top=178 ,right=1659 ,bottom=287 ,face='HY견명조' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='방문일시' ,left=1678 ,top=178 ,right=1881 ,bottom=287 ,face='HY견명조' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{CURROW}', left=59, top=75, right=163, bottom=162, face='HY견명조', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RTRN_TIME', left=663, top=75, right=816, bottom=162 ,mask='XX:XX', face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='군사분계선 통과)' ,left=831 ,top=75 ,right=1356 ,bottom=162 ,align='left' ,face='HY견명조' ,size=16 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='복귀인원 인적사항(' ,left=166 ,top=72 ,right=659 ,bottom=159 ,align='left' ,face='HY견명조' ,size=16 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=109 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=975 ,top=0 ,right=975 ,bottom=109 </L>
	<L> left=1078 ,top=0 ,right=1078 ,bottom=109 </L>
	<C>id='PRSN_NAME', left=766, top=6, right=966, bottom=103, face='HY견명조', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{CURROW}', left=59, top=6, right=163, bottom=103, face='HY견명조', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=344 ,top=0 ,right=344 ,bottom=109 </L>
	<C>id='P_CMPY', left=350, top=6, right=572, bottom=103, face='HY견명조', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PR_REGNO', left=1084, top=6, right=1331, bottom=103, face='HY견명조', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1338 ,top=0 ,right=1338 ,bottom=109 </L>
	<C>id='ADDRESS1', left=1347, top=6, right=1659, bottom=103, align='left', face='HY견명조', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1669 ,top=0 ,right=1669 ,bottom=109 </L>
	<L> left=53 ,top=109 ,right=1888 ,bottom=109 </L>
	<C>id='START_D', left=1678, top=6, right=1881, bottom=103, face='HY견명조', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=575 ,top=0 ,right=575 ,bottom=109 </L>
	<L> left=756 ,top=0 ,right=756 ,bottom=109 </L>
	<L> left=169 ,top=0 ,right=169 ,bottom=109 </L>
	<L> left=53 ,top=0 ,right=53 ,bottom=109 </L>
	<C>id='SEX', left=984, top=6, right=1075, bottom=103, face='HY견명조', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_DUTY', left=581, top=6, right=747, bottom=103, face='HY견명조', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RTRN_TIME', left=175, top=6, right=341, bottom=103, supplevel=1, face='Free 3 of 9 Regular', size=13,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1888 ,top=0 ,right=1888 ,bottom=109 </L>
</B>

">
</object>
</OBJECT><%=HDConstant.COMMENT_END%> 

<%=HDConstant.COMMENT_START%>
<object id=gcrp_print07 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param NAME="DetailDataID"				VALUE="gcds_print09"> 
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="false">
	<PARAM NAME="PrintSetupDlgFlag"		    VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<param name="MargineX"                        value="20">
	<param name="SuppressColumns"        	value="1:PageSkip,RTRN_TIME">
	<PARAM NAME="Format"					VALUE="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=250 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='3. 복귀차량' ,left=53 ,top=141 ,right=1888 ,bottom=244 ,align='left' ,face='HY견명조' ,size=20 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=297 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=53 ,top=169 ,right=1888 ,bottom=297 ,border=true</X>
	<L> left=1266 ,top=172 ,right=1266 ,bottom=297 </L>
	<L> left=684 ,top=169 ,right=684 ,bottom=294 </L>
	<L> left=294 ,top=169 ,right=294 ,bottom=294 </L>
	<L> left=1638 ,top=172 ,right=1638 ,bottom=297 </L>
	<T>id='표시번호' ,left=59 ,top=178 ,right=288 ,bottom=287 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량번호' ,left=694 ,top=178 ,right=1259 ,bottom=287 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차종' ,left=300 ,top=178 ,right=678 ,bottom=287 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='운전사' ,left=1275 ,top=178 ,right=1634 ,bottom=287 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='방문일' ,left=1647 ,top=178 ,right=1881 ,bottom=287 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RTRN_TIME', left=106, top=75, right=313, bottom=162 ,mask='XX:XX', face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='군사분계선 통과)' ,left=316 ,top=75 ,right=834 ,bottom=162 ,align='left' ,face='HY견명조' ,size=16 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(' ,left=72 ,top=75 ,right=103 ,bottom=162 ,align='left' ,face='HY견명조' ,size=16 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=109 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=53 ,top=109 ,right=1888 ,bottom=109 </L>
	<L> left=1884 ,top=0 ,right=1884 ,bottom=109 </L>
	<L> left=294 ,top=0 ,right=294 ,bottom=109 </L>
	<C>id='{CURROW}', left=59, top=6, right=288, bottom=103, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=684 ,top=0 ,right=684 ,bottom=109 </L>
	<C>id='CAR_NAME', left=300, top=6, right=678, bottom=103, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CAR_NO', left=694, top=6, right=1259, bottom=103, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1266 ,top=0 ,right=1266 ,bottom=109 </L>
	<C>id='PSN_KNAME', left=1275, top=6, right=1634, bottom=103, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1638 ,top=0 ,right=1638 ,bottom=109 </L>
	<C>id='START_D', left=1647, top=6, right=1881, bottom=103, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=53 ,top=0 ,right=53 ,bottom=109 </L>
</B>

">
</object>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<object id=gcrp_print08 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
		<param name="DetailDataID"		value="gcds_print08">
		<param name="PaperSize"			value="A4">
		<PARAM NAME="LandScape"					VALUE="false">
		<PARAM NAME="PrintSetupDlgFlag"		    VALUE="true">
		<PARAM NAME="PreviewZoom"				VALUE="100">
		<param name="MargineX"                        value="20">
		<param name="SuppressColumns"	value="1:PageSkip,START_TIME;">
		<param name="Format"			value="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=250 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='4. 방문인원' ,left=53 ,top=144 ,right=1888 ,bottom=241 ,align='left' ,face='HY견명조' ,size=20 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=293 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=53 ,top=169 ,right=1888 ,bottom=294 ,border=true</X>
	<L> left=1078 ,top=172 ,right=1078 ,bottom=294 </L>
	<L> left=975 ,top=169 ,right=975 ,bottom=294 </L>
	<L> left=756 ,top=169 ,right=756 ,bottom=294 </L>
	<L> left=575 ,top=169 ,right=575 ,bottom=294 </L>
	<L> left=169 ,top=169 ,right=169 ,bottom=294 </L>
	<L> left=1338 ,top=172 ,right=1338 ,bottom=294 </L>
	<L> left=344 ,top=172 ,right=344 ,bottom=294 </L>
	<L> left=1669 ,top=172 ,right=1669 ,bottom=294 </L>
	<T>id='순번' ,left=59 ,top=178 ,right=163 ,bottom=287 ,face='HY견명조' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직위' ,left=584 ,top=178 ,right=750 ,bottom=287 ,face='HY견명조' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소속' ,left=350 ,top=178 ,right=572 ,bottom=287 ,face='HY견명조' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관련업무' ,left=175 ,top=178 ,right=341 ,bottom=287 ,face='HY견명조' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='생년월일' ,left=1084 ,top=178 ,right=1331 ,bottom=287 ,face='HY견명조' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성별' ,left=984 ,top=178 ,right=1075 ,bottom=287 ,face='HY견명조' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=766 ,top=178 ,right=969 ,bottom=287 ,face='HY견명조' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주소' ,left=1347 ,top=178 ,right=1659 ,bottom=287 ,face='HY견명조' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='방문일시' ,left=1678 ,top=178 ,right=1881 ,bottom=287 ,face='HY견명조' ,size=14 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{CURROW}', left=59, top=75, right=163, bottom=162, face='HY견명조', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='START_TIME', left=663, top=75, right=822, bottom=162 ,mask='XX:XX', face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='군사분계선 통과)' ,left=831 ,top=75 ,right=1356 ,bottom=162 ,align='left' ,face='HY견명조' ,size=16 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='방문인원 인적사항(' ,left=166 ,top=72 ,right=659 ,bottom=159 ,align='left' ,face='HY견명조' ,size=16 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=109 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=975 ,top=0 ,right=975 ,bottom=109 </L>
	<L> left=1078 ,top=0 ,right=1078 ,bottom=109 </L>
	<C>id='PRSN_NAME', left=766, top=6, right=966, bottom=103, face='HY견명조', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{CURROW}', left=59, top=6, right=163, bottom=103, face='HY견명조', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=344 ,top=0 ,right=344 ,bottom=109 </L>
	<C>id='P_CMPY', left=350, top=6, right=572, bottom=103, face='HY견명조', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PR_REGNO', left=1084, top=6, right=1331, bottom=103, face='HY견명조', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1338 ,top=0 ,right=1338 ,bottom=109 </L>
	<C>id='ADDRESS1', left=1347, top=6, right=1659, bottom=103, align='left', face='HY견명조', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1669 ,top=0 ,right=1669 ,bottom=109 </L>
	<L> left=53 ,top=109 ,right=1888 ,bottom=109 </L>
	<L> left=575 ,top=0 ,right=575 ,bottom=109 </L>
	<L> left=756 ,top=0 ,right=756 ,bottom=109 </L>
	<L> left=169 ,top=0 ,right=169 ,bottom=109 </L>
	<L> left=53 ,top=0 ,right=53 ,bottom=109 </L>
	<C>id='SEX', left=984, top=6, right=1075, bottom=103, face='HY견명조', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_DUTY', left=581, top=6, right=747, bottom=103, face='HY견명조', size=9,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RTRN_TIME', left=175, top=6, right=341, bottom=103, supplevel=1, face='Free 3 of 9 Regular', size=13,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1888 ,top=0 ,right=1888 ,bottom=109 </L>
	<C>id='START_D', left=1678, top=6, right=1881, bottom=103, face='HY견명조', size=9,   forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>


">
</object>
</OBJECT><%=HDConstant.COMMENT_END%> 

<%=HDConstant.COMMENT_START%>
<object id=gcrp_print09 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param NAME="DetailDataID"				VALUE="gcds_print07">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="false">
	<PARAM NAME="PrintSetupDlgFlag"		    VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<param name="MargineX"                        value="20">
	<param name="SuppressColumns"        	value="1:PageSkip,START_TIME">
	<PARAM NAME="Format"					VALUE="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=250 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='5. 방문차량' ,left=53 ,top=141 ,right=1888 ,bottom=244 ,align='left' ,face='HY견명조' ,size=20 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=297 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=53 ,top=169 ,right=1888 ,bottom=297 ,border=true</X>
	<L> left=1266 ,top=172 ,right=1266 ,bottom=297 </L>
	<L> left=684 ,top=169 ,right=684 ,bottom=294 </L>
	<L> left=294 ,top=169 ,right=294 ,bottom=294 </L>
	<L> left=1638 ,top=172 ,right=1638 ,bottom=297 </L>
	<T>id='표시번호' ,left=59 ,top=178 ,right=288 ,bottom=287 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량번호' ,left=694 ,top=178 ,right=1259 ,bottom=287 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차종' ,left=300 ,top=178 ,right=678 ,bottom=287 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='운전사' ,left=1275 ,top=178 ,right=1634 ,bottom=287 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='방문일' ,left=1647 ,top=178 ,right=1881 ,bottom=287 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='START_TIME', left=106, top=75, right=313, bottom=162 ,mask='XX:XX', face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='군사분계선 통과)' ,left=316 ,top=75 ,right=834 ,bottom=162 ,align='left' ,face='HY견명조' ,size=16 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(' ,left=72 ,top=75 ,right=103 ,bottom=162 ,align='left' ,face='HY견명조' ,size=16 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=110 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=53 ,top=109 ,right=1888 ,bottom=109 </L>
	<L> left=1884 ,top=0 ,right=1884 ,bottom=109 </L>
	<L> left=294 ,top=0 ,right=294 ,bottom=109 </L>
	<C>id='{CURROW}', left=59, top=6, right=288, bottom=103, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=684 ,top=0 ,right=684 ,bottom=109 </L>
	<C>id='CAR_NAME', left=300, top=6, right=678, bottom=103, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CAR_NO', left=694, top=6, right=1259, bottom=103, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1266 ,top=0 ,right=1266 ,bottom=109 </L>
	<C>id='PSN_KNAME', left=1275, top=6, right=1634, bottom=103, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1638 ,top=0 ,right=1638 ,bottom=109 </L>
	<C>id='START_D', left=1647, top=6, right=1881, bottom=103, face='굴림', size=10,   forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=53 ,top=0 ,right=53 ,bottom=109 </L>
</B>



">
</object>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<object id=gcrp_print10 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param NAME="DetailDataID"				VALUE="gcds_print06">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="false">
	<PARAM NAME="PrintSetupDlgFlag"		    VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<param name="MargineX"                        value="20">
	<PARAM NAME="Format"					VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2716 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=131 ,top=434 ,right=1831 ,bottom=1491 ,border=true</X>
	<T>id='6. 출입시간' ,left=131 ,top=216 ,right=1834 ,bottom=344 ,align='left' ,face='HY견명조' ,size=26 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1234 ,top=437 ,right=1234 ,bottom=1487 </L>
	<L> left=641 ,top=437 ,right=641 ,bottom=1487 </L>
	<T>id='목 적 지' ,left=141 ,top=1322 ,right=634 ,bottom=1481 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=131 ,top=1312 ,right=1828 ,bottom=1312 </L>
	<C>id='RT_DATE_TIME', left=1244, top=959, right=1822, bottom=1069, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RT_DATE_TIME2', left=1244, top=1078, right=1822, bottom=1187, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RT_DATE_TIME3', left=1244, top=1197, right=1822, bottom=1306, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='군사분계선 통과' ,left=141 ,top=962 ,right=634 ,bottom=1303 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구 분' ,left=141 ,top=447 ,right=634 ,bottom=587 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=644 ,top=1191 ,right=1828 ,bottom=1191 </L>
	<L> left=644 ,top=834 ,right=1828 ,bottom=834 </L>
	<L> left=644 ,top=1072 ,right=1828 ,bottom=1072 </L>
	<T>id='출입사무소 출발' ,left=141 ,top=600 ,right=634 ,bottom=941 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='남 -> 북' ,left=650 ,top=447 ,right=1228 ,bottom=587 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='북 -> 남' ,left=1244 ,top=447 ,right=1822 ,bottom=587 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=131 ,top=953 ,right=1828 ,bottom=953 </L>
	<L> left=644 ,top=716 ,right=1828 ,bottom=716 </L>
	<L> left=134 ,top=591 ,right=1828 ,bottom=591 </L>
	<T>id='개성공단 시범단지 내' ,left=650 ,top=1322 ,right=1228 ,bottom=1481 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='도 라 산 역' ,left=1244 ,top=1322 ,right=1822 ,bottom=1481 ,face='HY견명조' ,size=15 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ST_DATE_TIME3', left=650, top=1197, right=1228, bottom=1306, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ST_DATE_TIME2', left=650, top=1078, right=1228, bottom=1187, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ST_DATE_TIME', left=650, top=959, right=1228, bottom=1069, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='S_DATE_TIME3', left=647, top=841, right=1225, bottom=950, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='S_DATE_TIME', left=647, top=600, right=1225, bottom=709, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='S_DATE_TIME2', left=647, top=722, right=1225, bottom=831, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='R_DATE_TIME2', left=1244, top=722, right=1822, bottom=831, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='R_DATE_TIME', left=1244, top=600, right=1822, bottom=709, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='R_DATE_TIME3', left=1244, top=841, right=1822, bottom=950, face='HY견명조', size=15,   forecolor=#000000, backcolor=#FFFFFF</C>
</B>

">
</object>
<%=HDConstant.COMMENT_END%>

</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>
