<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 공통 코드 관리
 * 프로그램ID 	: THMS101.HTML
 * J  S  P		: th101.jsp
 * 작 성 자		: 이동훈
 * 작 성 일		: 2010-10-05
 * 기능정의		: 입찰이력용 공통코드관리
 * [ 수정일자 ][수정자] 내용
 * [2011-06-16][심동현] 공사관리 쪽으로 통합
 *  서블릿명 : thms_101_s.java, thms_101_t.java
 *****************************************************************************/
%>
<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>


<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="http://erp.hdasan.com/common/include/common.css">
 
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="http://erp.hdasan.com/common/include/PubFun.js"></script>
 
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
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;

 
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){

	ln_Enable01("f");

	ln_Enable02("f");

}
 
/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query01(){

  var str1 = "";
	gcds_code01.DataID = "<%=dirPath%>/servlet/construct.menu.th.thms_101_s?"; 
	gcds_code01.Reset();

	ln_Enable01("f");
	ln_Enable02("f");

	gcds_code02.ClearData();

}
 
function ln_Query02(p){

  	gcds_code02.DataID = "<%=dirPath%>/servlet/construct.menu.th.thms_101_s3?v_str1="+p; 

	gcds_code02.Reset();

	ln_Enable02("f");

}
 

/******************************************************************************
	Description : 상세코드추가
******************************************************************************/
function ln_Add(){

	gcds_code02.addrow();

	gcds_code02.namevalue(gcds_code02.rowposition,"CMTYPE")=gcds_code01.namevalue(gcds_code01.rowposition,"CMTYPE");

	ln_Enable02("t");

	txt_cdcode.focus();

}
 

/******************************************************************************
	Description : 상세코드 저장
******************************************************************************/
function ln_Save(){

	if (gcds_code02.IsUpdated) {

		if(ln_Chk){

			if (confirm("저장하시겠습니까?")){	

				gctr_code02.Action = "<%=dirPath%>/servlet/construct.menu.th.thms_101_t";

				gctr_code02.post();

			}	

		}

	}

}
 

/******************************************************************************
	Description : 상세코드 입력체크 
******************************************************************************/
function ln_Chk() {

  //필수항목
	if (fn_trim(txt_cdcode.value)=="" ){

		alert("표준코드를 입력하십시요.");
		txt_cdcode.focus();
		return false; 

	}
 
	if (fn_trim(txt_cdnam.value)==""){

		alert("코드명을 입력하십시요.");
		txt_cdnam.focus();
		return false; 

	}
 
}
 
/******************************************************************************
	Description : 상위코드 Enable _ Disabled 
	parameter   : t - Enable, f - Disable
******************************************************************************/
function ln_Enable01(p) {

	if (p=="t"){

		txt_cmtype.disabled=false;

	}else if (p=="f"){

		txt_cmtype.disabled=true;

	}

}
 
/******************************************************************************
	Description : 상세코드 Enable _ Disabled 
	parameter   : t - Enable, f - Disable
******************************************************************************/
function ln_Enable02(p) {

	if (p=="t"){

		txt_cdcode.disabled=false;

	}else if (p=="f"){

		txt_cdcode.disabled=true;

	}

}
 

 /******************************************************************************
	Description : 엑셀
******************************************************************************/
  function ln_Excel(){

    var szName1 = "업체별 현황";
    var szPath = "C:\\Test\\현황.xls";
       if (gcds_code02.countrow<1){
          alert("다운로드 하실 자료가 없습니다");
       }
       else{
          gcgd_code02.GridToExcel(szName1,szPath,2);
       }
   }


/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){


		ReportID.Preview();

}


</script>
 
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--코드목록-->
</object>

</comment><script>__ws__(__NSID__);</script> 
 
<comment id="__NSID__"><object  id=gcds_code02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--코드상세-->
</object></comment><script>__ws__(__NSID__);</script> 
 

 <comment id="__NSID__">
<OBJECT id=gcds_report00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

 <comment id="__NSID__">
