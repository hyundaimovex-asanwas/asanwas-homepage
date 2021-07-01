<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  연말정산 - 근로소득 지급명세서 파일 생성
+ 프로그램 ID	:  p030030.html
+ 기 능 정 의	:  연말정산 근로소득 지급명세 파일생성 (퇴사자 포함)
+ 작   성  자 :  정 영 식
+ 작   성  자 :  작 성 일 자 : 2011.02.14
+ 서 블 릿 명	:	 
------------------------------------------------------------------------------>
<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>근로소득 지급명세서 전산제출파일 생성</title>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>


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
get_cookdata();
//var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
//var gs_date2  = gcurdate.substring(0,4);
//var gs_date3  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
//var gs_userid = gusrid;		//user_id

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
	gcem_saccyy.text = "2010";	//귀속년도
	gcem_vendnm0.text="현대아산 주식회사";
	gcem_vendid0.text="2218113834";
	gcem_vddirect0.text="장경작";
	gcem_vendno0.text="1401110011714";
}

/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(e){
  var str1 = gcem_saccyy.text;					//년도

  if(gcem_saccyy.text==""){
		alert("년도를 입력하십시요.");
		return;
	}
  gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030030_s1?v_str1="+str1;																							
	gcds_data.Reset();
  
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
	Description : 연말정산 급여반영
*****************************************************************************************/
function ln_Ycpay(){

  alert("귀속년도 2010 데이터를 2011년 2월급여에 반영했습니다.");
	return;

  ln_SetDataHeader();
	ln_Add();

	var strAppdt="201102";

	if(strAppdt==""){
		alert("급여년월을 입력하십시요..");
	}

	if (confirm("귀속년도 "+gcem_saccyy.text+"년 연말정산 결과를 "+strAppdt+"월 급여에 반영하시겠습니까?")){	
			gctr_data99.KeyValue = "Payroll.p030030_t3(I:USER=gcds_ihead)";
			gctr_data99.Action   = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030030_t3";
			gctr_data99.Parameters = "v_str1="+strAppdt;
			//prompt('gcds_ihead',gcds_ihead.text);

			//alert("strAppdt::"+strAppdt);
    
			gctr_data99.post();
		}
}


/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){
	gcds_ihead.Addrow();
	gcds_ihead.namevalue(gcds_ihead.rowposition,"APPYY")=gcem_saccyy.text;
}
/******************************************************************************************
	Description : 생성 A B C D 레코드 생성 
*****************************************************************************************/
function ln_Create(){

  //alert("귀속년도 2010 전산매체를 생성했습니다.");
	//return;

	ln_SetDataHeader();
	ln_Add();

	if(gcds_ihead.IsUpdated) {	
		if (confirm("귀속년도 "+gcem_saccyy.text+"년 근로소득 전산매체를 생성 하시겠습니까?")){	
			gctr_data.KeyValue = "Payroll.p030030_t0(I:USER=gcds_ihead)";
			gctr_data.Action   = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030030_t0";
			//gctr_data.Parameters = "v_str1="+gs_frdt+",v_str2="+gs_todt;
			//prompt('gcds_ihead',gcds_ihead.text);
			gctr_data.post();
		}
	}else{
		alert("생성하실 정보가 없습니다.");
	}
}


/******************************************************************************************
	Description : 생성 E 레코드 생성 
*****************************************************************************************/
function ln_Create2(){

  ln_SetDataHeader();
	ln_Add();
	gctr_data1.KeyValue = "Payroll.p030030_t1(I:USER=gcds_ihead)";
	gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030030_t1";

	//prompt('22',gcds_ihead.text);
	gctr_data1.post();
}


/******************************************************************************************
	Description : 생성 F 레코드 생성 
*****************************************************************************************/
function ln_Create3(){
  ln_SetDataHeader();
	ln_Add();
	gctr_data2.KeyValue = "Payroll.p030030_t2(I:USER=gcds_ihead)";
	gctr_data2.Action   = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030030_t2";
	//prompt('33',gcds_ihead.text);
	gctr_data2.post();
}

