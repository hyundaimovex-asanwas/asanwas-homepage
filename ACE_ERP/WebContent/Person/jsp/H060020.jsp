<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 인사/업적신고작성
 * 프로그램ID 	: h060020
 * J  S  P		: h060020.jsp
 * 서 블 릿		: 
 * 작 성 자		: 정영식
 * 작 성 일		: ?
 * 기능정의		: ?
 * [ 수정일자 ][수정자] 내용
 * [2011-07-29][심동현] JSP 수정방법
 *						1.업무시스템 CD 인사 01
 *                                      회계 02
 *                                      시스템설정 03
 *                                      관광/출입 04 
 *                                      쇼핑몰 05
 *                                      물류 07 
 *                                      구매 08
 *                                      공사관리 10
 *                                      종합관리 13
 *                                      로력관리 14
 *						   include 하는 body_s01.jsp 그리고 body_s01.jsp 안에서 사용
 *						2. dirpath 를 선언하고 각종 경로에 사용해야 
 *							소스를 그대로 WASD와 운영서버에서 사용 가능함
 *						3. html 주석은 가급적 ServerPage 주석으로 변경함
 *						4. 
 
 *****************************************************************************/
%>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	
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
<html>
<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<title></title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr  ">
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
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7); //+ gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_evaym="";

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

  //gcem_evaym.text = gs_date;
  //고과년월 가져오기
	//2009.05.11 신규추가
  gcds_evaym.DataID = "/servlet/Person.hclcode_s1?v_str1=2063";
	gcds_evaym.Reset();
	
	//alert("MINORNM"+gcds_evaym.namevalue(gcds_evaym.rowposition,"MINORNM"));
	gcem_evaym.text=gcds_evaym.namevalue(gcds_evaym.rowposition,"MINORNM");
	gs_evaym = gcds_evaym.namevalue(gcds_evaym.rowposition,"MINORNM");
 
	txt_empno2.value=gusrid;

	ln_Query();

	if(gusrid=="6070001"||gusrid=="2020008"||gusrid=="2050045"){
		txt_empno2.readOnly= false;
	}else{
		txt_empno2.readOnly= true;
	}
}

/******************************************************************************
	Description : 고과대상기간조회
	              strTerm : 고과년월
******************************************************************************/
function ln_Term_Query(evaym){
	gcds_term.DataID = "/servlet/Person.hclcode_s2?v_str1=2064&v_str2="+evaym;
	//prompt('',gcds_term.DataID);
	gcds_term.Reset(); 
	txt_term.value = gcds_term.namevalue(gcds_term.rowposition,"MEMO");
}

/******************************************************************************
	Description : 조회 ( 전체일 경우 모든 부서가 아니라...콤보에 나타난 부서만 조회한다.)
******************************************************************************/
function ln_Query(){

  window.status="데이타 조회중입니다..잠시만 기다려 주십시오.1";
	//document.all.LowerFrame.style.visibility="visible";
	//alert("gcem_evaym.text::"+gcem_evaym.text);
  //고과대상기간
	ln_Term_Query(gcem_evaym.text);
	//alert("MEMO:::"+gcds_term.namevalue(gcds_term.rowposition,"MEMO"));
  //마스트
  //@@@
	gcds_mst.DataID = "/servlet/Person.h060020_s0?"
									+ "v_str1="+gcem_evaym.text
									+ "&v_str2="+txt_empno2.value;
  //prompt('',gcds_mst.DataID);
	gcds_mst.Reset();
	if(gcds_mst.countrow<1){
		ln_Add();
	}else{
    ifrm.ln_Row_Clear(2); //초기화
	}
	ifrm.ln_Query();

	//document.all.LowerFrame.style.visibility="hidden";
}
/*-----------------------------------------------------------------------------
		Description : 선조회 조건
-----------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------
		Description : 선조회 조건
-----------------------------------------------------------------------------*/
function ln_Before(){

    //2008.11.12 JYS - 재택근무자의 부서 때문에 쿼리를 임의로 변경함.
		/*
    gcds_data.DataID = "/servlet/Person.h060020_s2?"
		                + "v_str1="+gusrid;
		gcds_data.Reset();
    */

		//@@@
		gcds_data.DataID = "/servlet/Person.h060020_s22?"
		                 + "v_str1="+ txt_empno2.value;
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
  
	// 나중에 막아야함.
  //if(gusrid=="6070001"||gusrid=="2040011"||gusrid=="2070037"||gusrid=="2040067"||gusrid=="2050018"||gusrid=="2070033"||gusrid=="2040001"||gusrid=="2050046"||gusrid=="6050005"){
  
	/****
	2008.11.11 JYS 임의로 막음
 	if(gusrid=="6070001"){

	}else{
	  alert("업적신고서 입력기간이 지나 입력이 불가합니다.");
	  if(gcds_data.rowposition>1){
			return false;
		}
	}
	****/
  //2009.05.11 jys
	/***
	if(gcem_evaym.text!="200811"){
		alert("고과년월을 확인 하십시요.");
		return false;
	}
	***/



  if(gcem_evaym.text!=gs_evaym){
		alert("고과년월을 확인 하십시요1.");
		return false;
	}

	
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
	gcds_mst.namevalue(gcds_mst.rowposition,"WRID") =gusrid;  
	gcds_mst.namevalue(gcds_mst.rowposition,"UPDT") =gs_date2;
	gcds_mst.namevalue(gcds_mst.rowposition,"UPID") =gusrid;  

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
  //@@@@
	gcds_chk.DataID = "/servlet/Person.h060020_s3?"
		               + "v_str1="+gcem_evaym.text
									 + "&v_str2="+ txt_empno2.value;
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
 
  
	// 나중에 막아야함.
	//if(gusrid=="6070001"||gusrid=="2040011"||gusrid=="2070037"||gusrid=="2040067"||gusrid=="2050018"||gusrid=="2070033"||gusrid=="2040001"||gusrid=="2050046"||gusrid=="6050005"){
  /*******
	if(gusrid=="6070001"){

	}else{
		alert("업적신고서 입력기간이 지나 입력이 불가합니다.");
		return false;
	}
	********/
	

  if(!ln_Save_Chk()) return;
	ifrm.ln_Save();
}


