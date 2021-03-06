<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	연월차관리
+ 프로그램 ID	: p010004
+ 기 능 정 의	: 조회|등록|저장|삭제
+ 변 경 이 력	: 이순미
+ 서 블 릿 명	: p110001_s1, p110001_t1
------------------------------------------------------------------------------>
 
<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>연월차관리</title>
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

	ln_DeptQuery();	//소속
	
	gcem_frdt1.text = gcurdate.substring(0,7);

	//txt_empnm.disabled = true;

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	var str1 = gcem_frdt1.text;
	var str2 = gclx_deptcd.BindColVal;
	var str3 = txt_empnm.value;

	gcds_pay.DataID = "/servlet/Contract.p110001_s1?v_str1="+fn_trim(str1)
																													 +"&v_str2="+str2
																													 +"&v_str3="+fn_trim(str3)
																													 +"&v_str4="+gs_level
																													 +"&v_str5="+gs_treecd; 
	gcds_pay.Reset(); 

	//txt_empnm.value = "";
	//txt_empno.value = "";

}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

	gcds_pay.addrow();
	
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

	//if (!ln_Valchk()) return;
	
	var row = gcds_pay.rowposition;

	var cur_y = gcds_pay.namevalue(row,"CURYEAR");
	var use_y = gcds_pay.namevalue(row,"USEYEAR");

	////gcds_pay.namevalue(row,"PAYYEAR") = Number(cur_y-use_y);

	var cur_m = gcds_pay.namevalue(row,"CURMON");
	var use_m = gcds_pay.namevalue(row,"USEMON");

