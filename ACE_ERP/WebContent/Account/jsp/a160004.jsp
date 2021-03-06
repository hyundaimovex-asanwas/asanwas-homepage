<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 소득원천세지급현황
+ 프로그램 ID	: A160004.html
+ 기 능 정 의	: 조회|출력
+ 변 경 이 력	: 
+ 수 정 내 용 : 
+ 수 정 이 력	: 
+ 수 정 이 력	: 
+ 수 정 이 력	: 
+ 수 정 이 력	: 
+ 서 블 릿 명	: a160004_s1, 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>소득원천세지급현황</title>

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
var tab_gb=1;
var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
var gs_date2 = gcurdate.substr(0,4) +"/"+ gcurdate.substr(5,2) +"/"+ gcurdate.substr(8,2);
var gs_date3 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;

var gs_jigub = gs_jigub;
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	gcds_select_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1120"; 
	gcds_select_ec01az.Reset();

	gcds_select_ec02az.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1120"; 
	gcds_select_ec02az.Reset();

	gcem_yyyymm41.text = gs_date3; 
	gcem_yyyymm42.text = gs_date3;

	gs_jigub = '1';
	//alert(gs_jigub);

	gclx_select_jigub4.bindcolval = gs_jigub;

}

/******************************************************************************
	Description : 탭 설정
******************************************************************************/
function ln_Tabset(index){

	var div_cm=new Array("div_regular","div_contract");

	for(var i=0;i<=1;i++){
	 
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}	else 	{
			eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	var str1 = fn_trim(gcem_yyyymm41.text);									//지급년월
	var str2 = fn_trim(gclx_select_jigub4.BindColVal);      //지급구분
	var str3 = fn_trim(gcem_yyyymm42.text);	
	var str4 = fn_trim(gclx_select_jigub5.BindColVal);

  //alert(gclx_select_jigub4.bindcolval);

  if(tab_gb==1){
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160004_s1?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2;
							
	gcds_data.Reset(); //그리드

	}else if(tab_gb==2){
	gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160004_s2?"
									 + "v_str3=" + str3
									 + "&v_str4=" + str4;
							
	gcds_data2.Reset(); //그리드

	}
}


/******************************************************************************
	Description : 급여지급현황 총인원보고서(Fheader 부분)
******************************************************************************/
function ln_Report_4_1(e,n){ 
	var str1 = fn_trim(gcem_yyyymm41.text);								//지급년월							//지급년월
	var str2 = fn_trim(gclx_select_jigub4.BindColVal);		//지급구분

	gcds_report0.ClearAll();

	if (str2 == e) {
		gcds_report0.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160004_s3"+n+"?"
										 + "v_str1="	+ str1
										 + "&v_str2=" + str2
										 + "&v_str3=" + gs_date;
	//	prompt('gcds_report0',gcds_report0.DataID);
		gcds_report0.Reset();
	}
	
}

/******************************************************************************
	Description : 급여지급현황 상세보고서 (Detail 부분)
******************************************************************************/
function ln_Report_4_2(e,n){ 
	var str1 = fn_trim(gcem_yyyymm41.text);								//지급년월
	var str2 = fn_trim(gclx_select_jigub4.BindColVal);    //지급구분
 
	gcds_report1.ClearAll();

	
	if (str2 == e) {
		gcds_report1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160004_s4"+n+"?"
										 + "v_str1="	+ str1
										 + "&v_str2=" + str2;

		//prompt('gcds_report1',gcds_report1.DataID );
		gcds_report1.Reset(); 
		gcds_report1.rowposition=1;
	}
	
}

/******************************************************************************
	Description : 급여지급현황 본사근무자보고서(Header 부분)
******************************************************************************/
function ln_Report_4_3(e,n){ 
	var str1 = fn_trim(gcem_yyyymm41.text);										//지급년월
	var str2 = fn_trim(gclx_select_jigub4.BindColVal);        //지급구분

	gcds_report2.ClearAll();

	if (str2 == e) {
	gcds_report2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160004_s5"+n+"?"
									 + "v_str1="	+ str1
									 + "&v_str2=" + str2

  //prompt('gcds_report2',gcds_report2.DataID);
	gcds_report2.Reset(); 
	gcds_report2.rowposition=1;
	}
	
}

/******************************************************************************
	Description : 계약 급여지급현황 총인원보고서(Fheader 부분)
******************************************************************************/
function ln_Report_5_1(e,n){ 
	var str1 = fn_trim(gcem_yyyymm42.text);								//지급년월
	var str2 = fn_trim(gclx_select_jigub5.BindColVal);		//지급구분


	gcds_report3.ClearAll();
		gcds_report3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160004_s6"+n+"?"
										 + "v_str1="	+ str1
										 + "&v_str2=" + str2
										 + "&v_str3=" + gs_date;
		//prompt('gcds_report3',gcds_report3.DataID);
		gcds_report3.Reset();
	
}

/******************************************************************************
	Description : 계약 급여지급현황 상세보고서 (Detail 부분)
******************************************************************************/
function ln_Report_5_2(e,n){ 
	var str1 = fn_trim(gcem_yyyymm42.text);								//지급년월
	var str2 = fn_trim(gclx_select_jigub5.BindColVal);    //지급구분
 
	gcds_report4.ClearAll();
	gcds_report4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160004_s7"+n+"?"
										 + "v_str1="	+ str1
										 + "&v_str2=" + str2;

		//prompt('gcds_report4',gcds_report4.DataID );
		gcds_report4.Reset(); 
		gcds_report4.rowposition=1;
	
}


/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){


	if (tab_gb==1 && fn_trim(gclx_select_jigub4.BindColVal) == '1') {	//급여 지급현황[정기]
		if (gcds_data.countrow<1) {
			alert("출력하실 정보가 없습니다");
		} else {
			var str1=fn_trim(gcem_yyyymm41.Text);
			if (str1.length != 6) {
				alert("지급년월 입력란이 기준년월입니다.\n입력해주세요");
			}else{
				var v_pay01 = "1";
				var v_pay02 = "";
				ln_Report_4_1(v_pay01,v_pay02);	
				ln_Report_4_3(v_pay01,v_pay02);
				ln_Report_4_2(v_pay01,v_pay02);
				gcrp_print.preview();
			}
		}
	} else if ((tab_gb==1) && fn_trim(gclx_select_jigub4.BindColVal) == '5'){	//급여 지급현황[상여]			
		if (gcds_data.countrow<1) {
			alert("출력하실 정보가 없습니다");
		} else {
			var str1=fn_trim(gcem_yyyymm41.Text);
			if (str1.length != 6) {
				alert("지급년월 입력란이 기준년월입니다.\n입력해주세요");
			}else{

				var v_pay01 = "5";
				ln_Report_4_1(v_pay01,"3");	
				ln_Report_4_2(v_pay01,"4");
				gcrp_print_2.preview();
			}
		}
	}else if ((tab_gb==2) && fn_trim(gclx_select_jigub5.BindColVal) == 'T'){	//급여 지급현황[계약]			
		if (gcds_data2.countrow<1) {
			alert("출력하실 정보가 없습니다");
		} else {
			var str1=fn_trim(gcem_yyyymm42.text);
			if (str1.length != 6) {
				alert("지급년월 입력란이 기준년월입니다.\n입력해주세요");
			}else{
				var v_pay01 = "1";
				var v_pay02 = "";
				ln_Report_5_1(v_pay01,v_pay02);	
				ln_Report_5_2(v_pay01,v_pay02);
				gcrp_print_3.preview();
			}
		}
	}

}


