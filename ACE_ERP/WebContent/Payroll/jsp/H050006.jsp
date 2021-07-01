<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사근태관리
+ 프로그램 ID	: 
+ 기 능 정 의	: 출퇴근관리
+ 최 초 이 력	: 이순미
+ 변 경 이 력	: 
+ 서 블 릿 명	: h050006_s1, h050006_t1
-----------------------------------------------------------------------------
+ 수 정 내 용 :	
+ 수   정  자 : 정영식
+ 수 정 일 자 : 2007.10.23
-----------------------------------------------------------------------------
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title></title>


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
//lfn_init();
var gs_level;
var gs_treecd;
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + "01";
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	ln_DeptQuery();

  //gcem_curdt.text = "20070701";
	//gcem_curdt2.text = "20070701";
	gcem_curdt.text = gs_date2;
	gcem_curdt2.text = gs_date;
	//gcem_clotime.enabled = false;
	//gcem_atttime.enabled = false;
	//txt_empnm.disabled = true;
	//gcem_attday.enable = false;
	//gcem_cloday.enable = false;
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	var str1 = gclx_deptcd1.BindColVal;
	var str2 = gcem_curdt.text;			//일자 FROM
	var str3 = txt_empnmk11.value;	//성명
	var str4 = gcem_curdt2.text;		//년월 TO

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050006_s1?v_str1="+str1
									 +"&v_str2="+str2
									 +"&v_str3="+str3	
									 +"&v_str4="+gs_level
									 +"&v_str5="+gs_treecd
									 +"&v_str6="+str4;
	gcds_data.Reset();
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){
	gcds_data.addrow();
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
	
	if (!ln_Valchk()) return;

	if (gcem_empno.text == "") {
		//gcem_empno.value = gcds_data.namevalue(gcds_data.rowposition,"EMPNO");
	}else{
		gcds_data.namevalue(gcds_data.rowposition,"EMPNO") = gcem_empno.text;
	}

	if (gcds_data.IsUpdated) {
	//prompt('',gcds_data.text);
		if (confirm("입력하신 사항을 등록하시겠습니까?")){	
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050006_t1";
		//prompt('',gcds_data.text);
		gctr_data.post();
		ln_Query();
		}
	}
}

/******************************************************************************
	Description : 입력값 체크[근태관리]
******************************************************************************/
function ln_Valchk() {

	if (txt_deptnm.value == "") { 
		alert("정확한 소속명을 입력해 주십시오."); 
		txt_deptnm.focus()
		return false;
	}
	
	if (fn_trim(txt_empnm.value) == "") { 
		alert("정확한 성명을 입력해 주십시오."); 
		txt_empnm.value="";
		//txt_empnm.focus()
		return false;
	}

	if (gcem_attday.text == "") { 
		alert("정확한 출근일자를 입력해 주십시오."); 
		gcem_attday.focus()
		return false;
	}

	if (gcem_atttime.text == "") { 
		alert("정확한 출근시간을 입력해 주십시오."); 
		//gcem_atttime.focus()
		return false;
	}

	return true;
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){
	
	if (confirm("선택한 정보를 삭제하시겠습니까?")){
		gcds_data.deleterow(gcds_data.rowposition);
		//prompt('',gcds_data.text);
		gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050006_t1";
		gctr_data.post();
		ln_Query();
	}
 }

/******************************************************************************
	Description : 출근시간
******************************************************************************/
function ln_AttTime() {

	var row = gcds_curtime.rowposition;
	//gcem_atttime.enabled = false;

	gcds_curtime.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050001_s1_time";
	gcds_curtime.Reset();

	var h_time = gcds_curtime.namevalue(row,"TOTIME").substring(0,2);
	var m_time = gcds_curtime.namevalue(row,"TOTIME").substring(3,5);
	var s_time = gcds_curtime.namevalue(row,"TOTIME").substring(6,8);

	gcem_atttime.text = h_time + m_time + s_time;

}

/******************************************************************************
	Description : 퇴근시간
******************************************************************************/
function ln_CloTime() {

	var row = gcds_curtime.rowposition;
	gcds_curtime.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050001_s1_time";
	gcds_curtime.Reset();

	var h_time = gcds_curtime.namevalue(row,"TOTIME").substring(0,2);
	var m_time = gcds_curtime.namevalue(row,"TOTIME").substring(3,5);
	var s_time = gcds_curtime.namevalue(row,"TOTIME").substring(6,8);

	gcem_clotime.text = h_time + m_time + s_time;

}

