<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사/야근특근관리
+ 프로그램 ID	: h050008
+ 기 능 정 의	: 
+ 변 경 이 력	: 이순미
+ 서 블 릿 명	: h050001_s1, h050001_s2, h050001_s3, h050001_t1, h050001_s1_time
-----------------------------------------------------------------------------
+ 수 정 내 용 :	전자결재와 연동 및 process변경
+ 수   정  자 : 정영식
+ 수 정 일 자 : 2007.07.25
-----------------------------------------------------------------------------
------------------------------------------------------------------------------>
<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title></title>


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
gs_date = gcurdate.substring(0,4);// + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);

var g_managegb=""; //부서별 관리자 구분  m-관리자, u-사용자
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	gcem_frdt.text = gcurdate.substring(0,7) + "01";	//검색일자 FROM
	gcem_todt.text = gcurdate;												//검색일자	TO
	ln_Before();	//선조회 조건
	ln_Enable('F');
  gclx_closeyn.index=0;
	//gclx_gubun.index=0;
}
/******************************************************************************
	Description : 조회 ( 전체일 경우 모든 부서가 아니라...콤보에 나타난 부서만 조회한다.)
******************************************************************************/
function ln_Query(){
  var strdeptcd="";
	if(gclx_deptcd.bindcolval==""){ //전체일 경우
		for(i=1;i<=gcds_deptcd.countrow;i++){
			if(i==1){
				strdeptcd = "'"+gcds_deptcd.namevalue(i,"DEPTCD")+"'";
			}else{
				strdeptcd = strdeptcd+",'"+gcds_deptcd.namevalue(i,"DEPTCD")+"'";
			}
		}
	}else{
		strdeptcd =  "'"+gclx_deptcd.bindcolval+"'"
	}
  strdeptcd = "("+strdeptcd+")";
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050001_s4?"
	                 + "v_str1=" + gcem_frdt.text
									 + "&v_str2=" + gcem_todt.text
									 + "&v_str3=" + fn_trim(gcem_empno_fr.text)
									 + "&v_str4=" + fn_trim(gcem_empno_to.text)
									 + "&v_str5=" + txt_empnmk.value
									 + "&v_str6=" + gclx_lazcd.bindcolval
									 + "&v_str7=" + strdeptcd
									 + "&v_str8=" + gclx_paygrd.bindcolval
									 + "&v_str9=" + gclx_closeyn.bindcolval     
									 + "&v_str10=";
	//prompt("",gcds_data.DataID);
	gcds_data.Reset();
}
/*-----------------------------------------------------------------------------
		Description : 선조회 조건
-----------------------------------------------------------------------------*/
function ln_Before(){

	// 근무구분
	/*
	gcds_lazcd_1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050001_s2";
	gcds_lazcd_1.Reset();
  */
  //근태구분
	/*
	gcds_lazcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1124&v_str2=S";
	gcds_lazcd.Reset();

	gcds_lazcd_1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1124&v_str2=S";
	gcds_lazcd_1.Reset();
  */
  
	 //관리자구분
	gcds_manager.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s2?v_str1=2052&v_str2="+gusrid;
	gcds_manager.Reset();	

	//소속코드[조회조건]
	if(g_managegb=="Y"){
		gcds_deptcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s4?v_str1="+gdeptcd;
		gcds_deptcd.Reset();
  }else{
		gcds_deptcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?v_str1=";
		gcds_deptcd.Reset();
	}

	//직위코드[검색조건]
	gcds_paygrd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002";
	gcds_paygrd.Reset();

  ln_Paygrd_info(gusrid);
	ln_User_Setting(g_managegb);

	gcds_lazcd.DataID =  "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050001_s2";
	gcds_lazcd.Reset();

	gcds_lazcd_1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050001_s2";
	gcds_lazcd_1.Reset();

	//휴일근무
	gcds_holiday.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_s3?v_str1="+gs_date; 
	gcds_holiday.Reset();
	
}

/******************************************************************************
	Description : 개인별 직위 정보를 가져옴.
******************************************************************************/
function ln_Paygrd_info(userid){
	gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050001_s3?v_str1="+userid;
	gcds_data2.Reset();
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

	if(gcds_data.namevalue(gcds_data.countrow,"LAZCD")=="S05"){
		if(!ln_Holchk(gcem_frdt_1.text)){
			alert("현재일자는 휴일이 아닙니다. 확인 바랍니다.");
			return false;
		}
	}

  ln_SetDataHeader(1);
	gcds_data.addrow();

  txt_deptnm_1.value	= gcds_data2.namevalue(gcds_data2.rowposition,"DEPTNM");		//소속명
	txt_paygrdnm_1.value = gcds_data2.namevalue(gcds_data2.rowposition,"MINORNM");	//직위
	txt_empnmk_1.value	= gusrnm;																//성명	
	gcem_empno_1.text = gcds_data2.namevalue(gcds_data2.rowposition,"EMPNO");	 
	txt_deptcd_1.value =gcds_data2.namevalue(gcds_data2.rowposition,"DEPTCD");	
	txt_paygrd_1.value =gcds_data2.namevalue(gcds_data2.rowposition,"PAYGRD");	

	//gcem_todt.text = gcurdate;			      	//현재일
	txt_appdt_1.value =gs_date2;	          //신청일
	gcem_frdt_1.text = gcurdate;						//시작일
	gcem_frtime_1.text = "0800";		
	gcem_totime_1.text = "1700";		
	gcds_lazcd_1.Filter();
	gclx_lazcd_1.index =0;
	gclx_closeyn_1.index=0;
	//ln_CurTime1();	//출근시간
	ln_Enable('T');
  gclx_lazcd_1.bindcolval='S05';
	gclx_lazcd_1.enable = false;	        //근무구분
}

/******************************************************************************
	Description : 현재 출근시간정보
******************************************************************************/
/**
function ln_CurTime1() {

	if (txt_deptnm_1.value == "") { 
		alert("해당 소속이 없으므로 등록할 수 없습니다.");
		return false;
	} 

	if (gcem_frtime_1.text == "") { 
		gcds_curtime.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050001_s1_time";
		gcds_curtime.Reset();

		var h_time = gcds_curtime.namevalue(gcds_curtime.rowposition,"TOTIME").substring(0,2);
		var m_time = gcds_curtime.namevalue(gcds_curtime.rowposition,"TOTIME").substring(3,5);
		var s_time = gcds_curtime.namevalue(gcds_curtime.rowposition,"TOTIME").substring(6,8);

		gcem_frtime_1.text = h_time+m_time+s_time;
		gcem_frtime_1.enabled = false;

	}else{
		return false;
	}

}
**/

/******************************************************************************
	Description : 현재 퇴근시간정보
******************************************************************************/
/**
function ln_CurTime() {

	if (txt_deptnm_1.value == "") { 
		//alert("해당 소속이 없으므로 등록할 수 없습니다.");
		return false;
	} 

	gcem_totime_1.enabled = false;

	if (gcem_totime_1.text == "") {
		gcds_curtime.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050001_s1_time";
		gcds_curtime.Reset();

		var h_time = gcds_curtime.namevalue(gcds_curtime.rowposition,"TOTIME").substring(0,2);
		var m_time = gcds_curtime.namevalue(gcds_curtime.rowposition,"TOTIME").substring(3,5);
		var s_time = gcds_curtime.namevalue(gcds_curtime.rowposition,"TOTIME").substring(6,8);

		gcem_totime_1.text = h_time+m_time+s_time;
	}else{
		return false;
	}

}
**/

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

	if (txt_deptnm_1.value == "") { 
		alert("소속된 소속가 없으므로 등록할 수 없습니다.");
		return false;
	} 
	//if (gcem_frdt_1.text != "") { TODT.text = gcem_frdt_1.text; }
	
	if (!ln_Chk_Save()) return;

	var row = gcds_data.rowposition;
	gcds_data.namevalue(row,"DEPTCD")		=		fn_trim(txt_deptcd_1.value);	//소속코드
	gcds_data.namevalue(row,"EMPNO")		=		gcem_empno_1.text;						//사번
	gcds_data.namevalue(row,"DEPTNM")		=		fn_trim(txt_deptnm_1.value);	//소속명
	gcds_data.namevalue(row,"PAYSEQ")		=		txt_paygrd_1.value;						//직위
	gcds_data.namevalue(row,"EMPNMK")		=		txt_empnmk_1.value;						//성명
	gcds_data.namevalue(row,"DTYREM")		=		txt_dtyrem_1.value;						//근태사유
	gcds_data.namevalue(row,"AMT")		  =		gcem_amt_1.text;							//수당금액
	gcds_data.namevalue(row,"FRDT")			=		gcem_frdt_1.text							//시작일

	//휴가구분 현재일자의 공휴일/주휴일 체크---------------------------------------------------------
	if (gclx_lazcd_1.BindColVal == 'S05'||gclx_lazcd_1.BindColVal == 'S07' ) {	//특근(휴일) 영업당직(휴일)
		if (gcem_frtime_1.text != "") {
			if (ln_Holchk(gcem_frdt_1.text)==true) {
				var frt = gcem_frtime_1.text;	//출근시간
				var tot = gcem_totime_1.text;	//퇴근시간
				var sum_time  = tot.substring(0,2) - frt.substring(0,2);
				
        //일 4시간 이상일 때 지급
				if (sum_time >= 4) {
					if (gcds_data2.namevalue(gcds_data2.rowposition,"MEMO") == '20') {
						gcem_amt_1.text = 40000;		//과장이상 지급금액
					}else if (gcds_data2.namevalue(gcds_data2.rowposition,"MEMO") == '22') {
						gcem_amt_1.text = 30000;		//대리이하 지급금액 
					}
				}else {
					gcem_amt_1.text = 0;
				}
			}else {
				alert("평일에는 "+gclx_lazcd_1.text+" 을 사용할 수 없습니다.");
				gcem_amt_1.text = 0;
				gcem_totime_1.text = "";
				return false;
			}
		}
	}

	if (gcem_frtime_1.text != "" && gcem_totime_1.text != "") {
		var stfrtime = gcem_frtime_1.text + "00";
		var sttotime = gcem_totime_1.text + "00";
		gcds_data.namevalue(gcds_data.rowposition,"FRTIME") = stfrtime;
		gcds_data.namevalue(gcds_data.rowposition,"TOTIME") = sttotime;
	}

	//-----------------------------------------------------------------------------------------------
	var v_str1 = txt_appdt_1.value;
	var v_str2 = gcem_empno_1.Text ;					//사번   
	var v_str3 = "";                         	//결재자
	//var v_str3 = fn_trim(txt_SGNID.value);	//결재자
	//var v_str4 = txt_AGRID.value;						//승인자

	if (gcds_data.IsUpdated) {
		if (confirm("저장 하시겠습니까?")){	
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050001_t1?v_str1="+ v_str1+"&v_str2="+v_str2 + "&v_str3=" + v_str3;
			//prompt("",gcds_data.text);
			gctr_data.post();
			ln_Query();
		}else {
			//gcem_totime_1.text ='';
		}		
	}
}

