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
<title>달력(월)</title>

<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
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
	
	//로컬에서 사용하기 위해 임의로 막음.
    /*
	//var gs_date = gn_Replace(gcurdate,"/");
   */
   
    var now = new Date(); 
    var gs_date=now.getYear();

	/******************************************************************************
		Description : 페이지 로딩
	******************************************************************************/
	function ln_Start(){
		gcem_yymm.text = gs_date;
	}

	/******************************************************************************
		Description : str문자열의 s부터 cnt의 갯수만큼 return
	******************************************************************************/
	function Mid(str,s,cnt ){
		s = s - 1;
		return( str.substring( s, s + cnt ) );
	}

	/******************************************************************************
		Description : 
	******************************************************************************/
	function fSetDate(iMonth)	{
		if (gcem_yymm.text.length == 4 ) {
			window.returnValue = gcem_yymm.text + iMonth;
			window.close();
		}
	}

	/******************************************************************************
		Description : 
	******************************************************************************/
	function WinClose()	{
		window.close();
	}

	/******************************************************************************
		Description : 월이동
	******************************************************************************/
	function ln_MonthMove(arg){
    if(arg == "L")	gcem_yymm.text = gcem_yymm.text - 1 ;
    else gcem_yymm.text = eval(gcem_yymm.text) + 1 ;
	}
</script>

<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start();">
<table border="0" cellpadding="0" cellspacing="0" align=center>
	<tr><td style="height:5px;"></td></tr>
	<tr>
		<td valign="top" style="border:1 solid #c5c5c5;border-bottom-width:0px;">
			<table border="0" cellpadding="0" cellspacing="0" width="162" height="32">
				<tr><td style="height:9px;"></td></tr>
				<tr>
					<td style="width:20px;"></td>
					<td style="width:120px" align=center>
						<img src="../img/btn/com_b_left.gif" style="cursor:hand" border="0" OnClick="ln_MonthMove('L');">

						  <object id="gcem_yymm" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" style="position:relative;top:1px;left:0px;height:15;width:65">
							<param name="Alignment"      value="1">
							<param name="Border"         value="false">
							<param name="Format"         value="0000년">
							<param name="PromptChar"     value="_">
							<param name="MoveCaret"      value="true">
							<param name="Enable"         value="false">
						  </object>
						  
						<img src="../img/btn/com_b_right.gif" style="cursor:hand" border="0" OnClick="ln_MonthMove('R');">
					</td>
					<td></td>
				</tr>
				<tr><td style="height:5px;"></td></tr>
			</table>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<table class="tab_b1010" border="0" cellpadding="0" cellspacing="0">
				<tr style="height:42px;">
					<td class="tab_b0101" OnClick="fSetDate('01');" style="cursor:hand;text-align:center" bgcolor="#f5f5f5" width="42">1월</td>
					<td class="tab_b0101" OnClick="fSetDate('02');" style="cursor:hand;text-align:center" bgcolor="#f5f5f5" width="42">2월</td>
					<td class="tab_b0101" OnClick="fSetDate('03');" style="cursor:hand;text-align:center" bgcolor="#f5f5f5" width="42">3월</td>
					<td class="tab_b0101" OnClick="fSetDate('04');" style="cursor:hand;text-align:center" bgcolor="#f5f5f5" width="42">4월</td>
				</tr>
				<tr style="height:42px;">
					<td class="tab_b0101" OnClick="fSetDate('05');" style="cursor:hand;text-align:center" bgcolor="#f5f5f5">5월</td>
					<td class="tab_b0101" OnClick="fSetDate('06');" style="cursor:hand;text-align:center" bgcolor="#f5f5f5">6월</td>
					<td class="tab_b0101" OnClick="fSetDate('07');" style="cursor:hand;text-align:center" bgcolor="#f5f5f5">7월</td>
					<td class="tab_b0101" OnClick="fSetDate('08');" style="cursor:hand;text-align:center" bgcolor="#f5f5f5">8월</td>
				</tr>
				<tr style="height:42px;">
					<td class="tab_b0101" OnClick="fSetDate('09');" style="cursor:hand;text-align:center" bgcolor="#f5f5f5">9월</td>
					<td class="tab_b0101" OnClick="fSetDate('10');" style="cursor:hand;text-align:center" bgcolor="#f5f5f5">10월</td>
					<td class="tab_b0101" OnClick="fSetDate('11');" style="cursor:hand;text-align:center" bgcolor="#f5f5f5">11월</td>
					<td class="tab_b0101" OnClick="fSetDate('12');" style="cursor:hand;text-align:center" bgcolor="#f5f5f5">12월</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 