/******************************************************************************
	Description : Report Head 설정
******************************************************************************/
function ln_SetDataHeader(){

	var s_tmp1 = "APPYY:STRING";
	gcds_ihead.SetDataHeader(s_tmp1);

  /**
  var s_tmp2 = "REFNO:STRING,FDCODE:STRING,RCDGB:STRING,ACCYY:STRING,ACCHF:STRING,"
					   + "HALFNO:STRING,VENDID:STRING,CARDGB:STRING,CARDNO:STRING,AFVENDID:STRING,"
						 + "VCNT:DECIMAL,NUMEXP1:STRING,REQAMT:DECIMAL,NUMEXP2:STRING,TAXAMT:DECIMAL,FILLER:STRING";
	gcds_idata.SetDataHeader(s_tmp2);


	var s_tmp3 = "FDCODE:STRING,RCDGB:STRING,ACCYY:STRING,ACCHF:STRING,HALFNO:STRING,"
					   + "VENDID:STRING,DCNT:DECIMAL,TVCNT:DECIMAL,NUMEXP1:STRING,TREQAMT:DECIMAL,"
						 + "NUMEXP2:STRING,TTAXAMT:DECIMAL,FILLER:STRING";
	gcds_itail.SetDataHeader(s_tmp3);
	**/
	
}


function ln_SetDataHeader2(){

	var s_tmp1 = "DISKET:STRING(1245)";
	gcds_create_file.SetDataHeader(s_tmp1);
	
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
  var strfilenm = "C2218113.834";
	if (gcds_create_file.countrow<1) {
		alert("다운로드하실 자료가 없습니다.");
	} else { 
		gcgd_data01.ExportFileEx(strfilenm,true,1,false);
 	}
}

/******************************************************************************
	Description : 내려받기
******************************************************************************/
function ln_Down_Query(){
	var str1 = gcem_saccyy.text;					//년도

	if(gcem_saccyy.text==""){
		alert("년도를 입력하십시요.");
		return;
	}

  //파일생성
  gcds_create_file.clearAll();

	ln_SetDataHeader2();
	//var s_temp = "DISKET:STRING";
	//gcds_create_file.SetDataHeader(s_temp);


	//데이터 있는지 조회....있으면...그것 조회 없으면 생성해서 보여줌..
	//A RECODE (1건)
	gcds_recode_a.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030030_s2?v_str1="+str1;
	gcds_recode_a.Reset();

  
	//B RECODE (1건)
	gcds_recode_b.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030030_s3?v_str1="+str1;
	gcds_recode_b.Reset();


	//C RECODE (근로소득자)
	gcds_recode_c.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030030_s4?v_str1="+str1;
	gcds_recode_c.Reset();

 
	//D RECODE (종전근무)
	gcds_recode_d.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030030_s5?v_str1="+str1;
	gcds_recode_d.Reset();


	//E RECODE (명세서)
	gcds_recode_e.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030030_s6?v_str1="+str1;
	gcds_recode_e.Reset();

   
	//F RECODE (연금저축등상세)
	gcds_recode_f.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030030_s7?v_str1="+str1;
	gcds_recode_f.Reset();

  //alert("gcds_recode_f::"+gcds_recode_f.countrow);

	ln_Display();
}


/******************************************************************************
	Description : 자료 내려받기 화면 display
******************************************************************************/
function ln_Display(){
 
 // ln_SetDataHeader2();

	var intd=1;
	var inte=1;
  var intf=1;

  for(i=1;i<=gcds_recode_a.countrow;i++){
    ln_Forward_Batch_A(i);
  }


	for(i=1;i<=gcds_recode_b.countrow;i++){
    ln_Forward_Batch_B(i);
  }

	//ln_Forward_Batch_C(1);
	for(i=1;i<=gcds_recode_c.countrow;i++){
    ln_Forward_Batch_C(i);
    
		  //종전근무지 D레코드
     	d_out:  
			for(var d=intd;d<=gcds_recode_d.countrow;d++){
				if(gcds_recode_c.namevalue(i,"C004")==gcds_recode_d.namevalue(d,"D004")){
					 ln_Forward_Batch_D(d);
					 intd+=1;
					 break d_out;
				}
			}

			//소득공제명 E레코드
			//E1
			e1_out:  
			for(var e=inte;e<=gcds_recode_e.countrow;e++){
				if(gcds_recode_c.namevalue(i,"C004")==gcds_recode_e.namevalue(e,"E004")){		
					 ln_Forward_Batch_E(e);
					 inte+=1;
					 break e1_out;
				}	
			}

      //E2
			e2_out:  
			for(var e=inte;e<=gcds_recode_e.countrow;e++){
				if(gcds_recode_c.namevalue(i,"C004")==gcds_recode_e.namevalue(e,"E004")){		
					 ln_Forward_Batch_E(e);
					 inte+=1;
					 break e2_out;
				}	
			}

		
		  //연금저축 F레코드
			f_out:  
			for(var f=intf;f<=gcds_recode_f.countrow;f++){
				if(gcds_recode_c.namevalue(i,"C004")==gcds_recode_f.namevalue(f,"F004")){		
					 ln_Forward_Batch_F(f);
					 intf+=1;
					 break f_out;
				}	
			}
  }
	


/**
  for(i=1;i<=gcds_down_data.countrow;i++){
    ln_Forward_Batch_data(i);
  }

	for(i=1;i<=gcds_down_tail.countrow;i++){
    ln_Forward_Batch_tail(i);
  }

  **/
}


