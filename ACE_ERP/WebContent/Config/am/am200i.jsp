<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 전산기기등록
 * 프로그램ID 	: am200i
 * J  S  P		: am200i
 * 서 블 릿		: am200i
 * 작 성 자		: 박경국
 * 작 성 일		: 2011-01-06
 * 기능정의		: 전산기기관리에 있어서 전산기기 등록 및 관리하는 화면
 * [수  정   일  자][수정자] 내용
 *****************************************************************************/
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

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
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
		var jobFlag = "";
		/*
		 * 페이지로딩
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			fnInit(); 
		} 
		/*
		 * 초기작업
		 * Header 설정 
		 */
		function fnInit(){
    	   jobFlag = "INIT";
		}
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			//if(sItem_cd.value == "" && sItem_nm.value == ""){
			//	alert("고유번호 또는 품목 중 하나는 반드시 입력되어야 합니다.")
			//	return;
			//}
			
			if (ds1.IsUpdated==false ) {
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				          + ",sItem_cd="+ sItem_cd.value
				          + ",sItem_nm=" + sItem_nm.value
				          + ",sModel_nm=" + sModel_nm.value;
				
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Am200I",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			} else {
				alert("작업중인 상태에서는 조회할수 없습니다!");
			}
		}
		/*
		 * 행추가 , 신규 
		 */
		function fnAddRowDs1() {
			jobFlag = "N";
			ds1.addRow();
			rowNum.value = ds1.rowposition;
		}
		function fnDeleteRowDs1() {
			jobFlag = "D";
			ds1.deleterow(ds1.rowposition);
		}
		/*
		 * 입력 체크
		 */
		function fnCheck() {
		 if (ds1.IsUpdated) {
				if (jobFlag != "D") {
				 for(var i=1; i<=ds1.CountRow; i++){
				  	if(ds1.NameValue(ds1.rowposition, "item_cd")=="") {
	                 	alert("고유번호를 입력하세요!");
	                 	getObjectFirst("item_cd").focus();
	                 	return;
	                 }
	                if(ds1.NameValue(ds1.rowposition, "item_nm")==""){
	                    alert("품목을 입력하세요!");
	                    getObjectFirst("item_nm").focus();
	                    return;
	                }
	              }
              }
		   }
			 return true;
		}
		/*
		 * 저장
		 */		
		function fnApply() {
	
			var row=ds1.countRow;
			
			if (ds1.IsUpdated ) {
				if(fnCheck()){
				  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Am200I",
	                "JSP(I:DS1=ds1)",
	                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
            		tr_post(tr1);
            	}
			}	
		}
		/*
		 * 취소 
		 */
		function fnCancel() {
			ds1.undoall();
			if (ds1.countrow >= 1) {
				fnSelectDs1();
			}
			window. status="데이터 변경이 취소되었습니다.";
			return;		
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
	        getObjectFirst("gr1").SetExcelTitle(1, "value:전산기기관리_등록; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("전산기기관리","전산기기관리_등록.xls", 8);
		}
	</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="작업이 성공적으로 완료되었습니다.";
	</script>	
<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
		<param name="SyncLoad" 	value="true">
	</object>
		<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
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
			<td width='425px'>
				<table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666">
					<tr>
						<td width='70px' height="30px" class='text'>고유번호</td>
						<td width='100px' height="30px" bgcolor='#FFFFFF' align='center'>
							<input type='hidden'  	name='sItem_sid' 		value='' maxlength='20' 	size='10' 	class='textbox'>
							<input type='text' 		name='sItem_cd' 		value='' maxlength='20' 	size='10' 	class='textbox'>
						</td>
						<td width='70px' height="30px" class='text'>품목</td>
						<td width='100px' height="30px" bgcolor='#FFFFFF' align='center'>
							<input type='text'  	name='sItem_nm' 		value='' maxlength='20' 	size='10' 	class='textbox'>
						</td>
						<td width='70px' height="30px" class='text'>모델 명</td>
						<td width='100px' height="30px" bgcolor='#FFFFFF' align='center'>
							<input type='text'  	name='sModel_nm' 		value='' maxlength='30' 	size='10' 	class='textbox'>
						</td>
					</tr>
				</table>
			</td>
			<td align='right'>
				<table border='0' cellpadding='0' cellspacing='0' width='390px'>
					<tr>
						<td height='30px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/new.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRowDs1()" >
							<img src="<%=dirPath%>/Sales/images/delete.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRowDs1()" >
							<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
							<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">		<!-- 엑셀 -->
						</td>
					</tr>
				</table>
			</td>
		</tr> 
		<tr>
			<td height='10px'></td>
		</tr>
		<tr>
			<td colspan='3' valign="top">
				<table  border='0' cellpadding='0' cellspacing='0'>
					<tr>
						<td valign='top'>
							<table  border='0' cellpadding='0' cellspacing='0' width='300px' height='430px' >
								<tr>
									<td>
										<%=HDConstant.COMMENT_START%>
										<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='300px' height='427px' border='1'>
											<param name="DataID"			value="ds1">
											<param name="ColSizing"			value="true">
											<param name="Fillarea"			value="false">
											<param name="Editable"  		value="false">
											<param name="BorderStyle"       value="0">
											<param name=SortView  			value="Left">
											<param name="Format" 			value="
								                <C> name='ITEM_SID'    ID='item_sid' 		Width=100  align=left editlimit=10 	show=false</C>
								                <C> name='고유번호'    ID='item_cd'    		Width=100  align=left editlimit=20 	show=true sort=true</C><!-- 고유번호 -->
								                <C> name='품목'      	ID='item_nm'    		Width=120  align=left editlimit=20 	show=true</C> <!--품목 -->
								                <C> name='자산코드'    ID='asset_cd'    	Width=100  align=left editlimit=20 	show=FALSE</C>
								                <C> name='모델명'      	ID='model_nm'   	Width=100  align=left editlimit=30 	show=FALSE</C>
								                <C> name='제조사'  		ID='made_company'   	Width=100  align=left editlimit=20 	show=false</C>
								                <C> name='CPU' 			ID='cpu'    	Width=100  align=left editlimit=50 	show=FALSE</C>
								                <C> name='메인보드'    ID='mainboard' 		Width=100  align=left editlimit=50 	show=false</C>
								                <C> name='하드디스크' ID='hdd'  	Width=100  align=left editlimit=10 	show=false</C>
								                <C> name='램 '     		ID='ram'    				Width=100  align=left editlimit=10 	show=false</C>
								                <C> name='그래픽카드'    	ID='graphic'  	Width=100  align=left editlimit=50 	show=false</C>
								                <C> name='파워서플라이'      	ID='powersupply'    Width=100  align=left editlimit=50 	show=false</C>
								                <C> name='DVD'       	ID='dvd'     			Width=100  align=left editlimit=50 	show=false</C>
								                <C> name='윈도우 PRODUCT KEY'      	ID='win_serial'     		Width=100  align=left editlimit=30 	show=false</C>
								                <C> name='비고'     	ID='remarks'   		Width=100  align=left editlimit=200 	show=false</C>
								        	">											
										</object>	
										<%=HDConstant.COMMENT_END%>								
									</td>
								</tr>
							</table>
						</td>
						<td width='10px'></td>
						<td valign='top'>
							<table border='0' cellpadding='0' cellspacing='0' width='530px'>
								<tr>
									<td width='535px'>
										<table border='0' cellpadding='0' cellspacing='1' width='530px' height='244px' bgcolor="#666666">
											<tr>
												<td width='120px' height='30px' class='boardt02'>고유번호</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='item_cd' 		name='item_cd' 		value='' maxlength='10' size='18' 	class='textbox' > <!-- 고유번호 -->
												</td>
												<td  width='120px' height='30px' class='boardt02'>품목</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='item_nm' 		name='item_nm' 		value='' maxlength='20' size='18' 	class='textbox' > <!-- 품목 -->
												</td>
											</tr>
											<tr>
												<td width='120px' height='30px' class='boardt02'>모델명</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='model_nm' 		name='model_nm' 		value='' maxlength='30' size='18' 	class='textbox' > <!-- 모델명 -->
												</td>
												<td  width='120px' height='30px' class='boardt02'>제조사</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='made_company' 		name='made_company' 		value='' maxlength='20' size='18' 	class='textbox' > <!--제조사 -->
												</td>
											</tr>
											<tr>
												<td width='120px' height='30px' class='boardt02'>CPU</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='cpu' 		name='cpu' 		value='' maxlength='50' size='18' 	class='textbox' > <!-- cpu -->
												</td>
												<td  width='120px' height='30px' class='boardt02'>메인보드</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='mainboard' 		name='mainboard' 		value='' maxlength='50' size='18' 	class='textbox' > <!-- 메인보드 -->
												</td>
											</tr>
											<tr>
												<td width='120px' height='30px' class='boardt02'>하드디스크</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='hdd' 		name='hdd' 		value='' maxlength='10' size='18' 	class='textbox' > <!-- 하드디스크 -->
												</td>
												<td  width='120px' height='30px' class='boardt02'>램</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='ram' 		name='ram' 		value='' maxlength='10' size='18' 	class='textbox' > <!-- 램 -->
												</td>
											</tr>
											<tr>
												<td width='120px' height='30px' class='boardt02'>그래픽카드</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='graphic' 		name='graphic' 		value='' maxlength='50' size='18' 	class='textbox' > <!-- 그래픽카드 -->
												</td>
												<td  width='120px' height='30px' class='boardt02'>파워서플라이</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='powersupply' 		name='powersupply' 		value='' maxlength='50' size='18' 	class='textbox' > <!-- 파워서플라이 -->
												</td>
											</tr>
											<tr>
												<td width='120px' height='30px' class='boardt02'>DVD</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='dvd' 		name='dvd' 		value='' maxlength='50' size='18' 	class='textbox' > <!-- DVD -->
												</td>
												<td  width='120px' height='30px' class='boardt02'>윈도우_KEY</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='win_serial' 		name='win_serial' 		value='' maxlength='30' size='18' 	class='textbox' > <!--윈도우 PRODUCT KEY-->
												</td>
											</tr>
											<tr>
												<td  width='120px' height='30px' class='boardt02'>비고</td>
												<td  bgcolor='#FFFFFF' colspan='3'>
													&nbsp;&nbsp;<input type='text' id='remarks' 		name='remarks' 		value='' maxlength='200' size='63' 	class='textbox'> <!--비고-->
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td height='10px'></td>
								</tr>

							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
        <%
        /*=============================================================================
                                Bind 선언
        =============================================================================*/
        %>
        <%=HDConstant.COMMENT_START%>
        <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
            <param name="DataId" value="ds1">
            <param name=BindInfo    value="
                    <C>Col=item_sid      		Ctrl=item_sid 	    	    Param=value </C>
                    <C>Col=item_cd         	Ctrl=item_cd      	    	Param=value </C>
                    <C>Col=asset_cd         Ctrl=asset_cd            	Param=value </C>
                    <C>Col=item_nm       	Ctrl=item_nm		          	Param=value </C>
                    <C>Col=model_nm        Ctrl=model_nm         		Param=value </C>
                    <C>Col=made_company        Ctrl=made_company          Param=value </C>
                    <C>Col=cpu         		Ctrl=cpu            			Param=value </C>
                    <C>Col=mainboard     	Ctrl=mainboard      		Param=value </C>
                    <C>Col=hdd           		Ctrl=hdd            			Param=value </C>
                    <C>Col=ram      			Ctrl=ram       				 	Param=value </C>
                    <C>Col=graphic          	Ctrl=graphic            		Param=value </C>
                    <C>Col=powersupply     Ctrl=powersupply       	Param=value </C>
                    <C>Col=dvd      			Ctrl=dvd        				Param=value </C>
                    <C>Col=win_serial       	Ctrl=win_serial        		Param=value </C>
                    <C>Col=remarks    		Ctrl=remarks      			Param=value </C>
            ">
        </object>
        <%=HDConstant.COMMENT_END%>
        <input type="hidden" name="tabFlag" value="1"> 
        <input type="hidden" name="rowNum" value="">
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

