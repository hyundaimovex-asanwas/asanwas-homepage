<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  회계관리 - 수정세금계산서
+ 프로그램 ID	:  a040077.jsp
+ 기 능 정 의	:  수정세금계산서 
+ 작   성   자     :  정 영 식
+ 서 블 릿 명	:  a040077_s1
------------------------------------------------------------------------------
+ 수 정 일 자     :  2017.06.22
+ 수   정   자     :  정영식  
+ 수 정 내 용     :  수정세금계산서  저장 및 결재요청 추가
                              매출발행은 정발행 매출 또는 매출관리에서 처리해야 함.
                              당초승인번호를 가져올 때 거래처 정보도 함께 가져옴. (수정불가)          
               ---------------------------------------------------------------
                             현재 매출발행시 매출등록 + 전자세금계산서 발행이 동시에 이루어지는 프로세스를
                             
                             매출등록 ( 당초승인번호도 별도 저장해야함. )
                             수정세금계산서 발행 프로세스 신규                  
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>수정세금계산서</title>

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

var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2  = gcurdate.substring(0,4);
var gs_date3  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;		//user_id
var gs_fdcode = gfdcode;	//지점코드
var gs_deptcd = gdeptcd;	//부서코드
var gs_deptnm = gdeptnm;

var gs_frdt="";
var gs_todt="";

var gs_position =0;


/******************************************************************************
Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	
	gcem_sup_com_regno.text ="2218113834";
	ln_Before();
	ln_Initial();
	ln_User_Chk();
}

function ln_Initial(){
	
	gclx_cocode.bindcolval ="02"; //사업장 서울 기본
	ln_Display_Cocode();
	ln_Taxmst_SetDataHeader();
	ln_Taxdtl_SetDataHeader();
	gcds_taxdtl.addrow();
	ln_sup_vend_info();	
	
	ln_Clear_Byr_Vend();   //공급받는자 정보 
	
	gcem_taxdat.text="";   //계산서일자 
	
	//수정사유
	gcem_modify_reason.text="";
	gcem_modify_reason_nm1.text="";
	gcem_modify_reason_nm2.text="";
	
	//적요
	gcem_erp_remark.text="";
	
	//공급가액, 부가세액, 합계, 수정사유
    gcem_sup_amount.text=0;
    gcem_tax_amount.text=0;
    gcem_total_amount.text=0;
    gcem_amend_code.text="";
    gcem_amend_codenm.text="";
    
    //원가
    txt_costcd.value="";
    txt_costnm.value="";
    
    gclx_taxsts.bindcolval="N";
    gcem_duedate.text ="";
    gcem_taxnbr.text ="";
    
    document.fileForm.reset();
    document.fileForm.fileList.options[0].text="";
    document.fileForm.fileList.options[0].value="";
}

/*
 공급받는쪽 정보
 */
function ln_Clear_Byr_Vend(){
	gcem_vendcd.text   = ""; //거래처 코드  
	txt_vendnm.value = ""; //거래처명
	gcem_vendid.text   =""; //거래처 사업자 등록번호 
	gcem_empnm.text    = ""; //담당자성명           
	gcem_email.text    =""; //Email    
	gcem_byr_com_regno.text= ""; //등록번호
	
	gcem_byr_com_name.text = ""; //상호
	gcem_byr_rep_name.text = ""; //성명
	gcem_byr_com_addr.text = "";//주소
	gcem_byr_bizplace_code.text = ""; //종사업장
	gcem_byr_com_type.text = ""; //업태
	gcem_byr_com_classify.text = ""; //업종
	gcem_byr_emp_name.text = ""; //담당자
	gcem_byr_tel_num.text  = ""; //연락처
	gcem_byr_email.text    = ""; //이메일 	
}

/******************************************************************************
Description : 선조회
******************************************************************************/
function ln_Before(){
	//지점코드
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();
	
	//귀속구분[매출구분]
	gcds_taxdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=1215"; 
	gcds_taxdiv.Reset();
	
	//부가세종류[매출]
	gcds_taxknd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0009"; 
	gcds_taxknd.Reset();
	
	//공급자 거래처 정보
	gcds_sup_vend.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s7?v_str1="+gcem_sup_com_regno.text+"&v_str2=&v_str3=";                           
	//prompt('',gcds_sup_vend.DataID);
	gcds_sup_vend.Reset();
}


/******************************************************************************
Description : 당초승인번호 찾기
******************************************************************************/
function ln_ori_issue_id_find(){
		
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	strURL = "./a040077_popup1.jsp";
	arrParam[0]="";
	strPos = "dialogWidth:900px;dialogHeight:600px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);	

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		
		if(arrParam[2].length==10){
			gcem_ori_byr_com_regno.Format="###-##-#####"; 
  		}else if (arrParam[2].length==13){
  			gcem_ori_byr_com_regno.Format="######-#######"; 		
  		}
		
		gcem_ori_issue_id.text = arrParam[0];
		gcem_ori_byr_com_regno.text =  arrParam[2];
		
		//기존 보냈던 사람의 데이터 가져옴.
		gcem_sup_tel_num.text=arrParam[3]; //연락처
		gcem_sup_emp_name.text=arrParam[4];//담당자 
		gcem_sup_email.text=arrParam[5]; //이메일
		gcem_ori_dti_wdate.text =arrParam[6]; //일자 
		
		gcem_ori_sup_amount.text=arrParam[7];   //공급가액 
        gcem_ori_tax_amount.text=arrParam[8];   //부가세액 
        gcem_ori_total_amount.text=arrParam[9]; //합계
        gcem_ori_dti_type_nm.text=arrParam[10]; //귀속구분		
	} else {
		gcem_ori_issue_id.text ="";
		gcem_ori_byr_com_regno.text =  "";
		gcem_sup_tel_num.text=""; //연락처
		gcem_sup_emp_name.text="";//담당자 
		gcem_sup_email.text=""; //이메일		
		gcem_ori_dti_wdate.text=""; //일자 
		gcem_ori_sup_amount.text="";   //공급가액 
        gcem_ori_tax_amount.text="";   //부가세액 
        gcem_ori_total_amount.text=""; //합계
        gcem_ori_dti_type_nm.text="";
	}
}


/******************************************************************************
Description : 사업자 등록번호로 공급자, 공급받는자 정보 찾기 
******************************************************************************/
function ln_sup_vend_info(){
	gcem_sup_com_name.text      = gcds_sup_vend.namevalue(gcds_sup_vend.rowposition,"VEND_NM");
	gcem_sup_rep_name.text      = gcds_sup_vend.namevalue(gcds_sup_vend.rowposition,"VD_DIRECT");
	gcem_sup_com_addr.text      = gcds_sup_vend.namevalue(gcds_sup_vend.rowposition,"ADDRESS1")+ gcds_sup_vend.namevalue(gcds_sup_vend.rowposition,"ADDRESS2");
	gcem_sup_com_type.text      = gcds_sup_vend.namevalue(gcds_sup_vend.rowposition,"BSNS_CND");
	gcem_sup_com_classify.text  = gcds_sup_vend.namevalue(gcds_sup_vend.rowposition,"BSNS_KND");	
}

/******************************************************************************
Description : 수정사유 찾기
******************************************************************************/
function ln_modify_reason_find(){
	
	//alert("수정사유 찾기");
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	strURL = "./a040077_popup2.jsp";
	arrParam[0]="";
	strPos = "dialogWidth:900px;dialogHeight:600px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);	

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_modify_reason.text = arrParam[0];
	} else {
		gcem_modify_reason.text="";
	}
	
	if(gcem_modify_reason.text=="01"){
		gcem_modify_reason_nm1.text="기재사항 착오 정정 등";
		gcem_modify_reason_nm2.text="당초세금계산서";
	}else if(gcem_modify_reason.text=="011"){
		gcem_modify_reason_nm1.text="기재사항 착오 정정 등";
		gcem_modify_reason_nm2.text="정정된 세금계산서";
	}else if(gcem_modify_reason.text=="06"){
		gcem_modify_reason_nm1.text="착오에 의한 이중발급 등";
	}else if(gcem_modify_reason.text=="02"){
		gcem_modify_reason_nm1.text="공급가액 변동";
	}else if(gcem_modify_reason.text=="04"){
		gcem_modify_reason_nm1.text="계약의 해제";
	}else if(gcem_modify_reason.text=="03"){
		gcem_modify_reason_nm1.text="환입";
	}else if(gcem_modify_reason.text=="05"){	
		gcem_modify_reason_nm1.text="내국신용장 사후개설";
		gcem_modify_reason_nm2.text="당초세금계산서";
	}else if(gcem_modify_reason.text=="051"){	
		gcem_modify_reason_nm1.text="내국신용장 사후개설";
		gcem_modify_reason_nm2.text="영세율 세금계산서";
	}else{
		gcem_modify_reason_nm1.text="";
		gcem_modify_reason_nm2.text="";
	}
	
	gcem_amend_code.text = gcem_modify_reason.text;
	gcem_amend_codenm.text = gcem_modify_reason_nm1.text;
	
	if (gcem_amend_code.text=="011"){
		gcem_amend_code.text="01";
	}else if (gcem_amend_code.text=="051"){
		gcem_amend_code.text="05";
	}
}


/******************************************************************************
Description : 사업장 Display    
******************************************************************************/
function ln_Display_Cocode(){
	
	if(gclx_cocode.bindcolval=="02"){//서울
		sp1.style.display = "";
		gcem_s_bizplace.text="0001"; //종사업장번호
		gcem_remark2.text="현대아산주식회사(지점) 서울 종로구 율곡로 194";
	}else if(gclx_cocode.bindcolval=="03"){//양양
		sp1.style.display = "";
		gcem_s_bizplace.text="0002"; //종사업장번호
		gcem_remark2.text="현대아산주식회사 강원도 양양군 손양면 동호리 545";
	}else if(gclx_cocode.bindcolval=="04"){//홍성
		sp1.style.display = "";
		gcem_s_bizplace.text="0003"; //종사업장번호
		gcem_remark2.text="현대아산주식회사 충청남도 홍성군 홍북면 충남대로 36(빌앤더스오피스텔)";
	}else{ //고성
		sp1.style.display = "none"; //숨김
		gcem_s_bizplace.text="";
		gcem_remark2.text="";
	}
	
	gcem_sup_bizplace_code.text = gcem_s_bizplace.text;
}


