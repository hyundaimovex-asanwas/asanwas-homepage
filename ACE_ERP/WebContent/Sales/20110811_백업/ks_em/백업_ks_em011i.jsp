
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%	// ContextPath 및 기타 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	
	java.util.Calendar date = java.util.Calendar.getInstance();
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	String firstday = m_today.format(date.getTime());			
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 개성 로력 인사관리 - 발령관리
+ 프로그램ID : ks_em011i.jsp
+ 기능정의 : 
+ 작 성 자 : 이 동 훈
+ 작성일자 : 2008.09.04
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 :
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 : KS_Em011_S1
----------------------------------------------------------------------------------*/
%>
	 
    <link rel="stylesheet" href="../common/include/common.css">
</script>
<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script 시작
=============================================================================*/
%>
	<script language="javascript">
	
	get_cookdata();
	var useid = gusrid;
		
	//로컬에서 사용하기 위해 임의로 막음.
	/*
	var gs_date = gcurdate.substring(0,4)+gcurdate.substring(5,7)+gcurdate.substring(8,10);
	*/
	var gs_date ='<%=firstday%>';
	var year_date = gs_date.substring(2,4);
	var chk_tab = "";
	
	/*----------------------------------------------------------------------------
	 * 페이지로딩
	 ----------------------------------------------------------------------------*/
	function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

		fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]
		ln_before();//선조회

		//fnInit(); //초기화 함수
	}

	/*----------------------------------------------------------------------------
	* 데이타셋 헤더 설정	 
	----------------------------------------------------------------------------*/
	function fnSetHeader(){

	}
	/*----------------------------------------------------------------------------
	 * 선조회
	 ----------------------------------------------------------------------------*/
	function fnInit(){
	
		//*****  페이지 초기화 함수는 여기에..  ********
    
        cfStyleGrid(getObjectFirst("gr1"), "comn");	//그리드에 스타일 적용하는 부분. 1줄="comn";2줄="comn1"
    
        window.status = "<%=HDConstant.S_MSG_SEARCH_DATA%>"; //브라우저 상태창 수정.
	
	}

/*----------------------------------------------------------------------------
	Description : 팝업창
----------------------------------------------------------------------------*/
function ln_Find(){//성명조회

  var arrParam	= new Array();
	var strURL   = "./Per_com_pop.jsp";
	var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
	var arrResult = showModalDialog(strURL,window,strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		txt_empno.value = arrParam[0];
		txt_empnmk.value = arrParam[1];
	} else {
		txt_empno.value = "";
		txt_empnmk.value = "";
	}
}

/*----------------------------------------------------------------------------
	Description : 기본조회
	Parameter : 
----------------------------------------------------------------------------*/
function ln_Query(){

	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>KS_Em011_S1?"
											 + "v_str1="+fn_trim(txt_empno.value)
											 + "&v_str2="++fn_trim(txt_empnmk.value) 
											 + "&v_str3="gclx_dept_cd_s.bindcolval
                       						+ "&v_str4="+chk_s.value;

	gcds_data01.Reset();
	gcds_data02.ClearAll();
}


/*----------------------------------------------------------------------------
	Description : 선조회 조건
----------------------------------------------------------------------------*/
function ln_before(){

	//소속팀 검색  CM003
	//부서  CM006
	gcds_cm006_s.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM006";
	gcds_cm006_s.Reset();

	gcds_cm003_s.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM003";
	gcds_cm003_s.Reset();
  //입력
	//직종  CM004
	gcds_cm004.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM004";
	gcds_cm004.Reset();
	//근무업체  CM019
	gcds_cm019.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM019";
	gcds_cm019.Reset();
	//부서  CM006
	gcds_cm006.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM006";
	gcds_cm006.Reset();
	//소속팀  CM003
	gcds_cm003.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM003";
	gcds_cm003.Reset();
	//근무지  CM007
	gcds_cm007.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM007";
	gcds_cm007.Reset();
	//발령구분
	gcds_cm012.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM012";
	gcds_cm012.Reset();
	//기능구분
	gcds_cm013.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM013";
	gcds_cm013.Reset();
	//퇴직구분
	gcds_cm032.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM032";
	gcds_cm032.Reset();

	//퇴직구분
	gcds_cm032_g.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM032";
	gcds_cm032_g.Reset();

  //비용부담업체
	gcds_tsy010.DataID = "<%=dirPath%>/servlet/sales.bm.Company_pop_s01?v_str1="; 
	gcds_tsy010.Reset();

  ln_ChkBox_Chk(0);
	ln_ChkBox_Chk(1);
	ln_ChkBox_Chk(2);
	ln_ChkBox_Chk(3);
	ln_Enable2();
  gcem_ord_dt.text=gs_date;

}
/******************************************************************************
	Description : 거래처추가
******************************************************************************/
function ln_Add(){

}

