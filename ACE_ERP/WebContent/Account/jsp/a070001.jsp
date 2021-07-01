
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:  자금관리 - 일일자금신청
+ 프로그램 ID	:  A700001.html
+ 기 능 정 의	:  출력,조회 화면이다.
+ 작   성  자 :   
+ 서 블 릿 명	:	
------------------------------------------------------------------------------
+ 수 정 내 용  :	팝업창 수정 및 개선사항 수정   
+ 수   정  자  :  이민정
+ 수 정 일 자  :  2006.12.13
-----------------------------------------------------------------------------
+ 수 정 내 용  :	출력물 수정 및 개선사항 수정
+ 수   정  자  :  이민정
+ 수 정 일 자  :  2007. 2. 23
+ 서 블 릿 명	: a070001_s1, a070001_s2, a070001_t1
-----------------------------------------------------------------------------
+ 수 정 내 용  :	신청금액 수기 입력 안되게 함. 내역확인 팝업에서 잠금 되면 상태값에 관계없이 조회 안되게 함. 
+ 수   정  자  : 정영식
+ 수 정 일 자  : 2014. 4. 9
+ 서 블 릿 명  : 
-----------------------------------------------------------------------------
+ 수 정 내 용  : 출력물 수정 	
+ 수   정  자   : 정영식
+ 수 정 일 자  : 2015. 1. 13
+ 서 블 릿 명  : 

-----------------------------------------------------------------------------
+ 수 정 내 용  : 일일자금신청 - 지급기준 현금 공백 후 필수항목으로 처리  	
+ 수   정  자   : 정영식
+ 수 정 일 자  : 2017. 4. 10
+ 서 블 릿 명  :
------------------------------------------------------------------------------>

<html>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>


<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>일일자금신청</title> 

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">

</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_date3 = gcurdate.substring(0,4);
var gs_date4 = gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;
var g_end = "";	//마감여부CHK
var gs_chk = gs_deptcd;

var g_arrParam	= new Array();



var ENO_NM1;
var DPT_NM1;
var JOB_NM1;
						
var ENO_NM2;
var DPT_NM2;
var JOB_NM2;

var ENO_NM3;
var DPT_NM3;
var JOB_NM3;						

var ENO_NM4;
var DPT_NM4;
var JOB_NM4;	

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();
	ln_DispChk(0);
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(s){
	if(s=="01") {
		var str1  = gclx_sfdcode1.BindColVal;				    //지점코드   
		var str2  = gclx_cadeptcd.BindColVal;					  //부서코드       
		var str3  = fn_trim(gcem_sgetdatefr1.text);	    //신청일자
		var str4  = fn_trim(gcem_sgetdateto2.text);	    //신청일자 
		var str5  = gs_userid;                          //ID 체크 
		var str6 = "";	                                //구분값

		if (str5 =="6070001"||str5 =='2060005' ||str5=='2020029'||str5=='6060002') {
			str6 = "1";
		}else  {
			str6 = "2";
		}

		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070001_s1"
											+ "?v_str1="+str1
											+"&v_str2="+str2
											+"&v_str3="+str3
											+ "&v_str4="+str4
	 										+ "&v_str5="+str5
											+ "&v_str6="+str6;
		gcds_data1.Reset();
	
	}else if(s=="02") {
		var str1  = gclx_sfdcode2.BindColVal;				    //지점코드   
		var str2  = gclx_cadeptcd2.BindColVal;					//부서코드       
		var str3  = fn_trim(gcem_sgetdatefr2.text);	    //신청일자
		var str4  = gs_userid;          //ID 체크 
		var str5 = "";	//구분값

		if (str4 =="6070001"||str4 =='2060005' ||str4=='2020029'||str4=='6060002') {
			str5 = "1";
		}else  {
			str5 = "2";
		}

		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070001_s2"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str3+"&v_str5="+str4+"&v_str6="+str5;
    //prompt('',gcds_data2.DataID);
		gcds_data2.Reset();

		gcds_temp.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s6"
											+ "?v_str1="+str1+"&v_str2="+str3;
		gcds_temp.Reset();
	}
}


/******************************************************************************
	Description : 마감체크
******************************************************************************/
function magam_check(){

		var str1  = gclx_sfdcode2.BindColVal;				    //지점코드   
		var str2  = fn_trim(gcem_sgetdatefr2.text);				 //신청일자  

		gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070001_s3"
											+ "?v_str1="+str1+"&v_str2="+str2;
										
		gcds_data3.Reset();
}
/******************************************************************************
	Description : 중복체크
******************************************************************************/
function double_check(){

		var str1  = gclx_sfdcode2.BindColVal;				    //지점코드   
		var str2  = gclx_cadeptcd2.BindColVal;					//부서코드       
		var str3  = fn_trim(gcem_sgetdatefr2.text);	           //신청일자
 		var str4  =  "";//gclx_com.BindColVal;

		gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070001_s4"
									+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4;		
		gcds_data4.Reset();
}

