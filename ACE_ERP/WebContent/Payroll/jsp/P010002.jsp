<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	급여항목변동관리
+ 프로그램 ID	: p010002
+ 기 능 정 의	: 조회|등록|저장|삭제
+ 변 경 이 력	: 이순미
+ 서 블 릿 명	: p010002_s1, p010002_s2, p010002_t1
------------------------------------------------------------------------------>

<html>
<head>
	<jsp:include page="/Payroll/common/include/head.jsp"/>
<title>급여항목관리</title>
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
 gs_paydiv="1";
 gs_pbdiv="1";

 /******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Luxequery();				//공통코드
	ln_DeptQuery();				//소속
	ln_Luxequery1()

	txt_empnm.disabled	= true;
	gclx_paydiv.enable	= false;
	gclx_pbdiv.enable		= false;
	gclx_paycd.enable		= false;
	
	gcem_frdt1.text = gcurdate.substring(0,7); //+"01";

	//txt_empnm.value	= "";
	//gclx_paydiv.BindColVal	= "";
	//gclx_pbdiv.BindColVal		= "";
	//gclx_paycd.BindColVal		= "";

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){


	var str1 = gclx_paydiv1.BindColVal;		//지급구분
	var str2 = gclx_pbdiv1.BindColVal;		//항목구분
	var str3 = gcem_frdt1.text;						//변동적용년월
	var str4 = gclx_deptcd.BindColVal;		//소속
	var str5 = txt_empno1.value;					//사번


	gcds_pay.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p010002_s1?v_str1="+str1
																												+"&v_str2="+str2
																												+"&v_str3="+fn_trim(str3)
																												+"&v_str4="+str4
																												+"&v_str5="+str5;
	gcds_pay.Reset();

	txt_empnm.disabled	= true;
	gclx_paydiv.enable	= false;
	gclx_pbdiv.enable		= false;
	gclx_paycd.enable		= false;

}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

	gcds_pay.addrow();

	txt_empnm.disabled	= true;
	gclx_paydiv.enable	= true;		gclx_paydiv.index = 0;
	gclx_pbdiv.enable		= true;		gclx_pbdiv.index = 0;
	gclx_paycd.enable		= true;		gclx_paycd.index = 10;

	gcem_frdt.text		=		gcurdate.substring(0,7) + "01";
	gcem_todt.text		=		"99991231";

	gcds_pay.namevalue(gcds_pay.RowPosition,"FRDT")=gcem_frdt.text;//+"01";
	gcds_pay.namevalue(gcds_pay.RowPosition,"TODT")=gcem_todt.text;//+"31";


	gs_paydiv= gclx_paydiv.BindColVal; ;
  gs_pbdiv=gclx_pbdiv.BindColVal;

	//alert("gs_paydiv"+gs_paydiv+"gs_pbdiv"+gs_pbdiv);


}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

	if (!ln_Valchk()) return;

	var str1 = gcem_frdt.text;
	var str2 = gcem_todt.text;

	if (gcds_pay.IsUpdated) {	
		if (confirm("입력하신 사항을 등록하시겠습니까?")){
			gctr_pay.KeyValue = "p010002_t1(I:USER=gcds_pay)";
			gctr_pay.Action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p010002_t1?v_str1="+str1+"&v_str2="+str2;

			//prompt("",gcds_pay.text);
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
    gctr_pay.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p010002_t1";
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

	return true;

}

/******************************************************************************
	Description : 성명 찾기 [입력]
******************************************************************************/
function ln_Popup(e){

	if (fn_trim(txt_empnm.value) != "" ) { //fn_trim(txt_empno.value) != "" || 
		alert("사용자명은 변경할 수 없습니다.");  
		return false; 
	}else{

	//var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./H030003_popup.jsp";
	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		eval(e).value  = arrParam[0];
		if (e=="txt_empnm") txt_empno.value = arrParam[1];	txt_deptnm.value = arrParam[2];
		gcds_pay.namevalue(gcds_pay.rowposition,"DEPTNMK") = fn_trim(txt_deptnm.value);
	} else {
		eval(e).value = "";
		if (e=="txt_empnm") txt_empno.value = "";	
	}
}
}

