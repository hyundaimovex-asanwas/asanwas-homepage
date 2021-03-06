<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	급여/급여개인정보
+ 프로그램 ID	: p020008.HTML
+ 기 능 정 의	: 조회|출력|엑셀
+ 변 경 이 력	: 
+ 수 정 이 력	: 이순미 - 2005.08.24 - 소스 정리
+ 서 블 릿 명	: p020008_s1
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Payroll/common/include/head.jsp"/>  
<title></title>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

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
var key_sabun="";
var gs_level;
var gs_treecd;
get_cookdata();
//lfn_init();
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	
	gcem_yymm_search.Text=gs_date2;	//적용년월

	//지급구분
	gcds_select_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1120"; 
	gcds_select_ec01az.Reset();

	//소속정보
	gcds_dept.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?v_str1=";
	gcds_dept.Reset();

	//직군정보
	//gcds_select_ec03az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2000"; 
	//gcds_select_ec03az.Reset();

	//직위정보
	gcds_select_ec04az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002"; 
	gcds_select_ec04az.Reset();

	//직급정보
	//gcds_select_ec05az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2001"; 
	//gcds_select_ec05az.Reset();

}

/******************************************************************************
	Description : 기본조회
******************************************************************************/
function ln_Query(){

	var str1 ="";// fn_trim(gcem_jigbil_search.Text);    //지급일자
	var str2 = fn_trim(gcem_yymm_search.Text);          //적용년월
	var str3 = fn_trim(gclx_select_ec01az.BindColVal);  //지급구분
	//var str4 = fn_trim(gclx_select_ec02az.BindColVal);  //소속
	var str4 ="";
	var str5 = "";  //직군
	var str6 = gusrid;              //사번부터
	var str7 = gusrid;             //사번까지
	var str8 ="";                //성명
	//var str9 = fn_trim(gclx_select_ec04az.BindColVal);  //직위
  var str9 ="";  
	var str10 = ""; //직급

	if (str3=="1" || str3=="4" || str3=="5" || str3=="6" || str3=="7"){	
		gcds_grid_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p020005_s1?"
										 + "v_str1=" + str1
										 + "&v_str2=" + str2
										 + "&v_str3=" + str3
										 + "&v_str4=" + str4
										 + "&v_str5=" + str5
										 + "&v_str6=" + str6
										 + "&v_str7=" + str7
										 + "&v_str8=" + str8
										 + "&v_str9=" + str9
										 + "&v_str10=" + str10
										 + "&v_str11=" + gs_level
										 + "&v_str12=" + gs_treecd
										 + "&v_str13=T";
    

		gcds_grid_ec01az.Reset(); //그리드
		gcds_grid_ec01az.rowposition=1;
	}
}

