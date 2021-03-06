<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 공통 코드 관리
 * 프로그램ID 	: THMS101.HTML
 * J  S  P		: th101.jsp
 * 작 성 자		: 이동훈
 * 작 성 일		: 2010-10-05
 * 기능정의		: 입찰이력용 공통코드관리
 * [ 수정일자 ][수정자] 내용
 * [2011-06-16][심동현] 공사관리 쪽으로 통합
 *  서블릿명 : thms_101_s.java, thms_101_t.java
 *****************************************************************************/
%>
<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>


<!--
/*--------------------------------------------------------------------------------
+ 시스템명 : 입찰 결과 관리
+ 프로그램ID : THMS101.HTML
+ 기능정의 : 
+ 작 성 자 : 이 동 훈 
+ 작성일자 : 2010.08.24
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 : thms_101_s.java, thms_101_t.java

------------------------------------------------------------------------------>
<html>
<head>
<title>입찰 결과 등록</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="http://erp.hdasan.com/common/include/common.css">
 
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="http://erp.hdasan.com/common/include/PubFun.js"></script>

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

	get_cookdata();       //읽기
	var gs_date = gcurdate.substring(0,10);
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){


	ln_Before();		//선조회 조건




}




/******************************************************************************
	Description : 선조회 조건
******************************************************************************/
function ln_Before(){


	//현장
	gcds_site_s.DataID="<%=dirPath%>/servlet/construct.menu.th.thms_site_s?v_str1=0001";
	gcds_site_s.Reset();


	//공종
	gcds_cnst_s.DataID="<%=dirPath%>/servlet/construct.menu.th.thms_site_s?v_str1=0002";	
	gcds_cnst_s.Reset();

	//현장
	gcds_site.DataID="<%=dirPath%>/servlet/construct.menu.th.thms_site_s?v_str1=0001";
	gcds_site.Reset();


	//공종
	gcds_cnst.DataID="<%=dirPath%>/servlet/construct.menu.th.thms_site_s?v_str1=0002";	
	gcds_cnst.Reset();


	//발주처
	gcds_ord.DataID="<%=dirPath%>/servlet/construct.menu.th.thms_site_s?v_str1=0005";	
	gcds_ord.Reset();

	//발주처
	gcds_bid_style.DataID="<%=dirPath%>/servlet/construct.menu.th.thms_site_s?v_str1=0007";	
	gcds_bid_style.Reset();


	 ln_SetDataHeader00();

	 ln_SetDataHeader03();


}




/******************************************************************************
	Description : 데이타 셋 헤드 설정
******************************************************************************/
function ln_SetDataHeader00(){

	if (gcds_data00.countrow<1){

		var s_temp = "BID_NUM:STRING(20),"
								+"BID_STYLE:STRING(3),"		
								+"BID_STYLE_NM:STRING(20),"	
								+"SITE_CD:STRING(10),"			
								+"SITE_NM:STRING(50),"										
								+"CNST_CD:STRING(10),"
								+"CNST_NM:STRING(50),"
								+"BID_DAY:STRING(10),"
								+"ORDER_CD:STRING(10),"
								+"ORDER_NM:STRING(50),"
								+"START_DT:STRING(10),"
								+"END_DT:STRING(10),"
								+"ACT_AMT:DECIMAL(12),"
								+"ACT_AMT_KOR:STRING(100),"
								+"START_DT_HA:STRING(10),"
								+"END_DT_HA:STRING(10),"
								+"ACT_AMT_HA:DECIMAL(12),"
								+"ACT_AMT_HA_KOR:STRING(100),"
								+"RECO_CD:STRING(10)";

		gcds_data00.SetDataHeader(s_temp);

	}

}


/******************************************************************************
	Description : 데이타 셋 헤드 설정
******************************************************************************/
function ln_SetDataHeader03(){

	if (gcds_data03.countrow<1){

		var s_temp = "BID_NUM:STRING(20),"
							+"SITE_CD:STRING(10),"					
							+"CNST_CD:STRING(10),"
							+"SEQ:STRING(1),"
							+"BID_COM:STRING(10),"  			
							+"BID_COM_NM:STRING(30),"  	
							+"BID_AMT:DECIMAL(12)," 			
							+"BID_AMT_PCT1:STRING(10)," 		
							+"BID_AMT_PCT2:STRING(10)," 		
							+"BID_AMT2:DECIMAL(12)," 		
							+"BID_AMT2_PCT1:STRING(10)," 		
							+"BID_AMT2_PCT2:STRING(10)," 	
							+"RESULT_CP:STRING(10),"
							+"RESULT_AMT:DECIMAL(12),"
							+"RESULT_AMT_KOR:STRING(100),"
							+"REMARK:STRING(50)";							 
		gcds_data03.SetDataHeader(s_temp);
		
	}
	
}




/******************************************************************************
	Description : 데이타 셋 헤드 설정
******************************************************************************/
function ln_SetPrintDataHeader(){

		if(gcds_report00.countrow<1){

		var s_temp = "BID_NUM:STRING(20),"
								+"BID_STYLE:STRING(3),"		
								+"BID_STYLE_NM:STRING(20),"	
								+"SITE_CD:STRING(10),"			
								+"SITE_NM:STRING(50),"										
								+"CNST_CD:STRING(10),"
								+"CNST_NM:STRING(50),"
								+"BID_DAY:STRING(10),"
								+"ORDER_CD:STRING(10),"
								+"ORDER_NM:STRING(50),"
								+"START_DT:STRING(10),"
								+"END_DT:STRING(10),"
								+"ACT_AMT:DECIMAL(12),"
								+"ACT_AMT_KOR:STRING(100),"
								+"START_DT_HA:STRING(10),"
								+"END_DT_HA:STRING(10),"
								+"ACT_AMT_HA:DECIMAL(12),"
								+"ACT_AMT_HA_KOR:STRING(100),"
								+"RECO_CD:STRING(10)";

			gcds_report00.SetDataHeader(s_temp);
	}
	
}




/******************************************************************************
	Description : 조회  -   완성해야 됨!!!!
******************************************************************************/
function ln_Query(){


		gclx_site.index = 0;
		gclx_cnst.index = 0;
		gclx_ord.index = 0;
		gclx_bid_style.index = 0;
		gcem_act_amt.Text = "";
		gcem_fr_date1.Text = "";
		gcem_to_date1.Text = "";
		gcem_act_amt_ha.Text = "";
		gcem_fr_date2.Text = "";
		gcem_to_date2.Text = "";
		gcem_bid_date.Text = "";

		gcds_data00.ClearData();
		gcds_data03.ClearData();



    if(!ln_Query_Chk()) return;

	gcds_data00.DataID = "<%=dirPath%>/servlet/construct.menu.th.thms_202_s1?"	 		
											 + "v_str1="+gclx_site_s.bindcolval							//현장명
											 + "&v_str2="+gclx_cnst_s.bindcolval;						//공종명

	gcds_data00.Reset(); 



	var x = gcem_act_amt.Text;
	var y = gcem_act_amt_ha.Text;
	var z = (y/x) * 100;

	gcem_pct1.Text = z;

	//prompt(this, y);
	//prompt(this, x);
	//prompt(this, gcem_pct1.value);


	gcds_data03.DataID = "<%=dirPath%>/servlet/construct.menu.th.thms_202_s2?"	 		
											 + "v_str1="+gclx_site_s.bindcolval							//현장명
											 + "&v_str2="+gclx_cnst_s.bindcolval;						//공종명

	//prompt('',gcds_data03.DataID);

	gcds_data03.Reset(); 

}