<OBJECT id=gcds_report01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gctr_code01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--코드목록-->
	<PARAM NAME="KeyValue" VALUE="a010001_t1(I:USER=gcds_code01)">
</object></comment><script>__ws__(__NSID__);</script> 
 
<comment id="__NSID__"><object  id="gctr_code02" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--코드상세-->
	<PARAM NAME="KeyValue" VALUE="a010001_t2(I:USER=gcds_code02)">
</object></comment><script>__ws__(__NSID__);</script> 
 
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()"> 
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>
<script language="javascript" for="gcds_code02" event="OnLoadStarted()"> 
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>
 
<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)"> 
	window.status="조회가 완료 되었습니다.";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>
 
<script language="javascript" for="gcds_code02" event="onloadCompleted(row,colid)"> 
	window.status="조회가 완료 되었습니다.";
	ft_cnt02.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
  gcgd_code01.Focus();
</script>
 
<script language=JavaScript for=gcgd_code01 event=OnClick(row,colid)> 

	if(row>0){

		ln_Query02(gcds_code01.namevalue(row,"CMTYPE"));

	}

</script>
 
<script language=JavaScript for=gcgd_code01 event=onKeyPress(keycode)> 

	if (gcds_code01.countrow>=1){

		if ((keycode==38)||(keycode==40)){

			ln_Query02(gcds_code01.namevalue(gcds_code01.rowposition,"CMTYPE"));

		}

	}

</script>
 
 
 
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript"  for=gcds_code01 event=OnClick(Row,Colid)> 
	if(Row>0) ln_Enable01("f");
</script>
 
<script language="javascript"  for=gcds_code02 event=OnClick(Row,Colid)> 
	if(Row>0) ln_Enable02("f");
</script>
 
 
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_code01" event="onsuccess()"> 
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_code02" event="onsuccess()"> 
	alert("작업이 성공적으로 완료되었습니다.");
</script>
 
<script language="javascript" for="gctr_code01" event="onfail()"> 
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>
<script language="javascript" for="gctr_code02" event="onfail()"> 
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>
 