/*******************************************************************************
  Description : Grid 데이터를 Excel을 실행시켜 출력
******************************************************************************/
function ln_Excel(){
	if (gcds_grid_ec01az.countrow<1) alert("다운로드하실 자료가 없습니다.");
	else gcgd_grid_ec01az.RunExcel('급여내역');
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){
	if (gcds_grid_ec01az.countrow<1) {
		alert("출력하실 정보가 없습니다");
	} else {

		gcds_report0.ClearData();

		var ls_temp="CTITLE:STRING,EMPNO:STRING,EMPNMK:STRING,DEPTNM:STRING,PAYGRDNM:STRING,PAYSEQNM:STRING,PAYBNKNM:STRING,";
		ls_temp +="PAYNUM:STRING,P10000:DECIMAL,P11000:DECIMAL,P12000:DECIMAL,P21000:DECIMAL,P22000:DECIMAL,P23000:DECIMAL,";
		ls_temp +="P24000:DECIMAL,P25000:DECIMAL,P26000:DECIMAL,P27000:DECIMAL,P28000:DECIMAL,P29000:DECIMAL,";
		ls_temp +="P30000:DECIMAL,P31000:DECIMAL,P32000:DECIMAL,P36000:DECIMAL,P37000:DECIMAL,P38000:DECIMAL,";
		ls_temp +="PX0010:DECIMAL,PX0020:DECIMAL,PX0030:DECIMAL,PX0040:DECIMAL,P34000:DECIMAL,P35000:DECIMAL,P39000:DECIMAL,";
		ls_temp +="S91000:DECIMAL,T11000:DECIMAL,T12000:DECIMAL,B11000:DECIMAL,B12000:DECIMAL,B13000:DECIMAL,";
		ls_temp +="B15000:DECIMAL,B14000:DECIMAL,B16000:DECIMAL,BX0010:DECIMAL,BX0020:DECIMAL,BX0030:DECIMAL,";
		ls_temp +="BX0040:DECIMAL,P41000:DECIMAL,P42000:DECIMAL,T21000:DECIMAL,T22000:DECIMAL,S93000:DECIMAL,";
		ls_temp +="TS9100:DECIMAL,TT1100:DECIMAL,TT1200:DECIMAL,S94000:DECIMAL,STRTDT:STRING,PAYDT:STRING,JOBGRPHNM:STRING,";
		ls_temp +="DIVNM1:STRING,INSURNM1:STRING,TOTDAY1:STRING,TOTCNT1:DECIMAL,SUPAMT1:DECIMAL,TOTAMT1:DECIMAL,";
		ls_temp +="DIVNM2:STRING,INSURNM2:STRING,TOTDAY2:STRING,TOTCNT2:DECIMAL,SUPAMT2:DECIMAL,TOTAMT2:DECIMAL,";
		ls_temp +="DIVNM3:STRING,INSURNM3:STRING,TOTDAY3:STRING,TOTCNT3:DECIMAL,SUPAMT3:DECIMAL,TOTAMT3:DECIMAL,";
		ls_temp +="SANGNAME:STRING,SANGRAT:STRING,BAEBUSU:STRING,";
		ls_temp +="PR0020:STRING,PR0030:STRING,PR0040:STRING,BR0020:STRING,BR0030:STRING,BR0040:STRING,";
		ls_temp +="APLAMT:DECIMAL,APLRAT:DECIMAL,APPCNT:DECIMAL,APJAMT:DECIMAL,AMT_1:DECIMAL,";
		ls_temp +="COACNT:DECIMAL,COAAMT:DECIMAL,COJAMT:DECIMAL,COLAMT:DECIMAL,AMT_2:DECIMAL";

		gcds_report0.SetDataHeader(ls_temp);
		
		var row = gcds_grid_ec01az.rowposition;

	for(s=1;s<=gcds_grid_ec01az.countrow;s++) {

		gcds_report0.Addrow();

		//REPORT TITLE START--------------------------------------------------------------------------------------
		if (gcds_grid_ec01az.namevalue(s,"PAYDIV") == '정기급여') { 
			gcds_report0.namevalue(s,"CTITLE")=gcds_grid_ec01az.namevalue(s,"PAYDIV").substring(2,4) + " 명세서 ["
																				+ gcds_grid_ec01az.namevalue(s,"APPDT").substring(0,4) + "년"
																				+ gcds_grid_ec01az.namevalue(s,"APPDT").substring(4,6) + "월]";
		
		}else { 
			gcds_report0.namevalue(s,"CTITLE")=gcds_grid_ec01az.namevalue(s,"PAYDIV").substring(0,2) + " 명세서 ["
																				+ gcds_grid_ec01az.namevalue(s,"APPDT").substring(0,4) + "년"
																				+ gcds_grid_ec01az.namevalue(s,"APPDT").substring(4,6) + "월]";
		}
		//REPORT TITLE END----------------------------------------------------------------------------------------

		gcds_report0.namevalue(s,"EMPNO")=gcds_grid_ec01az.namevalue(s,"EMPNO");
		gcds_report0.namevalue(s,"EMPNMK")=gcds_grid_ec01az.namevalue(s,"EMPNMK");
		gcds_report0.namevalue(s,"DEPTNM")=gcds_grid_ec01az.namevalue(s,"DEPTNM");
		gcds_report0.namevalue(s,"PAYGRDNM")=gcds_grid_ec01az.namevalue(s,"PAYGRDNM");
		gcds_report0.namevalue(s,"PAYSEQNM")=gcds_grid_ec01az.namevalue(s,"PAYSEQNM");
		gcds_report0.namevalue(s,"PAYBNKNM")=gcds_grid_ec01az.namevalue(s,"PAYBNKNM");
		gcds_report0.namevalue(s,"PAYNUM")=gcds_grid_ec01az.namevalue(s,"PAYNUM");
		gcds_report0.namevalue(s,"P10000")=gcds_grid_ec01az.namevalue(s,"P10000");
		gcds_report0.namevalue(s,"P11000")=gcds_grid_ec01az.namevalue(s,"P11000");
		gcds_report0.namevalue(s,"P12000")=gcds_grid_ec01az.namevalue(s,"P12000");
		gcds_report0.namevalue(s,"P21000")=gcds_grid_ec01az.namevalue(s,"P21000");
		gcds_report0.namevalue(s,"P22000")=gcds_grid_ec01az.namevalue(s,"P22000");
		gcds_report0.namevalue(s,"P23000")=gcds_grid_ec01az.namevalue(s,"P23000");
		gcds_report0.namevalue(s,"P24000")=gcds_grid_ec01az.namevalue(s,"P24000");
		gcds_report0.namevalue(s,"P25000")=gcds_grid_ec01az.namevalue(s,"P25000");
		gcds_report0.namevalue(s,"P26000")=gcds_grid_ec01az.namevalue(s,"P26000");
		gcds_report0.namevalue(s,"P27000")=gcds_grid_ec01az.namevalue(s,"P27000");
		gcds_report0.namevalue(s,"P28000")=gcds_grid_ec01az.namevalue(s,"P28000");
		gcds_report0.namevalue(s,"P29000")=gcds_grid_ec01az.namevalue(s,"P29000");
		gcds_report0.namevalue(s,"P30000")=gcds_grid_ec01az.namevalue(s,"P30000");
		gcds_report0.namevalue(s,"P31000")=gcds_grid_ec01az.namevalue(s,"P31000");
		gcds_report0.namevalue(s,"P32000")=gcds_grid_ec01az.namevalue(s,"P32000");
		gcds_report0.namevalue(s,"P34000")=gcds_grid_ec01az.namevalue(s,"P34000");
		gcds_report0.namevalue(s,"P35000")=gcds_grid_ec01az.namevalue(s,"P35000");
		gcds_report0.namevalue(s,"P39000")=gcds_grid_ec01az.namevalue(s,"P39000");
		gcds_report0.namevalue(s,"P36000")=gcds_grid_ec01az.namevalue(s,"P36000");
		gcds_report0.namevalue(s,"P37000")=gcds_grid_ec01az.namevalue(s,"P37000");
		gcds_report0.namevalue(s,"P38000")=gcds_grid_ec01az.namevalue(s,"P38000");
		gcds_report0.namevalue(s,"P41000")=gcds_grid_ec01az.namevalue(s,"P41000");
		gcds_report0.namevalue(s,"P42000")=gcds_grid_ec01az.namevalue(s,"P42000");
		gcds_report0.namevalue(s,"PX0010")=gcds_grid_ec01az.namevalue(s,"PX0010");
		gcds_report0.namevalue(s,"PX0020")=gcds_grid_ec01az.namevalue(s,"PX0020");
		gcds_report0.namevalue(s,"PX0030")=gcds_grid_ec01az.namevalue(s,"PX0030");
		gcds_report0.namevalue(s,"PX0040")=gcds_grid_ec01az.namevalue(s,"PX0040");

		gcds_report0.namevalue(s,"S91000")=gcds_grid_ec01az.namevalue(s,"S91000");
		gcds_report0.namevalue(s,"S93000")=gcds_grid_ec01az.namevalue(s,"S93000");
		gcds_report0.namevalue(s,"S94000")=gcds_grid_ec01az.namevalue(s,"S94000");
		gcds_report0.namevalue(s,"T11000")=gcds_grid_ec01az.namevalue(s,"T11000");
		gcds_report0.namevalue(s,"T12000")=gcds_grid_ec01az.namevalue(s,"T12000");
		gcds_report0.namevalue(s,"T21000")=gcds_grid_ec01az.namevalue(s,"T21000");
		gcds_report0.namevalue(s,"T22000")=gcds_grid_ec01az.namevalue(s,"T22000");
		gcds_report0.namevalue(s,"B11000")=gcds_grid_ec01az.namevalue(s,"B11000");
		gcds_report0.namevalue(s,"B12000")=gcds_grid_ec01az.namevalue(s,"B12000");
		gcds_report0.namevalue(s,"B13000")=gcds_grid_ec01az.namevalue(s,"B13000");
		gcds_report0.namevalue(s,"B14000")=gcds_grid_ec01az.namevalue(s,"B14000");
		gcds_report0.namevalue(s,"B15000")=gcds_grid_ec01az.namevalue(s,"B15000");
		gcds_report0.namevalue(s,"B16000")=gcds_grid_ec01az.namevalue(s,"B16000");
		gcds_report0.namevalue(s,"BX0010")=gcds_grid_ec01az.namevalue(s,"BX0010");
		gcds_report0.namevalue(s,"BX0020")=gcds_grid_ec01az.namevalue(s,"BX0020");
		gcds_report0.namevalue(s,"BX0030")=gcds_grid_ec01az.namevalue(s,"BX0030");
		gcds_report0.namevalue(s,"BX0040")=gcds_grid_ec01az.namevalue(s,"BX0040");
		gcds_report0.namevalue(s,"PAYDT") =gcds_grid_ec01az.namevalue(s,"PAYDT");
		gcds_report0.namevalue(s,"STRTDT")=gcds_grid_ec01az.namevalue(s,"STRTDT");
	  gcds_report0.namevalue(s,"JOBGRPHNM")=gcds_grid_ec01az.namevalue(s,"JOBGRPHNM");
		gcds_report0.namevalue(s,"TS9100") =gcds_grid_ec01az.namevalue(s,"TS9100");
		gcds_report0.namevalue(s,"TT1100")=gcds_grid_ec01az.namevalue(s,"TT1100");
	  gcds_report0.namevalue(s,"TT1200")=gcds_grid_ec01az.namevalue(s,"TT1200");
		gcds_report0.namevalue(s,"P35000")=gcds_grid_ec01az.namevalue(s,"P35000");

		//기타지급 TITLE START ------------------------------------------------------------------------------
		if (gcds_grid_ec01az.namevalue(s,"PR0020") == '' || gcds_grid_ec01az.namevalue(s,"PR0020") == 0) {
			gcds_report0.namevalue(s,"PR0020") = '기타지급1';
		}else {
			gcds_report0.namevalue(s,"PR0020")=gcds_grid_ec01az.namevalue(s,"PR0020");
		}
		if (gcds_grid_ec01az.namevalue(row,"PR0030") == '' || gcds_grid_ec01az.namevalue(s,"PR0030") == 0) {
			gcds_report0.namevalue(s,"PR0030") = '기타지급2';
		}else {
			gcds_report0.namevalue(s,"PR0030")=gcds_grid_ec01az.namevalue(s,"PR0030");
		}
		if (gcds_grid_ec01az.namevalue(s,"PR0040") == '' || gcds_grid_ec01az.namevalue(s,"PR0040") == 0) {
			gcds_report0.namevalue(s,"PR0040") = '기타지급3';
		}else {
			gcds_report0.namevalue(s,"PR0040")=gcds_grid_ec01az.namevalue(s,"PR0040");
		}
		//기타지급 TITLE END --------------------------------------------------------------------------------

		//기타공제 TITLE START ------------------------------------------------------------------------------
		if (gcds_grid_ec01az.namevalue(s,"BR0020") == '' || gcds_grid_ec01az.namevalue(s,"BR0020") == 0) {
			gcds_report0.namevalue(s,"BR0020") = '기타공제1';
		}else {
			gcds_report0.namevalue(s,"BR0020")=gcds_grid_ec01az.namevalue(s,"BR0020");
		}
		if (gcds_grid_ec01az.namevalue(s,"BR0030") == '' || gcds_grid_ec01az.namevalue(s,"BR0030") == 0) {
			gcds_report0.namevalue(s,"BR0030") = '기타공제2';
		}else {
			gcds_report0.namevalue(s,"BR0030")=gcds_grid_ec01az.namevalue(s,"BR0030");
		}
		if (gcds_grid_ec01az.namevalue(row,"BR0040") == '' || gcds_grid_ec01az.namevalue(s,"BR0040") == 0) {
			gcds_report0.namevalue(s,"BR0040") = '기타공제3';
		}else {
			gcds_report0.namevalue(s,"BR0040")=gcds_grid_ec01az.namevalue(s,"BR0040");
		}
		//기타공제 TITLE END --------------------------------------------------------------------------------

		//대출상환 START------------------------------------------------------------------------------------------
		gcds_report0.namevalue(s,"APLAMT")=gcds_grid_ec01az.namevalue(s,"APLAMT");
		gcds_report0.namevalue(s,"APLRAT")=gcds_grid_ec01az.namevalue(s,"APLRAT");
		gcds_report0.namevalue(s,"APPCNT")=gcds_grid_ec01az.namevalue(s,"APPCNT");
		gcds_report0.namevalue(s,"APJAMT")=gcds_grid_ec01az.namevalue(s,"APJAMT");
		gcds_report0.namevalue(s,"AMT_1") =gcds_grid_ec01az.namevalue(s,"AMT_1");
		//대출상환 END--------------------------------------------------------------------------------------------

		//공조회대출상환 START------------------------------------------------------------------------------------------
		gcds_report0.namevalue(s,"COACNT")=gcds_grid_ec01az.namevalue(s,"COACNT");
		gcds_report0.namevalue(s,"COAAMT")=gcds_grid_ec01az.namevalue(s,"COAAMT");
		gcds_report0.namevalue(s,"COJAMT")=gcds_grid_ec01az.namevalue(s,"COJAMT");
		gcds_report0.namevalue(s,"COLAMT")=gcds_grid_ec01az.namevalue(s,"COLAMT");
		gcds_report0.namevalue(s,"AMT_2") =gcds_grid_ec01az.namevalue(s,"AMT_2");
		//대출상환 END--------------------------------------------------------------------------------------------
    
		var str6= fn_trim(gclx_select_ec01az.BindColVal);// 상여구분
		if(str6=='5'){
			gcds_report0.namevalue(s,"SANGNAME") ="상  여  율 :";
			gcds_report0.namevalue(s,"SANGRAT") =gcds_grid_ec01az.namevalue(s,"SANGRAT")+""+"%";
		}
		var str1=gcds_grid_ec01az.namevalue(s,"P23002");
		var str2=gcds_grid_ec01az.namevalue(s,"P23003");
		var str3 =gcds_grid_ec01az.namevalue(s,"P23004");
		var str4=gcds_grid_ec01az.namevalue(s,"P23005");
		var str5=gcds_grid_ec01az.namevalue(s,"P23006");
		
		gcds_report0.namevalue(s,"BAEBUSU") =str1+"-"+str2+"-"+str3+"-"+str4+"-"+str5;

		gcds_report1.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050005_s1?"
												+ "v_str3=" + gcds_grid_ec01az.namevalue(s,"EMPNO")+"&v_str4="+gcem_yymm_search.text;
		gcds_report1.Reset(); 

		//저축내역
		for(var i=1;i<=gcds_report1.countrow; i++) {
			gcds_report1.rowposition=i;   
			gcds_report0.namevalue(s,("DIVNM"+i)) =  gcds_report1.namevalue(i,"DIVNM");
		  gcds_report0.namevalue(s,("INSURNM"+i)) =gcds_report1.namevalue(i,"INSURNM");
			gcds_report0.namevalue(s,("TOTDAY"+i)) = gcds_report1.namevalue(i,"TOTDAY");
			gcds_report0.namevalue(s,("TOTCNT"+i)) = gcds_report1.namevalue(i,"TOTCNT");
			gcds_report0.namevalue(s,("SUPAMT"+i)) = gcds_report1.namevalue(i,"SUPAMT");
			gcds_report0.namevalue(s,("TOTAMT"+i)) = gcds_report1.namevalue(i,"TOTAMT");
		}
	
	}//end for countrow
		
		if (gclx_select_ec01az.BindColVal == '5') {
			//gcrp_print2.preview();		//상여명세서 미리보기
			gcrp_print.preview();			//미리보기
		}else{
			gcrp_print.preview();			//미리보기
		}

	}//end if
}