/******************************************************************************
	Description : 성명 찾기
******************************************************************************/
function ln_Popup(e){

	var arrResult	= new Array();
	var arrSend	= new Array();
	var strURL;	
	var strPos;

  if(gcds_data.SysStatus(gcds_data.rowposition)!=1){
		return false;
	}

  arrSend[0]="H050005";

	strURL = "./H030003_popup.html";
	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrSend,strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");

		txt_empnm.value=arrParam[0];  //성명
		gcem_empno.text =arrParam[1];  //사번
		txt_deptcd.value=arrParam[4];  //
		txt_deptnm.value=arrParam[2];  //
	} else {
		txt_empnm.value="";  //성명
		gcem_empno.text ="";  //사번
		txt_deptcd.value="";  //
		txt_deptnm.value="";  //
	}

  /*
  arrSend[0]="H050008";
	strURL = "../../Person/html/H030003_popup.html"
	strPos = "dialogWidth:377px;dialogHeight:383px;dialogTop:270px;dialogLeft:348px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrSend,strPos);

	if(gbn=="0"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_empnmk.value = arrParam[0]; //성명
		} else {
			txt_empnmk.value ="";			//성명
		}
	}else if(gbn=="1"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			eval("txt_empnmk_"+gbn).value = arrParam[0]; //성명
			eval("gcem_empno_"+gbn).text = arrParam[1];  //사번
			eval("txt_deptcd_"+gbn).value=arrParam[4];   //
			eval("txt_deptnm_"+gbn).value=arrParam[2];   //
			eval("txt_paygrd_"+gbn).value=arrParam[5];   //
			eval("txt_paygrdnm_"+gbn).value=arrParam[3]; //
       
			ln_Paygrd_info(eval("gcem_empno_"+gbn).text);
			ln_Amt_Setting();//금액설정
		} else {
			eval("txt_empnmk_"+gbn).value  ="";			//성명
			eval("gcem_empno_"+gbn).text="";
			eval("txt_deptcd_"+gbn).value="";   //
			eval("txt_deptnm_"+gbn).value="";   //
			eval("txt_paygrd_"+gbn).value="";   //
			eval("txt_paygrdnm_"+gbn).value=""; //
		}
	}
  */
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

	var row = gcds_data.rowposition;
	
	if (gcds_data.countrow<1) alert("출력하실 자료가 없습니다");
	else if (gcds_data.sysStatus(row)=="1") alert("증명서 등록후 사용할수 있습니다.");
	else {
		var THeader	 = "EMPNO:STRING(7),EMPNMK:STRING(20),ATTDAY:STRING(8),ATTTIME:STRING(6),CLODAY:STRING(8),CLOTIME:STRING(6),";
				THeader += "DEPTNM:STRING(70),OVERWK:DECIMAL(4),";
				THeader += "CUDATE:STRING(10),WRITENM:STRING(20),CUYEAR:STRING(4),CUMONTH:STRING(2)";

				gcds_print.SetDataHeader(THeader);
				
				//gcds_print.namevalue(1,"FRDATE") = ADE_EMEdit_monthFr.text;
				//gcds_print.namevalue(1,"TODATE") = ADE_EMEdit_monthTo.text;
				//gcds_print.namevalue(1,"CUDATE") = GetCookie("vcurd"); 

				var r_print = gcds_print.rowposition;
				var r_data = gcds_data.rowposition;

			for (var i=1;i<=gcds_data.countrow;i++){

				gcds_print.addrow();

				gcds_print.namevalue(i,"EMPNO")					= gcds_data.namevalue(i,"EMPNO");
				gcds_print.namevalue(i,"EMPNMK")				= gcds_data.namevalue(i,"EMPNMK");
				gcds_print.namevalue(i,"ATTDAY")				= gcds_data.namevalue(i,"ATTDAY");
				gcds_print.namevalue(i,"ATTTIME")				= gcds_data.namevalue(i,"ATTTIME");
				gcds_print.namevalue(i,"CLODAY")				= gcds_data.namevalue(i,"CLODAY");
				gcds_print.namevalue(i,"CLOTIME")				= gcds_data.namevalue(i,"CLOTIME");
				gcds_print.namevalue(i,"DEPTNM")				= gcds_data.namevalue(i,"DEPTNM");
				gcds_print.namevalue(i,"OVERWK")				= gcds_data.namevalue(i,"OVERWK");
				gcds_print.namevalue(i,"CUDATE")				= gcds_data.namevalue(i,"CUDATE");
				gcds_print.namevalue(i,"WRITENM")				= gusrnm;
				gcds_print.namevalue(i,"CUYEAR")				= gcurdate.substring(0,4);	//년
				gcds_print.namevalue(i,"CUMONTH")				= gcurdate.substring(5,7);	//월
			}

		/*
		for (var i=1;i<=gcds_data.countcolumn;i++){
			gcds_print.namevalue(1,gcds_data.columnid(i)) = gcds_data.namevalue(i,gcds_data.columnid(i));
		}
		
		for (var i=1;i<=gcds_data.countrow;i++){
		}
		*/

		gcrp_print1.preview();	
	}

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	if(gcds_data.countrow<1) {	alert("다운로드하실 자료가 없습니다."); 
	}else{ gcgd_data.RunExcel('출퇴근관리');	}
}