/******************************************************************************
	Description : 조회  -   완성해야 됨!!!!
******************************************************************************/
function ln_Query_Chk(){


			if(gclx_site_s.index == 0){

				alert("현장명을 선택하십시요.");

				return false;

				}

			if(gclx_cnst_s.index == 0){

				alert("공종명을 선택하십시요.");

				return false;

				}

	return true;


}




/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){



		gclx_site.index = 0;
		gclx_cnst.index = 0;
		gclx_ord.index = 0;
		gcem_act_amt.value = "";
		gcem_fr_date1.Text = "";
		gcem_to_date1.Text = "";
		gcem_act_amt_ha.Text = "";
		gcem_fr_date2.Text = "";
		gcem_to_date2.Text = "";
		gcem_bid_date.Text = "";

		gcds_data00.ClearData();
		gcds_data03.ClearData();

		gcem_act_amt.focus();

        gcds_data00.AddRow();

}

/******************************************************************************
	Description : 추가 // 완료된 것 같음
******************************************************************************/
function ln_Refresh(){


		gcem_act_amt.Text = "";
		gcem_fr_date1.Text = "";
		gcem_to_date1.Text = "";
		gcem_act_amt_ha.Text = "";
		gcem_fr_date2.Text = "";
		gcem_to_date2.Text = "";
		gcem_bid_date.Text = "";

		gcds_data00.ClearData();

		gcds_data03.ClearData();

}



/******************************************************************************
	Description : 추가 
******************************************************************************/
function ln_Add3(){


		gcds_data03.addrow();	


}


/******************************************************************************
	Description : 저장  -   완성해야 됨!!!!
******************************************************************************/
function ln_Save(){



    if(!ln_Save_Chk()) return;

	if (gcds_data00.IsUpdated || gcds_data03.IsUpdated) {	

		if (confirm("해당 입력정보를 저장하시겠습니까 ?")) {

			//for (var i=1; i<=gcds_sys.countrow; i++){}
			//gctr_sys.KeyValue = "thms_101_t1?(I:USER=gcds_data00,I:USER2=gcds_data02,I:USER3=gcds_data03)";
			//gctr_sys.KeyValue = "thms_101_t?(I:USER=gcds_data00,I:USER3=gcds_data03)";		
			
			gctr_sys.KeyValue = "thms_202_t?(I:USER=gcds_data00,I:USER3=gcds_data03)";		
			
			//prompt(this,gcds_data00.text);

			gctr_sys.action = "<%=dirPath%>/servlet/construct.menu.th.thms_202_t?";



			gctr_sys.post();

		}
	}

}



/******************************************************************************
	Description : 적용시 체크
******************************************************************************/

function ln_Save_Chk(){

			var bid_num= "";
	
			bid_num += gclx_site.bindcolval;
			bid_num += gclx_cnst.bindcolval;



      		gcds_data00.namevalue(gcds_data00.rowposition,"BID_NUM") = bid_num;
      		gcds_data00.namevalue(gcds_data00.rowposition,"SITE_CD") = gclx_site.bindcolval;
      		gcds_data00.namevalue(gcds_data00.rowposition,"CNST_CD") = gclx_cnst.bindcolval;
      		gcds_data00.namevalue(gcds_data00.rowposition,"ORDER_CD") = gclx_ord.bindcolval;			
      		gcds_data00.namevalue(gcds_data00.rowposition,"BID_STYLE") = gclx_bid_style.bindcolval;			



	if (gcds_data03.countrow<1) {

			alert("입찰 결과도 같이 작성하셔야 합니다.");

			return false;
	}

	var chk=0;

	for(i=1;i<=gcds_data03.countrow;i++){	

      		gcds_data03.namevalue(i,"BID_NUM") = bid_num;
      		gcds_data03.namevalue(i,"SITE_CD") = gclx_site.bindcolval;
      		gcds_data03.namevalue(i,"CNST_CD") = gclx_cnst.bindcolval;

			if(gcds_data03.namevalue(i,"RESULT_CP") == ''){

			alert("결과를 입력하세요");

			return false;

			chk=chk + 1;


			if(chk > 1){

				alert("낙찰 업체가 중복됩니다.");

			return false;

				}
			}
		}


	return true;

}





/******************************************************************************
	Description : 현장 및 공종 조회
******************************************************************************/
function ln_FindC(e){

		var arrResult	= new Array();
		var strURL;
		var strPos;
		arrParam = e;
		strURL = "../html/thms_pop1.html";
		strPos = "dialogWidth:370px;dialogHeight:400px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
		
				if ( arrParam[0] == '01'){			
					gcem_site_cd.Text=arrParam[1];							
					gcem_site_nm.Text=arrParam[2];
				}else if	( arrParam[0] == '02'){	
					gcem_cnst_cd.Text=arrParam[1];				
					gcem_cnst_nm.Text=arrParam[2];
				}			

		}
}



/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){



//		if (gcds_data00.countrow<1) {
//			alert("출력하실 정보가 없습니다");
//		} else {

		var bid_num_r= "";

		bid_num_r += gclx_site.bindcolval;
		bid_num_r += gclx_cnst.bindcolval;

		//prompt(this, bid_num_r);

		gcds_report00.ClearAll();

		ln_SetPrintDataHeader();
	
		gcds_report00.Addrow();

		for (var k=1;k<=gcds_data00.countcolumn;k++) {

		 gcds_report00.namevalue(1,gcds_data00.columnid(k)) = gcds_data00.namevalue(gcds_data00.rowposition,gcds_data00.columnid(k));

		}



		//gcds_data03.DataID = "<%=dirPath%>/servlet/construct.menu.th.thms_202_s2?"	 		
		//									 + "v_str1="+gclx_site_s.bindcolval							//현장명
		//									 + "&v_str2="+gclx_cnst_s.bindcolval;						//공종명


		//입찰결과
		//gcds_report01.DataID = "<%=dirPath%>/servlet/construct.menu.th.thms_202_r?"
		//									 + "v_str1="+bid_num_r;					//현장명


		gcds_report01.DataID = "<%=dirPath%>/servlet/construct.menu.th.thms_202_s3?"	 		
											 + "v_str1="+gclx_site.bindcolval							//현장명
											 + "&v_str2="+gclx_cnst.bindcolval;						//공종명


		//prompt(this, gcds_report01.DataID);

		gcds_report01.Reset(); 

/*
		gcds_report02.DataID = "<%=dirPath%>/servlet/construct.menu.th.thms_202_s5?"	 		
											 + "v_str1="+gclx_site.bindcolval							//현장명
											 + "&v_str2="+gclx_cnst.bindcolval;						//공종명


		prompt(this, gcds_report02.DataID);

		gcds_report02.Reset(); 
*/

/*
		//참석자
		gcds_report2.DataID =  "<%=dirPath%>/servlet/thms_202_sr2?"
											  + "v_str1=" + txt_empno.value;
		gcds_report2.Reset();		


*/

		ln_RptFormat();		

		//prompt(this, ReportID.text);

		ReportID.Preview();

//		}

}


