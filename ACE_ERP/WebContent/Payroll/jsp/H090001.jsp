<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	계약직/출퇴근등록
+ 프로그램 ID	: h090001
+ 기 능 정 의	: 일별근태신청
+ 최 초 이 력	: 이순미
+ 변 경 이 력	: 
+ 서 블 릿 명	: h090001_s1, h090001_t1
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>출퇴근등록</title>
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


var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	ln_DeptQuery();

	gcem_frdt.text = gcurdate.substring(0,4)+gcurdate.substring(5,7);;

	ln_DeptQuery2();	//소속명, 성명 조회
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";

	var str1 = gclx_deptcd1.BindColVal;
	var str2 = gcem_frdt.text;
	var str3 = gusrid;

	gcds_data.DataID = "/servlet/Contract.h090001_s1?v_str1="+str1+"&v_str2="+fn_trim(str2)+"&v_str3="+str3;
	gcds_data.Reset();

}

/*-----------------------------------------------------------------------------
		Description : 조회[소속]
-----------------------------------------------------------------------------*/
function ln_DeptQuery2() {

	gcds_deptcd3.DataID = "/servlet/Contract.h090001_s2?v_str1="+gusrid;
	gcds_deptcd3.Reset();

	gclx_deptcd.BindColVal = gcds_deptcd3.namevalue(gcds_deptcd3.rowposition,"DEPTCD");
	gclx_deptcd1.BindColVal = gcds_deptcd3.namevalue(gcds_deptcd3.rowposition,"DEPTCD");
	txt_empno.value = gusrid;
	txt_empnm.value = gusrnm;

/*
	var row = gcds_deptcd3.rowposition;
	if (txt_deptno2.value != "" || gcds_data2.namevalue(row,"DEPTCD") != null) {
		txt_deptno2.value	= gcds_data2.namevalue(row,"DEPTCD");		//소속명
		gclx_deptcd.BindColVal = txt_deptno2.value;
	} else {
		gclx_deptcd.index= 0;
	}
*/

}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

	gcds_data.addrow();

	ln_DeptQuery2();

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
	
	if (!ln_Valchk()) return;

	if (txt_empno.value == "") {
		//txt_empno.value = gcds_data.namevalue(gcds_data.rowposition,"EMPNO");
	}else{
		gcds_data.namevalue(gcds_data.rowposition,"EMPNO") = txt_empno.value;
	}

	if (gcds_data.IsUpdated) {
	//prompt('',gcds_data.text);
		if (confirm("입력하신 사항을 등록하시겠습니까?")){	
		gctr_data.Action = "/servlet/Contract.h090001_t1";
		gctr_data.post();
		ln_Query();
		}
	}
}

/******************************************************************************
	Description : 입력값 체크[근태관리]
******************************************************************************/
function ln_Valchk() {

	if (gclx_deptcd.BindColVal == "") { 
		alert("정확한 소속명을 입력해 주십시오."); 
		gclx_deptcd.focus()
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
		gctr_data.action = "/servlet/Contract.h090001_t1";
		gctr_data.post();
		ln_Query();
	}
 }

/******************************************************************************
	Description : 출근시간
******************************************************************************/
function ln_AttTime() {

	if (gcem_atttime.text != "") { return false;}	//재입력 불가 

	var row = gcds_curtime.rowposition;

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

	if (gcem_clotime.text != "") { return false;}	//재입력 불가 

	var row = gcds_curtime.rowposition;

	if (confirm("퇴근시간정보를 입력하시겠습니까?\n입력하신 정보는 변경할 수 없습니다.")){

		gcds_curtime.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050001_s1_time";
		gcds_curtime.Reset();

		var h_time = gcds_curtime.namevalue(row,"TOTIME").substring(0,2);
		var m_time = gcds_curtime.namevalue(row,"TOTIME").substring(3,5);
		var s_time = gcds_curtime.namevalue(row,"TOTIME").substring(6,8);

		gcem_clotime.text = h_time + m_time + s_time;
	}else {
		//gcds_data.Undo(gcds_data.RowPosition);	//취소할경우
		return false;
	}

}

/******************************************************************************
	Description : 성명 찾기
******************************************************************************/
function ln_Popup(e){

	if (txt_empnm.value != "" && gcem_attday.text !="" && gcem_attday.text !="" ) {
		return false;
	}

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
		if (e=="txt_empnm") txt_empno.value = arrParam[1];	
	} else {
		eval(e).value = "";
		if (e=="txt_empnm") txt_empno.value = "";	
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
				gcds_print.namevalue(i,"WRITENM")	= gusrnm;
				gcds_print.namevalue(i,"CUYEAR")	= gcurdate.substring(0,4);	//년
				gcds_print.namevalue(i,"CUMONTH")	= gcurdate.substring(5,7);	//월
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

}

