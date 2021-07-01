<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	계약직/급여변동적용
+ 프로그램 ID	: H100005
+ 기 능 정 의	: 조회|저장|삭제
+ 서 블 릿 명	: h100005_s1, h100005_t1
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>급여변동적용</title>
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
var curtid = "88001";  
var key_sabun="";
var gs_level;
var gs_treecd;

gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	gcem_yearmon_search.Text=gs_date2;
	
	//소속정보
	gcds_dept.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?v_str1="; 
	gcds_dept.Reset();

	gclx_select_ec01az.index=1;

}

/******************************************************************************
	Description : 기본조회
******************************************************************************/
function ln_Query(){

	var str1 = "";//gcem_jigbil_search.Text;
	var str2 = fn_trim(gcem_yearmon_search.Text);
	var str3 = fn_trim(gclx_select_ec02az.BindColVal);
	var str4 = fn_trim(gcem_empno.Text);
	var str5 = fn_trim(txt_empnm.value);
	var str6 = fn_trim(gclx_select_ec01az.BindColVal);

	gcds_grid_ec01az.DataID = "/servlet/Contract.h100005_s1?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4 
									 + "&v_str5=" + str5
									 + "&v_str6=" + str6
									 + "&v_str7=" + gs_level
									 + "&v_str8=" + gs_treecd;

	gcds_grid_ec01az.Reset(); //그리드
	gcds_grid_ec01az.rowposition=1;
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Del(){
	if(gcds_grid_ec01az.countRow !=0)	{
		if (confirm("선택된 급여사항을 삭제하시겠습니까 ?")) {
			gcds_grid_ec01az.deleteRow(gcds_grid_ec01az.rowposition); //그리드
		}
	}
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save() {
	if (gcds_grid_ec01az.countrow <1) {
		alert("저장하실 정보가 없습니다.");
	} else {
		if (gcds_grid_ec01az.IsUpdated)	{
			if (confirm("급여변경사항을 저장하시겠습니까 ?")) {
				gctr_data.KeyValue = "Contract.h100005_t1(I:USER=gcds_grid_ec01az)";
				gctr_data.Action = "/servlet/Contract.h100005_t1";

		//prompt('gcds_grid_ec01az',gcds_grid_ec01az.text);
		//prompt('',gcds_grid_ec01az.text);

				gctr_data.Parameters = "v_str5="+gs_date;
				gctr_data.post();
				ln_Query();
			}
		} 
	}
}

/******************************************************************************
	Description : 급여기타(공제)항목 제목 자동생성
******************************************************************************/
function ln_TitelAuto() {

	var t_row = gcds_grid_ec01az.rowposition;

	//급여기타항목제목 자동생성
	if(gcds_grid_ec01az.namevalue(t_row,"PR0020") != null) txt_px01.value = gcds_grid_ec01az.namevalue(t_row,"PR0020");
	if(gcds_grid_ec01az.namevalue(t_row,"PR0030") != null) txt_px02.value = gcds_grid_ec01az.namevalue(t_row,"PR0030");
	if(gcds_grid_ec01az.namevalue(t_row,"PR0040") != null) txt_px03.value = gcds_grid_ec01az.namevalue(t_row,"PR0040");
	if(gcds_grid_ec01az.namevalue(t_row,"BR0020") != null) txt_pb01.value = gcds_grid_ec01az.namevalue(t_row,"BR0020");
	if(gcds_grid_ec01az.namevalue(t_row,"BR0030") != null) txt_pb02.value = gcds_grid_ec01az.namevalue(t_row,"BR0030");
	if(gcds_grid_ec01az.namevalue(t_row,"BR0040") != null) txt_pb03.value = gcds_grid_ec01az.namevalue(t_row,"BR0040");
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
<comment id="__NSID__"><OBJECT id=gcds_grid_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--기본사항조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--소속구분 DataSet-->
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"	VALUE="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_grid_ec01az" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec01az.countrow <=0)
	alert("조회된 데이타가 없습니다.");
	ln_TitelAuto()	//급여기타(공제)항목제목 자동생성
</script>

<script language="javascript" for="gcds_dept" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.InsertRow(1);
	gcds_dept.NameValue(1,"DEPTCD")="";
	gcds_dept.NameValue(1,"DEPTNM")="전체";
	gclx_select_ec02az.index=0;

	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript"  for=gcds_grid_ec01az  event=OnRowPosChanged(row)>
	var strBS=gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"BSDAY")+"";
	var strHJ=gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"HJDAY")+"";
	var strNS=gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"NSDAY")+"";
	if(strBS.length==1) strBS="0"+strBS;
	if(strHJ.length==1) strHJ="0"+strHJ;
	if(strNS.length==1) strNS="0"+strNS;
	gcem_SGUNMU.Text=strBS+","+strHJ+","+strNS;
