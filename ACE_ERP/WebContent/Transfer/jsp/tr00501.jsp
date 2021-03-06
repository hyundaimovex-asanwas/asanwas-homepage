<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	: 공통코드관리
+ 프로그램 ID	: TR00501
+ 기 능 정 의	: 조회|등록|저장|삭제
+ 변 경 이 력	: 박재성
+ 서 블 릿 명	: tr00501_s1, tr00501_s2, tr00501_s3, tr00501_t1, tr00501_t2
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 :
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 :
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="transfer.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 및 기타 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());
%>


<!-- HTML 시작-->
<html>
	<head>
   <jsp:include page="/Transfer/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script 시작
=============================================================================*/
%>


<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	get_cookdata();

    var gs_date = '<%=firstday%>';
	var gs_date1 = gs_date.substring(0,6) + "01";

	/*----------------------------------------------------------------------------
	 * 페이지로딩
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]

			ln_Start();//선조회

			window.status="완료";

		}
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){

			get_cookdata();
		
			ln_MajorQuery();
		
			txt_majorcd1.value = "";
			txt_majornm2.value = "";
			txt_useyn2.checked = false;
			txt_memo2.value = "";
			txt_minorcd.readonly =true ;


}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";


	var str1 = tb_majorcd.BindColVal;
	
	gcds_hcl.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=" + str1; 

	gcds_hcl.Reset();
	gcds_hcl.rowposition=1;



	if (gcds_hcl.namevalue(1,"USEYN") == "T") {
		txt_useyn.checked = true;
	} else {
		txt_useyn.checked = false;
	}

	var row = gcds_hch.rowposition;

	txt_majorcd1.value = str1; 
	txt_majorcd1.disabled = true;
	txt_majornm2.value = gcds_hch.namevalue(row,"MAJORNM");
	
	if (gcds_hch.namevalue(row,"USEYN") == "T") {	
		txt_useyn2.checked = true; 
	} else {
		txt_useyn2.checked = false;
	}
	
	txt_memo2.value = gcds_hch.namevalue(row,"MEMO");

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_MajorQuery(){

	gcds_hch.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s2?v_str1="; 
	gcds_hch.Reset(); 

	tb_majorcd.BindColVal = gcds_hch.namevalue(gcds_hch.rowposition,"MAJORNM");
	tb_majorcd.index = 0;

}
/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

	gcds_hcl.addrow();


	for(i=1;i<=gcds_hcl.countrow;i++){

		if(gcds_hcl.NameValue(i,"USEYN") == "T"){
			txt_useyn.checked = true; 
		}else{
			txt_useyn.checked = false;
		}
	}

	var row = gcds_hcl.rowposition;
	gcds_hcl.namevalue(row, "MAJORCD") = tb_majorcd.bindcolval;

}

/*-----------------------------------------------------------------------------
 #  상위코드  : 추가
-----------------------------------------------------------------------------*/
function ln_Add2(){

	txt_majorcd1.value	=	"";
	txt_majornm2.value		=	"";
	txt_useyn2.checked	=	false;
	txt_memo2.value			=	"";
	
	ln_TempSave();

	txt_majorcd1.disabled = false;
	txt_majorcd1.focus();

	gcds_hcl.ClearData();

}

/******************************************************************************
	Description : 하위코드 저장
******************************************************************************/
function ln_Save(){

	var row = gcds_hcl.rowposition;

	if (txt_useyn.checked==false) {gcds_hcl.namevalue(row,"USEYN")='F'} else gcds_hcl.namevalue(row,"USEYN")='T'; 

	if (!ln_Valchk()) return;

	if (gcds_hcl.IsUpdated) {	//하위코드 조회
	
		if (confirm("입력하신 사항을 등록하시겠습니까?")){
			gctr_hcl.KeyValue = "tr00501_t1(I:USER=gcds_hcl)";
			gctr_hcl.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_t1";
			gctr_hcl.post();
			return ln_Query();
		}
	}
}

