<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 대리점등록
 * 프로그램ID 	: CU040I
 * J  S  P		: cu040i
 * 서 블 릿		: Cu040I
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-06-13
 * 기능정의		 : 대리점 신규 입력 / 수정
  * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
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
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			cfStyleGrid(getObjectFirst("gr3"), "comn");
			cfStyleGrid(getObjectFirst("gr4"), "comn");
			
			fnInit(); 

			codeDs1.deleteRow(1);
			codeDs2.deleteRow(1);
			codeDs3.deleteRow(1);
			codeDs4.deleteRow(1);
			codeDs5.deleteRow(1);
			codeDs7.deleteRow(1);
			
			agen_gu.index = 0;
			dir_yn.index = 0;
			area_cd.index = 0;
			cunt_status.index = 0;
			use_yn.index = 0;
			
			fnSetHeaderDs1();
			fnSetHeaderDs2();
			fnSetHeaderDs3();
			fnSetHeaderDs4();
		} 
			
		/*
		 * 데이터셋 헤더 설저 (디테일)
		 */
		function fnSetHeaderDs1(){
			if (ds1.countrow<1){
				var s_temp = ""
/*				+"client_sid:INT,vend_cd:STRING,vend_nm:STRING,client_cd:STRING,client_nm:STRING,"  	
				+"client_gu:STRING,agen_gu:STRING,agen_gu_name:STRING,dir_yn:STRING,dir_yn_name:STRING,"    
				+"area_cd:STRING,area_cd_name:STRING,sal_dam_sid:STRING,sal_dam_nm:STRING,client_dam_nm:STRING,  "
				+"tel_no:STRING,mobile_no:STRING,fax_no:STRING,e_mail:STRING,zip_cd:STRING,"     	
				+"address1:STRING,address2:STRING,commi_rate:INT,cunt_status:STRING,cunt_status_name:STRING,"
				+"bancod:STRING,bannam:STRING,bank_acc_no:STRING,bank_acct_nm:STRING,use_yn:STRING,use_yn_name:STRING";
*/
				+ "CLIENT_SID:INT,VEND_CD:STRING,CLIENT_CD:STRING,CLIENT_NM:STRING,CLIENT_GU:STRING,AGEN_GU:STRING,DIR_YN:STRING,AREA_CD:STRING,SAL_DAM_SID:INT,CLIENT_DAM_NM:STRING,TEL_NO:STRING,MOBILE_NO:STRING,FAX_NO:STRING,E_MAIL:STRING,ZIP_CD:STRING,ADDRESS1:STRING,ADDRESS2:STRING,COMMI_RATE:DOUBLE,CUNT_STATUS:STRING,BANCOD:STRING,BANK_ACC_NO:STRING,BANK_ACCT_NM:STRING,USE_YN:STRING,U_EMPNO:STRING,U_DATE:STRING,U_IP:STRING";
				
				ds1.SetDataHeader(s_temp);
			}
		}		
		
		function fnSetHeaderDs2(){
			if (ds2.countrow<1){
				var s_temp = ""
				//+"client_sid:INT,cont_date:STRING,expire_date:STRING,insur_amt:STRING,insur_comp_cd:STRING,insur_comp_cd_name:STRING";
				 + "CLIENT_SID:INT,CONT_DATE:STRING,EXPIRE_DATE:STRING,INSUR_AMT:INT,INSUR_COMP_CD:STRING,INSUR_COMP_CD_NAME:STRING,U_EMPNO:STRING,U_DATE:STRING,U_IP:STRING";
				
				ds2.SetDataHeader(s_temp);
			}
		}		
		
		function fnSetHeaderDs3(){
			if (ds3.countrow<1){
				var s_temp = ""
				//+"client_sid:INT,branch_cd:STRING,branch_nm:STRING,area_cd:STRING,"
				//+"client_down_yn:STRING,empno:STRING,tel_no:STRING,mobile_no:STRING,fax_no:STRING,"
				//+"branch_url:STRING,area_nm:STRING,client_down_yn_name:STRING";
				+ "CLIENT_SID:INT,BRANCH_CD:STRING,BRANCH_NM:STRING,AREA_CD:STRING,AREA_NM:STRING,CLIENT_DOWN_YN:STRING,CLIENT_DOWN_YN_NAME:STRING,EMPNO:STRING,TEL_NO:STRING,MOBILE_NO:STRING,FAX_NO:STRING,BRANCH_URL:STRING,U_EMPNO:STRING,U_DATE:STRING,U_IP:STRING";
				ds3.SetDataHeader(s_temp);
			}
		}		
		
		function fnSetHeaderDs4(){
			if (ds4.countrow<1){
				var s_temp = ""
				
					+ "CLIENT_SID:INT,"
					+ "FR_DATE:STRING,"
					+ "TO_DATE:STRING,"
					+ "COMMI_RATE:DOUBLE"
				ds4.SetDataHeader(s_temp);
			}
		}	
							
		 
		/*
		 * 초기작업
		 * Header 설정 
		 */
		function fnInit(){
    	   jobFlag = "INIT";
        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_CU%>Cu040I",
            	"JSP(O:AGENGU=codeDs1,O:DIRYN=codeDs2,O:AREACD=codeDs3,O:CUNTSTATUS=codeDs4,O:USEYN=codeDs5,O:INSURCOMPCD=codeDs6,O:CLIENTDOWNYN=codeDs7,O:S_USEYN=sCodeDs1)",            	
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);
		}
			
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			if (ds1.IsUpdated==false || !ds2.IsUpdated==false || !ds3.IsUpdated==false || !ds4.IsUpdated==false) {
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				          + ",sClient_nm="+ sClient_nm.value
				          + ",sSal_dam_sid=" + sSal_dam_sid.value
				          + ",sUse_yn=" + sUse_yn.ValueOfIndex("detail", sUse_yn.Index);
				
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_CU%>Cu040I",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			} else {
				alert("작업중인 상태에서는 조회할수 없습니다!");
			}
		}
			
		
		/*
		 * 계약정보, 지점조회
		 */	
		function fnSelectDs1() {
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sClient_sid=" + ds1.namevalue(ds1.rowposition,"client_sid");
			         
			
			ln_TRSetting(tr2, 
			    "<%=dirPath%><%=HDConstant.PATH_CU%>Cu040I",
			    "JSP(O:DS3=ds3,O:DS2=ds2,O:DS4=ds4)",
			    param);
			tr_post(tr2);
		}
			
			
		/*
		 * 행추가 , 신규 
		 */
		function fnAddRowDs1() {
		
			if (!ds1.isUpdated) {
				jobFlag = "N";
				ds1.addRow();
				rowNum.value = ds1.rowposition;
				
				ds1.namevalue(ds1.rowposition,"client_gu") = "1";
				ds2.ClearAll();
				ds3.ClearAll();
				ds4.ClearAll();
				
				fnSetHeaderDs2();
				fnSetHeaderDs3();
				fnSetHeaderDs4();
			} else {
				alert("신규작업 중입니다 저장후에 등록하세요!");
				return;
			}
				
		}
			
		function fnAddRow() {
			if (tabFlag.value == "1") {
				if (ds1.namevalue(ds1.rowposition, "client_cd") == "" || ds1.namevalue(ds1.rowposition,"client_cd") == undefined ) {
					alert("대리점 코드가 없는 상태에서는 추가할수 없습니다!");
					return;
				} else {
					fnAddRowDs2();
				}
			} else if (tabFlag.value == "2") {
				if (ds1.namevalue(ds1.rowposition, "client_cd") == "" || ds1.namevalue(ds1.rowposition,"client_cd") == undefined) {
					alert("대리점 코드가 없는 상태에서는 추가할수 없습니다!");
					return;
				} else {
					fnAddRowDs3();
				}
			} else if (tabFlag.value == "3") {
				if (ds1.namevalue(ds1.rowposition, "client_cd") == "" || ds1.namevalue(ds1.rowposition,"client_cd") == undefined) {
					alert("대리점 코드가 없는 상태에서는 추가할수 없습니다!");
					return;
				} else {
					fnAddRowDs4();
				}
			}
		}
		function fnAddRowDs2() {
			//if (jobFlag == "N") {
			//	ds2.addRow();
			//	gr2.setcolumn("cont_date");				
			//} else {
				ds2.addRow();
				ds2.namevalue(ds2.rowposition, "client_sid") = ds1.namevalue(ds1.rowposition, "client_sid");
				gr2.setcolumn("cont_date");
			//}
		}
		
		function fnAddRowDs3() {
			//if (jobFlag == "N") {
			//	ds3.addRow();
			//	gr3.setcolumn("branch_cd");
			//} else {
				ds3.addRow() ;
				
				ds3.namevalue(ds3.rowposition, "client_sid") = ds1.namevalue(ds1.rowposition, "client_sid");
				gr3.setcolumn("branch_cd");
			//}
		}
		
		function fnAddRowDs4() {
			//if (jobFlag == "N") {
			//	ds3.addRow();
			//	gr3.setcolumn("branch_cd");
			//} else {
				ds4.addRow() ;
				
				ds4.namevalue(ds4.rowposition, "client_sid") = ds1.namevalue(ds1.rowposition, "client_sid");
				gr4.setcolumn("fr_date");
			//}
		}
		
		
		
		function fnDeleteRowDs1() {
			jobFlag = "D";
			ds1.deleterow(ds1.rowposition);
			ds2.deleteAll();
			ds3.deleteAll();
			ds4.deleteAll();
		}
		/*
		 * 행삭제, 삭제
		 */
		function fnDeleteRow() {
		jobFlag = "D";
			if (tabFlag.value == "1") {
				fnDeleteRowDs2();
			} else if (tabFlag.value == "2") {
				fnDeleteRowDs3();
			} else if (tabFlag.value == "3") {
				fnDeleteRowDs4();
			} else {
				fnDeleteRowDs2();
			}
		}
			
		function fnDeleteRowDs2() {
			ds2.deleterow(ds2.rowposition);
		}
		
		function fnDeleteRowDs3() {
			ds3.deleterow(ds3.rowposition);
		}	
		
		function fnDeleteRowDs4() {
			ds4.deleterow(ds4.rowposition);
		}	

		 
		/*
		 * 입력 체크
		 */
		function fnCheck() {
		 if (ds1.IsUpdated) {
				if (jobFlag != "D") {
			  	if(ds1.NameValue(ds1.rowposition, "client_cd")=="") {
                 	alert("대리점 코드를 입력하세요!");
                 	getObjectFirst("client_cd").focus();
                 	return;
                 }
                 
			 	if(ds1.NameValue(ds1.rowposition, "client_nm")==""){
                    alert("대리점명을 입력하세요!");
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
		  		if(ds1.NameValue(ds1.rowposition, "ange_gu")=="") {
                 	alert("대리점구분을 선택하세요!");
                 	getObjectFirst("ange_gu").focus();
                 	return;
                 }
		  		if(ds1.NameValue(ds1.rowposition, "dir_yn")=="") {
                 	alert("직판여부를 선택하세요!");
                 	getObjectFirst("dir_yn").focus();
                 	return;
                 }
		  		if(ds1.NameValue(ds1.rowposition, "client_dam_nm")=="") {
                 	alert("대리점담당자를 입력하세요!");
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
                 
                if(ds1.NameValue(ds1.rowposition, "commi_rate") =="") {
                	alert("수수료율을 입력하세요!");
                	getObjectFirst("commi_rate").focus();
                 	return;
                }
		  		if(ds1.NameValue(ds1.rowposition, "cunt_status")=="") {
                 	alert("계약상태를 선택하세요!");
                 	getObjectFirst("cunt_status").focus();
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
		
		if (ds2.IsUpdated) {	 
			 for(var i=1; i<=ds2.CountRow; i++){
			 	if(ds2.NameValue(i, "cont_date")=="") {
                 	alert("계약일자를 입력하세요!");
                 	gr2.setcolumn("cont_date");
                 	return;
                 }
			 	if(ds2.NameValue(i, "expire_date")=="") {
                 	alert("만료일자를 입력하세요!");
                 	gr2.setcolumn("expire_date");
                 	return;
                 }
			 	if(ds2.NameValue(i, "insur_amt")=="") {
                 	alert("보험료를 입력하세요!");
                 	gr2.setcolumn("insur_amt");
                 	return;
                 }
			 	if(ds2.NameValue(i, "insur_comp_cd")=="") {
                 	alert("보험회사를 입력하세요!");
                 	gr2.setcolumn("insur_comp_cd_name");
                 	return;
                 }
			 }
		}
		
		if (ds3.IsUpdated) {
			 for(var i=1; i<=ds3.CountRow; i++){
			 	if(ds3.NameValue(i, "branch_cd")=="") {
                 	alert("지점코드를 입력하세요!");
                 	gr3.setcolumn("branch_cd");
                 	return;
                }
			 	if(ds3.NameValue(i, "branch_nm")=="") {
                 	alert("지점명을 입력하세요!");
                 	gr3.setcolumn("branch_nm");
                 	return;
                }                
			 	if(ds3.NameValue(i, "area_cd")=="") {
                 	alert("지역을 선택하세요!");
                 	gr3.setcolumn("area_nm");
                 	return;
                }                  
			 	if(ds3.NameValue(i, "client_down_yn")=="") {
                 	alert("본점여부 선택하세요!");
               	 	gr3.setcolumn("client_down_yn_name");
                 	return;
                }                  
			 	if(ds3.NameValue(i, "empno")=="") {
                 	alert("담당자를 입력하세요!");
                 	gr3.setcolumn("empno");
                 	return;
                }                  
			 	if(ds3.NameValue(i, "tel_no")=="") {
                 	alert("전화번호를 입력하세요!");
                 	gr3.setcolumn("tel_no");
                 	return;
                }                  
			 	if(ds3.NameValue(i, "mobile_no")=="") {
                 	alert("휴대폰번호를 선택하세요!");
                 	gr3.setcolumn("mobile_no");
                 	return;
                }                  
			 	if(ds3.NameValue(i, "fax_no")=="") {
                 	alert("팩스번호를 입력하세요!");
                 	gr3.setcolumn("fax_no");
                 	return;
                }                  
			 	if(ds3.NameValue(i, "branch_url")=="") {
                 	alert("지점홈페이지를 입력하세요!");
                 	gr3.setcolumn("branch_url");
                 	return;
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
			
			if (ds1.IsUpdated || ds2.IsUpdated || ds3.IsUpdated || ds4.IsUpdated) {
				if(fnCheck()){
				  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu040I",
	                "JSP(I:DS1=ds1,I:DS2=ds2,I:DS3=ds3,I:DS4=ds4)",
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
			ds2.undoall();
			ds3.undoall();
			ds4.undoall();
			
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
		 * 대리점 팝업
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
				
				if (head == 'CU010') {				// 보증보험회사 
		   			ds2.namevalue(ds2.rowposition, "insur_comp_cd") = arrParam[1];
		   			ds2.namevalue(ds2.rowposition, "insur_comp_cd_name")  = arrParam[2];
				} else if (head == 'SY006') {		// 지역
		   			ds3.namevalue(ds3.rowposition, "area_cd") = arrParam[1];
		   			ds3.namevalue(ds3.rowposition, "area_nm") = arrParam[2];
				} else if (head == 'AC002') {		// 은행 
					bancod.value = arrParam[1];
					bannam.value = arrParam[2];
				} else if (head = 'CU001') {
					ds3.namevalue(ds3.rowposition,"client_down_yn") = arrParam[1];
					ds3.namevalue(ds3.rowposition,"client_down_yn_name") = arrParam[2];
					
					
				}		
				
	
			} else {
				if (head == 'CU010') {			// 보증보험회사 
				  ds2.namevalue(ds2.rowposition, "insur_comp_cd") = "";
				  ds2.namevalue(ds2.rowposition, "insur_comp_cd_name") = "";
				} else if (head == 'SY006') {		// 지역 
				  ds3.namevalue(ds3.rowposition, "area_cd") = ""
				  ds3.namevalue(ds3.rowposition, "area_nm") = "";
				} else if (head == 'AC002') {	// 은행 
					bancod.value = "";
					bannam.value = "";
				} else if (head = 'CU001') {
					ds3.namevalue(ds3.rowposition,"client_down_yn") = "";
					ds3.namevalue(ds3.rowposition,"client_down_yn_name") = "";
					
				}
			}
			return ;	
		}		
		
		</script>
		

<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>

	<script language="javascript"  for=gr1 event=OnClick(Row,Colid)>
	if (ds1.IsUpdated || ds2.IsUpdated || ds3.IsUpdated || ds4.IsUpdated) {
			if (confirm("지금 현재 작업중인 데이터가 있습니다. 진행하시겠습니까?")) {
				if (Row >0 ) {
					
					rowNum.value = ds1.rowposition;
					fnCancel();
				//	fnSelectDs1();
				}
				
				
			} else {
				ds1.rowposition = rowNum.value;
				
			}
		} else {
			if (Row >0 ) {
				rowNum.value = Row;
				fnSelectDs1();
			}
		}
	</script>
	
 
 	<script language=JavaScript for=ds1 event=OnLoadCompleted(rowcnt)>
		if (rowcnt >0 ) {
			rowNum.value = rowcnt;
			fnSelectDs1();
		}
	</script>
 
 	
	
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="작업이 성공적으로 완료되었습니다.";
	</script>	
	<script language="javascript" for="tr2" event="OnFail()">
		//20070921 추가 
	    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	
	    var error_cnt = tr1.SrvErrCount("ERROR");
	    var error_msg = "";
	    for(var i=0; i<error_cnt; i++){
	        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
	    }
	    if(error_msg!="") 
	        alert(error_msg);
	    else
	        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
	</script>	
	
	
	
	<script language=JavaScript for=mxTab event=OnSelChanged(index)>
		if (index == 1) {
			tabFlag.value = "1";
		} else if (index == 2) {
			tabFlag.value = "2";
		} else if (index == 3) {
			tabFlag.value = "3";
		}
	</script>
	
	<script language=JavaScript for=gr2 event=OnPopup(row,colid,data)>
		if(colid=="insur_comp_cd_name") {
			fnCommonCodePopup('CU010', '보증보험회사코드');
		}
	</script>
	<script language=JavaScript for=gr3 event=OnPopup(row,colid,data)>
		if(colid=="client_down_yn_name") {
			fnCommonCodePopup('CU011', '하위대리점여부');
		}
		if(colid=="area_nm") {
			fnCommonCodePopup('SY006', '지역코드');
		}
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
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  계약정보 -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  지점정보 -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  수수료정보 -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  대리점구분 -->
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
<object id=codeDs7 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  하위대리점 여부 -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=sCodeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  사용유무 -->
	<param name="SyncLoad" 	value="false">
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<table border='0' cellpadding='0' cellspacing='0' width='845'>	
	<tr>
		<td width='525px'>
			<table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666">
				<tr>
					<td width='70px' height="30px" class='text'>대리점</td>
					<td width='100px' bgcolor='#FFFFFF' align='center'>
						<input type='hidden'  	name='sClient_cd' 		value='' maxlength='10' 	size='10' 	class='textbox'>
						<input type='text' 		name='sClient_nm' 		value='' maxlength='30' 	size='10' 	class='textbox'>
					</td>
					<td width='70px' class='text'>담당자</td>
					<td width='120px' bgcolor='#FFFFFF' align='center'>
						<input type='hidden'  		name='sSal_dam_sid' 		value='' maxlength='10' 	size='5' 	class='textbox'  >
						<input type='text'  		name='sSal_dam_nm' 			value='' maxlength='10' 	size='10' 	class='textbox' readonly onClick="javascript:fnSalDamPopup('S');">
						<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="영업담당자를 검색합니다"  style="cursor:hand" id="zipcode_btn" onclick="javascript:fnSalDamPopup('S');" align='absmiddle'>
					<td width='80px' class='text' >사용유무</td>
					<td width='100px' bgcolor='#FFFFFF' align='center'>
						<%=HDConstant.COMMENT_START%>
                           <object id=sUse_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=120 width=80 border="0" align=absmiddle>
							<param name=ComboDataID		value=sCodeDs1>
							<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
							<param name=ListExprFormat  value="detail_nm^0^100">
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
						<img src="<%=dirPath%>/Sales/images/new.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRowDs1()" >
						<img src="<%=dirPath%>/Sales/images/delete.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRowDs1()" >
						<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
						<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
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
						<table  border='0' cellpadding='0' cellspacing='0' width='200px' height='440px' >
							<tr>
								<td>
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='200px' height='440px' border='1'>
										<param name="DataID"			value="ds1">
										<param name="ColSizing"			value="true">
										<param name="Fillarea"			value="false">
										<param name="Editable"  		value="false">
										<param name="BorderStyle"       value="0">
										<param name=SortView  			value="Left">

										
										<param name="Format" 			value="

							                <C> name='대리점SID'   	ID='client_sid' 		Width=100  align=left editlimit=12 	show=false</C>
							                <C> name='거래처코드'    	ID='vend_cd'    		Width=100  align=left editlimit=13 	show=false</C>
							                <C> name='거래처명'      	ID='vend_nm'    		Width=100  align=left editlimit=62 	show=false</C>
							                <C> name='코드'    	ID='client_cd'  		Width=50  align=left editlimit=5 	show=true sort=true</C>
							                <C> name='대리점명'    	ID='client_nm'  		Width=183  align=left editlimit=30 	show=true sort=true</C> <!-- 대리점명 : 대리점명 -->
							                
							                <C> name='대리점구분'    	ID='client_gu'  		Width=100  align=left editlimit=1 	show=false</C> <!-- 대리점 구분 1 = 대리점 -->
							                <C> name='대리점구분'    	ID='agen_gu'    		Width=100  align=left editlimit=1 	show=false</C>
							                <C> name='대리점구분명' 	ID='agen_gu_name'   	Width=100  align=left editlimit=50 	show=false</C>
							                <C> name='직판여부'      	ID='dir_yn'     		Width=100  align=left editlimit=1 	show=false</C>
							                <C> name='직판여부명'  	ID='dir_yn_name'    	Width=100  align=left editlimit=50 	show=false</C>

							                <C> name='지역코드'      	ID='area_cd'    		Width=100  align=left editlimit=2 	show=false</C>
							                <C> name='지역코드명' 	ID='area_cd_name'   	Width=100  align=left editlimit=50 	show=false</C>
							                <C> name='영업담당자SID' 	ID='sal_dam_sid'    	Width=100  align=left editlimit=12 	show=false</C>
							                <C> name='영업담당자명'   ID='sal_dam_nm' 		Width=100  align=left editlimit=22 	show=false</C>
							                <C> name='대리점담당자'  	ID='client_dam_nm'  	Width=100  align=left editlimit=20 	show=false</C>

							                <C> name='전화번화 '     	ID='tel_no'    			Width=100  align=left editlimit=20 	show=false</C>
							                <C> name='휴대전화'    	ID='mobile_no'  		Width=100  align=left editlimit=15 	show=false</C>
							                <C> name='팩스번호'      	ID='fax_no'     		Width=100  align=left editlimit=20 	show=false</C>
							                <C> name='이메일'       	ID='e_mail'     		Width=100  align=left editlimit=30 	show=false</C>
							                <C> name='우편번호'      	ID='zip_cd'     		Width=100  align=left editlimit=6 	show=false</C>

							                <C> name='주소1'     	ID='address1'   		Width=100  align=left editlimit=60 	show=false</C>
							                <C> name='주소2'     	ID='address2'   		Width=100  align=left editlimit=60 	show=false</C>
							                <C> name='수수료율'   	ID='commi_rate' 		Width=100  align=left editlimit=7 	show=false</C>
							                <C> name='계약상태'  		ID='cunt_status'        Width=100  align=left editlimit=1 	show=false</C>
							                <C> name='계약상태명' 	ID='cunt_status_name'   Width=100  align=left editlimit=50 	show=false</C>

							                <C> name='은행코드'      	ID='bancod'     		Width=100  align=left editlimit=6 	show=false</C>
							                <C> name='은행명'       	ID='bannam'     		Width=100  align=left editlimit=30 	show=false</C>
							                <C> name='은행계좌번호'  	ID='bank_acc_no'        Width=100  align=left editlimit=20 	show=false</C>
							                <C> name='예금주' 		ID='bank_acct_nm'       Width=100  align=left editlimit=32 	show=false</C>
							                <C> name='사용여부'      	ID='use_yn'     		Width=100  align=left editlimit=1 	show=false</C>

							                <C> name='사용여부명'  	ID='use_yn_name'        Width=100  align=left editlimit=50 	show=false</C>
							                <C> name='홈페이지'  	ID='client_url'        Width=100  align=left editlimit=50 	show=true</C>
							        	">											
									</object>	
									<%=HDConstant.COMMENT_END%>								
								</td>
							</tr>
						</table>
					</td>
					<td width='10px'></td>
					<td valign='top'>
						<table border='0' cellpadding='0' cellspacing='0' width='630px'>
							<tr>
								<td width='530px'height='244px'>
									<table border='0' cellpadding='0' cellspacing='1' width='630px' height='244px' bgcolor="#666666">
										<tr>
											<td width='100px' class='boardt02'>대리점코드</td>
											<td  width='165px' bgcolor='#FFFFFF'>&nbsp;
												<!-- <input type='text' id='client_cd' 		name='client_cd' 		value='' maxlength='5' 	size='5' 	class='textbox' > <!-- 대리점 코드 -->
												
												<%=HDConstant.COMMENT_START%>
												<object id=client_cd classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='60px' align='absmiddle' class='textbox'>			
													<param name=Alignment 	value=1>
													<param name=Format 		value="00000">
													<param name=Enable      value="true">
                                                       <param name=Border   	value=false>
												</object>
												<%=HDConstant.COMMENT_END%>
			
											</td>
											<td  width='100px' class='boardt02'>대리점명</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												&nbsp;
												<input type='text' id='client_nm' 		name='client_nm' 		value='' maxlength='30' size='20' 	class='textbox' > <!-- 대리점 명 -->
												
											</td>
										</tr>
										<tr>
											<td  width='100px' class='boardt02'>거래처명</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												<input type='hidden' id='vend_cd' 			name='vend_cd' 			value='' maxlength='13' size='10' 	class='textbox'> <!-- 거래처코드 -->
												&nbsp;&nbsp;<input type='text' id='vend_nm' 			name='vend_nm' 			value='' maxlength='62' size='15' 	class='textbox' readonly> <!-- 거래처명 -->
												<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="거래처를 검색합니다"  style="cursor:hand" id="vend_btn" onclick="javascript:fnVendPopup();" align='absmiddle'>
											</td>
											<td  width='100px' class='boardt02'>영업담당자</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												<input type='hidden' id='sal_dam_sid' 		name='sal_dam_sid' 		value='' maxlength='12' size='12' 	class='textbox' readonly> <!-- 영업담당자코드 -->
      												&nbsp;&nbsp;<input type='text' id='sal_dam_nm' 		name='sal_dam_nm' 		value='' maxlength='22' size='10' 	class='textbox' readonly> <!-- 영업담당자명 -->
      												<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="영업담당자를 검색합니다"  style="cursor:hand" id="sal_dam_btn" onclick="javascript:fnSalDamPopup('I');" align='absmiddle'>
											</td>
										</tr>
										<tr>
											<td  width='100px' class='boardt02'>대리점 구분</td>
											<td  width='165px' bgcolor='#FFFFFF'>&nbsp;
												 <!-- <input type='hidden' id='agen_gu' 			name='agen_gu' 			value='' maxlength='1' 	size='1' 	class='textbox'> <!-- 대리점 구분 -->
     												 <!-- &nbsp;&nbsp;<input type='text' id='agen_gu_name' 	name='agen_gu_name' 	value='' maxlength='50' size='10' 	class='textbox'> <!-- 대리점 구분명-->
     												<%=HDConstant.COMMENT_START%>
					                            <object id=agen_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=codeDs1>
													<param name=BindColumn      value="detail">
                                                       <param name=BindColVal      value="detail">
													<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
													<param name=ListExprFormat  value="detail_nm^0^100">
												</object>
												<%=HDConstant.COMMENT_END%>	
     												 
											</td>
											<td  width='100px' class='boardt02'>직판여부</td>
											<td  width='165px' bgcolor='#FFFFFF'>&nbsp;
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
											<td  width='130px' class='boardt02'>대리점담당자</td>
											<td  bgcolor='#FFFFFF'>
												&nbsp;&nbsp;<input type='text' id='client_dam_nm' 	name='client_dam_nm' 	value='' maxlength='20' size='20' 	class='textbox'> <!-- 대리점담당자 -->
											</td>
											<td  width='100px' class='boardt02'>홈페이지</td>
											<td bgcolor='#FFFFFF'>
												&nbsp;&nbsp;<input type='text' id='client_url' 	name='client_url' 	value='' maxlength='50' size='30' 	class='textbox'> <!-- 홈페이지 -->
											</td>
										</tr>
										<tr>
											<td  width='100px' class='boardt02'>전화번호</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												&nbsp;&nbsp;<input type='text' id='tel_no' 			name='tel_no' 			value='' maxlength='20' size='20' 	class='textbox'> <!-- 전화번호 -->
												
											</td>
											<td  width='100px' class='boardt02'>휴대전화</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												&nbsp;&nbsp;<input type='text' id='mobile_no' 		name='mobile_no' 		value='' maxlength='15' size='20' 	class='textbox'> <!-- 휴대전화 -->
											</td>
										</tr>

										<tr>
											<td  width='100px' class='boardt02'>팩스번호</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												&nbsp;&nbsp;<input type='text' id='fax_no' 			name='fax_no' 			value='' maxlength='20' size='20' 	class='textbox'> <!-- FAX번호 -->
											</td>
											<td  width='100px' class='boardt02'>메일주소</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												 &nbsp;&nbsp;<input type='text' id='e_mail' 			name='e_mail' 			value='' maxlength='30' size='23' 	class='textbox'> <!-- 이메일 -->
											</td>
										</tr>
										<tr>
											<td  width='100px' class='boardt02'>우편번호</td>
											<td  width='165px' bgcolor='#FFFFFF'>&nbsp;
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
												<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="우편번호를 검색합니다"  style="cursor:hand" id="zipcode_btn" onclick="fnZipCodePopup();" align='absmiddle'>													
											</td>
											<td  width='100px' class='boardt02'>지역코드</td>
											<td  width='165px' bgcolor='#FFFFFF'>&nbsp;
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
											<td  width='100px' class='boardt02'>주소1</td>
											<td  width='495px' bgcolor='#FFFFFF' colspan='3'>
												&nbsp;&nbsp;<input type='text' id='address1' 		name='address1' 		value='' maxlength='60' size='50' 	class='textbox'> <!-- 주소1 -->
											</td>
										</tr>
										<tr>
											<td  width='100px' class='boardt02'>주소2</td>
											<td  width='495px' bgcolor='#FFFFFF'colspan='3'>
												&nbsp;&nbsp;<input type='text' id='address2' 		name='address2' 		value='' maxlength='60' size='50' 	class='textbox'> <!-- 주소2 -->
											</td>
										</tr>

										<tr>
											<td  width='100px' class='boardt02'>수수료율</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												&nbsp;<!-- <input type='text' id='commi_rate' 		name='commi_rate' 		value='' maxlength='7' 	size='7' 	class='textbox'> <!-- 수수료율 -->
																									
												<%=HDConstant.COMMENT_START%>
												<object id=commi_rate classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='60px' align='absmiddle' class='textbox'>			
													<param name=Alignment 	value=1>
													<param name=Enable      value="true">
                                                       <param name=Border   	value=false>
                                                       <param name=MaxDecimalPlace   value=2>
                                                       
												</object>
												<%=HDConstant.COMMENT_END%>

											</td>
											<td  width='100px' class='boardt02'>계약상태</td>
											<td  width='165px' bgcolor='#FFFFFF'>&nbsp;
												<!-- <input type='hidden' id='cunt_status' 		name='cunt_status' 		value='' maxlength='1' 	size='1' 	class='textbox'> <!-- 계약상태 -->
												<!-- &nbsp;&nbsp;<input type='text' id='cunt_status_name' name='cunt_status_name' value='' maxlength='50' size='10' 	class='textbox'> <!-- 계약상태명 -->
     												<%=HDConstant.COMMENT_START%>
					                            <object id=cunt_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
													<param name=ComboDataID		value=codeDs4>
													<param name=BindColumn      value="detail">
                                                       <param name=BindColVal      value="detail">
													<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
													<param name=ListExprFormat  value="detail_nm^0^100">													</object>
												<%=HDConstant.COMMENT_END%>														
											</td>
										</tr>
										<tr>
											<td  width='100px' class='boardt02'>은행코드</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												 <input type='hidden' id='bancod' 			name='bancod' 			value='' maxlength='6' 	size='15' 	class='textbox' readonly> <!-- 은행코드 -->
												 &nbsp;&nbsp;<input type='text' id='bannam' 	readonly="readonly"		name='bannam' 			value='' maxlength='30' size='15' 	class='textbox'> <!-- 은행명 -->
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="은행코드를 검색합니다"  style="cursor:hand" id="zipcode_btn" onclick="fnCommonCodePopup('AC002','은행코드');" align='absmiddle'>
											</td>
											<td  width='100px' height='22px' class='boardt02'>계좌번호</td>
											<td  width='165px' height='22px' bgcolor='#FFFFFF'>
												&nbsp;&nbsp;<input type='text' id='bank_acc_no' 		name='bank_acc_no' 		value='' maxlength='20' size='20' 	class='textbox'> <!-- 은행계좌번호 -->
											</td>
										</tr>
										<tr>
											<td  width='100px' class='boardt02'>예금주</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												&nbsp;&nbsp;<input type='text' id='bank_acct_nm' 	name='bank_acct_nm' 	value='' maxlength='32' size='20' 	class='textbox'> <!-- 예금주 -->
											</td>
											<td  width='100px' class='boardt02'>사용유무</td>
											<td  width='165px' bgcolor='#FFFFFF'>&nbsp;
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
							<tr>
								<td>
									<table  border='0' cellpadding='0' cellspacing='0' width='630px'>
										<tr>
											<td align='left'>
												<%=HDConstant.COMMENT_START%>
												<object id=mxTab classid=<%=HDConstant.CT_TAB_CLSID%> width='200px' height='20px'> 
													<param name="BackColor"			value="#00FFFF">
													<param name="DisableBackColor"	value="#fffff0">
													<param name="Format"			value='
														<T>divid="tab1"	title="계약정보"</T>
														<T>divid="tab2"	title="지점정보"</T>
														<T>divid="tab3" title="수수료율"</T>
														'>
												</object>
												<%=HDConstant.COMMENT_END%>
											</td>
											<td width='330px' align='right' valign='top'>
												<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand"	onClick="fnAddRow()" >
												<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand" onClick="fnDeleteRow()" >

											</td>
										<tr>
										<tr>
											<td colspan='2'>
												<div id=tab1 style="position:absolute; left:382; top:476; width:630; height:120">     
													<%=HDConstant.COMMENT_START%>                                                                                                        
													<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> style="left:5; top:5; width=627; height=117" border='1'>                                       
														<param name="DataID"			value="ds2">                                                                                                                            
														<param name="Fillarea"			value="true">                                                                                                                           
														<param name="Editable"  		value="true">                                                                                                                           
														<param name="BorderStyle"       value="0">                                                                                                                       
														<param name="Format" 			value="                                                                                                                                 
														   <C> name='대리점SID'   		ID='client_sid'  		align=left editlimit=12 width=100 show=false</C>
														   <C> name='계약일자'    		ID='cont_date'   		align=left editlimit=8 	width=100 show=true mask='XXXX-XX-XX'</C>
														   <C> name='만료일자'  			ID='expire_date'    	align=left editlimit=8 	width=100 show=true  mask='XXXX-XX-XX'</C>
														   <C> name='보험료'    			ID='insur_amt'   		align=right editlimit=10 width=100 show=true</C>
														   <C> name='보증보험회사'   	ID='insur_comp_cd'  	align=left editlimit=2 	width=227 show=true editstyle=lookup data='codeDs6:detail:detail_nm'</C>
														   <C> name='보증보험회사명'  	ID='insur_comp_cd_name' align=left editlimit=50 width=227 show=false editstyle=popup</C>
														">                                                                                                                                                                              
													</object> 
													<%=HDConstant.COMMENT_END%>	                                                                                                                                                                              
												</div>   
												<div id=tab2 style="position:absolute; left:382; top:476; width:630; height:120">   
													<%=HDConstant.COMMENT_START%>                                                                                                                          
													<object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> style="left:5; top:5; width=627; height=117" border='1'>
														<param name="DataID"			value="ds3">                                                                                                                            
														<param name="Fillarea"			value="true">                                                                                                                           
														<param name="Editable"  		value="true">                                                                                                                           
														 <param name="BorderStyle"       value="0">                                                                                                                                  
														<param name="Format" 			value="                                                                                                                                            
											               <C> name='대리점SID'   			ID='client_sid'  			width=100 align=left editlimit=12 show=false</C>
											               <C> name='지점코드'    			ID='branch_cd'   			width=60 align=left editlimit=3 	show=true</C>
											               <C> name='지점명'    				ID='branch_nm'   			width=100 align=left editlimit=20 show=true</C>
											               <C> name='지역명'      			ID='area_cd'     			width=60 align=left editlimit=2 	show=true editstyle=lookup data='codeDs3:detail:detail_nm'</C>
											               <C> name='지역명'					ID='area_nm'				width=60 align=left editlimit=10 show=false editstyle=popup</C>
											               <C> name='본점여부'       			ID='client_down_yn'      	width=80 align=left editlimit=1 	show=true editstyle=lookup data='codeDs7:detail:detail_nm'</C>
											               <C> name='하위대리점여부명'  		ID='client_down_yn_name'    width=120 align=left editlimit=50 show=false editstyle=popup </C>
											               <C> name='담당자'        			ID='empno'       			width=100 align=left editlimit=7 	show=true</C>
											               <C> name='전화번호'       			ID='tel_no'      			width=100 align=left editlimit=15 show=true</C>
											               <C> name='휴대전화'    			ID='mobile_no'   			width=100 align=left editlimit=15 show=true</C>
											               <C> name='팩스번호'       			ID='fax_no'      			width=100 align=left editlimit=20 show=true</C>
											               <C> name='지점홈페이지'   			ID='branch_url'  			width=100 align=left editlimit=40 show=true</C>
														">                                                                                                                                                                                         
													</object>     
													<%=HDConstant.COMMENT_END%>	      
												</div>
												<div id=tab3 style="position:absolute; left:382; top:476; width:630; height:120">     
													<%=HDConstant.COMMENT_START%>                                                                                                        
													<object id=gr4 classid=<%=HDConstant.CT_GRID_CLSID%> style="left:5; top:5; width=627; height=117" border='1'>
														<param name="DataID"			value="ds4">                                                                                                                            
														<param name="Fillarea"			value="true">                                                                                                                           
														<param name="Editable"  		value="true">                                                                                                                           
														<param name="BorderStyle"       value="0">                                                                                                                       
														<param name="Format" 			value="                                                                                                                                 
														     	<C> name='대리점SID'   ID='client_sid'  width=100 align=left editlimit=12 show=true</C>
															   <C> name='시작일자'      ID='fr_date'     width=100 align=left editlimit=8 show=true mask='XXXX-XX-XX'</C>
															   <C> name='종료일자'      ID='to_date'     width=100 align=left editlimit=8 show=true mask='XXXX-XX-XX'</C>
															   <C> name='수수료율'   ID='commi_rate'  width=100 align=left editlimit=7 show=true</C>
														">                                                                                                                                                                              
													</object> 
													<%=HDConstant.COMMENT_END%>	                                                                                                                                                                              
												</div>                                                                                                                                                                                 
											</td>
											
											   
										</tr>
									</table>
								</td>
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
                     <C>Col=client_url      Ctrl=client_url        Param=value </C>
            ">
        </object>
        <%=HDConstant.COMMENT_END%>
        <input type="hidden" name="tabFlag" value="1"> 
        <input type="hidden" name="rowNum" value="">

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

