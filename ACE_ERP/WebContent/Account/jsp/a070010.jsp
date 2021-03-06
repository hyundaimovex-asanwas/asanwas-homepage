<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  자금관리 - 예적금현황
+ 프로그램 ID	:  A070010.html
+ 기 능 정 의	:  예적금 현황을 조회, 출력
+ 작   성  자   :   
+ 서 블 릿 명	:	
------------------------------------------------------------------------------>
<html>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>예적금현황</title>


<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">

</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_date3 = gcurdate.substring(0,4);
var gs_date4 = gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();
}

/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(){
	var str1 = gclx_sfdcode.bindcolval;	//지점
	var str2 = txt_atcode_fr.value;     //계정과목
	var str3 = gcem_staxdatfr.text;			//일자from
	var str4 = gcem_staxdatto.text;			//일자to
	var str5 = gcem_MORTBANK.value;			//은행
	var str6 = gclx_sstdiv.bindcolval;				//구분
	gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070010_s1?v_str1="+str1+"&v_str2="+str2
										+ "&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6;
	gcds_data1.Reset();
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){
	alert("준비중입니다.");
	/*
	if(gcds_print.countrow<1) {
		alert("출력할 정보가 없습니다.");
	}
	*/
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
	gcem_staxdatfr.text = gs_date2 + "01";
	gcem_staxdatto.text = gs_date;
	gclx_sstdiv.index		= 0;

	//지점코드[검색]
	gcds_sfdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset();

	gcds_com.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0053";
  gcds_com.Reset();
}

