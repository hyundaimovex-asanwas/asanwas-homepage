<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<!---------------------------------------------------------------------------
+ 시 스 템 명	:  경리회계 - 계정코드관리	
+ 프로그램 ID	:  A010002.html
+ 기 능 정 의	:  계정코드 조회 및 등록 화면이다.
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2005.10.05
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 결산보고서양식 화면 추가  
+ 수   정  자 :  이 순 미
+ 수 정 일 자 :
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 검색조건란(계정코드) 변경   
+ 수   정  자 :  구 자 헌
+ 수 정 일 자 :  2006.3.3
-----------------------------------------------------------------------------
+ 서 블 릿 명	:  a010002_s1, 
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 관리항목 화면수정 변경   
+ 수   정  자 : 하민숙
+ 수 정 일 자 : 2006.3.15
+ 변경 서블릿 : a010002_s2,a010002_t2
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 세목텝 막음.
+ 수   정  자 :   정영식
+ 수 정 일 자 : 2006.5.16.I
+ 변경 서블릿 : 
-----------------------------------------------------------------------------
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<html>
<head>

<jsp:include page="/Account/common/include/head.jsp"/>

<title>계정코드관리</title>

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


var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;


/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
    fnInit_tree(tree_idx);  //트리초기화 호출

    ln_SetDataHeader();
    ln_Before();
	ln_DispChk(0);		
	ln_Enable01("f");
}

/******************************************************************************************
	Description : 조회
	parameter   : 01 - 계정코드, 02 - 관리항목, 03 - 출력순서, 04 - Tree항목, 05 - 세목코드
******************************************************************************************/
function ln_Query(p){

	ln_Defval("s",p);

	if (p=="01"){
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s1?v_str1=C&v_str2="+gcem_atcode_11.text+"&v_str3="+gcem_atcode_12.text; 
		gcds_code01.Reset();
	}else if(p=="02"){
		gcds_code02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s1?v_str1=C&v_str2="+gcem_atcode_21.text+"&v_str3="+gcem_atcode_22.text+"&v_str4=ATUSEYN"; 
		gcds_code02.Reset();
		gcds_code02_1.ClearData();
	}else if(p=="03"){
		gcds_code03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s5?v_str1=C&v_str2="+gcem_atcode_31.text+"&v_str3="+gcem_atcode_32.text; 
		gcds_code03.Reset();
	}else if(p=="04"){
		gcds_code04.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s3?v_str1="+gcem_atcode_41.text+"&v_str2="+gcem_atcode_42.text; 
		gcds_code04.Reset();
	}else if(p=="05"){
	  /*
		gcds_code05.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s7?v_str1="+gcem_atcode_51.text+"&v_str2="+gcem_atcode_52.text; 
		gcds_code05.Reset();
		*/
	}else if(p=="06"){
		gcds_code06.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s8?v_str1="+gclx_prtcode.BindColVal;
		gcds_code06.Reset(); 
	}

}

/******************************************************************************
	Description : 관리항목조회
	parameter   : p : 02_1 - 관리항목,  04_1 - Tree항목 조회
                p2: data
******************************************************************************/
function ln_Query_1(p,p2){
	if (p=="02_1"){
		gcds_code02_1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+p2; 
		gcds_code02_1.Reset();
	}else if(p=="04_1"){
		gcds_code04_1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s4?v_str1="+p2;
		gcds_code04_1.Reset();
	}
}

/*****************************************************************************************
	Description : 추가
	parameter   : 01 - 계정코드, 02 - 관리항목, 03 - 출력순서, 04 - Tree항목, 05 - 세목코드, 06 - 결산보고서양식
*****************************************************************************************/
function ln_Add(p){
  	if (p=="01"){
		gcds_code01.addrow();
		ln_Defval("a",p);
		ln_Enable("t",p);
		gcem_atcode.focus();
	}else if(p=="02"){
        gcds_code02_1.addrow();
        //prompt("",gcds_code02_1.text);
		ln_Add_Status("02_1");
	}else if(p=="03"){
	}else if(p=="04"){
	}else if(p=="05"){
		gcds_code05.addrow();
		ln_Defval("a",p);
		ln_Enable("t",p);
		//gcem_atcode.focus();
	}else if(p=="06"){
		gcds_code06.addrow();
		var row06 = gcds_code06.rowposition;
		gcds_code06.namevalue(row06,"PRTCODE") = gclx_prtcode.BindColVal;
	}
}

/******************************************************************************************
	Description : 계정코드 체크(결산보고서 양식)
******************************************************************************************/
function ln_AtcodeChk(){
	var chk1 ="";
	if(gcra_atbalshtyn.CodeValue=="Y") {
		for(var i=1;i<=gcds_temp08.countrow;i++) {
			if (gcem_atcode.text != gcds_temp08.namevalue(i,"ATCODE")) {		
			}else{
				chk1 = "Y";
			}
		}
		
		if (chk1 != "Y") alert("등록되지 않은 계정코드이므로 결산보고서양식에 추가해주십시오.");
	}
}

/******************************************************************************************
	Description : 저장
	parameter   : 01 - 계정코드, 02 - 관리항목, 03 - 출력순서, 04 - Tree항목, 05 - 세목코드, 06 - 결산보고서양식
******************************************************************************************/
function ln_Save(p){
  var strAtcode="";
	if (p=="01"){
		if (gcds_code01.IsUpdated){
			if(ln_Chk(p)){
				if(ln_AtcodeChk()) return true;
				//if (confirm("저장하시겠습니까?")){	
					gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_t1?";
					gctr_code01.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;					
					gctr_code01.post();
			//	}	
			}
		}

	}else if(p=="02"){
		if (gcds_code02_1.IsUpdated){
			if(ln_Chk(p)){
				//if (confirm("저장하시겠습니까?")){	
					for(var i = 1; i<=gcds_code02_1.countrow;i++){
						if(gcds_code02_1.SysStatus(i)==1||gcds_code02_1.SysStatus(i)==2||gcds_code02_1.SysStatus(i)==3){
							gcds_code02_1.namevalue(i,"ATCODE") = gcds_code02.namevalue(gcds_code02.rowposition,"ATCODE");
						}
					}
					gctr_code02.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_t2?";
					gctr_code02.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;
					//prompt("",gcds_code02_1.text);
					gctr_code02.post();
				//}	
			}
		}
	}else if(p=="03"){
		if (gcds_code03.IsUpdated){
			if(ln_Chk(p)){
				if (confirm("저장하시겠습니까?")){	
					gctr_code03.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_t3?";
					gctr_code03.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;
					gctr_code03.post();
				}	
			}
		}
	}else if(p=="05"){
		if (gcds_code05.IsUpdated){
			if(ln_Chk(p)){
				if (confirm("저장하시겠습니까?")){	
					gctr_code05.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_t4?";
					gctr_code05.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;
					gctr_code05.post();
				}	
			}
		}
	}else if(p=="06"){
		if (gcds_code06.IsUpdated){
		//	if (confirm("저장하시겠습니까?")){	
				gctr_code06.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_t5?";
        strAtcode=gcds_code06.OrgNameString(gcds_code06.RowPosition,"ATCODE");
				gctr_code06.Parameters="v_str1="+strAtcode;
		  	gctr_code06.post();   
				//ln_Query('06');
		//	}
		}
	}
}

/******************************************************************************************
	Description : 삭제
	parameter   : 01 - 계정코드, 02 - 관리항목, 03 - 출력순서, 04 - Tree항목, 05 - 세목코드, 06 - 결산보고서양식
*****************************************************************************************/
function ln_Delete(p){

	if (p=="01"){
		if (confirm("삭제하시겠습니까?")){	
			gcds_code01.deleterow(gcds_code01.rowposition);
			gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_t1?";
			gctr_code01.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;
			gctr_code01.post();
		}
	}else if(p=="02"){
		if (confirm("삭제하시겠습니까?")){	
			gcds_code02_1.namevalue(gcds_code02_1.rowposition,"ATCODE") = gcds_code02.namevalue(gcds_code02.rowposition,"ATCODE");
			gcds_code02_1.deleterow(gcds_code02_1.rowposition);
			gctr_code02.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_t2?";
			gctr_code02.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;
			gctr_code02.post();
		}
	}else if(p=="05"){
		if (confirm("삭제하시겠습니까?")){	
			gcds_code05.deleterow(gcds_code05.rowposition);
			gctr_code05.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_t4?";
			gctr_code05.Parameters = "v_str1=" + gs_date +",v_str2="+gs_userid;
			gctr_code05.post();
		}
	}else if(p=="06"){
		if (confirm("삭제하시겠습니까?")){
			gcds_code06.deleterow(gcds_code06.rowposition);
			gctr_code06.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_t5?";
			gctr_code06.post();
			ln_Query('06');
		}
	}
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(p){

}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(p){
/*
	if(p=="01"){
		ln_Report_Head(p);
		gcds_report01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s6?v_str1"+gcem_atcode_fr01.text+"&v_str2="+gcem_atcode_to01.text; 
		gcds_report01.Reset();
  }
*/
	if(p=="01"){
		ln_Report_Head(p);
		gcds_report01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s6?v_str1"+gcem_atcode_11.text+"&v_str2="+gcem_atcode_12.text; 
		gcds_report01.Reset();
  }
}

/******************************************************************************
	Description : 엑셀
	parameter   :  - grid object명 , p2 - sheet명
******************************************************************************/
function ln_Excel(p,p2){
	var obj = eval(p);
	if (p=="gcgd_disp01"){
		obj.RunExcelEx(p2, 1, 0);
	}else if (p=="gcgd_disp02"){
		gcds_code02_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s6?v_str1"+gcem_atcode_fr02.text+"&v_str2="+gcem_atcode_to02.text; 
		gcds_code02_2.Reset();
	}
}

/******************************************************************************
	Description : FILE 
******************************************************************************/
function ln_File(p){

}

/******************************************************************************
	Description : 코드 작업
******************************************************************************/
function ln_Before() {
	//계정구분
	gcds_comcode01.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comcode_s1?v_str1=0033";
	gcds_comcode01.Reset();
	//계정그룹
	gcds_comcode02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comcode_s1?v_str1=0034";
	gcds_comcode02.Reset();
	//지점계정구분
	gcds_commuse01.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comcode_s1?v_str1=0026";
	gcds_commuse01.Reset();
	//[결산보고서양식] - 출력구분
	gcds_comcode03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comcode_s1?v_str1=2130";
	gcds_comcode03.Reset();
	//계정코드 체크 Ds
	gcds_temp08.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s8?v_str2=A";
	gcds_temp08.Reset();
	//반제단위
	gcds_fsrefcd01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comcode_s1?v_str1=0050";
	gcds_fsrefcd01.Reset();

  //자금구분
	gcds_fundiv01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comcode_s1?v_str1=0053";
	gcds_fundiv01.Reset();
}

/******************************************************************************
	Description : 체크
******************************************************************************/
function ln_Chk(p){

	if (p=="01"){	//필수항목체크
		if (fn_trim(gcem_atcode.text)=="" ){
			alert("계정코드를 입력하십시요.");
			gcem_atcode.focus();
			return false; 
		}

		if (fn_trim(gcem_atkornam.text)==""){
			alert("계정과목명을 입력하십시요.");
			gcem_atkornam.focus();
			return false; 
		}
	}else if(p=="02"){
	}else if(p=="03"){
	}else if(p=="04"){
	}else if(p=="05"){
	  /*
		if (fn_trim(gcem_buddtl.text)=="" ){
			alert("세목코드를 입력하십시요.");
			gcem_buddtl.focus();
			return false; 
		}

		if (fn_trim(txt_budnam.value)==""){
			alert("세목명을 입력하십시요.");
			txt_budnam.focus();
			return false; 
		}
		*/
	}
	return true; 
}

/******************************************************************************
	Description : 저장시 체크박스값 변환
	prameter : e - chkbox명,  p - dataset 칼럼명
******************************************************************************/
function ln_Chkbox(e,p){
	var row = gcds_code01.rowposition;
	if (e.checked) gcds_code01.namevalue(row,p) = "Y";
	else gcds_code01.namevalue(row,p) = "N";
}

/******************************************************************************
	Description : 조회시 체크박스 확인
	prameter :     p==> 01 - 계정코드
******************************************************************************/
/*
function ln_Chkbox2(p){


	if (gcds_code01.namevalue(row,"ATBDGRELYN")=="Y"){
		chk_atbdgrelyn.checked=true;
	}else{
		chk_atbdgrelyn.checked=false;
	}
}
*/

/***********************************************************************************************
	Description : 계정코드 찾기
	parameter   : p2===> fr, to- 계정코드 : apr- 충당금 : up - 상위계정 : down - 계정코드
	              p==> 01 - 계정코드, 02 - 관리항목, 03 - 출력순서, 04 - Tree항목, 05 - 세목코드, 06 - 결산보고서양식
**********************************************************************************************/
function ln_Popup(p2,p){

	//var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	strURL = "./actcode_popup.jsp";
	
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);	

	if (p=="01"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			//eval(e).value  = arrParam[0];
			 if(p2=="fr") {
					gcem_atcode_fr01.text = arrParam[0];
					txt_atkornam_fr01.value = arrParam[1];
			 }else if(p2=="to"){
					gcem_atcode_to01.text = arrParam[0];
					txt_atkornam_to01.value = arrParam[1];
			 }else if(p2=="apr") {
					gcem_ataprcode.text = arrParam[0];
					gcem_ataprnam.text = arrParam[1];
			 }else if(p2=="up") {
					gcem_atupcode.text = arrParam[0];
					gcem_atupnam.text = arrParam[1];
			 }
		} else {
			if(p2=="fr") {
				gcem_atcode_fr01.text = "";
				txt_atkornam_fr01.value ="";
			}else if(p2=="to"){
				gcem_atcode_to01.text = "";
				txt_atkornam_to01.value = "";
			}else if(p2=="apr") {
				gcem_ataprcode.text = "";
				gcem_ataprnam.text = "";
			}else if(p2=="up") {
				gcem_atupcode.text = "";
				gcem_atupnam.text = "";
			}
		}
		
	}else if(p=="02"){
		if (arrResult != null) {
				arrParam = arrResult.split(";");
			 if(p2=="fr") {
					gcem_atcode_fr02.text = arrParam[0];
					txt_atkornam_fr02.value = arrParam[1];
			 }else if(p2=="to"){
					gcem_atcode_to02.text = arrParam[0];
					txt_atkornam_to02.value = arrParam[1];
			 }
		} else {
			if(p2=="fr") {
				gcem_atcode_fr02.text = "";
				txt_atkornam_fr02.value ="";
			}else if(p2=="to"){
				gcem_atcode_to02.text = "";
				txt_atkornam_to02.value = "";
			}
		}

	}else if(p=="03"){
		if (arrResult != null) {
				arrParam = arrResult.split(";");
			 if(p2=="fr") {
					gcem_atcode_fr03.text = arrParam[0];
					txt_atkornam_fr03.value = arrParam[1];
			 }else if(p2=="to"){
					gcem_atcode_to03.text = arrParam[0];
					txt_atkornam_to03.value = arrParam[1];
			 }
		} else {
			if(p2=="fr") {
				gcem_atcode_fr03.text = "";
				txt_atkornam_fr03.value ="";
			}else if(p2=="to"){
				gcem_atcode_to03.text = "";
				txt_atkornam_to03.value = "";
			}
		}

	}else if(p=="04"){
		if (arrResult != null) {
				arrParam = arrResult.split(";");
			 if(p2=="fr") {
					gcem_atcode_fr04.text = arrParam[0];
					txt_atkornam_fr04.value = arrParam[1];
			 }else if(p2=="to"){
					gcem_atcode_to04.text = arrParam[0];
					txt_atkornam_to04.value = arrParam[1];
			 }
		} else {
			if(p2=="fr") {
				gcem_atcode_fr04.text = "";
				txt_atkornam_fr04.value ="";
			}else if(p2=="to"){
				gcem_atcode_to04.text = "";
				txt_atkornam_to04.value = "";
			}
		}

	}else if(p=="05"){
	  /*
		if (arrResult != null) {
				arrParam = arrResult.split(";");
			if(p2=="fr") {
				gcem_atcode_fr05.text = arrParam[0];
				txt_atkornam_fr05.value = arrParam[1];
			}else if(p2=="to"){
				gcem_atcode_to05.text = arrParam[0];
				txt_atkornam_to05.value = arrParam[1];
			}else if(p2=="down") {
				gcem_atdowncode.text = arrParam[0];
				txt_atdownnam.value = arrParam[1];
			}
		} else {
			if(p2=="fr") {
				gcem_atcode_fr05.text = "";
				txt_atkornam_fr05.value ="";
			}else if(p2=="to"){
				gcem_atcode_to05.text = "";
				txt_atkornam_to05.value = "";
	  	}else if(p2=="down"){
				gcem_atdowncode.text = "";
				txt_atdownnam.value = "";
			}
		}
    */
	}else if(p=="06"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			if(p2=="lt") {
				if(txa_prtlt.value !=""){
					txa_prtlt.value = txa_prtlt.value + arrParam[0];
				}else{
					txa_prtlt.value = arrParam[0];
				}
			}
		} else {
			if(p2=="lt") {
				if(txa_prtlt.value==""){
					txa_prtlt.value = "";
				}
			}
		}
	}else if(p=="07"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			if(p2=="rt") {
				if(txa_prtrt.value !=""){
					txa_prtrt.value = txa_prtrt.value + arrParam[0];
				}else{
					txa_prtrt.value = arrParam[0];
				}
			}
		} else {
			if(p2=="rt") {
				if(txa_prtrt.value==""){
					txa_prtrt.value = "";
				}
			}
		}
	}else if(p=="08"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			if(p2=="fr") {
				gcem_atcode_06.text = arrParam[0];
				if(arrParam[2]=="1") {
					gclx_lrdiv.bindcolval = "L";
				}else{
					gclx_lrdiv.bindcolval = "R";
				}
			}
		} else {
			if(p2=="fr") {
				gcem_atcode_06.text = "";
				gclx_lrdiv.bindcolval = "";
			}
		}
	}
}

