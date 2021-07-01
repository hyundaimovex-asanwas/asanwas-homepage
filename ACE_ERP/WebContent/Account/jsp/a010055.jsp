<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 업체수정요청 (사용자) 
+ 프로그램 ID	: a010055.jsp
+ 기 능 정 의	: 업체수정요청 
+ 최 초 이 력	: 
+ 변 경 이 력	: 
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
+ 수 정 내 용  : 우편번호변경
+ 수   정  자  :  정 영 식 
+ 수 정 일 자  : 2016.03.09
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a010055_s1, a010055_t1
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

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
    gcra_usegb_0.codevalue="1";
    gcra_usegb_2.codevalue="1";
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	
    //사업자등록번호 또는 거래처명 필수항목 입력해야 함. 	
    if(gcem_vend_cd_0.text =="" && gcem_vend_nm_0.text=="" && gcem_vend_id_0.text=="" ){
    	alert("거래처코드 또는 거래처명 또는 사업자(주민)번호 중 한개는 필수 항목입니다.");
    	return false;
    }
    
 
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010055_s0?v_str1="+gcem_vend_cd_0.text
                                                                        +"&v_str2="+gcem_vend_nm_0.text
                                                                        +"&v_str3="+gcem_vend_id_0.text             	
                                                                        +"&v_str4="+gcra_usegb_0.codevalue;     	
	                                                                                                                                                                                                                                                       
    //prompt('',gcds_data.DataID);
	gcds_data.Reset();
	
	gcds_data_md.ClearAll();
}

/******************************************************************************
Description : 수정내역조회
******************************************************************************/
function ln_MD_Query(){
	if(gcem_vend_id_2.text==""){
		alert("사업자(주민)등록번호는 필수 검색조건입니다.");
		return false;
	}
	
	gcds_data_md.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010055_s1?v_str1="+gs_userid
			                                                            +"&v_str2="+gcem_vend_nm_2.text
                                                                        +"&v_str3="+gcem_vend_id_2.text             	
                                                                        +"&v_str4="+gcra_usegb_2.codevalue    
	                                                                    +"&v_str5=";
	gcds_data_md.Reset();
}


