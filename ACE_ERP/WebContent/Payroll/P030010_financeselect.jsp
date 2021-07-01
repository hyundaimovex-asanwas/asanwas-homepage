<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명	: 급여시스템
 * 프로그램ID 	: P030010_financeselect
 * J  S  P		: 
 * 서 블 릿		: 
 * 작 성 자		: 이 동 훈
 * 작 성 일		: 2011-1-8

 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy = request.getParameter("eyy");		//귀속년도
    String eno = request.getParameter("eno");		//사번
%>

<html>
<head>
<title>2011년 금융기관 검색</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<LINK href="imgs/css_ehr.css" type=text/css rel=stylesheet>


<!-- 기존 가우스 시작-->
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../common/include/PubFun.js"></script>

<script language="javascript" src="js/PubFun.js"></script>
<script language="javascript" src="js/embedControl.js"></script>
<script language="javascript" src="js/menu.js"></script>
<script language="javascript" src="js/common_gauce.js"></script>
<script language="javascript" src="js/common_pop.js"></script>      
<script language="javascript" src="js/common.js"></script>       
<script language="javascript" src="imgs/web.js"></script>
<script language="javascript" src="imgs/06yearentry.js"></script>
<script language="javascript" src="imgs/applychk.js"></script>
<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	var gstrChk =""; //등록
	var gs_level;
	var gs_treecd;
	
	get_cookdata();
	

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	gcds_data.DataID = "/services/servlet/Payroll.p030010_s9?"
									+ "v_str1=" + txt_finanm.value;

	gcds_data.Reset();

}



/******************************************************************************
	Description : 선택
******************************************************************************/
function ln_select(){

			var row = gcds_data.rowposition;

			window.returnValue = gcds_data.namevalue(row,"FINACD") + ";" + gcds_data.namevalue(row,"FINANM");				

			window.close();
}




/******************************************************************************
	Description : 창닫기
******************************************************************************/
function ln_Close(){
		window.close();
}
</script>


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>



<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if(gcds_data.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick()">
	ln_select();
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>




<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:360px;border:1 solid #708090">
	<tr>
		<td class="tab12" width="100px;" height="30px;"bgcolor="#eeeeee"align = center>금융기관</td>
		<td width="110px">
		<input type="text" class="txt11" id="txt_finanm" style="width:200px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		<td><img src="../../common/img/btn/com_b_find.gif" alt="금융기관을 검색합니다" style="position:relative;left:2px;top:1px;cursor:hand;" onclick="ln_Query()"></td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" >
			<comment id="__NSID__">
			<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:360;height:300px;border:1 solid #708090;border-left-width:1px;border-top-width:1px;">
		    <PARAM NAME="DataID"			VALUE="gcds_data">
			  <PARAM NAME="BorderStyle" VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="sortview"     value=left>
			  <PARAM NAME="Format"			VALUE="  
					<C>ID=FINACD,		Name=코드,		width=100,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
					<C>ID=FINANM,		Name=금융기관,		width=250,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
				">
	    </OBJECT></comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:360;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
				&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
			</fieldset>
		</td>
	</tr>
	<tr><td height="4px"></td></tr>
	<tr>
		<td height="30px;" align="center">
			<img name="btn_select" border="0" src="../../common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_select()">
			<img name="btn_close" border="0" src="../../common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close()">
		</td>
	</tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:25px; top:130px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"> </iframe>

</body>
</html>
