<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 인감관리 - 법인인감날인신청
+ 프로그램 ID	: a400140.jsp
+ 기 능 정 의	: 법인인감날인신청
+ 최 초 이 력	: 2017.04.10 jys
+ 가우스 버젼    : 5.2
-----------------------------------------------------------------------------
+ 변 경 이 력	:   
+ 변 경 내 용	:  
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a400140_s1, a400140_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<%@ page import="sales.common.DateUtil"%> 
<% 
   //ContextPath 변수 설정.
   String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정.
   
   String v_dwr_sid = request.getParameter("v_dwr_sid");	//작업일보 index
   String v_status	 = request.getParameter("v_status");	//페이지 작업 구분자 : 상태 010작성중, 011현장결재진행중, 012현장결재완료
   String v_ap_m_sid = request.getParameter("v_ap_m_sid");	//결재마스터 sid : 반려시에는 스냅샷을 찍는게 아니므로 일보 인덱스가 겹친다.
   
   String gusrip	= (String)session.getAttribute("vusrip");	//페이지 이동시 IP변경 체크
%>

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

var gs_date2  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;
var gs_yymm = gcurdate.substring(2,4) + gcurdate.substring(5,7); 

<%
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	//ln_Query("C201704210001");
	//ln_Query_Apline("12237");
	
	ln_Query('C209912310001');  // 데이터 셋 헤드 가져오기 
	
	txt_app_teamcd.value = gdeptcd;
	txt_app_teamnm.value = gdeptnm;
	txt_app_empno.value = gusrid;
	txt_app_empnm.value = gusrnm;
	
	//직위 조회
	gcds_jobcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_job_cd_s1?v_str1="+txt_app_empno.value;
	gcds_jobcd.Reset();
	
	txt_app_jobcd.value = gcds_jobcd.namevalue(gcds_jobcd.rowposition,"JOBCD");
	txt_app_jobnm.value = gcds_jobcd.namevalue(gcds_jobcd.rowposition,"JOBNM");
	
	//인감관리번호 팀명 + 인감기준번호 + 년월 + 순번
	//gcem_signet_mgr_no.text = gs_yymm ;
	
	ln_SetDataHeader();	 //결재선 헤더
	ln_SetDataHeader2(); //주관침 결재선 헤더

	ds_apline_2_temp.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_apline2_s1?v_str1=0001";
	ds_apline_2_temp.Reset();
	
	ds_gc_aptype.DataId = "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP005&s_item1=Y";
	ds_gc_aptype.Reset();	// 결재유형 AP005 - 공통모듈쪽 공통코드 읽어오기
	
	ds_gc_apsts_d.DataId = "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP003&s_item1=Y";
	ds_gc_apsts_d.Reset();	// 결재상태_D AP003 - 공통모듈쪽 공통코드 읽어오기
	
}
<%
/******************************************************************************
	Description : 조회
******************************************************************************/
%>
function ln_Query(strAppno){
	
	if(strAppno==""){
		alert("신청번호가 존재해야 합니다. ");
		return false;
	}
	
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_s1?v_str1="+strAppno;	                                                            
    //prompt('',gcds_data.DataID);
	gcds_data.Reset();
}


function ln_Query_Apline(strAp_m_sid){
	
	//신청팀 결재선 조회 
	ds_apline.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_s2?v_str1="+strAp_m_sid+"&v_str2=1";                                                  
	ds_apline.Reset();
	
	//주관팀 결재선 조회 
	ds_apline2.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_s2?v_str1="+strAp_m_sid+"&v_str2=4";                                                  
	ds_apline2.Reset();
}

<%
/******************************************************************************
	Description : 추가
******************************************************************************/
%>
function ln_Add(){
	
	gcds_data.Addrow();
	
	gcem_signet_id.text="0001"; 
	gcem_app_date.text = gs_date2;
	
	txt_app_teamcd.value = gdeptcd;
	txt_app_empno.value = gusrid;
	txt_app_jobcd.value = gcds_jobcd.namevalue(gcds_jobcd.rowposition,"JOBCD");
	
	ln_File_Clear();
	//신청번호 및 인감관리번호는 상신시 발생	
}

<%
/******************************************************************************
	Description : 저장
******************************************************************************/
%>
function ln_Save(){
	if(!ln_Chk_Save())return;
	else if (gcds_data.IsUpdated) {
		if (confirm("입력하신 사항을 저장하시겠습니까?")){			
			gctr_data_save.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_t1";
			gctr_data_save.Parameters = "v_str1="+gs_userid;
			//prompt('',gcds_data.text);
			gctr_data_save.post();
			ln_Query(gcem_app_no.text);
		}	
	}
}

/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
function ln_Chk_Save() {
    //필수항목 체크     
    
    //신청소속/직위/신청자
    if(txt_app_teamcd.value==""){
    	alert("신청자 소속 코드를 확인하십시요");
    	return false;
    } 
    
    if(txt_app_jobcd.value==""){
    	alert("신청자 직위를 확인하십시요");
    	return false;
    } 
    
    if(txt_app_empno.value==""){
    	alert("신청자 사번을 확인하십시요");
    	return false;
    } 
    
    //인감ID
    if(gcem_signet_id.text==""){
    	alert("인감 ID를 확인하십시요");
    	return false;
    } 
    
    //신청일자
    if(gcem_app_date.text==""){
    	alert("신청일자를 확인하십시요");
    	return false;
    } 
    
    //용도
    if(gcem_signet_use.text==""){
    	alert("용도를 확인하십시요");
    	return false;
    } 
    
    //용도
    if(gcem_signet_submit.text==""){
    	alert("제출처를 확인하십시요");
    	return false;
    } 
    
    //서류수
    if(gcem_paper_cnt.text==0){
    	alert("서류수를 확인하십시요");
    	return false;
    } 
    
    //날인수량
    if(gcem_seal_cnt.text==0){
    	alert("날인수량을 확인하십시요");
    	return false;
    } 
    
    //품의서 사본명 첨부
    if(document.fileForm.fileList.options[0].text==""){
    	alert("품의서 사본명을 확인하십시요");
    	return false;
    } 

    return true;
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){
	
}