/*********************************************************************************************
	Description : 등록번호 찾기
*********************************************************************************************/
function ln_Popup2(p){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = gclx_prtcode.BindColVal;

	strURL = "./prtnbr_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (p=="01"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txa_prtlt.value = arrParam[1];
		}
	}else if(p=="02"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txa_prtrt.value = arrParam[1];
		}
	}
}

/***********************************************************************************************
	Description : Test
	parameter
**********************************************************************************************/
function ln_P(){

	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./com_tax_list1.jsp";
	strPos = "dialogWidth:715px;dialogHeight:415px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	arrParam = arrResult.split(";");
	alert(arrParam[0]);
}

/***********************************************************************************************
	Description : Enable _ Disabled 
	parameter   : p2==> t - Enable, f - Disable
	              p==> 01 - 계정코드, 02 - 관리항목, 03 - 출력순서, 04 - Tree항목, 05 - 세목코드
***********************************************************************************************/
function ln_Enable(p2,p) {
	
	if (p=="01"){
		if (p2=="t")gcem_atcode.enalbe=true;
		else if (p2=="f")gcem_atcode.enalbe=false;
	}else if(p=="02"){
	}else if(p=="03"){
	}else if(p=="04"){
	}else if(p=="05") {
	if (p2=="t")gcem_atcode.enalbe=true;
		else if (p2=="f")gcem_atcode.enalbe=false;
	}
}

function ln_Enable01(p) {
  /*
	if (p=="t"){
		txt_atdownnam.disabled=false;
	}else if (p=="f"){
		txt_atdownnam.disabled=true;
	}
	*/
}

/************************************************************************************************
	Description : Add시 Default 값 설정 
	parameter   : p2 : a - 등록시 , s -조회시
	              p : 01 - 계정코드, 02 - 관리항목, 03 - 출력순서, 04 - Tree항목, 05 - 세목코드
***********************************************************************************************/
function ln_Defval(p2,p) {

	if (p=="01"){
		if (p2=="a"){
			gcra_atdecr.CodeValue="";   
			gcra_atuseyn.CodeValue="N";    
			gcra_atforcuryn.CodeValue="N"; 
			gcra_atcurtype.CodeValue="N";  
			gcra_atapryn.CodeValue="N";    
			gcra_atdaybalyn.CodeValue="N"; 
			gcra_atsupplyn.CodeValue="N";  
			gcra_attotaccyn.CodeValue="N"; 
			gcra_atsumbalyn.CodeValue="N"; 
			gcra_atbalshtyn.CodeValue="N"; 
			gcra_atprolstyn.CodeValue="N"; 
			gcra_atattshtyn.CodeValue="N"; 
			gcra_atmakyn.CodeValue="N";    
			gcra_atwrkyn.CodeValue="N";    
			gcra_attrayn.CodeValue="N";    
			gcra_atetcyn.CodeValue="N";    
			gcra_atdebtyn.CodeValue="N";   
		}else if(p2=="s"){
			gcra_atdecr.CodeValue="";   
			gcra_atuseyn.CodeValue="";    
			gcra_atforcuryn.CodeValue=""; 
			gcra_atcurtype.CodeValue="";  
			gcra_atapryn.CodeValue="";    
			gcra_atdaybalyn.CodeValue=""; 
			gcra_atsupplyn.CodeValue="";  
			gcra_attotaccyn.CodeValue=""; 
			gcra_atsumbalyn.CodeValue=""; 
			gcra_atbalshtyn.CodeValue=""; 
			gcra_atprolstyn.CodeValue=""; 
			gcra_atattshtyn.CodeValue=""; 
			gcra_atmakyn.CodeValue="";    
			gcra_atwrkyn.CodeValue="";    
			gcra_attrayn.CodeValue="";    
			gcra_atetcyn.CodeValue="";    
			gcra_atdebtyn.CodeValue="";  
		}
	}else if(p=="04"){
		txt_atcode04.value="";         	
		txt_atkornam04.value="";              
		txt_atprtnam04.value="";              
		txt_atdiv04.value="";                 
		txt_atgrp04.value="";                 
		txt_atdecr04.value="";                
		txt_atuseyn04.value="";               
		txt_atupcode04.value="";              
		txt_atprtseq04.value="";              
		txt_atforcuryn04.value="";            
		txt_atcurtype04.value="";             
		txt_atapryn04.value="";               
		txt_ataprcode04.value="";             
		txt_atdaybalyn04.value="";            
		txt_atsupplyn04.value="";             
		txt_attotaccyn04.value="";            
		txt_atsumbalyn04.value="";            
		txt_atbalshtyn04.value="";            
		txt_atprolstyn04.value="";            
		txt_atattshtyn04.value="";            
		txt_atmakyn04.value="";               
		txt_atwrkyn04.value="";               
		txt_attrayn04.value="";               
		txt_atetcyn04.value="";               
		txt_atoppuseyn04.value="";            
		txt_atbdgrelyn04.value="";            
		txt_atdebtyn04.value="";              
		txa_attxt04.value="";                 
		gcem_basdat04.text="";               
		gcem_dsudt04.text="";   
	}
}

/******************************************************************************
	Description : Dataset Head 설정
******************************************************************************/
function ln_SetDataHeader(){
	var s_temp = "ATCODE:STRING,	    ATKORNAM:STRING, 	  ATPRTNAM:STRING,	  ATDIV:STRING,	      ATGRP:STRING,	"
						 + "ATDECR:STRING,	    ATUSEYN:STRING,	    ATUPCODE:STRING,  	ATPRTSEQ:DECIAML, 	ATFORCURYN:STRING,"
						 + "ATCURTYPE:STRING,  	ATAPRYN:STRING,	    ATAPRCODE:STRING,  	ATDAYBALYN:STRING,	ATSUPPLYN:STRING,	"
						 + "ATTOTACCYN:STRING,	ATSUMBALYN:STRING,	ATBALSHTYN:STRING,	ATPROLSTYN:STRING,	ATATTSHTYN:STRING,"
						 + "ATMAKYN:STRING,	    ATWRKYN:STRING,	    ATTRAYN:STRING,	    ATETCYN:STRING,	    ATOPPUSEYN:STRING,"	
						 + "ATBDGRELYN:STRING,  ATDEBTYN:STRING,	  ATTXT:STRING,	      BASDAT:STRING,      FUNDIV:STRING, "
						 + "WRDT:STRING ,     	WRID:STRING,	      UPDT:STRING,	      UPID:STRING,	      DSUDT:STRING";
	gcds_code01.SetDataHeader(s_temp);
}

/******************************************************************************
	Description : 탭구분
	prameter    : 0-계정코드, 1-관리항목, 2-출력순서, 3-Tree_항목, 4-세목코드
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp1","div_disp2","div_disp3","div_disp4","div_disp6");
	for(var i=0;i<=4;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
	if (index==3){	
		ln_Query('04');
	}

}

/******************************************************************************
	Description : add 시 포커스 위치와 기본항목 설정
	prameter    : 0-계정코드, 1-관리항목, 2-출력순서, 3-Tree_항목, 4-세목코드, 5-결산보고서양식
******************************************************************************/
function ln_Add_Status(p){
	var temp1=0;
	var temp2=0;
          temp1 = gcds_code02_1.namevalue(gcds_code02_1.rowposition,"ARSEQ");
	if (p=="02_1"){
		if (temp1==""&&gcds_code02_1.rowposition==1){
			gcds_code02_1.namevalue(gcds_code02_1.rowposition,"ARSEQ")=1;
		}else{
			//temp2 = gcds_code02_1.namevalue(intRow,"ARSEQ");
			//temp2=Number(temp2)+1
			//gcds_code02_1.namevalue(gcds_code02_1.rowposition,"ARSEQ")=Number(temp2);
							
			gcds_code02_1.namevalue(gcds_code02_1.rowposition,"ARSEQ")=String(Number(gcds_code02_1.Max(2,0,0))+1);
		}
		
        gcds_code02_1.namevalue(gcds_code02_1.rowposition,"ARDEYN")="Y";
		gcds_code02_1.namevalue(gcds_code02_1.rowposition,"ARCRYN")="Y";
		gcds_code02_1.namevalue(gcds_code02_1.rowposition,"ARBALDIV")="N";
		gcds_code02_1.namevalue(gcds_code02_1.rowposition,"TYPE")="A";
	
	}	 	
}

