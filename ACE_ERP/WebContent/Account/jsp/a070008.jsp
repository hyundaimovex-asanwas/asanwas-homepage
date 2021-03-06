<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:  자금관리 - 대금지급명세서
+ 프로그램 ID	:   A700008.html
+ 기 능 정 의	:   출력,조회 화면이다.
+ 작   성  자 :  
+ 서 블 릿 명	:	
------------------------------------------------------------------------------>

<html>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>자금관리</title>


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
var gs_fdcode = gfdcode;
var gs_usrid = gusrid;
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
		var str1  = gclx_sfdcode1.BindColVal;				//지점코드          
		var str2  = fn_trim(gcem_sgetdatefr1.text);			//일자
		var str3 = "";
		if(rdo_0.checked == true) str3 =  "A";
		else if(rdo_1.checked == true) str3 =  "B";
		else if(rdo_2.checked ==  true) str3="D";

		if(str2.length !=8) {

			alert("지급일자를 정확히 입력해 주세요 .");
			return;

		}
		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070008_s1"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3;
		//prompt("",		gcds_data1.DataID);						
		gcds_data1.Reset();
}

/******************************************************************************
	Description : Header 설정
******************************************************************************/
function ln_PrintHederSet(){

	var THeader1 = "CURDT:STRING";
	gcds_temp01.SetDataHeader(THeader1);

}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(e){

	var str3;
	if(e=="01") {
		if(gcds_data1.countrow<1) {
			alert("출력할 정보가 없습니다.");
		}else{
			if(rdo_0.checked == true) str3 =  "A";
			else if(rdo_1.checked == true) str3 =  "B";
			else if(rdo_2.checked ==  true) str3="D";

			if(str3=="A"||str3=="B") {
				gcds_temp01.clearall();
				ln_PrintHederSet();
				gcds_temp01.addrow();
				gcds_temp01.namevalue(gcds_temp01.rowposition,"CURDT")=gcem_sgetdatefr1.text;
				gcrp_print1.preview();
			} else if(str3=="D") {
				gcds_temp01.clearall();
				ln_PrintHederSet();
				gcds_temp01.addrow();
				gcds_temp01.namevalue(gcds_temp01.rowposition,"CURDT")=gcem_sgetdatefr1.text;
				gcrp_print2.preview();
			}
		}
	}

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(e){
	if(e=="01"){
		if (gcds_data1.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_disp01.RunExcel('대금지급명세서');
	}
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
	gcem_sgetdatefr1.text = gs_date;	 							
	
	//지점코드[검색]
	gcds_sfdcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode1.Reset();

	//계정코드 
	gcds_acct_cd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s0?v_str1=";  
	gcds_acct_cd.Reset();

	//거래처
	gcds_vend_cd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s0?v_str1=";  
	gcds_vend_cd.Reset();
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_acct_cd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_vend_cd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

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
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
	}
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt02.innerText = "조회건수 : " + row + " 건";
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
	}
</script>

<script language="javascript" for="gcds_data3" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data3" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt03.innerText = "조회건수 : " + row + " 건";
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
		
	}
</script>

