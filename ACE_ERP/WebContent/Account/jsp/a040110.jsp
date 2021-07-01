<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  회계관리 - 부가세관리 - 매입등록
+ 프로그램 ID	:  a040110.jsp
+ 기 능 정 의	:  매입등록 
+ 작   성   자     :  정 영 식
+ 작 성 일 자     :  2014.04.25
+ 서 블 릿 명	:  a040110_s1
---------------------------------------------------------------------------
+ 수   정   자     :  정 영 식
+ 수 정 일 자     :  2018.04.24
+ 수 정 내 용     :  신용카드 번호 입력 처리 막음 (신용카드는 PMS에서만 입력 가능 )  
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>매입등록</title>

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

<% String ss_userid  = (String)session.getAttribute("vusrid"); %>

var gstrempno="";
var gstrGubun ="";
var gstrdeptcd="";
var gstrAuthgr="";


/******************************************************************************
Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	
	ln_Before();
	ln_Initial();
	ln_Query_Authority2(); 
}

/******************************************************************************
Description : 선조회
******************************************************************************/
function ln_Before(){
	//지점코드
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();
	
	//귀속구분[매입]
	gcds_taxdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0014"; 
	gcds_taxdiv.Reset();
	
	//부가세종류[매입]
	gcds_taxknd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0013"; 
	gcds_taxknd.Reset();
}


/******************************************************************************
Description : 페이지 로딩
******************************************************************************/
function ln_Initial(){
		
	var str_ori_vendcd=gcem_vendcd.text;         //거래처 코드 
	var str_ori_vendnm=txt_vendnm.value;         //거래처 명 
	var str_ori_vendid=gcem_vendid.text;         //등록번호
	var str_ori_seq=gcem_seq.text;               //담당자 순번 
	var str_ori_vend_empnm=gcem_vend_empnm.text; //거래처담당자 
	var str_ori_vend_email=gcem_vend_email.text; //거래처담당자 이메일 
	var str_ori_vd_direct= gcem_vd_direct.text;  //대표자명
	
	var str_ori_atcode=gcem_atcode.text;         //상대계정
	var str_ori_atkornam=txt_atkornam.value;     //계정명
	var str_ori_atdecr=txt_atdecr.value;         //차대구분 (hidden ) 
	var str_ori_costcd=gcem_costcd.text;         //원가코드
	var str_ori_costnm=txt_costnm.value;         //원가명 
	
	gcem_taxnbr_s.text="";
	
	ln_Taxmst_SetDataHeader();
	ln_Taxdtl_SetDataHeader();
	gcds_taxmst.addrow();
	gcds_taxdtl.addrow();
	
	gclx_cocode.bindcolval ="02"; //사업장 서울 기본
	ln_Display_Cocode();          //종사업장번호 display  
	
	gcem_deptnm.text=gs_deptnm;   //담당부서명
	gcem_deptcd.text=gs_deptcd;   //담당부서코드 
	gcem_empnm.text=gusrnm;       //담당자명
	gcem_empno.text=gs_userid;    //담당자사번
	gcem_taxdat.text="";          //계산서일자 
	gclx_buy.bindcolval ="Y";
	
	//과세구분
	gclx_taxknd.bindcolval ="1";
	//귀속구분
	gclx_taxdiv.bindcolval ="0001";
	
	//거래처
	if(v_chk_vend.checked==true){
		gcem_vendcd.text=str_ori_vendcd;          //거래처 코드 
		txt_vendnm.value=str_ori_vendnm;          //거래처 명 
		gcem_vendid.text=str_ori_vendid;          //등록번호
		gcem_seq.text=str_ori_seq;                //담당자 순번 
		gcem_vend_empnm.text=str_ori_vend_empnm;  //거래처담당자 
		gcem_vend_email.text=str_ori_vend_email;  //거래처담당자 이메일 
		gcem_vd_direct.text=str_ori_vd_direct;    //대표자명.
	}else{
		gcem_vendcd.text="";      //거래처 코드 
		txt_vendnm.value="";      //거래처 명 
		gcem_vendid.text="";      //등록번호
		gcem_seq.text="";         //담당자 순번 
		gcem_vend_empnm.text="";  //거래처담당자 
		gcem_vend_email.text="";  //거래처담당자 이메일 
		gcem_vd_direct.text="";   //대표자명
		gcem_cocomyn.text="";     //업체구분
	}
	
	//적요
	gcem_erp_remark.text="";
	gcem_fsdat.text="";
	gcem_fsnbr.text="";       //전표접수번호
	gclx_fsstat.text="";      //전표상태
	
	
	//상대계정
	if(v_chk_account.checked==true){
		gcem_atcode.text= str_ori_atcode;         //상대계정
		txt_atkornam.value= str_ori_atkornam;     //계정명
		txt_atdecr.value= str_ori_atdecr;         //차대구분 (hidden ) 
	}else{
		gcem_atcode.text="";      //상대계정
		txt_atkornam.value="";    //계정명
		txt_atdecr.value="";      //차대구분 (hidden ) 
	}
	
	
	//원가
	if(v_chk_account.checked==true){
		gcem_costcd.text= str_ori_costcd;         //원가코드
		txt_costnm.value= str_ori_costnm;         //원가명 
	}else{
		gcem_costcd.text="";      //원가코드
		txt_costnm.value="";      //원가명
    }
	
	//공급가액, 부가세액, 합계, 수정사유
    gcem_sup_amount.text=0;
    gcem_tax_amount.text=0;
    gcem_total_amount.text=0;
    
    ln_Taxknd_Chg();
    
    gclx_ebillgb.bindcolval="1"; //매입 기본은 스마트빌....
    
}


/******************************************************************************
조회권한 신규
******************************************************************************/
function ln_Query_Authority2(){
	gcds_empno_chk.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010010_s1?v_str1=&v_str2=<%=ss_userid%>&v_str3=1171&v_str4=Y";
	//prompt('gcds_empno_chk.DataID',gcds_empno_chk.DataID );
	gcds_empno_chk.Reset();
}

/******************************************************************************
조회권한 결과 return 
******************************************************************************/
function ln_Authority_Result(row,colid){
	var cnt=0;
	gstrempno="'<%=ss_userid%>',";
	
	if(row>0){
   //권한그룹
		gstrAuthgr=gcds_empno_chk.namevalue(row,"AUTHGR");
	
   //부서(6-14), 사번(15-19)
		//부서(6-25), 사번(26-30)
   		for(i=6;i<=30;i++){
			if(i<=25){		  
				if(gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))!=""){ //부서존재 
					cnt+=1;
					gstrdeptcd+="'"+gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))+"',"				
				}			
			}

			if(i>=16){
       			if(gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))!=""){ //사번존재 
					gstrempno+="'"+gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))+"',"				
				}
			}
		}//for

		if(cnt>0){
			gstrdeptcd=gstrdeptcd.substring(0,gstrdeptcd.length-1);
		}
	}
	
	gstrempno=gstrempno.substring(0,gstrempno.length-1);

	if(gstrAuthgr=="A"){
		gstrGubun = gstrAuthgr;
	}else{
		gstrGubun="";
	}
}


