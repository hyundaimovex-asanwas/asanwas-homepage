<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사/업적신고작성
+ 프로그램 ID	: h060020
+ 기 능 정 의	: 
+ 변 경 이 력	: 정영식
+ 서 블 릿 명	:
-----------------------------------------------------------------------------
+ 수 정 내 용 :	
+ 수   정  자 : 
+ 수 정 일 자 : 
-----------------------------------------------------------------------------
------------------------------------------------------------------------------>

<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>

<jsp:include page="/Payroll/common/include/head.jsp"/>
<title></title>
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
//get_cookdata();
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7); //+ gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);

var strParam = new Array();
strParam=window.dialogArguments;
	


/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
     gcem_evaym.text =strParam[0];

	ln_Query();
}
/******************************************************************************
	Description : 조회 ( 전체일 경우 모든 부서가 아니라...콤보에 나타난 부서만 조회한다.)
******************************************************************************/
function ln_Query(){
  //마스트
	gcds_mst.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060020_s0?"
									+ "v_str1="+gcem_evaym.text
									+ "&v_str2="+strParam[1];
  //prompt('',gcds_mst.DataID);
	gcds_mst.Reset();
	
	if(gcds_mst.countrow<1){
		ln_Add();
	}else{
        ifrm.ln_Row_Clear(2); //초기화
	}

	ifrm.ln_Query();
}
/*-----------------------------------------------------------------------------
		Description : 선조회 조건
-----------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------
		Description : 선조회 조건
-----------------------------------------------------------------------------*/
function ln_Before(){
    gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060020_s2?"
		                + "v_str1="+strParam[1];
		//prompt('',gcds_data.DataID);										
		gcds_data.Reset();
}

/*-----------------------------------------------------------------------------
		Description : 초기정보
-----------------------------------------------------------------------------*/
function ln_info(i) {
    txt_evaym.value = gcem_evaym.text;
		txt_empno.value = gcds_data.namevalue(i,"EMPNO");
		txt_empnmk.value =gcds_data.namevalue(i,"EMPNMK");
		txt_deptcd.value =gcds_data.namevalue(i,"DEPTCD");
		txt_deptnm.value =gcds_data.namevalue(i,"DEPTNMK");
		txt_divcd.value  =gcds_data.namevalue(i,"DIVCD");
		txt_divnm.value  =gcds_data.namevalue(i,"DIVNM");
		txt_headcd.value =gcds_data.namevalue(i,"HEADCD");
		txt_headnm.value =gcds_data.namevalue(i,"HEADNM");
		txt_paygrd.value =gcds_data.namevalue(i,"PAYGRD");
		txt_paygrdnm.value =gcds_data.namevalue(i,"PAYGRDNM");

    if(gcds_data.namevalue(i,"DIVCD")!=""&&gcds_data.namevalue(i,"DIVCD")==gcds_data.namevalue(i,"DEPTCD")){
			txt_deptcd.value="";
			txt_deptnm.value="";
			gcds_data.namevalue(1,"DEPTCD")="";
			gcds_data.namevalue(1,"DEPTNMK")="";
		}

		if(gcds_data.namevalue(i,"HEADCD")!=""&&gcds_data.namevalue(i,"HEADCD")==gcds_data.namevalue(i,"DIVCD")){
			txt_divcd.value="";
			txt_divnm.value="";
			gcds_data.namevalue(1,"DIVCD")="";  
			gcds_data.namevalue(1,"DIVNM")="";  
		}	

}		
		

