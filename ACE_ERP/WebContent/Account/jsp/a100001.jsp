<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  원가관리 - 원가명세서 / 총원가명세서
+ 프로그램 ID	:  A100001.html
+ 기 능 정 의	:  
+ 작   성  자 :  YS.JEONG
+ 수 정 일 자 :  2006.09.19
-----------------------------------------------------------------------------
+ 수 정 내 용 :	    
+ 수   정  자 :  
+ 수 정 일 자 :  
-----------------------------------------------------------------------------
+ 서 블 릿 명	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>원가명세서</title>

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
var ki,ki1,ki2

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	ln_Before();

  
  gctb_gubun.codevalue="1";
	gclx_fdcode.bindcolval = gs_fdcode;
}

/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(){
  ln_Kisu();
  gcds_data01.clearall();
	gcds_temp01.clearall();
  //전기년도 계산
  var stryymmfr = gcem_datefr.text;
	var stryymmto = gcem_dateto.text
	var strbyymmfr = Number(stryymmfr.substring(0,4)-1)+stryymmfr.substring(4,6);		//회계년월(전기)
	var strbyymmto = Number(stryymmto.substring(0,4)-1)+stryymmto.substring(4,6);	

	if(gctb_gubun.codevalue=="1"){       //원가명세서
		gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a100001_s1?v_str1="+gclx_fdcode.bindcolval
																									   +"&v_str2="+gcem_datefr.text
																									   +"&v_str3="+gcem_dateto.text
																									   +"&v_str4="+gclx_place.bindcolval
																									   +"&v_str5="+txt_costnm_fr.value
																									   +"&v_str6="+txt_costcd_fr.value
																									   +"&v_str7="+strbyymmfr
																									   +"&v_str8="+strbyymmto;																											
    //prompt("",gcds_data01.DataID );																							
	  gcds_data01.Reset();									
	}else if(gctb_gubun.codevalue=="2"){ //총원가명세서
		gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a100001_s2?v_str1="+gclx_fdcode.bindcolval
																									   +"&v_str2="+gcem_datefr.text
																									   +"&v_str3="+gcem_dateto.text
																									   +"&v_str4="
																									   +"&v_str5="
																									   +"&v_str6="
																									   +"&v_str7="+strbyymmfr
																									   +"&v_str8="+strbyymmto;																											
    //prompt("",gcds_data01.DataID );																							
	  gcds_data01.Reset();									
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
function ln_Print(){
  ln_Kisu();
	//title & head
	var time = new Date();
	var g_time;
	
	if(time.getHours()<10) {
		if(time.getMinutes()<10)
			g_time = "0"+time.getHours()+"0"+time.getMinutes()+"AM";
		else
			g_time = "0"+time.getHours()+""+time.getMinutes()+"AM";
	} else if(time.getHours()>=10&&time.getHours()<12) {
		if(time.getMinutes()<10)
			g_time = ""+time.getHours()+"0"+time.getMinutes()+"AM";
		else
			g_time = ""+time.getHours()+""+time.getMinutes()+"AM";
	} else if(time.getHours()==12) {
		if(time.getMinutes()<10)
			g_time = "120"+time.getMinutes()+"PM";
		else
			g_time = "12"+time.getMinutes()+"PM";
	} else if(time.getHours()>12&&time.getHours()<22) {
		if(time.getMinutes()<10)
			g_time = "0"+(time.getHours()-12)+"0"+time.getMinutes()+"PM";
		else
			g_time = "0"+(time.getHours()-12)+""+time.getMinutes()+"PM";
	} else {
		if(time.getMinutes()<10)
			g_time = ""+(time.getHours()-12)+"0"+time.getMinutes()+"PM";
		else
			g_time = ""+(time.getHours()-12)+""+time.getMinutes()+"PM";
	}
	g_time=gs_date+g_time;

	if(gcds_temp01.countrow<1)
			alert("출력할 정보가 없습니다.");
	else {
		if(gctb_gubun.CodeValue=="1") {
			var fdcodenm;
			if(gclx_place.BindColVal=="")
				fdcodenm = "사업장명 : 현대아산주식회사";
			else
				fdcodenm = "사업장명 : " + gclx_place.text;
			gcds_temp01.namevalue(1,"TITLE") = "원  가  명  세  서";
			gcds_temp01.namevalue(1,"FDCODENM") = fdcodenm + "  " +txt_costnm_fr.value;
		}
		else if(gctb_gubun.CodeValue=="2") {
			var fdcodenm;
			if(gclx_place.BindColVal=="")
				fdcodenm = "사업장명 : 현대아산주식회사";
			else
				fdcodenm = "사업장명 : " + gclx_place.text;
			gcds_temp01.namevalue(1,"TITLE") = "총  원  가  명  세  서";
			gcds_temp01.namevalue(1,"FDCODENM") = fdcodenm + "  " +txt_costnm_fr.value;
		}

		gcds_temp01.namevalue(1,"CURKISU") = ki1; //제 XX(당)기
		gcds_temp01.namevalue(1,"PREKISU") = ki2; //제 XX(전)기
		if(gctb_gubun.CodeValue=="1") {
			gcds_temp01.namevalue(1,"KISU1") = "제 "+ki1+"기 : "
														+gcem_datefr.text.substring(0,4)+"년 "
														+gcem_datefr.text.substring(4,6)+"월 "
														+"01일부터 "
														+gcem_dateto.text.substring(0,4)+"년 "
														+gcem_dateto.text.substring(4,6)+"월 "
														+shiftTime(gcem_dateto.text+"01",0,1,-1).substring(6,8)+"일 까지";
			gcds_temp01.namevalue(1,"PRTTIME") = g_time;
			gcds_temp01.namevalue(1,"KISU2") = "";
		}
		else if(gctb_gubun.CodeValue=="2") {
			gcds_temp01.namevalue(1,"KISU1") = "제 "+ki1+"기 : "
														+gcem_datefr.text.substring(0,4)+"년 "
														+gcem_datefr.text.substring(4,6)+"월 "
														+"01일부터 "
														+gcem_dateto.text.substring(0,4)+"년 "
														+gcem_dateto.text.substring(4,6)+"월 "
														+shiftTime(gcem_dateto.text+"01",0,1,-1).substring(6,8)+"일 까지";
			gcds_temp01.namevalue(1,"KISU2") = "제 "+ki2+"기 : "
														+(Number(gcem_datefr.text.substring(0,4))-1)+"년 "
														+gcem_datefr.text.substring(4,6)+"월 "
														+"01일부터 "
														+(Number(gcem_dateto.text.substring(0,4))-1)+"년 "
														+gcem_dateto.text.substring(4,6)+"월 "
														+shiftTime(gcem_dateto.text+"01",0,1,-1).substring(6,8)+"일 까지";
			gcds_temp01.namevalue(1,"PRTTIME") = g_time;
			gcds_temp01.namevalue(1,"KISU2") = "";
		}
		gcrp_print1.preview();

	}

}

/******************************************************************************
	Description : 출력 Dataset Head 설정 
  parameter   : 
******************************************************************************/
function ln_SetDataHeader(p){
	if(p=='01'){
		if(gcds_temp01.countrow<1){
		   var s_temp = "ATCODE:STRING,PRTNAM:STRING,PRTSEQ:STRING,GUBUN:STRING,"
			            + "XLTTOT:DECIMAL,XRTTOT:DECIMAL,YLTTOT:DECIMAL,YRTTOT:DECIMAL,"
									+ "TITLE:STRING,KISU1:STRING,KISU2:STRING,FDCODENM:STRING,"
									+ "CURKISU:STRING,PREKISU:STRING,PRTTIME:STRING";
			 gcds_temp01.SetDataHeader(s_temp);
		}
  }
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	if(gctb_gubun.codevalue=="1"){
		//gcgd_disp01.runexcel("원가명세서");
    gcgd_disp01.GridToExcel("원가명세서","",2);
	}else if(gctb_gubun.codevalue=="2"){
	  //gcgd_disp01.runexcel("총원가명세서");
     gcgd_disp01.GridToExcel("총원가명세서","",2);
	}
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
  
	//지점
	gcem_datefr.text = gs_date3+"01"; //년월
	gcem_dateto.text = gs_date2;
	
	//지점코드
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

  //사업장
	gcds_place.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2159"; 
	//prompt("", gcds_place.DataID);
	gcds_place.Reset();

  //기수
	gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
	gcds_staxdatki.Reset(); 

	/* 
	//관리/지점코드
	gcds_sfdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode2.Reset();

	gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
	gcds_staxdatki.Reset(); //기수
	*/
}


/******************************************************************************
	Description : 계정별 Set
******************************************************************************/
function ln_DataSet(){
  /*
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
	*/
}

/******************************************************************************
	Description : 조회한 데이타의 포맷을 다시 설정함.
	parameter   : gcds_disp01 -> gcds_temp01
******************************************************************************/
function ln_Data_Reset(p){

	var strno="";
	var dblcnt=0;
	var dblxrtot=0; //당기총원가
	var dblyrtot=0; //전기총원가

	gcgd_disp01.DataID="";
	//데이타셋 생성
	ln_SetDataHeader("01");

	//순번 설정
  for(i=1;i<=gcds_data01.countrow;i++){
		gcds_temp01.addrow();
		gcds_temp01.namevalue(gcds_temp01.rowposition,"ATCODE")=gcds_data01.namevalue(i,"ATCODE");
    gcds_temp01.namevalue(gcds_temp01.rowposition,"PRTSEQ")=gcds_data01.namevalue(i,"PRTSEQ");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"GUBUN")=gcds_data01.namevalue(i,"GUBUN");
    gcds_temp01.namevalue(gcds_temp01.rowposition,"XLTTOT")=gcds_data01.namevalue(i,"XLTTOT");
    gcds_temp01.namevalue(gcds_temp01.rowposition,"XRTTOT")=gcds_data01.namevalue(i,"XRTTOT");
    gcds_temp01.namevalue(gcds_temp01.rowposition,"YLTTOT")=gcds_data01.namevalue(i,"YLTTOT");
    gcds_temp01.namevalue(gcds_temp01.rowposition,"YRTTOT")=gcds_data01.namevalue(i,"YRTTOT");
		
		if(gcds_data01.namevalue(i,"GUBUN")=="Y"){
			strno="";
			dblcnt=0;
			dblxrtot = dblxrtot + gcds_data01.namevalue(i,"XRTTOT");
			dblyrtot = dblyrtot + gcds_data01.namevalue(i,"YRTTOT");
		}else{
		   dblcnt =  dblcnt+1;
		  if(i!=gcds_data01.countrow){
        strno = " "+dblcnt+"."
			}else{
        strno = "";
        //총금액 
				gcds_temp01.namevalue(gcds_temp01.rowposition,"XRTTOT") = dblxrtot;
				gcds_temp01.namevalue(gcds_temp01.rowposition,"YRTTOT") = dblyrtot;
			}
		}
		//계정명에 번호 붙이기
		gcds_temp01.namevalue(gcds_temp01.rowposition,"PRTNAM")=strno+gcds_data01.namevalue(i,"PRTNAM");
	}	
  gcgd_disp01.DataID = "gcds_temp01";
	
}

/******************************************************************************
	Description : 원가팝업
  parameter   : 
******************************************************************************/
function ln_Popup(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

  arrParam[0]="0030";//원가코드

	if(gclx_place.bindcolval!=""){
		arrParam[1]=gclx_place.bindcolval;//사업장코드
  }else{
    arrParam[1]="";
	}

	if(txt_costnm_fr.value==""){
		 arrParam[2]="";
	}else{
     arrParam[2]=txt_costnm_fr.value;
	}

	if(txt_costcd_fr.value==""){
     arrParam[3]="";
	}else{
     arrParam[3]=txt_costcd_fr.value;
	}

	strURL =  "./commdtil_cost_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		txt_costcd_fr.value =arrResult[0];
		txt_costnm_fr.value = arrResult[1];
	}else{
    txt_costcd_fr.value="";
		txt_costnm_fr.value="";
	}

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


function ln_Kisu(){

		//그리드 타이틀
	ki = gcds_staxdatki.namevalue(1,"CDCODE");
	ki1 = Number(gcem_datefr.text.substring(0,4))-Number(ki)+1+"";//8기
	ki2 = Number(gcem_datefr.text.substring(0,4))-1-Number(ki)+1+"";//7기
	gcgd_disp01.ColumnProp('GUBUN1','NAME') = "제 " + ki1 + "(당)기";
	gcgd_disp01.ColumnProp('GUBUN2','NAME') = "제 " + ki2 + "(전)기";
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!--(총)원가명세서 조회  -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--지점  -->
<comment id="__NSID__"><object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!--사업장  -->
<comment id="__NSID__"><object  id=gcds_place classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--(총)원가명세서 조회 복사  -->
<comment id="__NSID__"><object  id=gcds_temp01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 기수 -->
<comment id="__NSID__"><object  id=gcds_staxdatki classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
    ln_Data_Reset(); //데이타 재설정	  
		//ln_DataSet(); //데이타 재설정
	}
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_staxdatki" event="onloadCompleted(row,colid)">

  ln_Kisu();

</script>

<script language="javascript" for="gcds_place" event="onloadCompleted(row,colid)">
	gcds_place.InsertRow(1);
	gcds_place.NameValue(1,"CDCODE")="";
	gcds_place.NameValue(1,"CDNAM")="전체";
	gclx_place.index=0;
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
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a100001_head.gif"></td>
    <td  width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;
			<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print()">
			<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query()">
		</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!------------------------ ----------------------->
<table cellpadding="0" cellspacing="0" border="0" >
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:3px;width:877px;border:0 solid #708090;">
			<tr>
				<td class="tab15" style="height:30px;width:80px;" bgcolor="#eeeeee" align =center>지점코드</td>
				<td class="tab18" style="width:120px"><nobr>
					<comment id="__NSID__"><object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;">
						<param name=ComboDataID			value="gcds_fdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort				    value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				
				<td class="tab18" width="80px" bgcolor="#eeeeee" align =center>기&nbsp;&nbsp;&nbsp;간</td>
				<td class="tab18" style="height:30px;width:160px;" >&nbsp;<nobr>
					<comment id="__NSID__"><object  id=gcem_datefr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:-3px;top:3px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment	    value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable		    value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					~
					<comment id="__NSID__"><object  id=gcem_dateto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative;left:-1px;top:3px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				
				<td class="tab18" style="height:25px;width:80px;" bgcolor="#eeeeee" align =center>구분</td>
				<td class="tab18" width="300px" colspan=3>&nbsp;
					<nobr>
						<comment id="__NSID__"><object id=gctb_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0	style="height:24;width:190">
							<param name=Cols	value="2">
							<param name=Format	value="1^원가명세서,2^총원가명세서">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
					</nobr>
				</td>
			
				
			</tr>
			
			<tr>
				<td class="tab17" style="height:30px;width:80px;" bgcolor="#eeeeee" align =center>사 업 장</td>
				<td class="tab19" style="width:120px"><nobr>
					<comment id="__NSID__"><object  id=gclx_place classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;">
						<param name=ComboDataID			value="gcds_place">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort				    value=false>
						<param name=ListExprFormat	value="CDNAM^0^110">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
        <td class="tab19" style="height:25px;width:80px;" bgcolor="#eeeeee" align =center>원&nbsp;&nbsp;&nbsp;가</td>
				<td class="tab19" width="490px" colspan=5>
				  <nobr>
					<input id="txt_costnm_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="원가코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup();">
					<input id="txt_costcd_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
					</nobr>
				</td>
			</tr>
		</table>
	</td>
	</tr>
	<tr><td height="2px" colspan =2></td></tr>
	<tr>
		<td>  

			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:877px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  
						style="position:relative;left:3px;width:875px; height:400px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_temp01">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
              <param name="Editable"    value="false">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='계정코드'	ID=ATCODE HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center sort=false show = false </C> 
								<C> Name='계정과목'	ID=PRTNAM HeadAlign=Center HeadBgColor=#B9D4DC Width=158 align=left sort=false</C> 
								<G> Name='제 (당)기'	ID=GUBUN1 HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='금액'	ID=XLTTOT  HeadAlign=Center HeadBgColor=#B9D4DC Width=175 align=right</C>
									<C> Name='금액'	ID=XRTTOT  HeadAlign=Center HeadBgColor=#B9D4DC Width=175 align=right</C> 
								</G>
								<G> Name='제 (전)기'	ID=GUBUN2 HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='금액'	ID=YLTTOT HeadAlign=Center HeadBgColor=#B9D4DC Width=175 align=right</C> 
									<C> Name='금액'	ID=YRTTOT HeadAlign=Center HeadBgColor=#B9D4DC Width=175 align=right</C> 
								</G>
							">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;">조회건수 :</font>
					</fieldset>
			</td>
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
	<param name="MasterDataID"			value="gcds_temp01">
	<param name="DetailDataID"			value="gcds_temp01">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="printMargine"			value="false">
	<param name="LandScape"					value="false">
  <param name="PrintSetupDlgFlag" value="true">
	<param name="Format"						value="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=558 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=71 ,top=402 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=74 ,top=556 ,right=1942 ,bottom=556 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='계정과목' ,left=82 ,top=415 ,right=553 ,bottom=550 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=71 ,top=402 ,right=71 ,bottom=556 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=564 ,top=402 ,right=564 ,bottom=556 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1249 ,top=402 ,right=1249 ,bottom=558 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=402 ,right=1942 ,bottom=556 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURKISU', left=640, top=407, right=1201, bottom=474 ,mask='제 XX(당)기', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PREKISU', left=1323, top=407, right=1881, bottom=474 ,mask='제 XX(전)기', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=564 ,top=479 ,right=1942 ,bottom=479 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='금 액' ,left=640 ,top=492 ,right=1201 ,bottom=540 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금 액' ,left=1328 ,top=492 ,right=1879 ,bottom=540 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY중고딕', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='KISU1', left=503, top=191, right=1564, bottom=233, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='KISU2', left=503, top=238, right=1564, bottom=280, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='(단위 : 원)' ,left=1722 ,top=349 ,right=1934 ,bottom=394 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM', left=71, top=347, right=1249, bottom=392, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=53 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='XRTTOT', left=918, top=0, right=1244, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='XLTTOT', left=572, top=0, right=902, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='YLTTOT', left=1259, top=3, right=1588, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PRTNAM', left=85, top=5, right=553, bottom=45, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=71 ,top=0 ,right=71 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=564 ,top=0 ,right=564 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=910 ,top=0 ,right=910 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1598 ,top=0 ,right=1598 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=0 ,right=1942 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1249 ,top=0 ,right=1249 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='YRTTOT', left=1606, top=0, right=1931, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=1558 ,top=3 ,right=1937 ,bottom=85</I>
	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='PRTTIME', left=71, top=11, right=849, bottom=56, align='left' ,mask='출력일자 : XXXX/XX/XX   출력시간 : XX:XX XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='#p / #t' ,left=873 ,top=53 ,right=1140 ,bottom=101 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 