/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(){
		
	//권한관리
	var str1 = gclx_fdcode.BindColVal;
	var str2 = gcem_taxnbr_s.text;
	var str3 = gstrGubun;  //구분
	var str4 = gstrempno;  //로그인
	var str5 = gstrdeptcd; //부서 	
	
	
	if(fn_trim(gcem_taxnbr_s.text)==""){
		alert("계산서번호를 입력하십시요.");
		return false;
	}
	
	//매입 체크 
	if(str2.substring(0,1)=="B"||str2.substring(0,1)=="D"||str2.substring(0,1)=="F"){
		alert("계산서번호가 매입건이 아닙니다.");
		return;
	}
	
	gcds_taxmst.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040110_s1?v_str1="+str1
																	     +"&v_str2="+str2
																		 +"&v_str3="+str3
																		 +"&v_str4="+str4
																		 +"&v_str5="+str5;
	//prompt('gcds_taxmst',gcds_taxmst.DataID);
	gcds_taxmst.Reset();
	
	
	gcds_taxdtl.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040110_s2?v_str1="+gcem_taxnbr_s.text;
	//prompt('',gcds_taxdtl.DataID);
	gcds_taxdtl.Reset(); 
	
	
}


/******************************************************************************
Description : 추가 - 매입 등록 
******************************************************************************/
function ln_Add(){
	ln_Initial();
	gclx_fdcode.bindcolval = gs_fdcode;
}

/******************************************************************************
Description : 매입등록 

******************************************************************************/
function ln_Save(){
		
	//서울 A-매입, B-매출  , 개성 C-매입, D-매출 , 금강산 E-매입, F-매출
	if(gclx_fdcode.bindcolval =="02"){        // 서울 
		strParam ="A";
	}else if(gclx_fdcode.bindcolval =="03"){ //금강산
		strParam ="E";
	}else if(gclx_fdcode.bindcolval =="04"){ //개성 
		strParam ="C";
	}else{
		alert("지점을 확인하세요.");
	} 
	strParam = strParam+gcem_taxdat.text.substring(0,6); //구분값+년월:
		
	ln_Data_Setting();
	if(!ln_Chk())return;
	if (gcds_taxmst.IsUpdated) {	
		if (confirm("매입[세금]정보를 저장 하시겠습니까?")){	
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040110_t1";
			gctr_data.KeyValue = "Account.a040110_t1(I:USER1=gcds_taxmst,I:USER2=gcds_taxdtl,O:USER7=gcds_return)";	
			gctr_data.Parameters ="v_str1="+strParam;
			//prompt('',gcds_taxmst.text);
			//prompt('',gcds_taxdtl.text);
			gctr_data.post();
		}	
	}
}

/******************************************************************************
Description : DataSet에 반영

******************************************************************************/
function ln_Data_Setting(){
			
	var row = 0;
	row = gcds_taxmst.rowposition;
	var strdat = gcem_taxdat.text; 
	var strtaxkidiv ="";
		
	if (strdat.substring(4,6) >='01' && strdat.substring(4,6) <='03') {
		strtaxkidiv="1";	//기수[1]
	}else if(strdat.substring(4,6) >='04' && strdat.substring(4,6) <='06') {
		strtaxkidiv="2";	//기수[2]
	}else if(strdat.substring(4,6) >='07' && strdat.substring(4,6) <='09') {
		strtaxkidiv="3";	//기수[3]
	}else if(strdat.substring(4,6) >='10' && strdat.substring(4,6) <='12') {
		strtaxkidiv="4";	//기수[4]
	}
	
	gcds_taxmst.namevalue(row,"TAXIODIV")="A" ;
	gcds_taxmst.namevalue(row,"TAXSUM")=gcem_sup_amount.text ;
	gcds_taxmst.namevalue(row,"TAXVATAMT")=gcem_tax_amount.text ;
	gcds_taxmst.namevalue(row,"TAXTOT")=gcem_total_amount.text ;
	gcds_taxmst.namevalue(row,"TAXPRTYN")="Y";
	gcds_taxmst.namevalue(row,"TAXTYPE")="N" ;
	gcds_taxmst.namevalue(row,"TAXKIDIV")=strtaxkidiv ;  //계산해서 넣기 ( 계산서 일자로 )
	gcds_taxmst.namevalue(row,"WORKTYPE")="A" ;
	gcds_taxmst.namevalue(row,"WRDT")=gs_date ;
	gcds_taxmst.namevalue(row,"WRID")=gs_userid ;
	gcds_taxmst.namevalue(row,"UPDT")=gs_date ;
	gcds_taxmst.namevalue(row,"UPID")=gs_userid ;
		
	//2009.12.04 JYS 전자세금계산서 전자발행구분 추가
    if(rdo_gubun1_1.checked==true){
    	gcds_taxmst.namevalue(row,"GUBUN")="1" ;  //전자 
	}else if(rdo_gubun1_2.checked==true){
		gcds_taxmst.namevalue(row,"GUBUN")="2" ;  //수기
	}		
	
	gcds_taxmst.namevalue(row,"EXTCHK")="0" ;
	
	//세부내역
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"WRDT")=gs_date;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"WRID")=gs_userid;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"UPDT")=gs_date;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"UPID")=gs_userid;
		
}

