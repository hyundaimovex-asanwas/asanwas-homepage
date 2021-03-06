<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	급여/개인등급관리
+ 프로그램 ID	: p050002.HTML
+ 기 능 정 의	: 조회|등록|저장|삭제|파일|엑셀|확인서
+ 변 경 이 력	: 권영법
+ 수 정 이 력	: 이순미 - 2005.08.05 - 소스 정리
+ 서 블 릿 명	: p050002_s1, p050002_s2
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>개인등급관리</title>
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
var curtid = "88001";  
var key_sabun="";
var gs_level;
var gs_treecd;
var gs_level2;
var gs_treecd2;
var gs_level3="";
var gs_treecd3="";
var gs_premm="";
var gs_curmm="";
get_cookdata();
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	gcem_yymm_search.Text=gs_date2;         //기준년월
	gcem_yymm_search2.Text=gs_date2;        //기준년월
	gcem_yymm_search3.Text=gs_date2;        //기준년월
  

	//소속정보 1
	gcds_dept1.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?v_str1="; 
	gcds_dept1.Reset();
  
	//소속정보 2
	gcds_dept2.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?v_str1="; 
	gcds_dept2.Reset();


  //건강보험 수정
	gcds_dept3.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?v_str1="; 
	gcds_dept3.Reset();
	

	var Obj="div_zipcode";
	var div_cm=new Array("div_zipcode","div_sendal","div_holiday","div_special");

  for(var i=0;i<=3;i++)  {
		if(div_cm[i]==Obj)	{
			eval("document.all."+Obj+".style.display='block';");
		}	else	{
			eval("document.all."+div_cm[i]+".style.display='none';");
		}
  }
	gcem_emo_1.Enable=false;
	txt_empnmk_1.disabled=true;
	img_1.disabled=true;
	gcem_appdt_1.Enable=false;
	gcem_GRDCD_1.Enable=false;

	gcem_emo_2.Enable=false;
	txt_empnmk_2.disabled=true;
	img_2.disabled=true;
	gcem_appdt_2.Enable=false;
	gcem_GRDCD_2.Enable=false;
}

/******************************************************************************
	Description : 사원조회
******************************************************************************/
function ln_FindEmp(e,e2){
	if(e2=='2')	{   
		var str1=fn_trim(gcem_emo.Text);
		gcds_select_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040001_s1?"+ "v_str1=" + str1;
		gcds_select_ec01az.Reset();
	}else	{
		var arrResult	= new Array();
		var arrSend	= new Array();
		    arrSend[0]='P040001';
		window.dialogArguments=arrSend[0];
		var strURL;	
		var strPos;
		strURL = "./H030003_popup.jsp"
		//strURL = "P040001_popup.html"
		strPos = "dialogWidth:377px;dialogHeight:363px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrSend,strPos);
		
		if(e=="1") {
			if (arrResult != null) {
				arrParam = arrResult.split(";");
				gcem_emo_1.Text = arrParam[0];     // 사번
				txt_empnmk_1.value = arrParam[1];    //성명
				hid_deptnm_1.value = arrParam[3];  //소속명
				hid_resino_1.value = arrParam[9];  //주민번호
				gcem_appdt_1.Focus();
			} else {
				gcem_emo_1.Text = "";     // 사번
				txt_empnmk_1.value = "";    //성명
				hid_deptnm_1.value = "";  //소속명
				hid_resino_1.value = "";  //주민번호
			}	
		}	else	{
			if (arrResult != null) {
				arrParam = arrResult.split(";");
				gcem_emo_2.Text = arrParam[0];     // 사번
				txt_empnmk_2.value = arrParam[1];    //성명
				hid_deptnm_2.value = arrParam[3];  //소속명
				hid_resino_2.value = arrParam[9];  //주민번호
				gcem_appdt_2.Focus();
			} else {
				gcem_emo_2.Text = "";     // 사번
				txt_empnmk_2.value = "";    //성명
				hid_deptnm_2.value = "";  //소속명
				hid_resino_2.value = "";  //주민번호
			}
		}
	}
}

/******************************************************************************
	Description : 조회 1
******************************************************************************/
function ln_Query(gubun){
	eval("ln_Query_"+gubun+"();");
}

/******************************************************************************
	Description : 조회 2
******************************************************************************/
function ln_Query_1(){

	var str1 = fn_trim(gcem_yymm_search.Text);						//기준년월
	var str2 = fn_trim(gclx_select_ec01az.BindColVal);    //소속
	var str3 = fn_trim(txt_empnmk_search_1.value);        //성명
	var str4 = "1";																				//보험구분 1,건강 2,국민
	gcds_grid_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050002_s1?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
									 + "&v_str5=" + gs_level
									 + "&v_str6=" + gs_treecd;
	gcds_grid_ec01az.Reset(); //그리드
	gcds_grid_ec01az.rowposition=1;
}

/******************************************************************************
	Description : 조회 3
******************************************************************************/
function ln_Query_2(){

	var str1 = fn_trim(gcem_yymm_search2.Text);						//기준년월
	var str2 = fn_trim(gclx_select_ec02az.BindColVal);		//소속
	var str3 = fn_trim(txt_empnmk_search_2.value);        //성명
	var str4 = "2";																				//보험구분 1,건강 2,국민

	gcds_grid_ec02az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050002_s2?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
                   + "&v_str5=" + gs_level2
									 + "&v_str6=" + gs_treecd2;
	gcds_grid_ec02az.Reset(); //그리드
	//prompt("",gcds_grid_ec02az.DataID);
	gcds_grid_ec02az.rowposition=1;
}


/******************************************************************************
	Description : 건강보험 수정
******************************************************************************/
function ln_Query_3(){
	var str1 = fn_trim(gcem_yymm_search3.Text);						//기준년월
	var str2 = fn_trim(gclx_select_ec03az.BindColVal);		//소속
	var str3 = fn_trim(txt_empnmk_search_3.value);        //성명
	var str4 =""; //이전년월
	var preyymm="";
  var curyymm="";


  if(str1.substring(4,6)=="01"){
		str4 = parseInt(str1.substring(0,4)-1)+"12";
	}else{
	  str4 = parseInt(str1)-1;
	}

 str4=str4+"";

 preyymm=str4.substring(0,4)+"년"+str4.substring(4,6)+"월";
 curyymm=str1.substring(0,4)+"년"+str1.substring(4,6)+"월";

 gs_premm=str4.substring(4,6);
 gs_curmm=str1.substring(4,6);

 gcgd_grid_ec03az.ColumnProp("PRE","Name")=preyymm;
 gcgd_grid_ec03az.ColumnProp("CUR","Name")=curyymm;
	
 /****
	gcds_cnt03.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050002_s9?"
									  + "v_str1=" + str1 ; 
	gcds_cnt03.Reset(); //그리드
	
	//신규건
	if(gcds_cnt03.namevalue(1,"CNT")==0){
		gcds_grid_ec03az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050002_s3?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
                   + "&v_str5=" + gs_level3
									 + "&v_str6=" + gs_treecd3;
		gcds_grid_ec03az.Reset(); //그리드
		gcds_grid_ec03az.rowposition=1;
	}else{ //데이타가 존재하는 경우
		gcds_grid_ec03az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050002_s4?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
                   + "&v_str5=" + gs_level3
									 + "&v_str6=" + gs_treecd3;
		gcds_grid_ec03az.Reset(); //그리드
		gcds_grid_ec03az.rowposition=1;
	}

	**/
   gcds_grid_ec03az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050002_s5?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
                   + "&v_str5=" + gs_level3
									 + "&v_str6=" + gs_treecd3;
		gcds_grid_ec03az.Reset(); //그리드
		gcds_grid_ec03az.rowposition=1;


}

/******************************************************************************
	Description : 추가 2
******************************************************************************/
function ln_Insert_1(){   //건강보험
	if(gcds_grid_ec01az.countRow==0)  {
	var THeader = "APPYM:String(6),"	
		        +"DEPTNM:String(70),"	
						+"EMPNO:String(7),"   
						+"EMPNMK:String(20),"   
						+"MEDSNO:String(20),"	
						+"GRDCD:Decimal(3),"	
						+"INSAMT:Decimal(9),"	
						+"STDAMT:Decimal(9),"	
						+"GETDT:String(8),"	
						+"LOSDT:String(8),"	
						+"REPDT:String(8),"
						+"RESINO:String(13)";	
                  
		gcds_grid_ec01az.DataID = "";
		gcds_grid_ec01az.SetDataHeader(THeader);
	}
	//gcds_grid_ec02az.NameValue(gcds_grid_ec02az.rowposition,"INSGB")="1";
	gcds_grid_ec01az.addRow();
	gcem_emo_1.disabled=false;
	txt_empnmk_1.disabled=false;
	img_1.disabled=false;
	gcem_appdt_1.Text=gs_date2;
	gcem_emo_1.Focus();

}

