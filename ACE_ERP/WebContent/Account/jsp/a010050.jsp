<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 업체등록요청 (사용자) 
+ 프로그램 ID	: a010050.jsp
+ 기 능 정 의	: 업체등록요청 
+ 최 초 이 력	: 
+ 변 경 이 력	: 
------------------------------------------------------------------------------
+ 수 정 내 용  : 우편번호 변경
+ 수   정  자  :  정 영 식
+ 수 정 일 자  : 2016.03.09
------------------------------------------------------------------------------
+ 수 정 내 용  : 파일첨부 기능 추가 
+ 수    정  자 : 정 영 식
+ 수 정 일 자  : 2017.06.07
------------------------------------------------------------------------------
+ 수 정 내 용  : 등록 버튼 클릭안하면 입력안되게끔 수정
+ 수    정  자 : 이 동 훈
+ 수 정 일 자  : 2019.05.31
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a010050_s1, a010050_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>

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

var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;
var gs_position =0;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
		
	fnInit_tree(tree_idx);	//트리초기화 호출
    
    gclx_status_0.bindcolval ="N"    
    gcra_usegb_0.codevalue="1";
    gclx_cocomyn.bindcolval="";
    gclx_status.bindcolval ="N";
    
    txt_empno.value =gusrid;
	txt_empnmk.value = gusrnm;
	
    document.getElementById("txt_vend_nm").disabled = true;
    document.getElementById("txt_vend_nm").className = "input_ReadOnly";
	
    document.getElementById("txt_vd_direct").disabled = true;
    document.getElementById("txt_vd_direct").className = "input_ReadOnly";
    
    document.getElementById("txt_bsns_cnd").disabled = true;
    document.getElementById("txt_bsns_cnd").className = "input_ReadOnly";    
    
    document.getElementById("txt_bsns_knd").disabled = true;
    document.getElementById("txt_bsns_knd").className = "input_ReadOnly";  
    
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
		
	//alert("gs_userid::"+gs_userid+"::gusrid::"+gusrid);
	
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	
	document.all.LowerFrame.style.visibility="visible";
	
	//첨부파일 초기화 
	document.fileForm.reset();

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_s1?v_str1="+gcem_vend_cd_0.text
                                                                        +"&v_str2="+gcem_vend_nm_0.text
                                                                        +"&v_str3="+gclx_status_0.bindcolval
                                                                        +"&v_str4="+gcem_vend_id_0.text    
                                                                        +"&v_str5="+ txt_empno.value   	
                                                                        +"&v_str6="+gcra_usegb_0.codevalue;     	
	                                                                                                                                                                                                                                                       
   // prompt('',gcds_data.DataID);
	gcds_data.Reset();
	
}


/******************************************************************************
	Description : 조회2
******************************************************************************/
function ln_Query2(){
	
	//alert("gs_userid::"+gs_userid+"::gusrid::"+gusrid);

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_s1?v_str1="+gcem_vend_cd_0.text
	                                                                    +"&v_str2="+gcem_vend_nm_0.text
	                                                                    +"&v_str3="+gclx_status_0.bindcolval
	                                                                    +"&v_str4="+gcds_data.namevalue(gcds_data.rowposition,"VEND_ID")   
	                                                                    +"&v_str5="+ txt_empno.value;     	
	                                                                                                                                                                                                                                                       
	//prompt('',gcds_data.DataID);
	gcds_data.Reset();

}


/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){
		
		
    document.getElementById("txt_vend_nm").disabled = false;
    document.getElementById("txt_vend_nm").className = "";
	
    document.getElementById("txt_vd_direct").disabled = false;
    document.getElementById("txt_vd_direct").className = "";
    
    document.getElementById("txt_bsns_cnd").disabled = false;
    document.getElementById("txt_bsns_cnd").className = "";    
    
    document.getElementById("txt_bsns_knd").disabled = false;
    document.getElementById("txt_bsns_knd").className = "";  		
		
	ln_SetDataHeader();
	
	gcds_data.addrow();	
	
	gcds_data.namevalue(gcds_data.rowposition,"CHK")="T";
	//gcra_use_tag.CodeValue="Y";	
    //gclx_cocomyn.index=1;
    
    gclx_cocomyn.bindcolval="";
    gclx_status.bindcolval ="N";
    
    gcds_data.namevalue(gcds_data.rowposition,"USE_TAG")="Y";
    
    ln_Find2();
    
}


/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
		
	if(gs_userid==""||gs_userid==undefined){
		alert("사용자 id가 존재하지 않습니다. 다시 로그인 하시길 바랍니다.");
		return false;
	}	
		
		
	if(!ln_Chk_Save())return;
	else if (gcds_data.IsUpdated) {
		
	    if(!ln_Chk_Save_Status())return;
	
		if (confirm("입력하신 사항을 등록하시겠습니까?")){	
			
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_t1";
		
		gctr_pyo.Parameters = "v_str1="+gs_userid;
		
		//prompt(this, gcds_data.text);
		
		gctr_pyo.post();
		
		ln_Query2();
		
		//alert(gcds_data.namevalue(1,"CHK"));
		gcds_data.namevalue(gcds_data.rowposition,"CHK")="T";
		
		ln_AppReq();
		
		}	
		
	}
	
}


/******************************************************************************
	Description : 삭제 
******************************************************************************/
function ln_Delete(){

    //상태값 체크 
    if(!ln_Chk_Delete_Status()) return false;
    
	if (confirm(" 해당 데이터를 삭제 하시겠습니까?")){	
		
		gcds_data.DeleteMarked();
		
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_t1";
		
		gctr_pyo.Parameters = "v_str1="+gs_userid;
		
		gctr_pyo.post();
		
		ln_Query();
		
	}	
	
}

