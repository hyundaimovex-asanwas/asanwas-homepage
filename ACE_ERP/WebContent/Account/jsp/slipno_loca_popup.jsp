<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<!---------------------------------------------------------------------------
+ 시 스 템 명	:  전표관리 - 전표작성경로 Popup
+ 프로그램 ID	:  Slipno_loca_popup.html
+ 기 능 정 의	:  전표작성경로 팝업창
+ 작   성  자 : 하민숙
+ 서 블 릿 명	:	 Slipno_loca_s1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>전표상태 경로 Popup</title>

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
get_cookdata();
var  g_cm1; var  g_cm2;
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
	var strParam = new Array();
	strParam = window.dialogArguments; 
	g_cm = strParam[0];

    //alert(g_cm);

    g_cm1= strParam[1];
    g_cm2= strParam[2];
  
    //alert(g_cm1);
	//alert(g_cm2);
    gcem_TSNBR.text  = g_cm1;
    gcem_TSNBR2.text = g_cm2;
	ln_Query();

}
/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(){

	gcds_data01.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>slipno_loca_s1?v_str1="+g_cm
																	  		+ "&v_str2="+gcem_TSNBR.text
																		    + "&v_str3="+gcem_TSNBR2.text;
	//prompt("",gcds_data01.DataID);
	gcds_data01.Reset();
}

/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){

}

/******************************************************************************************
	Description : 저장
******************************************************************************************/
function ln_Save(){
	
}

/******************************************************************************************
	Description : 삭제
*****************************************************************************************/
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
	Description : FILE 
******************************************************************************/
function ln_File(){

}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){

}
/******************************************************************************
	Description : 창닫기
	parameter   : A - 선택
******************************************************************************/
/*
function ln_Close(p){
	if (p=="C") {
		window.close();
		}
}*/

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	window.status="데이타 조회중입니다.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadcompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";

	if(gcds_data01.countrow <=0) alert("조회된 데이타가 없습니다.");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  OnLoad="ln_Start()">
<table width="782" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <!-- <tr> 
    <td background="../../common/img/com_t_bg.gif">
		<img src="../img/Slipno_loca_popup.gif"></td>
    <td background="../../common/img/com_t_bg.gif">&nbsp;</td>
  </tr> -->
	<tr><td colspan="2" height="1px"></td></tr>
</table>

<table cellpadding="0" cellspacing="0" border="0"> 
	<tr>
	<td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:782px;border:1 solid #708090;">
			<tr>
				<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">전표번호</td>
						<td>&nbsp;
							<comment id="__NSID__"><object  id=gcem_TSNBR classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:20px;position:relative;left:0px;top:3px">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Numeric       value=false>
							<param name=Format        value="#########">
							<param name=PromptChar    value="">
							<param name=maxlength     value="9">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> -&nbsp;
						<comment id="__NSID__"><object  id=gcem_TSNBR2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:20px;position:relative;left:0px;top:3px">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Numeric       value=false>
							<param name=Format        value="######">
							<param name=PromptChar    value="">
							<param name=maxlength     value="6">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> 			
						</td>
						<td width="1px" align=right>&nbsp;</td>
						<td valign="bottom">
							<img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand;position:relative;right:-89px;" onclick="ln_Query()">&nbsp;
						</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr><td height="2px" colspan=2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49   
						style="position:relative;left:8px;width:780px;height:300px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_data01">
						<PARAM NAME="IndWidth"		VALUE="0">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<param name="Editable"    value="false">
						<PARAM NAME="Format"			VALUE=" 
					  <C> Name='순서'			  ID=SEQ		   HeadAlign=Center HeadBgColor=#B9D4DC	Width=35		align=CENTER</C> 
						<C> Name='작성일자'		ID=WRDT      HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center Mask='XXXX/XX/XX'</C>
					  <C> Name='결재구분'		ID=ACCSGNEND HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center SumBgColor=#C3D0DB EditStyle=Combo Data='N:결재대기,Y:결재완료,R:결재요청,C:결재취소,B:반송' edit=none </C> 					
						<C> Name='발생지'	    ID=FROMGB    HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center	  EditStyle=Combo Data='01:현업,02:예산,03:회계,04:수정분개,05:전기,06:자금' edit=none </C> 
						<C> Name='목적지'	    ID=TOGB      HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center	  EditStyle=Combo Data='01:현업,02:예산,03:회계,04:수정분개,05:전기,06:자금' edit=none </C> 
						<C> Name='반송사유'	  ID=BIGO      HeadAlign=Center HeadBgColor=#B9D4DC Width=302	  align=left</C> 
						">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:782px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
					</fieldset><!-- mask={decode(ACTDAT,'전기이월','XXXX','XXXX/XX/XX')} -->
					</td>
				</tr>

				<tr><td height="4px"></td></tr>
				<tr>
					<td height="30px;" align="center">
						<!-- <img name="btn_select" border="0" src="../../common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')"> -->
						<!--<img name="btn_close" border="0" src="../../common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">-->
					</td>
				</tr>
			
			</table>
		</td> 
	</tr> 
</table> 
		</td>
	</tr> 
</table>

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>
<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 