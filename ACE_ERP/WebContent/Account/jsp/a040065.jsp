<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	회계관리/매출관리(전자세금계산서)
+ 프로그램 ID	: A040065.html
+ 기 능 정 의	: 정발행매출(전자세금계산서)
+ 최 초 이 력	: 정영식
+ 변 경 이 력	:  
-----------------------------------------------------------------------------
+ 수 정 내 용     :	수정세금계산서 코드 추가 
+ 수   정  자      : JYS
+ 수 정 일 자     : 20096.12.07
-----------------------------------------------------------------------------
+ 수 정 내 용     :	비고 추가
+ 수   정  자      : JYS
+ 수 정 일 자     : 2010.12.01
-----------------------------------------------------------------------------
+ 수 정 내 용     : 결재상태 승인 건에 대하여 매출발행 가능하게 함.  
+ 수   정  자      : J Y S
+ 수 정 일 자     : 2017.06.27 
+ 서 블 릿 명	:
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a040065_s2 , 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>매출관리</title>

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
 
var gs_gubun="";
var gs_status="";
var gs_signal="";
var gs_sm_call_status=""; // 호출 asp 구분
var gs_conversation_id="";

var gs_empnos="";
var gs_deptcds="";



/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


    //&&
	//newWin=window.open('inform.html','child','width=350,height=230,top=310,left=350');

	gclx_cocode.index=2;
	gclx_amend_code.index=0;
	//ln_Find_Regno();
	//ln_Query(gcem_regno.text);
  	ln_Before();

    //gcem_frdt.text="20090801";
	//gcem_todt.text="20090831";

	gclx_fdcode.index=1;
	gclx_supbuy.index=0;
	gclx_status.index=0;

	gcem_frdt.text=ln_Load_Date('s');
  	gcem_todt.text=ln_Load_Date('c');

	//gclx_status.style.color="#FF0000";
	//gclx_status.style.background="#FFFFCC";
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
	//지점코드
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

	ln_Authority();
}

/******************************************************************************
	Description : 권한조회
******************************************************************************/
function ln_Authority(){
	
	//login자와 부가세 관리자확인---------------------------------------------------------
	gcds_login.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0901&v_str2="+gusrid;
	gcds_login.Reset();

	if( gcds_login.countrow>0){
		hid_login.value="M";
		gs_empnos="";
		gs_deptcds="";
	}else{
		hid_login.value="";	
	
		//로그인자의 권한.-----------------------------------------------------------------------
		gcds_right.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0902&v_str3="+gusrid;
		//prompt(this,gcds_right.DataID);
		gcds_right.Reset();

		for(i=1;i<=gcds_right.countrow;i++){
			if(gcds_right.namevalue(i,"CDREMARK")!=""){   // 개인별권한 가져옴.empno
				gs_empnos=gs_empnos+gcds_right.namevalue(i,"CDREMARK")+"','";
			}else if(gcds_right.namevalue(i,"GBCD")!=""){ // 부서별권한 가져옴.deptcd
				gs_deptcds=gs_deptcds+gcds_right.namevalue(i,"GBCD")+"','"; 
			}
		}

		//맨마지막에 콤마를 떼어난다.
		if(gs_empnos.length>1){
			gs_empnos = gs_empnos.substring(0,gs_empnos.length-3);
		}

		if(gs_deptcds.length>1){
			gs_deptcds = gs_deptcds.substring(0,gs_deptcds.length-3);
		}
		//------------------------------------------------------------------------------------
	} 
}


/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

  var strregno ="";
	var strbizplace="";

	if(gclx_cocode.bindcolval=="02"){        //서울
		strregno = gs_regno_s;
		strbizplace ="0001";
	}else if (gclx_cocode.bindcolval=="01"){ //고성
		strregno = gs_regno_g;
		strbizplace="";
    }else if (gclx_cocode.bindcolval=="03"){ //양양
		strregno = gs_regno_g;
		strbizplace="0002";
    }else if (gclx_cocode.bindcolval=="04"){ //홍성
		strregno = gs_regno_g;
		strbizplace="0003";	
	}
	/**&&
    gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040065_s2?v_str1="+gclx_fdcode.bindcolval   //지점                
	                                                      +"&v_str2="+strregno              	 //사업소              
																												+"&v_str3="+gcem_frdt.text					 //계산서기간 from     
																												+"&v_str4="+gcem_todt.text					 //계산서기간 to       
																												+"&v_str5="+gcem_regno.text					 //사업자등록번호      
																												+"&v_str6="+gcem_vendnm.text				 //거래처명            
																												+"&v_str7="+gcem_vendcd.text				 //거래처코드    ( 삭제 )      
																												+"&v_str8="+gclx_supbuy.bindcolval	 //발행구분
																												+"&v_str9="+gclx_status.bindcolval	 //상태
																												+"&v_str10="+gusrid 	               //id
																												+"&v_str11="+gs_empnos	             //참조가능한 사번     
																												+"&v_str12="+gs_deptcds	             //참조가능한 부서
																												+"&v_str13="+hid_login.value;	       //관리자구분		
	**/
	
  gcem_frdt.ClipMode="true";
																												
  if (gcem_frdt.text.substring(0,4)==""){
	  gcem_frdt.ClipMode="false";
	  return false;
  }else{
	  gcem_frdt.ClipMode="false";
  }																											
																												
  gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040065_s2_ee?v_str1="+gclx_fdcode.bindcolval     //지점                
                                                                        +"&v_str2="+strregno              	    //사업소              
																		+"&v_str3="+gcem_frdt.text				//계산서기간 from     
																		+"&v_str4="+gcem_todt.text				//계산서기간 to       
																		+"&v_str5="+gcem_regno.text				//사업자등록번호      
																		+"&v_str6="+gcem_vendnm.text			//거래처명            
																		+"&v_str7="+gcem_vendcd.text			//거래처코드    ( 삭제 )      
																		+"&v_str8="+gclx_supbuy.bindcolval	    //발행구분
																		+"&v_str9="+gclx_status.bindcolval	    //상태
																		+"&v_str10="+gusrid 	                //id
																		+"&v_str11="+gs_empnos	                //참조가능한 사번     
																		+"&v_str12="+gs_deptcds	                //참조가능한 부서
																		+"&v_str13="+hid_login.value	        //관리자구분		
																		+"&v_str14="+gclx_amend_code.bindcolval //수정코드	
																		+"&v_str15="+strbizplace                //종사업장번호
																		+"&v_str16="+gclx_taxsts.bindcolval;    //결재상태  
	prompt("",gcds_data.DataID);
  gcds_data.Reset();
  
  //alert( "countrow::"+gcds_data.countrow);

}

