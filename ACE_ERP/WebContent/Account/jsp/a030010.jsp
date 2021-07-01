<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  결산관리-손익계산서
+ 프로그램 ID	:  A030010.html
+ 기 능 정 의	:  손익계산서 조회 및 출력 화면이다.
+ 작   성  자 :  구 자 헌
+ 수 정 이 력 :  이 순 미(REPORT 수정)
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 손익계산서 확인작업   
+ 수   정  자 :  ys.jeong
+ 수 정 일 자 :  2006.08.19 
-----------------------------------------------------------------------------
+ 서 블 릿 명	:	 a030010_s1, a030010_s2
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>손익계산서</title>

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
}

/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(s){

	if(s=="02") { //기업회계
		var str1 = gclx_sfdcode2.bindcolval; //지점코드
		var str2 = gcem_staxdatfr2.text; //년월from
		var str3 = gcem_staxdatto2.text; //년월to
		//var str4 = gclx_cocode.bindcolval; //사업소
		var str4 =""; //사업소
		var str5 = gclx_rdept.bindcolval; //본부

    	if(chkbox2.checked==false){  //원화미적용
			if(chkbox_md2.checked==true){//수정분개 포함
				gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s2?v_str1="+str1
													+ "&v_str2="+str2 + "&v_str3="+str3 + "&v_str4="+str4 + "&v_str5="+str5; 
				gcds_data2.Reset();
			}else{ //수정분개 미포함
				gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s2_n?v_str1="+str1
													+ "&v_str2="+str2 + "&v_str3="+str3 + "&v_str4="+str4 + "&v_str5="+str5; 
				gcds_data2.Reset();
			}
			gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
			gcds_staxdatki.Reset(); //기수
		}else{
			if(gclx_sfdcode2.bindcolval==""){ //전체 항상 원화로 조회됨.
					if(chkbox_md2.checked==true){  //수정분개포함
						gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s3?v_str1="+str1
															+ "&v_str2="+str2 + "&v_str3="+str3 + "&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=A";
						gcds_data2.Reset();
					}else{  //수정분개 미포함
						gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s3_n?v_str1="+str1
															+ "&v_str2="+str2+"&v_str3="+str3 + "&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=A";
						
						gcds_data2.Reset();
					}
				gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
				gcds_staxdatki.Reset(); //기수
			}else if(gclx_sfdcode2.bindcolval=="03"){ //금강산(원화로 조회)
			  if(chkbox_md2.checked==true){  //수정분개포함
					gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s3?v_str1="+str1
														+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=K";
					//prompt("",gcds_data2.DataID);
					gcds_data2.Reset();
				}else{//수정분개 미포함
					gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s3_n?v_str1="+str1
														+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=K";
					gcds_data2.Reset();
				}
				gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
				gcds_staxdatki.Reset(); //기수
			}
		}
	}else if(s=="01") { //관리
		
		var str1 = gclx_sfdcode.bindcolval; //지점코드
		var str2 = gcem_staxdatfr.text; //년월from
		var str3 = gcem_staxdatto.text; //년월to
		//var str4 = gclx_cocode.bindcolval; //사업소
		var str4 =""; //사업소
		var str5 =""; //gclx_rdept.bindcolval; //본부

    	if(chkbox.checked==false){    //원화미적용
			if(chkbox_cost.checked==false){//판관비구분 안함 ==>판관비
				if(chkbox_md.checked==true){//수정분개 포함
					gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s22?v_str1="+str1
														+ "&v_str2="+str2+ "&v_str3="+str3+ "&v_str4="+str4+ "&v_str5="+str5; 
					//prompt("NY",gcds_data1.DataID);
					gcds_data1.Reset();
				}else{ //수정분개 미포함
					gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s22_n?v_str1="+str1
														+ "&v_str2="+str2+ "&v_str3="+str3+ "&v_str4="+str4+ "&v_str5="+str5; 
					//prompt("NN",gcds_data1.DataID);
					gcds_data1.Reset();
				}
			}else{//판매비&관리비 구분
				if(chkbox_md.checked==true){//수정분개 포함
					gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s22_b?v_str1="+str1
														+ "&v_str2="+str2+ "&v_str3="+str3+ "&v_str4="+str4+ "&v_str5="+str5; 
					//prompt("KNYB",gcds_data1.DataID);
					gcds_data1.Reset();
				}else{ //수정분개 미포함
					gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s22_n_b?v_str1="+str1
														+ "&v_str2="+str2+ "&v_str3="+str3+ "&v_str4="+str4+ "&v_str5="+str5; 
					//prompt("KYYB",gcds_data1.DataID);
					gcds_data1.Reset();
				}
			}
			gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
			gcds_staxdatki.Reset(); //기수
		}else{
			if(gclx_sfdcode.bindcolval==""){ //전체 항상 원화로 조회됨.
					if(chkbox_md.checked==true){  //수정분개포함
						gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s23?v_str1="+str1
															+ "&v_str2="+str2 + "&v_str3="+str3 + "&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=A";
            //prompt("AYY",gcds_data1.DataID);
						gcds_data1.Reset();
					}else{  //수정분개 미포함
						gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s23_n?v_str1="+str1
															+ "&v_str2="+str2+"&v_str3="+str3 + "&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=A";
						//prompt("AYN",gcds_data1.DataID);
						gcds_data1.Reset();
					}
				gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
				gcds_staxdatki.Reset(); //기수
			}else if(gclx_sfdcode.bindcolval=="03"){ //금강산(원화로 조회)
				if(chkbox_cost.checked==false){//판관비구분 안함 ==>판관비
					if(chkbox_md.checked==true){           //수정분개포함
						gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s23?v_str1="+str1
															+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=K";
						//prompt("KYY",gcds_data1.DataID);
						gcds_data1.Reset();
					}else{//수정분개 미포함
						gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s23_n?v_str1="+str1
															+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=K";
						//prompt("KYN",gcds_data1.DataID);
						gcds_data1.Reset();
					}
				}else{ //판관비구분함==>판매비&관리비
					if(chkbox_md.checked==true){           //수정분개포함
						gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s23_b?v_str1="+str1
															+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=K";
						//prompt("KYYB",gcds_data1.DataID);
						gcds_data1.Reset();
					}else{//수정분개 미포함
						gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s23_n_b?v_str1="+str1
															+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=K";
						prompt("KYNB",gcds_data1.DataID);
						gcds_data1.Reset();
					}
				}
				gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
				gcds_staxdatki.Reset(); //기수
			}
		}
	}
}