/******************************************************************************
	Description : A 레코드 생성
******************************************************************************/
function ln_Forward_Batch_A(i){
  var DISKET = "";
	
  DISKET+=strStr(gcds_recode_a.namevalue(i,"A001")  ,"1");     //
  DISKET+=intStr(gcds_recode_a.namevalue(i,"A002")  ,"2");     //
  DISKET+=strStr(gcds_recode_a.namevalue(i,"A003")  ,"3");     //
  DISKET+=intStr(gcds_recode_a.namevalue(i,"A004")  ,"8");     //
  DISKET+=intStr(gcds_recode_a.namevalue(i,"A005")  ,"1");     //
  DISKET+=strStr(gcds_recode_a.namevalue(i,"A006")  ,"6");     //
  DISKET+=strStr(gcds_recode_a.namevalue(i,"A007")  ,"20");    //
  DISKET+=strStr(gcds_recode_a.namevalue(i,"A008")  ,"4");     //
  DISKET+=strStr(gcds_recode_a.namevalue(i,"A009")  ,"10");    //
	DISKET+=strStr(gcds_recode_a.namevalue(i,"A010")  ,"40");    //
	DISKET+=strStr(gcds_recode_a.namevalue(i,"A011")  ,"30");    //
	DISKET+=strStr(gcds_recode_a.namevalue(i,"A012")  ,"30");    //
	DISKET+=strStr(gcds_recode_a.namevalue(i,"A013")  ,"15");    //
	DISKET+=intStr(gcds_recode_a.namevalue(i,"A014")  ,"5");     //
	DISKET+=intStr(gcds_recode_a.namevalue(i,"A015")  ,"3");     //
	DISKET+=strStr(gcds_recode_a.namevalue(i,"A016")  ,"1067");  //
  
	gcds_create_file.addrow();
  gcds_create_file.namevalue(gcds_create_file.countrow,"DISKET") = DISKET;
}


/******************************************************************************
	Description : B 레코드 생성
******************************************************************************/
function ln_Forward_Batch_B(i){
  var DISKET = "";
  DISKET+=strStr(gcds_recode_b.namevalue(i,"B001")  ,"1");     //
  DISKET+=intStr(gcds_recode_b.namevalue(i,"B002")  ,"2");     //
  DISKET+=strStr(gcds_recode_b.namevalue(i,"B003")  ,"3");     //
  DISKET+=intStr(gcds_recode_b.namevalue(i,"B004")  ,"6");     //
  DISKET+=strStr(gcds_recode_b.namevalue(i,"B005")  ,"10");    //
  DISKET+=strStr(gcds_recode_b.namevalue(i,"B006")  ,"40");    //
  DISKET+=strStr(gcds_recode_b.namevalue(i,"B007")  ,"30");    //
  DISKET+=strStr(gcds_recode_b.namevalue(i,"B008")  ,"13");    //
  DISKET+=intStr(gcds_recode_b.namevalue(i,"B009")  ,"7");     //
	DISKET+=intStr(gcds_recode_b.namevalue(i,"B010")  ,"7");     //
	DISKET+=intStr(gcds_recode_b.namevalue(i,"B011")  ,"14");    //
	DISKET+=intStr(gcds_recode_b.namevalue(i,"B012")  ,"13");    //
	DISKET+=intStr(gcds_recode_b.namevalue(i,"B013")  ,"13");    //
	DISKET+=intStr(gcds_recode_b.namevalue(i,"B014")  ,"13");    //
	DISKET+=intStr(gcds_recode_b.namevalue(i,"B015")  ,"13");    //
	DISKET+=intStr(gcds_recode_b.namevalue(i,"B016")  ,"13");    //
	DISKET+=intStr(gcds_recode_b.namevalue(i,"B017")  ,"1");     //
	DISKET+=strStr(gcds_recode_b.namevalue(i,"B018")  ,"1046");  //
  
	gcds_create_file.addrow();
  gcds_create_file.namevalue(gcds_create_file.countrow,"DISKET") = DISKET;
}