/******************************************************************************
	Description : 리포트의 head 부분설정
	prameter    : 01-계정코드
******************************************************************************/
function ln_Report_Head(p){
	if (p=="01"){  
	  gcds_report0.ClearAll();
		var ls_temp = "ATCODEFR:STRING,"
		            + "ATCODETO:STRING,"
		            + "CURDATE:STRING";
		gcds_report0.SetDataHeader(ls_temp);
		gcds_report0.Addrow();
		gcds_report0.namevalue(1,"CURDATE")=gs_date;

		if(gcem_atcode_11.text==""){
      gcds_report0.namevalue(1,"ATCODEFR")="ALL";
			//gcds_report0.namevalue(1,"ATCODETO")="";
    }else{
			gcds_report0.namevalue(1,"ATCODEFR")=gcem_atcode_11.text;
			//gcds_report0.namevalue(1,"ATCODETO")="";
		}

		//if(gcem_atcode_to01.text==""){
    //  gcds_report0.namevalue(1,"ATCODETO")="ALL";
    //}else{
		//	gcds_report0.namevalue(1,"ATCODETO")=gcem_atcode_to01.text;
		//}
	}
}

/******************************************************************************
	Description : emedit length chk
	prameter    : p1 - object 명 , p2 - length
******************************************************************************/
function ln_length_Chk(p1,p2){
	var obj = eval(p1); 
	if ((obj.Modified) && (obj.Text.length >=p2)) {
		alert("입력하신 글자가 허용 길이를 초과 했습니다.");
	}
}

/******************************************************************************
	Description : 좌변,우변 계산식 취소
******************************************************************************/
function ln_CacuLtRt(s){
	if(s=="01") {
		var rt = txa_prtlt.value; 
		for(var i=1;i<=rt.length;i++) {
			if (i==rt.length) {
				if (rt.substring(Number(rt.length-1),rt.length) == '+' ||
						rt.substring(Number(rt.length-1),rt.length) == '-' ||
						rt.substring(Number(rt.length-1),rt.length) == '*' ||
						rt.substring(Number(rt.length-1),rt.length) == '/' ||
						rt.substring(Number(rt.length-1),rt.length) == ')' ||
						rt.substring(Number(rt.length-1),rt.length) == '(' ) {
					txa_prtlt.value = rt.substring(0,Number(rt.length-1));
				}else{
					txa_prtlt.value = rt.substring(0,Number(rt.length-7));
				}
			}
		}
	}else if(s=="02") {
		var rt = txa_prtrt.value; 
		for(var i=1;i<=rt.length;i++) {
			if (i==rt.length) {
				if (rt.substring(Number(rt.length-1),rt.length) == '+' ||
						rt.substring(Number(rt.length-1),rt.length) == '-' ||
						rt.substring(Number(rt.length-1),rt.length) == '*' ||
						rt.substring(Number(rt.length-1),rt.length) == '/' ||
						rt.substring(Number(rt.length-1),rt.length) == '(' ||
						rt.substring(Number(rt.length-1),rt.length) == ')' ) {
					txa_prtrt.value = rt.substring(0,Number(rt.length-1));
				}else{
					txa_prtrt.value = rt.substring(0,Number(rt.length-7));
				}
			}
		}
	}
}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_code02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--관리항목-->
<object  id=gcds_code02_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_commuse01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_fsrefcd01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+CDNAM">
</object>

<!--자금구분-->
<object  id=gcds_fundiv01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--관리항목 Excel-->
<object  id=gcds_code02_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_code03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_code04 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_code04_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_code05 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_comcode01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_comcode02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_comcode03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- 리포트헤드 -->
<object  id=gcds_report0  classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object> 

<object  id=gcds_report01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!-- 결산보고서양식 -->
<object  id=gcds_code06 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_temp08 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>
</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gctr_code01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a010002_t1(I:USER=gcds_code01)"> 
</object> 

<object  id=gctr_code02 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a010002_t2(I:USER=gcds_code02_1)">
</object>

<object  id=gctr_code03 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a010002_t3(I:USER=gcds_code03)"> 
</object>

<object  id=gctr_code05 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a010002_t4(I:USER=gcds_code05)"> 
</object> 

<object  id=gctr_code06 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a010002_t5(I:USER=gcds_code06)"> 
</object>
</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
	//ln_Chkbox2('01');
</script>

<script language="javascript" for="gcds_code02" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code02" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt02.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_code02_1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code02_1" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt02_1.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
	gcgd_disp02.Focus();
</script>

<script language="javascript" for="gcds_code02_2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code02_2" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1){
		alert("검색된 데이터가 없습니다.");
	}else{
		gcgd_disp02_2.RunExcelEx('계정별관리항목', 1, 0);
	}
</script>

<script language="javascript" for="gcds_code03" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code03" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt03.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_code04" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code04" event="onloadCompleted(row,colid)">
/*	gcds_code04.insertrow(1);
	gcds_code04.namevalue(1,"ATCODE") = "0000000";
	gcds_code04.namevalue(1,"ATKORNAM") = "계 정 과 목";
	gcds_code04.namevalue(1,"Level") = "1";
*/
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_code05" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code05" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt02.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_report01" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_report01" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	gcrp_print01.preview();
</script>

<script language="javascript" for="gcds_code06" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code06" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_fsrefcd01" event="onloadCompleted(row,colid)">
	gcds_fsrefcd01.InsertRow(1);
	gcds_fsrefcd01.NameValue(1,"CDCODE")="";
	gcds_fsrefcd01.NameValue(1,"CDNAM")="";
	gclx_fsrefcd01.index = 0;
</script>

<script language="javascript" for="gcds_fundiv01" event="onloadCompleted(row,colid)">
	gcds_fundiv01.InsertRow(1);
	gcds_fundiv01.NameValue(1,"CDCODE")="";
	gcds_fundiv01.NameValue(1,"CDNAM")="";
	gcds_fundiv01.index = 0;
</script>
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- 계정코드 -->
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1));
</script>

<!-- 계정코드 -->
<script language=JavaScript for="gcgd_disp01" event=OnClick(row,colid)>
	if (row < 1) return; 
  //ln_Chkbox2('01');
</script>

<!-- 관리항목 -->
<script language=JavaScript for="gcgd_disp02" event=OnClick(row,colid)>
	if (row < 1) return; 
    ln_Query_1('02_1',gcds_code02.namevalue(row,"ATCODE"));
</script>

<!-- <script language=JavaScript for="gcgd_disp05" event=OnClick(row,colid)>
	if (row < 1)  ln_Enable("f");
	return; 
</script> -->

<script language=JavaScript for="gcgd_disp06" event=OnClick(row,colid)>
	if(!gcds_code06.IsUpdated){
		if (row >= 1) { 
			
		}
	}
</script>

<script language=JavaScript for="gcgd_disp02" event=onKeyPress(keycode)>
	if (gcds_code02.countrow>=1){
		if ((keycode==38)||(keycode==40)){
			ln_Query_1('02_1',gcds_code02.namevalue(gcds_code02.rowposition,"ATCODE"));
		}
	}
</script>

<script language=JavaScript for="gcgd_disp02_1" event=OnPopup(row,colid,data)>
	var result ="";
	var strURL;	
	var strPos;
	var arrResult = new Array();
	var arrParam	= new Array();

	arrParam[0]	= "0050"; //관리항목
	strURL = "./commdtil_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);

	if (result == -1 || result == null || result == "")	return;
	arrResult = result.split(";");
	gcds_code02_1.NameValue(gcds_code02_1.RowPosition,"CDCODE") = arrResult[0];
	gcds_code02_1.NameValue(gcds_code02_1.RowPosition,"CDNAM") = arrResult[1];
</script>

<script language=JavaScript for=gcte_tree event=OnClick()>
	//txt_text1.value=gcte_tree.ItemText;
</script>
 
<script language=JavaScript for=gcte_tree event=OnItemClick(ItemIndex)>
	ln_Query_1("04_1",gcds_code04.namevalue(gcds_code04.rowposition,"ATCODE"));
</script>

<script language=JavaScript for=gcrp_print01 event=OnError()>
	alert("Error Code : " + gcrp_print01.ErrorCode + "\n" +
	"Error Message : " + gcrp_print01.ErrorMsg + "\n");
</script>

<script language=JavaScript for=gcem_atkornam event=onKillFocus()>
	ln_length_Chk('gcem_atkornam',30);
</script>

<script language=JavaScript for=gcem_atprtnam event=onKillFocus()>
	ln_length_Chk('gcem_atprtnam',30);
</script>

<script language=JavaScript for=gcem_ataprnam event=onKillFocus()>
	ln_length_Chk('gcem_ataprnam',30);
</script>

<script language=JavaScript for=txt_atdownnam event=onKillFocus()>
	ln_length_Chk('txt_atdownnam',30);
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_code01 event=OnSuccess()>
  window.status="";
	window.status="작업이 성공적으로 완료되었습니다.";
</script>

<script language=JavaScript for=gctr_code01 event=OnFail()>
	window.status="작업이 성공적으로 완료되지 못했습니다.";
</script>

<script language=JavaScript for=gctr_code02 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_code02 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language=JavaScript for=gctr_code03 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_code03 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language=JavaScript for=gctr_code05 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_code05 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language=JavaScript for=gctr_code06 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_code06 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="<%=HDConstant.PATH_ACC_COMMON%>img/com_t_bg.gif"><img src="../img/a010002_head.gif"></td>
    <td background="<%=HDConstant.PATH_ACC_COMMON%>img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr>
					<td width="0" align=right>
						<comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;">
						<PARAM NAME="BackColor"					VALUE="#cccccc">
   					       <PARAM NAME="titleHeight"				VALUE="20px">
						  <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
						  <PARAM NAME="Format"						VALUE="
								T>divid=div_1		title=계정코드</T>									
							  <T>divid=div_2		title=관리항목</T>
							  <T>divid=div_3    title=출력순서</T>
							  <T>divid=div_4    title=Tree_항목</T>
								<T>divid=div_6		title=결산보고서양식</T>
						  ">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!-- 계정코드 -->