/******************************************************************************
	Description : 소속 조회
******************************************************************************/
function ln_DeptQuery(){

	gcds_deptcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?";
	gcds_deptcd.Reset();

	gcds_deptcd1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?";
	gcds_deptcd1.Reset();

}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="TRUE">
	<!-- <param name=SubSumExpr value="TOTAL, 1:DEPTNM"> -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- 검색 소속 -->
<comment id="__NSID__"><OBJECT id=gcds_deptcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- 접속자 개인 소속 -->
<comment id="__NSID__"><OBJECT id=gcds_deptcd3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- Bind 소속 -->
<comment id="__NSID__"><OBJECT id=gcds_deptcd1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

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
	<PARAM NAME="KeyValue" VALUE="H090001_t1(I:USER=gcds_data)">
</OBJECT></comment><script>__ws__(__NSID__);</script>
	
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
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
	// document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//근태총 조회 건수
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");

		ln_DeptQuery2();
		
		//txt_empno.value = gusrid;
		//txt_empnm.value = gusrnm;
	}

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";

</script>

<script language="javascript" for="gcds_deptcd" event="onloadCompleted(row,colid)">
	gcds_deptcd.insertrow(1);
	gcds_deptcd.namevalue(1,"DEPTCD") = "";
	gcds_deptcd.namevalue(1,"DEPTNM") = "전체";
	gclx_deptcd.index = 0;
</script>

<script language="javascript" for="gcds_deptcd1" event="onloadCompleted(row,colid)">
	gcds_deptcd1.insertrow(1);
	gcds_deptcd1.namevalue(1,"DEPTCD") = "";
	gcds_deptcd1.namevalue(1,"DEPTNM") = "전체";
	gclx_deptcd1.index = 0;
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


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/h090001_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<!-- <img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand"	onclick="ln_Print()"> -->
			<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand"	onclick="ln_Delete()">
			<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()" >
			<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
  </tr>
