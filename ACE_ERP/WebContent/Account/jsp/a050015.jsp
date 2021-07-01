<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  회계관리 - 게산서 합계표
+ 프로그램 ID	:  A050015.jsp
+ 기 능 정 의	:  
+ 작   성  자 :  정 영 식
+ 서 블 릿 명	:	 a050015_s1
------------------------------------------------------------------------------
+ 수  정  자  :  이 동 훈
+ 수정내용   : 계산서 자료 제출 형식 변경에 따른 수정	2013.07.10
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>계산서합계표</title>
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

var gs_frdt="";
var gs_todt="";

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){

	gcem_saccyy.text    = gs_date2;	//년도
	gclx_saccyyqt.index = 0;				//기수

}

/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(e){

	var strAccyy = gcem_saccyy.text;			//년도
	var gisu = gclx_saccyyqt.BindColVal;	//기수
	var strAccyyqt="";                    //기수구분
	var strRptgb="";                      //신고구분
	var strFrymd ="";                     //거래기간fr
	var strToymd ="";                     //거래기간to

    gcem_vendcnt_B.text  ="";
	gcem_shtcnt_B.text   ="";
	gcem_reqamt_B.text   ="";
	gcem_vendcnt1_B.text ="";
	gcem_shtcnt1_B.text  ="";
	gcem_reqamt1_B.text  ="";
	gcem_vendcnt2_B.text ="";
	gcem_shtcnt2_B.text  ="";
	gcem_reqamt2_B.text  ="";
	gcem_vendcnt_A.text  ="";
	gcem_shtcnt_A.text   ="";
	gcem_reqamt_A.text   ="";

    gcem_vendcnt_B2.text  ="";
	gcem_shtcnt_B2.text   ="";
	gcem_reqamt_B2.text   ="";
	gcem_vendcnt1_B2.text ="";
	gcem_shtcnt1_B2.text  ="";
	gcem_reqamt1_B2.text  ="";
	gcem_vendcnt2_B2.text ="";
	gcem_shtcnt2_B2.text  ="";
	gcem_reqamt2_B2.text  ="";
	gcem_vendcnt_A2.text  ="";
	gcem_shtcnt_A2.text   ="";
	gcem_reqamt_A2.text   ="";
	
	
	gcem_vendcnt_B_sum.text="";
	gcem_shtcnt_B_sum.text="";
	gcem_reqamt_B_sum.text="";
	gcem_vendcnt1_sum.text="";
	gcem_shtcnt1_sum.text="";
	gcem_reqamt1_sum.text="";
	gcem_vendcnt2_sum.text="";
	gcem_shtcnt2_sum.text="";
	gcem_reqamt2_sum.text="";
	gcem_vendcnt_A_sum.text="";
	gcem_shtcnt_A_sum.text="";
	gcem_reqamt_A_sum.text="";
	

	if(gcem_saccyy.text==""){
		alert("년도를 입력하십시요.");
		return;
	}

	if(gisu=="1"){ 
		strAccyyqt="1";
		strRptgb="1";  
		strFrymd = strAccyy+"0101";
		strToymd = strAccyy+"0331";
	}else if(gisu=="2"){
		strAccyyqt="1";
		strRptgb="2";  
		strFrymd = strAccyy+"0401";
		strToymd = strAccyy+"0630";
	}else if(gisu=="3"){
		strAccyyqt="2";
		strRptgb="1";  
		strFrymd = strAccyy+"0701";
		strToymd = strAccyy+"0930";
	}else if(gisu=="4"){
		strAccyyqt="2";
		strRptgb="2";  
		strFrymd = strAccyy+"1001";
		strToymd = strAccyy+"1231";
	}

	//데이터 있는지 조회....있으면...그것 조회 없으면 생성해서 보여줌..

	//A (1건)
	gcds_data_a.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050015_s1?v_str1="+strFrymd
																									        +"&v_str2="+strToymd;
																								        
	//prompt('',gcds_data_a.DataID);
	gcds_data_a.Reset();

 

	//C(2개) 매출집계, 매입집계
	gcds_data_c.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050015_s3?v_str1="+strAccyyqt
																										        +"&v_str2="+strRptgb
																												+"&v_str3="+strAccyy;

    //prompt('',gcds_data_c.DataID);
	gcds_data_c.Reset();

  
	//D (N개)
    gcds_data_d.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050015_s4?v_str1="+strAccyyqt
																										      +"&v_str2="+strRptgb
																										      +"&v_str3="+strAccyy;
																										     
	//prompt('',gcds_data_d.DataID);
	gcds_data_d.Reset();
  
  
	//E (2개) 매출집계, 매입집계
    gcds_data_e.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050015_s5?v_str1="+strAccyyqt
																										      +"&v_str2="+strRptgb
																										      +"&v_str3="+strAccyy;
																										     
	//prompt('',gcds_data_e.DataID);
	gcds_data_e.Reset();  
  
}


/******************************************************************************************
	Description : C레코드 조회 ( 매출과 매입을 구분함.) 
******************************************************************************************/
function ln_Setting_C(){

	//alert("ln_Setting_C");
		
	for(i=1;i<=gcds_data_c.countrow;i++){
	
		if(gcds_data_c.namevalue(i,"DATADIV")=="17"){        //매출
				gcem_vendcnt_B.text = gcds_data_c.namevalue(i,"VENDCNT");
	      		gcem_shtcnt_B.text  = gcds_data_c.namevalue(i,"SHTCNT");
				gcem_reqamt_B.text  = gcds_data_c.namevalue(i,"REQAMT");
				gcem_vendcnt1_B.text = gcds_data_c.namevalue(i,"VENDCNT1");
	      		gcem_shtcnt1_B.text  = gcds_data_c.namevalue(i,"SHTCNT1");
				gcem_reqamt1_B.text  = gcds_data_c.namevalue(i,"REQAMT1");
				gcem_vendcnt2_B.text = gcds_data_c.namevalue(i,"VENDCNT2");
	      		gcem_shtcnt2_B.text  = gcds_data_c.namevalue(i,"SHTCNT2");
				gcem_reqamt2_B.text  = gcds_data_c.namevalue(i,"REQAMT2");
		}else if(gcds_data_c.namevalue(i,"DATADIV")=="18"){ 		//매입
			    //alert("ln_Setting_C"+gcds_data_c.namevalue(i,"VENDCNT"));
				gcem_vendcnt_A.text = gcds_data_c.namevalue(i,"VENDCNT");
	      		gcem_shtcnt_A.text  = gcds_data_c.namevalue(i,"SHTCNT");
				gcem_reqamt_A.text  = gcds_data_c.namevalue(i,"REQAMT");
		}
	}
}


