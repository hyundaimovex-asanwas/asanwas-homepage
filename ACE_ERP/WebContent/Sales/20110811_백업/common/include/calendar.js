/////////////////////////////////////////////////////////////////////////////////
//   gs_GetDate() : 오늘의 날짜를 String 형식으로 Return '20000901'.
//	 gs_GetTime() : 현재의 시간을 String 형식으로 Return '1301'.
//	 gb_DateChck(l_sDate) : 날짜 Check.l_sDate는 '20000901'형식일것.      					   return: true, false.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 오늘의 날짜를 String 형식으로 Return '20000901'
function gs_GetDate() {
    current = new Date();

   tmpyear = current.getYear();
   str0 = "";
   str1 = str0.concat(tmpyear);

    tmpmon = current.getMonth() + 1;
    if(tmpmon < 10) {
         str4 = "0";
         str5 = str4.concat(tmpmon);
    }
    else
      str5 = tmpmon;

    tmpday = current.getDate();
   if(tmpday < 10) {
          str6 = "0";
          str7 = str6.concat(tmpday);
    }
   else
       str7 = tmpday;

   str2 = str1.concat(str5);
    str3 = str2.concat(str7);

   return(str3);
}


// 월별  일짜수 저장
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


/************************************************************************************
* 날짜체크 (년월일형식, 8자리)
*  "19991231" 이런 형식`으로 반드시 넘겨줄것 ("1999/12/31" 이런 형식은 절대 안됨)
*************************************************************************************/

function gb_DateChck(l_sDate) // "19991231" 이런 형식`으로 반드시 넘겨줄것
{                             // "1999/12/31" 이런 형식은 절대 안됨

	if (l_sDate == "" || l_sDate == " ") return true;
	if  (l_sDate.substring(4,6) == '00') return false;
	if  (l_sDate.substring(6,8) == '00') return false;

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

	if (l_iYear < 1900)	{
		return false;
	}
	else if (l_iMonth > 12) { // 달수가 12월 보다 크면...
		return false;
	}
	else if(l_iDay > monthDays[l_iMonth]) { // 그 달의 마지막 날 보다 크다면...
		return false;
	}

	return true;
}


// 해당 년월의 마지막 날짜값을 Return
function gs_GetDaysOfMonth(l_sDate)
{
   var l_iYear  = parseInt(l_sDate.substring(0,4), 10);
   var l_iMonth = parseInt(l_sDate.substring(4,6), 10);

   /******************************************************************
    * 윤달 Check!
    ******************************************************************/
   var l_sLeapYear = (((l_iYear%4 == 0) && (l_iYear%100 != 0)) || (l_iYear%400 == 0));
   var monthDays  = new gn_ArrayOfDay(l_sLeapYear);

   return ""+monthDays[l_iMonth];

}

function gs_Random() {
	var ls_GetDate = new Date();
	var result = gs_GetDate();
	result += ls_GetDate.getTime();
	return result;

}

function GetVal(name, ck_val)
{
	var Found = false;
	var start, end;
	var i = 0;

	while(i <= ck_val.length) {
		start = i;
		end = start + name.length;
		if(ck_val.substring(start, end) == name) {
			Found = true;
			break;
		}
		end = ck_val.indexOf("@", start+1) ;
		if (end < start) {
			return "";
		} else {
			i = end;
		}
	}

	if (Found == true) {
		start = end + 1;
		end = ck_val.indexOf("@", start);

		if(end <start) {
			end =ck_val.length;
		}
		 return ck_val.substring(start, end);
	}
	return "";
}


function gn_day(){
	var ar = new Array();
	ar[0] = "일";
	ar[1] = "월";
	ar[2] = "화";
	ar[3] = "수";
	ar[4] = "목";
	ar[5] = "금";
	ar[6] = "토";
	now=new Date();             // 현재 일자, 시간
    wkdy=now.getDay();          // 요일 (0=일요일, 1=월요일, ...)
    return ar[wkdy];

}

function gn_day_week(yyyymmdd){

  var year ;
  var month ;
  var day ;

  if (yyyymmdd.length != 8) return ;

  year = parseInt(yyyymmdd.substring(0, 4)) ;
  month = parseInt("1" + yyyymmdd.substring(4, 6)) ;
  day = parseInt("1" + yyyymmdd.substring(6)) ;

	var ar = new Array();
	ar[0] = "일";
	ar[1] = "월";
	ar[2] = "화";
	ar[3] = "수";
	ar[4] = "목";
	ar[5] = "금";
	ar[6] = "토";

	now=new Date(year, (month-101), (day-100));             // 현재 일자, 시간
    wkdy=now.getDay();          // 요일 (0=일요일, 1=월요일, ...)
    return ar[wkdy];

}

/////////////////////////////////////////////////////////////////
//	 Ending Security
/////////////////////////////////////////////////////////////////
function gn_Cal_Yymm(btnsrc){
	strleft = "dialogleft:" + eval(window.screenLeft + window.event.clientX ) ;
	strtop = ";dialogtop:" + eval(window.screenTop + window.event.clientY ) ;
	return window.showModalDialog("../common/COM_Calendar.html","",strleft +  strtop +";dialogWidth:136px; dialogHeight:153px;scroll:no;status:no;titlebar:no;center:no;help:yes;");
}

function gn_Cal_Yyyymmdd(){
	strleft = "dialogleft:" + eval(window.screenLeft + window.event.clientX ) ;
	strtop = ";dialogtop:" + eval(window.screenTop + window.event.clientY ) ;
	return window.showModalDialog("../common/COM_Calendar.html","",strleft +  strtop +";dialogWidth:245px; dialogHeight:190px;scroll:no;status:no;titlebar:no;center:no;help:yes;");
}

function gn_Cal_Yyyymmdd_Grid(){
	strleft = "dialogleft:" + 500;
	strtop = ";dialogtop:" + 370;
	return window.showModalDialog("../common/COM_Calendar.html","",strleft +  strtop +";dialogWidth:190px; dialogHeight:190px;scroll:no;status:no;titlebar:no;center:no;help:yes;");
}

//null 값check
function is_null(item_var) {

	if(item_var == "" || item_var == null || item_var == 'undefined' || item_var == " ")
		return true;

	return false;
}