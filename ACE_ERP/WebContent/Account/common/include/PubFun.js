var gs_daecod = "";	//전역변수 
var gs_gubun = "";
var gs_itnbr = "";
var old_gusrid = "";
var gusrpw = "";
var old_gusrnm = "";
var gediusr = "";
var gsecurity = "";
var gcurdate = "";
var gautlevel = "";

var gaccess_no =""; //출입계획 No

var gdeptcd = "";  //부서
var gdeptnm = "";  //부서명
var gfdcode = "";  //지점
var	gfdname = "";  //지점명
var	gcocode = "";  //사업장
var	gconame = "";  //사업장명
var	gjobdty = "";  //직책

var gs_appdt  = "" ; 

//var rDOMAIN = "http://www.singiro.co.kr";   //테스트 도메인URL
var rDOMAIN = "http://203.242.32.198";        //현대아산 도메인URL
//var g_servlet ="/services/servlet" 

/////////////////////////////////////////////////////////
//서버경로
//var g_servlet ="/servlet";
//로컬 경로
var g_servlet ="/HDAsan/servlet";
/////////////////////////////////////////////////////////

var gs_url = "http://203.242.32.199/services/servlet/"

var gs_mst;
var gs_dtl;
var gs_banjae;

var gs_arrPop = null;

 //공용함수설정
 function fn_Init(){
 //화면 초기화 
	var vndcd = GetCookie("vusrid");
	
	if (vndcd == null || vndcd == ""){
		SetCookie("vusrid","");
		SetCookie("vusrpw","");
		SetCookie("vusrnm","");
		SetCookie("vediusr","");
		SetCookie("vsecurity","");
		SetCookie("vcurdate","");
		SetCookie("vautlevel","");

		SetCookie("vdeptcd","");
		SetCookie("vdeptnm","");
		SetCookie("vfdcode","");
		SetCookie("vfdname","");
		SetCookie("vcocode","");
		SetCookie("vconame","");
		SetCookie("vjobdty","");
		
		window.top.location = "Login.html";
	}else{
		fn_Default();
	}
 }
function is_null(item){
	if(item == "" || item ==null || item == 'undefined')
		return true;
	else
		return false;
}
//=================================================================================================
//=================================================================================================
//===== 날짜선택 모달 팝업 열기 =====
var __calendarRtn; // return할 변수, 문자열배열(4) { 연도, 월, 일, 연월일 }
function CallCalendar(){ // 모달팝업 호출 함수
	
	__calendarRtn = window.showModalDialog("../../Common/jsp/com_calender.jsp","","dialogWidth:180px;dialogHeight:230px;scroll:no;status:no;titlebar:no;center:yes;help:yes;");
}

//===== 개체에 날짜선택 모달팝업에서 얻은 값 넣기 =====
//----- 한 개체에 넣기
function __GetCallCalendar(objNameHead, objValueProp){
	CallCalendar();

	if (__calendarRtn!=null && __calendarRtn.length>=4 ){
		eval( objNameHead+"."+objValueProp+" = __calendarRtn[3];" );
		__calendarRtn=null;
	}
}
function CallCalendar1(){ // 모달팝업 호출 함수
	__calendarRtn = window.showModalDialog("../../Transfer/html/Calendar.html",window,"dialogWidth:370px;dialogHeight:395px;scroll:no;status:no;titlebar:no;center:yes;help:yes;");
}

//===== 개체에 날짜선택 모달팝업에서 얻은 값 넣기 =====
//----- 한 개체에 넣기
function __GetCallCalendar1(objNameHead, objValueProp){
	CallCalendar1();

	if (__calendarRtn!=null && __calendarRtn.length>=4 ){
		eval( objNameHead+"."+objValueProp+" = __calendarRtn[3];" );
		eval( gs_appdt +" = __calendarRtn[4];" );
		 
		__calendarRtn=null;
	}
}

function __GetCallCalendar2(objNameHead, objValueProp,objNameHead1, objValueProp1){
	CallCalendar1();

	if (__calendarRtn!=null && __calendarRtn.length>=4 ){
		eval( objNameHead+"."+objValueProp+" = __calendarRtn[3];" );

		if (DLVL_TYPE.index==2) eval( objNameHead1+"."+objValueProp1+" = __calendarRtn[5];" );
		else eval( objNameHead1+"."+objValueProp1+" = __calendarRtn[4];" );
		 
		__calendarRtn=null;
	}
}

function __GetCallCalendar3(objNameHead, objValueProp){
	CallCalendar();

	if (__calendarRtn!=null && __calendarRtn.length>=4 ){
		eval( objNameHead+"."+objValueProp+" = __calendarRtn[3];" );
		__calendarRtn=null;
	}

	ln_DataChange(objNameHead.toUpperCase().substring(5,12));
}

function __GetCallCalendar4(objNameHead, objValueProp,objNameHead1, objValueProp1){
	CallCalendar1();

	if (__calendarRtn!=null && __calendarRtn.length>=4 ){
		eval( objNameHead+"."+objValueProp+" = __calendarRtn[3];" );

		/*************************************************************************************
			2006.08.09 김민규 협의 후 입고일자를 반입일자로 대체한다.
		*************************************************************************************
		if (DLVL_TYPE.index==2) eval( objNameHead1+"."+objValueProp1+" = __calendarRtn[5];" );
		else eval( objNameHead1+"."+objValueProp1+" = __calendarRtn[4];" );
		*************************************************************************************/
		eval( objNameHead1+"."+objValueProp1+" = __calendarRtn[3];" );
		 
		__calendarRtn=null;
	}
}

var __calendarRtn2; // return할 변수, 문자열배열(2) { 선택한 연월일, 시스템에서 넣어줄 연월일 }

function CallCalendar2(){ // 모달팝업 호출 함수
	__calendarRtn2 = window.showModalDialog("../..//html/com_calender2.htm","","dialogWidth:180px;dialogHeight:230px;scroll:no;status:no;titlebar:no;center:yes;help:yes;");
}

function __GetCallCalendar5(objNameHead, objValueProp,objNameHead1, objValueProp1){

	CallCalendar2();

	if (__calendarRtn2!=null && __calendarRtn2.length>=2 ){
		eval( objNameHead+"."+objValueProp+" = __calendarRtn2[0];" );
		eval( objNameHead1+"."+objValueProp1+" = __calendarRtn2[1];" );
		
		__calendarRtn2=null;
	}
}








function CallMonth(){ // 모달팝업 호출 함수
		__calMonthRtn = window.showModalDialog("../../Common/jsp/com_month.jsp","","dialogWidth:180px;dialogHeight:230px;scroll:no;status:no;titlebar:no;center:yes;help:yes;");
}

//개체에 날짜선택 모달팝업에서 얻은 값 넣기 =====
function __GetCallMonth(objNameHead, objValueProp){
	CallMonth();

	if (__calMonthRtn!=null && __calMonthRtn.length>=4 ){
		eval( objNameHead+"."+objValueProp+" = __calMonthRtn" );
		__calMonthRtn=null;
	}
}


//=================================================================================================

