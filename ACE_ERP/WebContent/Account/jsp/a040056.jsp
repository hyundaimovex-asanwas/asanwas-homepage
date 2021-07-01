
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	세금계산서관리/부가세매입매출장
+ 프로그램 ID	: A040002
+ 기 능 정 의	: 조회|등록|출력|전표발행|전표조회
+ 최 초 이 력	: 이순미
+ 서 블 릿 명	: a040002_s1_e,a040002_s2
------------------------------------------------------------------------------
+ 수 정 내 용  :	팝업창 수정 및 개선사항 수정   
+ 수   정  자  :  이민정
+ 수 정 일 자  :  2006.10
-----------------------------------------------------------------------------
+ 수 정 내 용 :	부가세관리 지점 사용  (  A040002 ==> A040099로 임시 사용함)           
+ 수   정  자 : 정  영  식
+ 수 정 일 자 : 2008.06.11
+ 서 블 릿 명	:
-----------------------------------------------------------------------------
+ 수 정 내 용 :	수정코드 및 전자발행 구분 코드 추가    
+ 수   정  자 : 정  영  식
+ 수 정 일 자 : 2008.06.11
+ 서 블 릿 명	:
-----------------------------------------------------------------------------
+ 수 정 내 용 :	전자세금계산서 발행 구분 eBill구분    
+ 수   정  자 : 정  영  식
+ 수 정 일 자 : 2017.01.25
+ 서 블 릿 명	:
-----------------------------------------------------------------------------
+ 수 정 일 자     :  2017.04.14 
+ 수 정 내 용     :  그리드에 입금예정일 추가 
+ 서 블 릿 명	:
-----------------------------------------------------------------------------
+ 수 정 일 자     :  2017.06.22 
+ 수 정 내 용     : 결재상태 추가  
+ 서 블 릿 명	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>부가세매입매출장</title>

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
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_deptcd = gdeptcd; //부서코드
var gs_deptnm = gdeptnm; //부서명
var gs_chk = gs_deptcd;
var g_usrnm = gusrnm;
var gs_empno = "";
var g_login	

var gs_empnos="";
var gs_deptcds="";

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	gcte_disp.ActiveIndex=2;
	ln_DispChk(1);
	ln_Before();	//선조회

	if(gs_chk==null) gs_chk = "";

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(e){
		
	ln_QueryChk();

	if (e=="A") {	//계산서별
		var str1 = gclx_staxiodiv.BindColVal;	//매입매출구분
		var str2 = gclx_cocode.BindColVal;		//사업소
		var str3 = gcem_staxdatfr.text;			//계산서기간 from
		var str4 = gcem_staxdatto.text;			//계산서기간 to
		var str5 = gcem_vendcd.text;			//거래처코드
		var str6 = "";		                    //귀속구분
		var str7 = "";		                    //부가세종류
		var str8 = gclx_taxprtyn.BindColVal;	//발행여부
		var str9 = gclx_fsstat.BindColVal;		//전표상태
		var str10 = gcem_vendnm.text;			//거래처명
		var str11 = gclx_fdcode.BindColVal;		//지점코드
		var str12 = gs_userid;	                //로그인
		var str13 = "";	                        //구분값
		var str17 =gclx_amend_code.BindColVal;	
		var str21 = gclx_ebillgb.BindColVal;
		var str22 = gclx_taxsts.BindColVal;


		if (str1 =="1") {
			str1 = "A";
			str6 = gclx_staxdiv.BindColVal;
			str7 = gclx_staxknd.BindColVal;
		}else if (str1 =="2") {
			str1 = "B";
			str6 = gclx_staxdiv_2.BindColVal;
			str7 = gclx_staxknd_2.BindColVal;
		}

   
       if(hid_login.value=="M"){ //부가세 관리자
			str13 = "1";	
		}else{
           str13 = "2";            //일반사용자	
		}
    
		
       gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s1_ee?v_str1="+str1
		                                                                        +"&v_str2="+str2
																				+"&v_str3="+str3+"&v_str4="+str4
																				+"&v_str5="+str5+"&v_str6="+str6
																				+"&v_str7="+str7+"&v_str8="+str8
																				+"&v_str9="+str9+"&v_str10="+str10
																				+"&v_str11="+str11+"&v_str12="+gs_chk
		                                										+"&v_str13="+str12+"&v_str14="+str13
																				+"&v_str15="+gs_empnos+"&v_str16="+gs_deptcds
																				+"&v_str17="+str17+"&v_str21="+str21
       																			+"&v_str22="+str22;
		gcds_data1.Reset();
		var row  = gcds_data1.rowposition;
		var temp = gcds_temp.rowposition;

	}else if(e=="B") {	//전표별
		var str1 = gclx_staxiodiv2.BindColVal;	    //매입매출구분
		var str2 = gclx_cocode2.BindColVal;			//사업소
		var str3 = gcem_staxdatfr2.text;			//계산서기간 from
		var str4 = gcem_staxdatto2.text;			//계산서기간 to
		var str5 = gcem_vendcd2.text;				//거래처코드
		var str6 = "";		                        //귀속구분
		var str7 = "";		                        //부가세종류
		var str8 = gclx_taxprtyn2.BindColVal;		//발행여부
		var str9 = gclx_fsstat2.BindColVal;			//전표상태
		var str10 = gcem_vendnm2.text;				//거래처명
		var str11 = gclx_fdcode2.BindColVal;		//지점코드
		var str12 = gs_userid;	                    //로그인
		var str17 = gclx_amend_code2.BindColVal;	
		var str21 = gclx_ebillgb2.BindColVal;
		var str22 = gclx_taxsts2.BindColVal;
		
		if (str1 =="1") {       //매입
			str1 = "A";
			str6 = gclx_staxdiv2.BindColVal;
			str7 = gclx_staxknd2.BindColVal;
		}else if (str1 =="2") { //매출
			str1 = "B";
			str6 = gclx_staxdiv_3.BindColVal;
			str7 = gclx_staxknd2_2.BindColVal;		
  	    }
  
		if(hid_login.value=="M"){ //부가세 관리자
			str13 = "1";	
		}else{
           str13 = "2";            //일반사용자	
		}
    
       gcds_data1_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s1_ee"
											+"?v_str1="+str1+"&v_str2="+str2
											+"&v_str3="+str3+"&v_str4="+str4
											+"&v_str5="+str5+"&v_str6="+str6
											+"&v_str7="+str7+"&v_str8="+str8
											+"&v_str9="+str9+"&v_str10="+str10
											+"&v_str11="+str11+"&v_str12="+gs_chk
											+"&v_str13="+str12+"&v_str14="+str13
											+"&v_str15="+gs_empnos+"&v_str16="+gs_deptcds
											+"&v_str17="+str17+"&v_str21="+str21
      										+"&v_str22="+str22;
		gcds_data1_2.Reset();
	}
}

/******************************************************************************
	Description : 예산부서 CHK
******************************************************************************/
function ln_QueryChk(){
	for(var i=1;i<=gcds_temp1.countrow;i++){
		if(gs_deptcd==gcds_temp1.namevalue(i,"DEPTCD")){
			gs_chk="";
		}
	}
}


/******************************************************************************
	Description : 조회 - 매입(매출장) 출력
******************************************************************************/
function ln_Query2(e){
	if (e=="A") {
		var str1 = gclx_staxiodiv.BindColVal;	//매입매출구분
		var str2 = gclx_cocode.BindColVal;			//사업소
		var str3 = gcem_staxdatfr.text;				//계산서기간 from
		var str4 = gcem_staxdatto.text;				//계산서기간 to
		var str5 = gcem_vendcd.text;					//거래처코드
		var str6 = gclx_staxdiv.BindColVal;		//귀속구분
		var str7 = gclx_staxknd.BindColVal;		//부가세종류
		var str17 =gclx_amend_code.BindColVal;	

		if (str1 =="1") str1 = "A";       //매입
		else if (str1 =="2") str1 = "B";  //매출

    /*&&
		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s1_e"
											+ "?v_str1="+str1+"&v_str2="+str2
											+ "&v_str3="+str3+"&v_str4="+str4
											+ "&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7+"&v_str12="+gs_deptcd
											+"&v_str15="+gs_empnos+"&v_str16="+gs_deptcds;
    */
    gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s1_ee"
											+ "?v_str1="+str1+"&v_str2="+str2
											+ "&v_str3="+str3+"&v_str4="+str4
											+ "&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7+"&v_str12="+gs_deptcd
											+"&v_str15="+gs_empnos+"&v_str16="+gs_deptcds
											+"&v_str17="+str17;
		gcds_data2.Reset(); 
	}else if (e=="B") {
		var str1 = gclx_staxiodiv2.BindColVal;	//매입매출구분
		var str2 = gclx_cocode2.BindColVal;			//사업소
		var str3 = gcem_staxdatfr2.text;				//계산서기간 from
		var str4 = gcem_staxdatto2.text;				//계산서기간 to
		var str5 = gcem_vendcd2.text;						//거래처코드
		var str6 = gclx_staxdiv2.BindColVal;		//귀속구분
		var str7 = gclx_staxknd2.BindColVal;		//부가세종류
		var str17 =gclx_amend_code2.BindColVal;	

		if (str1 =="1") str1 = "A";
		else if (str1 =="2") str1 = "B";

    /*&&
		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s1_e"
											+ "?v_str1="+str1+"&v_str2="+str2
											+ "&v_str3="+str3+"&v_str4="+str4
											+ "&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7+"&v_str12="+gs_deptcd
											+"&v_str15="+gs_empnos+"&v_str16="+gs_deptcds;
     */

    gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s1_ee"
											+ "?v_str1="+str1+"&v_str2="+str2
											+ "&v_str3="+str3+"&v_str4="+str4
											+ "&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7+"&v_str12="+gs_deptcd
											+"&v_str15="+gs_empnos+"&v_str16="+gs_deptcds
											+"&v_str17="+str17;
		gcds_data2.Reset();
	}
	
}