/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
function ln_Chk_Save() {

  //상태값이 대기 일경우만 가능 
   for(i=1;i<=gcds_data.countrow;i++){
   		if(gcds_data.SysStatus(i)=="1"||gcds_data.SysStatus(i)=="3"){
   		
   			if(gcds_data.namevalue(i,"VEND_ID") == ""){//사업자등록번호
				alert("등록번호를 입력하세요.");
				return false;
			}
			
			if(fn_trim(gcds_data.namevalue(i,"VEND_NM")) == ""){//거래처명
				alert("거래처명을  입력하세요.");
				return false;
			}
			
			if(fn_trim(gcds_data.namevalue(i,"VD_DIRECT")) == ""){//대표자명
				alert("대표자명을  입력하세요.");
				return false;
			}
				
			if(fn_trim(gcds_data.namevalue(i,"BSNS_CND")) == "" ){ //업태				
				alert("업태를 입력하세요 .");
				return false;
			}		
			
			if(fn_trim(gcds_data.namevalue(i,"BSNS_KND")) == "" ){ //업종				
				alert("업종을  입력하세요 .");
				return false;
			}		
			
			if(gcds_data.namevalue(i,"COCOMYN") == "" ){ //업체구분				
				alert("업체구분을  입력하세요 .");
				return false;
			}	
			
			
			if(fn_trim(gcds_data.namevalue(i,"POST_NO1"))==""){ //우편번호				
				alert("우편번호를  입력하세요1.");
				return false;
			}	
			
			
			if(fn_trim(gcds_data.namevalue(i,"POST_NO2"))==""){ //우편번호				
				alert("우편번호를  입력하세요2.");
				return false;
			}	

			
			if(fn_trim(gcds_data.namevalue(i,"ADDRESS1")) == "" ){ //주소				
				alert("주소를  입력하세요 .");
				return false;
			}	
			
			if(fn_trim(gcds_data.namevalue(i,"ADDRESS2")) == "" ){ //기타주소				
				alert("기타주소를  입력하세요 .");
				return false;
			}	
			
		}
   		
   }
 
	return true;
	
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){
		
	gcds_data.undo(gcds_data.rowposition);
	
}

/******************************************************************************
	Description : 승인요청
******************************************************************************/
function ln_AppReq(){
		
    //상태값 체크 : 대기 반송 상태만 요청 가능함 
    
    if(!ln_Chk_Status("승인요청")) return false;
   
	if (confirm(" 해당 거래처 등록 승인 요청 하시겠습니까?")){	
		
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_t2";
		
		gctr_pyo.Parameters = "v_str1="+gs_userid;
		
	//	prompt('',gcds_data.text);
		gctr_pyo.post();
		
		ln_Query();
		
	}else{
		
		gcds_data.UndoAll();
		
	}	
	
}


/******************************************************************************
	Description : 상태값 체크 
******************************************************************************/
function ln_Chk_Save_Status(){
		
	for(var i =1; i<=gcds_data.countrow;i++){
		
		//alert("gcds_data.SysStatus(i)::"+gcds_data.SysStatus(i));
		if(gcds_data.SysStatus(i)==3){
			
			if(gcds_data.namevalue(i,"STATUS")!="N"&&gcds_data.namevalue(i,"STATUS")!="B"){
				
				alert(gcds_data.namevalue(i,"VEND_NM")+"은 수정 가능건이 아닙니다.");
				
				return false;
				
			}
		}
	}

	return true;
}

/******************************************************************************
	Description : 상태값 체크 
******************************************************************************/
function ln_Chk_Status(strReq){
		
    var vcnt=0;
    
    for(var i =1; i<=gcds_data.countrow;i++){
    	
		if(gcds_data.namevalue(i,"CHK")=="T"){
			
			if(gcds_data.SysStatus(i)=="1"){
				
				alert("저장 후 "+strReq+" 하십시요.");
				
				return false;
				
			}
			
			vcnt+=1;	
		}
		
	}
    
  
    if (vcnt==0){
    	
		alert("선택된 항목이 존재 하지 않습니다.");
		
		return false;
		
	}
	
    
	for(var i =1; i<=gcds_data.countrow;i++){
		
		if(gcds_data.namevalue(i,"CHK")=="T"){
			
			if(gcds_data.namevalue(i,"STATUS")!="N"&&gcds_data.namevalue(i,"STATUS")!="B"){
				
				alert(gcds_data.namevalue(i,"VEND_NM")+"은 "+strReq+" 건이 아닙니다.");
				
				return false;
				
			}else{
				
				gcds_data.namevalue(i,"STATUS")="R"; 
				
			}
			
		}
		
	}
	
	return true;
	
}

/******************************************************************************
	Description : 상태값 체크 삭제
******************************************************************************/
function ln_Chk_Delete_Status(){
		
    var vcnt=0;
    
	for(var i =1; i<=gcds_data.countrow;i++){
		
		if(gcds_data.namevalue(i,"CHK")=="T"){
			
			if(gcds_data.namevalue(i,"STATUS")=="Y"){
				
				alert(gcds_data.namevalue(i,"VEND_NM") + "은  삭제 가능건이 아닙니다.");
				
				return false;
				
			}
			
			gcds_data.MarkRows(i,i);
			
			vcnt+=1;
		}
		
	}
	
	if (vcnt==0){
		
		alert("선택된 항목이 존재 하지 않습니다.");
		
		return false;
		
	}
	
	return true;
	
}


/******************************************************************************
Description : 승인
******************************************************************************/
function ln_Apply(){

	if(!ln_Chk_Apply_Status()){
		
		return;
		
	}else if (gcds_data.IsUpdated) {
		
		if (confirm("업체 등록을 승인 하시겠습니까?")){	
			
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010051_t1";
		
		gctr_pyo.Parameters = "v_str1="+gs_userid+",v_str2="+gs_date2;
		
		//prompt('',gcds_data.text);
		
		gctr_pyo.post();
		
		ln_Query();
		
		}	
	}
}