/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(e){
  
}

/******************************************************************************
Description : 매출 발행

데이터를 
ACCOUNT.ATTAXMST, ACCOUNT.ATTAXDTL
HDASAN_EDI.XXSB_DTI_MAIN, XXSB_DTI_ITEM, XXSB_DTI_STATUS에 INSERT 해야함.
******************************************************************************/
function ln_Save(){
	
	//상태값이 요청일경우는 저장불가...
	if(gclx_taxsts.bindcolval!="N"&&gclx_taxsts.bindcolval!="B"){
		alert("결재상태를 확인하십시요.");
		return false;
	}
	
	if(!ln_User_Chk()) return;
	
	ln_Data_Setting();
	if(!ln_Chk())return;	
	//alert("gcds_taxmst.IsUpdated:;"+gcds_taxmst.IsUpdated);
	if (gcds_taxmst.IsUpdated) {
		if (confirm("수정세금계산서를 저장 하시겠습니까?")){	
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040077_t1";
			gctr_data.KeyValue = "Account.a040077_t1(I:USER01=gcds_taxmst,I:USER02=gcds_taxdtl,I:USER=gcds_issueid,O:USER7=gcds_return)";	
			gctr_data.Parameters = "v_str1="+gcem_sup_com_regno.text+",v_str2="+gusrid+",v_str3="+gcem_ori_issue_id.text;
			          
			//prompt('',gcds_taxmst.text);
			//prompt('',gcds_taxdtl.text);
			//prompt('',gcds_issueid.text);
			gctr_data.post();
		}	
	}
}



/******************************************************************************
Description : DataSet에 반영

******************************************************************************/
function ln_Data_Setting(){
			
	var row = 0;
	
	gcds_issueid.clearAll();
	gcds_taxmst.clearAll();
	ln_Taxmst_SetDataHeader();
	gcds_issueid.addrow();
	gcds_taxmst.addrow();
	row = gcds_taxmst.rowposition;
	gcds_issueid.namevalue(gcds_issueid.rowposition,"ORI_ISSUE_ID") = gcem_ori_issue_id.text;
		
	var strdat = gcem_taxdat.text; 
	var strtaxkidiv ="";
	//alert("strdat.substring(4,6):;"+strdat.substring(4,6));
	
	if (strdat.substring(4,6) >='01' && strdat.substring(4,6) <='03') {
		strtaxkidiv="1";	//기수[1]
	}else if(strdat.substring(4,6) >='04' && strdat.substring(4,6) <='06') {
		strtaxkidiv="2";	//기수[2]
	}else if(strdat.substring(4,6) >='07' && strdat.substring(4,6) <='09') {
		strtaxkidiv="3";	//기수[3]
	}else if(strdat.substring(4,6) >='10' && strdat.substring(4,6) <='12') {
		strtaxkidiv="4";	//기수[4]
	}
		
	gcds_taxmst.namevalue(row,"TAXNBR")="" ;  // 저장시점에 생성함.
	gcds_taxmst.namevalue(row,"COCODE")=gclx_cocode.bindcolval;
	gcds_taxmst.namevalue(row,"DEPTCD")=gs_deptcd ;  //로그인 세션 정보 만약 없을 경우 ....체크 
	gcds_taxmst.namevalue(row,"EMPNO")=gs_userid ;   //로그인 세션 정보 만약 없을 경우 ....체크
	gcds_taxmst.namevalue(row,"TAXIODIV")="B" ;
	gcds_taxmst.namevalue(row,"TAXDIV")=gclx_taxdiv.bindcolval;
	gcds_taxmst.namevalue(row,"TAXKND")=gclx_taxknd.bindcolval;
	gcds_taxmst.namevalue(row,"VEND_CD")=gcem_vendcd.text;
	gcds_taxmst.namevalue(row,"TAXDAT")=gcem_taxdat.text ;
	gcds_taxmst.namevalue(row,"TAXSUM")=gcem_sup_amount.text ;
	gcds_taxmst.namevalue(row,"TAXVATAMT")=gcem_tax_amount.text ;
	gcds_taxmst.namevalue(row,"TAXTOT")=gcem_total_amount.text ;
	gcds_taxmst.namevalue(row,"REMARK")=gcem_erp_remark.text ;
	gcds_taxmst.namevalue(row,"TAXCDNBR")="" ;//패스
	gcds_taxmst.namevalue(row,"ATCODE")="1110110" ; //현금으로  Default 나중에 전표칠때 바꿔삼
	gcds_taxmst.namevalue(row,"TAXPRTYN")="Y";
	gcds_taxmst.namevalue(row,"TAXCNT")=0 ;
	gcds_taxmst.namevalue(row,"LASTPRT")="" ;
	gcds_taxmst.namevalue(row,"TAXTYPE")="N" ;
	gcds_taxmst.namevalue(row,"FSDAT")="" ;
	gcds_taxmst.namevalue(row,"FSNBR")="" ;
	gcds_taxmst.namevalue(row,"TAXKIDIV")=strtaxkidiv ;  //계산해서 넣기 ( 계산서 일자로 )
	gcds_taxmst.namevalue(row,"FDCODE")=gclx_fdcode.bindcolval;
	gcds_taxmst.namevalue(row,"WORKTYPE")="A" ;
	gcds_taxmst.namevalue(row,"REPORT")="" ;
	gcds_taxmst.namevalue(row,"WRDT")=gs_date ;
	gcds_taxmst.namevalue(row,"WRID")=gs_userid ;
	gcds_taxmst.namevalue(row,"UPDT")="" ;
	gcds_taxmst.namevalue(row,"UPID")="" ;
	gcds_taxmst.namevalue(row,"SSDAT")="" ;
	gcds_taxmst.namevalue(row,"SSNBR")="" ;
	gcds_taxmst.namevalue(row,"SEQ")=gcem_seq.text ;                   //거래처 담당순번
	gcds_taxmst.namevalue(row,"CONVERSATION_ID")="" ;
	gcds_taxmst.namevalue(row,"SUPBUY_TYPE")="" ;
	gcds_taxmst.namevalue(row,"DIRECTION")="" ;
	gcds_taxmst.namevalue(row,"GUBUN")="1" ;  //전자 직접입력받아야함.
	gcds_taxmst.namevalue(row,"AMEND_CODE")=gcem_amend_code.text ;
	gcds_taxmst.namevalue(row,"AMEND_REMARK")=gcem_remark.text ;  //비고 1 임..
	gcds_taxmst.namevalue(row,"EXTCHK")="0" ;
	gcds_taxmst.namevalue(row,"REMARK2")=gcem_remark2.text ;
	gcds_taxmst.namevalue(row,"REMARK3")=gcem_remark3.text ;
	gcds_taxmst.namevalue(row,"S_BIZPLACE")=gcem_s_bizplace.text ;
	gcds_taxmst.namevalue(row,"B_BIZPLACE")="" ;
	gcds_taxmst.namevalue(row,"COSTCD")=txt_costcd.value;
	
	//추가내용.....
	gcds_taxmst.namevalue(row,"EBILLGB")="1";                         //스마트빌
	gcds_taxmst.namevalue(row,"DUEDATE")=gcem_duedate.text;           //입금예정일
	gcds_taxmst.namevalue(row,"TAXSTS")=gclx_taxsts.bindcolval;       //결재상태 - 대기
	gcds_taxmst.namevalue(row,"ORI_ISSUE_ID")=gcem_ori_issue_id.text; //당초승인번호 
	
	//추가내용2...
	//VEND_NM
	//VEND_ID
	//VD_DIRECT 
	//TAXKNDNM
	
	gcds_taxmst.namevalue(row,"VEND_NM")=txt_vendnm.value;            //거래처명
	gcds_taxmst.namevalue(row,"VEND_ID")=gcem_vendid.text;            //등록번호
	gcds_taxmst.namevalue(row,"VD_DIRECT")=gcem_byr_rep_name.text;    //공급받는자 대표
	gcds_taxmst.namevalue(row,"TAXKNDNM")=gclx_taxknd.text;           //과세
	
	//세부내역
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXSEQ")="001";
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"WRDT")=gs_date;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"WRID")=gs_userid;
		
}

/******************************************************************************
Description : 계산서 사용자 등록체크 
******************************************************************************/
function ln_User_Chk(){
	//계산서 사용자 등록 체크 && Email 등록 체크
	gcds_chk.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_sm_user_s1?v_str1="+gs_userid;
	gcds_chk.Reset();
	
	if(gcds_chk.countrow<=0){
		alert("수정전자세금계산서 발행전 반드시 [계산서 사용자관리]에 등록하셔야 합니다. ");
		return false;
	}
	
	if(gcds_chk.namevalue(gcds_chk.rowposition,"SMART_ID")==""){
		alert("smartbill.co.kr 에 등록한 동일한 id를 계산서 사용자관리에 등록하셔야 합니다. ");
		return false;
	}
	
	if(gcds_chk.namevalue(gcds_chk.rowposition,"SMART_PASSWORD")==""){
		alert("smartbill.co.kr 에 등록한 동일한 password를 계산서 사용자관리에 등록하셔야 합니다. ");
		return false;
	}
	
	if(gcds_chk.namevalue(gcds_chk.rowposition,"EMAIL")==""){
		alert("smartbill.co.kr에 등록한 eMail를 등록하셔야 합니다. ");
		return false;
	}
	return true;
}

