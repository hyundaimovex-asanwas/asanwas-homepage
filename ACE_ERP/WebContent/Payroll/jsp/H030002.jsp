<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사/인사현황검색
+ 프로그램 ID	: H030002
+ 기 능 정 의	: 조회,엑셀
+ 변 경 이 력	: 
+ 서 블 릿 명	: h030002_s1, hclcode_s1, hcdept_s1
------------------------------------------------------------------------------>

<html>
<head>
	<jsp:include page="/Payroll/common/include/head.jsp"/>
<title>인사현황검색</title>

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
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_level;
var gs_treecd;
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	//gcra_prngbn.codevalue = 1;
	ln_Disp('1');

	for (var i=1; i<6; i++) {
		eval("gcem_fr"+i).text = gcurdate.substring(0,7) + "01";
		eval("gcem_to"+i).text = gcurdate;
	}

	gcem_fr7.text = gcurdate.substring(0,7) + "01";
	gcem_to7.text = gcurdate;
	
	gcem_fr5.enable = false;	//발령일자 fr
	gcem_to5.enable = false;	//발령일자 to
	txt_chk6.disabled = true;	//발령일자 체크박스

	ln_Before();	//선조회
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	var ls_data = "";
	var gbn = "1";
	
	if (chk_p01.checked) { 
		gbn = chk_p01.value;
	}else if (chk_p02.checked) {
		gbn = chk_p02.value;
	}else if (chk_p03.checked) {
		gbn = chk_p03.value;
	}

	for (var k=2;k<=3;k++) {
		if (eval("chk_p01").checked && eval("chk_p0"+k).checked)	{
			alert("화면조회 자료 중 하나만 선택해 주십시오.");
			return false;
		}else if (eval("chk_p02").checked && eval("chk_p03").checked)	{
			alert("화면조회 자료 중 하나만 선택해 주십시오.");
			return false;
		}
	}

	ls_data += "<%=dirPath%><%=HDConstant.PATH_PERSON%>h030002_s1?";

	if (txt_wrksts.checked)	ls_data += "v_str1=" + gclx_wrksts.bindcolval;
	else ls_data += "v_str1=";

	if (txt_deptcd.checked)	{
		ls_data += "&v_str2=" +	gclx_deptcd.bindcolval
		ls_data += "&v_str17="+gs_level
		ls_data += "&v_str18="+gs_treecd
	} else { 
		ls_data += "&v_str2="
		ls_data += "&v_str17="//+gs_level
		ls_data += "&v_str18="//+gs_treecd
	}

	if (txt_wrkpart.checked)	ls_data += "&v_str3=" +	gclx_jobgrph.bindcolval
	else ls_data += "&v_str3=";

	if (txt_deptlvl.checked)	ls_data += "&v_str4=" +	gclx_deptlvl.bindcolval
	else ls_data += "&v_str4=";

	if (txt_license.checked)	ls_data += "&v_str5=" +	gclx_license.bindcolval
	else ls_data += "&v_str5=";

	if (txt_ordcd.checked)	ls_data += "&v_str19=" +	gclx_ordcd.bindcolval
	else ls_data += "&v_str19=";	//발령구분

	if (txt_chkpayseq.checked)	ls_data += "&v_str24=" +	gclx_chkpayseq.bindcolval
	else ls_data += "&v_str24=";	//호봉

	if (txt_chksex.checked)	ls_data += "&v_str25=" +	gclx_chksex.bindcolval
	else ls_data += "&v_str25=";	//성별

	if (txt_chk6.checked)	{				//발령일자
	ls_data += "&v_str20=" +	gcem_fr5.text; 
	ls_data += "&v_str21=" +	gcem_to5.text;
	} else {ls_data += "&v_str20=&v_str21=";	}

	if (txt_chk7.checked)	{				//그룹일자
	ls_data += "&v_str22=" +	gcem_fr7.text; 
	ls_data += "&v_str23=" +	gcem_to7.text;
	} else {ls_data += "&v_str22=&v_str23=";	}

	var lis=6; lit=7;
	for (var j=1;j<5;j++) {
		if (eval("txt_chk"+j).checked)	{
			ls_data += "&v_str"+lis+"=" +	eval("gcem_fr"+j).text;
			ls_data += "&v_str"+lit+"=" + eval("gcem_to"+j).text;
		} else 	ls_data += "&v_str"+lis+"=&v_str"+lit+"=";

		lis++;lis++;
		lit++;lit++;
	}

	ls_data += "&v_str14=" + gcurdate.substring(0,4);
	ls_data += "&v_str15=" + gs_date.substring(0,6);

	if (gbn=="7") ls_data += "&v_str16=B";
	else ls_data += "&v_str16=A";

	ls_data += "&v_str26=" + gclx_chkorder.BindColVal;

	eval("gcds_data"+gbn).DataID = ls_data;
	eval("gcds_data"+gbn).Reset();

	ln_Disp(gbn);

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
	Description : 출력조회
