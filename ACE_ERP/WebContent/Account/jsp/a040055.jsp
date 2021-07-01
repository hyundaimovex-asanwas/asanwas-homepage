<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	세금계산서관리/매입매출등록
+ 프로그램 ID	: A040001
+ 기 능 정 의	: 조회|등록|저장|삭제|출력
+ 최 초 이 력	: 이순미
+ 서 블 릿 명	: a040001_s1,a040001_s2,a040001_s3,
								a040001_s4,a040001_t1,a040001_t2,
                taxcdnbr_s1,commdtil_s1,vendcode_s1,atcode_s1
-----------------------------------------------------------------------------
+ 수 정 내 용 :	부가세관리 지점 사용  (  A040001 )           
+ 수   정  자 : 정  영  식
+ 수 정 일 자 :  2007.10.18
+ 서 블 릿 명	:

-----------------------------------------------------------------------------
+ 수 정 내 용 :	전자세금계산서 연동시 거래처별 담당자의 정보 수록 
              : ATTAXMST 에 SEQ 추가함. 
+ 수   정  자 : 정  영  식
+ 수 정 일 자 :  2009.06.18
+ 서 블 릿 명	:
-----------------------------------------------------------------------------
+ 수 정 내 용 :	전자세금계산서 수정세금계산서 반영을 위한 코드 추가
                        전자세금계산서 발행과 전자세금계산서 아닌 것으로 발행한 세금계산서 구분자 추가
          : ATTAXMST : GUBUN VARDHAR(1) 
			           AMEND_CODE VARCHAR(2)
				  	   AMEND_REMARK VARCHAR(100)
+ 수   정  자 : 정  영  식
+ 수 정 일 자 :  2009.12.04
+ 서 블 릿 명	:
-----------------------------------------------------------------------------
+ 수 정 내 용 :	외부시스템 매출발행 추가  
              : ATTAXMST : EXTCHK CHAR(1)  외부시스템발행 
+ 수   정  자 : 정  영  식
+ 수 정 일 자 : 2010.08.24
+ 서 블 릿 명	:
-----------------------------------------------------------------------------
+ 수 정 내 용 :	비고추가 
              : ATTAXMST : REMARK2 VARCHAR(150)  비고2  // REMARK3 VARCHAR(150) 비고3 은 예비용으로 추가함
+ 수   정  자 : 정  영  식
+ 수 정 일 자 : 2010.12.01
+ 서 블 릿 명:
-----------------------------------------------------------------------------
+ 수 정 내 용 :	종사업장번호 추가 ( 공급자, 공급받는자 )
              : ATTAXMST : S_BIZPLACE(공급자 사업장번호), B_BIZPLACE(공급받는자 사업장번호) VARCHAR(4)
+ 수   정  자 : 정  영  식
+ 수 정 일 자 : 2010.12.02
+ 서 블 릿 명:
-----------------------------------------------------------------------------
+ 수 정 내 용 :	종사업장 추가 ( 양양공항 면세점 0002 ) 
              :
+ 수   정  자 : 정  영  식
+ 수 정 일 자 : 2011.07.25
+ 서 블 릿 명	:
-----------------------------------------------------------------------------
+ 수 정 내 용 :	수정세금계산서 코드 추가 ( 06 - 착오에 의한 이중발급 ) 
+ 수   정  자 : 정  영  식
+ 수 정 일 자 : 2011.11.24
+ 서 블 릿 명	:
-----------------------------------------------------------------------------
+ 수 정 내 용 :	매입등록시 수정 : 과세, 불공, 영세 - 전자발행, 면세,신용카드,현금영수증 - 수기발행을 기본설정으로 함.  
+ 수   정  자 : 정  영  식
+ 수 정 일 자 : 2012.02.06
+ 서 블 릿 명 :
-----------------------------------------------------------------------------
+ 수 정 내 용 :	DB2 >> Oracle 변경  
+ 수   정  자 : 정  영  식
+ 수 정 일 자 : 2013.12.09
+ 서 블 릿 명 :
-----------------------------------------------------------------------------
+ 수 정 내 용 :	수정세금계산서 막음.  
+ 수   정  자 : 이동훈
+ 수 정 일 자 : 2014.04.01
+ 서 블 릿 명 :
-----------------------------------------------------------------------------
+ 수 정 내 용 :	원가코드 추가   
+ 수   정  자 : 정  영  식
+ 수 정 일 자 : 2014.04.10
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>매입매출등록</title>

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

gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var cuserid = gusrid;		
var g_fdcod = gfdcode;	//지점코드
var g_deptcd = gdeptcd;	//부서코드
var g_deptnm =gdeptnm;
var g_usrnm  = gusrnm;
var setchk = "T";
var gs_empno = "";
var gs_userid = gusrid;
var g_ceoname="";

//&&2008.05.21 추가
var g_numgb =""; //계산서번호 구분자 
var g_gb ="";    //매입 /매출 A-매입, B-매출 

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
 
	ln_DispChk(0);
	ln_Before();	//선조회
	ln_Header();
	ln_Add('1');	//매입 등록
	ln_Add2('1');	//매출 등록

	g_gb ="A";//매입
    g_numgb = ln_Taxnbr_Gb(gfdcode);
	gclx_buy.bindcolval ="Y";

	ln_Display_Cocode(); //종사업장번호 display
	ln_Taxknd_Chg();

	if(gcds_bizplace.namevalue(gcds_bizplace.rowposition,"GBCD")=="A"){
		gclx_cocode2.Enable =true;
	}
}

/******************************************************************************
	Description : 기본조회 - 매입    매입매입매입
	Parameter   : e :  1 - MST, 2-상세
******************************************************************************/
function ln_Query(e){
  gcem_staxnbr.Enable	= true;
	if (e=="1") { //매입MST
		var str1 = gclx_fdcode.BindColVal;
		var str2 = gcem_staxnbr.text;
		var str3 = gclx_worktype.bindcolval;
		var str4 = gs_userid;	//로그인
		var str5 = "";	
    
		if (str4 =="6070001"||str4 =='2050053'||str4=='2020009') { //전체조회
			str5 = "1";  
		}else  {
			str5 = "2";
		}
		
	
		if (fn_trim(str2) != "") {
		  	//&&2008.05.21 추가
			//str2 = "A" + str2; 
			str2 = g_numgb + str2;

			gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_s1_ee_A2?v_str1="+str1
																					   +"&v_str2="+str2
																					   +"&v_str3="+str3
																					   +"&v_str4="+str4
																					   +"&v_str5="+str5;
			gcds_data1.Reset();
		}else { 
			alert("계산서번호를 입력해 주십시오."); 
			gcem_staxnbr.focus();
			gcds_data2.ClearData();
			return false; 
		}
	}else if(e=="2") { //매입상세
		var str1_2 = gcem_taxnbr.text;  //매입mst에서 조회한 데이타를 가져옴.
		var row = gcds_data2.rowposition;
		if (fn_trim(str1_2) != "") { 
			//&&gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_s2?v_str1="+str1_2;
			gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_s2?v_str1="+str1_2;
			///prompt('매입상세',gcds_data2.DataID);
			gcds_data2.Reset(); 
      
			gcds_empno.DeleteRow(1);
			gcds_empno.InsertRow(1);
			gcds_empno.NameValue(1,"EMPNO")=gcds_data2.namevalue(row,"EMPNO") ;
			gcds_empno.NameValue(1,"EMPNMK")=gcds_data2.namevalue(row,"EMPNMK") ;

			gcds_dept.DeleteRow(1);
			gcds_dept.InsertRow(1);
			gcds_dept.NameValue(1,"DEPTNM")=gcds_data2.namevalue(row,"DEPTNM") ;
			gcds_dept.NameValue(1,"DEPTCD")=gcds_data2.namevalue(row,"DEPTCD") ;
		}	
	}else if(e.substring(0,1) =="A") {

		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_s1_ee_A2?v_str2="+e;
		///prompt('?????뭘까?==>저장 후 조회 하는 로직이더군...',gcds_data1.DataID);
		gcds_data1.Reset();
	}
}

/******************************************************************************
	Description : 기본조회- 매출
	Parameter   : e :  1 - MST, 2-상세
******************************************************************************/
function ln_Query2(e){ 
	gcem_staxnbr2.Enable	= true;
	if (e=="1") {
		var str1 = gclx_fdcode2.BindColVal;
		var str2 = gcem_staxnbr2.text;
		var str3 = gclx_worktype2.bindcolval;
		var str4 = gs_userid;	//로그인
		var str5 = "";	

		if (str4 =="6070001"||str4 =='2050053'||str4=='2020009') {
			str5 = "1";
		}else  {
			str5 = "2";
		}

		if (str2 != "") {
			//2008.05.21 정영식 수정
			//str2 = "B" + str2;
			str2 = g_numgb + str2;
		    gcds_data1_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_s1_ee_A2?v_str1="+str1
																								   +"&v_str2="+str2
																													 +"&v_str3="+str3
																													 +"&v_str4="+str4
																													 +"&v_str5="+str5;

			//prompt('매출:::',gcds_data1_2.DataID);
			gcds_data1_2.Reset(); 
		}else { 
			alert("계산서번호를 입력해 주십시오.");
			gcem_staxnbr2.focus();
			gcds_data2_2.ClearData();
			return false; 
		}
	}else if(e=="2") { //매출상세
		var row = gcds_data1_2.rowposition;
		var str1_2 = gcem_taxnbr2.text;
		if (str1_2 != "") { 
			gcds_data2_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_s2?v_str1="+str1_2;
			///prompt('매출상세',gcds_data2_2.DataID);
			gcds_data2_2.Reset(); 
		}
	}else if(e.substring(0,1) =="B") {

		gcds_data1_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_s1_ee_A2?v_str2="+e;
		///prompt('매출뭘까?',gcds_data1_2.DataID);
		gcds_data1_2.Reset();
	}
}

/******************************************************************************
	Description : 저장 후 조회 - 매입
******************************************************************************/
function ln_QuerySuc1(e){
	if(fn_trim(e)=="") return;	
	var str1 = gclx_fdcode.bindcolval;
	var str3 = gclx_worktype.bindcolval;

    gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_s1_ee_A2?v_str1="+str1
										+"&v_str2="+e+"&v_str3="+str3;
	//prompt('',gcds_data1.DataID);
	gcds_data1.Reset();
}

/******************************************************************************
	Description : 저장 후 조회 - 매출
******************************************************************************/
function ln_QuerySuc2(e){
	if(fn_trim(e)=="") return;	
	var str1 = gclx_fdcode2.bindcolval;
	var str3 = gclx_worktype2.bindcolval;
 
	gcds_data1_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_s1_ee_A2?v_str1="+str1
										  + "&v_str2="+e+"&v_str3="+str3;

    //prompt('',gcds_data1_2.DataID);
	gcds_data1_2.Reset(); 
}

/******************************************************************************
	Description : Max 계산서번호 조회
******************************************************************************/
function ln_Query4(e){
	//e : 매입[A]/매출[B]
  
	/***
  @@ 2008.05.21 정영식 의미 없어서 막음. 
	gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_s3?v_str1="+e+gs_date2;
	prompt('gcds_data3.DataID:::',gcds_data3.DataID);
	gcds_data3.Reset();
  ***/
}																														

/******************************************************************************
	Description : 추가 - 매입   e : 1 등록, e : 2 행추가 
******************************************************************************/
function ln_Add(e){
  //alert("매입:::e::"+e);
	var obj = eval("gcds_data"+e);
	var row1 = gcds_data1.rowposition;
	var row2 = gcds_data2.rowposition;
	if (gcem_fsdat.text == ""){ 
		if (e=='1') { // 전체등록
//		alert("test1");
			gcds_data11.ClearData();
			gcds_data1.AddRow();
			gcds_data11.AddRow();
			gcds_data2.ClearData();
			
			txt_fixprop.value	=	"";
			txt_fixpropnm.value	=	"";
			txt_fixpropnm_cnt.value	=	"";
			
			gclx_worktype.bindcolval = "A";				//회계구분
			gclx_taxprtyn.bindcolval = "N";				//발행여부
			gclx_taxdiv.bindcolval	 = "0001";		//귀속구분
			gclx_taxknd.bindcolval	 = "1";				//부가세종류
			//gclx_actcode1.bindcolval = "2100101";		//오브젝트 변경후 사용안함(선택하도록함)
			//gcem_atcode.text				 = "2100101";		
			//txt_atkornam.value			 = "외상매입금";

			gclx_cocode.bindcolval	 = "02";			//사업소
			gcem_taxdat.text				 = gs_date;		//접수일자
			gcem_wrdt.text					 = gs_date;		//작업일자
			gcem_staxnbr.Enable			 = false;			//계산서번호[선등록]

			ln_Rdo_Chk('1'); // 라디오버튼
			
			if (cuserid!=null&&cuserid!="ACCOUNT")  {
				gcds_empno.DeleteRow(1);
				gcds_empno.InsertRow(1);
				gcds_dept.DeleteRow(1);
				gcds_dept.InsertRow(1);

				gcds_empno.NameValue(1,"EMPNO")=cuserid;
				gcds_empno.NameValue(1,"EMPNMK")=gusrnm;
				gcds_dept.NameValue(1,"DEPTCD")=g_deptcd;
				gcds_dept.NameValue(1,"DEPTNM")=g_deptnm;

				gclx_empno.index=0;
				gclx_dept.index=0;	
			}else{
			  /*
				gcds_empno.NameValue(1,"EMPNO")="1990054";
				gcds_empno.NameValue(1,"EMPNMK")="권정교";
				gcds_dept.NameValue(1,"DEPTCD")="C220";
				gcds_dept.NameValue(1,"DEPTNM")="재무팀";
				gclx_empno.index=0;
				gclx_dept.index=0;
		    */
			}

			if (g_fdcod!=null)	{
				gclx_fdcode.bindcolval = g_fdcod;	//지점
			}else{
				gclx_fdcode.index=1;
			}
			gclx_empno.enable	= false;
			var strdat = gcem_taxdat.text;
			if (strdat.substring(4,6) >='01' || strdat.substring(4,6) <='03') {
				gcds_data1.namevalue(gcds_data1.rowposition,"TAXKIDIV") = "1";	//기수[1]
			}else if(strdat.substring(4,6) >='04' || strdat.substring(4,6) <='06') {
				gcds_data1.namevalue(gcds_data1.rowposition,"TAXKIDIV") = "2";	//기수[2]
			}else if(strdat.substring(4,6) >='07' || strdat.substring(4,6) <='09') {
				gcds_data1.namevalue(gcds_data1.rowposition,"TAXKIDIV") = "3";	//기수[3]
			}else if(strdat.substring(4,6) >='10' || strdat.substring(4,6) <='12') {
				gcds_data1.namevalue(gcds_data1.rowposition,"TAXKIDIV") = "4";	//기수[4]
			}

			gcds_data1.namevalue(row1,"TAXIODIV") =  "A";	//계산서구분 A-매입, B-매출

		}else if (e=='2') { //상세 행추가 
			gcds_data2.AddRow();
//			alert("test4");
			gclx_empno.index=0;

			var cnt2  = gcds_data2.countrow;
			var taxmm = gcds_data1.namevalue(row1,"TAXDAT");
			var taxdt = gcds_data1.namevalue(row1,"TAXDAT");
			gcds_data2.namevalue(cnt2,"TAXNBR") = gcds_data1.namevalue(row1,"TAXNBR");
			gcds_data2.namevalue(cnt2,"TAXMM")  = taxmm.substring(4,6);
			gcds_data2.namevalue(cnt2,"TAXDT")  = taxdt.substring(6,8);
		}
	}else{
		alert("전표가 발행된 건은 등록하실수 없습니다.");
		return false;
	}
}

/******************************************************************************
	Description : 추가 - 매출   e : 1 등록, e : 2 행추가 
******************************************************************************/
function ln_Add2(e){
  //alert("매출:::e::"+e);
	var obj = eval("gcds_data"+e+"_2");
	var row1 = gcds_data1_2.rowposition;
	var row2 = gcds_data2_2.rowposition;

	if (gcem_fsdat2.text == ""){ 
		if (e=='1') {
			gcds_data1_2.AddRow();
			gcds_data22.ClearData();
			gcds_data22.AddRow();

			gcds_data2_2.ClearData();

			gclx_worktype2.bindcolval = "A";			//회계구분
			gclx_taxdiv2.bindcolval	 = "0001";		//귀속구분
			gclx_taxknd2.bindcolval	 = "1";				//부가세종류
			//gclx_actcode2.bindcolval  = "1110601";	////오브젝트 변경후 사용안함(선택하도록함)
			//gcem_atcode2.text				 = "1110601";		
			//txt_atkornam_2.value		 = "외상매출금";
			gclx_taxprtyn2.bindcolval = "N";				//발행여부
			gclx_taxtype2.bindcolval  = "N";				//발행구분
			gclx_cocode2.bindcolval		= "02";				//사업소
			gcem_taxdat2.text					= gs_date;		//접수일자
			gcem_wrdt2.text						= gs_date;		//작업일자
			gcem_lastprt2.text				= gs_date;		//최종출력일
			gcem_staxnbr2.Enable			= false;			//계산서번호

			ln_Rdo_Chk('3');

			if (cuserid!=null&&cuserid!="ACCOUNT")  {
				gclx_empno2.bindcolval = cuserid;	//담당자
			}else{
				gclx_empno2.index=0;
			}

			if (gdeptcd!=null)	{
				gclx_dept2.bindcolval = gdeptcd;	//담당부서
			}else{
				gclx_dept2.index=0;
			}

			if (g_fdcod!=null)	{
				gclx_fdcode2.bindcolval = g_fdcod;	//지점
			}else{
				gclx_fdcode2.index=1;
			}

			gclx_empno2.enable	= false;

			var strdat = gcem_taxdat2.text;
			if (strdat.substring(4,6) >='01' || strdat.substring(4,6) <='03') {
				gcds_data1_2.namevalue(gcds_data1_2.rowposition,"TAXKIDIV") = "1";	//기수[1]
			}else if(strdat.substring(4,6) >='04' || strdat.substring(4,6) <='06') {
				gcds_data1_2.namevalue(gcds_data1_2.rowposition,"TAXKIDIV") = "2";	//기수[2]
			}else if(strdat.substring(4,6) >='07' || strdat.substring(4,6) <='09') {
				gcds_data1_2.namevalue(gcds_data1_2.rowposition,"TAXKIDIV") = "3";	//기수[3]
			}else if(strdat.substring(4,6) >='10' || strdat.substring(4,6) <='12') {
				gcds_data1_2.namevalue(gcds_data1_2.rowposition,"TAXKIDIV") = "4";	//기수[4]
			}

			gcds_data1_2.namevalue(row1,"TAXIODIV") =  "B";	//계산서구분  A-매입, B-매출

			//2010.08.24 JYS 외부시스템 매출발행 
			chk_ext.checked=false;

		}else if (e=='2') {
			gcds_data2_2.AddRow();
			var cnt2  = gcds_data2_2.countrow;
			var taxmm = gcds_data1_2.namevalue(row1,"TAXDAT");
			var taxdt = gcds_data1_2.namevalue(row1,"TAXDAT");
			gcds_data2_2.namevalue(cnt2,"TAXNBR") = gcds_data1_2.namevalue(row1,"TAXNBR");
			gcds_data2_2.namevalue(cnt2,"TAXMM")  = taxmm.substring(4,6);
			gcds_data2_2.namevalue(cnt2,"TAXDT")  = taxdt.substring(6,8);
			if (cuserid!=null&&cuserid!="ACCOUNT")  {
				gclx_empno2.bindcolval = cuserid;	//담당자
			}else{
				gclx_empno2.index=0;
			}
		}
	}else{
		alert("전표가 발행된 건은 등록하실수 없습니다.");
		return false;
	}
}

/******************************************************************************
	Description : 달력함수
******************************************************************************/
var __calendarRtn; // return할 변수, 문자열배열(4) { 연도, 월, 일, 연월일 }
function ln_CallCalendar(){ // 모달팝업 호출 함수
	__calendarRtn = window.showModalDialog("../../Common/html/com_calender.htm","","dialogWidth:180px;dialogHeight:230px;scroll:no;status:no;titlebar:no;center:yes;help:yes;");
}

//===== 개체에 날짜선택 모달팝업에서 얻은 값 넣기 =====
//----- 한 개체에 넣기
function ln_GetCallCalendar(objNameHead, objValueProp){
	ln_CallCalendar();

	var ls_date = gcem_taxdat.text;
	var ls_date2 = gcem_taxdat2.text;

//	alert(ls_date);

	if (__calendarRtn!=null && __calendarRtn.length>=4 ){
		eval( objNameHead+"."+objValueProp+" = __calendarRtn[3];" );
		__calendarRtn=null;
	}

//alert(gcem_taxdat.text);
	if (ls_date!=gcem_taxdat.text){

		var ls_taxmm= gcem_taxdat.text;
	//alert(ls_taxmm);
	//alert(ls_taxmm.substring(4,6));
	//gcem_taxmm.text=ls_taxmm.substring(4,6);
		gcem_taxmm.text=ls_taxmm.substring(4,6);
		gcem_taxdd.text=ls_taxmm.substring(6,8);

	} else if (ls_date2!=gcem_taxdat2.text){

		var ls_taxmm2= gcem_taxdat2.text;
	//alert(ls_taxmm);
	//alert(ls_taxmm.substring(4,6));
	//gcem_taxmm.text=ls_taxmm.substring(4,6);
		gcem_taxmm2.text=ls_taxmm2.substring(4,6);
		//alert(gcem_taxmm2.text);
		gcem_taxdd2.text=ls_taxmm2.substring(6,8);
		//alert(gcem_taxdd2.text);

	}

}

/******************************************************************************
	Description : 합계(공급가액+부가세액) - 매입
******************************************************************************/
function ln_TaxSum1(){
  
	///alert("ln_TaxSum1::::");

	var row = gcds_data2.rowposition;	//세부내역 합계[매입]
	var row1 = gcds_data1.rowposition;
	var v_taxsum = 0;
	var v_taxvat = 0;
	var v_taxtot = 0;
	for(var i=1;i<=gcds_data2.countrow;i++){
		v_taxsum += gcds_data2.namevalue(i,"TAXSUM");
		v_taxvat += gcds_data2.namevalue(i,"TAXVATAMT");
	}
		v_taxtot =  v_taxsum+v_taxvat;
		gcds_data1.namevalue(row1,"TAXSUM")    = v_taxsum;
		gcds_data1.namevalue(row1,"TAXVATAMT") = v_taxvat;
		gcds_data1.namevalue(row1,"TAXTOT")    = v_taxtot;

    //alert("ln_TaxSum1::v_taxtot::" +v_taxtot);

		//gcds_data2.namevalue(row,"TAXTOT2")    = v_taxtot;
}

/******************************************************************************
	Description : 합계(공급가액+부가세액) - 매출
******************************************************************************/
function ln_TaxSum2(e,e1,e2){
	var row = gcds_data2_2.rowposition;	//세부내역 합계[매출]
	var row1 = gcds_data1_2.rowposition; 
	var v_taxsum = 0;
	var v_taxvat = 0;
	var v_taxtot = 0;
	for(var i=1;i<=gcds_data2_2.countrow;i++){
		v_taxsum += gcds_data2_2.namevalue(i,"TAXSUM");
		v_taxvat += gcds_data2_2.namevalue(i,"TAXVATAMT");
	}
		v_taxtot =  v_taxsum+v_taxvat;
		gcds_data1_2.namevalue(row1,"TAXSUM")    = v_taxsum;
		gcds_data1_2.namevalue(row1,"TAXVATAMT") = v_taxvat;
		gcds_data1_2.namevalue(row1,"TAXTOT")    = v_taxtot;
		gcds_data2_2.namevalue(row,"TAXTOT2")    = v_taxtot;
}

/******************************************************************************
	Description : 저장 - 매입
******************************************************************************/
function ln_Save(e){
	
	////ln_Query4('A');
	//&& 2008.05.21.의미 없어서 막음.   ln_Query4(g_gb);

	var obj  = eval("gcds_data"+e);
	var row1 = gcds_data1.rowposition;
	var row2 = gcds_data2.rowposition;

	gcds_taxnbr.ClearAll();

	///alert("gcds_data1.IsUpdated::"+gcds_data1.IsUpdated);
	///alert("row1::"+row1+"SysStatus:::"+ gcds_data1.SysStatus(row1));

	//2009.12.04 jys 전자발행구분 변경시 bind처리////////////////////////////////////
	if(gcds_data1.namevalue(row1,"GUBUN")!=""){
		if(gcds_data1.namevalue(row1,"GUBUN")=="1"&&rdo_gubun1_2.checked==true){
			gcds_data1.namevalue(row1,"GUBUN")="2";
		}else if(gcds_data1.namevalue(row1,"GUBUN")=="2"&&rdo_gubun1_1.checked==true){
			gcds_data1.namevalue(row1,"GUBUN")="1";
		}
	}
	/////////////////////////////////////////////////////////////////////////////////
  

	if(!gcds_data1.IsUpdated && !gcds_data2.IsUpdated) {
		alert("저장하실 정보가 없습니다.");
	}else if(gcds_data1.IsUpdated && gcds_data2.IsUpdated && gcds_data1.SysStatus(row1) == '1') { //신규입력
		if (fn_trim(gcem_fsdat.text) == ""){ 
		  ////if (!ln_Check('A'))	return false; 
			if (!ln_Check(g_gb))	return false;
				gcds_data11.namevalue(1,"COCODE")=gcds_data1.namevalue(row1,"COCODE");
				gcds_data11.namevalue(1,"DEPTCD")=gcds_data1.namevalue(row1,"DEPTCD");
				gcds_data11.namevalue(1,"EMPNO")=gcds_data1.namevalue(row1,"EMPNO");
				gcds_data11.namevalue(1,"TAXDIV")=gcds_data1.namevalue(row1,"TAXDIV");
				gcds_data11.namevalue(1,"TAXIODIV")="A";
				gcds_data11.namevalue(1,"TAXKND")=gcds_data1.namevalue(row1,"TAXKND");

				gcds_data11.namevalue(1,"VEND_CD")=gcds_data1.namevalue(row1,"VEND_CD");
				gcds_data11.namevalue(1,"TAXDAT")=gcds_data1.namevalue(row1,"TAXDAT");

				gcds_data11.namevalue(1,"TAXVATAMT")=gcds_data2.Sum(8,0,0); //gcds_data1.namevalue(row1,"TAXVATAMT");
				gcds_data11.namevalue(1,"TAXSUM")  = gcds_data2.Sum(7,0,0); 
				gcds_data11.namevalue(1,"TAXTOT")  = parseFloat(gcds_data2.Sum(7,0,0))+parseFloat(gcds_data2.Sum(8,0,0));
				
				gcds_data11.namevalue(1,"REMARK")=gcds_data1.namevalue(row1,"REMARK");
				
				//2009.12.09 jys
				//gcds_data11.namevalue(1,"TAXCDNBR")=gcds_data1.namevalue(row1,"TAXCDNBR");
				gcds_data11.namevalue(1,"TAXCDNBR")=gcem_canbr.text;
				
				gcds_data11.namevalue(1,"ATCODE")=gcds_data1.namevalue(row1,"ATCODE");
				gcds_data11.namevalue(1,"TAXPRTYN")=gcds_data1.namevalue(row1,"TAXCDNBR");
				gcds_data11.namevalue(1,"TAXCNT")=gcds_data1.namevalue(row1,"TAXCNT");
				gcds_data11.namevalue(1,"LASTPRT")=gcds_data1.namevalue(row1,"LASTPRT");

				gcds_data11.namevalue(1,"TAXTYPE")=gcds_data1.namevalue(row1,"TAXTYPE");
				gcds_data11.namevalue(1,"FSDAT")=gcds_data1.namevalue(row1,"FSDAT");
				gcds_data11.namevalue(1,"FSNBR")=gcds_data1.namevalue(row1,"FSNBR");
				gcds_data11.namevalue(1,"TAXKIDIV")=gcds_data1.namevalue(row1,"TAXKIDIV");
				gcds_data11.namevalue(1,"FDCODE")=gcds_data1.namevalue(row1,"FDCODE");

				gcds_data11.namevalue(1,"WORKTYPE")=gcds_data1.namevalue(row1,"WORKTYPE");
				gcds_data11.namevalue(1,"WRDT")=gs_date;
				gcds_data11.namevalue(1,"WRID")=gs_userid;
				
        var ddat = gcds_data11.namevalue(1,"TAXDAT").substring(4,6);
        if(ddat=="01" || ddat=="02" || ddat=="03"){
          gcds_data11.namevalue(1,"TAXKIDIV")="1";
        }else if(ddat=="04" || ddat=="05" || ddat=="06"){
          gcds_data11.namevalue(1,"TAXKIDIV")="2";
        }else if(ddat=="07" || ddat=="08" || ddat=="09"){
          gcds_data11.namevalue(1,"TAXKIDIV")="3";
        }else if(ddat=="10" || ddat=="11" || ddat=="12"){
          gcds_data11.namevalue(1,"TAXKIDIV")="4";
        }

		gcds_data11.namevalue(1,"SEQ")=gcds_data1.namevalue(row1,"SEQ");  //2009.06.18. JYS 전자세금계산서용 추가

        //2009.12.04 JYS 전자세금계산서 전자발행구분 추가
        if(rdo_gubun1_1.checked==true){
        	gcds_data11.namevalue(1,"GUBUN")="1";
		}else if(rdo_gubun1_2.checked==true){
			gcds_data11.namevalue(1,"GUBUN")="2";
		}		
		
        //alert("txt_costcd"+txt_costcd.value+"COSTCD"+gcds_data1.namevalue(row1,"COSTCD"));
		//2014.04.11 JYS 전자세금계산서 원가추가
        gcds_data11.namevalue(1,"COSTCD")=txt_costcd.value;

        ///////////////////////////////////////////////////////////////////////////////////// 
				/*var str5  = gcds_data11.namevalue(row1,"DEPTCD");		//부서코드            
				var str6  = gcds_data11.namevalue(row1,"EMPNO");			//사번                
				var str7  = "A";//gcds_data1.namevalue(row1,"TAXIODIV");	//계산서구분          
				var str8  = gcds_data11.namevalue(row1,"TAXDIV");		//귀속구분  
				var str9  = gcds_data11.namevalue(row1,"TAXKND");		//계산서종류          

				var str10 = gcds_data11.namevalue(row1,"VEND_CD");		//거래처코드          
				var str11 = gcds_data11.namevalue(row1,"TAXDAT");		//계산서일자          
				var str12 = gcds_data11.namevalue(row1,"TAXSUM");		//공급가액            
				var str13 = gcds_data11.namevalue(row1,"TAXVATAMT");	//부가세액            
				var str14 = gcds_data11.namevalue(row1,"TAXTOT");		//합계금액            
				var str15 = gcds_data11.namevalue(row1,"REMARK")+"("+gclx_taxknd.text+")";		//적요                

				var str16 = gcds_data11.namevalue(row1,"TAXCDNBR");	//신용카드번호        
				var str17 = gcds_data11.namevalue(row1,"ATCODE");		//계정코드            
				var str18 = gcds_data11.namevalue(row1,"TAXPRTYN");	//발행여부            
				var str19 = gcds_data11.namevalue(row1,"TAXCNT");		//발행횟수            
				var str20 = gcds_data11.namevalue(row1,"LASTPRT");		//최종출력일          

				var str21 = gcds_data11.namevalue(row1,"TAXTYPE");		//발행구분            
				var str22 = gcds_data11.namevalue(row1,"FSDAT");			//전표일자            
				var str23 = gcds_data11.namevalue(row1,"FSNBR");			//전표번호            
				var str24 = gcds_data11.namevalue(row1,"TAXKIDIV");	//기수구분            
				var str25 = gcds_data11.namevalue(row1,"FDCODE");		//지점코드    
				
				var str26 = gcds_data11.namevalue(row1,"WORKTYPE");	//회계구분            */
			 // var str27 = "A";	//매입[A]/매출[B]구분 
			 ///////////////////////////////////////////////////////////////////////////////////// 

				if (gcem_fsdat.text == "") {	//매입MST
					var v_taxsum = 0;
					var v_taxvat = 0;
					var v_taxtot = 0;
				
					for(var i=1;i<=gcds_data2.countrow;i++){
						v_taxsum += gcds_data2.namevalue(i,"TAXSUM");
						v_taxvat += gcds_data2.namevalue(i,"TAXVATAMT");
						var aa = gcds_data2.namevalue(i,"TAXPDTNAM");
						if(aa.length>19){
							alert("품목명은 19자까지만 입력해주세요.");
							return;
						}
					}
					
					v_taxtot =  v_taxsum+v_taxvat;
            
          			//2009.06.16 사번 체크 해야함.(전자세금계산서에서 사번이 누락된 경우 저장 안되게함)
					//gctr_data1.KeyValue   = "Account.a040001_t4(I:USER=gcds_data2,I:USER1=gcds_data11,I:USER6=gcds_insert,O:USER7=gcds_taxnbr)";
          			//&&gctr_data1.KeyValue   = "Account.a040001_t4_e(I:USER=gcds_data2,I:USER1=gcds_data11,I:USER6=gcds_insert,O:USER7=gcds_taxnbr)";        
					//gctr_data1.KeyValue   = "Account.a040001_t4_9(I:USER=gcds_data2,I:USER1=gcds_data11,I:USER6=gcds_insert,O:USER7=gcds_taxnbr)";
					///prompt('신규 gcds_data2',gcds_data2.text);   //dtl
					//prompt('신규 gcds_data11',gcds_data11.text); //mst
					///prompt('신규 gcds_insert',gcds_insert.text); //자산
										
					gctr_data1.KeyValue   = "Account.a040001_t4_ee(I:USER=gcds_data2,I:USER1=gcds_data11,I:USER6=gcds_insert,O:USER7=gcds_taxnbr)"; 
					gctr_data1.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_t4_ee";
				
					gctr_data1.Parameters = "v_str1="+ln_Taxnbr_Gb(gclx_fdcode.bindcolval);

					///alert("구분값::"+ln_Taxnbr_Gb(gclx_fdcode.bindcolval));
					gctr_data1.post();
			}

           /******
			var maxnbr2 = gcds_data3.namevalue(gcds_data3.rowposition,"CNT");
			if (maxnbr2!=null && maxnbr2!="")	{
				ln_QuerySuc1(maxnbr2);
			}
			******/
			
			
			ln_QuerySuc1(gcem_taxnbr.text);
		}else{
			alert("전표가 발행된 건은 저장하실수 없습니다.");
			return false;
		}
	
	}else{ // 매입 수정	
		//alert ("어떤 경우 발생할까?");
		if (gcem_fsdat.text==""){	//매입MST
			if (!ln_Check('A'))	return false;
			ln_TaxSum1();
			if (gcds_data2.countrow>0){	//매입DTL
				for(var i=1;i<=gcds_data2.countrow;i++){
					var aa = gcds_data2.namevalue(i,"TAXPDTNAM");
					if(aa.length>19){
						alert("품목명은 19자까지만 입력해주세요.");
						return;
					}
				}
			
                gctr_data1.KeyValue   = "Account.a040001_t2_2_ee_A2(I:USER=gcds_data2,I:USER2=gcds_data1,I:USER6=gcds_insert)";
				gctr_data1.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_t2_2_ee_A2";

				gctr_data1.Parameters = "v_str1="+gcem_taxnbr.text+",v_str2="+gs_date+",v_str3="+gusrid;
				///prompt("@gcds_data2",gcds_data2.Text);
				///prompt("@gcds_data1",gcds_data1.Text);
				///prompt("@gcds_insert",gcds_insert.Text);

				gctr_data1.post();
				ln_Query("2");
			}
			
			/******* 2008.05.21
			if (gcem_staxnbr.text=="") {
				var maxnbr2 = gcds_data3.namevalue(gcds_data3.rowposition,"CNT");
				alert("maxnbr2:::"+maxnbr2);
				if (maxnbr2!=null && maxnbr2!="")	ln_Query(maxnbr2);
			}else{
				var maxnbr_1 = ln_Taxnbr_Gb(gclx_fdcode.bindcolval)+gcem_staxnbr.text;
				ln_QuerySuc1(maxnbr_1);
			}
			******/
			var maxnbr_1 = ln_Taxnbr_Gb(gclx_fdcode.bindcolval)+gcem_staxnbr.text;
			ln_QuerySuc1(maxnbr_1);
		}else{
			alert("전표가 발행된 건은 저장하실수 없습니다.");
			return false;
		}
	}
}

/******************************************************************************
	Description : 저장 - 매출
******************************************************************************/
function ln_Save2(e){
	//@@2008.05.21  ln_Query4('B');

	//alert("매출....");

	var obj  = eval("gcds_data"+e+"_2");
	var row1 = gcds_data1_2.rowposition;
	var row2 = gcds_data2_2.rowposition;

	//2009.12.04 jys 전자발행구분 변경시 bind처리////////////////////////////////////
	if(gcds_data1_2.namevalue(row1,"GUBUN")!=""){
		if(gcds_data1_2.namevalue(row1,"GUBUN")=="1"&&rdo_gubun2_2.checked==true){
			gcds_data1_2.namevalue(row1,"GUBUN")="2";
		}else if(gcds_data1_2.namevalue(row1,"GUBUN")=="2"&&rdo_gubun2_1.checked==true){
			gcds_data1_2.namevalue(row1,"GUBUN")="1";
		}
	}
	/////////////////////////////////////////////////////////////////////////////////

	if(!gcds_data1_2.IsUpdated && !gcds_data2_2.IsUpdated) {
		alert("저장하실 정보가 없습니다.");
	}else if(gcds_data1_2.IsUpdated && gcds_data2_2.IsUpdated && gcds_data1_2.SysStatus(row1) == '1') { //신규
	     //alert("gclx_amend_code::"+gclx_amend_code.bindcolval);
	  
		if (gcem_fsdat2.text == ""){ 
			if (!ln_Check('B'))	return false;
			if (confirm("저장 하시겠습니까?")){	
				gcds_data22.namevalue(1,"COCODE")=gcds_data1_2.namevalue(row1,"COCODE");
				gcds_data22.namevalue(1,"DEPTCD")=gcds_data1_2.namevalue(row1,"DEPTCD");
				gcds_data22.namevalue(1,"EMPNO")=gcds_data1_2.namevalue(row1,"EMPNO");
				gcds_data22.namevalue(1,"TAXDIV")=gcds_data1_2.namevalue(row1,"TAXDIV");
				gcds_data22.namevalue(1,"TAXIODIV")="B";
				gcds_data22.namevalue(1,"TAXKND")=gcds_data1_2.namevalue(row1,"TAXKND");

				gcds_data22.namevalue(1,"TAXSUM")    = gcds_data2_2.sum(7,0,0);
				gcds_data22.namevalue(1,"TAXVATAMT") = gcds_data2_2.sum(8,0,0);
				gcds_data22.namevalue(1,"TAXTOT")    = parseFloat(gcds_data2_2.sum(7,0,0))+parseFloat(gcds_data2_2.sum(8,0,0));

				gcds_data22.namevalue(1,"VEND_CD")=gcds_data1_2.namevalue(row1,"VEND_CD");
				gcds_data22.namevalue(1,"TAXDAT")=gcds_data1_2.namevalue(row1,"TAXDAT");
				gcds_data22.namevalue(1,"REMARK")=gcds_data1_2.namevalue(row1,"REMARK");
				gcds_data22.namevalue(1,"TAXCDNBR")=gcds_data1_2.namevalue(row1,"TAXCDNBR");
				gcds_data22.namevalue(1,"ATCODE")=gcds_data1_2.namevalue(row1,"ATCODE");

				gcds_data22.namevalue(1,"TAXPRTYN")=gcds_data1_2.namevalue(row1,"TAXCDNBR");
				gcds_data22.namevalue(1,"TAXCNT")=gcds_data1_2.namevalue(row1,"TAXCNT");
				gcds_data22.namevalue(1,"LASTPRT")=gcds_data1_2.namevalue(row1,"LASTPRT");

				gcds_data22.namevalue(1,"TAXTYPE")=gcds_data1_2.namevalue(row1,"TAXTYPE");
				gcds_data22.namevalue(1,"FSDAT")=gcds_data1_2.namevalue(row1,"FSDAT");
				gcds_data22.namevalue(1,"FSNBR")=gcds_data1_2.namevalue(row1,"FSNBR");
				gcds_data22.namevalue(1,"TAXKIDIV")=gcds_data1_2.namevalue(row1,"TAXKIDIV");
				gcds_data22.namevalue(1,"FDCODE")=gcds_data1_2.namevalue(row1,"FDCODE");
                
				var ddat = gcds_data22.namevalue(1,"TAXDAT").substring(4,6);
		        if(ddat=="01" || ddat=="02" || ddat=="03"){
		          gcds_data22.namevalue(1,"TAXKIDIV")="1";
		        }else if(ddat=="04" || ddat=="05" || ddat=="06"){
		          gcds_data22.namevalue(1,"TAXKIDIV")="2";
		        }else if(ddat=="07" || ddat=="08" || ddat=="09"){
		          gcds_data22.namevalue(1,"TAXKIDIV")="3";
		        }else if(ddat=="10" || ddat=="11" || ddat=="12"){
		          gcds_data22.namevalue(1,"TAXKIDIV")="4";
		        }
		        gcds_data22.namevalue(1,"WORKTYPE")=gcds_data1_2.namevalue(row1,"WORKTYPE");
				//			alert(gcds_data22.namevalue(1,"WORKTYPE"));
				gcds_data22.namevalue(1,"WRDT")=gs_date;
				gcds_data22.namevalue(1,"WRID")=gs_userid;

				gcds_data22.namevalue(1,"SEQ")=gcds_data1_2.namevalue(row1,"SEQ");  //2009.06.18. JYS 전자세금계산서용 추가

				 //2009.12.04 JYS 전자세금계산서 전자발행구분 추가
                if(rdo_gubun2_1.checked==true){
					gcds_data22.namevalue(1,"GUBUN")="1";
				}else if(rdo_gubun2_2.checked==true){
					gcds_data22.namevalue(1,"GUBUN")="2";
				}
				
				//2011.11.22. jys 추가
				gcds_data22.namevalue(1,"AMEND_CODE") = gcds_data1_2.namevalue(row1,"AMEND_CODE");
				gcds_data22.namevalue(1,"AMEND_REMARK") = gcds_data1_2.namevalue(row1,"AMEND_REMARK");

				//2010.08.24 JYS 외부전자세금계산서 시스템으로 매출발행하여 전송한 경우 
				if(chk_ext.checked==true){
					gcds_data22.namevalue(1,"EXTCHK")="1";
				}else{
					gcds_data22.namevalue(1,"EXTCHK")="0";
				}
			
               //2010.12.01 JYS 비고2 추가 
				gcds_data22.namevalue(1,"REMARK2")=gcds_data1_2.namevalue(row1,"REMARK2");
				
				//##2010.12.02 JYS 공급자 종사업장번호 추가 
				gcds_data22.namevalue(1,"S_BIZPLACE")=gcds_data1_2.namevalue(row1,"S_BIZPLACE");
				
				//2014.04.11 JYS 전자세금계산서 원가추가
				gcds_data22.namevalue(1,"COSTCD")=gcds_data1_2.namevalue(row1,"COSTCD");

				/*var str4  = gcds_data1_2.namevalue(row1,"COCODE");		//사업소              
				var str5  = gcds_data1_2.namevalue(row1,"DEPTCD");		//부서코드            
				var str6  = gcds_data1_2.namevalue(row1,"EMPNO");			//사번                
				var str7  = "B";//gcds_data1_2.namevalue(row1,"TAXIODIV");	//계산서구분          
				var str8  = gcds_data1_2.namevalue(row1,"TAXDIV");		//귀속구분            
				var str9  = gcds_data1_2.namevalue(row1,"TAXKND");	 	//계산서종류          
				var str10 = gcds_data1_2.namevalue(row1,"VEND_CD");		//거래처코드          
				var str11 = gcds_data1_2.namevalue(row1,"TAXDAT");		//계산서일자          
				var str12 = gcds_data1_2.namevalue(row1,"TAXSUM");		//공급가액            
				var str13 = gcds_data1_2.namevalue(row1,"TAXVATAMT");	//부가세액            
				var str14 = gcds_data1_2.namevalue(row1,"TAXTOT");		//합계금액            
				var str15 = gcds_data1_2.namevalue(row1,"REMARK")+"("+gclx_taxknd2.text+")";		//적요                
				var str16 = gcds_data1_2.namevalue(row1,"TAXCDNBR");	//신용카드번호        
				var str17 = gcds_data1_2.namevalue(row1,"ATCODE");		//계정코드            
				var str18 = gcds_data1_2.namevalue(row1,"TAXPRTYN");	//발행여부            
				var str19 = gcds_data1_2.namevalue(row1,"TAXCNT");		//발행횟수            
				var str20 = gcds_data1_2.namevalue(row1,"LASTPRT");		//최종출력일          
				var str21 = gcds_data1_2.namevalue(row1,"TAXTYPE");		//발행구분            
				var str22 = gcds_data1_2.namevalue(row1,"FSDAT");			//전표일자            
				var str23 = gcds_data1_2.namevalue(row1,"FSNBR");			//전표번호            
				var str24 = gcds_data1_2.namevalue(row1,"TAXKIDIV");	//기수구분            
				var str25 = gcds_data1_2.namevalue(row1,"FDCODE");		//지점코드            
				var str26 = gcds_data1_2.namevalue(row1,"WORKTYPE");	//회계구분            
				var str27 = "B";	//매입[A]/매출[B]구분 */
				if (gcem_fsdat2.text == "") {	//매출MST
					var v_taxsum = 0;
					var v_taxvat = 0;
					var v_taxtot = 0;
					for(var i=1;i<=gcds_data2_2.countrow;i++){
						v_taxsum += gcds_data2_2.namevalue(i,"TAXSUM");
						v_taxvat += gcds_data2_2.namevalue(i,"TAXVATAMT");
						var aa = gcds_data2_2.namevalue(i,"TAXPDTNAM");
						if(aa.length>19){
							alert("품목명은 19자까지만 입력해주세요.");
							return;
						}
					}
					v_taxtot =  v_taxsum+v_taxvat;
					gcds_data2_2.namevalue(row2,"TAXTOT2")   = v_taxtot;

                    gctr_data1_2.KeyValue   = "Account.a040001_t4_ee_A2(I:USER=gcds_data2_2,I:USER1=gcds_data22,O:USER7=gcds_taxnbr)";
					gctr_data1_2.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_t4_ee_A2";
					gctr_data1_2.Parameters = "v_str1="+ln_Taxnbr_Gb(gclx_fdcode2.bindcolval);

					gctr_data1_2.post();

				}
			}
			
			/****
			var maxnbr2 = gcds_data3.namevalue(gcds_data3.rowposition,"CNT");
			if (maxnbr2!=null && maxnbr2!="")	{
				ln_QuerySuc2(maxnbr2);
			}
			****/
			ln_QuerySuc2(gcem_taxnbr2.text);

		}else{
			alert("전표가 발행된 건은 저장하실수 없습니다.");
			return false;
		}
	}else{ // 수정 
		if (gcem_fsdat2.text == "") {	/*매출MST*/
			if (!ln_Check('B')) return false;
			if (confirm("저장 하시겠습니까?")){	
				ln_TaxSum2();
				//gctr_data1_2.KeyValue   = "Account.a040001_t3(I:USER=gcds_data1_2)";
				//gctr_data1_2.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_t3";
				//gctr_data1_2.Parameters = "v_str1="+gs_date2+",v_str8="+gs_date+",v_str9="+gusrid+",v_str17=N";
				//gctr_data1_2.post();

				if (gcds_data2_2.countrow>0){	/*매출DTL*/
					for(var i=1;i<=gcds_data2_2.countrow;i++){
						var aa = gcds_data2_2.namevalue(i,"TAXPDTNAM");
						if(aa.length>19){
							alert("품목명은 19자까지만 입력해주세요.");
							return;
						}
					}
					
					gctr_data2_2.KeyValue   = "Account.a040001_t2_2_ee_A2(I:USER=gcds_data2_2,I:USER2=gcds_data1_2)";
					gctr_data2_2.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_t2_2_ee_A2";

					gctr_data2_2.Parameters = "v_str1="+gcem_taxnbr2.text+",v_str2="+gs_date+",v_str3="+gusrid;

					//prompt("수정...gcds_data1_2",gcds_data1_2.Text);
					//prompt("수정..gcds_data2_2",gcds_data2_2.Text);
					///alert("gusrid::"+gusrid);
					gctr_data2_2.post();
					//ln_Query2('2');
			}//매출

				/******* 2008.05.21
				if (gcem_staxnbr2.text == "") {
					var maxnbr2 = gcds_data3.namevalue(gcds_data3.rowposition,"CNT");
					if (maxnbr2!=null && maxnbr2!="")	ln_Query2(maxnbr2);
				}else{
					var maxnbr_1 = ln_Taxnbr_Gb(gclx_fdcode.bindcolval)+gcem_staxnbr2.text;
					ln_QuerySuc2(maxnbr_1);
				}
				********/
          var maxnbr_1 = ln_Taxnbr_Gb(gclx_fdcode.bindcolval)+gcem_staxnbr2.text;
					ln_QuerySuc2(maxnbr_1);
			}//저장하시겠습니까?
		}else{
			alert("전표가 발행된 건은 저장하실수 없습니다.");
			return false;
		}
	}
}


/******************************************************************************
	Description : 저장 - 매입(공급가액-부가세액) 
******************************************************************************/
function ln_Save_1(){
	gctr_data1_1.KeyValue   = "Account.a040001_t2_2(I:USER=gcds_data1)";
	gctr_data1_1.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_t2_2";
	gctr_data1_1.Parameters = "v_str1="+gs_date2+",v_str8="+gs_date+",v_str9="+gusrid+",v_str17=N";
	gctr_data1_1.post();
}

/******************************************************************************
	Description : 저장 - 매출(공급가액-부가세액)gctr_data1_1
******************************************************************************/
function ln_Save2_2(){
	gctr_data1_4.KeyValue   = "Account.a040001_t3(I:USER=gcds_data1_2)";
	gctr_data1_4.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_t3";
	gctr_data1_4.Parameters = "v_str1="+gs_date2+",v_str8="+gs_date+",v_str9="+gusrid+",v_str17=N";
	gctr_data1_4.post();
}

/******************************************************************************
	Description : 헤더설정 
******************************************************************************/
function ln_SetDataHeader(){

		var s_temp = "FDCODE:STRING,ATCODE:STRING,AST1ST:STRING,AST2ND:STRING,AST3RD:STRING,"
							 + "ASTSEQ:STRING";
		 gcds_insert.SetDataHeader(s_temp);
}

/******************************************************************************
	Description : DATA INSERT 
******************************************************************************/
function ln_Data_Insert(k){

	ln_SetDataHeader(); 
	gcds_insert.Addrow();
	var row = gcds_insert.rowposition;

	for(i=1;i<=gcds_data1.countrow;i++){

		gcds_insert.namevalue(row,"FDCODE")=gcds_data1.namevalue(k,"FDCODE");
		gcds_insert.namevalue(row,"ATCODE")=gcds_data1.namevalue(k,"ATCODE");
		gcds_insert.namevalue(row,"AST1ST")=gcds_data1.namevalue(k,"AST1ST");
		gcds_insert.namevalue(row,"AST2ND")=gcds_data1.namevalue(k,"AST2ND");
		gcds_insert.namevalue(row,"AST3RD")=gcds_data1.namevalue(k,"AST3RD");
		gcds_insert.namevalue(row,"ASTSEQ")=gcds_data1.namevalue(k,"ASTSEQ");
		gcds_insert.namevalue(row,"TAXNBR")=gcds_data1.namevalue(k,"TAXNBR");

	}

//prompt('',gcds_data1.Text)  ;
	
}

/******************************************************************************
	Description : 입력값 체크 - 매입 && 매출
******************************************************************************/
function ln_Check(e) {

	if (e=="A") { //매입
		if (gcem_vendcd.text == "") {
			alert("거래처코드를 입력해 주세요");
			return false;
		}


   	//사업자 등록번호
		if(gcem_vendid1.text==""){
			alert("사업자등록번로를 입력해 주십시요.");
			return false;
		}

		//거래처 Email 수정 
   		if(gclx_buy.bindcolval=="N"){
			if(gcem_email.text==""){
				alert("Email을 입력해 주십시요.");
				return false;
			}
		}

		//2010.06.08 JYS 적요 필수항목 적용 오연주 요청
		if(gcem_remark.text==""){
			alert("적요를 입력해 주십시요");
			return false;
		}

		if (gcem_atcode.text == "") {
			alert("계정과목을 입력해 주세요");
			return false;
		}

		 //DTI_STATUS 체크하여 null 또는 취소완료, 수신거부 일 경우만 수정가능.
		if(gclx_status.bindcolval!=""&&gclx_status.bindcolval!="O"&&gclx_status.bindcolval!="R"){
			alert("상태를 확인해 주십시요. 저장할 수 없습니다.");
			return false;
		}
		
		//매입 공급가액 && 부가세액 체크
		if(gclx_taxknd.bindcolval=="1"&&gcds_data2.countrow>0){
			for(var i=1;i<=gcds_data2.countrow;i++){
				if(gcds_data2.namevalue(i,"TAXVATAMT")==0){
					alert("입력되지 않은 부가세액이 존재합니다.");
					return false;
				}

				if(gcds_data2.namevalue(i,"TAXSUM")==0){
					alert("입력되지 않은 공급가액이 존재합니다.");
					return false;
				}
			}
		}

		//매입 공급가액 && 부가세액 체크
		if(gclx_taxknd.bindcolval=="2"||gclx_taxknd.bindcolval=="3"){
      if(gcds_data2.countrow>0){
        for(var i=1;i<=gcds_data2.countrow;i++){
          if(gcds_data2.namevalue(i,"TAXVATAMT")!=0){
            alert("부가세액이 존재합니다.");
            return false;
          }
        }
      }
		}

		//2009.12.09 jys 과세구분이 신용카드 일경우 신용카드번호가 존재해야함.  

		if(gclx_taxknd.bindcolval=="8"&&gcem_canbr.text==""){
			alert("신용카드번호를 입력하십시요.");
			return false;
		}

        if(gclx_taxknd.bindcolval!="8"&&gcem_canbr.text!=""){
			alert("과세구분과 신용카드번호를 확인하십시요.");
			return false;
		}
        
        if(fn_trim(txt_costcd.value)==""){
        	alert("원가를 입력하십시요.");
			return false;
		}
        
        if( gclx_empno.bindcolval==""){ 
        	alert("담당자를 확인하십시요.");
        	return false;
        }

        if( gclx_dept.bindcolval==""){ 
        	alert("부서를 확인하십시요.");
        	return false;
        }


	}else if(e=="B") { //매출
		if (gcem_vendcd2.text == "") {
			alert("거래처코드를 입력해 주십시요");
			return false;
		}

		//사업자 등록번호
		if(gcem_vendid2.text==""){
			alert("사업자등록번로를 입력해 주십시요.");
			return false;
		}

		//거래처 Email 수정 
		if(gcem_email2.text==""){
			alert("Email을 입력해 주십시요.");
			return false;
		}

		//2010.06.08 JYS 적요 필수항목 적용 오연주 요청
		if(gcem_remark2.text==""){
			alert("적요를 입력해 주십시요");
			return false;
		}

		if (gcem_atcode2.text == "") {
			alert("계정과목을 입력해 주십시요");
			return false;
		}

		 //DTI_STATUS 체크하여 null 또는 취소완료, 수신거부 일 경우만 수정가능.
		if(gclx_status2.bindcolval!=""&&gclx_status2.bindcolval!="O"&&gclx_status2.bindcolval!="R"){
			alert("상태를 확인해 주십시요. 저장할 수 없습니다.");
			return false;
		}

		//매출 공급가액 && 부가세액 체크
		if(gclx_taxknd2.bindcolval=="1"&&gcds_data2_2.countrow>0){
			for(var i=1;i<=gcds_data2_2.countrow;i++){
				if(gcds_data2_2.namevalue(i,"TAXVATAMT")==0){
					alert("입력되지 않은 부가세액이 존재합니다.");
					return false;
				}

				if(gcds_data2_2.namevalue(i,"TAXSUM")==0){
					alert("입력되지 않은 공급가액이 존재합니다.");
					return false;
				}
			}
		}

		//매입 공급가액 && 부가세액 체크
		if(gclx_taxknd2.bindcolval=="2"){
	      if(gcds_data2_2.countrow>0){
	        for(var i=1;i<=gcds_data2_2.countrow;i++){
	          if(gcds_data2_2.namevalue(i,"TAXVATAMT")!=0){
	            alert("부가세액이 존재합니다.");
	            return false;
	          }
	        }
	      }
		}
		
	    if(fn_trim(txt_costcd02.value)==""){
        	alert("원가를 입력하십시요.");
			return false;
		}
	    
	    if( gclx_empno2.bindcolval==""){ 
	    	alert("담당자를 확인하십시요.");
	    	return false;
	    }

	    if( gclx_dept2.bindcolval==""){ 
	    	alert("부서를 확인하십시요.");
	    	return false;
	    }

		//수정세금계산서 수정 관련 체크 
    /*
		if(){


		}
		*/

	}
	return true;
}

/******************************************************************************
	Description : 삭제 - 매입
******************************************************************************/
function ln_Delete(e) {
	var obj = eval("gcds_data"+e);
	var row1 = gcds_data1.rowposition;

  if(!ln_StatusChk("gclx_status")) return false;
	
	if (gcem_fsdat.text == ""){ 
		if (e=='1') {
			if (gcem_fsdat.text != "" && gcem_fsstat.text == "N") {
				if (confirm("삭제 하시겠습니까?")){	
					var str1 = gcds_data1.namevalue(row1,"FDCODE");	//지점코드
					var str2 = gcds_data1.namevalue(row1,"FSDAT");	//전표일자
					var str3 = gcds_data1.namevalue(row1,"FSNBR");	//전표번호
					var str4 = "00" + gcds_data1.namevalue(row1,"TAXKND");	//증빙코드
					var str5 = gcds_data1.namevalue(row1,"TAXNBR");	//증빙명(계산서번호)

					obj.deleterow(gcds_data1.rowposition);
					gctr_data1.KeyValue   = "Account.a040001_t1(I:USER=gcds_data1)";
					gctr_data1.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_t1";
					gctr_data1.Parameters = "v_str2="+str1+",v_str3="+str2+",v_str4="+str3
																+ ",v_str5="+str4+",v_str6="+str5+",v_str7=Y";
					gctr_data1.post();
					ln_Query('1');
				}
			}else {
				if (confirm("삭제 하시겠습니까?")){	
					obj.deleterow(gcds_data1.rowposition);
					gctr_data1.KeyValue   = "Account.a040001_t1(I:USER=gcds_data1)";
					gctr_data1.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_t1";
					gctr_data1.Parameters = "v_str7=N";
					gctr_data1.post();
					ln_Query('1');
				}
			}
		}else if (e=='2') {	//행삭제
			if (confirm("삭제 하시겠습니까?")){	
				obj.deleterow(gcds_data2.rowposition);
				gctr_data2.KeyValue   = "Account.a040001_t2(I:USER=gcds_data2)";
				gctr_data2.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_t2";
				gctr_data2.Parameters = "v_str1=" + gcds_data1.namevalue(row1,"TAXNBR");
				gctr_data2.post();
				ln_Query('2');
			}
		}	
	}else{
		alert("전표가 발행된 건은 삭제하실수 없습니다.");
		return false;
	}
}

/******************************************************************************
	Description : 삭제 - 매출
******************************************************************************/
function ln_Delete2(e) {
	var obj = eval("gcds_data"+e+"_2");
	var row1 = gcds_data1_2.rowposition;

  if(!ln_StatusChk("gclx_status")) return false;


	if (gcem_fsdat2.text == ""){ 
		if (e=='1') {
			if (gcem_fsdat2.text != "" && gcem_fsstat2.text == "N") {
				if (confirm("삭제 하시겠습니까?")){	
					var str1 = gcds_data1_2.namevalue(row1,"FDCODE");	//지점코드
					var str2 = gcds_data1_2.namevalue(row1,"FSDAT");	//전표일자
					var str3 = gcds_data1_2.namevalue(row1,"FSNBR");	//전표번호
					var str4 = "00" + gcds_data1_2.namevalue(row1,"TAXKND");	//증빙코드
					var str5 = gcds_data1_2.namevalue(row1,"TAXNBR");	//증빙명(계산서번호)

					obj.deleterow(gcds_data1_2.rowposition);
					gctr_data1_2.KeyValue   = "Account.a040001_t3(I:USER=gcds_data1_2)";
					gctr_data1_2.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_t3";
					gctr_data1_2.Parameters = "v_str2="+str1+",v_str3="+str2+",v_str4="+str3
																	+ ",v_str5="+str4+",v_str6="+str5+",v_str7=Y";
					gctr_data1_2.post();
					ln_Query2('1');
				}
			}else {
				if (confirm("삭제 하시겠습니까?")){	
					obj.deleterow(gcds_data1_2.rowposition);
					gctr_data1_2.KeyValue   = "Account.a040001_t3(I:USER=gcds_data1_2)";
					gctr_data1_2.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_t3";
					gctr_data1_2.Parameters = "v_str7=N";
					gctr_data1_2.post();
					ln_Query2('1');
				}
			}
		}else if (e=='2') {	//행삭제
			if (confirm("삭제 하시겠습니까?")){	
				obj.deleterow(gcds_data2_2.rowposition);
				gctr_data2_2.KeyValue   = "Account.a040001_t2(I:USER=gcds_data2_2)";
				gctr_data2_2.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_t2";
				gctr_data2_2.Parameters = "v_str1=" + gcds_data1_2.namevalue(row1,"TAXNBR");
				gctr_data2_2.post();
				ln_Query2('2');
			}
		}
	}else{
		alert("전표가 발행된 건은 삭제하실수 없습니다.");
		return false;
	}
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
function ln_Valchk(){
	if (fn_trim(gcem_taxnbr.text) == "") {			
		alert("정확한 계산서번호를 입력해 주십시오");
		gcem_taxnbr.text ="";
		gcem_taxnbr.focus();
		return false;
	}
}



/******************************************************************************
	Description : 삭제시 상태 체크 
******************************************************************************/
function ln_StatusChk(obj){

 // alert("::::::"+eval(obj).bindcolval+"::::::::");
	if(eval(obj).bindcolval!=""&&eval(obj).bindcolval!="O"&&eval(obj).bindcolval!="R"){
		alert("상태를 확인하십시요. 삭제할 수 없습니다.");
		return false;
	}
	return true;
}


/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){ 
   
	//2008.06.11  정영식 적용
	///////if(gdeptcd==null)	gdeptcd ="C220";

	if(gs_userid=="6070001"||gs_userid=="2020009"){
		sp0.style.display = "";
	}else{
    sp0.style.display = "none"; //숨김
	}
  
	if(gdeptcd==null)	{
		alert("부서코드가 누락 되었습니다. F5키를 눌러 새로고침을 하십시요");
		return;
	}

	/*매입 선조회*/
	gcem_staxnbr.Enable	= true;
	//gclx_taxprtyn.bindcolval = "N";				//발행여부
	//gclx_taxtype.bindcolval	 = "N";				//발행구분
	gclx_cocode.bindcolval	 = "02";			//사업소
	//gcem_lastprt.text				 = gs_date;		//최종출력일
	gclx_taxdiv.bindcolval	 = "0001";		//귀속구분
	gclx_taxknd.bindcolval	 = "1";				//부가세종류
	gcem_taxdat.text				 = gs_date;		//접수일자
	gcem_wrdt.text					 = gs_date;		//작업일자

	//지점코드
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

	//회계구분
	gcds_worktype.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=1155"; 
	gcds_worktype.Reset();

	//담당부서코드
	gcds_dept.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s1?v_str1="+gdeptcd; 
	gcds_dept.Reset();

	//담당자코드[회계팀]
	gcds_empno.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>confirm_popup_s1?v_str2="+gdeptcd+"&v_str3="+cuserid;
	//prompt('',gcds_empno.DataID);
	gcds_empno.Reset();

	//부가세종류[매입]
	gcds_taxknd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0013"; 
	gcds_taxknd.Reset();

	//신용카드관리
	gcds_taxcdnbr.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>taxcdnbr_s1?v_str1="; 
	gcds_taxcdnbr.Reset();

	//귀속구분[매입구분]
	gcds_taxdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0014"; 
	gcds_taxdiv.Reset();

	//계정과목[매입구분]
	gcds_actcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0056"; 
	gcds_actcode1.Reset();

	/*매출 선조회***********************************************************/
	gclx_taxprtyn2.bindcolval = "N";				//발행여부
	gclx_taxtype2.bindcolval	= "N";				//발행구분
	gclx_cocode2.bindcolval		= "02";				//사업소
	gcem_taxdat2.text					= gs_date;		//접수일자
	gcem_wrdt2.text						= gs_date;		//작업일자
	gcem_lastprt2.text				= gs_date;		//최종출력일

	//지점코드
	gcds_fdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode2.Reset();

	//담당부서코드[매출]
	gcds_dept2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s1?v_str1="+gdeptcd; 
	gcds_dept2.Reset();

	//귀속구분[매출구분]
	gcds_taxdiv2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=1215"; 
	gcds_taxdiv2.Reset();

	//부가세종류[매출]
	gcds_taxknd2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0009"; 
	gcds_taxknd2.Reset();

	//계정과목[매출구분]
	gcds_actcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0057"; 
	gcds_actcode2.Reset();

	//종사업장 선택 변경 가능자.
	gcds_bizplace.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2190&v_str3="+gs_userid; 
	//prompt('',gcds_bizplace.DataID);
	gcds_bizplace.Reset();
}

/******************************************************************************
	Description : 거래처 기본조회 항목
******************************************************************************/
function ln_Vend(){
	var row = gcds_data1.rowposition;
	txt_vddirect.value = gcds_data1.namevalue(row, "VD_DIRECT");	//대표자
	txt_bsnscnd.value  = gcds_data1.namevalue(row, "BSNS_CND");		//업태
	txt_bsnsknd.value  = gcds_data1.namevalue(row, "BSNS_KND");		//종목
}

/******************************************************************************
	Description : 찾기 - 거래처코드
******************************************************************************/
function ln_Popup(p){
	var arrVAT	= new Array(); 
	var arrParam	= new Array();
	if(p=="A") {	//매입
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		var row1 = gcds_data1.rowposition;
		arrVAT[0]="VAT";

		//매입 중 매입구분에 따라 팝업 변경해야함.

		if(gclx_buy.bindcolval =="Y"){ //정발행매입 --> 일반거래처
			strURL = "./gczm_vender_popup.jsp";
            strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrVAT,strPos);

			if (arrResult != null) {
				arrParam = arrResult.split(";");
				gcem_vendcd.text   = arrParam[0];
				txt_fdcodenm.value = arrParam[1];
				gcem_vendid1.text  = arrParam[5];
				
				gcem_seq.text=0;
				gcem_empnm.text="";
				gcem_deptnm.text="";
				gcem_hpno.text="";
				gcem_telno.text="";
				gcem_email.text="";

			}else{
				gcem_seq.text=0;
				gcem_vendcd.text	 = "";
				txt_fdcodenm.value = "";
				gcem_vendid1.text  = "";

				gcem_empnm.text="";
				gcem_deptnm.text="";
				gcem_hpno.text="";
				gcem_telno.text="";
				gcem_email.text="";
			}

		}else if(gclx_buy.bindcolval =="N"){ // 역발행매입요청 --> email이 존재하는 거래처
			strURL = "./gczm_vender_popup33.jsp";
			strPos = "dialogWidth:700px;dialogHeight:380px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrVAT,strPos);

			if (arrResult != null) {
				arrParam = arrResult.split(";");
				//gcem_vendcd.text   = arrParam[0];
				//txt_fdcodenm.value = arrParam[1];
				//gcem_vendid1.text  = arrParam[5];
				
				gcem_seq.text      = arrParam[0]; //순번  
				gcem_vendcd.text   = arrParam[1]; //거래처 코드  
				txt_fdcodenm.value = arrParam[2]; //거래처명
				gcem_vendid1.text   = arrParam[9]; //거래처 사업자 등록번호 

				gcem_empnm.text   =arrParam[3]; //담당자성명      
				gcem_deptnm.text  =arrParam[4];	//부서명          
				gcem_hpno.text    =arrParam[6];	//핸드폰          
				gcem_telno.text   =arrParam[7];	//전화            
				gcem_email.text   =arrParam[5];	//Email      

			} else {
				gcem_seq.text=0;
				gcem_vendcd.text	 = "";
				txt_fdcodenm.value = "";
				gcem_vendid1.text  = "";

				gcem_empnm.text="";
				gcem_deptnm.text="";
				gcem_hpno.text="";
				gcem_telno.text="";
				gcem_email.text="";
			}
		}	
	}else if(p=="B") {	//매출
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		var row1 = gcds_data1_2.rowposition;
		arrVAT[0]="VAT";

    //2009.06.17 JYS 임의로 막음. 
    //strURL = "./Gczm_vender_popup.html";
		strURL = "./gczm_vender_popup33.jsp";
		strPos = "dialogWidth:700px;dialogHeight:380px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrVAT,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			


			if(arrParam[16]==10){
				gcem_vendid2.format="###-##-#####";	
			}else if (arrParam[16]==13){
				gcem_vendid2.format="######-##****#";
			}



			
			gcem_seq2.text      = arrParam[0]; //순번  
			gcem_vendcd2.text   = arrParam[1]; //거래처 코드  
			txt_fdcodenm2.value = arrParam[2]; //거래처명
			gcem_vendid2.text   = arrParam[9]; //거래처 사업자 등록번호 

			gcem_empnm2.text=arrParam[3];     //담당자성명      
			gcem_deptnm2.text  =arrParam[4];	//부서명          
			gcem_hpno2.text    =arrParam[6];	//핸드폰          
			gcem_telno2.text   =arrParam[7];	//전화            
			gcem_email2.text   =arrParam[5];	//Email     


		} else {
		  gcem_seq2.text =0;
			gcem_vendcd2.text	  = "";
			txt_fdcodenm2.value = "";
			gcem_vendid2.text   = "";

			gcem_empnm2.text="";
			gcem_deptnm2.text="";
			gcem_hpno2.text="";
			gcem_telno2.text="";
			gcem_email2.text="";
		}
	}
}
	
/******************************************************************************
Description : 원가팝업
parameter   : 
******************************************************************************/
function ln_Costcd_Popup(p){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0]="0030";//원가코드
	
	
	
	arrParam[1]="";
	
	if(p=="01"){
	
		if(txt_costnm.value==""){
			 arrParam[2]="";
		}else{
		   arrParam[2]=txt_costnm.value;
		}
		
		if(txt_costcd.value==""){
		 arrParam[3]="";
		}else{
		 arrParam[3]=txt_costcd.value;
		}
		
		strURL =  "./commdtil_cost_popup.jsp";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
		result = showModalDialog(strURL,arrParam,strPos);
		
		if (result != null) {
			arrResult = result.split(";");
			txt_costcd.value =arrResult[0];
			txt_costnm.value = arrResult[1];
		}else{
		    txt_costcd.value="";
			txt_costnm.value="";
		}
	
	}else if(p=="02"){
		if(txt_costnm02.value==""){
			 arrParam[2]="";
		}else{
		   arrParam[2]=txt_costnm02.value;
		}
		
		if(txt_costcd02.value==""){
		 arrParam[3]="";
		}else{
		 arrParam[3]=txt_costcd02.value;
		}
		
		strURL =  "./commdtil_cost_popup.jsp";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
		result = showModalDialog(strURL,arrParam,strPos);
		
		if (result != null) {
			arrResult = result.split(";");
			txt_costcd02.value =arrResult[0];
			txt_costnm02.value = arrResult[1];
		}else{
		    txt_costcd02.value="";
			txt_costnm02.value="";
		}
	}
}	

/******************************************************************************
	Description : 탭구분
	prameter    : 0-매입, 1-매출
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

/***********************************************************************************************
	Description : 매입[전표조회]
	parameter   : fcod - 지점코드, fsdt - 전표일자, fnbr - 전표번호
**********************************************************************************************/
function ln_TaxQuery(){
	if(gcem_fsdat.text != "") {
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;

		arrParam[0] = gclx_fdcode.bindcolval;
		arrParam[1] = gcem_fsdat.text;
		arrParam[2] = gcem_fsnbr.text;

		strURL = "./slipno_popup.jsp";
		strPos = "dialogWidth:890px;dialogHeight:595px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);
	}else{
		alert("발행 된 전표가 없습니다.");
	}
}

/***********************************************************************************************
	Description : 매출[전표조회]
	parameter   : fcod - 지점코드, fsdt - 전표일자, fnbr - 전표번호
**********************************************************************************************/
function ln_TaxQuery2(){
	if(gcem_fsdat2.text != "") {
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;

		arrParam[0] = gclx_fdcode2.bindcolval;
		arrParam[1] = gcem_fsdat2.text;
		arrParam[2] = gcem_fsnbr2.text;

		strURL = "./slipno_popup.jsp";
		strPos = "dialogWidth:890px;dialogHeight:595px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);
	}else{
		alert("발행 된 전표가 없습니다.");
	}
}

/***********************************************************************************************
	Description : 매입[전표발행 - FSLIPMST]
	parameter   : arrParam[0]  = "T",					arrParam[1]  = 지점,					arrParam[2]  = 전표일자,
	              arrParam[3]  = 전표번호,		arrParam[4]  = 전표상태(N),		arrParam[5]  = 부서,
	              arrParam[6]  = 부서명,			arrParam[7]  = 담당자사번,		arrParam[8]  = 담당자명,
	              arrParam[9]  = 적요,				arrParam[10] = 사업소코드,		arrParam[11] = 과세구분,
	              arrParam[12] = DTL합계금액
	----------------------------------------------------------------------------------------------
	Description : 매입[전표발행 - FSLIPDTL]
	parameter   : arrParam[0]  = 계정코드,		arrParam[1]  = 계정명,				arrParam[2]  = 거래처코드,
	              arrParam[3]  = 거래처명,		arrParam[4]  = 부서코드,			arrParam[5]  = 부서명,
	              arrParam[6]  = 적요,				arrParam[7]  = 차변금액,			arrParam[8]  = 대변금액,
	              arrParam[9]  = 세금계산서번호, 
								arrParam[10] = 증빙명(001:세금계산서,  002:계산서,    003:신용카드,
								                      004:현금소득공제,005:간이영수증,006:간주공급)
								arrParam[11] = 소속본부,		arrParam[12] = 계산서일자
**********************************************************************************************/
function ln_TaxIssue(){
	if (gcds_data2.namevalue(1,"TAXNBR") == null) {
		alert("세부내역이 등록되지 않았습니다.");
		return false;
	}else{

		if(gclx_taxknd.bindcolval!=""){//과세구분[과세]
			for(var i=1;i<=gcds_data2.countrow;i++){
				if(gclx_taxknd.bindcolval=="1"){
					if(gcds_data2.namevalue(i,"TAXSUM")==0||gcds_data2.namevalue(i,"TAXVATAMT")==0){
						alert("정확한 세부내역 금액을 입력해 주십시오.");
						return false;
					}
				}else{
					if(gcds_data2.namevalue(i,"TAXSUM")==0){
						alert("정확한 세부내역 금액을 입력해 주십시오.");
						return false;
					}
				}
			}
		}

	if (gcem_fsdat.text == "") {
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	/*전표 - FSLIPMST*/
	arrParam[0]  = "T";
	arrParam[1]  = gclx_fdcode.bindcolval;
	arrParam[2]  = gcem_fsdat.text;
	arrParam[3]  = gcem_fsnbr.text;
	arrParam[4]  = "N";
	arrParam[5]  = gclx_dept.bindcolval;
	arrParam[6]  = gclx_dept.text;
	arrParam[7]  = gclx_empno.bindcolval;
	//alert("arrParam[7] "+arrParam[7]);
	//alert("gclx_empno.bindcolval "+gclx_empno.bindcolval);
	arrParam[8]  = gclx_empno.text;
  //alert(arrParam[8] );
	arrParam[9]  = gcem_remark.text;
	arrParam[10] = gclx_cocode.bindcolval;
	arrParam[11] = gclx_taxknd.bindcolval;////gcds_deptprt.namevalue(gcds_deptprt.rowposition,"DEPTCD");
	arrParam[12] = gcem_taxtot.text;
	/*전표 - FSLIPDTL*/
	var j=1;
	for(var i=1;i<=gcds_data2.countrow;i++) {
		j = j + 13;
		if(i==1) {
			arrParam[Number(j+1)]  = gcds_data1.namevalue(1,"ATCODE");//gclx_actcode1.bindcolval;	////gcem_atcode.text;
			arrParam[Number(j+2)]  = txt_atkornam.value;				////txt_atkornam.value;
			arrParam[Number(j+3)]  = gcem_vendcd.text;
			arrParam[Number(j+4)]  = txt_fdcodenm.value;
			arrParam[Number(j+5)]  = gclx_dept.bindcolval;
			arrParam[Number(j+6)]  = gclx_dept.text;
			arrParam[Number(j+7)]  = gcem_remark.text;
			arrParam[Number(j+8)]  = 0;
			arrParam[Number(j+9)]  = gcem_taxtot.text;	//매입->대변[2]
			arrParam[Number(j+10)] = gcem_taxnbr.text;
			arrParam[Number(j+11)] = gcds_taxknd.namevalue(gcds_taxknd.rowposition,"GBCD");
			arrParam[Number(j+12)] = gcds_dept.namevalue(gcds_dept.rowposition,"DEPTCD2");
			arrParam[Number(j+13)] = gcem_taxdat.text;	//추가-접수일자

			if (gcds_data2.namevalue(i,"TAXSUM") != "") {	/*세금계산서(매입)-공급가액*/
				j = j + 13;
				arrParam[Number(j+1)]  = "";
				arrParam[Number(j+2)]  = "";	//gcds_data2.namevalue(i,"TAXPDTNAM");
				arrParam[Number(j+3)]  = gcem_vendcd.text;
				arrParam[Number(j+4)]  = txt_fdcodenm.value;
				arrParam[Number(j+5)]  = gclx_dept.bindcolval;
				arrParam[Number(j+6)]  = gclx_dept.text;
				arrParam[Number(j+7)]  = gcem_remark.text;
				if(gclx_taxknd.bindcolval!="4"){
					arrParam[Number(j+8)]  = gcds_data2.namevalue(i,"TAXSUM");	//매입->대변[2] => 차변금액
				}else{//불공[4]
					arrParam[Number(j+8)]  = gcds_data2.namevalue(i,"TAXTOT2");		//매입->공급가액+부가세액 => 합계
				}
				arrParam[Number(j+9)]  = 0;
				arrParam[Number(j+10)] = gcem_taxnbr.text;
				arrParam[Number(j+11)] = gcds_taxknd.namevalue(gcds_taxknd.rowposition,"GBCD");
				arrParam[Number(j+12)] = gcds_dept.namevalue(gcds_dept.rowposition,"DEPTCD2");
				arrParam[Number(j+13)] = gcem_taxdat.text;	//추가-접수일자
			}

			if (gcds_data2.namevalue(i,"TAXVATAMT") != "") {	/*부가가치세[매입]*/
				j = j + 13;
				arrParam[Number(j+1)]  = "1112300";//변경-"2101100";	
				arrParam[Number(j+2)]  = "선급부가가치세";//변경-"선수부가가치세";	
				arrParam[Number(j+3)]  = gcem_vendcd.text;
				arrParam[Number(j+4)]  = txt_fdcodenm.value;
				arrParam[Number(j+5)]  = gclx_dept.bindcolval;
				arrParam[Number(j+6)]  = gclx_dept.text;
				arrParam[Number(j+7)]  = gcem_remark.text;
				arrParam[Number(j+8)]  = gcds_data2.namevalue(i,"TAXVATAMT");	//매입->대변[2] => 차변금액
				arrParam[Number(j+9)]  = 0;
				arrParam[Number(j+10)] = gcem_taxnbr.text;
				arrParam[Number(j+11)] = gcds_taxknd.namevalue(gcds_taxknd.rowposition,"GBCD");
				arrParam[Number(j+12)] = gcds_dept.namevalue(gcds_dept.rowposition,"DEPTCD2");
				arrParam[Number(j+13)] = gcem_taxdat.text;	//추가-접수일자
			}

		}else{
			if (gcds_data2.namevalue(i,"TAXSUM") != "") {	/*세금계산서(매입)-공급가액*/
				arrParam[Number(j+1)]  = "";
				arrParam[Number(j+2)]  = "";	//gcds_data2.namevalue(i,"TAXPDTNAM");
				arrParam[Number(j+3)]  = gcem_vendcd.text;
				arrParam[Number(j+4)]  = txt_fdcodenm.value;
				arrParam[Number(j+5)]  = gclx_dept.bindcolval;
				arrParam[Number(j+6)]  = gclx_dept.text;
				arrParam[Number(j+7)]  = gcem_remark.text;
				arrParam[Number(j+8)]  = gcds_data2.namevalue(i,"TAXSUM");	//매입->대변[2] => 차변금액
				arrParam[Number(j+9)]  = 0;
				arrParam[Number(j+10)] = gcem_taxnbr.text;
				arrParam[Number(j+11)] = gcds_taxknd.namevalue(gcds_taxknd.rowposition,"GBCD");
				arrParam[Number(j+12)] = gcds_dept.namevalue(gcds_dept.rowposition,"DEPTCD2");
				arrParam[Number(j+13)] = gcem_taxdat.text;	//추가-접수일자
			}

			if (gcds_data2.namevalue(i,"TAXVATAMT") != "") {	/*부가가치세[매입]*/
				j = j + 13;
				arrParam[Number(j+1)]  = "1112300";//변경-"2101100";
				arrParam[Number(j+2)]  = "선급부가가치세";//변경-"선수부가가치세";
				arrParam[Number(j+3)]  = gcem_vendcd.text;
				arrParam[Number(j+4)]  = txt_fdcodenm.value;
				arrParam[Number(j+5)]  = gclx_dept.bindcolval;
				arrParam[Number(j+6)]  = gclx_dept.text;
				arrParam[Number(j+7)]  = gcem_remark.text;
				arrParam[Number(j+8)]  = gcds_data2.namevalue(i,"TAXVATAMT");	//매입->대변[2] => 차변금액
				arrParam[Number(j+9)]  = 0;
				arrParam[Number(j+10)] = gcem_taxnbr.text;
				arrParam[Number(j+11)] = gcds_taxknd.namevalue(gcds_taxknd.rowposition,"GBCD");
				arrParam[Number(j+12)] = gcds_dept.namevalue(gcds_dept.rowposition,"DEPTCD2");
				arrParam[Number(j+13)] = gcem_taxdat.text;	//추가-접수일자
			}
		}
	}

	  ///prompt('',arrParam);

		strURL = "./slipno_popup.jsp";
		strPos = "dialogWidth:890px;dialogHeight:595px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);
		ln_Query('1');
		}else{
			alert("전표가 이미 발행되었습니다.");
		}
	}
}

/***********************************************************************************************
	Description : 매출[전표발행 - FSLIPMST]
	parameter   : arrParam[0]  = "T",					arrParam[1]  = 지점,					arrParam[2]  = 전표일자,
	              arrParam[3]  = 전표번호,		arrParam[4]  = 전표상태(N),		arrParam[5]  = 부서,
	              arrParam[6]  = 부서명,			arrParam[7]  = 담당자사번,		arrParam[8]  = 담당자명,
	              arrParam[9]  = 적요,				arrParam[10] = 사업소코드,		arrParam[11] = 과세구분,
	              arrParam[12] = DTL합계금액
	----------------------------------------------------------------------------------------------
	Description : 매출[전표발행 - FSLIPDTL]
	parameter   : arrParam[0]  = 계정코드,		arrParam[1]  = 계정명,				arrParam[2]  = 거래처코드,
	              arrParam[3]  = 거래처명,		arrParam[4]  = 부서코드,			arrParam[5]  = 부서명,
	              arrParam[6]  = 적요,				arrParam[7]  = 차변금액,			arrParam[8]  = 대변금액,
	              arrParam[9]  = 세금계산서번호, 
								arrParam[10] = 증빙명(001:세금계산서,  002:계산서,    003:신용카드,
								                      004:현금소득공제,005:간이영수증,006:간주공급)
								arrParam[11] = 소속본부,		arrParam[12] = 계산서일자
**********************************************************************************************/
function ln_TaxIssue2(){

	if (gcds_data2_2.namevalue(1,"TAXNBR") == null) {
		alert("세부내역이 등록되지 않았습니다.");
		return false;
	}else{
		if(gclx_taxknd2.bindcolval!=""){//과세구분[과세]
			for(var i=1;i<=gcds_data2_2.countrow;i++){
				if(gclx_taxknd2.bindcolval=="1"){
					if(gcds_data2_2.namevalue(i,"TAXSUM")==0||gcds_data2_2.namevalue(i,"TAXVATAMT")==0){
						alert("정확한 세부내역 금액을 입력해 주십시오.");
						return false;
					}
				}else{
					if(gcds_data2_2.namevalue(i,"TAXSUM")==0){
						alert("정확한 세부내역 금액을 입력해 주십시오.");
						return false;
					}
				}
			}
		}
	
	if (gcem_fsdat2.text == "") {
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	/*전표 - FSLIPMST*/
	arrParam[0]  = "T";
	arrParam[1]  = gclx_fdcode2.bindcolval;
	arrParam[2]  = gcem_fsdat2.text;
	arrParam[3]  = gcem_fsnbr2.text;
	arrParam[4]  = "N";
	arrParam[5]  = gclx_dept2.bindcolval;
	arrParam[6]  = gclx_dept2.text;
	arrParam[7]  = gclx_empno2.bindcolval;
	arrParam[8]  = gclx_empno2.text;
	arrParam[9]  = gcem_remark2.text;
	arrParam[10] = gclx_cocode2.bindcolval;
	arrParam[11] = gclx_taxknd2.bindcolval; //gcds_deptprt.namevalue(gcds_deptprt.rowposition,"DEPTCD");
	arrParam[12] = gcem_taxtot2.text;

	/*전표 - FSLIPDTL*/
	var j=1;
	for(var i=1;i<=gcds_data2_2.countrow;i++) {
		j = j + 13;
		if(i==1) {
			arrParam[Number(j+1)]  = gcds_data1_2.namevalue(1,"ATCODE");//gclx_actcode2.bindcolval;	////gcem_atcode2.text;
			arrParam[Number(j+2)]  = txt_atkornam_2.value;				////txt_atkornam_2.value;
			arrParam[Number(j+3)]  = gcem_vendcd2.text;
			arrParam[Number(j+4)]  = txt_fdcodenm2.value;
			arrParam[Number(j+5)]  = gclx_dept2.bindcolval;
			arrParam[Number(j+6)]  = gclx_dept2.text;
			arrParam[Number(j+7)]  = gcem_remark2.text;
			arrParam[Number(j+8)]  = gcem_taxtot2.text;	//매출->차변[1]
			arrParam[Number(j+9)]  = 0;
			arrParam[Number(j+10)] = gcem_taxnbr2.text;
			arrParam[Number(j+11)] = gcds_taxknd2.namevalue(gcds_taxknd2.rowposition,"GBCD");
			arrParam[Number(j+12)] = gcds_dept2.namevalue(gcds_dept2.rowposition,"DEPTCD2");
			arrParam[Number(j+13)] = gcem_taxdat2.text;	//추가-접수일자
			
			if (gcds_data2_2.namevalue(i,"TAXSUM") != "") {	/*세금계산서(매출)-공급가액*/
				j = j + 13;
				arrParam[Number(j+1)]  = "";
				arrParam[Number(j+2)]  = "";
				arrParam[Number(j+3)]  = gcem_vendcd2.text;
				arrParam[Number(j+4)]  = txt_fdcodenm2.value;
				arrParam[Number(j+5)]  = gclx_dept2.bindcolval;
				arrParam[Number(j+6)]  = gclx_dept2.text;
				arrParam[Number(j+7)]  = gcem_remark2.text;
				arrParam[Number(j+8)]  = 0;
				arrParam[Number(j+9)]  = gcds_data2_2.namevalue(i,"TAXSUM");	//매출->차변[1] => 대변금액
				arrParam[Number(j+10)] = gcem_taxnbr2.text;
				arrParam[Number(j+11)] = gcds_taxknd2.namevalue(gcds_taxknd2.rowposition,"GBCD");
				arrParam[Number(j+12)] = gcds_dept2.namevalue(gcds_dept2.rowposition,"DEPTCD2");
				arrParam[Number(j+13)] = gcem_taxdat2.text;	//추가-접수일자
			}

			if (gcds_data2_2.namevalue(i,"TAXVATAMT") != "") {	/*부가가치세[매출]*/
				j = j + 13;
				arrParam[Number(j+1)]  = "2101100";//변경-"2101200";	
				arrParam[Number(j+2)]  = "선수부가가치세";//변경-"부가가치세예수금";
				arrParam[Number(j+3)]  = gcem_vendcd2.text;
				arrParam[Number(j+4)]  = txt_fdcodenm2.value;
				arrParam[Number(j+5)]  = gclx_dept2.bindcolval;
				arrParam[Number(j+6)]  = gclx_dept2.text;
				arrParam[Number(j+7)]  = gcem_remark2.text;
				arrParam[Number(j+8)]  = 0;
				arrParam[Number(j+9)]  = gcds_data2_2.namevalue(i,"TAXVATAMT");	//매출->차변[1] => 대변금액
				arrParam[Number(j+10)] = gcem_taxnbr2.text;
				arrParam[Number(j+11)] = gcds_taxknd2.namevalue(gcds_taxknd2.rowposition,"GBCD");
				arrParam[Number(j+12)] = gcds_dept2.namevalue(gcds_dept2.rowposition,"DEPTCD2");
				arrParam[Number(j+13)] = gcem_taxdat2.text;	//추가-접수일자
			}

		}else{
			if (gcds_data2_2.namevalue(i,"TAXSUM") != "") {	/*세금계산서(매출)-공급가액*/
				arrParam[Number(j+1)]  = "";
				arrParam[Number(j+2)]  = "";	
				arrParam[Number(j+3)]  = gcem_vendcd2.text;
				arrParam[Number(j+4)]  = txt_fdcodenm2.value;
				arrParam[Number(j+5)]  = gclx_dept2.bindcolval;
				arrParam[Number(j+6)]  = gclx_dept2.text;
				arrParam[Number(j+7)]  = gcem_remark2.text;
				arrParam[Number(j+8)]  = 0;
				arrParam[Number(j+9)]  = gcds_data2_2.namevalue(i,"TAXSUM");	//매출->차변[1] => 대변금액
				arrParam[Number(j+10)] = gcem_taxnbr2.text;
				arrParam[Number(j+11)] = gcds_taxknd2.namevalue(gcds_taxknd2.rowposition,"GBCD");
				arrParam[Number(j+12)] = gcds_dept2.namevalue(gcds_dept2.rowposition,"DEPTCD2");
				arrParam[Number(j+13)] = gcem_taxdat2.text;	//추가-접수일자
			}

			if (gcds_data2_2.namevalue(i,"TAXVATAMT") != "") {	/*부가가치세[매출]*/
				j = j + 13;
				arrParam[Number(j+1)]  = "2101100";//변경-"2101200";
				arrParam[Number(j+2)]  = "선수부가가치세";//변경-"부가가치세예수금";
				arrParam[Number(j+3)]  = gcem_vendcd2.text;
				arrParam[Number(j+4)]  = txt_fdcodenm2.value;
				arrParam[Number(j+5)]  = gclx_dept2.bindcolval;
				arrParam[Number(j+6)]  = gclx_dept2.text;
				arrParam[Number(j+7)]  = gcem_remark2.text;
				arrParam[Number(j+8)]  = 0;
				arrParam[Number(j+9)]  = gcds_data2_2.namevalue(i,"TAXVATAMT");	//매출->차변[1] => 대변금액
				arrParam[Number(j+10)] = gcem_taxnbr2.text;
				arrParam[Number(j+11)] = gcds_taxknd2.namevalue(gcds_taxknd2.rowposition,"GBCD");
				arrParam[Number(j+12)] = gcds_dept2.namevalue(gcds_dept2.rowposition,"DEPTCD2");
				arrParam[Number(j+13)] = gcem_taxdat2.text;	//추가-접수일자
			}
		}
	}

	  ///prompt('매출',arrParam);
		strURL = "./slipno_popup.jsp";
		strPos = "dialogWidth:890px;dialogHeight:595px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);
		ln_Query2('1');
		}else{
			alert("전표가 이미 발행되었습니다.");
		}
	}
}

/******************************************************************************
	Description : 찾기 - 계정코드
******************************************************************************/
function ln_Popup2(p){
	if(p=="A") {
		var strURL;
		var strPos;
		var arrParam = new Array();
		var result   = new Array();

		strURL = "./actcode_popup.jsp";
		arrParam[0]="ATUSEYN";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);

		if (result != null) {
			arrResult = result.split(";");
			gcem_atcode.text		=	arrResult[0];
			txt_atkornam.value	=	arrResult[1];
			txt_atdecr.value		=	arrResult[2];
		} else {
			gcem_atcode.text		=	"";
			txt_atkornam.value	=	"";
			txt_atdecr.value		=	"";
		}
	}else if(p=="B") {
		var strURL;
		var strPos;
		var arrParam = new Array();
		var result   = new Array();

		strURL = "./actcode_popup.jsp";
		arrParam[0]="ATUSEYN";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);

		if (result != null) {
			arrResult = result.split(";");
			gcem_atcode2.text			=	arrResult[0];
			txt_atkornam_2.value	=	arrResult[1];
			txt_atdecr_2.value		=	arrResult[2];
		} else {
			gcem_atcode2.text			=	"";
			txt_atkornam_2.value	=	"";
			txt_atdecr_2.value		=	"";
		}
	}
}

/******************************************************************************
	Description : 신규등록[신용카드]
******************************************************************************/
function ln_CardPopup(){

	var strURL;
	var strPos;
	var arrParam = new Array();
	var result   = new Array();

	//strURL = "./creditcard_popup.html";
	strURL = "./card_popup.jsp";
	strPos = "dialogWidth:450px;dialogHeight:420px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		gcem_canbr.text	=	arrResult[0];
	} else {
		gcem_canbr.text	=	"";
	}

}

/******************************************************************************
	Description : 신규등록[가맹점(거래처)]
******************************************************************************/
function ln_VenderPopup(){
	var strURL;
	var strPos;
	var arrParam = new Array();
	var result   = new Array();

	strURL = "./vendertr_popup.jsp";
	strPos = "dialogWidth:878px;dialogHeight:520px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		gcem_cardvendcd.text	=	arrResult[0];
		txt_cardvendnm.value	=	arrResult[1];
	} else {
		gcem_cardvendcd.text	=	"";
		txt_cardvendnm.value  = "";
	}
}

/******************************************************************************
	Description : 신규등록[고정자산]
******************************************************************************/
function ln_PropPopup(){
	var strURL;
	var strPos;
	var arrParam = new Array();
	var result   = new Array();

	strURL = "./a040001_popup.jsp";
	strPos = "dialogWidth:888px;dialogHeight:635px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {

	
		arrResult = result.split(";");
		//gcem_cardvendcd.text	=	arrResult[0];
		var ls_cnt="";
		ls_cnt = arrResult.length/8 ;
		var ls_cnt_2 = arrResult.length-1;
//alert("length::"+arrResult.length);
//alert("ls_cnt_2::"+ls_cnt_2);
		ln_SetDataHeader();

		for(i=1; i<=ls_cnt; i++) {
				gcds_insert.Addrow();
		//		if(ls_cnt==1) {
				txt_fixprop.value=arrResult[0];
				txt_fixpropnm.value=arrResult[1];
		//		alert("sss");
		//}
				//gcds_insert.NameValue(i,"FDCODE")  = arrResult[0];
				//gcds_insert.NameValue(i,"FDCODE")  = arrResult[1];
				gcds_insert.NameValue(i,"FDCODE")  = arrResult[8*(i-1)+2];
				gcds_insert.NameValue(i,"ATCODE")  = arrResult[8*(i-1)+3];
				gcds_insert.NameValue(i,"AST1ST")  = arrResult[8*(i-1)+4];
				gcds_insert.NameValue(i,"AST2ND")  = arrResult[8*(i-1)+5];
				gcds_insert.NameValue(i,"AST3RD")  = arrResult[8*(i-1)+6];
				gcds_insert.NameValue(i,"ASTSEQ")  = arrResult[8*(i-1)+7];

				//gcds_insert.NameValue(i,"ASTSEQ")  = arrResult[8];
				txt_fixpropnm_cnt.value=arrResult[ls_cnt_2]; //배열의 마지막값에 cnt row가 담겨 있다.
				//prompt('',gcds_insert.Text);
		}
	} else {
		txt_fixprop.value	=	"";
		txt_fixpropnm.value	=	"";
		txt_fixpropnm_cnt.value	=	"";
	}
}
/******************************************************************************
	Description : 세금계산서 출력조회
******************************************************************************/
function ln_Query3(){ 

	var row  = gcds_data1_2.rowposition;
	var str1 = gcem_taxnbr2.text;
	var str2 = gclx_cocode2.BindColVal;
	var str3 = gcem_taxdat2.text;
	var str4 = gcem_vendcd2.text;
	var str5 = gclx_taxdiv2.BindColVal;
	var str6 = gclx_taxknd2.BindColVal;

	gcds_print.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_s4"
									  + "?v_str1="+str1+"&v_str2="+str2
									  + "&v_str3="+str3+"&v_str4="+str4
									  + "&v_str5="+str5+"&v_str6="+str6;
  //prompt('',gcds_print.DataID);
	gcds_print.Reset();  
}


/******************************************************************************
	Description : 지점에 따른 계산서번호 구분값 변경
	Param       : strFdcode - 지점( 01:본사, 02:서울, 03:금강산, 04:개성)   
	              g_gb - 구분( A:매입 , B:매출)
******************************************************************************/
function ln_Taxnbr_Gb(strFdcode){
	
	if(strFdcode=="03"){ //금강산
		if(g_gb=="A"){
		  return "E";
		}else if(g_gb=="B"){
      return "F"; 
		}
	}else if(strFdcode=="04"){ //개성
		if(g_gb=="A"){
		  return "C";
		}else if(g_gb=="B"){
      return "D"; 
		}
	}else{ //서울
		if(g_gb=="A"){
      return "A";
		}else if(g_gb=="B"){
		  return "B";
		}
	}
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

	ln_Query3();	//세금계산서 출력조회

	var taxdat = gcds_print.namevalue(gcds_print.rowposition,"TAXDAT");

	if(taxdat<'20080828'){
		g_ceoname="윤만준";
		
	}else if(taxdat<'20100323'){
		g_ceoname="조건식";
			
	}else if(taxdat<'20130321'){
		g_ceoname="장경작";		

	}else if(taxdat<'20140326'){
		g_ceoname="김종학";	
		
	}else{
		g_ceoname="조건식";
	}

	if (gcds_data1_2.countrow<1) {
		alert("출력하실 정보가 없습니다");
	} else {
		/* 부가세종류 */
		var sknd = gclx_taxknd2.BindColVal;	
		if(sknd=="1"||sknd=="2") {	
			var tcnt = Number(gcds_data1_2.namevalue(gcds_data1_2.rowposition,"TAXCNT")+1);
			gcds_data1_2.namevalue(gcds_data1_2.rowposition,"TAXPRTYN") = "Y";
			gcds_data1_2.namevalue(gcds_data1_2.rowposition,"TAXCNT") = tcnt;
			gctr_data1_3.KeyValue   = "Account.a040001_t3(I:USER=gcds_data1_2)";
			gctr_data1_3.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_t3";
			gctr_data1_3.Parameters = "v_str1="+gs_date2+",v_str8="+gs_date+",v_str9="+cuserid;
			gctr_data1_3.post();
			/* [1]세금계산서 Format */
			if(gclx_cocode2.bindcolval=="02"){
				ln_RptFormat1();
			}else if(gclx_cocode2.bindcolval=="01"){
				ln_RptFormat3();
			}
      
			gcrp_print.preview();	//세금계산서 미리보기 
		}else if(sknd=="3") {
			/* [2]계  산  서 Format */
			ln_RptFormat2();	
			gcrp_print.preview();	//세금계산서 미리보기
		}else{
			alert("출력하실 계산서 종류를 선택해 주세요.");
			return false;
		}
	}
}

/******************************************************************************
	Description : 출력 - 세금계산서[매출]
******************************************************************************/
function ln_RptFormat1() {

	var ls_for = "";

	ls_for += " <B>id=default ,left=0,top=0 ,right=2871 ,bottom=2762 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                     ";
	ls_for += " 	<T>id='자' ,left=37 ,top=484 ,right=82 ,bottom=561 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                             ";	
	ls_for += " 	<T>id='공' ,left=37 ,top=273 ,right=82 ,bottom=349 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                             ";	
	ls_for += " 	<L> left=291 ,top=225 ,right=929 ,bottom=225 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=1778 ,top=151 ,right=1778 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";	
  ls_for += " 	<L> left=1725 ,top=151 ,right=1725 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";
	ls_for += " 	<L> left=1619 ,top=151 ,right=1619 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<T>id='명' ,left=1519 ,top=373 ,right=1564 ,bottom=413 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='성' ,left=1519 ,top=328 ,right=1564 ,bottom=368 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='주     소' ,left=987 ,top=468 ,right=1191 ,bottom=508 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                   ";	
  ls_for += " 	<T>id='급' ,left=37 ,top=381 ,right=82 ,bottom=458 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                             ";
	ls_for += " 	<T>id='자' ,left=934 ,top=508 ,right=979 ,bottom=566 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";	
	ls_for += " 	<T>id='는' ,left=934 ,top=450 ,right=979 ,bottom=505 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";	
	ls_for += " 	<T>id='받' ,left=934 ,top=392 ,right=979 ,bottom=447 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";	
	ls_for += " 	<T>id='급' ,left=934 ,top=331 ,right=979 ,bottom=386 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";	
  ls_for += " 	<T>id='공' ,left=934 ,top=273 ,right=979 ,bottom=328 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";
	ls_for += " 	<L> left=1193 ,top=225 ,right=1834 ,bottom=225 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<L> left=1299 ,top=151 ,right=1834 ,bottom=151 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<T>id='책 번 호' ,left=1307 ,top=82 ,right=1508 ,bottom=148 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                    ";	
	ls_for += " 	<T>id='일련번호' ,left=1307 ,top=156 ,right=1508 ,bottom=222 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                   ";	
  ls_for += " 	<L> left=29 ,top=225 ,right=1834 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";
	ls_for += " 	<T>id='(                   )' ,left=987 ,top=132 ,right=1296 ,bottom=172 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                       ";	
	ls_for += " 	<T>id='세 금 계 산 서' ,left=37 ,top=66 ,right=984 ,bottom=201 ,face='굴림' ,size=23 ,bold=true ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                  ";	
	ls_for += " 	<T>id='사 업 장' ,left=987 ,top=426 ,right=1191 ,bottom=466 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                    ";	
	ls_for += " 	<T>id='등록번호' ,left=90 ,top=230 ,right=288 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      ";	
  ls_for += " 	<L> left=85 ,top=320 ,right=929 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                            ";
	ls_for += " 	<L> left=982 ,top=320 ,right=1834 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                          ";	
	ls_for += " 	<T>id='등록번호' ,left=987 ,top=230 ,right=1191 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                    ";	
	ls_for += " 	<T>id='(법인명)' ,left=987 ,top=368 ,right=1191 ,bottom=413 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                    ";	
	ls_for += " 	<T>id='상    호' ,left=987 ,top=325 ,right=1191 ,bottom=365 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                    ";	
  ls_for += " 	<T>id='(법인명)' ,left=90 ,top=368 ,right=288 ,bottom=413 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      ";
	ls_for += " 	<T>id='상    호' ,left=90 ,top=325 ,right=288 ,bottom=365 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      ";	
	ls_for += " 	<T>id='현대아산주식회사' ,left=299 ,top=325 ,right=606 ,bottom=410 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                               ";	
	ls_for += " 	<T>id='성' ,left=616 ,top=325 ,right=659 ,bottom=365 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";	
	ls_for += " 	<T>id='명' ,left=616 ,top=368 ,right=659 ,bottom=410 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";	
  ls_for += " 	<T>id='인' ,left=881 ,top=325 ,right=926 ,bottom=413 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";
	ls_for += " 	<T>id='"+g_ceoname+"' ,left=669 ,top=325 ,right=876 ,bottom=410 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                         ";	
	ls_for += " 	<T>id='인' ,left=1783 ,top=328 ,right=1828 ,bottom=413 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<C>id='VD_DIRECT', left=1572, top=328, right=1778, bottom=413, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                    ";	
	ls_for += " 	<C>id='VEND_NM', left=1201, top=336, right=1508, bottom=413, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                      ";	
  ls_for += " 	<L> left=982 ,top=415 ,right=1834 ,bottom=415 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                          ";
	ls_for += " 	<L> left=85 ,top=415 ,right=929 ,bottom=415 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                            ";	
	ls_for += " 	<L> left=291 ,top=415 ,right=929 ,bottom=415 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<T>id='사 업 장' ,left=90 ,top=421 ,right=288 ,bottom=463 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      ";	
	ls_for += " 	<T>id='주     소' ,left=90 ,top=466 ,right=288 ,bottom=505 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                     ";	
  ls_for += " 	<C>id='ADDNM', left=1201, top=431, right=1831, bottom=505, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                        ";
	ls_for += " 	<T>id='서울시 종로구 계동 140-2' ,left=296 ,top=421 ,right=926 ,bottom=505 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                       ";	
	ls_for += " 	<L> left=85 ,top=508 ,right=929 ,bottom=508 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                            ";	
	ls_for += " 	<L> left=982 ,top=508 ,right=1834 ,bottom=508 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                          ";	
	ls_for += " 	<T>id='서비스' ,left=296 ,top=516 ,right=606 ,bottom=598 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                         ";	
  ls_for += " 	<T>id='업     태' ,left=90 ,top=516 ,right=288 ,bottom=598 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                     ";
	ls_for += " 	<C>id='BSNS_KND', left=1572, top=516, right=1828, bottom=598, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                     ";	
	ls_for += " 	<C>id='BSNS_CND', left=1201, top=516, right=1508, bottom=598, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                     ";	
	ls_for += " 	<T>id='업     태' ,left=987 ,top=516 ,right=1191 ,bottom=598 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                   ";	
	ls_for += " 	<T>id='목' ,left=616 ,top=558 ,right=659 ,bottom=601 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";	
  ls_for += " 	<T>id='종' ,left=616 ,top=516 ,right=659 ,bottom=556 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";
	ls_for += " 	<T>id='목' ,left=1519 ,top=558 ,right=1564 ,bottom=601 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='종' ,left=1519 ,top=516 ,right=1564 ,bottom=556 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<L> left=32 ,top=603 ,right=1834 ,bottom=603 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=1566 ,top=508 ,right=1566 ,bottom=603 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";	
  ls_for += " 	<L> left=1566 ,top=151 ,right=1566 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";
	ls_for += " 	<T>id='비        고' ,left=1519 ,top=611 ,right=1828 ,bottom=654 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                               ";	
	ls_for += " 	<T>id='세              액' ,left=987 ,top=611 ,right=1508 ,bottom=654 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                          ";	
	ls_for += " 	<T>id='공     급     가     액' ,left=296 ,top=611 ,right=979 ,bottom=654 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                      ";	
	ls_for += " 	<T>id='작      성' ,left=37 ,top=611 ,right=288 ,bottom=654 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                    ";	
  ls_for += " 	<L> left=29 ,top=656 ,right=1834 ,bottom=656 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";
	ls_for += " 	<T>id='일' ,left=1466 ,top=661 ,right=1508 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='일' ,left=233 ,top=661 ,right=288 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";	
	ls_for += " 	<T>id='공란수' ,left=296 ,top=661 ,right=394 ,bottom=706 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                         ";	
	ls_for += " 	<T>id='백' ,left=402 ,top=661 ,right=447 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";	
  ls_for += " 	<T>id='억' ,left=508 ,top=661 ,right=553 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";
	ls_for += " 	<T>id='십' ,left=881 ,top=661 ,right=926 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";	
	ls_for += " 	<T>id='백' ,left=828 ,top=661 ,right=873 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";	
	ls_for += " 	<T>id='천' ,left=775 ,top=661 ,right=820 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";	
	ls_for += " 	<T>id='만' ,left=722 ,top=661 ,right=767 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";	
  ls_for += " 	<T>id='십' ,left=669 ,top=661 ,right=712 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";
	ls_for += " 	<T>id='백' ,left=616 ,top=661 ,right=659 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";	
	ls_for += " 	<T>id='천' ,left=564 ,top=661 ,right=606 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";	
	ls_for += " 	<T>id='일' ,left=934 ,top=661 ,right=979 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";	
	ls_for += " 	<T>id='십' ,left=455 ,top=661 ,right=500 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";	
  ls_for += " 	<T>id='억' ,left=1040 ,top=661 ,right=1085 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                         ";
	ls_for += " 	<T>id='천' ,left=1093 ,top=661 ,right=1138 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='백' ,left=1148 ,top=661 ,right=1191 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='십' ,left=1201 ,top=661 ,right=1244 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='만' ,left=1254 ,top=661 ,right=1296 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                         ";	
  ls_for += " 	<T>id='천' ,left=1307 ,top=661 ,right=1349 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                         ";
	ls_for += " 	<T>id='백' ,left=1360 ,top=661 ,right=1402 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='십' ,left=1413 ,top=661 ,right=1455 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='십' ,left=987 ,top=661 ,right=1032 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                          ";	
	ls_for += " 	<L> left=32 ,top=773 ,right=1834 ,bottom=773 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                           ";	
  ls_for += " 	<T>id='년' ,left=37 ,top=661 ,right=164 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                            ";
	ls_for += " 	<T>id='월' ,left=172 ,top=661 ,right=225 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";	
	ls_for += " 	<L> left=29 ,top=709 ,right=1513 ,bottom=709 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=228 ,top=656 ,right=228 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=291 ,top=225 ,right=291 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
  ls_for += " 	<L> left=397 ,top=656 ,right=397 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";
	ls_for += " 	<L> left=450 ,top=656 ,right=450 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=503 ,top=656 ,right=503 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=556 ,top=656 ,right=556 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=664 ,top=508 ,right=664 ,bottom=603 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
  ls_for += " 	<L> left=982 ,top=225 ,right=982 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";
	ls_for += " 	<T>id='월' ,left=37 ,top=781 ,right=95 ,bottom=823 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                             ";	
	ls_for += " 	<T>id='비고' ,left=1701 ,top=781 ,right=1828 ,bottom=823 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                       ";	
	ls_for += " 	<T>id='세       액' ,left=1413 ,top=781 ,right=1691 ,bottom=823 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                ";	
	ls_for += " 	<T>id='공 급 가 액' ,left=1093 ,top=781 ,right=1402 ,bottom=823 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                ";	
  ls_for += " 	<T>id='단    가' ,left=828 ,top=781 ,right=1085 ,bottom=823 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                    ";
	ls_for += " 	<T>id='수량' ,left=722 ,top=781 ,right=820 ,bottom=823 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='규격' ,left=616 ,top=781 ,right=712 ,bottom=823 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='품        목' ,left=172 ,top=781 ,right=606 ,bottom=823 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                 ";	
	ls_for += " 	<T>id='일' ,left=103 ,top=781 ,right=164 ,bottom=823 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                           ";	
  ls_for += " 	<L> left=29 ,top=826 ,right=1834 ,bottom=826 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";
	ls_for += " 	<L> left=29 ,top=894 ,right=1834 ,bottom=894 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=29 ,top=963 ,right=1834 ,bottom=963 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=1193 ,top=320 ,right=1831 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<L> left=32 ,top=1220 ,right=1834 ,bottom=1220 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                         ";	
  ls_for += " 	<L> left=397 ,top=228 ,right=397 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";
	ls_for += " 	<L> left=450 ,top=228 ,right=450 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=503 ,top=228 ,right=503 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=556 ,top=228 ,right=556 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=609 ,top=656 ,right=609 ,bottom=1220 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                          ";
	ls_for += " 	<L> left=664 ,top=656 ,right=664 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";
	ls_for += " 	<L> left=664 ,top=228 ,right=664 ,bottom=418 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=876 ,top=656 ,right=876 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=929 ,top=656 ,right=929 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=1035 ,top=656 ,right=1035 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";	
  ls_for += " 	<L> left=1140 ,top=656 ,right=1140 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";
	ls_for += " 	<L> left=1193 ,top=656 ,right=1193 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<L> left=1246 ,top=656 ,right=1246 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<L> left=1299 ,top=656 ,right=1299 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<L> left=1352 ,top=656 ,right=1352 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";	
  ls_for += " 	<L> left=1458 ,top=656 ,right=1458 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";
	ls_for += " 	<L> left=770 ,top=228 ,right=770 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=876 ,top=228 ,right=876 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=1246 ,top=228 ,right=1246 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<L> left=1299 ,top=228 ,right=1299 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                         ";	
  ls_for += " 	<L> left=1352 ,top=228 ,right=1352 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                         ";
	ls_for += " 	<L> left=1458 ,top=228 ,right=1458 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<L> left=1566 ,top=228 ,right=1566 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<L> left=1619 ,top=228 ,right=1619 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<L> left=1725 ,top=228 ,right=1725 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                         ";	
  ls_for += " 	<L> left=1778 ,top=228 ,right=1778 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                         ";
	ls_for += " 	<L> left=291 ,top=225 ,right=291 ,bottom=415 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=929 ,top=228 ,right=929 ,bottom=415 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=929 ,top=225 ,right=929 ,bottom=603 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=1193 ,top=228 ,right=1193 ,bottom=603 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";	
  ls_for += " 	<L> left=85 ,top=225 ,right=85 ,bottom=603 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                             ";
	ls_for += " 	<L> left=1513 ,top=228 ,right=1513 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<L> left=1513 ,top=508 ,right=1513 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<L> left=770 ,top=656 ,right=770 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=29 ,top=1032 ,right=1834 ,bottom=1032 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";	
  ls_for += " 	<T>id='22226-28131일 ‘96.3.27승인' ,left=32 ,top=1228 ,right=585 ,bottom=1270 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                     ";
	ls_for += " 	<T>id='인쇄용지(특급)34g/m2 182mmx128mm' ,left=1098 ,top=1228 ,right=1839 ,bottom=1270 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>           ";	
	ls_for += " 	<T>id='공  급  자' ,left=987 ,top=101 ,right=1296 ,bottom=140 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                  ";	
	ls_for += " 	<T>id='보  관  용' ,left=987 ,top=159 ,right=1296 ,bottom=204 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                  ";	
	ls_for += " 	<C>id='TAXPDTNAM_1', left=172, top=831, right=606, bottom=892, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                    ";	
  ls_for += " 	<C>id='TAXPDTNAM_2', left=172, top=900, right=606, bottom=958, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                    ";
	ls_for += " 	<C>id='TAXPDTNAM_3', left=172, top=968, right=606, bottom=1029, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                   ";	
	ls_for += " 	<C>id='TAXPDTNAM_4', left=172, top=1037, right=606, bottom=1098, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                  ";	
	ls_for += " 	<L> left=29 ,top=1101 ,right=1834 ,bottom=1101 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<T>id='합계금액' ,left=40 ,top=1106 ,right=344 ,bottom=1148 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                    ";	
  ls_for += " 	<T>id='현  금' ,left=352 ,top=1106 ,right=606 ,bottom=1148 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                     ";
	ls_for += " 	<T>id='수  표' ,left=616 ,top=1106 ,right=876 ,bottom=1148 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                     ";	
	ls_for += " 	<T>id='어  음' ,left=884 ,top=1106 ,right=1140 ,bottom=1148 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                    ";	
	ls_for += " 	<T>id='외상미수금' ,left=1151 ,top=1106 ,right=1402 ,bottom=1148 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                               ";	
	ls_for += " 	<L> left=29 ,top=1151 ,right=1405 ,bottom=1151 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";	
  ls_for += " 	<C>id='TAXMM_1', left=37, top=831, right=95, bottom=892, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                          ";
	ls_for += " 	<C>id='TAXDT_1', left=103, top=831, right=164, bottom=892, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                        ";	
	ls_for += " 	<C>id='TAXMM_2', left=37, top=900, right=95, bottom=958, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                          ";	
	ls_for += " 	<C>id='TAXDT_2', left=103, top=900, right=164, bottom=958, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                        ";	
	ls_for += " 	<C>id='TAXDT_3', left=103, top=968, right=164, bottom=1029, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                       ";	
  ls_for += " 	<C>id='TAXMM_3', left=37, top=968, right=95, bottom=1029, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                         ";
	ls_for += " 	<C>id='TAXMM_4', left=37, top=1037, right=95, bottom=1098, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                        ";	
	ls_for += " 	<C>id='TAXDT_4', left=103, top=1037, right=164, bottom=1098, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                      ";	
	ls_for += " 	<C>id='VSEQ_10', left=1783, top=230, right=1828, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";	
	ls_for += " 	<C>id='VSEQ_9', left=1730, top=230, right=1775, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     ";	
  ls_for += " 	<C>id='VSEQ_8', left=1677, top=230, right=1722, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     ";
	ls_for += " 	<C>id='VSEQ_7', left=1625, top=230, right=1670, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     ";	
	ls_for += " 	<C>id='VSEQ_6', left=1572, top=230, right=1617, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     ";	
	ls_for += " 	<T>id='-' ,left=1519 ,top=230 ,right=1564 ,bottom=315 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                          ";	
	ls_for += " 	<C>id='VSEQ_5', left=1466, top=230, right=1508, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     ";	
	ls_for += " 	<C>id='VSEQ_4', left=1413, top=230, right=1455, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     ";
	ls_for += " 	<T>id='-' ,left=1360 ,top=230 ,right=1402 ,bottom=315 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                          ";	
	ls_for += " 	<C>id='VSEQ_3', left=1307, top=230, right=1349, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     ";	
	ls_for += " 	<C>id='VSEQ_2', left=1254, top=230, right=1296, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     ";	
	ls_for += " 	<C>id='VSEQ_1', left=1201, top=230, right=1244, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                     ";	
  ls_for += " 	<C>id='SEQ_1', left=1519, top=156, right=1564, bottom=222, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                      ";
	ls_for += " 	<C>id='{decode(TAXSTD_1,'0','',TAXSTD_1)}', left=616, top=831, right=712, bottom=892, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>             ";	
	ls_for += " 	<C>id='{decode(TAXSTD_2,'0','',TAXSTD_2)}', left=616, top=900, right=712, bottom=958, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>             ";	
	ls_for += " 	<C>id='{decode(TAXSTD_3,'0','',TAXSTD_3)}', left=616, top=968, right=712, bottom=1029, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>            ";	
	ls_for += " 	<C>id='{decode(TAXSTD_4,'0','',TAXSTD_4)}', left=616, top=1037, right=712, bottom=1098, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>           ";	
  ls_for += " 	<C>id='{decode(TAXQTY_1,'0','',TAXQTY_1)}', left=722, top=831, right=820, bottom=892, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                           ";
	ls_for += " 	<C>id='{decode(TAXQTY_2,'0','',TAXQTY_2)}', left=722, top=900, right=820, bottom=958, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                           ";	
	ls_for += " 	<C>id='{decode(TAXQTY_3,'0','',TAXQTY_3)}', left=722, top=968, right=820, bottom=1029, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                          ";	
	ls_for += " 	<C>id='{decode(TAXQTY_4,'0','',TAXQTY_4)}', left=722, top=1037, right=820, bottom=1098, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                         ";	
	ls_for += " 	<C>id='{decode(TAXPRIC_1,'0','',TAXPRIC_1)}', left=828, top=831, right=1085, bottom=892, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>         ";	
  ls_for += " 	<C>id='{decode(TAXPRIC_2,'0','',TAXPRIC_2)}', left=828, top=2270, right=1085, bottom=2328, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>       ";
	ls_for += " 	<C>id='{decode(TAXPRIC_3,'0','',TAXPRIC_3)}', left=828, top=2336, right=1085, bottom=2397, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>       ";	
	ls_for += " 	<C>id='{decode(TAXPRIC_4,'0','',TAXPRIC_4)}', left=828, top=2405, right=1085, bottom=2466, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>       ";	
	ls_for += " 	<C>id='{decode(TAXSUM_1,'0','',TAXSUM_1)}', left=1093, top=831, right=1402, bottom=892, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>          ";	
	ls_for += " 	<C>id='{decode(TAXSUM_2,'0','',TAXSUM_2)}', left=1093, top=900, right=1402, bottom=958, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>          ";	
  ls_for += " 	<C>id='{decode(TAXSUM_3,'0','',TAXSUM_3)}', left=1093, top=968, right=1402, bottom=1029, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>         ";
	ls_for += " 	<C>id='{decode(TAXSUM_4,'0','',TAXSUM_4)}', left=1093, top=1037, right=1402, bottom=1098, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>        ";	
	ls_for += " 	<C>id='{decode(TAXVATAMT_1,'0','',TAXVATAMT_1)}', left=1413, top=831, right=1691, bottom=892, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>    ";	
	ls_for += " 	<C>id='{decode(TAXVATAMT_2,'0','',TAXVATAMT_2)}', left=1413, top=900, right=1691, bottom=958, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>    ";	
	ls_for += " 	<C>id='{decode(TAXVATAMT_3,'0','',TAXVATAMT_3)}', left=1413, top=968, right=1691, bottom=1029, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>   ";	
  ls_for += " 	<C>id='{decode(TAXVATAMT_4,'0','',TAXVATAMT_4)}', left=1413, top=1037, right=1691, bottom=1098, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>  ";
	ls_for += " 	<C>id='VSEQ_1', left=1201, top=1601, right=1244, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";	
	ls_for += " 	<C>id='VSEQ_2', left=1254, top=1601, right=1296, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";	
	ls_for += " 	<C>id='VSEQ_3', left=1307, top=1601, right=1349, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";	
	ls_for += " 	<T>id='-' ,left=1360 ,top=1601 ,right=1402 ,bottom=1683 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                        ";	
  ls_for += " 	<C>id='VSEQ_4', left=1413, top=1601, right=1455, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
	ls_for += " 	<C>id='VSEQ_5', left=1466, top=1601, right=1508, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";	
	ls_for += " 	<T>id='-' ,left=1519 ,top=1601 ,right=1564 ,bottom=1683 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                        ";	
	ls_for += " 	<C>id='VSEQ_6', left=1572, top=1601, right=1617, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";	
	ls_for += " 	<C>id='VSEQ_7', left=1625, top=1601, right=1670, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";	
  ls_for += " 	<C>id='VSEQ_8', left=1677, top=1601, right=1722, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";
	ls_for += " 	<C>id='VSEQ_9', left=1730, top=1601, right=1775, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   ";	
	ls_for += " 	<C>id='VSEQ_10', left=1783, top=1601, right=1828, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                  ";	
	ls_for += " 	<C>id='SEQ_1', left=1519, top=1524, right=1564, bottom=1590, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";	
	ls_for += " 	<C>id='SEQ_2', left=1572, top=1524, right=1617, bottom=1590, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";	
  ls_for += " 	<C>id='SEQ_3', left=1625, top=1524, right=1670, bottom=1590, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";
	ls_for += " 	<C>id='SEQ_4', left=1677, top=1524, right=1722, bottom=1590, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";	
	ls_for += " 	<C>id='SEQ_5', left=1730, top=1524, right=1775, bottom=1590, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";	
	ls_for += " 	<C>id='SEQ_6', left=1783, top=1524, right=1828, bottom=1590, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                    ";	
	ls_for += " 	<C>id='{decode(TAXSTD_1,'0','',TAXSTD_1)}', left=616, top=2199, right=712, bottom=2260, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>           ";	
  ls_for += " 	<C>id='{decode(TAXSTD_2,'0','',TAXSTD_2)}', left=616, top=2270, right=712, bottom=2328, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>           ";
	ls_for += " 	<C>id='{decode(TAXSTD_3,'0','',TAXSTD_3)}', left=616, top=2336, right=712, bottom=2397, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>           ";	
	ls_for += " 	<C>id='{decode(TAXSTD_4,'0','',TAXSTD_4)}', left=616, top=2405, right=712, bottom=2466, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>           ";	
	ls_for += " 	<C>id='{decode(TAXQTY_1,'0','',TAXQTY_1)}', left=722, top=2199, right=820, bottom=2260, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                         ";	
	ls_for += " 	<C>id='{decode(TAXQTY_2,'0','',TAXQTY_2)}', left=722, top=2270, right=820, bottom=2328, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                         ";	
  ls_for += " 	<C>id='{decode(TAXQTY_3,'0','',TAXQTY_3)}', left=722, top=2336, right=820, bottom=2397, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                         ";
	ls_for += " 	<C>id='{decode(TAXQTY_4,'0','',TAXQTY_4)}', left=722, top=2405, right=820, bottom=2466, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                         ";	
	ls_for += " 	<C>id='{decode(TAXPRIC_1,'0','',TAXPRIC_1)}', left=828, top=2199, right=1085, bottom=2260, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>       ";	
	ls_for += " 	<C>id='{decode(TAXPRIC_2,'0','',TAXPRIC_2)}', left=828, top=900, right=1085, bottom=958, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>         ";	
	ls_for += " 	<C>id='{decode(TAXPRIC_3,'0','',TAXPRIC_3)}', left=828, top=968, right=1085, bottom=1029, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>        ";	
  ls_for += " 	<C>id='{decode(TAXPRIC_4,'0','',TAXPRIC_4)}', left=828, top=1037, right=1085, bottom=1098, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>       ";
	ls_for += " 	<C>id='{decode(TAXSUM_1,'0','',TAXSUM_1)}', left=1093, top=2199, right=1402, bottom=2260, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>        ";	
	ls_for += " 	<C>id='{decode(TAXSUM_2,'0','',TAXSUM_2)}', left=1093, top=2270, right=1402, bottom=2328, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>        ";	
	ls_for += " 	<C>id='{decode(TAXSUM_3,'0','',TAXSUM_3)}', left=1093, top=2336, right=1402, bottom=2397, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>        ";	
	ls_for += " 	<C>id='{decode(TAXSUM_4,'0','',TAXSUM_4)}', left=1093, top=2405, right=1402, bottom=2466, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>        ";	
	ls_for += " 	<C>id='{decode(TAXVATAMT_1,'0','',TAXVATAMT_1)}', left=1413, top=2199, right=1691, bottom=2260, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>  ";
	ls_for += " 	<C>id='{decode(TAXVATAMT_2,'0','',TAXVATAMT_2)}', left=1413, top=2270, right=1691, bottom=2328, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>  ";	
	ls_for += " 	<C>id='{decode(TAXVATAMT_3,'0','',TAXVATAMT_3)}', left=1413, top=2336, right=1691, bottom=2397, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>  ";	
	ls_for += " 	<C>id='{decode(TAXVATAMT_4,'0','',TAXVATAMT_4)}', left=1413, top=2405, right=1691, bottom=2466, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>  ";	
	ls_for += " 	<C>id='BIGO_1', left=1701, top=831, right=1828, bottom=892, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                       ";	
  ls_for += " 	<C>id='BIGO_2', left=1701, top=900, right=1828, bottom=958, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                       ";
	ls_for += " 	<C>id='BIGO_3', left=1701, top=968, right=1828, bottom=1029, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                      ";	
	ls_for += " 	<C>id='BIGO_4', left=1701, top=1037, right=1828, bottom=1098, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                     ";	
	ls_for += " 	<T>id='-' ,left=616 ,top=233 ,right=659 ,bottom=315 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                            ";	
	ls_for += " 	<T>id='-' ,left=455 ,top=233 ,right=500 ,bottom=315 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                            ";	
  ls_for += " 	<L> left=32 ,top=2588 ,right=1834 ,bottom=2588 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                         ";
	ls_for += " 	<T>id='인쇄용지(특급)34g/m2 182mmx128mm' ,left=1098 ,top=2598 ,right=1839 ,bottom=2638 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>           ";	
	ls_for += " 	<T>id='22226-28131일 ‘96.3.27승인' ,left=32 ,top=2598 ,right=585 ,bottom=2638 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                     ";	
	ls_for += " 	<C>id='BIGO_4', left=1701, top=2405, right=1828, bottom=2466, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                     ";	
	ls_for += " 	<C>id='BIGO_3', left=1701, top=2336, right=1828, bottom=2397, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                     ";	
  ls_for += " 	<C>id='BIGO_2', left=1701, top=2270, right=1828, bottom=2328, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                     ";
	ls_for += " 	<C>id='BIGO_1', left=1701, top=2199, right=1828, bottom=2260, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                     ";	
	ls_for += " 	<C>id='TAXDT_4', left=103, top=2405, right=164, bottom=2466, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                      ";	
	ls_for += " 	<C>id='TAXMM_4', left=37, top=2405, right=95, bottom=2466, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                        ";	
	ls_for += " 	<C>id='TAXMM_3', left=37, top=2336, right=95, bottom=2397, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                        ";	
  ls_for += " 	<C>id='TAXDT_3', left=103, top=2336, right=164, bottom=2397, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                      ";
	ls_for += " 	<C>id='TAXDT_2', left=103, top=2270, right=164, bottom=2328, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                      ";	
	ls_for += " 	<C>id='TAXMM_2', left=37, top=2270, right=95, bottom=2328, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                        ";	
	ls_for += " 	<C>id='TAXDT_1', left=103, top=2199, right=164, bottom=2260, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                      ";	
	ls_for += " 	<C>id='TAXMM_1', left=37, top=2199, right=95, bottom=2260, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                        ";	
  ls_for += " 	<L> left=32 ,top=2519 ,right=1405 ,bottom=2519 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";
	ls_for += " 	<T>id='외상미수금' ,left=1151 ,top=2474 ,right=1402 ,bottom=2516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                               ";	
	ls_for += " 	<T>id='어  음' ,left=884 ,top=2474 ,right=1140 ,bottom=2516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    ";	
	ls_for += " 	<T>id='수  표' ,left=616 ,top=2474 ,right=876 ,bottom=2516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                     ";	
	ls_for += " 	<T>id='현  금' ,left=352 ,top=2474 ,right=606 ,bottom=2516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                     ";	
  ls_for += " 	<T>id='합계금액' ,left=40 ,top=2474 ,right=344 ,bottom=2516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    ";
	ls_for += " 	<L> left=32 ,top=2469 ,right=1834 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<C>id='TAXPDTNAM_4', left=172, top=2405, right=606, bottom=2466, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                  ";	
	ls_for += " 	<C>id='TAXPDTNAM_3', left=172, top=2336, right=606, bottom=2397, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                  ";	
	ls_for += " 	<C>id='TAXPDTNAM_2', left=172, top=2270, right=606, bottom=2328, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                  ";	
  ls_for += " 	<C>id='TAXPDTNAM_1', left=172, top=2199, right=606, bottom=2260, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                  ";
	ls_for += " 	<T>id='공급받는자' ,left=987 ,top=1471 ,right=1296 ,bottom=1511 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                ";	
	ls_for += " 	<T>id='보  관  용' ,left=987 ,top=1529 ,right=1296 ,bottom=1572 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                ";	
	ls_for += " 	<L> left=32 ,top=2400 ,right=1834 ,bottom=2400 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=770 ,top=2024 ,right=770 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
  ls_for += " 	<L> left=1513 ,top=1879 ,right=1513 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";
	ls_for += " 	<L> left=1513 ,top=1598 ,right=1513 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=85 ,top=1593 ,right=85 ,bottom=1971 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                           ";	
	ls_for += " 	<L> left=929 ,top=1593 ,right=929 ,bottom=1971 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=929 ,top=1598 ,right=929 ,bottom=1783 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                         ";	
  ls_for += " 	<L> left=291 ,top=1593 ,right=291 ,bottom=1783 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                         ";
	ls_for += " 	<L> left=1778 ,top=1598 ,right=1778 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1725 ,top=1598 ,right=1725 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1672 ,top=1598 ,right=1672 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1566 ,top=1598 ,right=1566 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                       ";	
  ls_for += " 	<L> left=1458 ,top=1598 ,right=1458 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                       ";
	ls_for += " 	<L> left=1405 ,top=1598 ,right=1405 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1352 ,top=1598 ,right=1352 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1299 ,top=1598 ,right=1299 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1246 ,top=1598 ,right=1246 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                       ";	
  ls_for += " 	<L> left=1458 ,top=2024 ,right=1458 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";
	ls_for += " 	<L> left=1352 ,top=2024 ,right=1352 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1299 ,top=2024 ,right=1299 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1246 ,top=2024 ,right=1246 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1193 ,top=2024 ,right=1193 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1140 ,top=2024 ,right=1140 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";
	ls_for += " 	<L> left=1035 ,top=2024 ,right=1035 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=929 ,top=2024 ,right=929 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=876 ,top=2024 ,right=876 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=664 ,top=2024 ,right=664 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
  ls_for += " 	<L> left=609 ,top=2024 ,right=609 ,bottom=2588 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";
	ls_for += " 	<L> left=32 ,top=2331 ,right=1834 ,bottom=2331 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=32 ,top=2262 ,right=1834 ,bottom=2262 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=32 ,top=2193 ,right=1834 ,bottom=2193 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<T>id='일' ,left=103 ,top=2151 ,right=164 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";	
  ls_for += " 	<T>id='품        목' ,left=172 ,top=2151 ,right=606 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                               ";
	ls_for += " 	<T>id='규격' ,left=616 ,top=2151 ,right=712 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       ";	
	ls_for += " 	<T>id='수량' ,left=722 ,top=2151 ,right=820 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       ";	
	ls_for += " 	<T>id='단    가' ,left=828 ,top=2151 ,right=1085 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                  ";	
	ls_for += " 	<T>id='공 급 가 액' ,left=1093 ,top=2151 ,right=1402 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                              ";	
  ls_for += " 	<T>id='세       액' ,left=1413 ,top=2151 ,right=1691 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                              ";
	ls_for += " 	<T>id='비고' ,left=1701 ,top=2151 ,right=1828 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                     ";	
	ls_for += " 	<T>id='월' ,left=37 ,top=2151 ,right=95 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                           ";	
	ls_for += " 	<L> left=982 ,top=1593 ,right=982 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=556 ,top=2024 ,right=556 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
  ls_for += " 	<L> left=503 ,top=2024 ,right=503 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";
	ls_for += " 	<L> left=450 ,top=2024 ,right=450 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=291 ,top=1593 ,right=291 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=228 ,top=2024 ,right=228 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=32 ,top=2077 ,right=1513 ,bottom=2077 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
  ls_for += " 	<T>id='월' ,left=172 ,top=2032 ,right=225 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";
	ls_for += " 	<T>id='년' ,left=37 ,top=2032 ,right=164 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                          ";	
	ls_for += " 	<L> left=32 ,top=2140 ,right=1834 ,bottom=2140 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<T>id='십' ,left=987 ,top=2032 ,right=1032 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                        ";	
	ls_for += " 	<T>id='십' ,left=1413 ,top=2032 ,right=1455 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       ";	
  ls_for += " 	<T>id='백' ,left=1360 ,top=2032 ,right=1402 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       ";
	ls_for += " 	<T>id='천' ,left=1307 ,top=2032 ,right=1349 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       ";	
	ls_for += " 	<T>id='만' ,left=1254 ,top=2032 ,right=1296 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       ";	
	ls_for += " 	<T>id='십' ,left=1201 ,top=2032 ,right=1244 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       ";	
	ls_for += " 	<T>id='백' ,left=1148 ,top=2032 ,right=1191 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       ";	
  ls_for += " 	<T>id='천' ,left=1093 ,top=2032 ,right=1138 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       ";
	ls_for += " 	<T>id='억' ,left=1040 ,top=2032 ,right=1085 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       ";	
	ls_for += " 	<T>id='십' ,left=455 ,top=2032 ,right=500 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='일' ,left=934 ,top=2032 ,right=979 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='천' ,left=564 ,top=2032 ,right=606 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";	
  ls_for += " 	<T>id='백' ,left=616 ,top=2032 ,right=659 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";
	ls_for += " 	<T>id='십' ,left=669 ,top=2032 ,right=712 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='만' ,left=722 ,top=2032 ,right=767 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='천' ,left=775 ,top=2032 ,right=820 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='백' ,left=828 ,top=2032 ,right=873 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";	
  ls_for += " 	<T>id='십' ,left=881 ,top=2032 ,right=926 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";
	ls_for += " 	<T>id='억' ,left=508 ,top=2032 ,right=553 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='백' ,left=402 ,top=2032 ,right=447 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='공란수' ,left=296 ,top=2032 ,right=394 ,bottom=2074 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                       ";	
	ls_for += " 	<T>id='일' ,left=233 ,top=2032 ,right=288 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";	
  ls_for += " 	<T>id='일' ,left=1466 ,top=2032 ,right=1508 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       ";
	ls_for += " 	<L> left=32 ,top=2024 ,right=1834 ,bottom=2024 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<T>id='작      성' ,left=37 ,top=1982 ,right=288 ,bottom=2021 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                  ";	
	ls_for += " 	<T>id='공     급     가     액' ,left=296 ,top=1982 ,right=979 ,bottom=2021 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                    ";	
	ls_for += " 	<T>id='세              액' ,left=987 ,top=1982 ,right=1508 ,bottom=2021 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                        ";	
  ls_for += " 	<T>id='비        고' ,left=1519 ,top=1982 ,right=1828 ,bottom=2021 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                             ";
	ls_for += " 	<L> left=32 ,top=1971 ,right=1834 ,bottom=1971 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<T>id='종' ,left=1519 ,top=1884 ,right=1564 ,bottom=1926 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       ";	
	ls_for += " 	<T>id='목' ,left=1519 ,top=1929 ,right=1564 ,bottom=1969 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       ";	
	ls_for += " 	<T>id='종' ,left=616 ,top=1884 ,right=659 ,bottom=1926 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='목' ,left=616 ,top=1929 ,right=659 ,bottom=1969 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";
	ls_for += " 	<T>id='업     태' ,left=987 ,top=1884 ,right=1191 ,bottom=1966 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                 ";	
	ls_for += " 	<C>id='BSNS_CND', left=1201, top=1884, right=1508, bottom=1966, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                   ";	
	ls_for += " 	<C>id='BSNS_KND', left=1572, top=1884, right=1828, bottom=1966, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                   ";	
	ls_for += " 	<T>id='업     태' ,left=90 ,top=1884 ,right=288 ,bottom=1966 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                   ";	
  ls_for += " 	<T>id='서비스' ,left=296 ,top=1884 ,right=606 ,bottom=1966 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                       ";
	ls_for += " 	<L> left=982 ,top=1879 ,right=1834 ,bottom=1879 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                        ";	
	ls_for += " 	<L> left=85 ,top=1879 ,right=929 ,bottom=1879 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                          ";	
	ls_for += " 	<T>id='서울시 종로구 계동 140-2' ,left=296 ,top=1791 ,right=926 ,bottom=1876 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                     ";	
	ls_for += " 	<C>id='ADDNM', left=1201, top=1799, right=1831, bottom=1876, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                      ";	
  ls_for += " 	<T>id='주     소' ,left=90 ,top=1834 ,right=288 ,bottom=1876 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                   ";
	ls_for += " 	<T>id='사 업 장' ,left=90 ,top=1791 ,right=288 ,bottom=1831 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    ";	
	ls_for += " 	<L> left=291 ,top=1783 ,right=929 ,bottom=1783 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=982 ,top=1783 ,right=1834 ,bottom=1783 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                        ";	
	ls_for += " 	<C>id='VEND_NM', left=1201, top=1707, right=1508, bottom=1781, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                    ";	
  ls_for += " 	<C>id='VD_DIRECT', left=1572, top=1696, right=1778, bottom=1781, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                  ";
	ls_for += " 	<T>id='인' ,left=1783 ,top=1696 ,right=1828 ,bottom=1781 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       ";	
	ls_for += " 	<T>id='"+g_ceoname+"' ,left=669 ,top=1693 ,right=876 ,bottom=1778 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                       ";	
	ls_for += " 	<T>id='인' ,left=881 ,top=1693 ,right=926 ,bottom=1781 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='명' ,left=616 ,top=1738 ,right=659 ,bottom=1778 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";	
  ls_for += " 	<T>id='성' ,left=616 ,top=1693 ,right=659 ,bottom=1733 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";
	ls_for += " 	<T>id='현대아산주식회사' ,left=299 ,top=1693 ,right=606 ,bottom=1778 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                             ";	
	ls_for += " 	<T>id='상    호' ,left=90 ,top=1693 ,right=288 ,bottom=1733 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    ";	
	ls_for += " 	<T>id='(법인명)' ,left=90 ,top=1738 ,right=288 ,bottom=1781 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    ";	
	ls_for += " 	<T>id='상    호' ,left=987 ,top=1693 ,right=1191 ,bottom=1733 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                  ";	
  ls_for += " 	<T>id='(법인명)' ,left=987 ,top=1738 ,right=1191 ,bottom=1781 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                  ";
	ls_for += " 	<T>id='등록번호' ,left=987 ,top=1601 ,right=1191 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                  ";	
	ls_for += " 	<L> left=85 ,top=1688 ,right=929 ,bottom=1688 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                          ";	
	ls_for += " 	<T>id='등록번호' ,left=90 ,top=1601 ,right=288 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    ";	
	ls_for += " 	<T>id='(                   )' ,left=987 ,top=1500 ,right=1296 ,bottom=1540 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                     ";	
  ls_for += " 	<L> left=32 ,top=1593 ,right=1834 ,bottom=1593 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";
	ls_for += " 	<T>id='일련번호' ,left=1307 ,top=1524 ,right=1508 ,bottom=1590 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                 ";	
	ls_for += " 	<T>id='책 번 호' ,left=1307 ,top=1450 ,right=1508 ,bottom=1516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                 ";	
	ls_for += " 	<L> left=1299 ,top=1519 ,right=1834 ,bottom=1519 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1193 ,top=1593 ,right=1834 ,bottom=1593 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                       ";	
  ls_for += " 	<T>id='공' ,left=934 ,top=1640 ,right=979 ,bottom=1696 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";
	ls_for += " 	<T>id='급' ,left=934 ,top=1701 ,right=979 ,bottom=1757 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='받' ,left=934 ,top=1759 ,right=979 ,bottom=1815 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='는' ,left=934 ,top=1818 ,right=979 ,bottom=1876 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";	
	ls_for += " 	<T>id='자' ,left=934 ,top=1879 ,right=979 ,bottom=1934 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                         ";	
  ls_for += " 	<T>id='급' ,left=37 ,top=1749 ,right=82 ,bottom=1828 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                           ";
	ls_for += " 	<T>id='성' ,left=1519 ,top=1696 ,right=1564 ,bottom=1738 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       ";	
	ls_for += " 	<T>id='명' ,left=1519 ,top=1741 ,right=1564 ,bottom=1781 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       ";	
	ls_for += " 	<L> left=291 ,top=1593 ,right=929 ,bottom=1593 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<T>id='공' ,left=37 ,top=1640 ,right=82 ,bottom=1720 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                           ";	
  ls_for += " 	<T>id='자' ,left=37 ,top=1852 ,right=82 ,bottom=1931 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                           ";
	ls_for += " 	<L> left=85 ,top=1783 ,right=929 ,bottom=1783 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                          ";	
	ls_for += " 	<L> left=609 ,top=228 ,right=609 ,bottom=325 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=609 ,top=508 ,right=609 ,bottom=603 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=609 ,top=1879 ,right=609 ,bottom=1971 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
  ls_for += " 	<L> left=664 ,top=1879 ,right=664 ,bottom=1971 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";
	ls_for += " 	<L> left=1725 ,top=1519 ,right=1725 ,bottom=1593 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1778 ,top=1519 ,right=1778 ,bottom=1593 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1566 ,top=1879 ,right=1566 ,bottom=1971 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1566 ,top=1519 ,right=1566 ,bottom=1593 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";	
  ls_for += " 	<T>id='사 업 장' ,left=987 ,top=1791 ,right=1191 ,bottom=1831 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                  ";
	ls_for += " 	<T>id='주     소' ,left=987 ,top=1834 ,right=1191 ,bottom=1876 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                 ";	
	ls_for += " 	<T>id='세 금 계 산 서' ,left=37 ,top=1434 ,right=984 ,bottom=1569 ,face='굴림' ,size=23 ,bold=true ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                               ";	
	ls_for += " 	<L> left=1193 ,top=1593 ,right=1193 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1193 ,top=225 ,right=1193 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<L> left=1193 ,top=1598 ,right=1193 ,bottom=1971 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";
	ls_for += " 	<L> left=98 ,top=773 ,right=98 ,bottom=1101 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                            ";	
	ls_for += " 	<L> left=167 ,top=656 ,right=167 ,bottom=1101 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                          ";	
	ls_for += " 	<L> left=717 ,top=656 ,right=717 ,bottom=1101 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                          ";	
	ls_for += " 	<L> left=823 ,top=656 ,right=823 ,bottom=1101 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                          ";	
  ls_for += " 	<L> left=878 ,top=1101 ,right=878 ,bottom=1220 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";
	ls_for += " 	<L> left=347 ,top=1101 ,right=347 ,bottom=1220 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<L> left=1087 ,top=656 ,right=1087 ,bottom=1101 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        ";	
	ls_for += " 	<L> left=1143 ,top=1101 ,right=1143 ,bottom=1220 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1405 ,top=656 ,right=1405 ,bottom=1220 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        ";	
  ls_for += " 	<L> left=1693 ,top=773 ,right=1693 ,bottom=1101 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        ";
	ls_for += " 	<L> left=1405 ,top=228 ,right=1405 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<L> left=717 ,top=228 ,right=717 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=823 ,top=228 ,right=823 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=344 ,top=228 ,right=344 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
  ls_for += " 	<L> left=1193 ,top=1688 ,right=1831 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                       ";
	ls_for += " 	<L> left=98 ,top=2140 ,right=98 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                           ";	
	ls_for += " 	<L> left=167 ,top=2024 ,right=167 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=347 ,top=2469 ,right=347 ,bottom=2588 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=717 ,top=2024 ,right=717 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
  ls_for += " 	<L> left=823 ,top=2024 ,right=823 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";
	ls_for += " 	<L> left=878 ,top=2469 ,right=878 ,bottom=2588 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=1087 ,top=2024 ,right=1087 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1143 ,top=2469 ,right=1143 ,bottom=2588 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1405 ,top=2024 ,right=1405 ,bottom=2588 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";	
  ls_for += " 	<L> left=1693 ,top=2140 ,right=1693 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";
	ls_for += " 	<L> left=397 ,top=2024 ,right=397 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<T>id='-' ,left=616 ,top=1601 ,right=659 ,bottom=1683 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                          ";	
	ls_for += " 	<T>id='-' ,left=455 ,top=1601 ,right=500 ,bottom=1683 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                          ";	
	ls_for += " 	<L> left=556 ,top=1598 ,right=556 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                         ";	
  ls_for += " 	<L> left=503 ,top=1598 ,right=503 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                         ";
	ls_for += " 	<L> left=450 ,top=1598 ,right=450 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=397 ,top=1598 ,right=397 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=344 ,top=1598 ,right=344 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=876 ,top=1598 ,right=876 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                         ";	
  ls_for += " 	<L> left=823 ,top=1598 ,right=823 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                         ";
	ls_for += " 	<L> left=770 ,top=1598 ,right=770 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=717 ,top=1598 ,right=717 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=664 ,top=1598 ,right=664 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=609 ,top=1598 ,right=609 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                         ";	
  ls_for += " 	<L> left=609 ,top=1598 ,right=609 ,bottom=1783 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";
	ls_for += " 	<L> left=609 ,top=228 ,right=609 ,bottom=415 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=664 ,top=1598 ,right=664 ,bottom=1783 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<L> left=664 ,top=228 ,right=664 ,bottom=325 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                           ";	
	ls_for += " 	<L> left=982 ,top=1688 ,right=1834 ,bottom=1688 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                        ";	
  ls_for += " 	<L> left=1513 ,top=1683 ,right=1513 ,bottom=1783 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";
	ls_for += " 	<L> left=1566 ,top=1683 ,right=1566 ,bottom=1783 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1566 ,top=315 ,right=1566 ,bottom=415 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<L> left=1513 ,top=312 ,right=1513 ,bottom=415 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<L> left=24 ,top=1386 ,right=1834 ,bottom=1386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>                                                                                                                           ";	
  ls_for += " 	<L> left=32 ,top=74 ,right=1834 ,bottom=74 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                             ";
	ls_for += " 	<T>id='[별지 제11호 서식]' ,left=29 ,top=37 ,right=434 ,bottom=71 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                 ";	
	ls_for += " 	<L> left=32 ,top=1445 ,right=1834 ,bottom=1445 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                         ";	
	ls_for += " 	<T>id='[별지 제11호 서식]' ,left=32 ,top=1405 ,right=439 ,bottom=1442 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                             ";	
	ls_for += " 	<L> left=32 ,top=1445 ,right=32 ,bottom=2588 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                           ";	
  ls_for += " 	<L> left=29 ,top=74 ,right=29 ,bottom=1220 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                             ";
	ls_for += " 	<L> left=1834 ,top=74 ,right=1834 ,bottom=1220 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<L> left=1299 ,top=1445 ,right=1299 ,bottom=1598 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1513 ,top=1445 ,right=1513 ,bottom=1598 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1672 ,top=1445 ,right=1672 ,bottom=1598 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1513 ,top=74 ,right=1513 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                          ";
	ls_for += " 	<L> left=1299 ,top=74 ,right=1299 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                          ";	
	ls_for += " 	<T>id='1' ,left=296 ,top=233 ,right=341 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                            ";	
	ls_for += " 	<T>id='0' ,left=349 ,top=233 ,right=394 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                            ";	
	ls_for += " 	<T>id='0' ,left=349 ,top=233 ,right=394 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                            ";	
  ls_for += " 	<T>id='1' ,left=402 ,top=233 ,right=447 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                            ";
	ls_for += " 	<T>id='8' ,left=508 ,top=233 ,right=553 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                            ";	
	ls_for += " 	<T>id='5' ,left=564 ,top=233 ,right=606 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                            ";	
	ls_for += " 	<T>id='1' ,left=669 ,top=233 ,right=712 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                            ";	
	ls_for += " 	<T>id='0' ,left=722 ,top=233 ,right=767 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                            ";	
  ls_for += " 	<T>id='6' ,left=775 ,top=233 ,right=820 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                            ";
	ls_for += " 	<T>id='9' ,left=828 ,top=233 ,right=873 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                            ";	
	ls_for += " 	<T>id='5' ,left=881 ,top=233 ,right=926 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                            ";	
	ls_for += " 	<T>id='1' ,left=402 ,top=1603 ,right=447 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                          ";	
	ls_for += " 	<T>id='8' ,left=508 ,top=1603 ,right=553 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                          ";	
  ls_for += " 	<T>id='5' ,left=564 ,top=1603 ,right=606 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                          ";
	ls_for += " 	<T>id='1' ,left=669 ,top=1603 ,right=712 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                          ";	
	ls_for += " 	<T>id='0' ,left=722 ,top=1603 ,right=767 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                          ";	
	ls_for += " 	<T>id='6' ,left=775 ,top=1603 ,right=820 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                          ";	
	ls_for += " 	<T>id='9' ,left=828 ,top=1603 ,right=873 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                          ";	
  ls_for += " 	<T>id='5' ,left=881 ,top=1603 ,right=926 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                          ";
	ls_for += " 	<T>id='1' ,left=296 ,top=1603 ,right=341 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                          ";	
	ls_for += " 	<T>id='0' ,left=349 ,top=1603 ,right=394 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                          ";	
	ls_for += " 	<C>id='TAXDAT', left=37, top=717, right=164, bottom=767 ,mask='XXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                    ";	
	ls_for += " 	<C>id='TAXMM_1', left=172, top=717, right=225, bottom=767, align='left' ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                      ";	
  ls_for += " 	<C>id='TAXDT_1', left=233, top=717, right=288, bottom=767, align='left' ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                      ";
	ls_for += " 	<C>id='', left=1519, top=661, right=1828, bottom=767, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>                                             ";	
	ls_for += " 	<C>id='TAXDAT', left=37, top=2085, right=164, bottom=2135 ,mask='XXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                  ";	
	ls_for += " 	<C>id='TAXMM_1', left=172, top=2085, right=225, bottom=2135, align='left' ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                    ";	
	ls_for += " 	<C>id='TAXDT_1', left=233, top=2085, right=288, bottom=2135, align='left' ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                    ";	
  ls_for += " 	<C>id='', left=1519, top=2032, right=1828, bottom=2135, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>                                           ";
	ls_for += " 	<C>id='{MTAXSUM+MTAXVATAMT}', left=37, top=1156, right=344, bottom=1212, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                         ";	
	ls_for += " 	<C>id='{MTAXSUM+MTAXVATAMT}', left=37, top=2524, right=344, bottom=2580, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                         ";	
	ls_for += " 	<C>id='{decode(BlkCnt,'0','',BlkCnt)}', left=296, top=2085, right=394, bottom=2135 ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                  ";	
	ls_for += " 	<C>id='{decode(BlkCnt,'0','',BlkCnt)}', left=296, top=717, right=394, bottom=767 ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                    ";	
  ls_for += " 	<C>id='TSUM_1', left=934, top=717, right=979, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                                ";
	ls_for += " 	<C>id='TSUM_2', left=881, top=717, right=926, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                                ";	
	ls_for += " 	<C>id='TSUM_3', left=828, top=717, right=873, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                                ";	
	ls_for += " 	<C>id='TSUM_4', left=775, top=717, right=820, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                                ";	
	ls_for += " 	<C>id='TSUM_5', left=722, top=717, right=767, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                                ";	
  ls_for += " 	<C>id='TSUM_6', left=669, top=717, right=712, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                                ";
	ls_for += " 	<C>id='TSUM_7', left=616, top=717, right=659, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                                ";	
	ls_for += " 	<C>id='TSUM_8', left=564, top=717, right=606, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                                ";	
	ls_for += " 	<C>id='TSUM_9', left=508, top=717, right=553, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                                ";	
	ls_for += " 	<C>id='TSUM_10', left=455, top=717, right=500, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                               ";	
  ls_for += " 	<C>id='TSUM_11', left=402, top=717, right=447, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                               ";
	ls_for += " 	<C>id='TVAT_1', left=1466, top=717, right=1508, bottom=767 ,mask='X', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                    ";	
	ls_for += " 	<C>id='TVAT_2', left=1413, top=717, right=1455, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                              ";	
	ls_for += " 	<C>id='TVAT_3', left=1360, top=717, right=1402, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                              ";	
	ls_for += " 	<C>id='TVAT_4', left=1307, top=717, right=1349, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                              ";	
  ls_for += " 	<C>id='TVAT_5', left=1254, top=717, right=1296, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                              ";
	ls_for += " 	<C>id='TVAT_6', left=1201, top=717, right=1244, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                              ";	
	ls_for += " 	<C>id='TVAT_7', left=1148, top=717, right=1191, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                              ";	
	ls_for += " 	<C>id='TVAT_8', left=1093, top=717, right=1138, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                              ";	
	ls_for += " 	<C>id='TVAT_9', left=1040, top=717, right=1085, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                              ";	
  ls_for += " 	<C>id='TVAT_10', left=987, top=717, right=1032, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                              ";
	ls_for += " 	<C>id='TSUM_1', left=934, top=2085, right=979, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                              ";	
	ls_for += " 	<C>id='TSUM_2', left=881, top=2085, right=926, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                              ";	
	ls_for += " 	<C>id='TSUM_3', left=828, top=2085, right=873, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                              ";	
	ls_for += " 	<C>id='TSUM_4', left=775, top=2085, right=820, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                              ";	
	ls_for += " 	<C>id='TSUM_5', left=722, top=2085, right=767, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                              ";
	ls_for += " 	<C>id='TSUM_6', left=669, top=2085, right=712, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                              ";	
	ls_for += " 	<C>id='TSUM_7', left=616, top=2085, right=659, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                              ";	
	ls_for += " 	<C>id='TSUM_8', left=564, top=2085, right=606, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                              ";	
	ls_for += " 	<C>id='TSUM_9', left=508, top=2085, right=553, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                              ";	
  ls_for += " 	<C>id='TSUM_10', left=455, top=2085, right=500, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                             ";
	ls_for += " 	<C>id='TSUM_11', left=402, top=2085, right=447, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                             ";	
	ls_for += " 	<C>id='TVAT_1', left=1466, top=2085, right=1508, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                            ";	
	ls_for += " 	<C>id='TVAT_2', left=1413, top=2085, right=1455, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                            ";	
	ls_for += " 	<C>id='TVAT_3', left=1360, top=2085, right=1402, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                            ";	
  ls_for += " 	<C>id='TVAT_4', left=1307, top=2085, right=1349, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                            ";
	ls_for += " 	<C>id='TVAT_5', left=1254, top=2085, right=1296, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                            ";	
	ls_for += " 	<C>id='TVAT_6', left=1201, top=2085, right=1244, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                            ";	
	ls_for += " 	<C>id='TVAT_7', left=1148, top=2085, right=1191, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                            ";	
	ls_for += " 	<C>id='TVAT_8', left=1093, top=2085, right=1138, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                            ";	
  ls_for += " 	<C>id='TVAT_9', left=1040, top=2085, right=1085, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                            ";
	ls_for += " 	<C>id='TVAT_10', left=987, top=2085, right=1032, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                            ";	
	ls_for += " 	<C>id='SEQ_6', left=1783, top=153, right=1828, bottom=220, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                      ";	
	ls_for += " 	<C>id='SEQ_5', left=1730, top=153, right=1775, bottom=220, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                      ";	
	ls_for += " 	<C>id='SEQ_4', left=1677, top=153, right=1722, bottom=220, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                      ";	
  ls_for += " 	<C>id='SEQ_3', left=1625, top=153, right=1670, bottom=220, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                      ";
	ls_for += " 	<C>id='SEQ_2', left=1572, top=153, right=1617, bottom=220, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                      ";	
	ls_for += " 	<L> left=1672 ,top=228 ,right=1672 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                         ";	
	ls_for += " 	<L> left=1672 ,top=74 ,right=1672 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                          ";	
	ls_for += " 	<T>id='권' ,left=1627 ,top=82 ,right=1670 ,bottom=148 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                          ";	
  ls_for += " 	<T>id='호' ,left=1786 ,top=82 ,right=1828 ,bottom=148 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                          ";
	ls_for += " 	<C>id='CNT', left=1677, top=82, right=1783, bottom=148 ,mask='XXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                            ";	
	ls_for += " 	<L> left=1606 ,top=1521 ,right=1606 ,bottom=1595 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<L> left=1606 ,top=1598 ,right=1606 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                       ";	
	ls_for += " 	<C>id='TAXDAT', left=1519, top=82, right=1622, bottom=148 ,mask='XXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                  ";	
  ls_for += " 	<C>id='TAXDAT', left=1519, top=1450, right=1622, bottom=1516 ,mask='XXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF, Dec=0</C>                               ";
	ls_for += " 	<T>id='권' ,left=1627 ,top=1450 ,right=1670 ,bottom=1516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       ";	
	ls_for += " 	<C>id='CNT', left=1677, top=1450, right=1783, bottom=1516 ,mask='XXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>                                         ";	
	ls_for += " 	<T>id='호' ,left=1786 ,top=1450 ,right=1828 ,bottom=1516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       ";	
	ls_for += " 	<L> left=1834 ,top=1445 ,right=1834 ,bottom=2588 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                       ";	
  ls_for += " 	<T>id='함' ,left=1736 ,top=2474 ,right=1818 ,bottom=2580 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       ";
	ls_for += " 	<T>id='"+gclx_taxtype2.text+"' ,left=1590 ,top=2474 ,right=1730 ,bottom=2580 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                   ";	
	ls_for += " 	<T>id='위 금액을' ,left=1416 ,top=2474 ,right=1582 ,bottom=2580 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                ";	
	ls_for += " 	<T>id='위 금액을' ,left=1413 ,top=1106 ,right=1580 ,bottom=1212 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                ";	
	ls_for += " 	<T>id='"+gclx_taxtype2.text+"' ,left=1585 ,top=1106 ,right=1728 ,bottom=1212 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                   ";	
  ls_for += " 	<T>id='함' ,left=1736 ,top=1106 ,right=1818 ,bottom=1212 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                       ";
	ls_for += " 	<T>id='기타사업남북경제' ,left=669 ,top=516 ,right=926 ,bottom=556 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                ";	
	ls_for += " 	<T>id='협력사업' ,left=669 ,top=558 ,right=926 ,bottom=598 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                        ";	
	ls_for += " 	<T>id='기타사업남북경제' ,left=669 ,top=1884 ,right=926 ,bottom=1924 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                              ";	
	ls_for += " 	<T>id='협력사업' ,left=669 ,top=1926 ,right=926 ,bottom=1966 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                      ";	
  ls_for += " </B>                                                                                                                                                                                                                        ";
	
	gcrp_print.format = ls_for + gcrp_print.format;

}
function ln_RptFormat3() {

	var ls_for = "";

ls_for += " <B>id=default ,left=0,top=0 ,right=2000 ,bottom=2762 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                                    "
ls_for += " 	<T>id='자' ,left=37 ,top=484 ,right=82 ,bottom=561 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                          "
ls_for += " 	<T>id='공' ,left=37 ,top=273 ,right=82 ,bottom=349 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                          "
ls_for += " 	<L> left=291 ,top=225 ,right=929 ,bottom=225 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=1778 ,top=151 ,right=1778 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1725 ,top=151 ,right=1725 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1619 ,top=151 ,right=1619 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<T>id='명' ,left=1519 ,top=373 ,right=1564 ,bottom=413 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='성' ,left=1519 ,top=328 ,right=1564 ,bottom=368 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='주     소' ,left=987 ,top=468 ,right=1191 ,bottom=508 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                "
ls_for += " 	<T>id='급' ,left=37 ,top=381 ,right=82 ,bottom=458 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                          "
ls_for += " 	<T>id='자' ,left=934 ,top=508 ,right=979 ,bottom=566 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='는' ,left=934 ,top=450 ,right=979 ,bottom=505 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='받' ,left=934 ,top=392 ,right=979 ,bottom=447 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='급' ,left=934 ,top=331 ,right=979 ,bottom=386 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='공' ,left=934 ,top=273 ,right=979 ,bottom=328 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<L> left=1193 ,top=225 ,right=1834 ,bottom=225 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1299 ,top=151 ,right=1834 ,bottom=151 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<T>id='책 번 호' ,left=1307 ,top=82 ,right=1508 ,bottom=148 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                 "
ls_for += " 	<T>id='일련번호' ,left=1307 ,top=156 ,right=1508 ,bottom=222 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                "
ls_for += " 	<L> left=29 ,top=225 ,right=1834 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<T>id='(                   )' ,left=987 ,top=132 ,right=1296 ,bottom=172 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                    "
ls_for += " 	<T>id='세 금 계 산 서' ,left=37 ,top=66 ,right=984 ,bottom=201 ,face='굴림' ,size=23 ,bold=true ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                               "
ls_for += " 	<T>id='사 업 장' ,left=987 ,top=426 ,right=1191 ,bottom=466 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                 "
ls_for += " 	<T>id='등록번호' ,left=90 ,top=230 ,right=288 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                   "
ls_for += " 	<L> left=85 ,top=320 ,right=929 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         "
ls_for += " 	<L> left=982 ,top=320 ,right=1834 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                       "
ls_for += " 	<T>id='등록번호' ,left=987 ,top=230 ,right=1191 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                 "
ls_for += " 	<T>id='(법인명)' ,left=987 ,top=368 ,right=1191 ,bottom=413 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                 "
ls_for += " 	<T>id='상    호' ,left=987 ,top=325 ,right=1191 ,bottom=365 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                 "
ls_for += " 	<T>id='(법인명)' ,left=90 ,top=368 ,right=288 ,bottom=413 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                   "
ls_for += " 	<T>id='상    호' ,left=90 ,top=325 ,right=288 ,bottom=365 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                   "
ls_for += " 	<T>id='현대아산주식회사' ,left=299 ,top=325 ,right=606 ,bottom=410 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                            "
ls_for += " 	<T>id='성' ,left=616 ,top=325 ,right=659 ,bottom=365 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='명' ,left=616 ,top=368 ,right=659 ,bottom=410 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='인' ,left=881 ,top=325 ,right=926 ,bottom=413 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='"+g_ceoname+"' ,left=669 ,top=325 ,right=876 ,bottom=410 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                      "
ls_for += " 	<T>id='인' ,left=1783 ,top=328 ,right=1828 ,bottom=413 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<C>id='VD_DIRECT', left=1572, top=328, right=1778, bottom=413, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                 "
ls_for += " 	<C>id='VEND_NM', left=1201, top=336, right=1508, bottom=413, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                   "
ls_for += " 	<L> left=982 ,top=415 ,right=1834 ,bottom=415 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                       "
ls_for += " 	<L> left=85 ,top=415 ,right=929 ,bottom=415 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         "
ls_for += " 	<L> left=291 ,top=415 ,right=929 ,bottom=415 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<T>id='사 업 장' ,left=90 ,top=421 ,right=288 ,bottom=463 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                   "
ls_for += " 	<T>id='주     소' ,left=90 ,top=466 ,right=288 ,bottom=505 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                  "
ls_for += " 	<C>id='ADDNM', left=1201, top=431, right=1831, bottom=505, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                     "
ls_for += " 	<T>id='강원도 고성군 현내면 초도리 258-2' ,left=296 ,top=421 ,right=926 ,bottom=505 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>           "
ls_for += " 	<L> left=85 ,top=508 ,right=929 ,bottom=508 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         "
ls_for += " 	<L> left=982 ,top=508 ,right=1834 ,bottom=508 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                       "
ls_for += " 	<T>id='서비스' ,left=296 ,top=516 ,right=606 ,bottom=598 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                      "
ls_for += " 	<T>id='업     태' ,left=90 ,top=516 ,right=288 ,bottom=598 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                  "
ls_for += " 	<C>id='BSNS_KND', left=1572, top=516, right=1828, bottom=598, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                  "
ls_for += " 	<C>id='BSNS_CND', left=1201, top=516, right=1508, bottom=598, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                  "
ls_for += " 	<T>id='업     태' ,left=987 ,top=516 ,right=1191 ,bottom=598 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                "
ls_for += " 	<T>id='목' ,left=616 ,top=558 ,right=659 ,bottom=601 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='종' ,left=616 ,top=516 ,right=659 ,bottom=556 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='목' ,left=1519 ,top=558 ,right=1564 ,bottom=601 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='종' ,left=1519 ,top=516 ,right=1564 ,bottom=556 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<L> left=32 ,top=603 ,right=1834 ,bottom=603 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=1566 ,top=508 ,right=1566 ,bottom=603 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1566 ,top=151 ,right=1566 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<T>id='비        고' ,left=1519 ,top=611 ,right=1828 ,bottom=654 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                            "
ls_for += " 	<T>id='세              액' ,left=987 ,top=611 ,right=1508 ,bottom=654 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                       "
ls_for += " 	<T>id='공     급     가     액' ,left=296 ,top=611 ,right=979 ,bottom=654 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                   "
ls_for += " 	<T>id='작      성' ,left=37 ,top=611 ,right=288 ,bottom=654 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                 "
ls_for += " 	<L> left=29 ,top=656 ,right=1834 ,bottom=656 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<T>id='일' ,left=1466 ,top=661 ,right=1508 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='일' ,left=233 ,top=661 ,right=288 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='공란수' ,left=296 ,top=661 ,right=394 ,bottom=706 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                      "
ls_for += " 	<T>id='백' ,left=402 ,top=661 ,right=447 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='억' ,left=508 ,top=661 ,right=553 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='십' ,left=881 ,top=661 ,right=926 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='백' ,left=828 ,top=661 ,right=873 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='천' ,left=775 ,top=661 ,right=820 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='만' ,left=722 ,top=661 ,right=767 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='십' ,left=669 ,top=661 ,right=712 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='백' ,left=616 ,top=661 ,right=659 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='천' ,left=564 ,top=661 ,right=606 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='일' ,left=934 ,top=661 ,right=979 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='십' ,left=455 ,top=661 ,right=500 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='억' ,left=1040 ,top=661 ,right=1085 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='천' ,left=1093 ,top=661 ,right=1138 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='백' ,left=1148 ,top=661 ,right=1191 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='십' ,left=1201 ,top=661 ,right=1244 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='만' ,left=1254 ,top=661 ,right=1296 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='천' ,left=1307 ,top=661 ,right=1349 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='백' ,left=1360 ,top=661 ,right=1402 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='십' ,left=1413 ,top=661 ,right=1455 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='십' ,left=987 ,top=661 ,right=1032 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                       "
ls_for += " 	<L> left=32 ,top=773 ,right=1834 ,bottom=773 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<T>id='년' ,left=37 ,top=661 ,right=164 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                         "
ls_for += " 	<T>id='월' ,left=172 ,top=661 ,right=225 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<L> left=29 ,top=709 ,right=1513 ,bottom=709 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=228 ,top=656 ,right=228 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=291 ,top=225 ,right=291 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=397 ,top=656 ,right=397 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=450 ,top=656 ,right=450 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=503 ,top=656 ,right=503 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=556 ,top=656 ,right=556 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=664 ,top=508 ,right=664 ,bottom=603 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=982 ,top=225 ,right=982 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<T>id='월' ,left=37 ,top=781 ,right=95 ,bottom=823 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                          "
ls_for += " 	<T>id='비고' ,left=1701 ,top=781 ,right=1828 ,bottom=823 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<T>id='세       액' ,left=1413 ,top=781 ,right=1691 ,bottom=823 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                             "
ls_for += " 	<T>id='공 급 가 액' ,left=1093 ,top=781 ,right=1402 ,bottom=823 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                             "
ls_for += " 	<T>id='단    가' ,left=828 ,top=781 ,right=1085 ,bottom=823 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                 "
ls_for += " 	<T>id='수량' ,left=722 ,top=781 ,right=820 ,bottom=823 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='규격' ,left=616 ,top=781 ,right=712 ,bottom=823 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='품        목' ,left=172 ,top=781 ,right=606 ,bottom=823 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                              "
ls_for += " 	<T>id='일' ,left=103 ,top=781 ,right=164 ,bottom=823 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<L> left=29 ,top=826 ,right=1834 ,bottom=826 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=29 ,top=894 ,right=1834 ,bottom=894 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=29 ,top=963 ,right=1834 ,bottom=963 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=1193 ,top=320 ,right=1831 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=32 ,top=1220 ,right=1834 ,bottom=1220 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=397 ,top=228 ,right=397 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=450 ,top=228 ,right=450 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=503 ,top=228 ,right=503 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=556 ,top=228 ,right=556 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=609 ,top=656 ,right=609 ,bottom=1220 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                       "
ls_for += " 	<L> left=664 ,top=656 ,right=664 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=664 ,top=228 ,right=664 ,bottom=418 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=876 ,top=656 ,right=876 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=929 ,top=656 ,right=929 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=1035 ,top=656 ,right=1035 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1140 ,top=656 ,right=1140 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1193 ,top=656 ,right=1193 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1246 ,top=656 ,right=1246 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1299 ,top=656 ,right=1299 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1352 ,top=656 ,right=1352 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1458 ,top=656 ,right=1458 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=770 ,top=228 ,right=770 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=876 ,top=228 ,right=876 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=1246 ,top=228 ,right=1246 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1299 ,top=228 ,right=1299 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1352 ,top=228 ,right=1352 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1458 ,top=228 ,right=1458 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1566 ,top=228 ,right=1566 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1619 ,top=228 ,right=1619 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1725 ,top=228 ,right=1725 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1778 ,top=228 ,right=1778 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=291 ,top=225 ,right=291 ,bottom=415 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=929 ,top=228 ,right=929 ,bottom=415 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=929 ,top=225 ,right=929 ,bottom=603 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=1193 ,top=228 ,right=1193 ,bottom=603 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=85 ,top=225 ,right=85 ,bottom=603 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                          "
ls_for += " 	<L> left=1513 ,top=228 ,right=1513 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1513 ,top=508 ,right=1513 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=770 ,top=656 ,right=770 ,bottom=773 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=29 ,top=1032 ,right=1834 ,bottom=1032 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<T>id='22226-28131일 ‘96.3.27승인' ,left=32 ,top=1228 ,right=585 ,bottom=1270 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                  "
ls_for += " 	<T>id='인쇄용지(특급)34g/m2 182mmx128mm' ,left=1098 ,top=1228 ,right=1839 ,bottom=1270 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>        "
ls_for += " 	<T>id='공  급  자' ,left=987 ,top=101 ,right=1296 ,bottom=140 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                               "
ls_for += " 	<T>id='보  관  용' ,left=987 ,top=159 ,right=1296 ,bottom=204 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                               "
ls_for += " 	<C>id='TAXPDTNAM_1', left=172, top=831, right=606, bottom=892, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                 "
ls_for += " 	<C>id='TAXPDTNAM_2', left=172, top=900, right=606, bottom=958, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                 "
ls_for += " 	<C>id='TAXPDTNAM_3', left=172, top=968, right=606, bottom=1029, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                "
ls_for += " 	<C>id='TAXPDTNAM_4', left=172, top=1037, right=606, bottom=1098, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                               "
ls_for += " 	<L> left=29 ,top=1101 ,right=1834 ,bottom=1101 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<T>id='합계금액' ,left=40 ,top=1106 ,right=344 ,bottom=1148 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                 "
ls_for += " 	<T>id='현  금' ,left=352 ,top=1106 ,right=606 ,bottom=1148 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                  "
ls_for += " 	<T>id='수  표' ,left=616 ,top=1106 ,right=876 ,bottom=1148 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                  "
ls_for += " 	<T>id='어  음' ,left=884 ,top=1106 ,right=1140 ,bottom=1148 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                 "
ls_for += " 	<T>id='외상미수금' ,left=1151 ,top=1106 ,right=1402 ,bottom=1148 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                            "
ls_for += " 	<L> left=29 ,top=1151 ,right=1405 ,bottom=1151 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<C>id='TAXMM_1', left=37, top=831, right=95, bottom=892, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                       "
ls_for += " 	<C>id='TAXDT_1', left=103, top=831, right=164, bottom=892, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                     "
ls_for += " 	<C>id='TAXMM_2', left=37, top=900, right=95, bottom=958, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                       "
ls_for += " 	<C>id='TAXDT_2', left=103, top=900, right=164, bottom=958, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                     "
ls_for += " 	<C>id='TAXDT_3', left=103, top=968, right=164, bottom=1029, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                    "
ls_for += " 	<C>id='TAXMM_3', left=37, top=968, right=95, bottom=1029, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                      "
ls_for += " 	<C>id='TAXMM_4', left=37, top=1037, right=95, bottom=1098, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                     "
ls_for += " 	<C>id='TAXDT_4', left=103, top=1037, right=164, bottom=1098, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                   "
ls_for += " 	<C>id='VSEQ_10', left=1783, top=230, right=1828, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                 "
ls_for += " 	<C>id='VSEQ_9', left=1730, top=230, right=1775, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                  "
ls_for += " 	<C>id='VSEQ_8', left=1677, top=230, right=1722, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                  "
ls_for += " 	<C>id='VSEQ_7', left=1625, top=230, right=1670, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                  "
ls_for += " 	<C>id='VSEQ_6', left=1572, top=230, right=1617, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                  "
ls_for += " 	<T>id='-' ,left=1519 ,top=230 ,right=1564 ,bottom=315 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                       "
ls_for += " 	<C>id='VSEQ_5', left=1466, top=230, right=1508, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                  "
ls_for += " 	<C>id='VSEQ_4', left=1413, top=230, right=1455, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                  "
ls_for += " 	<T>id='-' ,left=1360 ,top=230 ,right=1402 ,bottom=315 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                       "
ls_for += " 	<C>id='VSEQ_3', left=1307, top=230, right=1349, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                  "
ls_for += " 	<C>id='VSEQ_2', left=1254, top=230, right=1296, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                  "
ls_for += " 	<C>id='VSEQ_1', left=1201, top=230, right=1244, bottom=315, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                  "
ls_for += " 	<C>id='SEQ_1', left=1519, top=156, right=1564, bottom=222, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   "
ls_for += " 	<C>id='{decode(TAXSTD_1,0,,TAXSTD_1)}', left=616, top=831, right=712, bottom=892, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>              "
ls_for += " 	<C>id='{decode(TAXSTD_2,0,,TAXSTD_2)}', left=616, top=900, right=712, bottom=958, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>              "
ls_for += " 	<C>id='{decode(TAXSTD_3,0,,TAXSTD_3)}', left=616, top=968, right=712, bottom=1029, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>             "
ls_for += " 	<C>id='{decode(TAXSTD_4,0,,TAXSTD_4)}', left=616, top=1037, right=712, bottom=1098, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>            "
ls_for += " 	<C>id='{decode(TAXQTY_1,0,,TAXQTY_1)}', left=722, top=831, right=820, bottom=892, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                            "
ls_for += " 	<C>id='{decode(TAXQTY_2,0,,TAXQTY_2)}', left=722, top=900, right=820, bottom=958, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                            "
ls_for += " 	<C>id='{decode(TAXQTY_3,0,,TAXQTY_3)}', left=722, top=968, right=820, bottom=1029, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                           "
ls_for += " 	<C>id='{decode(TAXQTY_4,0,,TAXQTY_4)}', left=722, top=1037, right=820, bottom=1098, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                          "
ls_for += " 	<C>id='{decode(TAXPRIC_1,0,,TAXPRIC_1)}', left=828, top=831, right=1085, bottom=892, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>          "
ls_for += " 	<C>id='{decode(TAXPRIC_2,0,,TAXPRIC_2)}', left=828, top=2270, right=1085, bottom=2328, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>        "
ls_for += " 	<C>id='{decode(TAXPRIC_3,0,,TAXPRIC_3)}', left=828, top=2336, right=1085, bottom=2397, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>        "
ls_for += " 	<C>id='{decode(TAXPRIC_4,0,,TAXPRIC_4)}', left=828, top=2405, right=1085, bottom=2466, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>        "
ls_for += " 	<C>id='{decode(TAXSUM_1,0,,TAXSUM_1)}', left=1093, top=831, right=1402, bottom=892, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>           "
ls_for += " 	<C>id='{decode(TAXSUM_2,0,,TAXSUM_2)}', left=1093, top=900, right=1402, bottom=958, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>           "
ls_for += " 	<C>id='{decode(TAXSUM_3,0,,TAXSUM_3)}', left=1093, top=968, right=1402, bottom=1029, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>          "
ls_for += " 	<C>id='{decode(TAXSUM_4,0,,TAXSUM_4)}', left=1093, top=1037, right=1402, bottom=1098, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>         "
ls_for += " 	<C>id='{decode(TAXVATAMT_1,0,,TAXVATAMT_1)}', left=1413, top=831, right=1691, bottom=892, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>     "
ls_for += " 	<C>id='{decode(TAXVATAMT_2,0,,TAXVATAMT_2)}', left=1413, top=900, right=1691, bottom=958, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>     "
ls_for += " 	<C>id='{decode(TAXVATAMT_3,0,,TAXVATAMT_3)}', left=1413, top=968, right=1691, bottom=1029, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>    "
ls_for += " 	<C>id='{decode(TAXVATAMT_4,0,,TAXVATAMT_4)}', left=1413, top=1037, right=1691, bottom=1098, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>   "
ls_for += " 	<C>id='VSEQ_1', left=1201, top=1601, right=1244, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                "
ls_for += " 	<C>id='VSEQ_2', left=1254, top=1601, right=1296, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                "
ls_for += " 	<C>id='VSEQ_3', left=1307, top=1601, right=1349, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                "
ls_for += " 	<T>id='-' ,left=1360 ,top=1601 ,right=1402 ,bottom=1683 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                     "
ls_for += " 	<C>id='VSEQ_4', left=1413, top=1601, right=1455, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                "
ls_for += " 	<C>id='VSEQ_5', left=1466, top=1601, right=1508, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                "
ls_for += " 	<T>id='-' ,left=1519 ,top=1601 ,right=1564 ,bottom=1683 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                     "
ls_for += " 	<C>id='VSEQ_6', left=1572, top=1601, right=1617, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                "
ls_for += " 	<C>id='VSEQ_7', left=1625, top=1601, right=1670, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                "
ls_for += " 	<C>id='VSEQ_8', left=1677, top=1601, right=1722, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                "
ls_for += " 	<C>id='VSEQ_9', left=1730, top=1601, right=1775, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                "
ls_for += " 	<C>id='VSEQ_10', left=1783, top=1601, right=1828, bottom=1683, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                               "
ls_for += " 	<C>id='SEQ_1', left=1519, top=1524, right=1564, bottom=1590, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                 "
ls_for += " 	<C>id='SEQ_2', left=1572, top=1524, right=1617, bottom=1590, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                 "
ls_for += " 	<C>id='SEQ_3', left=1625, top=1524, right=1670, bottom=1590, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                 "
ls_for += " 	<C>id='SEQ_4', left=1677, top=1524, right=1722, bottom=1590, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                 "
ls_for += " 	<C>id='SEQ_5', left=1730, top=1524, right=1775, bottom=1590, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                 "
ls_for += " 	<C>id='SEQ_6', left=1783, top=1524, right=1828, bottom=1590, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                 "
ls_for += " 	<C>id='{decode(TAXSTD_1,0,,TAXSTD_1)}', left=616, top=2199, right=712, bottom=2260, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>            "
ls_for += " 	<C>id='{decode(TAXSTD_2,0,,TAXSTD_2)}', left=616, top=2270, right=712, bottom=2328, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>            "
ls_for += " 	<C>id='{decode(TAXSTD_3,0,,TAXSTD_3)}', left=616, top=2336, right=712, bottom=2397, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>            "
ls_for += " 	<C>id='{decode(TAXSTD_4,0,,TAXSTD_4)}', left=616, top=2405, right=712, bottom=2466, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>            "
ls_for += " 	<C>id='{decode(TAXQTY_1,0,,TAXQTY_1)}', left=722, top=2199, right=820, bottom=2260, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                          "
ls_for += " 	<C>id='{decode(TAXQTY_2,0,,TAXQTY_2)}', left=722, top=2270, right=820, bottom=2328, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                          "
ls_for += " 	<C>id='{decode(TAXQTY_3,0,,TAXQTY_3)}', left=722, top=2336, right=820, bottom=2397, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                          "
ls_for += " 	<C>id='{decode(TAXQTY_4,0,,TAXQTY_4)}', left=722, top=2405, right=820, bottom=2466, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                          "
ls_for += " 	<C>id='{decode(TAXPRIC_1,0,,TAXPRIC_1)}', left=828, top=2199, right=1085, bottom=2260, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>        "
ls_for += " 	<C>id='{decode(TAXPRIC_2,0,,TAXPRIC_2)}', left=828, top=900, right=1085, bottom=958, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>          "
ls_for += " 	<C>id='{decode(TAXPRIC_3,0,,TAXPRIC_3)}', left=828, top=968, right=1085, bottom=1029, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>         "
ls_for += " 	<C>id='{decode(TAXPRIC_4,0,,TAXPRIC_4)}', left=828, top=1037, right=1085, bottom=1098, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>        "
ls_for += " 	<C>id='{decode(TAXSUM_1,0,,TAXSUM_1)}', left=1093, top=2199, right=1402, bottom=2260, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>         "
ls_for += " 	<C>id='{decode(TAXSUM_2,0,,TAXSUM_2)}', left=1093, top=2270, right=1402, bottom=2328, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>         "
ls_for += " 	<C>id='{decode(TAXSUM_3,0,,TAXSUM_3)}', left=1093, top=2336, right=1402, bottom=2397, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>         "
ls_for += " 	<C>id='{decode(TAXSUM_4,0,,TAXSUM_4)}', left=1093, top=2405, right=1402, bottom=2466, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>         "
ls_for += " 	<C>id='{decode(TAXVATAMT_1,0,,TAXVATAMT_1)}', left=1413, top=2199, right=1691, bottom=2260, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>   "
ls_for += " 	<C>id='{decode(TAXVATAMT_2,0,,TAXVATAMT_2)}', left=1413, top=2270, right=1691, bottom=2328, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>   "
ls_for += " 	<C>id='{decode(TAXVATAMT_3,0,,TAXVATAMT_3)}', left=1413, top=2336, right=1691, bottom=2397, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>   "
ls_for += " 	<C>id='{decode(TAXVATAMT_4,0,,TAXVATAMT_4)}', left=1413, top=2405, right=1691, bottom=2466, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>   "
ls_for += " 	<C>id='BIGO_1', left=1701, top=831, right=1828, bottom=892, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                    "
ls_for += " 	<C>id='BIGO_2', left=1701, top=900, right=1828, bottom=958, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                    "
ls_for += " 	<C>id='BIGO_3', left=1701, top=968, right=1828, bottom=1029, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                   "
ls_for += " 	<C>id='BIGO_4', left=1701, top=1037, right=1828, bottom=1098, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                  "
ls_for += " 	<T>id='-' ,left=616 ,top=233 ,right=659 ,bottom=315 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                         "
ls_for += " 	<T>id='-' ,left=455 ,top=233 ,right=500 ,bottom=315 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                         "
ls_for += " 	<L> left=32 ,top=2588 ,right=1834 ,bottom=2588 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<T>id='인쇄용지(특급)34g/m2 182mmx128mm' ,left=1098 ,top=2598 ,right=1839 ,bottom=2638 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>        "
ls_for += " 	<T>id='22226-28131일 ‘96.3.27승인' ,left=32 ,top=2598 ,right=585 ,bottom=2638 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                 "
ls_for += " 	<C>id='BIGO_4', left=1701, top=2405, right=1828, bottom=2466, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                  "
ls_for += " 	<C>id='BIGO_3', left=1701, top=2336, right=1828, bottom=2397, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                  "
ls_for += " 	<C>id='BIGO_2', left=1701, top=2270, right=1828, bottom=2328, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                  "
ls_for += " 	<C>id='BIGO_1', left=1701, top=2199, right=1828, bottom=2260, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                  "
ls_for += " 	<C>id='TAXDT_4', left=103, top=2405, right=164, bottom=2466, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                   "
ls_for += " 	<C>id='TAXMM_4', left=37, top=2405, right=95, bottom=2466, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                     "
ls_for += " 	<C>id='TAXMM_3', left=37, top=2336, right=95, bottom=2397, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                     "
ls_for += " 	<C>id='TAXDT_3', left=103, top=2336, right=164, bottom=2397, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                   "
ls_for += " 	<C>id='TAXDT_2', left=103, top=2270, right=164, bottom=2328, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                   "
ls_for += " 	<C>id='TAXMM_2', left=37, top=2270, right=95, bottom=2328, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                     "
ls_for += " 	<C>id='TAXDT_1', left=103, top=2199, right=164, bottom=2260, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                   "
ls_for += " 	<C>id='TAXMM_1', left=37, top=2199, right=95, bottom=2260, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                     "
ls_for += " 	<L> left=32 ,top=2519 ,right=1405 ,bottom=2519 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<T>id='외상미수금' ,left=1151 ,top=2474 ,right=1402 ,bottom=2516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                            "
ls_for += " 	<T>id='어  음' ,left=884 ,top=2474 ,right=1140 ,bottom=2516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                 "
ls_for += " 	<T>id='수  표' ,left=616 ,top=2474 ,right=876 ,bottom=2516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                  "
ls_for += " 	<T>id='현  금' ,left=352 ,top=2474 ,right=606 ,bottom=2516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                  "
ls_for += " 	<T>id='합계금액' ,left=40 ,top=2474 ,right=344 ,bottom=2516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                 "
ls_for += " 	<L> left=32 ,top=2469 ,right=1834 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<C>id='TAXPDTNAM_4', left=172, top=2405, right=606, bottom=2466, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                               "
ls_for += " 	<C>id='TAXPDTNAM_3', left=172, top=2336, right=606, bottom=2397, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                               "
ls_for += " 	<C>id='TAXPDTNAM_2', left=172, top=2270, right=606, bottom=2328, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                               "
ls_for += " 	<C>id='TAXPDTNAM_1', left=172, top=2199, right=606, bottom=2260, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                               "
ls_for += " 	<T>id='공급받는자' ,left=987 ,top=1471 ,right=1296 ,bottom=1511 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                             "
ls_for += " 	<T>id='보  관  용' ,left=987 ,top=1529 ,right=1296 ,bottom=1572 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                             "
ls_for += " 	<L> left=32 ,top=2400 ,right=1834 ,bottom=2400 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=770 ,top=2024 ,right=770 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=1513 ,top=1879 ,right=1513 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1513 ,top=1598 ,right=1513 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=85 ,top=1593 ,right=85 ,bottom=1971 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                        "
ls_for += " 	<L> left=929 ,top=1593 ,right=929 ,bottom=1971 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=929 ,top=1598 ,right=929 ,bottom=1783 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=291 ,top=1593 ,right=291 ,bottom=1783 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=1778 ,top=1598 ,right=1778 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1725 ,top=1598 ,right=1725 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1672 ,top=1598 ,right=1672 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1566 ,top=1598 ,right=1566 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1458 ,top=1598 ,right=1458 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1405 ,top=1598 ,right=1405 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1352 ,top=1598 ,right=1352 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1299 ,top=1598 ,right=1299 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1246 ,top=1598 ,right=1246 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1458 ,top=2024 ,right=1458 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1352 ,top=2024 ,right=1352 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1299 ,top=2024 ,right=1299 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1246 ,top=2024 ,right=1246 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1193 ,top=2024 ,right=1193 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1140 ,top=2024 ,right=1140 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1035 ,top=2024 ,right=1035 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=929 ,top=2024 ,right=929 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=876 ,top=2024 ,right=876 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=664 ,top=2024 ,right=664 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=609 ,top=2024 ,right=609 ,bottom=2588 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=32 ,top=2331 ,right=1834 ,bottom=2331 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=32 ,top=2262 ,right=1834 ,bottom=2262 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=32 ,top=2193 ,right=1834 ,bottom=2193 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<T>id='일' ,left=103 ,top=2151 ,right=164 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='품        목' ,left=172 ,top=2151 ,right=606 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                            "
ls_for += " 	<T>id='규격' ,left=616 ,top=2151 ,right=712 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<T>id='수량' ,left=722 ,top=2151 ,right=820 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<T>id='단    가' ,left=828 ,top=2151 ,right=1085 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                               "
ls_for += " 	<T>id='공 급 가 액' ,left=1093 ,top=2151 ,right=1402 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                           "
ls_for += " 	<T>id='세       액' ,left=1413 ,top=2151 ,right=1691 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                           "
ls_for += " 	<T>id='비고' ,left=1701 ,top=2151 ,right=1828 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                  "
ls_for += " 	<T>id='월' ,left=37 ,top=2151 ,right=95 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<L> left=982 ,top=1593 ,right=982 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=556 ,top=2024 ,right=556 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=503 ,top=2024 ,right=503 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=450 ,top=2024 ,right=450 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=291 ,top=1593 ,right=291 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=228 ,top=2024 ,right=228 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=32 ,top=2077 ,right=1513 ,bottom=2077 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<T>id='월' ,left=172 ,top=2032 ,right=225 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='년' ,left=37 ,top=2032 ,right=164 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                       "
ls_for += " 	<L> left=32 ,top=2140 ,right=1834 ,bottom=2140 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<T>id='십' ,left=987 ,top=2032 ,right=1032 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                     "
ls_for += " 	<T>id='십' ,left=1413 ,top=2032 ,right=1455 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<T>id='백' ,left=1360 ,top=2032 ,right=1402 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<T>id='천' ,left=1307 ,top=2032 ,right=1349 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<T>id='만' ,left=1254 ,top=2032 ,right=1296 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<T>id='십' ,left=1201 ,top=2032 ,right=1244 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<T>id='백' ,left=1148 ,top=2032 ,right=1191 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<T>id='천' ,left=1093 ,top=2032 ,right=1138 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<T>id='억' ,left=1040 ,top=2032 ,right=1085 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<T>id='십' ,left=455 ,top=2032 ,right=500 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='일' ,left=934 ,top=2032 ,right=979 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='천' ,left=564 ,top=2032 ,right=606 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='백' ,left=616 ,top=2032 ,right=659 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='십' ,left=669 ,top=2032 ,right=712 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='만' ,left=722 ,top=2032 ,right=767 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='천' ,left=775 ,top=2032 ,right=820 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='백' ,left=828 ,top=2032 ,right=873 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='십' ,left=881 ,top=2032 ,right=926 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='억' ,left=508 ,top=2032 ,right=553 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='백' ,left=402 ,top=2032 ,right=447 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='공란수' ,left=296 ,top=2032 ,right=394 ,bottom=2074 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                    "
ls_for += " 	<T>id='일' ,left=233 ,top=2032 ,right=288 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='일' ,left=1466 ,top=2032 ,right=1508 ,bottom=2074 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<L> left=32 ,top=2024 ,right=1834 ,bottom=2024 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<T>id='작      성' ,left=37 ,top=1982 ,right=288 ,bottom=2021 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                               "
ls_for += " 	<T>id='공     급     가     액' ,left=296 ,top=1982 ,right=979 ,bottom=2021 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                 "
ls_for += " 	<T>id='세              액' ,left=987 ,top=1982 ,right=1508 ,bottom=2021 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                     "
ls_for += " 	<T>id='비        고' ,left=1519 ,top=1982 ,right=1828 ,bottom=2021 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                          "
ls_for += " 	<L> left=32 ,top=1971 ,right=1834 ,bottom=1971 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<T>id='종' ,left=1519 ,top=1884 ,right=1564 ,bottom=1926 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<T>id='목' ,left=1519 ,top=1929 ,right=1564 ,bottom=1969 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<T>id='종' ,left=616 ,top=1884 ,right=659 ,bottom=1926 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='목' ,left=616 ,top=1929 ,right=659 ,bottom=1969 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='업     태' ,left=987 ,top=1884 ,right=1191 ,bottom=1966 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                              "
ls_for += " 	<C>id='BSNS_CND', left=1201, top=1884, right=1508, bottom=1966, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                "
ls_for += " 	<C>id='BSNS_KND', left=1572, top=1884, right=1828, bottom=1966, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                "
ls_for += " 	<T>id='업     태' ,left=90 ,top=1884 ,right=288 ,bottom=1966 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                "
ls_for += " 	<T>id='서비스' ,left=296 ,top=1884 ,right=606 ,bottom=1966 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                    "
ls_for += " 	<L> left=982 ,top=1879 ,right=1834 ,bottom=1879 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                     "
ls_for += " 	<L> left=85 ,top=1879 ,right=929 ,bottom=1879 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       "
ls_for += " 	<T>id='강원도 고성군 현내면 초도리 258-2' ,left=296 ,top=1791 ,right=926 ,bottom=1876 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>         "
ls_for += " 	<C>id='ADDNM', left=1201, top=1799, right=1831, bottom=1876, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                   "
ls_for += " 	<T>id='주     소' ,left=90 ,top=1834 ,right=288 ,bottom=1876 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                "
ls_for += " 	<T>id='사 업 장' ,left=90 ,top=1791 ,right=288 ,bottom=1831 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                 "
ls_for += " 	<L> left=291 ,top=1783 ,right=929 ,bottom=1783 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=982 ,top=1783 ,right=1834 ,bottom=1783 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                     "
ls_for += " 	<C>id='VEND_NM', left=1201, top=1707, right=1508, bottom=1781, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>                 "
ls_for += " 	<C>id='VD_DIRECT', left=1572, top=1696, right=1778, bottom=1781, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                               "
ls_for += " 	<T>id='인' ,left=1783 ,top=1696 ,right=1828 ,bottom=1781 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<T>id='"+g_ceoname+"' ,left=669 ,top=1693 ,right=876 ,bottom=1778 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                    "
ls_for += " 	<T>id='인' ,left=881 ,top=1693 ,right=926 ,bottom=1781 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='명' ,left=616 ,top=1738 ,right=659 ,bottom=1778 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='성' ,left=616 ,top=1693 ,right=659 ,bottom=1733 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='현대아산주식회사' ,left=299 ,top=1693 ,right=606 ,bottom=1778 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                          "
ls_for += " 	<T>id='상    호' ,left=90 ,top=1693 ,right=288 ,bottom=1733 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                 "
ls_for += " 	<T>id='(법인명)' ,left=90 ,top=1738 ,right=288 ,bottom=1781 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                 "
ls_for += " 	<T>id='상    호' ,left=987 ,top=1693 ,right=1191 ,bottom=1733 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                               "
ls_for += " 	<T>id='(법인명)' ,left=987 ,top=1738 ,right=1191 ,bottom=1781 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                               "
ls_for += " 	<T>id='등록번호' ,left=987 ,top=1601 ,right=1191 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                               "
ls_for += " 	<L> left=85 ,top=1688 ,right=929 ,bottom=1688 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       "
ls_for += " 	<T>id='등록번호' ,left=90 ,top=1601 ,right=288 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                 "
ls_for += " 	<T>id='(                   )' ,left=987 ,top=1500 ,right=1296 ,bottom=1540 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                  "
ls_for += " 	<L> left=32 ,top=1593 ,right=1834 ,bottom=1593 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<T>id='일련번호' ,left=1307 ,top=1524 ,right=1508 ,bottom=1590 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                              "
ls_for += " 	<T>id='책 번 호' ,left=1307 ,top=1450 ,right=1508 ,bottom=1516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                              "
ls_for += " 	<L> left=1299 ,top=1519 ,right=1834 ,bottom=1519 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1193 ,top=1593 ,right=1834 ,bottom=1593 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<T>id='공' ,left=934 ,top=1640 ,right=979 ,bottom=1696 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='급' ,left=934 ,top=1701 ,right=979 ,bottom=1757 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='받' ,left=934 ,top=1759 ,right=979 ,bottom=1815 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='는' ,left=934 ,top=1818 ,right=979 ,bottom=1876 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='자' ,left=934 ,top=1879 ,right=979 ,bottom=1934 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                      "
ls_for += " 	<T>id='급' ,left=37 ,top=1749 ,right=82 ,bottom=1828 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='성' ,left=1519 ,top=1696 ,right=1564 ,bottom=1738 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<T>id='명' ,left=1519 ,top=1741 ,right=1564 ,bottom=1781 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<L> left=291 ,top=1593 ,right=929 ,bottom=1593 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<T>id='공' ,left=37 ,top=1640 ,right=82 ,bottom=1720 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<T>id='자' ,left=37 ,top=1852 ,right=82 ,bottom=1931 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                        "
ls_for += " 	<L> left=85 ,top=1783 ,right=929 ,bottom=1783 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                       "
ls_for += " 	<L> left=609 ,top=228 ,right=609 ,bottom=325 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=609 ,top=508 ,right=609 ,bottom=603 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=609 ,top=1879 ,right=609 ,bottom=1971 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=664 ,top=1879 ,right=664 ,bottom=1971 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=1725 ,top=1519 ,right=1725 ,bottom=1593 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1778 ,top=1519 ,right=1778 ,bottom=1593 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1566 ,top=1879 ,right=1566 ,bottom=1971 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1566 ,top=1519 ,right=1566 ,bottom=1593 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<T>id='사 업 장' ,left=987 ,top=1791 ,right=1191 ,bottom=1831 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                               "
ls_for += " 	<T>id='주     소' ,left=987 ,top=1834 ,right=1191 ,bottom=1876 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                              "
ls_for += " 	<T>id='세 금 계 산 서' ,left=37 ,top=1434 ,right=984 ,bottom=1569 ,face='굴림' ,size=23 ,bold=true ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                            "
ls_for += " 	<L> left=1193 ,top=1593 ,right=1193 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1193 ,top=225 ,right=1193 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1193 ,top=1598 ,right=1193 ,bottom=1971 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=98 ,top=773 ,right=98 ,bottom=1101 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                         "
ls_for += " 	<L> left=167 ,top=656 ,right=167 ,bottom=1101 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                       "
ls_for += " 	<L> left=717 ,top=656 ,right=717 ,bottom=1101 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                       "
ls_for += " 	<L> left=823 ,top=656 ,right=823 ,bottom=1101 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                       "
ls_for += " 	<L> left=878 ,top=1101 ,right=878 ,bottom=1220 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=347 ,top=1101 ,right=347 ,bottom=1220 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1087 ,top=656 ,right=1087 ,bottom=1101 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                     "
ls_for += " 	<L> left=1143 ,top=1101 ,right=1143 ,bottom=1220 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                    "
ls_for += " 	<L> left=1405 ,top=656 ,right=1405 ,bottom=1220 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                     "
ls_for += " 	<L> left=1693 ,top=773 ,right=1693 ,bottom=1101 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                     "
ls_for += " 	<L> left=1405 ,top=228 ,right=1405 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=717 ,top=228 ,right=717 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=823 ,top=228 ,right=823 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=344 ,top=228 ,right=344 ,bottom=320 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=1193 ,top=1688 ,right=1831 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=98 ,top=2140 ,right=98 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                        "
ls_for += " 	<L> left=167 ,top=2024 ,right=167 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=347 ,top=2469 ,right=347 ,bottom=2588 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=717 ,top=2024 ,right=717 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=823 ,top=2024 ,right=823 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=878 ,top=2469 ,right=878 ,bottom=2588 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=1087 ,top=2024 ,right=1087 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1143 ,top=2469 ,right=1143 ,bottom=2588 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1405 ,top=2024 ,right=1405 ,bottom=2588 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1693 ,top=2140 ,right=1693 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=397 ,top=2024 ,right=397 ,bottom=2140 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<T>id='-' ,left=616 ,top=1601 ,right=659 ,bottom=1683 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                       "
ls_for += " 	<T>id='-' ,left=455 ,top=1601 ,right=500 ,bottom=1683 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                       "
ls_for += " 	<L> left=556 ,top=1598 ,right=556 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=503 ,top=1598 ,right=503 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=450 ,top=1598 ,right=450 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=397 ,top=1598 ,right=397 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=344 ,top=1598 ,right=344 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=876 ,top=1598 ,right=876 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=823 ,top=1598 ,right=823 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=770 ,top=1598 ,right=770 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=717 ,top=1598 ,right=717 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=664 ,top=1598 ,right=664 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=609 ,top=1598 ,right=609 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=609 ,top=1598 ,right=609 ,bottom=1783 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=609 ,top=228 ,right=609 ,bottom=415 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=664 ,top=1598 ,right=664 ,bottom=1783 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<L> left=664 ,top=228 ,right=664 ,bottom=325 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                        "
ls_for += " 	<L> left=982 ,top=1688 ,right=1834 ,bottom=1688 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                     "
ls_for += " 	<L> left=1513 ,top=1683 ,right=1513 ,bottom=1783 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1566 ,top=1683 ,right=1566 ,bottom=1783 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1566 ,top=315 ,right=1566 ,bottom=415 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1513 ,top=312 ,right=1513 ,bottom=415 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=24 ,top=1386 ,right=1834 ,bottom=1386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>                                                                                                                        "
ls_for += " 	<L> left=32 ,top=74 ,right=1834 ,bottom=74 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                          "
ls_for += " 	<T>id='[별지 제11호 서식]' ,left=29 ,top=37 ,right=434 ,bottom=71 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                              "
ls_for += " 	<L> left=32 ,top=1445 ,right=1834 ,bottom=1445 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                      "
ls_for += " 	<T>id='[별지 제11호 서식]' ,left=32 ,top=1405 ,right=439 ,bottom=1442 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                          "
ls_for += " 	<L> left=32 ,top=1445 ,right=32 ,bottom=2588 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                        "
ls_for += " 	<L> left=29 ,top=74 ,right=29 ,bottom=1220 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                          "
ls_for += " 	<L> left=1834 ,top=74 ,right=1834 ,bottom=1220 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1299 ,top=1445 ,right=1299 ,bottom=1598 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1513 ,top=1445 ,right=1513 ,bottom=1598 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1672 ,top=1445 ,right=1672 ,bottom=1598 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1513 ,top=74 ,right=1513 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                       "
ls_for += " 	<L> left=1299 ,top=74 ,right=1299 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                       "
ls_for += " 	<T>id='2' ,left=296 ,top=233 ,right=341 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                         "
ls_for += " 	<T>id='0' ,left=349 ,top=233 ,right=394 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                         "
ls_for += " 	<T>id='2' ,left=349 ,top=233 ,right=394 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                         "
ls_for += " 	<T>id='1' ,left=402 ,top=233 ,right=447 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                         "
ls_for += " 	<T>id='8' ,left=508 ,top=233 ,right=553 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                         "
ls_for += " 	<T>id='1' ,left=564 ,top=233 ,right=606 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                         "
ls_for += " 	<T>id='1' ,left=669 ,top=233 ,right=712 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                         "
ls_for += " 	<T>id='3' ,left=722 ,top=233 ,right=767 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                         "
ls_for += " 	<T>id='8' ,left=775 ,top=233 ,right=820 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                         "
ls_for += " 	<T>id='3' ,left=828 ,top=233 ,right=873 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                         "
ls_for += " 	<T>id='4' ,left=881 ,top=233 ,right=926 ,bottom=315 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                         "
ls_for += " 	<T>id='1' ,left=402 ,top=1603 ,right=447 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                       "
ls_for += " 	<T>id='8' ,left=508 ,top=1603 ,right=553 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                       "
ls_for += " 	<T>id='1' ,left=564 ,top=1603 ,right=606 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                       "
ls_for += " 	<T>id='1' ,left=669 ,top=1603 ,right=712 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                       "
ls_for += " 	<T>id='3' ,left=722 ,top=1603 ,right=767 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                       "
ls_for += " 	<T>id='8' ,left=775 ,top=1603 ,right=820 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                       "
ls_for += " 	<T>id='3' ,left=828 ,top=1603 ,right=873 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                       "
ls_for += " 	<T>id='4' ,left=881 ,top=1603 ,right=926 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                       "
ls_for += " 	<T>id='2' ,left=296 ,top=1603 ,right=341 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                       "
ls_for += " 	<T>id='2' ,left=349 ,top=1603 ,right=394 ,bottom=1683 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                                       "
ls_for += " 	<C>id='TAXDAT', left=37, top=717, right=164, bottom=767 ,mask='XXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                 "
ls_for += " 	<C>id='TAXMM_1', left=172, top=717, right=225, bottom=767, align='left' ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                   "
ls_for += " 	<C>id='TAXDT_1', left=233, top=717, right=288, bottom=767, align='left' ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                   "
ls_for += " 	<C>id='', left=1519, top=661, right=1828, bottom=767, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>                                          "
ls_for += " 	<C>id='TAXDAT', left=37, top=2085, right=164, bottom=2135 ,mask='XXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                               "
ls_for += " 	<C>id='TAXMM_1', left=172, top=2085, right=225, bottom=2135, align='left' ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                 "
ls_for += " 	<C>id='TAXDT_1', left=233, top=2085, right=288, bottom=2135, align='left' ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                 "
ls_for += " 	<C>id='', left=1519, top=2032, right=1828, bottom=2135, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>                                        "
ls_for += " 	<C>id='{MTAXSUM+MTAXVATAMT}', left=37, top=1156, right=344, bottom=1212, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                      "
ls_for += " 	<C>id='{MTAXSUM+MTAXVATAMT}', left=37, top=2524, right=344, bottom=2580, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                      "
ls_for += " 	<C>id='{decode(BlkCnt,0,,BlkCnt)}', left=296, top=2085, right=394, bottom=2135 ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                   "
ls_for += " 	<C>id='{decode(BlkCnt,0,,BlkCnt)}', left=296, top=717, right=394, bottom=767 ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                     "
ls_for += " 	<C>id='TSUM_1', left=934, top=717, right=979, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                             "
ls_for += " 	<C>id='TSUM_2', left=881, top=717, right=926, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                             "
ls_for += " 	<C>id='TSUM_3', left=828, top=717, right=873, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                             "
ls_for += " 	<C>id='TSUM_4', left=775, top=717, right=820, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                             "
ls_for += " 	<C>id='TSUM_5', left=722, top=717, right=767, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                             "
ls_for += " 	<C>id='TSUM_6', left=669, top=717, right=712, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                             "
ls_for += " 	<C>id='TSUM_7', left=616, top=717, right=659, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                             "
ls_for += " 	<C>id='TSUM_8', left=564, top=717, right=606, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                             "
ls_for += " 	<C>id='TSUM_9', left=508, top=717, right=553, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                             "
ls_for += " 	<C>id='TSUM_10', left=455, top=717, right=500, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                            "
ls_for += " 	<C>id='TSUM_11', left=402, top=717, right=447, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                            "
ls_for += " 	<C>id='TVAT_1', left=1466, top=717, right=1508, bottom=767 ,mask='X', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                 "
ls_for += " 	<C>id='TVAT_2', left=1413, top=717, right=1455, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                           "
ls_for += " 	<C>id='TVAT_3', left=1360, top=717, right=1402, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                           "
ls_for += " 	<C>id='TVAT_4', left=1307, top=717, right=1349, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                           "
ls_for += " 	<C>id='TVAT_5', left=1254, top=717, right=1296, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                           "
ls_for += " 	<C>id='TVAT_6', left=1201, top=717, right=1244, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                           "
ls_for += " 	<C>id='TVAT_7', left=1148, top=717, right=1191, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                           "
ls_for += " 	<C>id='TVAT_8', left=1093, top=717, right=1138, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                           "
ls_for += " 	<C>id='TVAT_9', left=1040, top=717, right=1085, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                           "
ls_for += " 	<C>id='TVAT_10', left=987, top=717, right=1032, bottom=767, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                           "
ls_for += " 	<C>id='TSUM_1', left=934, top=2085, right=979, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                           "
ls_for += " 	<C>id='TSUM_2', left=881, top=2085, right=926, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                           "
ls_for += " 	<C>id='TSUM_3', left=828, top=2085, right=873, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                           "
ls_for += " 	<C>id='TSUM_4', left=775, top=2085, right=820, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                           "
ls_for += " 	<C>id='TSUM_5', left=722, top=2085, right=767, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                           "
ls_for += " 	<C>id='TSUM_6', left=669, top=2085, right=712, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                           "
ls_for += " 	<C>id='TSUM_7', left=616, top=2085, right=659, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                           "
ls_for += " 	<C>id='TSUM_8', left=564, top=2085, right=606, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                           "
ls_for += " 	<C>id='TSUM_9', left=508, top=2085, right=553, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                           "
ls_for += " 	<C>id='TSUM_10', left=455, top=2085, right=500, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                          "
ls_for += " 	<C>id='TSUM_11', left=402, top=2085, right=447, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                          "
ls_for += " 	<C>id='TVAT_1', left=1466, top=2085, right=1508, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                         "
ls_for += " 	<C>id='TVAT_2', left=1413, top=2085, right=1455, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                         "
ls_for += " 	<C>id='TVAT_3', left=1360, top=2085, right=1402, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                         "
ls_for += " 	<C>id='TVAT_4', left=1307, top=2085, right=1349, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                         "
ls_for += " 	<C>id='TVAT_5', left=1254, top=2085, right=1296, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                         "
ls_for += " 	<C>id='TVAT_6', left=1201, top=2085, right=1244, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                         "
ls_for += " 	<C>id='TVAT_7', left=1148, top=2085, right=1191, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                         "
ls_for += " 	<C>id='TVAT_8', left=1093, top=2085, right=1138, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                         "
ls_for += " 	<C>id='TVAT_9', left=1040, top=2085, right=1085, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                         "
ls_for += " 	<C>id='TVAT_10', left=987, top=2085, right=1032, bottom=2135, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                                         "
ls_for += " 	<C>id='SEQ_6', left=1783, top=153, right=1828, bottom=220, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   "
ls_for += " 	<C>id='SEQ_5', left=1730, top=153, right=1775, bottom=220, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   "
ls_for += " 	<C>id='SEQ_4', left=1677, top=153, right=1722, bottom=220, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   "
ls_for += " 	<C>id='SEQ_3', left=1625, top=153, right=1670, bottom=220, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   "
ls_for += " 	<C>id='SEQ_2', left=1572, top=153, right=1617, bottom=220, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                   "
ls_for += " 	<L> left=1672 ,top=228 ,right=1672 ,bottom=320 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>                                                                                                                      "
ls_for += " 	<L> left=1672 ,top=74 ,right=1672 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>                                                                                                                       "
ls_for += " 	<T>id='권' ,left=1627 ,top=82 ,right=1670 ,bottom=148 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                       "
ls_for += " 	<T>id='호' ,left=1786 ,top=82 ,right=1828 ,bottom=148 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                       "
ls_for += " 	<C>id='CNT', left=1677, top=82, right=1783, bottom=148 ,mask='XXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                         "
ls_for += " 	<L> left=1606 ,top=1521 ,right=1606 ,bottom=1595 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<L> left=1606 ,top=1598 ,right=1606 ,bottom=1688 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<C>id='TAXDAT', left=1519, top=82, right=1622, bottom=148 ,mask='XXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>                               "
ls_for += " 	<C>id='TAXDAT', left=1519, top=1450, right=1622, bottom=1516 ,mask='XXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF, Dec=0</C>                            "
ls_for += " 	<T>id='권' ,left=1627 ,top=1450 ,right=1670 ,bottom=1516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<C>id='CNT', left=1677, top=1450, right=1783, bottom=1516 ,mask='XXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>                                      "
ls_for += " 	<T>id='호' ,left=1786 ,top=1450 ,right=1828 ,bottom=1516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<L> left=1834 ,top=1445 ,right=1834 ,bottom=2588 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>                                                                                                                    "
ls_for += " 	<T>id='함' ,left=1736 ,top=2474 ,right=1818 ,bottom=2580 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<T>id='"+gclx_taxtype2.text+"' ,left=1590 ,top=2474 ,right=1730 ,bottom=2580 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                "
ls_for += " 	<T>id='위 금액을' ,left=1416 ,top=2474 ,right=1582 ,bottom=2580 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>                                             "
ls_for += " 	<T>id='위 금액을' ,left=1413 ,top=1106 ,right=1580 ,bottom=1212 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                             "
ls_for += " 	<T>id='"+gclx_taxtype2.text+"' ,left=1585 ,top=1106 ,right=1728 ,bottom=1212 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                "
ls_for += " 	<T>id='함' ,left=1736 ,top=1106 ,right=1818 ,bottom=1212 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>                                                    "
ls_for += " 	<T>id='기타사업남북경제' ,left=669 ,top=516 ,right=926 ,bottom=556 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                             "
ls_for += " 	<T>id='협력사업' ,left=669 ,top=558 ,right=926 ,bottom=598 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                     "
ls_for += " 	<T>id='기타사업남북경제' ,left=669 ,top=1884 ,right=926 ,bottom=1924 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                           "
ls_for += " 	<T>id='협력사업' ,left=669 ,top=1926 ,right=926 ,bottom=1966 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                   "
ls_for += " </B>                                                                                                                                                                                                                     "
	
	gcrp_print.format = ls_for + gcrp_print.format;

}
/******************************************************************************
	Description : 출력 - 계   산   서[매입]
******************************************************************************/
function ln_RptFormat2() {

	var ls_for = "";

	ls_for += "	<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2703 ,face='Arial' ,size=10 ,penwidth=1																			";
ls_for += "	<T>id='보     관     용' ,left=988 ,top=172 ,right=1297 ,bottom=216 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>								";
ls_for += "	<T>id='자' ,left=38 ,top=484 ,right=81 ,bottom=562 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='공' ,left=38 ,top=272 ,right=81 ,bottom=350 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<L> left=291 ,top=225 ,right=928 ,bottom=225 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=1778 ,top=150 ,right=1778 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1725 ,top=150 ,right=1725 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1619 ,top=150 ,right=1619 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<T>id='명' ,left=1519 ,top=372 ,right=1563 ,bottom=412 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='성' ,left=1519 ,top=328 ,right=1563 ,bottom=369 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<C>id='CNT', left=1678, top=81, right=1828, bottom=147 ,mask='XXXX 호', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<T>id='주     소' ,left=988 ,top=469 ,right=1191 ,bottom=509 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='급' ,left=38 ,top=381 ,right=81 ,bottom=459 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='자' ,left=934 ,top=509 ,right=978 ,bottom=566 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='는' ,left=934 ,top=450 ,right=978 ,bottom=506 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='받' ,left=934 ,top=391 ,right=978 ,bottom=447 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='급' ,left=934 ,top=331 ,right=978 ,bottom=387 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='공' ,left=934 ,top=272 ,right=978 ,bottom=328 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<L> left=1194 ,top=225 ,right=1834 ,bottom=225 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1300 ,top=150 ,right=1834 ,bottom=150 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<T>id='책 번 호' ,left=1306 ,top=81 ,right=1509 ,bottom=147 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='일련번호' ,left=1306 ,top=156 ,right=1509 ,bottom=222 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<C>id='TAXDAT', left=1519, top=81, right=1669, bottom=147 ,mask='XXXX 권', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF, Dec=0</C>						";
ls_for += "	<L> left=28 ,top=225 ,right=1834 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<T>id='(                   )' ,left=988 ,top=131 ,right=1297 ,bottom=172 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>							";
ls_for += "	<T>id='계    산    서' ,left=38 ,top=66 ,right=984 ,bottom=200 ,face='굴림' ,size=23 ,bold=true ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>								";
ls_for += "	<T>id='사 업 장' ,left=988 ,top=425 ,right=1191 ,bottom=466 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='등록번호' ,left=91 ,top=231 ,right=288 ,bottom=316 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<L> left=84 ,top=319 ,right=928 ,bottom=319 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=981 ,top=319 ,right=1834 ,bottom=319 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<T>id='등록번호' ,left=988 ,top=231 ,right=1191 ,bottom=316 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='(법인명)' ,left=988 ,top=369 ,right=1191 ,bottom=412 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='상    호' ,left=988 ,top=325 ,right=1191 ,bottom=366 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='(법인명)' ,left=91 ,top=369 ,right=288 ,bottom=412 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='상    호' ,left=91 ,top=325 ,right=288 ,bottom=366 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='현대아산(주)' ,left=300 ,top=325 ,right=606 ,bottom=409 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>							";
ls_for += "	<T>id='성' ,left=616 ,top=325 ,right=659 ,bottom=366 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='명' ,left=616 ,top=369 ,right=659 ,bottom=409 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='인' ,left=881 ,top=325 ,right=925 ,bottom=412 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='"+g_ceoname+"' ,left=669 ,top=325 ,right=875 ,bottom=409 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>							";
ls_for += "	<T>id='인' ,left=1784 ,top=328 ,right=1828 ,bottom=412 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<C>id='VD_DIRECT', left=1572, top=328, right=1778, bottom=412, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='VEND_NM', left=1200, top=328, right=1509, bottom=412, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<L> left=981 ,top=416 ,right=1834 ,bottom=416 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=84 ,top=416 ,right=928 ,bottom=416 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=291 ,top=416 ,right=928 ,bottom=416 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																		";
ls_for += "	<T>id='사 업 장' ,left=91 ,top=422 ,right=288 ,bottom=462 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='주     소' ,left=91 ,top=466 ,right=288 ,bottom=506 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<C>id='ADDNM', left=1200, top=422, right=1831, bottom=506, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<T>id='서울시 종로구 계동 현대빌딩 140-2' ,left=297 ,top=422 ,right=925 ,bottom=506 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>				";
ls_for += "	<L> left=84 ,top=509 ,right=928 ,bottom=509 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=981 ,top=509 ,right=1834 ,bottom=509 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<T>id='관광' ,left=669 ,top=516 ,right=925 ,bottom=597 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>								";
ls_for += "	<T>id='서비스업' ,left=297 ,top=516 ,right=606 ,bottom=597 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>							";
ls_for += "	<T>id='업     태' ,left=91 ,top=516 ,right=288 ,bottom=597 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<C>id='BSNS_KND', left=1572, top=516, right=1828, bottom=597, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='BSNS_CND', left=1200, top=516, right=1509, bottom=597, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<T>id='업     태' ,left=988 ,top=516 ,right=1191 ,bottom=597 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='목' ,left=616 ,top=559 ,right=659 ,bottom=600 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='종' ,left=616 ,top=516 ,right=659 ,bottom=556 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='목' ,left=1519 ,top=559 ,right=1563 ,bottom=600 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='종' ,left=1519 ,top=516 ,right=1563 ,bottom=556 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<L> left=31 ,top=603 ,right=1834 ,bottom=603 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=1566 ,top=509 ,right=1566 ,bottom=603 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1566 ,top=150 ,right=1566 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<T>id='공     급     가     액' ,left=297 ,top=612 ,right=978 ,bottom=653 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>							";
ls_for += "	<T>id='작      성' ,left=38 ,top=612 ,right=288 ,bottom=653 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<L> left=28 ,top=656 ,right=1834 ,bottom=656 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<T>id='일' ,left=234 ,top=662 ,right=288 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='공란수' ,left=297 ,top=662 ,right=394 ,bottom=706 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>							";
ls_for += "	<T>id='백' ,left=403 ,top=662 ,right=447 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='억' ,left=509 ,top=662 ,right=553 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='십' ,left=881 ,top=662 ,right=925 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='백' ,left=828 ,top=662 ,right=872 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='천' ,left=775 ,top=662 ,right=819 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='만' ,left=722 ,top=662 ,right=766 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='십' ,left=669 ,top=662 ,right=713 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='백' ,left=616 ,top=662 ,right=659 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='천' ,left=563 ,top=662 ,right=606 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='일' ,left=934 ,top=662 ,right=978 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='십' ,left=456 ,top=662 ,right=500 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<L> left=31 ,top=772 ,right=1834 ,bottom=772 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																		";
ls_for += "	<T>id='년' ,left=38 ,top=662 ,right=163 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='월' ,left=172 ,top=662 ,right=225 ,bottom=706 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<L> left=31 ,top=709 ,right=981 ,bottom=709 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=228 ,top=656 ,right=228 ,bottom=772 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=291 ,top=225 ,right=291 ,bottom=772 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=397 ,top=656 ,right=397 ,bottom=772 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=450 ,top=656 ,right=450 ,bottom=772 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=503 ,top=656 ,right=503 ,bottom=772 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=556 ,top=656 ,right=556 ,bottom=772 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=663 ,top=509 ,right=663 ,bottom=603 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=981 ,top=225 ,right=981 ,bottom=772 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<T>id='월' ,left=38 ,top=781 ,right=94 ,bottom=822 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='단    가' ,left=828 ,top=781 ,right=1084 ,bottom=822 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='수량' ,left=722 ,top=781 ,right=819 ,bottom=822 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='규격' ,left=616 ,top=781 ,right=713 ,bottom=822 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='품        목' ,left=172 ,top=781 ,right=606 ,bottom=822 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>								";
ls_for += "	<T>id='일' ,left=103 ,top=781 ,right=163 ,bottom=822 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<L> left=28 ,top=825 ,right=1834 ,bottom=825 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=28 ,top=894 ,right=1834 ,bottom=894 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=28 ,top=962 ,right=1834 ,bottom=962 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=1194 ,top=319 ,right=1831 ,bottom=319 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=31 ,top=1219 ,right=1834 ,bottom=1219 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=397 ,top=228 ,right=397 ,bottom=319 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=450 ,top=228 ,right=450 ,bottom=319 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=503 ,top=228 ,right=503 ,bottom=319 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=556 ,top=228 ,right=556 ,bottom=319 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=609 ,top=656 ,right=609 ,bottom=1219 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=663 ,top=656 ,right=663 ,bottom=772 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=663 ,top=228 ,right=663 ,bottom=419 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=875 ,top=656 ,right=875 ,bottom=772 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=928 ,top=656 ,right=928 ,bottom=772 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=769 ,top=228 ,right=769 ,bottom=319 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=875 ,top=228 ,right=875 ,bottom=319 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=1566 ,top=228 ,right=1566 ,bottom=319 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1619 ,top=228 ,right=1619 ,bottom=319 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1725 ,top=228 ,right=1725 ,bottom=319 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1778 ,top=228 ,right=1778 ,bottom=319 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=291 ,top=225 ,right=291 ,bottom=416 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=928 ,top=228 ,right=928 ,bottom=416 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=928 ,top=225 ,right=928 ,bottom=603 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=1194 ,top=228 ,right=1194 ,bottom=603 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=84 ,top=225 ,right=84 ,bottom=603 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=1513 ,top=228 ,right=1513 ,bottom=319 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=769 ,top=656 ,right=769 ,bottom=772 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=28 ,top=1031 ,right=1834 ,bottom=1031 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<T>id='22226-28131일 ‘96.3.27승인' ,left=31 ,top=1228 ,right=584 ,bottom=1269 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>					";
ls_for += "	<T>id='인쇄용지(특급)34g/m2 182mmx128mm' ,left=1097 ,top=1228 ,right=1838 ,bottom=1269 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>				";
ls_for += "	<T>id='공 급 받 는 자' ,left=988 ,top=91 ,right=1297 ,bottom=131 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>								";
ls_for += "	<C>id='TAXPDTNAM_1', left=172, top=831, right=606, bottom=891, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='TAXPDTNAM_2', left=172, top=900, right=606, bottom=959, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='TAXPDTNAM_3', left=172, top=969, right=606, bottom=1028, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='TAXPDTNAM_4', left=172, top=1037, right=606, bottom=1097, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>						";
ls_for += "	<L> left=28 ,top=1100 ,right=1834 ,bottom=1100 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<T>id='합계금액' ,left=41 ,top=1106 ,right=344 ,bottom=1147 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='현  금' ,left=353 ,top=1106 ,right=606 ,bottom=1147 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='수  표' ,left=616 ,top=1106 ,right=875 ,bottom=1147 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='어  음' ,left=884 ,top=1106 ,right=1141 ,bottom=1147 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='외상미수금' ,left=1150 ,top=1106 ,right=1403 ,bottom=1147 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>								";
ls_for += "	<L> left=28 ,top=1150 ,right=1406 ,bottom=1150 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<C>id='TAXMM_1', left=38, top=831, right=94, bottom=891, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='TAXDT_1', left=103, top=831, right=163, bottom=891, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='TAXMM_2', left=38, top=900, right=94, bottom=959, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='TAXDT_2', left=103, top=900, right=163, bottom=959, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='TAXDT_3', left=103, top=969, right=163, bottom=1028, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='TAXMM_3', left=38, top=969, right=94, bottom=1028, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='TAXMM_4', left=38, top=1037, right=94, bottom=1097, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='TAXDT_4', left=103, top=1037, right=163, bottom=1097, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='VSEQ_10', left=1784, top=231, right=1828, bottom=316, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='VSEQ_9', left=1731, top=231, right=1775, bottom=316, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='VSEQ_8', left=1678, top=231, right=1722, bottom=316, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='VSEQ_7', left=1625, top=231, right=1669, bottom=316, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='VSEQ_6', left=1572, top=231, right=1616, bottom=316, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>									";
ls_for += "	<T>id='-' ,left=1519 ,top=231 ,right=1563 ,bottom=316 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<C>id='VSEQ_5', left=1466, top=231, right=1509, bottom=316, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='VSEQ_4', left=1413, top=231, right=1456, bottom=316, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>									";
ls_for += "	<T>id='-' ,left=1359 ,top=231 ,right=1403 ,bottom=316 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<C>id='VSEQ_3', left=1306, top=231, right=1350, bottom=316, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='VSEQ_2', left=1253, top=231, right=1297, bottom=316, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='VSEQ_1', left=1200, top=231, right=1244, bottom=316, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='SEQ_1', left=1519, top=156, right=1563, bottom=222, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='SEQ_2', left=1572, top=156, right=1616, bottom=222, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='SEQ_3', left=1625, top=156, right=1669, bottom=222, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='SEQ_4', left=1678, top=156, right=1722, bottom=222, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='SEQ_5', left=1731, top=156, right=1775, bottom=222, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='SEQ_6', left=1784, top=156, right=1828, bottom=222, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id={decode(TAXSTD_1,'0','',TAXSTD_1)}, left=616, top=831, right=713, bottom=891, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>				";
ls_for += "	<C>id={decode(TAXSTD_2,'0','',TAXSTD_2)}, left=616, top=900, right=713, bottom=959, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>				";
ls_for += "	<C>id={decode(TAXSTD_3,'0','',TAXSTD_3)}, left=616, top=969, right=713, bottom=1028, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>				";
ls_for += "	<C>id={decode(TAXSTD_4,'0','',TAXSTD_4)}, left=616, top=1037, right=713, bottom=1097, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>				";
ls_for += "	<C>id={decode(TAXQTY_1,'0','',TAXQTY_1)}, left=722, top=831, right=819, bottom=891, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>						";
ls_for += "	<C>id={decode(TAXQTY_2,'0','',TAXQTY_2)}, left=722, top=900, right=819, bottom=959, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>						";
ls_for += "	<C>id={decode(TAXQTY_3,'0','',TAXQTY_3)}, left=722, top=969, right=819, bottom=1028, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>					";
ls_for += "	<C>id={decode(TAXQTY_4,'0','',TAXQTY_4)}, left=722, top=1037, right=819, bottom=1097, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>					";
ls_for += "	<C>id={decode(TAXPRIC_1,'0','',TAXPRIC_1)}, left=828, top=831, right=1084, bottom=891, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>			";
ls_for += "	<C>id={decode(TAXPRIC_2,'0','',TAXPRIC_2)}, left=828, top=2269, right=1084, bottom=2328, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>			";
ls_for += "	<C>id={decode(TAXPRIC_3,'0','',TAXPRIC_3)}, left=828, top=2337, right=1084, bottom=2397, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>			";
ls_for += "	<C>id={decode(TAXPRIC_4,'0','',TAXPRIC_4)}, left=828, top=2406, right=1084, bottom=2466, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>			";
ls_for += "	<C>id='VSEQ_1', left=1200, top=1600, right=1244, bottom=1684, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='VSEQ_2', left=1253, top=1600, right=1297, bottom=1684, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='VSEQ_3', left=1306, top=1600, right=1350, bottom=1684, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>									";
ls_for += "	<T>id='-' ,left=1359 ,top=1600 ,right=1403 ,bottom=1684 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<C>id='VSEQ_4', left=1413, top=1600, right=1456, bottom=1684, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='VSEQ_5', left=1466, top=1600, right=1509, bottom=1684, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>									";
ls_for += "	<T>id='-' ,left=1519 ,top=1600 ,right=1563 ,bottom=1684 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<C>id='VSEQ_6', left=1572, top=1600, right=1616, bottom=1684, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='VSEQ_7', left=1625, top=1600, right=1669, bottom=1684, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='VSEQ_8', left=1678, top=1600, right=1722, bottom=1684, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='VSEQ_9', left=1731, top=1600, right=1775, bottom=1684, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='VSEQ_10', left=1784, top=1600, right=1828, bottom=1684, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>								";
ls_for += "	<C>id='SEQ_1', left=1519, top=1525, right=1563, bottom=1591, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='SEQ_2', left=1572, top=1525, right=1616, bottom=1591, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='SEQ_3', left=1625, top=1525, right=1669, bottom=1591, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='SEQ_4', left=1678, top=1525, right=1722, bottom=1591, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='SEQ_5', left=1731, top=1525, right=1775, bottom=1591, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id='SEQ_6', left=1784, top=1525, right=1828, bottom=1591, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>									";
ls_for += "	<C>id={decode(TAXSTD_1,'0','',TAXSTD_1)}, left=616, top=2200, right=713, bottom=2259, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>				";
ls_for += "	<C>id={decode(TAXSTD_2,'0','',TAXSTD_2)}, left=616, top=2269, right=713, bottom=2328, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>				";
ls_for += "	<C>id={decode(TAXSTD_3,'0','',TAXSTD_3)}, left=616, top=2337, right=713, bottom=2397, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>				";
ls_for += "	<C>id={decode(TAXSTD_4,'0','',TAXSTD_4)}, left=616, top=2406, right=713, bottom=2466, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>				";
ls_for += "	<C>id={decode(TAXQTY_1,'0','',TAXQTY_1)}, left=722, top=2200, right=819, bottom=2259, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>					";
ls_for += "	<C>id={decode(TAXQTY_2,'0','',TAXQTY_2)}, left=722, top=2269, right=819, bottom=2328, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>					";
ls_for += "	<C>id={decode(TAXQTY_3,'0','',TAXQTY_3)}, left=722, top=2337, right=819, bottom=2397, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>					";
ls_for += "	<C>id={decode(TAXQTY_4,'0','',TAXQTY_4)}, left=722, top=2406, right=819, bottom=2466, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>					";
ls_for += "	<C>id={decode(TAXPRIC_1,'0','',TAXPRIC_1)}, left=828, top=2200, right=1084, bottom=2259, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>			";
ls_for += "	<C>id={decode(TAXPRIC_2,'0','',TAXPRIC_2)}, left=828, top=900, right=1084, bottom=959, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>			";
ls_for += "	<C>id={decode(TAXPRIC_3,'0','',TAXPRIC_3)}, left=828, top=969, right=1084, bottom=1028, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>			";
ls_for += "	<C>id={decode(TAXPRIC_4,'0','',TAXPRIC_4)}, left=828, top=1037, right=1084, bottom=1097, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>			";
ls_for += "	<T>id='-' ,left=616 ,top=234 ,right=659 ,bottom=316 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='-' ,left=456 ,top=234 ,right=500 ,bottom=316 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<L> left=31 ,top=2587 ,right=1834 ,bottom=2587 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<T>id='인쇄용지(특급)34g/m2 182mmx128mm' ,left=1097 ,top=2597 ,right=1838 ,bottom=2637 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>				";
ls_for += "	<T>id='22226-28131일 ‘96.3.27승인' ,left=31 ,top=2597 ,right=584 ,bottom=2637 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>					";
ls_for += "	<C>id='TAXDT_4', left=103, top=2406, right=163, bottom=2466, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='TAXMM_4', left=38, top=2406, right=94, bottom=2466, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='TAXMM_3', left=38, top=2337, right=94, bottom=2397, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='TAXDT_3', left=103, top=2337, right=163, bottom=2397, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='TAXDT_2', left=103, top=2269, right=163, bottom=2328, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='TAXMM_2', left=38, top=2269, right=94, bottom=2328, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='TAXDT_1', left=103, top=2200, right=163, bottom=2259, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='TAXMM_1', left=38, top=2200, right=94, bottom=2259, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>							";
ls_for += "	<L> left=31 ,top=2519 ,right=1406 ,bottom=2519 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<T>id='외상미수금' ,left=1150 ,top=2475 ,right=1403 ,bottom=2516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>								";
ls_for += "	<T>id='어  음' ,left=884 ,top=2475 ,right=1141 ,bottom=2516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='수  표' ,left=616 ,top=2475 ,right=875 ,bottom=2516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='현  금' ,left=353 ,top=2475 ,right=606 ,bottom=2516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='합계금액' ,left=41 ,top=2475 ,right=344 ,bottom=2516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<L> left=31 ,top=2469 ,right=1834 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<C>id='TAXPDTNAM_4', left=172, top=2406, right=606, bottom=2466, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>						";
ls_for += "	<C>id='TAXPDTNAM_3', left=172, top=2337, right=606, bottom=2397, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>						";
ls_for += "	<C>id='TAXPDTNAM_2', left=172, top=2269, right=606, bottom=2328, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>						";
ls_for += "	<C>id='TAXPDTNAM_1', left=172, top=2200, right=606, bottom=2259, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>						";
ls_for += "	<T>id='공     급     자' ,left=988 ,top=1459 ,right=1297 ,bottom=1500 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>							";
ls_for += "	<L> left=31 ,top=2400 ,right=1834 ,bottom=2400 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=769 ,top=2025 ,right=769 ,bottom=2141 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1513 ,top=1597 ,right=1513 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=84 ,top=1594 ,right=84 ,bottom=1972 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																		";
ls_for += "	<L> left=928 ,top=1594 ,right=928 ,bottom=1972 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=928 ,top=1597 ,right=928 ,bottom=1784 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=291 ,top=1594 ,right=291 ,bottom=1784 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1778 ,top=1597 ,right=1778 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1725 ,top=1597 ,right=1725 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1672 ,top=1597 ,right=1672 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1619 ,top=1597 ,right=1619 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1566 ,top=1597 ,right=1566 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1459 ,top=1597 ,right=1459 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1406 ,top=1597 ,right=1406 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1353 ,top=1597 ,right=1353 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1300 ,top=1597 ,right=1300 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1247 ,top=1597 ,right=1247 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=928 ,top=2025 ,right=928 ,bottom=2141 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=875 ,top=2025 ,right=875 ,bottom=2141 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=663 ,top=2025 ,right=663 ,bottom=2141 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=609 ,top=2025 ,right=609 ,bottom=2587 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=31 ,top=2331 ,right=1834 ,bottom=2331 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=31 ,top=2262 ,right=1834 ,bottom=2262 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=31 ,top=2194 ,right=1834 ,bottom=2194 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<T>id='일' ,left=103 ,top=2150 ,right=163 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='품        목' ,left=172 ,top=2150 ,right=606 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>								";
ls_for += "	<T>id='규격' ,left=616 ,top=2150 ,right=713 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='수량' ,left=722 ,top=2150 ,right=819 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='단    가' ,left=828 ,top=2150 ,right=1084 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>								";
ls_for += "	<T>id='공 급 가 액' ,left=1094 ,top=2150 ,right=1563 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>								";
ls_for += "	<T>id='비고' ,left=1572 ,top=2150 ,right=1828 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='월' ,left=38 ,top=2150 ,right=94 ,bottom=2191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>										";
ls_for += "	<L> left=981 ,top=1594 ,right=981 ,bottom=2141 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=556 ,top=2025 ,right=556 ,bottom=2141 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=503 ,top=2025 ,right=503 ,bottom=2141 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=450 ,top=2025 ,right=450 ,bottom=2141 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=291 ,top=1594 ,right=291 ,bottom=2141 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=228 ,top=2025 ,right=228 ,bottom=2141 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<T>id='월' ,left=172 ,top=2031 ,right=225 ,bottom=2075 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='년' ,left=38 ,top=2031 ,right=163 ,bottom=2075 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<L> left=31 ,top=2141 ,right=1834 ,bottom=2141 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<T>id='십' ,left=456 ,top=2031 ,right=500 ,bottom=2075 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='일' ,left=934 ,top=2031 ,right=978 ,bottom=2075 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='천' ,left=563 ,top=2031 ,right=606 ,bottom=2075 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='백' ,left=616 ,top=2031 ,right=659 ,bottom=2075 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='십' ,left=669 ,top=2031 ,right=713 ,bottom=2075 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='만' ,left=722 ,top=2031 ,right=766 ,bottom=2075 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='천' ,left=775 ,top=2031 ,right=819 ,bottom=2075 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='백' ,left=828 ,top=2031 ,right=872 ,bottom=2075 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='십' ,left=881 ,top=2031 ,right=925 ,bottom=2075 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='억' ,left=509 ,top=2031 ,right=553 ,bottom=2075 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='백' ,left=403 ,top=2031 ,right=447 ,bottom=2075 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='공란수' ,left=297 ,top=2031 ,right=394 ,bottom=2075 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>							";
ls_for += "	<T>id='일' ,left=234 ,top=2031 ,right=288 ,bottom=2075 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<L> left=31 ,top=2025 ,right=1834 ,bottom=2025 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<T>id='작      성' ,left=38 ,top=1981 ,right=288 ,bottom=2022 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>								";
ls_for += "	<T>id='공     급     가     액' ,left=297 ,top=1981 ,right=978 ,bottom=2022 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>							";
ls_for += "	<L> left=31 ,top=1972 ,right=1834 ,bottom=1972 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<T>id='종' ,left=1519 ,top=1884 ,right=1563 ,bottom=1925 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='목' ,left=1519 ,top=1928 ,right=1563 ,bottom=1969 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='종' ,left=616 ,top=1884 ,right=659 ,bottom=1925 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='목' ,left=616 ,top=1928 ,right=659 ,bottom=1969 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='업     태' ,left=988 ,top=1884 ,right=1191 ,bottom=1966 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>								";
ls_for += "	<C>id='BSNS_CND', left=1200, top=1884, right=1509, bottom=1966, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='BSNS_KND', left=1572, top=1884, right=1828, bottom=1966, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>							";
ls_for += "	<T>id='업     태' ,left=91 ,top=1884 ,right=288 ,bottom=1966 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='서비스업' ,left=297 ,top=1884 ,right=606 ,bottom=1966 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>							";
ls_for += "	<T>id='관광' ,left=669 ,top=1884 ,right=925 ,bottom=1966 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>							";
ls_for += "	<L> left=981 ,top=1878 ,right=1834 ,bottom=1878 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=84 ,top=1878 ,right=928 ,bottom=1878 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<T>id='서울시 종로구 계동 현대빌딩 140-2' ,left=297 ,top=1791 ,right=925 ,bottom=1875 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>				";
ls_for += "	<C>id='ADDNM', left=1200, top=1791, right=1831, bottom=1875, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>							";
ls_for += "	<T>id='주     소' ,left=91 ,top=1834 ,right=288 ,bottom=1875 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='사 업 장' ,left=91 ,top=1791 ,right=288 ,bottom=1831 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<L> left=291 ,top=1784 ,right=928 ,bottom=1784 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=981 ,top=1784 ,right=1834 ,bottom=1784 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<C>id='VEND_NM', left=1200, top=1697, right=1509, bottom=1781, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='VD_DIRECT', left=1572, top=1697, right=1778, bottom=1781, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>						";
ls_for += "	<T>id='인' ,left=1784 ,top=1697 ,right=1828 ,bottom=1781 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='"+g_ceoname+"' ,left=669 ,top=1694 ,right=875 ,bottom=1778 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>							";
ls_for += "	<T>id='인' ,left=881 ,top=1694 ,right=925 ,bottom=1781 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='명' ,left=616 ,top=1737 ,right=659 ,bottom=1778 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='성' ,left=616 ,top=1694 ,right=659 ,bottom=1734 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='현대아산(주)' ,left=300 ,top=1694 ,right=606 ,bottom=1778 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>						";
ls_for += "	<T>id='상    호' ,left=91 ,top=1694 ,right=288 ,bottom=1734 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='(법인명)' ,left=91 ,top=1737 ,right=288 ,bottom=1781 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='상    호' ,left=988 ,top=1694 ,right=1191 ,bottom=1734 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>								";
ls_for += "	<T>id='(법인명)' ,left=988 ,top=1737 ,right=1191 ,bottom=1781 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>								";
ls_for += "	<T>id='등록번호' ,left=988 ,top=1600 ,right=1191 ,bottom=1684 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>								";
ls_for += "	<L> left=84 ,top=1687 ,right=928 ,bottom=1687 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<T>id='등록번호' ,left=91 ,top=1600 ,right=288 ,bottom=1684 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='(                   )' ,left=988 ,top=1500 ,right=1297 ,bottom=1541 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>							";
ls_for += "	<L> left=31 ,top=1594 ,right=1834 ,bottom=1594 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<C>id='TAXDAT', left=1519, top=1450, right=1669, bottom=1516 ,mask='XXXX 권', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF, Dec=0</C>						";
ls_for += "	<T>id='일련번호' ,left=1306 ,top=1525 ,right=1509 ,bottom=1591 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>								";
ls_for += "	<T>id='책 번 호' ,left=1306 ,top=1450 ,right=1509 ,bottom=1516 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>								";
ls_for += "	<L> left=1300 ,top=1519 ,right=1834 ,bottom=1519 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1194 ,top=1594 ,right=1834 ,bottom=1594 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<T>id='공' ,left=934 ,top=1641 ,right=978 ,bottom=1697 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='급' ,left=934 ,top=1700 ,right=978 ,bottom=1756 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='받' ,left=934 ,top=1759 ,right=978 ,bottom=1816 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='는' ,left=934 ,top=1819 ,right=978 ,bottom=1875 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='자' ,left=934 ,top=1878 ,right=978 ,bottom=1934 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='급' ,left=38 ,top=1750 ,right=81 ,bottom=1828 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>										";
ls_for += "	<C>id='CNT', left=1678, top=1450, right=1828, bottom=1516 ,mask='XXXX 호', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>							";
ls_for += "	<T>id='성' ,left=1519 ,top=1697 ,right=1563 ,bottom=1737 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='명' ,left=1519 ,top=1741 ,right=1563 ,bottom=1781 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<L> left=291 ,top=1594 ,right=928 ,bottom=1594 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<T>id='공' ,left=38 ,top=1641 ,right=81 ,bottom=1719 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='자' ,left=38 ,top=1853 ,right=81 ,bottom=1931 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='보     관     용' ,left=988 ,top=1541 ,right=1297 ,bottom=1584 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>							";
ls_for += "	<L> left=84 ,top=1784 ,right=928 ,bottom=1784 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=609 ,top=228 ,right=609 ,bottom=325 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=609 ,top=509 ,right=609 ,bottom=603 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=609 ,top=1878 ,right=609 ,bottom=1972 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=663 ,top=1878 ,right=663 ,bottom=1972 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1619 ,top=1519 ,right=1619 ,bottom=1594 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1725 ,top=1519 ,right=1725 ,bottom=1594 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1778 ,top=1519 ,right=1778 ,bottom=1594 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1566 ,top=1878 ,right=1566 ,bottom=1972 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1566 ,top=1519 ,right=1566 ,bottom=1594 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<T>id='사 업 장' ,left=988 ,top=1791 ,right=1191 ,bottom=1831 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>								";
ls_for += "	<T>id='주     소' ,left=988 ,top=1834 ,right=1191 ,bottom=1875 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>								";
ls_for += "	<T>id='계    산    서' ,left=38 ,top=1434 ,right=984 ,bottom=1569 ,face='굴림' ,size=23 ,bold=true ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>								";
ls_for += "	<L> left=1194 ,top=1594 ,right=1194 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1194 ,top=225 ,right=1194 ,bottom=319 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1194 ,top=1597 ,right=1194 ,bottom=1972 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=97 ,top=772 ,right=97 ,bottom=1100 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=166 ,top=656 ,right=166 ,bottom=1100 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=716 ,top=656 ,right=716 ,bottom=1100 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=822 ,top=656 ,right=822 ,bottom=1100 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=878 ,top=1100 ,right=878 ,bottom=1219 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=347 ,top=1100 ,right=347 ,bottom=1219 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1144 ,top=1100 ,right=1144 ,bottom=1219 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1406 ,top=228 ,right=1406 ,bottom=319 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=716 ,top=228 ,right=716 ,bottom=319 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=822 ,top=228 ,right=822 ,bottom=319 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=344 ,top=228 ,right=344 ,bottom=319 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=1194 ,top=1687 ,right=1831 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=97 ,top=2141 ,right=97 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																		";
ls_for += "	<L> left=166 ,top=2025 ,right=166 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=347 ,top=2469 ,right=347 ,bottom=2587 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=716 ,top=2025 ,right=716 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=822 ,top=2025 ,right=822 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=878 ,top=2469 ,right=878 ,bottom=2587 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=397 ,top=2025 ,right=397 ,bottom=2141 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<T>id='-' ,left=616 ,top=1600 ,right=659 ,bottom=1684 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='-' ,left=456 ,top=1600 ,right=500 ,bottom=1684 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<L> left=556 ,top=1597 ,right=556 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=503 ,top=1597 ,right=503 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=450 ,top=1597 ,right=450 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=397 ,top=1597 ,right=397 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=344 ,top=1597 ,right=344 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=875 ,top=1597 ,right=875 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=822 ,top=1597 ,right=822 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=769 ,top=1597 ,right=769 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=716 ,top=1597 ,right=716 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=663 ,top=1597 ,right=663 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=609 ,top=1597 ,right=609 ,bottom=1687 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=609 ,top=1597 ,right=609 ,bottom=1784 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=609 ,top=228 ,right=609 ,bottom=416 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=663 ,top=1597 ,right=663 ,bottom=1784 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=663 ,top=228 ,right=663 ,bottom=325 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=981 ,top=1687 ,right=1834 ,bottom=1687 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1513 ,top=1684 ,right=1513 ,bottom=1784 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1566 ,top=1684 ,right=1566 ,bottom=1784 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1566 ,top=316 ,right=1566 ,bottom=416 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1513 ,top=312 ,right=1513 ,bottom=416 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=25 ,top=1309 ,right=1834 ,bottom=1309 ,penstyle=dot ,penwidth=1 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=31 ,top=75 ,right=1834 ,bottom=75 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																		";
ls_for += "	<T>id='[별지 제11호 서식]' ,left=28 ,top=37 ,right=434 ,bottom=72 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>						";
ls_for += "	<L> left=31 ,top=1444 ,right=1834 ,bottom=1444 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<T>id='[별지 제11호 서식]' ,left=31 ,top=1406 ,right=438 ,bottom=1441 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>						";
ls_for += "	<L> left=31 ,top=1444 ,right=31 ,bottom=2587 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																		";
ls_for += "	<L> left=28 ,top=75 ,right=28 ,bottom=1219 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																		";
ls_for += "	<L> left=1834 ,top=75 ,right=1834 ,bottom=1219 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1834 ,top=1444 ,right=1834 ,bottom=2587 ,penstyle=solid ,penwidth=3 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1300 ,top=1444 ,right=1300 ,bottom=1597 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1513 ,top=1444 ,right=1513 ,bottom=1597 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1672 ,top=1444 ,right=1672 ,bottom=1597 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1513 ,top=75 ,right=1513 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1300 ,top=75 ,right=1300 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1672 ,top=75 ,right=1672 ,bottom=225 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1672 ,top=228 ,right=1672 ,bottom=319 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																	";
ls_for += "	<T>id='1' ,left=297 ,top=234 ,right=341 ,bottom=316 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='0' ,left=350 ,top=234 ,right=394 ,bottom=316 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='0' ,left=350 ,top=234 ,right=394 ,bottom=316 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='1' ,left=403 ,top=234 ,right=447 ,bottom=316 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='8' ,left=509 ,top=234 ,right=553 ,bottom=316 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='5' ,left=563 ,top=234 ,right=606 ,bottom=316 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='1' ,left=669 ,top=234 ,right=713 ,bottom=316 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='0' ,left=722 ,top=234 ,right=766 ,bottom=316 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='6' ,left=775 ,top=234 ,right=819 ,bottom=316 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='9' ,left=828 ,top=234 ,right=872 ,bottom=316 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='5' ,left=881 ,top=234 ,right=925 ,bottom=316 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>										";
ls_for += "	<T>id='1' ,left=403 ,top=1603 ,right=447 ,bottom=1684 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='8' ,left=509 ,top=1603 ,right=553 ,bottom=1684 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='5' ,left=563 ,top=1603 ,right=606 ,bottom=1684 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='1' ,left=669 ,top=1603 ,right=713 ,bottom=1684 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='0' ,left=722 ,top=1603 ,right=766 ,bottom=1684 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='6' ,left=775 ,top=1603 ,right=819 ,bottom=1684 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='9' ,left=828 ,top=1603 ,right=872 ,bottom=1684 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='5' ,left=881 ,top=1603 ,right=925 ,bottom=1684 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='1' ,left=297 ,top=1603 ,right=341 ,bottom=1684 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<T>id='0' ,left=350 ,top=1603 ,right=394 ,bottom=1684 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>									";
ls_for += "	<C>id='TAXDAT', left=38, top=716, right=163, bottom=766 ,mask='XXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF, Dec=0</C>							";
ls_for += "	<C>id='TAXMM_1', left=172, top=716, right=225, bottom=766, align='left' ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF, Dec=0</C>					";
ls_for += "	<C>id='TAXDT_1', left=234, top=716, right=288, bottom=766, align='left' ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF, Dec=0</C>					";
ls_for += "	<C>id='REMARK', left=988, top=662, right=1828, bottom=766, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='TAXDAT', left=38, top=2084, right=163, bottom=2134 ,mask='XXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF, Dec=0</C>						";
ls_for += "	<C>id='TAXMM_1', left=172, top=2084, right=225, bottom=2134, align='left' ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF, Dec=0</C>					";
ls_for += "	<C>id='TAXDT_1', left=234, top=2084, right=288, bottom=2134, align='left' ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF, Dec=0</C>					";
ls_for += "	<T>id='이 금액을  청구  함' ,left=1413 ,top=1106 ,right=1828 ,bottom=1212 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>							";
ls_for += "	<T>id='이 금액을  청구  함' ,left=1413 ,top=2475 ,right=1828 ,bottom=2581 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>							";
ls_for += "	<C>id={MTAXSUM+MTAXVATAMT}, left=38, top=1156, right=344, bottom=1212, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>					";
ls_for += "	<C>id={MTAXSUM+MTAXVATAMT}, left=38, top=2525, right=344, bottom=2581, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>					";
ls_for += "	<C>id={decode(BlkCnt,'0','',BlkCnt)}, left=297, top=2084, right=394, bottom=2134 ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>				";
ls_for += "	<C>id={decode(BlkCnt,'0','',BlkCnt)}, left=297, top=716, right=394, bottom=766 ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>					";
ls_for += "	<C>id='TSUM_1', left=934, top=716, right=978, bottom=766, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_2', left=881, top=716, right=925, bottom=766, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_3', left=828, top=716, right=872, bottom=766, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_4', left=775, top=716, right=819, bottom=766, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_5', left=722, top=716, right=766, bottom=766, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_6', left=669, top=716, right=713, bottom=766, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_7', left=616, top=716, right=659, bottom=766, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_8', left=563, top=716, right=606, bottom=766, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_9', left=509, top=716, right=553, bottom=766, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_10', left=456, top=716, right=500, bottom=766, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_11', left=403, top=716, right=447, bottom=766, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_1', left=934, top=2084, right=978, bottom=2134, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_2', left=881, top=2084, right=925, bottom=2134, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_3', left=828, top=2084, right=872, bottom=2134, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_4', left=775, top=2084, right=819, bottom=2134, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_5', left=722, top=2084, right=766, bottom=2134, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_6', left=669, top=2084, right=713, bottom=2134, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_7', left=616, top=2084, right=659, bottom=2134, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_8', left=563, top=2084, right=606, bottom=2134, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_9', left=509, top=2084, right=553, bottom=2134, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_10', left=456, top=2084, right=500, bottom=2134, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<C>id='TSUM_11', left=403, top=2084, right=447, bottom=2134, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF, Dec=0</C>								";
ls_for += "	<L> left=1088 ,top=2144 ,right=1088 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1088 ,top=775 ,right=1088 ,bottom=1100 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1513 ,top=509 ,right=1513 ,bottom=603 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<T>id='비        고' ,left=988 ,top=612 ,right=1828 ,bottom=653 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>								";
ls_for += "	<L> left=1459 ,top=228 ,right=1459 ,bottom=319 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1353 ,top=228 ,right=1353 ,bottom=319 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1300 ,top=228 ,right=1300 ,bottom=319 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1247 ,top=228 ,right=1247 ,bottom=319 ,penstyle=solid ,penwidth=3 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1406 ,top=1100 ,right=1406 ,bottom=1219 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<L> left=1144 ,top=2469 ,right=1144 ,bottom=2587 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1406 ,top=2469 ,right=1406 ,bottom=2587 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<L> left=1566 ,top=2141 ,right=1566 ,bottom=2469 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<C>id='BIGO_4', left=1572, top=2406, right=1828, bottom=2466, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='BIGO_3', left=1572, top=2337, right=1828, bottom=2397, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='BIGO_2', left=1572, top=2269, right=1828, bottom=2328, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='BIGO_1', left=1572, top=2200, right=1828, bottom=2259, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id={decode(TAXSUM_1,'0','',TAXSUM_1)}, left=1094, top=2200, right=1563, bottom=2259, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>			";
ls_for += "	<C>id={decode(TAXSUM_2,'0','',TAXSUM_2)}, left=1094, top=2269, right=1563, bottom=2328, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>			";
ls_for += "	<C>id={decode(TAXSUM_3,'0','',TAXSUM_3)}, left=1094, top=2337, right=1563, bottom=2397, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>			";
ls_for += "	<C>id={decode(TAXSUM_4,'0','',TAXSUM_4)}, left=1094, top=2406, right=1563, bottom=2466, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>			";
ls_for += "	<L> left=31 ,top=2078 ,right=981 ,bottom=2078 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	<T>id='비        고' ,left=988 ,top=1981 ,right=1828 ,bottom=2022 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>								";
ls_for += "	<C>id='REMARK', left=988, top=2031, right=1828, bottom=2134, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>							";
ls_for += "	<L> left=1566 ,top=772 ,right=1566 ,bottom=1100 ,penstyle=solid ,penwidth=1 ,pencolor=#0000FF </L>																	";
ls_for += "	<T>id='비고' ,left=1572 ,top=781 ,right=1828 ,bottom=822 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>									";
ls_for += "	<C>id='BIGO_1', left=1572, top=831, right=1828, bottom=891, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='BIGO_2', left=1572, top=900, right=1828, bottom=959, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='BIGO_3', left=1572, top=969, right=1828, bottom=1028, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<C>id='BIGO_4', left=1572, top=1037, right=1828, bottom=1097, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>							";
ls_for += "	<T>id='공 급 가 액' ,left=1094 ,top=781 ,right=1563 ,bottom=822 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>								";
ls_for += "	<C>id={decode(TAXSUM_4,'0','',TAXSUM_4)}, left=1094, top=1037, right=1563, bottom=1097, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>			";
ls_for += "	<C>id={decode(TAXSUM_3,'0','',TAXSUM_3)}, left=1094, top=969, right=1563, bottom=1028, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>			";
ls_for += "	<C>id={decode(TAXSUM_2,'0','',TAXSUM_2)}, left=1094, top=900, right=1563, bottom=959, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>			";
ls_for += "	<C>id={decode(TAXSUM_1,'0','',TAXSUM_1)}, left=1094, top=831, right=1563, bottom=891, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>			";
ls_for += "	<L> left=1513 ,top=1878 ,right=1513 ,bottom=1972 ,penstyle=solid ,penwidth=1 ,pencolor=#FF0000 </L>																	";
ls_for += "	</B>																													";	
	
	gcrp_print.format = ls_for + gcrp_print.format;

}

/******************************************************************************
	Description : Dataset Head 설정
******************************************************************************/
function ln_Header(){  //##
	/*매입 - Header */
	var Theder = "TAXNBR:STRING(11),COCODE:STRING(2),DEPTCD:STRING(4),EMPNO:STRING(7),TAXIODIV:STRING(1),"
						 + "TAXDIV:STRING(4),TAXDIVNM:STRING(40),TAXKND:STRING(1),TAXKNDNM:STRING(40),VEND_CD:STRING(13),"
						 + "VEND_ID:STRING(15),VEND_NM:STRING(32),TAXDAT:STRING(8),TAXSUM:DECIMAL(15),TAXVATAMT:DECIMAL(13),"
						 + "TAXTOT:DECIMAL(15),REMARK:STRING(132),TAXCDNBR:STRING(16),ATCODE:STRING(7),ATKORNAM:STRING(66),"
						 + "ATDECR:STRING(1),TAXPRTYN:STRING(1),TAXCNT:DECIMAL(3),LASTPRT:STRING(8),TAXTYPE:STRING(1),"
						 + "FSDAT:STRING(9),FSNBR:STRING(6),TAXKIDIV:STRING(1),WRDT:STRING(8),WRID:STRING(7),"
						 + "UPDT:STRING(8),UPID:STRING(7),FDCODE:STRING(2),VD_DIRECT:STRING(12),BSNS_CND:STRING(22),"
						 + "BSNS_KND:STRING(22),ADDNM:STRING(144),FSSTAT:STRING(1),TAXNBR_R:STRING(10),WORKTYPE:STRING(1),"
 						 + "EMPNMK:STRING(30),DEPTNM:STRING(30),SEQ:DECIMAL(2),DTI_STATUS:STRING(1),"
						 + "GUBUN:STRING(1),AMEND_CODE:STRING(2),AMEND_REMARK:STRING(100),REMARK2:STRING(150),"
						 + "REMARK3:STRING(150),S_BIZPLACE:STRING(4),COSTCD:STRING(6),COSTNM:STRING(100)";

	gcds_data1.SetDataHeader(Theder);

	var Theder11 = "TAXNBR:STRING(11),COCODE:STRING(2),DEPTCD:STRING(4),EMPNO:STRING(7),TAXIODIV:STRING(1),"
						 + "TAXDIV:STRING(4),TAXKND:STRING(1),VEND_CD:STRING(13),TAXDAT:STRING(8),TAXSUM:DECIMAL(15),"
						 + "TAXVATAMT:DECIMAL(13),TAXTOT:DECIMAL(15),REMARK:STRING(132),TAXCDNBR:STRING(16),ATCODE:STRING(7),"
						 + "TAXPRTYN:STRING(1),TAXCNT:DECIMAL(3),LASTPRT:STRING(8),TAXTYPE:STRING(1),FSDAT:STRING(9),"
						 + "FSNBR:STRING(6),TAXKIDIV:STRING(1),FDCODE:STRING(2),WORKTYPE:STRING(1),WRDT:STRING(8),"
						 + "WRID:STRING(7),SEQ:DECIMAL(2),GUBUN:STRING(1),AMEND_CODE:STRING(2),AMEND_REMARK:STRING(100),EXTCHK:STRING(1),REMARK2:STRING(150),"
						 + "REMARK3:STRING(150),S_BIZPLACE:STRING(4),COSTCD:STRING(6),COSTNM:STRING(100)";

	gcds_data11.SetDataHeader(Theder11);
	gcds_data22.SetDataHeader(Theder11);

	var Theder2 = "TAXNBR:STRING(11),TAXSEQ:STRING(3),TAXPDTNAM:STRING(70),TAXSTD:STRING(36),TAXQTY:DECIMAL(13),"
						  + "TAXPRIC:DECIMAL(15),TAXSUM:DECIMAL(15),TAXVATAMT:DECIMAL(13),TAXTOT2:DECIMAL(15),"
						  + "BIGO:STRING(66),WRDT:STRING(8),WRID:STRING(7),UPDT:STRING(8),UPID:STRING(7),TAXMM:STRING(2),TAXDT:STRING(2)";
	gcds_data2.SetDataHeader(Theder2);

	/*매출 - Header */
	var Theder_2 = "TAXNBR:STRING(11),COCODE:STRING(2),DEPTCD:STRING(4),EMPNO:STRING(7),TAXIODIV:STRING(1),"
						   + "TAXDIV:STRING(4),TAXDIVNM:STRING(40),TAXKND:STRING(1),TAXKNDNM:STRING(40),VEND_CD:STRING(13),"
						   + "VEND_NM:STRING(32),TAXDAT:STRING(8),TAXSUM:DECIMAL(15),TAXVATAMT:DECIMAL(13),TAXTOT:DECIMAL(15),"
						   + "REMARK:STRING(132),TAXCDNBR:STRING(16),ATCODE:STRING(7),ATKORNAM:STRING(66),ATDECR:STRING(1),TAXPRTYN:STRING(1),"
						   + "TAXCNT:DECIMAL(3),LASTPRT:STRING(8),TAXTYPE:STRING(1),FSDAT:STRING(9),FSNBR:STRING(6),"
						   + "TAXKIDIV:STRING(1),WRDT:STRING(8),WRID:STRING(7),UPDT:STRING(8),UPID:STRING(7),"
						   + "FDCODE:STRING(2),WORKTYPE:STRING(1),VD_DIRECT:STRING(12),BSNS_CND:STRING(22),BSNS_KND:STRING(22),ADDNM:STRING(144),"
						   + "FSSTAT:STRING(1),TAXNBR_R:STRING(10),SEQ:DECIMAL(2),DTI_STATUS:STRING(1),"
							 + "GUBUN:STRING(1),AMEND_CODE:STRING(2),AMEND_REMARK:STRING(100),REMARK2:STRING(150),"
							 + "REMARK3:STRING(150),S_BIZPLACE:STRING(4),COSTCD:STRING(6),COSTNM:STRING(100)";
	gcds_data1_2.SetDataHeader(Theder_2);

	var Theder2_2 = "TAXNBR:STRING(11),TAXSEQ:STRING(3),TAXPDTNAM:STRING(70),TAXSTD:STRING(36),TAXQTY:DECIMAL(13),"
						  + "TAXPRIC:DECIMAL(15),TAXSUM:DECIMAL(15),TAXVATAMT:DECIMAL(13),TAXTOT2:DECIMAL(15),"
						  + "BIGO:STRING(66),WRDT:STRING(8),WRID:STRING(7),UPDT:STRING(8),UPID:STRING(7),TAXMM:STRING(2),TAXDT:STRING(2)";
	gcds_data2_2.SetDataHeader(Theder2_2);
}

/******************************************************************************
	Description : Enter 설정
******************************************************************************/
function ln_Enter(e){
	if(e=="TAXMM"){
		gcgd_data2.SetColumn("TAXDT");
	}else	if(e=="TAXDT"){
		gcgd_data2.SetColumn("TAXPDTNAM");
	}else	if(e=="TAXPDTNAM"){
		gcgd_data2.SetColumn("TAXSTD");
	}else	if(e=="TAXSTD"){
		gcgd_data2.SetColumn("TAXQTY");
	}else	if(e=="TAXQTY"){
		gcgd_data2.SetColumn("TAXPRIC");
	}else	if(e=="TAXPRIC"){
		gcgd_data2.SetColumn("TAXSUM");
	}else	if(e=="TAXSUM"){
		gcgd_data2.SetColumn("TAXVATAMT");
	}else	if(e=="TAXVATAMT"){
		gcgd_data2.SetColumn("TAXTOT2");
	}else	if(e=="TAXTOT2"){
		gcgd_data2.SetColumn("BIGO");
	}
}

/******************************************************************************
	Description : 라디오 버튼 체크
	              2009.12.04 jys 추가
******************************************************************************/
function ln_Rdo_Chk(param){

	if(param=="1"){
		rdo_gubun1_1.checked=true;
		rdo_gubun1_2.checked=false;
	}else if(param=="2"){
    rdo_gubun1_1.checked=false;
		rdo_gubun1_2.checked=true;
	}else if(param=="3"){
	  	rdo_gubun2_1.checked=true;	  	
		rdo_gubun2_2.checked=false;					
	}else if(param=="4"){
	  	rdo_gubun2_1.checked=false;	  
		rdo_gubun2_2.checked=true;	
	}
}

/******************************************************************************
	Description : 수정세금계산서 체크 버튼 체크
	              2009.12.04 jys 추가
******************************************************************************/
function ln_ChkBox(){

	if(chk_tax.checked==true){
		gclx_amend_code.Enable = true;
		gcem_amend_remark.ReadOnly=false;
	}else{
		gclx_amend_code.Enable = false;
		gcem_amend_remark.ReadOnly=true;
        gclx_amend_code.bindcolval="00";
        gcem_amend_remark.text="";
	}
}

/******************************************************************************
	Description : 외부시스템 매출발행
	              2010.08.24 jys 추가
******************************************************************************/
function ln_ChkBox2(){
  
	if(chk_ext.checked==true){ 
		gcds_data1_2.namevalue(gcds_data1_2.rowposition,"EXTCHK")="1";
		alert("외부시스템 발행 여부를 [회계팀]에 꼭 확인 후 체크하여 주시기 바랍니다.(☎ 3669-3638)");
	}else{
    gcds_data1_2.namevalue(gcds_data1_2.rowposition,"EXTCHK")="0";
	}	
}

/******************************************************************************
	Description : 사업장 Display
	              2010.12.02 jys 추가
******************************************************************************/
function ln_Display_Cocode(){
  if(gclx_cocode2.bindcolval=="02"){//서울
		sp1.style.display = "";
    gcem_s_bizplace.text="0001"; //종사업장번호
		gcem_remark_b2.text="현대아산주식회사(지점) 서울 종로 연지 1-7";
  }else if(gclx_cocode2.bindcolval=="03"){//양양
		sp1.style.display = "";
    gcem_s_bizplace.text="0002"; //종사업장번호
		gcem_remark_b2.text="현대아산주식회사 강원도 양양군 손양면 동호리 545";
	}else{ //고성
    sp1.style.display = "none"; //숨김
		gcem_s_bizplace.text="";
		gcem_remark_b2.text="";
	}
}

/******************************************************************************
	Description : 매입
	              과세구분으로 전자발행구분 자동 선택 
******************************************************************************/
function ln_Taxknd_Chg(){
	if(gclx_taxknd.bindcolval=="1"||gclx_taxknd.bindcolval=="2"||gclx_taxknd.bindcolval=="4"){
		ln_Rdo_Chk('1');
	}else if(gclx_taxknd.bindcolval=="3"||gclx_taxknd.bindcolval=="7"||gclx_taxknd.bindcolval=="8"){
        ln_Rdo_Chk('2');
	}
}

/******************************************************************************
	Description : 매출
	              과세구분으로 전자발행구분 자동 선택 
******************************************************************************/
function ln_Taxknd_Chg2(){

	if(gclx_taxknd2.bindcolval=="1"||gclx_taxknd2.bindcolval=="2"){
		ln_Rdo_Chk('3');
	}else if(gclx_taxknd2.bindcolval=="3"){
        ln_Rdo_Chk('4');
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcds_data1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data11" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data22" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true"><!-- max taxnbr -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_fdcode" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 지점코드[매입] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_dept" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 담당부서[매입] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_deptprt" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 본부[매입] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_empno" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 담당자[매입] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_taxdiv" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 귀속구분[매입] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_taxdiv2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 귀속구분[매출] -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id="gcds_taxknd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 부가세종류[매입] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_worktype" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 회계구분[매입] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_taxcdnbr" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 신용카드관리 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_print" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true"><!-- 출력조회 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"	VALUE="false"><!-- 세금계산서(cross) -->												 
	<PARAM NAME="Logical"		VALUE="true">																									 
  <PARAM NAME="DataID"		VALUE="gcds_print">
	<PARAM NAME="GroupExpr"	VALUE="TAXNBR:VEND_NM:VD_DIRECT:BSNS_CND:BSNS_KND:ADDNM:MTAXSUM:MTAXVATAMT:TAXDAT:REMARK:TSUM_11:TSUM_10:TSUM_9:TSUM_8:TSUM_7:TSUM_6:TSUM_5:TSUM_4:TSUM_3:TSUM_2:TSUM_1:TVAT_10:TVAT_9:TVAT_8:TVAT_7:TVAT_6:TVAT_5:TVAT_4:TVAT_3:TVAT_2:TVAT_1:BlkCnt:CNT:SEQ_1:SEQ_2:SEQ_3:SEQ_4:SEQ_5:SEQ_6:VSEQ_1:VSEQ_2:VSEQ_3:VSEQ_4:VSEQ_5:VSEQ_6:VSEQ_7:VSEQ_8: VSEQ_9:VSEQ_10,TAXSEQ,TAXSEQ:TAXPDTNAM:TAXSTD:TAXQTY:TAXPRIC:TAXSUM:TAXVATAMT:BIGO:TAXMM:TAXDT">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data1_2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 매출MST -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data2_2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 매출DTL -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_fdcode2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 지점코드[매출] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_dept2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 담당부서[매출] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_taxknd2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 부가세종류[매출] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_actcode1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true"><!-- 계정과목[매입] -->
	<PARAM NAME="SortExpr" VALUE="+PSEQ">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_actcode2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true"><!-- 계정과목[매출] -->
	<PARAM NAME="SortExpr" VALUE="+PSEQ">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__">
<object  id="gcds_insert" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object>

<!-- @@2008.05.21 세금계산서 번호 RETURN -->
 <object  id=gcds_taxnbr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

 <!-- 종사업장 관리 -->
 <object  id=gcds_bizplace classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gctr_data1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!-- 매입MST -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gctr_data1_1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!-- 매입MST -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gctr_data2" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!-- 매입DTL -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gctr_data1_2" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!-- 매출MST -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gctr_data1_3" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!-- 매출MST -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gctr_data1_4" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!-- 매출MST -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gctr_data2_2" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!-- 매출DTL -->
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
	window.status = "정상적으로 조회되었습니다.";
	if (row<1) { 
		alert("검색된 데이터가 없습니다.");
		gcds_data2.ClearData();
		gcem_staxnbr.focus();
		//gcds_insert.ClearData();

		txt_fixprop.value	=	"";
		txt_fixpropnm.value	=	"";
		txt_fixpropnm_cnt.value	=	"";

	}else{
		//gcem_taxnbr.text = gcds_data1.namevalue(gcds_data1.rowposition,"TAXNBR").substring(1,11);
		var row1 = gcds_data1.rowposition;
		if (gcds_data1.RowStatus(row1)!="1") ln_Query('2');//세금계산서 상세조회

		if(gcds_data1.namevalue(row1,"GUBUN")=="1"){
			ln_Rdo_Chk('1');
		}else if(gcds_data1.namevalue(row1,"GUBUN")=="2"){
      ln_Rdo_Chk('2');
		}

		//본부코드
		var str_tree = gcds_dept.namevalue(gcds_dept.rowposition,"TREECD");
		gcds_deptprt.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdeptprt_s1?v_str3="+str_tree.substring(0,4)+"0000"; 
		gcds_deptprt.Reset();
		gclx_dept.index=0;
		gclx_empno.index=0;
		gclx_empno2.index=0;
	}
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt2.innerText = "조회건수 : " + row + " 건";
	window.status = "정상적으로 조회되었습니다.";

	if (row<1) { alert("검색된 데이터가 없습니다."); 
		gcem_taxsum.text		= gcds_data2.Sum(7,0,0);												//공급가액
		gcem_taxvatamt.text = gcds_data2.Sum(8,0,0);												//부가세액
		gcem_taxtot.text		= gcds_data2.Sum(7,0,0)+gcds_data2.Sum(8,0,0);	//합계

	  //if(gcds_data1.IsUpdated) { 
		//ln_Save_1();	
	  //}
	}else{
		//alert("gcds_data2:::onloadCompleted");
		gcem_taxsum.text		= gcds_data2.Sum(7,0,0);												//공급가액
		gcem_taxvatamt.text = gcds_data2.Sum(8,0,0);												//부가세액
		gcem_taxtot.text		= gcds_data2.Sum(7,0,0)+gcds_data2.Sum(8,0,0);	//합계
		//if(gcds_data1.IsUpdated)		{
		//   ln_Save_1();	
	  //}
	}
</script>

<script language="javascript" for="gcds_print" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_print" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row<1) { alert("출력하실 정보가 없습니다"); 
	}else{
		//gcrp_print.preview();	//세금계산서 미리보기
	}
</script>

<script language="javascript" for="gcds_empno" event="onloadCompleted(row,colid)">
	//매입-담당자
	if(cuserid=="ACCOUNT"|| cuserid==null){
	  /*
		gcds_empno.InsertRow(1);
		gcds_empno.NameValue(1,"EMPNO") ="1990054";
		gcds_empno.NameValue(1,"EMPNMK")="권정교";
		gclx_empno.index=0;
		gclx_empno2.index=0;
		*/
	}else{
		gclx_empno.bindcolval  = cuserid;
		gclx_empno2.bindcolval = cuserid;
	}	
</script>

<script language="javascript" for="gcds_taxdiv" event="onloadCompleted(row,colid)">
	gcds_taxdiv.InsertRow(1);
	gcds_taxdiv.NameValue(1,"CDCODE") ="";
	gcds_taxdiv.NameValue(1,"CDNAM")="";
	gclx_taxdiv.index = 1;
</script>

<script language="javascript" for="gcds_taxdiv2" event="onloadCompleted(row,colid)">
	gcds_taxdiv2.InsertRow(1);
	gcds_taxdiv2.NameValue(1,"CDCODE") ="";
	gcds_taxdiv2.NameValue(1,"CDNAM")="";
	gclx_taxdiv2.index = 1;
</script>

<script language="javascript" for="gcds_worktype" event="onloadCompleted(row,colid)">
	gcds_worktype.InsertRow(1);
	gcds_worktype.NameValue(1,"CDCODE")="";
	gcds_worktype.NameValue(1,"CDNAM")="";
	gclx_worktype.index = 1;
	gclx_worktype2.index = 1;
</script>

<script language="javascript" for="gcds_data1_2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1_2" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	window.status = "정상적으로 조회되었습니다.";
	if (row<1) { 
		alert("검색된 데이터가 없습니다.");
		gcds_data2_2.ClearData();
		gcem_staxnbr2.focus();
	}else{
		//gcem_taxnbr2.text = gcds_data1_2.namevalue(gcds_data1_2.rowposition,"TAXNBR").substring(1,11);
		var row1 = gcds_data1_2.rowposition;
		if (gcds_data1_2.RowStatus(row1)!="1") ln_Query2('2');	//세금계산서 상세조회

		if(gcds_data1_2.namevalue(row1,"GUBUN")=="1"){
			ln_Rdo_Chk('3');
		}else if(gcds_data1_2.namevalue(row1,"GUBUN")=="2"){
      ln_Rdo_Chk('4');
		}
  
	  if(gcds_data1_2.namevalue(row1,"AMEND_CODE")=="01"||gcds_data1_2.namevalue(row1,"AMEND_CODE")=="02"||
	     gcds_data1_2.namevalue(row1,"AMEND_CODE")=="03"||gcds_data1_2.namevalue(row1,"AMEND_CODE")=="04"||
	     gcds_data1_2.namevalue(row1,"AMEND_CODE")=="05"||gcds_data1_2.namevalue(row1,"AMEND_CODE")=="06"){
			 chk_tax.checked=true;
			 ln_ChkBox();	
		}else{
			 chk_tax.checked=false;
			 ln_ChkBox();	
		}

    //2010.08.24.JYS
		/*
    if(gcds_data1_2.namevalue(row1,"EXTCHK")=="1"){
		 	 chk_ext.chkecked = true;
		}else{
       chk_ext.chkecked = false;
		}
		**/

		//본부코드
		var str_tree = gcds_dept.namevalue(gcds_dept.rowposition,"TREECD");
		gcds_deptprt.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdeptprt_s1?v_str3="+str_tree.substring(0,4)+"0000"; 
		gcds_deptprt.Reset();

		gclx_dept2.index=0;
		gclx_empno.index=0;
		gclx_empno2.index=0;
	}
</script>

<script language="javascript" for="gcds_data2_2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2_2" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt2_2.innerText = "조회건수 : " + row + " 건";
	window.status = "정상적으로 조회되었습니다.";

	if (row<1) { alert("검색된 데이터가 없습니다."); 
		gcem_taxsum2.text			= gcds_data2_2.Sum(7,0,0);													//공급가액
		gcem_taxvatamt2.text	= gcds_data2_2.Sum(8,0,0);													//부가세액
		gcem_taxtot2.text			= gcds_data2_2.Sum(7,0,0)+gcds_data2_2.Sum(8,0,0);	//합계

	//	if(gcds_data1_2.IsUpdated)
	//	{ ln_Save2_2();	}
	}else{
		gcem_taxsum2.text			= gcds_data2_2.Sum(7,0,0);													//공급가액
		gcem_taxvatamt2.text	= gcds_data2_2.Sum(8,0,0);													//부가세액
		gcem_taxtot2.text			= gcds_data2_2.Sum(7,0,0)+gcds_data2_2.Sum(8,0,0);	//합계
		
		//if(gcds_data1_2.IsUpdated) { ln_Save2_2();	}
	}
</script>

<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	if(cuserid=="ACCOUNT"){
		gclx_fdcode.index=1;
	}else{
		gclx_fdcode.bindcolval=g_fdcod;
	}
</script>

<script language="javascript" for="gcds_fdcode2" event="onloadCompleted(row,colid)">
	if(cuserid=="ACCOUNT"){
		gclx_fdcode2.index=1;
	}else{
		gclx_fdcode2.bindcolval=g_fdcod;
	}
</script>

<script language="javascript" for="gcds_dept2" event="onloadCompleted(row,colid)">
	gclx_dept2.index=0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
  //alert("index::"+index);
	ln_DispChk((index-1)); 
  
	//&&2008.05.21
	if(index==1){       //매입
	  g_gb ="A";
		g_numgb = ln_Taxnbr_Gb(gfdcode);
	}else if(index==2){ //매출
	  g_gb ="B";
		g_numgb = ln_Taxnbr_Gb(gfdcode); 
	}
</script>

<!---- 매입세액 변경시 합계액 구함..--->
<!-- <script language=JavaScript for=gcds_data2 event=onColumnChanged(row,colid)>
if (colid == 'TAXVATAMT' || colid == 'TAXSUM') {
	gcds_data2.Namevalue(row,"TAXTOT") = parseFloat(gcds_data2.NameValue(row,'TAXVATAMT')) + parseFloat(gcds_data2.NameValue(row,'TAXSUM'));
}
</script> -->
<!---- 매출세액 변경시 합계액 구함..--->
<!-- <script language=JavaScript for=gcds_data2_2 event=onColumnChanged(row,colid)>

if (colid == "TAXVATAMT" || colid == "TAXSUM") {
	gcds_data2_2.Namevalue(row,"TAXTOT") = parseFloat(gcds_data2_2.NameValue(row,"TAXVATAMT")) + parseFloat(gcds_data2_2.NameValue(row,"TAXSUM"));
}
</script> -->

<script language=JavaScript for=gcgd_data2 event=onKeyPress(kcode)>
	var row = gcds_data2.rowposition;	//세부내역 합계[매입]
	var row1 = gcds_data1.rowposition;
	gcds_data2.namevalue(row,"TAXTOT2") = gcds_data2.namevalue(row,"TAXSUM")
																			+ gcds_data2.namevalue(row,"TAXVATAMT");

	gcds_data1.namevalue(row1,"TAXTOT") = gcds_data1.namevalue(row1,"TAXSUM")
																			+ gcds_data1.namevalue(row1,"TAXVATAMT");
  if(kcode==13)	ln_Enter(gcgd_data2.GetColumn());
  
	if(gcgd_data2.GetColumn()=="TAXVATAMT" ){
		//alert("row::"+row+":::"+gcds_data2.namevalue(row,"TAXSUM")+"::"+gcds_data2.namevalue(row,"TAXVATAMT"));
	}
</script>

<script language=JavaScript for=gcgd_data2 event=OnKillFocus()>
	var row = gcds_data2.rowposition; //세부내역 합계[매입]
	var row1 = gcds_data1.rowposition; 
	gcds_data2.namevalue(row,"TAXTOT2") = gcds_data2.namevalue(row,"TAXSUM")
																			+ gcds_data2.namevalue(row,"TAXVATAMT");

	gcds_data1.namevalue(row1,"TAXTOT") = gcds_data1.namevalue(row1,"TAXSUM")
																			+ gcds_data1.namevalue(row1,"TAXVATAMT");
</script>


<!-- 2008.06.12. 정영식 추가 START : 과세일 경우만 부가세 10% 자동 적용 -->
<script language=JavaScript for=gcds_data2 event=onColumnChanged(row,colid)>
  
	if (colid == 'TAXVATAMT' || colid == 'TAXSUM') {
		gcds_data2.Namevalue(row,"TAXTOT") = parseFloat(gcds_data2.NameValue(row,'TAXVATAMT')) + parseFloat(gcds_data2.NameValue(row,'TAXSUM'));
	}

	if (colid == 'TAXSUM') {
		if(gclx_taxknd.bindcolval=="1"){ //과세일 경우 
			gcds_data2.NameValue(row,'TAXVATAMT')= Math.round(gcds_data2.NameValue(row,'TAXSUM')*0.1);
		}else{
			gcds_data2.NameValue(row,'TAXVATAMT')=0;
		}
	}

	if(colid=='TAXPDTNAM'&&gcds_data2.NameValue(row,'TAXPDTNAM')!=""){
		 if(gcds_data2.NameValue(row,'TAXPDTNAM').length>19){
				alert("품목명이 너무 길어서 저장이 되지 않을 수도 있습니다.");
		 }
	}
</script>

<script language=JavaScript for=gcds_data2_2 event=onColumnChanged(row,colid)>
	if (colid == "TAXVATAMT" || colid == "TAXSUM") {
		gcds_data2_2.Namevalue(row,"TAXTOT") = parseFloat(gcds_data2_2.NameValue(row,"TAXVATAMT")) + parseFloat(gcds_data2_2.NameValue(row,"TAXSUM"));
	}

	if (colid == 'TAXSUM') {
		if(gclx_taxknd2.bindcolval=="1"){ //과세일 경우 
			gcds_data2_2.NameValue(row,'TAXVATAMT')= Math.round(gcds_data2_2.NameValue(row,'TAXSUM')*0.1);
		}else{
			gcds_data2_2.NameValue(row,'TAXVATAMT')=0;
		}
	}

	if(colid=='TAXPDTNAM'&&gcds_data2_2.NameValue(row,'TAXPDTNAM')!=""){
		 if(gcds_data2_2.NameValue(row,'TAXPDTNAM').length>19){
				alert("품목명이 너무 길어서 저장이 되지 않을 수도 있습니다.");
		 }
	}
</script>
<!-- 2008.06.12. 정영식 추가 END -->

<script language=JavaScript for=gcgd_data2_2 event=onKeyPress()>
	var row = gcds_data2_2.rowposition;	//세부내역 합계[매출]
	var row1 = gcds_data1_2.rowposition; 
	gcds_data2_2.namevalue(row,"TAXTOT2") = gcds_data2_2.namevalue(row,"TAXSUM")
																			  + gcds_data2_2.namevalue(row,"TAXVATAMT");
	gcds_data1_2.namevalue(row1,"TAXTOT") = gcds_data1_2.namevalue(row1,"TAXSUM")
																			  + gcds_data1_2.namevalue(row1,"TAXVATAMT");
</script>

<script language=JavaScript for=gcgd_data2_2 event=OnKillFocus()>
	var row = gcds_data2_2.rowposition; //세부내역 합계[매출]
	var row1 = gcds_data1_2.rowposition; 
	gcds_data2_2.namevalue(row,"TAXTOT2") = gcds_data2_2.namevalue(row,"TAXSUM")
																			  + gcds_data2_2.namevalue(row,"TAXVATAMT");
	gcds_data1_2.namevalue(row1,"TAXTOT") = gcds_data1_2.namevalue(row1,"TAXSUM")
																			  + gcds_data1_2.namevalue(row1,"TAXVATAMT");
</script>

<script language=JavaScript for=gclx_cocode2 event=OnSelChange()>
	ln_Display_Cocode();
</script>

<script language=JavaScript for=gclx_taxknd event=OnSelChange()>
	ln_Taxknd_Chg();
</script>

<script language=JavaScript for=gclx_taxknd2 event=OnSelChange()>
	ln_Taxknd_Chg2();
</script>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data1" event="onsuccess()">
	gcem_staxnbr.Enable	= true;
	alert("작업이 성공적으로 완료되었습니다.");	//매입
  //alert("	"+gcds_taxnbr.namevalue(gcds_taxnbr.rowposition,"TAXNBR"));
  if(gcds_taxnbr.namevalue(gcds_taxnbr.rowposition,"TAXNBR")!=""&&gcds_taxnbr.namevalue(gcds_taxnbr.rowposition,"TAXNBR")!=undefined){
		gcem_taxnbr.text = gcds_taxnbr.namevalue(gcds_taxnbr.rowposition,"TAXNBR"); //구분자 포함.
		gcem_staxnbr.text = gcem_taxnbr.text.substring(1,11);                       //구분자미포함.
	}
</script>

<script language="javascript" for="gctr_data1" event="onfail()">
	gcem_staxnbr.Enable	= true;
	alert("작업이 성공적으로 완료되지 못했습니다.");
  alert("Error Code : " + gctr_data1.ErrorCode + "\n" + "Error Message : " + gctr_data1.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data1_2" event="onsuccess()">
	gcem_staxnbr2.Enable	= true;
	alert("작업이 성공적으로 완료되었습니다.");	//매출
	//alert("TAXNBR::"+gcds_taxnbr.namevalue(gcds_taxnbr.rowposition,"TAXNBR"));
  if(gcds_taxnbr.namevalue(gcds_taxnbr.rowposition,"TAXNBR")!=""&&gcds_taxnbr.namevalue(gcds_taxnbr.rowposition,"TAXNBR")!=undefined){
		gcem_taxnbr2.text = gcds_taxnbr.namevalue(gcds_taxnbr.rowposition,"TAXNBR"); //구분자 포함.
		gcem_staxnbr2.text = gcem_taxnbr.text.substring(1,11);                       //구분자미포함.
	}
</script>

<script language="javascript" for="gctr_data1_2" event="onfail()">
	gcem_staxnbr2.Enable	= true;
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data1_2.ErrorCode + "\n" + "Error Message : " + gctr_data1_2.ErrorMsg + "\n");
</script>

</head>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a040001_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr>
					<td width="0" align=right>
						<comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:260px;height:20px;">
							<PARAM NAME="BackColor"					VALUE="#cccccc">
   					  		<PARAM NAME="titleHeight"				VALUE="20px">
						    <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
						    <PARAM NAME="Format"						VALUE="
								<T>divid=div_1		title='매입'</T>
								<T>divid=div_2		title='매출'</T>									
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
<fieldset id=field1 style="position:absolute;top:160px;left:18px;height:513px;width:880px;bacground-color:#708090"></fieldset>
<div id="div_disp1" style="border:0 solid #708090;">
<table border="0" cellpadding=0 cellspacing=0 style="position:relative;left:0px;">
	<tr>
		<td>
			<table width="867px" border="0" cellpadding=0 cellspacing=0 style="position:relative;left:8px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;">
					<tr> 
						<td class="tab37" width="100px" bgcolor="#eeeeee"><nobr>지점코드</nobr></td>
						<td class="tab18" width="169px;"><comment id="__NSID__">
							<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:160px;height:110px;">
								<param name=ComboDataID			value="gcds_fdcode">
								<param name=CBDataColumns		value="FDCODE,FDNAME">
								<param name=SearchColumn		value="FDNAME">
								<param name=Sort						value=false>
								<param name=Enable          value=false>
  							<param name=ListExprFormat	value="FDNAME^0^160">
								<param name=BindColumn			value="FDCODE">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td>
						<td class="tab14" width="100px" bgcolor="#eeeeee"><nobr>사&nbsp;업&nbsp;장</nobr></td>
						<td class="tab18" width="100px"><comment id="__NSID__">
							<object  id=gclx_cocode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:1px;font-size:12px;width:90px;height:200px;">
								<param name=CBData					value="02^서울,01^고성,03^양양">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
								<param name=Enable          value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab14" width="100px" bgcolor="#eeeeee"><nobr>계산서접수번호</nobr></td>
						<td class="tab31" width="89px"><comment id="__NSID__">
							<object  id=gcem_staxnbr class="txtbox" style="position:relative;left:5px;top:1px;width:75px;height:20px;"  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F onKeyDown="if(event.keyCode==13) ln_Query('1')">
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=True>
								<param name=ClipMode			value=true>
								<param name=Format	      value="######-####">
								<param name=MaxLength     value=10>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Enable				value=true>
							</object></comment><script>__ws__(__NSID__);</script> 
							<comment id="__NSID__"><object  id=gcem_taxnbr class="txtbox" style="position:relative;left:5px;top:1px;width:10px;height:20px;"  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F>
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=True>
								<param name=ClipMode			value=true>
								<param name=Format	      value="#######-####">
								<param name=MaxLength     value=10>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=visible				value=false>
								<param name=Enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script> 
						</td>
					</tr>
					<tr> 
						<td class="tab33" width="100px" bgcolor="#eeeeee"><nobr>회계구분</nobr></td>
						<td class="tab19" width="149px;"><comment id="__NSID__">
							<object id=gclx_worktype classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:1px;font-size:12px;width:90px;height:200px;">
								<param name=ComboDataID			value="gcds_worktype">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=Enable      value="false">
								<param name=ListExprFormat	value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>접수일자</nobr></td>
						<td class="tab19" width="189px"><comment id="__NSID__">
							<object  id=gcem_taxdat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
								style="position:relative;left:5px;top:2px;width:70px;height:20px;" class="txtbox">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								<param name=Enable				value="true">
							</object></comment><script>__ws__(__NSID__);</script> 
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_GetCallCalendar('gcem_taxdat', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">

							<comment id="__NSID__">
							<object  id=gcem_taxmm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
								style="position:relative;left:5px;top:2px;width:30px;height:20px;" class="txtbox">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<!-- <param name=Format	      value="YY"> -->
								<param name=PromptChar	  value="_">
								<param name=Enable				value="true">
								<param name=Visible			  value="false">
							</object></comment><script>__ws__(__NSID__);</script> 

							<comment id="__NSID__">
							<object  id=gcem_taxdd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
								style="position:relative;left:5px;top:2px;width:30px;height:20px;" class="txtbox">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<!-- <param name=Format	      value="YY"> -->
								<param name=PromptChar	  value="_">
								<param name=Enable				value="false">
								<param name=Visible			  value="false">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>담당부서</nobr></td>
						<td class="tab22" width="189px"><comment id="__NSID__">
							<object  id=gclx_dept classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:160px;height:150px;">
								<param name=ComboDataID			value="gcds_dept">
								<param name=CBDataColumns		value="DEPTCD,DEPTNM">
								<param name=SearchColumn		value="DEPTNM">
								<param name=Sort						value=false>
								<param name=enable					value="false">
								<param name=ListExprFormat	value="DEPTNM^0^160">
								<param name=BindColumn			value="DEPTCD">
								<param name=Enable					value="false">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td>
					</tr>
					<tr> 
						<td class="tab33" width="100px" bgcolor="#eeeeee"><nobr>귀속구분</nobr></td>
						<td class="tab19" width="149px;"><comment id="__NSID__">
							<object  id=gclx_taxdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:0px;font-size:12px;width:160px;height:200px;">
								<param name=ComboDataID			value="gcds_taxdiv">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDNAM^0^160">
								<param name=BindColumn			value="CDCODE">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>과세구분</nobr></td><!-- =부가세종류 -->
						<td class="tab19" width="189px"><comment id="__NSID__">
							<object  id=gclx_taxknd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:90px;height:110px;">
								<param name=ComboDataID			value="gcds_taxknd">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>담&nbsp;당&nbsp;자</nobr></td>
						<td class="tab22" width="189px"><comment id="__NSID__">
							<object  id=gclx_empno classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:160px;height:110px;">
								<param name=ComboDataID			value="gcds_empno">
								<param name=CBDataColumns		value="EMPNO,EMPNMK">
								<param name=SearchColumn		value="EMPNMK">
								<param name=Sort						value=false>
								<param name=Enable					value="true">
								<param name=ListExprFormat	value="EMPNMK^0^160">
								<param name=BindColumn			value="EMPNO">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td>
					</tr>
					<tr> 
						<td class="tab33" width="100px" bgcolor="#eeeeee"><nobr>거&nbsp;래&nbsp;처</nobr></td>
						<td class="tab19" width="400px" colspan="3"><nobr><comment id="__NSID__">
							<object  id=gcem_vendcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:90px">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="#############">
								<param name=PromptChar	value="_">
								<param name=Enable			value="false">
							</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
							<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-2px;cursor:hand"	 onclick="ln_Popup('A')"><input id=txt_fdcodenm type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:230px;" readOnly>
							<comment id="__NSID__"><object  id=gcem_vendid1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:85px;">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="###-##-#####">
								<param name=PromptChar	value="_">
								<param name=Enable			value="false">
							</object></comment><script>__ws__(__NSID__);</script></nobr>
						</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>작성일자</nobr></td>
						<td class="tab22" width="189px"><nobr><comment id="__NSID__">
							<object  id=gcem_wrdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
								style="position:relative;left:5px;top:2px;width:70px;height:20px;" class="txtbox">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								<param name=Enable				value="false">
							</object></comment><script>__ws__(__NSID__);</script></nobr>
						</td>
					</tr>

          <!-- 매입쪽추가 2009.07.08.JYS -->
          <tr> 
						<td class="tab33" width="100px" bgcolor="#eeeeee"><nobr>거래처담당정보</nobr></td>
						<td class="tab19" width="149px" ><nobr><comment id="__NSID__">
						  <!-- 담당자명 -->
							<object  id=gcem_empnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:5px;top:2px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>&nbsp;&nbsp;
							<!-- <font size="2" color="" style="position:relative;top:-3px">부서</font> -->
              <!-- 담당자 부서명 130px->1 -->
							<object  id=gcem_deptnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:1px;height:20px;position:relative;left:5px;top:2px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
								<param name=Visible       value=false>
							</object>
							<!-- <font size="2" color="" style="position:relative;top:-3px">H.P</font> -->
              <!-- 핸드폰번호 85px->1 -->
							<object  id=gcem_hpno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:1px;height:20px;position:relative;left:3px;top:2px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
								<param name=Visible       value=false>
							</object>
							<!-- <font size="2" color="" style="position:relative;top:-3px">Tel</font> -->
              <!-- 전화번호 80px->1 -->
							<object  id=gcem_telno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:1px;height:20px;position:relative;left:3px;top:2px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
								<param name=Visible       value=false>
							</object>&nbsp;

							<!-- <font size="2" color="" style="position:relative;top:-3px">거래처 Email</font> -->
              <!-- Email -->
							<!--  <object  id=gcem_email classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:167px;height:20px;position:relative;left:7px;top:2px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
								<param name=ReadOnly      value=true> 
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>&nbsp; -->

							<object  id=gcem_seq classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:1px;height:20px;">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
							  <param name=Visible       value=false>
							</object>&nbsp;
							</comment><script>__ws__(__NSID__);</script> </nobr>
						</td> 

						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>거래처 Email</nobr></td><!-- =거래처 Email -->
						<td class="tab19" width="189px"><comment id="__NSID__">
							<object  id=gcem_email classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:172px;height:20px;position:relative;left:5px;top:0px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
								<param name=ReadOnly      value=true> 
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
							</comment><script>__ws__(__NSID__);</script> 
						</td>
            
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>전자발행구분</nobr></td>		
						<td class="tab22" width="189px"><nobr><comment id="__NSID__">
              			     <INPUT type="radio" id=rdo_gubun1_1 value="1" onclick="ln_Rdo_Chk('1')">전자 발행
							 <INPUT type="radio" id=rdo_gubun1_2 value="2" onclick="ln_Rdo_Chk('2')"  >수기 발행
						  <!-- <object id=gcrd_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0	style="height:20px;width:170px;position:relative;left:7px;">
								<param name=Cols	  value="2">
								<param name=Format	value="1^전자 발행, 2^일반 발행">
							</object> -->
							</comment><script>__ws__(__NSID__);</script></nobr>
						</td>
					</tr>

					<tr> 
						<td class="tab33" width="100px" bgcolor="#eeeeee"><nobr>적&nbsp;&nbsp;&nbsp;&nbsp;요</nobr></td>
						<td class="tab19" width="400px" colspan="3"><nobr><comment id="__NSID__">
							<object  id=gcem_remark classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:461px;height:20px;position:relative;left:5px;top:0px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
							</object></comment><script>__ws__(__NSID__);</script> </nobr>
						</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>출력횟수</nobr></td>
						<td class="tab22" width="189px"><comment id="__NSID__">
							<object  id=gcem_taxcnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
								style="position:relative;left:5px;top:0px;width:25px;height:20px;" class="txtbox">
								<param name=Text				value="">
								<param name=Alignment		value=2>
								<param name=Border			value=true>
								<param name=ClipMode		value=true>
								<param name=Numeric			value=true>
								<param name=Format			value="000">
								<param name=PromptChar	value="_">
								<param name=Enable			value="false">
							</object>
							&nbsp;&nbsp;&nbsp;&nbsp;
								<object id=gclx_status  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:1px;width:100px;">
								<param name=CBData			    value="A^매입저장,V^역발행요청,I^수신미승인,C^수신승인,M^발행취소요청(공급받는자),N^발행취소요청(공급자),R^수신거부,O^취소완료,T^역발행거부,W^역발행요청 취소">
								<param name=CBDataColumns	  value="CODE,NAME">
								<param name=SearchColumn	  value=NAME>
								<param name=Sort			      value=false>
                                <param name=Enable 	        value=false>
								<param name=ListExprFormat	Value="CODE^0^30,NAME^0^100">								
								<param name=BindColumn		  value="CODE">
							</object>
							</comment><script>__ws__(__NSID__);</script> 
						</td>
					</tr>
					<tr> 
						<td class="tab33" width="100px" bgcolor="#eeeeee"><nobr>상대계정과목</nobr></td>
						<td class="tab19" width="400px" colspan="3"> <nobr><comment id="__NSID__">
							<object id=gcem_atcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:50px">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="#######">
								<param name=PromptChar	value="_">
								<param name=Enable			value="false">
							</object></comment><script>__ws__(__NSID__);</script> 
							<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:7px;cursor:hand"	 onclick="ln_Popup2('A')">
							<input id=txt_atkornam type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:190px;">
							<input id=txt_atdecr type="text" class="txt11" style="position:relative;left:5px;width:70px;display:none"></nobr> 
						<!-- 	<comment id="__NSID__"><object  id=gclx_actcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:1px;font-size:12px;width:170px;height:200px;">
								<param name=ComboDataID			value="gcds_actcode1">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDNAM^0^170">
								<param name=BindColumn			value="CDCODE"> 
							</object></comment><script>__ws__(__NSID__);</script>-->
						</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>최종출력일</nobr></td>
						<td class="tab22" width="149px"><nobr><comment id="__NSID__">
							<object  id=gcem_lastprt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
								style="position:relative;left:5px;top:1px;width:70px;height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="false">
							</object></comment><script>__ws__(__NSID__);</script></nobr>
						</td>
					</tr>
					<tr> 
						<td class="tab33" width="100px" bgcolor="#eeeeee"><nobr>발행여부</nobr></td>
						<td class="tab19" width="189px;" >
						<comment id="__NSID__">

							<object  id=gclx_taxprtyn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:1px;font-size:12px;width:90px;height:200px;">
								<param name=CBData					value="Y^발행,N^미발행">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=Enable              value="false">
								<param name=ListExprFormat	    value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>매입구분</nobr></td>
						<td class="tab19" width="100px"><comment id="__NSID__">
							<object  id=gclx_buy classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:1px;font-size:12px;width:90px;height:200px;">
								<param name=CBData					value="Y^정발행매입,N^역발행매입">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>전표접수번호</nobr></td>
						<td class="tab22" width="189px"><comment id="__NSID__">
							<object  id=gcem_fsdat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:2px;width:70px">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=ClipMode		value=true>
								<param name=Numeric			value=false>
								<param name=Format			value="#########">
								<param name=PromptChar	value="_">
								<param name=Enable			value="false">
							</object></comment><script>__ws__(__NSID__);</script> &nbsp;-
							<comment id="__NSID__"><object  id=gcem_fsnbr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:3px;top:2px;width:45px">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=ClipMode		value=true>
								<param name=Numeric			value=false>
								<param name=Format			value="######">
								<param name=PromptChar	value="_">
								<param name=Enable			value="false">
							</object></comment><script>__ws__(__NSID__);</script> 
							<comment id="__NSID__"><object  id=gcem_fsstat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:2px;width:15px">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=ClipMode		value=true>
								<param name=Numeric			value=false>
								<param name=Format			value="#">
								<param name=PromptChar	value="_">
								<param name=visible			value="false">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr> 
						<td class="tab41" width="100px" bgcolor="#eeeeee"><nobr>원가</nobr></td>
						<td width="149px;" colspan =5>
							<nobr>
							<input id="txt_costcd" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6"  readOnly=true>	
							<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="원가코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Costcd_Popup('01');">				
							<input id="txt_costnm" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >			
							&nbsp;<font color="blue" > * 원가 미존재시 [판매관리비 등]으로 입력하세요.</font>
							</nobr>
						</td>
						
					</tr> 
				</table>
			</td>
		</tr>
	</table>

	<table border="0" cellpadding="0" cellspacing="0" style="position:relative;top:5px;left:8px;">
		<tr>
			<td>
				<comment id="__NSID__"><object  id=gcte_disp2 classid=clsid:ED382953-E907-11D3-B694-006097AD7252 
					style="width:600px;height:20px">
						<PARAM NAME="BackColor"					VALUE="#cccccc">
						<PARAM NAME="titleHeight"				VALUE="20px">
						<PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
						<PARAM NAME="Format"						VALUE="
							<T>divid=layer1  title='세금계산서 세부내역'</T>									
						">
				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
		</tr>
	</table>

<!---------[TAB 1] 세금계산서세부내역 매입----------->
<div id="layer1" style="position:relative;top:5px;left:8px;width:867px;visibility:hidden;border:1 solid #708090">
  <table cellpadding=0 cellspacing=0 border=0>
		<tr>
			<td height="25px" align="right" valign="bottom">
				<img name="btn_taxselect"	    src="../../Common/img/btn/com_b_taxselect.gif"   style="position:relative;right:-118px;top:-287px;cursor:hand" onclick="ln_TaxQuery()">
				<!-- <img name="btn_taxissue"	src="../../Common/img/btn/com_b_taxissue.gif"	 style="position:relative;right:-118px;top:-256px;cursor:hand" onclick="ln_TaxIssue()"> -->
				<img name="btn_del_1"			src="../../Common/img/btn/com_b_delete.gif"		 style="position:relative;right:-118px;top:-287px;cursor:hand" onclick="ln_Delete('1')">
				<img name="btn_add_1"			src="../../Common/img/btn/com_b_insert.gif"		 style="position:relative;right:-118px;top:-287px;cursor:hand" onclick="ln_Add('1')">
				<img name="btn_save_1"		    src="../../Common/img/btn/com_b_save.gif"		 style="position:relative;right:-118px;top:-287px;cursor:hand" onclick="ln_Save('1')">
				<img name="btn_query_1"		    src="../../Common/img/btn/com_b_query.gif"		 style="position:relative;right:-118px;top:-287px;cursor:hand" onclick="ln_Query('1')">
				<img name="btn_del_2"			src="../../Common/img/btn/com_b_rowdel.gif"		 style="position:relative;right:2px;top:0px;cursor:hand" onclick="ln_Delete('2')">
				<img name="btn_add_2"			src="../../Common/img/btn/com_b_rowadd.gif"		 style="position:relative;right:2px;top:0px;cursor:hand" onclick="ln_Add('2')">
		  </td>
			<td width="1px;"></td>
		</tr> 
		<tr>
		  <td style="width:865;border:0 solid #708090;border-top-width:1px" colspan="2">
				<comment id="__NSID__"><object  id=gcgd_data2 style="width:865px;height:140px;border:0 solid #777777" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49>
					<PARAM NAME="DataID"			VALUE="gcds_data2">
					<PARAM NAME="Editable"		VALUE="true">
					<PARAM NAME="viewSummary" VALUE="1">
					<PARAM NAME="ColSizing"		VALUE="true">
					<PARAM NAME="SortView"		VALUE="left">
					<PARAM NAME="BorderStyle" VALUE="0">
					<param name="Fillarea"		VALUE="true">
					<PARAM NAME="IndWidth"    VALUE="0">
					<param name=AllShowEdit  value="true">
          			<param name="ColSelect"		value=false>
					<PARAM NAME="Format"			VALUE="
					<C>ID=TAXMM			Name='월'			HeadAlign=Center HeadBgColor=#B9D4DC Width=20  align=center SumText=''		 SumBgColor=#C3D0DB </C>
					<C>ID=TAXDT			Name='일'			HeadAlign=Center HeadBgColor=#B9D4DC Width=20  align=center SumText=''		 SumBgColor=#C3D0DB </C>
					<C>ID=TAXPDTNAM     Name='품목명'		    HeadAlign=Center HeadBgColor=#B9D4DC Width=200 align=LEFT	SumText='합계'    SumBgColor=#C3D0DB </C>
					<C>ID=TAXSTD		Name='규격'			HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=LEFT	SumText=''		 SumBgColor=#C3D0DB </C>
					<C>ID=TAXQTY		Name='수량'			HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=right	SumText=''		 SumBgColor=#C3D0DB </C> 
					<C>ID=TAXPRIC       Name='단가'			HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=right	SumText=''		 SumBgColor=#C3D0DB </C> 
					<C>ID=TAXSUM		Name='공급가액'	    HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=right	SumText=@sum	 SumBgColor=#C3D0DB</C>
					<C>ID=TAXVATAMT     Name='부가세액'	    HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=right	SumText=@sum	 SumBgColor=#C3D0DB</C>
					<C>ID=TAXTOT2	    Name='합계'			HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=right	SumText=@sum	 SumBgColor=#C3D0DB </C>
					<C>ID=BIGO			Name='비고'			HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=LEFT	SumText=''		 SumBgColor=#C3D0DB</C>
					<C>ID=EMPNO			Name='EMPNO'		HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center SumText=''		 SumBgColor=#C3D0DB show=false</C>
					">
				</object></comment><script>__ws__(__NSID__);</script> 
				<fieldset style="width:865;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt2 style="position:relative;top:4px;"></font>
				</fieldset><!-- Value={(TAXSUM+TAXVATAMT)} -->
			</td>
		</tr>
	</table>
</div>

	<table cellpadding=0 cellspacing=0 border=0 style="position:relative;top:10px;left:8px;width:867px;border:1 solid #708090">
		<tr>
			<td class="tab11" bgcolor="#eeeeee">신용카드번호</td>
			<td class="tab19" colspan=3><comment id="__NSID__">
				<object  id=gcem_canbr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:5px;top:3px">		
					<param name=Text					value="">
					<param name=Alignment     value=0>
					<param name=Border        value=true>
					<param name=Numeric       value=false>
					<param name=Format        value="####-####-####-####">
					<param name=PromptChar    value="_">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<param name=ReadOnly      value=true>
					<param name=ReadOnlyBackColor   value="#CCFFCC">
				</object></comment><script>__ws__(__NSID__);</script> 
				<img name="btn_find3" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:7px;cursor:hand"	onclick="ln_CardPopup()">
			</td>
			<!-- 2009.12.09 jys 막음
			<td class="tab11" bgcolor="#eeeeee" >신용카드가맹점</td>
			<td width="400px" class="tab22"><comment id="__NSID__">
				<object  id=gcem_cardvendcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:86px;height:20px;position:relative;left:5px;top:2px">		
					<param name=Text					value="">
					<param name=Alignment     value=0>
					<param name=Border        value=true>
					<param name=Numeric       value=false>
					<param name=Format        value="#############">
					<param name=PromptChar    value="_">
					<param name=maxlength     value="13">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> 
				<img name="btn_find4" src="../../common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:8px;cursor:hand"	 onclick="ln_VenderPopup()">
				<input id="txt_cardvendnm" type="text" class="txtbox"  style= "width:250px;height:20px;position:relative;left:6px;top:-2px">
			</td> -->
		</tr>
			<tr>
			<td class="tab12" bgcolor="#eeeeee">고정자산</td>
			<td class="tab23" colspan="3">
				<input id=txt_fixprop type="text" class="txt11" style="position:relative;top:0px;left:5px;width:120px;">
				<img name="btn_find5" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:7px;cursor:hand"	 onclick="ln_PropPopup()">
				<input id=txt_fixpropnm type="text" class="txt11" style="position:relative;top:0px;left:5px;width:190px;">

				<input id=txt_fixpropnm_cnt type="text" class="txt11" style="position:relative;top:0px;left:5px;width:50px;">
			</td>
	<!-- 		<td class="tab12" bgcolor="#eeeeee">고정자산명</td>
			<td>
				<input id=txt_fixpropnm type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:190px;">
				<img name="btn_find6" src="../../common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:7px;cursor:hand"	 onclick="ln_PropPopup2()">
			</td> -->
		</tr>
	</table>
	<table cellpadding=0 cellspacing=0 border=1 style="position:relative;left:8px;top:13px;border:1 solid #708090;display:none">
		<tr> 
			<td class="tab12" width="100px" bgcolor="#eeeeee"><nobr>공급가액</nobr></td>
			<td class="tab23" width="149px;"><comment id="__NSID__">
				<object  id=gcem_taxsum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;width:90px">
					<param name=Text				value="">
					<param name=Alignment		value=2>
					<param name=Border			value=true>
					<param name=ClipMode		value=true>
					<param name=Numeric			value=true>
					<param name=Format			value="000,000,000">
					<param name=PromptChar	value="_">
					<param name=Enable			value="false">
				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
			<td class="tab12" width="100px" bgcolor="#eeeeee"><nobr>부가세액</nobr></td>
			<td class="tab23" width="189px" colspan=2><comment id="__NSID__">
				<object  id=gcem_taxvatamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;width:110px">
					<param name=Text				value="">
					<param name=Alignment		value=2>
					<param name=Border			value=true>
					<param name=ClipMode		value=true>
					<param name=Numeric			value=true>
					<param name=Format			value="000,000,000">
					<param name=PromptChar	value="_">
					<param name=Enable			value=false>
				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
			<td class="tab12" width="100px" bgcolor="#eeeeee"><nobr>합계금액</nobr></td>
			<td width="189px" colspan=2><comment id="__NSID__">
				<object  id=gcem_taxtot classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;width:110px">
					<param name=Text				value="">
					<param name=Alignment		value=2>
					<param name=Border			value=true>
					<param name=ClipMode		value=true>
					<param name=Numeric			value=true>
					<param name=Format			value="000,000,000">
					<param name=PromptChar	value="_">
					<param name=Enable			value=false>
				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
		</tr>
	</table>
</div>

<!-- 매출 ===========================================================================================================-->
<fieldset id=field2 style="position:absolute;top:160px;left:18px;height:513px;width:880px;bacground-color:#708090"></fieldset>
<table id="div_disp2" border="0" cellpadding=0 cellspacing=0 style="position:relative;left:0px;display:none">
<tr>
<td>
<table border="0" cellpadding=0 cellspacing=0 style="position:relative;left:0px;">
	<tr>
		<td>
			<table width="867px" border="0" cellpadding=0 cellspacing=0 style="position:relative;left:8px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;">
					<tr> 
						<td class="tab37" width="100px" bgcolor="#eeeeee"><nobr>지점코드</nobr></td>
						<td class="tab18" width="189px;"><comment id="__NSID__">
							<object  id=gclx_fdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:160px;height:110px;">
								<param name=ComboDataID			value="gcds_fdcode2">
								<param name=CBDataColumns		value="FDCODE,FDNAME">
								<param name=SearchColumn		value="FDNAME">
								<param name=Sort						value=false>
								<param name=Enable					value=false>
								<param name=ListExprFormat	value="FDNAME^0^160">
								<param name=BindColumn			value="FDCODE">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td>
						<td class="tab14" width="100px" bgcolor="#eeeeee"><nobr>사&nbsp;업&nbsp;장</nobr></td>
						<td class="tab18" width="180px"><comment id="__NSID__"> 
							<object  id=gclx_cocode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:1px;font-size:12px;width:60px;height:200px;">
								<param name=CBData					value="02^서울,01^고성,03^양양">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDNAM^0^60">
								<param name=BindColumn			value="CDCODE">
								<param name=Enable          value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;&nbsp;
              <span id=sp1 style="display:none;">
							 <font color="" style="position:relative;top:-5px;" >종사업장</font>&nbsp;
							 <comment id="__NSID__"> 
							 <object  id=gcem_s_bizplace classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:35px;height:20px;position:relative;left:5px;top:2px">		
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=GeneralEdit   value=true>
									<param name=Language			value=1>
									<param name=ReadOnly      value=true>
									<param name=ReadOnlyBackColor   value="#CCFFCC">
								</object>
								</comment><script>__ws__(__NSID__);</script>
							</span>
						</td>
						<td class="tab14" width="100px" bgcolor="#eeeeee">계산서번호</td>
						<td class="tab31" width="89px"><comment id="__NSID__">
							<object  id=gcem_staxnbr2 class="txtbox" style="position:relative;left:5px;top:1px;width:75px;height:20px;"  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F onKeyDown="if(event.keyCode==13) ln_Query2('1')">
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=True>
								<param name=ClipMode			value=true>
								<param name=Format	      value="######-####">
								<param name=MaxLength     value=10>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Enable				value=true>
							</object></comment><script>__ws__(__NSID__);</script> 
							<comment id="__NSID__"><object  id=gcem_taxnbr2 class="txtbox" style="position:relative;left:5px;top:1px;width:10px;height:20px;"  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F>
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=True>
								<param name=ClipMode			value=true>
								<param name=Format	      value="#######-####">
								<param name=MaxLength     value=10>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=visible				value=false>
								<param name=Enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script> 
						</td>
					</tr>
					<tr> 
						<td class="tab33" width="100px" bgcolor="#eeeeee"><nobr>회계구분</nobr></td>
						<td class="tab19" width="149px;"><comment id="__NSID__">
							<object  id=gclx_worktype2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:1px;font-size:12px;width:90px;height:200px;">
								<param name=ComboDataID			value="gcds_worktype">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=Enable      value="false">
								<param name=ListExprFormat	value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>계산서일자</nobr></td>
						<td class="tab19" width="189px"><comment id="__NSID__">
							<object  id=gcem_taxdat2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
								style="position:relative;left:5px;top:2px;width:70px;height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
							</object></comment><script>__ws__(__NSID__);</script> 
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_GetCallCalendar('gcem_taxdat2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">

					<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_taxdat', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;"> -->

							<comment id="__NSID__">
							<object  id=gcem_taxmm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
								style="position:relative;left:5px;top:2px;width:30px;height:20px;" class="txtbox">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<!-- <param name=Format	      value="YY"> -->
								<param name=PromptChar	  value="_">
								<param name=Enable				value="true">
								<param name=Visible			  value="false">
							</object></comment><script>__ws__(__NSID__);</script> 

							<comment id="__NSID__">
							<object  id=gcem_taxdd2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
								style="position:relative;left:5px;top:2px;width:30px;height:20px;" class="txtbox">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<!-- <param name=Format	      value="YY"> -->
								<param name=PromptChar	  value="_">
								<param name=Enable				value="false">
								<param name=Visible			  value="false">
							</object></comment><script>__ws__(__NSID__);</script> 

						</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>담당부서</nobr></td>
						<td class="tab22" width="189px"><comment id="__NSID__">
							<object  id=gclx_dept2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:160px;height:150px;">
								<param name=ComboDataID			value="gcds_dept2">
								<param name=CBDataColumns		value="DEPTCD,DEPTNM">
								<param name=SearchColumn		value="DEPTNM">
								<param name=Sort						value=false>
								<param name=enable					value="false">
								<param name=ListExprFormat	value="DEPTNM^0^160">
								<param name=BindColumn			value="DEPTCD">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td>
					</tr>
					<tr> 
						<td class="tab33" width="100px" bgcolor="#eeeeee"><nobr>귀속구분</nobr></td>
						<td class="tab19" width="149px;"><comment id="__NSID__">
							<object  id=gclx_taxdiv2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:0px;font-size:12px;width:160px;height:200px;">
								<param name=ComboDataID			value="gcds_taxdiv2">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDNAM^0^160">
								<param name=BindColumn			value="CDCODE">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>과세구분</nobr></td><!-- =부가세종류 -->
						<td class="tab19" width="189px"><comment id="__NSID__">
							<object  id=gclx_taxknd2  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:90px;height:150px;">
								<param name=ComboDataID			value="gcds_taxknd2">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn			value="CDNAM">
								<param name=Sort							value="false">
								<param name=ListExprFormat			value="CDNAM^0^90">
								<param name=BindColumn				value="CDCODE">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>담&nbsp;당&nbsp;자</nobr></td>
						<td class="tab22" width="189px"><comment id="__NSID__">
							<object  id=gclx_empno2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:160px;height:110px;">
								<param name=ComboDataID			value="gcds_empno">
								<param name=CBDataColumns		value="EMPNO,EMPNMK">
								<param name=SearchColumn		value="EMPNMK">
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="EMPNMK^0^160">
								<param name=BindColumn			value="EMPNO">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td>
					</tr>
					<tr> 
						<td class="tab33" width="100px" bgcolor="#eeeeee"><nobr>거&nbsp;래&nbsp;처</nobr></td>
						<td class="tab19" width="400px;" colspan="3"><nobr><comment id="__NSID__">
							<object  id=gcem_vendcd2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:90px">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="#############">
								<param name=PromptChar	value="_">
								<!-- <param name=Enable			value="false"> -->
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
							<img name="btn_find2" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-2px;cursor:hand"	 onclick="ln_Popup('B')">
							<input id=txt_fdcodenm2 type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:210px;" readOnly>
							<comment id="__NSID__"><object  id=gcem_vendid2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:105px;">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="###-##-#####">
								<param name=PromptChar	value="_">
								<!-- <param name=Enable			value="false"> -->
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object></comment><script>__ws__(__NSID__);</script></nobr>
						</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>작성일자</nobr></td>
						<td class="tab22" width="189px"><nobr><comment id="__NSID__">
							<object  id=gcem_wrdt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
								style="position:relative;left:5px;top:2px;width:70px;height:20px;" class="txtbox">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								<!-- <param name=Enable				value="false"> -->
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
          <!--2009.06.16 jys 매출추가 -->
         <tr> 
						<td class="tab33" width="100px" bgcolor="#eeeeee"><nobr>거래처담당정보</nobr></td>
						<td class="tab19" width="189px" ><nobr><comment id="__NSID__">
						  <!-- 담당자명 -->
							<object  id=gcem_empnm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:5px;top:2px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>&nbsp;
							<!-- <font size="2" color="" style="position:relative;top:-3px">부서</font> -->
              <!-- 담당자 부서명 -->
							<object  id=gcem_deptnm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:1px;height:20px;position:relative;left:5px;top:2px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
								<param name=Visible       value=false>
							</object>&nbsp;
						<!-- 	<font size="2" color="" style="position:relative;top:-3px">H.P</font> -->
              <!-- 핸드폰번호 -->
							<object  id=gcem_hpno2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:1px;height:20px;position:relative;left:3px;top:2px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
								<param name=Visible       value=false>
							</object>&nbsp;
							<!-- <font size="2" color="" style="position:relative;top:-3px">Tel</font> -->
              <!-- 전화번호 -->
							<object  id=gcem_telno2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:1px;height:20px;position:relative;left:3px;top:2px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
								<param name=Visible       value=false>
							</object>&nbsp;	
							<!-- <font size="2" color="" style="position:relative;top:-3px">Email</font> -->
              <!-- Email -->
							<!--  <object  id=gcem_email2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:162px;height:20px;position:relative;left:7px;top:2px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
								<param name=ReadOnly      value=true> 
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>&nbsp; -->

							<object  id=gcem_seq2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:1px;height:20px;">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
							  <param name=Visible       value=false>
							</object>&nbsp;
							</comment><script>__ws__(__NSID__);</script> </nobr>
						</td>
						
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>거래처 Email</nobr></td><!-- =거래처 Email -->
						<td class="tab19" width="189px"><comment id="__NSID__">
							<object  id=gcem_email2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:172px;height:20px;position:relative;left:5px;top:0px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
								<param name=ReadOnly      value=true> 
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
							</comment><script>__ws__(__NSID__);</script> 
						</td>

						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>전자발행구분</nobr></td>
						<td class="tab22" width="189px"><nobr><comment id="__NSID__">
						  	<INPUT type="radio" id=rdo_gubun2_1 value="1" onclick="ln_Rdo_Chk('3')" disabled>전자 발행
							<INPUT type="radio" id=rdo_gubun2_2 value="2" onclick="ln_Rdo_Chk('4')" disabled>수기 발행
						  <!-- <object id=gcrd_gubun2 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0	style="height:20px;width:170px;position:relative;left:7px;">
								<param name=Cols	  value="2">
								<param name=Format	value="1^전자 발행, 2^일반 발행">
							</object> -->
							</comment><script>__ws__(__NSID__);</script></nobr>
						</td>
					</tr>
           <!-- 여기까지 -->
					 <tr> 
						<td class="tab33" width="100px" bgcolor="#eeeeee"><nobr>적&nbsp;&nbsp;&nbsp;&nbsp;요</nobr></td>
						<td class="tab19" width="400px" colspan="3"><nobr><comment id="__NSID__">
							<object  id=gcem_remark2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:461px;height:20px;position:relative;left:5px;top:0px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
							</object></comment><script>__ws__(__NSID__);</script> </nobr>
						</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>출력횟수</nobr></td>
						<td class="tab22" width="189px"><comment id="__NSID__">
							<object  id=gcem_taxcnt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
								style="position:relative;left:5px;top:0px;width:25px;height:20px;" class="txtbox">
								<param name=Text				value="">
								<param name=Alignment		value=2>
								<param name=Border			value=true>
								<param name=ClipMode		value=true>
								<param name=Numeric			value=true>
								<param name=Format			value="000">
								<param name=PromptChar	value="_">
								<param name=Enable			value="false">
							</object>
							 &nbsp;&nbsp;&nbsp;&nbsp;
							<object id=gclx_status2      classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:1px;width:100px;">
								<param name=CBData			  value="S^매출저장,I^수신미승인,C^수신승인,R^수신거부,O^취소완료,M^발행취소요청(공급받는자),N^발행취소요청(공급자),V^역발행요청,T^역발행거부,W^역발행요청 취소">
								<param name=CBDataColumns	value="CODE,NAME">
								<param name=SearchColumn	value=NAME>
								<param name=Sort			      value=false>
                                <param name=Enable 	        value=false>
								<param name=ListExprFormat	Value="CODE^0^30,NAME^0^100">								
								<param name=BindColumn		  value="CODE">
							</object>
							</comment><script>__ws__(__NSID__);</script> 
						</td>
					</tr>

					<tr> 
						<td class="tab33" width="100px" bgcolor="#eeeeee"><nobr>상대계정과목</nobr></td>
						<td class="tab19" width="400px" colspan="3"><nobr><comment id="__NSID__">
							<object  id=gcem_atcode2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:50px">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="#######">
								<param name=PromptChar	value="_">
								<param name=Enable			value="false">
							</object></comment><script>__ws__(__NSID__);</script> 
							<img name="btn_find_2" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:7px;cursor:hand"	 onclick="ln_Popup2('B')">
							<input id=txt_atkornam_2 type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:190px;">
							<input id=txt_atdecr_2 type="text" class="txt11" style="position:relative;left:5px;width:70px;display:none"></nobr>
						</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>최종출력일</nobr></td>
						<td class="tab22" width="149px"><nobr><comment id="__NSID__">
							<object  id=gcem_lastprt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
								style="position:relative;left:5px;top:1px;width:70px;height:20px;" class="txtbox">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								<param name=Enable				value="true">
							</object></comment><script>__ws__(__NSID__);</script> </nobr>
						</td>
					</tr>
					<tr> 
						<td class="tab33" width="100px" bgcolor="#eeeeee"><nobr>발행여부</nobr></td>
						<td class="tab19" width="149px;"><comment id="__NSID__">
							<object  id=gclx_taxprtyn2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:1px;font-size:12px;width:90px;height:200px;">
								<param name=CBData					value="Y^발행,N^미발행">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=Enable      value="false">
								<param name=ListExprFormat	value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>발행구분</nobr></td>
						<td class="tab19" width="189px"><comment id="__NSID__">
							<object  id=gclx_taxtype2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:5px;top:1px;font-size:12px;width:90px;">
								<param name=CBData					value="Y^영수,N^청구">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>전표접수번호</nobr></td>
						<td class="tab22" width="149px"><comment id="__NSID__">
							<object  id=gcem_fsdat2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:2px;width:70px">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=ClipMode		value=true>
								<param name=Numeric			value=false>
								<param name=Format			value="#########">
								<param name=PromptChar	value="_">
								<param name=Enable			value="false">
							</object></comment><script>__ws__(__NSID__);</script> &nbsp;-
							<comment id="__NSID__"><object  id=gcem_fsnbr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:3px;top:2px;width:45px">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=ClipMode		value=true>
								<param name=Numeric			value=false>
								<param name=Format			value="######">
								<param name=PromptChar	value="_">
								<param name=Enable			value="false">
							</object></comment><script>__ws__(__NSID__);</script> 
							<comment id="__NSID__"><object  id=gcem_fsstat2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:2px;width:15px">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=ClipMode		value=true>
								<param name=Numeric			value=false>
								<param name=Format			value="#">
								<param name=PromptChar	value="_">
								<param name=visible			value="false">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>

          <!-- 비고추가 2010.12.01 JYS -->
					<tr> 
						<td class="tab33" width="100px" bgcolor="#eeeeee"><nobr>세금계산서비고</nobr></td>
						<td class="tab19" width="580px" colspan="4"><nobr><comment id="__NSID__">
							<object  id=gcem_remark_b2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:570px;height:20px;position:relative;left:5px;top:0px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
							</object></comment><script>__ws__(__NSID__);</script> </nobr>
						</td>
						<td class="tab22" width="189px;"><nobr>
						  <INPUT id=chk_ext type=checkbox  value='0' style="position:relative;top:0px" onclick="ln_ChkBox2()" > <font color="blue" >외부시스템 매출발행</font>
						<td>
					</tr>
					<tr> 
						<td class="tab41" width="100px" bgcolor="#eeeeee" style="border:1 solid #708090; border-color:blue" ><nobr>원가</nobr></td>
					    <td class="tab23" style="border:1 solid #708090;" colspan=5 ><nobr>
							<nobr>
							<input id="txt_costcd02" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6"  readOnly=true>	
							<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="원가코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Costcd_Popup('02');">				
							<input id="txt_costnm02" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >			
							&nbsp; <font color="blue" >* 원가 미존재시 [판매관리비 등]으로 입력하세요.</font>
							</nobr>
						</td>
						
					</tr>
					
					<!-- 수정세금계산서 추가  
					<tr> 
						<td class="tab41" width="100px" bgcolor="#eeeeee" style="border:1 solid #708090; border-color:blue" ><nobr>수정세금계산서</nobr></td>
						<td class="tab23" width="149px;" style="border:1 solid #708090; " ><nobr>
						  <INPUT id=chk_tax type=checkbox  value='1' style="position:relative;top:-3px"  onclick="ln_ChkBox()"  >
							<comment id="__NSID__">
							<object  id=gclx_amend_code classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:3px;top:2px;font-size:12px;width:150px;height:200px;">
								<param name=CBData					value="^' ',01^기재사항의 착오·오류,02^공급가액 변동,03^환입,04^계약의 해제,05^내국신용장 사후 개설,06^착오에 의한 이중발급">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDNAM^0^153">
								<param name=BindColumn			value="CDCODE">
								<param name=Enable          value="false">
  						</object></comment><script>__ws__(__NSID__);</script>
							</nobr>
						</td>
						<td class="tab12" width="100px" bgcolor="#eeeeee" style="border:1 solid #708090;"><nobr>수정비고</nobr></td>
						<td class="tab23" width="475px" colspan=3 style="border:1 solid #708090;" ><comment id="__NSID__">
							<object  id=gcem_amend_remark classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:460px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
								<param name=ReadOnly      value=true> 
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						
					</tr>-->


					<!-- <tr> 
						<td class="tab41" width="100px" bgcolor="#eeeeee"><nobr>공급가액</nobr></td>
						<td class="tab23" width="149px;">
							<comment id="__NSID__"><object  id=gcem_taxsum2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;width:90px">
								<param name=Text				value="">
								<param name=Alignment		value=2>
								<param name=Border			value=true>
								<param name=ClipMode		value=true>
								<param name=Numeric			value=true>
								<param name=Format			value="000,000,000">
								<param name=PromptChar	value="_">
								<param name=Enable			value="false">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td>
						<td class="tab12" width="100px" bgcolor="#eeeeee"><nobr>부가세액</nobr></td>
						<td class="tab23" width="189px" colspan=2>
							<comment id="__NSID__"><object  id=gcem_taxvatamt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;width:110px">
								<param name=Text				value="">
								<param name=Alignment		value=2>
								<param name=Border			value=true>
								<param name=ClipMode		value=true>
								<param name=Numeric			value=true>
								<param name=Format			value="000,000,000">
								<param name=PromptChar	value="_">
								<param name=Enable			value="false">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td>
						<td class="tab12" width="100px" bgcolor="#eeeeee"><nobr>합계금액</nobr></td>
						<td width="189px" colspan=2>
							<comment id="__NSID__"><object  id=gcem_taxtot2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;width:110px">
								<param name=Text				value="">
								<param name=Alignment		value=2>
								<param name=Border			value=true>
								<param name=ClipMode		value=true>
								<param name=Numeric			value=true>
								<param name=Format			value="000,000,000">
								<param name=PromptChar	value="_">
								<param name=Enable			value="false">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td>
					</tr> -->
				</table>
			</td>
		</tr>
	</table>

	<table border="0" cellpadding="0" cellspacing="0" style="position:relative;top:5px;left:8px;">
		<tr>
			<td>
				<comment id="__NSID__"><object  id=gcte_disp_2 classid=clsid:ED382953-E907-11D3-B694-006097AD7252 
					style="width:600px;height:20px">
						<PARAM NAME="BackColor"					VALUE="#cccccc">
						<PARAM NAME="titleHeight"				VALUE="20px">
						<PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
						<PARAM NAME="Format"						VALUE="
							<T>divid=layer2  title='세금계산서 세부내역'</T>									
						">
				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
		</tr>
	</table>

<!---------[TAB 1] 세금계산서 세부내역 매출----------->
<div id="layer2" style="position:relative;top:5px;left:8px;width:867px;visibility:hidden;border:1 solid #708090">
  <table cellpadding=0 cellspacing=0 border=0>
		<tr>
			<td height="25px" align="right" valign="bottom">
                <span id=sp0 style="display:none;">
					<img name="btn_accprint_2"	src="../../Common/img/btn/com_b_accprint.gif"	 style="position:relative;right:-117px;top:-316px;cursor:hand" onclick="ln_Print()">  
				</span>
				<img name="btn_taxselect_2"	src="../../Common/img/btn/com_b_taxselect.gif" style="position:relative;right:-117px;top:-316px;cursor:hand" onclick="ln_TaxQuery2()">
				<!-- <img name="btn_taxissue_2"	src="../../Common/img/btn/com_b_taxissue.gif"	 style="position:relative;right:-117px;top:-308px;cursor:hand" onclick="ln_TaxIssue2()"> -->
				<img name="btn_del_1_2"			src="../../Common/img/btn/com_b_delete.gif"		 style="position:relative;right:-117px;top:-316px;cursor:hand" onclick="ln_Delete2('1')">
				<img name="btn_add_1_2"			src="../../Common/img/btn/com_b_insert.gif"		 style="position:relative;right:-117px;top:-316px;cursor:hand" onclick="ln_Add2('1')">
				<img name="btn_save_1_2"		src="../../Common/img/btn/com_b_save.gif"			 style="position:relative;right:-117px;top:-316px;cursor:hand" onclick="ln_Save2('1')">
				<img name="btn_query_1_2"		src="../../Common/img/btn/com_b_query.gif"		 style="position:relative;right:-117px;top:-316px;cursor:hand" onclick="ln_Query2('1')">
				<img name="btn_del_2_2"			src="../../Common/img/btn/com_b_rowdel.gif"		 style="position:relative;right:3px;top:0px;cursor:hand" onclick="ln_Delete2('2')">
				<img name="btn_add_2_2"			src="../../Common/img/btn/com_b_rowadd.gif"		 style="position:relative;right:3px;top:0px;cursor:hand" onclick="ln_Add2('2')">
		  </td>
			<td width="1px;"></td>
		</tr> 
		<tr>
		  <td style="width:865;border:0 solid #708090;border-top-width:1px" colspan="2">
				<comment id="__NSID__"><object  id=gcgd_data2_2 style="width:865px;height:120px;border:0 solid #777777" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49>
					<PARAM NAME="DataID"			VALUE="gcds_data2_2">
					<PARAM NAME="Editable"		VALUE="true">
					<PARAM NAME="viewSummary" VALUE="1">
					<PARAM NAME="ColSizing"		VALUE="true">
					<PARAM NAME="SortView"		VALUE="left">
					<PARAM NAME="BorderStyle" VALUE="0">
					<param name="Fillarea"		VALUE="true">
					<PARAM NAME="IndWidth"    VALUE="0">
					<param name=AllShowEdit  value="true">
					<PARAM NAME="Format"			VALUE="
						<C>ID=TAXMM			Name='월'				HeadAlign=Center HeadBgColor=#B9D4DC Width=20  align=center SumText=''		 SumBgColor=#C3D0DB </C>
						<C>ID=TAXDT			Name='일'				HeadAlign=Center HeadBgColor=#B9D4DC Width=20  align=center SumText=''		 SumBgColor=#C3D0DB </C>
						<C>ID=TAXPDTNAM Name='품목명'		HeadAlign=Center HeadBgColor=#B9D4DC Width=200 align=LEFT		SumText='합계' SumBgColor=#C3D0DB </C>
						<C>ID=TAXSTD		Name='규격'			HeadAlign=Center HeadBgColor=#B9D4DC Width=60	 align=LEFT		SumText=''		 SumBgColor=#C3D0DB </C>
						<C>ID=TAXQTY		Name='수량'			HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=right	SumText=''		 SumBgColor=#C3D0DB </C> 
						<C>ID=TAXPRIC   Name='단가'			HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=right	SumText=''		 SumBgColor=#C3D0DB </C> 
						<C>ID=TAXSUM		Name='공급가액'	HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=right	SumText=@sum	 SumBgColor=#C3D0DB</C>
						<C>ID=TAXVATAMT Name='부가세액'	HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=right	SumText=@sum   SumBgColor=#C3D0DB</C>
						<C>ID=TAXTOT2	  Name='합계'			HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=right	SumText=@sum	 SumBgColor=#C3D0DB </C>
						<C>ID=BIGO			Name='비고'			HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=LEFT		SumText=''		 SumBgColor=#C3D0DB</C>
					">
				</object></comment><script>__ws__(__NSID__);</script> 
				<fieldset style="width:865;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt2_2 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
		<tr>
     <td style="width:865;height:20px;border:0 solid #708090;border-top-width:1px"  colspan=2> * 예) [나라빌] 같은 외부시스템에서 매출 발행했을 경우 <font color="red">[외부시스템 매출발행]</font>을 반드시 체크 해 주십시요.
		 </td>
    </tr>
	</table>
	<table cellpadding=0 cellspacing=0 border=1 style="position:relative;left:8px;top:13px;border:1 solid #708090;display:none">
		<tr> 
			<tr> 
				<td class="tab41" width="100px" bgcolor="#eeeeee"><nobr>공급가액</nobr></td>
				<td class="tab23" width="149px;"><comment id="__NSID__">
					<object  id=gcem_taxsum2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;width:90px">
						<param name=Text				value="">
						<param name=Alignment		value=2>
						<param name=Border			value=true>
						<param name=ClipMode		value=true>
						<param name=Numeric			value=true>
						<param name=Format			value="000,000,000">
						<param name=PromptChar	value="_">
						<param name=Enable			value="false">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab12" width="100px" bgcolor="#eeeeee"><nobr>부가세액</nobr></td>
				<td class="tab23" width="189px" colspan=2><comment id="__NSID__">
					<object  id=gcem_taxvatamt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;width:110px">
						<param name=Text				value="">
						<param name=Alignment		value=2>
						<param name=Border			value=true>
						<param name=ClipMode		value=true>
						<param name=Numeric			value=true>
						<param name=Format			value="000,000,000">
						<param name=PromptChar	value="_">
						<param name=Enable			value="false">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab12" width="100px" bgcolor="#eeeeee"><nobr>합계금액</nobr></td>
				<td width="189px" colspan=2><comment id="__NSID__">
					<object  id=gcem_taxtot2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;width:110px">
						<param name=Text				value="">
						<param name=Alignment		value=2>
						<param name=Border			value=true>
						<param name=ClipMode		value=true>
						<param name=Numeric			value=true>
						<param name=Format			value="000,000,000">
						<param name=PromptChar	value="_">
						<param name=Enable			value="false">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr> 
		</table>
	</div>
		</td>
	</tr>
</table>

<!-----------------------------------------------------------------------------
			B I N D  D E F I N I T I O N   -  매 입
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data1 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"				VALUE="gcds_data1">
	<PARAM NAME="ActiveBind"		VALUE="true">
	<PARAM NAME="BindInfo"			VALUE="
	<C>Col=FDCODE				Ctrl=gclx_fdcode				Param=BindColVal	</C>
	<C>Col=TAXNBR_R			Ctrl=gcem_staxnbr				Param=text				</C>
	<C>Col=WORKTYPE			Ctrl=gclx_worktype			Param=BindColVal	</C>
	<C>Col=TAXNBR				Ctrl=gcem_taxnbr				Param=text				</C>
	<C>Col=TAXPRTYN			Ctrl=gclx_taxprtyn			Param=BindColVal	</C>
	<C>Col=DEPTCD				Ctrl=gclx_dept					Param=BindColVal	</C>
	<C>Col=TAXDAT				Ctrl=gcem_taxdat				Param=text				</C>
	<C>Col=TAXTYPE			Ctrl=gclx_taxtype				Param=BindColVal	</C>
	<C>Col=EMPNO				Ctrl=gclx_empno					Param=BindColVal	</C>

	<C>Col=TAXDIV				Ctrl=gclx_taxdiv				Param=BindColVal	</C>
	<C>Col=TAXCNT				Ctrl=gcem_taxcnt				Param=text				</C>
	<C>Col=WRDT					Ctrl=gcem_wrdt					Param=text				</C>
	<C>Col=TAXKND				Ctrl=gclx_taxknd				Param=BindColVal	</C>
	<C>Col=LASTPRT			Ctrl=gcem_lastprt				Param=text				</C>
	<C>Col=COCODE				Ctrl=gclx_cocode				Param=BindColVal	</C>
	<C>Col=VEND_CD			Ctrl=gcem_vendcd				Param=text				</C>
	<C>Col=VEND_ID			Ctrl=gcem_vendid1				Param=text				</C>
	<C>Col=VEND_NM			Ctrl=txt_fdcodenm				Param=value				</C>
	<C>Col=ATCODE				Ctrl=gcem_atcode			  Param=text	      </C>
	<C>Col=ATKORNAM			Ctrl=txt_atkornam			  Param=value				</C>

	<C>Col=ATDECR				Ctrl=txt_atdecr					Param=value				</C>
	<C>Col=REMARK				Ctrl=gcem_remark				Param=text				</C>
	<C>Col=FSDAT				Ctrl=gcem_fsdat					Param=text				</C>
	<C>Col=FSNBR				Ctrl=gcem_fsnbr					Param=text				</C>
	<C>Col=FSSTAT				Ctrl=gcem_fsstat				Param=text				</C>
	<C>Col=TAXSUM				Ctrl=gcem_taxsum				Param=text				</C>
	<C>Col=TAXVATAMT		Ctrl=gcem_taxvatamt			Param=text				</C>
	<C>Col=TAXTOT				Ctrl=gcem_taxtot				Param=text				</C>
	<C>Col=TAXTOT				Ctrl=txt_fixprop				Param=text				</C>
	<C>Col=SEQ				  Ctrl=gcem_seq				    Param=text				</C>
	<C>Col=EMPNM				Ctrl=gcem_empnm				  Param=text				</C>
	<C>Col=DEPTNM_2			Ctrl=gcem_deptnm				Param=text				</C>
	<C>Col=HPNO				  Ctrl=gcem_hpno				  Param=text				</C>
	<C>Col=TELNO			Ctrl=gcem_telno				  Param=text				</C>
	<C>Col=EMAIL			Ctrl=gcem_email				  Param=text				</C> 
    <C>Col=DTI_STATUS		Ctrl=gclx_status			aram=BindColVal	</C> 
	<C>Col=TAXCDNBR		   Ctrl=gcem_canbr				  Param=text	</C> 
	<C>Col=EXTCHK     	   Ctrl=chk_ext	                  Param=Checked    	</C> 
	<C>Col=COSTCD		   Ctrl=txt_costcd				  Param=value				</C>
	<C>Col=COSTNM		   Ctrl=txt_costnm				  Param=value				</C>
">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcbn_data2 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"				VALUE="gcds_data2">
	<PARAM NAME="ActiveBind"		VALUE="true">
	<PARAM NAME="BindInfo"			VALUE="
	
	<C>Col=EMPNO				Ctrl=gclx_empno					Param=BindColVal				</C>
	<C>Col=TAXDT				Ctrl=gcem_taxdd					Param=text				</C>
		
">
</object></comment><script>__ws__(__NSID__);</script>  

<comment id="__NSID__"><object  id=gcbn_data2_2 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"				VALUE="gcds_data2_2">
	<PARAM NAME="ActiveBind"		VALUE="true">
	<PARAM NAME="BindInfo"			VALUE="
	
	<C>Col=EMPNO				Ctrl=gclx_empno2					Param=BindColVal				</C>
	<C>Col=TAXDT				Ctrl=gcem_taxdd2					Param=text				</C>
		
">
</object></comment><script>__ws__(__NSID__);</script>  


<comment id="__NSID__"><object  id=gcbn_data2_2 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"				VALUE="gcds_insert">
	<PARAM NAME="ActiveBind"		VALUE="true">
	<PARAM NAME="BindInfo"			VALUE="
	
	<C>Col=SEQ				Ctrl=txt_fixprop					Param=value				</C>
	<C>Col=ASTNAME		Ctrl=txt_fixpropnm				Param=value				</C>
	<C>Col=CNT				Ctrl=txt_fixpropnm_cnt		Param=value				</C>
		
">
</object></comment><script>__ws__(__NSID__);</script>  

<!-----------------------------------------------------------------------------
			B I N D  D E F I N I T I O N   -  매 출
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data1_2 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"				VALUE="gcds_data1_2">
	<PARAM NAME="ActiveBind"		VALUE="true">
	<PARAM NAME="BindInfo"			VALUE="
	<C>Col=FDCODE				Ctrl=gclx_fdcode2				Param=BindColVal	</C>
	<C>Col=TAXNBR_R			Ctrl=gcem_staxnbr2			Param=text				</C>
	<C>Col=WORKTYPE			Ctrl=gclx_worktype2			Param=BindColVal	</C>
	<C>Col=TAXNBR				Ctrl=gcem_taxnbr2				Param=text				</C>
	<C>Col=TAXPRTYN			Ctrl=gclx_taxprtyn2			Param=BindColVal	</C>
	<C>Col=DEPTCD				Ctrl=gclx_dept2					Param=BindColVal	</C>
	<C>Col=TAXDAT				Ctrl=gcem_taxdat2				Param=text				</C>
	<C>Col=TAXTYPE			Ctrl=gclx_taxtype2			Param=BindColVal	</C>
	<C>Col=EMPNO				Ctrl=gclx_empno2				Param=BindColVal	</C>
	<C>Col=TAXDIV				Ctrl=gclx_taxdiv2				Param=BindColVal	</C>
	<C>Col=TAXCNT				Ctrl=gcem_taxcnt2				Param=text				</C>
	<C>Col=WRDT					Ctrl=gcem_wrdt2					Param=text				</C>
	<C>Col=TAXKND				Ctrl=gclx_taxknd2				Param=BindColVal	</C>
	<C>Col=LASTPRT			Ctrl=gcem_lastprt2			Param=text				</C>
	<C>Col=COCODE				Ctrl=gclx_cocode2				Param=BindColVal	</C>
	<C>Col=VEND_CD			Ctrl=gcem_vendcd2				Param=text				</C>
	<C>Col=VEND_ID			Ctrl=gcem_vendid2				Param=text				</C>
	<C>Col=VEND_NM			Ctrl=txt_fdcodenm2			Param=value				</C>
	<C>Col=ATCODE				Ctrl=gcem_atcode2			  Param=text	      </C>
	<C>Col=ATKORNAM			Ctrl=txt_atkornam_2			Param=value				</C>
	<C>Col=ATDECR				Ctrl=txt_atdecr_2				Param=value				</C>
	<C>Col=REMARK				Ctrl=gcem_remark2				Param=text				</C>
	<C>Col=FSDAT				Ctrl=gcem_fsdat2				Param=text				</C>
	<C>Col=FSNBR				Ctrl=gcem_fsnbr2				Param=text				</C>
	<C>Col=FSSTAT				Ctrl=gcem_fsstat2				Param=text				</C>
	<C>Col=TAXSUM				Ctrl=gcem_taxsum2				Param=text				</C>
	<C>Col=TAXVATAMT		Ctrl=gcem_taxvatamt2		Param=text				</C>
	<C>Col=TAXTOT				Ctrl=gcem_taxtot2				Param=text				</C>
	<C>Col=SEQ				  Ctrl=gcem_seq2				  Param=text				</C>
	<C>Col=EMPNM				Ctrl=gcem_empnm2				Param=text				</C>
	<C>Col=DEPTNM_2			Ctrl=gcem_deptnm2				Param=text				</C>
	<C>Col=HPNO				  Ctrl=gcem_hpno2				  Param=text				</C>
	<C>Col=TELNO				Ctrl=gcem_telno2				Param=text				</C>
	<C>Col=EMAIL				Ctrl=gcem_email2				Param=text				</C> 
	<C>Col=DTI_STATUS		Ctrl=gclx_status2				Param=BindColVal	</C> 
	<C>Col=AMEND_CODE		Ctrl=gclx_amend_code		Param=BindColVal	</C> 
	<C>Col=AMEND_REMARK	Ctrl=gcem_amend_remark	  Param=text      	</C> 
	<C>Col=REMARK2	    Ctrl=gcem_remark_b2	      Param=text      	</C> 
	<C>Col=S_BIZPLACE	  Ctrl=gcem_s_bizplace    Param=text      	</C> 
	<C>Col=COSTCD   	  Ctrl=txt_costcd02       Param=value      	</C> 
	<C>Col=COSTNM		  Ctrl=txt_costnm02				  Param=value				</C>
">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N - 매 출 세 금 계 산 서
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<param NAME="DetailDataID"			VALUE="gcds_print2">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="false">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
">
</object></comment><script>__ws__(__NSID__);</script>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 