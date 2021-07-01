<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 협력업체조회
 * 프로그램ID 	: CU050S
 * J  S  P		: cu050S
 * 서 블 릿		: Cu050S
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-06-16
 * 기능정의	: 협력업체 리스트 조회
 * [수  정   일  자][수정자] 내용
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
        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_CU%>Cu050S",
            	"JSP(O:S_USEYN=sCodeDs1)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);
		}
			
		/*
		 * 메인 조회
		 */
		function fnSelect() {
		
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				          + ",sClient_nm="+ sClient_nm.value
				          + ",sSal_dam_sid=" + sSal_dam_sid.value
				          + ",sUse_yn=" + sUse_yn.ValueOfIndex("detail", sUse_yn.Index);
				
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_CU%>Cu050S",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
		}
			
		/*
		 * 프린트
		 */
		function fnPrintDs1() {
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
		        getObjectFirst("gr1").SetExcelTitle(1, "value:협력업체별 조회; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        getObjectFirst("gr1").GridToExcel("협력업체별 조회", "협력업체별  조회.xls", 8);
			
		}
		
		/*
		 * 영업담당자
		 */
		 
		 function fnSalDamPopup(flag) {
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			
			strURL = "<%=dirPath%>/Sales/help/sy005h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			
			
			arrResult = showModalDialog(strURL,arrParam,strPos);	
			
			if (arrResult != null) {
				arrParam = arrResult.split(";");
				
				
			 	if (flag == "S") {
			 		sSal_dam_sid.value = arrParam[0];
			 		sSal_dam_nm.value = arrParam[2];
			 	} else if (flag == "I") {
			 		sal_dam_sid.value = arrParam[0];
			 		sal_dam_nm.value = arrParam[2];
			 	}
			} else {
				if (flag == "S") {
			 		sSal_dam_sid.value = "";
			 		sSal_dam_nm.value = "";
			 	} else if (flag == "I") {
			 		sal_dam_sid.value = "";
			 		sal_dam_nm.value = "";
			 	}
			}
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
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  대리점 조회 -->
		<param name="SyncLoad" 	value="true">
	</object>
	
	
	
	<object id=sCodeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  사용유무 -->
		<param name="SyncLoad" 	value="false">
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
			<td width='525px'>
				<table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666">
					<tr>
						<td width='70px' height='30px' class='text'>협력업체</td>
						<td width='100px' height='30px' bgcolor='#FFFFFF' align='center'>
							<input type='hidden'  	name='sClient_cd' 		value='' maxlength='10' 	size='10' 	class='textbox'>
							<input type='text' 		name='sClient_nm' 		value='' maxlength='30' 	size='10' 	class='textbox'>
						</td>
						<td width='70px' height='30px' class='text'>담당자</td>
						<td width='120px' height='30px' bgcolor='#FFFFFF' align='center'>
							<input type='hidden'  		name='sSal_dam_sid' 		value='' maxlength='10' 	size='5' 	class='textbox'  >
							<input type='text'  		name='sSal_dam_nm' 			value='' maxlength='10' 	size='10' 	class='textbox' readonly onClick="javascript:fnSalDamPopup('S');">
							<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="영업담당자를 검색합니다"  style="cursor:hand" id="zipcode_btn" onclick="javascript:fnSalDamPopup('S');" align='absmiddle'>
						<td width='80px' height='30px' class='text'>사용유무</td>
						<td width='100px' height='30px' bgcolor='#FFFFFF'>&nbsp;
							<%=HDConstant.COMMENT_START%>
							<object id=sUse_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
								<param name=ComboDataID		value=sCodeDs1>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
							</object>
							<%=HDConstant.COMMENT_END%>	
						</td>
					</tr>
				</table>
			</td>
			<td align='right'>
				<table border='0' cellpadding='0' cellspacing='0' width='300px'>
					<tr>
						<td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand"	align=absmiddle onclick="fnExcelDs1()">
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
							<table  border='0' cellpadding='0' cellspacing='0' width='845px' height='430px' >
								<tr>
									<td>
										<%=HDConstant.COMMENT_START%>
										<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='447px' border='1'>
											<param name="DataID"			value="ds1">
											<param name="ColSizing"			value="true">
											<param name="Fillarea"			value="false">
											<param name="Editable"  		value="false">
											<param name="BorderStyle"       value="0">
											<param name=SortView  			value="Left">
											<param name="SuppressOption"    value="1">
											<param name=FixSizing  value="false">
											<param name="Format" 			value="
										               <FC> name='영업담당자'   	ID='sal_dam_nm'  	width=100  align=center editlimit=22 show=true suppress=1 (FixedColumn)</FC>
										               <FC> name='협력업체코드'   	ID='client_cd'   	width=100  align=center editlimit=5 show=true (FixedColumn)</FC>
										               <FC> name='거래처코드'     	ID='vend_cd'     	width=100  align=right editlimit=13 show=true (FixedColumn)</FC>
										               <C> name='협력업체명'    	ID='client_nm'   	width=150  align=left editlimit=30 show=true</C>
										               <C> name='직판'  			ID='dir_yn_name'   	width=40  align=center editlimit=50 show=true</C>
										               <C> name='지역' 			ID='area_cd_name'   width=40  align=center editlimit=50 show=true</C>
										               <C> name='대리점담당자'   	ID='client_dam_nm'  width=120  align=center editlimit=20 show=true</C>
										               <C> name='전화번호'       ID='tel_no'      	width=120  align=left editlimit=20 show=true</C>
										               <C> name='휴대번호'    	ID='mobile_no'   	width=120  align=left editlimit=15 show=true</C>
										               <C> name='팩스번호'       	ID='fax_no'      	width=120  align=left editlimit=20 show=true</C>
										               <C> name='메일주소'       	ID='e_mail'      	width=200  align=left editlimit=30 show=true</C>
										               <C> name='사용유무' 		ID='use_yn_name'    width=60  align=center editlimit=50 show=true</C>
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
	</table>
	
   
        <input type="hidden" name="tabFlag" value="1"> 
        <input type="hidden" name="rowNum" value="">

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

