<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	기본코드관리
+ 프로그램 ID	: h010002
+ 기 능 정 의	: 조회|등록|저장|삭제
+ 변 경 이 력	: 이순미
+ 서 블 릿 명	: h010002_s1, h010002_s2, h010002_s3, h010002_s4
								h010002_t1, h010002_t2, h010002_t3, h010002_t4,
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>기본코드관리</title>


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
get_cookdata();
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);		//트리초기화 호출
	ln_Luxequery();				//공통코드

	gcem_bundle.text = gcurdate;

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	gcem_zipcd.enabled = false;

	var v_str1 = txt_dong2.value;

  if (ln_Trim(txt_dong2.value) == "") {
		alert("검색할 동이름을 입력하여 주십시오.");
		txt_dong2.value="";
		txt_dong2.focus();
	} else {
		gcds_zipcode.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_s1?v_str1=" + v_str1; 
		gcds_zipcode.Reset();
	}

}

/*-----------------------------------------------------------------------------
 #  발령코드  : 조회
-----------------------------------------------------------------------------*/
function ln_Query2(){

		window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
		//document.all.LowerFrame.style.visibility="visible";

	if (gcds_sendal.namevalue(gcds_sendal.rowposition,"USEYN") == "T") {
		txt_useyn2.checked		= true;
	} else {
		txt_useyn2.checked		= false;
	}

		gcds_sendal.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_s2?v_str1=";
		gcds_sendal.Reset(); 
		txt_ordcd.disabled = true;
}

/*-----------------------------------------------------------------------------
 #  회사휴일관리  : 조회
-----------------------------------------------------------------------------*/
function ln_Query3(){

		window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
		//document.all.LowerFrame.style.visibility="visible";

		var str1 = gcem_bundle.text;
		gcds_holiday.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_s3?v_str1="+str1; 
		gcds_holiday.Reset(); 

}

/*-----------------------------------------------------------------------------
 #  특근수당관리  : 조회
-----------------------------------------------------------------------------*/
function ln_Query4(){

		window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
		//document.all.LowerFrame.style.visibility="visible";

		gcds_special.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_s4?v_str1="; 
		gcds_special.Reset(); 

		txt_lazcd.disabled = true;
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

	gcds_zipcode.addrow();
	gcem_zipcd.enabled = true;
	gcem_zipcd.focus();

}

/*-----------------------------------------------------------------------------
 #  발령코드  : 추가
-----------------------------------------------------------------------------*/
function ln_Add2(){

	gcds_sendal.addrow();
	gcds_sendal.DataID = "";

	if (gcds_sendal.DataID == "") {txt_useyn2.checked = false;}

	txt_ordcd.disabled = false;
	txt_ordcd.focus();
}

/*-----------------------------------------------------------------------------
 #  회사휴가관리  : 추가
-----------------------------------------------------------------------------*/
function ln_Add3(){

	gcds_holiday.addrow();

	ln_Luxequery();				//공통코드

	tb_HOLDT.enabled = true;
	tb_HOLDT.focus();
}

/*-----------------------------------------------------------------------------
 #  특근수당관리  : 추가
-----------------------------------------------------------------------------*/
function ln_Add4(){

	gcds_special.addrow();

	txt_lazcd.disabled = false;
	txt_lazcd.focus();
}

/******************************************************************************
	Description : 우편번호 - 저장
******************************************************************************/
function ln_Save(){

	if (gcds_zipcode.IsUpdated) {	
		if (confirm("입력하신 사항을 등록하시겠습니까?")){
			gctr_zipcode.KeyValue = "h010002_t1(I:USER=gcds_zipcode)";
			gctr_zipcode.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t1";
			gctr_zipcode.post();
			return ln_Query();
		}
	}
}

/*-----------------------------------------------------------------------------
 #  발령코드  : 저장
-----------------------------------------------------------------------------*/
function ln_Save2(){
	
	if (txt_useyn2.checked == true) {
		gcds_sendal.namevalue(gcds_sendal.rowposition, "USEYN") = "T";
	} else {
		gcds_sendal.namevalue(gcds_sendal.rowposition, "USEYN") = "F";
	}

	if (!ln_Valchk2()) return;

	if (gcds_sendal.IsUpdated) {	
		if (confirm("입력하신 사항을 등록하시겠습니까?")){
			gctr_sendal.KeyValue = "h010002_t2(I:USER=gcds_sendal)";
			gctr_sendal.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t2";
			gctr_sendal.post();
			return ln_Query2();
		}
	}
}

/******************************************************************************
	Description : 입력값 체크[발령코드]
******************************************************************************/
function ln_Valchk2() {

	if (txt_ordcd.value == "") {			
		alert("정확한 발령코드를 입력해 주십시오");
		txt_ordcd.focus();
		return false;
	}

	if (txt_ordnm.value == "") {			
		alert("정확한 발령코드명을 입력해 주십시오");
		txt_ordnm.focus();
		return false;
	}

	return true;

}

/*-----------------------------------------------------------------------------
 #  회사휴일관리  : 저장
-----------------------------------------------------------------------------*/
function ln_Save3(){

	if (gcds_holiday.IsUpdated) {	
		if (confirm("입력하신 사항을 등록하시겠습니까?")){
			gctr_holiday.KeyValue = "h010002_t3(I:USER=gcds_holiday)";
			gctr_holiday.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t3";
			gctr_holiday.post();
			return ln_Query3();
		}
	}
}

/*-----------------------------------------------------------------------------
 #  휴일 일괄생성  : 저장
-----------------------------------------------------------------------------*/
function ln_SaveBatch(){

	if (gcds_batch.IsUpdated) {	
		if (confirm("입력하신 사항을 등록하시겠습니까?")){
			gctr_batch.KeyValue = "h010002_t5(I:USER=gcds_batch)";
			gctr_batch.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t5";
			gctr_batch.post();
			return ln_Query3();
		}
	}
}

/******************************************************************************
	Description : 입력값 체크[휴일 일괄생성]
******************************************************************************/
function ln_ValchkBatch() {
	var ch = gclx_weekday.text;
	for(i=1;i<=gcds_holiday.countrow;i++) {
		if(gcds_holiday.namevalue(i,"HOLDT") == lx_weekday+"0105") {
			alert("생성할 휴일[년/월/일]이 존재합니다.");
		}
	}
}


