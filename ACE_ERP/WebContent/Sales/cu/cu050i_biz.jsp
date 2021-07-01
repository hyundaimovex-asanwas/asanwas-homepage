<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 협력업체등록
 * 프로그램ID 	: CU050I
 * J  S  P		: cu050i
 * 서 블 릿		: Cu050I
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-06-16
 * 기능정의		: 대리점에 대응하는 협력업체(사업자전용)의 등록메뉴.
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2008-02-27][심동현] 사업자전용 : 테이블 수정에 맞춰 다시 수정
 * [2015-10-01][심동현] 영문 협력업체명 등록
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
			
			codeDs1.deleteRow(1);
			codeDs2.deleteRow(1);
			codeDs3.deleteRow(1);
			codeDs4.deleteRow(1);
			codeDs5.deleteRow(1);
			
			dir_yn.index = 0;
			area_cd.index = 0;
			use_yn.index = 0;
			
			fnSetHeaderDs1();
		} 
			
		/*
		 * 데이터셋 헤더 설저 (디테일)
		 */
		function fnSetHeaderDs1(){
			if (ds1.countrow<1){
				var s_temp = ""
				+ "CLIENT_SID:INT,VEND_CD:STRING,CLIENT_CD:STRING,CLIENT_NM:STRING,CLIENT_GU:STRING,AGEN_GU:STRING,DIR_YN:STRING,AREA_CD:STRING,SAL_DAM_SID:INT,CLIENT_DAM_NM:STRING,TEL_NO:STRING,MOBILE_NO:STRING,FAX_NO:STRING,E_MAIL:STRING,ZIP_CD:STRING,ADDRESS1:STRING,ADDRESS2:STRING,COMMI_RATE:INT,CUNT_STATUS:STRING,BANCOD:STRING,BANK_ACC_NO:STRING,BANK_ACCT_NM:STRING,USE_YN:STRING,U_EMPNO:STRING,U_DATE:STRING,U_IP:STRING,VEND_TYPE:STRING,VEND_ID:STRING";
				
				ds1.SetDataHeader(s_temp);
			}
		}		
		

		/*
		 * 초기작업
		 * Header 설정 
		 */
		function fnInit(){
    	   jobFlag = "INIT";
        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_CU%>Cu050I",
            	"JSP(O:AGENGU=codeDs1,O:DIRYN=codeDs2,O:AREACD=codeDs3,O:CUNTSTATUS=codeDs4,O:USEYN=codeDs5,O:INSURCOMPCD=codeDs6,O:CLIENTDOWNYN=codeDs7,O:S_USEYN=sCodeDs1)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);


	 		codeDs8.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CU024";
			codeDs8.Reset(); //법인구분

		}
			
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			if(sClient_nm.value == "" && sSal_dam_sid.value == ""){
				alert("협력업체 또는 담당자 중 한가지는 반드시 입력되야 합니다.")
				return;
			}
			
			if (ds1.IsUpdated==false ) {
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				          + ",sClient_nm="+ sClient_nm.value
				          + ",sSal_dam_sid=" + sSal_dam_sid.value
				          + ",sUse_yn=" + sUse_yn.ValueOfIndex("detail", sUse_yn.Index);
				
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_CU%>Cu050I",
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
			
			ds1.namevalue(ds1.rowposition,"client_gu") = "2";	//매출처구분 == 2(협력업체)로...;;;
			vend_type.index=1;	//법인구분 기본값 [영리법인] 으로.
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
				  	if(ds1.NameValue(ds1.rowposition, "client_cd")=="") {
	                 	alert("협력업체 코드를 입력하세요!");
	                 	getObjectFirst("client_cd").focus();
	                 	return;
	                 }
	                 
				 	if(ds1.NameValue(ds1.rowposition, "client_nm")==""){
	                    alert("협력업체명을 입력하세요!");
	                    getObjectFirst("client_nm").focus();
	                    return;
	                 }
	                
			  		if(ds1.NameValue(ds1.rowposition, "vend_cd")=="") {
	                 	alert("거래처를 선택하세요!");
	                 	getObjectFirst("vend_nm").focus();
	                 	return;
	                 }
	
			  		if(ds1.NameValue(ds1.rowposition, "sal_dam_sid")=="") {
	                 	alert("영업담당자를 선택하세요!");
	                 	getObjectFirst("sal_dam_nm").focus();
	                 	return;
	                 }
			  		
			  		if(ds1.NameValue(ds1.rowposition, "dir_yn")=="") {
	                 	alert("직판여부를 선택하세요!");
	                 	getObjectFirst("dir_yn").focus();
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "client_dam_nm")=="") {
	                 	alert("협력업체담당자를 입력하세요!");
	                 	getObjectFirst("client_dam_nm").focus();
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "tel_no")=="") {
	                 	alert("전화번호를 입력하세요!");
	                 	getObjectFirst("tel_no").focus();
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "mobile_no")=="") {
	                 	alert("휴대전화를 입력하세요!");
	                 	getObjectFirst("mobile_no").focus();
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "fax_no")=="") {
	                 	alert("팩스를 입력하세요!");
	                 	getObjectFirst("fax_no").focus();
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "e_mail")=="") {
	                 	alert("이메일을 입력하세요!");
	                 	getObjectFirst("e_mail").focus();
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "zip_cd")=="") {
	                 	alert("우편번호를 선택하세요!");
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "address2")=="") {
	                 	alert("상세주소를 입력하세요!");
	                 	getObjectFirst("address2").focus();
	                 	return;
	                 }
	                 

			  		if(ds1.NameValue(ds1.rowposition, "bancod")=="") {
	                 	alert("은행을 선택하세요!");
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "bank_acc_no")=="") {
	                 	alert("계좌번호를 입력하세요!");
	                 	getObjectFirst("bank_acc_no").focus();
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "bank_acct_nm")=="") {
	                 	alert("예금주를 입력하세요!");
	                 	getObjectFirst("bank_acct_nm").focus();
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "use_yn")=="") {
	                 	alert("사용유무를 선택하세요!");
	                 	getObjectFirst("use_yn").focus();
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
	                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu050I",
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
		 * 프린트
		 */
		function fnPrintDs1() {
		}
			
		/*
		 * 엑셀
		 */
		function fnExcelDs1() {
			gr1.runexcelsheet("고객엑셀등록");
		}
			
		/*
		 * 보험회사 팝업
		 */
		function fnPopup() {
			
		}
		
		/*
		 * 지역 팝업
		 */
		 function fnAreaPopup() {
		 }
		 
		/*
		 * 우편번호 팝업 
		 */ 
		function fnZipCodePopup() {
	       var arrParam    = new Array();
	        var arrResult   = new Array();
	        var strURL; 
	        var strPos;
	            
	        strURL = "<%=dirPath%>/Sales/help/sy002h.jsp";
	        strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	        arrResult = showModalDialog(strURL,arrParam,strPos);    
	    
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            zip_cd.Text= arrParam[0];
	            address1.value = arrParam[1];
	            
	        } else {
	          zip_cd.Text = "";
	          address1.value = "";
	        }       				
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

		/*
		 * 협력업체 팝업
		 */
		function fnClientPopup() {
			
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			var dir = '<%=dirPath%>';
			
			arrResult = fnClientPop(dir,'1');
		
			if (arrResult != null) {
				arrParam = arrResult.split(";");
		   		client_cd.value = arrParam[2];
		   		client_nm.value = arrParam[1];
			} else {
			  client_nm.value = "";
			  client_cd.value = "";
			}				
		}		 
		/*
		 * 거래처 팝업 
		 */
		function fnVendPopup() {
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			
			strURL = "<%=dirPath%>/Sales/help/cu004h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			
			arrResult = showModalDialog(strURL,arrParam,strPos);	
			
			if (arrResult != null) {
				arrParam = arrResult.split(";");
		   		vend_cd.value = arrParam[0];
		   		vend_nm.value  = arrParam[1];
			} else {
			 	vend_cd.value = "";
			  	vend_nm.value = "";
			}
			return ;			
		}
		/*
		 * 공통코드 팝업
		 */
		function fnCommonCodePopup(head, headNm) {
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			
			strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			
			arrParam[0] = head;
			arrParam[1] = headNm;
			arrResult = showModalDialog(strURL,arrParam,strPos);	
			
			if (arrResult != null) {
				arrParam = arrResult.split(";");
				
			if (head == 'AC002') {		// 은행 
					bancod.value = arrParam[1];
					bannam.value = arrParam[2];
				} 
				
	
			} else {
				if (head == 'AC002') {	// 은행 
					bancod.value = "";
					bannam.value = "";
				}
			}
			return ;	
		}		


	    // 협력업체 코드 만들기
		function fnSelectClientCd() {
		        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2";

		        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu050I",
		            "JSP(O:SEARCH_DS1=searchds1)",
		            param);
		        tr_post(tr1);
		}


		
		</script>
		