/*-----------------------------------------------------------------------------
 #  상위코드  : 저장
-----------------------------------------------------------------------------*/
function ln_Save2() {

	var row		= gcds_hch.rowposition;
	var rtemp = gcds_temp.rowposition;

	gcds_temp.namevalue(rtemp,"MAJORCD")	=	txt_majorcd1.value;
	gcds_temp.namevalue(rtemp,"MAJORNM")	=	txt_majornm2.value;
	gcds_temp.namevalue(rtemp,"MEMO")		=	txt_memo2.value;
	gcds_temp.namevalue(rtemp,"MEMO")		=	txt_memo2.value;

	if (txt_useyn2.checked ==	false) { gcds_temp.namevalue(rtemp,"USEYN") = "F"; 
	}else { gcds_temp.namevalue(rtemp,"USEYN") = "T"; }

	if (!ln_Valchk1()) return;
	if (!ln_Valchk2()) return;

}

/******************************************************************************
	Description : 상위코드 임시저장
******************************************************************************/
function ln_TempSave() {

	var THeader = "MAJORCD:String(4),MAJORNM:String(30),USEYN:String(1),MEMO:String(30)";

	gcds_temp.SetDataHeader(THeader);

	gcds_temp.addrow();

}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){

	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_hcl.deleterow(gcds_hcl.rowposition);
		gctr_hcl.KeyValue = "tr00501_t1(I:USER=gcds_hcl)";
		gctr_hcl.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_t1";
		gctr_hcl.post();
		return ln_Query();
	}
}

/*-----------------------------------------------------------------------------
 #  상위코드  : 삭제
-----------------------------------------------------------------------------*/
function ln_Delete2(){

	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_hch.deleterow(gcds_hch.rowposition);
		gctr_hch.KeyValue = "tr00501_t2(I:USER=gcds_hch)";
		gctr_hch.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_t2";
		gctr_hch.post();
		tb_majorcd.index = 0;
		return ln_Query();
	}
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

	gcds_hcl.undo(gcds_hcl.rowposition);
	return ln_Query();

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
	Descrition : CheckBox
******************************************************************************/
function ln_Chkbox(e,a){

	var row = gcds_hcl.rowposition;

	if (e.checked) gcds_hcl.namevalue(row,a) = "T";
	else gcds_hcl.namevalue(row,a) = "F";
}

/******************************************************************************
	Description : 입력값 체크[하위코드]
******************************************************************************/
function ln_Valchk() {

	if (fn_trim(txt_minorcd.value) == "") {			
		alert("정확한 하위코드를 입력해 주십시오");
		txt_minorcd.value = "";
		txt_minorcd.focus();
		return false;
	}

	if (fn_trim(txt_minornm.value)== "") {			
		alert("정확한 하위코드명을 입력해 주십시오");
		txt_minornm.value = "";
		txt_minornm.focus();
		return false;
	}

	return true;

}

/*-----------------------------------------------------------------------------
 #  Description : 입력값 체크[상위코드]
-----------------------------------------------------------------------------*/
function ln_Valchk1() {

	if (fn_trim(txt_majorcd1.value) == "") {			
		alert("정확한 상위코드를 입력해 주십시오");
		txt_majorcd1.value ="";
		txt_majorcd1.focus();
		return false;
	}

	if (fn_trim(txt_majornm2.value) == "") {			
		alert("정확한 상위코드명을 입력해 주십시오");
		txt_majornm2.value = "";
		txt_majornm2.focus();
		return false;
	}

	return true;
}

/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
function ln_Valchk2() {

	var str1 =  txt_majorcd1.value;
	
	gcds_hch3.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s3?v_str1=" + str1; 
	gcds_hch3.Reset(); 

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_hcl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!--공통하위코드-->
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_hch classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!--공통상위코드-->
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_hch3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<%=HDConstant.COMMENT_END%>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id="gctr_hcl" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--공통하위코드 TR-->
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id="gctr_hch" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--공통상위코드 TR-->
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_hcl" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_hcl" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language="javascript" for="gctr_hch" event="OnSuccess()">//상위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_hch" event="OnFail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language=JavaScript  for=gcds_hcl event=OnLoadCompleted(rowcount)>	//하위코드
	window.status="조회가 완료 되었습니다.";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	} 

	ft_cnt.innerText = "조회건수 : 총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";
</script>

<script language="javascript" for="gcgd_hcl" event="onClick(row,colid)" >

	if (row<1) {
		if (colid=="MINORNM"||colid=="MINORCD"){
			gcds_hcl.sortExpr = colid + "+";
			gcds_hcl.sort();
			gcds_hcl.rowposition = 1;
		}
	}
	
	if (gcds_hcl.namevalue(row,"USEYN") == "T" ) {
		txt_useyn.checked = true;
	}	else {
		txt_useyn.checked = false;
	}
</script>

