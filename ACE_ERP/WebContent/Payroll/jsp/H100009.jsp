<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
	<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	급여/급여정보관리 > 출력관리
+ 프로그램 ID	: P020007.html
+ 기 능 정 의	: 조회|출력
+ 변 경 이 력	: 권영법
+ 수 정 내 용 : 급여변동현황 데이타가 안 맞음. Servlet 모두 수정함. 지급항목추가함.
+ 수 정 이 력	: 이순미 - 2005.08.02 - 소스 정리
+ 수 정 이 력	: 정영식 - 2005.08.24 - 소속별 급여지급현황 엑셀 추가
+ 수 정 이 력	: 정영식 - 2005.09.07 - 출력관리 4개 항목에 조건 변경 (급여+소급+퇴직+휴급, 상여)
+ 수 정 이 력	: 이순미 - 2006.03.10 - 급여소속총액(검색조건 소속,직위 추가),레포트 반영
---------------------------------------------------------------------------------
+ 수 정 내 용 : 지급현황 과거 데이터 조회를 위하여 지급현황 출력물의 상세내용 쿼리문 변경
                ( h100009_s33 ==> h100009_s331로 변경함 )
								PBPAY 에 컬럼 추가 PRTSEQ, PRTCOD, PRTDEPTNM [출력순 관련]
+ 수 정 일 자 : 2010.10.29 
+ 수   정  자 : 정  영  식 
------------------------------------------------------------------------------
+ 서 블 릿 명	: p020007_s1, p020007_s2, p020007_s3, p020007_s4,
								p020007_s5, p020007_s6, p020007_s7
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>출력관리</title>
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>

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


var gs_level;
var gs_treecd;
var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
var gs_date2 = gcurdate.substr(0,4) +"/"+ gcurdate.substr(5,2) +"/"+ gcurdate.substr(8,2);
var gs_date3 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var Hrow=0; var Hcol=0;
var THeader ="param1:String(10),param2:String(10),param3:String(10),param4:String(10),param5:String(10),"
            +"param6:String(10),param7:String(10),param8:String(10),param9:String(10),param10:String(10)";

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	
	gcem_app_yyyymm_3.Text = gs_date3;
	gcem_app_yyyymm_7.Text = gs_date3;


	gcem_yyyymm41.Text = gs_date3;
	gcem_yyyymm42.Text = gs_date3;

	gcem_yyyymm51.Text = gs_date3;
	gcem_yyyymm52.Text = gs_date3;

	gcem_yyyymm61.Text = gs_date3;
	gcem_yyyymm62.Text = gs_date3;

	gcds_pyo4.ClearAll();
	gcds_pyo4.DataID = "";
	gcds_pyo4.SetDataHeader(THeader);
	gcds_pyo4.addrow();
	gcds_pyo4.namevalue(1,"param1")="총계";
	gcds_pyo4.namevalue(1,"param4")="기본급계";
	gcds_pyo4.namevalue(1,"param5")=0;
	gcds_pyo4.namevalue(1,"param6")="건강보험계";
	gcds_pyo4.namevalue(1,"param7")=0;
	gcds_pyo4.namevalue(1,"param8")="소득세계";
	gcds_pyo4.namevalue(1,"param9")=0;
	gcds_pyo4.addrow();
	gcds_pyo4.namevalue(2,"param1")=0;
	gcds_pyo4.namevalue(2,"param2")="실지급액계";
	gcds_pyo4.namevalue(2,"param3")=0;
	gcds_pyo4.namevalue(2,"param4")="상여계";
	gcds_pyo4.namevalue(2,"param5")=0;
	gcds_pyo4.namevalue(2,"param6")="국민연금계";
	gcds_pyo4.namevalue(2,"param7")=0;
	gcds_pyo4.namevalue(2,"param8")="주민세계";
	gcds_pyo4.namevalue(2,"param9")=0;

	gcds_pyo4.addrow();
	gcds_pyo4.namevalue(3,"param4")="시간외수당계";
	gcds_pyo4.namevalue(3,"param5")=0;
	gcds_pyo4.namevalue(3,"param6")="고용보험계";
	gcds_pyo4.namevalue(3,"param7")=0;
	gcds_pyo4.namevalue(3,"param8")="공제계";
	gcds_pyo4.namevalue(3,"param9")=0;
	gcds_pyo4.addrow();
	gcds_pyo4.RowPosition = 4;

	gcds_pyo5.ClearAll();
	gcds_pyo5.DataID = "";
	gcds_pyo5.SetDataHeader(THeader);
	gcds_pyo5.addrow();
	gcds_pyo5.namevalue(1,"param1")="총계";
	gcds_pyo5.namevalue(1,"param4")="기본급계";
	gcds_pyo5.namevalue(1,"param5")=0;
	gcds_pyo5.namevalue(1,"param6")="건강보험계";
	gcds_pyo5.namevalue(1,"param7")=0;
	gcds_pyo5.namevalue(1,"param8")="소득세계";
	gcds_pyo5.namevalue(1,"param9")=0;
	gcds_pyo5.addrow();
	gcds_pyo5.namevalue(2,"param1")=0;
	gcds_pyo5.namevalue(2,"param2")="실지급액계";
	gcds_pyo5.namevalue(2,"param3")=0;
	gcds_pyo5.namevalue(2,"param4")="직책수당계";
	gcds_pyo5.namevalue(2,"param5")=0;
	gcds_pyo5.namevalue(2,"param6")="국민연금계";
	gcds_pyo5.namevalue(2,"param7")=0;
	gcds_pyo5.namevalue(2,"param8")="주민세계";
	gcds_pyo5.namevalue(2,"param9")=0;

	gcds_pyo5.addrow();
	gcds_pyo5.namevalue(3,"param4")="시간외수당계";
	gcds_pyo5.namevalue(3,"param5")=0;
	gcds_pyo5.namevalue(3,"param6")="고용보험계";
	gcds_pyo5.namevalue(3,"param7")=0;
	gcds_pyo5.namevalue(3,"param8")="공제계";
	gcds_pyo5.namevalue(3,"param9")=0;
	gcds_pyo5.addrow();
	gcds_pyo5.RowPosition = 4;

	gcds_pyo6.ClearAll();
	gcds_pyo6.DataID = "";
	gcds_pyo6.SetDataHeader(THeader);
	gcds_pyo6.addrow();
	gcds_pyo6.namevalue(1,"param1")="총계";
	gcds_pyo6.namevalue(1,"param4")="기본급계";
	gcds_pyo6.namevalue(1,"param5")=0;
	gcds_pyo6.namevalue(1,"param6")="건강보험계";
	gcds_pyo6.namevalue(1,"param7")=0;
	gcds_pyo6.namevalue(1,"param8")="소득세계";
	gcds_pyo6.namevalue(1,"param9")=0;
	gcds_pyo6.addrow();
	gcds_pyo6.namevalue(2,"param1")=0;
	gcds_pyo6.namevalue(2,"param2")="실지급액계";
	gcds_pyo6.namevalue(2,"param3")=0;
	gcds_pyo6.namevalue(2,"param4")="직책수당계";
	gcds_pyo6.namevalue(2,"param5")=0;
	gcds_pyo6.namevalue(2,"param6")="국민연금계";
	gcds_pyo6.namevalue(2,"param7")=0;
	gcds_pyo6.namevalue(2,"param8")="주민세계";
	gcds_pyo6.namevalue(2,"param9")=0;

	gcds_pyo6.addrow();
	gcds_pyo6.namevalue(3,"param4")="시간외수당계";
	gcds_pyo6.namevalue(3,"param5")=0;
	gcds_pyo6.namevalue(3,"param6")="고용보험계";
	gcds_pyo6.namevalue(3,"param7")=0;
	gcds_pyo6.namevalue(3,"param8")="공제계";
	gcds_pyo6.namevalue(3,"param9")=0;
	gcds_pyo6.addrow();
	gcds_pyo6.RowPosition = 4;

	//지급구분
	gcds_select_ec01az.DataID = "/servlet/Contract.hclcode_s1?v_str1=1120"; 
	gcds_select_ec01az.Reset();

	//소속정보
  gcds_dept.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?v_str1="; 
	gcds_dept.Reset();

	//직군정보
	gcds_select_ec03az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2000"; 
	gcds_select_ec03az.Reset();

	//직위정보
	gcds_select_ec04az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002"; 
	gcds_select_ec04az.Reset();

	//급여항목
	gcds_select_ec06az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1126"; 
	gcds_select_ec06az.Reset();

	//직급정보
	gcds_select_ec05az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2001"; 
	gcds_select_ec05az.Reset();

	var str1 = "";//fn_trim(gcem_jigubil_3.Text);      //지급일자
	var str2 = fn_trim(gcem_app_yyyymm_3.Text);        //penwidth=5년월
  yyyymmPlusMinus(str2,str1,gs_date3);
	gcgd_create3_1.ColumnProp('PRVYYYYMM', 'Name') = str2_1.substr(0,4)+"년 " + str2_1.substr(4,2)+"월";
	gcgd_create3_1.ColumnProp('NOWYYYYMM', 'Name') = str2_2.substr(0,4)+"년 " + str2_2.substr(4,2)+"월";

	nwgubun.value="4_1";
	ln_visible_hidden("4_1");

}

/******************************************************************************
	Description : 기본조회
******************************************************************************/
function ln_Query(){

	eval("ln_Query_"+nwgubun.value+"();");

}

/******************************************************************************
	Description : 소속별 급여지급현황 Excel 쿼리
******************************************************************************/
function ln_Excel_Query(){
	var str1 = fn_trim(gcem_yyyymm51.Text);								//지급년월
	var str2 = fn_trim(gcem_yyyymm52.Text);								//지급년월
	var str3 = fn_trim(gclx_select_jigub5.BindColVal);		//지급구분						

	gcds_excel_5_1.DataID = "/servlet/Contract.h100009_s10?v_str1="+str1+"&v_str2="+str3; 
	//prompt("",gcds_excel_5_1.DataID);
	gcds_excel_5_1.Reset();
	gcgd_excel_5_1.RunExcelEx('소속별급여지급현황', 1, 0);
}