</HEAD>
 
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
 
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">


  <tr> 
    <td><img src="http://203.242.32.199/THMS/img/a010001_head.gif"></td>
    <td width="685" align="right" background="http://erp.hdasan.com/common/img/com_t_bg.gif" style="padding-top:4px;"> 
		<img src="http://erp.hdasan.com/common/img/btn/com_b_print.gif" style="position:relative;top:3px;cursor:hand" onclick="ln_Print()">
		<img src="http://erp.hdasan.com/common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query01()">&nbsp;
	</td>
  </tr>

	<tr>
	<td colspan=2 height=3> </td>  
	</tr> 

  <tr> 
    <td colspan="2" align=left style="padding-left:0px;"> 
      <table width="867" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:567px;height:210">
						<comment id="__NSID__"><object  id=gcgd_code01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="WIDTH:567px; HEIGHT:200px;border:1 solid #777777;" viewastext class="txtbox">
						    <PARAM NAME="DataID"			VALUE="gcds_code01">
						    <PARAM NAME="Editable"		VALUE="false">
						    <PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="SORTVIEW"    VALUE="LEFT">
							<PARAM NAME="COLSIZING"  VALUE="TRUE">
							<PARAM NAME="TITLEHEIGHT"	VALUE=30>
							<PARAM NAME="FILLAREA"   VALUE="TRUE">
							<PARAM NAME="INDWIDTH"   VALUE="0">
							<PARAM NAME="Format"			VALUE="
								<C> Name='분류코드'		ID=CMTYPE			HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=center	 sort=true</C>
								<C> Name='코드명'			ID=CMNAM			HeadAlign=Center HeadBgColor=#B9D4DC Width=310	align=left    sort=true</C>
								<C> Name='비고'				ID=CMREMARK  	HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=left Edit=none </C> 
							">
					</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="position:relative;left:0px;width:569px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
					<td width=0><nobr>&nbsp;</nobr></td>
					<td style="">
						<table border="0" cellpadding="0" cellspacing="0" style="width:300px; height:215px;">
							<tr>
								<td valign=middle width=250 style="height:30px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#B9D4DC" align=center class="txtbox"><nobr>&nbsp;&nbsp;&nbsp;분류코드&nbsp;&nbsp;&nbsp;</nobr></td>
								<td width="100%" style="border:0 solid #708090;border-bottom-width:0px;" align=right>
								</td>									
							</tr>
							<tr>
								<td style="height:25px;width:205px;border:1 solid #708090;border-top-width:1px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>분류코드</nobr></td>
								<td style="border:1 solid #708090;border-top-width:1px;border-left-width:0px">&nbsp;
									<input id="txt_cmtype" type="text" class="txtbox" style= "width:210px; height:20px;position:relative;left:-6px"  maxlength="4" onBlur="bytelength(this,this.value,4);">
								</td>									
							</tr>
							<tr>
								<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">
								코 드 명</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;
									<input id="txt_cmnam" type="text" class="txtbox"  style= "width:210px; height:20px;position:relative;left:-6px" maxlength="36" onBlur="bytelength(this,this.value,100);">
								</td>
							</tr>


							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">비&nbsp;&nbsp;&nbsp;&nbsp;고</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px" >&nbsp;
								<textarea id="txt_cmremark" class="txtbox"  style= "width:210px; height:70px; overflow:auto;position:relative;left:-6px" maxlength="30" onBlur="bytelength(this,this.value,30);"></textarea>
								</td>
							</tr>
							<tr>
								<td style="height:20px;border:0 solid #708090;border-top-width:0px;" >&nbsp;</td>
								<td style="border:0 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;</td>
							</tr>
						
						</table>
				</td>
        </tr>
      </table>
    </td>
  </tr>
	<tr><td colspan=2 height=3> 
		</td>
	</tr> 
  <tr> 
    <td colspan="2" align=left style="padding-left:0px;"> 
      <table width="867" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:567">
						<comment id="__NSID__"><object  id=gcgd_code02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="WIDTH:567px; HEIGHT:200px;border:1 solid #777777;" viewastext class="txtbox">
						    <PARAM NAME="DATAID"			VALUE="GCDS_CODE02">
						    <PARAM NAME="EDITABLE"		VALUE="FALSE">
						    <PARAM NAME="BORDERSTYLE" VALUE="0">
							<PARAM NAME="TITLEHEIGHT"	VALUE=30>
							<PARAM NAME="SORTVIEW"    VALUE="LEFT">
							<PARAM NAME="COLSIZING"  VALUE="TRUE">
							<PARAM NAME="FILLAREA"   VALUE="TRUE">
							<PARAM NAME="INDWIDTH"   VALUE="0">
							<PARAM NAME="Format"			VALUE="
								<C> Name='표준코드'		ID=CDCODE			HeadAlign=Center HeadBgColor=#B9D4DC Width=110  align=center sort=true</C>
								<C> Name='표준코드명'		ID=CDNAM			HeadAlign=Center HeadBgColor=#B9D4DC Width=310 align=left   sort=true</C>
								<C> Name='비고'				ID=CDREMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=left </C>
							">
						</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="position:relative;left:0px;width:569px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt02 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<td width=0><nobr>&nbsp;</nobr></td>
					<td style="">
						<table border="0" cellpadding="0" cellspacing="0" style="width:300px; height:200px;">
							<tr>
								<td valign=middle width=250 style="height:30px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#B9D4DC" align=center class="txtbox"><nobr>&nbsp;&nbsp;&nbsp;상세내역&nbsp;&nbsp;&nbsp;</nobr></td>
								<td width="100%" style="border:0 solid #708090;border-bottom-width:0px;" align=right>
									<img src="http://erp.hdasan.com/common/img/btn/com_b_excel.gif"		style="cursor:hand" onclick="ln_Excel()">	
									<img src="http://erp.hdasan.com/common/img/btn/com_b_insert.gif"		style="cursor:hand" onClick="ln_Add()" >
									<img src="http://erp.hdasan.com/common/img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save()">
								</td>									
							</tr>
							<tr>
								<td style="height:25px;width:205px;border:1 solid #708090;border-top-width:1px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>표준코드</nobr></td>
								<td style="border:1 solid #708090;border-top-width:1px;border-left-width:0px">&nbsp;
									<input id="txt_cdcode" type="text" class="txtbox" style= "width:210px; height:20px;position:relative;left:-6px"  maxlength="20" onBlur="bytelength(this,this.value,20);">
								</td>									
							</tr>
							<tr>
								<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">
								코 드 명</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;
									<input id="txt_cdnam" type="text" class="txtbox"  style= "width:210px; height:20px;position:relative;left:-6px" maxlength="36" onBlur="bytelength(this,this.value,100);">
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">비&nbsp;&nbsp;&nbsp;&nbsp;고</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px" >&nbsp;
									<textarea id="txt_cdremark" class="txtbox"  style= "width:210px; height:70px; overflow:auto;position:relative;left:-6px" maxlength="30" onBlur="bytelength(this,this.value,30);"></textarea>
								</td>
							</tr>
							<tr>
								<td style="height:20px;border:0 solid #708090;border-top-width:0px;" >&nbsp;</td>
								<td style="border:0 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;</td>
							</tr>
						
						</table>
					</td>
        </tr>
      </table>
    </td>
  </tr>
 