/******************************************************************************
	Description : C 레코드 생성
******************************************************************************/
function ln_Forward_Batch_C(i){
  var DISKET = "";

  DISKET+=strStr(gcds_recode_c.namevalue(i,"C001")  ,"1" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C002")  ,"2" );    //
  DISKET+=strStr(gcds_recode_c.namevalue(i,"C003")  ,"3" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C004")  ,"6" );    //
  DISKET+=strStr(gcds_recode_c.namevalue(i,"C005")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C006")  ,"2" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C007")  ,"1" );    //
  DISKET+=strStr(gcds_recode_c.namevalue(i,"C008")  ,"2" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C009")  ,"1" );    //
	DISKET+=strStr(gcds_recode_c.namevalue(i,"C010")  ,"30");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C011")  ,"1" );    //
	DISKET+=strStr(gcds_recode_c.namevalue(i,"C012")  ,"13");    //
	DISKET+=strStr(gcds_recode_c.namevalue(i,"C013")  ,"2" );    //
	DISKET+=strStr(gcds_recode_c.namevalue(i,"C014")  ,"1" );    //
	DISKET+=strStr(gcds_recode_c.namevalue(i,"C015")  ,"1" );    //
	DISKET+=strStr(gcds_recode_c.namevalue(i,"C016")  ,"10");    //
	DISKET+=strStr(gcds_recode_c.namevalue(i,"C017")  ,"40");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C018")  ,"8" );    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C019")  ,"8" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C020")  ,"8" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C021")  ,"8" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C022")  ,"11");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C023")  ,"11");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C024")  ,"11");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C025")  ,"11");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C026")  ,"11");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C027")  ,"22");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C028")  ,"11");    //
	//비과세
  DISKET+=intStr("0","10");    //C029
	DISKET+=intStr("0","10");    //C030
	DISKET+=intStr("0","10");    //C031
	DISKET+=intStr("0","10");    //C032
	DISKET+=intStr("0","10");    //C033
	DISKET+=intStr("0","10");    //C034
	DISKET+=intStr("0","10");    //C035
	DISKET+=intStr("0","10");    //C036
	DISKET+=intStr("0","10");    //C037
	DISKET+=intStr("0","10");    //C038
	DISKET+=intStr("0","10");    //C039
	DISKET+=intStr("0","10");    //C040
	DISKET+=intStr("0","10");    //C041
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C042")  ,"10");    //
  DISKET+=intStr("0","10");    //C043
	DISKET+=intStr("0","10");    //C044
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C045")  ,"10");    //
	DISKET+=intStr("0","10");    //C046
	DISKET+=intStr("0","10");    //C047
	DISKET+=intStr("0","10");    //C048
	DISKET+=intStr("0","10");    //C049
	DISKET+=intStr("0","10");    //C050
	DISKET+=intStr("0","10");    //C051
	DISKET+=intStr("0","10");    //C052
	DISKET+=intStr("0","10");    //C053
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C054")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C055")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C056")  ,"11");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C057")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C058")  ,"11");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C059")  ,"8" );    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C060")  ,"8" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C061")  ,"2" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C062")  ,"8" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C063")  ,"2" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C064")  ,"8" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C065")  ,"2" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C066")  ,"8" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C067")  ,"8" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C068")  ,"2" );    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C069")  ,"8" );    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C070")  ,"2" );    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C071")  ,"8" );    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C072")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C073")  ,"2" );    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C074")  ,"8" );    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C075")  ,"10");    //
  DISKET+=intStr("0","10");    //C076
	DISKET+=intStr("0","10");    //C077
	DISKET+=intStr("0","10");    //C078
	DISKET+=intStr("0","10");    //C079
	DISKET+=intStr("0","10");    //C080
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C081")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C082")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C083")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C084")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C085")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C086")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C087")  ,"8" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C088")  ,"8" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C089")  ,"8" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C090")  ,"8" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C091")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C092")  ,"20");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C093")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C094")  ,"8" );    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C095")  ,"11");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C096")  ,"8" );    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C097")  ,"8" );    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C098")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C099")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C100")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C101")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C102")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C103")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C104")  ,"8" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C105")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C106")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C107")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C108")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C109")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C110")  ,"11");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C111")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C112")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C113")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C114")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C115")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C116")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C117")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C118")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C119")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C120")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C121")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C122")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C123")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C124")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C125")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C126")  ,"10");    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C127")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C128")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C129")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C130")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C131_1"),"1" );    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C131")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C132_1"),"1" );    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C132")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C133_1"),"1" );    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C133")  ,"10");    //
	DISKET+=intStr(gcds_recode_c.namevalue(i,"C134_1"),"1" );    //
  DISKET+=intStr(gcds_recode_c.namevalue(i,"C134")  ,"10");    //
  DISKET+=strStr(gcds_recode_c.namevalue(i,"C135")  ,"3");  //
 
	gcds_create_file.addrow();
  gcds_create_file.namevalue(gcds_create_file.countrow,"DISKET") = DISKET;
}