/*****************************************************************************************
	Description : 손익계산서 관리 계산식
*****************************************************************************************/

function ln_ManCalCu(){
	var cnt  = gcds_data1.countrow;
	var str1 = gclx_sfdcode.BindColVal;		//지점코드
	var str2 = gcem_staxdatto.text; 
	//var str4 = gclx_cocode.BindColVal;			//사업소
	var str4 = "";			//사업소
	var str5 =""; // gclx_rdept.BindColVal;				//본부
	var str6 = Number(str2.substring(0,4)-1)+str2.substring(4,6);		//회계년월(전기)
	var strfr1 = gcem_staxdatfr.text;				//회계년월(당기)
	var strfr2 = Number(strfr1.substring(0,4)-1)+strfr1.substring(4,6);	

	var md_gubun ="";
	var won_gubun="";
	if(chkbox.checked==false) won_gubun="N";
	else won_gubun="Y";
	if(chkbox_md.checked==true) md_gubun = "Y";  
	else  md_gubun = "N";  


	for(var i=1;i<=cnt;i++) {	//(당)기
		if (gcds_data1.namevalue(i,"XCOM") != null && gcds_data1.namevalue(i,"XCOM") != "") {
			var temp = gcds_data1.namevalue(i,"XCOM");				//좌변,우변 계산식
			gf_array_val(gcds_name,str1,str2,str4,str5,temp,strfr1,md_gubun,won_gubun);
			var s_amt = gcds_name2.namevalue(1,"TOTALVALUE");
			if (s_amt == null || s_amt == "NaN") s_amt = 0;
			gcds_data1.namevalue(i,"XRTTOT") = s_amt;
		}
	}
	///return;
	for(var i=1;i<=cnt;i++) {	//(전)기
		if (gcds_data1.namevalue(i,"YCOM") != null && gcds_data1.namevalue(i,"YCOM") != "") {
			var temp = gcds_data1.namevalue(i,"YCOM");				//좌변,우변 계산식
			gf_array_val(gcds_name,str1,str6,str4,str5,temp,strfr2,md_gubun,won_gubun);
			var s_amt = gcds_name2.namevalue(1,"TOTALVALUE");
			if (s_amt == null || s_amt == "NaN") s_amt = 0;
			gcds_data1.namevalue(i,"YRTTOT") = s_amt;
		}
	}
}