<%	
/******************************************************************************
	Description : 삭제
******************************************************************************/
%>
function ln_Delete(){
	
	if(!ln_Chk_Delete())return;
	
	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_data.deleterow(gcds_data.rowposition);
		gctr_data_save.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_t1";
		gctr_data_save.Parameters = "v_str1="+gs_userid;
		gctr_data_save.post();
	    
		ln_Query("C209912310001");
	}
	else gcds_data.undo(gcds_data.rowposition);		
}

<%//파일삭제 체크%>
function ln_Chk_Delete(){
	
	if(gcem_app_no.text==""){
		alert("신청번호가 존재하지 않습니다. 삭제 대상건이 아닙니다.");
		return false;
	}
	
    if(document.fileForm.filename.value!=""){
		if(document.fileForm.fileList.options[0].text!=""){
			alert("파일이 첨부되어 있습니다. 파일 삭제후 데이터 삭제 가능합니다.")
			return false;
		}
    }
	return true;
}

<%
/******************************************************************************
	Description : 출력
******************************************************************************/
%>
function ln_Print(){

}

function ln_File_Clear(){
	//첨부파일
	//txt_real_file.value="";
	
    //파일첨부 초기화 
    fileForm.filename.outerHTML = fileForm.filename.outerHTML;
	fileForm.fileList.options[0].text="";
}

<%//file upload %>
function fnFileUpload(){
	
	/*
	var str = document.fileForm.filename.value;
	var ary = str.split('\\');
	var strFilename = ary[ary.length-1];  //순수파일명만 
	
	alert( '파일명 : ' + ary[ary.length-1].split('.')[0] );
	alert( '파일명1 : ' + ary[ary.length-1]);
	alert( '파일길이 : ' + ary[ary.length-1].split('.')[0].length );
	*/
	
	if(gcem_signet_id.text==""){
		alert("등록 후 파일 첨부 하십시요.");
		return false;
	}
	
	if(document.fileForm.filename.value==""){
		alert("첨부할 파일이 존재하지 않습니다.");
		return false;
	}
		
	fileForm.target="tempUpload";	//업로드 폼의 타겟은 iFrame !
	fileForm.action="a400140_fileUpload.jsp";
	fileForm.submit();
}

function fnAddFileList(realName){
	f = document.fileForm;
	if(realName!=""){
		f.fileList.options[0].value="1";
		f.fileList.options[0].text=realName;
		
		gcds_data.namevalue(gcds_data.rowposition,"ATT_GB") ="Y";
		gcds_data.namevalue(gcds_data.rowposition,"ATT_FILE_NAME")= realName;
	}  
}

<%//파일삭제%>
function fnFileDelete(){
	f = document.fileForm;
	  
	if(f.fileList.selectedIndex==null || f.fileList.selectedIndex < 0){
		alert('삭제할 파일을 선택해 주십시요');
		f.fileList.focus();
		return;
	}	

	if(confirm('정말로 삭제 하시겠습니까?')){
		var i = f.fileList.options.selectedIndex;
		
		var select_val = f.fileList.options[i].text;
		//var realFileName = f.file1.value;

		var realFileName = f.fileList.options[0].text;
		var oldFileNames = f.fileList.options[0].text;
	    var fileArray = oldFileNames.split(":");

		//alert(select_val);
		//alert(oldFileNames);

		//******** START 기존에 있던 파일인지 구분 ***********/
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
		//******** END  기존에 있던 파일인지 구분 ***********/
		 
		//alert(isNew);

		document.file_del.target="tempUpload";
		document.file_del.realFileName.value=realFileName;
		document.file_del.virtualFileName.value = select_val;
//		document.file_del.saveDir.value = "memGalleryUpload";
		document.file_del.mode.value=isNew;
		document.file_del.action = "./a400140_deleteFile.jsp";	//여기로 섬밋
		document.file_del.submit();
	}	
}


<% //파일을 서버에서 삭제 후 리스트에서 삭제 %>
function delResult(){
	
	f = document.fileForm;
	
	idx = f.fileList.selectedIndex;
	
	cnt = f.fileList.options.length;
	
	for(i=idx;i< f.fileList.options.length-1;i++){
		f.fileList.options[i] = new Option(f.fileList.options[i+1].text,f.fileList.options[i+1].value);
	}
	
	f.fileList.options[cnt - 1] = null;
	//f.file1.value = "첨부파일은최대 1M까지가능합니다.";
	fnAttchFile_delete();
}

function fnAttchFile_delete(){
	
	setDataHeader();
	gcds_data2.addrow();
	gcds_data2.namevalue(gcds_data2.rowposition,"APP_NO") = gcem_app_no.text
	gcds_data2.namevalue(gcds_data2.rowposition,"ATT_FILE_NAME") = "";
	gcds_data2.namevalue(gcds_data2.rowposition,"ATT_GB") = "N"
	gcds_data2.namevalue(gcds_data2.rowposition,"UPID") = gs_userid;
	gcds_data2.namevalue(gcds_data2.rowposition,"UPDT") = "";
	
	gctr_data.KeyValue = "Account.a400140_t2(I:USER=gcds_data2)";
	gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_t2";
	gctr_data.Parameters = "v_str1="+gs_userid;
	
	gctr_data.post();
	ln_File_Clear();
	ln_Query(gcem_app_no.text);
}