/******************************************************************************
	Description : 성명 찾기 [검색]
******************************************************************************/
function ln_Popup1(e){

	//var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./H030003_popup.jsp";
	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		eval(e).value  = arrParam[0];
		if (e=="txt_empnm1") txt_empno1.value = arrParam[1];	
	} else {
		eval(e).value = "";
		if (e=="txt_empnm1") txt_empno1.value = "";	
	}
}

/******************************************************************************
	Description : 공통코드 조회[검색]
******************************************************************************/
function ln_Luxequery() { 

	//지급구분[검색]
	gcds_paycd11.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1120"; 
	gcds_paycd11.Reset();

	//항목구분[검색]
	gcds_paycd22.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1126"; 
	gcds_paycd22.Reset();

}

/******************************************************************************
	Description : 공통코드 조회
******************************************************************************/
function ln_Luxequery1() { 

	//지급구분
	gcds_paycd1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1120"; 
	gcds_paycd1.Reset();

	//항목구분
	gcds_paycd2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1126"; 
	gcds_paycd2.Reset();

	//항목명
  gcds_paycd3.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p010001_s2"; 
	//prompt("",gcds_paycd3.DataID);
	gcds_paycd3.Reset();

//	gcds_paycd3.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p010001_s2?v_str1="+gs_paydiv+"&v_str2="+gs_pbdiv; 
	//prompt("",gcds_paycd3.DataID);
//	gcds_paycd3.Reset();

}

/******************************************************************************
	Description : 공통코드 조회 20051118....정영식 추가
******************************************************************************/
function ln_Luxequery2() { 

		//항목명
	gcds_paycd3.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p010001_s2?v_str1="+gs_paydiv+"&v_str2="+gs_pbdiv; 
	//prompt("222",gcds_paycd3.DataID);
	gcds_paycd3.Reset();
}