/******************************************************************************
	Description : 급여기타항목제목 자동생성
******************************************************************************/
function ln_TitelAuto() {

	var t_row = gcds_grid_ec01az.rowposition;

	//급여기타항목제목 자동생성
	if(gcds_grid_ec01az.namevalue(t_row,"PR0020") != null) txt_px01.value = gcds_grid_ec01az.namevalue(t_row,"PR0020");
	if(gcds_grid_ec01az.namevalue(t_row,"PR0030") != null) txt_px02.value = gcds_grid_ec01az.namevalue(t_row,"PR0030");
	if(gcds_grid_ec01az.namevalue(t_row,"PR0040") != null) txt_px03.value = gcds_grid_ec01az.namevalue(t_row,"PR0040");
	if(gcds_grid_ec01az.namevalue(t_row,"BR0020") != null) txt_pb01.value = gcds_grid_ec01az.namevalue(t_row,"BR0020");
	if(gcds_grid_ec01az.namevalue(t_row,"BR0030") != null) txt_pb02.value = gcds_grid_ec01az.namevalue(t_row,"BR0030");
	if(gcds_grid_ec01az.namevalue(t_row,"BR0040") != null) txt_pb03.value = gcds_grid_ec01az.namevalue(t_row,"BR0040");

}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete() {
	
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_select_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 지급구분 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 소속구분 DataSet-->
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

<comment id="__NSID__"><OBJECT id=gcds_grid_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 조회 DataSet-->
    <!--param name=SortExpr   value="+EMPNO"-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_grid_ec01az" event="OnLoadStarted()">
	//ft_cnt1.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="onloadcompleted(row,colid)">
	//ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
		if(gcds_grid_ec01az.countrow <=0)
			alert("조회된 데이타가 없습니다.");

	ln_TitelAuto();		//급여기타(공제)항목제목 자동생성
</script>

<script language="javascript" for="gcds_select_ec01az" event="onloadCompleted(row,colid)">
	//gcds_select_ec01az.InsertRow(1);
	//gcds_select_ec01az.NameValue(1,"MINORCD")="";
	//gcds_select_ec01az.NameValue(1,"MINORNM")="전체";
	for (var i=gcds_select_ec01az.countrow; i >0; i--)	{   
		gcds_select_ec01az.rowposition=i;
		kkk=fn_trim(gcds_select_ec01az.NameValue(gcds_select_ec01az.rowposition,"MINORCD"))+"";
		if(kkk=='3'){
			gcds_select_ec01az.DeleteRow(gcds_select_ec01az.rowposition);
		}
	}
    gclx_select_ec01az.index=0;
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.InsertRow(1);
	gcds_dept.NameValue(1,"DEPTCD")="";
	gcds_dept.NameValue(1,"DEPTNM")="전체";
	//gclx_select_ec02az.index=0;
</script>

<!-- <script language="javascript" for="gcds_select_ec03az" event="onloadCompleted(row,colid)">
	gcds_select_ec03az.InsertRow(1);
	gcds_select_ec03az.NameValue(1,"MINORCD")="";
	gcds_select_ec03az.NameValue(1,"MINORNM")="전체";
	gclx_select_ec03az.index=0;
</script> -->

<script language="javascript" for="gcds_select_ec04az" event="onloadCompleted(row,colid)">
	gcds_select_ec04az.InsertRow(1);
	gcds_select_ec04az.NameValue(1,"MINORCD")="";
	gcds_select_ec04az.NameValue(1,"MINORNM")="전체";
	//직위 전체가 포함되어있음
	//gclx_select_ec04az.index=0;
</script>

<!-- <script language="javascript" for="gcds_select_ec05az" event="onloadCompleted(row,colid)">
	gcds_select_ec05az.InsertRow(1);
	gcds_select_ec05az.NameValue(1,"MINORCD")="";
	gcds_select_ec05az.NameValue(1,"MINORNM")="전체";
	gclx_select_ec05az.index=0;
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script> -->

<script language="javascript"  for=gcds_grid_ec01az  event=OnRowPosChanged(row)>
	var strBS=gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"BSDAY")+"";
	var strHJ=gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"HJDAY")+"";
	var strNS=gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"NSDAY")+"";
	if(strBS.length==1) strBS="0"+strBS;
	if(strHJ.length==1) strHJ="0"+strHJ;
	if(strNS.length==1) strNS="0"+strNS;
	gcem_SGUNMU.Text=strBS+","+strHJ+","+strNS;
</script>

<script language="javascript" for="gcds_data5" event="onloadCompleted(row,colid)">
	txt_sang.value = gcds_data5.namevalue(gcds_data5.rowposition,"SANGRAT") + " %";	//상여율
	txt_sang.style.display = "block";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_select_ec02az event=onSelChange()>
	gs_level = '';
	gs_treecd ='';
	gs_level = gclx_select_ec02az.ValueOfIndex ("level", gclx_select_ec02az.Index);
	gs_treecd = gclx_select_ec02az.ValueOfIndex ("treecd", gclx_select_ec02az.Index);
	gs_treecd = fn_treecd(gs_level, gs_treecd);
</script>

<script language=JavaScript for=gclx_select_ec01az event=onSelChange()>
	var str_sang = gclx_select_ec01az.BindColVal;
	if (str_sang == "5") {
		gcds_data5.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p020008_s1?v_str1="+gusrid
											+"&v_str2="+fn_trim(gcem_yymm_search.Text);
		gcds_data5.Reset();
	}else{
		txt_sang.style.display = "none";
	}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_select_ec01az" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_ec01az" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_dept" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<!-- <script language="javascript" for="gcds_select_ec03az" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script> -->

<script language="javascript" for="gcds_select_ec04az" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_ec04az" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>