/******************************************************************************
Description : 필수항목 체크 
******************************************************************************/
function ln_Chk(){

	 //필수항목 체크 
	 if (gcem_ori_issue_id.text=="") { alert("당초승인번호가 없습니다. 확인하십시요.");  return false; }
	 if (gcem_modify_reason.text==""){ alert("수정사유가  없습니다. 확인하십시요.");	     return false; }
	 if (gclx_fdcode.bindcolval=="") { alert("지점이 존재하지 않습니다. 확인하십시요.");  return false; } 
	 if (gclx_cocode.bindcolval=="") { alert("사업장이 존재하지 않습니다. 확인하십시요."); return false;	 }	 
	 if (gclx_taxdiv.bindcolval=="") { alert("귀속구분이 존재하지 않습니다. 확인하십시요."); return false;}
	 if (gclx_taxknd.bindcolval=="") { alert("과세구분이 존재하지 않습니다. 확인하십시요."); return false;}
	 if (gcem_vendcd.text=="")  { alert("거래처코드가 존재하지 않습니다. 확인하십시요."); return false; }
	 if (txt_vendnm.value==""){ alert("거래처명이 존재하지 않습니다. 확인하십시요."); return false; }
	 if (gcem_vendid.text=="")  { alert("사업자등록번호가  존재하지 않습니다. 확인하십시요."); return false; }  
	 if (gcem_empnm.text=="") { alert("거래처 담당 정보가  존재하지 않습니다. 확인하십시요."); return false; }  
	 if (gcem_email.text=="") { alert("거래처 Email이  존재하지 않습니다. 확인하십시요."); return false;	 }  
	 if (gcem_erp_remark.text==""){ alert("적요가  존재하지 않습니다. 확인하십시요."); return false; }  
	 if (gcem_taxdat.text==""){ alert("계산서 일자가  존재하지 않습니다. 확인하십시요."); return false;}   
	 if (txt_costcd.value==""){ alert("원가코드가 존재하지 않습니다. 확인하십시요."); return false;}   
	 
	 //공급자 정보 
	 if (gcem_sup_com_regno.text=="")     { alert("공급자 등록번호가  존재하지 않습니다. 확인하십시요."); return false; }
	 if (gcem_sup_com_name.text=="")      { alert("공급자 상호가  존재하지 않습니다. 확인하십시요."); return false; }
	 if (gcem_sup_rep_name.text=="")      { alert("공급자 성명이  존재하지 않습니다. 확인하십시요."); return false; }
	 if (gcem_sup_com_addr.text=="")      { alert("공급자 주소가  존재하지 않습니다. 확인하십시요."); return false; }
	 if (gcem_sup_com_type.text=="")      { alert("공급자 업태가  존재하지 않습니다. 확인하십시요."); return false; }
	 if (gcem_sup_com_classify.text=="")  { alert("공급자 업종이  존재하지 않습니다. 확인하십시요."); return false; }
	 if (gcem_sup_emp_name.text=="")      { alert("공급자 담당자가  존재하지 않습니다. 확인하십시요."); return false; }
	 //if (gcem_sup_tel_num.text=="")       { alert("공급자 연락처가  존재하지 않습니다. 확인하십시요."); return false; }
	 if (gcem_sup_email.text=="")         { alert("공급자 이메일이  존재하지 않습니다. 확인하십시요."); return false; }
	 
	 //공급받는자 정보 
	 if (gcem_byr_com_regno.text=="")     { alert("공급받는자 등록번호가  존재하지 않습니다. 확인하십시요."); return false; }
	 if (gcem_byr_com_name.text=="")      { alert("공급받는자 상호가  존재하지 않습니다. 확인하십시요."); return false; }
	 if (gcem_byr_rep_name.text=="")      { alert("공급받는자 성명이  존재하지 않습니다. 확인하십시요."); return false; }
	 if (gcem_byr_com_addr.text=="")      { alert("공급받는자 주소가  존재하지 않습니다. 확인하십시요."); return false; }
	 if (gcem_byr_com_type.text=="")      { alert("공급받는자 업태가  존재하지 않습니다. 확인하십시요."); return false; }
	 if (gcem_byr_com_classify.text=="")  { alert("공급받는자 업종이  존재하지 않습니다. 확인하십시요."); return false; }
	 if (gcem_byr_emp_name.text=="")      { alert("공급받는자 담당자가  존재하지 않습니다. 확인하십시요."); return false; }
	 //if (gcem_sup_tel_num.text=="")       { alert("공급자 연락처가  존재하지 않습니다. 확인하십시요."); return false; }
	 if (gcem_byr_email.text=="")         { alert("공급자 이메일이  존재하지 않습니다. 확인하십시요."); return false; }
	 
	 //비고 
	 //공급가액, 부가세액, 합계, 수정사유 
	 if (gcem_sup_amount.text==""||gcem_sup_amount.text=="0")     { alert("공급가액이 존재하지 않습니다. 확인하십시요."); return false; }
	 if (gcem_total_amount.text==""||gcem_total_amount.text=="0") { alert("합계액이  존재하지 않습니다. 확인하십시요."); return false; }

	 //수정사유
	 if (gcem_amend_code.text=="") { alert("수정사유가 존재하지 않습니다. 확인하십시요."); return false; }
	 	 
	 //세부내역
	 
	 if(gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"MMDD")=="")     {alert("세부내역 월일이 존재하지 않습니다. 확인하십시요."); return false;}
	 if(gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXPDTNAM")==""){alert("세부내역 품목이 존재하지 않습니다. 확인하십시요."); return false;}
	 if(gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXSUM")==0)    {alert("세부내역 공급가액이 존재하지 않습니다. 확인하십시요."); return false;}
	 
	 
	 //필수항목체크 
	  
	 //Data cross check  
	 
	 //수정사유에 따른 날짜체크
	 if(gcem_modify_reason.text=="01") { //기재사항착오정정 당초세금계산서 
		 
	 	if(gcem_ori_dti_wdate.text !=gcem_taxdat.text){
	 		alert("계산서일자가 당초작성일이 아닙니다. 확인하십시요.");		
	 		return false;
	 	} 
	 }else if (gcem_modify_reason.text=="06"){ //착오에 의한 이중발급 
		if(gcem_ori_dti_wdate.text !=gcem_taxdat.text){
			alert("계산서일자가 당초작성일이 아닙니다. 확인하십시요.");
			return false;
		}  
	 }else if (gcem_modify_reason.text=="05"||gcem_modify_reason.text=="051"  ){ //내국신용장 사후개설 		 
		if(gcem_ori_dti_wdate.text !=gcem_taxdat.text){
			alert("계산서일자가 당초작성일이 아닙니다. 확인하십시요.");
			return false;
		}  
	 }
	 
	 //계산서일자와 품목일자가 틀린경우 체크
	 if(gcem_taxdat.text.substring(4,8)!=gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"MMDD")){
		 alert("일자가 맞지 않습니다. 확인 바랍니다.");
		 return false;
	 }
	 
	
	 //과세일경우 
	 if(gclx_taxknd.bindcolval=="1"){ 
		//0이면 안됨.
	 	if(gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXVATAMT")==0){
	 		alert("과세구분과 부가세액이 맞지 않습니다.확인 바랍니다.");
	 		return false;
	 	}	
	 }else{ //영세 면세일 경우 부가세액 체크 
		//0이 아니면 안됨.
	 	if(gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXVATAMT")!=0){
	 		alert("과세구분과 부가세액이 맞지 않습니다.확인 바랍니다.");
	 		return false;
	 	}	
	 }
	 
	 //입금예정일
	 if (fn_trim(gcem_duedate.text)=="")   { alert("입금예정일이  존재하지 않습니다. 확인하십시요."); return false; }
	 if (fn_trim(gcem_duedate.text).length!=8) { alert("입금예정일이 정확하지 않습니다. 확인하십시요."); return false; }
	 
	 //입금예정일 > 계산서 일자 
	 if(gcem_duedate.text<gcem_taxdat.text){
		 alert("입금예정일을 확인하십시요");
		 return false;
	 }
	 
	 //계산서번호
	 if (fn_trim(gcem_taxnbr.text)!="")   { alert("계산서 번호가  존재합니다. 저장 불가합니다."); return false; }
	 
	 return true;
}


/******************************************************************************************
	Description : 삭제
*****************************************************************************************/
function ln_Delete(){

}

/******************************************************************************
Description : Report Head 설정 - 세금계산서 상세내역
******************************************************************************/
function ln_Taxmst_SetDataHeader(){

	var s_tmp1 = "TAXNBR:STRING,COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,TAXIODIV:STRING,TAXDIV:STRING,TAXKND:STRING,"
			   + "VEND_CD:STRING,TAXDAT:STRING,TAXSUM:DECIMAL,TAXVATAMT:DECIMAL,TAXTOT:DECIMAL,REMARK:STRING,TAXCDNBR:STRING,"
			   + "ATCODE:STRING,TAXPRTYN:STRING,TAXCNT:DECIMAL,LASTPRT:STRING,TAXTYPE:STRING,FSDAT:STRING,FSNBR:STRING,"
			   + "TAXKIDIV:STRING,FDCODE:STRING,WORKTYPE:STRING,REPORT:STRING,WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
			   + "SSDAT:STRING,SSNBR:STRING,SEQ:DECIMAL,CONVERSATION_ID:STRING,SUPBUY_TYPE:STRING,DIRECTION:STRING,"
			   + "GUBUN:STRING,AMEND_CODE:STRING,AMEND_REMARK:STRING,EXTCHK:STRING,REMARK2:STRING,REMARK3:STRING,S_BIZPLACE:STRING,B_BIZPLACE:STRING,COSTCD:STRING,"
			   + "EBILLGB:STRING,DUEDATE:STRING,TAXSTS:STRING,REAL_FILE:STRING,SYS_FILE:STRING,REAL_FILE2:STRING,SYS_FILE2:STRING,ORI_ISSUE_ID:STRING,"
			   + "VEND_NM:STRING,VEND_ID:STRING,VD_DIRECT:STRING,TAXKNDNM:STRING";
	gcds_taxmst.SetDataHeader(s_tmp1);
	
	var s_tmp2 = "ORI_ISSUE_ID:STRING";
	gcds_issueid.SetDataHeader(s_tmp2);
	
}


/******************************************************************************
	Description : Report Head 설정 - 세금계산서 상세내역
******************************************************************************/
function ln_Taxdtl_SetDataHeader(){

	var s_tmp1 = "TAXNBR:STRING,TAXSEQ:STRING,TAXPDTNAM:STRING,TAXSTD:STRING,TAXQTY:DECIMAL,"
			   + "TAXPRIC:DECIMAL,TAXSUM:DECIMAL,TAXVATAMT:DECIMAL,BIGO:STRING,WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,MMDD:STRING";
	gcds_taxdtl.SetDataHeader(s_tmp1);
}