function get_cookdata()
{
	  old_gusrid    =  GetCookie("vusrid");
  	  gusrpw    =  GetCookie("vusrpw");
	  old_gusrnm    =  GetCookie("vusrnm");
  	  gediusr   =  GetCookie("vediusr");  
  	  gsecurity =  GetCookie("vsecurity");  
   	   gcurdate  =  GetCookie("vcurdate"); 
   	//alert("11111111111111");
   	//alert(gcurdate);
   	    gautlevel =  GetCookie("vautlevel"); 

		gdeptcd   =  GetCookie("vdeptcd");
		gdeptnm   =  GetCookie("vdeptnm");
		gfdcode   =  GetCookie("vfdcode");
		gfdname   =  GetCookie("vfdname");
		gcocode   =  GetCookie("vcocode");
		gconame   =  GetCookie("vconame");
		gjobdty   =  GetCookie("vjobdty");

	     gJobflag = GetCookie("Jobflag");
	  	   
	   // alert("gdeptnm999"+gdeptnm);
}

 function getCookieVal (offset) 
 {
   var endstr = document.cookie.indexOf(";", offset)
   if (endstr == -1)
      endstr = document.cookie.length
   return unescape(document.cookie.substring(offset, endstr))
  }

  function GetCookie (name) 
  {
   var arg = name + "="
   var alen = arg.length
   var clen = document.cookie.length
   var i = 0
  
   while (i < clen) 
    {
     var j = i + alen
     if (document.cookie.substring(i, j) == arg)
        return getCookieVal (j)
     i = document.cookie.indexOf(" ", i) + 1
     if (i == 0) break
    }
    return null
   }

   	function SetCookie (name, value) 
	{
	// 쿠키 형식의 문자열을 만들어 줍니다.
		var argv = SetCookie.arguments
		var argc = SetCookie.arguments.length
		
		var expires = (2 < argc) ? argv[2] : null
		var path =    (3 < argc) ? argv[3] : null
		var domain = (4 < argc) ? argv[4] : null
		var secure = (5 < argc) ? argv[5] : false
         
		document.cookie = name + "=" + escape (value) +
		((expires == null) ? "" : ("; expires=" + expires.toGMTString())) +
		((path == null) ? "" : ("; path=" + path)) +
		((domain == null) ? "" : ("; domain=" + domain)) +
		((secure == true) ? ";secure" : "")
    }
function gn_connect_info(tbds) {

	  var vusrid    =  tbds.NameValue(tbds.RowPosition,'USERID');
  	  var vusrpw  = tbds.nameValue(tbds.RowPosition,'PASSWORD');
	  var vusrnm  = tbds.nameValue(tbds.RowPosition,'USERNAME');
	  var vediusr  = ""; //tbds.nameValue(tbds.RowPosition,'EDIUSR');
  	  var vsecurity = tbds.nameValue(tbds.RowPosition,'SECURITY');
	  var vcurdate  = tbds.nameValue(tbds.RowPosition,'CURDATE');
  	  var vautlevel = tbds.nameValue(tbds.RowPosition,'AUTLEVEL');

	  var vdeptcd  = tbds.nameValue(tbds.RowPosition,'DEPTCD');
	  var vdeptnm  = tbds.nameValue(tbds.RowPosition,'DEPTNM');
	  var vfdcode  = tbds.nameValue(tbds.RowPosition,'FDCODE');
	  var vfdname  = tbds.nameValue(tbds.RowPosition,'FDNAME');
	  var vcocode  = tbds.nameValue(tbds.RowPosition,'COCODE');
	  var vconame  = tbds.nameValue(tbds.RowPosition,'CONAME');
	  var vjobdty  = tbds.nameValue(tbds.RowPosition,'JOBDTY');
		
	  //alert("vdeptnm::"+vdeptnm);

 	    SetCookie('vusrid',vusrid);			
  	    SetCookie('vusrpw' ,vusrpw);          
	    SetCookie("vusrnm",vusrnm);
  	    SetCookie('vediusr' ,vediusr);          
  	    SetCookie('vsecurity' ,vsecurity);          
  	    SetCookie('vcurdate' ,vcurdate);
  	    SetCookie('vautlevel' ,vautlevel);

		SetCookie('vdeptcd',vdeptcd);
		SetCookie('vdeptnm',vdeptnm);
		SetCookie('vfdcode',vfdcode);
		SetCookie('vfdname',vfdname);
		SetCookie('vcocode',vcocode);
		SetCookie('vconame',vconame);
		SetCookie('vjobdty',vjobdty);

  	tbds.deleterow(tbds.RowPosition);
  	return;
}

function Reset_Cnt() 
    {
		var myday = new Date()
		var sms = 0
		SetCookie("sms", sms, myday , "/", null, false)
		location.reload()
	}

	function fn_ChkButton(cQ,cI,cS,cD,cC,cE,cEx,cPr,cDe){
	//버턴설정을 변경한다
		if(cQ == "T"){
			btn_Query.disabled = true;
			btn_Query.src = "../imgdat/btn/b_query_x.gif";
			btn_Query.style.cursor = "default";
		}else{
			btn_Query.disabled = false;
			btn_Query.src = "../imgdat/btn/b_query.gif";
			btn_Query.style.cursor = "hand";
		}
		if(cI == "T"){
			btn_Insert.disabled = true;
			btn_Insert.src = "../imgdat/btn/b_insert_x.gif";
			btn_Insert.style.cursor = "default";
		}else{
			btn_Insert.disabled = false;
			btn_Insert.src = "../imgdat/btn/b_insert.gif";
			btn_Insert.style.cursor = "hand";
		}
		if(cS == "T"){
			btn_Save.disabled = true;
			btn_Save.src = "../imgdat/btn/b_save_x.gif";
			btn_Save.style.cursor = "default";	
		}else{
			btn_Save.disabled = false;
			btn_Save.src = "../imgdat/btn/b_save.gif";
			btn_Save.style.cursor = "hand";
		}
		if(cD == "T"){
			btn_Delete.disabled = true;
			btn_Delete.src = "../imgdat/btn/b_delete_x.gif";
			btn_Delete.style.cursor = "default";
		}else{
			btn_Delete.disabled = false;
			btn_Delete.src = "../imgdat/btn/b_delete.gif";
			btn_Delete.style.cursor = "hand";
		}
		if(cC == "T"){
			btn_Cancel.disabled = true;
			btn_Cancel.src = "../imgdat/btn/b_cancel_x.gif";
			btn_Cancel.style.cursor = "default";
		}else{
			btn_Cancel.disabled = false;
			btn_Cancel.src = "../imgdat/btn/b_cancel.gif";
			btn_Cancel.style.cursor = "hand";
		}
		if(cE == "T"){
			btn_Exit.disabled = true;
			btn_Exit.src = "../imgdat/btn/b_exit_x.gif";
			btn_Exit.style.cursor = "default";
		}else{
			btn_Exit.disabled = false;
			btn_Exit.src = "../imgdat/btn/b_exit.gif";
			btn_Exit.style.cursor = "hand";
		}
		if(cEx == "T"){
			btn_Excel.disabled = true;
			btn_Excel.src = "../imgdat/btn/b_excel_x.gif";	
			btn_Excel.style.cursor = "default";
		}else{
			btn_Excel.disabled = false;
			btn_Excel.src = "../imgdat/btn/b_excel.gif";
			btn_Excel.style.cursor = "hand";
		}
		if(cPr == "T"){
			btn_Print.disabled = true;
			btn_Print.src = "../imgdat/btn/b_print_x.gif";
			btn_Print.style.cursor = "default";
		}else{
			btn_Print.disabled = false;
			btn_Print.src = "../imgdat/btn/b_print.gif";
			btn_Print.style.cursor = "hand";
		}
		if(cDe == "T"){
			btn_Detail.disabled = true;
			btn_Detail.src = "../imgdat/btn/b_detail_x.gif";
			btn_Detail.style.cursor = "default";
		}else{
			btn_Detail.disabled = false;
			btn_Detail.src = "../imgdat/btn/b_detail.gif";
			btn_Detail.style.cursor = "hand";
		}
	}

	function fn_UrlEncode(han)	{
	//한글변환함수
		var len = han.length ;
		var ret = "" ;
	
		if( len == 0 ) return ";" ;
	
		for( i = 0 ; i < len ; i++ )
		{
			ret += han.charCodeAt( i ) ;
			ret += ";" ;
		}

		return ret ;
	}

	 function fn_HideStatus(){ 
	//status에 내용을 표시하지 않는다
		  window.status="";
		  return true 
	} 
	
	function fn_Get_Curdate(dat)	{
	//현재일자읽어오기
		var mdate=new Date(); 			

		var year=mdate.getYear(); 
		var day=mdate.getDay(); 
		var month=mdate.getMonth()+1 ;
		if (month<10) 
		month="0"+month; 
		var daym=mdate.getDate();
		if (daym<10) 
		daym="0"+daym;

		var curdate = year+month+daym;
		
		return curdate;
	}