</table>

	<table  cellpadding="1" cellspacing="0" border="0"  style='position:relative;left:3px;width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
    <tr> 
			<td width="10" align=CENTER  style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp;&nbsp;소 속 명&nbsp;&nbsp;</nobr></td>
			<td width="10"style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
				<comment id="__NSID__"><OBJECT id=gclx_deptcd1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative; left:0px;top:2px;" height=180 width=160 class="txtbox">
					<param name=ComboDataID           value=gcds_deptcd1>
					<param name=SearchColumn          value="DEPTNM">
					<param name=Sort                  value="false">
					<param name=SortColumn						value="DEPTNM">
					<param name=ListExprFormat        value="DEPTNM^0^150">       
					<param name=BindColumn            value="DEPTCD">
					<param name=enable								value=false>
				</OBJECT></comment><script>__ws__(__NSID__);</script>
			</td>
			<td width="10" align=CENTER  style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp;&nbsp;적용년월&nbsp;&nbsp;</nobr></td>
			<td width="10"style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;
				<comment id="__NSID__"><OBJECT id=gcem_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:0px;top:2px; width:50px; height:20px;" class="txtbox"	validFeatures="ignoreStatus=yes" validExp="">
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
			</td>
			<td width="550">&nbsp;</td>
		</tr>
	</table>

	<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td>
				<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data style="position:relative;top:3px;WIDTH:568px;HEIGHT: 415px;border:1 solid #777777;display:block;" viewastext class="txtbox">
					<PARAM NAME="DataID"			VALUE="gcds_data">
					<PARAM NAME="Editable"		VALUE="false">
					<PARAM NAME="BorderStyle" VALUE="0">
					<param name="Fillarea"		VALUE="true">
					<PARAM NAME="Format"			VALUE="  
						<C> Name='소속명'			ID=DEPTCD  	HeadAlign=Center HeadBgColor=#B9D4DC Width=160	align=LEFT		Edit=None		EditStyle=Lookup Data='gcds_deptcd:DEPTCD:DEPTNM'</C> 
						<C> Name='성명'				ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT		Edit=None		</C>
						<G> Name='출근'				HeadAlign=Center HeadBgColor=#B9D4DC 
							<C> Name='일자'	ID=ATTDAY		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=CENTER	Edit=None	Mask='XXXX/XX/XX'</C>
							<C> Name='시간'	ID=ATTTIME	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=CENTER	Edit=None	Mask='XX:XX'</C>
						</G>
						<G> Name='퇴근'				HeadAlign=Center HeadBgColor=#B9D4DC
							<C> Name='일자'	ID=CLODAY		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=CENTER	Edit=None	Mask='XXXX/XX/XX'</C>
							<C> Name='시간'	ID=CLOTIME	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=CENTER	Edit=None	Mask='XX:XX'</C>
						</G>
						<C> Name='시간외;근무'	ID=OVERWK		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=RIGHT		Edit=realNumeric  Dec=1 </C>
					">
				</OBJECT></comment><script>__ws__(__NSID__);</script>
			</td>
			<td>

				<table border= "0" cellpadding=0 cellspacing=0  border=0  style='position:relative;left:0px;top:2px;width:304px;height:415px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr>
						<td style="width:74px;height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;소 속 명&nbsp;</td>
						<td style="border:0 solid #708090;border-bottom-width:1px;" colspan=2>&nbsp;
							<comment id="__NSID__"><OBJECT id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative; left:0px;top:2px;" height=180 width=160 class="txtbox">
								<param name=ComboDataID           value=gcds_deptcd>
								<param name=SearchColumn          value="DEPTNM">
								<param name=Sort                  value="false">
								<param name=SortColumn						value="DEPTNM">
								<param name=ListExprFormat        value="DEPTNM^0^150">       
								<param name=BindColumn            value="DEPTCD"> 
								<param name=enable								value="FALSE">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명&nbsp;</td>
						<td style="border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;" colspan=2>&nbsp;
							<input id="txt_empno" name="txt_empno" type="hidden"  class="txtbox">
							<input id="txt_empnm" name="txt_empnm" type="text"		class="txtbox" style= "position:relative;left:-12px;top:1px;width:90px; height:20px;" disabled>
							<!-- <img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="성명을 검색합니다" style="cursor:hand;position:relative;left:-12px;" align=center onclick="ln_Popup('txt_empnm');"> -->
						</td>
					</tr>	
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox"><nobr>&nbsp;출근일자&nbsp;</nobr></td>
						<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
							<comment id="__NSID__"><OBJECT id=gcem_attday classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px;" class="txtbox"	validFeatures="ignoreStatus=yes" validExp="">
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
								<param name=InheritColor  value=false>
							</OBJECT></comment><script>__ws__(__NSID__);</script>
							
							<img src="../../Common/img/btn/com_btn_calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_attday', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">
						</td>
					</tr>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox"><nobr>&nbsp;출근시간&nbsp;</nobr></td>
						<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px">&nbsp;
							<comment id="__NSID__"><OBJECT id=gcem_atttime classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px;width:35px;height:20px;" class="txtbox" validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="00:00:00">
								<param name=MaxLength     value=6>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</OBJECT></comment><script>__ws__(__NSID__);</script>

							<img src="../../Common/img/btn/com_btn_atttime.gif" style="position:relative;left:5px;top:2px;cursor:hand;" BORDER="0" onclick="ln_AttTime()">
						</td>
					</tr>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox"><nobr>&nbsp;종료일자&nbsp;</nobr></td>
						<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"><nobr>&nbsp;
							<comment id="__NSID__"><OBJECT id=gcem_cloday classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px;" class="txtbox" validFeatures="ignoreStatus=yes" validExp="">
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
								<param name=InheritColor  value=false>
							</OBJECT></comment><script>__ws__(__NSID__);</script>
					
					<img src="../../Common/img/btn/com_btn_calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_cloday', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"></nobr>
				</td>
			</tr>
			<tr>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox"><nobr>&nbsp;퇴근시간&nbsp;</nobr></td>
				<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_clotime classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:35px; height:20px;" class="txtbox" validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=ClipMode			value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="00:00:00">
						<param name=MaxLength     value=6>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=enable				value=false>
			    </OBJECT></comment><script>__ws__(__NSID__);</script><nobr>
					<img src="../../Common/img/btn/com_btn_clotime.gif" style="position:relative;left:5px;top:2px;cursor:hand;" BORDER="0" onclick="ln_CloTime()">
				</td>
			</tr>
			<tr>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox"><nobr>&nbsp;시간외근무&nbsp;</nobr></td>
				<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_overwk classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:0px;top:2px; width:50px; height:20px;" class="txtbox"	validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text						value="">
						<param name=Alignment				value=2>
						<param name=ClipMode				value=true>
						<param name=Border					value=true>
						<param name=Numeric					value=true>
						<param name=MaxLength				value=4>
						<param name=MaxDecimalPlace value=1>
					</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
				</td>
			</tr>
			<tr>
				<td colspan=6 style="height:100%;border:0 solid #708090;">&nbsp;</td>
			</tr>
				</table>
				</td>
			</tr>
	<tr>
		<td colspan="2" height="34" align="left" class="txtbox">조회건수 : <label id="lbl_search"></label></td>
  </tr>	