/******************************************************************************
Description : 필수항목 체크 
******************************************************************************/
function ln_Chk(){

	 if (fn_trim(gs_date)=="")   { alert("세션이 존재하지 않습니다. 확인하십시요.");  return false; }
	 if (fn_trim(gs_userid)=="") { alert("작성자가 존재하지 않습니다. 확인하십시요.");  return false; }
	  
	 //필수항목 체크 
	 if (gclx_fdcode.bindcolval=="") { alert("지점이 존재하지 않습니다. 확인하십시요.");  return false; } 
	 if (gclx_cocode.bindcolval=="") { alert("사업장이 존재하지 않습니다. 확인하십시요."); return false;	 }	 
	 if (fn_trim(gcem_deptcd.text)=="")   { alert("담당부서코드가  존재하지 않습니다. 확인하십시요."); return false; }
	 if (fn_trim(gcem_deptnm.text)=="")   { alert("담당부서명  존재하지 않습니다. 확인하십시요."); return false; }
	 if (fn_trim(gcem_empno.text)=="")    { alert("담당자사번이  존재하지 않습니다. 확인하십시요."); return false; }
	 if (fn_trim(gcem_empnm.text)=="")    { alert("담당자명이  존재하지 않습니다. 확인하십시요."); return false; }
	 
	 if (fn_trim(gcem_taxdat.text)=="")  { alert("계산서 일자가  존재하지 않습니다. 확인하십시요."); return false;}  
	 if (gclx_buy.bindcolval=="")    { alert("발행구분이  존재하지 않습니다. 확인하십시요."); return false;}  
	 if (gclx_taxknd.bindcolval=="") { alert("과세구분이 존재하지 않습니다. 확인하십시요."); return false;}
	 if (gclx_taxdiv.bindcolval=="") { alert("귀속구분이 존재하지 않습니다. 확인하십시요."); return false;}
	 
	 if (fn_trim(gcem_vendcd.text)=="")  { alert("거래처코드가 존재하지 않습니다. 확인하십시요."); return false; }
	 if (fn_trim(txt_vendnm.value)=="")  { alert("거래처명이 존재하지 않습니다. 확인하십시요."); return false; }
	 if (fn_trim(gcem_vendid.text)=="")  { alert("사업자등록번호가  존재하지 않습니다. 확인하십시요."); return false; }  
	 
	 
	 if(gclx_buy.bindcolval =="N"){  //역발행 매입
		 if (fn_trim(gcem_vend_empnm.text)=="")   { alert("거래처 담당 정보가  존재하지 않습니다. 확인하십시요."); return false; }  
		 if (fn_trim(gcem_vend_email.text)=="")   { alert("거래처 Email이  존재하지 않습니다. 확인하십시요."); return false;	 }  
	 }
	 
	 if (fn_trim(gcem_vd_direct.text)=="")    { alert("대표자명이 존재하지 않습니다. 확인하십시요."); return false;	 }
	 if (fn_trim(gcem_erp_remark.text)=="")   { alert("적요가  존재하지 않습니다. 확인하십시요."); return false; } 
	 
	 //상대계정
	 if (fn_trim(gcem_atcode.text)=="")    { alert("계정코드가 존재하지 않습니다. 확인하십시요."); return false;}   
	 if (fn_trim(txt_atkornam.value)=="")  { alert("계정명이 존재하지 않습니다. 확인하십시요."); return false;}   
	 
	 if (fn_trim(gcem_costcd.text)=="")  { alert("원가코드가 존재하지 않습니다. 확인하십시요."); return false;}   
	 if (fn_trim(txt_costnm.value)=="")  { alert("원가명이 존재하지 않습니다. 확인하십시요."); return false;}   
		 
	 //공급가액, 부가세액, 합계, 수정사유 
	 if (fn_trim(gcem_sup_amount.text)==""||gcem_sup_amount.text=="0")     { alert("공급가액이 존재하지 않습니다. 확인하십시요."); return false; }
	 if (fn_trim(gcem_total_amount.text)==""||gcem_total_amount.text=="0") { alert("합계액이  존재하지 않습니다. 확인하십시요."); return false; }
	 	 
	 //세부내역 
	 if(gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"MMDD")=="")     {alert("세부내역 월일이 존재하지 않습니다. 확인하십시요."); return false;}
	 if(gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXPDTNAM")==""){alert("세부내역 품목이 존재하지 않습니다. 확인하십시요."); return false;}
	 if(gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXSUM")==0)    {alert("세부내역 공급가액이 존재하지 않습니다. 확인하십시요."); return false;}
	
	 //Data cross check   
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
	 }else if(gclx_taxknd.bindcolval=="2"||gclx_taxknd.bindcolval=="3"){ //영세 면세일 경우 부가세액 체크 
		//0이 아니면 안됨.
	 	if(gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXVATAMT")!=0){
	 		alert("부가세액이 존재합니다.");
	 		return false;
	 	}	
	 }
	 
    //과세구분이 신용카드 일 경우만 신용카드 데이터 필수항목인가
	//2009.12.09 jys 과세구분이 신용카드 일경우 신용카드번호가 존재해야함.  
	if(gclx_taxknd.bindcolval=="8"&&gcem_canbr.text==""){
		alert("신용카드번호를 입력하십시요.");
		return false;
	}

    if(gclx_taxknd.bindcolval!="8"&&gcem_canbr.text!=""){
		alert("과세구분과 신용카드번호를 확인하십시요.");
		return false;
	}
    
    //2014.06.30
    //면세업체인데, 과세구분이 면세가 아니면 체크.
    if(gcem_cocomyn.text=="M-면세업체" ||gcem_cocomyn.text=="M" ){    	
    	if(gclx_taxknd.bindcolval!="3"){
    		alert("면세업체는 과세구분이 [면세]만 가능합니다.");
    		return false;
    	}
    }
	 
    //2015.01.21
    //이예빈요청
    //간이과세자일 경우 부가세액 0원  ( 꼭 체크 )
    if(gcem_cocomyn.text=="T-간이과세업체" ||gcem_cocomyn.text=="T" ){   
    	if(gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXVATAMT")!=0){
    		alert("간이과세 업체입니다. 부가세액을 확인 하십시요.");
    		return false;
    	}
    }
    
    //2017.01.31 jys EBILLGB 필수항목 추가
    if(gclx_ebillgb.bindcolval==""){
    	alert("eBill구분은 필수항목입니다.");	
    	return false;
    }
    
	//품목 길이체크
    //DTI_STATUS 체크하여 null 또는 취소완료, 수신거부 일 경우만 수정가능. 매출발행건만....
    /**
	if(gclx_status.bindcolval!=""&&gclx_status.bindcolval!="O"&&gclx_status.bindcolval!="R"){
		alert("상태를 확인해 주십시요. 저장할 수 없습니다.");
		return false;
	}
	**/
	//전표가 존재하면 수정불가...................................................................
	//2015.07.14
	if(fn_trim(gcem_fsdat.text)!="") {
		if (gs_userid=="6070001"||gs_userid=="2040080"||gs_userid=="2050053"||gs_userid=="2140004"){
		}else{
			alert("전표생성이 되었습니다. 수정 불가합니다."); return false;
		}
	}
	
	//2019.04.24.jys  신용카드 입력 불가 //2021.03.03 권미정씨 잠깐 추가 했다가 삭제했음
    if(gcem_canbr.text!=""){
    	if(gs_userid=="6070001"||gs_userid=="2140004"){
    		
    	}else{
			alert("신용카드번호는 매입등록에서 입력 불가 입니다. \nPMS에서 처리하십시요. \n문의 : 박준용DR (3842) ");
			return false;
    	}
	}
	
	return true;
}


