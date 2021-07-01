<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  회계관리 - 신용카드매출전표등 수취명세서
+ 프로그램 ID	:  A050010.html
+ 기 능 정 의	:  신용카드매출전표등 수취명세서를 실제 매입등록 중 
                 신용카드, 현금영수증 데이터로 부터 생성한다.
                 생성시 수취명세서 테이블에 저장되고, 이 데이터로 부터 
								 텍스트 파일을 생성하기 위해 내려받기 한다.
+ 작   성  자 :  정 영 식
+ 서 블 릿 명	:	 a050010_s1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>신용카드매출전표등 수취명세서</title>


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

var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2  = gcurdate.substring(0,4);
var gs_date3  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;		//user_id
var gs_fdcode = gfdcode;	//지점코드

var gs_frdt="";
var gs_todt="";

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();
}

/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(e){

	var str1 = gclx_sfdcode.BindColVal;		//사업소
	var str2 = gcem_saccyy.text;					//년도
	var gisu = gclx_saccyyqt.BindColVal;	//기수
	var str3="";
	var str4="";

	if(gcem_saccyy.text==""){
		alert("년도를 입력하십시요.");
		return;
	}

	if(gisu=="1"||gisu=="2"){
		str3="1";
	}else if(gisu=="3"||gisu=="4"){
		str3="2";
	}

	if(gisu=="1"){ 
		str4="3";
	}else if(gisu=="2"){
		str4="6";
	}else if(gisu=="3"){
		str4="3";
	}else if(gisu=="4"){
		str4="6";
	}

	//데이터 있는지 조회....있으면...그것 조회 없으면 생성해서 보여줌..

	//HEADER(1건)
	gcds_head.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050010_s1?v_str1="+str1
																									      +"&v_str2="+str2
																									      +"&v_str3="+str3
																									      +"&v_str4="+str4;
	//prompt('',gcds_head.DataID);
	gcds_head.Reset();

	//DATA(N개)
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050010_s2?v_str1="+str1
																										    +"&v_str2="+str2
																										    +"&v_str3="+str3
																										    +"&v_str4="+str4;
	//prompt('',gcds_data.DataID);
	gcds_data.Reset();

	//DATA SUM
  gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050010_s3?v_str1="+str1
																										    +"&v_str2="+str2
																										    +"&v_str3="+str3
																										    +"&v_str4="+str4;
	//prompt('',gcds_data1.DataID);
	gcds_data1.Reset();

  
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

/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){
  var str1 = gclx_sfdcode.BindColVal;		//사업소
	var str2 = gcem_saccyy.text;					//년도
  var gisu = gclx_saccyyqt.BindColVal;	//기수
	var strAcchf="";
	var strHalfno="";
	var strVendid="";
	var strVendnm="";
	var strVddrect="";
	var strVendno="";

  if(str1=="01"){       //고성
		strVendid="2218113834";
	  strVendnm="현대아산주식회사";
	}else if(str1=="02"){ //서울
		//strVendid="1018510695";
		strVendid="2218113834";
	  strVendnm="현대아산주식회사";
	}
    strVddrect="배국환";
	strVendno="1401110011714";

	if(gisu=="1"||gisu=="2"){
		strAcchf="1";
	}else if(gisu=="3"||gisu=="4"){
		strAcchf="2";
	}

	if(gisu=="1"){ 
		strHalfno="3";
		gs_frdt = str2+"0101";
		gs_todt = str2+"0331";
	}else if(gisu=="2"){
		strHalfno="6";
		gs_frdt = str2+"0401";
		gs_todt = str2+"0630";
	}else if(gisu=="3"){
		strHalfno="3";
		gs_frdt = str2+"0701";
		gs_todt = str2+"0930";
	}else if(gisu=="4"){
		strHalfno="6";
		gs_frdt = str2+"1001";
		gs_todt = str2+"1231";
	}

	gcds_ihead.Addrow();
	gcds_ihead.namevalue(gcds_ihead.rowposition,"FDCODE")=gclx_sfdcode.BindColVal;
	gcds_ihead.namevalue(gcds_ihead.rowposition,"RCDGB")="HL";
	gcds_ihead.namevalue(gcds_ihead.rowposition,"ACCYY")=gcem_saccyy.text;
	gcds_ihead.namevalue(gcds_ihead.rowposition,"ACCHF")=strAcchf;
	gcds_ihead.namevalue(gcds_ihead.rowposition,"HALFNO")=strHalfno;
	gcds_ihead.namevalue(gcds_ihead.rowposition,"VENDID")=strVendid;
	gcds_ihead.namevalue(gcds_ihead.rowposition,"VENDNM")=strVendnm;
	gcds_ihead.namevalue(gcds_ihead.rowposition,"VDDIRECT")=strVddrect;
	gcds_ihead.namevalue(gcds_ihead.rowposition,"VENDNO")=strVendno;
	gcds_ihead.namevalue(gcds_ihead.rowposition,"SENDDT")=gs_date;
	gcds_ihead.namevalue(gcds_ihead.rowposition,"FILLER")="";
}
/******************************************************************************************
	Description : 생성
	신용카드매출전표등 수취명세서 생성 
*****************************************************************************************/
function ln_Create(){
  var strfrdt="";
	var strtodt="";

	//필수항목 체크 
  //if (!ln_Chk()) return; 


  ln_SetDataHeaderClearAll();
	ln_SetDataHeader();
	ln_Add();

	if(gcds_ihead.IsUpdated) {	
		if (confirm("생성 하시겠습니까?")){	
			gctr_data.KeyValue = "Account.a050010_t1(I:USER=gcds_ihead)";
			gctr_data.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050010_t1";
			gctr_data.Parameters = "v_str1="+gs_frdt+",v_str2="+gs_todt;
			//prompt('gcds_ihead',gcds_ihead.text);
			gctr_data.post();
		}
	}else{
		alert("생성하실 정보가 없습니다.");
	}
}

