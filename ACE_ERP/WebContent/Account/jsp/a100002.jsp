<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  원가관리 - 원가명세서 / 총원가명세서
+ 프로그램 ID	:  A100001.html
+ 기 능 정 의	:  
+ 작   성  자 :  YS.JEONG
+ 수 정 일 자 :  2006.09.19
-----------------------------------------------------------------------------
+ 수 정 내 용 :	    
+ 수   정  자 :  
+ 수 정 일 자 :  
-----------------------------------------------------------------------------
+ 서 블 릿 명	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>원가별계정원장</title>

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

var gs_date  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7); //년월
var gs_date3 = gcurdate.substring(0,4); //년
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var g_date, g_time;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
    ln_Before();

  
	var date = new Date();
	g_date = "출력일자 : " + date.getFullYear() + "/" + date.getMonth() + "/"
											+ date.getDate();
	g_time = "출력시간 : " + date.getHours() + ":" + date.getMinutes();
	gclx_fdcode.bindcolval = gs_fdcode;
	
}

/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(){

  //gcds_data01.clearall();
	//gcds_temp01.clearall();
	gcgd_disp01.DataID="";
  
	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a100002_s1?v_str1="+gclx_fdcode.bindcolval
																		  +"&v_str2="+gcem_datefr.text
																		  +"&v_str3="+gcem_dateto.text
																		  +"&v_str4="+txt_atcode_fr.value
																		  +"&v_str5="+txt_atcode_to.value
																		  +"&v_str6="+txt_costcd_fr.value
																		  +"&v_str7="+txt_costcd_to.value;																											
	//prompt("",gcds_data01.DataID );																							
	gcds_data01.Reset();									
}


/***********************************************************************************************
	Description : [일별] - 전표 찾기
	parameter   : fcod - 지점코드, fsdt - 전표일자, fnbr - 전표번호
**********************************************************************************************/
function ln_Popup2(fcod,fsdt,fnbr){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

 // alert(fcod+"fcod");
	// alert(fsdt+"fsdt");
	//  alert(fnbr+"fnbr");
	arrParam[0] = fcod;
	arrParam[1] = fsdt;
	arrParam[2] = fnbr;

	strURL = "./slipno_popup.jsp";
	strPos = "dialogWidth:890px;dialogHeight:610px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}


/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){

}

/******************************************************************************************
	Description : 저장
******************************************************************************************/
function ln_Save(){
	
}

/******************************************************************************************
	Description : 삭제
*****************************************************************************************/
function ln_Delete(){

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

	var time = new Date();

	gcds_temp01.clearall();
	ln_PrintHeader();
	gcds_temp01.ImportData(gcds_data01.ExportData(1,gcds_data01.countrow,false));
	
	if(time.getMonth()+1<10)
		g_date = time.getFullYear()+"/0"+(time.getMonth()+1)+"/"+time.getDate();
	else
		g_date = time.getFullYear()+"/"+(time.getMonth()+1)+"/"+time.getDate();
	if(time.getHours()<10) {
		if(time.getMinutes()<10)
			g_time = "0"+time.getHours()+":0"+time.getMinutes()+" AM";
		else
			g_time = "0"+time.getHours()+":"+time.getMinutes()+" AM";
	} else if(time.getHours()>=10&&time.getHours()<12) {
		if(time.getMinutes()<10)
			g_time = ""+time.getHours()+":0"+time.getMinutes()+" AM";
		else
			g_time = ""+time.getHours()+":"+time.getMinutes()+" AM";
	} else if(time.getHours()==12) {
		if(time.getMinutes()<10)
			g_time = "12:0"+time.getMinutes()+" PM";
		else
			g_time = "12:"+time.getMinutes()+" PM";
	} else if(time.getHours()>12&&time.getHours()<22) {
		if(time.getMinutes()<10)
			g_time = "0"+(time.getHours()-12)+":0"+time.getMinutes()+" PM";
		else
			g_time = "0"+(time.getHours()-12)+":"+time.getMinutes()+" PM";
	} else {
		if(time.getMinutes()<10)
			g_time = ""+(time.getHours()-12)+":0"+time.getMinutes()+" PM";
		else
			g_time = ""+(time.getHours()-12)+":"+time.getMinutes()+" PM";
	}
	if(gcds_temp01.countrow<1)
			alert("출력할 정보가 없습니다.");
	else {
		for(i=1;i<=gcds_temp01.countrow;i++) {
			gcds_temp01.namevalue(i,"KISU1") = "";
			gcds_temp01.namevalue(i,"CURDT") = "출력일자 : " + g_date;
			gcds_temp01.namevalue(i,"CURTM") = "출력시간 : " + g_time;
		}
			gcrp_print1.preview();
	}
	
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

	//gcgd_disp01.runexcel("원가별 계정별원장");
gcgd_disp01.GridToExcel("원가별 계정별원장","",2);

}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
  
	//지점
	gcem_datefr.text = gs_date3+"0101"; //년월
	gcem_dateto.text = gs_date;
	
	//지점코드
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

}


