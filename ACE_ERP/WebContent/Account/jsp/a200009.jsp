<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:  어음관리 - 원장관리
+ 프로그램 ID	:  A200009.html
+ 기 능 정 의	:  지급어음 등록,저장,삭제,조회 및 출력 화면이다.
+ 작   성  자 :  이 순 미
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 원장관리
+ 수   정  자 :  정 영 식
+ 수 정 일 자 :  2006.06.01
-----------------------------------------------------------------------------
+ 서 블 릿 명	:	 a200009_s1
------------------------------------------------------------------------------>

<html>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>원장관리</title>


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
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_date3 = gcurdate.substring(0,4);
var gs_date4 = gcurdate.substring(5,7);
var gs_fdcode = gfdcode;
var gs_usrid = gusrid;
var gstr_fundiv =""; //자금구분
var gstr_atdecr =""; //차대구분
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();
	ln_Enable("f");
	
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(s){
	if(s=="01") {
		var str1  = gclx_sfdcode1.BindColVal;				//지점코드   
		var str2  = txt_atcode_fr.value             //계정   
		var str3  = gstr_fundiv;				            //자금구분       
		var str4  = fn_trim(gcem_sstrdatefr1.text);	//발생일자fr
		var str5  = fn_trim(gcem_sstrdateto1.text);	//발생일자to 
		var str6  = gclx_sstatdiv1.BindColVal;			//처리구분   

		if (txt_atcodenm_fr.value==""){
			alert("계정명을 선택하십시요.");
			txt_atcodenm_fr.focus();
			return false; 
		}

		if (txt_atcode_fr.value==""){
			alert("계정코드를 선택하십시요.");
			txt_atcode_fr.focus();
			return false; 
		}

		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a200009_s1"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6;
		gcds_data1.Reset();

		ln_Enable("f");
	}
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){
  if(gcds_data1.countrow<=0){
		ln_SetDataHeader("01");
	}
	
	if(ln_Add_Chk()){
		if(ln_Chk()){
			gcds_data1.AddRow();
			ln_Enable("t");
			gcem_strdate.text = gs_date;	//발생일자
			gcem_enddate.text = gs_date;	//만기일자
			gcem_actdat.text  = gs_date;	//회계일자
			gcem_actdat1.text = gs_date;	//처리일자
			gclx_statdiv1.index = 0;			//처리구분
			gcds_data1.namevalue(gcds_data1.rowposition,"FDCODE")=gclx_sfdcode1.BindColVal;
			gcds_data1.namevalue(gcds_data1.rowposition,"ATCODE")=txt_atcode_fr.value;
			gcds_data1.namevalue(gcds_data1.rowposition,"FUNDDIV")=gstr_fundiv;
			gcds_data1.namevalue(gcds_data1.rowposition,"ATDECR")=gstr_atdecr;
		}
	}else{
 
	}

}

/******************************************************************************
	Description : 추가시 빈칸을 두번 등록하지 않음.
******************************************************************************/
function ln_Add_Chk(){	
	for(i=1; i<=gcds_data1.countrow;i++){
		if(gcds_data1.namevalue(i,"REFCODE2")==""){
			return false
		}
	}
	return true;
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
	if(gcds_data1.IsUpdated) {
		if(ln_Chk()) {
			ln_Janamt_Cal();
			gctr_data1.Action    = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a200009_t1";
			gctr_data1.Parameters = "v_str1="+gs_date+",v_str2="+gs_usrid;
			gctr_data1.post();
			ln_Query('01');
		}
	}
}

