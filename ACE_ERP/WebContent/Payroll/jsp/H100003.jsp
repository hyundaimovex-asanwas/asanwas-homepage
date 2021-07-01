<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	계약직/호봉표관리
+ 프로그램 ID	: H100003
+ 기 능 정 의	: 조회|등록|저장|삭제
+ 변 경 이 력	: 이순미
+ 서 블 릿 명	: h100003_s1, h100003_t1
------------------------------------------------------------------------------>
 
<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>호봉표관리</title>
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


 gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7);

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	ln_Luxequery();								//공통코드

	gcem_stdym.enable = false;		//기준년월
	gclx_paygrd.enable = false;		//직급
	gcem_stdym1.Text=gs_date;

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	var str1 = gcem_stdym1.text;

	gcds_pay.DataID ="/servlet/Contract.h100003_s1?v_str1="+fn_trim(str1);
	gcds_pay.Reset();

	gcem_stdym.enable = false;		//기준년월
	gclx_paygrd.enable = false;		//직급

//prompt("",gcds_pay.DataID );	

}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

	//if (gcds_pay.Countrow<=0) { return false; }

	gcds_pay.addrow();

	gcem_stdym.enable = true;			//기준년월
	gclx_paygrd.enable = true;		//직급

	gclx_paygrd.index = 0;

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){  

	if (!ln_Valchk()) return;

	if (gcds_pay.IsUpdated) {
		if (confirm("입력하신 사항을 등록하시겠습니까?")){
			gctr_pay.KeyValue = "h100003_t1(I:USER=gcds_pay)";
			gctr_pay.Action = "/servlet/Contract.h100003_t1?v_str1=I";
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
		gctr_pay.action = "/servlet/Contract.h100003_t1";
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
	Description : 파일열기
******************************************************************************/
function ln_File(){

	var str1=gcem_stdym.Text;	//기준년월
	
	gcif_file.Open();

	var str2=fn_trim(gcif_file.Value);										//open file
	var str3=str2.substr(str2.length-3,3).toLowerCase();	//확장자 추출

	if(str2=="") {
		alert("파일을 선택하세요");
	} else if(str3 !="csv")	{
	  gcif_file.Value="";
		alert("CSV확장자 파일을 선택하세요");
	//}	else if(str1.length != 6) {
	//	alert("기준년월을 6자리를 정확히 입력하세요");
	}else{
		ln_File_1();
	}
}

/******************************************************************************
	Description : 데이터 임포트
******************************************************************************/
function ln_File_1(){

	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";		

	var THeader = "STDYM:String(6),"					
							+	"PAYGRD:String(4),"					
							+	"PAYSEQ:String(4),"   			
							+	"TIMAMT:String(9.0),"				
							+	"BASAMT:String(9.0),"   		
							+	"ECTAMT:Decimal(9.0),"			
							+	"MONAMT:Decimal(9.0),"			
							+	"SAGAMT:Decimal(9.0),"			
							+	"YERAMT:Decimal(9.0)";			

	gcds_temp.DataID = gcif_file.Value;
	gcds_temp.Reset();

	gcds_pay.SyncLoad=true;
	gcds_pay.ClearAll();
	gcgd_pay.DataID = "";

	gcds_pay.SetDataHeader(THeader);								//Header Set

	var row = gcds_pay.rowposition;
	var ls_pd = gcem_stdym.Text;

	for(var j=1;j<=gcds_temp.countrow;j++) {
			
		gcds_pay.addrow();

		var ls_pos = gcds_pay.rowposition;

		for (var i=1; i<=9; i++) {
			
			gcds_txt=fn_trim(gcds_temp.ColumnValue(j,i));

			gcds_txt=ln_Ltrim(gcds_txt,",");
			gcds_pay.ColumnValue(ls_pos,i) = gcds_txt;
		
		}
	}

	window.status="조회가 완료 되었습니다."; 
	// document.all.LowerFrame.style.visibility="hidden";

	ft_cnt1.innerText = "조회건수 : " + gcds_pay.countrow + " 건";
	if (gcds_pay.countrow <1) alert("검색된 데이터가 없습니다.");

	gcgd_pay.DataID = "gcds_pay";
	gcds_pay.SyncLoad=false;
	gcif_file.Value="";

}

/******************************************************************************
	Description :
******************************************************************************/
function ln_Ltrim(src,arg) {
	if(src != undefined)
	{
	var li_chk = src.length/4+1;
	var ls_val = src;
	for (var i=1; i<=li_chk; i++)	ls_val = ls_val.replace(arg,"");
	return ls_val;
	}
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

	if (gcds_pay.countrow<1) { 
		alert("다운로드하실 자료가 없습니다."); 
	} else {
		gcgd_pay.RunExcel('호봉표관리');
	}
	
}

/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
function ln_Valchk(){

	if (gcem_stdym.text == "") {
		alert("정확한 기준년월를 입력해 주십시오.");
		gcem_stdym.Focus();
		return false;
	}
	
	return true;

}

/******************************************************************************
	Description : 공통코드 조회
******************************************************************************/
function ln_Luxequery() { 

	//직급코드
	gcds_paycd1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2001"; 
	gcds_paycd1.Reset();

	//구분
	gcds_paycd2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2018"; 
	gcds_paycd2.Reset();

	//구분[검색]
	gcds_paycd3.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2018"; 
	gcds_paycd3.Reset();

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gcds_pay" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+PAYGRD">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_pay2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_pay3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_paycd1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE" ><!--직급-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_paycd2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE" ><!--구분-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_paycd3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE" ><!--구분[검색]-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_temp" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_pay classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h100003_t1(I:USER=gcds_pay)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_pay" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_pay" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>
<script language="javascript" for="gcds_pay" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_pay" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_pay.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>
<script language="javascript" for="gcds_pay2" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	// document.all.LowerFrame.style.visibility="visible";
</script>
<script language="javascript" for="gcds_pay2" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_pay2.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td  background="../../Common/img/com_t_bg.gif"><img src="../img/h100003_head.gif"></td>
    <td  align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			<img src="../../Common/img/btn/com_b_file.gif"	style="cursor:hand" onclick="ln_File()">
			<img src="../../Common/img/btn/com_b_excel.gif"	style="cursor:hand" onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onclick="ln_Delete()">
			<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()">
			<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
						<td style="height:23px;border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" class="txtbox"  align=center>
							<nobr>&nbsp;기준년월&nbsp;</nobr></td>
								<td style="height:23px;border:0 solid #708090;border-bottom-width:0px" align=center><nobr>
									<comment id="__NSID__"><OBJECT id=gcem_stdym1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:1px;top:2px; width:50px; height:20px;" class="txtbox">
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
									</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
									
									<comment id="__NSID__"><OBJECT id=gcif_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03 style="position:relative;left:9px;width:0; height:0;" align="absmiddle">
										<param name="Text"		value='찾아보기'>
										<param name="Enable"	value="True">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
								</td>
						<td width="100%" style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;</nobr></td>  
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
							<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pay style="WIDTH:576px;HEIGHT:420px;border:1 solid #777777;display:block;" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_pay">
								<PARAM NAME="Editable"		VALUE="FALSE">
								<PARAM NAME="BorderStyle" VALUE="0">
								<param name="Fillarea"		VALUE="true">
								<param name=Numeric       value=true>
								<param name=IsComma				value=true><!--기준년월 : Mask='XXXX/XX'   -->
								<PARAM NAME="Format"			VALUE="  
									<F> Name='기준년월'	ID=STDYM		HeadAlign=Center HeadBgColor=#B9D4DC Width=60	 align=CENTER		BgColor='#f5f5f5' </F>
									<F> Name='직급'			ID=PAYGRD		HeadAlign=Center HeadBgColor=#B9D4DC Width=32  align=CENTER		BgColor='#f5f5f5' </F>
									<F> Name='호봉'			ID=PAYSEQ		HeadAlign=Center HeadBgColor=#B9D4DC Width=32  align=CENTER		BgColor='#f5f5f5' Edit=Numeric  </F>
									<C> Name='시급'			ID=TIMAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C>
									<C> Name='기본급'		ID=BASAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									<C> Name='시간외'		ID=ECTAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									<C> Name='교통비'		ID=TRAAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									<C> Name='현장수당'		ID=PLAAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									<C> Name='북측근무수당'	ID=NORAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=79  align=RIGHT		Edit=Numeric  </C>
									<C> Name='본사급여'		ID=MONAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									<C> Name='현장급여'		ID=PMOAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									<C> Name='북측급여'		ID=NMOAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									<C> Name='본사연봉'		ID=YERAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									<C> Name='현장연봉'		ID=PYEAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									<C> Name='북측연봉'		ID=NYEAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									">
              </OBJECT></comment><script>__ws__(__NSID__);</script>
							<fieldset id=ft_div1 style="width:578px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
								<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
							</fieldset>
						</td>
						<td width=3></td>
						<td>
              <table border= "0" class=itemdisp cellpadding=0 cellspacing=0 style='width:295px;height:25px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
								<tr>
                  <td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;기준년월</nobr></td>
									<td style="width:70px;height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px" bgcolor="#ffffff">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_stdym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:3px; width:50px; height:20px;" class="txtbox" validFeatures="ignoreStatus=yes" validExp="">
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
										</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
									</td> 
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:0px;border-bottom-width:0px"  bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;직&nbsp;급&nbsp;</nobr></td>
									<td style="width:90px;height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:0px;border-bottom-width:0px"  align=center><nobr>&nbsp;&nbsp;
										<comment id="__NSID__"><OBJECT id=gclx_paygrd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=150 width=115 style="position:relative;top:3px;left:-5" class="txtbox">
											<param name=ComboDataID			value=gcds_paycd1>
											<param name=SearchColumn		value="MINORCD^MINORNM">
											<param name=Sort            value="TRUE">
											<param name=SortColumn			value="MINORCD">
											<param name=ListExprFormat	value="MINORNM">
											<param name=BindColumn			value="MINORCD">
										</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
                </tr>
							</table>

							<table border=0><tr><td height=1></td></tr></table>

							<table border= "0" class=itemdisp cellpadding=0 cellspacing=0 style='width:295px;height:410px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>		
								<tr>
                  <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" ><nobr>호봉</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_1ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
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
										</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox" align=center>
										<nobr>&nbsp;시급&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_5ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
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
										</OBJECT></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  align=center bgcolor="#eeeeee" class="txtbox" >
										<nobr>&nbsp;&nbsp;기본급&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_2ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
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
										</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  align=center bgcolor="#eeeeee" class="txtbox"><nobr>&nbsp;&nbsp;시간외&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_3ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
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
										</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
									</td>
                </tr>

      

<!--여기에 넣기 , 교통비부터~ -->
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>&nbsp;&nbsp;교통비&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_traamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
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
										</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>&nbsp;&nbsp;현장수당&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_plaamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
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
										</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>&nbsp;&nbsp;북측근무수당&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_noramt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
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
										</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>&nbsp;&nbsp;본사월급여&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_monamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
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
										</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>&nbsp;&nbsp;현장월급여&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_pmoamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
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
										</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>&nbsp;&nbsp;북측월급여&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_nmoamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
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
										</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
									<nobr>&nbsp;&nbsp;본사연봉&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_yeramt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
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
										</OBJECT></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>&nbsp;&nbsp;현장연봉&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_pyeamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
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
										</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>&nbsp;&nbsp;북측연봉&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_nyeamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
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
										</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
								</tr>

								<tr>
                  <td style="height:70%;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px" bgcolor="#ffffff">
										<nobr></nobr></td>
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
<comment id="__NSID__"><OBJECT id=gcbn_pyo classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_pay>
	<param name=BindInfo  value='
		<C>Col=STDYM		Ctrl=gcem_stdym       Param=text</C>
		<C>Col=PAYGRD		Ctrl=gclx_paygrd      Param=BindColVal</C>
		<C>Col=PAYSEQ		Ctrl=gcem_1ho		  Param=text</C>
		<C>Col=TIMAMT 		Ctrl=gcem_5ho		  Param=text</C>
		<C>Col=BASAMT 		Ctrl=gcem_2ho		  Param=text</C>
		<C>Col=ECTAMT 		Ctrl=gcem_3ho		  Param=text</C>
		<C>Col=TRAAMT 		Ctrl=gcem_traamt	  Param=text</C>
		<C>Col=PLAAMT 		Ctrl=gcem_plaamt	  Param=text</C>
		<C>Col=NORAMT 		Ctrl=gcem_noramt	  Param=text</C>
		<C>Col=MONAMT 		Ctrl=gcem_monamt	  Param=text</C>
		<C>Col=PMOAMT 		Ctrl=gcem_pmoamt	  Param=text</C>
		<C>Col=NMOAMT 		Ctrl=gcem_nmoamt	  Param=text</C>
		<C>Col=YERAMT 		Ctrl=gcem_yeramt	  Param=text</C>
		<C>Col=PYEAMT 		Ctrl=gcem_pyeamt	  Param=text</C>
		<C>Col=NYEAMT 		Ctrl=gcem_nyeamt	  Param=text</C>
	'>


</OBJECT></comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	