// 공백제거 Trim
	function fn_trim(str){
		var index,len;

		while(true){

			index = str.indexOf(" ");
	
			if(index == -1) break;
			len = str.length;
			str = str.substring(0, index) + str.substring((index + 1),len)
		}

		return str;
	}
	
	function fn_BtnCont(btn_nam,btn_val){
		//이미지버턴의 사용을 제어한다.
		if(btn_val == true){
			btn_nam.disabled = false;
			btn_nam.style.cursor = "hand";
		}else{
			btn_nam.disabled = true;
			btn_nam.style.cursor = "default";
		}
	}

	function fRtrim(pStr){
		//우측공백제거
		var tLen = 0;
		var i = 0;
		 
		if(pStr == '' || pStr == null) return '';

		i = pStr.length-1;
		while(1){
			tLen = i + 1;
			
			if(pStr.substring(i,tLen) == ' '){
				i--;
				if(i<0) return '';
			}else{
				return pStr.substring(0,tLen);
			}
		}
	}

	function fn_GridSort(dts_Code,row,colid,mySort){
		//그리드헤드 클릭시 정렬
		if(row > 0) return;

		if(mySort == null || mySort == ""){
			var expr = dts_Code.SortExpr;
			if(expr == null || expr == ""){
				expr = "+";
			}else{
				expr = expr.substring(0,1);
				switch (expr){
					case '-':
						expr = "+";
						break;
					default :
						expr = "-";
				}
			}
			dts_Code.SortExpr = expr + colid;
		}else{
			dts_Code.SortExpr = mySort;
		}
		dts_Code.Sort();
		dts_Code.RowPosition = 1;
	}

	function fn_ComboAdd(dts_Code,cbo_Tmp,colCod,colNam){
		//코드콤보의 리스트를 채운다
			cbo_Tmp.Data = "";

			document.body.style.cursor = "wait";	//모래시계
			dts_Code.Reset();
			
			var strCod = "";
			
			if(dts_Code.CountRow > 0){
				for (var i=1;i<=dts_Code.CountRow;i++){
					var col1=dts_Code.ColumnIndex(colCod);
					var col2=dts_Code.ColumnIndex(colNam);
					
					strCod = strCod 
						      +dts_Code.NameValue(i,colCod)+"^"
					          +dts_Code.NameValue(i,colNam)+","
				}
				cbo_Tmp.Data = strCod;
				//cbo_Tmp.Index="0";
			}
			document.body.style.cursor = "default";	//기본(화살표) 
	}

	function fn_FindDoNong(pVndcd)
	{
		//도지회찾기
		var result="";
		var code = pVndcd.substring(0,1);
		
		switch (code)
		{
		case '1':
			result = "120007";
			break;
		case '2':
			result = "225003";
			break;
		case '3':
			result = "399917";
			break;
		case '4':
			result = "410007";
			break;
		case '5':
			result = "510008";
			break;
		case '6':
			result = "610009";
			break;
		case '7':
			result = "710033";
			break;
		case '8':
			result = "810001";
			break;
		case '9':
			result = "910002";
			break;
		}
		return result;

	}

	function fn_Fit0020(){
	//어음현황
		var result = new Array();
		result = window.showModalDialog('/services/prjsvr/fi/fit0020S.html',"","dialogWidth:872px; dialogHeight:600px;center:yes;status:no");
	}

	function fn_FindManoItem(pMano,pItnbr,pItdsc)
	{
		//관리번호,품번찾기 버턴처리
		var result = new Array();
		var paramList = new Array();
		var tdaecod = GetCookie("VNDCD");

		paramList[0] = pMano;
		paramList[1] = pItnbr;
		paramList[2] = pItdsc;
		paramList[3] = tdaecod;
		result = window.showModalDialog('/services/prjsvr//PitnbrFind.html',paramList,"dialogWidth:668px; dialogHeight:658px;center:yes;status:no");
		
		if (result == -1 || result == null || result == "")	return null;
		
		return result;
	}

	function fn_FindJaepum(pMano,pItnbr,pItdsc)
	{
		//제품찾기
		var result = "";
		var paramList = new Array();
		var tdaecod = GetCookie("VNDCD");

		paramList[0] = pMano;
		paramList[1] = pItnbr;
		paramList[2] = pItdsc;
		paramList[3] = tdaecod;
		result = window.showModalDialog('/services/prjsvr/common/Pcatalog.html',paramList,"dialogWidth:675px; dialogHeight:665px;center:yes;status:no");
		
		if (result == -1 || result == null || result == "")	return null;
		return result;
	}
	
	function fn_FindCtmtbl(pName,pJuno,pGubun){
			//고객찾기
			var result = "";
		
			var paramList = new Array();
			var tdaecod = GetCookie("VNDCD");
		
			paramList[0] = pName;
			paramList[1] = pJuno;
			paramList[2] = tdaecod;
			paramList[3] = pGubun;
			
			txt_msg.value = "고객을 조회합니다.";
			result = window.showModalDialog('/services/prjsvr/common/Pctmtbl.html',paramList,"dialogWidth:600px; dialogHeight:580px;center:yes;status:no");
			
			txt_msg.value = "";

			if (result == -1 || result == null || result == "")	return null;
			return result;
	}

	function fn_FindVehtbl(pGubun,pCode)
	{
		//기대정보찾기
		var result ="";
		var paramList = new Array();
		var tdaecod = GetCookie("VNDCD");
		
		paramList[0] = pGubun;
		paramList[1] = pCode;
		paramList[2] = tdaecod;
		result = window.showModalDialog('/services/prjsvr/common/Pvehtbl.html',paramList,"dialogWidth:441px; dialogHeight:440px;center:yes;status:no");
		
		if (result == -1 || result == null || result == "")	return null;
		return result;
	}
	function fn_Ctmtbl() {
	//고객등록
		var result ="";
		var paramList = new Array();
		var tdaecod = GetCookie("VNDCD");
		
		paramList[0] = "1";//pGubun;
		paramList[1] = "";//pCode;
		paramList[2] = "";//tdaecod;
		paramList[3] = "";	
		result = window.showModalDialog('/services/prjsvr/cm/cmt0010s.html',paramList,"dialogWidth:875px; dialogHeight:570px;center:yes;status:no");
		
		if (result == -1 || result == null || result == "")	return null;
		return result;
	}

	//날짜check
	function gn_ArrayOfDay(l_sLeapYear) 
	{ 
	   this[0]=0;  // <- 아무런 의미가 없는 것임. 무시해도 좋음. 
	   this[1]=31; 
	   this[2]=28; 
	   if (l_sLeapYear) // 윤달이 아니면... 
		   this[2]=29; 
	   this[3]=31; 
	   this[4]=30; 
	   this[5]=31; 
	   this[6]=30; 
	   this[7]=31; 
	   this[8]=31; 
	   this[9]=30; 
	   this[10]=31; 
	   this[11]=30; 
	   this[12]=31; 
	} 

	function gv_date_check(l_sDate) // "19991231" 이런 형식`으로 반드시 넘겨줄것 
	{                             // "1999/12/31" 이런 형식은 절대 안됨   
	   if (l_sDate == "" || l_sDate == null ) return false; 

	   if (l_sDate.length != 8) // 처음엔 자리수부터 Check 한다. 
	   {           
		  return false; 
	   } 

	   /************************************************* 
		* text Box 의 입력된 자료 Check 
		*************************************************/         
	   var l_iYear  = parseInt(l_sDate.substring(0,4), 10);       
	   var l_iMonth = parseInt(l_sDate.substring(4,6), 10); 
	   var l_iDay   = parseInt(l_sDate.substring(6,8), 10);     
	   
	   
	   /****************************************************************** 
		* 윤달 Check! 
		******************************************************************/ 
	   var l_sLeapYear = (((l_iYear%4 == 0) && (l_iYear%100 != 0)) || (l_iYear%400 == 0)); 
	   var monthDays  = new gn_ArrayOfDay(l_sLeapYear); 

	   if (l_iYear < 1900) 
	   { 
				 return false; 
	   } 
	   else if (l_iMonth > 12) // 달수가 12월 보다 크면... 
	   {             
				  return false; 
	   } 
	   else if((parseInt(l_iDay) < 1) || (l_iDay > monthDays[l_iMonth])) // 그 달의 마지막 날 보다 크다면... 
	   {   
				  return false; 
	   } 
	   
	   return true; 
	}
	//Zero Charter Insert "0"
	function charAddZ(chr,maxlen){

		if(chr == null && chr.length ==0) return;

			var str="";		
			var  len=chr.length;	
			for( j=0; j<maxlen-len;j++)
			{
					str=str+"0";	
			}

			return str+chr;
	}

	//Space Charter Insert " "
	function charAddS(chr,maxlen){

		//if(chr == null && chr.length ==0) return;

			var str="";		
			var  len=chr.length;
			
			for( j=0; j<maxlen-len;j++)
			{
					str=str+" ";	
			}

			return chr+str;
	}
	//DB2에 한글 필드 move전에 oeof Check하여 자리수만큼 잘라주기(
	function lfn_UrlEncode(han,slen){ 

	var len = han.length ; 
	var ret = "" ;
	var tlen = 0;
	var tsts="A";
	var rstr="";

	if( len == 0 ) return " " ; 

	for( i = 0 ; i < len ; i++ ) 
	{ 
		if (tlen == slen-3){
			if (tsts == 'H'){
				if (han.charCodeAt( i ) > 12592){
					rstr = rstr + han.substr(i,1);
					return rstr;
				}
			}else{
				if (han.charCodeAt( i ) > 12592){
					return rstr;
				}
			}
		}
		if (tlen == slen-2){
			if (tsts == 'H'){
				if (han.charCodeAt( i ) > 12592){
					return rstr;
				}else{
					rstr = rstr + han.substr(i,1)
					return rstr;
				}
			}else{
				if (han.charCodeAt( i ) > 12592){
					return rstr;
				}
			}
		}
		if (tlen == slen-1){
			if (tsts == 'H'){
				return rstr;
			}else{
				if (han.charCodeAt( i ) > 12592){
					return rstr;
				}else{
					rstr = rstr + han.substr(i,1)
					return rstr;
				}
			}
		}		
		if (han.charCodeAt( i ) > 12592){
			if (tsts == 'A'){
			tlen = tlen + 3;
			rstr = rstr + han.substr(i,1);
			tsts="H";
			}else{
			 rstr = rstr + han.substr(i,1);
			 tlen = tlen + 2;
			}
		}else{
			if (tsts == 'H'){
				tlen = tlen + 2;
				rstr = rstr + han.substr(i,1);
				tsts="A";
			}else{
			tlen = tlen +1;
			rstr = rstr + han.substr(i,1);
			}
		}
		
	//ret += han.charCodeAt( i ) ; 
	//ret += ";" ; 
	} 
	return rstr;//ret ; 
	} 