/******************************************************************************
	Description : 추가 2
******************************************************************************/
function ln_Insert_2(){   //국민연금
   if(gcds_grid_ec02az.countRow==0)
   {
		var THeader = "APPYM:String(6),"	
		        +"DEPTNM:String(70),"	
						+"EMPNO:String(7),"   
						+"EMPNMK:String(20),"   
						+"MEDSNO:String(20),"	
						+"GRDCD:Decimal(3),"	
						+"INSAMT:Decimal(9),"	
						+"STDAMT:Decimal(9),"	
						+"GETDT:String(8),"	
						+"LOSDT:String(8),"	
						+"REPDT:String(8),"
						+"RESINO:String(13)";	

		gcds_grid_ec02az.DataID = "";
		gcds_grid_ec02az.SetDataHeader(THeader);
	}
	gcds_grid_ec02az.addRow();
	//gcds_grid_ec02az.NameValue(gcds_grid_ec02az.rowposition,"INSGB")="2";

	gcem_emo_2.disabled=false;
	txt_empnmk_2.disabled=false;
	img_2.disabled=false;
	gcem_appdt_2.Text=gs_date2;
	gcem_emo_2.Focus();
	
}

/******************************************************************************
	Description : 저장 1
******************************************************************************/
function ln_Save_1(){
	
	if (gcds_grid_ec01az.IsUpdated) {
		if (confirm("변경된 정보를 저장하시겠습니까?")) {
			for(i=1;i<=gcds_grid_ec01az.countrow;i++)	{
				if( gcds_grid_ec01az.NameValue(i,"EMPNO")==""
				 || gcds_grid_ec01az.NameValue(i,"APPYM")=="")
					gcds_grid_ec01az.deleterow(i);
			}
			gctr_grade1.KeyValue = "p050002_t1(I:USER=gcds_grid_ec01az)";
			gctr_grade1.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050002_t1";

			//prompt("",gcds_grid_ec01az.text)
			gctr_grade1.post();
		}
	}
}

/******************************************************************************
	Description : 저장 2
******************************************************************************/
function ln_Save_2(){

	if (gcds_grid_ec02az.IsUpdated) {
		if (confirm("변경된 정보를 저장하시겠습니까?")) {
			for(i=1;i<=gcds_grid_ec01az.countrow;i++)	{
				if(  gcds_grid_ec02az.NameValue(i,"EMPNO")==""
				  || gcds_grid_ec02az.NameValue(i,"APPYM")=="")
					gcds_grid_ec02az.deleterow(i);
			}
			gctr_grade2.KeyValue = "p050002_t2(I:USER=gcds_grid_ec02az)";
			gctr_grade2.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050002_t2";
			//prompt("",gcds_grid_ec02az.text);
			gctr_grade2.post();
		}
	}
}


/******************************************************************************
	Description : 건강보험수정 저장
******************************************************************************/
function ln_Save_3(){

  if(gcds_cnt03.namevalue(1,"CNT")==0){ // 신규건
		if (confirm("새로운 정보를 저장하시겠습니까?")) {
			for(i=1;i<=gcds_grid_ec03az.countrow;i++){
				gcds_grid_ec03az.namevalue(i,"REMARK")=gcds_grid_ec03az.namevalue(i,"REMARK")+" ";
			}
			gctr_grade2.KeyValue = "p050002_t3(I:USER=gcds_grid_ec03az)";
			gctr_grade2.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050002_t3";
			gctr_grade2.post();
		}
	}else{ //수정건.
		if (confirm("변경된 정보를 저장하시겠습니까?")) {
			gctr_grade2.KeyValue = "p050002_t4(I:USER=gcds_grid_ec03az)";
			gctr_grade2.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050002_t4";
			//prompt('',gcds_grid_ec03az.text);
			gctr_grade2.post();
		}
	}
}

/******************************************************************************
	Description : 파일열기
******************************************************************************/
function ln_FileOpen_1(){
	
	var str1=gcem_yymm_search.Text;
	inp_File_1.Open();

	var str2=fn_trim(inp_File_1.Value);
	var str3=str2.substr(str2.length-3,3).toLowerCase();
	if(str2=="")
		alert("파일을 선택하세요");
	else if(str3 !="csv")
	{
	  inp_File_1.Value="";
		alert("CSV확장자 파일을 선택하세요");
	}
	else if(str1.length != 6)
		alert("기준년월을 6자리를 정확히 입력하세요");
	else
		ln_File_1();
}

/******************************************************************************
	Description : 데이터 임포트
******************************************************************************/
function ln_File_1(){
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";

		var THeader = "APPYM:String(6),"	
		        +"DEPTNM:String(70),"	
						+"EMPNO:String(7),"   
						+"EMPNMK:String(20),"   
						+"MEDSNO:String(20),"	
						+"GRDCD:Decimal(3),"	
						+"INSAMT:Decimal(9),"	
						+"STDAMT:Decimal(9),"	
						+"GETDT:String(8),"	
						+"LOSDT:String(8),"	
						+"REPDT:String(8),"
						+"RESINO:String(13)";	

	gcds_dump.DataID = inp_File_1.Value;//파일경로
	gcds_dump.Reset();
	gcds_grid_ec01az.SyncLoad=true;
	gcds_grid_ec01az.ClearAll();
	gcgd_grid_ec01az.DataID = "";
	gcds_grid_ec01az.SetDataHeader(THeader);
	var ls_pd = gcem_yymm_search.Text;
	//ls_pd = ls_pd.substring(0,4) + "-" + ls_pd.substring(4,6) + "-" + ls_pd.substring(6,8);
	//if (fn_trim(gcds_dump.ColumnValue(j,1))==ls_pd) alert("ok");
	
	for (var j=1; j<=gcds_dump.countrow;j++){
		if (fn_trim(gcds_dump.ColumnValue(j,1))==ls_pd){
			gcds_grid_ec01az.addrow();
			gcds_grid_ec01az.UserStatus(j)=1;
			var ls_pos = gcds_grid_ec01az.rowposition;
			for (var i=1; i<=12; i++) {    //칼럼갯수
			 gcds_txt=fn_trim(gcds_dump.ColumnValue(j,i));
			 gcds_txt=ln_Ltrim(gcds_txt,",");
			 if(i!=7&&i!=8){
					gcds_txt=ln_Ltrim(gcds_txt,"-");
			 }
			 gcds_txt=ln_Ltrim(gcds_txt,"/");
			 gcds_grid_ec01az.ColumnValue(ls_pos,i) = gcds_txt;
			}
		}
	}
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	ft_cnt1.innerText = "조회건수 : " + gcds_grid_ec01az.countrow + " 건";
	if (gcds_grid_ec01az.countrow <1) alert("검색된 데이터가 없습니다.");

	gcgd_grid_ec01az.DataID = "gcds_grid_ec01az";
	gcds_grid_ec01az.SyncLoad=false;
	inp_File_1.Value="";
}

/******************************************************************************
	Description : 파일열기
******************************************************************************/
function ln_FileOpen_2(){
	var str1=gcem_yymm_search2.Text;
	inp_File_2.Open();

	var str2=fn_trim(inp_File_2.Value);
	var str3=str2.substr(str2.length-3,3).toLowerCase();
	if(str2=="")
		alert("파일을 선택하세요");
	else if(str3 !="csv")
	{
	  inp_File_2.Value="";
		alert("CSV확장자 파일을 선택하세요");
	}
	else if(str1.length != 6)
		alert("기준년월을 6자리를 정확히 입력하세요");
	else
		ln_File_2();

}