function ln_SetDataHeaderClearAll(){
	gcds_ihead.ClearAll();
	//gcds_idata.ClearAll();
	//gcds_itail.ClearAll();
}

/******************************************************************************
	Description : Report Head 설정
******************************************************************************/
function ln_SetDataHeader(){

	var s_tmp1 = "FDCODE:STRING,RCDGB:STRING,ACCYY:STRING,ACCHF:STRING,HALFNO:STRING,"
					   + "VENDID:STRING,VENDNM:STRING,VDDIRECT:STRING,VENDNO:STRING,SENDDT:STRING,FILLER:STRING";
	gcds_ihead.SetDataHeader(s_tmp1);

  /**
  var s_tmp2 = "REFNO:STRING,FDCODE:STRING,RCDGB:STRING,ACCYY:STRING,ACCHF:STRING,"
					   + "HALFNO:STRING,VENDID:STRING,CARDGB:STRING,CARDNO:STRING,AFVENDID:STRING,"
						 + "VCNT:DECIMAL,NUMEXP1:STRING,REQAMT:DECIMAL,NUMEXP2:STRING,TAXAMT:DECIMAL,FILLER:STRING";
	gcds_idata.SetDataHeader(s_tmp2);


	var s_tmp3 = "FDCODE:STRING,RCDGB:STRING,ACCYY:STRING,ACCHF:STRING,HALFNO:STRING,"
					   + "VENDID:STRING,DCNT:DECIMAL,TVCNT:DECIMAL,NUMEXP1:STRING,TREQAMT:DECIMAL,"
						 + "NUMEXP2:STRING,TTAXAMT:DECIMAL,FILLER:STRING";
	gcds_itail.SetDataHeader(s_tmp3);
	**/
	
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_RowAdd(e){

}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력
******************************************************************************/



/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
	gcem_saccyy.text    = gs_date2;	//년도
	gclx_saccyyqt.index = 0;				//기수
  	//지점코드
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();
  gclx_sfdcode.index=0;


	if (gcds_data99.countrow<1){
    
  }
}


