<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* 시 스 템 명	: 정보보보>정보관리>배포관리>배포등록
* 프로그램 ID	: li0200i.jsp
* 기 능 정 의	: 배포등록
* 작  성   자 : 정 영 식
* 작 성 일 자 : 2011.10.21
-----------------------------------------------------------------------------
* 수 정 내 용 : 
* 수   정  자 :
* 수 정 일 자 : 
-----------------------------------------------------------------------------
* 서 블 릿 명	: 
* PROCEDURE 	: 
*******************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="security.common.*" %>

<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 변수 설정.
  String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. 
%>

<html>
<head>
<jsp:include page="/Security/common/include/head.jsp"/>
<title>배포등록</title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var sApproveLine="";

/******************************************************************************
	Description : 페이지 로딩
****************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
    fnInit();
    
    txt_own_dpt.value = gdeptcd;
    txt_own_dptnm.value = gdeptnm;
}

/******************************************************************************
	Description : 초기화 
****************************************************************************/
function fnInit(){
	ds_doc_grd.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=LI001&s_item1=Y";
    ds_doc_grd.Reset(); //문서등급
    
    ds_doc_frm.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=LI002&s_item1=Y";
    ds_doc_frm.Reset(); //문서형태
    
    ds_crt_div.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=LI003&s_item1=Y";
    ds_crt_div.Reset(); //생성구분
    
    ds_sgn_sts.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP002&s_item1=Y";
    ds_sgn_sts.Reset(); //결재상태
    
    ds_snd_div.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=LI005&s_item1=Y";
    ds_snd_div.Reset(); //발신구분
    
    ds_rcp_sts.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=LI004&s_item1=Y";
    ds_rcp_sts.Reset(); //수신열람
}

/******************************************************************************
	Description : 기등록문서 조회
******************************************************************************/
function fnSelect(){

     /** 이건은 의미 없음. ==> 결재대상건만 조회 가능하게 함 
     if(gcem_doc_mag_sid.text==""){
     	alert("관리번호 입력 후 조회 가능합니다.");
        return;
     }
     **/

	 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		              + ",v_doc_grd="+gclx_doc_grd.bindcolval
		              + ",v_doc_frm=" +gclx_doc_frm.bindcolval
		              + ",v_gdeptcd=" + txt_own_dpt.value
		              + ",v_doc_tle=" + gcem_doc_tle.text
		              + ",v_doc_cts=" + gcem_doc_cts.text
		              + ",v_doc_kwd=" + gcem_doc_kwd.text;       
		              
    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Li0200I",  "JSP(O:DS_DEFAULT=ds_default)",  param);
    //prompt('',ds_default.dataid);   
    tr_post(tr1);
  
}


/******************************************************************************
	Description : 배포정보 조회
******************************************************************************/
function fnSelect2(int_doc_mag_sid){

	 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		              + ",v_doc_mag_sid="+int_doc_mag_sid;
		              
    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Li0200I",  "JSP(O:DS_DEFAULT2=ds_default2)",  param);
    //prompt('',ds_default.dataid);   
    tr_post(tr1);

}



/******************************************************************************
	Description : 배포상세 조회
******************************************************************************/
function fnSelect3(){

     //doc_mag_sid 공백체크
      
     var srow;
  	
  	 //배포정보위치 확인 
	 for (var i=1; i<=ds_default2.countrow;i++){
   		if(ds_default2.namevalue(i,"CHK")=="T"){
         	srow = ds_default2.rowposition;
        }
    }
  
    fnDisplay(srow,"SND_DIV");  
     

	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                 + ",v_dtb_mag_sid="+gcem_dtb_mag_sid.text;
		              
    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Li0200I",  "JSP(O:DS_DEFAULT3=ds_default3)",  param);
    //prompt('',ds_default.dataid);   
    tr_post(tr1);

}

/******************************************************************************
	Description : 배포정보 행추가 
******************************************************************************/
function fnAddRow2(){
    
    if(gcem_doc_mag_sid.text==0 ||gcem_doc_mag_sid.text==""){
    	alert("등록번호를 선택하세요");
    	return;
    }
    
	if(ds_default2.CountRow==0){
		 fnSelect2("0");
	}
	
	ds_default2.addrow();
	ds_default2.namevalue(ds_default2.rowposition,"DOC_MAG_SID")=gcem_doc_mag_sid.text; //
	
}

