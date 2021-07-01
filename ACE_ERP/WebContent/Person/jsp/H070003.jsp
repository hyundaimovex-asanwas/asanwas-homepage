<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사
+ 프로그램 ID	: h070003.html
+ 기 능 정 의	: 교육신청승인
+ 변 경 이 력	: 문희식
+ 서 블 릿 명	: h010027_s1, h010027_t1
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<title>교육신청승인</title>
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

  txt_EMPNO.value = gusrid;
	txt_NAME.value = gusrnm;	
CURDATE.text = gcurdate;
	gcem_fr.text = gcurdate.substring(0,7) + "01";
	gcem_to.text = gcurdate;
	Radio1_1.CodeValue = 1;
	}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
var v_str5;
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
if (Radio1_1.CodeValue  == 2) v_str5 = 'A';
    else if (Radio1_1.CodeValue  == 3) v_str5 = 'B';
    else if (Radio1_1.CodeValue  == 4) v_str5 = 'C';
	else v_str5 = 'D';
/*	
	if (Radio1_2.checked  == true) v_str5 = 'A';
    else if (Radio1_3.checked  == true) v_str5 = 'B';
    else if (Radio1_4.checked  == true) v_str5 = 'C';
	else v_str5 = 'D';
*/
//    var v_str1=gcem_fr.text;
//	var v_str2=gcem_to.text;

	gcds_data.DataID = "/servlet/Person.h010027_s1?v_str1=" + gcem_fr.text + "&v_str2=" + gcem_to.text + "&v_str5=" + v_str5;
	gcds_data.Reset();
//	alert(gcds_data.countrow);


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
		
		if(confirm("승인하시겠습니까?")){
			gctr_pyo.Action ="/servlet/Person.h010027_t1?v_str1=" + v_str1 + "&v_str2=" + v_str2+ "&v_str3=" + v_str3;
//		prompt('',gcds_data.text);
			gctr_pyo.post();
		return ln_Query();
	    }
	}else{
		return ; 
	}
}