<script language="javascript" for="gcds_sfdcode1" event="onloadCompleted(row,colid)">
	gcds_sfdcode1.InsertRow(1);
	gcds_sfdcode1.NameValue(1,"FDCODE")="";
	gcds_sfdcode1.NameValue(1,"FDNAME")="";
	if(gs_usrid=="ACCOUNT"){
		gclx_sfdcode1.index=2;
	}else{
		gclx_sfdcode1.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_dept1" event="onloadCompleted(row,colid)">
window.status="조회가 완료 되었습니다.";   
	//// document.all.LowerFrame.style.visibility="hidden";    
	gcds_dept1.InsertRow(1);
	gcds_dept1.NameValue(1,"DEPTCD")="";
	gcds_dept1.NameValue(1,"DEPTNM")="";
	gclx_cadeptcd.index=0;
</script>

<script language="javascript" for="gcds_stdiv2" event="onloadCompleted(row,colid)">
	gcds_stdiv2.InsertRow(1);
	gcds_stdiv2.NameValue(1,"CDCODE")="";
	gcds_stdiv2.NameValue(1,"CDNAM")="";
	gclx_stdiv2.index = 0;
</script>

<script language="javascript" for="gcds_stdiv3" event="onloadCompleted(row,colid)">
	gcds_stdiv3.InsertRow(1);
	gcds_stdiv3.NameValue(1,"CDCODE")="";
	gcds_stdiv3.NameValue(1,"CDNAM")="";
	gclx_stdiv3.index = 0;
</script>

</head>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/a070008_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2 align=left style="position:relative;left:5px">
      
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
<table cellpadding="0" cellspacing="0" border="0" style="display:block">

	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:0px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>지점구분</nobr></td>
					<td class="tab23" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode1">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>지급일자</nobr></td>
					<td class="tab23" style="width:120px">
						<comment id="__NSID__"><object id=gcem_sgetdatefr1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdatefr1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</td>

					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>구분</nobr></td>
					<td style="width:310px">
						<input type="radio" id="rdo_0" name="rdo1" checked> 전체
						<input type="radio" id="rdo_1" name="rdo1" > 현금,예금
						<input type="radio" id="rdo_2" name="rdo1" > 어음

					</td>

					<td align="right">&nbsp;<nobr>      
						<img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('01')">
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Excel('01')">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('01')"> 
						</nobr>
					</td>
				</tr>
			</table>
					</td>
				</tr>
				<tr>
					<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr> 
						<td style="width:460" ALIGN=LEFT VALIGN=TOP><comment id="__NSID__">
							<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:-1px" viewastext>
								<PARAM NAME="DataID"        VALUE="gcds_data1">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"      VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"        VALUE="
									<C> Name='No.'			ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC	Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
									<C> Name='구분'			ID=ATCODE		HeadAlign=Center HeadBgColor=#B9D4DC	Width=70		align=left		SumText=''		SumBgColor='#C3D0DB'	EditStyle='lookup' Data='gcds_acct_cd:ATCODE:ATKORNAM'</C>
									<C> Name='거래처'		ID=FSREFVAL	HeadAlign=Center HeadBgColor=#B9D4DC	Width=160		align=left		SumText='계'	SumBgColor='#C3D0DB'	EditStyle='lookup' Data='gcds_vend_cd:vend_cd:vend_nm'</C>
									<C> Name='금액'			ID=FSAMT		HeadAlign=Center HeadBgColor=#B9D4DC	Width=140		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
						      <C> Name='회계일자'	ID=ACTDAT		HeadAlign=Center HeadBgColor=#B9D4DC	Width=70		align=left		SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='적요'			ID=REMARK		HeadAlign=Center HeadBgColor=#B9D4DC	Width=370		align=left		SumText=''		SumBgColor='#C3D0DB'</C>
							
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:-1px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<td>
			</table>			
		</td> 
	</tr> 
</table> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<!--param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"				value="A4">
	<param name="LandScape"				value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false"-->
	<param name="SuppressColumns"	value="1:pageskip,ATCODE">
	<param NAME="MasterDataID"					VALUE="gcds_temp01">
	<param NAME="DetailDataID"					VALUE="gcds_data1">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="false">
	<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="true">	
	<param name="Format"					value="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=344 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='( 단위  : 원 )' ,left=1614 ,top=278 ,right=1931 ,bottom=333 ,align='right' ,face='돋움체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT', left=529, top=132, right=1484, bottom=201 ,mask='대금지급 명세서(XXXX. XX. XX)', face='돋움체', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=95 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='적   요' ,left=1482 ,top=21 ,right=1722 ,bottom=77 ,face='돋움체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급일' ,left=1177 ,top=21 ,right=1289 ,bottom=77 ,face='돋움체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='발행일' ,left=1005 ,top=48 ,right=1117 ,bottom=90 ,face='돋움체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계산서' ,left=1005 ,top=5 ,right=1117 ,bottom=48 ,face='돋움체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금 액' ,left=720 ,top=21 ,right=947 ,bottom=77 ,face='돋움체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거래처' ,left=331 ,top=21 ,right=572 ,bottom=77 ,face='돋움체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구분' ,left=71 ,top=21 ,right=183 ,bottom=77 ,face='돋움체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=953 ,top=3 ,right=953 ,bottom=93 </L>
	<L> left=1164 ,top=3 ,right=1164 ,bottom=93 </L>
	<L> left=1296 ,top=3 ,right=1296 ,bottom=93 </L>
	<L> left=1931 ,top=0 ,right=1931 ,bottom=93 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=66 ,top=0 ,right=66 ,bottom=95 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=714 ,top=0 ,right=714 ,bottom=93 </L>
	<L> left=185 ,top=0 ,right=185 ,bottom=93 </L>
	<L> left=66 ,top=0 ,right=1931 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=66 ,top=93 ,right=1931 ,bottom=93 </L>
</B>
<B>id=Default ,left=0,top=0 ,right=2000 ,bottom=66 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=185 ,top=0 ,right=185 ,bottom=66 </L>
	<L> left=66 ,top=0 ,right=66 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=714 ,top=0 ,right=714 ,bottom=66 </L>
	<L> left=953 ,top=0 ,right=953 ,bottom=66 </L>
	<L> left=1164 ,top=0 ,right=1164 ,bottom=66 </L>
	<L> left=1931 ,top=0 ,right=1931 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=66 ,top=66 ,right=1931 ,bottom=66 </L>
	<C>id='ATCODE', left=71, top=5, right=180, bottom=61, face='돋움체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FSREFVAL', left=191, top=5, right=709, bottom=61, align='left', face='돋움체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FSAMT', left=722, top=5, right=947, bottom=61, align='right', face='돋움체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=1302, top=5, right=1926, bottom=61, align='left', face='돋움체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAXDAT', left=958, top=5, right=1159, bottom=61 ,mask='XXXX/XX/XX', face='돋움체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1296 ,top=0 ,right=1296 ,bottom=66 </L>
	<C>id='SGNDAT', left=1169, top=5, right=1291, bottom=61 ,mask='XX/XX', face='돋움체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=66 ,top=0 ,right=1931 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print2 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<!--param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"				value="A4">
	<param name="LandScape"				value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false"-->
	<param name="SuppressColumns"	value="1:pageskip,ATCODE">
	<param NAME="MasterDataID"					VALUE="gcds_temp01">
	<param NAME="DetailDataID"					VALUE="gcds_data1">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="false">
	<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="true">	
	<param name="Format"					value="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=344 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='( 단위  : 원 )' ,left=1614 ,top=278 ,right=1931 ,bottom=333 ,align='right' ,face='돋움체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT', left=529, top=132, right=1484, bottom=201 ,mask='대금지급 명세서(XXXX. XX. XX)', face='돋움체', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=95 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='적   요' ,left=1535 ,top=21 ,right=1775 ,bottom=77 ,face='돋움체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급일' ,left=1111 ,top=21 ,right=1222 ,bottom=77 ,face='돋움체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='발행일' ,left=939 ,top=48 ,right=1050 ,bottom=90 ,face='돋움체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계산서' ,left=939 ,top=5 ,right=1050 ,bottom=48 ,face='돋움체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금 액' ,left=654 ,top=21 ,right=881 ,bottom=77 ,face='돋움체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거래처' ,left=331 ,top=21 ,right=572 ,bottom=77 ,face='돋움체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구분' ,left=71 ,top=21 ,right=183 ,bottom=77 ,face='돋움체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=886 ,top=3 ,right=886 ,bottom=93 </L>
	<L> left=1098 ,top=3 ,right=1098 ,bottom=93 </L>
	<L> left=1363 ,top=3 ,right=1363 ,bottom=93 </L>
	<L> left=1931 ,top=0 ,right=1931 ,bottom=93 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=648 ,top=0 ,right=648 ,bottom=93 </L>
	<L> left=185 ,top=0 ,right=185 ,bottom=93 </L>
	<L> left=66 ,top=0 ,right=1931 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=66 ,top=93 ,right=1931 ,bottom=93 </L>
	<L> left=1230 ,top=0 ,right=1230 ,bottom=95 </L>
	<T>id='만기일' ,left=1244 ,top=21 ,right=1355 ,bottom=77 ,face='돋움체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=66 ,top=0 ,right=66 ,bottom=93 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Default ,left=0,top=0 ,right=2000 ,bottom=66 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=185 ,top=0 ,right=185 ,bottom=66 </L>
	<L> left=66 ,top=0 ,right=66 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=648 ,top=0 ,right=648 ,bottom=66 </L>
	<L> left=886 ,top=0 ,right=886 ,bottom=66 </L>
	<L> left=1098 ,top=0 ,right=1098 ,bottom=66 </L>
	<L> left=1931 ,top=0 ,right=1931 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=66 ,top=66 ,right=1931 ,bottom=66 </L>
	<C>id='ATCODE', left=71, top=5, right=180, bottom=61, face='돋움체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FSREFVAL', left=191, top=5, right=643, bottom=61, align='left', face='돋움체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FSAMT', left=656, top=5, right=881, bottom=61, align='right', face='돋움체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=1368, top=5, right=1926, bottom=61, align='left', face='돋움체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAXDAT', left=892, top=5, right=1093, bottom=61 ,mask='XXXX/XX/XX', face='돋움체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1363 ,top=0 ,right=1363 ,bottom=66 </L>
	<C>id='SGNDAT', left=1103, top=5, right=1225, bottom=61 ,mask='XX/XX', face='돋움체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1230 ,top=0 ,right=1230 ,bottom=66 </L>
	<C>id='SGNDAT', left=1236, top=5, right=1357, bottom=61 ,mask='XX/XX', face='돋움체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=66 ,top=0 ,right=1931 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 