</table>
 






<!-----------------------------------------------------------------------------
	  레포트 데이타쉣더퍽   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
	<object id=ReportID classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
		<param name="MasterDataID"		value="gcds_report00">
		<param name="PaperSize"			value="A4">
		<param name="LandScape"			value="false" >
		<param name="PrintSetupDlgFlag" value="true" />
		<param name="ImagSyncFlag"     value="true">
		<param name="PreviewOption"          value="1">  
		<param name="PreviewZoom"		value="90" >
		<param name="Format"				value="

<A>id=Area1 ,left=0,top=0 ,right=2000 ,bottom=180
<R>id='7page.sbt' ,left=0 ,top=20 ,right=2000 ,bottom=151, DetailDataID=gcds_report00
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=201 ,face='굴림' ,size=10 ,penwidth=1

<L> left=30 ,top=130 ,right=1900 ,bottom=130 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
<L> left=30 ,top=2800 ,right=1900 ,bottom=2800 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
<L> left=30 ,top=130 ,right=30 ,bottom=2800 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
<L> left=1900 ,top=130 ,right=1900 ,bottom=2800 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>

<L> left=30 ,top=250 ,right=1900 ,bottom=250 </L>
<L> left=30 ,top=350 ,right=1900 ,bottom=350 </L>
<L> left=30 ,top=430 ,right=1900 ,bottom=430 </L>
<L> left=30 ,top=510 ,right=1900 ,bottom=510 </L>
<L> left=30 ,top=610 ,right=1900 ,bottom=610 </L>
<L> left=30 ,top=710 ,right=1900 ,bottom=710 </L>

<L> left=30 ,top=810 ,right=1900 ,bottom=810 </L>
<L> left=30 ,top=870 ,right=1900 ,bottom=870 </L>
<L> left=30 ,top=930 ,right=1900 ,bottom=930 </L>
<L> left=30 ,top=990 ,right=1900 ,bottom=990 </L>
<L> left=30 ,top=1050 ,right=1900 ,bottom=1050 </L>

<L> left=30 ,top=1150 ,right=1900 ,bottom=1150 </L>
<L> left=30 ,top=1210 ,right=1900 ,bottom=1210 </L>
<L> left=30 ,top=1270 ,right=1900 ,bottom=1270 </L>
<L> left=30 ,top=1330 ,right=1900 ,bottom=1330 </L>
<L> left=30 ,top=1390 ,right=1900 ,bottom=1390 </L>
<L> left=30 ,top=1450 ,right=1900 ,bottom=1450 </L>

