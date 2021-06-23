<!--

// 주민등록번호 체크(2 parameter)

function JuminCheck(ResNo1, ResNo2)
{
	var chk = 0;
	var yy  = ResNo1.substring(0,2);
	var mm  = ResNo1.substring(2,4);
	var dd  = ResNo1.substring(4,6);
	var sex = ResNo2.substring(0,1);

	if(ResNo1.length != 6) {
		//alert('주민등록번호 앞부분이 잘못되었습니다.');
		return true;
	}
	
	if((sex != 1 && sex != 2 && sex != 3 && sex != 4) || (ResNo2.length != 7)) {
		//alert ('주민등록번호 뒷부분이 잘못되었습니다.');
		return true;
	}   

	if((ResNo1.length == 6) && (ResNo2.length == 7)) {
		var ich = parseInt(sex, 10);	
		switch(ich) {
			case 1: break;
			case 2: break;
			case 3: if(yy == 00) break;
			case 4: if(yy == 00) break;
			default:
				//alert('주민등록번호 뒷부분이 잘못되었습니다.');
				return true;
		}
	}
	
	for(var i = 0; i <=5; i++) { 
		chk = chk + (((i % 8) + 2) * parseInt(ResNo1.substring(i, i + 1)));
	}
	
	for(var i = 6; i <= 11; i++) {
		chk = chk + (((i % 8) + 2) * parseInt(ResNo2.substring(i - 6, i - 5)));
	}
	
	chk = 11 - (chk % 11);
	chk = chk % 10;
	
	if(chk != ResNo2.substring(6, 7)) {
		//alert('유효하지 않은 주민등록번호입니다.');
		return true;
	}
	return false
}
	

// 이름 체크

function NameCheck(n)
{
	var charck = '0123456789~!@#$%^&*()_-+=|{}[]<>,./?';
	for(var i = 0; i < n.length; i++) {
		var substr = n.substring(i, i + 1);
		if(charck.indexOf(substr) >= 0) return true;
	}
	return false;
}


// 숫자 판별

function isNumberCheck(num)
{	
	var num_Str = "0123456789";

	for (var i = 0; i < num.length; i++) {
		var substr = num.substring(i, i + 1);
		if(num_Str.indexOf(substr) < 0) return true;
	}
	return false;
}

function isNumber(num) {		
	if (isNumberCheck(num)) {
		alert("숫자만 입력해주세요");
		return false;
	}		
}

function IsEmpty(data) {
  
  for (var i=0; i<data.length; i++) {
    if (data.substring(i,i+1) != " ") {
        return false;           
	}   
  }	
	return true;
  
}


Now = new Date();
NowDay = Now.getDate();
NowMonth = Now.getMonth();
NowYear = Now.getYear();

if (NowYear < 2000) NowYear += 1900; 

function DaysInMonth(WhichMonth, WhichYear)
{
  var DaysInMonth = 31;
  if (WhichMonth == "04" || WhichMonth == "06" || WhichMonth == "09" || WhichMonth == "11") DaysInMonth = 30;
  if (WhichMonth == "02" && (WhichYear/4) != Math.floor(WhichYear/4))        DaysInMonth = 28;
  if (WhichMonth == "02" && (WhichYear/4) == Math.floor(WhichYear/4))        DaysInMonth = 29;
  return DaysInMonth;
}

function ChangeOptionDays(form, name)
{
  DaysObject = eval("document." + form + "." + name + "day");
  MonthObject = eval("document." + form + "." + name + "month");
  YearObject = eval("document." + form + "." + name + "year");

  Month = MonthObject[MonthObject.selectedIndex].value;
  Year = YearObject[YearObject.selectedIndex].value;

  DaysForThisSelection = DaysInMonth(Month, Year);
  CurrentDaysInSelection = DaysObject.length ;
  
  if (CurrentDaysInSelection > (DaysForThisSelection + 1))
  {
  	
    for (i=0; i<(CurrentDaysInSelection-(DaysForThisSelection + 1)); i++)
    {
      DaysObject.options[DaysObject.options.length - 1] = null
    }
  }
  if ((DaysForThisSelection + 1) > CurrentDaysInSelection)
  {
    for (i=0; i<((DaysForThisSelection + 1) - CurrentDaysInSelection); i++)
    {
      NewOption = new Option(DaysObject.options.length);
      DaysObject.add(NewOption);
    }
  }
    if (DaysObject.selectedIndex < 0) DaysObject.selectedIndex == 0;
}

function SetToToday(form, name)
{
  DaysObject = eval("document." + form + "." + name + "day");
  MonthObject = eval("document." + form + "." + name + "month");
  YearObject = eval("document." + form + "." + name + "year");

  YearObject[0].selected = true;
  MonthObject[NowMonth].selected = true;

  ChangeOptionDays(Which);

  DaysObject[NowDay-1].selected = true;
}

function WriteYearOptions(YearsAhead)
{
  line = "";
  for (i=0; i<YearsAhead; i++)
  {
    line += "<OPTION value='" + NowYear + i + "'>";
    line += NowYear + i;
    line += NowYear + "</OPTION>";
  }
  return line;
}

function pop(url, pwidth, pheight) {
	var window_left=(screen.width/2) - (pwidth/2);
    var window_top=(screen.height/2) - (pheight/2);

 window.open (url,"","scrollbars=no,resizeable=no,status=no,width=" + pwidth + ",height=" + pheight + ",top="+window_top+",left="+window_left+"");

}

function insertcomma(vstr) {
	var str = vstr;
	str += "";
	
	var comval = "";
	var inversecomval = "";
	
	for ( k = 0 ; k < str.length ; k++ ) {
		if ( k != 0 && k%3 == 0 ) {
			comval += ",";
		}
		comval += str.charAt(str.length-(k+1));
	}
	
	for ( k = 0 ; k < comval.length; k++ ) {
		inversecomval += comval.charAt(comval.length-(k+1));
	}
	
	return inversecomval;
}


function removecomma(str) {
	if ( str == "" )
		return;
		
	var comval = "";
	for ( k = 0 ; k < str.length ; k++ ) {
		if ( str.charAt(k) == ',' ) {
			continue;
		}
		comval += str.charAt(k);
	}
	
	return comval;
}


function insertcomma_obj(obj) {
	var str = obj.value;
	str += "";
	var comval = "";
	var inversecomval = "";
	
	for ( k = 0 ; k < str.length ; k++ ) {
		if ( k != 0 && k%3 == 0 ) {
			comval += ",";
		}
		comval += str.charAt(str.length-(k+1));
	}
	
	for ( k = 0 ; k < comval.length; k++ ) {
		inversecomval += comval.charAt(comval.length-(k+1));
	}
	
	obj.value =  inversecomval;
}


function removecomma_obj(obj) {
	var str = obj.value;
	if ( str == "" )
		return;
	var comval = "";
	for ( k = 0 ; k < str.length ; k++ ) {
		if ( str.charAt(k) == ',' ) {
			continue;
		}
		comval += str.charAt(k);
	}
	
	obj.value = comval;
}


//-->