<fieldset id=field1 style="position:absolute;top:160px;left:18px;height:485px;width:878px;bacground-color:#708090"></fieldset>
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td align="center" colspan=2>
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
					<tr> 				
						<!--td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">계정코드</td>
						<td>&nbsp;
							<comment id="__NSID__"><object  id=gcem_atcode_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:5px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Numeric       value=false>
											<param name=Format        value="#######">
											<param name=PromptChar    value="">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script> 
							<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px" align=center onclick="ln_Popup('fr','01');">
							<input id="txt_atkornam_fr01" type="text" class="txtbox"  style= "position:relative;top:1px;width:130px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled>
							~&nbsp;
						 <comment id="__NSID__"><object  id=gcem_atcode_to01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:5px">				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Numeric       value=false>
											<param name=Format        value="#######">
											<param name=PromptChar    value="">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script> 
							<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px" align=center onclick="ln_Popup('to','01');">
							<input id="txt_atkornam_to01" type="text" class="txtbox"  style= "position:relative;top:1px;width:130px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled>

						</td-->
					<td width="80" class="tab12" bgcolor="#eeeeee" align="center">계정명</td>
					<td class="tab23" style="width:135px">&nbsp;<comment id="__NSID__">
						<object  id=gcem_atcode_11 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query('01');">		
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
					<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">계정코드</td>
					<td>&nbsp;<comment id="__NSID__">
						<object  id=gcem_atcode_12 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:86px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query('01');">		
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
					<td width="1px" align=right>&nbsp;</td>
						<td valign="bottom" align=right>
							<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_excel.gif"   style="cursor:hand" onclick="ln_Excel('gcgd_disp01','계정코드')">
							<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_print.gif"   style="cursor:hand" onclick="ln_Print('01')">
							<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Delete('01')" >
							<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add('01')" >
							<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save('01')">
							<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query('01')">&nbsp;
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="2px" colspan =2></td></tr>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;width:280px;border:0 solid #708090;">
				<tr> 			
				<td>
						<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
							style="position:relative;left:7px;width:275px; height:420px; border:1 solid #708090;">
                				<PARAM NAME="DataID"			VALUE="gcds_code01">
								<PARAM NAME="IndWidth"		VALUE ='0'>
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
                				<PARAM NAME="Sortview"		VALUE="left">
								<PARAM NAME="Format"			VALUE="  
								<C> Name='계정코드'		    ID=ATCODE   	HeadAlign=Center HeadBgColor=#B9D4DC Width=78		align=center sort=true </C> 
								<C> Name='계정과목명'			ID=ATKORNAM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	sort=true </C> 
								<C> Name='계정출력명'			ID=ATPRTNAM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	show=false</C> 
								<C> Name='계정구분'	      ID=ATDIV     	HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	show=false</C> 
								<C> Name='계정그룹'	    	ID=ATGRP     	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	show=false</C> 
								<C> Name='기준차대'	      ID=ATDECR    	HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	show=false</C> 
								<C> Name='전표발생'		    ID=ATUSEYN   	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	show=false</C> 
								<C> Name='상위계정코드'		ID=ATUPCODE  	HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	show=false</C> 
								<C> Name='출력순서'		    ID=ATPRTSEQ  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	show=false</C> 
								<C> Name='외화관리'	      ID=ATFORCURYN	HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	show=false</C> 
								<C> Name='환율구분'		    ID=ATCURTYPE 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	show=false</C> 
								<C> Name='충당금'         ID=ATAPRYN   	HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	show=false</C> 
								<C> Name='충당금코드'			ID=ATAPRCODE 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	show=false</C> 
								<C> Name='일계표출력'		  ID=ATDAYBALYN	HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	show=false</C> 
								<C> Name='보조부출력'			ID=ATSUPPLYN 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	show=false</C> 
								<C> Name='총계정원장출력'		  ID=ATTOTACCYN	HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	show=false</C> 
								<C> Name='합계잔액시산표출력'	ID=ATSUMBALYN	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	show=false</C> 
								<C> Name='대차대조표출력'		ID=ATBALSHTYN	HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	show=false</C> 
								<C> Name='손익계산서출력'		ID=ATPROLSTYN	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	show=false</C> 
								<C> Name='부속명세표출력'		ID=ATATTSHTYN	HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	show=false</C> 
								<C> Name='제조원가명세표출력'	ID=ATMAKYN   	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	show=false</C> 
								<C> Name='공사원가명세표출력'	ID=ATWRKYN   	HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	show=false</C> 
								<C> Name='운송원가명세표출력'	ID=ATTRAYN   	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	show=false</C> 
								<C> Name='기타원가명세표출력'	ID=ATETCYN   	HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	show=false</C> 
								<C> Name='상대변사용여부'			ID=ATOPPUSEYN	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	show=false</C> 
								<C> Name='자금구분'		    ID=FUNDIV   	HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	show=false</C> 
								<C> Name='반제사용'		    ID=ATDEBTYN  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	show=false</C> 
								<C> Name='계정코드해설 '	ID=ATTXT     	HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	show=false</C> 
								<C> Name='적용일자'		    ID=BASDAT    	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	show=false</C>
								<C> Name='폐기일자'		    ID=DSUDT    	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	show=false</C>
								">
						</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="position:relative;left:7px;width:277px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
						</fieldset>
				</td>
				</tr>
				</table>
			</td>

			<td>
			<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:8px;width:584px;border:0 solid #708090;">
			<tr>
				<td class="tab15" style="width:120px;" bgcolor="#eeeeee" align=center >계정코드</td>
				<td class="tab18" style="width:140px;"align=left >&nbsp;<comment id="__NSID__">
					<object  id=gcem_atcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="#######">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab18" style="width:120px;" bgcolor="#eeeeee" align=center >계정과목명</td>
				<td class="tab18">&nbsp;
					<!-- <input id="txt_atkornam" type="text" class="txtbox"  style= "width:200px;height:20px;position:relative;left:-4px" maxlength="33" onBlur="bytelength(this,this.value,30)";> -->
					<comment id="__NSID__"><object  id=gcem_atkornam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:200px;height:20px;position:relative;left:-4px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">           
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" align=center >충당금</td>
				<td class="tab19" style="width:140px;" >&nbsp;
				<comment id="__NSID__"><object  id=gcra_atapryn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
					style="position:relative;left:0px;top:0px;height:20;width:130;cursor:hand;">
						<param name=Cols     value="2">
						<param name=Format   value="Y^사용,N^미사용">
				</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab19" style="width:120px;" bgcolor="#eeeeee" align=center >계정출력명</td>
				<td class="tab19" style="height:25px;" >&nbsp;
					<!-- <input id="gcem_atprtnam" type="text" class="txtbox"  style= "width:200px; height:20px;position:relative;left:-4px" maxlength="33" > -->
					<comment id="__NSID__"><object  id=gcem_atprtnam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:200px;height:20px;position:relative;left:-4px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">           
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
				<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" align=center>충당금코드</td>
				<td class="tab19" style="width:140px;" >&nbsp;<comment id="__NSID__">
					<object  id=gcem_ataprcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="#######">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<div id="layer1" style="position:absolute;top:53px; left:183px;">	
						<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;" align=center onclick="ln_Popup('apr','01');">
          </div>
				</td>
				<td class="tab19" style="width:120px;" bgcolor="#eeeeee" align=center >충당금코드명</td>
				<td class="tab19" style="width:170px;">
					<!-- <input id="txt_ataprnam" type="text" class="txtbox"  style= "width:200px; height:20px;position:relative;left:4px" maxlength="33" > -->
					<comment id="__NSID__"><object  id=gcem_ataprnam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:200px;height:20px;position:relative;left:4px;top:1px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">           
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>

			<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" align=center >상위계정코드</td>
				<td class="tab19" style="width:140px;">
					<comment id="__NSID__"><object  id=gcem_atupcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:20px;position:relative;left:4px;top:0px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="#######">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<div id="layer2" style="position:absolute;top:78px; left:183px;">	
						<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;" align=center onclick="ln_Popup('up','01');">
          </div>
				</td>
				<td class="tab19" style="width:120px;" bgcolor="#eeeeee" align=center >상위계정과목명</td>
				<td class="tab19" style="height:25px;">
					<!-- <input id="txt_atupnam" type="text" class="txtbox"  style= "width:200px; height:20px;position:relative;left:4px" maxlength="33" onBlur="bytelength(this,this.value,30);"> -->
					<comment id="__NSID__"><object  id=gcem_atupnam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:200px;height:20px;position:relative;left:4px;top:1px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">           
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" align=center >계정구분</td>
				<td class="tab19" style="width:140px;">&nbsp;<comment id="__NSID__">
					<object  id=gclx_atdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:2px;font-size:12px;width:135px;">
								<param name=ComboDataID			value="gcds_comcode01">
								<param name=CBDataColumns		value="CDCODE, CDNAM">
								<param name=SearchColumn		value=CDNAM>
								<param name=Sort			    value=true>
								<param name=SortColumn          value="CDCODE">
								<param name=ListExprFormat	    value="CDNAM^0^145">
								<param name=BindColumn			value=CDCODE>
						</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab19" style="width:120px;" bgcolor="#eeeeee" align=center>계정그룹</td>
				<td class="tab19">&nbsp;<comment id="__NSID__">
					<object  id=gclx_atgrp classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:2px;font-size:12px;width:135px;">
								<param name=ComboDataID			value="gcds_comcode02">
								<param name=SearchColumn		value=CDNAM>
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^145">
								<param name=BindColumn			value=CDCODE>
						</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>

			<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" align=center>출력순서</td>
				<td class="tab19" style="width:140px;">&nbsp;<comment id="__NSID__">
					<object  id=gcem_atprtseq classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=Alignment     value=2>
            			<param name=Numeric       value=true>
						<param name=MaxLength     value=7>
						<param name=IsComma       value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab19" style="width:120px;" bgcolor="#eeeeee" align=center >기준차대</td>
				<td class="tab19">&nbsp;
					<comment id="__NSID__"><object  id=gcra_atdecr classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
						style="position:relative;left:0px;top:0px;height:20;width:144;cursor:hand;">
							<param name=Cols     value="2">
							<param name=Format   value="1^차변,2^대변">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>

			<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" align=center>전표발생</td>
				<td class="tab19" style="width:140px;">&nbsp;
					<comment id="__NSID__"><object  id=gcra_atuseyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
						style="position:relative;left:0px;top:0px;height:20;width:135;cursor:hand;">
							<param name=Cols     value="2">
							<param name=Format   value="Y^사용,N^미사용">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab19" style="width:120px;" bgcolor="#eeeeee" align=center>반제사용</td>
				<td class="tab19" >&nbsp;
					<comment id="__NSID__"><object  id=gcra_atdebtyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
						style="position:relative;left:0px;top:0px;height:20;width:144;cursor:hand;">
							<param name=Cols     value="2">
							<param name=Format   value="Y^사용,N^미사용">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>

			<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" align=center >외화관리</td>
				<td class="tab19" style="width:140px;">&nbsp;
					<comment id="__NSID__"><object  id=gcra_atforcuryn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
						style="position:relative;left:0px;top:0px;height:20;width:135;cursor:hand;">
							<param name=Cols     value="2">
							<param name=Format   value="Y^사용,N^미사용">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab19" style="width:120px;" bgcolor="#eeeeee" align=center>환율원화적용</td>
				<td class="tab19" >&nbsp;
					<comment id="__NSID__"><object  id=gcra_atcurtype classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
						style="position:relative;left:0px;top:0px;height:20;width:145;cursor:hand;">
							<param name=Cols     value="2">
							<param name=Format   value="Y^사용,N^미사용">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>

      <tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" align=center >일계표출력</td>
				<td class="tab19" style="width:140px;" >&nbsp;
					<comment id="__NSID__"><object  id=gcra_atdaybalyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
						style="position:relative;left:0px;top:0px;height:20;width:135;cursor:hand;">
							<param name=Cols     value="2">
							<param name=Format   value="Y^출력,N^미출력">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab19" style="width:120px;" bgcolor="#eeeeee" align=center>보조부출력</td>
				<td class="tab19" >&nbsp;
					<comment id="__NSID__"><object  id=gcra_atsupplyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
						style="position:relative;left:0px;top:0px;height:20;width:144;cursor:hand;">
							<param name=Cols     value="2">
							<param name=Format   value="Y^출력,N^미출력">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>

			 <tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" align=center >총계정원장출력</td>
				<td class="tab19" style="width:140px;" >&nbsp;
					<comment id="__NSID__"><object  id=gcra_attotaccyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
						style="position:relative;left:0px;top:0px;height:20;width:135;cursor:hand;">
							<param name=Cols     value="2">
							<param name=Format   value="Y^출력,N^미출력">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab19" style="width:120px;" bgcolor="#eeeeee" align=center>합계시산표출력</td>
				<td class="tab19" >&nbsp;
					<comment id="__NSID__"><object  id=gcra_atsumbalyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
						style="position:relative;left:0px;top:0px;height:20;width:144;cursor:hand;">
							<param name=Cols     value="2">
							<param name=Format   value="Y^출력,N^미출력">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
			 <tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" align=center >대차대조표출력</td>
				<td class="tab19" style="width:140px;" >&nbsp;
					<comment id="__NSID__"><object  id=gcra_atbalshtyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
						style="position:relative;left:0px;top:0px;height:20;width:135;cursor:hand;">
							<param name=Cols     value="2">
							<param name=Format   value="Y^출력,N^미출력">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab19" style="width:120px;" bgcolor="#eeeeee" align=center>손익계산서출력</td>
				<td class="tab19" >&nbsp;
					<comment id="__NSID__"><object  id=gcra_atprolstyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
						style="position:relative;left:0px;top:0px;height:20;width:144;cursor:hand;">
							<param name=Cols     value="2">
							<param name=Format   value="Y^출력,N^미출력">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>

      <tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" align=center >부속명세표출력</td>
				<td class="tab19" style="width:140px;" >&nbsp;
					<comment id="__NSID__"><object  id=gcra_atattshtyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
						style="position:relative;left:0px;top:0px;height:20;width:135;cursor:hand;">
							<param name=Cols     value="2">
							<param name=Format   value="Y^출력,N^미출력">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab19" style="width:120px;" bgcolor="#eeeeee" align=center>제조원가명세표출력</td>
				<td class="tab19" >&nbsp;
					<comment id="__NSID__"><object  id=gcra_atmakyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
						style="position:relative;left:0px;top:0px;height:20;width:144;cursor:hand;">
							<param name=Cols     value="2">
							<param name=Format   value="Y^출력,N^미출력">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>

			<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" align=center >공사원가명세표출력</td>
				<td class="tab19" style="width:140px;" >&nbsp;
					<comment id="__NSID__"><object  id=gcra_atwrkyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
						style="position:relative;left:0px;top:0px;height:20;width:135;cursor:hand;">
							<param name=Cols     value="2">
							<param name=Format   value="Y^출력,N^미출력">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab19" style="width:120px;" bgcolor="#eeeeee" align=center>운송원가명세표출력</td>
				<td class="tab19" >&nbsp;
					<comment id="__NSID__"><object  id=gcra_attrayn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
						style="position:relative;left:0px;top:0px;height:20;width:144;cursor:hand;">
							<param name=Cols     value="2">
							<param name=Format   value="Y^출력,N^미출력">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" align=center >기타원가명세표출력</td>
				<td class="tab19" style="width:140px;" >&nbsp;
					<comment id="__NSID__"><object  id=gcra_atetcyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
						style="position:relative;left:0px;top:0px;height:20;width:135;cursor:hand;">
							<param name=Cols     value="2">
							<param name=Format   value="Y^출력,N^미출력">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab19" style="width:120px;" bgcolor="#eeeeee" align=center>지점계정구분</td>
				<td class="tab19" >&nbsp;<comment id="__NSID__">
					<object  id=gclx_commuse classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:2px;font-size:12px;width:135px;">
								<param name=ComboDataID			value="gcds_commuse01">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDNAM^0^145">
								<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
				</td>
			</tr>

			<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" align=center>반제단위</td><!-- 상대변사용 -->
				<td class="tab19" style="width:140px;">&nbsp;<comment id="__NSID__">
					<object  id=gclx_fsrefcd01 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:2px;font-size:12px;width:135px;">
						<param name=ComboDataID			value="gcds_fsrefcd01">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^145">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
					<!-- <input type=checkbox name=chk_atoppuseyn class="txtbox"  style="position:relative;left:0px" onclick="ln_Chkbox(this,'ATOPPUSEYN')"> -->
				</td>
				<td class="tab19" style="width:120px;" bgcolor="#eeeeee" align=center>자금구분</td>
				
				<td class="tab19" >&nbsp;
				  <comment id="__NSID__">
					<object  id=gclx_fundiv01 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:-4px;top:2px;font-size:12px;width:135px;">
						<param name=ComboDataID			value="gcds_fundiv01">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^145">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
					<!-- <input type=checkbox name=chk_atbdgrelyn class="txtbox"  style="position:relative;left:0px" onclick="ln_Chkbox(this,'ATBDGRELYN')"> -->
				</td>
			
			</tr>
			<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" align=center >적용일자</td>
				<td class="tab19" style="width:140px;" >&nbsp;<comment id="__NSID__">
					<object  id=gcem_basdat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
					style="position:relative;top:2px;width:70px;height:20px;">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=PromptChar	  value="_">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_basdat', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
				</td>
				<td class="tab19" style="width:120px;" bgcolor="#eeeeee" align=center>폐기일자</td>
				<td class="tab19" >&nbsp;<comment id="__NSID__">
					<object  id=gcem_dsudt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
					style="position:relative;top:2px;width:70px;height:20px;">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=PromptChar	  value="_">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_dsudt', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
				</td>
			</tr>
			</table>
			
			<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:8px;width:584px;border:0 solid #708090;">
			<tr>
				<td class="tab17" style="width:114px;" bgcolor="#eeeeee" align=center >계정코드해설</td>
				<td class="tab19" align=left colspan=3 >&nbsp;
					<textarea id="txa_attxt" class="txtbox"  style= "width:457px; height:38px; overflow:auto;position:relative;left:-3px" maxlength="30" ></textarea>
				</td>
			</tr>
			</table>
   </td>
  </tr> 