/******************************************************************************
	Description : 내려받기
******************************************************************************/
function ln_Download(){
  var strfilenm = "J2218113.834";
	if (gcds_data99.countrow<1) {
		alert("다운로드하실 자료가 없습니다.");
	} else { 
		gcgd_data01.ExportFileEx(strfilenm,true,1,false);
 	}
}

/******************************************************************************
	Description : 내려받기
******************************************************************************/
function ln_Down_Query(){
	var str1 = gclx_sfdcode.BindColVal;		//사업소
	var str2 = gcem_saccyy.text;					//년도
	var gisu = gclx_saccyyqt.BindColVal;	//기수
	var str3="";
	var str4="";

	if(gcem_saccyy.text==""){
		alert("년도를 입력하십시요.");
		return;
	}

  gcds_data99.clearAll();
	var s_temp = "DISKET:STRING";
	gcds_data99.SetDataHeader(s_temp);


	if(gisu=="1"||gisu=="2"){
		str3="1";
	}else if(gisu=="3"||gisu=="4"){
		str3="2";
	}

	if(gisu=="1"){ 
		str4="3";
	}else if(gisu=="2"){
		str4="6";
	}else if(gisu=="3"){
		str4="3";
	}else if(gisu=="4"){
		str4="6";
	}

	//데이터 있는지 조회....있으면...그것 조회 없으면 생성해서 보여줌..

	//HEADER(1건)
	gcds_down_head.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050010_s1?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4;
	gcds_down_head.Reset();

	//DATA(N개)
	gcds_down_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050010_s2?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4;
	gcds_down_data.Reset();

  //TAIL(1개)
	gcds_down_tail.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050010_s4?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4;
	gcds_down_tail.Reset();

	ln_Display();
}


/******************************************************************************
	Description : 자료 내려받기 화면 display
******************************************************************************/
function ln_Display(){

  for(i=1;i<=gcds_down_head.countrow;i++){
    ln_Forward_Batch_head(i);
  }

  for(i=1;i<=gcds_down_data.countrow;i++){
    ln_Forward_Batch_data(i);
  }

	for(i=1;i<=gcds_down_tail.countrow;i++){
    ln_Forward_Batch_tail(i);
  }

}


/******************************************************************************
	Description : head
******************************************************************************/
function ln_Forward_Batch_head(i){
  var DISKET = "";
  DISKET+=strStr(gcds_down_head.namevalue(i,"RCDGB")  ,"2");   //레코드구분
  DISKET+=strStr(gcds_down_head.namevalue(i,"ACCYY")  ,"4");   //귀속년도
  DISKET+=strStr(gcds_down_head.namevalue(i,"ACCHF")  ,"1");   //반기구분
  DISKET+=strStr(gcds_down_head.namevalue(i,"HALFNO") ,"1");   //반기내월순번
  DISKET+=strStr(gcds_down_head.namevalue(i,"VENDID") ,"10");  //수취자 사업자등록번호
  DISKET+=strStr(gcds_down_head.namevalue(i,"VENDNM") ,"60");  //상호(법인명)
  DISKET+=strStr(gcds_down_head.namevalue(i,"VDDIRECT"),"30"); //성명(대표자)
  DISKET+=strStr(gcds_down_head.namevalue(i,"VENDNO")  ,"13"); //법인명
  DISKET+=strStr(gcds_down_head.namevalue(i,"SENDDT")  ,"8");  //제출일자
  DISKET+=strStr(gcds_down_head.namevalue(i,"FILLER")  ,"11"); //공란
  gcds_data99.addrow();
  
  gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}