/******************************************************************************
	Description : 공통코드 조회
******************************************************************************/
function ln_DeptQuery() { 
	//소속명
	//gcds_deptcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>h010018_s3?v_str1=";
	gcds_deptcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?v_str1=";
	gcds_deptcd.Reset();
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

<comment id="__NSID__"><object id="gcds_paycd1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE" ><!--지급구분-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_paycd11" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE" ><!--지급구분[검색]-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_paycd22" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE"><!--항목구분[검색]-->
	<PARAM NAME="SortExpr" VALUE="+MINORNM">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_paycd2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE"><!--항목구분-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_paycd3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE"><!--항목명-->
	<!-- <param name=UseFilter   value=true> -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_deptcd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE"><!--소속명-->
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_pay classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="p010002_t1(I:USER=gcds_pay)">
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



<script language=javascript for=txt_empnm event=onBlur>
	if (txt_empnm.value =="") {
		gcds_pay.namevalue(gcds_pay.rowposition,"EMPNO") = "";
	}
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

<script language=JavaScript for= gclx_paydiv event=OnSelChange2()> 
  
		gs_paydiv = gclx_paydiv.BindColVal; 
    gs_pbdiv = gclx_pbdiv.BindColVal; 
		ln_Luxequery2();
		//gcds_paycd3.filter();
		//gclx_paycd.index=1;
</script> 


<script language=JavaScript for= gclx_paydiv event=OnSelChange()> 
   
		gs_paydiv = gclx_paydiv.BindColVal; 
    gs_pbdiv = gclx_pbdiv.BindColVal; 
		ln_Luxequery2();
		//alert("gs_paydiv0"+gs_paydiv+"gs_pbdiv"+gs_pbdiv);
		//gclx_paycd.ClearData(); 
		//gcds_paycd3.filter();
		//gclx_paycd.index=1;
</script>


<script language=JavaScript for= gclx_pbdiv event=OnSelChange2()> 
  
    gs_paydiv = gclx_paydiv.BindColVal; 
		gs_pbdiv = gclx_pbdiv.BindColVal; 
		//gclx_paycd.ClearData(); 
		//gcds_paycd3.filter();
		//gclx_paycd.index=1;
</script>

<script language=JavaScript for= gclx_pbdiv event=OnSelChange()> 

   
    gs_paydiv = gclx_paydiv.BindColVal; 
		gs_pbdiv = gclx_pbdiv.BindColVal; 
	  ln_Luxequery2();
	
		//gclx_paycd.ClearData(); 
	//	gcds_paycd3.filter();
		//gclx_paycd.index=1;

		//alert("gs_paydiv"+gs_paydiv+"gs_pbdiv"+gs_pbdiv);

		//txt_index.value = LuxeCombo1.Index;
//		gclx_paydiv.BindColVal = LuxeCombo1.ValueOfIndex("Country", txt_index.value);


</script>


<script language=JavaScript for= gclx_paycd event=OnSelChange()> 
		
		gcds_pay.namevalue(gcds_pay.rowposition,"PAYCDNM")=gcds_paycd3.namevalue(gcds_paycd3.rowposition,"PAYCDNM");
</script>

<script language=JavaScript for=gcds_paycd3 event=onFilter(row)>
	if (gcds_paycd3.NameValue(row,"PAYDIV")==gs_paydiv && gcds_paycd3.NameValue(row,"PBDIV")==gs_pbdiv) return true
	else return false;
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">


<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/p010005_head.gif"></td>
    <td align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
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
					<td width="10" style="border:0 solid #708090;border-left-width:0px;" bgcolor="#eeeeee" align=center><nobr>&nbsp;지급구분&nbsp;</nobr></td>
					<td width="10" style="border:0 solid #708090;border-left-width:1px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gclx_paydiv1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=70 style="position:relative;top:2px;" class="txtbox">
							<param name=ComboDataID			value=gcds_paycd11>
							<param name=SearchColumn		value="MINORCD^MINORNM">
							<param name=Sort            value="TRUE">
							<param name=SortColumn			value="MINORCD">
							<param name=ListExprFormat	value="MINORNM">
							<param name=BindColumn			value="MINORCD">
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td>
					<td width="20"   style="border:0 solid #708090;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align=center><nobr>&nbsp;항목구분&nbsp;</nobr></td>
					<td width="10" style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gclx_pbdiv1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=100 style="position:relative;top:2px;" class="txtbox">
							<param name=ComboDataID			value=gcds_paycd22>
							<param name=SearchColumn		value="MINORCD^MINORNM">
							<param name=Sort            value="TRUE">
							<param name=SortColumn			value="MINORCD">
							<param name=ListExprFormat	value="MINORNM">
							<param name=BindColumn			value="MINORCD">
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td>
					<td style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;width=70px"  bgcolor="#eeeeee" align=center><nobr>&nbsp;적용년월&nbsp;</nobr></td>
					<td style="border:0 solid #708090;border-right-width:1px;" ><nobr>&nbsp;
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
						</object></comment><script>__ws__(__NSID__);</script>
						<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('ADE_EMEdit_ec02ay', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"> -->&nbsp;</nobr>
					</td> 
					 <td width="20"   style="border:0 solid #708090;border-right-width:1px;border-left-width:0px;" bgcolor="#eeeeee" align=center><nobr>&nbsp;소속명&nbsp;</nobr>
					</td>
					<td width=110><nobr>&nbsp;
						<comment id="__NSID__"><object id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=180 width=150 style="position:relative; left:0px;top:2px" class="txtbox">
							<param name=ComboDataID           value=gcds_deptcd>
							<param name=SearchColumn          value="DEPTNM">
							<param name=Sort                  value="false">
							<param name=SortColumn						value="DEPTNM">
							<param name=ListExprFormat        value="DEPTNM">       
							<param name=BindColumn            value="DEPTCD"> 
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						<!-- <input id="txt_deptnmk1" name="txt_deptnmk1"	type='text'	style="width:80px;position:relative;left:-5px" class="txtbox"> -->
					</td>
					<td width="20" style="border:0 solid #708090;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;성&nbsp;&nbsp;&nbsp;명&nbsp;</nobr></td>
					<td><nobr>&nbsp;
						<input id="txt_empnm1" name="txt_empnm1"	type='text'	style="width:60px;position:relative;left:-5px;top:0px" class="txtbox" maxlength="20" onBlur="bytelength(this,this.value,20);" onkeydown="if(event.keyCode==13) ln_Query();" disabled>
						<img src="../../Common/img/btn/com_b_find.gif" style="cursor:hand;position:relative;top:3px;left:-5px" alt="성명을 검색합니다" onclick="ln_Popup1('txt_empnm1')"></nobr>
						<input id="txt_empno1" name="txt_empno1"	type='hidden'	style="width:80px;position:relative;left:-5px" class="txtbox" maxlength="7" onBlur="bytelength(this,this.value,7);">
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
							<comment id="__NSID__"><OBJECT id=gcgd_create classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:668px;HEIGHT:420px;border:1 solid #777777;display:block;"   viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_pay">
								<PARAM NAME="Editable"		VALUE="false">
								<PARAM NAME="ColSizing"		VALUE="True">
								<PARAM NAME="BorderStyle" VALUE="0">
								<param name="Fillarea"		VALUE="true">
								<PARAM NAME="Format"			VALUE="  
									<F> Name='사번'					ID=EMPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=CENTER	BgColor='#f5f5f5'</F> 
									<F> Name='성명'					ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=LEFT		BgColor='#f5f5f5'</F> 
									<F> Name='소속'					ID=DEPTNMK  HeadAlign=Center HeadBgColor=#B9D4DC Width=125	align=LEFT		BgColor='#f5f5f5'</F> 
									<C> Name='지급구분'			ID=PAYDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=CENTER		Data='gcds_paycd1:MINORCD:MINORNM'	EditStyle=Lookup</C> 
									<C> Name='항목구분명'		ID=PBDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT		Data='gcds_paycd2:MINORCD:MINORNM'	EditStyle=Lookup</C> 
									<C> Name='항목명'				ID=PAYCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=LEFT		  show=false</C> 
                  <C> Name='항목명'				ID=PAYCDNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=LEFT</C> 
									<C> Name='변동금액'			ID=PAYAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT	</C>
									<C> Name='시작년월'			ID=FRDT			HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=CENTER	Mask='XXXX/XX'</C> 
									<C> Name='종료년월'			ID=TODT			HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=CENTER	Mask='XXXX/XX'</C>
											">
              </OBJECT></comment><script>__ws__(__NSID__);</script>
			  <fieldset id=ft_div1 style="width:670px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
</fieldset><!-- <C> Name='항목란'				ID=EXCSCR		HeadAlign=Center HeadBgColor=#B9D4DC Width=0		align=LEFT show=false</C> -->

						</td>
						<td width=3></td>
						<td>              
							<table class=itemdisp cellpadding=0 cellspacing=0  border=0 style='width:0px;height:442px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
								<tr>
                  <td style="width:90px;height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox"><nobr>성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</nobr></td>
                  <td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr><table cellspacing=0 cellpadding=0 border=0><tr><td>&nbsp;&nbsp;</td><td style="padding-left:1px;"><input id="txt_empnm" name="txt_empnm"	type='text'	style="width:60px;position:relative;left:-7px;top:1px" class="txtbox" maxlength="20" onBlur="bytelength(this,this.value,20);"></td>
				                <td><input id="txt_deptnm" name="txt_deptnm"	type='hidden'	style="width:90px;position:relative;left:-7px;top:-1px" class="txtbox"></td>
										<td><input id="txt_empno" name="txt_empno"	type='hidden'	style="width:90px;position:relative;left:-1px;top:7px" class="txtbox"></td>
										<td><img src="../../Common/img/btn/com_b_find.gif" style="cursor:hand ;border:0px" alt="성명을 검색합니다" onclick="ln_Popup('txt_empnm')"  vspace=0 hspace=0></td></tr></table></nobr></td>
                </tr>
								<tr>
                  <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">지급구분</td>
                  <td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
										<comment id="__NSID__"><object id=gclx_paydiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=110 style="position:relative;top:2px;" class="txtbox">
										<param name=ComboDataID			value=gcds_paycd1>
										<param name=SearchColumn		value="MINORCD^MINORNM">
										<param name=Sort            value="TRUE">
										<param name=SortColumn			value="MINORCD">
										<param name=ListExprFormat	value="MINORNM">
										<param name=BindColumn			value="MINORCD">
									</object></comment><script>__ws__(__NSID__);</script></nobr></td>
                </tr>
                <tr>
                  <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">항목구분</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
										<comment id="__NSID__"><object id=gclx_pbdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=110 style="position:relative;top:2px;left:5px" class="txtbox">
										<param name=ComboDataID			value=gcds_paycd2>
										<param name=SearchColumn		value="MINORCD^MINORNM">
										<param name=Sort            value="TRUE">
										<param name=SortColumn			value="MINORCD">
										<param name=ListExprFormat	value="MINORNM">
										<param name=BindColumn			value="MINORCD">
									</object></comment><script>__ws__(__NSID__);</script></nobr></td> 
								</tr>
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">항&nbsp;목&nbsp;명</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
										<comment id="__NSID__"><object id=gclx_paycd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=110 style="position:relative;top:2px;left:5px" class="txtbox">
										<param name=ComboDataID			value=gcds_paycd3>
										<param name=SearchColumn		value="PAYCD^PAYCDNM">
										<param name=Sort            value="TRUE">
										<param name=SortColumn			value="PAYCD">
										<param name=ListExprFormat	value="PAYCDNM">
										<param name=BindColumn			value="PAYCD">
									</object></comment><script>__ws__(__NSID__);</script></nobr></td> 
								</tr>
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">변동금액</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
										<comment id="__NSID__"><object id=gcem_payamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;position:relative;left:5px;" class="txtbox" >
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
										</object></comment><script>__ws__(__NSID__);</script></td> 
								</tr>				
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox"><nobr>&nbsp;변동시작년월&nbsp;</nobr></td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
										<comment id="__NSID__"><object id=gcem_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:6px;top:2px; width:50px; height:20px;" class=txtbox validFeatures="ignoreStatus=yes" validExp="">
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
										</object></comment><script>__ws__(__NSID__);</script></td> 
								</tr>
								<tr>
									<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">변동종료년월</td>
									<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
										<comment id="__NSID__"><object id=gcem_todt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:6px;top:2px; width:50px; height:20px;" class=txtbox validFeatures="ignoreStatus=yes" validExp="">
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
										</object></comment><script>__ws__(__NSID__);</script></td> 
								</tr>
								<tr>
									<td style="height:198px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee">&nbsp;</td>
									<td  Style="height:50px;border:0 solid #708090;border-bottom-width:0px"><nobr>&nbsp;</nobr></td>
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
		<C>Col=EMPNO			Ctrl=txt_empno				Param=value</C>
		<C>Col=EMPNMK			Ctrl=txt_empnm				Param=value</C>
		<C>Col=DEPTNMK		Ctrl=txt_deptnmk			Param=value</C>
		<C>Col=PAYDIV			Ctrl=gclx_paydiv      Param=BindColVal</C>
		<C>Col=PBDIV			Ctrl=gclx_pbdiv				Param=BindColVal</C>
		<C>Col=PAYCD			Ctrl=gclx_paycd				Param=BindColVal</C>
		
		<C>Col=FRDT				Ctrl=gcem_frdt				Param=text</C>
		<C>Col=TODT				Ctrl=gcem_todt				Param=text</C>
		<C>Col=PAYAMT			Ctrl=gcem_payamt			Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	