/******************************************************************************
Description : 수정내역체크 조회
******************************************************************************/
function ln_MD_Chk_Query(){
	
	
	gcds_data_md_chk.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010055_s1?v_str1="+gs_userid
																			    +"&v_str2="+gcem_vend_nm_2.text
																			    +"&v_str3="+gcem_vend_id_2.text             	
																			    +"&v_str4="+gcra_usegb_2.codevalue    
																			    +"&v_str5=C";
	gcds_data_md_chk.Reset();
	
	if(gcds_data_md_chk.countrow>0){
		return false;
	}else{
		return true;
	}
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){
		
	//등록시점에 승인요청 또는 대기 건이 있으면 등록 안되게 막음. 	
	if (!ln_MD_Chk_Query()){
		alert("기존 수정내역이 존재합니다. 확인 바랍니다.");
		return false;
	} 

    //addrow는 한번만 가능함. 		
	var irow =0;	
	ln_SetDataHeader();
	gcds_data_md.addrow();	
	
	irow =gcds_data_md.RowPosition; 
	orow =gcds_data.RowPosition 
	
	gcds_data_md.namevalue(irow,"VEND_CD") = txt_vend_cd.value;
	gcds_data_md.namevalue(irow,"VEND_ID") = gcem_vend_id.text;
	gcds_data_md.namevalue(irow,"SEQ") =  gcds_data_md.Max(4,0,0)+1;
	gcds_data_md.namevalue(irow,"A_VEND_NM")  = txt_vend_nm.value;
	gcds_data_md.namevalue(irow,"A_VD_DIRECT")= txt_vd_direct.value;
	gcds_data_md.namevalue(irow,"A_POST_NO1") = txt_post_no1.value;
	gcds_data_md.namevalue(irow,"A_POST_NO2") = txt_post_no2.value;
	gcds_data_md.namevalue(irow,"A_ADDRESS1") = txt_address1.value;
	gcds_data_md.namevalue(irow,"A_ADDRESS2") = txt_address2.value;
	gcds_data_md.namevalue(irow,"A_COCOMYN")  = gclx_cocomyn.bindcolval;
	
	//변경전데이터 
	gcds_data_md.namevalue(irow,"B_VEND_NM")  = gcds_data.OrgNameValue(orow,"VEND_NM");
	gcds_data_md.namevalue(irow,"B_VD_DIRECT")= gcds_data.OrgNameValue(orow,"VD_DIRECT");
	gcds_data_md.namevalue(irow,"B_POST_NO1") = gcds_data.OrgNameValue(orow,"POST_NO1");
	gcds_data_md.namevalue(irow,"B_POST_NO2") = gcds_data.OrgNameValue(orow,"POST_NO2");
	gcds_data_md.namevalue(irow,"B_ADDRESS1") = gcds_data.OrgNameValue(orow,"ADDRESS1");
	gcds_data_md.namevalue(irow,"B_ADDRESS2") = gcds_data.OrgNameValue(orow,"ADDRESS2");
	gcds_data_md.namevalue(irow,"B_COCOMYN")  = gcds_data.OrgNameValue(orow,"COCOMYN");
	
	gcds_data_md.namevalue(irow,"STATUS") = "N"; 
	gcds_data_md.namevalue(irow,"WRID") =gs_userid;
	gcds_data_md.namevalue(irow,"UPID") =gs_userid;

	if(gcds_data_md.namevalue(irow,"B_VEND_NM")==gcds_data_md.namevalue(irow,"A_VEND_NM")&&
	   gcds_data_md.namevalue(irow,"B_VD_DIRECT")==gcds_data_md.namevalue(irow,"A_VD_DIRECT")&&
	   gcds_data_md.namevalue(irow,"B_POST_NO1")==gcds_data_md.namevalue(irow,"A_POST_NO1")&&
	   gcds_data_md.namevalue(irow,"B_POST_NO2")==gcds_data_md.namevalue(irow,"A_POST_NO2")&&
	   gcds_data_md.namevalue(irow,"B_ADDRESS1")==gcds_data_md.namevalue(irow,"A_ADDRESS1")&&
	   gcds_data_md.namevalue(irow,"B_ADDRESS2")==gcds_data_md.namevalue(irow,"A_ADDRESS2")&&
	   gcds_data_md.namevalue(irow,"B_COCOMYN")==gcds_data_md.namevalue(irow,"A_COCOMYN")
	){
	   alert("수정사항이 존재하지 않습니다.\n\n[수정내역입력]에서 데이터 수정 후 [등록] 버튼을 누르십시요.");
	   gcds_data_md.UndoAll();
	}
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
	
    //거래처 		
		
	//if(!ln_Chk_Save())return;
	if (gcds_data_md.IsUpdated) {
	    //if(!ln_Chk_Save_Status())return;
	
		if (confirm("입력하신 사항을 등록하시겠습니까?")){	
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010055_t1";
			gctr_data.Parameters = "v_str1="+gs_userid;
		
			//prompt(this, gcds_data_md.text);
			gctr_data.post();
		    //ln_Query();
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
		gcds_data_md.DeleteMarked();
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010055_t1";
		gctr_data.Parameters = "v_str1="+gs_userid;
		
		//prompt('',gcds_data_md.text);
		gctr_data.post();
		ln_Query();
	}	
}


/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
function ln_Chk_Save() {

  //상태값이 대기 일경우만 가능 

   for(i=1;i<=gcds_data_md.countrow;i++){
   		if(gcds_data_md.SysStatus(i)=="1"){
   		
   			if(gcds_data.namevalue(i,"VEND_ID") == ""){//사업자등록번호
				alert("등록번호가 존재하지 않습니다.");
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
			
			if(fn_trim(gcds_data.namevalue(i,"POST_NO1")) == "" && fn_trim(gcds_data.namevalue(i,"POST_NO2")) ){ //우편번호				
				alert("우편번호를  입력하세요 .");
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
			
			if(fn_trim(gcds_data.namevalue(i,"COCOMYN")) == "" ){ //협력업체구분				
				alert("협력업체구분을  입력하세요 .");
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
	gcds_data_md.undo(gcds_data_md.rowposition);
}

/******************************************************************************
	Description : 승인요청
******************************************************************************/
function ln_AppReq(){
    //상태값 체크 : 대기 반송 상태만 요청 가능함 
    if(!ln_Chk_Status()) return false;
	if (confirm(" 해당 거래처 수정 승인 요청 하시겠습니까?")){	
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010055_t1";
		gctr_data.Parameters = "v_str1="+gs_userid;
		//prompt('',gcds_data_md.text);
		gctr_data.post();
		ln_Query();
	}	
}

/******************************************************************************
	Description : 상태값 체크 
******************************************************************************/
function ln_Chk_Save_Status(){
	for(var i =1; i<=gcds_data_md.countrow;i++){
		//alert("gcds_data.SysStatus(i)::"+gcds_data.SysStatus(i));
		if(gcds_data_md.SysStatus(i)==3){
			if(gcds_data_md.namevalue(i,"STATUS")!="N"&&gcds_data_md.namevalue(i,"STATUS")!="B"){
				alert(gcds_data_md.namevalue(i,"VEND_ID")+"은 수정 가능건이 아닙니다.");
				return false;
			}
		}
	}
	return true;
}

/******************************************************************************
	Description : 상태값 체크 
******************************************************************************/
function ln_Chk_Status(){
    var vcnt=0;
	for(var i=1; i<=gcds_data_md.countrow;i++){
		if(gcds_data_md.namevalue(i,"CHK")=="T"){
			if(gcds_data_md.namevalue(i,"STATUS")!="N"&&gcds_data_md.namevalue(i,"STATUS")!="B"){
				alert(gcds_data_md.namevalue(i,"VEND_ID")+" 순번:"+gcds_data_md.namevalue(i,"SEQ")+ "은 요청 가능건이 아닙니다.");
				return false;
			}else{
				gcds_data_md.namevalue(i,"STATUS")="R"; 
			}
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
	Description : 상태값 체크 삭제
******************************************************************************/
function ln_Chk_Delete_Status(){
    var vcnt=0;
	for(var i =1; i<=gcds_data_md.countrow;i++){
		if(gcds_data_md.namevalue(i,"CHK")=="T"){
			if(gcds_data_md.namevalue(i,"STATUS")=="R"||gcds_data_md.namevalue(i,"STATUS")=="Y"){
				alert(gcds_data_md.namevalue(i,"VEND_ID") +" 순번:"+gcds_data_md.namevalue(i,"SEQ") + " 은  삭제 가능건이 아닙니다.");
				return false;
			}
			gcds_data_md.MarkRows(i,i);
			
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
	Description : 출력
******************************************************************************/
function ln_Print(){

}


/******************************************************************************
	Description : 문자열체크
******************************************************************************/


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
		var THeader = "CHK:STRING,VEND_CD:STRING,VEND_NM:STRING,VEND_ID:STRING,VEND_NO:STRING,VD_DIRECT:STRING,"
					+ "BSNS_CND:STRING,BSNS_KND:STRING,VD_TELNO:STRING,VD_FAXNO:STRING,POST_NO1:STRING,"
					+ "POST_NO2:STRING,ADDRESS1:STRING,ADDRESS2:STRING,"
					+ "USE_TAG:STRING,"
					+ "REMARK:STRING,CREAT_DT:STRING,CREAT_NM:STRING,MSN:STRING,MPWD:STRING,"
					+ "COCOMYN:STRING,H_VEND_CD:STRING,H_VEND_NM:STRING,IUGB:STRING,"
					+ "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
					+ "STATUS:STRING,RQID:STRING,RQDT:STRING,CFID:STRING,CFDT:STRING,BSID:STRING,BSDT:STRING";
		gcds_data.SetDataHeader(THeader);						
	}
	
	if(gcds_data_md.countrow<1){
		var THeader = "CHK:STRING,VEND_CD:STRING,VEND_ID:STRING,SEQ:DECIMAL,"
					+ "B_VEND_NM:STRING,B_VD_DIRECT:STRING,B_POST_NO1:STRING,B_POST_NO2:STRING,B_ADDRESS1:STRING,B_ADDRESS2:STRING,B_COCOMYN:STRING,"
					+ "A_VEND_NM:STRING,A_VD_DIRECT:STRING,A_POST_NO1:STRING,A_POST_NO2:STRING,A_ADDRESS1:STRING,A_ADDRESS2:STRING,A_COCOMYN:STRING,"
					+ "STATUS:STRING,WRID:STRING,UPID:STRING";
		gcds_data_md.SetDataHeader(THeader);						
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




<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!-- 수정내역 -->
<object  id=gcds_data_md classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_data_md_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a010055_t1(I:USER=gcds_data_md)">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_data" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
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
//		ln_Query();
	}

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";
</script>


<script language=JavaScript  for=gcds_data_md event=OnLoadCompleted(rowcount)>//총 조회 건수
	window.status="조회가 완료 되었습니다.";
	
	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	}
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcra_usegb_0 event=OnSelChange()>

	if(gcra_usegb_0.codevalue=="1"){ //
		gcem_vend_id_0.Format = "000-00-00000";        //법인 
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
		gcem_vend_id.Format = "000-00-00000";        //법인 
		gcem_vend_id_2.Format = "000-00-00000";      //법인 
	}else if(intChk==13){
		gcem_vend_id.Format = "000000-0000000";      //개인 
		gcem_vend_id_2.Format = "000000-0000000";    //개인
	}
	
	gcem_vend_id.text   = gcds_data.namevalue(row,"VEND_ID");
	gcem_vend_id_2.text = gcds_data.namevalue(row,"VEND_ID");
</script>

<script language=JavaScript for=gcds_data event=OnRowPosChanged(row)>

	var intChk=0;
    if (row>=1){
    	intChk = gcds_data.namevalue(row,"VEND_ID").length;
    }
      
	if(intChk==10){ //
		gcem_vend_id.Format = "000-00-00000";      //법인 
		gcem_vend_id_2.Format = "000-00-00000";    //법인
	}else if(intChk==13){
		gcem_vend_id.Format = "000000-0000000";    //개인 
		gcem_vend_id_2.Format = "000000-0000000";  //개인 
	}
	gcem_vend_id.text = gcds_data.namevalue(row,"VEND_ID");
	gcem_vend_id_2.text = gcds_data.namevalue(row,"VEND_ID");
</script>

<script language=JavaScript for=gcgd_pyo2 event=OnClick(row,colid)>
   if(colid =="CHK"){
	   if(gcds_data_md.namevalue(row,"STATUS")!="N"){
		   alert("상태가 선택 불가능합니다.");
		   gcds_data_md.namevalue(row,"CHK")="F";
	   }
   }
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
    	<td height="30" align=right>   
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
    </tr>
	<tr>
	 	<td>
			<table  cellpadding="0" cellspacing="0" style="width:868px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr> 
					<td width="80px" align=center  bgcolor="#eeeeee" class="tab15" rowspan=2 >검색조건</td>
					<td class="tab18" width="90px;" bgcolor="#eeeeee" align="center">거래처코드</td>
					<td width="90px" class="tab18" align=CENTER><comment id="__NSID__">
					<object  id=gcem_vend_cd_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:80px" >
						<param name=Text				    value="">
						<param name=Alignment			value=0>
						<param name=Border				value=true>
						<param name=GeneralEdit		value="true">
						<param name=PromptChar		value="_">
					</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab14" width="90px;" bgcolor="#eeeeee" align="center">거래처명</td>
					<td width="400px" class="tab24" align="left" ><comment id="__NSID__">
						<object  id=gcem_vend_nm_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:165px" >
						<param name=Text			        value="">
						<param name=Alignment		    value=0>
						<param name=Border			    value=true>
						<param name=GeneralEdit		value="true">
						<param name=PromptChar		value="_">
					</object></comment><script>__ws__(__NSID__);</script>
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
							<param name=Text		   value="">
							<param name=Alignment      value=0>
							<param name=Border         value=true>
							<param name=Numeric        value=false>
							<param name=Format         value="000-00-00000">
							<param name=PromptChar     value="">
							<param name=BackColor      value="#CCCCCC">
							<param name=InheritColor   value=false>
							<param name=readOnly       value=false>
					   </object></comment><script>__ws__(__NSID__);</script>
					</td>
				
				</tr> 
			</table>
		</td>
	<tr>
		<td>
			<table>
				<tr>
					<td>
						<!--Grid-->
						<table cellpadding="0" cellspacing="0"  style="position:relative;left:-3px;width:250px;border:0 solid #708090;">
							<tr> 			
								<td ALIGN=LEFT VALIGN=TOP>
									<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo style="WIDTH:866px;HEIGHT:200px;border:1 solid #777777;display:block;" viewastext>
			 						 <PARAM NAME="DataID"			VALUE="gcds_data">
									 <PARAM NAME="BorderStyle"  VALUE="0">
									 <PARAM NAME="Indwidth"		VALUE="0">
									 <PARAM NAME="Fillarea"		    VALUE="true">
									 <PARAM NAME="ColSizing"		VALUE="true">
									 <param name="sortview"         value=left>
									 <param name="Editable"     	value='true'>
									 <param name=UsingOneClick  value="1">
								     <PARAM NAME="Format"			VALUE="    
										<FC>ID=VEND_CD,	     Name=거래처코드,		    width=75,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = true</FC>
										<FC>ID=VEND_ID,	     Name=사업자번호,		    width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none, sort = true</FC>
										<FC>ID=VEND_NM,	     Name=거래처명,			width=150,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    edit=none  sort = true</FC>
										<C> ID=VD_DIRECT,	 Name=대표자,			    width=60,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  sort = true show = true </C>
										<C> ID=BSNS_CND,	 Name=업태,	            width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  sort = true show = true </C>
										<C> ID=BSNS_KND,	 Name=업종,	            width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  sort = true show = true </C>
										<C> ID=ADDRESS1,	 Name=주소,	            width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  sort = true show = true </C>
										<C> ID=ADDRESS2,	 Name=상세주소,	        width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  sort = true show = true </C>
										<C> ID=COCOMYN,	     Name=업체구분,	        width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  sort = true EditStyle=Combo, Data='N:일반업체,T:간이과세업체,M:면세업체', show = true </C>
										<C> ID=STATUS		 Name=상태,			    width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    edit=none,	sort = true, EditStyle=Combo, Data='N:대기,R:승인요청,Y:완료,B:반송', show = true </C>
									">
								 </object></comment><script>__ws__(__NSID__);</script> 
								</td>
							 </tr>
					 	</table>
					</td>
	 			</tr>
			</table>
		</td>
	<tr>
		<td  height="24" align="left">조회건수 : <label id="lbl_search"></label></td>
    </tr>
    
    <tr>
		<td height="30" align="left"><strong><font size="2" color="blue"> [수정내역입력]</font></strong></td>
    </tr>	
    <tr>
    	<td>
			<!--입력창 -->
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:866px;height:100px;border:1 solid #708090;">
				
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;등록번호</nobr></td>
					<td Style="height:20px;border:0 solid #708090;border-bottom-width:1px" colspan =5><nobr>&nbsp;<comment id="__NSID__">
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
					</td>
				</tr>
				<tr>
				    <td style="width:80px;height:25px;" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;거래처코드 </nobr></td>               
					<td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_cd" class="txtbox" type="text" style="width:100px;position:relative;left:-7px;top:0px;background-color:#d7d7d7"    ReadOnly>
					</td>
					<td style="width:80px;height:25px;" bgcolor="#eeeeee"  class="tab30" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;거래처명 </nobr></td>               
					<td Style="width:200px;height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_nm" class="txtbox" type="text" style="width:190px;position:relative;left:-7px;top:0px"   >
					</td>			
				
				
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab30" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;대표자명</nobr></td>
					<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_vd_direct"   type="text"   class="txtbox"  style= "position:relative;left:5px;width:100px;height:20px;">
					</nobr>
					</td>
				</tr>
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;우편번호</nobr></td>
					<td class="tab13" style="text-align:left" ><nobr>
						<input id="txt_post_no1"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:30px;height:20px;top:1px;background-color:#d7d7d7"" readOnly="true";>&nbsp;~
						<input id="txt_post_no2"    type="text"   class="txtbox"  style= "position:relative;left:0px;width:30px;height:20px;top:1px;background-color:#d7d7d7"" readOnly="true";>
						<!-- <img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="우편번호를 검색합니다" style="cursor:hand;position:relative;left:1px;top:0px" align=center onclick="ln_Popup('c')">&nbsp;			 
						</nobr> 예)000-000
						-->
						<input type="button" onclick="openDaumPostcode()"  style="position:relative;top:0px;width:100px" value="우편번호 찾기">&nbsp;
					</td>
					<td style="width:80px;height:25px;" bgcolor="#eeeeee"  class="tab30" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;업체구분 </nobr></td>   
					<td class="tab13" style="text-align:left" colspan =3>
					<nobr><comment id="__NSID__">
						 		<object id=gclx_cocomyn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:5px;top:2px;font-size:12px;width:100px;">
											<param name=CBData			         value="N^일반업체,T^간이과세업체,M^면세업체">
											<param name=CBDataColumns	     value="CODE,NAME">
											<param name=SearchColumn	     value=NAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat       value="NAME">								
											<param name=BindColumn		     value="CODE">
								</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
					    <a href="Javascript:link_1('https://www.hometax.go.kr/websquare/websquare.wq?w2xPath=/ui/pp/index.xml&tmIdx=0&tm2lIdx=&tm3lIdx=')"><font color="blue"><b>과세유형조회</b></font></a>
						</nobr>
					</td>
					
				</tr>
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left  readOnly="true";><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;주소</nobr></td>
					<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_address1"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:280px;height:20px;">
						</nobr> 
					</td>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab30" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;기타주소</nobr></td>
					<td class="tab13" style="text-align:left"  colspan=3 ><nobr>
						<input id="txt_address2"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:380px;height:20px;">
						</nobr> 
					</td>
				</tr>	
			  </table>
		 </td>
    </tr>
    
    <tr>
		<td> 
			<table  cellpadding="0" cellspacing="0" style="width:868px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr>
					<td  height="24" align="left"><strong><font size="2" color="blue"> [수정내역조회]</font></strong></td>
					<td height="30" align=right>   
			            <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_appreq.gif"	style="cursor:hand" onclick="ln_AppReq()" >&nbsp;&nbsp;
			    
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	    style="cursor:hand" onclick="ln_Add()" >
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"		style="cursor:hand" onclick="ln_Delete()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_cancle.gif"      style="cursor:hand" onclick="ln_Cancel()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_MD_Query()">&nbsp;
					</td>
					
				</tr>
			</table>
		</td>
    </tr>	
    <tr>
    	<td>
			 <table  cellpadding="0" cellspacing="0" style="width:868px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr> 
					<td class="tab15" width="90px;" bgcolor="#eeeeee" align="center">번호구분</td>
					<td width="160px" class="tab18" ><comment id="__NSID__">
						<object id=gcra_usegb_2 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:160px;height:20px" >
							<param name=Cols	value="2">
							<param name=Format	value="1^사업자번호,2^주민번호">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
				
					<td class="tab14" width="90px;" bgcolor="#eeeeee" align="center">번호</td>
					<td width="90px" class="tab24"   Style="height:20px;;"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gcem_vend_id_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:-2px;top:3px">		
							<param name=Text		   value="">
							<param name=Alignment      value=0>
							<param name=Border         value=true>
							<param name=Numeric        value=false>
							<param name=Format         value="000-00-00000">
							<param name=PromptChar     value="">
							<param name=BackColor      value="#CCCCCC">
							<param name=InheritColor   value=false>
							<param name=readOnly       value=true>
						    <param name=ReadOnlyBackColor   value="#d7d7d7">
					   </object></comment><script>__ws__(__NSID__);</script>
					</td>
					
					<td class="tab14" width="90px;" bgcolor="#eeeeee" align="center">거래처명</td>
					<td width="400px" class="tab24" align="left" ><comment id="__NSID__">
						<object  id=gcem_vend_nm_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:165px" >
						<param name=Text			        value="">
						<param name=Alignment		    value=0>
						<param name=Border			    value=true>
						<param name=GeneralEdit		    value="true">
						<param name=PromptChar		    value="_">
						<param name=readOnly       value=true>
						<param name=ReadOnlyBackColor   value="#d7d7d7">
					</object></comment><script>__ws__(__NSID__);</script>
					</td>
				
				</tr> 
			</table>
    	</td>
    </tr>
    
    <tr> 			
		<td ALIGN=LEFT VALIGN=TOP>
			<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo2 style="WIDTH:866px;HEIGHT:200px;border:1 solid #777777;display:block;" viewastext>
				 <PARAM NAME="DataID"	VALUE="gcds_data_md">
			 <PARAM NAME="BorderStyle"  VALUE="0">
			 <PARAM NAME="Indwidth"		VALUE="0">
			 <PARAM NAME="Fillarea"		VALUE="false">
			 <PARAM NAME="ColSizing"	VALUE="true">
			 <param name="sortview"     value=left>
			 <param name="Editable"     value='true'>
			 <param name=UsingOneClick  value="1">
		     <PARAM NAME="Format"			VALUE="
		        <FC>ID=CHK,  	     Name=선택,		        width=30,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  editstyle=checkbox  </FC>    
				<FC>ID=VEND_CD,	     Name=거래처코드,		    width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = true </FC>
				<FC>ID=VEND_ID,	     Name=사업자번호,		    width=90,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none, sort = true  </FC>
				<FC>ID=SEQ,	         Name=순번,		        width=30,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none, sort = false </FC>
				<G> Name=수정내역,	 HeadBgColor=#B9D4DC, 
				<C> ID=A_VEND_NM,	 Name=거래처명,			width=120,	HeadBgColor=#B9D4DC, BgColor={IF(B_VEND_NM=A_VEND_NM,'FFFFFF','#FFCC66')},     align=left,   edit=none  sort = true</C>
				<C> ID=A_VD_DIRECT,	 Name=대표자,			    width=60,	HeadBgColor=#B9D4DC, BgColor={IF(B_VD_DIRECT=A_VD_DIRECT,'FFFFFF','#FFCC66')}, align=left,	 edit=none  sort = true show = true </C>
				<C> ID=A_POST_NO1,	 Name=우편,	            width=30,	HeadBgColor=#B9D4DC, BgColor={IF(B_POST_NO1=A_POST_NO1,'FFFFFF','#FFCC66')},   align=left,	 edit=none  sort = false show = true </C>
				<C> ID=A_POST_NO2,	 Name=번호,	            width=30,	HeadBgColor=#B9D4DC, BgColor={IF(B_POST_NO2=A_POST_NO2,'FFFFFF','#FFCC66')},   align=left,	 edit=none  sort = false show = true </C>
				<C> ID=A_ADDRESS1,	 Name=주소,	            width=140,	HeadBgColor=#B9D4DC, BgColor={IF(B_ADDRESS1=A_ADDRESS1,'FFFFFF','#FFCC66')},   align=left,	 edit=none  sort = true show = true </C>
				<C> ID=A_ADDRESS2,	 Name=상세주소,	        width=140,	HeadBgColor=#B9D4DC, BgColor={IF(B_ADDRESS2=A_ADDRESS2,'FFFFFF','#FFCC66')},   align=left,	 edit=none  sort = true show = true  </C>
				<C> ID=A_COCOMYN,	 Name=업체구분,	        width=70,	HeadBgColor=#B9D4DC, BgColor={IF(B_COCOMYN=A_COCOMYN,'FFFFFF','#FFCC66')},     align=left,	 edit=none  sort = true show = true  EditStyle=Combo, Data='N:일반업체,T:간이과세업체,M:면세업체'</C>
				</G>
				<C> ID=STATUS		 Name=상태,			    width=60,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    edit=none,	sort = true, EditStyle=Combo, Data='N:대기,R:승인요청,Y:완료,B:반송', show = true </C>
                <C> ID=B_VEND_NM,	 Name=거래처명,			width=120,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    edit=none  show = false </C>
				<C> ID=B_VD_DIRECT,	 Name=대표자,			    width=60,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  show = false </C>
				<C> ID=B_POST_NO1,	 Name=우편,	            width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  show = false </C>
				<C> ID=B_POST_NO2,	 Name=번호,	            width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  show = false </C>
				<C> ID=B_ADDRESS1,	 Name=주소,	            width=150,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  show = false </C>
				<C> ID=B_ADDRESS2,	 Name=상세주소,	        width=150,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  show = false </C>
 			">
			 </object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
</table>

<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=VEND_ID,     Ctrl=gcem_vend_id   Param=text		    </C>
		<C>Col=VEND_CD,     Ctrl=txt_vend_cd    Param=value		    </C>
		<C>Col=VEND_NM,     Ctrl=txt_vend_nm  	Param=value		    </C>
		<C>Col=VD_DIRECT,   Ctrl=txt_vd_direct  Param=value		    </C>
		<C>Col=POST_NO1,  	Ctrl=txt_post_no1   Param=value		    </C>
		<C>Col=POST_NO2,  	Ctrl=txt_post_no2 	Param=value		    </C>
		<C>Col=ADDRESS1,  	Ctrl=txt_address1 	Param=value		    </C>
		<C>Col=ADDRESS2,  	Ctrl=txt_address2   Param=value  	    </C>
		<C>Col=COCOMYN,  	Ctrl=gclx_cocomyn   Param=bindcolval    </C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe type="hidden" id="ifrm" name="ifrm" src ="../../Person/html/GP_form.html" frameborder=1 style="width:1;height:1px;border:0 solid #708090;"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



