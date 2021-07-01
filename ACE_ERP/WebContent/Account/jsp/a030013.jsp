<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 관리항목별잔액장		
+ 프로그램 ID	:  A030013.html
+ 기 능 정 의	:  관리항목벼잔액장을 조회 하는 화면이다
+ 작   성  자 :  
+ 작 성 일 자 : 
-----------------------------------------------------------------------------
+ 수 정 내 용 :	관리항목 event 추가
+ 수   정  자 : 이 순 미
+ 수 정 일 자 :
-----------------------------------------------------------------------------
+ 수 정 내 용 :	전체적인 수정
+ 수   정  자 : 정 영 식
+ 수 정 일 자 : 2006.03.17
-----------------------------------------------------------------------------
+ 수 정 내 용 :	레포트
+ 수   정  자 : 구 자 헌 
+ 수 정 일 자 : 2006.03.17
-----------------------------------------------------------------------------
+ 수 정 내 용 :	현업요구 반영 - 계정코드 추가
+ 수   정  자 : 정영식
+ 수 정 일 자 : 2006.10.03
-----------------------------------------------------------------------------
+ 수 정 내 용 :	현업요구 반영 - 출력물수정
+ 수   정  자 : 이민정
+ 수 정 일 자 : 2006.10

-----------------------------------------------------------------------------
+ 서 블 릿 명	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>관리항목별잔액장</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../common/include/common.css">

<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../common/include/PubFun.js"></script>

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
//get_cookdata();

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_hisdat = gs_date;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
  
	ln_Before();

}

/******************************************************************************
	Description : 선 조회
******************************************************************************/
function ln_Before() {

	//gcem_hisdat_fr.text		 = gs_date2 + "01";	    //처분일자 from
	gcem_actdat_fr.text=gs_date2 + "01";
	gcem_actdat_to.text=gs_date;	            	//처분일자 to 
	
	//지점코드[검색]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();
	
	//관리항목[검색]
	/***
	gcds_fsrefcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0050";  
	gcds_fsrefcd.Reset();
	***/

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){ 

	var str1 = gclx_fdcode.BindColVal;                //지점코드
	var str2 = gcem_actdat_fr.text;                   //기간 from
	var str3 = gcem_actdat_to.text;                   //기간 to
	var str4 = gclx_fsrefcd.BindColVal;               //관리항목
	var str5 = gcem_vend_fr.text;											//관리항목 from
	var str6 = gcem_vend_to.text;									    //관리항목 to
	var str7 = gcem_atcode_fr01.text;									//계정과목
 
  if(!ln_Chk()) return;

	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030013_s1"
									  + "?v_str1="+str1+"&v_str2="+str2
									  + "&v_str3="+str3+"&v_str4="+str4
									  + "&v_str5="+str5+"&v_str6="+str6
										+ "&v_str7="+str7;
	gcds_code01.Reset(); 
}

/******************************************************************************
	Description : 등록
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
	Description : 출력
	parameter   : 
******************************************************************************/
function ln_Print(){


	var str1 = gclx_fdcode.BindColVal;                //지점코드
	var str2 = gcem_actdat_fr.text;                   //기간 from
	var str3 = gcem_actdat_to.text;                   //기간 to
	var str4 = gclx_fsrefcd.BindColVal;               //관리항목
	var str5 = gcem_vend_fr.text;											//관리항목 from
	var str6 = gcem_vend_to.text;									    //관리항목 to
	var str7 = gcem_atcode_fr01.text;									//계정과목
 
  if(!ln_Chk()) return;

	gcds_print1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030013_s1"
									  + "?v_str1="+str1+"&v_str2="+str2
									  + "&v_str3="+str3+"&v_str4="+str4
									  + "&v_str5="+str5+"&v_str6="+str6
										+ "&v_str7="+str7;
	gcds_print1.Reset(); 
}

/******************************************************************************
	Description : 엑셀
	parameter   : 
******************************************************************************/
function ln_Excel(){

//	gcgd_disp01.runexcel("관리항목별잔액장");

     gcgd_disp01.GridToExcel("관리항목별잔액장","",2);
}

/******************************************************************************
	Description : FILE 
******************************************************************************/
function ln_File(){

}

/******************************************************************************
	Description : Enable _ Disabled 
	parameter   : p==> t - Enable, f - Disable
	          
******************************************************************************/
function ln_Enable(p) {
	
}