/******************************************************************************
	Description : 소속 조회
******************************************************************************/
function ln_DeptQuery(){

	//gcds_deptcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?";
	//gcds_deptcd.Reset();

	gcds_deptcd1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?";
	gcds_deptcd1.Reset();

}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"	VALUE="false">
	<!-- <PARAM NAME="SortExpr"	VALUE="+TREECD"> -->
	<!-- <param name=SubSumExpr value="TOTAL, 1:DEPTNM"> -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- 검색 소속 -->
<comment id="__NSID__"><OBJECT id=gcds_deptcd1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<!-- <PARAM NAME="SortExpr"	VALUE="+TREECD"> -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- BIND 소속 
<comment id="__NSID__"><OBJECT id=gcds_deptcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<PARAM NAME="SortExpr"	VALUE="+TREECD">
</OBJECT></comment><script>__ws__(__NSID__);</script>
-->

<!-- Bind 현재 시간정보 -->
<comment id="__NSID__"><OBJECT id=gcds_curtime classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- 출력 정보 -->
<comment id="__NSID__"><OBJECT id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h050006_t1(I:USER=gcds_data)">
</OBJECT></comment><script>__ws__(__NSID__);</script>
	
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data event=onloadCompleted(row,colid)>//근태총 조회 건수
	/*
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	}

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";
*/
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");

</script>
<!-- 
<script language="javascript" for="gcds_deptcd" event="onloadCompleted(row,colid)">
	gcds_deptcd.insertrow(1);
	gcds_deptcd.namevalue(1,"DEPTCD") = "";
	gcds_deptcd.namevalue(1,"DEPTNM") = "전체";
	gclx_deptcd.index = 0;
</script> -->

<script language="javascript" for="gcds_deptcd1" event="onloadCompleted(row,colid)">
	gcds_deptcd1.insertrow(1);
	gcds_deptcd1.namevalue(1,"DEPTCD") = "";
	gcds_deptcd1.namevalue(1,"DEPTNM") = "전체";
	gclx_deptcd1.index = 0;
</script>

<script language=JavaScript for=gclx_deptcd1 event=onSelChange()>
	gs_level = '';
	gs_treecd ='';
	gs_level = gclx_deptcd1.ValueOfIndex ("level", gclx_deptcd1.Index);
	gs_treecd = gclx_deptcd1.ValueOfIndex ("treecd", gclx_deptcd1.Index);
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
<script language="javascript" for="gctr_data" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_data" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("에러가 발생 했습니다.");
	//document.all.LowerFrame.style.visibility="hidden";
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/h050006_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<!-- <img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand"	onclick="ln_Print()"> -->
			<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand"	onclick="ln_Excel()">
		<!--   <img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand"	onclick="ln_Delete()">
			<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()" >  -->
			<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
  </tr>
