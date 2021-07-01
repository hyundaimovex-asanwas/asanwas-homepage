<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사
+ 프로그램 ID	: h070004.html
+ 기 능 정 의	: 교육신청작성
+ 작 성 이 력	: 정영식
+ 서 블 릿 명	: h070001_s1, h010025_t1
+ 수 정  일 자	: 
------------------------------------------------------------------------------>
<html>
<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<title></title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../Common/include/common.css">
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../Common/include/PubFun.js"></script>

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
lfn_init();
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	var THeader = "EMPNO:String(7),REQDT:String(8),SEQ:Decimal(1),SUBJECT:String(50),FRDT:String(8),"
			              +"TODT:String(8),EDUDAY:Decimal(3),EDUPLC:String(50),EDUINST:String(30),SGDT:String(8),"
                    +"SGID:String(7),APDT:String(8),APID:String(7),MEMO:String(30)";

	gcds_data.SetDataHeader(THeader);
  //txt_EMPNO.value = gusrid;
	//txt_NAME.value = gusrnm;
	gcem_fr.text = gcurdate.substring(0,7) + "01";
	gcem_to.text = gcurdate;

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
  var v_str1=gcem_fr.text;
	var v_str2=gcem_to.text;
	gcds_data.DataID = "/servlet/Person.h070001_s1?v_str1=" + gcem_fr.text + "&v_str2=" + gcem_to.text+ "&v_str3=" + txt_name.value+ "&v_str4=9"+ "&v_str5=A" ;
	//gcds_data.DataID = "/servlet/Person.h070001_s1?v_str1=" + gcem_fr.text + "&v_str2=" + gcem_to.text+ "&v_str3=" + txt_name.value+ "&v_str4=&v_str5=A" ;
	gcds_data.Reset();

}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){
		gcds_data.addrow();
		gcem_to.text = gcurdate;
		REQDT.value = gcem_to.text;
		FRDT.text = gcurdate;
		TODT.text = gcurdate;
		gcem_EDUDAY.text = 1;
		SUBJECT.focus()
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
	
	/*
	if (((SGDT.text != "") || (APDT.text != "")) && ((SGDT.text != "99999999") || (APDT.text != "99999999"))) { 
		alert("결재일 / 승인일이  처리 된 항목은  저장할수 없습니다."); 
	return false;
	}
	if (SUBJECT.value == "") { 
		alert("교육과목은 필수 항목입니다. 저장할수 없습니다."); 
		SUBJECT.focus()
	return false;
	}
	if (EDUINST.value == "") { 
		alert("교육기관은 필수 항목입니다. 저장할수 없습니다."); 
		EDUINST.focus()
	return false;
	}
	
	*/
/*	if (EDUPLC.value == "") { 
		alert("교육장소는 필수 항목입니다. 저장할수 없습니다."); 
		EDUPLC.focus()
	return false;
	}
*/
/*
	if ((gcem_EDUDAY.text == 0) ||(gcem_EDUDAY.text == "")) { 
		alert("교육일수는 1보다 작을수 없습니다. 저장할수 없습니다."); 
		gcem_EDUDAY.focus()
	return false;
	}
	if (TODT.text==null) { TODT.text = ""; }
	if ((TODT.text == "") || (FRDT == "")) {
		alert("교육 시작일 / 종료일은 필수 항목 입니다.");
		SUBJECT.focus()
	return false;
	}

	*/
	if (gcds_data.IsUpdated) {	
		if (confirm("교육평가를  등록하시겠습니까?")){
		gctr_pyo.Action = "/servlet/Person.h010025_t1?v_str2=" + gcem_to.text+ "&v_str4=" +  gcds_data.namevalue(gcds_data.rowposition,"empno") ;
		//prompt('',gcds_data.text);
		gctr_pyo.post();
		return ln_Query();
		}
	}

	
}