/******************************************************************************
	Description : D 레코드 생성
******************************************************************************/
function ln_Forward_Batch_D(i){
  var DISKET = "";

 // if(strBseq==gcds_recode_d.namevalue(i,"D004")){ //일련번호가 동일할 경우만 적용
		DISKET+=strStr(gcds_recode_d.namevalue(i,"D001")  ,"1" );    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D002")  ,"2" );    //
		DISKET+=strStr(gcds_recode_d.namevalue(i,"D003")  ,"3" );    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D004")  ,"6" );    //
		DISKET+=strStr(gcds_recode_d.namevalue(i,"D005")  ,"10");    //
		DISKET+=strStr(gcds_recode_d.namevalue(i,"D006")  ,"50");    //
		DISKET+=strStr(gcds_recode_d.namevalue(i,"D007")  ,"13");    //
		DISKET+=strStr(gcds_recode_d.namevalue(i,"D008")  ,"1" );    //
		DISKET+=strStr(gcds_recode_d.namevalue(i,"D009")  ,"40");    //
		DISKET+=strStr(gcds_recode_d.namevalue(i,"D010")  ,"10");    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D011")  ,"8" );    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D012")  ,"8" );    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D013")  ,"8" );    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D014")  ,"8" );    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D015")  ,"11");    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D016")  ,"11");    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D017")  ,"11");    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D018")  ,"11");    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D019")  ,"11");    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D020")  ,"22");    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D021")  ,"11");    //
		DISKET+=intStr("0","10");    //D022
		DISKET+=intStr("0","10");    //D023
		DISKET+=intStr("0","10");    //D024
		DISKET+=intStr("0","10");    //D025
		DISKET+=intStr("0","10");    //D026
		DISKET+=intStr("0","10");    //D027
		DISKET+=intStr("0","10");    //D028
		DISKET+=intStr("0","10");    //D029
		DISKET+=intStr("0","10");    //D030
		DISKET+=intStr("0","10");    //D031
		DISKET+=intStr("0","10");    //D032
		DISKET+=intStr("0","10");    //D033
		DISKET+=intStr("0","10");    //D034
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D035")  ,"10");    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D036")  ,"10");    //
		DISKET+=intStr("0","10");    //D037
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D038")  ,"10");    //
		DISKET+=intStr("0","10");    //D039
		DISKET+=intStr("0","10");    //D040
		DISKET+=intStr("0","10");    //D041
		DISKET+=intStr("0","10");    //D042
		DISKET+=intStr("0","10");    //D043
		DISKET+=intStr("0","10");    //D044
		DISKET+=intStr("0","10");    //D045
		DISKET+=intStr("0","10");    //D046
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D047")  ,"10");    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D048")  ,"10");    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D049")  ,"10");    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D050")  ,"10");    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D051")  ,"10");    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D052")  ,"10");    //
		DISKET+=intStr(gcds_recode_d.namevalue(i,"D053")  ,"2" );    //
		DISKET+=strStr(gcds_recode_d.namevalue(i,"D054")  ,"677");   //
		
		gcds_create_file.addrow();
		gcds_create_file.namevalue(gcds_create_file.countrow,"DISKET") = DISKET;
	//}
}


/******************************************************************************
	Description : E 레코드 생성
******************************************************************************/
function ln_Forward_Batch_E(i){
  var DISKET = "";

		DISKET+=strStr(gcds_recode_e.namevalue(i,"E001")  ,"1" );    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E002")  ,"2" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E003")  ,"3" );    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E004")  ,"6" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E005")  ,"10");    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E006")  ,"13");    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E007")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E008")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E009")  ,"20");    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E010")  ,"13");    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E011")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E012")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E013")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E014")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E015")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E016")  ,"1" );    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E017")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E018")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E019")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E020")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E021")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E022")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E023")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E024")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E025")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E026")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E027")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E028")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E029")  ,"10");    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E030")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E031")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E032")  ,"20");    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E033")  ,"13");    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E034")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E035")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E036")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E037")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E038")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E039")  ,"1" );    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E040")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E041")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E042")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E043")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E044")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E045")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E046")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E047")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E048")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E049")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E050")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E051")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E052")  ,"10");    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E053")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E054")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E055")  ,"20");    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E056")  ,"13");    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E057")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E058")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E059")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E060")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E061")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E062")  ,"1" );    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E063")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E064")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E065")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E066")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E067")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E068")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E069")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E070")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E071")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E072")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E073")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E074")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E075")  ,"10");    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E076")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E077")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E078")  ,"20");    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E079")  ,"13");    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E080")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E081")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E082")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E083")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E084")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E085")  ,"1" );    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E086")  ,"10");    
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E087")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E088")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E089")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E090")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E091")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E092")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E093")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E094")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E095")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E096")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E097")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E098")  ,"10");    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E099")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E100")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E101")  ,"20");    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E102")  ,"13");    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E103")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E104")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E105")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E106")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E107")  ,"1" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E108")  ,"1" );    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E109")  ,"10");    
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E110")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E111")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E112")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E113")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E114")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E115")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E116")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E117")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E118")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E119")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E120")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E121")  ,"10");    //
		DISKET+=intStr(gcds_recode_e.namevalue(i,"E122")  ,"2" );    //
		DISKET+=strStr(gcds_recode_e.namevalue(i,"E123")  ,"353");    //

		gcds_create_file.addrow();
		gcds_create_file.namevalue(gcds_create_file.countrow,"DISKET") = DISKET;
	//}
}

