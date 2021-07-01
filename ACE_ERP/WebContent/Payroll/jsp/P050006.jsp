<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	급여/각종수당입력
+ 프로그램 ID	: p050006.HTML
+ 기 능 정 의	: 조회|등록|저장|삭제
+ 변 경 이 력	: 
+ 수 정 이 력	: 이순미 - 2005.08.05 - 소스 정리
+ 서 블 릿 명	: p050006_s1, p050006_t1
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>각종수당입력</title>
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
//get_cookdata();
var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
var gs_date2 = gcurdate.substr(0,4)+  gcurdate.substr(5,2);
var gs_status =1;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	gcem_yymm_search.Text=gs_date2;          //기준년월
	
	//수당구분
	gcds_select_ec03az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1777"; 
	gcds_select_ec03az.Reset();

	txt_empnmk_1.disabled=true;
	img_1.disabled=true;
	gcem_FRDT.Enable=false;
	gclx_select_ec03az.Enable=false;

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	
	var str1 = fn_trim(gcem_yymm_search.Text);					//기준년월
	var str2 = fn_trim(txt_empnmk_search.value);        //성명
	gcds_grid_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050006_s1?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2;
	gcds_grid_ec01az.Reset(); //그리드
	gcds_grid_ec01az.rowposition=1;

}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Insert(){   
  if(gcds_grid_ec01az.countRow==0)   {
	var THeader = "DEPTNM:String(50),"	
						+"EMPNO:String(7),"   
						+"EMPNMK:String(20),"   
						+"ALLOWGB:String(4),"	
						+"ALLOWGBNM:String(30),"	
						+"FRDT:String(6),"	
						+"TODT:String(6),"	
						+"DEPTCD:String(4),"	
						+"ALLOWAMT:Decimal(9),"	
						+"ETC:String(30)";

		gcds_grid_ec01az.DataID = "";
		gcds_grid_ec01az.SetDataHeader(THeader);
	}	
	gcds_grid_ec01az.addRow();

	txt_empnmk_1.disabled=false;
	img_1.disabled=false;
	gclx_select_ec03az.Enable=true;
	gcem_FRDT.Enable=true;

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
	if (gcds_grid_ec01az.IsUpdated) {
		if (confirm("변경된 정보를 저장하시겠습니까?")) {
			gctr_grade1.KeyValue = "p050006_t1(I:USER=gcds_grid_ec01az)";
			gctr_grade1.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050006_t1";
			gctr_grade1.post();
			ln_Query();
		}
	}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Del(){
	if (gcds_grid_ec01az.countrow >0) {
		if (confirm("선택한 정보를 삭제하시겠습니까?")){
			gcds_grid_ec01az.deleterow(gcds_grid_ec01az.rowposition);
			gctr_grade1.KeyValue = "p050006_t1(I:USER=gcds_grid_ec01az)";
			gctr_grade1.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050006_t1";
      gctr_grade1.post();
			ln_Query();
		}
	}
}

/******************************************************************************
	Description : 사원조회
******************************************************************************/
function ln_FindEmp(e,e2){
	if(e2=='2')	{   
		var str1=fn_trim(gcem_emo_1.Text);
		gcds_select_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040001_s1?"
										 + "v_str1=" + str1;
		gcds_select_ec01az.Reset();
	}	else	{
	var arrResult	= new Array();
	var arrSend	= new Array();
			arrSend[0]='P040001';
	window.dialogArguments=arrSend[0];
	var strURL;	
	var strPos;
			strURL = "./H030003_popup.jsp"
	//strURL = "P040001_popup.html"
	strPos = "dialogWidth:377px;dialogHeight:363px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrSend,strPos);
	
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_emo_1.Text = arrParam[0];     // 사번
			txt_empnmk_1.value = arrParam[1];    //성명
			hid_deptnm_1.value = arrParam[3];  //소속명
			hid_deptcd_1.value = arrParam[2];  //소속코드
			gclx_select_ec03az.Focus();
		} else {
			gcem_emo_1.Text = "";     // 사번R
			txt_empnmk_1.value = "";    //성명
			hid_deptnm_1.value = "";  //소속명
			hid_deptcd_1.value = "";  //소속코드
			gclx_select_ec03az.Focus();
		}
	}
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_visible_hidden(Obj){
	if(Obj=="gcgd_create")	{
		document.all.gcgd_create.style.display="block";
		document.all.div_create.style.display="block";
		document.all.gcgd_select.style.display="none";
		document.all.div_select.style.display="none";
	}	else	{
        document.all.gcgd_create.style.display="none";
		document.all.div_create.style.display="none";
		document.all.gcgd_select.style.display="block";
		document.all.div_select.style.display="block";
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcds_select_ec02az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_select_ec03az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_grid_ec01az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_pyo" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE">
</object></comment><script>__ws__(__NSID__);</script>

<!------------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------->
<comment id="__NSID__"><OBJECT id="gctr_grade1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--공통하위코드 TR-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<script language="javascript" for="gcds_select_ec03az" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_ec03az" event="onloadCompleted(row,colid)">
	gcds_select_ec03az.InsertRow(1);
	gcds_select_ec03az.NameValue(1,"MINORCD")="";
	gcds_select_ec03az.NameValue(1,"MINORNM")="";
	gclx_select_ec03az.index=0;
	//document.all.LowerFrame.style.visibility="hidden";
	window.status="데이타 조회가 완료되었습니다.";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	if(gcds_grid_ec01az.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>

<script language=JavaScript for=gcem_emo_1 event=OnSetFocus()>
	//gcem_ALLOWAMT.Focus();
	if(gs_status==2)
	alert("사번은 찾기 버튼을 선택해서 입력하세요")
	//ln_FindEmp('1','1');
</script>

<script language="javascript" for="gcds_grid_ec01az" event="OnRowPosChanged(row)">
	if(gcds_grid_ec01az.rowStatus(row) ==1)	{
		gs_status =2;
		txt_empnmk_1.disabled=false;
		img_1.disabled=false;
		gclx_select_ec03az.Enable=true;
		gcem_FRDT.Enable=true;
	}	else	{
		gs_status =1;
		txt_empnmk_1.disabled=true;
		img_1.disabled=true;
		gclx_select_ec03az.Enable=false;
		gcem_FRDT.Enable=false;
	}
</script>

<script language=JavaScript for= gclx_select_ec03az event=OnSelChange()>
	gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"ALLOWGBNM")=gclx_select_ec03az.Text;
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_grade1" event="OnSuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	//ln_Query();
</script>

<script language="javascript" for="gctr_grade1" event="OnFail()">
	alert("중복된 데이타 입력으로 에러가 발생했습니다.");
</script>

</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td  background="../../Common/img/com_t_bg.gif"><img src="../img/p050007_head.gif"></td>
    <td  align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			<img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Del()">
			<img src="../../Common/img/btn/com_b_insert.gif" style="cursor:hand" onclick="ln_Insert()" >
			<img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
	<table  cellpadding="1" cellspacing="0" border="0" style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
    <tr> 
			<td width="10" style="border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee"><nobr>&nbsp;기준년월&nbsp;</nobr></td>
			<td style="border:0 solid #708090;border-right-width:1px;"><nobr>
				<comment id="__NSID__"><object id=gcem_yymm_search classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1  validFeatures="ignoreStatus=yes" validExp="">
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
				</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
			</td>  
			<td width="10" style="border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee"><nobr>&nbsp;성명&nbsp;</nobr></td>
			<td><nobr><INPUT id="txt_empnmk_search" class="txt21" TYPE=TEXT STYLE="width:80px;" onkeydown="if(event.keyCode==13) ln_Query();">&nbsp;</nobr></td> 
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
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create style="WIDTH: 613px; HEIGHT: 400px;border:1 solid #777777;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_grid_ec01az">
							<PARAM NAME="Editable"		VALUE="False">
							<PARAM NAME="ColSizing"		VALUE="True">
							<PARAM NAME="BorderStyle" VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<param name="Sortview"		VALUE="left">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='사번'			ID=EMPNO  		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=center		sort=true</C> 
								<C> Name='성명'			ID=EMPNMK 		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center		sort=true</C> 
								<C> Name='소속'			ID=DEPTNM  		HeadAlign=Center HeadBgColor=#B9D4DC Width=140  align=LEFT			sort=true</C> 
								<C> Name='수당구분' ID=ALLOWGBNM  HeadAlign=Center HeadBgColor=#B9D4DC Width=112  align=LEFT			sort=true</C> 
								<C> Name='시작년월' ID=FRDT  			HeadAlign=Center HeadBgColor=#B9D4DC Width=70		Mask='XXXX/XX'	sort=true	align=center  </C> 
								<C> Name='종료년월' ID=TODT  			HeadAlign=Center HeadBgColor=#B9D4DC Width=70		Mask='XXXX/XX'	sort=true	align=center  </C> 
								<C> Name='수당액'		ID=ALLOWAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=RIGHT			sort=true</C> 
       					">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width: 615px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
						</fieldset>
					</td>
					<td width=3></td>
					<td>
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0 style='width:259px;height:422px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr>
            <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;사번&nbsp;</nobr></td>
            <td  Style="height:23px;border:0 solid #708090;border-bottom-width:1px"><nobr>
							<comment id="__NSID__"><object id=gcem_emo_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative;left:8px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=True>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="0000000">
								<param name=MaxLength     value=13>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Enable  value=false>
								<param name=Readonly  value=true>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
						</td>
						<td style="padding-top:0px;padding-left:0px; border:0 solid #708090;border-bottom-width:1px;"><nobr><img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand" onclick="ln_FindEmp('1','1')" ></nobr></td>
						<td width="100%" Style="border:0 solid #708090;border-bottom-width:1px;padding-top:1px;"><nobr><input id="txt_empnmk_1" name="txt_empnmk_1" type="text" class="txt21" style="width:75px;" maxlength=7 readonly>&nbsp;&nbsp;</nobr></td>						
          </tr>
					<tr>
						<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;수당구분&nbsp;</nobr></td>
						<td colspan=3 style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>
							<comment id="__NSID__"><object id=gclx_select_ec03az  name="gclx_select_ec03az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
								<param name=ComboDataID			value=gcds_select_ec03az>
								<param name=SearchColumn		value="MINORCD^MINORNM">
								<param name=Sort            value="TRUE">
								<param name=SortColumn			value="MINORCD">
								<param name=ListExprFormat	value="MINORNM">
								<param name=BindColumn			value="MINORCD">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
						</td> 
          </tr>
					<tr>
            <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;시작년월&nbsp;</nobr></td>
					  <td colspan=3 style="border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"   ><nobr>
							<comment id="__NSID__"><object id=gcem_FRDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									style="position:relative; left:8px;top:1px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
									validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment	  value=0>
								<param name=Border	      value=True>
								<param name=ClipMode	  value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM">
								<param name=MaxLength     value=6>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td> 
					</tr>					
					<tr>
            <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;종료년월&nbsp;</nobr></td>
					  <td colspan=3 style="border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"   ><nobr>
							<comment id="__NSID__"><object id=gcem_TODT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									style="position:relative; left:8px;top:1px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
									validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment	  value=0>
								<param name=Border	      value=True>
								<param name=ClipMode	  value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM">
								<param name=MaxLength     value=6>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td> 
					</tr>				
					<tr>
						<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;수당액&nbsp;</nobr></td>
						<td colspan=3 style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"   ><nobr>
							<comment id="__NSID__"><object id=gcem_ALLOWAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									style="position:relative; left:8px;top:1px; width:60px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
									validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=True>
								<param name=ClipMode	  value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="9,999,999">
								<param name=MaxLength     value=7>
								<param name=PromptChar	  value="">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td> 
					</tr>	
					<tr>
            <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;</nobr></td>
						<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#ffffff"><nobr></nobr></td> 
          </tr>
          <tr>
            <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;</nobr></td>
						<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#ffffff"><nobr></nobr></td> 
          </tr>
				  <tr>
            <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;</nobr></td>
						<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#ffffff"><nobr></nobr></td> 
          </tr>
          <tr>
            <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;</nobr></td>
						<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#ffffff"><nobr></nobr></td> 
          </tr>
				  <tr>
            <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;</nobr></td>
						<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#ffffff"><nobr></nobr></td> 
          </tr>
				  <tr>
            <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;</nobr></td>
						<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#ffffff"><nobr></nobr></td> 
          </tr>
				  <tr>
            <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;</nobr></td>
						<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#ffffff"><nobr></nobr></td> 
          </tr>
          <tr>
            <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;</nobr></td>
						<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#ffffff"><nobr></nobr></td> 
          </tr>
				</table>
				</td>
			 </tr>
		 </table>
    </td>
  </tr>
</table>

<input type=hidden id=hid_deptnm_1 name=hid_deptnm_1>
<input type=hidden id=hid_deptcd_1 name=hid_deptcd_1>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcbn_grid_ec01az classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_grid_ec01az>
	<param name=BindInfo  value='
		<C>Col=DEPTNM			Ctrl=hid_deptnm_1					Param=value</C>
		<C>Col=EMPNO			Ctrl=gcem_emo_1						Param=Text</C>
		<C>Col=EMPNMK			Ctrl=txt_empnmk_1					Param=value</C>
		<C>Col=ALLOWGB		Ctrl=gclx_select_ec03az   Param=BindColVal</C>
		<C>Col=FRDT				Ctrl=gcem_FRDT						Param=Text</C>
		<C>Col=TODT				Ctrl=gcem_TODT						Param=Text</C>
		<C>Col=ALLOWAMT   Ctrl=gcem_ALLOWAMT				Param=Text</C>
		<C>Col=DEPTCD			Ctrl=hid_deptcd_1					Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	