/*-----------------------------------------------------------------------------
 #  회사휴일관리 : 일괄저장[토,일 - 주휴일] 
-----------------------------------------------------------------------------*/
function ln_TimeCalculate() {

	///ln_ValchkBatch();

	if (gclx_weekday.text == "") {
		alert("정확한 휴일 일괄 생성년월을 입력해 주십시요");
		return false;
	}

	var endM				= new Array(31,28,31,30,31,30,31,31,30,31,30,31);
	var months			= new Array("1","2","3","4","5","6","7","8","9","10","11","12");
	var days				= new Array("1","2","3","4","5","6","7");	//1:일요일
	var days2				= new Array("일요일","월요일","화요일","수요일","목요일","금요일","토요일");
	var type				= new Array("1","2");	//1:공휴일
	
	var lx_weekday	= gclx_weekday.text;
	var row					= gcds_holiday.rowposition;

	var y = lx_weekday;
	var m = 0;
	var d = 1;

	var hlpr = endM[m];
	//alert("end[M]_hlpr : "+ hlpr);
	if (d < endM[m] + 1) {
		if (m == 1 && y % 4 == 0) { hlpr++; }
		var c = new Date(y,m,d);
		var dayOfWeek = c.getDay();
		var mon_1 = ""
		//alert("dayOfWeek : " + c.getDay());
		//alert("요일 "+days2[dayOfWeek]);
		//alert("요일 "+days[dayOfWeek]);

		var a = c.getDay();	//토요일구분
		var mon_sun = "";	//일요일구분

		alert("토요일 : "+a);
		alert("일요일 : "+mon_sun);
		
		if (a == "0") {
			mon_1 = 7;	//1[일]
			mon_sun = 1;
		} else if (a == "1") {
			mon_1 = 6;	//1[월]
		} else if (a == "2") {
			mon_1 = 5;	//1[화]
		} else if (a == "3") {
			mon_1 = 4;	//1[수]
		} else if (a == "4") {
			mon_1 = 3;	//1[목]
		} else if (a == "5") {
			mon_1 = 2;	//1[금]
		} else if (a == "6") {
			mon_1 = 1;	//1[토]
		}
	}

		//alert("토 : "+mon_1);
		//alert("일 : "+mon_sun);

	for(i=1;i<=gcds_holiday.countrow;i++) {
		if(gcds_holiday.namevalue(i,"HOLDT") == lx_weekday+"01"+"0"+mon_1) {
			alert("생성할 휴일[년/월/일]이 존재합니다.");
			return false;
		}
	}

	

/*---------------------------------------------------------------------------------------
		● 1월 주휴일[토,일] 생성	
---------------------------------------------------------------------------------------*/
		
    //alert("mon_1::: " + mon_1 + " ::endM[0]:: "+ endM[0] );
		for(i=mon_1; i <= endM[0];i=i+7) {			//1월			
			//alert("1월 " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {
				//alert("이하");
				//alert("HOLDT: "+lx_weekday+"01"+"0"+i+"/"+"WHATDAY: 7"+"HOLNM : ''"+"HOLDIV: 2");
				//alert(mon_1);

				if (mon_sun == 1) {
					//alert("일요일 - 1일");
					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"01"+"01";							//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'

					if (i==9) { 
					
					}else{
						gcds_holiday.addrow();	//Row 추가
						tb_HOLDT.text = lx_weekday+"01"+"07";							//토_년/월/일
						gclx_whatday.BindColVal = "7";										//토_요일
						txt_holnm.value = "";															//토_휴일내용
						gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'
					}
				} else {				
					//2010.02.01 jys 수정 1월 생성이 이상했음..
					if (i<9) {
						gcds_holiday.addrow();	//Row 추가
						
						tb_HOLDT.text = lx_weekday+"01"+"0"+i;						//토_년/월/일
						gclx_whatday.BindColVal = "7";										//토_요일
						txt_holnm.value = "";															//토_휴일내용
						gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

						gcds_holiday.addrow();	//Row 추가
						tb_HOLDT.text = lx_weekday+"01"+"0"+Number(i+1);	//일_년/월/일
						gclx_whatday.BindColVal = "1";										//일_요일
						txt_holnm.value = "";															//일_휴일내용
						gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'
          }else if (i==9){
            gcds_holiday.addrow();	//Row 추가
					  tb_HOLDT.text = lx_weekday+"01"+"0"+i;						//토_년/월/일
						gclx_whatday.BindColVal = "7";										//토_요일
						txt_holnm.value = "";															//토_휴일내용
						gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'
						
						gcds_holiday.addrow();	//Row 추가
						tb_HOLDT.text = lx_weekday+"01"+"10";	            //일_년/월/일
						gclx_whatday.BindColVal = "1";										//일_요일
						txt_holnm.value = "";															//일_휴일내용
						gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'

					}else{
			      gcds_holiday.addrow();	//Row 추가
						tb_HOLDT.text = lx_weekday+"01"+i;						  //토_년/월/일
						gclx_whatday.BindColVal = "7";										//토_요일
						txt_holnm.value = "";															//토_휴일내용
						gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

						gcds_holiday.addrow();	//Row 추가
						tb_HOLDT.text = lx_weekday+"01"+Number(i+1);	    //일_년/월/일
						gclx_whatday.BindColVal = "1";										//일_요일
						txt_holnm.value = "";															//일_휴일내용
						gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'
					}
				}
					
			}else{

				//alert("이상");
				//alert("HOLDT: "+lx_weekday+"01"+i+"/"+"WHATDAY: 7"+"HOLNM : ''"+"HOLDIV: 2");

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"01"+i;								//토_년/월/일
				gclx_whatday.BindColVal = "7";										//토_요일
				txt_holnm.value = "";															//토_휴일내용
				gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

				if (i>=31) { 
					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"02"+"01";							//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일' 
				
				}else {

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"01"+Number(i+1);			//일_년/월/일
				gclx_whatday.BindColVal = "1";										//일_요일
				txt_holnm.value = "";															//일_휴일내용
				gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'
			}
		}
	}

/*---------------------------------------------------------------------------------------
		● 2월 주휴일[토,일] 생성	
---------------------------------------------------------------------------------------*/

		var mon_2 = i-endM[0];
		//alert("2월 --> "+ mon_2);
		for(i=mon_2; i <= endM[1];i=i+7) {			//2월	
			//alert("2월 " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"02"+"0"+i;						//토_년/월/일
					gclx_whatday.BindColVal = "7";										//토_요일
					txt_holnm.value = "";															//토_휴일내용
					gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

					if (i==9) {
						
						gcds_holiday.addrow();	//Row 추가
						tb_HOLDT.text = lx_weekday+"02"+"10";							//일_년/월/일
						gclx_whatday.BindColVal = "1";										//일_요일
						txt_holnm.value = "";															//일_휴일내용
						gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'
					
					}else{

						gcds_holiday.addrow();	//Row 추가
						tb_HOLDT.text = lx_weekday+"02"+"0"+Number(i+1);	//일_년/월/일
						gclx_whatday.BindColVal = "1";										//일_요일
						txt_holnm.value = "";															//일_휴일내용
						gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'

					}
					
			}else{

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"02"+i;								//토_년/월/일
				gclx_whatday.BindColVal = "7";										//토_요일
				txt_holnm.value = "";															//토_휴일내용
				gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'
				
				if (i>=28) { 
					//alert("1");

						gcds_holiday.addrow();	//Row 추가
						tb_HOLDT.text = lx_weekday+"03"+"01";							//일_년/월/일
						gclx_whatday.BindColVal = "1";										//일_요일
						txt_holnm.value = "";															//일_휴일내용
						gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일' 
				
				} else {

						gcds_holiday.addrow();	//Row 추가
						tb_HOLDT.text = lx_weekday+"02"+Number(i+1);			//일_년/월/일
						gclx_whatday.BindColVal = "1";										//일_요일
						txt_holnm.value = "";															//일_휴일내용
						gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'
					
			}

			if(((y%4)==0)&&((y%100)!=0)||((y%400)==0)) { 
				//alert("윤달!!");
				//gcds_holiday.addrow();	//Row 추가
				endM[1] = 29;
				//tb_HOLDT.text = lx_weekday+"02"+i;							//토_년/월/일
				//gclx_whatday.BindColVal = "7";										//토_요일
				//txt_holnm.value = "";															//토_휴일내용
				//gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'  
			}

		}
	}