/******************************************************************************
	Description : 은행코드  팝업
******************************************************************************/
function ln_Popup1(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./banklist1_popup.jsp";
	strPos = "dialogWidth:318px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";"); 
		gcem_MORTBANK.value = ln_Trim(arrParam[0]);
		txt_MORTBANK.value = ln_Trim(arrParam[1]); 
	} else {
		gcem_MORTBANK.value = "";
		txt_MORTBANK.value = "";
	}
}
/******************************************************************************
	Description : 은행코드 유무검색	        
******************************************************************************/
function ln_Bank_Find(obj,e){
	var  vend = eval(obj).value;
  if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 또는 Enter 
	gcds_bank.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_s01?v_str1="+eval(obj).value+"&v_str2="; 
	gcds_bank.Reset();  

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;	       

	if(e=='01'){
		if (gcds_bank.countrow>0){
			strURL = "./ast_banklist_popup.jsp";
			arrParam[0] = ln_Trim(vend);
			strPos = "dialogWidth:318px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);
		if (arrResult != null) 
			arrParam = arrResult.split(";");
		  gcem_MORTBANK.value = arrParam[0];		
			txt_MORTBANK.value = arrParam[1];        
		}else {	
			alert("존재하지 않는 코드입니다");  gcem_MORTBANK.value="";		txt_MORTBANK.value = "";
		}
	}		
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

	if (p1=="01"){//계정과목
    
		strURL = "./actcode_fund_popup.jsp";
		arrParam[0]=eval(obj1).value;
		arrParam[1]=eval(obj2).value;
		arrParam[2]="'10'"//p3;
		arrParam[3]="ATUSEYN";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	

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
	}
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Trim(str){
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
} 

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(e){
	if(e=="01"){
		if (gcds_data1.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_disp01.RunExcel('예적금현황');
	}
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"		VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_com classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><OBJECT id="gcds_bank" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

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
	ft_cnt01.innerText = "조회건수 : " + row + " 건"; 
	// document.all.LowerFrame.style.visibility="hidden";
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
	}
</script>

<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	gcds_sfdcode.InsertRow(1);
	gcds_sfdcode.NameValue(1,"FDCODE")="";
	gcds_sfdcode.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode.index=2;
	}else{
		gclx_sfdcode.bindcolval=gs_fdcode;
	}
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
 <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a070010_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
	<tr><td colspan="2" height="1px"></td></tr>
</table>

<table  cellpadding="0" cellspacing="0" border="0">		
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:7px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>지점구분</nobr></td>
					<td class="tab21" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode">
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
						<input id="txt_atcode_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-2px;width:50px; height:20px;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode_fr','txt_atcodenm_fr')" disabled>
					</td>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>계약일자</nobr></td>
					<td class="tab22" style="width:210px">
						<comment id="__NSID__"><object id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~
					<comment id="__NSID__"><object id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_staxdatto', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</td>
					<td class="tab22" align="right">&nbsp;<nobr>      
						<!-- <img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('02')"> -->
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Excel('01')">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query()"> 
						</nobr>
					</td>
				</tr>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>은&nbsp;&nbsp;&nbsp;&nbsp;행</nobr></td>
					<td class="tab23" width="250px" colspan="3">
						<input type=text   id=gcem_MORTBANK style= "position:relative;top:0px;left:5px;width:40px; height:20px;"  class="txtbox"  maxlength=7; onkeydown="ln_Bank_Find('gcem_MORTBANK','01');">
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="은행명을 검색합니다" 
						style="cursor:hand;position:relative;left:2px;top:2px" onclick="ln_Popup1();">	
						<input id="txt_MORTBANK" type="text" class="txtbox"  style= "position:relative;top:0px;width:150px;left:0px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>처리구분</nobr></td>
					<td width="100px">
						<comment id="__NSID__"><object  id=gclx_sstdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:110px;height:110px;">
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
						<td style="width:867" ALIGN=LEFT VALIGN=TOP><comment id="__NSID__">
							<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:6px" viewastext>
								<PARAM NAME="DataID"        VALUE="gcds_data1">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"      VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"        VALUE="  
									<C> Name='No.'			ID={CURROW}		HeadAlign=Center	HeadBgColor=#B9D4DC		Width=40	align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
									<C> Name='은행'			ID=BANNAM		HeadAlign=Center	HeadBgColor=#B9D4DC		Width=110	align=left		SumText=''		SumBgColor='#C3D0DB'</C> 
									<C> Name='구분'			ID=FUNDDIV		HeadAlign=Center	HeadBgColor=#B9D4DC		Width=60	align=left		SumText=''		SumBgColor='#C3D0DB' EditStyle='lookup' Data='gcds_com:CDCODE:CDNAM'</C>
									<C> Name='계좌번호'	    ID=REFCODE2		HeadAlign=Center	HeadBgColor=#B9D4DC		Width=150	align=left		SumText='계'	SumBgColor='#C3D0DB'</C>
									<G>Name='금액'	                        HeadAlign=Center	HeadBgColor=#B9D4DC
									<C> Name='원화'			ID=AMT			HeadAlign=Center	HeadBgColor=#B9D4DC		Width=70	align=right		SumText=@sum	SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='외화'			ID=EAMT			HeadAlign=Center	HeadBgColor=#B9D4DC		Width=70	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
									</G>
									<C> Name='이율'			ID=INRATE		HeadAlign=Center	HeadBgColor=#B9D4DC		Width=70	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
									<C> Name='통화'			ID=CURDIV		HeadAlign=Center	HeadBgColor=#B9D4DC		Width=70	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
									<C> Name='환율'			ID=EXRATE		HeadAlign=Center	HeadBgColor=#B9D4DC		Width=70	align=right		SumText=@sum	SumBgColor='#C3D0DB' </C>
									<C> Name='계약일자'	    ID=STRDATE	    HeadAlign=Center	HeadBgColor=#B9D4DC		Width=70	align=center	SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='만기일자'	    ID=ENDDATE	    HeadAlign=Center	HeadBgColor=#B9D4DC		Width=70	align=center	SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
							<fieldset style="position:relative;left:6px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
							</fieldset>
						</td>
						<td>
		</td>
	</tr> 
</table>

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"				value="A4">
	<param name="fixpapersize"		value="true">
	<param name="LandScape"				value="true">
	<param name="printMargine"		value="false">
	<param name="SuppressColumns"	value="1:pageskip,ATCODE;">
	<param name="Format"					value="">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 