function ln_Chk_Apply_Status(){
	
    var vcnt=0;
    
	for(var i =1; i<=gcds_data.countrow;i++){
		
		if(gcds_data.namevalue(i,"CHK")=="T"){
			
			if(gcds_data.namevalue(i,"STATUS")!="N"&&gcds_data.namevalue(i,"STATUS")!="R"){
				
				alert("승인 대상 건이 아닙니다.");
				
				return false;
				
			}else{
				
				gcds_data.namevalue(i,"STATUS")="Y"; 
				
			}
			
			vcnt+=1;
		}
		
	}
	
	if(vcnt==0){
		
		alert("선택된 항목이 존재 하지 않습니다.");
		
		return false;
		
	}
	
	 //화면상에서 동일건 체크 
  	 for(var k =1; k<=gcds_data.countrow;k++){
  		 
  	 	for(var j=k+1;j<=gcds_data.countrow;j++){
  	 		
  	 	    //alert("k::"+k+"::j::"+j+"::"+gcds_data.namevalue(k,"VEND_ID")+":::"+gcds_data.namevalue(j,"VEND_ID"));
   	 		if(gcds_data.namevalue(k,"CHK")=="T"&& gcds_data.namevalue(j,"CHK")=="T" && gcds_data.namevalue(k,"VEND_ID")==gcds_data.namevalue(j,"VEND_ID")){
   	 			
   	 		    alert(gcds_data.namevalue(k,"VEND_ID")+"  동일한 사업자 번호가 존재 합니다 .");
   	 		    
   	 			return false;
   	 			
   	 		}
   	 		
   	    }
  	 	
  	 }
  	 
  	 
  	 //DB 상세서 동일건 체크 
  	 for(var p =1; p<=gcds_data.countrow;p++){
  		 
		if(gcds_data.namevalue(p,"CHK")=="T"){
			
			gcds_temp01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s6?v_str1="+gcds_data.namevalue(p,"VEND_ID"); 
			gcds_temp01.Reset();
			
			if(gcds_temp01.namevalue(1,"CNT")>0){
				
				alert(gcds_data.namevalue(p,"VEND_ID")+" 중복된 번호가 존재합니다.\n\n확인하시고 다시 입력해 주십시오.");
				
				return false;
				
			}
			
		}
		
	}
	
	return true;
	
}



/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

}


/******************************************************************************
	Description : 문자열체크
******************************************************************************/


/******************************************************************************
	Description : 중복체크 팝업
******************************************************************************/
function ln_Find2(){
		
	var arrResult	= new Array();
	var arrParam	= new Array();
	var strURL;	
	var strPos;

	if(gcds_data.namevalue(gcds_data.rowposition,"VEND_CD")!=""){
	    alert("신규 등록시에만 중복 체크 가능합니다.");
		return false;
	}
	
	strURL = "<%=dirPath%>/Account/jsp/a010050_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:120px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

 	if (arrResult != null) {
 		
		arrParam = arrResult.split(";");
		ln_usegb_format(arrParam[1]);
		gcem_vend_id.text = arrParam[0];
		gcem_vend_id_0.text = arrParam[0];
		
	} else {
		
		gcem_vend_id.text ="";
		
	}
 	
}



/******************************************************************************
	Description : data clear
******************************************************************************/
function ln_usegb_format(strusegb){
		
	if(strusegb=="1"){ //
		
		gcem_vend_id.Format = "000-00-00000";        //법인 
		
	}else if(strusegb=="2"){
		
		gcem_vend_id.Format = "000000-0000000";  //개인 
		
	}
	
}

/******************************************************************************
	Description : Dataset Head 설정 -  
******************************************************************************/
function ln_SetDataHeader(){
		
	if(gcds_data.countrow<1){
		
		var THeader = "CHK:STRING, VEND_CD:STRING,VEND_NM:STRING,VEND_ID:STRING,VEND_NO:STRING,VD_DIRECT:STRING,"
							+ "BSNS_CND:STRING,BSNS_KND:STRING,VD_TELNO:STRING,VD_FAXNO:STRING,POST_NO1:STRING,"
							+ "POST_NO2:STRING,ADDRESS1:STRING,ADDRESS2:STRING,"
							+ "USE_TAG:STRING,"
							+ "REMARK:STRING,CREAT_DT:STRING,CREAT_NM:STRING,MSN:STRING,MPWD:STRING,"
							+ "COCOMYN:STRING,H_VEND_CD:STRING,H_VEND_NM:STRING,IUGB:STRING,"
							+ "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
							+ "STATUS:STRING,RQID:STRING,RQDT:STRING,CFID:STRING,CFDT:STRING,BSID:STRING,BSDT:STRING,"
							+ "EMPNMK:STRING,SB_REASON:STRING,VENDER_USERGB:STRING,"
							+ "REAL_FILE4:STRING,SYS_FILE4:STRING,REAL_FILE3:STRING,SYS_FILE3:STRING,"
							+ "REAL_FILE2:STRING,SYS_FILE2:STRING,REAL_FILE1:STRING,SYS_FILE1:STRING";
		
		gcds_data.SetDataHeader(THeader);					
		
	}
	
}

/***********************************************************************************************
	Description : 우편번호 찾기
	parameter   : p==> 01 - 거래처, 02 - 지점, 03 - 사업장 
**********************************************************************************************/
function ln_Popup(e){
		
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "<%=dirPath%>/Common/jsp/com_zipcd.jsp";
	strPos = "dialogWidth:640px;dialogHeight:425px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);


	if (arrResult != null) {
		
		arrParam = arrResult.split(";");
		
		var post_no1 = arrParam[0];
		
		txt_post_no1.value= post_no1.substring(0,3);
		txt_post_no2.value= post_no1.substring(3,6);
		txt_address1.value = arrParam[1] + arrParam[2]; 
		txt_address2.value= arrParam[3] + arrParam[4];
		
	}else {
		
		txt_post_no1.value= "";
		txt_post_no2.value= "";
		txt_address1.value=""; 
		txt_address2.value="";
		
	}
}


/***********************************************************************************************
	Description : 사번찾기
	parameter   :
**********************************************************************************************/
function ln_Popup_Empno(){
		
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

    arrParam[0]="" ;//

	strURL =  "./empno_popup.jsp";
	strPos = "dialogWidth:390px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		
		arrResult = result.split(";");
		txt_empno.value =arrResult[1];
		txt_empnmk.value = arrResult[0];
		
	}else{
		
   		txt_empno.value="";
		txt_empnmk.value="";
		
	}
}


