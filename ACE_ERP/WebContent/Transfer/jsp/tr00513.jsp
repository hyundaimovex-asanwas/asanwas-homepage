 <%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	: 달력정보관리
+ 프로그램 ID	: TR00513
+ 기 능 정 의	: 조회|등록|저장|삭제
+ 변 경 이 력	: 윤정민
+ 작성일자 :
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 :
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서 블 릿 명	: tr00501_s1, tr00501_s2, tr00501_s3, tr00501_t1, tr00501_t2
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


<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
		get_cookdata();
	
		var gcal = "";
		var gcalgbn = "N";
	
		// 오늘을 구한다. 
		var today = new Date();
		var yyyy, mm, dd, ddT;
		var yyyyStr, mmStr, ddStr;
		var dateOfWeek;
	
		var oyyyy, omm;
	
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]

			ln_Start();//선조회

			window.status="완료";

		}	
	/******************************************************************************
		Description : 페이지 로딩
	******************************************************************************/
	function ln_Start(){

		yyyy = today.getYear();
		mm = today.getMonth()+1;
		dd = today.getDate();
		ddT = dd;

		oyyyy = yyyy;
		omm = mm;

		ln_OutputYM();
		if (mm<10) mm = "0" + mm;

		gcem_yymm.text = yyyy + "" + mm;

		gcds_data1.DataId =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0002"; //Project
		gcds_data1.Reset();
	}

	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query(){

	 gcalgbn = "N";

		if (gclx_line_part.bindcolval == ""){
			alert("프로젝트를 선택해 주십시오.");
			return;
		}

		if (gcem_yymm.text==""){
			alert("검색년월을 입력해 주십시오.");
			return;
		}
		
		var ls_yyyy = parseInt(gcem_yymm.text.substring(0,4)) - yyyy;
		var ls_mm = parseInt(gcem_yymm.text.substring(4,6),10);
		
		ln_YearAdd(ls_yyyy);
		mm = ls_mm;

		gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00513_s1"
									  + "?v_str1="+gclx_line_part.BindColVal
									  + "&v_str2="+gcem_yymm.text;
		gcds_data.Reset();

		ln_OutputYM();
	}

	/******************************************************************************
		Description : 저장
	******************************************************************************/
	function ln_Save() {

		if (gcds_data.IsUpdated){

			for (var i=1; i<=gcds_data.countrow; i++){
				if (gcds_data.sysStatus(i)=="3") {
					if (gclx_holy_div.bindColval=="2"){
						var appdt  = fRtrim(gcds_data.namevalue(i,"cal_dt"));
						var appdt1 = fRtrim(gcds_data.namevalue(i,"app_dt1"));
						var appdt2 = fRtrim(gcds_data.namevalue(i,"app_dt2"));
						var appdt3 = fRtrim(gcds_data.namevalue(i,"app_dt3"));

						if (appdt1.length<8){
							alert(i+"일 날자의 신청가능일을 입력해 주십시오.");
							return;
						}
						
						var dcnt = parseInt(appdt1)-parseInt(appdt);

						if (dcnt<4 ){
							alert(i+"일 날자의 신청가능일은 D-4일전 입니다.");
							return;
						}

						if (appdt2.length<8){
							alert(i+"일 날자의 입고일자를 입력해 주십시오.");
							return;
						}

						if (appdt3.length<8){
							alert(i+"일 날자의 상차일자를 입력해 주십시오.");
							return;
						}

					}
				}
			}

			if (confirm("저장하시겠습니까?")) {
				gctr_data.KeyValue = "tr00513_t1(I:DATA=gcds_data)";
				gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00513_t1";
				gctr_data.Parameters = "v_str1=" + gusrid;
				gctr_data.post();
			}
		}

	}

	/******************************************************************************
		Description : 날짜 문자형을 숫자형으로 바꾸기
	******************************************************************************/
	function ln_ToIntYMD(){
		if ( yyyyStr!="" && !isNaN(yyyyStr )) { yyyy = parseInt(yyyyStr); }
		if ( mmStr!="" && !isNaN(mmStr )) { mm = parseInt(mmStr); }
		dd = parseInt(ddStr);
	}

	/******************************************************************************
		Description : 연도와 월을 출력한다. 년도, 월의 증감을 있게 한다. 
	******************************************************************************/
	function ln_OutputYM() {
		txt_year.value=yyyy.toString(); 
		sel_month.value=mm.toString(); 

		ln_PrintCalendar();
		window.focus();
	}

	/******************************************************************************
		Description : 
	******************************************************************************/
	function ln_InputYM() {
		yyyy = parseInt(txt_year.value);
		mm = parseInt(sel_month.value);	
	}

	/******************************************************************************
		Description : 
	******************************************************************************/
	function ln_YearAdd(val) {
		ln_ResetYM();
		yyyy += val;
		ln_OutputYM();
	}

	/******************************************************************************
		Description : 
	******************************************************************************/
	function ln_ResetYM() {
		ln_InputYM();	
		ln_ToIntYMD();
		ln_OutputYM();
	}

	/******************************************************************************
		Description : 선택된 연월을 기준으로 날짜를 출력한다. 
	******************************************************************************/
	function ln_PrintCalendar(){
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

		// 출력한다. 
		var eachDay = new Array(43);
		var Cnt=0;
		var todayColor="", mOutCheck="";
		
		for (var i=1; i<43; i++) { 
			if (i==1 || i==8 || i==15 || i==22 || i==29 || i==36)	var ls_for = "<td style='height:60px;width:80px;color:#ff0000;border:0 solid #777777;border-left-width:1px;border-top-width:1px;text-align:left' valign='top'";
			else if (i==7 || i==14 || i==21 || i==28 || i==35 )	var ls_for = "<td style='height:60px;width:80px;color:#0000ff;border:0 solid #777777;border-left-width:1px;border-top-width:1px;text-align:left' valign='top'";
			else var ls_for = "<td style='height:60px;width:80px;border:0 solid #777777;border-left-width:1px;border-top-width:1px;text-align:left' valign='top'";

			if ( i >= dateOfWeek1+1 && i <= (dayCnt+dateOfWeek1) ) { // 해당일이 나타나야 할 경우
				Cnt++; 
				if ( Cnt == ddT ) { todayColor=" bgColor='#FDEF0A'"; mOutCheck=", 1"; } else { todayColor=""; mOutCheck=""; }
				eachDay[i] = ls_for + " onClick='ln_Click("+Cnt.toString()+", this);' onMouseOver='ln_mOver(this);' onMouseOut='ln_mOut(this"+mOutCheck+");' style='cursor:hand;'"+todayColor+" ><span id=sp" + Cnt.toString() + " style='position:relative;left:5px;top:5px'>"+Cnt.toString()+"</span><br><font id=ta" + Cnt.toString()+ " style='position:relative;left:10px;top:10px;width:60px;height:30px;'></font></td>\n"
			} else {
				eachDay[i] = ls_for + ">&nbsp;</td>\n"; 
			}
		}

		var data = ""
					+ "<table border='0' cellspacing='0' cellpadding='0' style='border:1 solid #aaaaaa;border-left-width:0px;'>\n"
					+ "	<tr valign='middle' align='center'>\n"
					+ "		<td style='width:80;height:80px;border:0 solid #777777;border-left-width:1px;color:#ff0000;background-color:#efefef;font-family:굴림;font-size:12pt;'>일</td>\n"
					+ "		<td style='width:80;border:0 solid #777777;border-left-width:1px;background-color:#efefef;font-family:굴림;font-size:12pt;'>월</td>\n"
					+ "		<td style='width:80;border:0 solid #777777;border-left-width:1px;background-color:#efefef;font-family:굴림;font-size:12pt;'>화</td>\n"
					+ "		<td style='width:80;border:0 solid #777777;border-left-width:1px;background-color:#efefef;font-family:굴림;font-size:12pt;'>수</td>\n"
					+ "		<td style='width:80;border:0 solid #777777;border-left-width:1px;background-color:#efefef;font-family:굴림;font-size:12pt;'>목</td>\n"
					+ "		<td style='width:80;border:0 solid #777777;border-left-width:1px;background-color:#efefef;font-family:굴림;font-size:12pt;'>금</td>\n"
					+ "		<td style='width:80;border:0 solid #777777;border-left-width:1px;color:#0000ff;background-color:#efefef;font-family:굴림;font-size:12pt;'>토</td>\n"
					+ "	</tr>\n";

		// dateOfWeek1, dayCnt 에 유의
		for ( var i=0; i<6; i++ ) { 
				data+="	<tr valign='middle' align='center'>\n";
				for (var k=1; k<=7; k++ ) { 
					data+=eachDay[i*7+k]; 
				}
				data+="	</tr>\n";
		}

		data += "</table>";

		divCalendar.innerHTML = data;
		data = null;

		for (var s=1; s<=gcds_data.countrow; s++){
			if (gcds_data.namevalue(s,"HOLY_DIV")=="0"){
				eval("sp"+s).style.color="#ff0000";
				eval("ta"+s).style.color="#ff0000";
			}
			var srem = gcds_data.namevalue(s,"CAL_REM");
			if (srem!="") eval("ta"+s).innerText = srem;
		}

	}

	/******************************************************************************
		Description : 날짜 클릭/마우스 오버-아웃등 
	******************************************************************************/
	function ln_Click(d, obj) {
		gcal = d;

		gcem_app_dt.text = gcds_data.namevalue(d,"cal_dt");
		gclx_holy_div.BindColVal = gcds_data.namevalue(d,"holy_div");
		gcem_app_dt1.text = gcds_data.namevalue(d,"app_dt1");
		gcem_app_dt2.text = gcds_data.namevalue(d,"app_dt2");
		gcem_app_dt3.text = gcds_data.namevalue(d,"app_dt3");
		gclx_holy_type.BindColVal = gcds_data.namevalue(d,"holy_type");
		txt_cal_rem.value = gcds_data.namevalue(d,"cal_rem");

		gcalgbn = "Y";
	}

	/******************************************************************************
		Description : 
	******************************************************************************/
	function ln_DataChange(e){
		if (gcalgbn=="Y") {
			if (e=="HOLY_DIV") gcds_data.namevalue(gcal,"holy_div")	= gclx_holy_div.bindColVal;
			if (e=="HOLY_TYPE") gcds_data.namevalue(gcal,"holy_type")	= gclx_holy_type.bindColVal;
			if (e=="APP_DT1")	gcds_data.namevalue(gcal,"app_dt1")		= gcem_app_dt1.text;
			if (e=="APP_DT2")	gcds_data.namevalue(gcal,"app_dt2")		= gcem_app_dt2.text;
			if (e=="APP_DT3")	gcds_data.namevalue(gcal,"app_dt3")		= gcem_app_dt3.text;
			if (e=="CAL_REM")	gcds_data.namevalue(gcal,"cal_rem")		= txt_cal_rem.value;
		}
	}

	/******************************************************************************
		Description : 
	******************************************************************************/
	function ln_mOver(obj) {
		obj.style.backgroundColor = "#FFAAAA";
	}

	/******************************************************************************
		Description : 
	******************************************************************************/
	function ln_mOut(obj, tod) {
		obj.style.backgroundColor = "#FFFFFF";
		if ( tod==1 ) { obj.style.backgroundColor = "#FDEF0A"; }
	}

	/******************************************************************************
		Description : 
	******************************************************************************/
	function ln_SetReturnVal(d) { // 연도, 월, 일, 연월일 반환
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

	/******************************************************************************
		Description : 
	******************************************************************************/
	function ln_KeyCheck(){
		if (event.keyCode == 13) { window.focus(); }
	}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--프로젝트검색-->
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!--달력정보검색-->
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for=gcds_data1 event="OnLoadCompleted(row)">
	ln_Query();
</script>

<script language=javascript for=gcds_data event="OnLoadCompleted(row)">
	gcem_app_dt.text = "";
	gclx_holy_div.index = 0;
	gcem_app_dt1.text = "";
	gcem_app_dt2.text = "";
	gcem_app_dt3.text = "";
	gclx_holy_type.index = 0;
	txt_cal_rem.value = "";
</script>

<script language=javascript for=gclx_holy_div event="OnSelChange2()">
	ln_DataChange('HOLY_DIV');
	if (gclx_holy_div.bindColVal=="0") {
		gcem_app_dt1.text = "";
		gcem_app_dt2.text = "";
		gcem_app_dt3.text = "";
		if (gcalgbn=="Y"){
			gcds_data.namevalue(gcal,"app_dt1")		= "";
			gcds_data.namevalue(gcal,"app_dt2")		= "";
			gcds_data.namevalue(gcal,"app_dt3")		= "";
		}
	}
</script>

<script language=javascript for=gclx_holy_type event="OnSelChange2()">
	ln_DataChange('HOLY_TYPE');
</script>

<script language=javascript for=gcem_app_dt1 event="OnKeyUp()">
	ln_DataChange('APP_DT1');
</script>

<script language=javascript for=gcem_app_dt2 event="OnKeyUp()">
	ln_DataChange('APP_DT2');
</script>

<script language=javascript for=gcem_app_dt3 event="OnKeyUp()">
	ln_DataChange('APP_DT3');
</script>

<script language=javascript for=gctr_data event=onsuccess()>
	alert("정상적으로 저장되었습니다.");
	ln_Query();
</script>

<script language=javascript for=gctr_data event=onfail()>
	alert("error code : " + gctr_data.errorcode + "\n" + "error message : " + gctr_data.errormsg + "\n");
</script>

<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s07.jsp"  flush="true"/>
<BODY>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td width="876" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;"> 
			<img src="../../../Common/img/btn/com_b_save.gif" style="cursor:hand" onclick="ln_Save()">
			<img src="../../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
		</td>
  </tr>
	<tr>
		<td colspan=2> 
			<table  cellpadding="0" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr>
					<td style="width:100px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" align=center>프로젝트</td>
					<td style="width:200px;border:0 solid #708090;border-right-width:1px;">
						<%=HDConstant.COMMENT_START%><OBJECT id=gclx_line_part  style='border:0;position:relative;left:8px;top:0px;width:160px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 tabindex="1">
							<param name=ComboDataID			value=gcds_data1>  
							<param name=CBDataColumns		value="MINORCD,MINORNM">
							<param name=SearchColumn		value="MINORNM">
							<param name=SortColumn			value="MINORCD"> 
							<param name=Sort						value="True">
							<param name=ListExprFormat	value="MINORNM^0^160">
							<param name=BindColumn			value="MINORCD">
							<param name=Index						value="0">
							<param name=InheritColor		value="true"> 
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
					<td style="width:100px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" align=center>검색년월</td>
					<td>
						<%=HDConstant.COMMENT_START%><OBJECT id=gcem_yymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:8px;top:0px" onkeydown="if(event.keyCode==13) ln_Query();">
							<param name=Alignment				value=1>
							<param name=Border					value=true>
							<param name=ClipMode				value=true>
							<param name=IsComma					value=true>
							<param name=Format					value="YYYY/MM">
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td colspan=2 height=3></td></tr>  	
  <tr> 
    <td colspan="2" valign=top> 
			<table border=0 cellpadding=0 cellspacing=0 style="width:100%">
				<tr>
					<td style="width:560px;">
						<div style="position:absolute;top:0px;left:0px;visibility:hidden">
						<table border="0" cellpadding="0" cellspacing="0" align="center" valign="middle">
							<tr><td style="height:10px;"></td></tr>
							<tr>
								<td align="center" background="/img/title_bg.gif" style="height:35px;">
									<input type="text" name="txt_year" class="textCal" style="width:30px;border:1 solid #aaaaaa" maxlength=4 onFocus="this.select();" onKeyup="ln_KeyCheck();" onBlur="ln_ResetYM();">&nbsp;년&nbsp;&nbsp;
									<input type="button" class="btnCal" value="◀" onclick="ln_YearAdd(-1);" style="cursor:hand;background-color:#e3e3e3">&nbsp;<input type="button" class="btnCal" value="▶" onclick="ln_YearAdd(1);" style="cursor:hand;background-color:#e3e3e3">
								</td>
								<td background="/img/title_bg.gif">
									<select name="sel_month" class="selCal" style="width:38px;border:1 solid #aaaaaa" onChange="ln_ResetYM();">
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
									</select>&nbsp;월
								</td>
							</tr>
							<tr><td style="height:5px;"></td></tr>
							<tr>
								<td colspan=2><!--<div id="divCalendar">&nbsp;</div>-->
								</td>
							</tr>
						</table>
						</div>
						<div id="divCalendar">&nbsp;</div>
					</td>
					<td>&nbsp;</td>
					<td valign=top>
						<table border="0" cellpadding="0" cellspacing="0" style="width:307px; "><!-- height:420px; -->
							<tr>
								<td valign=middle width=100 style="height:30px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#B9D4DC" align=center class="txtbox"><nobr>&nbsp;상세내역&nbsp;</nobr></td>
								<td style="border:0 solid #708090;border-bottom-width:0px;" align=right>&nbsp;</td>
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#eeeeee" class="txtbox">&nbsp;선택일자</td>
								<td style="border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;">&nbsp;
									<%=HDConstant.COMMENT_START%>
									<OBJECT id=gcem_app_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:2px;top:6px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;">
											<param name=Alignment			value="0">
											<param name=Border	      value="false">
											<param name=Format	      value="YYYY/MM/DD">
											<param name=Enable				value="0">
									</OBJECT>
									<%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#eeeeee" class="txtbox">&nbsp;휴일여부</td>
								<td style="border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;">&nbsp;
									<%=HDConstant.COMMENT_START%>
									<OBJECT id=gclx_holy_div classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100 style="position:relative;top:2px;">
										<param name=CBData			   value="0^휴일,2^근무일">
										<param name=CBDataColumns	 value="code,name">
										<param name=SearchColumn	 value="name">
										<param name=ListExprFormat value="name">								
										<param name=BindColumn		 value="code">
										<param name=Index			     value="0">
									</OBJECT>
									<%=HDConstant.COMMENT_END%>
								</td>								
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#eeeeee" class="txtbox">&nbsp;신청가능일</td>
								<td style="border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;">&nbsp;
									<%=HDConstant.COMMENT_START%>
									<OBJECT id=gcem_app_dt1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:2px;top:6px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;">
											<param name=Alignment			value="0">
											<param name=Border	      value="false">
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
									</OBJECT>
									<%=HDConstant.COMMENT_END%>
									<img src="../../../Common/img/btn_calendar.gif" style="position:relative;left:0px;top:3px;cursor:hand" onclick="__GetCallCalendar3('gcem_app_dt1', 'Text');">
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#eeeeee" class="txtbox">&nbsp;입고일자</td>
								<td style="border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;">&nbsp;
									<%=HDConstant.COMMENT_START%>
									<OBJECT id=gcem_app_dt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:2px;top:6px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;">
											<param name=Alignment			value="0">
											<param name=Border	      value="false">
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
									</OBJECT>
									<%=HDConstant.COMMENT_END%>
									<img src="../../../Common/img/btn_calendar.gif" style="position:relative;left:0px;top:3px;cursor:hand" onclick="__GetCallCalendar3('gcem_app_dt2', 'Text');">
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#eeeeee" class="txtbox">&nbsp;상차일자</td>
								<td style="border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;">&nbsp;
									<%=HDConstant.COMMENT_START%>
									<OBJECT id=gcem_app_dt3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:2px;top:6px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;">
											<param name=Alignment			value="0">
											<param name=Border	      value="false">
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
									</OBJECT>
									<%=HDConstant.COMMENT_END%>
									<img src="../../../Common/img/btn_calendar.gif" style="position:relative;left:0px;top:3px;cursor:hand" onclick="__GetCallCalendar3('gcem_app_dt3', 'Text');">
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#eeeeee" class="txtbox">&nbsp;공휴일구분</td>
								<td style="border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;">&nbsp;
									<%=HDConstant.COMMENT_START%>
									<OBJECT id=gclx_holy_type classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100 style="position:relative;top:2px;">
										<param name=CBData			   value="0^공휴일,1^국경일,2^평일,3^임시휴일,4^북측휴일">
										<param name=CBDataColumns	 value="code,name">
										<param name=SearchColumn	 value="name">
										<param name=ListExprFormat value="name">								
										<param name=BindColumn		 value="code">
										<param name=Index			     value="0">
									</OBJECT>
									<%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td style="height:110px;border:1 solid #708090;border-top-width:1px;" bgcolor="#eeeeee" class="txtbox">&nbsp;비고</td>
								<td style="border:1 solid #708090;border-left-width:0px">
									<textarea id=txt_cal_rem style="position:relative;left:8px;width:190px;height:100px;font-family:굴림;font-size:9pt;border:1 solid #777777;IME-MODE: active" onchange="ln_DataChange('CAL_REM')"></textarea>
								</td>
							</tr>
							<tr>
								<td style="height:121px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" class="txtbox">&nbsp;</td>
								<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</body>
</HTML>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>