/******************************************************************************
	Description : 조회한 데이타의 포맷을 다시 설정함.
	parameter   :  
******************************************************************************/
function ln_Data_Reset(p){

	//그리드에 출력
  	var strno="";
  	var dblDEMMSum=0;//차변월계
	var dblCRMMSum=0;//대변월계
	var dblDEATSum=0; //차변계정별 누계
	var dblCRATSum=0; //대변계정별 누계
	var dblDECTSum=0; //차변원가코드별 계
	var dblCRCTSum=0; //대변원가코드별 계
	var dblJanSum=0;  //대변원가코드별 계

	var dblDEATSum_TOT=0; //차변계정별 누계합계
	var dblCRATSum_TOT=0; //대변계정별 누계합계
	var dblJanSum_TOT=0;  //총합계 잔액합계
	
	//데이타셋 생성
	//ln_SetDataHeader("01");
	
	var aa=0;
	
	//순번 설정
  	for(i=1;i<=gcds_data01.countrow;i++){
		dblDEMMSum = dblDEMMSum + gcds_data01.namevalue(i,"DETOT");
		dblCRMMSum = dblCRMMSum + gcds_data01.namevalue(i,"CRTOT");
		
		dblDEATSum_TOT = dblDEATSum_TOT + gcds_data01.namevalue(i,"DETOT");
		dblCRATSum_TOT = dblCRATSum_TOT + gcds_data01.namevalue(i,"CRTOT");
		
		if(gcds_data01.namevalue(i,"GUBUN")=="M"){       //월계
		     gcds_data01.namevalue(i,"SSDAT") = "월 계"
             gcds_data01.namevalue(i,"DETOT") = dblDEMMSum;
			 gcds_data01.namevalue(i,"CRTOT") = dblCRMMSum;
			 gcds_data01.namevalue(i,"JANAMT") = dblJanSum;
             dblDEATSum = dblDEATSum +dblDEMMSum;
             dblCRATSum = dblCRATSum +dblCRMMSum;
             dblDEMMSum=0;
             dblCRMMSum=0;
		}else if(gcds_data01.namevalue(i,"GUBUN")=="T"){ //누계
		     gcds_data01.namevalue(i,"SSDAT") = "누 계"
		     gcds_data01.namevalue(i,"DETOT") = dblDEATSum;
			 gcds_data01.namevalue(i,"CRTOT") = dblCRATSum;
			 gcds_data01.namevalue(i,"JANAMT")= dblJanSum;
		     
			 dblDECTSum=dblDECTSum + dblDEATSum; //차변원가코드별 계
	         dblCRCTSum=dblCRCTSum + dblCRATSum; //대변원가코드별 계
	         
             dblDEATSum =0;
             dblCRATSum =0;
             //2014.01.28 jys : 총합계 잘못 가져와서 막음.
			 //dblDEATSum_TOT = dblDEATSum_TOT + dblDECTSum;  
			 //dblCRATSum_TOT = dblCRATSum_TOT + dblCRCTSum;
		}else if(gcds_data01.namevalue(i,"GUBUN")=="C"){  //원가계
		     gcds_data01.namevalue(i,"SSDAT") = "원가계"
       		 gcds_data01.namevalue(i,"DETOT") = dblDECTSum;
			 gcds_data01.namevalue(i,"CRTOT") = dblCRCTSum;
			 gcds_data01.namevalue(i,"JANAMT") = dblJanSum;
			 dblJanSum_TOT = dblJanSum;
			 dblDECTSum=0;
			 dblCRCTSum=0;
			 dblJanSum =0;
		}else{ 
			 dblJanSum = dblJanSum + gcds_data01.namevalue(i,"DETOT");
			 gcds_data01.namevalue(i,"JANAMT") = dblJanSum;
		}
	}


     //alert("dblDEATSum_TOT::"+dblDEATSum_TOT);
     //2007.05.19 정영식 누계의 총합계 추가
   	 gcgd_disp01.DataID = "gcds_data01";
	 gcds_data01.Addrow();
	 gcds_data01.namevalue(gcds_data01.rowposition,"SSDAT") = "총합계"
	 gcds_data01.namevalue(gcds_data01.rowposition,"DETOT") = dblDEATSum_TOT;
	 gcds_data01.namevalue(gcds_data01.rowposition,"CRTOT") = dblCRATSum_TOT;
	 gcds_data01.namevalue(gcds_data01.rowposition,"JANAMT") = dblJanSum_TOT;

	
}