<L> left=30 ,top=1550 ,right=1900 ,bottom=1550 </L>
<L> left=30 ,top=1610 ,right=1900 ,bottom=1610 </L>
<L> left=30 ,top=1670 ,right=1900 ,bottom=1670 </L>
<L> left=30 ,top=1730 ,right=1900 ,bottom=1730 </L>
<L> left=30 ,top=1790 ,right=1900 ,bottom=1790 </L>
<L> left=30 ,top=1850 ,right=1900 ,bottom=1850 </L>


<L> left=30 ,top=1950 ,right=1900 ,bottom=1950 </L>
<L> left=30 ,top=2010 ,right=1900 ,bottom=2010 </L>
<L> left=30 ,top=2070 ,right=1900 ,bottom=2070 </L>
<L> left=30 ,top=2130 ,right=1900 ,bottom=2130 </L>
<L> left=30 ,top=2190 ,right=1900 ,bottom=2190 </L>
<L> left=30 ,top=2250 ,right=1900 ,bottom=2250 </L>



<L> left=750 ,top=350 ,right=750 ,bottom=510 </L>

<L> left=1228 ,top=350 ,right=1228 ,bottom=510 </L>
<L> left=1284 ,top=350 ,right=1284 ,bottom=430 </L>
<L> left=1340 ,top=350 ,right=1340 ,bottom=430 </L>
<T>id='-' ,left=1396 ,top=350 ,right=1452 ,bottom=430 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<L> left=1396 ,top=350 ,right=1396 ,bottom=430 </L>
<L> left=1452 ,top=350 ,right=1452 ,bottom=430 </L>
<T>id='-' ,left=1564 ,top=350 ,right=1620 ,bottom=430 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<L> left=1508 ,top=350 ,right=1508 ,bottom=430 </L>
<L> left=1564 ,top=350 ,right=1564 ,bottom=430 </L>
<L> left=1620 ,top=350 ,right=1620 ,bottom=430 </L>
<L> left=1676 ,top=350 ,right=1676 ,bottom=430 </L>
<L> left=1732 ,top=350 ,right=1732 ,bottom=430 </L>
<L> left=1788 ,top=350 ,right=1788 ,bottom=430 </L>
<L> left=1844 ,top=350 ,right=1844 ,bottom=430 </L>

<L> left=1276 ,top=430 ,right=1276 ,bottom=510 </L>
<L> left=1324 ,top=430 ,right=1324 ,bottom=510 </L>
<L> left=1372 ,top=430 ,right=1372 ,bottom=510 </L>
<L> left=1420 ,top=430 ,right=1420 ,bottom=510 </L>
<L> left=1468 ,top=430 ,right=1468 ,bottom=510 </L>
<L> left=1516 ,top=430 ,right=1516 ,bottom=510 </L>
<T>id='-' ,left=1516 ,top=430 ,right=1564 ,bottom=510 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<L> left=1564 ,top=430 ,right=1564 ,bottom=510 </L>
<L> left=1612 ,top=430 ,right=1612 ,bottom=510 </L>
<L> left=1660 ,top=430 ,right=1660 ,bottom=510 </L>
<L> left=1708 ,top=430 ,right=1708 ,bottom=510 </L>
<L> left=1756 ,top=430 ,right=1756 ,bottom=510 </L>
<L> left=1804 ,top=430 ,right=1804 ,bottom=510 </L>
<L> left=1852 ,top=430 ,right=1852 ,bottom=510 </L>

<L> left=300 ,top=350 ,right=300 ,bottom=710 </L>
<L> left=300 ,top=810 ,right=300 ,bottom=1050 </L>
<L> left=300 ,top=1150 ,right=300 ,bottom=1450 </L>
<L> left=300 ,top=1550 ,right=300 ,bottom=1850 </L>
<L> left=300 ,top=1950 ,right=300 ,bottom=2250 </L>

