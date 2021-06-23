
    var target;                                                                    // 호출한 Object의 저장
    var stime;
    document.write("<div id=minical onpropertychange=selectbox_hidden('minical') oncontextmenu='return false' ondragstart='return false' onselectstart='return false' style=\"background:buttonface; margin:5; padding:5;margin-top:2;border-top:1 solid buttonshadow;border-left: 1 solid buttonshadow;border-right: 1 solid buttonshadow;border-bottom:1 solid buttonshadow;width:160;display:none;position: absolute; z-index: 99\"></div>");

function Calendar(obj) {                                                        // jucke
    obj.value = "";
	var now = obj.value.split("-");
    var x, y;

    target = obj;                                                                // Object 저장;

    x = (document.layers) ? loc.pageX : event.clientX;
    y = (document.layers) ? loc.pageY : event.clientY;

    minical.style.pixelTop    = y+5;
    minical.style.pixelLeft    = x-50;
    minical.style.display = (minical.style.display == "block") ? "none" : "block";

	if(minical.style.display == "none"){
		selectbox_visible();
	}

    if (now.length == 3) {                                                        // 정확한지 검사
        Show_cal(now[0],now[1],now[2]);                                            // 넘어온 값을 년월일로 분리
    } else {
        now = new Date();
        Show_cal(now.getFullYear(), now.getMonth()+1, now.getDate());            // 현재 년/월/일을 설정하여 넘김.
    }
}

function doOver() {                                                                // 마우스가 칼렌다위에 있으면
    var el = window.event.srcElement;
    cal_Day = el.title;

    if (cal_Day.length > 7) {                                                    // 날자 값이 있으면.
        el.style.borderTopColor = el.style.borderLeftColor = "buttonhighlight";
        el.style.borderRightColor = el.style.borderBottomColor = "buttonshadow";
    }
    window.clearTimeout(stime);                                                    // Clear
}

function doClick() {                                                            // 날자를 선택하였을 경우
    cal_Day = window.event.srcElement.title;
    window.event.srcElement.style.borderColor = "red";                            // 테두리 색을 빨간색으로
    if (cal_Day.length > 7) {                                                    // 날자 값이있으면
        target.value=cal_Day                                                    // 값 설정
    }
    minical.style.display='none';                                                // 화면에서 지움
	selectbox_visible();														//가려진 select menu다시 보임
}

function doOut() {
    var el = window.event.fromElement;
    cal_Day = el.title;

    if (cal_Day.length > 7) {
        el.style.borderColor = "white";
    }
    //stime=window.setTimeout("minical.style.display='none';", 200);
}

function day2(d) {                                                                // 2자리 숫자료 변경
    var str = new String();

    if (parseInt(d) < 10) {
        str = "0" + parseInt(d);
    } else {
        str = "" + parseInt(d);
    }
    return str;
}

