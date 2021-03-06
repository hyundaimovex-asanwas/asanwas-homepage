<%@ page language="java" contentType="text/html;charset=KSC5601" %>
<%
/*---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 기준정보관리	
+ 프로그램 ID	:  A010001.html
+ 기 능 정 의	:  재무회계의 기준정보를 입력, 조회한다.
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2005.09.27
-----------------------------------------------------------------------------
+ 수 정 내 용 :	   
+ 수   정  자 :
+ 수 정 일 자 :DD
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a010001_s1,a010001_s2,a010001_t1,a010001_t2,
------------------------------------------------------------------------------*/
%>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<html>
<head>

<jsp:include page="/Account/common/include/head.jsp"/>

<title>공통코드관리</title>

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

//lfn_init(); //로그인 체크 함수 호출

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;


/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/

function fnOnLoad(tree_idx){

    fnInit_tree(tree_idx);	//트리초기화 호출


  	//login자와 부가세 관리자확인
	gcds_login.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2164&v_str2="+gs_userid;
	//prompt('',gcds_login.DataID );
	gcds_login.Reset();
	
	if( gcds_login.countrow>0){
		hid_login.value="M";
        txt_cmnam_fr.value = "자산명";
        gcem_cmtype_fr.text ="2161"; 
		txt_cmnam_fr.readOnly = true ; 
		gcem_cmtype_fr.Enable = false; 
	}else{
		hid_login.value="";
		txt_cmnam_fr.value = "";
       gcem_cmtype_fr.text =""; 
		txt_cmnam_fr.readOnly = false ; 
		gcem_cmtype_fr.Enable = true; 
	}

  //2016.09.01 예외처리
  if(gs_userid=="2100003"){
	    hid_login.value=="M"
		txt_cmnam_fr.value = "계좌번호";
        gcem_cmtype_fr.text ="0023"; 
		txt_cmnam_fr.readOnly = true ; 
		gcem_cmtype_fr.Enable = false; 
	}else if (gs_userid==""){
	  hid_login.value=="M"
      txt_cmnam_fr.readOnly = true ; 
	  gcem_cmtype_fr.Enable = false; 
	}
     
	ln_Enable01("f");
	ln_Enable02("f");
	ln_SetDataHeader();

}