/*******************************************************************************
  Description : 출력물 TITLE 변경
******************************************************************************/
function ln_Print_title(){
	var strTitle = fn_trim(gclx_select_jigub4.bindcolval);
	var strTitle2 = fn_trim(gclx_select_jigub5.bindcolval);
	var strTitlenm = fn_trim(gclx_select_jigub4.text);
	var strTitlenm2 = fn_trim(gclx_select_jigub5.text);
	//alert("strTitle" + strTitle + "strTitlenm"+strTitlenm);
  if (strTitle==1){
		gcds_report0.namevalue(1,"CTITLE") = "급여";	
	}else if (strTitle==5) {
    gcds_report0.namevalue(1,"CTITLE") = "상여";
	}
}

/*******************************************************************************
  Description : 출력물 TITLE 변경
******************************************************************************/
function ln_Print_title2(){

	var strTitle2 = fn_trim(gclx_select_jigub5.bindcolval);

	var strTitlenm2 = fn_trim(gclx_select_jigub5.text);
	//alert("strTitle" + strTitle + "strTitlenm"+strTitlenm);
if (strTitle2=='T') {
    gcds_report3.namevalue(1,"CTITLE") = "계약직";
	}
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

  if(tab_gb==1){
		gcgd_disp01.GridToExcel("소득원천세지급현황","",2);
	}else if (tab_gb==2){
		gcgd_disp02.GridToExcel("소득원천세지급현황","",2);
	}
}



/******************************************************************************
	Description : 선조회조건
******************************************************************************/
function ln_Before(){

}

/******************************************************************************
	Description : 헤더생성
******************************************************************************/
function ln_SetHeader(){

}
</script>



<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<param name="UseChangeInfo"    value="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<param name="UseChangeInfo"    value="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>



<comment id="__NSID__"><OBJECT id=gcds_select_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 지급구분 정규 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_select_ec02az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 지급구분 계약 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__"><OBJECT id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SortExpr     value="+TREECD">
  <param name=SubsumExpr   value="1:TREECD">
<PARAM NAME="SyncLoad" VALUE="true"><!-- REPORT조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SortExpr     value="+TREECD">
  <param name=SubsumExpr   value="1:TREECD">
<PARAM NAME="SyncLoad" VALUE="true"><!-- 계약 REPORT조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SortExpr     value="+TREECD">
  <param name=SubsumExpr   value="1:TREECD">
<PARAM NAME="SyncLoad" VALUE="true"><!-- REPORT조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">

	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";

	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
		 
</script>


<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">

	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";

	ft_cnt2.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
		 
</script>

<script language="javascript" for="gcds_select_ec01az" event="onloadCompleted(row,colid)">

	//  gclx_select_jigub4.BindColval = "1";

	  gclx_select_jigub4.index=0; //지급구분 정규

	  gcds_select_ec01az.DeleteRow(2);
	  gcds_select_ec01az.DeleteRow(2);
	  gcds_select_ec01az.DeleteRow(2);
	  gcds_select_ec01az.DeleteRow(3);
	  gcds_select_ec01az.DeleteRow(3);
	  gcds_select_ec01az.DeleteRow(3);
	  gcds_select_ec01az.DeleteRow(3);
	  
</script>

<script language="javascript" for="gcds_select_ec02az" event="onloadCompleted(row,colid)">
	  gclx_select_jigub5.index=0; //지급구분 계약

	  gcds_select_ec02az.DeleteRow(1);
	  gcds_select_ec02az.DeleteRow(1);
	  gcds_select_ec02az.DeleteRow(1);
	  gcds_select_ec02az.DeleteRow(1);
	  gcds_select_ec02az.DeleteRow(1);
	  gcds_select_ec02az.DeleteRow(1);
	  gcds_select_ec02az.DeleteRow(1);
	  gcds_select_ec02az.DeleteRow(2);
</script> 

<script language="javascript" for="gcds_report0" event="onloadCompleted(row,colid)">

	ln_Print_title();
	//ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if(gcds_report0.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>

<script language="javascript" for="gcds_report3" event="onloadCompleted(row,colid)">

	ln_Print_title2();

	//ft_cnt2.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if(gcds_report3.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gs_tab event=OnSelChanged(index)>
	ln_Tabset((index-1));

	tab_gb=index;

	// ln_init(tab_gb);