/******************************************************************************
	Description : 저장
******************************************************************************/
 function fnApply2() {
    
    //alert("저장2::"+ds_default2.IsUpdated);
 
    if (ds_default2.IsUpdated) {
        if (fnChk()) {
            ln_TRSetting(tr2, "<%=dirPath%><%=HDConstant.PATH_LI%>Li0200I",  "JSP(I:DS_DEFAULT2=ds_default2 )",  "proType=A,dsType=1");
           // prompt('',ds_default.text);
            tr_post(tr2);
        }
    }
}

/******************************************************************************
	Description : 배포정보 취소
******************************************************************************/
 function fnCancel2() {           
    ds_defaul2.undoall();
    window.status="배포정보 입력이 취소되었습니다.";      
}


/******************************************************************************
	Description : 생성
******************************************************************************/
function fnCreate3(){

    //체크박스 체크 
   var chk_yn="N";
   var chk_cnt=0;
   var chk_dtb_mag_sid="";
   var chk_dtb_sgn_sts="";
   
   for (var i=1; i<=ds_default2.countrow;i++){
   		if(ds_default2.namevalue(i,"CHK")=="T"){
   			chk_yn="Y";	
   			chk_cnt = ds_default2.namevalue(i,"DTB_CNT");
   			chk_dtb_mag_sid=ds_default2.namevalue(i,"DTB_MAG_SID");
   			chk_dtb_sgn_sts=ds_default2.namevalue(i,"DTB_SGN_STS");
   		}
   } 
   
   if(chk_yn=="N"){
   		alert("배포정보를 선택하십시요.");
   		return ;
   }
   
   //배포부수 체크 
   if(chk_cnt==0){
   		alert("배포수를 입력하십시요.");
   		return;
   }
   
    //배포부수 체크 
   if(chk_dtb_mag_sid==0){
   		alert("배포번호가 없습니다. 배포 정보를 먼저 저장하십시요 ");
   		return;
   }
   
   
    //결재상태 체크
   if(chk_dtb_sgn_sts!="1"){
   		alert("결재상태가 작성중만 배포상세 생성 가능합니다.");
   		return;
   }
   
   
   ds_default3.ClearAll();
     
   if(ds_default3.CountRow==0){
   		fnSelect3(0);
   }
   
   
   if(ds_default3.CountRow>=1){
   	 alert("이미 배포상세가 등록 되었습니다.");
   	 return;	
   }
   
   
   //alert("ds_default3.CountRow::"+ds_default3.CountRow);
    
   for (var i=1; i<=ds_default2.countrow;i++){
   		if(ds_default2.namevalue(i,"CHK")=="T"){
   		     fnDisplay(i,"SND_DIV"); //
   			for(var j=1;j<=chk_cnt;j++ ){
   				fnAddrow3(i,j,ds_default2.namevalue(i,"SND_DIV") );
   			}	
   		}
   }
}

/******************************************************************************
	Description : 자동행추가  
	                     
******************************************************************************/
function fnAddrow3(i,j,strSndDiv){

    //alert ("i::"+i+"::j::"+j+"ds_default::"+ds_default.namevalue(i,"DOC_MAG_SID"));
 
    //실질적으로 정보등록에 들어갈 데이터를 모두 가지고 있어야함. 

	ds_default3.Addrow();
		
	ds_default3.namevalue(j,"DTB_MAG_SID")=ds_default2.namevalue(i,"DTB_MAG_SID");;  //배포 번호
	ds_default3.namevalue(j,"DTB_SEQ")=j;  //배포 순번
	
	ds_default3.namevalue(j,"RCP_DPT")=""  //수신부서 사용자가 직접 입력
	ds_default3.namevalue(j,"SGN_STS")= "1";  //작성중
	
	if(strSndDiv=="1"){ //열람
		ds_default3.namevalue(j,"RCP_STS")= "3";  //열람미확인
	}else if(strSndDiv=="2"){ //사내반출
		ds_default3.namevalue(j,"RCP_STS")= "1";  //수신미확인
	}else{
	    ds_default3.namevalue(j,"RCP_STS")= "9"; //사외반출
	}
	
	
	ds_default3.namevalue(j,"TNS_RCP_DST")= ""; //반출수신처  사용자가 직접 입력
	ds_default3.namevalue(j,"TNS_RCP_PSN")= ""; //반출수신자  사용자가 직접 입력
	
	ds_default3.namevalue(j,"RCP_DT")="";            //수신일자  수신확인시 업데이터 
	ds_default3.namevalue(j,"RCP_PSN")="";         //수신자      사용자가 직접입력 
	ds_default3.namevalue(j,"DOC_MAG_SID")=gcem_doc_mag_sid.text;   //등록번호
	
	ds_default3.namevalue(j,"CRT_DIV")="2" ;  //사본 ( 복사본이므로 항상 사본 ) 
	ds_default3.namevalue(j,"DOC_GRD")=ds_default.namevalue(ds_default.rowposition,"DOC_GRD"); //등급
	ds_default3.namevalue(j,"DOC_FRM")=ds_default.namevalue(ds_default.rowposition,"DOC_FRM"); //형태
	ds_default3.namevalue(j,"DOC_TLE") =ds_default.namevalue(ds_default.rowposition,"DOC_TLE"); //제목

}