/******************************************************************************
	Description : 특근(휴일) 날짜 체크
******************************************************************************/
function ln_Holchk(str_frdt) {

	for (i=1;i<=gcds_holiday.countrow;i++) {	
		if (gcds_holiday.namevalue(i,"HOLDT") ==str_frdt && 
				(gcds_holiday.namevalue(i,"HOLDIV") == '2' || gcds_holiday.namevalue(i,"HOLDIV") == '1')) {
			return true;
		}	
	}
	return false;
}

/******************************************************************************
	Description : 입력값 체크[근태관리]
******************************************************************************/
function ln_Chk_Save() {

	for(j=1;j<=gcds_data.countrow;j++){
		if(gcds_data.SysStatus(j)==1||gcds_data.SysStatus(j)==3){
			if(gcds_data.namevalue(j,"EMPNO")==""||gcds_data.namevalue(j,"EMPNMK")==""){
				alert("성명을 확인하세요.");
				return false;
			}
			if(gcds_data.namevalue(j,"DEPTCD")==""||gcds_data.namevalue(j,"DEPTNM")==""){
				alert("부서를 확인하세요.");
				return false;
			}
			if(gcds_data.namevalue(j,"PAYGRD")==""||gcds_data.namevalue(j,"PAYGRDNM")==""){
				alert("직위를 확인하세요.");
				return false;
			}
			if(gcds_data.namevalue(j,"LAZCD")==""){
				alert("근태구분을 확인하세요.");
				return false;
			}
			if(gcds_data.namevalue(j,"FRDT")==""){
				alert("일자를 확인하세요.");
				return false;
			}
			if(gcds_data.namevalue(j,"FRDT")<=gs_date){
				alert("일자는 현재일보다 크야합니다.");
				return false;
			}
			//예상시간
		}

		//출장관리에서 자동 생성된 경우 수정건의 경우 수정불가
		if(gcds_data.SysStatus(j)==3&&gcds_data.namevalue(j,"CHK")=="T"){
			if(gcds_data.namevalue(j,"LAZCD")=="S05"&&(gcds_data.namevalue(j,"OTLAZCD")!=""&&gcds_data.namevalue(j,"OTLAZCD")!=null)){
				alert("출장관리에서 자동 생성된 건입니다. 수정할 수 없습니다.");
				return false;
			}

			//결재완료 건은 수정 못함.
			if(gcds_data.namevalue(j,"CLOSYN")!=""&&gcds_data.namevalue(j,"CLOSYN")!="N"){
				alert("결재완료건은 수정 할 수 없습니다.");
				return false;
			}
		}

		//휴일근태의 경우 휴일일자 체크
		if(gcds_data.namevalue(j,"LAZCD")=="S05"){
			if(!ln_Holchk(gcds_data.namevalue(j,"FRDT"))){
				alert("현재일자는 휴일이 아닙니다. 확인 바랍니다.");
				return false;
			}
		}
	}

	return true;
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){
 var row = gcds_data.rowposition;

	if(!ln_Chk_Delete())return;
	if (confirm("선택한 정보를 삭제하시겠습니까?")){
		var str2 = gcds_data.namevalue(gcds_data.rowposition,"EMPNO");
		gcds_data.ClearAllMark();
		for(i=1;i<=gcds_data.countrow;i++){
			if(gcds_data.namevalue(i,"CHK")=="T"){
				gcds_data.MarkRows(i,i);
			}
		}
		gcds_data.DeleteMarked();
		
		gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050001_t1?v_str1=" + gcem_todt.text+ "&v_str2=" + str2;
		gctr_data.post();
		ln_Query();
	}
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
	Description : 결재자 찾기
******************************************************************************/
/*
function ln_Popup(e){

	var row = gcds_data.rowposition;

	if (gcds_data.countrow<1) { return false; }

	txt_SGDT.value  = fn_trim(gcds_data.namevalue(row, "SGDT"));		//결재날짜
	txt_AGRDT.value = fn_trim(gcds_data.namevalue(row, "AGRDT"));	//승인날짜

	if (gcds_data.IsUpdated) {
		if ((txt_SGDT.value != "" && txt_SGDT.value != "99999999") || (txt_AGRDT.value != "" && txt_AGRDT.value != "99999999")) { 
			alert("결재 및 승인이  처리 된 항목입니다."); 
			return false;
		}

		//var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;

		strURL = "./H030003_popup.html";
		strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,'',strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			eval(e).value  = arrParam[0];
			if (e=="SGNM") txt_SGNID.value = arrParam[1];	
		} else {
			eval(e).value = "";
			if (e=="SGNM") txt_SGNID.value = "";	
		}
	}
}

*/

/******************************************************************************
	Description : 팝업
******************************************************************************/
function ln_Popup(gbn){
	var arrResult	= new Array();
	var arrSend	= new Array();
	var strURL;	
	var strPos;

  if(g_managegb!="Y"){ //부서관리자가 아닐 경우
		return;
	}else{
		arrSend[1]=gusrid;
	}

	if(gbn=="1"){
	  if(gcds_data.SysStatus(gcds_data.rowposition)!=1){
			return false;
		}
	}
	
	arrSend[0]="H050008";
	strURL = "../../Person/html/H030003_popup.html"
	strPos = "dialogWidth:377px;dialogHeight:383px;dialogTop:270px;dialogLeft:348px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrSend,strPos);

	if(gbn=="0"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_empnmk.value = arrParam[0]; //성명
		} else {
			txt_empnmk.value ="";			//성명
		}
	}else if(gbn=="1"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			eval("txt_empnmk_"+gbn).value = arrParam[0]; //성명
			eval("gcem_empno_"+gbn).text = arrParam[1];  //사번
			eval("txt_deptcd_"+gbn).value=arrParam[4];   //
			eval("txt_deptnm_"+gbn).value=arrParam[2];   //
			eval("txt_paygrd_"+gbn).value=arrParam[5];   //
			eval("txt_paygrdnm_"+gbn).value=arrParam[3]; //
			ln_Paygrd_info(eval("gcem_empno_"+gbn).text);
			ln_Amt_Setting();//금액설정
		} else {
			eval("txt_empnmk_"+gbn).value ="";			//성명
			eval("gcem_empno_"+gbn).text="";
			eval("txt_deptcd_"+gbn).value="";   //
			eval("txt_deptnm_"+gbn).value="";   //
			eval("txt_paygrd_"+gbn).value="";   //
			eval("txt_paygrdnm_"+gbn).value=""; //
		}
	}
}

