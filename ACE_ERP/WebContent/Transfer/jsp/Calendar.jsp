<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산 반출배정조회
+ 프로그램 ID	: TR00103.HTML
+ 기 능 정 의	: 반출배정조회
+ 변 경 이 력	: 정미선
+ 작성일자 : 
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 :
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="transfer.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 및 기타 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());		
%>


<!-- HTML 시작-->
<html>
	<head>
   <jsp:include page="/Transfer/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script 시작
=============================================================================*/
%>



<!-- /******************************************************************************
	Description : DataSet 선언
******************************************************************************/ --> 
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"> 
</OBJECT>

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"> 
</OBJECT>

<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"> 
</OBJECT>
<%=HDConstant.COMMENT_END%>

<script language="JavaScript">

	//var opener = window.dialogArguments;
	// 오늘을 구한다. 
	var today = new Date();
	var yyyy, mm, dd, ddT;
	var yyyyStr, mmStr, ddStr;
	var dateOfWeek;

	yyyy = today.getYear();
	mm = today.getMonth()+1;
	dd = today.getDate();
	ddT = dd;

	var ndate = new Date(today.getYear(), today.getMonth(), today.getDate()+4 );
	var nyear = ndate.getYear();
	var nmonth = ndate.getMonth()+1;
	if (nmonth<10) nmonth = "0"+nmonth;
	var nday = ndate.getDate();
	if (nday<10) nday = "0" + nday;
	var ndate = nyear+nmonth+nday;

	ToStrYMD();

	/******************************************************************************
		Description :
	******************************************************************************/  
	function ln_Start(){
	
		gcDs_etc1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project 
		gcDs_etc1.Reset();  

		//LINE_PART.index = opener.LINE_PART.index-1;

		sel_month.index = parseInt(mm)-1;

		var cyymm = "";
		if (mm<10) cyymm = yyyy+"0"+mm;
		else cyymm = yyyy+""+mm;

		OutputYM();
	}

	/******************************************************************************
		Description : 날짜 숫자형을 문자형으로 바꾸기
	******************************************************************************/  
	function ToStrYMD(){

	}

	/******************************************************************************
		Description : 날짜 문자형을 숫자형으로 바꾸기
	******************************************************************************/  
	function ToIntYMD(){
		if ( yyyyStr!="" && !isNaN(yyyyStr )) { yyyy = parseInt(yyyyStr); }
		if ( mmStr!="" && !isNaN(mmStr )) { mm = parseInt(mmStr); }
		dd = parseInt(ddStr);
	}

	/******************************************************************************
		Description : 연도와 월을 출력한다. 년도, 월의 증감을 있게 한다. 
	******************************************************************************/  
	function OutputYM() {
		txt_year.value=yyyy.toString(); 

		cyymm = txt_year.value;
		if (sel_month.bindcolval<10) cyymm += "0" +sel_month.bindcolval;
		else cyymm += "" + sel_month.bindcolval;

		gcDs1.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsCalendar?NOH=Y&gstr1=" + LINE_PART.bindcolval+ "&gstr2=" + cyymm ; 

		gcDs1.Reset() ;

		PrintCalendar();
		window.focus();
	}

	/******************************************************************************
		Description : 
	******************************************************************************/  
	function InputYM() {
		yyyy = parseInt(txt_year.value,10);
		mm = parseInt(sel_month.bindcolval,10);	
	}

	/******************************************************************************
		Description : 
	******************************************************************************/  
	function YearAdd(val) {
		ResetYM();
		yyyy += parseInt(val);
		ToStrYMD();
		OutputYM();
	}

	/******************************************************************************
		Description : 
	******************************************************************************/  
	function ResetYM() {
		InputYM();	ToIntYMD();
		ToStrYMD();	OutputYM();
	}

	/******************************************************************************
		Description : 선택된 연월을 기준으로 날짜를 출력한다. 
	******************************************************************************/  
	function PrintCalendar(){

		// 첫째 날짜의 요일값을 가져온다. 
		var firstDay1 = new Date(yyyy, mm-1, 1);	//이번달 1일에 대해
		var firstDay2;													  //다음달 1일에 대해 
		var dayCnt = 28; 
		var Syymm = null ; 

		if (mm==12) { firstDay2 = new Date(yyyy+1, 0, 1); } else { firstDay2 = new Date(yyyy, mm, 1); } 

		// 해당 월의 날짜 수를 구한다. 
		var dateOfWeek1 = firstDay1.getDay(); 
		var dateOfWeek2 = firstDay2.getDay(); 
		var gap = dateOfWeek2 - dateOfWeek1; 
		if ( gap >= 0) { dayCnt+=gap } else { dayCnt+=gap+7; }

		if( (mm+"").length == 1){Syymm = yyyy + "0" + mm ;  }
		else {Syymm = yyyy +  mm ;  }


		// 출력한다. 
		var eachDay = new Array(43);
		var Cnt=0;
		var todayColor="", mOutCheck="";
		
		for (var i=1; i<=42; i++) { 
			if ( i >= dateOfWeek1+1 && i <= (dayCnt+dateOfWeek1) ) { // 해당일이 나타나야 할 경우
				Cnt++; 
				if ( Cnt == ddT ) { todayColor=" bgColor='#FDEF0A'"; mOutCheck=", 1"; } else { todayColor=""; mOutCheck=",0"; }

				if (Cnt<10) var idate = Syymm + "0" + Cnt;
				else var idate = Syymm + "" + Cnt;

				if (gcDs1.NameValue(Cnt,"HOLY_DIV")=="0"){

					eachDay[i] = "<td class='tab21' valign=bottom height='40px' onClick='Click("+Cnt.toString()+", this , 0);' onMouseOver='mOver(this);' onMouseOut='mOut(this"+mOutCheck+",1);' style='cursor:hand;' bgColor='#dfdfdf'>"+Cnt.toString()+"</td>\n"
				} else if (idate < ndate) {

					eachDay[i] = "<td class='tab21' valign=bottom height='40px' onClick='Click("+Cnt.toString()+", this, 0);' onMouseOver='mOver(this);' onMouseOut='mOut(this"+mOutCheck+",1);' style='cursor:hand;' bgColor='#dfdfdf'>"+Cnt.toString()+"</td>"
				} else {

					eachDay[i] = "<td class='tab21' valign=bottom height='40px' onClick='Click("+Cnt.toString()+", this, 1);' onMouseOver='mOver(this);' onMouseOut='mOut(this"+mOutCheck+",0);' style='cursor:hand;'>"+Cnt.toString()+"</td>\n"
				}

			} else {
				eachDay[i] = "<td class='tab21' style='height:35px;width:45px;' valign='bottom' >&nbsp;</td>"; 
			}
		}

		var data = ""
					+ "<table border='0' cellspacing='0' cellpadding='0' style='border:1 solid #aaaaaa;border-right-width:0px;border-bottom-width:0px;'>"
					+ "	<tr valign='middle' bgColor='#cfcfcf' align='center'>"
					+ "		<td class='tab21' style='width:45;height:24px'>일</td>"
					+ "		<td class='tab21' width=45>월</td>"
					+ "		<td class='tab21' width=45>화</td>"
					+ "		<td class='tab21' width=45>수</td>"
					+ "		<td class='tab21' width=45>목</td>"
					+ "		<td class='tab21' width=45>금</td>"
					+ "		<td class='tab21' width=45>토</td>"
					+ "	</tr>";

		// dateOfWeek1, dayCnt 에 유의
		for ( var i=0; i<6; i++ ) { 
				data+="	<tr valign='middle' align='center'>";
				for (var k=1; k<=7; k++ ) { data+=eachDay[i*7+k]; }
				data+="	</tr>";
		}

		data += "</table>";

		divCalendar.innerHTML = data;
		data = null;

	}

	/******************************************************************************
		Description : 날짜 클릭
	******************************************************************************/  
	function Click(d, obj, chk) {
		if (chk=="0") {
			alert("반출가능일자가 아닙니다");
			return;
		}
		obj.style.backgroundColor = "#FFAAAA";

		var return_value = new Array() ; 
		return_value =  SetReturnVal(d);
		
		window.returnValue = return_value ; 
		window.close();
	}

	/******************************************************************************
		Description :
	******************************************************************************/  
	function mOver(obj) {
		obj.style.backgroundColor = "#FFCCCC";
	}

	/******************************************************************************
		Description :
	******************************************************************************/  
	function mOut(obj, tod, chk) {
		obj.style.backgroundColor = "#FFFFFF";
		if ( chk==1 ) { obj.style.backgroundColor = "#dfdfdf"; }
	}

	/******************************************************************************
		Description : 연도, 월, 일, 연월일 반환
	******************************************************************************/  
	function SetReturnVal(d) {
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

		var cnt  = gcDs1.NameValueRow('APP_DT1',yyyyStr+mmStr+ddStr2) ;
		var ndat = "";
		var udat = "";

		if (cnt==0)	{
			gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00513_s3?v_str1=" + LINE_PART.BindColVal + "&v_str2=" + yyyyStr+mmStr+ddStr2;

			gcds_data.Reset();
			
			ndat=gcds_data.NameValue(gcds_data.rowposition,'APP_DT2');

		} else ndat = gcDs1.NameValue(cnt,'APP_DT2');

		if (cnt==0)	{ //공장상차도일 경우

      udat=gcds_data.NameValue(gcds_data.rowposition,'APP_DT3');		


		} else udat = gcDs1.NameValue(cnt,'APP_DT3');

		return ( new Array(yyyyStr, mmStr, ddStr2, yyyyStr+mmStr+ddStr2, ndat, udat) );


	}

	/******************************************************************************
		Description :
	******************************************************************************/  
	function keyCheck(){
		if (event.keyCode == 13) { window.focus(); }
	}