/******************************************************************************
	Description : 저장
******************************************************************************/
 function fnApply3() {
    if (ds_default3.IsUpdated) {
        if (fnChk3()) {
            ln_TRSetting(tr1, "<%=dirPath%><%=HDConstant.PATH_LI%>Li0200I",  "JSP(I:DS_DEFAULT3=ds_default3 )",  "proType=A,dsType=1");
           // prompt('',ds_default.text);
            tr_post(tr1);
        }
    }
}

/******************************************************************************
	Description : 저장시 체크
******************************************************************************/
 function fnChk() {           
    var chk_yn="N";
  	var chk_cnt=0;
  	var chk_snd_div="";
  	var chk_dtb_dt="";
  	var chk_tns_rsn="";
  	var chk_tns_way="";
  	var chk_row=0;
  	
   for (var i=1; i<=ds_default2.countrow;i++){
   		if(ds_default2.namevalue(i,"CHK")=="T"){
   			chk_yn="Y";	
   			chk_cnt = ds_default2.namevalue(i,"DTB_CNT");
   			chk_snd_div = ds_default2.namevalue(i,"SND_DIV");
   			chk_dtb_dt = ds_default2.namevalue(i,"DTB_DT");
   			chk_tns_rsn = ds_default2.namevalue(i,"TNS_RSN");
   			chk_tns_way = ds_default2.namevalue(i,"TNS_WAY");
   			chk_row=i;
   		}
   } 
      
  	
  	//필수항목체크 
  	if(chk_yn=="N"){
  		alert("배포정보를 선택하십시요.");
  		return false;
  	}
  	
  	
  	if(chk_snd_div==""){
  		alert("발신구분을  입력하십시요.");
  		return false;
  	}
  	
  	if(chk_cnt==0){
  		alert("배포수를 입력하십시요.");
  		return false;
  	}
  	
  	if(chk_dtb_dt==""){
  		alert("배포일자를 입력하십시요.");
  		return false;
  	}
  	
  	
  	//사외반출일 경우 배포사유와 배포방법 필수입력 
  	if(chk_snd_div=="3"){
  		if(chk_tns_rsn==""){
	  		alert("배포사유를  입력하십시요.");
	  		return false;
  		}
  		
  		if(chk_tns_way==""){
	  		alert("배포방법을 입력하십시요.");
	  		return false;
  		}
  	}
  	
  	//배포일자 길이 
  	if(chk_dtb_dt.length!=8){
  		alert("배포일자를 확인하십시요");
  		return false;
  	}
  	
  	
  	
    if(ds_default2.namevalue(chk_row,"DTB_SGN_STS")!=""){
    	alert("더 이상 저장 할 수 없습니다.");
    	return false;
    }
  	
    return true;
  	
  	//체크 선택할 때 배포 및 반출입력 cell 색깔 변경되게 할까?
}