/*---------------------------------------------------------------------------------------
		● 3월 주휴일[토,일] 생성	
---------------------------------------------------------------------------------------*/

		var mon_3 = i-endM[1];
		for(i=mon_3; i <= endM[2];i=i+7) {			//3월	
			//alert("3월 " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row 추가	
					tb_HOLDT.text = lx_weekday+"03"+"0"+i;						//토_년/월/일
					gclx_whatday.BindColVal = "7";										//토_요일
					txt_holnm.value = "";															//토_휴일내용
					gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"03"+"0"+Number(i+1);	//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'
					
					}
					
			}else{

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"03"+i;								//토_년/월/일
				gclx_whatday.BindColVal = "7";										//토_요일
				txt_holnm.value = "";															//토_휴일내용
				gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

				if (i>=31) { 
				
					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"04"+"01";							//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일' 
				
				}else {

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"03"+Number(i+1);			//일_년/월/일
				gclx_whatday.BindColVal = "1";										//일_요일
				txt_holnm.value = "";															//일_휴일내용
				gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'
				}
			}
		}

/*---------------------------------------------------------------------------------------
		● 4월 주휴일[토,일] 생성	
---------------------------------------------------------------------------------------*/

		var mon_4 = i-endM[2];
		for(i=mon_4; i <= endM[3];i=i+7) {			//4월	
			//alert("4월 " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row 추가				
					tb_HOLDT.text = lx_weekday+"04"+"0"+i;						//토_년/월/일
					gclx_whatday.BindColVal = "7";										//토_요일
					txt_holnm.value = "";															//토_휴일내용
					gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"04"+"0"+Number(i+1);	//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'

					}
					
			}else{

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"04"+i;								//토_년/월/일
				gclx_whatday.BindColVal = "7";										//토_요일
				txt_holnm.value = "";															//토_휴일내용
				gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

				if (i>=30) { 
				
					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"05"+"01";							//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일' 
				
				}else {

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"04"+Number(i+1);			//일_년/월/일
				gclx_whatday.BindColVal = "1";										//일_요일
				txt_holnm.value = "";															//일_휴일내용
				gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'
			}
		}
	}

/*---------------------------------------------------------------------------------------
		● 5월 주휴일[토,일] 생성	
---------------------------------------------------------------------------------------*/

		var mon_5 = i-endM[3];
		for(i=mon_5; i <= endM[4];i=i+7) {			//5월	
			//alert("5월 " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"05"+"0"+i;						//토_년/월/일
					gclx_whatday.BindColVal = "7";										//토_요일
					txt_holnm.value = "";															//토_휴일내용
					gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"05"+"0"+Number(i+1);	//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'

					}
					
			}else{

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"05"+i;								//토_년/월/일
				gclx_whatday.BindColVal = "7";										//토_요일
				txt_holnm.value = "";															//토_휴일내용
				gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

				if (i>=31) { 
				
					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"06"+"01";							//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일' 
				
				}else {

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"05"+Number(i+1);			//일_년/월/일
				gclx_whatday.BindColVal = "1";										//일_요일
				txt_holnm.value = "";															//일_휴일내용
				gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'
			}
		}
	}

/*---------------------------------------------------------------------------------------
		● 6월 주휴일[토,일] 생성	
---------------------------------------------------------------------------------------*/

		var mon_6 = i-endM[4];
		for(i=mon_6; i <= endM[5];i=i+7) {			//6월	
			//alert("6월 " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"06"+"0"+i;						//토_년/월/일
					gclx_whatday.BindColVal = "7";										//토_요일
					txt_holnm.value = "";															//토_휴일내용
					gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"06"+"0"+Number(i+1);	//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'

					}
					
			}else{

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"06"+i;								//토_년/월/일
				gclx_whatday.BindColVal = "7";										//토_요일
				txt_holnm.value = "";															//토_휴일내용
				gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

				if (i>=30) { 
				
					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"07"+"01";							//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일' 
				
				}else {

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"06"+Number(i+1);			//일_년/월/일
				gclx_whatday.BindColVal = "1";										//일_요일
				txt_holnm.value = "";															//일_휴일내용
				gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'
			}
		}
	}

/*---------------------------------------------------------------------------------------
		● 7월 주휴일[토,일] 생성	
---------------------------------------------------------------------------------------*/

		var mon_7 = i-endM[5];
		for(i=mon_7; i <= endM[6];i=i+7) {			//7월	
			//alert("7월 " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"07"+"0"+i;						//토_년/월/일
					gclx_whatday.BindColVal = "7";										//토_요일
					txt_holnm.value = "";															//토_휴일내용
					gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"07"+"0"+Number(i+1);	//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'

					}
					
			}else{

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"07"+i;								//토_년/월/일
				gclx_whatday.BindColVal = "7";										//토_요일
				txt_holnm.value = "";															//토_휴일내용
				gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

				if (i>=31) { 
				
					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"08"+"01";							//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일' 
				
				}else {

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"07"+Number(i+1);			//일_년/월/일
				gclx_whatday.BindColVal = "1";										//일_요일
				txt_holnm.value = "";															//일_휴일내용
				gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'
			}
		}
	}

/*---------------------------------------------------------------------------------------
		● 8월 주휴일[토,일] 생성	
---------------------------------------------------------------------------------------*/

		var mon_8 = i-endM[6];
		for(i=mon_8; i <= endM[7];i=i+7) {			//8월	
			//alert("8월 " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"08"+"0"+i;						//토_년/월/일
					gclx_whatday.BindColVal = "7";										//토_요일
					txt_holnm.value = "";															//토_휴일내용
					gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"08"+"0"+Number(i+1);	//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'

					}
					
			}else{

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"08"+i;								//토_년/월/일
				gclx_whatday.BindColVal = "7";										//토_요일
				txt_holnm.value = "";															//토_휴일내용
				gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

				if (i>=31) { 
				
					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"09"+"01";							//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일' 
				
				}else {

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"08"+Number(i+1);			//일_년/월/일
				gclx_whatday.BindColVal = "1";										//일_요일
				txt_holnm.value = "";															//일_휴일내용
				gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'
			}
		}
	}