</script>

<script language=javascript for=LINE_PART event=OnSelChange2()>
	OutputYM();
</script>

<script language=javascript for=sel_month event=OnSelChange2()>
	ResetYM();
</script>

</head>

<body class="modalPop" onLoad="ln_Start();">

<table border="0" cellpadding="0" cellspacing="0" align="center" valign="middle">
  <tr><td style="height:5px;"></td></tr>
	<tr>
		<td style="width:150px;">
			<%=HDConstant.COMMENT_START%><OBJECT id=LINE_PART  style='border:0;position:relative;left:0px;top:2px;width:140px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
				<param name=ComboDataID			value=gcDs_etc1>  
				<param name=CBDataColumns		value="MINORCD,MINORNM">
				<param name=SearchColumn		value=MINORNM>
				<param name=SortColumn			value="MINORCD"> 
				<param name=Sort						value=True>
				<param name=ListExprFormat	value="MINORNM^0^140">
				<param name=BindColumn			value="MINORCD">
				<param name=Index						value=0>
				<param name=InheritColor		value="true">
				<param name=XPStyle					value="true">
			</OBJECT><%=HDConstant.COMMENT_END%> 
		</td>
		<td align="left" background="/img/title_bg.gif" style="height:35px;border:1 soild #cccccc">
			<select name="sel_year" class="selCal" style="position:relative;left:0px;top:2px;width:60px;border:1 solid #aaaaaa" onChange="YearAdd(this.value);">
				<option value='-1'>2001</option>
				<option value='1'>2002</option>
			</select>
			년&nbsp;&nbsp;
			<script language=javascript>
				sel_year.options[0].text = yyyy;
				sel_year.options[0].value = "-1";
				sel_year.options[1].text = yyyy+1;
				sel_year.options[1].value = "1";
			</script>
			<input type="hidden" name="txt_year">
		</td>
		<td background="/img/title_bg.gif">
			<%=HDConstant.COMMENT_START%><OBJECT id=sel_month style='position:relative;left:0px;top:4px;height:200;width:50px;' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
				<param name=CBData					value="1^01,2^02,3^03,4^04,5^05,6^06,7^07,8^08,9^09,10^10,11^11,12^12">
				<param name=CBDataColumns		value="CAL_CD,CAL_NM">
				<param name=SearchColumn		value="CAL_NM">
				<param name=ListExprFormat	value="CAL_NM^0^50">
				<param name=BindColumn			value="CAL_CD">
				<param name=XPStyle					value="1">
			</OBJECT><%=HDConstant.COMMENT_END%>&nbsp;<font style="position:relative;top:-2px">월</font>
		</td>
	</tr>
   <tr><td style="height:5px;"></td></tr>
	<tr>
		<td colspan=3>
			<div id="divCalendar">&nbsp;</div>
		</td>
	</tr>
	<tr><td style="height:10px;"></td></tr>
	<tr>
		<td><img src='../../../Common/img/disabled.gif' style="position:relative;left:2px;top:2px;">&nbsp;선택불가일자</td>
	</tr>
</table>

</body>
</html>
