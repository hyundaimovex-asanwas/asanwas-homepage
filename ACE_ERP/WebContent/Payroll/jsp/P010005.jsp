<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	급여/조견표관리
+ 프로그램 ID	: p010005.HTML
+ 기 능 정 의	: 조회|등록|저장|삭제|파일
+ 변 경 이 력	: 이순미
+ 수 정 이 력	: 이순미 - 2005.08.02 - 소스 정리
+ 서 블 릿 명	: p010005_s1, p010005_t1
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>조견표관리</title>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

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
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	gcem_APPYM_SEARCH.Text=gs_date2;
	gcem_APPYM.enable	= false;

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	var str1 = fn_trim(gcem_APPYM_SEARCH.Text);			//지급구분
	var str2 =  fn_trim(gcem_FRAMT_SEARCH.Text);		//기준급여

	gcds_pay.DataID ="<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p010005_s1?v_str1="+str1+"&v_str2="+str2; 
	gcds_pay.Reset();

}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){
	gcem_APPYM.enable	= true;

  if(gcds_pay.countRow==0) {
		var THeader =   "APPYM:String(6),"	
				+"FRAMT:Decimal(9),"   
				+"TOAMT:Decimal(9),"   
				+"FAMILY1:Decimal(9),"	
				+"FAMILY2:Decimal(9),"	
				+"FAMILY3:Decimal(9),"	
				+"FAMILY4:Decimal(9),"	
				+"FAMILY5:Decimal(9),"	
				+"FAMILY6:Decimal(9),"	
				+"FAMILY7:Decimal(9),"	
				+"FAMILY8:Decimal(9),"	
				+"FAMILY9:Decimal(9),"	
				+"FAMILY11:Decimal(9),"	
        +"FAMILY23:Decimal(9),"
        +"FAMILY24:Decimal(9),"
        +"FAMILY25:Decimal(9),"
        +"FAMILY26:Decimal(9),"
        +"FAMILY27:Decimal(9),"
        +"FAMILY28:Decimal(9),"
        +"FAMILY29:Decimal(9),"
        +"FAMILY30:Decimal(9),"
				+"FAMILY31:Decimal(9)";	

		gcds_pay.DataID = "";
		gcds_pay.SetDataHeader(THeader);
	}

	gcds_pay.addrow();
	gcem_APPYM.Text=gs_date2;

}

/******************************************************************************
	Description : 파일열기
******************************************************************************/
function ln_FileOpen_1(){
	var str1=gcem_APPYM_SEARCH.Text;
	inp_File_1.Open();

	var str2=fn_trim(inp_File_1.Value);
	var str3=str2.substr(str2.length-3,3).toLowerCase();
	
	if(str2=="") {
		alert("파일을 선택하세요");
	} else if(str3 !="csv") {
	  inp_File_1.Value="";
		alert("CSV확장자 파일을 선택하세요");
	}	else if(str1.length != 6) {
		alert("기준년월을 6자리를 정확히 입력하세요");
	} else {
		ln_File_1();
	}
}

/******************************************************************************
	Description : 데이터 임포트
******************************************************************************/
function ln_File_1(){
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";

	var THeader =   "APPYM:String(6),"	
					+"FRAMT:Decimal(9.0),"   
					+"TOAMT:Decimal(9.0),"   
					+"FAMILY1:Decimal(9.0),"	
					+"FAMILY2:Decimal(9.0),"	
					+"FAMILY3:Decimal(9.0),"	
					+"FAMILY4:Decimal(9.0),"	
					+"FAMILY5:Decimal(9.0),"	
					+"FAMILY6:Decimal(9.0),"	
					+"FAMILY7:Decimal(9.0),"	
					+"FAMILY8:Decimal(9.0),"	
					+"FAMILY9:Decimal(9.0),"	
					+"FAMILY10:Decimal(9.0),"	
					+"FAMILY11:Decimal(9.0),"	
          +"FAMILY23:Decimal(9.0),"
          +"FAMILY24:Decimal(9.0),"
          +"FAMILY25:Decimal(9.0),"
          +"FAMILY26:Decimal(9.0),"
          +"FAMILY27:Decimal(9.0),"
          +"FAMILY28:Decimal(9.0),"
          +"FAMILY29:Decimal(9.0),"
          +"FAMILY30:Decimal(9.0),"
				  +"FAMILY31:Decimal(9.0)";	

	gcds_dump.DataID = inp_File_1.Value;
	gcds_dump.Reset();

	gcds_pay.SyncLoad=true;
	gcds_pay.ClearAll();
	gcgd_create.DataID = "";
	
	gcds_pay.SetDataHeader(THeader);

	var ls_pd = gcem_APPYM_SEARCH.Text;
	
	for (var j=1; j<=gcds_dump.countrow;j++){
		if (fn_trim(gcds_dump.ColumnValue(j,1))==ls_pd){
			gcds_pay.addrow();
			var ls_pos = gcds_pay.rowposition;
			for (var i=1; i<=23; i++) {
			 gcds_txt=fn_trim(gcds_dump.ColumnValue(j,i));
			 gcds_txt=ln_Ltrim(gcds_txt,",");
			 gcds_pay.ColumnValue(ls_pos,i) = gcds_txt;
			}
		}
	}
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	ft_cnt1.innerText = "조회건수 : " + gcds_pay.countrow + " 건";
	if (gcds_pay.countrow <1) alert("검색된 데이터가 없습니다.");

	gcgd_create.DataID = "gcds_pay";
	gcds_pay.SyncLoad=false;
	inp_File_1.Value="";

}

