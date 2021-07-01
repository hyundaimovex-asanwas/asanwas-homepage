<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	달력(월)
+ 프로그램 ID	: MONTH.HTML
+ 기 능 정 의	: 조회
+ 변 경 이 력	: 윤정민
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>
<html>
<head>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<jsp:include page="<%=dirPath%>/Account/common/include/head.jsp"/>

<title>날짜선택............................................................................</title>


<style type="text/css">

BODY
{scrollbar-face-color:#eeeeee;
scrollbar-shadow-color:#cccccc;
scrollbar-highlight-color:#FFFFFF;
scrollbar-3dlight-color:#fafafa;
scrollbar-darkshadow-color:#ccccccF;
scrollbar-track-color:#ffffff;
scrollbar-arrow-color:#666666}

BODY,TD,input,DIV,form,TEXTAREA,center,pre,blockquote,select,option 
{font-size:9pt;font-family:,u;color:555555;line-height:130%}

A:link    {color:666666;text-decoration:none;}
A:visited {color:666666;text-decoration:none;}
A:active  {color:666666;text-decoration:none;}
A:hover  {color:FF7800;text-decoration:none;}

.img {border:0}
</style>

<script language="JavaScript">
<!--
	// 오늘을 구한다. 
	var today = new Date();
	var yyyy, mm, dd, ddT;
	var yyyyStr, mmStr, ddStr;
	var dateOfWeek;

	yyyy = today.getYear();
	mm = today.getMonth()+1;
	dd = today.getDate();
	ddT = dd;

	ToStrYMD();

	// 날짜 숫자형을 문자형으로 바꾸기
	function ToStrYMD(){
		//yyyyStr = yyyy.toString();
		//mmStr = mm.toString();
		//ddStr = dd.toString();
		//if ( mmStr.length ==1 ){ mmStr="0"+mmStr; }
		//if ( ddStr.length == 1 ){ ddStr="0"+ddStr; }
	}

	// 날짜 문자형을 숫자형으로 바꾸기
	function ToIntYMD(){
		if ( yyyyStr!="" && !isNaN(yyyyStr )) { yyyy = parseInt(yyyyStr); }
		if ( mmStr!="" && !isNaN(mmStr )) { mm = parseInt(mmStr); }
		dd = parseInt(ddStr);
	}
	// 연도와 월을 출력한다. 년도, 월의 증감을 있게 한다. 

	function OutputYM() {
		txt_year.value=yyyy.toString(); 
		sel_month.value=mm.toString(); 
		//sel_month.options[mm-1].seleted=true;
		PrintCalendar();
		window.focus();
	}
	function InputYM() {
		yyyy = parseInt(txt_year.value);
		mm = parseInt(sel_month.value);	
		//alert("InputYM : mmStr="+mmStr);
	}

	function YearAdd(val) {
		ResetYM();
		yyyy += val;
		ToStrYMD();
		OutputYM();
	}

	function ResetYM() {
		InputYM();	ToIntYMD();
		ToStrYMD();	OutputYM();
	}

	// 선택된 연월을 기준으로 날짜를 출력한다. 
	function PrintCalendar(){
		// 첫째 날짜의 요일값을 가져온다. 
		var firstDay1 = new Date(yyyy, mm-1, 1);	//이번달 1일에 대해
		var firstDay2;																					// 다음달 1일에 대해 
		var dayCnt = 28; 
		if (mm==12) { firstDay2 = new Date(yyyy+1, 0, 1); } else { firstDay2 = new Date(yyyy, mm, 1); } 

		// 해당 월의 날짜 수를 구한다. 
		var dateOfWeek1 = firstDay1.getDay(); 
		var dateOfWeek2 = firstDay2.getDay(); 
		var gap = dateOfWeek2 - dateOfWeek1; 
		if ( gap >= 0) { dayCnt+=gap } else { dayCnt+=gap+7; }

		//ftA.innerText = dateOfWeek1 + " / " + dateOfWeek2 + " / " + dayCnt;

		// 출력한다. 
		var eachDay = new Array(43);
		var Cnt=0;
		var todayColor="", mOutCheck="";
		
		//alert(dayCnt);
	//alert(ddT);

		for (var i=1; i<=42; i++) { 
			if ( i >= dateOfWeek1+1 && i <= (dayCnt+dateOfWeek1) ) { // 해당일이 나타나야 할 경우
				Cnt++; 
				if ( Cnt == ddT ) { todayColor=" bgColor='#A0A0FF'"; mOutCheck=", 1"; } else { todayColor=""; mOutCheck=""; }
				eachDay[i] = "<td class='tab21' valign=bottom height='20px' onClick='Click("+Cnt.toString()+", this);' onMouseOver='mOver(this);' onMouseOut='mOut(this"+mOutCheck+");' style='cursor:hand;'"+todayColor+" >"+Cnt.toString()+"</td>"
			} else {
				eachDay[i] = "<td class='tab21'>&nbsp;</td>"; 
			}
		}

		var data = ""
					+ "<table border='0' cellspacing='0' cellpadding='0' style='border:1 solid #708090;border-right-width:0px;border-bottom-width:0px'>"
					+ "	<tr valign='middle' align='center' bgColor='#DDDDDD' height='24px'>"
					+ "		<td class='tab21' width=24>일</td>"
					+ "		<td class='tab21' width=24>월</td>"
					+ "		<td class='tab21' width=24>화</td>"
					+ "		<td class='tab21' width=24>수</td>"
					+ "		<td class='tab21' width=24>목</td>"
					+ "		<td class='tab21' width=24>금</td>"
					+ "		<td class='tab21' width=24>토</td>"
					+ "	</tr>";

		// dateOfWeek1, dayCnt 에 유의
		for ( var i=0; i<6; i++ ) { 
				data+="	<tr valign='middle' align='center' height='20px'>";
				for (var k=1; k<=7; k++ ) { data+=eachDay[i*7+k]; }
				data+="	</tr>";
		}

		data += "</table>";

		divCalendar.innerHTML = data;
		data = null;


	}

	//================================================
	//===== 날짜 클릭/마우스 오버-아웃등 
	function Click(d, obj) {
		obj.style.backgroundColor = "#FFAAAA";
		//결과 정하고 창닫기
		//alert(d+"를 선택하셨습니다.");
		window.returnValue = SetReturnVal(d);
		window.close();
	}

	function mOver(obj) {
		obj.style.backgroundColor = "#FFAAAA";
	}

	function mOut(obj, tod) {
		obj.style.backgroundColor = "#FFFFFF";
		if ( tod==1 ) { obj.style.backgroundColor = "#A0A0FF"; }
	}

	function SetReturnVal(d) { // 연도, 월, 일, 연월일 반환
		yyyyStr = yyyy.toString();
		mmStr = mm.toString();
		var ddStr2 = d.toString();
		switch ( yyyyStr.length ) { 
			case 1 : yyyyStr="000"+yyyyStr; break;
			case 2 : yyyyStr="00"+yyyyStr; break;
			case 3 : yyyyStr="0"+yyyyStr; break;
			case 4 : break;
			default : yyyyStr="0000"; break;
		}
		if ( mmStr.length ==1 ){ mmStr="0"+mmStr; }
		if ( ddStr2.length == 1 ){ ddStr2 = "0"+ddStr2; }
		return ( new Array(yyyyStr, mmStr, ddStr2, yyyyStr+mmStr+ddStr2) );
	}

	function keyCheck(){
		if (event.keyCode == 13) { window.focus(); }
	}

//-->
</script>

</head>

<body class="modalPop" onLoad="OutputYM();">

<table align="center" valign="middle" style="position:relative;top:2px;width:168px;border:1 solid #708090">
	<tr align="center">
		<td valign=top>
			<input type="text" name="txt_year" style="position:relative;top:0px;width:28px;border:0" onFocus="this.select();" onKeyup="keyCheck();" onBlur="ResetYM();" disabled>년 
			<img src="../img/btn/com_b_left.gif" style="position:relative;top:3px;cursor:hand;border:0" onclick="YearAdd(-1);">
			<img src="../img/btn/com_b_right.gif" style="position:relative;top:3px;cursor:hand;border:0" onclick="YearAdd(1);">
<!--
			<input type="button" style="position:relative;top:1px;height:20px;width:20px;font-size:9pt" class="btnCal" value="◀" onclick="YearAdd(-1);"><input type="button" style="position:relative;top:1px;height:20px;width:20px;font-size:9pt" class="btnCal" value="▶" onclick="YearAdd(1);">
-->
		</td>
		<td>
			<select name="sel_month" class="selCal" style="position:relative;top:1px;width:44px;border:1 solid #708090" onChange="ResetYM();">
				<option value='1'>01</option>
				<option value='2'>02</option>
				<option value='3'>03</option>
				<option value='4'>04</option>
				<option value='5'>05</option>
				<option value='6'>06</option>
				<option value='7'>07</option>
				<option value='8'>08</option>
				<option value='9'>09</option>
				<option value='10'>10</option>
				<option value='11'>11</option>
				<option value='12'>12</option>
			</select>월
		</td>
	</tr>
</table>
<table align="center" valign="middle" style="position:relative;top:2px;width:168px;border:1 solid #708090 ">
	<tr>
		<td colspan=2>
			<div id="divCalendar">&nbsp;</div>
		</td>
	</tr>
</table>

<!-- <hr><input type="button" value="결과" onclick="PrintCalendar();"><hr> -->
<!-- <font id="ftA"></font><br> -->

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