function Show_cal(sYear, sMonth, sDay) {
    var Months_day = new Array(0,31,28,31,30,31,30,31,31,30,31,30,31)
    var Weekday_name = new Array("일", "월", "화", "수", "목", "금", "토");
    var intThisYear = new Number(), intThisMonth = new Number(), intThisDay = new Number();
    document.all.minical.innerHTML = "";
    datToday = new Date();                                                    // 현재 날자 설정

    intThisYear = parseInt(sYear);
    intThisMonth = parseInt(sMonth);
    intThisDay = parseInt(sDay);

    if (intThisYear == 0) intThisYear = datToday.getFullYear();                // 값이 없을 경우
    if (intThisMonth == 0) intThisMonth = parseInt(datToday.getMonth())+1;    // 월 값은 실제값 보다 -1 한 값이 돼돌려 진다.
    if (intThisDay == 0) intThisDay = datToday.getDate();

    switch(intThisMonth) {
        case 1:
                intPrevYear = intThisYear -1;
                intPrevMonth = 12;
                intNextYear = intThisYear;
                intNextMonth = 2;
                break;
        case 12:
                intPrevYear = intThisYear;
                intPrevMonth = 11;
                intNextYear = intThisYear + 1;
                intNextMonth = 1;
                break;
        default:
                intPrevYear = intThisYear;
                intPrevMonth = parseInt(intThisMonth) - 1;
                intNextYear = intThisYear;
                intNextMonth = parseInt(intThisMonth) + 1;
                break;
    }

    NowThisYear = datToday.getFullYear();                                        // 현재 년
    NowThisMonth = datToday.getMonth()+1;                                        // 현재 월
    NowThisDay = datToday.getDate();                                            // 현재 일

    datFirstDay = new Date(intThisYear, intThisMonth-1, 1);                        // 현재 달의 1일로 날자 객체 생성(월은 0부터 11까지의 정수(1월부터 12월))
    intFirstWeekday = datFirstDay.getDay();                                        // 현재 달 1일의 요일을 구함 (0:일요일, 1:월요일)

    intSecondWeekday = intFirstWeekday;
    intThirdWeekday = intFirstWeekday;

    datThisDay = new Date(intThisYear, intThisMonth, intThisDay);                // 넘어온 값의 날자 생성
    intThisWeekday = datThisDay.getDay();                                        // 넘어온 날자의 주 요일

    varThisWeekday = Weekday_name[intThisWeekday];                                // 현재 요일 저장

    intPrintDay = 1                                                                // 달의 시작 일자
    secondPrintDay = 1
    thirdPrintDay = 1

    Stop_Flag = 0

    if ((intThisYear % 4)==0) {                                                    // 4년마다 1번이면 (사로나누어 떨어지면)
        if ((intThisYear % 100) == 0) {
            if ((intThisYear % 400) == 0) {
                Months_day[2] = 29;
            }
        } else {
            Months_day[2] = 29;
        }
    }
    intLastDay = Months_day[intThisMonth];                                        // 마지막 일자 구함
    Stop_flag = 0

    Cal_HTML = "<TABLE WIDTH=100% BORDER=0 CELLPADDING=0 CELLSPACING=0 ONMOUSEOVER=doOver(); ONMOUSEOUT=doOut(); STYLE='font-size:8pt;font-family:Tahoma;'>"
            + "<TR ALIGN=CENTER><TD COLSPAN=7 nowrap=nowrap ALIGN=CENTER><SPAN TITLE='이전달' STYLE=cursor:hand; onClick='Show_cal("+intPrevYear+","+intPrevMonth+",1);'><FONT COLOR=Navy>◀</FONT></SPAN> "
            + "<B STYLE=color:red>"+get_Yearinfo(intThisYear,intThisMonth,intThisDay)+"년"+get_Monthinfo(intThisYear,intThisMonth,intThisDay)+"월</B>"
            + " <SPAN TITLE='다음달' STYLE=cursor:hand; onClick='Show_cal("+intNextYear+","+intNextMonth+",1);'><FONT COLOR=Navy>▶</FONT></SPAN></TD></TR>"
            + "<TR ALIGN=CENTER BGCOLOR=ThreedFace STYLE='color:White;font-weight:bold;'><TD>일</TD><TD>월</TD><TD>화</TD><TD>수</TD><TD>목</TD><TD>금</TD><TD>토</TD></TR>";

    for (intLoopWeek=1; intLoopWeek < 7; intLoopWeek++) {                        // 주단위 루프 시작, 최대 6주
        Cal_HTML += "<TR ALIGN=RIGHT BGCOLOR=WHITE>"
        for (intLoopDay=1; intLoopDay <= 7; intLoopDay++) {                        // 요일단위 루프 시작, 일요일 부터
            if (intThirdWeekday > 0) {                                            // 첫주 시작일이 1보다 크면
                Cal_HTML += "<TD onClick=doClick();>";
                intThirdWeekday--;
            } else {
                if (thirdPrintDay > intLastDay) {                                // 입력 날짝 월말보다 크다면
                    Cal_HTML += "<TD onClick=doClick();>";
                } else {                                                        // 입력날짜가 현재월에 해당 되면
                    Cal_HTML += "<TD onClick=doClick(); title="+intThisYear+"-"+day2(intThisMonth).toString()+"-"+day2(thirdPrintDay).toString()+" STYLE=\"cursor:Hand;border:1px solid white;";
                    if (intThisYear == NowThisYear && intThisMonth==NowThisMonth && thirdPrintDay==intThisDay) {
                        Cal_HTML += "background-color:cyan;";
                    }

                    switch(intLoopDay) {
                        case 1:                                                    // 일요일이면 빨간 색으로
                            Cal_HTML += "color:red;"
                            break;
                        case 7:
                            Cal_HTML += "color:blue;"
                            break;
                        default:
                            Cal_HTML += "color:black;"
                            break;
                    }

                    Cal_HTML += "\">"+thirdPrintDay;

                }
                thirdPrintDay++;

                if (thirdPrintDay > intLastDay) {                                // 만약 날짜 값이 월말 값보다 크면 루프문 탈출
                    Stop_Flag = 1;
                }
            }
            Cal_HTML += "</TD>";
        }
        Cal_HTML += "</TR>";
        if (Stop_Flag==1) break;
    }
    Cal_HTML += "</TABLE>";

    document.all.minical.innerHTML = Cal_HTML;
}