/******************************************************************************
	Description : 저장시 체크
******************************************************************************/
 function fnChk3() {    
   var chk_row=0;
   var chk_snd_div="";
   var chk_sgn_sts="";
   var chk_yn="N";
   var chk_dtb_mag_sid="";
   
      
   for (var i=1; i<=ds_default2.countrow;i++){
   		if(ds_default2.namevalue(i,"CHK")=="T"){
   			chk_row=i;
   			chk_snd_div = ds_default2.namevalue(i,"SND_DIV");
   			chk_sgn_sts =ds_default2.namevalue(i,"DTB_SGN_STS");      
   			chk_yn="Y";      
   			chk_dtb_mag_sid = ds_default2.namevalue(i,"DTB_MAG_SID");
   		}
   } 
   
   //alert("chk_snd_div::"+chk_snd_div);
   //alert("chk_sgn_sts::"+chk_sgn_sts);
   //alert("chk_dtb_mag_sid::"+chk_dtb_mag_sid);
   
  	if(chk_yn=="N"){
  		alert("배포정보를 선택하십시요.");
  		return false;
  	}
   
   if (chk_dtb_mag_sid!=ds_default3.namevalue(1,"DTB_MAG_SID")) {
   	  alert("배포번호를 확인하십시요.");
   	  return false;
   }
   
   if (chk_sgn_sts!=1&&chk_sgn_sts!="") {
   	 alert("결재상태가 진행중입니다. 수정할 수 없습니다.");
   	 return false;
   }
   
   
   //저장시 필수항목 체크 
   if(chk_snd_div==3){ // 사외반출 
   		for (var j =1;j<=ds_default3.countrow;j++){
   			if(ds_default3.namevalue(j,"TNS_RCP_DST")==""){
   				alert("반출수신처는 필수 항목입니다.");
   				return false;	
   			}
   			
   			if(ds_default3.namevalue(j,"TNS_RCP_PSN")==""){
   				alert("반출수신자는 필수 항목입니다.");
   				return false;
   			}
   		}
   }else{
    	for (var j =1;j<=ds_default3.countrow;j++){
   			if(ds_default3.namevalue(j,"수신자")==""){
   				alert("수신자는 필수 항목입니다.");
   				return false;	
   			}
   			
   			if(ds_default3.namevalue(j,"RCP_DPT")==""){
   				alert("수신부서는 필수 항목입니다.");
   				return false;
   			}
   		}
   }
      
     
  return true;
 
 }  

/******************************************************************************
	Description : 배포문서 그리드의 수신처,수신자, 반출수신처,반출수신자 display
	                     발신구분 = 사외반출일경우만, 반출수신처, 반출수신자 기입함.
******************************************************************************/
function fnDisplay(row,colid) {

	if(ds_default2.namevalue(row,colid)=="3"){ //사외반출
 			gcgd_disp03.ColumnProp("RCP_DPT_NM","show")="false"; 
 			gcgd_disp03.ColumnProp("RCP_PSN_NM","show")="false";
 			gcgd_disp03.ColumnProp("TNS_RCP_DST","show")="true";
 			gcgd_disp03.ColumnProp("TNS_RCP_PSN","show")="true";
 	}else{
 			gcgd_disp03.ColumnProp("RCP_DPT_NM","show")="true";
 			gcgd_disp03.ColumnProp("RCP_PSN_NM","show")="true";
 			gcgd_disp03.ColumnProp("TNS_RCP_DST","show")="false";
 			gcgd_disp03.ColumnProp("TNS_RCP_PSN","show")="false";
 	}
}



/******************************************************************************
	Description : 수신자, 수신자 부서 
******************************************************************************/
function fnRcpDptPopup(row,colid,data) {
			
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Common/help/rv004h_03.jsp"
		strPos = "dialogWidth:410px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			
			//alert(" arrParam[0]::"+ arrParam[0]);
			ds_default3.namevalue(row,"RCP_DPT")       = arrParam[3];
	   		ds_default3.namevalue(row,"RCP_DPT_NM") = arrParam[0];
	   		ds_default3.namevalue(row,"RCP_PSN")      = arrParam[1];
	   		ds_default3.namevalue(row,"RCP_PSN_NM")   = arrParam[2];
		} else {
			ds_default3.namevalue(row,"RCP_DPT")      = "";
	   		ds_default3.namevalue(row,"RCP_DPT_NM") = "";
	   		ds_default3.namevalue(row,"RCP_PSN")      = "";
	   		ds_default3.namevalue(row,"RCP_PSNM")   = "";
   		}				
	}


/******************************************************************************
	Description : 결재선  popup
******************************************************************************/
function fnApproval() {
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;
	var strPos;
	strURL = "<%=dirPath%>/Sales/help/sy040h.jsp?";
	strPos = "dialogWidth:580px;dialogHeight:530px;status:no;scroll:no;resizable:no";

	arrResult = showModalDialog(strURL,arrParam,strPos);
	sApproveLine = arrResult; // ru
}