/******************************************************************************
Description : 거래처 찾기
******************************************************************************/
function ln_Vend_Popup(){

	var arrVAT	= new Array(); 
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrVAT[0]="VAT";
	strURL = "./gczm_vender_popup33.jsp";
	strPos = "dialogWidth:700px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrVAT,strPos);
		
	/*
	 gcds_code01.namevalue(row,"SEQ")  + ";" 
	1	+ gcds_code01.namevalue(row,"VEND_CD")  + ";" 
	2  	+ gcds_code01.namevalue(row,"VEND_NM")  + ";" 
	3	+ gcds_code01.namevalue(row,"EMPNM") + ";"
	4	+ gcds_code01.namevalue(row,"DEPTNM") + ";"
	5	+ gcds_code01.namevalue(row,"EMAIL")  + ";"
	6	+ gcds_code01.namevalue(row,"HPNO")  + ";"
	7	+ gcds_code01.namevalue(row,"TELNO")  + ";"
	8	+ gcds_code01.namevalue(row,"USEGB")  + ";"
	9	+ gcds_code01.namevalue(row,"VEND_ID")+ ";"
	10	+ gcds_code01.namevalue(row,"BSNS_CND")  + ";"
	11	+ gcds_code01.namevalue(row,"BSNS_KND")  + ";"
	12	+ gcds_code01.namevalue(row,"ADDRESS1")  + ";"
	13	+ gcds_code01.namevalue(row,"ADDRESS2")  + ";"
	14	+ gcds_code01.namevalue(row,"VD_DIRECT") + ";"
	15	+ gcds_code01.namevalue(row,"ORI_VEND_I");
	*/
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		
		if(arrParam[16]=="10"){
  			gcem_vendid.Format="###-##-#####"; 
  			gcem_byr_com_regno.Format="###-##-#####"; 
  		}else if (arrParam[16]=="13"){
  			gcem_vendid.Format="######-#######"; 		
  			gcem_byr_com_regno.Format="######-#######"; 
  		}
		
		gcem_seq.text      = arrParam[0]; //순번  
		gcem_vendcd.text   = arrParam[1]; //거래처 코드  
		txt_vendnm.value = arrParam[2]; //거래처명
		//gcem_vendid.text   = arrParam[9]; //거래처 사업자 등록번호 
		gcem_vendid.text   = arrParam[15]; //거래처 사업자 등록번호 
		gcem_empnm.text    = arrParam[3]; //담당자성명      
		//gcem_deptnm2.text   = arrParam[4]; //부서명          
		//gcem_hpno2.text     = arrParam[6]; //핸드폰          
		//gcem_telno2.text    = arrParam[7]; //전화        
		gcem_email.text       = arrParam[5]; //Email    
		gcem_byr_com_regno.text= arrParam[15]; //등록번호
		
		gcem_byr_com_name.text = arrParam[2]; //상호
		gcem_byr_rep_name.text = arrParam[14]; //성명
    	gcem_byr_com_addr.text = arrParam[12]+arrParam[13]; //주소
		gcem_byr_bizplace_code.text = ""; //종사업장
    	gcem_byr_com_type.text = arrParam[10]; //업태
    	gcem_byr_com_classify.text = arrParam[11]; //업종
  		gcem_byr_emp_name.text = arrParam[3]; //담당자
  		gcem_byr_tel_num.text  = arrParam[7]; //연락처
  		gcem_byr_email.text    = arrParam[5]; //이메일 
  		
  		ln_Find_Ori_Auto_Settiong();
	} else {
		gcem_vendcd.text   = ""; //거래처 코드  
		txt_vendnm.value = ""; //거래처명
		gcem_vendid.text   =""; //거래처 사업자 등록번호 
		gcem_empnm.text    = ""; //담당자성명           
		gcem_email.text    =""; //Email    
		gcem_byr_com_regno.text= ""; //등록번호
		
		gcem_byr_com_name.text = ""; //상호
		gcem_byr_rep_name.text = ""; //성명
    	gcem_byr_com_addr.text = "";//주소
		gcem_byr_bizplace_code.text = ""; //종사업장
    	gcem_byr_com_type.text = ""; //업태
    	gcem_byr_com_classify.text = ""; //업종
  		gcem_byr_emp_name.text = ""; //담당자
  		gcem_byr_tel_num.text  = ""; //연락처
  		gcem_byr_email.text    = ""; //이메일 
	}
}

/******************************************************************************
Description : 당초 정보 자동 설정
                            기재사항착오정정, 착오에 의한 이중발급만 자동설정 함. 
******************************************************************************/
function ln_Find_Ori_Auto_Settiong (){
	
	if(gcem_modify_reason.text=="01"){ //기재사항 착오, 당초세금계산서  당초금액의 부의 금액 적용
		gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXSUM")= parseFloat(gcem_ori_sup_amount.text)*-1;
		gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXVATAMT")=parseFloat(gcem_ori_tax_amount.text)*-1;
		ln_Auto_Sum();
	}else if(gcem_modify_reason.text=="06"){ //착오에 의한 이중발급
		gcem_taxdat.text = gcem_ori_dti_wdate.text;  // 당초작성일자
		gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"MMDD") = gcem_ori_dti_wdate.text.substring(4,8);  // 당초작성일자
		gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXSUM")= parseFloat(gcem_ori_sup_amount.text)*-1;
		gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXVATAMT")=parseFloat(gcem_ori_tax_amount.text)*-1;
		ln_Auto_Sum();
	}
}

/******************************************************************************
Description : 달력 년월 가져오기
******************************************************************************/
function ln_GetCallCalendar(){
	__GetCallCalendar('gcem_taxdat', 'Text');
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"MMDD") = gcem_taxdat.text.substring(4,8);
	//alert("gcem_taxdat::"+gcem_taxdat.text);
}

/******************************************************************************
Description : 금액자동계산
******************************************************************************/
function ln_Auto_Sum(){
	var row = gcds_taxdtl.rowposition;	//세부내역 합계[매출]
  	gcem_sup_amount.text = parseFloat(gcds_taxdtl.namevalue(row,"TAXSUM"));
  	gcem_tax_amount.text = parseFloat(gcds_taxdtl.namevalue(row,"TAXVATAMT"));
  	gcem_total_amount.text = parseFloat(gcem_sup_amount.text) + parseFloat(gcem_tax_amount.text);
}


/******************************************************************************
Description : 스마트 모듈 호출 
******************************************************************************/
function ln_SM_Call(strBatchId, strId, strPass){
	
	var v_left = (screen.width-300)/2;
	var v_top  = (screen.height-300)/2;

	//세금계산서만
	url=gs_url+"/callSB_V3/XXSB_DTI_ARISSUE.asp?BATCH_ID="+strBatchId+"&ID="+strId+"&PASS="+strPass;		
	window.open(url,"", "status=1, width=300, height=280, left="+v_left+", top="+v_top );
    
	ln_Initial();
}


/******************************************************************************
Description : 수정세금계산서 발급방법 링크 
******************************************************************************/
function ln_Menual(){

	var v_left = (screen.width-800)/2;
	var v_top  = (screen.height-800)/2;
    
	url="http://esero.go.kr.krweb.nefficient.co.kr/esero/data/is/form/수정전자세금계산서%20발급방법.pdf";

	window.open(url,"", "status=1, resizable=yes, width=1000, height=780, left="+v_left+", top="+v_top );
}

/******************************************************************************
Description : 원가팝업
parameter   : 
******************************************************************************/
function ln_Costcd_Popup(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0]="0030";//원가코드
	arrParam[1]="";
	
	if(txt_costnm.value==""){
		 arrParam[2]="";
	}else{
	   arrParam[2]=txt_costnm.value;
	}
	
	if(txt_costcd.value==""){
	 arrParam[3]="";
	}else{
	 arrParam[3]=txt_costcd.value;
	}
	
	strURL =  "./commdtil_cost_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);
	
	if (result != null) {
		arrResult = result.split(";");
		txt_costcd.value =arrResult[0];
		txt_costnm.value = arrResult[1];
	}else{
	    txt_costcd.value="";
		txt_costnm.value="";
	}	
}	


<%
/***********************************************************************************************
Description : 결재요청
parameter   : 
**********************************************************************************************/
%>
function ln_Request(){
	//계산서 번호 필수항목
	if(!ln_Chk_Status()) return false;
	   
	if (confirm(" 해당 매출정보를 승인 요청 하시겠습니까?")){	
		gctr_data5.KeyValue = "Account.a040120_t1(I:USER=gcds_taxmst)";
		gctr_data5.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040120_t1";
		gctr_data5.Parameters = "v_str1="+gs_userid;
		
		//prompt('',gcds_taxmst.text);
		gctr_data5.post();
		//ln_Query();
	}else{
		gcds_taxmst.UndoAll();
	}	
}

<%
/******************************************************************************
Description : 상태값 체크 
******************************************************************************/
%>
function ln_Chk_Status(){
	//계산서 상태 체크 ( 대기 또는 null, 반송 상태만 가능, 요청 또는 승인은 불가  )
	if(fn_trim(gcem_taxnbr.text)==""){
		alert("계산서 번호가 존재하지 않습니다. 확인 바랍니다.");
		return false;
	}
	
	if(gclx_taxsts.bindcolval=="R"||gclx_taxsts.bindcolval=="Y"){
		alert("해당 상태값은 결재요청이 불가합니다.");
		return false;
	}
	
	f = document.fileForm;
	
	// alert(".options[0].text::::"+document.fileForm.fileList.options[0].text+"::");
	// alert(".options[0].value::::"+document.fileForm.fileList.options[0].value+"::");
	/*  
	if(f.fileList.options.selectedindex==-1){
		 alert("없어여");
		 return false;
	}else{
		if(f.fileList.options.length==1){
			alert("첨부파일이 1개입니다. 확인 바랍니다.");
			return false;
		}
	} 
	*/
	    
	if(f.fileList.options[0].text==""||f.fileList.options[0].text==undefined){
		alert("파일이 첨부 되지 않았습니다.");
		return false;
	}
	
	if(f.fileList.options[0].value==""||f.fileList.options[0].value==undefined){
		alert("파일이 첨부 되지 않았습니다.");
		return false;
	}
	
	//alert("f.fileList.options[1].value::"+f.fileList.options[1].value);
	if(f.fileList.options[1].text==""||f.fileList.options[1].text==undefined){
		alert("파일이 첨부 되지 않았습니다2.");
		return false;
	}
	
	if(f.fileList.options[1].value==""||f.fileList.options[1].value==undefined){
		alert("파일이 첨부 되지 않았습니다2.");
		return false;
	}
	
	if(gcds_taxmst.namevalue(1,"TAXSTS")!="N"&&gcds_taxmst.namevalue(1,"TAXSTS")!="B"){
		alert(gcds_taxmst.namevalue(1,"VEND_NM")+"은 결재요청 건이  아닙니다.");
		return false;
	}else{
		gcds_taxmst.namevalue(1,"TAXSTS")="R"; 
		gclx_taxsts.bindcolval="R"; 
	}
	
	return true;
}