/*****************************************************************************
	Description : 저장 
******************************************************************************/
function ln_Save(){
	if (gcds_data01.IsUpdated) {
		if(confirm("저장하시겠습니까?")){
			gctr_data.KeyValue = "Em011_t1(I:USER=gcds_data02)";
			gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em011_t1?";
			//prompt(this,gcds_data02.text);
			gctr_data.post();
		}			
	}
}
/******************************************************************************
	Description : 삭제 
******************************************************************************/
function ln_Del(){
	gcds_data02.DeleteRow(gcds_data02.rowposition);
}

/******************************************************************************
	Description : Loading Bar 
******************************************************************************/
function ln_Start_Load(){
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
  document.all.LowerFrame.style.visibility="visible";
}

/******************************************************************************
	Description : Loading Bar 
******************************************************************************/
function ln_End_Load(row,cnt){
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	eval(cnt).innerText = "조회건수 : " + row + " 건";
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
	}
}

/******************************************************************************
	Description : 발령대상자 선택 후 발령생성
******************************************************************************/
function ln_Order(){
  var chk=0;
	if(!ln_Order_Chk()) return;
	ln_SetDataHeader();
	for(i=1;i<=gcds_data01.countrow;i++){
		if(gcds_data01.namevalue(i,"CHK")=="T"){
			chk = 1;
			gcds_data02.addrow();
			//기존데이타 복사.
			gcds_data02.namevalue(gcds_data02.rowposition,"EMPNO") = gcds_data01.namevalue(i,"EMPNO");
			gcds_data02.namevalue(gcds_data02.rowposition,"EMPNMK") = gcds_data01.namevalue(i,"EMPNMK");
			gcds_data02.namevalue(gcds_data02.rowposition,"VEND_CD") = gcds_data01.namevalue(i,"VEND_CD");
			gcds_data02.namevalue(gcds_data02.rowposition,"VEND_NM") = gcds_data01.namevalue(i,"VEND_NM");
			gcds_data02.namevalue(gcds_data02.rowposition,"DEPT_CD") = gcds_data01.namevalue(i,"DEPT_CD");
			gcds_data02.namevalue(gcds_data02.rowposition,"DEPT_NM") = gcds_data01.namevalue(i,"DEPT_NM");
			gcds_data02.namevalue(gcds_data02.rowposition,"TEAM_CD") = gcds_data01.namevalue(i,"TEAM_CD");
			gcds_data02.namevalue(gcds_data02.rowposition,"TEAM_NM") = gcds_data01.namevalue(i,"TEAM_NM");
			gcds_data02.namevalue(gcds_data02.rowposition,"WORK_CD") = gcds_data01.namevalue(i,"WORK_CD");
			gcds_data02.namevalue(gcds_data02.rowposition,"WORK_NM") = gcds_data01.namevalue(i,"WORK_NM");
			gcds_data02.namevalue(gcds_data02.rowposition,"SKILL_CD") = gcds_data01.namevalue(i,"SKILL_CD");
			gcds_data02.namevalue(gcds_data02.rowposition,"SKILL_NM") = gcds_data01.namevalue(i,"SKILL_NM");
			gcds_data02.namevalue(gcds_data02.rowposition,"JOB_CD") = gcds_data01.namevalue(i,"JOB_CD");
			gcds_data02.namevalue(gcds_data02.rowposition,"JOB_NM") = gcds_data01.namevalue(i,"JOB_NM");
			gcds_data02.namevalue(gcds_data02.rowposition,"CUST_SID") = gcds_data01.namevalue(i,"CUST_SID");
			gcds_data02.namevalue(gcds_data02.rowposition,"C_VEND_CD") = gcds_data01.namevalue(i,"C_VEND_CD");
			gcds_data02.namevalue(gcds_data02.rowposition,"C_VEND_NM") = gcds_data01.namevalue(i,"C_VEND_NM");
			gcds_data02.namevalue(gcds_data02.rowposition,"I_EMPNO") = gusrid;
			gcds_data02.namevalue(gcds_data02.rowposition,"U_EMPNO") = gusrid;

			//******************************신규발령을 추가한다.
			//발령구분
      gcds_data02.namevalue(gcds_data02.rowposition,"ORD_CD") = gclx_ord_cd.bindcolval;
			gcds_data02.namevalue(gcds_data02.rowposition,"ORD_NM") = gclx_ord_cd.text;
			//발령일자
      gcds_data02.namevalue(gcds_data02.rowposition,"ORD_DT") = gcem_ord_dt.text;
			
      //
      if(chk1.checked){ 
				//근무업체
				gcds_data02.namevalue(gcds_data02.rowposition,"VEND_CD")=gclx_vend_cd.bindcolval;
				gcds_data02.namevalue(gcds_data02.rowposition,"VEND_NM")=gclx_vend_cd.text;
			  //부서
				gcds_data02.namevalue(gcds_data02.rowposition,"DEPT_CD")=gclx_dept_cd.bindcolval;
				gcds_data02.namevalue(gcds_data02.rowposition,"DEPT_NM")=gclx_dept_cd.text;
		 	  //소속팀
				gcds_data02.namevalue(gcds_data02.rowposition,"TEAM_CD")=gclx_team_cd.bindcolval;
				gcds_data02.namevalue(gcds_data02.rowposition,"TEAM_NM")=gclx_team_cd.text;
			  //근무지
				gcds_data02.namevalue(gcds_data02.rowposition,"WORK_CD")=gclx_work_cd.bindcolval;
				gcds_data02.namevalue(gcds_data02.rowposition,"WORK_NM")=gclx_work_cd.text;
				//비용업체
				gcds_data02.namevalue(gcds_data02.rowposition,"C_VEND_CD")=gclx_c_vend_cd.bindcolval;
				gcds_data02.namevalue(gcds_data02.rowposition,"C_VEND_NM")=gclx_c_vend_cd.text;
			}

      if(chk2.checked){
				//발령직종
				gcds_data02.namevalue(gcds_data02.rowposition,"JOB_CD")=gclx_job_cd.bindcolval;
				gcds_data02.namevalue(gcds_data02.rowposition,"JOB_NM")=gclx_job_cd.text;
				//기능구분
				gcds_data02.namevalue(gcds_data02.rowposition,"SKILL_CD")=gclx_skill_cd.bindcolval;
				gcds_data02.namevalue(gcds_data02.rowposition,"SKILL_NM")=gclx_skill_cd.text;
			} 	
			
			if(gclx_ord_cd.bindcolval=="007"){ //퇴사일경우
				gcds_data02.namevalue(gcds_data02.rowposition,"RETGB") = gclx_retgb_cd.bindcolval;
				if(blchk.checked==true){
					blchk.value="Y";
				}else{
					blchk.value="";
				}
				gcds_data02.namevalue(gcds_data02.rowposition,"BLCHK") = blchk.value;
			}
		}
	}
	
	if(chk==0){
		alert("발령대상자를 선택하십시요.");
	}
}