</table> 

<!-- 관리항목 -->
<fieldset id=field2 style="position:absolute;top:160px;left:18px;height:485px;width:878px;bacground-color:#708090"></fieldset>
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="display:none">
<tr>
  <td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr> 				
				<!--td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">계정코드</td>
				<td>&nbsp;
					<comment id="__NSID__"><object  id=gcem_atcode_fr02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:5px">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px" align=center onclick="ln_Popup('fr','02');">
					<input id="txt_atkornam_fr02" type="text" class="txtbox"  style= "position:relative;top:1px;width:130px; height:20px;" maxlength="36"  disabled>
					~&nbsp;
				 <comment id="__NSID__"><object  id=gcem_atcode_to02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:5px">				
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px" align=center onclick="ln_Popup('to','02');">
					<input id="txt_atkornam_to02" type="text" class="txtbox"  style= "position:relative;top:1px;width:130px; height:20px;" maxlength="36"  disabled>
				</td-->
					<td width="80" class="tab12" bgcolor="#eeeeee" align="center">계정명</td>
					<td class="tab23" style="width:135px">&nbsp;<comment id="__NSID__">
						<object  id=gcem_atcode_21 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query('02');">		
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
					<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">계정코드</td>
					<td>&nbsp;<comment id="__NSID__">
						<object  id=gcem_atcode_22 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:86px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query('02');">		
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				<td width="1px" align=right>&nbsp;</td>
					<td valign="bottom" align=right>
					<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel('gcgd_disp02','관리항목')">
					<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Delete('02')" >
					<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add('02')" >
					<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save('02')">
					<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query('02')">&nbsp;
				</td>
			</tr>
		</table>
	</td>
	</tr>
  <tr><td height="2px" colspan=2></td></tr>
	<tr> 
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					  <comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
						style="position:relative;left:7px;width:275px; height:420px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_code02">
							<PARAM NAME="IndWidth"		VALUE ='0'>
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<PARAM NAME="Format"			VALUE="  
							<C> Name='계정코드'		    ID=ATCODE   	HeadAlign=Center HeadBgColor=#B9D4DC Width=78		align=center sort=true </C> 
							<C> Name='계정과목명'			ID=ATKORNAM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	sort=true </C> 
							">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:7px;width:277px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt02 style="position:relative;top:4px;"></font>
					</fieldset>
				</td>
			</tr>
			</table>
		</td>
     
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:584px;border:0 solid #708090;">
			<tr>
				<td style="width:584" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02_1  
							style="position:relative;left:0px;width:583px; height:420px; border:1 solid #708090;display:block;" viewastext>
                <PARAM NAME="DataID"			VALUE="gcds_code02_1">
								<PARAM NAME="IndWidth"		VALUE ='0'>
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="true">
                <PARAM NAME="Sortview"		VALUE="left">
								<param name="ColSelect"   value=true>
								<PARAM NAME="Format"			VALUE="  
								<C> Name='계정코드'		  ID=ATCODE   	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=center  show=false edit=none</C> 
								<C> Name='순서'		      ID=ARSEQ   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=35		align=center  sort=false edit=none</C> 
								<C> Name='관리항목'			ID=CDCODE 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=75 	align=center	sort=true EditStyle=Popup </C> 
								<C> Name='관리항목명'		ID=CDNAM    	HeadAlign=Center HeadBgColor=#B9D4DC Width=170	align=LEFT	  sort=true  edit=none</C> 
								<C> Name='차변구분'			ID=ARDEYN 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=75	  align=center	sort=true EditStyle=Combo Data='Y:사용,N:미사용'</C> 
								<C> Name='대변구분'			ID=ARCRYN 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=75	  align=center	sort=true EditStyle=Combo Data='Y:사용,N:미사용'</C> 
								<C> Name='선택구분'			ID=ARBALDIV 	HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=center	sort=true EditStyle=Combo Data='Y:선택,N:필수'</C> 
								<C> Name='타입'			ID=TYPE 	HeadAlign=Center HeadBgColor=#B9D4DC Width=65	  align=center	sort=true EditStyle=Combo Data='A:공통,B:예산,C:입력'</C> 				
								">
						</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="position:relative;left:0px;width:585px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt02_1 style="position:relative;top:4px;"></font>
					</fieldset>
          
					<!-- 관리항목 Excel -->
          <comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02_2 
							style="position:relative;left:0px;width:583px; height:420px; border:1 solid #708090;display:none;">
                <PARAM NAME="DataID"			VALUE="gcds_code02_2">
								<PARAM NAME="IndWidth"		VALUE ='0'>
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<param name="SuppressOption" value="1">
								<PARAM NAME="Format"			VALUE="  
								<C> Name='계정코드'		  ID=ATCODE   	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  suppress=2  </C> 
								<C> Name='계정코드명'		ID=ATKORNAM   HeadAlign=Center HeadBgColor=#B9D4DC Width=190	align=left    suppress=1</C> 
								<C> Name='순서'		      ID=ARSEQ   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=center  </C> 
								<C> Name='관리항목'			ID=CDCODE 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=center	</C> 
								<C> Name='관리항목명'		ID=CDNAM    	HeadAlign=Center HeadBgColor=#B9D4DC Width=190	align=LEFT	  </C> 
								<C> Name='차변구분'			ID=ARDEYN 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=75	  align=center	</C> 
								<C> Name='대변구분'			ID=ARCRYN 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=75	  align=center	</C> 
								<C> Name='잔액여부'			ID=ARBALDIV 	HeadAlign=Center HeadBgColor=#B9D4DC Width=75	  align=center	</C>  
								">
						</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
			</table>
    </td> 
	</tr> 
</table> 

<!-- 출력순서 -->
<fieldset id=field3 style="position:absolute;top:160px;left:18px;height:485px;width:878px;bacground-color:#708090"></fieldset>
<table id="div_disp3" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr>
  <td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr> 				
				<!--td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">계정코드</td>
				<td>&nbsp;
					<comment id="__NSID__"><object  id=gcem_atcode_fr03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:5px;">		
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Numeric       value=false>
									<param name=Format        value="#######">
									<param name=PromptChar    value="">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
          
					<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px" align=center onclick="ln_Popup('fr','03');">
          	
					<input id="txt_atkornam_fr03" type="text" class="txtbox"  style= "position:relative;top:1px;width:130px;height:20px;" maxlength="36"  disabled>
					~&nbsp;
        
				 <comment id="__NSID__"><object  id=gcem_atcode_to03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:5px">				
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Numeric       value=false>
									<param name=Format        value="#######">
									<param name=PromptChar    value="">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
          
					<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px" align=center onclick="ln_Popup('to','03');">
					<input id="txt_atkornam_to03" type="text" class="txtbox"  style= "position:relative;top:1px;width:130px;height:20px;" maxlength="36"  disabled>
				</td-->
					<td width="80" class="tab12" bgcolor="#eeeeee" align="center">계정명</td>
					<td class="tab23" style="width:135px">&nbsp;<comment id="__NSID__">
						<object  id=gcem_atcode_31 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query('03');">		
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
					<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">계정코드</td>
					<td>&nbsp;<comment id="__NSID__">
						<object  id=gcem_atcode_32 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:86px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query('03');">		
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				<td width="1px" align=right>&nbsp;</td>
				<td valign="bottom" align=right>
					<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save('03')">
					<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query('03')">&nbsp;
				</td>
			</tr>
		</table>
		
	</td>
	</tr>

	<tr><td height="2px" colspan =2></td></tr>

	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp03  
						style="position:relative;left:8px;width:864px; height:419px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_code03">
							<PARAM NAME="IndWidth"		VALUE ='0'>
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
              <param name="Editable"    value="true">
							<PARAM NAME="Format"			VALUE="  
							<C> Name='계정코드'		    ID=ATCODE   	HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=center sort=true Edit=None</C> 
							<C> Name='계정과목명'			ID=ATKORNAM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=310	align=LEFT	 sort=true Edit=None</C> 
							<C> Name='출력순서'			  ID=ATPRTSEQ 	HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=right	 sort=true  </C> 
              <C> Name='상위계정'		  	ID=ATUPCODE 	HeadAlign=Center HeadBgColor=#B9D4DC Width=75	  align=center sort=true Edit=None</C> 
							<C> Name='상위계정명'			ID=ATUPCDNM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=316	align=LEFT	 sort=true Edit=None</C> 
							">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;"></font>
					</fieldset>
			</td>
			</tr>
			</table>
		</td> 
	</tr> 
</table> 

