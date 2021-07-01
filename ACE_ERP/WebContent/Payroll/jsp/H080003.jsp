<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	계약직/인사정보분석
+ 프로그램 ID	: H080003.HTML
+ 기 능 정 의	: 조회,출력
+ 변 경 이 력	: 
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>

<html>
<head>
     <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>인사정보분석</title>


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



var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
var gs_date2 = gcurdate.substr(0,4)+ "/" + gcurdate.substr(5,2)+ "/" + gcurdate.substr(8,2);

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	cfInitXChart13(gcxc_chart1);
	cfInitXChart15(gcxc_chart2);

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	gcds_data.DataID = "/servlet/Contract.h080003_s1?"
	//prompt('',gcds_data.DataID);
	gcds_data.Reset();
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
function ln_Print(){
	var	row = gcds_data.rowposition;
	if (gcds_data.countrow<1) alert("출력하실 자료가 없습니다");
	else {
		ln_Format();
		gcrp_print.preview();
	}
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description :
******************************************************************************/
function ln_Format(){
	var ls_html = "";

ls_html += "	  <B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=341 ,face='Arial' ,size=10 ,penwidth=1	";
ls_html += "	  <X>left=0 ,top=222 ,right=2834 ,bottom=341 ,border=true ,penstyle=solid ,penwidth=2</X>	";
ls_html += "	  <X>left=2548 ,top=278 ,right=2651 ,bottom=339 ,backcolor=#CCCCCC ,border=true ,penstyle=solid ,penwidth=1</X>	";
ls_html += "	  <T>id='계' ,left=2551 ,top=278 ,right=2651 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#CCCCCC</T>	";
ls_html += "	  <T>id='소 속' ,left=5 ,top=249 ,right=410 ,bottom=315 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <L> left=410 ,top=222 ,right=410 ,bottom=341 </L>	";
ls_html += "	  <L> left=410 ,top=275 ,right=2651 ,bottom=275 </L>	";
ls_html += "	  <L> left=1191 ,top=116 ,right=1640 ,bottom=116 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>	";
ls_html += "	  <T>id='인 사 정 보 분 석' ,left=0 ,top=19 ,right=2834 ,bottom=114 ,face='HY견고딕' ,size=18 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='기준년월 :' ,left=0 ,top=148 ,right=201 ,bottom=214 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "		<T>id='" + gs_date.substring(0,4) + "년 " + gs_date.substring(4,6) + "월 " + "' ,left=200, top=148, right=553, bottom=214, align='left', face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align=left</T> ";
ls_html += "	  <L> left=2651 ,top=222 ,right=2651 ,bottom=341 </L>	";
ls_html += "	  <T>id='합계' ,left=2654 ,top=249 ,right=2831 ,bottom=315 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <L> left=503 ,top=275 ,right=503 ,bottom=341 </L>	";
ls_html += "	  <L> left=595 ,top=275 ,right=595 ,bottom=341 </L>	";
ls_html += "	  <L> left=781 ,top=275 ,right=781 ,bottom=341 </L>	";
ls_html += "	  <L> left=873 ,top=275 ,right=873 ,bottom=341 </L>	";
ls_html += "	  <L> left=966 ,top=275 ,right=966 ,bottom=341 </L>	";
ls_html += "	  <L> left=1058 ,top=275 ,right=1058 ,bottom=341 </L>	";
ls_html += "	  <L> left=688 ,top=275 ,right=688 ,bottom=341 </L>	";
ls_html += "	  <T>id='계' ,left=1061 ,top=278 ,right=1154 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B0B0B0</T>	";
ls_html += "	  <L> left=1990 ,top=275 ,right=1990 ,bottom=341 </L>	";
ls_html += "	  <L> left=2082 ,top=275 ,right=2082 ,bottom=341 </L>	";
ls_html += "	  <L> left=2175 ,top=275 ,right=2175 ,bottom=341 </L>	";
ls_html += "	  <L> left=1897 ,top=222 ,right=1897 ,bottom=341 </L>	";
ls_html += "	  <L> left=1154 ,top=222 ,right=1154 ,bottom=341 </L>	";
ls_html += "	  <T>id='차장' ,left=598 ,top=278 ,right=688 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='과장' ,left=691 ,top=278 ,right=781 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='대리' ,left=783 ,top=278 ,right=873 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='사원' ,left=876 ,top=278 ,right=966 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='기타' ,left=968 ,top=278 ,right=1058 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='한국인기능직' ,left=413 ,top=225 ,right=1154 ,bottom=275 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='부장' ,left=505 ,top=278 ,right=595 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <X>left=1804 ,top=278 ,right=1897 ,bottom=339 ,backcolor=#CCCCCC ,border=true ,penstyle=solid ,penwidth=1</X>	";
ls_html += "	  <L> left=1431 ,top=275 ,right=1431 ,bottom=341 </L>	";
ls_html += "	  <L> left=1802 ,top=275 ,right=1802 ,bottom=341 </L>	";
ls_html += "	  <L> left=1709 ,top=275 ,right=1709 ,bottom=341 </L>	";
ls_html += "	  <L> left=1617 ,top=275 ,right=1617 ,bottom=341 </L>	";
ls_html += "	  <L> left=1524 ,top=275 ,right=1524 ,bottom=341 </L>	";
ls_html += "	  <L> left=1339 ,top=275 ,right=1339 ,bottom=341 </L>	";
ls_html += "	  <L> left=1249 ,top=275 ,right=1249 ,bottom=341 </L>	";
ls_html += "	  <T>id='임원' ,left=1156 ,top=278 ,right=1246 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='부장' ,left=1251 ,top=278 ,right=1339 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='차장' ,left=1341 ,top=278 ,right=1431 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='과장' ,left=1434 ,top=278 ,right=1524 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='대리' ,left=1527 ,top=278 ,right=1617 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='사원' ,left=1619 ,top=278 ,right=1709 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='기타' ,left=1712 ,top=278 ,right=1802 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='파견근로자' ,left=1156 ,top=225 ,right=1897 ,bottom=275 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='임원' ,left=1900 ,top=278 ,right=1990 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='부장' ,left=1992 ,top=278 ,right=2082 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='차장' ,left=2085 ,top=278 ,right=2175 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='과장' ,left=2178 ,top=278 ,right=2262 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='재중동포' ,left=1900 ,top=225 ,right=2651 ,bottom=275 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <X>left=1061 ,top=278 ,right=1154 ,bottom=339 ,backcolor=#CCCCCC ,border=true ,penstyle=solid ,penwidth=1</X>	";
ls_html += "	  <T>id='계' ,left=1804 ,top=278 ,right=1897 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#CCCCCC</T>	";
ls_html += "	  <T>id='임원' ,left=413 ,top=278 ,right=503 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <T>id='계' ,left=1061 ,top=278 ,right=1154 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#CCCCCC</T>	";
ls_html += "	  <L> left=2265 ,top=275 ,right=2265 ,bottom=341 </L>	";
ls_html += "	  <T>id='대리' ,left=2270 ,top=278 ,right=2360 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <L> left=2360 ,top=275 ,right=2360 ,bottom=341 </L>	";
ls_html += "	  <T>id='사원' ,left=2363 ,top=278 ,right=2453 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <L> left=2453 ,top=275 ,right=2453 ,bottom=341 </L>	";
ls_html += "	  <T>id='기타' ,left=2455 ,top=278 ,right=2545 ,bottom=339 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	";
ls_html += "	  <L> left=2545 ,top=275 ,right=2545 ,bottom=341 </L>	";
ls_html += "	</B>	";
ls_html += "	<B>id=default ,left=0,top=0 ,right=2871 ,bottom=56 ,face='Arial' ,size=10 ,penwidth=1	";
ls_html += "	  <X>left=2651 ,top=0 ,right=2836 ,bottom=56 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>	";
ls_html += "	  <C>id='T25', left=2656, top=0, right=2834, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#B1B1B1</C>	";
ls_html += "	  <X>left=2548 ,top=0 ,right=2651 ,bottom=56 ,backcolor=#CCCCCC ,border=true ,penstyle=solid ,penwidth=1</X>	";
ls_html += "	  <C>id='T24', left=2551, top=0, right=2643, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#CCCCCC</C>	";
ls_html += "	  <C>id='T24', left=2551, top=0, right=2648, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#CCCCCC</C>	";
ls_html += "	  <L> left=0 ,top=0 ,right=0 ,bottom=56 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	";
ls_html += "	  <L> left=2834 ,top=0 ,right=2834 ,bottom=56 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	";
ls_html += "	  <L> left=0 ,top=56 ,right=2834 ,bottom=56 </L>	";
ls_html += "	  <L> left=410 ,top=0 ,right=410 ,bottom=56 </L>	";
ls_html += "	  <L> left=2651 ,top=0 ,right=2651 ,bottom=56 </L>	";
ls_html += "	  <C>id='DEPTNM', left=5, top=0, right=410, bottom=56, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <L> left=688 ,top=0 ,right=688 ,bottom=56 </L>	";
ls_html += "	  <C>id='T1', left=413, top=0, right=503, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <L> left=503 ,top=0 ,right=503 ,bottom=56 </L>	";
ls_html += "	  <C>id='T2', left=505, top=0, right=595, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <L> left=595 ,top=0 ,right=595 ,bottom=56 </L>	";
ls_html += "	  <C>id='T3', left=598, top=0, right=688, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <C>id='T4', left=691, top=0, right=781, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <L> left=781 ,top=0 ,right=781 ,bottom=56 </L>	";
ls_html += "	  <C>id='T5', left=783, top=0, right=873, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <L> left=873 ,top=0 ,right=873 ,bottom=56 </L>	";
ls_html += "	  <C>id='T6', left=876, top=0, right=966, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <L> left=966 ,top=0 ,right=966 ,bottom=56 </L>	";
ls_html += "	  <C>id='T7', left=968, top=0, right=1058, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <L> left=1058 ,top=0 ,right=1058 ,bottom=56 </L>	";
ls_html += "	  <L> left=1154 ,top=0 ,right=1154 ,bottom=56 </L>	";
ls_html += "	  <L> left=1249 ,top=0 ,right=1249 ,bottom=56 </L>	";
ls_html += "	  <C>id='T10', left=1251, top=0, right=1339, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <L> left=1339 ,top=0 ,right=1339 ,bottom=56 </L>	";
ls_html += "	  <L> left=1431 ,top=0 ,right=1431 ,bottom=56 </L>	";
ls_html += "	  <C>id='T11', left=1341, top=0, right=1431, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <C>id='T12', left=1434, top=0, right=1524, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <L> left=1524 ,top=0 ,right=1524 ,bottom=56 </L>	";
ls_html += "	  <C>id='T13', left=1527, top=0, right=1617, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <L> left=1617 ,top=0 ,right=1617 ,bottom=56 </L>	";
ls_html += "	  <C>id='T14', left=1619, top=0, right=1709, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <L> left=1709 ,top=0 ,right=1709 ,bottom=56 </L>	";
ls_html += "	  <C>id='T15', left=1712, top=0, right=1802, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <L> left=1802 ,top=0 ,right=1802 ,bottom=56 </L>	";
ls_html += "	  <X>left=1804 ,top=0 ,right=1897 ,bottom=56 ,backcolor=#CCCCCC ,border=true ,penstyle=solid ,penwidth=1</X>	";
ls_html += "	  <C>id='T17', left=1900, top=0, right=1990, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <L> left=1897 ,top=0 ,right=1897 ,bottom=56 </L>	";
ls_html += "	  <L> left=1990 ,top=0 ,right=1990 ,bottom=56 </L>	";
ls_html += "	  <C>id='T18', left=1992, top=0, right=2082, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <L> left=2082 ,top=0 ,right=2082 ,bottom=56 </L>	";
ls_html += "	  <C>id='T19', left=2085, top=0, right=2175, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <L> left=2175 ,top=0 ,right=2175 ,bottom=56 </L>	";
ls_html += "	  <L> left=2360 ,top=0 ,right=2360 ,bottom=56 </L>	";
ls_html += "	  <L> left=2453 ,top=0 ,right=2453 ,bottom=56 </L>	";
ls_html += "	  <L> left=2545 ,top=0 ,right=2545 ,bottom=56 </L>	";
ls_html += "	  <C>id='T21', left=2270, top=0, right=2360, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <C>id='T22', left=2363, top=0, right=2453, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <C>id='T23', left=2455, top=0, right=2545, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <X>left=1061 ,top=0 ,right=1154 ,bottom=56 ,backcolor=#CCCCCC ,border=true ,penstyle=solid ,penwidth=1</X>	";
ls_html += "	  <X>left=1061 ,top=0 ,right=1154 ,bottom=56 ,backcolor=#CCCCCC ,border=true ,penstyle=solid ,penwidth=1</X>	";
ls_html += "	  <C>id='T20', left=2178, top=0, right=2262, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <L> left=2265 ,top=0 ,right=2265 ,bottom=56 </L>	";
ls_html += "	  <C>id='T8', left=1061, top=0, right=1154, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#CCCCCC</C>	";
ls_html += "	  <L> left=1058 ,top=0 ,right=1058 ,bottom=56 </L>	";
ls_html += "	  <C>id='T9', left=1156, top=0, right=1246, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
ls_html += "	  <C>id='T16', left=1804, top=0, right=1897, bottom=56, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#CCCCCC</C>	";
ls_html += "	</B>	";
ls_html += "	<B>id=LDFooter ,left=0,top=0 ,right=2871 ,bottom=58 ,face='Arial' ,size=10 ,penwidth=1	";
ls_html += "	  <X>left=0 ,top=0 ,right=2834 ,bottom=56 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>	";
ls_html += "	  <L> left=0 ,top=0 ,right=0 ,bottom=56 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	";
ls_html += "	  <L> left=2834 ,top=0 ,right=2834 ,bottom=56 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	";
ls_html += "	  <L> left=0 ,top=56 ,right=2834 ,bottom=56 </L>	";
ls_html += "	  <L> left=410 ,top=0 ,right=410 ,bottom=56 </L>	";
ls_html += "	  <T>id='합계' ,left=11 ,top=0 ,right=410 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>	";
ls_html += "	  <L> left=0 ,top=0 ,right=2834 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	";
ls_html += "	  <L> left=503 ,top=0 ,right=503 ,bottom=56 </L>	";
ls_html += "	  <L> left=595 ,top=0 ,right=595 ,bottom=56 </L>	";
ls_html += "	  <L> left=688 ,top=0 ,right=688 ,bottom=56 </L>	";
ls_html += "	  <L> left=781 ,top=0 ,right=781 ,bottom=56 </L>	";
ls_html += "	  <L> left=873 ,top=0 ,right=873 ,bottom=56 </L>	";
ls_html += "	  <L> left=966 ,top=0 ,right=966 ,bottom=56 </L>	";
ls_html += "	  <L> left=1058 ,top=0 ,right=1058 ,bottom=56 </L>	";
ls_html += "	  <L> left=1058 ,top=0 ,right=1058 ,bottom=56 </L>	";
ls_html += "	  <L> left=1154 ,top=0 ,right=1154 ,bottom=56 </L>	";
ls_html += "	  <S>id='{Sum(T1)}' ,left=415 ,top=3 ,right=503 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T2)}' ,left=505 ,top=3 ,right=593 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T3)}' ,left=598 ,top=3 ,right=688 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T4)}' ,left=691 ,top=3 ,right=778 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T5)}' ,left=783 ,top=3 ,right=873 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T6)}' ,left=876 ,top=3 ,right=963 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T7)}' ,left=968 ,top=3 ,right=1058 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <L> left=1249 ,top=0 ,right=1249 ,bottom=56 </L>	";
ls_html += "	  <L> left=1339 ,top=0 ,right=1339 ,bottom=56 </L>	";
ls_html += "	  <L> left=1431 ,top=0 ,right=1431 ,bottom=56 </L>	";
ls_html += "	  <L> left=1524 ,top=0 ,right=1524 ,bottom=56 </L>	";
ls_html += "	  <L> left=1617 ,top=0 ,right=1617 ,bottom=56 </L>	";
ls_html += "	  <L> left=1709 ,top=0 ,right=1709 ,bottom=56 </L>	";
ls_html += "	  <L> left=1802 ,top=0 ,right=1802 ,bottom=56 </L>	";
ls_html += "	  <L> left=1897 ,top=0 ,right=1897 ,bottom=56 </L>	";
ls_html += "	  <L> left=2651 ,top=0 ,right=2651 ,bottom=56 </L>	";
ls_html += "	  <L> left=2545 ,top=0 ,right=2545 ,bottom=56 </L>	";
ls_html += "	  <L> left=2453 ,top=0 ,right=2453 ,bottom=56 </L>	";
ls_html += "	  <L> left=2360 ,top=0 ,right=2360 ,bottom=56 </L>	";
ls_html += "	  <L> left=2265 ,top=0 ,right=2265 ,bottom=56 </L>	";
ls_html += "	  <L> left=2175 ,top=0 ,right=2175 ,bottom=56 </L>	";
ls_html += "	  <L> left=2082 ,top=0 ,right=2082 ,bottom=56 </L>	";
ls_html += "	  <L> left=1990 ,top=0 ,right=1990 ,bottom=56 </L>	";
ls_html += "	  <S>id='{Sum(T8)}' ,left=1061 ,top=3 ,right=1154 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T16)}' ,left=1804 ,top=3 ,right=1894 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T14)}' ,left=1619 ,top=3 ,right=1709 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T15)}' ,left=1712 ,top=3 ,right=1799 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T13)}' ,left=1527 ,top=3 ,right=1614 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T12)}' ,left=1434 ,top=3 ,right=1524 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T11)}' ,left=1341 ,top=3 ,right=1429 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T10)}' ,left=1251 ,top=3 ,right=1339 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T9)}' ,left=1156 ,top=3 ,right=1246 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T25)}' ,left=2654 ,top=3 ,right=2834 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T24)}' ,left=2551 ,top=3 ,right=2648 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T23)}' ,left=2455 ,top=3 ,right=2543 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T22)}' ,left=2363 ,top=3 ,right=2450 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T21)}' ,left=2270 ,top=3 ,right=2357 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T20)}' ,left=2178 ,top=3 ,right=2265 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T19)}' ,left=2085 ,top=3 ,right=2172 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T18)}' ,left=1992 ,top=3 ,right=2080 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	  <S>id='{Sum(T17)}' ,left=1900 ,top=3 ,right=1990 ,bottom=56 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</S>	";
ls_html += "	</B>	";
ls_html += "	<B>id=Footer ,left=0 ,top=1849 ,right=2871 ,bottom=2000 ,face='굴림' ,size=10 ,penwidth=1	";
ls_html += "	  <I>id='../../Common/img/icon.jpg' ,left=2450 ,top=0 ,right=2831 ,bottom=101</I>	";
ls_html += "	  <L> left=0 ,top=0 ,right=2834 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	";
ls_html += "	  <T>id='#p/#t' ,left=0 ,top=0 ,right=2834 ,bottom=101</T>	";
ls_html += "	</B>	";


  gcrp_print.format = ls_html;
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"	VALUE="false">
	<PARAM NAME="SortExpr"	VALUE="+TREECD">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"	VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_chart classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";

	ft_cnt.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
	else {
		cfAddSeriesOne_1(gcxc_chart1, gcds_data.id, 31, "", "#00ff00", "DEPTNM", "T25" );

		var ls_ehtml = "";
		ls_ehtml += "CHKNM:STRING(30),CHKVAL:DECIMAL(5.0),COLOR:STRING(10)";
		gcds_data2.SetDataHeader(ls_ehtml);
		gcds_data2.addrow();
		gcds_data2.namevalue(1,"CHKNM") = "한국인기능직 ";
		gcds_data2.namevalue(1,"CHKVAL") = gcds_data.NameSum("T8",0,gcds_data.countrow);
		gcds_data2.namevalue(1,"COLOR") = "blue";
		gcds_data2.addrow();
		gcds_data2.namevalue(2,"CHKNM") = "파견근로자";
		gcds_data2.namevalue(2,"CHKVAL") = gcds_data.NameSum("T16",0,gcds_data.countrow);
		gcds_data2.namevalue(2,"COLOR") = "green";

		gcds_data2.addrow();
		gcds_data2.namevalue(3,"CHKNM") = "재중동포";
		gcds_data2.namevalue(3,"CHKVAL") = gcds_data.NameSum("T24",0,gcds_data.countrow);
		gcds_data2.namevalue(3,"COLOR") = "red";

		gcxc_chart2.Header.Alignment = 2;
		gcxc_chart2.Header.Font.Size=9;
		gcxc_chart2.Header.Text.Clear();
		gcxc_chart2.Header.Text.Add("직종별 현황");

		gcxc_chart2.RemoveAllSeries();

		idx = gcxc_chart2.AddSeries(5);
		gcxc_chart2.Series(idx).Marks.Style = 1;
		gcxc_chart2.Series(idx).DataID = "gcds_data2";
		gcxc_chart2.Series(idx).YValueColumn = "CHKVAL";
		gcxc_chart2.Series(idx).XValueColumn = "CHKNM";
		gcxc_chart2.Series(idx).LabelColumn = "CHKNM";
		gcxc_chart2.Series(idx).ColorColumn = "COLOR";
		gcxc_chart2.Reset();
	}

</script>

<script language=JavaScript for=gcds_chart event=OnLoadCompleted(rowcnt)>
//	cfAddSeriesOne_1(gcxc_chart1, gcds_chart.id, 31, " man", "green", "ITEM_CODE", "mkt_rate" );
//	cfAddSeriesOne_1(gcxc_chart2, gcds_chart.id, 5, " man", "green", "ITEM_CODE", "mkt_rate" );
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="onclick(row,colid)">
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


<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
		<td background="../../Common/img/com_t_bg.gif"><img src="../img/h080003_head.gif"></td>
    <td align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			<img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print()">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
  </tr>
  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT id="gcgd_disp" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:260px;width:877px;border:1 solid #708090" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_data">
					      <PARAM NAME="Editable"		VALUE="false">
						    <PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Indwidth"		VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="ViewSummary"	VALUE="1">
								<PARAM NAME="Format"			VALUE='  
									<C>Name="소속명", ID=DEPTNM   width=135, HeadBgColor=#B9D4DC, sumText="합계", sumBgcolor="#FFDDEE"</C>
									<G> Name="한국인기능직", HeadBgColor=#B9D4DC, align=center 
										<C>ID=T1, Name="임원", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T2, Name="부장", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T3, Name="차장", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T4, Name="과장", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T5, Name="대리", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T6, Name="사원", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T7, Name="기타", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T8, Name="계",		width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE", bgcolor="#eef5f5" </C>
									</G>
									<G> Name="파견근로자", HeadBgColor=#B9D4DC, align=center 
										<C>ID=T9,  Name="임원", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T10, Name="부장", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T11, Name="차장", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T12, Name="과장", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T13, Name="대리", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T14, Name="사원", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T15, Name="기타", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T16, Name="계",		width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE", bgcolor="#eef5f5" </C>
									</G>
									<G> Name="재중동포", HeadBgColor=#B9D4DC, align=center 
										<C>ID=T17,  Name="임원", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T18, Name="부장", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T19, Name="차장", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T20, Name="과장", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T21, Name="대리", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T22, Name="사원", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T23, Name="기타", width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE" </C>
										<C>ID=T24, Name="계",		width=29, HeadBgColor=#B9D4DC, align=center, sumText=@sum, sumBgcolor="#FFDDEE", bgcolor="#eef5f5" </C>
									</G>
									<C>ID=T25,  Name="합계",	width=30, HeadBgColor=#B9D4DC, align=center, sumText={SUM(T8)+SUM(T16)+SUM(T24)}, sumBgcolor="#FFDDEE", bgcolor="#FFeeEE" </C>
								'>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="width:879px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:3px;"></font>
						</fieldset><!--
						<comment id="__NSID__"><OBJECT id="gcgd_dd" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:260px;width:877px;border:1 solid #708090" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_chart">
					      <PARAM NAME="Editable"		VALUE="false">
						    <PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Indwidth"		VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="ViewSummary"	VALUE="1">
								<PARAM NAME="Format"			VALUE='  
									<C>Name="소속명", ID=SALE_DATE   width=107, HeadBgColor=#B9D4DC</C>
									<C>Name="소속명", ID=ITEM_CODE   width=107, HeadBgColor=#B9D4DC</C>
									<C>Name="소속명", ID=SHOP_CODE   width=107, HeadBgColor=#B9D4DC</C>
									<C>Name="소속명", ID=BRAND_CODE  width=107, HeadBgColor=#B9D4DC</C>
									<C>Name="소속명", ID=MKT_RATE    width=107, HeadBgColor=#B9D4DC</C>
									<C>Name="소속명", ID=COMP_CODE   width=107, HeadBgColor=#B9D4DC</C>
								'>
						</OBJECT></comment><script>__ws__(__NSID__);</script>-->


					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr><td height=3></td></tr>  
	<tr>
		<td colspan=2>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" style='height:30px;font-size:9pt;'>
				<tr>
					<td>
						<comment id="__NSID__"><OBJECT id=gcxc_chart2 style="width:340;height:220px;border:1 solid #708090;border-right-width:0px;border-bottom-width:0px"   
							classid=clsid:75B5421D-15E1-43FA-990D-C7847D1077F0 VIEWASTEXT>
					  </OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
					<td>&nbsp;</td>
					<td>
  				  <comment id="__NSID__"><OBJECT id=gcxc_chart1 style="width:530;height:220px;border:1 solid #708090;border-right-width:0px;border-bottom-width:0px"   
							classid=clsid:75B5421D-15E1-43FA-990D-C7847D1077F0 VIEWASTEXT>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<!-----------------------------------------------------------------------------------------
출력물 정의부분
--------------------------------------------------------------------------------------->
<comment id="__NSID__"><OBJECT id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
  <PARAM NAME="MasterDataID"			VALUE="gcds_data">
  <PARAM NAME="DetailDataID"			VALUE="gcds_data">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
  <PARAM NAME="Landscape"					VALUE="1">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            VALUE="
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>