<%
//파일 첨부
%>
function fnFileUpload(){
	
	//거래처 코드가 존재해야만 업로드 가능.
  //alert("VEND_CD::"+gcds_data.namevalue(gcds_data.rowpostion,"VEND_CD"));
	
	/*
	if(gcds_taxmst.namevalue(gcds_taxmst.rowpostion,"TAXNBR")==""||gcds_taxmst.namevalue(gcds_data.rowpostion,"TAXNBR")==undefined){
		alert("세금계산서 번호가 존재해야  업로드 가능합니다.");
	}
	*/
	
	//결재요청일 경우 파일 첨부 불가.
	if(gclx_taxsts.bindcolval=="R"||gclx_taxsts.bindcolval=="Y"){
		alert("해당 결재상태값은 파일첨부 불가합니다.");
		return false;
	}
	
	//기존에 파일이 첨부 되었을 경우.....삭제 후 다시 첨부 해야함.......
	//동일한 파일명이 존재합니다.
	//상태가 대기 및 반송만 가능합다.
	//if(!ln_Chk_Status("파일첨부")) return false;
	f = document.fileForm;
	
	if(f.filename1.value!=""){
		file_position ="1";
	}else if(f.filename2.value!=""){
		file_position ="2";
	}
	
	gs_position = file_position; 
	

	if(f.filename2.value==""){
		alert("발행승인요청서 첨부할 파일을 선택하십시요2.");
		return false;
	}
	
	if(f.filename1.value==""){
		alert("사업자등록번호 첨부할 파일을 선택하십시요1.");	
		return false;
	}
		
	var realFileName = f.filename1.value;
	var idx = realFileName.lastIndexOf("\\");
	realFileName = realFileName.substring(idx+1);
	
	
	if(f.filename2.value.substring(f.filename2.value.lastIndexOf("\\")+1).toUpperCase().indexOf(".PDF")<0){
		alert("발행승인요청서는 PDF파일만 첨부 가능합니다. ");
		return false;
	}
	
	if(f.filename1.value.substring(f.filename1.value.lastIndexOf("\\")+1).toUpperCase().indexOf(".PDF")<0){
		alert("사업자등록번호는 PDF파일만 첨부 가능합니다. ");
		return false;
	}
	
	//파일 확장자 체크 
	/*
	if(realFileName.indexOf(".mp3") > 0 ||realFileName.indexOf(".wma") > 0 || realFileName.indexOf(".asf") > 0){
		alert("저작권 문제의 소지가 있는 mp3, wma, asf 형식의 음악파일 첨부는 되지 않습니다.");
		return;
	}
	*/
	
	
  /*
	if(realFileName.toUpperCase().indexOf(".PDF") <0 ){
		alert(" PDF 파일만 첨부 가능합니다. ");
		return false;
	}
	*/
	
	
	f.target="tempUpload";	               //업로드 폼의 타겟은 iFrame !
	f.realFileName.value=realFileName;   
	f.mode.value="insert";
	
	f.action = "./a040120_fileUpload.jsp";  //실질적인 파일 업로드
	f.submit();
	
}

<%
//파일 추가 리스트  --> a010050_fileUpload에서 호출 
//실제업로드 된 파일명을 리턴해 줌. 
%>
function addFileList(realName, virtualName, intTot, strfilename){
	
	f = document.fileForm;
	intTot = intTot - 1;

	if(realName!=""){
		f.fileList.options[intTot] = new Option(realName,virtualName);
	}
	
	//파일명 업데이터 처리...
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REAL_FILE")=realName;
	//gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SYS_FILE")=virtualName;
	
	if(strfilename=="filename2"){ //발행승인요청서
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REAL_FILE2")=realName;
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SYS_FILE2")=virtualName;
	}else if(strfilename=="filename1"){ //등록번호 
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REAL_FILE")=realName;
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SYS_FILE")=virtualName;
	}
	
	if (gs_position==strfilename.substring(8,9)){
		gctr_data5.KeyValue = "Account.a040120_t2(I:USER=gcds_taxmst)";
		gctr_data5.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040120_t2";
		gctr_data5.Parameters = "v_str1="+gs_userid;
		//prompt('fileupload::',gcds_taxmst.text);
		gctr_data5.post();
	}
	
	//f.file1.value ="첨부파일은최대10M까지가능합니다." ;  //f.file1.title;
}

<%
//조회 및 그리드 클릭시시 첨부파일이 존재하면 첨부list에 넣어둠.
%>
function fnFileList(row){
	var strReal_file="";
	var strSys_file ="";
	var ip =0;
	
	for(var i=2;i>=1; i--){
		if(i==1){        //등록번호
			strReal_file = gcds_taxmst.namevalue(row,"REAL_FILE");
			strSys_file  = gcds_taxmst.namevalue(row,"SYS_FILE");
			//alert("strReal_file::"+strReal_file+"::strSys_file::"+strSys_file);
			if(strReal_file!=""){
				document.fileForm.fileList.options[ip] = new Option(strReal_file,strSys_file);
				ip=ip+1;
			}
			
		}else if(i==2){ //
			strReal_file = gcds_taxmst.namevalue(row,"REAL_FILE2");
			strSys_file  = gcds_taxmst.namevalue(row,"SYS_FILE2");
			
			//alert("strReal_file::"+strReal_file+"::strSys_file::"+strSys_file);
			if(strReal_file!=""){
				document.fileForm.fileList.options[ip] = new Option(strReal_file,strSys_file);
				ip=ip+1;
			}
		}
	}
}

<%
//파일삭제
//파일목록에서 삭제 
%>
function fnFileDelete(){
	f = document.fileForm;
		
	//결재요청일 경우 파일 첨부 불가.
	if(gclx_taxsts.bindcolval=="R"||gclx_taxsts.bindcolval=="Y"){
		alert("해당 결재상태값은 파일삭제 불가합니다.");
		return false;
	}
	
	if(f.fileList.selectedIndex==null || f.fileList.selectedIndex < 0){
		alert('삭제할 파일을 선택해 주십시요');
		f.fileList.focus();
		return;
	}	

	if(confirm('정말로 삭제 하시겠습니까?')){
		var i = f.fileList.options.selectedIndex;
		var select_val  = f.fileList.options[i].value;
		var select_text = f.fileList.options[i].text;
		
		//파일찾기해서 삭제되면 없애야 함...
		//var realFileName = f.file1.value;
	    //var fileArray = oldFileNames.split(":");

		//alert(select_val);
		//alert(oldFileNames);

		//******** START 기존에 있던 파일인지 구분 ***********/
		var isNew = "i_del"; // 이게 금방 올린 파일인 경우... insert_file
		//******** END  기존에 있던 파일인지 구분 ***********/ 
		
		document.file_del.target="tempUpload";
		//document.file_del.realFileName.value=realFileName;
		document.file_del.realFileName.value=select_text;
		document.file_del.virtualFileName.value = select_val;
		//document.file_del.saveDir.value = "memGalleryUpload";
		document.file_del.mode.value=isNew;
		document.file_del.action = "./a040120_deleteFile.jsp";	//여기로 섬밋
		document.file_del.submit();
	}
}

<%
//파일업로드 4
//파일을 서버에서 삭제 후 리스트에서 삭제
%>
function delResult(realName, virtualName){
	
	//alert("delResult:realName:"+realName+"virtualName"+virtualName);
	
	f = document.fileForm;
	idx = f.fileList.selectedIndex;
	cnt = f.fileList.options.length;
	//f.fileList.options[0] = new Option(f.fileList.options[0].text,f.fileList.options[0].value);
	
	for(i=idx;i< f.fileList.options.length-1;i++){
		f.fileList.options[i] = new Option(f.fileList.options[i+1].text,f.fileList.options[i+1].value);
	}
	
	f.fileList.options[cnt - 1] = null;
	
	//f.file1.value = "첨부파일은최대5M까지가능합니다.";
	//alert("gcds_data.rowposition::"+gcds_data.rowposition+"::del::realName"+realName+":virtualName:"+virtualName);
	/*
	if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SYS_FILE")==virtualName){
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REAL_FILE")="";
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SYS_FILE")="";
	}
	*/
	
	for(var j=2;j>=1; j--){
		if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SYS_FILE2")==virtualName){
			gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REAL_FILE2")="";
			gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SYS_FILE2")="";
		}else if(gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SYS_FILE")==virtualName){
			gcds_taxmst.namevalue(gcds_taxmst.rowposition,"REAL_FILE")="";
			gcds_taxmst.namevalue(gcds_taxmst.rowposition,"SYS_FILE")="";
		}
	}
	
	//업데이트 후에 DB에도 업데이트 해야함.
	gctr_data5.KeyValue = "Account.a040120_t3(I:USER=gcds_taxmst)";
	gctr_data5.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040120_t3";
	gctr_data5.Parameters = "v_str1="+gs_userid;
	//prompt('',gcds_taxmst.text);
	gctr_data5.post();
	
	//ln_Query();
}

<%
//매출 세금계산서 발생 승인 요청서
%>
function ln_Print(){
  
	//계산서 번호 체크 
	if(gcem_taxnbr.text==""){
		alert("계산서번호가 존재하지 않습니다.");
		//return false;
	}
	
	fnReportSetDataHeader();
	gcds_rptmst.addrow();
	gcds_rptmst.namevalue(gcds_rptmst.rowposition,"APP_TEAMNM")= gdeptnm;
	gcrp_print.preview();
}