//****************************************************************************
// 전월구하기
//****************************************************************************
function gn_getbyymm(v_yyyymm) {
	ls_yy = Mid(v_yyyymm,1,4);
	ls_mon = Mid(v_yyyymm,5,2);
	if (ls_mon == '01') {
		ls_bef_yyyymm = (parseInt(ls_yy,10)-1)+'12'
		
	}	
	else {

		if ((parseInt(ls_mon-1,10)) < 10 ) {
			ls_bef_yyyymm = ls_yy+'0'+ parseInt(ls_mon-1,10);
		}	
		else {
			ls_bef_yyyymm = ls_yy+ parseInt(ls_mon-1,10);
		}	
	}
	return(ls_bef_yyyymm);
}	


/******************************************************************************************
	Descrition : 입력값 체크 (db2 입력시 입력값 2byte 변환후 자릿수 체크)
******************************************************************************************/
function bytelength(fe,bstr,mx) { 
	var xx = "";
	var yy = "";
	var len = bstr.length; 

	for (var i=0; i<bstr.length; i++) {
		xx = bstr.substr(i,1).charCodeAt(0); 
		if (i!=0) yy = bstr.substr(i-1,1).charCodeAt(0); 

		if (i==0) {
			if (xx>127) {	len++;len++; }
		} else {
			if (yy!="") {
				if (yy>127) { len++; } 
				else { if (xx>127) { len++;len++; } }
			}
		}
	} 

	if (bstr.substr(bstr.length-1,1).charCodeAt(0)>127) len++;

	// 클경우 메시지 뿌리기 
	if (mx < len){ 
		alert('입력한 글이 길어서 잘릴수 있습니다.\n다시 입력하여 주십시요'); 
		fe.focus(); 
		fe.select(); 
	} 

	return len; 
}

