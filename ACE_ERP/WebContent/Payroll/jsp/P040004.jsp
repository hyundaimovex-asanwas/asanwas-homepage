<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	급여/퇴직금변동자료
+ 프로그램 ID	: p040004.HTML
+ 기 능 정 의	: 조회|저장|삭제
+ 변 경 이 력	: 
+ 수 정 이 력	: 이순미 - 2005.08.03 - 소스 정리
+ 서 블 릿 명	: p040004_s1, p040004_s2, p040004_t1
------------------------------------------------------------------------------>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>퇴직금변동자료</title>


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
var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
var gs_date2 = gcurdate.substr(0,4)+ "/" + gcurdate.substr(5,2)+ "/" + gcurdate.substr(8,2);

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	window.status="";
	var mon = [31,28,31,30,31,30,31,31,30,31,30,31];
	var y, m;
	today=new Date();
	y=today.getFullYear();
	m=today.getMonth();

	var today;
	day = new Date(y,m,1);	
	year = y;
	// 윤년이면 2월 날수를 29로...
	if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
		mon[1] = 29;
	else
		mon[1] = 28;
	gcem_jigub11.Text=gs_date.substr(0,6)+"01";
  gcem_jigub12.Text=gs_date.substr(0,6)+mon[m];

	gcem_BASAMT_SUM.Text= "";//급여합계
	gcem_BASBUS_SUM.Text= "";//상여합계
	gcem_BAEAMT_SUM.Text= "";//기타수당합계

}

/******************************************************************************
	Description : 기본조회
******************************************************************************/
function ln_Query(){

	var str1 = fn_trim(gcem_jigub11.Text);
	var str2 = fn_trim(gcem_jigub12.Text);
	var str3 = fn_trim(txt_empnm_search.value);

	gcds_grid_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040004_s1?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3;
	gcds_grid_ec01az.Reset(); 
	gcds_grid_ec01az.rowposition=1;

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save() {
	if (gcds_grid_ec01az.IsUpdated ) {
		if (confirm("퇴직급여변경사항을 저장하시겠습니까 ?"))	{
		  ln_DataSave();
			gctr_data.KeyValue = "Payroll.p040004_t1(I:USER=gcds_grid_ec01az)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040004_t1";
			gctr_data.post();
		}
	} 
}

/******************************************************************************
	Description : 데이타 저장
******************************************************************************/
function ln_DataSave() {
	gcem_S93000.text = Number(gcem_T21000.text)+Number(gcem_T22000.text)+Number(gcem_P43000.text)+Number(gcem_P41000.text)+
                     Number(gcem_P42000.text)+Number(gcem_T23000.text)+Number(gcem_T24000.text)+Number(gcem_BX0010.text)+
                     Number(gcem_BX0020.text)+Number(gcem_BX0030.text)+Number(gcem_BX0040.text)+Number(gcem_RETJUH.text);

	gcem_S91000.text = Number(gcem_JUSPAY.text) +Number(gcem_JUSYER.text)+ Number(gcem_JUSRET.text) + Number(gcem_JUSBOS.text);

	gcem_S94000.text = Number(gcem_S91000.text) - Number(gcem_S93000.text);

  ln_DataResave(gcds_grid_ec01az.rowposition);
 
}


/******************************************************************************
	Description : 저장시 데이타 반영
******************************************************************************/
function ln_DataResave(row){

		gcem_BASAMT_SUM.Text= //급여합계
		gcds_grid_ec01az.NameValue(row,"BASAMT1")+
		gcds_grid_ec01az.NameValue(row,"BASAMT2")+
		gcds_grid_ec01az.NameValue(row,"BASAMT3")+
		gcds_grid_ec01az.NameValue(row,"BASAMT4");

		gcem_BASBUS_SUM.Text= //상여합계
		gcds_grid_ec01az.NameValue(row,"BASBUS1")+
		gcds_grid_ec01az.NameValue(row,"BASBUS2")+
		gcds_grid_ec01az.NameValue(row,"BASBUS3")+
		gcds_grid_ec01az.NameValue(row,"BASBUS4");

		gcem_BAEAMT_SUM.Text= //기타수당합계
		gcds_grid_ec01az.NameValue(row,"BAEAMT1")+
		gcds_grid_ec01az.NameValue(row,"BAEAMT2")+
		gcds_grid_ec01az.NameValue(row,"BAEAMT3")+
		gcds_grid_ec01az.NameValue(row,"BAEAMT4")+
		gcds_grid_ec01az.NameValue(row,"AVGYER");

		var str_baeday11 = gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"BAEDAY1");
		var str_baeday22 = gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"BAEDAY2");
		var str_baeday33 = gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"BAEDAY3");
		var str_baeday44 = gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"BAEDAY4");
		var str_bdaysum2 = str_baeday11+str_baeday22+str_baeday33+str_baeday44;
		var str_bamtsum2 = gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"BAEAMT1")
									+gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"BAEAMT2")
									+gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"BAEAMT3")
									+gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"BAEAMT4")
									+gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"AVGYER");

	 gcem_AVGETC.Text = Math.round((str_bamtsum2/str_bdaysum2)*30);		//기타평균 AVGETC

	 gcem_AVGAMT.Text = //기본급 평균
	 Math.round((gcds_grid_ec01az.NameValue(row,"BASAMT1")+
	 gcds_grid_ec01az.NameValue(row,"BASAMT2")+
	 gcds_grid_ec01az.NameValue(row,"BASAMT3")+
	 gcds_grid_ec01az.NameValue(row,"BASAMT4"))/3);

	 gcem_AVGBOS.Text = //상여금 평균
	 Math.round((gcds_grid_ec01az.NameValue(row,"BASBUS1")+
	 gcds_grid_ec01az.NameValue(row,"BASBUS2")+
	 gcds_grid_ec01az.NameValue(row,"BASBUS3")+
	 gcds_grid_ec01az.NameValue(row,"BASBUS4"))/12);

		var row1 = gcds_grid_ec01az.rowposition;
		if (gcds_grid_ec01az.namevalue(row1,"BAEDAY1") == gcds_grid_ec01az.namevalue(row1,"BASMAX1")) {
			gcds_grid_ec01az.namevalue(row1,"BAEDAY1") = gcds_grid_ec01az.namevalue(row1,"BAEDAY1")-1;
			gcds_grid_ec01az.namevalue(row1,"BASDAY1") = gcds_grid_ec01az.namevalue(row1,"BASDAY1")-1;
			
			gcds_grid_ec01az.namevalue(row1,"BAEDAY4") = gcds_grid_ec01az.namevalue(row1,"BAEDAY4")+1;
			gcds_grid_ec01az.namevalue(row1,"BASDAY4") = gcds_grid_ec01az.namevalue(row1,"BASDAY4")+1;
		}


}