/******************************************************************************
	Description : 행추가
******************************************************************************/
function ln_Add(){

	if(!ln_Add_Chk()) false;

  ln_Before();
  i = gcds_data.rowposition;
  ln_SetDataHeader();
  gcds_mst.Addrow();
	txt_evaym.value = gcem_evaym.text;
	gcds_mst.namevalue(gcds_mst.rowposition,"EVAYM")=txt_evaym.value;
	gcds_mst.namevalue(gcds_mst.rowposition,"EMPNO")  =gcds_data.namevalue(i,"EMPNO");   
	gcds_mst.namevalue(gcds_mst.rowposition,"EMPNMK") =gcds_data.namevalue(i,"EMPNMK");  
	gcds_mst.namevalue(gcds_mst.rowposition,"DEPTCD") =gcds_data.namevalue(i,"DEPTCD");  
	gcds_mst.namevalue(gcds_mst.rowposition,"DEPTNMK")=gcds_data.namevalue(i,"DEPTNMK"); 
	gcds_mst.namevalue(gcds_mst.rowposition,"DIVCD")  =gcds_data.namevalue(i,"DIVCD");   
	gcds_mst.namevalue(gcds_mst.rowposition,"DIVNM")  =gcds_data.namevalue(i,"DIVNM");   
	gcds_mst.namevalue(gcds_mst.rowposition,"HEADCD") =gcds_data.namevalue(i,"HEADCD");  
	gcds_mst.namevalue(gcds_mst.rowposition,"HEADNM") =gcds_data.namevalue(i,"HEADNM");  
	gcds_mst.namevalue(gcds_mst.rowposition,"PAYGRD") =gcds_data.namevalue(i,"PAYGRD");  
	gcds_mst.namevalue(gcds_mst.rowposition,"PAYGRDNM")= gcds_data.namevalue(i,"PAYGRDNM");
	gcds_mst.namevalue(gcds_mst.rowposition,"WRDT")  = gs_date2;  
	gcds_mst.namevalue(gcds_mst.rowposition,"WRID") =strParam[1];  
	gcds_mst.namevalue(gcds_mst.rowposition,"UPDT") =gs_date2;
	gcds_mst.namevalue(gcds_mst.rowposition,"UPID") =strParam[1];  

	ifrm.ln_Row_Clear(2); //초기화
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Row_Add(){
 	ifrm.ln_Add();
}

/******************************************************************************
	Description : 추가시 체크 기존 데이타 존재시 추가 못함.
******************************************************************************/
function ln_Add_Chk(){
	gcds_chk.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060020_s3?"
		               + "v_str1="+gcem_evaym.text
									 + "&v_str2="+strParam[1];
	//prompt('dtl::ln_Query',gcds_dtl.DataID);									
  gcds_chk.Reset();

	if(gcds_chk.namevalue(1,"CNT")>0){
		alert("이미 데이타가 존재합니다. 조회 후 수정하십시요.");
		return false;
	}
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
  ln_Save_Chk();
	ifrm.ln_Save();
}


/******************************************************************************
	Description : 입력값 체크[근태관리]
******************************************************************************/
function ln_Save_Chk() {
  //숫자체크
  //gf_ChkNumber()

}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Row_Delete(){
	ifrm.ln_Delete();
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
  ifrm.ln_Print();
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : 팝업
******************************************************************************/
function ln_Popup(gbn){

}

/******************************************************************************
	Description : 사용여부
  parameter   :
******************************************************************************/
function ln_Enable(gbn){

}

/******************************************************************************
	Description : 데이타셋 헤드 설정 (mst)
  parameter   :
******************************************************************************/
function ln_SetDataHeader(){
  
      //업적신고MST
	if (gcds_mst.countrow<1){
		var s_temp = " EVAYM:STRING(6),EMPNO:STRING(7),EMPNMK:STRING(30),HEADCD:STRING(4),HEADNM:STRING(50),"
							 + " DIVCD:STRING(4),DIVNM:STRING(50),DEPTCD:STRING(4),DEPTNMK:STRING(50),PAYGRD:STRING(4),PAYGRDNM:STRING(50), "
							 + " WORK_1:STRING(50),STARTDT_1:STRING(8),ENDDT_1:STRING(8),PLACE_1:STRING(50),REMARK_1:STRING(100),"
							 + " WORK_2:STRING(50),STARTDT_2:STRING(8),ENDDT_2:STRING(8),PLACE_2:STRING(50),REMARK_2:STRING(100),"
							 + " WORK_3:STRING(50),STARTDT_3:STRING(8),ENDDT_3:STRING(8),PLACE_3:STRING(50),REMARK_3:STRING(100),"
							 + " WRDT:STRING(8),WRID:STRING(10),UPDT:STRING(8),UPID:STRING(10)";
	  gcds_mst.SetDataHeader(s_temp);
	}
}



/******************************************************************************
	Description : 조회시 Loading bar start
  parameter   :
******************************************************************************/
function ln_Loading_Start(){
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.1";
	//document.all.LowerFrame.style.visibility="visible";
}
/******************************************************************************
	Description : 조회시 Loading bar end
  parameter   :
******************************************************************************/
function ln_Loading_End(row){
	window.status="조회가 완료 되었습니다.";
	lbl_search.innerText = "( " + row + " 건 )";
	//document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
}


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<OBJECT id=gcds_mst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h060020_t1(I:USER=gcds_data)">
</OBJECT></comment><script>__ws__(__NSID__);</script>
	
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
  if(row>=1){
		ln_info(row);
	}
</script>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("에러가 발생 했습니다.");
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language=JavaScript for=gctr_data event=OnFail()>
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data2" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language=JavaScript for=gctr_data2 event=OnFail()>
	alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
</script>
</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/h060004_popup2_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		  <img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand" onclick="ln_Print()">
			<!-- <img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">
			<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()" >
		  <img src="../../Common/img/btn/com_b_save.gif" 		style="cursor:hand" onclick="ln_Save()"> -->
		</td>
  </tr>
	<tr>
		<td COLSPAN=2>
			<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr> 
					<td width="120px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>&nbsp;&nbsp;고과년월&nbsp;</nobr></td>
					<td class="tab18"  style="width:750px;"><nobr>&nbsp;
					<comment id="__NSID__">
						<object  id=gcem_evaym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:0px;top:3px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
											<param name=ReadOnly      value="true">
						 </object></comment><script>__ws__(__NSID__);</script> 
						 <!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_evaym', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">   -->
				</tr>
      </table>
		</td>
	</tr>
	<tr> 
    <td colspan=2 style="height:25px;position:relative;top:3px"><font color="blue"><b>1.인적사항</b></font></td>
	</tr>
	<tr>
		<td COLSPAN=2>
			<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr> 
					<td width="130px" height="20"  style="" bgcolor="#eeeeee" class="tab15" align=center rowspan=2><nobr>소속</nobr></td>					
					<td width="80px"  style="" bgcolor="#eeeeee" class="tab18" align=center rowspan=2><nobr>직위</nobr></td>					
					<td width="80px"  style="" bgcolor="#eeeeee" class="tab18" align=center rowspan=2><nobr>성명</nobr></td>					
					<td width="465px"  style="" bgcolor="#eeeeee" class="tab18" align=center colspan=3><nobr>인사이동사항</nobr></td>					
					<td width="125px"  style="" bgcolor="#eeeeee" class="tab18" align=center rowspan=2><nobr>비고</nobr></td>					
				</tr>
				<tr> 		
					<td width="180px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>근무기간</nobr></td>					
					<td width="160px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>소속부서</nobr></td>					
					<td width="125px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>담당업무</nobr></td>					
				</tr>
        <tr>  
					<td class="tab15" style=""rowspan=3>
					  <input id="txt_evaym"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_headcd"  type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_divcd"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_deptcd"  type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_headnm"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:110px;height:20px;" ReadOnly>
						<input id="txt_divnm"   type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:110px;height:20px;" ReadOnly>
						<input id="txt_deptnm"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:110px;height:20px;" ReadOnly>
					</td>
					<td class="tab18" style=""rowspan=3><nobr>
					  <input id="txt_paygrd"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width5px;height:20px;" ReadOnly>
						<input id="txt_paygrdnm" type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:70px;height:20px;" ReadOnly>
					</nobr></td>
					<td class="tab18" style=""rowspan=3><nobr>
						<input id="txt_empno"   type="hidden"   class="txtbox"  style= "position:relative;left:0px;width:5px;height:20px;" ReadOnly>
						<input id="txt_empnmk"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:70px;height:20px;" ReadOnly>
					</nobr></td>
					<td class="tab18" style=""><nobr>
						<comment id="__NSID__">
						<object  id=gcem_startdt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=ReadOnly      value="true">
											<param name=InheritColor  value=false>
						 </object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp; ~
  					 <comment id="__NSID__">
						 <object  id=gcem_enddt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=ReadOnly      value="true">
											<param name=InheritColor  value=false>
						 </object></comment><script>__ws__(__NSID__);</script> 
					</nobr></td>
					<td class="tab18" style=""><nobr>
					   <input id="txt_place_1"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:150px;height:20px;" ReadOnly >
					</nobr></td>
					<td class="tab18" style=""><nobr>
					  <input id="txt_work_1"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:116px;height:20px;" ReadOnly>
					</nobr></td>

          <td class="tab18" style=""><nobr>
						<input id="txt_remark_1"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:115px;height:20px;" ReadOnly >
					</nobr></td>
				</tr>
				
				<tr>  
					
					<td class="tab18" style=""><nobr>
						<comment id="__NSID__">
						<object  id=gcem_startdt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px" >		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=ReadOnly      value="true">
											<param name=InheritColor  value=false>
						 </object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp; ~
  					 <comment id="__NSID__">
						 <object  id=gcem_enddt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=ReadOnly      value="true">
											<param name=InheritColor  value=false>
						 </object></comment><script>__ws__(__NSID__);</script> 
					</nobr></td>
					
					<td class="tab18" style=""><nobr>
							<input id="txt_place_2"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:150px;height:20px;" ReadOnly>
					</nobr></td>

					<td class="tab18" style=""><nobr>
            <input id="txt_work_2"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:116px;height:20px;" ReadOnly > 
          </nobr></td>
          
					<td class="tab18" style=""><nobr>
					    <input id="txt_remark_2"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:115px;height:20px;" ReadOnly>
					</nobr></td>
				</tr>
				<tr>  					
					<td class="tab18" style=""><nobr>
						<comment id="__NSID__">
						<object  id=gcem_startdt_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px" >		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=ReadOnly      value="true">
											<param name=InheritColor  value=false>
						 </object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp; ~
  					 <comment id="__NSID__">
						 <object  id=gcem_enddt_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=ReadOnly      value="true">
											<param name=InheritColor  value=false>
						 </object></comment><script>__ws__(__NSID__);</script> 
					
					</nobr></td>
					
					<td class="tab18" style=""><nobr>
						 <input id="txt_place_3"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:150px;height:20px;" ReadOnly>
					</nobr></td>

					<td class="tab18" style=""><nobr>
						<input id="txt_work_3"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:116px;height:20px;" ReadOnly> 
					</nobr></td>
          
					<td class="tab18" style=""><nobr>
						 <input id="txt_remark_3"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:115px;height:20px;" ReadOnly>
					</nobr></td>
				</tr>
      </table>
		</td>
	</tr>
	<tr> 
    <td style="height:25px;position:relative;top:3px"><font color="blue"><b>2.업적신고서</b></font></td>
		<td width="685" align="right" style="padding-top:4px;">
			<!-- <img src="../../Common/img/btn/com_b_rowadd.gif"		style="cursor:hand" onclick="ln_Row_Add()">
		  <img src="../../Common/img/btn/com_b_rowdel.gif"		style="cursor:hand" onclick="ln_Row_Delete()"> -->
		</td>
	</tr>
  <tr>
  <td COLSPAN=2>
		<table  cellpadding=0 cellspacing=0 style=width:855px;height:30px;font-size:9pt;background-color:#ffffff;>
		<tr> 
			<td width=40px  style='' bgcolor='#eeeeee'  class='tab15' align=center ><nobr>순</nobr></td>					
			<td width=80px  style='' bgcolor='#eeeeee'  class='tab18' align=center ><nobr>항목</nobr></td>					
			<td width=623px style='' bgcolor='#eeeeee' class='tab18' align=center ><nobr>주요 업적 내용</nobr></td>					
			<td width=54px  style='' bgcolor='#eeeeee' class='tab18' align=center ><nobr>가중치(%)</nobr></td>					
			<td width=58px  style='' bgcolor='#eeeeee' class='tab18' align=center ><nobr>비고</nobr></td>					
		</tr>
		</table>
	</td>
	</tr>
	<tr>
	 <td colspan=2>
		<iframe id="ifrm" name="ifrm" src="./H060004_ifrm.jsp" frameborder=0 style="position:relative;top:1px;width:872;height:330px;border:1 solid #708090;"></iframe>
	 </td>
</table>


<comment id="__NSID__"><object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_mst>
	<param name=BindInfo  value='
		<C>Col=EVAYM      ctrl=txt_evaym		  param=value	 </C>
		<C>Col=EMPNO      ctrl=txt_empno		  param=value	 </C>
		<C>Col=EMPNMK     ctrl=txt_empnmk		  param=value	 </C>
		<C>Col=HEADCD     ctrl=txt_headcd		  param=value	 </C>
		<C>Col=HEADNM     ctrl=txt_headnm		  param=value	 </C>
		<C>Col=DIVCD      ctrl=txt_divcd		  param=value	 </C>
		<C>Col=DIVNM      ctrl=txt_divnm		  param=value	 </C>
		<C>Col=DEPTCD     ctrl=txt_deptcd     param=value	 </C>
		<C>Col=DEPTNMK    ctrl=txt_deptnm		  param=value	 </C>
		<C>Col=PAYGRD     ctrl=txt_paygrd     param=value	 </C>
		<C>Col=PAYGRDNM   ctrl=txt_paygrdnm   param=value	 </C>
		<C>Col=WORK_1     ctrl=txt_work_1     param=value	 </C>
		<C>Col=STARTDT_1  ctrl=gcem_startdt_1 param=text   </C>
		<C>Col=ENDDT_1    ctrl=gcem_enddt_1	  param=text	 </C>
		<C>Col=PLACE_1    ctrl=txt_place_1    param=value	 </C>
		<C>Col=REMARK_1		ctrl=txt_remark_1 	param=value	 </C>
		<C>Col=WORK_2     ctrl=txt_work_2     param=value	 </C>
		<C>Col=STARTDT_2  ctrl=gcem_startdt_2 param=text   </C>
		<C>Col=ENDDT_2    ctrl=gcem_enddt_2	  param=text	 </C>
		<C>Col=PLACE_2    ctrl=txt_place_2    param=value	 </C>
		<C>Col=REMARK_2		ctrl=txt_remark_2 	param=value	 </C>
		<C>Col=WORK_3     ctrl=txt_work_3     param=value	 </C>
		<C>Col=STARTDT_3  ctrl=gcem_startdt_3 param=text   </C>
		<C>Col=ENDDT_3    ctrl=gcem_enddt_3	  param=text	 </C>
		<C>Col=PLACE_3    ctrl=txt_place_3    param=value	 </C>
		<C>Col=REMARK_3		ctrl=txt_remark_3 	param=value	 </C>
	'>
</object></comment><script>__ws__(__NSID__);</script>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>