/******************************************************************************
		Description :  출력물 포멧 작성
******************************************************************************/
function ln_RptFormat(){
		
	var ls_for = "";
	

	ls_for += "<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=1400 ,face='Tahoma' ,size=10 ,penwidth=1";
	ls_for += "<I>id='../img/4t.jpg' ,left=50 ,top=0 ,right=299 ,bottom=220</I>";
	ls_for += "<T>id='하도급 입찰 결과' ,left=548 ,top=82 ,right=1505 ,bottom=177 ,face='Tahoma' ,size=21 ,bold=true ,underline=true ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<L> left=37 ,top=230 ,right=1950 ,bottom=230 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=40 ,top=550 ,right=1950 ,bottom=550 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=413 ,top=233 ,right=413 ,bottom=550 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=1072 ,top=230 ,right=1072 ,bottom=548 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=415 ,top=304 ,right=1693 ,bottom=304 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=415 ,top=484 ,right=1693 ,bottom=484 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=418 ,top=370 ,right=1950 ,bottom=370 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=1487 ,top=304 ,right=1487 ,bottom=550 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=1270 ,top=304 ,right=1270 ,bottom=550 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=857 ,top=304 ,right=857 ,bottom=550 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<T>id='결재' ,left=79 ,top=368 ,right=177 ,bottom=434 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='중역' ,left=712 ,top=310 ,right=831 ,bottom=362 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='년' ,left=360 ,top=273 ,right=410 ,bottom=325 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='월' ,left=355 ,top=373 ,right=405 ,bottom=426 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='일' ,left=352 ,top=466 ,right=402 ,bottom=519 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<L> left=1693 ,top=233 ,right=1693 ,bottom=550 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<T>id='본부장' ,left=918 ,top=312 ,right=1037 ,bottom=365 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='작성자' ,left=471 ,top=310 ,right=590 ,bottom=362 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='차장/손무홍' ,left=429 ,top=489 ,right=627 ,bottom=542 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='상무보/정종국' ,left=635 ,top=489 ,right=855 ,bottom=542 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='상무/조철중' ,left=870 ,top=492 ,right=1095 ,bottom=545 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='상무보/강금석' ,left=1273 ,top=489 ,right=1492 ,bottom=542 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='상무/김현덕' ,left=1500 ,top=492 ,right=1720 ,bottom=545 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='경영지원본부' ,left=654 ,top=243 ,right=908 ,bottom=296 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='건설사업본부' ,left=1286 ,top=243 ,right=1540 ,bottom=296 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='부서장' ,left=1127 ,top=312 ,right=1246 ,bottom=365 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='중역' ,left=1344 ,top=312 ,right=1463 ,bottom=365 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='본부장' ,left=1537 ,top=310 ,right=1656 ,bottom=362 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='사장' ,left=1778 ,top=278 ,right=1897 ,bottom=331 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<L> left=180 ,top=230 ,right=180 ,bottom=548 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=37 ,top=230 ,right=37 ,bottom=548 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=1953 ,top=233 ,right=1953 ,bottom=550 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=630 ,top=304 ,right=630 ,bottom=550 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";


	var YYYY =  gs_date.substring(0,4);
	var MM =  gs_date.substring(5,7);
	var DD =  gs_date.substring(8,10);


	ls_for += "<T>id='"+YYYY+"', align='right' ,left=204, top=267, right=347, bottom=333 </T>";
	ls_for += "<T>id='"+MM+"', align='right' ,left=204, top=365, right=347, bottom=431</T>";
	ls_for += "<T>id='"+DD+"', align='right' ,left=204, top=458, right=347, bottom=524</T>";
	ls_for += "<L> left=37 ,top=704 ,right=1947 ,bottom=704 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=1545 ,top=1117 ,right=1545 ,bottom=1251 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=180 ,top=704 ,right=180 ,bottom=1334 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=1550 ,top=1185 ,right=1945 ,bottom=1185 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=183 ,top=1114 ,right=1945 ,bottom=1114 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<T>id='1. 공사개요' ,left=34 ,top=627 ,right=810 ,bottom=693 ,align='left' ,face='Tahoma' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<L> left=185 ,top=781 ,right=1950 ,bottom=781 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<T>id='개요' ,left=61 ,top=828 ,right=164 ,bottom=894 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='하도급' ,left=50 ,top=1146 ,right=153 ,bottom=1212 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<L> left=37 ,top=1032 ,right=1950 ,bottom=1032 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=180 ,top=947 ,right=1945 ,bottom=947 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=180 ,top=857 ,right=1947 ,bottom=857 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=1545 ,top=860 ,right=1545 ,bottom=947 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=37 ,top=1334 ,right=1950 ,bottom=1334 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=37 ,top=704 ,right=37 ,bottom=1334 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=439 ,top=706 ,right=439 ,bottom=1328 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<L> left=1950 ,top=701 ,right=1950 ,bottom=1334 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<T>id='예가' ,left=251 ,top=1154 ,right=373 ,bottom=1220 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='공기' ,left=251 ,top=1259 ,right=355 ,bottom=1326 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='공종' ,left=251 ,top=1042 ,right=370 ,bottom=1109 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='공기' ,left=251 ,top=958 ,right=373 ,bottom=1024 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='예산' ,left=251 ,top=870 ,right=370 ,bottom=937 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='발주처' ,left=249 ,top=786 ,right=373 ,bottom=852 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='현장명' ,left=249 ,top=709 ,right=373 ,bottom=775 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<C>id='START_DT', left=505, top=958, right=762, bottom=1024 ,mask='XXXX/XX/XX', face='Tahoma', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
	ls_for += "<T>id='~' ,left=783 ,top=963 ,right=833 ,bottom=1016 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<C>id='END_DT', left=844, top=958, right=1101, bottom=1024 ,mask='XXXX/XX/XX', face='Tahoma', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
	ls_for += "<C>id='START_DT_HA', left=495, top=1259, right=751, bottom=1326 ,mask='XXXX/XX/XX', face='Tahoma', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
	ls_for += "<T>id='~' ,left=773 ,top=1265 ,right=823 ,bottom=1318 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<C>id='END_DT_HA', left=833, top=1259, right=1090, bottom=1326 ,mask='XXXX/XX/XX', face='Tahoma', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
	ls_for += "<C>id='SITE_NM', left=500, top=709, right=1521, bottom=775, face='Tahoma', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
	ls_for += "<C>id='CNST_NM', left=497, top=1042, right=1524, bottom=1109, face='Tahoma', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
	ls_for += "<C>id='ORDER_NM', left=503, top=788, right=1519, bottom=855, face='Tahoma', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
	ls_for += "<L> left=180 ,top=1251 ,right=1947 ,bottom=1251 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
	ls_for += "<T>id='예산대비 :     95%' ,left=1574 ,top=1191 ,right=1926 ,bottom=1249 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='￦' ,left=1572 ,top=870 ,right=1651 ,bottom=937 ,align='right' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<C>id='ACT_AMT', left=1654, top=870, right=1939, bottom=937, align='left', face='Tahoma', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
	ls_for += "<T>id='￦' ,left=1574 ,top=1117 ,right=1654 ,bottom=1183 ,align='right' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<C>id='ACT_AMT_HA', left=1659, top=1117, right=1916, bottom=1183, align='left', face='Tahoma', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
	ls_for += "<T>id='원정' ,left=1241 ,top=1156 ,right=1363 ,bottom=1222 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<T>id='원정' ,left=1241 ,top=873 ,right=1363 ,bottom=939 ,align='left' ,face='Tahoma' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for += "<C>id='ACT_AMT_HA_KOR', left=503, top=1156, right=1236, bottom=1222, align='right' , face='Tahoma', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
	ls_for += "<C>id='ACT_AMT_KOR', left=503, top=870, right=1236, bottom=937, align='right' , face='Tahoma', size=13, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
	ls_for += "</B>";

	ls_for += "<B>id=Footer ,left=0 ,top=2748 ,right=2000 ,bottom=2870 ,face='Tahoma' ,size=10 ,penwidth=1";
	ls_for += "<I>id='../img/icon.jpg' ,left=1603 ,top=21 ,right=1953 ,bottom=103</I>";
	ls_for += "</B>";


	ReportID.format = ls_for + ReportID.format ;

	//prompt(this, ReportID.text);

}