/******************************************************************************
	Description : Header 설정
******************************************************************************/
function ln_HederSet(){
  if(gcds_data2.countrow<1){
		var THeader1 = "FDCODE:STRING,ACDATE:STRING,DEPTCD:STRING,REMCODE:STRING,AMTDIV:STRING,"
								 + "PLAMT:DECIMAL,EXAMT:DECIMAL,REMARK:STRING,EXDATE:STRING,STATDIV:STRING,"
								 + "ATKORNAM:STRING,VENDCD:STRING,VENDNM:STRING,UPDT:STRING,UPID:STRING,"
								 + "ORGFDCODE:STRING,ORGACDATE:STRING,ORGDEPTCD:STRING,ORGREMCODE:STRING,ORGAMTDIV:STRING,"
								 + "ORGVENDCD:STRING,ORGPLAMT:DECIMAL";
		gcds_data2.SetDataHeader(THeader1);
	}
}

/******************************************************************************
	Description : Header 설정
******************************************************************************/
function ln_PrintHederSet(){

	var THeader1 = "FDCODE:STRING,ACDATE:STRING,DEPTCD:STRING,REMCODE:STRING,AMTDIV:STRING,AMTDIV1:STRING,"
						   + "PLAMT:DECIMAL,EXAMT:DECIMAL,REMARK:STRING,EXDATE:STRING,STATDIV:STRING,"
						   + "ATKORNAM:STRING,VENDCD:STRING,VENDNM:STRING,UPDT:STRING,UPID:STRING";
	gcds_temp01.SetDataHeader(THeader1);

	var THeader2 = "CURDT:STRING,KBUNAM:STRING,CURDT2:STRING,JOB1:STRING,JOB2:STRING,JOB3:STRING,JOB4:STRING,NM1:STRING,NM2:STRING,NM3:STRING,NM4:STRING";
	gcds_temp02.SetDataHeader(THeader2);

}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 등록버튼
******************************************************************************/
function ln_Insert(){
	ln_HederSet();
	if(g_end!="Y") {
		var row = gcds_data2.rowposition;
		gcds_data2.AddRow();
		//gclx_amtdiv2.bindcolval = "C";	
	}else alert("이미 마감처리되었습니다");
}

/******************************************************************************
	Description : 저장버튼
******************************************************************************/
function ln_Save(){
	if(gcds_data2.countrow>0){
		if(g_end!="Y") {
			if (gcds_data2.IsUpdated){
				if(ln_Chk()){
    
          			ln_orgData();
					var str1  = gclx_sfdcode2.bindcolval;				//지점코드  
					var str2  = fn_trim(gcem_sgetdatefr2.text);	//신청일자		
					var str3  = gclx_cadeptcd2.bindcolval;			//부서코드 		
					gctr_code02.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070001_t1?";
					gctr_code02.Parameters = "v_str1="+str1+",v_str2="+str2+",v_str3="+str3
										  + ",v_str4="+gs_date+",v_str5="+gs_userid;
					//prompt('',gcds_data2.text);
					//prompt('',gctr_code02.Parameters);
					
					gctr_code02.post();
				}
			}else alert("변경된 정보가 없습니다.");
		}else alert("이미 마감처리되었습니다");
	}else alert("저장할 정보가 없습니다.");
}

/******************************************************************************
	Description : 데이타 저장시 키값저장
******************************************************************************/
function ln_orgData(){
		for(i=1;i<=gcds_data2.countrow;i++){
			if(gcds_data2.SysStatus(i)==3){
				 gcds_data2.namevalue(i,"ORGFDCODE")=gcds_data2.OrgNameValue(i,"FDCODE");
				 gcds_data2.namevalue(i,"ORGACDATE")=gcds_data2.OrgNameValue(i,"ACDATE");
				 gcds_data2.namevalue(i,"ORGDEPTCD")=gcds_data2.OrgNameValue(i,"DEPTCD");
				 gcds_data2.namevalue(i,"ORGREMCODE")=gcds_data2.OrgNameValue(i,"REMCODE");
				 gcds_data2.namevalue(i,"ORGAMTDIV")=gcds_data2.OrgNameValue(i,"AMTDIV");
				 gcds_data2.namevalue(i,"ORGVENDCD")=gcds_data2.OrgNameValue(i,"VENDCD");
				 gcds_data2.namevalue(i,"ORGPLAMT")=gcds_data2.OrgNameValue(i,"PLAMT");
			}
		}
}
/******************************************************************************
	Description : 필수항목 입력체크 
******************************************************************************/
function ln_Chk() {
	if(fn_trim(txt_atcode_fr.value)=="") {
		alert("계정과목을 입력하십시요.");
		txt_atcodenm_fr.focus();
		return false;
	}
	
	//거래처 
	if(fn_trim(txt_vendcd.value)=="") {
		alert("거래처를 입력하십시요.");
		txt_vendcd.focus();
		return false;
	}
	
	
	//지급기준  
	if(gclx_amtdiv2.bindcolval=="") {
		alert("지급기준을 선택하십시요.");
		return false;
	}
		
	
	//신청금액
	if(gcem_plamt2.text==0||gcem_plamt2.text=="") {
		alert('신청금액을 입력하십시요.');
		gcem_plamt2.focus();
		return false;
	}
	
	
	//결재일자
	if(gcem_exdate2.text=="") {
		alert('결재일자를 입력하십시요.');
		gcem_exdate2.focus();
		return false;
	}
	
	
	
	//적요
	if(fn_trim(txt_remark2.value)=="") {
		alert('적요를 입력하십시요.');
		txt_remark2.focus();
		return false;
	}
	
	
	return true;
}