/****************************************************************************************
	Description : 삭제
*****************************************************************************************/
function ln_Delete(){

	//삭제 전 체크 사항
	//0.데이터유무
	//1.전표발행유무
	if(gcds_taxmst.countrow<=0) return;
	if(fn_trim(gcem_fsdat.text)!="") {
		alert("전표생성이 되었습니다. 삭제 불가합니다."); return false;
	}
	
	var strParam = gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXNBR");
	
	if (confirm("매입[세금]정보를 삭제 하시겠습니까?")){	
		
		gcds_taxmst.deleterow(gcds_taxmst.rowposition);
		gcds_taxdtl.deleterow(gcds_taxdtl.rowposition);
					
		gctr_data3.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040110_t1";
		gctr_data3.KeyValue = "Account.a040110_t1(I:USER1=gcds_taxmst,I:USER2=gcds_taxdtl,O:USER7=gcds_return)";
		gctr_data3.Parameters ="v_str1="+strParam;
		//prompt('',gcds_taxmst.text);
		//prompt('',gcds_taxdtl.text);
		gctr_data3.post();
	}	
}

/******************************************************************************
Description : 사업장 Display    
******************************************************************************/
function ln_Display_Cocode(){
	
	if(gclx_cocode.bindcolval=="02"){//서울
		sp1.style.display = "";
		gcem_b_bizplace.text="0001"; //종사업장번호
	}else if(gclx_cocode.bindcolval=="03"){//양양
		sp1.style.display = "";
		gcem_b_bizplace.text="0002"; //종사업장번호
	}else if(gclx_cocode.bindcolval=="04"){//홍성
		sp1.style.display = "";
		gcem_b_bizplace.text="0003"; //종사업장번호
	}else{ //고성
		sp1.style.display = "none"; //숨김
		gcem_b_bizplace.text="";
		gcem_remark2.text="";
	}
}

/******************************************************************************
Description : Report Head 설정 - 세금계산서 상세내역
******************************************************************************/
function ln_Taxmst_SetDataHeader(){

	var s_tmp1 = "TAXNBR:STRING,COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,TAXIODIV:STRING,"
        	   + "TAXDIV:STRING,TAXDIVNM:STRING,TAXKND:STRING,TAXKNDNM:STRING,VEND_CD:STRING,VEND_ID:STRING,"
			   + "VEND_NM:STRING,TAXDAT:STRING,TAXSUM:DECIMAL,TAXVATAMT:DECIMAL,TAXTOT:DECIMAL,"
			   + "REMARK:STRING,TAXCDNBR:STRING,ATCODE:STRING,ATKORNAM:STRING,ATDECR:STRING,TAXPRTYN:STRING,"
			   + "TAXCNT:DECIMAL,LASTPRT:STRING,TAXTYPE:STRING,FSDAT:STRING,FSNBR:STRING,"
			   + "TAXKIDIV:STRING,WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
			   + "FDCODE:STRING,VD_DIRECT:STRING,BSNS_CND:STRING,BSNS_KND:STRING,ADDNM:STRING,"
			   + "FSSTAT:STRING,WORKTYPE:STRING,EMPNMK:STRING,DEPTNM:STRING,"
			   + "SEQ:DECIMAL,EMPNM:STRING,DEPTNM_2:STRING,HPNO:STRING,TELNO:STRING,EMAIL:STRING,"
			   + "DTI_STATUS:STRING,GUBUN:STRING,AMEND_CODE:STRING,AMEND_REMARK:STRING,EXTCHK:STRING,REMARK2:STRING,"
			   + "REMARK3:STRING,S_BIZPLACE:STRING,B_BIZPLACE:STRING,COSTCD:STRING,COSTNM:STRING,"
			   + "CONVERSATION_ID:STRING,SUPBUY_TYPE:STRING,DIRECTION:STRING,EBILLGB:STRING,DUEDATE:STRING,TAXSTS:STRING";
	gcds_taxmst.SetDataHeader(s_tmp1);
}

/******************************************************************************
	Description : Report Head 설정 - 세금계산서 상세내역
******************************************************************************/
function ln_Taxdtl_SetDataHeader(){

	var s_tmp1 = "TAXNBR:STRING,TAXSEQ:STRING,TAXPDTNAM:STRING,TAXSTD:STRING,TAXQTY:DECIMAL,"
			   + "TAXPRIC:DECIMAL,TAXSUM:DECIMAL,TAXVATAMT:DECIMAL,BIGO:STRING,WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,MMDD:STRING,TAXTOT:DECIMAL";
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
	
	//발행구분이 역발행 매입의 경우 
	if (gclx_buy.bindcolval =="N"){
	
		arrVAT[0]="VAT";
		strURL = "./gczm_vender_popup33.jsp";
		strPos = "dialogWidth:700px;dialogHeight:380px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrVAT,strPos);
			
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			if(arrParam[16]=="10"){
	  			gcem_vendid.Format="###-##-#####";  
	  		}else if (arrParam[16]=="13"){
	  			gcem_vendid.Format="######-#######"; 		 
	  		}
			gcem_seq.text      = arrParam[0];  //순번  
			gcem_vendcd.text   = arrParam[1];  //거래처 코드  
			txt_vendnm.value   = arrParam[2];  //거래처명
			gcem_vendid.text   = arrParam[15]; //거래처 사업자 등록번호 
			gcem_vend_empnm.text = arrParam[3];  //담당자성명           
			gcem_vend_email.text = arrParam[5];  //Email    
			gcem_vd_direct.text  = arrParam[14]; //성명
			
			if(arrParam[17]=="N"){
				arrParam[17] ="N-일반업체";					
			}else if(arrParam[17]=="Y"){
				arrParam[17] ="Y-협력업체";
			}else if(arrParam[17]=="S"){
				arrParam[17] ="S-특수관계업체";
			}else if(arrParam[17]=="T"){
				arrParam[17] ="T-간이과세업체";
			}else if(arrParam[17]=="M"){	
				arrParam[17] ="M-면세업체";
			}
			gcem_cocomyn.text = arrParam[17]; //업체구분
			
		} else {
			gcem_seq.text      = "";    //순번  
			gcem_vendcd.text   = "";    //거래처 코드  
			txt_vendnm.value   = "";    //거래처명
			gcem_vendid.text   = "";    //거래처 사업자 등록번호 
			gcem_vend_empnm.text = "";  //담당자성명           
			gcem_vend_email.text = "";  //Email    
			gcem_vd_direct.text  = "";  //성명
			gcem_cocomyn.text ="";
			
		}
	}else if (gclx_buy.bindcolval =="Y"){
		//발행구분이 정발행 매입의 경우 
		strURL = "./gczm_vender_popup22.jsp";
        strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrVAT,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			if(arrParam[6]=="10"){
	  			gcem_vendid.Format="###-##-#####";  
	  		}else if (arrParam[6]=="13"){
	  			gcem_vendid.Format="######-#######"; 		 
	  		}
			gcem_seq.text      = 0;  //순번  
			gcem_vendcd.text   = arrParam[0];  //거래처 코드  
			txt_vendnm.value   = arrParam[1];  //거래처명
			gcem_vendid.text   = arrParam[5];  //거래처 사업자 등록번호 
			gcem_vend_empnm.text = "";         //담당자성명           
			gcem_vend_email.text = "";         //Email    
			gcem_vd_direct.text  = arrParam[2]; //성명	
			
			if(arrParam[6]=="N"){
				arrParam[6] ="N-일반업체";					
			}else if(arrParam[6]=="Y"){
				arrParam[6] ="Y-협력업체";
			}else if(arrParam[6]=="S"){
				arrParam[6] ="S-특수관계업체";
			}else if(arrParam[6]=="T"){
				arrParam[6] ="T-간이과세업체";
			}else if(arrParam[6]=="M"){	
				arrParam[6] ="M-면세업체";
			}
			gcem_cocomyn.text = arrParam[6]; //업체구분
		}else{
			gcem_seq.text      = "";    //순번  
			gcem_vendcd.text   = "";    //거래처 코드  
			txt_vendnm.value   = "";    //거래처명
			gcem_vendid.text   = "";    //거래처 사업자 등록번호 
			gcem_vend_empnm.text = "";  //담당자성명           
			gcem_vend_email.text = "";  //Email    
			gcem_vd_direct.text  = "";  //성명
			gcem_cocomyn.text ="";
		}
		
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
	
	if(gcem_costcd.text==""){
	 arrParam[3]="";
	}else{
	 arrParam[3]=gcem_costcd.text;
	}
	
	strURL =  "./commdtil_cost_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);
	
	if (result != null) {
		arrResult = result.split(";");
		gcem_costcd.text =arrResult[0];
		txt_costnm.value = arrResult[1];
	}else{
		gcem_costcd.text="";
		txt_costnm.value="";
	}	
}	