/******************************************************************************
	Description : 정매출 발행
	데이터를 XXSB_DTI_MAIN, XXSB_DTI_ITEM, XXSB_DTI_STATUS에 INSERT 해야함.
******************************************************************************/
function ln_Save(){
  /*

  if (gcds_data.IsUpdated) {
		if (confirm("발행 하시겠습니까?")){	
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040060_t1"

			gctr_data.Parameters = "v_str1=1018510695,v_str2="+gusrid;

			prompt('',gcds_data.text);
			gctr_data.post();
		}	
	}
  */

 /*
  if(!ln_Chk()) return;
  
  var v_left = (screen.width-300)/2;
  var v_top  = (screen.height-300)/2;
  //var v_left = screen.availWidth/2 - 300/2; 
  //var v_top  = screen.availHeight/2 - 300/2;            

	
	if(gcds_data.namevalue(1,"CHK")=="T"){        //서울인 경우
		url=gs_url+"/callSB/XXSB_DTI_CERT.asp?CERT_REGNO="+gs_regno_s+"&CERT_COMNAME="+gs_comname_s;		
	}else if(gcds_data.namevalue(2,"CHK")=="T"){  //고성인 경우
		url=gs_url+"/callSB/XXSB_DTI_CERT.asp?CERT_REGNO="+gs_regno_g+"&CERT_COMNAME="+gs_comname_g;	
	}

  window.open(url,"", "status=1, width=300, height=280, left="+v_left+", top="+v_top );
	*/
}

/******************************************************************************
	Description : 사업소 코드로 사업자등록번호 찾기 
******************************************************************************/
function ln_Find_Regno(){
  /*
	if(gclx_cocode.bindcolval=="01"){
		gcem_regno.text =gs_regno_g;
	}else if(gclx_cocode.bindcolval=="02"){
    gcem_regno.text =gs_regno_s;
	}else{
    gcem_regno.text ="";
	}
	*/
}

/******************************************************************************
	Description : 매출발행 체크 ( 세금계산서 작성일자 > 전자세금계산서 발행일자 ) 체크함
******************************************************************************/
function ln_Chk(){
  var strDti_wdate="";
  for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
  	 		strDti_wdate = gcds_data.namevalue(i,"DTI_WDATE");
			if(strDti_wdate>gcurdate){
				alert("세금계산서 작성일자가 발행일자보다 큽니다. 확인 하십시요.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"TAXSTS")!="Y"){
				alert("결재상태가 승인완료 건만 매출발행 가능합니다. 확인 하십시요.");
				return false;
			}
			
  		}
	}

return true;
  /*
	var intcnt = 0; 

  //인증서 선택이 한 것도 안 된경우
  for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			intcnt+=1;
		}
	}
	
  if (intcnt==0){
		alert("해당 사업자 번호를 선택하십시요.");
		return false;
	}else if(intcnt==1){
    return true;
	}else if(intcnt==2){
		alert("사업자 번호를 1건만 선택하십시요.");
		return false;
	}else{
    alert("기타");
    return false;
	}
	*/
}
/******************************************************************************
	Description : 찾기 - 거래처코드
******************************************************************************/
function ln_Popup(){
    	var arrVAT	= new Array(); 
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		arrVAT[0]="VAT";

		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrVAT,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_vendcd.text  = arrParam[0];
			gcem_vendnm.text	= arrParam[1];
			gcem_regno.text	= arrParam[5];
		} else {
			gcem_vendcd.text	= "";
			gcem_vendnm.text	= "";
			gcem_regno.text="";
		}
}


/******************************************************************************
	Description : 매출발행 
	parameter   : strStatus  - 변경할 상태코드           
	              strSignal  - signal
                strBtnname - 버튼명칭
  정발행 매출을 정상적으로 했지만 네트워크 오류로 호출페이지 호출 못할 경우 STATUS ='S' 인건을 조회한 후 재 발행함.
******************************************************************************/
function ln_Issue(strStatus,strSignal,strBtnname){

  	if(!ln_Chk()) return;
 
	if (gcds_data.IsUpdated) {
		if (confirm(strBtnname+" 하시겠습니까?")){	
			gs_sm_call_status="I";
		    ln_Batch_id();
		}
	}
}