</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
			B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<body bgcolor="#FFFFFF" topmargin="0" marginheight="0" leftmargin="0" marginwidth="0" onload="ln_Start()">

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/p020008_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"><nobr>
			<!-- <img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel()"> -->
			<img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print()">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;</nobr>
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table  cellpadding="0" cellspacing="0" border="0" style='width:876px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="140px" align=center  style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;적용년월</nobr></td>
					<td width="152px" style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_yymm_search classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative;left:-2px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1 ValidFeatures="ignoreStatus=yes" validExp="">
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
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td>	
					<td width="140px"  align=center style="height:30px;border:0 solid #708090;border-right-width:1px;padding-left:3px;padding-right:3px;" bgcolor="#eeeeee"><nobr>&nbsp;지급구분</nobr></td>	
					<td width="152px"  style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;"><nobr>
						<comment id="__NSID__"><object id=gclx_select_ec01az  name="gclx_select_ec01az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:-1px;font-size:12px;width:80px;height:100px;">
							<param name=CBData					value="1^정기급여,4^휴직급여,5^상여급여,6^격려금,7^유보급여">
							<param name=CBDataColumns		value="MINORCD,MINORNM">
							<param name=Sort            value="false">
							<param name=ListExprFormat	value="MINORNM^0^80">
							<param name=BindColumn			value="MINORCD">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td width="140px" align=left style="height:30px;border:0 solid #708090;border-right-width:0px;"><nobr><input id="txt_sang" type="text" style="position:relative;left:-3px;top:1px;width:45px;display:none"></nobr></td>
					<td width="160px" align=RIGHT >&nbsp;&nbsp;</td>
				</tr>
   <!--  <tr> 
		    <td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;" bgcolor="#eeeeee">
			<nobr>&nbsp;사원번호&nbsp;&nbsp;</nobr></td>
		<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;border-top-width:1px;"><nobr>
			
			<table cellpadding=0 cellspacing=0 width=150>
				<tr>
					<td>
						<comment id="__NSID__"><object id=gcem_emo_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative;left:8px;top:0px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment			value=0>
							<param name=Border	      value=True>
							<param name=ClipMode			value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="0000000">
							<param name=MaxLength     value=13>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Readonly			value=false>
						</object></comment><script>__ws__(__NSID__);</script></td><td>~</td><td>
						<comment id="__NSID__"><object id=gcem_emo_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative;left:8px;top:0px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment			value=0>
							<param name=Border	      value=True>
							<param name=ClipMode			value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="0000000">
							<param name=MaxLength     value=13>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Readonly			value=false>
						</object></comment><script>__ws__(__NSID__);</script></td></tr></table></nobr></td>	
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;padding-left:3px;" bgcolor="#eeeeee">
						<nobr>&nbsp;성명&nbsp;</nobr></td>	
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-top:0px;border-top-width:1px;"><nobr>
						<input type="text" id=txt_empnm style="width:100px;" class="txt11" onkeydown="if(event.keyCode==13) ln_Query();">&nbsp;&nbsp;</nobr>
					</td>
					<td width="0" align=lefT style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;" bgcolor="#eeeeee">
						<nobr >&nbsp;직위&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;">
						<comment id="__NSID__"><object id=gclx_select_ec04az  name="gclx_select_ec04az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:0px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value=gcds_select_ec04az>
							<param name=SearchColumn		value="MINORCD^MINORNM">
							<param name=Sort            value="TRUE">
							<param name=SortColumn			value="MINORCD">
							<param name=ListExprFormat	value="MINORNM">
							<param name=BindColumn			value="MINORCD">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
          <td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;직급&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-top-width:1px;" colspan=3>
						<comment id="__NSID__"><object id=gclx_select_ec05az  name="gclx_select_ec05az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:0px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value=gcds_select_ec05az>
							<param name=SearchColumn		value="MINORCD^MINORNM">
							<param name=Sort            value="TRUE">
							<param name=SortColumn			value="MINORCD">
							<param name=ListExprFormat	value="MINORNM">
							<param name=BindColumn			value="MINORCD">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td width="100%" style="height:30px;border:0 solid #708090;border-top-width:1px;" align=RIGHT >&nbsp;&nbsp;</td>
				</tr> -->
			</table>
		</td>
  </tr>
  <tr> <td colspan="2" height=3>
  </td></tr>
  <tr> 
    <td colspan="2"> 
	<table width="876" cellpadding="0" cellspacing="0" border="0">
		<tr> 
			<td style="width:3px;"></td>
			<td STYLE="PADDING-TOP:0px;" valign=top>
						<table width="876" cellpadding="0" cellspacing="0" border="0">
							<tr> 
								<td valign=top>
									<table border="5" cellpadding=0 cellspacing=0    style='width:876px;height:421px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:0 solid #708090'>
										<tr>
											<td width="140px" style="height:20px;border:1 solid #708090;" bgcolor="#eeeeee" align=center>&nbsp;적용년월</td>
											<td width="152px" style="border:1 solid #708090;border-left-width:0px;" colspan=2><nobr>
												<comment id="__NSID__"><object id=gcem_APPDT  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
													<param name=Text          value="">
													<param name=Alignment			value=0>
													<param name=ReadOnly			value=True>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=false>
													<param name=Format	      value="YYYY/MM">
													<param name=MaxLength     value=8>
													<param name=enable				value=false>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=false>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script></nobr>
											</td>
											<td width="140px" style="height:20px;border:1 solid #708090;border-left-width:0px;" bgcolor="#eeeeee" align=center>&nbsp;사번</td>
											<td width="152px" style="border:1 solid #708090;border-left-width:0px;" colspan=2><nobr>
												<input type="text" id=txt_empno class="txt11" maxlength=7 size=8 disabled style="postion:relative;left:8px;width:100px;"></nobr>
											</td>
											<td width="140px" style="border:1 solid #708090;border-left-width:0px;" bgcolor="#eeeeee" align=center>&nbsp;성명</td>
											<td width="152px" style="border:1 solid #708090;border-left-width:0px;" colspan=2>
												<input type="text" id=txt_EMPNMK class="txt11" disabled style="postion:relative;left:8px;width:100px;">
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center>&nbsp;입사일자</td>
											<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px" colspan=2><nobr>
												<comment id="__NSID__"><object id=gcem_strtdt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
													<param name=Text          value="">
													<param name=Alignment			value=0>
													<param name=ReadOnly			value=True>
													<param name=Border	      value=True>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=false>
													<param name=Format	      value="YYYY/MM/DD">
													<param name=MaxLength     value=8>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=false>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
													<param name=enable				value=false>
												</object></comment><script>__ws__(__NSID__);</script></nobr>
											</td>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>&nbsp;발령일자</td>
											<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px" colspan=2><nobr>
												<comment id="__NSID__"><object id=gcem_DPOFFDT  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
													<param name=Text          value="">
													<param name=Alignment			value=0>
													<param name=ReadOnly			value=True>
													<param name=Border	      value=True>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=false>
													<param name=Format	      value="YYYY/MM/DD">
													<param name=MaxLength     value=8>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=false>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
													<param name=enable				value=false>
												</object></comment><script>__ws__(__NSID__);</script></nobr>
											</td>
											<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee" align=center>&nbsp;지급일자</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px" colspan=2>
												<comment id="__NSID__"><object id=gcem_paydt1  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
													<param name=Text          value="">
													<param name=Alignment			value=0>
													<param name=ReadOnly			value=True>
													<param name=Border	      value=True>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=false>
													<param name=Format	      value="YYYY/MM/DD">
													<param name=MaxLength     value=8>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=false>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
													<param name=enable				value=false>
												</object></comment><script>__ws__(__NSID__);</script></nobr>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center>&nbsp;소속</td>
											<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px" colspan=2><nobr>
												<input type="text" id=txt_DEPTNM style="width:100px;" class="txt11" disabled>
												<!--<comment id="__NSID__"><object id=gclx_select_ec02az  name="gclx_select_ec02az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
													<param name=ComboDataID			value=gcds_dept>
													<param name=SearchColumn		value="DEPTCD^DEPTNM">
													<param name=Sort            value="false">
													<param name=SortColumn			value="DEPTCD">
													<param name=ListExprFormat	value="DEPTNM^0^130">
													<param name=BindColumn			value="DEPTCD">
												</object></comment><script>__ws__(__NSID__);</script> -->
												</nobr>
											</td>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee" align=center>&nbsp;직위</td>
											<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px" colspan=2><nobr>
												<input type="text" id=txt_PAYGRDNM style="width:100px;" class="txt11" disabled>
												<!-- <comment id="__NSID__"><object id=gclx_select_ec04az  name="gclx_select_ec04az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:0px;font-size:12px;width:100px;height:200px;">
													<param name=ComboDataID			value=gcds_select_ec04az>
													<param name=SearchColumn		value="MINORCD^MINORNM">
													<param name=Sort            value="TRUE">
													<param name=SortColumn			value="MINORCD">
													<param name=ListExprFormat	value="MINORNM">
													<param name=BindColumn			value="MINORCD">
												</object></comment><script>__ws__(__NSID__);</script> -->
												</nobr>
											</td>
											<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee" align=center>&nbsp;호봉</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px" colspan=2>
												<input type="text" id=txt_PAYSEQNM style="width:100px;" class="txt11" disabled></nobr>
											</td>
										</tr>
										<tr>
											<td style="height:5px;border:0 solid #708090;" colspan=6></td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#B9D4DC" colspan=1>
												<nobr>&nbsp;지급항목</nobr>
											</td>
											<td style="border:0 solid #708090;border-top-width:1px;border-bottom-width:0px;" colspan=1>
											</td>
											<td style="height:20px;border:1 solid #708090;border-bottom-width:0px;border-top-width:0px;border-right-width:0px;border-left-width:0px;"  colspan=1><nobr>&nbsp;</nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-TOP-width:1px;border-bottom-width:0px;" colspan=1 ><nobr></nobr></td><!-- bgcolor="#B9D4DC" -->
											<td style="height:20px;border:1 solid #708090;border-bottom-width:0px;border-top-width:0px;border-left-width:0px;border-right-width:1px;"  colspan=2>&nbsp;<nobr>
												</nobr></td>
											<td style="height:20px;border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;" bgcolor="#B9D4DC" colspan=1><nobr>&nbsp;지급합계</nobr></td>
											<td style="border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;" colspan=2 >
												<comment id="__NSID__"><object id=gcem_S91000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=enable				value=false>
													<param name=Readonly			value=true>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;" bgcolor="#eeeeee" align=center>&nbsp;기본급</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P10000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Readonly	    value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:1px;" bgcolor="#eeeeee" align=center>&nbsp;직책수당</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;;border-top-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P11000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:1px;" bgcolor="#eeeeee" align=center>&nbsp;시간외수당</td>
											<td style="border:1 solid #708090;border-left-width:0px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P12000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center><nobr>&nbsp;근속수당</nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P21000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center><nobr>&nbsp;자기계발비</nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P22000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;가족부양비</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P23000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center>&nbsp;차량유지비</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P24000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;출납</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P25000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;운전수당</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P26000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center>&nbsp;연장수당</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P27000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;자격수당</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P28000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;남북경협수당</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P29000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center>&nbsp;사장단수당</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P30000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;특수지수당</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P31000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;지역근무수당</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P32000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
										<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center>&nbsp;개인연금</td>
										<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
											<comment id="__NSID__"><object id=gcem_P37000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;학자금</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P36000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;현장직책수당</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P38000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center>&nbsp;휴일수당</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_PX0010 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;년차수당</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P34000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;식대</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P35000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center>
											   <nobr>
													<input id="txt_px01"  type="text" class="txtbox"  style="border:1;height:15px;background-color:#eeeeee;text-align:center;position:relative;top:2px;left:25px;" alt="기타지급1" disabled>&nbsp;
												 </nobr>
												</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_PX0020 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center><nobr><input id="txt_px02"  type="text" class="txtbox" style="border:1 ;width:80px; height:15px;position:relative;top:2px;left:15px;background-color:#eeeeee" alt="기타지급2" disabled></nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_PX0030 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center><nobr><input id="txt_px03"  type="text" class="txtbox" style="border:1 ;width:80px; height:15px;position:relative;top:2px;left:15px;background-color:#eeeeee" alt="기타지급3" disabled></td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_PX0040 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center>&nbsp;전월소급</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P39000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												    <param name=Readonly	    value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;본사,현장,해외</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_SGUNMU classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"style="position:relative; left:8px;top:0px; width:100px; height:20px;" class=txtbox validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=false>
													<param name=Format	      value="00,  00,  00">
													<param name=MaxLength     value=9>
													<param name=Readonly			value=true>
													<param name=enable				value=false>
													<param name=PromptChar	  value="_">
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>&nbsp;</td>
										</tr>
										<tr><td style="height:5px;border:0 solid #708090;" colspan=6></td></tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#B9D4DC" colspan=1><nobr>&nbsp;공제항목</nobr></td>
											<td style="border:0 solid #708090;border-bottom-width:0px;border-right-width:1px;" colspan=2 >&nbsp;</td>
											<td style="height:20px;border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;" bgcolor="#B9D4DC" colspan=1><nobr>&nbsp;공제합계</nobr></td>
											<td style="border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;" colspan=2 >
												<comment id="__NSID__"><object id=gcem_S93000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												  <param name=enable				value=false>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;" bgcolor="#B9D4DC" colspan=1><nobr>&nbsp;실지급액</nobr></td>
											<td style="border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_S94000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=enable				value=false>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;" bgcolor="#eeeeee" align=center>&nbsp;갑근세</td>
											<td style="border:1 solid #708090;border-left-width:0px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_T11000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:1 solid #708090;border-left-width:0px;" bgcolor="#eeeeee" align=center>&nbsp;주민세</td>
											<td style="border:1 solid #708090;border-left-width:0px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_T12000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:1 solid #708090;border-left-width:0px;" bgcolor="#eeeeee" align=center>&nbsp;건강보험</td>
											<td style="border:1 solid #708090;border-left-width:0px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_B11000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center>&nbsp;국민연금</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_B12000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;고용보험</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_B13000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;개인연금</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_B15000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center>&nbsp;여직원회비</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_B14000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;공조회비</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_B16000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee" align=center disabled><nobr>&nbsp;산재보험</nobr></td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_B17000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
													<param name=Enable				value=false>
												</object></comment><script>__ws__(__NSID__);</script></td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center >&nbsp;보증보험</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_BX0010 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center><nobr><input id="txt_pb01"  type="text" class="txtbox" style="border:1 ;width:80px; height:15px;position:relative;top:2px;left:18px;background-color:#eeeeee" alt="기타공제1" disabled></nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_BX0020 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center><nobr><input id="txt_pb02"  type="text" class="txtbox" style="border:1 ;width:80px; height:15px;position:relative;top:2px;left:18px;background-color:#eeeeee" alt="기타공제2" disabled></nobr></td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_BX0030 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center><nobr><input id="txt_pb03"  type="text" class="txtbox" style="border:1 ;width:80px; height:15px;position:relative;top:2px;left:18px;background-color:#eeeeee" alt="기타공제3" disabled></nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_BX0040 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center><nobr>&nbsp;정산연금</nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><comment id="__NSID__"><object id=gcem_P43000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;정산건강</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P41000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center>&nbsp;정산고용</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_P42000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center><nobr>&nbsp;정산소득</nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_T21000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;정산주민</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_T22000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center>&nbsp;사내대출</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_amtrat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
                      <td style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee" align=center>&nbsp;공조회대출</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><object id=gcem_amtrat2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:100px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
											</td>
 
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
												&nbsp;
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<!-------------------------------------------------------------------------------------------
   ▣ 데이타바인드 정의부분