/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print2(){



//		if (gcds_data00.countrow<1) {
//			alert("출력하실 정보가 없습니다");
//		} else {




		//prompt(this, bid_num_r);

		gcds_report10.ClearAll();

		//ln_SetPrintDataHeader10();
	
		gcds_report10.Addrow();

		//prompt(this, gcds_report10.text);

		//ln_RptFormat2();		
		ln_RptFormat3();		

		ReportID2.Preview();


}

/******************************************************************************
		Description :  출력물 포멧 작성
******************************************************************************/
function ln_RptFormat3(){
	var ls_for2 = "";
	ls_for2 += "<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=2807 ,face='굴림' ,size=11 ,penwidth=1";
	ls_for2 += "<I>id='../img/4t.jpg' ,left=56 ,top=29 ,right=294 ,bottom=220</I>";
	ls_for2 += "<I>id='../img/opening.jpg' ,left=750 ,top=50 ,right=1200 ,bottom=220</I>";
	ls_for2 += "<L> left=37 ,top=323 ,right=1900 ,bottom=323 ,penstyle=solid ,penwidth=8 ,pencolor=#000000 </L>";
	ls_for2 += "<T>id='110 - 754/서울특별시 종로구 연지동 1-7 현대그룹빌딩 서관 8층                                                   Tel : 02) 3669 - 3696   Fax : 02)3669-3777' ,left=53 ,top=243 ,right=1918 ,bottom=312 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='2010.  12.     .' ,left=1640 ,top=355 ,right=1939 ,bottom=431 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='현   아 :' ,left=101 ,top=347 ,right=280 ,bottom=413 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='지원 제 2010 -        호' ,left=299 ,top=349 ,right=725 ,bottom=421 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='수   신 :' ,left=101 ,top=437 ,right=280 ,bottom=503 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";

	for(i=0;i<10;i++)
	{
	if(gcds_data03.namevalue(gcds_data03.rowposition,"RESULT_CP") == '1'){
			var susin = gcds_data03.namevalue(gcds_data03.rowposition,"BID_COM_NM");
			var result_amt = gf_setnum(gcds_data03.namevalue(gcds_data03.rowposition,"RESULT_AMT"));
			var result_amt_kor = gcds_data03.namevalue(gcds_data03.rowposition,"RESULT_AMT_KOR");
		}
	}

	ls_for2 += "<T>id='"+susin+"', left=299, top=437, right=783, bottom=503, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</T>";

	ls_for2 += "<T>id='참   조 :' ,left=101 ,top=516 ,right=280 ,bottom=582 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='관리부장' ,left=299 ,top=511 ,right=511 ,bottom=582 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='제   목 :' ,left=101 ,top=603 ,right=280 ,bottom=669 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='낙찰통보' ,left=299 ,top=606 ,right=534 ,bottom=669 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<L> left=42 ,top=693 ,right=1900 ,bottom=693 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";

	ls_for2 += "<T>id='1. 귀사의 무궁한 발전을 기원합니다.' ,left=312 ,top=750 ,right=1087 ,bottom=800 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='2. 당사에서 실시한 입찰 결과 귀사가 낙착되었음을 통보하오니 성공적인 공사 수행을 위한 동원' ,left=312 ,top=820 ,right=2048 ,bottom=870 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='준비에 만전을 기하여 주시고 아래 서류를 구비하여 하도급 계약 체결 후 조속히 착공하여 주시기 바랍니다. ' ,left=114 ,top=890 ,right=1979 ,bottom=940 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='또한 계약서 초안 작성후 일주일 이내에 계약구비서류 미제출로 인하여 계약체결이 완료되지 않을 시에는 낙찰이 ' ,left=114 ,top=960 ,right=2006 ,bottom=1010 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='취소될 수 있음을 숙지하시고 신속한 계약체결을 위한 업무협조 부탁드립니다.' ,left=114 ,top=1030 ,right=2032 ,bottom=1080 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";

	ls_for2 += "<T>id='- 아                 래 -' ,left=537 ,top=1200 ,right=1312 ,bottom=1300 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='1) 입찰공사명 :' ,left=114 ,top=1300 ,right=415 ,bottom=1380 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";

	var bid_num_r2 = gcds_data00.namevalue(1,"SITE_NM");
	      bid_num_r2 += " - ";
		  bid_num_r2 += gcds_data00.namevalue(1,"CNST_NM");

	ls_for2 += "<T>id='"+bid_num_r2+"', left=413, top=1300, right=1600, bottom=1380, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</T>";

	ls_for2 += "<T>id='2) 공        기 :' ,left=114 ,top=1380 ,right=415 ,bottom=1460 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='계약일 ~' ,left=413 ,top=1380 ,right=619 ,bottom=1460 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";

	var end_day_yy = gcds_data00.namevalue(1,"END_DT_HA").substring(0,4);
	var end_day_mm = gcds_data00.namevalue(1,"END_DT_HA").substring(4,6);
	var end_day_dd = gcds_data00.namevalue(1,"END_DT_HA").substring(6,8);

	ls_for2 += "<T>id='"+end_day_yy+"."+end_day_mm+"."+end_day_dd+"', left=560, top=1380, right=1000, bottom=1460, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</T>";

	ls_for2 += "<T>id='3) 낙 찰 금 액 :' ,left=114 ,top=1460 ,right=415 ,bottom=1540 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";

	ls_for2 += "<T>id='일금' ,left=413 ,top=1460 ,right=521 ,bottom=1540 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";

	ls_for2 += "<T>id='"+result_amt_kor+"', left=524, top=1460, right=900, bottom=1540, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</T>";

	ls_for2 += "<T>id='원정  (￦' ,left=900 ,top=1460 ,right=1061 ,bottom=1540 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";




	ls_for2 += "<T>id='"+result_amt+"', left=1066, top=1460, right=1300, bottom=1540, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>";

	ls_for2 += "<T>id=') [공급가 기준]' ,left=1300 ,top=1460 ,right=1765 ,bottom=1540 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";

	
	ls_for2 += "<T>id='4) 구 비 서 류 :    ① 건설공사 하도급계약서(당사 작성 후 전자계약체결)' ,left=114 ,top=1540 ,right=1863 ,bottom=1620 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='② 공사계약 내역서(전자메일 송부)' ,left=413 ,top=1620 ,right=1863 ,bottom=1700 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='③ 계약이행증권(10%), 근재보험증권(1인당 1억, 한 사고당 2억)' ,left=413 ,top=1700 ,right=1863 ,bottom=1780 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='④ 예정공정표, 보유면허 사본' ,left=413 ,top=1780 ,right=1863 ,bottom=1860 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='⑤ 대표자 인감증명서 및 사용인감계' ,left=413 ,top=1860 ,right=1863 ,bottom=1940 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='⑥ 현장대리인 선임계, 대리인 이력서, 대리인 면허증사본' ,left=413 ,top=1940 ,right=1863 ,bottom=2020 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='⑦ 사업자등록증 사본. 등기부등본. 시국세완납증명서' ,left=413 ,top=2020 ,right=1863 ,bottom=2100 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='⑧ 통장사본(어음결제 조건인 경우 전자어음 계좌등록)' ,left=413 ,top=2100 ,right=1863 ,bottom=2180 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='※ 전자계약 체결 후 송부 : ③~⑦ 계약건별 각 2부.' ,left=413 ,top=2180 ,right=1863 ,bottom=2260 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='(원본 1부와 ‘사실과 상이없음’ 날인한 1부) ' ,left=1000 ,top=2260 ,right=1889 ,bottom=2340 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";

	ls_for2 += "<T>id='경 영 지 원 본 부' ,left=1300 ,top=2400 ,right=1850 ,bottom=2500 ,face='굴림' ,size=15 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
	ls_for2 += "<T>id='담당중역 정 종 국' ,left=1300 ,top=2500 ,right=1850 ,bottom=2600 ,face='굴림' ,size=15 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";

	ls_for2 += "</B>";
	ReportID2.format = ls_for2 + ReportID2.format ;
}