/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Del(){

	if(gcds_grid_ec01az.countRow !=0)	{
		if (confirm("선택된 퇴직자급여사항을 삭제하시겠습니까 ?")) {
			gcem_BASAMT_SUM.Text= "";//급여합계
			gcem_BASBUS_SUM.Text= "";//상여합계
			gcem_BAEAMT_SUM.Text= "";//기타수당합계

			gcds_grid_ec01az.deleteRow(gcds_grid_ec01az.rowposition); //그리드
			gctr_data.KeyValue = "Payroll.p040004_t1(I:USER=gcds_grid_ec01az)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040004_t1";

			gctr_data.post();
		}
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_select_ec02az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--소속구분 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--소속그리드 기본사항조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_grid_ec01az" event="OnLoadStarted()">
	gcem_BASAMT_SUM.Text= "";//급여합계
	gcem_BASBUS_SUM.Text= "";//상여합계
	gcem_BAEAMT_SUM.Text= "";//기타수당합계
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

<script language="javascript" for="gcds_grid_ec02az" event="OnLoadStarted()">
	ft_cnt1.innerText="추계 퇴직금데이타 조회중입니다.";
	window.status="추계 퇴직금데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript for=gcds_grid_ec01az event=OnRowPosChanged(row)>
	if(row >0) {
	 ln_DataResave(row);
	}
</script>
 
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="OnSuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	//ln_Query();
</script>
<script language="javascript" for="gctr_data" event="onerror()">
	alert("요청하신 작업을 성공적으로 수행하지 못했습니다.");
</script>

</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
			B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td  background="../../Common/img/com_t_bg.gif"><img src="../img/p040004_head.gif"></td>
    <td  align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			 <img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Del()">
			 <img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			 <img src="../../Common/img/btn/com_b_query.gif"	style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
	<table  cellpadding="0" cellspacing="0" border="0"      
	   style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
    <tr> 
			<td width="10" style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
				<nobr>&nbsp;기준일자&nbsp;</nobr></td>
			<TD style="border:0 solid #708090;border-right-width:1px;"><nobr>
    <table cellpadding=0 cellspacing=0><tr><td><nobr>&nbsp;
			<comment id="__NSID__"><object id=gcem_jigub11 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:2px;top:1px; width:67px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
				<param name=Text          value="">
				<param name=Alignment			value=0>
				<param name=Border	      value=True>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=false>
				<param name=Format	      value="YYYY/MM/DD">
				<param name=MaxLength     value=8>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=false>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_jigub11', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"></nobr></td><td>~</td>
		<td><nobr>
			<comment id="__NSID__"><object id=gcem_jigub12 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:67px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
				<param name=Text          value="">
				<param name=Alignment			value=0>
				<param name=Border	      value=True>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=false>
				<param name=Format	      value="YYYY/MM/DD">
				<param name=MaxLength     value=8>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=false>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_jigub12', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">&nbsp;&nbsp;</nobr></td></tr></table></nobr></TD>
    <td style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee">
			<nobr>&nbsp;성명&nbsp;</nobr></td>
		<td style="height:20px; border:0 solid #708090;border-right-width:0px;border-bottom-width:0px" bgcolor="#ffffff"><nobr><input id=txt_empnm_search name=txt_empnm_search type=text class="txt21" size=10 onkeydown="if(event.keyCode==13) ln_Query();">&nbsp;</nobr></td> 
    <td width="100%" style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;</nobr></td>  
	</tr>
</table>		
		</td>
	</tr>
	<tr><td height=3></td></tr>  
  <tr> 
    <td colspan=2 valign=top> 
      <table width="876" cellpadding="0" cellspacing="0" border="0">
        <tr> 
		   <td valign=top>
		<table cellpadding="0" cellspacing="0" border="0">
		  <tr>
			  <td colspan=2>
					<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create style="WIDTH: 280px; HEIGHT: 276px;border:1 solid #777777;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_grid_ec01az">
						<PARAM NAME="Editable"		VALUE="false">
						<PARAM NAME="ColSizing"		VALUE="true">
            <PARAM NAME="BorderStyle" VALUE="0">
			      <PARAM NAME="Fillarea"		VALUE="true">
			      <PARAM NAME="Format"			VALUE="  
              <C> Name='소속' ID=DEPTNM   HeadAlign=Center HeadBgColor=#B9D4DC Width=80 </C>
							<C> Name='성명' ID=EMPNMK HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center   </C>
							<C> Name='사번' ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50   align=center </C> 
							<C> Name='퇴사일' ID=ENDDT HeadAlign=Center HeadBgColor=#B9D4DC Width=65 align=center Mask='XXXX/XX/XX' </C>							
						">
				  </OBJECT></comment><script>__ws__(__NSID__);</script>
		    </td>
			</tr>
			<tr><td height=3></td></tr>
			<tr>
				<td colspan=2>
		<table width="282" height="482" border= "0" cellpadding=0 cellspacing=0  border=0 style=' height:28px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'> 
			<tr>
        <td style="height:20px; width:40px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;퇴직사유&nbsp;</nobr></td>
				<td style="height:20px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr><input id="txt_ref" type="text" class=txt21 style="width:200px;"></nobr></td> 
      </tr>
			<tr>
        <td style="height:20px; width:40px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;사번/성명&nbsp;</nobr></td>
				<td style="height:20px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr><INPUT id=txt_empno TYPE=TEXT STYLE="width:60px;" class="txt21" readonly  >&nbsp;&nbsp;&nbsp;/&nbsp;<INPUT TYPE=TEXT STYLE="width:70px; "  id=txt_empnmk class="txt21" readonly  ></nobr></td> 
      </tr>
			<tr>
				<td style="height:25px; width:40px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;소속/직위&nbsp;</nobr></td>
				<td style="width=30px; height:20px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr><INPUT TYPE=TEXT STYLE="width:100px; "  id=txt_DEPTNM class="txt21"  readonly  >&nbsp;&nbsp;/<INPUT TYPE=TEXT STYLE="width:70px; "  id=txt_PAYGRDNM class="txt21" readonly  ></nobr></td> 
			</tr>
			<tr>
				<td style="height:25px; width:40px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;입/퇴사일&nbsp;</nobr></td>
				<TD style="border:0 solid #708090;border-bottom-width:1px; border-right-width:0px;"><nobr>
			<table cellspacing=0 cellpadding=0 border=0><tr><td>&nbsp;
				<comment id="__NSID__"><object id=gcem_STRTDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=0>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=MaxLength     value=8>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script>&nbsp;
			</td>
			<td style="padding-top:4px;">/</td>
			<td>&nbsp;
				<comment id="__NSID__"><object id=gcem_ENDDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=0>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=MaxLength     value=8>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script>
			</td>
		</tr>
	</table></nobr>
				</TD>
			</tr>
			<tr>
				<td  style="height:23px; width:60px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;근무기간&nbsp;</nobr></td>
				<td  width="100%" style="height:20px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr><INPUT TYPE=TEXT STYLE="width:20px; padding-top:4px;text-align:right;" id=txt_DUYEAR class="txt21" readonly  >&nbsp;&nbsp;년<INPUT TYPE=TEXT STYLE="width:20px;  padding-top:4px;text-align:right;" id=txt_DUYMM class="txt21" readonly  >&nbsp;&nbsp;개월<INPUT TYPE=hidden STYLE="width:20px; padding-top:4px ;text-align:right;" id=txt_DUDAY class="txt21" readonly  >&nbsp;&nbsp;<!-- 일 -->&nbsp;</nobr></td> 
			</tr>	
			<tr>
        <td  style="height:23px; width:60px; border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee"><nobr>&nbsp;주소&nbsp;</nobr></td>
				<td  width="100%" style="height:20px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px" bgcolor="#ffffff"><nobr><INPUT TYPE=TEXT STYLE="width:200px; " id=txt_CADDR01 class="txt21" readonly  >&nbsp;</nobr></td> 
      </tr>	
		</table>
		<fieldset style="width:282;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
			<font id=ft_cnt1 style="position:relative;top:4px;"></font>
		</fieldset>
				</td>
			</tr>
		</table>
			</td>
		  <td width=3>
		  </td>
		  <td valign=top>
<div id=div_jikwon style="display:block;">
		<table width="591" border= "0" cellpadding=0 cellspacing=0 style='height:28px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
			<tr>
				<TD colspan=10 align="left" style="height:20px; border:0 solid #708090;border-right-width:0px; border-bottom-width:1px" bgcolor="#eeeeee">
					<nobr>&nbsp;1.퇴직금계산내역&nbsp;</nobr>
				</TD> 						
			</tr>   
			<tr>
				<TD colspan=4 align="center" style="height:20px; border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;기본급+직책수당+시간외수당&nbsp;</nobr></TD> 
				<TD colspan=2 align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;상여금ㆍ년차수당&nbsp;</nobr></TD> 
				<TD colspan=4 align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;기타 수당&nbsp;</nobr></TD> 
			</tr>   
			<tr>
				<td align=center style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:50px;text-align:center"  id=txt_BASDAY1  readonly ></nobr></td>
				<td align=center  style="  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:50px;text-align:center"  id=txt_BASMAX1  readonly  ></nobr></td>
				<td align=center style=" width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>1st월</nobr></td>
				<TD align=center width=90 align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
					<comment id="__NSID__"><object id=gcem_BASAMT1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
						<param name=Text          value="">
						<param name=Alignment	  value=2>
						<param name=Border	      value=true>
						<param name=ClipMode	  value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=11>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</TD> 
				<td align=center style=" width:100px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">
					<nobr><input type=text id=txt_ref1 class=txtbox style="border:0px;width:70px;text-align:center;background-color:#eeeeee"></nobr></td>
				<TD align="center" width=90 style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>	
					<comment id="__NSID__"><object id=gcem_BASBUS1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
						<param name=Text          value="">
						<param name=Alignment	  value=2>
						<param name=Border	      value=true>
						<param name=ClipMode	  value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=11>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</TD> 
				<td  align=center style="  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEDAY1  readonly ></nobr></td>
				<td align=center  style="height:20px; width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEMAX1  readonly ></nobr></td>
				<td  align=center style="height:20px; width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>1st월</nobr></td>
				<TD align="center" width=90 style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px"><nobr>
					<comment id="__NSID__"><object id=gcem_BAEAMT1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
						<param name=Text          value="">
						<param name=Alignment	  value=2>
						<param name=Border	      value=true>
						<param name=ClipMode	  value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=11>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</TD> 
			</tr>   
			<tr>
			<td align=center style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BASDAY2  readonly  ></nobr></td>
			<td align=center  style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BASMAX2  readonly  ></nobr></td>
			<TD align=center  style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>2nd월</nobr></td>
			<TD align=center style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><object id=gcem_BASAMT2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=2>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=MaxLength     value=11>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
			<TD align=center  style="height:20px; width:100px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><input type=text id=txt_ref2 class=txtbox style="border:0px;width:70px;text-align:center;background-color:#eeeeee"></nobr></td>
			<TD align=center style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><object id=gcem_BASBUS2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=2>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=MaxLength     value=11>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
			<td align=center style="  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEDAY2  readonly ></nobr></td>
			<td align=center  style="height:20px; width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEMAX2  readonly ></nobr></td>
			<TD align=center  style="height:20px; width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>2nd월</nobr></td>
			<TD align=center  style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><object id=gcem_BAEAMT2  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=2>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=MaxLength     value=11>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
		</tr>   
		<tr>
			<td align=center style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BASDAY3  readonly  ></nobr></td>
			<td align=center  style="  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BASMAX3  readonly  ></nobr></td>
			<TD align=center  style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>3th월</nobr></td>
			<TD align=center style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
				<comment id="__NSID__"><object id=gcem_BASAMT3  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1		validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=2>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=MaxLength     value=11>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
			<TD align=center  style="height:20px; width:100px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><input type=text id=txt_ref3 class=txtbox style="border:0px;width:70px;text-align:center;background-color:#eeeeee"></nobr></td>
			<TD align=center style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_BASBUS3     
				 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=2>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=MaxLength     value=11>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
			<td  align=center style=" width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEDAY3  readonly ></nobr></td>
			<td align=center  style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEMAX3  readonly ></nobr></td>
			<TD align=center  style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>3th월</nobr></td>
			<TD align=center  style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_BAEAMT3                
				 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=2>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=MaxLength     value=11>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
		</tr>   
		<tr>
			<td align=center style="height:22px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BASDAY4  readonly  ></nobr></td>
			<td align=center  style="  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BASMAX4  readonly  ></nobr></td>
			<TD align=center  style="height:20px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>4th월</nobr></td>
			<TD align=center align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_BASAMT4                
				 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=2>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=MaxLength     value=11>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
			<TD align=center  style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><input type=text id=txt_ref4 class=txtbox style="border:0px;width:70px;text-align:center;background-color:#eeeeee"></nobr></td>
			<TD align=center   style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_BASBUS4   
				 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=2>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=MaxLength     value=11>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
			<td  align=center style="  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEDAY4  readonly ></nobr></td>
			<td align=center  style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><INPUT TYPE=TEXT STYLE="font-family:굴림;font-size:9pt;color: #333333;background-color:#eeeeee;border:0px;width:30px;text-align:center"  id=txt_BAEMAX4  readonly ></nobr></td>
			<TD align=center  style="height:20px; width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>4th월</nobr></td>
			<TD align=center  style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_BAEAMT4    
				 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment			value=2>
					<param name=Border	      value=true>
					<param name=ClipMode			value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=MaxLength     value=11>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
		</tr>   
		<tr>
			<td colspan=3 align=center  style="height:22px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>년차일수</nobr></td>
			<TD  align=center style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_YEAQTY                
				 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=2>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=MaxLength     value=11>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
			<td  align=center style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>년차수당</nobr></td>
			<TD  align=center style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_YEAPAY                
				 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=2>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=MaxLength     value=11>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 							 
			<td colspan=3 align=center   style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">평균년차수당</td>
			<TD align=center  style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px">
			<comment id="__NSID__"><object id=gcem_AVGYER                
				 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				 style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " > 
					<param name=Text          value="">
					<param name=Alignment	  value=2>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=MaxLength     value=11>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script>
			</TD> 
		</tr>   
		<tr>
			<TD align=center colspan=3  style="height:22px;border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>합계</nobr></TD> 
			<TD align=center  style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_BASAMT_SUM                 
				 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=2>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=MaxLength     value=11>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
			<TD align=center   style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>합계</nobr></TD> 
			<TD align=center  style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_BASBUS_SUM                
				 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=2>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=MaxLength     value=11>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
			<TD align=center colspan=3  style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>합계</nobr></TD> 
			<TD align=center  style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_BAEAMT_SUM                
				 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=2>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=MaxLength     value=11>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
		</tr>   
		<tr>
			<TD align=center colspan=3  style="height:22px;border:0 solid #708090;border-right-width:1px; border-bottom-width:0px" bgcolor="#eeeeee"><nobr>평균</nobr></TD> 
			<TD align=center  style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr><comment id="__NSID__"><object id=gcem_AVGAMT                 
				 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=2>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=MaxLength     value=11>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
			<TD align=center   style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px" bgcolor="#eeeeee"><nobr>평균</nobr></TD> 
			<TD align=center  style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr><comment id="__NSID__"><object id=gcem_AVGBOS                
				 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=2>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=MaxLength     value=11>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
			<TD align=center colspan=3  style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px" bgcolor="#eeeeee"><nobr>평균</nobr></TD> 
			<TD align=center  style="border:0 solid #708090;border-right-width:0px; border-bottom-width:0px"><nobr><comment id="__NSID__"><object id=gcem_AVGETC                
				 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
							validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Text          value="">
					<param name=Alignment	  value=2>
					<param name=Border	      value=true>
					<param name=ClipMode	  value=true>
					<param name=Numeric	      value=true>
					<param name=Format	      value="000,000,000">
					<param name=MaxLength     value=11>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=true>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</TD> 
		</tr>   		
	</table>
	<table border= "0" cellpadding=0 cellspacing=0><tr><td height=3></td></tr></table>

<!-- 기타수당 -->
<table width="591" border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0 style='height:28px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
	<tr>
		<TD colspan=8 align="left" style="height=22px; border:0 solid #708090;border-right-width:0px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;2.기타수당내역&nbsp;</nobr></TD> 
	</tr>   
	<tr>
		<TD align="center" style=" height:20px;border:0 solid #708090;border-right-width:1px; border-bottom-width:1px;width:81px" bgcolor="#eeeeee"><nobr>근속수당</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px;width:81px" bgcolor="#eeeeee"><nobr>자기계발비</nobr></TD> 
		<td align="center" style="height:20px; width:70px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;width:81px" bgcolor="#eeeeee"><nobr>차량유지비</nobr></td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px;width:81px" bgcolor="#eeeeee"><nobr>남북경협수당</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px;width:81px" bgcolor="#eeeeee"><nobr>임원직책수당</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px;width:81px" bgcolor="#eeeeee"><nobr>연장수당</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px;width:81px" bgcolor="#eeeeee"><nobr>기타</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;&nbsp;</nobr></TD> 
	</tr>   
	<tr>
		<td align="center" style="height:23px; border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" ><nobr>
			<comment id="__NSID__"><object id=gcem_P21000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> <!-- 근속수당 -->
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr><comment id="__NSID__"><object id=gcem_P22000      
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp="">  <!-- 자기계발비 -->
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td align="center"  style=" border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" ><nobr><comment id="__NSID__"><object id=gcem_P24000    
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> <!-- 차량유지비 -->
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr><comment id="__NSID__"><object id=gcem_P29000      
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> <!-- 남북경협수당 -->
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr><comment id="__NSID__"><object id=gcem_P38000      
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> <!-- 임원직책수당 -->
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr><comment id="__NSID__"><object id=gcem_P27000 
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> <!-- 연장수당 -->
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:0px"><nobr><comment id="__NSID__"><object id=gcem_PX0000      
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> <!-- 기타 -->
				<param name=Text          value="">
				<param name=Alignment	  value=2>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<TD  align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:0px"><nobr>&nbsp;&nbsp;</nobr></TD></tr>   	
</table>
<table cellpadding=0 cellspacing=0  border=0><tr><td height=3></td></tr></table>

<!-- 지급내역  -->
<table width="591" border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0 style='height:28px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
	<tr>
		<td colspan=7 align="left" style="height:20px; width:70px; border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;3.퇴직금정산내역&nbsp;</nobr></td>
	</tr>   
	<tr>
		<td align="center"	style="height:20px; width:81px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>급여</nobr></td>
		<TD align="center"	style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>퇴직금</nobr></TD> 
		<TD align="center"	style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>년차수당</nobr></TD> 
		<TD align="center"	style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>상여</nobr></TD> 
		<TD align="center"	style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>지급합계</nobr></TD> 
		<TD  align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>실지급액</nobr></TD> 
		<TD align="center"	style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp&nbsp</nobr></TD> 
	</tr>   
	<tr>
		<td align="center" style="height:23px; border:0 solid #708090;border-right-width:1px;border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_JUSPAY classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_JUSRET                 
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td align="center"  style="  border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" ><nobr>
			<comment id="__NSID__"><object id=gcem_JUSYER                 
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_JUSBOS              
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_S91000                 
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="0,000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td  align="center" style=" border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" ><nobr>
			<comment id="__NSID__"><object id=gcem_S94000
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:0px"><nobr>&nbsp&nbsp</nobr></TD></tr>   	
	</table>
<table cellpadding=0 cellspacing=0 border=0><tr><td height=3></td></tr></table>

<!--4.공제내역-->
<table width="591" border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0 style='height:28px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
	<tr>
		<td colspan=7 align="left" style="height:20px;  border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;4.공제내역&nbsp;</nobr></td>
	</tr>   
	<tr>
		<td align="center" style="height:20px; width:81px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>정산갑근세</nobr></td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>정산주민세</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>정산국민연금</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>정산건강보험</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>정산고용보험</nobr></TD> 
		<TD  align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px; width:81px;" bgcolor="#eeeeee"><nobr>퇴직소득세</nobr></TD> 
		<TD  align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>퇴직주민세</nobr></TD> 
	</tr>   
	<tr>
		<td align="center" style="height:23px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" ><nobr>
			<comment id="__NSID__"><object id=gcem_T21000  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_T22000 
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td align="center" style="height:20px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" ><nobr>
			<comment id="__NSID__"><object id=gcem_P43000                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr></td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_P41000                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">			
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px"><nobr>
			<comment id="__NSID__"><object id=gcem_P42000                 
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="0,000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td  align="center"   style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" ><nobr>
			<comment id="__NSID__"><object id=gcem_T23000                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px"><nobr><comment id="__NSID__"><object id=gcem_T24000                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode		 value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
	</tr>   
	<tr>
		<td align="center" style="height:20px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;기타1&nbsp;</nobr></td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;기타2&nbsp</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;기타3&nbsp</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;기타4&nbsp</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;퇴직전환금&nbsp;</nobr></TD> 
		<TD  align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;&nbsp</nobr></TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;공제합계&nbsp;</nobr></TD> 
	</tr>   
	<tr>
		<td align="center" style="height:23px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" ><nobr>
			<comment id="__NSID__"><object id=gcem_BX0010   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px;right:8px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_BX0020                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td align="center" style="height:20px; border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" ><nobr>
			<comment id="__NSID__"><object id=gcem_BX0030                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<TD align="center" style="border:0 solid #708090; border-right-width:1px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_BX0040                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<TD align="center" style="border:0 solid #708090;border-right-width:1px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_RETJUH                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
		<td  align="center"  style="height:20px;  border:0 solid #708090;border-right-width:1px;border-bottom-width:0px"><nobr>&nbsp;&nbsp;</nobr></td>
		<TD  align="center" style="border:0 solid #708090;border-right-width:0px; border-bottom-width:0px"><nobr>
			<comment id="__NSID__"><object id=gcem_S93000                
			 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1
						validFeatures="ignoreStatus=yes" validExp=""> 
				<param name=Text          value="">
				<param name=Alignment			value=2>
				<param name=Border	      value=true>
				<param name=ClipMode			value=true>
				<param name=Numeric	      value=true>
				<param name=Format	      value="000,000,000">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=true>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script></nobr>
		</TD> 
	</tr>   
</table></div>
		</td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcbn_grid_ec01az classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_grid_ec01az>
	<param name=BindInfo  value='
		<C>Col=APPDT   Ctrl=txt_appdt					Param=value</C>
		<C>Col=EMPNO   Ctrl=txt_empno					Param=value</C>
		<C>Col=EMPDIV  Ctrl=txt_empdiv				Param=value</C>
		<C>Col=EMPNMK  Ctrl=txt_empnmk				Param=value</C>
		<C>Col=DEPTNM  Ctrl=txt_DEPTNM				Param=value</C>
		<C>Col=PAYGRDNM Ctrl=txt_PAYGRDNM			Param=value</C>
		<C>Col=STRTDT  Ctrl=gcem_STRTDT       Param=Text</C>
		<C>Col=ENDDT   Ctrl=gcem_ENDDT				Param=Text</C>
		<C>Col=DUYEAR  Ctrl=txt_DUYEAR				Param=value</C>
		<C>Col=DUYMM   Ctrl=txt_DUYMM					Param=value</C>
		<C>Col=DUDAY   Ctrl=txt_DUDAY					Param=value</C>
		<C>Col=CADDR01 Ctrl=txt_CADDR01       Param=value</C>
		<C>Col=CADDR02 Ctrl=txt_CADDR02       Param=value</C>
		<C>Col=BASDAY1 Ctrl=txt_BASDAY1       Param=value</C>
		<C>Col=BASDAY2 Ctrl=txt_BASDAY2       Param=value</C>
		<C>Col=BASDAY3 Ctrl=txt_BASDAY3       Param=value</C>
		<C>Col=BASDAY4 Ctrl=txt_BASDAY4       Param=value</C>
		<C>Col=BASMAX1 Ctrl=txt_BASMAX1       Param=value</C>
		<C>Col=BASMAX2 Ctrl=txt_BASMAX2       Param=value</C>
		<C>Col=BASMAX3 Ctrl=txt_BASMAX3       Param=value</C>
		<C>Col=BASMAX4 Ctrl=txt_BASMAX4       Param=value</C>
		<C>Col=BASMAX1 Ctrl=txt_BAEMAX1       Param=value</C>
		<C>Col=BASMAX2 Ctrl=txt_BAEMAX2       Param=value</C>
		<C>Col=BASMAX3 Ctrl=txt_BAEMAX3       Param=value</C>
		<C>Col=BASMAX4 Ctrl=txt_BAEMAX4       Param=value</C>
		<C>Col=BASAMT1 Ctrl=gcem_BASAMT1      Param=Text</C>
		<C>Col=BASAMT2 Ctrl=gcem_BASAMT2      Param=Text</C>
		<C>Col=BASAMT3 Ctrl=gcem_BASAMT3      Param=Text</C>
		<C>Col=BASAMT4 Ctrl=gcem_BASAMT4      Param=Text</C>
		<C>Col=BASBUS1 Ctrl=gcem_BASBUS1      Param=Text</C>
		<C>Col=BASBUS2 Ctrl=gcem_BASBUS2      Param=Text</C>
		<C>Col=BASBUS3 Ctrl=gcem_BASBUS3      Param=Text</C>
		<C>Col=BASBUS4 Ctrl=gcem_BASBUS4      Param=Text</C>
		<C>Col=BAEDAY1 Ctrl=txt_BAEDAY1       Param=value</C>
		<C>Col=BAEDAY2 Ctrl=txt_BAEDAY2       Param=value</C>
		<C>Col=BAEDAY3 Ctrl=txt_BAEDAY3				Param=value</C>
		<C>Col=BAEDAY4 Ctrl=txt_BAEDAY4       Param=value</C>
		<C>Col=BAEAMT1 Ctrl=gcem_BAEAMT1      Param=Text</C>
		<C>Col=BAEAMT2 Ctrl=gcem_BAEAMT2      Param=Text</C>
		<C>Col=BAEAMT3 Ctrl=gcem_BAEAMT3      Param=Text</C>
		<C>Col=BAEAMT4 Ctrl=gcem_BAEAMT4      Param=Text</C>
		<C>Col=YEAQTY  Ctrl=gcem_YEAQTY       Param=Text</C>
		<C>Col=YEAPAY  Ctrl=gcem_YEAPAY       Param=Text</C>
		<C>Col=AVGYER  Ctrl=gcem_AVGYER       Param=Text</C>
		<C>Col=AVGAMT  Ctrl=gcem_AVGAMT       Param=Text</C>
		<C>Col=AVGBOS  Ctrl=gcem_AVGBOS       Param=Text</C>
		<C>Col=AVGETC  Ctrl=gcem_AVGETC       Param=Text</C>
		<C>Col=P21000  Ctrl=gcem_P21000       Param=Text</C>
		<C>Col=P22000  Ctrl=gcem_P22000				Param=Text</C>
		<C>Col=P24000  Ctrl=gcem_P24000       Param=Text</C>
		<C>Col=P29000  Ctrl=gcem_P29000       Param=Text</C>
		<C>Col=P38000  Ctrl=gcem_P38000       Param=Text</C>
		<C>Col=P27000  Ctrl=gcem_P27000       Param=Text</C>
		<C>Col=PX0000  Ctrl=gcem_PX0000       Param=Text</C>
		<C>Col=JUSPAY  Ctrl=gcem_JUSPAY       Param=Text</C>
		<C>Col=JUSRET  Ctrl=gcem_JUSRET       Param=Text</C>
		<C>Col=JUSYER  Ctrl=gcem_JUSYER       Param=Text</C>
		<C>Col=JUSBOS  Ctrl=gcem_JUSBOS       Param=Text</C>
		<C>Col=S91000  Ctrl=gcem_S91000       Param=Text</C>
		<C>Col=S94000  Ctrl=gcem_S94000       Param=Text</C>
		<C>Col=T21000  Ctrl=gcem_T21000       Param=Text</C>
		<C>Col=T22000  Ctrl=gcem_T22000       Param=Text</C>
		<C>Col=T23000  Ctrl=gcem_T23000       Param=Text</C>
		<C>Col=T24000  Ctrl=gcem_T24000       Param=Text</C>
		<C>Col=P43000  Ctrl=gcem_P43000       Param=Text</C>
		<C>Col=P41000  Ctrl=gcem_P41000       Param=Text</C>
		<C>Col=P42000  Ctrl=gcem_P42000       Param=Text</C>
		<C>Col=RETJUH  Ctrl=gcem_RETJUH       Param=Text</C>
		<C>Col=BX0010  Ctrl=gcem_BX0010       Param=Text</C>
		<C>Col=BX0020  Ctrl=gcem_BX0020       Param=Text</C>
		<C>Col=BX0030  Ctrl=gcem_BX0030       Param=Text</C>
		<C>Col=BX0040  Ctrl=gcem_BX0040       Param=Text</C>
		<C>Col=S93000  Ctrl=gcem_S93000       Param=Text</C>
		
		<C>Col=REF1		 Ctrl=txt_ref1					Param=value</C>
		<C>Col=REF2		 Ctrl=txt_ref2					Param=value</C>
		<C>Col=REF3		 Ctrl=txt_ref3					Param=value</C>
		<C>Col=REF4		 Ctrl=txt_ref4					Param=value</C>

		<C>Col=REF		 Ctrl=txt_ref						Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>
  
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	