-------------------------------------------------------------------------------------------->  
<comment id="__NSID__"><OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"				VALUE="gcds_grid_ec01az">
	<PARAM NAME="ActiveBind"		VALUE="true">
	<PARAM NAME="BindInfo"			VALUE="
		<C>Col=EMPNO			Ctrl=txt_EMPNO			Param=value</C>	
		<C>Col=EMPNMK			Ctrl=txt_EMPNMK			Param=value</C> 
		<C>Col=NOTWRK			Ctrl=txt_NOTWRK			Param=value</C>		
		<C>Col=APPDT			Ctrl=gcem_APPDT			Param=Text</C>	
		<C>Col=PAYDIV			Ctrl=txt_PAYDIV			Param=value</C>	
		<C>Col=DEPTCD			Ctrl=txt_DEPTCD			Param=value</C>	
		<C>Col=DEPTNM			Ctrl=txt_DEPTNM			Param=value</C>	
		<C>Col=PAYGRDNM		Ctrl=txt_PAYGRDNM		Param=value</C>	
		<C>Col=GRDDIVNM		Ctrl=txt_GRDDIVNM		Param=value</C>	
		<C>Col=PAYSEQNM		Ctrl=txt_PAYSEQNM		Param=value</C>	
		<C>Col=PAYBNKNM		Ctrl=txt_PAYBNKNM		Param=value</C>	
		<C>Col=PAYNUM			Ctrl=txt_PAYNUM			Param=value</C>	
		<C>Col=PAYDT			Ctrl=gcem_PAYDT			Param=Text</C> 
		<C>Col=DUYNOT			Ctrl=txt_DUYNOT			Param=value</C>	
		<C>Col=P10000			Ctrl=gcem_P10000		Param=Text</C>
		<C>Col=P11000			Ctrl=gcem_P11000		Param=Text</C>
		<C>Col=P12000			Ctrl=gcem_P12000		Param=Text</C>
		<C>Col=P21000			Ctrl=gcem_P21000		Param=Text</C>
		<C>Col=P22000			Ctrl=gcem_P22000		Param=Text</C>
		<C>Col=P23000			Ctrl=gcem_P23000		Param=Text</C>
		<C>Col=P24000			Ctrl=gcem_P24000		Param=Text</C>
		<C>Col=P25000			Ctrl=gcem_P25000		Param=Text</C>
		<C>Col=P26000			Ctrl=gcem_P26000		Param=Text</C>
		<C>Col=P27000			Ctrl=gcem_P27000		Param=Text</C>
		<C>Col=P28000			Ctrl=gcem_P28000		Param=Text</C>
		<C>Col=P29000			Ctrl=gcem_P29000		Param=Text</C>
		<C>Col=P30000			Ctrl=gcem_P30000		Param=Text</C>
		<C>Col=P31000			Ctrl=gcem_P31000		Param=Text</C>
		<C>Col=P32000			Ctrl=gcem_P32000		Param=Text</C>
		<C>Col=P36000			Ctrl=gcem_P36000		Param=Text</C>
		<C>Col=P37000			Ctrl=gcem_P37000		Param=Text</C>
		<C>Col=P38000			Ctrl=gcem_P38000		Param=Text</C>
		<C>Col=PX0010			Ctrl=gcem_PX0010		Param=Text</C>
		<C>Col=PX0020			Ctrl=gcem_PX0020		Param=Text</C>
		<C>Col=PX0030			Ctrl=gcem_PX0030		Param=Text</C>
		<C>Col=PX0040			Ctrl=gcem_PX0040		Param=Text</C> 
		<C>Col=P34000	    Ctrl=gcem_P34000		Param=Text</C>	 
		<C>Col=P39000	    Ctrl=gcem_P39000		Param=Text</C>	 
		
		<C>Col=S91000			Ctrl=gcem_S91000		Param=Text</C>

		<C>Col=T11000			Ctrl=gcem_T11000		Param=Text</C>
		<C>Col=T12000			Ctrl=gcem_T12000		Param=Text</C>
		<C>Col=B11000			Ctrl=gcem_B11000		Param=Text</C>
		<C>Col=B12000			Ctrl=gcem_B12000		Param=Text</C>
		<C>Col=B13000			Ctrl=gcem_B13000		Param=Text</C>
		<C>Col=B15000			Ctrl=gcem_B15000		Param=Text</C>
		<C>Col=B14000			Ctrl=gcem_B14000		Param=Text</C>
		<C>Col=B16000			Ctrl=gcem_B16000		Param=Text</C>
		<C>Col=BX0010			Ctrl=gcem_BX0010		Param=Text</C>
		<C>Col=BX0020			Ctrl=gcem_BX0020		Param=Text</C>
		<C>Col=BX0030			Ctrl=gcem_BX0030		Param=Text</C>
		<C>Col=BX0040			Ctrl=gcem_BX0040		Param=Text</C>
		<C>Col=P41000			Ctrl=gcem_P41000		Param=Text</C>	 
		<C>Col=P42000			Ctrl=gcem_P42000		Param=Text</C>	 
		<C>Col=T21000			Ctrl=gcem_T21000		Param=Text</C>	 
		<C>Col=T22000			Ctrl=gcem_T22000		Param=Text</C>	 

		<C>Col=S93000			Ctrl=gcem_S93000		Param=Text</C>
		<C>Col=S94000			Ctrl=gcem_S94000		Param=Text</C>

		<C>Col=STRTDT			Ctrl=gcem_strtdt		Param=text</C>	
		<C>Col=DPOFFDT		Ctrl=gcem_DPOFFDT		Param=text</C>	
		<C>Col=PAYDT			Ctrl=gcem_paydt1		Param=Text</C>
		<C>Col=JOBGRPHNM  Ctrl=txt_JOBGRPHNM	Param=value</C>	
		<C>Col=B17000			Ctrl=gcem_B17000		Param=Text</C>
		<C>Col=P43000			Ctrl=gcem_P43000		Param=Text</C>
		<C>Col=P35000			Ctrl=gcem_P35000		Param=Text</C>

		<C>Col=PR0020			Ctrl=txt_px01				Param=value</C>
		<C>Col=PR0030			Ctrl=txt_px02				Param=value</C>
		<C>Col=PR0040			Ctrl=txt_px03				Param=value</C>

		<C>Col=BR0020			Ctrl=txt_pb01				Param=value</C>
		<C>Col=BR0030			Ctrl=txt_pb02				Param=value</C>
		<C>Col=BR0040			Ctrl=txt_pb03				Param=value</C>

		<C>Col=AMT_1			Ctrl=gcem_amtrat		Param=text</C>
		<C>Col=AMT_2			Ctrl=gcem_amtrat2		Param=text</C>
		
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-------------------------------------------------------------------------------------------
   ▣ 보고서 정의부분