</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	ln_Query();
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert("요청하신 작업이 성공적으로 수행되지 못했습니다.");

	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");

	ln_Query();
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif" ><img src="../img/a160004_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<nobr>	    
			 <img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print()">
			 <img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel()">
			 <img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()"> 
			&nbsp;</nobr>
		</td>
  </tr>

  <tr> 
    <td COLSPAN=2 ALING=LEFT>
		  <table width="0" cellpadding="1" cellspacing="0" border="0">
				<tr> 
					<td width="0" align=RIGHT><NOBR>
					  <comment id="__NSID__"><OBJECT id=gs_tab classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;cursor:hand;">
					  <PARAM NAME="BackColor" VALUE="#cccccc">
					  <PARAM NAME="titleHeight" VALUE="20px">
					  <PARAM NAME="DisableBackColor" VALUE="#eeeeee">
					  <PARAM NAME="Format" VALUE="
					  <T>divid=div_regular  title=정규직</T>                                  
					  <T>divid=div_contract title=계약직</T>                              
					  ">
					</OBJECT></comment><script>__ws__(__NSID__);</script></NOBR>
					</td>
				</tr>
		</table>
	</td>
  </tr>

<tr> 
  <td colspan=2>
  	<div id="div_regular" style="display:block">
		<table width="876" cellpadding="0" cellspacing="0" border="0">
			<tr>
			  <td colspan=8 align=center>
	<table  cellpadding="0" cellspacing="0" border="0" style='width:876px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
		<tr> 
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;지급년월&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0;width:130px solid #708090;padding-top:2px;border-right-width:1px;border-bottom-width:0px;"><nobr>
        <table cellpadding=0 cellspacing=0>
			<tr>
				<td><nobr>&nbsp;
					<comment id="__NSID__"><object id=gcem_yyyymm41 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment			value=0>
						<param name=Border	      value=True>
						<param name=Numeric	      value=false>
						<param name=Format	      value="YYYY/MM">
						<param name=MaxLength     value=6>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr></td>
			</tr>
		</table></nobr></td>	
			<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:0px;" bgcolor="#eeeeee">
				<nobr>&nbsp;지급구분&nbsp;</nobr></td>	 
			<td width="50" style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px;padding-top:2px;"><nobr>
        <table cellpadding=0 cellspacing=0 border=0> 
					<tr>
						<td><nobr>
							<comment id="__NSID__"><object id=gclx_select_jigub4  name="gclx_select_jigub4" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
								<param name=ComboDataID			value=gcds_select_ec01az>
								<param name=CBDataColumns		value="MINORCD^MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=Sort            value="TRUE">
								<param name=SortColumn			value="MINORCD">
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value="MINORCD">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
						</td>
					</tr>
		</table></nobr></td>
		<td width="650"></td>


					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr> 
    <td colspan="2" align=center valign=center> 
      <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:100%;" align=center>
						<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;top:2px;">
							<tr> 
								<td style="width:876" align=center>
									<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01 
										style="width:876px;height:437px;border:1 solid #777777;z-index:2;">
									<PARAM NAME="DataID"				VALUE="gcds_data">
										<PARAM NAME="Editable"			VALUE="True">
										<PARAM NAME="BorderStyle"		VALUE="0">
										<PARAM NAME="Indwidth"			VALUE="0">
										<param name="Fillarea"			VALUE="true">
										<PARAM NAME="SortView"			VALUE="left">
										<PARAM NAME="ColSizing"			VALUE="true">
									  <PARAM NAME="Format"				VALUE="  
								<FC> Name='소속' ID=DEPTNM BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=101 align=left  SumBgColor=#C3D0DB sort=true </FC> 
								<FC> Name='년월' ID=PAYDT BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=center  SumBgColor=#C3D0DB Value={Left(PAYDT,6)}  sort=true MASK='XXXX/XX'</FC> 
								<FC> Name='구분' ID=PAYDIVNM BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=center  SumBgColor=#C3D0DB sort=true  </FC> 
								<FC> Name='직위' ID=MINORNM BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=101 align=center  SumBgColor=#C3D0DB sort=true  </FC> 
								<FC> Name='근무지' ID=TMINORNM BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=101 align=center  SumBgColor=#C3D0DB sort=true  </FC>
								<FC> Name='사번' ID=EMPNO BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center  SumBgColor=#C3D0DB sort=true  </FC> 
								<F> Name='성명' ID=EMPNMK BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=center SumBgColor=#C3D0DB  sort=true </F> 
								<C> Name='급여'		ID=PAYSUM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='식대' ID=BP35000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='차량'			ID=BP24000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C>
								<C> Name='계'		ID=S91000  HeadAlign=Center HeadBgColor=#B9D4DC Width=85  align=RIGHT SumBgColor=#C3D0DB </C>
								<C> Name='갑근세'		ID=T11000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT  SumBgColor=#C3D0DB </C> 
								<C> Name='주민세'		ID=T12000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT  SumBgColor=#C3D0DB </C>
								<C> Name='기타공제계'			ID=BXTOTAL  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT  SumBgColor=#C3D0DB </C> 
								<C> Name='공제합계'			ID=S93000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT  SumBgColor=#C3D0DB </C> 
								<c> Name='실지급액' ID=S94000   HeadAlign=Center HeadBgColor=#B9D4DC Width=95  align=RIGHT  SumBgColor=#C3D0DB </c> 
							">
									</OBJECT></comment><script>__ws__(__NSID__);</script>

									<fieldset style="width:876px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
										&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
									</fieldset>
                </td>
       					<td style="padding-left:3px;">

								</td>
							</tr>
						</table>
					</td>
        </tr>
      </table>
		</td>
	</tr>