******************************************************************************/
function ln_PrintQuery(){

	gcds_temp.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h030002_s2";
	gcds_temp.Reset();

	var temp	=  gcds_temp.rowposition;
	var row		=  gcds_data1.rowposition;

}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

	var ls_data = "";
	var gbn = "";
	
	if (chk_p01.checked) { 
		gbn = chk_p01.value;
	}else if (chk_p02.checked) {
		gbn = chk_p02.value;
	}else if (chk_p03.checked) {
		gbn = chk_p03.value;
	}else if (chk_p04.checked) {
		gbn = chk_p04.value;
	}else if (chk_p05.checked) {
		gbn = chk_p05.value;
	}

	for (var k=2;k<=3;k++) {
		if (eval("chk_p01").checked && eval("chk_p0"+k).checked)	{
			alert("화면조회 자료 중 하나만 선택해 주십시오.");
			return false;
		}else if (eval("chk_p02").checked && eval("chk_p03").checked)	{
			alert("화면조회 자료 중 하나만 선택해 주십시오.");
			return false;
		}
	}

	if (chk_p04.checked && chk_p05.checked) {
		alert("출력자료 중 하나만 선택해 주십시오.");
		return false;
	}else if (!chk_p04.checked && !chk_p05.checked) {
		alert("출력자료 중 하나를 선택해 주십시오.");
		return false;
	}

	if (chk_p05.checked && gcds_data1.countrow>0) {	//본부 소속별 현황
		gcds_temp.ClearAll();
		ls_data += "<%=dirPath%><%=HDConstant.PATH_PERSON%>h030002_s2?";
		
		//재직유무
		if (txt_wrksts.checked)	ls_data += "v_str1=" + gclx_wrksts.bindcolval;	
		else ls_data += "v_str1=";

		//소속코드,레벨,조직도
		if (txt_deptcd.checked)	{
			ls_data += "&v_str2=" +	gclx_deptcd.bindcolval
			ls_data += "&v_str5="+gs_level
			ls_data += "&v_str6="+gs_treecd
		} else { 
			ls_data += "&v_str2="
			ls_data += "&v_str5="//+gs_level
			ls_data += "&v_str6="//+gs_treecd
		}

		//직종구분
		if (txt_wrkpart.checked)	ls_data += "&v_str3=" +	gclx_jobgrph.bindcolval
		else ls_data += "&v_str3=";

		//직위코드
		if (txt_deptlvl.checked)	ls_data += "&v_str4=" +	gclx_deptlvl.bindcolval
		else ls_data += "&v_str4=";

		//자격증코드
		if (txt_license.checked)	ls_data += "&v_str7=" +	gclx_license.bindcolval
		else ls_data += "&v_str7=";

		//호봉
		if (txt_chkpayseq.checked)	ls_data += "&v_str20=" +	gclx_chkpayseq.bindcolval
		else ls_data += "&v_str20=";	

		//성별
		if (txt_chksex.checked)	ls_data += "&v_str21=" +	gclx_chksex.bindcolval
		else ls_data += "&v_str21=";	

		//발령구분
		//if (txt_ordcd.checked)	ls_data += "&v_str19=" +	gclx_ordcd.bindcolval
		//else ls_data += "&v_str19=";

		//v_str8-9   : 입사일자 fr ~ 입사일자 to 
		//v_str10-11 : 승진일자 fr ~ 승진일자 to
		//v_str12-13 : 퇴사일자 fr ~ 퇴사일자 to
		//v_str14-15 : 생년월일 fr ~ 생년월일 to
		var lis=8; lit=9;
		for (var j=1;j<5;j++) {
			if (eval("txt_chk"+j).checked)	{
				ls_data += "&v_str"+lis+"=" +	eval("gcem_fr"+j).text;
				ls_data += "&v_str"+lit+"=" + eval("gcem_to"+j).text;
			} else 	ls_data += "&v_str"+lis+"=&v_str"+lit+"=";

			lis++;lis++;
			lit++;lit++;
		}

		//현재년, 현재년월
		ls_data += "&v_str16=" + gcurdate.substring(0,4);
		ls_data += "&v_str17=" + gs_date.substring(0,6);

		//별정직구분
		if (gbn=="7") ls_data += "&v_str18=B";
		else ls_data += "&v_str18=A";

		ls_data += "&v_str22=" + gclx_chkorder.BindColVal;

		gcds_temp.DataID = ls_data;
		gcds_temp.Reset();
						
		var THeader = "EMPNO:STRING(7),EMPNMK:STRING(30),DEPTCD:STRING(4),DEPTNM:STRING(30),TREECD:STRING(8),"
								+"CNT:STRING(5),GUBUN:STRING(1),PAYGNM:STRING(30),PAYGRD:STRING(4),PAYSEQ:STRING(4),"
								+"SEX:STRING(1),GRSTRTDT:STRING(8),STRTDT:STRING(8),LAMDT:STRING(8),BIRDT:STRING(8),"
								+"PERAGE:STRING(4),LSTEDU:STRING(60),LSTHD:STRING(30),PGCCD:STRING(4),ETC:STRING(30),"
								+"SEQ:STRING(5),CURDT:STRING(8),EDCDNM:STRING(30),EDCCNM:STRING(30)";

		gcds_print.SetDataHeader(THeader);
		
		var row = gcds_temp.rowposition;	
		for (var s=1;s<=gcds_temp.countrow;s++) {			

			gcds_print.addrow();
			
			for (var i=1;i<=22;i++) {
				if (i==22) {
					gcds_print.namevalue(s,"CURDT") = gs_date;
				} else {
					gcds_print.namevalue(s,gcds_temp.columnid(i)) = gcds_temp.namevalue(s,gcds_temp.columnid(i));
				}
			}
		}

		if (gcds_data1.countrow<1) { alert("출력하실 자료가 없습니다"); 
		}else {	
			gcrp_print.preview();
		}

	} else {

	ln_BasPrint();
	
	}
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_BasPrint(){

	var ls_data = "";
	var gbn = "1";
	
	if (chk_p01.checked) { 
		gbn = chk_p01.value;
	}else if (chk_p02.checked) {
		gbn = chk_p02.value;
	}else if (chk_p03.checked) {
		gbn = chk_p03.value;
	}else if (chk_p04.checked) {
		gbn = chk_p04.value;
	}else if (chk_p05.checked) {
		gbn = chk_p05.value;
	}

	for (var k=2;k<=3;k++) {
		if (eval("chk_p01").checked && eval("chk_p0"+k).checked)	{
			alert("화면조회 자료 중 하나만 선택해 주십시오.");
			return false;
		}else if (eval("chk_p02").checked && eval("chk_p03").checked)	{
			alert("화면조회 자료 중 하나만 선택해 주십시오.");
			return false;
		}
	}

	if (chk_p04.checked && chk_p05.checked) {
		alert("출력자료 중 하나만 선택해 주십시오.");
		return false;
	}else if (!chk_p04.checked && !chk_p05.checked) {
		alert("출력자료 중 하나를 선택해 주십시오.");
		return false;
	}

	if (chk_p04.checked && gcds_data1.countrow>0) {	//인사기본정보
		gcds_temp2.ClearAll();
		//gcds_temp.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h030002_s3";
		ls_data += "<%=dirPath%><%=HDConstant.PATH_PERSON%>02_s3?";
		
		//재직유무
		if (txt_wrksts.checked)	ls_data += "v_str1=" + gclx_wrksts.bindcolval;	
		else ls_data += "v_str1=";

		//소속코드,레벨,조직도
		if (txt_deptcd.checked)	{
			ls_data += "&v_str2=" +	gclx_deptcd.bindcolval
			ls_data += "&v_str5="+gs_level
			ls_data += "&v_str6="+gs_treecd
		} else { 
			ls_data += "&v_str2="
			ls_data += "&v_str5="//+gs_level
			ls_data += "&v_str6="//+gs_treecd
		}

		//직종구분
		if (txt_wrkpart.checked)	ls_data += "&v_str3=" +	gclx_jobgrph.bindcolval
		else ls_data += "&v_str3=";

		//직위코드
		if (txt_deptlvl.checked)	ls_data += "&v_str4=" +	gclx_deptlvl.bindcolval
		else ls_data += "&v_str4=";

		//자격증코드
		if (txt_license.checked)	ls_data += "&v_str7=" +	gclx_license.bindcolval
		else ls_data += "&v_str7=";

		//호봉
		if (txt_chkpayseq.checked)	ls_data += "&v_str20=" +	gclx_chkpayseq.bindcolval
		else ls_data += "&v_str20=";	

		//성별
		if (txt_chksex.checked)	ls_data += "&v_str21=" +	gclx_chksex.bindcolval
		else ls_data += "&v_str21=";	

		//발령구분
		//if (txt_ordcd.checked)	ls_data += "&v_str19=" +	gclx_ordcd.bindcolval
		//else ls_data += "&v_str19=";

		//v_str8-9   : 입사일자 fr ~ 입사일자 to 
		//v_str10-11 : 승진일자 fr ~ 승진일자 to
		//v_str12-13 : 퇴사일자 fr ~ 퇴사일자 to
		//v_str14-15 : 생년월일 fr ~ 생년월일 to
		var lis=8; lit=9;
		for (var j=1;j<5;j++) {
			if (eval("txt_chk"+j).checked)	{
				ls_data += "&v_str"+lis+"=" +	eval("gcem_fr"+j).text;
				ls_data += "&v_str"+lit+"=" + eval("gcem_to"+j).text;
			} else 	ls_data += "&v_str"+lis+"=&v_str"+lit+"=";

			lis++;lis++;
			lit++;lit++;
		}

		//현재년, 현재년월
		ls_data += "&v_str16=" + gcurdate.substring(0,4);
		ls_data += "&v_str17=" + gs_date.substring(0,6);

		//별정직구분
		if (gbn=="7") ls_data += "&v_str18=B";
		else ls_data += "&v_str18=A";

		ls_data += "&v_str22=" + gclx_chkorder.BindColVal;

	gcds_temp2.DataID = ls_data;
	gcds_temp2.Reset();
	
	}

	var THeader = "EMPNMK:STRING(20),NME:STRING(40),NMC:STRING(20),EMPNO:STRING(7),RESINO:STRING(13),"
							+"BIRDT:STRING(8),GLDIVNM:STRING(6),SEXNM:STRING(6),DEPTNM:STRING(30),PAYGNM:STRING(30),"
							+"PAYSNM:STRING(30),JOBNM:STRING(30),DPOFFDT:STRING(8),ORDDT:STRING(8),LAMDT:STRING(8),"
							+"GRSTRTDT:STRING(8),STRTDT:STRING(8),ENDDT:STRING(8),EDIVNM:STRING(30),SCHNM:STRING(60),"
							+"BLOOD:STRING(2),TELNO:STRING(15),EMPADD:STRING(70),PICFILE:STRING(100),RILIGNM:STRING(30),"
							+"CURDT:STRING(8)";//COL

	gcds_print2.SetDataHeader(THeader);

	var row = gcds_temp2.rowposition;
		for (var s=1;s<=gcds_temp2.countrow;s++) {
			gcds_print2.addrow();
			for (var i=1;i<=26;i++) {	//COL
				if (i==26) {
					gcds_print2.namevalue(s,"CURDT") = gs_date;
				} else {
					gcds_print2.namevalue(s,gcds_temp2.columnid(i)) = gcds_temp2.namevalue(s,gcds_temp2.columnid(i));
				}
			}
		}

		ln_Format();

		if (gcds_data1.countrow<1) { alert("출력하실 자료가 없습니다"); 
		}else {	
			gcrp_print2.preview();
		}
}