/******************************************************************************
	Description : 출력 - Header Set
******************************************************************************/
function ln_PrintHeader() {
		if(gcds_temp01.countrow<1){

			var s_temp="GUBUN:STRING,FSREFVAL:STRING,COSTNM:STRING,ATCODE:STRING,ATKORNAM:STRING," 
					  + "PRTSEQ:STRING,SSDAT:STRING,SSNBR:STRING,FSSEQ:STRING,"
					  + "DETOT:DECIMAL,CRTOT:DECIMAL,JANAMT:DECMAL,REMARK:STRING,"
					  + "VEND_CD:STRING,VEND_NM:STRING,"
					  + "KISU1:STRING,CURDT:STRING,CURTM:STRING";
		    gcds_temp01.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : 원가팝업
  parameter   : 
******************************************************************************/
function ln_Popup(p){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

    arrParam[0]="0030";//원가코드
	arrParam[1]="";

    if(p=="fr"){
		if(txt_costnm_fr.value==""){
			 arrParam[2]="";
		}else{
			 arrParam[2]=txt_costnm_fr.value;
		}

		if(txt_costcd_fr.value==""){
			 arrParam[3]="";
		}else{
			 arrParam[3]=txt_costcd_fr.value;
		}
	}else if(p=="to"){
		if(txt_costnm_to.value==""){
			 arrParam[2]="";
		}else{
			 arrParam[2]=txt_costnm_to.value;
		}
		if(txt_costcd_to.value==""){
			 arrParam[3]="";
		}else{
			 arrParam[3]=txt_costcd_to.value;
		}
	}

	strURL =  "./commdtil_cost_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		if(p=="fr"){
			txt_costcd_fr.value =arrResult[0];
			txt_costnm_fr.value = arrResult[1];
			txt_costcd_to.value = arrResult[0];
			txt_costnm_to.value = arrResult[1];
		}else if(p=="to"){
			txt_costcd_to.value =arrResult[0];
			txt_costnm_to.value = arrResult[1];
		}
	}else{
    if(p=="fr"){
			txt_costcd_fr.value ="";
			txt_costnm_fr.value ="";
			txt_costcd_to.value = "";
			txt_costnm_to.value = "";
		}else if(p=="to"){
			txt_costcd_to.value ="";
			txt_costnm_to.value ="";
		}
	}
}