<!-- Tree 항목 -->
<fieldset id=field4 style="position:absolute;top:160px;left:18px;height:485px;width:878px;bacground-color:#708090"></fieldset>
<table id="div_disp4" cellpadding="0" cellspacing="0" border="0" style="display:none"><!--1-->
	<tr>
 	<td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;"><!--2-->
			<tr> 				
				<!--td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">계정코드</td>
				<td>&nbsp;
					<comment id="__NSID__"><object  id=gcem_atcode_fr04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:5px">		
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Numeric       value=false>
									<param name=Format        value="#######">
									<param name=PromptChar    value="">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px" align=center onclick="ln_Popup('fr','04');">
					<input id="txt_atkornam_fr04" type="text" class="txtbox"  style= "position:relative;top:1px;width:130px; height:20px;" maxlength="36"  disabled>
					~&nbsp;
				 <comment id="__NSID__"><object  id=gcem_atcode_to04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:5px">				
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Numeric       value=false>
									<param name=Format        value="#######">
									<param name=PromptChar    value="">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px" align=center onclick="ln_Popup('to','04');">
					<input id="txt_atkornam_to04" type="text" class="txtbox"  style= "position:relative;top:1px;width:130px; height:20px;" maxlength="36"  disabled>

				</td-->
					<td width="80" class="tab12" bgcolor="#eeeeee" align="center">계정명</td>
					<td class="tab23" style="width:135px">&nbsp;<comment id="__NSID__">
						<object  id=gcem_atcode_41 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query('04');">		
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
					<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">계정코드</td>
					<td>&nbsp;<comment id="__NSID__">
						<object  id=gcem_atcode_42 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:86px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query('04');">		
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				<td width="1px" align=right>&nbsp;</td>
				<td valign="bottom" align=right>
					<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query('04')">&nbsp;
				</td>
			</tr>
		</table>
	</td>
	</tr>
	<tr><td height="2px" colspan =2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;width:330px;border:0 solid #708090;"><!--2-->
			<tr> 			
			<td>
					<comment id="__NSID__"><object  id=gcte_tree classid=CLSID:4401B994-DD33-11D2-B539-006097ADB678 style="position:relative;left:7px;width:325px; height:440px; border:1 solid #708090;">
             <param name=DataID        value="gcds_code04">
             <param name=TextColumn    value="ATKORNAM">
            <!--  <param name=TypeColumn    value="Type"> -->
						<Param Name="BorderStyle"		value="0">
						<param name="UseImage"			value="true"> 
            <param name=LevelColumn   value="LEVEL">
          </object></comment><script>__ws__(__NSID__);</script> 
			</td>
			</tr>
			</table>
		</td>

		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:534px;border:0 solid #708090;"><!--2-->
			<tr>
				<td>
					<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:534px;border:0 solid #708090;"><!--3-->
						<tr>
						  <td>
								<table cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td class="tab15" style="width:100px;" bgcolor="#eeeeee" align=center>계정코드</td>
										<td class="tab18" style="width:60px;"align=center >&nbsp;
											<input id="txt_atcode04" type="text" class="txtbox"  style= "width:50px; height:20px;position:relative;left:-4px" readonly="true">
										</td>
										<td class="tab18" style="width:370px;"align=left >&nbsp;
											<input id="txt_atkornam04" type="text" class="txtbox"  style= "width:360px; height:20px;position:relative;left:-4px" readonly="true"> 
										</td>
                  </tr>
								</table>

								<table cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td class="tab17" style="width:100px;" bgcolor="#eeeeee" align=center>계정출력명</td>
										<td class="tab19" style="width:431px;"align=left >&nbsp;
											<input id="txt_atprtnam04" type="text" class="txtbox"  style= "width:420px; height:20px;position:relative;left:-3px"  readonly="true"> 
										</td>
                  </tr>
								</table>

								<table cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td class="tab17" style="width:100px;" bgcolor="#eeeeee" align=center>상위계정</td>
										<td class="tab19" style="width:60px;"align=center >&nbsp;
											<input id="txt_atupcode04" type="text" class="txtbox"  style= "width:50px; height:20px;position:relative;left:-4px"  readonly="true">
										</td>
										<td class="tab19" style="width:370px;"align=left >&nbsp;
											<input id="txt_atupnam04" type="text" class="txtbox"  style= "width:360px; height:20px;position:relative;left:-4px"  readonly="true"> 
										</td>
                  </tr>
								</table>

								<table cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td class="tab17" style="width:100px;" bgcolor="#eeeeee" align=center>충당금여부</td>
										<td class="tab19" style="width:60px;"align=center >&nbsp;
											<input id="txt_atapryn04" type="text" class="txtbox"  style= "width:50px; height:20px;position:relative;left:-4px"  readonly="true">
										</td>
										<td class="tab19" style="width:100px;" bgcolor="#eeeeee" align=center>충당금코드</td>
										<td class="tab19" style="width:60px;"align=center >&nbsp;
											<input id="txt_ataprcode04" type="text" class="txtbox"  style= "width:50px; height:20px;position:relative;left:-4px"  readonly="true" >
										</td>
										<td class="tab19" style="width:208px;"align=center >&nbsp;
											<input id="txt_ataprnam04" type="text" class="txtbox"  style= "width:198px; height:20px;position:relative;left:-4px"  readonly="true"> 
										</td>
                  </tr>
								</table>

								<table cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td class="tab17" style="width:100px;" bgcolor="#eeeeee" align=center>계정구분</td>
										<td class="tab19" style="width:60px;"align=center >&nbsp;
											<input id="txt_atdiv04" type="text" class="txtbox"  style= "width:50px; height:20px;position:relative;left:-4px" readonly="true" >
										</td>
										<td class="tab19" style="width:100px;" bgcolor="#eeeeee" align=center>계정그룹</td>
										<td class="tab19" style="width:60px;"align=center >&nbsp;
											<input id="txt_atgrp04" type="text" class="txtbox"  style= "width:50px; height:20px;position:relative;left:-4px" readonly="true" >
										</td>
										<td class="tab19" style="width:100px;" bgcolor="#eeeeee" align=center>출력순서</td>
										<td class="tab19" style="width:107px;"align=center >&nbsp;
											<input id="txt_atprtseq04" type="text" class="txtbox"  style= "width:97px; height:20px;position:relative;left:-4px" readonly="true" > 
										</td>
                  </tr>

									<tr>
										<td class="tab17" style="width:100px;" bgcolor="#eeeeee" align=center>기준차대</td>
										<td class="tab19" style="width:60px;"align=center >&nbsp;
											<input id="txt_atdecr04" type="text" class="txtbox"  style= "width:50px; height:20px;position:relative;left:-4px" readonly="true" >
										</td>
										<td class="tab19" style="width:100px;" bgcolor="#eeeeee" align=center>전표발생</td>
										<td class="tab19" style="width:60px;"align=center >&nbsp;
											<input id="txt_atuseyn04" type="text" class="txtbox"  style= "width:50px; height:20px;position:relative;left:-4px" readonly="true" >
										</td>
										<td class="tab19" style="width:100px;" bgcolor="#eeeeee" align=center>반제</td>
										<td class="tab19" style="width:107px;"align=center >&nbsp;
											<input id="txt_atdebtyn04" type="text" class="txtbox"  style= "width:97px; height:20px;position:relative;left:-4px" readonly="true" > 
										</td>
                  </tr>

									<tr>
										<td class="tab17" style="width:100px;" bgcolor="#eeeeee" align=center>외화관리</td>
										<td class="tab19" style="width:60px;"align=center >&nbsp;
											<input id="txt_atforcuryn04" type="text" class="txtbox"  style= "width:50px; height:20px;position:relative;left:-4px" readonly="true" >
										</td>
										<td class="tab19" style="width:100px;" bgcolor="#eeeeee" align=center>환율구분</td>
										<td class="tab19" style="width:60px;"align=center >&nbsp;
											<input id="txt_atcurtype04" type="text" class="txtbox"  style= "width:50px; height:20px;position:relative;left:-4px" readonly="true" >
										</td>
										<td class="tab19" style="width:100px;" bgcolor="#eeeeee" align=center>일계표</td>
										<td class="tab19" style="width:107px;"align=center >&nbsp;
											<input id="txt_atdaybalyn04" type="text" class="txtbox"  style= "width:97px; height:20px;position:relative;left:-4px" readonly="true" > 
										</td>
                  </tr>

									<tr>
										<td class="tab17" style="width:100px;" bgcolor="#eeeeee" align=center>보조부</td>
										<td class="tab19" style="width:60px;"align=center >&nbsp;
											<input id="txt_atsupplyn04" type="text" class="txtbox"  style= "width:50px; height:20px;position:relative;left:-4px" readonly="true" >
										</td>
										<td class="tab19" style="width:100px;" bgcolor="#eeeeee" align=center>총계정원장</td>
										<td class="tab19" style="width:60px;"align=center >&nbsp;
											<input id="txt_attotaccyn04" type="text" class="txtbox"  style= "width:50px; height:20px;position:relative;left:-4px" readonly="true" >
										</td>
										<td class="tab19" style="width:100px;" bgcolor="#eeeeee" align=center>합계시산표</td>
										<td class="tab19" style="width:107px;"align=center >&nbsp;
											<input id="txt_atsumbalyn04" type="text" class="txtbox"  style= "width:97px; height:20px;position:relative;left:-4px" readonly="true"> 
										</td>
                  </tr>

									<tr>
										<td class="tab17" style="width:100px;" bgcolor="#eeeeee" align=center>대차대조표</td>
										<td class="tab19" style="width:60px;"align=center >&nbsp;
											<input id="txt_atbalshtyn04" type="text" class="txtbox"  style= "width:50px; height:20px;position:relative;left:-4px" readonly="true" >
										</td>
										<td class="tab19" style="width:100px;" bgcolor="#eeeeee" align=center>손익계산서</td>
										<td class="tab19" style="width:60px;"align=center >&nbsp;
											<input id="txt_atprolstyn04" type="text" class="txtbox"  style= "width:50px; height:20px;position:relative;left:-4px" readonly="true">
										</td>
										<td class="tab19" style="width:100px;" bgcolor="#eeeeee" align=center>부속명세서</td>
										<td class="tab19" style="width:107px;"align=center >&nbsp;
											<input id="txt_atattshtyn04" type="text" class="txtbox"  style= "width:97px; height:20px;position:relative;left:-4px" readonly="true" > 
										</td>
                  </tr>

									<tr>
										<td class="tab17" style="width:100px;" bgcolor="#eeeeee" align=center>제조원가명세표</td>
										<td class="tab19" style="width:60px;"align=center >&nbsp;
											<input id="txt_atmakyn04" type="text" class="txtbox"  style= "width:50px; height:20px;position:relative;left:-4px" readonly="true" >
										</td>
										<td class="tab19" style="width:100px;" bgcolor="#eeeeee" align=center>공사원가명세표</td>
										<td class="tab19" style="width:60px;"align=center >&nbsp;
											<input id="txt_atwrkyn04" type="text" class="txtbox"  style= "width:50px; height:20px;position:relative;left:-4px" readonly="true" >
										</td>
										<td class="tab19" style="width:100px;" bgcolor="#eeeeee" align=center>운송원가명세표</td>
										<td class="tab19" style="width:107px;"align=center >&nbsp;
											<input id="txt_attrayn04" type="text" class="txtbox"  style= "width:97px; height:20px;position:relative;left:-4px" readonly="true" > 
										</td>
                  </tr>

									<tr>
										<td class="tab17" style="width:100px;" bgcolor="#eeeeee" align=center>기타원가명세표</td>
										<td class="tab19" style="width:60px;"align=center >&nbsp;
											<input id="txt_atetcyn04" type="text" class="txtbox"  style= "width:50px; height:20px;position:relative;left:-4px" readonly="true" >
										</td>
										<td class="tab19" style="width:100px;" bgcolor="#eeeeee" align=center>상대변사용</td>
										<td class="tab19" style="width:60px;"align=center >&nbsp;
											<input id="txt_atoppuseyn04" type="text" class="txtbox"  style= "width:50px; height:20px;position:relative;left:-4px" readonly="true" >
										</td>
										<td class="tab19" style="width:100px;" bgcolor="#eeeeee" align=center>예산연결</td>
										<td class="tab19" style="width:107px;"align=center >&nbsp;
											<input id="txt_atbdgrelyn04" type="text" class="txtbox"  style= "width:97px; height:20px;position:relative;left:-4px" readonly="true" > 
										</td>
                  </tr>
								</table>

								<table cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td class="tab17" style="width:100px;" bgcolor="#eeeeee" align=center>적용일자</td>
										<td class="tab19" style="width:161px;"align=left >&nbsp;<comment id="__NSID__">
											<object  id=gcem_basdat04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style= "width:80px; height:20px;position:relative;left:1px;top:2px;" >		
												<param name=Text					value="">
												<param name=Alignment     value=0>
												<param name=Border        value=true>
												<param name=ReadOnly      value=true>
												<param name=Numeric       value=false>
												<param name=Format        value="####/##/##">
												<param name=PromptChar    value="">
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
											</object></comment><script>__ws__(__NSID__);</script> 
										</td>

										<td class="tab19" style="width:100px;" bgcolor="#eeeeee" align=center>폐기일자</td>
										<td class="tab19" style="width:168px;"align=left >&nbsp;<comment id="__NSID__">
											<object  id=gcem_dsudt04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style= "width:80px; height:20px;position:relative;left:1px;top:2px;" >		
												<param name=Text					value="">
												<param name=Alignment     value=0>
												<param name=Border        value=true>
												<param name=ReadOnly      value=true>
												<param name=Numeric       value=false>
												<param name=Format        value="####/##/##">
												<param name=PromptChar    value="">
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
											</object></comment><script>__ws__(__NSID__);</script> 
										</td>
                  </tr>
								</table>

								<table cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td class="tab17" style="width:100px;" bgcolor="#eeeeee" align=center>계정코드해설</td>
										<td class="tab19" style="width:431px;"align=left >&nbsp;
										  <textarea id="txa_attxt04" class="txtbox"  style= "width:421px;height:139px; overflow:auto;position:relative;left:-3px" readonly="true"></textarea>
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

