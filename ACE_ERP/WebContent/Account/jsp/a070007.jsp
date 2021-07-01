<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:   자금관리 - 현금실사표
+ 프로그램 ID	:   A700007.html
+ 기 능 정 의	:   취소,등록,저장,출력,조회 화면이다.
+ 작   성  자 :   
+ 서 블 릿 명	:
-----------------------------------------------------------------------------
+ 수 정 내 용 :	현금실사표 시스템 사용을 위하여 수정     
+ 수   정  자 : 정영식
+ 수 정 일 자 : 2016.09.05
-----------------------------------------------------------------------------
+ 수 정 내 용 :	크루즈로 인하여 엔화 추가   
+ 수    정  자 : 정영식
+ 수 정 일 자 : 2017.08.08
	
------------------------------------------------------------------------------>

<html>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>현금실사표</title>


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
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;
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
		var str1  = gclx_sfdcode1.BindColVal;			   //지점코드         
		var str2  = fn_trim(gcem_acdate1.text);	           //실사일자
		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s1"+ "?v_str1="+str1+"&v_str2="+str2;
		gcds_data1.Reset();
		
		ln_Query2(str2);
	
	}else if(s=="02") {
		var str1  = gclx_sfdcode2.BindColVal;			   //지점코드         
		var str2  = fn_trim(gcem_acdate2.text);            //실사일자
		
		//
		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s2"+ "?v_str1="+str1+"&v_str2="+str2;	
		gcds_data2.Reset();

		//20160908 JYS 테이블 변경으로 사용안함. ==> ASURVEND->CASHHAND로 변경예정
		//증감...조회 이건 나중에 처리
		//gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s3"+ "?v_str1="+str1+"&v_str2="+str2;	
		//gcds_data3.Reset();

		//마감여부 체크 
		gcds_temp.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s6"+ "?v_str1="+str1+"&v_str2="+str2;
		gcds_temp.Reset();
		
		
		//증감표시
		gcds_print2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s8"+ "?v_str1="+str1+"&v_str2="+str2;	
		gcds_print2.Reset();
		
		ln_SetDataHeader2();
		
	    gcds_data3.addrow();
	    gcds_data3.namevalue(gcds_data3.rowposition,"GUBUN") ="원화(WON)";
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD01") = gcds_print2.namevalue(gcds_print2.rowposition,"A01");
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD02") = gcds_print2.namevalue(gcds_print2.rowposition,"A02");
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD03") = gcds_print2.namevalue(gcds_print2.rowposition,"A03");
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD04") = gcds_print2.namevalue(gcds_print2.rowposition,"A04");
	    
	    gcds_data3.addrow();
	    gcds_data3.namevalue(gcds_data3.rowposition,"GUBUN") ="외화(CNY)";
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD01") = gcds_print2.namevalue(gcds_print2.rowposition,"B01");
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD02") = gcds_print2.namevalue(gcds_print2.rowposition,"B02");
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD03") = gcds_print2.namevalue(gcds_print2.rowposition,"B03");
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD04") = gcds_print2.namevalue(gcds_print2.rowposition,"B04");
	    
	    gcds_data3.addrow();
	    gcds_data3.namevalue(gcds_data3.rowposition,"GUBUN") ="외화(EUR)";
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD01") = gcds_print2.namevalue(gcds_print2.rowposition,"C01");
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD02") = gcds_print2.namevalue(gcds_print2.rowposition,"C02");
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD03") = gcds_print2.namevalue(gcds_print2.rowposition,"C03");
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD04") = gcds_print2.namevalue(gcds_print2.rowposition,"C04");
	    
	    gcds_data3.addrow();
	    gcds_data3.namevalue(gcds_data3.rowposition,"GUBUN") ="외화(USD)";
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD01") = gcds_print2.namevalue(gcds_print2.rowposition,"D01");
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD02") = gcds_print2.namevalue(gcds_print2.rowposition,"D02");
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD03") = gcds_print2.namevalue(gcds_print2.rowposition,"D03");
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD04") = gcds_print2.namevalue(gcds_print2.rowposition,"D04");
	    
	    gcds_data3.addrow();
	    gcds_data3.namevalue(gcds_data3.rowposition,"GUBUN") ="외화(JPY)";
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD01") = gcds_print2.namevalue(gcds_print2.rowposition,"E01");
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD02") = gcds_print2.namevalue(gcds_print2.rowposition,"E02");
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD03") = gcds_print2.namevalue(gcds_print2.rowposition,"E03");
	    gcds_data3.namevalue(gcds_data3.rowposition,"AD04") = gcds_print2.namevalue(gcds_print2.rowposition,"E04");
	    
	    
	    
	    gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s10?v_str1="+str1+"&v_str2="+str2;	
		gcds_data4.Reset();
	    
	}
}