/******************************************************************************
	Description : 조회 - 세금계산서 Detail[전표발행]
******************************************************************************/
function ln_Query3(e,p){
	if(e=="A") {
		gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s2?v_str1="+p;
		gcds_data3.Reset(); 
	}else if(e=="B") {
		gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s2?v_str1="+p;
		gcds_data3.Reset(); 
	}
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save() {
  var chkgb=0;
	for (var i=1;i<=gcds_data1_2.countrow;i++){
		if(gcds_data1_2.namevalue(i,"CHK")=="T"){
			chkgb+=1;
		}
	}
	if(chkgb==0){
	  alert("선택 후 저장하십시요.");
		return false;
	}


  gcds_gb_data.clearall();
  ln_SetDataHeader2()
	for(var w=1;w<=gcds_data1_2.countrow;w++){
		if(gcds_data1_2.namevalue(w,"CHK")=="T"){	
			gcds_gb_data.addrow();     
            gcds_gb_data.namevalue(gcds_gb_data.rowposition,"CHK")=gcds_data1_2.namevalue(w,"CHK");
			gcds_gb_data.namevalue(gcds_gb_data.rowposition,"TAXNBR")=gcds_data1_2.namevalue(w,"TAXNBR");
			gcds_gb_data.namevalue(gcds_gb_data.rowposition,"GUBUN")=gcds_data1_2.namevalue(w,"GUBUN");
		}
	}
	gctr_data1.KeyValue   = "Account.a040002_t4(I:USER=gcds_gb_data)";
	gctr_data1.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_t4";
	gctr_data1.post();
}

/******************************************************************************
	Description : 삭제
	2008.06.12  : 정영식 수정 건별로 삭제한다. 
	2009.07.10  : 
******************************************************************************/
function ln_Delete(e){
  var strFdcode ="";
	var strFsdat ="";
	var strFsnbr="";
	var str_taxnbr ="";

	if(e=="A"){
		if(gcds_data1.countrow>0){
			for(var w=1;w<=gcds_data1.countrow;w++) {
        strFdcode =fn_trim(gcds_data1.namevalue(w,"FDCODE"));
			  strFsdat = fn_trim(gcds_data1.namevalue(w,"FSDAT"));
			  strFsnbr=fn_trim(gcds_data1.namevalue(w,"FSNBR"));
				str_taxnbr = gcds_data1.namevalue(w,"TAXNBR");
				///alert("strFdcode::::"+strFdcode+"strFsdat::::"+strFsdat+"strFsnbr::::"+strFsnbr);
				if (gcds_data1.namevalue(w,"CHK") == "T" && strFsnbr == "") {	
					
					//if(gs_userid=="6070001"){ 
					//	alert("DTI_STATUS::::"+gcds_data1.namevalue(w,"DTI_STATUS"));
					//}

          //2009.07.10 상태체크 //수신거부, 수신완료, 공백일 경우만 삭제가능
					if(gcds_data1.namevalue(w,"DTI_STATUS")!="R"&&gcds_data1.namevalue(w,"DTI_STATUS")!="O"&&gcds_data1.namevalue(w,"DTI_STATUS")!=""&&gcds_data1.namevalue(w,"DTI_STATUS")!="W"){
						alert("상태가 삭제 불가능한 건입니다.");
						return;
					}

					if(confirm("삭제 하시겠습니까?")){	
						gcds_data1.deleterow(w);
						gctr_data1.KeyValue   = "Account.a040002_t1(I:USER=gcds_data1)";
						gctr_data1.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_t1";
						gctr_data1.Parameters = "v_str1="+str_taxnbr;
						gctr_data1.post();
						ln_Query('A');
					}
				}else if(gcds_data1.namevalue(w,"CHK") == "T" && (strFsnbr!= ""&& strFsnbr != undefined)) {
					//2008.06.11 관리자의 경우 결재취소인 건에 대한 세금계산서는 삭제 가능함.			  
					//전표에서 동일 세금계산서 찾아서 전표번호의 세금계산서 삭제함.
          if(hid_login.value=="M"&&gcds_data1.namevalue(w,"FSSTAT")=="N"){ //관리자이고  결재취소건
             
            //접수번호가 없을 경우 삭제 할 수 없음.
						if(strFdcode==""||strFsdat==""||strFsnbr==""){
							alert("접수번호를 확인하십시요.");
						}
            if (confirm("정말로 삭제 하시겠습니까?")){	
							gcds_data1.deleterow(w);
							gctr_data1.KeyValue   = "Account.a040002_t2(I:USER=gcds_data1)";
							gctr_data1.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_t2";
							gctr_data1.Parameters = "v_str1="+str_taxnbr+",v_str2="+strFdcode+",v_str3="+strFsdat+",v_str4="+strFsnbr;
							//prompt('',gcds_data1.text);
							
							gctr_data1.post();
							ln_Query('A');
						}
					}else{
						alert("전표발행된 건은 삭제할 수 없습니다.");
						return false;
					}
				}
			}
		}else alert("삭제할 정보가 없습니다.");
	}else if(e=="B"){
		if(gcds_data1_2.countrow>0){
			for(var w=1;w<=gcds_data1_2.countrow;w++) {
			  strFsnbr =fn_trim(gcds_data1_2.namevalue(w,"FSNBR"));
				if (gcds_data1_2.namevalue(w,"CHK") == "T" && strFsnbr == "") {	
					var str_taxnbr = gcds_data1_2.namevalue(w,"TAXNBR");
				
          //if(gs_userid=="6070001"){ 
					//	alert("DTI_STATUS::::"+gcds_data1_2.namevalue(w,"DTI_STATUS"));
					//}

					if(gcds_data1_2.namevalue(w,"DTI_STATUS")!="R"&&gcds_data1_2.namevalue(w,"DTI_STATUS")!="O"&&gcds_data1_2.namevalue(w,"DTI_STATUS")!=""&&gcds_data1_2.namevalue(w,"DTI_STATUS")!="W"){
						alert("상태가 삭제 불가능한 건입니다2.");
						return;
					}

					if (confirm("삭제 하시겠습니까?")){	
						gcds_data1_2.deleterow(w);
						gctr_data1.KeyValue   = "Account.a040002_t1(I:USER=gcds_data1_2)";
						gctr_data1.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_t1";
						gctr_data1.Parameters = "v_str1="+str_taxnbr;
						gctr_data1.post();
						ln_Query('B');
					}
				}else if(gcds_data1_2.namevalue(w,"CHK") == "T" &&(strFsnbr!= ""&& strFsnbr!= undefined)) {
					alert("전표발행된 건은 삭제할 수 없습니다.");
					return false;
				}
			}
		}else alert("삭제할 정보가 없습니다.");
	}
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){
 
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(e){
	if(e=="A") {
		if (gcds_data1.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_data1.GridToExcel("매입매출장(계산서별)","",2);
	}else if(e=="B") {
		if (gcds_data1_2.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_data2.GridToExcel("매입매출장(전표별)","",2);
	}
}

/******************************************************************************
	Description : 출력 - 계산서별
******************************************************************************/
function ln_Print(){
	ln_SetDataHeader();
	if(gcds_data1.countrow<1) {
		alert("출력할 정보가 없습니다.");
	}else{
		for(i=1;i<=gcds_data1.countrow;i++){
			gcds_print.ImportData(gcds_data1.ExportData(i,1,false));
			gcds_print.namevalue(1,"PTITLE")   = "부가세매입매출장 - "+gclx_staxiodiv.text;
			gcds_print.namevalue(1,"DATANM")   = "부가세종류 : "+gclx_staxknd.text+",  귀속구분 : "+gclx_staxdiv.text
			                                   + ",  전표상태 : "+gclx_fsstat.text
			gcds_print.namevalue(1,"FSNBRDT")  = gcds_data1.namevalue(i,"FSDAT")+gcds_data1.namevalue(i,"FSNBR");
			gcds_print.namevalue(1,"FDCODENM") = gclx_fdcode.text;
			gcds_print.namevalue(1,"CURDT")		 = gcem_staxdatfr.text + gcem_staxdatto.text;
			gcds_print.namevalue(1,"CURDT2")	 = gs_date;
		}
		gcrp_print.preview();
	}
}

/******************************************************************************
	Description : 출력 - 전표별
******************************************************************************/
function ln_Print2(){
	ln_SetDataHeader();
	if(gcds_data1_2.countrow<1) {
		alert("출력할 정보가 없습니다.");
	}else{
		for(i=1;i<=gcds_data1_2.countrow;i++){
			gcds_print.ImportData(gcds_data1_2.ExportData(i,1,false));
			gcds_print.namevalue(1,"PTITLE")   = "부가세매입매출장 - "+gclx_staxiodiv2.text;
			gcds_print.namevalue(1,"DATANM")   = "부가세종류 : "+gclx_staxknd2.text+",  귀속구분 : "+gclx_staxdiv2.text
			                                   + ",  전표상태 : "+gclx_fsstat2.text
			gcds_print.namevalue(1,"FSNBRDT")  = gcds_data1_2.namevalue(i,"FSDAT")+gcds_data1_2.namevalue(i,"FSNBR");
			gcds_print.namevalue(1,"FDCODENM") = gclx_fdcode2.text;
			gcds_print.namevalue(1,"CURDT")		 = gcem_staxdatfr2.text + gcem_staxdatto2.text;
			gcds_print.namevalue(1,"CURDT2")	 = gs_date;
		}
		gcrp_print.preview();
	}
}

/******************************************************************************
	Description : Report Head 설정
******************************************************************************/
function ln_SetDataHeader(){
	var s_temp = "CHK:STRING,TAXNBR:STRING,COCODE:STRING,TAXIODIV:STRING,"
						 + "TAXDIV:STRING,TAXIODIVNM:STRING,TAXDIVNM:STRING,TAXKND:STRING,"
						 + "TAXKNDNM:STRING,VEND_CD:STRING,VEND_NM:STRING,VEND_ID:STRING,"
						 + "TAXDAT:STRING,TAXSUM:DECIMAL,TAXVATAMT:DECIMAL,TAXTOT:DECIMAL,"
						 + "REMARK:STRING,TAXCDNBR:STRING,TAXPRTYN:STRING,FSDAT:STRING,"
						 + "FSNBR:STRING,FSNUM:STRING,TAXCNT:DECIMAL,TAXKIDIV:STRING,"
						 + "VD_DIRECT:STRING,BSNS_CND:STRING,BSNS_KND:STRING,COID:STRING,"
						 + "COSANG:STRING,ADDNM:STRING,FSSTAT:STRING,FDCODE:STRING,"
						 + "DEPTCD:STRING,DEPTNM:STRING,TREECD:STRING,EMPNO:STRING,"
						 + "EMPNMK:STRING,ATCODE:STRING,ATKORNAM:STRING,TAXNBR_R:STRING,"
						 + "FDCODENM:STRING,CURDT:STRING,CURDT2:STRING,PTITLE:STRING,"
						 + "DATANM:STRING";
	gcds_print.SetDataHeader(s_temp);
}

/******************************************************************************
	Description : Report Head 설정
******************************************************************************/
function ln_SetDataHeader2(){
	var s_temp = "CHK:STRING,TAXNBR:STRING,GUBUN:STRING";					
	gcds_gb_data.SetDataHeader(s_temp);
}
/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print22(){
	var chk = gcte_disp.ActiveIndex;
	if (chk =="2") {
		if (gclx_staxiodiv2.BindColVal !="") {
			ln_Query2('B');			
			ln_RptFormat2();
		}
	}
}

/******************************************************************************
	Description : 출력 - 세금계산서
******************************************************************************/
function ln_RptFormat2() {

	var ls_for = "";

	ls_for += " <B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=329 ,face='Arial' ,size=10 ,penwidth=1																																																								";
	ls_for += " <X>left=1088 ,top=34 ,right=1925 ,bottom=109 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>																																													";
	ls_for += " <X>left=1078 ,top=22 ,right=1913 ,bottom=100 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																													";
	ls_for += " <T>id='종목' ,left=1953 ,top=231 ,right=2759 ,bottom=275 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>											";
	ls_for += " <T>id='사업자번호' ,left=1084 ,top=231 ,right=1366 ,bottom=275 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>								";
	ls_for += " <T>id='업태' ,left=1378 ,top=231 ,right=1941 ,bottom=275 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>											";
	ls_for += " <T>id='전표번호' ,left=309 ,top=231 ,right=528 ,bottom=275 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>										";
	ls_for += " <T>id='거래처명' ,left=541 ,top=231 ,right=1072 ,bottom=275 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>										";
	ls_for += " <T>id='거래일자' ,left=78 ,top=231 ,right=297 ,bottom=275 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>																		";
	ls_for += " <L> left=63 ,top=219 ,right=2769 ,bottom=219 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>																																																				";
	ls_for += " <T>id='귀속구분' ,left=309 ,top=278 ,right=903 ,bottom=322 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>										";
	ls_for += " <T>id='구분' ,left=916 ,top=278 ,right=1072 ,bottom=322 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>												";
	ls_for += " <T>id='부가세종류' ,left=1084 ,top=278 ,right=1322 ,bottom=322 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>								";
	ls_for += " <T>id='적요' ,left=1378 ,top=278 ,right=1941 ,bottom=322 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>											";
	ls_for += " <T>id='금액' ,left=1953 ,top=278 ,right=2203 ,bottom=322 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>											";
	ls_for += " <T>id='합계' ,left=2478 ,top=278 ,right=2759 ,bottom=322 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>											";
	ls_for += " <L> left=63 ,top=328 ,right=2772 ,bottom=328 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>																																																				";
	ls_for += " <T>id='세액' ,left=2216 ,top=278 ,right=2466 ,bottom=322 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>											";
	
	var strfr = gcem_staxdatfr2.text;
	var strto = gcem_staxdatto2.text;
	var syyyy = strfr.substring(0,4);
	var smm   = strfr.substring(4,6);
	var sdd   = strfr.substring(6,8);
	var tyyyy = strto.substring(0,4);
	var tmm   = strto.substring(4,6);
	var tdd   = strto.substring(6,8);
	ls_for += " <C>id='(  거래일자 : "+syyyy+"년 "+smm+"월 "+sdd+"일  ~  "+tyyyy+"년 "+tmm+"월 "+tdd+"일  )', left=922, top=119, right=2066, bottom=166 ,mask='(  거래일자 : XXXX년 XX월 XX일  ~  XXXX년 XX월 XX일  )', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
	
	var strio = gclx_staxiodiv2.BindColVal;	//매입매출구분
	var strionm = "";
	if (strio =='1')			{	strionm += " 매 입";
	}else if(strio =='2') { strionm += " 매 출";	}
	ls_for += " <T>id='"+strionm+"' ,left=1081 ,top=25 ,right=1906 ,bottom=87 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>													";
	ls_for += " </B>																																																																																																";
	ls_for += " <B>id=default ,left=0,top=0 ,right=2869 ,bottom=91 ,face='Arial' ,size=10 ,penwidth=1																																																								";
	ls_for += " <C>id='BSNS_CND', left=1378, top=0, right=1941, bottom=44, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>									";
	ls_for += " <C>id='VEND_ID', left=1084, top=0, right=1366, bottom=44, align='left' ,mask='XXX-XX-XXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
	ls_for += " <C>id='VEND_NM', left=541, top=0, right=1072, bottom=44, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>										";
	ls_for += " <C>id='FSNBR', left=309, top=0, right=528, bottom=44, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>												";
	ls_for += " <C>id='TAXDAT', left=78, top=0, right=297, bottom=44 ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>									";
	ls_for += " <C>id='TAXDIVNM', left=309, top=47, right=903, bottom=91, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>										";
	ls_for += " <C>id='REMARK', left=1378, top=47, right=1941, bottom=91, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>										";
	ls_for += " <C>id='TAXSUM', left=1953, top=47, right=2203, bottom=91, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>									";
	ls_for += " <C>id='TAXVATAMT', left=2216, top=47, right=2466, bottom=91, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>								";
	ls_for += " <C>id='BSNS_KND', left=1953, top=0, right=2759, bottom=44, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>									";
	ls_for += " <C>id='TAXTOT', left=2478, top=47, right=2759, bottom=91, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>									";
	ls_for += " <C>id='TAXKNDNM', left=1084, top=47, right=1322, bottom=91, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>									";
	ls_for += " <C>id='TAXIODIVNM', left=916, top=47, right=1072, bottom=91, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>								";
	ls_for += " </B>																																																																																																";
	ls_for += " <B>id=Footer ,left=0 ,top=1856 ,right=2869 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1																																																					";
	ls_for += " <L> left=63 ,top=0 ,right=2769 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>																																																					";
	ls_for += " <I>id='../../common/img/icon.jpg' ,left=2413 ,top=3 ,right=2791 ,bottom=84</I>																																																											";
	ls_for += " </B>																																																																																																";

	gcrp_print.format = ls_for + gcrp_print.format;

}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){ 
	gclx_fsstat.index = 0;
	gclx_fsstat2.index = 0;

	gclx_amend_code.index = 0;
	gclx_amend_code2.index = 0;

	if(gs_userid=="6070001" || gs_userid=="2020009"){
		sp0.style.display = "";
	}else{
		sp0.style.display = "none";
	}

  
  /******************************
	//2009.09.03. 권한관리 추가로 막음.
	//login자와 부가세 관리자확인
	gcds_login.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0901&v_str2="+gs_userid;
	gcds_login.Reset();

	if( gcds_login.countrow>0){
		hid_login.value="M";
	}else{
		hid_login.value="";
	}
	******************************/

	//계산서별
	gclx_cocode.BindColVal		= "02";							//사업소
	gcem_staxdatfr.text			= gs_date2 + "01";	//계산서기간 from
	gcem_staxdatto.text			= gs_date;					//계산서기간 to
	//전표별
	gclx_cocode2.BindColVal	= "02";							//사업소
	gcem_staxdatfr2.text		= gs_date2 + "01";	//계산서기간 from
	gcem_staxdatto2.text		= gs_date;					//계산서기간 to

	//지점코드
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

	//거래처코드[검색]  
	//gcds_vendcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>vendcode_s1?v_str1="; 
	//gcds_vendcd.Reset();
	
	//귀속구분[매입]
	gcds_staxdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0014"; 
	gcds_staxdiv.Reset();

	//귀속구분[매출]
	gcds_staxdiv2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=1215"; 
	gcds_staxdiv2.Reset();

	//부가세종류[매입]
	gcds_staxknd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0013"; 
	gcds_staxknd.Reset();

	//부가세종류[매출]
	gcds_staxknd2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0009"; 
	gcds_staxknd2.Reset();

	//본부
	gcds_deptprt.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdeptprt_s1?"; 
	gcds_deptprt.Reset();

	//예산부서 chk
	gcds_temp1.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s3?v_str1="; 
	gcds_temp1.Reset();

	//담당자코드[회계팀]
	gcds_empno.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>confirm_popup_s1?v_str2="+gs_deptcd+"&v_str3="+gs_userid;
	gcds_empno.Reset();


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
	Description : 찾기 - 거래처코드
******************************************************************************/
function ln_Popup(p){
  var arrVAT	= new Array(); 
	if(p=="A") {	//계산서별
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
		} else {
			gcem_vendcd.text	= "";
			gcem_vendnm.text	= "";
		}
	}else if(p=="B") {	//전표별
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		arrVAT[0]="VAT";

		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrVAT,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_vendcd2.text  = arrParam[0];
			gcem_vendnm2.text	= arrParam[1];
		} else {
			gcem_vendcd2.text	= "";
			gcem_vendnm2.text	= "";
		}
	}
}

/***********************************************************************************************
	Description : 전표조회
	parameter   : fcod - 지점코드, fsdt - 전표일자, fnbr - 전표번호
**********************************************************************************************/
function ln_TaxQuery(e){
	if (e=="A") {	//계산서별
		for(var i=1; i<=gcds_data1.countrow;i++) {
			if(gcds_data1.namevalue(i,"CHK") == "T" && gcds_data1.namevalue(i,"FSNBR") != "") {	
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;

				arrParam[0] = gcds_data1.namevalue(i,"FDCODE");
				arrParam[1] = gcds_data1.namevalue(i,"FSDAT");
				arrParam[2] = gcds_data1.namevalue(i,"FSNBR");

				strURL = "./slipno_popup.jsp";
				strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
				arrResult = showModalDialog(strURL,arrParam,strPos);
			}else if (gcds_data1.namevalue(i,"CHK") == "T" && gcds_data1.namevalue(i,"FSNBR") == "") {
				alert("발행 된 전표가 없습니다.");
			}
		}
	}else if(e=="B") {	//전표별
		for(var i=1; i<=gcds_data1_2.countrow;i++) {
			if(gcds_data1_2.namevalue(i,"CHK") == "T" && gcds_data1_2.namevalue(i,"FSNBR") != "") {	
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;

				arrParam[0] = gcds_data1_2.namevalue(i,"FDCODE");
				arrParam[1] = gcds_data1_2.namevalue(i,"FSDAT");
				arrParam[2] = gcds_data1_2.namevalue(i,"FSNBR");

				strURL = "./slipno_popup.jsp";
				strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
				arrResult = showModalDialog(strURL,arrParam,strPos);
			}else if (gcds_data1_2.namevalue(i,"CHK") == "T" && gcds_data1_2.namevalue(i,"FSNBR") == "") {
				alert("발행 된 전표가 없습니다.");
			}
		}
	}
}

/***********************************************************************************************
	Description : 전표발행 - FSLIPMST
**********************************************************************************************/
function ln_TaxIssue(e){
	if (e=="A") {	//계산서별
		var schk = "F";
		for(var w=1;w<=gcds_data1.countrow;w++) {
			if (gcds_data1.namevalue(w,"CHK") == "T" && gcds_data1.namevalue(w,"FSNBR") == "") {	
				var str_taxnbr = gcds_data1.namevalue(w,"TAXNBR");
				var str_chk = "";
				if (gcds_data1.namevalue(w,"TAXIODIVNM") == "매입") { 
					str_chk = "A";
				}else if (gcds_data1.namevalue(w,"TAXIODIVNM") == "매출") { 
					str_chk = "B";
				}
				ln_Query3(str_chk,str_taxnbr);	//세금계산서 Detail Query
			}else if (gcds_data1.namevalue(w,"CHK") == "T" && gcds_data1.namevalue(w,"FSNBR") != "") {
				alert("전표가 이미 발행되었습니다.");
			}

			if(gcds_data1.namevalue(w,"CHK") !="F"){
				schk = "T";
			}
		}
		if (schk=="F") alert("선택된 정보가 없습니다.");
	}else if(e=="B") {
		var bchk = "F";
		for(var w=1;w<=gcds_data1_2.countrow;w++) {
			if (gcds_data1_2.namevalue(w,"CHK") == "T" && gcds_data1_2.namevalue(w,"FSNBR") == "") {	
				var str_taxnbr = gcds_data1_2.namevalue(w,"TAXNBR");
				var str_chk = "";
				if (gcds_data1_2.namevalue(w,"TAXIODIVNM") == "매입") { 
					str_chk = "A";
				}else if (gcds_data1_2.namevalue(w,"TAXIODIVNM") == "매출") { 
					str_chk = "B";
				}
				ln_Query3(str_chk,str_taxnbr);	//세금계산서 Detail Query
			}else if (gcds_data1_2.namevalue(w,"CHK") == "T" && gcds_data1_2.namevalue(w,"FSNBR") != "") {
				alert("전표가 이미 발행되었습니다.");
			}

			if(gcds_data1_2.namevalue(w,"CHK") !="F"){
				bchk = "T";
			}
		}
		if (bchk=="F") alert("선택된 정보가 없습니다.");
	}
}

/***********************************************************************************************
	Description : 계산서별-[전표발행 - FSLIPMST]
	parameter   : arrParam[0]  = "T",					arrParam[1]  = 지점,					arrParam[2]  = 전표일자,
	              arrParam[3]  = 전표번호,		arrParam[4]  = 전표상태(N),		arrParam[5]  = 부서,
	              arrParam[6]  = 부서명,			arrParam[7]  = 담당자사번,		arrParam[8]  = 담당자명,
	              arrParam[9]  = 적요,				arrParam[10] = 사업소코드,		arrParam[11] = 과세구분,
	              arrParam[12] = DTL합계금액
	----------------------------------------------------------------------------------------------
	Description : 계산서별-[전표발행 - FSLIPDTL]
	parameter   : arrParam[0]  = 계정코드,		arrParam[1]  = 계정명,				arrParam[2]  = 거래처코드,
	              arrParam[3]  = 거래처명,		arrParam[4]  = 부서코드,			arrParam[5]  = 부서명,
	              arrParam[6]  = 적요,				arrParam[7]  = 차변금액,			arrParam[8]  = 대변금액,
	              arrParam[9]  = 세금계산서번호, 
								arrParam[10] = 증빙명(001:세금계산서,  002:계산서,    003:신용카드,
								                      004:현금소득공제,005:간이영수증,006:간주공급)
								arrParam[11] = 소속본부,		arrParam[12] = 계산서일자
**********************************************************************************************/
function ln_TaxIssue2(){
	for(var w=1; w<=gcds_data1.countrow;w++) {
		if(gcds_data1.namevalue(w,"CHK") == "T" && gcds_data1.namevalue(w,"FSNBR") == "") {	
			
			//본부코드
			var str_tree = gcds_data1.namevalue(w,"DEPTCD");
			var str_deps = "";
			for(var g=1;g<=gcds_deptprt.countrow;g++) {
				var str_dep = gcds_deptprt.namevalue(g,"DEPTCD");
				var str_lel = gcds_deptprt.namevalue(g,"LEVEL");
				var str_tee = gcds_deptprt.namevalue(g,"TREECD");
				if(str_dep.substring(0,1) == str_tree.substring(0,1)) {
					str_deps = gcds_deptprt.namevalue(g,"DEPTCD");
				}
			}

			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;

			/*전표 - FSLIPMST*/
			arrParam[0]  = "T";
			arrParam[1]  = gcds_data1.namevalue(w,"FDCODE");	//gclx_fdcode.bindcolval;
			arrParam[2]  = gcds_data1.namevalue(w,"FSDAT");		//gcem_fsdat.text;
			arrParam[3]  = gcds_data1.namevalue(w,"FSNBR");		//gcem_fsnbr.text;
			arrParam[4]  = "N";
			arrParam[5]  = gcds_data1.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
			arrParam[6]  = gcds_data1.namevalue(w,"DEPTNM");	//gclx_dept.text;
			arrParam[7]  = gcds_data1.namevalue(w,"EMPNO");		//gclx_empno.bindcolval;
			arrParam[8]  = gcds_data1.namevalue(w,"EMPNMK");	//gclx_empno.text;
			//alert(arrParam[7]);
			//alert(arrParam[8]);
			arrParam[9]  = gcds_data1.namevalue(w,"REMARK");	//txt_remark.value;
			arrParam[10] = gcds_data1.namevalue(w,"COCODE");	//gclx_cocode.CodeValue;
			arrParam[11] = gcds_data1.namevalue(w,"TAXKND");	//str_deps;	//str_tree.substring(0,4)+"0000";
			arrParam[12] = gcds_data1.namevalue(w,"TAXTOT");	//gcem_taxtot.text;

			/*전표 - FSLIPDTL*/
			var j=1;
			for(var i=1;i<=gcds_data3.countrow;i++) {	
				j = j + 13;
				if(i==1) {
					arrParam[Number(j+1)]  = gcds_data1.namevalue(w,"ATCODE");		//gcem_atcode.text;
					arrParam[Number(j+2)]  = gcds_data1.namevalue(w,"ATKORNAM");	//txt_atkornam.value;
					arrParam[Number(j+3)]  = gcds_data1.namevalue(w,"VEND_CD");		//gcem_vendcd.text;
					arrParam[Number(j+4)]  = gcds_data1.namevalue(w,"VEND_NM");		//txt_fdcodenm.value;
					arrParam[Number(j+5)]  = gcds_data1.namevalue(w,"DEPTCD");		//gclx_dept.bindcolval;
					arrParam[Number(j+6)]  = gcds_data1.namevalue(w,"DEPTNM");		//gclx_dept.text;
					arrParam[Number(j+7)]  = gcds_data1.namevalue(w,"REMARK");		//txt_remark.value;
					if(gcds_data1.namevalue(w,"TAXIODIVNM") == "매입") {
						arrParam[Number(j+8)]  = 0;
						arrParam[Number(j+9)]  = gcds_data1.namevalue(w,"TAXTOT");	//gcem_taxtot.text;	//매입->대변[2]
					}else if(gcds_data1.namevalue(w,"TAXIODIVNM") == "매출") {
						arrParam[Number(j+8)]  = gcds_data1.namevalue(w,"TAXTOT");	//gcem_taxtot.text;	//매출->차변[1]
						arrParam[Number(j+9)]  = 0;
					}
					arrParam[Number(j+10)] = gcds_data1.namevalue(w,"TAXNBR");		//gcem_taxnbr.text;
					arrParam[Number(j+11)] = gcds_data1.namevalue(w,"GBCD");			//gclx_taxknd.bindcolval;
					arrParam[Number(j+12)] = gcds_data1.namevalue(w,"DEPTCD");		//추가-부서코드
					arrParam[Number(j+13)] = gcds_data1.namevalue(w,"TAXDAT");		//추가-계산서일자

					if (gcds_data3.namevalue(i,"TAXSUM") != "") {	/*세금계산서(detail)-공급가액*/
						j = j + 13;
						arrParam[Number(j+1)]  = "";
						arrParam[Number(j+2)]  = "";	
						arrParam[Number(j+3)]  = gcds_data1.namevalue(w,"VEND_CD");	//gcem_vendcd.text;
						arrParam[Number(j+4)]  = gcds_data1.namevalue(w,"VEND_NM");	//txt_fdcodenm.value;
						arrParam[Number(j+5)]  = gcds_data1.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
						arrParam[Number(j+6)]  = gcds_data1.namevalue(w,"DEPTNM");	//gclx_dept.text;
						arrParam[Number(j+7)]  = gcds_data1.namevalue(w,"REMARK");	//txt_remark.value;
						if (gcds_data1.namevalue(w,"TAXIODIVNM") == "매입") {
							arrParam[Number(j+8)]  = gcds_data3.namevalue(i,"TAXSUM");	//매입->대변[2] => 차변금액
							arrParam[Number(j+9)]  = 0;
						}else if(gcds_data1.namevalue(w,"TAXIODIVNM") == "매출") {
							arrParam[Number(j+8)]  = 0;
							arrParam[Number(j+9)]  = gcds_data3.namevalue(i,"TAXSUM");	//매출->차변[1] => 대변금액
						}
						arrParam[Number(j+10)] = gcds_data1.namevalue(w,"TAXNBR");		//gcem_taxnbr.text;
						arrParam[Number(j+11)] = gcds_data1.namevalue(w,"GBCD");			//gclx_taxknd.bindcolval;
						arrParam[Number(j+12)] = gcds_data1.namevalue(w,"DEPTCD");		//추가
						arrParam[Number(j+13)] = gcds_data1.namevalue(w,"TAXDAT");		//추가-계산서일자
					}

					if (gcds_data3.namevalue(i,"TAXVATAMT") != "") {	/*부가가치세[detail]*/
						j = j + 13;
						if (gcds_data1.namevalue(w,"TAXIODIVNM") == "매입") {
							arrParam[Number(j+1)]  = "1112300";//변경-"2101100";
							arrParam[Number(j+2)]  = "선급부가가치세";//변경-"선수부가가치세";
						}else if(gcds_data1.namevalue(w,"TAXIODIVNM") == "매출") {
							arrParam[Number(j+1)]  = "2101100";//변경-"2101200";
							arrParam[Number(j+2)]  = "선수부가가치세";//변경-"부가가치세예수금";
						}
						arrParam[Number(j+3)]  = gcds_data1.namevalue(w,"VEND_CD");	//gcem_vendcd.text;
						arrParam[Number(j+4)]  = gcds_data1.namevalue(w,"VEND_NM");	//txt_fdcodenm.value;
						arrParam[Number(j+5)]  = gcds_data1.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
						arrParam[Number(j+6)]  = gcds_data1.namevalue(w,"DEPTNM");	//gclx_dept.text;
						arrParam[Number(j+7)]  = gcds_data1.namevalue(w,"REMARK");	//txt_remark.value;
						if (gcds_data1.namevalue(w,"TAXIODIVNM") == "매입") {
							arrParam[Number(j+8)]  = gcds_data3.namevalue(i,"TAXVATAMT");	//매입->대변[2] => 차변금액
							arrParam[Number(j+9)]  = 0;
						}else if(gcds_data1.namevalue(w,"TAXIODIVNM") == "매출") {
							arrParam[Number(j+8)]  = 0;
							arrParam[Number(j+9)]  = gcds_data3.namevalue(i,"TAXVATAMT");	//매출->차변[1] => 대변금액
						}
						arrParam[Number(j+10)] = gcds_data1.namevalue(w,"TAXNBR");			//gcem_taxnbr.text;
						arrParam[Number(j+11)] = gcds_data1.namevalue(w,"GBCD");				//gclx_taxknd.bindcolval;
						arrParam[Number(j+12)] = gcds_data1.namevalue(w,"DEPTCD");			//추가
						arrParam[Number(j+13)] = gcds_data1.namevalue(w,"TAXDAT");		//추가-계산서일자
					}

				}else{
					if (gcds_data3.namevalue(i,"TAXSUM") != "") {	/*세금계산서(detail)-공급가액*/
						arrParam[Number(j+1)]  = "";
						arrParam[Number(j+2)]  = "";
						arrParam[Number(j+3)]  = gcds_data1.namevalue(w,"VEND_CD");	//gcem_vendcd.text;
						arrParam[Number(j+4)]  = gcds_data1.namevalue(w,"VEND_NM");	//txt_fdcodenm.value;
						arrParam[Number(j+5)]  = gcds_data1.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
						arrParam[Number(j+6)]  = gcds_data1.namevalue(w,"DEPTNM");	//gclx_dept.text;
						arrParam[Number(j+7)]  = gcds_data1.namevalue(w,"REMARK");	//txt_remark.value;
						if (gcds_data1.namevalue(w,"TAXIODIVNM") == "매입") {
							arrParam[Number(j+8)]  = gcds_data3.namevalue(i,"TAXSUM");	//매입->대변[2] => 차변금액
							arrParam[Number(j+9)]  = 0;
						}else if(gcds_data1.namevalue(w,"TAXIODIVNM") == "매출") {
							arrParam[Number(j+8)]  = 0;
							arrParam[Number(j+9)]  = gcds_data3.namevalue(i,"TAXSUM");	//매출->차변[1] => 대변금액
						}
						arrParam[Number(j+10)] = gcds_data1.namevalue(w,"TAXNBR");		//gcem_taxnbr.text;
						arrParam[Number(j+11)] = gcds_data1.namevalue(w,"GBCD");			//gclx_taxknd.bindcolval;
						arrParam[Number(j+12)] = gcds_data1.namevalue(w,"DEPTCD");		//추가
						arrParam[Number(j+13)] = gcds_data1.namevalue(w,"TAXDAT");		//추가-계산서일자
					}

					if (gcds_data3.namevalue(i,"TAXVATAMT") != "") {	/*부가가치세[detail]*/
						j = j + 13;
						if (gcds_data1.namevalue(w,"TAXIODIVNM") == "매입") {
							arrParam[Number(j+1)]  = "1112300";//변경-"2101100";
							arrParam[Number(j+2)]  = "선급부가가치세";//변경-"선수부가가치세";
						}else if(gcds_data1.namevalue(w,"TAXIODIVNM") == "매출") {
							arrParam[Number(j+1)]  = "2101100";//변경-"2101200";
							arrParam[Number(j+2)]  = "선수부가가치세";//변경-"부가가치세예수금";
						}
						arrParam[Number(j+3)]  = gcds_data1.namevalue(w,"VEND_CD");	//gcem_vendcd.text;
						arrParam[Number(j+4)]  = gcds_data1.namevalue(w,"VEND_NM");	//txt_fdcodenm.value;
						arrParam[Number(j+5)]  = gcds_data1.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
						arrParam[Number(j+6)]  = gcds_data1.namevalue(w,"DEPTNM");	//gclx_dept.text;
						arrParam[Number(j+7)]  = gcds_data1.namevalue(w,"REMARK");	//txt_remark.value;
						if(gcds_data1.namevalue(w,"TAXIODIVNM") == "매입") {
							arrParam[Number(j+8)]  = gcds_data3.namevalue(i,"TAXVATAMT");	//매입->대변[2] => 차변금액
							arrParam[Number(j+9)]  = 0;
						}else if(gcds_data1.namevalue(w,"TAXIODIVNM") == "매출") {
							arrParam[Number(j+8)]  = 0;
							arrParam[Number(j+9)]  = gcds_data3.namevalue(i,"TAXVATAMT");	//매출->차변[1] => 대변금액
						}
						arrParam[Number(j+10)] = gcds_data1.namevalue(w,"TAXNBR");			//gcem_taxnbr.text;
						arrParam[Number(j+11)] = gcds_data1.namevalue(w,"GBCD");				//gclx_taxknd.bindcolval;
						arrParam[Number(j+12)] = gcds_data1.namevalue(w,"DEPTCD");			//추가
						arrParam[Number(j+13)] = gcds_data1.namevalue(w,"TAXDAT");		//추가-계산서일자
					}
				}
			}
			
			strURL = "./slipno_popup.jsp";
			strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);
			ln_Query();
		}
	}
}

/***********************************************************************************************
	Description : 전표별-[전표발행 - FSLIPMST]
	parameter   : arrParam[0]  = "T",					arrParam[1]  = 지점,					arrParam[2]  = 전표일자,
	              arrParam[3]  = 전표번호,		arrParam[4]  = 전표상태(N),		arrParam[5]  = 부서,
	              arrParam[6]  = 부서명,			arrParam[7]  = 담당자사번,		arrParam[8]  = 담당자명,
	              arrParam[9]  = 적요,				arrParam[10] = 사업소코드,		arrParam[11] = 본부코드,
	              arrParam[12] = DTL합계금액
	----------------------------------------------------------------------------------------------
	Description : 전표별-[전표발행 - FSLIPDTL]
	parameter   : arrParam[0]  = 계정코드,		arrParam[1]  = 계정명,				arrParam[2]  = 거래처코드,
	              arrParam[3]  = 거래처명,		arrParam[4]  = 부서코드,			arrParam[5]  = 부서명,
	              arrParam[6]  = 적요,				arrParam[7]  = 차변금액,			arrParam[8]  = 대변금액,
	              arrParam[9]  = 세금계산서번호, 
								arrParam[10] = 증빙명(001:세금계산서,  002:계산서,    003:신용카드,
								                      004:현금소득공제,005:간이영수증,006:간주공급)
								arrParam[11] = 소속본부,		arrParam[12] = 계산서일자
**********************************************************************************************/
function ln_TaxIssue2_2(){
	for(var w=1; w<=gcds_data1_2.countrow;w++) {
		if(gcds_data1_2.namevalue(w,"CHK") == "T" && gcds_data1_2.namevalue(w,"FSNBR") == "") {	
			
			//본부코드
			var str_tree = gcds_data1_2.namevalue(w,"DEPTCD");
			var str_deps = "";
			for(var g=1;g<=gcds_deptprt.countrow;g++) {
				var str_dep = gcds_deptprt.namevalue(g,"DEPTCD");
				var str_lel = gcds_deptprt.namevalue(g,"LEVEL");
				var str_tee = gcds_deptprt.namevalue(g,"TREECD");
				if(str_dep.substring(0,1) == str_tree.substring(0,1)) {
					str_deps = gcds_deptprt.namevalue(g,"DEPTCD");
				}
			}
			
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;

			/*전표 - FSLIPMST*/
			arrParam[0]  = "T";
			arrParam[1]  = gcds_data1_2.namevalue(w,"FDCODE");	//gclx_fdcode.bindcolval;
			arrParam[2]  = gcds_data1_2.namevalue(w,"FSDAT");		//gcem_fsdat.text;
			arrParam[3]  = gcds_data1_2.namevalue(w,"FSNBR");		//gcem_fsnbr.text;
			arrParam[4]  = "N";
			arrParam[5]  = gcds_data1_2.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
			arrParam[6]  = gcds_data1_2.namevalue(w,"DEPTNM");	//gclx_dept.text;
			arrParam[7]  = gcds_data1_2.namevalue(w,"EMPNO");		//gclx_empno.bindcolval;
			arrParam[8]  = gcds_data1_2.namevalue(w,"EMPNMK");	//gclx_empno.text;
			arrParam[9]  = gcds_data1_2.namevalue(w,"REMARK");	//txt_remark.value;
			arrParam[10] = gcds_data1_2.namevalue(w,"COCODE");	//gclx_cocode.CodeValue;
			arrParam[11] = gcds_data1_2.namevalue(w,"TAXKND");		////str_deps;	//str_tree.substring(0,4)+"0000";
			arrParam[12] = gcds_data1_2.namevalue(w,"TAXTOT");	//gcem_taxtot.text;

			/*전표 - FSLIPDTL*/
			var j=1;
			for(var i=1;i<=gcds_data3.countrow;i++) {	
				j = j + 13;
				if(i==1) {
					arrParam[Number(j+1)]  = gcds_data1_2.namevalue(w,"ATCODE");		//gcem_atcode.text;
					arrParam[Number(j+2)]  = gcds_data1_2.namevalue(w,"ATKORNAM");	//txt_atkornam.value;
					arrParam[Number(j+3)]  = gcds_data1_2.namevalue(w,"VEND_CD");		//gcem_vendcd.text;
					arrParam[Number(j+4)]  = gcds_data1_2.namevalue(w,"VEND_NM");		//txt_fdcodenm.value;
					arrParam[Number(j+5)]  = gcds_data1_2.namevalue(w,"DEPTCD");		//gclx_dept.bindcolval;
					arrParam[Number(j+6)]  = gcds_data1_2.namevalue(w,"DEPTNM");		//gclx_dept.text;
					arrParam[Number(j+7)]  = gcds_data1_2.namevalue(w,"REMARK");		//txt_remark.value;
					if(gcds_data1_2.namevalue(w,"TAXIODIVNM") == "매입") {
						arrParam[Number(j+8)]  = 0;
						arrParam[Number(j+9)]  = gcds_data1_2.namevalue(w,"TAXTOT");	//gcem_taxtot.text;	//매입->대변[2]
					}else if(gcds_data1_2.namevalue(w,"TAXIODIVNM") == "매출") {
						arrParam[Number(j+8)]  = gcds_data1_2.namevalue(w,"TAXTOT");	//gcem_taxtot.text;	//매출->차변[1]
						arrParam[Number(j+9)]  = 0;
					}
					arrParam[Number(j+10)] = gcds_data1_2.namevalue(w,"TAXNBR");		//gcem_taxnbr.text;
					arrParam[Number(j+11)] = gcds_data1_2.namevalue(w,"GBCD");			//gclx_taxknd.bindcolval;
					arrParam[Number(j+12)] = gcds_data1_2.namevalue(w,"DEPTCD");		//추가
					arrParam[Number(j+13)] = gcds_data1_2.namevalue(w,"TAXDAT");		//추가-계산서일자

					if (gcds_data3.namevalue(i,"TAXSUM") != "") {	/*세금계산서(detail)-공급가액*/
						j = j + 13;
						arrParam[Number(j+1)]  = "";
						arrParam[Number(j+2)]  = "";	
						arrParam[Number(j+3)]  = gcds_data1_2.namevalue(w,"VEND_CD");	//gcem_vendcd.text;
						arrParam[Number(j+4)]  = gcds_data1_2.namevalue(w,"VEND_NM");	//txt_fdcodenm.value;
						arrParam[Number(j+5)]  = gcds_data1_2.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
						arrParam[Number(j+6)]  = gcds_data1_2.namevalue(w,"DEPTNM");	//gclx_dept.text;
						arrParam[Number(j+7)]  = gcds_data1_2.namevalue(w,"REMARK");	//txt_remark.value;
						if (gcds_data1_2.namevalue(w,"TAXIODIVNM") == "매입") {
							arrParam[Number(j+8)]  = gcds_data3.namevalue(i,"TAXSUM");	//매입->대변[2] => 차변금액
							arrParam[Number(j+9)]  = 0;
						}else if(gcds_data1_2.namevalue(w,"TAXIODIVNM") == "매출") {
							arrParam[Number(j+8)]  = 0;
							arrParam[Number(j+9)]  = gcds_data3.namevalue(i,"TAXSUM");	//매출->차변[1] => 대변금액
						}
						arrParam[Number(j+10)] = gcds_data1_2.namevalue(w,"TAXNBR");	//gcem_taxnbr.text;
						arrParam[Number(j+11)] = gcds_data1_2.namevalue(w,"GBCD");		//gclx_taxknd.bindcolval;
						arrParam[Number(j+12)] = gcds_data1_2.namevalue(w,"DEPTCD");	//추가
						arrParam[Number(j+13)] = gcds_data1_2.namevalue(w,"TAXDAT");		//추가-계산서일자
					}

					if (gcds_data3.namevalue(i,"TAXVATAMT") != "") {	/*부가가치세[detail]*/
						j = j + 13;
						if (gcds_data1_2.namevalue(w,"TAXIODIVNM") == "매입") {
							arrParam[Number(j+1)]  = "1112300";//변경-"2101100";
							arrParam[Number(j+2)]  = "선급부가가치세";//변경-"선수부가가치세";
						}else if(gcds_data1_2.namevalue(w,"TAXIODIVNM") == "매출") {
							arrParam[Number(j+1)]  = "2101100";//변경-"2101200";
							arrParam[Number(j+2)]  = "선수부가가치세";//변경-"부가가치세예수금";
						}
						arrParam[Number(j+3)]  = gcds_data1_2.namevalue(w,"VEND_CD");	//gcem_vendcd.text;
						arrParam[Number(j+4)]  = gcds_data1_2.namevalue(w,"VEND_NM");	//txt_fdcodenm.value;
						arrParam[Number(j+5)]  = gcds_data1_2.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
						arrParam[Number(j+6)]  = gcds_data1_2.namevalue(w,"DEPTNM");	//gclx_dept.text;
						arrParam[Number(j+7)]  = gcds_data1_2.namevalue(w,"REMARK");	//txt_remark.value;
						if (gcds_data1_2.namevalue(w,"TAXIODIVNM") == "매입") {
							arrParam[Number(j+8)]  = gcds_data3.namevalue(i,"TAXVATAMT");	//매입->대변[2] => 차변금액
							arrParam[Number(j+9)]  = 0;
						}else if(gcds_data1_2.namevalue(w,"TAXIODIVNM") == "매출") {
							arrParam[Number(j+8)]  = 0;
							arrParam[Number(j+9)]  = gcds_data3.namevalue(i,"TAXVATAMT");	//매출->차변[1] => 대변금액
						}
						arrParam[Number(j+10)] = gcds_data1_2.namevalue(w,"TAXNBR");		//gcem_taxnbr.text;
						arrParam[Number(j+11)] = gcds_data1_2.namevalue(w,"GBCD");			//gclx_taxknd.bindcolval;
						arrParam[Number(j+12)] = gcds_data1_2.namevalue(w,"DEPTCD");		//추가
						arrParam[Number(j+13)] = gcds_data1_2.namevalue(w,"TAXDAT");		//추가-계산서일자
					}

				}else{
					if (gcds_data3.namevalue(i,"TAXSUM") != "") {	/*세금계산서(detail)-공급가액*/
						arrParam[Number(j+1)]  = "";
						arrParam[Number(j+2)]  = "";
						arrParam[Number(j+3)]  = gcds_data1_2.namevalue(w,"VEND_CD");	//gcem_vendcd.text;
						arrParam[Number(j+4)]  = gcds_data1_2.namevalue(w,"VEND_NM");	//txt_fdcodenm.value;
						arrParam[Number(j+5)]  = gcds_data1_2.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
						arrParam[Number(j+6)]  = gcds_data1_2.namevalue(w,"DEPTNM");	//gclx_dept.text;
						arrParam[Number(j+7)]  = gcds_data1_2.namevalue(w,"REMARK");	//txt_remark.value;
						if (gcds_data1_2.namevalue(w,"TAXIODIVNM") == "매입") {
							arrParam[Number(j+8)]  = gcds_data3.namevalue(i,"TAXSUM");	//매입->대변[2] => 차변금액
							arrParam[Number(j+9)]  = 0;
						}else if(gcds_data1_2.namevalue(w,"TAXIODIVNM") == "매출") {
							arrParam[Number(j+8)]  = 0;
							arrParam[Number(j+9)]  = gcds_data3.namevalue(i,"TAXSUM");	//매출->차변[1] => 대변금액
						}
						arrParam[Number(j+10)] = gcds_data1_2.namevalue(w,"TAXNBR");	//gcem_taxnbr.text;
						arrParam[Number(j+11)] = gcds_data1_2.namevalue(w,"GBCD");		//gclx_taxknd.bindcolval;
						arrParam[Number(j+12)] = gcds_data1_2.namevalue(w,"DEPTCD");	//추가
						arrParam[Number(j+13)] = gcds_data1_2.namevalue(w,"TAXDAT");		//추가-계산서일자
					}

					if (gcds_data3.namevalue(i,"TAXVATAMT") != "") {	/*부가가치세[detail]*/
						j = j + 13;
						if (gcds_data1_2.namevalue(w,"TAXIODIVNM") == "매입") {
							arrParam[Number(j+1)]  = "1112300";//변경-"2101100";
							arrParam[Number(j+2)]  = "선급부가가치세";//변경-"선수부가가치세";
						}else if(gcds_data1_2.namevalue(w,"TAXIODIVNM") == "매출") {
							arrParam[Number(j+1)]  = "2101100";//변경-"2101200";
							arrParam[Number(j+2)]  = "선수부가가치세";//변경-"부가가치세예수금";
						}
						arrParam[Number(j+3)]  = gcds_data1_2.namevalue(w,"VEND_CD");	//gcem_vendcd.text;
						arrParam[Number(j+4)]  = gcds_data1_2.namevalue(w,"VEND_NM");	//txt_fdcodenm.value;
						arrParam[Number(j+5)]  = gcds_data1_2.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
						arrParam[Number(j+6)]  = gcds_data1_2.namevalue(w,"DEPTNM");	//gclx_dept.text;
						arrParam[Number(j+7)]  = gcds_data1_2.namevalue(w,"REMARK");	//txt_remark.value;
						if (gcds_data1_2.namevalue(w,"TAXIODIVNM") == "매입") {
							arrParam[Number(j+8)]  = gcds_data3.namevalue(i,"TAXVATAMT");	//매입->대변[2] => 차변금액
							arrParam[Number(j+9)]  = 0;
						}else if(gcds_data1_2.namevalue(w,"TAXIODIVNM") == "매출") {
							arrParam[Number(j+8)]  = 0;
							arrParam[Number(j+9)]  = gcds_data3.namevalue(i,"TAXVATAMT");	//매출->차변[1] => 대변금액
						}
						arrParam[Number(j+10)] = gcds_data1_2.namevalue(w,"TAXNBR");		//gcem_taxnbr.text;
						arrParam[Number(j+11)] = gcds_data1_2.namevalue(w,"GBCD");			//gclx_taxknd.bindcolval;
						arrParam[Number(j+12)] = gcds_data1_2.namevalue(w,"DEPTCD");		//추가
						arrParam[Number(j+13)] = gcds_data1_2.namevalue(w,"TAXDAT");		//추가-계산서일자
					}
				}
			}
			strURL = "./slipno_popup.jsp";
			strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);
			ln_Query('B');
		}
	}
}