/******************************************************************************
	Description : 역매출발행
	parameter   : strStatus  - 변경할 상태코드           
	              strSignal  - signal
                strBtnname - 버튼명칭
  역매출 발행 일경우 ==> ATTAXMST 와 ATTAXDTL에 데이터를 저장해야함.
******************************************************************************/
function ln_SaleIssue(strStatus,strSignal,strBtnname){

	var rowcnt=0;
	gs_conversation_id="";

	//체크 - 건별로만 역발행 매출 가능함.
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			rowcnt+=1;
			gs_conversation_id = gcds_data.namevalue(i,"CONVERSATION_ID");
		}
	}

	if(rowcnt>1){
		alert("역발행 매출의 경우 1건씩 가능합니다.");
		return;
	}

	var strregno ="";
  	if(gclx_cocode.bindcolval=="02") strregno = gs_regno_s;
	else if (gclx_cocode.bindcolval=="01") strregno = gs_regno_g;
	else if (gclx_cocode.bindcolval=="03") strregno = gs_regno_g;
	else if (gclx_cocode.bindcolval=="04") strregno = gs_regno_g;
  	
  	if(strregno==""){
  		
  		strregno="2218113834";
  		//alert("해당 사업장을 선택하십시요.");  
  		//return;
  	}
	//체크 ....
	//역매출시 거래 이메일이 등록되어 있지 않으면...발행 안됨.

	//해당 역발행이 존재할 경우 ( 역발행매출 발행을 했는데, 아산 db에는 생성이 되었는데, 스마트빌 asp 페이지 호출을 못할 경우 )
	
	// ==> 이 경우는 어떻게 처리할까? 1. 데이터 생성할 때 미리 체크하여 존재하면 update를 친다.
	//                                2. 데이터 생성할 때 미리 체크하여 존재하면 delete 후 insert를 친다.
	//                                3. 저장전 다른 서블릿으로 체크해본다. ( 건별 처리라서 가능할 것 같음.)  

	if(!ln_Chk()) return;
 
	if (gcds_data.IsUpdated) {
		if (confirm(strBtnname+" 하시겠습니까?")){	
		    gs_sm_call_status="R";
			gctr_data.KeyValue = "a040065_t3_ee(I:USER=gcds_data,O:USER2=gcds_return)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040065_t3_ee"
			gctr_data.Parameters = "v_str1="+gusrid+",v_str2="+strregno;
			gctr_data.post();
		}
	}
}

/******************************************************************************
	Description : 상태코드 변경
	parameter   : strStatus - 변경할 상태코드           
	              strSignal - signal
                strBtnname - 버튼명칭
******************************************************************************/
function ln_Status(strStatus,strSignal,strBtnname){
    var strTitle="";
	gs_status="";
	gs_signal="";

	gs_sm_call_status="S";   //상태변경

    if(strSignal=="CANCELALL"){ // 발행취소
		strTitle="발행취소 사유";
    }else if(strSignal=="CANCELISSUE"){ //발행취소요청
		strTitle="발행취소요청 사유";
    }else if(strSignal=="REQREJECTR"){ //발행취소거부
    	strTitle="발행취소거부 사유";
	}else if(strSignal=="RIREJECT"){   //역발행거부
    	strTitle="역발행거부 사유";
	}

	if (gcds_data.IsUpdated) {
		if (confirm(strBtnname+" 하시겠습니까?")){	
			if(strTitle!=""){
				if(!ln_Reason_Popup(strSignal,strTitle)) return; 
			}
			gs_status = strStatus; 
			gs_signal = strSignal;

			//BATCH_ID 생성하여 XXSB_DTI_MAIN에 UPDATE하고  
			//UPDATE 된 BATCH_ID를 XXSB_DTI_STATUS_CHANGE.asp에 넘김(데이터셋으로 리턴 ) 
			ln_Batch_id();
		}
	}//IsUpdated

}

/******************************************************************************
	Description : 사유입력
	parameter   :            
******************************************************************************/
function ln_Reason_Popup(strSignal,strTitle){
		var arrResult	= new Array();
		var arrParam	= new Array();
		var strURL;	
		var strPos;

		hid_sbdescription.value= "";

		arrParam[0] = strTitle;

		strURL = "./a040065_popup.jsp";
		strPos = "dialogWidth:350px;dialogHeight:140px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			hid_sbdescription.value  = arrParam[0];	
			return true;
		} else {
			hid_sbdescription.value= "";
			return false;
		}

		//alert("hid_sbdescription.value ::"+hid_sbdescription.value );
}

/******************************************************************************
	Description : Interface_Batch_id 생성 및 사번으로 id, pw 찾기
	parameter   :            
******************************************************************************/
function ln_Batch_id(){      

    var strregno ="2218113834";
    if(gclx_cocode.bindcolval=="02") strregno = gs_regno_s;
	else if (gclx_cocode.bindcolval=="01") strregno = gs_regno_g;
	else if (gclx_cocode.bindcolval=="03") strregno = gs_regno_g;
	else if (gclx_cocode.bindcolval=="04") strregno = gs_regno_g;
    
    //alert("strregno"+strregno+"gusrid"+gusrid);
  
    gctr_data.KeyValue = "a040065_t1(I:USER=gcds_data,O:USER2=gcds_return)";
	gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040065_t1"
	gctr_data.Parameters = "v_str1="+gusrid+",v_str2="+strregno;
		
	//prompt('gcds_data',gcds_data.text);

	gctr_data.post();
}


/******************************************************************************
	Description : 사번으로 id, pw 찾기
	parameter   :            
******************************************************************************/
function ln_ID_PW_Find(){
    var strregno ="2218113834";
    if(gclx_cocode.bindcolval=="02") strregno = gs_regno_s;
	else if (gclx_cocode.bindcolval=="01") strregno = gs_regno_g;
	else if (gclx_cocode.bindcolval=="03") strregno = gs_regno_g;
	else if (gclx_cocode.bindcolval=="04") strregno = gs_regno_g;
		
	gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040065_t2"
	gctr_data2.Parameters = "v_str1="+gusrid+",v_str2="+strregno;
	//prompt('gcds_data',gcds_data.text);
	gctr_data2.post();
}

