/////////////////////////////////////////////////////////////////////////////////
//   gs_GetDate() : ������ ��¥�� String �������� Return '20000901'.
//	 gs_GetTime() : ������ �ð��� String �������� Return '1301'.
//	 gb_DateChck(l_sDate) : ��¥ Check.l_sDate�� '20000901'�����ϰ�.      					   return: true, false.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ������ ��¥�� String �������� Return '20000901'
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


// ����  ��¥�� ����
function gn_ArrayOfDay(l_sLeapYear)
{
	this[0]=0;  // <- �ƹ��� �ǹ̰� ���� ����. �����ص� ����.
	this[1]=31;
	this[2]=28;
	if (l_sLeapYear) // ������ �ƴϸ�...
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
* ��¥üũ (���������, 8�ڸ�)
*  "19991231" �̷� ����`���� �ݵ�� �Ѱ��ٰ� ("1999/12/31" �̷� ������ ���� �ȵ�)
*************************************************************************************/

function gb_DateChck(l_sDate) // "19991231" �̷� ����`���� �ݵ�� �Ѱ��ٰ�
{                             // "1999/12/31" �̷� ������ ���� �ȵ�

	if (l_sDate == "" || l_sDate == " ") return true;
	if  (l_sDate.substring(4,6) == '00') return false;
	if  (l_sDate.substring(6,8) == '00') return false;

	if (l_sDate.length != 8) // ó���� �ڸ������� Check �Ѵ�.
	{
	return false;
	}


	/*************************************************
	* text Box �� �Էµ� �ڷ� Check
	*************************************************/
	var l_iYear  = parseInt(l_sDate.substring(0,4), 10);
	var l_iMonth = parseInt(l_sDate.substring(4,6), 10);
	var l_iDay   = parseInt(l_sDate.substring(6,8), 10);


	/******************************************************************
	* ���� Check!
	******************************************************************/
	var l_sLeapYear = (((l_iYear%4 == 0) && (l_iYear%100 != 0)) || (l_iYear%400 == 0));
	var monthDays  = new gn_ArrayOfDay(l_sLeapYear);

	if (l_iYear < 1900)	{
		return false;
	}
	else if (l_iMonth > 12) { // �޼��� 12�� ���� ũ��...
		return false;
	}
	else if(l_iDay > monthDays[l_iMonth]) { // �� ���� ������ �� ���� ũ�ٸ�...
		return false;
	}

	return true;
}


// �ش� ����� ������ ��¥���� Return
function gs_GetDaysOfMonth(l_sDate)
{
   var l_iYear  = parseInt(l_sDate.substring(0,4), 10);
   var l_iMonth = parseInt(l_sDate.substring(4,6), 10);

   /******************************************************************
    * ���� Check!
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
	ar[0] = "��";
	ar[1] = "��";
	ar[2] = "ȭ";
	ar[3] = "��";
	ar[4] = "��";
	ar[5] = "��";
	ar[6] = "��";
	now=new Date();             // ���� ����, �ð�
    wkdy=now.getDay();          // ���� (0=�Ͽ���, 1=������, ...)
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
	ar[0] = "��";
	ar[1] = "��";
	ar[2] = "ȭ";
	ar[3] = "��";
	ar[4] = "��";
	ar[5] = "��";
	ar[6] = "��";

	now=new Date(year, (month-101), (day-100));             // ���� ����, �ð�
    wkdy=now.getDay();          // ���� (0=�Ͽ���, 1=������, ...)
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

//null ��check
function is_null(item_var) {

	if(item_var == "" || item_var == null || item_var == 'undefined' || item_var == " ")
		return true;

	return false;
}