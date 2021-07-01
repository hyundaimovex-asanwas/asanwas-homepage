<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-----------------------------------------------------------------------------
+ 시 스 템 명	:	연말정산기초생성
+ 프로그램 ID	: P030001.HTML
+ 기 능 정 의	: 생성,조회
+ 변 경 이 력	: 
+ 서 블 릿 명	:  p030001_s1  -조회
                       p030001_s2  -생성
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>연말정산기초생성</title>

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
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7)

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	gcem_curdt.text = gs_date;	//정산년월
  gcem_yyyy.text=parseInt(gcurdate.substring(0,6));
  //gcem_yyyy.text='20050701' //임시 
}

/******************************************************************************
	Description : 기본조회
******************************************************************************/
function ln_Query(){
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030001_s1?v_str1=" + gcem_curdt.text+"&v_str2="+gcem_yyyy.text; 
//	prompt("gcds_data", gcds_data.DataID);
	gcds_data.Reset(); 

}

/******************************************************************************
	Description : 생성
******************************************************************************/
function ln_Create(){

		gcds_create.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030001_s2?v_str1=" + gcem_curdt.text //정산일자
		                                                                                 +"&v_str2=Y" 
                                                                                         +"&v_str3="+ gcem_yyyy.text
		                                                                                 +"&v_str4=SP_Y500000"; 
	//prompt("gcds_create", gcds_create.DataID);
	gcds_create.Reset(); 
		
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

</script>


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_create classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 생성 DS -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
	ft_cnt1.innerText="데이타 조회중입니다.";
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data event="OnLoadError()">
	  alert("에러가 발생 했습니다.");
	  window.status="조회가 완료 되었습니다.";
    //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
  ft_cnt1.innerText = "조회건수 : " + rowcount + " 건";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	} 
	window.status = " 조회가 완료 되었습니다.";
</script>

<script language="javascript" for="gcds_create" event="OnLoadStarted()">
	//ft_cnt1.innerText="데이타 생성중입니다.";
	window.status=" 연말정산 기초 생성중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_create" event="onloadcompleted(row,colid)">

	window.status="  연말정산 기초 생성을 완료 했습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	if(gcds_create.countrow <=0)
		alert("리턴값이 없습니다.");
	else {
		if(gcds_create.NameValue(1,"RETCOD") =="Y")
		alert( "계산이 정상적으로 구동 되었으니\n조회 버튼을 사용하여 진행상태를 조회하시기 바랍니다.");
		else
		alert( "계산이 정상적으로 구동 되지 않았습니다.");
		}
	window.status="";
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
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/p030001_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"><nobr>	    
			<img src="../../Common/img/btn/com_b_create.gif" style="cursor:hand" onclick="ln_Create()">
			<img src="../../Common/img/btn/com_b_query.gif"  style="cursor:hand" onclick="ln_Query()" >
			</nobr>&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			
			<table cellpadding="0" cellspacing="0" border="0" style='width:877px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="100px" class="tab12" bgcolor="#eeeeee">&nbsp;귀속년월&nbsp;</td>
					<td style="width:110px; height:30px;border:0 solid #708090;border-right-width:1px;padding-top:0px;"><nobr><comment id="__NSID__"><object id=gcem_yyyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:9px;top:1px; width:40px; height:20px; font-family:굴림; font-size:9pt;z-index:2; ">
							<param name=Text          value="">
							<param name=Alignment			value=0>
							<param name=Border	      value=True>
							<param name=ClipMode	    value=true>
							<param name=Numeric				value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=8>
							<param name=PromptChar		value="_">
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td width="100px" class="tab12" bgcolor="#eeeeee">&nbsp;정산일자&nbsp;</td>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:3px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_curdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " >
							<param name=Text          value="">
							<param name=Alignment			value=0>
							<param name=Border	      value=True>
							<param name=ClipMode	    value=true>
							<param name=Numeric				value=false>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=MaxLength     value=8>
							<param name=PromptChar		value="_">
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_curdt', 'Text')"   style="position:relative;width:20px;left:5px;cursor:hand;">
							</nobr>
					</td>
						<td width="580px"  bgcolor="#FFFFFF">&nbsp;</td>
						<td width="500px" style="height:30px;border:0 solid #708090;">&nbsp;</td>
					</tr>
				</table>
		</td>
  </tr>
  <tr><td colspan="2" height=3></td></tr>
  <tr> 
    <td colspan="2"> 
			<comment id="__NSID__"><OBJECT id=gcgd_data classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="WIDTH:875px;HEIGHT:423px;border:1 solid #777777" viewastext>
				<PARAM NAME="DataID"			VALUE="gcds_data">
				<PARAM NAME="Editable"		VALUE="FALSE">
				<PARAM NAME="ColSizing"		VALUE="True">
				<PARAM NAME="BorderStyle" VALUE="0">
				<param name="Fillarea"		VALUE="true">
				<PARAM NAME="Format"			VALUE="
					<C> Name='정산년월'		ID=APPDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=center  Mask='XXXX/XX' </C>
					<C> Name='정산구분'		ID=PAYDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center </C>
					<C> Name='급여항목'		ID=PAYCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center</C>
					<C> Name='시작일'			ID=FRDT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=70	 align=center  Mask='XXXX/XX/XX'</C> 
					<C> Name='시작시간'		ID=FRTM  		HeadAlign=Center HeadBgColor=#B9D4DC Width=70	 align=center Mask='XX:XX:XX' </C> 
					<C> Name='종료일'			ID=TODT			HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=center  Mask='XXXX/XX/XX'</C>
					<C> Name='종료시간'		ID=TOTM			HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=center  Mask='XX:XX:XX' </C>
					<C> Name='상태'				ID=WRKSTS		HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=center  Value={Decode(WRKSTS,1,'진행중',2,'완료',E,'에러')} </C>
					<C> Name='비고'				ID=MEMO			HeadAlign=Center HeadBgColor=#B9D4DC Width=280 align=left</C>
				">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<fieldset style="width:877px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
				<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
			</fieldset>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden;position:absolute;left:280px;top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	