</script>

<script language=JavaScript for=gcds_grid_ec01az event=OnColumnChanged(row,colid)>
	gcds_grid_ec01az.NameValue(row,"S91000")= //지급합계
	gcds_grid_ec01az.NameValue(row,"P10000")+
	gcds_grid_ec01az.NameValue(row,"P11000")+
	gcds_grid_ec01az.NameValue(row,"P12000")+
	gcds_grid_ec01az.NameValue(row,"P21000")+
	gcds_grid_ec01az.NameValue(row,"P22000")+
	gcds_grid_ec01az.NameValue(row,"P23000")+
	gcds_grid_ec01az.NameValue(row,"P24000")+
	gcds_grid_ec01az.NameValue(row,"P25000")+
	gcds_grid_ec01az.NameValue(row,"P26000")+
	gcds_grid_ec01az.NameValue(row,"P27000")+
	gcds_grid_ec01az.NameValue(row,"P28000")+
	gcds_grid_ec01az.NameValue(row,"P29000")+
	gcds_grid_ec01az.NameValue(row,"P30000")+
	gcds_grid_ec01az.NameValue(row,"P31000")+
	gcds_grid_ec01az.NameValue(row,"P32000")+
	gcds_grid_ec01az.NameValue(row,"P36000")+
	gcds_grid_ec01az.NameValue(row,"P37000")+
	gcds_grid_ec01az.NameValue(row,"P38000")+
	gcds_grid_ec01az.NameValue(row,"PX0010")+
	gcds_grid_ec01az.NameValue(row,"PX0020")+
	gcds_grid_ec01az.NameValue(row,"PX0030")+
	gcds_grid_ec01az.NameValue(row,"PX0040")+
	gcds_grid_ec01az.NameValue(row,"P34000")+
	gcds_grid_ec01az.NameValue(row,"P39000")+
	gcds_grid_ec01az.NameValue(row,"P35000");  

	gcds_grid_ec01az.NameValue(row,"S93000")=  //공제합계
	gcds_grid_ec01az.NameValue(row,"T11000")+
	gcds_grid_ec01az.NameValue(row,"T12000")+
	gcds_grid_ec01az.NameValue(row,"B11000")+
	gcds_grid_ec01az.NameValue(row,"B12000")+
	gcds_grid_ec01az.NameValue(row,"B13000")+
	gcds_grid_ec01az.NameValue(row,"B15000")+
	gcds_grid_ec01az.NameValue(row,"B14000")+
	gcds_grid_ec01az.NameValue(row,"B16000")+
	gcds_grid_ec01az.NameValue(row,"BX0010")+
	gcds_grid_ec01az.NameValue(row,"BX0020")+
	gcds_grid_ec01az.NameValue(row,"BX0030")+
	gcds_grid_ec01az.NameValue(row,"BX0040")+
	gcds_grid_ec01az.NameValue(row,"P41000")+
	gcds_grid_ec01az.NameValue(row,"P42000")+
	gcds_grid_ec01az.NameValue(row,"T21000")+
	gcds_grid_ec01az.NameValue(row,"T22000")+

	gcds_grid_ec01az.NameValue(row,"P43000");
  //2010.02.23 공제합계에서 산재보험은 제외시킴.
	//gcds_grid_ec01az.NameValue(row,"B17000"); 

	gcds_grid_ec01az.NameValue(row,"S94000")=		//실지급액
	gcds_grid_ec01az.NameValue(row,"S91000")-
	gcds_grid_ec01az.NameValue(row,"S93000");  //차인지급액
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_select_ec02az event=onSelChange()>
	gs_level = '';
	gs_treecd ='';
	gs_level = gclx_select_ec02az.ValueOfIndex ("level", gclx_select_ec02az.Index);
	gs_treecd = gclx_select_ec02az.ValueOfIndex ("treecd", gclx_select_ec02az.Index);
	gs_treecd = fn_treecd(gs_level, gs_treecd);
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="OnSuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
</script>