/******************************************************************************
	Description : 탭구분
	prameter    : 0-매입, 1-매출
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp1","div_disp2");
	for(var i=0;i<=1;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
			if (i==0) {
				gclx_staxknd.index=0;
				gclx_staxknd_2.index=0;
			}else{
				gclx_staxknd2.index=0;
				gclx_staxknd2_2.index=0;
			}
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
			if (i==1) {
				gclx_staxknd2.index=0;
				gclx_staxknd2_2.index=0;
			}else{
				gclx_staxknd.index=0;
				gclx_staxknd_2.index=0;
			}
		}
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcds_data1" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
  <PARAM NAME="UseFilter" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data1_2" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
  <PARAM NAME="UseFilter" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data2" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data3" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_fdcode" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 지점코드[검색] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_vendcd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 거래처코드[검색] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_staxdiv" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 귀속구분[매입] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_staxdiv2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 귀속구분[매출] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_staxknd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 부가세종류[매입] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_staxknd2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 부가세종류[매출] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_deptprt" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 본부코드 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_print" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_temp1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id="gcds_temp" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id="gcds_empno" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<!-- 로그인 체크 -->
<comment id="__NSID__">
 <object  id=gcds_login classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- 권한관리 -->
<object id=gcds_right classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- 권한관리 -->
<object id=gcds_gb_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gctr_data1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data1 event=OnLoadCompleted(row,colid)>
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status = "정상적으로 조회되었습니다.";
	if (row<1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_data1_2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for="gcds_data1_2" event=OnLoadCompleted(row,colid)>
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt1_2.innerText = "조회건수 : " + row + " 건";
	window.status = "정상적으로 조회되었습니다.";
	if (row<1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data2 event=OnLoadCompleted(row,colid)>
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row<1) {
		alert("출력하실 정보가 없습니다");
	}else{
		gcrp_print.preview();	//매입(매출장) 출력
	}
</script>

<script language="javascript" for="gcds_data3" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data3 event=OnLoadCompleted(row,colid)>
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (gcds_data3.namevalue(1,"TAXNBR") != null) {
		var chk = gcte_disp.ActiveIndex;
		if (chk =="1") {
			ln_TaxIssue2();		//계산서별 - 전표발행등록
		}else if (chk =="2") {
			ln_TaxIssue2_2();	//전표별   - 전표발행등록
		}
	}else{
		alert("세부항목이 등록되지 않았습니다.");
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1)); 
</script>

<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="전체";
	if(gs_userid=="ACCOUNT"){
		gclx_fdcode.index=2;
		gclx_fdcode2.index=2;
	}else{
		gclx_fdcode.bindcolval=gs_fdcode;
		gclx_fdcode2.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_staxdiv" event="onloadCompleted(row,colid)">
	gcds_staxdiv.InsertRow(1);
	gcds_staxdiv.NameValue(1,"CDCODE")="";
	gcds_staxdiv.NameValue(1,"CDNAM")="전체";
	gclx_staxdiv.index=0;
	gclx_staxdiv2.index=0;
</script>

<script language="javascript" for="gcds_staxdiv2" event="onloadCompleted(row,colid)">
	gcds_staxdiv2.InsertRow(1);
	gcds_staxdiv2.NameValue(1,"CDCODE")="";
	gcds_staxdiv2.NameValue(1,"CDNAM")="전체";
	gclx_staxdiv_2.index=0;
	gclx_staxdiv_3.index=0;
</script>

<script language="javascript" for="gcds_staxknd" event="onloadCompleted(row,colid)">
	gcds_staxknd.InsertRow(1);
	gcds_staxknd.NameValue(1,"CDCODE")="";
	gcds_staxknd.NameValue(1,"CDNAM")="전체";
	gclx_staxknd.index=0;
	gclx_staxknd_2.index=0;
	gclx_staxknd2.index=0;
	gclx_staxknd2_2.index=0;
</script>

<script language="javascript" for="gcds_staxknd2" event="onloadCompleted(row,colid)">
	gcds_staxknd2.InsertRow(1);
	gcds_staxknd2.NameValue(1,"CDCODE")="";
	gcds_staxknd2.NameValue(1,"CDNAM")="전체";
	gclx_staxknd.index=0;
	gclx_staxknd_2.index=0;
	gclx_staxknd2.index=0;
	gclx_staxknd2_2.index=0;
</script>
 
<script language="javascript" for="gcds_staxdiv" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";

	gcds_staxdiv.InsertRow(1);
	gcds_staxdiv.NameValue(1,"CDCODE")="";
	gcds_staxdiv.NameValue(1,"CDNAM")="전체";
	gclx_staxdiv.index=0;
	gclx_staxdiv2.index=0;
</script>

<script language="javascript"  for=gcgd_data1 event="OnClick(Row,Colid)">
	if (Colid =="CHK") {
		for (var i=1; i<=gcds_data1.countrow;i++) {
			if(i != Row) {
				gcds_data1.namevalue(i,"CHK") = "F";
			}
		}
	}
</script>

<script language="javascript"  for=gcgd_data2 event="OnClick(Row,Colid)">
	if (Colid =="CHK") {
		for (var i=1; i<=gcds_data1_2.countrow;i++) {
			if(i != Row) {
				gcds_data1_2.namevalue(i,"CHK") = "F";
			}
		}
	}
</script>

<script language="javascript"  for=gcgd_data1 event="OnDblClick(Row,Colid)">
    /*
	var strURL;
	var strPos;
	var arrParam = new Array();
	var result   = new Array();

	arrParam[0] = gcds_data1.namevalue(gcds_data1.rowposition,"TAXNBR").substring(0,1);
	arrParam[1] = gcds_data1.namevalue(gcds_data1.rowposition,"FDCODE");
	arrParam[2] = gcds_data1.namevalue(gcds_data1.rowposition,"TAXNBR").substring(1,11);

	//strURL = "./STaxBill_popup_2.jsp";
	//strURL = "./STaxBill_popup_2_ee.jsp";
	strURL = "./staxbill_popup_2_ee_a.jsp";
	strPos = "dialogWidth:888px;dialogHeight:650px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	*/
	
	var strURL;
	var strPos;
	var arrParam = new Array();
	var result   = new Array();
	
	var strParam = gcds_data1.namevalue(gcds_data1.rowposition,"TAXNBR").substring(0,1);
	arrParam[0] = gcds_data1.namevalue(gcds_data1.rowposition,"TAXNBR");
	
	if(strParam=="A"||strParam=="C"||strParam=="E"||strParam=="G"||strParam=="J"){
		strURL = "./a040110_popup.jsp";
		
	}else if(strParam=="B"||strParam=="D"||strParam=="F"||strParam=="H"||strParam=="K"){
		strURL = "./a040120_popup.jsp";
	}
	
	strPos = "dialogWidth:970px;dialogHeight:635px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