/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){
	
	/*
	if ((SGDT.text != "") || (APDT.text != "")) { 
		alert("결재일 / 승인일이  처리 된 항목은 삭제할수 없습니다."); 
		return false;
		}
	if (confirm("선택한 정보를 삭제하시겠습니까?")){
		gcds_data.deleterow(gcds_data.rowposition);
		gctr_pyo.action = "/servlet/Person.h010025_t1?v_str4=" + txt_EMPNO.value;
		gctr_pyo.post();
//	return ln_Query();
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

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
 gcgd_pyo.GridToExcel("거래처","",2);
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h010025_t1(I:USER=gcds_data)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
	window.status="데이타 조회중입니다.잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data event="OnLoadError()" >
	alert("에러가 발생 했습니다.");
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	} 

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";
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
    <td ><img src="../img/h070004_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		<!-- 	<img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Delete()">
			<img src="../../Common/img/btn/com_b_insert.gif" style="cursor:hand" onclick="ln_Add()" > -->
			<img src="../../Common/img/btn/com_b_excel.gif"  style="cursor:hand" onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
	<table  cellpadding="1" cellspacing="0" border="0"  style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
			<td width="10" align=RIGHT  style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox"><nobr>&nbsp;검색일자&nbsp;&nbsp;</nobr></td>
			<td width="10"style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
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
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fr', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"></nobr>
					</td>
					<td align=center> ~ </td>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;"><nobr> 
						<comment id="__NSID__"><object id=gcem_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
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
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_to', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">&nbsp;&nbsp;&nbsp;</nobr>
					</td>
           <td width="150" align=RIGHT >&nbsp;&nbsp;</td>
         	 <td width="10" align=RIGHT  style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox"><nobr>&nbsp;&nbsp;&nbsp;성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명&nbsp;&nbsp;&nbsp;</nobr></td>
				  <td width="10" Style="border:0 solid #708090;border-bottom-width:0px"><nobr>&nbsp;   
						 <input id="txt_name" name="txt_name" type="text" class="txtbox" style="width:120px;position:relative; left:-5px"   onkeydown="if(event.keyCode==13) ln_Query();"></td>&nbsp;</nobr></td>	
				  <td width="100%" style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;
					</nobr></td>    
			 </tr>
	  </table>		
	</td>
 </tr>
  <tr> 
  <td height=3></td>
  </tr>
  <tr> 
    <td colspan="2"> 
      <table width="876" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:650">
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo  class="txtbox" style="WIDTH: 602px; HEIGHT: 419px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data">
              <PARAM NAME="Editable"		   VALUE="True">
              <PARAM NAME="BorderStyle"	VALUE="0">
						  <param NAME="Fillarea"		     VALUE="true">
							<param name=ColSizing      value="true">
							<param name="sortview"     value=left>
							<param name="ColSelect"		value=False>
							<PARAM NAME="Format"			VALUE="  
								<F> Name='신청일'				ID=REQDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=CENTER		Edit=None BgColor='#f5f5f5' Mask='XXXX/XX/XX'  sort=true </F>
								<F> Name='사번'					ID=EMPNO   	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=CENTER			Edit=None BgColor='#f5f5f5'     sort=true  </F> 
                <F>  Name='성명'					ID=EMPNMK  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=CENTER			Edit=None BgColor='#f5f5f5'      sort=true </F> 
								<F> Name='순번'					ID=SEQ  		HeadAlign=Center HeadBgColor=#B9D4DC Width=30		align=RIGHT			Edit=Numeric BgColor='#f5f5f5' </F> 
								<F> Name='교육과목'			ID=SUBJECT	HeadAlign=Center HeadBgColor=#B9D4DC Width=100		align=LEFT			Edit=None BgColor='#f5f5f5' sort=true </F>
								<C> Name='교육시작일'		ID=FRDT			HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=CENTER		Edit=None Mask='XXXX/XX/XX'  </C>
								<C> Name='교육종료일'		ID=TODT			HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=CENTER		Edit=None Mask='XXXX/XX/XX' </C>
								<C> Name='교육일수'			ID=EDUDAY		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=RIGHT			Edit=Numeric </C>
								<C> Name='교육평가'			ID=EDUPLC		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=LEFT			Edit=None </C>
								<C> Name='교육기관'			ID=EDUINST	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=LEFT			Edit=None </C>
								<C> Name='결재자'				ID=SGID			HeadAlign=Center HeadBgColor=#B9D4DC Width=65		align=CENTER		Edit=None </C>
								<C> Name='결재일'				ID=SGDT			HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=CENTER		Edit=None Mask='XXXX/XX/XX' </C>
								<C> Name='승인자'				ID=APID			HeadAlign=Center HeadBgColor=#B9D4DC Width=65		align=CENTER		Edit=None </C>
								<C> Name='승인일'				ID=APDT			HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=CENTER		Edit=None Mask='XXXX/XX/XX' </C>
								<C> Name='교육내용'			ID=MEMO			HeadAlign=Center HeadBgColor=#B9D4DC Width=182	align=LEFT			Edit=None </C>
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>

           <td align="left">
	
			 
       <table border="0" class=itemdisp topmargin="0" cellpadding=0 cellspacing=0  style='width:270px;height:420px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
				<tr>
						<td style="height:30px;width:70px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox" align=center>교육과목</td>
						<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px">&nbsp;
							<input id="SUBJECT" name="SUBJECT" type="text" class="txtbox" style= "position:relative; left:-5px;width:185px; height:20px;" maxlength="50" onBlur="bytelength(this,this.value,50);" >
							<input id="SEQ" name="SEQ" type="hidden" style= "width:10px; height:20px;" maxlength="1" onBlur="bytelength(this,this.value,1);">
							<input id="REQDT" name="REQDT" type="hidden" style="height:20px;" maxlength="8" onBlur="bytelength(this,this.value,8);">
						</td>
          </tr>
					<tr>
						<td style="height:30px;border:1 solid #708090;border-top-width:0px;border-left-width:0px"" bgcolor="#eeeeee" class="txtbox" align=center>교육일자</td>
						<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-right-width:0px;padding-left:5px;">
			      <nobr>
						<comment id="__NSID__"><object id="FRDT" name="FRDT" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme2
						validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=MaxLength     value=8>
						<param name=PromptChar	  value="_">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						 <param name=Enable   value=false>

			    </object></comment><script>__ws__(__NSID__);</script><input type="text" style= "border:0;width:10px; height:17px;  position:relative; top:-3px;" value="~" >

					<comment id="__NSID__"><object id=TODT name=TODT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				style="position:relative; left:5px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme2
				validFeatures="ignoreStatus=yes" validExp="">
				<param name=Text          value="">
				<param name=Border	      value=true>
				<param name=Format	      value="YYYY/MM/DD">
				<param name=MaxLength     value=8>
				<param name=PromptChar	  value="_">
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Enable   value=false>
			   </object></comment><script>__ws__(__NSID__);</script>
				 </nobr>
					</td>
							</tr>
                    <tr>
                        <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>교육일수</td>
                        
                        <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px">&nbsp;
												<comment id="__NSID__"><object id=gcem_EDUDAY classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;" class="txtbox" >
													<PARAM name="DataID"			value="gcds_data">								
													<param name=Text					value="">
													<param name=Alignment     value=2>
													<param name=Border        value=true>
													<param name=Numeric       value=true>
													<param name=MaxLength			value=3>
											  	<param name=BackColor     value="#CCCCCC">
													<param name=Enable   value=false>
												</object></comment><script>__ws__(__NSID__);</script>
												</td>
                    </tr>
                    <tr>
                        <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>교육평가</td>
                        
                        <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px">&nbsp;<input id="EDUPLC" name="EDUPLC" type="text"  class="txtbox" style= "width:185px; height:20px;" maxlength="50" onBlur="bytelength(this,this.value,50);"  ></td>
										</tr>
										<tr>
                        <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>교육기관</td>
                        
                        <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px">&nbsp;<input id="EDUINST" name="EDUINST" type="text"  class="txtbox" style= "width:185px; height:20px;" maxlength="30" onBlur="bytelength(this,this.value,30);"  disabled = true></td>
                    </tr>
                    <tr>
                        <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>결재일자</nobr></td>
                        
                        <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px">&nbsp;
				
												<comment id="__NSID__"><object id=SGDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
														style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1
														validFeatures="ignoreStatus=yes" validExp="">
														<param name=Text          value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=ClipMode      value=true>
														<param name=Numeric       value=false>
														<param name=Enable        value=false> 
														<param name=ReadOnly			value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=MaxLength     value=8>
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														</object></comment><script>__ws__(__NSID__);</script>
					</td>
         </tr>
					<tr>
                        <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>결&nbsp;재&nbsp;자</td>
                        
                        <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px">&nbsp;<input id="SGID" name="SGID" type="text"  class="txtbox" style= "width:185px; height:20px;" maxlength="7" onBlur="bytelength(this,this.value,7);" disabled = true></td>
                    </tr>
                    <tr>
                        <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>승인일자</nobr></td>
                        
                        <td Style="height:30px;border:0 solid #708090;border-bottom-width:1px">

											<nobr>&nbsp;<comment id="__NSID__"><object id=APDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1
													validFeatures="ignoreStatus=yes" validExp="">
													<param name=Text          value="">
													<param name=Alignment     value=0>
													<param name=Border        value=true>
													<param name=ClipMode      value=true>
													<param name=Numeric       value=false>
													<param name=Enable        value=false>
													<param name=ReadOnly			value=false>
													<param name=Format        value="YYYY/MM/DD">
													<param name=MaxLength     value=8>
													<param name=PromptChar    value="_">
													<param name=IsComma       value=false>
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
													</object></comment><script>__ws__(__NSID__);</script>
													</td>
                    </tr>
										<tr>
                        <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>승&nbsp;인&nbsp;자</td>
                        
                        <td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px">&nbsp;<input id="APID" name="APID" type="text"  class="txtbox" style= "width:185px; height:20px;" maxlength="7" onBlur="bytelength(this,this.value,7);" disabled = true></td>
                    </tr>
										<tr>
											<td style="height:25;border:1 solid #708090;border-top-width:0px;border-left-width:0px;border-bottom-width:0px;" bgcolor="#eeeeee" class="txtbox"  align=center>교육내용</td>
											<td style="border:0 solid #708090;border-top-width:0px;border-left-width:0px" >&nbsp;<textarea id="MEMO" name="MEMO"  class="txtbox" style="width:185px;height:125px;overflow:auto;" disabled=true ></textarea></td>
									</tr>

                </table>
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
		<C>Col=EMPNO        Ctrl=EMPNO			  Param=value</C>
		<C>Col=REQDT        Ctrl=REQDT			  Param=value</C>
		<C>Col=SEQ					    Ctrl=SEQ					Param=value</C>
		<C>Col=SUBJECT      Ctrl=SUBJECT		  Param=value</C>
		<C>Col=FRDT					   Ctrl=FRDT					Param=Text</C>
		<C>Col=TODT					   Ctrl=TODT					Param=Text</C>
		<C>Col=EDUDAY				Ctrl=gcem_EDUDAY	Param=text</C>
		<C>Col=EDUPLC				Ctrl=EDUPLC				Param=value</C>
		<C>Col=EDUINST			Ctrl=EDUINST			Param=value</C>
		<C>Col=SGID					   Ctrl=SGID					Param=value	 </C>
		<C>Col=SGDT					Ctrl=SGDT					Param=Text	 </C>
		<C>Col=APID					   Ctrl=APID					Param=value	 </C>
		<C>Col=APDT					  Ctrl=APDT					Param=Text	 </C>
		<C>Col=MEMO					Ctrl=MEMO					Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 
 
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	