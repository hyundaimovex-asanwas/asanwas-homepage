<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:   자금관리 - 자금신청현황
+ 프로그램 ID	:   A700013.html
+ 기 능 정 의	:   조회화면이다.
+ 작   성  자 :   
+ 서 블 릿 명	:	
------------------------------------------------------------------------------>

<html>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>자금신청현황</title> 


<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">

</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_date3 = gcurdate.substring(0,4);
var gs_date4 = gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();
	ln_DispChk(0);
	if (gs_userid=="ACCOUNT"){
		gs_userid="1990046";
		gs_fdcode = '02';
		gs_deptcd= 'C260';
		gs_deptnm='회계팀';
		gs_cocode='02';
	}
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(s){
	switch(s) {
		case("01"):
			var str1  = gclx_sfdcode1.BindColVal;				//지점코드
			var str2  = gclx_cadeptcd.BindColVal;				//부서코드  
			var str3  = fn_trim(gcem_sgetdatefr1.text);	//신청일자FROM
			var str4  = fn_trim(gcem_sgetdateto1.text);	//신청일자TO
			var str5  = gcem_atcode_fr01.text;					//항목

			gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070013_s1"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5;
			gcds_data1.Reset();
			break;
		case("02"):
			var str1  = gclx_sfdcode2.BindColVal;				//지점코드
			var str2  = gclx_cadeptcd2.BindColVal;			//부서코드  
			var str3  = fn_trim(gcem_sgetdatefr2.text);	//신청년월
			var str4  = gclx_week1.bindcolval;					//주간구분
			var str5  = gclx_remcd2.BindColVal;					//항목

			gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070013_s2?v_str1="+str1
											  + "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5;
			gcds_data2.Reset();
			break;
		case("03"):
			var str1  = gclx_sfdcode3.BindColVal;				//지점코드
			var str2  = gclx_cadeptcd3.BindColVal;			//부서코드
			var str3  = gcem_atcode_to01.text;					//항목
			var str4  = fn_trim(gcem_sgetdatefr3.text);	//신청년월fr
			var str5  = fn_trim(gcem_sgetdateto3.text);	//신청년월to

			gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070013_s3?v_str1="+str1
											+"&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5;
			gcds_data3.Reset();
			break;
	}
}

/******************************************************************************
	Description : 필수항목 입력체크 
******************************************************************************/
function ln_Chk() {
	
}