function fnFileNameDisplay(row){
	f = document.fileForm;
	//txt_real_file.value= gcds_data.namevalue(row,"ATT_FILE_NAME");
	f.fileList.options[0].value=gcds_data.namevalue(row,"ATT_FILE_NAME");
}

<%//파일삭제 데이터 셋 헤드 설정 %>
function setDataHeader() {
	 var s_temp = "APP_NO:STRING,ATT_FILE_NAME:STRING,ATT_GB:STRING,UPID:STRING,UPDT:STRING";
	 gcds_data2.SetDataHeader(s_temp);
}

<%
/******************************************************************************
	Description : 결재선  popup
******************************************************************************/
%>
function fnPopApline() {
	
	//인감정보 등록 체크 
	if(gcem_app_no.text==""){
		alert(" 신청서 저장 후 결재선지정 가능합니다.");
		return false;
	}
	
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;
	var strPos;
	var sApproveLine;
	strURL = "<%=dirPath%>/Config/help/sy040h.jsp";
	strPos = "dialogWidth:620px;dialogHeight:500px;status:no;scroll:no;resizable:no";

	arrResult = showModalDialog(strURL,arrParam,strPos);
	fnSetApline(arrResult);	
}

function fnSetApline(val){
	//alert("받아온 결재선="+val);
	var apline_tot = new Array();
	var apline_row = new Array();

	if(val!=""){
		ds_apline.clearData();	//먼저 지우고
		ds_apline2.clearData();	//먼저 지우고
		
		apline_tot=val.split(";");	// 결재선 행별로 나눔
		//alert("실제 결재선 행 + 1개 == "+apline_tot.length);	// 1행이면 2 리턴.. ;가 마지막에 들어가 있으니
		for(i=1;i<apline_tot.length;i++){
			apline_row = apline_tot[i-1].split("/");  // 1행부터
			/*
			alert(apline_row.length);	//
			alert("기본결재선(1) : " + apline_row[0]);	//
			alert("순번 : " + apline_row[1]);	//
			alert("결재유형 : " + apline_row[2]);	//
			alert("사번 : " + apline_row[3]);	//
			alert("이름 : " + apline_row[4]);	//
			alert("직위 : " + apline_row[5]);	//
			alert("부서 : " + apline_row[6]);	//
			alert("내 결재선 SID : " + apline_row[7]);	//
			*/
			
			ds_apline.AddRow();
			ds_apline.NameValue(i, "SEQ") 				= apline_row[1];//순번
			ds_apline.NameValue(i, "AP_TYPE") 			= apline_row[2];//결재유형
			ds_apline.NameValue(i, "ENO_NO")			= apline_row[3];//사번
			ds_apline.NameValue(i, "ENO_NM") 			= apline_row[4];//이름
			ds_apline.NameValue(i, "JOB_NM") 			= apline_row[5];//직위
			ds_apline.NameValue(i, "DPT_NM") 			= apline_row[6];//부서
			
			/*
			if(apline_row[1]==1){
				ds_apline.NameValue(i, "AP_STATUS_D") 	= "2";	//==상신
				
			}else{
				ds_apline.NameValue(i, "AP_STATUS_D") 	= "1";	//==미결
			};
			*/
			
			ds_apline.NameValue(i, "AP_STATUS_D") 	= "1";	//==미결
			
			ds_apline.NameValue(i, "U_DATE") 			= "";
			ds_apline.NameValue(i, "AP_DESC") 			= "";
		}
		
		//주관팀 결재선 
		//alert("ds_apline_2_temp::"+ds_apline_2_temp.countrow);
		for(var j=1;j<=ds_apline_2_temp.countrow;j++){
			
			ds_apline2.AddRow();
			ds_apline2.NameValue(j, "SEQ") 				= ds_apline_2_temp.namevalue(j,"SEQ");        //순번
			ds_apline2.NameValue(j, "AP_TYPE") 			= ds_apline_2_temp.namevalue(j,"AP_TYPE");    //결재유형
			ds_apline2.NameValue(j, "ENO_NO")			= ds_apline_2_temp.namevalue(j,"ENO_NO");     //사번
			ds_apline2.NameValue(j, "ENO_NM") 			= ds_apline_2_temp.namevalue(j,"ENO_NM");     //이름
			ds_apline2.NameValue(j, "JOB_NM") 			= ds_apline_2_temp.namevalue(j,"JOB_NM");     //직위
			ds_apline2.NameValue(j, "DPT_NM") 			= ds_apline_2_temp.namevalue(j,"DPT_NM");     //부서
			ds_apline2.NameValue(j, "AP_STATUS_D") 	    = ds_apline_2_temp.namevalue(j,"AP_STATUS_D");//==미결
			ds_apline2.NameValue(j, "U_DATE") 			= "";
			ds_apline2.NameValue(j, "AP_DESC") 			= "";
								
		}

	}else{
    	v_job="S_AP";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			+ ",v_dwr_sid=<%=v_dwr_sid%>"
			+ ",v_ap_m_sid=<%=v_ap_m_sid%>"	//결재선sid
			;
		
		//이 결재선 조회도 Ap200I.java로 옮기는게 맞을 듯.. -_-
        ln_TRSetting(tr1, 
        	"<%=dirPath%><%=HDConstant.PATH_CONFIG_AP%>Ap200I",	
            "JSP(O:DS_APLINE=ds_apline)",
            param);
        tr_post(tr1);
	}
} 