</table>
</div>

  	<div id="div_contract" style="display:block">
		<table width="876" cellpadding="0" cellspacing="0" border="0">
			<tr>
			  <td colspan=8 align=center>
	<table  cellpadding="0" cellspacing="0" border="0" style='width:876px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
		<tr> 
			<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;지급년월&nbsp;&nbsp;</nobr></td>
			<td style="height:30px;border:0;width:130px solid #708090;padding-top:2px;border-right-width:1px;border-bottom-width:0px;"><nobr>
        <table cellpadding=0 cellspacing=0>
			<tr>
				<td><nobr>&nbsp;
					<comment id="__NSID__"><object id=gcem_yyyymm42 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="2" style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment			value=0>
						<param name=Border	      value=True>
						<param name=Numeric	      value=false>
						<param name=Format	      value="YYYY/MM">
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr></td></tr>
		</table></nobr></td>	
			<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:0px;" bgcolor="#eeeeee">
				<nobr>&nbsp;지급구분&nbsp;</nobr></td>	
			<td width="50" style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px;padding-top:2px;"><nobr>
        <table cellpadding=0 cellspacing=0 border=0>
					<tr>
						<td><nobr>
							<comment id="__NSID__"><object id=gclx_select_jigub5  name="gclx_select_jigub5" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
								<param name=ComboDataID			value=gcds_select_ec02az>
								<param name=SearchColumn		value="MINORCD^MINORNM">
								<param name=Sort            value="TRUE">
								<param name=SortColumn			value="MINORCD">
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value="MINORCD">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
						</td>
					</tr>
		</table></nobr></td>
		<td width="650"></td>


					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr> 
    <td colspan="2" align=center valign=center> 
      <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:100%;" align=center>
						<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;top:2px;">
							<tr> 
								<td style="width:876" align=center>
									<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
										style="width:876px;height:437px;border:1 solid #777777;z-index:2;">
									<PARAM NAME="DataID"				VALUE="gcds_data2">
										<PARAM NAME="Editable"			VALUE="True">
										<PARAM NAME="BorderStyle"		VALUE="0">
										<PARAM NAME="Indwidth"			VALUE="0">
										<param name="Fillarea"			VALUE="true">
										<PARAM NAME="SortView"			VALUE="left">
										<PARAM NAME="ColSizing"			VALUE="true">
									  <PARAM NAME="Format"				VALUE="  
								<FC> Name='소속' ID=DEPTNM BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=101 align=left  SumBgColor=#C3D0DB sort=true </FC> 
								<FC> Name='년월' ID=PAYDT BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=center  SumBgColor=#C3D0DB Value={Left(PAYDT,6)}  sort=true MASK='XXXX/XX'</FC> 
								<FC> Name='구분' ID=PAYDIVNM BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=center  SumBgColor=#C3D0DB sort=true  </FC> 
								<FC> Name='직위' ID=MINORNM BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=101 align=center  SumBgColor=#C3D0DB sort=true  </FC> 
								<FC> Name='근무지' ID=TMINORNM BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=101 align=center  SumBgColor=#C3D0DB sort=true  </FC>
								<FC> Name='사번' ID=EMPNO BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center  SumBgColor=#C3D0DB sort=true  </FC> 
								<F> Name='성명' ID=EMPNMK BgColor='#f5f5f5' HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=center SumBgColor=#C3D0DB  sort=true </F> 
								<C> Name='급여'		ID=PAYSUM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=RIGHT SumBgColor=#C3D0DB </C> 
								<C> Name='식대' ID=BP35000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C> 

								<C> Name='계'		ID=S91000 HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT SumBgColor=#C3D0DB </C>
								<C> Name='갑근세'		ID=T11000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT  SumBgColor=#C3D0DB </C> 
								<C> Name='주민세'		ID=T12000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT  SumBgColor=#C3D0DB </C>
								<C> Name='기타공제계'			ID=BXTOTAL  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT  SumBgColor=#C3D0DB </C> 
								<C> Name='공제합계'			ID=S93000  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=RIGHT  SumBgColor=#C3D0DB </C> 
								<c> Name='실지급액' ID=S94000   HeadAlign=Center HeadBgColor=#B9D4DC Width=95  align=RIGHT  SumBgColor=#C3D0DB </c> 
							">
									</OBJECT></comment><script>__ws__(__NSID__);</script>

									<fieldset style="width:876px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
										&nbsp;<font id=ft_cnt2 style="position:relative;top:3px;"></font>
									</fieldset>
                </td>
       					<td style="padding-left:3px;">

								</td>
							</tr>
						</table>
					</td>
        </tr>
      </table>
		</td>
	</tr>
</table>
</div>
</td>
</tr>
</table>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N  -- 급여지급현황[정기] --
------------------------------------------------------------------------------>
 <comment id="__NSID__"><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"			value="gcds_report1">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='급여지급현황_총인원.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_report0' 
<B>id=DHeader ,left=0,top=0 ,right=2870 ,bottom=458 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=895 ,top=5 ,right=1917 ,bottom=105 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=2</X>
	<L> left=32 ,top=227 ,right=2780 ,bottom=227 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='TODATEE', left=2580, top=132, right=2783, bottom=179, align='right' ,mask='XXXX.XX.XX', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='구  분' ,left=45 ,top=240 ,right=245 ,bottom=348 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=34 ,top=361 ,right=2780 ,bottom=361 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='월' ,left=200 ,top=372 ,right=245 ,bottom=422 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CMM', left=153, top=372, right=203, bottom=422, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='.' ,left=137 ,top=372 ,right=163 ,bottom=422 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CYYYY', left=45, top=372, right=140, bottom=422, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Print Date:' ,left=2314 ,top=132 ,right=2578 ,bottom=179 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1   총인원' ,left=32 ,top=179 ,right=242 ,bottom=221 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급내역' ,left=361 ,top=240 ,right=1327 ,bottom=290 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제내역' ,left=1348 ,top=240 ,right=2467 ,bottom=290 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CYYYY', left=964, top=13, right=1135, bottom=98, align='right', face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='S94000R', left=2488, top=372, right=2772, bottom=422, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='단위 : 원' ,left=2580 ,top=179 ,right=2783 ,bottom=221 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='COUNTR', left=274, top=372, right=350, bottom=422, align='right'</C>
	<L> left=353 ,top=295 ,right=2467 ,bottom=295 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='인원' ,left=271 ,top=240 ,right=348 ,bottom=348 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='실지급액' ,left=2488 ,top=240 ,right=2772 ,bottom=348 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CMM', left=1222, top=13, right=1311, bottom=98, align='right', face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<T>id='월' ,left=1311 ,top=13 ,right=1385 ,bottom=98 ,face='HY헤드라인M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='CTITLE', left=1416, top=13, right=1553, bottom=98, align='right', face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<T>id='지급 현황' ,left=1556 ,top=13 ,right=1869 ,bottom=98 ,face='HY헤드라인M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='년' ,left=1137 ,top=13 ,right=1219 ,bottom=98 ,face='HY헤드라인M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=34 ,top=438 ,right=2780 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=32 ,top=229 ,right=32 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=258 ,top=229 ,right=258 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=353 ,top=229 ,right=353 ,bottom=438 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1340 ,top=229 ,right=1340 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2475 ,top=229 ,right=2475 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2780 ,top=229 ,right=2780 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1606 ,top=295 ,right=1606 ,bottom=440 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1872 ,top=295 ,right=1872 ,bottom=440 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=642 ,top=295 ,right=642 ,bottom=440 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=879 ,top=295 ,right=879 ,bottom=440 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='S93000R', left=2167, top=377, right=2467, bottom=427, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BXTOTALR', left=1877, top=377, right=2154, bottom=427, align='right'</C>
	<C>id='T12000R', left=1611, top=377, right=1867, bottom=427, align='right'</C>
	<C>id='T11000R', left=1348, top=377, right=1601, bottom=427, align='right'</C>
	<C>id='S91000R', left=1106, top=377, right=1327, bottom=427, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BP24000R', left=887, top=377, right=1093, bottom=427, align='right'</C>
	<C>id='BP35000R', left=648, top=377, right=877, bottom=427, align='right'</C>
	<C>id='PAYSUMR', left=361, top=377, right=637, bottom=427, align='right'</C>
	<T>id='계' ,left=2164 ,top=301 ,right=2464 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=1875 ,top=301 ,right=2151 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=1609 ,top=301 ,right=1864 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑근세' ,left=1348 ,top=301 ,right=1601 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1103 ,top=301 ,right=1332 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량' ,left=885 ,top=301 ,right=1090 ,bottom=351 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='식대' ,left=645 ,top=301 ,right=874 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급여' ,left=358 ,top=301 ,right=635 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2162 ,top=295 ,right=2162 ,bottom=440 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1101 ,top=295 ,right=1101 ,bottom=440 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1101 ,top=295 ,right=1340 ,bottom=295 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>






	</R>