<L> left=850 ,top=810 ,right=850 ,bottom=1050 </L>
<L> left=850 ,top=1150 ,right=850 ,bottom=1450 </L>
<L> left=850 ,top=1550 ,right=850 ,bottom=1850 </L>
<L> left=850 ,top=1950 ,right=850 ,bottom=2250 </L>

<L> left=1300 ,top=810 ,right=1300 ,bottom=1050 </L>
<L> left=1300 ,top=1150 ,right=1300 ,bottom=1450 </L>
<L> left=1300 ,top=1550 ,right=1300 ,bottom=1850 </L>
<L> left=1300 ,top=1950 ,right=1300 ,bottom=2250 </L>

<L> left=1600 ,top=810 ,right=1600 ,bottom=1050 </L>
<L> left=1600 ,top=1150 ,right=1600 ,bottom=1450 </L>
<L> left=1600 ,top=1550 ,right=1600 ,bottom=1850 </L>
<L> left=1600 ,top=1950 ,right=1600 ,bottom=2250 </L>


<T>id='(7쪽)' ,left=1738 ,top=71 ,right=1892 ,bottom=132 ,align='right'</T>

<T>id='연금 · 저축 등 소득공제 명세서' ,left=30 ,top=100 ,right=1900 ,bottom=250 ,face='맑은 고딕' ,bold=true, size=20 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='1. 인적사항' ,left=50 ,top=250 ,right=300 ,bottom=350 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='①상            호' ,left=30 ,top=350 ,right=300 ,bottom=430 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='②사  업  자  등  록  번  호' ,left=750 ,top=350 ,right=1228 ,bottom=430 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='③성            명' ,left=30 ,top=430 ,right=300 ,bottom=510 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='④주   민   등   록   번   호' ,left=750 ,top=430 ,right=1228 ,bottom=510 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='⑤주            소' ,left=30 ,top=510 ,right=300 ,bottom=610 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='⑥사업장소재지' ,left=30 ,top=610 ,right=300 ,bottom=710 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='(전화번호:' ,left=1400 ,top=510 ,right=1570 ,bottom=610 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='(전화번호:' ,left=1400 ,top=610 ,right=1570 ,bottom=710 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id=')' ,left=1880 ,top=510 ,right=1900 ,bottom=610 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id=')' ,left=1880 ,top=610 ,right=1900 ,bottom=710 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='2. 퇴직연금 공제' ,left=50 ,top=710 ,right=400 ,bottom=760 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF ,align='left'</T>
<T>id='     * 퇴직연금 공제에 대한 명세를 작성합니다.' ,left=40 ,top=760 ,right=900 ,bottom=810 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='퇴직연금구분' ,left=30 ,top=810 ,right=300 ,bottom=870 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='금융기관' ,left=300 ,top=810 ,right=850 ,bottom=870 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='계좌번호' ,left=850 ,top=810 ,right=1300 ,bottom=870 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='불입금액' ,left=1300 ,top=810 ,right=1600 ,bottom=870 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='공제금액' ,left=1600 ,top=810 ,right=1900 ,bottom=870 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>

<T>id='3. 연금저축 공제' ,left=50 ,top=1050 ,right=400 ,bottom=1100 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='     * 연금저축 공제에 대한 명세를 작성합니다.' ,left=40 ,top=1100 ,right=900 ,bottom=1150 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='연금저축구분' ,left=30 ,top=1150 ,right=300 ,bottom=1210 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='금융기관' ,left=300 ,top=1150 ,right=850 ,bottom=1210 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='계좌번호' ,left=850 ,top=1150 ,right=1300 ,bottom=1210 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='불입금액' ,left=1300 ,top=1150 ,right=1600 ,bottom=1210 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='공제금액' ,left=1600 ,top=1150 ,right=1900 ,bottom=1210 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>