</script>

<script language="javascript"  for=gcgd_data2 event="OnDblClick(Row,Colid)">
	var strURL;
	var strPos;
	var arrParam = new Array();
	var result   = new Array();
	
	var strParam = gcds_data1_2.namevalue(gcds_data1_2.rowposition,"TAXNBR").substring(0,1);

	//arrParam[0] = gcds_data1_2.namevalue(gcds_data1_2.rowposition,"TAXNBR").substring(0,1);
	//arrParam[1] = gcds_data1_2.namevalue(gcds_data1_2.rowposition,"FDCODE");
	//arrParam[2] = gcds_data1_2.namevalue(gcds_data1_2.rowposition,"TAXNBR").substring(1,11);
	arrParam[0] = gcds_data1_2.namevalue(gcds_data1_2.rowposition,"TAXNBR");
	//alert("arrParam[0]"+arrParam[0]);

	//strURL = "./STaxBill_popup_2.jsp";
	//strURL = "./STaxBill_popup_2_ee.jsp";
	//strURL = "./staxbill_popup_2_ee_a.jsp";
	
	if(strParam=="A"||strParam=="C"||strParam=="E"||strParam=="G"){
		strURL = "./a040110_popup.jsp";
		
	}else if(strParam=="B"||strParam=="D"||strParam=="F"||strParam=="H"){
		strURL = "./a040120_popup.jsp";
	}
	
	strPos = "dialogWidth:970px;dialogHeight:635px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