/******************************************************************************
	Description : 거래처 찾기
******************************************************************************/
function ln_Popup(p){             

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	if(!ln_Chk()) return;

	if(gclx_fsrefcd.bindcolval=="0020"){
	  arrParam[0]="";
		arrParam[1]="";
		strURL = "./gczm_vender_popup.jsp";
	  strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
   }else if(gclx_fsrefcd.bindcolval=="0002"){
	  arrParam[0]="";
		arrParam[1]="";
		strURL = "./hcdept_popup.jsp";
	  strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else{
	  arrParam[0]=gclx_fsrefcd.bindcolval;
		arrParam[1]="";
		strURL = "./commdtil_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}
	
	arrResult = showModalDialog(strURL,arrParam,strPos);

if (arrResult != null) {
		arrParam = arrResult.split(";");
		 if(p=="fr") {
				gcem_vend_fr.text = arrParam[0];
				txt_vend_fr.value = arrParam[1];
				gcem_vend_to.text = arrParam[0];
			  txt_vend_to.value = arrParam[1];
		 }else if(p=="to"){
				gcem_vend_to.text = arrParam[0];
				txt_vend_to.value = arrParam[1];
			}
	} else {
		if(p=="fr") {
			gcem_vend_fr.text = "";
			txt_vend_fr.value ="";
		}else if(p=="to"){
			gcem_vend_to.text = "";
			txt_vend_to.value = "";
		}
	}
}


/******************************************************************************
	Description :  계정과목 찾기
	parameter    : p1 - 구분    (01 - 버튼, 02 - enter)
	               obj - object명 
******************************************************************************/
function ln_Onblur_Atcode(p1,obj){
  var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
 
	arrParam[0]='ATUSEYN';

	if(p1=="02"){
		if(event.keyCode!=113&&event.keyCode!=13) return;
		arrParam[1]=eval(obj).text;
	}else if(p1=="01"){
    arrParam[1]="";
	}
	
	strURL = "./actcode_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		gcem_atcode_fr01.text = arrResult[0];
		gcem_atkornam_fr01.text = arrResult[1];
		//해당 계정의 관리항목만 가져옴.

		//관리항목[검색]
		gcds_fsrefcd.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+arrResult[0];	
		gcds_fsrefcd.Reset();

	}else{
		gcem_atcode_fr01.text = "";
		gcem_atkornam_fr01.text ="";
	}
}
/******************************************************************************
	Description :  관리항목 찾기
	parameter    : p1 - 구분    ( fr, to)
	               obj - object명 
******************************************************************************/
function ln_Onblur(p1,obj){
  var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	if(event.keyCode!=113&&event.keyCode!=13) return;

	if(!ln_Chk()) return;

	if(gclx_fsrefcd.bindcolval=="0020"){
	  arrParam[0]="";
    arrParam[1]=eval(obj).value;
		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else if(gclx_fsrefcd.bindcolval=="0002"){
	  arrParam[0]="";
    arrParam[1]=eval(obj).value;
		strURL = "./hcdept_popup.jsp";
		strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else{
	  arrParam[0]=gclx_fsrefcd.bindcolval;
    arrParam[1]=eval(obj).value;
		strURL = "./commdtil_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}
		
	arrResult = showModalDialog(strURL,arrParam,strPos);

  if (arrResult != null) {
		arrParam = arrResult.split(";");
		if (p1=="fr"){
			gcem_vend_fr.text = arrParam[0];
			txt_vend_fr.value = arrParam[1];
			gcem_vend_to.text = arrParam[0];
			txt_vend_to.value = arrParam[1];
		}else if(p1=="to"){
			gcem_vend_to.text = arrParam[0];
			txt_vend_to.value = arrParam[1];
		}
	} else {
		if(p1=="fr") {
			gcem_vend_fr.text = "";
			txt_vend_fr.value ="";
		}else if(p1=="to"){
			gcem_vend_to.text = "";
			txt_vend_to.value = "";
		}
	}
}


function ln_Chk(){

  if (gcem_atcode_fr01.text=="") {
			alert("관리항목을 선택하십시요") ;
			gclx_fsrefcd.Focus();
			return false;
	}
	
	if (gclx_fsrefcd.bindcolval=="") {
			alert("관리항목을 선택하십시요") ;
			gclx_fsrefcd.Focus();
			return false;
	}
	
	return true;
}

function ln_Clear(){
	gcem_vend_fr.text = "";
	txt_vend_fr.value ="";
	gcem_vend_to.text = "";
	txt_vend_to.value = "";
}

/******************************************************************************
	Description : Dataset Head 설정 - 전표 Detail
******************************************************************************/
function ln_SetDataHeader(){

		if (gcds_print2.countrow<1){
			var s_temp = "FDCODE:STRING,ATCODE:STRING,COCODE:STRING,DIVCD:STRING,";
			s_temp+="DEPTCD:STRING,FSREFCD:STRING,FSREFVAL:STRING,ATKORNAM:STRING,CDNAM:STRING,";
			s_temp+="BEVAL:DECIMAL,DETOT:DECIAML,CRTOT:DECIAML,SLPVAL:DECIMAL,FSREFNM:STRING,";
			s_temp+="FDCODENM:STRING,FDCODENM2:STRING,CURDT:STRING,CURDT2:STRING";
			gcds_print2.SetDataHeader(s_temp);
		}
	}

/***********************************************************************************************
	Description : 레포트 컬럼 삽입하기
	parameter   : 
**********************************************************************************************/
function ln_Sum(){
	for(i=1;i<=gcds_print1.countrow;i++){
	gcds_print2.addrow();
	gcds_print2.namevalue(i,"FDCODE")=gcds_print1.namevalue(i,"FDCODE");
	gcds_print2.namevalue(i,"ATCODE")=gcds_print1.namevalue(i,"ATCODE");
	gcds_print2.namevalue(i,"COCODE")=gcds_print1.namevalue(i,"COCODE");
	gcds_print2.namevalue(i,"DIVCD")=gcds_print1.namevalue(i,"DIVCD");
	gcds_print2.namevalue(i,"DEPTCD")=gcds_print1.namevalue(i,"DEPTCD");
	gcds_print2.namevalue(i,"FSREFCD")=gcds_print1.namevalue(i,"FSREFCD");
	gcds_print2.namevalue(i,"FSREFVAL")=gcds_fsrefcd4.namevalue(gcds_fsrefcd4.valuerow(gcds_fsrefcd4.columnindex("CDCODE"),gcds_print1.namevalue(i,"FSREFVAL")),"CDNAM");
	gcds_print2.namevalue(i,"ATKORNAM")=gcds_print1.namevalue(i,"ATKORNAM");
	gcds_print2.namevalue(i,"FSREFNM")=gcds_print1.namevalue(i,"FSREFNM");
	gcds_print2.namevalue(i,"CDNAM")=gcds_print1.namevalue(i,"CDNAM");
	gcds_print2.namevalue(i,"BEVAL")=gcds_print1.namevalue(i,"BEVAL");
	gcds_print2.namevalue(i,"DETOT")=gcds_print1.namevalue(i,"DETOT");
	gcds_print2.namevalue(i,"CRTOT")=gcds_print1.namevalue(i,"CRTOT");
	gcds_print2.namevalue(i,"SLPVAL")=gcds_print1.namevalue(i,"SLPVAL");
	//gcds_print2.ImportData(gcds_print1.ExportData(i,1,false));

	//[이순미:코드추가 START]---------------------------------------------------------------------
	gcds_print2.namevalue(1,"FDCODENM") = gclx_fdcode.text;
	gcds_print2.namevalue(1,"FDCODENM2") = gclx_fsrefcd.text
	gcds_print2.namevalue(1,"CURDT")		= gcem_actdat_fr.text + gcem_actdat_to.text;
	gcds_print2.namevalue(1,"CURDT2")		= gs_date;
	//[이순미:코드추가 END]-----------------------------------------------------------------------
	}
}

/***********************************************************************************************
	Description : 관리항목 계정원장 팝업
	parameter   : fcod-지점코드, atcod-계정코드, frdt-검색일자(from), todt-검색일자(to)
	parameter   : fsrefcd-관리항목코드, fsrefva-관리항목값, arrParam[10] - 관리항목구분[잔액장]
	코드 수정   : 이순미 - 2006/03/30
**********************************************************************************************/
function ln_Popup2(fcod,atcod,frdt,todt,fsrefcd,fsrefva){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam[0] = fcod;			
	arrParam[1] = atcod;
	arrParam[2] = frdt;
	arrParam[3] = todt;
	arrParam[4] = fsrefcd;	
	arrParam[5] = fsrefva;	
	arrParam[10] = "A";			
	arrParam[11] = "1";			

	strURL = "./mtotalbal_popup.jsp";
	strPos = "dialogWidth:888px;dialogHeight:545px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 지점코드 -->
<comment id="__NSID__"><object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 관리항목 -->
<comment id="__NSID__"><object  id="gcds_fsrefcd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 관리항목 from -->
<comment id="__NSID__"><object  id="gcds_fsrefval_fr" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 관리항목 to -->
<comment id="__NSID__"><object  id="gcds_fsrefval_to" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 관리항목 temp -->
<comment id="__NSID__"><object  id="gcds_fsrefcd2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 관리항목 부서 -->
<comment id="__NSID__"><object  id="gcds_fsrefcd3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 관리항목 공통코드 -->
<comment id="__NSID__"><object  id="gcds_fsrefcd4" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">

   //alert("BEVAL::"+ gcds_code01.namevalue(row,"BEVAL"));

	window.status="조회가 완료 되었습니다.";
	ft_cnt.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	//if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<!-- 지점 -->
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="전체";
	if(gs_userid=="ACCOUNT"){
		gclx_fdcode.index=2;
	}else{
		gclx_fdcode.bindcolval=gs_fdcode;
	}
</script>

<!-- 관리항목 -->
<script language="javascript" for="gcds_fsrefcd" event="onloadCompleted(row,colid)">
	//window.status="조회가 완료 되었습니다.";   
	//document.all.LowerFrame.style.visibility="hidden";      //마지막으로 로딩되는것은 hidden으로
	//gclx_fsrefcd.ComboDataID="";
	gcds_fsrefcd.InsertRow(1);
	gcds_fsrefcd.NameValue(1,"CDCODE")="";
	gcds_fsrefcd.NameValue(1,"CDNAM")="";
	gclx_fsrefcd.index=0;
  //gclx_fsrefcd.ComboDataID ="gcds_fsrefcd";
</script>

<script language="javascript" for="gcds_print1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_print1 event=OnLoadCompleted(row,colid)>
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	gcds_print2.ClearData();
	ln_SetDataHeader();
	ln_Sum();
	gcrp_print.preview(); 

</script>

<!-- 관리항목 -->
<script language="javascript" for="gcds_fsrefcd4" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_fsrefcd4" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	//if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for= gclx_fsrefcd event=OnCloseUp()>
	//////ln_Clear();
	/*
	if(gclx_fsrefcd.bindcolval==""){	//전체
	}else if(gclx_fsrefcd.bindcolval=="0020"){ //거래처
	gcgd_disp01.ColumnProp('FSREFVAL','EditStyle')="Lookup";
	gcgd_disp01.ColumnProp('FSREFVAL','Data') = 'gcds_fsrefcd2:VEND_CD:VEND_NM'; // Lookup
	gcds_fsrefcd2.DataID = g_servlet+"/Account.a010003_s0?v_str1=&v_str2=";
  gcds_fsrefcd2.Reset();
	}else if(gclx_fsrefcd.bindcolval=="0002"){  //부서
	gcgd_disp01.ColumnProp('FSREFVAL','EditStyle')="Lookup";
	gcgd_disp01.ColumnProp('FSREFVAL','Data') = "gcds_fsrefcd3:DEPTCD:DEPTNM";
	gcds_fsrefcd3.DataID = g_servlet+"/Person.hcdept_s1?v_str1=";
	gcds_fsrefcd3.Reset();
	}else {	//공통 //관리항목[검색]*/
	/****
	gcgd_disp01.ColumnProp('FSREFVAL','EditStyle')="Lookup";
	gcgd_disp01.ColumnProp('FSREFVAL','Data')  = "gcds_fsrefcd4:CDCODE:CDNAM";
	gcds_fsrefcd4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>Account.commdtil_s1?v_str1="+gclx_fsrefcd.bindcolval;  
	gcds_fsrefcd4.Reset();
	***/
	//}
</script>

<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>
	/***코드수정 : 이순미 **********************************************/
	var fcod		= gclx_fdcode.bindcolval;									//지점코드
	var atcod		= gcds_code01.namevalue(row,"ATCODE");		//계정코드
	var frdt		= gcem_actdat_fr.text;										//검색일자 fr
	var todt		= gcem_actdat_to.text;										//검색일자 to
	var fsrefcd	= gcds_code01.namevalue(row,"FSREFCD");		//관리항목코드
	var fsrefva = gcds_code01.namevalue(row,"FSREFVAL");	//관리항목값
	ln_Popup2(fcod,atcod,frdt,todt,fsrefcd,fsrefva);			//관리항목 팝업
	/***코드수정 : 이순미 **********************************************/
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
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030013_1_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif"  align=right>
			<img src="../../Common/img/btn/com_b_print.gif"	style="cursor:hand" onclick="ln_Print()">
			<img src="../../Common/img/btn/com_b_excel.gif"	style="cursor:hand" onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query()">
		</td>
  </tr>
  <tr>  
    <td colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
				 <td width="80px"  style="" bgcolor="#eeeeee" class="tab21" align=center >지점코드</td>
					<td class="tab21" style="width:110px;">
					<comment id="__NSID__"><object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_fdcode">
								<param name=CBDataColumns		value="FDCODE, FDNAME">
								<param name=SearchColumn		value=FDNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="FDNAME^0^140">
								<param name=BindColumn			value=FDCODE>
							</object></comment><script>__ws__(__NSID__);</script> 
						</td> 
					<td class="tab21" bgcolor="#eeeeee" align="center" width="80">기&nbsp;&nbsp;간</td> 
				  <td class="tab21" style="width:230px;"  >&nbsp;    
						<comment id="__NSID__"><object  id=gcem_actdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
						style="position:relative;top:2px;left:0px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat_fr', 'Text')" style="position:relative;width:20px;left:-4px;top:1px;cursor:hand;">~
					&nbsp;
           <comment id="__NSID__"><object  id=gcem_actdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
						style="position:relative;top:2px;left:0px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat_to', 'Text')" style="position:relative;width:20px;left:4px;top:1px;cursor:hand;">
					</td> 
					
					<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">계정과목</td>
					<td class="tab22" width="199px"><nobr>
					
					<comment id="__NSID__"><object  id=gcem_atkornam_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:5px;top:2px;" onkeydown="ln_Onblur_Atcode('02','gcem_atkornam_fr01')";">
			      <param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:0px" align=center onclick="ln_Onblur_Atcode('01','');">
					<comment id="__NSID__"><object  id=gcem_atcode_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:5px;top:2px;">
			      <param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					
					</nobr>
				 </td>			
				
					<tr>
						<td width="80px"  style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:9pt; 
						   " bgcolor="#eeeeee" align=center >관리항목</td>
						<td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:9pt; " colspan="5" >

							<comment id="__NSID__"><object  id=gclx_fsrefcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:4px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_fsrefcd">
								<param name=CBDataColumns		value="CDCODE, CDNAM">
								<param name=SearchColumn		value=CDNAM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="CDNAM^0^140">
								<param name=BindColumn			value=CDCODE>
						</object></comment><script>__ws__(__NSID__);</script>  &nbsp;
				  	
							<input id="txt_vend_fr" type="text" class="txtbox"  style= "position:relative;left:2px;top:-3px;width:160px; height:20px;" maxlength="36" onkeydown="ln_Onblur('fr','txt_vend_fr');" > 
						  <img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="검색합니다" style="cursor:hand;position:relative;left:2px;top:2px" align=center onclick="ln_Popup('fr');">
							<comment id="__NSID__"><object  id=gcem_vend_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:84px;height:20px;position:relative;left:7px;top:4px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="#############">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script> &nbsp; ~ &nbsp;

							
							<input id="txt_vend_to" type="text" class="txtbox"  style= "position:relative;left:1px;top:-3px;width:160px; height:20px;" maxlength="36" onkeydown="ln_Onblur('to','txt_vend_to');" >
						  <img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="검색합니다" style="cursor:hand;position:relative;left:1px;top:3px" align=center onclick="ln_Popup('to');">
							<comment id="__NSID__"><object  id=gcem_vend_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:84px;height:20px;position:relative;left:3px;top:4px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="#############">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script> 
              <img SRC="../../Common/img/btn/com_b_clear.gif" BORDER="0" style="cursor:hand;position:relative;left:3px;top:4px" align=center onclick="ln_Clear();">
							
						</td> 
				</tr>
			</table>
		</td>
	</tr>  
							
	<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;top:3px;width:280px;border:0 solid #708090;">
		<tr> 			
			<td style="width:280" ALIGN=LEFT VALIGN=TOP>
				<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
					style="position:relative;left:3px;width:875px; height:400px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_code01">
						<PARAM NAME="IndWidth"		VALUE ='0'>
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<PARAM NAME="Sortview"		VALUE="left">
						<param name="ViewSummary"	value=1>
						<param name="ColSizing"   value="true">
						<Param Name="Editable"     value="false"> 
						<PARAM NAME="Format"			VALUE=" 
						<C> Name='계정코드'	 ID=ATCODE HeadAlign=Center HeadBgColor=#B9D4DC SumBgColor=#C3D0DB Width=80	align=center	  Edit=none  SumText=합계 sort = true supress=2 show=false</C> 
						<C> Name='계정과목'	 ID=ATKORNAM	HeadAlign=Center HeadBgColor=#B9D4DC SumBgColor=#C3D0DB Width=130	align=left	  Edit=none  SumText=합계 sort = true supress=2 </C> 
						<C> Name='관리항목'	 ID=FSREFVAL  HeadAlign=Center HeadBgColor=#B9D4DC SumBgColor=#C3D0DB Width=80	 align=center		show=false  </C> 
						<C> Name='관리항목'	 ID=FSREFNM   HeadAlign=Center HeadBgColor=#B9D4DC SumBgColor=#C3D0DB Width=235	align=left		show=true  sort = true  supress=1 </C> 
						<C> Name='전기이월'	 ID=BEVAL 	  HeadAlign=Center HeadBgColor=#B9D4DC SumBgColor=#C3D0DB Width=120	align=right	  Edit=none  SumText=@sum </C> 
						<C> Name='차변'			 ID=DETOT 		HeadAlign=Center HeadBgColor=#B9D4DC SumBgColor=#C3D0DB Width=120	align=right   Edit=none  SumText=@sum</C> 
						<C> Name='대변'			 ID=CRTOT			HeadAlign=Center HeadBgColor=#B9D4DC SumBgColor=#C3D0DB Width=120	align=rigth	  SumText=@sum </C> 
						<C> Name='잔액'			 ID=SLPVAL 		HeadAlign=Center HeadBgColor=#B9D4DC SumBgColor=#C3D0DB Width=130	align=right   Edit=none SumText=@sum </C> 
						"><!--
						<C> Name='관리항목'	 ID=FSREFCD 	HeadAlign=Center HeadBgColor=#B9D4DC SumBgColor=#C3D0DB Width=155	align=center  Edit=none  show = false </C> 
						<C> Name='관리항목'	 ID=FSREFVAL  HeadAlign=Center HeadBgColor=#B9D4DC SumBgColor=#C3D0DB Width=155	align=left		show=true  </C> 
						<C> Name='관리항목'	 ID=FSREFVAL2 HeadAlign=Center HeadBgColor=#B9D4DC SumBgColor=#C3D0DB Width=155	align=left		show=false</C> 
						<C> Name='관리항목'	 ID=FSREFVAL3 HeadAlign=Center HeadBgColor=#B9D4DC SumBgColor=#C3D0DB Width=155	align=left		show=false</C> 
						<C> Name='계정과목'	 ID=ATKORNAM	HeadAlign=Center HeadBgColor=#B9D4DC SumBgColor=#C3D0DB Width=210	align=left	  Edit=none  SumText=합계 sort = true </C> 
						<C> Name='전기이월'	 ID=BEVAL 	  HeadAlign=Center HeadBgColor=#B9D4DC SumBgColor=#C3D0DB Width=120	align=right	  Edit=none  SumText=@sum </C> 
						<C> Name='차변'			 ID=DETOT 		HeadAlign=Center HeadBgColor=#B9D4DC SumBgColor=#C3D0DB Width=120	align=right   Edit=none  SumText=@sum</C> 
						<C> Name='대변'			 ID=CRTOT			HeadAlign=Center HeadBgColor=#B9D4DC SumBgColor=#C3D0DB Width=120	align=rigth	  SumText=@sum </C> 
						<C> Name='잔액'			 ID=SLPVAL 		HeadAlign=Center HeadBgColor=#B9D4DC SumBgColor=#C3D0DB Width=130	align=right   Edit=none SumText=@sum </C> -->
				</object></comment><script>__ws__(__NSID__);</script> 
				<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
				&nbsp;<font id=ft_cnt style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</table>		

<!---------------------------------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
---------------------------------------------------------------------------------------------------->

<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcrp_print" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param name="MasterDataID"			    value="gcds_print2">
	<param name="DetailDataID"			    value="gcds_print2">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="true">
  <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="PaperSize"							VALUE="A4">	
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<PARAM NAME="Format"                VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=373 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1024 ,top=34 ,right=1863 ,bottom=111 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1016 ,top=21 ,right=1849 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='CURDT', left=860, top=119, right=2003, bottom=167 ,mask='(  기간 : XXXX년 XX월 XX일  ~  XXXX년 XX월 XX일  )', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='관 리 항 목 별 잔 액 장' ,left=1021 ,top=26 ,right=1844 ,bottom=87 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=220 ,top=373 ,right=2810 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=220 ,top=283 ,right=2810 ,bottom=283 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='잔  액' ,left=2447 ,top=291 ,right=2802 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='대 변' ,left=2077 ,top=291 ,right=2434 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='차 변' ,left=1709 ,top=291 ,right=2064 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1336 ,top=283 ,right=1336 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2810 ,top=283 ,right=2810 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2439 ,top=283 ,right=2439 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2072 ,top=283 ,right=2072 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1704 ,top=283 ,right=1704 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=220 ,top=283 ,right=220 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='계정과목' ,left=696 ,top=291 ,right=1328 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=688 ,top=283 ,right=688 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURDT2', left=2384, top=180, right=2805, bottom=228, align='right' ,mask='출력일자: XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Page : #p of #t' ,left=2384 ,top=228 ,right=2805 ,bottom=280 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM', left=447, top=180, right=1294, bottom=228, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='관리항목' ,left=278 ,top=291 ,right=640 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='전기이월' ,left=1339 ,top=291 ,right=1699 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='지점코드 :' ,left=230 ,top=180 ,right=431 ,bottom=228 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관리항목 :' ,left=230 ,top=228 ,right=431 ,bottom=275 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM2', left=447, top=228, right=1294, bottom=275, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=51 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=220 ,top=0 ,right=220 ,bottom=50 </L>
	<L> left=2810 ,top=0 ,right=2810 ,bottom=50 </L>
	<C>id='SLPVAL', left=2447, top=0, right=2802, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2439 ,top=0 ,right=2439 ,bottom=50 </L>
	<L> left=2072 ,top=0 ,right=2072 ,bottom=50 </L>
	<C>id='CRTOT', left=2077, top=0, right=2434, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DETOT', left=1709, top=0, right=2064, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1704 ,top=0 ,right=1704 ,bottom=50 </L>
	<L> left=1336 ,top=0 ,right=1336 ,bottom=50 </L>
	<C>id='ATKORNAM', left=696, top=0, right=1328, bottom=45, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=688 ,top=0 ,right=688 ,bottom=50 </L>
	<L> left=220 ,top=50 ,right=2810 ,bottom=50 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>
	<C>id='FSREFNM', left=225, top=0, right=685, bottom=45, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BEVAL', left=1339, top=0, right=1699, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=220 ,top=0 ,right=2810 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2871 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=220 ,top=0 ,right=220 ,bottom=50 </L>
	<L> left=688 ,top=0 ,right=688 ,bottom=50 </L>
	<L> left=1336 ,top=0 ,right=1336 ,bottom=50 </L>
	<L> left=1704 ,top=0 ,right=1704 ,bottom=50 </L>
	<L> left=2072 ,top=0 ,right=2072 ,bottom=50 </L>
	<L> left=2439 ,top=0 ,right=2439 ,bottom=50 </L>
	<L> left=2810 ,top=0 ,right=2810 ,bottom=50 </L>
	<T>id='합  계' ,left=696 ,top=8 ,right=1328 ,bottom=50 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='{Sum(BEVAL)}' ,left=1339 ,top=8 ,right=1699 ,bottom=50 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(DETOT)}' ,left=1709 ,top=8 ,right=2064 ,bottom=50 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(CRTOT)}' ,left=2077 ,top=8 ,right=2434 ,bottom=50 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(SLPVAL)}' ,left=2447 ,top=8 ,right=2802 ,bottom=50 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<L> left=220 ,top=50 ,right=2810 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1857 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=85</I>
	<L> left=222 ,top=0 ,right=2813 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>



">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 