/******************************************************************************
	Description : 출력물 포멧 작성
******************************************************************************/
function ln_Format() {

	var ls_for = "";

		ls_for += "<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=204 ,face='Arial' ,size=10 ,penwidth=1																																																																											";
		ls_for += "	<T>id='인 사 기 본 정 보' ,left=597 ,top=9 ,right=1406 ,bottom=116 ,face='HY헤드라인M' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>																												";
		ls_for += "	<L> left=703 ,top=125 ,right=1297 ,bottom=125 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>																																																																					";
		ls_for += "	<C>id='CURDT', left=1516, top=141, right=1959, bottom=197, align='right' ,mask='발행일자 : XXXX/XX/XX', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>													";
		ls_for += "</B>																																																																																																																				";
		ls_for += "<B>id=default ,left=0,top=0 ,right=2000 ,bottom=488 ,face='Arial' ,size=10 ,penwidth=1																																																																											";
		ls_for += "	<X>left=0 ,top=325 ,right=1963 ,bottom=453 ,border=true</X>																																																																																								";
		ls_for += "	<X>left=325 ,top=0 ,right=513 ,bottom=66 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																																																	";
		ls_for += "	<L> left=509 ,top=0 ,right=1963 ,bottom=0 </L>																																																																																														";
		ls_for += "	<X>left=325 ,top=62 ,right=513 ,bottom=128 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																																																";
		ls_for += "	<X>left=325 ,top=125 ,right=513 ,bottom=191 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																																																";
		ls_for += "	<X>left=325 ,top=187 ,right=513 ,bottom=253 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																																																";
		ls_for += "	<X>left=325 ,top=250 ,right=513 ,bottom=312 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																																																";
		ls_for += "	<T>id='소속발령' ,left=334 ,top=194 ,right=506 ,bottom=244 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>																																			";
		ls_for += "	<T>id='소속/직위' ,left=334 ,top=131 ,right=506 ,bottom=181 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>																																		";
		ls_for += "	<T>id='주민번호' ,left=334 ,top=69 ,right=506 ,bottom=119 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>																																			";
		ls_for += "	<T>id='성   명' ,left=334 ,top=6 ,right=506 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>																																					";
		ls_for += "	<L> left=509 ,top=62 ,right=1963 ,bottom=62 </L>																																																																																													";
		ls_for += "	<L> left=509 ,top=125 ,right=1963 ,bottom=125 </L>																																																																																												";
		ls_for += "	<L> left=509 ,top=187 ,right=1963 ,bottom=187 </L>																																																																																												";
		ls_for += "	<L> left=509 ,top=250 ,right=1963 ,bottom=250 </L>																																																																																												";
		ls_for += "	<C>id='RESINO', left=516, top=69, right=950, bottom=119, align='left' ,mask='XXXXXX-XXXXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																		";
		ls_for += "	<C>id='PAYGNM', left=763, top=131, right=950, bottom=181, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																													";
		ls_for += "	<X>left=0 ,top=0 ,right=328 ,bottom=312 ,border=true</X>																																																																																									";
		ls_for += "	<T>id='그룹입사일' ,left=334 ,top=256 ,right=506 ,bottom=306 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>																																		";
		ls_for += "	<X>left=956 ,top=62 ,right=1144 ,bottom=128 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																																																";
		ls_for += "	<X>left=956 ,top=125 ,right=1144 ,bottom=191 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																																															";
		ls_for += "	<X>left=956 ,top=187 ,right=1144 ,bottom=253 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																																															";
		ls_for += "	<X>left=956 ,top=250 ,right=1144 ,bottom=312 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																																															";
		ls_for += "	<T>id='생년월일' ,left=963 ,top=69 ,right=1134 ,bottom=119 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>																																			";
		ls_for += "	<T>id='급   호' ,left=963 ,top=131 ,right=1134 ,bottom=181 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>																																			";
		ls_for += "	<T>id='직위발령일' ,left=963 ,top=194 ,right=1134 ,bottom=244 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>																																	";
		ls_for += "	<T>id='입사일' ,left=963 ,top=256 ,right=1134 ,bottom=306 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>																																			";
		ls_for += "	<C>id='BIRDT', left=1150, top=69, right=1438, bottom=119, align='left' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																			";
		ls_for += "	<C>id='PAYSNM', left=1150, top=131, right=1438, bottom=181, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																												";
		ls_for += "	<C>id='DEPTNM', left=516, top=131, right=756, bottom=181, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																													";
		ls_for += "	<C>id='ORDDT', left=1150, top=194, right=1438, bottom=244, align='left' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																			";
		ls_for += "	<C>id='STRTDT', left=1150, top=256, right=1438, bottom=306, align='left' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																		";
		ls_for += "	<X>left=1475 ,top=0 ,right=1663 ,bottom=62 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																																																";
		ls_for += "	<C>id='GLDIVNM', left=1478, top=69, right=1631, bottom=119, align='right' ,mask=' / ', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																					";
		ls_for += "	<C>id='SEXNM', left=1638, top=69, right=1791, bottom=119, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																													";
		ls_for += "	<X>left=1475 ,top=125 ,right=1663 ,bottom=191 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																																															";
		ls_for += "	<X>left=1475 ,top=187 ,right=1663 ,bottom=253 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																																															";
		ls_for += "	<X>left=1475 ,top=250 ,right=1663 ,bottom=312 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																																															";
		ls_for += "	<T>id='퇴사일' ,left=1481 ,top=256 ,right=1653 ,bottom=306 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>																																			";
		ls_for += "	<T>id='승진일' ,left=1481 ,top=194 ,right=1653 ,bottom=244 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>																																			";
		ls_for += "	<T>id='직   종' ,left=1481 ,top=131 ,right=1653 ,bottom=181 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>																																		";
		ls_for += "	<C>id='JOBNM', left=1669, top=131, right=1956, bottom=181, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																												";
		ls_for += "	<C>id='LAMDT', left=1669, top=194, right=1956, bottom=244, align='left' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																			";
		ls_for += "	<C>id='ENDDT', left=1669, top=256, right=1956, bottom=306, align='left' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																			";
		ls_for += "	<C>id='DPOFFDT', left=516, top=194, right=803, bottom=244, align='left' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																			";
		ls_for += "	<C>id='GRSTRTDT', left=516, top=256, right=803, bottom=306, align='left' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																		";
		ls_for += "	<X>left=0 ,top=325 ,right=153 ,bottom=391 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																																																	";
		ls_for += "	<T>id='입사채용' ,left=6 ,top=331 ,right=147 ,bottom=381 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>																																				";
		ls_for += "	<X>left=0 ,top=387 ,right=328 ,bottom=453 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																																																	";
		ls_for += "	<L> left=325 ,top=387 ,right=1959 ,bottom=387 </L>																																																																																												";
		ls_for += "	<C>id='EMPADD', left=334, top=394, right=1469, bottom=447, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																												";
		ls_for += "	<X>left=1475 ,top=325 ,right=1663 ,bottom=391 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																																															";
		ls_for += "	<X>left=1475 ,top=387 ,right=1663 ,bottom=453 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																																															";
		ls_for += "	<T>id='혈액형' ,left=1481 ,top=331 ,right=1653 ,bottom=381 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>																																			";
		ls_for += "	<T>id='전화번호' ,left=1481 ,top=394 ,right=1653 ,bottom=447 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>																																		";
		ls_for += "	<C>id='BLOOD', left=1669, top=331, right=1956, bottom=381, align='left' ,mask='XX형', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																						";
		ls_for += "	<C>id='TELNO', left=1669, top=394, right=1956, bottom=447, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																												";
		ls_for += "	<C>id='SCHNM', left=1150, top=331, right=1438, bottom=381, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																												";
		ls_for += "	<T>id='사   번' ,left=1481 ,top=6 ,right=1653 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>																																				";
		ls_for += "	<X>left=956 ,top=325 ,right=1144 ,bottom=387 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																																															";
		ls_for += "	<C>id='NMC', left=734, top=6, right=953, bottom=56, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																																";
		ls_for += "	<C>id='EMPNMK', left=516, top=6, right=728, bottom=56, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																														";
		ls_for += "	<C>id='NME', left=963, top=6, right=1444, bottom=56, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																															";
		ls_for += "	<T>id='출신교' ,left=963 ,top=331 ,right=1134 ,bottom=384 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>																																			";
		ls_for += "	<L> left=513 ,top=312 ,right=1963 ,bottom=312 </L>																																																																																												";
		ls_for += "	<L> left=1963 ,top=0 ,right=1963 ,bottom=312 </L>																																																																																													";
		ls_for += "	<L> left=0 ,top=466 ,right=1959 ,bottom=466 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>																																																																						";
		ls_for += "	<C>id='EMPNO', left=1669, top=6, right=1956, bottom=56, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																														";
		ls_for += "	<L> left=325 ,top=0 ,right=325 ,bottom=309 </L>																																																																																														";
		ls_for += "	<L> left=0 ,top=0 ,right=325 ,bottom=0 </L>																																																																																																";
		ls_for += "	<L> left=0 ,top=0 ,right=325 ,bottom=0 </L>																																																																																																";
		ls_for += "	<I>id='PICFILE' ,left=2 ,top=3 ,right=325 ,bottom=311</I>																																																																																									";
		ls_for += "	<T>id='주   소' ,left=6 ,top=394 ,right=322 ,bottom=447 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>																																				";
		ls_for += "	<C>id='EDIVNM', left=159, top=331, right=319, bottom=381, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																													";
		ls_for += "	<X>left=327 ,top=325 ,right=513 ,bottom=387 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																																																";
		ls_for += "	<T>id='종   교' ,left=334 ,top=331 ,right=506 ,bottom=381 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>																																			";
		ls_for += "	<C>id='RILIGNM', left=516, top=331, right=803, bottom=381, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>																												";
		ls_for += "</B>																																																																																																																				";
		ls_for += "</B>                                                                                                                                                                                                                        								";
		ls_for += "<B>id=Footer ,left=0,top=2750 ,right=2000 ,bottom=2800 ,face='Arial' ,size=10 ,penwidth=1																																																																									";
		ls_for += "	<I>id='../../Common/img/icon.jpg' ,left=1594 ,top=30 ,right=1974 ,bottom=130</I>																																																																													";
		ls_for += "	<L> left=0 ,top=20	,right=1974 ,bottom=20, penstyle=solid, penwidth=2 </L>																																																																																";
		ls_for += "	<T> id='#p/#t' left=0 ,top=30 ,right=1974 ,bottom=110</T>																																																																																									";
		ls_for += "</B>																																																																																																																				";

	gcrp_print2.format = ls_for + gcrp_print2.format;

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

	var e = "1";
	
	if (chk_p01.checked) { 
		e = chk_p01.value;
	}else if (chk_p02.checked) {
		e = chk_p02.value;
	}else if (chk_p03.checked) {
		e = chk_p03.value;
	}
	if (eval("gcds_data"+e).countrow<1) alert("다운로드 하실 자료가 없습니다");
	else eval("gcgd_disp"+e).runexcel("인사현황");

}

/******************************************************************************
	Description : 선조회 조건
******************************************************************************/
function ln_Before(){

	//재직구분
	gcds_srh.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1121";
	gcds_srh.Reset();

	//소속
	gcds_dept.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?v_str1=";
	gcds_dept.Reset();

	//직군
	gcds_jobgrph.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2000";
	gcds_jobgrph.Reset();

	//직위코드
	gcds_deptlvl.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002";
	gcds_deptlvl.Reset();

	//호봉
	gcds_payseq.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1184";
	gcds_payseq.Reset();

	//자격증
	gcds_license.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1127";
	gcds_license.Reset();

	//발령구분
	//gcds_ordcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>ordcode_s1?v_str1=1149";
	//gcds_ordcd.Reset();

	gclx_ordcd.index =0;

}

/******************************************************************************
	Description : 그리드 보이기
******************************************************************************/
function ln_Disp(e){
	for (var i=1;i<8;i++) eval("disp0"+i).style.visibility = "hidden";
	eval("disp0"+e).style.visibility = "visible";
}