<% //결재선 데이터셋 헤더 %>
function ln_SetDataHeader(){
	if (ds_apline.countrow<1){
		var s_temp = " SEQ: DECIMAL(5),ENO_NO:STRING(7),AP_TYPE:STRING(10),ENO_NM:STRING(30),"
				   + " DPT_NM:STRING(50),DPT_CD:STRING(10),JOB_NM:STRING(50),AP_STATUS_D:STRING(10), "
				   + " U_DATE:STRING(50), AP_DESC:STRING(100), SID:NUMERIC(10.0) ";
		ds_apline.SetDataHeader(s_temp);
	}
}

<% //결재선 데이터셋 디테일 %>
function ln_SetDataHeader2(){
	if (ds_apline2.countrow<1){
		var s_temp = " SEQ: DECIMAL(5),ENO_NO:STRING(7),AP_TYPE:STRING(10),ENO_NM:STRING(30),"
				   + " DPT_NM:STRING(50),DPT_CD:STRING(10),JOB_NM:STRING(50),AP_STATUS_D:STRING(10), "
				   + " U_DATE:STRING(50), AP_DESC:STRING(100), SID:NUMERIC(10.0) ";
		ds_apline2.SetDataHeader(s_temp);
	}
}


<% //결재MST %>
function ln_SetDataHeader3(){
	if (gcds_ap_mst.countrow<1){
		var s_temp = "AP_M_SID:DECIMAL(10),DOC_SID:DECIMAL(10),DOC_GU:STRING(10),DOC_GU2:STRING(10),AP_STATUS_M:STRING(10),L_EMPNO:STRING(10),"
				   + "I_EMPNO:STRING(10),I_DATE:STRING(20),I_IP:STRING(30),U_EMPNO:STRING(10),U_DATE:STRING(20),U_IP:STRING(30),"
				   + "NUM_PARAM1:DECIMAL(10),NUM_PARAM2:DECIMAL(10),NUM_PARAM3:DECIMAL(10),NUM_PARAM4:DECIMAL(10),NUM_PARAM5:DECIMAL(10),"
				   + "CH_PARAM1:STRING(20),CH_PARAM2:STRING(20),CH_PARAM3:STRING(20)";
		gcds_ap_mst.SetDataHeader(s_temp);
	}
}


<% //결재DTL %>
function ln_SetDataHeader4(){
	if (gcds_ap_dtl.countrow<1){
		var s_temp = "AP_SID:DECIMAL(10),AP_M_SID:DECIMAL(10),AP_GU:STRING(10),AP_SEQ:DECIMAL(10),AP_TYPE:STRING(10),AP_STATUS_D:STRING(10),"
				   + "AP_EMPNO:STRING(10),AP_REAL_EMPNO:STRING(10),AP_DESC:STRING(100),"
				   + "I_EMPNO:STRING(10),I_DATE:STRING(20),I_IP:STRING(30),U_EMPNO:STRING(10),U_DATE:STRING(20),U_IP:STRING(30),"
				   + "AP_JOBNM:STRING(20),AP_DPTNM:STRING(50)";
		gcds_ap_dtl.SetDataHeader(s_temp);
	}
}

<% //상신  전자결재MST, 전자결재DTL %>
function ln_Apply(){
   
    if(!ln_Chk_Apply())return;
	
	if (confirm("입력하신 사항을 상신하시겠습니까?")){
			
		ln_Data_Setting();	
		
		gctr_data.KeyValue = "Account.a400140_t3(I:USER=gcds_ap_mst,I:USER2=gcds_ap_dtl)";
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400140_t3";
		gctr_data.Parameters = "v_str1="+gs_userid;
		//prompt('gcds_ap_mst',gcds_ap_mst.text);
		//prompt('gcds_ap_dtl',gcds_ap_dtl.text);
		
		gctr_data.post();
		
		ln_Query(gcem_app_no.text);
		ln_Query_Apline(gcds_data.namevalue(gcds_data.rowposition,"AP_M_SID"));
	}
}

<% //상신 체크 %>
function ln_Chk_Apply(){
	
	//신청번호 체크
	if(gcem_app_no.text==""){
		alert("신청번호가 존재하지 않습니다. 확인 바랍니다.");
		return false;
	}	
	
	//체크 - 결재선 존재 확인 .
	if(ds_apline.countrow<2){
		alert("신청팀 결재선을 확인 바랍니다.");
		return false;
	}
	
	//결재 후에는 상신 불가...
	if(gcds_data.namevalue(gcds_data.rowposition,"AP_M_SID")!=0){
		alert("이미 상신하셨습니다.");
		return false;
	}
	return true;
}