/*****************************************************************************************
	Description : 손익계산서 기업 계산식
*****************************************************************************************/
function ln_ManCalCu2(){
   	var cnt  = gcds_data2.countrow;
	var str1 = gclx_sfdcode2.BindColVal;		//지점코드
	var str2 = gcem_staxdatto2.text; 
	//var str4 = gclx_cocode.BindColVal;			//사업소
	var str4 = "";			//사업소
	var str5 = gclx_rdept.BindColVal;				//본부
	var str6 = Number(str2.substring(0,4)-1)+str2.substring(4,6);		//회계년월(전기)
	var strfr1 = gcem_staxdatfr2.text;				//회계년월(당기)
	var strfr2 = Number(strfr1.substring(0,4)-1)+strfr1.substring(4,6);	

	var md_gubun ="";
	var won_gubun="";
	if(chkbox2.checked==false) won_gubun="N";
	else won_gubun="Y";
	if(chkbox_md2.checked==true) md_gubun = "Y";  
	else  md_gubun = "N";  

	for(var i=1;i<=cnt;i++) {	//(당)기
	    
		if (gcds_data2.namevalue(i,"XCOM") != null && gcds_data2.namevalue(i,"XCOM") != "") {

			var temp = gcds_data2.namevalue(i,"XCOM");				//좌변,우변 계산식
			gf_array_val(gcds_name,str1,str2,str4,str5,temp,strfr1,md_gubun,won_gubun);
			var s_amt = gcds_name2.namevalue(1,"TOTALVALUE");
			if (s_amt == null || s_amt == "NaN") s_amt = 0;
			gcds_data2.namevalue(i,"XRTTOT") = s_amt;
		}
	}
	///return;
	for(var i=1;i<=cnt;i++) {	//(전)기
		if (gcds_data2.namevalue(i,"YCOM") != null && gcds_data2.namevalue(i,"YCOM") != "") {
			var temp = gcds_data2.namevalue(i,"YCOM");				//좌변,우변 계산식
			gf_array_val(gcds_name,str1,str6,str4,str5,temp,strfr2,md_gubun,won_gubun);
			var s_amt = gcds_name2.namevalue(1,"TOTALVALUE");
			if (s_amt == null || s_amt == "NaN") s_amt = 0;
			gcds_data2.namevalue(i,"YRTTOT") = s_amt;
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
	}else if(e=="02"){
		ln_PrintHeader();

			//날짜 및 시간 쿼리
		gcds_datetime.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_datetime_s1?"
		gcds_datetime.Reset();

    gcds_time.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030009_s4";
    gcds_time.Reset();

		for(i=1;i<=gcds_data2.countrow;i++){
			gcds_print.ImportData(gcds_data2.ExportData(i,1,false));
			
			var strfr1  = gcem_staxdatfr2.text+"01";	//8기
			var strfr2  = shiftTime(strfr1,-1,0,0);		//7기
			var strto		= gcem_staxdatto2.text+"01";	//to
			
			var strto1	= shiftTime(strto,0,1,-1);		//8기
			var strto2	= shiftTime(strto,-1,1,-1);		//7기
			var ki			= gcds_staxdatki.namevalue(1,"CDCODE");
			var ki1			= Number(gcem_staxdatfr2.text.substring(0,4))-Number(ki)+1;
			var ki2			= Number(gcem_staxdatfr2.text.substring(0,4))-1-Number(ki)+1;

			/*
			gcds_print.namevalue(i,"KISU1")	   = ki1+strfr1.substring(0,4)+strfr1.substring(4,6)+strfr1.substring(6,8)
																				 + strto1.substring(0,4)+strto1.substring(4,6)+strto1.substring(6,8);
			gcds_print.namevalue(i,"KISU2")	   = ki2+strfr2.substring(0,4)+strfr2.substring(4,6)+strfr2.substring(6,8)
																				 + strto2.substring(0,4)+strto2.substring(4,6)+strto2.substring(6,8);;
      */  

      gcds_print.namevalue(i,"KISU1")	   = "제"+ki1+"기 : "+strto1.substring(0,4)+"년 "+strto1.substring(4,6)+"월 "+strto1.substring(6,8)+"일 현재";
			gcds_print.namevalue(i,"KISU2")	   = "제"+ki2+"기 : "+strto2.substring(0,4)+"년 "+strto2.substring(4,6)+"월 "+strto2.substring(6,8)+"일 현재";


			gcds_print.namevalue(i,"CURKISU")  = Number(gcem_staxdatto2.text.substring(0,4))-Number(ki)+1;		//8기
			gcds_print.namevalue(i,"PREKISU")  = Number(gcem_staxdatto2.text.substring(0,4))-1-Number(ki)+1;	//7기
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
	var Theader = "PRTNAM:STRING,PRTSEQ:STRING,XLTTOT:DECIMAL,XRTTOT:DECIMAL,XCOM:STRING,"
							+ "XREAD:STRING,YLTTOT:DECIMAL,YRTTOT:DECIMAL,YCOM:STRING,YREAD:STRING,"
							+ "KISU1:STRING,KISU2:STRING,CURKISU:STRING,PREKISU:STRING,FDCODENM:STRING,"
							+ "CURDT:STRING,CURTM:STRIMG";
	gcds_print.SetDataHeader(Theader);
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(e){
	if(e=="01") {
	//	gcgd_disp01.runexcel("손익계산서 관리");
gcgd_disp01.GridToExcel("손익계산서 관리","",2);
	}
	else if(e=="02") {
	//	gcgd_disp02.runexcel("손익계산서 기업");
gcgd_disp02.GridToExcel("손익계산서 기업","",2);
	}

}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){

	gcem_staxdatfr2.text = gs_date3+"01"; //년월
	gcem_staxdatto2.text = gs_date2;
	gcem_staxdatfr.text = gs_date3+"01"; //년월
	gcem_staxdatto.text = gs_date2;

	//기업회계기준/지점코드
	gcds_sfdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset();

	//관리/지점코드
	gcds_sfdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode2.Reset();

	//관리/사업소
	gcds_cocode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>company_s1?v_str1=";
	gcds_cocode.Reset(); 

	//관리/본부
	gcds_rdept.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdeptprt_s1?v_str1=";
	gcds_rdept.Reset(); 

	gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
	gcds_staxdatki.Reset(); //기수
}

/******************************************************************************
	Description : 탭
	prameter    : 0 - 기업회계기준, 1 - 관리
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
	//사용하지 않음.
******************************************************************************/
function ln_DataSet(){

	var ls_temp1 = "PRTACT:STRING,PRTNAM:STRING,PRTSEQ:STRING,DECRTOT:DECIAML";
	var ls_temp2 = "PRTACT2:STRING,PRTNAM2:STRING,PRTSEQ2:STRING,DECRTOT2:DECIAML";
	var ls_temp3 = "PRTACT:STRING,PRTNAM:STRING,PRTSEQ:STRING,DECRTOT:DECIAML,"
							 + "PRTACT2:STRING,PRTNAM2:STRING,PRTSEQ2:STRING,DECRTOT2:DECIAML";
	gcds_temp1.SetDataHeader(ls_temp1);
	gcds_temp2.SetDataHeader(ls_temp2);
	gcds_temp3.SetDataHeader(ls_temp3);

	var decnt = 0;
	var crcnt = 0;
	for(var i=1;i<=gcds_data1.countrow;i++){
		var s_prtact = gcds_data1.namevalue(i,"PRTDIV");
		//var s_prtact = gcds_data1.namevalue(i,"PRTACT"); 
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

/******************************************************************************************
 	Descrition : 대차대조표 금액 계산 배열에 담기
	parameter  : gcds_name //데이타셋명 
	             fdcode    //지점코드
							 actyymm   //회계년월
							 atcode    //계정코드
							 cocode    //사업소
							 divcd     //본부
							 temp      //수식
	retun      : 사용안함.
******************************************************************************************/
function gf_array_val1(gcds_name,fdcode, actyymm, cocode, divcd, temp){ 
    alert("gcds_name:"+gcds_name+"/fdcode:"+fdcode+"/actyymm:"+actyymm+"/cocode:"+cocode+"/divcd:"+divcd+"/temp:"+temp);
	var arrcode = new Array();
	var cnt=0;
	var cnt1=0;
	var strData="";
	var result="";
	arrcode[0]="";

	for (i=0;i<temp.length;i++){
		if(temp.charAt(i)==" "){
		}else if(temp.charAt(i)>="0" && temp.charAt(i)<="9"){
				if(cnt1==0)strData="";
        strData += temp.charAt(i);
				arrcode[cnt]=strData;
			if (cnt1==6) {
					  gf_format_val1(gcds_name,fdcode,actyymm,arrcode[cnt],cocode,divcd);
						arrcode[cnt] = gcds_name.namevalue(1,"TOTALVAL");
						arrcode[cnt] = Math.floor(arrcode[cnt]);
						cnt1=0;
						cnt+=1;
						strData=""
					}else{
						cnt1+=1 ;
			}
		}else{
	      strData="";
				strData = temp.charAt(i);
        arrcode[cnt] =strData;
				cnt1=0;
				cnt+=1;
		}
	}//for
	for(j=0;j<arrcode.length;j++){
    result+=arrcode[j];
  }
	if(temp.length>=8){
		gf_cal_val1(gcds_name2,result);
  }else{
		gcds_name2.ClearAll();
		var s_temp = "TOTALVALUE:STRING"
		gcds_name2.SetDataHeader(s_temp);
		gcds_name2.addrow();
    gcds_name2.namevalue(1,"TOTALVALUE")=result;
	}

}

/******************************************************************************************
 	Descrition : 대차대조표 금액 계산
	parameter  : gcds_name //데이타셋명 
	             fdcode    //지점코드
							 actyymm   //회계년월
							 atcode    //계정코드
							 cocode    //사업소
							 divcd     //본부
	retun      : 
******************************************************************************************/
function gf_format_val1(gcds_name,fdcode, actyymm, atcode, cocode, divcd){ 

		gcds_name.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_func_s1?v_str1="+fdcode
																										 +"&v_str2="+actyymm
																										 +"&v_str3="+atcode
																										 +"&v_str4="+cocode
																										 +"&v_str5="+divcd;
	  gcds_name.Reset();			

}

/******************************************************************************************
 	Descrition : 대차대조표 금액 계산
	parameter  : gcds_name2,      //데이타셋명 
	             dblvalue         //계산식 
	            
	retun      : 
******************************************************************************************/
function gf_cal_val1(gcds_name2, dblvalue){ 

		gcds_name2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_cal_s1?v_str1="+dblvalue;
	  gcds_name2.Reset();

}

/******************************************************************************************
 	Descrition : 기업
******************************************************************************************/
function ln_Enable2(p){
	if(p=="t"){
		chkbox2.disabled=false;
	}else if(p=="f"){
	  chkbox2.disabled=true;
		chkbox2.checked=false;
	}
}

/******************************************************************************************
 	Descrition : 관리
******************************************************************************************/
function ln_Enable(p){
	if(p=="t"){
		chkbox.disabled=false;
	}else if(p=="f"){
	  chkbox.disabled=true;
		chkbox.checked=false;
	}

  if(gclx_sfdcode.bindcolval=="03"){
		chkbox_cost.disabled=false;
	}else{
		chkbox_cost.disabled=true;
		chkbox_cost.checked=false;
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- 기업회계기준 -->

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- 관리 -->

<comment id="__NSID__"><object  id=gcds_temp1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- 기업회계기준 -->

<comment id="__NSID__"><object  id=gcds_temp2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- 기업회계기준 -->

<comment id="__NSID__"><object  id=gcds_temp3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"		VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- 기업회계기준 -->

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
</object></comment><script>__ws__(__NSID__);</script> <!-- 기업회계기준 temp -->

<comment id="__NSID__"><object  id=gcds_name2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> <!-- 기업회계기준 temp -->

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
		//ln_DataSet(); //gcds_temp로
		ln_ManCalCu();	//손익계산관리  계산식
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
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
		ln_ManCalCu2();	//손익계산기업  계산식
	}
</script>

<script language="javascript" for="gcds_name" event="OnLoadStarted()">
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_name" event="onloadCompleted(row,colid)">
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_name2" event="OnLoadStarted()">
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_name2" event="onloadCompleted(row,colid)">
	document.all.LowerFrame.style.visibility="hidden";
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

	if(gclx_sfdcode.bindcolval==""||gclx_sfdcode.bindcolval=="03"){
		ln_Enable('t');
		if(gclx_sfdcode.bindcolval=="") chkbox.checked=true;
	}else{
		ln_Enable('f');
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

	if(gclx_sfdcode2.bindcolval==""||gclx_sfdcode2.bindcolval=="03"){
		ln_Enable2('t');
		if(gclx_sfdcode2.bindcolval=="") chkbox2.checked=true;
	}else{
		ln_Enable2('f');
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
	var ki1 = Number(gcem_staxdatto2.text.substring(0,4))-Number(ki)+1+"";   //8기
	var ki2 = Number(gcem_staxdatto2.text.substring(0,4))-1-Number(ki)+1+""; //7기
	gcgd_disp02.ColumnProp('GUBUN1','NAME') = "제 " + ki1 + "(당)기";
	gcgd_disp02.ColumnProp('GUBUN2','NAME') = "제 " + ki2 + "(전)기";
	gcgd_disp01.ColumnProp('GUBUN1','NAME') = "제 " + ki1 + "(당)기";
	gcgd_disp01.ColumnProp('GUBUN2','NAME') = "제 " + ki2 + "(전)기";
</script>

<script language=JavaScript for=gclx_sfdcode2 event=OnSelChange()>
	
	if(gclx_sfdcode2.bindcolval==""||gclx_sfdcode2.bindcolval=="03"){
		ln_Enable2('t');
		if(gclx_sfdcode2.bindcolval=="") chkbox2.checked=true;
	}else{
		ln_Enable2('f');
	}
</script>

<script language=JavaScript for=gclx_sfdcode event=OnSelChange()>
	if(gclx_sfdcode.bindcolval==""||gclx_sfdcode.bindcolval=="03"){
		ln_Enable('t');
		if(gclx_sfdcode.bindcolval=="") chkbox.checked=true;
	}else{
		ln_Enable('f');
	}

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

<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030010_head.gif"></td>
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
								<T>divid=div_1		title='기업회계기준'</T>									
								<T>divid=div_2		title='  관 리  '</T>
						  ">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!------------------------ 기업회계기준 ----------------------->
<fieldset id=field1 style="position:absolute;top:160px;left:18px;height:485px;width:878px;bacground-color:#708090"></fieldset>
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr> 				
				<td class="tab12" style="height:30px;width:50px;" bgcolor="#eeeeee">지점코드</td>
				<td class="tab12" style="width:80px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:80px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode2">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="FDNAME^0^80">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab12" style="height:25px;width:50px;" bgcolor="#eeeeee">년&nbsp;&nbsp;&nbsp;월</td>
				<td class="tab23" width="80px"><nobr>
					<comment id="__NSID__"><object  id=gcem_staxdatfr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					&nbsp;~&nbsp;<comment id="__NSID__">
					<object  id=gcem_staxdatto2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatto2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;&nbsp;</nobr>
				</td>
				<!-- <td class="tab12" style="height:25px;width:50px;" bgcolor="#eeeeee">사&nbsp;업&nbsp;소</td>
				<td class="tab23" width="40px"><nobr>
					<comment id="__NSID__"><object  id=gclx_cocode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:50px;height:110px;">
						<param name=ComboDataID			value="gcds_cocode">
						<param name=CBDataColumns		value="COCODE,CONAME">
						<param name=SearchColumn		value="CONAME">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CONAME^0^90">
						<param name=BindColumn			value="COCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td> -->
				<td class="tab12" style="height:25px;width:50px;" bgcolor="#eeeeee">본&nbsp;&nbsp;&nbsp;부</td>
				<td class="tab23" width="100px"><nobr>
					<comment id="__NSID__"><object  id=gclx_rdept classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:100px;height:150px;">
						<param name=ComboDataID			value="gcds_rdept">
						<param name=CBDataColumns		value="DEPTCD,DEPTNM">
						<param name=SearchColumn		value="DEPTNM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="DEPTNM^0^120">
						<param name=BindColumn			value="DEPTCD">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
 
        <td width="50px" class="tab12" bgcolor="#eeeeee"><nobr>수정분개</nobr></td>
				<td width="35px" class="tab23" ><nobr>&nbsp;
					<input type=checkbox  id=chkbox_md2  style=width:15px;position:relative;left:-4px;top:-1px;>
				</nobr>	
				</td>

				<td width="40px" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;원화&nbsp;</nobr></td>
				<td width="15px"><nobr>&nbsp;
					<input type=checkbox  id=chkbox2  style=width:15px;position:relative;left:-4px;top:-1px;>
				</nobr>	
				</td>
				<td align="right"  colspan="3">
					<img src="../../Common/img/btn/com_b_print.gif"	style="position:relative;right:-1px;top:2px;cursor:hand" onClick="ln_Print('02')">
					<img src="../../Common/img/btn/com_b_excel.gif"	style="position:relative;right:-1px;top:2px;cursor:hand" onClick="ln_Excel('02')">
					<img src="../../Common/img/btn/com_b_query.gif" style="position:relative;right:-1px;top:2px;cursor:hand" onclick="ln_Query('02')">&nbsp;
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
						style="position:relative;left:8px;width:864px; height:400px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data2">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
              <param name="Editable"    value="false">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='계정코드'	ID=ATCODE HeadAlign=Center HeadBgColor=#B9D4DC Width=185 align=left show=false</C> 
								<C> Name='계정과목'	ID=PRTNAM HeadAlign=Center HeadBgColor=#B9D4DC Width=185 align=left sort=false</C> 
								<G> Name='제 (당)기'	ID=GUBUN1 HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='금액'	ID=XLTTOT  HeadAlign=Center HeadBgColor=#B9D4DC Width=165 align=right</C>
									<C> Name='금액'	ID=XRTTOT  HeadAlign=Center HeadBgColor=#B9D4DC Width=165 align=right</C> 
								</G>
								<G> Name='제 (전)기'	ID=GUBUN2 HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='금액'	ID=YLTTOT HeadAlign=Center HeadBgColor=#B9D4DC Width=165 align=right</C> 
									<C> Name='금액'	ID=YRTTOT HeadAlign=Center HeadBgColor=#B9D4DC Width=165 align=right</C> 
								</G>
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


<!----------------- 관 리 -------------------->
<fieldset id=field2 style="position:absolute;top:160px;left:18px;height:485px;width:878px;bacground-color:#708090"></fieldset>
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr><td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab12" style="height:30px;width:60px;" bgcolor="#eeeeee">지점코드</td>
				<td class="tab12" style="width:80px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:80px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="FDNAME^0^80">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab12" style="height:25px;width:60px;" bgcolor="#eeeeee">년&nbsp;&nbsp;&nbsp;월</td>
				<td class="tab23" width="80px"><nobr>
					<comment id="__NSID__"><object  id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					&nbsp;~&nbsp;
					<comment id="__NSID__"><object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatto', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					&nbsp;&nbsp;</nobr>
				</td>

				<td width="50px" class="tab12" bgcolor="#eeeeee"><nobr>수정분개</nobr></td>
				<td width="35px" class="tab23" ><nobr>&nbsp;
					<input type=checkbox  id=chkbox_md  style=width:15px;position:relative;left:-4px;top:-1px;>
				</nobr>	
				</td>

				<td width="40px" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;원화&nbsp;</nobr></td>
				<td width="35px" class="tab23"><nobr>&nbsp;
					<input type=checkbox  id=chkbox  style=width:15px;position:relative;left:-4px;top:-1px;>
				</nobr>	
				</td>

				<td width="40px" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;판관비구분&nbsp;</nobr></td>
				<td width="15px"><nobr>&nbsp;
					<input type=checkbox  id=chkbox_cost  style=width:15px;position:relative;left:-4px;top:-1px;>
				</nobr>	
				</td>
				<td width="50px">&nbsp;</td>
				<td>&nbsp;</td>
				<td width="200px" align=right colspan="3">
					<img src="../../Common/img/btn/com_b_print.gif"	style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print('01')">
					<img src="../../Common/img/btn/com_b_excel.gif"	style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel('01')">
					<img src="../../Common/img/btn/com_b_query.gif" style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query('01')">
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
						style="position:relative;left:8px;width:864px; height:400px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data1">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
              <param name="Editable"    value="false">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='계정과목'	ID=PRTNAM HeadAlign=Center HeadBgColor=#B9D4DC Width=185 align=left sort=false</C> 
								<G> Name='제 (당)기'	ID=GUBUN1 HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='금액'	ID=XLTTOT  HeadAlign=Center HeadBgColor=#B9D4DC Width=165 align=right</C>
									<C> Name='금액'	ID=XRTTOT  HeadAlign=Center HeadBgColor=#B9D4DC Width=165 align=right</C> 
								</G>
								<G> Name='제 (전)기'	ID=GUBUN2 HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='금액'	ID=YLTTOT HeadAlign=Center HeadBgColor=#B9D4DC Width=165 align=right</C> 
									<C> Name='금액'	ID=YRTTOT HeadAlign=Center HeadBgColor=#B9D4DC Width=165 align=right</C> 
								</G>
							">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;">조회건수 :</font>
					</fieldset>
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
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=494 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='손 익 계 산 서' ,left=614 ,top=101 ,right=1437 ,bottom=161 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='KISU2', left=590, top=238, right=1468, bottom=286, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='KISU1', left=590, top=191, right=1468, bottom=241, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=71 ,top=339 ,right=1942 ,bottom=339 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURKISU', left=640, top=352, right=1201, bottom=418 ,mask='제 XX (당)기', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PREKISU', left=1344, top=352, right=1902, bottom=418 ,mask='제 XX (전)기', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FDCODENM', left=71, top=294, right=357, bottom=336, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Page :#p of #t' ,left=1508 ,top=294 ,right=1931 ,bottom=336 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=74 ,top=492 ,right=1942 ,bottom=492 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=564 ,top=423 ,right=1942 ,bottom=423 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='계정과목' ,left=82 ,top=352 ,right=553 ,bottom=487 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=71 ,top=339 ,right=71 ,bottom=492 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=564 ,top=339 ,right=564 ,bottom=492 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1249 ,top=339 ,right=1249 ,bottom=495 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='금액' ,left=1344 ,top=437 ,right=1894 ,bottom=484 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금액' ,left=640 ,top=437 ,right=1201 ,bottom=484 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1942 ,top=339 ,right=1942 ,bottom=492 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=53 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='{decode(XRTTOT,0,,XRTTOT)}', left=918, top=0, right=1244, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(XLTTOT,0,,XLTTOT)}', left=572, top=0, right=902, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(YLTTOT,0,,YLTTOT)}', left=1259, top=3, right=1588, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PRTNAM', left=85, top=5, right=553, bottom=45, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=71 ,top=0 ,right=71 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=564 ,top=0 ,right=564 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=910 ,top=0 ,right=910 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1598 ,top=0 ,right=1598 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=0 ,right=1942 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1249 ,top=0 ,right=1249 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{decode(YRTTOT,0,,YRTTOT)}', left=1606, top=0, right=1931, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2728 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=1558 ,top=3 ,right=1937 ,bottom=85</I>
	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='출력일시 :' ,left=77 ,top=3 ,right=243 ,bottom=69 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DATES', left=249, top=3, right=455, bottom=69, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TIMES', left=460, top=3, right=619, bottom=69, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>


	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 