</A>

<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=133
	<R>id='급여지급현황_본사근무자.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 , MasterDataID='gcds_report2' 
<B>id=DHeader ,left=0,top=0 ,right=2870 ,bottom=287 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='2  임원(본사)' ,left=26 ,top=13 ,right=313 ,bottom=55 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=874 ,top=129 ,right=874 ,bottom=274 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=637 ,top=129 ,right=637 ,bottom=274 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1867 ,top=129 ,right=1867 ,bottom=274 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1601 ,top=129 ,right=1601 ,bottom=274 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2156 ,top=129 ,right=2156 ,bottom=274 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2775 ,top=63 ,right=2775 ,bottom=272 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2470 ,top=63 ,right=2470 ,bottom=272 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1335 ,top=63 ,right=1335 ,bottom=272 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=348 ,top=63 ,right=348 ,bottom=272 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=253 ,top=63 ,right=253 ,bottom=272 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=26 ,top=63 ,right=26 ,bottom=272 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='S93000R', left=2162, top=206, right=2462, bottom=256, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BXTOTALR', left=1872, top=206, right=2148, bottom=256, align='right'</C>
	<C>id='T12000R', left=1606, top=206, right=1861, bottom=256, align='right'</C>
	<C>id='T11000R', left=1343, top=206, right=1595, bottom=256, align='right'</C>
	<C>id='BP24000R', left=882, top=206, right=1087, bottom=256, align='right'</C>
	<C>id='BP35000R', left=642, top=206, right=871, bottom=256, align='right'</C>
	<C>id='PAYSUMR', left=355, top=206, right=632, bottom=256, align='right'</C>
	<T>id='실지급액' ,left=2483 ,top=74 ,right=2767 ,bottom=182 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인원' ,left=266 ,top=74 ,right=342 ,bottom=182 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='COUNTR', left=269, top=206, right=345, bottom=256, align='right'</C>
	<C>id='S94000R', left=2483, top=206, right=2767, bottom=256, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='공제내역' ,left=1343 ,top=74 ,right=2462 ,bottom=124 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급내역' ,left=355 ,top=74 ,right=1322 ,bottom=124 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CYYYY', left=39, top=206, right=134, bottom=256, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='.' ,left=132 ,top=206 ,right=158 ,bottom=256 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CMM', left=147, top=206, right=197, bottom=256, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='월' ,left=195 ,top=206 ,right=240 ,bottom=256 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=195 ,right=2775 ,bottom=195 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='구  분' ,left=39 ,top=74 ,right=240 ,bottom=182 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=26 ,top=61 ,right=2775 ,bottom=61 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=277 ,right=2775 ,bottom=277 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2154 ,top=129 ,right=2470 ,bottom=129 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1087 ,top=129 ,right=1087 ,bottom=274 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1087 ,top=129 ,right=1335 ,bottom=129 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=350 ,top=127 ,right=2464 ,bottom=127 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='S91000R', left=1095, top=206, right=1330, bottom=256, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='식대' ,left=640 ,top=137 ,right=869 ,bottom=187 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량' ,left=879 ,top=137 ,right=1085 ,bottom=187 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급여' ,left=353 ,top=137 ,right=629 ,bottom=187 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑근세' ,left=1343 ,top=137 ,right=1595 ,bottom=187 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=1606 ,top=137 ,right=1861 ,bottom=187 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=1872 ,top=137 ,right=2148 ,bottom=187 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=2162 ,top=137 ,right=2462 ,bottom=187 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1095 ,top=137 ,right=1330 ,bottom=187 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

	</R>
</A>

<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=141
	<R>id='급여지급현황_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='gcds_report1' 