<% //데이터 설정 %>
function ln_Data_Setting(){
	var mrow=0;
	var drow=0;
	//결재 MST
	ln_SetDataHeader3();
	gcds_ap_mst.addrow();
	mrow = gcds_ap_mst.rowposition;
	
	//gcds_ap_mst.namevalue(mrow,"AP_M_SID") ="" ;      //시퀀스에서 가져옴.
	gcds_ap_mst.namevalue(mrow,"DOC_SID") ="3000";      //이건 그냥 임의로 넣음....의미없음. 
	gcds_ap_mst.namevalue(mrow,"DOC_GU") = "15";        //인감
	gcds_ap_mst.namevalue(mrow,"DOC_GU2") ="210";       //법인인감
	gcds_ap_mst.namevalue(mrow,"AP_STATUS_M") ="2";     //승인진행
	gcds_ap_mst.namevalue(mrow,"L_EMPNO") =gs_userid;   //최종결재자 - 상신시는 상신자. 계속 update 
	gcds_ap_mst.namevalue(mrow,"I_EMPNO") =gs_userid;   //등록자
	gcds_ap_mst.namevalue(mrow,"I_DATE") ="" ;          //등록일시  
	gcds_ap_mst.namevalue(mrow,"I_IP") = "<%=gusrip%>"; //등록자 IP
	gcds_ap_mst.namevalue(mrow,"U_EMPNO") ="" ;
	gcds_ap_mst.namevalue(mrow,"U_DATE") ="" ;
	gcds_ap_mst.namevalue(mrow,"U_IP") ="" ;
	gcds_ap_mst.namevalue(mrow,"NUM_PARAM1") ="" ;
	gcds_ap_mst.namevalue(mrow,"NUM_PARAM2") ="" ;
	gcds_ap_mst.namevalue(mrow,"NUM_PARAM3") ="" ;
	gcds_ap_mst.namevalue(mrow,"NUM_PARAM4") ="" ;
	gcds_ap_mst.namevalue(mrow,"NUM_PARAM5") ="" ;
	gcds_ap_mst.namevalue(mrow,"CH_PARAM1") =gcem_app_no.text ; //법인인감 신청NO
	gcds_ap_mst.namevalue(mrow,"CH_PARAM2") ="" ;
	gcds_ap_mst.namevalue(mrow,"CH_PARAM3") ="" ;
	
	//결재 DTL (신청팀)
	ln_SetDataHeader4();
	for(var i=1;i<=ds_apline.countrow;i++ ){
		gcds_ap_dtl.addrow();
		drow=gcds_ap_dtl.rowposition;
		//gcds_ap_dtl.namevalue(drow,"AP_SID") =""; //시퀀스에서 가져옴.
		//gcds_ap_dtl.namevalue(drow,"AP_M_SID") =ds_apline2.namevalue(i,""); // MST 시퀀스 가져옴.
		
		gcds_ap_dtl.namevalue(drow,"AP_GU") = "1"; //1결재 2참조 3시행 4협조
		gcds_ap_dtl.namevalue(drow,"AP_SEQ")       =ds_apline.namevalue(i,"SEQ");
		gcds_ap_dtl.namevalue(drow,"AP_TYPE")      =ds_apline.namevalue(i,"AP_TYPE");
		
		if(ds_apline.namevalue(i,"SEQ")==1){
			gcds_ap_dtl.namevalue(drow,"AP_STATUS_D")  ="2"; //상신
		}else{
			gcds_ap_dtl.namevalue(drow,"AP_STATUS_D")  =ds_apline.namevalue(i,"AP_STATUS_D");
		}
		gcds_ap_dtl.namevalue(drow,"AP_EMPNO")     =ds_apline.namevalue(i,"ENO_NO");
		gcds_ap_dtl.namevalue(drow,"AP_REAL_EMPNO")=ds_apline.namevalue(i,"ENO_NO");
		gcds_ap_dtl.namevalue(drow,"AP_DESC")      =ds_apline.namevalue(i,"AP_DESC");
		gcds_ap_dtl.namevalue(drow,"I_EMPNO")      =gs_userid;
		gcds_ap_dtl.namevalue(drow,"I_DATE")  ="";
		gcds_ap_dtl.namevalue(drow,"I_IP")    ="<%=gusrip%>";
		gcds_ap_dtl.namevalue(drow,"U_EMPNO") ="";
		gcds_ap_dtl.namevalue(drow,"U_DATE")  ="";
		gcds_ap_dtl.namevalue(drow,"U_IP")    ="";
		gcds_ap_dtl.namevalue(drow,"AP_JOBNM") =ds_apline.namevalue(i,"JOB_NM");
		gcds_ap_dtl.namevalue(drow,"AP_DPTNM") =ds_apline.namevalue(i,"DPT_NM");
	}
	
	//결재 DTL (주관팀)	
	for(var i=1;i<=ds_apline2.countrow;i++ ){
		gcds_ap_dtl.addrow();
		drow=gcds_ap_dtl.rowposition;
		//gcds_ap_dtl.namevalue(drow,"AP_SID") =""; //시퀀스에서 가져옴.
		//gcds_ap_dtl.namevalue(drow,"AP_M_SID") =ds_apline2.namevalue(i,""); // MST 시퀀스 가져옴.
		gcds_ap_dtl.namevalue(drow,"AP_GU")   ="4"; //1결재 2참조 3시행 4협조
		gcds_ap_dtl.namevalue(drow,"AP_SEQ")       =ds_apline2.namevalue(i,"SEQ");
		gcds_ap_dtl.namevalue(drow,"AP_TYPE")      =ds_apline2.namevalue(i,"AP_TYPE");
		gcds_ap_dtl.namevalue(drow,"AP_STATUS_D")  =ds_apline2.namevalue(i,"AP_STATUS_D");
		gcds_ap_dtl.namevalue(drow,"AP_EMPNO")     =ds_apline2.namevalue(i,"ENO_NO");
		gcds_ap_dtl.namevalue(drow,"AP_REAL_EMPNO")=ds_apline2.namevalue(i,"ENO_NO");
		gcds_ap_dtl.namevalue(drow,"AP_DESC")      =ds_apline2.namevalue(i,"AP_DESC");
		gcds_ap_dtl.namevalue(drow,"I_EMPNO")      =gs_userid;
		gcds_ap_dtl.namevalue(drow,"I_DATE") ="";   //생성일시
		gcds_ap_dtl.namevalue(drow,"I_IP") ="<%=gusrip%>" ;
		gcds_ap_dtl.namevalue(drow,"U_EMPNO") ="";  //공백
		gcds_ap_dtl.namevalue(drow,"U_DATE")  ="";  //공백
		gcds_ap_dtl.namevalue(drow,"U_IP")    ="";  //공백
		gcds_ap_dtl.namevalue(drow,"AP_JOBNM") =ds_apline2.namevalue(i,"JOB_NM");
		gcds_ap_dtl.namevalue(drow,"AP_DPTNM") =ds_apline2.namevalue(i,"DPT_NM");
	}
}
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_data2 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=ds_apline classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=ds_apline2 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=ds_apline_2_temp classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_ap_mst classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_ap_dtl classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<object id=ds_gc_aptype classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=ds_gc_apsts_d classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<object id=gcds_jobcd classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_data_appno classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


</comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
	<object id=gctr_data classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 VIEWASTEXT>
		<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	</object>

    <object id=gctr_data_save classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 VIEWASTEXT>
		<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
		<PARAM NAME="KeyValue" VALUE="a400140_t1(I:USER=gcds_data,O:USER2=gcds_data_appno)">
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

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//총 조회 건수
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (rowcount ==0 ){
		//alert("검색된 데이타가 없습니다.");
	}else{
		//alert("rowposition::"+rowposition);
		//alert(gcds_data.namevalue(rowposition,"ATT_FILE_NAME"));
		if(gcds_data.namevalue(rowposition,"ATT_FILE_NAME")!=""){
			fnAddFileList(gcds_data.namevalue(rowposition,"ATT_FILE_NAME"));
		}
	}
	window.status = "정상적으로 조회되었습니다.";
</script>

<script language="javascript" for="gcds_signet_gb_0" event="onloadCompleted(row,colid)">
    gcds_signet_gb_0.InsertRow(1);
    gcds_signet_gb_0.NameValue(1,"CDCODE")="";
    gcds_signet_gb_0.NameValue(1,"CDNAM")="전체";
    gclx_signet_gb_0.index = 0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_data" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>
<script language="javascript" for="gctr_data_save" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
	gcem_app_no.text=gcds_data_appno.namevalue(gcds_data_appno.rowposition,"APP_NO");