function link_1(url){  // default 창
	
  var stat='top=0,left=50,width=1024,height=768,toolbar=1,location=1,status=1,menubar=1,scrollbars=1,directories=0,resizable=1';

  newWin=window.open('','',stat);
  
  newWin.location=url;
  
}

</script>


<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>

<script>
function openDaumPostcode() {
    	
    var width =500;
    var height =600; 	
    	
    new daum.Postcode({
    	
    	 width:width,
         height:height,
    	
    	
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
            
        	 var strpostcode="";  //이전 우편번호 ( 6자리 )
             var strzonecode="";  //신규 우편번호 ( 5자리 )
             strzonecode = data.zonecode;    
             document.getElementById('txt_post_no1').value = strzonecode.substring(0,3);
             document.getElementById('txt_post_no2').value = strzonecode.substring(3,5);
             
             document.getElementById('txt_address1').value = data.address;
             document.getElementById('txt_address2').focus();
        }
    }).open({
    	    left:(window.screen.width/2)-(width/2),
		    top:(window.screen.height/2)-(height/2)
    	
    		});
 }

</script> 



<script>
<%
//파일 첨부
%>
function fnFileUpload(){
	
	//거래처 코드가 존재해야만 업로드 가능.
    //alert("VEND_CD::"+gcds_data.namevalue(gcds_data.rowpostion,"VEND_CD"));
	 
	if(gcds_data.namevalue(gcds_data.rowpostion,"VEND_CD")==""||gcds_data.namevalue(gcds_data.rowpostion,"VEND_CD")==undefined){
		alert("거래처가 선택 후 파일 업로드 가능합니다.");
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
	}else if(f.filename3.value!=""){
		file_position ="3";
	}else if(f.filename4.value!=""){	
		file_position ="4";
	}
	
	gs_position = file_position; 
	
	//alert("file_position::"+file_position+"::gs_position::"+gs_position);
	
	var realFileName = f.filename1.value;
	
	//var realFileName = eval("f.filename"+seq).value;
	var idx = realFileName.lastIndexOf("\\");
	realFileName = realFileName.substring(idx+1);
	//alert("realFileName:::"+realFileName);
	

	if(f.filename4.value==""){
		alert("사업자등록증 첨부할 파일을 선택하십시요1.");	
		return false;
	}
	
	
	//alert(f.filename4.value.substring(f.filename4.value.lastIndexOf("\\")+1).toUpperCase().indexOf(".PDF"));
	//alert(f.filename3.value.substring(f.filename3.value.lastIndexOf("\\")+1).toUpperCase().indexOf(".PDF"));
	
	if(f.filename4.value.substring(f.filename4.value.lastIndexOf("\\")+1).toUpperCase().indexOf(".PDF")<0){
		alert("사업자등록증은 PDF파일만 첨부 가능합니다. ");
		return false;
	}
	
	
	if(f.filename3.value!=""){
		if(f.filename3.value.substring(f.filename3.value.lastIndexOf("\\")+1).toUpperCase().indexOf(".PDF")<0){
			alert("등기부등본은 PDF파일만 첨부 가능합니다. ");
			return false;
		}
	}
	
	
	if(f.filename2.value!=""){
		if(f.filename2.value.substring(f.filename2.value.lastIndexOf("\\")+1).toUpperCase().indexOf(".PDF")<0){
			alert("완납증명서는 PDF파일만 첨부 가능합니다. ");
			return false;
		}
	}
	
	if(f.filename1.value!=""){
		if(f.filename1.value.substring(f.filename1.value.lastIndexOf("\\")+1).toUpperCase().indexOf(".PDF")<0){
			alert("기타는 PDF파일만 첨부 가능합니다. ");
			return false;
		}
	}
	
	var file_nm
	
	f.target="tempUpload";	//업로드 폼의 타겟은 iFrame !
	f.realFileName.value=realFileName;
	f.mode.value="insert";
	
	f.action = "./a010050_fileUpload.jsp";
	f.submit();
	
	/*
	//fileForm.filename.value = txt_file_dir.value ;
	fileForm.target="tempUpload";	              //업로드 폼의 타겟은 iFrame !
	//fileForm.action="./a010050_fileUpload_old.jsp";   //실질적인 파일 업로드
	
	fileForm.realFileName.value=realFileName;
	fileForm.mode.value="insert";
	
	fileForm.action="./a010050_fileUpload.jsp";   //실질적인 파일 업로드 
	fileForm.submit();
	*/
}



<%
//파일 추가 리스트  --> a010050_fileUpload에서 호출 
//실제업로드 된 파일명을 리턴해 줌. 
%>
function addFileList(realName, virtualName, intTot, strfilename)	{
	//alert("addFileList");
	//alert("strfilename::"+strfilename);
	
	f = document.fileForm;
	//eval("f."+strfilename).reset();
	//document.getElementsByName("filename4").form.reset();
	
	//alert("f.fileList.options.length::"+f.fileList.options.length);
	//alert("intTot::"+intTot);
	
	intTot = intTot - 1;

	if(realName!=""){
		//f.fileList.options[f.fileList.options.length] = new Option(realName,virtualName);
		f.fileList.options[intTot] = new Option(realName,virtualName);
	}
	
	/*
	alert("f.fileList.options[1].value:"+f.fileList.options[1].value);
	alert("f.fileList.options[1].text::"+f.fileList.options[1].text);
	alert("f.fileList.options[2].value:"+f.fileList.options[2].value);
	alert("f.fileList.options[2].text::"+f.fileList.options[2].text);
	*/
	
	//alert("gcds_data.rowposition::"+gcds_data.rowposition);
	
	//파일명 업데이터 처리...
	if(strfilename=="filename4"){        //사업자등록증
		gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE4")=realName;
		gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE4")=virtualName;
	}else if(strfilename=="filename3"){ //등기부등본
		gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE3")=realName;
		gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE3")=virtualName;
	}else if(strfilename=="filename2"){ //완납증명서
		gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE2")=realName;
		gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE2")=virtualName;
	}else if(strfilename=="filename1"){ //기타 
		gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE1")=realName;
		gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE1")=virtualName;
	}
	
	//alert( "strfilename.substring(8,9)::"+strfilename.substring(8,9));
	if (gs_position==strfilename.substring(8,9)){
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_t3";
		gctr_data.Parameters = "v_str1="+gs_userid;
		//prompt('',gcds_data.text);
		gctr_data.post();
	}
	//f.file1.value ="첨부파일은최대10M까지가능합니다." ;  //f.file1.title;
}




