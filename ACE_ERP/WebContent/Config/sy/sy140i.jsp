<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 전체 메뉴 조회 및 권한 요청!
 * 프로그램ID  	: SY140I
 * J  S  P   	: Sy140i
 * 서 블 릿     : Sy120I
 * 작 성 자     : 차태주
 * 작 성 일     : 2006-09-10
 * 기능정의     : 메뉴조회 권한 요청
 * [ 수정일자 ][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMddHHmm");
   String firstday = m_today.format(date.getTime()).substring(0,8);
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
        <script language=javascript src="<%=dirPath%>/Sales/common/js/cu010i.js"></script>
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>	
<script language="javascript">
    var v_job = "H";

    var v_Main_row = 0;

   //페이지로딩
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		fnInit();
		fnSelect();
	}
	
   //선조회
   function fnInit(){
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        cfStyleGrid(getObjectFirst("gr2"), "comn");
        
		fnSetHeader(); //ds2 헤더셋팅 
		
 		//작업상태1
        ds_status1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_Item1=Y";
        ds_status1.Reset();
 		
   }

   /*
    * 메인조회
    */
    function fnSelect() {
      if (ds1.isUpdated) {
         alert("수정중인 행이 있습니다.");
            return;
      } else {
		v_job = "S";
           window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
           var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1";

           ln_TRSetting(tr1,
               "<%=dirPath%><%=HDConstant.PATH_SY%>Sy140I",
               "JSP(O:Main=ds1,O:Sub=ds2)",
               v_param);
           tr_post(tr1);
       }
    }


	// 취소
	function fnCancel() {
        ds2.undoall();
		window.status="데이터 변경이 취소되었습니다.";
		return;		
	}

	//저장 (신규메뉴 권한 신청)- 관리자가 확인 후 실제로 저장해주는 것.. 엄청 피곤할지도.. ;;
	function fnApply() {
		if (ds2.IsUpdated) {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_SY%>Sy140I",
			    "JSP(I:DS2=ds2,O:RESULT=ds_result)",
			    param);
			   
			tr_post(tr1);  
			
			fnSelect();
		} else {
			alert("수정된 객실이 없습니다.");
		};
	}


	// 엑셀
	function fnExcelDs1() {
		if(ds1.RowCount==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        } 
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:메뉴목록조회; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("메뉴목록조회","메뉴목록조회.xls", 8);
	}

	// 데이타셋 헤더 설정
	function fnSetHeader(){
		if (ds2.countrow < 1){
			var s_temp1 = "AUTH_RQ:STRING,TREE_IDX:INTEGER,TREE_NM4:STRING,U_DATE:STRING";
			
			ds2.SetDataHeader(s_temp1);
		}
	}

</script>

<%
/*=============================================================================
         Gauce Components Event Scripts
=============================================================================*/
%>

<%
/*=============================================================================
         Transaction Component's Event Message Scripts
=============================================================================*/
%>

<script language="javascript" for="tr1" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr1" event="OnFail()">
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
</script>

<script language="javascript" for="tr2" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    var info_cnt = tr2.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="")
        alert("============= 안내 메시지=============\n\n" + info_msg);
</script>