/******************************************************************************
	Description : 발령 체크

******************************************************************************/
function ln_Order_Chk(){
	
  if(gclx_ord_cd.bindcolval=="007"){ //퇴사일경우 체크안함.
		if(gclx_retgb_cd.bindcolval==""){
			alert("귀국구분을 선택하십시요.");
			return false;
		}
	}else{
		if(chk1.value !="T"&&chk2.value!="T"){
			alert("부서선택 또는 직종선택을 먼저 선택하십시요.");
			return false;
		}

		if(chk1.value=="T"){
			if(gclx_vend_cd.bindcolval==""){
				alert("근무업체를 먼저 선택하십시요.");
				return false;
			}

			if(gclx_dept_cd.bindcolval==""){
				alert("부서를 먼저 선택하십시요.");
				return false;
			}

			if(gclx_team_cd.bindcolval==""){
				alert("소속팀을 먼저 선택하십시요.");
				return false;
			}

      if(gclx_c_vend_cd.bindcolval==""){
				alert("비용업체를 먼저 선택하십시요.");
				return false;
			}
		}
		
		if(chk2.value=="T"){
			if(gclx_job_cd.bindcolval==""){
				alert("발령직종을 먼저 선택하십시요.");
				return false;
			}
		}
	}
	return true;
}