<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	
	<script language="javascript" for="tr1" event="onsuccess()">
		msgTxt.innerHTML="작업이 성공적으로 완료되었습니다.";
	</script>	
	
	<script language=JavaScript  for=searchds1 event="OnLoadCompleted(row)">
		client_cd.text = searchds1.namevalue(searchds1.rowposition,"CLIENT_CD");
		
	</script>
	
	
<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  협력업체 조회 -->
		<param name="SyncLoad" 	value="true">
	</object>
	
	<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  협력업체구분 -->
		<param name="SyncLoad" 	value="false">
	</object>
	<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  직판구분 -->
		<param name="SyncLoad" 	value="false">
	</object>
	<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  지역 -->
		<param name="SyncLoad" 	value="false">
	</object>
	<object id=codeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  계약상태 -->
		<param name="SyncLoad" 	value="false">
	</object>
	<object id=codeDs5 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  사용유무 -->
		<param name="SyncLoad" 	value="false">
	</object>
	<object id=codeDs6 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  보증보험회사 -->
		<param name="SyncLoad" 	value="false">
	</object>
	<object id=codeDs7 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  하위협력업체 여부 -->
		<param name="SyncLoad" 	value="false">
	</object>
	<object id=codeDs8 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  법인구분 여부 -->
		<param name="SyncLoad" 	value="false">
	</object>

	<object id=sCodeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  사용유무 -->
		<param name="SyncLoad" 	value="false">
	</object>
	<object id=searchds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  협력업체코드 -->
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='525px'>
				<table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666">
					<tr>
						<td width='70px' height="30px" class='text'>협력업체</td>
						<td width='100px' height="30px" bgcolor='#FFFFFF' align='center'>
							<input type='hidden'  	name='sClient_cd' 		value='' maxlength='10' 	size='10' 	class='textbox'>
							<input type='text' 		name='sClient_nm' 		value='' maxlength='30' 	size='10' 	class='textbox'>
						</td>
						<td width='70px' height="30px" class='text'>담당자</td>
						<td width='120px' height="30px" bgcolor='#FFFFFF' align='center'>
							<input type='hidden'  		name='sSal_dam_sid' 		value='' maxlength='10' 	size='5' 	class='textbox'  >
							<input type='text'  		name='sSal_dam_nm' 			value='' maxlength='10' 	size='10' 	class='textbox' readonly onClick="javascript:fnSalDamPopup('S');">
							<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="영업담당자를 검색합니다"  style="cursor:pointer" id="zipcode_btn" onclick="javascript:fnSalDamPopup('S');" align='absmiddle'>
						<td width='80px' height="30px" class='text'>사용유무</td>
						<td width='100px' height="30px" bgcolor='#FFFFFF'>&nbsp;
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
						<td height='30px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/new.gif"	style="cursor:pointer"	align=absmiddle onClick="fnAddRowDs1()" >
							<img src="<%=dirPath%>/Sales/images/delete.gif" style="cursor:pointer" align=absmiddle onClick="fnDeleteRowDs1()" >
							<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:pointer" align=absmiddle onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:pointer"	align=absmiddle onclick="fnCancel()">
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
								                <C> name='협력업체SID'   	ID='client_sid' 		Width=100  align=left editlimit=12 	show=false</C>
								                <C> name='거래처코드'    	ID='vend_cd'    		Width=100  align=left editlimit=13 	show=false</C>
								                <C> name='거래처명'      	ID='vend_nm'    		Width=100  align=left editlimit=62 	show=false</C>
								                <C> name='협력업체코드'    	ID='client_cd'  		Width=100  align=left editlimit=5 	show=true sort=true</C>
								                <C> name='협력업체명'    	ID='client_nm'  		Width=183  align=left editlimit=30 	show=true</C> <!-- 대리점명 : 협력업체명 -->
								                
								                <C> name='대리점구분'    	ID='client_gu'  		Width=100  align=left editlimit=1 	show=false</C> <!-- 대리점 구분 1 = 협력업체 -->
								                <C> name='협력업체구분'    	ID='agen_gu'    	Width=100  align=left editlimit=1 	show=false</C>
								                <C> name='협력업체구분명' 	ID='agen_gu_name'   Width=100  align=left editlimit=50 	show=false</C>
								                <C> name='직판여부'      	ID='dir_yn'     		Width=100  align=left editlimit=1 	show=false</C>
								                <C> name='직판여부명'  	ID='dir_yn_name'    	Width=100  align=left editlimit=50 	show=false</C>

								                <C> name='지역코드'      	ID='area_cd'    		Width=100  align=left editlimit=2 	show=FALSE</C>
								                <C> name='지역코드명' 	ID='area_cd_name'   	Width=100  align=left editlimit=50 	show=false</C>
								                <C> name='영업담당자SID' 	ID='sal_dam_sid'    	Width=100  align=left editlimit=12 	show=FALSE</C>
								                <C> name='영업담당자명'   ID='sal_dam_nm' 		Width=100  align=left editlimit=22 	show=false</C>
								                <C> name='협력업체담당자' ID='client_dam_nm'  	Width=100  align=left editlimit=20 	show=false</C>

								                <C> name='전화번화 '     	ID='tel_no'    			Width=100  align=left editlimit=20 	show=false</C>
								                <C> name='휴대전화'    	ID='mobile_no'  		Width=100  align=left editlimit=15 	show=false</C>
								                <C> name='팩스번호'      	ID='fax_no'     		Width=100  align=left editlimit=20 	show=false</C>
								                <C> name='이메일'       	ID='e_mail'     		Width=100  align=left editlimit=30 	show=false</C>
								                <C> name='우편번호'      	ID='zip_cd'     		Width=100  align=left editlimit=6 	show=false</C>

								                <C> name='주소1'     	ID='address1'   		Width=100  align=left editlimit=60 	show=false</C>
								                <C> name='주소2'     	ID='address2'   		Width=100  align=left editlimit=60 	show=false</C>
								                <C> name='수수료율'   	ID='commi_rate' 		Width=100  align=left editlimit=7 	show=false</C>
								                <C> name='계약상태'  	ID='cunt_status'        Width=100  align=left editlimit=1 	show=false</C>
								                <C> name='계약상태명' 	ID='cunt_status_name'   Width=100  align=left editlimit=50 	show=false</C>

								                <C> name='은행코드'     ID='bancod'     		Width=100  align=left editlimit=6 	show=false</C>
								                <C> name='은행명'       ID='bannam'     		Width=100  align=left editlimit=30 	show=false</C>
								                <C> name='은행계좌번호' ID='bank_acc_no'        Width=100  align=left editlimit=20 	show=false</C>
								                <C> name='예금주' 		ID='bank_acct_nm'       Width=100  align=left editlimit=32 	show=false</C>
								                <C> name='사용여부'     ID='use_yn'     		Width=100  align=left editlimit=1 	show=false</C>

								                <C> name='사용여부명'  	ID='use_yn_name'        Width=100  align=left editlimit=50 	show=false</C>
								                <C> name='법인구분'  	ID='vend_type'        Width=100  align=left editlimit=50 	show=FALSE</C>
								                <C> name='사업자번호'  	ID='vend_id'        Width=100  align=left editlimit=50 	show=FALSE</C>
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
												<td width='120px' height='30px' class='boardt02'>협력업체코드</td>
												<td bgcolor='#FFFFFF'>&nbsp;
													<%=HDConstant.COMMENT_START%>
													<object id=client_cd classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='60px' align='absmiddle' class='textbox'>			
														<param name=Alignment 	value=1>
														<param name=Format 		value="00000">
														<param name=Enable      value="false">
                                                        <param name=Border   	value=false>
													</object>
													<%=HDConstant.COMMENT_END%>
													&nbsp;<img src="<%=dirPath%>/Sales/images/n_create.gif" border="0" 	ALT="신청서번호생성"  		style="cursor:pointer"  onclick="javascript:fnSelectClientCd();" align='absmiddle'>
												</td>
												<td  width='120px' height='30px' class='boardt02'>협력업체명</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='client_nm' 		name='client_nm' 		value='' maxlength='30' size='20' 	class='textbox' > <!-- 대리점 명 -->
													
												</td>
											</tr>
											<tr>
												<td  width='120px' height='30px' class='boardt02'>회계거래처명</td>
												<td  bgcolor='#FFFFFF'>
													<input type='hidden' id='vend_cd' 			name='vend_cd' 			value='' maxlength='13' size='10' 	class='textbox'> <!-- 거래처코드 -->
													&nbsp;&nbsp;<input type='text' id='vend_nm' 			name='vend_nm' 			value='' maxlength='62' size='15' 	class='textbox' readonly> <!-- 거래처명 -->
													<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="거래처를 검색합니다"  style="cursor:pointer" id="vend_btn" onclick="javascript:fnVendPopup();" align='absmiddle'>
												</td>
												<td  width='120px' height='30px' class='boardt02'>영업담당자</td>
												<td   bgcolor='#FFFFFF'>
													<input type='hidden' id='sal_dam_sid' 		name='sal_dam_sid' 		value='' maxlength='12' size='12' 	class='textbox' readonly> <!-- 영업담당자코드 -->
       												&nbsp;&nbsp;<input type='text' id='sal_dam_nm' 		name='sal_dam_nm' 		value='' maxlength='22' size='10' 	class='textbox' readonly> <!-- 영업담당자명 -->
       												<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="영업담당자를 검색합니다"  style="cursor:pointer" id="sal_dam_btn" onclick="javascript:fnSalDamPopup('I');" align='absmiddle'>
												</td>
											</tr>
											<tr>
												<td width='120px' height='30px' class='boardt02'>협력업체담당자</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;&nbsp;<input type='text' id='client_dam_nm' 	name='client_dam_nm' 	value='' maxlength='20' size='20' 	class='textbox'> <!-- 대리점담당자 -->
												</td>
												<td  width='120px' height='30px' class='boardt02'>직판여부</td>
												<td  bgcolor='#FFFFFF'>&nbsp;
													<!-- <input type='hidden' id='dir_yn' 			name='dir_yn' 			value='' maxlength='1' 	size='1' 	class='textbox'> <!-- 직판여부 -->
       												<!-- &nbsp;&nbsp;<input type='text' id='dir_yn_name' 		name='dir_yn_name' 		value='' maxlength='50' size='10' 	class='textbox'> <!-- 직판여부명 -->
      												<%=HDConstant.COMMENT_START%>
						                            <object id=dir_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
														<param name=ComboDataID		value=codeDs2>
														<param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
														
														<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
														<param name=ListExprFormat  value="detail_nm^0^100">
													</object>
													<%=HDConstant.COMMENT_END%>	
       												
												</td>
											</tr>
											<tr>
												<td  width='120px' height='30px' class='boardt02'>법인구분</td>
												<td  width='165px' height='30px' bgcolor='#FFFFFF'>&nbsp;
      												<%=HDConstant.COMMENT_START%>
						                            <object id=vend_type classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
														<param name=ComboDataID		value=codeDs8>
														<param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
														<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
														<param name=ListExprFormat  value="detail_nm^0^120">
													</object>
													<%=HDConstant.COMMENT_END%>	
       												
												</td>
												<td  width='120px' height='30px' class='boardt02'>사업자등록번호</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;&nbsp;<input type='text' id='vend_id' 	name='vend_id' 		value='' maxlength='15' size='20' 	class='textbox'> <!-- 휴대전화 -->
												</td>
											</tr>

											
											<tr>
												<td  width='120px' height='30px' class='boardt02'>전화번호</td>
												<td   bgcolor='#FFFFFF'>
													&nbsp;&nbsp;<input type='text' id='tel_no' 			name='tel_no' 			value='' maxlength='20' size='20' 	class='textbox'> <!-- 전화번호 -->
													
												</td>
												<td  width='120px' height='30px' class='boardt02'>휴대전화</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;&nbsp;<input type='text' id='mobile_no' 		name='mobile_no' 		value='' maxlength='15' size='20' 	class='textbox'> <!-- 휴대전화 -->
												</td>
											</tr>

											<tr>
												<td  width='120px' height='30px' class='boardt02'>팩스번호</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;&nbsp;<input type='text' id='fax_no' 			name='fax_no' 			value='' maxlength='20' size='20' 	class='textbox'> <!-- FAX번호 -->
												</td>
												<td  width='120px' height='30px' class='boardt02'>메일주소</td>
												<td  bgcolor='#FFFFFF'>
													 &nbsp;&nbsp;<input type='text' id='e_mail' 			name='e_mail' 			value='' maxlength='30' size='23' 	class='textbox'> <!-- 이메일 -->
												</td>
											</tr>
											<tr>
												<td  width='120px' height='30px' class='boardt02'>우편번호</td>
												<td  width='165px' height='30px' bgcolor='#FFFFFF'>&nbsp;
													<!-- &nbsp;&nbsp;<input type='text' id='zip_cd' 			name='zip_cd' 			value='' maxlength='6' 	size='6' 	class='textbox'> <!-- 우편번호 -->
													
													<%=HDConstant.COMMENT_START%>
													<object id=zip_cd classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='60px' onkeydown="if (event.keyCode == 13) fnZipCodePopup();" align='absmiddle' class='textbox'>			
														<param name=Alignment 	value=1>
														<param name=Format 		value="###-###">
														<param name=Cursor	 	value="Hand">
														<param name=Enable      value="False">
                                                        <param name=ReadOnly    value="True">
                                                        <param name=Border   	value=false>
													</object>
													<%=HDConstant.COMMENT_END%>&nbsp;&nbsp;
													<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="우편번호를 검색합니다"  style="cursor:pointer" id="zipcode_btn" onclick="fnZipCodePopup();" align='absmiddle'>													
												</td>
												<td  width='120px' height='30px' class='boardt02'>지역코드</td>
												<td  width='165px' height='30px' bgcolor='#FFFFFF'>&nbsp;
													<!-- <input type='hidden' id='area_cd' 			name='area_cd' 			value='' maxlength='2' 	size='2' 	class='textbox'> <!-- 지역코드 -->
       												<!-- &nbsp;&nbsp;<input type='text' id='area_cd_name' 	name='area_cd_name' 	value='' maxlength='50' size='10' 	class='textbox'> <!-- 지역명 -->	
      												<%=HDConstant.COMMENT_START%>
						                            <object id=area_cd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
														<param name=ComboDataID		value=codeDs3>
														<param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
														<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
														<param name=ListExprFormat  value="detail_nm^0^100">
													</object>
													<%=HDConstant.COMMENT_END%>	
       												
												</td>
											</tr>
											<tr>
												<td  width='120px' height='30px' class='boardt02'>주소1</td>
												<td  bgcolor='#FFFFFF' colspan='3'>
													&nbsp;&nbsp;<input type='text' id='address1' 		name='address1' 		value='' maxlength='60' size='50' 	class='textbox'> <!-- 주소1 -->
												</td>
											</tr>
											<tr>
												<td  width='120px' height='30px' class='boardt02'>주소2</td>
												<td  bgcolor='#FFFFFF'colspan='3'>
													&nbsp;&nbsp;<input type='text' id='address2' 		name='address2' 		value='' maxlength='60' size='50' 	class='textbox'> <!-- 주소2 -->
												</td>
											</tr>

											<tr>
												<td  width='120px' height='30px' class='boardt02'>은행코드</td>
												<td  bgcolor='#FFFFFF'>
													 <input type='hidden' id='bancod' 			name='bancod' 			value='' maxlength='6' 	size='6' 	class='textbox' readonly> <!-- 은행코드 -->
													 &nbsp;&nbsp;<input type='text' id='bannam' 			name='bannam' 			value='' maxlength='30' size='10' 	class='textbox'> <!-- 은행명 -->
													 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="은행코드를 검색합니다"  style="cursor:pointer" id="zipcode_btn" onclick="fnCommonCodePopup('AC002','은행코드');" align='absmiddle'>
												</td>
												<td  width='120px' height='30px' class='boardt02'>계좌번호</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;&nbsp;<input type='text' id='bank_acc_no' 		name='bank_acc_no' 		value='' maxlength='20' size='20' 	class='textbox'> <!-- 은행계좌번호 -->
												</td>
											</tr>
											<tr>
												<td  width='120px' height='30px' class='boardt02'>예금주</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;&nbsp;<input type='text' id='bank_acct_nm' 	name='bank_acct_nm' 	value='' maxlength='32' size='20' 	class='textbox'> <!-- 예금주 -->
												</td>
												<td  width='100px' height='30px' class='boardt02'>사용유무</td>
												<td  bgcolor='#FFFFFF'>&nbsp;
													<!-- <input type='hidden' id='use_yn' 			name='use_yn' 			value='' maxlength='1' 	size='1' 	class='textbox'> <!-- 사용여부 -->
													<!-- &nbsp;&nbsp;<input type='text' id='use_yn_name' 		name='use_yn_name' 		value='' maxlength='50' size='10' 	class='textbox'> <!-- 사용여부명 -->
													<%=HDConstant.COMMENT_START%>
						                            <object id=use_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
														<param name=ComboDataID		value=codeDs5>
														<param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
														<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
														<param name=ListExprFormat  value="detail_nm^0^100">
													</object>
													<%=HDConstant.COMMENT_END%>	
													
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
                    <C>Col=client_sid      	Ctrl=client_sid         Param=value </C>
                    <C>Col=vend_cd         	Ctrl=vend_cd            Param=value </C>
                    <C>Col=vend_nm         	Ctrl=vend_nm            Param=value </C>
                    <C>Col=client_cd       	Ctrl=client_cd          Param=Text </C>
                    <C>Col=client_nm        Ctrl=client_nm          Param=value </C>
                    <C>Col=client_gu        Ctrl=client_gu          Param=value </C>
                    <C>Col=agen_gu          Ctrl=agen_gu            Param=BindColVal </C>
                    <C>Col=agen_gu_name     Ctrl=agen_gu_name       Param=value </C>
                    <C>Col=dir_yn           Ctrl=dir_yn             Param=BindColVal </C>
                    <C>Col=dir_yn_name      Ctrl=dir_yn_name        Param=value </C>
                    <C>Col=area_cd          Ctrl=area_cd            Param=BindColVal </C>
                    <C>Col=area_cd_name     Ctrl=area_cd_name       Param=value </C>
                    <C>Col=sal_dam_sid      Ctrl=sal_dam_sid        Param=value </C>
                    <C>Col=sal_dam_nm       Ctrl=sal_dam_nm         Param=value </C>
                    <C>Col=client_dam_nm    Ctrl=client_dam_nm      Param=value </C>
                    <C>Col=tel_no           Ctrl=tel_no             Param=value </C>
                    <C>Col=mobile_no        Ctrl=mobile_no          Param=value </C>
                    <C>Col=fax_no           Ctrl=fax_no             Param=value </C>
                    <C>Col=e_mail           Ctrl=e_mail             Param=value </C>
                    <C>Col=zip_cd           Ctrl=zip_cd             Param=Text </C>
                    <C>Col=address1         Ctrl=address1           Param=value </C>
                    <C>Col=address2         Ctrl=address2           Param=value </C>
                    <C>Col=commi_rate       Ctrl=commi_rate         Param=Text </C>
                    <C>Col=cunt_status      Ctrl=cunt_status        Param=BindColVal </C>
                    <C>Col=cunt_status_name	Ctrl=cunt_status_name   Param=value </C>
                    <C>Col=bancod           Ctrl=bancod             Param=value </C>
                    <C>Col=bannam           Ctrl=bannam             Param=value </C>
                    <C>Col=bank_acc_no      Ctrl=bank_acc_no        Param=value </C>
                    <C>Col=bank_acct_nm     Ctrl=bank_acct_nm       Param=value </C>
                    <C>Col=use_yn           Ctrl=use_yn             Param=BindColVal </C>
                    <C>Col=use_yn_name      Ctrl=use_yn_name        Param=value </C>
                    <C>Col=vend_type		Ctrl=vend_type          Param=BindColVal </C>
					<C>Col=vend_id			Ctrl=vend_id			Param=value </C>
            ">
        </object>
        <%=HDConstant.COMMENT_END%>
        <input type="hidden" name="tabFlag" value="1"> 
        <input type="hidden" name="rowNum" value="">
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