<%
//조회 및 그리드 클릭시시 첨부파일이 존재하면 첨부list에 넣어둠.
%>
function fnFileList(row){
	var strReal_file="";
	var strSys_file ="";
	var intpo =4;
	for(var i=0;i<=3; i++){
		
		//alert("i::"+i);
		strReal_file = gcds_data.namevalue(row,"REAL_FILE"+intpo);
		strSys_file  = gcds_data.namevalue(row,"SYS_FILE"+intpo);
		//alert("strReal_file::"+strReal_file+"::strSys_file::"+strSys_file);
		document.fileForm.fileList.options[i] = new Option(strReal_file,strSys_file);
		intpo = intpo-1;
	}
}




<%
//파일삭제
//파일목록에서 삭제 
%>
function fnFileDelete(){
	f = document.fileForm;
  
	if(f.fileList.selectedIndex==null || f.fileList.selectedIndex < 0){
		alert('삭제할 파일을 선택해 주십시요');
		f.fileList.focus();
		return;
	}	

	if(confirm('정말로 삭제 하시겠습니까?')){
		var i = f.fileList.options.selectedIndex;
		var select_val  = f.fileList.options[i].value;
		var select_text = f.fileList.options[i].text;
		
		/*
		alert("i::"+i);
		alert("select_val::"+select_val);
		alert("select_text::"+select_text);
		*/
		
		//파일찾기해서 삭제되면 없애야 함...
		//var realFileName = f.file1.value;
	    //var fileArray = oldFileNames.split(":");

		//alert(select_val);
		//alert(oldFileNames);

		//******** START 기존에 있던 파일인지 구분 ***********/
		var isNew = "i_del"; // 이게 금방 올린 파일인 경우... insert_file
		/*
		var isNew = "i_del"; // 이게 금방 올린 파일인 경우... insert_file
		 
		if(fileArray.length>1){
			for(j=0;j< fileArray.length;j++){
				tempFileName = fileArray[j];
				if(tempFileName == select_val){
				   isNew = "u_del";		// 여기가 예전 파일	update_file 
				   break;
				}
			}
		}
		 
		if(fileArray.length <=1){
		   if(oldFileNames == select_val){
				      isNew = "u_del";
			}
		}
		*/
		//******** END  기존에 있던 파일인지 구분 ***********/
		 
		//alert(isNew);
		document.file_del.target="tempUpload";
		//document.file_del.realFileName.value=realFileName;
		document.file_del.realFileName.value=select_text;
		document.file_del.virtualFileName.value = select_val;
//		document.file_del.saveDir.value = "memGalleryUpload";
		document.file_del.mode.value=isNew;
		document.file_del.action = "./a010050_deleteFile.jsp";	//여기로 섬밋
		document.file_del.submit();
		
	}
}




//파일업로드 4
// 파일을 서버에서 삭제 후 리스트에서 삭제
function delResult(realName, virtualName){
	
	//alert("delResult:realName:"+realName+"virtualName"+virtualName);
	
	f = document.fileForm;

	idx = f.fileList.selectedIndex;
	cnt = f.fileList.options.length;
	for(i=idx;i< f.fileList.options.length-1;i++){
		f.fileList.options[i] = new Option(f.fileList.options[i+1].text,f.fileList.options[i+1].value);
	}
	f.fileList.options[cnt - 1] = null;
	//f.file1.value = "첨부파일은최대5M까지가능합니다.";
	
	//alert("gcds_data.rowposition::"+gcds_data.rowposition+"::del::realName"+realName+":virtualName:"+virtualName);
	
	var intPo=0;
	for(var j=4; j>=1; j--){
		//alert("j::"+j)
		if(gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE"+j)==virtualName){
			gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE"+j)="";
			gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE"+j)="";
			intPo = j;
		}
	}
	
	//업데이트 후에 DB에도 업데이트 해야함.
	gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_t4";
	gctr_data.Parameters = "v_str1="+intPo;
	//prompt('',gcds_data.text);
	gctr_data.post();
}





/*
function fnAddFileList(realName){
	f = document.fileForm;
	if(realName!=""){
		f.fileList.options[0].value="1";
		f.fileList.options[0].text=realName;
		
		//gcds_data.namevalue(gcds_data.rowposition,"ATT_GB") ="Y";
		//gcds_data.namevalue(gcds_data.rowposition,"ATT_FILE_NAME")= realName;
	}  
}
*/
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- 로그인 사번 체크  -->
<object  id=gcds_userid2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_temp01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object> 

</comment><script>__ws__(__NSID__);</script> 


<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="A010050_t1(I:USER=gcds_data)">
</object>


<object id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="A010050_t3(I:USER=gcds_data)">
</object>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_pyo" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_pyo" event="onfail()">

	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_pyo.ErrorCode + "\n" + "Error Message : " + gctr_pyo.ErrorMsg + "\n");
	
</script>


<script language=JavaScript event="OnLoadError()" for=gcds_data>

	alert("에러가 발생 했습니다.");
	document.all.LowerFrame.style.visibility="hidden";
	
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//총 조회 건수

	window.status="조회가 완료 되었습니다.";
	
	document.all.LowerFrame.style.visibility="hidden";
	
	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	}

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	
	window.status = "정상적으로 조회되었습니다.";
	
	fnFileList(1);

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcra_usegb_0 event=OnSelChange()>

	if(gcra_usegb_0.codevalue=="1"){ //
		gcem_vend_id_0.Format = "000-00-00000";    //법인 
	}else if(gcra_usegb_0.codevalue=="2"){
		gcem_vend_id_0.Format = "000000-0000000";  //개인 
	}
	
</script>