/******************************************************************************
	Description : data
******************************************************************************/
function ln_Forward_Batch_data(i){

  
  if(gcds_down_data.namevalue(i,"CARDGB")!=1){
		gcds_down_data.namevalue(i,"AFVENDID")="";
	}

  var DISKET = "";
  DISKET+=strStr(gcds_down_data.namevalue(i,"RCDGB")   ,"2");     //레코드구분
  DISKET+=strStr(gcds_down_data.namevalue(i,"ACCYY")   ,"4");     //귀속년도
  DISKET+=strStr(gcds_down_data.namevalue(i,"ACCHF")   ,"1");     //반기구분
  DISKET+=strStr(gcds_down_data.namevalue(i,"HALFNO")  ,"1");     //반기내월순번
  DISKET+=strStr(gcds_down_data.namevalue(i,"VENDID")  ,"10");    //수취자 사업자등록번호
  DISKET+=strStr(gcds_down_data.namevalue(i,"CARDGB")  ,"1");     //카드구분
  DISKET+=strStr(gcds_down_data.namevalue(i,"CARDNO")  ,"20");    //카드회원번호
  DISKET+=strStr(gcds_down_data.namevalue(i,"AFVENDID"),"10");    //공급자(가맹점)사업자등록번호
  DISKET+=intStr(gcds_down_data.namevalue(i,"VCNT")+"" ,"9");     //거래건수
	DISKET+=strStr(gcds_down_data.namevalue(i,"NUMEXP1") ,"1");     //음수표시
	DISKET+=intStr(gcds_down_data.namevalue(i,"REQAMT")+"" ,"13");  //공급가액
	DISKET+=strStr(gcds_down_data.namevalue(i,"NUMEXP2") ,"1");     //음수표시
	DISKET+=intStr(gcds_down_data.namevalue(i,"TAXAMT")+"" ,"13");  //세액
  DISKET+=strStr(gcds_down_data.namevalue(i,"FILLER")  ,"54");    //공란
  gcds_data99.addrow();
  
  gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}


/******************************************************************************
	Description : tail
	          "FDCODE",	"RCDGB",	"ACCYY",	 "ACCHF",	  "HALFNO",	 "VENDID",	
					"DCNT", 	"TVCNT",	"NUMEXP1", "TREQAMT",	"NUMEXP2", "TTAXAMT",	"FILLER"

******************************************************************************/
function ln_Forward_Batch_tail(i){
  var DISKET = "";
  DISKET+=strStr(gcds_down_tail.namevalue(i,"RCDGB")   ,"2");   //레코드구분
  DISKET+=strStr(gcds_down_tail.namevalue(i,"ACCYY")   ,"4");   //귀속년도
  DISKET+=strStr(gcds_down_tail.namevalue(i,"ACCHF")   ,"1");   //반기구분
  DISKET+=strStr(gcds_down_tail.namevalue(i,"HALFNO")  ,"1");   //반기내월순번
  DISKET+=strStr(gcds_down_tail.namevalue(i,"VENDID")  ,"10");  //수취자 사업자등록번호
  DISKET+=intStr(gcds_down_tail.namevalue(i,"DCNT")+"" ,"7");   //상호(법인명)
  DISKET+=intStr(gcds_down_tail.namevalue(i,"TVCNT")+"","9");   //성명(대표자)
	DISKET+=strStr(gcds_down_tail.namevalue(i,"NUMEXP1") ,"1");   //음수표시
 	DISKET+=intStr(gcds_down_tail.namevalue(i,"TREQAMT")+"" ,"15");  //공급가액
	DISKET+=strStr(gcds_down_tail.namevalue(i,"NUMEXP2") ,"1");      //음수표시
	DISKET+=intStr(gcds_down_tail.namevalue(i,"TTAXAMT")+"" ,"15");  //세액
  DISKET+=strStr(gcds_down_tail.namevalue(i,"FILLER")  ,"74");     //공란
  gcds_data99.addrow();
  
  gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}



/******************************************************************************
	Description : 문자타입 공백 처리함.
******************************************************************************/
function strStr(a, b){
  var returnVal = "";
  if(a==null) a = "";
  var alength = calculateBytes(a);
  var tt = calculateBytesStr(a,b);

  if(alength<=b){
    returnVal+=a;
    for(var i=0; i<b-alength; i++){
      returnVal+=" ";
    }
  }else{
    returnVal = tt;
  }
  return returnVal;
}