</script>

<script language=JavaScript for="gclx_staxiodiv" event="OnSelChange2()">
	if (gclx_staxiodiv.bindcolval == "1") {	//부가세종류[매입]
		document.all.gclx_staxknd.style.display='block';
		document.all.gclx_staxknd_2.style.display='none';

		document.all.gclx_staxdiv.style.display='block';
		document.all.gclx_staxdiv_2.style.display='none';
	}else if(gclx_staxiodiv.bindcolval == "2") {
		document.all.gclx_staxknd.style.display='none';
		document.all.gclx_staxknd_2.style.display='block';

		document.all.gclx_staxdiv.style.display='none';
		document.all.gclx_staxdiv_2.style.display='block';
	}
</script>

<script language=JavaScript for="gclx_staxiodiv2" event="OnSelChange2()">
	if (gclx_staxiodiv2.bindcolval == "1") {//부가세종류[매출]
		document.all.gclx_staxknd2.style.display='block';
		document.all.gclx_staxknd2_2.style.display='none';

		document.all.gclx_staxdiv2.style.display='block';
		document.all.gclx_staxdiv_3.style.display='none';
	}else if(gclx_staxiodiv2.bindcolval == "2") {
		document.all.gclx_staxknd2.style.display='none';
		document.all.gclx_staxknd2_2.style.display='block';

		document.all.gclx_staxdiv2.style.display='none';
		document.all.gclx_staxdiv_3.style.display='block';
	}
