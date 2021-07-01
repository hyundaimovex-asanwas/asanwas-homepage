<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	: 감가상각 _ 년이월	팝업
+ 프로그램 ID	: AstForward_popup.html
+ 기 능 정 의	: 감가상각 년이월 팝업
+ 작   성  자 : 정영식
+ 작 성 일 자 : 2009.10.27
-----------------------------------------------------------------------------
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>년이월팝업</title>

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
var parentGubun="";
var gs_strGubun ="";
var gs_Gubun="";//관리부서(A) 현업부서(B) 구분
var gs_Divcd="";//  본부
var gs_Fdcode="";//  지점
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
  
	var strParam = new Array();
	strParam=window.dialogArguments;

    fdcode.value = strParam[0];
	fdcodenm.value = strParam[1];
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

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
	Description : 년이월
******************************************************************************/
function ln_Year_Forward(){

		if(!ln_Chk()) return;

		if(confirm(gcem_frdt.text+"년도 감가상각을 "+gcem_todt.text+"년도로 년이월 하시겠습니까?" )){
			gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>asetdep_yearforward_sp"
									       + "?v_str1="+fdcode.value+"&v_str2="+gcem_frdt.text									     
									       + "&v_str3=N";
		    gcds_data.Reset();
		}
}

/******************************************************************************
	Description : 년이월 체크 
******************************************************************************/
function ln_Chk(){
  var intfrdt=0;
	var inttodt=0;

	if(fdcode.value==""){
		alert("지점코드를 확인하십시요.");
		return false;
	}

	if(gcem_frdt.text==""){
		alert("From년이 누락 되었습니다.");
		gcem_frdt.Focus();
		return false;
	}

	if(gcem_todt.text==""){
		alert("To년이 누락 되었습니다.");
		gcem_todt.Focus();
		return false;
	}

	if(gcem_frdt.text>=gcem_todt.text){
		alert("From년 과 To년을 확인하십시요.");
		return false;
	}

	//4자리가 아닌 경우
	if(gcem_frdt.text.length!=4){
		alert("From년이 4자리 년도가 아닙니다. 확인하십시요.");
		gcem_frdt.Focus();
		return false;
	}
	
  if(gcem_todt.text.length!=4){
		alert("To년이 4자리 년도가 아닙니다. 확인하십시요.");
		gcem_todt.Focus();
		return false;
	}

	//from과 to가 2년이상 차이가 날 경우 
	intfrdt = gcem_frdt.text;
	inttodt = gcem_todt.text;

	if (inttodt-intfrdt>1) {
			alert("From년 과 To년 차이가 1년이 아닙니다.");
			return false;
	}

  //년이월 마감 체크
  gcds_chk.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>astFinish_chk_s1"
									+ "?v_str1="+fdcode.value+"&v_str2=2"
									+ "&v_str3="+gcem_frdt.text+"&v_str4=";
	gcds_chk.Reset(); 

  if(gcds_chk.namevalue(gcds_chk.rowposition,"CNT")>=1){
		alert(gcem_frdt.text+"년도 연마감이 되었습니다. 해당년도 년이월 할 수 없습니다.");
		return false;
	}

  return true;
}

/******************************************************************************
	Description : 창닫기
	parameter   : A - 선택
******************************************************************************/
function ln_Close(){
	window.close();
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
  <object  id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  </object>

	<object  id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  </object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_data" event="OnLoadStarted()">
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">

  alert("S_YN::"+gcds_data.namevalue(row,"S_YN"));

  if(gcds_data.namevalue(row,"S_YN")=="Y"){
		alert("년이월 작업이 정상적으로 완료 되었습니다.");
	}else{
		alert("년이월 작업이 정상적으로 완료 되지 못하였습니다.");
	}
</script>

<script language=JavaScript for=gcem_frdt event=onKillFocus()>
	if(gcem_frdt.text!=""){
		gcem_todt.text=Number(gcem_frdt.text)+1;
	}
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

<table width="325px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td width="325px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		  <img src="../../Common/img/btn/com_b_eyuol.gif"   style="cursor:hand;position:relative;top:3px;" onclick="ln_Year_Forward()">
		</td>
	</tr>
	<tr> 
		<td width="325px" align="left" background="../../Common/img/com_t_bg.gif" >&nbsp;
		</td>
	</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:3px;top:1px;width:325px;border:1 solid #708090">
	<tr>

	  <td class="tab12" width="50px;" bgcolor="#eeeeee" align="center">지점</td>
		<td width="90px"><nobr>&nbsp;
		   <input type="text" class="txt11" id="fdcode"    style="position:relative;left:-6px;width:20px;background-color:#d7d7d7" readOnly>
			 <input type="text" class="txt11" id="fdcodenm"  style="position:relative;left:-6px;width:50px;background-color:#d7d7d7" readOnly>
		</td>
    <td class="tab16" width="50px;" bgcolor="#eeeeee" align="center">FROM년</td>
		<td width="40px"><nobr>&nbsp;
		    <comment id="__NSID__">
				<object id=gcem_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
					style="position:relative;left:-4px;top:2px; width:35px; height:20px;" >
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY">
					<param name=PromptChar	  value="_">
					<param name=Enable				value="true">
				</object>
				</comment><script>__ws__(__NSID__);</script> 
		</td>

		<td class="tab16" width="50px;" bgcolor="#eeeeee" align="center">TO년</td>
		<td width="40px" ><nobr>&nbsp;
		    <comment id="__NSID__">
				<object id=gcem_todt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
					style="position:relative;left:-4px;top:2px; width:35px; height:20px;" >
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY">
					<param name=PromptChar	  value="_">
					<param name=Enable				value="true">
				</object>
				</comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
</table>
<table>
	<tr>
		<td height="1" > </td>
	</tr>
</table>
<table border="0" cellpadding="1" cellspacing="1" style="position:relative;left:3px;top:1px;width:325px;border:1 solid #708090">
	<tr>
    <td colspan=2> &nbsp;예) <font size="2" color="blue"> 2009년 ==> 2010년 </font> 으로 년이월 </td>
	</tr>
  <tr>
    <td> &nbsp;&nbsp;&nbsp;&nbsp;*FROM년 : 2009</td>
		<td> *TO년 : 2010 </td>
	</tr>
</table>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