/******************************************************************************
	Description : F 레코드 생성
******************************************************************************/
function ln_Forward_Batch_F(i){
  var DISKET = "";
  DISKET+=strStr(gcds_recode_f.namevalue(i,"F001")  ,"1" );    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F002")  ,"2" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F003")  ,"3" );    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F004")  ,"6" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F005")  ,"10");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F006")  ,"13");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F007")  ,"2" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F008")  ,"3" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F009")  ,"30");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F010")  ,"20");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F011")  ,"2" );    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F012")  ,"10");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F013")  ,"10");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F014")  ,"2" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F015")  ,"3" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F016")  ,"30");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F017")  ,"20");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F018")  ,"2" );    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F019")  ,"10");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F020")  ,"10");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F021")  ,"2" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F022")  ,"3" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F023")  ,"30");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F024")  ,"20");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F025")  ,"2" );    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F026")  ,"10");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F027")  ,"10");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F028")  ,"2" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F029")  ,"3" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F030")  ,"30");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F031")  ,"20");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F032")  ,"2" );    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F033")  ,"10");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F034")  ,"10");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F035")  ,"2" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F036")  ,"3" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F037")  ,"30");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F038")  ,"20");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F039")  ,"2" );    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F040")  ,"10");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F041")  ,"10");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F042")  ,"2" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F043")  ,"3" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F044")  ,"30");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F045")  ,"20");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F046")  ,"2" );    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F047")  ,"10");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F048")  ,"10");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F049")  ,"2" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F050")  ,"3" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F051")  ,"30");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F052")  ,"20");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F053")  ,"2" );    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F054")  ,"10");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F055")  ,"10");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F056")  ,"2" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F057")  ,"3" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F058")  ,"30");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F059")  ,"20");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F060")  ,"2" );    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F061")  ,"10");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F062")  ,"10");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F063")  ,"2" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F064")  ,"3" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F065")  ,"30");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F066")  ,"20");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F067")  ,"2" );    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F068")  ,"10");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F069")  ,"10");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F070")  ,"2" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F071")  ,"3" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F072")  ,"30");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F073")  ,"20");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F074")  ,"2" );    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F075")  ,"10");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F076")  ,"10");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F077")  ,"2" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F078")  ,"3" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F079")  ,"30");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F080")  ,"20");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F081")  ,"2" );    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F082")  ,"10");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F083")  ,"10");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F084")  ,"2" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F085")  ,"3" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F086")  ,"30");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F087")  ,"20");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F088")  ,"2" );    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F089")  ,"10");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F090")  ,"10");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F091")  ,"2" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F092")  ,"3" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F093")  ,"30");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F094")  ,"20");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F095")  ,"2" );    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F096")  ,"10");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F097")  ,"10");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F098")  ,"2" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F099")  ,"3" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F100")  ,"30");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F101")  ,"20");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F102")  ,"2" );    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F103")  ,"10");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F104")  ,"10");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F105")  ,"2" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F106")  ,"3" );    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F107")  ,"30");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F108")  ,"20");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F109")  ,"2" );    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F110")  ,"10");    //
	DISKET+=intStr(gcds_recode_f.namevalue(i,"F111")  ,"10");    //
	DISKET+=strStr(gcds_recode_f.namevalue(i,"F112")  ,"55");    //
 
	gcds_create_file.addrow();
  gcds_create_file.namevalue(gcds_create_file.countrow,"DISKET") = DISKET;
}