/******************************************************************************
	Description : 데이터 임포트
******************************************************************************/
function ln_File_2(){
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	////document.all.LowerFrame.style.visibility="visible";

		var THeader = "APPYM:String(6),"	
		        +"DEPTNM:String(70),"	
						+"EMPNO:String(7),"   
						+"EMPNMK:String(20),"   
						+"MEDSNO:String(20),"	
						+"GRDCD:Decimal(3),"	
						+"INSAMT:Decimal(9),"	
						+"STDAMT:Decimal(9),"	
						+"GETDT:String(8),"	
						+"LOSDT:String(8),"	
						+"REPDT:String(8),"
						+"RESINO:String(13)";	
	gcds_dump.DataID = inp_File_2.Value;
	gcds_dump.Reset();
	gcds_grid_ec02az.SyncLoad=true;
	gcds_grid_ec02az.ClearAll();
	gcds_grid_ec02az.DataID = "";
	gcds_grid_ec02az.SetDataHeader(THeader);
	var ls_pd = gcem_yymm_search2.Text;
	//ls_pd = ls_pd.substring(0,4) + "-" + ls_pd.substring(4,6) + "-" + ls_pd.substring(6,8);
	//if (fn_trim(gcds_dump.ColumnValue(j,1))==ls_pd) alert("ok");

  gcgd_grid_ec02az.DataID="";

	for (var j=1; j<=gcds_dump.countrow;j++){
		if (fn_trim(gcds_dump.ColumnValue(j,1))==ls_pd ){

			gcds_grid_ec02az.addrow();
			var ls_pos = gcds_grid_ec02az.rowposition;
			for (var i=1; i<=12; i++) {
				 gcds_txt=fn_trim(gcds_dump.ColumnValue(j,i));
				 gcds_txt=ln_Ltrim(gcds_txt,",");
				 if(i!=7&&i!=8){
					gcds_txt=ln_Ltrim(gcds_txt,"-");
			   }
				 gcds_txt=ln_Ltrim(gcds_txt,"/");
				 gcds_grid_ec02az.ColumnValue(ls_pos,i) = gcds_txt;
			}
		}
	}

	window.status="조회가 완료 되었습니다.";
	////document.all.LowerFrame.style.visibility="hidden";

	ft_cnt2.innerText = "조회건수 : " + gcds_grid_ec02az.countrow + " 건";
	if (gcds_grid_ec02az.countrow <1) alert("검색된 데이터가 없습니다.");

	gcgd_grid_ec02az.DataID = "gcds_grid_ec02az";
	gcds_grid_ec02az.SyncLoad=false;
	inp_File_2.Value="";
}

/******************************************************************************
	Description :
******************************************************************************/
function ln_Date(sdate) {
  var ls_yy = sdate.substring(0,4);
  var ls_mm = sdate.substring(5,7);
  var ls_dd = sdate.substring(8,10);

	return ls_yy + ls_mm + ls_dd
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Time(stime) {
  var ls_hh = stime.substring(0,2);
  var ls_mm = stime.substring(3,5);
  var ls_ss = stime.substring(6,8);
	var ls_uu = stime.substring(9,10);
	return ls_hh + ls_mm + ls_ss + ls_uu
}

/******************************************************************************
	Description :
******************************************************************************/
function ln_Ltrim(src,arg) {
	if(src !=undefined)
	{
	var li_chk = src.length/4+1;
	var ls_val = src;
	for (var i=1; i<=li_chk; i++)	ls_val = ls_val.replace(arg,"");
	return ls_val;
	}
}

/******************************************************************************
	Description :
******************************************************************************/
function ln_sTrim(src,arg) {
	if(src !=undefined)
	{
	var li_chk = src.length/4+1;
	var ls_val = src;
	for (var i=1; i<=li_chk; i++)	ls_val = ls_val.replace(arg,"");
	return ls_val;
	}
}

/*******************************************************************************
  Description : Grid 데이터를 Excel을 실행시켜 출력
******************************************************************************/
function ln_Excel_1(){
gcgd_grid_ec01az.ColumnProp('APPYM','Mask')="";
	if (gcds_grid_ec01az.countrow<1) alert("다운로드하실 자료가 없습니다.");
	else gcgd_grid_ec01az.RunExcel('개인보험등급내역');

gcgd_grid_ec01az.ColumnProp('APPYM','Mask')="XXXX/XX";

}

/*******************************************************************************
  Description : Grid 데이터를 Excel을 실행시켜 출력
******************************************************************************/
function ln_Excel_2(){
	gcgd_grid_ec02az.ColumnProp('APPYM','Mask')="";

	if (gcds_grid_ec02az.countrow<1) alert("다운로드하실 자료가 없습니다.");
	else gcgd_grid_ec02az.RunExcel('개인연금등급내역');
	gcgd_grid_ec02az.ColumnProp('APPYM','Mask')="XXXX/XX";
}

/*******************************************************************************
  Description : Grid 데이터를 Excel을 실행시켜 출력
******************************************************************************/
function ln_Excel_3(){
  if (gcds_grid_ec03az.countrow<1) alert("다운로드하실 자료가 없습니다.");
	else gcgd_grid_ec03az.GridToExcel('건강보험수정',"",2);
}

/******************************************************************************
	Description : 삭제 1
******************************************************************************/
function ln_Del_1(){
	if (gcds_grid_ec01az.countrow >0) {
		if (confirm("선택한 정보를 삭제하시겠습니까?")){
			gcds_grid_ec01az.deleterow(gcds_grid_ec01az.rowposition);
			ln_Save_1();
		}
	}
}

/******************************************************************************
	Description : 삭제 2
******************************************************************************/
function ln_Del_2(){
	if (gcds_grid_ec02az.countrow >0) {
		if (confirm("선택한 정보를 삭제하시겠습니까?")){
			gcds_grid_ec02az.deleterow(gcds_grid_ec02az.rowposition);
			ln_Save_2();
		}
	}
}

/******************************************************************************
	Description :
******************************************************************************/
function ln_Certi_prt_1(){

}

/******************************************************************************
	Description :
******************************************************************************/
function ln_Create_1(){

}

/******************************************************************************
	Description :
******************************************************************************/
function ln_Create_2(){

}

/******************************************************************************
	Description :
******************************************************************************/
function ln_visible_hidden(index){
	var div_cm=new Array("div_zipcode","div_sendal","div_holiday","div_special");
	for(var i=0;i<=3;i++) {
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}	else {
			eval("document.all."+div_cm[i]+".style.display='none';");
		}
  }
}



function ln_Print_3(){
	var THeader = "TITLE:STRING(50),PREYYMM:STRING(70),CURYYMM:STRING(70)" 
	gcds_prtmst.DataID = "";
	gcds_prtmst.SetDataHeader(THeader);

  gcds_prtmst.addrow();

	var stryymm = gcem_yymm_search3.text;

  gcds_prtmst.namevalue(1,"TITLE")=stryymm.substring(0,4)+"년 "+stryymm.substring(4,6)+"월분 국민건강보험료";

  gcds_prtmst.namevalue(1,"PREYYMM") = "당월보험료("+gs_premm+"월분)"; 
	gcds_prtmst.namevalue(1,"CURYYMM") = "당월보험료("+gs_curmm+"월분)"; 

  gcrp_print1.preview();	

}