</script>
<script language="javascript" for="gctr_data_save" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data_save.ErrorCode + "\n" + "Error Message : " + gctr_data_save.ErrorMsg + "\n");
</script>
</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
	  	<td colspan=2>
	  		<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td height ="'vAlign="center"><strong><h4>&nbsp;</h4></strong></td>
					<td width="998px" align="right"  style="padding-top:4px;"> 
					    <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/btn_ReportOver.gif" style="cursor:hand" onclick="ln_Apply()" >
					    <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	 style="cursor:hand" onclick="ln_Add()" >
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	 style="cursor:hand" onclick="ln_Save()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	 style="cursor:hand" onclick="ln_Delete()">
					</td>
				</tr>
			</table>
	    </td>  
	</tr>
	<tr>
		<td height="30px" colspan=2>
			<b><font size="2" color="blue">&nbsp;◎ 법인인감 날인 신청작성</font></b>
		<td>
	</tr>
	<tr>
		<td colspan=2 >
		<table cellpadding="1" cellspacing="0" border="0" style='width:1004px;height:30px;border:1 solid #708090'>
			<tr>
				<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>신청번호</nobr> </td>
				<td class="tab21" >
					<comment id="__NSID__">
						<object id=gcem_app_no  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:100px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="#00000000-0000">
							<param name=PromptChar	  value="_">
							<param name=UpperFlag     value=1>
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#C0C0C0">
 						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
				
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>소속</nobr> </td>
				<td class="tab21">
					 <input id="txt_app_teamcd"  type=hidden  style= "position:relative;top:0px;left:4px;width:50px; height:20px;"  class="txtbox"  maxlength=7; "  >
				     <input id="txt_app_teamnm"  type="text"  style= "position:relative;top:0px;left:4px;width:150px; height:20px;" class="txtbox"  maxlength="36"  readOnly>			
			    </td>
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>직위</nobr> </td>
				<td class="tab21">
					 <input id="txt_app_jobcd"  type=hidden  style= "position:relative;top:0px;left:4px;width:50px; height:20px;"  class="txtbox"  maxlength=7; " >
				     <input id="txt_app_jobnm"  type="text"  style= "position:relative;top:0px;left:4px;width:100px; height:20px;" class="txtbox"  maxlength="36"  readOnly>
				</td>
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>신청자</nobr> </td>
				<td class="tab22">
					 <input id="txt_app_empno"  type=hidden  style= "position:relative;top:0px;left:4px;width:50px; height:20px;"  class="txtbox"  maxlength=7; " >
				     <input id="txt_app_empnm"  type="text"  style= "position:relative;top:0px;left:4px;width:100px; height:20px;" class="txtbox"  maxlength="36"  readOnly>
				</td>
		    </tr>
		    <tr>
				<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>인감ID</nobr> </td>
				<td class="tab21" >
					<comment id="__NSID__">
						<object id=gcem_signet_id  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:100px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="0000">
							<param name=UpperFlag     value=1>
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#C0C0C0">
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
				
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>인감관리번호</nobr> </td>
				<td class="tab21">
					<comment id="__NSID__">
						<object id=gcem_signet_mgr_no  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:150px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=IsComma       value=false>
							<param name=UpperFlag     value=1>
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#C0C0C0">
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>신청일자</nobr> </td>
				<td class="tab21">
					<comment id="__NSID__">
						<object  id=gcem_app_date classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:0px;left:4px;width:70px;height:20px;">
						<param name=Alignment	  value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=ReadOnly      value="true">
						<param name=ReadOnlyBackColor   value="#C0C0C0">
						</object> 
					</comment><script>__ws__(__NSID__);</script>	
				</td>
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>날인일자</nobr> </td>
				<td class="tab22">
					<comment id="__NSID__">
						<object  id=gcem_seal_date classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:0px;left:4px;width:70px;height:20px;">
						<param name=Alignment	  value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=ReadOnly      value="true">
						<param name=ReadOnlyBackColor   value="#C0C0C0">
						</object> 
					</comment><script>__ws__(__NSID__);</script>	
				</td>
		    </tr>
		    <tr>
		    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>용도</nobr> </td>
				<td class="tab22" colspan=7>
					<comment id="__NSID__">
						<object id=gcem_signet_use  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:800px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=GeneralEdit   value=true>
							<param name=MaxLength     value=50>
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
				
				
		    </tr>
		    <tr>
		    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>제출/사용처</nobr> </td>
				<td class="tab21" colspan=3>
					<comment id="__NSID__">
						<object id=gcem_signet_submit  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:380px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=GeneralEdit   value=true>
							<param name=MaxLength     value=50>
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
		    
		    
		    	<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>서류수</nobr> </td>
				<td class="tab21" >
					<comment id="__NSID__">
						<object id=gcem_paper_cnt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:80px;height:20px;" class="txtbox">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=UpperFlag     value=1>
							<param name=MaxLength     value=3>
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
				
				<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>날인수량</nobr> </td>
				<td class="tab22" >
					<comment id="__NSID__">
						<object id=gcem_seal_cnt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:80px;height:20px;" class="txtbox">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=UpperFlag     value=1>
							<param name=MaxLength     value=3>
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
		    </tr>
		    
		    <form name="fileForm" method="post" enctype="multipart/form-data" align="absmiddle"  > 
		    <tr>
		    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>품의서 사본명</nobr> </td>
				<td class="tab22" colspan=7>
					<input type="file"  name="filename"  style="position:relative;left:4px;top:0px;width:736px;height:20px" >
		    </tr>
		    <tr>
		    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>품의서 사본명 첨부</nobr> </td>
				<td class="tab22" colspan=7>
					<select multiple name="fileList" id="fileList" style="position:relative;left:4px;top:2px; width:230px;height:25px;border-color:#666666;background-color:#FFFOFO;font-weight:bold;">
						 <option></option>
					</select>
					<img src="<%=dirPath%>/Omsm/images/FileAddOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileUpload()">
					<img src="<%=dirPath%>/Omsm/images/FileDelOver.gif"		   style="position:relative;left:0px;top:2px;cursor:hand"  onclick="fnFileDelete()">    
		    </tr>
		    </form>
			     
			    <!-- 파일 삭제용 폼-->
				<FORM METHOD=POST NAME="file_del">
				<input type="hidden" name="realFileName">
				<input type="hidden" name="virtualFileName">
				<input type="hidden" name="saveDir">
				<input type="hidden" name="mode">
				</FORM> 
			     
			     <!-- 파일 임시 업로드용 iFrame -->
				<iframe name="tempUpload" width="0" height="0" src="about:blank"></iframe>
		    
		     <tr>
		    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>인감증명서 수량</nobr> </td>
				<td class="tab21" colspan=3 >
					<comment id="__NSID__">
						<object id=gcem_signet_certi_cnt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:3px;width:50px;height:20px;" class="txtbox">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=UpperFlag     value=1>
							<param name=MaxLength     value=3>
						</object>
					</comment><script>__ws__(__NSID__);</script><font size="2" >&nbsp;(부)</font>
				</td>
				
		    	<td class="tab11" width="100px" bgcolor="#eeeeee"><nobr>등기본등본</nobr> </td>
				<td class="tab22" colspan=3>
					<comment id="__NSID__">
						<object id=gcem_regi_cnt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:3px;width:50px;height:20px;" class="txtbox">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=UpperFlag     value=1>
							<param name=MaxLength     value=3>
						</object>
					</comment><script>__ws__(__NSID__);</script><font size="2" >&nbsp;&nbsp;(부)</font>
					&nbsp;	
					<comment id="__NSID__">
						<object id=gcra_cur_can_gb classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="position:relative;left:0px;top:3px; width:180px;height:20px" >
							<param name=Cols	value="2">
							<param name=Format	value="1^유효사항, 2^말소사항">
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
		     </tr>
		     <tr>
		    	<td class="tab11" width="120px" bgcolor="#eeeeee"><nobr>비고</nobr> </td>
				<td class="tab22" colspan=7>
					<comment id="__NSID__">
						<object id=gcem_remark  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:4px;top:0px;width:800px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=UpperFlag     value=1>
							<param name=GeneralEdit   value=true>
							<param name=MaxLength     value=50>
						</object>
					</comment><script>__ws__(__NSID__);</script>
				</td>
		    </tr>
		</table>
		</td>
	</tr>
	<tr>
		<td width="998px" align="right"  style="padding-top:4px;" colspan=2> 
			<img src="<%=dirPath%>/Sales/images/ap_line.gif"	style="cursor:hand" onclick="fnPopApline()">
		</td>
	</tr>
	<tr>
		<td height="30px" style='width:500px;height:30px;border:1 solid #708090'><b><font size="2" color="blue">&nbsp;◎ 신청팀 결재선</font></b></td>
		<td height="30px" style='width:500px;height:30px;border:1 solid #708090'><b><font size="2" color="blue">&nbsp;◎ 주관팀 결재선</font></b></td>
	</tr>
	<tr>
		<td colspan=2>
		<table cellpadding="1" cellspacing="0" border="0" style='width:950px;height:30px;border:1 solid #708090'>
			<tr>
				<td><nobr>
					<comment id="__NSID__">
			  		<object id=gcgd_appteam classid="CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" width='498px' height='120px' border='1'>
						<param name="dataid"		 value="ds_apline">
						<param name="borderstyle"    value="0">
						<param name="indwidth"       value="0">
						<param name="fillarea"		 value="true">
						<param name="colsizing"      value="true">
						<param name="editable"       value="true">
						<param name="format"		 value="  
							<C> Name='순번'	      ID=SEQ        	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	    align=center	edit=none </C> 
							<C> Name='유형'	      ID=AP_TYPE      	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center	edit=none   EditStyle=Lookup Data='ds_gc_aptype:detail:detail_nm'</C>
							<C> Name='사번'	      ID=ENO_NO   	      HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center    edit=none </C>
							<C> Name='이름'	      ID=ENO_NM       	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center	edit=none </C>
							<C> Name='직위'		  ID=JOB_NM           HeadAlign=Center HeadBgColor=#B9D4DC Width=50     align=center	edit=none </C>
							<C> Name='소속'        ID=DPT_NM   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left  	edit=none </C>
							<C> Name='결재상태'     ID=AP_STATUS_D   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	    align=center  	edit=none   EditStyle=Lookup Data='ds_gc_apsts_d:detail:detail_nm'</C>
							<C> Name='의견'        ID=SP_DESC   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	    align=left  	edit=none </C>
					  	 ">
					</object>
					</comment><script>__ws__(__NSID__);</script></nobr>
				</td>
				<td><nobr>  
					<comment id="__NSID__">
			  		<object id=gcgd_supteam classid="CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" width='498px' height='120px' border='1'>
						<param name="dataid"		 value="ds_apline2">
						<param name="borderstyle"    value="0">
						<param name="indwidth"       value="0">
						<param name="fillarea"		 value="true">
						<param name="colsizing"      value="true">
						<param name="editable"       value="true">
						<param name="format"		 value="  
							<C> Name='순번'	      ID=SEQ        	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	    align=center	edit=none </C> 
							<C> Name='유형'	      ID=AP_TYPE      	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center	edit=none   EditStyle=Lookup Data='ds_gc_aptype:detail:detail_nm'</C>
							<C> Name='사번'	      ID=ENO_NO   	      HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center    edit=none </C>
							<C> Name='이름'	      ID=ENO_NM       	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center	edit=none </C>
							<C> Name='직위'		  ID=JOB_NM           HeadAlign=Center HeadBgColor=#B9D4DC Width=50     align=center	edit=none </C>
							<C> Name='소속'        ID=DPT_NM   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left  	edit=none </C>
							<C> Name='결재상태'     ID=AP_STATUS_D   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	    align=center  	edit=none   EditStyle=Lookup Data='ds_gc_apsts_d:detail:detail_nm'</C>
							<C> Name='의견'        ID=SP_DESC   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	    align=left  	edit=none </C>
					  	 ">
					</object>
					</comment><script>__ws__(__NSID__);</script></nobr>
				</td>
			</tr>	
		</table>		
		</td>
	</tr>
	<tr>
		<td align=left colspan=2  style= "height:25px" > <font size="2" color="blue" > * 1.등록 버튼 클릭 후 입력 하시십시요.</font></td>
	</tr>
	<tr>
		<td align=left colspan=2  style= "height:25px" > <font size="2" color="blue" > * 2.신청 작성 후 저장 버튼 클릭</font></td>
	</tr>
	<tr>
		<td align=left colspan=2  style= "height:25px" > <font size="2" color="blue" > * 3.결재선지정 버튼 클릭</font></td>
	</tr>
	<tr>
		<td align=left colspan=2  style= "height:25px" > <font size="2" color="blue" > * 4.상신 버튼 클릭</font></td>
	</tr>
	<tr>
		<td align=left colspan=2  style= "height:25px" > <font size="2" color="blue" > * 5.참고 - 동일 파일명이 서버에 존재할 경우 [파일명+NO]로 자동 변경됩니다.</font></td>
	</tr>
