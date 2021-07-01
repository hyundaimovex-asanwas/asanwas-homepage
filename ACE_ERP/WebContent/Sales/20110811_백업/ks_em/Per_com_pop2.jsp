<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%
/*-------------------------------------------------------------------------------
+ 시 스 템 명	:	
+ 프로그램 ID	: Per_com_pop.jsp
+ 기 능 정 의	: 
+ 변 경 이 력	: 
+ 서 블 릿 명	: 
------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 및 기타 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>

<html>
<head>
<jsp:include page="/Sales/common/include/head.jsp"/>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
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

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	gcds_data.DataID = "<%=dirPath%>/servlet/sales.em.Per_com_pop_s2?v_str1="+txt_empno.value+"&v_str2="+txt_empnmk.value+"&v_str3="+chk_s.value; 
	gcds_data.Reset();
}


/******************************************************************************
	Description : 창닫기
******************************************************************************/
function ln_Close(p){
	if (p=="A") {
		if(gcds_data.countrow<1) {
			alert("선택하실 협력업체가 없습니다.");
		}
		else {
			var row = gcds_data.rowposition;
      //alert(gcds_data.namevalue(row,"CUST_SID"));
			window.returnValue = gcds_data.namevalue(row,"EMPNO") + ";" 
                         + gcds_data.namevalue(row,"EMPNMK") + ";"
	                   	   + gcds_data.namevalue(row,"DEPT_NM") + ";"
	                   	   + gcds_data.namevalue(row,"TEAM_NM") + ";"
	                   	   + gcds_data.namevalue(row,"CUST_SID")+ ";"
	                   	   + gcds_data.namevalue(row,"JOB_CD")+ ";"
	                   	   + gcds_data.namevalue(row,"DEPT_CD")+ ";"
	                   	   + gcds_data.namevalue(row,"TEAM_CD")+ ";"
	                   	   + gcds_data.namevalue(row,"VEND_CD")+ ";"
	                   	   + gcds_data.namevalue(row,"WORK_CD")+ ";"
												 + gcds_data.namevalue(row,"SKILL_CD");
			window.close();
		}
	} else {
		window.close();
	}
}

/******************************************************************************
	Description : 퇴사 선택
******************************************************************************/
function ln_ChkBox_Chk(){
	if(chk_s.checked) {
		chk_s.value = '3';
	}else {
		chk_s.value = '1'
	}
}
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

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

  //alert(gcds_data.namevalue(rowposition,'TEAM_NM'));

	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	if(gcds_data.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick(row,colid)">
	if (row<1) return;
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
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:360px;border:0 solid #c5c5c5">
	<tr>
	  <td class="tab_a1111" style="width:30px;height:30px;">성명</td>
		<td class="tab_b0111" width="72px">
		 <input type="text" class="txt_a01" id="txt_empnmk" style="width:70px;position:relative;left:5px;top:0px;" maxlength="10" onkeydown="if(event.keyCode==13) ln_Query();">
    </td>
		<td class="tab_a0111" style="width:30px;height:30px;">사번</td>
		<td class="tab_b0111" width="65px">
		  <input type="text" class="txt_a01" id="txt_empno" style="width:60px;position:relative;left:5px;top:0px;" maxlength="10" onkeydown="if(event.keyCode==13) ln_Query();">
		</td>
		<td class="tab_a0111" style="width:30px;height:30px;" bgcolor="#eeeeee">퇴사</td>
		<td class="tab_b0111" bgcolor="#FFFFFF" width="100px">
			<input type="checkbox" id=chk_s   value=""    style="position:relative;left:5px;top:-2px;cursor:hand;width:20px" onClick="ln_ChkBox_Chk()" >
			<img src="../common//img/btn/com_b_find.gif" alt="해당 직원을 검색합니다" style="position:relative;left:8px;top:3px;cursor:hand;" onclick="ln_Query()">
		</td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td colspan="3">
			<comment id="__NSID__">
			<OBJECT id=gcgd_disp class="tab_b1111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:358;height:329px;" viewastext >
						<param name="DataID"			value="gcds_data">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Indwidth"	  VALUE="0">
						<PARAM NAME="Fillarea"	  VALUE="true">
						<PARAM NAME="Format"			VALUE="  
						<C>ID=EMPNO  	  Name=사번 	width=120 	HeadBgColor=#eeeeee align=center sort = true</C>
						<C>ID=EMPNMK		Name=성명	  width=220 	HeadBgColor=#eeeeee align=left	 sort = true</C>
				">
	    </OBJECT></comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:361;height:20px;border:1 solid #c5c5c5;border-top-width:0px;text-align:left;">
				&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
			</fieldset>
		</td>
	</tr>
	<tr><td height="4px"></td></tr>
	<tr>
		<td height="30px;" align="center">
			<img name="btn_select" border="0" src="../common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="../common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
</table>


</body>
</html>