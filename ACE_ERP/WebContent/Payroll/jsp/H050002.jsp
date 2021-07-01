<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사
+ 프로그램 ID	: h070002.html
+ 기 능 정 의	: 교육신청결재
+ 변 경 이 력	: 문희식
+ 변 경 이 력	: 정영식  - 조회시 결재자 사번으로 조회함.
+ 서 블 릿 명	: h050002_s1, h050002_t1
------------------------------------------------------------------------------>

<html>
<head>
	<jsp:include page="/Payroll/common/include/head.jsp"/>
<title>근태신청결재</title>


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
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	txt_EMPNO.value =		gusrid;		//신청자ID
	txt_name.value	=		gusrnm;		//신청자명
 	CURDATE.text		=		gcurdate;	//신청일
	gcem_fr.text		=		gcurdate.substring(0,7) + "01";
	gcem_to.text		=		gcurdate;

	gcds_deptcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?";		//소속
	gcds_deptcd.Reset();
	Radio1_1.CodeValue = 1;	

	//ln_Query2();
	
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";

	var v_str3 = "";					 						//구분[A:결재 B:미결재 C:결재취소 D:전체]
	//var v_str4 = txt_name.value;					//결재자명

	var v_str4 = txt_EMPNO.value;          
	var v_str5 = gclx_deptcd.BindColVal;	//소속코드

	if (Radio1_1.CodeValue  == '1') {
		v_str3 = 'D';		//전체
	} else if (Radio1_1.CodeValue  == '2') {
		v_str3 = 'A';		// 결재
	} else if (Radio1_1.CodeValue  == '3') {
		v_str3 = 'B';  // 미결재
	} else if (Radio1_1.CodeValue  == '4') {
		v_str3 = 'C';  // 결재취소
	}
	
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h050002_s1?v_str1=" + gcem_fr.text + "&v_str2=" + gcem_to.text + "&v_str3=" + v_str3 + "&v_str4=" + fn_trim(v_str4)+ "&v_str5=" + v_str5;
	gcds_data.Reset();

	//ln_Query2();

}

/*-----------------------------------------------------------------------------
		Description : 조회[소속]
-----------------------------------------------------------------------------*/
function ln_Query2() {
	
	txt_EMPNO.value = gusrid;
	var v_str1 = txt_EMPNO.value;

	gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010018_s3?v_str1="+v_str1;
	gcds_data2.Reset();

	var row = gcds_data2.rowposition;

	if (txt_deptno2.value != "" || gcds_data2.namevalue(row,"DEPTCD") != null) {
		txt_deptno2.value	= gcds_data2.namevalue(row,"DEPTCD");		//소속명
		gclx_deptcd.BindColVal = txt_deptno2.value;
	} else {
		gclx_deptcd.index= 0;
	}

}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){
//		gcds_data.addrow();
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
  
	var v_str1=txt_EMPNO.value;
	var v_str2=CURDATE.text;
	var v_str3 = 'B';
	
	if(fn_CheckSaveCondt()){
//prompt('',gcds_data.text);
		if(confirm("결재 하시겠습니까?")){
			gctr_pyo.Action ="<%=dirPath%><%=HDConstant.PATH_PERSON%>h050002_t1?v_str1=" + v_str1 + "&v_str2=" + v_str2 + "&v_str3=" + v_str3;
			gctr_pyo.post();
			ln_Query();
	  }
	} else { return ; }
}


/*-----------------------------------------------------------------------------
 #  Description  : 체크
-----------------------------------------------------------------------------*/
function fn_CheckSaveCondt(){

	//저장할때 그리드의 선택의 체크가 없을 경우 경고창 띄워줌 replace(/(^\s*)|(\s*$)/g, "")); 
	var countChk = 0;
	var check = 'T'
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.NameValue(i,"CHK") == "T"){
			if ((gcds_data.NameValue(i,"AGRDT") != "") && (gcds_data.NameValue(i,"AGRDT") != "99999999")) { 
				alert("승인된 항목은 재결재 할수 없습니다."); 
				return false;
			}
			
			if ((gcds_data.NameValue(i,"SGDT") == "") || (gcds_data.NameValue(i,"SGDT") == "99999999")) {
				countChk++;
			} else {
				alert(i + " 번째 결재일을 확인하십시요");
				check ='F'
				countChk++;
			}
		}
	}