/******************************************************************************
	Description : 삭제버튼
******************************************************************************/
function ln_Delete(){
	if(gcds_data2.countrow>0){
		magam_check();
		if(gcds_data3.countrow > 0) {alert("마감처리되어서 삭제할수 없습니다."); return;
		}else{
			var str1  = gclx_sfdcode2.BindColVal;				    //지점코드  
			var str2  = fn_trim(gcem_sgetdatefr2.text);	    //신청일자		
			var str3  = gclx_cadeptcd2.BindColVal;					//부서코드
			if (confirm("삭제 하시겠습니까?")){
				gcds_data2.deleterow(gcds_data2.rowposition);
				gctr_code02.action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070001_t1?";
				gctr_code02.Parameters = "v_str1=" + str1 +",v_str2=" + str2+",v_str3=" + str3;
				gctr_code02.post();
				ln_Query('02');
			}
		}
	}else alert("삭제할 정보가 없습니다.");
}

/***********************************************************************************************
	Description : 계정코드 
	parameter   : p1 - 구분  p2-구분2, p3-자금구분값 obj
**********************************************************************************************/
function ln_Popup3(p1,p2,p3,obj1,obj2){ 
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	if(gcds_data2.namevalue(gcds_data2.rowposition,"ATKORNAM")!=""){
	    alert("신규 등록시에만 계정과목 찾기가 가능합니다.");
		return false;
	}
	

	if (p1=="01"){//계정과목
		strURL = "./actcode_fund_popup2.jsp";
		arrParam[0]=eval(obj1).value;
		arrParam[1]=eval(obj2).value;
		arrParam[2]="C";//p3;
		arrParam[3]="ATUSEYN";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			if(p2=="fr"){
				txt_atcode_fr.value = arrParam[0];
				txt_atcodenm_fr.value = arrParam[1];
				gstr_fundiv = arrParam[2];
			}

		} else {
			if(p2=="fr") {
			    txt_atcode_fr.value="";
				txt_atcodenm_fr.value="";
				gstr_fundiv = "";
			}
		}
	}
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(e){
  if(e=="01") {
		if(gcds_data1.countrow<1) {
			alert("출력할 정보가 없습니다.");
		}else{
			gcds_temp01.clearall();
			gcds_temp02.clearall();
			ln_PrintHederSet();
			gcds_temp01.ImportData(gcds_data1.ExportData(1,gcds_data1.countrow,false));
			gcds_temp02.addrow();
			gcds_temp02.namevalue(gcds_temp02.rowposition,"CURDT")= gcem_sgetdatefr1.text;
			gcds_temp02.namevalue(gcds_temp02.rowposition,"CURDT2")= gcem_sgetdateto2.text;
			
			gcds_temp02.namevalue(gcds_temp02.rowposition,"KBUNAM")=gclx_cadeptcd.text;
			/*
			for(i=1;i<=gcds_temp01.countrow;i++) {
				if(gcds_temp01.namevalue(i,"AMTDIV")=="C")	gcds_temp01.namevalue(i,"AMTDIV1")="현금";
				else if(gcds_temp01.namevalue(i,"AMTDIV")=="B") gcds_temp01.namevalue(i,"AMTDIV1")="어음";
				else if(gcds_temp01.namevalue(i,"AMTDIV")=="D") gcds_temp01.namevalue(i,"AMTDIV1")="보통예금";
        		else if(gcds_temp01.namevalue(i,"AMTDIV")=="E") gcds_temp01.namevalue(i,"AMTDIV1")="현금";
			}
			*/
			
			if (confirm("결재라인을 작성하시겠습니까?")){

				if (confirm("정말 작성하시겠습니까? 안하셔도 됩니다.")){

					strURL = "./a070001_approval.jsp";
					strPos = "dialogWidth:500px;dialogHeight:300px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
					//result = showModalDialog(strURL,arrParam,strPos);
					result = showModalDialog(strURL,window,strPos);
					
					if (result != null) {
						
						//alert(result);
						
						arrResult = result.split(";");
						
						ENO_NM1 = arrResult[0];
						DPT_NM1 = arrResult[1];
						JOB_NM1 = arrResult[2];

						ENO_NM2 = arrResult[3];
						DPT_NM2 = arrResult[4];
						JOB_NM2 = arrResult[5];
						
						ENO_NM3 = arrResult[6];
						DPT_NM3 = arrResult[7];
						JOB_NM3 = arrResult[8];						
						
						ENO_NM4 = arrResult[9];
						DPT_NM4 = arrResult[10];
						JOB_NM4 = arrResult[11];							

					}else{
						

					}					

				}		
				
			}
			
			//alert(ENO_NM4);
			//alert(DPT_NM4);	
			
			
			gcds_temp02.namevalue(gcds_temp02.rowposition,"JOB1")= JOB_NM1;
			gcds_temp02.namevalue(gcds_temp02.rowposition,"JOB2")= JOB_NM2;			
			gcds_temp02.namevalue(gcds_temp02.rowposition,"JOB3")= JOB_NM3;			
			gcds_temp02.namevalue(gcds_temp02.rowposition,"JOB4")= JOB_NM4;			
			
			gcds_temp02.namevalue(gcds_temp02.rowposition,"NM1")= ENO_NM1;
			gcds_temp02.namevalue(gcds_temp02.rowposition,"NM2")= ENO_NM2;
			gcds_temp02.namevalue(gcds_temp02.rowposition,"NM3")= ENO_NM3;			
			gcds_temp02.namevalue(gcds_temp02.rowposition,"NM4")= ENO_NM4;
			

			
			
			gcrp_print1.preview();
			
			
			JOB_NM1 = "";
			JOB_NM2 = "";
			JOB_NM3 = "";
			JOB_NM4 = "";	
			
			ENO_NM1 = "";
			ENO_NM2 = "";
			ENO_NM3 = "";
			ENO_NM4 = "";
			
			gcds_temp02.clearall();
		}
	}
  
	
  
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(e){
	if(e=="01"){
		if (gcds_data1.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_disp01.RunExcel('신청현황');
	}
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
	gcem_sgetdatefr1.text = gs_date2+"01";	 
	gcem_sgetdateto2.text = gs_date;	

	gcem_sgetdatefr2.text = gs_date;	
	//gclx_amtdiv2.bindcolval = "C";	//지급기준(현금)
	
	gcds_sfdcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode1.Reset();

	gcds_sfdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode2.Reset();

	gcds_dept1.DataID = "<%=dirPath%>/servlet/Person.hcdept_s2?v_str1=";
	
	//prompt('',gcds_dept1.DataID);
	gcds_dept1.Reset();

	gcds_dept2.DataID = "<%=dirPath%>/servlet/Person.hcdept_s2?v_str1=";
	gcds_dept2.Reset();

	//gcds_com.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0054"; 
	//gcds_com.Reset();

	gcds_temp.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s6?v_str1="+gclx_sfdcode2.BindColVal
									 + "&v_str2="+fn_trim(gcem_sgetdatefr2.text);
	gcds_temp.Reset();
}

/******************************************************************************
	Description : lost focus 시 
	prameter    : p1 - 01 전표작성
	                   02 내역조회
								p2 - atcode:계정
								obj
******************************************************************************/
function ln_Blur(p1,p2,obj1,obj2){
	if(p1=="01"){
		if(p2=="atcode"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 또는 Enter 
				ln_Popup3('01','fr','B',obj1,obj2);
		}
	}
}

/******************************************************************************
	Description : 찾기 - 거래처코드
******************************************************************************/
function ln_Popup(){

	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		txt_vendcd.value  = arrParam[0];
		txt_vendnm.value	= arrParam[1];
	} else {
		txt_vendcd.value	= "";
		txt_vendnm.value	= "";
	}
}

/******************************************************************************
	Description : 탭구분
	prameter    : 0-일별코드, 1-월별항목
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp1","div_disp2");
	for(var i=0;i<=1;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
}

/******************************************************************************
	Description : 반제 List 조회
	prameter    : 
******************************************************************************/
function ln_Popup_Repay(){
  
	var result="";
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	g_arrParam[0]=txt_atcode_fr.value;               //계정코드
	g_arrParam[1]=txt_atcodenm_fr.value;             //계정명
	g_arrParam[2]=txt_vendcd.value;                  //거래처코드
	g_arrParam[3]=txt_vendnm.value;                  //거래처명
	g_arrParam[4]=gclx_sfdcode2.bindcolval;					 //FDCODE
	g_arrParam[5]="";	                               //반제전표 FSDAT
	g_arrParam[6]="";						                     //반제전표 FSNBR
	g_arrParam[7]="";					                       //전표행번호 seq
	g_arrParam[8]="";                                //반제단위 관리항목 
	g_arrParam[9]="";                                //반제단위값
	g_arrParam[10]="";                               //반제단위값 명칭
	g_arrParam[11]=gs_userid;                        //작성자
	
	strURL = "./a070001_repay_popup.jsp";
	strPos = "dialogWidth:878px;dialogHeight:510px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	//result = showModalDialog(strURL,arrParam,strPos);
	result = showModalDialog(strURL,window,strPos);

  //alert("result:"+result);
	if (result != null) {
		arrResult = result.split(";");
		if(arrResult[0]!=0){         //차변이 0이 아닐 경우 대변 금액
			gcem_plamt2.text=arrResult[0];
		}else if(arrResult[1]!=0){   //대변이 0이 아닐 경우 차변 금액
			gcem_plamt2.text=arrResult[1];
		}
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr     value="+EXDATE+AMTDIV1">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_sfdcode1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><OBJECT id="gcds_dept1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><OBJECT id="gcds_dept2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_com" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id="gcds_temp" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id="gcds_temp01" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad"   VALUE="false">
<param name=SortExpr     value="+EXDATE+AMTDIV1">
<param name=SubSumExpr   value="1:EXDATE:AMTDIV1">


</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id="gcds_temp02" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__"><object  id="gcds_orgdata2" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_code02" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
<PARAM NAME="KeyValue" VALUE="a070001_t1(I:USER=gcds_data2)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
	}
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt02.innerText = "조회건수 : " + row + " 건";
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
	}
</script>

<script language="javascript" for="gcds_sfdcode1" event="onloadCompleted(row,colid)">
	gcds_sfdcode1.InsertRow(1);
	gcds_sfdcode1.NameValue(1,"FDCODE")="";
	gcds_sfdcode1.NameValue(1,"FDNAME")="";
	gclx_sfdcode1.BindColVal = gs_fdcode;
</script>

<script language="javascript" for="gcds_sfdcode2" event="onloadCompleted(row,colid)">
	gcds_sfdcode2.InsertRow(1);
	gcds_sfdcode2.NameValue(1,"FDCODE")="";
	gcds_sfdcode2.NameValue(1,"FDNAME")="";
	gclx_sfdcode2.BindColVal = gs_fdcode;
</script>


<script language="javascript" for="gcds_dept1" event="onloadCompleted(row,colid)">
window.status="조회가 완료 되었습니다.";     
	gcds_dept1.InsertRow(1);
	gcds_dept1.NameValue(1,"DEPTCD")="";
	gcds_dept1.NameValue(1,"DEPTNM")="";
	gclx_cadeptcd.BindColVal = gs_deptcd;
</script>

<script language="javascript" for="gcds_dept2" event="onloadCompleted(row,colid)">
window.status="조회가 완료 되었습니다.";       
	gcds_dept2.InsertRow(1);
	gcds_dept2.NameValue(1,"DEPTCD")="";
	gcds_dept2.NameValue(1,"DEPTNM")="";
	gclx_cadeptcd2.BindColVal = gs_deptcd;
</script>

<!-- <script language="javascript" for="gcds_com" event="onloadCompleted(row,colid)">
window.status="조회가 완료 되었습니다.";       
	gcds_com.InsertRow(1);
	gcds_com.NameValue(1,"CDCODE")="";
	gcds_com.NameValue(1,"CDNAM")="";
	gclx_com.index=0;
</script> -->

<script language="javascript" for="gcds_temp" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	if (row <1) {
		g_end = "N";
	}else{
		g_end = gcds_temp.namevalue(row,"CHK");
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1)); 
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_code02" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다."); 
</script>