<script language="javascript" for="gctr_data" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	 alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>
</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
			B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td width=197 ><img src="../img/h100005_head.gif"></td>
    <td width="689" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"><nobr>	    
			<img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Del()">
			<img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;</nobr>
		</td>
  </tr>
	<tr> 
    <td COLSPAN=2>
			<table cellpadding="0" cellspacing="0" border="0" width=883 style='height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-left:3px;padding-right:3px;" bgcolor="#eeeeee">
						<nobr>&nbsp;&nbsp;&nbsp;적용년월&nbsp;&nbsp;&nbsp;</nobr>
					</td>	
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-top:2px;"><nobr>&nbsp;
						<comment id="__NSID__"><OBJECT id=gcem_yearmon_search classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment			value=0>
							<param name=Border	      value=True>
							<param name=ClipMode			value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=8>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td>
						<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;지급구분&nbsp;&nbsp;</nobr></td>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr><comment id="__NSID__"><OBJECT id=gclx_select_ec01az  name="gclx_select_ec01az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 
							style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
							<param name=CBData					value="T^정기급여,K^특별상여">
							<param name=CBDataColumns		value="MINORCD,MINORNM">
							<param name=SearchColumn		value="MINORCD^MINORNM">
							<param name=Sort            value="TRUE">
							<param name=SortColumn			value="MINORCD">
							<param name=ListExprFormat	value="MINORNM">
							<param name=BindColumn			value="MINORCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>

					<td width="0" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr >&nbsp;&nbsp;&nbsp;소속&nbsp;&nbsp;&nbsp;</nobr>
					</td>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;" WIDTH=150px><nobr>
						<comment id="__NSID__"><OBJECT id=gclx_select_ec02az  name="gclx_select_ec02az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value=gcds_dept>
							<param name=SearchColumn		value="DEPTCD^DEPTNM">
							<param name=Sort            value="false">
							<param name=SortColumn			value="DEPTCD">
							<param name=ListExprFormat	value="DEPTNM^0^130">
							<param name=BindColumn			value="DEPTCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
					</td>
					<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;&nbsp;&nbsp;사번&nbsp;&nbsp;&nbsp;</nobr>
					</td>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>
						<comment id="__NSID__"><OBJECT id=gcem_empno  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment			value=0>
							<param name=Border	      value=True>
							<param name=ClipMode			value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="0000000">
							<param name=MaxLength     value=7>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;&nbsp;</nobr>
					</td>
					<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" >
						<nobr>&nbsp;&nbsp;&nbsp;성명&nbsp;&nbsp;&nbsp;</nobr>
					</td>
					<td><input id=txt_empnm name=txt_empnm type=text class="txt11" size=10 onkeydown="if(event.keyCode==13) ln_Query();">&nbsp;</td>
					<td width="100%" align=RIGHT >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
  <tr><td colspan="2" height=3></td></tr>
  <tr> 
    <td colspan="2"> 
      <table width="876" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:340px" valign=top>
						<comment id="__NSID__"><OBJECT id=gcgd_grid_ec01az  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 363px; HEIGHT: 399px;border:1 solid #777777;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_grid_ec01az">
							<PARAM NAME="Editable"		VALUE="fALSE">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM name="Fillarea"		VALUE="true">
							<PARAM name="ColSizing"		VALUE="true">
							<PARAM name="SortView"		VALUE="left">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='년월' ID=APPDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55 align=center Mask='XXXX/XX' sort=true </C> 
								<C> Name='소속'			ID=DEPTNM   HeadAlign=Center HeadBgColor=#B9D4DC Width=110 sort=true </C>
								<C> Name='성명'			ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center sort=true </C>
								<C> Name='사번'			ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center   sort=true </C> 
								<C> Name='입사일'		ID=STRTDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=65 align=center Mask='XXXX/XX/XX'  sort=true </C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="width:365;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
					<td>&nbsp;</td>
					<td STYLE="PADDING-TOP:0px;" valign=top>
						<table width="503" cellpadding="0" cellspacing="0" border="0">
							<tr> 
								<td valign=top>
									<table border="0" cellpadding=0 cellspacing=0  border=0  style='width:512px;height:421px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:0 solid #708090'>
										<tr>
											<td style="height:20px;border:1 solid #708090;" bgcolor="#eeeeee">&nbsp;적용년월</td>
											<td style="border:1 solid #708090;border-left-width:0px;" colspan=2><nobr>
												<comment id="__NSID__"><OBJECT id=gcem_APPDT  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:1px; width:50px; height:18px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
													<param name=Text          value="">
													<param name=Alignment			value=0>
													<param name=ReadOnly			value=True>
													<param name=Border	      value=True>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=false>
													<param name=Format	      value="YYYY/MM">
													<param name=MaxLength     value=8>
													<param name=enable				value=false>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=false>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
											</td>
											<td style="height:20px;border:1 solid #708090;border-left-width:0px;" bgcolor="#eeeeee">&nbsp;사번</td>
											<td style="border:1 solid #708090;border-left-width:0px;" colspan=2><nobr>
												<input type="text" id=txt_empno class="txt11" maxlength=7 size=8 disabled style="postion:relative;left:2px;width:70px;"></nobr>
											</td>
											<td style="border:1 solid #708090;border-left-width:0px;" bgcolor="#eeeeee">&nbsp;성명</td>
											<td style="border:1 solid #708090;border-left-width:0px;" colspan=2>
												<input type="text" id=txt_EMPNMK class="txt11" disabled style="postion:relative;left:2px;width:70px;">
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;입사일자</td>
											<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px" colspan=2><nobr>
												<comment id="__NSID__"><OBJECT id=gcem_strtdt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:1px; width:70px; height:18px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
													<param name=Text          value="">
													<param name=Alignment			value=0>
													<param name=ReadOnly			value=True>
													<param name=Border	      value=True>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=false>
													<param name=Format	      value="YYYY/MM/DD">
													<param name=MaxLength     value=8>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=false>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
													<param name=enable				value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
											</td>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px" bgcolor="#eeeeee">&nbsp;퇴사일자</td>
											<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px" colspan=2><nobr>
												<comment id="__NSID__"><OBJECT id=gcem_enddt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:1px; width:70px; height:18px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
													<param name=Text          value="">
													<param name=Alignment			value=0>
													<param name=ReadOnly			value=True>
													<param name=Border	      value=True>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=false>
													<param name=Format	      value="YYYY/MM/DD">
													<param name=MaxLength     value=8>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=false>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
													<param name=enable				value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
											</td>
											<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee">&nbsp;지급일자</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_paydt1  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:1px; width:70px; height:18px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
													<param name=Text          value="">
													<param name=Alignment			value=0>
													<param name=ReadOnly			value=True>
													<param name=Border	      value=True>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=false>
													<param name=Format	      value="YYYY/MM/DD">
													<param name=MaxLength     value=8>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=false>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
													<param name=enable				value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
											</td>
										</tr>
										<tr>
											<td style="height:5px;border:0 solid #708090;" colspan=6></td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#B9D4DC" colspan=1>
												<nobr>&nbsp;지급항목</nobr>
											</td>
											<td style="border:0 solid #708090;border-top-width:1px;border-bottom-width:0px;" colspan=1>
											</td>
											<td style="height:20px;border:1 solid #708090;border-bottom-width:0px;border-top-width:0px;border-right-width:0px;border-left-width:0px;"  colspan=1><nobr>&nbsp;</nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-TOP-width:1px;border-bottom-width:0px;" colspan=1 ><nobr></nobr></td><!-- bgcolor="#B9D4DC" -->
											<td style="height:20px;border:1 solid #708090;border-bottom-width:0px;border-top-width:0px;border-left-width:0px;border-right-width:1px;"  colspan=2>&nbsp;<nobr>
												</nobr></td>
									
											<td style="height:20px;border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;" bgcolor="#B9D4DC" colspan=1><nobr>&nbsp;지급합계</nobr></td>
											<td style="border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;" colspan=2 >
												<comment id="__NSID__"><OBJECT id=gcem_S91000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=Readonly			value=true>
													<param name=enable				value=false>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;" bgcolor="#eeeeee">&nbsp;기본급</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:1px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_P10000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<!-- <param name=Readonly	    value=true> -->
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:1px;" bgcolor="#eeeeee">&nbsp;시간외수당</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;;border-top-width:1px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_P12000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:1px;" bgcolor="#eeeeee">&nbsp;교통비</td>
											<td style="border:1 solid #708090;border-left-width:0px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_P24000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
                      <tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;현장수당</nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_P30000  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;성과급 </nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_P38000  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;북측근무수당</td>
											<td style="border:0 solid #708090;border-right-width:1px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_P31000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
                     </tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;식대</nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_P35000  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;본사,현장,해외</nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
													<comment id="__NSID__"><OBJECT id=gcem_SGUNMU classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"style="position:relative; left:2px;top:0px; width:70px; height:18px;" class=txtbox validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=false>
													<param name=Format	      value="00,  00,  00">
													<param name=MaxLength     value=9>
													<param name=Readonly			value=true>
													<param name=enable				value=false>
													<param name=PromptChar	  value="_">
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:1px;" colspan=2>&nbsp;</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee"><nobr><input id="txt_px01"  type="text" class="txtbox" style="border:1 ;width:85px; height:15px;position:relative;top:2px;left:5px;background-color:#eeeeee" alt="기타지급1">&nbsp;</nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_PX0020 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
												  <!-- <param name=Readonly			value=true> -->
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><input id="txt_px02"  type="text" class="txtbox" style="border:1 ;width:80px; height:15px;position:relative;top:2px;left:5px;background-color:#eeeeee" alt="기타지급2"></nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_PX0030 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><input id="txt_px03"  type="text" class="txtbox" style="border:1 ;width:80px; height:15px;position:relative;top:2px;left:5px;background-color:#eeeeee" alt="기타지급3"></td>
											<td style="border:1 solid #708090;border-left-width:1px;border-top-width:0px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_PX0040 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;전월소급</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_P39000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script> 
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;최종변동일</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_chagdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"style="position:relative; left:2px;top:0px; width:70px; height:20px;" class=txtbox > 
													<param name=Text          value="">
													<param name=Alignment			value=0>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=false>
													<param name=Format	      value="YYYY/MM/DD">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;수습여부</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>	 &nbsp; <comment id="__NSID__"><OBJECT id=gclx_trainyn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:-4px;top:3px;font-size:12px;width:70px;height:120px;">
													<param name=CBData					value="1^수습,2^  ">
													<param name=CBDataColumns		value="Seq,Seqnm">
													<param name=SearchColumn	  value="Seqnm">
													<param name=Sort						value="false">
													<param name=ListExprFormat	value="Seqnm^0^69">								
													<param name=BindColumn			value="Seq">
													</OBJECT></comment><script>__ws__(__NSID__);</script>	
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;지역근무수당</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_P32000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script> 
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;연차수당</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>			<comment id="__NSID__"><OBJECT id=gcem_P34000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script> 
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:0px;"" bgcolor="#eeeeee">&nbsp;자격수당</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_P28000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>

										</tr>
			            
										<tr><td style="height:5px;border:0 solid #708090;" colspan=6></td></tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#B9D4DC" colspan=1><nobr>&nbsp;공제항목</nobr></td>
											<td style="border:0 solid #708090;border-bottom-width:0px;border-right-width:1px;" colspan=2 >&nbsp;</td>
											<td style="height:20px;border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;" bgcolor="#B9D4DC" colspan=1><nobr>&nbsp;공제합계</nobr></td>
											<td style="border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;" colspan=2 >
												<comment id="__NSID__"><OBJECT id=gcem_S93000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=enable				value=false>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;" bgcolor="#B9D4DC" colspan=1><nobr>&nbsp;실지급액</nobr></td>
											<td style="border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_S94000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=enable				value=false>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;" bgcolor="#eeeeee">&nbsp;갑근세</td>
											<td style="border:1 solid #708090;border-left-width:0px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_T11000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:1 solid #708090;border-left-width:0px;" bgcolor="#eeeeee">&nbsp;주민세</td>
											<td style="border:1 solid #708090;border-left-width:0px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_T12000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:1 solid #708090;border-left-width:0px;" bgcolor="#eeeeee">&nbsp;건강보험</td>
											<td style="border:1 solid #708090;border-left-width:0px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_B11000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;국민연금</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_B12000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;고용보험</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_B13000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;산재보험</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_B17000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>										
										<tr>
											<td style="height:20px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><input id="txt_pb01"  type="text" class="txtbox" style="border:1 ;width:80px; height:15px;position:relative;top:2px;left:5px;background-color:#eeeeee" alt="기타공제1"></nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_BX0020 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><input id="txt_pb02"  type="text" class="txtbox" style="border:1 ;width:80px; height:15px;position:relative;top:2px;left:5px;background-color:#eeeeee" alt="기타공제2"></nobr></td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_BX0030 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:1 solid #708090;border-top-width:0px;border-left-width:0px;" bgcolor="#eeeeee"><nobr><input id="txt_pb03"  type="text" class="txtbox" style="border:1 ;width:80px; height:15px;position:relative;top:2px;left:5px;background-color:#eeeeee" alt="기타공제3"></nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_BX0040 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;정산연금</nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_P43000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;정산건강</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_P41000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="height:20px;border:1 solid #708090;border-left-width:0px;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;정산고용</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_P42000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
										<tr>
											<td style="height:20px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;정산소득</nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_T21000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;정산주민</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_T22000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;공조회비</td>
											<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_B16000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
																			<tr>
											<td style="height:20px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;보증보험</nobr></td>
											<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
												<comment id="__NSID__"><OBJECT id=gcem_BX0010 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
													<param name=Text          value="">
													<param name=Alignment			value=2>
													<param name=Border	      value=true>
													<param name=ClipMode			value=true>
													<param name=Numeric	      value=true>
													<param name=Format	      value="000,000,000">
													<param name=MaxLength     value=9>
													<param name=PromptChar	  value="_">
													<param name=IsComma	      value=true>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
																				
										</tr>
										
										<tr>
											<td height="90%">&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<!-------------------------------------------------------------------------------------------
   ▣ 데이타바인드 정의부분