</table>

<!-----------------------------------------------------------------------------
	● Description : B I N D I N G
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=DEPTCD       Ctrl=gclx_deptcd			Param=BindColVal</C>
		<C>Col=EMPNO				Ctrl=gclx_empno				Param=value			</C>
		<C>Col=EMPNMK       Ctrl=txt_empnm				Param=value			</C>
		<C>Col=ATTDAY       Ctrl=gcem_attday			Param=text			</C>
		<C>Col=ATTTIME			Ctrl=gcem_atttime			Param=text			</C>
		<C>Col=CLODAY       Ctrl=gcem_cloday			Param=text			</C>
		<C>Col=CLOTIME      Ctrl=gcem_clotime			Param=text			</C>
		<C>Col=OVERWK				Ctrl=gcem_overwk			Param=text			</C>
	'>
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	● Description : P R I N T I N G
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
  <!-- <PARAM NAME="MasterDataID"			VALUE="gcds_data"> -->
  <PARAM NAME="DetailDataID"			VALUE="gcds_print">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
  <PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            VALUE="
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=420 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='출 역 월 보' ,left=37 ,top=5 ,right=1916 ,bottom=151 ,face='HY견고딕' ,size=24 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=1580 ,top=243 ,right=1918 ,bottom=421 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=1577 ,top=246 ,right=1577 ,bottom=336 </L>
	<L> left=119 ,top=238 ,right=119 ,bottom=421 </L>
	<L> left=749 ,top=238 ,right=749 ,bottom=421 </L>
	<L> left=540 ,top=238 ,right=540 ,bottom=421 </L>
	<L> left=1577 ,top=238 ,right=1577 ,bottom=421 </L>
	<L> left=1736 ,top=339 ,right=1736 ,bottom=421 </L>
	<L> left=26 ,top=238 ,right=1918 ,bottom=241 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=26 ,top=421 ,right=1916 ,bottom=421 </L>
	<L> left=29 ,top=241 ,right=29 ,bottom=421 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1376 ,top=336 ,right=1376 ,bottom=421 </L>
	<X>left=751 ,top=243 ,right=1064 ,bottom=421 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=762 ,top=159 ,right=1201 ,bottom=159 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='일 자' ,left=754 ,top=347 ,right=939 ,bottom=413 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=1921 ,top=238 ,right=1918 ,bottom=421 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='토요일:13:00' ,left=286 ,top=169 ,right=574 ,bottom=235 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='평일:20:00' ,left=37 ,top=169 ,right=280 ,bottom=235 ,align='left' ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1376 ,top=238 ,right=1376 ,bottom=336 </L>
	<X>left=1378 ,top=243 ,right=1577 ,bottom=421 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1064 ,top=243 ,right=1376 ,bottom=421 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='일자' ,left=1066 ,top=347 ,right=1254 ,bottom=413 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=1254 ,top=336 ,right=1254 ,bottom=421 </L>
	<L> left=1064 ,top=336 ,right=1064 ,bottom=421 </L>
	<L> left=942 ,top=336 ,right=942 ,bottom=421 </L>
	<T>id='시간' ,left=1257 ,top=347 ,right=1376 ,bottom=413 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='시 간' ,left=945 ,top=347 ,right=1064 ,bottom=413 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=1064 ,top=238 ,right=1064 ,bottom=336 </L>
	<L> left=1577 ,top=336 ,right=1918 ,bottom=336 </L>
	<X>left=122 ,top=243 ,right=540 ,bottom=421 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=749 ,top=336 ,right=1376 ,bottom=336 </L>
	<X>left=32 ,top=243 ,right=119 ,bottom=421 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=542 ,top=243 ,right=749 ,bottom=421 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='성명' ,left=545 ,top=304 ,right=749 ,bottom=370 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='소속명' ,left=124 ,top=304 ,right=537 ,bottom=370 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='NO' ,left=32 ,top=304 ,right=116 ,bottom=370 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='근무' ,left=1408 ,top=333 ,right=1545 ,bottom=400 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='시간외' ,left=1408 ,top=265 ,right=1545 ,bottom=331 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='퇴  근' ,left=1069 ,top=265 ,right=1373 ,bottom=331 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='출  근' ,left=757 ,top=265 ,right=1061 ,bottom=331 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='확  인' ,left=1630 ,top=265 ,right=1842 ,bottom=331 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='본인' ,left=1585 ,top=347 ,right=1733 ,bottom=413 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='관리자' ,left=1741 ,top=347 ,right=1913 ,bottom=413 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='CUMONTH', left=1831, top=172, right=1918, bottom=238 ,mask='XX월', face='굴림체', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CUYEAR', left=1677, top=172, right=1820, bottom=238 ,mask='XXXX년', face='굴림체', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=87 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1736 ,top=0 ,right=1736 ,bottom=85 </L>
	<L> left=942 ,top=0 ,right=942 ,bottom=85 </L>
	<L> left=1376 ,top=0 ,right=1376 ,bottom=85 </L>
	<L> left=1254 ,top=0 ,right=1254 ,bottom=85 </L>
	<L> left=1918 ,top=0 ,right=1918 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=0 ,right=29 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=119 ,top=0 ,right=119 ,bottom=85 </L>
	<L> left=32 ,top=87 ,right=1918 ,bottom=87 </L>
	<L> left=1577 ,top=0 ,right=1577 ,bottom=85 </L>
	<L> left=749 ,top=0 ,right=749 ,bottom=85 </L>
	<L> left=540 ,top=0 ,right=540 ,bottom=85 </L>
	<C>id='ATTDAY', left=754, top=11, right=939, bottom=77 ,mask='XXXX/XX/XX', face='굴림체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=545, top=11, right=749, bottom=77, align='left', face='굴림체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='OVERWK', left=1386, top=11, right=1566, bottom=77, face='굴림체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=1</C>
	<C>id='CLODAY', left=1066, top=11, right=1254, bottom=77 ,mask='XXXX/XX/XX', face='굴림체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{CurRow}', left=32, top=11, right=116, bottom=77, face='굴림체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATTTIME', left=945, top=11, right=1064, bottom=77 ,mask='XX:XX', face='굴림체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1064 ,top=0 ,right=1064 ,bottom=85 </L>
	<C>id='CLOTIME', left=1257, top=11, right=1376, bottom=77 ,mask='XX:XX', face='굴림체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTNM', left=122, top=11, right=537, bottom=77, align='left', face='굴림체', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2000 ,bottom=350 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=32 ,top=79 ,right=1916 ,bottom=161 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='WRITENM', left=487, top=98, right=833, bottom=146, align='left', face='굴림체', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<X>left=32 ,top=5 ,right=119 ,bottom=77 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=119 ,top=5 ,right=119 ,bottom=74 </L>
	<L> left=1913 ,top=241 ,right=103 ,bottom=241 </L>
	<X>left=122 ,top=5 ,right=1916 ,bottom=77 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='작 성 자:' ,left=257 ,top=95 ,right=474 ,bottom=146 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='담     당' ,left=257 ,top=177 ,right=468 ,bottom=228 ,face='굴림체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관 리 책 임 자' ,left=791 ,top=177 ,right=1132 ,bottom=228 ,face='굴림체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부  서  장' ,left=1476 ,top=177 ,right=1728 ,bottom=228 ,face='굴림체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=77 ,right=1918 ,bottom=77 </L>
	<L> left=1918 ,top=3 ,right=1918 ,bottom=331 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=3 ,right=29 ,bottom=331 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=101 ,top=164 ,right=101 ,bottom=331 </L>
	<L> left=664 ,top=161 ,right=664 ,bottom=333 </L>
	<L> left=1278 ,top=161 ,right=1278 ,bottom=333 </L>
	<T>id='결' ,left=37 ,top=185 ,right=98 ,bottom=243 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='재' ,left=37 ,top=249 ,right=98 ,bottom=307 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=161 ,right=1918 ,bottom=161 </L>
	<L> left=1916 ,top=331 ,right=29 ,bottom=331 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=26 ,top=3 ,right=1918 ,bottom=3 </L>
	<S>id='{Sum(OVERWK)}' ,left=1389 ,top=16 ,right=1566 ,bottom=66 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=1</S>
	<T>id='계' ,left=32 ,top=8 ,right=116 ,bottom=77 ,face='굴림체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
</B>
<B>id=Footer ,left=0 ,top=2539 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=32 ,top=0 ,right=1916 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=29 ,top=0 ,right=1916 ,bottom=79 ,face='굴림체' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

	">
</OBJECT></comment><script>__ws__(__NSID__);</script>


</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	