/******************************************************************************
	Description : 숫자타입 공백 0으로 처리함.
******************************************************************************/
function intStr(a, b){

  var returnVal="";
  if(a==null) a="";
  var alength=a.length;

  if(alength<b){
    for(var i=0; i<b-alength; i++){
      returnVal+="0";
    }
  }
  returnVal+=a;

  return returnVal;
}
function minorintStr(a, b){
  var returnVal="";
  if(a==null) a="";
  var temp = "";  
  var rst = "";
  if(a<0){
    a = strReplace(a, "-", "0");

    for(var k=0; k<a.length; k++){
      temp = a.charAt(k);
      if(k+1==a.length){
        temp=strReplace(temp, "0","}");
        temp=strReplace(temp, "1","J");
        temp=strReplace(temp, "2","K");
        temp=strReplace(temp, "3","L");
        temp=strReplace(temp, "4","M");
        temp=strReplace(temp, "5","N");
        temp=strReplace(temp, "6","O");
        temp=strReplace(temp, "7","P");
        temp=strReplace(temp, "8","Q");
        temp=strReplace(temp, "9","R");
      }
      rst += temp;
    }
  }else{
    rst = a;
  }

  var alength=rst.length;
  if(alength<b){
    for(var i=0; i<b-alength; i++){
      returnVal+="0";
    }
  }
  returnVal+=rst;
  return returnVal;
}

/******************************************************************************
	Description : 바이트 처리 
******************************************************************************/
function calculateBytes(szValue){
  var tcount = 0;
  var tmpStr = new String(szValue);
  var temp = tmpStr.length;
  var onechar;
  for ( k=0; k<temp; k++ ){
    onechar = tmpStr.charAt(k);
    if (escape(onechar).length > 4){
      tcount += 2;
    }
    else{
      tcount += 1;
    }
  }
  return tcount;
}
function calculateBytesStr(szValue,b){
  var tcount = 0;
  var tstr = "";
  var tmpStr = new String(szValue);
  var temp = tmpStr.length;
  var onechar;
  for ( k=0; k<temp; k++ ){
    onechar = tmpStr.charAt(k);
    if (escape(onechar).length > 4){
      tcount += 2;
      tstr += onechar;
    }
    else{
      tcount += 1;
      tstr += onechar;
    }
    if(tcount==b) break;
  }
  return tstr;
}

function strReplace(str, src, dest) {
  var reg = new RegExp(src, "gi");
  return str.replace(reg, dest);
}

/******************************************************************************
	Description : 엑셀 다운로드
******************************************************************************/
function ln_Excel(){

	gcgd_disp01.GridToExcel("신용카드수취명세서","",2);
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_head classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--입력관련  -->
<object  id=gcds_ihead classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--내려받기 -->
<object  id=gcds_data99 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_down_head classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_down_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_down_tail classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
	}else{
	}
</script>

<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
//		gclx_sfdcode.index=2;
	}else{
//		gclx_sfdcode.bindcolval=gs_fdcode;
	}
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
 <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a050010_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif" align="right">&nbsp;</td>
	</tr>
	<tr><td height=4></td></tr>
</table>

