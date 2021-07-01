<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:  자금관리 - 투자자산별현황,만기일별현황
+ 프로그램 ID	:  A700012.html
+ 기 능 정 의	:  출력,조회 화면이다.
+ 작   성  자 :
+ 변 경 이 력 :  이순미
+ 서 블 릿 명	:	 a700012_s1
------------------------------------------------------------------------------>

<html>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>투자자산현황</title>

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

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_date3 = gcurdate.substring(0,4);
var gs_date4 = gcurdate.substring(5,7);
var gs_fdcode = gfdcode;
var cuserid		= gusrid;	
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();
	ln_DispChk(0);
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(s){
	if(s=="01") {
		var str1  = gclx_sfdcode1.BindColVal;				//지점코드							
		var str2  = txt_atcodenm_fr.value;					//계정명     
		var str3  = txt_atcode_fr.value;						//계정코드   
		var str4  = gclx_sstdiv1.BindColVal;				//처리구분   
		var str5  = fn_trim(gcem_svendnm1.text);		//발행처명     
		var str6  = fn_trim(gcem_svendcd1.text);		//발행처코드   
		var str7  = fn_trim(gcem_sgetdatefr1.text);	//발행일자fr 
		var str8  = fn_trim(gcem_sgetdateto2.text);	//발행일자to 
		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070012_s1"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7+"&v_str8="+str8;
		gcds_data1.Reset();
	}else if(s=="02") {
		var str1  = gclx_sfdcode2.BindColVal;				//지점코드							
		var str2  = txt_atcodenm_fr2.value;					//계정명     
		var str3  = txt_atcode_fr2.value;						//계정코드   
		var str4  = gclx_sstdiv2.BindColVal;				//처리구분   
		var str5  = fn_trim(gcem_svendnm2.text);		//발행처명     
		var str6  = fn_trim(gcem_svendcd2.text);		//발행처코드   
		var str7  = fn_trim(gcem_sgetdatefr3.text);	//만기일자fr 
		var str8  = fn_trim(gcem_sgetdateto4.text);	//만기일자to 
		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070012_s1"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6
											+ "&v_str9="+str7+"&v_str10="+str8;
		gcds_data2.Reset();
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
	Description : 취소
******************************************************************************/
function ln_Cancel(){

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
		else gcgd_disp01.RunExcel('투자자산별현황');
	}else if(e=="02") {
		if (gcds_data2.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_disp02.RunExcel('만기일별현황');
	}
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){

	/**투자자산별현황*****************************************************/
	gcem_sgetdatefr1.text = gs_date2+"01";	 
	gcem_sgetdateto2.text = gs_date;
	gclx_sstdiv1.index = 1;
	
	//지점코드[검색]
	gcds_sfdcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode1.Reset();

	//자금구분
	gcds_funddiv1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0053"; 
	gcds_funddiv1.Reset();

	/**만기일별현황*****************************************************/
	gcem_sgetdatefr3.text = gs_date2+"01";	 
	gcem_sgetdateto4.text = gs_date;
	gclx_sstdiv2.index = 1;

	//지점코드[검색]
	gcds_sfdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode2.Reset();
}

/***********************************************************************************************
	Description : 계정코드 
	parameter   : p1 - 구분  p2-구분2, p3-자금구분값 obj
**********************************************************************************************/
function ln_Popup3(p1,p2,p3,obj1,obj2){ 
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

		strURL = "./actcode_fund_popup.jsp";
		arrParam[0]=eval(obj1).value;
		arrParam[1]=eval(obj2).value;
		arrParam[2]="'40'";//p3;
		arrParam[3]="ATUSEYN";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

	if (p1=="01"){//계정과목
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			 if(p2=="fr"){
				txt_atcode_fr.value = arrParam[0];
				txt_atcodenm_fr.value = arrParam[1];
				gstr_fundiv = arrParam[2];
			}
		} else {
			if(p2=="fr") {
			    txt_atcode_fr.value="";
				txt_atcodenm_fr.value="";
				gstr_fundiv = "";
			}
		}
	}else if(p1=="02"){
			if (arrResult != null) {
			arrParam = arrResult.split(";");
			 if(p2=="fr"){
				txt_atcode_fr2.value = arrParam[0];
				txt_atcodenm_fr2.value = arrParam[1];
				gstr_fundiv = arrParam[2];
			}
		} else {
			if(p2=="fr") {
			  txt_atcode_fr2.value="";
				txt_atcodenm_fr2.value="";
				gstr_fundiv = "";
			}
		}	
	}
}
/******************************************************************************
	Description : lost focus 시 
	prameter    : p1 - 01 전표작성/02 내역조회
								p2 - atcode:계정	obj
******************************************************************************/
function ln_Blur(p1,p2,obj1,obj2){
	if(p1=="01"){
		if(p2=="atcode"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 또는 Enter 
				ln_Popup3('01','fr','B',obj1,obj2);
		}
	}else if(p1=="02"){
			if(p2=="atcode"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 또는 Enter 
				ln_Popup3('02','fr','B',obj1,obj2);
		}
  }
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
	if(e=="01"){
		arrParam[1]=gcem_svendnm1.text;
	}else if(e=="02"){
		arrParam[1]=gcem_svendnm2.text;
	}
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

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		if(e=="02") {
			gcem_svendcd2.text = arrParam[0];
			gcem_svendnm2.text = arrParam[1];
		}
	} else {
		if(e=="02") {
			gcem_svendcd2.text = "";
			gcem_svendnm2.text ="";
		}
	}
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

<comment id="__NSID__"><object  id=gcds_funddiv1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_funddiv2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
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
	if (row<1) { 
		alert("검색된 데이터가 없습니다.");
	}
</script>

<script language="javascript" for="gcds_sfdcode1" event="onloadCompleted(row,colid)">
	gcds_sfdcode1.InsertRow(1);
	gcds_sfdcode1.NameValue(1,"FDCODE")="";
	gcds_sfdcode1.NameValue(1,"FDNAME")="";
	if(cuserid=="ACCOUNT"){
		gclx_sfdcode1.index=2;
	}else{
		gclx_sfdcode1.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_sfdcode2" event="onloadCompleted(row,colid)">
	gcds_sfdcode2.InsertRow(1);
	gcds_sfdcode2.NameValue(1,"FDCODE")="";
	gcds_sfdcode2.NameValue(1,"FDNAME")="";
	if(cuserid=="ACCOUNT"){
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
	ln_DispChk((index-1)); /*투자자산별현황*/
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</head>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
 
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/a070012_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2 align=left style="position:relative;left:5px">
      <table width="0" cellpadding="1" cellspacing="0" border="0" style="position:relative;top:4px;left:1px;">
				<tr> 
					<td width="0" align=left><nobr>
					  <comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;">
							<PARAM NAME="BackColor"					VALUE="#cccccc">
   					  <PARAM NAME="titleHeight"				VALUE="20px">
						  <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
						  <PARAM NAME="Format"						VALUE="
								<T>divid=div_1		title=투자자산별현황</T>									
								<T>divid=div_2		title=만기일별현황</T>							 
						  ">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
        </tr>
      </table>
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
		
<!-- 투자자산별현황 ===========================================================================================================-->
<!--<fieldset id=field1 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:7px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>지점구분</nobr></td>
					<td class="tab21" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode1">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>계정과목</nobr></td>
					<td class="tab21" style="width:220px">
						<input id="txt_atcodenm_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:6px;width:115px; height:20px;ime-mode:active;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode_fr', 'txt_atcodenm_fr')">
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정과목을 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px;" align=center onclick="ln_Popup3('01','fr','B','txt_atcode_fr','txt_atcodenm_fr');">
						<input id="txt_atcode_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-2px;width:50px; height:20px;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode_fr','txt_atcodenm_fr')" >
					</td>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>발행일자</nobr></td>
					<td class="tab22" style="width:210px">
						<comment id="__NSID__"><object id=gcem_sgetdatefr1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
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
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_sgetdateto2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</td>
					<td class="tab22" align="right">&nbsp;<nobr>      
						<!-- <img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('01')"> -->
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Excel('01')">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('01')"> 
						</nobr>
					</td>
				</tr>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>발행처</nobr></td>
					<td class="tab23" width="100px" colspan="3"><nobr><comment id="__NSID__">
						<object  id=gcem_svendnm1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:155px;height:20px;position:relative;left:5px;top:3px">		
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Language			value=1>
						</object></comment><script>__ws__(__NSID__);</script>
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:8px;cursor:hand"	 onclick="ln_Popup('01')"><comment id="__NSID__">
						<object id=gcem_svendcd1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:3px;left:12px;width:90px">
							<param name=Text				value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=Format			value="#############">
							<param name=PromptChar	value="_">
							<param name=Enable			value="false">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>처리구분</nobr></td>
					<td width="100px">
						<comment id="__NSID__"><object  id=gclx_sstdiv1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:110px;height:110px;">
							<param name=CBData					value="^전체,0^진행,1^완료">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^110">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
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
							<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:6px" viewastext>
								<PARAM NAME="DataID"        VALUE="gcds_data1">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"      VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"        VALUE="  
									<C> Name='No.'			ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
									<C> Name='발행처'		ID=VEND_NM	HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=left		SumText=''		SumBgColor='#C3D0DB'</C> 
									<C> Name='구분'			ID=FUNDDIV	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=left		SumText='계'	SumBgColor='#C3D0DB' EditStyle='lookup' Data='gcds_funddiv1:CDCODE:CDNAM'</C> 
									<C> Name='증권번호'	ID=REFCODE2	HeadAlign=Center HeadBgColor=#B9D4DC Width=170	align=left		SumText=''		SumBgColor='#C3D0DB'</C> 
									<C> Name='액면가액'	ID=DRAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=right   SumText=@sum	SumBgColor='#C3D0DB' </C>
									<C> Name='발행일자'	ID=STRDATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=85		align=center  SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
						      <C> Name='만기일자'	ID=ENDDATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=85		align=center  SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='이율'			ID=INRATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=right   SumText=@sum	SumBgColor='#C3D0DB'</C>
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:6px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<td>
			</table>			
		</td> 
	</tr> 
</table> 

<!-- 만기일별현황 ===========================================================================================================-->
<!--<fieldset id=field2 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>-->
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0">		
		<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:7px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>지점구분</nobr></td>
					<td class="tab21" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode2">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>계정과목</nobr></td>
					<td class="tab21" style="width:220px">
					<input id="txt_atcodenm_fr2" type="text" class="txtbox"  style= "position:relative;top:0px;left:6px;width:115px; height:20px;ime-mode:active;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode_fr2', 'txt_atcodenm_fr2')">
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정과목을 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px;" align=center onclick="ln_Popup3('02','fr','B','txt_atcode_fr2','txt_atcodenm_fr2');">
						<input id="txt_atcode_fr2" type="text" class="txtbox"  style= "position:relative;top:0px;left:-2px;width:50px; height:20px;" maxlength="36" onkeydown="ln_Blur('02','atcode','txt_atcode_fr2','txt_atcodenm_fr2')" >
					</td>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>만기일자</nobr></td>
					<td class="tab22" style="width:210px">
						<comment id="__NSID__"><object id=gcem_sgetdatefr3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdatefr3', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~
					<comment id="__NSID__"><object id=gcem_sgetdateto4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_sgetdateto4', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</td>
					<td class="tab22" align="right">&nbsp;<nobr>      
						<!-- <img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('02')"> -->
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Excel('02')">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('02')"> 
						</nobr>
					</td>
				</tr>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>발행처</nobr></td>
					<td class="tab23" width="100px" colspan="3"><nobr><comment id="__NSID__">
						<object  id=gcem_svendnm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:155px;height:20px;position:relative;left:5px;top:3px">		
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Language			value=1>
						</object></comment><script>__ws__(__NSID__);</script>
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:8px;cursor:hand"	 onclick="ln_Popup('02')"><comment id="__NSID__">
						<object id=gcem_svendcd2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:3px;left:12px;width:90px">
							<param name=Text				value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=Format			value="#############">
							<param name=PromptChar	value="_">
							<param name=Enable			value="false">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>처리구분</nobr></td>
					<td width="100px">
						<comment id="__NSID__"><object  id=gclx_sstdiv2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:110px;height:110px;">
							<param name=CBData					value="^전체,0^진행,1^완료">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^110">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
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
							<OBJECT id=gcgd_disp02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:6px" viewastext>
								<PARAM NAME="DataID"        VALUE="gcds_data2">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"      VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"        VALUE="  
									<C> Name='No.'			ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
									<C> Name='만기일자'	ID=ENDDATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=85		align=center  SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='발행처'		ID=VEND_NM	HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=left		SumText=''		SumBgColor='#C3D0DB'</C> 
									<C> Name='구분'			ID=FUNDDIV	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=left		SumText=''		SumBgColor='#C3D0DB' EditStyle='lookup' Data='gcds_funddiv1:CDCODE:CDNAM'</C> 
									<C> Name='증권번호'	ID=REFCODE2	HeadAlign=Center HeadBgColor=#B9D4DC Width=170	align=left   	SumText='계'	SumBgColor='#C3D0DB'</C> 
									<C> Name='액면가액'	ID=DRAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=right   SumText=@sum	SumBgColor='#C3D0DB' </C>
									<C> Name='발행일자'	ID=STRDATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=85		align=center  SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='이율'			ID=INRATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=right   SumText=@sum	SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:6px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt02" style="position:relative;top:4px;"></font>
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