/******************************************************************************************
 	Descrition : 숫자 Sting에 콤마찍기(소수점 이하 존재할 경우 포함)
	parameter  : 
	retun      : 
******************************************************************************************/
function gf_setnum(src){ 
  
  if(src==""){
		return 0;
	}

	//alert("src"+src);

	var arrParam	= new Array();
	var buf_all  = "";
	var buf_comma  = "";
	var len	= 0;
	var comma = 0;
	var buf  = "";
	var dest = "";

	buf_all = "" + src + "";
	arrParam = buf_all.split(".");
  
  buf = arrParam[0];
  
	if (arrParam.length>1){
		buf_comma = arrParam[1];
	}else{
    buf_comma="";
	}
  
	
	buf = "" + buf + "";
	len = buf.length;
	
	for(i = 3; i < len; i+=3) {
		if((i < len) || (len < (i+4)))	comma++;
	}
	
	for(i = 0; i < len; i++) {
		if(i == (len - (3 * comma))) {
			dest += ",";
			dest += buf.charAt(i);
			comma--;
		}
		else {
			dest += buf.charAt(i);
		}
	}

	if (dest.substring(0,1)=="-") {
		if (dest.substring(1,2)==",") {
			dest = dest.substring(0,1) + dest.substring(2,dest.length);
		}
	}

	if(buf_comma!=""){
    dest=dest+"."+buf_comma;
	}

	return dest;
}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<comment id="__NSID__">
<OBJECT id="gcds_data00" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
 </OBJECT>
 </comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<OBJECT id="gcds_data03" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
 </OBJECT>
 </comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<OBJECT id=gcds_site_s classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<OBJECT id=gcds_cnst_s classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<OBJECT id=gcds_site classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<OBJECT id=gcds_cnst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<OBJECT id=gcds_ord classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<OBJECT id=gcds_bid_style classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<OBJECT id=gcds_report00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<OBJECT id=gcds_report01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<OBJECT id=gcds_report02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<OBJECT id=gcds_report10 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<OBJECT id=gctr_sys classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
 </OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data00" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
</script>
<!--
<script language="javascript" for="gcds_data00" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_data00" event="onloadError()">
	window.status="조회가 완료 되었습니다.";
</script>
-->
<script language="javascript" for="gcds_data03" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	if (row <1) alert("검색된 데이터가 없습니다.");

</script>

<script language="javascript" for="gcds_data03" event="onloadError()">
	window.status="조회가 완료 되었습니다.";
</script>

<!-- 현장 검색용  -->
<script language="javascript" 	for="gcds_site_s" event="onloadCompleted(row,colid)">
	gcds_site_s.insertrow(1);
	gcds_site_s.namevalue(1,"COM_CODE") = "";
	gcds_site_s.namevalue(1,"COM_SNAME") = "전체";
	gclx_site_s.index = 0;
</script>


<!-- 공종 검색용  -->
<script language="javascript" 	for="gcds_cnst_s" event="onloadCompleted(row,colid)">
	gcds_cnst_s.insertrow(1);
	gcds_cnst_s.namevalue(1,"COM_CODE") = "";
	gcds_cnst_s.namevalue(1,"COM_SNAME") = "전체";
	gclx_cnst_s.index = 0;
</script>


<!-- 현장명  -->
<script language="javascript" 	for="gcds_site" event="onloadCompleted(row,colid)">
	gcds_site.insertrow(1);
	gcds_site.namevalue(1,"COM_CODE") = "";
	gcds_site.namevalue(1,"COM_SNAME") = "전체";
	gclx_site.index = 0;
</script>


<!-- 공종명  -->
<script language="javascript" 	for="gcds_cnst" event="onloadCompleted(row,colid)">
	gcds_cnst.insertrow(1);
	gcds_cnst.namevalue(1,"COM_CODE") = "";
	gcds_cnst.namevalue(1,"COM_SNAME") = "전체";
	gclx_cnst.index = 0;
</script>

<!-- 발주처  -->
<script language="javascript" 	for="gcds_ord" event="onloadCompleted(row,colid)">
	gcds_ord.insertrow(1);
	gcds_ord.namevalue(1,"COM_CODE") = "";
	gcds_ord.namevalue(1,"COM_SNAME") = "전체";
	gclx_ord.index = 0;
</script>

<!-- 발주처  -->
<script language="javascript" 	for="gcds_bid_style" event="onloadCompleted(row,colid)">
	gcds_bid_style.insertrow(1);
	gcds_bid_style.namevalue(1,"COM_CODE") = "";
	gcds_bid_style.namevalue(1,"COM_SNAME") = "전체";
	gclx_bid_style.index = 0;
</script>

<script language=JavaScript for=gcgd_data03 event=OnPopup(row,colid,data)>


		var arrResult	= new Array();
		var strURL;
		var strPos;
		arrParam = "";
		strURL = "../html/thms_pop3.html";
		strPos = "dialogWidth:370px;dialogHeight:400px;status:no;scroll:no;resizable:no";

		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {

			arrParam = arrResult.split(";");


							gcds_data03.namevalue(gcds_data03.rowposition,"BID_COM") = arrParam[0];	
							gcds_data03.namevalue(gcds_data03.rowposition,"BID_COM_NM") = arrParam[1];	


		}

</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_bas" event="onclick(row)">
	if (row >0) 
	ln_Query(gcds_bas.namevalue(row,"scode"));
</script>

<script language="javascript" for="gcds_sys" event="OnRowPosChanged(row)">
	ln_Format(gcds_sys.sysStatus(row));
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_sys" event="onsuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	ln_Refresh();
</script>

<script language=JavaScript for=gctr_sys event=OnFail()>
	alert("Error Code : " + gctr_sys.ErrorCode + "\n" + "Error Message : " + gctr_sys.ErrorMsg + "\n");
</script>