/******************************************************************************
	Description : Dataset Head 설정 - 야근특근 
  parameter   : 1 - 야근특근
	              2 - 야근일괄생성
******************************************************************************/
function ln_SetDataHeader(gbn){
	if(gbn==1){
		if(gcds_data.countrow<1){
			var THeader = "APPDT:String(8),EMPNO:String(7),LAZCD:String(4),DEPTCD:String(4),PAYSEQ:String(4),"
									+ "FRDT:String(8),TODT:String(8),FRTIME:String(6),TOTIME:String(6),DTYREM:String(40),"
									+ "CLOSYN:String(1),SGDT:String(8),SGNID:String(7),AGRDT:String(8),AGRID:String(7),"
									+ "PAYDT:String(8),AMT:Decimal(7),DEPTNM:String(50),MINORNM:String(30),EMPNMK:String(20),"
									+ "LAZFEENM:String(20),CURYEAR:String(3),USEYEAR:String(3),PAYYEAR:String(3),"
									+ "SGNM:String(20),MINORCD:String(4),AGNM:String(20),ATTTIME:STRING(6),CLOTIME:STRING(6),CHK:STRING(1), HLNO:STRING(14)";
			gcds_data.SetDataHeader(THeader);								//Header Set
		}
	}else if(gbn==2){
		if(gcds_batch.countrow<1){
			var THeader = "FRDT:String(8),TODT:String(8),LAZCD:String(4),INTRDAY:DECIAML(3.0)";
			gcds_batch.SetDataHeader(THeader);								//Header Set
		}
	}
}

/******************************************************************************
	Description : 사용여부
  parameter   :
******************************************************************************/
function ln_Enable(gbn){
	if(gbn=="F"){
		gclx_lazcd_1.enable = false;	      //근무구분
		gcem_frtime_1.ReadOnly = true;			//시작시간
		gcem_totime_1.ReadOnly = true;			//종료시간
		gcem_frdt_1.ReadOnly = true;				//시작일
		gcem_empno_1.ReadOnly  = true;
	}else if(gbn=="T"){
	  gclx_lazcd_1.enable = true;	        //근무구분
		gcem_totime_1.ReadOnly = false;			//시작시간
		gcem_frtime_1.ReadOnly = false;			//종료시간
		gcem_frdt_1.ReadOnly = false;				//시작일
		gcem_empno_1.ReadOnly  = true;
	}
}

/******************************************************************************
	Description : 달력관련
  parameter   : 수정건의 경우 출발일은 key값이라서 수정 못하게 막음.
******************************************************************************/
function ln_Calendar(gbn){
	if(gbn=="fr"){
		if(gcds_data.SysStatus(gcds_data.rowposition)!=1){
			return false;
		}
		__GetCallCalendar('gcem_frdt_1','Text');
	}
}

/******************************************************************************
	Description : 근태 금액 설정
  parameter   : 
******************************************************************************/
function ln_Amt_Setting(){
	//근무구분에 따른 지급조건과 지급금액 조회
	var row = gcds_lazcd_1.rowposition;
	//특근(휴일)
	if (gcds_lazcd_1.namevalue(row,"LAZCD") == 'S05' ) {	
		if (gcds_data2.namevalue(gcds_data2.rowposition,"MEMO") == '20') {       //과장이상 지급금액
			gcem_amt_1.text = 40000;		
		}else if (gcds_data2.namevalue(gcds_data2.rowposition,"MEMO") == '22') { //대리이하 지급금액
			gcem_amt_1.text = 30000;		
		}else{
      gcem_amt_1.text = 0;		
		} 
 	}else{
		gcem_memo_1.text = gcds_lazcd_1.namevalue(row,"MEMO");
		gcem_amt_1.text = gcds_lazcd_1.namevalue(row,"AMT");
	}
}

/******************************************************************************
	Description : 사용자에 따른 설정
	parameter   : 
******************************************************************************/
function ln_User_Setting(gbn){
  
	if(gbn=="Y"){ // 부서별 관리자
		gcem_amt_1.ReadOnly = false;
		gcem_amt_1.ReadOnlyBackColor = "#CCCCCC";
	  gcem_empno_fr.ReadOnly = false;
    gcem_empno_to.ReadOnly = false;
		txt_empnmk.readOnly=false;
		gclx_deptcd.enable=true;
		gclx_paygrd.enable=true;
		gcem_empno_fr.text = gusrid;
		gcem_empno_to.text = gusrid;
		txt_empnmk.value=gusrnm;
		gclx_deptcd.bindcolval=gcds_data2.namevalue(gcds_data2.rowposition,"DEPTCD");
		gclx_paygrd.bindcolval=gcds_data2.namevalue(gcds_data2.rowposition,"PAYGRD");

	}else{ //일반사용자
		gcem_amt_1.ReadOnly = true;
		gcem_amt_1.ReadOnlyBackColor = "#CCFFCC";
		gcem_empno_fr.ReadOnly = true;
    gcem_empno_to.ReadOnly = true;
    txt_empnmk.readOnly=true;
		gclx_deptcd.enable=false;
		gclx_paygrd.enable=false;
		gcem_empno_fr.text = gusrid;
		gcem_empno_to.text = gusrid;
		txt_empnmk.value=gusrnm;
		gclx_deptcd.bindcolval=gcds_data2.namevalue(gcds_data2.rowposition,"DEPTCD");
		gclx_paygrd.bindcolval=gcds_data2.namevalue(gcds_data2.rowposition,"PAYGRD");
	}
}

/******************************************************************************
	Description : 야근자동생성
	parameter   : 사용안함.
******************************************************************************/
function ln_Auto_Create(){
  /*
  if(gcem_frdt_2.text==""||gcem_todt_2.text==""){
		alert("일자를 확인 하십시요.");
		return;
	}

	if(gcem_frdt_2.text>gcem_todt_2.text){
		alert("일자를 확인 하십시요.");
		return;
	}

	if(ln_Chk_Create()){
		if(confirm("기생성된 데이타가 존재 합니다. 삭제하고 다시 생성 하시겠습니까?")){	
		}else{
			return false;
		}
	}else{
  }

	ln_SetDataHeader(2);
	gcds_batch.addrow();
	//gcds_batch.namevalue(gcds_batch.rowposition,"APPDT")=gs_date2;         //현재일     
	gcds_batch.namevalue(gcds_batch.rowposition,"FRDT")=gcem_frdt_2.text;	 //from 일자     
	gcds_batch.namevalue(gcds_batch.rowposition,"TODT")=gcem_todt_2.text;	 //to 일자  
	gcds_batch.namevalue(gcds_batch.rowposition,"LAZCD")="S01";	 //to 일자  
	gcds_batch.namevalue(gcds_batch.rowposition,"INTRDAY") = ln_DataChk(gcem_frdt_2.text,gcem_todt_2.text);

	if (gcds_batch.IsUpdated) {
		if(confirm("생성 하시겠습니까?")){	
			gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050008_t1?";
			prompt("",gcds_batch.text);
			gctr_data2.post();
		}
	}
	*/
}

/******************************************************************************
	Description : 야근자동생성 체크
	parameter   : 사용안함.
******************************************************************************/
function ln_Chk_Create(){
  /*
	gcds_chk_batch.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050008_s2?"
	                 + "v_str1=" + gcem_frdt_2.text
									 + "&v_str2=" + gcem_todt_2.text
									 + "&v_str3=S01" ;
	prompt("",gcds_chk_batch.DataID);
	gcds_chk_batch.Reset();

	
	if(gcds_chk_batch.namevalue(gcds_chk_batch.rowposition,"CNT")>0){
	  alert("true");
		return true;
	}else{
	  alert("false");
		return false;
	}
	*/
}

/******************************************************************************
	Description : 날짜 사이 조회
	Parameter   : frdt - 출발일, todt - 복귀일
******************************************************************************/
function ln_DataChk(frdt,todt) { 
	var fryy =frdt.substring(0,4);
	var frmm =frdt.substring(4,6);
	var frdd =frdt.substring(6,8);

	var toyy =todt.substring(0,4);
	var tomm =todt.substring(4,6);
	var todd =todt.substring(6,8);

	frdate=new Date(fryy,frmm-1,frdd); //월에서는 1을 뺀다 
	todate=new Date(toyy,tomm-1,todd); //오늘날짜 

	frtime=frdate.getTime(); //출발시각 
	totime=todate.getTime(); //복구시각
	cha=totime-frtime;       //시각차이 
	conv=Math.floor(cha/(60*60*24*1000))+1; //시각차이를 일자차이로 계산 
	return conv
}

/******************************************************************************
	Description : 사원조회
******************************************************************************/
/***
function ln_FindEmp(e,e2){

	if (gcds_data.countrow<1) { return false; }
	if(e2=='2')	{   
		var str1=fn_trim(gcem_emo.Text);
		gcds_select_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040001_s1?"+ "v_str1=" + str1;
		gcds_select_ec01az.Reset();
	}	else	{
		var arrResult	= new Array();
		var arrSend	= new Array();
        arrSend[0]='P040001';
		window.dialogArguments=arrSend[0];
		var strURL;	
		var strPos;
		strURL = "../../Person/html/H030003_popup.html"
		//strURL = "P040001_popup.html"
		strPos = "dialogWidth:377px;dialogHeight:363px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrSend,strPos);
		
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_empno_1.Text = arrParam[0];			// 사번
			txt_empnmk_1.value = arrParam[1];			//성명
      txt_deptcd_1.value = arrParam[2];
			txt_deptnm_1.value = arrParam[3];			  //소속명
			txt_paygrd_1.value = arrParam[11];     //직위
			txt_paygrdnm_1.value = arrParam[12];
			//gcem_empno_fr.Focus();		
		} else {
			gcem_empno_1.Text ="";			  // 사번
			txt_empnmk_1.value  ="";			//성명
      txt_deptcd_1.value  ="";
			txt_deptnm_1.value  ="";			  //소속명
			txt_paygrd_1.value  ="";      //직위
			txt_paygrdnm_1.value  ="";
		}
	}
}
**/