</script>

<!----------------------------------------------------------------------------
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


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a040002_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr>
			<td width="0" align=right>
				<comment id="__NSID__">
				<object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:260px;height:20px;">
					<PARAM NAME="BackColor"		   	  VALUE="#cccccc">
					<PARAM NAME="titleHeight"		  VALUE="20px">
				  	<PARAM NAME="DisableBackColor"	  VALUE="#eeeeee">
				    <PARAM NAME="Format"			  VALUE="
						<T>divid=div_1		title='계산서별'</T>
						<T>divid=div_2		title='전표별'</T>									
				  ">
				</object>
				</comment><script>__ws__(__NSID__);</script> 
				<input type="hidden" class="txt11" id="hid_login"  style="position:relative;left:0px;width:60px;background-color:#d7d7d7" readOnly>
			</td>
		</tr>
	  </table>
	</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!-- 계산서별 ===========================================================================================================-->
<div id="div_disp1" style="border:0 solid #708090;">
<table border="0" cellpadding=0 cellspacing=0 style="position:relative;left:0px;">
	<tr>
		<td>
			<table cellpadding="1" cellspacing="0" border="0" style='position:relative;left:8px;width:867px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        		<tr> 
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>지점코드</nobr></td>
					<td width="115px;" class="tab21">
						<comment id="__NSID__"><object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:110px;">
							<param name=ComboDataID			value="gcds_fdcode">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value=false>
              				<param name=Enable              value="true">
							<param name=ListExprFormat	    value="FDNAME^0^100">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>  
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;사업장&nbsp;</nobr></td>
					<td width="115px;" class="tab21">
            			<nobr>
						<comment id="__NSID__"><object  id=gclx_cocode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData					value="01^고성,02^서울,04^홍성">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index						value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;계산서기간&nbsp;</nobr></td>
					<td width="200px"class="tab21"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_staxdatto', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">&nbsp;</nobr>
					</td>
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;발행여부&nbsp;</nobr></td>
					<td width="115px" class="tab22">
						<comment id="__NSID__"><object  id=gclx_taxprtyn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData					value="^전체,Y^발행,N^미발행">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index						value="0">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
				<tr> 
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>거래처코드</nobr></td>
					<td width="170px;" class="tab22" colspan="7"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:250px" onKeydown="if(event.keyCode==13) ln_Query('A')">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=GeneralEdit value="true">
								<param name=PromptChar	value="_">
							</object>
						</comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-2px;cursor:hand"	 onclick="ln_Popup('A')">
					   	<comment id="__NSID__">
					   		<object  id=gcem_vendcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:90px" onKeydown="if(event.keyCode==13) ln_Query('A')">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="#############">
								<param name=PromptChar	    value="_">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
						<img name="btn_find" src="../../Common/img/btn/com_b_clear.gif"	style="position:relative;top:1px;left:8px;cursor:hand"	 onclick="gcem_vendnm.text = '';gcem_vendcd.text = '';">
						<!-- 계산서별 버튼 --------------------------------------------------------------------------------------------------------------------------------------->
						<img name="btn_p1" src="../../Common/img/btn/com_b_taxselect.gif"	style="position:relative;top:-59px;left:85px;cursor:hand"	onclick="ln_TaxQuery('A')"> 
						<!-- <img name="btn_p2" src="../../Common/img/btn/com_b_taxissue.gif"	style="position:relative;top:-59px;left:15px;cursor:hand"	onclick="ln_TaxIssue('A')">  -->
						<img name="btn_p3" src="../../Common/img/btn/com_b_print.gif"		style="position:relative;top:-59px;left:85px;cursor:hand"	onclick="ln_Print()"> 
						<img name="btn_p6" src="../../Common/img/btn/com_b_delete.gif"		style="position:relative;top:-59px;left:85px;cursor:hand"	onclick="ln_Delete('A')"> 
						<img name="btn_p5" src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;top:-59px;left:85px;cursor:hand"	onclick="ln_Excel('A')">
						<img name="btn_q4" src="../../Common/img/btn/com_b_query.gif"		style="position:relative;top:-59px;left:85px;cursor:hand"   onclick="ln_Query('A')"></nobr> 
						<!-- 계산서별 버튼 --------------------------------------------------------------------------------------------------------------------------------------->
					</td>
				</tr>
				<tr> 
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>매입매출구분</nobr></td>
					<td width="110px;" class="tab21"><nobr>
						<comment id="__NSID__"><object  id=gclx_staxiodiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData				value="1^매입,2^매출">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index						value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>  
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;부가세종류&nbsp;</nobr></td>
					<td width="110px" class="tab21"><nobr>
						<comment id="__NSID__"><object  id=gclx_staxknd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;height:150px;display:block">
							<param name=ComboDataID			value="gcds_staxknd"><!-- 매입구분:0013 -->
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value=CDNAM>
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
						<comment id="__NSID__"><object  id=gclx_staxknd_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;height:180px;display:none">
							<param name=ComboDataID			value="gcds_staxknd2"><!-- 매출구분:0009 -->
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value="false">
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
						</nobr>
					</td>
					<!-- 2009.12.07 jys 귀속구분을 조회 조건에서 임의로 뺌 나주에 필요하면 추가함. -->
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;귀속구분&nbsp;</nobr></td>
					<td width="200px" class="tab21"><nobr>
						<comment id="__NSID__"><object  id=gclx_staxdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:130px;display:block">
								<param name=ComboDataID			value="gcds_staxdiv"><!-- 매입 -->
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=ListExprFormat	    value="CDNAM^0^130">
								<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
						<comment id="__NSID__"><object  id=gclx_staxdiv_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:130px;display:none">
								<param name=ComboDataID			value="gcds_staxdiv2"><!-- 매출 -->
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=ListExprFormat	    value="CDNAM^0^130">
								<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;전표상태&nbsp;</nobr></td>
					<td width="110px" class="tab22"><nobr>
						<comment id="__NSID__"><object  id=gclx_fsstat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData				value="^전체,Y^결재완료,C^결재취소,R^결재요청,N^결재대기,B^반송">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^100">
								<param name=BindColumn			value="CDCODE">
								<param name=index						value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
				</tr>
        		<tr> 
					<td width="80px"  class="tab12" bgcolor="#eeeeee"><nobr>수정코드</nobr></td>
					<td width="170px;"  class="tab12"  colspan="3"><nobr>
						<comment id="__NSID__">
							<object  id=gclx_amend_code classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:3px;top:0px;font-size:12px;width:180px;height:200px;">
								<param name=CBData				value="^'전체',01^기재사항의 착오 정정,02^공급가액 변동,03^환입,04^계약의 해제,05^내국신용장 사후 개설,06^착오에 의한 이중발급 등">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=ListExprFormat	    value="CDCODE^0^30,CDNAM^0^180">
								<param name=BindColumn			value="CDCODE">
  						</object></comment><script>__ws__(__NSID__);</script>
						</nobr>
					</td>
					
					<td  class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;eBill구분&nbsp;</nobr></td>
					<td  class="tab23" ><nobr>
						<comment id="__NSID__">
							<object  id=gclx_ebillgb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData				value="^전체,1^스마트빌,2^트러스빌,9^기타">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^100">
								<param name=BindColumn			value="CDCODE">
								<param name=index				value="0">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
					</td>
					
					<td  class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;결재상태&nbsp;</nobr></td>
					<td>
						<comment id="__NSID__">
							<object  id=gclx_taxsts classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;font-size:12px;width:100px;height:100px;">
								<param name=CBData			    value="^전체,N^대기,R^요청,Y^승인,B^반송">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=Enable				value="true">
								<param name=ListExprFormat	    value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
								<param name=index				value="0">
							</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=3></td></tr>
  <tr> 
    <td colspan="2"> 
      <table width="865" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;">
        <tr> 
          <td style="width:865" class="tab32">
						<comment id="__NSID__"><object  id="gcgd_data1"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="height:355;width:865" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data1">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="viewSummary" VALUE="1">
							<PARAM NAME="ColSizing"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="BorderStyle" VALUE="0">
							<param name="IndWidth"    value="0">
							<param name="Fillarea"		VALUE="true">
							<Param Name="UsingOneClick"  value="1">
							<PARAM NAME="Format"			VALUE=" 
								<F>ID=CHK,		 Name='선택'		 ,width=30, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, EditStyle=CheckBox BgColor='#f5f5f5' Cursor='hand' SumBgColor=#C3D0DB</F>
								<C>ID=FDNAME, 	 Name='지점'		 ,width=40, HeadBgColor=#B9D4DC,HeadAlign=center, align=left,   Edit=none sort=true SumBgColor=#C3D0DB</C>
								<F>ID=TAXDAT,	 Name='계산서일자'	 ,width=85, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, mask='XXXX/XX/XX', BgColor='#f5f5f5' Edit=none sort=true SumText='합계'  SumBgColor=#C3D0DB</F>
								<F>ID=TAXNBR_R,	 Name='번호'		 ,width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, BgColor='#f5f5f5' Edit=none sort=true SumBgColor=#C3D0DB</F>
								<C>ID=VEND_CD,	 Name='거래처코드'	 ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, EditStyle=Lookup, Edit=none sort=true show=false SumBgColor=#C3D0DB</C>
								<C>ID=VEND_CD,	 Name='거래처명'	 ,width=135,HeadBgColor=#B9D4DC,HeadAlign=center, align=left,   EditStyle=Lookup, Data='gcds_vendcd:VEND_CD:VEND_NM' Edit=none sort=true SumBgColor=#C3D0DB show=false</C>
								<C>ID=VEND_NM,	 Name='거래처명'	 ,width=95, HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT,   BgColor='#f5f5f5' Edit=none sort=true SumBgColor=#C3D0DB</C>
								<C>ID=VEND_ID,	 Name='사업자번호'	 ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, mask='XXX-XX-XXXXX',Edit=none sort=true SumBgColor=#C3D0DB</C>
								<C>ID=REMARK,	 Name='적요'		 ,width=135,HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT    Edit=none sort=true SumBgColor=#C3D0DB</C>
								<C>ID=TAXKNDNM,	 Name='종류'	     ,width=45, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>
								<C>ID=TAXDIVNM,	 Name='귀속구분'	 ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT    Edit=none sort=true SumBgColor=#C3D0DB</C>
								<C>ID=TAXSUM,	 Name='공급가액'	 ,width=85, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none  SumBgColor=#C3D0DB SumText=@sum sort=true</C>
								<C>ID=TAXVATAMT, Name='부가세액'	 ,width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none  SumBgColor=#C3D0DB SumText=@sum sort=true</C>
								<C>ID=TAXTOT,	 Name='합계금액'	 ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none  SumBgColor=#C3D0DB SumText=@sum sort=true</C>
								<C>ID=TAXPRTYN,	 Name='발행여부'	 ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='Y:발행,N:미발행' Edit=none sort=true SumBgColor=#C3D0DB</C>
								<C>ID=FSSTAT,	 Name='전표상태'	 ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='Y:결재완료,C:결재취소,R:결재요청,N:결재대기,B:반송' Edit=none sort=true SumBgColor=#C3D0DB</C>
								<C>ID=EMPNMK,	 Name='담당자'	 ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB</C>
								<C>ID=DEPTNM,	 Name='담당부서'	 ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB</C>
								<C>ID=DTI_STATUS,Name='상태'		 ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB EditStyle=Combo Data='S:매출저장,A:매입저장,V:역발행요청,I:수신미승인,C:수신승인,M:발행취소요청(공급받는자),N:발행취소요청(공급자),R:수신거부,O:취소완료,T:역발행거부,W:역발행요청 취소'</C>
								<C>ID=GUBUN,     Name='발행구분'	 ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB EditStyle=Combo Data='1:전자발행,2:수기발행'</C>
								<C>ID=AMEND_CODE,Name='수정코드'	 ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB </C>
							    <C>ID=TAXCDNBR,  Name='신용카드번호',width=130, HeadBgColor=#B9D4DC,HeadAlign=center, align=center    Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XXXX-XXXX-XXXX'</C>
								<C>ID=EXTCHK,    Name='외부발행'	 ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  </C>
								<C>ID=DUEDATE,	 Name='입금예정일'	 ,width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, mask='XXXX/XX/XX',  Edit=none SumBgColor=#C3D0DB </C>
								<C>ID=TAXSTS,	 Name='결재상태'	 ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='N:대기,R:요청,Y:승인,B:반송' Edit=none sort=true SumBgColor=#C3D0DB</C>
								<C>ID=SB_REASON, Name='반송사유'	 ,width=100, HeadBgColor=#B9D4DC,HeadAlign=center,align=left    Edit=none sort=true SumBgColor=#C3D0DB</C>
							">
            </object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="width:865;height:20px;;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</div>