<!-- 세목코드 -->
<!--  
<fieldset id=field5 style="position:absolute;top:155px;left:173px;height:485px;width:875px;bacground-color:#708090"></fieldset>
<table id="div_disp5" cellpadding="0" cellspacing="0" border="0" style="display:none">
		<tr>
			<td align="center" colspan=2>
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">

					<tr> 				
					<td width="80" class="tab12" bgcolor="#eeeeee" align="center">계정명</td>
					<td class="tab23" style="width:135px">&nbsp;<comment id="__NSID__">
						<object  id=gcem_atcode_51 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query('05');">		
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script>  
					</td>
					<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">계정코드</td>
					<td>&nbsp;<comment id="__NSID__">
						<object  id=gcem_atcode_52 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:86px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query('05');">		
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>						
						<td width="1px" align=right>&nbsp;</td>
							<td valign="bottom" align=right>
							<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Delete('05')" >
							<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add('05')" >
							<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save('05')">
							<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query('05')">&nbsp;
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height="2px" colspan =3></td></tr>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;width:493px;border:0 solid #708090;">
			<tr> 	
				
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
				
					<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp05  
							style="position:relative;left:7px;width:493px; height:421px; border:1 solid #708090;display:block;"viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_code05">
							<PARAM NAME="IndWidth"		VALUE ='0'>
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
              <param name="Editable"    value="false">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='계정코드'		    ID=ATCODE   	HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=center Edit=None</C> 
								<C> Name='계정과목명'			ID=ATKORNAM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=LEFT	Edit=None</C> 
								<C> Name='세목코드'		    ID=BUDDTL   	HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=center Edit=None</C> 
								<C> Name='세목명'					ID=BUDNAM			HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=cneter	 Edit=None</C> 
								<C> Name='비고'					  ID=REMARK    	HeadAlign=Center HeadBgColor=#B9D4DC Width=134 align=left 	 Edit=None</C> 
							">
					</object></comment><script>__ws__(__NSID__);</script> 

						<fieldset style="position:relative;left:7px;width:495px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt05 style="position:relative;top:4px;"></font>
						</fieldset>
				</td>
				</tr>
				</table>
			</td>

			<td align="right">
			<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:7px;width:366px;border:0 solid #708090;">
			<tr>
			
				<td class="tab15" style="height:30px;width:120px;" bgcolor="#eeeeee" align=center >계정코드</td>
						<td style="height:25px;border:1 solid #708090;border-top-width:1px;border-left-width:0px" >&nbsp;<comment id="__NSID__">
							<object  id=gcem_atdowncode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:2px;top:5px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Numeric       value=false>
											<param name=Format        value="#######">
											<param name=PromptChar    value="">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script> 
							<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px" align=center onclick="ln_Popup('down','05');">
							</td>
							</tr>
								
			<tr>
				<td class="tab15" style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center >계&nbsp;정&nbsp;명</td>
				<td class="tab18" style="border:1 solid #708090;border-top-width:0px;border-left-width:0px"align=left >&nbsp;
				<input id="txt_atdownnam" type="text" class="txtbox"  style= "position:relative;top:0px;width:230px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" >
				</td>
			</tr>

				<tr>
				<td class="tab15" style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center >세목코드</td>
				<td class="tab18" style="border:1 solid #708090;border-top-width:0px;border-left-width:0px"align=left >&nbsp;					
					<comment id="__NSID__"><object  id=gcem_buddtl classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:20px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=Alignment     value=2>
						<param name=Numeric       value=true>
						<param name=Border        value=true>
						<param name=Format        value="##">
						<param name=MaxLength     value=2>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">           
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>

<tr>
		<td class="tab15" style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center >세목명</td>
				<td class="tab18" style="border:1 solid #708090;border-top-width:0px;border-left-width:0px"align=left >&nbsp;
					<input id="txt_budnam" type="text" class="txtbox"  style= "position:relative;top:0px;width:230px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,30);" >
				</td>
			</tr>
			<tr>
				<td class="tab17" style="height:40px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center >비     고</td>
				<td class="tab19" align=left colspan=3 >&nbsp;
					<textarea id="txa_remark" class="txtbox"  style= "position:relative;top:0px;width:230px;height:38px;"   maxlength="100" ></textarea>
				</td>
			</tr>
			<tr>
		<td height="295px" style="border:1 solid 
				#708090;border-right-width:0px;border-top-width:0px;">&nbsp;</td>
		<td height="295px" style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;">&nbsp;</td>
	</tr>
</table>
		</td>
	</tr> 
</table> 
-->


<!-- 결산보고서양식 -->
<fieldset id=field6 style="position:absolute;top:160px;left:18px;height:485px;width:878px;bacground-color:#708090"></fieldset>
<table id="div_disp6" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr>
		<td align="left" colspan=2>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
				<tr> 				
					<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">결산보고서</td>
					<td>&nbsp;<comment id="__NSID__">
						<object  id=gclx_prtcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:1px;width:150px;height:150px;">
							<param name=ComboDataID			value="gcds_comcode03">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="FALSE">
							<param name=ListExprFormat	value="CDNAM^0^145">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
					<td width="1px" align=right>&nbsp;</td>
						<td align=right valign="bottom"  style="position:relative;right:9px;top:0px;">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Delete('06')" >
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add('06')" >
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save('06')">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query('06')">&nbsp;
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td height="2px" colspan=3></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;width:493px;border:0 solid #708090">
				<tr> 	
					<td style="width:280" ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object  id=gcgd_disp06  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
						style="position:relative;left:7px;width:573px;height:421px;border:1 solid #708090;display:block;">
						<PARAM NAME="DataID"			VALUE="gcds_code06">
						<PARAM NAME="IndWidth"		VALUE="0">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<PARAM NAME="Sortview"		VALUE="left">
						<param name="Editable"    value="true">
						<param name="ColSizing"   value="true">
						<PARAM NAME="Format"			VALUE="  
							<C> Name='번호'				ID=PRTNBR HeadAlign=Center HeadBgColor=#B9D4DC Width=45	 align=center</C> 
							<C> Name='출력형식'		ID=PRTNAM	HeadAlign=Center HeadBgColor=#B9D4DC Width=162 align=left	 </C> 
							<C> Name='계정코드'		ID=ATCODE	HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=center</C> 
							<C> Name='좌변계산식'	ID=PRTLT  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	 align=left</C>
							<C> Name='우변계산식'	ID=PRTRT  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	 align=left</C> 
							<C> Name='순서'				ID=PRTSEQ	HeadAlign=Center HeadBgColor=#B9D4DC Width=40	 align=center</C> 
							<C> Name='구분'				ID=PRTNO  HeadAlign=Center HeadBgColor=#B9D4DC Width=40	 align=center</C>
							<C> Name='좌우'				ID=LRDIV  HeadAlign=Center HeadBgColor=#B9D4DC Width=40	 align=center EditStyle='Combo' Data='L:좌변,R:우변'</C>
						">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:7px;width:575px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt06 style="position:relative;top:4px;"></font>
					</fieldset>
				</td>
			</tr>
		</table>
	</td>
	<td valign=top align="right">
<table cellpadding="0" cellspacing="0" border="0" style="width:266px;position:relative;left:7px;border:1 solid #708090;">
	<tr>
		<td class="tab11" style="height:30px;width:120px;" bgcolor="#eeeeee">등록번호</td>
		<td class="tab22" style="height:30px;">&nbsp;<comment id="__NSID__">
			<object  id=gcem_prtnbr style="height:20px;width:40px;position:relative;left:-2px;top:2px" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F>		
				<param name=Text					value="">
				<param name=Alignment     value=0>
				<param name=Border        value=true>
				<param name=Numeric       value=false>
				<param name=Format        value="#####">
				<param name=PromptChar    value="_">
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
	<tr>
		<td class="tab11" style="height:30px;" bgcolor="#eeeeee">계정코드</td>
		<td class="tab22" style="height:30px;">&nbsp;<comment id="__NSID__">
			<object  id=gcem_atcode_06 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:-1px;top:5px;">		
				<param name=Text					value="">
				<param name=Alignment     value=0>
				<param name=Border        value=true>
				<param name=Numeric       value=false>
				<param name=Format        value="#######">
				<param name=PromptChar    value="_">
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script> 
			<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:2px;top:1px" align=center onclick="ln_Popup('fr','08');">
		</td>
	</tr>
	<tr>
		<td class="tab11" style="height:30px;" bgcolor="#eeeeee">좌우구분</td>
		<td class="tab22" style="height:30px;"><comment id="__NSID__">
			<!-- <object  id=gcra_lrdiv classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
					style="position:relative;left:0px;top:1px;height:20px;width:170px;cursor:hand;">
				<param name=Cols     value="2">
				<param name=Format   value="L^좌변,R^우변">
			</object></comment><script>__ws__(__NSID__);</script> -->
			<object  id=gclx_lrdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
				style="position:relative;left:5px;top:2px;font-size:12px;width:70px;">
				<param name=CBData					value="L^좌변,R^우변">
				<param name=CBDataColumns		value="CDCODE,CDNAM">
				<param name=SearchColumn		value="CDNAM">
				<param name=Sort						value="false">
				<param name=ListExprFormat	value="CDNAM^0^70">
				<param name=BindColumn			value="CDCODE">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>
	<tr>
		<td class="tab11" style="height:30px;" bgcolor="#eeeeee">출력형식</td>
		<td class="tab22" style="height:30px;">&nbsp;
			<textarea id="txa_prtnam" class="txtbox" style="position:relative;left:-8px;top:0px;width:200px;height:60px;" maxlength="100"></textarea>
		</td>
	</tr>
	<tr>
		<td class="tab11" style="height:30px;" bgcolor="#eeeeee" align=center>좌변계산식<p>
			<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_titleacc.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:0px;top:0px" align=center onclick="ln_Popup('lt','06');">
			<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_registnum.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:3px;top:3px" align=center onclick="ln_Popup2('01');">&nbsp;
		</td>
		<td class="tab22" style="height:100px;">&nbsp;<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_plus.gif" style="cursor:hand;position:relative;left:-2px;top:3px" border="0" onclick="txa_prtlt.value = '+' + txa_prtlt.value;">
		<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_minor.gif"		style="cursor:hand;position:relative;left:-2px;top:3px" border="0" onclick="txa_prtlt.value = txa_prtlt.value + '-';">
		<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_multip.gif"	style="cursor:hand;position:relative;left:-2px;top:3px" border="0" onclick="txa_prtlt.value = txa_prtlt.value + '*';">
		<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_divis.gif"		style="cursor:hand;position:relative;left:-2px;top:3px" border="0" onclick="txa_prtlt.value = txa_prtlt.value + '/';">
		<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_lg.gif"			style="cursor:hand;position:relative;left:-2px;top:3px" border="0" onclick="txa_prtlt.value = txa_prtlt.value + '(';">
		<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_rg.gif"			style="cursor:hand;position:relative;left:-2px;top:3px" border="0" onclick="txa_prtlt.value = txa_prtlt.value + ')';">
		<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_back.gif"		style="cursor:hand;position:relative;left:-2px;top:3px" border="0" onClick="ln_CacuLtRt('01')"><br>
			<textarea id="txa_prtlt" class="txtbox"					style="position:relative;left:4px;top:0px;width:200px;height:91px;" maxlength="100" rows="5" cols="50"></textarea>
		</td>
	</tr>
	<tr>
		<td class="tab11" style="height:30px;" bgcolor="#eeeeee" align=center>우변계산식<p>
			<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_titleacc.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:0px;top:0px" align=center onclick="ln_Popup('rt','07');">
			<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_registnum.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:3px;top:3px" align=center onclick="ln_Popup2('02');">&nbsp;
		</td>
		<td class="tab22" style="height:100px;">&nbsp;<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_plus.gif" style="cursor:hand;position:relative;left:-2px;top:3px" border="0" onclick="txa_prtrt.value = txa_prtrt.value + '+';" onkeyup="txa_prtrt.value = txa_prtrt.value + '+' ">
		<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_minor.gif"  style="cursor:hand;position:relative;left:-2px;top:3px" border="0" onclick="txa_prtrt.value = txa_prtrt.value + '-';">
		<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_multip.gif" style="cursor:hand;position:relative;left:-2px;top:3px" border="0" onclick="txa_prtrt.value = txa_prtrt.value + '*';">
		<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_divis.gif"  style="cursor:hand;position:relative;left:-2px;top:3px" border="0" onclick="txa_prtrt.value = txa_prtrt.value + '/';">
		<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_lg.gif"     style="cursor:hand;position:relative;left:-2px;top:3px" border="0" onclick="txa_prtrt.value = txa_prtrt.value + '(';">
		<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_rg.gif"     style="cursor:hand;position:relative;left:-2px;top:3px" border="0" onclick="txa_prtrt.value = txa_prtrt.value + ')';">
		<img id="evt_rt" src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_back.gif"   style="cursor:hand;position:relative;left:-2px;top:3px" border="0" onClick="ln_CacuLtRt('02')"><br>
			<textarea id="txa_prtrt" class="txtbox"        style="position:relative;left:4px;top:0px;width:200px;height:91px;" maxlength="100"></textarea>
		</td>
	</tr>
	<tr>
		<td class="tab11" style="height:30px;" bgcolor="#eeeeee">출력순서</td>
		<td class="tab22" style="height:30px;">&nbsp;<comment id="__NSID__">
			<object  id=gcem_prtseq style="height:20px;width:40px;position:relative;left:-2px;top:2px" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F>		
				<param name=Text					value="">
				<param name=Alignment     value=0>
				<param name=Border        value=true>
				<param name=Numeric       value=false>
				<param name=Format        value="#####">
				<param name=PromptChar    value="_">
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
	<tr>
		<td class="tab12" style="height:30px;" bgcolor="#eeeeee" align=center >구분</td>
		<td style="height:30px;">&nbsp;<comment id="__NSID__">
			<object  id=gcem_prtno style="height:20px;width:40px;position:relative;left:-2px;top:2px" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F>		
				<param name=Text					value="">
				<param name=Alignment     value=0>
				<param name=Border        value=true>
				<param name=Numeric       value=false>
				<param name=Format        value="#####">
				<param name=PromptChar    value="_">
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
</table>
		</td>
	</tr> 