/******************************************************************************************
	Description : E레코드 조회 ( 매출과 매입을 구분함.) 
******************************************************************************************/
function ln_Setting_E(){
		
	for(i=1;i<=gcds_data_e.countrow;i++){
	
		if(gcds_data_e.namevalue(i,"DATADIV")=="17"){        //매출

				gcem_vendcnt_B2.text = gcds_data_e.namevalue(i,"VENDCNT");
	      		gcem_shtcnt_B2.text  = gcds_data_e.namevalue(i,"SHTCNT");
				gcem_reqamt_B2.text  = gcds_data_e.namevalue(i,"REQAMT");
				gcem_vendcnt1_B2.text = gcds_data_e.namevalue(i,"VENDCNT1");
	      		gcem_shtcnt1_B2.text  = gcds_data_e.namevalue(i,"SHTCNT1");
				gcem_reqamt1_B2.text  = gcds_data_e.namevalue(i,"REQAMT1");
				gcem_vendcnt2_B2.text = gcds_data_e.namevalue(i,"VENDCNT2");
	      		gcem_shtcnt2_B2.text  = gcds_data_e.namevalue(i,"SHTCNT2");
				gcem_reqamt2_B2.text  = gcds_data_e.namevalue(i,"REQAMT2");    

		}else if(gcds_data_e.namevalue(i,"DATADIV")=="18"){ 		//매입

				gcem_vendcnt_A2.text = gcds_data_e.namevalue(i,"VENDCNT");
	      		gcem_shtcnt_A2.text  = gcds_data_e.namevalue(i,"SHTCNT");
				gcem_reqamt_A2.text  = gcds_data_e.namevalue(i,"REQAMT");				
	
		}
	}
	
	if(gcds_data_c.countrow >= 1){  

		if(gcds_data_e.countrow >= 1){  	

			ln_Setting_sum();
			
		}
	}
	
}

/******************************************************************************************
	Description : E레코드 조회 ( 매출과 매입을 구분함.) 
******************************************************************************************/
function ln_Setting_sum(){

	for(i=1;i<=gcds_data_e.countrow;i++){

		if(gcds_data_e.namevalue(i,"DATADIV")=="17"){        //매출
			
				gcem_vendcnt_B_sum.text = gcds_data_c.namevalue(i,"VENDCNT")+gcds_data_e.namevalue(i,"VENDCNT");
	      		gcem_shtcnt_B_sum.text  = gcds_data_c.namevalue(i,"SHTCNT")+gcds_data_e.namevalue(i,"SHTCNT");
				gcem_reqamt_B_sum.text  = gcds_data_c.namevalue(i,"REQAMT")+gcds_data_e.namevalue(i,"REQAMT");
				gcem_vendcnt1_sum.text = gcds_data_c.namevalue(i,"VENDCNT1")+gcds_data_e.namevalue(i,"VENDCNT1");
	      		gcem_shtcnt1_sum.text  = gcds_data_c.namevalue(i,"SHTCNT1")+gcds_data_e.namevalue(i,"SHTCNT1");
				gcem_reqamt1_sum.text  = gcds_data_c.namevalue(i,"REQAMT1")+gcds_data_e.namevalue(i,"REQAMT1");
				gcem_vendcnt2_sum.text = gcds_data_c.namevalue(i,"VENDCNT2")+gcds_data_e.namevalue(i,"VENDCNT2");
	      		gcem_shtcnt2_sum.text  = gcds_data_c.namevalue(i,"SHTCNT2")+gcds_data_e.namevalue(i,"SHTCNT2");
				gcem_reqamt2_sum.text  = gcds_data_c.namevalue(i,"REQAMT2")+gcds_data_e.namevalue(i,"REQAMT2");  

		}else if(gcds_data_e.namevalue(i,"DATADIV")=="18"){ 		//매입
		
				gcem_vendcnt_A_sum.text = gcds_data_c.namevalue(1,"VENDCNT")+gcds_data_e.namevalue(i,"VENDCNT");
	      		gcem_shtcnt_A_sum.text  = gcds_data_c.namevalue(1,"SHTCNT")+gcds_data_e.namevalue(i,"SHTCNT");
	      		
	      		//alert(i+"cREQAMT::"+gcds_data_c.namevalue(i,"REQAMT"));
	      		//alert(i+"eREQAMT::"+gcds_data_e.namevalue(i,"REQAMT"));
				gcem_reqamt_A_sum.text  = gcds_data_c.namevalue(1,"REQAMT")+gcds_data_e.namevalue(i,"REQAMT");
		}
	}		
}

/******************************************************************************************
	Description : 저장
******************************************************************************************/
function ln_Save(){
	
}

/******************************************************************************************
	Description : 삭제
*****************************************************************************************/
function ln_Delete(){

}

/******************************************************************************************
	Description : 생성
	계산서합계표 데이터 생성 
*****************************************************************************************/
function ln_Create(){

    var strfrdt="";
	var strtodt="";

  	ln_SetDataHeaderClearAll();
  	
	ln_SetDataHeader();
	
	ln_Add();

	if(gcds_ihead.IsUpdated) {	
	
		if (confirm("생성 하시겠습니까?")){	
		
			gctr_data.KeyValue = "Account.a050015_t1(I:USER=gcds_ihead)";
			
			gctr_data.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050015_t1";
			
			//prompt('gcds_ihead',gcds_ihead.text);
			
			gctr_data.post();
		}
		
	}else{
	
		alert("생성하실 정보가 없습니다.");
		
	}
	
}


/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){

	var strAccyy = gcem_saccyy.text;					//년도
  	var gisu = gclx_saccyyqt.BindColVal;				//기수
	
	var strVendid="";
	var strVendnm="";
	var strVddrect="";
	var strVendno="";
	var strAccyyqt="";                    //기수구분
	var strRptgb="";                      //신고구분


	strVendid="2218113834";
    strVendnm="현대아산 주식회사";
    strVddrect="배국환";
	strVendno="1401110011714";


	if(gisu=="1"){ 
		strAccyyqt="1";
		strRptgb="1";  
		gs_frdt = strAccyy+"0101";
		gs_todt = strAccyy+"0331";
	}else if(gisu=="2"){
		strAccyyqt="1";
		strRptgb="2";  
		gs_frdt = strAccyy+"0401";
		gs_todt = strAccyy+"0630";
	}else if(gisu=="3"){
		strAccyyqt="2";
		strRptgb="1";  
		gs_frdt = strAccyy+"0701";
		gs_todt = strAccyy+"0930";
	}else if(gisu=="4"){
		strAccyyqt="2";
		strRptgb="2";  
		gs_frdt = strAccyy+"1001";
		gs_todt = strAccyy+"1231";
	}

	gcds_ihead.Addrow();
	gcds_ihead.namevalue(gcds_ihead.rowposition,"FDCODE")="02";
    gcds_ihead.namevalue(gcds_ihead.rowposition,"FRYMD")=gs_frdt;
	gcds_ihead.namevalue(gcds_ihead.rowposition,"TOYMD")=gs_todt;
	gcds_ihead.namevalue(gcds_ihead.rowposition,"RCDGB")="A";
	gcds_ihead.namevalue(gcds_ihead.rowposition,"TAXOFF")="227";
	gcds_ihead.namevalue(gcds_ihead.rowposition,"ACCYMD")=gs_date;
	gcds_ihead.namevalue(gcds_ihead.rowposition,"SENDGB")="2";
	gcds_ihead.namevalue(gcds_ihead.rowposition,"TAXNO")=" ";  //NULL값 허용 안해서 공백넣음 ..2013.12.27 JYS
	gcds_ihead.namevalue(gcds_ihead.rowposition,"VENDID")=strVendid;
	gcds_ihead.namevalue(gcds_ihead.rowposition,"VENDNM")=strVendnm;
	gcds_ihead.namevalue(gcds_ihead.rowposition,"COREGNO")=strVendno;
	gcds_ihead.namevalue(gcds_ihead.rowposition,"VDDIRECT")=strVddrect;
	gcds_ihead.namevalue(gcds_ihead.rowposition,"POSTNO")="219812"; //24706
	gcds_ihead.namevalue(gcds_ihead.rowposition,"VDADDR")="강원도 고성군 현내면 화진포서길 10";
	gcds_ihead.namevalue(gcds_ihead.rowposition,"TELNO")="02-3669-3638";
	gcds_ihead.namevalue(gcds_ihead.rowposition,"SENDCNT")="1";
	gcds_ihead.namevalue(gcds_ihead.rowposition,"KORCD")="101";
	gcds_ihead.namevalue(gcds_ihead.rowposition,"FILLER")="";
	gcds_ihead.namevalue(gcds_ihead.rowposition,"ACCYY")=strAccyy;
	gcds_ihead.namevalue(gcds_ihead.rowposition,"ACCYYQT")=strAccyyqt;
	gcds_ihead.namevalue(gcds_ihead.rowposition,"RPTGB")=strRptgb;
}								
															   
