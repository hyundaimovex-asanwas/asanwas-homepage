<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	급여항목관리
+ 프로그램 ID	: H100001
+ 기 능 정 의	: 조회|등록|저장|삭제
+ 변 경 이 력	: 이순미
+ 서 블 릿 명	: p010001_s1, p010001_t1
------------------------------------------------------------------------------>
 
<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>급여항목관리</title>
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
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	ln_Luxequery();				//공통코드

	gcem_frdt1.text		=		gcurdate.substring(0,7);

	gclx_paydiv.enable = false;
	gclx_pbdiv.enable = false;
	txt_paycd.disabled = true;

	gclx_paydiv1.index = 0;
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	var str1 = gclx_paydiv1.BindColVal;
	var str2 = gclx_pbdiv1.BindColVal;
	var str3 = gcem_frdt1.text;

	//if (gcem_frdt1.text != "") {  str3 = str3+"01"; }

	ln_Luxequery1();

	gcds_pay.DataID = "/servlet/Contract.h100001_s1?v_str1="+str1+"&v_str2="+str2+"&v_str3="+fn_trim(str3);
	gcds_pay.Reset(); 

	gclx_paydiv.enable = false;
	gclx_pbdiv.enable = false;
	txt_paycd.disabled = true;

}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

	gcds_pay.addrow();

	gclx_paydiv.enable = true;
	gclx_pbdiv.enable = true;
	txt_paycd.disabled = false;

	gclx_paydiv.index  = 0;
	gclx_pbdiv.index  = 0;

	gcra_caldiv.CodeValue = 2;
	gcra_autoyn.CodeValue = 'Y';
	gcra_taxyn.CodeValue = 'Y';

	gcem_frdt.text		=		gcurdate.substring(0,7) + "01";
	gcem_todt.text		=		"99991231";

	gcds_pay.namevalue(gcds_pay.RowPosition,"FRDT")=gcem_frdt.text+"01";
	gcds_pay.namevalue(gcds_pay.RowPosition,"TODT")=gcem_todt.text+"31";
	
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

	if (!ln_Valchk()) return;
  
	if (gcds_pay.IsUpdated) {	
	//prompt('',gcds_pay.text);
		if (confirm("입력하신 사항을 등록하시겠습니까?")){
			gctr_pay.KeyValue = "p010001_t1(I:USER=gcds_pay)";
			gctr_pay.Action = "/servlet/Contract.h100001_t1";
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
	//prompt('',gcds_pay.text);
    gctr_pay.action = "/servlet/Contract.h100001_t1";
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

	if (txt_paycd.value == "") {
		alert("정확한 항목코드를 입력해 주십시오.");
		txt_paycd.focus();
		return false;
	}
	
	if (txt_paycdnm.value == "") {
		alert("정확한 항목명칭을 입력해 주십시오.");
		txt_paycdnm.focus();
		return false;
	}

	return true;

}

/******************************************************************************
	Description : 공통코드 조회[검색]
******************************************************************************/
function ln_Luxequery() { 

	//급여구분[검색]
	//gcds_paycd11.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1120"; 
	//gcds_paycd11.Reset();

	//항목구분[검색]
	gcds_paycd22.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1126"; 
	gcds_paycd22.Reset();
}

/******************************************************************************
	Description : 공통코드 조회
******************************************************************************/
function ln_Luxequery1() { 

	//급여구분
	//gcds_paycd1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1120"; 
	//gcds_paycd1.Reset();

	//항목구분
	gcds_paycd2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1126"; 
	gcds_paycd2.Reset();

}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gcds_pay" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!--급여구분[검색]
<comment id="__NSID__"><OBJECT id="gcds_paycd11" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE" >
</OBJECT></comment><script>__ws__(__NSID__);</script>-->

<!--급여구분
<comment id="__NSID__"><OBJECT id="gcds_paycd1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE" >
</OBJECT></comment><script>__ws__(__NSID__);</script>-->

<comment id="__NSID__"><OBJECT id="gcds_paycd22" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE"><!--항목구분[검색]-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_paycd2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE"><!--항목구분-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_pay classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="p010001_t1(I:USER=gcds_pay)">
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

<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/h100001_head.gif"></td>
    <td align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onclick="ln_Delete()">
			<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()">
			<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
	
	<table border="0" cellpadding="1" cellspacing="0" style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
    <tr>
			<td width="10" style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
				<nobr>&nbsp;지급구분&nbsp;&nbsp;</nobr></td>
			<td width="10" style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
				<comment id="__NSID__"><OBJECT id=gclx_paydiv1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=120 style="position:relative;top:2px;" class="txtbox">
					<param name=CBData					value="T^정기급여">
					<param name=CBDataColumns		value="MINORCD,MINORNM">
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
			</td>
			<td width="20"  style="border:0 solid #708090;border-right-width:1px;border-left-width:0px;" bgcolor="#eeeeee">
				<nobr>&nbsp;항목구분&nbsp;&nbsp;</nobr></td>
			<td width="10" style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
				<comment id="__NSID__"><OBJECT id=gclx_pbdiv1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=120 style="position:relative;top:2px;" class="txtbox">
					<param name=ComboDataID			value=gcds_paycd22>
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
			</td>  
			<td width="10" style="border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee">
				<nobr>&nbsp;적용년월&nbsp;</nobr></td>
			<td style="border:0 solid #708090;border-right-width:1px;" ><nobr>&nbsp;
				<comment id="__NSID__"><OBJECT id=gcem_frdt1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:0px;top:2px; width:50px; height:20px;" class="txtbox"	validFeatures="ignoreStatus=yes" validExp="">
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
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_frdt1', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"> -->&nbsp;</nobr>
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
						<comment id="__NSID__"><OBJECT  id=gcgd_pay classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="WIDTH:630px;HEIGHT:420px;border:1 solid #777777;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_pay">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle" VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='지급구분'			ID=PAYDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=LEFT Mask='정기급여'</C> 
								<C> Name='항목구분'			ID=PBDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=LEFT Data='gcds_paycd2:MINORCD:MINORNM' EditStyle=Lookup</C> 
								<C> Name='항목코드'			ID=PAYCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=CENTER </C>
								<C> Name='항목명'				ID=PAYCDNM  HeadAlign=Center HeadBgColor=#B9D4DC Width=118 align=LEFT </C>
								<C> Name='시작년월'	ID=FRDT			HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=CENTER Mask='XXXX/XX'</C> 
								<C> Name='종료년월'	ID=TODT		  HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=CENTER Mask='XXXX/XX'</C> 
								<C> Name='프로그램ID'		ID=PGMID		HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=LEFT </C> 
       					">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
			<fieldset id=ft_div1 style="width:632px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
</fieldset>

					</td>
					<td width=3>
					</td>
					<td>
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0 style='width:243px;height:442px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090;'>
							<tr>
								<td style="width:90px;height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>지급구분</td>
								<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__"><OBJECT id=gclx_paydiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=120 style="position:relative;top:2px;" class="txtbox">
										<param name=CBData					value="T^정기급여">
										<param name=CBDataColumns		value="MINORCD,MINORNM">
										<param name=SearchColumn		value="MINORCD^MINORNM">
										<param name=Sort            value="TRUE">
										<param name=SortColumn			value="MINORCD">
										<param name=ListExprFormat	value="MINORNM">
										<param name=BindColumn			value="MINORCD">
									</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
								</td>
              </tr>
              <tr>
                <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>항목구분</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>&nbsp;
									<comment id="__NSID__"><OBJECT id=gclx_pbdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=120 style="position:relative;top:2px;" class="txtbox">
										<param name=ComboDataID			value=gcds_paycd2>
										<param name=SearchColumn		value="MINORCD^MINORNM">
										<param name=Sort            value="TRUE">
										<param name=SortColumn			value="MINORCD">
										<param name=ListExprFormat	value="MINORNM">
										<param name=BindColumn			value="MINORCD">
									</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
								</td> 
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"  align=CENTER>항목코드</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
									<input id="txt_paycd" name="txt_paycd"	type='text'	style="width:90px;position:relative;left:5px" class="txtbox" maxlength="8" onBlur="bytelength(this,this.value,8);">
								</td> 
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>항목명칭</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
									<input id="txt_paycdnm" name="txt_paycdnm"	type='text'	style="width:90px;position:relative;left:5px" class="txtbox" maxlength="40" onBlur="bytelength(this,this.value,40);">
								</td> 
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>계산구분</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
									<comment id="__NSID__"><OBJECT id=gcra_caldiv classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="position:relative;left:1px;top:0px;height:24;width:145;cursor:hand;" class="txtbox">
										<param name=Cols     value="3">
										<param name=Format   value="1^율,2^정액,3^표">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
								</td> 
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>프로그램ID</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
									<input id="txt_pgmid" name="txt_pgmid"	type='text' style="width:120px;position:relative;left:5px" class="txtbox" maxlength="20" onBlur="bytelength(this,this.value,20);">
								</td> 
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>퇴직급여여부</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
									<comment id="__NSID__"><OBJECT id=gcra_autoyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="position:relative;left:1px;top:0px;height:24;width:115;cursor:hand;" class="txtbox">
										<param name=Cols     value="2">
										<param name=Format   value="Y^포함,N^미포함">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
								</td> 
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>과세구분</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
									<comment id="__NSID__"><OBJECT id=gcra_taxyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="position:relative;left:1px;top:0px;height:24;width:115;cursor:hand;" class="txtbox">
										<param name=Cols     value="2">
										<param name=Format   value="Y^과세,N^비과세">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
								</td> 
							</tr>
							<!--tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>계산순위</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
									<input id="txt_calseq" name="txt_calseq"	type='text'	style="width:90px;position:relative;left:5px" class="txtbox" maxlength="3" onBlur="bytelength(this,this.value,3);">
								</td>
							</tr-->
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>적용시작년월</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
									<comment id="__NSID__"><OBJECT id=gcem_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:6px;top:2px; width:50px; height:20px;" class=txtbox validFeatures="ignoreStatus=yes" validExp="">
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
									</OBJECT></comment><script>__ws__(__NSID__);</script>

									<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_frdt', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;"> -->
								</td> 
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>적용종료년월</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
								<comment id="__NSID__"><OBJECT id=gcem_todt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:6px;top:2px; width:50px; height:20px;" class=txtbox validFeatures="ignoreStatus=yes" validExp="">
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
								</OBJECT></comment><script>__ws__(__NSID__);</script>
								
								<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_todt', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;"> -->											
							</td> 
						</tr>
						<tr>
							<td style="sheight:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" align=CENTER>비&nbsp;&nbsp;&nbsp;&nbsp;고</td>
							<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px" bgcolor="#ffffff">
								<textarea id="txt_memo" name="txt_memo"	style="width:140px;height:115px;position:relative;left:5px" class="txtbox"></textarea>
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
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT	id=gcbn_pay classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_pay>
	<param name=BindInfo		value='
		<C>Col=PAYDIV				Ctrl=gclx_paydiv      Param=BindColVal</C>
		<C>Col=PBDIV				Ctrl=gclx_pbdiv       Param=BindColVal</C>
		<C>Col=PAYCD				Ctrl=txt_paycd				Param=value</C>
		<C>Col=PAYCDNM			Ctrl=txt_paycdnm			Param=value</C>
		<C>Col=CALDIV				Ctrl=gcra_caldiv			Param=CodeValue</C>
		<C>Col=PGMID				Ctrl=txt_pgmid				Param=value</C>
		<C>Col=AUTOYN				Ctrl=gcra_autoyn			Param=CodeValue</C>
		<C>Col=TAX				Ctrl=gcra_taxyn		    	Param=CodeValue</C>
		<C>Col=FRDT					Ctrl=gcem_frdt				Param=text</C>
		<C>Col=TODT					Ctrl=gcem_todt				Param=text</C>
		<C>Col=MEMO					Ctrl=txt_memo					Param=value</C>
	'>
</OBJECT></comment><script>__ws__(__NSID__);</script>
		<!--C>Col=CALSEQ				Ctrl=txt_calseq				Param=value</C-->

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	