/******************************************************************************
	Description : 조회시 Loading bar start
  parameter   :
******************************************************************************/
function ln_Loading_Start(){
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.1";
	//document.all.LowerFrame.style.visibility="visible";
}
/******************************************************************************
	Description : 조회시 Loading bar end
  parameter   :
******************************************************************************/
function ln_Loading_End(row){
	window.status="조회가 완료 되었습니다.";
	lbl_search.innerText = "( " + row + " 건 )";
	//document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
}

/******************************************************************************
	Description : 결재팝업
	Parameter :
******************************************************************************/
function ln_Submit(){

	var arrMst	= new Array();
	var arrDtl	= new Array();
	var m=0; //
	var cnt=0;
	var strFrdt="";
	var yy="";
	var mm="";
	var dd="";
	var strFrtime="";
	var strTotime="";

	if(!ln_Chk_Submit()) return;

	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			 arrMst[0]="HA1";                              //양식코드
			 arrMst[1]=gusrid;                            //기안자사번
			 arrMst[2]=gcds_data.namevalue(i,"DIVNM");    //휴일근무부서명
			 break;
		}
  }

	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			cnt+=1;
		}
	}
	arrMst[3]=cnt;                                      //휴일근무자 수 

	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			strFrdt = gcds_data.namevalue(i,"FRDT");       //근태일
			yy = strFrdt.substring(0,4);
			mm = strFrdt.substring(4,6);
			dd = strFrdt.substring(6,8);
			arrDtl[0+m]=yy+"/"+mm+"/"+dd+" "+gf_dayOfWeek(yy,mm,dd);  

			arrDtl[1+m]=gcds_data.namevalue(i,"EMPNO");    //사번
			arrDtl[2+m]=gcds_data.namevalue(i,"MINORNM");  //직책
			arrDtl[3+m]=gcds_data.namevalue(i,"EMPNMK");  //성명
			strFrtime = gcds_data.namevalue(i,"FRTIME");  //시작시간
			arrDtl[4+m]=strFrtime.substring(0,2)+":"+ strFrtime.substring(2,4);
			strTotime = gcds_data.namevalue(i,"TOTIME");  //종료시간
			arrDtl[5+m]=strTotime.substring(0,2)+":"+ strTotime.substring(2,4);
			arrDtl[6+m]=gcds_data.namevalue(i,"DTYREM");  //근무내용
			arrDtl[7+m]=gcds_data.namevalue(i,"HLNO");    //근태번호
			m+=8;
		}
  }

	ifrm.ln_Popup('HA1',arrMst,arrDtl);
}

/******************************************************************************
	Description : 결재시체크
	Parameter :
******************************************************************************/
function ln_Chk_Submit(){
	var cnt=0;
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.namevalue(i,"CLOSYN")!=""&&gcds_data.namevalue(i,"CLOSYN")!="N"){
				alert("결재할 수 없습니다. 결재상태를 확인하십시요.");
				return false;
  		}
			cnt+=1;
		}
	}

	if(cnt==0){
		alert("결재할 대상을 선택하십시요.");
		return false;
	}

	return true;
}

/******************************************************************************
	Description : 삭제시 체크
	Parameter :
******************************************************************************/
function ln_Chk_Delete(){
	var cnt=0;
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(fn_trim(gcds_data.namevalue(i,"CLOSYN"))!=""&&gcds_data.namevalue(i,"CLOSYN")!="N"&&gcds_data.namevalue(i,"CLOSYN")!="R"&&gcds_data.namevalue(i,"CLOSYN")!="B"&&gcds_data.namevalue(i,"CLOSYN")!="H"){
				alert("해당건은 삭제 할 수 없습니다.");
				return false;
  		}

			 //출장관리에서 자동 생성된 경우 수정건의 경우 수정불가
			if(gcds_data.namevalue(i,"LAZCD")=="S05"&&(gcds_data.namevalue(i,"OTLAZCD")!=""&&gcds_data.namevalue(i,"OTLAZCD")!=null)){
				alert("출장관리에서 자동 생성된 건입니다. 수정할 수 없습니다.");
				return false;
			}

			cnt+=1;
		}
	}

	if(cnt==0){
		alert("삭제할 대상을 선택하십시요.");
		return false;
	}
	return true;
}
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- 근무구분 -->
<comment id="__NSID__"><OBJECT id=gcds_lazcd_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"	VALUE="false">
	<PARAM NAME="SortExpr"  VALUE="+LAZFEENM">
	<param name="UseFilter"	value="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"	VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- 현재 시간정보 -->
<comment id="__NSID__"><OBJECT id=gcds_curtime classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- 휴일근무 -->
<comment id="__NSID__"><OBJECT id=gcds_holiday classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"	VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<OBJECT id=gcds_lazcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr"  VALUE="+LAZFEENM">
</OBJECT>

<OBJECT id=gcds_deptcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<OBJECT id=gcds_paygrd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<OBJECT id=gcds_manager classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 관리자구분 -->
</OBJECT>

<OBJECT id=gcds_batch classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 야근 일괄생성 -->
</OBJECT>

<OBJECT id=gcds_chk_batch classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 야근 일괄생성 체크 -->
</OBJECT>

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h050001_t1(I:USER=gcds_data)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gctr_data2 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h050008_t1(I:USER=gcds_batch)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

	
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	ln_Loading_Start();
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	ln_Loading_End(row);
</script>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("에러가 발생 했습니다.");
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_manager" event="onloadCompleted(row,colid)">
  
	if(row>0){ //관리자
	  g_managegb = "Y"; 
		ln_User_Setting('Y');
	}else{     //일반사용자
    g_managegb="N";
		ln_User_Setting('N'); 
	}
</script>