/******************************************************************************
	Description : 입력항목 표시유무
******************************************************************************/
function ln_Disp2(){

	gcem_fr5.text = gcurdate.substring(0,7) + "01";
	gcem_to5.text = gcurdate;
	
	if (txt_ordcd.checked) {
		gcem_fr5.enable = true;			//발령일자 fr
		gcem_to5.enable = true;			//발령일자 to
		txt_chk6.disabled = false;	//발령일자 체크박스
	}else{
		gcem_fr5.enable = false;		//발령일자 fr
		gcem_to5.enable = false;		//발령일자 to
		txt_chk6.disabled = true;		//발령일자 체크박스
	}
	//if(gcgd_orddt.style.display=="none") gcgd_orddt.style.display="block";
	//else gcgd_orddt.style.display="none";

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
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

<comment id="__NSID__"><OBJECT id=gcds_data7 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_deptlvl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<!-- <PARAM NAME="SortExpr" VALUE="+MINORNM"> -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<!-- <PARAM NAME="SortExpr" VALUE="+TREECD"> -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_payseq classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_license classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+MINORNM">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_srh classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_jobgrph classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 전체 소속별 출력 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_print2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 개인기본정보 출력 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_temp2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_photo classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_ordcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+ordnm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

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

<script language="javascript" for="gcds_data7" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_srh" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	ft_cnt2.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data3" event="onloadCompleted(row,colid)">
	ft_cnt3.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data4" event="onloadCompleted(row,colid)">
	ft_cnt4.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data5" event="onloadCompleted(row,colid)">
	ft_cnt5.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data6" event="onloadCompleted(row,colid)">
	ft_cnt6.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data7" event="onloadCompleted(row,colid)">
	ft_cnt7.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data7" event="onloadError()">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_jobgrph" event="onloadCompleted(row,colid)">
	gcds_jobgrph.deleterow(1);
	gclx_jobgrph.index = 0;
</script>

<script language=JavaScript for=gclx_deptcd event=onSelChange()>
		gs_level = '';
		gs_treecd ='';
		gs_level = gclx_deptcd.ValueOfIndex ("level", gclx_deptcd.Index);
		gs_treecd = gclx_deptcd.ValueOfIndex ("treecd", gclx_deptcd.Index);

		gs_treecd = fn_treecd(gs_level, gs_treecd);
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.insertrow(1);
	gcds_dept.namevalue(1,"DEPTCD") = "";
	gcds_dept.namevalue(1,"DEPTNM") = "전체";
	gclx_deptcd.index = 0;
</script>

<script language="javascript" for="gcds_srh" event="onloadCompleted(row,colid)">
	gcds_srh.insertrow(1);
	gcds_srh.namevalue(1,"MINORCD") = "0";
	gcds_srh.namevalue(1,"MINORNM") = "전체";
	gclx_wrksts.index = 0;
</script>

<script language="javascript" for="gcds_jobgrph" event="onloadCompleted(row,colid)">
	gcds_jobgrph.insertrow(1);
	gcds_jobgrph.namevalue(1,"MINORCD") = "";
	gcds_jobgrph.namevalue(1,"MINORNM") = "전체";
	gclx_jobgrph.index = 0;
</script>

<script language="javascript" for="gcds_deptlvl" event="onloadCompleted(row,colid)">
	gcds_deptlvl.insertrow(1);
	gcds_deptlvl.namevalue(1,"MINORCD") = "";
	gcds_deptlvl.namevalue(1,"MINORNM") = "전체";
	gclx_deptlvl.index = 0;
</script>

<script language="javascript" for="gcds_payseq" event="onloadCompleted(row,colid)">
	gcds_payseq.insertrow(1);
	gcds_payseq.namevalue(1,"MINORCD") = "";
	gcds_payseq.namevalue(1,"MINORNM") = "전체";
	gclx_chkpayseq.index = 0;
</script>

<script language="javascript" for="gcds_license" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	gcds_license.insertrow(1);
	gcds_license.namevalue(1,"MINORCD") = "";
	gcds_license.namevalue(1,"MINORNM") = "전체";
	gclx_license.index = 0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- <script language="javascript" for="gcra_prngbn" event="onSelChange()">
	ln_Disp(gcra_prngbn.codevalue);
</script>
 -->
<!-- <script language="javascript" for="txt_ordcd"		event="onmousedown()">
	//ln_Disp2(txt_ordcd.checked)
//alert(txt_ordcd.checked);
//gcgd_orddt.style.visibility="hidden";

</script> -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" border="0"   cellpadding="0" cellspacing="0">
	<tr>
		<td width=100% height="25px">
			<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;">
				<tr> 
					<td width="197" background="../../Common/img/com_t_bg.gif"><IMG height=47 src="../img/h030002_head.gif" width=197></td>
					<td width="100%" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:1px">
						<img name="btn_print" border="0" src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print()">
			      <img name="btn_excel" border="0" src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel()">
						<img name="btn_query" border="0" src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onClick="ln_Query()">&nbsp;
			    </td>
				</tr>
	    </table>
		</td>
	</tr>
	<tr>
	  <td style="padding-left:3px;">
	    <table width="876" cellpadding=0 cellspacing=0>
			  <tr>
					<td width=290 valign=top><fieldset style="height:70px;"><legend>화면조회 자료</legend>
						<input type="checkbox" id=chk_p01   value="1" style="position:relative;top:5px;">
						<input type="text"     id=chk_p01nm value="인사명부" style="position:relative;top:5px;left:-4px;border-width:0;width:55px">
						<input type="checkbox" id=chk_p02   value="6" style="position:relative;top:5px;left:-6px">
						<input type="text"     id=chk_p02nm value="직원주소록" style="position:relative;top:5px;left:-10px;border-width:0;width:68px">
						<input type="checkbox" id=chk_p03   value="7" style="position:relative;top:5px;left:-14px">
						<input type="text"     id=chk_p03nm value="별정직현황" style="position:relative;top:5px;left:-15px;border-width:0;width:65px">
						<input type="text" value="" style="border-width:0;width:65px;height:1px">
						
							<fieldset style="height:20px;"><legend>출력자료</legend>
								<input type="checkbox" id=chk_p04   value="H" style="position:relative;top:0px;">
								<input type="text"     id=chk_p04nm value="인사기본" style="position:relative;top:0px;left:-5px;border-width:0;width:52px">
								<input type="checkbox" id=chk_p05   value="D" style="position:relative;top:0px;left:-5px;">
								<input type="text"     id=chk_p05nm value="본부소속" style="position:relative;top:0px;left:-10px;border-width:0;width:52px">
							</fieldset>

							<fieldset style="height:20px;position:relative;top:5px"><legend>조건선택1</legend><nobr>
								<input type="checkbox" id=txt_chksex   style="position:relative;top:-2.5px;">
								<input type="text"     id=txt_chksexnm value="성별" style="position:relative;left:-8px;top:-2.5px;border-width:0;width:25px">
								<comment id="__NSID__"><object id=gclx_chksex classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
									style="position:relative;left:-3px;top:3px;font-size:12px;width:48px;">
										<param name=CBData					value="0^전체,1^남자,2^여자">
										<param name=CBDataColumns		value="MINORCD,MINORNM">
										<param name=SearchColumn		value=MINORNM>
										<param name=index						value="0">
										<param name=Sort						value=false>
										<param name=ListExprFormat	value="MINORNM^0^70">
										<param name=BindColumn			value=MINORCD>
								</object></comment><script>__ws__(__NSID__);</script>

								<input type="checkbox" id=txt_chkpayseq   style="position:relative;top:-2.5px;left:-5px">
								<input type="text"     id=txt_chkpayseqnm value="호봉" style="position:relative;top:-2.5px;left:-13px;border-width:0;width:25px">
								<comment id="__NSID__"><object id=gclx_chkpayseq classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
									style="position:relative;left:-9px;top:3px;font-size:12px;width:62px;">
										<param name=ComboDataID			value="gcds_payseq">
										<param name=CBDataColumns		value="MINORCD,MINORNM">
										<param name=SearchColumn		value=MINORNM>
										<param name=Sort						value=false>
										<param name=ListExprFormat	value="MINORNM^0^60">
										<param name=BindColumn			value=MINORCD>
								</object></comment><script>__ws__(__NSID__);</script>

								<comment id="__NSID__"><object id=gclx_chkorder classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
									style="position:relative;left:-12px;top:3px;left:0px;font-size:12px;width:54px;">
										<param name=CBData					value="1^DESC,2^ASC">
										<param name=CBDataColumns		value="MINORCD,MINORNM">
										<param name=SearchColumn		value=MINORNM>
										<param name=index						value="0">
										<param name=Sort						value=false>
										<param name=ListExprFormat	value="MINORNM^0^70">
										<param name=BindColumn			value=MINORCD>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</fieldset><br>

					</fieldset></td>
			    <td width=250 valign=top><fieldset style="height:140px;"><legend>조건선택2</legend>
					  <table cellpadding="0" cellspacing="0" border=0>
							<tr>
						  	<td><input type="checkbox" id=txt_wrksts style="position:relative;top:-2.5px;"></td>
						  	<td height="19px;">재직유무</td>
						  	<td>
									<comment id="__NSID__"><object id=gclx_wrksts classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:8px;top:0px;font-size:12px;width:150px;">
											<param name=ComboDataID			value="gcds_srh">
											<param name=CBDataColumns		value="MINORCD,MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORNM^0^150">
											<param name=BindColumn			value=MINORCD>
 									</object></comment><script>__ws__(__NSID__);</script>
								</td>
						  </tr>
						  <tr>
						  	<td><input type="checkbox" id=txt_deptcd style="position:relative;top:-2.5px;"></td>
						  	<td height="19px;">소속코드</td>
						  	<td>
									<comment id="__NSID__"><object id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:8px;top:1px;font-size:12px;width:150px;">
											<param name=ComboDataID			value="gcds_dept">
											<param name=CBDataColumns		value="DEPTCD, DEPTNM">
											<param name=SearchColumn		value=DEPTNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="DEPTNM^0^150">
											<param name=BindColumn			value=DEPTCD>
 									</object></comment><script>__ws__(__NSID__);</script>
								</td>
						  </tr>
						  <tr>
						  	<td><input type="checkbox" id=txt_wrkpart style="position:relative;top:-2.5px;"></td>
						  	<td height="19px;">직종구분</td>
				  			<td>
									<comment id="__NSID__"><object id=gclx_jobgrph classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:8px;top:1px;font-size:12px;width:120px;">
											<param name=ComboDataID			value="gcds_jobgrph">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORNM^0^120">
											<param name=BindColumn			value=MINORCD>
	 								</object></comment><script>__ws__(__NSID__);</script>
								</td>
						  </tr>
						  <tr>
						  	<td><input type="checkbox" id=txt_deptlvl style="position:relative;top:-2.5px;"></td>
						  	<td height="19px;">직위코드</td>
		  					<td><font color="#9999ff">
									<comment id="__NSID__"><object id=gclx_deptlvl classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:8px;top:1px;font-size:12px;width:120px;">
											<param name=ComboDataID			value="gcds_deptlvl">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORNM^0^120">
											<param name=BindColumn			value=MINORCD>
	 								</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td><input type="checkbox" id=txt_ordcd style="position:relative;top:-2.5px;" onclick="ln_Disp2()"></td>
								<td height="19px;">발령구분</td>
								<td><font color="#9999ff">
									<comment id="__NSID__"><object id=gclx_ordcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:8px;top:1px;font-size:12px;width:120px;">
											<param name=CBData  		value="1^전체,C1^부임,C3^복귀">
											<param name=CBDataColumns		value="ORDCD, ORDNM">
											<param name=SearchColumn		value=ORDNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="ORDNM^0^90">
											<param name=BindColumn			value=ORDCD>
											<!-- <param name=ComboDataID			value="gcds_ordcd">
											<param name=CBDataColumns		value="ORDCD, ORDNM">
											<param name=SearchColumn		value=ORDNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="ORDNM^0^90">
											<param name=BindColumn			value=ORDCD> -->
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
						  </tr>
							<tr>
					  		<td><input type="checkbox" id=txt_license></td>
					  		<td height="19px;">자격증코드</td>
					  		<td><font color="#9999ff">
									<comment id="__NSID__"><object id=gclx_license classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:7px;top:1px;font-size:12px;width:120px;">
											<param name=ComboDataID			value="gcds_license">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORNM^0^150">
											<param name=BindColumn			value=MINORCD>
	 								</object></comment><script>__ws__(__NSID__);</script>
								</td>
					  	</tr>
					  </table></fieldset>
					</td>
				  <td valign=top width=336><fieldset style="height:140px;"><legend>조건선택3</legend>
				    <table cellpadding="0" cellspacing="0" border="0">
							<tr>
				  			<td width="30px;"><input type="checkbox" id=txt_chk1 style="position:relative;top:-2.5px;"></td>
								<td width="60px;">입사일자</td>
								<td width="100px;" height="16px"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_fr1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:1px;top:0px; width:70px; height:18px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
							    </object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fr1', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"></nobr>
								</td>
								<td align=center>&nbsp;~&nbsp;</td>
								<td width="100px;">
									<comment id="__NSID__"><object id=gcem_to1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:1px;top:0px; width:70px; height:18px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
							    </object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_to1', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">
								</td>
							</tr>
							<tr>
				  			<td width="30px;"><input type="checkbox" id=txt_chk7 style="position:relative;top:-4.5px;"></td>
								<td width="75px;" style="position:relative;top:-2.5px;">그룹일자</td>
								<td width="100px;" height="16px"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_fr7 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:1px;top:-2.5px; width:70px; height:18px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
							    </object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fr7', 'Text')" style="position:relative;width:20px;left:5px;top:-2.5px;cursor:hand;"></nobr>
								</td>
								<td align=center style="position:relative;top:-2.5px;">&nbsp;~&nbsp;</td>
								<td>
									<comment id="__NSID__"><object id=gcem_to7 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:1px;top:-2.5px; width:70px; height:18px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
							    </object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_to7', 'Text')" style="position:relative;width:20px;left:5px;top:-2.5px;cursor:hand;">
								</td>
							</tr>
							<tr>
				  			<td width="30px;"><input type="checkbox" id=txt_chk2 style="position:relative;top:-5.5px;"></td>
								<td width="75px;" style="position:relative;top:-4.5px;">승진일자</td>
								<td width="100px;" height="16px"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_fr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:1px;top:-3.5px; width:70px; height:18px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
							    </object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fr2', 'Text')" style="position:relative;width:20px;left:5px;top:-3.5px;cursor:hand;"></nobr>
								</td>
								<td align=center style="position:relative;top:-3.5px;">&nbsp;~&nbsp;</td>
								<td>
									<comment id="__NSID__"><object id=gcem_to2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:1px;top:-3.5px; width:70px; height:18px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
							    </object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_to2', 'Text')" style="position:relative;width:20px;left:5px;top:-3.5px;cursor:hand;">
								</td>
							</tr>
							<tr>
				  			<td width="30px;"><input type="checkbox" id=txt_chk3 style="position:relative;top:-7.5px;"></td>
								<td width="75px;" style="position:relative;top:-6.5px;">퇴사일자</td>
								<td width="100px;" height="16px"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_fr3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:1px;top:-4.5px; width:70px; height:18px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
							    </object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fr3', 'Text')" style="position:relative;width:20px;left:5px;top:-4.5px;cursor:hand;"></nobr>
								</td>
								<td align=center style="position:relative;top:-4.5px;">&nbsp;~&nbsp;</td>
								<td>
									<comment id="__NSID__"><object id=gcem_to3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:1px;top:-4.5px; width:70px; height:18px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
							    </object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_to3', 'Text')" style="position:relative;width:20px;left:5px;top:-4.5px;cursor:hand;">
								</td>
							</tr>
							<tr>
				  			<td width="30px;"><input type="checkbox" id=txt_chk4 style="position:relative;top:-7.5px;"></td>
								<td width="75px;" style="position:relative;top:-7.5px;">생년월일</td>
								<td width="100px;" height="16px"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_fr4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:1px;top:-5.5px; width:70px; height:18px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
							    </object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fr4', 'Text')" style="position:relative;width:20px;left:5px;top:-6.5px;cursor:hand;"></nobr>
								</td>
								<td align=center style="position:relative;top:-6.5px;">&nbsp;~&nbsp;</td>
								<td>
									<comment id="__NSID__"><object id=gcem_to4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:1px;top:-5.5px; width:70px; height:18px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
							    </object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_to4', 'Text')" style="position:relative;width:20px;left:5px;top:-6.5px;cursor:hand;">
								</td>
							</tr>
<!-- <div id=gcgd_orddt name=gcgd_orddt  style="position:relative;display:none"> -->
							<tr>
				  			<td width="30px;"><input type="checkbox" id=txt_chk6 style="position:relative;top:-10.5px;"></td>
								<td width="75px;" style="position:relative;top:-10.5px;">발령일자</td>
								<td width="100px;" height="16px"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_fr5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:1px;top:-7.5px; width:70px; height:18px;" class="txtbox">
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
							    </object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fr5', 'Text')" style="position:relative;width:20px;left:5px;top:-7.5px;cursor:hand;"></nobr>
								</td>
								<td align=center style="position:relative;top:-7.5px;">&nbsp;~&nbsp;</td>
								<td>
									<comment id="__NSID__"><object id=gcem_to5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:1px;top:-7.5px; width:70px; height:18px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
							    </object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_to5', 'Text')" style="position:relative;width:20px;left:5px;top:-7.5px;cursor:hand;">
								</td>
							</tr>
					  </table>
						</fieldset>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<!---------직원명부----------->
<div id=disp01 name=disp01 style="position:absolute;top:305px; left:170px; width:874px; height:300px; visibility:hidden">
  <table style="border:solid; border-width:0px;width:874px"  cellpadding=0 cellspacing=0 border=0 >
    <TR>
  	  <td height="300" width=97%  valign="top">
				<comment id="__NSID__"><object id="gcgd_disp1" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
					style="height:317; width:873; border:1 solid #777777" >
		        <param name=dataid					value=gcds_data1>
						<param name=borderstyle			value="0">
				    <param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=sortview    value=left>
		   			<param name=format          value='
							<F>ID=DEPTNM,		Name=소속명,				width=100,	HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left, sort = true</F>
							<F>ID=PAYGNM,		Name=직위명,				width=80,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left, sort = true</F>
							<F>ID=PAYSEQ,		Name=호봉,					width=50,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=center, Editstyle=lookup, Data="gcds_payseq:minorcd:minornm", sort = true</F>
							<F>ID=EMPNMK,		Name=성명,					width=60,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left ,sort = true	</F>
							<C>ID=EMPNO,		Name=사번,					width=60,		HeadBgColor=#B9D4DC, align=center ,sort = true</C>
							<C>ID=LAMDT,		Name=승진일,				width=80,		HeadBgColor=#B9D4DC, align=center, Mask="XXXX/XX/XX" ,sort = true</C>
							<C>ID=GRSTRTDT, Name=그룹입사일,		width=85,		HeadBgColor=#B9D4DC, align=center, Mask="XXXX/XX/XX" ,sort = true</C>
							<C>ID=STRTDT,		Name=입사일,				width=80,		HeadBgColor=#B9D4DC, align=center, Mask="XXXX/XX/XX" ,sort = true</C>
							<C>ID=BIRDT,		Name=생년월일,			width=80,		HeadBgColor=#B9D4DC, align=center, Mask="XXXX/XX/XX" ,sort = true</C>
							<C>ID=RESINO,		Name=주민등록번호,  width=100,	HeadBgColor=#B9D4DC, align=center, Mask="XXXXXX-XXXXXXX" ,sort = true</C>
							<C>ID=PERAGE,		Name=나이,					width=50,		HeadBgColor=#B9D4DC, align=center ,sort = true</C>
							<C>ID=DUYEAR,		Name=근속년,				width=60,		HeadBgColor=#B9D4DC, align=center ,sort = true</C>
							<C>ID=LSTEDU,		Name=최종학교명,		width=160,	HeadBgColor=#B9D4DC, align=left		,sort = true</C>
							<C>ID=EDCCNM,		Name=학력,		  width=160,	HeadBgColor=#B9D4DC, align=left		,sort = true</C>
							<C>ID=LSTHB,		Name=학과,      		width=160,	HeadBgColor=#B9D4DC, align=left		,sort = true</C>
							
							<C>ID=EDCDNM,		Name=학위,		  width=160,	HeadBgColor=#B9D4DC, align=left		,sort = true</C>
							<C>ID=GRAYY,		Name=졸업년도,			width=80,		HeadBgColor=#B9D4DC, align=center	,sort = true </C>
							<C>ID=DEPTPNM,	Name=근무지명,			width=100,	HeadBgColor=#B9D4DC, align=left		,sort = true</C>
							<C>ID=CADDR,		Name=현주소,				width=300,	HeadBgColor=#B9D4DC, align=left		,sort = true</C>
							<C>ID=TELNO,		Name=전화번호				width=97,		HeadBgColor=#B9D4DC, align=left		,sort = true</C>
							<C>ID=OFFTELNO, Name=사내번호,			width=70,		HeadBgColor=#B9D4DC, align=center ,sort = true</C>
							<C>ID=HPNO,			Name=모바일NO,			width=100,	HeadBgColor=#B9D4DC, align=left		,sort = true</C>
							<C>ID=ORDNM,		Name=발령구분,			width=80,		HeadBgColor=#B9D4DC, align=center ,sort = true</C>
							<C>ID=ORDDT,		Name=발령일자,			width=80,		HeadBgColor=#B9D4DC, align=center ,sort = true, Mask="XXXX/XX/XX"</C>
              <C>ID=DPOFFDT,	Name=부서발령,			width=80,		HeadBgColor=#B9D4DC, align=center ,sort = true, Mask="XXXX/XX/XX"</C>
              <C>ID=ENDDT,		Name=퇴사일자,			width=80,		HeadBgColor=#B9D4DC, align=center ,sort = true, Mask="XXXX/XX/XX"</C>
              <C>ID=EMAIL,		Name=EMAIL,	      	width=160,	HeadBgColor=#B9D4DC, align=left		,sort = true</C>
							<C>ID=NME,		  Name=영문명,			  width=100,  HeadBgColor=#B9D4DC, align=left   ,sort = true</C>
							<C>ID=CZIPCD,		Name=우편번호,			width=60,  HeadBgColor=#B9D4DC, align=center , Mask="XXX-XXX"</C>
							<C>ID=TELNO		  Name=자택전화,			width=85,  HeadBgColor=#B9D4DC, align=left   ,sort = true</C>
						'>
				</object></comment><script>__ws__(__NSID__);</script>
				<!--
							<C>ID=LRMDT,		Name=승급일,				width=80,		HeadBgColor=#B9D4DC, align=center, Mask="XXXX/XX/XX"</C>
				-->
				<fieldset style="width:875px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
					&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
				</fieldset>
			</td>
		</tr>
  </table>
</div>
<!---------경력인정자명부----------->
<div id=disp02 name=disp02 style="position:absolute;top:190px; left:2px; width:874px; height:300px; visibility:hidden">
  <table style="border:solid; border-width:0px;width:874px"  cellpadding=0 cellspacing=0 border=0 >
    <TR>
  	  <td height="300" width=97%  valign="top">
				<comment id="__NSID__"><object id="gcgd_disp2" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
					style="height:300; width:873; border:1 solid #777777" >
		        <param name=dataid value=gcds_data2>
						<param name=borderstyle value="0">
				    <param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=fontname        value=굴림>
						<param name=fontsize        value=9>
						<param name=sortview     value=left>
		   			<param name=format          value='
							<F>ID=EMPNO,		Name=사번,					width=60,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=center</F>
							<F>ID=EMPNMK,		Name=성명,					width=70,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left</F>
							<F>ID=DEPTNM,		Name=소속명,				width=80,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left</F>
							<F>ID=PAYGNM,		Name=직위명,				width=80,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left</F>
							<C>ID=PAYSEQ,		Name=호봉,					width=50,		HeadBgColor=#B9D4DC, align=center, Editstyle=lookup, Data="gcds_payseq:minorcd:minornm"</C>
							<C>ID=GRSTRTDT, Name=그룹입사일,		width=80,		HeadBgColor=#B9D4DC, align=center, Mask="XXXX/XX/XX"</C>
							<C>ID=STRTDT,		Name=입사일,				width=80,		HeadBgColor=#B9D4DC, align=center, Mask="XXXX/XX/XX"</C>
							<G>NAME="적용기간1", HeadBgColor=#B9D4DC
								<C>ID=, Name="시작일",  width=75, HeadBgColor=#B9D4DC, align=center,	Mask=XXXX/XX/XX </C>
								<C>ID=, Name="종료일",  width=75, HeadBgColor=#B9D4DC, align=center,	Mask=XXXX/XX/XX</C>
								<C>ID=, Name="적용율%", width=52, HeadBgColor=#B9D4DC, align=right </C>
							</G>
						 	<G>NAME="적용기간2", HeadBgColor=#B9D4DC
								<C>ID=, Name="시작일",  width=75, HeadBgColor=#B9D4DC, align=center,  Mask=XXXX/XX/XX </C>
								<C>ID=, Name="종료일",  width=75, HeadBgColor=#B9D4DC, align=center,  Mask=XXXX/XX/XX </C>
								<C>ID=, Name="적용율%",  width=52, HeadBgColor=#B9D4DC, align=right </C>
							</G>
						'>
				</object></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:875px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
					&nbsp;<font id=ft_cnt2 style="position:relative;top:3px;"></font>
				</fieldset>
			</td>
		</tr>
  </table>
</div>
<!---------수당지급자명부----------->
<div id=disp03 name=disp03 style="position:absolute;top:190px; left:2px;width:874px; height:300px; visibility:hidden">
  <table style="border:solid; border-width:0px;width:874px"  cellpadding=0 cellspacing=0 border=0 >
    <tr>
  	  <td height="300" width=97%  valign="top">
				<comment id="__NSID__"><object id="gcgd_disp3" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
					style="height:298; width:873; border:1 solid #777777" >
		        <param name=dataid value=gcds_data3>
						<param name=borderstyle value="0">
				    <param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=fontname        value=굴림>
						<param name=fontsize        value=9>
						<param name=sortview     value=left>
		   			<param name=format          value='
							<F>ID=EMPNO,		Name=사번,					width=60,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=center</F>
							<F>ID=EMPNMK,		Name=성명,					width=70,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left</F>
							<F>ID=DEPTNM,		Name=소속명,				width=80,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left</F>
							<F>ID=PAYGNM,		Name=직위명,				width=80,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left</F>
 							<G>NAME="적용수당", HeadBgColor=#B9D4DC
								<C>ID=, Name="수당수",  width=47, HeadBgColor=#B9D4DC, align=right</C>
						    <C>ID=, Name="합계액",  width=80, HeadBgColor=#B9D4DC, align=right</C>
								<C>ID=, Name="수당1",  width=88,HeadBgColor=#B9D4DC, align=right</C>
								<C>ID=, Name="수당2",  width=88,HeadBgColor=#B9D4DC, align=right</C>
								<C>ID=, Name="수당3",  width=88, HeadBgColor=#B9D4DC, align=right</C>
								<C>ID=, Name="수당4",  width=88, HeadBgColor=#B9D4DC, align=right</C>
								<C>ID=, Name="수당5",  width=88, HeadBgColor=#B9D4DC, align=right</C>
							</G>
						'>
				</object></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:875px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
					&nbsp;<font id=ft_cnt3 style="position:relative;top:3px;"></font>
				</fieldset>
			</td>
		</tr>
  </table>
</div>
<!---------면허및특기자명부----------->
<div id=disp04 name=disp04 style="position:absolute;top:190px; left:2px;width:874px; height:300px; visibility:hidden">
  <table style="border:solid; border-width:0px;width:874px"  cellpadding=0 cellspacing=0 border=0 >
    <TR >
  	  <td height="300" width=97%  valign="top">
				<comment id="__NSID__"><object id="gcgd_disp4" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
					style="height:319; width:873; border:1 solid #777777" >
		        <param name=dataid value=gcds_data4>
						<param name=borderstyle value="0">
				    <param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=fontname        value=굴림>
						<param name=fontsize        value=9>
						<param name=sortview     value=left>
		   			<param name=format          value='
							<F>ID=DEPTNM,		Name=소속명,				width=100,	HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left </F>
							<F>ID=PAYGNM,		Name=직위명,				width=80,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left </F>
							<F>ID=PAYSEQ,		Name=호봉,					width=50,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=center, Editstyle=lookup, Data="gcds_payseq:minorcd:minornm"</F>
							<F>ID=EMPNMK,		Name=성명,					width=60,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left</F>
							<C>ID=EMPNO,		Name=사번,					width=60,		HeadBgColor=#B9D4DC, align=center</C>
						  <C>ID=LCSTNM,		Name="면허 및 자격증명", width=160, HeadBgColor=#B9D4DC, align=left</C>
					    <C>ID=GETDT,		Name="취득일자",  width=80, HeadBgColor=#B9D4DC, align=center,  Mask="XXXX/XX/XX"</C>
					    <C>ID=LCSNO,		Name="증번호",  width=120, HeadBgColor=#B9D4DC, align=left</C>
						  <C>ID=ISSPART,	Name="발행처",  width=147, HeadBgColor=#B9D4DC, align=left</C>
						'>
				</object></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:875px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
					&nbsp;<font id=ft_cnt4 style="position:relative;top:3px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</div>
<!---------신원보증명부----------->
<div id=disp05 name=disp05 style="position:absolute;top:190px; left:2px;width:874px; height:300px; visibility:hidden">
  <table style="border:solid; border-width:0px;width:874px"  cellpadding=0 cellspacing=0 border=0 >
    <TR>
  	  <td height="300" width=97%  valign="top">
				<comment id="__NSID__"><object id="gcgd_disp5" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
					style="height:317; width:873; border:1 solid #777777" >
		        <param name=dataid value=gcds_data5>
						<param name=borderstyle value="0">
				    <param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=fontname        value=굴림>
						<param name=fontsize        value=9>
						<param name=sortview     value=left>
		   			<param name=format          value='
							<F>ID=DEPTNM,		Name=소속명,			width=100,	HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left</F>
							<F>ID=PAYGNM,		Name=직위명,			width=80,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left</F>
							<F>ID=PAYSEQ,		Name=호봉,				width=50,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=center, Editstyle=lookup, Data="gcds_payseq:minorcd:minornm"</F>
							<F>ID=EMPNMK,		Name=성명,				width=60,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left</F>
							<C>ID=EMPNO,		Name=사번,				width=60,		HeadBgColor=#B9D4DC, align=center</C>
						  <C>ID=AFRDT,		Name="시작일",		width=75,		HeadBgColor=#B9D4DC, align=center,  Mask="XXXX/XX/XX"</C>
							<C>ID=ATODT,		Name="종료일",		width=75,		HeadBgColor=#B9D4DC, align=center,  Mask="XXXX/XX/XX"</C>
					    <C>ID=ASSINST,	Name="보증기관",	width=120,	HeadBgColor=#B9D4DC, align=left </C>
					    <C>ID=ASSNO,		Name="증번호",		width=120,	HeadBgColor=#B9D4DC, align=left </C>
					    <C>ID=ASSAMT,		Name="보증금액",	width=90,		HeadBgColor=#B9D4DC, align=right </C>
					    <C>ID=RECPAMT,	Name="보험료/납세액", width=87,		HeadBgColor=#B9D4DC, align=right </C>
						  <C>ID=TELNO,		Name="연락처",				width=90,		HeadBgColor=#B9D4DC, align=left </C>
							<C>ID=CADDR,		Name="주소",					width=390,	HeadBgColor=#B9D4DC, align=left </C>
						'>
				</object></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:875px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
					&nbsp;<font id=ft_cnt5 style="position:relative;top:3px;"></font>
				</fieldset>
			</td>
		</tr>
  </table>
</div>
<!---------주소록명부----------->
<div id=disp06 name=disp06 style="position:absolute;top:190px; left:2px;width:874px; height:300px; visibility:hidden">
  <table style="border:solid; border-width:0px;width:874px"  cellpadding=0 cellspacing=0 border=0 >
    <tr>
  	  <td height="300" width=97%  valign="top">
				<comment id="__NSID__"><object id="gcgd_disp6" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
					style="height:319; width:873; border:1 solid #777777" >
		        <param name=dataid value=gcds_data6>
						<param name=borderstyle value="0">
				    <param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=fontname        value=굴림>
						<param name=fontsize        value=9>
						<param name=sortview     value=left>
		   			<param name=format          value='
							<F>ID=DEPTNM,		Name=소속명,				width=100,	HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left ,sort = true</F>
							<F>ID=PAYGNM,		Name=직위명,				width=80,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left ,sort = true</F>
							<F>ID=PAYSEQ,		Name=호봉,					width=50,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=center, Editstyle=lookup, Data="gcds_payseq:minorcd:minornm" ,sort = true</F>
							<F>ID=EMPNMK,		Name=성명,					width=60,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left ,sort = true</F>
							<C>ID=EMPNO,		Name=사번,					width=60,		HeadBgColor=#B9D4DC, align=center ,sort = true</C>
					    <C>ID=CADDR,		Name="현주소",			width=270,	HeadBgColor=#B9D4DC, align=left		,sort = true</C>
					    <C>ID=TELNO,		Name="전화번호"			width=87,		HeadBgColor=#B9D4DC, align=left		,sort = true</C>
						  <C>ID=OFFTELNO, Name="사내번호",		width=65,		HeadBgColor=#B9D4DC, align=center ,sort = true</C>
							<C>ID=HPNO,			Name="모바일NO",		width=85,		HeadBgColor=#B9D4DC, align=left		,sort = true</C>
						'>
				</object></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:875px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
					&nbsp;<font id=ft_cnt6 style="position:relative;top:3px;"></font>
				</fieldset>
			</td>
		</tr>
  </table>
</div>

<!---------별정직----------->
<div id=disp07 name=disp07 style="position:absolute;top:190px; left:2px;width:874px; height:300px; visibility:hidden">
  <table style="border:solid; border-width:0px;width:874px"  cellpadding=0 cellspacing=0 border=0 >
    <tr>
  	  <td height="300" width=97%  valign="top">
				<comment id="__NSID__"><object id="gcgd_disp7" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
					style="height:319; width:873; border:1 solid #777777" >
		        <param name=dataid					value=gcds_data7>
						<param name=borderstyle			value="0">
				    <param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=fontname        value=굴림>
						<param name=fontsize        value=9>
						<param name=sortview     value=left>
		   			<param name=format          value='
							<F>ID=DEPTNM,		Name=소속명,				width=120,	HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left ,sort = true</F>
							<F>ID=PAYGNM,		Name=직위명,				width=80,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left ,sort = true</F>
							<F>ID=EMPNMK,		Name=성명,					width=60,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left ,sort = true</F>
							<C>ID=STRTDT,		Name=입사일,				width=80,		HeadBgColor=#B9D4DC, align=center, Mask="XXXX/XX/XX" ,sort = true</C>
							<C>ID=RESINO,		Name=주민등록번호,  width=100,	HeadBgColor=#B9D4DC, align=center, Mask="XXXXXX-XXXXXXX" ,sort = true</C>
							<C>ID=DEPTPNM,	Name=근무지명,			width=150,	HeadBgColor=#B9D4DC, align=left		,sort = true</C>
							<C>ID=TELNO,		Name=전화번호				width=97,		HeadBgColor=#B9D4DC, align=left		,sort = true</C>
							<C>ID=OFFTELNO, Name=사내번호,			width=70,		HeadBgColor=#B9D4DC, align=center ,sort = true</C>
							<C>ID=HPNO,			Name=모바일NO,			width=100,	HeadBgColor=#B9D4DC, align=left		,sort = true</C>
						'>
				</object></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:875px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
					&nbsp;<font id=ft_cnt7 style="position:relative;top:3px;"></font>
				</fieldset>
			</td>
		</tr>
  </table>
</div>

<!---------별정직----------->
<div id=disp08 name=disp08 style="position:absolute;top:190px; left:2px;width:874px; height:300px; visibility:hidden">
  <table style="border:solid; border-width:0px;width:874px"  cellpadding=0 cellspacing=0 border=0 >
    <tr>
  	  <td height="300" width=97%  valign="top">
				<comment id="__NSID__"><object id="gcgd_print" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="height:317; width:873; border:1 solid #777777" >
					<param name=dataid					value=gcds_print>
					<param name=borderstyle			value="0">
					<param name=indwidth        value=0>
					<param name=enable	        value=false>
					<param name=fillarea        value=true>
					<param name=sortview				value=left>
					<param name=format          value='
						<C>ID=DEPTNM,		Name=소속명,				width=100,	HeadBgColor=#B9D4DC, align=left</C>
						<C>ID=CNT,			Name=인원,					width=80,		HeadBgColor=#B9D4DC, align=center</C>
						<C>ID=PAYGNM,		Name=직위,					width=50,		HeadBgColor=#B9D4DC, align=center</C>
						<C>ID=PAYSEQ,		Name=급호,					width=50,		HeadBgColor=#B9D4DC, align=center</C>
						<C>ID=SEX,			Name=성별,					width=60,		HeadBgColor=#B9D4DC, align=center</C>
						<C>ID=EMPNMK,		Name=성명,					width=60,		HeadBgColor=#B9D4DC, align=left</C>
						<C>ID=GRSTRTDT,	Name=그룹입사일,		width=80,		HeadBgColor=#B9D4DC, align=center,	Mask="XXXX/XX/XX"</C>
						<C>ID=STRTDT,		Name=입사일,				width=80,		HeadBgColor=#B9D4DC, align=center,	Mask="XXXX/XX/XX"</C>
						<C>ID=LAMDT,		Name=최종승진일,		width=80,		HeadBgColor=#B9D4DC, align=center,	Mask="XXXX/XX/XX"</C>
						<C>ID=BIRDT,		Name=생년월일,			width=100,	HeadBgColor=#B9D4DC, align=center,	Mask="XXXX/XX/XX"</C>
						<C>ID=PERAGE,		Name=나이,					width=40,		HeadBgColor=#B9D4DC, align=center</C>
						<C>ID=LSTEDU,		Name=출신교학교,		width=40,		HeadBgColor=#B9D4DC, align=left</C>
						<C>ID=EDCCNM,		Name=학력,		      width=160,	HeadBgColor=#B9D4DC, align=left		,sort = true</C>
						<C>ID=LSTHB,		Name=전공학과,			width=40,		HeadBgColor=#B9D4DC, align=left</C>
						
						<C>ID=EDCDNM,		Name=학위,		  width=160,	HeadBgColor=#B9D4DC, align=left		,sort = true</C>
						<C>ID=EMPNO,		Name=사번,					width=160,	HeadBgColor=#B9D4DC, align=left</C>
					'>
				</object></comment><script>__ws__(__NSID__);</script>
				<fieldset style="width:875px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
					&nbsp;<font id=ft_cnt7 style="position:relative;top:3px;"></font>
				</fieldset>
			</td>
		</tr>
  </table>
</div>

<!-----------------------------------------------------------------------------------------
출력물 정의부분 Ⅰ : 전체 소속별 조회
--------------------------------------------------------------------------------------->
<comment id="__NSID__"><object id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_print">
	<param name=DetailDataID      value="gcds_print">
	<!-- <param name=BandColumn        value=BANDOK>
	<param name=BandSelection     value="band1:band;default:default;"> -->
	<param name=NullRecordFlag    value=True>
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="true">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=216 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1025 ,top=34 ,right=1863 ,bottom=109 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=0 ,top=156 ,right=106 ,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1972 ,top=156 ,right=2069 ,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=2066 ,top=156 ,right=2650 ,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='출신교' ,left=2069 ,top=162 ,right=2447 ,bottom=216 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=841 ,top=156 ,right=928 ,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=756 ,top=156 ,right=844 ,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1753 ,top=156 ,right=1975 ,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=925 ,top=156 ,right=1109 ,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1016 ,top=22 ,right=1850 ,bottom=100 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='나이' ,left=1978 ,top=162 ,right=2063 ,bottom=216 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=2647 ,top=156 ,right=2816 ,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='사번' ,left=2650 ,top=162 ,right=2813 ,bottom=216 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='성별' ,left=847 ,top=162 ,right=922 ,bottom=216 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1106 ,top=156 ,right=1325 ,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='생년월일' ,left=1759 ,top=162 ,right=1969 ,bottom=216 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='급호' ,left=763 ,top=162 ,right=838 ,bottom=216 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='성명' ,left=931 ,top=162 ,right=1106 ,bottom=216 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=103 ,top=156 ,right=494 ,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='순' ,left=6 ,top=162 ,right=100 ,bottom=216 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<L> left=2816 ,top=156 ,right=2816 ,bottom=216 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=3 ,top=153 ,right=3 ,bottom=212 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<X>left=569 ,top=156 ,right=759 ,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=569 ,top=156 ,right=759 ,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='소속' ,left=109 ,top=162 ,right=488 ,bottom=216 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='직위' ,left=575 ,top=162 ,right=753 ,bottom=216 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='본부-소속-소속별 인원현황' ,left=1019 ,top=25 ,right=1844 ,bottom=81 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<X>left=1322 ,top=156 ,right=1541 ,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='입사일' ,left=1328 ,top=162 ,right=1534 ,bottom=216 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=491 ,top=156 ,right=572 ,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='인원' ,left=497 ,top=162 ,right=566 ,bottom=216 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1538 ,top=156 ,right=1756 ,bottom=216 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='최종승진일' ,left=1544 ,top=162 ,right=1750 ,bottom=216 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='그룹입사일' ,left=1113 ,top=162 ,right=1319 ,bottom=216 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<L> left=0 ,top=156 ,right=2816 ,bottom=156 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=0 ,top=216 ,right=2816 ,bottom=216 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='CURDT', left=2400, top=56, right=2809, bottom=134, align='right' ,mask='XXXX년XX월XX일', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2450 ,top=156 ,right=2450 ,bottom=216 </L>
	<T>id='전공학과' ,left=2456 ,top=162 ,right=2644 ,bottom=216 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
</B>
<B>id=default ,left=0,top=0 ,right=2869 ,bottom=59 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=103 ,top=0 ,right=103 ,bottom=59 </L>
	<L> left=572 ,top=0 ,right=572 ,bottom=59 </L>
	<L> left=759 ,top=0 ,right=759 ,bottom=59 </L>
	<L> left=2066 ,top=0 ,right=2066 ,bottom=59 </L>
	<L> left=2450 ,top=0 ,right=2450 ,bottom=59 </L>
	<L> left=2647 ,top=0 ,right=2647 ,bottom=59 </L>
	<L> left=925 ,top=0 ,right=925 ,bottom=59 </L>
	<L> left=1109 ,top=0 ,right=1109 ,bottom=59 </L>
	<L> left=1322 ,top=0 ,right=1322 ,bottom=59 </L>
	<L> left=1538 ,top=0 ,right=1538 ,bottom=59 </L>
	<L> left=1756 ,top=0 ,right=1756 ,bottom=59 </L>
	<L> left=1975 ,top=0 ,right=1975 ,bottom=59 </L>
	<L> left=844 ,top=0 ,right=844 ,bottom=59 </L>
	<L> left=491 ,top=0 ,right=491 ,bottom=59 </L>
	<C>id='{decode (SEQ,'0','',SEQ)}', left=6, top=0, right=100, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PGCNM', left=2453, top=0, right=2644, bottom=56, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='LSTEDU', left=2069, top=0, right=2447, bottom=56, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='LSTHD', left=2069, top=0, right=2447, bottom=56, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode (PERAGE,'0','',PERAGE)}', left=1978, top=0, right=2063, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BIRDT', left=1759, top=0, right=1972, bottom=56 ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='LAMDT', left=1541, top=0, right=1753, bottom=56 ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='STRTDT', left=1325, top=0, right=1538, bottom=56 ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='GRSTRTDT', left=1116, top=0, right=1319, bottom=56 ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='EMPNMK', left=928, top=0, right=1106, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode (SEX,'1','남','2','여','')}', left=847, top=0, right=922, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='PAYSEQ', left=763, top=0, right=841, bottom=56 ,mask='XX호', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='PAYGNM', left=575, top=0, right=756, bottom=56, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode (CNT,'0','',CNT)}', left=497, top=0, right=569, bottom=56, face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNO', left=2650, top=0, right=2813, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTNM', left=109, top=0, right=488, bottom=56, align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=0 ,top=0 ,right=0 ,bottom=59 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2816 ,top=0 ,right=2816 ,bottom=59 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2450 ,top=0 ,right=2450 ,bottom=59 </L>
	<L> left=2450 ,top=0 ,right=2450 ,bottom=59 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2869 ,bottom=100 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=0 ,top=0 ,right=2816 ,bottom=0 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=0 ,top=16 ,right=2816 ,bottom=16 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=1106 ,top=19 ,right=1813 ,bottom=59</T>
	<I>id='../../Common/img/icon.jpg' ,left=2444 ,top=19 ,right=2822 ,bottom=100</I>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------------------