</table>

	<table  cellpadding="1" cellspacing="0" border="0"  style='position:relative;left:3px;width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
    <tr> 
			<td width="10" align=CENTER  style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp;&nbsp;&nbsp;소 속 명&nbsp;&nbsp;</nobr></td>
			<td width="10"style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;
				<comment id="__NSID__"><object id=gclx_deptcd1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative; left:0px;top:2px;" height=180 width=160 class="txtbox">
					<param name=ComboDataID           value=gcds_deptcd1>
					<param name=SearchColumn          value="DEPTNM">
					<param name=Sort                  value="false">
					<param name=SortColumn						value="DEPTNM">
					<param name=ListExprFormat        value="DEPTNM^0^150">       
					<param name=BindColumn            value="DEPTCD"> 
				</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
			</td>
			<td width="10" align=CENTER  style="border:0 solid #708090;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" class="txtbox"><nobr>&nbsp;&nbsp;적용일자&nbsp;&nbsp;</nobr></td>
			<td width="10"style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
				<comment id="__NSID__"><object id=gcem_curdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:0px;top:2px; width:70px; height:20px;" class="txtbox"	validFeatures="ignoreStatus=yes" validExp="">
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=True>
					<param name=ClipMode			value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=MaxLength     value=6>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script>~&nbsp;
				<comment id="__NSID__"><object id=gcem_curdt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:0px;top:2px; width:70px; height:20px;" class="txtbox"	validFeatures="ignoreStatus=yes" validExp="">
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=True>
					<param name=ClipMode			value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=MaxLength     value=6>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
			</td>
			<td class="tab23" width="65" bgcolor="#eeeeee">&nbsp;&nbsp;성&nbsp;&nbsp;&nbsp;명&nbsp;&nbsp;</td>
				<td width="70px;"><input type=text id="txt_empnmk11" style="width:60px;position:relative;left:5px"  onkeydown="if(event.keyCode==13) ln_Query();"></td>
			<td width="100%">&nbsp;</td>
		</tr>
	</table>

	<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td>
				<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data style="position:relative;top:3px;WIDTH:568px;HEIGHT: 400px;border:1 solid #777777;display:block;" viewastext class="txtbox">
					<PARAM NAME="DataID"			VALUE="gcds_data">
					<PARAM NAME="Editable"		VALUE="false">
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="SortView"		VALUE="left">
					<param name="Fillarea"		VALUE="true">
					<param name="ColSizing"   VALUE="true">
					<PARAM NAME="Format"			VALUE="  
						<C> Name='성명'				ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=LEFT		Edit=None	Bgcolor={IF(ATTTIME='0000','#E3E3FF','WHITE')}	sort=true</C>
						<C> Name='소속명'			ID=DEPTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=LEFT		Edit=None	Bgcolor={IF(ATTTIME='0000','#E3E3FF','WHITE')} 	sort=true</C> 
						<G> Name='출근'										HeadAlign=Center HeadBgColor=#B9D4DC 
							<C> Name='일자'			ID=ATTDAY		HeadAlign=Center HeadBgColor=#B9D4DC Width=65		align=CENTER	Edit=None	Bgcolor={IF(ATTTIME='0000','#E3E3FF','WHITE')} Mask='XXXX/XX/XX'</C>
							<C> Name='시간'			ID=ATTTIME	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=CENTER	Edit=None	Bgcolor={IF(ATTTIME='0000','#E3E3FF','WHITE')} Mask='XX:XX'</C>
						</G>
						<G> Name='퇴근'										HeadAlign=Center HeadBgColor=#B9D4DC
							<C> Name='일자'			ID=CLODAY		HeadAlign=Center HeadBgColor=#B9D4DC Width=65		align=CENTER	Edit=None	Bgcolor={IF(ATTTIME='0000','#E3E3FF','WHITE')} Mask='XXXX/XX/XX'</C>
							<C> Name='시간'			ID=CLOTIME	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=CENTER	Edit=None	Bgcolor={IF(ATTTIME='0000','#E3E3FF','WHITE')} Mask='XX:XX'</C>
						</G>
						<C> Name='비 고1'			ID=ETC		  HeadAlign=Center HeadBgColor=#B9D4DC Width=75	align=LEFT		Edit=None Bgcolor={IF(ATTTIME='0000','#E3E3FF','WHITE')} sort=true </C>
						<C> Name='비 고2'			ID=ETC2		  HeadAlign=Center HeadBgColor=#B9D4DC Width=75	align=LEFT		Edit=None Bgcolor={IF(ATTTIME='0000','#E3E3FF','WHITE')} sort=true </C>
					">
				</OBJECT></comment><script>__ws__(__NSID__);</script><!-- OVERWK -> ETC -->
				<font id=ft_cnt1 style="position:relative;top:5px;"></font>
			</td>
			<td>
				<table border= "0" cellpadding=0 cellspacing=0  border=0  style='position:relative;left:0px;top:2px;width:304px;height:403px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명&nbsp;</td>
						<td style="border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;" colspan=2><nobr>&nbsp;
							<comment id="__NSID__">
							<object id=gcem_empno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative;left:-5px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " >
								<param name=Text          value="">
								<param name=Alignment	    value=0>
								<param name=Border	      value=True>
								<param name=Format	      value="0000000">
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;
							<img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:-9px;top:2px;" onclick="ln_Popup('txt_empnm')" >
							<input id="txt_empnm" type="text" class="txt21" style="position:relative;left:-9px;top:-3px;width:70px;" ReadOnly> 
						</nobr>
						</td>
					</tr>	
					<tr>
						<td style="width:74px;height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;소 속 명&nbsp;</td>
						<td style="border:0 solid #708090;border-bottom-width:1px;" colspan=2>&nbsp;
						  <input id="txt_deptcd"  type="text"   class="txtbox"  style= "position:relative;left:-5px;width:50px;height:20px;" ReadOnly>
						  <input id="txt_deptnm"  type="text"   class="txtbox"  style= "position:relative;left:-5px;width:117px;height:20px;" ReadOnly>