//	gcds_pay.namevalue(row,"PAYMON") = Number(cur_m-use_m);
  
	if (gcds_pay.IsUpdated) {	
//	prompt('',gcds_pay.text);
		if (confirm("입력하신 사항을 등록하시겠습니까?")){
			gctr_pay.KeyValue = "p110001_t1(I:USER=gcds_pay)";
			gctr_pay.Action = "/servlet/Contract.p110001_t1";
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
//	prompt('',gcds_pay.text);
    gctr_pay.action = "/servlet/Contract.p110001_t1";
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
if (gcds_pay.countrow<1) alert("다운로드하실 자료가 없습니다.");
	else gcgd_pay.RunExcel('연월차관리');
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
	Description : 성명 찾기 [검색]
******************************************************************************/
function ln_Popup(e){

	//var arrParam	= new Array();
	var arrResult	= new Array();
	var arrSend	= new Array();
	var strURL;	
	var strPos;

  arrSend[0]="H100011";
	strURL = "./H100011_popup.jsp";
	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrSend,strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		eval(e).value  = arrParam[0];
		if (e=="txt_empnm") txt_empnm.value = arrParam[1];	
	} else {
		eval(e).value = "";
		if (e=="txt_empnm") txt_empnm.value = "";	
	}
}


/******************************************************************************
	Description : 공통코드 조회
******************************************************************************/
function ln_Luxequery1() { 

	//급여구분
	gcds_paycd1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1120"; 
	gcds_paycd1.Reset();

	//항목구분
	gcds_paycd2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1126"; 
	gcds_paycd2.Reset();

}

/******************************************************************************
	Description : 소속 조회
******************************************************************************/
function ln_DeptQuery() { 

	gcds_deptcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?";	//소속명
	gcds_deptcd.Reset();
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcds_pay" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_deptcd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE">
	<PARAM NAME="SortExpr" VALUE="+TREECD"> 
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_pay classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="p010004_t1(I:USER=gcds_pay)">
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

<script language="javascript" for=gcds_deptcd event=onLoadCompleted(row, colid)>
	gcds_deptcd.insertrow(1);
	gcds_deptcd.namevalue(1,"DEPTCD") = "";
	gcds_deptcd.namevalue(1,"DEPTNM") = "전체";
	gclx_deptcd.index = 0;
</script>

<script language=JavaScript for=gclx_deptcd event=onSelChange()>
		gs_level = '';
		gs_treecd ='';
		gs_level = gclx_deptcd.ValueOfIndex ("level", gclx_deptcd.Index);
		gs_treecd = gclx_deptcd.ValueOfIndex ("treecd", gclx_deptcd.Index);

		gs_treecd = fn_treecd(gs_level, gs_treecd);
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


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/p010007_head.gif"></td>
    <td align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
	    <img src="../../Common/img/btn/com_b_excel.gif"	style="cursor:hand"		onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand"		onclick="ln_Delete()">
			<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand"		onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand"		onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table cellpadding="0" cellspacing="0" border="0" style='width:878px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr>  
					<td width="10"   style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;적용연월&nbsp;</nobr></td>
          <TD style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp
						<comment id="__NSID__"><object id=gcem_frdt1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:0px;top:2px; width:50px; height:20px;" class="txtbox"	validFeatures="ignoreStatus=yes" validExp="">
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
						</object></comment><script>__ws__(__NSID__);</script>&nbsp</nobr></TD>
					<td width="10"   style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;소&nbsp;속&nbsp;명&nbsp;</nobr></td>
					<td width="10" style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=180 width=150 style="position:relative; left:0px;top:2px" class="txtbox">
							<param name=ComboDataID           value=gcds_deptcd>
							<param name=SearchColumn          value="DEPTNM">
							<param name=Sort                  value="false">
							<param name=SortColumn						value="DEPTNM">
							<param name=ListExprFormat        value="DEPTNM">       
							<param name=BindColumn            value="DEPTCD"> 
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td>  
          <td width="10"   style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;&nbsp;성&nbsp;&nbsp;&nbsp;명&nbsp;&nbsp;</nobr></td>
          <td >&nbsp;<nobr>
						<input id="txt_empnm" name="txt_empnm"	type='text'	style="width:90px;position:relative;left:-5px;top:3px" class="txtbox" maxlength="20" onBlur="bytelength(this,this.value,20);" onkeydown="if(event.keyCode==13) ln_Query();">
						<input id="txt_empno" name="txt_empno"	type='hidden'	style="width:90px;position:relative;left:-5px" class="txtbox" maxlength="7" onBlur="bytelength(this,this.value,7);">
						
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="성명을 검색합니다" style="cursor:hand;position:relative;left:-9px;" align=center onclick="ln_Popup('txt_empnm');"></nobr>
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
						<comment id="__NSID__"><OBJECT id=gcgd_pay classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:876px;HEIGHT:420px;border:1 solid #777777;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_pay">
							<PARAM NAME="Editable"		VALUE="True">
							<PARAM NAME="BorderStyle" VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<param name="ColSizing"  value="true">
							<PARAM NAME="Format"			VALUE="  
								<F> Name='순'					ID={CUR_ROW} 	HeadBgColor=#B9D4DC Width=30		align=CENTER Value={CurRow} BgColor='#f5f5f5'</F>				
								<F> Name='소속명'			ID=DEPTNM			HeadBgColor=#B9D4DC Width=100		align=LEFT	BgColor='#f5f5f5' EditStyle=Lookup Data='gcds_deptcd:DEPTCD:DEPTNM' edit=none suppress=1</F>
								<F> Name='성명'				ID=EMPNMK  		HeadBgColor=#B9D4DC Width=50		align=LEFT	Edit=none  BgColor='#f5f5f5'</F>
								<F> Name='사번'				ID=EMPNO  		HeadBgColor=#B9D4DC Width=60		align=CENTER	Edit=none  BgColor='#f5f5f5'</F> 								
								<F> Name='직위'				ID=PAYGRD			HeadBgColor=#B9D4DC Width=75		align=LEFT	BgColor='#f5f5f5' EditStyle=Lookup Data='gcds_pay:PAYGRD:PAYGNM' edit=none</F>
                <C> Name='급호'				ID=GRDDIV  		HeadBgColor=#B9D4DC Width=46		align=CENTER Edit=none </C> 
								<C> Name='호봉'				ID=PAYSEQ  		HeadBgColor=#B9D4DC Width=28		align=CENTER Edit=none </C> 
								<C> Name='입사일'	ID=STRTDT		HeadBgColor=#B9D4DC Width=75		align=CENTER Edit=none  Mask='XXXX/XX/XX'</C>
								<C> Name='계약만료일'	ID=TODT		HeadBgColor=#B9D4DC Width=75		align=CENTER Edit=none  Mask='XXXX/XX/XX'</C>
								
							<G> Name='연차수'				HeadAlign=Center	HeadBgColor=#B9D4DC 
								<C> Name='정산'				ID=BEFYEAR		HeadBgColor=#B9D4DC Width=30		align=RIGHT 	</C>
								<C> Name='발생'				ID=CURYEAR		HeadBgColor=#B9D4DC Width=30		align=RIGHT 	</C>
								<C> Name='사용'				ID=USEYEAR		HeadBgColor=#B9D4DC Width=30		align=RIGHT   </C>
							</G>
							<G> Name='100%보상'		HeadAlign=Center HeadBgColor=#B9D4DC 
								<C> Name='잔여연차'		ID=PAYYEAR		HeadBgColor=#B9D4DC Width=70		align=RIGHT 	</C>
								<C> Name='금액'				ID=PAYAMT			HeadBgColor=#B9D4DC Width=70		align=RIGHT </C>
							</G>

								<C> Name='기본급'			ID=P10000			HeadBgColor=#B9D4DC Width=72		align=RIGHT Edit=Numeric  </C>
								<C> Name='조장수당'		ID=P27000			HeadBgColor=#B9D4DC Width=72		align=RIGHT Edit=Numeric  </C>
								<C> Name='계'					ID=PAYSUM			HeadBgColor=#B9D4DC Width=72		align=RIGHT Edit=Numeric  </C>
								<C> Name='통상임금/日'	ID=PAYGMT		HeadBgColor=#B9D4DC Width=77		align=RIGHT Edit=Numeric  </C>

							
       				">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset id=ft_div1 style="width:878px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
				<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
				</fieldset>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<!-- <comment id="__NSID__"><object id=gcbn_pay classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_pay>
	<param name=BindInfo  value='
		<C>Col=EVACD			Ctrl=ddlb_evacd       Param=BindColVal</C>
		<C>Col=DIVCD			Ctrl=ddlb_divcd       Param=BindColVal</C>
		<C>Col=GRPCD			Ctrl=ddlb_grpcd       Param=BindColVal</C>
		<C>Col=JOBGRPH		Ctrl=ddlb_jobgrph			Param=BindColVal</C>
		<C>Col=DETCD			Ctrl=ddlb_detcd				Param=BindColVal</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> -->
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	