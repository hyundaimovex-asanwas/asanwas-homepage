<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 직원 검색
+ 프로그램 ID	: empno_popup4.jsp
+ 기 능 정 의	: 
+ 변 경 이 력	: 
+ 서 블 릿 명	: 
+ 작  성  자  : 이 동 훈
+ 작 성 일 자 : 2018/02/07
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>직원 조회</title>

<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var parentGubun="";

get_cookdata();

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){



}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(e){

  	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>empno_s4?"  
								   							+ "v_str1="+txt_nm.value;
  

	gcds_data.Reset();
	
}



/******************************************************************************
	Description : 창닫기
******************************************************************************/
function ln_Close(e){
		
  var row= gcds_data.rowposition;

	if(e=="A"){
		
		window.returnValue = gcds_data.namevalue(row,"ENO_NO") + ";" 
							+ gcds_data.namevalue(row,"ENO_NM") + ";"
							+ gcds_data.namevalue(row,"DPT_NM") + ";"
							+ gcds_data.namevalue(row,"JOB_NM") ;
		
		window.close();
		
	}else{
		
		window.close();
	}
	
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

</script>
<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	if(gcds_data.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick()">
	ln_Close('A');
</script>

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
		<td class="tab12" width="50px;" bgcolor="#eeeeee">성명</td>
		<td width="120px">
			<input type="text" class="txt11" id="txt_nm" style="width:100px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		<td><img src="../../Common/img/btn/com_b_find.gif" alt="성명을 검색합니다" style="position:relative;left:2px;top:1px;cursor:hand;" onclick="ln_Query()"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:358;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    <PARAM NAME="DataID"			VALUE="gcds_data">
			  <PARAM NAME="BorderStyle" VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="sortview"     value=left>
			  <PARAM NAME="Format"			VALUE="  
					<C>ID=ENO_NO,		Name=사번,		width=70,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
					<C>ID=ENO_NM,		Name=성명,		width=80,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
					<C>ID=DPT_NM,		Name=소속,		width=106,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
					<C>ID=JOB_NM,		Name=직위,		width=86,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
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
			<img name="btn_select" border="0" src="../../Common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="../../Common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
</table>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 