<%
/*=============================================================================
         DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=javascript for=ds2 event="OnLoadCompleted(Row)">
    if(Row==0) return;
</script>

<script language=javascript for="gr1" event="OnDblClick(Row, Colid)">
    if(Row<1) return;
	
	if(ds1.namevalue(Row,"TREE_LV")=="4" && "F"==ds1.namevalue(Row,"AUTH_RQ") ){
		if(ds2.countrow>0){
			var exsts ="n";
	    	for (i = 1; i <= ds2.countrow; i++) {//ds2 루프 
	    		if(ds2.namevalue(i,"TREE_IDX")==ds1.namevalue(Row, "TREE_IDX")) {
	 	   			alert("이미 요청된 메뉴입니다.");
	 	   			exsts ="y";
	 	   			return;
	 	   		};
			};
			
			if(exsts="n"){
				ds2.addRow();
				ds2.namevalue(ds2.rowposition,"AUTH_RQ") 	= "RR";
				ds2.namevalue(ds2.rowposition,"TREE_IDX") 	= ds1.namevalue(Row, "TREE_IDX");
				ds2.namevalue(ds2.rowposition,"TREE_NM4") 	= ds1.namevalue(Row, "TREE_NM4");
				ds2.namevalue(ds2.rowposition,"U_DATE") 	= "<%=firstday%>";
	    	};
	    }else{
				ds2.addRow();
				ds2.namevalue(ds2.rowposition,"AUTH_RQ") 	= "RR";
				ds2.namevalue(ds2.rowposition,"TREE_IDX") 	= ds1.namevalue(Row, "TREE_IDX");
				ds2.namevalue(ds2.rowposition,"TREE_NM4") 	= ds1.namevalue(Row, "TREE_NM4");
				ds2.namevalue(ds2.rowposition,"U_DATE") 	= "<%=firstday%>";
	    };
	}else{
		alert("4레벨이고 권한이 없는 메뉴만 가능합니다.");
	}


</script>

<%
/*=============================================================================
         DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_status1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		


<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
	<td>
		<table border="0" width="845px"  cellpadding="0" cellspacing="0">
		  <tr>
			<td align="right" colspan="2">
				<table border="0"  cellpadding="0" cellspacing="0" width="100%">
				  <tr>
					<td align="right" height="30px">
					    <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
						<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
						<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">		<!-- 엑셀 -->					    
						<img src="<%=dirPath%>/Sales/images/save.gif"  	style="cursor:hand"	align=absmiddle onclick="fnApply()">
					</td>
				  </tr>
				</table>
			</td>
		  </tr>
		  <tr>
			<td height='5px'></td>
		  </tr>
		  <tr>
			<td width="845px" colspan='2'>
				<table  border="0" cellpadding="0" cellspacing="0" >
				  <tr valign="top"">
					<td width=535>■ 전체 메뉴 리스트<br>
					    <%=HDConstant.COMMENT_START%>
					    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=535px; height:360px" border="1">
					        <param name="DataID"            value="ds1">
					        <param name="BorderStyle"       value="0">
					        <param name="ColSizing"         value="true">
					        <param name="editable"          value="false">
					        <Param Name="UsingOneClick"     value="1">
					        <Param Name="AllShowEdit"       value="True">
					        <param name="SuppressOption"    value="1">
					        <param name="ViewSummary"    value="1">
					        <param name="Format"            value="
					            <C> name='권한'      	ID='AUTH_RQ'   Width=40  align=center EditStyle=CheckBox Sumtext=계</C>
					            <C> name='레벨'     	ID='TREE_LV'   Width=40  align=center Sumtext=@cnt</C>
					            <C> name='메뉴ID'       ID='TREE_ID'      Width=60  align=left </C>
					            <C> name='메뉴번호'     ID='TREE_IDX'     Width=60  align=center </C>
					            <C> name='메뉴명1'      ID='TREE_NM1'     Width=70  align=left suppress=1</C>
					            <C> name='메뉴명2'      ID='TREE_NM2'     Width=70  align=left suppress=2</C>
					            <C> name='메뉴명3'      ID='TREE_NM3'     Width=70  align=left suppress=3</C>
					            <C> name='메뉴명4'      ID='TREE_NM4'     Width=100  align=left </C>
					        ">
					    </object>
					    <%=HDConstant.COMMENT_END%>
					</td>
					<td width=10></td>					
					<td width=300>■ 권한 요청<br>
					    <%=HDConstant.COMMENT_START%>
					    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr2  style="width=300px; height:360px" border="1">
					        <param name="DataID"            value="ds2">
					        <param name="BorderStyle"       value="0">
					        <param name="ColSizing"         value="true">
					        <param name="editable"          value="salse">
					        <Param Name="UsingOneClick"     value="1">
					        <Param Name="AllShowEdit"       value="True">
					        <param name="Format"            value="
					            <C> name='상태'     	ID='AUTH_RQ'	Width=50  align=center editstyle=lookup data='ds_status1:detail:detail_nm' edit=none</C>
					            <C> name='메뉴번호'     ID='TREE_IDX'	Width=60  align=center </C>
					            <C> name='메뉴명4'      ID='TREE_NM4'   Width=100  align=left </C>
					            <C> name='요청날짜'     ID='U_DATE'		Width=70  align=center </C>
					        ">
					    </object>
					    <%=HDConstant.COMMENT_END%>
					</td>
				  </tr>
				</table>
			</td>
		  </tr>
		</table>
	</td>
  </tr>
  <tr>
	<td style="padding-top:6px">※ 좌측 [전체 메뉴 리스트]에서 필요한 메뉴를 더블클릭하면 우측 [권한 요청]에 목록이 생성됩니다.<br>
		　 필요한 메뉴를 추가하신 후 저장을 누르면 관리자에게 신청됩니다.<br>
		※ 각 메뉴별 관리팀의 요청에 의해 권한을 드리지 못할 수도 있습니다.<br>
		　예) <b>블록확정, 환불처리, 객실 배정</b> 등
	</td>
  </tr>

</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

