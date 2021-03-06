<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  경리회계 - 결산관리-대차대조표
+ 프로그램 ID	:  A030009.html
+ 기 능 정 의	:  대차대조표 조회 및 출력 화면이다.
+ 작   성  자 :  이 순 미
+ 수 정 이 력 :  이 순 미(REPORT 수정)
+ 서 블 릿 명	:	 a030009_s1
-----------------------------------------------------------------------------
+ 수 정 내 용 :	환율적용   
+ 수   정  자 :
+ 수 정 일 자 :
-----------------------------------------------------------------------------
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>대차대조표</title>

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

var gs_date  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_date3 = gcurdate.substring(0,4);

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

	if(gclx_sfdcode2.bindcolval==""||gclx_sfdcode2.bindcolval=="03"){
		ln_Enable('t');
		if(gclx_sfdcode2.bindcolval=="") chkbox2.checked=true;
	}else{
		ln_Enable('f');
	}
}

/******************************************************************************
	Description : 조회시마다 잔액 관련 프로시저 실행
******************************************************************************/
function ln_up_Atcode_Create(){
	if (gcds_upatcode.countrow<1){
		var s_temp = "FDCODE:STRING";
		gcds_upatcode.SetDataHeader(s_temp);
	}
	gcds_upatcode.addrow();
	gcds_upatcode.namevalue(gcds_upatcode.rowposition,"FDCODE")="99";
	gctr_upatcode.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_upatcode_t2?";
	gctr_upatcode.post();																 
	gcds_upatcode.ClearAll();
}

/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(s){
	//ln_up_Atcode_Create();

	//alert("s:::"+s);
	if(s=="01") {  //관리
		var str1 = gclx_sfdcode.bindcolval;
		var str2 = gcem_staxdatfr.text;
        var strmm = str2.substring(4,6);
		var str3 = Number(str2.substring(0,4)-1);
			str3 = str3+strmm;
		var str4 = "";
		var str5 = "";
	
	  if(chkbox.checked==false){    // 원화 미적용
			if(chkbox_md.checked==true){//수정분개 포함
				gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030009_s22?v_str1="+str1
																															+ "&v_str2="+str3 
																															+ "&v_str3="+str2 
																															+ "&v_str4="+str4 
																															+ "&v_str5="+str5; 
				//prompt('a030009_s22',gcds_data1.DataID);																											      
				gcds_data1.Reset();
			}else{ //수정분개 미포함
				gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030009_s22_n?v_str1="+str1
																															+ "&v_str2="+str3 
																															+ "&v_str3="+str2 
																															+ "&v_str4="+str4 
																															+ "&v_str5="+str5; 
                //prompt('a030009_s22_n',gcds_data1.DataID);						
				gcds_data1.Reset();
			}

			gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
			gcds_staxdatki.Reset(); //기수

		}else{  // 원화 적용
			if(gclx_sfdcode.bindcolval==""){         //전체 항상 원화로 조회됨.
				if(chkbox_md.checked==true){  //수정분개포함
					gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030009_s23?v_str1="+str1
																																+ "&v_str2="+str3 
																																+ "&v_str3="+str2 
																																+ "&v_str4="+str4 
																																+ "&v_str5="+str5
																																+ "&v_str6=A";
					//prompt("a030009_s23",gcds_data1.DataID);
					gcds_data1.Reset();
				}else{ //수정분개 미포함
					gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030009_s23_n?v_str1="+str1
																																+ "&v_str2="+str3 
																																+ "&v_str3="+str2 
																																+ "&v_str4="+str4 
																																+ "&v_str5="+str5
																																+ "&v_str6=A";
					//prompt("a030009_s23_n",gcds_data1.DataID);
					gcds_data1.Reset();
				}

				gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
			    gcds_staxdatki.Reset(); //기수
			}else if(gclx_sfdcode.bindcolval=="03"){ //금강산(원화로 조회)
				if(chkbox_md.checked==true){ //수정분개포함
					gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030009_s23?v_str1="+str1
																																+ "&v_str2="+str3 
																																+ "&v_str3="+str2 
																																+ "&v_str4="+str4 
																																+ "&v_str5="+str5
																																+ "&v_str6=K";
					//prompt("a030009_s23",gcds_data2.DataID);
					gcds_data1.Reset();
				}else{ //수정분개 미포함
					gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030009_s23_n?v_str1="+str1
																																+ "&v_str2="+str3 
																																+ "&v_str3="+str2 
																																+ "&v_str4="+str4 
																																+ "&v_str5="+str5
																																+ "&v_str6=K";
					//prompt("a030009_s23_n",gcds_data2.DataID);
					gcds_data1.Reset();
				}
				gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
			  gcds_staxdatki.Reset(); //기수
			}
  	}
	}else if(s=="02") {  //기업회계기준
		var str1 = gclx_sfdcode2.bindcolval;
		var str2 = gcem_staxdatfr2.text;
        var strmm = str2.substring(4,6);
		var str3 = Number(str2.substring(0,4)-1);
			 str3 = str3+strmm;
		var str4 = "";//gclx_cocode.bindcolval;
		var str5 = gclx_rdept.bindcolval;
	
	  if(chkbox2.checked==false){    // 원화 미적용
			if(chkbox_md2.checked==true){//수정분개 포함
				gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030009_s2?v_str1="+str1
																															+ "&v_str2="+str3 
																															+ "&v_str3="+str2 
																															+ "&v_str4="+str4 
																															+ "&v_str5="+str5; 
                //alert("a030009_s2");
				gcds_data2.Reset();
			}else{ //수정분개 미포함
				gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030009_s2_n?v_str1="+str1
																															+ "&v_str2="+str3 
																															+ "&v_str3="+str2 
																															+ "&v_str4="+str4 
																															+ "&v_str5="+str5; 
                //alert("a030009_s2_n");
				gcds_data2.Reset();
			}

			gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
			gcds_staxdatki.Reset(); //기수

		}else{  // 원화 적용
			if(gclx_sfdcode2.bindcolval==""){         //전체 항상 원화로 조회됨.
				if(chkbox_md2.checked==true){  //수정분개포함
					gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030009_s3?v_str1="+str1
																																+ "&v_str2="+str3 
																																+ "&v_str3="+str2 
																																+ "&v_str4="+str4 
																																+ "&v_str5="+str5
																																+ "&v_str6=A";
        
					//prompt("a030009_s3",gcds_data1.DataID);
					gcds_data2.Reset();
				}else{ //수정분개 미포함
					gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030009_s3_n?v_str1="+str1
																																+ "&v_str2="+str3 
																																+ "&v_str3="+str2 
																																+ "&v_str4="+str4 
																																+ "&v_str5="+str5
																																+ "&v_str6=A";
                    //prompt('a030009_s3_n',gcds_data2.DataID );
					gcds_data2.Reset();
				}

				gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
			  gcds_staxdatki.Reset(); //기수
			}else if(gclx_sfdcode2.bindcolval=="03"){ //금강산(원화로 조회)
				if(chkbox_md2.checked==true){ //수정분개포함
					gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030009_s3?v_str1="+str1
																																+ "&v_str2="+str3 
																																+ "&v_str3="+str2 
																																+ "&v_str4="+str4 
																																+ "&v_str5="+str5
																																+ "&v_str6=K";
					//prompt("a030009_s3",gcds_data2.DataID);
					gcds_data2.Reset();
				}else{ //수정분개 미포함
					gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030009_s3_n?v_str1="+str1
																																+ "&v_str2="+str3 
																																+ "&v_str3="+str2 
																																+ "&v_str4="+str4 
																																+ "&v_str5="+str5
																																+ "&v_str6=K";
					//prompt("a030009_s3_n",gcds_data2.DataID);
					gcds_data2.Reset();
				}
				gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
			    gcds_staxdatki.Reset(); //기수
			}
  	}
  }
}