/******************************************************************************************
	Descrition : 입력값 체크 (db2 입력시 입력값 2byte 변환후 자릿수 체크)
******************************************************************************************/
function bytelength_1(fe,bstr,mx) { 
	var xx = "";
	var yy = "";
	var len = bstr.length; 

	for (var i=0; i<bstr.length; i++) {
		xx = bstr.substr(i,1).charCodeAt(0); 
		if (i!=0) yy = bstr.substr(i-1,1).charCodeAt(0); 

		if (i==0) {
			if (xx>127) {	len++;len++; }
		} else {
			if (yy!="") {
				if (yy>127) { len++; } 
				else { if (xx>127) { len++;len++; } }
			}
		}
	} 

	if (bstr.substr(bstr.length-1,1).charCodeAt(0)>127) len++;

	return len; 
}
/******************************************************************************************
	Descrition : 부서조회시  Level에 따른 Treecd 반환
******************************************************************************************/
function fn_treecd(level,treecd) {

	var result="";

	switch (level)
	{
	case '1':
		result =treecd.substring(0,2);  
		break;
	case '2':
		result =treecd.substring(0,2);  
		break;
	case '3':
		result = treecd.substring(0,4);
		break;
	case '4':
		result = treecd.substring(0,6);
		break;
	case '5':
		result = treecd.substring(0,8);
		break;	
	}
	return result;
}

/******************************************************************************************
/*	Descrition : 회계관련한 신규 함수 
/*             : 함수명 gf_함수명 ( 함수명 첫자리는 대문자)
******************************************************************************************/

/******************************************************************************************
	Descrition : 주민번호 체크
	parameter  : 주민번호
	retun      : true - 가능 , false - 불가능
******************************************************************************************/
function gf_Resino(p) {

	var int_val=0;
	var s_chkval = "234567892345";
	var int_result="";

	for (i=0;i< 12;i++){
		int_val = int_val + parseInt(p.substring(i,i+1)) * parseInt(s_chkval.substring(i,i+1));
	}
  
	int_result = 11 - parseInt((int_val%11))

  if (int_result == 10) int_result = 0;
  else if (int_result == 11) int_result = 1;

	if (int_result == parseInt(p.substring(12,13))){
		return true;
	}else {
		alert("주민등록번호가 맞지 않습니다.\n\n다시 입력하여 주십시요.");
		return false;
	}
}

/******************************************************************************************
	Descrition : 사업자번호 체크
	parameter  : 사업자번호
	retun      : true - 가능 , false - 불가능
******************************************************************************************/
function gf_Wkresino(p) {
	var int_val=0;
	var int_getpam =new Array(10);
	var int_chkval =new Array("1","3","7","1","3","7","1","3","5");
	var int_result=0;
	var int_chk=0;

	for (i=0;i<10;i++){int_getpam[i]= p.substring(i,i+1);} 
	for (j=0;j<9;j++){ int_val += int_getpam[j]*int_chkval[j];} 

	int_val=int_val + Math.floor((int_getpam[8]*5)/10);
	int_result = int_val%10; 

	if(int_result==0){ int_chk = 0;}
	else{ int_chk = 10 - int_result;}

	if(int_chk!= int_getpam[9]){
		alert("사업자등록번호가 맞지 않습니다.\n\n다시 입력하여 주십시요.");
		return false;
	}else{
		return true;
	}
}


/******************************************************************************************
		Descrition : 주민번호 체크 (외국인)
		parameter  : 주민번호
		retun      : true - 가능 , false - 불가능
******************************************************************************************/
function gn_FgResino(fgnno) {  
	var sum=0;  
	var odd=0;  
	buf = new Array(13);  
	for(i=0; i<13; i++) { 
		buf[i]=parseInt(fgnno.charAt(i)); 
	}  
	
	odd = buf[7]*10 + buf[8];  
	
	if(odd%2 != 0) { 
		alert("외국인 주민등록번호가 맞지 않습니다.\n\n다시 입력하여 주십시요0.");
		return false;
	}
	
	if( (buf[11]!=6) && (buf[11]!=7) && (buf[11]!=8) && (buf[11]!=9) ) {   
		alert("외국인 주민등록번호가 맞지 않습니다.\n\n다시 입력하여 주십시요00.");
		return false;  
	}  
	
	multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];  
	
	for(i=0, sum=0; i<12; i++) { sum += (buf[i] *= multipliers[i]); }  
	
	sum = 11 - (sum%11);  
	
	if(sum >= 10) { sum -= 10; }  
	
	sum += 2;  
	
	if(sum >= 10) { sum -= 10; }  
	
	if(sum != buf[12]) { 
	    alert("외국인 주민등록번호가 맞지 않습니다.\n\n다시 입력하여 주십시요000.");	
		return false; 
	}  
	
	return true; 
}

/******************************************************************************
	Description : 불필요한 문자 삭제하기
******************************************************************************/
function gn_Replace(str, ws) {
	var retStr 	= '';
	var ch		= '';
	
	if (str == '' || str == null)
		return '';

	for (z=0; z < str.length; z++) {
		ch = str.charAt(z);
		if (ch != ws) {
			retStr += ch;
		}
	}

	return retStr;
}



/******************************************************************************************
	Descrition : 로그인시 해당부서만 전체 선택가능함.
	parameter  : 부서코드
	retun      : true - 가능 , false - 불가능
	             gcds_name - dataset 명
******************************************************************************************/
function gf_Dept_Enable(p, gcds_name){
	gcds_name.DataID = g_servlet+"/Account.commdtil_s1?v_str1=2139"
													  +"&v_str2="+p
	                                                  +"&v_str3=";

    //prompt("",gcds_name.DataID );																							
	gcds_name.Reset();			
	
	//alert("gcds_name.countrow::"+gcds_name.countrow);

	if(gcds_name.countrow>0){
		return true;
    }else { 
		return false;
	}
}

/******************************************************************************************
Descrition : 회계부서 확인 가져오기
parameter  : 부서코드
retun      : true - 가능 , false - 불가능
             gcds_name - dataset 명
******************************************************************************************/
function gf_USER(p, gcds_name){
	gcds_name.DataID = g_servlet+"/Account.commdtil_s1?v_str1=2139"
													  +"&v_str2="+p
	                                                  +"&v_str3=";
													  +"&v_str4="
													  +"&v_str5="
													  +"&v_str6=1"
													  
	//prompt("",gcds_name.DataID );																							
	gcds_name.Reset();			
    //alert("gcds_name.countrow::"+gcds_name.countrow);

	if(gcds_name.countrow>0){
		return true;
	}else { 
		return false;
	}
}


/******************************************************************************************
	Descrition : 로그인시 해당사번만 전체 선택가능함.
	parameter  : 사번코드
	retun      : true - 가능 , false - 불가능
	             gcds_name - dataset 명
******************************************************************************************/
function gf_empno_Enable(s, gcds_name){
	gcds_name.DataID = g_servlet+"/Account.commdtil_s5?v_str1=2120"
													  +"&v_str2="+s;
	                                                  																						
	gcds_name.Reset();			

	if(gcds_name.countrow>0){
		return true;
    }else { 
		return false;
	}
}