/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query01(){
   var str1 = "";
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010001_s1?v_str1=B&v_str2="+gcem_cmtype_fr.text+"&v_str3="+txt_cmnam_fr.value; 
	
	//gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010001_s1?v_str1=B&v_str2="+gcem_cmtype_fr.text+"&v_str3=\\"; 
	//prompt('',gcds_code01.DataID );
	
	gcds_code01.Reset();
	
	ln_Enable01("f");
	ln_Enable02("f");
	gcds_code02.ClearData();
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Query02(p){
    	gcds_code02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010001_s2?v_str1="+p; 
		gcds_code02.Reset();
		ln_Enable02("f");
}

/******************************************************************************
	Description : 상위코드추가
******************************************************************************/
function ln_Add01(){
	gcds_code01.addrow();
	ln_Enable01("t");
	txt_cmtype.focus();
	gcds_code02.ClearData();
}

/******************************************************************************
	Description : 상세코드추가
******************************************************************************/
function ln_Add02(){
	gcds_code02.addrow();
	gcds_code02.namevalue(gcds_code02.rowposition,"CMTYPE")=gcds_code01.namevalue(gcds_code01.rowposition,"CMTYPE");
	ln_Enable02("t");
	txt_cdcode.focus();
}

/******************************************************************************
	Description : 상위코드 저장
******************************************************************************/
function ln_Save01(){

	if (gcds_code01.IsUpdated){
		if(ln_Chk01()){
			if (confirm("저장하시겠습니까?")){	
				gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010001_t1?";
				gctr_code01.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;
				gctr_code01.post();
			}	
		}
	}

}

/******************************************************************************
	Description : 상세코드 저장
******************************************************************************/
function ln_Save02(){
	if (gcds_code02.IsUpdated) {
		if(ln_Chk01){
			if (confirm("저장하시겠습니까?")){	
				gctr_code02.Action =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010001_t2?";
				gctr_code02.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;
				gctr_code02.post();
			}	
		}
	}
}


/******************************************************************************
	Description : 상위코드삭제
******************************************************************************/
function ln_Delete01(){
  gcds_code03.addrow();
	gcds_code03.namevalue(1,"CMTYPE") = gcds_code01.namevalue(gcds_code01.rowposition,"CMTYPE");
	var str1 = gcds_code03.namevalue(1,"CMTYPE");
	
	if (confirm("삭제하시겠습니까?")){	
      gctr_code03.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010001_t3?"+str1;
			gctr_code03.post();
	    gcds_code01.deleterow(gcds_code01.rowposition);
			
			gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010001_t1?";
			gctr_code01.post();
      
			gcds_code02.ClearData();
			gcds_code03.ClearData();
	}	
}

/******************************************************************************
	Description : 상세코드삭제
******************************************************************************/
function ln_Delete02(){
	if (confirm("삭제하시겠습니까?")){	
	    gcds_code02.deleterow(gcds_code02.rowposition);
			gctr_code02.Action =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010001_t2?";
			gctr_code02.post();
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

/******************************************************************************
	Description : 상위코드 입력체크 
******************************************************************************/
function ln_Chk01() {
  //필수항목체크
	if (fn_trim(txt_cmtype.value)=="" ){
		alert("분류코드를 입력하십시요.");
		txt_cmtype.focus();
		return false; 
	}

	if (fn_trim(txt_cmnam.value)==""){
		alert("코드명을 입력하십시요.");
		txt_cmnam.focus();
		return false; 
	}

	if ((fn_trim(gcem_cmlen.text)=="")||(gcem_cmlen.text=="0")){
		alert("길이 입력하십시요");
		gcem_cmlen.focus();
		return false;
	}

	//값체크
  if ((parseInt(fn_trim(gcem_cmlen.text))> 20)||(parseInt(gcem_cmlen.text) <=0)){
		alert("길이 값이 맞지 않습니다. 최대 20까지입니다.");
		gcem_cmlen.focus();
		return false;
	}
	return true; 

}

/******************************************************************************
	Description : 상세코드 입력체크 
******************************************************************************/
function ln_Chk02() {
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
	Description : 분류코드 찾기
	parameter   : p - fr : 분류코드 , p- to
******************************************************************************/
function ln_Popup(p){
	//var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	if(hid_login.value=="M") return;

	strURL = "./commlist_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		//eval(e).value  = arrParam[0];
		 if(p=="fr") {
				gcem_cmtype_fr.text = arrParam[0];
				txt_cmnam_fr.value = arrParam[1];
		 }else if(p=="to"){
				//gcem_cmtype_to.text = arrParam[0];
				//txt_cmnam_to.value = arrParam[1];
			}
	} else {
		if(p=="fr") {
			gcem_cmtype_fr.text = "";
			txt_cmnam_fr.value ="";
		}else if(p=="to"){
			//gcem_cmtype_to.text = "";
			//txt_cmnam_to.value = "";
		}
	}
}


/******************************************************************************
	Description : Dataset Head 설정
******************************************************************************/
function ln_SetDataHeader(){
    var s_temp = "CMTYPE:STRING";
		gcds_code03.SetDataHeader(s_temp);
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--코드목록-->
</object>

<object  id=gcds_code02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--코드상세-->
</object>

<object  id=gcds_code03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--코드상세 분류코드별 삭제-->
</object>

<object  id=gcds_login classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!--코드상세 분류코드별 삭제-->
</object>
</comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<comment id="__NSID__">
<object  id="gctr_code01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--코드목록-->
	<PARAM NAME="KeyValue" VALUE="a010001_t1(I:USER=gcds_code01)">
</object>

<object  id="gctr_code02" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--코드상세-->
	<PARAM NAME="KeyValue" VALUE="a010001_t2(I:USER=gcds_code02)">
</object>

<object  id="gctr_code03" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--코드상세 분류코드별 삭제-->
	<PARAM NAME="KeyValue" VALUE="a010001_t3(I:USER=gcds_code03)"> 
</object>
</comment><script>__ws__(__NSID__);</script> 
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
	//document.all.LowerFrame.style.visibility="visible";
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
	//document.all.LowerFrame.style.visibility="hidden";
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
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/a010001_head.gif"></td>
    <td width="685" align="right" background="<%=HDConstant.PATH_ACC_COMMON%>img/com_t_bg.gif" style="padding-top:4px;"> 
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query01()">
			<input type="hidden" class="txt11" id="hid_login"  style="position:relative;left:0px;width:60px;background-color:#d7d7d7" readOnly>
		</td>
  </tr>
	<tr>
		<td colspan=2> 
			<table  cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="80" align=center  style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox"><nobr>코드명</nobr></td>
					<td>&nbsp;
						<input id="txt_cmnam_fr" type="text" class="txtbox"  style= "position:relative;left:-5px;top:-2px;width:150px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" onkeydown="if(event.keyCode==13) ln_Query01();">
						<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="분류코드를 검색합니다" style="cursor:hand;position:relative;left:-5px;top:3px" align=center onclick="ln_Popup('fr');">
					
						<comment id="__NSID__"><object  id=gcem_cmtype_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:35px;height:20px;position:relative;left:0px;top:5px" onKeydown="if(event.keyCode==13) ln_Query01()">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Numeric       value=false>
							<param name=Format        value="####">
							<param name=PromptChar    value="">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=false>

						</object></comment><script>__ws__(__NSID__);</script> 
           <!-- <comment id="__NSID__"><object  id=gcem_cmtype_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:35px;height:20px;position:relative;left:0px;top:5px">				
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="####">
                    <param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> 
						<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="분류코드를 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px" align=center onclick="ln_Popup('to');">
						<input id="txt_cmnam_to" type="text" class="txtbox"  style= "position:relative;top:1px;width:150px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> -->
					</td>
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
      
          <td style="width:567px;height:210">
						<comment id="__NSID__"><object  id=gcgd_code01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="WIDTH:567px; HEIGHT:200px;border:1 solid #777777;" viewastext class="txtbox">
                            <PARAM NAME="DataID"			VALUE="gcds_code01">
                            <PARAM NAME="Editable"		    VALUE="false">
                            <PARAM NAME="BorderStyle"   VALUE="0">
							<param name="SortView"         value="Left">
							<param name="ColSizing"        value="true">
							<param name="FillArea"           value="True">
							<param name="IndWidth"         value="0">
							<PARAM NAME="Format"   	   value="
								<C> Name='분류코드'		ID=CMTYPE   	  HeadAlign=Center  HeadBgColor=#B9D4DC  Width=71    align=center	 sort=true</C>
								<C> Name='코드명'	        ID=CMNAM	      HeadAlign=Center  HeadBgColor=#B9D4DC  Width=145  align=left         sort=true</C>
								<C> Name='길이'	            ID=CMLEN	      HeadAlign=Center  HeadBgColor=#B9D4DC  Width=30    align=right	   Edit=none </C>
								<C> Name='폐기일자'	    ID=DSUDT  		  HeadAlign=Center  HeadBgColor=#B9D4DC  Width=75    align=center   Edit=none   Mask='XXXX/XX/XX'   sort=true </C>
								<C> Name='비고'		        ID=CMREMARK   HeadAlign=Center  HeadBgColor=#B9D4DC  Width=228  align=left         Edit=none </C> 
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

									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Delete01()" >
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add01()" >
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save01()">
								</td>									
							</tr>
							<tr>
								<td style="height:25px;width:205px;border:1 solid #708090;border-top-width:1px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>분류코드</nobr></td>
								<td style="border:1 solid #708090;border-top-width:1px;border-left-width:0px">&nbsp;
									<input id="txt_cmtype" type="text" class="txtbox" style= "width:35px; height:20px;position:relative;left:-6px"  maxlength="4" onBlur="bytelength(this,this.value,4);">
								</td>									
							</tr>
							<tr>
								<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">코 드 명</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;
									<input id="txt_cmnam" type="text" class="txtbox"  style= "width:175px; height:20px;position:relative;left:-6px" maxlength="36" onBlur="bytelength(this,this.value,100);">
								</td>
							</tr>
							<tr>
								<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">길&nbsp;&nbsp;&nbsp;&nbsp;이</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;<comment id="__NSID__">	<object  id=gcem_cmlen classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:35px;height:20px;position:relative;left:0px;top:3px">				
										<param name=Text					value="">
										<param name=Alignment     value=2>
										<param name=Border        value=true>
										<param name=Numeric       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script> 
								</td>
							</tr>
							<tr>
								<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">폐기일자</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;padding-left:2px;"><comment id="__NSID__">
									<object  id=gcem_dsudt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
									style="position:relative;top:1px;left:4px;width:70px;height:20px;">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									</object></comment><script>__ws__(__NSID__);</script> 
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_dsudt01', 'Text')" style="position:relative;width:20px;left:6px;cursor:hand;">
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">비&nbsp;&nbsp;&nbsp;&nbsp;고</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px" >&nbsp;
								<textarea id="txt_cmremark" class="txtbox"  style= "width:175px; height:68px; overflow:auto;position:relative;left:-6px" maxlength="30" onBlur="bytelength(this,this.value,30);"></textarea>
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
              <PARAM NAME="DataID"			VALUE="gcds_code02">
              <PARAM NAME="Editable"		VALUE="false">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="SortView"    value="Left">
							<param name="ColSizing"  value="true">
							<param name="FillArea"   value="True">
							<param name="IndWidth"   value="0">
							<PARAM NAME="Format"			VALUE="
								<C> Name='표준코드'	ID=CDCODE	HeadAlign=Center HeadBgColor=#B9D4DC Width=71  align=center sort=true</C>
								<C> Name='표준코드명'		ID=CDNAM	HeadAlign=Center HeadBgColor=#B9D4DC Width=110 align=left   sort=true</C>
								<C> Name='출력순서'	ID=PSEQ	HeadAlign=Center HeadBgColor=#B9D4DC Width=71  align=center sort=true</C>
								<C> Name='폐기일자'	ID=DSUDT	HeadAlign=Center HeadBgColor=#B9D4DC Width=75  align=center	sort=true</C>
								<C> Name='구분'   	ID=GBCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=67  align=LEFT sort=true</C>
								<C> Name='비고'			ID=CDREMARK HeadAlign=Center HeadBgColor=#B9D4DC Width=155	align=left </C>
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
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Delete02()" >
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add02()" >
									<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save02()">
								</td>									
							</tr>
							<tr>
								<td style="height:25px;width:205px;border:1 solid #708090;border-top-width:1px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>표준코드</nobr></td>
								<td style="border:1 solid #708090;border-top-width:1px;border-left-width:0px">&nbsp;
									<input id="txt_cdcode" type="text" class="txtbox" style= "width:134px; height:20px;position:relative;left:-6px"  maxlength="20" onBlur="bytelength(this,this.value,20);">
								</td>									
							</tr>
							<tr>
								<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">코 드 명</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;
									<input id="txt_cdnam" type="text" class="txtbox"  style= "width:175px; height:20px;position:relative;left:-6px" maxlength="36" onBlur="bytelength(this,this.value,100);">
								</td>
							</tr>
							<tr>
								<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">출력순서</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;
									<input id="txt_pseq" type="text" class="txtbox"  style= "width:134x; height:20px;position:relative;left:-6px" maxlength="5" onBlur="bytelength(this,this.value,5);">
								</td>
							</tr>
							<tr>
								<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">폐기일자</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;<comment id="__NSID__">
									<object  id=gcem_dsudt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
									style="position:relative;top:1px;width:70px;height:20px;">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									</object></comment><script>__ws__(__NSID__);</script> 
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_dsudt02', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
								</td>
							</tr>
							<tr>
								<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">구 분</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;
									<input id="txt_gbcd" type="text" class="txtbox"  style= "width:134px; height:20px;position:relative;left:-6px" maxlength="30" onBlur="bytelength(this,this.value,30);">
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">비&nbsp;&nbsp;&nbsp;&nbsp;고</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px" >&nbsp;
									<textarea id="txt_cdremark" class="txtbox"  style= "width:175px; height:45px; overflow:auto;position:relative;left:-6px" maxlength="30" onBlur="bytelength(this,this.value,30);"></textarea>
								</td>
							</tr>
							<tr>
								<td style="height:20px;border:0 solid #708090;border-top-width:0px;" >&nbsp;</td>
								<td style="border:0 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;</td>
							</tr>
						
						</table>
					</td>
					
					
        </tr>
        
        <tr><td colspan=2 height=3><strong><font size="2" color="blue">* 원가코드 구분 : 01-관광, 02-MICE, 03-건설, 04-경협, 05-개성</font></strong>  </td></tr> 
      </table>
    </td>
  </tr>

 
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_code01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_code01>
	<param name=ActiveBind         value=true>
	<param name=BindInfo			value='
		<C>Col=CMTYPE       Ctrl=txt_cmtype             Param=value</C>
		<C>Col=CMNAM		 Ctrl=txt_cmnam             Param=value</C>
		<C>Col=CMLEN		 Ctrl=gcem_cmlen	     Param=text </C>
		<C>Col=DSUDT		 Ctrl=gcem_dsudt01		 Param=text</C>
		<C>Col=CMREMARK	 Ctrl=txt_cmremark		 Param=value</C> 
		' >
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcbn_code02 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_code02>
	<param name=ActiveBind         value=true>
	<param name=BindInfo			value="
		<C>Col=CDCODE       Ctrl=txt_cdcode           Param=value</C>
		<C>Col=CDNAM		 Ctrl=txt_cdnam            Param=value</C>
		<C>Col=PSEQ           Ctrl=txt_pseq                Param=value</C>
		<C>Col=DSUDT		 Ctrl=gcem_dsudt02		Param=text </C>
		<C>Col=GBCD           Ctrl=txt_gbcd                Param=value</C>
		<C>Col=CDREMARK	 Ctrl=txt_cdremark		Param=value</C>
	">
</object></comment><script>__ws__(__NSID__);</script> 


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 