<script language="javascript"  for="gcds_data2"  event=onLoadCompleted(rowcount)>
	var row = gcds_data2.rowposition;
	if (txt_deptnm_1.value != "" && txt_paygrdnm_1.value != "" || gcds_data2.namevalue(row,"DEPTNM") != null) {
		txt_deptnm_1.value	= gcds_data2.namevalue(row,"DEPTNM");		//소속명
		txt_paygrdnm_1.value = gcds_data2.namevalue(row,"MINORNM");	//직위
		txt_empnmk_1.value	= gcds_data2.namevalue(row,"EMPNMK");		//성명	
		gcem_empno_1.text = gcds_data2.namevalue(row,"EMPNO");
		txt_deptcd_1.value =gcds_data2.namevalue(row,"DEPTCD");	
		txt_paygrd_1.value =gcds_data2.namevalue(row,"PAYGRD");	
	} else {
		txt_deptnm_1.value	= "";
		txt_paygrdnm_1.value = "";
		txt_empnmk_1.value	= gusrnm;	
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_lazcd" event="onloadCompleted(row,colid)">
		gcds_lazcd.insertrow(1);
		gcds_lazcd.namevalue(1,"LAZCD") = "";
		gcds_lazcd.namevalue(1,"LAZFEENM") = "전체";
		gclx_lazcd.index = 0;
</script>

<script language="javascript" for="gcds_deptcd" event="onloadCompleted(row,colid)">
	gcds_deptcd.insertrow(1);
	gcds_deptcd.namevalue(1,"DEPTCD") = "";
	gcds_deptcd.namevalue(1,"DEPTNM") = "전체";
	gclx_deptcd.index = 0;
</script>

<script language="javascript" for="gcds_paygrd" event="onloadCompleted(row,colid)">
	//직위[검색조건]
	gcds_paygrd.insertrow(1);
	gcds_paygrd.namevalue(1,"MINORCD") = "";
	gcds_paygrd.namevalue(1,"MINORNM") = "전체";
	gclx_paygrd.index = 0;
</script>

<script language="javascript" for="gclx_lazcd_1" event="OnSelChange()">
	ln_Amt_Setting();
	/***
	//근무구분에 따른 지급조건과 지급금액 조회
	var row = gcds_lazcd_1.rowposition;
	var str1 = gcds_lazcd_1.namevalue(row,"LAZCD");
	gcem_memo_1.text = gcds_lazcd_1.namevalue(row,"MEMO");
	gcem_amt_1.text = gcds_lazcd_1.namevalue(row,"AMT");

	//근무구분 : 특근(휴일)---------------------------------------------------------------
	if (gcds_lazcd_1.namevalue(row,"LAZCD") == 'S05' ) {	
		if (gcds_data2.namevalue(gcds_data2.rowposition,"MEMO") == '20') {
			gcem_amt_1.text = 40000;		//과장이상 지급금액
		}else if (gcds_data2.namevalue(gcds_data2.rowposition,"MEMO") == '22') {
			gcem_amt_1.text = 30000;		//대리이하 지급금액
		}

	//근무구분 : 야근비(평일)-------------------------------------------------------------
	} else if (gcds_lazcd_1.namevalue(row,"LAZCD") == 'S01' )	{ 
		var to_time = gcem_totime_1.text;
		var h_time = to_time.substring(0,2);	//시		
		var m_time = to_time.substring(3,5);	//분
		var s_time = to_time.substring(6,8);	//초

		if (gcem_totime_1.text != "") {
			//21시 이후 ~ 오후 24시까지
			if (h_time.substring(0,2) >= '21' && m_time.substring(3,5) == '00') { 
				gcem_amt_1.text = 7000;
			//24시 이후 ~ 오전 8시까지
			} else if (h_time.substring(0,2) >=  '24' || (h_time.substring(0,2) <=  '08' && m_time.substring(3,5) <=  '00')) {
				gcem_amt_1.text = 10000;
			//18시 부터 ~ 21시 이전까지
			} else if (h_time.substring(0,2) >=  '18' || h_time.substring(0,2) <  '21') {
				gcem_amt_1.text = 0;
			}
		}else{ gcem_amt_1.text = 0; }
   
 	} ***/
</script>

<script language="javascript"  for=gcgd_disp  event=OnColumnPosChanged(Row,Colid)>
 	gcem_amt_1.text = gcds_data.namevalue(row,"AMT");
</script>

<!-- <script language="javascript"  for="FRDT"  event="OnKillFocus()">
 	TODT.text = FRDT.text;
</script> -->

<script language=JavaScript for=gcem_frdt_1 event=onKillFocus()>
  var yyyymmdd = fn_trim(gcem_frdt_1.text); 
	var stryyyy="" ,strmm="",strdd="" ;
  
	stryyyy= yyyymmdd.substring(0,4);
	strmm = yyyymmdd.substring(4,6);
	strdd = yyyymmdd.substring(6,8);

  //년 변경
	if(parseInt(strmm)==1 && parseInt(strdd)==1)	{
		stryyyy=(parseInt(stryyyy)-1)+"";
	}	else {
		stryyyy=stryyyy;
	}

	if (strdd=="01"){
	   //일자변경
		if (strmm== "01" || strmm=="02" || strmm=="04" ||strmm=="06" ||strmm=="08"|| strmm=="09" ||strmm=="11"){
			strdd="31"
		}else if (strmm=="03"){
      strdd="29"
    }else{
			strdd="30"
		}
    
		//월변경
		if(Number(strmm)==1) strmm="12";
		else	strmm=(Number(strmm)-1)+"";

		if(strmm.length ==1)
			strmm ="0" + strmm ;

	}else{
		strdd=(Number(strdd)-1)
		if (strdd>=1&&strdd<=9) strdd ="0" + strdd ;
	}

	gcds_data.namevalue(gcds_data.RowPosition,"APPDT") = stryyyy+strmm+strdd; 
</script>

<script language=JavaScript for=gcds_lazcd_1 event=onFilter(row)>
	//if(gcds_lazcd_1.namevalue(row,"LAZCD")!="S01") return true;
	//else return false;
</script>

<script language="javascript"  for=gcgd_disp01 event=OnClick(Row,Colid)>
	if(Row>=1&&Colid=="CHK"){
		if(gcds_data.namevalue(Row,"OTLAZCD")=="G02"||gcds_data.namevalue(Row,"OTLAZCD")=="G03"){
			 gcds_data.namevalue(Row,"CHK")="F";
			 alert(fn_trim(gcds_data.namevalue(Row,"DTYREM"))+"으로 인해 자동생성된 건입니다. ");
		}
	}

	if(Row>1&&gcds_data.namevalue(Row,"CLOSYN")!=""&&gcds_data.namevalue(Row,"CLOSYN")!="N"){
		txt_dtyrem_1.readOnly=true;
	}else{
    txt_dtyrem_1.readOnly=false;
	}

</script>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language=JavaScript for=gctr_data event=OnFail()>
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data2" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language=JavaScript for=gctr_data2 event=OnFail()>
	alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
</script>


</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<form name="appfrm" method="post" action="">
<input type="hidden" name="typ" value="HA1">		  <!-- 양식코드 : 양식별로 구분할수 있는 구분자로 양식별로 할당하여 사용할 것임.-->
<input type="hidden" name="eno" value="6060001">	<!-- 기안자 사번 : 기안을 할 사용자의 사번으로 인사시스템에서 만들어 넣어주세요!-->
													<!-- 연동에 필요한 XML Data : 기안시 그룹웨어 쪽으로 넘길 실제 Data로 인사 시스템내에서 만들어 넣어주세요!-->
<input type="hidden" name="xml" value="<?xml version='1.0' encoding='utf-8' ?><returnData RESULT='true'><row><field name='param1'><![CDATA[HA1]]></field><field name='param2'><![CDATA[]]></field><field name='param3'><![CDATA[]]></field><field name='param4'><![CDATA[]]></field><field name='param5'><![CDATA[]]><field name='connurl'><![CDATA[http://203.242.52.66/test/test.jsp]]></field></field><field name='lDepartment'><![CDATA[광양사무소]]></field><field name='workDate'><![CDATA[2007/01/07 ( 日 )]]></field><field name='total'><![CDATA[2]]></field></row><row><field name='empNo'><![CDATA[3607]]></field><field name='lJikwe'><![CDATA[과장급감독]]></field><field name='userName'><![CDATA[김용철]]></field>	<field name='workStart'><![CDATA[04:00]]></field><field name='workEnd'><![CDATA[06:00]]></field><field name='workContents'><![CDATA[HHSH005W 하역작업 준비]]></field></row><row><field name='empNo'><![CDATA[3940]]></field><field name='lJikwe'><![CDATA[대리급감독]]></field><field name='userName'><![CDATA[서백석]]></field><field name='workStart'><![CDATA[04:00]]></field><field name='workEnd'><![CDATA[06:00]]></field><field name='workContents'><![CDATA[MV ORCHID BAY 702A 선적감독]]></field></row></returnData>">
<input type="hidden" name="company" value="hda">	<!-- 회사코드 : 회사 구분 코드임.-->
</form>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/h050001_0_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		  <img src="../../Common/img/btn/com_b_result.gif"	style="cursor:hand" onclick="ln_Submit()">
			<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onclick="ln_Delete()">
			<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()" >
			<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
	<tr>
		<td COLSPAN=2>
			<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr> 
					<td width="60px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>&nbsp;&nbsp;특근일자&nbsp;</nobr></td>
					<td class="tab18" style="width:210px;"><nobr>&nbsp;
					<comment id="__NSID__">
						<object  id=gcem_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
						 </object></comment><script>__ws__(__NSID__);</script> 
						 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_frdt','Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  
							~&nbsp;
						 <comment id="__NSID__"><object  id=gcem_todt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script> 
							 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_todt','Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  
							</nobr>
					</td>
          <td width="80px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;사번&nbsp;</nobr></td>
          <td class="tab18" style="width:140px;"><nobr>&nbsp;
					<comment id="__NSID__">
						<object id=gcem_empno_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:0px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " validFeatures="ignoreStatus=yes" validExp="">
											<param name=Text          value="">
											<param name=Alignment	    value=0>
											<param name=Border	      value=True>
											<param name=Format	      value="0000000">
											<param name=PromptChar	  value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										~ &nbsp;
          <comment id="__NSID__"><object id=gcem_empno_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:0px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment	    value=0>
								<param name=Border	      value=True>
								<param name=Format	      value="0000000">
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td width="80px"  bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;성명</nobr></td>
          <td class="tab18" style="width:160px;" align=center><nobr>&nbsp;
						<input id="txt_empnmk"  type="text"  class="txtbox"  style= "position:relative;left:-8px;top:-2px;width:90px;height:20px;"   onkeydown="if(event.keyCode==13) ln_Query();" >
						<img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:-8px;top:2px;" onclick="ln_Popup('0')" >
					  </nobr>
					</td>
          <td width="80px"  bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;결재상태</nobr></td>
          <td class="tab18" style="width:140px;" align=center><nobr>&nbsp;
							<comment id="__NSID__">
							<object id=gclx_closeyn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 class="txtbox"  style="position:relative;left:-8px;top:2px;" >
								<param name=CBData			    value="''^전체,N^결재대기,I^결재중,Y^결재완료,J^접수완료,S^수신결재완료,R^회수,B^반송,H^회송">
								<param name=CBDataColumns	  value="MINORCD,MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=Sort						value="FALSE">
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value="MINORCD">
								<param name=Enable          value="true">
							</object></comment><script>__ws__(__NSID__);</script>
					  </nobr>
					</td> 
				</tr>
				<tr>
					<td width="60px" style="" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;&nbsp;근태구분&nbsp;</nobr></td>
					<td class="tab19" ><nobr>&nbsp;
						<comment id="__NSID__"><object id=gclx_lazcd  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  
						style="position:relative;left:0px;top:2px;font-size:12px;width:173px;"  >
						<param name=ComboDataID			value="gcds_lazcd">
						<param name=SearchColumn		value="LAZCD^LAZFEENM">
						<param name=Sort						value="LAZFEENM">
						<param name=ListExprFormat	value="LAZFEENM^0^170"">
						<param name=BindColumn			value="LAZCD">
						</object></comment><script>__ws__(__NSID__);</script>
						</nobr>
					</td>
					<td width="80px" style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;소속&nbsp;</nobr></td>
          <td class="tab19" ><nobr>&nbsp;
						<comment id="__NSID__"><OBJECT id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:2px;font-size:12px;width:125px;">
							<param name=ComboDataID			value="gcds_deptcd">
							<param name=SearchColumn		value="DEPTNM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="DEPTNM^0^130">
							<param name=BindColumn			value="DEPTCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 
						</nobr>
					</td>			
					<td width="80px" style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;직위&nbsp;</nobr></td>
          <td class="tab19" colspan=3><nobr>&nbsp;
					 <comment id="__NSID__"><OBJECT id=gclx_paygrd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:-4px;top:2px;font-size:12px;width:135px;">
							<param name=ComboDataID			value="gcds_paygrd">
							<param name=CBDataColumns		value="MINORCD, MINORNM">
							<param name=SearchColumn		value=MINORNM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="MINORNM^0^130">
							<param name=BindColumn			value=MINORCD>
					</OBJECT></comment><script>__ws__(__NSID__);</script> 
					</td>
					<!-- <td width="80px"  bgcolor="#eeeeee" class="tab19" align=center><nobr>&nbsp;구분</nobr></td>
          <td class="tab19" style="width:140px;" align=center><nobr>&nbsp;
							<comment id="__NSID__">
							<object id=gclx_gubun classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 class="txtbox"  style="position:relative;left:-8px;top:2px;" >
								<param name=CBData			    value="''^전체,R^정규직,T^계약직">
								<param name=CBDataColumns	  value="MINORCD,MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=Sort						value="FALSE">
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value="MINORCD">
								<param name=Enable          value="true">
							</object></comment><script>__ws__(__NSID__);</script>
					  </nobr>
					</td>  -->
				</tr>
      </table>
		</td>
	</tr>
	<!-- 검색조건 End -->

	<!-- Grid 와 입력창 -->
	<tr>
	  <td COLSPAN=2>
			<table>
				<tr>
				  <td>
					  <!--Grid-->
						<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:280px;border:0 solid #708090;">
							<tr> 			
								<td ALIGN=LEFT VALIGN=TOP>
									<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
										style="position:relative;left:2px;width:642px; height:400px; border:1 solid #708090;display:block;" viewastext>
											<param name="dataid"			value="gcds_data">
											<param name="indwidth"		value ='0'>
											<param name="borderstyle" value="0">
											<param name="fillarea"		value="true">
											<param name="sortview"		value="left">
											<param name="ColSelect"   value="false">
											<param name="colsizing"   value="true">
											<param name=MultiRowSelect	value=true>
											<param name="editable"    value="true"> 
											<param name="format"			value=" 
												<FC> Name='선택'		  ID=CHK      HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center	BgColor={IF(OTLAZCD='G02','#CCFFCC',IF(OTLAZCD='G03','#CCFFCC',''))} sort=false  EditStyle=CheckBox </FC> 
												<FC> Name='신청일'		ID=APPDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=66	  align=CENTER	BgColor={IF(OTLAZCD='G02','#CCFFCC',IF(OTLAZCD='G03','#CCFFCC',''))}  Mask='XXXX/XX/XX' Edit=None  </FC> 
												<C> Name='소속명'			ID=DEPTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=left  	BgColor={IF(OTLAZCD='G02','#CCFFCC',IF(OTLAZCD='G03','#CCFFCC',''))} Edit=None </C>
												<C> Name='직위'				ID=MINORNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=LEFT		BgColor={IF(OTLAZCD='G02','#CCFFCC',IF(OTLAZCD='G03','#CCFFCC',''))} Edit=None </C>
												<C> Name='성명'				ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=45		align=LEFT		BgColor={IF(OTLAZCD='G02','#CCFFCC',IF(OTLAZCD='G03','#CCFFCC',''))} Edit=None </C>
												<F> Name='근무구분'		ID=LAZCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=LEFT		BgColor={IF(OTLAZCD='G02','#CCFFCC',IF(OTLAZCD='G03','#CCFFCC',''))} Edit=None     Editstyle=lookup data='gcds_lazcd_1:LAZCD:LAZFEENM'  </F> 
												<C> Name='일자'				ID=FRDT			HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=CENTER	BgColor={IF(OTLAZCD='G02','#CCFFCC',IF(OTLAZCD='G03','#CCFFCC',''))} Mask='XXXX/XX/XX' Edit=None  </C>
												<G> Name='예상시간'		HeadAlign=Center HeadBgColor=#B9D4DC
												<C> Name='시작'		    ID=FRTIME		HeadAlign=Center HeadBgColor=#B9D4DC Width=35		align=CENTER	BgColor={IF(OTLAZCD='G02','#CCFFCC',IF(OTLAZCD='G03','#CCFFCC',''))} Mask='XX:XX' Edit=None </C>							
												<C> Name='종료'		    ID=TOTIME		HeadAlign=Center HeadBgColor=#B9D4DC Width=35		align=CENTER	BgColor={IF(OTLAZCD='G02','#CCFFCC',IF(OTLAZCD='G03','#CCFFCC',''))} Mask='XX:XX' Edit=None </C>
												</G>
												<G> Name='실제시간'		HeadAlign=Center HeadBgColor=#B9D4DC
												<C> Name='시작'		    ID=ATTTIME	HeadAlign=Center HeadBgColor=#B9D4DC Width=35		align=CENTER	BgColor={IF(OTLAZCD='G02','#CCFFCC',IF(OTLAZCD='G03','#CCFFCC',''))} Mask='XX:XX' Edit=None Color=#ff0000</C>							
												<C> Name='종료'		    ID=CLOTIME	HeadAlign=Center HeadBgColor=#B9D4DC Width=35		align=CENTER	BgColor={IF(OTLAZCD='G02','#CCFFCC',IF(OTLAZCD='G03','#CCFFCC',''))} Mask='XX:XX' Edit=None Color=#ff0000</C>
												</G>
												<C> Name='소속명'			ID=DEPTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=83		align=CENTER	BgColor={IF(OTLAZCD='G02','#CCFFCC',IF(OTLAZCD='G03','#CCFFCC',''))} Edit=None show=false</C>
												<C> Name='직위'				ID=MINORNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=73		align=LEFT		BgColor={IF(OTLAZCD='G02','#CCFFCC',IF(OTLAZCD='G03','#CCFFCC',''))} Edit=None show=false</C>
												<C> Name='이름'				ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=73		align=LEFT		BgColor={IF(OTLAZCD='G02','#CCFFCC',IF(OTLAZCD='G03','#CCFFCC',''))} Edit=None show=false</C>
												<C> Name='사번'				ID=EMPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=73		align=LEFT		BgColor={IF(OTLAZCD='G02','#CCFFCC',IF(OTLAZCD='G03','#CCFFCC',''))} Edit=None show=false</C>
												<C> Name='상태'       ID=CLOSYN   HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=left    BgColor={IF(OTLAZCD='G02','#CCFFCC',IF(OTLAZCD='G03','#CCFFCC',''))} sort=false  Edit=None EditStyle=Combo Data='N:결재대기,I:결재중,Y:결재완료,J:접수완료,S:수신결재완료,R:회수,B:반송,H:회송'</C> 
											">
									</object></comment><script>__ws__(__NSID__);</script>  
									
								</td>
							</tr>
						</table>
					</td>
					<td>
						<!--입력창 -->
						<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:215px;height:402px;border:1 solid #708090;">
						<tr>
							<td width="80px" height="30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>성명</nobr></td>
							<td class="tab13"><nobr>
							<comment id="__NSID__">
							<object id=gcem_empno_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:6px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " >
								<param name=Text          value="">
								<param name=Alignment	    value=0>
								<param name=Border	      value=True>
								<param name=Format	      value="0000000">
								<param name=MaxLength     value=13>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;
							<img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:-3px;top:2px;" onclick="ln_Popup('1')" >
              <input id="txt_empnmk_1" type="text" class="txt21" style="position:relative;left:-5px;top:-3px;width:70px;" > 
						</nobr>
					  </td>
            </tr>
						<tr>
						  <td width="80px" height="30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>소속</nobr></td>
							<td class="tab13"><nobr> 
							  <input id="txt_deptcd_1"  type="text"   class="txtbox"  style= "position:relative;left:0px;width:45px;height:20px;" ReadOnly>
								<input id="txt_deptnm_1"  type="text"   class="txtbox"  style= "position:relative;left:0px;width:116px;height:20px;" ReadOnly>
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>직위</nobr></td>
							<td class="tab13"><nobr>
								<input id="txt_paygrd_1"    type="text"   class="txtbox"  style= "position:relative;left:0px;width:45px;height:20px;"  ReadOnly>
								<input id="txt_paygrdnm_1"  type="text"   class="txtbox"  style= "position:relative;left:0px;width:116px;height:20px;" ReadOnly>
								<input id="txt_appdt_1"	  		type="hidden" style="height:20px"  readonly>
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>근태구분</nobr></td>
							<td class="tab13" ><nobr>
							<comment id="__NSID__">
							<object id=gclx_lazcd_1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=150 class="txtbox"  style="position:relative;left:-9px;" >
								<param name=ComboDataID			value=gcds_lazcd_1>
								<param name=SearchColumn		value="LAZCD^LAZFEENM^ALWCON^AMT">
								<param name=Sort						value="LAZFEENM">
								<param name=ListExprFormat	value="LAZFEENM^0^170"">
								<param name=BindColumn			value="LAZCD">
							</object></comment><script>__ws__(__NSID__);</script>
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>일자</nobr></td>
              <td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
									<object  id=gcem_frdt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Format        value="YYYY/MM/DD">
										<param name=PromptChar    value="_">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
									 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_Calendar('fr')" style="position:relative;width:20px;left:7px;cursor:hand;">  
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>예상시간</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
									<object id=gcem_frtime_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="width:40px;height:20px;position:relative;left:5px;top:1px">
									<param name=Text          value="">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=ClipMode			value=true>
									<param name=Format	      value="00:00">
									<param name=MaxLength     value=4>
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
								</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;~        
     						<comment id="__NSID__">
									<object id=gcem_totime_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="width:40px;height:20px;position:relative;left:5px;top:1px">
									<param name=Text          value="">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=ClipMode			value=true>
									<param name=Format	      value="00:00">
									<param name=MaxLength     value=4>
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
								</object></comment><script>__ws__(__NSID__);</script>&nbsp;
							</nobr>
							</td>
						</tr>
						<tr>
						  <td width="80px" height="30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>실제시간</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
									<object id=gcem_r_frtime_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="width:40px;height:20px;position:relative;left:5px;top:1px">
									<param name=Text          value="">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=ClipMode			value=true>
									<param name=Format	      value="00:00">
									<param name=MaxLength     value=4>
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=ReadOnlyBackColor   value="#CCFFCC">
									<param name=ReadOnly      value="true">
								</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;~        
     						<comment id="__NSID__">
									<object id=gcem_r_totime_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="width:40px;height:20px;position:relative;left:5px;top:1px">
									<param name=Text          value="">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=ClipMode			value=true>
									<param name=Format	      value="00:00">
									<param name=MaxLength     value=4>
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=ReadOnlyBackColor   value="#CCFFCC">
									<param name=ReadOnly      value="true">
								</object></comment><script>__ws__(__NSID__);</script>
							</nobr>
							</td>
						</tr>
						<tr>
						  <td width="80px" height="30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>업무내용</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
							 <textarea id="txt_dtyrem_1" class="txtbox"  style= "width:167px; height:80px; overflow:auto;position:relative;left:5px" maxlength="48" onBlur="bytelength(this,this.value,100);"></textarea>&nbsp;</nobr>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee"  class="tab19" align=center ><nobr>수당</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__"> 
									<object  id=gcem_amt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:5px;top:0px">		
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=MaxLength     value=7>
											<param name=IsComma       value=true>
											<param name=ReadOnly      value="true">
											<param name=ReadOnlyBackColor   value="#CCFFCC">
											<param name=BackColor     value="#CCCCCC">
									 </object></comment><script>__ws__(__NSID__);</script> 
								</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee"  class="tab19" align=center ><nobr>지급조건</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__"> 
									<object  id=gcem_memo_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:167px;height:20px;position:relative;left:5px;top:0px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=GeneralEdit   value="true">
											<param name=ReadOnly      value="true">
											<param name=ReadOnlyBackColor   value="#CCFFCC">
											<param name=BackColor     value="#CCCCCC">
									 </object></comment><script>__ws__(__NSID__);</script> 
								</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>결재상태</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
								<object id=gclx_closeyn_1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 class="txtbox"  style="position:relative;left:5px;" >
									<param name=CBData			    value="N^결재대기,I^결재중,Y^결재완료,J^접수완료,S^수신결재완료,R^회수,B^반송,H^회송">
									<param name=CBDataColumns	  value="MINORCD,MINORNM">
									<param name=SearchColumn		value="MINORNM">
									<param name=Sort						value="FALSE">
									<param name=ListExprFormat	value="MINORNM^0^100">
									<param name=BindColumn			value="MINORCD">
									<param name=Enable          value="false">
								</object></comment><script>__ws__(__NSID__);</script>
							</nobr></td>
						</tr>
						
            <tr>
						  <td><nobr>
								<iframe type="hidden" id="ifrm" name="ifrm" src="../../Person/html/GP_form.html" frameborder=1 style="width:0;height:0px;border:0 solid #708090;"></iframe>

							</nobr></td>
							<td><nobr></nobr></td>
						</tr>
						</table>
					</td>
        </tr>
			</table>
		</td>
	</tr>
	<!-- Grid 와 입력창 End -->

  <!-- <tr> 
    <td COLSPAN=2>

	<table  cellpadding="1" cellspacing="0" border="0"  style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
    <tr> 
			<td width="70px" align=RIGHT  style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp;검색일자&nbsp;&nbsp;</nobr></td>
			<td width="80"style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;
				<comment id="__NSID__"><object id=gcem_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2;" >
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=ClipMode			value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=MaxLength     value=8>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script>
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_frdt', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"></nobr>
			</td>
			<td align=center> ~ </td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;"><nobr> 
				<comment id="__NSID__"><object id=gcem_todt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2;">
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=ClipMode			value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=MaxLength     value=8>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script>
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_todt', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">&nbsp;</nobr>
			</td>
			<td width="5px" align=RIGHT ></td>   
			<td width="80px" align=RIGHT  style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox"><nobr>&nbsp;신청자사번&nbsp;&nbsp;</nobr></td>
			<td>
				<comment id="__NSID__"><object id=gcem_empno_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;left:8px;top:0px; width:50px; height:20px;" class=txtbox>
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
				</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td align=center><nobr>&nbsp; ~ </nobr></td>
			<td>
				<comment id="__NSID__"><object id=gcem_empno_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;left:8px;top:2px; width:50px; height:20px;" class=txtbox>
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
				</object></comment><script>__ws__(__NSID__);</script>
				<input id="txt_EMPNO" name="txt_EMPNO" type=hidden value=""  class="txtbox" style="border:0px;position:relative;left:5px;top:2px"   maxlength="7" onBlur="bytelength(this,this.value,7);" disabled >
			</td>
			<td width="5px" align=RIGHT style="border:0 solid #708090;border-right-width:1px;">&nbsp;&nbsp;</td>
			<td width="80px" align=RIGHT  style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp;&nbsp;&nbsp;성&nbsp;&nbsp;명&nbsp;&nbsp;&nbsp;</nobr></td>
			<td >
				<input id="txt_empnmk" name="txt_empnmk" type=text value="" class="txtbox" style="position:relative;left:5px;top:1px;width:70px"       onkeydown="if(event.keyCode==13) ln_Query();">
			</td>
			<td width="100%" align=RIGHT >&nbsp;&nbsp;</td>
			<td style="padding-top:4px;"></td>
		</tr>
	</table>
		</td>
  </tr>
 -->


  <!-- <tr><td colspan="2" height=3></td></tr>
  <tr> 
    <td colspan="2"> 
      <table width="876" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:503">
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="WIDTH:484px;HEIGHT:419px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data">
              <PARAM NAME="Editable"		VALUE="false">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="indwidth"		value ='0'>
							<param name="Fillarea"		VALUE="true">
							<param name="Colsizing"		VALUE="true">
							<PARAM NAME="Format"			VALUE="  
								<F> Name='신청일'			ID=APPDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=66	  align=CENTER	Mask='XXXX/XX/XX' BgColor='#f5f5f5' Edit=None  </F> 
								<C> Name='소속명'			ID=DEPTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=left  	Edit=None </C>
								<C> Name='직위'				ID=MINORNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=LEFT		Edit=None </C>
								<C> Name='이름'				ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=LEFT		Edit=None </C>
								<F> Name='근무구분'		ID=LAZCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=LEFT		Edit=None    BgColor='#f5f5f5' Editstyle=lookup data='gcds_holfee:LAZCD:LAZFEENM'  </F> 
								<C> Name='날짜'				ID=gcem_frdt_1			HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=CENTER	Mask='XXXX/XX/XX' Edit=None  </C>
								<G> Name='예상시간'		HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='시작'		    ID=FRTIME		HeadAlign=Center HeadBgColor=#B9D4DC Width=35		align=CENTER	Mask='XX:XX' Edit=None </C>							
								<C> Name='종료'		    ID=TOTIME		HeadAlign=Center HeadBgColor=#B9D4DC Width=35		align=CENTER	Mask='XX:XX' Edit=None </C>
								</G>
								<G> Name='실제시간'		HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='시작'		    ID=FRTIME		HeadAlign=Center HeadBgColor=#B9D4DC Width=35		align=CENTER	Mask='XX:XX' Edit=None </C>							
								<C> Name='종료'		    ID=TOTIME		HeadAlign=Center HeadBgColor=#B9D4DC Width=35		align=CENTER	Mask='XX:XX' Edit=None </C>
								</G>
								<C> Name='소속명'			ID=DEPTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=83		align=CENTER	Edit=None show=false</C>
								<C> Name='직위'				ID=MINORNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=73		align=LEFT		Edit=None show=false</C>
								<C> Name='이름'				ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=73		align=LEFT		Edit=None show=false</C>
								<C> Name='사번'				ID=EMPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=73		align=LEFT		Edit=None show=false</C>
							  <C> Name='결재상태'   ID=CLOSYN   HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=left    sort=false SumBgColor=#C3D0DB Edit=None EditStyle=Combo Data='N:결재대기,I:결재중,Y:결재완료,R:회수,B:반송'</C> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
			<td STYLE="PADDING-TOP:0px;" valign=top><table width="350" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td valign=top>
				<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:384px;height:421px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr>
						<td style="width:70px;height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee" align=center class="txtbox" >성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</td>
						<td  Style="height:23px;border:0 solid #708090;border-bottom-width:1px" ><nobr>
							<comment id="__NSID__"><object id=gcem_empno_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;left:6px;top:2px; width:50px; height:20px;" class=txtbox>
								<param name=Text          value="">
								<param name=Alignment	    value=0>
								<param name=Border	      value=True>
								<param name=Format	      value="0000000">
								<param name=MaxLength     value=13>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Readonly  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;
							<img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:3px;top:2px;" onclick="ln_FindEmp('1','1')" ></nobr>
						</td>
						<td Style="border:0 solid #708090;border-bottom-width:1px;padding-top:1px;" colspan=5><nobr>
							<input id="txt_empnmk_1" name="txt_empnmk_1" type="text" class="txt21" style="width:75px;"  readonly></nobr>
						</td>	
					</tr> 
					<tr>
						<td style="width:70px;height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee" align=center class="txtbox" >소 속 명</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" colspan=2>&nbsp;
							<input id="txt_deptnm_1" name="txt_deptnm_1" type="text"   class="txtbox"  style= "position:relative;left:-6px;width:126px;height:20px;" maxlength="50" onBlur="bytelength(this,this.value,50);" disabled>
							<input id="txt_deptcd_1" name="txt_deptcd_1" type="hidden" style= "position:relative;left:-6px;width:10px;height:20px;" value="" maxlength="4" onBlur="bytelength(this,this.value,4);" readonly>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >직&nbsp;&nbsp;&nbsp;&nbsp;위</td>
						<td style="border:0 solid #708090;border-bottom-width:1px" colspan=2>&nbsp;
							<input id="txt_paygrdnm_1" name="txt_paygrdnm_1"  class="txtbox" type="text" style= "position:relative;left:-5px;width:90px; height:20px;" value="" maxlength="30" onBlur="bytelength(this,this.value,30);" disabled>
							<input id="txt_paygrd_1" name="txt_paygrd_1"	type="hidden" style= "width:1px; height:1px;" maxlength="4" onBlur="bytelength(this,this.value,4);" readonly>
							<input id="txt_appdt_1"		name="txt_appdt_1"		type="hidden" style="height:20px" maxlength="8" onBlur="bytelength(this,this.value,8);" readonly>
						</td>
					</tr>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >근무구분</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>&nbsp;
							<comment id="__NSID__"><object id=gclx_lazcd_1 name=gclx_lazcd_1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=186 width=128 class="txtbox" >
								<param name=ComboDataID			value=gcds_lazcd_1>
								<param name=SearchColumn		value="LAZCD^LAZFEENM^ALWCON^AMT">
								<param name=Sort						value="LAZFEENM">
								<param name=ListExprFormat	value="LAZFEENM">
								<param name=BindColumn			value="LAZCD">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >
							<nobr>&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-bottom-width:1px" colspan=2>&nbsp;
					</tr>					
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center><nobr>시 작 일</nobr></td>
						<td Style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" colspan=2>&nbsp;
							<comment id="__NSID__"><object id=gcem_frdt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " 		validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
							
							<img name="frimg" src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_frdt_1', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"></td>
						
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" ><nobr>&nbsp;시작시간&nbsp;</nobr></td>
						<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=2>&nbsp;
							<comment id="__NSID__"><object id=gcem_frtime_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:40px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " 
				validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="00:00">
								<param name=MaxLength     value=4>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
 						</td>
					</tr>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox"><nobr>종 료 일</nobr></td>
						<td Style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" colspan=2><nobr>&nbsp;
							<comment id="__NSID__"><object id=TODT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; "  
				validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
			    </object></comment><script>__ws__(__NSID__);</script>
					
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('TODT', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"></nobr>
				</td>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">종료시간</td>
				<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=2><nobr>&nbsp;
					<comment id="__NSID__"><object id=gcem_totime_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:40px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " 
				validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=ClipMode			value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="00:00">
						<param name=MaxLength     value=4>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
			    </object></comment><script>__ws__(__NSID__);</script>
					<nobr>
				</td>
			</tr>
			<tr>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">결 재 자</td>
				<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
					<input id="SGNM"			name="SGNM"				type="text"		 class="txt21" style= "position:relative;left:-6px;width:76px; height:20px;" maxlength="20" onBlur="bytelength(this,this.value,20);" disabled>
					<input id="txt_SGNID" name="txt_SGNID"	type="hidden" style= "width:20px; height:1px;" maxlength="7" onBlur="bytelength(this,this.value,7);">
					<input id="txt_SGDT"	name="txt_SGDT"		type="hidden" style= "width:20px; height:1px;" maxlength="8" onBlur="bytelength(this,this.value,8);">
					<input id="txt_AGRDT"	name="txt_AGRDT"	type="hidden" style= "width:20px; height:1px;" maxlength="8" onBlur="bytelength(this,this.value,8);">
				</td>
				<td Style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px">
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="성명을 검색합니다" style="cursor:hand;position:relative;left:-17px;" align=center onclick="ln_Popup('SGNM');">
				</td>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;</td>
				<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=2>&nbsp;</td>
			</tr>
			<tr>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >업무내용</br><nobr>(구체적기입)</nobr></td>
				<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=5><nobr>&nbsp;
					<textarea id="txt_dtyrem_1" class="txtbox"  style= "width:297px; height:74px; overflow:auto;position:relative;left:-6px" maxlength="40" onBlur="bytelength(this,this.value,40);"></textarea>&nbsp;</nobr>
				</td>
			</tr>
			<tr>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >지급조건</td>
				<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=5><nobr>&nbsp;
					<input id="gcem_memo_1" name="gcem_memo_1" type="text" class="txt21"  style="position:relative;left:-6px;width:257px;border=0;background-color:#f1f1f1;" maxlength="30" onBlur="bytelength(this,this.value,30);" disabled>&nbsp;</nobr>
				</td>
			</tr>
			<tr>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >수당금액</td>
				<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=5><nobr>&nbsp;
					<input id="gcem_amt_1" name="gcem_amt_1" type="text" class="txt21"  style="position:relative;left:-6px;width:257px;border=0;background-color:#f1f1f1;" maxlength="7" onBlur="bytelength(this,this.value,7);" disabled>&nbsp;</nobr>
				</td>
			</tr>
			<tr>
				<td colspan=6 style="height:100%;border:0 solid #708090;border-bottom-width:0px;" >&nbsp;</td>
				</table>
				</td>
			</tr>
		</table>
			</td>
		</tr>
  </table> -->
    </td>
  </tr>
	<tr>
		<td colspan="2" height="24" align="left">조회건수 : <label id="lbl_search"></label></td>
  </tr>	
</table>

<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=APPDT      Ctrl=txt_appdt_1		Param=value			</C>
		<C>Col=EMPNO      Ctrl=gcem_empno_1   Param=Text			</C>
		<C>Col=LAZCD      Ctrl=gclx_lazcd_1	  Param=BindColVal</C>
		<C>Col=DEPTCD     Ctrl=txt_deptcd_1		Param=value			</C>
		<C>Col=PAYSEQ     Ctrl=txt_paygrd_1   Param=value			</C>
		<C>Col=FRDT				Ctrl=gcem_frdt_1		Param=Text			</C>
		<C>Col=FRTIME			Ctrl=gcem_frtime_1	Param=Text			</C>
		<C>Col=TOTIME			Ctrl=gcem_totime_1  Param=Text			</C>
		<C>Col=DTYREM			Ctrl=txt_dtyrem_1		Param=value			</C>
		<C>Col=CLOSYN			Ctrl=gclx_closeyn_1 Param=bindcolval</C>
		<C>Col=AMT				Ctrl=gcem_amt_1			Param=text			</C>
		<C>Col=MINORNM		Ctrl=txt_paygrdnm_1	Param=value			</C>
		<C>Col=DEPTNM			Ctrl=txt_deptnm_1		Param=value			</C>
		<C>Col=EMPNMK			Ctrl=txt_empnmk_1	  Param=value			</C>
		<C>Col=ATTTIME	  Ctrl=gcem_r_frtime_1	 Param=text	  </C>
		<C>Col=CLOTIME	  Ctrl=gcem_r_totime_1	 Param=text	  </C>
		
	'>
</object></comment><script>__ws__(__NSID__);</script>
<!-- <C>Col=CURYEAR			Ctrl=CURYEAR			Param=value			</C>
		<C>Col=USEYEAR			Ctrl=USEYEAR			Param=value			</C>
		<C>Col=PAYYEAR			Ctrl=PAYYEAR			Param=value     </C> -->
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>