<!-- 매입 ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:20px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>사업소</nobr></td>
					<td class="tab23" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:1px;font-size:12px;width:70px;height:200px;">
								<param name=CBData					value="02^서울,01^고성">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDNAM^0^70">
								<param name=BindColumn			value="CDCODE">
							</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>년&nbsp;&nbsp;&nbsp;&nbsp;도</nobr></td>
					<td class="tab23" style="width:60px"><comment id="__NSID__">
						<object id=gcem_saccyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px;width:35px;height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>&nbsp;분&nbsp;기&nbsp;수&nbsp;</nobr></td>
					<td style="width:100px;"><nobr><comment id="__NSID__">
						<object  id=gclx_saccyyqt classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:90px;height:110px;">
							<param name=CBData					value="1^1기예정,2^1기확정,3^2기예정,4^2기확정">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^90">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
					</td>
					<td align="right">&nbsp;<nobr>      
						<!-- <img src="../../common/img/btn/com_b_print.gif" style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('01')"> -->
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px"	onclick="ln_Excel()">
						<img src="../../Common/img/btn/com_b_create.gif"  style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Create()">
						<img src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query()"> 
						</nobr>
					</td>
				</tr>
			</table>
				</td>
			</tr>
			<tr><!-- 매입 ----------------------------------------------------------------------------------------->
				<td style="position:relative;left:6px">
					<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>상호(법인명)</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object id=gcem_vendnm0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:230px">
									<param name=Text				value="">
									<param name=Alignment		value=0>
									<param name=Border			value=true>
									<param name=GeneralEdit value="true">
									<param name=Language		value=1>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>사업자등록번호</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_vendid0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=BackColor     value="#CCCCCC">
									<param name=Format			  value="000-00-00000">
									<param name=PromptChar	  value="_">
									<param name=InheritColor  value=false>
									<param name=ReadOnly      value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>대표자명</nobr></td>
							<td class="tab23" style="width:256px"><comment id="__NSID__">
								<object  id=gcem_vddirect0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:230px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
									<param name=ReadOnly      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>법인등록번호</nobr></td>
							<td style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_vendno0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=Format			  value="000000-0000000">
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
									<param name=ReadOnly      value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr><!-- 매입2 ----------------------------------------------------------------------------------------->
				<td style="position:relative;left:6px;top:2px">
					<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
						<tr>
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>구&nbsp;&nbsp;&nbsp;&nbsp;분</nobr></td>
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>거래건수</nobr></td>
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>공급가액</nobr></td>
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>세&nbsp;&nbsp;&nbsp;&nbsp;액</nobr></td>
							<td class="tab13" style="width:173px;" bgcolor="#eeeeee"><nobr>비&nbsp;&nbsp;&nbsp;&nbsp;고</nobr></td>
						</tr>
						<tr>
							<td class="tab11" style="width:173px;"><nobr>합&nbsp;계&nbsp;분</nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_tvcnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_treqamt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_ttaxamt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							 <td class="tab22" style="width:173px;"><nobr>&nbsp;</nobr></td>
						</tr>
             <tr>
              <td class="tab11" style="width:173px;"><nobr>현금영수증</nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_tvcnt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_treqamt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_ttaxamt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab22" style="width:173px;"><nobr>&nbsp;</nobr></td>
						</tr>
						<tr>
							<td class="tab11" style="width:173px;"><nobr>화물운전자복지카드</nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_tvcnt3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_treqamt3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_ttaxamt3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td  class="tab22" style="width:173px;"><nobr>&nbsp;</nobr></td>
						</tr>
            <tr>
							<td class="tab11" style="width:173px;"><nobr>사업용신용카드</nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_tvcnt4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_treqamt4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab11" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_ttaxamt4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>						
						    <td class="tab22" style="width:173px;"><nobr>&nbsp;</nobr></td>		
						 </tr>
						 <tr>
              <td class="tab12" style="width:173px;"><nobr>기타신용카드</nobr></td>
							<td class="tab12" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_tvcnt1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab12" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_treqamt1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td class="tab12" style="width:173px;"><nobr><comment id="__NSID__">
								<object id=gcem_ttaxamt1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:135px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr></td>
							<td  style="width:173px;"><nobr>&nbsp;</nobr></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr><td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:220px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data">
							<PARAM NAME="Editable"			VALUE="false">
							<PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM NAME="IndWidth"			VALUE="0">
							<PARAM NAME="ColSizing"			VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name=SortView  value="Left">
							<PARAM NAME="viewSummary"		VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<C> Name='일련번호'	      ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	   	align=center	SumText=@count	SumBgColor='#C3D0DB' BgColor={decode(CARDNO,'0000000000000000    ','Orange','')}</C> 
								<C> Name='카드회원번호'  	ID=CARDNO 	HeadAlign=Center HeadBgColor=#B9D4DC Width=200		align=center	SumText='계'	  SumBgColor='#C3D0DB' sort=true mask='XXXX-XXXX-XXXX-XXXX' BgColor={decode(CARDNO,'0000000000000000    ','Orange','')} </C>
								<C> Name='공급자(가맹점)\\사업자등록번호'		ID=AFVENDID	HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=center	SumText=''	SumBgColor='#C3D0DB' sort=true mask='XXX-XX-XXXXX' BgColor={decode(CARDNO,'0000000000000000    ','Orange','')}</C>
								<G> Name='기타 신용카드 등 거래내역 합계' HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='거래건수'			ID=VCNT 		HeadAlign=Center HeadBgColor=#B9D4DC Width=145		align=right		SumText=@sum	SumBgColor='#C3D0DB' sort=true BgColor={decode(CARDNO,'0000000000000000    ','Orange','')}</C>
								<C> Name='공급가액'		  ID=REQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=145		align=right		SumText=@sum	SumBgColor='#C3D0DB' sort=true BgColor={decode(CARDNO,'0000000000000000    ','Orange','')}</C>
								<C> Name='세액'   	    ID=TAXAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=145		align=right		SumText=@sum	SumBgColor='#C3D0DB' sort=true BgColor={decode(CARDNO,'0000000000000000    ','Orange','')}</C>
							  </G>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<tr>
			</table>			
		</td> 
	</tr> 
	<tr>
    <td>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
				<tr>
					<td style="width:173px;position:relative;left:5px;top:3px"><nobr><FONT SIZE="2" COLOR="blue"><B>[내려받기]</B></FONT></nobr></td>
					<td align="right">&nbsp;<nobr>      
						<img src="../../Common/img/btn/com_b_down.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onclick="ln_Download()">
						<img src="../../Common/img/btn/com_b_query.gif"	    style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Down_Query()"> 
						</nobr>
					</td>
				</tr>
				<tr>
					<td colspan =2>
						<comment id="__NSID__">
						<OBJECT id=gcgd_data01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="width:867px;height:160px;position:relative;left:5px;border:1 solid #777777;">
							<PARAM NAME="DataID"			VALUE="gcds_data99">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<param name="ColSelect"		value="false">
							<param name="ColSizing"		value="true">
							<PARAM NAME="Format"			VALUE="  
								<C> Name=''	ID=DISKET	HeadAlign=Center HeadBgColor=#B9D4DC Width=843	align=left</C>
							">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table> 
			 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [HEAD]
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_head classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_head>
	<param name=BindInfo		value='  
		<C>Col=VENDNM			Ctrl=gcem_vendnm0				Param=text</C>
		<C>Col=VENDID			Ctrl=gcem_vendid0				Param=text</C>
		<C>Col=VDDIRECT	  Ctrl=gcem_vddirect0			Param=text</C>
		<C>Col=VENDNO		  Ctrl=gcem_vendno0			  Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [DATA2]