</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="1" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px" height="47" background="http://erp.hdasan.com/common/img/com_t_bg.gif">

  <tr> 
			<td width="876" height = "30" align="right" background="http://erp.hdasan.com/common/img/com_t_bg.gif">
						<img src="http://erp.hdasan.com/common/img/btn/com_b_save.gif" style="position:relative;top:3px;cursor:hand" onclick="ln_Save()">
						<img src="http://erp.hdasan.com/common/img/btn/com_b_newadd.gif" style="position:relative;top:3px;cursor:hand" onclick="ln_Add()">
						<img src="http://erp.hdasan.com/common/img/btn/com_b_query.gif" style="position:relative;top:3px;cursor:hand" onclick="ln_Query()">		
						<img src="http://erp.hdasan.com/common/img/btn/com_b_print.gif" style="position:relative;top:3px;cursor:hand" onclick="ln_Print()">
						<img src="http://erp.hdasan.com/common/img/btn/com_b_print2.gif" style="position:relative;top:5px;cursor:hand" onclick="ln_Print2()">
						&nbsp;&nbsp;
			</td>
    </tr>


	<table >
		<tr>
			<td>

				<tr>
					<td>
						<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;left:10px;font-size:9pt;background-color:#ffffff;">
							<tr width="876px"> 
								<td width="80px" style="" bgcolor="#eeeeee" class="tab15" align=center><nobr>&nbsp;현장명</nobr></td>
								<td class="tab18" style="width:200px;" >
									<comment id="__NSID__">
									<object id="gclx_site_s" classid="clsid:60109D65-70C0-425C-B3A4-4CB001513C69" style="position: relative; left: 5px; top: 1px; font-size: 12px; width: 320px">
															<param name="ComboDataID" value="gcds_site_s" />
															<param name="CBDataColumns" value="COM_CODE, COM_SNAME" />
															<param name="SearchColumn" value="COM_SNAME" />
															<param name="Sort" value="false" />
															<param name="Index" value="0" />
															<param name="ListExprFormat" value="COM_SNAME^0^320" />
															<param name="BindColumn" value="COM_CODE" />
									</object>
									</comment><script>__ws__(__NSID__);</script>

								</td>
								<td width="80px" style="" bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;공종명</nobr></td>
								<td class="tab18" style="width:200px;" >
									<comment id="__NSID__">
									<object id="gclx_cnst_s" classid="clsid:60109D65-70C0-425C-B3A4-4CB001513C69" style="position: relative; left: 5px; top: 1px; font-size: 12px; width: 320px">
															<param name="ComboDataID" value="gcds_cnst_s" />
															<param name="CBDataColumns" value="COM_CODE, COM_SNAME" />
															<param name="SearchColumn" value="COM_SNAME" />
															<param name="Sort" value="false" />
															<param name="Index" value="0" />
															<param name="ListExprFormat" value="COM_SNAME^0^320" />
															<param name="BindColumn" value="COM_CODE" />
									</object>
									</comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
					 </table>
					</td>
				</tr>
			</td>
		</tr>
	</table>


  <tr> 
      <table width="500" cellpadding="1" cellspacing="0" border="0">


				<tr> 
					<td valign="top">
						<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:2px;width:430px;">
							<tr>
								<td class="tab21" style="height:30px;width:120px;left:-3px;border:1 solid #708090" bgcolor="#eeeeee" align="center">
								<b>공 사 개 요</b></td>
								<td class="tab22">&nbsp;</td>
							</tr>
						</table>



						<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:2px;width:430px;border:0 solid #708090;border-left-width:1px;">
							<tr>
								<td class="tab21" style="height:30px;width:120px;" bgcolor="#eeeeee">&nbsp;현장명</td>
								<td class="tab21">
								<comment id="__NSID__">
								<object id="gclx_site" classid="clsid:60109D65-70C0-425C-B3A4-4CB001513C69" style="position: relative; left: 5px; top: 1px; font-size: 12px; width:250px">
														<param name="ComboDataID" value="gcds_site" />
														<param name="CBDataColumns" value="COM_CODE, COM_SNAME" />
														<param name="SearchColumn" value="COM_SNAME" />
														<param name="Sort" value="false" />
														<param name="Index" value="0" />
														<param name="ListExprFormat" value="COM_SNAME^0^250" />
														<param name="BindColumn" value="COM_CODE" />
								</object>
								</comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;공종명</td>
								<td class="tab21">
								<comment id="__NSID__">
								<object id="gclx_cnst" classid="clsid:60109D65-70C0-425C-B3A4-4CB001513C69" style="position: relative; left: 5px; top: 1px; font-size: 12px; width:250px">
														<param name="ComboDataID" value="gcds_cnst" />
														<param name="CBDataColumns" value="COM_CODE, COM_SNAME" />
														<param name="SearchColumn" value="COM_SNAME" />
														<param name="Sort" value="false" />
														<param name="Index" value="0" />
														<param name="ListExprFormat" value="COM_SNAME^0^250" />
														<param name="BindColumn" value="COM_CODE" />
								</object>
								</comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;발주처</td>
								<td class="tab21">
								<comment id="__NSID__">
								<object id="gclx_ord" classid="clsid:60109D65-70C0-425C-B3A4-4CB001513C69" style="position: relative; left: 5px; top: 1px; font-size: 12px; width:250px">
														<param name="ComboDataID" value="gcds_ord" />
														<param name="CBDataColumns" value="COM_CODE, COM_SNAME" />
														<param name="SearchColumn" value="COM_SNAME" />
														<param name="Sort" value="false" />
														<param name="Index" value="0" />
														<param name="ListExprFormat" value="COM_SNAME^0^250" />
														<param name="BindColumn" value="COM_CODE" />
								</object>
								</comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;입찰구분</td>
								<td class="tab21">
								<comment id="__NSID__">
								<object id="gclx_bid_style" classid="clsid:60109D65-70C0-425C-B3A4-4CB001513C69" style="position: relative; left: 5px; top: 1px; font-size: 12px; width:250px">
														<param name="ComboDataID" value="gcds_bid_style" />
														<param name="CBDataColumns" value="COM_CODE, COM_SNAME" />
														<param name="SearchColumn" value="COM_SNAME" />
														<param name="Sort" value="false" />
														<param name="Index" value="0" />
														<param name="ListExprFormat" value="COM_SNAME^0^250" />
														<param name="BindColumn" value="COM_CODE" />
								</object>
								</comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;예산</td>
								<td class="tab21">
										<fieldset class=field_01 style="width:150px;  height: 18px;position:relative; left:2px;  top:1px;">
    		    						<comment id="__NSID__">
										<OBJECT id=gcem_act_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:150px;  height: 18px;">
												<param name=Alignment			value=2>
												<param name=Border	      value=false>
												<param name=Numeric value="true">
												<param name=IsComma   value=true>
												<param name=MaxLength value=12>
												<param name=Format	      value="000,000,000,000">
												<param name=PromptChar	  value="">
												<param name=Enable        value="true">
										</OBJECT>
										</comment><script>__ws__(__NSID__);</script>
										</fieldset>	
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;도급공기</td>
								<td class="tab21">
									<comment id="__NSID__">
									<OBJECT id=gcem_fr_date1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:5px;height:20;width:80">
											 <param name=Alignment  value=1>
											 <param name=Enable     value=true>
											 <param name=Format     value="YYYY/MM/DD">
					                 </OBJECT>
									</comment><script>__ws__(__NSID__);</script>																		
									<img src="http://erp.hdasan.com/common/img/btn/com_btn_calender.gif" value="com_btn_calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fr_date1', 'Text')" style="position:relative;width:20px;left:10px;top:5px;cursor:hand;">
									&nbsp;~
									<comment id="__NSID__">
									<OBJECT id=gcem_to_date1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:5px;height:20;width:80">
											 <param name=Alignment  value=1>
											 <param name=Enable     value=true>
											 <param name=Format     value="YYYY/MM/DD">
									</OBJECT>
									</comment><script>__ws__(__NSID__);</script>
									<img src="http://erp.hdasan.com/common/img/btn/com_btn_calender.gif" value="com_btn_calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_to_date1', 'Text')" style="position:relative;width:20px;left:10px;top:5px;cursor:hand;">
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;예가</td>
								<td class="tab21">
										<fieldset class=field_01 style="width:150px;  height: 18px;position:relative; left:2px;  top:1px;">
    		    						<comment id="__NSID__">
										<OBJECT id=gcem_act_amt_ha classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:150px;  height: 18px;">
												<param name=Alignment			value=2>
												<param name=Border	      value=false>
												<param name=Numeric value="true">
												<param name=IsComma   value=true>
												<param name=MaxLength value=12>
												<param name=Format	      value="000,000,000,000">
												<param name=PromptChar	  value="">
												<param name=Enable        value="true">
										</OBJECT>
										</comment><script>__ws__(__NSID__);</script>
										</fieldset>			
										&nbsp;( 예산대비 :
										
									<fieldset class=field_01 style="width:30px;  height: 16px;position:relative; left:2px;  top:1px;">
									<comment id="__NSID__">
									<OBJECT id=gcem_pct1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="gcem_01"
										style="position:relative;height:16px;width:30">
											 <param name=Alignment		value=2>
											 <param name=Border			value=false>
											 <param name=Numeric		value=true>
											 <param name=PromptChar	  value="">
											 <param name=Enable			value=true>
									</OBJECT>
									</comment><script>__ws__(__NSID__);</script>
									</fieldset>												
										%)
								</td>							
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;하도급공기</td>
								<td class="tab21">
									<comment id="__NSID__">
									<OBJECT id=gcem_fr_date2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:5px;height:20;width:80">
											 <param name=Alignment  value=1>
											 <param name=Enable     value=true>
											 <param name=Format     value="YYYY/MM/DD">
					                 </OBJECT>
									</comment><script>__ws__(__NSID__);</script>																		
									<img src="http://erp.hdasan.com/common/img/btn/com_btn_calender.gif" value="com_btn_calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fr_date2', 'Text')" style="position:relative;width:20px;left:10px;top:5px;cursor:hand;">
									&nbsp;~
									<comment id="__NSID__">
									<OBJECT id=gcem_to_date2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:5px;height:20;width:80">
											 <param name=Alignment  value=1>
											 <param name=Enable     value=true>
											 <param name=Format     value="YYYY/MM/DD">
									</OBJECT>
									</comment><script>__ws__(__NSID__);</script>
									<img src="http://erp.hdasan.com/common/img/btn/com_btn_calender.gif" value="com_btn_calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_to_date2', 'Text')" style="position:relative;width:20px;left:10px;top:5px;cursor:hand;">
							</tr>						
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;입찰일자</td>
								<td class="tab21">
									<comment id="__NSID__">
									<OBJECT id=gcem_bid_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:5px;height:20;width:80">
										 <param name=Alignment  value=1>
										 <param name=Enable     value=true>
										 <param name=Format     value="YYYY/MM/DD">
									   </OBJECT>
									   </comment><script>__ws__(__NSID__);</script>
									<img src="http://erp.hdasan.com/common/img/btn/com_btn_calender.gif" value="com_btn_calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_bid_date', 'Text')" style="position:relative;width:20px;left:10px;top:5px;cursor:hand;">
							</tr>
						</table>










					<td>
						<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:0px;width:430px;">
							<tr>
								
								<td class="tab11" style="height:30px;width:120px;border:1 solid #708090" bgcolor="#eeeeee" align="center">
								<b>입찰(견적)결과</b></td>



								<td >
										<img src="http://erp.hdasan.com/common/img/btn/com_b_rowadd.gif" style="position:relative;top:2px;cursor:hand" align="right" onclick="ln_Add3()">
								</td>
							</tr>
					</table>

				<table border="1" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:2px;width:442px;">
					<tr>
						<comment id="__NSID__">
						<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data03 style="position:relative;left:3px;top:2px;WIDTH: 435px; HEIGHT: 380px; border:1 solid #999999" viewastext>
							    <PARAM NAME="DataID"			VALUE="gcds_data03">
							    <PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="editable"      VALUE="true">
								<PARAM NAME="Enable	"		VALUE="True">
								<PARAM NAME="Colsizing"     VALUE="true">
								<PARAM NAME="Indwidth"		VALUE="0">
								<param name="Fillarea"		VALUE="true">
								<PARAM NAME="Format"			VALUE=" 
								<FC>ID=SEQ,	  Name=등수,	 width=35,    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center</FC>					
								<C> Name=결과;(Combo)			ID=RESULT_CP 			HeadAlign=Center HeadBgColor=#B9D4DC Width=45 align=center 
								EditStyle=Combo		Data='1:낙찰,2: '</C>
								<C> Name='업체코드'		ID=BID_COM  				HeadAlign=Center HeadBgColor=#B9D4DC Width=140 align=center show=false</C>								
								<C> Name='업체명'		ID=BID_COM_NM  				HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=center EditStyle=PopupFix</C>
								<C> Name='1차입찰'		ID=BID_AMT 				HeadAlign=Center HeadBgColor=#B9D4DC Width=80 Edit=Numeric </C> 

								<C> Name='예가(%)'		ID=BID_AMT_PCT1 			HeadAlign=Center HeadBgColor=#B9D4DC Width=50 Edit=Numeric show=true align=center</C> 
								<C> Name='예산(%)'		ID=BID_AMT_PCT2 			HeadAlign=Center HeadBgColor=#B9D4DC Width=50 Edit=Numeric show=true align=center</C> 
								
								<C> Name='2차입찰'		ID=BID_AMT2 				HeadAlign=Center HeadBgColor=#B9D4DC Width=80 Edit=Numeric show=true</C> 

								<C> Name='예가(%)'		ID=BID_AMT2_PCT1 			HeadAlign=Center HeadBgColor=#B9D4DC Width=50 Edit=Numeric show=true align=center</C> 
								<C> Name='예산(%)'		ID=BID_AMT2_PCT2 			HeadAlign=Center HeadBgColor=#B9D4DC Width=50 Edit=Numeric show=true align=center</C> 
								<C> Name='비고'		ID=REMARK 				HeadAlign=Center HeadBgColor=#B9D4DC Width=100 Edit=ANY</C> 


							">
						</OBJECT>
						</comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>