/*---------------------------------------------------------------------------------------
		● 9월 주휴일[토,일] 생성	
---------------------------------------------------------------------------------------*/

		var mon_9 = i-endM[7];
		for(i=mon_9; i <= endM[8];i=i+7) {			//9월	
			//alert("9월 " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"09"+"0"+i;						//토_년/월/일
					gclx_whatday.BindColVal = "7";										//토_요일
					txt_holnm.value = "";															//토_휴일내용
					gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"09"+"0"+Number(i+1);	//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'
					}
					
			}else{

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"09"+i;								//토_년/월/일
				gclx_whatday.BindColVal = "7";										//토_요일
				txt_holnm.value = "";															//토_휴일내용
				gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

				if (i>=30) { 
				
					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"10"+"01";							//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일' 
				
				}else {

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"09"+Number(i+1);			//일_년/월/일
				gclx_whatday.BindColVal = "1";										//일_요일
				txt_holnm.value = "";															//일_휴일내용
				gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'
			}
		}
	}

/*---------------------------------------------------------------------------------------
		● 10월 주휴일[토,일] 생성	
---------------------------------------------------------------------------------------*/

		var mon_10 = i-endM[8];
		for(i=mon_10; i <= endM[9];i=i+7) {			//10월	
			//alert("10월 " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row 추가				
					tb_HOLDT.text = lx_weekday+"10"+"0"+i;						//토_년/월/일
					gclx_whatday.BindColVal = "7";										//토_요일
					txt_holnm.value = "";															//토_휴일내용
					gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"10"+"0"+Number(i+1);	//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'

					}
					
			}else{

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"10"+i;								//토_년/월/일
				gclx_whatday.BindColVal = "7";										//토_요일
				txt_holnm.value = "";															//토_휴일내용
				gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

				if (i>=31) { 
				
					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"11"+"01";							//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일' 
				
				}else {

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"10"+Number(i+1);			//일_년/월/일
				gclx_whatday.BindColVal = "1";										//일_요일
				txt_holnm.value = "";															//일_휴일내용
				gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'
			}
		}
	}

/*---------------------------------------------------------------------------------------
		● 11월 주휴일[토,일] 생성	
---------------------------------------------------------------------------------------*/

		var mon_11 = i-endM[9];
		for(i=mon_11; i <= endM[10];i=i+7) {			//11월	
			//alert("11월 " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row 추가				
					tb_HOLDT.text = lx_weekday+"11"+"0"+i;						//토_년/월/일
					gclx_whatday.BindColVal = "7";										//토_요일
					txt_holnm.value = "";															//토_휴일내용
					gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"11"+"0"+Number(i+1);	//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'

					}
					
			}else{

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"11"+i;								//토_년/월/일
				gclx_whatday.BindColVal = "7";										//토_요일
				txt_holnm.value = "";															//토_휴일내용
				gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

				if (i>=30) { 
				
					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"12"+"01";							//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일' 
				
				}else {

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"11"+Number(i+1);			//일_년/월/일
				gclx_whatday.BindColVal = "1";										//일_요일
				txt_holnm.value = "";															//일_휴일내용
				gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'
			}
		}
	}

/*---------------------------------------------------------------------------------------
		● 12월 주휴일[토,일] 생성	
---------------------------------------------------------------------------------------*/

		var mon_12 = i-endM[10];
		for(i=mon_12; i <= endM[11];i=i+7) {			//12월	
			//alert("11월 " + days2[6] + " : "+ i + "/"+ days2[0] + " : " + Number(i+1));
			
			if (i<=9) {

					gcds_holiday.addrow();	//Row 추가				
					tb_HOLDT.text = lx_weekday+"12"+"0"+i;						//토_년/월/일
					gclx_whatday.BindColVal = "7";										//토_요일
					txt_holnm.value = "";															//토_휴일내용
					gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

					if (i==9) { }else{

					gcds_holiday.addrow();	//Row 추가
					tb_HOLDT.text = lx_weekday+"12"+"0"+Number(i+1);	//일_년/월/일
					gclx_whatday.BindColVal = "1";										//일_요일
					txt_holnm.value = "";															//일_휴일내용
					gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'
					
					}
					
			}else{

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"12"+i;								//토_년/월/일
				gclx_whatday.BindColVal = "7";										//토_요일
				txt_holnm.value = "";															//토_휴일내용
				gclx_holdiv.BindColVal = "2";											//토_구분 '2:주휴일'

				if (i>=31) { 
				
					//gcds_holiday.addrow();	//Row 추가
					//tb_HOLDT.text = lx_weekday+"01"+"01";							//일_년/월/일
					//gclx_whatday.BindColVal = "1";										//일_요일
					//txt_holnm.value = "";															//일_휴일내용
					//gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일' 
				
				}else {

				gcds_holiday.addrow();	//Row 추가
				tb_HOLDT.text = lx_weekday+"12"+Number(i+1);			//일_년/월/일
				gclx_whatday.BindColVal = "1";										//일_요일
				txt_holnm.value = "";															//일_휴일내용
				gclx_holdiv.BindColVal = "2";											//일_구분 '2:주휴일'
			}
		}
	}
	

	ln_Save3();

}

function setY() {
	var y = new Date().getYear();
	if (y < 2000) y += 1900;
	document.ymdForm1.year.value = y;
}	

/*-----------------------------------------------------------------------------
 #  특근수당관리  : 저장
-----------------------------------------------------------------------------*/
function ln_Save4(){

	if (gcds_special.IsUpdated) {	
		if (confirm("입력하신 사항을 등록하시겠습니까?")){
			gctr_special.KeyValue = "h010002_t4(I:USER=gcds_special)";
			gctr_special.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t4";
			gctr_special.post();
			return ln_Query4();
		}
	}
}

/******************************************************************************
	Description : 우편번호 - 삭제
******************************************************************************/
function ln_Delete(){

if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_zipcode.deleterow(gcds_zipcode.rowposition);
		gctr_zipcode.KeyValue = "h010002_t1(I:USER=gcds_zipcode)";
		gctr_zipcode.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t1";
		gctr_zipcode.post();
		return ln_Query();
	}else gcds_zipcode.undo(gcds_zipcode.rowposition);		

}

