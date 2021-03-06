<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	근태현황
+ 프로그램 ID	: H050004.HTML
+ 기 능 정 의	: 
+ 변 경 이 력	: 정영식 (금액을 특근테이블에서 가져옴)
+ 변 경 이 력	: 정영식 (해당월현황)  - 20050921
+ 변 경 이 력	: 정영식 (월별근태현황) - 20050921
-----------------------------------------------------------------------------
+ 수 정 내 용 :	
+ 수   정  자 : 정영식
+ 수 정 일 자 : 2007.08.28
-----------------------------------------------------------------------------
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>근태현황검색</title>


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
//lfn_init();
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var ls_p = new Array('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31');
var ls_m = new Array('1','2','3','4','5','6','7','8','9','10','11','12');
var gs_level;
var gs_treecd;
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	gcem_date1.text = gs_date;
	var arg = gcem_date1.text.substring(0,6);
	ln_Before(arg);
	ln_DispChk(0);
	gcgd_disp1.DataID = "gcds_data1";

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(arg){
	gcgd_disp1.DataID = "";

	var obj = eval(arg);
	var pam = "";
	if (arg=="gcds_data1") {  //월별특근현황
		pam = gcem_date1.text.substring(0,6);
		ln_ForSel(pam);
		obj.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050004_s1?v_str1=" + gcem_date1.text + "&v_str2=";
		//prompt("월별특근현황",obj.DataID);
	}  else if (arg=="gcds_data2") {               //소속별특근현황
		txt_bigo.value = "";
		pam = gcem_date2.text.substring(0,6);
		obj.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050004_s4?v_str1=" + pam + "&v_str2=" + ln_Getbyymm(pam);
	}  else if (arg=="gcds_data3") {
		obj.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050004_s6?v_str1=" + gcem_date3.text 
																									+ "&v_str2=" + gclx_dept.bindcolval
																									+ "&v_str3=" + gs_level
																									+ "&v_str4=" + gs_treecd;
	}  else if (arg=="gcds_data4") {
		obj.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050004_s5?v_str1=" + gcem_fr.text + "&v_str2=" + gcem_to.text + "&v_str3=" + fn_trim(gclx_gbn.bindcolval);
	} else if (arg=="gcds_data5") {
		obj.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050004_s7?v_str1=" + gcem_date5.text + "&v_str2=" +	fn_trim(gclx_gbn5.bindcolval);
	} else if (arg=="gcds_data6") {
		obj.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050004_s8?v_str1=" + gcem_date6.text + "&v_str2=" +	fn_trim(gclx_gbn6.bindcolval);
	} else if (arg=="gcds_data7") {
		obj.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050004_s77?v_str1=" + gcem_date7_fr.text + "&v_str2=" +gcem_date7_to.text	
  }
	obj.Reset();
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
function ln_Print(arg){

	var obj = eval(arg);
	if (arg == "gcrp_print1") ln_PrintSet1();
	else if (arg == "gcrp_print2") ln_PrintSet2();
	else if (arg == "gcrp_print3") ln_PrintSet3();
	else if (arg == "gcrp_print4") ln_PrintSet4();
	else if (arg == "gcrp_print7") ln_PrintSet7();
	
	if(arg != "gcrp_print7") { 
		obj.Preview();
	}
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(arg1,arg2){
	var obj = eval(arg1);
	obj.RunExcel(arg2);
}

/******************************************************************************
	Description : 탭구분
******************************************************************************/
function ln_DispChk(index){
	var div_cm = new Array("div_disp1","div_disp2","div_disp3","div_disp4","div_disp5","div_disp6","div_disp7");

	for(var i=0;i<=6;i++)	{
		if(i==index) eval("document.all."+div_cm[i]+".style.display='block';");
		else eval("document.all."+div_cm[i]+".style.display='none';");
	}

	if (index == 1) gcem_date2.text = gs_date;
	else if (index == 2) gcem_date3.text = gs_date;
	else if (index == 3) {
		gcem_fr.text = gs_date.substring(0,6) + "01";
		gcem_to.text = gs_date;
	}else if (index == 4) gcem_date5.text = gs_date.substring(0,6);
	 else if (index == 5) gcem_date6.text = gs_date.substring(0,4);
	 else if (index == 6){
		gcem_date7_fr.text = gs_date;
    gcem_date7_to.text = gs_date;
		gclx_gubun7.index=0;
	}
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Before(arg) {
	gcds_holfee.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050004_s3";
	gcds_holfee.Reset();

	//소속코드
	gcds_dept.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?v_str1=";
	gcds_dept.Reset();

	// 근태구분
	gcds_feegbn.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050004_s3";
	gcds_feegbn.Reset();

	// 근태구분2
	gcds_duty.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1124&v_str2=C";
	gcds_duty.Reset();
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_ForSel(arg){
	gcds_holday.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050004_s2?v_str1=" + arg;
	gcds_holday.Reset();
}

/******************************************************************************
	Description :
******************************************************************************/
function ln_Format(){
	var ls_format = "";

	ls_format += "<F> Name='순번' ID={CURROW} HeadAlign=Center Headbgcolor='#B9D4DC' bgcolor='#efefef' Width=30, subsumtext='' </F> ";
	ls_format += "<F> Name='소속' ID=DEPTNM	HeadAlign=Center Headbgcolor='#B9D4DC' bgcolor='#efefef' Width=90, subsumtext='', suppress=1  </F> ";
	ls_format += "<F> Name='직위' ID=PAYGNM HeadAlign=Center Headbgcolor='#B9D4DC' bgcolor='#efefef' Width=70, subsumtext='계', subBgcolor='#FFDDEE ' </F> ";
	ls_format += "<F> Name='성명' ID=EMPNMK HeadAlign=Center Headbgcolor='#B9D4DC' bgcolor='#efefef' Width=70, subsumtext='', subBgcolor='#FFDDEE '  </F> ";
	ls_format += "<G> Name='평일' HeadAlign=Center HeadBgColor=#B9D4DC Align=center ";
	ls_p = new Array('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31');

	for (var s=1;s<=gcds_holday.countrow;s++){
		var c = parseInt(gcds_holday.namevalue(s,"HOLDT").substring(6,8),10)-1;
		ls_p[c] = "0";
	}

	for (var k=0;k<ls_p.length;k++){
		if (ls_p[k]!="0")ls_format += "  <C> Name='"+ls_p[k]+"'	ID='TEMP"+ls_p[k]+"'  HeadAlign=Center HeadBgColor=#B9D4DC Width=20 align=center, editstyle=combo, data='0:', subBgcolor='#FFDDEE '  </C> ";
	}

	ls_format += "	<C> Name='특'   ID='TCNT1' HeadAlign=Center HeadBgColor=#B9D4DC Width=25 align=right, subBgcolor='#FFDDEE ' </C> ";
	ls_format += "	<C> Name='계'   ID='TCNT2' HeadAlign=Center HeadBgColor=#B9D4DC Width=25 align=right, subBgcolor='#FFDDEE ' </C> ";
	ls_format += "	<C> Name='금액' ID='TAMT' HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right, subBgcolor='#FFDDEE ' </C> ";
	ls_format += "</G> ";

	ls_format += "<G> Name='휴일' HeadAlign=Center HeadBgColor=#B9D4DC Align=center ";
	for (var i=1; i<= gcds_holday.countrow; i++) {
		var ls_dat = gcds_holday.namevalue(i,"HOLDT").substring(6,8);
		ls_dat = parseInt(ls_dat,10);
		ls_format += "	<C> Name='" + ls_dat + "'  ID='TEMP" + ls_dat + "' HeadAlign=Center HeadBgColor=#B9D4DC Width=20 align=center, editstyle=combo, data='0:', subBgcolor='#FFDDEE ' </C>";
	}

	ls_format += "	<C> Name='특'		ID='HCNT1' HeadAlign=Center HeadBgColor=#B9D4DC Width=25 align=right, subBgcolor='#FFDDEE ' </C>";
	ls_format += "	<C> Name='계'		ID='HCNT2' HeadAlign=Center HeadBgColor=#B9D4DC Width=25 align=right, subBgcolor='#FFDDEE ' </C>";
	ls_format += "	<C> Name='금액' ID='HAMT'	 HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right, subBgcolor='#FFDDEE ' </C>";
	ls_format += "</G>";
	ls_format += "<G> Name='합계' HeadAlign=Center HeadBgColor=#B9D4DC Align=center ";
	ls_format += "	<C> Name='일수' ID=ODAY HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=right, subBgcolor='#FFDDEE ' </C>";
	ls_format += "	<C> Name='금액' ID=OAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right, subBgcolor='#FFDDEE ' </C>";
	ls_format += "</G>";
	ls_format += "<C> Name='비고' ID=LACSCR HeadAlign=Center HeadBgColor=#B9D4DC Width=103 align=left, subBgcolor='#FFDDEE ' </C>";

	gcgd_disp1.Format = ls_format;
}

/******************************************************************************
	Description : 해당월현황 Grid 폼
******************************************************************************/
function ln_Format5(){
	var ls_format = "";

	ls_format += "<F> Name='순번' ID={CURROW} HeadAlign=Center Headbgcolor='#B9D4DC' bgcolor='#efefef' Width=30</F> ";
	ls_format += "<F> Name='소속' ID=DEPTNM	HeadAlign=Center Headbgcolor='#B9D4DC' bgcolor='#efefef' Width=90, sort=true,  </F> ";
	ls_format += "<F> Name='직위' ID=PAYGRDNM HeadAlign=Center Headbgcolor='#B9D4DC' bgcolor='#efefef' Width=70, sort=true, subBgcolor='#FFDDEE' </F> ";
	ls_format += "<F> Name='성명' ID=EMPNMK HeadAlign=Center Headbgcolor='#B9D4DC' bgcolor='#efefef' Width=55, align=center sort=true, subBgcolor='#FFDDEE'  </F> ";
	ls_format += "<F> Name='그룹입사일' ID=GRSTRTDT HeadAlign=Center Headbgcolor='#B9D4DC' bgcolor='#efefef', align=center sort=true, Width=85,MASK='XXXX/XX/XX' subBgcolor='#FFDDEE '  </F> ";
	ls_format += "<F> Name='입사일' ID=STRTDT HeadAlign=Center Headbgcolor='#B9D4DC' bgcolor='#efefef' Width=70, align=center sort=true, MASK='XXXX/XX/XX' subBgcolor='#FFDDEE '  </F> ";
	ls_format += "<F> Name='사번' ID=EMPNO HeadAlign=Center Headbgcolor='#B9D4DC' bgcolor='#efefef' Width=70, align=center  sort=true, subBgcolor='#FFDDEE '  </F> ";

	ls_p = new Array('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31');

	for (var k=0;k<ls_p.length;k++){
		ls_format += "  <C> Name='"+ls_p[k]+"'	ID='TEMP"+ls_p[k]+"'  HeadAlign=Center HeadBgColor=#B9D4DC Width=20 align=center, editstyle=combo, data='0:', subBgcolor='#FFDDEE'  </C> ";
	}

	ls_format += "	<C> Name='계'   ID='TCNT1' HeadAlign=Center HeadBgColor=#B9D4DC Width=25 align=right,bgcolor='#FFDDEE' subBgcolor='#FFDDEE' </C> ";

	gcgd_disp5.Format = ls_format;
}

/******************************************************************************
	Description : 월별근태현황 Grid 폼
******************************************************************************/
function ln_Format6(){
	var ls_format = "";

	ls_format += "<F> Name='순번' ID={CURROW} HeadAlign=Center Headbgcolor='#B9D4DC' bgcolor='#efefef' Width=30</F> ";
	ls_format += "<F> Name='소속' ID=DEPTNM	HeadAlign=Center Headbgcolor='#B9D4DC' bgcolor='#efefef' Width=110, sort=true,  </F> ";
	ls_format += "<F> Name='직위' ID=PAYGRDNM HeadAlign=Center Headbgcolor='#B9D4DC' bgcolor='#efefef' Width=90, sort=true, subBgcolor='#FFDDEE' </F> ";
	ls_format += "<F> Name='성명' ID=EMPNMK HeadAlign=Center Headbgcolor='#B9D4DC' bgcolor='#efefef' Width=47, align=center sort=true, subBgcolor='#FFDDEE'  </F> ";
	ls_format += "<F> Name='그룹입사일' ID=GRSTRTDT HeadAlign=Center Headbgcolor='#B9D4DC' bgcolor='#efefef', align=center sort=true, Width=83,MASK='XXXX/XX/XX' subBgcolor='#FFDDEE '  </F> ";
	ls_format += "<F> Name='입사일' ID=STRTDT HeadAlign=Center Headbgcolor='#B9D4DC' bgcolor='#efefef' Width=70, align=center sort=true, MASK='XXXX/XX/XX' subBgcolor='#FFDDEE '  </F> ";
	ls_format += "<F> Name='사번' ID=EMPNO HeadAlign=Center Headbgcolor='#B9D4DC' bgcolor='#efefef' Width=60, align=center sort=true, subBgcolor='#FFDDEE '  </F> ";

	ls_m = new Array('1','2','3','4','5','6','7','8','9','10','11','12');

	for (var k=0;k<ls_m.length;k++){
		ls_format += "  <C> Name='"+ls_m[k]+"월'	ID='TEMP"+ls_m[k]+"'  HeadAlign=Center HeadBgColor=#B9D4DC Width=26 align=center, editstyle=combo, data='0:', subBgcolor='#FFDDEE'  </C> ";
	}

	ls_format += "	<C> Name='계'   ID='TCNT1' HeadAlign=Center HeadBgColor=#B9D4DC Width=31 align=right,bgcolor='#FFDDEE' subBgcolor='#FFDDEE' </C> ";

	gcgd_disp6.Format = ls_format;
}

/******************************************************************************
	Description : 전월구하기
******************************************************************************/
function ln_Getbyymm(v_yyyymm) {
	ls_yy = v_yyyymm.substring(0,4);
	ls_mon = v_yyyymm.substring(4,6);
	if (ls_mon == '01') ls_bef_yyyymm = (parseInt(ls_yy,10)-1)+'12'
	else {
		if ((parseInt(ls_mon-1,10)) < 10 ) ls_bef_yyyymm = ls_yy+'0'+ parseInt(ls_mon-1,10);
		else ls_bef_yyyymm = ls_yy+ parseInt(ls_mon-1,10);
	}
	return(ls_bef_yyyymm);
}

/******************************************************************************
	Description : 월별특근현황
******************************************************************************/
function ln_PrintSet1(){
var ls_for = "";

	/////////////////////////////////////////////////////////////////////////////////////////////
	// Header
	/////////////////////////////////////////////////////////////////////////////////////////////
  ls_for += "<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=341 ,face='Arial' ,size=10 ,penwidth=1 ";
  ls_for += "	<X>left=0 ,top=222 ,right=2834 ,bottom=341 ,border=true, penstyle=solid ,penwidth=2</X> ";
	ls_for += " <X> left=1705 ,top=275 ,right=1975 ,bottom=341, backcolor=#cccccc </X> ";
	ls_for += " <X> left=2175 ,top=275 ,right=2446 ,bottom=341, backcolor=#cccccc </X> ";
	ls_for += " <X> left=2445 ,top=222 ,right=2676 ,bottom=341, backcolor=#b1b1b1 </X> ";
	ls_for += "	<T>id='No' ,left=5 ,top=249 ,right=60 ,bottom=315 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align=right</T> ";
  ls_for += "	<L> left=70 ,top=222 ,right=70 ,bottom=341 </L> ";
  ls_for += "	<T>id='소 속' ,left=91 ,top=249 ,right=303 ,bottom=315 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
  ls_for += "	<L> left=321 ,top=222 ,right=321 ,bottom=341 </L> ";
  ls_for += "	<T>id='직 위' ,left=335 ,top=249 ,right=538 ,bottom=315 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
  ls_for += "	<L> left=546 ,top=222 ,right=546 ,bottom=341 </L> ";
  ls_for += "	<T>id='성 명' ,left=559 ,top=249 ,right=654 ,bottom=315 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align=center</T> ";
  ls_for += " <L> left=665 ,top=222 ,right=665 ,bottom=341 </L> ";
  ls_for += " <L> left=665 ,top=275 ,right=2834 ,bottom=275 </L> ";
  ls_for += " <L> left=1190 ,top=116 ,right=1645 ,bottom=116 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L> ";
  ls_for += " <T>id='월 별 특 근 현 황' ,left=0 ,top=19 ,right=2834 ,bottom=115 ,face='HY견고딕' ,size=18 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
  ls_for += " <T>id='기준년월 :' ,left=0 ,top=148 ,right=200 ,bottom=214 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align=left</T> ";
  ls_for += " <T>id='" + gs_date.substring(0,4) + "년 " + gs_date.substring(4,6) + "월 " + "' ,left=200, top=148, right=553, bottom=214, align='left', face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align=left</T> ";

	for (var s=1;s<=gcds_holday.countrow;s++){
		var c = parseInt(gcds_holday.namevalue(s,"HOLDT").substring(6,8),10)-1;
		ls_p[c] = "0";
	}

  var flileft = 665;
  var lileft = 665;
  var liright = 615;	
	for (var k=0;k<ls_p.length;k++){
		if (ls_p[k]!="0") {
		  lileft = lileft + 40;
		  liright = liright + 40;
			lic = liright + 10;
		  ls_for += "	<T> id='"+ls_p[k]+"', left='"+lic+"', top=275, right='"+lileft+"', bottom=341, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
		  ls_for += " <L> left="+lileft+" ,top=275 ,right="+lileft+" ,bottom=341 </L> ";
		}
	}

	lileft = lileft + 50;
	liright = liright + 50;
	lic = liright+8;
  ls_for += "	<T>id='특', left='"+lic+"', top=275, right='"+lileft+"', bottom=341, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#cccccc, align='left'</T> ";
  ls_for += " <L> left="+lileft+" ,top=275 ,right="+lileft+" ,bottom=341 </L> ";
	lileft = lileft + 50;
	liright = liright + 50;
	lic = liright+8;
  ls_for += "	<T> id='계', left='"+lic+"', top=275, right='"+lileft+"', bottom=341, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#cccccc, align='left'</T> ";
  ls_for += " <L> left="+lileft+" ,top=275 ,right="+lileft+" ,bottom=341 </L> ";
	lileft = lileft + 170;
	liright = liright + 170;
	lic = liright - 110;
  ls_for += "	<T>id='금액', left='"+lic+"', top=275, right='"+lileft+"', bottom=341, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#cccccc, align='center'</T> ";
  ls_for += " <L> left="+lileft+" ,top=275 ,right="+lileft+" ,bottom=341, penstyle=solid ,penwidth=2 </L> ";

  ls_for += "	<T>id='평 일', left='"+flileft+"', top=222, right='"+lileft+"', bottom=275, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align='center'</T> ";
  ls_for += " <L> left="+lileft+" ,top=222 ,right="+lileft+" ,bottom=341, penstyle=solid ,penwidth=2 </L> ";
  flileft = lileft;

	for (var i=1; i<= gcds_holday.countrow; i++) {
		var ls_dat = gcds_holday.namevalue(i,"HOLDT").substring(6,8);
		ls_dat = parseInt(ls_dat,10);
	  lileft = lileft + 40;
	  liright = liright + 40;
		lic = liright + 10;
	  ls_for += "	<T> id='"+ls_dat+"', left='"+lic+"', top=275, right='"+lileft+"', bottom=341, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T> ";
	  ls_for += " <L> left="+lileft+" ,top=275 ,right="+lileft+" ,bottom=341 </L> ";
	}

	lileft = lileft + 50;
	liright = liright + 50;
	lic = liright+8;
  ls_for += " <L> left="+lileft+" ,top=275 ,right="+lileft+" ,bottom=341 </L> ";
  ls_for += "	<T>id='특', left='"+lic+"', top=275, right='"+lileft+"', bottom=341, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#cccccc, align='left'</T> ";
	lileft = lileft + 50;
	liright = liright + 50;
	lic = liright+8;
  ls_for += " <L> left="+lileft+" ,top=275 ,right="+lileft+" ,bottom=341 </L> ";
  ls_for += "	<T>id='계', left='"+lic+"', top=275, right='"+lileft+"', bottom=341, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#cccccc, align='left'</T> ";
	lileft = lileft + 170;
	liright = liright + 170;
	lic = liright - 110;
  ls_for += " <L> left="+lileft+" ,top=275 ,right="+lileft+" ,bottom=341 </L> ";
  ls_for += "	<T>id='금액', left='"+lic+"', top=275, right='"+lileft+"', bottom=341, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#cccccc, align='center'</T> ";

  ls_for += "	<T>id='휴 일', left='"+flileft+"', top=222, right='"+lileft+"', bottom=275, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align='center'</T> ";
  ls_for += " <L> left="+lileft+" ,top=222 ,right="+lileft+" ,bottom=341 </L> ";
  flileft = lileft;

	lileft = lileft + 60;
	liright = liright + 60;
	lic = liright - 8;
  ls_for += " <L> left="+lileft+" ,top=275 ,right="+lileft+" ,bottom=341 </L> ";
  ls_for += "	<T>id='일수', left='"+lic+"', top=275, right='"+lileft+"', bottom=341, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1, align='center'</T> ";
	lileft = lileft + 170;
	liright = liright + 170;
	lic = liright - 110;
  ls_for += " <L> left="+lileft+" ,top=275 ,right="+lileft+" ,bottom=341 </L> ";
  ls_for += "	<T>id='금액', left='"+lic+"', top=275, right='"+lileft+"', bottom=341, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1, align='center'</T> ";
  ls_for += "	<T>id='합 계', left='"+flileft+"', top=222, right='"+lileft+"', bottom=275, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1, align='center'</T> ";
  ls_for += " <L> left="+lileft+" ,top=222 ,right="+lileft+" ,bottom=341 </L> ";
  ls_for += "	<T>id='비 고', left='"+lileft+"', top=222, right='2834', bottom=275, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align='center'</T> ";
  ls_for += "</B> ";

	/////////////////////////////////////////////////////////////////////////////////////////////
	//	Detail
	/////////////////////////////////////////////////////////////////////////////////////////////
  ls_for += "<B>id=Default ,left=0,top=0 ,right=2871 ,bottom=55 ,face='Arial' ,size=10 ,penwidth=1 ";
	ls_for += " <X> left=1705 ,top=0 ,right=1975 ,bottom=56, backcolor=#cccccc </X> ";
	ls_for += " <X> left=2175 ,top=0 ,right=2446 ,bottom=56, backcolor=#cccccc </X> ";
	ls_for += " <X> left=2445 ,top=0 ,right=2676 ,bottom=56, backcolor=#b1b1b1 </X> ";

	ls_for += "	<L> left=70 ,top=0 ,right=70 ,bottom=55 </L> ";
  ls_for += "	<L> left=321 ,top=0 ,right=321 ,bottom=55 </L> ";
  ls_for += "	<L> left=546 ,top=0 ,right=546 ,bottom=55 </L> ";
  ls_for += "	<L> left=665 ,top=0 ,right=665 ,bottom=55 </L> ";
  ls_for += "	<C>id={if(empnmk='','계',empnmk)}, left=554, top=3, right=657, bottom=55, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += "	<C>id='paygnm', left=329, top=3, right=538, bottom=55, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += "	<C>id='deptnm', left=75, top=3, right=316, bottom=55, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, supplevel=1</C> ";
  ls_for += "	<C>id='{currow}', left=5, top=3, right=60, bottom=55, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, align=right</C> ";

  var lileft = 665;
  var liright = 615;
	for (var k=0;k<ls_p.length;k++){
		if (ls_p[k]!="0") {
		  lileft = lileft + 40;
		  liright = liright + 40;
			lic = liright + 10;
		  ls_for += " <L> left="+lileft+" ,top=0 ,right="+lileft+" ,bottom=55 </L> ";
		  ls_for += "	<C>id={if (temp"+ls_p[k]+"=0,'',temp"+ls_p[k]+")}, left='"+lic+"', top=3, right='"+lileft+"', bottom=55, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
		}
	}

	lileft = lileft + 50;
	liright = liright + 50;
	lic = liright - 5;
  ls_for += " <L> left="+lileft+" ,top=0 ,right="+lileft+" ,bottom=55 </L> ";
  ls_for += "	<C>id='tcnt1', left='"+lic+"', top=3, right='"+lileft+"', bottom=55, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#cccccc, align=right</C> ";
	lileft = lileft + 50;
	liright = liright + 50;
	lic = liright - 5;
  ls_for += " <L> left="+lileft+" ,top=0 ,right="+lileft+" ,bottom=55 </L> ";
  ls_for += "	<C>id='tcnt2', left='"+lic+"', top=3, right='"+lileft+"', bottom=55, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#cccccc, align=right</C> ";
	lileft = lileft + 170;
	liright = liright + 170;
	lic = liright - 80;
  ls_for += " <L> left="+lileft+" ,top=0 ,right="+lileft+" ,bottom=55, penstyle=solid ,penwidth=2 </L> ";
  ls_for += "	<C>id='tamt', left='"+lic+"', top=3, right='"+lileft+"', bottom=55, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#cccccc, align=right</C> ";

	for (var i=1; i<= gcds_holday.countrow; i++) {
		var ls_dat = gcds_holday.namevalue(i,"HOLDT").substring(6,8);
		ls_dat = parseInt(ls_dat,10);
		  lileft = lileft + 40;
		  liright = liright + 40;
			lic = liright + 10;
		  ls_for += " <L> left="+lileft+" ,top=0 ,right="+lileft+" ,bottom=55 </L> ";
		  ls_for += "	<C>id={if (temp"+ls_dat+"=0,'',temp"+ls_dat+")}, left='"+lic+"', top=3, right='"+lileft+"', bottom=55, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
	}

	lileft = lileft + 50;
	liright = liright + 50;
	lic = liright - 5;
  ls_for += " <L> left="+lileft+" ,top=0 ,right="+lileft+" ,bottom=55 </L> ";
  ls_for += "	<C>id='hcnt1', left='"+lic+"', top=3, right='"+lileft+"', bottom=55, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#cccccc, align=right</C> ";
	lileft = lileft + 50;
	liright = liright + 50;
	lic = liright - 5;
  ls_for += " <L> left="+lileft+" ,top=0 ,right="+lileft+" ,bottom=55 </L> ";
  ls_for += "	<C>id='hcnt2', left='"+lic+"', top=3, right='"+lileft+"', bottom=55, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#cccccc, align=right</C> ";
	lileft = lileft + 170;
	liright = liright + 170;
	lic = liright - 110;
  ls_for += " <L> left="+lileft+" ,top=0 ,right="+lileft+" ,bottom=55 </L> ";
  ls_for += "	<C>id='hamt', left='"+lic+"', top=3, right='"+lileft+"', bottom=55, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#cccccc, align=right</C> ";

	lileft = lileft + 60;
	liright = liright + 60;
	lic = liright - 8;
  ls_for += " <L> left="+lileft+" ,top=0 ,right="+lileft+" ,bottom=55 </L> ";
  ls_for += "	<C>id='oday', left='"+lic+"', top=3, right='"+lileft+"', bottom=55, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#b1b1b1, align=right</C> ";
	lileft = lileft + 170;
	liright = liright + 170;
	lic = liright - 110;
  ls_for += " <L> left="+lileft+" ,top=0 ,right="+lileft+" ,bottom=55 </L> ";
  ls_for += "	<C>id='oamt', left='"+lic+"', top=3, right='"+lileft+"', bottom=55, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#b1b1b1, align=right</C> ";

  ls_for += " <L> left=0 ,top=0 ,right=0 ,bottom=55, penstyle=solid ,penwidth=2 </L> ";
  ls_for += " <L> left=2834 ,top=0 ,right=2834 ,bottom=55, penstyle=solid ,penwidth=2 </L> ";
  ls_for += " <L> left=321 ,top=55 ,right=2834 ,bottom=55 </L> ";
  ls_for += " <L> left=0 ,top=55 ,right=71 ,bottom=55 </L> ";
	ls_for += " <L> left=0 ,top=0 ,right=2834 ,bottom=0, penstyle=solid ,penwidth=2, supplevel=1 </L> ";

	ls_for += "</B> ";

	/////////////////////////////////////////////////////////////////////////////////////////////
	//	Summary
	/////////////////////////////////////////////////////////////////////////////////////////////
	ls_for += "<B>id=LDfooter ,left=0,top=0 ,right=2871 ,bottom=55 ,face='Arial' ,size=10 ,penwidth=1 ";

  var lileft = 665;
  var liright = 615;

	ls_for += " <X> left=0 ,top=0 ,right=666 ,bottom=55, backcolor=#b1b1b1</X> ";
	ls_for += " <X> left=1705 ,top=0 ,right=1975 ,bottom=55, backcolor=#b1b1b1 </X> ";
	ls_for += " <X> left=2175 ,top=0 ,right=2676 ,bottom=55, backcolor=#b1b1b1 </X> ";

	ls_for += " <L> left="+lileft+" ,top=0 ,right="+lileft+" ,bottom=55 </L> ";
  ls_for += "	<T>	id='합   계 (', left='0', top=0, right='300', bottom=55, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1, align='right'</T> ";
  ls_for += "	<S>	id=count(temp1), left='300', top=0, right='390', bottom=55, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1, align='right'</S> ";
  ls_for += "	<T>	id='명 )', left='400', top=0, right='500', bottom=55, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#b1b1b1, align='left'</T> ";

	for (var k=0;k<ls_p.length;k++){
		if (ls_p[k]!="0") {
		  lileft = lileft + 40;
		  liright = liright + 40;
			lic = liright + 10;
		}
	}

	ls_for += " <L> left=1705 ,top=0 ,right=1705 ,bottom=55 </L> ";

	lileft = lileft + 50;
	liright = liright + 50;
	lic = liright - 5;
  ls_for += " <L> left="+lileft+" ,top=0 ,right="+lileft+" ,bottom=55 </L> ";
  ls_for += "	<s>id=Sum(tcnt1), left='"+lic+"', top=3, right='"+lileft+"', bottom=55, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#b1b1b1, align=right</S> ";
	lileft = lileft + 50;
	liright = liright + 50;
	lic = liright - 5;
  ls_for += " <L> left="+lileft+" ,top=0 ,right="+lileft+" ,bottom=55 </L> ";
  ls_for += "	<S>id=Sum(tcnt2), left='"+lic+"', top=3, right='"+lileft+"', bottom=55, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#b1b1b1, align=right</S> ";
	lileft = lileft + 170;
	liright = liright + 170;
	lic = liright - 110;
  ls_for += " <L> left="+lileft+" ,top=0 ,right="+lileft+" ,bottom=55, penstyle=solid ,penwidth=2 </L> ";
  ls_for += "	<S>id=Sum(tamt), left='"+lic+"', top=3, right='"+lileft+"', bottom=55, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#b1b1b1, align=right</S> ";

	for (var i=1; i<= gcds_holday.countrow; i++) {
		var ls_dat = gcds_holday.namevalue(i,"HOLDT").substring(6,8);
		ls_dat = parseInt(ls_dat,10);
	  lileft = lileft + 40;
	  liright = liright + 40;
		lic = liright + 10;
	}

	ls_for += " <L> left=2175 ,top=0 ,right=2175 ,bottom=55 </L> ";

	lileft = lileft + 50;
	liright = liright + 50;
	lic = liright - 5;
  ls_for += " <L> left="+lileft+" ,top=0 ,right="+lileft+" ,bottom=55 </L> ";
  ls_for += "	<S>id=Sum(hcnt1), left='"+lic+"', top=3, right='"+lileft+"', bottom=55, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#b1b1b1, align=right</S> ";
	lileft = lileft + 50;
	liright = liright + 50;
	lic = liright - 5;
  ls_for += " <L> left="+lileft+" ,top=0 ,right="+lileft+" ,bottom=55 </L> ";
  ls_for += "	<S>id=Sum(hcnt2), left='"+lic+"', top=3, right='"+lileft+"', bottom=55, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#b1b1b1, align=right</S> ";
	lileft = lileft + 170;
	liright = liright + 170;
	lic = liright - 110;
  ls_for += " <L> left="+lileft+" ,top=0 ,right="+lileft+" ,bottom=55 </L> ";
  ls_for += "	<S>id=Sum(hamt), left='"+lic+"', top=3, right='"+lileft+"', bottom=55, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#b1b1b1, align=right</S> ";

	lileft = lileft + 60;
	liright = liright + 60;
	lic = liright - 8;
  ls_for += " <L> left="+lileft+" ,top=0 ,right="+lileft+" ,bottom=55 </L> ";
  ls_for += "	<S>id=Sum(oday), left='"+lic+"', top=3, right='"+lileft+"', bottom=55, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#b1b1b1, align=right</S> ";
	lileft = lileft + 170;
	liright = liright + 170;
	lic = liright - 110;
  ls_for += " <L> left="+lileft+" ,top=0 ,right="+lileft+" ,bottom=55 </L> ";
  ls_for += "	<S>id=Sum(oamt), left='"+lic+"', top=3, right='"+lileft+"', bottom=55, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#b1b1b1, align=right</S> ";

	ls_for += " <L> left=0 ,top=0 ,right=0 ,bottom=55, penstyle=solid ,penwidth=2 </L> ";
  ls_for += " <L> left=2834 ,top=0 ,right=2834 ,bottom=55, penstyle=solid ,penwidth=2 </L> ";
  ls_for += " <L> left=321 ,top=55 ,right=2834 ,bottom=55, penstyle=solid ,penwidth=2 </L> ";
  ls_for += " <L> left=0 ,top=55 ,right=71 ,bottom=55, penstyle=solid ,penwidth=2 </L> ";
	ls_for += " <L> left=0 ,top=0 ,right=2834 ,bottom=0, penstyle=solid ,penwidth=2 </L> ";
	ls_for += "	<L> left=0 ,top=55 ,right=2834 ,bottom=55, penstyle=solid ,penwidth=2 </L> ";
	ls_for += "</B>";


	ls_for += "<B>id=Dfooter ,left=0,top=0 ,right=2871 ,bottom=1 ,face='Arial' ,size=10 ,penwidth=1 ";
	ls_for += " <L> left=0 ,top=0 ,right=2834 ,bottom=0, penstyle=solid ,penwidth=2</L> ";
	ls_for += "</B> ";

	ls_for += "<B>id=Footer ,left=0,top=1950 ,right=2871 ,bottom=2100 ,face='굴림' ,size=10 ,penwidth=1 ";
	ls_for += "	<I>id='../../Common/img/icon.jpg' ,left=2450 ,top=0 ,right=2830 ,bottom=100</I>";
	ls_for += "	<L> left=0 ,top=0 ,right=2834 ,bottom=0, penstyle=solid ,penwidth=2 </L> ";
	ls_for += "	<T> id='#p/#t' left=0 ,top=0 ,right=2834 ,bottom=100</T> ";
	ls_for += "</B>";

  //prompt('',ls_for);
	gcrp_print1.Format = ls_for;
}

/******************************************************************************
	Description : 소속별 특근현황
******************************************************************************/
function ln_PrintSet2(){
var ls_for = "";

	/////////////////////////////////////////////////////////////////////////////////////////////
	// Header
	/////////////////////////////////////////////////////////////////////////////////////////////
  ls_for += "<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=455 ,face='Arial' ,size=10 ,penwidth=1 ";
  ls_for += "	<X>left=0 ,top=222 ,right=2834 ,bottom=401 ,border=true, penstyle=solid ,penwidth=2</X> ";
  ls_for += "	<X>left=0 ,top=401 ,right=2834 ,bottom=455 ,border=false, penstyle=solid ,penwidth=1, backcolor=#bbbbbb</X> ";
  ls_for += " <T>id='소 속 별 특 근 현 황' ,left=0 ,top=19 ,right=2834 ,bottom=115 ,face='HY견고딕' ,size=18 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_for += " <L>left=1155 ,top=116 ,right=1680 ,bottom=116 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L> ";
	ls_for += " <T>id='기준년월 :' ,left=0 ,top=148 ,right=200 ,bottom=214 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align=left</T> ";
  ls_for += " <T>id='" + gs_date.substring(0,4) + "년 " + gs_date.substring(4,6) + "월 " + "' ,left=200, top=148, right=553, bottom=214, align='left', face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align=left</T> ";
  ls_for += "	<T>id='소 속' ,left=0 ,top=222 ,right=400 ,bottom=400 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
  ls_for += "	<L> left=400 ,top=222 ,right=400 ,bottom=400 </L> ";
  ls_for += "	<T>id='인 원 (명)' ,left=400 ,top=222 ,right=700 ,bottom=400 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
  ls_for += "	<L> left=700 ,top=222 ,right=700 ,bottom=400 </L> ";
	ls_for += " <L> left=700 ,top=275 ,right=2200 ,bottom=275 </L> ";
  ls_for += "	<L> left=2200 ,top=222 ,right=2200 ,bottom=400 </L> ";
  ls_for += "	<T>id='특 근 현 황', left=700, top=222, right=2400, bottom=275, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align='center'</T> ";
  ls_for += "	<T>id='비 고' ,left=2200 ,top=222 ,right=2834 ,bottom=400 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
	ls_for += "	<T>id='단위 : 원/명' ,left=2500 ,top=172 ,right=2834 ,bottom=222 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align=right</T> ";

	ls_for += "	<T>id='평일', left=700, top=275, right=1000, bottom=400, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#ffffff</T> ";
	ls_for += "	<T>id='휴일', left=1000, top=275, right=1300, bottom=400, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#ffffff</T> ";
	ls_for += "	<T>id='계', left=1300, top=275, right=1600, bottom=400, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#ffffff</T> ";
	ls_for += "	<T>id='전체금액대비', left=1600, top=315, right=1900, bottom=400, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#ffffff</T> ";
	ls_for += "	<T>id='인당특근비', left=1900, top=275, right=2200, bottom=400, face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#ffffff</T> ";

	ls_for += " <L> left=0 ,top=404 ,right=2834 ,bottom=404, penstyle=solid ,penwidth=2 </L> ";
	ls_for += " <L> left=1000 ,top=275 ,right=1000 ,bottom=400 </L> ";
	ls_for += " <L> left=1300 ,top=275 ,right=1300 ,bottom=400 </L> ";
	ls_for += " <L> left=1600 ,top=315 ,right=1600 ,bottom=400 </L> ";
	ls_for += " <L> left=1600 ,top=315 ,right=1900 ,bottom=315 </L> ";
	ls_for += " <L> left=1900 ,top=275 ,right=1900 ,bottom=400,penstyle=solid ,penwidth=2 </L> ";
	ls_for += " <L> left=1900 ,top=275 ,right=2200 ,bottom=275,penstyle=solid ,penwidth=2 </L> ";
	ls_for += " <L> left=2200 ,top=275 ,right=2200 ,bottom=400,penstyle=solid ,penwidth=2 </L> ";

	ls_for += " <L> left=0 ,top=400 ,right=0 ,bottom=455, penstyle=solid ,penwidth=2</L> ";
	ls_for += " <L> left=2833 ,top=400 ,right=2833 ,bottom=456, penstyle=solid ,penwidth=2 </L> ";
	ls_for += " <L> left=0 ,top=455 ,right=2834 ,bottom=455 </L> ";
	ls_for += " <L> left=400 ,top=400 ,right=400 ,bottom=455</L> ";
	ls_for += " <L> left=700 ,top=400 ,right=700 ,bottom=455</L> ";
	ls_for += " <L> left=1000 ,top=400 ,right=1000 ,bottom=455</L> ";
	ls_for += " <L> left=1300 ,top=400 ,right=1300 ,bottom=455</L> ";
	ls_for += " <L> left=1600 ,top=400 ,right=1600 ,bottom=455</L> ";
	ls_for += " <L> left=1900 ,top=400 ,right=1900 ,bottom=455, penstyle=solid ,penwidth=2</L> ";
	ls_for += " <L> left=2200 ,top=400 ,right=2200 ,bottom=455, penstyle=solid ,penwidth=2</L> ";

	ls_for += "	<T>id='총계/평균', left=5, top=400, right=400, bottom=455, align='center', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#bbbbbb</T> ";
  ls_for += "	<C>id='{sum(acnt)}',		left=400, top=400, right=690, bottom=455, align='center', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#bbbbbb</C> ";
  ls_for += "	<C>id='{sum(lcnt)}',		left=700, top=400, right=990, bottom=455, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#bbbbbb</C> ";
  ls_for += "	<C>id='{sum(hcnt)}',		left=1000, top=400, right=1290, bottom=455, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#bbbbbb</C> ";
  ls_for += "	<C>id='{sum(tcnt)}',		left=1300, top=400, right=1590, bottom=455, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#bbbbbb</C> ";
  ls_for += "	<T>id='100 %',		left=1600, top=400, right=1888, bottom=455, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#bbbbbb, dec=2</T> ";
  ls_for += "	<C>id='{sum(tcnt)/sum(acnt)}',		left=2000, top=400, right=2190, bottom=455, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#bbbbbb</C> ";


	var val1 = gcds_data2.NameSum("TCNT",0,gcds_data2.countrow);
	var val2 = gcds_data2.NameSum("BCNT",0,gcds_data2.countrow);
	var ls_tit = ln_Getbyymm(gcem_date2.text.substring(0,6)).substring(4,6) + "월 특근비 ￦" + val2;

	if (parseInt(val2)>0) ls_tit += " , 증감 " + Math.round(Math.floor((parseInt(val1) - parseInt(val2)))/parseInt(val2)*100) + " %";
  //Math.round((parseInt(val1) - parseInt(val2))/parseInt(val2))*100 + "%"
  ls_for += "	<T>id='" + ls_tit + "',		left=2205, top=400, right=2833, bottom=455, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#bbbbbb</T> ";

	ls_for += "</B> ";

	/////////////////////////////////////////////////////////////////////////////////////////////
	// Detail
	/////////////////////////////////////////////////////////////////////////////////////////////
  ls_for += "<B>id=Default ,left=0,top=0 ,right=2871 ,bottom=55 ,face='Arial' ,size=10 ,penwidth=1 ";
  ls_for += "	<X>left=1900 ,top=0 ,right=2201 ,bottom=56 ,border=false, penstyle=solid ,penwidth=0, backcolor=#bbbbbb</X> ";
	ls_for += " <L> left=0 ,top=55 ,right=2833 ,bottom=55</L> ";
	ls_for += " <L> left=0 ,top=0 ,right=0 ,bottom=55, penstyle=solid ,penwidth=2</L> ";
	ls_for += " <L> left=2833 ,top=0 ,right=2833 ,bottom=55, penstyle=solid ,penwidth=2 </L> ";
	ls_for += " <L> left=400 ,top=0 ,right=400 ,bottom=55</L> ";
	ls_for += " <L> left=700 ,top=0 ,right=700 ,bottom=55</L> ";
	ls_for += " <L> left=1000 ,top=0 ,right=1000 ,bottom=55</L> ";
	ls_for += " <L> left=1300 ,top=0 ,right=1300 ,bottom=55</L> ";
	ls_for += " <L> left=1600 ,top=0 ,right=1600 ,bottom=55</L> ";
	ls_for += " <L> left=1900 ,top=0 ,right=1900 ,bottom=55, penstyle=solid ,penwidth=2</L> ";
	ls_for += " <L> left=2200 ,top=0 ,right=2200 ,bottom=55, penstyle=solid ,penwidth=2</L> ";

	ls_for += "	<C>id='deptnm', left=5, top=3, right=400, bottom=55, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += "	<C>id='acnt',		left=400, top=3, right=690, bottom=55, align='center', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += "	<C>id='lcnt',		left=700, top=3, right=990, bottom=55, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += "	<C>id='hcnt',		left=1000, top=3, right=1290, bottom=55, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += "	<C>id='tcnt',		left=1300, top=3, right=1590, bottom=55, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += "	<C>id='{tcnt/sum(tcnt)*100}',		left=1600, top=3, right=1850, bottom=55, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, dec=2</C> ";
  ls_for += "	<T>id='%'		,		left=1855, top=3, right=1890, bottom=55, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T> ";
  ls_for += "	<C>id='{tcnt/acnt}',		left=1900, top=3, right=2190, bottom=55, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#bbbbbb</C> ";
	ls_for += "</B> ";

	ls_for += "<B>id=Dfooter ,left=0,top=0 ,right=2871 ,bottom=1 ,face='Arial' ,size=10 ,penwidth=1 ";
	ls_for += " <L> left=0 ,top=0 ,right=2834 ,bottom=0, penstyle=solid ,penwidth=2</L> ";
	ls_for += "</B> ";
	ls_for += "<B>id=Footer ,left=0,top=1950 ,right=2871 ,bottom=2100 ,face='굴림' ,size=10 ,penwidth=1 ";
	ls_for += "	<I>id='../../Common/img/icon.jpg' ,left=2450 ,top=0 ,right=2830 ,bottom=100</I>";
	ls_for += "	<L> left=0 ,top=0 ,right=2834 ,bottom=0, penstyle=solid ,penwidth=2 </L> ";
	ls_for += "	<T> id='#p/#t' left=0 ,top=0 ,right=2834 ,bottom=100</T> ";
	ls_for += "</B>";

	gcrp_print2.Format = ls_for;
}

/******************************************************************************
	Description : 소속별 특근비
******************************************************************************/
function ln_PrintSet3(){
var ls_for = "";

	/////////////////////////////////////////////////////////////////////////////////////////////
	// Header
	/////////////////////////////////////////////////////////////////////////////////////////////
  ls_for += "<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=359 ,face='Arial' ,size=10 ,penwidth=1 ";
  ls_for += "	<X>left=0		  ,top=241 ,right=352  ,bottom=360 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X> ";
  ls_for += "	<X>left=350		,top=241 ,right=632  ,bottom=360 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X> ";
  ls_for += "	<X>left=630		,top=241 ,right=1109 ,bottom=360 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X> ";
  ls_for += "	<X>left=1106	,top=241 ,right=1378 ,bottom=360 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X> ";
  ls_for += "	<X>left=1376	,top=241 ,right=1693 ,bottom=360 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X> ";
  ls_for += "	<X>left=1691	,top=241 ,right=1974 ,bottom=360 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X> ";
  ls_for += "	<L> left=632	,top=135 ,right=1335 ,bottom=135 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L> ";
  ls_for += "	<L> left=0		,top=241 ,right=0		 ,bottom=359 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L> ";
  ls_for += "	<L> left=0		,top=241 ,right=1974 ,bottom=241 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L> ";
  ls_for += "	<L> left=630	,top=302 ,right=1106 ,bottom=302 </L> ";
  ls_for += "	<L> left=868	,top=302 ,right=868  ,bottom=359 </L> ";
  ls_for += "	<L> left=1973 ,top=241 ,right=1973 ,bottom=359 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L> ";
  ls_for += "	<L> left=0		,top=359 ,right=1973 ,bottom=359 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L> ";
	var ls_date = gcem_date3.text.substring(0,4) + ". " + gcem_date3.text.substring(4,6) + " (소속별 특근비)";
  ls_for += "	<T>id='" + ls_date + "' ,left=0 ,top=40 ,right=1974 ,bottom=132 ,face='HY견고딕' ,size=18 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";
  ls_for += "	<T>id='직  위'		,left=0		 ,top=246 ,right=357  ,bottom=355 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
  ls_for += "	<T>id='성  명'		,left=365  ,top=246 ,right=627  ,bottom=355 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
  ls_for += "	<T>id='평  일'		,left=638  ,top=310 ,right=865  ,bottom=355 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
  ls_for += "	<T>id='근무일수'	,left=635  ,top=251 ,right=1101 ,bottom=296 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
  ls_for += "	<T>id='휴  일'		,left=873  ,top=310 ,right=1101 ,bottom=355 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
  ls_for += "	<T>id='금  액'		,left=1111 ,top=246 ,right=1373 ,bottom=355 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
  ls_for += "	<T>id='서  명'		,left=1381 ,top=246 ,right=1688 ,bottom=355 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
  ls_for += "	<T>id='비  고'		,left=1696 ,top=246 ,right=1969 ,bottom=355 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
  ls_for += "</B> ";

	/////////////////////////////////////////////////////////////////////////////////////////////
	// Detail
	/////////////////////////////////////////////////////////////////////////////////////////////
  ls_for += "<B>id=Default ,left=0,top=0 ,right=2000 ,bottom=61 ,face='Arial' ,size=10 ,penwidth=1 ";
  ls_for += "	<L> left=0		,top=0 ,right=0			,bottom=61 ,penstyle=solid ,penwidth=2 ,pencolor=#000000</L> ";
  ls_for += "	<L> left=0		,top=61,right=360 	,bottom=61 </L> ";
  ls_for += "	<L> left=360	,top=61,right=1973	,bottom=61 </L> ";
  ls_for += "	<L> left=0		,top=0 ,right=400		,bottom=0 </L> ";
  ls_for += "	<L> left=350  ,top=0 ,right=350		,bottom=61 </L> ";
  ls_for += "	<L> left=630  ,top=0 ,right=630		,bottom=61 </L> ";
  ls_for += "	<L> left=868  ,top=0 ,right=868		,bottom=61 </L> ";
  ls_for += "	<L> left=1106 ,top=0 ,right=1106  ,bottom=61 </L> ";
  ls_for += "	<L> left=1376 ,top=0 ,right=1376  ,bottom=61 </L> ";
  ls_for += "	<L> left=1691 ,top=0 ,right=1691  ,bottom=61 </L> ";
  ls_for += "	<L> left=1973 ,top=0 ,right=1973  ,bottom=61 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L> ";
  ls_for += "	<T>id='소 속 명 : '	,left=10		 ,top=-180 ,right=257  ,bottom=-120 ,align=left, face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, supplevel=1</T> ";
  ls_for += "	<C>id='DEPTNM'			,left=207		 ,top=-180 ,right=757  ,bottom=-120 ,align=left, face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, supplevel=1</C> ";
	ls_for += "	<C>id='PAYGNM'	, left=0	, top=3, right=357, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += "	<C>id={IF(EMPNMK='','합계',EMPNMK)}	, left=365	, top=3, right=630, bottom=58, face='true', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += "	<C>id='LCNT'		, left=638	, top=3, right=865, bottom=58, face='true', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += "	<C>id='HCNT'		, left=873	, top=3, right=1101, bottom=58, face='true', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += "	<C>id={IF (TCNT>200000,(TCNT-(TCNT-200000)),TCNT)}		, left=1111	, top=3, right=1373, bottom=58, align='right', face='true', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += "	<C>id={IF (TCNT>200000,(200000-TCNT),0)}		, left=1696	, top=3, right=1969, bottom=58, align='right', face='true', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += "</B> ";
  ls_for += "<B>id=Dfooter ,left=0,top=0 ,right=2000 ,bottom=55 ,face='굴림' ,size=9 ,penwidth=1  ";
  ls_for += "	<L> left=0		,top=0	,right=1974 ,bottom=0, penstyle=solid, penwidth=2 </L> ";
  ls_for += "	<L> left=0		,top=54	,right=1974 ,bottom=54, penstyle=solid, penwidth=2 </L> ";
  ls_for += "	<L> left=0		,top=0	,right=0		,bottom=54, penstyle=solid, penwidth=2 </L> ";
  ls_for += "	<L> left=1973 ,top=0	,right=1974 ,bottom=54, penstyle=solid, penwidth=2 </L> ";
  ls_for += "	<T> id='전체 소속 합계' left=800	, top=3, right=1111, bottom=52, align=right, face='굴림', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T> ";
  ls_for += "	<S>id='Sum(TCNT)'	, left=1111	, top=3, right=1373, bottom=52, align='right', face='굴림', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</S> ";
  ls_for += "</B>  ";
  ls_for += "<B>id=Footer ,left=0,top=2550 ,right=2000 ,bottom=2600 ,face='Arial' ,size=10 ,penwidth=1 ";
  ls_for += "	<I>id='../../Common/img/icon.jpg' ,left=1594 ,top=230 ,right=1974 ,bottom=330</I> ";
  ls_for += "	<L> left=0 ,top=220	,right=1974 ,bottom=220, penstyle=solid, penwidth=2 </L> ";
  ls_for += "	<T> id='#p/#t' left=0 ,top=230 ,right=1974 ,bottom=310</T> ";
  ls_for += "</B> ";

	gcrp_print3.Format = ls_for;

}

/******************************************************************************
	Description : 근태현황
******************************************************************************/
function ln_PrintSet4(){
var ls_for = "";

	/////////////////////////////////////////////////////////////////////////////////////////////
	// Header
	/////////////////////////////////////////////////////////////////////////////////////////////
  ls_for += " <B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=288 ,face='굴림' ,size=10 ,penwidth=1 ";
  ls_for += " 	<X>left=0 ,top=222 ,right=2834 ,bottom=288 ,backcolor=#bbbbbb ,border=true ,penstyle=solid ,penwidth=2</X> ";
  ls_for += " 	<L> left=124  ,top=222 ,right=124  ,bottom=288 </L> ";
  ls_for += " 	<L> left=320  ,top=222 ,right=320  ,bottom=288 </L> ";
  ls_for += " 	<L> left=889  ,top=222 ,right=889  ,bottom=288 </L> ";
  ls_for += " 	<L> left=1087 ,top=222 ,right=1087 ,bottom=288 </L> ";
  ls_for += " 	<L> left=1257 ,top=116 ,right=1580 ,bottom=116 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L> ";
  ls_for += " 	<L> left=1286 ,top=222 ,right=1286 ,bottom=288 </L> ";
  ls_for += " 	<L> left=1484 ,top=222 ,right=1484 ,bottom=288 </L> ";
  ls_for += " 	<L> left=1683 ,top=222 ,right=1683 ,bottom=288 </L> ";
  ls_for += " 	<L> left=2244 ,top=222 ,right=2244 ,bottom=288 </L> ";
  ls_for += " 	<L> left=2437 ,top=222 ,right=2437 ,bottom=288 </L> ";
  ls_for += " 	<L> left=2635 ,top=222 ,right=2635 ,bottom=288 </L> ";
  ls_for += " 	<T>id='근 태 현 황' ,left=0		 ,top=19  ,right=2834 ,bottom=114 ,face='HY견고딕' ,size=18 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#ffffff</T> ";
  ls_for += " 	<T>id='기준년월 :'	,left=0		 ,top=148 ,right=201  ,bottom=214 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#ffffff</T> ";
  ls_for += "   <T>id='" + gs_date.substring(0,4) + "년 " + gs_date.substring(4,6) + "월 " + "' ,left=200, top=148, right=553, bottom=214, align='left', face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align=left</T> ";
  ls_for += " 	<T>id='근태구분 :'	,left=760		 ,top=148 ,right=961  ,bottom=214 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#ffffff</T> ";

	var ls_val1 = gclx_gbn.ValueByColumn("LAZCD", gclx_gbn.ValueOfIndex("LAZCD", gclx_gbn.Index), "LAZFEENM");

	ls_for += "   <T>id='" + ls_val1 + "' ,left=960, top=148, right=1213, bottom=214, align='left', face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align=left</T> ";
	ls_for += " 	<T>id='No'					,left=5		 ,top=228 ,right=114  ,bottom=280 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#bbbbbb</T> ";
  ls_for += " 	<T>id='일 자'				,left=135  ,top=228 ,right=310  ,bottom=280 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#bbbbbb</T> ";
  ls_for += " 	<T>id='소 속'				,left=336  ,top=228 ,right=881  ,bottom=280 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#bbbbbb</T> ";
  ls_for += " 	<T>id='사 번'				,left=902  ,top=228 ,right=1077 ,bottom=280 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#bbbbbb</T> ";
  ls_for += " 	<T>id='성 명'				,left=1101 ,top=228 ,right=1275 ,bottom=280 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#bbbbbb</T> ";
  ls_for += " 	<T>id='시작일'			,left=1299 ,top=228 ,right=1474 ,bottom=280 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#bbbbbb</T> ";
  ls_for += " 	<T>id='종료일'			,left=1498 ,top=228 ,right=1672 ,bottom=280 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#bbbbbb</T> ";
  ls_for += " 	<T>id='근태사유'		,left=1699 ,top=228 ,right=2238 ,bottom=280 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#bbbbbb</T> ";
  ls_for += " 	<T>id='결재일'			,left=2252 ,top=228 ,right=2426 ,bottom=280 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#bbbbbb</T> ";
  ls_for += " 	<T>id='결재자'			,left=2450 ,top=228 ,right=2625 ,bottom=280 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#bbbbbb</T> ";
  ls_for += " 	<T>id='승인일'			,left=2648 ,top=228 ,right=2823 ,bottom=280 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#bbbbbb</T> ";
  ls_for += " </B> ";
  
	/////////////////////////////////////////////////////////////////////////////////////////////
	// Detail
	/////////////////////////////////////////////////////////////////////////////////////////////
  ls_for += " <B>id=Default ,left=0,top=0 ,right=2871 ,bottom=64 ,face='Arial' ,size=10 ,penwidth=1 ";
  ls_for += " 	<L> left=0		,top=0  ,right=0    ,bottom=64 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L> ";
  ls_for += " 	<L> left=1286 ,top=64 ,right=2834 ,bottom=64 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L> ";
  ls_for += " 	<L> left=0		,top=64 ,right=124  ,bottom=64 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L> ";
  ls_for += " 	<L> left=124	,top=0  ,right=320  ,bottom=0 ,penstyle=solid ,penwidth=1 ,pencolor=#000000, supplevel=3 </L> ";
  ls_for += " 	<L> left=320	,top=0  ,right=889  ,bottom=0 ,penstyle=solid ,penwidth=1 ,pencolor=#000000, supplevel=2 </L> ";
  ls_for += " 	<L> left=889	,top=0  ,right=1286 ,bottom=0 ,penstyle=solid ,penwidth=1 ,pencolor=#000000, supplevel=1 </L> ";
	ls_for += " 	<L> left=124	,top=0  ,right=124  ,bottom=64 </L> ";
  ls_for += " 	<L> left=320	,top=0  ,right=320  ,bottom=64 </L> ";
  ls_for += " 	<L> left=889	,top=0  ,right=889  ,bottom=64 </L> ";
  ls_for += " 	<L> left=1087 ,top=0  ,right=1087 ,bottom=64 </L> ";
  ls_for += " 	<L> left=1286 ,top=0  ,right=1286 ,bottom=64 </L> ";
  ls_for += " 	<L> left=1484 ,top=0  ,right=1484 ,bottom=64 </L> ";
  ls_for += " 	<L> left=1683 ,top=0  ,right=1683 ,bottom=64 </L> ";
  ls_for += " 	<L> left=2244 ,top=0  ,right=2244 ,bottom=64 </L> ";
  ls_for += " 	<L> left=2437 ,top=0  ,right=2437 ,bottom=64 </L> ";
  ls_for += " 	<L> left=2635 ,top=0  ,right=2635 ,bottom=64 </L> ";
  ls_for += " 	<L> left=2833 ,top=0  ,right=2833 ,bottom=64 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L> ";
  ls_for += " 	<C>id='{CURROW}', left=5   , top=5, right=114 , bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += " 	<C>id='APPDT'		, left=135 , top=5, right=310 , bottom=58 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, supplevel=3</C> ";
  ls_for += " 	<C>id='DEPTNM'	, left=336 , top=5, right=881 , bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, supplevel=2</C> ";
  ls_for += " 	<C>id='EMPNO'		, left=902 , top=5, right=1077, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, supplevel=1</C> ";
  ls_for += " 	<C>id='EMPNMK'	, left=1101, top=5, right=1275, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, supplevel=1</C> ";
  ls_for += " 	<C>id='FRDT'		, left=1299, top=5, right=1474, bottom=58 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += " 	<C>id='TODT'		, left=1498, top=5, right=1672, bottom=58 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += " 	<C>id='DTYREM'	, left=1699, top=5, right=2238, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += " 	<C>id='SGDT'		, left=2252, top=5, right=2426, bottom=58 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += " 	<C>id='SGNNM'		, left=2450, top=5, right=2625, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += " 	<C>id='AGRDT'		, left=2648, top=5, right=2823, bottom=58 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
  ls_for += " </B> ";

	ls_for += "<B>id=Dfooter ,left=0,top=0 ,right=2871 ,bottom=1 ,face='Arial' ,size=10 ,penwidth=1 ";
	ls_for += " <L> left=0 ,top=0 ,right=2834 ,bottom=0, penstyle=solid ,penwidth=2</L> ";
	ls_for += "</B> ";
	ls_for += "<B>id=Footer ,left=0,top=1950 ,right=2871 ,bottom=2100 ,face='굴림' ,size=10 ,penwidth=1 ";
	ls_for += "	<I>id='../../Common/img/icon.jpg' ,left=2450 ,top=0 ,right=2830 ,bottom=100</I>";
	ls_for += "	<L> left=0 ,top=0 ,right=2834 ,bottom=0, penstyle=solid ,penwidth=2 </L> ";
	ls_for += "	<T> id='#p/#t' left=0 ,top=0 ,right=2834 ,bottom=100</T> ";
	ls_for += "</B>";

	gcrp_print4.Format = ls_for;
}


/******************************************************************************
	Description : 출퇴근현황
******************************************************************************/
function ln_PrintSet7(){
	if(gclx_gubun7.bindcolval=="A"){ //평일
		gcds_print7.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050004_s88?v_str1=" + gcem_date7_fr.text + "&v_str2=" +gcem_date7_to.text;	
		//prompt(this,gcds_print7.DataID);
    gcds_print7.Reset();
	}else if(gclx_gubun7.bindcolval=="B"){ //주말
		gcds_print7.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050004_s89?v_str1=" + gcem_date7_fr.text + "&v_str2=" +gcem_date7_to.text;	
		//prompt(this,gcds_print7.DataID);
    gcds_print7.Reset();
	}
}


/******************************************************************************
	Description : 출퇴근현황 print mst
******************************************************************************/
function ln_PritnSet7_MstSet(){
  var strFrdt=gcem_date7_fr.text; 
	var strTodt=gcem_date7_to.text;	
	var strFRTemp="";
	var strTOTemp="";
	var yy="";
	var mm="";
	var dd="";
  var strT_DT="";
	var strS_DT="";

	yy = strFrdt.substring(0,4);
	mm = strFrdt.substring(4,6);
	dd = strFrdt.substring(6,8);
	strFRTemp=mm+"/"+dd+" ("+ gf_dayOfWeek2(yy,mm,dd) +")"  
	
	yy = strTodt.substring(0,4);
	mm = strTodt.substring(4,6);
	dd = strTodt.substring(6,8);
	strTOTemp=mm+"/"+dd+" ("+ gf_dayOfWeek2(yy,mm,dd) +")"  

	if(gclx_gubun7.bindcolval=="A"){ //평일
		//head 설정
    ln_SetDataHeader();
		gcds_prtmst7.addrow();
		gcds_prtmst7.namevalue(gcds_prtmst7.rowposition,"TITLE")="출.퇴근 현황";
		gcds_prtmst7.namevalue(gcds_prtmst7.rowposition,"DATE")=gcem_date7_fr.text+gcem_date7_to.text;
		gcds_prtmst7.namevalue(gcds_prtmst7.rowposition,"FRDT")=strFRTemp;
		gcds_prtmst7.namevalue(gcds_prtmst7.rowposition,"TODT")=strTOTemp;
		gcrp_print7.Preview();
	}else if(gclx_gubun7.bindcolval=="B"){ //주말
		//head 설정
		yy = strFrdt.substring(0,4);
		mm = strFrdt.substring(4,6);
		dd = strFrdt.substring(6,8);

		strFRTemp=mm+"/"+dd
		F_Day = new Date(yy,mm-1,dd)
		T_Day = new Date(F_Day.getTime()+Math.floor(60*60*24*1000)); //토요일
		S_Day = new Date(T_Day.getTime()+Math.floor(60*60*24*1000)); //일요일
     
		mm = ln_Seqno_Format(T_Day.getMonth()+1,2); // 월 구하기
		dd = ln_Seqno_Format(T_Day.getDate(),2);     // 일 구하기
	  strT_DT = mm+"/"+dd;

		mm = ln_Seqno_Format(S_Day.getMonth()+1,2); // 월 구하기
		dd = ln_Seqno_Format(S_Day.getDate(),2);     // 일 구하기
	  strS_DT = mm+"/"+dd;

		mm = strTodt.substring(4,6);
		dd = strTodt.substring(6,8);

		strTOTemp=mm+"/"+dd 	
    ln_SetDataHeader();
		gcds_prtmst7_2.addrow();
		gcds_prtmst7_2.namevalue(gcds_prtmst7_2.rowposition,"TITLE")="출.퇴근 현황";
		gcds_prtmst7_2.namevalue(gcds_prtmst7_2.rowposition,"DATE")=gcem_date7_fr.text+gcem_date7_to.text;
		gcds_prtmst7_2.namevalue(gcds_prtmst7_2.rowposition,"F_DT")=strFRTemp;
		gcds_prtmst7_2.namevalue(gcds_prtmst7_2.rowposition,"T_DT")=strT_DT;
		gcds_prtmst7_2.namevalue(gcds_prtmst7_2.rowposition,"S_DT")=strS_DT;
		gcds_prtmst7_2.namevalue(gcds_prtmst7_2.rowposition,"M_DT")=strTOTemp;
		gcrp_print7_2.Preview();
	}
}


/******************************************************************************
	Description : 출력 Dataset Head 설정 
  parameter   : 
******************************************************************************/
function ln_SetDataHeader(){
  if(gclx_gubun7.bindcolval=="A"){ //평일
		if(gcds_prtmst7.countrow<1){
			 var s_temp = "TITLE:STRING(50),DATE:STRING(100),PRTTIME:STRING(100),FRDT:STRING(10),TODT:STRING(10)";
			 gcds_prtmst7.SetDataHeader(s_temp);
		}
	}else if(gclx_gubun7.bindcolval=="B"){ //주말
		if(gcds_prtmst7_2.countrow<1){
			 var s_temp = "TITLE:STRING(50),DATE:STRING(100),PRTTIME:STRING(100),F_DT:STRING(10),T_DT:STRING(10),S_DT:STRING(10),M_DT:STRING(10)";
			 gcds_prtmst7_2.SetDataHeader(s_temp);
		}
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME=SubSumExpr VALUE="1:DEPTNM">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"		VALUE="false">
	<PARAM NAME="SubsumExpr"	VALUE="1:DEPTNM">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_holday classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_holfee classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_feegbn classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_duty classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data7 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 출퇴근현황 -->
	<param name=SortExpr    value="+EMPNO+EMPNMK+DEPTNM"> 
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_crossTab classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=Logical    value=true>
	<param name=DataID      value=gcds_data7>
	<param name=GroupExpr   value="EMPNO:EMPNMK:DEPTNM,TITLE,TTIME"> 
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__">
<OBJECT id=gcds_etc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<OBJECT id=gcds_print7 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_prtmst7 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_prtmst7_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

</comment><script>__ws__(__NSID__);</script><!-- 비고:근태기록가져오기 -->
 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data3" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data4" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data5" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data6" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	if (row <1) alert("검색된 데이터가 없습니다.");
	else {
		for (var j=1;j<=row;j++){
			var tem1 = 0;
			var tem2 = 0;
			var amt1=0;
			var amt2=0;

			for (var s=1;s<=gcds_holday.countrow;s++){
				var c = parseInt(gcds_holday.namevalue(s,"HOLDT").substring(6,8),10)-1;
				ls_p[c] = "0";   //휴일 0 셋팅                                                                      //    
			}

			t = 1;
			for (var k=0;k<ls_p.length;k++){                                            // ls_p.length : 월의 일자수
				if (ls_p[k]!="0") { 
						tem1 += gcds_data1.namevalue(j,"temp"+t);   //tem1 : 평일횟수
						amt1 += gcds_data1.namevalue(j,"amt"+t);    //amt1 : 평일금액
				} else {
						tem2 += gcds_data1.namevalue(j,"temp"+t);   //tem2 : 휴일횟수
						amt2 += gcds_data1.namevalue(j,"amt"+t);    //amt2 : 휴일금액

						//b_Grid.ColumnProp('Amt2','BgColor')
				}
				t++
			}

			var amtchk1 = "";                                                                   // amtchk1 : 평일금액
			var amtchk2 = "";                                                                   // amtchk2 : 휴일금액
			                              //계   
		//	for (var r=1;r<=gcds_holfee.countrow;r++) {
		//		if (gcds_holfee.namevalue(r,"LAZCD") == "S02") amtchk1 = gcds_holfee.namevalue(r,"AMT")
		//		else if (gcds_holfee.namevalue(r,"LAZCD") == "S01") amtchk2 = gcds_holfee.namevalue(r,"AMT")
		//	}
       
      gcds_data1.namevalue(j,"TCNT1") = 0;          //평일 특
			gcds_data1.namevalue(j,"TCNT2") = tem1;       //평일 계
			gcds_data1.namevalue(j,"TAMT") =  amt1;       //평일 금액
						
			gcds_data1.namevalue(j,"HCNT1") = 0;          //휴일 특
			gcds_data1.namevalue(j,"HCNT2") =tem2;        //휴일 계
			gcds_data1.namevalue(j,"HAMT") = amt2;        //휴일 금액

			gcds_data1.namevalue(j,"ODAY") = tem1 + tem2;  //합계 일수
			gcds_data1.namevalue(j,"OAMT") = amt1 + amt2;  //합게 금액
		}
	}

	window.status="조회가 완료 되었습니다.";
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	gcgd_disp1.DataID = "gcds_data1";

	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	ft_cnt2.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");

	var val1 = gcds_data2.NameSum("TCNT",0,gcds_data2.countrow);
	var val2 = gcds_data2.NameSum("BCNT",0,gcds_data2.countrow);
 
	var ls_tit = ln_Getbyymm(gcem_date2.text.substring(0,6)).substring(4,6) + "월 특근비 ￦" + val2;

	if (parseInt(val2)<1) txt_bigo.value = ls_tit;
	else txt_bigo.value = ls_tit + " , 증감 " + Math.round(Math.floor((parseInt(val1) - parseInt(val2)))/parseInt(val2)*100) + " %";
//txt_bigo.value = ls_tit + " , 증감 " + Math.round((parseInt(val1) - parseInt(val2)))/parseInt(val2)*100 + " %";
</script>

<script language="javascript" for="gcds_data3" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	ft_cnt3.innerText = "조회건수 : " + gcds_data3.RealCount(1,gcds_data3.CountRow) + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_data4" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	ft_cnt4.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_data5" event="onloadCompleted(row,colid)">
	if (row <1) alert("검색된 데이터가 없습니다.");
	else {
		for (var j=1;j<=row;j++){
			var tem1 = 0;		
			var t = 1;
			for (var k=0;k<ls_p.length;k++){               // ls_p.length : 월
					tem1 += gcds_data5.namevalue(j,"temp"+t);  //tem1 : 횟수계
					t++
			}
      gcds_data5.namevalue(j,"TCNT1") = tem1;  //계
		}
	}
	window.status="조회가 완료 되었습니다.";
	ft_cnt5.innerText = "조회건수 : " + row + " 건";
	gcgd_disp5.DataID = "gcds_data5";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data6" event="onloadCompleted(row,colid)">
	if (row <1) alert("검색된 데이터가 없습니다.");
  else {
		for (var j=1;j<=row;j++){
			var tem1 = 0;		
			var t = 1;
			for (var k=0;k<ls_m.length;k++){               // ls_p.length : 월
					tem1 += gcds_data6.namevalue(j,"temp"+t);  //tem1 : 횟수계
					t++
			}
      gcds_data6.namevalue(j,"TCNT1") = tem1;  //계
		}
	}

	window.status="조회가 완료 되었습니다.";
	ft_cnt6.innerText = "조회건수 : " + row + " 건";
	gcgd_disp6.DataID = "gcds_data6";
	//document.all.LowerFrame.style.visibility="hidden";
</script>


<script language="javascript" for="gcds_holfee" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_feegbn" event="onloadCompleted(row,colid)">
	var arg = gcem_date1.text.substring(0,6);
	ln_ForSel(arg);
	gcds_feegbn.insertrow(1);
	gcds_feegbn.namevalue(1,"LAZCD") = "";
	gcds_feegbn.namevalue(1,"LAZFEENM") = "전체";
	gclx_gbn.index = 0;
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.insertrow(1);
	gcds_dept.namevalue(1,"DEPTCD") = "";
	gcds_dept.namevalue(1,"DEPTNM") = "전체";
	gclx_dept.index = 0;
</script>

<script language=JavaScript for=gclx_dept event=onSelChange()>
		gs_level = '';
		gs_treecd ='';
		gs_level = gclx_dept.ValueOfIndex ("level", gclx_dept.Index);
		gs_treecd = gclx_dept.ValueOfIndex ("treecd", gclx_dept.Index);

		gs_treecd = fn_treecd(gs_level, gs_treecd);
</script>

<script language="javascript" for="gcds_holday" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	ln_Format();
	ln_Format5(); 
	ln_Format6(); 
</script>


<script language="javascript" for="gcds_crossTab" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
	gcgd_disp7.DataID=""
</script>

<script language="javascript" for="gcds_crossTab" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

  //비고가져오기
	gcds_etc.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050004_s78?v_str1="+gcem_date7_to.text	;
	gcds_etc.Reset();	
	for(i=1;i<=row;i++){
	  for(j=1;j<=gcds_etc.countrow;j++){
		  if(gcds_crossTab.namevalue(i,"EMPNO")=="1990103"){
        //alert(""+gcds_etc.namevalue(j,"ETC"));
			}
			if(gcds_crossTab.namevalue(i,"EMPNO")==gcds_etc.namevalue(j,"EMPNO")){
			  //alert("j:::"+j+"::"+gcds_etc.namevalue(j,"ETC"))
				gcds_crossTab.namevalue(i,"ETC")=gcds_etc.namevalue(j,"ETC");
				//alert("i:::"+i+"::"+gcds_crossTab.namevalue(i,"ETC"))
			}
		}
	}
	gcgd_disp7.DataID="gcds_crossTab"
	ft_cnt7.innerText = "조회건수 : " + row + " 건";
</script>


<script language="javascript" for="gcds_data7" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data7" event="onloadCompleted(row,colid)">
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_print7" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_print7" event="onloadCompleted(row,colid)">
	if(row>=1)ln_PritnSet7_MstSet();
	//document.all.LowerFrame.style.visibility="hidden";
</script>
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1));
</script>

<script language="javascript" for="gcgd_disp1" event="onClick(row,colid)">
	if (row<1) {
		if (colid=="DEPTNM"||colid=="PAYGNM"||colid=="EMPNMK"){
			gcds_data1.SortExpr = colid+"+";
			gcds_data1.Sort();
		}
	}
</script>

<script language=JavaScript for=EMEditID event=OnKillFocus()>

return bValue

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

<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/h050004_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr>
					<td width="0" align=right>
						<comment id="__NSID__"><OBJECT id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252   VIEWASTEXT style="width:660px;height:20px;">
							<PARAM NAME="BackColor"		VALUE="#cccccc">
   					  <PARAM NAME="titleHeight" VALUE="20px">
						  <PARAM NAME="DisableBackColor" VALUE="#eeeeee">
						  <PARAM NAME="Format"			VALUE="
								<T>divid=div_create		title=월별특근현황</T>									
							  <T>divid=div_select		title=소속별특근현황</T>
							  <T>divid=div_select2  title=소속별특근비</T>
							  <T>divid=div_select3  title=근태현황</T>
                <T>divid=div_select4  title=해당월현황</T>
								<T>divid=div_select5  title=월별근태현황</T>
								<T>divid=div_select6  title=출퇴근현황</T>
						  ">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=10></td></tr>
</table>
<!-- 월별특근현황 -->
<fieldset id=field1 style="position:absolute;top:160px;left:174px;height:475px;width:875px;bacground-color:#708090"></fieldset>
	<table id="div_disp1" cellpadding="0" cellspacing="0" border="0"  style="width:875px">
		<tr>
			<td align="center">
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;border:1 solid #708090;">
					<tr> 				
						<td class="tab12" style="height:30px;width:90px;" bgcolor="#eeeeee">기준년월</td>
						<td >
							<comment id="__NSID__"><object id=gcem_date1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
								style="position:relative;left:8px;top:1px;width:50px;height:20px;">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM">
									<param name=PromptChar	  value="_">
					    </object></comment><script>__ws__(__NSID__);</script>
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_date1', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
						</td>
						<td width="550" align=right>&nbsp;</td>
						<td valign="bottom">
							<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel('gcgd_disp1','월별특근현황')">
							<img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print('gcrp_print1')">
							<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query('gcds_data1')">&nbsp;
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="2px;"></td></tr>
		<tr>
			<td align="center">
				<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp1  
					style="position:relative;left:3px;width:849px; height:397px; border:1 solid #708090;">
						<PARAM NAME="IndWidth"		VALUE='0'>
            <PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<PARAM NAME="Format"			VALUE="  
						">
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="position:relative;left:3px;width:851px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
<!-- 월별특근현황 END -->

<!--소속별특근현황-->
	<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="width:875px;display:none">
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:15px;border:1 solid #708090;">
					<tr> 				
						<td class="tab12" style="height:30px;width:90px;" bgcolor="#eeeeee">기준년월</td>
						<td >
							<comment id="__NSID__"><object id=gcem_date2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
								style="position:relative;left:8px;top:1px;width:50px;height:20px;">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM">
									<param name=PromptChar	  value="_">
					    </object></comment><script>__ws__(__NSID__);</script>
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_date2', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
						</td>
						<td width="550" align=right>&nbsp;</td>
						<td valign="bottom">
							<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel('gcgd_disp2','소속별특근현황')">
							<img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print('gcrp_print2')">
							<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query('gcds_data2')">&nbsp;
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="2px;"></td></tr>
		<tr>
			<td>
				<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp2  
					style="position:relative;left:15px;width:849px; height:399px; border:1 solid #708090;">
            <PARAM NAME="DataID"			VALUE="gcds_data2">
            <PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="IndWidth"		VALUE='0'>
						<PARAM NAME="ViewSummary"	VALUE='2'>
						<PARAM NAME="Fillarea"		VALUE="true">
					  <PARAM NAME="Format"			VALUE="  
							<C> Name='소속' ID=DEPTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=203 align=left, sumtext='총계/평균', sumbgcolor='#FFDDEE' </C> 
							<C> Name='인원' ID=ACNT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=90  align=center, sumtext=@sum, sumbgcolor='#FFDDEE' </C> 
							<G> Name='특근현황' HeadAlign=Center HeadBgColor=#B9D4DC Align=center
								<C> Name='평일' ID=LCNT			HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right, sumtext=@sum, sumbgcolor='#FFDDEE' </C>
								<C> Name='휴일' ID=HCNT			HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right, sumtext=@sum, sumbgcolor='#FFDDEE' </C>
								<C> Name='계'		ID=TCNT			HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right, sumtext=@sum, sumbgcolor='#FFDDEE' </C>
								<C> Name='전체금액대비' ID={tcnt/sum(tcnt)*100}, HeadAlign=Center HeadBgColor=#B9D4DC Width=120  align=center, dec=2, sumtext='100%', sumbgcolor='#FFDDEE' </C>
								<C> Name='인당특근비'		ID={tcnt/acnt}, HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=right, sumtext={sum(tcnt)/sum(acnt)}, sumbgcolor='#FFDDEE' </C>
							</G>
						">
<!--
								<C> Name='순위' ID=LVL1		HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=right, sumtext=, sumbgcolor='#FFDDEE' </C>
								<C> Name='순위' ID=LVL2		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=right, sumtext='', sumbgcolor='#FFDDEE' </C>
-->

				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="position:relative;left:15px;width:422px;height:20px;border:1 solid #708090;border-top-width:0px;border-right-width:0px;text-align:left;">
					&nbsp;<font id=ft_cnt2 style="position:relative;top:4px;"></font>
				</fieldset>
				<fieldset style="position:relative;left:0px;width:81px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:center;background-color:#eeeeee">
					<span style="position:relative;top:3px;font-family:굴림;font-size:9pt;">비고</span>
				</fieldset>
				<fieldset style="position:relative;left:-6px;top:-1px;width:357px;height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;">
					<input type="text" id="txt_bigo" style="position:relative;top:2px;left:8px;height:15px;width:330px;font-family:굴림;font-size:9pt;border:0"  readonly>
				</fieldset>
			</td>
		</tr>
	</table>
<!-- END -->

<!--  -->
	<table id="div_disp3" cellpadding="0" cellspacing="0" border="0" style="width:875px;display:none">
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:15px;border:1 solid #708090;">
					<tr>
						<td class="tab12" style="height:30px;width:90px;" bgcolor="#eeeeee">기준년월</td>
						<td width="120px;" class="tab23">
							<comment id="__NSID__"><object id=gcem_date3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
								style="position:relative;left:8px;top:1px;width:50px;height:20px;">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM">
									<param name=PromptChar	  value="_">
					    </object></comment><script>__ws__(__NSID__);</script>
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar3 OnClick="__GetCallCalendar('gcem_date3', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
						</td>
						<td class="tab12" style="width:90px;" bgcolor="#eeeeee">소속</td>
						<td width="180px;">
							<comment id="__NSID__"><object id=gclx_dept classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:160px;">
									<param name=ComboDataID			value="gcds_dept">
									<param name=CBDataColumns		value="DEPTCD, DEPTNM">
									<param name=SearchColumn		value=DEPTNM>
									<param name=Sort						value=false>
									<param name=ListExprFormat	value="DEPTNM^0^150">
									<param name=BindColumn			value=DEPTCD>
	 						</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td width="228" align=right>&nbsp;</td>
						<td valign="bottom">
							<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel('gcgd_disp3','특근교통비현황')">
							<img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print('gcrp_print3')">
							<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query('gcds_data3')">&nbsp;
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="2px;"></td></tr>
		<tr>
			<td>
				<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp3  
					style="position:relative;left:15px;width:849px; height:399px; border:1 solid #708090;">
						<PARAM NAME="DataID"			VALUE="gcds_data3">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="IndWidth"		VALUE='0'>
						<PARAM NAME="Fillarea"		VALUE="true">
						<PARAM NAME="Format"			VALUE="  
							<C> Name='순번' ID={CURROW} HeadAlign=Center HeadBgColor=#B9D4DC Width=40 align=right,		SubsumText='', subBgcolor='#FFDDEE' </C> 
							<C> Name='소속' ID=DEPTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=190 align=left,		SubsumText='합 계', subBgcolor='#FFDDEE', suppress=1 </C> 
							<C> Name='직위' ID=PAYGNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=left,		SubsumText='', subBgcolor='#FFDDEE', suppress=2 </C> 
							<C> Name='성명' ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=center,	SubsumText='' , subBgcolor='#FFDDEE'</C>
							<C> Name='평일' ID=LCNT			HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=center, subBgcolor='#FFDDEE'</C>
							<C> Name='휴일' ID=HCNT			HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=center, subBgcolor='#FFDDEE'</C>
							<C> Name='금액' ID={IF (TCNT>200000,(TCNT-(TCNT-200000)),TCNT)}		HeadAlign=Center HeadBgColor=#B9D4DC Width=130 align=right, subBgcolor='#FFDDEE'</C>
							<C> Name='비고' ID={IF (TCNT>200000,(200000-TCNT),0)}			HeadAlign=Center HeadBgColor=#B9D4DC Width=132 align=right, subBgcolor='#FFDDEE'</C>
						">
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="position:relative;left:15px;width:851px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt3 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
<!-- END -->
<!--  -->
	<table id="div_disp4" cellpadding="0" cellspacing="0" border="0" style="width:875px;display:none">
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:15px;border:1 solid #708090;">
					<tr> 				
						<td class="tab12" style="width:90px;height:30px;" bgcolor="#eeeeee">기간</td>
						<td width="100px;">
							<comment id="__NSID__"><object id=gcem_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
								style="position:relative;left:8px;top:1px; width:70px; height:20px;">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
					    </object></comment><script>__ws__(__NSID__);</script>
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar4 OnClick="__GetCallCalendar('gcem_fr', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
						</td>
						<td align=center width="20px"> ~ </td>
						<td class="tab23" width="150px;">
							<comment id="__NSID__"><object id=gcem_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
								style="position:relative;left:1px;top:1px; width:70px; height:20px;">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
					    </object></comment><script>__ws__(__NSID__);</script>
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar5 OnClick="__GetCallCalendar('gcem_to', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">&nbsp;
						</td>
						<td class="tab12" width="90" bgcolor="#eeeeee">근태구분</td>
						<td width="160px;">
	 						<comment id="__NSID__"><object id=gclx_gbn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:0px;font-size:12px;width:150px;height:200px;">
									<param name=ComboDataID			value="gcds_feegbn">
									<param name=CBDataColumns		value="LAZCD, LAZFEENM">
									<param name=SearchColumn		value=LAZFEENM>
									<param name=Sort						value=false>
									<param name=ListExprFormat	value="LAZFEENM^0^150">
									<param name=BindColumn			value=LAZCD>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td width="98" align=right>&nbsp;</td>
						<td valign="bottom">
							<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel('gcgd_disp4','근태현황')">
							<img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print('gcrp_print4')">
							<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query('gcds_data4')">&nbsp;
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="2px;"></td></tr>
		<tr>
			<td>
				<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp4 
					style="position:relative;left:15px;width:849px; height:399px; border:1 solid #708090;">
						<PARAM NAME="DataID"			VALUE="gcds_data4">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="IndWidth"		VALUE='0'>
						<PARAM NAME="Fillarea"		VALUE="true">
						<PARAM NAME="Format"			VALUE="  
							<C> Name='일자'			ID=APPDT  HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center, mask='XXXX/XX/XX', suppress=1 </C> 
							<C> Name='소속'			ID=DEPTNM HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left  , suppress=2 </C>
							<C> Name='사번'			ID=EMPNO  HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=center, suppress=3 </C> 
							<C> Name='성명'			ID=EMPNMK HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center, suppress=3 </C>
							<C> Name='시작일'		ID=FRDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center, mask='XXXX/XX/XX' </C>
							<C> Name='종료일'		ID=TODT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center, mask='XXXX/XX/XX' </C>
							<C> Name='근태사유' ID=DTYREM HeadAlign=Center HeadBgColor=#B9D4DC Width=148	align=left </C>
							<C> Name='결재일'		ID=SGDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center, mask='XXXX/XX/XX' </C>
							<C> Name='결재자'		ID=SGNNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center </C>
							<C> Name='승인일'		ID=AGRDT	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center, mask='XXXX/XX/XX' </C>
							<C> Name='승인자'		ID=AGRNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center </C>
						">
				</OBJECT></comment><script>__ws__(__NSID__);</script>			
				<fieldset style="position:relative;left:15px;width:851px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt4 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
<!-- END -->
<!--  -->
	<table id="div_disp5" cellpadding="0" cellspacing="0" border="0" style="width:875px;display:none" >
		<tr>
			<td align="center">
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;border:1 solid #708090;">
					<tr> 				
						<td class="tab12" style="height:30px;width:90px;" bgcolor="#eeeeee">기준년월</td>
						<td class="tab23" width="115px;" >
							<comment id="__NSID__"><object id=gcem_date5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
								style="position:relative;left:8px;top:1px;width:50px;height:20px;">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM">
									<param name=PromptChar	  value="_">
					    </object></comment><script>__ws__(__NSID__);</script>
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar6 OnClick="__GetCallCalendar('gcem_date5', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
						</td>

            <td class="tab12" width="90" bgcolor="#eeeeee">근태구분</td>
						<td width="160px;">
	 						<comment id="__NSID__"><object id=gclx_gbn5 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:0px;font-size:12px;width:150px;height:200px;">
									<param name=ComboDataID			value="gcds_duty">
									<param name=CBDataColumns		value="MINORCD, MINORNM">
									<param name=SearchColumn		value="MINORNM">
									<param name=Sort						value=false>
									<param name=ListExprFormat	value="MINORNM^0^150">
									<param name=BindColumn			value="MINORCD">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>

						<td width="300px" align=right>&nbsp;</td>
						<td valign="bottom">
							<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel('gcgd_disp5','해당월현황')">
							<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query('gcds_data5')">&nbsp;
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="2px;"></td></tr>
		<tr>
			<td align="center">
				<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp5  
					style="position:relative;left:3px;width:849px; height:397px; border:1 solid #708090;">
						<PARAM NAME="IndWidth"		VALUE='0'>
            <PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<param name="SortView"    value="Left">
						<PARAM NAME="Format"			VALUE="  
						">
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="position:relative;left:3px;width:851px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt5 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
<!-- END -->
<!--  -->
	<table id="div_disp6" cellpadding="0" cellspacing="0" border="0"  style="width:875px;display:none">
		<tr>
			<td align="center">
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;border:1 solid #708090;">
					<tr> 				
						<td class="tab12" style="height:30px;width:90px;" bgcolor="#eeeeee">기준년도</td>
						<td class="tab23" width="115px;" >
							<comment id="__NSID__"><object id=gcem_date6 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
								style="position:relative;left:8px;top:1px;width:40px;height:20px;">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY">
									<param name=PromptChar	  value="_">
					    </object></comment><script>__ws__(__NSID__);</script>
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar6 OnClick="__GetCallCalendar('gcem_date6', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
						</td>

            <td class="tab12" width="90" bgcolor="#eeeeee">근태구분</td>
						<td width="160px;">
	 						<comment id="__NSID__"><object id=gclx_gbn6 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:0px;font-size:12px;width:150px;height:200px;">
									<param name=ComboDataID			value="gcds_duty">
									<param name=CBDataColumns		value="MINORCD, MINORNM">
									<param name=SearchColumn		value="MINORNM">
									<param name=Sort						value=false>
									<param name=ListExprFormat	value="MINORNM^0^150">
									<param name=BindColumn			value="MINORCD">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>

						<td width="300px" align=right>&nbsp;</td>
						<td valign="bottom">
							<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel('gcgd_disp6','월별근태현황')">
							<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query('gcds_data6')">&nbsp;
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="2px;"></td></tr>
		<tr>
			<td align="center">
				<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp6  
					style="position:relative;left:3px;width:849px; height:397px; border:1 solid #708090;">
						<PARAM NAME="IndWidth"		VALUE='0'>
            <PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<param name="SortView"    value="Left">
						<PARAM NAME="Format"			VALUE="  
						">
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="position:relative;left:3px;width:851px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt6 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
<!-- END -->

<!-- 출퇴근현황 -->
 <table id="div_disp7" cellpadding="0" cellspacing="0" border="0"  style="width:875px;display:none">
		<tr>
			<td align="center">
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;border:1 solid #708090; width:851px">
					<tr> 				
						<td class="tab12" style="width:90px;height:30px;" bgcolor="#eeeeee">기간</td>
						<td width="100px;">
							<comment id="__NSID__"><object id=gcem_date7_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
								style="position:relative;left:8px;top:1px; width:70px; height:20px;">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
					    </object></comment><script>__ws__(__NSID__);</script>
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar4 OnClick="__GetCallCalendar('gcem_date7_fr', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
						</td>
						<td align=center width="20px"> ~ </td>
						<td class="tab23" width="150px;">
							<comment id="__NSID__"><object id=gcem_date7_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
								style="position:relative;left:1px;top:1px; width:70px; height:20px;">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
					    </object></comment><script>__ws__(__NSID__);</script>
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar5 OnClick="__GetCallCalendar('gcem_date7_to', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">&nbsp;
						</td>

						<td class="tab12" style="width:90px;height:30px;" bgcolor="#eeeeee">출력구분</td>
            <td width="100px;">
							<comment id="__NSID__">
								<object id=gclx_gubun7 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 class="txtbox"  style="position:relative;left:5px;" >
									<param name=CBData			    value="A^평일,B^주말포함">
									<param name=CBDataColumns	  value="MINORCD,MINORNM">
									<param name=SearchColumn		value="MINORNM">
									<param name=Sort						value="FALSE">
									<param name=ListExprFormat	value="MINORNM^0^100">
									<param name=BindColumn			value="MINORCD">
									<param name=Enable          value="true">
								</object></comment><script>__ws__(__NSID__);</script>
            </td>
						
						<td width="157px" align=right>&nbsp;</td>
						<td valign="bottom" >
							<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel('gcgd_disp7','출퇴근현황')">
	  				  <img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print('gcrp_print7')">
							<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query('gcds_data7')">&nbsp;
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="2px;"></td></tr>
		<tr>
			<td align="center">
				<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp7  
					style="position:relative;left:3px;width:849px; height:397px; border:1 solid #708090;">
					  <PARAM NAME="DataID"			VALUE="gcds_crossTab">
						<PARAM NAME="IndWidth"		VALUE='0'>
            <PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<param name="SortView"    value="Left">
						<PARAM NAME="Format"			VALUE="  
							<F> ID=EMPNO     Title='사번' HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=center sort=false </F> 
							<F> ID=EMPNMK    Title='성명' HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left sort=false   </F> 
							<F> ID=DEPTNM    Title='소속' HeadAlign=Center HeadBgColor=#B9D4DC Width=130 align=left sort=false   </F> 
							<R>
									<C>ID=TTIME_$$  name=$xkeyname_$$  HeadAlign=Center HeadBgColor=#B9D4DC  width=70 align=center MASK='XX:XX' </C>
							</R>
							<F> ID=ETC   Title='비고' HeadAlign=Center HeadBgColor=#B9D4DC Width=130 align=left sort=false   </F> 
							">
						
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="position:relative;left:3px;width:851px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt7 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
<!-- 출퇴근현황 END -->

<comment id="__NSID__"><object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=EVACD    Ctrl=ddlb_evacd       Param=BindColVal</C>
		<C>Col=DIVCD		Ctrl=ddlb_divcd       Param=BindColVal</C>
		<C>Col=GRPCD		Ctrl=ddlb_grpcd       Param=BindColVal</C>
		<C>Col=JOBGRPH  Ctrl=ddlb_jobgrph     Param=BindColVal</C>
		<C>Col=DETCD		Ctrl=ddlb_detcd       Param=BindColVal</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
  <PARAM NAME="MasterDataID"			VALUE="gcds_data1">
  <PARAM NAME="DetailDataID"			VALUE="gcds_data1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
  <PARAM NAME="Landscape"					VALUE="1">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="SuppressColumns"   VALUE="1:DEPTNM">
	<PARAM NAME="Format"            VALUE="
	">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcrp_print2 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
  <PARAM NAME="MasterDataID"			VALUE="gcds_data2">
  <PARAM NAME="DetailDataID"			VALUE="gcds_data2">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
  <PARAM NAME="Landscape"					VALUE="1">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            VALUE="
	">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcrp_print3 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
  <PARAM NAME="MasterDataID"			VALUE="gcds_data3">
  <PARAM NAME="DetailDataID"			VALUE="gcds_data3">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
  <PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="SuppressColumns"   VALUE="1:PAGESKIP,DEPTNM">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            VALUE="
	">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcrp_print4 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
  <PARAM NAME="MasterDataID"			VALUE="gcds_data4">
  <PARAM NAME="DetailDataID"			VALUE="gcds_data4">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
  <PARAM NAME="Landscape"					VALUE="1">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="SuppressColumns"   VALUE="3:APPDT;2:DEPTNM;1:EMPNO,EMPNMK">
	<PARAM NAME="Format"            VALUE="
	">
</object></comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__"><object id=gcrp_print7 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
  <PARAM NAME="MasterDataID"			VALUE="gcds_prtmst7">
  <PARAM NAME="DetailDataID"			VALUE="gcds_print7">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
  <PARAM NAME="Landscape"					VALUE="FALSE">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="Format"            VALUE="
	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=441 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY중고딕', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='FRDT', left=984, top=302, right=1204, bottom=357, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1209 ,top=286 ,right=1209 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1453 ,top=286 ,right=1453 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='출근' ,left=1217 ,top=378 ,right=1439 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='퇴근' ,left=984 ,top=378 ,right=1204 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비고' ,left=1463 ,top=296 ,right=1931 ,bottom=431 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=974 ,top=286 ,right=974 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='팀명' ,left=492 ,top=299 ,right=960 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=487 ,top=288 ,right=487 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=280 ,top=288 ,right=280 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='사번' ,left=79 ,top=299 ,right=275 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=286 ,top=299 ,right=482 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=976 ,top=370 ,right=1450 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=288 ,right=1942 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=288 ,right=71 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=74 ,top=442 ,right=1942 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=288 ,right=1942 ,bottom=288 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TODT', left=1217, top=302, right=1437, bottom=357, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATE', left=1164, top=228, right=1942, bottom=273, align='right' ,mask='날짜 : XXXX-XX-XX 부터 XXXX-XX-XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=53 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=71 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='EMPNO', left=79, top=3, right=275, bottom=53, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=286, top=3, right=482, bottom=53, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTNMK', left=492, top=3, right=960, bottom=53, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CLOTIME', left=984, top=3, right=1204, bottom=53 ,mask='XX:XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATTTIME', left=1217, top=3, right=1439, bottom=53 ,mask='XX:XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ETC', left=1461, top=3, right=1929, bottom=53, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=280 ,top=0 ,right=280 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=487 ,top=0 ,right=487 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=974 ,top=0 ,right=974 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1209 ,top=0 ,right=1209 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1453 ,top=0 ,right=1453 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=0 ,right=1942 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=1558 ,top=3 ,right=1937 ,bottom=85</I>
	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p / #t' ,left=873 ,top=53 ,right=1140 ,bottom=101 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcrp_print7_2 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
  <PARAM NAME="MasterDataID"			VALUE="gcds_prtmst7_2">
  <PARAM NAME="DetailDataID"			VALUE="gcds_print7">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
  <PARAM NAME="Landscape"					VALUE="FALSE">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="Format"            VALUE="
	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=441 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY중고딕', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=915 ,top=286 ,right=915 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=751 ,top=286 ,right=751 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=452 ,top=288 ,right=452 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=262 ,top=288 ,right=262 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=754 ,top=370 ,right=1715 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=288 ,right=1942 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=288 ,right=71 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=74 ,top=442 ,right=1942 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=288 ,right=1942 ,bottom=288 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DATE', left=1164, top=228, right=1942, bottom=273, align='right' ,mask='날짜 : XXXX-XX-XX 부터 XXXX-XX-XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='사번' ,left=79 ,top=299 ,right=254 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=270 ,top=299 ,right=445 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='팀명' ,left=460 ,top=299 ,right=743 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='F_DT', left=759, top=302, right=910, bottom=357, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='퇴근' ,left=759 ,top=378 ,right=910 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='퇴근' ,left=1397 ,top=378 ,right=1548 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출근' ,left=1241 ,top=378 ,right=1392 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출근' ,left=1558 ,top=376 ,right=1709 ,bottom=431 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='퇴근' ,left=1077 ,top=378 ,right=1228 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1233 ,top=286 ,right=1233 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1553 ,top=286 ,right=1553 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1715 ,top=286 ,right=1715 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='비고' ,left=1722 ,top=296 ,right=1931 ,bottom=431 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출근' ,left=921 ,top=378 ,right=1072 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='M_DT', left=1558, top=302, right=1709, bottom=357, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='S_DT', left=1241, top=302, right=1543, bottom=357, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='T_DT', left=921, top=302, right=1222, bottom=357, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1074 ,top=370 ,right=1074 ,bottom=439 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1392 ,top=370 ,right=1392 ,bottom=439 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=53 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=71 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=262 ,top=0 ,right=262 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=452 ,top=0 ,right=452 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=751 ,top=0 ,right=751 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=0 ,right=1942 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='EMPNO', left=79, top=3, right=254, bottom=53, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=270, top=3, right=445, bottom=53, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTNMK', left=460, top=3, right=743, bottom=53, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='F_CLOTIME', left=759, top=3, right=910, bottom=53 ,mask='XX:XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=915 ,top=0 ,right=915 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='ETC', left=1722, top=3, right=1931, bottom=53, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1715 ,top=0 ,right=1715 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='T_CLOTIME', left=1077, top=3, right=1228, bottom=53 ,mask='XX:XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='S_ATTTIME', left=1241, top=3, right=1392, bottom=53 ,mask='XX:XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='S_CLOTIME', left=1397, top=3, right=1548, bottom=53 ,mask='XX:XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='M_ATTTIME', left=1558, top=3, right=1709, bottom=53 ,mask='XX:XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='T_ATTTIME', left=921, top=3, right=1072, bottom=53 ,mask='XX:XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1074 ,top=0 ,right=1074 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1233 ,top=0 ,right=1233 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1392 ,top=0 ,right=1392 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1553 ,top=0 ,right=1553 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2735 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=1558 ,top=3 ,right=1937 ,bottom=85</I>
	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p / #t' ,left=873 ,top=53 ,right=1140 ,bottom=101 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>


	">
</object></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</BODY>
</HTML>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>