<script language="javascript" for="gctr_code02" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_code02.ErrorCode + "\n" + "Error Message : " + gctr_code02.ErrorMsg + "\n");
	//ln_Query('02');
</script>

</head>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/a070001_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2 align=left style="position:relative;left:5px">
      <table width="0" cellpadding="1" cellspacing="0" border="0" style="position:relative;top:4px;left:-6px;">
				<tr> 
					<td width="0" align=left><nobr>
					  <comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;">
						  <PARAM NAME="BackColor"					VALUE="#cccccc">
   					      <PARAM NAME="titleHeight"				VALUE="20px">
						  <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
						  <PARAM NAME="Format"						VALUE="
								<T>divid=div_1		title=신청현황</T>									
							    <T>divid=div_2		title=자금신청</T>							 
						  ">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
        </tr>
      </table>
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
		
<!-- 신청현황 ===========================================================================================================-->
<!--<fieldset id=field1 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >
	<tr>
		<td height="3px">
		</td>
	</tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:0px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>지점구분</nobr>
					</td>
					<td class="tab23" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode1">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>부서</nobr>
					</td>
					<td class="tab23" style="width:120px"><comment id="__NSID__">
						<OBJECT id=gclx_cadeptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=110 style="position:relative;left:6px;top:0px;" class="txtbox" >
								<param name=ComboDataID			value="gcds_dept1">
								<param name=CBDataColumns		value="DEPTCD,DEPTNM">
								<param name=SearchColumn		value="DEPTNM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="DEPTNM^0^110">
								<param name=BindColumn			value="DEPTCD">
							</OBJECT></comment><script>__ws__(__NSID__);</script> 	
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>신청일자</nobr>
					</td>
					<td style="width:210px">
						<comment id="__NSID__"><object id=gcem_sgetdatefr1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=Format			value="YYYY/MM/DD">
							<param name=PromptChar		value="_">
							<param name=Enable			value="true">
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdatefr1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~
						<comment id="__NSID__"><object id=gcem_sgetdateto2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=Format			value="YYYY/MM/DD">
							<param name=PromptChar		value="_">
							<param name=Enable			value="true">
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_sgetdateto2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</td>
					<td align="right">&nbsp;<nobr>      
						<img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('01')">
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Excel('01')">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('01')"> 
						</nobr>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td ALIGN=CENTER>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
				<tr> 
					<td style="width:460" ALIGN=LEFT VALIGN=TOP><comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:-1px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data1">
							<PARAM NAME="Editable"			VALUE="false">
							<PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM NAME="IndWidth"			VALUE="0">
                            <PARAM NAME="Sortview"		VALUE="left">
							<PARAM NAME="ColSizing"			VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<PARAM NAME="viewSummary"		VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<C> Name='No.'			ID={CURROW}	    HeadAlign=Center HeadBgColor=#B9D4DC Width=30	align=center sort=true	SumText=''		SumBgColor='#C3D0DB'</C> 
								<C> Name='신청여부'		ID=STATDIV	    HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=center sort=false SumText=''		SumBgColor='#C3D0DB' </C>
								<C> Name='신청일자'		ID=ACDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=center sort=true  SumText='합계'	SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
								<C> Name='지급기한'		ID=EXDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=center sort=true  SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX' </C>
								
								<C> Name='지급기준'		ID=AMTDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=center sort=true	SumText=''		SumBgColor='#C3D0DB' EditStyle='combo' Data='C:현금,B:어음,D:보통예금,E:현금,F:현금(외화),G:외화보통예금'</C>

								<C> Name='계정과목'		ID=ATKORNAM	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left	 sort=true	SumText=''      SumBgColor='#C3D0DB'</C>
								<C> Name='거래처'			ID=VENDCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=left	 sort=true	SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='거래처'			ID=VENDNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=140	align=left	 sort=true	SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='적요'			ID=REMARK		HeadAlign=left	 HeadBgColor=#B9D4DC Width=190	align=left	 sort=true	SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='신청금액'		ID=PLAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=right	 sort=true	SumText=@sum	SumBgColor='#C3D0DB'</C>
								">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:-1px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>  
					</td>
				<td>
			</table>			
		</td> 
	</tr> 