/******************************************************************************************
 	Descrition : 잔액금액 생성
	             일계표/월계표/합계잔액시산표 등을 조회할때  
							 일별합계잔액, 일별관리항목집계, 월별합계잔액, 월별관리항목집계 테이블의 잔액에
							 새로운 금액이 존재하면 상위계정 생성 및 추가하는  일괄 프로세스
	parameter  : 
	retun      : 
******************************************************************************************/
function gf_Up_Atcode_Create(){

  //데이타셋선언
	//데이타셋생성
	//Addrow

	//tr

	//데이타셋 Delete
}


/******************************************************************************************
 	Descrition : 숫자 Sting에 콤마찍기
	parameter  : 
	retun      : 
******************************************************************************************/
function gf_setnum(src){ 
	
	var len	= 0;
	var comma = 0;
	var buf  = "";
	var dest = "";
	
	buf = "" + src + "";
	len = buf.length;
	
	for(i = 3; i < len; i+=3) {
		if((i < len) || (len < (i+4)))	comma++;
	}
	
	for(i = 0; i < len; i++) {
		if(i == (len - (3 * comma))) {
			dest += ",";
			dest += buf.charAt(i);
			comma--;
		}
		else {
			dest += buf.charAt(i);
		}
	}

	if (dest.substring(0,1)=="-") {
		if (dest.substring(1,2)==",") {
			dest = dest.substring(0,1) + dest.substring(2,dest.length);
		}
	}

	return dest;
}

/******************************************************************************************
 	Descrition : 숫자 Sting에 콤마찍기(소수점 이하 존재할 경우 포함)
	parameter  : 
	retun      : 
******************************************************************************************/
function gf_setnum2(src){ 
  
  if(src==""){
		return 0;
	}

	//alert("src"+src);

	var arrParam	= new Array();
	var buf_all  = "";
	var buf_comma  = "";
	var len	= 0;
	var comma = 0;
	var buf  = "";
	var dest = "";

	buf_all = "" + src + "";
	arrParam = buf_all.split(".");
  
  buf = arrParam[0];
  
	if (arrParam.length>1){
		buf_comma = arrParam[1];
	}else{
    buf_comma="";
	}
  
	
	buf = "" + buf + "";
	len = buf.length;
	
	for(i = 3; i < len; i+=3) {
		if((i < len) || (len < (i+4)))	comma++;
	}
	
	for(i = 0; i < len; i++) {
		if(i == (len - (3 * comma))) {
			dest += ",";
			dest += buf.charAt(i);
			comma--;
		}
		else {
			dest += buf.charAt(i);
		}
	}

	if (dest.substring(0,1)=="-") {
		if (dest.substring(1,2)==",") {
			dest = dest.substring(0,1) + dest.substring(2,dest.length);
		}
	}

	if(buf_comma!=""){
    dest=dest+"."+buf_comma;
	}

	return dest;
}



/******************************************************************************************
 	Descrition : 대차대조표 금액 계산 배열에 담기
	parameter  : gcds_name      //데이타셋명 
	             fdcode    //지점코드
							 actyymm   //회계년월
							 atcode    //계정코드
							 cocode    //사업소
							 divcd     //본부
							 temp      //수식
	retun      : 
******************************************************************************************/
function gf_array_val2(gcds_name,fdcode, actyymm, cocode, divcd, temp){ 

  //alert("gcds_name:"+gcds_name+"/fdcode:"+fdcode+"/actyymm:"+actyymm+"/cocode:"+cocode+"/divcd:"+divcd+"/temp:"+temp);
	
	var arrcode = new Array();
	var cnt=0;
	var cnt1=0;
	var strData="";
	var result="";
	arrcode[0]="";

 // (1117000)+(1111400)                19개
	for (i=0;i<temp.length;i++){
		if(temp.charAt(i)==" "){
		}else if(temp.charAt(i)>="0" && temp.charAt(i)<="9"){
			if(cnt1==0)strData="";
      strData += temp.charAt(i);
			arrcode[cnt]=strData;          //(11
			
			if (cnt1==6) {
				gf_format_val(gcds_name,fdcode,actyymm,arrcode[cnt],cocode,divcd);
				arrcode[cnt] = gcds_name.namevalue(1,"TOTALVAL");

				if(arrcode[cnt]==undefined){
					arrcode[cnt]=0;
				}
				//alert("arrcode[cnt]"+arrcode[cnt])
				//alert(gcds_name.namevalue(1,"TOTALVAL"));
				arrcode[cnt] = Math.floor(arrcode[cnt]);
				cnt1=0;
				cnt+=1;
				strData=""
			}else{
				cnt1+=1 ;
			}
		}else{                         //특수문자
	      strData="";
				strData = temp.charAt(i);  //()
        arrcode[cnt] =strData;     //(
				cnt1=0;
				cnt+=1;
		}
	}//for

	for(j=0;j<arrcode.length;j++){
    result+=arrcode[j];
	 // alert(result);
  }

	if(temp.length>=8){
		gf_cal_val(gcds_name2,result);
  }else{
		gcds_name2.ClearAll();
		var s_temp = "TOTALVALUE:STRING"
		gcds_name2.SetDataHeader(s_temp);
		gcds_name2.addrow();
		gcds_name2.namevalue(1,"TOTALVALUE") = result;
	}

}

/******************************************************************************************
 	Descrition : 대차대조표 금액 계산 배열에 담기
	parameter  : gcds_name      //데이타셋명 
	             fdcode    //지점코드
							 actyymm   //회계년월(to_
							 atcode    //계정코드
							 cocode    //사업소
							 divcd     //본부
							 temp      //수식
							 actyymmfr   //회계년월(from
							 md_gubun   Y - 수정분개 포함, N-미포함//수정분개구분
							 won_gubun  Y - 금강산 원화, N - 금강산 달러//원화구분
	retun      : 
******************************************************************************************/
function gf_array_val(gcds_name,fdcode, actyymm, cocode, divcd, temp,actyymmfr,md_gubun,won_gubun){ 

  //alert("gcds_name:"+gcds_name+"/fdcode:"+fdcode+"/actyymm:"+actyymm+"/cocode:"+cocode+"/divcd:"+divcd+"/temp:"+temp);
	
	var arrcode = new Array();
	var cnt=0;
	var cnt1=0;
	var strData="";
	var result="";
	var tempval=0;
	var totval=0;
	var miplus="+";
	arrcode[0]="";

 // alert("수식"+temp);
	for (i=0;i<temp.length;i++){
		if(temp.charAt(i)==" "){
       miplus="";
    }else if( temp.charAt(i)=="+"){
       miplus="+";
			 cnt1=0;
		}else if(temp.charAt(i)=="-"){
       miplus="-";
       cnt1=0;
		}else if(temp.charAt(i)>="0" && temp.charAt(i)<="9"){
			if(cnt1==0)strData="";
      strData += temp.charAt(i);
			arrcode[cnt]=strData;          //(11
			
			if (cnt1==6) {
				gf_format_val(gcds_name,fdcode,actyymm,arrcode[cnt],cocode,divcd,actyymmfr,md_gubun,won_gubun);
				arrcode[cnt] = gcds_name.namevalue(1,"TOTALVAL");
				if(arrcode[cnt]==undefined){
					arrcode[cnt]=0;
				}
				//alert("arrcode[cnt]"+arrcode[cnt]);
				//alert("tot"+totval);

				tempval = arrcode[cnt];
				if (miplus=="+"){
					totval += tempval;
				}else if(miplus=="-"){
          totval -= tempval;
				}
				
				//alert("totval:::"+totval + "::tempval::" + tempval)
				
				//alert("arrcode[cnt]"+arrcode[cnt])
				//alert(gcds_name.namevalue(1,"TOTALVAL"));
			  //arrcode[cnt] = Math.floor(arrcode[cnt]);
				cnt1=0;
				cnt+=1;
				strData=""
			}else{
				cnt1+=1 ;
			}
		}else{                     
				cnt1=0;
				cnt+=1;
		}
	}//for

	gcds_name2.ClearAll();
	var s_temp = "TOTALVALUE:DECIMAL"
	gcds_name2.SetDataHeader(s_temp);
	gcds_name2.addrow();
	gcds_name2.namevalue(1,"TOTALVALUE")=totval;
  
 // alert("end");
}