function ln_Find_3(){ 
  /*
	for(i=1;i<=gcds_grid_ec03az.countrow;i++){
		if(gcds_grid_ec03az.namevalue(i,"EMPNMK")==fn_trim(txt_empnmk_search_3.value)){
			gcds_grid_ec03az.rowposition=i;
			return;
		}
	}
	*/

	for(i=1;i<=gcds_grid_ec03az.countrow;i++){
		if(gcds_grid_ec03az.namevalue(i,"EMPNMK")==fn_trim(txt_empnmk_search_3.value)){
			gcds_grid_ec03az.rowposition=i;
			if (confirm("계속 찾으시겠습니까?")) {
			}else{
				return;
			}
		}

		if(i==gcds_grid_ec03az.countrow){
			alert("더 이상 존재하지 않습니다.");
		}
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcds_dept3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
	<PARAM NAME="SYNCLOAD" VALUE="true">
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_dept1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
	<PARAM NAME="SYNCLOAD" VALUE="true">
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_dept2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
	<PARAM NAME="SYNCLOAD" VALUE="true">
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_grid_ec01az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false">  <!-- 보험료 -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_grid_ec02az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false">  <!-- 연금 -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_grid_ec03az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false">  <!-- 요율 -->
		<param name=SubsumExpr	value="Total,1:GROUPNM">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_dump"   classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49   VIEWASTEXT> 
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_cnt03"   classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49   VIEWASTEXT> 
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- 건강보험수정 입력시 사용. -->
<comment id="__NSID__"><OBJECT id="gcds_data3"   classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49   VIEWASTEXT> 
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- 출력 mst. -->
<comment id="__NSID__"><OBJECT id="gcds_prtmst"   classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49   VIEWASTEXT> 
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_grade1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--공통하위코드 TR-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gctr_grade2" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--공통하위코드 TR-->
	<PARAM NAME="timeout"  VALUE="240000">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<script language="javascript" for="gcds_dept3" event="onloadCompleted(row,colid)">
	gcds_dept3.InsertRow(1);
  gcds_dept3.NameValue(1,"DEPTCD")="";
  gcds_dept3.NameValue(1,"DEPTNM")="전체";
	gclx_select_ec03az.index=0; //보험구분
</script>

<script language="javascript" for="gcds_dept1" event="OnLoadStarted()">
  window.status="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dept1" event="onloadCompleted(row,colid)">
	gcds_dept1.InsertRow(1);
  gcds_dept1.NameValue(1,"DEPTCD")="";
  gcds_dept1.NameValue(1,"DEPTNM")="전체";
	gclx_select_ec01az.index=0; //보험구분
</script>

<script language="javascript" for="gcds_dept2" event="OnLoadStarted()">
  window.status="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dept2" event="onloadCompleted(row,colid)">
	gcds_dept2.InsertRow(1);
  gcds_dept2.NameValue(1,"DEPTCD")="";
  gcds_dept2.NameValue(1,"DEPTNM")="전체";
	gclx_select_ec02az.index=0; //보험구분
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec01az.countrow <=0)
	alert("조회된 데이타가 없습니다.");
</script>

<script language="javascript" for="gcds_grid_ec01az" event="OnRowPosChanged(row)">
	if(gcds_grid_ec01az.rowStatus(row) ==1)	{
		gcem_emo_1.Enable=true;
		txt_empnmk_1.disabled=false;
		img_1.disabled=false;
		gcem_appdt_1.Enable=true;
		gcem_GRDCD_1.Enable=true;
	}else{
		gcem_emo_1.Enable=false;
		txt_empnmk_1.disabled=true;
		img_1.disabled=true;
		gcem_appdt_1.Enable=false;
		gcem_GRDCD_1.Enable=false;
	}
</script>

<script language="javascript" for="gcds_grid_ec02az" event="OnLoadStarted()">
	ft_cnt2.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec02az" event="onloadcompleted(row,colid)">
	ft_cnt2.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec02az.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>

<script language="javascript" for="gcds_grid_ec02az" event="OnRowPosChanged(row)">
	if(gcds_grid_ec02az.rowStatus(row) ==1)	{
		gcem_emo_2.Enable=true;
		txt_empnmk_2.disabled=false;
		img_2.disabled=false;
		gcem_appdt_2.Enable=true;
		gcem_GRDCD_2.Enable=true;
	}	else	{
		gcem_emo_2.Enable=false;
		txt_empnmk_2.disabled=true;
		img_2.disabled=true;
		gcem_appdt_2.Enable=false;
		gcem_GRDCD_2.Enable=false;
	}
</script>

<script language=JavaScript for=ADE_Tab_1 event=OnSelChanged(index)>
	ln_visible_hidden((index-1));
</script>

<script language=JavaScript for=gclx_select_ec01az event=onSelChange()>
   
		gs_level = '';
		gs_treecd ='';
		gs_level = gclx_select_ec01az.ValueOfIndex ("level", gclx_select_ec01az.Index);
		gs_treecd = gclx_select_ec01az.ValueOfIndex ("treecd", gclx_select_ec01az.Index);

		gs_treecd = fn_treecd(gs_level, gs_treecd);
</script>

<script language=JavaScript for=gclx_select_ec02az event=onSelChange()>
    
		gs_level2 = '';
		gs_treecd2 ='';
		gs_level2 = gclx_select_ec02az.ValueOfIndex ("level", gclx_select_ec02az.Index);
		gs_treecd2 = gclx_select_ec02az.ValueOfIndex ("treecd", gclx_select_ec02az.Index);

		gs_treecd2 = fn_treecd(gs_level2, gs_treecd2);
</script>

<script language=JavaScript for=gclx_select_ec03az event=onSelChange()>
    
		gs_level3 = '';
		gs_treecd3 ='';
		gs_level3 = gclx_select_ec03az.ValueOfIndex ("level", gclx_select_ec03az.Index);
		gs_treecd3 = gclx_select_ec03az.ValueOfIndex ("treecd", gclx_select_ec03az.Index);

		gs_treecd3 = fn_treecd(gs_level3, gs_treecd3);
</script>


<script language="javascript" for="gcds_grid_ec03az" event="OnLoadStarted()">
  window.status="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>


<script language="javascript" for="gcds_grid_ec03az" event="onloadcompleted(row,colid)">
  ft_cnt3.innerText = "조회건수 : " + gcds_grid_ec03az.RealCount(0,row) + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec03az.countrow <=0){
		alert("조회된 데이타가 없습니다.");
	}else{
		for(i=1;i<=row;i++){
     // alert("CurLevel::"+gcds_grid_ec03az.namevalue(i,"CurLevel"));
		  /*
			if(){
			}else{
			}
			*/
		}
	}


</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_grade1" event="OnSuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	//ln_Query();
</script>
<script language="javascript" for="gctr_grade1" event="OnFail()">
	alert("데이타 입력시 에러가 발생했습니다.");
</script>

<script language="javascript" for="gctr_grade2" event="OnSuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	//ln_Query();
</script>
<script language="javascript" for="gctr_grade2" event="OnFail()">
	//alert("데이타 입력시 에러가 발생했습니다.");
	alert("Error Code : " + gctr_grade2.ErrorCode + "\n" + "Error Message : " + gctr_grade2.ErrorMsg + "\n");

</script>


</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/p050002_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2 ALING=LEFT>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr> 
          <td width="0" align=RIGHT><NOBR>
						<comment id="__NSID__"><OBJECT id=ADE_Tab_1 classid=clsid:ED382953-E907-11D3-B694-006097AD7252  VIEWASTEXT style="width:660px;height:20px">
							<PARAM NAME="BackColor" VALUE="#cccccc">
							<PARAM NAME="titleHeight" VALUE="20px">
							<PARAM NAME="DisableBackColor" VALUE="#eeeeee">
							<PARAM NAME="Format" VALUE="
								<T>divid=div_zipcode  title=건강보험</T>                          						  
								<T>divid=div_sendal   title=국민연금</T>
								<T>divid=div_holiday  title=건강보험전월대비</T>
								">
		          </OBJECT></comment><script>__ws__(__NSID__);</script></NOBR>
					</td>
        </tr>
			</table>
    </td>
  </tr>
  <tr><td height=10></td></tr>
  <tr> 
    <td COLSPAN=2>
