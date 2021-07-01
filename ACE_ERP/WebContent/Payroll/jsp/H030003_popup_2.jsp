<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사
+ 프로그램 ID	: H030003_popup_2.HTML
+ 기 능 정 의	: 사원조회
+ 변 경 이 력	: 
+ 서 블 릿 명	: h030003_s2_1
------------------------------------------------------------------------------>



<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>

<title>사원조회</title>
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
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
var gs_level;
var gs_treecd;
//get_cookdata();
//lfn_init();
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){

  var strParam = new Array();
	strParam=window.dialogArguments;
	gs_level=strParam[0];
	gs_treecd=strParam[1];
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h030003_s2_1?"
									 + "v_str1=" +txt_nm.value
									 + "&v_str2=S" 
									 + "&v_str3="+gs_level
									 + "&v_str4="+gs_treecd; 
  
	gcds_data.Reset();
	
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(e){
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h030003_s2_1?"
									 + "v_str1=" + txt_nm.value;
	gcds_data.Reset();
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : 창닫기
******************************************************************************/
function ln_Close(e){
	if (e=="A") {
		var row = gcds_data.rowposition;
		window.returnValue = gcds_data.namevalue(row,"EMPNMK") + ";" + gcds_data.namevalue(row,"EMPNO") +";"+ gcds_data.namevalue(row,"PAYGRD") +";"+ gcds_data.namevalue(row,"PAYGNM") +";"+ gcds_data.namevalue(row,"DEPTCD") +";"+ gcds_data.namevalue(row,"DEPTNM") +";"+ gcds_data.namevalue(row,"GRSTRTDT") ;
		window.close();
	} else {
		window.close();
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	ft_cnt.innerText = "조회건수 : " + row + " 건";
</script>

<script language="javascript" for="gcgd_disp" event="OnDblClick()">

	ln_Close('A');

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:360px;border:1 solid #708090">
	<tr>
		<td class="tab12" width="80px;" bgcolor="#eeeeee">성명</td>
		<td width="110px"><input type="text" class="txt21" id="txt_nm" style="width:100px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		<td><img src="../../Common/img/btn/com_b_find.gif" alt="성명을 검색합니다" style="position:relative;left:2px;top:1px;cursor:hand;" onclick="ln_Query()"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:358;height:240px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    <PARAM NAME="DataID"			VALUE="gcds_data">
			  <PARAM NAME="BorderStyle" VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<PARAM NAME="Sortview"		VALUE="left">
			  <PARAM NAME="Format"			VALUE="  
					<F>ID=EMPNO,		Name=사번,		width=70,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=center sort=true</F>
					<F>ID=EMPNMK,		Name=성명,		width=80,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left sort=true</F>
					<F>ID=DEPTNM,		Name=소속명,	width=88,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left sort=true</F>
					<F>ID=PAYGNM,		Name=직위명,	width=88,		HeadBgColor=#B9D4DC, bgcolor=#f5f5f5, align=left sort=true</F>
				">
	    </OBJECT></comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>
	<tr>
		<td>
			<fieldset style="width:360;height:20px;background-color:#cccccc;border:1 solid #708090;border-top-width:0px;text-align:reft;">
				<font id=ft_cnt style="position:relative;top:3px;"></font>&nbsp;
			</fieldset>
		</td>
	</tr>
	<tr><td height="4px"></td></tr>
	<tr>
		<td height="30px;" align="center">
			<img name="btn_select" border="0" src="../../Common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="../../Common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
</table>

</body>
</html>