<!-- 							<input id="txt_deptnm" type="text"		class="txtbox" style= "position:relative;left:-6px;top:1px;width:90px; height:20px;" disabled>
 -->							<!-- <comment id="__NSID__"><object id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative; left:0px;top:2px;" height=180 width=160 class="txtbox">
								<param name=ComboDataID           value=gcds_deptcd>
								<param name=SearchColumn          value="DEPTNM">
								<param name=Sort                  value="false">
								<param name=ListExprFormat        value="DEPTNM^0^150">       
								<param name=BindColumn            value="DEPTCD"> 
							</object></comment><script>__ws__(__NSID__);</script> -->
						</td>
					</tr>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox"><nobr>&nbsp;출근일자&nbsp;</nobr></td>
						<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
							<comment id="__NSID__"><object id=gcem_attday classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:-5px;top:2px; width:70px; height:20px;" class="txtbox"	>
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=ReadOnly      value="true">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
							
							<!-- <img src="../../Common/img/btn/com_btn_calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_attday', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"> -->
						</td>
					</tr>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox"><nobr>&nbsp;출근시간&nbsp;</nobr></td>
						<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px">&nbsp;
							<comment id="__NSID__"><object id=gcem_atttime classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:-5px;top:3px;width:35px;height:20px;" class="txtbox"  ReadOnly>
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="00:00">
								<param name=MaxLength     value=6>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>

							<!-- <img src="../../Common/img/btn/com_btn_atttime.gif" style="position:relative;left:5px;top:2px;cursor:hand;" BORDER="0" onclick="ln_AttTime()"> -->
						</td>
					</tr>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox"><nobr>&nbsp;퇴근일자&nbsp;</nobr></td>
						<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gcem_cloday classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:-5px;top:2px; width:70px; height:20px;" class="txtbox"  >
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=ReadOnly      value="true">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
					
					<!-- <img src="../../Common/img/btn/com_btn_calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_cloday', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"> --></nobr>
				</td>
			</tr>
			<tr>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox"><nobr>&nbsp;퇴근시간&nbsp;</nobr></td>
				<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
					<comment id="__NSID__"><object id=gcem_clotime classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:-5px;top:2px; width:35px; height:20px;" class="txtbox"  ReadOnly>
						<param name=Text          value="">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=ClipMode			value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="00:00">
						<param name=MaxLength     value=6>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
			    </object></comment><script>__ws__(__NSID__);</script><nobr>
					<!-- <img src="../../Common/img/btn/com_btn_clotime.gif" style="position:relative;left:5px;top:2px;cursor:hand;" BORDER="0" onclick="ln_CloTime()"> -->
						
				</td>
			</tr>
			<tr>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox"><nobr>&nbsp;비 고1&nbsp;</nobr></td>
				<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
					<textarea id="txt_etc" class="txtbox"  style= "width:207px; height:74px; overflow:auto;position:relative;left:-6px" maxlength="40" onBlur="bytelength(this,this.value,40);" ReadOnly ></textarea>
				</td>
			</tr>
			<tr>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox"><nobr>&nbsp;비 고2&nbsp;</nobr></td>
				<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
					<textarea id="txt_etc2" class="txtbox"  style= "width:207px; height:74px; overflow:auto;position:relative;left:-6px" maxlength="40" onBlur="bytelength(this,this.value,40);"  ></textarea>
				</td>
			</tr>
			<tr>
				<td colspan=6 style="height:100%;border:0 solid #708090;">&nbsp;</td>
			</tr>
				</table>
				</td>
			</tr>
	<!-- <tr>
		<td colspan="2" height="34" align="left" class="txtbox">조회건수 : <label id="lbl_search"></label></td>
  </tr> -->

