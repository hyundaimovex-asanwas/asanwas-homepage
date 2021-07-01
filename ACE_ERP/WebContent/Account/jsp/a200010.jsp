<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:  어음관리 - 상계누계현황
+ 프로그램 ID	:  A200010.html
+ 기 능 정 의	:  상계누계현황 조회 및 출력 화면이다.
+ 작   성  자 :  이 순 미
+ 서 블 릿 명	:	 a200001_s1
------------------------------------------------------------------------------>

<html>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>상계누계현황</title>

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
var gs_date4  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_fdcode = gfdcode;
var gs_usrid  = gusrid;
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	ln_DispChk(0);
	ln_Before();
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(s){
	if(s=="01") {
		var str1  = gclx_sfdcode1.BindColVal;				//지점코드   
		var str2  = fn_trim(gcem_sgetdatefr1.text);	//기준년월
		//gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a200001_s1?v_str1="+str1+"&v_str2="+str2;
		//gcds_data1.Reset();
	}else if(s=="02") {
		var str1  = gclx_sfdcode2.BindColVal;				//지점코드   
		var str2  = fn_trim(gcem_sgetdatefr1.text);	//기준년월fr
		var str3  = fn_trim(gcem_sgetdateto2.text);	//기준년월to 
		//gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a200001_s2"
		//									+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3;
		//gcds_data2.Reset();
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
function ln_Delete(e){
	
}

/******************************************************************************
	Description : 월마감 - 기준년월 from=>to
******************************************************************************/
function ln_MonthChk(){
	var p_frdt = gcem_sgetdatefr1.text;
	var u_frdt = 0;
	if (parseInt(p_frdt.substring(4,6))<=9&&parseInt(p_frdt.substring(4,6))>=1){
		u_urdt = parseInt(p_frdt.substring(5,6))+1;
		gcem_sgetdateto2.text = p_frdt.substring(0,4)+"0"+String(u_urdt);
	}else{
		u_urdt = parseInt(p_frdt.substring(4,6))+1; 
		gcem_sgetdateto2.text = p_frdt.substring(0,4)+String(u_urdt);
	}
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(e){
	alert("준비중입니다.");
	/*
  if(e=="01") {
		if(gcds_print1.countrow<1) {
			alert("출력할 정보가 없습니다.");
		}else{
			gcrp_print1.preview();
		}
	}else if(e=="02") {
		if(gcds_print2.countrow<1) {
			alert("출력할 정보가 없습니다.");
		}else{
			gcrp_print2.preview();
		}
	}
	*/
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(e){
  if(e=="01") {
		if (gcds_data1.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_disp01.RunExcel('누계현황');
	}else if(e=="02") {
		if (gcds_data2.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_disp02.RunExcel('월마감');
	}
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
	/*누계현황 항목 조회**************************************************/
	gcem_sgetdate.text = gs_date2;				//[입력]기준일자
	
	//지점코드[검색]
	gcds_sfdcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode1.Reset();

	/*월마감 항목 조회**************************************************/
	gcem_sgetdatefr1.text = gs_date4;	//[검색]기준년월fr
	//gcem_sgetdateto2.text = gs_date4;	//[검색]기준년월to

	//지점코드[검색]
	gcds_sfdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode2.Reset();

	ln_MonthChk();
}

/******************************************************************************
	Description : 탭구분
	prameter    : 0-일별코드, 1-월별항목
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp1","div_disp2");
	for(var i=0;i<=1;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
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

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_sfdcode1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt02.innerText = "조회건수 : " + row + " 건";
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
	if(gs_usrid=="ACCOUNT"){
		gclx_sfdcode1.index=2;
	}else{
		gclx_sfdcode1.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_sfdcode2" event="onloadCompleted(row,colid)">
	gcds_sfdcode2.InsertRow(1);
	gcds_sfdcode2.NameValue(1,"FDCODE")="";
	gcds_sfdcode2.NameValue(1,"FDNAME")="";
	gclx_sfdcode2.index=2;
	if(gs_usrid=="ACCOUNT"){
		gclx_sfdcode2.index=2;
	}else{
		gclx_sfdcode2.bindcolval=gs_fdcode;
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1)); /*누계현황*/
</script>

<script language=JavaScript for=gcem_sgetdatefr1 event=OnKeyUp(kcode,scode)>
	ln_MonthChk();
</script>

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
    <td><img src="../img/a200010_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2 align=left style="position:relative;left:5px">
      <table width="0" cellpadding="1" cellspacing="0" border="0">
				<tr> 
					<td width="0" align=left><nobr><comment id="__NSID__">
					  <object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;">
							<PARAM NAME="BackColor"					VALUE="#cccccc">
   					  <PARAM NAME="titleHeight"				VALUE="20px">
						  <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
						  <PARAM NAME="Format"						VALUE="
								<T>divid=div_1		title=누계현황</T>									
							  <T>divid=div_2		title=월마감</T>							
						  ">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
        </tr>
      </table>
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
		
<!-- 누계현황 ===========================================================================================================-->
<fieldset id=field1 style="position:absolute;top:70px;left:4px;height:470px;width:880px;bacground-color:#708090"></fieldset>

<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px">
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
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>기준년월</nobr></td>
					<td style="width:210px"><comment id="__NSID__">
						<object id=gcem_sgetdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px; width:55px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script>
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
							<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
								<PARAM NAME="DataID"        VALUE="gcds_data1">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"      VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"        VALUE="  
									<C> Name='No.'			ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
		              <C> Name='거래처'		ID=VEND_NM	HeadAlign=Center HeadBgColor=#B9D4DC Width=360	align=left		SumText='계'	SumBgColor='#C3D0DB'</C>
									<C> Name='전월이월'	ID=PREAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
									<C> Name='당월증가'	ID=CURAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
									<C> Name='누계'			ID=REAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<td>
			</table>			
		</td> 
	</tr> 
</table> 
			 

<!-- 월마감 ===========================================================================================================-->
<fieldset id=field2 style="position:absolute;top:70px;left:4px;height:470px;width:880px;bacground-color:#708090"></fieldset>
	<table id="div_disp2" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>지점구분</nobr></td>
					<td class="tab23" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode2">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>기준년월</nobr></td>
					<td style="width:210px"><comment id="__NSID__">
						<object id=gcem_sgetdatefr1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script>
					 &nbsp;==>
					<comment id="__NSID__"><object id=gcem_sgetdateto2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:-3px;top:2px; width:50px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="false">
					</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td align="right">&nbsp;<nobr>      
						<img src="../../Common/img/btn/com_b_finish.gif"	style="position:relative;top:2px;left:-2px;cursor:hand" onclick="ln_Finish()"> 
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
							<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
								<PARAM NAME="DataID"        VALUE="gcds_data1">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"      VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"        VALUE="  
									<C> Name='No.'			ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
		              <C> Name='거래처'		ID=REMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=360	align=center	SumText='계'	SumBgColor='#C3D0DB'</C>
									<C> Name='전월이월'	ID=LOSDATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=center  SumText=@sum	SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='당월증가'	ID=LOSDATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=center  SumText=@sum	SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='누계'			ID=REMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=center	SumText=@sum	SumBgColor='#C3D0DB'</C>
						
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<td>
			</table>			
		</td> 
	</tr> 
</table> 

<!--  ===========================================================================================================-->
<fieldset id=field3 style="position:absolute;top:70px;left:4px;height:470px;width:880px;bacground-color:#708090"></fieldset>
<table id="div_disp3" cellpadding="0" cellspacing="0" border="0" style="display:none">
	

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
		<C>Col=BANNAM			Ctrl=gcem_bancodnm1		Param=text</C>
		<C>Col=BANCOD			Ctrl=gcem_bancod1			Param=text</C>
		<C>Col=GETDATE		Ctrl=gcem_getdate1		Param=text</C>
		<C>Col=GETMEN			Ctrl=gcem_getmen1			Param=text</C>
		<C>Col=STDIV			Ctrl=gclx_stdiv1			Param=BindColVal</C>
		<C>Col=STDATE			Ctrl=gcem_stdate1			Param=text</C>
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