function ln_Query2(stracdate){
	
	var str1  = gclx_sfdcode2.BindColVal;			   //지점코드         
	var str2  = stracdate;                             //첫텝의 실사일자
	
	//
	//gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s2"+ "?v_str1="+str1+"&v_str2="+str2;	
	//gcds_data2.Reset();

	//20160908 JYS 테이블 변경으로 사용안함. ==> ASURVEND->CASHHAND로 변경예정
	//증감...조회 이건 나중에 처리
	//gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s3"+ "?v_str1="+str1+"&v_str2="+str2;	
	//gcds_data3.Reset();

	//마감여부 체크 
	gcds_temp.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s6"+ "?v_str1="+str1+"&v_str2="+str2;
	gcds_temp.Reset();
	
	
	//증감표시
	gcds_print2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s8"+ "?v_str1="+str1+"&v_str2="+str2;	
	gcds_print2.Reset();
	
	ln_SetDataHeader2();
	
    gcds_data3.addrow();
    gcds_data3.namevalue(gcds_data3.rowposition,"GUBUN") ="원화(WON)";
    gcds_data3.namevalue(gcds_data3.rowposition,"AD01") = gcds_print2.namevalue(gcds_print2.rowposition,"A01");
    gcds_data3.namevalue(gcds_data3.rowposition,"AD02") = gcds_print2.namevalue(gcds_print2.rowposition,"A02");
    gcds_data3.namevalue(gcds_data3.rowposition,"AD03") = gcds_print2.namevalue(gcds_print2.rowposition,"A03");
    gcds_data3.namevalue(gcds_data3.rowposition,"AD04") = gcds_print2.namevalue(gcds_print2.rowposition,"A04");
    
    gcds_data3.addrow();
    gcds_data3.namevalue(gcds_data3.rowposition,"GUBUN") ="외화(CNY)";
    gcds_data3.namevalue(gcds_data3.rowposition,"AD01") = gcds_print2.namevalue(gcds_print2.rowposition,"B01");
    gcds_data3.namevalue(gcds_data3.rowposition,"AD02") = gcds_print2.namevalue(gcds_print2.rowposition,"B02");
    gcds_data3.namevalue(gcds_data3.rowposition,"AD03") = gcds_print2.namevalue(gcds_print2.rowposition,"B03");
    gcds_data3.namevalue(gcds_data3.rowposition,"AD04") = gcds_print2.namevalue(gcds_print2.rowposition,"B04");
    
    gcds_data3.addrow();
    gcds_data3.namevalue(gcds_data3.rowposition,"GUBUN") ="외화(EUR)";
    gcds_data3.namevalue(gcds_data3.rowposition,"AD01") = gcds_print2.namevalue(gcds_print2.rowposition,"C01");
    gcds_data3.namevalue(gcds_data3.rowposition,"AD02") = gcds_print2.namevalue(gcds_print2.rowposition,"C02");
    gcds_data3.namevalue(gcds_data3.rowposition,"AD03") = gcds_print2.namevalue(gcds_print2.rowposition,"C03");
    gcds_data3.namevalue(gcds_data3.rowposition,"AD04") = gcds_print2.namevalue(gcds_print2.rowposition,"C04");
    
    gcds_data3.addrow();
    gcds_data3.namevalue(gcds_data3.rowposition,"GUBUN") ="외화(USD)";
    gcds_data3.namevalue(gcds_data3.rowposition,"AD01") = gcds_print2.namevalue(gcds_print2.rowposition,"D01");
    gcds_data3.namevalue(gcds_data3.rowposition,"AD02") = gcds_print2.namevalue(gcds_print2.rowposition,"D02");
    gcds_data3.namevalue(gcds_data3.rowposition,"AD03") = gcds_print2.namevalue(gcds_print2.rowposition,"D03");
    gcds_data3.namevalue(gcds_data3.rowposition,"AD04") = gcds_print2.namevalue(gcds_print2.rowposition,"D04");
    
    
    
    gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s10?v_str1="+str1+"&v_str2="+str2;	
	gcds_data4.Reset();
	
}