/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
function ln_Save_Chk() {

  /*** 임시막음.
  if(gusrid=="1990023"){//예외처리
  
	}else{
		if(gcem_evaym.text<="200906"){
			alert("입력기간이 지났습니다. 전산팀에 문의하십시요.");
			return false;
		}
	}

	***/

  //필수항목 체크

  if(gcem_evaym.text!=gs_evaym){
		alert("고과년월을 확인 하십시요2.");
		return false;
	}
	
	//예외처리시..
	/***
	if(txt_empno2.value!=gusrid){

	  //예외처리 금강산 수작업 입력으로 임시로 적용함. 
	  if(txt_empno2.value=="1990023"||txt_empno2.value=="1990080"||txt_empno2.value=="2000002"||txt_empno2.value=="2040014"
		 ||txt_empno2.value=="2040016"||txt_empno2.value=="2040040"||txt_empno2.value=="2050006"||txt_empno2.value=="2050053"||txt_empno2.value=="2070001"||txt_empno2.value=="2080023"){
			return true;
		}
		alert("저장할 수 없습니다. 전산팀에 문의하십시요.");
		return false;
	}

	***/
	/*
	if(gcem_evaym.text!="200811"){
		alert("고과년월을 확인 하십시요.");
		return false;
	}
	*/
 
  return true;
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


/******************************************************************************
	Description : 고과년월 찾기( 현재년월보다 아래로 )
  parameter   :
******************************************************************************/
function ln_Left(){
  //@@@
	gcds_yymm.DataID = "/servlet/Person.h060020_s5?v_str1=L&v_str2="+gcem_evaym.text+"&v_str3="+ txt_empno2.value;
	gcds_yymm.Reset();

	if(gcds_yymm.countrow>0&&gcds_yymm.namevalue(gcds_yymm.rowposition,"YYYYMM")!=""){
		gcem_evaym.text = gcds_yymm.namevalue(gcds_yymm.rowposition,"YYYYMM");
	}
}

/******************************************************************************
	Description : 고과년월 찾기 ( 현재년월보다 위로 ) 
  parameter   :
******************************************************************************/
function ln_Right(){
 //@@@
	gcds_yymm.DataID = "/servlet/Person.h060020_s5?v_str1=R&v_str2="+gcem_evaym.text+"&v_str3="+ txt_empno2.value;
	gcds_yymm.Reset();
   
	if(gcds_yymm.countrow>0&&gcds_yymm.namevalue(gcds_yymm.rowposition,"YYYYMM")!=""){
		gcem_evaym.text = gcds_yymm.namevalue(gcds_yymm.rowposition,"YYYYMM");
	}else{
    gcem_evaym.text = gcds_evaym.namevalue(gcds_evaym.rowposition,"MINORNM");
	}
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

<OBJECT id=gcds_evaym classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 고과년월 -->
</OBJECT>

<OBJECT id=gcds_term classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 고과기간 -->
</OBJECT>

<OBJECT id=gcds_yymm classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 고과년월 -->
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
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/h060020_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		  <img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand" onclick="ln_Print()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">
			<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()" >
		  <img src="../../Common/img/btn/com_b_save.gif" 		style="cursor:hand" onclick="ln_Save()">
		</td>
  </tr>
	<tr>
		<td COLSPAN=2>
			<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr> 
					<td width="120px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>&nbsp;&nbsp;고과년월&nbsp;</nobr></td>
					<td class="tab18"  style="width:80px;" ><nobr>&nbsp;
					<comment id="__NSID__">
						<object  id=gcem_evaym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:0px;top:3px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
						 </object></comment><script>__ws__(__NSID__);</script> 
						 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_evaym', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  
				 </td>
				 <td class="tab18"  style=""><nobr>&nbsp;
						<img src="../../Common/img/btn/com_btn_left.gif"	 style="cursor:hand;position:relative;top:3px" onclick="ln_Left()" >
						<img src="../../Common/img/btn/com_btn_right.gif"  style="cursor:hand;position:relative;top:3px" onclick="ln_Right()">
				 </td>
				 <td width="120px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;사번&nbsp;</nobr></td>
         <td class="tab18"  style=""><nobr>&nbsp;
						<input id="txt_empno2" name="txt_empno2" type="text"  class="txtbox"   style= "position:relative;left:3px;top:0px;width:55px;height:20px;" >	
				 </td>
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
					<!-- <td width="465px"  style="" bgcolor="#eeeeee" class="tab18" align=center colspan=3><nobr>인사이동사항 (대상기간 : 2007. 12. 01 ~ 2008. 05. 31)</nobr></td>					 -->
					<!-- <td width="465px"  style="" bgcolor="#eeeeee" class="tab18" align=center colspan=3><nobr>인사이동사항 (대상기간 : 2008. 06. 01 ~ 2008. 11. 30)</nobr></td>				 -->	
					<!-- <td width="465px"  style="" bgcolor="#eeeeee" class="tab18" align=center colspan=3><nobr>인사이동사항 (대상기간 : 2008. 12. 01 ~ 2009. 05. 31)</nobr></td>			 -->		

           <td width="465px"  style="" bgcolor="#eeeeee" class="tab18" align=center colspan=3><nobr>인사이동사항 (대상기간 :
              <input id="txt_term"  type="text"  ReadOnly>
							)
           </nobr></td>

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
											<param name=InheritColor  value=false>
						 </object></comment><script>__ws__(__NSID__);</script> 
					</nobr></td>
					<td class="tab18" style=""><nobr>
					   <input id="txt_place_1"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:150px;height:20px;" >
					</nobr></td>
					<td class="tab18" style=""><nobr>
					  <input id="txt_work_1"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:116px;height:20px;" >
					</nobr></td>

          <td class="tab18" style=""><nobr>
						<input id="txt_remark_1"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:115px;height:20px;" >
					</nobr></td>
				</tr>
				
				<tr>  
					
					<td class="tab18" style=""><nobr>
						<comment id="__NSID__">
						<object  id=gcem_startdt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
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
											<param name=InheritColor  value=false>
						 </object></comment><script>__ws__(__NSID__);</script> 
					</nobr></td>
					
					<td class="tab18" style=""><nobr>
							<input id="txt_place_2"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:150px;height:20px;" >
					</nobr></td>

					<td class="tab18" style=""><nobr>
            <input id="txt_work_2"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:116px;height:20px;" > 
          </nobr></td>
          
					<td class="tab18" style=""><nobr>
					    <input id="txt_remark_2"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:115px;height:20px;" >
					</nobr></td>
				</tr>
				<tr>  					
					<td class="tab18" style=""><nobr>
						<comment id="__NSID__">
						<object  id=gcem_startdt_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
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
											<param name=InheritColor  value=false>
						 </object></comment><script>__ws__(__NSID__);</script> 
					
					</nobr></td>
					
					<td class="tab18" style=""><nobr>
						 <input id="txt_place_3"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:150px;height:20px;" >
					</nobr></td>

					<td class="tab18" style=""><nobr>
						<input id="txt_work_3"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:116px;height:20px;" > 
					</nobr></td>
          
					<td class="tab18" style=""><nobr>
						 <input id="txt_remark_3"  type="text"     class="txtbox"  style= "position:relative;left:3px;top:0px;width:115px;height:20px;" >
					</nobr></td>
				</tr>
      </table>
		</td>
	</tr>
	<tr> 
    <td style="height:25px;position:relative;top:3px"><font color="blue"><b>2.업적신고서</b></font></td>
		<td width="685" align="right" style="padding-top:4px;">
			<img src="../../Common/img/btn/com_b_rowadd.gif"		style="cursor:hand" onclick="ln_Row_Add()">
		  <img src="../../Common/img/btn/com_b_rowdel.gif"		style="cursor:hand" onclick="ln_Row_Delete()">
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
		<iframe id="ifrm" name="ifrm" src="../../Person/html/H060020_ifrm.html" frameborder=0 style="position:relative;top:1px;width:872;height:330px;border:1 solid #708090;"></iframe>
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
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	