if(countChk == 0) { alert("선택된 데이터가 없습니다.");	return false;	}

if (check == 'T') {
  return true;
} else if (check == 'F') {
	return false;
}

	return true;

}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){
   
  var v_str1=txt_EMPNO.value;
	var v_str2=CURDATE.text;
	var v_str3 = 'A';

	if(fn_CheckCancelCondt()){
//prompt('',gcds_data.text);
		if(confirm("취소하시겠습니까?")){
		gctr_pyo.Action ="<%=dirPath%><%=HDConstant.PATH_PERSON%>h050002_t1?v_str1=" + v_str1 + "&v_str2=" + v_str2 + "&v_str3=" + v_str3;
		gctr_pyo.post();
		return ln_Query();
	    }
	}else{
		return ; 
	}
}

/*-----------------------------------------------------------------------------
 #  Description  : 체크
-----------------------------------------------------------------------------*/
function fn_CheckCancelCondt(){
	
	//저장할때 그리드의 선택의 체크가 없을 경우 경고창 띄워줌
	var countChk = 0;
  var check = 'T';
	
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.NameValue(i,"CHK") == "T"){	
			if  ((gcds_data.NameValue(i,"SGDT") == "99999999") || (gcds_data.NameValue(i,"SGDT") == "")) {
				alert(i + " 번째 승인일을 확인하십시요");
				check ='F'
				countChk++;
				return false;
		 } else if((gcds_data.NameValue(i,"AGRDT") != "") && (gcds_data.NameValue(i,"AGRDT") != "99999999"))  { 
				alert("승인된 항목은 취소 할수 없습니다."); 
				check ='F'
				countChk++;
				return false;
		 } else {
			  countChk++;
		 }
	 }
}

	if(countChk == 0) {
	  alert("선택된 데이터가 없습니다.");
		return false;
	}

	if (check == 'T') {
   return true;
	 }
	 else if (check == 'F') {
	 return false;
	 }

	return true;
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
	Description : 전체선택
******************************************************************************/
function ln_Chkbox(){

	var ch = 1;

	for(i=1;i<=gcds_data.countrow;i++){
		if (ch != i){ 
			for(i=1;i<=gcds_data.countrow;i++){
				if (gcds_data.NameValue(i,"CHK") == 'T') { 
					gcds_data.NameValue(i,"CHK") = 'F';   
				} else if (gcds_data.NameValue(i,"CHK") == 'F') { 
						gcds_data.NameValue(i,"CHK") = 'F';
				}
			 ch++ ; 
		 }
	} else if ((ch == i) && (gcds_data.NameValue(i,"CHK") == 'F')) { 
			for(i=1;i<=gcds_data.countrow;i++) {
				if ((ch == i) || (gcds_data.NameValue(i,"CHK") == 'T')|| (gcds_data.NameValue(i,"CHK") == 'F')) { 
					gcds_data.NameValue(i,"CHK") = 'T';
					ch++ ; 
				}
			}
		}
	} 
}


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_deptcd classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="true">
	<!-- <PARAM NAME="SortExpr" VALUE="+TREECD"> -->
</object></comment><script>__ws__(__NSID__);</script>
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h050002_t1(I:USER=gcds_data)">
</OBJECT>	</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("에러가 발생 했습니다.");
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//총조회 건수

	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
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

<script language=JavaScript for=gclx_deptcd event=onSelChange()>
		gs_level = '';
		gs_treecd ='';
		gs_level = gclx_deptcd.ValueOfIndex ("level", gclx_deptcd.Index);
		gs_treecd = gclx_deptcd.ValueOfIndex ("treecd", gclx_deptcd.Index);

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