<B>id=default ,left=0,top=0 ,right=2870 ,bottom=316 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=32 ,top=95 ,right=2780 ,bottom=95 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='구  분' ,left=45 ,top=105 ,right=245 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DEPTNM', left=92, top=40, right=606, bottom=84, align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=32 ,top=224 ,right=2780 ,bottom=224 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='월' ,left=200 ,top=237 ,right=245 ,bottom=285 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DCMM', left=153, top=237, right=203, bottom=285, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='.' ,left=137 ,top=237 ,right=163 ,bottom=285 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DCYYYY', left=45, top=237, right=140, bottom=285, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='인원' ,left=271 ,top=105 ,right=348 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DCOUNTR', left=271, top=237, right=348, bottom=285, align='right'</C>
	<L> left=353 ,top=158 ,right=2472 ,bottom=158 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='공제내역' ,left=1348 ,top=105 ,right=2467 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='실지급액' ,left=2488 ,top=105 ,right=2772 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DS94000R', left=2488, top=237, right=2772, bottom=285, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='지급내역' ,left=361 ,top=105 ,right=1327 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{currow+2}', left=32, top=40, right=87, bottom=84, align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='급여' ,left=361 ,top=166 ,right=629 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1090 ,top=158 ,right=1340 ,bottom=158 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2151 ,top=158 ,right=2472 ,bottom=158 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DPAYSUMR', left=361, top=237, right=629, bottom=285, align='right'</C>
	<C>id='DS93000R', left=2162, top=237, right=2467, bottom=285, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='식대' ,left=640 ,top=166 ,right=877 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량' ,left=887 ,top=166 ,right=1090 ,bottom=216 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1101 ,top=166 ,right=1332 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑근세' ,left=1348 ,top=166 ,right=1598 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=1603 ,top=166 ,right=1864 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=1872 ,top=166 ,right=2148 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=2162 ,top=166 ,right=2467 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DBP35000R', left=640, top=237, right=877, bottom=285, align='right'</C>
	<C>id='DBP24000R', left=887, top=237, right=1090, bottom=285, align='right'</C>
	<C>id='DS91000R', left=1101, top=237, right=1332, bottom=285, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DT11000R', left=1348, top=237, right=1598, bottom=285, align='right'</C>
	<C>id='DT12000R', left=1603, top=237, right=1864, bottom=285, align='right'</C>
	<C>id='DBXTOTALR', left=1872, top=237, right=2148, bottom=285, align='right'</C>
	<L> left=32 ,top=298 ,right=2780 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1340 ,top=98 ,right=1340 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=258 ,top=98 ,right=258 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=353 ,top=98 ,right=353 ,bottom=298 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=635 ,top=156 ,right=635 ,bottom=298 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1869 ,top=156 ,right=1869 ,bottom=298 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1601 ,top=156 ,right=1601 ,bottom=298 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=882 ,top=156 ,right=882 ,bottom=298 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1093 ,top=156 ,right=1093 ,bottom=298 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2475 ,top=98 ,right=2475 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2780 ,top=98 ,right=2780 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2154 ,top=156 ,right=2154 ,bottom=298 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=32 ,top=98 ,right=32 ,bottom=295 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
</B>


	</R>
</A>

<B>id=Footer ,left=0 ,top=1895 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=8 ,top=0 ,right=2826 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=8 ,top=26 ,right=2815 ,bottom=106</T>
	<I>id='../../common/img/icon.jpg' ,left=2400 ,top=5 ,right=2781 ,bottom=106</I>
</B>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N  -- 급여지급현황[상여] --
------------------------------------------------------------------------------>
 <comment id="__NSID__"><OBJECT id=gcrp_print_2  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<param name="DetailDataID"			value="gcds_report1">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='급여지급현황_총인원.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_report0' 
<B>id=DHeader ,left=0,top=0 ,right=2870 ,bottom=458 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=895 ,top=5 ,right=1917 ,bottom=105 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=2</X>
	<L> left=32 ,top=227 ,right=2780 ,bottom=227 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='TODATEE', left=2580, top=132, right=2783, bottom=179, align='right' ,mask='XXXX.XX.XX', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='구  분' ,left=45 ,top=240 ,right=245 ,bottom=348 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=34 ,top=361 ,right=2780 ,bottom=361 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='월' ,left=200 ,top=372 ,right=245 ,bottom=422 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CMM', left=153, top=372, right=203, bottom=422, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='.' ,left=137 ,top=372 ,right=163 ,bottom=422 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CYYYY', left=45, top=372, right=140, bottom=422, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Print Date:' ,left=2314 ,top=132 ,right=2578 ,bottom=179 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1   총인원' ,left=32 ,top=179 ,right=242 ,bottom=221 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급내역' ,left=361 ,top=240 ,right=1327 ,bottom=290 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제내역' ,left=1348 ,top=240 ,right=2467 ,bottom=290 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CYYYY', left=964, top=13, right=1135, bottom=98, align='right', face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='S94000R', left=2488, top=372, right=2772, bottom=422, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='단위 : 원' ,left=2580 ,top=179 ,right=2783 ,bottom=221 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='COUNTR', left=274, top=372, right=350, bottom=422, align='right'</C>
	<L> left=353 ,top=295 ,right=2467 ,bottom=295 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='인원' ,left=271 ,top=240 ,right=348 ,bottom=348 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1101 ,top=295 ,right=1340 ,bottom=295 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='실지급액' ,left=2488 ,top=240 ,right=2772 ,bottom=348 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CMM', left=1222, top=13, right=1311, bottom=98, align='right', face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<T>id='월' ,left=1311 ,top=13 ,right=1385 ,bottom=98 ,face='HY헤드라인M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='CTITLE', left=1416, top=13, right=1553, bottom=98, align='right', face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<T>id='지급 현황' ,left=1556 ,top=13 ,right=1869 ,bottom=98 ,face='HY헤드라인M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='년' ,left=1137 ,top=13 ,right=1219 ,bottom=98 ,face='HY헤드라인M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=34 ,top=438 ,right=2780 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=32 ,top=229 ,right=32 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=258 ,top=229 ,right=258 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=353 ,top=229 ,right=353 ,bottom=438 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1340 ,top=229 ,right=1340 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2475 ,top=229 ,right=2475 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2780 ,top=229 ,right=2780 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2162 ,top=295 ,right=2162 ,bottom=440 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1606 ,top=295 ,right=1606 ,bottom=440 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1872 ,top=295 ,right=1872 ,bottom=440 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1101 ,top=295 ,right=1101 ,bottom=440 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=642 ,top=295 ,right=642 ,bottom=440 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=879 ,top=295 ,right=879 ,bottom=440 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='S93000R', left=2167, top=377, right=2467, bottom=427, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BXTOTALR', left=1877, top=377, right=2154, bottom=427, align='right'</C>
	<C>id='T12000R', left=1611, top=377, right=1867, bottom=427, align='right'</C>
	<C>id='T11000R', left=1348, top=377, right=1601, bottom=427, align='right'</C>
	<C>id='S91000R', left=1106, top=377, right=1327, bottom=427, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BP24000R', left=887, top=377, right=1093, bottom=427, align='right'</C>
	<C>id='BP35000R', left=648, top=377, right=877, bottom=427, align='right'</C>
	<C>id='PAYSUMR', left=361, top=377, right=637, bottom=427, align='right'</C>
	<T>id='계' ,left=2164 ,top=301 ,right=2464 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=1875 ,top=301 ,right=2151 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=1609 ,top=301 ,right=1864 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑근세' ,left=1348 ,top=301 ,right=1601 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1103 ,top=301 ,right=1332 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량' ,left=885 ,top=301 ,right=1090 ,bottom=351 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='식대' ,left=645 ,top=301 ,right=874 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급여' ,left=358 ,top=301 ,right=635 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>


	</R>