/*-----------------------------------------------------------------------------
 #  발령코드  : 삭제
-----------------------------------------------------------------------------*/
function ln_Delete2(){

	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_sendal.UserStatus(gcds_sendal.rowposition)=2;
		gcds_sendal.deleterow(gcds_sendal.rowposition);
		gctr_sendal.KeyValue = "h010002_t2(I:USER=gcds_sendal)";
		gctr_sendal.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t2";
		gctr_sendal.post();
		return ln_Query2();
	}else gcds_sendal.undo(gcds_sendal.rowposition);		
}

/*-----------------------------------------------------------------------------
 #  회사휴일관리  : 삭제
-----------------------------------------------------------------------------*/
function ln_Delete3(){

	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
			gcds_holiday.deleterow(gcds_holiday.rowposition);
			gctr_holiday.KeyValue = "h010002_t3(I:USER=gcds_holiday)";
			gctr_holiday.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t3";
			gctr_holiday.post();
			return ln_Query3();
		}else gcds_holiday.undo(gcds_holiday.rowposition);		
	}

/*-----------------------------------------------------------------------------
 #  휴일 일괄삭제
-----------------------------------------------------------------------------*/
function ln_DelBatch(){

	var str1 = gclx_weekday.text;

	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
			gcds_holiday.deleterow(gcds_holiday.rowposition);
			gctr_holiday.KeyValue = "h010002_t5(I:USER=gcds_holiday)";
			gctr_holiday.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t5?v_str1="+str1;
			gctr_holiday.post();
			return ln_Query3();
		}else gcds_holiday.undo(gcds_holiday.rowposition);		

}

/*-----------------------------------------------------------------------------
 #  특근수당관리  : 삭제
-----------------------------------------------------------------------------*/
function ln_Delete4(){

	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
			gcds_special.deleterow(gcds_special.rowposition);
			gctr_special.KeyValue = "h010002_t4(I:USER=gcds_special)";
			gctr_special.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_t4";
			gctr_special.post();
			return ln_Query4();
		}else gcds_special.undo(gcds_special.rowposition);
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

}

/******************************************************************************
	Description : 탭 설정
******************************************************************************/
function ln_Tabset(index){

	var div_cm=new Array("div_zipcode","div_sendal","div_holiday","div_special");

	for(var i=0;i<=3;i++)  {
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		} else {
			eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
}

/******************************************************************************************
	Descrition : CheckBox
******************************************************************************************/
function ln_Chkbox(e,a){
	var row = gcds_sendal.rowposition;

	if (e.checked) gcds_sendal.namevalue(row,a) = "T";
	else gcds_sendal.namevalue(row,a) = "F";
}


/******************************************************************************
	Description : 공통코드 조회
******************************************************************************/
function ln_Luxequery(){

	//회사휴일관리 - 요일
	gcds_whatday.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1151"; 
	gcds_whatday.Reset();

	//회사휴일관리 - 휴일구분
	gcds_holdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1150"; 
	gcds_holdiv.Reset();

}

/******************************************************************************
	Description : 공백제거
******************************************************************************/
function ln_Trim(str){
   
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
} 

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcds_zipcode" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false"><!--우편번호-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_sendal" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false"><!--발령코드-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_holiday" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false"><!--회사휴일-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_whatday" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true"><!--회사휴일 - 요일-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_holdiv" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true"><!--회사휴일 - 휴일구분-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_batch" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true"><!--휴일 일괄생성-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_special" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false"><!--특근수당-->
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_zipcode classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--우편번호-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gctr_sendal classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--발령코드-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gctr_holiday classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--회사휴일-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gctr_batch classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
		<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--휴일 일괄생성-->
		<PARAM NAME="KeyValue" VALUE="h010002_t5(I:USER=gcds_batch)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gctr_special classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--특근수당-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gs_tab event=OnSelChanged(index)>
	ln_Tabset((index-1));
</script>

<script language="javascript" for="gcgd_sendal" event="onClick(row,colid)">
	if (gcds_sendal.namevalue(gcds_sendal.rowposition,"USEYN") == 'T') {
		txt_useyn2.checked = true;
	} else {
		txt_useyn2.checked = false;
	}
</script>

<script language=JavaScript  for=gcds_zipcode event=OnLoadCompleted(rowcount)>	//우편번호 총 검색 건수
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	} 

	lbl_search1.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";
</script>

<script language=JavaScript  for=gcds_sendal event=OnLoadCompleted(rowcount)>	//발령코드 총 검색 건수
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	} 

	lbl_search2.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";
</script>



<script language=JavaScript  for=gcds_holiday event=OnLoadCompleted(rowcount)>	//회사휴일 총 검색 건수
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	} 

	lbl_search3.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";
</script>

<script language=JavaScript  for=gcds_special event=OnLoadCompleted(rowcount)>	//근태수당 총 검색 건수
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	} 

	lbl_search4.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";
</script>

<script language="javascript" for="gcds_zipcode" event=OnLoadStarted()>	//우편번호
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_zipcode" event="onsuccess()">//우편번호
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_zipcode" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language="javascript" for="gctr_sendal" event="OnSuccess()">//발령코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_sendal" event="OnFail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language="JavaScript" for="gctr_holiday" event=OnSuccess()>//회사휴일
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="JavaScript" for="gctr_holiday" event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다999.");
</script>

<script language="javascript" for="gctr_special" event="onsuccess()">//특근수당
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_special" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>