</table> 

<!-- 자금신청 ===========================================================================================================-->
<!--<fieldset id=field2 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>-->
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="position:absolute;top:66px;display:none;">	
	<tr>
		<td height="3px">
		</td>
	</tr>
	<tr>
		<td height="3px">
		</td>
	</tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:0px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>지점구분</nobr>
					</td>
					<td class="tab23" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode2">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>부서</nobr>
					</td>
					<td class="tab23" style="width:120px">
						<comment id="__NSID__"><OBJECT id=gclx_cadeptcd2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=110 style="position:relative;left:6px;top:0px;" class="txtbox" >
							<param name=ComboDataID			value="gcds_dept2">
							<param name=CBDataColumns		value="DEPTCD,DEPTNM">
							<param name=SearchColumn		value="DEPTNM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="DEPTNM^0^110">
							<param name=BindColumn			value="DEPTCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 			
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>신청일자</nobr>
					</td>
					<td style="width:210px">
						<comment id="__NSID__"><object id=gcem_sgetdatefr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdatefr2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</td>
					<td align="right">&nbsp;<nobr>  
						<IMG src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand;position:relative;top:2px;right:2px" onclick="ln_Delete()"> 
						<IMG  src="../../Common/img/btn/com_b_insert.gif"  style="cursor:hand;position:relative;top:2px;right:2px" onclick="ln_Insert()" >
						<IMG  src="../../Common/img/btn/com_b_save.gif"    style="cursor:hand;position:relative;top:2px;right:2px"  onclick="ln_Save()">
						<IMG src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('02')"> 
						</nobr>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td ALIGN=CENTER>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
				<tr>
					<td style="width:460" ALIGN=LEFT VALIGN=TOP><comment id="__NSID__">
						<OBJECT id=gcgd_data2 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:520px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:-1px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data2">
							<PARAM NAME="Editable"			VALUE="false">
							<PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM NAME="IndWidth"			VALUE="0">
							<PARAM NAME="ColSizing"			VALUE="true">
							<param NAME="Fillarea"			VALUE="true">
							<PARAM NAME="viewSummary"		VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<C> Name='No.'			ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 						
							    <C> Name='계정과목'	ID=ATKORNAM	HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left		SumText='계'	SumBgColor='#C3D0DB'</C>
								<C> Name='거래처'		ID=VENDNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=210	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='신청금액'	ID=PLAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=right		SumText=@sum	SumBgColor='#C3D0DB' Edit=Numeric</C>	
								<C> Name='적요'			ID=REMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=210	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:-1px;width:522px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt02" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
					<td>
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:343px;height:402px;border:1 solid #708090;position:relative;left:1px'>
							<tr>
								<td class="tab11"  bgcolor="#eeeeee">계정과목</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;">
									<input id="txt_atcodenm_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:6px;width:115px; height:20px;ime-mode:active;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode_fr', 'txt_atcodenm_fr')">
									<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정과목을 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px;" align=center onclick="ln_Popup3('01','fr','B','txt_atcode_fr','txt_atcodenm_fr');">
									<input id="txt_atcode_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-2px;width:50px; height:20px;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode_fr','txt_atcodenm_fr')" disabled>
								</td>
							</tr>
							<tr>
								<td class="tab11"  bgcolor="#eeeeee">거 래 처</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;">
									<input id="txt_vendnm" type="text" class="txtbox"  style= "position:relative;top:0px;left:6px;width:115px; height:20px;ime-mode:active;" maxlength="36" >
									<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px;" align=center onclick="ln_Popup();">
									<input id="txt_vendcd" type="text" class="txtbox"  style= "position:relative;top:0px;left:-2px;width:50px; height:20px;" maxlength="36" disabled>
								</td>
							</tr>
							<tr>
								<td class="tab11"  bgcolor="#eeeeee">지급기준</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;width:130px"><comment id="__NSID__">
									<object  id=gclx_amtdiv2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:100px;height:110px;">
										<param name=CBData				value="^,C^현금,D^보통예금,G^외화보통예금,F^현금(외화)">
										<param name=CBDataColumns		value="CDCODE,CDNAM">
										<param name=SearchColumn		value="CDNAM">
										<param name=Sort				value="false">
										<param name=ListExprFormat	    value="CDNAM^0^110">
										<param name=BindColumn			value="CDCODE">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>											
								<td class="tab11"  bgcolor="#eeeeee" Style="height:25px;width:80px;">신청금액</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;"><comment id="__NSID__">
									<object  id=gcem_plamt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:5px;top:2px;">		
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=true>
										<param name=Numeric	      value=true>
										<param name=Format	      value="000,000,000">
										<param name=MaxLength     value=13>
										<param name=ReadOnly        value=true>
							            <param name=ReadOnlyBackColor   value="#CCFFCC">
										<param name=IsComma	      value=true>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;
									<IMG src="../../Common/img/btn/com_btn_list.gif" style="cursor:hand;position:relative;top:2px;right:2px" onclick="ln_Popup_Repay()"> 
								</td>
							</tr>
							
	                        <tr>											
								<td class="tab11"  bgcolor="#eeeeee" Style="height:25px;width:80px;">결재일자</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;"><comment id="__NSID__">
									<object id=gcem_exdate2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
										<param name=Alignment		value=0>
										<param name=Border			value=true>
										<param name=Format			value="YYYY/MM/DD">
										<param name=PromptChar	value="_">
										<param name=Enable			value="true">
									</object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar3 OnClick="__GetCallCalendar('gcem_exdate2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
								</td>
							</tr>
							<tr>											
								<td class="tab11"  bgcolor="#eeeeee" Style="height:25px;width:80px;">적&nbsp;&nbsp;&nbsp;&nbsp;요</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;">
									<input id="txt_remark2" type="text" class="txtbox" style= "width:250px;height:20px;position:relative;left:5px;" MaxLength=132>			
								</td>
							</tr>
							<tr>
								<td colspan=2 style="height:100%;border:0 solid #708090;">&nbsp;
								</td>
							</tr>
						</table>
					</TD>
				</tr>
			</table>
		</td>
	</tr>