-------------------------------------------------------------------------------------------->  
<comment id="__NSID__"><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"			value="gcds_report0">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="0">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<param name=NullRecordFlag			value=True>
	<param name="SaveToFileShowButton"value="true">		
	<param name="SaveToFileENV"     value='filename=c:\\temp;filetype=jpg;quality=100;bpp=8;ppf=0;pts=all;sizetype=resolution;width=400;height=300'>
	<PARAM NAME="Format" VALUE="
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2752 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='지       급       내      역' ,left=545 ,top=849 ,right=1455 ,bottom=908 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=1442 ,right=1876 ,bottom=1442 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=923 ,right=1876 ,bottom=923 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=833 ,right=1876 ,bottom=833 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=799 ,right=1876 ,bottom=799 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=717 ,right=1876 ,bottom=717 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=32 ,top=1008 ,right=1876 ,bottom=1008 </L>
	<L> left=29 ,top=717 ,right=29 ,bottom=799 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1876 ,top=717 ,right=1876 ,bottom=799 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='실수령액' ,left=1283 ,top=730 ,right=1455 ,bottom=783 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='S93000', left=881, top=730, right=1257, bottom=783, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='공제총액' ,left=669 ,top=730 ,right=857 ,bottom=783 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='S91000', left=267, top=730, right=640, bottom=783, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='지급총액' ,left=53 ,top=730 ,right=233 ,bottom=783 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='S94000', left=1482, top=730, right=1855, bottom=783, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1466 ,top=720 ,right=1466 ,bottom=799 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=868 ,top=720 ,right=868 ,bottom=799 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=246 ,top=720 ,right=246 ,bottom=799 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1270 ,top=720 ,right=1270 ,bottom=799 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=654 ,top=720 ,right=654 ,bottom=799 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1876 ,top=833 ,right=1876 ,bottom=1442 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='P11000', left=267, top=1016, right=463, bottom=1074, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P12000', left=267, top=1085, right=463, bottom=1143, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P21000', left=267, top=1151, right=463, bottom=1209, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P22000', left=267, top=1220, right=463, bottom=1278, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P10000', left=267, top=942, right=463, bottom=997, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P24000', left=267, top=1365, right=463, bottom=1421, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='기본급' ,left=42 ,top=942 ,right=254 ,bottom=997 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=1648, top=1365, right=1865, bottom=1421, align='right'</C>
	<C>id='', left=1648, top=1291, right=1865, bottom=1347, align='right'</C>
	<C>id='P37000', left=717, top=1016, right=908, bottom=1074, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='개인연금보조' ,left=479 ,top=1016 ,right=699 ,bottom=1074 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출납수당' ,left=479 ,top=1151 ,right=699 ,bottom=1209 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='운전수당' ,left=479 ,top=1220 ,right=699 ,bottom=1278 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P26000', left=717, top=1220, right=908, bottom=1278, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P25000', left=717, top=1151, right=908, bottom=1209, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P32000', left=717, top=1085, right=908, bottom=1143, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P28000', left=717, top=1365, right=908, bottom=1421, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='자격수당' ,left=479 ,top=1365 ,right=699 ,bottom=1421 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P29000', left=717, top=942, right=908, bottom=997, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='남북경협수당' ,left=479 ,top=942 ,right=699 ,bottom=997 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=918 ,top=923 ,right=918 ,bottom=1437 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1373 ,top=926 ,right=1373 ,bottom=1442 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1630 ,top=926 ,right=1630 ,bottom=1442 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=259 ,top=926 ,right=259 ,bottom=1442 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=468 ,top=926 ,right=468 ,bottom=1442 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=706 ,top=926 ,right=706 ,bottom=1442 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1164 ,top=926 ,right=1164 ,bottom=1442 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='지역근무수당' ,left=479 ,top=1085 ,right=699 ,bottom=1143 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P30000', left=1172, top=942, right=1368, bottom=997, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='사장단수당' ,left=937 ,top=942 ,right=1156 ,bottom=997 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='식대보조' ,left=937 ,top=1365 ,right=1156 ,bottom=1421 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P35000', left=1172, top=1365, right=1368, bottom=1421, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='' ,left=1386 ,top=1291 ,right=1625 ,bottom=1347 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='' ,left=1386 ,top=1365 ,right=1625 ,bottom=1421 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=833 ,right=29 ,bottom=1442 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=1474 ,right=1876 ,bottom=1474 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=1553 ,right=1876 ,bottom=1553 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=259 ,top=1556 ,right=259 ,bottom=1855 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=706 ,top=1556 ,right=706 ,bottom=1855 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=29 ,top=1855 ,right=1876 ,bottom=1855 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=1479 ,right=29 ,bottom=1855 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1876 ,top=1479 ,right=1876 ,bottom=1855 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=1892 ,right=1876 ,bottom=1892 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1162 ,top=1892 ,right=1162 ,bottom=2326 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=29 ,top=1892 ,right=29 ,bottom=2326 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1876 ,top=1892 ,right=1876 ,bottom=2326 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=2326 ,right=1876 ,bottom=2326 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='누    계     내     역' ,left=48 ,top=2379 ,right=900 ,bottom=2434 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=2532 ,right=1876 ,bottom=2532 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=2447 ,right=1876 ,bottom=2447 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=2360 ,right=1876 ,bottom=2360 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1876 ,top=2360 ,right=1876 ,bottom=2617 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='3669-3867, 3669-3915' ,left=945 ,top=2463 ,right=1868 ,bottom=2519 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급여/상여 문의 및 주소 변경' ,left=945 ,top=2379 ,right=1868 ,bottom=2434 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=635 ,top=2453 ,right=635 ,bottom=2622 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=328 ,top=2453 ,right=328 ,bottom=2622 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='TS9100', left=53, top=2551, right=307, bottom=2601, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=29 ,top=2360 ,right=29 ,bottom=2617 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='저    축    내    역' ,left=318 ,top=1910 ,right=865 ,bottom=1963 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공       제       내       역' ,left=532 ,top=1487 ,right=1381 ,bottom=1540 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연차수당' ,left=937 ,top=1085 ,right=1156 ,bottom=1143 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='학비보조금' ,left=937 ,top=1151 ,right=1156 ,bottom=1209 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현장직책수당' ,left=937 ,top=1220 ,right=1156 ,bottom=1278 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PAYSEQNM', left=1386, top=373, right=1722, bottom=431, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAYGRDNM', left=1386, top=304, right=1722, bottom=360, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SANGNAME', left=1098, top=442, right=1373, bottom=500, face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='급       호 :' ,left=1098 ,top=373 ,right=1373 ,bottom=431 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직       위 :' ,left=1098 ,top=304 ,right=1373 ,bottom=360 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성       명 :' ,left=1098 ,top=233 ,right=1373 ,bottom=286 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PAYDT', left=1434, top=138, right=1876, bottom=196, align='right' ,mask='지급일:XXXX-XX-XX', face='굴림', size=13, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='귀하의 노고에 감사 드립니다.' ,left=484 ,top=529 ,right=1519 ,bottom=622 ,align='left' ,face='궁서' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SANGRAT', left=1386, top=442, right=1722, bottom=500, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=29 ,top=206 ,right=29 ,bottom=669 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=204 ,right=1876 ,bottom=204 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='EMPNO', left=331, top=233, right=667, bottom=286, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=1386, top=233, right=1722, bottom=286, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=29 ,top=669 ,right=1876 ,bottom=669 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='사       번 :' ,left=58 ,top=233 ,right=323 ,bottom=286 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소       속 :' ,left=58 ,top=304 ,right=323 ,bottom=357 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부양코드  :' ,left=56 ,top=373 ,right=320 ,bottom=426 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DEPTNM', left=331, top=304, right=1040, bottom=357, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BAEBUSU', left=331, top=373, right=667, bottom=426, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAYBNKNM', left=331, top=442, right=534, bottom=500, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='계좌번호  :' ,left=56 ,top=442 ,right=320 ,bottom=500 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PAYNUM', left=564, top=442, right=1087, bottom=500, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='/' ,left=534 ,top=442 ,right=564 ,bottom=500 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../Common/img/icon.jpg' ,left=720 ,top=2651 ,right=1199 ,bottom=2749</I>
	<C>id='CTITLE', left=497, top=34, right=1503, bottom=122, face='HY중고딕', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P38000', left=1172, top=1220, right=1368, bottom=1278, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='PX0020', left=1648, top=942, right=1865, bottom=997, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PR0020', left=1386, top=942, right=1627, bottom=997, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P36000', left=1172, top=1151, right=1368, bottom=1209, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P39000', left=1648, top=1151, right=1865, bottom=1209, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='' ,left=1386 ,top=1220 ,right=1625 ,bottom=1278 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=1648, top=1220, right=1865, bottom=1278, align='right'</C>
	<T>id='전월소급' ,left=1386 ,top=1151 ,right=1627 ,bottom=1209 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1876 ,top=206 ,right=1876 ,bottom=669 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='직책수당' ,left=42 ,top=1016 ,right=254 ,bottom=1074 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시간외수당' ,left=42 ,top=1085 ,right=254 ,bottom=1143 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근속수당' ,left=42 ,top=1151 ,right=254 ,bottom=1209 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자기계발비' ,left=42 ,top=1220 ,right=254 ,bottom=1278 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='가족부양비' ,left=42 ,top=1294 ,right=254 ,bottom=1349 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차랑유지비' ,left=42 ,top=1365 ,right=254 ,bottom=1421 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='건강보험' ,left=42 ,top=1717 ,right=254 ,bottom=1773 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국민연금' ,left=42 ,top=1789 ,right=254 ,bottom=1839 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=42 ,top=1646 ,right=254 ,bottom=1699 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P23000', left=267, top=1294, right=463, bottom=1349, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='PX0010', left=1172, top=1294, right=1368, bottom=1349, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='휴일수당' ,left=937 ,top=1294 ,right=1156 ,bottom=1349 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P27000', left=717, top=1294, right=908, bottom=1349, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='연장수당' ,left=479 ,top=1294 ,right=699 ,bottom=1349 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=926 ,top=923 ,right=926 ,bottom=1437 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=32 ,top=1355 ,right=1876 ,bottom=1355 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=32 ,top=1283 ,right=1876 ,bottom=1283 </L>
	<L> left=32 ,top=1212 ,right=1876 ,bottom=1212 </L>
	<L> left=32 ,top=1143 ,right=1876 ,bottom=1143 </L>
	<L> left=32 ,top=1077 ,right=1876 ,bottom=1077 </L>
	<L> left=32 ,top=1775 ,right=1876 ,bottom=1775 </L>
	<C>id='B12000', left=267, top=1789, right=463, bottom=1839, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='B11000', left=267, top=1717, right=463, bottom=1773, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='T12000', left=267, top=1648, right=463, bottom=1701, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='T11000', left=267, top=1572, right=463, bottom=1627, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='여직원회비' ,left=479 ,top=1789 ,right=699 ,bottom=1839 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공조회비' ,left=479 ,top=1717 ,right=699 ,bottom=1773 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='개인연금' ,left=479 ,top=1648 ,right=699 ,bottom=1701 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='고용보험' ,left=479 ,top=1572 ,right=699 ,bottom=1625 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=32 ,top=1635 ,right=1876 ,bottom=1635 </L>
	<L> left=32 ,top=1707 ,right=1876 ,bottom=1707 </L>
	<L> left=468 ,top=1556 ,right=468 ,bottom=1855 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='B14000', left=717, top=1789, right=913, bottom=1839, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='B16000', left=717, top=1717, right=913, bottom=1773, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='B15000', left=717, top=1648, right=908, bottom=1701, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='B13000', left=717, top=1572, right=908, bottom=1625, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=918 ,top=1556 ,right=918 ,bottom=1855 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=926 ,top=1556 ,right=926 ,bottom=1855 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='보증보험' ,left=937 ,top=1572 ,right=1156 ,bottom=1627 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1164 ,top=1556 ,right=1164 ,bottom=1855 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='BX0010', left=1172, top=1572, right=1368, bottom=1627, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=1373 ,top=1556 ,right=1373 ,bottom=1855 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1630 ,top=1556 ,right=1630 ,bottom=1855 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1151 ,top=1892 ,right=1151 ,bottom=2326 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='소득누계' ,left=56 ,top=2466 ,right=307 ,bottom=2521 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TT1200', left=656, top=2551, right=913, bottom=2601, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TT1100', left=355, top=2551, right=614, bottom=2601, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='주민세누계' ,left=656 ,top=2466 ,right=913 ,bottom=2521 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑근세누계' ,left=355 ,top=2466 ,right=614 ,bottom=2521 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PX0030', left=1648, top=1016, right=1865, bottom=1074, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='PR0030', left=1386, top=1016, right=1627, bottom=1074, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P31000', left=1172, top=1016, right=1368, bottom=1074, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='특수지수당' ,left=937 ,top=1016 ,right=1156 ,bottom=1074 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PX0040', left=1648, top=1085, right=1865, bottom=1143, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='PR0040', left=1386, top=1085, right=1627, bottom=1143, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P34000', left=1172, top=1085, right=1368, bottom=1143, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='갑근세' ,left=40 ,top=1569 ,right=254 ,bottom=1625 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='T22000', left=1651, top=1786, right=1847, bottom=1842, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='정산주민세' ,left=1405 ,top=1786 ,right=1619 ,bottom=1839 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='T21000', left=1651, top=1717, right=1847, bottom=1770, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='정산갑근세' ,left=1405 ,top=1717 ,right=1619 ,bottom=1773 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사내대출' ,left=1408 ,top=1572 ,right=1627 ,bottom=1627 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='AMT_1', left=1648, top=1572, right=1844, bottom=1627, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='BX0020', left=1172, top=1648, right=1368, bottom=1701, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='BR0020', left=937, top=1648, right=1156, bottom=1701, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BX0030', left=1172, top=1717, right=1368, bottom=1770, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='BR0030', left=937, top=1717, right=1156, bottom=1770, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BX0040', left=1172, top=1789, right=1368, bottom=1842, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='BR0040', left=937, top=1789, right=1156, bottom=1842, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='공조회대출' ,left=1408 ,top=1648 ,right=1627 ,bottom=1704 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='AMT_2', left=1648, top=1648, right=1844, bottom=1704, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='DIVNM3', left=42, top=2262, right=254, bottom=2320, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{APJAMT-APLAMT}', left=1405, top=2262, right=1622, bottom=2315, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='대출잔액' ,left=1167 ,top=2262 ,right=1363 ,bottom=2318 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TOTAMT3', left=947, top=2262, right=1143, bottom=2318, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SUPAMT3', left=714, top=2262, right=934, bottom=2318, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TOTCNT3', left=606, top=2262, right=706, bottom=2318, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='INSURNM3', left=267, top=2262, right=463, bottom=2318, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COJAMT', left=1648, top=2262, right=1865, bottom=2315, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=32 ,top=2254 ,right=1876 ,bottom=2254 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='DIVNM2', left=42, top=2191, right=254, bottom=2249, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INSURNM2', left=267, top=2191, right=463, bottom=2249, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TOTDAY2', left=479, top=2191, right=590, bottom=2249, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TOTCNT2', left=606, top=2191, right=706, bottom=2249, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SUPAMT2', left=714, top=2191, right=934, bottom=2249, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TOTAMT2', left=947, top=2191, right=1143, bottom=2249, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='상환횟수' ,left=1167 ,top=2191 ,right=1363 ,bottom=2249 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='APPCNT', left=1405, top=2191, right=1622, bottom=2246, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='COACNT', left=1648, top=2191, right=1865, bottom=2246, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=32 ,top=2180 ,right=1876 ,bottom=2180 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='DIVNM1', left=42, top=2117, right=254, bottom=2175, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INSURNM1', left=267, top=2117, right=463, bottom=2175, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TOTDAY1', left=479, top=2117, right=590, bottom=2175, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TOTCNT1', left=606, top=2117, right=706, bottom=2175, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SUPAMT1', left=714, top=2117, right=934, bottom=2175, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TOTAMT1', left=947, top=2117, right=1143, bottom=2175, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='상환이자' ,left=1167 ,top=2117 ,right=1363 ,bottom=2175 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='APLRAT', left=1405, top=2117, right=1622, bottom=2170, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='COLAMT', left=1648, top=2117, right=1865, bottom=2170, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=32 ,top=2103 ,right=1371 ,bottom=2103 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='저축종류' ,left=42 ,top=2035 ,right=254 ,bottom=2090 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금융기관' ,left=267 ,top=2035 ,right=463 ,bottom=2090 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기간' ,left=479 ,top=2035 ,right=590 ,bottom=2090 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='횟수' ,left=606 ,top=2035 ,right=706 ,bottom=2090 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='당월불입액' ,left=714 ,top=2035 ,right=934 ,bottom=2090 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='누계액' ,left=947 ,top=2035 ,right=1143 ,bottom=2090 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상환원금' ,left=1167 ,top=2035 ,right=1363 ,bottom=2090 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{Decode(APLAMT,0,,APLAMT)}', left=1405, top=2035, right=1622, bottom=2088, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{Decode(COAAMT,0,,COAAMT)}', left=1648, top=2035, right=1865, bottom=2088, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=29 ,top=2024 ,right=1876 ,bottom=2024 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=259 ,top=2027 ,right=259 ,bottom=2328 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=468 ,top=2027 ,right=468 ,bottom=2328 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=598 ,top=2027 ,right=598 ,bottom=2328 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=709 ,top=2027 ,right=709 ,bottom=2328 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=939 ,top=2027 ,right=939 ,bottom=2328 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='공조회대출' ,left=1640 ,top=1976 ,right=1871 ,bottom=2013 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='회    사    대    출' ,left=1283 ,top=1910 ,right=1749 ,bottom=1947 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1378 ,top=2103 ,right=1873 ,bottom=2103 </L>
	<L> left=1164 ,top=1961 ,right=1876 ,bottom=1961 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1630 ,top=1963 ,right=1630 ,bottom=2323 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1373 ,top=1963 ,right=1373 ,bottom=2323 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='사내대출' ,left=1392 ,top=1976 ,right=1622 ,bottom=2013 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구분' ,left=1167 ,top=1976 ,right=1363 ,bottom=2013 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TOTDAY3', left=479, top=2262, right=590, bottom=2318, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=29 ,top=2622 ,right=1876 ,bottom=2622 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=934 ,top=2360 ,right=934 ,bottom=2619 </L>