</A>


<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=141
	<R>id='급여지급현황_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='gcds_report1' 
<B>id=default ,left=0,top=0 ,right=2870 ,bottom=316 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=32 ,top=95 ,right=2780 ,bottom=95 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='구  분' ,left=45 ,top=105 ,right=245 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DEPTNM', left=92, top=40, right=606, bottom=84, align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=32 ,top=224 ,right=2780 ,bottom=224 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='월' ,left=200 ,top=237 ,right=245 ,bottom=285 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DCMM', left=153, top=237, right=203, bottom=285, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='.' ,left=137 ,top=237 ,right=163 ,bottom=285 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DCYYYY', left=45, top=237, right=140, bottom=285, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='인원' ,left=271 ,top=105 ,right=348 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DCOUNTR', left=271, top=237, right=348, bottom=285, align='right'</C>
	<L> left=353 ,top=158 ,right=2472 ,bottom=158 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='공제내역' ,left=1348 ,top=105 ,right=2467 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='실지급액' ,left=2488 ,top=105 ,right=2772 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DS94000R', left=2488, top=237, right=2772, bottom=285, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='지급내역' ,left=361 ,top=105 ,right=1327 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{currow+1}', left=32, top=40, right=87, bottom=84, align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='급여' ,left=361 ,top=166 ,right=629 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1090 ,top=158 ,right=1340 ,bottom=158 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2151 ,top=158 ,right=2472 ,bottom=158 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DPAYSUMR', left=361, top=237, right=629, bottom=285, align='right'</C>
	<C>id='DS93000R', left=2162, top=237, right=2467, bottom=285, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='식대' ,left=640 ,top=166 ,right=877 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량' ,left=887 ,top=166 ,right=1090 ,bottom=216 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1101 ,top=166 ,right=1332 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑근세' ,left=1348 ,top=166 ,right=1598 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=1603 ,top=166 ,right=1864 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=1872 ,top=166 ,right=2148 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=2162 ,top=166 ,right=2467 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DBP35000R', left=640, top=237, right=877, bottom=285, align='right'</C>
	<C>id='DBP24000R', left=887, top=237, right=1090, bottom=285, align='right'</C>
	<C>id='DS91000R', left=1101, top=237, right=1332, bottom=285, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DT11000R', left=1348, top=237, right=1598, bottom=285, align='right'</C>
	<C>id='DT12000R', left=1603, top=237, right=1864, bottom=285, align='right'</C>
	<C>id='DBXTOTALR', left=1872, top=237, right=2148, bottom=285, align='right'</C>
	<L> left=32 ,top=298 ,right=2780 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1340 ,top=98 ,right=1340 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=258 ,top=98 ,right=258 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=353 ,top=98 ,right=353 ,bottom=298 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=635 ,top=156 ,right=635 ,bottom=298 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1869 ,top=156 ,right=1869 ,bottom=298 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1601 ,top=156 ,right=1601 ,bottom=298 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=882 ,top=156 ,right=882 ,bottom=298 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1093 ,top=156 ,right=1093 ,bottom=298 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2475 ,top=98 ,right=2475 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2780 ,top=98 ,right=2780 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2154 ,top=156 ,right=2154 ,bottom=298 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=32 ,top=98 ,right=32 ,bottom=295 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
</B>

	</R>
</A>

<B>id=Footer ,left=0 ,top=1895 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=8 ,top=0 ,right=2826 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=8 ,top=26 ,right=2815 ,bottom=106</T>
	<I>id='../../common/img/icon.jpg' ,left=2400 ,top=5 ,right=2781 ,bottom=106</I>
</B>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N  -- 급여지급현황[계약] --
------------------------------------------------------------------------------>
 <comment id="__NSID__"><OBJECT id=gcrp_print_3  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report3">
	<param name="DetailDataID"			value="gcds_report4">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='급여지급현황_총인원.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_report3' 