<!-- 건강보험 -->
<div id="div_zipcode" style="display:block">
	<table width="875" cellpadding="1" cellspacing="0" border="0">
    <tr> 
		  <td colspan=8 align=center>
        <table width="860" cellpadding="1" cellspacing="0" border="0" style='border:1 solid #708090' >
          <tr> 
            <td width="10" style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
							<nobr>&nbsp;기준년월&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gcem_yymm_search classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
				        <param name=Text          value="">
				        <param name=Alignment	  value=0>
		        		<param name=Border	      value=True>
	        			<param name=ClipMode	  value=true>
        				<param name=Numeric	      value=false>
        				<param name=Format	      value="YYYY/MM">
        				<param name=MaxLength     value=6>
        				<param name=PromptChar	  value="_">
        				<param name=IsComma	      value=false>
        				<param name=BackColor     value="#CCCCCC">
        				<param name=InheritColor  value=false>
        			</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td> 
            <td width="10" style="border:0 solid #708090;border-right-width:1px;"bgcolor="#eeeeee">
							<nobr>&nbsp;소속&nbsp;</nobr></td>
            <td  style="border:0 solid #708090;border-top-width:0px;border-right-width:1px;"><nobr>
							<comment id="__NSID__"><object id=gclx_select_ec01az  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
								<param name=ComboDataID			value=gcds_dept1>
								<param name=SearchColumn		value="DEPTCD^DEPTNM">
								<param name=Sort            value="false">
								<param name=SortColumn			value="DEPTCD">
								<param name=ListExprFormat	value="DEPTNM^0^130">
								<param name=BindColumn			value="DEPTCD">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>	
     			  </td>
            <td width="10" style="border:0 solid #708090;border-right-width:1px;"bgcolor="#eeeeee">
							<nobr>&nbsp;성명&nbsp;</nobr></td>
						<td  Style="height:30px;border:0 solid #708090;border-bottom-width:0px"><nobr><input id="txt_empnmk_search_1" name="txt_empnmk_search_1" type="text" style="width:70px;"  class="txt21" maxlength=10 onkeydown="if(event.keyCode==13) ln_Query_1();"></nobr></td>
						<td width=100%>&nbsp;
							<comment id="__NSID__"><object id=inp_File_1 classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03	style="position:relative;left:9px;width:0; height:0;" align="absmiddle">
								<param name="Text"		value='찾아보기'>
		            <param name="Enable"	value="True">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
            <td style="padding-top:4px;"><nobr>      
					    <img src="../../Common/img/btn/com_b_download.gif" style="cursor:hand" onclick="ln_FileOpen_1();" >
					    <img src="../../Common/img/btn/com_b_certi_prt.gif" style="cursor:hand" onclick="ln_Certi_prt_1();" >
							<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel_1();" >
							<img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Del_1();" >
							<img src="../../Common/img/btn/com_b_insert.gif" style="cursor:hand" onclick="ln_Insert_1();" >
							<img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand" onclick="ln_Save_1();"  >
							<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query_1();"></nobr>
						</td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
			<td ALIGN=CENTER>
        <table width="847" cellpadding="1" cellspacing="0" border="0">
          <tr> 
            <td style="width:847" ALIGN=LEFT VALIGN=TOP>
              <comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_grid_ec01az  style="WIDTH: 666px; HEIGHT: 360px;border:1 solid #777777;display:block;" viewastext>
							  <PARAM NAME="DataID"          VALUE="gcds_grid_ec01az">
							  <PARAM NAME="Editable"				VALUE="false">
							  <PARAM NAME="ColSizing"				VALUE="True">
							  <PARAM NAME="BorderStyle"			VALUE="0">
       					<param name="Fillarea"    VALUE="true">
							  <PARAM NAME="Format"          VALUE="  
									<C> Name='적용년월' ID=APPYM		HeadAlign=Center HeadBgColor=#B9D4DC Width=68		align=CENTER Mask='XXXX/XX' </C>
                  <C> Name='소속'			ID=DEPTNM   HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=left		</C> 
                  <C> Name='사번'			ID=EMPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=CENTER	</C> 
                  <C> Name='성명'			ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=CENTER	</C>
                  <C> Name='보험번호' ID=MEDSNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=CENTER	</C>
									<C> Name='등급'			ID=GRDCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=35		align=CENTER	</C>
									<C> Name='본인부담' ID=INSAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=RIGHT		</C>
									<C> Name='보수월액' ID=STDAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=RIGHT		</C>
									<C> Name='취득일자' ID=GETDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=68		align=CENTER Mask='XXXX/XX/XX' </C>
									<C> Name='상실일자' ID=LOSDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=68		align=CENTER Mask='XXXX/XX/XX' </C>
									<C> Name='신고일자' ID=REPDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=68		align=CENTER Mask='XXXX/XX/XX' </C>
									<C> Name='주민번호' ID=RESINO		HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=CENTER Mask='XXXXXX-XXXXXXX' </C>
                  ">
              </OBJECT></comment><script>__ws__(__NSID__);</script>
							<fieldset id=ft_div1 style="width:668px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
								<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
							</fieldset>
            </td>
            <TD>
              <table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:176px;height:382px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
								<tr>
                  <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">
										<nobr>&nbsp;사번&nbsp;</nobr></td>
                  <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>
										<comment id="__NSID__"><object id=gcem_emo_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:8px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
											<param name=Text          value="">
											<param name=Alignment	  value=0>
											<param name=Border	      value=True>
											<param name=ClipMode	  value=true>
											<param name=Numeric	      value=false>
											<param name=Format	      value="0000000">
											<param name=MaxLength     value=13>
											<param name=PromptChar	  value="_">
											<param name=IsComma	      value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
											<param name=Readonly  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td>
									<td style="padding-top:4px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;<img src="../../Common/img/btn/com_b_find.gif"  id="img_1"  name="img_1" style="cursor:hand" onclick="ln_FindEmp('1','1')"></nobr> </td>
									<td width="0" Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<input id="txt_empnmk_1" name="txt_empnmk_1" type="hidden" style="width:70px;" maxlength=7 readonly></nobr></td>
                </tr>
                <tr>
                  <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;적용년월&nbsp;</nobr></td>
                  <td  colspan=3 width="100%" style="border:0 solid #708090;border-bottom-width:1px;"><nobr>
										<comment id="__NSID__"><object id=gcem_appdt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:8px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
											<param name=Text          value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=false>
											<param name=Format        value="YYYY/MM">
											<param name=MaxLength     value=6>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
									</td>
                </tr>                   
                <tr>
                  <td style="height:30px;border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;등급&nbsp;</nobr></td>
                  <td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;border-right-width:0px; border-bottom-width:1px">
										<comment id="__NSID__"><object id=gcem_GRDCD_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:8px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
											<param name=Text          value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=Format        value="000">
											<param name=MaxLength     value=3>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=true>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
									</td>
                </tr>
								<tr>
                  <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;보수월액&nbsp;</nobr></td>
                  <td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;">
										<comment id="__NSID__"><object id=gcem_STDAMT_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
											style="position:relative; left:8px;top:2px; width:75px; height:20px; font-family:굴림; font-size:9pt;z-index:2; ">
											<param name=Text          value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=Format        value="000,000,000">
											<param name=MaxLength     value=9>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=true>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
									</td>
                </tr>                   
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;본인부담&nbsp;</nobr></td>
									<td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;">
										<comment id="__NSID__"><object id=gcem_INSAMT_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
											style="position:relative; left:8px;top:2px; width:75px; height:20px; font-family:굴림; font-size:9pt;z-index:2; ">
											<param name=Text          value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=Format        value="000,000,000">
											<param name=MaxLength     value=9>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=true>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
									</td>
                </tr>                   
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;보험번호&nbsp;</nobr></td>
									<td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;"><nobr>
										<comment id="__NSID__"><object id=gcem_MEDSNO_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
			              	style="position:relative; left:8px;top:2px; width:115px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " >
											<param name=Text          value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=MaxLength     value=20>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td>
                </tr>                   
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;취득일자&nbsp;</nobr></td>
									<td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;">
										<comment id="__NSID__"><object id=gcem_GETDT_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:2px; width:67px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp="">
											<param name=Text          value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=false>
											<param name=Format        value="YYYY/MM/DD">
											<param name=MaxLength     value=9>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
									</td>
                </tr>                   
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;상실일자&nbsp;</nobr></td>
									<td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;">
										<comment id="__NSID__"><object id=gcem_LOSDT_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:2px; width:67px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp="">
											<param name=Text          value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=false>
											<param name=Format        value="YYYY/MM/DD">
											<param name=MaxLength     value=9>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
									</td>
                </tr>                   
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;신고일자&nbsp;</nobr></td>
									<td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;"><comment id="__NSID__"><object id=gcem_REPDT_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:2px; width:67px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp="">
											<param name=Text          value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=false>
											<param name=Format        value="YYYY/MM/DD">
											<param name=MaxLength     value=9>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
									</td>
                </tr>                   
                <tr>
                  <td colspan=3 style="height:100%;border:0 solid #708090;" >&nbsp;</td>
                </tr>
              </table>
						</TD>
					</tr>
				</table>
      </td>
    </tr>
 </table>
</div>