<T>id='4. 주택마련저축 공제' ,left=50 ,top=1450 ,right=500 ,bottom=1500 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='     * 주택마련저축 공제에 대한 명세를 작성합니다.' ,left=40 ,top=1500 ,right=1000 ,bottom=1550 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='저축 구분' ,left=30 ,top=1550 ,right=300 ,bottom=1610 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='금융기관' ,left=300 ,top=1550 ,right=850 ,bottom=1610 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='계좌번호' ,left=850 ,top=1550 ,right=1300 ,bottom=1610 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='불입금액' ,left=1300 ,top=1550 ,right=1600 ,bottom=1610 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='공제금액' ,left=1600 ,top=1550 ,right=1900 ,bottom=1610 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>

<T>id='5. 장기주식형저축 공제' ,left=50 ,top=1850 ,right=500 ,bottom=1900 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='     * 장기주식형저축 공제에 대한 명세를 작성합니다.' ,left=40 ,top=1900 ,right=1000 ,bottom=1950 ,face='굴림' ,size=10,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='금융기관' ,left=30 ,top=1950 ,right=300 ,bottom=2010 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='계좌번호' ,left=300 ,top=1950 ,right=850 ,bottom=2010 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='납입연차' ,left=850 ,top=1950 ,right=1300 ,bottom=2010 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='불입금액' ,left=1300 ,top=1950 ,right=1600 ,bottom=2010 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='공제금액' ,left=1600 ,top=1950 ,right=1900 ,bottom=2010 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>

<T>id='※ 작성요령' ,left=40 ,top=2270 ,right=1900 ,bottom=2350 ,align='left' ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='1. 퇴직연금·연금저축·주택마련저축·장기주식형저축 공제를 신청하고자 하는 근로소득자는 해당 소득공제에 대한 명세를' ,left=40 ,top=2350 ,right=1900 ,bottom=2400 ,align='left' ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id=' 작성하여야 합니다.' ,left=40 ,top=2400 ,right=1900 ,bottom=2450 ,align='left' ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>

<T>id='2. 퇴직연금 공제에서 퇴직연금구분란은 퇴직연금·과학기술인공제회로 구분하여 적습니다.' ,left=40 ,top=2450 ,right=1900 ,bottom=2500 ,align='left' ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='3. 연금저축 공제의 연금저축구분란은 개인연금저축과 연금저축으로 구분하여 적습니다.' ,left=40 ,top=2500 ,right=1900 ,bottom=2550 ,align='left' ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='4. 주택마련저축 공제의 저축구분란은 청약저축, 주택청약종합저축, 장기주택마련저축 및 근로자주택마련저축으로 구분하여' ,left=40 ,top=2550 ,right=1900 ,bottom=2600 ,align='left' ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id=' 적습니다.' ,left=40 ,top=2600 ,right=1900 ,bottom=2650 ,align='left' ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>

<T>id='5. 장기주식형저축 공제의 경우 동일 계좌라 하더라도 해당 과세기간에 납입연차가 달라지는 경우 구분하여 적습니다.' ,left=40 ,top=2650 ,right=1900 ,bottom=2700 ,align='left' ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='6. 근로자가 원천징수의무자에게 제출시 공제금액란은 근로소득자가 적지 아니할 수 있습니다.' ,left=40 ,top=2700 ,right=1900 ,bottom=2750 ,align='left' ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>




<T>id='210㎜x297㎜' ,left=1300 ,top=2805 ,right=1890 ,bottom=2840 ,align='right'</T>



</B>
</R>
</A>
"/>  


</OBJECT>
</comment><script>__ws__(__NSID__);</script>






<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_code01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_code01>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=CMTYPE    Ctrl=txt_cmtype       Param=value</C>
		<C>Col=CMNAM		 Ctrl=txt_cmnam        Param=value</C>
		<C>Col=CMREMARK	 Ctrl=txt_cmremark		 Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 
 
<comment id="__NSID__"><object  id=gcbn_code02 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_code02>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=CDCODE    Ctrl=txt_cdcode      Param=value</C>
		<C>Col=CDNAM		 Ctrl=txt_cdnam       Param=value</C>
		<C>Col=CDREMARK	 Ctrl=txt_cdremark		Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 
 
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="http://erp.hdasan.com/common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 
 
</body>
</html>