/******************************************************************************
	Description : Report Head Clear
******************************************************************************/
function ln_SetDataHeaderClearAll(){
	gcds_ihead.ClearAll();
}

/******************************************************************************
	Description : Report Head 설정
******************************************************************************/
function ln_SetDataHeader(){

	var s_tmp1 = "FDCODE:STRING,FRYMD:STRING,TOYMD:STRING,RCDGB:STRING,TAXOFF:STRING,"
					   		+ "ACCYMD:STRING,SENDGB:STRING,TAXNO:STRING,VENDID:STRING,VENDNM:STRING,"
             				+ "COREGNO:STRING,VDDIRECT:STRING,POSTNO:STRING,VDADDR:STRING,TELNO:STRING,"
						 	+ "SENDCNT:STRING,KORCD:STRING,FILLER:STRING,ACCYY:STRING,ACCYYQT:STRING,RPTGB:STRING";
	gcds_ihead.SetDataHeader(s_tmp1);
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_RowAdd(e){

}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력
******************************************************************************/


/******************************************************************************
	Description : 내려받기
******************************************************************************/
function ln_Download(){
  var strfilenm = "H2218113.834";
	if (gcds_data99.countrow<1) {
		alert("다운로드하실 자료가 없습니다.");
	} else { 
		gcgd_data01.ExportFileEx(strfilenm,true,1,false);
 	}
}

/******************************************************************************
	Description : 내려받기
******************************************************************************/
function ln_Down_Query(){

	var strAccyy = gcem_saccyy.text;			//년도
	var gisu = gclx_saccyyqt.BindColVal;		//기수
	var strAccyyqt="";                    					//기수구분
	var strRptgb="";                      					//신고구분
	var strFrymd ="";                     					//거래기간fr
	var strToymd ="";                     					//거래기간to


	if(gcem_saccyy.text==""){
		alert("년도를 입력하십시요.");
		return;
	}


  	gcds_data99.clearAll();
	var s_temp = "DISKET:STRING";
	gcds_data99.SetDataHeader(s_temp);

	if(gisu=="1"){ 				//1기예정
		strAccyyqt="1";
		strRptgb="1";  
		strFrymd = strAccyy+"0101";
		strToymd = strAccyy+"0331";
	}else if(gisu=="2"){		//1기확정
		strAccyyqt="1";
		strRptgb="2";  
		strFrymd = strAccyy+"0401";
		strToymd = strAccyy+"0630";
	}else if(gisu=="3"){		//2기예정
		strAccyyqt="2";
		strRptgb="1";  
		strFrymd = strAccyy+"0701";
		strToymd = strAccyy+"0930";
	}else if(gisu=="4"){		//2기확정
		strAccyyqt="2";
		strRptgb="2";  
		strFrymd = strAccyy+"1001";
		strToymd = strAccyy+"1231";
	} 


	//데이터 있는지 조회....있으면...그것 조회 없으면 생성해서 보여줌..

    //A (1건)
	gcds_down_a.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050015_s1?v_str1="+strFrymd
																									        +"&v_str2="+strToymd;
																								        
	//prompt('gcds_down_a',gcds_down_a.DataID);
	gcds_down_a.Reset();

  
    //B (1건)
	gcds_down_b.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050015_s2?v_str1="+strFrymd
																									        +"&v_str2="+strToymd;
	//prompt('gcds_down_b',gcds_down_b.DataID);
	gcds_down_b.Reset();
	

	//C(2개) 매출집계, 매입집계
	gcds_down_c.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050015_s3?v_str1="+strAccyyqt
																										      +"&v_str2="+strRptgb
																													+"&v_str3="+strAccyy;

    //prompt('gcds_down_c',gcds_down_c.DataID);
	gcds_down_c.Reset();

  
	//D (N개)
    gcds_down_d.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050015_s4?v_str1="+strAccyyqt
																										      +"&v_str2="+strRptgb
																										      +"&v_str3="+strAccyy;
																										     
	//prompt('gcds_down_d',gcds_data_d.DataID);
	gcds_down_d.Reset();
  
  
  
	//E (2개) 매출집계, 매입집계
    gcds_down_e.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050015_s5?v_str1="+strAccyyqt
																										      +"&v_str2="+strRptgb
																										      +"&v_str3="+strAccyy;
																										     
	//prompt('',gcds_down_e.DataID);
	gcds_down_e.Reset();    
  
  
	ln_Display();
	
}


/******************************************************************************
	Description : 자료 내려받기 화면 display
******************************************************************************/
function ln_Display(){

  for(i=1;i<=gcds_down_a.countrow;i++){
    ln_Forward_Batch_A(i);
  }

  for(i=1;i<=gcds_down_b.countrow;i++){
    ln_Forward_Batch_B(i);
  }
  
  
  for(i=1;i<=gcds_down_c.countrow;i++){

  	if(gcds_down_c.namevalue(i,"DATADIV")=="17"){ //매출
  
		ln_Forward_Batch_C1(i);	
		
		for(j=1;j<=gcds_down_d.countrow;j++){
			if(gcds_down_d.namevalue(j,"DATADIV")=="17"){ //매출
				ln_Forward_Batch_D1(j);
			}
		}
  	 }
  }
			
  ln_Forward_Batch_E1(1);	
  
  
  for(i=1;i<=gcds_down_c.countrow;i++){
			
		if (gcds_down_c.namevalue(i,"DATADIV")=="18"){ //매입
		
		  ln_Forward_Batch_C2(i);
		  
			for(j=1;j<=gcds_down_d.countrow;j++){
				if(gcds_down_d.namevalue(j,"DATADIV")=="18"){ //매입
					ln_Forward_Batch_D2(j);
				}
			}
			
		  		
			
		}
		
 }
  
  ln_Forward_Batch_E2(2);	


    /*
	for(i=1;i<=gcds_down_c.countrow;i++){

    	if(gcds_down_c.namevalue(i,"DATADIV")=="17"){ //매출
    
			ln_Forward_Batch_C1(i);	
			
			for(j=1;j<=gcds_down_d.countrow;j++){
				if(gcds_down_d.namevalue(j,"DATADIV")=="17"){ //매출
					ln_Forward_Batch_D1(j);
				}
			}
			
			ln_Forward_Batch_E1(i);				
			
		}else if (gcds_down_c.namevalue(i,"DATADIV")=="18"){ //매입
		
		  ln_Forward_Batch_C2(i);
		  
			for(j=1;j<=gcds_down_d.countrow;j++){
				if(gcds_down_d.namevalue(j,"DATADIV")=="18"){ //매입
					ln_Forward_Batch_D2(j);
				}
			}
			
		  ln_Forward_Batch_E2(i);			
			
		}
		
   }
	*/
}


/******************************************************************************
	Description : A 
******************************************************************************/
function ln_Forward_Batch_A(i){
    var DISKET = "";
	
    DISKET+=strStr(gcds_down_a.namevalue(i,"RCDGB")   ,"1");    //레코드구분',   
	DISKET+=strStr(gcds_down_a.namevalue(i,"TAXOFF")  ,"3");    //세무서',       
	DISKET+=strStr(gcds_down_a.namevalue(i,"ACCYMD")  ,"8");    //제출년월일',   
	DISKET+=strStr(gcds_down_a.namevalue(i,"SENDGB")  ,"1");    //제출자구분',   
	DISKET+=strStr(gcds_down_a.namevalue(i,"TAXNO")   ,"6");    //세무대리인번호'
	DISKET+=strStr(gcds_down_a.namevalue(i,"VENDID")  ,"10");   //사업자등록번호'
	DISKET+=strStr(gcds_down_a.namevalue(i,"VENDNM")  ,"40");   //상호',         
	DISKET+=strStr(gcds_down_a.namevalue(i,"COREGNO") ,"13");   //법인등록번호', 
	DISKET+=strStr(gcds_down_a.namevalue(i,"VDDIRECT"),"30");   //성명(대표자)', 
	DISKET+=strStr(gcds_down_a.namevalue(i,"POSTNO")  ,"10");   //소재지우편번호'
	DISKET+=strStr(gcds_down_a.namevalue(i,"VDADDR")  ,"70");   //사업장소재지', 
	DISKET+=strStr(gcds_down_a.namevalue(i,"TELNO")   ,"15");   //전화번호',     
	DISKET+=intStr(gcds_down_a.namevalue(i,"SENDCNT") ,"5");    //제출건수계',   
	DISKET+=intStr(gcds_down_a.namevalue(i,"KORCD")   ,"3");    //사용한한글코드'
	DISKET+=strStr(gcds_down_a.namevalue(i,"FILLER")  ,"15");   //공란'          

    gcds_data99.addrow();
  
    gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}


/******************************************************************************
	Description : B 
******************************************************************************/
function ln_Forward_Batch_B(i){

    var DISKET = "";
 
	DISKET+=strStr(gcds_down_b.namevalue(i,"RCDGB")    ,"1");      //레코드구분',     
	DISKET+=strStr(gcds_down_b.namevalue(i,"TAXOFF")   ,"3");      //세무서',         
	DISKET+=intStr(gcds_down_b.namevalue(i,"SEQ")      ,"6");      //일련번호',       
	DISKET+=strStr(gcds_down_b.namevalue(i,"VENDID")   ,"10");     //사업자등록번호', 
	DISKET+=strStr(gcds_down_b.namevalue(i,"VENDNM")   ,"40");     //상호',           
	DISKET+=strStr(gcds_down_b.namevalue(i,"VDDIRECT") ,"30");     //성명(대표자)',   
	DISKET+=strStr(gcds_down_b.namevalue(i,"POSTNO")   ,"10");     //소재지우편번호', 
	DISKET+=strStr(gcds_down_b.namevalue(i,"VDADDR")   ,"70");     //사업장소재지',   
	DISKET+=strStr(gcds_down_b.namevalue(i,"FILLER")   ,"60");     //공란'            

    gcds_data99.addrow();
  
    gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}


/******************************************************************************
	Description : C1 매출용 
******************************************************************************/
function ln_Forward_Batch_C1(i){
    var DISKET = "";
    DISKET+=strStr(gcds_down_c.namevalue(i,"RCDGB")    ,"1");   //레코드구분',      
	DISKET+=intStr(gcds_down_c.namevalue(i,"DATADIV")  ,"2");   //자료구분',        
	DISKET+=strStr(gcds_down_c.namevalue(i,"ACCYYQT")  ,"1");   //기수구분',        
	DISKET+=strStr(gcds_down_c.namevalue(i,"RPTGB")    ,"1");   //신고구분',        
	DISKET+=strStr(gcds_down_c.namevalue(i,"TAXOFF")   ,"3");   //세무서',          
	DISKET+=intStr(gcds_down_c.namevalue(i,"SEQ")      ,"6");   //일련번호',        
	DISKET+=strStr(gcds_down_c.namevalue(i,"VENDID")   ,"10");  //사업자등록번호',  
	DISKET+=intStr(gcds_down_c.namevalue(i,"ACCYY")    ,"4");   //귀속년도',        
	DISKET+=intStr(gcds_down_c.namevalue(i,"FRYMD")    ,"8");   //거래시작년월일',  
	DISKET+=intStr(gcds_down_c.namevalue(i,"TOYMD")    ,"8");   //거래종료년월일',  
	DISKET+=intStr(gcds_down_c.namevalue(i,"WRYMD")    ,"8");   //작성일자',        
	DISKET+=intStr(gcds_down_c.namevalue(i,"VENDCNT")  ,"6");   //매출처수',        
	DISKET+=intStr(gcds_down_c.namevalue(i,"SHTCNT")   ,"6");   //계산서매수',      
	DISKET+=intStr(gcds_down_c.namevalue(i,"NUMEXP")   ,"1");   //음수표시',        
	DISKET+=intStr(gcds_down_c.namevalue(i,"REQAMT")   ,"14");  //금액',            
	DISKET+=intStr(gcds_down_c.namevalue(i,"VENDCNT1") ,"6");   //사업자매출처수',  
	DISKET+=intStr(gcds_down_c.namevalue(i,"SHTCNT1")  ,"6");   //사업자계산서매수',
	DISKET+=intStr(gcds_down_c.namevalue(i,"NUMEXP1")  ,"1");   //사업자음수표시',  
	DISKET+=intStr(gcds_down_c.namevalue(i,"REQAMT1")  ,"14");  //사업자금액',      
	DISKET+=intStr(gcds_down_c.namevalue(i,"VENDCNT2") ,"6");   //주민매출처수',    
	DISKET+=intStr(gcds_down_c.namevalue(i,"SHTCNT2")  ,"6");   //주민계산서매수',  
	DISKET+=intStr(gcds_down_c.namevalue(i,"NUMEXP2")  ,"1");   //주민음수표시',    
	DISKET+=intStr(gcds_down_c.namevalue(i,"REQAMT2")  ,"14");  //주민번호금액',    
	DISKET+=strStr(gcds_down_c.namevalue(i,"FILLER")   ,"97");  //공란'             
  
    gcds_data99.addrow();
    gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}

/******************************************************************************
	Description : C2 매입용 
******************************************************************************/
function ln_Forward_Batch_C2(i){
    var DISKET = "";
    DISKET+=strStr(gcds_down_c.namevalue(i,"RCDGB")    ,"1");   //레코드구분',      
	DISKET+=intStr(gcds_down_c.namevalue(i,"DATADIV")  ,"2");   //자료구분',        
	DISKET+=strStr(gcds_down_c.namevalue(i,"ACCYYQT")  ,"1");   //기수구분',        
	DISKET+=strStr(gcds_down_c.namevalue(i,"RPTGB")    ,"1");   //신고구분',        
	DISKET+=strStr(gcds_down_c.namevalue(i,"TAXOFF")   ,"3");   //세무서',          
	DISKET+=intStr(gcds_down_c.namevalue(i,"SEQ")      ,"6");   //일련번호',        
	DISKET+=strStr(gcds_down_c.namevalue(i,"VENDID")   ,"10");  //사업자등록번호',  
	DISKET+=intStr(gcds_down_c.namevalue(i,"ACCYY")    ,"4");   //귀속년도',        
	DISKET+=intStr(gcds_down_c.namevalue(i,"FRYMD")    ,"8");   //거래시작년월일',  
	DISKET+=intStr(gcds_down_c.namevalue(i,"TOYMD")    ,"8");   //거래종료년월일',  
	DISKET+=intStr(gcds_down_c.namevalue(i,"WRYMD")    ,"8");   //작성일자',        
	DISKET+=intStr(gcds_down_c.namevalue(i,"VENDCNT")  ,"6");   //매출처수',        
	DISKET+=intStr(gcds_down_c.namevalue(i,"SHTCNT")   ,"6");   //계산서매수',      
	DISKET+=intStr(gcds_down_c.namevalue(i,"NUMEXP")   ,"1");   //음수표시',        
	DISKET+=intStr(gcds_down_c.namevalue(i,"REQAMT")   ,"14");  //금액',            
	DISKET+=strStr(gcds_down_c.namevalue(i,"FILLER")   ,"151");  //공란'             

    gcds_data99.addrow();
    gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}



/******************************************************************************
	Description : D1 매출용 
******************************************************************************/
function ln_Forward_Batch_D1(i){
    var DISKET = "";
    DISKET+=strStr(gcds_down_d.namevalue(i,"RCDGB")   ,"1");   //레코드구분',        
	DISKET+=intStr(gcds_down_d.namevalue(i,"DATADIV") ,"2");   //자료구분',          
	DISKET+=strStr(gcds_down_d.namevalue(i,"ACCYYQT") ,"1");   //기수구분',          
	DISKET+=strStr(gcds_down_d.namevalue(i,"RPTGB")   ,"1");   //신고구분',          
	DISKET+=strStr(gcds_down_d.namevalue(i,"TAXOFF")  ,"3");   //세무서',            
	DISKET+=intStr(gcds_down_d.namevalue(i,"SEQ")     ,"6");   //일련번호',          
	DISKET+=strStr(gcds_down_d.namevalue(i,"VENDID")  ,"10");  //사업자등록번호',    
	DISKET+=strStr(gcds_down_d.namevalue(i,"VENDID2") ,"10");  //매출처사업자번호',
	DISKET+=strStr(gcds_down_d.namevalue(i,"VENDNM2") ,"40");  //매출처상호',      
	DISKET+=intStr(gcds_down_d.namevalue(i,"SHTCNT")  ,"5");   //계산서매수',        
	DISKET+=intStr(gcds_down_d.namevalue(i,"NUMEXP")  ,"1");   //음수표시',          
	DISKET+=intStr(gcds_down_d.namevalue(i,"REQAMT")  ,"14");   //금액',              
	DISKET+=strStr(gcds_down_d.namevalue(i,"FILLER")  ,"136"); //공란
 
    gcds_data99.addrow();
  
    gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}


/******************************************************************************
	Description : D1 매입용 
******************************************************************************/
function ln_Forward_Batch_D2(i){
	var DISKET = "";
	DISKET+=strStr(gcds_down_d.namevalue(i,"RCDGB")   ,"1");   //레코드구분',        
	DISKET+=intStr(gcds_down_d.namevalue(i,"DATADIV") ,"2");   //자료구분',          
	DISKET+=strStr(gcds_down_d.namevalue(i,"ACCYYQT") ,"1");   //기수구분',          
	DISKET+=strStr(gcds_down_d.namevalue(i,"RPTGB")   ,"1");   //신고구분',          
	DISKET+=strStr(gcds_down_d.namevalue(i,"TAXOFF")  ,"3");   //세무서',            
	DISKET+=intStr(gcds_down_d.namevalue(i,"SEQ")     ,"6");   //일련번호',          
	DISKET+=strStr(gcds_down_d.namevalue(i,"VENDID")  ,"10");  //사업자등록번호',    
	DISKET+=strStr(gcds_down_d.namevalue(i,"VENDID2") ,"10");  //매입처사업자번호',
	DISKET+=strStr(gcds_down_d.namevalue(i,"VENDNM2") ,"40");  //매입처상호',      
	DISKET+=intStr(gcds_down_d.namevalue(i,"SHTCNT")  ,"5");   //계산서매수',        
	DISKET+=intStr(gcds_down_d.namevalue(i,"NUMEXP")  ,"1");   //음수표시',          
	DISKET+=intStr(gcds_down_d.namevalue(i,"REQAMT")  ,"14");   //금액',              
	DISKET+=strStr(gcds_down_d.namevalue(i,"FILLER")  ,"136"); //공란
 
    gcds_data99.addrow();
  
    gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}


/******************************************************************************
	Description : E1 매출용 
******************************************************************************/
function ln_Forward_Batch_E1(i){
		
	//2014.04.21 jys  VENDCNT = 0 이면 return 
	if(gcds_down_e.namevalue(i,"VENDCNT")==0) return;
	
    var DISKET = "";

    DISKET+=strStr(gcds_down_e.namevalue(i,"RCDGB")    ,"1");   //레코드구분',      
	DISKET+=intStr(gcds_down_e.namevalue(i,"DATADIV")  ,"2");   //자료구분',        
	DISKET+=strStr(gcds_down_e.namevalue(i,"ACCYYQT")  ,"1");   //기수구분',        
	DISKET+=strStr(gcds_down_e.namevalue(i,"RPTGB")    ,"1");   //신고구분',        
	DISKET+=strStr(gcds_down_e.namevalue(i,"TAXOFF")   ,"3");   //세무서',          
	DISKET+=intStr(gcds_down_e.namevalue(i,"SEQ")      ,"6");   //일련번호',        
	DISKET+=strStr(gcds_down_e.namevalue(i,"VENDID")   ,"10");  //사업자등록번호',  
	DISKET+=intStr(gcds_down_e.namevalue(i,"ACCYY")    ,"4");   //귀속년도',        
	DISKET+=intStr(gcds_down_e.namevalue(i,"FRYMD")    ,"8");   //거래시작년월일',  
	DISKET+=intStr(gcds_down_e.namevalue(i,"TOYMD")    ,"8");   //거래종료년월일',  
	DISKET+=intStr(gcds_down_e.namevalue(i,"WRYMD")    ,"8");   //작성일자',        
	DISKET+=intStr(gcds_down_e.namevalue(i,"VENDCNT")  ,"6");   //매출처수',        
	DISKET+=intStr(gcds_down_e.namevalue(i,"SHTCNT")   ,"6");   //계산서매수',      
	DISKET+=intStr(gcds_down_e.namevalue(i,"NUMEXP")   ,"1");   //음수표시',        
	DISKET+=intStr(gcds_down_e.namevalue(i,"REQAMT")   ,"14");  //금액',            
	DISKET+=intStr(gcds_down_e.namevalue(i,"VENDCNT1") ,"6");   //사업자매출처수',  
	DISKET+=intStr(gcds_down_e.namevalue(i,"SHTCNT1")  ,"6");   //사업자계산서매수',
	DISKET+=intStr(gcds_down_e.namevalue(i,"NUMEXP1")  ,"1");   //사업자음수표시',  
	DISKET+=intStr(gcds_down_e.namevalue(i,"REQAMT1")  ,"14");  //사업자금액',      
	DISKET+=intStr(gcds_down_e.namevalue(i,"VENDCNT2") ,"6");   //주민매출처수',    
	DISKET+=intStr(gcds_down_e.namevalue(i,"SHTCNT2")  ,"6");   //주민계산서매수',  
	DISKET+=intStr(gcds_down_e.namevalue(i,"NUMEXP2")  ,"1");   //주민음수표시',    
	DISKET+=intStr(gcds_down_e.namevalue(i,"REQAMT2")  ,"14");  //주민번호금액',    
	DISKET+=strStr(gcds_down_e.namevalue(i,"FILLER")   ,"97");  //공란'  		
				
    gcds_data99.addrow();
  
    gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}


/******************************************************************************
	Description : E2 매입용 
******************************************************************************/
function ln_Forward_Batch_E2(i){
    var DISKET = "";

    DISKET+=strStr(gcds_down_e.namevalue(i,"RCDGB")    ,"1");   //레코드구분',      
	DISKET+=intStr(gcds_down_e.namevalue(i,"DATADIV")  ,"2");   //자료구분',        
	DISKET+=strStr(gcds_down_e.namevalue(i,"ACCYYQT")  ,"1");   //기수구분',        
	DISKET+=strStr(gcds_down_e.namevalue(i,"RPTGB")    ,"1");   //신고구분',        
	DISKET+=strStr(gcds_down_e.namevalue(i,"TAXOFF")   ,"3");   //세무서',          
	DISKET+=intStr(gcds_down_e.namevalue(i,"SEQ")      ,"6");   //일련번호',        
	DISKET+=strStr(gcds_down_e.namevalue(i,"VENDID")   ,"10");  //사업자등록번호',  
	DISKET+=intStr(gcds_down_e.namevalue(i,"ACCYY")    ,"4");   //귀속년도',        
	DISKET+=intStr(gcds_down_e.namevalue(i,"FRYMD")    ,"8");   //거래시작년월일',  
	DISKET+=intStr(gcds_down_e.namevalue(i,"TOYMD")    ,"8");   //거래종료년월일',  
	DISKET+=intStr(gcds_down_e.namevalue(i,"WRYMD")    ,"8");   //작성일자',        
	DISKET+=intStr(gcds_down_e.namevalue(i,"VENDCNT")  ,"6");   //매출처수',        
	DISKET+=intStr(gcds_down_e.namevalue(i,"SHTCNT")   ,"6");   //계산서매수',      
	DISKET+=intStr(gcds_down_e.namevalue(i,"NUMEXP")   ,"1");   //음수표시',        
	DISKET+=intStr(gcds_down_e.namevalue(i,"REQAMT")   ,"14");  //금액',            
	DISKET+=strStr(gcds_down_e.namevalue(i,"FILLER")   ,"151");  //공란' 		
		
		
    gcds_data99.addrow();
  
    gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}


/******************************************************************************
	Description : 문자타입 공백 처리함.
******************************************************************************/
function strStr(a, b){
  var returnVal = "";
  if(a==null) a = "";
  var alength = calculateBytes(a);
  var tt = calculateBytesStr(a,b);

  if(alength<=b){
    returnVal+=a;
    for(var i=0; i<b-alength; i++){
      returnVal+=" ";
    }
  }else{
    returnVal = tt;
  }
  return returnVal;
}

/******************************************************************************
	Description : 숫자타입 공백 0으로 처리함.
******************************************************************************/
function intStr(a, b){

  var tmpa = new String(a);
  var returnVal="";
  if(a==null) a="";

  var alength=tmpa.length;

  if(alength<b){
    for(var i=0; i<b-alength; i++){
      returnVal+="0";
    }
  }
  returnVal+=a;

  return returnVal;
}

/******************************************************************************
	Description : 숫자타입 공백 0으로 처리함.
******************************************************************************/
function minorintStr(a, b){
  var returnVal="";
  if(a==null) a="";
  var temp = "";  
  var rst = "";
  if(a<0){
    a = strReplace(a, "-", "0");

    for(var k=0; k<a.length; k++){
      temp = a.charAt(k);
      if(k+1==a.length){
        temp=strReplace(temp, "0","}");
        temp=strReplace(temp, "1","J");
        temp=strReplace(temp, "2","K");
        temp=strReplace(temp, "3","L");
        temp=strReplace(temp, "4","M");
        temp=strReplace(temp, "5","N");
        temp=strReplace(temp, "6","O");
        temp=strReplace(temp, "7","P");
        temp=strReplace(temp, "8","Q");
        temp=strReplace(temp, "9","R");
      }
      rst += temp;
    }
  }else{
    rst = a;
  }

  var alength=rst.length;
  if(alength<b){
    for(var i=0; i<b-alength; i++){
      returnVal+="0";
    }
  }
  returnVal+=rst;
  return returnVal;
}

/******************************************************************************
	Description : 바이트 처리 
******************************************************************************/
function calculateBytes(szValue){

  var tcount = 0;
  var tmpStr = new String(szValue);
  var temp = tmpStr.length;
  var onechar;
  for ( k=0; k<temp; k++ ){
    onechar = tmpStr.charAt(k);
    if (escape(onechar).length > 4){
      tcount += 2;
    }
    else{
      tcount += 1;
    }
  }
  return tcount;
}

function calculateBytesStr(szValue,b){

  var tcount = 0;
  var tstr = "";
  var tmpStr = new String(szValue);
  var temp = tmpStr.length;
  var onechar;
  for ( k=0; k<temp; k++ ){
    onechar = tmpStr.charAt(k);
    if (escape(onechar).length > 4){
      tcount += 2;
      tstr += onechar;
    }
    else{
      tcount += 1;
      tstr += onechar;
    }
    if(tcount==b) break;
  }
  return tstr;
}

function strReplace(str, src, dest) {
  var reg = new RegExp(src, "gi");
  return str.replace(reg, dest);
}

/******************************************************************************
	Description : 엑셀 다운로드
******************************************************************************/
function ln_Excel(){

	gcgd_disp01.GridToExcel("계산서합계표","",2);
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=gcds_data_a classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_data_b classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_data_c classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_data_d classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_data_e classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!--입력관련  -->
<object  id=gcds_ihead classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--내려받기 -->
<object  id=gcds_down_a classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_down_b classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_down_c classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_down_d classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_down_e classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_data99 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>



</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_data_c" event="onloadCompleted(row,colid)">
    
	if(row>=1){
		ln_Setting_C();
		//ln_Setting_E();
		//ln_Setting_sum();
	}
</script>

<script language="javascript" for="gcds_data_e" event="onloadCompleted(row,colid)">

	if(row>=1){
		ln_Setting_E();
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
 <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a050015_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif" align="right">&nbsp;</td>
	</tr>
	<tr><td height=4></td></tr>
</table>

<!--  ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:20px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>년&nbsp;&nbsp;&nbsp;&nbsp;도</nobr></td>
					<td class="tab23" style="width:255px"><comment id="__NSID__">
						<object id=gcem_saccyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px;width:35px;height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>&nbsp;분&nbsp;기&nbsp;수&nbsp;</nobr></td>
					<td style="width:100px;"><nobr><comment id="__NSID__">
						<object  id=gclx_saccyyqt classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:90px;height:110px;">
							<param name=CBData						value="1^1기예정,2^1기확정,3^2기예정,4^2기확정">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn			value="CDNAM">
							<param name=Sort							value="false">
							<param name=ListExprFormat			value="CDNAM^0^90">
							<param name=BindColumn				value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
					</td>
					<td align="right">&nbsp;<nobr>      
						<!-- <img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('01')"> -->
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px"	onclick="ln_Excel()">
						<img src="../../Common/img/btn/com_b_create.gif"  style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Create()">
						<img src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query()"> 
						</nobr>
					</td>
				</tr>
			</table>
				</td>
			</tr>
			<tr>
				<td style="position:relative;left:6px">
					<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>상호(법인명)</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object id=gcem_vendnm_a classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:230px">
									<param name=Text				value="">
									<param name=Alignment		value=0>
									<param name=Border			value=true>
									<param name=GeneralEdit value="true">
									<param name=Language		value=1>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>사업자등록번호</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_vendid_a classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=BackColor     value="#CCCCCC">
									<param name=Format			  value="000-00-00000">
									<param name=PromptChar	  value="_">
									<param name=InheritColor  value=false>
									<param name=ReadOnly      value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>대표자명</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object  id=gcem_vddirect_a classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:230px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
									<param name=ReadOnly      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>법인등록번호</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_coregno_a classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=Format			  value="000000-0000000">
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
									<param name=ReadOnly      value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>거래기간</nobr></td>
							<td class="tab23" style="width:256px"><comment id="__NSID__">
								<object  id=gcem_frymd_a classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=Format			  value="0000-00-00">
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
									<param name=ReadOnly      value=true>
								</object>&nbsp;~&nbsp;
								<object  id=gcem_toymd_a classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=Format			  value="0000-00-00">
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
									<param name=ReadOnly      value=true>
								</object>
								</comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>소재지</nobr></td>
							<td style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_postno_a classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=Format			  value="000-000">
									<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
									<param name=ReadOnly      value=true>
								</object>&nbsp;
								
								<object  id=gcem_vdaddr_a classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:300px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
									<param name=ReadOnly      value=true>
								</object>
								
								</comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td style="position:relative;left:6px;top:2px">
					<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
						<tr>
							<td class="tab11" bgcolor="#eeeeee" rowspan="2"><nobr>구&nbsp;&nbsp;&nbsp;&nbsp;분</nobr></td>
							<td class="tab11" bgcolor="#eeeeee" colspan="3" ><nobr>매출처/매입처 수</nobr></td>
							<td class="tab11" bgcolor="#eeeeee" colspan="3" ><nobr>계산서매수</nobr></td>
							<td class="tab11" bgcolor="#eeeeee" colspan="3" ><nobr>금&nbsp;&nbsp;&nbsp;&nbsp;액</nobr></td>
							<td class="tab13" bgcolor="#eeeeee" rowspan="2"><nobr>비&nbsp;&nbsp;&nbsp;&nbsp;고</nobr></td>
						</tr>
						<tr>
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>수기</nobr></td>
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>전자</nobr></td>
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>합계</nobr></td>							
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>수기</nobr></td>
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>전자</nobr></td>
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>합계</nobr></td>														
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>수기</nobr></td>
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>전자</nobr></td>
							<td class="tab11" style="width:173px;" bgcolor="#eeeeee"><nobr>합계</nobr></td>														
						</tr>						
						
						<tr>
							<td class="tab11" style="width:173px;"><nobr>매출합계</nobr></td>
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt_B classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text			value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	    value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	    value=true>
									<param name=ReadOnly        value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt_B2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>							

							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt_B_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=readOnlyBackColor	value="Orange">									
									<param name=PromptChar	value="_">
									<param name=Numeric		value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>							
							
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt_B  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>

							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt_B2  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>							

							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt_B_sum  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=readOnlyBackColor	value="Orange">								
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>							
							
							<td class="tab11" style="width:100px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt_B  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:100px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							
							<td class="tab11" style="width:100px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt_B2  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:100px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>	
													
							<td class="tab11" style="width:100px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt_B_sum  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:100px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=readOnlyBackColor	value="Orange">									
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>							
							
							 <td class="tab22" style="width:173px;"><nobr>&nbsp;</nobr>
							 </td>
						</tr>
             <tr>
              <td class="tab11" style="width:173px;"><nobr>매출사업자번호</nobr></td>
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt1_B classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt1_B2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>							
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt1_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>	
														
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt1_B classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt1_B2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>							
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt1_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>		
													
							<td class="tab11" style="width:100px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt1_B classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:100px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							<td class="tab11" style="width:100px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt1_B2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:100px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>							
							<td class="tab11" style="width:100px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt1_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:100px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>							
							
							<td class="tab22" style="width:173px;"><nobr>&nbsp;</nobr></td>
						</tr>
						<tr>
							<td class="tab11" style="width:173px;"><nobr>매출주민번호</nobr></td>
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt2_B classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt2_B2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>							
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt2_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
														
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt2_B classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt2_B2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>							
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt2_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>	
														
							<td class="tab11" style="width:100px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt2_B classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:100px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							<td class="tab11" style="width:100px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt2_B2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:100px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>							
							<td class="tab11" style="width:100px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt2_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:100px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>								
							
							<td  class="tab22" style="width:173px;"><nobr>&nbsp;</nobr></td>
						</tr>
						
						
						<tr>
							<td class="tab11" bgcolor="#eeeeee"><nobr>구&nbsp;&nbsp;&nbsp;&nbsp;분</nobr></td>
							<td class="tab11" bgcolor="#eeeeee"><nobr>수기</nobr></td>
							<td class="tab11" bgcolor="#eeeeee"><nobr>전자</nobr></td>
							<td class="tab11" bgcolor="#eeeeee"><nobr>합계</nobr></td>							
							<td class="tab11" bgcolor="#eeeeee"><nobr>수기</nobr></td>
							<td class="tab11" bgcolor="#eeeeee"><nobr>전자</nobr></td>
							<td class="tab11" bgcolor="#eeeeee"><nobr>합계</nobr></td>														
							<td class="tab11" bgcolor="#eeeeee"><nobr>수기</nobr></td>
							<td class="tab11" bgcolor="#eeeeee"><nobr>전자</nobr></td>
							<td class="tab11" bgcolor="#eeeeee"><nobr>합계</nobr></td>		
							<td class="tab13" bgcolor="#eeeeee"><nobr>비&nbsp;&nbsp;&nbsp;&nbsp;고</nobr></td>																			
						</tr>								
						
						
            			<tr>
							<td class="tab11" style="width:173px;"><nobr>매입합계</nobr></td>
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt_A classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt_A2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>							
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_vendcnt_A_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="0,000,000">
									<param name=readOnlyBackColor	value="Orange">									
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
														
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt_A classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt_A2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>							
							<td class="tab11" style="width:50px;"><nobr><comment id="__NSID__">
								<object id=gcem_shtcnt_A_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:50px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=readOnlyBackColor	value="Orange">									
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
														
							<td class="tab11" style="width:100px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt_A classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:100px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>						
							<td class="tab11" style="width:100px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt_A2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:100px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>							
							<td class="tab11" style="width:100px;"><nobr><comment id="__NSID__">
								<object id=gcem_reqamt_A_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:100px">
									<param name=Text				value="">
									<param name=Alignment		value=2>
									<param name=Border			value=true>
									<param name=Format			value="000,000,000,000,000">
									<param name=readOnlyBackColor	value="Orange">									
									<param name=PromptChar	value="_">
									<param name=Numeric			value=true>
									<param name=IsComma   	value=true>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>							
							
						    <td class="tab22" style="width:173px;"><nobr>&nbsp;</nobr></td>		
						 </tr>
        </table>
				</td>
			</tr>
			<tr>
				<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr><td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:220px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data_d">
							<PARAM NAME="Editable"			VALUE="false">
							<PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM NAME="IndWidth"			VALUE="0">
							<PARAM NAME="ColSizing"			VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name=SortView        value="Left">
							<PARAM NAME="viewSummary"		VALUE="1">
							<PARAM NAME="Format"        VALUE="  
  							<C> Name='일련번호'	      				ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	   	align=center	SumText=@count	SumBgColor='#C3D0DB' </C> 
								<C> Name='구분'   	     				ID=DATADIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=100		align=center	EditStyle=Combo		Data='17:매출,18:매입'	  SumBgColor='#C3D0DB' sort=true </C>
								<C> Name='사업자등록번호'			ID=VENDID2 		HeadAlign=Center HeadBgColor=#B9D4DC Width=125		align=center	SumText='계'	  	SumBgColor='#C3D0DB' sort=true mask='XXX-XX-XXXXX'   </C>
								<C> Name='상호'	        				ID=VENDNM2	HeadAlign=Center HeadBgColor=#B9D4DC Width=295	  	align=left  		SumText=''   	  	SumBgColor='#C3D0DB' sort=true </C>
								<C> Name='계산서매수'				ID=SHTCNT		HeadAlign=Center HeadBgColor=#B9D4DC Width=120		align=right		SumText=@sum	  SumBgColor='#C3D0DB' sort=true </C>
								<C> Name='금액'	      	  				ID=REQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=145		align=right		SumText=@sum	  SumBgColor='#C3D0DB' sort=true </C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<tr>
			</table>			
		</td> 
	</tr> 
	<tr>
    <td>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
				<tr>
					<td style="width:173px;position:relative;left:5px;top:3px"><nobr><FONT SIZE="2" COLOR="blue"><B>[내려받기]</B></FONT></nobr></td>
					<td align="right">&nbsp;<nobr>      
						<img src="../../Common/img/btn/com_b_down.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onclick="ln_Download()">
						<img src="../../Common/img/btn/com_b_query.gif"	    style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Down_Query()"> 
						</nobr>
					</td>
				</tr>
				<tr>
					<td colspan =2>
						<comment id="__NSID__">
						<OBJECT id=gcgd_data01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="width:867px;height:160px;position:relative;left:5px;border:1 solid #777777;">
							<PARAM NAME="DataID"		VALUE="gcds_data99">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle"   VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<param name="ColSelect"		value="false">
							<param name="ColSizing"		value="true">
							<PARAM NAME="Format"		VALUE="  
								<C> Name=''	ID=DISKET	HeadAlign=Center HeadBgColor=#B9D4DC Width=843	align=left</C>
							">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table> 
			 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [HEAD]
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_head classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data_a>
	<param name=BindInfo		value='  
		<C>Col=VENDNM			Ctrl=gcem_vendnm_a				Param=text</C>
		<C>Col=VENDID			Ctrl=gcem_vendid_a				Param=text</C>
		<C>Col=VDDIRECT	  	    Ctrl=gcem_vddirect_a			Param=text</C>
		<C>Col=COREGNO		    Ctrl=gcem_coregno_a		  	    Param=text</C>
		<C>Col=POSTNO	  		Ctrl=gcem_postno_a			  	Param=text</C>
		<C>Col=VDADDR 			Ctrl=gcem_vdaddr_a			  	Param=text</C>
		<C>Col=FRYMD	  		Ctrl=gcem_frymd_a		  	  	Param=text</C>
		<C>Col=TOYMD  			Ctrl=gcem_toymd_a			    Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 