<!-- 국민연금 -->
<div id="div_sendal" style="display:block">
  <table width="875" cellpadding="1" cellspacing="0" border="0">
    <tr> 
		  <td colspan=8 align=center>
        <table width="860" cellpadding="1" cellspacing="0" border="0"	 style='border:1 solid #708090'>
          <tr> 
            <td width="10" style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;기준년월&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gcem_yymm_search2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				        style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
				        validFeatures="ignoreStatus=yes" validExp="">
				        <param name=Text          value="">
				        <param name=Alignment	  value=0>
		        		<param name=Border	      value=True>
	        			<param name=ClipMode	  value=true>
        				<param name=Numeric	      value=false>
        				<param name=Format	      value="YYYY/MM">
        				<param name=MaxLength     value=6>
        				<param name=PromptChar	  value="_">
        				<param name=IsComma	      value=false>
        				<param name=BackColor     value="#CCCCCC">
        				<param name=InheritColor  value=false>
        			</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td> 
            <td width="10" style="border:0 solid #708090;border-right-width:1px;"bgcolor="#eeeeee"><nobr>&nbsp;소속&nbsp;</nobr></td>
            <td  style="border:0 solid #708090;border-top-width:0px;border-right-width:1px;"><nobr>
							<comment id="__NSID__"><object id=gclx_select_ec02az   classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
								<param name=ComboDataID			value=gcds_dept2>
								<param name=SearchColumn		value="DEPTCD^DEPTNM">
								<param name=Sort            value="false">
								<param name=SortColumn			value="DEPTCD">
								<param name=ListExprFormat	value="DEPTNM^0^130">
								<param name=BindColumn			value="DEPTCD">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>	
     			  </td>
            <td width="10" style="border:0 solid #708090;border-right-width:1px;"bgcolor="#eeeeee"><nobr>&nbsp;성명&nbsp;</nobr></td>
						<td  Style="height:30px;border:0 solid #708090;border-bottom-width:0px"><nobr>
							<input id="txt_empnmk_search_2" name="txt_empnmk_search_2" type="text" style="width:70px;"  class="txt21" maxlength=10 onkeydown="if(event.keyCode==13) ln_Query_2();"></nobr></td>
						<td width=100%>&nbsp;
							<comment id="__NSID__"><object id=inp_File_2 classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03
							style="position:relative;left:9px;width:0; height:0;" align="absmiddle">
								<param name="Text"		value='찾아보기'>
								<param name="Enable"	value="True">
							</object></comment><script>__ws__(__NSID__);</script></td>
            <td style="padding-top:4px;"><nobr>      
							<img src="../../Common/img/btn/com_b_download.gif" style="cursor:hand" onclick="ln_FileOpen_2();">
							<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel_2();">
							<img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Del_2();" >
							<img src="../../Common/img/btn/com_b_insert.gif" style="cursor:hand" onclick="ln_Insert_2();">
							<img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand" onclick="ln_Save_2();"  >
							<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query_2();"></nobr>
						</td>
          </tr>
        </table>
      </td>
    </tr>
		<tr>
			<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
          <tr> 
            <td style="width:847" ALIGN=LEFT VALIGN=TOP>
              <comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_grid_ec02az  style="WIDTH: 666px; HEIGHT: 360px;border:1 solid #777777;display:block;" viewastext>
							  <PARAM NAME="DataID"          VALUE="gcds_grid_ec02az">
							  <PARAM NAME="Editable"				VALUE="false">
							  <PARAM NAME="ColSizing"				VALUE="True">
							  <PARAM NAME="BorderStyle"			VALUE="0">
       					<param name="Fillarea"				VALUE="true">
							  <PARAM NAME="Format"          VALUE="  
									<C> Name='적용년월' ID=APPYM HeadAlign=Center HeadBgColor=#B9D4DC Width=68 align=CENTER Mask='XXXX/XX' </C>
                  <C> Name='소속' ID=DEPTNM   HeadAlign=Center HeadBgColor=#B9D4DC Width=90  align=left </C> 
                  <C> Name='사번' ID=EMPNO   HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=CENTER </C> 
                  <C> Name='성명' ID=EMPNMK HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=CENTER </C>
                  <C> Name='연금번호' ID=MEDSNO HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=CENTER </C>
									<C> Name='등급' ID=GRDCD HeadAlign=Center HeadBgColor=#B9D4DC Width=35  align=CENTER </C>
									<C> Name='본인부담' ID=INSAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT  </C>
									<C> Name='소득월액' ID=STDAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=RIGHT  </C>
									<C> Name='취득일자' ID=GETDT HeadAlign=Center HeadBgColor=#B9D4DC Width=68  Mask='XXXX/XX/XX' align=CENTER  </C>
									<C> Name='상실일자' ID=LOSDT HeadAlign=Center HeadBgColor=#B9D4DC Width=68  Mask='XXXX/XX/XX' align=CENTER  </C>
									<C> Name='신고일자' ID=REPDT HeadAlign=Center HeadBgColor=#B9D4DC Width=68  Mask='XXXX/XX/XX' align=CENTER  </C>
									<C> Name='주민번호' ID=RESINO HeadAlign=Center HeadBgColor=#B9D4DC Width=110 align=CENTER Mask='XXXXXX-XXXXXXX'  </C>
                  ">
                </OBJECT></comment><script>__ws__(__NSID__);</script>
								<fieldset id=ft_div1 style="width:668px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
									<font id=ft_cnt2 style="position:relative;top:4px;"></font>&nbsp;
								</fieldset>
              </td>
              <TD>
                <table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:176px;height:382px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
									<tr>
                    <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;사번&nbsp;</nobr></td>
                    <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>
											<comment id="__NSID__"><object id=gcem_emo_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:8px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
												<param name=Text          value="">
												<param name=Alignment	  value=0>
												<param name=Border	      value=True>
												<param name=ClipMode	  value=true>
												<param name=Numeric	      value=false>
												<param name=Format	      value="0000000">
												<param name=MaxLength     value=13>
												<param name=PromptChar	  value="_">
												<param name=IsComma	      value=false>
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
												<param name=Readonly  value=false>
									    </object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
										</td>
										<td style="padding-top:4px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;<img src="../../Common/img/btn/com_b_find.gif" id="img_2"  name="img_2" style="cursor:hand" onclick="ln_FindEmp('2','1')"></nobr> </td>
										<td width="0" Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<input id="txt_empnmk_2" name="txt_empnmk_2" type="hidden" style="width:70px;" maxlength=7 readonly></nobr></td>
                  </tr>
                  <tr>
										<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;적용년월&nbsp;</nobr></td>
										<td  colspan=3 width="100%" style="border:0 solid #708090;border-bottom-width:1px;"><nobr>
											<comment id="__NSID__"><object id=gcem_appdt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp="">
												<param name=Text          value="">
												<param name=Alignment     value=0>
												<param name=Border        value=true>
												<param name=ClipMode      value=true>
												<param name=Numeric       value=false>
												<param name=Format        value="YYYY/MM">
												<param name=MaxLength     value=6>
												<param name=PromptChar    value="_">
												<param name=IsComma       value=false>
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
											</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
										</td>
                  </tr>                   
                  <tr>
                    <td style="height:30px;border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;등급&nbsp;</nobr></td>
                    <td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;border-right-width:0px; border-bottom-width:1px">
											<comment id="__NSID__"><object id=gcem_GRDCD_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp="">
												<param name=Text          value="">
												<param name=Alignment     value=2>
												<param name=Border        value=true>
												<param name=ClipMode      value=true>
												<param name=Numeric       value=true>
												<param name=Format        value="000">
												<param name=MaxLength     value=3>
												<param name=PromptChar    value="_">
												<param name=IsComma       value=true>
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
											</object></comment><script>__ws__(__NSID__);</script>
										</td>
                  </tr>
									<tr>
										<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;소득월액&nbsp;</nobr></td>
										<td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;">
											<comment id="__NSID__"><object id=gcem_STDAMT_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:2px; width:75px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp="">
												<param name=Text          value="">
												<param name=Alignment     value=2>
												<param name=Border        value=true>
												<param name=ClipMode      value=true>
												<param name=Numeric       value=true>
												<param name=Format        value="000,000,000">
												<param name=MaxLength     value=9>
												<param name=PromptChar    value="_">
												<param name=IsComma       value=true>
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
											</object></comment><script>__ws__(__NSID__);</script>
										</td>
                  </tr>                   
									<tr>
										<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;본인부담&nbsp;</nobr></td>
										<td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;">
											<comment id="__NSID__"><object id=gcem_INSAMT_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:2px; width:75px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp="">
												<param name=Text          value="">
												<param name=Alignment     value=2>
												<param name=Border        value=true>
												<param name=ClipMode      value=true>
												<param name=Numeric       value=true>
												<param name=Format        value="000,000,000">
												<param name=MaxLength     value=9>
												<param name=PromptChar    value="_">
												<param name=IsComma       value=true>
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
											</object></comment><script>__ws__(__NSID__);</script>
										</td>
                  </tr>                   
									<tr>
                    <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;연금번호&nbsp;</nobr></td>
                    <td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;"><nobr>
											<comment id="__NSID__"><object id=gcem_MEDSNO_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:2px; width:115px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp="">
												<param name=Text          value="">
												<param name=Alignment     value=2>
												<param name=Border        value=true>
												<param name=ClipMode      value=true>
												<param name=Numeric       value=true>
												<param name=MaxLength     value=20>
												<param name=PromptChar    value="_">
												<param name=IsComma       value=false>
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
											</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
										</td>
                  </tr>                   
									<tr>
										<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;취득일자&nbsp;</nobr></td>
										<td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;">
											<comment id="__NSID__"><object id=gcem_GETDT_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:2px; width:67px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp="">
												<param name=Text          value="">
												<param name=Alignment     value=0>
												<param name=Border        value=true>
												<param name=ClipMode      value=true>
												<param name=Numeric       value=false>
												<param name=Format        value="YYYY/MM/DD">
												<param name=MaxLength     value=9>
												<param name=PromptChar    value="_">
												<param name=IsComma       value=false>
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
											</object></comment><script>__ws__(__NSID__);</script>
										</td>
                  </tr>                   
									<tr>
										<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;상실일자&nbsp;</nobr></td>
										<td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;">
											<comment id="__NSID__"><object id=gcem_LOSDT_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:2px; width:67px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp="">
												<param name=Text          value="">
												<param name=Alignment     value=0>
												<param name=Border        value=true>
												<param name=ClipMode      value=true>
												<param name=Numeric       value=false>
												<param name=Format        value="YYYY/MM/DD">
												<param name=MaxLength     value=9>
												<param name=PromptChar    value="_">
												<param name=IsComma       value=false>
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
											</object></comment><script>__ws__(__NSID__);</script>
										</td>
                  </tr>                   
									<tr>
										<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;신고일자&nbsp;</nobr></td>
										<td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;">
											<comment id="__NSID__"><object id=gcem_REPDT_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:2px; width:67px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp="">
												<param name=Text          value="">
												<param name=Alignment     value=0>
												<param name=Border        value=true>
												<param name=ClipMode      value=true>
												<param name=Numeric       value=false>
												<param name=Format        value="YYYY/MM/DD">
												<param name=MaxLength     value=9>
												<param name=PromptChar    value="_">
												<param name=IsComma       value=false>
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
											</object></comment><script>__ws__(__NSID__);</script>
										</td>
									</tr>                   
									<tr>
										<td colspan=3 style="height:100%;border:0 solid #708090;">&nbsp;</td>
									</tr>
								</table>
							</TD>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>

	<!-- 건강보험 전월대비 -->
	<div id="div_holiday" style="display:block">
		<table width="875" cellpadding="1" cellspacing="0" border="0">
    <tr> 
		  <td colspan=8 align=center>
        <table width="860" cellpadding="1" cellspacing="0" border="0" style='border:1 solid #708090' >
          <tr> 
            <td width="10" style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
							<nobr>&nbsp;기준년월&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gcem_yymm_search3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
				        <param name=Text          value="">
				        <param name=Alignment	    value=0>
		        		<param name=Border	      value=True>
	        			<param name=ClipMode	    value=true>
        				<param name=Numeric	      value=false>
        				<param name=Format	      value="YYYY/MM">
        				<param name=MaxLength     value=6>
        				<param name=PromptChar	  value="_">
        				<param name=IsComma	      value=false>
        				<param name=BackColor     value="#CCCCCC">
        				<param name=InheritColor  value=false>
        			</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td> 
            <td width="10" style="border:0 solid #708090;border-right-width:1px;"bgcolor="#eeeeee">
							<nobr>&nbsp;소속&nbsp;</nobr></td>
            <td  style="border:0 solid #708090;border-top-width:0px;border-right-width:1px;"><nobr>
							<comment id="__NSID__"><object id=gclx_select_ec03az  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
								<param name=ComboDataID			value=gcds_dept3>
								<param name=SearchColumn		value="DEPTCD^DEPTNM">
								<param name=Sort            value="false">
								<param name=SortColumn			value="DEPTCD">
								<param name=ListExprFormat	value="DEPTNM^0^130">
								<param name=BindColumn			value="DEPTCD">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>	
     			  </td>
            <td width="10" style="border:0 solid #708090;border-right-width:1px;"bgcolor="#eeeeee">
							<nobr>&nbsp;성명&nbsp;</nobr></td>
						<td  Style="height:30px;border:0 solid #708090;border-bottom-width:0px"><nobr>
						  <input id="txt_empnmk_search_3"  type="text" style="width:70px;"  class="txt21" maxlength=10 onkeydown="if(event.keyCode==13) ln_Query_3();">&nbsp;<img src="../../Common/img/btn/com_b_find.gif" id="img_3"  style="cursor:hand;position:relative;left:4px;top:5;" onclick="ln_Find_3()"></nobr> </td>
						<td width=100%>&nbsp;
							<comment id="__NSID__"><object id=inp_File_3 classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03	style="position:relative;left:9px;width:0; height:0;" align="absmiddle">
								<param name="Text"		value='찾아보기'>
		            <param name="Enable"	value="True">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
            <td style="padding-top:4px;">
						 <nobr>      
					    <!-- <img src="../../Common/img/btn/com_b_download.gif" style="cursor:hand" onclick="ln_FileOpen_1();" >
					    <img src="../../Common/img/btn/com_b_certi_prt.gif" style="cursor:hand" onclick="ln_Certi_prt_1();" >
							
							<img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Del_1();" >-->
							<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel_3();" >
							<img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print_3();" >
							<img src="../../Common/img/btn/com_b_save.gif"  style="cursor:hand" onclick="ln_Save_3();"  >
							<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query_3();"> 
						 </nobr>
						</td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
			<td ALIGN=CENTER>
        <table width="847" cellpadding="1" cellspacing="0" border="0">
          <tr> 
            <td style="width:847" ALIGN=LEFT VALIGN=TOP>
              <comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_grid_ec03az  style="WIDTH: 666px; HEIGHT: 360px;border:1 solid #777777;display:block;" viewastext>
							  <PARAM NAME="DataID"          VALUE="gcds_grid_ec03az">
							  <PARAM NAME="Editable"				VALUE="false">
							  <PARAM NAME="ColSizing"				VALUE="True">
							  <PARAM NAME="BorderStyle"			VALUE="0">
       					<param name="Fillarea"    VALUE="true">
							  <PARAM NAME="Format"          VALUE="  
									<C> Name='순번'       ID=CurRow		HeadAlign=Center HeadBgColor=#B9D4DC Width=30		align=center Value={CurRow} </C>
									<C> Name='본부'		    ID=GROUPNM  HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=left  Value={IF(CurLevel=1,'소계:'SubRealCount(CurLevel=0),GROUPNM)} suppress=1</C> 
									<C> Name='성명'			  ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=left	Value={IF(CurLevel=1, SubRealCount(CurLevel=0), IF(CurLevel=9999,RealCount(CurLevel=0),EMPNMK ) )} </C> 
									<C> Name='사번'			  ID=EMPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=CENTER	</C> 
                  <C> Name='보험번호'		ID=MEDSNO   HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=center </C> 
                  <G> name='이전월'     ID=PRE      HeadAlign=Center HeadBgColor=#B9D4DC
										<C> Name='보수월액'	ID=PRE_STDAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=right	</C>
										<C> Name='보험료'   ID=PRE_INSAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=right	</C>
									</G>
									<G> name='현재월'     ID=CUR      HeadAlign=Center HeadBgColor=#B9D4DC
										<C> Name='보수월액'	ID=STDAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=right	</C>
										<C> Name='보험료'   ID=INSAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=right	</C>
									</G>
									<C> Name='증감액'     ID=ADDAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=right </C>
									<C> Name='비고'       ID=REMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left </C>
                  ">
              </OBJECT></comment><script>__ws__(__NSID__);</script>
							<fieldset id=ft_div3 style="width:668px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
								<font id=ft_cnt3 style="position:relative;top:4px;"></font>&nbsp;
							</fieldset>
            </td>
            <td>
              <table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:176px;height:382px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
								<tr>
                  <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">
										<nobr>&nbsp;사번&nbsp;</nobr></td>
                  <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>
										<comment id="__NSID__"><object id=gcem_emo_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:8px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
											<param name=Text          value="">
											<param name=Alignment	    value=0>
											<param name=Border	      value=True>
											<param name=ClipMode	    value=true>
											<param name=Numeric	      value=false>
											<param name=Format	      value="0000000">
											<param name=MaxLength     value=7>
											<param name=PromptChar	  value="_">
											<param name=IsComma	      value=false>
											<param name=ReadOnly      value="true">
											<param name=ReadOnlyBackColor   value="#CCFFCC">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td>
									<td style="padding-top:4px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;</nobr> </td>
                </tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">
										<nobr>&nbsp;성명&nbsp;</nobr></td>
									<td colspan=3 width="0" Style="height:30px;border:0 solid #708090;border-bottom-width:1px"  ><nobr>&nbsp;
									  <input id="txt_empnmk_3"  type="text" style="position:relative;left:-4px; width:70px; background-color:#CCFFCC; "  readonly></nobr>
									</td>
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;보험번호&nbsp;</nobr></td>
									<td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;"><nobr>
										<comment id="__NSID__"><object id=gcem_medsno_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
											style="position:relative; left:8px;top:2px; width:115px; height:20px; font-family:굴림; font-size:9pt;z-index:2; ">
											<param name=Text          value="">
											<param name=Alignment     value=1>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=MaxLength     value=20>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
											<param name=ReadOnly      value="true">
											<param name=ReadOnlyBackColor   value="#CCFFCC">
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td>
                </tr>                            
								<tr>
                  <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;보험료&nbsp;</nobr></td>
                  <td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;">
										<comment id="__NSID__"><object id=gcem_insamt_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
											style="position:relative; left:8px;top:2px; width:75px; height:20px; font-family:굴림; font-size:9pt;z-index:2; ">
											<param name=Text          value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=Format        value="000,000,000">
											<param name=MaxLength     value=9>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=true>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
									</td>
                </tr>
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;비고&nbsp;</nobr></td>
									<td colspan=3 style="border:0 solid #708090;border-bottom-width:1px;"><nobr>
										<textarea id="txt_remark_3" class="txtbox"  style= "width:110px; height:20px; overflow:auto;position:relative;left:8px" maxlength="60" onBlur="bytelength(this,this.value,120);"></textarea>&nbsp;</nobr>
									</td>
                </tr>                                           
								          
                <tr>
                  <td colspan=3 style="height:100%;border:0 solid #708090;" >&nbsp;</td>
                </tr>
              </table>
						</TD>
					</tr>
				</table>
      </td>
    </tr>
 </table>
	</div>
	<div id="div_special" style="display:block"></div>
			<td>
	 </tr>