/******************************************************************************
	Description : 계정팝업
  parameter   : 
******************************************************************************/
function ln_Popup_Atcode(p){
		var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./actcode_popup_cost.jsp";
	arrParam[0]="ATUSEYN";
	strPos = "dialogWidth:495px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if(arrResult != null) {
		 arrParam = arrResult.split(";");
		 if(p=="fr") {
				txt_atcode_fr.value = arrParam[0];
				txt_atkornam_fr.value = arrParam[1];
				txt_atcode_to.value = arrParam[0];
				txt_atkornam_to.value = arrParam[1];
		 }else if(p=="to"){
				txt_atcode_to.value = arrParam[0];
				txt_atkornam_to.value = arrParam[1];
		 }
	}else{
		 if(p=="fr") {
				txt_atcode_fr.value = "";
				txt_atkornam_fr.value = "";
				txt_atcode_to.value = "";
				txt_atkornam_to.value = "";
		 }else if(p=="to"){
				txt_atcode_to.text = "";
				txt_atkornam_to.value = "";					
		 }
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- 조회  -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr	value="-FSREFVAL+PRTSEQ+SSDAT+SSNBR+FSSEQ">
</object></comment><script>__ws__(__NSID__);</script> 

<!--지점  -->
<comment id="__NSID__"><object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!--레포트  -->
<comment id="__NSID__"><object  id=gcds_temp01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
    ln_Data_Reset("00"); //데이타 재설정

	}
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp01" event="OnDblClick()">
	var row = gcds_data01.rowposition;
  //alert("row::"+row);

	var p_fcod = gcds_data01.namevalue(row,"FDCODE");
	var p_fsdt = gcds_data01.namevalue(row,"FSDAT");
	var p_fnbr = gcds_data01.namevalue(row,"FSNBR");
	//alert("p_fcod::"+p_fcod);
	ln_Popup2(p_fcod,p_fsdt,p_fnbr);	//전표 Popup
</script>




<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a100002_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif" width="685" align="right" >&nbsp;
			<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print()">
			<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query()">
		
		</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!------------------------ ----------------------->
<table cellpadding="0" cellspacing="0" border="0" >
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:3px;width:877px;border:0 solid #708090;">
			<tr>
				<td class="tab15" style="height:30px;width:80px;" bgcolor="#eeeeee" align =center>지점코드</td>
				<td class="tab18" style="width:190px"><nobr>
					<comment id="__NSID__"><object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;">
						<param name=ComboDataID			value="gcds_fdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort				    value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				
				<td class="tab18" width="80px" bgcolor="#eeeeee" align =center>기&nbsp;&nbsp;&nbsp;간</td>
				<td class="tab18" style="height:30px;width:360px;" >&nbsp;<nobr>
					<comment id="__NSID__"><object  id=gcem_datefr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:-3px;top:3px; width:70px; height:20px;" class="txtbox">
							<param name=Alignment	    value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable		    value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				  <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_datefr', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
					~&nbsp;
					<comment id="__NSID__"><object  id=gcem_dateto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative;left:-1px;top:3px; width:70px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_dateto', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
				</td>
				
			</tr>
			<tr>
        <td class="tab17" style="height:25px;width:80px;" bgcolor="#eeeeee" align =center>계&nbsp;&nbsp;&nbsp;정</td>
				<td class="tab19" width="690px" colspan=7>
				  <nobr>
					<input id="txt_atkornam_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Atcode('fr');">
					<input id="txt_atcode_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
					&nbsp;&nbsp;&nbsp;~&nbsp;
					<input id="txt_atkornam_to" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Atcode('to');">
					<input id="txt_atcode_to" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
					</nobr>
				</td>
			</tr>
			<tr>
        <td class="tab17" style="height:25px;width:80px;" bgcolor="#eeeeee" align =center>원&nbsp;&nbsp;&nbsp;가</td>
				<td class="tab19" width="690px" colspan=5>
				  <nobr>
					<input id="txt_costnm_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="원가코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup('fr');">
					<input id="txt_costcd_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
					&nbsp;&nbsp;&nbsp;~&nbsp;
					<input id="txt_costnm_to" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="원가코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup('to');">
					<input id="txt_costcd_to" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
					</nobr>
				</td>
			</tr>
		</table>
	</td>
	</tr>
	<tr><td height="2px" colspan =2></td></tr>
	<tr>
		<td>  

			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:877px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  
						style="position:relative;left:3px;width:875px; height:400px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data01">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<param name=ColSizing     value="true">
              <param name="Editable"    value="false">
							<PARAM NAME="Format"			VALUE="  
							  <FC> Name='원가코드'	ID=FSREFVAL HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center sort=false show=false</FC>
								<FC> Name='원가명'	  ID=COSTNM   HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=left sort=false show=TRUE suppress=2 </FC>
								<FC> Name='계정코드'	ID=ATCODE   HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center sort=false show=false</FC>
								<FC> Name='계정과목'	ID=ATKORNAM HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=left sort=false suppress=1</FC>
								<FC> Name='전표일자'	ID=SSDAT    HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=center sort=false</FC>
								<FC> Name='번호'	    ID=SSNBR    HeadAlign=Center HeadBgColor=#B9D4DC Width=47  align=left sort=false</FC>
								<C> Name='순서'   	ID=FSSEQ    HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=left sort=false show=false</C>
								<C> Name='차변'	    ID=DETOT    HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=right color =#0000FF</C>
								<C> Name='대변'	    ID=CRTOT    HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=right color =#FF0000</C>
                <C> Name='잔액'	    ID=JANAMT   HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=right</C>
								<C> Name='적요'	    ID=REMARK   HeadAlign=Center HeadBgColor=#B9D4DC Width=285 align=left sort=false</C>
								<C> Name='거래처코드'	ID=VEND_CD   HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=left sort=false</C>
								<C> Name='거래처명'	  ID=VEND_NM   HeadAlign=Center HeadBgColor=#B9D4DC Width=150 align=left sort=false</C>
								<C> Name='지점'	    ID=FDCODE    HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=center show=false</FC>
								<C> Name='전표일자'	ID=FSDAT    HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=center show=false</FC>
								<C> Name='번호'	    ID=FSNBR    HeadAlign=Center HeadBgColor=#B9D4DC Width=47  align=left show=false</FC>
							">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;">조회건수 :</font>
					</fieldset>
			</td>
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

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<!-- <param name="MasterDataID"			value="gcds_temp01"> -->
	<param name="DetailDataID"			value="gcds_temp01">
	<param name="PaperSize"					value="A4">
	<!-- <param name="fixpapersize"			value="true">
	<param name="printMargine"			value="false"> -->
	<param name="LandScape"					value="true">
	<param name="PrintSetupDlgFlag" value="true">
	<param name="SuppressColumns"   value="2:pageskip,COSTNM;1:ATKORNAM">
	<param name="Format"						value="