</table>
			 
</td> 
</tr> 
</table> 
			 
<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data2>
	<param name=BindInfo  value=' 
		<C>Col=REMCODE		Ctrl=txt_atcode_fr			Param=value</C>
		<C>Col=ATKORNAM		Ctrl=txt_atcodenm_fr		Param=value</C>
		<C>Col=VENDCD		Ctrl=txt_vendcd				Param=value</C>
		<C>Col=VENDNM		Ctrl=txt_vendnm				Param=value</C>
		<C>Col=PLAMT		Ctrl=gcem_plamt2			Param=text</C>
		<C>Col=AMTDIV		Ctrl=gclx_amtdiv2			Param=bindcolval</C>
		<C>Col=EXDATE		Ctrl=gcem_exdate2			Param=text</C>
		<C>Col=REMARK		Ctrl=txt_remark2			Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<!--param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"			value="A4">
	<param name="LandScape"			value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="SuppressColumns"	value="1:pageskip,ATCODE;"-->
	<param name="MasterDataID"		value="gcds_temp02">
	<param name="DetailDataID"		value="gcds_temp01">
	<param name="PaperSize"			value="A4">
	<param name="LandScape"			value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="NullRecordFlag"    value="false">
	<PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<param name="Format"			value="
<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=526 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=74 ,top=204 ,right=913 ,bottom=278 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=69 ,top=191 ,right=902 ,bottom=270 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='일 일  자 금  신 청 서' ,left=71 ,top=198 ,right=894 ,bottom=259 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=2400 ,top=11 ,right=2400 ,bottom=251 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='현' ,left=1987 ,top=69 ,right=2040 ,bottom=108 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='업' ,left=1987 ,top=148 ,right=2040 ,bottom=191 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2143 ,top=212 ,right=2127 ,bottom=241 </L>
	<L> left=2320 ,top=212 ,right=2305 ,bottom=241 </L>
	<L> left=2492 ,top=212 ,right=2477 ,bottom=241 </L>
	<L> left=2678 ,top=212 ,right=2662 ,bottom=241 </L>
	<L> left=2760 ,top=11 ,right=2760 ,bottom=251 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2577 ,top=11 ,right=2577 ,bottom=251 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2225 ,top=11 ,right=2225 ,bottom=251 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2045 ,top=11 ,right=2045 ,bottom=251 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1982 ,top=251 ,right=2760 ,bottom=251 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2045 ,top=198 ,right=2760 ,bottom=198 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1982 ,top=8 ,right=2760 ,bottom=8 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1982 ,top=11 ,right=2760 ,bottom=11 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2045 ,top=69 ,right=2760 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='승인' ,left=2585 ,top=16 ,right=2754 ,bottom=64 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확인' ,left=2408 ,top=16 ,right=2577 ,bottom=64 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='검토' ,left=2228 ,top=16 ,right=2397 ,bottom=64 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담당' ,left=2051 ,top=16 ,right=2223 ,bottom=64 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1982 ,top=11 ,right=1982 ,bottom=251 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='경' ,left=1987 ,top=278 ,right=2040 ,bottom=318 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='영' ,left=1987 ,top=318 ,right=2040 ,bottom=357 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관' ,left=1987 ,top=357 ,right=2040 ,bottom=397 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='리' ,left=1987 ,top=397 ,right=2040 ,bottom=439 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='팀' ,left=1987 ,top=439 ,right=2040 ,bottom=479 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2143 ,top=460 ,right=2127 ,bottom=489 </L>
	<L> left=2320 ,top=460 ,right=2305 ,bottom=489 </L>
	<L> left=2492 ,top=460 ,right=2477 ,bottom=489 </L>
	<L> left=2678 ,top=460 ,right=2662 ,bottom=489 </L>
	<L> left=2760 ,top=259 ,right=2760 ,bottom=500 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2577 ,top=259 ,right=2577 ,bottom=500 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2400 ,top=259 ,right=2400 ,bottom=500 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2225 ,top=259 ,right=2225 ,bottom=500 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2045 ,top=259 ,right=2045 ,bottom=500 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1982 ,top=500 ,right=2760 ,bottom=500 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2045 ,top=447 ,right=2760 ,bottom=447 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1982 ,top=257 ,right=2760 ,bottom=257 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1982 ,top=259 ,right=2760 ,bottom=259 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2045 ,top=318 ,right=2760 ,bottom=318 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='승인' ,left=2585 ,top=265 ,right=2754 ,bottom=312 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확인' ,left=2408 ,top=265 ,right=2577 ,bottom=312 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='검토' ,left=2228 ,top=265 ,right=2397 ,bottom=312 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담당' ,left=2051 ,top=265 ,right=2223 ,bottom=312 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1982 ,top=259 ,right=1982 ,bottom=500 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURDT2', left=540, top=381, right=1135, bottom=442, align='left' ,mask='~    XXXX/XX/XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='KBUNAM', left=310, top=447, right=902, bottom=500, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CURDT', left=310, top=381, right=529, bottom=442, align='left' ,mask='XXXX/XX/XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='신 청 일 자 :' ,left=74 ,top=381 ,right=304 ,bottom=442 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='신 청 부 서 :' ,left=74 ,top=447 ,right=304 ,bottom=500 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>

	<C>id='JOB1', left=2051, top=204, right=2122, bottom=249, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB2', left=2230, top=204, right=2302, bottom=249, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB3', left=2405, top=204, right=2477, bottom=249, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB4', left=2582, top=204, right=2654, bottom=249, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NM1', left=2146, top=204, right=2217, bottom=249, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NM2', left=2320, top=204, right=2392, bottom=249, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NM3', left=2495, top=204, right=2566, bottom=249, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NM4', left=2683, top=204, right=2754, bottom=249, face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>