<!-- 전표별 ===========================================================================================================-->
<fieldset id=field2 style="position:absolute;top:160px;left:18px;height:498px;width:879px;bacground-color:#708090"></fieldset>
<div id="div_disp2" style="border:0 solid #708090;" >
<table border="0" cellpadding=0 cellspacing=0 style="position:relative;left:0px;">
	<tr>
		<td>
			<table cellpadding="1" cellspacing="0" border="0" style='position:relative;left:8px;width:867px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>지점코드</nobr></td>
					<td width="115px;" class="tab21">
						<comment id="__NSID__"><object  id=gclx_fdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:110px;">
							<param name=ComboDataID			value="gcds_fdcode">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort						value=false>
              <param name=Enable          value="true">
							<param name=ListExprFormat	value="FDNAME^0^100">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>  
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;사업장&nbsp;</nobr></td>
					<td width="115px;" class="tab21">
            <nobr>
						<comment id="__NSID__"><object  id=gclx_cocode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData					value="01^고성,02^서울,04^홍성">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index						value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;계산서기간&nbsp;</nobr></td>
					<td width="200px"class="tab21"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatfr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr2', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatto2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable		  value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_staxdatto2', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">&nbsp;</nobr>
					</td>
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;발행여부&nbsp;</nobr></td>
					<td width="115px" class="tab22">
						<comment id="__NSID__"><object  id=gclx_taxprtyn2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData				value="^전체,Y^발행,N^미발행">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index						value="0">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
				<tr> 
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>거래처코드</nobr></td>
					<td width="170px;" class="tab22" colspan="7"><nobr>
						<comment id="__NSID__"><object  id=gcem_vendnm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:250px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=GeneralEdit     value="true">
								<param name=PromptChar	    value="_">
							</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;<img name="btn_find2" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-2px;cursor:hand"	 onclick="ln_Popup('B')">
						<comment id="__NSID__"><object  id=gcem_vendcd2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:90px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="#############">
								<param name=PromptChar	    value="_">
							</object></comment><script>__ws__(__NSID__);</script> 
							<img name="btn_clear" src="../../Common/img/btn/com_b_clear.gif"	style="position:relative;top:1px;left:8px;cursor:hand"	 onclick="gcem_vendnm2.text = '';gcem_vendcd2.text = '';">
							
							<!-- 전표별 버튼 --------------------------------------------------------------------------------------------------------------------------------------->
							<span id=sp0 style="display:none;">
								<img name="btn_p0_2" src="../../Common/img/btn/com_b_save.gif"	    style="position:relative;top:-59px;left:40px;cursor:hand"	onclick="ln_Save()"> 
							</span>
							
							<img name="btn_p1_2" src="../../Common/img/btn/com_b_taxselect.gif"	    style="position:relative;top:-59px;left:45px;cursor:hand"	onclick="ln_TaxQuery('B')"> 
							<!-- <img name="btn_p2_2" src="../../Common/img/btn/com_b_taxissue.gif"	style="position:relative;top:-59px;left:15px;cursor:hand"	onclick="ln_TaxIssue('B')">  -->
							<img name="btn_p3_2" src="../../Common/img/btn/com_b_print.gif"			style="position:relative;top:-59px;left:45px;cursor:hand"	onclick="ln_Print2()"> 
							<img name="btn_p6_2" src="../../Common/img/btn/com_b_delete.gif"		style="position:relative;top:-59px;left:45px;cursor:hand"	onclick="ln_Delete('B')">
							<img name="btn_p5_2" src="../../Common/img/btn/com_b_excel.gif"			style="position:relative;top:-59px;left:45px;cursor:hand"	onclick="ln_Excel('B')"> 
							<img name="btn_q4_2" src="../../Common/img/btn/com_b_query.gif"			style="position:relative;top:-59px;left:45px;cursor:hand"   onclick="ln_Query('B')"></nobr>
							<!-- 전표별 버튼 --------------------------------------------------------------------------------------------------------------------------------------->
					</td>
				</tr>
				<tr> 
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>매입매출구분</nobr></td>
					<td width="110px;" class="tab21"><nobr>
						<comment id="__NSID__"><object  id=gclx_staxiodiv2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData				value="1^매입,2^매출">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index				value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>  
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;부가세종류&nbsp;</nobr></td>
					<td width="110px" class="tab21"><nobr>
						<comment id="__NSID__"><object  id=gclx_staxknd2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;height:150px;display:block">
							<param name=ComboDataID			value="gcds_staxknd"><!-- 매입구분:0013 -->
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value=CDNAM>
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
						<comment id="__NSID__"><object  id=gclx_staxknd2_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;height:150px;display:none">
							<param name=ComboDataID			value="gcds_staxknd2"><!-- 매출구분:0009 -->
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value=CDNAM>
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;귀속구분&nbsp;</nobr></td>
					<td width="200px" class="tab21"><nobr>
						<comment id="__NSID__"><object  id=gclx_staxdiv2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:130px;display:block">
							<param name=ComboDataID			value="gcds_staxdiv"><!-- 매입 -->
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value="false">
							<param name=ListExprFormat	    value="CDNAM^0^130">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
						<comment id="__NSID__"><object  id=gclx_staxdiv_3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:130px;display:none">
							<param name=ComboDataID			value="gcds_staxdiv2"><!-- 매출 -->
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value="false">
							<param name=ListExprFormat	    value="CDNAM^0^130">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;전표상태&nbsp;</nobr></td>
					<td width="110px" class="tab22"><nobr>
						<comment id="__NSID__"><object  id=gclx_fsstat2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData				value="^전체,Y^결재완료,C^결재취소,R^결재요청,N^결재대기,B^반송">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^100">
								<param name=BindColumn			value="CDCODE">
								<param name=index				value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
				</tr>
        		<tr> 
					<td width="80px" class="tab12" bgcolor="#eeeeee"><nobr>수정코드</nobr></td>
					<td width="370px;"   class="tab23" colspan="3"><nobr>
						<comment id="__NSID__">
							<object  id=gclx_amend_code2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:3px;top:0px;font-size:12px;width:180px;height:200px;">
								<param name=CBData				value="^'전체',01^기재사항의 착오 정정,02^공급가액 변동,03^환입,04^계약의 해제,05^내국신용장 사후 개설,06^착오에 의한 이중발급 등">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=ListExprFormat	    value="CDCODE^0^30,CDNAM^0^180">
								<param name=BindColumn			value="CDCODE">
  						</object></comment><script>__ws__(__NSID__);</script>
						</nobr>
					</td>
					
					<td class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;eBill구분&nbsp;</nobr></td>
					<td class="tab23">
						<comment id="__NSID__"><object  id=gclx_ebillgb2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData				value="^전체,1^스마트빌,2^트러스빌,9^기타">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index				value="0">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
					
					<td  class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;결재상태&nbsp;</nobr></td>
					<td>
						<comment id="__NSID__">
							<object  id=gclx_taxsts2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;font-size:12px;width:100px;height:100px;">
								<param name=CBData			    value="^전체,N^대기,R^요청,Y^승인,B^반송">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=Enable				value="true">
								<param name=ListExprFormat	    value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
								<param name=index				value="0">
							</object>
						</comment><script>__ws__(__NSID__);</script>
						
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=3></td></tr>
  <tr> 
    <td colspan="2"> 
      <table width="865" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;">
        <tr> 
          <td style="width:865" class="tab32">
						<comment id="__NSID__"><object  id="gcgd_data2"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:355;width:865" >
              <PARAM NAME="DataID"			VALUE="gcds_data1_2">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="viewSummary"   VALUE="1">
							<PARAM NAME="ColSizing"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="BorderStyle"   VALUE="0">
							<param name="IndWidth"      value="0">
							<param name="Fillarea"		VALUE="true">
							<Param Name="UsingOneClick"  value="1">
							<PARAM NAME="Format"			VALUE=" 
							<F>ID=CHK,		 Name='선택'		  ,width=30, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, EditStyle=CheckBox BgColor='#f5f5f5' SumBgColor=#C3D0DB</F>
							<F>ID=FDNAME, 	 Name='지점'		  ,width=40, HeadBgColor=#B9D4DC,HeadAlign=center, align=left,   Edit=none sort=true SumBgColor=#C3D0DB</F>
							<F>ID=FSNUM,	 Name='전표번호'	  ,width=105,HeadBgColor=#B9D4DC,HeadAlign=center, align=center, BgColor='#f5f5f5' Edit=none sort=true mask='XXXXXXXXX-XXXXXX' SumText='합계'  SumBgColor=#C3D0DB</F>
							<C>ID=VEND_CD,	 Name='거래처코드'	  ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, BgColor='#f5f5f5' Edit=none sort=true show=false SumBgColor=#C3D0DB</C>
							<C>ID=VEND_NM,	 Name='거래처명'	  ,width=95, HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT,   BgColor='#f5f5f5' Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=VEND_ID,	 Name='사업자번호'	  ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, mask='XXX-XX-XXXXX',Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=TAXSUM,	 Name='공급가액'	  ,width=85, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C>ID=TAXVATAMT, Name='부가세액'	  ,width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C>ID=TAXTOT,	 Name='합계금액'	  ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C>ID=REMARK,	 Name='적요'		  ,width=135,HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT    Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=TAXKNDNM,	 Name='종류'	      ,width=45, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=GUBUN,     Name='발행구분'	  ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    sort=true show=true SumBgColor=#C3D0DB EditStyle=Combo Data='1:전자발행,2:수기발행'</C>
							<C>ID=FSSTAT,	 Name='전표상태'	  ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='Y:결재완료,C:결재취소,R:결재요청,N:결재대기,B:반송' Edit=none sort=true SumBgColor=#C3D0DB</C>
                            <C>ID=DTI_STATUS,Name='상태'		  ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB EditStyle=Combo Data='S:매출저장,A:매입저장,V:역발행요청,I:수신미승인,C:수신승인,M:발행취소요청(공급받는자),N:발행취소요청(공급자),R:수신거부,O:취소완료,T:역발행거부,W:역발행요청 취소'</C>
							<C>ID=TAXPRTYN,	 Name='발행여부'	  ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='Y:발행,N:미발행' Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=EMPNMK,	 Name='담당자'	  ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB</C>
							<C>ID=DEPTNM,	 Name='담당부서'	  ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB</C>
							<C>ID=AMEND_CODE,Name='수정코드'	  ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB </C>
							<C>ID=TAXCDNBR,  Name='신용카드번호' ,width=130, HeadBgColor=#B9D4DC,HeadAlign=center, align=center    Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XXXX-XXXX-XXXX'</C>
							<C>ID=TAXDAT,    Name='계산서일자'	  ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XX-XX'</C>
							<C>ID=EXTCHK,    Name='외부발행'    ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  </C>
							<C>ID=TAXDIVNM,	 Name='귀속구분'	  ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT    Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=DUEDATE,	 Name='입금예정일'	  ,width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, mask='XXXX/XX/XX', Edit=none  SumBgColor=#C3D0DB</C>
							<C>ID=TAXSTS,	 Name='결재상태'	  ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='N:대기,R:요청,Y:승인,B:반송' Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=SB_REASON, Name='반송사유'	 ,width=100, HeadBgColor=#B9D4DC,HeadAlign=center,align=left    Edit=none sort=true SumBgColor=#C3D0DB</C>
							">
            </object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="width:865;height:20px;;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt1_2 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</div>

