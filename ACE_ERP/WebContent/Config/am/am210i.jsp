<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 전산기기관리_HISTORY
 * 프로그램ID 	: am210i
 * J  S  P		: am210i
 * 서 블 릿		: AM210I
 * 작 성 자		: 박경국
 * 작 성 일		: 2011-01-10
 * [수  정   일  자][수정자] 내용
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
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	String firstday = m_today.format(date.getTime());			
%>
<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
	
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		
<script language="javascript">
	 var v_job='';
	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		cfStyleGrid(getObjectFirst("gr1"), "comn1");
		fnInit();
	} 
	function fnInit() {
	ds_send_status_cd.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=IT001";
    ds_send_status_cd.Reset();//현재사용자 상태
    ds_receive_status_cd.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=IT001";
    ds_receive_status_cd.Reset();//받을사용자 상태
	}
	
	/*
	 * 메인 조회
	 */
	function fnSelect() {
		v_job = "S";
		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		        	+ ",sItem_cd="+ sItem_cd.value
		          	+ ",sItem_nm=" + sItem_nm.value
		          	+ ",sModel_nm=" + sModel_nm.value;

			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%> Am210I",
		    "JSP(O:DS1=ds1)",
		    param);
		   
		tr_post(tr1);
	}
		
	/*
	* 인원 팝업 : 현재 사용자 조회
	*/
	function fnCustPopup() {
			
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Common/help/rv004h_03.jsp"
		strPos = "dialogWidth:410px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		//alert(arrResult);
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			ds1.namevalue(ds1.rowposition,"send_empnmk") = arrParam[2];
	   		ds1.namevalue(ds1.rowposition, "send_deptnm") = arrParam[0];
	   		ds1.namevalue(ds1.rowposition, "send_empno") = arrParam[1];
		} else {
			ds1.namevalue(ds1.rowposition,"send_empnmk") = "";
	   		ds1.namevalue(ds1.rowposition, "send_deptnm") = "";
			ds1.namevalue(ds1.rowposition,"send_empno") = "";
   		}				
	}
	/*
	* 인원 팝업 : 받을 사용자 조회
	*/
	function fnCustPopup2() {
			
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Common/help/rv004h_03.jsp"
		strPos = "dialogWidth:410px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		//alert(arrResult);
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			ds1.namevalue(ds1.rowposition,"receive_empnmk") = arrParam[2];
	   		ds1.namevalue(ds1.rowposition, "receive_deptnm") = arrParam[0];
	   		ds1.namevalue(ds1.rowposition, "receive_empno") = arrParam[1];
		} else {
			ds1.namevalue(ds1.rowposition,"receive_empnmk") = "";
	   		ds1.namevalue(ds1.rowposition, "receive_deptnm") = "";
			ds1.namevalue(ds1.rowposition,"receive_empno") = "";
   		}				
	}			 	 			 	 
	/*
	 * 엑셀
	 */
	function fnExcelDs1() {
		if(ds1.RowCount==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        } 
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:전산기기관리_HISTORY; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("전산기기관리","전산기기관리_HISTORY.xls", 8);
	}

	//적용
	function fnApply() {
		if ( ds1.isUpdated ) {
            v_job = "I";
            window.status="저장 중입니다. 잠시만 기다려 주십시오...";
            
            ln_TRSetting(tr1,
                "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%> Am210I",
                "JSP(I:DS1=ds1)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
            tr_post(tr1);
         } else {
         	alert("업데이트된 행이 없습니다.");
		 }
	}	
	//취소
	function fnCancel(){
		if(ds1.IsUpdated){
			ds1.undoall();
			v_job=""; //취소누르면 변수 초기화
		}
		window.status="전산기기_HISTORY 작업이 취소되었습니다.";
		return;
	}
</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="작업이 성공적으로 완료되었습니다.";
		if(v_job=="I"){
			fnSelect();
		};
	</script>	
	<script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
		if (colid=="send_empnmk") {
			fnCustPopup();
		}
		if (colid=="receive_empnmk") {
			fnCustPopup2();
		}
		
	</script>        
<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 메인  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds_send_status_cd classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_receive_status_cd classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='845px'>
				<table  border='0' cellpadding='0' cellspacing='0' width='845'>
					<tr>
						<td>
							<table border='0' celpadding='0' cellspacing='1' bgcolor='#666666'>
								<tr>
									<td width='70px' height="30px" class='text'>고유번호</td>
									<td width='100px' height="30px" bgcolor='#FFFFFF' align='center'>
										<input type='hidden'  	name='sItem_sid' 		value='' maxlength='20' 	size='10' 	class='textbox'>
										<input type='text' 			name='sItem_cd' 		value='' maxlength='20' 	size='10' 	class='textbox'>
									</td>
									<td width='70px' 	height="30px" class='text'>품목</td>
									<td width='100px' 	height="30px" bgcolor='#FFFFFF' align='center'>
										<input type='text'  	name='sItem_nm' 		value='' maxlength='20' 	size='10' 	class='textbox'>
									</td>
									<td width='70px' height="30px" class='text'>모델 명</td>
									<td width='100px' height="30px" bgcolor='#FFFFFF' align='center'>
										<input type='text'  	name='sModel_nm' 		value='' maxlength='30' 	size='10' 	class='textbox'>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table  border='0' cellpadding='0' cellspacing='0'>
								<tr>
									<td align='right'>
										<img src="<%=dirPath%>/Sales/images/refer.gif"  		style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 			<!-- 조회 -->
										<img src="<%=dirPath%>/Sales/images/save.gif" 		style="cursor:hand" align=absmiddle onClick="fnApply();">			<!-- 저장 -->
				                        <img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand" align=absmiddle onclick="fnCancel()">			<!-- 취소 -->
				                        <img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">		<!-- 엑셀 -->
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height='10px'></td>
		</tr>
		<tr>
			<td colspan='2'>
				<table  border='0' cellpadding='0' cellspacing='1' >
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='370px' border='1'>
								<param name="DataID"		value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="True">
								<param name="BorderStyle"	value="0">
								<Param Name="AllShowEdit"   value="True">
								<param name=SortView  		value="Left">
								<param name="SuppressOption"    value="1">
								<param name=ViewSummary     value=1>
								<param name="Format" 		value="
									
									<C> name='고유번호'   	ID='item_cd'  	width=66 	align=center edit=none show=true </C>
									<C> name='품목'   		ID='item_nm'  	width=60 	align=left show=true   edit=none</C>
									<C> name='모델명'   	ID='model_nm'  	width=80 	align=left show=true   edit=none</C>
									<C> name='사번' 			ID='send_empno'  	width=55 	align=center  show=true  edit=none BgColor=pink editlimit=61 </C>
									<C> name='부서'   		ID='send_deptnm'	width=90 	align=left  show=true  edit=none BgColor=pink editlimit=61 </C>
									<C> name='현재\\사용자'   		ID='send_empnmk'  		width=70 	align=center  editlimit=61 editstyle=popup show=true  Edit=any BgColor=pink editlimit=61 </C>
									<C> name='현재사용자\\(상태변경)'   		ID='send_status_cd'  		width=70 	align=center  show=true  EditStyle=Lookup  editlimit=61 Data='ds_send_status_cd:detail:detail_nm' BgColor=pink</C>
									<C> name='사번' 			ID='receive_empno'  	width=55 	align=center  show=true  edit=none BgColor=#D7FFDA editlimit=61 </C>
									<C> name='부서'   		ID='receive_deptnm'	width=90 	align=left  show=true  edit=none BgColor=#D7FFDA editlimit=61 </C>
									<C> name='받을\\사용자'   		ID='receive_empnmk'  		width=70 	align=center  show=true   editstyle=popup Edit=any BgColor=#D7FFDA editlimit=61 </C>
									<C> name='받을사용자\\(상태변경)'   		ID='receive_status_cd'  		width=70 	align=center  show=true   editlimit=61 EditStyle=Lookup Data='ds_receive_status_cd:detail:detail_nm' BgColor=#D7FFDA</C>
									<C> name='비고'   		ID='remarks'  	width=150 	align=left show=true   editlimit=200</C>
								">
							</object>
										<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
					<br>
					※   작업순서<br>
					1. "이동/수정 할 전산기기"를 조회합니다.<br>
					2. [현재사용자]에서 [···] 버튼을 눌러 "현재 사용자"를 선택합니다.<br>
					3. [현재사용자(상태변경)]에서 변경할 상태를 선택합니다. <br>
					4. [받을사용자]에서 [···] 버튼을 눌러 "받을 사용자"를 선택합니다.<br>
					5. [받을사용자(상태변경)]에서 변경할 상태를 선택합니다. <br>
					6. [저장] 버튼을 누르면 전산기기_HISTORY 변경내용이 저장됩니다.<br>
					<br>
					※ 신규지급 일 경우에는 받을사용자만 선택하신 후, 저장합니다.<br>
					※ 분실/폐기 일 경우에는 현재사용자만 선택하신 후, 저장합니다. <br>
			</td>
		</tr>
	</table>
 <%
/*=============================================================================
                        Bind 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>
        <param name="DataId" value="ds1">
        <param name=BindInfo    value="
            <C>Col=accept_sid               Ctrl=accept_sid         Param=value </C>
            <C>Col=accept_no                Ctrl=accept_no          Param=Text </C>
            <C>Col=accept_date              Ctrl=accept_date        Param=Text </C>
            <C>Col=goods_sid              Ctrl=v_goods        Param=BindColVal </C>
            <C>Col=depart_date              Ctrl=depart_date        Param=Text </C>
        ">
</object>
<%=HDConstant.COMMENT_END%>	
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