<script language="javascript" for="tb_majorcd" event="OnCloseUp()">

	var str1 = tb_majorcd.BindColVal;
	var row = gcds_hch.rowposition;

	txt_majorcd1.value = str1; 
	txt_majornm2.value = gcds_hch.namevalue(row,"MAJORNM");
	
	if (gcds_hch.namevalue(row,"USEYN") == "T") {	
		txt_useyn2.checked = true; 
	} else {
		txt_useyn2.checked = false;
	}
	
	txt_memo2.value = gcds_hch.namevalue(row,"MEMO");

	ln_Query();
	
</script>


<script language="javascript" for="gcds_hch3" event="OnLoadCompleted(rowcnt)">
		
		var row		= gcds_hch.rowposition;
		var rtemp = gcds_temp.rowposition;

		if (confirm("입력하신 사항을 등록하시겠습니까?")){

			gctr_hch.KeyValue = "tr00501_t2(I:USER=gcds_temp)";
			gctr_hch.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_t2";
			gctr_hch.post();
			tb_majorcd.index = 0;
			ln_Query();
			ln_MajorQuery();
		}


</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_hcl" event="OnRowPosChanged(row)">
	if (gcds_hcl.sysStatus(row)=="0") txt_minorcd.readOnly = true;
	else txt_minorcd.readOnly = false;
</script> 



<!--상위코드
<script language="javascript" for="gcds_hch" event="onloadCompleted(row,colid)">
	gcds_hch.InsertRow(1);
	gcds_hch.NameValue(1,"MAJORCD")="";
	gcds_hch.NameValue(1,"MAJORNM")="전체";
	tb_majorcd.index=0;