</table>
<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
 ------------------------------------------------------------------------------>
<comment id="__NSID__">
  <object  id=gcbn_disp classid=CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='  
	<C>Col=APP_NO                  Ctrl=gcem_app_no           Param=text</C>
	<C>Col=SIGNET_ID               Ctrl=gcem_signet_id        Param=text</C>
	<C>Col=SIGNET_USE              Ctrl=gcem_signet_use       Param=text</C>
	<C>Col=SIGNET_SUBMIT           Ctrl=gcem_signet_submit    Param=text</C>
	<C>Col=PAPER_CNT               Ctrl=gcem_paper_cnt        Param=text</C>
	<C>Col=SEAL_CNT                Ctrl=gcem_seal_cnt         Param=text</C>
	<C>Col=ATT_FILE_NAME           Ctrl=fileList              Param=text</C>
	<C>Col=SIGNET_CERTI_CNT        Ctrl=gcem_signet_certi_cnt Param=text</C>
	<C>Col=REGI_CNT                Ctrl=gcem_regi_cnt         Param=text</C>
	<C>Col=CUR_CAN_GB              Ctrl=gcra_cur_can_gb       Param=codevalue</C>
	<C>Col=SEAL_DATE               Ctrl=gcem_seal_date        Param=text</C>
	<C>Col=SIGNET_MGR_NO           Ctrl=gcem_signet_mgr_no    Param=text</C>
	<C>Col=APP_TEAMCD              Ctrl=txt_app_teamcd        Param=value</C>
	<C>Col=APP_JOBCD               Ctrl=txt_app_jobcd         Param=value</C>
	<C>Col=APP_EMPNO               Ctrl=txt_app_empno         Param=value</C>
	<C>Col=APP_DATE                Ctrl=gcem_app_date         Param=text</C>
	<C>Col=REMARK                  Ctrl=gcem_remark           Param=text</C>
	'>
  </object>
  </comment><script>__ws__(__NSID__);</script> 
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