/******************************************************************************
Description : 찾기 - 계정코드
******************************************************************************/
function ln_Atcode_Popup(){
	var strURL;
	var strPos;
	var arrParam = new Array();
	var result   = new Array();

	strURL = "./actcode_popup.jsp";
	arrParam[0]="ATUSEYN";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		gcem_atcode.text	=	arrResult[0];
		txt_atkornam.value	=	arrResult[1];
		txt_atdecr.value	=	arrResult[2];
	} else {
		gcem_atcode.text	="";
		txt_atkornam.value	="";
		txt_atdecr.value	="";
	}
}

/******************************************************************************
Description : 라디오 버튼 체크
              2009.12.04 jys 추가
******************************************************************************/
function ln_Rdo_Chk(param){

	if(param=="1"){
		rdo_gubun1_1.checked=true;
		rdo_gubun1_2.checked=false;
	}else if(param=="2"){
		rdo_gubun1_1.checked=false;
		rdo_gubun1_2.checked=true;
	}
}

/******************************************************************************
Description : 지점에 따른 계산서번호 구분값 변경
Param       : strFdcode - 지점( 01:본사, 02:서울, 03:금강산, 04:개성)   
              g_gb - 구분( A:매입 , B:매출)
******************************************************************************/
function ln_Taxnbr_Gb(strFdcode){

	if(strFdcode=="03"){ //금강산
		if(g_gb=="A"){
			return "E";
		}else if(g_gb=="B"){
	  		return "F"; 
		}
	}else if(strFdcode=="04"){ //개성
		if(g_gb=="A"){
		  	return "C";
		}else if(g_gb=="B"){
	  		return "D"; 
		}
	}else{ //서울
		if(g_gb=="A"){
	  		return "A";
		}else if(g_gb=="B"){
		  	return "B";
		}
	}
}

/******************************************************************************
Description : 신규등록[신용카드]
******************************************************************************/
function ln_CardPopup(){

	var strURL;
	var strPos;
	var arrParam = new Array();
	var result   = new Array();
	
	strURL = "./card_popup.jsp";
	strPos = "dialogWidth:450px;dialogHeight:420px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if (result != null) {
		arrResult = result.split(";");
		gcem_canbr.text	=	arrResult[0];
	} else {
		gcem_canbr.text	=	"";
	}
}

/***********************************************************************************************
Description : 매입[전표조회]
parameter   : fcod - 지점코드, fsdt - 전표일자, fnbr - 전표번호
**********************************************************************************************/
function ln_Slipno_Popup(){
	if(gcem_fsdat.text != "") {
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
	
		arrParam[0] = gclx_fdcode.bindcolval;
		arrParam[1] = gcem_fsdat.text;
		arrParam[2] = gcem_fsnbr.text;
	
		strURL = "./slipno_popup.jsp";
		strPos = "dialogWidth:890px;dialogHeight:595px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);
	}else{
		alert("발행 된 전표가 없습니다.");
	}
}