</script>
-->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s07.jsp"  flush="true"/>
<BODY>
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td width="876" align="right" style="padding-top:4px;"> 
			<img src="../../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
		</td>
  </tr>
	<tr>
		<td colspan=2> 
			<table  cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="100" align=center style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox">
					<nobr>&nbsp;상위코드&nbsp;&nbsp;</nobr></td>
					<td>&nbsp;
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=tb_majorcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=200 style="position:relative;top:2px;" class="txtbox">
							<param name=ComboDataID		value=gcds_hch>
							<param name=SearchColumn		value="MAJORNM">
							<param name=Sort                		value="true">
							<param name=SortColumn			value="MAJORCD">
							<param name=ListExprFormat	    value="MAJORNM^0^80">
							<param name=BindColumn			value="MAJORCD">
						</OBJECT>
						<%=HDConstant.COMMENT_END%>
					</td>
					<td width="150" align=RIGHT></td>
					<td width="10"	align=RIGHT style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;"></td>
					<td width="150" align=RIGHT	style="border:0 solid #708090;border-right-width:0px;"></td>
					<td width="10"	align=RIGHT style="border:0 solid #708090;border-right-width:0px;"></td>
					<td><nobr></nobr></td>
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
          <td style="width:500">
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=gcgd_hcl classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="WIDTH: 500px; HEIGHT: 419px;border:1 solid #777777;" viewastext class="txtbox">
				              <PARAM NAME="DataID"			VALUE="gcds_hcl">
				              <PARAM NAME="Editable"		VALUE="false">
				              <PARAM NAME="BorderStyle" VALUE="0">
								<param name="Sort"				value="true">
								<param name="Fillarea"		VALUE="true">
								<PARAM NAME="Format"			VALUE="
								<C> Name='상위코드'		ID=MAJORCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=center	show=false</C>
								<C> Name='하위코드'		ID=MINORCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center Edit=none</C>
								<C> Name='하위코드명'	ID=MINORNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=160 align=left		Edit=none</C>
								<C> Name='출력순'			ID=SEQ  			HeadAlign=Center HeadBgColor=#B9D4DC Width=40	 align=center Edit=true</C>
								<C> Name='사용유무'		ID=USEYN  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50	 align=center EditStyle=combo  Data='T:사용,F:미사용' Edit=none</C> 
								<C> Name='비고'				ID=MEMO			HeadAlign=Center HeadBgColor=#B9D4DC Width=137 align=center Edit=none</C>
							">
            			</OBJECT><%=HDConstant.COMMENT_END%>
						<fieldset style="width:502px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:3px;"></font>
						</fieldset>
					</td>
          			<td width=3><nobr>&nbsp;</nobr></td>
					<td style="" valign=top>
						<table border="0" cellpadding="0" cellspacing="0" style="width:367px; height:420px;">
							<tr>
								<td valign=middle width=250 style="height:30px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#B9D4DC" align=center class="txtbox"><nobr>&nbsp;상세내역&nbsp;</nobr></td>
								<td width="100%" style="border:0 solid #708090;border-bottom-width:0px;" align=right>
									<img src="../../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Delete()" >
									<img src="../../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add()" >
									<img src="../../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save()">
								</td>									
							</tr>
							<tr>
								<td style="height:30px;width:205px;border:1 solid #708090;border-top-width:1px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>&nbsp;&nbsp;&nbsp;&nbsp;코&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;드&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
								<td style="border:1 solid #708090;border-top-width:1px;border-left-width:0px">&nbsp;
									<input id="txt_minorcd" type="text" class="txtbox" style= "width:63px; height:20px;position:relative;left:-6px"  maxlength="10" onBlur="bytelength(this,this.value,10);">
								</td>									
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">코 드 명</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;
									<input id="txt_minornm" type="text" class="txtbox"  style= "width:183px; height:20px;position:relative;left:-6px;IME-MODE: active" maxlength="30" onBlur="bytelength(this,this.value,30);">
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">출 력 순</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_seq classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:63px;height:20px;position:relative;left:-6px;top:3px">
										<PARAM name="DataID"			value="gcds_hcl">								
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
									</OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input id="txt_seq"			type="text" style= "width:183px; height:20px;position:relative;left:-6px"> -->
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">사용유무</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;padding-left:2px;">
									<input type=checkbox name=txt_useyn class="txtbox"  style="position:relative;left:0px" onclick="ln_Chkbox(this,'USEYN')">
								</td>
							</tr>
							<tr>
								<td style="height:80px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">비&nbsp;&nbsp;&nbsp;&nbsp;고</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px" >&nbsp;
									<textarea id="txt_memo" class="txtbox"  style= "width:255px; height:71px; overflow:auto;position:relative;left:-6px;IME-MODE: active" maxlength="30" onBlur="bytelength(this,this.value,30);"></textarea>
								</td>
							</tr>
							<tr>
								<td style="height:17px;border:0 solid #708090;border-top-width:0px;" >&nbsp;</td>
								<td style="border:0 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;</td>
							</tr>
							<tr>
								<td valign=middle width=150 style="height:30px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#B9D4DC" align=center class="txtbox"><nobr>&nbsp;상위코드&nbsp;</nobr></td>
								<td width="100%" style="border:0 solid #708090;border-bottom-width:0px;" align=right>
									<img src="../../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Delete2()">
									<img src="../../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add2()">
									<img src="../../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save2()">
								</td>				
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">코&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;드</td>
								<td style="border:1 solid #708090;border-top-width:1px;border-left-width:0px">&nbsp;
									<input id="txt_majorcd1" type="text" class="txtbox"  style= "width:63px; height:20px;position:relative;left:-6px" maxlength="4" onBlur="bytelength(this,this.value,4);">
								</td>									
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">코 드 명</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;
									<input id="txt_majornm2" type="text" class="txtbox"  style= "width:183px; height:20px;position:relative;left:-6px;IME-MODE: active" maxlength="30" onBlur="bytelength(this,this.value,30);">
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">사용유무</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;padding-left:2px;">
									<input type=checkbox id=txt_useyn2 name=txt_useyn2 class="txtbox"  checked style="position:relative;left:0px;">
								</td>
							</tr>
							<tr>
								<td style="height:74px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">비&nbsp;&nbsp;&nbsp;&nbsp;고</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px" >&nbsp;
									<textarea id="txt_memo2" name="txt_memo2" class="txtbox"  style= "width:255px; height:65px; overflow:auto;position:relative;left:-6px;IME-MODE: active" maxlength="30" onBlur="bytelength(this,this.value,30);"></textarea></td>
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
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcbn_hcl classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_hcl>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=MINORCD    Ctrl=txt_minorcd      Param=value</C>
		<C>Col=MINORNM		Ctrl=txt_minornm      Param=value</C>
		<C>Col=SEQ				Ctrl=gcem_seq					Param=text </C>
		<C>Col=USEYN			Ctrl=txt_useyn				Param=value</C>
		<C>Col=MEMO				Ctrl=txt_memo					Param=value</C>
	'>
</OBJECT>
<%=HDConstant.COMMENT_END%>


</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>