</table>
	<input type="hidden" id="hid_deptnm_1" name="hid_deptnm_1">
	<input type="hidden" id="hid_deptnm_2" name="hid_deptnm_2">
	<input type="hidden" id="hid_resino_1" name="hid_resino_1">
	<input type="hidden" id="hid_resino_2" name="hid_resino_2">
<div class=page id="out_line" style="position:absolute; left:174; top:158; width:875; height:438;z-index:-1;">&nbsp;</div>

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_prtmst">
	<param name="DetailDataID"			value="gcds_grid_ec03az">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="printMargine"			value="false">
	<param name="LandScape"					value="false">
	<param name="SuppressColumns"       value="1:GROUPNM">
  <param name="PrintSetupDlgFlag" value="true">
	<param name="Format"						value="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=481 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=58 ,top=331 ,right=1958 ,bottom=479 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY중고딕', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=1961 ,top=328 ,right=1961 ,bottom=482 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=468 ,top=328 ,right=468 ,bottom=482 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=58 ,top=328 ,right=58 ,bottom=482 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=58 ,top=482 ,right=1961 ,bottom=482 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=56 ,top=328 ,right=1958 ,bottom=328 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=609 ,top=328 ,right=609 ,bottom=482 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=606 ,top=407 ,right=1482 ,bottom=407 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='비고' ,left=1707 ,top=336 ,right=1955 ,bottom=471 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='증감액' ,left=1487 ,top=336 ,right=1696 ,bottom=471 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=1701 ,top=331 ,right=1701 ,bottom=482 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=828 ,top=407 ,right=828 ,bottom=476 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='보수월액' ,left=1050 ,top=418 ,right=1259 ,bottom=471 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=1267 ,top=410 ,right=1267 ,bottom=479 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='보험료' ,left=1273 ,top=418 ,right=1474 ,bottom=471 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='보험료' ,left=833 ,top=418 ,right=1035 ,bottom=471 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='보수월액' ,left=614 ,top=418 ,right=823 ,bottom=471 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='성명' ,left=474 ,top=339 ,right=603 ,bottom=474 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='본부' ,left=66 ,top=339 ,right=249 ,bottom=474 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=251 ,top=328 ,right=251 ,bottom=482 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='증번호' ,left=251 ,top=339 ,right=463 ,bottom=474 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='(단위 : 원)' ,left=1741 ,top=278 ,right=1953 ,bottom=323 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURYYMM', left=1050, top=336, right=1471, bottom=402, face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='PREYYMM', left=614, top=336, right=1035, bottom=402, face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=1042 ,top=328 ,right=1042 ,bottom=482 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1482 ,top=328 ,right=1482 ,bottom=482 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=55 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=58 ,top=0 ,right=58 ,bottom=56 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='REMARK', left=1707, top=5, right=1955, bottom=53, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ADDAMT', left=1487, top=5, right=1696, bottom=53, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INSAMT', left=1273, top=5, right=1474, bottom=53, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='STDAMT', left=1050, top=5, right=1259, bottom=53, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PRE_INSAMT', left=833, top=5, right=1035, bottom=53, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PRE_STDAMT', left=614, top=5, right=823, bottom=53, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,\'소계\',9999,\'합계\',MEDSNO)}', left=251, top=5, right=463, bottom=45, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,SubRealCount(CurLevel=0),9999,RealCount(CurLevel=0),EMPNMK)}', left=474, top=5, right=603, bottom=53, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=251 ,top=0 ,right=1961 ,bottom=0 ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=61 ,top=0 ,right=249 ,bottom=0 ,penwidth=0 ,pencolor=#000000 ,supplevel=1 </L>
	<C>id='GROUPNM', left=66, top=5, right=249, bottom=56, align='left', supplevel=1, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<L> left=251 ,top=0 ,right=251 ,bottom=56 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=468 ,top=0 ,right=468 ,bottom=56 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=609 ,top=0 ,right=609 ,bottom=56 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=828 ,top=0 ,right=828 ,bottom=56 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1042 ,top=0 ,right=1042 ,bottom=56 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1267 ,top=0 ,right=1267 ,bottom=56 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1482 ,top=0 ,right=1482 ,bottom=56 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1701 ,top=0 ,right=1701 ,bottom=56 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1961 ,top=0 ,right=1961 ,bottom=56 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=58 ,top=0 ,right=1961 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2728 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=1577 ,top=3 ,right=1955 ,bottom=85</I>
	<T>id='#p / #t' ,left=892 ,top=53 ,right=1159 ,bottom=101 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=56 ,top=0 ,right=1958 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
	">