<B>id=DHeader ,left=0,top=0 ,right=2870 ,bottom=458 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=895 ,top=5 ,right=1917 ,bottom=105 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=2</X>
	<L> left=32 ,top=227 ,right=2780 ,bottom=227 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='TODATEE', left=2580, top=132, right=2783, bottom=179, align='right' ,mask='XXXX.XX.XX', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='구  분' ,left=45 ,top=240 ,right=245 ,bottom=348 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=34 ,top=361 ,right=2780 ,bottom=361 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='월' ,left=200 ,top=372 ,right=245 ,bottom=422 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CMM', left=153, top=372, right=203, bottom=422, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='.' ,left=137 ,top=372 ,right=163 ,bottom=422 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CYYYY', left=45, top=372, right=140, bottom=422, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Print Date:' ,left=2314 ,top=132 ,right=2578 ,bottom=179 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1   총인원' ,left=32 ,top=179 ,right=242 ,bottom=221 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급내역' ,left=361 ,top=240 ,right=1327 ,bottom=290 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제내역' ,left=1348 ,top=240 ,right=2467 ,bottom=290 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CYYYY', left=964, top=13, right=1135, bottom=98, align='right', face='HY헤드라인M', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=353 ,top=295 ,right=2467 ,bottom=295 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='인원' ,left=271 ,top=240 ,right=348 ,bottom=348 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1101 ,top=295 ,right=1340 ,bottom=295 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='실지급액' ,left=2488 ,top=240 ,right=2772 ,bottom=348 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CMM', left=1222, top=13, right=1311, bottom=98, align='right', face='HY헤드라인M', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<T>id='월' ,left=1311 ,top=13 ,right=1385 ,bottom=98 ,face='HY헤드라인M' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='CTITLE', left=1416, top=13, right=1553, bottom=98, align='right', face='HY헤드라인M', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<T>id='급여지급 현황' ,left=1556 ,top=13 ,right=1869 ,bottom=98 ,face='HY헤드라인M' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='년' ,left=1137 ,top=13 ,right=1219 ,bottom=98 ,face='HY헤드라인M' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=34 ,top=438 ,right=2780 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=32 ,top=229 ,right=32 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=258 ,top=229 ,right=258 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=353 ,top=229 ,right=353 ,bottom=438 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1340 ,top=229 ,right=1340 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2475 ,top=229 ,right=2475 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2780 ,top=229 ,right=2780 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2162 ,top=295 ,right=2162 ,bottom=440 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1606 ,top=295 ,right=1606 ,bottom=440 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1872 ,top=295 ,right=1872 ,bottom=440 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1101 ,top=295 ,right=1101 ,bottom=440 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=727 ,top=295 ,right=727 ,bottom=440 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='S91000R', left=1106, top=374, right=1327, bottom=425, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='S94000R', left=2488, top=374, right=2772, bottom=425, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='갑근세' ,left=1348 ,top=301 ,right=1601 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='식대' ,left=729 ,top=301 ,right=1090 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1103 ,top=301 ,right=1332 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급여' ,left=358 ,top=301 ,right=721 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=1611 ,top=301 ,right=1867 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=1877 ,top=301 ,right=2154 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=2167 ,top=301 ,right=2467 ,bottom=351 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BP35000R', left=729, top=374, right=1090, bottom=425, align='right'</C>
	<C>id='PAYSUMR', left=358, top=374, right=721, bottom=425, align='right'</C>
	<C>id='T11000R', left=1348, top=374, right=1601, bottom=425, align='right'</C>
	<C>id='T12000R', left=1611, top=374, right=1867, bottom=425, align='right'</C>
	<C>id='BXTOTALR', left=1877, top=374, right=2154, bottom=425, align='right'</C>
	<C>id='S93000R', left=2167, top=374, right=2467, bottom=425, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COUNTR', left=274, top=374, right=350, bottom=425, align='right'</C>
	<T>id='단위 : 원' ,left=2580 ,top=179 ,right=2783 ,bottom=221 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

	</R>
</A>


<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=141
	<R>id='급여지급현황_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='gcds_report4' 
<B>id=default ,left=0,top=0 ,right=2870 ,bottom=316 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=32 ,top=95 ,right=2780 ,bottom=95 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='구  분' ,left=45 ,top=105 ,right=245 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DEPTNM', left=92, top=40, right=606, bottom=84, align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=32 ,top=224 ,right=2780 ,bottom=224 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='월' ,left=200 ,top=237 ,right=245 ,bottom=285 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DCMM', left=153, top=237, right=203, bottom=285, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='.' ,left=137 ,top=237 ,right=163 ,bottom=285 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DCYYYY', left=45, top=237, right=140, bottom=285, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='인원' ,left=271 ,top=105 ,right=348 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DCOUNTR', left=271, top=237, right=348, bottom=285, align='right'</C>
	<L> left=353 ,top=158 ,right=2472 ,bottom=158 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='공제내역' ,left=1348 ,top=105 ,right=2467 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='실지급액' ,left=2488 ,top=105 ,right=2772 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DS94000R', left=2488, top=237, right=2772, bottom=285, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='지급내역' ,left=361 ,top=105 ,right=1327 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{currow+1}', left=32, top=40, right=87, bottom=84, align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1090 ,top=158 ,right=1340 ,bottom=158 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2151 ,top=158 ,right=2472 ,bottom=158 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DS93000R', left=2162, top=237, right=2467, bottom=285, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='계' ,left=1101 ,top=166 ,right=1332 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑근세' ,left=1348 ,top=166 ,right=1598 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=1603 ,top=166 ,right=1864 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=1872 ,top=166 ,right=2148 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=2162 ,top=166 ,right=2467 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DS91000R', left=1101, top=237, right=1332, bottom=285, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DT11000R', left=1348, top=237, right=1598, bottom=285, align='right'</C>
	<C>id='DT12000R', left=1603, top=237, right=1864, bottom=285, align='right'</C>
	<C>id='DBXTOTALR', left=1872, top=237, right=2148, bottom=285, align='right'</C>
	<L> left=32 ,top=298 ,right=2780 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=32 ,top=98 ,right=29 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1340 ,top=98 ,right=1340 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=258 ,top=98 ,right=258 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=353 ,top=98 ,right=353 ,bottom=298 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1869 ,top=156 ,right=1869 ,bottom=298 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1601 ,top=156 ,right=1601 ,bottom=298 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1093 ,top=156 ,right=1093 ,bottom=298 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2475 ,top=98 ,right=2475 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2780 ,top=98 ,right=2780 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2154 ,top=156 ,right=2154 ,bottom=298 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=729 ,top=158 ,right=729 ,bottom=301 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='급여' ,left=361 ,top=166 ,right=724 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='식대' ,left=735 ,top=166 ,right=1087 ,bottom=216 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DBP35000R', left=735, top=237, right=1087, bottom=285, align='right'</C>
	<C>id='DPAYSUMR', left=361, top=237, right=724, bottom=285, align='right'</C>
</B>

	</R>
</A>

<B>id=Footer ,left=0 ,top=1895 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=8 ,top=0 ,right=2826 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=8 ,top=26 ,right=2815 ,bottom=106</T>
	<I>id='../../common/img/icon.jpg' ,left=2400 ,top=5 ,right=2781 ,bottom=106</I>
</B>
">
</OBJECT></comment><script>__ws__(__NSID__);</script>

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 