function get_Yearinfo(year,month,day) {                                            // 년 정보를 콤보 박스로 표시
    var min = parseInt(year) - 100;
    var max = parseInt(year) + 10;
    var i = new Number();
    var str = new String();

    str = "<SELECT onChange='Show_cal(this.value,"+month+","+day+");' ONMOUSEOVER=doOver();>";
    for (i=min; i<=max; i++) {
        if (i == parseInt(year)) {
            str += "<OPTION VALUE="+i+" selected ONMOUSEOVER=doOver();>"+i+"</OPTION>";
        } else {
            str += "<OPTION VALUE="+i+" ONMOUSEOVER=doOver();>"+i+"</OPTION>";
        }
    }
    str += "</SELECT>";
    return str;
}


function get_Monthinfo(year,month,day) {                                        // 월 정보를 콤보 박스로 표시
    var i = new Number();
    var str = new String();

    str = "<SELECT onChange='Show_cal("+year+",this.value,"+day+");' ONMOUSEOVER=doOver();>";
    for (i=1; i<=12; i++) {
        if (i == parseInt(month)) {
            str += "<OPTION VALUE="+i+" selected ONMOUSEOVER=doOver();>"+i+"</OPTION>";
        } else {
            str += "<OPTION VALUE="+i+" ONMOUSEOVER=doOver();>"+i+"</OPTION>";
        }
    }
    str += "</SELECT>";
    return str;
}


/*select box 위로 레이어 띄우기 */
// Internet Explorer에서 셀렉트박스와 레이어가 겹칠시 레이어가 셀렉트 박스 뒤로 숨는 현상을 해결하는 함수
// 레이어가 셀렉트 박스를 침범하면 셀렉트 박스를 hidden 시킴
// 사용법 :
// <div id=LayerID style="display:none; position:absolute;" onpropertychange="selectbox_hidden('LayerID')">
function selectbox_hidden(layer_id)
{
	var ly = eval(layer_id);

	// 레이어 좌표
	var ly_left  = ly.offsetLeft;
	var ly_top    = ly.offsetTop;
	var ly_right  = ly.offsetLeft + ly.offsetWidth;
	var ly_bottom = ly.offsetTop + ly.offsetHeight;

	// 셀렉트박스의 좌표
	var el;

	for (i=0; i<document.forms.length; i++) {
		for (k=0; k<document.forms[i].length; k++) {
			el = document.forms[i].elements[k];
			if (el.type == "select-one") {
				var el_left = el_top = 0;
				var obj = el;
				if (obj.offsetParent) {
					while (obj.offsetParent) {
						el_left += obj.offsetLeft;
						el_top  += obj.offsetTop;
						obj = obj.offsetParent;
					}
				}
				el_left  += el.clientLeft;
				el_top    += el.clientTop;
				el_right  = el_left + el.clientWidth;
				el_bottom = el_top + el.clientHeight;

				// 좌표를 따져 레이어가 셀렉트 박스를 침범했으면 셀렉트 박스를 hidden 시킴
				if ( (el_left >= ly_left && el_top >= ly_top && el_left <= ly_right && el_top <= ly_bottom) ||
					(el_right >= ly_left && el_right <= ly_right && el_top >= ly_top && el_top <= ly_bottom) ||
					(el_left >= ly_left && el_bottom >= ly_top && el_right <= ly_right && el_bottom <= ly_bottom) ||
					(el_left >= ly_left && el_left <= ly_right && el_bottom >= ly_top && el_bottom <= ly_bottom) )
					el.style.visibility = 'hidden';
			}
		}
	}
}

// 감추어진 셀렉트 박스를 모두 보이게 함
function selectbox_visible()
{
	for (i=0; i<document.forms.length; i++) {
		for (k=0; k<document.forms[i].length; k++) {
			el = document.forms[i].elements[k];
			if (el.type == "select-one" && el.style.visibility == 'hidden')
				el.style.visibility = 'visible';
		}
	}
}