</B>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>	

<!-------------------------------------------------------------------------------------------
   ▣ 보고서 정의부분 - 상여명세서 ( 사용안함.)
-------------------------------------------------------------------------------------------->  
<comment id="__NSID__"><OBJECT id=gcrp_print2  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"			value="gcds_report0">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="0">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<param name="SaveToFileShowButton"value="true">		
	<param name="SaveToFileENV"     value='filename=c:\\temp;filetype=jpg;quality=100;bpp=8;ppf=0;pts=all;sizetype=resolution;width=400;height=300'>
	<param name=NullRecordFlag			value=True>
	<PARAM NAME="Format" VALUE="
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2753 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='지       급       내      역' ,left=544 ,top=850 ,right=1456 ,bottom=906 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=28 ,top=1441 ,right=1878 ,bottom=1441 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=28 ,top=922 ,right=1878 ,bottom=922 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=28 ,top=834 ,right=1878 ,bottom=834 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=28 ,top=800 ,right=1878 ,bottom=800 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=28 ,top=716 ,right=1878 ,bottom=716 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=31 ,top=1006 ,right=1878 ,bottom=1006 </L>
	<L> left=28 ,top=716 ,right=28 ,bottom=800 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1878 ,top=716 ,right=1878 ,bottom=800 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='실수령액' ,left=1281 ,top=731 ,right=1456 ,bottom=784 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='S93000', left=881, top=731, right=1256, bottom=784, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='공제총액' ,left=669 ,top=731 ,right=856 ,bottom=784 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='S91000', left=266, top=731, right=641, bottom=784, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='지급총액' ,left=53 ,top=731 ,right=234 ,bottom=784 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='S94000', left=1481, top=731, right=1856, bottom=784, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1466 ,top=719 ,right=1466 ,bottom=800 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=869 ,top=719 ,right=869 ,bottom=800 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=247 ,top=719 ,right=247 ,bottom=800 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1269 ,top=719 ,right=1269 ,bottom=800 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=653 ,top=719 ,right=653 ,bottom=800 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1878 ,top=834 ,right=1878 ,bottom=1441 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='P11000', left=266, top=1016, right=463, bottom=1072, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P12000', left=266, top=1084, right=463, bottom=1141, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P21000', left=266, top=1153, right=463, bottom=1209, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P22000', left=266, top=1222, right=463, bottom=1278, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P10000', left=266, top=941, right=463, bottom=997, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P24000', left=266, top=1366, right=463, bottom=1422, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='기본급' ,left=41 ,top=941 ,right=256 ,bottom=997 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=1647, top=1366, right=1863, bottom=1422, align='right'</C>
	<C>id='', left=1647, top=1291, right=1863, bottom=1347, align='right'</C>
	<C>id='P37000', left=716, top=1016, right=909, bottom=1072, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='개인연금보조' ,left=478 ,top=1016 ,right=697 ,bottom=1072 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출납수당' ,left=478 ,top=1153 ,right=697 ,bottom=1209 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='운전수당' ,left=478 ,top=1222 ,right=697 ,bottom=1278 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P26000', left=716, top=1222, right=909, bottom=1278, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P25000', left=716, top=1153, right=909, bottom=1209, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P32000', left=716, top=1084, right=909, bottom=1141, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P28000', left=716, top=1366, right=909, bottom=1422, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='자격수당' ,left=478 ,top=1366 ,right=697 ,bottom=1422 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P29000', left=716, top=941, right=909, bottom=997, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='남북경협수당' ,left=478 ,top=941 ,right=697 ,bottom=997 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=919 ,top=922 ,right=919 ,bottom=1437 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1375 ,top=925 ,right=1375 ,bottom=1441 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1631 ,top=925 ,right=1631 ,bottom=1441 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=259 ,top=925 ,right=259 ,bottom=1441 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=469 ,top=925 ,right=469 ,bottom=1441 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=706 ,top=925 ,right=706 ,bottom=1441 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1163 ,top=925 ,right=1163 ,bottom=1441 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='지역근무수당' ,left=478 ,top=1084 ,right=697 ,bottom=1141 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P30000', left=1172, top=941, right=1369, bottom=997, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='사장단수당' ,left=938 ,top=941 ,right=1156 ,bottom=997 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='식대보조' ,left=938 ,top=1366 ,right=1156 ,bottom=1422 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P35000', left=1172, top=1366, right=1369, bottom=1422, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='' ,left=1388 ,top=1291 ,right=1625 ,bottom=1347 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='' ,left=1388 ,top=1366 ,right=1625 ,bottom=1422 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=28 ,top=834 ,right=28 ,bottom=1441 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=28 ,top=1475 ,right=1878 ,bottom=1475 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=28 ,top=1553 ,right=1878 ,bottom=1553 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=259 ,top=1556 ,right=259 ,bottom=1853 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=706 ,top=1556 ,right=706 ,bottom=1853 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=28 ,top=1856 ,right=1878 ,bottom=1856 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=28 ,top=1478 ,right=28 ,bottom=1856 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1878 ,top=1478 ,right=1878 ,bottom=1856 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=28 ,top=1981 ,right=1878 ,bottom=1981 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=28 ,top=1891 ,right=1878 ,bottom=1891 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1384 ,top=1891 ,right=1384 ,bottom=2325 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=259 ,top=1984 ,right=259 ,bottom=2325 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=706 ,top=1984 ,right=706 ,bottom=2325 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=28 ,top=1891 ,right=28 ,bottom=2325 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1878 ,top=1891 ,right=1878 ,bottom=2325 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=28 ,top=2325 ,right=1878 ,bottom=2325 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=28 ,top=2625 ,right=1878 ,bottom=2625 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='누    계     내     역' ,left=47 ,top=2378 ,right=900 ,bottom=2434 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=28 ,top=2531 ,right=1878 ,bottom=2531 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=28 ,top=2447 ,right=1878 ,bottom=2447 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=28 ,top=2359 ,right=1878 ,bottom=2359 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1878 ,top=2359 ,right=1878 ,bottom=2619 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='3669-3867, 3669-3915' ,left=944 ,top=2462 ,right=1866 ,bottom=2519 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급여/상여 문의 및 주소 변경' ,left=944 ,top=2378 ,right=1866 ,bottom=2434 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=634 ,top=2453 ,right=634 ,bottom=2619 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=328 ,top=2453 ,right=328 ,bottom=2619 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='TS9100', left=53, top=2550, right=309, bottom=2603, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=28 ,top=2359 ,right=28 ,bottom=2619 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='저    축    내    역' ,left=556 ,top=1909 ,right=1103 ,bottom=1962 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='회    사    대    출' ,left=1400 ,top=1909 ,right=1869 ,bottom=1962 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공       제       내       역' ,left=531 ,top=1487 ,right=1381 ,bottom=1541 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연차수당' ,left=938 ,top=1084 ,right=1156 ,bottom=1141 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='학비보조금' ,left=938 ,top=1153 ,right=1156 ,bottom=1209 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='임원직책수당' ,left=938 ,top=1222 ,right=1156 ,bottom=1278 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PAYSEQNM', left=1388, top=375, right=1722, bottom=431, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAYGRDNM', left=1388, top=303, right=1722, bottom=359, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SANGNAME', left=1097, top=444, right=1375, bottom=500, face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='급       호 :' ,left=1097 ,top=375 ,right=1375 ,bottom=431 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직       위 :' ,left=1097 ,top=303 ,right=1375 ,bottom=359 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성       명 :' ,left=1097 ,top=231 ,right=1375 ,bottom=287 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PAYDT', left=1434, top=137, right=1875, bottom=194, align='right' ,mask='지급일:XXXX-XX-XX', face='굴림', size=13, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='귀하의 노고에 감사 드립니다.' ,left=484 ,top=531 ,right=1519 ,bottom=622 ,align='left' ,face='궁서' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SANGRAT', left=1388, top=444, right=1722, bottom=500, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=28 ,top=206 ,right=28 ,bottom=669 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=28 ,top=203 ,right=1878 ,bottom=203 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='EMPNO', left=331, top=231, right=666, bottom=287, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=1388, top=231, right=1722, bottom=287, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=28 ,top=669 ,right=1878 ,bottom=669 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='사       번 :' ,left=59 ,top=231 ,right=325 ,bottom=287 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소       속 :' ,left=59 ,top=303 ,right=325 ,bottom=356 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부양코드  :' ,left=56 ,top=372 ,right=322 ,bottom=428 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DEPTNM', left=331, top=303, right=1041, bottom=356, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BAEBUSU', left=331, top=372, right=666, bottom=428, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAYBNKNM', left=331, top=444, right=534, bottom=500, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='계좌번호  :' ,left=56 ,top=444 ,right=322 ,bottom=500 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PAYNUM', left=563, top=444, right=1088, bottom=500, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='/' ,left=534 ,top=444 ,right=563 ,bottom=500 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../Common/img/icon.jpg' ,left=719 ,top=2650 ,right=1197 ,bottom=2750</I>
	<C>id='CTITLE', left=497, top=34, right=1503, bottom=122, face='HY중고딕', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=28 ,top=2066 ,right=1369 ,bottom=2066 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1388 ,top=2066 ,right=1872 ,bottom=2066 </L>
	<C>id='P38000', left=1172, top=1222, right=1369, bottom=1278, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='PX0020', left=1647, top=941, right=1863, bottom=997, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PR0020', left=1388, top=941, right=1628, bottom=997, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P36000', left=1172, top=1153, right=1369, bottom=1209, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P39000', left=1647, top=1153, right=1863, bottom=1209, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='' ,left=1388 ,top=1222 ,right=1625 ,bottom=1278 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=1647, top=1222, right=1863, bottom=1278, align='right'</C>
	<T>id='전월소급' ,left=1388 ,top=1153 ,right=1628 ,bottom=1209 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1878 ,top=206 ,right=1878 ,bottom=669 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='직책수당' ,left=41 ,top=1016 ,right=256 ,bottom=1072 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시간외수당' ,left=41 ,top=1084 ,right=256 ,bottom=1141 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근속수당' ,left=41 ,top=1153 ,right=256 ,bottom=1209 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자기계발비' ,left=41 ,top=1222 ,right=256 ,bottom=1278 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='가족부양비' ,left=41 ,top=1294 ,right=256 ,bottom=1350 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차랑유지비' ,left=41 ,top=1366 ,right=256 ,bottom=1422 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='저축종류' ,left=41 ,top=2000 ,right=256 ,bottom=2056 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑근세' ,left=41 ,top=1572 ,right=256 ,bottom=1628 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='건강보험' ,left=41 ,top=1716 ,right=256 ,bottom=1772 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국민연금' ,left=41 ,top=1787 ,right=256 ,bottom=1841 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=41 ,top=1644 ,right=256 ,bottom=1697 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P23000', left=266, top=1294, right=463, bottom=1350, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='PX0010', left=1172, top=1294, right=1369, bottom=1350, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='휴일수당' ,left=938 ,top=1294 ,right=1156 ,bottom=1350 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P27000', left=716, top=1294, right=909, bottom=1350, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='연장수당' ,left=478 ,top=1294 ,right=697 ,bottom=1350 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=928 ,top=922 ,right=928 ,bottom=1437 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=31 ,top=1356 ,right=1878 ,bottom=1356 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=31 ,top=1284 ,right=1878 ,bottom=1284 </L>
	<L> left=31 ,top=1212 ,right=1878 ,bottom=1212 </L>
	<L> left=31 ,top=1144 ,right=1878 ,bottom=1144 </L>
	<L> left=31 ,top=1075 ,right=1878 ,bottom=1075 </L>
	<L> left=31 ,top=1775 ,right=1878 ,bottom=1775 </L>
	<C>id='B12000', left=266, top=1787, right=463, bottom=1841, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='B11000', left=266, top=1716, right=463, bottom=1772, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='T12000', left=266, top=1647, right=463, bottom=1700, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='T11000', left=266, top=1572, right=463, bottom=1628, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='여직원회비' ,left=478 ,top=1787 ,right=697 ,bottom=1841 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공조회비' ,left=478 ,top=1716 ,right=697 ,bottom=1772 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='개인연금' ,left=478 ,top=1647 ,right=697 ,bottom=1700 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='고용보험' ,left=478 ,top=1572 ,right=697 ,bottom=1625 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=31 ,top=1634 ,right=1878 ,bottom=1634 </L>
	<L> left=31 ,top=1706 ,right=1878 ,bottom=1706 </L>
	<L> left=469 ,top=1556 ,right=469 ,bottom=1853 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='B14000', left=716, top=1787, right=913, bottom=1841, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='B16000', left=716, top=1716, right=913, bottom=1772, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='B15000', left=716, top=1647, right=909, bottom=1700, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='B13000', left=716, top=1572, right=909, bottom=1625, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=919 ,top=1556 ,right=919 ,bottom=1853 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=928 ,top=1556 ,right=928 ,bottom=1853 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='보증보험' ,left=938 ,top=1572 ,right=1156 ,bottom=1628 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1163 ,top=1556 ,right=1163 ,bottom=1853 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='BX0010', left=1172, top=1572, right=1369, bottom=1628, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=1375 ,top=1556 ,right=1375 ,bottom=1853 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1631 ,top=1556 ,right=1631 ,bottom=1853 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='금융기관' ,left=266 ,top=2000 ,right=463 ,bottom=2056 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=469 ,top=1984 ,right=469 ,bottom=2325 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='총불입기간' ,left=478 ,top=2000 ,right=697 ,bottom=2056 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='누계횟수' ,left=716 ,top=2000 ,right=913 ,bottom=2056 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=928 ,top=1984 ,right=928 ,bottom=2325 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='당월불입액' ,left=938 ,top=2000 ,right=1156 ,bottom=2056 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1163 ,top=1984 ,right=1163 ,bottom=2325 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='누계액' ,left=1172 ,top=2000 ,right=1369 ,bottom=2056 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1375 ,top=1894 ,right=1375 ,bottom=2325 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='대출상환원금' ,left=1394 ,top=2000 ,right=1619 ,bottom=2056 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1631 ,top=1984 ,right=1631 ,bottom=2325 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='대출잔액' ,left=1394 ,top=2247 ,right=1619 ,bottom=2303 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대출상환회수' ,left=1394 ,top=2166 ,right=1619 ,bottom=2222 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대출상환이자' ,left=1394 ,top=2084 ,right=1619 ,bottom=2141 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=31 ,top=2237 ,right=1878 ,bottom=2237 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=31 ,top=2153 ,right=1878 ,bottom=2153 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='소득누계' ,left=56 ,top=2466 ,right=309 ,bottom=2522 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TT1200', left=656, top=2550, right=913, bottom=2603, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TT1100', left=356, top=2550, right=613, bottom=2603, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='주민세누계' ,left=656 ,top=2466 ,right=913 ,bottom=2522 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑근세누계' ,left=356 ,top=2466 ,right=613 ,bottom=2522 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=928 ,top=2362 ,right=928 ,bottom=2619 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<C>id='PX0030', left=1647, top=1016, right=1863, bottom=1072, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='PR0030', left=1388, top=1016, right=1628, bottom=1072, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P31000', left=1172, top=1016, right=1369, bottom=1072, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='특수지수당' ,left=938 ,top=1016 ,right=1156 ,bottom=1072 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PX0040', left=1647, top=1084, right=1863, bottom=1141, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='PR0040', left=1388, top=1084, right=1628, bottom=1141, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='P34000', left=1172, top=1084, right=1369, bottom=1141, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='BX0040', left=1641, top=1572, right=1838, bottom=1625, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='BR0040', left=1406, top=1572, right=1625, bottom=1625, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BX0020', left=1172, top=1716, right=1369, bottom=1769, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='BR0020', left=938, top=1716, right=1156, bottom=1769, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BR0030', left=938, top=1784, right=1156, bottom=1837, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BX0030', left=1172, top=1784, right=1369, bottom=1837, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='대출원금이자' ,left=938 ,top=1644 ,right=1156 ,bottom=1700 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>	

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>