<script language=JavaScript for=gcgd_pyo event=OnClick(row,colid)>

    var intChk=0;
    
    if (row>=1){
    	intChk = gcds_data.namevalue(row,"VEND_ID").length;
    }

	if(intChk==10){ //
		gcem_vend_id.Format = "000-00-00000";    //법인 
	}else if(intChk==13){
		gcem_vend_id.Format = "000000-0000000";  //개인 
	}
	
	gcem_vend_id.text = gcds_data.namevalue(row,"VEND_ID");
	
	if(row>=1){
		fnFileList(row);
	}
	
</script>


<script language=JavaScript for=gcds_data event=OnRowPosChanged(row)>

	var intChk=0;
    
    if (row>=1){
    	intChk = gcds_data.namevalue(row,"VEND_ID").length;
    }
      
	if(intChk==10){ //
		gcem_vend_id.Format = "000-00-00000";    //법인 
	}else if(intChk==13){
		gcem_vend_id.Format = "000000-0000000";  //개인 
	}
	
	gcem_vend_id.text = gcds_data.namevalue(row,"VEND_ID");

</script>

 
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/a010050_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
    
            <!-- <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_sungin.gif" 	    style="cursor:hand" onclick="ln_Apply()" >&nbsp;&nbsp; -->
            <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_appreq.gif"		style="cursor:hand" onclick="ln_AppReq()">&nbsp;&nbsp;
    
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	    style="cursor:hand" onclick="ln_Add()" >
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"		style="cursor:hand" onclick="ln_Delete()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_cancle.gif"      style="cursor:hand" onclick="ln_Cancel()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;
	</td>
  </tr>
  <tr>
	<td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:868px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td width="80px" align=center  bgcolor="#eeeeee" class="tab15" rowspan=2 >검색조건</td>
			<td class="tab18" width="90px;" bgcolor="#eeeeee" align="center">거래처코드</td>
			<td width="90px" class="tab18" align=CENTER><comment id="__NSID__">
			<object  id=gcem_vend_cd_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:80px" >
				<param name=Text			value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=GeneralEdit		value="true">
				<param name=PromptChar		value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="90px;" bgcolor="#eeeeee" align="center">거래처명</td>
			<td width="200px" class="tab24" align="left" >
				<comment id="__NSID__">
					<object  id=gcem_vend_nm_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:165px" >
						<param name=Text			value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=GeneralEdit		value="true">
						<param name=PromptChar		value="_">
					</object>
				</comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="90px;" bgcolor="#eeeeee" align="center">상태</td>
			<td class="tab14" >&nbsp;
				<comment id="__NSID__">
					<object id=gclx_status_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:-53px;top:2px;font-size:12px;width:100px;">
								<param name=CBData			     value="N^대기,R^승인요청,Y^완료,B^반송">
								<param name=CBDataColumns	     value="CODE,NAME">
								<param name=SearchColumn	     value=NAME>
								<param name=Sort			     value=false>
								<param name=ListExprFormat       value="NAME">								
								<param name=BindColumn		     value="CODE">
					</object>
				</comment><script>__ws__(__NSID__);</script>
			</td> 	 
		</tr>
		<tr> 
		<td class="tab11" width="90px;" bgcolor="#eeeeee" align="center">번호구분</td>
		<td width="160px" class="tab11" ><comment id="__NSID__">
			<object id=gcra_usegb_0 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:160px;height:20px" >
				<param name=Cols		value="2">
				<param name=Format	value="1^사업자번호,2^주민번호">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
		
		<td class="tab11" width="90px;" bgcolor="#eeeeee" align="center">번호</td>
		<td width="90px" class="tab11"   Style="height:20px;;"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gcem_vend_id_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:-2px;top:3px">		
						<param name=Text			value="">
						<param name=Alignment       value=0>
						<param name=Border          value=true>
						<param name=Numeric         value=false>
						<param name=Format          value="000-00-00000">
						<param name=PromptChar      value="">
						<param name=BackColor       value="#CCCCCC">
						<param name=InheritColor    value=false>
						<param name=readOnly        value=false>
					   </object></comment><script>__ws__(__NSID__);</script>
		</td>
		<td class="tab11" width="90px;" bgcolor="#eeeeee" align="center">작성자</td>
		<td class="tab11" ><nobr> &nbsp;
			<input type="text" class="txt11" id="txt_empno"  style="position:relative;top:2px;left:-2px;width:60px;background-color:#d7d7d7" readOnly>
			<img src="../../Common/img/btn/com_b_find.gif" alt="코드 및 코드명을 검색합니다" style="cursor:hand;position:relative;top:2px;left:-3px" onclick="ln_Popup_Empno()">
		    <input type="text" class="txt11" id="txt_empnmk" maxlength=8 style="position:relative;top:2px;left:-4px;width:90px;"></nobr> 
		</td> 	 
		</tr> 
	</table>

	<tr>
	<td COLSPAN=2>
		<table>
			<tr>
			<td>
				<!--Grid-->
				<table cellpadding="0" cellspacing="0"  style="position:relative;left:-3px;width:250px;border:0 solid #708090;">
					<tr> 			
					<td ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo style="WIDTH:555px;HEIGHT:427px;border:1 solid #777777;display:block;" viewastext>
 						 <PARAM NAME="DataID"			VALUE="gcds_data">
						 <PARAM NAME="BorderStyle"      VALUE="0">
						 <PARAM NAME="Indwidth"		    VALUE="0">
						 <PARAM NAME="Fillarea"		    VALUE="true">
						 <PARAM NAME="ColSizing"		VALUE="true">
						 <param name="sortview"         value=left>
						 <param name="Editable"     	value='true'>
						 <param name=UsingOneClick      value="1">
					     <PARAM NAME="Format"			VALUE="  
					        <FC>ID=CHK 	         Name='선택'             	Width=28      HeadBgColor=#B9D4DC  bgcolor=#ffffff, align=center		EditStyle=CheckBox   </FC>  
							<FC>ID=VEND_CD,	     Name=거래처코드,		    width=85,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,   	edit=none  sort = true</FC>
							<FC>ID=VEND_NM,	     Name=거래처명,				width=160,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,     	edit=none  sort = true</FC>
							<FC>ID=VEND_ID,	     Name=사업자번호,		    width=90,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,   	edit=none, sort=true</FC>
							<C> ID=VD_DIRECT,	 Name=대표자,			    width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,			edit=none  sort = true show = true </C>
							<C> ID=BSNS_CND,	 Name=업태,	           		width=100,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,			edit=none  sort = true show = true </C>
							<C> ID=BSNS_KND,	 Name=업종,	            	width=100,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,			edit=none  sort = true show = true </C>
							<C> ID=COCOMYN,	     Name=업체구분,	        	width=100,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,			edit=none  sort = true EditStyle=Combo, Data='N:일반업체,T:간이과세업체,M:면세업체', show = true </C>
							<C> ID=STATUS		 Name=상태,			    	width=100,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,     	edit=none, sort = true, EditStyle=Combo, Data='N:대기,R:승인요청,Y:완료,B:반송', show = true </C>
						    <C> ID=SB_REASON,    Name=반송사유,	        	width=100,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,			edit=none  sort = true show = true </C>
						    <C> ID=REAL_FILE4,   Name=사업자등록증,        	width=130,    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,			edit=none  sort = true show = true </C>
							<C> ID=REAL_FILE3,   Name=등기부등본,         	width=130,     HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=REAL_FILE2,   Name=완납증명서,         	width=130,     HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=REAL_FILE1,   Name=기타,             	width=130,     HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
						">
					 </object></comment><script>__ws__(__NSID__);</script> 
				</td>
			  </tr>
			 </table>

			</td>
			<td>
				<!--입력창 -->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:310px;height:400px;border:1 solid #708090;">
				<tr>
					<td width="100px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;등록번호</nobr></td>
					<td Style="height:20px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:0px;top:3px;">		
						<param name=Text		   value="">
						<param name=Alignment      value=0>
						<param name=Border         value=true>
						<param name=Numeric        value=false>
						<param name=Format         value="###-##-#####">
						<param name=PromptChar     value="">
						<param name=BackColor      value="#CCCCCC">  
						<param name=InheritColor   value=false>
						<param name=readOnly       value=true>
						<param name=ReadOnlyBackColor   value="#d7d7d7">
						
					   </object></comment><script>__ws__(__NSID__);</script> </nobr>
					   <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" alt="등록번호를 검색 확인" style="position:relative;left:3px;top:3px;cursor:hand;" onclick="ln_Find2()">&nbsp;<font color="#ff0000">중복체크</font>					
					</td>
				</tr>
				
				<tr>
				   <td style="width:100px;height:25px;" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;거래처코드 </nobr></td>               
					<td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_cd" class="txtbox" type="text" style="width:100px;position:relative;left:-7px;top:0px;background-color:#d7d7d7"    ReadOnly>
					</td>
				</tr>
				
				<tr>
					<td style="width:100px;height:25px;" bgcolor="#eeeeee"  class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;거래처명 </nobr></td>               
					<td Style="width:200px;height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_nm" class="txtbox" type="text" style="width:190px;position:relative;left:-7px;top:0px"   >
					</td>
				</tr>
				
				
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;대표자명</nobr></td>
					<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_vd_direct"   type="text"   class="txtbox"  style= "position:relative;left:5px;width:100px;height:20px;">
					</nobr></td>
				</tr>
					<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;업태</nobr></td>
						  <td class="tab13" style="text-align:left"><nobr>
						<input id="txt_bsns_cnd"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:190px;height:20px;">
						</nobr></td>
					</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;업종</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_bsns_knd"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:190px;height:20px;">
						</nobr></td>
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;업체구분</nobr></td>
						<td class="tab13" style="text-align:left"><nobr><comment id="__NSID__">
						 		<object id=gclx_cocomyn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:5px;top:2px;font-size:12px;width:100px;">
											<param name=CBData			     value="N^일반업체,T^간이과세업체,M^면세업체">
											<param name=CBDataColumns	     value="CODE,NAME">
											<param name=SearchColumn	     value=NAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat       value="NAME">								
											<param name=BindColumn		     value="CODE">
								</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
					    <!-- <a href="Javascript:link_1('https://www.hometax.go.kr/websquare/websquare.wq?w2xPath=/ui/pp/index.xml&tmIdx=0&tm2lIdx=&tm3lIdx=')"><font color="blue"><b>과세유형조회</b></font></a> -->
					    <a href="Javascript:link_1('https://teht.hometax.go.kr/websquare/websquare.html?w2xPath=/ui/ab/a/a/UTEABAAA13.xml')"><font color="blue"><b>과세유형조회</b></font></a>
						</nobr> </td>
				</tr>
				
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;우편번호</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_post_no1"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:30px;height:20px;top:2px;background-color:#d7d7d7"" readOnly="true";>&nbsp;~
						<input id="txt_post_no2"    type="text"   class="txtbox"  style= "position:relative;left:0px;width:30px;height:20px;top:2px;background-color:#d7d7d7"" readOnly="true";>
						<!-- <img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="우편번호를 검색합니다" style="cursor:hand;position:relative;left:1px;top:0px" align=center onclick="ln_Popup('c')">&nbsp;			 
						</nobr> 예)000-000  --> 
						<input type="button" onclick="openDaumPostcode()"  style="position:relative;top:0px;width:100px" value="우편번호 찾기">&nbsp;
						</td>
				</tr>
				
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left  readOnly="true";><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;주소</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_address1"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:190px;height:20px;">
						</nobr> </td>
				</tr>
				
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;기타주소</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_address2"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:190px;height:20px;">
						</nobr> </td>
				</tr>
				
				<tr>
						<td width="80px" height="35px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;&nbsp;전화번호</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_vd_telno"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:100px;height:20px;">
						</nobr> 예)000-0000-0000 </td> 
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;&nbsp;팩스번호</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_vd_faxno"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:100px;height:20px;">
						</nobr> 예)000-0000-0000 </td>
				</tr>		
				<!--
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left><nobr>&nbsp;&nbsp;&nbsp;사용유무</nobr></td>
						<td  class="tab13" style="text-align:left">&nbsp;
							<comment id="__NSID__">
							<object id=gcra_use_tag classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0	style="position:relative;left:-6px;top:2px;width:114px;height:20px;">
								<param name=Cols	value="2">
								<param name=Format	value="Y^사용,N^미사용">
								<param name=Enable 	value="false">
								<param name=Enable 	value="false">
								
							</object></comment><script>__ws__(__NSID__);</script> 
						</td> 
				</tr>
				-->
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left><nobr>&nbsp;&nbsp;&nbsp;비고</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_remark"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;" ; >
						</nobr></td>
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;&nbsp;등록자</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_wrid"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true";>
						</nobr></td>
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left><nobr>&nbsp;&nbsp;&nbsp;등록일시</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_wrdt"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
				</tr>
				
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;상태</nobr></td>
						<td class="tab13" style="text-align:left"><nobr><comment id="__NSID__">
						 		<object id=gclx_status classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:5px;top:2px;font-size:12px;width:100px;">
											<param name=CBData			     value="N^대기,R^승인요청,Y^완료,B^반송">
											<param name=CBDataColumns	     value="CODE,NAME">
											<param name=SearchColumn	     value=NAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat       value="NAME">								
											<param name=BindColumn		     value="CODE">
											<param name=Enable               value="false">
								</object></comment><script>__ws__(__NSID__);</script> 
						</nobr> </td>
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left><nobr>&nbsp;&nbsp;&nbsp;반송사유</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_sb_reason"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
				</tr>
			  </table>
		 </td>
		 </tr>
		</table>
	<tr>
		<td colspan="2" height="24" align="left">조회건수 : <label id="lbl_search">
		</label></td>
    </tr>
    
    <form name="fileForm" method="post" enctype="multipart/form-data" align="absmiddle"  >
    <input type="hidden" name="realFileName">
	<input type="hidden" name="virtualFileName">
	<input type="hidden" name="mode"> 
	<input type="hidden" name="file_position"> 
    
    
    <tr>
		<td colspan="2" >
	     
    	<table cellpadding="0" cellspacing="0" style="width:868px;height:30px;font-size:9pt;border:1 solid #708090;">
	    <tr>
	    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>사업자등록증</nobr> </td>
			<td class="tab22">
				<input type="file"  name="filename4"   style="position:relative;left:4px;top:0px;width:536px;height:20px" >&nbsp;
				<!-- <img src="<%=dirPath%>/Omsm/images/FileAddOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileUpload('1')"> 
				<!-- <img src="<%=dirPath%>/Omsm/images/FileDelOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileDelete()"> -->
			</td>	
	    </tr>
	     
	    <tr>
	    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>등기부등본</nobr> </td>
			<td class="tab22" >
				<input type="file"  name="filename3"  style="position:relative;left:4px;top:0px;width:536px;height:20px" >&nbsp;
				<!--<img src="<%=dirPath%>/Omsm/images/FileAddOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileUpload('2')">-->
				<!--<img src="<%=dirPath%>/Omsm/images/FileDelOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileDelete()">-->
			</td>
	    </tr>
	    <tr>
	    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>완납증명서</nobr> </td>
			<td class="tab22" >
				<input type="file"  name="filename2"  style="position:relative;left:4px;top:0px;width:536px;height:20px" >&nbsp;
				<!--<img src="<%=dirPath%>/Omsm/images/FileAddOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileUpload('3')">-->
				<!--<img src="<%=dirPath%>/Omsm/images/FileDelOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileDelete()">-->
			</td>
	    </tr>
	    <tr>
	    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>기타</nobr> </td>
			<td class="tab22" >
				<input type="file"  name="filename1"  style="position:relative;left:4px;top:0px;width:536px;height:20px" >&nbsp;
				<!--<img src="<%=dirPath%>/Omsm/images/FileAddOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileUpload('4')">-->
				<!--<img src="<%=dirPath%>/Omsm/images/FileDelOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileDelete()">-->
			</td>
	    </tr>
	    
	    <tr>
	    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>첨부파일</nobr> </td>
			<td class="tab22" >
				<select multiple name="fileList" id="fileList" style="position:relative;left:4px;top:2px; width:400px;height:70px;border-color:#666666;background-color:#FFFOFO;font-weight:bold;">
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