/******************************************************************************************
 	Descrition : 대차대조표 금액 계산
	parameter  : gcds_name      //데이타셋명 
	             fdcode    //지점코드
							 actyymm   //회계년월
							 atcode    //계정코드
							 cocode    //사업소
							 divcd     //본부

	retun      : 
******************************************************************************************/
function gf_format_val(gcds_name,fdcode, actyymm, atcode, cocode, divcd, actyymmfr,md_gubun,won_gubun){ 
	 //alert("fdcode::"+fdcode+"");

	 if(won_gubun=="N"){ //원화 미적용
		if(md_gubun=="Y"){ //수정분개 포함.
			gcds_name.DataID = g_servlet+"/Account.comm_func_s1?v_str1="+fdcode
																											 +"&v_str2="+actyymm
																											 +"&v_str3="+atcode
																											 +"&v_str4="+cocode
																											 +"&v_str5="+divcd
																											 +"&v_str6="+actyymmfr;
		  //prompt("NY",gcds_name.DataID );																							
			gcds_name.Reset();			
	  }else{ //수정분개 미포함.
			gcds_name.DataID = g_servlet+"/Account.comm_func_s1_n?v_str1="+fdcode
																											 +"&v_str2="+actyymm
																											 +"&v_str3="+atcode
																											 +"&v_str4="+cocode
																											 +"&v_str5="+divcd
												  														 +"&v_str6="+actyymmfr;																							
			//prompt("NN",gcds_name.DataID );		
			gcds_name.Reset();			
		}
	}else{ //원화적용
	  if(fdcode==""){ //전체
			if(md_gubun=="Y"){ //수정분개 포함.
				gcds_name.DataID = g_servlet+"/Account.comm_func_s2?v_str1="+fdcode
																												 +"&v_str2="+actyymm
																												 +"&v_str3="+atcode
																												 +"&v_str4="+cocode
																												 +"&v_str5="+divcd
																												 +"&v_str6="+actyymmfr;
			  //prompt("YY",gcds_name.DataID );																							
				gcds_name.Reset();			
			}else{ //수정분개 미포함.
				gcds_name.DataID = g_servlet+"/Account.comm_func_s2_n?v_str1="+fdcode
																												 +"&v_str2="+actyymm
																												 +"&v_str3="+atcode
																												 +"&v_str4="+cocode
																												 +"&v_str5="+divcd
																												 +"&v_str6="+actyymmfr;		
				//prompt("YN",gcds_name.DataID );	
				gcds_name.Reset();			
			}
		}else if(fdcode=="03"){//금강산
		  if(md_gubun=="Y"){ //수정분개 포함.
				gcds_name.DataID = g_servlet+"/Account.comm_func_s3?v_str1="+fdcode
																												 +"&v_str2="+actyymm
																												 +"&v_str3="+atcode
																												 +"&v_str4="+cocode
																												 +"&v_str5="+divcd
																												 +"&v_str6="+actyymmfr;
			  //prompt("03Y",gcds_name.DataID );																							
				gcds_name.Reset();			
			}else{ //수정분개 미포함.
				gcds_name.DataID = g_servlet+"/Account.comm_func_s3_n?v_str1="+fdcode
																												 +"&v_str2="+actyymm
																												 +"&v_str3="+atcode
																												 +"&v_str4="+cocode
																												 +"&v_str5="+divcd
																												 +"&v_str6="+actyymmfr;		
				// prompt("03N",gcds_name.DataID );	
				gcds_name.Reset();			
			}
		}
	}

	 //alert("end");
}

/******************************************************************************************
 	Descrition : 대차대조표 금액 계산
	parameter  : gcds_name2,      //데이타셋명 
	             dblvalue 계산식 
	            
	retun      : 
******************************************************************************************/
function gf_cal_val(gcds_name2, dblvalue){ 

    //alert("start");
		gcds_name2.DataID = g_servlet+"/Account.comm_cal_s1?v_str1="+dblvalue;
 //   prompt("",gcds_name2.DataID );																							
	  gcds_name2.Reset();			
		 //alert("end");
}

/******************************************************************************************
 	Descrition : IE 패치후 발생하는 컴퍼넌트 문제를 위한것
******************************************************************************************/
function __ws__(id){
	document.write(id.innerHTML);
	id.id = "";
}


/****************************************************************************************
 Descrition : 전표입력시 InnerHtml 관련해서만 사용함.
*****************************************************************************************/

function __ws2__(div1,ls_html){
	//alert("ls_html"+ls_html);
	div1.innerHTML=div1.innerHTML+ls_html;
	//id.id = "";
}

function __ws3__(div1,ls_html){
	//alert("ls_html"+ls_html);
	div1.innerHTML=ls_html;
	//id.id = "";
}

function __ws2_Clear__(div1){
	div1.innerHTML="";
}

/******************************************************************************
	Description : seqno의 자리수를 설정
	parameter   : p1 - 현재숫자, p2 - 자리수
******************************************************************************/
function ln_Seqno_Format(p1,p2){
  var seq="0";
	if (p2==5){
		if (p1>=1&&p1<10) seq="0000"+p1;
		if (p1>=10&&p1<100) seq="000"+p1;
		if (p1>=100&&p1<1000) seq="00"+p1;
		if (p1>=1000&&p1<10000) seq="0"+p1;
		if (p1>=10000&&p1<100000) seq=p1;
        }else if (p2==3){
		if (p1>=1&&p1<10) seq="00"+p1;
		if (p1>=10&&p1<100) seq="0"+p1;
		if (p1>=100&&p1<1000) seq=p1;

	}else if (p2==2){
		if (p1>=1&&p1<10) seq="0"+p1;
		if (p1>=10&&p1<100) seq=p1;
	}

	return seq;
}