</table>

<!-----------------------------------------------------------------------------
	● Description : B I N D I N G
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=DEPTCD       Ctrl=txt_deptcd		    Param=value </C>
		<C>Col=DEPTNM       Ctrl=txt_deptnm				Param=value </C>
		<C>Col=EMPNO				Ctrl=gcem_empno				Param=text </C>
		<C>Col=EMPNMK       Ctrl=txt_empnm				Param=value	</C>
		<C>Col=ATTDAY       Ctrl=gcem_attday			Param=text	</C>
		<C>Col=ATTTIME			Ctrl=gcem_atttime			Param=text	</C>
		<C>Col=CLODAY       Ctrl=gcem_cloday			Param=text	</C>
		<C>Col=CLOTIME      Ctrl=gcem_clotime			Param=text	</C>
		<C>Col=ETC					Ctrl=txt_etc					Param=value	</C>
		<C>Col=ETC2					Ctrl=txt_etc2					Param=value	</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	● Description : P R I N T I N G
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
  <!-- <PARAM NAME="MasterDataID"			VALUE="gcds_data"> -->
  <PARAM NAME="DetailDataID"			VALUE="gcds_print">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
  <PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            VALUE="
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=422 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=28 ,top=244 ,right=125 ,bottom=422 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=122 ,top=244 ,right=541 ,bottom=422 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=541 ,top=244 ,right=719 ,bottom=422 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=719 ,top=244 ,right=1050 ,bottom=422 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='출 역 월 보' ,left=38 ,top=6 ,right=1916 ,bottom=150 ,face='HY견고딕' ,size=24 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=1581 ,top=244 ,right=1919 ,bottom=422 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=1738 ,top=337 ,right=1738 ,bottom=422 </L>
	<L> left=25 ,top=422 ,right=1916 ,bottom=422 </L>
	<L> left=1375 ,top=337 ,right=1375 ,bottom=422 </L>
	<L> left=763 ,top=159 ,right=1200 ,bottom=159 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='일 자' ,left=722 ,top=347 ,right=922 ,bottom=412 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='토요일:13:00' ,left=288 ,top=169 ,right=575 ,bottom=234 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='평일:20:00' ,left=38 ,top=169 ,right=281 ,bottom=234 ,align='left' ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=1378 ,top=244 ,right=1584 ,bottom=422 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1047 ,top=244 ,right=1384 ,bottom=422 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='일자' ,left=1053 ,top=347 ,right=1253 ,bottom=412 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=1253 ,top=337 ,right=1253 ,bottom=422 </L>
	<L> left=925 ,top=337 ,right=925 ,bottom=422 </L>
	<T>id='시간' ,left=1256 ,top=347 ,right=1375 ,bottom=412 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='시 간' ,left=928 ,top=347 ,right=1047 ,bottom=412 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=1581 ,top=337 ,right=1919 ,bottom=337 </L>
	<L> left=719 ,top=337 ,right=1384 ,bottom=337 </L>
	<T>id='성명' ,left=544 ,top=303 ,right=713 ,bottom=369 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='소속명' ,left=125 ,top=303 ,right=538 ,bottom=369 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='확  인' ,left=1631 ,top=266 ,right=1841 ,bottom=331 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='본인' ,left=1584 ,top=347 ,right=1734 ,bottom=412 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='관리자' ,left=1741 ,top=347 ,right=1913 ,bottom=412 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='CUMONTH', left=1831, top=172, right=1919, bottom=237 ,mask='XX월', face='굴림체', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CUYEAR', left=1678, top=172, right=1819, bottom=237 ,mask='XXXX년', face='굴림체', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='비고' ,left=1409 ,top=303 ,right=1544 ,bottom=369 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='NO' ,left=34 ,top=303 ,right=119 ,bottom=369 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='출  근' ,left=725 ,top=262 ,right=1031 ,bottom=328 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='퇴  근' ,left=1069 ,top=262 ,right=1372 ,bottom=328 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=31 ,top=244 ,right=1919 ,bottom=247 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=28 ,top=247 ,right=28 ,bottom=419 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1922 ,top=250 ,right=1919 ,bottom=419 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=81 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1738 ,top=0 ,right=1738 ,bottom=81 </L>
	<L> left=925 ,top=0 ,right=925 ,bottom=81 </L>
	<L> left=1383 ,top=0 ,right=1383 ,bottom=81 </L>
	<L> left=1253 ,top=0 ,right=1253 ,bottom=81 </L>
	<L> left=1919 ,top=0 ,right=1919 ,bottom=81 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=28 ,top=0 ,right=28 ,bottom=81 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=122 ,top=0 ,right=122 ,bottom=81 </L>
	<L> left=31 ,top=87 ,right=1919 ,bottom=81 </L>
	<L> left=1583 ,top=0 ,right=1583 ,bottom=81 </L>
	<L> left=719 ,top=0 ,right=719 ,bottom=81 </L>
	<L> left=541 ,top=0 ,right=541 ,bottom=81 </L>
	<C>id='ATTDAY', left=722, top=12, right=922, bottom=78 ,mask='XXXX/XX/XX', face='굴림체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=544, top=12, right=719, bottom=78, align='left', face='굴림체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ETC', left=1388, top=12, right=1575, bottom=78, face='굴림체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=1</C>
	<C>id='CLODAY', left=1053, top=12, right=1253, bottom=78 ,mask='XXXX/XX/XX', face='굴림체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{CurRow}', left=31, top=12, right=116, bottom=78, face='굴림체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATTTIME', left=928, top=12, right=1047, bottom=78 ,mask='XX:XX', face='굴림체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1047 ,top=0 ,right=1047 ,bottom=81 </L>
	<C>id='CLOTIME', left=1256, top=12, right=1375, bottom=78 ,mask='XX:XX', face='굴림체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTNM', left=122, top=12, right=538, bottom=78, align='left', face='굴림체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2000 ,bottom=334 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=31 ,top=78 ,right=1916 ,bottom=162 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='WRITENM', left=488, top=97, right=834, bottom=147, align='left', face='굴림체', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<X>left=31 ,top=6 ,right=119 ,bottom=78 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=119 ,top=6 ,right=119 ,bottom=75 </L>
	<L> left=1913 ,top=241 ,right=103 ,bottom=241 </L>
	<X>left=122 ,top=6 ,right=1916 ,bottom=78 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='작 성 자:' ,left=256 ,top=94 ,right=475 ,bottom=147 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='담     당' ,left=256 ,top=178 ,right=469 ,bottom=228 ,face='굴림체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관 리 책 임 자' ,left=791 ,top=178 ,right=1131 ,bottom=228 ,face='굴림체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부  서  장' ,left=1475 ,top=178 ,right=1728 ,bottom=228 ,face='굴림체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=28 ,top=78 ,right=1919 ,bottom=78 </L>
	<L> left=1919 ,top=3 ,right=1919 ,bottom=331 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=100 ,top=162 ,right=100 ,bottom=331 </L>
	<L> left=663 ,top=162 ,right=663 ,bottom=334 </L>
	<L> left=1278 ,top=162 ,right=1278 ,bottom=334 </L>
	<T>id='결' ,left=38 ,top=184 ,right=97 ,bottom=244 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='재' ,left=38 ,top=250 ,right=97 ,bottom=306 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=28 ,top=162 ,right=1919 ,bottom=162 </L>
	<L> left=25 ,top=3 ,right=1919 ,bottom=3 </L>
	<S>id='{Sum(OVERWK)}' ,left=1388 ,top=16 ,right=1566 ,bottom=66 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=1</S>
	<T>id='계' ,left=31 ,top=9 ,right=116 ,bottom=78 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=1916 ,top=334 ,right=28 ,bottom=334 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=28 ,top=3 ,right=28 ,bottom=334 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2539 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=31 ,top=0 ,right=1916 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=28 ,top=0 ,right=1916 ,bottom=78 ,face='굴림체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>