/******************************************************************************
	Description : 현금 공통 테이블의 내용 조회 
******************************************************************************/
function ln_Add(e){
	if(e=="01") {
		gcds_data1.ClearAll();
		var str1  = gclx_sfdcode1.BindColVal;	   //지점코드         
		var str2  = fn_trim(gcem_acdate1.text);	   //실사일자
		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s1"+ "?v_str1="+str1+"&v_str2="+str2;
		gcds_data1.Reset();
	}else if(e=="03"){
		gcds_data4.addrow();
		gcds_data4.namevalue(gcds_data4.rowposition,"FDCODE") = gclx_sfdcode2.bindcolval;
		gcds_data4.namevalue(gcds_data4.rowposition,"ACDATE") = gcem_acdate2.text;
	}
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(e){
	if(e=="01") {
		if(gcds_data1.countrow>0){
			if(gcds_data1.IsUpdated) {
				if(!ln_Chk('01')) {	return; }
				if (confirm("저장 하시겠습니까1?")){
					var str1  = gclx_sfdcode1.BindColVal;			   //지점코드         
					var str2  = fn_trim(gcem_acdate1.text);	           //실사일자
					gctr_data1.KeyValue = "Account.a070007_t1(I:USER=gcds_data1)";
					gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_t1";
					gctr_data1.Parameters = "v_str1="+str1+",v_str2="+str2;
					
					//prompt('',gcds_data1.text);
					gctr_data1.post();
					ln_Query('01');
				}
			}else alert("저장할 정보가 없습니다.");
		}else alert("저장할 정보가 없습니다.");
	} else if(e=="02") {  //마감.
		if(gcds_data2.countrow>0){
			if(gclx_statcd.bindcolval=="N"){
				if(!ln_Chk('02')) { return;}
				if (confirm("마감처리 하시겠습니까?")){
					var str1 = gclx_sfdcode2.BindColVal;			   //지점코드         
					var str2 = fn_trim(gcem_acdate2.text);            //실사일자
					var str3 = "Y";
					gctr_data1.KeyValue = "Account.a070007_t2(I:USER=gcds_data1)";
					gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_t2";
					
					gctr_data1.Parameters = "v_str1="+str1+",v_str2="+str2+",v_str3="+str3;
					//prompt('',gcds_data1.text);
					gctr_data1.post();
					ln_Query('02');
				}
				
			}else alert("이미 마감처리되었습니다");
		}else alert("마감할 정보가 없습니다.");
	} else if (e=="03"){
		
		if (confirm("저장 하시겠습니까?")){
			gctr_data1.KeyValue = "Account.a070007_t4(I:USER=gcds_data4)";
			gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_t4";
			gctr_data1.Parameters = "v_str1="+gs_userid;
			
			gctr_data1.post();
		}
	}
}

/******************************************************************************
	Description : 필수항목 입력체크 
******************************************************************************/
function ln_Chk(e) {

	if(e=="01") {
		var str1  = gclx_sfdcode1.BindColVal;			   //지점코드         
		var str2  = fn_trim(gcem_acdate1.text);	           //실사일자

		if(!ln_magam(str1,str2,'A')) {
			alert("이미 마감처리되었습니다");
			ln_Query('01');
			return false;
		}
		
		var intWon=0;
		var intCny=0;
		var intEur=0;
		var intUsd=0;
		var intJpy=0;
		var intWon2=0;
		
		//금액체크하기
	    for(var i=1;i<=gcds_data1.CountRow;i++){
	    	
	    	//alert("i::"+i+"::CDREMARK::"+gcds_data1.namevalue(i,"CDREMARK")+"::"); 
	    	
	    	if(gcds_data1.namevalue(i,"CDREMARK")==""&&gcds_data1.namevalue(i,"GRP")=="1"){
	    		intWon+=gcds_data1.namevalue(i,"SUMAMT");
	    	}
	    	
	    	if(gcds_data1.namevalue(i,"CDREMARK")==""&&gcds_data1.namevalue(i,"GRP")=="5"){
	    		intCny+=gcds_data1.namevalue(i,"SUMAMT");
	    	}
	    	
	    	if(gcds_data1.namevalue(i,"CDREMARK")==""&&gcds_data1.namevalue(i,"GRP")=="3"){
	    		intEur+=gcds_data1.namevalue(i,"SUMAMT");
	    	}
	    	
	    	if(gcds_data1.namevalue(i,"CDREMARK")==""&&gcds_data1.namevalue(i,"GRP")=="4"){
	    		intUsd+=gcds_data1.namevalue(i,"SUMAMT");
	    	}
	    	
	    	if(gcds_data1.namevalue(i,"CDREMARK")==""&&gcds_data1.namevalue(i,"GRP")=="6"){
	    		intJpy+=gcds_data1.namevalue(i,"SUMAMT");
	    	}
	    }
		
	  
	   intWon2 = Math.round(gcds_print2.namevalue(gcds_print2.rowposition,"A04")/10)*10; 	
	   
	   //alert("intWon2::"+intWon2+"::intWon::"+intWon);
	   
	   if(intWon2!=intWon){	   
		   alert("원화(WON) 금액이 틀립니다.\n입력금액 :"+intWon+":원장금액:"+gcds_print2.namevalue(gcds_print2.rowposition,"A04"));
		   return false;
	   }	
	   
	   if(gcds_print2.namevalue(gcds_print2.rowposition,"B04")!=intCny){
		   alert("외화(CNY) 금액이 틀립니다. 입력금액 :"+intCny+":원장금액:"+gcds_print2.namevalue(gcds_print2.rowposition,"B04"));
		   return false;
	   }	
	   
	   if(gcds_print2.namevalue(gcds_print2.rowposition,"C04")!=intEur){
		   alert("외화(EUR 금액이 틀립니다.입력금액 :"+intEur+":원장금액:"+gcds_print2.namevalue(gcds_print2.rowposition,"C04"));
		   return false;
	   }	
	   
	   if(gcds_print2.namevalue(gcds_print2.rowposition,"D04")!=intUsd){
		   alert("외화(USD) 금액이 틀립니다.입력금액 :"+intUsd+":원장금액:"+gcds_print2.namevalue(gcds_print2.rowposition,"D04"));
		   return false;
	   }	
	   
	   if(gcds_print2.namevalue(gcds_print2.rowposition,"E04")!=intJpy){
		   alert("외화(JPY) 금액이 틀립니다.입력금액 :"+intJpy+":원장금액:"+gcds_print2.namevalue(gcds_print2.rowposition,"E04"));
		   return false;
	   }	
	   
		
	} else if(e=="02") {
		var str1  = gclx_sfdcode2.BindColVal;			   //지점코드         
		var str2  = fn_trim(gcem_acdate2.text);            //실사일자
	
		if(!ln_magam(str1,str2,'B')) {
			alert("이미 마감처리되었습니다");
			return false;
		}
		
		//if(ln_magam(str1,str2,'B')==true) {
		//	alert("아직 마감하지 않은 자료가 존재합니다");
		//	return true;
		//}
	}
	
	return true;
}

/******************************************************************************
	Description : 마감
******************************************************************************/
function ln_magam(parm1,parm2,gubn) {
//gubn="A":해당일마감여부체크    gubn="B":전일마감여부체크  gubn="C":마감취소시 마감체크

	switch(gubn) {
		case "A":
			
			if(gcds_data1.namevalue(gcds_data1.rowpositin,"REMARK")=="Y"){
				return false;
			}
			
			//gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s3"+ "?v_str1="+parm1+"&v_str2="+parm2;
			//gcds_data4.Reset();
	
			//if(gcds_data4.countrow>0) {
			//	return true;
			//}
			
			break;
		case "B" :
			
			if(gcds_data2.namevalue(gcds_data2.rowpositin,"REMARK")=="Y"){
				return false;
			}
			
			//gcds_data5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s4"+ "?v_str1="+parm1+"&v_str2="+parm2;
			//gcds_data5.Reset();
	
			//if(gcds_data5.countrow>0) {
			//	return true;
			//}
			break;
		case "C" :
			gcds_data6.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s5"+ "?v_str1="+parm1+"&v_str2="+parm2;
			gcds_data6.Reset();
	
			if(gcds_data6.countrow>0 && gcds_data6.namevalue(gcds_data6.rowposition,"CNT")>0) {
				return false;
			}
			break;
	}

	return true;
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(e){
	
}

/******************************************************************************
	Description : Header 설정
******************************************************************************/
function ln_SetDataHeader(){
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(e){
	if(e=="01") {
		if(gcds_data1.countrow>0){
			gcds_data1.UndoAll();
		}else alert("취소할 정보가 없습니다.");
	} else if(e=="02") {
		if(gcds_data2.countrow>0){
			if(gclx_statcd.bindcolval=="Y"){
				var str1  = gclx_sfdcode2.BindColVal;			    //지점코드         
				var str2  = fn_trim(gcem_acdate2.text);             //실사일자
				var str3 = "N";
				
				if(ln_magam(str1,str2,"C")) {
					if (confirm("마감처리를 취소하시겠습니까?")) {	
						gctr_data1.KeyValue = "Account.a070007_t2(I:USER=gcds_data1)";
						gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_t2";
						gctr_data1.Parameters = "v_str1="+str1+",v_str2="+str2+",v_str3="+str3;
						gctr_data1.post();
						ln_Query('02');
					} 
				}else alert("해당일보다 큰 날짜에 마감자료가 존재합니다");
			}else alert("취소 할 수 없습니다.");
		}else alert("취소할 정보가 없습니다.");
	}
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){
		
	var str1  = gclx_sfdcode2.BindColVal;			   //지점코드         
	var str2  = fn_trim(gcem_acdate2.text);            //실사일자
	
	gcds_print.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s7"+ "?v_str1="+str1+"&v_str2="+str2;	
	gcds_print.Reset();
	
	gcds_print2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s8"+ "?v_str1="+str1+"&v_str2="+str2;	
	gcds_print2.Reset();

	if(gcds_print.countrow<1) {
		alert("출력할 정보가 없습니다.");
	}else{
		
		gcds_print2.namevalue(gcds_print2.rowposition,"ACDATE") = str2;
	   
	    for(var i =1; i<=gcds_print.countrow; i++){
	    	if(gcds_print.namevalue(i,"UNIT")=="1"){
	    		gcds_print.namevalue(i,"UNIT")="WON";
	    		gcds_print.namevalue(i,"CDNAM")="";
	    		gcds_print.namevalue(i,"QUANTY")="";
	    	}else if(gcds_print.namevalue(i,"UNIT")=="2"){
	    		gcds_print.namevalue(i,"UNIT")="CNY";
	    	}else if(gcds_print.namevalue(i,"UNIT")=="3"){
	    		gcds_print.namevalue(i,"UNIT")="EUR";
	    	}else if(gcds_print.namevalue(i,"UNIT")=="4"){
	    		gcds_print.namevalue(i,"UNIT")="USD";
	    	}else if(gcds_print.namevalue(i,"UNIT")=="5"){
	    		gcds_print.namevalue(i,"UNIT")="JPY";
	    	}else{
	    		gcds_print.namevalue(i,"UNIT")=""
	    	}
	    }
		
		gcrp_print.preview();
		
	}
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){

	gcem_acdate1.text = gs_date;
	gcem_acdate2.text = gs_date;

	//gclx_statcd.index = 0;

	gcds_sfdcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode1.Reset();

	gcds_sfdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode2.Reset();
}


/******************************************************************************
	Description : 탭구분
	prameter    : 0-실사표입력, 1-실사표마감
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
Description : 데이터 복사 
prameter    : 0-실사표입력, 1-실사표마감
******************************************************************************/

function ln_Copy(){
	
	if (!ln_Copy_Chk()) return false;
	if (confirm("복사 하시겠습니까?")) {	
		ln_SetDataHeader();
		gcds_temp_date.addrow();
		gcds_temp_date.namevalue(gcds_temp_date.rowposition,"ACDATE") = gcem_acdate1.text;
		gcds_temp_date.namevalue(gcds_temp_date.rowposition,"CPDATE") = gcem_cpdate.text;
		gcds_temp_date.namevalue(gcds_temp_date.rowposition,"UPID")   = gs_userid;
		
		gctr_data2.KeyValue = "Account.a070007_t3(I:USER=gcds_temp_date)";
		gctr_data2.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_t3";
	
		//prompt("gcds_temp_date",gcds_temp_date.text);
		gctr_data2.post();
	}
}


/******************************************************************************
Description : 데이터 복사시 체크 
prameter    : 0-실사표입력, 1-실사표마감
******************************************************************************/
function ln_Copy_Chk(){
	
	if(gcem_acdate1.text==""){
		alert("실사일자를 입력하십시요");
		return false;
	}
	
	if(gcem_cpdate.text==""){
		alert("복사일자를 입력하십시요");
		return false;
	}
	
	if(gcem_acdate1.text >=gcem_cpdate.text ){
		alert("복사일자는 실사일자보다 크야합니다.");
		return false;
	}
	
	//체크 테이블은  ACASHSUR 
	var str1  = gclx_sfdcode1.BindColVal;			   //지점코드         
	var str2  = fn_trim(gcem_acdate1.text);	           //실사일자
	var str3  = fn_trim(gcem_cpdate.text);	           //복사일자
	
	gcds_chk.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070007_s9?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3;
	gcds_chk.Reset();
	
	if(gcds_chk.CountRow>0){
	
		//복사 Source 데이터가 없는 경우는 return false  
		if(gcds_chk.namevalue(gcds_chk.rowposition,"CNT1")<=0){
			alert("원본 데이터가 존재하지 않습니다. 복사 불가입니다.");
			return false;
		}
		
		//복사 목적지 데이터가 존재하는데 마감  return false
		if(gcds_chk.namevalue(gcds_chk.rowposition,"CNT2")>0 && gcds_chk.namevalue(gcds_chk.rowposition,"CLOSEYN2")=="Y" ){
			alert("복사할 일자의 데이터가 존재하고 마감 적용되었습니다. 복사 불가입니다.");
			return false;
		}
		
		//복사 목적지 데이터가 존재하는데 마감 아님  메세지만 띄워고,개인이 확인
		if(gcds_chk.namevalue(gcds_chk.rowposition,"CNT2")>0 && gcds_chk.namevalue(gcds_chk.rowposition,"CLOSEYN2")!="Y" ){
			if (confirm("마감되지 않는 복사본 데이터가 존재합니다. 복사본을 삭제 후 다시 생성하시겠습니까?")){
				
			}else{
				return false;	
			}
		}
	}else{
		alert("복사오류");
		return false;
	}
	
	
	return true;	
}

/******************************************************************************
Description : 데이터 복사시 데이터 셋  
prameter    : 
******************************************************************************/
function ln_SetDataHeader(){
	
	gcds_temp_date.clearAll();
	if (gcds_temp_date.countrow<1){
		var s_temp = "ACDATE:STRING,CPDATE:STRING,UPID:STRING";
			gcds_temp_date.SetDataHeader(s_temp);
	}
}


/******************************************************************************
Description : 데이터 복사시 데이터 셋  
prameter    : 
******************************************************************************/
function ln_SetDataHeader2(){
	
	gcds_data3.clearAll();
	if (gcds_data3.countrow<1){
		var s_temp = "GUBUN:STRING,AD01:DECIMAL,AD02:DECIMAL,AD03:DECIMAL,AD04:DECIMAL";
		gcds_data3.SetDataHeader(s_temp);
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"		VALUE="false">
	<PARAM NAME="SubsumExpr"	VALUE="1:GRP">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SubsumExpr"	VALUE="1:GRP">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_data4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_data5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_data6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_sfdcode1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 


<comment id="__NSID__"><object  id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__"><object  id=gcds_temp_date classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<OBJECT id=gctr_data1 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</OBJECT>

<OBJECT id=gctr_data2 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</OBJECT>

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
	gcgd_disp01.ColumnProp('CDREMARK', 'Edit') = "None";
	gcgd_disp01.ColumnProp('CDNAM', 'Edit') = "None";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
 	gcgd_disp01.ColumnProp('ACAMT','Value')='{CDNAM * QUANTY}';
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

<script language="javascript" for="gcds_temp" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	if (row <1) {
		gclx_statcd.bindcolval = "N";
	}else{
		gclx_statcd.bindcolval = gcds_temp.namevalue(row,"CHK");
	}
	
</script>

<script language="javascript" for="gcds_sfdcode1" event="onloadCompleted(row,colid)">
	gcds_sfdcode1.InsertRow(1);
	gcds_sfdcode1.NameValue(1,"FDCODE")="";
	gcds_sfdcode1.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode1.index=2;
	}else{
		gclx_sfdcode1.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_sfdcode2" event="onloadCompleted(row,colid)">
	gcds_sfdcode2.InsertRow(1);
	gcds_sfdcode2.NameValue(1,"FDCODE")="";
	gcds_sfdcode2.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode2.index=2;
	}else{
		gclx_sfdcode2.bindcolval=gs_fdcode;
	}
</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1)); 
</script>


<script language=JavaScript for=gcds_data1 event=CanRowPosChange(row)>

	if(row>0){	
		gcds_data1.namevalue(row,"SUMAMT") = gcds_data1.namevalue(row,"CDNAM")*gcds_data1.namevalue(row,"QUANTY");
	}

</script>

<script language="javascript"  for=gcgd_disp01 event=OnExit(row,colid,olddata)>
    if(colid=="QUANTY"&& row>0){
 		gcds_data1.namevalue(row,"SUMAMT") = gcds_data1.namevalue(row,"CDNAM")*gcds_data1.namevalue(row,"QUANTY");
    }
 </script>
 
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data1" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_data1" event="onfail()">

	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data1.ErrorCode + "\n" + "Error Message : " + gctr_data1.ErrorMsg + "\n");
</script>


<script language="javascript" for="gctr_data2" event="onsuccess()">
	
    gcem_acdate1.text=gcem_cpdate.text;
	alert("복사가 성공적으로 완료되었습니다.");
	ln_Query("01"); 
	
</script>

<script language="javascript" for="gctr_data2" event="onfail()">

	alert("복사가 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
</script>



</head>

<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td><img src="../img/a070007_head.gif">
		</td>
		<td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;
		</td>
	</tr>
	<tr>
		<td colspan=2 align=left style="position:relative;left:5px">
			<table width="0" cellpadding="1" cellspacing="0" border="0" style="position:relative;top:4px;left:-6px;">
				<tr> 
					<td width="0" align=left><nobr>
						<comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;">
							<PARAM NAME="BackColor"					VALUE="#cccccc">
   							<PARAM NAME="titleHeight"				VALUE="20px">
							<PARAM NAME="DisableBackColor"			VALUE="#eeeeee">
							<PARAM NAME="Format"					VALUE="
								<T>divid=div_1		title=실사표입력</T>									
								<T>divid=div_2		title=실사표마감</T>							 
								">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr> 
		<td COLSPAN=2>
		
<!-- 실사표입력 ===========================================================================================================-->
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
								<td class="tab23" style="width:110px">
									<comment id="__NSID__"><object  id=gclx_sfdcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
										<param name=ComboDataID			value="gcds_sfdcode1">
										<param name=CBDataColumns		value="FDCODE,FDNAME">
										<param name=SearchColumn		value="FDNAME">
										<param name=Sort				value="false">
										<param name=ListExprFormat		value="FDNAME^0^80">
										<param name=BindColumn			value="FDCODE">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>실사일자</nobr>
								</td>
								<td class="tab23" style="width:130px">
									<comment id="__NSID__"><object id=gcem_acdate1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
										<param name=Alignment				value=0>
										<param name=Border					value=true>
										<param name=Format					value="YYYY/MM/DD">
										<param name=PromptChar				value="_">
										<param name=Enable					value="true">
									</object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_acdate1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
								</td>
								
								<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>복사일자</nobr>	</td>
								<td style="width:220px">
									<comment id="__NSID__"><object id=gcem_cpdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
										<param name=Alignment				value=0>
										<param name=Border					value=true>
										<param name=Format					value="YYYY/MM/DD">
										<param name=PromptChar				value="_">
										<param name=Enable					value="true">
									</object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_cpdate', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
								    &nbsp;
								    <img src="../../Common/img/btn/copy.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Copy()">
								</td>
								

								<td align="right">&nbsp;<nobr>
								      
									<img src="../../Common/img/btn/com_b_cancle.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Cancel('01')">	
									<img src="../../Common/img/btn/com_b_insert.gif"  style="cursor:hand;position:relative;top:2px;right:2px" onclick="ln_Add('01')" >
									<input type="image" id=save_sys    src="../../Common/img/btn/com_b_save.gif" style="cursor:hand;position:relative;top:2px;right:2px" onclick="ln_Save('01')">
									<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('01')"></nobr>
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
										<PARAM NAME="DataID"			VALUE="gcds_data1">
										<PARAM NAME="Editable"			VALUE="True">
										<PARAM NAME="BorderStyle"		VALUE="0">
										<PARAM NAME="IndWidth"			VALUE="0">
										<PARAM NAME="ColSizing"			VALUE="true">
										<param NAME="Fillarea"			VALUE="true">
										<PARAM NAME="Format"			VALUE="
											<C> Name='No1.'			ID={CURROW}		HeadAlign=Center HeadBgColor=#B9D4DC Width=50	align=center	SumText=''			SumBgColor='#C3D0DB'  </C>  
											<C> Name='구분'			ID=CDREMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=center	SubSumText='계'		SumBgColor='#C3D0DB'  suppress=1</C>
											<C> Name='코드'			ID=CDCODE		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left		SumText=''			SumBgColor='#C3D0DB'  Show=false </C>
											<C> Name='그룹'			ID=GRP			HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left		SumText=''			SumBgColor='#C3D0DB'  Show=false </C>
											<C> Name='액면가'		    ID=CDNAM		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=right		SubSumText=''		SumBgColor='#C3D0DB'  </C>
											<C> Name='수량'			ID=QUANTY		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=right		SubSumText=''		SumBgColor='#C3D0DB'  </C>
											<C> Name='금액'			ID=SUMAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=right		SumText=@sum		SumBgColor='#C3D0DB'  edit=none  </C>
											<C> Name='금액'			ID=ACAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=140	align=right		SumText=@sum		SumBgColor='#C3D0DB'  show=false </C>
											<C> Name='마감'			ID=REMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=center	SumText=''			SumBgColor='#C3D0DB'  edit=none </C>
											<C> Name='마감'			ID=ACDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=center	SumText=''			SumBgColor='#C3D0DB'  edit=none </C>
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

<!-- 실사표마감 ===========================================================================================================-->
			<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="display:none">	
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
										<param name=Sort				value="false">
										<param name=ListExprFormat		value="FDNAME^0^80">
										<param name=BindColumn			value="FDCODE">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>실사일자</nobr>
								</td>
								<td class="tab23" style="width:100px">
									<comment id="__NSID__"><object id=gcem_acdate2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
										<param name=Alignment			value=0>
										<param name=Border				value=true>
										<param name=Format				value="YYYY/MM/DD">
										<param name=PromptChar			value="_">
										<param name=Enable				value="true">
									</object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_acdate2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
								</td>
								<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>마감여부</nobr></td>
								<td width="100px"><comment id="__NSID__">
									<object  id=gclx_statcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:110px;height:110px;">
										<param name=CBData				value="^,Y^YES,N^NO">
										<param name=CBDataColumns		value="CDCODE,CDNAM">
										<param name=SearchColumn		value="CDNAM">
										<param name=Sort				value="false">
										<param name=ListExprFormat	    value="CDNAM^0^110">
										<param name=BindColumn			value="CDCODE">
										<param name=Enable				value="false">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td align="right">&nbsp;<nobr>      
									<img src="../../Common/img/btn/com_b_cancle.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Cancel('02')">
									<img name="btn_finish"  src="../../Common/img/btn/com_b_finish.gif"		style="position:relative;top:2px;cursor:hand" onclick="ln_Save('02')"> 
									<img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print()">
									<IMG src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('02')"></nobr>
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
									<OBJECT id=gcgd_disp02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:250px;border:1 solid #777777;display:block;position:relative;left:-1px" viewastext>
										<PARAM NAME="DataID"			VALUE="gcds_data2">
										<PARAM NAME="Editable"			VALUE="false">
										<PARAM NAME="BorderStyle"		VALUE="0">
										<PARAM NAME="IndWidth"			VALUE="0">
										<PARAM NAME="ColSizing"			VALUE="true">
										<param NAME="Fillarea"			VALUE="true">
										<PARAM NAME="Format"			VALUE="
											<C> Name='No.'			ID={CURROW}		HeadAlign=Center HeadBgColor=#B9D4DC Width=50	align=center  SumText=''	    SumBgColor='#C3D0DB'</C>
											<C> Name='구분'			ID=CDREMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=center  SubSumText='계'	SumBgColor='#C3D0DB'  suppress=1</C>
											<C> Name='코드'			ID=CDCODE		HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=left	  SumText=''		SumBgColor='#C3D0DB'	Show='false'</C>
											<C> Name='그룹'			ID=GRP			HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=left	  SumText=''		SumBgColor='#C3D0DB'	Show='false'</C>
											<C> Name='액면가'		    ID=CDNAM		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=right	  SubSumText=''	    SumBgColor='#C3D0DB'</C>
											<C> Name='수량'			ID=QUANTY		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=right	  SubSumText=''	    SumBgColor='#C3D0DB'</C>
											<C> Name='금액'			ID=ACAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=right	  SumText=@sum	    SumBgColor='#C3D0DB'</C>
											<C> Name='마감'			ID=REMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=center  SumText=''		SumBgColor='#C3D0DB'</C>
											">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
									<fieldset style="position:relative;left:-1px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
									&nbsp;<font id="ft_cnt02" style="position:relative;top:4px;"></font>
									</fieldset>
								</td>
							</tr>
							<tr>
								<td colspan=8 align=left style="position:relative;left:-1px">
									<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:0 solid #708090'>
										<comment id="__NSID__"><OBJECT id=gcgd_disp03 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:120px;border:1 solid #777777;display:block;position:relative;left:-1px" viewastext>
											<PARAM NAME="DataID"			VALUE="gcds_data3">
											<PARAM NAME="Editable"			VALUE="false">
											<PARAM NAME="BorderStyle"		VALUE="0">
											<PARAM NAME="IndWidth"			VALUE="0">
											<PARAM NAME="ColSizing"			VALUE="true">
											<param NAME="Fillarea"			VALUE="true">
											<PARAM NAME="Format"			VALUE="
												<C> Name='No.'		ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=50	align=center	SumText=''		SumBgColor='#C3D0DB'</C>
												<C> Name='구분'		ID=GUBUN	HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=center	SumText='계'	    SumBgColor='#C3D0DB'</C>
												<C> Name='전일이월'	ID=AD01		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
												<C> Name='당일증가'	ID=AD02		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
												<C> Name='당일감소'	ID=AD03		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
												<C> Name='잔액'		ID=AD04		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
												<C> Name='비고'		ID=BIGO		HeadAlign=Center HeadBgColor=#B9D4DC Width=50	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
												">
										</OBJECT></comment><script>__ws__(__NSID__);</script>	
									</table>
								</td>
							</tr>
							
							<tr>
								<td><font size="2" color="blue">[마감일자조정]</font>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<img src="../../Common/img/btn/com_btn_add.gif"		style="cursor:hand;position:relative;top:-5px;right:2px" onClick="ln_Add('03')">
								<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:-5px;right:2px" onClick="ln_Save('03')">
								</td>
							</tr>
							
							<tr>
								<td colspan=8 align=left style="position:relative;left:-1px">
									<table cellpadding="1" cellspacing="0" border="0" style='width:350px;height:30px;border:0 solid #708090'>
										<comment id="__NSID__"><OBJECT id=gcgd_disp04 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:350px;HEIGHT:120px;border:1 solid #777777;display:block;position:relative;left:-1px" viewastext>
											<PARAM NAME="DataID"			VALUE="gcds_data4">
											<PARAM NAME="Editable"			VALUE="true">
											<PARAM NAME="BorderStyle"		VALUE="0">
											<PARAM NAME="IndWidth"			VALUE="0">
											<PARAM NAME="ColSizing"			VALUE="true">
											<param NAME="Fillarea"			VALUE="true">
											<PARAM NAME="Format"			VALUE="
									            <C> Name='No.'		    ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=50	align=center	</C>  
												<C> Name='실사일자'	    ID=ACDATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=center  MASK ='XXXX/XX/XX'	</C>
												<C> Name='조정일자FR'		ID=AJDTFR	HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=center  MASK ='XXXX/XX/XX'	bgcolor=#FFFFBF</C>
												<C> Name='조정일자TO'		ID=AJDTTO	HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=center  MASK ='XXXX/XX/XX'	bgcolor=#FFFFBF</C>
												">
										</OBJECT></comment><script>__ws__(__NSID__);</script>	
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

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>

<comment id="__NSID__"><object id="gcrp_print" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param name="MasterDataID"			    value="gcds_print2">
	<param name="DetailDataID"			    value="gcds_print">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"				    VALUE="false">
    <PARAM NAME="PrintSetupDlgFlag"         VALUE="true">
	<PARAM NAME="PreviewZoom"			    VALUE="100">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="FixPaperSize"		        VALUE="true">
	<PARAM NAME="PrintMargine"				VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<param name="SuppressColumns"	        value="1:CDREMARK"> 
	<PARAM NAME="Format"                    VALUE="
<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=415 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=1225 ,top=138 ,right=1924 ,bottom=415 ,border=true ,penstyle=solid ,penwidth=2</X>
	<L> left=1458 ,top=138 ,right=1458 ,bottom=415 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='담  당' ,left=1230 ,top=140 ,right=1455 ,bottom=193 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='검  토' ,left=1463 ,top=140 ,right=1688 ,bottom=193 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확  인' ,left=1696 ,top=140 ,right=1921 ,bottom=193 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1693 ,top=138 ,right=1693 ,bottom=415 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1334 ,top=352 ,right=1310 ,bottom=407 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1810 ,top=352 ,right=1786 ,bottom=407 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1574 ,top=349 ,right=1550 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1225 ,top=344 ,right=1924 ,bottom=344 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1225 ,top=196 ,right=1924 ,bottom=196 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='현금시재현황' ,left=132 ,top=153 ,right=1109 ,bottom=262 ,face='굴림' ,size=30 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ACDATE', left=135, top=275, right=1101, bottom=341 ,mask='( XXXX年 XX月 XX日 )', face='Tahoma', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='사원' ,left=1238 ,top=355 ,right=1312 ,bottom=407 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='곽진희' ,left=1341 ,top=355 ,right=1447 ,bottom=407 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차장' ,left=1474 ,top=355 ,right=1548 ,bottom=407 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='봉균일' ,left=1577 ,top=355 ,right=1683 ,bottom=407 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차장' ,left=1707 ,top=355 ,right=1781 ,bottom=407 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='정상원' ,left=1810 ,top=355 ,right=1916 ,bottom=407 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=1225 ,top=71 ,right=1924 ,bottom=138 ,border=true ,penstyle=solid ,penwidth=2</X>
	<T>id='     년     월     일   (  기안 : 곽진희  )' ,left=1254 ,top=79 ,right=1921 ,bottom=132 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=142 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1580 ,top=90 ,right=1580 ,bottom=143 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1931 ,top=90 ,right=1931 ,bottom=143 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1164 ,top=90 ,right=1164 ,bottom=143 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=786 ,top=90 ,right=786 ,bottom=143 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=413 ,top=90 ,right=413 ,bottom=143 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=45 ,top=90 ,right=45 ,bottom=143 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='구분' ,left=53 ,top=103 ,right=400 ,bottom=140 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='액면가' ,left=426 ,top=103 ,right=773 ,bottom=140 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='수량' ,left=802 ,top=103 ,right=1148 ,bottom=140 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='금액' ,left=1175 ,top=103 ,right=1572 ,bottom=140 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='비고' ,left=1598 ,top=103 ,right=1921 ,bottom=140 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=45 ,top=90 ,right=1931 ,bottom=90 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='CDREMARK', left=53, top=5, right=400, bottom=42, supplevel=1, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CDNAM,0,,CDNAM)}', left=426, top=5, right=773, bottom=42, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(QUANTY,0,,QUANTY)}', left=802, top=5, right=1148, bottom=42, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=45 ,top=0 ,right=45 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=413 ,top=0 ,right=413 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=786 ,top=0 ,right=786 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1164 ,top=0 ,right=1164 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1931 ,top=0 ,right=1931 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='UNIT', left=1175, top=5, right=1259, bottom=42, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACAMT', left=1257, top=5, right=1572, bottom=42, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=48 ,top=0 ,right=407 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=1 </L>
	<L> left=1580 ,top=0 ,right=1580 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=407 ,top=0 ,right=1931 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=1 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=473 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=42 ,top=0 ,right=1929 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=42 ,top=111 ,right=1929 ,bottom=111 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=42 ,top=455 ,right=1929 ,bottom=455 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1931 ,top=111 ,right=1931 ,bottom=455 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1582 ,top=111 ,right=1582 ,bottom=455 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1167 ,top=111 ,right=1167 ,bottom=455 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=786 ,top=108 ,right=786 ,bottom=452 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=413 ,top=108 ,right=413 ,bottom=452 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=42 ,top=111 ,right=42 ,bottom=455 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='잔액' ,left=1598 ,top=119 ,right=1921 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='당일감소' ,left=1175 ,top=119 ,right=1572 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='당일증가' ,left=802 ,top=119 ,right=1148 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='전일이월' ,left=426 ,top=119 ,right=773 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='구분' ,left=53 ,top=119 ,right=400 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=42 ,top=164 ,right=1929 ,bottom=164 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='A04', left=1598, top=175, right=1921, bottom=212, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A03', left=1175, top=175, right=1572, bottom=212, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A02', left=802, top=175, right=1148, bottom=212, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A01', left=426, top=175, right=773, bottom=212, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='원화(WON)' ,left=53 ,top=175 ,right=400 ,bottom=212 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=42 ,top=220 ,right=1929 ,bottom=220 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=42 ,top=278 ,right=1929 ,bottom=278 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=45 ,top=336 ,right=1931 ,bottom=336 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=45 ,top=397 ,right=1931 ,bottom=397 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='외화(CNY)' ,left=53 ,top=230 ,right=400 ,bottom=267 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='외화(EUR)' ,left=53 ,top=288 ,right=400 ,bottom=325 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='외화(USD)' ,left=53 ,top=347 ,right=400 ,bottom=384 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='외화(JPY)' ,left=53 ,top=407 ,right=400 ,bottom=445 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<C>id='B01', left=426, top=230, right=773, bottom=267, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='C01', left=426, top=288, right=773, bottom=325, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='D01', left=426, top=347, right=773, bottom=384, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='E01', left=426, top=407, right=773, bottom=445, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='B02', left=802, top=230, right=1148, bottom=267, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='C02', left=802, top=286, right=1148, bottom=323, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='D02', left=802, top=344, right=1148, bottom=381, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='E02', left=802, top=405, right=1148, bottom=442, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='B03', left=1175, top=230, right=1572, bottom=267, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='C03', left=1175, top=288, right=1572, bottom=325, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='D03', left=1175, top=347, right=1572, bottom=384, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='E03', left=1175, top=407, right=1572, bottom=445, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='B04', left=1598, top=230, right=1921, bottom=267, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='C04', left=1598, top=288, right=1921, bottom=325, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='D04', left=1598, top=347, right=1921, bottom=384, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='E04', left=1598, top=407, right=1921, bottom=445, align='right' ,mask='#,###', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=2788 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=1550 ,top=0 ,right=1929 ,bottom=82</I>
</B>




">
</object></comment><script>__ws__(__NSID__);</script> 



</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 