function fnReportSetDataHeader() {
	 var s_temp = "APP_TEAMNM:STRING";
	 gcds_rptmst.SetDataHeader(s_temp);
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_taxdiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_taxknd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_taxmst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_taxdtl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_issueid classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_return classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_sup_vend classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_rptmst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

<object  id=gctr_data5 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gclx_fdcode.bindcolval=gs_fdcode;
</script>
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_cocode event=OnSelChange()>
	ln_Display_Cocode();
</script>

<script language=JavaScript for=gcds_taxdtl event=onColumnChanged(row,colid)>
	if (colid == "TAXVATAMT" || colid == "TAXSUM") {
		gcds_taxdtl.Namevalue(row,"TAXTOT") = parseFloat(gcds_taxdtl.NameValue(row,"TAXVATAMT")) + parseFloat(gcds_taxdtl.NameValue(row,"TAXSUM"));
	}

	if (colid == 'TAXSUM') {
		if(gclx_taxknd.bindcolval=="1"){ //과세일 경우 
			gcds_taxdtl.NameValue(row,'TAXVATAMT')= Math.round(gcds_taxdtl.NameValue(row,'TAXSUM')*0.1);
		}else{
			gcds_taxdtl.NameValue(row,'TAXVATAMT')=0;
		}
	}

	if(colid=='TAXPDTNAM'&&gcds_taxdtl.NameValue(row,'TAXPDTNAM')!=""){
		 if(gcds_taxdtl.NameValue(row,'TAXPDTNAM').length>34){
				alert("품목명이 너무 길어서 저장이 되지 않을 수도 있습니다.");
		 }
	}
</script>

<script language=JavaScript for=gcgd_taxdtl event=onKeyPress()>
	ln_Auto_Sum();
</script>

<script language=JavaScript for=gcgd_taxdtl event=OnKillFocus()>
	ln_Auto_Sum();
</script>

<script language=JavaScript for=gcem_taxdat event=onKeyUp(kcode,scode)>

	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"MMDD") = gcem_taxdat.text.substring(4,8);

</script>
 
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	 //alert("작업이 성공적으로 완료되었습니다.");
	
	 //alert("BATCH_ID::"+gcds_return.namevalue(gcds_return.rowposition,"BATCH_ID"));
	 //alert("ID::"+gcds_return.namevalue(gcds_return.rowposition,"ID"));
	 //alert("PASS::"+gcds_return.namevalue(gcds_return.rowposition,"PASS"));
	 /*	
	 ln_SM_Call(gcds_return.namevalue(gcds_return.rowposition,"BATCH_ID"),
	           gcds_return.namevalue(gcds_return.rowposition,"ID"),
			   gcds_return.namevalue(gcds_return.rowposition,"PASS"));
	 */
	 gcem_taxnbr.text = gcds_return.namevalue(gcds_return.rowposition,"TAXNBR"); //구분자 포함.
	 gcds_taxmst.namevalue(1,"TAXNBR")=gcem_taxnbr.text; 
	 alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

<script language=JavaScript for=gctr_data5 event=OnSuccess()>
	 alert("작업이 성공적으로 완료되었습니다.");

</script>

<script language=JavaScript for=gctr_data5 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data5.ErrorCode + "\n" + "Error Message : " + gctr_data5.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>