</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td>
			<img src="../img/h050002_head.gif">
		</td>  
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
      <comment id="__NSID__"><object id=CURDATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="border:0 solid #708090;" bgcolor="#eeeeee" class="txtbox">
				<param name=Text          value="">
				<param name=Alignment	  value=0>
				<param name=Border	      value=true>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=false>
				<param name=Visible       value=false>
				<param name=ReadOnly	  value=true>
				<param name=Format	      value="YYYY/MM/DD">
				<param name=MaxLength     value=8>
				<param name=PromptChar	  value="">
				<param name=IsComma	      value=false>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script>&nbsp;
						
			<img src="../../Common/img/btn/com_b_select.gif"	style="cursor:hand" onclick="ln_Chkbox()"> 
			<img src="../../Common/img/btn/com_b_cancle.gif"	style="cursor:hand" onclick="ln_Cancel()"> 
			<img src="../../Common/img/btn/com_b_result.gif"	style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table  cellpadding="1" cellspacing="0" border="0"  style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="10" style="border:0 solid #708090;border-right-width:1px;width" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp;&nbsp;소속&nbsp;&nbsp;&nbsp;</nobr></td>
					<td width="10" style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative; left:0px;top:2px;" height=180 width=140 class="txtbox" >
							<param name=ComboDataID           value=gcds_deptcd>
							<param name=SearchColumn          value="DEPTNM">
							<param name=Sort                  value="false">
							<param name=SortColumn						value="DEPTNM">
							<param name=ListExprFormat        value="DEPTNM^0^150">       
							<param name=BindColumn            value="DEPTCD"> 
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;			
					</td>  
					<td width="10" align=RIGHT  style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp;검색일자&nbsp;</nobr></td>
					<td width="10"style="width:80px;border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:-1px;top:2px; width:68px;" class="txtbox" >
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
						</object></comment><script>__ws__(__NSID__);</script>
						
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fr', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;"></nobr>
						
					</td>
					<td align=center> ~ </td>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;">
						<comment id="__NSID__"><object id=gcem_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:-1px;top:2px; width:68px; height:20px;" class="txtbox">
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
						</object></comment><script>__ws__(__NSID__);</script>
						
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_to', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">&nbsp;
					
					</td>
					<td width="10" align=RIGHT  class="txtbox"  style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;성명&nbsp;</nobr>
					</td>
					<td width="20">&nbsp;<nobr>
						<input id="txt_EMPNO"		name="txt_EMPNO"		type='hidden'	value=""	style="border:0px;width:50px;" maxlength="7" onBlur="bytelength(this,this.value,7);">
						<input id="txt_deptno2" name="txt_deptno2"	type='hidden'	value=""	style="border:0px;width:1px;" maxlength="4" onBlur="bytelength(this,this.value,4);">
						<input id="txt_name"		name="txt_name"	type=text	style="border:1px;position:relative;width:64px;left:-20px;top:2px" class="txtbox" maxlength="20" onBlur="bytelength(this,this.value,20);" disabled></nobr>
					</td>
					<td width="10" align=RIGHT  style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;" class="txtbox" bgcolor="#eeeeee">
						<nobr>&nbsp;구분&nbsp;</nobr>
					</td>
					<td width="230" style="border:0">
						<comment id="__NSID__"><object id=Radio1_1 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="position:relative;left:1px;top:0px;height:24;width:225;cursor:hand;" class="txtbox" >
							<param name=Cols     value="4">
							<param name=Format   value="1^전체,2^결재,3^미결재,4^취소">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
  </tr>

  <tr><td height=3></td></tr>
  
	<tr> 
    <td colspan="2"> 
      <table width="867" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:503">
						<comment id="__NSID__"><OBJECT classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" id=gcgd_pyo  style="WIDTH: 874px; HEIGHT: 420px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"				VALUE="gcds_data">
              <PARAM NAME="Editable"			VALUE="TRUE">
              <PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM NAME="Fillarea"			VALUE="TRUE">
							<PARAM NAME="Format"				VALUE="  
								<F>	Name='선택'			ID=CHK    HeadAlign=Center HeadBgColor=#B9D4DC Width=30 align=Center	EditStyle=CheckBox BgColor='#f5f5f5' </F>
								<F> Name='신청일'		ID=APPDT  HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=Center	Edit=None		BgColor='#f5f5f5' Mask='XXXX/XX/XX' </F> 
								<F> Name='근태구분'	ID=LAZNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=LEFT		Edit=None		BgColor='#f5f5f5'</F>
								<F> Name='사번'			ID=EMPNO  HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=CENTER	Edit=None		BgColor='#f5f5f5' </F> 
								<F> Name='성명'			ID=EMPNMK HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=LEFT		Edit=None		BgColor='#f5f5f5' </F> 

								<C> Name='시작일'		ID=FRDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=CENTER	Edit=None		Mask='XXXX/XX/XX' </C>
								<C> Name='시작시간' ID=FRTIME	HeadAlign=Center HeadBgColor=#B9D4DC Width=55 align=CENTER	Edit=None		Mask='XX:XX'			</C>
								<C> Name='종료일'		ID=TODT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=CENTER	Edit=None		Mask='XXXX/XX/XX' </C>
								<C> Name='종료시간' ID=TOTIME	HeadAlign=Center HeadBgColor=#B9D4DC Width=55 align=CENTER	Edit=None		Mask='XX:XX'			</C>
								<C> Name='결재자명'	ID=SGNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=72 align=LEFT		Edit=None		</C>
								<C> Name='결재일'		ID=SGDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=CENTER	Edit=None		Mask='XXXX/XX/XX' </C>
								<C> Name='승인자명'	ID=AGNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=72 align=LEFT		Edit=None		</C>
								<C> Name='승인일'		ID=AGRDT	HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=CENTER	Edit=None		Mask='XXXX/XX/XX' </C>
								<C> Name='근태사유' ID=DTYREM HeadAlign=Center HeadBgColor=#B9D4DC Width=278 align=LEFT		Edit=None</C>
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<!--
						<F> Name='근태구분'	ID=LAZCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=LEFT		Edit=None		BgColor='#f5f5f5' Data='gcds_data2:MINORCD:MINORNM' SHOW=FALSE</F>
						<C> Name='결재자ID'	ID=SGNID	HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=CENTER	Edit=None		SHOW=FALSE</C>
						<C> Name='승인자ID'	ID=AGID		HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=CENTER	Edit=None		SHOW=FALSE</C>
						--> 
					</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
		<td colspan="2" height="24" align="left">조회건수 : <label id="lbl_search"></label></td>
  </tr>	
</table>

<comment id="__NSID__"><object id=gcbn_pyo classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=APPDT        Ctrl=APPDT			  Param=value	</C>
		<C>Col=LAZCD        Ctrl=LAZCD			  Param=value	</C>
		<C>Col=EMPNO        Ctrl=EMPNO			  Param=value	</C>
		<C>Col=EMPNMK				Ctrl=EMPNMK				Param=value	</C>
		<C>Col=FRDT					Ctrl=FRDT					Param=Text	</C>
		<C>Col=FRTIME				Ctrl=FRTIME				Param=Text	</C>
		<C>Col=TODT					Ctrl=TODT					Param=Text	</C>
		<C>Col=TOTIME				Ctrl=TOTIME			  Param=Text	</C>
		<C>Col=SGDT					Ctrl=SGDT					Param=Text	</C>
		<C>Col=SGNM					Ctrl=SGNM					Param=value	</C>
		<C>Col=AGRDT				Ctrl=AGRDT				Param=Text	</C>
		<C>Col=AGNM					Ctrl=AGNM					Param=Text	</C>
		<C>Col=DTYREM				Ctrl=DTYREM			  Param=value	</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>