/*****************************************************************************************
	Description : 대차대조표 관리 계산식
*****************************************************************************************/
function ln_ManCalCu(){
	var cnt  = gcds_data1.countrow;
	var str1 = gclx_sfdcode.BindColVal;		//지점코드
	var str2 = gcem_staxdatfr.text;				//회계년월(당기)
	
	var str4 = "" //gclx_cocode.BindColVal;			//사업소
	var str5 = "" //gclx_rdept.BindColVal;				//본부
	var str6 = Number(str2.substring(0,4)-1)+str2.substring(4,6);		//회계년월(전기)
	var strto1 = str2.substring(0,4) + "00"; 
	var strto2 = str6.substring(0,4) + "00"; 

	var md_gubun ="";
	var won_gubun="";
	if(chkbox.checked==false) won_gubun="N";
	else won_gubun="Y";
	if(chkbox_md.checked==true) md_gubun = "Y";  
	else  md_gubun = "N";  

	for(var i=1;i<=cnt;i++) {	//(당)기
		if (gcds_data1.namevalue(i,"RCOM") != null && gcds_data1.namevalue(i,"RCOM") != "") {
			var rtemp = gcds_data1.namevalue(i,"RCOM");				  //우변 계산식
			gf_array_val(gcds_name,str1,str2,str4,str5,rtemp,strto1,md_gubun,won_gubun);
			var rs_amt = gcds_name2.namevalue(1,"TOTALVALUE");
			if (rs_amt == null || rs_amt == "NaN") rs_amt = 0;
			gcds_data1.namevalue(i,"RTTOT") = rs_amt;
		}
		
		if(gcds_data1.namevalue(i,"LCOM") != null && gcds_data1.namevalue(i,"LCOM") != ""){
		   //alert("LCOM::"+gcds_data2.namevalue(i,"LCOM"));
			var ltemp = gcds_data1.namevalue(i,"LCOM");				  //좌변 계산식
			gf_array_val(gcds_name,str1,str2,str4,str5,ltemp,strto1,md_gubun,won_gubun);
			var ls_amt = gcds_name2.namevalue(1,"TOTALVALUE");

			if (ls_amt == null || ls_amt == "NaN") ls_amt = 0;
			gcds_data1.namevalue(i,"LTTOT") = ls_amt;
		}
	}

	for(var i=1;i<=cnt;i++) {	//(전)기
	  /*
		if (gcds_data1.namevalue(i,"COM2") != null && gcds_data1.namevalue(i,"COM2") != "") {
			var temp = gcds_data1.namevalue(i,"COM2");				//좌변,우변 계산식
			gf_array_val(gcds_name,str1,str6,str4,str5,temp,strto2,md_gubun,won_gubun);
			var s_amt = gcds_name2.namevalue(1,"TOTALVALUE");
			if (s_amt == null || s_amt == "NaN") s_amt = 0;
			gcds_data1.namevalue(i,"RTTOT2") = s_amt;
		}
		*/
		if (gcds_data1.namevalue(i,"RCOM2") != null && gcds_data1.namevalue(i,"RCOM2") != "") {
			var temp = gcds_data1.namevalue(i,"RCOM2");				//우변 계산식
			gf_array_val(gcds_name,str1,str6,str4,str5,temp,strto2,md_gubun,won_gubun);
			var s_amt = gcds_name2.namevalue(1,"TOTALVALUE");
			if (s_amt == null || s_amt == "NaN") s_amt = 0;
			gcds_data1.namevalue(i,"RTTOT2") = s_amt;
		}

			if(gcds_data1.namevalue(i,"LCOM2") != null && gcds_data1.namevalue(i,"LCOM2") != ""){
		   //alert("LCOM::"+gcds_data2.namevalue(i,"LCOM"));
			var ltemp = gcds_data1.namevalue(i,"LCOM2");				  //좌변 계산식
			gf_array_val(gcds_name,str1,str6,str4,str5,ltemp,strto2,md_gubun,won_gubun);
			var ls_amt = gcds_name2.namevalue(1,"TOTALVALUE");

			if (ls_amt == null || ls_amt == "NaN") ls_amt = 0;
			gcds_data1.namevalue(i,"LTTOT2") = ls_amt;
		}
	}
}