<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=228 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1042 ,top=21 ,right=1879 ,bottom=98 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1032 ,top=11 ,right=1868 ,bottom=87 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='KISU1', left=1013, top=124, right=1892, bottom=175, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='원가별 계정별원장' ,left=1037 ,top=19 ,right=1860 ,bottom=79 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=180 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=93 ,right=2807 ,bottom=93 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='전표번호' ,left=873 ,top=114 ,right=1114 ,bottom=161 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='일자' ,left=609 ,top=114 ,right=849 ,bottom=161 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=71 ,top=180 ,right=2807 ,bottom=180 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='COSTNM', left=79, top=40, right=770, bottom=82, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='차변' ,left=1138 ,top=119 ,right=1434 ,bottom=161 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대변' ,left=1450 ,top=119 ,right=1749 ,bottom=161 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='잔액' ,left=1773 ,top=116 ,right=2080 ,bottom=161 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='적요' ,left=2117 ,top=116 ,right=2807 ,bottom=161 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계정과목' ,left=79 ,top=116 ,right=585 ,bottom=161 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=55 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='JANAMT', left=1773, top=8, right=2080, bottom=50, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=2117, top=8, right=2807, bottom=50, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=609 ,top=56 ,right=2080 ,bottom=56 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=77 ,top=56 ,right=609 ,bottom=56 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=1 </L>
	<C>id='CRTOT', left=1450, top=8, right=1749, bottom=50, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SSDAT', left=609, top=8, right=849, bottom=50, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DETOT', left=1138, top=8, right=1431, bottom=50, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SSNBR', left=873, top=8, right=1114, bottom=50, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATKORNAM', left=79, top=8, right=585, bottom=50, align='left', supplevel=1, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=1857 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2418 ,top=3 ,right=2797 ,bottom=85</I>
	<L> left=71 ,top=0 ,right=2805 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p / #t' ,left=1244 ,top=53 ,right=1667 ,bottom=95 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURTM', left=476, top=13, right=876, bottom=56, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CURDT', left=79, top=13, right=479, bottom=56, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 