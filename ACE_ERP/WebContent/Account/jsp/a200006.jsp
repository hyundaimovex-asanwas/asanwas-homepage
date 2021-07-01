<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:  어음관리 - 만기일별상계현황
+ 프로그램 ID	:  A200006.html
+ 기 능 정 의	:  만기일별상계현황 조회 및 출력 화면이다.
+ 작   성  자 :  이 순 미
+ 서 블 릿 명	:	 a200006_s1
-------------------------------------------------------------------------------->

<html>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>만기일별상계현황</title>


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

var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_date3  = gcurdate.substring(0,4);
var gs_date4  = gcurdate.substring(5,7);
var gs_fdcode = gfdcode;
var gs_usrid  = gusrid;
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	ln_Before();
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(s){
	if(s=="01") {
		var str1  = gclx_sfdcode1.BindColVal;				//지점코드   
		var str2  = fn_trim(gcem_sgetdatefr1.text);	//만기일자fr
		var str3  = fn_trim(gcem_sgetdateto2.text);	//만기일자to 
		var str4  = gcem_svendnm1.text;							//거래처명   
		var str5  = gcem_svendcd1.text;							//거래처코드   

		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a200006_s1"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str4+"&v_str5="+str5;
		gcds_data1.Reset();
	}
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
function ln_Print(e){
	alert("준비중입니다.");
  /*if(e=="01") {
		if(gcds_print1.countrow<1) {
			alert("출력할 정보가 없습니다.");
		}else{
			gcrp_print1.preview();
		}
	}*/
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(e){
  if(e=="01") {
		if (gcds_data1.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_disp01.RunExcel('만기일별상계현황');
	}
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
	gcem_sgetdatefr1.text = gs_date2+"01";	//[검색]만기from
	gcem_sgetdateto2.text = gs_date;				//[검색]만기to

	//지점코드[검색]
	gcds_sfdcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode1.Reset();
}

/***********************************************************************************************
	Description : 거래처 찾기
	parameter   : arrParam[0] - 거래처코드, arrParam[1] - 거래처명
**********************************************************************************************/
function ln_Popup(e){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./gczm_vender_popup.jsp";
	arrParam[0]="0020";
	arrParam[1]=gcem_svendnm1.text;
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		if(e=="01") {
			gcem_svendcd1.text = arrParam[0];
			gcem_svendnm1.text = arrParam[1];
		}
	} else {
		if(e=="01") {
			gcem_svendcd1.text = "";
			gcem_svendnm1.text ="";
		}
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<OBJECT id=gctr_data1 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</OBJECT>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
	}
</script>

<script language="javascript" for="gcds_sfdcode1" event="onloadCompleted(row,colid)">
	gcds_sfdcode1.InsertRow(1);
	gcds_sfdcode1.NameValue(1,"FDCODE")="";
	gcds_sfdcode1.NameValue(1,"FDNAME")="";
	gclx_sfdcode1.index=2;
</script>

<script language="javascript" for="gcds_sfunddiv" event="onloadCompleted(row,colid)">
	gclx_sfunddiv.index=4;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data1" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_data1" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

</head>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/a200006_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
		
<table cellpadding="0" cellspacing="0" border="0">
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:0px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>지점구분</nobr></td>
					<td class="tab23" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode1">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>만기일자</nobr></td>
					<td width="210px"><nobr><comment id="__NSID__">
						<object id=gcem_sgetdatefr1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdatefr1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~
						<comment id="__NSID__"><object id=gcem_sgetdateto2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
								style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_sgetdateto2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;"></nobr>
					</td>
					<td class="tab12"  style="position:relative;left:0px;width:70px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:0px;border-left-width:1px;border-right-width:1px;text-align:center;" bgcolor="#eeeeee"><nobr>거&nbsp;래&nbsp;처</nobr></td>
					<td style="width:250px"><nobr><comment id="__NSID__">
						<object  id=gcem_svendnm1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:5px;top:0px" onkeyDown="if(event.keyCode==13) ln_Query('01')">		
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Language			value=1>
						</object></comment><script>__ws__(__NSID__);</script>
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:0px;left:8px;cursor:hand"	 onclick="ln_Popup('01')"><comment id="__NSID__">
						<object id=gcem_svendcd1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:12px;width:90px">
							<param name=Text				value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=Format			value="#############">
							<param name=PromptChar	value="_">
							<param name=Enable			value="false">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td align="right">&nbsp;<nobr>      
						<!-- <img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('01')"> -->
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Excel('01')">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('01')"> 
						</nobr>
					</td>
				</tr>
			</table>
					</td>
				</tr>
				<tr>
					<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr> 
						<td style="width:460" ALIGN=LEFT VALIGN=TOP><comment id="__NSID__">
							<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:-1px" viewastext>
								<PARAM NAME="DataID"        VALUE="gcds_data1">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"      VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"        VALUE="  
									<C> Name='No.'					ID={CURROW}		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
									<C> Name='만기일자'			ID=ENDDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='거래처'				ID=VEND_NM		HeadAlign=Center HeadBgColor=#B9D4DC Width=210	align=left		SumText='계'	SumBgColor='#C3D0DB'</C>
									<G> Name='받을어음'     HeadAlign=Center HeadBgColor=#B9D4DC
										<C> Name='어음번호'		ID=REFCODE50	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
										<C> Name='금액'				ID=DRAMT50		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right		SumText=@sum	SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									</G>
									<G> Name='지급어음'     HeadAlign=Center HeadBgColor=#B9D4DC
										<C> Name='어음번호'		ID=REFCODE60	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
										<C> Name='금액'				ID=DRAMT60		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right		SumText=@sum	SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									</G>
									<C> Name='차액'					ID={DRAMT50-DRAMT60}	HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=right	SumText=@sum	SumBgColor='#C3D0DB'</C>
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:-1px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<td>
			</table>			
		</td> 
	</tr> 
</table> 
			 
    <td>
	</tr>
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data1>
	<param name=BindInfo  value='  
		<C>Col=REFCODE2		Ctrl=gcem_refcode21		Param=text</C>
		<C>Col=STRDATE		Ctrl=gcem_strdate			Param=text</C>
		<C>Col=ENDDATE		Ctrl=gcem_enddate			Param=text</C>
		<C>Col=BANNAM			Ctrl=gcem_bancodnm1		Param=text</C>
		<C>Col=BANCOD			Ctrl=gcem_bancod1			Param=text</C>
		<C>Col=VENDNM			Ctrl=gcem_vendnm1			Param=BindColVal</C>
		<C>Col=VEND_CD		Ctrl=gcem_vendcd1			Param=text</C>
		<C>Col=DRAMT			Ctrl=gcem_dramt				Param=text</C>
		<C>Col=DRFAMT			Ctrl=gcem_drfamt			Param=text</C>
		<C>Col=CRAMT			Ctrl=gcem_cramt				Param=text</C>
		<C>Col=CRFAMT			Ctrl=gcem_crfamt			Param=text</C>
		<C>Col=JANAMT1		Ctrl=gcem_janamt1			Param=text</C>
		<C>Col=JANAMT2		Ctrl=gcem_janamt2			Param=text</C>
		<C>Col=INRATE			Ctrl=gcem_inrate			Param=text</C>
		<C>Col=CURDIV			Ctrl=gcem_curdiv			Param=text</C>
		<C>Col=OUTRATE		Ctrl=gcem_outrate			Param=text</C>
		<C>Col=EXRATE			Ctrl=gcem_exrate			Param=text</C>
		<C>Col=REMARK			Ctrl=gcem_remark			Param=text</C>
		<C>Col=FSDAT			Ctrl=gcem_fsdat				Param=text</C>
		<C>Col=FSNBR			Ctrl=gcem_fsnbr				Param=text</C>
		<C>Col=ACTDAT			Ctrl=gcem_actdat			Param=text</C>
		<C>Col=FSDAT1			Ctrl=gcem_fsdat1			Param=text</C>
		<C>Col=FSNBR1			Ctrl=gcem_fsnbr1			Param=text</C>
		<C>Col=ACTDAT1		Ctrl=gcem_actdat1			Param=text</C>
		<C>Col=STATDIV		Ctrl=gclx_statdiv1		Param=BindColVal</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"				value="A4">
	<param name="LandScape"				value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="SuppressColumns"	value="1:pageskip,ATCODE;">
	<param name="Format"					value="
	">
</object></comment><script>__ws__(__NSID__);</script> 


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 