<!-----------------------------------------------------------------------------
			B I N D  D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  ID=gcbn_data CLASSID="CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49"> 
	<PARAM NAME=DataID    VALUE=gcds_data1>
	<PARAM NAME=BindInfo  VALUE="
	">
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N - 부 가 세 매 입 매 출 장
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<param NAME="MasterDataID"			VALUE="gcds_print">
	<param NAME="DetailDataID"			VALUE="gcds_print">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="FixPaperSize"			VALUE="true">
	<PARAM NAME="PrintMargine"      VALUE="false">
	<PARAM NAME="LandScape"					VALUE="true">
    <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
	
	<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=389 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1024 ,top=34 ,right=1863 ,bottom=108 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1016 ,top=21 ,right=1849 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='CURDT', left=860, top=119, right=2003, bottom=167 ,mask='(  기간 : XXXX년 XX월 XX일  ~  XXXX년 XX월 XX일  )', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='PTITLE', left=1019, top=24, right=1844, bottom=87, face='HY중고딕', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=71 ,top=384 ,right=2810 ,bottom=384 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DATANM', left=71, top=222, right=1357, bottom=275, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='FDCODENM', left=71, top=175, right=918, bottom=222, align='left' ,mask='지      점: XXXXXXXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='귀속구분' ,left=310 ,top=333 ,right=902 ,bottom=378 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=71 ,top=280 ,right=2810 ,bottom=280 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=280 ,right=71 ,bottom=384 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2810 ,top=280 ,right=2810 ,bottom=384 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURDT2', left=2384, top=175, right=2807, bottom=222, align='right' ,mask='출력일자: XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Page : #p of #t' ,left=2384 ,top=222 ,right=2807 ,bottom=275 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거래일자' ,left=77 ,top=286 ,right=296 ,bottom=378 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='거래처명' ,left=635 ,top=286 ,right=1072 ,bottom=331 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='전표번호' ,left=310 ,top=286 ,right=622 ,bottom=331 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='구분' ,left=915 ,top=333 ,right=1072 ,bottom=378 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='사업자번호' ,left=1085 ,top=286 ,right=1365 ,bottom=331 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='업태' ,left=1378 ,top=286 ,right=1691 ,bottom=331 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='적요' ,left=1378 ,top=333 ,right=2016 ,bottom=378 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='종목' ,left=1704 ,top=286 ,right=2802 ,bottom=331 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='금액' ,left=2027 ,top=333 ,right=2278 ,bottom=378 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='금액' ,left=2291 ,top=333 ,right=2540 ,bottom=378 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='금액' ,left=2553 ,top=333 ,right=2802 ,bottom=378 ,align='right' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='계산서종류' ,left=1085 ,top=333 ,right=1365 ,bottom=378 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=98 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=71 ,bottom=95 </L>
	<C>id='FSNUM', left=310, top=0, right=622, bottom=45, align='left' ,mask='XXXXXXXXX-XXXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TAXDIVNM', left=310, top=48, right=902, bottom=90, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TAXIODIVNM', left=915, top=48, right=1072, bottom=90, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VEND_ID', left=1085, top=0, right=1365, bottom=45, align='left' ,mask='XXX-XX-XXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TAXKNDNM', left=1085, top=48, right=1365, bottom=90, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BSNS_CND', left=1378, top=0, right=1691, bottom=45, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=1378, top=48, right=2016, bottom=90, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAXTOT', left=2553, top=48, right=2802, bottom=90, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BSNS_KND', left=1704, top=0, right=2802, bottom=45, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAXDAT', left=77, top=0, right=296, bottom=90 ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=2810 ,top=0 ,right=2810 ,bottom=95 </L>
	<L> left=71 ,top=95 ,right=2810 ,bottom=95 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>
	<C>id='VEND_NM', left=635, top=0, right=1072, bottom=45, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAXSUM', left=2027, top=48, right=2278, bottom=90, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAXVATAMT', left=2291, top=48, right=2540, bottom=90, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=2810 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Tail ,left=0,top=0 ,right=2871 ,bottom=53 ,face='Tahoma' ,size=10 ,penwidth=1
	<S>id='{Sum(TAXTOT)}' ,left=2553 ,top=5 ,right=2805 ,bottom=48 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<L> left=71 ,top=53 ,right=2810 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=0 ,right=71 ,bottom=50 </L>
	<L> left=2810 ,top=3 ,right=2810 ,bottom=53 </L>
	<S>id='{Sum(TAXVATAMT)}' ,left=2289 ,top=5 ,right=2540 ,bottom=48 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<S>id='{Sum(TAXSUM)}' ,left=2027 ,top=5 ,right=2278 ,bottom=48 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<T>id='합계' ,left=1704 ,top=5 ,right=2000 ,bottom=50 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
</B>
<B>id=Footer ,left=0 ,top=1857 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=85</I>
	<L> left=71 ,top=0 ,right=2810 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>



	">
</object></comment><script>__ws__(__NSID__);</script> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 