/*-------------------------------------------------------------------------------*
 * function gf_CalUnit(Data,unit,flag)                                                          *
 *-------------------------------------------------------------------------------*
 * 모듈명 : gf_CalUnit(절사,절상,반올림 처리 함수)                                      *
 * 인  수 : numeric (data,unit,flag)                                                                *
 * 리턴값 : numeric                                                                     *
 * 특  징 : Data를 자리수(unit)부터 flag(1:절사,2:절상,3:반올림)에 따리 작업한다.   *
 * (+n : 정수 n자리부터 작업 처리, 0: 정수부만 처리, -n : 소수점 n자리부터 작업처리 *
 * <예  +n : (1234.12,1,1) = 1230,  (1234.12,1,2) = 1240,   (1234.12,1,3) = 1230 *
 *          0  : (1234.12,0,1) = 1234, (1234.12,0,2) = 1235,    (1234.12,0,3) = 1234 *
 *          -n :(1234.12,-1,1)= 1234.1,(1234.12,-1,2)= 1234.2,(1234.12,-1,3)= 1234.1 *
 *-------------------------------------------------------------------------------*/
 function gf_CalUnit(Data,unit,flag)
 {
    var tpow = 0.00000001;
    var temp = 0.00000001;
    // unit을 기준으로 소수점 이하 값으로 세팅
    //      예, (1234.12,1,1) => temp = 1230, (1234.12,-1,1) => temp = 12341.2
    tpow = Math.pow(10,unit*-1);
    temp = Data * tpow;
    //절사(버림),절상(올림),반올림 작업을 수행한다.
    if(flag == 1)                   //절사(버림) 작업을 수행한다.
        temp = Math.floor(temp)
    else if(flag == 2)          //절상(올림) 작업을 수행한다.
        temp = Math.ceil(temp)
    else if(flag == 3)          //반올림 작업을 수행한다.
        temp = Math.round(temp)
    else
        temp = 0;
    return (temp * Math.pow(10,unit));
 }


/******************************************************************************************
	Descrition : 날짜의 숫자 체크
	parameter  : obj
	retun      : true - 가능 , false - 불가능
******************************************************************************************/
function gf_ChkNumber(obj){
	var str="";
	var sChk=0;
	var src=eval(obj).value;

	for(var i=0;i<src.length;i++){
		if(isNaN(src.charAt(i))||src.charAt(i)==" ") sChk+=1;
		else str+=src.charAt(i);
	}

	if(sChk!=0){
		alert("숫자만 입력하십시요.");
		obj.value=src;
		return false;
	}else{
	  sGubun = gf_ChkDate(str);
		if(sGubun==true){
			return true;
		}else{
			return false;
    }
  }
}


/******************************************************************************************
	Descrition : 날짜의 년월일 체크
	parameter  : sDate  날짜(8자리 숫자만가능)
	retun      : true - 가능 , false - 불가능
******************************************************************************************/
function gf_ChkDate(sDate){

	var sYY="";
	var sMM="";
	var sDD="";
	var sER=0;
	var sDAA=[31,28,31,30,31,30,31,31,30,31,30,31];

	if(sDate.length==8){
		sYY=sDate.substring(0,4);
	  sMM=sDate.substring(4,6);
	  sDD=sDate.substring(6,8);
		if(sYY%1000!=0&&sYY%4==0)sDAA[1]=29;   //윤년
		if(sDD>sDAA[sMM-1]||sDD<1)sER=1;       //일자체크
    if(sMM<1||sMM>12)sER=1;                //월체크
		if(sYY<1990)sER=1;                     //년도체크
		if(sYY%1!=0||sMM%1!=0||sDD%1!=0)sER=1; //정수체크
	}else{
		sER=1;
	}

	if(sER==1){
		alert("년월일을 확인하십시요.");
		return false;
	}else{
		return true;
  }
}

/******************************************************************************************
	Descrition : 날짜의 숫자 체크
	parameter  : value
	retun      : true - 가능 , false - 불가능
******************************************************************************************/
function gf_ChkNumber2(svalue){
	var sChk=0;
	var str="";
	var src=svalue;

	for(var i=0;i<src.length;i++){
		if(isNaN(src.charAt(i))||src.charAt(i)==" ") sChk+=1;
		else str+=src.charAt(i);
	}

	if(sChk!=0){
		alert("숫자만 입력하십시요.");
		return false;
	}else{
	  sGubun = gf_ChkDate(str);
		if(sGubun==true){
			return true;
		}else{
			return false;
    }
  }
}

/******************************************************************************************
	Descrition : 숫자 체크
	parameter  : value
	retun      : true - 가능 , false - 불가능
******************************************************************************************/
function gf_ChkNumber3(svalue){
	var sChk=0;
	var str="";
	var src=svalue;

	for(var i=0;i<src.length;i++){
		if(isNaN(src.charAt(i))||src.charAt(i)==" ") sChk+=1;
		else str+=src.charAt(i);
	}

	if(sChk!=0){
		alert("숫자만 입력하십시요.");
		return false;
	}else{
	  return true;
  }
}

/******************************************************************************************
	Descrition : 금강산지점 - 재고자산, 선급비용, 유형자산, 무형자산, 선수수익일 경우
	             관리항목의 외화금액란에 원화금액 필수항목
	parameter  : sfdcode, satcode, svalue
	retun      : true - 가능 , false - 불가능
******************************************************************************************/
function gf_Chk_Won(sfdcode, satcode, svalue){
	/*
	alert("sfdcode"+sfdcode+"satcode"+satcode+"svalue"+svalue);
	var satcode_3="";
  satcode_3 = satcode.substring(0,3);
	if(sfdcode =="03"){
		if(satcode_3=="112"||satcode_3=="122"||satcode_3=="123"||satcode=="1112200"||satcode=="2101000"){
			if(svalue==""||svalue="0"||svalue=="-"){
				alert("입력불가");
			}
		}
	}
	*/
}

/******************************************************************************************
	Descrition : 요일구하기	             
	parameter  : y, m, d (년,월,일)
******************************************************************************************/
function gf_dayOfWeek(y,m,d) {
   var days = new Array("일요일","월요일","화요일","수요일","목요일","금요일","토요일");
	 var mm = parseInt(m,10)-1;
	 
	 if(mm<10){
			m="0"+mm;
	 }else{
      m = mm;
	 }
	 var c = new Date(y,m,d);
 	 var dayOfWeek = c.getDay();
	 return days[dayOfWeek] ;
}

/******************************************************************************************
	Descrition : 요일구하기	             
	parameter  : y, m, d (년,월,일)
******************************************************************************************/
function gf_dayOfWeek2(y,m,d) {
   var days = new Array("일","월","화","수","목","금","토");
	 var mm = parseInt(m,10)-1;
	 
	 if(mm<10){
			m="0"+mm;
	 }else{
      m = mm;
	 }
	 var c = new Date(y,m,d);
 	 var dayOfWeek = c.getDay();
	 return days[dayOfWeek] ;
}


/******************************************************************************************
	Descrition : 로그인체크_20110610_박경국
	parameter  : 
******************************************************************************************/
function lfn_init(){
if ( is_null(old_gusrid) ||  is_null(gusrpw) ) {
		alert("Login을 하여야 합니다.\nLogin화면을 통해 접속하시기 바랍니다!");
		window.open("../hdasan.html","_parent");
		return 0;
	}
}