/******************************************************************************
	Description : data
******************************************************************************/
function ln_Forward_Batch_data(i){
  var DISKET = "";
  DISKET+=strStr(gcds_down_data.namevalue(i,"RCDGB")   ,"2");     //레코드구분
  DISKET+=strStr(gcds_down_data.namevalue(i,"ACCYY")   ,"4");     //귀속년도
  DISKET+=strStr(gcds_down_data.namevalue(i,"ACCHF")   ,"1");     //반기구분
  DISKET+=strStr(gcds_down_data.namevalue(i,"HALFNO")  ,"1");     //반기내월순번
  DISKET+=strStr(gcds_down_data.namevalue(i,"VENDID")  ,"10");    //수취자 사업자등록번호
  DISKET+=strStr(gcds_down_data.namevalue(i,"CARDGB")  ,"1");     //카드구분
  DISKET+=strStr(gcds_down_data.namevalue(i,"CARDNO")  ,"20");    //카드회원번호
  DISKET+=strStr(gcds_down_data.namevalue(i,"AFVENDID"),"10");    //공급자(가맹점)사업자등록번호
  DISKET+=intStr(gcds_down_data.namevalue(i,"VCNT")+"" ,"9");     //거래건수
	DISKET+=strStr(gcds_down_data.namevalue(i,"NUMEXP1") ,"1");     //음수표시
	DISKET+=intStr(gcds_down_data.namevalue(i,"REQAMT")+"" ,"13");  //공급가액
	DISKET+=strStr(gcds_down_data.namevalue(i,"NUMEXP2") ,"1");     //음수표시
	DISKET+=intStr(gcds_down_data.namevalue(i,"TAXAMT")+"" ,"13");  //세액
  DISKET+=strStr(gcds_down_data.namevalue(i,"FILLER")  ,"54");    //공란
  gcds_data99.addrow();
  
  gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}


/******************************************************************************
	Description : tail
	          "FDCODE",	"RCDGB",	"ACCYY",	 "ACCHF",	  "HALFNO",	 "VENDID",	
					"DCNT", 	"TVCNT",	"NUMEXP1", "TREQAMT",	"NUMEXP2", "TTAXAMT",	"FILLER"

******************************************************************************/
function ln_Forward_Batch_tail(i){
  var DISKET = "";
  DISKET+=strStr(gcds_down_tail.namevalue(i,"RCDGB")   ,"2");   //레코드구분
  DISKET+=strStr(gcds_down_tail.namevalue(i,"ACCYY")   ,"4");   //귀속년도
  DISKET+=strStr(gcds_down_tail.namevalue(i,"ACCHF")   ,"1");   //반기구분
  DISKET+=strStr(gcds_down_tail.namevalue(i,"HALFNO")  ,"1");   //반기내월순번
  DISKET+=strStr(gcds_down_tail.namevalue(i,"VENDID")  ,"10");  //수취자 사업자등록번호
  DISKET+=intStr(gcds_down_tail.namevalue(i,"DCNT")+"" ,"7");   //상호(법인명)
  DISKET+=intStr(gcds_down_tail.namevalue(i,"TVCNT")+"","9");   //성명(대표자)
	DISKET+=strStr(gcds_down_tail.namevalue(i,"NUMEXP1") ,"1");   //음수표시
 	DISKET+=intStr(gcds_down_tail.namevalue(i,"TREQAMT")+"" ,"15");  //공급가액
	DISKET+=strStr(gcds_down_tail.namevalue(i,"NUMEXP2") ,"1");      //음수표시
	DISKET+=intStr(gcds_down_tail.namevalue(i,"TTAXAMT")+"" ,"15");  //세액
  DISKET+=strStr(gcds_down_tail.namevalue(i,"FILLER")  ,"74");     //공란
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

  var returnVal="";
  if(a==null) a="";
  var alength=a.length;

  if(alength<b){
    for(var i=0; i<b-alength; i++){
      returnVal+="0";
    }
  }
  returnVal+=a;

  return returnVal;
}
//******************************************************************************/


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

	gcgd_disp01.GridToExcel("신용카드수취명세서","",2);
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=gcds_head classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--입력관련  -->
<object  id=gcds_ihead classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--내려받기 -->
<object  id=gcds_create_file classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_recode_a classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_recode_b classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_recode_c classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_recode_d classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_recode_e classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_recode_f classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
 <object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

 <object  id=gctr_data1 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

 <object  id=gctr_data2 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

 <object  id=gctr_data99 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	ln_Create2();
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>


<script language=JavaScript for=gctr_data1 event=OnSuccess()>
	ln_Create3();
</script>

<script language=JavaScript for=gctr_data1 event=OnFail()>
	alert("Error Code1 : " + gctr_data1.ErrorCode + "\n" + "Error Message : " + gctr_data1.ErrorMsg + "\n");
</script>