<!-----------------------------------------------------------------------------
	  레포트 데이타쉣더퍽   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
	<object id=ReportID classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
		<param name="MasterDataID"		value="gcds_report00">
		<param name="PaperSize"			value="A4">
		<param name="LandScape"			value="false" >
		<param name="PrintSetupDlgFlag" value="true" />
		<param name="ImagSyncFlag"     value="true">
		<param name="PreviewZoom"		value="120" >
		<param name="Format"				value="

<A>id=Area1 ,left=0,top=0 ,right=2000 ,bottom=180
	<R>id='History.sbt' ,left=0 ,top=20 ,right=2000 ,bottom=151, DetailDataID=gcds_report01
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=201 ,face='Tahoma' ,size=10 ,penwidth=1
			<T>id='2. 입찰(견적) 결과' ,left=29 ,top=13 ,right=654 ,bottom=87 ,align='left' ,face='Tahoma' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='순번' ,left=29 ,top=101 ,right=135 ,bottom=201 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
			<T>id='입찰참여업체' ,left=135 ,top=101 ,right=421 ,bottom=201 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
			<T>id='입찰 금액' ,left=421 ,top=101 ,right=1961 ,bottom=151 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
			<T>id='1차 입찰' ,left=421 ,top=151 ,right=720 ,bottom=201 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
			<T>id='예가(%)' ,left=720 ,top=151 ,right=889 ,bottom=201 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
			<T>id='예산(%)' ,left=889 ,top=151 ,right=1061 ,bottom=201 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
			<T>id='2차 입찰' ,left=1061 ,top=151 ,right=1360 ,bottom=201 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
			<T>id='예가(%)' ,left=1360 ,top=151 ,right=1529 ,bottom=201 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
			<T>id='예산(%)' ,left=1529 ,top=151 ,right=1701 ,bottom=201 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
			<T>id='최종금액' ,left=1701 ,top=151 ,right=1961 ,bottom=201 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
			<T>id='[단위 : 원]' ,left=1720 ,top=21 ,right=1955 ,bottom=115 ,align='right' ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=66 ,face='Tahoma' ,size=10 ,penwidth=1
			<C>id='SEQ', left=29, top=0, right=135, bottom=66, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
			<C>id='BID_COM_NM', left=135, top=0, right=421, bottom=66, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
			<C>id='BID_AMT', left=421, top=0, right=720, bottom=66, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
			<C>id='BID_AMT_PCT1', left=720, top=0, right=889, bottom=66, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
			<C>id='BID_AMT_PCT2', left=889, top=0, right=1061, bottom=66, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
			<C>id='BID_AMT2', left=1061, top=0, right=1360, bottom=66, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
			<C>id='BID_AMT2_PCT1', left=1360, top=0, right=1529, bottom=66, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
			<C>id='BID_AMT2_PCT2', left=1529, top=0, right=1701, bottom=66, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
			<C>id='RESULT_AMT', left=1701, top=0, right=1961, bottom=66, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
		</B>
	</R>