/******************************************************************************
	Description :
******************************************************************************/
function ln_Date(sdate) {
  var ls_yy = sdate.substring(0,4);
  var ls_mm = sdate.substring(5,7);
  var ls_dd = sdate.substring(8,10);

	return ls_yy + ls_mm + ls_dd
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Time(stime) {
  var ls_hh = stime.substring(0,2);
  var ls_mm = stime.substring(3,5);
  var ls_ss = stime.substring(6,8);
	var ls_uu = stime.substring(9,10);

	return ls_hh + ls_mm + ls_ss + ls_uu
}

/******************************************************************************
	Description :
******************************************************************************/
function ln_Ltrim(src,arg) {
	if(src !=undefined) {
	var li_chk = src.length/4+1;
	var ls_val = src;
	for (var i=1; i<=li_chk; i++)	ls_val = ls_val.replace(arg,"");
	return ls_val;
	}
}

/******************************************************************************
	Description :
******************************************************************************/
function ln_sTrim(src,arg) {
	if(src !=undefined) {
	var li_chk = src.length/4+1;
	var ls_val = src;
	for (var i=1; i<=li_chk; i++)	ls_val = ls_val.replace(arg,"");
	return ls_val;
	}
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

	if (!ln_Valchk()) return;
  
	if (gcds_pay.IsUpdated) {	
		if (confirm("입력하신 사항을 등록하시겠습니까?")){
			gctr_pay.KeyValue = "p010005_t1(I:USER=gcds_pay)";
			gctr_pay.Action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p010005_t1";
			gctr_pay.post();
			ln_Query();
		}
	}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete() {
	
	if (confirm("선택한 정보를 삭제하시겠습니까?")){
		gcds_pay.deleterow(gcds_pay.rowposition);
    gctr_pay.action ="<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p010005_t1";
		gctr_pay.post();
		ln_Query();
	}

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
	Description : 입력값 체크
******************************************************************************/
function ln_Valchk(){
/*
	if (fn_trim(txt_empno.value) == "" && fn_trim(txt_empnm.value) == "") {
		alert("정확한 성명을 입력해 주십시오.");
		txt_empno.value = ""
		txt_empnm.value = ""
		txt_empnm.focus();
		return false;
	}

	if (gcem_frdt.value == "") {
		alert("정확한 변동시작년월을 입력해 주십시오.");
		gcem_frdt.focus();
		return false;
	}

	if (gcem_todt.value == "") {
		alert("정확한 변동종료년월을 입력해 주십시오.");
		gcem_todt.focus();
		return false;
	}
*/
	return true;

}



/******************************************************************************
	Description : 공백제거
******************************************************************************/
function ln_Trim(str){
   
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
} 

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcds_pay" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_dump" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_pay classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="p010005_t1(I:USER=gcds_pay)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_pay" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_pay" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language="javascript" for="gcds_pay" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_pay" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_pay.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>

<script language="javascript" for="gcds_paycd22" event="onloadCompleted(row,colid)">
	gcds_paycd22.insertrow(1);
	gcds_paycd22.namevalue(1,"MINORCD") = "";
	gcds_paycd22.namevalue(1,"MINORNM") = "전체";
	gclx_pbdiv1.index = 0;
</script>

<script language="javascript" for="gcds_deptcd" event="onloadCompleted(row,colid)">
	gcds_deptcd.insertrow(1);
	gcds_deptcd.namevalue(1,"DEPTCD") = "";
	gcds_deptcd.namevalue(1,"DEPTNM") = "전체";
	gclx_deptcd.index = 0;
</script>
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_pay" event="OnRowPosChanged(row)">
	if(gcds_pay.rowStatus(row) ==1) {
		gcem_APPYM.enable	= true;
	} else {
		gcem_APPYM.enable	= false;
	}
</script>

</head>

<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/p010008_head.gif"></td>
    <td align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			<img src="../../Common/img/btn/com_b_download.gif"	style="cursor:hand" onclick="ln_FileOpen_1()">
			<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onclick="ln_Delete()">
			<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()">
		  <img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
		  <img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table  cellpadding="1" cellspacing="0" border="0"  style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr>
					<td width="10" style="border:0 solid #708090;border-left-width:0px;" bgcolor="#eeeeee" align=center><nobr>&nbsp;적용년월&nbsp;</nobr></td>
					<td width="10" style="border:0 solid #708090;border-left-width:1px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_APPYM_SEARCH classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:0px;top:2px; width:50px; height:20px;" class="txtbox"	validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment			value=0>
							<param name=Border	      value=True>
							<param name=ClipMode			value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td>
					<td width="20"   style="border:0 solid #708090;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align=center><nobr>&nbsp;기준급여&nbsp;</nobr></td>
					<td width="10" style="border:0 solid #708090;border-right-width:0px;"><nobr>
						<comment id="__NSID__"><object id=gcem_FRAMT_SEARCH classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;TOP:2px;" class="txtbox" >
							<PARAM name="DataID"			value="gcds_pay">								
							<param name=Text					value="">
							<param name=Alignment     value=2>
							<param name=Border        value=true>
							<param name=ClipMode      value=true>
							<param name=Numeric       value=true>
							<param name=IsComma				value=true>
							<param name=PromptChar    value="_">
							<param name=IsComma       value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
					</td>
						<td width="100%" style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=inp_File_1 classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03
							style="position:relative;left:9px;width:0; height:0;" align="absmiddle">
								<param name="Text"		value='찾아보기'>
		            <param name="Enable"	value="True">
							</object></comment><script>__ws__(__NSID__);</script></nobr>
						</td>  
					</tr>
				</table>		
			</td>
		</tr> 
		<tr><td height=3></td></tr>  
		<tr> 
			<td colspan=2> 
				<table width="877" cellpadding="0" cellspacing="0" border="0">
					<tr> 
						<td> 
							<comment id="__NSID__"><OBJECT id=gcgd_create classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:668px;HEIGHT:680px;border:1 solid #777777;display:block;"   viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_pay">
								<PARAM NAME="Editable"		VALUE="false">
								<PARAM NAME="ColSizing"		VALUE="True">
								<PARAM NAME="BorderStyle" VALUE="0">
								<param name="Fillarea"		VALUE="true">
								<PARAM NAME="Format"			VALUE="  
									<F> Name='적용년월'			ID=APPYM		HeadAlign=Center HeadBgColor=#B9D4DC Width=55	MASK='XXXX/XX'	align=CENTER	BgColor='#f5f5f5'</F> 
									<F> Name='급여이상'			ID=FRAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=75 BgColor='#f5f5f5'		align=RIGHT	</F>
									<F> Name='급여미만'			ID=TOAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=75	BgColor='#f5f5f5'	align=RIGHT	</F>

									<C> Name='1인가족'			ID=FAMILY1		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>
									<C> Name='2인가족'			ID=FAMILY2		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>
									<C> Name='3인가족'			ID=FAMILY3		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>
									<C> Name='4인가족'			ID=FAMILY4		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>
									<C> Name='5인가족'			ID=FAMILY5		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>
									<C> Name='6인가족'			ID=FAMILY6		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>

									<C> Name='7인가족'			ID=FAMILY7		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>
									<C> Name='8인가족'			ID=FAMILY8		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>
									<C> Name='9인가족'			ID=FAMILY9		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>
									<C> Name='10인가족'			ID=FAMILY10		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>
									<C> Name='11인가족'			ID=FAMILY11		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>
									<C> Name='3인가족다자녀'			ID=FAMILY23		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>
									<C> Name='4인가족다자녀'			ID=FAMILY24		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>
									<C> Name='5인가족다자녀'			ID=FAMILY25		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>
									<C> Name='6인가족다자녀'			ID=FAMILY26		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>
									<C> Name='7인가족다자녀'			ID=FAMILY27		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>
									<C> Name='8인가족다자녀'			ID=FAMILY28		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>
									<C> Name='9인가족다자녀'			ID=FAMILY29		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>
									<C> Name='10인가족다자녀'			ID=FAMILY30		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>
									<C> Name='11인가족다자녀'			ID=FAMILY31		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>


											">
              </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:670px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
						<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
						</fieldset>
						</td>
						<td width=3></td>
						<td>              
							<table class=itemdisp cellpadding=0 cellspacing=0  border=0 style='width:205px;height:442px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
								<tr>
                  <td style="width:90px;height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox"><nobr>적용년월</nobr></td>
                  <td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>
										<comment id="__NSID__"><object id=gcem_APPYM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:6px;top:2px; width:50px; height:20px;" class=txtbox validFeatures="ignoreStatus=yes" validExp="">
											<param name=Text          value="">
											<param name=Alignment			value=0>
											<param name=Border	      value=True>
											<param name=ClipMode			value=true>
											<param name=Numeric	      value=false>
											<param name=Format	      value="YYYY/MM">
											<param name=MaxLength     value=6>
											<param name=PromptChar	  value="_">
											<param name=IsComma	      value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
                </tr>
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">급여이상</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FRAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH       value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>				
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">급여미만</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_TOAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH       value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>				
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">1인가족</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH       value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>				
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">2인가족</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH     value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>				
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">3인가족</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH       value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>				
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">4인가족</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH     value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>				
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">5인가족</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH     value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>				
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">6인가족</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY6 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH     value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>				
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">7인가족</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY7 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH     value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>				
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">8인가족</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY8 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH     value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>				
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">9인가족</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY9 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH     value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>				
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">10인가족</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY10 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH     value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>				
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">11인가족</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY11 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH     value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>	
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">3인가족다자녀</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY23 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH     value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>	
								<tr>
			
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">4인가족다자녀</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY24 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH     value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>	
								<tr>
				
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">5인가족다자녀</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY25 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH     value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>	
					<tr>
				
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">6인가족다자녀</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY26 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH     value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>
					<tr>
				
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">7인가족다자녀</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY27 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH     value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>
					<tr>
				
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">8인가족다자녀</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY28 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH     value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>
					<tr>
				
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">9인가족다자녀</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY29 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH     value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>
					<tr>
				
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">10인가족다자녀</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY30 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH     value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>
					<tr>
				
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">11인가족다자녀</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
										<comment id="__NSID__"><object id=gcem_FAMILY31 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=MAXLENGTH     value=9>
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
									</td> 
								</tr>
								<tr>
									<td style="height:10px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee">&nbsp;</td>
									<td  Style="height:0px;border:0 solid #708090;border-bottom-width:0px"><nobr>&nbsp;</nobr></td>
								</tr>
							</table>
  					</td>
					</tr>
				</table>
			</td>
		</tr>
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcbn_pay classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_pay>
	<param name=BindInfo  value='
		<C>Col=APPYM			Ctrl=gcem_APPYM				Param=Text</C>
		<C>Col=FRAMT			Ctrl=gcem_FRAMT				Param=Text</C>
		<C>Col=TOAMT			Ctrl=gcem_TOAMT				Param=Text</C>
		<C>Col=FAMILY1		Ctrl=gcem_FAMILY1		 	Param=Text</C>
		<C>Col=FAMILY2		Ctrl=gcem_FAMILY2			Param=Text</C>
		<C>Col=FAMILY3		Ctrl=gcem_FAMILY3		 	Param=Text</C>
		<C>Col=FAMILY4		Ctrl=gcem_FAMILY4			Param=Text</C>
		<C>Col=FAMILY5		Ctrl=gcem_FAMILY5		 	Param=Text</C>
		<C>Col=FAMILY6		Ctrl=gcem_FAMILY6			Param=Text</C>
		<C>Col=FAMILY7		Ctrl=gcem_FAMILY7		 	Param=Text</C>
		<C>Col=FAMILY8		Ctrl=gcem_FAMILY8			Param=Text</C>
		<C>Col=FAMILY9		Ctrl=gcem_FAMILY9		 	Param=Text</C>
		<C>Col=FAMILY10		Ctrl=gcem_FAMILY10		Param=Text</C>
		<C>Col=FAMILY11		Ctrl=gcem_FAMILY11		Param=Text</C>
    <C>Col=FAMILY23		Ctrl=gcem_FAMILY23		 	Param=Text</C>
		<C>Col=FAMILY24		Ctrl=gcem_FAMILY24			Param=Text</C>
		<C>Col=FAMILY25		Ctrl=gcem_FAMILY25		 	Param=Text</C>
		<C>Col=FAMILY26		Ctrl=gcem_FAMILY26			Param=Text</C>
		<C>Col=FAMILY27		Ctrl=gcem_FAMILY27		 	Param=Text</C>
		<C>Col=FAMILY28		Ctrl=gcem_FAMILY28			Param=Text</C>
		<C>Col=FAMILY29		Ctrl=gcem_FAMILY29		 	Param=Text</C>
		<C>Col=FAMILY30		Ctrl=gcem_FAMILY30		Param=Text</C>
		<C>Col=FAMILY31		Ctrl=gcem_FAMILY31		Param=Text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	