<script language=JavaScript for=gctr_data2 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data2 event=OnFail()>
	alert("Error Code2 : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
</script>



<script language=JavaScript for=gctr_data99 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data99 event=OnFail()>
	alert("Error Code : " + gctr_data99.ErrorCode + "\n" + "Error Message : " + gctr_data99.ErrorMsg + "\n");
</script>



</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
 <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030030_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif" align="right">&nbsp;</td>
	</tr>
	<tr><td height=4></td></tr>
</table>

<!-- 매입 ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:20px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>귀속년도</nobr></td>
					<td class="tab23" style="width:90px">
						<comment id="__NSID__">
						<object id=gcem_saccyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px;width:35px;height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td align="right">&nbsp;<nobr>      
					  <img src="../../Common/img/btn/com_btn_ycpay.gif"	style="cursor:hand;position:relative;top:2px;right:2px"	onclick="ln_Ycpay()">
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px"	onclick="ln_Excel()">
						<img src="../../Common/img/btn/com_b_create.gif"  style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Create()">
						<img src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query()"> 
						</nobr>
					</td>
				</tr>
			</table>
				</td>
			</tr>
			<tr><!-- 매입 ----------------------------------------------------------------------------------------->
				<td style="position:relative;left:6px">
					<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>상호(법인명)</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object id=gcem_vendnm0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:230px">
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
								<object  id=gcem_vendid0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:5px;top:0px">		
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
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>대표자명</nobr></td>
							<td class="tab23" style="width:256px"><comment id="__NSID__">
								<object  id=gcem_vddirect0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:230px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
									<param name=ReadOnly      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>법인등록번호</nobr></td>
							<td style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_vendno0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:5px;top:0px">		
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
					</table>
				</td>
			</tr>
			<tr>
				<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr><td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:340px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data">
							<PARAM NAME="Editable"			VALUE="false">
							<PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM NAME="IndWidth"			VALUE="0">
							<PARAM NAME="ColSizing"			VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name=SortView  value="Left">
							<PARAM NAME="viewSummary"		VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<C> Name='번호'	        ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=30	 	align=center	SumText=@count	SumBgColor='#C3D0DB' </C> 
								<C> Name='사번'  	      ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=center	              SumBgColor='#C3D0DB' sort=true </C>
								<C> Name='성명'  	      ID=C010   	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=center	SumText='계'  SumBgColor='#C3D0DB' sort=true </C>
								<C> Name='총급여'  	    ID=C056   	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right 	SumText=@sum  SumBgColor='#C3D0DB' sort=true </C>
								<C> Name='비과세'   		ID=C054D047	HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=right	  SumText=@sum  SumBgColor='#C3D0DB' sort=true </C>
								<G> Name='결정세액'     HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='소득세'			  ID=C123 		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumText=@sum	SumBgColor='#C3D0DB' sort=false </C>
								<C> Name='지방소득세'		ID=C124 		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=right		SumText=@sum	SumBgColor='#C3D0DB' sort=false </C>
							  </G>
								<G> Name='기납부세액'   HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='종소득세'			ID=D049 		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=right		SumText=@sum	SumBgColor='#C3D0DB' sort=false </C>
								<C> Name='종지방소득'		ID=D050 		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=right		SumText=@sum	SumBgColor='#C3D0DB' sort=false </C>
 								<C> Name='현소득세'			ID=C127 		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumText=@sum	SumBgColor='#C3D0DB' sort=false </C>
								<C> Name='현지방소득'		ID=C128		  HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=right		SumText=@sum	SumBgColor='#C3D0DB' sort=false </C>
								</G>
								<G> Name='차감징수세액'  HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='소득세'			  ID=C131 		HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right		SumText=@sum	SumBgColor='#C3D0DB' sort=false </C>
								<C> Name='지방소득세'		ID=C132 		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=right		SumText=@sum	SumBgColor='#C3D0DB' sort=false </C>
							  </G>
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
						<img src="../../Common/img/btn/com_b_down.gif"		style="cursor:hand;position:relative;top:5px;right:2px" onclick="ln_Download()">
						<img src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand;position:relative;top:5px;right:2px" onClick="ln_Down_Query()"> 
						</nobr>
					</td>
				</tr>
				<tr>
					<td colspan =2>
						<comment id="__NSID__">
						<OBJECT id=gcgd_data01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="width:867px;height:160px;position:relative;left:5px;border:1 solid #777777;">
							<PARAM NAME="DataID"			VALUE="gcds_create_file">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<param name="ColSelect"		value="false">
							<param name="ColSizing"		value="true">
							<PARAM NAME="Format"			VALUE="  
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
	<param name=DataID			value=gcds_head>
	<param name=BindInfo		value='  
		<C>Col=VENDNM			Ctrl=gcem_vendnm0				Param=text</C>
		<C>Col=VENDID			Ctrl=gcem_vendid0				Param=text</C>
		<C>Col=VDDIRECT	  Ctrl=gcem_vddirect0			Param=text</C>
		<C>Col=VENDNO		  Ctrl=gcem_vendno0			  Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [DATA2]
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>