/*****************************************************************************************
	Description : 대차대조표 기업 계산식
*****************************************************************************************/
function ln_ManCalCu2(){
	var cnt  = gcds_data2.countrow;
	var str1 = gclx_sfdcode2.BindColVal;		//지점코드
	var str2 = gcem_staxdatfr2.text;				//회계년월(당기)
	
	var str4 = "";//gclx_cocode.BindColVal;			//사업소
	var str5 = gclx_rdept.BindColVal;				//본부
	var str6 = Number(str2.substring(0,4)-1)+str2.substring(4,6);		//회계년월(전기)
	var strto1 = str2.substring(0,4) + "00"; 
	var strto2 = str6.substring(0,4) + "00"; 

	var md_gubun ="";
	var won_gubun="";
	if(chkbox2.checked==false) won_gubun="N";
	else won_gubun="Y";
	if(chkbox_md2.checked==true) md_gubun = "Y";  
	else  md_gubun = "N";  

	for(var i=1;i<=cnt;i++) {	//(당)기
		if (gcds_data2.namevalue(i,"RCOM") != null && gcds_data2.namevalue(i,"RCOM") != "") {
			var rtemp = gcds_data2.namevalue(i,"RCOM");				  //우변 계산식
			gf_array_val(gcds_name,str1,str2,str4,str5,rtemp,strto1,md_gubun,won_gubun);
			var rs_amt = gcds_name2.namevalue(1,"TOTALVALUE");
			if (rs_amt == null || rs_amt == "NaN") rs_amt = 0;
			gcds_data2.namevalue(i,"RTTOT") = rs_amt;
		}
		
		if(gcds_data2.namevalue(i,"LCOM") != null && gcds_data2.namevalue(i,"LCOM") != ""){
		  //alert("LCOM::"+gcds_data2.namevalue(i,"LCOM"));
			var ltemp = gcds_data2.namevalue(i,"LCOM");				  //좌변 계산식
			gf_array_val(gcds_name,str1,str2,str4,str5,ltemp,strto1,md_gubun,won_gubun);
			var ls_amt = gcds_name2.namevalue(1,"TOTALVALUE");
			if (ls_amt == null || ls_amt == "NaN") ls_amt = 0;
			gcds_data2.namevalue(i,"LTTOT") = ls_amt;
		}
	}

	for(var i=1;i<=cnt;i++) {	//(전)기
	  /*
		if (gcds_data2.namevalue(i,"COM2") != null && gcds_data2.namevalue(i,"COM2") != "") {
			var temp = gcds_data2.namevalue(i,"COM2");				//좌변,우변 계산식
			gf_array_val(gcds_name,str1,str6,str4,str5,temp,strto2,md_gubun,won_gubun);
			var s_amt = gcds_name2.namevalue(1,"TOTALVALUE");
			if (s_amt == null || s_amt == "NaN") s_amt = 0;
			gcds_data2.namevalue(i,"RTTOT2") = s_amt;
		}
		*/

		if (gcds_data2.namevalue(i,"RCOM2") != null && gcds_data2.namevalue(i,"RCOM2") != "") {
			var temp = gcds_data2.namevalue(i,"RCOM2");				//우변 계산식
			gf_array_val(gcds_name,str1,str6,str4,str5,temp,strto2,md_gubun,won_gubun);
			var s_amt = gcds_name2.namevalue(1,"TOTALVALUE");
			if (s_amt == null || s_amt == "NaN") s_amt = 0;
			gcds_data2.namevalue(i,"RTTOT2") = s_amt;
		}

		if(gcds_data2.namevalue(i,"LCOM2") != null && gcds_data2.namevalue(i,"LCOM2") != ""){
			var ltemp = gcds_data2.namevalue(i,"LCOM2");				  //좌변 계산식
			gf_array_val(gcds_name,str1,str6,str4,str5,ltemp,strto2,md_gubun,won_gubun);
			var ls_amt = gcds_name2.namevalue(1,"TOTALVALUE");
			if (ls_amt == null || ls_amt == "NaN") ls_amt = 0;
			gcds_data2.namevalue(i,"LTTOT2") = ls_amt;
		}
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

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(e){
	if(e=="01") { 	
	}	else if(e=="02"){
		ln_PrintHeader();

		//날짜 및 시간 쿼리
		gcds_datetime.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_datetime_s1?"
		gcds_datetime.Reset();
    
		gcds_time.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030009_s4"; 	
		gcds_time.Reset();
		
		for(i=1;i<=gcds_data2.countrow;i++){
			gcds_print.ImportData(gcds_data2.ExportData(i,1,false));
			var strto		= gcem_staxdatfr2.text+"01";	//to
			var strto1	= shiftTime(strto,0,1,-1);		//8기
			var strto2	= shiftTime(strto,-1,1,-1);		//7기
			var ki			= gcds_staxdatki.namevalue(1,"CDCODE");
			var ki1			= Number(gcem_staxdatfr2.text.substring(0,4))-Number(ki)+1;
			var ki2			= Number(gcem_staxdatfr2.text.substring(0,4))-1-Number(ki)+1;
			gcds_print.namevalue(i,"KISU1")	   = "제"+ki1+"기 : "+strto1.substring(0,4)+"년 "+strto1.substring(4,6)+"월 "+strto1.substring(6,8)+"일 현재";
			gcds_print.namevalue(i,"KISU2")	   = "제"+ki2+"기 : "+strto2.substring(0,4)+"년 "+strto2.substring(4,6)+"월 "+strto2.substring(6,8)+"일 현재";
			gcds_print.namevalue(i,"CURKISU")  = String(Number(gcem_staxdatfr2.text.substring(0,4))-Number(ki)+1);		//8기
			gcds_print.namevalue(i,"PREKISU")  = String(Number(gcem_staxdatfr2.text.substring(0,4))-1-Number(ki)+1);	//7기
			gcds_print.namevalue(i,"FDCODENM") = "지점 : "+gcds_sfdcode2.NameValue(gcds_sfdcode2.rowposition,"FDNAME");
			gcds_print.namevalue(i,"CURDT")	   = gs_date;
			gcds_print.namevalue(i,"CURTM") = gcds_time.namevalue(1,"curtime");
		}
		gcrp_print1.preview();
	}
}

/******************************************************************************
	Description : 출력 - Header Set
******************************************************************************/
function ln_PrintHeader() {
	/** 2012.10.31 jys 수정
	var Theader = "ATCODE:STRING,PRTNAM:STRING,LTTOT:DECIMAL,RTTOT:DECIMAL,COM:STRING,"
							+ "READ:STRING,LTTOT2:DECIMAL,RTTOT2:DECIMAL,COM2:STRING,READ2:STRING,"
							+ "KISU1:STRING,KISU2:STRING,CURKISU:STRING,PREKISU:STRING,FDCODENM:STRING,"
							+ "CURDT:STRING,CURTM:STRING";
	gcds_print.SetDataHeader(Theader);
	**/
	var Theader = "ATCODE:STRING,PRTNAM:STRING,LTTOT:DECIMAL,RTTOT:DECIMAL,LCOM:STRING,RCOM:STRING,"
							+ "READ:STRING,LTTOT2:DECIMAL,RTTOT2:DECIMAL,LCOM2:STRING,RCOM2:STRING,READ2:STRING,"
							+ "KISU1:STRING,KISU2:STRING,CURKISU:STRING,PREKISU:STRING,FDCODENM:STRING,"
							+ "CURDT:STRING,CURTM:STRING";
	gcds_print.SetDataHeader(Theader);
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(e){
	if(e=="01") {
	//	gcgd_disp01.runexcel("대차대조표 관리");
gcgd_disp01.GridToExcel("대차대조표 관리","",2);
	}else if(e=="02") {
	//	gcgd_disp02.runexcel("대차대조표 기업");
gcgd_disp02.GridToExcel("대차대조표 기업","",2);
	}
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
	gcem_staxdatfr.text = gs_date2;
	gcem_staxdatfr2.text = gs_date2;

	//기준-지점코드[검색]
	gcds_sfdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset();

	//관리-지점코드[검색]
	gcds_sfdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode2.Reset();

	//관리-사업소
	gcds_cocode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>company_s1?v_str1=";
	gcds_cocode.Reset(); 

	//관리-본부
	gcds_rdept.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdeptprt_s1?v_str1=";
	gcds_rdept.Reset(); 

	gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
	gcds_staxdatki.Reset(); //기수
}

/******************************************************************************
	Description : 탭구분
	prameter    : 0-기업회계기준, 1-관리
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
	Description : 계정별 Set
******************************************************************************/
function ln_DataSet(){

	var ls_temp1 = "PRTACT:STRING,PRTNAM:STRING,PRTSEQ:STRING,DECRTOT:DECIAML"
	var ls_temp2 = "PRTACT2:STRING,PRTNAM2:STRING,PRTSEQ2:STRING,DECRTOT2:DECIAML";
	var ls_temp3 = "PRTACT:STRING,PRTNAM:STRING,PRTSEQ:STRING,DECRTOT:DECIAML,"
							 + "PRTACT2:STRING,PRTNAM2:STRING,PRTSEQ2:STRING,DECRTOT2:DECIAML";
	gcds_temp1.SetDataHeader(ls_temp1);
	gcds_temp2.SetDataHeader(ls_temp2);
	gcds_temp3.SetDataHeader(ls_temp3);

	var decnt = 0;
	var crcnt = 0;
	for(var i=1;i<=gcds_data1.CountRow;i++){
	  alert("i:"+i+":PRTACT:"+gcds_data1.namevalue(i,"PRTACT"));
		var s_prtact = gcds_data1.namevalue(i,"PRTACT");
		if(s_prtact.substring(0,1) == "1") {	
			decnt++;	//자산
		}else if (s_prtact.substring(0,1) == "2" || s_prtact.substring(0,1) == "3") {	
			crcnt++;	//부채 & 자본
		}
	}

	gcds_temp1.ImportData(gcds_data1.ExportData(1, decnt, true));
	gcds_temp3.ImportData(gcds_data1.ExportData(1, decnt, true));
	gcds_temp2.ImportData(gcds_data1.ExportData(Number(decnt+1), crcnt, true));
	
	for(var p2=1;p2<=crcnt;p2++) {
		gcds_temp3.namevalue(p2,"PRTACT2")  =  gcds_temp2.namevalue(p2,"PRTACT2");
		gcds_temp3.namevalue(p2,"PRTNAM2")  =  gcds_temp2.namevalue(p2,"PRTNAM2");
		gcds_temp3.namevalue(p2,"PRTSEQ2")  =  gcds_temp2.namevalue(p2,"PRTSEQ2");
		gcds_temp3.namevalue(p2,"DECRTOT2") =  gcds_temp2.namevalue(p2,"DECRTOT2");
	}
	
	ft_cnt01.innerText = "조회건수 : " + decnt + " 건";
	ft_cnt02.innerText = "조회건수 : " + crcnt + " 건";
}

/******************************************************************************
	Description : 날짜계산
	prameter    : 
******************************************************************************/

/**
 * Time 스트링을 자바스크립트 Date 객체로 변환
 * parameter time: Time 형식의 String
 */
function toTimeObject(time) { //parseTime(time)
    var year  = time.substr(0,4);
    var month = time.substr(4,2) - 1; // 1월=0,12월=11
    var day   = time.substr(6,2);
    return new Date(year,month,day);
}

/**
 * 자바스크립트 Date 객체를 Time 스트링으로 변환
 * parameter date: JavaScript Date Object
 */
function toTimeString(date) { //formatTime(date)
    var year  = date.getFullYear();
    var month = date.getMonth() + 1; // 1월=0,12월=11이므로 1 더함
    var day   = date.getDate();

    if (("" + month).length == 1) { month = "0" + month; }
    if (("" + day).length   == 1) { day   = "0" + day;   }

    return ("" + year + month + day);
}

/**
 * 주어진 Time 과 y년 m월 d일 차이나는 Time을 리턴
 *
 * ex) var time = form.time.value; //'20000101'
 *     alert(shiftTime(time,0,0,-100));
 *     => 2000/01/01 으로부터 100일 전 Time
 *
 * http://www.oramaster.net
 */
function shiftTime(time,y,m,d) { //moveTime(time,y,m,d)
    var date = toTimeObject(time);

    date.setFullYear(date.getFullYear() + y); //y년을 더함
    date.setMonth(date.getMonth() + m);       //m월을 더함
    date.setDate(date.getDate() + d);         //d일을 더함

    return toTimeString(date);
}



function ln_Enable(p){
	if(p=="t"){
		chkbox2.disabled=false;
	}else if(p=="f"){
	  chkbox2.disabled=true;
		chkbox2.checked=false;
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"		VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_cocode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_rdept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_name classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_name2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_upatcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 상위잔액관련 프로시저 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_staxdatki" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 기수 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_print" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_time" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_datetime classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 출력날짜 시간 -->
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- 상위잔액관련 프로시저 -->
<comment id="__NSID__"><object  id=gctr_upatcode classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name=TimeOut       value=2400000>
	<param name="keyvalue"    value="comm_upatcode_t1(I:USER=gcds_upatcode)">   
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
	document.all.LowerFrame.style.visibility="hidden";

	ft_cnt01.innerText = "조회건수 : " + row + " 건";

	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
		//ln_DataSet();
		ln_ManCalCu()
	}
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt03.innerText = "조회건수 : " + row + " 건";

	if (row<1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
		ln_ManCalCu2();	//대차대조표관리 계산식
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1)); /*기업회계기준*/
</script>

<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	gcds_sfdcode.InsertRow(1);
	gcds_sfdcode.NameValue(1,"FDCODE")="";
	gcds_sfdcode.NameValue(1,"FDNAME")="전체";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode.index=2;
	}else{
		gclx_sfdcode.bindcolval=gs_fdcode;
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


<!-- <script language="javascript" for="gcds_cocode" event="onloadCompleted(row,colid)">
	gcds_cocode.InsertRow(1);
	gcds_cocode.NameValue(1,"COCODE")="";
	gcds_cocode.NameValue(1,"CONAME")="전체";
	gclx_cocode.index=1;
</script> -->

<script language="javascript" for="gcds_rdept" event="onloadCompleted(row,colid)">
	gcds_rdept.InsertRow(1);
	gcds_rdept.NameValue(1,"DEPTCD")="";
	gcds_rdept.NameValue(1,"DEPTNM")="전체";
	gclx_rdept.index=0;
</script>

<script language="javascript" for="gcds_staxdatki" event="onloadCompleted(row,colid)">
	var ki = gcds_staxdatki.namevalue(1,"CDCODE");
	var ki1 = Number(gcem_staxdatfr2.text.substring(0,4))-Number(ki)+1+"";//8기
	var ki2 = Number(gcem_staxdatfr2.text.substring(0,4))-1-Number(ki)+1+"";//7기
	gcgd_disp02.ColumnProp('GUBUN1','NAME') = "제 " + ki1 + "(당)기";
	gcgd_disp02.ColumnProp('GUBUN2','NAME') = "제 " + ki2 + "(전)기";
	gcgd_disp01.ColumnProp('GUBUN1','NAME') = "제 " + ki1 + "(당)기";
	gcgd_disp01.ColumnProp('GUBUN2','NAME') = "제 " + ki2 + "(전)기";
</script>


<script language=JavaScript for=gclx_sfdcode2 event=OnSelChange()>
	
	if(gclx_sfdcode2.bindcolval==""||gclx_sfdcode2.bindcolval=="03"){
		ln_Enable('t');
		if(gclx_sfdcode2.bindcolval=="") chkbox2.checked=true;
	}else{
		ln_Enable('f');
	}

</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_upatcode event=OnFail()>

alert("Error Code : " + gctr_upatcode.ErrorCode + "\n" + "Error Message : " + gctr_upatcode.ErrorMsg + "\n");

</script>
 
</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030009_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr>
					<td width="0" align=right>
						<comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;">
							<PARAM NAME="BackColor"					VALUE="#cccccc">
   					  <PARAM NAME="titleHeight"				VALUE="20px">
						  <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
						  <PARAM NAME="Format"						VALUE="
								<T>divid=div_1		title='  기업회계기준'</T>
								<T>divid=div_2		title='  관    리  '</T>									
						  ">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!-- 관리  ===========================================================================================================-->
<fieldset id=field1 style="position:absolute;;top:160px;left:18px;height:485px;width:878px;bacground-color:#708090"></fieldset>
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr><td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab12" style="height:25px;width:80px;" bgcolor="#eeeeee">지점코드</td>
				<td class="tab12" style="width:80px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  
					   style="position:relative;left:5px;top:2px;width:120px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab12" style="height:25px;width:80px;" bgcolor="#eeeeee">년&nbsp;&nbsp;&nbsp;월</td>
				<td class="tab23" width="80px">
					<comment id="__NSID__"><object  id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</nobr>
				</td>

				<td width="50px" class="tab12" bgcolor="#eeeeee"><nobr>수정분개</nobr></td>
				<td width="35px" class="tab23" ><nobr>&nbsp;
					<input type=checkbox  id=chkbox_md  style=width:15px;position:relative;left:-4px;top:-1px;>
				</nobr>	
				</td>

				<td width="50px" class="tab12" bgcolor="#eeeeee"><nobr>원&nbsp;화</nobr></td>
				<td width="15px"><nobr>&nbsp;
					<input type=checkbox  id=chkbox  style=width:15px;position:relative;left:-4px;top:-1px;>
				</nobr>	
				</td>

				<td width="300px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>&nbsp;</td>
				<td width="200px"  align=right colspan="3">
					<img src="../../Common/img/btn/com_b_print.gif"	style="position:relative;right:-1px;top:2px;cursor:hand" onClick="ln_Print('01')">
					<img src="../../Common/img/btn/com_b_excel.gif"	style="position:relative;right:1px;top:2px;cursor:hand" onClick="ln_Excel('01')">
					<img src="../../Common/img/btn/com_b_query.gif" style="position:relative;right:4px;top:2px;cursor:hand" onclick="ln_Query('01')">
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
				<td style="width:280" ALIGN=LEFT VALIGN=TOP><nobr>
					<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  
						style="position:relative;left:8px;width:864px; height:419px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data1">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
              <param name="Editable"    value="false">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='계정코드'	ID=ATCODE HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center sort=false show=false</C> 
								<C> Name='계정과목'	ID=PRTNAM HeadAlign=Center HeadBgColor=#B9D4DC Width=148 align=left sort=false</C> 
								<G> Name='제 (당)기'	ID=GUBUN1 HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='금액'	ID=LTTOT  HeadAlign=Center HeadBgColor=#B9D4DC Width=175 align=right</C>
									<C> Name='금액'	ID=RTTOT  HeadAlign=Center HeadBgColor=#B9D4DC Width=175 align=right</C> 
								</G>
								<G> Name='제 (전)기'	ID=GUBUN2 HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='금액'	ID=LTTOT2 HeadAlign=Center HeadBgColor=#B9D4DC Width=175 align=right</C> 
									<C> Name='금액'	ID=RTTOT2 HeadAlign=Center HeadBgColor=#B9D4DC Width=175 align=right</C> 
								</G>
							">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
					</fieldset>
					</td>
				</tr>
			</table>
		</td> 
	</tr> 
</table> 

<!-- 기업회계기준 ===========================================================================================================-->
<fieldset id=field2 style="position:absolute;;top:160px;left:18px;height:485px;width:878px;bacground-color:#708090"></fieldset>
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr> 				
				<td class="tab12" style="height:25px;width:60px;" bgcolor="#eeeeee">지점코드</td>
				<td class="tab12" style="width:80px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:80px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode2">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="FDNAME^0^60">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab12" style="height:25px;width:40px;" bgcolor="#eeeeee">년&nbsp월</td>
				<td class="tab23" width="80px">
					<comment id="__NSID__"><object  id=gcem_staxdatfr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</nobr>
				</td>
				<!-- <td class="tab12" style="height:25px;width:40px;" bgcolor="#eeeeee">사업소</td>
				<td class="tab23" width="80px"><nobr>
					<comment id="__NSID__"><object  id=gclx_cocode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:70px;height:110px;">
						<param name=ComboDataID			value="gcds_cocode">
						<param name=CBDataColumns		value="COCODE,CONAME">
						<param name=SearchColumn		value="CONAME">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CONAME^0^60">
						<param name=BindColumn			value="COCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td> -->
				<td class="tab12" style="height:25px;width:40px;" bgcolor="#eeeeee">본&nbsp;부</td>
				<td class="tab23" width="80px"><nobr>
					<comment id="__NSID__"><object  id=gclx_rdept classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:105px;height:150px;">
						<param name=ComboDataID			value="gcds_rdept">
						<param name=CBDataColumns		value="DEPTCD,DEPTNM">
						<param name=SearchColumn		value="DEPTNM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="DEPTNM^0^90">
						<param name=BindColumn			value="DEPTCD">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>

				<td width="50px" class="tab12" bgcolor="#eeeeee"><nobr>수정분개</nobr></td>
				<td width="35px" class="tab23" ><nobr>&nbsp;
					<input type=checkbox  id=chkbox_md2  style=width:15px;position:relative;left:-4px;top:-1px;>
				</nobr>	
				</td>

				<td width="50px" class="tab12" bgcolor="#eeeeee"><nobr>원&nbsp;화</nobr></td>
				<td width="15px"><nobr>&nbsp;
					<input type=checkbox  id=chkbox2  style=width:15px;position:relative;left:-4px;top:-1px;>
				</nobr>	
				</td>
				
				<td align="right"  colspan="3">
					<img src="../../Common/img/btn/com_b_print.gif"	style="position:relative;right:-7px;top:2px;cursor:hand" onClick="ln_Print('02')">
					<img src="../../Common/img/btn/com_b_excel.gif"	style="position:relative;right:-5px;top:2px;cursor:hand" onClick="ln_Excel('02')">
					<img src="../../Common/img/btn/com_b_query.gif" style="position:relative;right:-2px;top:2px;cursor:hand" onclick="ln_Query('02')">&nbsp;
				</td>
			</tr>
		</table>
	</td>
	</tr>
	<tr><td height="2px" colspan =2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  id=gcgd_disp02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  
						style="position:relative;left:8px;width:864px; height:419px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data2">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
              <param name="Editable"    value="false">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='계정코드'	ID=ATCODE HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center sort=false show=false</C> 
								<C> Name='계정과목'	ID=PRTNAM HeadAlign=Center HeadBgColor=#B9D4DC Width=148 align=left sort=false</C> 
								<G> Name='제 (당)기'	ID=GUBUN1 HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='금액'	ID=LTTOT  HeadAlign=Center HeadBgColor=#B9D4DC Width=175 align=right</C>
									<C> Name='금액'	ID=RTTOT  HeadAlign=Center HeadBgColor=#B9D4DC Width=175 align=right</C> 
								</G>
								<G> Name='제 (전)기'	ID=GUBUN2 HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='금액'	ID=LTTOT2 HeadAlign=Center HeadBgColor=#B9D4DC Width=175 align=right</C> 
									<C> Name='금액'	ID=RTTOT2 HeadAlign=Center HeadBgColor=#B9D4DC Width=175 align=right</C> 
								</G>
							">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;"></font>
					</fieldset>
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

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_datetime">
	<param name="DetailDataID"			value="gcds_print">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="printMargine"			value="false">
	<param name="LandScape"					value="false">
  <param name="PrintSetupDlgFlag" value="true">
	<param name="Format"						value="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=489 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='대 차 대 조 표' ,left=614 ,top=101 ,right=1437 ,bottom=161 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='KISU1', left=590, top=196, right=1468, bottom=246, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='KISU2', left=590, top=243, right=1468, bottom=294, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=71 ,top=333 ,right=1942 ,bottom=333 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURKISU', left=640, top=347, right=1201, bottom=413 ,mask='제 XX (당)기', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='PREKISU', left=1344, top=347, right=1902, bottom=413 ,mask='제 XX (전)기', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='FDCODENM', left=71, top=288, right=357, bottom=331, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Page :#p of #t' ,left=1508 ,top=288 ,right=1931 ,bottom=331 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=74 ,top=487 ,right=1942 ,bottom=487 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=564 ,top=418 ,right=1942 ,bottom=418 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='계정과목' ,left=82 ,top=347 ,right=553 ,bottom=482 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=71 ,top=333 ,right=71 ,bottom=487 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=564 ,top=333 ,right=564 ,bottom=487 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1249 ,top=333 ,right=1249 ,bottom=489 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='금액' ,left=1344 ,top=431 ,right=1894 ,bottom=479 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금액' ,left=640 ,top=431 ,right=1201 ,bottom=479 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1942 ,top=333 ,right=1942 ,bottom=487 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=53 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='{decode(RTTOT,0,,RTTOT)}', left=918, top=0, right=1244, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LTTOT,0,,LTTOT)}', left=572, top=0, right=902, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LTTOT2,0,,LTTOT2)}', left=1259, top=3, right=1588, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PRTNAM', left=85, top=5, right=553, bottom=45, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=71 ,top=0 ,right=71 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=564 ,top=0 ,right=564 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=910 ,top=0 ,right=910 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1598 ,top=0 ,right=1598 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=0 ,right=1942 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1249 ,top=0 ,right=1249 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{decode(RTTOT2,0,,RTTOT2)}', left=1606, top=0, right=1931, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=1558 ,top=3 ,right=1937 ,bottom=85</I>
	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TIMES', left=455, top=3, right=614, bottom=69, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATES', left=243, top=3, right=450, bottom=69, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='출력일시 :' ,left=71 ,top=3 ,right=238 ,bottom=69 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 