/******************************************************************************
	Description : 필수항목 입력체크 
******************************************************************************/
function ln_Chk() {
	if (gclx_sfdcode1.BindColVal==""){
		alert("지점구분을 선택하십시요.");
		gclx_sfdcode1.focus();
		return false; 
	}

  if (txt_atcodenm_fr.value==""){
		alert("계정명을 선택하십시요.");
		txt_atcodenm_fr.focus();
		return false; 
	}

	if (txt_atcode_fr.value==""){
		alert("계정코드를 선택하십시요.");
		txt_atcode_fr.focus();
		return false; 
	}


/*
	for(var i=1;i<=gcds_data1.countrow;i++){
		if(gcds_data1.SysStatus(i)==1){
			gcds_data1.namevalue(i,"FDCODE")  = gclx_sfdcode1.BindColVal;	//지점구분
			gcds_data1.namevalue(i,"FUNDDIV") = gclx_sfunddiv.BindColVal;	//자금구분
			gcds_data1.namevalue(i,"ATCODE")  = "2100102";	//계정과목
		}
	}
*/
	return true;
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(e){
	if(e=="01"){
		if (confirm("삭제 하시겠습니까?")){	
			gctr_data1.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a200009_t1";
			gctr_data1.Parameters = "v_str1="+gs_date+",v_str2="+gs_usrid;
			gcds_data1.DeleteRow(gcds_data1.rowposition);
			gctr_data1.post();
			ln_Query('01');
		}
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
function ln_Print(e){
  if(e=="01") {
		if(gcds_print1.countrow<1) {
			alert("출력할 정보가 없습니다.");
		}else{
			gcrp_print1.preview();
		}
	}
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(e){
  if(e=="01") {
		if (gcds_data1.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_disp01.RunExcel('원장관리');
	}
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
	gcem_sstrdatefr1.text = gs_date2+"01";	//[검색]발생from
	gcem_sstrdateto1.text = gs_date;				//[검색]발생to
	gclx_sstatdiv1.index  = 1;							//[검색]처리구분
	
	gcem_strdate.text = gs_date;	//[입력]발생일자
	gcem_enddate.text = gs_date;	//[입력]만기일자
	gcem_actdat.text  = gs_date;	//[입력]회계일자
	gcem_actdat1.text = gs_date;	//[입력]처리일자

	//지점코드[검색]
	gcds_sfdcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode1.Reset();

	//자금구분[검색]
	gcds_sfunddiv.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0053"; 
	gcds_sfunddiv.Reset();
}

/***********************************************************************************************
	Description : 은행 찾기
	parameter   : arrParam[0] - 은행코드, arrParam[1] - 은행명
**********************************************************************************************/
function ln_Popup(e){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./commdtil_popup_ifrm.jsp";
	arrParam[0]="0022";
	arrParam[1]="";
	strPos = "dialogWidth:398px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult!=null) {
		arrParam = arrResult.split(";");
		if(e=="01") {
		
		}else if(e=="02") {
			gcem_bancod1.text = arrParam[0];
			gcem_bancodnm1.text = arrParam[1];
		}
	} else {
		if(e=="01") {
		
		}else if(e=="02") {
			gcem_bancod1.text = "";
			gcem_bancodnm1.text ="";
		}
	}
}

/***********************************************************************************************
	Description : 거래처 찾기
	parameter   : arrParam[0] - 거래처코드, arrParam[1] - 거래처명
**********************************************************************************************/
function ln_Popup2(e){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	//strURL = "./Commdtil_popup_ifrm.jsp";
	strURL = "./gczm_vender_popup.jsp";
	
	arrParam[0]="0020";
	arrParam[1]="";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		if(e=="01") {
			
			
		}else if(e=="02") {
			gcem_vendcd1.text = arrParam[0];
			gcem_vendnm1.text = arrParam[1];
		}
	} else {
		if(e=="01") {
			
		}else if(e=="02") {
			gcem_vendcd1.text = "";
			gcem_vendnm1.text ="";
		}
	}
}


/***********************************************************************************************
	Description : 계정코드 
	parameter   : p1 - 구분  p2-구분2, p3-자금구분값 obj
**********************************************************************************************/
function ln_Popup3(p1,p2,p3,obj1,obj2){ 
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	if (p1=="01"){//계정과목
    
		strURL = "./actcode_fund_popup.jsp";
		arrParam[0]=eval(obj1).value;
		arrParam[1]=eval(obj2).value;
		arrParam[2]=p3;
		arrParam[3]="ATUSEYN";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			 if(p2=="fr"){
				txt_atcode_fr.value = arrParam[0];
				txt_atcodenm_fr.value = arrParam[1];
				gstr_fundiv = arrParam[2];
			}

		} else {
			if(p2=="fr") {
			  txt_atcode_fr.value="";
				txt_atcodenm_fr.value="";
				gstr_fundiv = "";
			}
		}
	}
}

/***********************************************************************************************
	Description : 계정코드 
	parameter   : p1 - 구분  p2-관리항목코드
**********************************************************************************************/
function ln_Popup4(p1,p2){
	var result ="";
	var strURL;	
	var strPos;
	var arrResult = new Array();
	var arrParam	= new Array();
  
	if(p2=="0050"){
		arrParam[0]	= p2; //관리항목
		strURL = "./commdtil_popup.jsp";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
		result = showModalDialog(strURL,arrParam,strPos);

		if (result == -1 || result == null || result == ""){
		  txt_fsrefcd1.value= "";
			gcem_fsrefnm1.text = "";
		}else{
			arrResult = result.split(";");
			txt_fsrefcd1.value= arrResult[0];
			gcem_fsrefnm1.text = arrResult[1];
		}
	}else{
		arrParam[0]	= txt_fsrefcd1.value; //관리항목
		strURL = "./commdtil_popup.jsp";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
		result = showModalDialog(strURL,arrParam,strPos);

		if (result == -1 || result == null || result == ""){
		  txt_fsrefval1.value= "";
			gcem_fsrefvalnm1.text = "";
		}else{
			arrResult = result.split(";");
			txt_fsrefval1.value= arrResult[0];
			gcem_fsrefvalnm1.text = arrResult[1];
		}
	}
}

/******************************************************************************
	Description : lost focus 시 
	prameter    : p1 - 01 전표작성
	                   02 내역조회
								p2 - atcode:계정
								obj
******************************************************************************/
function ln_Blur(p1,p2,obj1,obj2){
	if(p1=="01"){
		if(p2=="atcode"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 또는 Enter 
				ln_Popup3('01','fr','B',obj1,obj2);
			 
		}
	}
}


/******************************************************************************
	Description : 저장할 Data를 위한 DataSetHead 설정
  parameter   : p - 01 : 자금원장
******************************************************************************/
function ln_SetDataHeader(p){
	if(p=="01"){
		var str_dataset = "FDCODE:STRING,ATCODE:STRING,FUNDDIV:STRING,REFCODE2:STRING,STRDATE:STRING,"
									  + "ENDDATE:STRING,DRAMT:DECIMAL,CRAMT:DECIMAL,VEND_CD:STRING,VENDNM:STRING,BANCOD:STRING,BANNAM:STRING,"
 									  + "INRATE:DECIMAL,OUTRATE:DECIMAL,DRFAMT:DECIMAL,CRFAMT:DECIMAL,CURDIV:STRING,"
									  + "EXRATE:DECIMAL,STATDIV:STRING,REMARK:STRING,FSDAT:STRING,FSNBR:STRING,"
									  + "FSSEQ:STRING,ACTDAT:STRING,FSDAT1:STRING,FSNBR1:STRING,FSSEQ1:STRING,"
										+ "ACTDAT1:STRING,FSREFCD:STRING,FSREFVAL:STRING,UPDT:STRING,UPID:STRING,JANAMT1:DECIMAL,JANAMT2:DECIMAL"
										+ "ATDECR:STRING";
		
		gcds_data1.SetDataHeader(str_dataset);
	}
}


/******************************************************************************
	Description : lock
  parameter   : p - t ; f
******************************************************************************/
function ln_Enable(p){
	if(p=="t"){
		gcem_refcode21.ReadOnly=false;
	}else if(p=="f"){
    gcem_refcode21.ReadOnly=true;
	}

}

/******************************************************************************
	Description : 저장시 잔액 계산
  parameter   : p - t ; f
******************************************************************************/
function ln_Janamt_Cal(){
	for(i=1;i<=gcds_data1.countrow;i++){
		if(gcds_data1.SysStatus(i)==1 ||gcds_data1.SysStatus(i)==3){ //입력 수정
			if(gcds_data1.namevalue(i,"ATDECR")=="1"){
         gcds_data1.namevalue(i,"JANAMT1")=gcds_data1.namevalue(i,"DRAMT")- gcds_data1.namevalue(i,"CRAMT");
				 gcds_data1.namevalue(i,"JANAMT2")=gcds_data1.namevalue(i,"DRFAMT")- gcds_data1.namevalue(i,"CRFAMT");
			}else if(gcds_data1.namevalue(i,"ATDECR")=="2"){
				 gcds_data1.namevalue(i,"JANAMT1")=gcds_data1.namevalue(i,"CRAMT")- gcds_data1.namevalue(i,"DRAMT");
				 gcds_data1.namevalue(i,"JANAMT2")=gcds_data1.namevalue(i,"CRFAMT")- gcds_data1.namevalue(i,"DRFAMT");
			}
		}
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfunddiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_print1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gctr_data1 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4">
		<param name="keyvalue"    value="Account.a200009_t1(I:USER=gcds_data1)">
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

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
 <script language="javascript"  for=gcgd_disp01 event=OnClick(Row,Colid)>
   ln_Enable("t");
 </script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data1" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_data1" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data1.ErrorCode + "\n" + "Error Message : " + gctr_data1.ErrorMsg + "\n");
</script>

</head>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
 
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/a200009_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2 align=left style="position:relative;left:0px"></td>
  </tr>
  <tr> 
    <td COLSPAN=2>
		
<!-- 원장관리 ===========================================================================================================-->
<table  cellpadding="0" cellspacing="0" border="0">		
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:1px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>지점구분</nobr></td>
					<td class="tab21" style="width:110px">
						<comment id="__NSID__"><object  id=gclx_sfdcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:100px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode1">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="FDNAME^0^90">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee" ><nobr>&nbsp;계정과목&nbsp;</nobr></td>
					<td class="tab22" style="width:100px;" ><nobr>&nbsp;
						<input id="txt_atcodenm_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-6px;width:210px; height:20px;ime-mode:active;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode_fr', 'txt_atcodenm_fr')">
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정과목을 검색합니다" style="cursor:hand;position:relative;left:-4px;top:0px;" align=center onclick="ln_Popup3('01','fr','B','txt_atcode_fr','txt_atcodenm_fr');">
						<input id="txt_atcode_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:60px; height:20px;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode_fr','txt_atcodenm_fr')" >
					</nobr>
					</td> 
					<td class="tab22" align="right" >&nbsp;<nobr>      
						<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Delete('01')">
						<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Add('01')">
						<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Save('01')">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('01')"> 
						</nobr>
					</td>
			 </tr>
			 <tr>
			    <td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>처리구분</nobr></td>
					<td class="tab23" ><comment id="__NSID__"><object  id=gclx_sstatdiv1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:110px;">
							<param name=CBData					value="^전체,0^진행,1^완료">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^90">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>발생일자</nobr></td>
					<td style="width:290px" colspan=2>
						<comment id="__NSID__"><object id=gcem_sstrdatefr1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sstrdatefr1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~
					<comment id="__NSID__"><object id=gcem_sstrdateto1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_sstrdateto1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
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
							<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:464px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:-1px" viewastext>
								<PARAM NAME="DataID"        VALUE="gcds_data1">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"      VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"        VALUE="  
								<C> Name='No.'			ID={CURROW}	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
								<C> Name='관리번호'	ID=REFCODE2		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left		SumText='계'	SumBgColor='#C3D0DB'</C> 
								<C> Name='원화금액'	ID=JANAMT1	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='외화금액'	ID=JANAMT2	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='은행'			ID=BANNAM		  HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='거래처'		ID=VENDNM		  HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='발생일자'	ID=STRDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=right		SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
								<C> Name='만기일자'	ID=ENDDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=right		SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
							<fieldset style="position:relative;left:-1px;width:466px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
					</fieldset>
						</td>
						<td>
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:406px;height:402px;border:1 solid #708090;position:relative;left:1px'>
							<tr>											
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">관리번호</td>
								<td class="tab22" colspan="3"><comment id="__NSID__">
									<object  id=gcem_refcode21 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:200px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Text					value="">
										<param name=Border        value=true>
										<param name=GeneralEdit   value="true">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
										<param name=MaxLength     value=30>
										<param name=Language			value=1>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">발생일자</td>
								<td class="tab21" style="width:115px;"><comment id="__NSID__">
								<object id=gcem_strdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_strdate', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
								</td>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">만기일자</td>
								<td class="tab22" style="width:115px;"><comment id="__NSID__">
								<object id=gcem_enddate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_enddate', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">은&nbsp;&nbsp;&nbsp;&nbsp;행</td>  
								<td class="tab22" colspan="3"><nobr><comment id="__NSID__">
									<object  id=gcem_bancodnm1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:220px;height:20px;position:relative;left:5px;top:2px">		
										<param name=Text					value="">
										<param name=Border        value=true>
										<param name=GeneralEdit   value="true">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
										<param name=Language			value=1>
									</object></comment><script>__ws__(__NSID__);</script>
									<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:8px;cursor:hand"	 onclick="ln_Popup('02')">
									<comment id="__NSID__">
									<object id=gcem_bancod1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:45px">
										<param name=Text				value="">
										<param name=Alignment		value=0>
										<param name=Border			value=true>
										<param name=Format			value="######">
										<param name=PromptChar	value="_">
										<param name=Enable			value="false">
									</object></comment><script>__ws__(__NSID__);</script>
									</nobr>
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">거&nbsp;래&nbsp;처</td>  
								<td class="tab22" colspan="3"><nobr><comment id="__NSID__">
									<object  id=gcem_vendnm1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:175px;height:20px;position:relative;left:5px;top:2px">		
										<param name=Text					value="">
										<param name=Border        value=true>
										<param name=GeneralEdit   value="true">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
										<param name=Language			value=1>
									</object></comment><script>__ws__(__NSID__);</script>
									<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:8px;cursor:hand"	 onclick="ln_Popup2('02')">
									<comment id="__NSID__">
									<object id=gcem_vendcd1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:90px">
										<param name=Text				value="">
										<param name=Alignment		value=0>
										<param name=Border			value=true>
										<param name=Format			value="#############">
										<param name=PromptChar	value="_">
										<param name=Enable			value="false">
									</object></comment><script>__ws__(__NSID__);</script>
									</nobr>
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">차변금액</td>
								<td class="tab21" style="width:115px;"><comment id="__NSID__">
									<object  id=gcem_dramt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:0px;width:110px;">
										<param name=Text				value="">
										<param name=Alignment		value="2">
										<param name=Border			value="true">
										<param name=IsComma     value=true>
										<param name=Numeric			value="true">
										<param name=ClipMode		value="true">
										<param name=MaxLength		value=15>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">외화차변</td>
								<td class="tab22" style="width:115px;"><comment id="__NSID__">
									<object  id=gcem_drfamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:0px;width:120px;">
										<param name=Text				value="">
										<param name=Alignment		value="2">
										<param name=Border			value="true">
										<param name=IsComma     value=true>
										<param name=Numeric			value="true">
										<param name=ClipMode		value="true">
										<param name=MaxLength		value=15>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">대변금액</td>
								<td class="tab21" style="width:115px;"><comment id="__NSID__">
									<object  id=gcem_cramt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:0px;width:110px;">
										<param name=Text				value="">
										<param name=Alignment		value="2">
										<param name=Border			value="true">
									  <param name=IsComma     value=true>
										<param name=Numeric			value="true">
										<param name=ClipMode		value="true">
										<param name=MaxLength		value=15>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">외화대변</td>
								<td class="tab22" style="width:115px;"><comment id="__NSID__">
									<object  id=gcem_crfamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:0px;width:120px;">
										<param name=Text				value="">
										<param name=Alignment		value="2">
										<param name=Border			value="true">
										<param name=Numeric			value="true">
										<param name=IsComma     value=true>
										<param name=ClipMode		value="true">
										<param name=MaxLength		value=15>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">잔&nbsp;&nbsp;&nbsp;&nbsp;액</td>
								<td class="tab21" style="width:115px;"><comment id="__NSID__">
									<object  id=gcem_janamt1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:0px;width:110px;">
										<param name=Text				value="">
										<param name=Alignment		value="2">
										<param name=Border			value="true">
										<param name=IsComma     value=true>
										<param name=Numeric			value="true">
										<param name=ClipMode		value="true">
										<param name=ReadOnly    value="true">
										<param name=MaxLength		value=15>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">잔&nbsp;&nbsp;&nbsp;&nbsp;액</td>
								<td class="tab22" style="width:115px;"><comment id="__NSID__">
									<object  id=gcem_janamt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:0px;width:120px;">
										<param name=Text				value="">
										<param name=Alignment		value="2">
										<param name=Border			value="true">
										<param name=IsComma     value=true>
										<param name=Numeric			value="true">
										<param name=ClipMode		value="true">
										<param name=ReadOnly    value="true">
										<param name=MaxLength		value=15>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">수신이율</td>
								<td class="tab21" style="width:115px;"><comment id="__NSID__">
									<object  id=gcem_inrate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:0px;width:60px;">
										<param name=Text				value="">
										<param name=Alignment		value="2">
										<param name=Border			value="true">
										<param name=MaxDecimalPlace  value=2>
										<param name=MaxLength		value=5>
										<param name=ClipMode		value="true">
										<param name=IsComma			value="true">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">통화구분</td>
								<td class="tab22" style="width:115px;"><comment id="__NSID__">
									<object  id=gcem_curdiv classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:25px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Text				value="">
										<param name=Alignment		value="0">
										<param name=Border			value="true">
										<param name=Format			value="###">
										<param name=PromptChar	value="_">
										<param name=MaxLength		value=3>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">여신이율</td>
								<td class="tab21" style="width:115px;"><comment id="__NSID__">
									<object  id=gcem_outrate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:0px;width:60px;">
										<param name=Text				value="">
										<param name=Alignment		value="2">
										<param name=Border			value="true">
										<param name=MaxDecimalPlace  value=2>
										<param name=MaxLength		value=5>
										<param name=ClipMode		value="true">
										<param name=IsComma			value="true">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">환&nbsp;&nbsp;&nbsp;&nbsp;율</td>
								<td class="tab22" style="width:115px;"><comment id="__NSID__">
									<object  id=gcem_exrate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:0px;width:70px;">
										<param name=Text				value="">
										<param name=Alignment		value=2>
										<param name=Border			value=true>
										<param name=MaxDecimalPlace  value=2>
										<param name=MaxLength		value=6>
										<param name=ClipMode		value="true">
										<param name=IsComma			value="true">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">적&nbsp;&nbsp;&nbsp;&nbsp;요</td>
								<td class="tab22" colspan="3"><comment id="__NSID__">
									<object  id=gcem_remark classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:310px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Text					value="">
										<param name=Border        value="true">
										<param name=GeneralEdit   value="true">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value="false">
										<param name=Language			value="1">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">발생전표</td>
								<td class="tab22" style="width:115px;" colspan="3"><nobr><comment id="__NSID__">
									<object  id=gcem_fsdat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:2px;width:70px">
										<param name=Text				value="">
										<param name=Alignment		value=0>
										<param name=Border			value=true>
										<param name=ClipMode		value=true>
										<param name=Numeric			value=false>
										<param name=Format			value="#########">
										<param name=PromptChar	value="_">
										<!-- <param name=Enable			value="false"> -->
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;-
									<comment id="__NSID__"><object  id=gcem_fsnbr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:0px;top:2px;width:45px">
										<param name=Text				value="">
										<param name=Alignment		value=0>
										<param name=Border			value=true>
										<param name=ClipMode		value=true>
										<param name=Numeric			value=false>
										<param name=Format			value="######">
										<param name=PromptChar	value="_">
										<!-- <param name=Enable			value="false"> -->
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;-
									<comment id="__NSID__"><object  id=gcem_fsseq classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:0px;top:2px;width:45px">
										<param name=Text				value="">
										<param name=Alignment		value=0>
										<param name=Border			value=true>
										<param name=ClipMode		value=true>
										<param name=Numeric			value=false>
										<param name=Format			value="#####">
										<param name=PromptChar	value="_">
										<!-- <param name=Enable			value="false"> -->
									</object></comment><script>__ws__(__NSID__);</script>
									
									</nobr>
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">발생회계일</td>
								<td class="tab21" style="width:115px;"><comment id="__NSID__">
								<object id=gcem_actdat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
								</td>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">&nbsp;</td>
								<td class="tab22" style="width:115px;">&nbsp;</td>
							</tr>
							<tr>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">처리전표</td>
								<td class="tab22" style="width:115px;" colspan="3"><nobr><comment id="__NSID__">
									<object  id=gcem_fsdat1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:2px;width:70px">
										<param name=Text				value="">
										<param name=Alignment		value=0>
										<param name=Border			value=true>
										<param name=ClipMode		value=true>
										<param name=Numeric			value=false>
										<param name=Format			value="#########">
										<param name=PromptChar	value="_">
										<!-- <param name=Enable			value="false"> -->
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;-
									<comment id="__NSID__"><object  id=gcem_fsnbr1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:0px;top:2px;width:45px">
										<param name=Text				value="">
										<param name=Alignment		value=0>
										<param name=Border			value=true>
										<param name=ClipMode		value=true>
										<param name=Numeric			value=false>
										<param name=Format			value="######">
										<param name=PromptChar	value="_">
										<!-- <param name=Enable			value="false"> -->
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;-
									<comment id="__NSID__"><object  id=gcem_fsseq1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:0px;top:2px;width:45px">
										<param name=Text				value="">
										<param name=Alignment		value=0>
										<param name=Border			value=true>
										<param name=ClipMode		value=true>
										<param name=Numeric			value=false>
										<param name=Format			value="#####">
										<param name=PromptChar	value="_">
										<!-- <param name=Enable			value="false"> -->
									</object></comment><script>__ws__(__NSID__);</script>
									</nobr>
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">처리회계일</td>
								<td class="tab21" style="width:115px;"><comment id="__NSID__">
									<object id=gcem_actdat1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
								</td>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">관리항목</td>
                                <td class="tab22" ><nobr><comment id="__NSID__">
									<object  id=gcem_fsrefnm1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:5px;top:2px">		
										<param name=Text					value="">
										<param name=Border        value=true>
										<param name=GeneralEdit   value="true">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
										<param name=Language			value=1>
									</object></comment><script>__ws__(__NSID__);</script>
									 <input id="txt_fsrefcd1"  type="hidden"   style= "width:0px; height:20px;">
									<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:1px;cursor:hand"	 onclick="ln_Popup4('','0050')">
							   
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">처리구분</td>
								<td class="tab21" style="width:115px;"><comment id="__NSID__">
									<object  id=gclx_statdiv1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:110px;height:110px;">
										<param name=CBData					value="^,0^진행,1^완료">
										<param name=CBDataColumns		value="CDCODE,CDNAM">
										<param name=SearchColumn		value="CDNAM">
										<param name=Sort						value="false">
										<param name=ListExprFormat	value="CDNAM^0^110">
										<param name=BindColumn			value="CDCODE">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td class="tab11" style="width:70px;" bgcolor="#eeeeee">관리항목값</td>

								 <td class="tab22" ><nobr><comment id="__NSID__">
									<object  id=gcem_fsrefvalnm1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:5px;top:2px">		
										<param name=Text					value="">
										<param name=Border        value=true>
										<param name=GeneralEdit   value="true">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
										<param name=Language			value=1>
									</object></comment><script>__ws__(__NSID__);</script>
									<input id="txt_fsrefval1"  type="hidden"   style= "width:0px; height:20px;">
									<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:1px;cursor:hand"	 onclick="ln_Popup4('','')">
								</td>
							</tr>
							<tr>
								<td colspan=2 style="height:100%;border:0 solid #708090;" >&nbsp;
								</td>
							</tr>
						</table>
								</TD>
							</tr>
						</table>
					</td>
				 </tr>
			 </table>
			 
    <td>
	</tr>
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data1>
	<param name=BindInfo  value='  
		<C>Col=REFCODE2		Ctrl=gcem_refcode21		Param=text</C>
		<C>Col=STRDATE		Ctrl=gcem_strdate			Param=text</C>
		<C>Col=ENDDATE		Ctrl=gcem_enddate			Param=text</C>
		<C>Col=BANNAM			Ctrl=gcem_bancodnm1		Param=text</C>
		<C>Col=BANCOD			Ctrl=gcem_bancod1			Param=text</C>
		<C>Col=VENDNM			Ctrl=gcem_vendnm1			Param=text</C>
		<C>Col=VEND_CD		Ctrl=gcem_vendcd1			Param=text</C>
		<C>Col=DRAMT			Ctrl=gcem_dramt				Param=text</C>
		<C>Col=DRFAMT			Ctrl=gcem_drfamt			Param=text</C>
		<C>Col=CRAMT			Ctrl=gcem_cramt				Param=text</C>
		<C>Col=CRFAMT			Ctrl=gcem_crfamt			Param=text</C>
		<C>Col=JANAMT1		Ctrl=gcem_janamt1			Param=text</C>
		<C>Col=JANAMT2		Ctrl=gcem_janamt2			Param=text</C>
		<C>Col=INRATE			Ctrl=gcem_inrate			Param=text</C>
		<C>Col=CURDIV			Ctrl=gcem_curdiv			Param=text</C>
		<C>Col=OUTRATE		Ctrl=gcem_outrate			Param=text</C>
		<C>Col=EXRATE			Ctrl=gcem_exrate			Param=text</C>
		<C>Col=REMARK			Ctrl=gcem_remark			Param=text</C>
		<C>Col=FSDAT			Ctrl=gcem_fsdat				Param=text</C>
		<C>Col=FSNBR			Ctrl=gcem_fsnbr				Param=text</C>
		<C>Col=FSSEQ			Ctrl=gcem_fsseq				Param=text</C>
		<C>Col=ACTDAT			Ctrl=gcem_actdat			Param=text</C>
		<C>Col=FSDAT1			Ctrl=gcem_fsdat1			Param=text</C>
		<C>Col=FSNBR1			Ctrl=gcem_fsnbr1			Param=text</C>
		<C>Col=FSSEQ1			Ctrl=gcem_fsseq1			Param=text</C>
		<C>Col=ACTDAT1		Ctrl=gcem_actdat1			Param=text</C>
		<C>Col=STATDIV		Ctrl=gclx_statdiv1		Param=BindColVal</C>
		<C>Col=FSREFCD		Ctrl=txt_fsrefcd1			Param=value</C>
		<C>Col=FSREFVAL		Ctrl=txt_fsrefval1		Param=value</C>
		<C>Col=FSREFCDNM		Ctrl=gcem_fsrefnm1			Param=text</C>
		<C>Col=FSREFVALNM		Ctrl=gcem_fsrefvalnm1		Param=text</C>
'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"				value="A4">
	<param name="LandScape"				value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="SuppressColumns"	value="1:pageskip,ATCODE;">
	<param name="Format"					value="
	">
</object></comment><script>__ws__(__NSID__);</script> 


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 