/******************************************************************************
	Description : DataSet Header 설정
	parameter   :            
******************************************************************************/
function ln_SetDataHeader(){
 
    gcds_temp.clearAll();
   
	if (gcds_temp.countrow<1){
		var s_temp = "TEMPC:STRING";							 
		gcds_temp.SetDataHeader(s_temp);
	}
   
	gcds_temp.Addrow();
	gcds_temp.namevalue(gcds_temp.rowposition,"TEMPC")="A";
}


/******************************************************************************
	Description : 세금계산서 보기
	parameter   :            
******************************************************************************/
function ln_Bill_View(){

	if (gcds_data.IsUpdated){
		gs_sm_call_status="V"; // 계산서보기 tag
		ln_Batch_id();
	}
}



/******************************************************************************
	Description : Email 재발송
	parameter   :            
******************************************************************************/
function ln_Email(){

	var rowcnt=0;
	var strByrEmail="";
	gs_conversation_id="";

	//체크 - 건별로만 메일 발송가능함.
	for(i=1;i<=gcds_data.countrow;i++){
	  //alert("i:::"+i+"::CONVERSATION_ID::"+gcds_data.namevalue(i,"CONVERSATION_ID")+":CHK:"+gcds_data.namevalue(i,"CHK"));
		if(gcds_data.namevalue(i,"CHK")=="T"){
			rowcnt+=1;
			gs_conversation_id = gcds_data.namevalue(i,"CONVERSATION_ID");
			strByrEmail = gcds_data.namevalue(i,"BYR_EMAIL");
		}
	}

	if(rowcnt>1){
		alert("이메일 재발송은 1건씩 가능합니다.");
		return;
	}

	//메일 입력 팝업
	if (gcds_data.IsUpdated){
		//true false 적용
		if(!ln_Mail_Popup('메일입력', strByrEmail)) return;
			gs_sm_call_status="E"; // Email 재발송
			ln_SetDataHeader();
			ln_ID_PW_Find();
	}
}


/******************************************************************************
	Description : 재발송 Email 입력 팝업
	parameter   :            
******************************************************************************/
function ln_Mail_Popup(strTitle, strByrEmail){
	  	var arrResult	= new Array();
		var arrParam	= new Array();
		var strURL="";	
		var strPos="";;

		hid_email.value= "";

		arrParam[0] = strTitle;
		arrParam[1] = strByrEmail;
		
		strURL = "./a040065_email_popup.jsp";
		strPos = "dialogWidth:350px;dialogHeight:140px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			hid_email.value  = arrParam[0];	
			return true;
		} else {
			hid_email.value= "";
			return false;
		}
	//	alert("::::hid_email::::"+hid_email.value);
}


/******************************************************************************
	Description : 스마트 모듈 호출 
******************************************************************************/
function ln_SM_Call(strBatchId, strId, strPass){

       // alert("strBatchId::"+strBatchId+"::STATUS::"+gs_status+"::SIGNAL::"+gs_signal+"::strId::"+strId+"strPass::"+strPass+"::SBDESCRIPTION::"+hid_sbdescription.value);
    
		var url="";
    	var v_left = (screen.width-300)/2;
    	var v_top  = (screen.height-300)/2;

		if(gs_sm_call_status=="S"){          //상태변경
				url=gs_url+"/callSB_V3/XXSB_DTI_STATUS_CHANGE.asp?BATCH_ID="+strBatchId+"&STATUS="+gs_status+"&SIGNAL="+gs_signal
																	 +"&ID="+strId+"&PASS="+strPass+"&SBDESCRIPTION="+hid_sbdescription.value;	
				window.open(url,"", "status=1,  scrollbars=no, width=300, height=280, left="+v_left+", top="+v_top  );
		}else if (gs_sm_call_status=="V"){   //세금계산서 보기 및 출력
				url=gs_url+"/callSB_V3/XXSB_DTI_PRINT.asp?BATCH_ID="+strBatchId+"&SORTFIELD=A&SORTORDER=1";		
				window.open(url,"", "status=1,  scrollbars=yes, width=300, height=280, left="+v_left+", top="+v_top  );
	    }else if (gs_sm_call_status=="R"){   //역발행 매출
				url=gs_url+"/callSB_V3/XXSB_DTI_RARISSUE.asp?CONVERSATION_ID="+gs_conversation_id+"&ID="+strId+"&PASS="+strPass;	
				window.open(url,"", "status=1,  scrollbars=no, width=300, height=280, left="+v_left+", top="+v_top  );
	    }else if (gs_sm_call_status=="I"){   //정발행 매출 
				url=gs_url+"/callSB_V3/XXSB_DTI_ARISSUE.asp?BATCH_ID="+strBatchId+"&ID="+strId+"&PASS="+strPass;		
				//prompt('url',url);
				window.open(url,"", "status=1,  scrollbars=no, width=300, height=280, left="+v_left+", top="+v_top  );
		}


		ln_Query();
		
}

/******************************************************************************
	Description : 스마트 모듈 호출 _ Email 
******************************************************************************/
function ln_SM_Email_Call( strId, strPass){

  //  alert("::CONVERSATION_ID::"+gs_conversation_id+"::EMAIL::"+hid_email.value+"::strId::"+strId+"strPass::"+strPass+"::STATUS::"+gclx_status.bindcolval);  
	var url="";
    var v_left = (screen.width-300)/2;
    var v_top  = (screen.height-300)/2;

    if (gs_sm_call_status=="E"){   //Email 재발송
				url=gs_url+"/callSB_V3/XXSB_DTI_SEND_EMAIL.asp?CONVERSATION_ID="+gs_conversation_id+"&EMAIL="+hid_email.value	
		                                                          +"&ID="+strId+"&PASS="+strPass+"&STATUS="+gclx_status.bindcolval;	

        //prompt('url::',url);
    }

	window.open(url,"", "status=1, width=300, height=280, left="+v_left+", top="+v_top );
}