</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/h010002_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2 ALING=LEFT>

      <table width="0" cellpadding="1" cellspacing="1" border="0">
				<tr> 
					<td width="0" align=RIGHT><NOBR>
					  <comment id="__NSID__"><OBJECT id=gs_tab classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;cursor:hand;">
              <PARAM NAME="BackColor" VALUE="#cccccc">
              <PARAM NAME="titleHeight" VALUE="20px">
              <PARAM NAME="DisableBackColor" VALUE="#eeeeee">
              <PARAM NAME="Format" VALUE="
							<T>divid=div_zipcode  title=우편번호</T>                                  
              <T>divid=div_sendal		title=발령코드</T>
              <T>divid=div_holiday  title=회사휴일</T>
              <T>divid=div_special  title=특근수당</T>                                  
              ">
            </OBJECT></comment><script>__ws__(__NSID__);</script></NOBR>
					</td>
        </tr>
      </table>
    
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2><div id="div_zipcode" style="cursor:hand;">
			<table width="875" cellpadding="1" cellspacing="0" border="0">
				<tr><td height=10></td></tr>
				<tr>
					<td colspan=8 align=center>

						<table width="846" cellpadding="1" cellspacing="1" border="0" style='width:846px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
							
							<tr><!--우편번호-->
								<td align=LEFT  style="border:0 solid #708090;border-right-width:1px;width:30px;height:22px" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp; 동 이 름&nbsp;&nbsp;</nobr></td>
								<td width="0" align=LEFT ><nobr>
									<INPUT TYPE=TEXT ID=txt_dong2 class="txtbox"  width=70 height=18 style="position:relative;left:5px" maxlength="60" onBlur="bytelength(this,this.value,60);" onkeydown="if(event.keyCode==13) ln_Query();"></nobr></td>
                <td width=100%>&nbsp;</td>
                <td><nobr>      
									<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:-69px" onClick="ln_Delete()">
									<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:-69px" onClick="ln_Add()">
									<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:-69px" onClick="ln_Save()">
									<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:-69px" onClick="ln_Query()"> 
									</nobr>
								</td>
              </tr>
            </table>
                </td>
              </tr>
              <tr>
								<td ALIGN=CENTER>

							<table width="847" cellpadding="1" cellspacing="1" border="0">
								<tr> 
									<td style="width:847" ALIGN=LEFT VALIGN=TOP>
										<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_zipcode  style="WIDTH: 460px; HEIGHT: 380px;border:1 solid #777777;display:block;" viewastext>
											<PARAM NAME="DataID"        VALUE="gcds_zipcode">
											<PARAM NAME="Editable"			VALUE="false">
											<PARAM NAME="BorderStyle"		VALUE="0">
											<param NAME="Fillarea"      VALUE="true">
											<PARAM NAME="Format"        VALUE="  
												<C> Name='순번'			ID=ZIPSEQ   HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=CENTER show=false</C> 
                        <C> Name='우편번호' ID=ZIPCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=CENTER Mask='XXX-XXX'</C> 
                        <C> Name='시도'			ID=SIDO			HeadAlign=Center HeadBgColor=#B9D4DC Width=65		align=CENTER</C> 
                        <C> Name='시군구'		ID=GUGUN		HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=CENTER</C> 
                        <C> Name='읍면동'		ID=DONG			HeadAlign=Center HeadBgColor=#B9D4DC Width=220	align=LEFT</C> 
                        <C> Name='번지'			ID=BUNJI		HeadAlign=Center HeadBgColor=#B9D4DC Width=95		align=CENTER</C> 
                        ">
										</OBJECT></comment><script>__ws__(__NSID__);</script>
                  </td>
                  <td>

									<table border= "0" class=itemdisp cellpadding=0 cellspacing=1  border=0  style='width:382px;height:382px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
                    <tr>											
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;우편번호</td>
                      <td style="border:0 solid #708090;border-bottom-width:1px;">&nbsp;
												<comment id="__NSID__"><object id=gcem_zipcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:1px; width:60px; height:20px; font-family:굴림; font-size:9pt;z-index:2; "class=objclsEme1validFeatures="ignoreStatus=yes" validExp="">
													<PARAM NAME="DataID"			VALUE="gcds_zipcode">
													<param name=Text          value="">
													<param name=Alignment     value=0>
													<param name=Border        value=true>
													<param name=ClipMode      value=true>
													<param name=Numeric       value=false>
													<param name=Format        value="000-000">
													<param name=MaxLength     value=6>
													<param name=PromptChar    value="_">
													<param name=IsComma       value=false>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
                    </tr>
										<tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;시&nbsp;&nbsp;&nbsp;&nbsp;도</nobr></td>
                      <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_sido" name="nwrlgn"  class="txtbox" type="text" style="width:260px;" maxlength="6" onBlur="bytelength(this,this.value,6);">&nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" ><nobr>&nbsp;시 군 구</nobr></td>  
                      <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_gugun" name="nwrlgn"  class="txtbox" type="text" style="width:260px;" maxlength="20" onBlur="bytelength(this,this.value,20);">&nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;읍 면 동</td>
                      <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_dong" name="nwrlgn"  class="txtbox" type="text" style="width:260px;" maxlength="60" onBlur="bytelength(this,this.value,60);">&nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align="center" class="txtbox" >&nbsp;번&nbsp;&nbsp;&nbsp;&nbsp;지</td>
                      <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
												<input id="txt_bunji" name="nwrlgn"  class="txtbox" type="text" style="width:260px;" maxlength="30" onBlur="bytelength(this,this.value,30);">&nbsp;</nobr>
											</td>
                    </tr>
                    <tr>
                      <td colspan=2 style="height:100%;border:0 solid #708090;" >&nbsp;
                      </td>
                    </tr>
									</table>
											</TD>
										</tr>
									</table>
								</td>
               </tr>
             </table>
						 <table border=0 cellpadding=1 cellspacing=1 width=875>
								<tr><td height=10></td></tr>
							 <tr>
							  <td height="24">조회건수 : <label id="lbl_search1"></label></td>
							 </tr>
						</table>
						 </div>

<div id="div_sendal" style="display:none">
	<table width="875" cellpadding="1" cellspacing="1" border="0">
		<tr><td height=13></td></tr>
		<tr>
			<td colspan=8 align=center>
			<table width="847" cellpadding="1" cellspacing="1" border="0">
				<tr> 
					<td width="0" align=RIGHT ><nobr ><!--발령코드--></nobr></td>
					<td width=100%>&nbsp;</td>
					<td><nobr>      
						<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:-71px;right:2px;" onClick="ln_Delete2()">
						<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:-71px;right:2px;" onClick="ln_Add2()">
						<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:-71px;right:2px;" onClick="ln_Save2()">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:-71px;right:2px;" onClick="ln_Query2()"> 
						</nobr>
					</td>
        </tr>
      </table>
		</td>
  </tr>
  <tr><td align=center valign=middle>
	<table width="847" cellpadding="1" cellspacing="1" border="0">
		<tr> 
			<td style="width:847" align=center>
				<comment id="__NSID__"><OBJECT id=gcgd_sendal classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="WIDTH: 460px; HEIGHT: 380px;border:1 solid #777777" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_sendal">
              <PARAM NAME="Editable"		VALUE="false">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param NAME="Fillarea"		VALUE="true">
							<param name="sortview"				VALUE=left>
							<PARAM NAME="Format"			VALUE="
            <C> Name='발령코드' ID=ORDCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=CENTER	Edit=none sort = true</C>
            <C> Name='발령명칭' ID=ORDNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=146	align=LEFT		Edit=none sort = true</C>
            <C> Name='적용항목' ID=CHKITEM  HeadAlign=Center HeadBgColor=#B9D4DC Width=115	align=CENTER  Edit=none</C>
            <C> Name='발령구분' ID=ORDDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=CENTER  Edit=none</C>
						<C> Name='사용유무'	ID=USEYN  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=center  EditStyle=combo  Data='T:사용,F:미사용' Pointer=Hand	</C>
            ">
					</OBJECT></comment><script>__ws__(__NSID__);</script>
        </td>
        <TD align=left>
                
					<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:382px;height:382px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
            <tr>
							<td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;발령코드</td>                        
              <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
								<input id="txt_ordcd" name="txt_ordcd"  class="txtbox" type="text" style="width:260px;" maxlength="2" onBlur="bytelength(this,this.value,2);">&nbsp;</nobr>
							</td>
            </tr>
            <tr>
              <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;발령코드명</td>   
              <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
								<input id="txt_ordnm" name="txt_ordnm"  class="txtbox" type="text" style="width:260px;" maxlength="30" onBlur="bytelength(this,this.value,30);">&nbsp;</nobr>
							</td>
            </tr>
            <tr>
              <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;적용항목</td>
              <td style="border:0 solid #708090;border-bottom-width:1px;">
								<nobr>&nbsp;
								<input id="txt_chkitem" name="txt_chkitem"  class="txtbox" type="text"  style="width:260px;" maxlength="8" onBlur="bytelength(this,this.value,8);">&nbsp;</nobr>
								</td>
            </tr>
            <tr>
              <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;발령구분</td>                        
              <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
								<input id="txt_orddiv" name="txt_orddiv" class="txtbox"  type="text"  style="width:260px;" maxlength="1" onBlur="bytelength(this,this.value,1);">&nbsp;</nobr>
							</td>
            </tr>
						<tr>
              <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;사용유무</td>                        
              <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
								<input name="txt_useyn2" type="checkbox"  style="width:15px;" onclick="ln_Chkbox(this,'USEYN')">&nbsp;</nobr>
							</td>
            </tr>
            <tr>
              <td colspan=4 style="height:100%;border:0 solid #708090;" >&nbsp;</td>
            </tr>
					</table>
        </TD>
			</tr>
		</table>
  </td>
 </tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=875>
	<tr><td height=10></td></tr>
	 <tr>
		<td height="24">조회건수 : <label id="lbl_search2"></label></td>
	 </tr>