/******************************************************************************
	Description : 급여소득총액 Excel 
******************************************************************************/
function ln_Excel_Query2(){
	var str1 = fn_trim(gcem_yyyymm61.Text);									//지급년월 fr
	var str2 = fn_trim(gcem_yyyymm62.Text);									//지급년월 to
	var str3 = fn_trim(gclx_select_jigub6.BindColVal);      //지급구분
	var str4 = fn_trim(gclx_select_div6.BindColVal);				//재직구분
	var str5 = str1.substring(0,4);
  str5+="소득총액";
	var str6 = fn_trim(gclx_select_position7.BindColVal);		//직위

	gcds_excel_6_1.DataID = "/servlet/Contract.h100009_s9?"
									 + "v_str1="  + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
									 + "&v_str5=" + gs_level
									 + "&v_str6=" + gs_treecd
									 + "&v_str7=" + str6;
	//prompt("",gcds_excel_6_1.DataID);
	gcds_excel_6_1.Reset(); //그리드
	gcds_excel_6_1.rowposition=1;
	gcgd_excel_6_1.RunExcelEx(str5, 1, 0);
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_prvyyyy(yyyy,mm) {

	if(parseInt(mm)==1)	{
    returnPrv=(parseInt(yyyy)-1)+"";
	}
	else returnPrv=yyyy;

	return returnPrv;
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_prvmm(prv) {

	if(Number(prv)==1) returnPrv="12";
	else
	{
		returnPrv=(Number(prv)-1)+"";
	}
	
	if(returnPrv.length ==1)
			returnPrv="0" + returnPrv ;

	return returnPrv;

}

/******************************************************************************
	Description : 상여에만 사용됨
******************************************************************************/
function ln_prvmm2(prv) {

	if(Number(prv)==1) {
		returnPrv="12";
	} else if(Number(prv)==12){
		returnPrv="11";
	} else{
		returnPrv=(Number(prv)-2)+"";
	}

	if(returnPrv.length ==1)
			returnPrv="0" + returnPrv ;

	return returnPrv;
}

/******************************************************************************
	Description : 
	Param       : str2 - 지급년월 fr
	              str1 - 지급년월 to
								gs_date2 - 현재년월
******************************************************************************/
function yyyymmPlusMinus(str2,str1,gs_date2) {
	if( str2.length ==6) {
		str2_1=ln_prvyyyy(str2.substr(0,4),str2.substr(4,2)) +""+ ln_prvmm(str2.substr(4,2));
		str2_2=str2.substr(0,4) +""+ str2.substr(4,2);
	} else if ( str1.length ==8) {
		str2_1=ln_prvyyyy(str1.substr(0,4),str2.substr(4,2)) +""+ ln_prvmm(str1.substr(4,2));
		str2_2=str1.substr(0,4) +""+ str1.substr(4,2);
	} else {
		str2_1=ln_prvyyyy(gs_date2.substr(0,4),gs_date2.substr(4,2)) +""+ ln_prvmm(gs_date2.substr(4,2));
		str2_2=gs_date2.substr(0,4) +""+ gs_date2.substr(4,2);
  }
}

/******************************************************************************
	Description : 상여일때만 사용 (상여지급월 1, 3, 5, 7, 9, 11, 12월)
	Param       : str2 - 지급년월 fr
	              str1 - 지급년월 to
								gs_date2 - 현재년월
******************************************************************************/
function yyyymmPlusMinus2(str2,str1,gs_date2) {
	
		str2_1=ln_prvyyyy(str2.substr(0,4),str2.substr(4,2)) +""+ ln_prvmm2(str2.substr(4,2));
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Query_3_1(){ //급여변동내역 탭 조회
	var str1 = "";// fn_trim(gcem_jigubil_3.Text);        //지급일자
	var str2 = fn_trim(gcem_app_yyyymm_3.Text);        //penwidth=5년월
	var str3 = fn_trim(gclx_select_ec01az_3.BindColVal);  //지급구분
	var str4 = fn_trim(gclx_select_div3.BindColVal);  //소속
	var str5 = fn_trim(gclx_select_ec03az_3.BindColVal);  //직군

	if(str2.length != 6) {
	alert("적용년월을 입력해주세요");
		gcem_app_yyyymm_3.Focus();
	}	else	{
   
		 yyyymmPlusMinus(str2,str1,gs_date3);
	 gcgd_create3_1.ColumnProp('PRVYYYYMM', 'Name') = str2_1.substr(0,4)+"년 " + str2_1.substr(4,2)+"월";
	 gcgd_create3_1.ColumnProp('NOWYYYYMM', 'Name') = str2_2.substr(0,4)+"년 " + str2_2.substr(4,2)+"월";
   
	 gcds_grid_ec03az.DataID = "/servlet/Contract.h100009_s8?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2_1
									 + "&v_str3=" + str2_2
									 + "&v_str4=" + str3
									 + "&v_str5=" + str4
									 + "&v_str6=" + str5;

//prompt("",gcds_grid_ec03az.DataID);	
	gcds_grid_ec03az.Reset(); //그리드
	gcds_grid_ec03az.rowposition=1;
	}
}

/******************************************************************************
	Description : 급여지급현황 조회
******************************************************************************/
function ln_Query_4_1(){ 
	var str1 = fn_trim(gcem_yyyymm41.Text);									//지급년월
	var str2 = fn_trim(gcem_yyyymm42.Text);									//지급년월
	var str3 = fn_trim(gclx_select_jigub4.BindColVal);      //지급구분
	var str4 = fn_trim(gclx_select_div4.BindColVal);				//소속
	var str5 = fn_trim(gclx_select_group4.BindColVal);			//직군
	var str6 = fn_trim(gclx_select_position4.BindColVal);		//직위
	var str7 = fn_trim(gclx_select_grade4.BindColVal);			//직급

  if(str3=='T'){

	gcds_grid_ec04az.DataID = "/servlet/Contract.h100009_s1?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
									 + "&v_str5=" + str5
									 + "&v_str6=" + str6
									 + "&v_str7=" + str7
									 + "&v_str8=" + gs_level
									 + "&v_str9=" + gs_treecd;
//	prompt("",gcds_grid_ec04az.DataID);	
	gcds_grid_ec04az.Reset(); //그리드
	gcds_grid_ec04az.rowposition=1;

	}else{
		
			gcds_grid_ec04az.DataID = "/servlet/Contract.h100009_s1?"				
			             + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
									 + "&v_str5=" + str5
									 + "&v_str6=" + str6
									 + "&v_str7=" + str7
									 + "&v_str8=" + gs_level
									 + "&v_str9=" + gs_treecd;
	//prompt("",gcds_grid_ec04az.DataID);	
	gcds_grid_ec04az.Reset(); //그리드
	gcds_grid_ec04az.rowposition=1;

	}

}

/******************************************************************************
	Description : 소속별급여지급현황 조회
******************************************************************************/
function ln_Query_5_1(){																
	var str1 = fn_trim(gcem_yyyymm51.Text);								//지급년월
	var str2 = fn_trim(gcem_yyyymm52.Text);								//지급년월
	var str3 = fn_trim(gclx_select_jigub5.BindColVal);		//지급구분
	var str4 = fn_trim(gclx_select_div5.BindColVal);			//소속
	var str5 = fn_trim(gclx_select_group5.BindColVal);		//직군
	var str6 = fn_trim(gclx_select_position5.BindColVal); //직위
	var str7 = fn_trim(gclx_select_grade5.BindColVal);		//직급

	gcds_grid_ec05az.DataID = "/servlet/Contract.h100009_s4?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
									 + "&v_str5=" + str5
									 + "&v_str6=" + str6
									 + "&v_str7=" + str7
	//prompt("",gcds_grid_ec05az.DataID);	
	gcds_grid_ec05az.Reset(); //그리드
	gcds_grid_ec05az.rowposition=1;
}

/******************************************************************************
	Description : 급여 소득총액 조회
******************************************************************************/
function ln_Query_6_1(){ 

	var str1 = fn_trim(gcem_yyyymm61.Text);									//지급년월 fr
	var str2 = fn_trim(gcem_yyyymm62.Text);									//지급년월 to
	var str3 = fn_trim(gclx_select_jigub6.BindColVal);      //지급구분
	var str4 = fn_trim(gclx_select_div6.BindColVal);				//재직구분
	var str5 = fn_trim(gclx_select_position7.BindColVal);		//직위

	gcds_grid_ec06az.DataID = "/servlet/Contract.h100009_s9?"
									 + "v_str1="  + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4 
									 + "&v_str5=" + gs_level 
									 + "&v_str6=" + gs_treecd 
									 + "&v_str7=" + str5;
	//prompt("",gcds_grid_ec06az.DataID);		
	gcds_grid_ec06az.Reset(); //그리드
	gcds_grid_ec06az.rowposition=1;

}

/******************************************************************************
	Description : 당월 급여 변동자
******************************************************************************/
function ln_Query_7_1(){ 

	var str1 = "";									
	var str2 = fn_trim(gcem_app_yyyymm_7.Text);				 //지급년월 
	var str3 = fn_trim(gclx_select_7.BindColVal);      //지급구분
	var str4="";

  yyyymmPlusMinus(str2,str1,gs_date3);
	gcgd_create3_1.ColumnProp('PRVYYYYMM', 'Name') = str2_1.substr(0,4)+"년 " + str2_1.substr(4,2)+"월";
	gcgd_create3_1.ColumnProp('NOWYYYYMM', 'Name') = str2_2.substr(0,4)+"년 " + str2_2.substr(4,2)+"월";

	if(gclx_select_7.bindcolval=="T"){
		if (gclx_ord_7.bindcolval=="A"){
			str4="";
		}else if(gclx_ord_7.bindcolval=="A1"){ //입사
			str4="'A1','A2','A3','A4','A9','C4','C8','F1','F2'";
		}else if(gclx_ord_7.bindcolval=="A2"){ //퇴사
			str4="'C5'";
		}else if(gclx_ord_7.bindcolval=="A3"){ //부임
			str4="'C1'";
		}else if(gclx_ord_7.bindcolval=="A4"){ //복귀
			str4="'C3','C9'";
		}else if(gclx_ord_7.bindcolval=="A5"){ //기타
      str4="Z";
    }

		gcds_change_7.DataID = "/servlet/Contract.h100009_s17?"
										 + "v_str1="  + str2
										 + "&v_str2=" + str3
										 + "&v_str3=" + str2_1
										 + "&v_str4=" + str4;
										 
		gcds_change_7.Reset(); //그리드
		gcds_change_7.rowposition=1;
	}else{ 
		gcds_change_7.DataID = "/servlet/Contract.h100009_s18?"
										 + "v_str1="  + str2
										 + "&v_str2=" + str3
										 + "&v_str3=" + str2_1
										 + "&v_str4=" + str4;
										 
		gcds_change_7.Reset(); //그리드
		gcds_change_7.rowposition=1;

	}
}

/******************************************************************************
	Description : 급여지급현황 총인원보고서(Fheader 부분)
******************************************************************************/
function ln_Report_4_1(e,n){ 
	var str1 = fn_trim(gcem_yyyymm41.Text);								//지급년월
	var str2 = fn_trim(gcem_yyyymm42.Text);								//지급년월
	var str3 = fn_trim(gclx_select_jigub4.BindColVal);		//지급구분
	var str4 = fn_trim(gclx_select_div4.BindColVal);			//소속
	var str5 = fn_trim(gclx_select_group4.BindColVal);    //직군
	var str6 = fn_trim(gclx_select_position4.BindColVal); //직위
	var str7 = fn_trim(gclx_select_grade4.BindColVal);    //직급

  if(fn_trim(gclx_select_jigub4.bindcolval)==5){ 	//상여일때와 달리 한다.
		yyyymmPlusMinus2(str2,str2,gs_date3);
	}else {
		yyyymmPlusMinus(str2,str2,gs_date3);
  }

	gcds_report0.ClearAll();

	if (str3 == e) {
		gcds_report0.DataID = "/servlet/Contract.h100009_s2"+n+"?"
										 + "v_str1="	+ str2_1
										 + "&v_str2=" + str2
										 + "&v_str3=" + str3
										 + "&v_str4=" + str4
										 + "&v_str5=" + str5
										 + "&v_str6=" + str6
										 + "&v_str7=" + str7
										 + "&v_str8=" + gs_date;
	//	prompt("",gcds_report0.DataID);
		gcds_report0.Reset();
	}
}

/******************************************************************************
	Description : 급여지급현황 상세보고서 (Detail 부분)
******************************************************************************/
function ln_Report_4_2(e,n){ 
	var str1 = fn_trim(gcem_yyyymm41.Text);								//지급년월
	var str2 = fn_trim(gcem_yyyymm42.Text);								//지급년월
	var str3 = fn_trim(gclx_select_jigub4.BindColVal);    //지급구분
	var str4 = fn_trim(gclx_select_div4.BindColVal);			//소속
	var str5 = fn_trim(gclx_select_group4.BindColVal);    //직군
	var str6 = fn_trim(gclx_select_position4.BindColVal); //직위
	var str7 = fn_trim(gclx_select_grade4.BindColVal);    //직급
  
	gcds_report1.ClearAll();

	if (str3 == e) {

 		//gcds_report1.DataID = "/servlet/Contract.h100009_s3"+n+"?"
		//gcds_report1.DataID = "/servlet/Contract.h100009_s33"+n+"?"
		gcds_report1.DataID = "/servlet/Contract.h100009_s331"+n+"?"
										 + "v_str1="	+ str2_1
										 + "&v_str2=" + str2
										 + "&v_str3=" + str3
										 + "&v_str4=" + str4
										 + "&v_str5=" + str5
										 + "&v_str6=" + str6
										 + "&v_str7=" + str7;
// prompt("",gcds_report1.DataID);
		gcds_report1.Reset(); 
		gcds_report1.rowposition=1;
	}
}

/******************************************************************************
	Description : 급여지급현황 본사근무자보고서(Header 부분)
******************************************************************************/
function ln_Report_4_3(e,n){ 
	var str1 = fn_trim(gcem_yyyymm41.Text);										//지급년월
	var str2 = fn_trim(gcem_yyyymm42.Text);										//지급년월
	var str3 = fn_trim(gclx_select_jigub4.BindColVal);        //지급구분
	var str4 = fn_trim(gclx_select_div4.BindColVal);					//소속
	var str5 = fn_trim(gclx_select_group4.BindColVal);				//직군
	var str6 = fn_trim(gclx_select_position4.BindColVal);			//직위
	var str7 = fn_trim(gclx_select_grade4.BindColVal);				//직급
  
	gcds_report2.ClearAll();

	if (str3 == e) {
	gcds_report2.DataID = "/servlet/Contract.h100009_s7"+n+"?"
									 + "v_str1="	+ str2_1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
									 + "&v_str5=" + str5
									 + "&v_str6=" + str6
									 + "&v_str7=" + str7;
/<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p020007_s7?v_str1=200603&v_str2=200604&v_str3=T&v_str4=&v_str5=&v_str6=&v_str7=

	//prompt("",gcds_report2.DataID);	
	gcds_report2.Reset(); 
	gcds_report2.rowposition=1;
	
	}
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Report_5_1(){ //소속별급여지급현황 총인원보고서(Fheader 부분)
	var str2 = fn_trim(gcem_yyyymm52.Text);        //지급년월
	
       gcds_report0.ClearAll();

		var ls_temp = "CYYYY:STRING,"
		            + "CMM:STRING,"
		            + "TODATEE:STRING";
		gcds_report0.SetDataHeader(ls_temp);
		gcds_report0.Addrow();
		gcds_report0.namevalue(1,"CYYYY")=str2.substring(0,4);
		gcds_report0.namevalue(1,"CMM")=str2.substring(4,6);
		gcds_report0.namevalue(1,"TODATEE")=gs_date;
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Report_5_2(){ //소속별급여지급현황 상세보고서
	var str1 = fn_trim(gcem_yyyymm51.Text);        //지급년월
	var str2 = fn_trim(gcem_yyyymm52.Text);        //지급년월
	var str3 = fn_trim(gclx_select_jigub5.BindColVal);        //지급구분
	var str4 = fn_trim(gclx_select_div5.BindColVal);  //소속
	var str5 = fn_trim(gclx_select_group5.BindColVal);     //직군
	var str6 = fn_trim(gclx_select_position5.BindColVal);  //직위
	var str7 = fn_trim(gclx_select_grade5.BindColVal);     //직급

	
	gcds_report2.ClearAll();

	gcds_report2.DataID = "/servlet/Contract.h100009_s5?"
									 + "v_str1=" + str2_1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
									 + "&v_str5=" + str5
									 + "&v_str6=" + str6
									 + "&v_str7=" + str7;
	//prompt("", gcds_report2.DataID);
	gcds_report2.Reset(); //그리드
	gcds_report2.rowposition=1;
	/*
    if (gcds_report2.countrow >0)
	   return true;
	  else{
		alert("지급년월 2번째 입력란이 출력기준년월으로서\n "+str2.substr(0,4)+"년 "+str2.substr(4,2)+"월의 소속별 급여지급현황데이타가 없습니다.");
		return false;
	}
	*/
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Report_3_1(){ //급여변동내역 총인원보고서
	var str2 = fn_trim(gcem_app_yyyymm_3.Text);        //지급년월
       gcds_report0.ClearAll();

		var ls_temp = 
					"CTITLE:STRING,"
		      //+ "CMM:STRING,"
		            + "TODATEE:STRING,"
		            + "PRVYYYYMM:STRING,"   /*이전년월*/
		            + "NOWYYYYMM:STRING,"   /*현재년월*/
					+	"PRVNUM:Decimal,"	/* 이전월 총인원 */
					+	"PRVAMT:Decimal,"   /* 이전월 전체 총 실급여*/
					+	"NEXNUM:Decimal,"	/* 현재월 총인원*/
					+	"NEXAMT:Decimal,"	/* 현재월 전체 총 실급여 */
					+   "IBSANUM:Decimal,"	/* 현재penwidth=5년월 입사인원*/	
					+   "IBSAAMT:Decimal,"	/* 현재penwidth=5년월 입사 총 실급여*/
					+	"TAENUM:Decimal,"	/* 현재penwidth=5년월 퇴사사인원 */
					+	"TAEAMT:Decimal,"   /* 현재적용년월 퇴사사 총 실급여*/
					+   "SUNGNUM:Decimal,"	/* 현재적용년월 승진인원*/
					+   "SUNGAMT:Decimal,"	/* 현재적용년월 승진자 총 실급여*/
					+	"ITSNUM:Decimal,"	/* 현재적용년월 입,퇴,승진자 총 실급여*/
					+	"ITSAMT:Decimal,"	/* 현재적용년월 입,퇴,승진자 총 실급여*/	
					+	"A1_AMT:Decimal,"	/* --기본급 증감 금액  */
					+	"A2_AMT:Decimal,"	/* --직책수당 증감 금액 */
					+	"A3_AMT:Decimal,"   /* --시간외 증감 금액  */
					+	"A4_AMT:Decimal,"	/* --근속수당 증감 금액 */
					+	"A5_AMT:Decimal,"	/* --자기계발비 증감 금액 */
					+	"A6_AMT:Decimal,"	/* --가족부양비 증감 금액 */	
					+	"A7_AMT:Decimal,"	/* --차량유지비 증감 금액 */
					+	"A8_AMT:Decimal,"	/* --자격수당 증감 금액  */
					+	"A9_AMT:Decimal,"   /* --개인연금 증감 금액  */
					+   "A10_AMT:Decimal,"	/* 남북경헙 증감 금액       */
					+   "A11_AMT:Decimal,"	/* 특수지 수당 증감 금액         */
					+   "A12_AMT:Decimal,"	/* 지역근무수당 증감 금액       */	
					+   "A13_AMT:Decimal,"	/* 휴일근무수당 증감 금액 -협의필요*/
					+   "A14_AMT:Decimal,"	/* 전월소급 증감 금액            */
					+   "A15_AMT:Decimal,"	/* 임원직책 증감 금액         */	
					+   "A16_AMT:Decimal,"	/* 학자금 증감 금액          */	
					+   "AA_AMT:Decimal";	    /* 지급 총합 증감 금액*/						

		gcds_report0.SetDataHeader(ls_temp);
		gcds_report0.Addrow();

    //alert(gcds_report0.namevalue(1,"CTITLE"));
		gcds_report0.namevalue(1,"CTITLE")= "급여변동현황 ["+str2.substring(0,4) +"년 "+ str2.substring(4,6)+"월]";

		//gcds_report0.namevalue(1,"CYYYY")=str2.substring(0,4);
		//gcds_report0.namevalue(1,"CMM")=str2.substring(4,6);
		gcds_report0.namevalue(1,"TODATEE")=gs_date;
		gcds_report0.namevalue(1,"PRVYYYYMM")=gcgd_create3_1.ColumnProp('PRVYYYYMM', 'Name');
	  gcds_report0.namevalue(1,"NOWYYYYMM")=gcgd_create3_1.ColumnProp('NOWYYYYMM', 'Name');

		gcds_report0.namevalue(1,"PRVNUM")=gcds_grid_ec03az.Sum(5,0,0);		/* 이전월 총인원 */
		gcds_report0.namevalue(1,"PRVAMT")=gcds_grid_ec03az.Sum(6,0,0);   /* 이전월 전체 총 실급여*/
		gcds_report0.namevalue(1,"NEXNUM")=gcds_grid_ec03az.Sum(7,0,0);		/* 현재월 총인원*/
		gcds_report0.namevalue(1,"NEXAMT")=gcds_grid_ec03az.Sum(8,0,0);		/* 현재월 전체 총 실급여 */
		gcds_report0.namevalue(1,"IBSANUM")=gcds_grid_ec03az.Sum(9,0,0);	/* 현재적용년월 입사인원*/	
		gcds_report0.namevalue(1,"IBSAAMT")=gcds_grid_ec03az.Sum(10,0,0);	/* 현재적용년월 입사 총 실급여*/
		gcds_report0.namevalue(1,"TAENUM")=gcds_grid_ec03az.Sum(11,0,0);	/* 현재적용년월 퇴사사인원 */
		gcds_report0.namevalue(1,"TAEAMT")=gcds_grid_ec03az.Sum(12,0,0);  /* 현재적용년월 퇴사사 총 실급여*/
		gcds_report0.namevalue(1,"SUNGNUM")=gcds_grid_ec03az.Sum(13,0,0);	/* 현재적용년월 승진인원*/
		gcds_report0.namevalue(1,"SUNGAMT")=gcds_grid_ec03az.Sum(14,0,0);	/* 현재적용년월 승진자 총 실급여*/
		gcds_report0.namevalue(1,"ITSNUM")=gcds_grid_ec03az.Sum(15,0,0);	/* 현재적용년월 입,퇴,승진자 총 실급여*/
		gcds_report0.namevalue(1,"ITSAMT")=gcds_grid_ec03az.Sum(16,0,0);	/* 현재적용년월 입,퇴,승진자 총 실급여*/	
		gcds_report0.namevalue(1,"A1_AMT")=gcds_grid_ec03az.Sum(17,0,0);	/* --기본급 증감 금액  */
		gcds_report0.namevalue(1,"A2_AMT")=gcds_grid_ec03az.Sum(18,0,0);	/* --직책수당 증감 금액 */
		gcds_report0.namevalue(1,"A3_AMT")=gcds_grid_ec03az.Sum(19,0,0);  /* --시간외 증감 금액  */
		gcds_report0.namevalue(1,"A4_AMT")=gcds_grid_ec03az.Sum(20,0,0);	/* --근속수당 증감 금액 */
		gcds_report0.namevalue(1,"A5_AMT")=gcds_grid_ec03az.Sum(21,0,0);	/* --자기계발비 증감 금액 */
		gcds_report0.namevalue(1,"A6_AMT")=gcds_grid_ec03az.Sum(22,0,0);	/* --가족부양비 증감 금액 */	
		gcds_report0.namevalue(1,"A7_AMT")=gcds_grid_ec03az.Sum(23,0,0);	/* --차량유지비 증감 금액 */
		gcds_report0.namevalue(1,"A8_AMT")=gcds_grid_ec03az.Sum(24,0,0);	/* --자격수당 증감 금액  */
		gcds_report0.namevalue(1,"A9_AMT")=gcds_grid_ec03az.Sum(25,0,0);  /* --개인연금 증감 금액  */
		gcds_report0.namevalue(1,"A10_AMT")=gcds_grid_ec03az.Sum(26,0,0);	/* 남북경헙 증감 금액 */
		gcds_report0.namevalue(1,"A11_AMT")=gcds_grid_ec03az.Sum(27,0,0);	/* 특수지 수당 증감 금액 */
		gcds_report0.namevalue(1,"A12_AMT")=gcds_grid_ec03az.Sum(28,0,0);	/* 지역근무수당 증감 금액 */	
		gcds_report0.namevalue(1,"A13_AMT")=gcds_grid_ec03az.Sum(29,0,0);	/* 휴일근무수당 증감 금액 -협의필요*/
		gcds_report0.namevalue(1,"A14_AMT")=gcds_grid_ec03az.Sum(30,0,0);	/* 전월소급 증감 금액 */
		gcds_report0.namevalue(1,"A15_AMT")=gcds_grid_ec03az.Sum(31,0,0);	/* 임원직책 증감 금액 */	
		gcds_report0.namevalue(1,"A16_AMT")=gcds_grid_ec03az.Sum(32,0,0);	/* 학자금 증감 금액 */	
		gcds_report0.namevalue(1,"AA_AMT")=gcds_grid_ec03az.Sum(41,0,0); 	/* 지급 총합 증감 금액*/				
		
}

/******************************************************************************
	Description : 당월급여 변동자
******************************************************************************/
function ln_Report_7_1(){ //급여변동내역 총인원보고서
	  var str2 = fn_trim(gcem_app_yyyymm_7.Text);        //지급년월
		var str3 ="";
    gcds_report0.ClearAll();
		var ls_temp = "CTITLE:STRING,PRINTDT:STRING,GUBUN:STRING";
		gcds_report0.SetDataHeader(ls_temp);
		gcds_report0.Addrow();
		if (gclx_select_7.bindcolval=="1"){
       str3 = "급여 변동자";  		
		}else if (gclx_select_7.bindcolval=="2"){
       str3 = "급여 소급내역";
		}else{
       str3 = gclx_select_7.text;
		}

		gcds_report0.namevalue(1,"CTITLE")= " ["+ str2.substring(4,6)+"월] "+str3 ;
		gcds_report0.namevalue(1,"PRINTDT")=gs_date;
		gcds_report0.namevalue(1,"GUBUN")= "구분 : " +gclx_ord_7.text;

}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){
//alert(nwgubun.value);
//	if (nwgubun.value=='4_1' && fn_trim(gclx_select_jigub4.BindColVal) == '1') {	//급여 지급현황[정기]
	if (nwgubun.value=='4_1' && fn_trim(gclx_select_jigub4.BindColVal) == 'T') {	//급여 지급현황[정기]
	//alert("111111");
		if (gcds_grid_ec04az.countrow<1) {
			alert("출력하실 정보가 없습니다");
		} else {
			var str1=fn_trim(gcem_yyyymm42.Text);
			if (str1.length != 6) {
				alert("지급년월 2번째 입력란이 기준년월입니다.\n입력해주세요");
			}else{
				var v_pay01 = "T";
				var v_pay02 = "";
				ln_Report_4_1(v_pay01,v_pay02);	
				//ln_Report_4_3(v_pay01,v_pay02);
				ln_Report_4_2(v_pay01,v_pay02);
				gcrp_print.preview();
			}
		}
	} else if (nwgubun.value=='4_1' && fn_trim(gclx_select_jigub4.BindColVal) == 'K') {	//급여 지급현황[상여]
		//alert("22222");
		if (gcds_grid_ec04az.countrow<1) {
			alert("출력하실 정보가 없습니다");
		} else {
			var str1=fn_trim(gcem_yyyymm42.Text);
			if (str1.length != 6) {
				alert("지급년월 2번째 입력란이 기준년월입니다.\n입력해주세요");
			}else{
				var v_pay01 = "K";
				ln_Report_4_1(v_pay01,"");
				//ln_Report_4_3(v_pay01,"7");
				ln_Report_4_2(v_pay01,"");
				//gcrp_print_2.preview();
        gcrp_print.preview();
			}
		}
  }	else if (nwgubun.value=='5_1') {			
		if (gcds_grid_ec05az.countrow<1) {
			alert("출력하실 정보가 없습니다");
		} else {
			var str1=fn_trim(gcem_yyyymm52.Text);
			if (str1.length != 6) {
				alert("지급년월 2번째 입력란이 기준년월입니다.\n입력해주세요");
			}else{
			//alert(gcds_grid_ec05az.countrow);
				ln_Report_5_1();
        ln_Report_5_2();
				//if(ln_Report_5_2())
					gcrp_print2.preview();
					
				}
		}
  }	else if (nwgubun.value=='3_1') {
		//	alert("44444");
		if (gcds_grid_ec03az.countrow<1) {
			alert("출력하실 정보가 없습니다");
		} else {
			var str1=fn_trim(gcem_app_yyyymm_3.Text);
			if (str1.length != 6) {
				alert("적용년월을 입력해주세요");
			}else{
				ln_Report_3_1();
				//ln_Report_5_2();
				gcrp_print3.preview();
			}
		}
	}	else if (nwgubun.value=='6_1') {
		//	alert("5555");
		if (gcds_grid_ec06az.countrow<1) {
		alert("출력하실 정보가 없습니다");
		} else {
			var str1=fn_trim(gcem_yyyymm62.Text);	//text box name 바꿔야함
			if (str1.length != 6) {
				alert("지급년월 2번째 입력란이 기준년월입니다.\n입력해주세요");
			}else{
			//	ln_Report_6_1();		레포트작성
			//	if(ln_Report_6_2())
				//	gcrp_print6.preview();
			}
		}
	} else if (nwgubun.value=='7_1') { //당월급여 변동자
		if (gcds_change_7.countrow<1) {
		alert("출력하실 정보가 없습니다");
		} else {
			var str1=fn_trim(gcem_app_yyyymm_7.Text);	//text box name 바꿔야함
			if (str1.length != 6) {
				alert("지급년월 2번째 입력란이 기준년월입니다.\n입력해주세요");
			}else{
				ln_Report_7_1();	
				gcrp_print7.preview();
			}
		}
	}
}

/*******************************************************************************
  Description : 엑셀 - 급여변동현황
******************************************************************************/
function ln_Excel(){
  if(nwgubun.value=="4_1"){
		if (gcds_grid_ec04az.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_create4_1.RunExcel('급여지급현황');
	}else if(nwgubun.value=="5_1"){
	   ln_Excel_Query();
	}else if(nwgubun.value=="3_1"){
		if (gcds_grid_ec03az.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_create3_1.RunExcel('급여변동내역');
	}else if(nwgubun.value=="6_1"){
		ln_Excel_Query2();
	}
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_visible_hidden(Obj){
	
	var lib_com= new Array("gcgd_create1_1","gcgd_create2_1","gcgd_create3_1","gcgd_create4_1","gcgd_create5_1","gcgd_create6_1","gcgd_create7_1");
	var lib_total= new Array("gcgd_create1_1","gcgd_create2_2","gcgd_create3_1","gcgd_create4_2","gcgd_create5_2","gcgd_create6_2","gcgd_create7_1");

	for(i=0;i<lib_com.length;i++) {
		if("gcgd_create"+Obj==lib_com[i]) {
			eval("document.all."+lib_com[i]+".style.display='block';");
			eval("document.all."+lib_total[i]+".style.display='block';");
		}	else {
			eval("document.all."+lib_com[i]+".style.display='none';");
			eval("document.all."+lib_total[i]+".style.display='none';");
		}
	}
	
	for(i=1;i<=7;i++){
		if(Obj.substring(0,1)==(""+i)){
				eval("document.all.gcgd_create"+i+".style.display='block';");
		}	else {
				eval("document.all.gcgd_create"+i+".style.display='none';");
		}
	 }
    
	if(Obj=="4_1" || Obj=="5_1" || Obj=="6_1") {	
		document.all.ft_div1.style.display="none";
		document.all.ft_div2.style.display="none";
		document.all.ft_div3.style.display="block";

		gcds_pyo4.namevalue(1,"param5")="0";
		//gcds_pyo4.namevalue(1,"param6")="건강보험계";
		gcds_pyo4.namevalue(1,"param7")="0";
		//gcds_pyo4.namevalue(1,"param8")="소득세계";
		gcds_pyo4.namevalue(1,"param9")="0";

		gcds_pyo4.namevalue(2,"param1")="0";
		//gcds_pyo4.namevalue(2,"param2")="실지급액계";
		gcds_pyo4.namevalue(2,"param3")="0";
		//gcds_pyo4.namevalue(2,"param4")="상여계";
		gcds_pyo4.namevalue(2,"param5")="0";
		//gcds_pyo4.namevalue(2,"param6")="국민연금계";
		gcds_pyo4.namevalue(2,"param7")="0";
		//gcds_pyo4.namevalue(2,"param8")="주민세계";
		gcds_pyo4.namevalue(2,"param9")="0";

		//gcds_pyo4.namevalue(3,"param4")="비과세계";
		gcds_pyo4.namevalue(3,"param5")="0";
		//gcds_pyo4.namevalue(3,"param6")="고용보험계";
		gcds_pyo4.namevalue(3,"param7")="0";
		//gcds_pyo4.namevalue(3,"param8")="공제계";
		gcds_pyo4.namevalue(3,"param9")="0";
		gcds_pyo4.RowPosition = 4;


		gcds_pyo5.namevalue(1,"param5")="0";
		//gcds_pyo5.namevalue(1,"param6")="건강보험계";
		gcds_pyo5.namevalue(1,"param7")="0";
		//gcds_pyo5.namevalue(1,"param8")="소득세계";
		gcds_pyo5.namevalue(1,"param9")="0";

		gcds_pyo5.namevalue(2,"param1")="0";
		//gcds_pyo5.namevalue(2,"param2")="실지급액계";
		gcds_pyo5.namevalue(2,"param3")="0";
		//gcds_pyo5.namevalue(2,"param4")="상여계";
		gcds_pyo5.namevalue(2,"param5")="0";
		//gcds_pyo5.namevalue(2,"param6")="국민연금계";
		gcds_pyo5.namevalue(2,"param7")="0";
		//gcds_pyo5.namevalue(2,"param8")="주민세계";
		gcds_pyo5.namevalue(2,"param9")="0";

		//gcds_pyo5.namevalue(3,"param4")="비과세계";
		gcds_pyo5.namevalue(3,"param5")="0";
		//gcds_pyo5.namevalue(3,"param6")="고용보험계";
		gcds_pyo5.namevalue(3,"param7")="0";
		//gcds_pyo5.namevalue(3,"param8")="공제계";
		gcds_pyo5.namevalue(3,"param9")="0";
		gcds_pyo5.RowPosition = 4;


		//급여소득총액
		gcds_pyo6.namevalue(1,"param5")="0";
		//gcds_pyo4.namevalue(1,"param6")="건강보험계";
		gcds_pyo6.namevalue(1,"param7")="0";
		//gcds_pyo4.namevalue(1,"param8")="소득세계";
		gcds_pyo6.namevalue(1,"param9")="0";

		gcds_pyo6.namevalue(2,"param1")="0";
		//gcds_pyo4.namevalue(2,"param2")="실지급액계";
		gcds_pyo6.namevalue(2,"param3")="0";
		//gcds_pyo4.namevalue(2,"param4")="상여계";
		gcds_pyo6.namevalue(2,"param5")="0";
		//gcds_pyo4.namevalue(2,"param6")="국민연금계";
		gcds_pyo6.namevalue(2,"param7")="0";
		//gcds_pyo4.namevalue(2,"param8")="주민세계";
		gcds_pyo6.namevalue(2,"param9")="0";

		//gcds_pyo4.namevalue(3,"param4")="비과세계";
		gcds_pyo6.namevalue(3,"param5")="0";
		//gcds_pyo4.namevalue(3,"param6")="고용보험계";
		gcds_pyo6.namevalue(3,"param7")="0";
		//gcds_pyo4.namevalue(3,"param8")="공제계";
		gcds_pyo6.namevalue(3,"param9")="0";
		gcds_pyo6.RowPosition = 4;
	}	else 	{ 
		if(Obj=="2_1"){
		document.all.ft_div1.style.display="none";
		document.all.ft_div2.style.display="block";
		document.all.ft_div3.style.display="none";
		
		}else	{      //3_1,1_1
		document.all.ft_div1.style.display="block";
		document.all.ft_div2.style.display="none";
		document.all.ft_div3.style.display="none";
		
		}
	}
	if(Obj=="3_1") document.all.excel_btn_id.style.visibility="visible";
	else document.all.excel_btn_id.style.visibility="hidden";
   
	 gcds_grid_ec03az.clearData();
   gcds_grid_ec04az.clearData();
   gcds_grid_ec05az.clearData();
	 gcds_grid_ec06az.clearData();

   ft_cnt1.innerText = "";
   ft_cnt2.innerText = "";
   ft_cnt3.innerText = "";
	 //ft_cnt6.innerText = "";

	 gclx_select_jigub3.index=0; //지급구분3
	 gclx_select_jigub4.index=0; //지급구분4
	 gclx_select_jigub5.index=0; //지급구분5
	 gclx_select_jigub6.index=0; //지급구분6

	 gclx_select_div3.index=0; //소속구분3
	 gclx_select_div4.index=0; //소속구분4
	 gclx_select_div5.index=0; //소속구분5

	 gclx_select_div6.index=0; //재직구분6
	 gclx_ord_7.index=0; //발령

   gclx_select_ec03az_3.index=0; //직군구분
	 gclx_select_group4.index=0;
	 gclx_select_group5.index=0;

   gclx_select_position4.index=0; //직위구분
   gclx_select_position5.index=0;

   gclx_select_grade4.index=0;		//직급구분
   gclx_select_grade5.index=0;

}

/*******************************************************************************
  Description : 엑셀
******************************************************************************/
function ln_Excel_bank(){
	
	var str1 =fn_trim(gcem_app_yyyymm_3.Text);
	var str2 =fn_trim(gclx_select_ec01az_3.BindColVal);

	gcds_excel.DataID = "/servlet/Contract.h100009_s12?v_str1="+str1+"&v_str2="+str2;
	//prompt('',gcds_excel.DataID);
	
	gcds_excel.Reset(); 

}


/*******************************************************************************
  Description : 출력물 TITLE 변경
******************************************************************************/
function ln_Print_title(){
var strTitle = fn_trim(gclx_select_jigub4.bindcolval);
 var strTitlenm = fn_trim(gclx_select_jigub4.text);
	//alert("strTitle" + strTitle + "   strTitlenm   "+strTitlenm);
  if (strTitle==1){
		gcds_report0.namevalue(1,"CTITLE") = "계약직";	
	}else if (strTitle==5) {
    gcds_report0.namevalue(1,"CTITLE") = "상여";
	}	else if (strTitle=='T') {
	   //alert(strTitlenm);
    gcds_report0.namevalue(1,"CTITLE") = "계약직 급여지급현황";
	}else if (strTitle=='K') {
	   //alert(strTitlenm);
    gcds_report0.namevalue(1,"CTITLE") = "격려금";
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_pyo4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 임시 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_pyo5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 임시 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_pyo6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 임시 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 지급구분 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 소속구분 DataSet-->
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec03az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 직군 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec04az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 직위 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec05az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 직급 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec06az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 급여항목 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec08az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 이체 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec02az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec03az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec04az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec05az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec06az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SortExpr     value="+TREECD">
  <param name=SubsumExpr   value="1:TREECD">
<PARAM NAME="SyncLoad" VALUE="true"><!-- REPORT조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_excel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_excel_5_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 소속별급여지급현황 Excel DataSet--> 
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_excel03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 급여변동현황 Excel DataSet--> 
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_excel_6_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 급여소득총액 Excel DataSet--> 
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_change_7 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 당월급여변동자--> 
</OBJECT></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_excel" event="OnLoadStarted()">
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_excel" event="onloadcompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	if (gcds_excel.countrow<1) alert("다운로드하실 자료가 없습니다.");
	//else gcgd_excel.RunExcel('계좌관리');
 else gcgd_excel.RunExcel('계좌관리');
</script>

<script language=javascript for=gcgd_create4_2 event=OnScrolling(row,col,bymethod)>
	if(!bymethod)
	gcgd_create4_1.SetScrolling(row,(col + 5));
</script>

<script language=javascript for=gcgd_create5_2 event=OnScrolling(row,col,bymethod)>
	if(!bymethod)
	gcgd_create5_1.SetScrolling(row,(col + 3));
</script>

<script language=javascript for=gcgd_create6_2 event=OnScrolling(row,col,bymethod)>
	if(!bymethod)
	gcgd_create6_1.SetScrolling(row,(col + 7));
</script>

<script language="javascript" for="gcds_grid_ec01az" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt1.innerText="데이타 조회중입니다.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec01az.countrow <=0)
			alert("조회된 데이타가 없습니다.");

	nwgubun.disabled=false;
</script>

<script language="javascript" for="gcds_grid_ec02az" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt2.innerText="데이타 조회중입니다.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec02az" event="onloadcompleted(row,colid)">
	ft_cnt2.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec02az.countrow <=0)
			alert("조회된 데이타가 없습니다.");
	nwgubun.disabled=false;
</script>

<script language="javascript" for="gcds_grid_ec03az" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt1.innerText="데이타 조회중입니다.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec03az" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec03az.countrow <=0)
			alert("조회된 데이타가 없습니다.");
	nwgubun.disabled=false;
</script>

<script language="javascript" for="gcds_grid_ec04az" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt3.innerText="데이타 조회중입니다.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec04az" event="onloadcompleted(row,colid)">
	nwgubun.disable=true;
	ft_cnt3.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec04az.countrow <=0)
			alert("조회된 데이타가 없습니다.");
	else
	{
		//gcds_pyo4.namevalue(1,"param1")="총계";
		//gcds_pyo4.namevalue(1,"param4")="급여계";
		gcds_pyo4.namevalue(1,"param5")=gcds_grid_ec04az.Sum(7,0,0)+"";
		//gcds_pyo4.namevalue(1,"param6")="건강보험계";
		gcds_pyo4.namevalue(1,"param7")=gcds_grid_ec04az.Sum(10,0,0)+"";
		//gcds_pyo4.namevalue(1,"param8")="소득세계";
		gcds_pyo4.namevalue(1,"param9")=gcds_grid_ec04az.Sum(13,0,0)+"";

		gcds_pyo4.namevalue(2,"param1")=gcds_grid_ec04az.countRow;
		//gcds_pyo4.namevalue(2,"param2")="실지급액계";
		gcds_pyo4.namevalue(2,"param3")=gcds_grid_ec04az.Sum(16,0,0)+"";
		//gcds_pyo4.namevalue(2,"param4")="상여계";
		gcds_pyo4.namevalue(2,"param5")=gcds_grid_ec04az.Sum(8,0,0)+"";
		//gcds_pyo4.namevalue(2,"param6")="국민연금계";
		gcds_pyo4.namevalue(2,"param7")=gcds_grid_ec04az.Sum(11,0,0)+"";
		//gcds_pyo4.namevalue(2,"param8")="주민세계";
		gcds_pyo4.namevalue(2,"param9")=gcds_grid_ec04az.Sum(14,0,0)+"";

		//gcds_pyo4.namevalue(3,"param4")="비과세계";
		gcds_pyo4.namevalue(3,"param5")=gcds_grid_ec04az.Sum(9,0,0)+"";
		//gcds_pyo4.namevalue(3,"param6")="고용보험계";
		gcds_pyo4.namevalue(3,"param7")=gcds_grid_ec04az.Sum(12,0,0)+"";
		//gcds_pyo4.namevalue(3,"param8")="공제계";
		gcds_pyo4.namevalue(3,"param9")=gcds_grid_ec04az.Sum(15,0,0)+"";
		gcds_pyo4.RowPosition = 4;
	}
	nwgubun.disabled=false;
</script>

<script language="javascript" for="gcds_grid_ec05az" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt3.innerText="데이타 조회중입니다.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec05az" event="onloadcompleted(row,colid)">
	ft_cnt3.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec05az.countrow <=0)
			alert("조회된 데이타가 없습니다.");
	else
	{
		//gcds_pyo5.namevalue(1,"param1")="총계";
		//gcds_pyo5.namevalue(1,"param4")="급여계";
		gcds_pyo5.namevalue(1,"param5")=gcds_grid_ec05az.Sum(5,0,0)+"";
		//gcds_pyo5.namevalue(1,"param6")="건강보험계";
		gcds_pyo5.namevalue(1,"param7")=gcds_grid_ec05az.Sum(8,0,0)+"";
		//gcds_pyo5.namevalue(1,"param8")="소득세계";
		gcds_pyo5.namevalue(1,"param9")=gcds_grid_ec05az.Sum(11,0,0)+"";

		gcds_pyo5.namevalue(2,"param1")=gcds_grid_ec05az.countRow;
		//gcds_pyo5.namevalue(2,"param2")="실지급액계";
		gcds_pyo5.namevalue(2,"param3")=gcds_grid_ec05az.Sum(14,0,0)+"";
		//gcds_pyo5.namevalue(2,"param4")="상여계";
		gcds_pyo5.namevalue(2,"param5")=gcds_grid_ec05az.Sum(6,0,0)+"";
		//gcds_pyo5.namevalue(2,"param6")="국민연금계";
		gcds_pyo5.namevalue(2,"param7")=gcds_grid_ec05az.Sum(9,0,0)+"";
		//gcds_pyo5.namevalue(2,"param8")="주민세계";
		gcds_pyo5.namevalue(2,"param9")=gcds_grid_ec05az.Sum(12,0,0)+"";

		//gcds_pyo5.namevalue(3,"param4")="비과세계";
		gcds_pyo5.namevalue(3,"param5")=gcds_grid_ec05az.Sum(7,0,0)+"";
		//gcds_pyo5.namevalue(3,"param6")="고용보험계";
		gcds_pyo5.namevalue(3,"param7")=gcds_grid_ec05az.Sum(10,0,0)+"";
		//gcds_pyo5.namevalue(3,"param8")="공제계";
		gcds_pyo5.namevalue(3,"param9")=gcds_grid_ec05az.Sum(13,0,0)+"";
		gcds_pyo5.RowPosition = 4;
	}
	nwgubun.disabled=false;
</script>

<!-- 급여 소득 총액 END -->
<script language="javascript" for="gcds_grid_ec06az" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt3.innerText="데이타 조회중입니다.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec06az" event="onloadcompleted(row,colid)">
	nwgubun.disable=true;
	ft_cnt3.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec06az.countrow <=0)
			alert("조회된 데이타가 없습니다.");
	else
	{
		//gcds_pyo6.namevalue(1,"param1")="총계";
		//gcds_pyo6.namevalue(1,"param4")="급여계";
		gcds_pyo6.namevalue(1,"param5")=gcds_grid_ec06az.Sum(7,0,0)+"";
		//gcds_pyo6.namevalue(1,"param6")="건강보험계";
		gcds_pyo6.namevalue(1,"param7")=gcds_grid_ec06az.Sum(10,0,0)+"";
		//gcds_pyo6.namevalue(1,"param8")="소득세계";
		gcds_pyo6.namevalue(1,"param9")=gcds_grid_ec06az.Sum(13,0,0)+"";

		gcds_pyo6.namevalue(2,"param1")=gcds_grid_ec06az.countRow;
		//gcds_pyo6.namevalue(2,"param2")="실지급액계";
		gcds_pyo6.namevalue(2,"param3")=gcds_grid_ec06az.Sum(16,0,0)+"";
		//gcds_pyo6.namevalue(2,"param4")="상여계";
		gcds_pyo6.namevalue(2,"param5")=gcds_grid_ec06az.Sum(8,0,0)+"";
		//gcds_pyo6.namevalue(2,"param6")="국민연금계";
		gcds_pyo6.namevalue(2,"param7")=gcds_grid_ec06az.Sum(11,0,0)+"";
		//gcds_pyo6.namevalue(2,"param8")="주민세계";
		gcds_pyo6.namevalue(2,"param9")=gcds_grid_ec06az.Sum(14,0,0)+"";

		//gcds_pyo6.namevalue(3,"param4")="비과세계";
		gcds_pyo6.namevalue(3,"param5")=gcds_grid_ec06az.Sum(9,0,0)+"";
		//gcds_pyo6.namevalue(3,"param6")="고용보험계";
		gcds_pyo6.namevalue(3,"param7")=gcds_grid_ec06az.Sum(12,0,0)+"";
		//gcds_pyo6.namevalue(3,"param8")="공제계";
		gcds_pyo6.namevalue(3,"param9")=gcds_grid_ec06az.Sum(15,0,0)+"";
		gcds_pyo6.RowPosition = 4;
	}
	nwgubun.disabled=false;
	// alert("!!!");
</script>
<!-- 급여 소득 총액 END -->

<!-- 당월급여변동자 -->
<script language="javascript" for="gcds_change_7" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt1.innerText="데이타 조회중입니다.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_change_7" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_change_7.countrow <=0)
			alert("조회된 데이타가 없습니다.");
	nwgubun.disabled=false;
</script>
<!-- 당월급여변동자 END -->

<script language="javascript" for="gcds_select_ec01az" event="onloadCompleted(row,colid)">
  
	gclx_select_jigub3.index=0; //지급구분3
	gclx_select_jigub4.index=0; //지급구분4
	gclx_select_jigub5.index=0; //지급구분5
	gclx_select_jigub6.index=0; //지급구분6
  
//	gcds_select_ec01az.DeleteRow(2);
//	gcds_select_ec01az.DeleteRow(2);
//	gcds_select_ec01az.DeleteRow(2);

</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.InsertRow(1);
	gcds_dept.NameValue(1,"DEPTCD")="";
	gcds_dept.NameValue(1,"DEPTNM")="전체";
	gclx_select_div3.index=0; //소속구분3
	gclx_select_div4.index=0; //소속구분4
	gclx_select_div5.index=0; //소속구분5
	gclx_select_div7.index=0; //소속구분7
</script>

<script language="javascript" for="gcds_select_ec03az" event="onloadCompleted(row,colid)">
	gcds_select_ec03az.InsertRow(1); //직군
	gcds_select_ec03az.NameValue(1,"MINORCD")="";
	gcds_select_ec03az.NameValue(1,"MINORNM")="전체";
	gclx_select_ec03az_3.index=0;
	gclx_select_group4.index=0;
	gclx_select_group5.index=0;
</script>

<script language="javascript" for="gcds_select_ec04az" event="onloadCompleted(row,colid)">
	gcds_select_ec04az.InsertRow(1);
	gcds_select_ec04az.NameValue(1,"MINORCD")="";
	gcds_select_ec04az.NameValue(1,"MINORNM")="전체";
	//직위 전체가 포함되어있음
	//gclx_select_ec04az.index=0;
	gclx_select_position4.index=0;
	gclx_select_position5.index=0;
	gclx_select_position7.index=0;
</script>

<script language="javascript" for="gcds_select_ec05az" event="onloadCompleted(row,colid)">
	gcds_select_ec05az.InsertRow(1);
	gcds_select_ec05az.NameValue(1,"MINORCD")="";
	gcds_select_ec05az.NameValue(1,"MINORNM")="전체";
	//gclx_select_ec05az.index=0;
	gclx_select_grade4.index=0;
	gclx_select_grade5.index=0;
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_select_ec01az" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dept" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_ec03az" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_ec04az" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>


<!--소속별급여지급현황 Excel -->
<script language="javascript" for="gcds_excel_5_1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_excel_5_1" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
</script>

<!--급여소득총액 Excel -->
<script language="javascript" for="gcds_excel_6_1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_excel_6_1" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_report0" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_report0" event="onloadCompleted(row,colid)">

	if(nwgubun.value=="4_1"){ //급여지급현황
		ln_Print_title();
	}

	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_report0.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_select_div4 event=onSelChange()>
	gs_level	= '';
	gs_treecd =	'';
	gs_level	= gclx_select_div4.ValueOfIndex ("level", gclx_select_div4.Index);
	gs_treecd = gclx_select_div4.ValueOfIndex ("treecd", gclx_select_div4.Index);
	gs_treecd = fn_treecd(gs_level, gs_treecd);
</script>

<script language=JavaScript for=gclx_select_div7 event=onSelChange()>
	gs_level	 = '';
	gs_treecd  = '';
	gs_level	 = gclx_select_div7.ValueOfIndex("level", gclx_select_div7.Index);
	gs_treecd  = gclx_select_div7.ValueOfIndex("treecd", gclx_select_div7.Index);
	gs_treecd  = fn_treecd(gs_level, gs_treecd);
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
			B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif" ><img src="../img/p020007_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<nobr>	    
			 <img id=excel_btn_id src="../../Common/img/btn/com_b_bank.gif" style="visible:hidden;cursor:hand" onclick="ln_Excel_bank()"> 
			 <img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print()">
			 <img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel()">
			 <img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()"> 
			&nbsp;</nobr>
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
	<table  cellpadding="0" cellspacing="0" border="0">
    <tr><td width=140 valign=top>
			<table cellpadding="0" cellspacing="0" border="0" style='width:125px;height:62px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
				<tr> 
					<td align=center  style="height:30px;border:0 solid #708090;border-bottom-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;출력구분&nbsp;</nobr></td><tr>
				<tr> 
					<td align=center  style="border:0 solid #708090;"><nobr>&nbsp;
						<SELECT id="nwgubun" name=소속별"nwgubun" style="width:122px;" onchange="ln_visible_hidden(this.value);">
							<option value="4_1">급여 지급현황</option>
							<option value="5_1">소속별 급여현황</option>
							<option value="3_1">급여 변동현황</option>
							<option value="6_1">급여 소득총액</option>
							<option value="7_1">당월급여변동자</option>
						</SELECT>&nbsp;</nobr></td></tr></table></td>
          <td valign=top><nobr>
					<DIV ID="gcgd_create1" STYLE="display:block;"></div>
					<DIV ID="gcgd_create2" STYLE="display:block;"></div>

<DIV ID="gcgd_create3" STYLE="display:block;">
	<table  cellpadding="0" cellspacing="0" border="0" style='width:737px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
		<tr> 
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee">
				<nobr>&nbsp;적용년월&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;border-bottom-width:1px"><nobr>&nbsp;
				<comment id="__NSID__"><OBJECT id=gcem_app_yyyymm_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=True>
					<param name=ClipMode			value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM">
					<param name=MaxLength     value=6>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
			</td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-left:3px;padding-right:3px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;지급구분&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-top:2px;border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_ec01az_3  name="gclx_select_jigub3" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:75px;height:200px;">
         	<param name=CBData					value="T^계약급여00,K^특별상여">					
					<param name=ComboDataID			value=gcds_select_ec01az>
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="false">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
			</td>

			<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;padding-left:3px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;소속&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-top:2px;border-top-width:0px;border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_div3  name="gclx_select_div3" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
					<param name=ComboDataID			value=gcds_dept>
					<param name=SearchColumn		value="DEPTCD^DEPTNM">
					<param name=Sort            value="false">
					<param name=SortColumn			value="DEPTCD">
					<param name=ListExprFormat	value="DEPTNM^0^160">
					<param name=BindColumn			value="DEPTCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
			</td>
			<td width="0" align=lefT style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr >&nbsp;직군&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_ec03az_3  name="gclx_select_ec03az_3" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 
				style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
					<param name=ComboDataID			value=gcds_select_ec03az>
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
			</td>
			<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff" ><nobr>&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-bottom-width:1px">&nbsp;</td>
			<td width="100%" align=RIGHT  style="height:30px;border:0 solid #708090;border-bottom-width:1px">&nbsp;&nbsp;</td>
		</tr>
		<tr> 
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;" bgcolor="#FFFFFF"><nobr>&nbsp;&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:0px;border-top-width:0px;"><nobr>&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;padding-left:3px;" bgcolor="#FFFFFF"><nobr>&nbsp;&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-top-width:0px;"><nobr>&nbsp;</nobr></td>
			<td width="0" align=lefT style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;" bgcolor="#FFFFFF"><nobr >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;"><nobr>&nbsp;</nobr></td>
			<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;" bgcolor="#FFFFFF" ><nobr>&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-top-width:0px;" colspan=3>&nbsp;</td>
			<td width="100%" style="height:30px;border:0 solid #708090;border-top-width:0px;" align=RIGHT >&nbsp;&nbsp;</td>
		</tr>
</table>
</div>
<!--년간월별소득현황,년간소득집계현황-->

<!--급여지급현황-->
<DIV ID="gcgd_create4" STYLE="display:block;">
	<table  cellpadding="0" cellspacing="0" border="0" style='width:737px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
		<tr> 
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;지급년월&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;border-bottom-width:1px;"><nobr>
    <table cellpadding=0 cellspacing=0>
			<tr>
				<td><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_yyyymm41 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment			value=0>
						<param name=Border	      value=True>
						<param name=ClipMode			value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="YYYY/MM">
						<param name=MaxLength     value=8>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr></td><td>~</td>
				<td><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_yyyymm42 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment	  value=0>
						<param name=Border	      value=True>
						<param name=ClipMode	  value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="YYYY/MM">
						<param name=MaxLength     value=8>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
				</td>
			</tr>
		</table></nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee">
				<nobr>&nbsp;지급구분&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;padding-top:2px;"><nobr>
        <table cellpadding=0 cellspacing=0 border=0>
					<tr>
						<td><nobr>
							<comment id="__NSID__"><OBJECT id=gclx_select_jigub4  name="gclx_select_jigub4" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
								<param name=ComboDataID			value=gcds_select_ec01az>
								<param name=SearchColumn		value="MINORCD^MINORNM">
								<param name=Sort            value="false">
								<param name=SortColumn			value="MINORCD">
								<param name=ListExprFormat	value="MINORNM">
								<param name=BindColumn			value="MINORCD">
							</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
						</td>
					</tr>
				</table></nobr></td>
            <td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;"><nobr>&nbsp;&nbsp;</nobr></td>
						<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;"><nobr>&nbsp;&nbsp;</nobr></td>
						<td width="0" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;"><nobr >&nbsp;&nbsp;</nobr></td>
						<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;"><nobr>&nbsp;</nobr></td>
						<td width="0" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;"><nobr >&nbsp;&nbsp;</nobr></td>
						<td style="height:30px;border:0 solid #708090;border-bottom-width:1px;">&nbsp;</td>
						<td width="100%" align=RIGHT  style="height:30px;border:0 solid #708090;border-bottom-width:1px;">&nbsp;&nbsp;</td>
					</tr>
        <tr> 
					<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;소속&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-right-width:1px;"><nobr>
						<comment id="__NSID__"><OBJECT id=gclx_select_div4  name="gclx_select_div4" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
							<param name=ComboDataID			value=gcds_dept>
							<param name=SearchColumn		value="DEPTCD^DEPTNM">
							<param name=Sort            value="false">
							<param name=SortColumn			value="DEPTCD">
							<param name=ListExprFormat	value="DEPTNM^0^160">
							<param name=BindColumn			value="DEPTCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
          <td width="0" align=left style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr >&nbsp;직군&nbsp;</nobr></td>
          <td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>
						<comment id="__NSID__"><OBJECT id=gclx_select_group4   name="gclx_select_group4" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value=gcds_select_ec03az>
							<param name=SearchColumn		value="MINORCD^MINORNM">
							<param name=Sort            value="TRUE">
							<param name=SortColumn			value="MINORCD">
							<param name=ListExprFormat	value="MINORNM">
							<param name=BindColumn			value="MINORCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
          <td width="0" align=left style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr >&nbsp;직위&nbsp;</nobr></td>
          <td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>
						<comment id="__NSID__"><OBJECT id=gclx_select_position4  name="gclx_select_position4" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value=gcds_select_ec04az>
							<param name=SearchColumn		value="MINORCD^MINORNM">
							<param name=Sort            value="TRUE">
							<param name=SortColumn			value="MINORCD">
							<param name=ListExprFormat	value="MINORNM^0^150">
							<param name=BindColumn			value="MINORCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
					</td>
          <td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;" bgcolor="#eeeeee" ><nobr>&nbsp;직급&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-top-width:0px;" colspan=3><nobr>
						<comment id="__NSID__"><OBJECT id=gclx_select_grade4  name="gclx_select_grade4" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:70px;height:200px;">
							<param name=ComboDataID			value=gcds_select_ec05az>
							<param name=SearchColumn		value="MINORCD^MINORNM">
							<param name=Sort            value="TRUE">
							<param name=SortColumn			value="MINORCD">
							<param name=ListExprFormat	value="MINORNM">
							<param name=BindColumn			value="MINORCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
					<td width="10" align=left style="height:30px;border:0 solid #708090;border-right-width:0px;" ><nobr>&nbsp;&nbsp;</nobr></td>
				</tr>
			</table>
</div>

<!-- 급여 소득 총액 [검색]-->
<DIV ID="gcgd_create6" STYLE="display:block;">
	<table  cellpadding="0" cellspacing="0" border="0" style='width:737px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
		<tr> 
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee">
				<nobr>&nbsp;적용년월&nbsp;&nbsp;</nobr></td>
				<td style="height:30px;border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_yyyymm61 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment			value=0>
						<param name=Border	      value=True>
						<param name=ClipMode			value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="YYYY/MM">
						<param name=MaxLength     value=8>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr></td><td style="height:30px;border:0 solid #708090;border-bottom-width:1px;">~&nbsp;</td>
				<td style="height:30px;border:0 solid #708090;border-bottom-width:1px;"><nobr>
					<comment id="__NSID__"><OBJECT id=gcem_yyyymm62 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment			value=0>
						<param name=Border	      value=True>
						<param name=ClipMode			value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="YYYY/MM">
						<param name=MaxLength     value=8>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
				</td>
			<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-left-width:1px;padding-left:0px;padding-right:3px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;지급구분&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-top:2px;border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_ec01az_6  name="gclx_select_jigub6" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:75px;height:200px;">
				<!--	<param name=CBData					value="0^전체,1^정기급여,5^상여급여">
					<param name=CBDataColumns		value="MINORCD,MINORNM">
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM">
					<param name=BindColumn			value="MINORCD">-->
					<param name=ComboDataID			value=gcds_select_ec01az>
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="false">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
			</td>
			<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;padding-left:3px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;재직구분&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-bottom-width:1px;padding-top:2px;border-top-width:0px;border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_div6  name="gclx_select_div6" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
					<param name=CBData					value="0^전체,1^재직자,3^퇴직자">
					<param name=CBDataColumns		value="MINORCD,MINORNM">
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
			</td>
			<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff" ><nobr>&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-bottom-width:1px">&nbsp;</td>
			<td width="100%" align=RIGHT  style="height:30px;border:0 solid #708090;border-bottom-width:1px">&nbsp;</td>
		</tr>
		<tr> 
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;소속&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;" colspan="3"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_div7 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
					<param name=ComboDataID			value=gcds_dept>
					<param name=SearchColumn		value="DEPTCD^DEPTNM">
					<param name=Sort            value="false">
					<param name=SortColumn			value="DEPTCD">
					<param name=ListExprFormat	value="DEPTNM^0^160">
					<param name=BindColumn			value="DEPTCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
			<td width="0" align=left style="height:30px;border:0 solid #708090;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee"><nobr >&nbsp;직위&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;" colspan="4"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_position7 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:140px;height:200px;">
					<param name=ComboDataID			value=gcds_select_ec04az>
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM^0^150">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
		</tr>
	</table>
</div>
<!-- 급여 소득 총액 END -->

<!--당월급여변동자//////////////////////////////////////////////////////////////////////////////////////////////////-->
<DIV ID="gcgd_create7" STYLE="display:none;">
	<table  cellpadding="0" cellspacing="0" border="0" style='width:737px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
		<tr> 
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee">
				<nobr>&nbsp;적용년월&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;border-bottom-width:1px"><nobr>&nbsp;
				<comment id="__NSID__"><object id=gcem_app_yyyymm_7 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative;left:1px;top:1px;width:50px;height:20px;font-family:굴림;font-size:9pt;z-index:2;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=True>
					<param name=ClipMode			value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM">
					<param name=MaxLength     value=6>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
			</td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-left:3px;padding-right:3px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;지급구분&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-top:2px;border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><object id=gclx_select_7  name="gclx_select_jigub3" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:75px;height:200px;">
					<param name=ComboDataID			value=gcds_select_ec01az>
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM^0^150">
					<param name=BindColumn			value="MINORCD">
				</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
			</td>
     <td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-left:3px;padding-right:3px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;발령구분&nbsp;</nobr></td>	
		 <td style="height:30px;border:0 solid solid #708090;border-right-width:0px;padding-top:2px;border-bottom-width:1px"><nobr>
				<comment id="__NSID__">
					<object  id=gclx_ord_7 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 	style="position:relative;left:2px;top:0px;font-size:12px;width:100px;">
							<param name=CBData			   value="A^전체,A1^입사,A2^퇴사,A3^부임,A4^복귀,A5^기타">
							<param name=CBDataColumns	 value="CODE,NAME">
							<param name=SearchColumn	 value=NAME>
							<param name=Sort			     value=false>
							<param name=ListExprFormat value="NAME^0^100">								
							<param name=BindColumn		 value="CODE">
					</object></comment><script>__ws__(__NSID__);</script> 	
			</td>
			<td width="100%" align=RIGHT  style="height:30px;border:0 solid #708090;border-bottom-width:1px">&nbsp;&nbsp;</td>
    </tr>
		<tr> 
		  <td width="0" align=lefT style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;" bgcolor="#FFFFFF"><nobr >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;" bgcolor="#FFFFFF"><nobr>&nbsp;&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:0px;border-top-width:0px;"><nobr>&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;padding-left:3px;" bgcolor="#FFFFFF"><nobr>&nbsp;&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:0px;border-top-width:0px;"><nobr>&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;padding-left:3px;" bgcolor="#FFFFFF"><nobr>&nbsp;&nbsp;</nobr></td>	
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-top-width:0px;"><nobr>&nbsp;</nobr></td>
		
		</tr>
</table>
</DIV>
<!--당월급여변동자 END-->


<!--소속별 지급현황 검색키워드-->
<DIV ID="gcgd_create5" STYLE="display:block;">   
	<table  cellpadding="0" cellspacing="0" border="0" style='width:737px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
    <tr> 
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;지급년월&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;border-bottom-width:1px;"><nobr>
        <table cellpadding=0 cellspacing=0><tr><td><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_yyyymm51 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment	  value=0>
						<param name=Border	      value=True>
						<param name=ClipMode	  value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="YYYY/MM">
						<param name=MaxLength     value=8>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
			    </OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr></td><td>~</td>
				<td><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_yyyymm52 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment			value=0>
						<param name=Border	      value=True>
						<param name=ClipMode			value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="YYYY/MM">
						<param name=MaxLength     value=8>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
				</td>
			</tr>
		</table></nobr></td>	
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee">
					<nobr>&nbsp;지급구분&nbsp;</nobr></td>	
				<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;padding-top:2px;"><nobr>
    <table cellpadding=0 cellspacing=0 border=0>
			<tr>
				<td><nobr>
					<comment id="__NSID__"><OBJECT id=gclx_select_jigub5  name="gclx_select_jigub5" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
						<param name=ComboDataID			value=gcds_select_ec01az>
						<param name=SearchColumn		value="MINORCD^MINORNM">
						<param name=Sort            value="false">
						<param name=SortColumn			value="MINORCD">
						<param name=ListExprFormat	value="MINORNM">
						<param name=BindColumn			value="MINORCD">
					</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
				</td>
			</tr>
		</table></nobr></td>
			<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;" ><nobr>&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;"><nobr>&nbsp;&nbsp;</nobr></td>
			<td width="0" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;"><nobr >&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;"><nobr>&nbsp;</nobr></td>
			<td width="0" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;"><nobr >&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-bottom-width:1px;">&nbsp;</td>
			<td width="100%" align=RIGHT  style="height:30px;border:0 solid #708090;border-bottom-width:1px;">&nbsp;&nbsp;</td>
		</tr>
		<tr> 
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;소속&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-right-width:1px;"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_div5  name="gclx_select_div5" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
					<param name=ComboDataID			value=gcds_dept>
					<param name=SearchColumn		value="DEPTCD^DEPTNM">
					<param name=Sort            value="false">
					<param name=SortColumn			value="DEPTCD">
					<param name=ListExprFormat	value="DEPTNM^0^160">
					<param name=BindColumn			value="DEPTCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
			<td width="0" align=left style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
				<nobr>&nbsp;직군&nbsp;</nobr></td>
      <td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_group5   name="gclx_select_group5" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
					<param name=ComboDataID			value=gcds_select_ec03az>
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
      <td width="0" align=left style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
				<nobr>&nbsp;직위&nbsp;</nobr></td>
      <td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_position5  name="gclx_select_position5" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
					<param name=ComboDataID			value=gcds_select_ec04az>
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM^0^150">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
			<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;" bgcolor="#eeeeee" ><nobr>&nbsp;직급&nbsp;</nobr></td>
			<td style="height:30px;border:0 solid #708090;border-top-width:0px;" colspan=3><nobr>
				<comment id="__NSID__"><OBJECT id=gclx_select_grade5  name="gclx_select_grade5" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:70px;height:200px;">
					<param name=ComboDataID			value=gcds_select_ec05az>
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
      <td width="10" align=left style="height:30px;border:0 solid #708090;border-right-width:0px;" ><nobr>&nbsp;&nbsp;</nobr></td></tr>				</table>
		</div></nobr>
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td colspan="2" height=3>
  </td></tr>
  <tr> 
    <td colspan="2"> 
      <table width="876" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:340px" valign=top>
						<DIV ID="gcgd_create1_1" STYLE="display:block;"> </div>
						<DIV ID="gcgd_create2_1" STYLE="display:block;">  </div>
						<DIV id=gcgd_create2_2 style="position:absolute;top:112px;left:347px;display:none"></div>
						<comment id="__NSID__"><OBJECT id=gcgd_create3_1 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  codebase="http://www.singiro.co.kr/Common/cab/toinbgrid.cab#version=1,1,0,135"  style="WIDTH: 875px; HEIGHT: 416px;border:1 solid #777777;display:block;" viewastext>
						  <PARAM NAME="DataID"			VALUE="gcds_grid_ec03az">
						  <PARAM NAME="Editable"		VALUE="false">
						  <PARAM NAME="BorderStyle" VALUE="0">
						  <PARAM NAME="viewSummary" VALUE="1">
							<PARAM name="Fillarea"		VALUE="true">
							<PARAM NAME="Format"			VALUE="  
								<FX> Name='＼    구분' ID=EXCSCR1  	HeadAlign=left HeadBgColor=#B9D4DC Width=65
										<G> Name='＼' ID=EXCSCR3  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65
											<C> Name='직위    ＼' ID=PAYGRDNM  	HeadAlign=right HeadBgColor=#B9D4DC Width=70 SumText='합계' SumBgColor=#C3D0DB   BgColor='#f5f5f5' align=LEFT </C> 
										</G>
								</FX>
								<FX> Name='05년 03월'   ID=PRVYYYYMM	HeadAlign=Center HeadBgColor=#B9D4DC 
										<C> Name='인원' ID=PRVNUM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50 BgColor='#f5f5f5' SumText=@sum SumBgColor=#C3D0DB align=RIGHT </C> 
										<C> Name='금액' ID=PRVAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 BgColor='#f5f5f5' SumText=@sum SumBgColor=#C3D0DB  align=RIGHT </C> 
								</FX>
								<FX> Name='05년 04월'    ID=NOWYYYYMM	HeadAlign=Center HeadBgColor=#B9D4DC 
										<C> Name='인원' ID=NEXNUM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50 BgColor='#f5f5f5' SumText=@sum SumBgColor=#C3D0DB  align=RIGHT </C> 
										<C> Name='금액' ID=NEXAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 BgColor='#f5f5f5' SumText=@sum SumBgColor=#C3D0DB  align=RIGHT </C> 
								</FX>
								<X> Name='증감내역'   	HeadAlign=Center HeadBgColor=#B9D4DC Width=65
										<G> Name='계' HeadAlign=Center HeadBgColor=#B9D4DC Width=65
										<C> Name='인원' ID=ITSNUM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=40 SumText=@sum SumBgColor=#C3D0DB   align=RIGHT </C> 
										<C> Name='금액' ID=ITSAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB  align=RIGHT </C> 
										</G>

										<G> Name='입사' HeadAlign=Center HeadBgColor=#B9D4DC Width=65
										<C> Name='인원' ID=IBSANUM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=30 SumText=@sum SumBgColor=#C3D0DB   align=RIGHT </C> 
										<C> Name='금액' ID=IBSAAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT </C> 
										</G>

										<G> Name='퇴사' HeadAlign=Center HeadBgColor=#B9D4DC Width=65
										<C> Name='인원' ID=TAENUM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=30 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT </C> 
										<C> Name='금액' ID=TAEAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT </C> 
										</G>

										<G> Name='승진' HeadAlign=Center HeadBgColor=#B9D4DC Width=65
										<C> Name='인원' ID=SUNGNUM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=30 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT </C> 
										<C> Name='금액' ID=SUNGAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										</G>

										<C> Name='계' ID=AA_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='기본' ID=A1_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='직책' ID=A2_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='시간외' ID=A3_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 SumText=@sum SumBgColor=#C3D0DB    align=RIGHT  </C> 
										<C> Name='근속\\수당' ID=A4_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='자 기\\계발비' ID=A5_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='가 족\\부양비' ID=A6_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB   align=RIGHT  </C> 

										<C> Name='차 량\\유지비' ID=A7_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='자격\\수당' ID=A8_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='개인\\연금' ID=A9_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='남북\\경협' ID=A10_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='특수지\\수 당' ID=A11_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB   align=RIGHT  </C> 
										<C> Name='지역근무\\수  당' ID=A12_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='휴  일\\근무수당' ID=A13_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='전월소급' ID=A14_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='임원직책' ID=A15_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 SumText=@sum SumBgColor=#C3D0DB  align=RIGHT  </C> 
										<C> Name='학자금' ID=A16_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
           
										<C> Name='출납수당' ID=A17_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
										<C> Name='운전수당' ID=A18_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
										<C> Name='연장수당' ID=A19_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
										<C> Name='사장단수당' ID=A20_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
										<C> Name='연차수당' ID=A21_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
										<C> Name='식대보조' ID=A22_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
										<C> Name='기타지급1' ID=A23_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
										<C> Name='기타지급2' ID=A24_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
										<C> Name='기타지급3' ID=A25_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  SumText=@sum SumBgColor=#C3D0DB align=RIGHT  </C> 
							</X>
								<C> Name='비고' ID=GODSCRSS  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=RIGHT  </C> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
<!-- 급여지급현황-->
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create4_1 codebase="http://www.singiro.co.kr/Common/cab/toinbgrid.cab#version=1,1,0,135"  style="WIDTH: 874px; HEIGHT: 356px;border:1 solid #777777;display:none;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_grid_ec04az">
              <PARAM NAME="Editable"		VALUE="False">
              <PARAM NAME="ColSizing"		VALUE="true">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="Format"			VALUE="  
								<FC> Name='소속' ID=DEPTNM BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=101 align=left  SumBgColor=#C3D0DB sort=true </FC> 
								<FC> Name='년월' ID=PAYDT BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=center  SumBgColor=#C3D0DB Value={Left(PAYDT,6)}  sort=true MASK='XXXX/XX'</FC> 
								<FC> Name='구분' ID=PAYDIVNM BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=center  SumBgColor=#C3D0DB sort=true  </FC> 
								<FC> Name='사번' ID=EMPNO BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center  SumBgColor=#C3D0DB sort=true  </FC> 
								<F> Name='성명' ID=EMPNMK BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=center SumBgColor=#C3D0DB  sort=true </F> 
								<C> Name='기본급'		ID=P10000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='상여' ID=P11000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB show=false</C>
								<C> Name='현장수당'			 ID=P30000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=right   </C> 
								<C> Name='북측근무수당'     ID=P31000   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=78  align=right   </C> 
								<C> Name='시간외'		ID=P12000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='건강보험' ID=B11000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='국민연금' ID=B12000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='고용보험' ID=B13000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='소득세'		ID=T11000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT  SumBgColor=#C3D0DB </C> 
								<C> Name='주민세'		ID=T12000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT  SumBgColor=#C3D0DB </C> 
								<C> Name='공제'			ID=S93000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=RIGHT  SumBgColor=#C3D0DB </C> 
								<c> Name='실지급액' ID=S94000   HeadAlign=Center HeadBgColor=#B9D4DC Width=110  align=RIGHT  SumBgColor=#C3D0DB </c> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>

						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create4_2  codebase="http://www.singiro.co.kr/Common/cab/toinbgrid.cab#version=1,1,0,135"   style="position:absolute;top:452px; left:0px;WIDTH: 874px; HEIGHT: 75px;border:1 solid #777777;border-top-width:1px;display:none;z-index:2" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_pyo4">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="ViewHeader"	VALUE="False">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="HiddenVScroll" VALUE="True">
							<PARAM NAME="Fillarea"		VALUE="True">
							<PARAM NAME="Format"			VALUE="  
							<C> Name='' ID=param1  	HeadAlign=Center	HeadBgColor=#B9D4DC  BgColor='#C3D0DB' Width=80 align=center </C> 
							<C> Name='' ID=param2  	HeadAlign=Center	HeadBgColor=#B9D4DC BgColor='#C3D0DB' Width=70 align=center  </C> 
							<C> Name='' ID=param3   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=120  align=RIGHT Value={Number(param3)}  </C> 
							<C> Name='' ID=param4		BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=86 align=RIGHT  </C> 
							<C> Name='' ID=param5		BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=110  align=RIGHT  Value={Number(param5)} </C> 
							<C> Name='' ID=param6   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=86  align=RIGHT  </C> 
							<C> Name='' ID=param7   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=110  align=RIGHT   Value={Number(param7)} </C> 
							<C> Name='' ID=param8   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=86  align=RIGHT  </C> 
							<C> Name='' ID=param9		BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=110 align=RIGHT   Value={Number(param9)}  </C> 
							<C> Name='' ID=param10  BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=133 align=RIGHT  </C> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script> 
						
						<!-- 급여 소득 총액 START-->
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create6_1 codebase="http://www.singiro.co.kr/Common/cab/toinbgrid.cab#version=1,1,0,135"  style="WIDTH: 874px; HEIGHT: 356px;border:1 solid #777777;display:none;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_grid_ec06az">
              <PARAM NAME="Editable"		VALUE="False">
              <PARAM NAME="ColSizing"		VALUE="true">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="Format"			VALUE="  
								<FC> Name='소속'				ID=DEPTNM BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=105 align=left    SumBgColor=#C3D0DB sort=true </FC>
								<FC> Name='직위'				ID=PAYGNM BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left    SumBgColor=#C3D0DB sort=true </FC> 
								<FC> Name='사번'				ID=EMPNO  BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=center  SumBgColor=#C3D0DB sort=true </FC> 
								<FC> Name='성명'				ID=EMPNMK BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=left    SumBgColor=#C3D0DB sort=true </FC> 
								<FC> Name='주민번호'		ID=RESINO BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=101 align=center  SumBgColor=#C3D0DB sort=true MASK='XXXXXX-XXXXXXX' </FC> 
								<FC> Name='입사일'			ID=STRTDT BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=center  SumBgColor=#C3D0DB sort=true MASK='XXXX/XX/XX'</FC> 
								<FC> Name='지급일'			ID=PAYDT  BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=center  SumBgColor=#C3D0DB Value={Left(PAYDT,6)}  sort=true MASK='XXXX/XX'</FC>  
								
								<C> Name='기본급'				ID=P10000 HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='직책수당'			ID=P11000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='시간외수당'		ID=P12000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='근속수당'			ID=P21000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='자기계발비'		ID=P22000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='부양가족수당' ID=P23000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='차량유지비'		ID=P24000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='출납수당'			ID=P25000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='운전수당'			ID=P26000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='연장수당'			ID=P27000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='자격수당'			ID=P28000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='남북경협수당' ID=P29000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='사장단수당'		ID=P30000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='특수지수당'		ID=P31000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='지역근무수당' ID=P32000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='학비보조금'		ID=P36000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='개인연금보조금' ID=P37000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='임원직책수당' ID=P38000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='년차수당'			ID=P34000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='식대보조'			ID=P35000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='전월소급'			ID=P39000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='휴일수당'			ID=PX0010 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='기타지급1'		ID=PX0020 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='기타지급2'		ID=PX0030 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='기타지급3'		ID=PX0040 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='지급합계'			ID=S91000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='소득세'				ID=T11000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='주민세'				ID=T12000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='건강보험료'		ID=B11000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='국민연금'			ID=B12000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='고용보험'			ID=B13000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='개인연금'			ID=B15000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='여직원회비'		ID=B14000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='공조회비'			ID=B16000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='산재보험'			ID=B17000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='보증보험'			ID=BX0010 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='기타공제1'		ID=BX0020 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='기타공제2'		ID=BX0030 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='기타공제3'		ID=BX0040 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='정산건강'			ID=P41000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='정산고용'			ID=P42000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='정산소득'			ID=T21000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='정산주민'			ID=T22000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='공제합계'			ID=S93000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='실지급액'			ID=S94000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>

						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create6_2  codebase="http://www.singiro.co.kr/Common/cab/toinbgrid.cab#version=1,1,0,135"   style="position:absolute;top:452px; left:0px;WIDTH: 874px; HEIGHT: 75px;border:1 solid #777777;border-top-width:1px;display:none;z-index:2" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_pyo6">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="ViewHeader"	VALUE="False">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="HiddenVScroll" VALUE="True">
							<PARAM NAME="Fillarea"		VALUE="True">
							<PARAM NAME="Format"			VALUE="  
							<C> Name='' ID=param1  	BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center </C> 
							<C> Name='' ID=param2  	BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  </C> 
							<C> Name='' ID=param3   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=120  align=RIGHT Value={Number(param3)}  </C> 
							<C> Name='' ID=param4		BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=86		align=RIGHT  </C> 
							<C> Name='' ID=param5		BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=110  align=RIGHT  Value={Number(param5)} </C> 
							<C> Name='' ID=param6   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=86		align=RIGHT  </C> 
							<C> Name='' ID=param7   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=110  align=RIGHT   Value={Number(param7)} </C> 
							<C> Name='' ID=param8   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=86		align=RIGHT  </C> 
							<C> Name='' ID=param9		BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=RIGHT   Value={Number(param9)}  </C> 
							<C> Name='' ID=param10  BgColor='#C3D0DB' HeadAlign=Center HeadBgColor=#B9D4DC Width=133	align=RIGHT  </C> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<!-- 급여 소득 총액 END -->

						<!-- 은행 엑셀 START -->
						<comment id="__NSID__"><OBJECT id=gcgd_excel  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="position:absolute;top:452px; left:0px;WIDTH: 874px; HEIGHT: 75px;border:1 solid #777777;border-top-width:1px;display:none;z-index:2" viewastext>
							<PARAM NAME="DataID"				VALUE="gcds_excel">
							<PARAM NAME="Editable"			VALUE="fALSE">
							<PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM NAME="Fillarea"			VALUE="true">
							<PARAM NAME="ColSizing"			VALUE="true">
							<Param NAME="SortView"			VALUE="Left">
							<PARAM NAME="Format"				VALUE="  
								<C> Name='No'				ID={Currow} BgColor='#FFFFFF' HeadAlign=Center HeadBgColor=#B9D4DC Width=30		align=CENTER </C> 
						<C> Name='성명'	ID=EMPNMK 	BgColor='#FFFFFF' HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=CENTER</C>
								<C> Name='은행코드'	ID=PAYBNK		BgColor='#FFFFFF'	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=CENTER </C> 
								<C> Name='계좌번호' ID=PAYNUM		BgColor='#FFFFFF' HeadAlign=Center HeadBgColor=#B9D4DC Width=160	align=CENTER </C> 
								<C> Name='금액'			ID=S94000		BgColor='#FFFFFF' HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=RIGHT  </C>
								<C> Name='금액2'		ID=DONG		BgColor='#FFFFFF' HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=RIGHT  </C>
								<C> Name='동'				ID=DONG			BgColor='#FFFFFF' HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=RIGHT  </C>
								<C> Name='호수'			ID=BUNJI		BgColor='#FFFFFF' HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=RIGHT  </C>
								<C> Name='전화'			ID=TELNO		BgColor='#FFFFFF' HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=RIGHT  </C>
								<C> Name='메모'			ID=MEMO			BgColor='#FFFFFF' HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=RIGHT  </C>
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<!-- 은행 엑셀 END -->

            <!--소속별 지급현황-->
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create5_1 codebase="http://www.singiro.co.kr/Common/cab/toinbgrid.cab#version=1,1,0,135"  style="WIDTH: 874px; HEIGHT: 356px;border:1 solid #777777;display:none;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_grid_ec05az">
              <PARAM NAME="Editable"		VALUE="flase">
              <PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
						  <PARAM NAME="Format"			VALUE="  
								<FC> Name='소속' ID=DEPTNM		BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=140 align=left  SumBgColor=#C3D0DB sort=true </FC> 
								<FC> Name='년월' ID=PAYDT			BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=center  SumBgColor=#C3D0DB sort=true </FC> 
								<FC> Name='구분' ID=PAYDIVNM	BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=center  SumBgColor=#C3D0DB  sort=true</FC> 
								<C> Name='기본급' ID=P10000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='직책수당' ID=P11000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='시간외' ID=P12000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='건강보험' ID=B11000 HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='국민연금' ID=B12000 HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='고용보험' ID=B13000 HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='소득세' ID=T11000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT  SumBgColor=#C3D0DB </C> 
								<C> Name='주민세' ID=T12000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=RIGHT  SumBgColor=#C3D0DB </C> 
								<C> Name='공제' ID=S93000  		HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT  SumBgColor=#C3D0DB </C> 
								<c> Name='실지급액' ID=S94000 HeadAlign=Center HeadBgColor=#B9D4DC Width=121  align=RIGHT  SumBgColor=#C3D0DB </c> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
            
						 <!--소속별 지급현황 Excel-->
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_excel_5_1  style="WIDTH:874px; HEIGHT: 356px;border:1 solid #777777;display:none;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_excel_5_1">
							<PARAM NAME="SuppressOption" value="1">
						  <PARAM NAME="Format"			VALUE="  
								<C> Name='소속' ID=GUBUN		HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=left  suppress=1  </C> 
								<C> Name='소속' ID=DEPTNM2	HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=left  </C> 
								<C> Name='인원' ID=CNT      HeadAlign=Center HeadBgColor=#B9D4DC Width=30   align=RIGHT  </C> 
								<C> Name='금액' ID=S91AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT </C> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>

						 <!--급여소득총액 Excel-->
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_excel_6_1  style="WIDTH:874px; HEIGHT: 356px;border:1 solid #777777;display:none;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_excel_6_1">
							<PARAM NAME="SuppressOption" value="1">
						  <PARAM NAME="Format"			VALUE="  
								<C> Name='소속명'         ID=DEPTNM   		HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=left   </C> 
								<C> Name='성명'           ID=EMPNMK   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=left   </C> 
								<C> Name='사번'           ID=EMPNO        HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center  </C> 
								<C> Name='호봉'           ID=PAYSEQ     	HeadAlign=Center HeadBgColor=#B9D4DC Width=50   align=center  </C> 
								<C> Name='직위명'         ID=PAYGNM   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=left   </C> 
								<C> Name='근무지'         ID=DEPTPRTNM	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=left   </C> 
								<C> Name='최종변동일'     ID=CHAGDT       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center  mask='XXXX/XX/XX'</C> 
								<C> Name='은행명'         ID=BANKNM     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=left  </C> 
								<C> Name='계좌번호'       ID=PAYACNT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=left   </C> 
								<C> Name='그룹입사일'     ID=GRSTRTDT 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=center  mask='XXXX/XX/XX' </C> 
								<C> Name='입사일'         ID=STRTDT       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center  mask='XXXX/XX/XX' </C> 
								<C> Name='수습적'         ID=TRAINYN    	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='발령일'         ID=DPOFFDT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center  mask='XXXX/XX/XX' </C> 
								<C> Name='실지급액'       ID=S94000   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='지급합계'       ID=S91000       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='공제합계'       ID=S93000     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='기본급'         ID=P10000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='직책수당'       ID=P11000   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='시간외수당'     ID=P12000       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='근속수당'       ID=P21000     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='자기계발비'     ID=P22000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='부양가족수당'   ID=P23000   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='차량유지비'     ID=P24000       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='출납수당'       ID=P25000     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='운전수당'       ID=P26000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='연장수당'       ID=P27000   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='자격수당'       ID=P28000       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='남북경협수당'   ID=P29000     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='사장단수당'     ID=P30000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='특수지수당'     ID=P31000   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='지역근무수당'   ID=P32000       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='학비보조금'     ID=P36000     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='개인연금보조금' ID=P37000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='임원직책수당'   ID=P38000   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='년차수당'       ID=P34000       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='식대보조'       ID=P35000     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='전월소급'       ID=P39000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='휴일수당'       ID=PX0010   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='기타지급1'      ID=PX0020       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='기타지급2'      ID=PX0030     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='기타지급3'      ID=PX0040   		HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='소득세'         ID=T11000   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='주민세'         ID=T12000       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='건강보험료'     ID=B11000     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='국민연금'       ID=B12000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='고용보험'       ID=B13000   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='개인연금'       ID=B15000       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='여직원회비'     ID=B14000     	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='공조회비'       ID=B16000       HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='산재보험'       ID=B17000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='보증보험'       ID=BX0010   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='기타공제1'      ID=BX0020   		HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='기타공제2'      ID=BX0030   		HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=right   </C> 
								<C> Name='기타공제3'      ID=BX0040   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right  </C> 
								<C> Name='정산건강'       ID=P41000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='정산고용'       ID=P42000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='정산소득'       ID=T21000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right   </C> 
								<C> Name='정산주민'       ID=T22000   		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=RIGHT  </C> 
								<C> Name='주민번호'       ID=RESINO   		HeadAlign=Center HeadBgColor=#B9D4DC Width=130  align=center  </C> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create5_2  codebase="http://www.singiro.co.kr/Common/cab/toinbgrid.cab#version=1,1,0,135"   style="position:absolute;top:452px; left:0px;WIDTH: 874px; HEIGHT: 75px;border:1 solid #777777;border-top-width:1px;display:none;z-index:2" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_pyo5">
              <PARAM NAME="Editable"		VALUE="false">
              <PARAM NAME="ViewHeader"	VALUE="False">
              <PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME=HiddenVScroll VALUE="True">
              <PARAM NAME="ColSizing"		VALUE="true">
							<PARAM NAME="Fillarea"		VALUE="True">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='' ID=param1  	HeadAlign=Center HeadBgColor=#B9D4DC  BgColor='#C3D0DB' Width=70 align=center </C> 
								<C> Name='' ID=param2  	HeadAlign=Center HeadBgColor=#B9D4DC BgColor='#C3D0DB' Width=70 align=center  </C> 
								<C> Name='' ID=param3   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=130  align=RIGHT    Value={Number(param3)} </C> 
								<C> Name=''  BgColor='#C3D0DB' ID=param4  	HeadAlign=Center HeadBgColor=#B9D4DC Width=86 align=RIGHT  </C> 
								<C> Name=''  BgColor='#C3D0DB' ID=param5  	HeadAlign=Center HeadBgColor=#B9D4DC Width=110  align=RIGHT   Value={Number(param5)} </C> 
								<C> Name='' ID=param6   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=86  align=RIGHT  </C> 
								<C> Name='' ID=param7   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=110  align=RIGHT   Value={Number(param7)}  </C> 
								<C> Name='' ID=param8   BgColor='#C3D0DB'	HeadAlign=Center HeadBgColor=#B9D4DC Width=86  align=RIGHT  </C> 
								<C> Name='' ID=param9  BgColor='#C3D0DB' 	HeadAlign=Center HeadBgColor=#B9D4DC Width=110 align=RIGHT   Value={Number(param9)} </C> 
								<C> Name='' ID=param10  BgColor='#C3D0DB' 	HeadAlign=Center HeadBgColor=#B9D4DC Width=123 align=RIGHT Dec=3 </C> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>         
						
						
						 <!-- 당월급여변동자/////////////////////////////////////////////////////////////////////////////////////////////////-->
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create7_1  style="WIDTH: 874px; HEIGHT: 356px;border:1 solid #777777;display:none;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_change_7">
              <PARAM NAME="Editable"		VALUE="False">
              <PARAM NAME="ColSizing"		VALUE="true">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="Format"			VALUE="  
								<FC> Name='순서'				ID=''        HeadAlign=Center HeadBgColor=#B9D4DC Width=30   align=center BgColor='#f5f5f5' SumBgColor=#C3D0DB value={currow} </FC>
								<FC> Name='소속'				ID=DEPTNMK2  HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=left   BgColor='#f5f5f5' SumBgColor=#C3D0DB sort=true </FC> 
								<FC> Name='변동일'			ID=CHAGDT    HeadAlign=Center HeadBgColor=#B9D4DC Width=70   align=center BgColor='#f5f5f5' SumBgColor=#C3D0DB sort=true MASK={IF(CHAGDT='','','XXXX/XX/XX')}</FC> 
								<FC> Name='직위'				ID=PAYGRDNM  HeadAlign=Center HeadBgColor=#B9D4DC Width=95   align=left   BgColor='#f5f5f5' SumBgColor=#C3D0DB sort=true </FC> 
							  <FC> Name='직급/호봉'		ID=PAYSEQ    HeadAlign=Center HeadBgColor=#B9D4DC Width=60   align=left   BgColor='#f5f5f5' SumBgColor=#C3D0DB  </FC> 
								<FC> Name='성명'		    ID=EMPNMK    HeadAlign=Center HeadBgColor=#B9D4DC Width=50   align=left   BgColor='#f5f5f5' SumBgColor=#C3D0DB sort=true  </FC> 
								<FG> Name='근무일수' HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='본사'			  ID=BSDAY     HeadAlign=Center HeadBgColor=#B9D4DC Width=30  align=center  BgColor='#f5f5f5' SumBgColor=#C3D0DB  </FC> 
									<C> Name='현장'			  ID=HJDAY     HeadAlign=Center HeadBgColor=#B9D4DC Width=30  align=center  BgColor='#f5f5f5' SumBgColor=#C3D0DB  </FC>  
									<C> Name='해외'				ID=FSDAY     HeadAlign=Center HeadBgColor=#B9D4DC Width=30  align=center  BgColor='#f5f5f5' SumBgColor=#C3D0DB </C> 
									<C> Name='계'			    ID=DAY_SUM   HeadAlign=Center HeadBgColor=#B9D4DC Width=30  align=center  BgColor='#f5f5f5' SumBgColor=#C3D0DB </C> 
								</FG>																																															
                <G> Name='공통수당' HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='기본급'		  ID=P10000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='상여'		  	ID=P11000 HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='시간외'		  ID=P12000 HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='근속수당'   ID=P21000 HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='자기계발'		ID=P22000 HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='가족부양'		ID=P23000 HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='자격수당'		ID=P28000 HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='남북경협'		ID=P29000 HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='개인연금'		ID=P37000 HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='조장수당'		ID=P27000 HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='기타지급'		ID=ETC_SUM HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='소계'       ID=COM_SUM HeadAlign=Center HeadBgColor=#B9D4DC Width=75 align=RIGHT SumBgColor=#C3D0DB  BgColor=#C3D0DB</C> 
								</G>

                <G> Name='변동수당' HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='차량유지'		ID=P24000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='현장수당'		ID=P32000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='현장식대'   ID=P35000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='현장(조장)'		ID=P31000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='전월소급'   ID=P39000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
									<C> Name='소계'       ID=CHG_SUM HeadAlign=Center HeadBgColor=#B9D4DC Width=75  align=RIGHT SumBgColor=#C3D0DB   BgColor=#C3D0DB</C> 
								</G>
								<C> Name='계'			      ID=TOT_SUM HeadAlign=Center HeadBgColor=#B9D4DC Width=85  align=RIGHT SumBgColor=#C3D0DB   BgColor=#C3D0DB</C> 
                <C> Name='비고'				  ID=ORDNM2     HeadAlign=Center HeadBgColor=#B9D4DC Width=60   align=left   BgColor='#f5f5f5' SumBgColor=#C3D0DB sort=true </FC>
								
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						 <!-- 당월급여변동자 END/////////////////////////////////////////////////////////////////////////////////////////////////-->
						
						
						
						<fieldset id=ft_div1 style="width:876px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
						</fieldset>
						<fieldset id=ft_div2 style="position:absolute;left:0px;top:529px;width: 342px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt2 style="position:relative;top:4px;"></font>&nbsp;
						</fieldset>
						<fieldset  id=ft_div3 style="position:absolute;left:0px;top:529px;width:876px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;display:none">
							<font id=ft_cnt3 style="position:relative;top:4px;"></font>&nbsp;
						</fieldset>
						<!-- <fieldset  id=ft_div6 style="position:absolute;left:0px;top:529px;width:876px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;display:none">
							<font id=ft_cnt6 style="position:relative;top:4px;"></font>&nbsp;
						</fieldset> -->
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
<comment id="__NSID__"><OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"				VALUE="gcds_grid_ec02az">
	<PARAM NAME="ActiveBind"		VALUE="true">
	<PARAM NAME="BindInfo"			VALUE="
		<C>Col=EMPNO		Ctrl=txt_EMPNO		Param=value</C>	
		<C>Col=EMPNMK		Ctrl=txt_EMPNMK		Param=value</C> 
		<C>Col=NOTWRK		Ctrl=txt_NOTWRK		Param=value</C> 
		<C>Col=APPDT		Ctrl=gcem_APPDT		Param=Text</C>	
		<C>Col=PAYDIV		Ctrl=txt_PAYDIV		Param=value</C>	
		<C>Col=DEPTCD		Ctrl=txt_DEPTCD		Param=value</C>	
		<C>Col=DEPTNM		Ctrl=txt_DEPTNM		Param=value</C>	
		<C>Col=PAYGRDNM	Ctrl=txt_PAYGRDNM	Param=value</C>	
		<C>Col=GRDDIVNM	Ctrl=txt_GRDDIVNM	Param=value</C>	
		<C>Col=PAYSEQNM	Ctrl=txt_PAYSEQNM	Param=value</C>	
		<C>Col=PAYBNKNM	Ctrl=txt_PAYBNKNM	Param=value</C>	
		<C>Col=PAYNUM		Ctrl=txt_PAYNUM		Param=value</C>	
		<C>Col=PAYDT		Ctrl=gcem_PAYDT		Param=Text</C> 
		<C>Col=DUYNOT		Ctrl=txt_DUYNOT		Param=value</C>	
		<C>Col=P10000		Ctrl=gcem_P10000	Param=Text</C>
		<C>Col=P11000		Ctrl=gcem_P11000	Param=Text</C>
		<C>Col=P12000		Ctrl=gcem_P12000	Param=Text</C>
		<C>Col=P21000		Ctrl=gcem_P21000	Param=Text</C>
		<C>Col=P22000		Ctrl=gcem_P22000	Param=Text</C>
		<C>Col=P23001		Ctrl=gcem_P23001	Param=Text</C>
		<C>Col=P24000		Ctrl=gcem_P24000	Param=Text</C>
		<C>Col=P25000		Ctrl=gcem_P25000	Param=Text</C>
		<C>Col=P26000		Ctrl=gcem_P26000	Param=Text</C>
		<C>Col=P27000		Ctrl=gcem_P27000	Param=Text</C>
		<C>Col=P28000		Ctrl=gcem_P28000	Param=Text</C>
		<C>Col=P29000		Ctrl=gcem_P29000	Param=Text</C>
		<C>Col=P30000		Ctrl=gcem_P30000	Param=Text</C>
		<C>Col=P31000		Ctrl=gcem_P31000	Param=Text</C>
		<C>Col=P32000		Ctrl=gcem_P32000	Param=Text</C>
		<C>Col=P36000		Ctrl=gcem_P36000	Param=Text</C>
		<C>Col=P37000		Ctrl=gcem_P37000	Param=Text</C>
		<C>Col=P38000		Ctrl=gcem_P38000	Param=Text</C>
		<C>Col=PX0010		Ctrl=gcem_PX0010	Param=Text</C>
		<C>Col=PX0020		Ctrl=gcem_PX0020	Param=Text</C>
		<C>Col=PX0030		Ctrl=gcem_PX0030	Param=Text</C>
		<C>Col=PX0040		Ctrl=gcem_PX0040	Param=Text</C>
		<C>Col=S91000		Ctrl=gcem_S91000	Param=Text</C>
		<C>Col=T11000		Ctrl=gcem_T11000	Param=Text</C>
		<C>Col=T12000		Ctrl=gcem_T12000	Param=Text</C>
		<C>Col=B11000		Ctrl=gcem_B11000	Param=Text</C>
		<C>Col=B12000		Ctrl=gcem_B12000	Param=Text</C>
		<C>Col=B13000		Ctrl=gcem_B13000	Param=Text</C>
		<C>Col=B15000		Ctrl=gcem_B15000	Param=Text</C>
		<C>Col=B14000		Ctrl=gcem_B14000	Param=Text</C>
		<C>Col=B16000		Ctrl=gcem_B16000	Param=Text</C>
		<C>Col=BX0010		Ctrl=gcem_BX0010	Param=Text</C>
		<C>Col=BX0020		Ctrl=gcem_BX0020	Param=Text</C>
		<C>Col=BX0030		Ctrl=gcem_BX0030	Param=Text</C>
		<C>Col=BX0040		Ctrl=gcem_BX0040	Param=Text</C>
		<C>Col=S93000		Ctrl=gcem_S93000	Param=Text</C>
		<C>Col=STRTDT		Ctrl=txt_STRTDT		Param=value</C>	
		<C>Col=JOBGRPHNM  Ctrl=txt_JOBGRPHNM	Param=value</C>	
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N
------------------------------------------------------------------------------>
<!--OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"	value="gcds_report1">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=FHeader ,left=0,top=0 ,right=2871 ,bottom=511 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=921 ,top=98 ,right=1937 ,bottom=98 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='CMM', left=1262, top=3, right=1352, bottom=90, align='right', face='Arial', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='월 급여지급 현황' ,left=1296 ,top=3 ,right=1847 ,bottom=90 ,face='Arial' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='년' ,left=1183 ,top=3 ,right=1262 ,bottom=90 ,face='Arial' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CYYYY', left=1013, top=3, right=1185, bottom=90, align='right', face='Arial', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='단위 : 원' ,left=2696 ,top=98 ,right=2839 ,bottom=167 ,align='right'</T>
	<T>id='1.총인원' ,left=16 ,top=87 ,right=228 ,bottom=156 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TODATEE', left=2696, top=69, right=2839, bottom=129 ,mask='XXXX.XX.XX'</C>
	<T>id='Print Date:' ,left=2434 ,top=69 ,right=2696 ,bottom=129 ,align='right'</T>
	<L> left=2376 ,top=209 ,right=2376 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=431 ,top=209 ,right=2551 ,bottom=209 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=431 ,top=138 ,right=431 ,bottom=503 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=21 ,top=138 ,right=21 ,bottom=503 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=283 ,top=138 ,right=283 ,bottom=503 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=21 ,top=503 ,right=2828 ,bottom=503 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=90 ,top=429 ,right=90 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=90 ,top=426 ,right=2831 ,bottom=426 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=26 ,top=357 ,right=2831 ,bottom=357 </L>
	<L> left=24 ,top=283 ,right=2828 ,bottom=283 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2559 ,top=138 ,right=2559 ,bottom=503 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1503 ,top=138 ,right=1503 ,bottom=503 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2831 ,top=138 ,right=2831 ,bottom=503 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=646 ,top=209 ,right=646 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=857 ,top=212 ,right=857 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1069 ,top=212 ,right=1069 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1281 ,top=209 ,right=1281 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2204 ,top=209 ,right=2204 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2032 ,top=209 ,right=2032 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1688 ,top=209 ,right=1688 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1860 ,top=209 ,right=1860 ,bottom=511 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=21 ,top=135 ,right=2828 ,bottom=135 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='구분' ,left=50 ,top=201 ,right=262 ,bottom=267 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인원' ,left=296 ,top=201 ,right=431 ,bottom=267 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본급' ,left=437 ,top=230 ,right=648 ,bottom=296 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급내역' ,left=950 ,top=164 ,right=1162 ,bottom=230 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직책수당' ,left=648 ,top=230 ,right=860 ,bottom=296 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시간외수당' ,left=860 ,top=230 ,right=1072 ,bottom=296 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=1072 ,top=230 ,right=1283 ,bottom=296 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1283 ,top=230 ,right=1495 ,bottom=296 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑근세' ,left=1519 ,top=230 ,right=1691 ,bottom=296 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=1691 ,top=230 ,right=1863 ,bottom=296 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='건강보험' ,left=1863 ,top=230 ,right=2035 ,bottom=296 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제내역' ,left=1913 ,top=164 ,right=2125 ,bottom=230 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국민연금' ,left=2035 ,top=230 ,right=2207 ,bottom=296 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=2207 ,top=230 ,right=2379 ,bottom=296 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=2379 ,top=230 ,right=2551 ,bottom=296 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='실지급액' ,left=2593 ,top=196 ,right=2805 ,bottom=262 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CYYYYO', left=74, top=310, right=153, bottom=376, align='right'</C>
	<T>id='.' ,left=151 ,top=310 ,right=175 ,bottom=376</T>
	<C>id='CMMO', left=167, top=310, right=217, bottom=376, align='right'</C>
	<T>id='월' ,left=214 ,top=310 ,right=262 ,bottom=376</T>
	<C>id='CYYYY', left=74, top=378, right=153, bottom=445, align='right'</C>
	<T>id='.' ,left=151 ,top=378 ,right=175 ,bottom=445</T>
	<C>id='CMM', left=167, top=378, right=217, bottom=445, align='right'</C>
	<T>id='월' ,left=214 ,top=378 ,right=262 ,bottom=445</T>
	<C>id='COUNTP', left=307, top=310, right=421, bottom=376, align='right'</C>
	<C>id='COUNTR', left=307, top=378, right=421, bottom=445, align='right'</C>
	<C>id='P10000R', left=437, top=378, right=648, bottom=445, align='right'</C>
	<C>id='P10000', left=437, top=310, right=648, bottom=376, align='right'</C>
	<C>id='P11000', left=648, top=310, right=860, bottom=376, align='right'</C>
	<C>id='P11000R', left=648, top=378, right=860, bottom=445, align='right'</C>
	<C>id='P12000', left=860, top=310, right=1072, bottom=376, align='right'</C>
	<C>id='P12000R', left=860, top=378, right=1072, bottom=445, align='right'</C>
	<C>id='PXTOTALR', left=1072, top=378, right=1283, bottom=445, align='right', Dec=0</C>
	<C>id='PXTOTAL', left=1069, top=310, right=1281, bottom=376, align='right', Dec=0</C>
	<C>id='S91000', left=1281, top=310, right=1492, bottom=376, align='right', Dec=0</C>
	<C>id='S91000R', left=1281, top=378, right=1492, bottom=445, align='right', Dec=0</C>
	<C>id='T11000', left=1516, top=310, right=1688, bottom=376, align='right', supplevel=2</C>
	<C>id='T11000R', left=1516, top=378, right=1688, bottom=445, align='right', supplevel=2</C>
	<C>id='T12000', left=1688, top=310, right=1860, bottom=376, align='right', supplevel=2</C>
	<C>id='T12000R', left=1688, top=378, right=1860, bottom=445, align='right', supplevel=2</C>
	<C>id='B11000', left=1860, top=310, right=2032, bottom=376, align='right', supplevel=2</C>
	<C>id='B11000R', left=1860, top=378, right=2032, bottom=445, align='right', supplevel=2</C>
	<C>id='B12000R', left=2032, top=378, right=2204, bottom=445, align='right', supplevel=2</C>
	<C>id='BXTOTAL', left=2204, top=310, right=2376, bottom=376, align='right', supplevel=2</C>
	<C>id='B12000', left=2032, top=310, right=2204, bottom=376, align='right', supplevel=2</C>
	<C>id='BXTOTALR', left=2204, top=378, right=2376, bottom=445, align='right', supplevel=2</C>
	<C>id='S93000', left=2376, top=310, right=2548, bottom=376, align='right', supplevel=2</C>
	<C>id='S93000R', left=2376, top=378, right=2548, bottom=445, align='right', supplevel=2</C>
	<C>id='S94000', left=2588, top=310, right=2807, bottom=376, align='right', Dec=0</C>
	<C>id='S94000R', left=2588, top=378, right=2807, bottom=445, align='right', Dec=0</C>
	<C>id='{S94000R-S94000}', left=2588, top=445, right=2807, bottom=511, align='right', Dec=0</C>
	<C>id='{S93000R-S93000}', left=2376, top=445, right=2548, bottom=511, align='right'</C>
	<C>id='{BXTOTALR-BXTOTAL}', left=2204, top=445, right=2376, bottom=511, align='right'</C>
	<C>id='{B12000R-B12000}', left=2032, top=445, right=2204, bottom=511, align='right'</C>
	<C>id='{B11000R-B11000}', left=1860, top=445, right=2032, bottom=511, align='right'</C>
	<C>id='{T12000R-T12000}', left=1688, top=445, right=1860, bottom=511, align='right'</C>
	<C>id='{T11000R-T11000}', left=1516, top=445, right=1688, bottom=511, align='right'</C>
	<C>id='{S91000R-S91000}', left=1281, top=445, right=1492, bottom=511, align='right', Dec=0</C>
	<C>id='{PXTOTALR-PXTOTAL}', left=1069, top=445, right=1281, bottom=511, align='right', Dec=0</C>
	<C>id='{P12000R-P12000}', left=857, top=445, right=1069, bottom=511, align='right'</C>
	<C>id='{P11000R-P11000}', left=646, top=445, right=857, bottom=511, align='right'</C>
	<C>id='{P10000R-P10000}', left=434, top=445, right=646, bottom=511, align='right'</C>
	<C>id='{COUNTR-COUNTP}', left=304, top=445, right=418, bottom=511, align='right'</C>
	<T>id='전월대비증감' ,left=95 ,top=445 ,right=273 ,bottom=511 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

<B>id=default ,left=0,top=0 ,right=2871 ,bottom=439 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='DEPTNM', left=82, top=3, right=595, bottom=69, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='.' ,left=58 ,top=0 ,right=77 ,bottom=69 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{currow+1}', left=16, top=5, right=66, bottom=71, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2373 ,top=140 ,right=2373 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='DCYYYY', left=69, top=291, right=148, bottom=357, align='right'</C>
	<T>id='.' ,left=146 ,top=291 ,right=169 ,bottom=357</T>
	<C>id='DCMM', left=161, top=291, right=212, bottom=357, align='right'</C>
	<T>id='월' ,left=209 ,top=291 ,right=257 ,bottom=357</T>
	<C>id='DCMMO', left=161, top=222, right=212, bottom=288, align='right'</C>
	<T>id='.' ,left=146 ,top=222 ,right=169 ,bottom=288</T>
	<C>id='DCYYYYO', left=69, top=222, right=148, bottom=288, align='right'</C>
	<T>id='월' ,left=209 ,top=222 ,right=257 ,bottom=288</T>
	<L> left=429 ,top=140 ,right=2548 ,bottom=140 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='구분' ,left=45 ,top=114 ,right=257 ,bottom=180 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인원' ,left=291 ,top=114 ,right=426 ,bottom=180 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=429 ,top=69 ,right=429 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=19 ,top=69 ,right=19 ,bottom=434 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=280 ,top=69 ,right=280 ,bottom=434 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='{DS94000R-DS94000}', left=2585, top=360, right=2805, bottom=426, align='right', Dec=0</C>
	<C>id='{DCOUNTR-DCOUNTP}', left=302, top=360, right=415, bottom=426, align='right'</C>
	<C>id='DCOUNTR', left=302, top=291, right=415, bottom=357, align='right'</C>
	<C>id='DS94000R', left=2585, top=291, right=2805, bottom=357, align='right', Dec=0</C>
	<C>id='DS94000', left=2585, top=222, right=2805, bottom=288, align='right', Dec=0</C>
	<C>id='{DP10000R-DP10000}', left=431, top=360, right=643, bottom=426, align='right'</C>
	<C>id='{DS91000R-DS91000}', left=1278, top=360, right=1490, bottom=426, align='right', Dec=0</C>
	<C>id='{DPXTOTALR-DPXTOTAL}', left=1066, top=360, right=1278, bottom=426, align='right', Dec=0</C>
	<C>id='{DP12000R-DP12000}', left=855, top=360, right=1066, bottom=426, align='right'</C>
	<C>id='{DP11000R-DP11000}', left=643, top=360, right=855, bottom=426, align='right'</C>
	<C>id='{DT11000R-DT11000}', left=1513, top=360, right=1685, bottom=426, align='right'</C>
	<C>id='{DS93000R-DS93000}', left=2373, top=360, right=2545, bottom=426, align='right'</C>
	<C>id='{DT12000R-DT12000}', left=1685, top=360, right=1857, bottom=426, align='right'</C>
	<C>id='{DB11000R-DB11000}', left=1857, top=360, right=2029, bottom=426, align='right'</C>
	<C>id='{DB12000R-DB12000}', left=2029, top=360, right=2201, bottom=426, align='right'</C>
	<C>id='{DBXTOTALR-DBXTOTAL}', left=2201, top=360, right=2373, bottom=426, align='right', supplevel=2</C>
	<L> left=87 ,top=360 ,right=87 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=87 ,top=357 ,right=2828 ,bottom=357 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='DP10000R', left=431, top=291, right=643, bottom=357, align='right'</C>
	<C>id='DP11000R', left=643, top=291, right=855, bottom=357, align='right'</C>
	<C>id='DP12000R', left=855, top=291, right=1066, bottom=357, align='right'</C>
	<C>id='DPXTOTALR', left=1066, top=291, right=1278, bottom=357, align='right', Dec=0</C>
	<C>id='DS91000R', left=1278, top=291, right=1490, bottom=357, align='right', Dec=0</C>
	<C>id='DT11000R', left=1513, top=291, right=1685, bottom=357, align='right', supplevel=2</C>
	<C>id='DT12000R', left=1685, top=291, right=1857, bottom=357, align='right', supplevel=2</C>
	<C>id='DB11000R', left=1857, top=291, right=2029, bottom=357, align='right', supplevel=2</C>
	<C>id='DB12000R', left=2029, top=291, right=2201, bottom=357, align='right', supplevel=2</C>
	<C>id='DBXTOTALR', left=2201, top=291, right=2373, bottom=357, align='right', supplevel=2</C>
	<C>id='DS93000R', left=2373, top=291, right=2545, bottom=357, align='right', supplevel=2</C>
	<C>id='DCOUNTP', left=302, top=222, right=415, bottom=288, align='right'</C>
	<L> left=24 ,top=288 ,right=2828 ,bottom=288 </L>
	<C>id='DBXTOTAL', left=2201, top=222, right=2373, bottom=288, align='right', supplevel=2</C>
	<C>id='DB12000', left=2029, top=222, right=2201, bottom=288, align='right', supplevel=2</C>
	<C>id='DB11000', left=1857, top=222, right=2029, bottom=288, align='right', supplevel=2</C>
	<C>id='DT12000', left=1685, top=222, right=1857, bottom=288, align='right', supplevel=2</C>
	<C>id='DS93000', left=2373, top=222, right=2545, bottom=288, align='right', supplevel=2</C>
	<C>id='DT11000', left=1513, top=222, right=1685, bottom=288, align='right', supplevel=2</C>
	<C>id='DS91000', left=1278, top=222, right=1490, bottom=288, align='right', Dec=0</C>
	<C>id='DP10000', left=431, top=222, right=643, bottom=288, align='right'</C>
	<C>id='DP11000', left=643, top=222, right=855, bottom=288, align='right'</C>
	<C>id='DP12000', left=855, top=222, right=1066, bottom=288, align='right'</C>
	<C>id='DPXTOTAL', left=1066, top=222, right=1278, bottom=288, align='right', Dec=0</C>
	<L> left=21 ,top=214 ,right=2826 ,bottom=214 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='계' ,left=1278 ,top=143 ,right=1490 ,bottom=209 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=1066 ,top=143 ,right=1278 ,bottom=209 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시간외수당' ,left=855 ,top=143 ,right=1066 ,bottom=209 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직책수당' ,left=643 ,top=143 ,right=855 ,bottom=209 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본급' ,left=431 ,top=143 ,right=643 ,bottom=209 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=2373 ,top=143 ,right=2545 ,bottom=209 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=2201 ,top=143 ,right=2373 ,bottom=209 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국민연금' ,left=2029 ,top=143 ,right=2201 ,bottom=209 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='건강보험' ,left=1857 ,top=143 ,right=2029 ,bottom=209 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=1685 ,top=143 ,right=1857 ,bottom=209 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑근세' ,left=1513 ,top=143 ,right=1685 ,bottom=209 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='실지급액' ,left=2588 ,top=108 ,right=2799 ,bottom=175 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2556 ,top=69 ,right=2556 ,bottom=434 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1500 ,top=69 ,right=1500 ,bottom=434 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2828 ,top=69 ,right=2828 ,bottom=434 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=643 ,top=140 ,right=643 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=855 ,top=143 ,right=855 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1066 ,top=143 ,right=1066 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1278 ,top=140 ,right=1278 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2201 ,top=140 ,right=2201 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2029 ,top=140 ,right=2029 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1685 ,top=140 ,right=1685 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1857 ,top=140 ,right=1857 ,bottom=439 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=19 ,top=66 ,right=2826 ,bottom=66 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='지급내역' ,left=945 ,top=77 ,right=1156 ,bottom=143 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제내역' ,left=1908 ,top=77 ,right=2119 ,bottom=143 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전월대비증감' ,left=93 ,top=360 ,right=270 ,bottom=426 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=19 ,top=434 ,right=2826 ,bottom=434 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1896 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=19 ,top=0 ,right=2826 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=19 ,top=19 ,right=2826 ,bottom=98</T>
	<I>id='../../Common/img/icon.jpg' ,left=2466 ,top=3 ,right=2847 ,bottom=103</I>
</B>


">
</OBJECT>-->

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N  -- 계약직 급여지급현황[정기] --
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"			value="gcds_report1">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='급여지급현황_총인원.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_report0' 
		<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=582 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=818 ,top=5 ,right=2133 ,bottom=106 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=2</X>
			<L> left=32 ,top=228 ,right=2781 ,bottom=228 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<C>id='TODATEE', left=2580, top=132, right=2783, bottom=180, align='right' ,mask='XXXX.XX.XX', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='구  분' ,left=45 ,top=241 ,right=246 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=34 ,top=360 ,right=2781 ,bottom=360 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=34 ,top=550 ,right=2781 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='월' ,left=201 ,top=373 ,right=246 ,bottom=421 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CMMO', left=153, top=373, right=204, bottom=421, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=373 ,right=164 ,bottom=421 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CYYYYO', left=45, top=373, right=140, bottom=421, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='월' ,left=201 ,top=431 ,right=246 ,bottom=482 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CMM', left=153, top=431, right=204, bottom=482, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=431 ,right=164 ,bottom=482 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CYYYY', left=45, top=431, right=140, bottom=482, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='전월대비증감' ,left=77 ,top=492 ,right=246 ,bottom=540 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=32 ,top=230 ,right=32 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=257 ,top=230 ,right=257 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=352 ,top=230 ,right=352 ,bottom=550 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<C>id='S91000', left=360, top=373, right=582, bottom=421, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{S91000R-S91000}', left=360, top=492, right=582, bottom=540, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S91000R', left=360, top=431, right=582, bottom=482, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=1680 ,top=294 ,right=1680 ,bottom=550 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=590 ,top=230 ,right=590 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2474 ,top=230 ,right=2474 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2781 ,top=230 ,right=2781 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='Print Date:' ,left=2315 ,top=132 ,right=2577 ,bottom=180 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='1   총인원' ,left=32 ,top=180 ,right=241 ,bottom=222 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='계' ,left=1685 ,top=299 ,right=1894 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CYYYY', left=929, top=13, right=1101, bottom=98, align='right', face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
			<L> left=69 ,top=484 ,right=2781 ,bottom=484 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='S94000', left=2487, top=373, right=2773, bottom=421, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{S94000R-S94000}', left=2487, top=492, right=2773, bottom=540, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S94000R', left=2487, top=431, right=2773, bottom=482, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='소득세' ,left=598 ,top=299 ,right=767 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='국민연금' ,left=1132 ,top=299 ,right=1302 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='건강보험' ,left=955 ,top=299 ,right=1124 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='단위 : 원' ,left=2580 ,top=180 ,right=2783 ,bottom=222 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='COUNTP', left=273, top=373, right=349, bottom=421, align='right'</C>
			<C>id='COUNTR', left=270, top=431, right=347, bottom=482, align='right'</C>
			<L> left=71 ,top=484 ,right=71 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=590 ,top=294 ,right=1680 ,bottom=294 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1677 ,top=294 ,right=1900 ,bottom=294 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='인원' ,left=270 ,top=241 ,right=347 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='{COUNTR-COUNTP}', left=270, top=492, right=347, bottom=540, align='right', Dec=0</C>
			<T>id='실지급액' ,left=2487 ,top=241 ,right=2773 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CMM', left=1188, top=13, right=1275, bottom=98, align='right', face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
			<T>id='월' ,left=1278 ,top=13 ,right=1349 ,bottom=98 ,face='HY헤드라인M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<T>id='년' ,left=1103 ,top=13 ,right=1185 ,bottom=98 ,face='HY헤드라인M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<L> left=773 ,top=296 ,right=773 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=34 ,top=426 ,right=2781 ,bottom=426 </L>
			<L> left=953 ,top=296 ,right=953 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1127 ,top=296 ,right=1127 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1307 ,top=296 ,right=1307 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1487 ,top=296 ,right=1487 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='S93000', left=1685, top=373, right=1894, bottom=421, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S93000R', left=1685, top=431, right=1894, bottom=482, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{S93000R-S93000}', left=1685, top=492, right=1894, bottom=540, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<T>id='회사지원' ,left=1905 ,top=238 ,right=2461 ,bottom=288 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1900 ,top=230 ,right=1900 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2265 ,top=294 ,right=2265 ,bottom=550 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='계' ,left=2270 ,top=299 ,right=2466 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1902 ,top=294 ,right=2294 ,bottom=294 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2270 ,top=294 ,right=2471 ,bottom=294 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='고용보험' ,left=1910 ,top=299 ,right=2080 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='B23000', left=1910, top=373, right=2080, bottom=421, align='right'</C>
			<T>id='산재보험' ,left=2090 ,top=299 ,right=2260 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='B17000', left=2090, top=373, right=2260, bottom=421, align='right'</C>
			<C>id='B17000R', left=2090, top=431, right=2260, bottom=482, align='right'</C>
			<C>id='{B17000R-B17000}', left=2090, top=492, right=2260, bottom=540, align='right', Dec=0</C>
			<C>id='B23000R', left=1910, top=431, right=2080, bottom=482, align='right'</C>
			<C>id='{B23000R-B23000}', left=1910, top=492, right=2080, bottom=540, align='right', Dec=0</C>
			<T>id='지급계' ,left=381 ,top=241 ,right=561 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='B23170', left=2270, top=373, right=2466, bottom=421, align='right'</C>
			<C>id='B23170R', left=2270, top=431, right=2466, bottom=482, align='right'</C>
			<C>id='{B23170R-B23170}', left=2270, top=492, right=2466, bottom=540, align='right', Dec=0</C>
			<T>id='공제내역' ,left=601 ,top=238 ,right=1886 ,bottom=288 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='주민세' ,left=778 ,top=299 ,right=947 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='T11000', left=598, top=373, right=773, bottom=421, align='right'</C>
			<C>id='T11000R', left=598, top=429, right=773, bottom=479, align='right'</C>
			<C>id='{T11000R-T11000}', left=598, top=489, right=773, bottom=537, align='right', Dec=0</C>
			<C>id='T12000', left=778, top=373, right=953, bottom=421, align='right'</C>
			<C>id='B12000', left=1132, top=373, right=1307, bottom=421, align='right'</C>
			<C>id='B13000', left=1310, top=373, right=1484, bottom=421, align='right'</C>
			<C>id='T12000R', left=778, top=431, right=953, bottom=482, align='right'</C>
			<C>id='{T12000R-T12000}', left=778, top=492, right=953, bottom=540, align='right', Dec=0</C>
			<C>id='{BXTOTALR-BXTOTAL}', left=1490, top=495, right=1677, bottom=542, align='right', Dec=0</C>
			<C>id='BXTOTALR', left=1490, top=434, right=1677, bottom=484, align='right'</C>
			<C>id='BXTOTAL', left=1490, top=376, right=1677, bottom=423, align='right'</C>
			<C>id='B13000R', left=1310, top=431, right=1484, bottom=482, align='right'</C>
			<C>id='{B13000R-B13000}', left=1310, top=492, right=1484, bottom=540, align='right', Dec=0</C>
			<C>id='B12000R', left=1132, top=431, right=1307, bottom=482, align='right'</C>
			<C>id='{B12000R-B12000}', left=1132, top=492, right=1307, bottom=540, align='right', Dec=0</C>
			<C>id='B11000', left=955, top=373, right=1124, bottom=421, align='right'</C>
			<C>id='B11000R', left=955, top=431, right=1124, bottom=482, align='right'</C>
			<C>id='{B11000R-B11000}', left=955, top=492, right=1124, bottom=540, align='right', Dec=0</C>
			<T>id='기타' ,left=1492 ,top=299 ,right=1672 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='고용보험' ,left=1312 ,top=299 ,right=1482 ,bottom=349 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=2082 ,top=296 ,right=2082 ,bottom=553 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='CTITLE', left=1363, top=13, right=2096, bottom=98, align='left', face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
		</B>
	</R>
</A>

<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=133
	<R>id='급여지급현황_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=132 , DetailDataID='gcds_report1' 
			<B>id=default ,left=0,top=0 ,right=2871 ,bottom=418 ,face='Arial' ,size=10 ,penwidth=1
				<L> left=2257 ,top=148 ,right=2471 ,bottom=148 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
				<L> left=1902 ,top=148 ,right=2262 ,bottom=148 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<C>id='DB23170R', left=2265, top=286, right=2466, bottom=336, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<C>id='{DB23170R-DB23170}', left=2265, top=347, right=2466, bottom=394, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
				<C>id='{DB17000R-DB17000}', left=2088, top=347, right=2257, bottom=394, align='right', Dec=0</C>
				<C>id='{DB23000R-DB23000}', left=1905, top=347, right=2074, bottom=394, align='right', Dec=0</C>
				<C>id='DB17000R', left=2088, top=286, right=2257, bottom=336, align='right'</C>
				<C>id='DB23000R', left=1905, top=286, right=2074, bottom=336, align='right'</C>
				<C>id='DB23170', left=2265, top=228, right=2466, bottom=275, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<C>id='DB17000', left=2088, top=228, right=2257, bottom=275, align='right'</C>
				<C>id='DB23000', left=1905, top=228, right=2074, bottom=275, align='right'</C>
				<L> left=595 ,top=148 ,right=1672 ,bottom=148 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<C>id='{DBXTOTALR-DBXTOTAL}', left=1487, top=347, right=1672, bottom=394, align='right', Dec=0</C>
				<C>id='{DB13000R-DB13000}', left=1310, top=347, right=1479, bottom=394, align='right', Dec=0</C>
				<C>id='{DB12000R-DB12000}', left=1132, top=347, right=1302, bottom=394, align='right', Dec=0</C>
				<C>id='{DB11000R-DB11000}', left=953, top=347, right=1122, bottom=394, align='right', Dec=0</C>
				<C>id='{DT12000R-DT12000}', left=775, top=347, right=942, bottom=394, align='right', Dec=0</C>
				<C>id='DBXTOTALR', left=1487, top=286, right=1672, bottom=336, align='right'</C>
				<C>id='DB13000R', left=1310, top=286, right=1479, bottom=336, align='right'</C>
				<C>id='DB12000R', left=1132, top=286, right=1302, bottom=336, align='right'</C>
				<C>id='DB11000R', left=953, top=286, right=1122, bottom=336, align='right'</C>
				<C>id='DT12000R', left=775, top=286, right=942, bottom=336, align='right'</C>
				<C>id='DBXTOTAL', left=1487, top=228, right=1672, bottom=275, align='right'</C>
				<C>id='DB13000', left=1310, top=228, right=1479, bottom=275, align='right'</C>
				<C>id='DB12000', left=1132, top=228, right=1302, bottom=275, align='right'</C>
				<C>id='DB11000', left=953, top=228, right=1122, bottom=275, align='right'</C>
				<C>id='DT12000', left=775, top=228, right=942, bottom=275, align='right'</C>
				<T>id='계' ,left=2262 ,top=151 ,right=2466 ,bottom=201 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<T>id='산재보험' ,left=2085 ,top=151 ,right=2254 ,bottom=201 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=2260 ,top=148 ,right=2260 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
				<T>id='회사지원' ,left=1910 ,top=93 ,right=2455 ,bottom=143 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=2080 ,top=148 ,right=2080 ,bottom=405 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<T>id='고용보험' ,left=1908 ,top=151 ,right=2077 ,bottom=201 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<T>id='공제내역' ,left=598 ,top=95 ,right=1889 ,bottom=146 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=1675 ,top=148 ,right=1897 ,bottom=148 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
				<L> left=1900 ,top=85 ,right=1900 ,bottom=402 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
				<L> left=1482 ,top=151 ,right=1482 ,bottom=407 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<C>id='{DT11000R-DT11000}', left=598, top=347, right=767, bottom=394, align='right', Dec=0</C>
				<C>id='DT11000R', left=598, top=286, right=767, bottom=336, align='right'</C>
				<C>id='DT11000', left=598, top=228, right=767, bottom=275, align='right'</C>
				<T>id='고용보험' ,left=1310 ,top=156 ,right=1479 ,bottom=206 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=1304 ,top=151 ,right=1304 ,bottom=407 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<L> left=1127 ,top=148 ,right=1127 ,bottom=405 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<T>id='지급계' ,left=360 ,top=95 ,right=582 ,bottom=206 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<T>id='기타' ,left=1487 ,top=156 ,right=1672 ,bottom=206 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<T>id='계' ,left=1683 ,top=156 ,right=1892 ,bottom=206 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<C>id='{DS93000R-DS93000}', left=1683, top=347, right=1892, bottom=394, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
				<C>id='DS93000R', left=1683, top=286, right=1892, bottom=336, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<C>id='{currow+1}', left=32, top=29, right=87, bottom=74, align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
				<L> left=71 ,top=341 ,right=71 ,bottom=407 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<L> left=773 ,top=148 ,right=773 ,bottom=405 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<L> left=352 ,top=85 ,right=352 ,bottom=407 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
				<C>id='DS91000', left=357, top=228, right=579, bottom=275, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<C>id='DS91000R', left=357, top=286, right=579, bottom=336, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<C>id='{DS91000R-DS91000}', left=357, top=347, right=579, bottom=394, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
				<L> left=2781 ,top=87 ,right=2781 ,bottom=405 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
				<C>id='DS94000', left=2487, top=228, right=2773, bottom=275, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<C>id='DS94000R', left=2487, top=286, right=2773, bottom=336, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<C>id='{DS94000R-DS94000}', left=2487, top=347, right=2773, bottom=394, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
				<T>id='실지급액' ,left=2487 ,top=95 ,right=2773 ,bottom=206 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=2474 ,top=87 ,right=2474 ,bottom=405 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
				<L> left=1675 ,top=148 ,right=1675 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
				<C>id='DS93000', left=1683, top=228, right=1892, bottom=275, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<L> left=947 ,top=148 ,right=947 ,bottom=405 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<T>id='국민연금' ,left=1132 ,top=156 ,right=1302 ,bottom=206 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<T>id='건강보험' ,left=955 ,top=156 ,right=1124 ,bottom=206 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<T>id='소득세' ,left=598 ,top=156 ,right=767 ,bottom=206 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<T>id='주민세' ,left=778 ,top=156 ,right=945 ,bottom=206 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=593 ,top=87 ,right=593 ,bottom=405 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
				<L> left=32 ,top=87 ,right=32 ,bottom=405 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
				<T>id='전월대비증감' ,left=77 ,top=347 ,right=246 ,bottom=394 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=32 ,top=405 ,right=2781 ,bottom=405 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
				<L> left=257 ,top=87 ,right=257 ,bottom=400 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
				<C>id='DCOUNTP', left=270, top=228, right=347, bottom=275, align='right'</C>
				<C>id='DCOUNTR', left=270, top=286, right=347, bottom=336, align='right'</C>
				<C>id='{DCOUNTR-DCOUNTP}', left=270, top=347, right=347, bottom=394, align='right', Dec=0</C>
				<L> left=71 ,top=339 ,right=2781 ,bottom=339 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
				<T>id='인원' ,left=270 ,top=95 ,right=347 ,bottom=206 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<T>id='.' ,left=138 ,top=286 ,right=164 ,bottom=336 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<C>id='DCMM', left=153, top=286, right=204, bottom=336, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<T>id='월' ,left=201 ,top=286 ,right=246 ,bottom=336 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=32 ,top=280 ,right=2781 ,bottom=280 </L>
				<C>id='DCYYYY', left=45, top=286, right=140, bottom=336, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<C>id='DCYYYYO', left=45, top=228, right=140, bottom=275, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<T>id='.' ,left=138 ,top=228 ,right=164 ,bottom=275 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<C>id='DCMMO', left=153, top=228, right=204, bottom=275, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<T>id='월' ,left=201 ,top=228 ,right=246 ,bottom=275 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=32 ,top=214 ,right=2781 ,bottom=214 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
				<C>id='DEPTNM', left=93, top=29, right=606, bottom=74, align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
				<T>id='구  분' ,left=45 ,top=95 ,right=246 ,bottom=206 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
				<L> left=32 ,top=85 ,right=2781 ,bottom=85 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			</B>
	</R>
</A>

<B>id=Footer ,left=0 ,top=1895 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=8 ,top=0 ,right=2826 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=8 ,top=26 ,right=2815 ,bottom=106</T>
	<I>id='../../Common/img/icon.jpg' ,left=2400 ,top=5 ,right=2781 ,bottom=106</I>
</B>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N  -- 급여지급현황[상여] --
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcrp_print_2  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"			value="gcds_report1">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='급여지급현황_총인원.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_report0' 
		<B>id=DHeader ,left=0,top=0 ,right=2972 ,bottom=579 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=894 ,top=6 ,right=1919 ,bottom=106 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=2</X>
			<L> left=31 ,top=228 ,right=2781 ,bottom=228 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<C>id='TODATEE', left=2581, top=131, right=2784, bottom=181, align='right' ,mask='XXXX.XX.XX', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='구  분' ,left=44 ,top=241 ,right=247 ,bottom=350 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=34 ,top=359 ,right=2781 ,bottom=359 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=34 ,top=425 ,right=2781 ,bottom=425 </L>
			<L> left=34 ,top=550 ,right=2781 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='월' ,left=200 ,top=372 ,right=247 ,bottom=422 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CMMO', left=153, top=372, right=203, bottom=422, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=372 ,right=163 ,bottom=422 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CYYYYO', left=44, top=372, right=141, bottom=422, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='월' ,left=200 ,top=431 ,right=247 ,bottom=481 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CMM', left=153, top=431, right=203, bottom=481, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=431 ,right=163 ,bottom=481 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CYYYY', left=44, top=431, right=141, bottom=481, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='전월대비증감' ,left=78 ,top=491 ,right=247 ,bottom=541 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=31 ,top=231 ,right=31 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=256 ,top=231 ,right=256 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=353 ,top=231 ,right=353 ,bottom=550 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=563 ,top=294 ,right=563 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='S93000', left=2244, top=372, right=2466, bottom=422, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S91000', left=1106, top=372, right=1328, bottom=422, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id={S93000R-S93000}, left=2244, top=491, right=2466, bottom=541, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id={S91000R-S91000}, left=1106, top=491, right=1328, bottom=541, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S93000R', left=2244, top=431, right=2466, bottom=481, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S91000R', left=1106, top=431, right=1328, bottom=481, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=2238 ,top=294 ,right=2238 ,bottom=550 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=2056 ,top=294 ,right=2056 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1878 ,top=294 ,right=1878 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1522 ,top=294 ,right=1522 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1100 ,top=294 ,right=1100 ,bottom=550 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=919 ,top=294 ,right=919 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=741 ,top=294 ,right=741 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1338 ,top=231 ,right=1338 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2475 ,top=231 ,right=2475 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2781 ,top=231 ,right=2781 ,bottom=550 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='Print Date:' ,left=2316 ,top=131 ,right=2578 ,bottom=181 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='1   총인원' ,left=31 ,top=181 ,right=241 ,bottom=222 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='계' ,left=2244 ,top=300 ,right=2466 ,bottom=350 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='계' ,left=1106 ,top=300 ,right=1328 ,bottom=350 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='지급내역' ,left=359 ,top=241 ,right=1328 ,bottom=291 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='공제내역' ,left=1350 ,top=241 ,right=2466 ,bottom=291 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CYYYY', left=963, top=12, right=1134, bottom=97, align='right', face='HY헤드라인M', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
			<L> left=69 ,top=484 ,right=2781 ,bottom=484 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='S94000', left=2488, top=372, right=2772, bottom=422, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id={S94000R-S94000}, left=2488, top=491, right=2772, bottom=541, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S94000R', left=2488, top=431, right=2772, bottom=481, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='PXTOTAL', left=925, top=372, right=1094, bottom=422, align='right'</C>
			<C>id='P12000', left=747, top=372, right=916, bottom=422, align='right'</C>
			<C>id='P11000', left=569, top=372, right=738, bottom=422, align='right'</C>
			<C>id='PXTOTALR', left=925, top=431, right=1094, bottom=481, align='right'</C>
			<C>id='P12000R', left=747, top=431, right=916, bottom=481, align='right'</C>
			<C>id='P11000R', left=569, top=431, right=738, bottom=481, align='right'</C>
			<C>id='P10000R', left=359, top=431, right=559, bottom=481, align='right'</C>
			<C>id={PXTOTALR-PXTOTAL}, left=925, top=491, right=1094, bottom=541, align='right', Dec=0</C>
			<C>id={P12000R-P12000}, left=747, top=491, right=916, bottom=541, align='right', Dec=0</C>
			<C>id={P11000R-P11000}, left=569, top=491, right=738, bottom=541, align='right', Dec=0</C>
			<C>id={P10000R-P10000}, left=359, top=491, right=559, bottom=541, align='right', Dec=0</C>
			<T>id='갑근세' ,left=1350 ,top=300 ,right=1519 ,bottom=350 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='' ,left=2063 ,top=300 ,right=2231 ,bottom=350 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='기타' ,left=1884 ,top=300 ,right=2053 ,bottom=350 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='고용보험' ,left=1706 ,top=300 ,right=1875 ,bottom=350 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='주민세' ,left=1528 ,top=300 ,right=1697 ,bottom=350 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='', left=2063, top=491, right=2231, bottom=541, align='right', Dec=0</C>
			<C>id={BXTOTALR-BXTOTAL}, left=1884, top=491, right=2053, bottom=541, align='right', Dec=0</C>
			<C>id={B13000R-B13000},		left=1706, top=491, right=1875, bottom=541, align='right', Dec=0</C>
			<C>id={T12000R-T12000},		left=1528, top=491, right=1697, bottom=541, align='right', Dec=0</C>
			<C>id={T11000R-T11000},		left=1350, top=491, right=1519, bottom=541, align='right', Dec=0</C>
			<C>id='', left=2063, top=431, right=2231, bottom=481, align='right'</C>
			<C>id='BXTOTALR', left=1884, top=431, right=2053, bottom=481, align='right'</C>
			<C>id='B13000R', left=1706, top=431, right=1875, bottom=481, align='right'</C>
			<C>id='T12000R', left=1528, top=431, right=1697, bottom=481, align='right'</C>
			<C>id='T11000R', left=1350, top=431, right=1519, bottom=481, align='right'</C>
			<C>id='', left=2063, top=372, right=2231, bottom=422, align='right'</C>
			<C>id='BXTOTAL', left=1884, top=372, right=2053, bottom=422, align='right'</C>
			<C>id='B13000', left=1706, top=372, right=1875, bottom=422, align='right'</C>
			<C>id='T12000', left=1528, top=372, right=1697, bottom=422, align='right'</C>
			<C>id='T11000', left=1350, top=372, right=1519, bottom=422, align='right'</C>
			<T>id='단위 : 원' ,left=2581 ,top=181 ,right=2784 ,bottom=222 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='기본급' ,left=359 ,top=300 ,right=559 ,bottom=350 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='직책수당' ,left=569 ,top=300 ,right=738 ,bottom=350 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='시간외수당' ,left=747 ,top=300 ,right=916 ,bottom=350 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='기타' ,left=925 ,top=300 ,right=1094 ,bottom=350 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='P10000', left=363, top=372, right=563, bottom=422, align='right'</C>
			<C>id='COUNTP', left=272, top=372, right=350, bottom=422, align='right'</C>
			<C>id='COUNTR', left=269, top=431, right=347, bottom=481, align='right'</C>
			<L> left=72 ,top=484 ,right=72 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=353 ,top=294 ,right=2466 ,bottom=294 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2238 ,top=294 ,right=2475 ,bottom=294 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='인원' ,left=269 ,top=241 ,right=347 ,bottom=350 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1100 ,top=294 ,right=1338 ,bottom=294 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<C>id={COUNTR-COUNTP}, left=269, top=491, right=347, bottom=541, align='right', Dec=0</C>
			<T>id='실지급액' ,left=2488 ,top=241 ,right=2772 ,bottom=350 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1700 ,top=294 ,right=1700 ,bottom=550 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='CMM', left=1222, top=12, right=1309, bottom=97, align='right', face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
			<T>id='월' ,left=1313 ,top=12 ,right=1384 ,bottom=97 ,face='HY헤드라인M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<C>id='CTITLE', left=1416, top=12, right=1553, bottom=97, align='right', face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
			<T>id='지급 현황' ,left=1556 ,top=12 ,right=1869 ,bottom=97 ,face='HY헤드라인M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
			<T>id='년' ,left=1138 ,top=12 ,right=1219 ,bottom=97 ,face='HY헤드라인M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
		</B>
	</R>
</A>

<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=133
	<R>id='급여지급현황_본사근무자.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 , MasterDataID='gcds_report2' 
		<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=391 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=34 ,top=62 ,right=2781 ,bottom=62 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='2   본사근무자' ,left=31 ,top=9 ,right=353 ,bottom=56 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='구  분' ,left=44 ,top=75 ,right=247 ,bottom=184 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=34 ,top=194 ,right=2781 ,bottom=194 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<C>id='CYYYYO', left=44, top=206, right=141, bottom=256, align='right' ,mask='XXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='월' ,left=200 ,top=206 ,right=247 ,bottom=256 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CMMO', left=153, top=206, right=203, bottom=256, align='right' ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=206 ,right=163 ,bottom=256 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=34 ,top=259 ,right=2781 ,bottom=259 </L>
			<T>id='인원' ,left=269 ,top=75 ,right=347 ,bottom=184 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CMM', left=153, top=266, right=203, bottom=316, align='right' ,mask='XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=266 ,right=163 ,bottom=316 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='월' ,left=200 ,top=266 ,right=247 ,bottom=316 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CYYYY', left=44, top=266, right=141, bottom=316, align='right' ,mask='XXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='COUNTP', left=269, top=206, right=347, bottom=256, align='right'</C>
			<C>id='COUNTR', left=269, top=266, right=347, bottom=316, align='right'</C>
			<T>id='전월대비증감' ,left=78 ,top=325 ,right=247 ,bottom=375 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=2475 ,top=62 ,right=2475 ,bottom=381 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=256 ,top=62 ,right=256 ,bottom=381 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=34 ,top=384 ,right=2781 ,bottom=384 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='지급내역' ,left=359 ,top=75 ,right=1328 ,bottom=125 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=353 ,top=128 ,right=2472 ,bottom=128 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='기본급' ,left=359 ,top=134 ,right=550 ,bottom=184 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='계' ,left=1106 ,top=134 ,right=1328 ,bottom=184 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='기타' ,left=925 ,top=134 ,right=1094 ,bottom=184 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='시간외수당' ,left=738 ,top=134 ,right=916 ,bottom=184 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='직책수당' ,left=559 ,top=134 ,right=728 ,bottom=184 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1100 ,top=131 ,right=1100 ,bottom=381 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=31 ,top=62 ,right=31 ,bottom=381 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<C>id='P12000R', left=738, top=266, right=916, bottom=316, align='right'</C>
			<C>id={PXTOTALR-PXTOTAL}, left=925, top=325, right=1094, bottom=375, align='right', Dec=0</C>
			<C>id='PXTOTALR', left=925, top=266, right=1094, bottom=316, align='right'</C>
			<C>id='PXTOTAL', left=925, top=206, right=1094, bottom=256, align='right'</C>
			<L> left=1338 ,top=66 ,right=1338 ,bottom=384 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=1097 ,top=128 ,right=1338 ,bottom=128 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<C>id='S91000', left=1106, top=206, right=1328, bottom=256, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S91000R', left=1106, top=266, right=1328, bottom=316, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id={S91000R-S91000}, left=1106, top=325, right=1328, bottom=375, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<T>id='공제내역' ,left=1350 ,top=75 ,right=2466 ,bottom=125 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='기타' ,left=1884 ,top=134 ,right=2053 ,bottom=184 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='고용보험' ,left=1706 ,top=134 ,right=1875 ,bottom=184 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='주민세' ,left=1528 ,top=134 ,right=1697 ,bottom=184 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='갑근세' ,left=1350 ,top=134 ,right=1519 ,bottom=184 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='T11000', left=1350, top=206, right=1519, bottom=256, align='right'</C>
			<C>id='T11000R', left=1350, top=266, right=1519, bottom=316, align='right'</C>
			<C>id={T11000R-T11000}, left=1350, top=325, right=1519, bottom=375, align='right', Dec=0</C>
			<C>id='', left=2063, top=206, right=2231, bottom=256, align='right'</C>
			<C>id='BXTOTAL', left=1884, top=206, right=2053, bottom=256, align='right'</C>
			<C>id='T12000', left=1528, top=206, right=1697, bottom=256, align='right'</C>
			<C>id='', left=2063, top=266, right=2231, bottom=316, align='right'</C>
			<C>id='BXTOTALR', left=1884, top=266, right=2053, bottom=316, align='right'</C>
			<C>id='T12000R', left=1528, top=266, right=1697, bottom=316, align='right'</C>
			<C>id='', left=2063, top=325, right=2231, bottom=375, align='right', Dec=0</C>
			<C>id={BXTOTALR-BXTOTAL}, left=1884, top=325, right=2053, bottom=375, align='right', Dec=0</C>
			<C>id={T12000R-T12000}, left=1528, top=325, right=1697, bottom=375, align='right', Dec=0</C>
			<L> left=1700 ,top=131 ,right=1700 ,bottom=384 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id={B13000R-B13000}, left=1706, top=325, right=1875, bottom=375, align='right', Dec=0</C>
			<C>id='B13000R', left=1706, top=266, right=1875, bottom=316, align='right'</C>
			<C>id='B13000', left=1706, top=206, right=1875, bottom=256, align='right'</C>
			<L> left=1878 ,top=131 ,right=1878 ,bottom=384 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2056 ,top=131 ,right=2056 ,bottom=384 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='' ,left=2063 ,top=134 ,right=2231 ,bottom=184 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=2238 ,top=131 ,right=2238 ,bottom=384 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='계' ,left=2244 ,top=134 ,right=2466 ,bottom=184 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id={S93000R-S93000}, left=2244, top=325, right=2466, bottom=375, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S93000R', left=2244, top=266, right=2466, bottom=316, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S93000', left=2244, top=206, right=2466, bottom=256, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=2238 ,top=128 ,right=2475 ,bottom=128 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='실지급액' ,left=2488 ,top=75 ,right=2772 ,bottom=184 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id={S94000R-S94000}, left=2488, top=325, right=2772, bottom=375, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='S94000R', left=2488, top=266, right=2772, bottom=316, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='S94000', left=2488, top=206, right=2772, bottom=256, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=2781 ,top=62 ,right=2781 ,bottom=384 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<C>id='P12000', left=738, top=206, right=916, bottom=256, align='right'</C>
			<C>id='P11000', left=559, top=206, right=728, bottom=256, align='right'</C>
			<C>id='P11000R', left=559, top=266, right=728, bottom=316, align='right'</C>
			<C>id='P10000', left=359, top=206, right=550, bottom=256, align='right'</C>
			<C>id='P10000R', left=359, top=266, right=550, bottom=316, align='right'</C>
			<C>id={P12000R-P12000}, left=738, top=325, right=916, bottom=375, align='right', Dec=0</C>
			<C>id={P11000R-P11000}, left=559, top=325, right=728, bottom=375, align='right', Dec=0</C>
			<C>id={P10000R-P10000}, left=359, top=325, right=550, bottom=375, align='right', Dec=0</C>
			<L> left=72 ,top=319 ,right=2781 ,bottom=319 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=72 ,top=319 ,right=72 ,bottom=384 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=353 ,top=66 ,right=353 ,bottom=384 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=1522 ,top=131 ,right=1522 ,bottom=384 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=919 ,top=131 ,right=919 ,bottom=384 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=731 ,top=131 ,right=731 ,bottom=384 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=553 ,top=131 ,right=553 ,bottom=384 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id={COUNTR-COUNTP}, left=269, top=325, right=347, bottom=375, align='right', Dec=0</C>
		</B>
	</R>
</A>

<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=141
	<R>id='급여지급현황_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='gcds_report1' 
		<B>id=default ,left=0,top=0 ,right=2869 ,bottom=431 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=31 ,top=94 ,right=2781 ,bottom=94 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='구  분' ,left=44 ,top=106 ,right=247 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='DEPTNM', left=94, top=41, right=606, bottom=84, align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=31 ,top=225 ,right=2781 ,bottom=225 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='월' ,left=200 ,top=237 ,right=247 ,bottom=287 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='DCMMO', left=153, top=237, right=203, bottom=287, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=237 ,right=163 ,bottom=287 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='DCYYYYO', left=44, top=237, right=141, bottom=287, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='DCYYYY', left=44, top=297, right=141, bottom=347, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=31 ,top=291 ,right=2781 ,bottom=291 </L>
			<T>id='월' ,left=200 ,top=297 ,right=247 ,bottom=347 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='DCMM', left=153, top=297, right=203, bottom=347, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='.' ,left=138 ,top=297 ,right=163 ,bottom=347 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='인원' ,left=269 ,top=106 ,right=347 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=72 ,top=350 ,right=2781 ,bottom=350 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id={DCOUNTR-DCOUNTP}, left=269, top=356, right=347, bottom=406, align='right', Dec=0</C>
			<C>id='DCOUNTR', left=269, top=297, right=347, bottom=347, align='right'</C>
			<C>id='DCOUNTP', left=269, top=237, right=347, bottom=287, align='right'</C>
			<L> left=353 ,top=159 ,right=2472 ,bottom=159 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='시간외수당' ,left=738 ,top=166 ,right=916 ,bottom=216 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='기타' ,left=925 ,top=166 ,right=1094 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=256 ,top=97 ,right=256 ,bottom=409 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=31 ,top=416 ,right=2781 ,bottom=416 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='전월대비증감' ,left=78 ,top=356 ,right=247 ,bottom=406 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=31 ,top=97 ,right=31 ,bottom=416 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=1338 ,top=97 ,right=1338 ,bottom=416 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='공제내역' ,left=1350 ,top=106 ,right=2466 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='계' ,left=1106 ,top=166 ,right=1328 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='주민세' ,left=1528 ,top=166 ,right=1697 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1100 ,top=159 ,right=1100 ,bottom=416 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='갑근세' ,left=1350 ,top=166 ,right=1519 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='계' ,left=2244 ,top=166 ,right=2466 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='' ,left=2063 ,top=166 ,right=2231 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='고용보험' ,left=1706 ,top=166 ,right=1875 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id={DT12000R-DT12000}, left=1528, top=356, right=1697, bottom=406, align='right', Dec=0</C>
			<C>id='DT12000R', left=1528, top=297, right=1697, bottom=347, align='right'</C>
			<C>id='DB13000R', left=1706, top=297, right=1875, bottom=347, align='right'</C>
			<C>id={DB13000R-DB13000}, left=1706, top=356, right=1875, bottom=406, align='right', Dec=0</C>
			<T>id='기타' ,left=1884 ,top=166 ,right=2053 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='DBXTOTAL', left=1884, top=237, right=2053, bottom=287, align='right'</C>
			<C>id='DBXTOTALR', left=1884, top=297, right=2053, bottom=347, align='right'</C>
			<C>id={DBXTOTALR-DBXTOTAL}, left=1884, top=356, right=2053, bottom=406, align='right', Dec=0</C>
			<C>id='', left=2063, top=237, right=2231, bottom=287, align='right'</C>
			<C>id='', left=2063, top=297, right=2231, bottom=347, align='right'</C>
			<C>id='', left=2063, top=356, right=2231, bottom=406, align='right', Dec=0</C>
			<L> left=1700 ,top=159 ,right=1700 ,bottom=416 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1878 ,top=159 ,right=1878 ,bottom=416 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2056 ,top=159 ,right=2056 ,bottom=416 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='DS93000', left=2244, top=237, right=2466, bottom=287, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='DS93000R', left=2244, top=297, right=2466, bottom=347, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id={DS93000R-DS93000}, left=2244, top=356, right=2466, bottom=406, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<L> left=2238 ,top=159 ,right=2238 ,bottom=416 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=2475 ,top=97 ,right=2475 ,bottom=416 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2238 ,top=159 ,right=2475 ,bottom=159 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='실지급액' ,left=2488 ,top=106 ,right=2772 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id={DS94000R-DS94000}, left=2488, top=356, right=2772, bottom=406, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='DS94000R', left=2488, top=297, right=2772, bottom=347, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='DS94000', left=2488, top=237, right=2772, bottom=287, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=2781 ,top=97 ,right=2781 ,bottom=416 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<C>id={DS91000R-DS91000}, left=1106, top=356, right=1328, bottom=406, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='DS91000R', left=1106, top=297, right=1328, bottom=347, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='DS91000', left=1106, top=237, right=1328, bottom=287, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='DPXTOTAL', left=925, top=237, right=1094, bottom=287, align='right'</C>
			<C>id='DPXTOTALR', left=925, top=297, right=1094, bottom=347, align='right'</C>
			<C>id={DPXTOTALR-DPXTOTAL}, left=925, top=356, right=1094, bottom=406, align='right', Dec=0</C>
			<C>id={DP12000R-DP12000}, left=738, top=356, right=916, bottom=406, align='right', Dec=0</C>
			<C>id='DP12000R', left=738, top=297, right=916, bottom=347, align='right'</C>
			<C>id='DP12000', left=738, top=237, right=916, bottom=287, align='right'</C>
			<C>id='DP11000', left=559, top=237, right=728, bottom=287, align='right'</C>
			<C>id='DP11000R', left=559, top=297, right=728, bottom=347, align='right'</C>
			<C>id={DP11000R-DP11000}, left=559, top=356, right=728, bottom=406, align='right', Dec=0</C>
			<C>id={DP10000R-DP10000}, left=359, top=356, right=550, bottom=406, align='right', Dec=0</C>
			<C>id='DP10000R', left=359, top=297, right=550, bottom=347, align='right'</C>
			<C>id='DP10000', left=359, top=237, right=550, bottom=287, align='right'</C>
			<C>id='DT12000', left=1528, top=237, right=1697, bottom=287, align='right'</C>
			<C>id='DT11000', left=1350, top=237, right=1519, bottom=287, align='right'</C>
			<C>id='DT11000R', left=1350, top=297, right=1519, bottom=347, align='right'</C>
			<C>id={DT11000R-DT11000}, left=1350, top=356, right=1519, bottom=406, align='right', Dec=0</C>
			<T>id='지급내역' ,left=359 ,top=106 ,right=1328 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='기본급' ,left=359 ,top=166 ,right=550 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='직책수당' ,left=559 ,top=166 ,right=728 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=1100 ,top=159 ,right=1338 ,bottom=159 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=353 ,top=94 ,right=353 ,bottom=419 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=1522 ,top=159 ,right=1522 ,bottom=416 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=919 ,top=159 ,right=919 ,bottom=416 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=731 ,top=159 ,right=731 ,bottom=416 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=553 ,top=159 ,right=553 ,bottom=416 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=72 ,top=353 ,right=72 ,bottom=419 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id={currow+2}, left=31, top=41, right=88, bottom=84, align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='DB13000', left=1706, top=237, right=1875, bottom=287, align='right'</C>
		</B>
	</R>
</A>

<B>id=Footer ,left=0 ,top=1895 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=8 ,top=0 ,right=2826 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=8 ,top=26 ,right=2815 ,bottom=106</T>
	<I>id='../../Common/img/icon.jpg' ,left=2400 ,top=5 ,right=2781 ,bottom=106</I>
</B>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- 소속별 급여지급 현황 -->
<comment id="__NSID__"><OBJECT id=gcrp_print2  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"	    value="gcds_report2">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="0">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=331 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='CYYYY', left=492, top=3, right=733, bottom=90, align='right' ,mask='XXXX년 ', face='Arial', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CMM', left=736, top=3, right=1532, bottom=90, align='left' ,mask='XX월 소속별 급여지급 현황', face='Arial', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=471 ,top=101 ,right=1529 ,bottom=101 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=26 ,top=143 ,right=1963 ,bottom=143 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=26 ,top=333 ,right=1963 ,bottom=331 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1966 ,top=146 ,right=1966 ,bottom=331 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=21 ,top=146 ,right=21 ,bottom=331 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=836 ,top=146 ,right=836 ,bottom=331 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1400 ,top=148 ,right=1400 ,bottom=331 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=963 ,top=238 ,right=963 ,bottom=331 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1550 ,top=148 ,right=1550 ,bottom=331 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='Print Date:' ,left=1627 ,top=58 ,right=1823 ,bottom=119 ,align='right'</T>
	<C>id='TODATEE', left=1826, top=58, right=1969, bottom=119 ,mask='XXXX.XX.XX'</C>
	<T>id='단위 : 원' ,left=1797 ,top=106 ,right=1969 ,bottom=167 ,align='right'</T>
	<T>id='소     속' ,left=400 ,top=220 ,right=818 ,bottom=302 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='%' ,left=1423 ,top=220 ,right=1527 ,bottom=291 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비   고' ,left=1614 ,top=217 ,right=1884 ,bottom=296 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급여지급' ,left=945 ,top=175 ,right=1156 ,bottom=257 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금액' ,left=974 ,top=262 ,right=1378 ,bottom=331 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인원' ,left=847 ,top=259 ,right=953 ,bottom=331 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=836 ,top=235 ,right=1400 ,bottom=235 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=384 ,top=146 ,right=384 ,bottom=331 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='소  속' ,left=45 ,top=220 ,right=373 ,bottom=302 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=69 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1550 ,top=0 ,right=1550 ,bottom=69 </L>
	<L> left=963 ,top=0 ,right=963 ,bottom=69 </L>
	<L> left=836 ,top=0 ,right=836 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1966 ,top=0 ,right=1966 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='SCOUNT', left=844, top=8, right=958, bottom=69, align='right'</C>
	<L> left=21 ,top=0 ,right=21 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1400 ,top=0 ,right=1400 ,bottom=69 </L>
	<C>id='S94000SUM', left=974, top=8, right=1389, bottom=69, align='right'</C>
	<L> left=384 ,top=0 ,right=384 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{decode(curlevel,1,\'소  계\',DEPTNM2)}', left=392, top=8, right=828, bottom=69, align='left'</C>
	<C>id='DEPTNM', left=34, top=8, right=376, bottom=69, align='left'</C>
	<C>id='PERRATE', left=1408, top=8, right=1540, bottom=69, align='right', supplevel=2</C>
	<L> left=26 ,top=69 ,right=1966 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=5 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=24 ,top=5 ,right=1963 ,bottom=5 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
</B>
<B>id=Tail ,left=0,top=0 ,right=2000 ,bottom=71 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=384 ,top=0 ,right=384 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1400 ,top=0 ,right=1400 ,bottom=69 </L>
	<L> left=21 ,top=0 ,right=21 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1966 ,top=0 ,right=1966 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=836 ,top=0 ,right=836 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=963 ,top=0 ,right=963 ,bottom=69 </L>
	<L> left=1550 ,top=0 ,right=1550 ,bottom=69 </L>
	<T>id='합 계' ,left=101 ,top=5 ,right=312 ,bottom=69</T>
	<S>id='{SUM(SCOUNT)}' ,left=844 ,top=3 ,right=955 ,bottom=69 ,align='right'</S>
	<S>id='{SUM(S94000SUM)}' ,left=976 ,top=3 ,right=1389 ,bottom=69 ,align='right'</S>
	<S>id='{SUM(PERRATE)}' ,left=1408 ,top=3 ,right=1543 ,bottom=69 ,align='right'</S>
	<L> left=24 ,top=69 ,right=1963 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2770 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=13 ,top=19 ,right=1961 ,bottom=98</T>
	<I>id='../../Common/img/icon.jpg' ,left=1609 ,top=5 ,right=1990 ,bottom=101</I>
	<L> left=26 ,top=0 ,right=1974 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- 급여 변동 현황 -->
<comment id="__NSID__"><OBJECT id=gcrp_print3  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"	    value="gcds_grid_ec03az">
	<PARAM NAME="PaperSize"					VALUE="A3">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="80">
	<PARAM NAME="Format" VALUE="
<B>id=FHeader ,left=0,top=0 ,right=4100 ,bottom=616 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='CTITLE', left=1516, top=6, right=2584, bottom=94, face='HY중고딕', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=2, pencolor=#000000, Dec=0</C>
	<L> left=0 ,top=237 ,right=3978 ,bottom=237 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=0 ,top=234 ,right=0 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=3981 ,top=234 ,right=3981 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=166 ,top=328 ,right=3981 ,bottom=328 </L>
	<L> left=1559 ,top=422 ,right=659 ,bottom=422 </L>
	<T>id='학자금' ,left=3738 ,top=387 ,right=3863 ,bottom=453 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='임원직책' ,left=3606 ,top=387 ,right=3728 ,bottom=453 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전월소급' ,left=3475 ,top=387 ,right=3600 ,bottom=453 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본' ,left=1756 ,top=391 ,right=1872 ,bottom=472 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시간외' ,left=2041 ,top=391 ,right=2153 ,bottom=472 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1594 ,top=391 ,right=1706 ,bottom=472 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근속' ,left=2166 ,top=362 ,right=2278 ,bottom=431 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자 기' ,left=2294 ,top=362 ,right=2409 ,bottom=431 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='가 족' ,left=2428 ,top=362 ,right=2541 ,bottom=431 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차 량' ,left=2556 ,top=362 ,right=2669 ,bottom=431 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='개인' ,left=2819 ,top=362 ,right=2931 ,bottom=431 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연금' ,left=2819 ,top=416 ,right=2931 ,bottom=481 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자격' ,left=2688 ,top=362 ,right=2803 ,bottom=431 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수당' ,left=2688 ,top=416 ,right=2803 ,bottom=481 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='남북' ,left=2950 ,top=362 ,right=3066 ,bottom=431 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='경협' ,left=2950 ,top=416 ,right=3066 ,bottom=481 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특수지' ,left=3084 ,top=362 ,right=3200 ,bottom=431 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수당' ,left=3084 ,top=416 ,right=3200 ,bottom=481 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지역근무' ,left=3213 ,top=362 ,right=3338 ,bottom=431 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수당' ,left=3213 ,top=416 ,right=3338 ,bottom=481 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직책' ,left=1906 ,top=391 ,right=2019 ,bottom=472 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='유지비' ,left=2556 ,top=416 ,right=2669 ,bottom=481 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부양비' ,left=2428 ,top=416 ,right=2541 ,bottom=481 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계발비' ,left=2294 ,top=416 ,right=2409 ,bottom=481 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수당' ,left=2166 ,top=416 ,right=2278 ,bottom=481 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인원' ,left=669 ,top=431 ,right=731 ,bottom=512 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금액' ,left=738 ,top=431 ,right=881 ,bottom=512 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인원' ,left=891 ,top=431 ,right=956 ,bottom=512 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금액' ,left=963 ,top=431 ,right=1106 ,bottom=512 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인원' ,left=1116 ,top=431 ,right=1181 ,bottom=512 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금액' ,left=1188 ,top=431 ,right=1331 ,bottom=512 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인원' ,left=1341 ,top=431 ,right=1406 ,bottom=512 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금액' ,left=1413 ,top=431 ,right=1556 ,bottom=512 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='승진' ,left=1341 ,top=334 ,right=1556 ,bottom=416 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='퇴사' ,left=1116 ,top=334 ,right=1331 ,bottom=416 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='입사' ,left=891 ,top=334 ,right=1106 ,bottom=416 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=669 ,top=334 ,right=881 ,bottom=416 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금액' ,left=491 ,top=387 ,right=656 ,bottom=469 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인원' ,left=419 ,top=387 ,right=481 ,bottom=469 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인원' ,left=172 ,top=387 ,right=234 ,bottom=469 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비고' ,left=3872 ,top=387 ,right=3969 ,bottom=453 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='합계' ,left=6 ,top=531 ,right=159 ,bottom=616 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=0 ,top=237 ,right=172 ,bottom=519 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='증감내역' ,left=2163 ,top=247 ,right=2575 ,bottom=328 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=0 ,top=616 ,right=3981 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=0 ,top=522 ,right=3981 ,bottom=522 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='직위' ,left=9 ,top=441 ,right=109 ,bottom=516 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PRVYYYYMM', left=175, top=256, right=403, bottom=319, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NOWYYYYMM', left=422, top=256, right=653, bottom=319, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PRVNUM', left=169, top=544, right=234, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A16_AMT', left=3738, top=544, right=3863, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A15_AMT', left=3603, top=544, right=3728, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A14_AMT', left=3472, top=544, right=3600, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A13_AMT', left=3341, top=544, right=3469, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A12_AMT', left=3209, top=544, right=3338, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A11_AMT', left=3078, top=544, right=3203, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A10_AMT', left=2947, top=544, right=3072, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A9_AMT', left=2816, top=544, right=2941, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A8_AMT', left=2684, top=544, right=2813, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A7_AMT', left=2553, top=544, right=2681, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A6_AMT', left=2422, top=544, right=2547, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A5_AMT', left=2291, top=544, right=2419, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A4_AMT', left=2159, top=544, right=2288, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A3_AMT', left=2031, top=544, right=2156, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A2_AMT', left=1891, top=544, right=2028, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A1_AMT', left=1744, top=544, right=1884, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AA_AMT', left=1569, top=544, right=1734, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SUNGAMT', left=1413, top=544, right=1556, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SUNGNUM', left=1341, top=544, right=1406, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAEAMT', left=1188, top=544, right=1331, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAENUM', left=1116, top=544, right=1181, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='IBSAAMT', left=963, top=544, right=1106, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='IBSANUM', left=891, top=544, right=956, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ITSAMT', left=738, top=544, right=881, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ITSNUM', left=669, top=544, right=731, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NEXAMT', left=491, top=544, right=656, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NEXNUM', left=419, top=544, right=481, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PRVAMT', left=241, top=544, right=406, bottom=606, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='단위 : 원' ,left=3806 ,top=166 ,right=3978 ,bottom=228 ,align='right'</T>
	<C>id='TODATEE', left=3834, top=97, right=3978, bottom=159, align='right' ,mask='XXXX.XX.XX'</C>
	<T>id='Print Date:' ,left=3638 ,top=97 ,right=3831 ,bottom=159 ,align='right'</T>
	<T>id='금액' ,left=241 ,top=387 ,right=406 ,bottom=469 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=234 ,top=331 ,right=234 ,bottom=616 </L>
	<L> left=484 ,top=331 ,right=484 ,bottom=616 </L>
	<L> left=734 ,top=425 ,right=734 ,bottom=612 </L>
	<L> left=888 ,top=331 ,right=888 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1406 ,top=425 ,right=1406 ,bottom=612 </L>
	<L> left=1181 ,top=425 ,right=1181 ,bottom=612 </L>
	<L> left=959 ,top=425 ,right=959 ,bottom=612 </L>
	<L> left=166 ,top=237 ,right=166 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=663 ,top=237 ,right=663 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=413 ,top=237 ,right=413 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='구분' ,left=66 ,top=247 ,right=159 ,bottom=328 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1738 ,top=331 ,right=1738 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1563 ,top=331 ,right=1563 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1338 ,top=331 ,right=1338 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1113 ,top=331 ,right=1113 ,bottom=616 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1888 ,top=328 ,right=1888 ,bottom=616 </L>
	<L> left=2028 ,top=328 ,right=2028 ,bottom=616 </L>
	<L> left=2156 ,top=328 ,right=2156 ,bottom=616 </L>
	<L> left=2288 ,top=328 ,right=2288 ,bottom=616 </L>
	<L> left=2419 ,top=328 ,right=2419 ,bottom=616 </L>
	<L> left=2550 ,top=328 ,right=2550 ,bottom=616 </L>
	<L> left=2681 ,top=328 ,right=2681 ,bottom=616 </L>
	<L> left=2813 ,top=328 ,right=2813 ,bottom=616 </L>
	<L> left=2944 ,top=328 ,right=2944 ,bottom=616 </L>
	<L> left=3075 ,top=328 ,right=3075 ,bottom=616 </L>
	<L> left=3206 ,top=328 ,right=3206 ,bottom=616 </L>
	<L> left=3338 ,top=328 ,right=3338 ,bottom=616 </L>
	<T>id='근무수당' ,left=3344 ,top=416 ,right=3469 ,bottom=481 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='휴    일' ,left=3344 ,top=362 ,right=3469 ,bottom=431 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3469 ,top=328 ,right=3469 ,bottom=616 </L>
	<L> left=3600 ,top=328 ,right=3600 ,bottom=616 </L>
	<L> left=3731 ,top=328 ,right=3731 ,bottom=616 </L>
	<L> left=3866 ,top=328 ,right=3866 ,bottom=616 </L>
</B>
<B>id=default ,left=0,top=0 ,right=4100 ,bottom=72 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=166 ,top=0 ,right=166 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=0 ,top=0 ,right=0 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=888 ,top=0 ,right=888 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='PAYGRDNM', left=6, top=6, right=159, bottom=66, align='left', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NEXNUM', left=419, top=6, right=481, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NEXAMT', left=491, top=6, right=656, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ITSNUM', left=669, top=6, right=731, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ITSAMT', left=738, top=6, right=881, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='IBSANUM', left=891, top=6, right=956, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='IBSAAMT', left=963, top=6, right=1106, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAENUM', left=1116, top=6, right=1181, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAEAMT', left=1188, top=6, right=1331, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SUNGNUM', left=1341, top=6, right=1406, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SUNGAMT', left=1413, top=6, right=1556, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A1_AMT', left=1744, top=6, right=1884, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AA_AMT', left=1569, top=6, right=1734, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3981 ,top=0 ,right=3981 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='PRVNUM', left=172, top=6, right=238, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=234 ,top=3 ,right=234 ,bottom=72 </L>
	<C>id='PRVAMT', left=241, top=6, right=406, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=413 ,top=0 ,right=413 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=484 ,top=0 ,right=484 ,bottom=69 </L>
	<L> left=663 ,top=0 ,right=663 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=734 ,top=0 ,right=734 ,bottom=69 </L>
	<L> left=959 ,top=0 ,right=959 ,bottom=69 </L>
	<L> left=1113 ,top=0 ,right=1113 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1181 ,top=0 ,right=1181 ,bottom=69 </L>
	<L> left=1338 ,top=0 ,right=1338 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1406 ,top=0 ,right=1406 ,bottom=69 </L>
	<L> left=1563 ,top=0 ,right=1563 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1738 ,top=0 ,right=1738 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1888 ,top=0 ,right=1888 ,bottom=69 </L>
	<C>id='A2_AMT', left=1891, top=6, right=2028, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A3_AMT', left=2031, top=6, right=2156, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2028 ,top=0 ,right=2028 ,bottom=69 </L>
	<L> left=2156 ,top=0 ,right=2156 ,bottom=69 </L>
	<C>id='A4_AMT', left=2159, top=6, right=2288, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2288 ,top=0 ,right=2288 ,bottom=69 </L>
	<C>id='A5_AMT', left=2291, top=6, right=2419, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2419 ,top=0 ,right=2419 ,bottom=69 </L>
	<C>id='A6_AMT', left=2422, top=6, right=2547, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2550 ,top=0 ,right=2550 ,bottom=69 </L>
	<C>id='A7_AMT', left=2553, top=6, right=2681, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2681 ,top=0 ,right=2681 ,bottom=69 </L>
	<C>id='A8_AMT', left=2684, top=6, right=2813, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2813 ,top=0 ,right=2813 ,bottom=69 </L>
	<C>id='A9_AMT', left=2816, top=6, right=2941, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2944 ,top=0 ,right=2944 ,bottom=69 </L>
	<C>id='A10_AMT', left=2947, top=6, right=3072, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3075 ,top=0 ,right=3075 ,bottom=69 </L>
	<C>id='A11_AMT', left=3078, top=6, right=3203, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3206 ,top=0 ,right=3206 ,bottom=69 </L>
	<C>id='A12_AMT', left=3209, top=6, right=3338, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3338 ,top=0 ,right=3338 ,bottom=69 </L>
	<C>id='A13_AMT', left=3341, top=6, right=3469, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3469 ,top=0 ,right=3469 ,bottom=69 </L>
	<C>id='A14_AMT', left=3472, top=6, right=3600, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3600 ,top=0 ,right=3600 ,bottom=69 </L>
	<C>id='A15_AMT', left=3603, top=6, right=3728, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3731 ,top=0 ,right=3731 ,bottom=69 </L>
	<C>id='A16_AMT', left=3738, top=6, right=3863, bottom=66, align='right', face='Arial', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=3866 ,top=0 ,right=3866 ,bottom=69 </L>
	<L> left=0 ,top=72 ,right=3981 ,bottom=72 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=4100 ,bottom=63 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=0 ,top=0 ,right=3981 ,bottom=0 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2770 ,right=4100 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=13 ,top=19 ,right=4069 ,bottom=97</T>
	<I>id='../../Common/img/icon.jpg' ,left=3697 ,top=0 ,right=4078 ,bottom=100</I>
	<L> left=25 ,top=0 ,right=4075 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- 당월급여변동자 -->
<comment id="__NSID__"><OBJECT id=gcrp_print7  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"	    value="gcds_change_7">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2870 ,bottom=350 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=895 ,top=5 ,right=1917 ,bottom=105 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=2</X>
	<C>id='CTITLE', left=924, top=13, right=1901, bottom=98, face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=11 ,top=208 ,right=2817 ,bottom=208 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<C>id='PRINTDT', left=2614, top=105, right=2817, bottom=153, align='right' ,mask='XXXX.XX.XX', face='굴림', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Print Date:' ,left=2351 ,top=105 ,right=2612 ,bottom=153 ,align='right' ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=11 ,top=208 ,right=11 ,bottom=351 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=2817 ,top=208 ,right=2817 ,bottom=351 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='자기계발' ,left=1132 ,top=282 ,right=1224 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근무일수' ,left=558 ,top=219 ,right=732 ,bottom=279 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=11 ,top=356 ,right=2817 ,bottom=351 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='변동수당' ,left=1925 ,top=219 ,right=2588 ,bottom=279 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=63 ,top=211 ,right=63 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=208 ,top=211 ,right=208 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=332 ,top=211 ,right=332 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1922 ,top=211 ,right=1922 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2591 ,top=208 ,right=2591 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=556 ,top=279 ,right=729 ,bottom=279 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1925 ,top=279 ,right=2588 ,bottom=279 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='순' ,left=21 ,top=219 ,right=58 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=479 ,top=208 ,right=479 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='소계' ,left=1798 ,top=282 ,right=1917 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=742 ,top=279 ,right=1925 ,bottom=279 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='전월소급' ,left=2346 ,top=282 ,right=2459 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현장(조장)' ,left=2233 ,top=282 ,right=2343 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2462 ,top=282 ,right=2462 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2343 ,top=282 ,right=2343 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2230 ,top=282 ,right=2230 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2127 ,top=282 ,right=2127 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='소계' ,left=2464 ,top=282 ,right=2588 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비고' ,left=2762 ,top=219 ,right=2812 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=2596 ,top=219 ,right=2757 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2759 ,top=208 ,right=2759 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='소속' ,left=68 ,top=219 ,right=208 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='변동일' ,left=213 ,top=219 ,right=332 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직위(급/호)' ,left=337 ,top=219 ,right=477 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=482 ,top=219 ,right=550 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='본사' ,left=556 ,top=282 ,right=598 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현장' ,left=600 ,top=282 ,right=642 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='해외' ,left=645 ,top=282 ,right=687 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=690 ,top=282 ,right=732 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=553 ,top=208 ,right=553 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=598 ,top=282 ,right=598 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=642 ,top=282 ,right=642 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=687 ,top=282 ,right=687 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=737 ,top=211 ,right=737 ,bottom=351 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='기본급' ,left=737 ,top=282 ,right=853 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=853 ,top=282 ,right=853 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='상여' ,left=856 ,top=282 ,right=948 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시간외' ,left=950 ,top=282 ,right=1043 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근속수당' ,left=1045 ,top=282 ,right=1129 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1129 ,top=282 ,right=1129 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1224 ,top=282 ,right=1224 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=948 ,top=282 ,right=948 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1043 ,top=282 ,right=1043 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='남북경협' ,left=1409 ,top=282 ,right=1503 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='개인연금' ,left=1506 ,top=282 ,right=1598 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1503 ,top=282 ,right=1503 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='조장수당' ,left=1601 ,top=282 ,right=1690 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량유지' ,left=1925 ,top=282 ,right=2025 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현장식대' ,left=2130 ,top=282 ,right=2230 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현장수당' ,left=2027 ,top=282 ,right=2127 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2025 ,top=282 ,right=2025 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='기타지급' ,left=1693 ,top=282 ,right=1798 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자격수당' ,left=1319 ,top=282 ,right=1406 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='가족부양' ,left=1227 ,top=282 ,right=1314 ,bottom=343 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1598 ,top=282 ,right=1598 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1690 ,top=282 ,right=1690 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1406 ,top=282 ,right=1406 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1314 ,top=282 ,right=1314 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='공통수당' ,left=737 ,top=219 ,right=1917 ,bottom=279 ,face='굴림' ,size=6 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1798 ,top=282 ,right=1798 ,bottom=351 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='단위 : 원' ,left=2614 ,top=158 ,right=2817 ,bottom=200 ,align='right' ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='GUBUN', left=11, top=158, right=666, bottom=200, align='left', face='굴림', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>


<B>id=default ,left=0,top=0 ,right=2870 ,bottom=68 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=11 ,top=0 ,right=11 ,bottom=66 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<C>id='P23000', left=1227, top=0, right=1314, bottom=66, align='right', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P28000', left=1319, top=0, right=1406, bottom=66, align='right', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P24000', left=1925, top=0, right=2025, bottom=66, align='right', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=63 ,top=0 ,right=63 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1314 ,top=0 ,right=1314 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2817 ,top=0 ,right=2817 ,bottom=66 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=2462 ,top=0 ,right=2462 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{CURROW}', left=21, top=0, right=58, bottom=66, face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTNMK2', left=68, top=0, right=208, bottom=66, align='left', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=208 ,top=0 ,right=208 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CHAGDT', left=213, top=0, right=332, bottom=66 ,mask='XXXX/XX/XX', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=482, top=0, right=550, bottom=66, align='left', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2025 ,top=0 ,right=2025 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2230 ,top=0 ,right=2230 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='P31000', left=2233, top=0, right=2343, bottom=66, align='right', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2343 ,top=0 ,right=2343 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='P39000', left=2346, top=0, right=2459, bottom=66, align='right', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CHG_SUM', left=2464, top=0, right=2588, bottom=66, align='right', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2591 ,top=0 ,right=2591 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2759 ,top=0 ,right=2759 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TOT_SUM', left=2596, top=0, right=2757, bottom=66, align='right', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ORDNM2', left=2762, top=0, right=2812, bottom=66, align='right', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=11 ,top=69 ,right=2817 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=332 ,top=0 ,right=332 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=479 ,top=0 ,right=479 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=553 ,top=0 ,right=553 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='BSDAY', left=556, top=0, right=598, bottom=66 ,mask='XXXX/XX/XX', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=598 ,top=3 ,right=598 ,bottom=69 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='HJDAY', left=600, top=0, right=642, bottom=66 ,mask='XXXX/XX/XX', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=642 ,top=0 ,right=642 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='FSDAY', left=645, top=0, right=687, bottom=66 ,mask='XXXX/XX/XX', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=687 ,top=0 ,right=687 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='DAY_SUM', left=690, top=0, right=732, bottom=66 ,mask='XXXX/XX/XX', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=737 ,top=0 ,right=737 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='P10000', left=737, top=0, right=853, bottom=66, align='right', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=853 ,top=0 ,right=853 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='P11000', left=856, top=0, right=948, bottom=66, align='right' ,mask='XXXX/XX/XX', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P12000', left=950, top=0, right=1043, bottom=66, align='right' ,mask='XXXX/XX/XX', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P21000', left=1045, top=0, right=1129, bottom=66, align='right' ,mask='XXXX/XX/XX', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1129 ,top=0 ,right=1129 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='P22000', left=1132, top=0, right=1224, bottom=66, align='right' ,mask='XXXX/XX/XX', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1224 ,top=0 ,right=1224 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1043 ,top=0 ,right=1043 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=948 ,top=0 ,right=948 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1406 ,top=0 ,right=1406 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='P29000', left=1409, top=0, right=1503, bottom=66, align='right', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P37000', left=1506, top=0, right=1598, bottom=66, align='right', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1503 ,top=0 ,right=1503 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='P27000', left=1601, top=0, right=1690, bottom=66, align='right', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P32000', left=2027, top=0, right=2127, bottom=66, align='right', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P35000', left=2130, top=0, right=2230, bottom=66, align='right', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2127 ,top=0 ,right=2127 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1922 ,top=0 ,right=1922 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='COM_SUM', left=1798, top=0, right=1917, bottom=66, align='right', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1798 ,top=0 ,right=1798 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1690 ,top=0 ,right=1690 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1598 ,top=0 ,right=1598 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='ETC_SUM', left=1693, top=0, right=1798, bottom=66, align='right', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAYSEQ', left=337, top=34, right=477, bottom=69, align='left', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAYGRDNM', left=337, top=0, right=477, bottom=34, align='left', face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>

<B>id=Footer ,left=0 ,top=1892 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=8 ,top=0 ,right=2818 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=8 ,top=26 ,right=2815 ,bottom=106</T>
	<I>id='../../Common/img/icon.jpg' ,left=2400 ,top=11 ,right=2781 ,bottom=106</I>
</B>



">
</OBJECT></comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>