/******************************************************************************
	Description : 스마트 모듈 호출 _역발행 매출 
******************************************************************************/
/*
function ln_SM_ISSUE_Call( strId, strPass){
  //  alert("::CONVERSATION_ID::"+gs_conversation_id+"::EMAIL::"+hid_email.value+"::strId::"+strId+"strPass::"+strPass+"::STATUS::"+gclx_status.bindcolval);  
		var url="";
    var v_left = (screen.width-300)/2;
    var v_top  = (screen.height-300)/2;

    if (gs_sm_call_status=="R"){   //역발행 매출
				url=gs_url+"/callSB_V3/XXSB_DTI_RARISSUE.asp?CONVERSATION_ID="+gs_conversation_id+"&ID="+strId+"&PASS="+strPass;	
    }
		window.open(url,"", "status=1, width=300, height=280, left="+v_left+", top="+v_top );
}
*/
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>
<object id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_return classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!-- 권한관리 -->
<object id=gcds_right classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_login classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>
</comment><script>__ws__(__NSID__);</script>

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__">
	<object id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
		<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
  </object>     
	<object id=gctr_data2 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
		<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
		<PARAM NAME="KeyValue" VALUE="a040065_t2(I:USER=gcds_temp,O:USER2=gcds_return)">
  </object>
 </comment><script>__ws__(__NSID__);</script>
	
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("에러가 발생 했습니다.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	}

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_cocode event=OnSelChange()>
  
	//ln_Find_Regno();
  //ln_Query(gcem_regno.text);

</script>

<script language="javascript"  for=gcgd_data event="OnClick(row,colid)">
  
	if(row==0 && colid=="CHK"){ //전체선택              
		if(gcds_data.namevalue(1,"CHK")=="T"){ //첫행이 체크 되어 있을 경우
			for(i=1;i<=gcds_data.Countrow;i++){
				gcds_data.namevalue(i,"CHK") = "F";
			}//for
		}else{
			for(i=1;i<=gcds_data.Countrow;i++){  //첫행이  체크 되지 않을 경우 모두 체크 
				gcds_data.namevalue(i,"CHK") = "T";
			}//for
		}
	}else if (row!=0 && colid=="CHK"){  //개별선택
        /*
		if(gs_gubun=="") gs_gubun=1;
		else if(gs_gubun=="1") gs_gubun=2;
		else if(gs_gubun=="2") gs_gubun=1;

		if(gs_gubun=="1"||gs_gubun==""){
			gcds_data.namevalue(row,"CHK")="T";
		}else{
			gcds_data.namevalue(row,"CHK")="F";
		}
		*/

	}


</script>

<script language=JavaScript for=gclx_supbuy event=OnSelChange()>

	if(gclx_supbuy.bindcolval=="0"){  //전체   - 일단 발행구분은 전체가 없음.
		gclx_status.CBData ="I^수신미승인,C^수신승인,R^수신거부,O^취소완료,M^발행취소요청(공급받는자),N^발행취소요청(공급자),V^역발행요청,T^역발행거부,W^역발행요청 취소";
	}else if(gclx_supbuy.bindcolval=="1"){ //역발행
    	gclx_status.CBData ="''^전체,V^역발행요청,I^수신미승인,C^수신승인,M^발행취소요청(공급받는자),N^발행취소요청(공급자),R^수신거부,O^취소완료,T^역발행거부,W^역발행요청 취소";
	}else if(gclx_supbuy.bindcolval=="2"){ //정발행
   	 	gclx_status.CBData ="''^전체,S^매출저장,I^수신미승인,C^수신승인,M^발행취소요청(공급받는자),N^발행취소요청(공급자),R^수신거부,O^취소완료";
	}
	ln_Query();
</script>


<script language=JavaScript for= gclx_status event=OnSelChange()>
   //매출발행 
	if(gclx_status.bindcolval =="I"){ //발행취소, 이메일재발송  
         sp0.style.display = "";
		 sp6.style.display = "";
		 sp7.style.display = ""; //세금계산서보기

		 sp1.style.display = "none";
	     sp2.style.display = "none";
		 sp3.style.display = "none";
		 sp4.style.display = "none";
		 sp5.style.display = "none";
		 //sp7.style.display = "none";
		 sp8.style.display = "none";

	}else if(gclx_status.bindcolval =="C"){ //발행취소요청, 이메일재발송, 세금계산서보기
		 sp1.style.display = "none";  //2014.01.09 
		 sp6.style.display = "";
		 sp7.style.display = "";

		 sp0.style.display = "none";
	     sp2.style.display = "none";
		 sp3.style.display = "none";
		 sp4.style.display = "none";
		 sp5.style.display = "none";
		 sp8.style.display = "none";

	}else if(gclx_status.bindcolval =="M"){ //발행취소승인, 발행취소거부
		 sp2.style.display = "";
		 sp3.style.display = "";

		 sp0.style.display = "none";
	     sp1.style.display = "none";
		 sp4.style.display = "none";
		 sp5.style.display = "none";
		 sp6.style.display = "none";
		 sp7.style.display = "none";
		 sp8.style.display = "none";

	}else if(gclx_status.bindcolval =="N"){ //이메일재발송

		 sp6.style.display = "";

		 sp0.style.display = "none";
	     sp1.style.display = "none";
		 sp2.style.display = "none";
		 sp3.style.display = "none";
		 sp4.style.display = "none";
		 sp5.style.display = "none";
		 sp7.style.display = "none";
		 sp8.style.display = "none";

 	}else if(gclx_status.bindcolval =="V"){ //역발행거부, 역매출발행

	     sp4.style.display = "";
		 sp5.style.display = "";

		 sp0.style.display = "none";
	     sp1.style.display = "none";
		 sp2.style.display = "none";
		 sp3.style.display = "none";
		 sp6.style.display = "none";
		 sp7.style.display = "none";
		 sp8.style.display = "none";

	}else if(gclx_status.bindcolval =="S"){ //매출발행

	     sp8.style.display = "";

		 sp0.style.display = "none";
	     sp1.style.display = "none";
		 sp2.style.display = "none";
		 sp3.style.display = "none";
		 sp4.style.display = "none";
		 sp5.style.display = "none";
		 sp6.style.display = "none";
		 sp7.style.display = "none";

	}else{
	     sp0.style.display = "none"; //발행취소
		 sp1.style.display = "none"; //발행취소요청 
		 sp2.style.display = "none"; //발행취소승인
		 sp3.style.display = "none"; //발행취소거부
		 sp4.style.display = "none"; //역발행거부
		 sp5.style.display = "none"; //역매출발행
		 sp6.style.display = "none"; //이메일재발송
		 sp7.style.display = "none"; //세금계산서보기
		 sp8.style.display = "none";
	}

	ln_Query();
 
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gctr_data event=OnSuccess()>

    //alert("BATCH_ID:"+gcds_return.namevalue(gcds_return.rowposition,"BATCH_ID"));
    //alert("ID:"+gcds_return.namevalue(gcds_return.rowposition,"ID"));
    //alert("PASS:"+gcds_return.namevalue(gcds_return.rowposition,"PASS"));
  
	ln_SM_Call(gcds_return.namevalue(gcds_return.rowposition,"BATCH_ID"),
	           gcds_return.namevalue(gcds_return.rowposition,"ID"),
			   gcds_return.namevalue(gcds_return.rowposition,"PASS"));
	//window.location.reload();
	//ln_Query();
	
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>


<script language=JavaScript for=gctr_data2 event=OnSuccess()>

    if(gs_sm_call_status=="E"){ //Email 재발송
		ln_SM_Email_Call(gcds_return.namevalue(gcds_return.rowposition,"ID"),
						 gcds_return.namevalue(gcds_return.rowposition,"PASS"));
  /*
	}else if(gs_sm_call_status=="R"){ //역발행 매출
		ln_SM_ISSUE_Call(gcds_return.namevalue(gcds_return.rowposition,"ID"),
										 gcds_return.namevalue(gcds_return.rowposition,"PASS"));
  */
	}
</script>

<script language=JavaScript for=gctr_data2 event=OnFail()>
	alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
</script>
 
 
</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/a040065_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"><nobr>
    <!--   <img src="../../common/img/btn/com_b_sale.gif"      style="cursor:hand" onclick="ln_Save()">-->
            <span id=sp0 style="display:none;"> <!-- 발행취소 -->
				<img src="../../Common/img/btn/com_b_p_cancel.gif"      style="cursor:hand" onclick="ln_Status('O','CANCELALL','발행취소')">
			</span>

			<span id=sp1 style="display:none;"> <!-- 발행취소요청 -->
				<img src="../../Common/img/btn/com_b_p_cancel_re.gif"   style="cursor:hand" onclick="ln_Status('N','CANCELISSUE','발행취소요청')">
			</span>

			<span id=sp2 style="display:none;"> <!-- 발행취소승인 -->
				<img src="../../Common/img/btn/com_b_p_cancel_ap.gif"   style="cursor:hand" onclick="ln_Status('O','SRADAPPRR','발행취소승인')">
			</span>

			<span id=sp3 style="display:none;"> <!-- 발행취소거부 -->
				<img src="../../Common/img/btn/com_b_p_cancel_rj.gif"   style="cursor:hand" onclick="ln_Status('C','REQREJECTR','발행취소거부')">
			</span>

			<span id=sp4 style="display:none;"> <!-- 역발행거부 -->
				<img src="../../Common/img/btn/com_b_op_sale_rj.gif"    style="cursor:hand" onclick="ln_Status('T','RIREJECT','역발행거부')">
			</span>

			<span id=sp5 style="display:none;"> <!-- 역매출발행 -->
				<img src="../../Common/img/btn/com_b_op_sale.gif"       style="cursor:hand" onclick="ln_SaleIssue('I','','역발행매출')">
			</span>

			<span id=sp6 style="display:none;"> <!-- 이메일 재발송  -->
				<img src="../../Common/img/btn/com_b_email_re.gif"      style="cursor:hand" onclick="ln_Email()">
			</span>

			<span id=sp7 style="display:none;"> <!-- 세금계산서보기 -->
				<img src="../../Common/img/btn/com_b_bill_view.gif"     style="cursor:hand" onclick="ln_Bill_View()">
			</span>

            <span id=sp8 style="display:none;"> <!-- 매출발행 -->
				<img src="../../Common/img/btn/com_b_sale.gif"    style="cursor:hand" onclick="ln_Issue('I','','매출발행')">
			</span>
			 
			<img src="../../Common/img/btn/com_b_query.gif"	    style="cursor:hand" onclick="ln_Query()"> 

			</nobr>
			
		</td>
  </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;" >
		<tr> 
      		<td width="100px" align=center  bgcolor="#eeeeee" class="tab15" ><nobr>지점코드</nobr></td>
			<td width="150px" class="tab18"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:2px;width:100px;">
					<param name=ComboDataID			value="gcds_fdcode">
					<param name=CBDataColumns		value="FDCODE,FDNAME">
					<param name=SearchColumn		value="FDNAME">
					<param name=Sort				value=false>
					<param name=Enable              value="true">
					<param name=ListExprFormat	    value="FDNAME^0^100">
					<param name=BindColumn			value="FDCODE">
				</object>
        </comment><script>__ws__(__NSID__);</script></nobr> 
			</td>
			<td width="100px" align=center  bgcolor="#eeeeee" class="tab18" ><nobr>사업장</nobr></td>
			<td width="190px" class="tab18"><nobr>&nbsp;<comment id="__NSID__">
				<object id=gclx_cocode      classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;width:100px;">
					<param name=CBData			  value="00^전체,01^고성,02^서울,04^홍성">
					<param name=CBDataColumns	  value="CODE,NAME">
					<param name=SearchColumn	  value=NAME>
					<param name=Sort			  value=false>
					<param name=ListExprFormat	  Value="CODE^1^30,NAME^1^60">								
					<param name=BindColumn		  value="CODE">
				</object>
        </comment><script>__ws__(__NSID__);</script></nobr> 
			</td>
			<td width="100px" align=center class="tab18" bgcolor="#eeeeee" ><nobr>발행기간</nobr></td>
			<td width="400px" class="tab18" ><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
					style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
					<param name=Alignment	  value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY-MM-DD">
					<param name=PromptChar	  value="_">
					<param name=Enable		  value="true">
					<param name=ClipMode      value=false>
				</object>
				</comment><script>__ws__(__NSID__);</script> 
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_frdt', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
				<comment id="__NSID__">
				<object  id=gcem_todt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
					style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
					<param name=Alignment	  value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY-MM-DD">
					<param name=PromptChar	  value="_">
					<param name=Enable		  value="true">
					<param name=ClipMode      value=false>
				</object>
				</comment><script>__ws__(__NSID__);</script> 
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_todt', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">&nbsp;</nobr>
			</td>
		</tr>
		<tr> 
      		<td width="100px" align=center  bgcolor="#eeeeee" class="tab17" ><nobr>사업자등록번호</nobr></td>
			<td width="150px" class="tab19" ><nobr>&nbsp;<comment id="__NSID__"><nobr> 
				<object id=gcem_regno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;left:0px;top:2px;width:80px;height:20px;">
					<param name=Text          value="">
					<param name=Alignment	  value=0>
					<param name=Border	      value=True>
					<param name=Format	      value="000-00-00000">
					<param name=PromptChar	  value="_">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<!-- <param name=ReadOnly      value=true> -->
				</object>
        </comment><script>__ws__(__NSID__);</script></nobr> 
			</td>
			<td width="100px" align=center  bgcolor="#eeeeee" class="tab19" ><nobr>거래처명</nobr></td>
			<td width="150px" class="tab19" colspan=3><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:250px" onKeydown="if(event.keyCode==13) ln_Popup()">
					<param name=Text			value="">
					<param name=Alignment		value=0>
					<param name=Border			value=true>
					<param name=GeneralEdit     value="true">
					<param name=PromptChar	    value="_">
				</object>
				</comment><script>__ws__(__NSID__);</script>&nbsp;
				<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-2px;cursor:hand"	 onclick="ln_Popup('A')">
			  <comment id="__NSID__">
				<object  id=gcem_vendcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:90px" onKeydown="if(event.keyCode==13) ln_Popup()">
					<param name=Text			value="">
					<param name=Alignment		value=0>
					<param name=Border			value=true>
					<param name=Format			value="#############">
					<param name=PromptChar	    value="_">
				</object>
				</comment><script>__ws__(__NSID__);</script> 
				<img name="btn_find" src="../../Common/img/btn/com_b_clear.gif"	style="position:relative;top:1px;left:8px;cursor:hand"	 onclick="gcem_vendnm.text = '';gcem_vendcd.text = '';gcem_regno.text=''">
			  </nobr> 
			</td>
		</tr>
		<tr> 
      		<td width="100px" align=center  bgcolor="#eeeeee" class="tab17" ><nobr>발행구분</nobr></td>
			<td width="150px" class="tab19" ><nobr>&nbsp;<comment id="__NSID__"><nobr> 
				<object id=gclx_supbuy      classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;width:100px;">
					<param name=CBData			value="2^정발행,1^역발행">
					<param name=CBDataColumns	value="CODE,NAME">
					<param name=SearchColumn	value=NAME>
					<param name=Sort			value=false>
					<param name=ListExprFormat	Value="CODE^0^30,NAME^0^60">								
					<param name=BindColumn		value="CODE">
				</object>
       			</comment><script>__ws__(__NSID__);</script></nobr> 
			</td>
			<td width="100px" align=center  bgcolor="#eeeeee" class="tab19" ><nobr>상    태</nobr></td>
			<td width="150px" class="tab19" ><nobr>&nbsp;<comment id="__NSID__">
				<object id=gclx_status      classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;width:180px;color:#FF0000;background:#FFFFCC">
					<param name=CBData			  value="S^매출저장,I^수신미승인,C^수신승인,R^수신거부,O^취소완료,M^발행취소요청(공급받는자),N^발행취소요청(공급자),V^역발행요청,T^역발행거부,W^역발행요청 취소">
					<param name=CBDataColumns	  value="CODE,NAME">
					<param name=SearchColumn	  value=NAME>
					<param name=Sort			  value=false>
					<param name=ListExprFormat	  Value="CODE^0^30,NAME^0^160">								
					<param name=BindColumn		  value="CODE">
					<param name=InheritColor	  value=true>
				</object>
				</comment><script>__ws__(__NSID__);</script>&nbsp;
			  </nobr> 
			</td>
			<td width="100px" align=center  bgcolor="#eeeeee" class="tab19" ><nobr>수정코드</nobr></td>
			<td width="150px" class="tab19" ><nobr>
				<comment id="__NSID__">
				<object  id=gclx_amend_code classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:3px;top:0px;font-size:12px;width:180px;height:200px;">
					<param name=CBData				value="^'전체',01^기재사항의 착오 정정,02^공급가액 변동,03^환입,04^계약의 해제,05^내국신용장 사후 개설,06^착오에 의한 이중발급 등">
					<param name=CBDataColumns		value="CDCODE,CDNAM">
					<param name=SearchColumn		value="CDNAM">
					<param name=Sort				value="false">
					<param name=ListExprFormat	    value="CDCODE^1^20,CDNAM^0^180">
					<param name=BindColumn			value="CDCODE">
				</object></comment><script>__ws__(__NSID__);</script>
				</nobr>
			</td>
		</tr>
		<tr>
			<td width="100px"  align=center  bgcolor="#eeeeee" class="tab17" >결재상태</td>
			<td class="tab19"  colspan =5><nobr>&nbsp;
				<comment id="__NSID__"> 
				<object  id=gclx_taxsts classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:-5px;top:3px;font-size:12px;width:100px;">
					<param name=CBData			    value="^전체,N^대기,R^요청,Y^승인,B^반송">
					<param name=CBDataColumns		value="CDCODE,CDNAM">
					<param name=SearchColumn		value="CDNAM">
					<param name=Sort				value="false">
					<param name=Enable				value="true">
					<param name=ListExprFormat	    value="CDNAM^0^90">
					<param name=BindColumn			value="CDCODE">
					<param name=index				value="0">
				</object>
			    </comment><script>__ws__(__NSID__);</script></nobr> 
			</td>
		</tr>
		</table>
    </td>
	</tr>
	
	<tr>
	<td colspan=2>	  
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;top:5px;width:876px;border:0 solid #708090;">
		<tr> 			
			<td>
				<comment id="__NSID__">
					<object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data style="WIDTH:874px;HEIGHT:377px;border:1 solid #777777;display:block;">
						<PARAM NAME="DataID"		VALUE="gcds_data">
						<PARAM NAME="BorderStyle"   VALUE="0">
						<param name="IndWidth"      value="0">
						<param name="Fillarea"		VALUE="true">
						<param name="ColSizing"     value="true">
						<param name="editable"      value="true">
						<param name="UsingOneClick" value="1">
						<PARAM NAME="Format"			  VALUE="  
						<FC> Name='선택'	           ID=CHK         	      HeadAlign=Center HeadBgColor=#B9D4DC Width=30	    align=center	EditStyle=CheckBox </FC> 
						<FC> Name='거래처명'		   ID=BYR_COM_NAME   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left		edit=none </FC>
						<FC> Name='사업자등록번호'	   ID=BYR_COM_REGNO       HeadAlign=Center HeadBgColor=#B9D4DC Width=90	    align=center    edit=none  Mask='XXX-XX-XXXXX'</FC>
						<C>  Name='공급가액'		   ID=SUP_AMOUNT          HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right		edit=none </C>
						<C>  Name='부가세액'		   ID=TAX_AMOUNT          HeadAlign=Center HeadBgColor=#B9D4DC Width=80     align=right		edit=none </C>
						<C>  Name='합계'            ID=TOTAL_AMOUNT   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90  	align=right  	edit=none </C>			
						<C>  Name='상태'            ID=DTI_STATUS    	  HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left  	edit=none  EditStyle=Combo Data='S:매출저장,I:수신미승인,C:수신승인,R:수신거부,O:취소완료,M:발행취소요청(공급받는자),N:발행취소요청(공급자),V:역발행요청,T:역발행거부,W:역발행요청 취소'</C>			  					
						<C>  Name='응답코드'		   ID=RETURN_CODE  	      HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center	edit=none </C>
						<C>  Name='응답코드내용'      ID=RETURN_DESCRIPTION  HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left		edit=none Value={IF(RETURN_CODE=30000,'정상',RETURN_DESCRIPTION)}</C>					
					    <C>  Name='사유'            ID=SBDESCRIPTION       HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left		edit=none </C>		
						<C>  Name='Email'		   ID=BYR_EMAIL   	      HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=left		edit=none </C>
						<C>  Name='계산서일자'    	   ID=DTI_WDATE  	      HeadAlign=Center HeadBgColor=#B9D4DC Width=80	    align=center    edit=none  </FC>
						<C>  Name='수정코드'         ID=AMEND_CODE          HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left  	edit=none  EditStyle=Combo Data='01:기재사항의 착오·오류,02:공급가액 변동,03:환입,04:계약의 해제,05:내국신용장 사후 개설'</C>
						<C>  Name='수정비고'         ID=REMARK        	  HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left  	edit=none  </C>
					    <C>  Name='결재상태'         ID=TAXSTS        	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left  	edit=none EditStyle=Combo, Data='N:대기,R:요청,Y:승인,B:반송' </C>
					">
					</object>
				</comment><script>__ws__(__NSID__);</script>
			  <input id="hid_sbdescription" type="hidden" class="txtbox" style= "width:400px;height:20px;"  readOnly="true";> 
				<input id="hid_email" type="hidden" class="txtbox" style= "width:400px;height:20px;"  readOnly="true";> 
			</td>
		</tr>
		
		</table> 
  </td>
	</tr>
	<tr><td colspan="2" height="24" align="left">조회건수 : <label id="lbl_search"></label></td> </tr>	 
	<input type="hidden" class="txt11" id="hid_login"  style="position:relative;left:0px;width:60px;background-color:#d7d7d7" readOnly>
</table>
 </body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