<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='

		<C>Col=VEND_ID,     Ctrl=gcem_vend_id   Param=text		  </C>
		<C>Col=VEND_CD,     Ctrl=txt_vend_cd    Param=value		  </C>
		<C>Col=VEND_NM,     Ctrl=txt_vend_nm  	Param=value		  </C>
		<C>Col=VD_DIRECT,   Ctrl=txt_vd_direct  Param=value		  </C>
		<C>Col=BSNS_CND,    Ctrl=txt_bsns_cnd   Param=value		  </C>
		<C>Col=BSNS_KND,  	Ctrl=txt_bsns_knd   Param=value		  </C>
		<C>Col=VD_TELNO,  	Ctrl=txt_vd_telno   Param=value		  </C>
		<C>Col=VD_FAXNO,  	Ctrl=txt_vd_faxno   Param=value		  </C>
		<C>Col=POST_NO1,  	Ctrl=txt_post_no1   Param=value		  </C>
		<C>Col=POST_NO2,  	Ctrl=txt_post_no2   Param=value		  </C>
		<C>Col=ADDRESS1,  	Ctrl=txt_address1 	Param=value		  </C>
		<C>Col=ADDRESS2,  	Ctrl=txt_address2   Param=value  	  </C>
		<C>Col=COCOMYN,   	Ctrl=gclx_cocomyn   Param=bindcolval  </C>

		<C>Col=REMARK,    	Ctrl=txt_remark     Param=value		  </C>
		<C>Col=WRID,      	Ctrl=txt_wrid     	Param=value		  </C>
		<C>Col=WRDT,      	Ctrl=txt_wrdt     	Param=value		  </C>
		<C>Col=STATUS,   	Ctrl=gclx_status 	Param=bindcolval  </C>
		<C>Col=SB_REASON,   Ctrl=txt_sb_reason  Param=value       </C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe type="hidden" id="ifrm" name="ifrm" src ="../../Person/html/GP_form.html" frameborder=1 style="width:1;height:1px;border:0 solid #708090;"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