/******************************************************************************
	Description : 발령 데이타 셋 헤드 설정
******************************************************************************/
function ln_SetDataHeader(){
	if (gcds_data02.countrow<1){
		var s_temp = " EMPNO:STRING(10),EMPNMK:STRING(30),ORD_DT:STRING(8),ORD_CD:STRING(3),ORD_NM:STRING(50),"
							 + " VEND_CD:DECIMAL(10),VEND_NM:STRING(50),DEPT_CD:STRING(5),DEPT_NM:STRING(50),TEAM_CD:STRING(5),"
							 + " TEAM_NM:STRING(50),WORK_CD:STRING(5),WORK_NM:STRING(50),SKILL_CD:STRING(3),SKILL_NM:STRING(50),"
							 + " JOB_CD:STRING(5),JOB_NM:STRING(50),SEQ:DECIMAL(2),CUST_SID:DECIMAL(10),"
							 + " I_EMPNO:STRING(10),I_DATE:STRING(10),U_EMPNO:STRING(10),U_DATE:STRING(10),"
							 + " C_VEND_CD:DECIMAL(10),C_VEND_NM:STRING(62),RETGB:STRING(2),BLCHK:STRING(1)";
		gcds_data02.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : 체크박스선택
	Parameter   : gbn  0 - 검색조건 퇴사자
	                   1 - 부서관련
								     2 - 직종관련
										 3 - black list
******************************************************************************/
function ln_ChkBox_Chk(gbn){
	if(gbn==0){
		if(chk_s.checked) {
			chk_s.value = '3';
		}else {
			chk_s.value = '1'
    }
	}else if(gbn==1){
		if(chk1.checked) {
			chk1.value = 'T';
			ln_Enable(gbn,true);
		}else {
			chk1.value = ''
			ln_Enable(gbn,false);
			gclx_vend_cd.index = 0;
			gclx_dept_cd.index = 0;
			gclx_team_cd.index = 0;
			gclx_work_cd.index = 0;
			gclx_c_vend_cd.index = 0;
		}
	}else if(gbn==2){
    if(chk2.checked) {
			chk2.value = 'T';
			ln_Enable(gbn,true);
		}else {
			chk2.value = ''
			ln_Enable(gbn,false);
      gclx_job_cd.index = 0;
		  gclx_skill_cd.index = 0;
		}
	}else if(gbn==3){
    if(gclx_ord_cd.bindcolval=="007"){ //퇴사자
      ln_Enable(gbn,true);
		}else{ //퇴사자가 아닌 경우
		  ln_Enable(gbn,false);
			gclx_retgb_cd.bindcolval ="";
		}
	}
}

/*=============================================================================
		Description : 발령 관련 럭스콤보 사용유무
=============================================================================*/
function ln_Enable(gbn,gbn2){
	if(gbn==1){ //
		gclx_vend_cd.Enable = gbn2;
		gclx_dept_cd.Enable = gbn2;
		gclx_team_cd.Enable = gbn2;
		gclx_work_cd.Enable = gbn2;
		gclx_c_vend_cd.Enable = gbn2;
	}else if(gbn==2){
    gclx_job_cd.Enable = gbn2;
		//gclx_skill_cd.Enable = gbn2;
		gclx_skill_cd.Enable = false;
	}else if(gbn==3){
    gclx_retgb_cd.Enable = gbn2;
		if(gbn2==false){
			blchk.disabled=true;
		}else{
      blchk.disabled=false;
		}
	}
}

/*=============================================================================
		Description : 귀국구분에 대한 사용유무
=============================================================================*/
function ln_Enable2(){
	if(gclx_retgb_cd.bindcolval=="01"){       //만기
		blchk.checked =false;
		blchk.disabled=false;
		blchk.value="";
  }else if(gclx_retgb_cd.bindcolval=="02"){ //조기
    blchk.checked =true;
		blchk.disabled=true;
		blchk.value="Y";
	}else if(gclx_retgb_cd.bindcolval=="03"){ //징계
    blchk.checked =true;
		blchk.disabled=true;
		blchk.value="Y";
	}else{
		blchk.checked =false;
		blchk.disabled=true;
		blchk.value="";
	}
}

/*----------------------------------------------------------------------------
	Description : 엑셀
----------------------------------------------------------------------------*/
function ln_Excel(){
    var szName1 = "발령대상자선택";
    //var szName2 = "발령";
    var szPath = "C:\\Test\\em011i.xls";
       if (gcds_data01.countrow<1){
          alert("다운로드 하실 자료가 없습니다");
       }
       else{
          gcgd_disp.GridToExcel(szName1,szPath,2);
          //gcgd_disp2.RunExcelSheet(szName2,szPath,2)
       }
   }
</script>
<%
/*=============================================================================
				Developer Java Script 끝
=============================================================================*/
%>
    
<%
/*=============================================================================
			Gauce Components Event Scripts 시작
=============================================================================*/
%>
<script language=JavaScript for=gclx_job_cd event=OnSelChange()>
	for(i=1;i<=gcds_cm013.countrow;i++){
		if(gcds_cm013.namevalue(i,"COM_CODE")==gcds_cm004.namevalue(gcds_cm004.rowposition,"ITEM2")){
      gclx_skill_cd.index=i-1;
			break;
		}
	}
</script>

<script language=JavaScript for=gclx_ord_cd event=OnSelChange()>
	if(gclx_ord_cd.bindcolval=="007"){ //퇴사
		ln_Enable('3',true);
		gclx_retgb_cd.index=1;
  }else{
    ln_Enable('3',false);
		gclx_retgb_cd.index=0;
	}
</script>

<script language=JavaScript for=gclx_retgb_cd event=OnSelChange()>
	ln_Enable2();
</script>
<%
/*=============================================================================
			Gauce Components Event Scripts 끝
=============================================================================*/
%>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts 시작
=============================================================================*/

///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공-TR1
%>
	<script language="javascript" for="gctr_data" event="onsuccess()">
		 alert("저장에 성공하였습니다");
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패-TR1
%>
<script language="javascript" for="gctr_data" event="onfail()">
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	ln_Start_Load()
</script>
<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	ln_End_Load(row,"ft_cnt1");
</script>

<script language="javascript" for="gcds_cm006_s" event="onloadCompleted(row,colid)">
	ln_Insert_Row(2,"gcds_cm006_s","gclx_dept_cd_s");
</script>

<script language="javascript" for="gcds_cm003_s" event="onloadCompleted(row,colid)">
	ln_Insert_Row(2,"gcds_cm003_s","gclx_team_cd_s");
</script>

<script language="javascript" for="gcds_cm004" event="onloadCompleted(row,colid)">
   ln_Insert_Row(1,"gcds_cm004","gclx_job_cd"); 
</script>

<script language="javascript" for="gcds_cm019" event="onloadCompleted(row,colid)">
    ln_Insert_Row(1,"gcds_cm019","gclx_vend_cd");
</script>

<script language="javascript" for="gcds_cm006" event="onloadCompleted(row,colid)">
    ln_Insert_Row(1,"gcds_cm006","gclx_dept_cd");
</script>

<script language="javascript" for="gcds_cm003" event="onloadCompleted(row,colid)">
    ln_Insert_Row(1,"gcds_cm003","gclx_team_cd");
</script>

<script language="javascript" for="gcds_cm007" event="onloadCompleted(row,colid)">
    ln_Insert_Row(1,"gcds_cm007","gclx_work_cd");
</script>

<script language="javascript" for="gcds_cm013" event="onloadCompleted(row,colid)">
    ln_Insert_Row(1,"gcds_cm013","gclx_skill_cd");
</script>

<script language="javascript" for="gcds_tsy010" event="onloadCompleted(row,colid)">
    ln_Insert_Row(1,"gcds_tsy010","gclx_c_vend_cd");
</script>

<script language="javascript" for="gcds_cm032" event="onloadCompleted(row,colid)">
    ln_Insert_Row(1,"gcds_cm032","gclx_retgb_cd");
</script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts 끝
=============================================================================*/
%>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts 시작
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
	</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts 끝
=============================================================================*/
%>


<%
/*=============================================================================
			DataSet Components(DS) 선언 시작
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- 직종 -->
<OBJECT id=gcds_cm004 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- 근무업체 -->
<OBJECT id=gcds_cm019 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- 부서 -->
<OBJECT id=gcds_cm006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- 소속팀 -->
<OBJECT id=gcds_cm003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- 근무지 -->
<OBJECT id=gcds_cm007 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- 발령구분 -->
<OBJECT id=gcds_cm012 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>'
<!-- 기능구분-->
<OBJECT id=gcds_cm013 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- 귀국구분-->
<OBJECT id=gcds_cm032 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_cm032_g classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- 소속팀 _ 검색 -->
<OBJECT id=gcds_cm003_s classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm006_s classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_tsy010 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><object id="gctr_data" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object><%=HDConstant.COMMENT_END%>
<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>

</head>
<body>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black border=0><!-- body table -->
	<tr height="20px"><!-- 버튼 영역 시작-->
		<td align="left" colspan="3">
			<table width="820" border="0"  cellspacing="0" cellpadding="0">
				<tr>
					<td align="right" height="30px">		
						<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()">
						<img src="<%=dirPath%>/Sales/images/excel.gif"   	style="cursor:hand" onclick="ln_Excel()">
					</td>
				</tr>																		
			</table>
		</td>
	 </tr>
	 <tr height=20><!-- 조회 영역 시작-->
		<td>
			<table cellpadding=0 cellspacing=1 style="width:824px;height:20px;" bgcolor="#708090">
				<tr>
				  <td bgcolor="#eeeeee" width="70" align = center>부서</td>
					<td bgcolor="#FFFFFF">
					
									<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
									<%=HDConstant.COMMENT_START%>
									<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										class="gcem_01" style="width:90px;  height: 16px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=Format	      value="">
											<param name=PromptChar	  value="">
											<param name=UpperFlag     value=1>
											<param name=GeneralEdit   value="true">
											<param name=Enable        value="false">
									</OBJECT><%=HDConstant.COMMENT_END%>
									</fieldset>											
								 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
								</td>
								<td bgcolor="#eeeeee" width="70" align = center>소속팀</td>
								<td bgcolor="#FFFFFF">
								<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
								<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
									class="gcem_01" style="width:90px;  height: 16px;">
										<param name=Alignment			value=0>
										<param name=Border	      value=false>
										<param name=Format	      value="">
										<param name=PromptChar	  value="">
										<param name=UpperFlag     value=1>
										<param name=GeneralEdit   value="true">
										<param name=Enable        value="false">
								</OBJECT><%=HDConstant.COMMENT_END%>
								</fieldset>											
							 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
							</td>

					<td align="center" width="70" bgcolor="#eeeeee">성명</td>
					<td bgcolor="#FFFFFF">
					  <input type="text" id="txt_empnmk" style="position:relative;width:80px;left:2px;  top:0px;">&nbsp;
						<img src="<%=dirPath%>/Sales/images/help.gif" alt="성명을 검색합니다" style="position:relative;left:2px;  top:1px; cursor:hand;" onclick="ln_Find()">
					  <input type="text" id="txt_empno" style="position:relative;left:2px;  top:1px; width:80px;">&nbsp;
					</td>
					<td align="center" width="70" bgcolor="#eeeeee">퇴사자</td>
					<td bgcolor="#FFFFFF" width="70">
						<input type="checkbox" id=chk_s   value=""    style="position:relative;left:5px;top:0px;cursor:hand;width:20px" onClick="ln_ChkBox_Chk(0)" >
					</td>
				</tr>
			</table>
		  </td>
	    </tr>
		<tr>
			<td>
				<table cellpadding=0 cellspacing=1 style="width:290px;">
					<tr>
						<td valign="top">
							<font style="position:relative;top:0px;left:0px; color=#0000FF"><b>[발령대상자 선택]</b></font>
							<table cellpadding=0 cellspacing=1 style="width:409px;" bgcolor="#708090">
								<tr>
									<td bgcolor="#FFFFFF">
										<%=HDConstant.COMMENT_START%>
										<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:405;height:380px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
										<PARAM NAME="DataID"	  VALUE="gcds_data01">
										<PARAM NAME="BorderStyle" VALUE="0">
										<PARAM NAME="Indwidth"	  VALUE="0">
										<PARAM NAME="Fillarea"	  VALUE="true">
										<param name="sortview"    value=left>
										<param name="colsizing"   value=true> 
										<param name=Editable      value="true">
										<PARAM NAME="Format"	  VALUE="  
										<FC>ID=CurRow,	Name=순번,		width=30,  	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center  edit=none value={CurRow}</FC>
										<FC>ID=CHK,		  Name=선택,		width=30,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, EditStyle='CheckBox'</FC>
										<FC>ID=EMPNO,	  Name=사번,		width=55,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none sort = true</FC>
										<FC>ID=EMPNMK,	Name=성명,		width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</FC>
										<C>ID=VEND_NM,	Name=근무업체,width=90,  	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</C>
										<C>ID=DEPT_NM,	Name=부서명,	width=90,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</C>
										<C>ID=TEAM_NM,	Name=소속명,	width=90,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</C>
										<C>ID=WORK_NM,	Name=근무지,	width=90,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</C>
										<C>ID=SKILL_NM, Name=기능명,	width=90,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</C>
										<C>ID=JOB_NM,	  Name=직종명,	width=90,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</C>
										<C>ID=C_VEND_NM,	  Name=비용부담업체,width=100,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</C>
										">
										</OBJECT><%=HDConstant.COMMENT_END%>
										<fieldset style="width:407;height:20px;;border:0 solid #708090;border-top-width:1px;text-align:left;">
										&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
										</fieldset>
									</td>
								</tr>
							</table>
						</td>
						<td valign="top"><!-- 우측테이블 시작 -->
							<table cellpadding=0 cellspacing=1 style="width:410px;height:20px;">
								<tr>
									<td align="left"><nobr>
										<font style="position:relative;top:-10px;left:0px; color=#0000FF"><b>[발령]</b></font>&nbsp;
										<input type="checkbox" id=chk1   value=""        style="position:relative;top:-4px;cursor:hand;width:20px" onClick="ln_ChkBox_Chk(1)">
                    					<input type="text"		 id=chknm1 value="부서선택"  style="position:relative;top:-4px;width:55px;border-width:0px" >
										<input type="checkbox" id=chk2   value=""          style=" position:relative;top:-4px;cursor:hand;width:20px" onClick="ln_ChkBox_Chk(2)">
                    					<input type="text"		 id=chknm2 value="직종선택"  style="position:relative;top:-4px;width:55px;border-width:0px" >
										<img src="<%=dirPath%>/Sales/images/n_create.gif"	style="cursor:hand" onclick="ln_Order()">
										<img src="<%=dirPath%>/Sales/images/minus.gif"     style="cursor:hand" onClick="ln_Del()" >		
										<img src="<%=dirPath%>/Sales/images/save.gif"		  style="cursor:hand" onClick="ln_Save()">
										<!-- <img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()"> -->
										</nobr>
									</td>
								</tr>
								<tr>
									<td>
										<table cellpadding=0 cellspacing=1 style="width:410px;height:100px;" bgcolor="#708090">
											<tr height="22">
												<td bgcolor="#eeeeee" align="center">발령구분</td>
												<td bgcolor="#FFFFFF">
													<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
														class="gcem_01" style="width:90px;  height: 16px;">
															<param name=Alignment			value=0>
															<param name=Border	      value=false>
															<param name=Format	      value="">
															<param name=PromptChar	  value="">
															<param name=UpperFlag     value=1>
															<param name=GeneralEdit   value="true">
															<param name=Enable        value="false">
													</OBJECT><%=HDConstant.COMMENT_END%>
													</fieldset>											
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
												</td>
												
												<td bgcolor="#eeeeee" align="center">발령일자</td>
												<td bgcolor="#FFFFFF">
													<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
														class="gcem_01" style="width:90px;  height: 16px;">
															<param name=Alignment			value=0>
															<param name=Border	      value=false>
															<param name=Format	      value="">
															<param name=PromptChar	  value="">
															<param name=UpperFlag     value=1>
															<param name=GeneralEdit   value="true">
															<param name=Enable        value="false">
													</OBJECT><%=HDConstant.COMMENT_END%>
													</fieldset>											
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
												</td>
											</tr>
											<tr height="22">
												<td bgcolor="#eeeeee" align="center">근무업체</td>
												<td bgcolor="#FFFFFF">
													<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
														class="gcem_01" style="width:90px;  height: 16px;">
															<param name=Alignment			value=0>
															<param name=Border	      value=false>
															<param name=Format	      value="">
															<param name=PromptChar	  value="">
															<param name=UpperFlag     value=1>
															<param name=GeneralEdit   value="true">
															<param name=Enable        value="false">
													</OBJECT><%=HDConstant.COMMENT_END%>
													</fieldset>											
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
												</td>
												<td bgcolor="#eeeeee" align="center">부서</td>
												<td bgcolor="#FFFFFF">
													<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
														class="gcem_01" style="width:90px;  height: 16px;">
															<param name=Alignment			value=0>
															<param name=Border	      value=false>
															<param name=Format	      value="">
															<param name=PromptChar	  value="">
															<param name=UpperFlag     value=1>
															<param name=GeneralEdit   value="true">
															<param name=Enable        value="false">
													</OBJECT><%=HDConstant.COMMENT_END%>
													</fieldset>											
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
												</td>
											</tr>
											<tr height="22">
												<td bgcolor="#eeeeee" align="center">소속팀</td>
												<td bgcolor="#FFFFFF">
													<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
														class="gcem_01" style="width:90px;  height: 16px;">
															<param name=Alignment			value=0>
															<param name=Border	      value=false>
															<param name=Format	      value="">
															<param name=PromptChar	  value="">
															<param name=UpperFlag     value=1>
															<param name=GeneralEdit   value="true">
															<param name=Enable        value="false">
													</OBJECT><%=HDConstant.COMMENT_END%>
													</fieldset>											
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
												</td>
												<td bgcolor="#eeeeee" align="center">근무지</td>
												<td bgcolor="#FFFFFF">
													<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
														class="gcem_01" style="width:90px;  height: 16px;">
															<param name=Alignment			value=0>
															<param name=Border	      value=false>
															<param name=Format	      value="">
															<param name=PromptChar	  value="">
															<param name=UpperFlag     value=1>
															<param name=GeneralEdit   value="true">
															<param name=Enable        value="false">
													</OBJECT><%=HDConstant.COMMENT_END%>
													</fieldset>											
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
												</td>
											</tr>
											<tr height="22">
												<td bgcolor="#eeeeee" align="center">비용업체</td>
												<td bgcolor="#FFFFFF">
													<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
														class="gcem_01" style="width:90px;  height: 16px;">
															<param name=Alignment			value=0>
															<param name=Border	      value=false>
															<param name=Format	      value="">
															<param name=PromptChar	  value="">
															<param name=UpperFlag     value=1>
															<param name=GeneralEdit   value="true">
															<param name=Enable        value="false">
													</OBJECT><%=HDConstant.COMMENT_END%>
													</fieldset>											
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
												</td>
												<td bgcolor="#eeeeee" align="center">직종</td>
												<td bgcolor="#FFFFFF">
													<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
														class="gcem_01" style="width:90px;  height: 16px;">
															<param name=Alignment			value=0>
															<param name=Border	      value=false>
															<param name=Format	      value="">
															<param name=PromptChar	  value="">
															<param name=UpperFlag     value=1>
															<param name=GeneralEdit   value="true">
															<param name=Enable        value="false">
													</OBJECT><%=HDConstant.COMMENT_END%>
													</fieldset>											
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
												</td>

											</tr>
										</table><!-- 우측 테이블 1단 끝 -->
									</td>
								</tr>
								<tr>
									<td>
										<table cellpadding=0 cellspacing=1  style="width:390px;height:290px;" bgcolor="#708090">
											<tr>
												<td bgcolor="#FFFFFF">
													<%=HDConstant.COMMENT_START%>
													<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp2 style="width:405;height:249px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
													<PARAM NAME="DataID"		VALUE="gcds_data02">
													<PARAM NAME="BorderStyle"   VALUE="0">
													<PARAM NAME="Indwidth"		VALUE="0">
													<PARAM NAME="Fillarea"		VALUE="true">
													<param name="colsizing"   value=true> 
													<param name="sortview"      value=left>
													<PARAM NAME="Format"		VALUE="  
													<C>ID=EMPNO,	  Name=사번,		  width=55,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
													<C>ID=EMPNMK,	  Name=성명,		  width=60,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													<C>ID=ORD_NM,	  Name=발령구분,	width=72,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													<C>ID=ORD_DT, 	Name=발령일자,	width=72,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true mask='XXXX/XX/XX'</C>
													<C>ID=VEND_NM,	Name=근무업체,	width=72,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													<C>ID=DEPT_NM,	Name=부서,		  width=70,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													<C>ID=TEAM_NM,	Name=소속팀,	  width=70,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													<C>ID=WORK_NM,	Name=근무지,	  width=70,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													<C>ID=JOB_NM,	  Name=직종,	    width=70,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													<C>ID=SKILL_NM,	Name=기능구분	  width=70,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													<C>ID=C_VEND_NM,Name=비용업체	  width=120, HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													">
													</OBJECT><%=HDConstant.COMMENT_END%>
													<fieldset style="width:408;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
														&nbsp;<font id=ft_cnt2 style="position:relative;top:4px;"></font>
													</fieldset>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table><!-- 우측 테이블 끝 -->
						</td>
					</tr>
				</table>
			</td>
		</tr>
</table>


<!--------------------------------- 코딩 부분 끝 -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
</body>
</html>