function fn_CheckSaveCondt(){
	var countChk = 0;
	//저장할때 그리드의 선택의 체크가 없을 경우 경고창 띄워줌
  var check = 'T'
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.NameValue(i,"CHK") == "T"){
			if ((gcds_data.NameValue(i,"SGDT") == "") || (gcds_data.NameValue(i,"SGDT") == "99999999")) { 
						alert("결재 되지 않은 항목입니다. 승인 할수 없습니다."); 
				return false;
				}

			else if  ((gcds_data.NameValue(i,"APDT") == "99999999") || (gcds_data.NameValue(i,"APDT") == "")) {
					 countChk++;
				 }
			else {
				alert(i + " 번째 승인일을 확인하십시요");
				check ='F'
				countChk++;
				return false;
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
	Description : 삭제
******************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){
   
  var v_str1=txt_EMPNO.value;
	var v_str2=gcem_to.text;
	var v_str3 = 'A';
	if(fn_CheckCancelCondt()){
		if(confirm("취소하시겠습니까?")){
		gctr_pyo.Action ="/servlet/Person.h010027_t1?v_str1=" + v_str1 + "&v_str2=" + v_str2+ "&v_str3=" +v_str3;
		gctr_pyo.post();
		return ln_Query();
	    }
	}else{
		return ; 
	}
}



function fn_CheckCancelCondt(){
	var countChk = 0;
	//저장할때 그리드의 선택의 체크가 없을 경우 경고창 띄워줌
  var check = 'T'
	
	
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.NameValue(i,"CHK") == "T"){	
			if  ((gcds_data.NameValue(i,"APDT") == "99999999") || (gcds_data.NameValue(i,"APDT") == "") || (gcds_data.NameValue(i,"APDT") == null)) {
			     alert(i + " 번째 승인일을 확인하십시요");
					 check ='F'
					 countChk++;
					 return false;
	
				 }
			else {
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
			for(i=1;i<=gcds_data.countrow;i++){
    	gcds_data.NameValue(i,"CHK") = 'T';
			}
}

function ln_Chkbox(){
var ch = 1;
			for(i=1;i<=gcds_data.countrow;i++){
					if (ch != i){ 
						for(i=1;i<=gcds_data.countrow;i++){
					    if (gcds_data.NameValue(i,"CHK") == 'T') { 
								gcds_data.NameValue(i,"CHK") = 'F';   }
							if (gcds_data.NameValue(i,"CHK") == 'F') { 
							    gcds_data.NameValue(i,"CHK") = 'F';
							}
							ch++ ; 
						}
					}
					else if ((ch == i) && (gcds_data.NameValue(i,"CHK") == 'F')) { 
							for(i=1;i<=gcds_data.countrow;i++){
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

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h010027_t1(I:USER=gcds_data)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript event="OnLoadError()" for=gcds_data>
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
<!-- <script language="javascript" for="gcgd_pyo" event="onclick(row,colid)"> 
alert(gcds_data.IsUpdated) = false;
	if (colid=="CHK") {
		if (gcds_data.namevalue(row,colid) == "T") {
			gcds_data.namevalue(row,"SGID") = txt_name.value;
			gcds_data.namevalue(row,"SGDT") = aaa.CURDATE.value;
		} 
		else {
			gcds_data.namevalue(row,"SGID") = "";
			gcds_data.namevalue(row,"SGDT") = "";
		}
	}
 </script>   -->

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
    <td ><img src="../img/h070003_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<comment id="__NSID__"><object id=CURDATE  class="txtbox" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="border:0 solid #708090;" bgcolor="#eeeeee" class=objclsEme1>
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Visible       value=false>
								<param name=ReadOnly			value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script>
			<!--			<comment id="__NSID__"><object id=SGDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1
                validFeatures="ignoreStatus=yes" validExp="">
                <param name=Text          value="">
                <param name=Alignment     value=0>
                <param name=Border        value=true>
                <param name=ClipMode      value=true>
                <param name=Numeric       value=false>
			// 	<param name=Enable        value=false> 
				<param name=Visible       value=false>
				<param name=ReadOnly	  value=true>
                <param name=Format        value="YYYY/MM/DD">
                <param name=MaxLength     value=8>
                <param name=PromptChar    value="_">
                <param name=IsComma       value=true>
                <param name=BackColor     value="#CCCCCC">
                <param name=InheritColor  value=false>
                </object></comment><script>__ws__(__NSID__);</script>-->&nbsp;
								 <img src="../../Common/img/btn/com_b_select.gif" style="cursor:hand" onclick="ln_Chkbox()"> 
			 <img src="../../Common/img/btn/com_b_cancle.gif" style="cursor:hand" onclick="ln_Cancel()"> 
			 <img src="../../Common/img/btn/com_b_sungin.gif" style="cursor:hand" onclick="ln_Save()">
			 <img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;</td>



  </tr>
  <!--------------------------------------------------------------------------------> 
  <!------------------------    FORM 내용부분   ------------------------------------> 
  <!--------------------------------------------------------------------------------> 

  <tr> 
    <td COLSPAN=2>
			<table  cellpadding="1" cellspacing="0" border="0"  style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="10" align=RIGHT  style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;검색일자&nbsp;&nbsp;</nobr></td>
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
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_to', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">&nbsp;</nobr>
						</td>
					
						<td width="10" align=RIGHT  style="border:0 solid #708090;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" class="txtbox" >
						<nobr>&nbsp;결재자사번&nbsp;</nobr></td>
						<td width="10">&nbsp;<nobr><input id="txt_EMPNO" name="txt_EMPNO"  class="txtbox" type=text value="" style="border:0px;width:50px;top:1px;" maxlength="7" onBlur="bytelength(this,this.value,7);" disabled></nobr></td>

						<td width="10" align=RIGHT  style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" >
						<nobr>&nbsp;성명&nbsp;</nobr></td>
						<td width="20">&nbsp;<nobr><input id="txt_NAME" name="txt_NAME"  class="txtbox" type=text value="" style="border:0px;width:70px;top:1px;" maxlength="20" onBlur="bytelength(this,this.value,20);" disabled></nobr></td>

	
						<td width="10" align=RIGHT  style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" >
						<nobr>&nbsp;구분&nbsp;</nobr></td>
						<td ><nobr>
						<comment id="__NSID__"><object id=Radio1_1  class="txtbox" classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
						         style="position:relative;left:4px;top:1px;height:24;width:275;cursor:hand;">
					             <param name=Cols     value="4">
						           <param name=Format   value="1^전체,2^승인,3^미승인,4^승인취소">
			            </object></comment><script>__ws__(__NSID__);</script></nobr>
					  </td> 
					</tr>
				</table>

				</td>
  </tr>
  <tr> 
 <td height=3></td>
  </tr>
  <tr> 
    <td colspan="2"> 
      <table width="500" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:503">
		<comment id="__NSID__"><OBJECT classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" id=gcgd_pyo  style="WIDTH: 874px; HEIGHT: 420px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data">
              <PARAM NAME="Editable"		VALUE="true">
              <PARAM NAME="BorderStyle"		VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="Format"			VALUE="  
              <F>	Name='선택'			 ID=CHK     HeadAlign=Center HeadBgColor=#B9D4DC Width=30 align=Center EditStyle=CheckBox BgColor='#f5f5f5'   </F>
							<F> Name='신청일'		 ID=REQDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65 Mask='XXXX/XX/XX' align=RIGHT BgColor='#f5f5f5' Edit=None  </F> 
							<F> Name='사번'			 ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=RIGHT BgColor='#f5f5f5' Edit=None   </F> 
							<F> Name='성명'			 ID=EMPNMK  HeadAlign=Center HeadBgColor=#B9D4DC Width=65 align=CENTER BgColor='#f5f5f5' Edit=None   </F> 
							<F> Name='순번'			 ID=SEQ			HeadAlign=Center HeadBgColor=#B9D4DC Width=30 align=RIGHT BgColor='#f5f5f5' Edit=Numeric </F> 
							
							<C> Name='소속'			 ID=DEPTNM  HeadAlign=Center HeadBgColor=#B9D4DC Width=65 align=LEFT Edit=None   </C> 
							<C> Name='시작일'		 ID=FRDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=65 Mask='XXXX/XX/XX' align=RIGHT Edit=None  </C>
							<C> Name='종료일'		 ID=TODT		HeadAlign=Center HeadBgColor=#B9D4DC Width=65 Mask='XXXX/XX/XX' align=RIGHT Edit=None </C>
							<C> Name='결재자사번'		 ID=SGID		HeadAlign=Center HeadBgColor=#B9D4DC Width=65 align=CENTER Edit=None show=false </C>
  						<C> Name='결재자'		 ID=SGNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=65 align=CENTER Edit=None </C>
							<C> Name='결재일'		 ID=SGDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=65 Mask='XXXX/XX/XX' align=RIGHT Edit=None </C>
							
							<C> Name='승인자사번'		 ID=APID		HeadAlign=Center HeadBgColor=#B9D4DC Width=65 align=CENTER Edit=None show=false</C>
							<C> Name='승인자'		 ID=APNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=65 align=CENTER Edit=None </C>
							<C> Name='승인일'		 ID=APDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=65 Mask='XXXX/XX/XX' align=RIGHT Edit=None </C>
							<C> Name='교육과목'		 ID=SUBJECT HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=LEFT Edit=None </C>
							<C> Name='교육기관'		 ID=EDUINST HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=LEFT Edit=None </C>
							<C> Name='교육평가'	 ID=EDUPLC	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=LEFT Edit=None </C>
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
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
		<C>Col=SEQ        Ctrl=SEQ			  Param=value</C>
		<C>Col=SUBJECT      Ctrl=SUBJECT		  Param=value</C>
		<C>Col=FRDT			Ctrl=FRDT			  Param=Text</C>
		<C>Col=TODT			Ctrl=TODT			  Param=Text</C>
		<C>Col=EDUDAY		Ctrl=EDUDAY			  Param=value</C>
		<C>Col=EDUPLC		Ctrl=EDUPLC			Param=value</C>
		<C>Col=EDUINST		Ctrl=EDUINST	  Param=value</C>
		<C>Col=SGID			Ctrl=SGID		  Param=value	 </C>
		<C>Col=SGDT			Ctrl=SGDT		  Param=Text	 </C>
		<C>Col=APID			Ctrl=APID		  Param=value	 </C>
		<C>Col=APDT			Ctrl=APDT		  Param=Text	 </C>
		<C>Col=MEMO			Ctrl=MEMO		  Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	