/******************************************************************************
Description : 매입
              과세구분으로 전자발행구분 자동 선택 
       2015.12.14 김효중 CJ 요청으로 매입계산서 면세도 전자발행으로 변경
******************************************************************************/
function ln_Taxknd_Chg(){
	if(gclx_taxknd.bindcolval=="1"||gclx_taxknd.bindcolval=="2"||gclx_taxknd.bindcolval=="3"||gclx_taxknd.bindcolval=="4"){
		ln_Rdo_Chk('1');
	}else if(gclx_taxknd.bindcolval=="7"||gclx_taxknd.bindcolval=="8"){
	    ln_Rdo_Chk('2');
	}
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
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_taxdtl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_return classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_empno_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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

<object  id=gctr_data3 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
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
<script language="javascript" for="gcds_taxmst" event="onloadCompleted(row,colid)">
	if (row<1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
		if(gcds_taxmst.namevalue(row,"GUBUN")=="1"){
			ln_Rdo_Chk('1');
		}else if(gcds_taxmst.namevalue(row,"GUBUN")=="2"){
		    ln_Rdo_Chk('2');
		}
	}
</script>

<script language="javascript" for="gcds_taxdtl" event="onloadCompleted(row,colid)">

	if (row<1) { 
		//alert("검색된 데이터가 없습니다.");
	}else{
		ln_Auto_Sum();
	}
	
</script>


<script language="javascript" for="gcds_empno_chk" event="onloadCompleted(row,colid)">
		ln_Authority_Result(row,colid);
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
		if(gclx_taxknd.bindcolval=="1"||gclx_taxknd.bindcolval=="4"){ //과세일 경우  //불공도 추가
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

<script language=JavaScript for=gclx_taxknd event=OnSelChange()>
	ln_Taxknd_Chg();
</script>
 
<script language=JavaScript for=gcem_erp_remark event=onKillFocus()>
	if(fn_trim(gcem_erp_remark.text)!=""){
		gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXPDTNAM") =gcem_erp_remark.text; 	
	}
</script>
  
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	 alert("작업이 성공적으로 완료되었습니다.");
	 //alert("BATCH_ID::"+gcds_return.namevalue(gcds_return.rowposition,"BATCH_ID"));
	 //alert("ID::"+gcds_return.namevalue(gcds_return.rowposition,"ID"));
	 //alert("PASS::"+gcds_return.namevalue(gcds_return.rowposition,"PASS"));
	 gcem_taxnbr_s.text = gcds_return.namevalue(gcds_return.rowposition,"TAXNBR"); //구분자 포함.
	
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

<script language=JavaScript for=gctr_data3 event=OnSuccess()>
	 alert("작업이 성공적으로 완료되었습니다.");
	 gcem_taxnbr_s.text = gcds_return.namevalue(gcds_return.rowposition,"TAXNBR"); //구분자 포함.
	 ln_Query();
	
</script>

<script language=JavaScript for=gctr_data3 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data3.ErrorCode + "\n" + "Error Message : " + gctr_data3.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>


<!-- 매입등록 ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="3px" colspan=2><td></tr>
	<tr>
		<td align=left style="position:relative;left:6px;top:-2px" colspan=2>
			<table cellpadding="0" cellspacing="0" border="0" style='width:950px;height:20px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:90px;" bgcolor="#eeeeee"><nobr>계산서번호</nobr></td>
					<td class="tab23" width ="100px">
						<comment id="__NSID__">
						<object id=gcem_taxnbr_s  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px;width:80px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="#000000-0000">
							<param name=PromptChar	  value="_">
							<param name=UpperFlag     value=1>
							
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td align="right">&nbsp;<nobr>      
						<img src="../../Common/img/btn/com_b_taxselect.gif"  style="cursor:hand;position:relative;top:0px;right:2px" onclick="ln_Slipno_Popup()">
						<img src="../../Common/img/btn/com_b_delete.gif"	 style="cursor:hand;position:relative;top:0px;right:2px" onclick="ln_Delete()">
						<img src="../../Common/img/btn/com_b_insert.gif"	 style="cursor:hand;position:relative;top:0px;right:2px" onclick="ln_Add()">
						<img src="../../Common/img/btn/com_b_save.gif"		 style="cursor:hand;position:relative;top:0px;right:2px" onclick="ln_Save()">
						<img src="../../Common/img/btn/com_b_query.gif"	     style="cursor:hand;position:relative;top:0px;right:2px" onClick="ln_Query()"> 
					 </nobr>
					</td>
				</tr>
			</table>
		</td>
	</tr>

	<tr>
		<td height="30px" colspan=2>
			<b><font size="2" color="blue">&nbsp;◎ 매입정보(ERP)</font></b>
		<td>
	</tr>
	<tr><!-- ERP정보----------------------------------------------------------------------------------------->
	   	<td style="position:relative;left:6px" colspan=2>
			<table cellpadding="1" cellspacing="0" border="0" style='width:950px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab11" width="90px" bgcolor="#eeeeee"><nobr>지점</nobr></td>
					<td class="tab21" width="100px">
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
					<td class="tab11" width="70px" bgcolor="#eeeeee"><nobr>사&nbsp;업&nbsp;장</nobr></td>
					<td class="tab22" width="220px">
					    <comment id="__NSID__"> 
							<object  id=gclx_cocode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:2px;font-size:12px;width:60px;height:200px;">
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
							<object  id=gcem_b_bizplace classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:35px;height:20px;position:relative;left:5px;top:2px">		
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
					<td class="tab33" width="70px" bgcolor="#eeeeee"><nobr>담당부서</nobr></td>
					<td class="tab19" width="140px;">
						<comment id="__NSID__"> 
							<object  id=gcem_deptnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:105px;height:20px;position:relative;left:5px;top:0px">		
								<param name=Text		        value="">
								<param name=Alignment           value=0>
								<param name=border              value=false>
								<param name=GeneralEdit         value=true>
								<param name=ReadOnly            value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
							<object  id=gcem_deptcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:10px;height:20px;position:relative;left:0px;top:2px">		
								<param name=Text		        value="">
								<param name=Alignment           value=0>
								<param name=border              value=false>
								<param name=GeneralEdit         value=true>
								<param name=Visible             value=false>	
								<param name=ReadOnly            value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script>
						 
					</td>
					<td class="tab11" width="70px" bgcolor="#eeeeee"><nobr>담당자</nobr></td>
					<td class="tab22" >
						 <comment id="__NSID__"> 
							<object  id=gcem_empnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:105px;height:20px;position:relative;left:5px;top:0px;">		
								<param name=Text		  value="">
								<param name=Alignment           value=0>
								<param name=border              value=false>
								<param name=GeneralEdit         value=true>
								<param name=ReadOnly            value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
							<object  id=gcem_empno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:10px;height:20px;position:relative;left:0px;top:2px">		
								<param name=Text		        value="">
								<param name=Alignment           value=0>
								<param name=border              value=false>
								<param name=GeneralEdit         value=true>
								<param name=Visible             value=false>	
								<param name=ReadOnly            value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>	
				</tr>
				<tr>
					<td class="tab11" width="90px" bgcolor="#eeeeee"><nobr>계산서일자</nobr></td>
					<td class="tab21" width="100px"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_taxdat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;left:5px;top:2px;width:70px;height:20px;" class="txtbox">
									<param name=Alignment	  value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable		  value="true">
							</object>
						</comment><script>__ws__(__NSID__);</script>&nbsp;
					    <img src="../img/calender.gif" value="calender.gif" id=img_calendar1  OnClick="ln_GetCallCalendar('gcem_taxdat', 'Text')" style="position:relative;width:20px;left:3px;top:2px;cursor:hand;">
					    </nobr>
					</td>
					<td class="tab11" width="70px" bgcolor="#eeeeee"><nobr>발행구분</nobr></td>
					<td class="tab22" width="220px">
					   <comment id="__NSID__">
							<object  id=gclx_buy classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:1px;font-size:12px;width:90px;height:100px;">
								<param name=CBData				value="Y^정발행매입,N^역발행매입">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=ListExprFormat	    value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
							</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab33" width="70px" bgcolor="#eeeeee"><nobr>과세구분</nobr></td><!-- =부가세종류 -->
					<td class="tab19" width="115px;">
						<comment id="__NSID__">
							<object  id=gclx_taxknd  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:150px;">
								<param name=ComboDataID			value="gcds_taxknd">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=ListExprFormat		value="CDNAM^0^100">
								<param name=BindColumn			value="CDCODE">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
					</td>
					<td class="tab11" width="70px" bgcolor="#eeeeee"><nobr>귀속구분</nobr></td>
					<td class="tab22" >
						<comment id="__NSID__">
							<object  id=gclx_taxdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:0px;font-size:12px;width:110px;height:200px;">
								<param name=ComboDataID			value="gcds_taxdiv">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=ListExprFormat	    value="CDNAM^0^110">
								<param name=BindColumn			value="CDCODE">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
					</td>	
				</tr>
				<tr>
					<td class="tab11" width="90px" bgcolor="#eeeeee"><nobr><input type="checkbox"  name='v_chk_vend'  id='v_chk_vend'  style="width:20px;" >거래처</nobr></td>
					<td class="tab22" width="860px;" colspan="7" ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_vendcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:3px;left:5px;width:90px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="#############">
								<param name=PromptChar	    value="_">
								<param name=ReadOnly        value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script>&nbsp;
						<img name="btn_find2" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:-2px;cursor:hand"	 onclick="ln_Vend_Popup()">
						<input id=txt_vendnm type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:362px;height:18px" readOnly>
						<comment id="__NSID__">
							<object  id=gcem_vendid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:3px;left:5px;width:115px;">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="###-##-#####">
								<param name=PromptChar	value="_">
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>&nbsp;&nbsp;
							<object  id=gcem_cocomyn classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:3px;left:0px;width:120px;">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=GeneralEdit     value=true>
								<param name=ReadOnly        value=true>
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
					<td class="tab11" width="90px" bgcolor="#eeeeee"><nobr>거래처담당정보</nobr></td>
					<td class="tab21" width="100px" ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_vend_empnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:5px;top:0px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>&nbsp;
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td class="tab11" width="70px" bgcolor="#eeeeee"><nobr>담당Email</nobr></td>
					<td class="tab21"  colspan=3  >
						<comment id="__NSID__">
							<object  id=gcem_vend_email classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:405px;height:20px;position:relative;left:5px;top:0px">		
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
					<td class="tab11" width="70px" bgcolor="#eeeeee"><nobr>대표자명</nobr></td>
					<td class="tab22"    >
						<comment id="__NSID__">
							<object  id=gcem_vd_direct classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:5px;top:0px">		
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
					<td class="tab11" width="90px" bgcolor="#eeeeee"><nobr>적요</nobr></td>
					<td class="tab21" width="400px" colspan=3>
						<comment id="__NSID__">
							<object  id=gcem_erp_remark classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:399px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=GeneralEdit   value=true>
								<param name=Language	  value=1>
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td class="tab11" width="70px" bgcolor="#eeeeee"><nobr>전표접수번호</nobr></td>
					<td class="tab21" >
					    <comment id="__NSID__"> 
							<object  id=gcem_fsdat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:2px;width:63px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=ClipMode		value=true>
								<param name=Numeric			value=false>
								<param name=Format			value="#########">
								<param name=PromptChar	    value="_">
								<param name=Enable			value="false">
							</object>&nbsp;-
							<object  id=gcem_fsnbr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:3px;top:2px;width:45px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=ClipMode		value=true>
								<param name=Numeric			value=false>
								<param name=Format			value="######">
								<param name=PromptChar	    value="_">
								<param name=Enable			value="false">
							</object></comment>
						<script>__ws__(__NSID__);</script> 
					</td>	
					<td class="tab11" width="70px" bgcolor="#eeeeee"><nobr>전표상태</nobr></td>
					<td class="tab22" >
						 <comment id="__NSID__">
							<object  id=gclx_fsstat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;font-size:12px;width:110px;height:100px;">
								<param name=CBData			    value="Y^결재완료,R^결재요청,N^결재대기,C^결재취소,B^반송">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=Enable				value="false">
								<param name=ListExprFormat	    value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
							</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>	
				</tr>
				<tr>
					<td class="tab11" width="90px" bgcolor="#eeeeee"><nobr><input type="checkbox"  name='v_chk_account'  id='v_chk_account'  style="width:20px;" >상대계정</nobr></td>
					<td class="tab21" width="400px" colspan=3><nobr>
						<comment id="__NSID__">
							<object id=gcem_atcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:50px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="#######">
								<param name=PromptChar	    value="_">
								<param name=Enable			value="false">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:7px;cursor:hand"	 onclick="ln_Atcode_Popup()">
						<input id=txt_atkornam type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:302px;height:18px" readOnly = true>
						<input id=txt_atdecr type="text" class="txt11" style="position:relative;left:5px;width:70px;display:none"></nobr> 
					</td>
					<td class="tab11" width="70px" bgcolor="#eeeeee"><nobr>전자발행구분</nobr></td>
					<td class="tab21"  >						
            			<INPUT type="radio" id=rdo_gubun1_1 value="1" onclick="ln_Rdo_Chk('1')">전자
					    <INPUT type="radio" id=rdo_gubun1_2 value="2" onclick="ln_Rdo_Chk('2')">수기				
					</td>
					<td class="tab11" width="70px" bgcolor="#eeeeee"><nobr>eBill구분</nobr></td>
					<td class="tab22" >
						 <comment id="__NSID__">
							<object  id=gclx_ebillgb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;font-size:12px;width:110px;height:100px;">
								<param name=CBData			    value="1^스마트빌,2^트러스빌,3^기타">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=Enable				value="true">
								<param name=ListExprFormat	    value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
							</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>	
				</tr>
				<tr>
					<td class="tab11" width="90px" bgcolor="#eeeeee"><nobr><input type="checkbox"  name='v_chk_cost'  id='v_chk_cost'  style="width:20px;" >원가</nobr></td>
					<td class="tab22" colspan=7>
					<nobr>
						<comment id="__NSID__">
							<object id=gcem_costcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:3px;left:5px;width:50px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="######">
								<param name=PromptChar	    value="_">
								<param name=Enable			value="false">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
						
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="원가코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:3px" align=center onclick="ln_Costcd_Popup();">				
						<input id="txt_costnm" type="text" class="txtbox"  style= "position:relative;left:5px;top:-4px;width:302px;height:18px;" maxlength="36"  readOnly = true>			
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font color="blue" >* 원가 미존재시 [판매관리비 등]으로 입력하세요.</font>
						</nobr>
					</td>
				</tr>
				<tr>
					<td class="tab11" width="90px" bgcolor="#eeeeee"><nobr>신용카드</nobr></td>
					<td class="tab22" colspan=7>
					<nobr>
						<comment id="__NSID__">
						<object  id=gcem_canbr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:5px;top:3px">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Numeric       value=false>
							<param name=Format        value="####-####-####-####">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=ReadOnly      value=true>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
						</object>
						</comment><script>__ws__(__NSID__);</script> 
						<img name="btn_find3" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:7px;cursor:hand"	onclick="ln_CardPopup()">
					</nobr>
					</td>
				</tr>
				<tr>
					<td class="tab11" width="90px" bgcolor="#eeeeee"><nobr>공급가액</nobr></td>
					<td class="tab22" width="140px" ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_sup_amount classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=2>
								<param name=Border        value=false>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td class="tab33" width="70px" bgcolor="#eeeeee"><nobr>부가세액</nobr></td>
					<td class="tab22"  ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_tax_amount classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=2>
								<param name=Border        value=false>
								<param name=Language	  value=1>
								<param name=ReadOnly      value=true>
								<param name=ReadOnlyBackColor   value="#CCFFCC">
							</object>
						</comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td class="tab33" width="70px" bgcolor="#eeeeee"><nobr>합계</nobr></td>
					<td class="tab22"  colspan=3 ><nobr>
						<comment id="__NSID__">
							<object  id=gcem_total_amount classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:5px;top:1px">		
								<param name=Text		  value="">
								<param name=Alignment     value=2>
								<param name=Border        value=false>
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
		<td height="30px" colspan=2 >
			<b><font size="2" color="blue">&nbsp;◎ 세부내역 </font></b>
		<td>
	</tr>
    <tr>
		<td style="cursor:hand;position:relative;left:6px;" width="845px" colspan=2><nobr>
		 	<comment id="__NSID__">
		  		<object id=gcgd_taxdtl classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" width='950px' height='41px' border='1'>
					<param name="dataid"		 value="gcds_taxdtl">
					<param name="borderstyle"    value="0">
					<param name="indwidth"       value="0">
					<param name="fillarea"		 value="true">
					<param name="colsizing"      value="true">
					<param name="editable"       value="true">
					<param name="format"		 value="  
					<C>  Name='월일'			ID=MMDD                Width=80 	align=center   bgcolor=#CCFFCC  mask='XX/XX' edit=none </C>
					<C>  Name='품목'         ID=TAXPDTNAM           Width=320 	align=left     bgcolor=yellow </C>			
					<C>  Name='규격'         ID=TAXSTD          	   Width=100	align=left     bgcolor=#CCFFCC edit=none </C>			  					
					<C>  Name='수량'		    ID=TAXQTY          	   Width=30 	align=right    bgcolor=#CCFFCC edit=none </C>
					<C>  Name='단가'         ID=TAXPRIC             Width=100	align=right	   bgcolor=#CCFFCC edit=none </C>					
					<C>  Name='공급가액'      ID=TAXSUM              Width=100  	align=right	   bgcolor=yellow </C>					
					<C>  Name='부가세액'      ID=TAXVATAMT           Width=100	align=right	   bgcolor=yellow </C>
					<C>  Name='합계'         ID=TAXTOT              Width=100	align=right	   bgcolor=#CCFFCC edit=none </C>							
				  	 ">
				</object>
			</comment><script>__ws__(__NSID__);</script></nobr>
		<td>			   
     </tr>	
</table> 
			 

<!-----------------------------------------------------------------------------
			B I N D  D E F I N I T I O N   -  매 입
------------------------------------------------------------------------------>
<comment id="__NSID__">
    <object  id=gcbn_data classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"		VALUE="gcds_taxmst">
	<PARAM NAME="ActiveBind"	VALUE="true">
	<PARAM NAME="BindInfo"		VALUE="
	<C>Col=COCODE     		Ctrl=gclx_cocode    		Param=bindcolval </C>
	<C>Col=DEPTCD     		Ctrl=gcem_deptcd    		Param=text       </C>
	<C>Col=EMPNO      		Ctrl=gcem_empno     		Param=text       </C>
	<C>Col=TAXDIV     		Ctrl=gclx_taxdiv    		Param=bindcolval </C>
	<C>Col=TAXKND     		Ctrl=gclx_taxknd    		Param=bindcolval </C>
	<C>Col=VEND_CD    		Ctrl=gcem_vendcd    		Param=text       </C>
	<C>Col=VEND_ID    		Ctrl=gcem_vendid    		Param=text       </C>
	<C>Col=VEND_NM    		Ctrl=txt_vendnm     		Param=value      </C>
	<C>Col=TAXDAT     		Ctrl=gcem_taxdat    		Param=text       </C>
	<C>Col=REMARK     		Ctrl=gcem_erp_remark		Param=text       </C>
	<C>Col=TAXCDNBR   		Ctrl=gcem_canbr     		Param=text       </C>
	<C>Col=ATCODE     		Ctrl=gcem_atcode    		Param=text       </C>
	<C>Col=ATKORNAM   		Ctrl=txt_atkornam   		Param=value      </C>
	<C>Col=ATDECR     		Ctrl=txt_atdecr     		Param=value      </C>
	<C>Col=FSDAT      		Ctrl=gcem_fsdat     		Param=text       </C>
	<C>Col=FSNBR      		Ctrl=gcem_fsnbr     		Param=text       </C>
	<C>Col=FDCODE     		Ctrl=gclx_fdcode    		Param=bindcolval </C>
	<C>Col=SEQ        		Ctrl=gcem_seq       		Param=text       </C>
	<C>Col=B_BIZPLACE 		Ctrl=gcem_b_bizplace		Param=text       </C>
	<C>Col=VD_DIRECT  		Ctrl=gcem_vd_direct 		Param=text       </C>
	<C>Col=FSSTAT     		Ctrl=gclx_fsstat    		Param=bindcolval </C>
	<C>Col=DEPTNM     		Ctrl=gcem_deptnm    		Param=text       </C>
	<C>Col=EMPNMK      		Ctrl=gcem_empnm     		Param=text       </C>
	<C>Col=COSTCD     		Ctrl=gcem_costcd    		Param=text       </C>
	<C>Col=COSTNM     		Ctrl=txt_costnm     		Param=value      </C>
	<C>Col=EMPNM    		Ctrl=gcem_vend_empnm     	Param=text       </C>
	<C>Col=EMAIL     		Ctrl=gcem_vend_email     	Param=text       </C>
	<C>Col=EBILLGB     		Ctrl=gclx_ebillgb        	Param=bindcolval </C>
	">
	</object>
	
</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 