/******************************************************************************
	Description : 기안  popup
******************************************************************************/
function fnDraft() {
    var row=0;
    var strGB="";
    var int_doc_mag_sid=0;

	if(ds_default.CountRow ==0){
		alert("기안 할 내용을 조회 해 주세요");
		return;
	}
	
	if(ds_default.namevalue(ds_default.rowposition,"DOC_GRD")!="1"){
		alert("문서등급이 기밀만 기안 가능합니다.");
		return;
	}
		
	if(sApproveLine==""||sApproveLine=="undefined"){
	   alert("결재선지정이 되지 않았습니다.");
	   return;
	}
	
	
	//배포정보위치 확인 
	for (var i=1; i<=ds_default2.countrow;i++){
   		if(ds_default2.namevalue(i,"CHK")=="T"){
         	row = ds_default2.rowposition;
        }
   }
    
   
    if(row<1){
    	alert("배포정보의 선택을 체크 하십시요.");
    	return;
    }
    
    
    //배포결재상태 확인 작성중만 기안 가능  
   	if(ds_default2.namevalue(row,"DTB_SGN_STS")!="1"){
   		alert("배포결재상태가 작성중만 기안 가능합니다.");
   		return;
   	}
         	

    //배포상세  건수 확인 
    if(ds_default3.countrow<1){
    	alert("배포상세 데이터가 존재하지 않습니다.");
    	return;
    } 
    
    //alert("ds_default3::"+ds_default3.SysStatus(ds_default3.countrow));   
    if(ds_default3.SysStatus(ds_default3.countrow)!=0){
    	alert("배포상세 데이터 저장 후 기안 가능합니다.");
    	return;
    }
      
   
	if (ds_default2.namevalue(row,"SND_DIV")=="1"){  //열람
		strGB ="040";
	}else if(ds_default2.namevalue(row,"SND_DIV")=="2"||ds_default2.namevalue(row,"SND_DIV")=="3" ){ //사내배포, 사외배포 
	    strGB ="020";	
	};
	
	
	int_doc_mag_sid = ds_default.namevalue(ds_default.rowposition,"DOC_MAG_SID");
	var arrParam	= new Array();
		
	arrParam[0]=strGB;  // AP006 ( 010 정보등록 , 020 정보배포, 030 정보수신, 040 정보열람, 100 서비스요청 
	arrParam[1]=ds_default2.namevalue(ds_default2.rowposition,"DTB_MAG_SID");  //배포번호 
	arrParam[2]=sApproveLine;      // 결재선정보 
	
	
	strURL = "<%=dirPath%>/Security/help/li0200h.jsp?";
	strPos = "dialogWidth:740px;dialogHeight:500px;status:no;scroll:no;resizable:no";
	
	arrResult = showModalDialog(strURL,arrParam,strPos);
	
	
	fnSelect2(int_doc_mag_sid);
}
	
	

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=ds_default classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr       value="-DOC_MAG_SID">
</object>

<object  id=ds_default2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<param name=SortExpr   value="-DTB_MAG_SID">
</object>

<object  id=ds_default3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


<object  id=ds_doc_grd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_doc_frm classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_crt_div classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_sgn_sts classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_snd_div classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_rcp_sts classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>
</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>


<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="ds_default" event="OnLoadStarted()">
	
</script>

<script language="javascript" for="ds_default" event="onloadCompleted(row,colid)">
  
    ft_cnt01.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	
	if(ds_default.countrow<=0){
		alert("조회된 데이타가 없습니다.");
	}
</script>

<script language="javascript" for="ds_default2" event="onloadCompleted(row,colid)">
  
    ft_cnt02.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	
	if(ds_default2.countrow<=0){
		alert("조회된 데이타가 없습니다.");
	}
</script>

