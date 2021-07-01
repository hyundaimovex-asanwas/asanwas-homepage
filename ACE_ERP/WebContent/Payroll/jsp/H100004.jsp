<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	계약직/급여계산작업
+ 프로그램 ID	: H100004
+ 기 능 정 의	: 조회
+ 변 경 이 력	: 
+ 수 정 이 력	: 이순미 - 2005.08.02 - 소스 정리
+ 서 블 릿 명	: h100004_s1, h100004_s2, h100004_t1
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>급여계산작업</title>
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


gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);


/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	
	gcem_ec01af.Text=gs_date2;
	gcem_ec02af.Text=gs_date2+"25";
	gclx_select_ec01az.index=2;
	percent_div.style.display="none";

}

/******************************************************************************
	Description : 기본조회
******************************************************************************/
function ln_Query(){

	var str1 = fn_trim(gcem_ec01af.Text);						//급여년월
	var str2 = gclx_select_ec01az.BindColVal;				//지급구분
	var str3 = fn_trim(gcem_ec02af.Text);						//지급일자

	gcds_data.DataID = "/servlet/Contract.h100004_s2?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2;
	
	gcds_data.Reset();				//그리드
	gcds_data.rowposition=1;

}

/******************************************************************************
	Description : 마감
******************************************************************************/
function ln_Finish(){

	var row = gcds_data.rowposition;
	var str1 = gcem_ec01af.text;
	var str2 = gclx_select_ec01az.BindColVal;

	for(i=1;i<=gcds_data.countrow;i++) {
		if (gcds_data.namevalue(row,"WRKSTS") == 'C') {
			alert("마감처리 되었습니다.");
			return false;
		}else{
			for(i=1;i<=gcds_data.countrow;i++) {
				gcds_data.namevalue(i,"WRKSTS") = 'C';
			}
			if (confirm("정보를 마감 하시겠습니까?")){
				gctr_data.KeyValue = "p020002_t1(I:USER=gcds_data)";
				gctr_data.Action = "/servlet/Contract.h100004_t1?v_str1="+str1+"&v_str2="+str2;
				gctr_data.Post();
				ln_Query();
			}else{
				return false;
			}
		}
	}
}