<!-- 매출 ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="3px" colspan=2><td></tr>
	<tr>
		<td align=left style="position:relative;left:6px;top:-2px" colspan=2>
			<table cellpadding="1" cellspacing="0" border="0" style='width:1024px;height:20px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:90px;" bgcolor="#eeeeee"><nobr>당초승인번호</nobr></td>
					<td class="tab23" style="width:200px">
						<comment id="__NSID__">
						<object id=gcem_ori_issue_id  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px;width:150px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="########################">
							<param name=PromptChar	  value="_">
							<param name=ReadOnly        value=true>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../../Common/img/btn/com_b_find.gif"		style="cursor:hand;position:relative;top:2px;left:6px;"	onclick="ln_ori_issue_id_find()">
					</td>
					<td class="tab23" style="width:550px"> <nobr> 
						<comment id="__NSID__">
						 <object id=gcem_ori_byr_com_regno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:1px;width:100px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=1>
								<param name=format        value="###-##-#####">
								<param name=Border        value=false>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							    <param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>&nbsp;
							
							<object id=gcem_ori_dti_wdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:1px;width:80px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=1>
								<param name=format        value="####-##-##">
								<param name=Border        value=false>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							    <param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>&nbsp;

							<object  id=gcem_ori_sup_amount classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=2>
								<param name=Border        value=false>
								<param name=Language	  value=1>
								<param name=ReadOnly        value=true>
							    <param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>&nbsp;
							
							<object  id=gcem_ori_tax_amount classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=2>
								<param name=Border        value=false>
								<param name=Language	  value=1>
								<param name=ReadOnly        value=true>
							    <param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>&nbsp;
							<object  id=gcem_ori_total_amount classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=2>
								<param name=Border        value=false>
								<param name=Language	  value=1>
								<param name=ReadOnly        value=true>
							    <param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>&nbsp;
							<object  id=gcem_ori_dti_type_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:30px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		   value="">
								<param name=Alignment      value=0>
								<param name=Border         value=false>
								<param name=GeneralEdit    value=true>
								<param name=Language	   value=1>
								<param name=ReadOnly       value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script></nobr> 
					</td>
					<td align="right">&nbsp;<nobr> 
					    <img src="../../Common/img/btn/com_b_appreq.gif"  style="cursor:hand;position:relative;top:0px;right:2px" onclick="ln_Request()">&nbsp;     
					    <img src="../../Common/img/btn/com_b_insert.gif"       style="cursor:hand;position:relative;top:0px;right:2px" onClick="ln_Initial()">
					    <img src="../../Common/img/btn/com_b_save.gif"		   style="cursor:hand;position:relative;top:0px;right:2px" onclick="ln_Save()">
						<!--<img src="../../Common/img/btn/com_b_sale.gif"    style="cursor:hand;position:relative;top:1px;right:2px" onClick="ln_Save()">--> 
						</nobr>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><!-- 수정사유 ----------------------------------------------------------------------------------------->
		<td style="position:relative;left:6px" colspan=2>
			<table cellpadding="1" cellspacing="0" border="0" style='width:1024px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:88px;" bgcolor="#eeeeee"><nobr>수정사유</nobr></td>
					<td ><comment id="__NSID__">
						<object id=gcem_modify_reason classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:50px">
							<param name=Text			value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=GeneralEdit     value="true">
							<param name=Language		value=1>
							<param name=ReadOnly        value=true>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../../Common/img/btn/com_b_find.gif"		style="cursor:hand;position:relative;top:2px;left:6px;"	onclick="ln_modify_reason_find()">
					    <comment id="__NSID__">
						<object id=gcem_modify_reason_nm1  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:200px">
							<param name=Text			value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=GeneralEdit     value="true">
							<param name=Language		value=1>
							<param name=ReadOnly        value=true>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
							<param name=ReadOnlyForeColor   value="red">
						</object>
						<object id=gcem_modify_reason_nm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:200px">
							<param name=Text			value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=GeneralEdit     value="true">
							<param name=Language		value=1>
							<param name=ReadOnly        value=true>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
							<param name=ReadOnlyForeColor   value="red">
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;
						
						<img src="../../Common/img/btn/com_b_taxm.gif"  style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Menual()"> 
					</td>
					<td class="tab41" width="70px" bgcolor="#eeeeee"><nobr>결재상태</nobr></td>
					<td><nobr>
						<comment id="__NSID__">
							<object  id=gclx_taxsts classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;font-size:12px;width:100px;height:100px;">
								<param name=CBData			    value="N^대기,R^요청,Y^승인,B^반송">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=Enable				value="false">
								<param name=ListExprFormat	    value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
							</object>
						</comment><script>__ws__(__NSID__);</script>
					    </nobr>
					</td>
					<td align="right">&nbsp;<nobr> 
					    <img src="../../Common/img/btn/com_b_print.gif"	     style="cursor:hand;position:relative;top:0px;right:2px" onClick="ln_Print()">
						</nobr>
					</td>
					
				</tr>
			</table>
		</td>
	</tr>
	
	<tr>
		<td height="25px" colspan=2>
			<b><font size="2" color="blue">&nbsp;◎ 매출정보(ERP)</font></b>
		<td>
	</tr>
	<tr><!-- ERP정보----------------------------------------------------------------------------------------->
	    <!-- 지점, 사업장, 종사업장, 회계구분(생략 : 강제입력), 귀속구분, 과세구분, 거래처 , 사업자번호, 거래처 담당자 성명, 거래처 담당자  EMAIL 
	                  전자발행구분, 적요, 상대계정과목, 작성자 부서, 작성자 사번, 외부시스템 매출발행체크
	         입금예정일, file첨부, 결재상태
	     -->
		<td style="position:relative;left:6px" colspan=2>
			<table cellpadding="1" cellspacing="0" border="0" style='width:1024px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>계산서번호</nobr></td>
					<td class="tab22" colspan=7>
						<comment id="__NSID__">
						<object id=gcem_taxnbr  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px;width:80px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="#000000-0000">
							<param name=PromptChar	  value="_">
							<param name=UpperFlag     value=1>
							<param name=ReadOnly      value=true>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
						</object>
					</comment><script>__ws__(__NSID__);</script>
					</td>
						
				</tr>
			
				<tr>
					<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>지점</nobr></td>
					<td class="tab21" >
						<comment id="__NSID__">
							<object  id=gclx_fdcode  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:70px;height:110px;">
								<param name=ComboDataID			value="gcds_fdcode">
								<param name=CBDataColumns		value="FDCODE,FDNAME">
								<param name=SearchColumn		value="FDNAME">
								<param name=Sort				value=false>
								<param name=Enable				value=true>
								<param name=ListExprFormat	    value="FDNAME^0^70">
								<param name=BindColumn			value="FDCODE">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
					</td>
					<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>사&nbsp;업&nbsp;장</nobr></td>
					<td class="tab22" width="250px">
					    <comment id="__NSID__"> 
							<object  id=gclx_cocode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:1px;font-size:12px;width:60px;height:200px;">
								<param name=CBData				value="02^서울,01^고성,04^홍성">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=ListExprFormat	    value="CDNAM^0^60">
								<param name=BindColumn			value="CDCODE">
								<param name=Enable              value=true>
							</object>
						</comment><script>__ws__(__NSID__);</script>&nbsp;
             			<span id=sp1 style="display:none;">
						<font color="" style="position:relative;top:-5px;" >종사업장</font>&nbsp;
						<comment id="__NSID__"> 
							<object  id=gcem_s_bizplace classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:35px;height:20px;position:relative;left:5px;top:2px">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script>
						</span>
					</td>
					<td class="tab33" width="100px" bgcolor="#eeeeee"><nobr>귀속구분</nobr></td>
					<td class="tab19" width="149px;">
						<comment id="__NSID__">
							<object  id=gclx_taxdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:0px;font-size:12px;width:140px;height:200px;">
								<param name=ComboDataID			value="gcds_taxdiv">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=ListExprFormat	    value="CDNAM^0^130">
								<param name=BindColumn			value="CDCODE">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
					</td>
					<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>과세구분</nobr></td><!-- =부가세종류 -->
					<td class="tab22" width="189px">
						<comment id="__NSID__">
							<object  id=gclx_taxknd  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:90px;height:150px;">
								<param name=ComboDataID			value="gcds_taxknd">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=ListExprFormat		value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
					</td>	
				</tr>
				
				<tr>
					<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>거&nbsp;래&nbsp;처</nobr></td>
					<td class="tab22" width="924px;" colspan="7"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_vendcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:90px">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="#############">
								<param name=PromptChar	value="_">
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
						<img name="btn_find2" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-2px;cursor:hand"	 onclick="ln_Vend_Popup()">
						<input id=txt_vendnm type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:255px;" readOnly>
						<comment id="__NSID__">
							<object  id=gcem_vendid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:115px;">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="###-##-#####">
								<param name=PromptChar	value="_">
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
							<object  id=gcem_seq classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:50px;">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=visible			value=false>
								<param name=PromptChar	value="_">
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					
				</tr>
				<tr>	
					<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>거래처담당정보</nobr></td>
					<td class="tab21" width="189px" ><nobr>
						<comment id="__NSID__">
						  <!-- 담당자명 -->
							<object  id=gcem_empnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:5px;top:2px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language			value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>거래처 Email</nobr></td><!--=거래처 Email-->
					<td class="tab22"  colspan=5  >
						<comment id="__NSID__">
							<object  id=gcem_email classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:273px;height:20px;position:relative;left:5px;top:0px">		
								<param name=Text				value="">
								<param name=Alignment           value=0>
								<param name=Border              value=true>
								<param name=GeneralEdit         value=true>
								<param name=Language	        value=1>
								<param name=ReadOnly            value=true> 
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				<tr>
					<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>적&nbsp;&nbsp;&nbsp;&nbsp;요</nobr></td>
					<td class="tab21"  width="500px" colspan="5"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_erp_remark classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:500px;height:20px;position:relative;left:5px;top:0px">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>계산서일자</nobr></td>
					<td class="tab22"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_taxdat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;left:5px;top:2px;width:70px;height:20px;" class="txtbox">
									<param name=Alignment	  value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable		  value="true">
							</object>
						</comment><script>__ws__(__NSID__);</script>&nbsp;
						<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_GetCallCalendar('gcem_taxdat2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">-->
					    <img src="../img/calender.gif" value="calender.gif" id=img_calendar1  OnClick="ln_GetCallCalendar('gcem_taxdat', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">
					    </nobr>
					</td>
				</tr>
				<tr>
					<td class="tab12" width="100px" bgcolor="#eeeeee"><nobr>원&nbsp;&nbsp;&nbsp;&nbsp;가</nobr></td>
					<td class="tab23" width="500px" colspan="5">
						<nobr>
						<input id="txt_costcd" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6"  readOnly=true>	
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="원가코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Costcd_Popup();">				
						<input id="txt_costnm" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >			
						&nbsp; <font color="blue" >* 원가 미존재시 [판매관리비 등]으로 입력하세요.</font>
						</nobr>
					</td>
					<td class="tab12" width="100px" bgcolor="#eeeeee"><nobr>입금예정일</nobr></td>
					<td ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_duedate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;left:5px;top:2px;width:70px;height:20px;" class="txtbox">
									<param name=Alignment	  value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable		  value="true">
							</object>
						</comment><script>__ws__(__NSID__);</script>&nbsp;
						<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_GetCallCalendar('gcem_taxdat2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">-->
					    <img src="../img/calender.gif" value="calender.gif" id=img_calendar1  OnClick="__GetCallCalendar('gcem_duedate', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">
					    </nobr>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<tr>
		<td height="25px" colspan=2 >
			<b><font size="2" color="blue">&nbsp;◎ 공급자 / 공급받는자 정보 </font></b>
		<td>
	</tr>
	
	<!--공급자 : 공급받는자 정보----------------------------------------------------------------------------------------->
	<!--공급자 : 등록번호, 상호, 대표자, 사업장주소, 종사업자,   업태, 업종, 담당자, 연락처, 담당자 이메일,  
          공급받는자 : 등록번호, 상호, 대표자, 사업장주소, (종사업자), 업태, 업종, 담당자, 연락처, 담당자 이메일,	
 	           공통 : 세액종류(과세, 영세 ) 
 	-->
 	
	<tr>
		<td style="position:relative;left:6px"  >
			<table cellpadding="1" cellspacing="0"  style='width:511px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab13" width="510px" bgcolor="#eeeeee" colspan=4><nobr>공급자</nobr></td>
				</tr>
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>등록번호</nobr></td>
					<td class="tab22" width="430px" align="center" colspan=3><nobr>
						   <object id=gcem_sup_com_regno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:300px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=1>
								<param name=format        value="###-##-#####">
								<param name=Border        value=false>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>
						</nobr>
					</td>
				</tr>
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>상호</nobr></td>
					<td class="tab21" width="175px" ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_sup_com_name classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:160px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>성명</nobr></td>
					<td class="tab22" width="175px"> 
						<comment id="__NSID__">
							<object  id=gcem_sup_rep_name classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:100px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>사업장주소</nobr></td>
					<td class="tab21" ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_sup_com_addr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:170px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>종사업장번호</nobr></td>
					<td class="tab22" > 
						<comment id="__NSID__">
							<object  id=gcem_sup_bizplace_code classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:100px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>업태</nobr></td>
					<td class="tab21"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_sup_com_type classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:160px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>업종</nobr></td>
					<td class="tab22"> 
						<comment id="__NSID__">
							<object  id=gcem_sup_com_classify classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:160px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>담당자</nobr></td>
					<td class="tab21"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_sup_emp_name classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:100px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>연락처</nobr></td>
					<td class="tab22"> 
						<comment id="__NSID__">
							<object  id=gcem_sup_tel_num classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:150px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				<tr>
					<td class="tab12" width="80px" bgcolor="#eeeeee"><nobr>이메일</nobr></td>
					<td colspan=3><nobr>
						<comment id="__NSID__">
							<object  id=gcem_sup_email classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:300px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
			</table>
		</td>
		
		<td style="position:relative;left:6px" >
			<table cellpadding="1" cellspacing="0"  style='width:512px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab13" width="510px" bgcolor="#eeeeee" colspan=4><nobr>공급받는자</nobr></td>
				</tr>
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>등록번호</nobr></td>
					<td class="tab22" width="430px" align="center" colspan=3><nobr>
						     <object id=gcem_byr_com_regno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:2px;width:300px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=1>
								<param name=format        value="###-##-#####">
								<param name=Border        value=false>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>
						</nobr>
					</td>
				</tr>
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>상호</nobr></td>
					<td class="tab21" width="175px" ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_byr_com_name classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:3px;width:170px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>성명</nobr></td>
					<td class="tab22" width="175px"> 
						<comment id="__NSID__">
							<object  id=gcem_byr_rep_name classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:3px;width:150px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>사업장주소</nobr></td>
					<td class="tab21" ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_byr_com_addr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:3px;width:170px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>종사업장번호</nobr></td>
					<td class="tab22" > 
						<comment id="__NSID__">
							<object  id=gcem_byr_bizplace_code classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:3px;width:150px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>업태</nobr></td>
					<td class="tab21"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_byr_com_type classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F     style="position:relative;top:3px;width:170px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>업종</nobr></td>
					<td class="tab22"> 
						<comment id="__NSID__">
							<object  id=gcem_byr_com_classify classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:3px;width:150px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				<tr>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>담당자</nobr></td>
					<td class="tab21"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_byr_emp_name classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:3px;width:170px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab11" width="80px" bgcolor="#eeeeee"><nobr>연락처</nobr></td>
					<td class="tab22"> 
						<comment id="__NSID__">
							<object  id=gcem_byr_tel_num classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:3px;width:150px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
				<tr>
					<td class="tab12" width="80px" bgcolor="#eeeeee"><nobr>이메일</nobr></td>
					<td colspan=3><nobr>
						<comment id="__NSID__">
							<object  id=gcem_byr_email classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:3px;width:170px;height:20px;">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							    <param name=Visible       value=true>
							    <param name=ReadOnly      value=true>
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<tr>
		<td style="position:relative;left:6px" colspan=2 >
			<table cellpadding="1" cellspacing="0"  style='width:1024px;height:30px;border:0 solid #708090'>
				<tr>
					<td class="tab33" width="73px" bgcolor="#eeeeee"><nobr>비고1</nobr></td>
					<td class="tab21" colspan=7><nobr>
						<comment id="__NSID__">
							<object  id=gcem_remark classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:900px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
				</tr>
				<tr>
					<td class="tab33" width="73px" bgcolor="#eeeeee"><nobr>비고2</nobr></td>
					<td class="tab21" colspan=7><nobr>
						<comment id="__NSID__">
							<object  id=gcem_remark2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:900px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		 value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
				</tr>
				<tr>
					<td class="tab33" width="73px" bgcolor="#eeeeee"><nobr>비고3</nobr></td>
					<td class="tab21" colspan=7><nobr>
						<comment id="__NSID__">
							<object  id=gcem_remark3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:900px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		 value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
				</tr>
				<tr>
					<td class="tab33" width="73px" bgcolor="#eeeeee"><nobr>공급가액</nobr></td>
					<td class="tab22" width="165px" align=right><nobr>
						<comment id="__NSID__">
							<object  id=gcem_sup_amount classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:0px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=2>
								<param name=Border        value=false>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td class="tab33" width="79px" bgcolor="#eeeeee"><nobr>부가세액</nobr></td>
					<td class="tab22" width="165px" align=right ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_tax_amount classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:0px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=2>
								<param name=Border        value=false>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td class="tab33" width="79px" bgcolor="#eeeeee"><nobr>합계</nobr></td>
					<td class="tab22" width="165px" align=right><nobr>
						<comment id="__NSID__">
							<object  id=gcem_total_amount classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:0px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=2>
								<param name=Border        value=false>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td class="tab33" width="79px" bgcolor="#eeeeee"><nobr>수정사유</nobr></td>
					<td class="tab21" width="177px" ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_amend_code classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:20px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
								<param name=Visible       value="true">
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
 							</object>&nbsp;
							<object  id=gcem_amend_codenm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:145px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=false>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
				</tr>
        	</table>
        </td>
    </tr>    
    
	<!-- 상세정보 품목----------------------------------------------------------------------------------------->
	<!--일자(월/일), 품목, 규격, 수량, 단가, 공급가액, 세액, 합계, 현금, 수표, 어음, 외상매입금, 영수, 청구   -->
	<tr>
		<td height="25px" colspan=2 >
			<b><font size="2" color="blue">&nbsp;◎ 세부내역 </font></b>
		<td>
	</tr>
    <tr>
		<td style="cursor:hand;position:relative;left:6px;" width="845px" colspan=2><nobr>
		 	<comment id="__NSID__">
		  		<object id=gcgd_taxdtl classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" width='1022px' height='41px' border='1'>
					<param name="dataid"		 value="gcds_taxdtl">
					<param name="borderstyle"    value="0">
					<param name="indwidth"       value="0">
					<param name="fillarea"		 value="true">
					<param name="colsizing"      value="true">
					<param name="editable"       value="true">
					<param name="format"		 value="  
					<C>  Name='월일'			ID=MMDD                Width=80 	align=center   bgcolor=#CCFFCC  mask='XX/XX' edit=none </C>
					<C>  Name='품목'         ID=TAXPDTNAM           Width=360 	align=left     bgcolor=yellow </C>			
					<C>  Name='규격'         ID=TAXSTD          	   Width=150	align=left     bgcolor=yellow </C>			  					
					<C>  Name='수량'		    ID=TAXQTY          	   Width=50 	align=right    bgcolor=yellow </C>
					<C>  Name='단가'         ID=TAXPRIC             Width=120	align=right	   bgcolor=yellow </C>					
					<C>  Name='공급가액'      ID=TAXSUM              Width=120  	align=right	   bgcolor=yellow </C>					
					<C>  Name='부가세액'      ID=TAXVATAMT           Width=120	align=right	   bgcolor=yellow </C>					
				  	 ">
				</object>
			</comment><script>__ws__(__NSID__);</script></nobr>
		<td>			   
     </tr>	
     
      <tr>
		<td  height="25px" colspan =2>
			<b><font size="2" color="blue">&nbsp;◎ 파일첨부 </font></b>
		</td>
	 </tr> 
	 
	<form name="fileForm" method="post" enctype="multipart/form-data" align="absmiddle"  >
	    <input type="hidden" name="realFileName">
		<input type="hidden" name="virtualFileName">
		<input type="hidden" name="mode"> 
		<input type="hidden" name="file_position"> 	     
	 <tr>
     	<td style="position:relative;left:6px" colspan=2>
			<table cellpadding="1" cellspacing="0" border="0" style='width:1022px;height:30px;border:1 solid #708090'>	
			     <tr>
			    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>발행승인요청서</nobr> </td>
					<td class="tab22">
						<input type="file"  name="filename2"   style="position:relative;left:4px;top:0px;width:536px;height:20px" >&nbsp;
					</td>	
			     </tr>
			     <tr>
			    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>사업자등록번호</nobr> </td>
					<td class="tab22">
						<input type="file"  name="filename1"   style="position:relative;left:4px;top:0px;width:536px;height:20px" >&nbsp;
					</td>	
			     </tr>
			     <tr>
			    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>첨부파일</nobr> </td>
					<td class="tab22" >
						<select multiple name="fileList" id="fileList" style="position:relative;left:4px;top:2px; width:450px;height:55px;border-color:#666666;background-color:#FFFOFO;font-weight:bold;">
							 <option></option>
						</select>
						<img src="<%=dirPath%>/Omsm/images/FileAddOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileUpload()">
					    <img src="<%=dirPath%>/Omsm/images/FileDelOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileDelete()">
					</td>    
			    </tr>
		     </table>
		 </td>
     </tr>
     
     </form>
     
      <!-- 파일 삭제용 폼-->
	<form METHOD=POST NAME="file_del">
	<input type="hidden" name="realFileName">
	<input type="hidden" name="virtualFileName">
	<input type="hidden" name="saveDir">
	<input type="hidden" name="mode">
	</form> 
    
    <!-- 파일 임시 업로드용 iFrame -->
	<iframe name="tempUpload" width="0" height="0" src="about:blank"></iframe>
    
</table> 
			 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [DATA2]
------------------------------------------------------------------------------>
<comment id="__NSID__">
    <object  id=gcbn_data classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"		VALUE="gcds_taxmst">
	<PARAM NAME="ActiveBind"	VALUE="true">
	<PARAM NAME="BindInfo"		VALUE="
	<C>Col=TAXNBR     		Ctrl=gcem_taxnbr    		Param=text </C>
	">
	</object>

</comment><script>__ws__(__NSID__);</script> 



<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N - 매 출 세 금 계 산 서
------------------------------------------------------------------------------>
<comment id="__NSID__">
  <object  id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="MasterDataID"		        value="gcds_rptmst">
	<param name="DetailDataID"		        value="gcds_taxmst">	
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="true">
    <PARAM NAME="PrintSetupDlgFlag"         VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
	<B>id=FHeader ,left=0,top=0 ,right=2871 ,bottom=376 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=1897 ,top=95 ,right=2831 ,bottom=373 ,border=true ,penstyle=solid ,penwidth=2</X>
	<T>id='담  당' ,left=1902 ,top=98 ,right=2127 ,bottom=151 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='검  토' ,left=2135 ,top=98 ,right=2360 ,bottom=151 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확  인' ,left=2368 ,top=98 ,right=2593 ,bottom=151 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='승  인' ,left=2601 ,top=98 ,right=2826 ,bottom=151 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1897 ,top=153 ,right=2826 ,bottom=153 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1897 ,top=302 ,right=2826 ,bottom=302 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2006 ,top=310 ,right=1982 ,bottom=365 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2707 ,top=307 ,right=2683 ,bottom=362 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2482 ,top=310 ,right=2458 ,bottom=365 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2246 ,top=307 ,right=2223 ,bottom=362 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2365 ,top=95 ,right=2365 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2130 ,top=93 ,right=2130 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2596 ,top=93 ,right=2596 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='매출 세금계산서 발생 승인 요청서' ,left=151 ,top=201 ,right=1884 ,bottom=325 ,face='HY중고딕' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=312 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='APP_TEAMNM', left=164, top=95, right=574, bottom=156, align='left', face='굴림', size=14, bold=false, underline=true, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=164 ,top=198 ,right=164 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=706 ,top=198 ,right=706 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1752 ,top=198 ,right=1752 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=164 ,top=198 ,right=2828 ,bottom=198 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=164 ,top=312 ,right=2828 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1976 ,top=198 ,right=1976 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2662 ,top=198 ,right=2662 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2831 ,top=198 ,right=2831 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=947 ,top=198 ,right=947 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='작성일자' ,left=1098 ,top=204 ,right=1259 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='적요(품목)' ,left=1982 ,top=204 ,right=2659 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='입금예정일' ,left=2667 ,top=204 ,right=2828 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='합계액' ,left=1757 ,top=204 ,right=1974 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1558 ,top=198 ,right=1558 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1336 ,top=198 ,right=1336 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='유형' ,left=1270 ,top=257 ,right=1334 ,bottom=299 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='과세' ,left=1270 ,top=214 ,right=1334 ,bottom=259 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1265 ,top=198 ,right=1265 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='대표자' ,left=953 ,top=204 ,right=1085 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사업자등록번호' ,left=714 ,top=204 ,right=942 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='업체명' ,left=169 ,top=204 ,right=701 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1090 ,top=198 ,right=1090 ,bottom=312 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='공급가액' ,left=1341 ,top=204 ,right=1553 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세액' ,left=1564 ,top=204 ,right=1749 ,bottom=307 ,face='HY중고딕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=194 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=164 ,top=85 ,right=2828 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=164 ,top=0 ,right=164 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2831 ,top=0 ,right=2831 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='VEND_NM', left=169, top=3, right=701, bottom=79, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=706 ,top=0 ,right=706 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=947 ,top=0 ,right=947 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='VEND_ID', left=714, top=3, right=942, bottom=79, mask='XXXXXX-XXXXXXX',face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VD_DIRECT', left=953, top=3, right=1085, bottom=79, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1090 ,top=0 ,right=1090 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TAXDAT', left=1098, top=3, right=1259, bottom=79 ,mask='XXXX.XX.XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1265 ,top=0 ,right=1265 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TAXKNDNM', left=1270, top=3, right=1334, bottom=79, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1336 ,top=0 ,right=1336 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TAXSUM', left=1341, top=3, right=1553, bottom=79, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1558 ,top=0 ,right=1558 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TAXVATAMT', left=1564, top=3, right=1749, bottom=79, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1752 ,top=0 ,right=1752 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TAXTOT', left=1757, top=3, right=1974, bottom=79, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1976 ,top=0 ,right=1976 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DUEDATE', left=2667, top=3, right=2828, bottom=79 ,mask='XXXX.XX.XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2662 ,top=0 ,right=2662 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='REMARK', left=1982, top=3, right=2659, bottom=79, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
	
">
</object></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 