</object></comment><script>__ws__(__NSID__);</script> 



<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N 1
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcbn_grid_ec01az classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_grid_ec01az>
	<param name=BindInfo  value='
		<C>Col=EMPNO    Ctrl=gcem_emo_1					Param=Text</C>
		<C>Col=EMPNMK		Ctrl=txt_empnmk_1       Param=value</C>
		<C>Col=APPYM		Ctrl=gcem_appdt_1       Param=Text</C>
		<C>Col=GRDCD		Ctrl=gcem_GRDCD_1       Param=Text</C>
		<C>Col=STDAMT   Ctrl=gcem_STDAMT_1      Param=Text</C>
		<C>Col=INSAMT		Ctrl=gcem_INSAMT_1      Param=Text</C>
		<C>Col=MEDSNO		Ctrl=gcem_MEDSNO_1      Param=Text</C>
		<C>Col=GETDT		Ctrl=gcem_GETDT_1       Param=Text</C>
		<C>Col=LOSDT		Ctrl=gcem_LOSDT_1       Param=Text</C>
		<C>Col=REPDT		Ctrl=gcem_REPDT_1       Param=Text</C>
		<C>Col=DEPTNM		Ctrl=hid_deptnm_1       Param=value</C>
		<C>Col=RESINO		Ctrl=hid_resino_1       Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N 2
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcbn_grid_ec02az classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_grid_ec02az>
	<param name=BindInfo  value='
		<C>Col=EMPNO    Ctrl=gcem_emo_2					Param=Text</C>
		<C>Col=EMPNMK		Ctrl=txt_empnmk_2       Param=value</C>
		<C>Col=APPYM		Ctrl=gcem_appdt_2       Param=Text</C>
		<C>Col=GRDCD		Ctrl=gcem_GRDCD_2       Param=Text</C>
		<C>Col=STDAMT   Ctrl=gcem_STDAMT_2      Param=Text</C>
		<C>Col=INSAMT		Ctrl=gcem_INSAMT_2      Param=Text</C>
		<C>Col=MEDSNO		Ctrl=gcem_MEDSNO_2      Param=Text</C>
		<C>Col=GETDT		Ctrl=gcem_GETDT_2       Param=Text</C>
		<C>Col=LOSDT		Ctrl=gcem_LOSDT_2       Param=Text</C>
		<C>Col=REPDT		Ctrl=gcem_REPDT_2				Param=Text</C>
		<C>Col=DEPTNM		Ctrl=hid_deptnm_2       Param=value</C>
		<C>Col=RESINO		Ctrl=hid_resino_2       Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N 3
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcbn_grid_ec03az classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_grid_ec03az>
	<param name=BindInfo  value='
	 	<C>Col=EMPNO    Ctrl=gcem_emo_3					Param=Text</C>
		<C>Col=EMPNMK		Ctrl=txt_empnmk_3       Param=value</C>
		<C>Col=MEDSNO		Ctrl=gcem_medsno_3      Param=Text</C>
		<C>Col=INSAMT   Ctrl=gcem_insamt_3      Param=Text</C>
		<C>Col=REMARK		Ctrl=txt_remark_3       Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	