출력물 정의부분 Ⅱ : 개인기본정보 출력
--------------------------------------------------------------------------------------->
<comment id="__NSID__"><object id=gcrp_print2 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
  <PARAM NAME="MasterDataID"			VALUE="gcds_print2">
  <PARAM NAME="DetailDataID"			VALUE="gcds_print2">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
  <PARAM NAME="Landscape"					VALUE="False">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            VALUE="

	">
</object></comment><script>__ws__(__NSID__);</script>

</BODY>
</HTML>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

<!--<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=204 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='인 사 기 본 정 보' ,left=597 ,top=9 ,right=1406 ,bottom=116 ,face='HY헤드라인M' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=703 ,top=125 ,right=1297 ,bottom=125 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='CURDT', left=1516, top=141, right=1959, bottom=197, align='right' ,mask='발행일자 : XXXX/XX/XX', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=488 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=0 ,top=325 ,right=1963 ,bottom=453 ,border=true</X>
	<X>left=0 ,top=325 ,right=144 ,bottom=453 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=325 ,top=0 ,right=513 ,bottom=66 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=509 ,top=0 ,right=1963 ,bottom=0 </L>
	<X>left=325 ,top=62 ,right=513 ,bottom=128 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=325 ,top=125 ,right=513 ,bottom=191 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=325 ,top=187 ,right=513 ,bottom=253 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=325 ,top=250 ,right=513 ,bottom=312 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='소속발령' ,left=334 ,top=194 ,right=506 ,bottom=244 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='소속/직위' ,left=334 ,top=131 ,right=506 ,bottom=181 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='주민번호' ,left=334 ,top=69 ,right=506 ,bottom=119 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='성   명' ,left=334 ,top=6 ,right=506 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=509 ,top=62 ,right=1963 ,bottom=62 </L>
	<L> left=509 ,top=125 ,right=1963 ,bottom=125 </L>
	<L> left=509 ,top=187 ,right=1963 ,bottom=187 </L>
	<L> left=509 ,top=250 ,right=1963 ,bottom=250 </L>
	<C>id='RESINO', left=516, top=69, right=950, bottom=119, align='left' ,mask='XXXXXX-XXXXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='PAYGNM', left=763, top=131, right=950, bottom=181, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=0 ,top=0 ,right=328 ,bottom=312 ,border=true</X>
	<T>id='그룹입사일' ,left=334 ,top=256 ,right=506 ,bottom=306 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<X>left=956 ,top=62 ,right=1144 ,bottom=128 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=956 ,top=125 ,right=1144 ,bottom=191 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=956 ,top=187 ,right=1144 ,bottom=253 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=956 ,top=250 ,right=1144 ,bottom=312 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='생년월일' ,left=963 ,top=69 ,right=1134 ,bottom=119 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='급   호' ,left=963 ,top=131 ,right=1134 ,bottom=181 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='직위발령일' ,left=963 ,top=194 ,right=1134 ,bottom=244 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='입사일' ,left=963 ,top=256 ,right=1134 ,bottom=306 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='BIRDT', left=1150, top=69, right=1438, bottom=119, align='left' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='PAYSNM', left=1150, top=131, right=1438, bottom=181, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTNM', left=516, top=131, right=756, bottom=181, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ORDDT', left=1150, top=194, right=1438, bottom=244, align='left' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='STRTDT', left=1150, top=256, right=1438, bottom=306, align='left' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<X>left=1475 ,top=0 ,right=1663 ,bottom=62 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='GLDIVNM', left=1478, top=69, right=1631, bottom=119, align='right' ,mask=' / ', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SEXNM', left=1638, top=69, right=1791, bottom=119, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=1475 ,top=125 ,right=1663 ,bottom=191 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1475 ,top=187 ,right=1663 ,bottom=253 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1475 ,top=250 ,right=1663 ,bottom=312 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='퇴사일' ,left=1481 ,top=256 ,right=1653 ,bottom=306 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='승진일' ,left=1481 ,top=194 ,right=1653 ,bottom=244 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='직   종' ,left=1481 ,top=131 ,right=1653 ,bottom=181 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='JOBNM', left=1669, top=131, right=1956, bottom=181, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='LAMDT', left=1669, top=194, right=1956, bottom=244, align='left' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='ENDDT', left=1669, top=256, right=1956, bottom=306, align='left' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='DPOFFDT', left=516, top=194, right=803, bottom=244, align='left' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='GRSTRTDT', left=516, top=256, right=803, bottom=306, align='left' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<X>left=141 ,top=325 ,right=328 ,bottom=391 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=141 ,top=387 ,right=328 ,bottom=453 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='입사구분' ,left=147 ,top=331 ,right=322 ,bottom=381 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='정' ,left=3 ,top=391 ,right=66 ,bottom=434 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='기' ,left=6 ,top=341 ,right=69 ,bottom=384 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='본' ,left=72 ,top=341 ,right=134 ,bottom=384 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='보' ,left=69 ,top=391 ,right=131 ,bottom=434 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='주   소' ,left=147 ,top=394 ,right=322 ,bottom=447 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='EDIVNM', left=334, top=331, right=622, bottom=381, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=325 ,top=387 ,right=1959 ,bottom=387 </L>
	<C>id='EMPADD', left=334, top=394, right=1469, bottom=447, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=1475 ,top=325 ,right=1663 ,bottom=391 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1475 ,top=387 ,right=1663 ,bottom=453 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='혈액형' ,left=1481 ,top=331 ,right=1653 ,bottom=381 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='전화번호' ,left=1481 ,top=394 ,right=1653 ,bottom=447 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='BLOOD', left=1669, top=331, right=1956, bottom=381, align='left' ,mask='XX형', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TELNO', left=1669, top=394, right=1956, bottom=447, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SCHNM', left=1150, top=331, right=1438, bottom=381, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='사   번' ,left=1481 ,top=6 ,right=1653 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<X>left=956 ,top=325 ,right=1144 ,bottom=387 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='NMC', left=734, top=6, right=953, bottom=56, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=516, top=6, right=728, bottom=56, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NME', left=963, top=6, right=1444, bottom=56, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='출신교' ,left=963 ,top=331 ,right=1134 ,bottom=384 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=513 ,top=312 ,right=1963 ,bottom=312 </L>
	<L> left=1963 ,top=0 ,right=1963 ,bottom=312 </L>
	<L> left=0 ,top=466 ,right=1959 ,bottom=466 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='EMPNO', left=1669, top=6, right=1956, bottom=56, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='Image' ,left=0 ,top=3 ,right=328 ,bottom=312</I>
</B>
<B>id=Footer ,left=0,top=2750 ,right=2000 ,bottom=2800 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=1594 ,top=30 ,right=1974 ,bottom=130</I>
	<L> left=0 ,top=20	,right=1974 ,bottom=20, penstyle=solid, penwidth=2 </L>
	<T> id='#p/#t' left=0 ,top=30 ,right=1974 ,bottom=110</T>
</B>-->
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>