-------------------------------------------------------------------------------------------->
<comment id="__NSID__"><OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"				VALUE="gcds_grid_ec01az">
	<PARAM NAME="ActiveBind"		VALUE="true">
	<PARAM NAME="BindInfo"			VALUE="
		<C>Col=APPDT			Ctrl=gcem_APPDT			Param=Text</C>	
		<C>Col=EMPNO			Ctrl=txt_empno			Param=value</C>	
		<C>Col=EMPNMK			Ctrl=txt_EMPNMK			Param=value</C> 
		<C>Col=NOTWRK			Ctrl=txt_NOTWRK			Param=value</C> 
		<C>Col=PAYDIV			Ctrl=txt_PAYDIV			Param=value</C>	
		<C>Col=DEPTCD			Ctrl=txt_DEPTCD			Param=value</C>	
		<C>Col=DEPTNM			Ctrl=txt_DEPTNM			Param=value</C>	
		<C>Col=PAYGRDNM		Ctrl=txt_PAYGRDNM		Param=value</C>	
		<C>Col=GRDDIVNM		Ctrl=txt_GRDDIVNM		Param=value</C>	
		<C>Col=PAYSEQNM		Ctrl=txt_PAYSEQNM		Param=value</C>	
		<C>Col=PAYBNKNM		Ctrl=txt_PAYBNKNM		Param=value</C>	
		<C>Col=PAYNUM			Ctrl=txt_PAYNUM			Param=value</C>	
		<C>Col=PAYDT			Ctrl=gcem_PAYDT			Param=Text</C> 
		<C>Col=DUYNOT			Ctrl=txt_DUYNOT			Param=value</C>	
		<C>Col=P10000			Ctrl=gcem_P10000		Param=Text</C>
		<C>Col=P11000			Ctrl=gcem_P11000		Param=Text</C>
		<C>Col=P12000			Ctrl=gcem_P12000		Param=Text</C>
		<C>Col=P21000			Ctrl=gcem_P21000		Param=Text</C>
		<C>Col=P22000			Ctrl=gcem_P22000		Param=Text</C>
		<C>Col=P23000			Ctrl=gcem_P23000		Param=Text</C>
		<C>Col=P24000			Ctrl=gcem_P24000		Param=Text</C>
		<C>Col=P25000			Ctrl=gcem_P25000		Param=Text</C>
		<C>Col=P26000			Ctrl=gcem_P26000		Param=Text</C>
		<C>Col=P27000			Ctrl=gcem_P27000		Param=Text</C>
		<C>Col=P28000			Ctrl=gcem_P28000		Param=Text</C>
		<C>Col=P29000			Ctrl=gcem_P29000		Param=Text</C>
		<C>Col=P30000			Ctrl=gcem_P30000		Param=Text</C>
		<C>Col=P31000			Ctrl=gcem_P31000		Param=Text</C>
		<C>Col=P32000			Ctrl=gcem_P32000		Param=Text</C>
		<C>Col=P36000			Ctrl=gcem_P36000		Param=Text</C>
		<C>Col=P37000			Ctrl=gcem_P37000		Param=Text</C>
		<C>Col=P38000			Ctrl=gcem_P38000		Param=Text</C>
		<C>Col=PX0010			Ctrl=gcem_PX0010		Param=Text</C>
		<C>Col=PX0020			Ctrl=gcem_PX0020		Param=Text</C>
		<C>Col=PX0030			Ctrl=gcem_PX0030		Param=Text</C>
		<C>Col=PX0040			Ctrl=gcem_PX0040		Param=Text</C>
		<C>Col=P34000	    Ctrl=gcem_P34000		Param=Text</C>	 
		<C>Col=P39000	    Ctrl=gcem_P39000		Param=Text</C>	 
		
		<C>Col=S91000			Ctrl=gcem_S91000		Param=Text</C>

		<C>Col=T11000			Ctrl=gcem_T11000		Param=Text</C>
		<C>Col=T12000			Ctrl=gcem_T12000		Param=Text</C>
		<C>Col=B11000			Ctrl=gcem_B11000		Param=Text</C>
		<C>Col=B12000			Ctrl=gcem_B12000		Param=Text</C>
		<C>Col=B13000			Ctrl=gcem_B13000		Param=Text</C>
		<C>Col=B15000			Ctrl=gcem_B15000		Param=Text</C>
		<C>Col=B14000			Ctrl=gcem_B14000		Param=Text</C>
		<C>Col=B16000			Ctrl=gcem_B16000		Param=Text</C>
		<C>Col=BX0010			Ctrl=gcem_BX0010		Param=Text</C>
		<C>Col=BX0020			Ctrl=gcem_BX0020		Param=Text</C>
		<C>Col=BX0030			Ctrl=gcem_BX0030		Param=Text</C>
		<C>Col=BX0040			Ctrl=gcem_BX0040		Param=Text</C>

		<C>Col=P41000			Ctrl=gcem_P41000		Param=Text</C>	 
		<C>Col=P42000			Ctrl=gcem_P42000		Param=Text</C>	 
		<C>Col=T21000			Ctrl=gcem_T21000		Param=Text</C>	 
		<C>Col=T22000			Ctrl=gcem_T22000		Param=Text</C>	 

		<C>Col=S93000			Ctrl=gcem_S93000		Param=Text</C>
		<C>Col=S94000			Ctrl=gcem_S94000		Param=Text</C>

		<C>Col=STRTDT			Ctrl=gcem_strtdt		Param=text</C>	
		<C>Col=ENDDT			Ctrl=gcem_enddt			Param=text</C>	
		<C>Col=PAYDT			Ctrl=gcem_paydt1		Param=Text</C>
		<C>Col=JOBGRPHNM  Ctrl=txt_JOBGRPHNM	Param=value</C>	
		<C>Col=P35000			Ctrl=gcem_P35000		Param=Text</C>

		<C>Col=B17000			Ctrl=gcem_B17000		Param=Text</C>
		<C>Col=P43000			Ctrl=gcem_P43000		Param=Text</C>

		<C>Col=PR0020			Ctrl=txt_px01				Param=value</C>
		<C>Col=PR0030			Ctrl=txt_px02				Param=value</C>
		<C>Col=PR0040			Ctrl=txt_px03				Param=value</C>

		<C>Col=BR0020			Ctrl=txt_pb01				Param=value</C>
		<C>Col=BR0030			Ctrl=txt_pb02				Param=value</C>
		<C>Col=BR0040			Ctrl=txt_pb03				Param=value</C>

		<C>Col=CHAGDT			Ctrl=gcem_chagdt		Param=Text</C>
		<C>Col=TRAINYN  	Ctrl=gclx_trainyn		Param=BindColVal</C>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>