<script language="javascript" for="ds_default3" event="onloadCompleted(row,colid)">
  
    ft_cnt03.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	
	if(ds_default3.countrow<=0){
		alert("조회된 데이타가 없습니다.");
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>

    if(row>0){
       // alert("DOC_MAG_SID::"+ds_default.namevalue(row,"DOC_MAG_SID"));
		fnSelect2(ds_default.namevalue(row,"DOC_MAG_SID"));
		ds_default3.ClearAll();
	}
 </script>
 
 
 <script language=JavaScript for=gcgd_disp01 event=OnClick(row,colid)>

    if(row>0){
       // alert("DOC_MAG_SID::"+ds_default.namevalue(row,"DOC_MAG_SID"));
		fnSelect2(ds_default.namevalue(row,"DOC_MAG_SID"));
		ds_default3.ClearAll();
	}
 </script>

 <script language=JavaScript for=gcgd_disp02 event=OnCloseUp(row,colid)>

 	if(colid=="SND_DIV"){
 		fnDisplay(row,colid);
 	}
  </script>
  
 <script language="javascript"  for=gcgd_disp02 event="OnClick(Row,Colid)">
	if (Colid =="CHK") {
		for (var i=1; i<=ds_default2.countrow;i++) {
			if(i != Row) {
				ds_default2.namevalue(i,"CHK") = "F";
			}
		}
	}
</script>


<script language=JavaScript for=gcgd_disp02 event=OnPopup(row,colid,data)>
	var __calendarRtn;
 	__calendarRtn = window.showModalDialog("<%=dirPath%>/Common/html/com_calender.htm","","dialogWidth:180px;dialogHeight:230px;scroll:no;status:no;titlebar:no;center:yes;help:yes;");
	
	if (__calendarRtn!=null && __calendarRtn.length>=4 ){
        ds_default2.namevalue(row,colid)= __calendarRtn[3];
		__calendarRtn=null;
	}
</script>
 
 
 <script language=JavaScript for=gcgd_disp03 event=OnPopup(row,colid,data)>
 		fnRcpDptPopup(row,colid,data);
 </script>

<!-- 그리드 선택일괄 체크 이벤트 -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=tr2  event=OnSuccess()>

	fnSelect2(gcem_doc_mag_sid.text);
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s09.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td align=left >
			<img src="<%=dirPath%>/Sales/images/ap_line.gif"	style="cursor:hand" onclick="fnApproval()">
			<img src="<%=dirPath%>/Sales/images/ap_up.gif"		style="cursor:hand" onclick="fnDraft()">
		</td>
		<td align=right >
		    <img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">	
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	
	<tr> 
		<td width="80px"   class="tab25" bgcolor="#eeeeee" align=center>문서등급</td>
		<td width="120px" class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_doc_grd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID	value="ds_doc_grd">
				<param name=BindColumn      value="detail">
                <param name=BindColVal        value="detail">
                <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                <param name=ListExprFormat  value="detail_nm^0^100">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center>문서형태</td>  
	    <td width="120px" class="tab24">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_doc_frm classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID	  	value="ds_doc_frm">
				<param name=CBDataColumns   value="detail, detail_nm">
				<param name=SearchColumn		value=detail_nm>
				<param name=ListExprFormat	    value="detail_nm^0^100">
				<param name=BindColumn			value="detail">
			</object>
			</comment><script>__ws__(__NSID__);</script> 
		</td>
		<td width="80px;" class="tab24"  bgcolor="#eeeeee" align=center>소유부서</td> 
		<td class="tab24"  colspan =3 >&nbsp;
			<input type="text" class="txt11" id="txt_own_dpt"       style="position:relative;left:-4px;width:50px;background-color:#d7d7d7" readOnly>
			<input type="text" class="txt11" id="txt_own_dptnm"  style="position:relative;left:-4px;width:100px;background-color:#d7d7d7" readOnly>
		</td>
	</tr>
	
	<tr> 
		<td width="80px"    class="tab30"  bgcolor="#eeeeee" align=center>제목</td>
		<td class="tab28"  colspan =7 >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_doc_tle classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:683px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value= true>
				<param name=Enable			value="true">
				<param name=GeneralEdit   value="true">
				
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
	
	<tr> 
		<td width="80px"  class="tab30" bgcolor="#eeeeee" align=center>내용</td>
		<td class="tab28" colspan =7 >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_doc_cts classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:683px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value= true>
				<param name=Enable			value="true">
				<param name=GeneralEdit   value="true">
				
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
	<tr> 
		<td width="80px"  class="tab30" bgcolor="#eeeeee" align=center>키워드</td>
		<td class="tab28" colspan =7 >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_doc_kwd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:683px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value= true>
				<param name=Enable			value="true">
				<param name=GeneralEdit   value="true">
				
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
</table>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
   <tr><td height="5px"> </td> </tr>
   <tr>
   		<td align=left><font  SIZE="2"   COLOR="blue" style="position:relative;top:-3px"><b>[기등록문서]</b></font>
   		
   		<font  SIZE="2"   COLOR="black"  style="position:relative;left:5px;top:-3px" > *등록번호 : </font>
            <comment id="__NSID__">
			<OBJECT id=gcem_doc_mag_sid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:80px">
				<param name=Text				value="">
				<param name=Alignment		value=2>
				<param name=Border			value= true>
				<param name=ReadOnly     value="true">
				<param name=IsComma      value="false">
				<param name=MaxLength    value=10>
				<param name=ReadOnlyBackColor   value="#C0C0C0">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
   		</td>
   		
        <td align=right >
            <font  SIZE="2"   COLOR="blue"  style="position:relative;left:-45px;top:-3px"><b>[배포정보]</b></font>
            
           <font  SIZE="2"   COLOR="black"  style="position:relative;left:-30px;top:-3px" > *배포번호 : </font>
            <comment id="__NSID__">
			<OBJECT id=gcem_dtb_mag_sid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:-30px;width:80px">
				<param name=Text				value="">
				<param name=Alignment		value=2>
				<param name=Border			value= true>
				<param name=ReadOnly     value="true">
				<param name=IsComma      value="false">
				<param name=MaxLength    value=10>
				<param name=ReadOnlyBackColor   value="#C0C0C0">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
    		<img src="<%=dirPath%>/Sales/images/plus.gif"   	       style="cursor:hand" onclick="fnAddRow2()">
    		<img src="<%=dirPath%>/Sales/images/save.gif"	 	    style="cursor:hand" onclick="fnApply2()">
		    <img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand" onclick="fnCancel2()">
		</td>
   </tr>
   <tr> 
		<td >
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:380px; height:150px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 value="ds_default">
					<param name="IndWidth"		 value='0'>
					<param name="BorderStyle"  value="0">
					<param name="Fillarea"		 value="true">
					<param name="Sortview"		 value="left">
					<param name="ColSizing"	 value="true">
					<param name="Editable"		 value="true"> 
					<param name=TitleHeight      value="30">
					<param name="Format"	 	 value=" 
					<C> Name='등록번호'		        ID=DOC_MAG_SID	  HeadAlign=Center HeadBgColor=#B9D4DC Width=65 	align=right    edit = none </C>
					<C> Name='생성\\구분'         ID=CRT_DIV                HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	align=left       edit = none  EditStyle=Lookup	Data='ds_crt_div:detail:detail_nm'  </C>
                    <C> Name='등급'  	                ID=DOC_GRD	          HeadAlign=Center HeadBgColor=#B9D4DC Width=40 	align=left       edit = none  EditStyle=Lookup	Data='ds_doc_grd:detail:detail_nm' </C>
					<C> Name='형태'  	                ID=DOC_FRM	          HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	align=left       edit = none  EditStyle=Lookup	Data='ds_doc_frm:detail:detail_nm' </C>
					<C> Name='제목'  	                ID=DOC_TLE	          HeadAlign=Center HeadBgColor=#B9D4DC Width=140 	align=left       edit = none</C>
					<C> Name='등록\\결재상태'	ID=SGN_STS 	          HeadAlign=Center HeadBgColor=#B9D4DC Width=55 	align=left       edit = none EditStyle=Lookup	Data='ds_sgn_sts:detail:detail_nm' </C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:382px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
		<td >
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
			style="position:relative;left:0px;width:475px; height:150px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 value="ds_default2">
					<param name="IndWidth"		 value='0'>
					<param name="BorderStyle"  value="0">
					<param name="Fillarea"		 value="true">
					<param name="Sortview"		 value="left">
					<param name="ColSizing"	 value="true">
					<param name="Editable"		 value="true"> 
					<param name=TitleHeight      value="30">
					<param name=UsingOneClick  value="1">
					<param name="Format"	 	 value=" 
					<C> Name='선택'      		        ID=CHK              	      HeadAlign=Center HeadBgColor=#B9D4DC Width=28 	align=center  EditStyle=CheckBox</C>
					<C> Name='배포번호'	            ID=DTB_MAG_SID 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=right     edit = none </C>
					<C> Name='발신구분'  	            ID=SND_DIV	              HeadAlign=Center HeadBgColor=#B9D4DC Width=55 	align=left       BgColor=#81F79F   EditStyle=Lookup	Data='ds_snd_div:detail:detail_nm' </C>
					<C> Name='배포\\수'   	        ID=DTB_CNT	          HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	align=right     BgColor=#81F79F  </C>
					<C> Name='배포일자'  	            ID=DTB_DT	              HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	align=center  BgColor=#81F79F  EditStyle=Popup  mask ='XXXX/XX/XX'</C>
					<C> Name='배포사유'  	            ID=TNS_RSN	          HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=left        BgColor=#81F79F </C>
					<C> Name='배포방법'  	            ID=TNS_WAY	          HeadAlign=Center HeadBgColor=#B9D4DC Width=77 	align=left        BgColor=#81F79F </C>
					<C> Name='배포\\결재상태'	ID=DTB_SGN_STS      HeadAlign=Center HeadBgColor=#B9D4DC Width=55 	align=left       edit = none EditStyle=Lookup	Data='ds_sgn_sts:detail:detail_nm' </C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:477px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt02 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
   <tr><td height="5px"> </td> </tr>
   <tr>
   		<td align=left><font  SIZE="2"   COLOR="blue"><b>[배포상세]</b></font></td>
   		
        <td align=right >
		    <img src="<%=dirPath%>/Sales/images/refer.gif"		   style="cursor:hand" onclick="fnSelect3()">
		    <img src="<%=dirPath%>/Sales/images/n_create.gif"	    style="cursor:hand" onclick="fnCreate3()">
    		<img src="<%=dirPath%>/Sales/images/save.gif"	 	    style="cursor:hand" onclick="fnApply3()">
		    <img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand" onclick="fnCancel3()">
		</td>
   </tr>
   <tr> 
		<td colspan=2>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp03  
			style="position:relative;left:0px;width:858px; height:250px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 value="ds_default3">
					<param name="IndWidth"		 value='0'>
					<param name="BorderStyle"  value="0">
					<param name="Fillarea"		 value="true">
					<param name="Sortview"		 value="left">
					<param name="ColSizing"	 value="true">
					<param name="Editable"		 value="true"> 
					<param name=TitleHeight      value="30">
					<param name="Format"	 	 value=" 
					<C> Name='등록번호'		              ID=DOC_MAG_SID	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=right   edit = none  </C>
					<C> Name='배포번호' 	                  ID=DTB_MAG_SID     HeadAlign=Center HeadBgColor=#B9D4DC Width=55 	align=right   edit = none  </C>
                    <C> Name='순번'  	                      ID=DTB_SEQ  	      HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	align=right   edit = none  </C>
					<C> Name='생성\\구분'               ID=CRT_DIV   	          HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	align=left     edit = none  EditStyle=Lookup	Data='ds_crt_div:detail:detail_nm' </C>
					<C> Name='등급'  	                      ID=DOC_GRD	          HeadAlign=Center HeadBgColor=#B9D4DC Width=40 	align=left     edit = none  EditStyle=Lookup	Data='ds_doc_grd:detail:detail_nm'  </C>
					<C> Name='형태'  	                      ID=DOC_FRM	          HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	align=left     edit = none  EditStyle=Lookup	Data='ds_doc_frm:detail:detail_nm' </C>
					<C> Name='제목'  	                      ID=DOC_TLE	          HeadAlign=Center HeadBgColor=#B9D4DC Width=175	align=left     edit = none  </C>
					<C> Name='수신자'	                      ID=RCP_PSN            HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=left     BgColor=#81F79F  EditStyle=Popup  show=false </C>
					<C> Name='수신자명'	                  ID=RCP_PSN_NM     HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=left     BgColor=#81F79F  EditStyle=Popup </C>
					<C> Name='수신부서'	                  ID=RCP_DPT            HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=left     show=false  </C>
					<C> Name='수신부서명'	              ID=RCP_DPT_NM     HeadAlign=Center HeadBgColor=#B9D4DC Width=100  	align=left      </C>
					<C> Name='반출\\수신처'	          ID=TNS_RCP_DST    HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=left      BgColor=#81F79F </C>
					<C> Name='반출\\수신자'	          ID=TNS_RCP_PSN    HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=left      BgColor=#81F79F </C>
					<C> Name='수신열람\\결재상태'  ID=SGN_STS 	          HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=left      edit = none  EditStyle=Lookup	Data='ds_sgn_sts:detail:detail_nm' </C>
					<C> Name='수신상태'	                  ID=RCP_STS 	          HeadAlign=Center HeadBgColor=#B9D4DC Width=65 	align=left      edit = none  EditStyle=Lookup	Data='ds_rcp_sts:detail:detail_nm' </C>
					<C> Name='키워드'  	                  ID=DOC_KWD	          HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left      edit = none  show=false</C>
					<C> Name='내용'  	                      ID=DOC_CTS	          HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left      edit = none   show=false</C>					
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>
<comment id="__NSID__">
	<object  id=gcbn_01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds_default>
	<param name=BindInfo  value='  
	<C>Col=DOC_MAG_SID	  Ctrl=gcem_doc_mag_sid   Param=TEXT </C>
	'>
</object>

<object  id=gcbn_02 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds_default2>
	<param name=BindInfo  value='  
	<C>Col=DTB_MAG_SID	  Ctrl=gcem_dtb_mag_sid   Param=TEXT </C>
	'>
</object>
</comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 