/******************************************************************************
	Description : Header 설정
******************************************************************************/
function ln_SetDataHeader(){

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
	alert("준비중입니다.");
  /*if(e=="01") {
		if(gcds_print1.countrow<1) {
			alert("출력할 정보가 없습니다.");
		}else{
			gcrp_print1.preview();
		}
	}*/
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(e){
	if(e=="01"){
		if (gcds_data1.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_disp01.RunExcel('일일신청현황');
	}else if(e=="02"){
		if (gcds_data2.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_disp02.RunExcel('주간신청현황');
	}else if(e=="03"){
		if (gcds_data3.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_disp03.RunExcel('월간신청현황');
	}
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
	gcem_sgetdatefr1.text = gs_date2+"01";
	gcem_sgetdateto1.text = gs_date;

	gcem_sgetdatefr2.text = gs_date;
	gcem_sgetdatefr3.text = gs_date;
	gcem_sgetdateto3.text = gs_date;

	gclx_week1.index=0;
	
	gcds_sfdcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_sfdcode1.Reset();

	gcds_sfdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_sfdcode2.Reset();

	gcds_sfdcode3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_sfdcode3.Reset();

	gcds_dept1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_hcdept_s2?v_str1=";
	gcds_dept1.Reset();

	gcds_dept2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_hcdept_s2?v_str1=";
	gcds_dept2.Reset();

	gcds_dept3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_hcdept_s2?v_str1=";
	gcds_dept3.Reset();

//	gcds_com.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0054";
//    gcds_com.Reset();

	gcds_com2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0054";
    gcds_com2.Reset();

	//gcds_com3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0054";
    //gcds_com3.Reset();

    gcds_com00.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0054";
    gcds_com00.Reset();

	gcds_dept00.DataID =  "/servlet/Person.h010003_s1?v_str1=&v_str2=";
	gcds_dept00.Reset();
}

/******************************************************************************
	Description : 탭구분
	prameter    :
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp1","div_disp2","div_disp3");
	for(var i=0;i<=2;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
}


/***********************************************************************************************
	Description : 계정코드 찾기
	parameter   : p2===> fr, to- 계정코드 : apr- 충당금 : up - 상위계정 : down - 계정코드
**********************************************************************************************/
function ln_Popup(p2,p){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./actcode_popup.jsp";
	arrParam[0]="ATUSEYN";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if(p=="01"){
		if (arrResult != null) {
				arrParam = arrResult.split(";");
			 if(p2=="fr") {
					gcem_atcode_fr01.text = arrParam[0];
					txt_atkornam_fr01.value = arrParam[1];

					gcem_atcode_to01.text = arrParam[0];
					txt_atkornam_to01.value = arrParam[1];
				//	ln_CurActcode();	//현재계정 조회
			 }else if(p2=="to"){
					gcem_atcode_to01.text = arrParam[0];
					txt_atkornam_to01.value = arrParam[1];
				//	ln_CurActcode();	//현재계정 조회
			 }
		} else {
			if(p2=="fr") {
				gcem_atcode_fr01.text = "";
				txt_atkornam_fr01.value ="";
			}else if(p2=="to"){
				gcem_atcode_to01.text = "";
				txt_atkornam_to01.value = "";
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

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_sfdcode1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_sfdcode3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_print1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><OBJECT id="gcds_dept1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><OBJECT id="gcds_dept2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_dept3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>
<!--
<comment id="__NSID__"><object  id="gcds_com" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>
-->
<comment id="__NSID__"><object  id="gcds_com2" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>
<!--
<comment id="__NSID__"><object  id="gcds_com3" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>
-->
<comment id="__NSID__"><object  id="gcds_com00" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id="gcds_dept00" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
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

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt02.innerText = "조회건수 : " + row + " 건";
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
	}
</script>

<script language="javascript" for="gcds_data3" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data3" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt03.innerText = "조회건수 : " + row + " 건";
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
	}
</script>

<script language="javascript" for="gcds_sfdcode1" event="onloadCompleted(row,colid)">
	gcds_sfdcode1.InsertRow(1);
	gcds_sfdcode1.NameValue(1,"FDCODE")="";
	gcds_sfdcode1.NameValue(1,"FDNAME")="전체";
	gclx_sfdcode1.BindColVal    =  gs_fdcode;
</script>

<script language="javascript" for="gcds_sfdcode2" event="onloadCompleted(row,colid)">
	gcds_sfdcode2.InsertRow(1);
	gcds_sfdcode2.NameValue(1,"FDCODE")="";
	gcds_sfdcode2.NameValue(1,"FDNAME")="전체";
	gclx_sfdcode2.BindColVal    =  gs_fdcode;
</script>

<script language="javascript" for="gcds_sfdcode3" event="onloadCompleted(row,colid)">
	gcds_sfdcode3.InsertRow(1);
	gcds_sfdcode3.NameValue(1,"FDCODE")="";
	gcds_sfdcode3.NameValue(1,"FDNAME")="전체";
	gclx_sfdcode3.BindColVal    =  gs_fdcode;
</script>

<script language="javascript" for="gcds_dept1" event="onloadCompleted(row,colid)">
window.status="조회가 완료 되었습니다.";     
	gcds_dept1.InsertRow(1);
	gcds_dept1.NameValue(1,"DEPTCD")="";
	gcds_dept1.NameValue(1,"DEPTNM")="전체";
	gclx_cadeptcd.BindColVal    =  gs_deptcd;
</script>

<script language="javascript" for="gcds_dept2" event="onloadCompleted(row,colid)">
window.status="조회가 완료 되었습니다.";       
	gcds_dept2.InsertRow(1);
	gcds_dept2.NameValue(1,"DEPTCD")="";
	gcds_dept2.NameValue(1,"DEPTNM")="전체";
	gclx_cadeptcd2.BindColVal   =  gs_deptcd;
</script>

<script language="javascript" for="gcds_dept3" event="onloadCompleted(row,colid)">
window.status="조회가 완료 되었습니다.";       
	gcds_dept3.InsertRow(1);
	gcds_dept3.NameValue(1,"DEPTCD")="";
	gcds_dept3.NameValue(1,"DEPTNM")="전체";
	gclx_cadeptcd3.BindColVal   =  gs_deptcd;
</script>
<!--
<script language="javascript" for="gcds_com" event="onloadCompleted(row,colid)">
window.status="조회가 완료 되었습니다.";       
	gcds_com.InsertRow(1);
	gcds_com.NameValue(1,"CDCODE")="";
	gcds_com.NameValue(1,"CDNAM")="전체";
	gclx_remcd.index=0;
</script>
--->
<script language="javascript" for="gcds_com2" event="onloadCompleted(row,colid)">
window.status="조회가 완료 되었습니다.";       
	gcds_com2.InsertRow(1);
	gcds_com2.NameValue(1,"CDCODE")="";
	gcds_com2.NameValue(1,"CDNAM")="전체";
	gclx_remcd2.index=0;
</script>
<!--
<script language="javascript" for="gcds_com3" event="onloadCompleted(row,colid)">
window.status="조회가 완료 되었습니다.";       
	gcds_com3.InsertRow(1);
	gcds_com3.NameValue(1,"CDCODE")="";
	gcds_com3.NameValue(1,"CDNAM")="전체";
	gclx_remcd3.index=0;
</script>--->

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1)); 
</script>

</head>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
 
<table width="869" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/a070013_head.gif">
	</td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;
	</td>
  </tr>
  <tr> 
    <td colspan="2" align=left style="position:relative;left:5px">
      <table width="0" cellpadding="1" cellspacing="0" border="0" style="position:relative;top:4px;left:-6px;">
		<tr> 
			<td width="0" align=left><nobr>
				<comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;">
				<PARAM NAME="BackColor"					VALUE="#cccccc">
   				<PARAM NAME="titleHeight"				VALUE="20px">
				<PARAM NAME="DisableBackColor"			VALUE="#eeeeee">
				<PARAM NAME="Format"					VALUE="
						<T>divid=div_1		title=일일신청현황</T>
						<T>divid=div_2		title=주간신청현황</T>
						<T>divid=div_3		title=월간신청현황</T>
				">
				</object></comment><script>__ws__(__NSID__);</script></nobr>
			</td>
        </tr>
      </table>
	</td>
  </tr>
  <tr> 
    <td COLSPAN="2">
		
<!-- 일일신청현황 ===========================================================================================================-->
<!--<fieldset id=field1 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >

	<tr><td height="3px"><td>
	</tr>
	<tr >
		<td colspan=8 align=left style="position:relative;left:0px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab21" style="width:70px" bgcolor="#eeeeee">&nbsp;&nbsp;지점구분</td>
					<td class="tab21" style="width:90px"><comment id="__NSID__"><object  id=gclx_sfdcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode1">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab21" style="width:70px" bgcolor="#eeeeee">&nbsp;&nbsp;부서</td>
					<td class="tab22" style="width:120px"><comment id="__NSID__">
						<OBJECT id=gclx_cadeptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=205 style="position:relative;left:6px;top:0px;border-right-width:0px" >
								<param name=ComboDataID			value="gcds_dept1">
								<param name=CBDataColumns		value="DEPTCD,DEPTNM">
								<param name=SearchColumn		value="DEPTNM">
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="DEPTNM^0^205">
								<param name=BindColumn			value="DEPTCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 	
					</td>
					<td align="right" class="tab22" >&nbsp;<nobr>      
						<!-- <img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('01')"> -->
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Excel('01')">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('01')"> 
						</nobr>
					</td>
				</tr>
				<tr>	
					
					<td class="tab12" style="height:25px;width:80px;" bgcolor="#eeeeee">계정코드</td>
				<td class="tab23"  width="250px">&nbsp;<comment id="__NSID__">
					<object  id=gcem_atcode_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:-1px;top:5px;">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:2px;top:1px" align=center onclick="ln_Popup('fr','01');">
					<input id="txt_atkornam_fr01" type="text" class="txtbox"  style= "position:relative;top:-3px;width:130px;height:20px;" maxlength="36"  disabled>
					
				</td>

<!--
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee">항목</td>
					<td class="tab23" style="width:120px"><comment id="__NSID__">
						<OBJECT id=gclx_remcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=110 style="position:relative;left:6px;top:0px;" class="txtbox" >
								<param name=ComboDataID			value="gcds_com">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^110">
								<param name=BindColumn			value="CDCODE">
									</OBJECT></comment><script>__ws__(__NSID__);</script> 	
					</td>--->
					<td class="tab12" style="width:70px;"	bgcolor="#eeeeee"><nobr>신청일자</nobr></td>
					<td style="width:210px">
						<comment id="__NSID__"><object id=gcem_sgetdatefr1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="YYYY/MM/DD">
						<param name=PromptChar		value="_">
						<param name=Enable			value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdatefr1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~
					<comment id="__NSID__"><object id=gcem_sgetdateto1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="YYYY/MM/DD">
						<param name=PromptChar		value="_">
						<param name=Enable			value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_sgetdateto2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</td>



					<td>
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
							<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:-1px" viewastext>
								<PARAM NAME="DataID"				VALUE="gcds_data1">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"			VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"				VALUE="  
								<C> Name='No.'				ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
								<C> Name='신청일자'		ID=ACDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center  SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
								<C> Name='계정과목'		ID=ATKORNAM	HeadAlign=Center HeadBgColor=#B9D4DC Width=160	align=left		SumText='계'	SumBgColor='#C3D0DB'</C>
								<C> Name='신청금액'		ID=PLAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='지급기준'		ID=AMTDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center	SumText=''		SumBgColor='#C3D0DB' EditStyle='combo' Data='C:현금,B:어음'</C>
								<C> Name='결재일자'		ID=EXDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center  SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
								<C> Name='적요'				ID=REMARK		HeadAlign=left	 HeadBgColor=#B9D4DC Width=250	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:-1px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>  
					</td>
				<td>
			</table>			
		</td> 
	</tr> 
</table> 

<!-- 주간신청현황 ===========================================================================================================-->
<!--<fieldset id=field1 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>-->
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="display:none">

	<tr><td height="3px"><td>
	</tr>
	<tr >
		<td colspan=8 align=left style="position:relative;left:0px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab21" style="width:70px" bgcolor="#eeeeee">&nbsp;&nbsp;지점구분</td>
					<td class="tab21" style="width:90px"><comment id="__NSID__"><object  id=gclx_sfdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode2">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab21" style="width:70px" bgcolor="#eeeeee">&nbsp;&nbsp;부서</td>
					<td class="tab22" style="width:220px"  colspan="3"><comment id="__NSID__">
						<OBJECT id=gclx_cadeptcd2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=205 style="position:relative;left:6px;top:0px;border-right-width:0px" >
								<param name=ComboDataID			value="gcds_dept2">
								<param name=CBDataColumns		value="DEPTCD,DEPTNM">
								<param name=SearchColumn		value="DEPTNM">
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="DEPTNM^0^205">
								<param name=BindColumn			value="DEPTCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 	
					</td>
					<td align="right" class="tab22">&nbsp;<nobr>      
						<!-- <img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('02')"> -->
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Excel('02')">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('02')"> 
						</nobr>
					</td>
				</tr>
				<tr>			
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee">항목</td>
					<td class="tab23" style="width:120px;height:26px"><comment id="__NSID__">
						<OBJECT id=gclx_remcd2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=110 style="position:relative;left:6px;top:0px;" class="txtbox" >
							<param name=ComboDataID			value="gcds_com2">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^110">
							<param name=BindColumn			value="CDCODE">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 	
					</td>
					<td class="tab12" style="width:70px;"	bgcolor="#eeeeee"><nobr>신청년월</nobr></td>
					<td style="width:70px">
						<comment id="__NSID__"><object id=gcem_sgetdatefr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px; width:55px; height:20px;" class="txtbox">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="YYYY/MM">
						<param name=PromptChar		value="_">
						<param name=Enable			value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdatefr1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;"> -->
					<td class="tab12" style="width:70px;border-left-width:1px" bgcolor="#eeeeee"><nobr>주간구분</nobr></td>
					<td style="width:300px">
						<comment id="__NSID__"><object  id=gclx_week1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:60px;height:110px;">
							<param name=CBDATA            value="^전체,1^1주,2^2주,3^3주,4^4주,5^5주">
							<param name=CBDataColumns			value="WEEKCD,WEEKNAME">
							<param name=SearchColumn			value="WEEKNAME">
							<param name=Sort							value="false">
							<param name=ListExprFormat		value="WEEKNAME^0^60">
							<param name=BindColumn				value="WEEKCD">
						</object></comment><script>__ws__(__NSID__);</script>
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
							<OBJECT id=gcgd_disp02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:-1px" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_data2">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"			VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"			VALUE="  
								<C> Name='No.'					ID={CURROW}	HeadAlign=Center	HeadBgColor=#B9D4DC Width=40	align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
								<C> Name='주간구분'			ID=ACWEEK		HeadAlign=Center	HeadBgColor=#B9D4DC Width=60	align=center	SumText=''		SumBgColor='#C3D0DB' EditStyle='combo' Data='1:1주,2:2주,3:3주,4:4주,5:5주'</C>
								<C> Name='부서'					ID=DEPTCD		HeadAlign=Center	HeadBgColor=#B9D4DC Width=150	align=left		SumText='계'	SumBgColor='#C3D0DB' EditStyle='lookup' Data='gcds_dept00:DEPTCD:DEPTNM' Edit=none</C>
								<C> Name='계정과목'			ID=ATKORNAM	HeadAlign=Center	HeadBgColor=#B9D4DC Width=150	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='신청금액'			ID=PLAMT		HeadAlign=Center	HeadBgColor=#B9D4DC Width=100	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='지급기준'			ID=AMTDIV		HeadAlign=Center	HeadBgColor=#B9D4DC Width=60	align=center	SumText=''		SumBgColor='#C3D0DB' EditStyle='combo' Data='C:현금,B:어음'</C>
								<C> Name='결재일자'			ID=EXDATE		HeadAlign=Center	HeadBgColor=#B9D4DC Width=100	align=center  SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
								<C> Name='적요'					ID=REMARK		HeadAlign=Left		HeadBgColor=#B9D4DC Width=190	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:-1px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt02" style="position:relative;top:4px;"></font>
						</fieldset>  
					</td>
				<td>
			</table>			
		</td> 
	</tr> 
</table>


<!-- 월간신청현황 ===========================================================================================================-->
<!--<fieldset id=field1 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>-->
<table id="div_disp3" cellpadding="0" cellspacing="0" border="0" style="display:none">

	<tr><td height="3px"><td>
	</tr>
	<tr >
		<td colspan=8 align=left style="position:relative;left:0px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab21" style="width:70px" bgcolor="#eeeeee">&nbsp;&nbsp;지점구분</td>
					<td class="tab21" style="width:90px"><comment id="__NSID__"><object  id=gclx_sfdcode3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode3">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab21" style="width:70px" bgcolor="#eeeeee">&nbsp;&nbsp;부서</td>
					<td class="tab22" style="width:120px"><comment id="__NSID__">
						<OBJECT id=gclx_cadeptcd3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=205 style="position:relative;left:6px;top:0px;border-right-width:0px" >
								<param name=ComboDataID			value="gcds_dept3">
								<param name=CBDataColumns		value="DEPTCD,DEPTNM">
								<param name=SearchColumn		value="DEPTNM">
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="DEPTNM^0^205">
								<param name=BindColumn			value="DEPTCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 	
					</td>
					<td align="right" class="tab22" >&nbsp;<nobr>      
						<!-- <img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('03')"> -->
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Excel('03')">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('03')"> 
						</nobr>
					</td>
				</tr>
				<tr>		
				<td class="tab12" style="height:25px;width:80px;" bgcolor="#eeeeee">계정코드</td>
				<td class="tab23"  width="250px">&nbsp;<comment id="__NSID__">
					<object  id=gcem_atcode_to01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:-1px;top:5px;">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:2px;top:1px" align=center onclick="ln_Popup('to','01');">
					<input id="txt_atkornam_to01" type="text" class="txtbox"  style= "position:relative;top:-3px;width:130px;height:20px;" maxlength="36"  disabled>
					
				</td>
				<!--
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee">항목</td>
					<td class="tab23" style="width:120px;height:26px"><comment id="__NSID__">
						<OBJECT id=gclx_remcd3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=110 style="position:relative;left:6px;top:0px;" class="txtbox" >
							<param name=ComboDataID			value="gcds_com3">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^110">
							<param name=BindColumn			value="CDCODE">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 	
					</td>--->
					<td class="tab12" style="width:70px;"	bgcolor="#eeeeee"><nobr>신청년월</nobr></td>
					<td style="width:210px"><comment id="__NSID__">
						<object id=gcem_sgetdatefr3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:55px; height:20px;" class="txtbox">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="YYYY/MM">
						<param name=PromptChar	value="_">
						<param name=Enable			value="true">
					</object></comment><script>__ws__(__NSID__);</script>&nbsp;~
					<comment id="__NSID__">
						<object id=gcem_sgetdateto3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:55px; height:20px;" class="txtbox">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="YYYY/MM">
						<param name=PromptChar	value="_">
						<param name=Enable			value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					</td>

					
					<td>
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
							<OBJECT id=gcgd_disp03 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:-1px" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_data3">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"			VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"			VALUE="  
								<C> Name='No.'				ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='신청년월'		ID=ACYYMM		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center  SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX'</C>
								<C> Name='부서'				ID=DEPTCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left		SumText='계'	SumBgColor='#C3D0DB' EditStyle='lookup' Data='gcds_dept00:DEPTCD:DEPTNM' Edit=none</C>
								<C> Name='계정과목'		ID=ATKORNAM	HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='신청금액'		ID=PLAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='지급기준'		ID=AMTDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center	SumText=''		SumBgColor='#C3D0DB' EditStyle='combo' Data='C:현금,B:어음'</C>
								<C> Name='결재일자'		ID=EXDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center  SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
								<C> Name='적요'				ID=REMARK		HeadAlign=left	 HeadBgColor=#B9D4DC Width=190	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:-1px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt03" style="position:relative;top:4px;"></font>
						</fieldset>  
					</td>
				<td>
			</table>			
		</td> 
	</tr> 
</table>
<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"			value="A4">
	<param name="LandScape"			value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="SuppressColumns"	value="1:pageskip,ATCODE;">
	<param name="Format"			value="
	">
</object></comment><script>__ws__(__NSID__);</script> 


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 