/******************************************************************************
	Description : 생성
******************************************************************************/
function ln_Create(){

	var row = gcds_data.rowposition;

	for(i=1;i<=gcds_data.countrow;i++) {
		if (gcds_data.namevalue(row,"WRKSTS") == 'C') {
			alert("마감처리 되었습니다.");
			return false;
		}
	}

	var str1 = fn_trim(gcem_ec01af.Text);									//급여년월
	var str2 = fn_trim(gclx_select_ec01az.BindColVal);		//지급구분
	var str3 = fn_trim(gcem_ec02af.Text);									//지급일자
	var str4 = fn_trim(gcem_percent.Text);								//상여율
	
	if(str1.length < 6 ) 	{
		alert("급여년월 6자리를 입력해주세요");
		gcem_ec01af.Focus()
	}else if(str2.length < 1){
		alert("지급구분을 선택해주세요");
		gclx_select_ec01az.Focus()
	}else if(str3.length < 8){
		alert("지급일자 8자리를 입력해주세요");
		gcem_ec02af.Focus()
	//}else if(str2=='5' && fn_trim(gcem_percent.Text)==''){
	//	alert("상여율을 입력하세요");
  //	gcem_percent.Focus();
  } else {
		gcds_data.ClearData();
		var prcedure_gubun="/servlet/Contract.h100004_s1?"
											 + "v_str1=" + str1
											 + "&v_str2=" + str2
											 + "&v_str3=" + str3;
		if(str2=="T") {       //정기급여
			prcedure_gubun+= "&v_str4=SP_T100000";
		}else if(str2=="C"){  //소급급여
				prcedure_gubun+= "&v_str4=SP_T200000";
		}else if(str2=="K"){  //소급급여
				prcedure_gubun+= "&v_str4=SP_T100000";
		}


		gcds_select_create.DataID =prcedure_gubun;
		gcds_select_create.Reset(); //그리드
		gcds_select_create.rowposition=1;
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

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- 지급구분 
<comment id="__NSID__"><OBJECT id=gcds_select_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>-->

<comment id="__NSID__"><OBJECT id=gcds_select_create classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 생성 DataSet-->
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
<!-- <script language="javascript" for="gcds_select_ec01az" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_ec01az" event="onloadCompleted(row,colid)">
	for(i=gcds_select_ec01az.countrow;i>0; i--)  {   
		gcds_select_ec01az.rowposition=i;
		kkk=fn_trim(gcds_select_ec01az.NameValue(gcds_select_ec01az.rowposition,"MINORCD"))+"";
		if((kkk == '3' || kkk == '4') || kkk == '5') {
			gcds_select_ec01az.deleteRow(gcds_select_ec01az.rowposition); //그리드
		}
	}
  gclx_select_ec01az.index=0;
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
</script> -->

<script language="javascript" for="gcds_select_create" event="OnLoadStarted()">
	//ft_cnt1.innerText="데이타 생성중입니다.";
	window.status=gclx_select_ec01az.Text+" 계산중입니다.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_create" event="onloadcompleted(row,colid)">
	//ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status=gclx_select_ec01az.Text+" 급여 계산 프로그램을 완료했습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_select_create.countrow <0) {
			alert("리턴값이 없습니다.");
	}else {
		//if(gcds_select_create.NameValue(1,"RETCOD") == "Y") {
		alert(gclx_select_ec01az.Text+" 급여 계산 프로그램이 정상적으로 구동 되었으니\n조회 버튼을 사용하여 진행상태를 조회하시기 바랍니다.");
		//}else {
		//alert(gclx_select_ec01az.Text+" 급여 계산 프로그램이 정상적으로 구동 되지 않았습니다.");
		//}
	}
	window.status="";
</script>

<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_data.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>

<script language=JavaScript for= "gclx_select_ec01az" event="OnSelChange()">
	var str1 = fn_trim(gclx_select_ec01az.BindColVal);   //지급구분
 if(str1=='5') {
    percent_div.style.display="block";
		gcem_percent.Focus();
 }else{
    percent_div.style.display="none";
 }
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


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/h100004_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<nobr>
			<img src="../../Common/img/btn/com_b_finish.gif" style="cursor:hand" onclick="ln_Finish()">
			<img src="../../Common/img/btn/com_b_create.gif" style="cursor:hand" onclick="ln_Create()">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()" >
			</nobr>&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
		<table  cellpadding="0" cellspacing="0" border="0" style='width:877px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
      <tr> 
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-left:3px;padding-right:3px;" bgcolor="#eeeeee"><nobr>&nbsp;급여년월&nbsp;</nobr></td>	
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-top:2px;"><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_ec01af classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
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
					</OBJECT></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_ec01af', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">&nbsp;</nobr></td>

				<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;지급구분&nbsp;&nbsp;</nobr></td>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;">
				
			<table cellspacing=0 cellpadding=0 border=0 width=0>
				<tr>
					<td align=left><nobr>
						<comment id="__NSID__"><OBJECT id=gclx_select_ec01az  name="gclx_select_ec01az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
							<param name=CBData					value="T^정기급여,C^소급급여,K^특별상여">
							<param name=CBDataColumns		value="MINORCD,MINORNM">
							<param name=SearchColumn		value="MINORCD^MINORNM">
							<param name=Sort            value="TRUE">
							<param name=SortColumn			value="MINORCD">
							<param name=ListExprFormat	value="MINORNM">
							<param name=BindColumn			value="MINORCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</TD>
					<TD>
<div id=percent_div style="display:block;"><nobr>
			<table cellspacing=0 cellpadding=0 border=0 width=0>
				<tr>
					<td align=left>
						<comment id="__NSID__"><OBJECT id=gcem_percent classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative;left:10px;top:0px;width:30px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=True>
							<param name=ClipMode	  value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="9999">
							<param name=MaxLength     value=4>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
					<td STYLE="PADDING-TOP:1px;"><nobr>&nbsp;&nbsp;<FONT  SIZE=2>%</FONT></nobr></td></tr></table></nobr></div></TD></TR></TABLE>
					</td>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-left:3px;padding-right:3px;" bgcolor="#eeeeee"><nobr>&nbsp;지급일자&nbsp;</nobr></td>	
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;"><nobr>&nbsp;
						<comment id="__NSID__"><OBJECT id=gcem_ec02af classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment	  value=0>
							<param name=Border	      value=True>
							<param name=ClipMode	  value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=MaxLength     value=8>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_ec02af', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">&nbsp;</nobr>
					</td>
					<td width="350"><nobr>&nbsp;</nobr></td>
				</tr>
			</table>
		</td>
  </tr>
  <tr> <td colspan="2" height=3>
  </td></tr>
  <tr> 
    <td colspan="2"> 
		<comment id="__NSID__"><OBJECT id=gcgd_hcl classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="WIDTH: 875px; HEIGHT: 423px;border:1 solid #777777" viewastext>
			<PARAM NAME="DataID"			VALUE="gcds_data">
			<PARAM NAME="Editable"		VALUE="FALSE">
			<PARAM NAME="ColSizing"		VALUE="True">
			<PARAM NAME="BorderStyle" VALUE="0">
			<param name="Fillarea"		VALUE="true">
			<PARAM NAME="Format"			VALUE="
				<C> Name='급여년도'		ID=APPDT	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=center  Mask='XXXX/XX' </C>
				<C> Name='지급구분'		ID=PAYDIV	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center  Mask='정기급여'</C>
				<C> Name='급여항목'		ID=PAYCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center</C>
				<C> Name='시작일'			ID=FRDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70	 align=center  Mask='XXXX/XX/XX'</C> 
				<C> Name='시작시간'		ID=FRTM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70	 align=center Mask='XX:XX:XX' </C> 
				<C> Name='종료일'			ID=TODT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=center  Mask='XXXX/XX/XX'</C>
				<C> Name='종료시간'		ID=TOTM		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=center  Mask='XX:XX:XX' </C>
				<C> Name='상태'				ID=WRKSTS	HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=center  Value={Decode(WRKSTS,1,'진행중',2,'완료',E,'에러','C','마감')} </C>
				<C> Name='비고'				ID=MEMO		HeadAlign=Center HeadBgColor=#B9D4DC Width=280 align=left</C>
			">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<fieldset style="width:877px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
				<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
			</fieldset>
						</td>
					</tr>
				</table>
			</td>
        </tr>
      </table>
    </td>
  </tr>
	</table>


</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	