</A>


<A>id=Area2 ,left=0,top=0 ,right=2000 ,bottom=200
	<R>id='Member.sbt' ,left=0 ,top=20 ,right=2000 ,bottom=200, DetailDataID=gcds_report02
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=601 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='3. 당사 참석자' ,left=29 ,top=101 ,right=667 ,bottom=180 ,align='left' ,face='Tahoma' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='순 번' ,left=29 ,top=201 ,right=135 ,bottom=302 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='소속부서' ,left=135 ,top=201 ,right=434 ,bottom=302 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='직 책' ,left=434 ,top=201 ,right=1000 ,bottom=302 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='성 명' ,left=1000 ,top=201 ,right=1500 ,bottom=302 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='비 고' ,left=1500 ,top=201 ,right=1961 ,bottom=302 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	
	<T>id='1', left=29, top=302, right=135, bottom=370, border=true, penstyle=solid, penwidth=1, pencolor=#000000</T>
	<T>id='사업지원부', left=135, top=302, right=434, bottom=370, border=true, penstyle=solid, penwidth=1, pencolor=#000000</T>
	<T>id='대 리', left=434, top=302, right=1000, bottom=370, border=true, penstyle=solid, penwidth=1, pencolor=#000000</T>
	<T>id='김 현 재', left=1000, top=302, right=1500, bottom=370, border=true, penstyle=solid, penwidth=1, pencolor=#000000</T>
	<T>id=' ', left=1500, top=302, right=1961, bottom=370, border=true, penstyle=solid, penwidth=1, pencolor=#000000</T>
	
	<T>id='2', left=29, top=370, right=135, bottom=440, border=true, penstyle=solid, penwidth=1, pencolor=#000000</T>	
	<T>id='토목부', left=135, top=370, right=434, bottom=440, border=true, penstyle=solid, penwidth=1, pencolor=#000000</T>
	<T>id='대 리', left=434, top=370, right=1000, bottom=440, border=true, penstyle=solid, penwidth=1, pencolor=#000000</T>
	<T>id='한 정 희', left=1000, top=370, right=1500, bottom=440, border=true, penstyle=solid, penwidth=1, pencolor=#000000</T>
	<T>id=' ', left=1500, top=370, right=1961, bottom=440, border=true, penstyle=solid, penwidth=1, pencolor=#000000</T>
	
	<T>id='3', left=29, top=440, right=135, bottom=510, border=true, penstyle=solid, penwidth=1, pencolor=#000000</T>
	<T>id='사원지원부', left=135, top=440, right=434, bottom=510, border=true, penstyle=solid, penwidth=1, pencolor=#000000</T>
	<T>id='사 원', left=434, top=440, right=1000, bottom=510, border=true, penstyle=solid, penwidth=1, pencolor=#000000</T>
	<T>id='최 경 태', left=1000, top=440, right=1500, bottom=510, border=true, penstyle=solid, penwidth=1, pencolor=#000000</T>
	<T>id=' ', left=1500, top=440, right=1961, bottom=510, border=true, penstyle=solid, penwidth=1, pencolor=#000000</T>
</B>

	</R>
</A>


"/>  


</OBJECT>
</comment><script>__ws__(__NSID__);</script>




<!-----------------------------------------------------------------------------
	  레포트 데이타쉣더퍽   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
	<object id=ReportID2 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
		<param name="MasterDataID"		value="gcds_report10">
		<param name="PaperSize"			value="A4">
		<param name="LandScape"			value="false" >
		<param name="PrintSetupDlgFlag" value="true" />
		<param name="ImagSyncFlag"     value="true">
		<param name="PreviewZoom"		value="90" >
		<param name="Format"				value="

"/>  


</OBJECT>
</comment><script>__ws__(__NSID__);</script>






<!-- 데이타바인드 정의부분  -->

<comment id="__NSID__">
<object id="gcbn_data00" classid="clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49">
<param name="DataID" value="gcds_data00" />
<param name="ActiveBind" value="true" />
<param name="BindInfo" value="
						<C>Col=SITE_CD           			Ctrl=gclx_site										Param=bindcolval</C>
						<C>Col=CNST_CD           			Ctrl=gclx_cnst										Param=bindcolval</C>
						<C>Col=ORDER_CD           		Ctrl=gclx_ord										Param=bindcolval</C>
						<C>Col=BID_STYLE           		Ctrl=gclx_bid_style								Param=bindcolval</C>
						<C>Col=BID_DAY           			Ctrl=gcem_bid_date								Param=Text</C>
						<C>Col=START_DT           		Ctrl=gcem_fr_date1								Param=Text</C>
						<C>Col=END_DT           			Ctrl=gcem_to_date1								Param=Text</C>
						<C>Col=ACT_AMT           			Ctrl=gcem_act_amt								Param=Text</C>
						<C>Col=START_DT_HA           	Ctrl=gcem_fr_date2								Param=Text</C>
						<C>Col=END_DT_HA           		Ctrl=gcem_to_date2								Param=Text</C>
						<C>Col=ACT_AMT_HA           	Ctrl=gcem_act_amt_ha						Param=Text</C>
	" />
</OBJECT>
</comment><script>__ws__(__NSID__);</script>




			  </table>
			</td>
		  </tr>
		</table>
	</body>
</html>