</table>
</div>

<div id="div_holiday" style="display:none">
  <table width="875" cellpadding="1" cellspacing="0" border="0">
		<tr><td height=13></td></tr>
    <tr> 
			<td colspan=8 align=center>

				<table width="846" cellpadding="1" cellspacing="0" border="0" style='position:relative;top:-3px;width:846px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr>
						<td align=LEFT  style="border:0 solid #708090;border-right-width:1px;width:30px;height:22px" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp; 휴일 년도&nbsp;&nbsp;</nobr></td>
						<td width="0" align=LEFT ><nobr>
							<comment id="__NSID__"><object id=gcem_bundle classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:30px;position:relative;left:5px;top:2px" class="txtbox" >
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=Format        value="YYYY">
								<param name=ClipMode      value=true>
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
							&nbsp;</td>
					
						<td width="0" align=RIGHT ><nobr ><!--회사휴일--></nobr></td>
            <td width=100%>&nbsp;</td>
            <td><nobr>
						<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:-69px;right:2px;left:0" onClick="ln_Delete3()">
							<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:-69px;right:2px;left:0" onClick="ln_Add3()">
							<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:-69px;right:2px;left:0" onClick="ln_Save3()">
							<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:-69px;right:2px;left:0" onClick="ln_Query3()">
							</nobr>
						</td>
          </tr>
        </table>
      </td>
    </tr>
    <tr><td align=center valign=middle>
      <table width="847" cellpadding="1" cellspacing="0" border="0" style='position:relative;top:-3px;'>
        <tr> 
          <td style="width:847" align=center>
            <comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_holiday  style="WIDTH: 460px; HEIGHT: 380px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"        VALUE="gcds_holiday">
              <PARAM NAME="Editable"			VALUE="false">
              <PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM name="Fillarea"      VALUE="true">
              <PARAM NAME="Format"        VALUE="  
                <C> Name='휴일일자'	ID=HOLDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=CENTER	Mask='XXXX/XX/XX'</C> 
                <C> Name='요일'			ID=WHATDAY	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=CENTER	EditStyle=Lookup Data='gcds_whatday:MINORCD:MINORNM'</C> 
                <C> Name='휴일내용'	ID=HOLNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=LEFT	</C> 
                <C> Name='구분'			ID=HOLDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=78		align=CENTER	EditStyle=Lookup Data='gcds_holdiv:MINORCD:MINORNM'</C> 
              ">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
          </td>
          <TD align=left>
            
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:382px;height:382px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
							<tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#B9D4DC" align=center class="txtbox" >&nbsp;휴일 일괄생성</td>        
                <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px;" colspan=3><nobr>&nbsp;
									<comment id="__NSID__"><object id=gclx_weekday classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:1px; width:30px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="YYYY">
										<param name=MaxLength     value=8>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;
									
									<img src="../../Common/img/btn/com_b_total.gif"		style="cursor:hand;position:relative;top:2px;right:2px;left:0" onClick="ln_TimeCalculate()">&nbsp;
									<!-- <img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand;position:relative;top:2px;right:2px;left:-7" onClick="ln_DelBatch()"> -->
									</nobr>
								</td>
              </tr>
              <tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;년/월/일</td>        
                <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
									<comment id="__NSID__"><object id=tb_HOLDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1validFeatures="ignoreStatus=yes" validExp="">
										<PARAM NAME="DataID"			VALUE="gcds_holiday">
										<param name=Text          value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="YYYY/MM/DD">
										<param name=MaxLength     value=8>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;
									
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('tb_HOLDT', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">&nbsp;</nobr>
								</td>
              </tr>
              <tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >요&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;일</td>
                <td style="border:0 solid #708090;border-bottom-width:1px;">&nbsp;
									<comment id="__NSID__"><object id=gclx_whatday classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=120 style="position:relative;left:5px" class="txtbox" >
										<param name=ComboDataID			value=gcds_whatday>
										<param name=SearchColumn		value="MINORNM">
										<param name=Sort						value="MINORCD">
										<param name=ListExprFormat	value="MINORNM^0^95">
										<param name=BindColumn			value="MINORCD">
									</object></comment><script>__ws__(__NSID__);</script>
                </td>
              </tr>
              <tr>
								<td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;휴일내용</td>
                <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<input id="txt_holnm" name="txt_holnm" type="text"   class="txtbox" style="width:260px;position:relative;left:5px;" maxlength="20" onBlur="bytelength(this,this.value,20);" >&nbsp;</nobr></td>
              </tr>
              <tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;휴일구분</td>        
                <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;&nbsp;</nobr>
									<comment id="__NSID__"><object id=gclx_holdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=120 class="txtbox" >
										<param name=ComboDataID			value=gcds_holdiv>
										<param name=SearchColumn		value="MINORNM">
										<param name=Sort						value="MINORCD">
										<param name=ListExprFormat	value="MINORNM^0^116">
										<param name=BindColumn			value="MINORCD">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
              </tr>
              <tr>
                <td colspan=4 style="height:100%;border:0 solid #708090;" >&nbsp;
                </td>
              </tr>
            </table>
          </TD>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=875>
	<tr><td height=10></td></tr>
	 <tr>
		<td height="24">조회건수 : <label id="lbl_search3"></label></td>
	 </tr>
</table>
</div>

<div id="div_special" style="display:none">
  <table width="875" cellpadding="1" cellspacing="0" border="0">
		<tr><td height=13></td></tr>
    <tr> 
			<td colspan=8 align=center>

				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr> 
						<td width="0" align=RIGHT ><nobr ><!--특근수당--></nobr></td>
            <td width=100%>&nbsp;</td>
            <td><nobr>      
							<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:-71px;right:2px;" onClick="ln_Delete4()">
							<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:-71px;right:2px;" onClick="ln_Add4()">
							<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:-71px;right:2px;" onClick="ln_Save4()">
							<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:-71px;right:2px;" onClick="ln_Query4()">  
							</nobr>
						</td>
          </tr>
        </table>
      </td>
    </tr>
    <tr><td align=center valign=middle>
      
			<table width="847" cellpadding="1" cellspacing="0" border="0">
        <tr> 
          <td style="width:847" align=center>
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_special  style="WIDTH: 460px; HEIGHT: 380px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"          VALUE="gcds_special">
              <PARAM NAME="Editable"				VALUE="false">
              <PARAM NAME="BorderStyle"			VALUE="0">
							<PARAM name="Fillarea"				VALUE="true">
              <PARAM NAME="Format"          VALUE="  
                <C> Name='근태코드' ID=LAZCD			HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=CENTER</C> 
                <C> Name='근태명칭' ID=LAZFEENM   HeadAlign=Center HeadBgColor=#B9D4DC Width=127	align=LEFT</C> 
                <C> Name='수당구분' ID=ALWCON			HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=CENTER value={decode(ALWCON,1,'시급',2,'일급',3,'회차',4,'무급')}</C> 
                <C> Name='금액'			ID=AMT				HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=RIGHT</C>
								<C> Name='비고'			ID=MEMO				HeadAlign=Center HeadBgColor=#B9D4DC Width=119	align=CENTER</C>
                ">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
          </td>
          <TD align=left>
                
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:382px;height:382px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
              <tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;근태코드</td>
                <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
									<input id="txt_lazcd" name="txt_lazcd"  class="txtbox" type="text" style="width:260px;" maxlength="4" onBlur="bytelength(this,this.value,4);">&nbsp;</nobr>
								</td>
              </tr>
              <tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;근태명칭</td>                        
                <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=3><nobr>&nbsp;
									<input id="txt_lazfeenm" name="txt_lazfeenm"  class="txtbox" type="text" style="width:260px;" maxlength="20" onBlur="bytelength(this,this.value,20);">&nbsp;</nobr>
								</td>
              </tr>
              <tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;수당구분</td>
                <td style="border:0 solid #708090;border-bottom-width:1px;">&nbsp;
									<select id=sel_alwcon  style="width:100px;" class="txtbox" >
										<option value></option>
										<option value=1>시급</option>
										<option value=2>일급</option>
										<option value=3>회차</option>
										<option value=4>무급</option>
									</select>
								</td>
              </tr>
              <tr>
                <td style="height:30px;width:260px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;금&nbsp;&nbsp;&nbsp;&nbsp;액</td>        
                <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:5px;" class="txtbox" >
										<PARAM name="DataID"			value="gcds_special">								
										<param name=Text					value="">
										<param name=Alignment     value=2>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=true>
										 <param name=IsComma			value=true>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>
									<!-- <input id="gcem_amt" name="gcem_amt" type="text" style="width:157px;" maxlength=16 > -->&nbsp;</nobr>
								</td>
              </tr>
							<tr>
                <td style="height:30px;width:100px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;비&nbsp;&nbsp;&nbsp;&nbsp;고</td>        
                <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<input id="txt_memo" name="txt_memo"  class="txtbox" type="text" style="width:260px;" maxlength="20" onBlur="bytelength(this,this.value,20);">&nbsp;</nobr>
								</td>
              </tr>
              <tr>
                <td colspan=4 style="height:100%;border:0 solid #708090;" >&nbsp;</td>
              </tr>
            </table>
								</TD>
							</tr>
						</table>
					</td>
				</tr>
			</table>
<table border=0 cellpadding=0 cellspacing=0 width=875>
	<tr><td height=10></td></tr>
	<tr>
		<td height="24">조회건수 : <label id="lbl_search4"></label></td>
	</tr>
</table></div>
    <td>
	</tr>
</table>

<comment id="__NSID__"><object id=gcbn_zipcode classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 disabled> 
    <param name=DataID    value=gcds_zipcode><!--우편번호-->
    <param name=BindInfo  value='
				
        <C>Col=ZIPCD			Ctrl=gcem_zipcd						Param=text</C>
        <C>Col=SIDO				Ctrl=txt_sido							Param=value</C>
        <C>Col=GUGUN			Ctrl=txt_gugun						Param=value</C>
        <C>Col=DONG				Ctrl=txt_dong							Param=value</C>
				<C>Col=BUNJI			Ctrl=txt_bunji						Param=value</C>
    '>
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcbn_sendal classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 disabled> 
    <param name=DataID    value=gcds_sendal><!--발령코드-->
    <param name=BindInfo  value='
        <C>Col=ORDCD			Ctrl=txt_ordcd						Param=value</C>
        <C>Col=ORDNM			Ctrl=txt_ordnm						Param=value</C>
        <C>Col=CHKITEM		Ctrl=txt_chkitem					Param=value</C>
        <C>Col=ORDDIV			Ctrl=txt_orddiv						Param=value</C>
				<C>Col=USEYN			Ctrl=txt_useyn2						Param=value</C>
    '>
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcbn_holiday classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 disabled> 
    <param name=DataID    value=gcds_holiday><!--회사휴일-->
    <param name=BindInfo  value='

        <C>Col=HOLDT			Ctrl=tb_HOLDT 						Param=text</C>
        <C>Col=WHATDAY		Ctrl=gclx_whatday					Param=BindColVal</C>
        <C>Col=HOLNM			Ctrl=txt_holnm						Param=value</C>
        <C>Col=HOLDIV			Ctrl=gclx_holdiv					Param=BindColVal</C>
    '>
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcbn_special classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 disabled> 
    <param name=DataID    value=gcds_special><!--특근수당-->
    <param name=BindInfo  value='
        <C>Col=LAZCD			Ctrl=txt_lazcd						Param=value</C>
        <C>Col=LAZFEENM		Ctrl=txt_lazfeenm					Param=value</C>
        <C>Col=ALWCON			Ctrl=sel_alwcon						Param=value</C>
        <C>Col=AMT				Ctrl=gcem_amt							Param=text</C>
				<C>Col=MEMO				Ctrl=txt_memo							Param=value</C>
    '>
</object></comment><script>__ws__(__NSID__);</script>

<div class=page id="out_line" style="position:absolute; left:4; top:68; width:875; height:438;z-index:-1;">&nbsp;</div>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 

</body>
</html>