</table> 
		</td>
	</tr> 
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N  --- [계 정 코 드]
------------------------------------------------------------------------------>
<comment id="__NSID__">
   <object  id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_code01>
	<param name=BindInfo  value="  
		<C>Col=ATCODE				Ctrl=gcem_atcode				Param=Text</C>
		<C>Col=ATKORNAM			Ctrl=gcem_atkornam			Param=Text</C>
		<C>Col=ATDIV				Ctrl=gclx_atdiv					Param=BindColVal</C>
		<C>Col=ATGRP				Ctrl=gclx_atgrp					Param=BindColVal</C>
		<C>Col=ATDECR				Ctrl=gcra_atdecr				Param=CodeValue</C>
		<C>Col=ATUSEYN			Ctrl=gcra_atuseyn				Param=CodeValue</C>
		<C>Col=ATUPCODE			Ctrl=gcem_atupcode			Param=Text</C>
		<C>Col=ATPRTSEQ			Ctrl=gcem_atprtseq			Param=Text</C>
		<C>Col=ATFORCURYN		Ctrl=gcra_atforcuryn		Param=CodeValue</C>
		<C>Col=ATCURTYPE		Ctrl=gcra_atcurtype			Param=CodeValue</C>
		<C>Col=ATAPRYN			Ctrl=gcra_atapryn				Param=CodeValue</C>
		<C>Col=ATAPRCODE		Ctrl=gcem_ataprcode			Param=Text</C>
		<C>Col=ATDAYBALYN		Ctrl=gcra_atdaybalyn		Param=CodeValue</C>
		<C>Col=ATSUPPLYN		Ctrl=gcra_atsupplyn			Param=CodeValue</C>
		<C>Col=ATTOTACCYN		Ctrl=gcra_attotaccyn		Param=CodeValue</C>
		<C>Col=ATSUMBALYN		Ctrl=gcra_atsumbalyn		Param=CodeValue</C>
		<C>Col=ATBALSHTYN		Ctrl=gcra_atbalshtyn		Param=CodeValue</C>
		<C>Col=ATPROLSTYN		Ctrl=gcra_atprolstyn		Param=CodeValue</C>
		<C>Col=ATATTSHTYN		Ctrl=gcra_atattshtyn		Param=CodeValue</C>
		<C>Col=ATMAKYN			Ctrl=gcra_atmakyn				Param=CodeValue</C>
		<C>Col=ATWRKYN			Ctrl=gcra_atwrkyn				Param=CodeValue</C>
		<C>Col=ATTRAYN			Ctrl=gcra_attrayn				Param=CodeValue</C>
		<C>Col=ATETCYN			Ctrl=gcra_atetcyn				Param=CodeValue</C>
		<C>Col=ATOPPUSEYN		Ctrl=chk_atoppuseyn			Param=value</C>
		<C>Col=FUNDIV	    	Ctrl=gclx_fundiv01  		Param=BindColVal</C>
		<C>Col=ATDEBTYN			Ctrl=gcra_atdebtyn			Param=CodeValue</C>
		<C>Col=ATTXT				Ctrl=txa_attxt					Param=value</C>
		<C>Col=BASDAT				Ctrl=gcem_basdat				Param=Text</C>
		<C>Col=DSUDT				Ctrl=gcem_dsudt					Param=Text</C>
		<C>Col=ATUPCDNM			Ctrl=gcem_atupnam				Param=text</C>
		<C>Col=ATAPRNAM			Ctrl=gcem_ataprnam			Param=Text</C>
		<C>Col=ATPRTNAM			Ctrl=gcem_atprtnam			Param=Text</C>
		<C>Col=COMMUSE			Ctrl=gclx_commuse				Param=BindColVal</C>
		<C>Col=FSREFCD			Ctrl=gclx_fsrefcd01			Param=BindColVal</C>
	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N  --- [TREE 항 목]
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data04 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_code04_1>
	<param name=BindInfo  value='
		<C>Col=ATCODE				Ctrl=txt_atcode04				 Param=value</C>
		<C>Col=ATKORNAM			Ctrl=txt_atkornam04			 Param=value</C>
		<C>Col=ATPRTNAM			Ctrl=txt_atprtnam04			 Param=value</C>
		<C>Col=ATDIV				Ctrl=txt_atdiv04				 Param=value</C>
		<C>Col=ATGRP				Ctrl=txt_atgrp04				 Param=value</C>
		<C>Col=ATDECR				Ctrl=txt_atdecr04				 Param=value</C>
		<C>Col=ATUSEYN			Ctrl=txt_atuseyn04			 Param=value</C>
		<C>Col=ATUPCODE			Ctrl=txt_atupcode04			 Param=value</C>
		<C>Col=ATPRTSEQ			Ctrl=txt_atprtseq04			 Param=value</C>
		<C>Col=ATFORCURYN		Ctrl=txt_atforcuryn04		 Param=value</C>
		<C>Col=ATCURTYPE		Ctrl=txt_atcurtype04		 Param=value</C>
		<C>Col=ATAPRYN			Ctrl=txt_atapryn04			 Param=value</C>
		<C>Col=ATAPRCODE		Ctrl=txt_ataprcode04		 Param=value</C>
		<C>Col=ATDAYBALYN		Ctrl=txt_atdaybalyn04		 Param=value</C>
		<C>Col=ATSUPPLYN		Ctrl=txt_atsupplyn04		 Param=value</C>
		<C>Col=ATTOTACCYN		Ctrl=txt_attotaccyn04		 Param=value</C>
		<C>Col=ATSUMBALYN		Ctrl=txt_atsumbalyn04		 Param=value</C>
		<C>Col=ATBALSHTYN		Ctrl=txt_atbalshtyn04		 Param=value</C>
		<C>Col=ATPROLSTYN		Ctrl=txt_atprolstyn04		 Param=value</C>
		<C>Col=ATATTSHTYN		Ctrl=txt_atattshtyn04		 Param=value</C>
		<C>Col=ATMAKYN			Ctrl=txt_atmakyn04			 Param=value</C>
		<C>Col=ATWRKYN			Ctrl=txt_atwrkyn04			 Param=value</C>
		<C>Col=ATTRAYN			Ctrl=txt_attrayn04			 Param=value</C>
		<C>Col=ATETCYN			Ctrl=txt_atetcyn04			 Param=value</C>
		<C>Col=ATOPPUSEYN		Ctrl=txt_atoppuseyn04		 Param=value</C>
		<C>Col=ATBDGRELYN		Ctrl=txt_atbdgrelyn04		 Param=value</C>
		<C>Col=ATDEBTYN			Ctrl=txt_atdebtyn04			 Param=value</C>
		<C>Col=ATTXT				Ctrl=txa_attxt04				 Param=value</C>
		<C>Col=BASDAT				Ctrl=gcem_basdat04			 Param=text</C>
		<C>Col=DSUDT				Ctrl=gcem_dsudt04				 Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N  --- [세 목 코 드]
------------------------------------------------------------------------------>
<!-- <comment id="__NSID__"><object  id=gcbn_data05 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_code05>
	<param name=BindInfo  value='
		<C>Col=ATCODE				Ctrl=gcem_atdowncode		 Param=Text</C>
		<C>Col=ATKORNAM			Ctrl=txt_atdownnam			 Param=value</C>
		<C>Col=BUDDTL				Ctrl=gcem_buddtl				 Param=text</C>
		<C>Col=BUDNAM				Ctrl=txt_budnam					 Param=value</C>
		<C>Col=REMARK				Ctrl=txa_remark					 Param=value</C>		
	'>
</object></comment><script>__ws__(__NSID__);</script>  -->

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N  --- [결산보고서양식]
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data06 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_code06>
	<param name=BindInfo  value='
		<C>Col=PRTNBR				Ctrl=gcem_prtnbr			Param=Text</C>
		<C>Col=PRTNAM				Ctrl=txa_prtnam				Param=value</C>
		<C>Col=ATCODE				Ctrl=gcem_atcode_06		Param=Text</C>
		<C>Col=PRTLT				Ctrl=txa_prtlt				Param=value</C>
		<C>Col=PRTRT				Ctrl=txa_prtrt				Param=value</C>
		<C>Col=PRTSEQ				Ctrl=gcem_prtseq			Param=Text</C>		
		<C>Col=PRTNO				Ctrl=gcem_prtno				Param=Text</C>		
		<C>Col=LRDIV				Ctrl=gclx_lrdiv				Param=bindcolval</C>		
	'>
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print01 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"	value="gcds_report0">
	<param name="DetailDataID"	value="gcds_report01">
	<param name="PaperSize"			value="A4">
	<param name="SuppressColumns"	value="5:ATCODE">
	<param name="Format"		value="
	<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=238 ,face='Arial' ,size=12 ,penwidth=2
	<L> left=24 ,top=238 ,right=2778 ,bottom=238 </L>
	<T>id='계정코드현황' ,left=0 ,top=24 ,right=2791 ,bottom=122 ,face='HY헤드라인M' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='#p/#t' ,left=2641 ,top=177 ,right=2757 ,bottom=233 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Page:' ,left=2328 ,top=177 ,right=2590 ,bottom=233 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출력일자:' ,left=2328 ,top=127 ,right=2590 ,bottom=185 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDATE', left=2588, top=127, right=2791, bottom=185, align='right' ,mask='XXXX.XX.XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=')' ,left=1619 ,top=127 ,right=1651 ,bottom=185 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ATCODEFR', left=1177, top=127, right=1619, bottom=185, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(' ,left=1135 ,top=127 ,right=1177 ,bottom=185 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=116 ,face='Arial' ,size=12 ,penwidth=2
	<T>id='계정코드' ,left=21 ,top=0 ,right=196 ,bottom=116 ,face='굴림체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상위계정' ,left=1082 ,top=0 ,right=1228 ,bottom=116 ,face='굴림체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계정구분' ,left=1230 ,top=0 ,right=1376 ,bottom=116 ,face='굴림체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계    정    명' ,left=206 ,top=0 ,right=1082 ,bottom=116 ,face='굴림체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계정그룹' ,left=1378 ,top=0 ,right=1524 ,bottom=116 ,face='굴림체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차/대' ,left=1529 ,top=0 ,right=1664 ,bottom=116 ,face='굴림체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관리항목' ,left=1815 ,top=0 ,right=2355 ,bottom=116 ,face='굴림체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계정관리 항목코드' ,left=2355 ,top=0 ,right=2778 ,bottom=56 ,face='굴림체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차변' ,left=2355 ,top=58 ,right=2495 ,bottom=111 ,face='굴림체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='잔액' ,left=2635 ,top=58 ,right=2773 ,bottom=111 ,face='굴림체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대변' ,left=2503 ,top=58 ,right=2641 ,bottom=111 ,face='굴림체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='분개유무' ,left=1667 ,top=0 ,right=1812 ,bottom=116 ,face='굴림체' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=64 ,face='Arial' ,size=12 ,penwidth=2
	<C>id='ATCODE', left=24, top=3, right=196, bottom=64, supplevel=5, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ARBALDIV', left=2635, top=3, right=2773, bottom=64, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ARCRYN', left=2498, top=3, right=2635, bottom=64, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ARDEYN', left=2360, top=3, right=2498, bottom=64, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CDNAM', left=1815, top=3, right=2355, bottom=64, align='left', face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=24 ,top=3 ,right=2778 ,bottom=3 </L>
	<C>id='ATPRTNAM', left=206, top=3, right=1082, bottom=64, align='left', supplevel=4, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATUPCODE', left=1082, top=3, right=1228, bottom=64, supplevel=3, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATDIVNM', left=1230, top=3, right=1376, bottom=64, supplevel=2, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATGRPNM', left=1378, top=3, right=1524, bottom=64, supplevel=1, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATDECRNM', left=1529, top=3, right=1664, bottom=64, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATUSEYN', left=1667, top=3, right=1812, bottom=64, face='Arial', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=0 ,face='Arial' ,size=12 ,penwidth=2
	<L> left=24 ,top=0 ,right=2778 ,bottom=0 ,penstyle=solid ,penwidth=1 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1905 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='<%=HDConstant.PATH_ACC_COMMON%>img/icon.jpg' ,left=2392 ,top=0 ,right=2773 ,bottom=95</I>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