------------------------------------------------------------------------------>
<comment id="__NSID__">

  <object  id=gcbn_data1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID		value=gcds_data1>
	<param name=BindInfo	value='  
	  <C>Col=TVCNT1 			Ctrl=gcem_tvcnt1	  		Param=text</C>
		<C>Col=TREQAMT1			Ctrl=gcem_treqamt1			Param=text</C>
		<C>Col=TTAXAMT1			Ctrl=gcem_ttaxamt1			Param=text</C>
		<C>Col=TVCNT2 			Ctrl=gcem_tvcnt2	  		Param=text</C>
		<C>Col=TREQAMT2			Ctrl=gcem_treqamt2			Param=text</C>
		<C>Col=TTAXAMT2			Ctrl=gcem_ttaxamt2			Param=text</C>
		<C>Col=TVCNT3 			Ctrl=gcem_tvcnt3	  		Param=text</C>
		<C>Col=TREQAMT3			Ctrl=gcem_treqamt3			Param=text</C>
		<C>Col=TTAXAMT3			Ctrl=gcem_ttaxamt3			Param=text</C>
		<C>Col=TVCNT4 			Ctrl=gcem_tvcnt4	  		Param=text</C>
		<C>Col=TREQAMT4			Ctrl=gcem_treqamt4			Param=text</C>
		<C>Col=TTAXAMT4			Ctrl=gcem_ttaxamt4			Param=text</C>
		<C>Col=TVCNT  			Ctrl=gcem_tvcnt     		Param=text</C>
		<C>Col=TREQAMT			Ctrl=gcem_treqamt 			Param=text</C>
		<C>Col=TTAXAMT			Ctrl=gcem_ttaxamt 			Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__">

<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 