</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=100 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='일자' ,left=82 ,top=50 ,right=151 ,bottom=90 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=64 ,top=3 ,right=64 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=265 ,top=3 ,right=265 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=64 ,top=3 ,right=265 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1725 ,top=3 ,right=1725 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='구분' ,left=183 ,top=13 ,right=251 ,bottom=53 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2352 ,top=3 ,right=2352 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=468 ,top=5 ,right=468 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=709 ,top=5 ,right=709 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1032 ,top=5 ,right=1032 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=64 ,top=3 ,right=2765 ,bottom=3 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=64 ,top=98 ,right=2765 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2765 ,top=3 ,right=2765 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='지급기한' ,left=278 ,top=21 ,right=458 ,bottom=85 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급기준' ,left=503 ,top=21 ,right=675 ,bottom=85 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계정과목' ,left=722 ,top=21 ,right=1021 ,bottom=85 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거래처' ,left=1048 ,top=21 ,right=1715 ,bottom=82 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='적 요' ,left=1741 ,top=21 ,right=2342 ,bottom=85 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='신청금액' ,left=2373 ,top=21 ,right=2754 ,bottom=85 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=66 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=64 ,top=0 ,right=64 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=265 ,top=0 ,right=265 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=468 ,top=0 ,right=468 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='ACDATE', left=74, top=3, right=257, bottom=61 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{IF(curlevel=2,'',IF(curlevel=1,'',EXDATE))}', left=278, top=3, right=458, bottom=61 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,\'소계\',AMTDIV1)}', left=479, top=0, right=706, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=709 ,top=0 ,right=709 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='ATKORNAM', left=720, top=0, right=1021, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VENDCD', left=1048, top=0, right=1204, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VENDNM', left=1214, top=0, right=1715, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=64 ,top=66 ,right=2765 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2765 ,top=0 ,right=2765 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1032 ,top=0 ,right=1032 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1725 ,top=0 ,right=1725 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='REMARK', left=1738, top=0, right=2339, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2352 ,top=0 ,right=2352 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='PLAMT', left=2373, top=3, right=2754, bottom=61, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2871 ,bottom=318 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=265 ,top=0 ,right=265 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=64 ,top=0 ,right=64 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='합계' ,left=71 ,top=3 ,right=259 ,bottom=61 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=468 ,top=0 ,right=468 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=64 ,top=66 ,right=2765 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2765 ,top=0 ,right=2765 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=709 ,top=0 ,right=709 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1032 ,top=0 ,right=1032 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1725 ,top=0 ,right=1725 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2352 ,top=0 ,right=2352 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<S>id='{Sum(PLAMT)}' ,left=2373 ,top=0 ,right=2754 ,bottom=58 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>