<%@ page language="java" contentType="text/html;charset=ksc5601" %>
<%
/******************************************************************************
 * 시스템명		: 급여시스템
 * 프로그램ID   : P03000
 * J  S  P		: P030009i
 * 서 블 릿		: 
 * 작 성 자		: 심동현
 * 작 성 일		: 2007-01-11
 * 기능정의		:	ds1) 기본정보 + 기타공제 일부
 					ds2) 종전근무지 
					ds3) 인적공제
					ds4) 기부
 *                   
 * 최종수정일자 	: 2007-01-11

 * 최종수정일자 	: 2009 - 정하나

 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy 		 = request.getParameter("eyy");			//귀속년도
    String eno 		 = request.getParameter("eno");			//사번   
    eyy="2009";
%>

<HTML>
<HEAD>
<TITLE><%=eyy%>년 근로소득공제 신고서 입력</TITLE>
<META http-equiv=Content-Type content="text/html; charset=euc-kr">

<LINK href="imgs/css_ehr.css" type=text/css rel=stylesheet>

<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../common/include/common.css">

<!-- 기존 가우스 시작-->
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>

<Script language="javascript" src="../../common/include/PubFun.js"></script>

<script language="javascript" src="js/PubFun.js"></script>  
 <script language="javascript" src="js/menu.js"></script>
<script language="javascript" src="js/common_pop.js"></script>     
<script language="javascript" src="js/common.js"></script>     
 <SCRIPT language=JavaScript   src="imgs/web.js"></SCRIPT>
<SCRIPT language=JavaScript   src="imgs/06YearEntry.js"></SCRIPT> 
<SCRIPT language="JavaScript" src="imgs/ApplyChk.js"></SCRIPT> 

<script language="javascript" src="js/embedControl.js"></script> 
<script language="javascript" src="js/common_gauce.js"></script> 


<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	var gstrChk =""; //등록
	var gs_level;
	var gs_treecd;
	var g_empno="";
	
	get_cookdata();
	
	var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
	//var gs_date2 = gcurdate.substr(0,4) + gcurdate.substr(5,2);

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
	function ln_Start(){
		//그리드 스타일 넣기
		cfStyleGrid(getObjectFirst("gr1"), "comn");
		cfStyleGrid(getObjectFirst("gr2"), "comn");		
		cfStyleGrid(getObjectFirst("gr3"), "comn");				

		//데이터셋 헤더 설정
		ln_SetDataHeader();
			
		fnSelect("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (개인소득 + 잡다)
		alert(ds1.namevalue(ds1.rowposition, "TAX_PAY"));
		fnSelect2("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (종전근무)
		fnSelect3("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (인적공제)
		fnSelect4("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (기부금)		
	}
	
	function ln_SetDataHeader(){
//		var s_temp = "VD_FAXNO:DECIMAL,POST_NO1:STRING,POST_NO2:STRING,ADDRESS1:STRING,VEND_ID:STRING";
		var s_temp = "REFc1:DECIMAL,REFc2:DECIMAL";
		ds3.SetDataHeader(s_temp);
	}	

	function ln_SetDataHeader_Submit(){
		if (ds7.countrow<1){
			var s_temp = "EMPNO:STRING(10),APPDT:STRING(6),SENDFLAG:STRING(1)";
			ds7.SetDataHeader(s_temp);
		}
	}	

/******************************************************************************
	Description : 기본조회
******************************************************************************/
	function fnSelect(pYear, pEmpno) {	 //기본 조회
	        g_empno = pEmpno ;
			v_job = "S";	//select 일듯..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030009i",	//		경로 주의할 것!
			    "JSP(O:DS1=ds1)",
			    param);
			tr_post(tr1);

			
           
		    /*
			prompt('',ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030009i",	//		경로 주의할 것!
			    "JSP(O:DS1=ds1)",
			    param));

			*/
	}

	function fnSelect2(pYear, pEmpno) {	 //종전근무지
			v_job = "S";	//select 일듯..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030009i",	//	
			    "JSP(O:DS2=ds2)",
			    param);
			tr_post(tr1);
	}	
	
	function fnSelect3(pYear, pEmpno) {	 //인적공제
			v_job = "S";	//select 일듯..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030009i",	//	
			    "JSP(O:DS3=ds3)",
			    param);
			tr_post(tr1);
	}	

	function fnSelect4(pYear, pEmpno) {	 //기부금
			v_job = "S";	//select 일듯..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr2, 
			    "/services/servlet/Payroll.p030009i",	//	
			    "JSP(O:DS4=ds4)",
			    param);
			tr_post(tr2);
	}	


	function fnSelect5(pYear, pEmpno) {	 //출력시 연말정산 인적공제
			v_job = "S";	//select 일듯..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030009i",	//	
			    "JSP(O:DS5=ds5)",
			    param);
			tr_post(tr1);
	}	


	function fnSelect6(pYear, pEmpno) {	 //출력시 연말정산 인적공제외
			v_job = "S";	//select 일듯..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030009i",	//	
			    "JSP(O:DS6=ds6)",
			    param);
			tr_post(tr1);
	}	
	
	
	
/******************************************************************************
	Description : 추가, 삭제, 저장, 취소
******************************************************************************/
    function fnApply() {// 현재 데이터셋 반영
       
        if (ds1.IsUpdated) {

			if(!fnSaveChk()){
				alert("전산 제출이 이미 되었습니다. 수정건이 있으면 전산 관리자에게 문의하십시요.");
				return;
			};
            
			v_job = "I";	
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

            ln_TRSetting(tr1, 
                "/services/servlet/Payroll.p030009i",
                "JSP(I:DS1=ds1,O:RESULT=ds_result)",			//여기의 DS1, RESULT 등이 java 파일의 req.getGauceDataSetKeys() 에서 불러짐.
                param);

            tr_post(tr1);
        } else {
            alert("기본공제 정보의 변경 내역이 없습니다.");
        }
    }
    
	function fnCancel() {	//취소시 undo all. 
		ds1.undoall();
	} 

	function fnAddRow3(){
		ds3.addrow();	
		ds3.namevalue(ds3.rowposition, "APPDT")="<%=eyy%>12";
		ds3.namevalue(ds3.rowposition, "EMPNO")="<%=eno%>";	
		ds3.namevalue(ds3.rowposition, "REF1")="F";
		ds3.namevalue(ds3.rowposition, "REF2")="F";
		ds3.namevalue(ds3.rowposition, "REF3")="F";
		ds3.namevalue(ds3.rowposition, "REF4")="F";
		ds3.namevalue(ds3.rowposition, "REF5")="F";
		ds3.namevalue(ds3.rowposition, "REF6")="F";
		ds3.namevalue(ds3.rowposition, "REF7")="F";
		ds3.namevalue(ds3.rowposition, "REF8")="F"; //2008귀속
	};
	function fnDeleteRow3() {//Row 삭제
		/*if (ds1.namevalue(ds1.rowposition,"close_yn") == "Y") {
        	alert("마감된 자료입니다. 삭제할수 없습니다");
        	ds1.undo(ds1.rowposition);
        	return;
        }*/
		ds3.DeleteRow(ds3.RowPosition);
	}

    function fnApply3() {// 현재 데이터셋 반영
		if(!Basic_Apply_Chk("ds3")) return; //기본 인적공제 체크
		
		if (ds3.IsUpdated) {
			if(!fnSaveChk()){
				alert("전산 제출이 이미 되었습니다. 수정건이 있으면 전산 관리자에게 문의하십시요.");
				return;
			};

			v_job = "I";	
        
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

            ln_TRSetting(tr1, 
                "/services/servlet/Payroll.p030009i",
                "JSP(I:DS3=ds3,O:RESULT=ds_result)",	//여기의 DS1, RESULT 등이 java 파일의 req.getGauceDataSetKeys() 에서 불러짐.
                param);

            tr_post(tr1);
        } else {
            alert("인적공제 정보의 변경 내역이 없습니다.");
        }
    };

	function fnCancel3() {	//취소시 undo all. 
		ds3.undoall();
	};


	function fnSubmit(){ //전산제출
		if(confirm("전산 제출한 후에는 데이타 입력,수정,삭제가 불가합니다.\n\n전산제출을 하시겠습니까?")){
			ln_SetDataHeader_Submit();

			ds7.Addrow();
			ds7.namevalue(ds7.rowposition,"EMPNO")=ds1.namevalue(ds1.rowposition,"EMPNO");
			ds7.namevalue(ds7.rowposition,"APPDT")=ds1.namevalue(ds1.rowposition,"APPDT");

			if (ds7.IsUpdated) {
				v_job = "I";	
				var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

				ln_TRSetting(tr1, 
					"/services/servlet/Payroll.p030009i",
					"JSP(I:DS7=ds7,O:RESULT=ds_result)",	//여기의 DS1, RESULT 등이 java 파일의 req.getGauceDataSetKeys() 에서 불러짐.
					param);
				tr_post(tr1);
			} else {
				alert("전산제출 할 수 없습니다.");
			}
		}
	}

	function fnSaveChk(){ //저장전 전산제출구분체크
		v_job = "S";	  //select 일듯..
		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				  + ",eyy="       + <%=eyy%>
				  + ",eno="       + <%=eno%> ;
        
		ln_TRSetting(tr1, 
			"/services/servlet/Payroll.p030009i",	//		경로 주의할 것!
			"JSP(O:DS9=ds9)",
			param);
		tr_post(tr1);

		if(ds9.namevalue(ds9.rowposition,"SENDFLAG")=="Y"){
			return false;
		}else{
            return true;
	    }
	}

	function fnPrint(){ //출력물
   
        /*


	    if(fnSaveChk()){
			alert("전산제출 이전입니다. 전산제출 후 출력하십시요.");
			return;
		};

        */

        //출력 직전에 작업을 돌린다.
		ds_print.ClearAll();
        fnSelect5("<%=eyy%>", "<%=eno%>");   //근로소득신고서 출력-기본(인적공제)
		fnSelect6("<%=eyy%>", "<%=eno%>");   //근로소득신고서 출력-기본
        var row=0;
		ln_Rpt_SetDataHeader();//데이타 셋헤드 
        ds_print.addrow();
 
        //인사 기본정보 
		row = ds_print.rowposition;
		row1 = ds6.rowposition;
		ds_print.namevalue(row,"EMPNO")=ds6.namevalue(ds1.rowposition,"EMPNO")
		ds_print.namevalue(row,"YYYY")="<%=eyy%>";
		ds_print.namevalue(row,"EMPNMK")=ds6.namevalue(row1,"EMPNMK");
		ds_print.namevalue(row,"EMPJUNO")=ds6.namevalue(row1,"EMPJUNO");
		ds_print.namevalue(row,"COMPANY")="현대아산(주)";
		ds_print.namevalue(row,"COMRESINO")=ds6.namevalue(row1,"COMRESINO");
		ds_print.namevalue(row,"CURDT3")=ds6.namevalue(row1,"CURDT3"); //근무시작일
		ds_print.namevalue(row,"CURDT")="20091231" //근무종료일
	//	ds_print.namevalue(row,"CNT")=ds5.countrow;
		ds_print.namevalue(row,"CNT")=ds6.namevalue(row1,"CNT");
		ds_print.namevalue(row,"CURDT2") = gs_date;
        var dblref11=0;
		var dblref12=0;
		var dblref13=0;
		var dblref14=0;
		var dblref15=0;
		var dblref16=0;
		var dblref21=0;
		var dblref22=0;
		var dblref23=0;
		var dblref24=0;
		var dblref26=0;
  
        var i=0;

		for(i=1;i<=ds5.countrow;i++){
         
          ds_print.namevalue(row,"RELAT1_"+i)=ds5.namevalue(i,"RELAT1");

		  if(ds5.namevalue(i,"REF1")=="T")ds_print.namevalue(row,"REF1_"+i)="9"; //내.외국인
		  else ds_print.namevalue(row,"REF1_"+i)="1";

		  if(ds5.namevalue(i,"REF2")=="T")ds_print.namevalue(row,"REF2_"+i)="O"; //기본공제
		  else ds_print.namevalue(row,"REF2_"+i)="";

		  if(ds5.namevalue(i,"REF3")=="T")ds_print.namevalue(row,"REF3_"+i)="O"; //장애인
		  else ds_print.namevalue(row,"REF3_"+i)="";

		  if(ds5.namevalue(i,"REF5")=="T")ds_print.namevalue(row,"REF5_"+i)="O"; //경로우대
		  else ds_print.namevalue(row,"REF5_"+i)=""; 

		  if(i>1){
            if(ds5.namevalue(i,"REF4")=="T")ds_print.namevalue(row,"REF4_"+i)="O"; //자녀양육비
		    else ds_print.namevalue(row,"REF4_"+i)="";

			if(ds5.namevalue(i,"REF7")=="T")ds_print.namevalue(row,"REF7_"+i)="O"; //다자녀
		    else ds_print.namevalue(row,"REF7_"+i)="";

			if(ds5.namevalue(i,"REF8")=="T")ds_print.namevalue(row,"REF8_"+i)="O"; //출산입양
		    else ds_print.namevalue(row,"REF8_"+i)="";

            ds_print.namevalue(row,"EMPNMK_"+i) = ds5.namevalue(i,"FAMNM1");
			ds_print.namevalue(row,"EMPJUNO_"+i) = ds5.namevalue(i,"RESINO1");
		    
		  }else if(i==1){
            if(ds5.namevalue(i,"REF6")=="T")ds_print.namevalue(row,"REF6_"+i)="O"; //부녀자
		    else ds_print.namevalue(row,"REF6_"+i)=""; 
		  }

		  ds_print.namevalue(row,"REF11_"+i)=ds5.namevalue(i,"REF11");
		  ds_print.namevalue(row,"REF12_"+i)=ds5.namevalue(i,"REF12");
		  ds_print.namevalue(row,"REF13_"+i)=ds5.namevalue(i,"REF13");
		  ds_print.namevalue(row,"REF14_"+i)=ds5.namevalue(i,"REF14");
		  ds_print.namevalue(row,"REF15_"+i)=ds5.namevalue(i,"REF15");
		  ds_print.namevalue(row,"REF16_"+i)=ds5.namevalue(i,"REF16");

		  ds_print.namevalue(row,"REF21_"+i)=ds5.namevalue(i,"REF21");
		  ds_print.namevalue(row,"REF22_"+i)=ds5.namevalue(i,"REF22");
		  ds_print.namevalue(row,"REF23_"+i)=ds5.namevalue(i,"REF23");
		  ds_print.namevalue(row,"REF24_"+i)=ds5.namevalue(i,"REF24");
		  ds_print.namevalue(row,"REF26_"+i)=ds5.namevalue(i,"REF26");

		  dblref11 += parseInt(ds5.namevalue(i,"REF11"));
		  dblref12 += parseInt(ds5.namevalue(i,"REF12"));
		  dblref13 += parseInt(ds5.namevalue(i,"REF13"));
		  dblref14 += parseInt(ds5.namevalue(i,"REF14"));
		  dblref15 += parseInt(ds5.namevalue(i,"REF15"));
		  dblref16 += parseInt(ds5.namevalue(i,"REF16"));

		  dblref21 += parseInt(ds5.namevalue(i,"REF21"));
		  dblref22 += parseInt(ds5.namevalue(i,"REF22"));
		  dblref23 += parseInt(ds5.namevalue(i,"REF23"));
		  dblref24 += parseInt(ds5.namevalue(i,"REF24"));
          dblref26 += parseInt(ds5.namevalue(i,"REF26"));
		}

        ds_print.namevalue(row,"REF11_S") = dblref11;  //보험료(국세청자료)
		ds_print.namevalue(row,"REF12_S") = dblref12;  //의료비
		ds_print.namevalue(row,"REF13_S") = dblref13;  //교육비
		ds_print.namevalue(row,"REF14_S") = dblref14;  //신용카드
		ds_print.namevalue(row,"REF15_S") = dblref15;  //현금영수증
		ds_print.namevalue(row,"REF16_S") = dblref16;  //기부금
		ds_print.namevalue(row,"REF21_S") = dblref21;  //보험료(그밖의자료)
		ds_print.namevalue(row,"REF22_S") = dblref22;  //의료비            
		ds_print.namevalue(row,"REF23_S") = dblref23;  //교육비            
		ds_print.namevalue(row,"REF24_S") = dblref24;  //신용카드          
		ds_print.namevalue(row,"REF26_S") = dblref26;  //기부금     

        
		//2009.01.06 사용하지 않음.//2009.12.21 사용 정하나 
		ds_print.namevalue(row,"GIVAMT1_1") = ds6.namevalue(row1,"GIVAMT1_1"); //기부금(국세청자료)
		ds_print.namevalue(row,"GIVAMT2_1") = ds6.namevalue(row1,"GIVAMT2_1"); //기부금(그밖의자료)

		/*연금보험료공제*/
        ds_print.namevalue(row,"BP31000") =ds6.namevalue(row1,"BP31000");//종전근무지(국민연금)
		ds_print.namevalue(row,"PENSUM") = ds6.namevalue(row1,"PENSUM"); //주현근무지(국민연금)
		ds_print.namevalue(row,"PENTOT") = parseInt(ds6.namevalue(row1,"BP31000"))+parseInt(ds6.namevalue(row1,"PENSUM")); //합계
        
				 
		ds_print.namevalue(row,"BP34000") =ds6.namevalue(row1,"BP34000");//종전근무지(퇴직연금)
		
		/*특별공제 - 보험료*/
		ds_print.namevalue(row,"BP32000") =ds6.namevalue(row1,"BP32000");//종전근무지(건강보험)
		ds_print.namevalue(row,"BP33000") =ds6.namevalue(row1,"BP33000");//종전근무지(고용보험)
		ds_print.namevalue(row,"INSAMT01") =ds6.namevalue(row1,"INSAMT01");//현근무지(건강보험)
		ds_print.namevalue(row,"INSAMT02") =ds6.namevalue(row1,"INSAMT02");//현근무지(고용보금)
		ds_print.namevalue(row,"INSAMT03") =ds6.namevalue(row1,"INSAMT03");//현근무지(일반보장성보험)
		ds_print.namevalue(row,"INSAMT04") =ds6.namevalue(row1,"INSAMT04");//현근무지(장애인보장성보험)

		if(parseInt(ds6.namevalue(row1,"INSAMT03"))>1000000){
			ds_print.namevalue(row,"INSAMT03S")=1000000;
		}else{
            ds_print.namevalue(row,"INSAMT03S")=ds6.namevalue(row1,"INSAMT03");
		}
		if(parseInt(ds6.namevalue(row1,"INSAMT04"))>1000000){
			ds_print.namevalue(row,"INSAMT04S")=1000000;
		}else{
            ds_print.namevalue(row,"INSAMT04S")=ds6.namevalue(row1,"INSAMT04");
		}
        
		//보험료계
		ds_print.namevalue(row,"INSSUM") = parseInt(ds_print.namevalue(row,"BP32000"))+parseInt(ds_print.namevalue(row,"BP33000"))
			                             + parseInt(ds_print.namevalue(row,"INSAMT01"))+parseInt(ds_print.namevalue(row,"INSAMT02"))
			                             + parseInt(ds_print.namevalue(row,"INSAMT03"))+parseInt(ds_print.namevalue(row,"INSAMT04"));
	    //보험료공제계
		ds_print.namevalue(row,"INSSUMS")= parseInt(ds_print.namevalue(row,"BP32000"))+parseInt(ds_print.namevalue(row,"BP33000"))
			                             + parseInt(ds_print.namevalue(row,"INSAMT01"))+parseInt(ds_print.namevalue(row,"INSAMT02"))
			                             + parseInt(ds_print.namevalue(row,"INSAMT03S"))+parseInt(ds_print.namevalue(row,"INSAMT04S"));

		/*특별공제 - 의료비*/
		ds_print.namevalue(row,"M_AMT1") =ds6.namevalue(row1,"M_AMT1");//본인.경로.장애인
		ds_print.namevalue(row,"M_AMT2") =ds6.namevalue(row1,"M_AMT2");//그밖의공제대상자
		ds_print.namevalue(row,"M_AMT3") =ds6.namevalue(row1,"M_AMT3");//신용카드
		ds_print.namevalue(row,"M_AMT4") =ds6.namevalue(row1,"M_AMT4");//현금
		ds_print.namevalue(row,"M_SUM")  =ds6.namevalue(row1,"M_SUM"); //신용카드 + 현금
		ds_print.namevalue(row,"M_SUMS") =ds6.namevalue(row1,"M_SUMS");//공제계

		/*특별공제 - 교육비*/
		ds_print.namevalue(row,"E_AMT1") =ds6.namevalue(row1,"E_AMT1");//본인
		ds_print.namevalue(row,"E_AMT2") =ds6.namevalue(row1,"E_AMT2");//취학전
		ds_print.namevalue(row,"E_AMT3") =ds6.namevalue(row1,"E_AMT3");//초중고
		ds_print.namevalue(row,"E_AMT4") =ds6.namevalue(row1,"E_AMT4");//대학생
		ds_print.namevalue(row,"E_AMT5") =ds6.namevalue(row1,"E_AMT5");//장애인
		ds_print.namevalue(row,"E_SUM") = parseInt(ds6.namevalue(row1,"E_AMT1"))+ parseInt(ds6.namevalue(row1,"E_AMT2"))+ parseInt(ds6.namevalue(row1,"E_AMT3"))
			                            + parseInt(ds6.namevalue(row1,"E_AMT4"))+ parseInt(ds6.namevalue(row1,"E_AMT5"));
		//인원
		ds_print.namevalue(row,"E_CNT2") =ds6.namevalue(row1,"E_CNT2");//취학전
		ds_print.namevalue(row,"E_CNT3") =ds6.namevalue(row1,"E_CNT3");//초중고
		ds_print.namevalue(row,"E_CNT4") =ds6.namevalue(row1,"E_CNT4");//대학생
		ds_print.namevalue(row,"E_CNT5") =ds6.namevalue(row1,"E_CNT5");//장애인

		//공제금액
		ds_print.namevalue(row,"E_AMT1S") =ds6.namevalue(row1,"E_AMT1S"); //본인    
		ds_print.namevalue(row,"E_AMT2S") =ds6.namevalue(row1,"E_AMT2S");//취학전  
		ds_print.namevalue(row,"E_AMT3S") =ds6.namevalue(row1,"E_AMT3S");//초중고  
		ds_print.namevalue(row,"E_AMT4S") =ds6.namevalue(row1,"E_AMT4S");//대학생  
		ds_print.namevalue(row,"E_AMT5S") =ds6.namevalue(row1,"E_AMT5S");//장애인  
		ds_print.namevalue(row,"E_SUMS") = parseInt(ds6.namevalue(row1,"E_AMT1S"))+ parseInt(ds6.namevalue(row1,"E_AMT2S"))+ parseInt(ds6.namevalue(row1,"E_AMT3S"))
			                             + parseInt(ds6.namevalue(row1,"E_AMT4S"))+ parseInt(ds6.namevalue(row1,"E_AMT5S"));

		/*특별공제 - 주택자금*/
		ds_print.namevalue(row,"H_AMT1") =ds6.namevalue(row1,"H_AMT1"); //주택마련저축  
		ds_print.namevalue(row,"H_AMT2") =ds6.namevalue(row1,"H_AMT2"); //차입금  
		ds_print.namevalue(row,"H_AMT3") =ds6.namevalue(row1,"H_AMT3"); //저당차입금  
		 

        //공제금액
		ds_print.namevalue(row,"H_AMT1S") =ds6.namevalue(row1,"H_AMT1S"); //주택마련저축
		ds_print.namevalue(row,"H_AMT2S") =ds6.namevalue(row1,"H_AMT2S"); //차입금      
		ds_print.namevalue(row,"H_AMT3S") =ds6.namevalue(row1,"H_AMT3S"); //저당차입금
		ds_print.namevalue(row,"H_AMT4S") =ds6.namevalue(row1,"H_AMT4S"); //저당차입금  		
		ds_print.namevalue(row,"H_AMT5S") =ds6.namevalue(row1,"H_AMT5S"); //저당차입금  	
		ds_print.namevalue(row,"H_SUMS") =ds6.namevalue(row1,"H_SUMS"); //계 

		/*특별공제 - 기부금*/
		ds_print.namevalue(row,"CONAMT02") =ds6.namevalue(row1,"CONAMT02"); //정치자금기부금
		ds_print.namevalue(row,"G_AMT1") =ds6.namevalue(row1,"G_AMT1"); //전액공제  
		ds_print.namevalue(row,"G_AMT2") =ds6.namevalue(row1,"G_AMT2"); //50%한도공제  
		ds_print.namevalue(row,"G_AMT3") =ds6.namevalue(row1,"G_AMT3"); //30%한도공제
		ds_print.namevalue(row,"CONAMT06") =ds6.namevalue(row1,"CONAMT06"); //종교단체 외
		ds_print.namevalue(row,"CONAMT07") =ds6.namevalue(row1,"CONAMT07"); //종교단체		
		//ds_print.namevalue(row,"G_AMT4") =ds6.namevalue(row1,"G_AMT4"); //지정기부금공제  

		//alert("G_AMT1::"+ds_print.namevalue(row,"G_AMT1"));

        //공제금액
		ds_print.namevalue(row,"CONAMT02S") =ds6.namevalue(row1,"CONAMT02S"); //정치자금기부금
		ds_print.namevalue(row,"G_AMT1S") =ds6.namevalue(row1,"G_AMT1S"); //전액공제      
		ds_print.namevalue(row,"G_AMT2S") =ds6.namevalue(row1,"G_AMT2S"); //50%한도공제   
		ds_print.namevalue(row,"G_AMT3S") =ds6.namevalue(row1,"G_AMT3S"); //30%한도공제  
		ds_print.namevalue(row,"CONAMT06S") =ds6.namevalue(row1,"CONAMT06S"); //종교단체 외
		ds_print.namevalue(row,"CONAMT07S") =ds6.namevalue(row1,"CONAMT07S"); //종교단체			
		//ds_print.namevalue(row,"G_AMT4S") =ds6.namevalue(row1,"G_AMT4S"); //10%한도공제  
		ds_print.namevalue(row,"G_SUMS") =ds6.namevalue(row1,"G_SUMS");  //계
        
		/*특별공제 - 혼인비.이사비.장례비*/
		ds_print.namevalue(row,"W_SUMS") =ds6.namevalue(row1,"W_SUMS"); //공제

		/*그밖의공제 -  소기업 소상공인 공제부금 소득공제*/
		ds_print.namevalue(row,"SM_AMT") =ds6.namevalue(row1,"SM_AMT"); //불입액
		ds_print.namevalue(row,"SM_AMT") =ds6.namevalue(row1,"SM_AMTS"); //공제금액

		/*그밖의공제 - 연금저축공제*/
		ds_print.namevalue(row,"S_AMT1") =ds6.namevalue(row1,"S_AMT1");  //개인연금저축
		ds_print.namevalue(row,"S_AMT2") =ds6.namevalue(row1,"S_AMT2");  //연금저축
		ds_print.namevalue(row,"S_SUM") =ds6.namevalue(row1,"S_SUM");   //연금공제계

        //연금저축공제
		ds_print.namevalue(row,"S_AMT1S") =ds6.namevalue(row1,"S_AMT1S");  //개인연금저축
		ds_print.namevalue(row,"S_AMT2S") =ds6.namevalue(row1,"S_AMT2S");  //연금저축
		ds_print.namevalue(row,"S_SUMS") =ds6.namevalue(row1,"S_SUMS");   //연금공제계

		/*그밖의공제 - 투자조합출자공제*/
		ds_print.namevalue(row,"T_SUM") =ds6.namevalue(row1,"T_SUM");    //투자조합
		ds_print.namevalue(row,"T_SUMS")=ds6.namevalue(row1,"T_SUMS");   //투자조합공제

		/*그밖의공제 - 신용카드소득공제*/
		ds_print.namevalue(row,"C_AMT1")=ds6.namevalue(row1,"C_AMT1");    //신용.직불.선불
		ds_print.namevalue(row,"C_AMT2")=ds6.namevalue(row1,"C_AMT2");    //현금영수증
		ds_print.namevalue(row,"C_AMT3")=ds6.namevalue(row1,"C_AMT3");    //학원지로납부
		ds_print.namevalue(row,"C_AMT4")=ds6.namevalue(row1,"C_AMT4");    //의료비중복배제 ==> 2008년 귀속분부터 사업관련비용으로 변경
		ds_print.namevalue(row,"C_SUM")=ds6.namevalue(row1,"C_SUM");      //계
		ds_print.namevalue(row,"C_SUMS")=ds6.namevalue(row1,"C_SUMS");    //신용카드공제

		/*그밖의공제 - 우리사주 출연금 소득공제*/
		ds_print.namevalue(row,"D_SUM")=ds6.namevalue(row1,"D_SUM");       //계
		ds_print.namevalue(row,"D_SUMS")=ds6.namevalue(row1,"D_SUMS");     //공제계

        /*그밖의공제 - 장기주식형저축소득공제*/
		ds_print.namevalue(row,"FD_AMT1")=ds6.namevalue(row1,"FD_AMT1");   //납입1년차
		ds_print.namevalue(row,"FD_AMT2")=ds6.namevalue(row1,"FD_AMT2");   //납입2년차
		ds_print.namevalue(row,"FD_AMT3")=ds6.namevalue(row1,"FD_AMT3");   //납입3년차
		ds_print.namevalue(row,"FD_SUM")=ds6.namevalue(row1,"FD_SUM");     //납입합계
		ds_print.namevalue(row,"FD_AMT1S")=ds6.namevalue(row1,"FD_AMT1S"); //납입1년차공제
		ds_print.namevalue(row,"FD_AMT2S")=ds6.namevalue(row1,"FD_AMT2S"); //납입2년차공제
		ds_print.namevalue(row,"FD_AMT3S")=ds6.namevalue(row1,"FD_AMT3S"); //납입3년차공제
		ds_print.namevalue(row,"FD_SUMS")=ds6.namevalue(row1,"FD_SUMS");   //납입합계공제

		/*그밖의공제 - 퇴직연금 소득공제*/
		ds_print.namevalue(row,"F_SUM")=ds6.namevalue(row1,"F_SUM");       //계
		ds_print.namevalue(row,"F_SUMS")=ds6.namevalue(row1,"F_SUMS");     //공제계
        
		/*세액공제 - 외국납부세액*/
		ds_print.namevalue(row,"FX_AMT1")=ds6.namevalue(row1,"FX_AMT1");  
		ds_print.namevalue(row,"FX_AMT2")=ds6.namevalue(row1,"FX_AMT2");      
		ds_print.namevalue(row,"FX_NATION")=ds6.namevalue(row1,"FX_NATION");      
		ds_print.namevalue(row,"FX_DATE1")=ds6.namevalue(row1,"FX_DATE1");      
		ds_print.namevalue(row,"FX_DATE2")=ds6.namevalue(row1,"FX_DATE2"); 
        ds_print.namevalue(row,"FX_WORK")=ds6.namevalue(row1,"FX_WORK");     
		ds_print.namevalue(row,"FX_FRTO")=ds6.namevalue(row1,"FX_FRTO");      
		ds_print.namevalue(row,"FX_POSITION")=ds6.namevalue(row1,"FX_POSITION");      

		/*세액공제 - 주택자금차입금이자세액공제*/
		ds_print.namevalue(row,"HX_AMT")=ds6.namevalue(row1,"HX_AMT");  
		ds_print.namevalue(row,"HX_AMTS")=ds6.namevalue(row1,"HX_AMTS");  //공제

		/*세액공제 - 기부정치자금*/
		ds_print.namevalue(row,"GX_AMT")=ds6.namevalue(row1,"GX_AMT");  
		ds_print.namevalue(row,"GX_AMTS")=ds6.namevalue(row1,"GX_AMTS");  //공제

		/*종전근무지 정보*/
		ds_print.namevalue(row,"WKNM") =ds6.namevalue(row1,"WKNM");        //종전근무지명
		ds_print.namevalue(row,"WKRESINO") =ds6.namevalue(row1,"WKRESINO");//사업자등록번호
		ds_print.namevalue(row,"WK_AMT") =ds6.namevalue(row1,"WK_AMT");    //종전 총급여액
 		ds_print.namevalue(row,"WK_AMTSD") =ds6.namevalue(row1,"WK_AMTSD");    //종전 결정세액

		getObjectFirst("gcrp_print").preview();
	}

	function ln_Rpt_SetDataHeader(){ //출력물 데이타 셋헤드 생성
		var ls_temp = "";
		if (ds_print.countrow<1){
			ds_print.SetDataHeader(ls_temp);
			ls_temp1 = "EMPNO:STRING(7),YYYY:STRING(4),EMPNMK:STRING(20),EMPJUNO:STRING(13),COMPANY:STRING(50),COMRESINO:STRING(10),CURDT3:STRING(8),CURDT2:STRING(8),CURDT:STRING(8),"     
					 + "REF11_S:DECIMAL(9.0),REF12_S:DECIMAL(9.0),REF13_S:DECIMAL(9.0),REF14_S:DECIMAL(9.0),REF15_S:DECIMAL(9.0),REF16_S:DECIMAL(9.0),"
					 + "REF21_S:DECIMAL(9.0),REF22_S:DECIMAL(9.0),REF23_S:DECIMAL(9.0),REF24_S:DECIMAL(9.0),REF26_S:DECIMAL(9.0),"
                     + "CNT:INT(2),GIVAMT1_1:DECIMAL(9.0),GIVAMT2_1:DECIMAL(9.0),"		 
					 + "RELAT1_1:STRING(1),REF1_1:STRING(1),REF2_1:STRING(1),REF3_1:STRING(1),REF5_1:STRING(1),REF6_1:STRING(1),REF7_1:STRING(1),REF8_1:STRING(1),"
					 + "REF11_1:DECIMAL(9.0),REF12_1:DECIMAL(9.0),REF13_1:DECIMAL(9.0),REF14_1:DECIMAL(9.0),REF15_1:DECIMAL(9.0),REF16_1:DECIMAL(9.0),"
					 + "REF21_1:DECIMAL(9.0),REF22_1:DECIMAL(9.0),REF23_1:DECIMAL(9.0),REF24_1:DECIMAL(9.0),REF26_1:DECIMAL(9.0),"
                     + "EMPNMK_2:STRING(20),EMPJUNO_2:STRING(13),"
					 + "RELAT1_2:STRING(1),REF1_2:STRING(1),REF2_2:STRING(1),REF3_2:STRING(1),REF4_2:STRING(1),REF5_2:STRING(1),REF7_2:STRING(1),REF8_2:STRING(1),"
					 + "REF11_2:DECIMAL(9.0),REF12_2:DECIMAL(9.0),REF13_2:DECIMAL(9.0),REF14_2:DECIMAL(9.0),REF15_2:DECIMAL(9.0),REF16_2:DECIMAL(9.0),"
					 + "REF21_2:DECIMAL(9.0),REF22_2:DECIMAL(9.0),REF23_2:DECIMAL(9.0),REF24_2:DECIMAL(9.0),REF26_2:DECIMAL(9.0),"
					 + "EMPNMK_3:STRING(20),EMPJUNO_3:STRING(13),"
					 + "RELAT1_3:STRING(1),REF1_3:STRING(1),REF2_3:STRING(1),REF3_3:STRING(1),REF4_3:STRING(1),REF5_3:STRING(1),REF7_3:STRING(1),REF8_3:STRING(1),"
					 + "REF11_3:DECIMAL(9.0),REF12_3:DECIMAL(9.0),REF13_3:DECIMAL(9.0),REF14_3:DECIMAL(9.0),REF15_3:DECIMAL(9.0),REF16_3:DECIMAL(9.0),"
					 + "REF21_3:DECIMAL(9.0),REF22_3:DECIMAL(9.0),REF23_3:DECIMAL(9.0),REF24_3:DECIMAL(9.0),REF26_3:DECIMAL(9.0),"
					 + "EMPNMK_4:STRING(20),EMPJUNO_4:STRING(13),"
					 + "RELAT1_4:STRING(1),REF1_4:STRING(1),REF2_4:STRING(1),REF3_4:STRING(1),REF4_4:STRING(1),REF5_4:STRING(1),REF7_4:STRING(1),REF8_4:STRING(1),"
					 + "REF11_4:DECIMAL(9.0),REF12_4:DECIMAL(9.0),REF13_4:DECIMAL(9.0),REF14_4:DECIMAL(9.0),REF15_4:DECIMAL(9.0),REF16_4:DECIMAL(9.0),"
					 + "REF21_4:DECIMAL(9.0),REF22_4:DECIMAL(9.0),REF23_4:DECIMAL(9.0),REF24_4:DECIMAL(9.0),REF26_4:DECIMAL(9.0),"
					 + "EMPNMK_5:STRING(20),EMPJUNO_5:STRING(13),"
					 + "RELAT1_5:STRING(1),REF1_5:STRING(1),REF2_5:STRING(1),REF3_5:STRING(1),REF4_5:STRING(1),REF5_5:STRING(1),REF7_5:STRING(1),REF8_5:STRING(1),"
					 + "REF11_5:DECIMAL(9.0),REF12_5:DECIMAL(9.0),REF13_5:DECIMAL(9.0),REF14_5:DECIMAL(9.0),REF15_5:DECIMAL(9.0),REF16_5:DECIMAL(9.0),"
					 + "REF21_5:DECIMAL(9.0),REF22_5:DECIMAL(9.0),REF23_5:DECIMAL(9.0),REF24_5:DECIMAL(9.0),REF26_5:DECIMAL(9.0),"
					 + "EMPNMK_6:STRING(20),EMPJUNO_6:STRING(13),"
					 + "RELAT1_6:STRING(1),REF1_6:STRING(1),REF2_6:STRING(1),REF3_6:STRING(1),REF4_6:STRING(1),REF5_6:STRING(1),REF7_6:STRING(1),REF8_6:STRING(1),"
					 + "REF11_6:DECIMAL(9.0),REF12_6:DECIMAL(9.0),REF13_6:DECIMAL(9.0),REF14_6:DECIMAL(9.0),REF15_6:DECIMAL(9.0),REF16_6:DECIMAL(9.0),"
					 + "REF21_6:DECIMAL(9.0),REF22_6:DECIMAL(9.0),REF23_6:DECIMAL(9.0),REF24_6:DECIMAL(9.0),REF26_6:DECIMAL(9.0),"
					 + "EMPNMK_7:STRING(20),EMPJUNO_7:STRING(13),"
					 + "RELAT1_7:STRING(1),REF1_7:STRING(1),REF2_7:STRING(1),REF3_7:STRING(1),REF4_7:STRING(1),REF5_7:STRING(1),REF7_7:STRING(1),REF8_7:STRING(1),"
					 + "REF11_7:DECIMAL(9.0),REF12_7:DECIMAL(9.0),REF13_7:DECIMAL(9.0),REF14_7:DECIMAL(9.0),REF15_7:DECIMAL(9.0),REF16_7:DECIMAL(9.0),"
					 + "REF21_7:DECIMAL(9.0),REF22_7:DECIMAL(9.0),REF23_7:DECIMAL(9.0),REF24_7:DECIMAL(9.0),REF26_7:DECIMAL(9.0),"
					 + "EMPNMK_8:STRING(20),EMPJUNO_8:STRING(13),"
					 + "RELAT1_8:STRING(1),REF1_8:STRING(1),REF2_8:STRING(1),REF3_8:STRING(1),REF4_8:STRING(1),REF5_8:STRING(1),REF7_8:STRING(1),REF8_8:STRING(1),"
					 + "REF11_8:DECIMAL(9.0),REF12_8:DECIMAL(9.0),REF13_8:DECIMAL(9.0),REF14_8:DECIMAL(9.0),REF15_8:DECIMAL(9.0),REF16_8:DECIMAL(9.0),"
					 + "REF21_8:DECIMAL(9.0),REF22_8:DECIMAL(9.0),REF23_8:DECIMAL(9.0),REF24_8:DECIMAL(9.0),REF26_8:DECIMAL(9.0),"
					 + "EMPNMK_9:STRING(20),EMPJUNO_9:STRING(13),"
					 + "RELAT1_9:STRING(1),REF1_9:STRING(1),REF2_9:STRING(1),REF3_9:STRING(1),REF4_9:STRING(1),REF5_9:STRING(1),REF7_9:STRING(1),REF8_9:STRING(1),"
					 + "REF11_9:DECIMAL(9.0),REF12_9:DECIMAL(9.0),REF13_9:DECIMAL(9.0),REF14_9:DECIMAL(9.0),REF15_9:DECIMAL(9.0),REF16_9:DECIMAL(9.0),"
					 + "REF21_9:DECIMAL(9.0),REF22_9:DECIMAL(9.0),REF23_9:DECIMAL(9.0),REF24_9:DECIMAL(9.0),REF26_9:DECIMAL(9.0),"
					 + "EMPNMK_10:STRING(20),EMPJUNO_10:STRING(13),"
					 + "RELAT1_10:STRING(1),REF1_10:STRING(1),REF2_10:STRING(1),REF3_10:STRING(1),REF4_10:STRING(1),REF5_10:STRING(1),REF7_10:STRING(1),REF8_10:STRING(1),"
					 + "REF11_10:DECIMAL(9.0),REF12_10:DECIMAL(9.0),REF13_10:DECIMAL(9.0),REF14_10:DECIMAL(9.0),REF15_10:DECIMAL(9.0),REF16_10:DECIMAL(9.0),"
					 + "REF21_10:DECIMAL(9.0),REF22_10:DECIMAL(9.0),REF23_10:DECIMAL(9.0),REF24_10:DECIMAL(9.0),REF26_10:DECIMAL(9.0),"
					 + "BP31000:DECIMAL(9.0),PENSUM:DECIMAL(9.0),PENTOT:DECIMAL(9.0),"
					 + "BP32000:DECIMAL(9.0),INSAMT01:DECIMAL(9.0),BP33000:DECIMAL(9.0),BP34000:DECIMAL(9.0),INSAMT02:DECIMAL(9.0),INSAMT03:DECIMAL(9.0),"
					 + "INSAMT03S:DECIMAL(9.0),INSAMT04:DECIMAL(9.0),INSAMT04S:DECIMAL(9.0),INSSUM:DECIMAL(9.0),INSSUMS:DECIMAL(9.0),"
					 + "M_AMT1:DECIMAL(9.0),M_AMT2:DECIMAL(9.0),M_SUM:DECIMAL(9.0),M_SUMS:DECIMAL(9.0),M_AMT3:DECIMAL(9.0),M_AMT4:DECIMAL(9.0),"
					 + "E_CNT2:DECIMAL(9.0),E_CNT3:DECIMAL(9.0),E_CNT4:DECIMAL(9.0),E_CNT5:DECIMAL(9.0)"
					 + "E_AMT1:DECIMAL(9.0),E_AMT1S:DECIMAL(9.0),E_AMT2:DECIMAL(9.0),E_AMT2S:DECIMAL(9.0),E_AMT3:DECIMAL(9.0),E_AMT3S:DECIMAL(9.0),"
					 + "E_AMT4:DECIMAL(9.0),E_AMT4S:DECIMAL(9.0),E_AMT5:DECIMAL(9.0),E_AMT5S:DECIMAL(9.0),E_SUM:DECIMAL(9.0),E_SUMS:DECIMAL(9.0),"
					 + "H_AMT1:DECIMAL(9.0),H_AMT1S:DECIMAL(9.0),H_AMT2:DECIMAL(9.0),H_AMT2S:DECIMAL(9.0),H_AMT3:DECIMAL(9.0),H_AMT3S:DECIMAL(9.0),H_SUMS:DECIMAL(9.0),"
					 +"CONAMT02:DECIMAL(9.0),CONAMT02S:DECIMAL(9.0),G_AMT1:DECIMAL(9.0),G_AMT1S:DECIMAL(9.0),G_AMT2:DECIMAL(9.0),G_AMT2S:DECIMAL(9.0),G_AMT3:DECIMAL(9.0),G_AMT3S:DECIMAL(9.0),"
  				     +"CONAMT06:DECIMAL(9.0),CONAMT06S:DECIMAL(9.0),CONAMT07:DECIMAL(9.0),CONAMT07S:DECIMAL(9.0),E_AMT5:DECIMAL(9.0),G_SUMS:DECIMAL(9.0),"
					 + "W_SUMS:DECIMAL(9.0),"
					 + "SM_AMT1:DECIMAL(9.0),SM_AMTS:DECIMAL(9.0),"
					 + "S_AMT1:DECIMAL(9.0),S_AMT1S:DECIMAL(9.0),S_AMT2:DECIMAL(9.0),S_AMT2S:DECIMAL(9.0),S_SUM:DECIMAL(9.0),S_SUMS:DECIMAL(9.0),"
					 + "T_SUM:DECIMAL(9.0),T_SUMS:DECIMAL(9.0),"
					 + "C_AMT1:DECIMAL(9.0),C_AMT2:DECIMAL(9.0),C_AMT3:DECIMAL(9.0),C_AMT4:DECIMAL(9.0),C_SUM:DECIMAL(9.0),C_SUMS:DECIMAL(9.0),"
					 + "D_SUM:DECIMAL(9.0),D_SUMS:DECIMAL(9.0),"
                     + "FD_AMT1:DECIMAL(9.0),FD_AMT1S:DECIMAL(9.0),FD_AMT2:DECIMAL(9.0),FD_AMT2S:DECIMAL(9.0),FD_AMT3:DECIMAL(9.0),FD_AMT3S:DECIMAL(9.0),FD_SUM:DECIMAL(9.0),FD_SUMS:DECIMAL(9.0),"
					 + "F_SUM:DECIMAL(9.0),F_SUMS:DECIMAL(9.0),"
					 + "FX_AMT1:DECIMAL(9.0),FX_AMT2:DECIMAL(9.0),FX_NATION:STRING(30),FX_DATE1:STRING(8),FX_DATE2:STRING(8),"
					 + "FX_WORK:STRING(30),FX_FRTO:STRING(12),FX_POSITION:STRING(30),"
					 + "HX_AMT:DECIMAL(9.0),HX_AMTS:DECIMAL(9.0),GX_AMT:DECIMAL(9.0),GX_AMTS:DECIMAL(9.0),"
					 + "WKNM:STRING(30),WKRESINO:STRING(10),WK_AMT:DECIMAL(9.0),WK_AMTSD:DECIMAL(9.0)";
			
			ds_print.SetDataHeader(ls_temp1);
		}
	}

    //주민번호 년월일 앞에 년도 붙이기
    function ln_yyyymmdd(strGb,strGb2,strResino){

        //주민번호로 생년월일 만들기 (yyyymmdd)
		if(strGb==3||strGb==4){ //2000년생
           strResino="20"+strResino;
		}else if(strGb==5||strGb==6){ //외국인
		   if(strGb2>="00"&&strGb2<="10"){ //임의로 10년도 까지만
			 strResino="20"+strResino;
		   }else{
             strResino="19"+strResino;
		   }
		}else{
		    strResino="19"+strResino; //그 외.  
		}
		return strResino;
	}
   

/******************************************************************************
	Description : 각 팝업창 띄우기
******************************************************************************/
function openOfc(){
	dest = "P030009_ofc1.jsp?eyy=<%=eyy%>&eno=<%=eno%>";
	window.open(dest,"ofc", "left=0,top=0,width=704,height=750,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openInsu(juno){
	dest = "P030009_insu1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"ofc", "left=0,top=0,width=800,height=560,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openMedi(juno){
	dest = "P030009_medi1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"ofc", "left=0,top=0,width=1000,height=600,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openEdu(juno){
	dest = "P030009_edu1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"ofc", "left=0,top=0,width=850,height=560,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openCard(juno){
	dest = "P030009_card1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"ofc", "left=0,top=0,width=840,height=660,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openGibu(){
	dest = "P030009_gibu1.jsp?eyy=<%=eyy%>&eno=<%=eno%>";
	window.open(dest,"gibu", "left=0,top=0,width=1004,height=600,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

//참고사항(기본공제)
function openBasic(){
	dest = "P030009_basic_ref1.jsp?eyy=<%=eyy%>&eno=<%=eno%>";
	window.open(dest,"basic", "left=0,top=0,width=704,height=600,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

//사용자 메뉴얼
function ln_Manual(){
	window.open('./files/YearManual.hwp','','resizable=yes,width=800,height=600,scrollbars=no,status=no');
}
</script>

<script language="javascript"  for="gr3" event="OnExit(row,colid,olddata)">
//주민번호 입력시 자동설정 - 경로우대, 자녀, 형제
    var strResino="";
	var strGb="";
	var strGb2="";

	if(colid =="RESINO1"){
		
		//2008.12.29 jys
        //주민번호 체크
        if(ds3.namevalue(row, "REF1")=="T"){ //외국인
            if(!gn_FgResino(ds3.namevalue(row, "RESINO1"))) return;
		}else{ //내국인
			if(!gn_Resino(ds3.namevalue(row, "RESINO1"))) return;
		}

		strResino = ds3.namevalue(row, "RESINO1");
		//strResino = strResino.substring(0,6);
        strGb = strResino.substring(6,7);
		strGb2 = strResino.substring(0,2);
		strResino = strResino.substring(0,6);
		strResino = ln_yyyymmdd(strGb,strGb2,strResino);

		//alert("strResino::"+strResino);
       
		//경로우대
		if(strResino<="19391231"){ //2009년도 기준
			ds3.namevalue(row,"REF5")="T";
		}else{
            ds3.namevalue(row,"REF5")="F";
		}

		//자녀양육비 (직계비속,입양자,직계비속외, 위탁아동이면서, 20030101 이후
		if((ds3.namevalue(row, "RELAT1")=="4"||ds3.namevalue(row, "RELAT1")=="5"||ds3.namevalue(row, "RELAT1")=="7")&& strResino>="20030101"){
			ds3.namevalue(row,"REF4")="T";
		}else{
			ds3.namevalue(row,"REF4")="F";
	    }

        //출산 입양
		if((ds3.namevalue(row, "RELAT1")=="4"||ds3.namevalue(row, "RELAT1")=="5")&& strResino>="20090101"){
			ds3.namevalue(row,"REF8")="T";
		}else{
			ds3.namevalue(row,"REF8")="F";
	    }

	}


</script>
 
 
<script language=javascript for="gr3" event="OnClick(row, Colid)">
//인적공제 클릭할 때 팝업 띄우기
    var strResino="";
	var strGb="";
	var strGb2="";

    if(row<1){
     return;
    }
	//본인 - 자녀양육비 및 다자녀 체크 안됨.
	//2008 - 출산 추가 됨
	if(ds3.namevalue(row,"RELAT1")=="0"||ds3.namevalue(row,"RELAT1")=="1"){
		if((Colid=="REF4")||(Colid=="REF7")||(Colid=="REF8")){
			ds3.namevalue(row,"REF4")="F";
			ds3.namevalue(row,"REF7")="F";
			ds3.namevalue(row,"REF8")="F";
		}
	}
	

	//자녀양육비 체크
	//직계비속 또는 입양자,위탁아동이며 주민번호가 2003.1.1 이후 출생만 가능
    if((Colid=="REF4")){    
		if(ds3.namevalue(row, "RESINO1")!=""){
			strResino = ds3.namevalue(row, "RESINO1");
			strGb = strResino.substring(6,7);
			strGb2 = strResino.substring(0,2);
			strResino = strResino.substring(0,6);
			strResino = ln_yyyymmdd(strGb,strGb2,strResino);
            
			if(ds3.namevalue(row,"REF4")=="F") return;

			 //자녀양육비 
			if((ds3.namevalue(row, "RELAT1")=="4"||ds3.namevalue(row, "RELAT1")=="5"||ds3.namevalue(row, "RELAT1")=="7")&&strResino>="20030101"){ //2009년도 기준
				ds3.namevalue(row,"REF4")="T";
			}else{
				ds3.namevalue(row,"REF4")="F";
			}
		}
	}
	 
	  

	//경로자우대체크
    if((Colid=="REF5")){    
		if(ds3.namevalue(row, "RESINO1")!=""){
			strResino = ds3.namevalue(row, "RESINO1");
			//strResino = strResino.substring(0,6);
			strGb = strResino.substring(6,7);
			strGb2 = strResino.substring(0,2);
			strResino = strResino.substring(0,6);
			strResino = ln_yyyymmdd(strGb,strGb2,strResino);

			 //경로우대
			if(strResino<="19391231"){ //2009년도 기준
				ds3.namevalue(row,"REF5")="T";
			}else{
				ds3.namevalue(row,"REF5")="F";
			}
		}
	}
	
   
	//부녀자공제 체크
	if((Colid=="REF6")){    
		//본인 - 남자일 경우 부녀자 공제 안됨.
        if(ds3.namevalue(row,"RELAT1")=="0"){
			strResino = ds3.namevalue(row, "RESINO1");
			if(strResino==""){
				ds3.namevalue(row,"REF6")="F";	
				alert("주민등록번호 부터 입력하십시요.");
				return;
			}else{
			   var strResino_chk = strResino.substring(6,7);
			   if(strResino_chk=="2"||strResino_chk=="4"){
				 // alert(ds3.namevalue(row,"REF6"));
				 // if(ds3.namevalue(row,"REF6")=="T") ds3.namevalue(row,"REF6")="F";		
				 // else ds3.namevalue(row,"REF6")="T";		
			   }else ds3.namevalue(row,"REF6")="F";		
			}
		}else{
			ds3.namevalue(row,"REF6")="F";	
		}
	}

   
	//다자녀
	//직계비속 및 년도체크 & 자녀 일 경우만 가능
	if((Colid=="REF7")){
      
	   strResino = ds3.namevalue(row, "RESINO1");
	   if(strResino==""){
		  ds3.namevalue(row,"REF7")="F";	
		  alert("주민등록번호 부터 입력하십시요.");
		  return;
	   }
		strGb = strResino.substring(6,7);
		strGb2 = strResino.substring(0,2);
		strResino = strResino.substring(0,6);
		strResino = ln_yyyymmdd(strGb,strGb2,strResino);

        /*
		if(g_empno=="3080141"){
            alert("strResino:::"+strResino);
			alert("REF2:::"+ds3.namevalue(row,"REF2"));
			alert("RELAT1:::"+ds3.namevalue(row,"RELAT1"));
		}
		*/

        if(ds3.namevalue(row,"REF7")=="F") return;

       //기본공제 & 직계비속 & 주민번호가 2009년 이상인 경우만 가능 
	    if(ds3.namevalue(row,"REF2")=="T"&&ds3.namevalue(row,"RELAT1")=="4"){
			if(strResino>="19890101"){ //2009년도 기준
			
			}else{
				ds3.namevalue(row,"REF7")="F";
			}

	    }else{
		   ds3.namevalue(row,"REF7")="F";	
	    }
	}



	//출산입양 공제 체크
	if((Colid=="REF8")){
	   strResino = ds3.namevalue(row, "RESINO1");
	   if(strResino==""){
		  ds3.namevalue(row,"REF8")="F";	
		  alert("주민등록번호 부터 입력하십시요.");
		  return;
	   }
	   strResino = strResino.substring(0,2);
       //기본공제 & 직계비속 & 주민번호가 2009년 이상인 경우만 가능 
	   if(ds3.namevalue(row,"REF2")=="T"&&(ds3.namevalue(row,"RELAT1")=="4"||ds3.namevalue(row,"RELAT1")=="5")&&strResino=="09"){
		
	   }else{
		   ds3.namevalue(row,"REF8")="F";	
	   }
	}


    //alert("SysStatus::"+ds3.SysStatus(row));
	//alert("FLAGCOL::"+ds3.namevalue(row,"FLAGCOL"));

    if(ds3.SysStatus(row)==1&&ds3.namevalue(row,"FLAGCOL")==""){ // 저장전
		if ((Colid =="REF11") || (Colid =="REF21") || (Colid =="REF12") || (Colid == "REF22")||(Colid =="REF13") || (Colid == "REF23")||(Colid =="REFc1")||(Colid == "REFc2") ) {
				alert("인적공제 대상자정보를 먼저 입력/저장 후 상세입력창을 띄워주세요.");
				return;		
		};
	}

	if ( (Colid =="REF11") || (Colid =="REF21") || (Colid =="REF12") || (Colid == "REF22")||(Colid =="REF13") || (Colid == "REF23")||(Colid =="REFc1")||(Colid == "REFc2") ) {
		if (ds3.namevalue(ds3.rowposition, "RESINO1").length < 13) {
			alert("인적공제 대상자정보를 먼저 입력/저장 후 상세입력창을 띄워주세요.");
			return;
		};
	};

    
    if ((Colid =="REF11") || (Colid =="REF21")) { 
//    	alert("보험료");
    	openInsu(ds3.namevalue(ds3.rowposition, "RESINO1"));
    } else if ((Colid =="REF12") || (Colid == "REF22")) {
//    	alert("의료비");    
		openMedi(ds3.namevalue(ds3.rowposition, "RESINO1"));
    } else if ((Colid =="REF13") || (Colid == "REF23")) {	
//    	alert("교육비");    
		openEdu(ds3.namevalue(ds3.rowposition, "RESINO1"));
    } else if ((Colid =="REFc1") || (Colid == "REFc2")) {
//    	alert("카드/현");    
		openCard(ds3.namevalue(ds3.rowposition, "RESINO1"));
	}
//    alert(ds3.namevalue(ds3.rowposition, "REF11"));
//REF11,21,12,22,13,23,14,24
</script>

<script language="javascript" for="tr1" event="onsuccess()">
	if(ds1.countrow > 0) {
//		getObjectFirst("dspImg").style.display="none";
	} else {
//		getObjectFirst("dspImg").style.display="";
	}
    if(v_job=="I") {	//저장
	    gf_msg();
        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
		fnSelect("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (개인소득 + 잡다)
//		fnSelect2("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (종전근무)
		fnSelect3("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (인적공제)
//		fnSelect4("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (기부금)		
    }  else if(v_job == "H" || v_job=="S") {
        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
    };	
	// 여기까지 테스트 완료 : ds_result에 대한 선언도 다 해주어야 오류가 안난다.~
</script>

<script language="javascript" for="tr2" event="onsuccess()">
	if(ds1.countrow > 0) {
//		getObjectFirst("dspImg").style.display="none";
	} else {
//		getObjectFirst("dspImg").style.display="";
	}
    if(v_job=="I") {	//저장
	    gf_msg();1
        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
						//		fnSelect("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (개인소득 + 잡다)
//		fnSelect2("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (종전근무)
		fnSelect3("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (인적공제)
//		fnSelect4("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (기부금)		
    }  else if(v_job == "H" || v_job=="S") {
        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
    };	
	// 여기까지 테스트 완료 : ds_result에 대한 선언도 다 해주어야 오류가 안난다.~
</script>

<script language=JavaScript  for=ds_result event="OnLoadCompleted(row)" >
// 결과 메세지 확인...
    if(row==0) return;
    var v_yn = "";
    var v_msg = "";
    for(var i=1; i<=row; i++){
        if(ds_result.NameValue(i, "MSG_CD")!="0000"){
            v_msg += ds_result.NameValue(i, "MSG")+"\n";
        }
    }
    if(v_msg!=""){
        alert(v_msg);
    }
</script>
<script language=javascript for=ds4 event="OnLoadCompleted(row)">
	if(row==0) return;

    var intGIVAMT_10A=ds4.namevalue(row,"GIVAMT_10A");
	var intGIVAMT_10B=ds4.namevalue(row,"GIVAMT_10B");
	var intGIVAMT_30A=ds4.namevalue(row,"GIVAMT_30A");
	var intGIVAMT_30B=ds4.namevalue(row,"GIVAMT_30B");
	var intGIVAMT_42A=ds4.namevalue(row,"GIVAMT_42A");
	var intGIVAMT_42B=ds4.namevalue(row,"GIVAMT_42B");
	var intGIVAMT_40A=ds4.namevalue(row,"GIVAMT_40A");
	var intGIVAMT_40B=ds4.namevalue(row,"GIVAMT_40B");

    var intCOMSUM = parseInt(intGIVAMT_10A) + parseInt(intGIVAMT_10B)+ parseInt(intGIVAMT_30A) + parseInt(intGIVAMT_30B)
	              + parseInt(intGIVAMT_42A) + parseInt(intGIVAMT_42B)+ parseInt(intGIVAMT_40A) + parseInt(intGIVAMT_40B);
	
	getObjectFirst("CONSUM").text= intCOMSUM;

</script>


<script language=JavaScript for=gcrp_print event=OnError()>

// alert("Error Code = " + gcrp_print.ErrorCode + "\n" + "Error Message = " + gcrp_print.ErrorMsg);

</script>

<%=HDConstant.COMMENT_START%>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds_print classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>

<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 메세지 -->
    <param name="SyncLoad"  value="false">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object id=ds_result2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 메세지 -->
    <param name="SyncLoad"  value="false">
</object>
<%=HDConstant.COMMENT_END%>

<BODY text=#000000 bgColor=#ffffff style='padding:0px' OnLoad="ln_Start()"> 
<FORM name=entry action="" method=post>
	<INPUT type=hidden value=2007 name=eyy> 
	<INPUT type=hidden value=200089 name=eno> <!-- 사번 -->

<%=HDConstant.COMMENT_START%>
<OBJECT id=gr1  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 636px; HEIGHT: 60px;border:1 solid #777777;display:NONE;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds1">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<C> Name='년월'				ID=APPDT   		Width=63	</C>    
	<C> Name='사번'				ID=EMPNO  		Width=60	</C>    
	<C> Name='소속부서'			ID=DEPTCD  		Width=60	</C>    
	<C> Name='직위'				ID=PAYGRD  		Width=60	</C>    
	<C> Name='그룹입사일'			ID=JOINDATE  	Width=60	</C>    
	<C> Name='성명'				ID=EMPNMK  		Width=40	</C>    
	<C> Name='주민번호'			ID=EMPJUNO  	Width=60	</C> 	
	<C> Name='전화번호'			ID=TELNUM	  	Width=60	</C>
	<C> Name='주소'				ID=ADDRESS  	Width=60	</C>
	<C> Name='과세급여'			ID=TAX_PAY  	Width=80	</C>
	<C> Name='과세상여'			ID=TAX_BNS  	Width=60	</C>
	<C> Name='과세소득계'			ID=TAX_SUM  	Width=60	</C>
	<C> Name='비과세소득계'		ID=NTAX_SUM  	Width=60	</C>
	<C> Name='갑근세'  			ID=DEDUCT1 		Width=60	</C>	
	<C> Name='주민세'  			ID=DEDUCT2 		Width=60	</C>	
	<C> Name='국민연금'			ID=DEDUCT3 		Width=60	</C>                                                             
	<C> Name='건강보험'			ID=DEDUCT4 		Width=60	</C>
	<C> Name='고용보험'			ID=DEDUCT5  	Width=60	</C>
	<C> Name='주택마련저축액'		ID=HOUAMT01 		Width=63	</C>    
	<C> Name='주택차입금상환'		ID=HOUAMT02 		Width=60	</C>    
	<C> Name='주택저당차임6'		ID=HOUAMT03 		Width=60	</C>    
	<C> Name='주택저당차임10'		ID=HOUAMT04 		Width=60	</C>
	<C> Name='주택저당차임15'		ID=HOUAMT05 		Width=60	</C> 	
	<C> Name='주택자금계'			ID=HOUSUM 	     	Width=60	</C>    
	<C> Name='기부금계'			ID=CONSUM	 		Width=60	</C>
	<C> Name='개인연금'			ID=ETCAMT011A    	Width=40	</C>    
	<C> Name='연금저축'			ID=ETCAMT01A 		Width=60	</C>
	<C> Name='주택차입금(세액'		ID=DEDAMT03 		Width=60	</C>
	<C> Name='정치기부금(세액'		ID=DEDAMT04		Width=60	</C>	
	
	<C> Name='Flag'	    		ID=FLAGCOL		Width=20	</C>		
	">
</OBJECT>	

<OBJECT id=gr2  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 636px; HEIGHT: 60px;border:1 solid #777777;display:NONE;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds2">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<C> Name='근무처명'			ID=BF_WKNM     			Width=60	</C>    
	<C> Name='사업자등'			ID=BF_RESINO			Width=60	</C> 
	<C> Name='과세급여'			ID=BF_TAX_PAY			Width=60	</C>    
	<C> Name='과세상여'			ID=BF_TAX_BNS			Width=60	</C> 
	<C> Name='과세소득'			ID=BF_TAX_SUM 			Width=60	</C>    
	<C> Name='비과세소'			ID=BF_NTAX_SUM 			Width=60	</C> 
	<C> Name='결정소득'			ID=BF_DEDUCT1   		Width=60	</C>    
	<C> Name='결정주민'			ID=BF_DEDUCT2			Width=60	</C> 
	<C> Name='국민연금'			ID=BF_DEDUCT3			Width=60	</C>    
	<C> Name='건강보험'			ID=BF_DEDUCT4			Width=60	</C> 
	<C> Name='건강보험'			ID=BF_DEDUCT5			Width=60	</C>
	">
</OBJECT>	

<OBJECT id=gr4  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 636px; HEIGHT: 60px;border:1 solid #777777;display:NONE;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds4">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<C> Name='100%한도 국세청'	ID=GIVAMT_10A 	Width=60	</C>    
	<C> Name='100%한도 그밖'	ID=GIVAMT_10B	Width=60	</C>    
	<C> Name='50%한도 국세청'	ID=GIVAMT_30A	Width=60	</C>    
	<C> Name='50%한도 그밖'		ID=GIVAMT_30B	Width=60	</C> 
	<C> Name='30%한도 국세청'	ID=GIVAMT_42A	Width=60	</C>    
	<C> Name='30%한도 그밖'		ID=GIVAMT_42B	Width=60	</C> 
	<C> Name='10%한도 국세청'	ID=GIVAMT_40A	Width=60	</C>    
	<C> Name='10%한도 그밖'		ID=GIVAMT_40B 	Width=60	</C>    
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>

<TABLE cellSpacing=0 cellPadding=0 width=854 border=0>
  <TR>
    <TD vAlign=top width=1003 bgColor=#ffffff height=62>

	  <TABLE cellSpacing=0 cellPadding=0 width=1003 align=center border=0>
        <TR>
          <TD><IMG src="imgs/tit_01_14.gif"></TD>
		  <TD align=right>
		    <!--  <img src="./imgs/btn_menu.gif"	style="cursor:hand;position:relative;left:-5px" onmouseover="this.src='./imgs/btn_menu.gif'"	onmouseout="this.src='./imgs/btn_menu.gif'"		onclick="ln_Manual()"> -->
			 <img src="./imgs/btn_menu9.gif"	style="cursor:hand;position:relative;left:-5px" onmouseover="this.src='./imgs/btn_menu9.gif'"	onmouseout="this.src='./imgs/btn_menu9.gif'"		onclick="ln_Manual()">
		  </TD>
		</TR>
		<!-- <TR>
		  <TD colspan=2 align=right>
		    <img src="../Sales/images/print.gif"	style="cursor:hand;position:relative;left:-7px"	align=absmiddle onClick="fnPrint()">
		  </TD>
		</TR> -->

	  </TABLE>
	  
	  
	  <BR>
	  <!--인적사항 -->
      <TABLE cellSpacing=1 cellPadding=3 width=1003 bgColor=#666666 border=0>
        <TR align=CENTER bgColor=#e8f3ff>
          <TD width=30 bgColor=#aad2ff rowSpan=4>인적<BR>사항 
          <TD width=82>사원번호</TD>
          <TD width=160>소속</TD>
          <TD width=140>직위</TD>
          <TD width=106>그룹입사일</TD>
          <TD width=140>성명</TD>
          <TD width=150>주민등록번호</TD>
          <TD>전화번호</TD></TR>
        <TR align=CENTER bgColor=#ffffff>
      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="EMPNO" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
				<param name=Text 			value="">
				<param name=Alignment 		value=1>
				<param name=FORMAT 			value="0000000">
				<param name=Numeric			value="false">
				<param name=Border	 		value="false">		
				<param name=InheritColor    value="true">																																																				
				<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="DEPTCD" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="PAYGRD" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="JOINDATE" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="EMPNMK" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="EMPJUNO" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
				<param name=Text 			value="">
				<param name=Alignment 		value=1>
				<param name=FORMAT 			value="000000-0000000">
				<param name=Numeric			value="false">
				<param name=Border	 		value="false">		
				<param name=InheritColor    value="true">																																																				
				<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="TELNUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
				<param name=Text 			value="">
				<param name=Alignment 		value=1>
				<param name=FORMAT 			value="000000000000">
				<param name=Numeric			value="false">
				<param name=Border	 		value="false">		
				<param name=InheritColor    value="true">																																																				
				<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
        </TR>
        <TR align=CENTER bgColor=#e8f3ff>
          <TD colSpan=4>주 소</TD>
          <TD colSpan=3>&nbsp;</TD></TR>
        <TR align=CENTER bgColor=#ffffff>
          <TD colSpan=4><%=HDConstant.COMMENT_START%>
				<object id="ADDRESS" style= "position:relative;left:0px;top:2px;width:465px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%></TD>
          <TD colSpan=3>&nbsp;</TD>
		</TR>
	  </TABLE>
		  
	
	<!-- 근로소득 -->
	  <TABLE cellSpacing=1 cellPadding=3 width=1003 bgColor=#666666 border=0>
        <TR align=CENTER>
          <TD width=30 bgColor=#aad2ff rowSpan=2>구분</TD>
          <TD bgColor=#aad2ff colSpan=4><%=eyy%>년 근로소득</TD>
          <TD bgColor=#aad2ff colSpan=5><%=eyy%>년 원천징수</TD>
          <TD bgColor=#aad2ff>&nbsp;</TD></TR>
        <TR align=CENTER bgColor=#e8f3ff>
          <TD width=79>과세급여</TD>
          <TD width=79>과세상여</TD>
          <TD width=79>과세소득 계</TD>
          <TD width=79>비과세소득 계</TD>
          <TD width=79>갑근세</TD>
          <TD width=79>주민세</TD>
          <TD width=79>국민연금</TD>
          <TD width=79>건강보험</TD>
          <TD width=79>고용보험</TD>
          <TD>&nbsp;</TD>
		</TR>
        <TR align=CENTER>
          <TD bgColor=#e8f3ff>금액</TD>
						<td class="tab28" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_pb10000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:80px; height:20px; font-family:굴림; font-size:9pt;"> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="0,000,000,000">
								<param name=MaxLength     value=10>
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="TAX_BNS" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="TAX_SUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="NTAX_SUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT1" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT2" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT3" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT4" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT5" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff>&nbsp;</TD>
		</TR>
        <TR bgColor=#ffffff>
          <TD colSpan=14><!--
						&nbsp;&nbsp;☞ 참고사항 <br>
						&nbsp;&nbsp;&nbsp;&nbsp;① 주 식 소 득 : 2004년 연말정산시 우리사주조합 소득공제를 받았던 사람이
						2006년 ESOP주식 인출하여 발생한 소득은 &quot;근로소득&quot;에 합산됩니다. <br>
						&nbsp;&nbsp;&nbsp;&nbsp;② 비과세소득 : 육원 - 해외근무자 월 100만원, 자녀보육수당 10만원 / 해원 - 외국항해 선원 월 150만원,
						황열접종비 등 기타 비과세소득 <br>-->
			&nbsp;&nbsp;<!-- <FONT color=#ff6633>☞ 위 금액은 12월 급여 지급 전 조회자료이므로 2007년 최종 확정 금액이 아닙니다.</FONT> --> </TD>
		  </TR>
	  </TABLE><BR><BR>

	  <TABLE cellSpacing=1 cellPadding=3 width=1003 border=0>
        <TR bgColor=#ffffff>
          <TD colSpan=6><B>I. 당해년도 "경력입사자 및 근무처가 2곳 이상인 경우" 전(종)근무지 소득 및 원천징수 현황을 입력바랍니다.</B>
		                <BR><FONT color=#3366ff>&nbsp;&nbsp;☞ 상세내용 조회 및 등록을 할려면</FONT> <FONT color=#ff6633> <B>작성</B></FONT> <FONT color=#3366ff>버튼을 누르세요.</FONT>
					   </TD></TR>
        <TR bgColor=#ffffff>
          <TD></TD>
          <TD width=25></TD>
          <TD></TD>
          <TD width=40></TD>
          <TD></TD>
          <TD width=930 align="right"><img src="./imgs/btn_write2.gif" style="cursor:hand" align=absmiddle onClick="openOfc()"></TD>
		 </TR>
	  </TABLE><!-- 전근무지 원천징수 현황 -->
      <TABLE cellSpacing=1 cellPadding=3 width=1003 bgColor=#666666 border=0>
        
        <TR align=CENTER>
          <TD width=30 bgColor=#ffedd2 rowSpan=2>구분</TD>
          <TD bgColor=#ffedd2 colSpan=2  onclick="openOfc();" style="cursor:hand"><b>회사명</b></TD>
          <TD bgColor=#ffffff colSpan=2><%=HDConstant.COMMENT_START%>
				<object id="BF_WKNM" style= "position:relative;left:0px;top:2px;width:265px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffedd2 colSpan=2>사업자등록번호</TD>
          <TD bgColor=#ffffff colSpan=2><%=HDConstant.COMMENT_START%>
				<object id="BF_RESINO" style= "position:relative;left:0px;top:2px;width:165px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffedd2>&nbsp;</TD></TR>
        <TR align=CENTER bgColor=#ffedd2>
          <TD align=CENTER>과세급여</TD>
          <TD align=CENTER>과세상여</TD>
          <TD align=CENTER>과세소득 계</TD>
          <TD align=CENTER>비과세소득 계</TD>
          <TD align=CENTER>결정갑근세</TD>
          <TD align=CENTER>결정주민세</TD>
          <TD align=CENTER>국민연금</TD>
          <TD align=CENTER>건강보험</TD>
          <TD align=CENTER>고용보험</TD></TR>
        <TR align=left>
          <TD align=CENTER bgColor=#ffedd2>금액</TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_TAX_PAY" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_TAX_BNS" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_TAX_SUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_NTAX_SUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT1" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT2" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT3" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT4" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT5" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

		</TR>
	  </TABLE>


	  <BR>
	  <BR>

	  <!-- 인적사항 및 공제항목 -->
      <TABLE cellSpacing=1 cellPadding=3 width=1003 border=0>
        
        <TR bgColor=#ffffff>
          <TD width=800><B>Ⅱ. 다음 본인과 부양가족의 인적사항 및 공제 항목을 선택(√) 또는 입력바랍니다.</B> 
          </TD>
          <TD vAlign=bottom align=right></TD>
          <TD vAlign=bottom align=right></TD></TR>
        <TR>
          <TD width=900><FONT color=#3366ff>&nbsp;&nbsp;☞ 주의사항 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;① "정산절차안내"를 반드시 숙지하신 후 입력바랍니다. 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;② 입력 및 수정후에는 반드시 "저장" 버튼을 눌러주시기 바랍니다. 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#ff6633><B>※&nbsp;국세청 자료란 : 
            국세청 홈페이지에서 제공하는 증빙서류상의 금액 
            입력</B></FONT>
			<BR>&nbsp;&nbsp;&nbsp;&nbsp;<B>※&nbsp;그밖의 자료란 : 국세청에서 
            제공하는 증빙서류 이외의 것 입력</B> </FONT>
			<BR>&nbsp;&nbsp;&nbsp;&nbsp;<B>※&nbsp;행추가 할 경우 반드시 인적사항,기본공제,추가공제 입력 후 저장 버튼을 눌러 저장하십시요. <BR>
			    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;그 후 특별공제(보험료, 의료비, 교육비, 카드/현금)를 입력하십시요.  
			<BR>&nbsp;&nbsp;&nbsp;<B>※&nbsp;추가공제의 자녀-자녀양육비, 출산-출산·입양, 다자녀-다자녀추가 공제를 의미합니다.
			</FONT>
            <BR>&nbsp;&nbsp;&nbsp;<FONT color=#ff6633><B>※&nbsp;관계 : 
            당해연도부터 위탁아동이 부양가족에 추가되었습니다. 동거입양자는 직계비속자녀, 위탁아동은 기타에 포함 됩니다.
            </B></FONT>
		  </TD>

          <TD vAlign=bottom align=right colSpan=2><!-- <A 
            href="javascript:showDiv('write_guide',%20'../../images/Self/btn_guideclose.gif',%20'../../images/Self/btn_guideopen.gif');"><IMG 
            id=imgsrc src="imgs/btn_guideopen.gif" border=0></A> -->
        </TD></TR></TABLE>

      <!-- Hidden Start///////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
      <DIV id=write_guide style="DISPLAY: none">
      <TABLE cellSpacing=1 cellPadding=3 width=1003 bgColor=#666666 border=0>
        
        <TR bgColor=#ffffff>
          <TD width=12 bgColor=#ffedd2 
            rowSpan=30>인<BR><BR>적<BR><BR>공<BR><BR>제<BR><BR>작<BR><BR>성<BR><BR>요<BR><BR>령</TD>
          <TD vAlign=top>
            <TABLE cellSpacing=0 cellPadding=2 width="100%" border=0>
              
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=3><B>1. 기본공제</B></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>1) 관 계 : 생계를 같이하는(주민등록등본상 동거가족) 근로자(배우자 포함)의 
                  직계존속(외조부모 포함), 자녀, 동거 입양자, 형제자매, 위탁아동</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>2) 세대주 : 근로자 본인이 주민등록등본상 세대주임을 반드시 체크하여야 
                  <U><B>"주택자금 공제"</B></U>를 신청할 수 있음. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>3) 내·외국인 : 배우자 및 부양가족이 외국인일 경우 "외국인 □"란에 체크한 후 
                  <U><B>"외국인등록번호 또는 여권번호"</B></U>를 기재함. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>4) 주민등록번호 : 입력한 출생년도로 부양가족 기본공제 적용 연령과 
                  추가공제(자녀양육비, 경로우대) 가능 여부를 자동체크함. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px"><FONT color=#3366ff>① 배 우 자 : 
                  연령제한 없음. </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px"><FONT color=#3366ff>② 부양가족 : 
                  만60세 이상 남성,여성 직계존속·형제 - 1949.12.31 이전 
                  生&nbsp;&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;&nbsp;
                  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  만20세 이하 직계비속·형제자매 - 1989.01.01 이후生 </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px"><FONT color=#3366ff>③ 자녀양육 : 
                  만6세 이하 직계비속 - 2003.01.01 이후生 </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px"><FONT color=#3366ff>④ 경로우대 : 
				  만70세 이상 - 
                  1939.12.31 이전生 </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2><FONT color=#ff6633>5) 연간 소득금액 : <U><B>"부양가족 
                  연령조건"</B></U>에 충족되는 자의 연간 총소득금액(급/상여 + 퇴직금 + 이자소득 + 사업소득 등 
                  합계액)이 
                  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  "100만원이하(소득공제 차감 후 금액)"인 경우 반드시 체크하여야 배우자 및 부양가족의 기본공제를 받을 수 
                  있음. </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">※ 연간 총소득금액 = 실제 과세소득 - 
                  소득공제(필요경비적 공제) </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">&nbsp;&nbsp;&nbsp;&nbsp;예) 
                  근로소득(급/상여)만 있는 경우 실제소득이 <U><B>약 700만원 이하</B></U>인 경우는 공제 가능하나, 
                  100만원 이상의 퇴직금이 포함된 경우는 공제 불가능함. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=3><B>2. 추가공제</B></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>1) 부녀자 여부 : 근로자 본인이 여성인 경우에만 체크할 수 있음. (남성 근로자는 
                  선택란이 비활성화 되어 체크 불가능함.)</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">① 미혼여성인 경우 : 주민등록등본상 기본공제를 적용받는 
                  부양가족이 있는 세대주이면 공제 가능함. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">② 기혼여성인 경우 : 혼인신고를 한 부녀자이면 공제 
                  가능함. (남편의 소득유무 상관없음.) </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>2) 자녀양육비 : 직계비속이 만6세 이하인 경우에만 체크할 수 있음. (만7세 
                  초과자는 선택란이 비활성화 되어 체크 불가능함.)</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">※ 맞벌이 부부인 경우 - 부모中 1인만 선택 공제 받음 
                </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 200px">- 한 자녀에 대해 본인이 기본공제를 받고 배우자가 
                  추가로 자녀양육비공제를 받을 수 있음. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>3) 장애인 여부 : 연령제한은 없으나, 연간 총소득금액이 100만원 이하인 장애인인 
                  경우에만 해당란에 체크할 수 있음.</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">(연간 소득금액 100만원 이하 □ 란에 체크 안 한 
                  경우 선택란이 비활성화되어 체크 불가능함)</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=3><B>3. 특별공제</B></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2><FONT color=#3366ff>※ 국세청 자료 : 국세청 홈페이지에서 제공하는 
                  자료 (대표적 예 - 현금영수증)</FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2><FONT color=#3366ff>&nbsp;&nbsp;&nbsp;&nbsp;그밖의 
                  자료 : 국세청에서 제공하는 증빙서류 이외의 것 (기존처럼 각 해당 금융기관 등에서 제공하는 자료) 
                </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>1) 보험료 : 본인 및 생계를 같이하는 가족을 "피보험자"로 하여 당해 근로자가 직접 
                  불입한 "소득공제 가능한 보장성 보험료 연간 합계액 " 기재 </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 40px"><FONT color=#ff6633>※ 배우자 및 
                  부양가족이 기본공제 적용자(연령·소득요건 충족자)여야 해당란이 활성화되어 입력 가능함. </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 40px">※ 장애인전용보험은 피보험자가 연간 소득금액 100만원 
                  이하인 장애인이어야 하며 증명서류상에 "장애인 전용 보장성 보험료"라고 기재되어 있어야 함.</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>2) 의료비 : 본인 및 생계를 같이하는 가족을 위하여 당해 근로자가 직접 지출한 치료 
                  및 요양목적의 의료비 기재 <U><B>(수납금액 = 소득공제 대상액)</B></U> </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 40px">※ 안경 및 콘택트렌즈 구입비용은 1인당 50만원 
                  한도내에서 의료비 지출액에 포함됨. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>3) 교육비 : 본인 및 생계를 같이하는 가족을 위하여 지출한 수업료, 입학금, 
                  보육비용, 취학전 아동의 학원수강료 등 기재 </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>4) 신용카드·학원비 지로납부·현금영수증 : 본인 및 생계를 같이하는 가족(형제자매 
                  제외)이 지출한 신용카드·현금영수증 공제 대상액 및 학원의 설립운영 및 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  과외교습에 관한 법률에 의한 학원의 수강료 등을 반드시 <U><B>"지로(ZERO)용지"</B></U>를 
                  이용하여 결제한 금액 기재</TD></TR></TABLE></TD></TR></TABLE></DIV>
<!-- Hidden END ///////////////////////////////////////////////////////////////////////////////////////////////////////////// -->

<table width=1003>
	<tr>
		<td>&nbsp;</td>
		<td align="right"><br>
		<nobr>
			<!-- <img src="../Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()"> -->
			<img src="./imgs/btn_ref2.gif"	style="cursor:hand"	align=absmiddle onClick="openBasic()">
			<img src="../Sales/images/plus.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRow3()">
			<img src="../Sales/images/minus.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRow3()">
			<img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply3();">
			<img src="../Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel3()">
		</nobr>&nbsp;</td>
	</tr>					
</table>

<!-- CheckBox형태로 표시할 Column은 Interger인 경우  Check Data는 1, 0을 사용하며, String인 경우 Check Data는 ‘T’, ‘F’를 사용한다-->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gr3  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 1003px; HEIGHT: 300px;border:1 solid #777777;display:;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds3">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<Param Name="UsingOneClick"   value="1">	
	<param name="SuppressOption"  value="1">
	<param name="Format" 		  value="  
	<G> name='인적사항'	
		<C> Name='관계'		ID=RELAT1	HeadAlign=Center align=center   Width=87  EditStyle=Combo
		 Data='0:본인,1:직계존속,2:배우직계,3:배우자,4:직계비속자녀,5:직계비속자녀외,6:형제자매,7:기타'</C>
		<C> Name='성명'		ID=FAMNM1	HeadAlign=Center align=center   Width=50	</C>
		<C> Name='외국인'	ID=REF1	    HeadAlign=Center align=center   Width=40	editlimit=16 EditStyle=CheckBox</C>
	</G>
	<G> name='기본공제'
		<C> Name='주민번호'	ID=RESINO1  HeadAlign=Center align=center   Width=92   mask='XXXXXX-XXXXXXX'	</C>
		<C> Name='기본'	    ID=REF2	    HeadAlign=Center align=center   Width=28	editlimit=16 EditStyle=CheckBox</C>
	</G>
	<G> name='추가공제'		
		<C> Name='장애인'	ID=REF3	    HeadAlign=Center align=center   Width=38	editlimit=16 EditStyle=CheckBox</C>
		<C> Name='자녀'		ID=REF4	    HeadAlign=Center align=center   Width=28	editlimit=16 EditStyle=CheckBox</C>
		<C> Name='경로'		ID=REF5	    HeadAlign=Center align=center   Width=28	editlimit=16 EditStyle=CheckBox</C>
		<C> Name='부녀자'	ID=REF6	    HeadAlign=Center align=center   Width=39	editlimit=16 EditStyle=CheckBox</C>
		<C> Name='다자녀'	ID=REF7	    HeadAlign=Center align=center   Width=40	editlimit=16 EditStyle=CheckBox</C>
		<C> Name='출산'	    ID=REF8	    HeadAlign=Center align=center   Width=28	editlimit=16 EditStyle=CheckBox</C>
	</G>
	<X> name='특별공제'
		<G> name='보험료'
			<C> Name='국세청'	ID=REF11	HeadAlign=Center align=right  Width=63	EDIT=none</C>
			<C> Name='그외'		ID=REF21	HeadAlign=Center align=right  Width=63	EDIT=none</C>
		</G>			
		<G> name='의료비'		
			<C> Name='국세청'	ID=REF12	HeadAlign=Center align=right  Width=63	EDIT=none</C>
			<C> Name='그외'		ID=REF22	HeadAlign=Center align=right  Width=63	EDIT=none</C>
		</G>			
		<G> name='교육비'
			<C> Name='국세청'	ID=REF13	HeadAlign=Center align=right  Width=63	EDIT=none</C>
			<C> Name='그외'		ID=REF23	HeadAlign=Center align=right  Width=63	EDIT=none</C>
		</G>			
		<G> name='카드/현금'		
			<C> Name='국세청'	ID=REFc1	HeadAlign=Center align=right  Width=63	EDIT=none  Value={Number(REFc1)} Dec=0</C>
			<C> Name='그외'		ID=REFc2	HeadAlign=Center align=right  Width=63	EDIT=none  Value={Number(REFc2)} Dec=0</C>
		</G>			
	</X>					
	<C> Name='년월'				ID=APPDT   		Width=63	show=false</C> 
	<C> Name='사번'				ID=EMPNO  		Width=60	show=false</C> 
	
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>

<br><br><br>
  
      <TABLE cellSpacing=1 cellPadding=3 width=1003 border=0>
        <TR bgColor=#ffffff>
          <TD ><B>Ⅲ. 다음 기타 공제 항목에는 "근로자 본인 명의"로 지출한 금액만 입력바랍니다.</B><BR>
		  </TD> 
		</TR>
		<TR>
		  <td align="right"><br>
			<nobr>
				<!-- <img src="./imgs/btn_submit.gif" style="cursor:hand" align=absmiddle onClick="fnSubmit()"> -->
				<img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
				<img src="../Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
			</nobr>&nbsp;</td>
		</TR>
      </TABLE>
            
      <TABLE cellSpacing=1 cellPadding=3 width=1003 align=center bgColor=#666666  border=2>
        
       <TR bgColor=#ffedd2>
          <TD align=CENTER rowSpan=15>특<BR>별<BR><BR>공<BR>제</TD>
          <TD align=CENTER width=50>항 목</TD>
          <TD align=CENTER colSpan=2>지 출 내 역</TD>
          <TD align=CENTER width=130>지 출 구 분</TD>
          <TD align=CENTER width=90>지 출 금 액</TD>
          <TD align=CENTER>참 고 사 항</TD>
	   </TR>
      <!-- <TR> -->
         <!--  <TD align=CENTER bgColor=#fff8ee rowSpan=4>주택자금</TD>  -->
          <!-- <TD align=left width=110 bgColor=#ffffff rowSpan=3>&nbsp;주택마련저축</TD>
          <TD align=left width=140 bgColor=#ffffff>&nbsp;① 청약저축</TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=3>근로자 본인 명의의 <BR>총 불입액 
            <BR>(40% 공제 미적용 금액)</TD>
          <TD align=CENTER bgColor=#ffffff ROWSPAN=3><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT01" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff >&nbsp;* 근로자 본인이 세대주이며, 무주택자 <BR></FONT>
		  </TD> -->
		<!-- </TR> -->
        <!-- <TR>
          <TD align=left bgColor=#ffffff>&nbsp;② 근로자주택마련저축</TD>
		  <TD bgColor=#ffffff rowspan=2>&nbsp;* 근로자 본인이 세대주이며, 국민주택규모 1채 이하 소유자
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>→ 2005.12.31 이전 가입자 : 국민주택규모
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>→ 2006.1.1 이후 가입자 : 국민주택규모+저축가입시점 기준시가 3억이하<BR></FONT>
		  </TD>
		</TR> -->
        <!-- <TR>
          <TD align=left bgColor=#ffffff>&nbsp;③ 장기주택마련저축</TD>
		</TR> -->

        <TR>
		  <TD align=CENTER bgColor=#fff8ee rowSpan=5>주택자금</TD> 
          <TD align=left  width=240 bgColor=#ffffff colSpan=2>&nbsp;주택임차차입금</TD>
          <TD align=CENTER bgColor=#ffffff>근로자 본인명의의<BR>총 원리금상환액<BR>(40%공제 
            미적용금액)</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT02" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD class=tit_f10 bgColor=#ffffff>&nbsp;* <B>주택마련저축과 연계사항 없어짐</B><BR>
		     &nbsp;* 연말현재 무주택자로 국민주택규모이하의 주택을 임차하기 위해 <BR>&nbsp;&nbsp;&nbsp;&nbsp;차입한 경우 총 원리금상환 기재 
		  </TD>
		</TR>
        <TR>
          <TD align=left  width=110 bgColor=#ffffff rowSpan=3>&nbsp;장기주택<BR>&nbsp;저당차입금 
          </TD>
          <TD align=left  width=125 bgColor=#ffffff>&nbsp;① 상환기간 14년 미만 </TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=3>근로자 본인명의의<BR>&nbsp;총 
          이자상환액</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT03" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD class=tit_f10 bgColor=#ffffff rowSpan=4>&nbsp;* 근로자 본인이 세대주이며, 
            국민주택규모의 주택(분양권·입주권 3억원<BR>&nbsp;&nbsp;&nbsp;&nbsp;이하)을 취득하기 위하여 주택에 
            저당권을 설정하고 차입한 경우<BR>&nbsp;&nbsp;&nbsp;&nbsp;총 이자상환액 기재 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>→ 2006년 신규 
            장기주택저당차입자<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: 차입 당시 
            분양권/입주권 평가액이 3억원 이하여야 함.</FONT> 
		  </TD>
		</TR>
        <TR>
          <TD align=left bgColor=#ffffff>&nbsp;② 상환기간 15년 이상 </TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT04" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=left bgColor=#ffffff>&nbsp;③ 상환기간 30년 이상 </TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT05" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee colSpan=3>주택자금 계</TD>
          <TD align=CENTER bgColor=#fff8ee>
			<%=HDConstant.COMMENT_START%>
			<object id="HOUSUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%>
		  </TD>
  	    </TR>    
		
		<!-- 기부금 -->
		<TR>
          <TD align=CENTER bgColor=#fff8ee rowSpan=9  onclick="openGibu();"  width="60" style="cursor:hand"><b>기부금</b>
		  <!-- <img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();"> -->
		  <img src="./imgs/btn_write2.gif" style="cursor:hand" align=absmiddle onClick="openGibu()">
		  </TD>
          
		  <TD align=left bgColor=#ffffff rowSpan=2>&nbsp;전액공제기부금</TD>
          <TD align=CENTER bgColor=#fff8ee><FONT color=#ff6633>국세청자료</FONT></TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=2>본인.배우자.직계비속<BR>명의 총 기부금액<BR>정치자금(본인명의)</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_10A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD class=tit_f10 bgColor=#ffffff rowSpan=2>&nbsp;* 법정기부금  <br>
		  &nbsp;* 정치자금 : 정당(후원회 및 선거관리위원회 포함)에 기부한 총 정치자금 
           <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>→ 10만원 이하 금액은 세액공제 + 10만원 초과 금액은 소득공제 </FONT><BR>
		  &nbsp;* 진흥기금출연금 : 문화예술진흥법에 의한 문화예술기금 출연 금액
		                              
            <!-- 국방헌금·수재의연금·국가/사립학교의 시설비 등에 기부한 경우<BR>&nbsp;&nbsp;&nbsp;&nbsp;총 기부액 
            기재 <BR><BR>&nbsp;* 정당(후원회 및 선거관리위원회 포함)에 기부한 총 정치자금 기재 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>→ 10만원 이하 금액은 세액공제 + 10만원 초과 금액은 소득공제 </FONT><BR><BR>&nbsp;* 종교·문화·예술·교육·사회·복지·자선단체 등 
            공익성단체에 기부한 경우 <BR>&nbsp;&nbsp;&nbsp;&nbsp;총 기부액 기재 <BR><BR>-->
		 </TD>
		</TR> 
		<TR>
          <TD align=CENTER bgColor=#fff8ee>그밖의자료</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_10B" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
		</TR>
        
		<TR>
          <TD align=left bgColor=#ffffff rowSpan=2>&nbsp;50%한도 기부금</TD>
          <TD align=CENTER bgColor=#fff8ee><FONT color=#ff6633>국세청자료</FONT></TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=2>본인.배우자.직계비속<BR>명의 총 기부금액</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_30A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
		 <TD class=tit_f10 bgColor=#ffffff rowSpan=2>&nbsp;* 특례기부금 : 다음의 각 기관에 지출하는 기부금<BR>
		 독립기념관,특정연구기관,정부출연연구기관,한국교육방송공사,한국국제교류재단 결식아동 결식해소 또는 빈곤층아동 복지증진을을 위한 비영리법인<BR>
		 <FONT color=#ff6633>* 공익법인기부신탁기부금 : 3년간 이월공제가능
		</TD>		
		</TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee>그밖의자료</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_30B" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
		</TR>
		<TR>
          <TD align=left bgColor=#ffffff rowSpan=2>&nbsp;30%한도 기부금</TD>
          <TD align=CENTER bgColor=#fff8ee><FONT color=#ff6633>국세청자료</FONT></TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=2>근로자 본인명의의<BR>총 기부금액</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_42A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
		 <TD class=tit_f10 bgColor=#ffffff rowSpan=2>&nbsp;* 우리사주조합기부금 <br>
		  우리사주조합에 지출하는 기부금(우리사주조합원이 지출하는 기부금 제외)       
		</TD>		
		</TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee>그밖의자료</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_42B" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
		</TR>
        <TR>
          <TD align=left bgColor=#ffffff 
            rowSpan=2>&nbsp;지정기부금 </TD>
          <TD align=CENTER bgColor=#fff8ee><FONT color=#ff6633>국세청자료</FONT></TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=2>본인.배우자.직계비속<BR>명의 총 기부금액</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_40A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
		  <TD class=tit_f10 bgColor=#ffffff rowSpan=2>&nbsp;* 종교단체기부금(10%한도)
		   <br>&nbsp;* 지정기부금(15%한도)
		  </TD>
		</TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee>그밖의자료</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_40B" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
		
		</TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee colSpan=3>기부금 계</TD>
          <TD align=CENTER bgColor=#fff8ee><%=HDConstant.COMMENT_START%>
			<object id="CONSUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
			 <TD class=tit_f10 bgColor=#ffffff>&nbsp;       
		    </TD>
		</TR>
<!--
		 <TR>
          <TD align=CENTER bgColor=#fff8ee rowSpan=3>혼인<BR>장례<BR>이사비용<BR>공제</TD>
          <TD align=CENTER bgColor=#ffffff colSpan=2 >&nbsp;혼인공제</TD>
		  <TD align=CENTER bgColor=#ffffff>혼인 건당 100만원</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
            <object id=MARCNT01 style= "position:relative;left:0px;top:2px;width:85px;" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 >
					<param name=CBData			value="0^0 회,1^1 회,2^2 회,3^3 회,4^4 회,5^5 회,6^6 회,7^7 회,8^8 회,9^9 회">
					<param name=Index           value="0">
					<param name=CBDataColumns	value="CODE,NAME">
					<param name=SearchColumn	value="NAME">
					<param name=Sort			value=True>
					<param name=ListExprFormat	value="NAME^1^60">								
					<param name=BindColumn		value="CODE">
			</object>
			<%=HDConstant.COMMENT_END%>
            </TD>
          <TD class=tit_f10 bgColor=#ffffff rowSpan=3>&nbsp;* 총급여가 2,500만원 이하인 근로자<BR>
          <FONT color=#3366ff> &nbsp;&nbsp;&nbsp;&nbsp;→ 혼인ㆍ장례 공제 : 기본공제대상자(연령불문)<BR>
		   &nbsp;&nbsp;&nbsp;&nbsp;→ 이사비용 공제 : 당해 거주자의 주소이동(가족전체이동)</FONT>
		  </TD>
		</TR>
        <TR>
          <TD align=CENTER bgColor=#ffffff colSpan=2>장례공제</TD>
		  <TD align=CENTER bgColor=#ffffff>장례 건당 100만원</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id=MARCNT02 style= "position:relative;left:0px;top:2px;width:85px;" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 >
					<param name=CBData			value="0^0 회,1^1 회,2^2 회,3^3 회,4^4 회,5^5 회,6^6 회,7^7 회,8^8 회,9^9 회">
					<param name=Index           value="0">
					<param name=CBDataColumns	value="CODE,NAME">
					<param name=SearchColumn	value="NAME">
					<param name=Sort			value=True>
					<param name=ListExprFormat	value="NAME^1^60">								
					<param name=BindColumn		value="CODE">
			</object>
			<%=HDConstant.COMMENT_END%>
            </TD>
		</TR>
		<TR>
          <TD align=CENTER bgColor=#ffffff colSpan=2>이사비용공제</TD>
		  <TD align=CENTER bgColor=#ffffff>이사 건당 100만원</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id=MARCNT03 style= "position:relative;left:0px;top:2px;width:85px;" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 >
					<param name=CBData			value="0^0 회,1^1 회,2^2 회,3^3 회,4^4 회,5^5 회,6^6 회,7^7 회,8^8 회,9^9 회">
					<param name=Index           value="0">
					<param name=CBDataColumns	value="CODE,NAME">
					<param name=SearchColumn	value="NAME">
					<param name=Sort			value=True>
					<param name=ListExprFormat	value="NAME^1^60">								
					<param name=BindColumn		value="CODE">
			</object>
			<%=HDConstant.COMMENT_END%>
            </TD>
		</TR>
-->
        <TR>
		  <TD align=CENTER bgColor=#ffedd2 rowSpan=12>기<BR>타<BR>소<BR>득<BR>공<BR>제</TD>
          <TD align=CENTER bgColor=#fff8ee rowSpan=2>개인연금</TD>
          <TD align=left bgColor=#ffffff colSpan=2 rowSpan=2>&nbsp;2000년 이전 가입한 저축</TD>
          <TD align=CENTER bgColor=#ffffff><FONT color=#3366ff>회사 단체 가입 저축<BR>(2000년 이전 입사자)</FONT></TD>
          <TD align=CENTER bgColor=#ffffff><FONT color=#3366ff>회사일괄처리</FONT></TD>
          <TD class=tit_f10 bgColor=#ffffff rowSpan=2><FONT color=#ff6633>&nbsp;* 회사에서 단체 가입한 대한생명 개인연금 불입액은 본인이 직접 입력하지 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;않음. <BR>&nbsp;&nbsp;&nbsp;&nbsp;→ 단체 가입 상품명 : 노후적립55(60)세 개시, 하이드림 10년납, 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 직장인으뜸55세</FONT> 
		  </TD>
		</TR>
        <TR>
          <TD align=CENTER bgColor=#ffffff>근로자 본인명의의<BR>총 불입액</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id="ETCAMT011A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		  value="0">
					<param name=Alignment 	  value=2 >
					<param name=Numeric		  value="true">
					<param name=Border	 	  value="false">		
					<param name=InheritColor  value="true">																																																				
					<param name=ReadOnly  	  value="false">
					<param name=SelectAll  	  value="true">
			</object>
			<%=HDConstant.COMMENT_END%>
           </TD>
		</TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee rowSpan=2>연금저축</TD>
          <TD align=left bgColor=#ffffff colSpan=2 rowSpan=2>&nbsp;2001년 이후 가입한 저축</TD>
          <TD align=CENTER bgColor=#ffffff><FONT color=#3366ff>회사 단체 가입 저축<BR>(2001년 이후 입사자)</FONT></TD>
          <TD align=CENTER bgColor=#ffffff><FONT color=#3366ff>회사일괄처리</FONT></TD>
          <TD class=tit_f10 bgColor=#ffffff rowSpan=2><FONT color=#ff6633>&nbsp;* 회사에서 단체 가입한 대한생명 연금저축 불입액은 본인이 직접 입력하지<BR>&nbsp;&nbsp;&nbsp; 않음. <BR>
			&nbsp;&nbsp;&nbsp;&nbsp;→ 단체 가입 상품명 : 미래로 기업복지 </FONT>
		  </TD>
		</TR>
        <TR>
          <TD align=CENTER bgColor=#ffffff>근로자 본인명의의<BR>총 불입액</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id="ETCAMT01A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%>
		  </TD>
		 </TR>

         <TR>
          <TD align=center bgColor=#ffffff rowSpan=4>&nbsp;주택마련<BR>저축</TD>
          <TD align=left colspan=2 bgColor=#ffffff>&nbsp;① 청약저축</TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=4>근로자 본인 명의의 <BR>총 불입액 
            <BR>(40% 공제 미적용 금액)</TD>
          <TD align=CENTER bgColor=#ffffff ROWSPAN=4><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT01" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff >&nbsp;* 근로자 본인이 세대주이며, 무주택자 <BR></FONT>
		  </TD>
		</TR>
        <TR>
          <TD align=left colspan=2 bgColor=#ffffff>&nbsp;② 근로자주택마련저축</TD>
		  <TD bgColor=#ffffff rowspan=3>&nbsp;* 근로자 본인이 세대주이며, 국민주택규모 1채 이하 소유자
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>→ 2005.12.31 이전 가입자 : 국민주택규모
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>→ 2006.1.1 이후 가입자 : 국민주택규모+저축가입시점 기준시가 3억이하<BR></FONT>
		  </TD>
		</TR>
        <TR>
          <TD align=left colspan=2 bgColor=#ffffff>&nbsp;③ 장기주택마련저축</TD>
		</TR>
        <TR>
          <TD align=left colspan=2 bgColor=#ffffff>&nbsp;④ 주택청약종합저축</TD>
		</TR>

		 <TR>
          <TD align=center bgColor=#ffffff rowSpan=4>&nbsp;펀드</TD>
          <TD align=left colspan=2 rowSpan=3 bgColor=#ffffff>&nbsp; 장기주식형저축소득공제</TD>
          <TD align=left bgColor=#ffffff >&nbsp;① 납입 1년차 불입액</TD>
          <TD align=CENTER bgColor=#ffffff ><%=HDConstant.COMMENT_START%>
			<object id="FNDAMT01" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff rowspan=3><FONT color=#ff6633>&nbsp;* 2008.10.20 이후 장기주식형저축(적립식펀드) 불입액 <BR>
		   &nbsp;*개인연금저축, 연금저축, 장기주택마련저축의 소득 공제를 적용받는 <BR> &nbsp;&nbsp;경우에는 장기주식형저축에 대한 소득 공제 적용 안됨.  
		  <BR></FONT>
		  </TD>
		</TR>
        <TR>
          <TD align=left bgColor=#ffffff>&nbsp;② 납입 2년차 불입액</TD>
		  <TD align=CENTER bgColor=#ffffff ><%=HDConstant.COMMENT_START%>
			<object id="FNDAMT02" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
		</TR>
        <TR>
          <TD align=left bgColor=#ffffff>&nbsp;③ 납입 3년차 불입액</TD>
		  <TD align=CENTER bgColor=#ffffff ><%=HDConstant.COMMENT_START%>
			<object id="FNDAMT03" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="true">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
		</TR>

		<TR>
          <TD align=left bgColor=#ffffff colspan=3>&nbsp;장기주식형저축 소득공제 계 </TD>
		  <TD align=CENTER bgColor=#ffffff ><%=HDConstant.COMMENT_START%>
			<object id="FNDSUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="true">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
			<TD class=tit_f10 bgColor=#ffffff>&nbsp;       
		    </TD>
		</TR>

		<TR>
		  <TD align=CENTER bgColor=#ffedd2 >연<BR>금</TD>
		  <TD align=center bgColor=#ffffff >&nbsp;연금보험</TD>
          <TD align=left bgColor=#ffffff colspan=3>&nbsp;퇴직연금 보험료공제</TD>
		  <TD align=CENTER bgColor=#ffffff ><%=HDConstant.COMMENT_START%>
			<object id="ETCAMT05" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
			<TD class=tit_f10 bgColor=#ffffff>&nbsp;       
		    </TD>
		</TR>


        <TR>
          <TD align=CENTER bgColor=#ffedd2 rowSpan=2>세<BR>액<BR>공<BR>제</TD>
          <TD align=CENTER bgColor=#fff8ee >정치자금</TD>
          <TD align=left bgColor=#ffffff COLSPAN=2>&nbsp;정치자금 기부금</TD>
          <TD align=CENTER bgColor=#ffffff >근로자 본인 명의의<BR>총 기부금액</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id="DEDAMT04" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD class=tit_f10 bgColor=#ffffff><FONT 
            color=#3366ff>&nbsp;* 정당(후원회 및 선거관리위원회 포함) 기부액이 10만원이하인 
            경우<BR>&nbsp;&nbsp;&nbsp;&nbsp;이하액 기재 (자동입력)</FONT> </TD>
		</TR>

        <TR>
          <TD align=CENTER bgColor=#fff8ee>주택자금</TD>
          <TD align=left bgColor=#ffffff colSpan=2>&nbsp;미분양주택취득차입금 상환이자</TD>
          <TD align=CENTER bgColor=#ffffff>근로자 본인명의의<BR>총 이자상환액</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id="DEDAMT03" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%>
		  </TD>
          <TD class=tit_f10 bgColor=#ffffff>&nbsp;* 세대주인 근로자 본인 명의로 "1995.11.1~1997.12.31" 중 서울시 이외의 <BR>
			&nbsp;&nbsp;&nbsp;&nbsp;지역에 국민주택규모 이하의 미분양 주택을 취득하기 위해 국민주택기금 <BR>
			&nbsp;&nbsp;&nbsp;&nbsp;또는 주택은행으로부터 1995.11.1 이후 차입한 차입금에 대한 총 이자 <BR>
			&nbsp;&nbsp;&nbsp;&nbsp;상환액 기재
		  </TD>
		</TR>
	  </TABLE>
	  <BR>
      <TABLE cellSpacing=1 cellPadding=3 width=1003 border=0>
        
        <TR bgColor=#ffffff>
		  <TD width=600><FONT color=#3366ff>&nbsp;☞ 주의사항 <BR></FONT>
		       <B>&nbsp;전산제출 버튼 : </B>모든 데이터를 입력한 후 더 이상 입력 또는 수정건이 없을 경우 적용한다.<BR>
		       <B><FONT color=#ff6633> ※전산제출 후에는 더 이상 수정 할 수 없기 때문에 주의해서 제출하시기 바랍니다.</FONT></B>     
		  </TD> 
          <TD vAlign=bottom align=right><img src="./imgs/btn_submit.gif" style="cursor:hand" align=absmiddle onClick="fnSubmit()">&nbsp;&nbsp;&nbsp;&nbsp;<img src="../Sales/images/print.gif"	style="cursor:hand;position:relative;left:-7px"	align=absmiddle onClick="fnPrint()"></TD>

		</TR>

		</TR>
	  </TABLE>

	  <!--연금보험료-->
	  <INPUT type=hidden value=1,486,800 name=pybsgm>
	  <INPUT type=hidden value=0 name=pybsto> 
	  
	  <!--보험료-->
	  <INPUT type=hidden value=802,130 name=pybsbh> 
	  <INPUT type=hidden value=173,047 name=pybsgy> 
	  <INPUT type=hidden value=0 name=pybins> 
	  <INPUT type=hidden value=0 name=pybin2> 
	  <INPUT type=hidden value=0 name=pybito> 
	  
	  <!--의료비-->
	  <INPUT type=hidden value=0 name=pybmsd> 
	  <INPUT type=hidden value=0 name=pybmgd> 
	  <INPUT type=hidden value=0 name=pybmtc> 
	  <INPUT type=hidden value=0 name=pybmto> 
	  <INPUT type=hidden value=0 name=pybmtm> 
	  
	  <!--교육비-->
	  <INPUT type=hidden value=0 name=pybsed> 
	  <INPUT type=hidden value=0 name=pybebc> 
	  <INPUT type=hidden value=0 name=pybebt> 
	  <INPUT type=hidden value=0 name=pybecc> 
	  <INPUT type=hidden value=0 name=pybect> 
      <INPUT type=hidden value=0 name=pybedc> 
	  <INPUT type=hidden value=0 name=pybedt> 
	  <INPUT type=hidden value=0 name=pybetc> 
	  <INPUT type=hidden value=0 name=pybets> 
	  <INPUT type=hidden value=0 name=pybeto> 

      <!--카드비-->
	  <INPUT type=hidden value=0 name=pybcad> 
	  <INPUT type=hidden value=0 name=pybhnd> 
	  <INPUT type=hidden value=0 name=pybsgd> 
	  <!--<input type="hidden" name="pybmex" value="0">-->
	  <INPUT type=hidden value=0 name=pybcto> 

      <DIV id=tipbox style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BACKGROUND: infobackground; LEFT: 0px; VISIBILITY: hidden; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 0px"></DIV>
	</TD>
  </TR>
</TABLE>

<%=HDConstant.COMMENT_START%>
<object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds1>
	<param name=BindInfo  value='
		<C>Col=EMPNO  	  	Ctrl=EMPNO  	   	Param=text</C>
		<C>Col=DEPTCD  	  	Ctrl=DEPTCD  	   	Param=text</C>
		<C>Col=PAYGRD  	  	Ctrl=PAYGRD  	   	Param=text</C>
		<C>Col=JOINDATE   	Ctrl=JOINDATE      	Param=text</C>
		<C>Col=EMPNMK  	  	Ctrl=EMPNMK  	   	Param=text</C>
		<C>Col=EMPJUNO    	Ctrl=EMPJUNO       	Param=text</C>
		<C>Col=TELNUM    	Ctrl=TELNUM       	Param=text</C>
		<C>Col=ADDRESS    	Ctrl=ADDRESS       	Param=text</C>
		<C>Col=TAX_PAY    	Ctrl=TAX_PAY       	Param=text</C>
		<C>Col=TAX_BNS    	Ctrl=TAX_BNS       	Param=text</C>
		<C>Col=TAX_SUM    	Ctrl=TAX_SUM       	Param=text</C>
		<C>Col=NTAX_SUM   	Ctrl=NTAX_SUM      	Param=text</C>
		<C>Col=DEDUCT1 	  	Ctrl=DEDUCT1 	   	Param=text</C>
		<C>Col=DEDUCT2 	  	Ctrl=DEDUCT2 	   	Param=text</C>
		<C>Col=DEDUCT3 	  	Ctrl=DEDUCT3 	   	Param=text</C>
		<C>Col=DEDUCT4 	  	Ctrl=DEDUCT4 	   	Param=text</C>
		<C>Col=DEDUCT5    	Ctrl=DEDUCT5       	Param=text</C>

		<C>Col=HOUAMT01   	Ctrl=HOUAMT01      Param=text</C>	
		<C>Col=HOUAMT02   	Ctrl=HOUAMT02      Param=text</C>
		<C>Col=HOUAMT03   	Ctrl=HOUAMT03      Param=text</C>
		<C>Col=HOUAMT04   	Ctrl=HOUAMT04      Param=text</C>
		<C>Col=HOUAMT05  	Ctrl=HOUAMT05      Param=text</C>
		<C>Col=HOUSUM 	  	Ctrl=HOUSUM 	   Param=text</C>
		<C>Col=ETCAMT011A  	Ctrl=ETCAMT011A     Param=text</C>
		<C>Col=ETCAMT01A   	Ctrl=ETCAMT01A      Param=text</C>
		<C>Col=CONSUM   	Ctrl=CONSUM        Param=text</C>
		<C>Col=DEDAMT03   	Ctrl=DEDAMT03      Param=text</C>
		<C>Col=DEDAMT04   	Ctrl=DEDAMT04      Param=text</C>	
		<C>Col=MARCNT01   	Ctrl=MARCNT01      Param=bindcolval</C>	
		<C>Col=MARCNT02   	Ctrl=MARCNT02      Param=bindcolval</C>	
		<C>Col=MARCNT03   	Ctrl=MARCNT03      Param=bindcolval</C>	

		<C>Col=FNDAMT01   	Ctrl=FNDAMT01      Param=text</C>	
		<C>Col=FNDAMT02   	Ctrl=FNDAMT02      Param=text</C>	
		<C>Col=FNDAMT03   	Ctrl=FNDAMT03      Param=text</C>	
		<C>Col=FNDSUM   	Ctrl=FNDSUM        Param=text</C>	
		<C>Col=ETCAMT05   	Ctrl=ETCAMT05        Param=text</C>	


	'>
</object>

<object id=gcbn_data2 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds2>
	<param name=BindInfo  value='
		<C>Col=BF_WKNM     	  	Ctrl=BF_WKNM     	   	Param=text</C>
		<C>Col=BF_RESINO	  	Ctrl=BF_RESINO	       	Param=text</C>
		<C>Col=BF_TAX_PAY	  	Ctrl=BF_TAX_PAY	       	Param=text</C>
		<C>Col=BF_TAX_BNS	  	Ctrl=BF_TAX_BNS	       	Param=text</C>
		<C>Col=BF_TAX_SUM 	  	Ctrl=BF_TAX_SUM 	   	Param=text</C>
		<C>Col=BF_NTAX_SUM 	  	Ctrl=BF_NTAX_SUM 	   	Param=text</C>
		<C>Col=BF_DEDUCT1     	Ctrl=BF_DEDUCT1        	Param=text</C>
		<C>Col=BF_DEDUCT2	  	Ctrl=BF_DEDUCT2	       	Param=text</C>
		<C>Col=BF_DEDUCT3	  	Ctrl=BF_DEDUCT3	       	Param=text</C>
		<C>Col=BF_DEDUCT4	  	Ctrl=BF_DEDUCT4	       	Param=text</C>
		<C>Col=BF_DEDUCT5	  	Ctrl=BF_DEDUCT5	       	Param=text</C>
	'>
</object>

<object id=gcbn_data4 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds4>
	<param name=BindInfo  value='
		<C>Col=GIVAMT_10A  	Ctrl=GIVAMT_10A 	   	Param=text</C>
		<C>Col=GIVAMT_10B  	Ctrl=GIVAMT_10B       	Param=text</C>
		<C>Col=GIVAMT_30A  	Ctrl=GIVAMT_30A       	Param=text</C>
		<C>Col=GIVAMT_30B  	Ctrl=GIVAMT_30B       	Param=text</C>
		<C>Col=GIVAMT_42A  	Ctrl=GIVAMT_42A       	Param=text</C>
		<C>Col=GIVAMT_42B  	Ctrl=GIVAMT_42B       	Param=text</C>
		<C>Col=GIVAMT_40A  	Ctrl=GIVAMT_40A	  		Param=text</C>
		<C>Col=GIVAMT_40B  	Ctrl=GIVAMT_40B 	   	Param=text</C>		
	'>
</object>

<object id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="ds_print">  
	<PARAM NAME="DetailDataID"			VALUE="ds_print">
	<PARAM NAME="PaperSize"				VALUE="A4">	
	<PARAM NAME="LandScape"				VALUE="False">
    <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<param name="MargineX"              value="30">
	<param name="MargineY"              value="30">
	<PARAM NAME="Format" VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='1쪽.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='ds_print'

<B>id=default ,left=0,top=0 ,right=2001 ,bottom=2787 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='(건강보험료' ,left=911 ,top=778 ,right=1072 ,bottom=823 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(1쪽)' ,left=1738 ,top=124 ,right=1893 ,bottom=185 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='[별지 제37호 서식]  (2009.04.14.개정)' ,left=29 ,top=124 ,right=874 ,bottom=185 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=190 ,right=1898 ,bottom=190 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=190 ,right=29 ,bottom=2732 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1898 ,top=190 ,right=1898 ,bottom=2732 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='210㎜x297㎜' ,left=1303 ,top=2737 ,right=1893 ,bottom=2779 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='   1. 연령기준' ,left=108 ,top=2457 ,right=1877 ,bottom=2497 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='   3. 내ㆍ외국인 : 내국인 =1, 외국인=9 로 구분하여 적습니다.' ,left=108 ,top=2642 ,right=1877 ,bottom=2684 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='   2. 관계코드 : 소득자 본인=0, 소득자의 직계존속=1, 배우자 직계존속=2, 배우자=3, 직계비속 자녀=4, 직계비속 자녀 외=5, 형제자매=6, ' ,left=108 ,top=2568 ,right=1877 ,bottom=2610 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='      기타=7을 적습니다.(4ㆍ5ㆍ6ㆍ7의 경우 소득자와 배우자의 각각의 관계를 포함합니다).  ' ,left=108 ,top=2605 ,right=1877 ,bottom=2647 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='      나. 6세 이하자 2003.01.01. 이후 출생(자녀양육비공제 100만원)' ,left=108 ,top=2531 ,right=1877 ,bottom=2573 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='      가. 경 로 자 1939.12.31. 이전 출생(70세 이상: 100만원 공제)' ,left=108 ,top=2494 ,right=1877 ,bottom=2534 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='※참고사항' ,left=108 ,top=2418 ,right=292 ,bottom=2457 ,align='left' ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='   4. 다자녀란은 근로자 본인의 기본공제대상자에 해당하는 자녀가 2명 이상인 경우에 해당 자녀수를 적습니다.' ,left=108 ,top=2679 ,right=1877 ,bottom=2721 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득공제신고서/근로소득자공제신고서 (' ,left=82 ,top=214 ,right=1050 ,bottom=287 ,align='left' ,face='굴림' ,size=15 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득자 성명' ,left=50 ,top=446 ,right=371 ,bottom=477 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민등록번호' ,left=911 ,top=446 ,right=1230 ,bottom=477 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNMK', left=440, top=446, right=893, bottom=477, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO', left=1237, top=446, right=1882, bottom=477 ,mask='XXXXXX-XXXXXXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='거주자' ,left=440 ,top=541 ,right=561 ,bottom=572 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=566 ,top=541 ,right=595 ,bottom=572 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='' ,left=606 ,top=541 ,right=635 ,bottom=572</T>
	<T>id='비거주자' ,left=650 ,top=541 ,right=771 ,bottom=572 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=779 ,top=541 ,right=808 ,bottom=572 ,border=true</X>
	<T>id='근무기간' ,left=911 ,top=538 ,right=1230 ,bottom=572 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주지국코드' ,left=911 ,top=585 ,right=1230 ,bottom=620 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='~' ,left=1559 ,top=538 ,right=1617 ,bottom=572 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사업자등록번호' ,left=908 ,top=493 ,right=1227 ,bottom=527 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근무처 명칭' ,left=50 ,top=493 ,right=371 ,bottom=527 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주구분' ,left=50 ,top=541 ,right=371 ,bottom=572 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주지국' ,left=50 ,top=591 ,right=371 ,bottom=622 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='COMPANY', left=440, top=493, right=893, bottom=527, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COMRESINO', left=1237, top=493, right=1882, bottom=527 ,mask='XXX-XX-XXXXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1232 ,top=435 ,right=1232 ,bottom=622 </L>
	<C>id='YYYY', left=1050, top=224, right=1856, bottom=298, align='left' ,mask='XXXX년 소득에 대한 연말정산용  )', face='굴림', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='  근로소득 세액계산을 하고 근로자에게 즉시 원천징수영수증을 교부하며, 환급발생시 원천징수의무자가 근로자에게 환급합니다.' ,left=39 ,top=367 ,right=1888 ,bottom=422 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='* 근로자는 해당 서류를 작성하여 원천징수의무자(소속 회사 등)에게 제출하며, 원천징수의무자는 해당 서류 및 첨부서류를 확인하여' ,left=39 ,top=327 ,right=1888 ,bottom=377 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=398 ,top=791 ,right=484 ,bottom=791 </L>
	<L> left=103 ,top=709 ,right=819 ,bottom=709 </L>
	<T>id='신용카드 등' ,left=1474 ,top=712 ,right=1664 ,bottom=780 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사용액공제' ,left=1474 ,top=762 ,right=1664 ,bottom=804 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1401 ,top=809 ,right=1730 ,bottom=809 </L>
	<L> left=100 ,top=899 ,right=1893 ,bottom=899 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{decode(REF26_S,0,,REF26_S)}', left=1730, top=973, right=1890, bottom=1028, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_S,0,,REF16_S)}', left=1730, top=907, right=1890, bottom=962, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_S,0,,REF15_S)}', left=1567, top=907, right=1727, bottom=962, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_S,0,,REF14_S)}', left=1403, top=907, right=1564, bottom=962, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_S,0,,REF24_S)}', left=1403, top=973, right=1564, bottom=1028, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_S,0,,REF23_S)}', left=1237, top=973, right=1401, bottom=1028, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_S,0,,REF13_S)}', left=1237, top=907, right=1401, bottom=962, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_S,0,,REF12_S)}', left=1074, top=907, right=1235, bottom=962, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_S,0,,REF22_S)}', left=1074, top=973, right=1235, bottom=1028, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_S,0,,REF11_S)}', left=908, top=907, right=1069, bottom=962, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='국세청' ,left=821 ,top=907 ,right=903 ,bottom=962 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=819 ,top=973 ,right=900 ,bottom=1028 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='명)' ,left=321 ,top=978 ,right=374 ,bottom=1023 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CNT', left=242, top=978, right=321, bottom=1023, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(다자녀' ,left=118 ,top=978 ,right=240 ,bottom=1023 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인적공제 항목에' ,left=103 ,top=910 ,right=395 ,bottom=954 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='해당하는 인원수를 기재' ,left=103 ,top=947 ,right=392 ,bottom=983 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=100 ,top=1034 ,right=1893 ,bottom=1034 </L>
	<L> left=100 ,top=1039 ,right=1893 ,bottom=1039 </L>
	<C>id='EMPNMK', left=179, top=1047, right=390, bottom=1102, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_1', left=405, top=1047, right=479, bottom=1102, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6_1', left=405, top=1113, right=479, bottom=1168, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='국세청' ,left=821 ,top=1047 ,right=903 ,bottom=1102 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=821 ,top=1113 ,right=903 ,bottom=1168 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=906 ,top=1107 ,right=1898 ,bottom=1107 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=906 ,top=1242 ,right=1898 ,bottom=1242 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=105 ,top=1173 ,right=1896 ,bottom=1173 </L>
	<L> left=400 ,top=968 ,right=484 ,bottom=968 </L>
	<L> left=908 ,top=965 ,right=1901 ,bottom=968 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=29 ,top=2732 ,right=1898 ,bottom=2732 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=100 ,top=628 ,right=100 ,bottom=2732 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='RELAT1_1', left=105, top=1049, right=171, bottom=1105, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_1', left=105, top=1115, right=171, bottom=1171, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_2', left=105, top=1250, right=171, bottom=1305, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_8', left=105, top=2046, right=171, bottom=2101, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO', left=179, top=1113, right=390, bottom=1168 ,mask='XXXXXX-XXXXXXX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_2', left=179, top=1247, right=390, bottom=1303 ,mask='XXXXXX-XXXXXXX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_2', left=105, top=1179, right=171, bottom=1234, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_3', left=103, top=1313, right=168, bottom=1368, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_4', left=105, top=1442, right=171, bottom=1498, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_5', left=105, top=1577, right=171, bottom=1632, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_6', left=103, top=1714, right=168, bottom=1769, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_6', left=105, top=1785, right=171, bottom=1840, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_7', left=105, top=1851, right=171, bottom=1906, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_8', left=105, top=1983, right=171, bottom=2038, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_9', left=105, top=2112, right=171, bottom=2167, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_10', left=105, top=2252, right=171, bottom=2307, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=103 ,top=2381 ,right=1893 ,bottom=2381 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='EMPNMK_2', left=179, top=1179, right=390, bottom=1234, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_1', left=487, top=1047, right=561, bottom=1168, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_2', left=569, top=1047, right=650, bottom=1168, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_S,0,,REF21_S)}', left=908, top=973, right=1069, bottom=1028, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_1,0,,REF26_1)}', left=1732, top=1113, right=1893, bottom=1168, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_1,0,,REF16_1)}', left=1732, top=1047, right=1893, bottom=1102, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_1,0,,REF15_1)}', left=1569, top=1047, right=1730, bottom=1102, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_1,0,,REF24_1)}', left=1406, top=1113, right=1567, bottom=1168, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_1,0,,REF14_1)}', left=1406, top=1047, right=1567, bottom=1102, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_1,0,,REF23_1)}', left=1240, top=1113, right=1403, bottom=1168, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_1,0,,REF13_1)}', left=1240, top=1047, right=1403, bottom=1102, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_1,0,,REF22_1)}', left=1077, top=1113, right=1237, bottom=1168, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_1,0,,REF12_1)}', left=1077, top=1047, right=1237, bottom=1102, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_1,0,,REF21_1)}', left=911, top=1113, right=1072, bottom=1168, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_1,0,,REF11_1)}', left=911, top=1047, right=1072, bottom=1102, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_2', left=742, top=1044, right=816, bottom=1165, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_2', left=405, top=1179, right=479, bottom=1234, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='국세청' ,left=821 ,top=1179 ,right=903 ,bottom=1234 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF11_2,0,,REF11_2)}', left=911, top=1179, right=1072, bottom=1234, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_2,0,,REF12_2)}', left=1077, top=1179, right=1237, bottom=1234, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_2,0,,REF13_2)}', left=1240, top=1179, right=1403, bottom=1234, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_2,0,,REF14_2)}', left=1406, top=1179, right=1567, bottom=1234, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_2,0,,REF15_2)}', left=1569, top=1179, right=1730, bottom=1234, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_2,0,,REF16_2)}', left=1732, top=1179, right=1893, bottom=1234, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='기타' ,left=821 ,top=1247 ,right=903 ,bottom=1303 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF21_2,0,,REF21_2)}', left=911, top=1247, right=1072, bottom=1303, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_2,0,,REF22_2)}', left=1077, top=1247, right=1237, bottom=1303, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_2,0,,REF23_2)}', left=1240, top=1247, right=1403, bottom=1303, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_2,0,,REF24_2)}', left=1406, top=1247, right=1567, bottom=1303, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_2,0,,REF26_2)}', left=1732, top=1247, right=1893, bottom=1303, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_3', left=179, top=1313, right=390, bottom=1368, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='국세청' ,left=821 ,top=1313 ,right=903 ,bottom=1368 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF11_3,0,,REF11_3)}', left=911, top=1313, right=1072, bottom=1368, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_3,0,,REF12_3)}', left=1077, top=1313, right=1237, bottom=1368, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_3,0,,REF13_3)}', left=1240, top=1313, right=1403, bottom=1368, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_3,0,,REF14_3)}', left=1406, top=1313, right=1567, bottom=1368, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_3,0,,REF15_3)}', left=1569, top=1313, right=1730, bottom=1368, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_3,0,,REF16_3)}', left=1732, top=1313, right=1893, bottom=1368, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_3,0,,REF24_3)}', left=1406, top=1376, right=1567, bottom=1432, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_3,0,,REF23_3)}', left=1240, top=1376, right=1403, bottom=1432, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_3,0,,REF22_3)}', left=1077, top=1376, right=1237, bottom=1432, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_3,0,,REF21_3)}', left=911, top=1376, right=1072, bottom=1432, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='기타' ,left=821 ,top=1376 ,right=903 ,bottom=1432 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPJUNO_3', left=179, top=1376, right=390, bottom=1432 ,mask='XXXXXX-XXXXXXX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_3,0,,REF26_3)}', left=1732, top=1376, right=1893, bottom=1432, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_3', left=105, top=1376, right=171, bottom=1432, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_3', left=405, top=1313, right=479, bottom=1368, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_4', left=179, top=1442, right=390, bottom=1498, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_4', left=405, top=1442, right=479, bottom=1498, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='국세청' ,left=821 ,top=1442 ,right=903 ,bottom=1498 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF11_4,0,,REF11_4)}', left=911, top=1442, right=1072, bottom=1498, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_4,0,,REF12_4)}', left=1077, top=1442, right=1237, bottom=1498, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_4,0,,REF13_4)}', left=1240, top=1442, right=1403, bottom=1498, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_4,0,,REF14_4)}', left=1406, top=1442, right=1567, bottom=1498, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_4,0,,REF15_4)}', left=1569, top=1442, right=1730, bottom=1498, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_4,0,,REF16_4)}', left=1732, top=1442, right=1893, bottom=1498, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_4', left=179, top=1511, right=390, bottom=1566 ,mask='XXXXXX-XXXXXXX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_4', left=105, top=1511, right=171, bottom=1566, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='기타' ,left=821 ,top=1511 ,right=903 ,bottom=1566 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF21_4,0,,REF21_4)}', left=911, top=1511, right=1072, bottom=1566, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_4,0,,REF22_4)}', left=1077, top=1511, right=1237, bottom=1566, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_4,0,,REF23_4)}', left=1240, top=1511, right=1403, bottom=1566, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_4,0,,REF24_4)}', left=1406, top=1511, right=1567, bottom=1566, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_4,0,,REF26_4)}', left=1732, top=1511, right=1893, bottom=1566, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_5', left=179, top=1577, right=390, bottom=1632, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_5', left=405, top=1577, right=479, bottom=1632, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='국세청' ,left=821 ,top=1577 ,right=903 ,bottom=1632 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF11_5,0,,REF11_5)}', left=911, top=1577, right=1072, bottom=1632, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_5,0,,REF12_5)}', left=1077, top=1577, right=1237, bottom=1632, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_5,0,,REF13_5)}', left=1240, top=1577, right=1403, bottom=1632, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_5,0,,REF14_5)}', left=1406, top=1577, right=1567, bottom=1632, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_5,0,,REF15_5)}', left=1569, top=1577, right=1730, bottom=1632, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_5,0,,REF16_5)}', left=1732, top=1577, right=1893, bottom=1632, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_5', left=105, top=1645, right=171, bottom=1701, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_5,0,,REF26_5)}', left=1732, top=1645, right=1893, bottom=1701, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='기타' ,left=821 ,top=1645 ,right=903 ,bottom=1701 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF21_5,0,,REF21_5)}', left=911, top=1645, right=1072, bottom=1701, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_5,0,,REF22_5)}', left=1077, top=1645, right=1237, bottom=1701, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_5,0,,REF23_5)}', left=1240, top=1645, right=1403, bottom=1701, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_5,0,,REF24_5)}', left=1406, top=1645, right=1567, bottom=1701, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_5', left=179, top=1645, right=390, bottom=1701 ,mask='XXXXXX-XXXXXXX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_6', left=179, top=1714, right=390, bottom=1769, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_6', left=405, top=1714, right=479, bottom=1769, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='국세청' ,left=821 ,top=1714 ,right=903 ,bottom=1769 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF11_6,0,,REF11_6)}', left=911, top=1714, right=1072, bottom=1769, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_6,0,,REF12_6)}', left=1079, top=1714, right=1240, bottom=1769, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_6,0,,REF13_6)}', left=1243, top=1714, right=1406, bottom=1769, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_6,0,,REF14_6)}', left=1409, top=1714, right=1569, bottom=1769, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_6,0,,REF15_6)}', left=1572, top=1714, right=1732, bottom=1769, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_6,0,,REF16_6)}', left=1735, top=1714, right=1896, bottom=1769, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_6', left=179, top=1785, right=390, bottom=1840 ,mask='XXXXXX-XXXXXXX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='기타' ,left=821 ,top=1785 ,right=903 ,bottom=1840 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF21_6,0,,REF21_6)}', left=911, top=1785, right=1072, bottom=1840, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_6,0,,REF22_6)}', left=1079, top=1785, right=1240, bottom=1840, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_6,0,,REF23_6)}', left=1243, top=1785, right=1406, bottom=1840, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_6,0,,REF24_6)}', left=1409, top=1785, right=1569, bottom=1840, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_6,0,,REF26_6)}', left=1735, top=1785, right=1896, bottom=1840, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_7', left=179, top=1851, right=390, bottom=1906, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_7', left=405, top=1851, right=479, bottom=1906, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='국세청' ,left=821 ,top=1851 ,right=903 ,bottom=1906 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF11_7,0,,REF11_7)}', left=911, top=1851, right=1072, bottom=1906, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_7,0,,REF12_7)}', left=1072, top=1851, right=1232, bottom=1906, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_7,0,,REF13_7)}', left=1235, top=1851, right=1398, bottom=1906, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_7,0,,REF14_7)}', left=1401, top=1851, right=1561, bottom=1906, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_7,0,,REF15_7)}', left=1564, top=1851, right=1724, bottom=1906, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_7,0,,REF16_7)}', left=1727, top=1851, right=1888, bottom=1906, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_7', left=105, top=1917, right=171, bottom=1972, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_7', left=179, top=1917, right=390, bottom=1972 ,mask='XXXXXX-XXXXXXX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='기타' ,left=821 ,top=1917 ,right=903 ,bottom=1972 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF21_7,0,,REF21_7)}', left=911, top=1917, right=1072, bottom=1972, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_7,0,,REF22_7)}', left=1072, top=1917, right=1232, bottom=1972, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_7,0,,REF23_7)}', left=1235, top=1917, right=1398, bottom=1972, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_7,0,,REF24_7)}', left=1401, top=1917, right=1561, bottom=1972, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_7,0,,REF26_7)}', left=1727, top=1917, right=1888, bottom=1972, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_8', left=179, top=1983, right=390, bottom=2038, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_8', left=405, top=1983, right=479, bottom=2038, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='국세청' ,left=821 ,top=1983 ,right=903 ,bottom=2038 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF11_8,0,,REF11_8)}', left=911, top=1983, right=1072, bottom=2038, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_8,0,,REF12_8)}', left=1077, top=1983, right=1237, bottom=2038, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_8,0,,REF13_8)}', left=1240, top=1983, right=1403, bottom=2038, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_8,0,,REF14_8)}', left=1406, top=1983, right=1567, bottom=2038, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_8,0,,REF15_8)}', left=1569, top=1983, right=1730, bottom=2038, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_8,0,,REF16_8)}', left=1732, top=1983, right=1893, bottom=2038, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_8', left=179, top=2046, right=390, bottom=2101 ,mask='XXXXXX-XXXXXXX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='기타' ,left=821 ,top=2046 ,right=903 ,bottom=2101 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF21_8,0,,REF21_8)}', left=911, top=2046, right=1072, bottom=2101, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_8,0,,REF22_8)}', left=1077, top=2046, right=1237, bottom=2101, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_8,0,,REF23_8)}', left=1240, top=2046, right=1403, bottom=2101, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_8,0,,REF24_8)}', left=1406, top=2046, right=1567, bottom=2101, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_8,0,,REF26_8)}', left=1732, top=2046, right=1893, bottom=2101, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_9', left=179, top=2112, right=390, bottom=2167, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_9', left=405, top=2112, right=479, bottom=2167, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='국세청' ,left=821 ,top=2112 ,right=903 ,bottom=2167 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF11_9,0,,REF11_9)}', left=911, top=2112, right=1072, bottom=2167, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_9,0,,REF12_9)}', left=1079, top=2112, right=1240, bottom=2167, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_9,0,,REF13_9)}', left=1243, top=2112, right=1406, bottom=2167, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_9,0,,REF14_9)}', left=1409, top=2112, right=1569, bottom=2167, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_9,0,,REF15_9)}', left=1569, top=2112, right=1730, bottom=2167, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_9,0,,REF16_9)}', left=1732, top=2112, right=1893, bottom=2167, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_9', left=179, top=2181, right=390, bottom=2236 ,mask='XXXXXX-XXXXXXX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_9', left=105, top=2181, right=171, bottom=2236, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='기타' ,left=821 ,top=2181 ,right=903 ,bottom=2236 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF21_9,0,,REF21_9)}', left=911, top=2181, right=1072, bottom=2236, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_9,0,,REF22_9)}', left=1079, top=2181, right=1240, bottom=2236, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_9,0,,REF23_9)}', left=1243, top=2181, right=1406, bottom=2236, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_9,0,,REF24_9)}', left=1409, top=2181, right=1569, bottom=2236, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_9,0,,REF26_9)}', left=1732, top=2181, right=1893, bottom=2236, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_10', left=184, top=2252, right=395, bottom=2307, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_10', left=405, top=2252, right=479, bottom=2307, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='국세청' ,left=821 ,top=2252 ,right=903 ,bottom=2307 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF11_10,0,,REF11_10)}', left=911, top=2252, right=1072, bottom=2307, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_10,0,,REF12_10)}', left=1077, top=2252, right=1237, bottom=2307, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_10,0,,REF13_10)}', left=1240, top=2252, right=1403, bottom=2307, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_10,0,,REF14_10)}', left=1406, top=2252, right=1567, bottom=2307, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_10,0,,REF15_10)}', left=1569, top=2252, right=1730, bottom=2307, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_10,0,,REF16_10)}', left=1732, top=2252, right=1893, bottom=2307, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_10', left=105, top=2320, right=171, bottom=2376, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_10', left=184, top=2320, right=395, bottom=2376 ,mask='XXXXXX-XXXXXXX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='기타' ,left=821 ,top=2320 ,right=903 ,bottom=2376 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(REF21_10,0,,REF21_10)}', left=911, top=2320, right=1072, bottom=2376, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_10,0,,REF22_10)}', left=1077, top=2320, right=1237, bottom=2376, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_10,0,,REF23_10)}', left=1240, top=2320, right=1403, bottom=2376, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_10,0,,REF24_10)}', left=1406, top=2320, right=1567, bottom=2376, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_10,0,,REF26_10)}', left=1732, top=2320, right=1893, bottom=2376, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_2', left=569, top=1179, right=650, bottom=1300, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_3', left=569, top=1310, right=650, bottom=1432, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_4', left=569, top=1445, right=650, bottom=1566, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_5', left=569, top=1579, right=650, bottom=1701, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_6', left=569, top=1719, right=650, bottom=1840, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_7', left=569, top=1851, right=650, bottom=1972, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_8', left=569, top=1980, right=650, bottom=2101, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_9', left=569, top=2115, right=650, bottom=2236, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_10', left=569, top=2254, right=650, bottom=2376, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_2', left=742, top=1179, right=816, bottom=1300, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_3', left=742, top=1310, right=816, bottom=1432, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_4', left=742, top=1445, right=816, bottom=1566, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_5', left=742, top=1579, right=816, bottom=1701, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_6', left=742, top=1719, right=816, bottom=1840, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_7', left=742, top=1851, right=816, bottom=1972, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_8', left=742, top=1980, right=816, bottom=2101, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_9', left=742, top=2115, right=816, bottom=2236, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_10', left=742, top=2254, right=816, bottom=2376, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_2', left=487, top=1179, right=561, bottom=1300, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_3', left=487, top=1310, right=561, bottom=1432, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_4', left=487, top=1445, right=561, bottom=1566, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_5', left=487, top=1579, right=561, bottom=1701, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_6', left=487, top=1719, right=561, bottom=1840, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_7', left=487, top=1851, right=561, bottom=1972, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_8', left=487, top=1980, right=561, bottom=2101, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_9', left=487, top=2115, right=561, bottom=2236, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_10', left=487, top=2254, right=561, bottom=2376, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=398 ,top=438 ,right=398 ,bottom=2384 </L>
	<L> left=906 ,top=438 ,right=906 ,bottom=2384 </L>
	<L> left=563 ,top=709 ,right=563 ,bottom=2384 </L>
	<L> left=484 ,top=709 ,right=484 ,bottom=2384 </L>
	<L> left=656 ,top=709 ,right=656 ,bottom=2384 </L>
	<L> left=1074 ,top=709 ,right=1074 ,bottom=2384 </L>
	<L> left=1403 ,top=709 ,right=1403 ,bottom=2384 </L>
	<L> left=1237 ,top=709 ,right=1237 ,bottom=2384 </L>
	<L> left=903 ,top=2312 ,right=1896 ,bottom=2312 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=903 ,top=2173 ,right=1896 ,bottom=2173 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=906 ,top=2041 ,right=1898 ,bottom=2041 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=906 ,top=1912 ,right=1898 ,bottom=1912 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=906 ,top=1777 ,right=1898 ,bottom=1777 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=903 ,top=1637 ,right=1896 ,bottom=1637 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=903 ,top=1500 ,right=1896 ,bottom=1500 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=906 ,top=1368 ,right=1898 ,bottom=1368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=174 ,top=1039 ,right=174 ,bottom=2381 </L>
	<L> left=174 ,top=628 ,right=174 ,bottom=896 </L>
	<L> left=29 ,top=438 ,right=1898 ,bottom=438 </L>
	<L> left=29 ,top=483 ,right=1898 ,bottom=483 </L>
	<L> left=29 ,top=533 ,right=1898 ,bottom=533 </L>
	<L> left=29 ,top=577 ,right=1898 ,bottom=577 </L>
	<L> left=29 ,top=628 ,right=1898 ,bottom=628 </L>
	<T>id='관계' ,left=108 ,top=633 ,right=171 ,bottom=675 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='코드' ,left=108 ,top=672 ,right=171 ,bottom=707 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=182 ,top=651 ,right=392 ,bottom=693 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='각종 소득공제 항목' ,left=921 ,top=651 ,right=1885 ,bottom=693 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인적공제 항목' ,left=437 ,top=651 ,right=803 ,bottom=693 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국인' ,left=103 ,top=791 ,right=174 ,bottom=836 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내·외' ,left=103 ,top=746 ,right=174 ,bottom=794 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='번호' ,left=184 ,top=788 ,right=395 ,bottom=836 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민등록' ,left=184 ,top=749 ,right=395 ,bottom=796 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본' ,left=405 ,top=715 ,right=479 ,bottom=754 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=405 ,top=751 ,right=479 ,bottom=791 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부녀' ,left=405 ,top=799 ,right=479 ,bottom=838 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자' ,left=405 ,top=828 ,right=479 ,bottom=867 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=405 ,top=857 ,right=479 ,bottom=896 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='경로' ,left=487 ,top=741 ,right=561 ,bottom=780 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='우대' ,left=487 ,top=780 ,right=561 ,bottom=820 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=487 ,top=817 ,right=561 ,bottom=857 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자' ,left=569 ,top=823 ,right=650 ,bottom=862 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='입양' ,left=569 ,top=788 ,right=650 ,bottom=828 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='·' ,left=569 ,top=770 ,right=650 ,bottom=788 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출산' ,left=569 ,top=736 ,right=650 ,bottom=775 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=569 ,top=862 ,right=650 ,bottom=896 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인' ,left=661 ,top=783 ,right=735 ,bottom=823 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='장애' ,left=661 ,top=749 ,right=735 ,bottom=788 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='양육비' ,left=737 ,top=770 ,right=819 ,bottom=809 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자녀' ,left=742 ,top=736 ,right=811 ,bottom=775 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=661 ,top=820 ,right=735 ,bottom=860 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구분' ,left=821 ,top=770 ,right=903 ,bottom=809 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자료' ,left=827 ,top=733 ,right=900 ,bottom=773 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=911 ,top=738 ,right=1072 ,bottom=783 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의료비' ,left=1077 ,top=783 ,right=1230 ,bottom=831 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='교육비' ,left=1240 ,top=783 ,right=1401 ,bottom=831 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='신용카드' ,left=1406 ,top=815 ,right=1567 ,bottom=854 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='등' ,left=1406 ,top=852 ,right=1567 ,bottom=891 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='영수증' ,left=1569 ,top=852 ,right=1730 ,bottom=891 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현금' ,left=1569 ,top=815 ,right=1730 ,bottom=854 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금' ,left=1738 ,top=783 ,right=1893 ,bottom=831 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=732 ,top=709 ,right=732 ,bottom=2384 </L>
	<L> left=821 ,top=630 ,right=821 ,bottom=2381 </L>
	<C>id='REF3_1', left=661, top=1047, right=727, bottom=1168, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_2', left=661, top=1179, right=727, bottom=1300, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_3', left=661, top=1310, right=727, bottom=1432, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_4', left=661, top=1445, right=727, bottom=1566, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_5', left=661, top=1579, right=727, bottom=1701, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_6', left=661, top=1719, right=727, bottom=1840, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_7', left=661, top=1851, right=727, bottom=1972, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_8', left=661, top=1980, right=727, bottom=2101, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_9', left=661, top=2115, right=727, bottom=2236, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_10', left=661, top=2254, right=727, bottom=2376, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=100 ,top=1173 ,right=1890 ,bottom=1173 </L>
	<L> left=100 ,top=1308 ,right=1890 ,bottom=1308 </L>
	<L> left=100 ,top=1706 ,right=1890 ,bottom=1706 </L>
	<L> left=100 ,top=1843 ,right=1890 ,bottom=1843 </L>
	<L> left=100 ,top=1978 ,right=1890 ,bottom=1978 </L>
	<L> left=100 ,top=2107 ,right=1890 ,bottom=2107 </L>
	<L> left=100 ,top=2244 ,right=1890 ,bottom=2244 </L>
	<L> left=906 ,top=709 ,right=1898 ,bottom=709 </L>
	<L> left=821 ,top=2312 ,right=903 ,bottom=2312 </L>
	<L> left=821 ,top=968 ,right=903 ,bottom=968 </L>
	<L> left=821 ,top=1107 ,right=903 ,bottom=1107 </L>
	<L> left=821 ,top=1242 ,right=903 ,bottom=1242 </L>
	<L> left=821 ,top=1368 ,right=903 ,bottom=1368 </L>
	<L> left=821 ,top=1500 ,right=903 ,bottom=1500 </L>
	<L> left=821 ,top=1637 ,right=903 ,bottom=1637 </L>
	<L> left=821 ,top=1777 ,right=903 ,bottom=1777 </L>
	<L> left=821 ,top=1912 ,right=903 ,bottom=1912 </L>
	<L> left=821 ,top=2041 ,right=903 ,bottom=2041 </L>
	<L> left=821 ,top=2173 ,right=903 ,bottom=2173 </L>
	<L> left=400 ,top=1107 ,right=484 ,bottom=1107 </L>
	<L> left=400 ,top=1242 ,right=484 ,bottom=1242 </L>
	<L> left=400 ,top=1368 ,right=484 ,bottom=1368 </L>
	<L> left=400 ,top=1500 ,right=484 ,bottom=1500 </L>
	<L> left=400 ,top=1637 ,right=484 ,bottom=1637 </L>
	<L> left=400 ,top=1777 ,right=484 ,bottom=1777 </L>
	<L> left=400 ,top=1912 ,right=484 ,bottom=1912 </L>
	<L> left=400 ,top=2041 ,right=484 ,bottom=2041 </L>
	<L> left=400 ,top=2173 ,right=484 ,bottom=2173 </L>
	<L> left=400 ,top=2312 ,right=484 ,bottom=2312 </L>
	<L> left=103 ,top=2312 ,right=398 ,bottom=2312 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=100 ,top=1437 ,right=1890 ,bottom=1437 </L>
	<L> left=395 ,top=1107 ,right=100 ,bottom=1107 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=398 ,top=1242 ,right=103 ,bottom=1242 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=395 ,top=1368 ,right=100 ,bottom=1368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=392 ,top=1500 ,right=97 ,bottom=1500 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=103 ,top=2173 ,right=398 ,bottom=2173 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=103 ,top=2041 ,right=398 ,bottom=2041 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=103 ,top=1912 ,right=398 ,bottom=1912 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=103 ,top=1777 ,right=398 ,bottom=1777 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=103 ,top=1637 ,right=398 ,bottom=1637 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=100 ,top=1569 ,right=1890 ,bottom=1569 </L>
	<T>id='등 포함)' ,left=911 ,top=820 ,right=1072 ,bottom=865 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1730 ,top=709 ,right=1730 ,bottom=2384 </L>
	<T>id='인' ,left=34 ,top=1313 ,right=95 ,bottom=1353 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='적' ,left=34 ,top=1361 ,right=95 ,bottom=1400 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=34 ,top=1408 ,right=95 ,bottom=1448 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=34 ,top=1455 ,right=95 ,bottom=1495 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='및' ,left=34 ,top=1548 ,right=95 ,bottom=1585 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소' ,left=34 ,top=1635 ,right=95 ,bottom=1677 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='득' ,left=34 ,top=1685 ,right=95 ,bottom=1724 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=34 ,top=1732 ,right=95 ,bottom=1772 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=34 ,top=1780 ,right=95 ,bottom=1819 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='명' ,left=34 ,top=1872 ,right=95 ,bottom=1912 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=34 ,top=1920 ,right=95 ,bottom=1959 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=1567 ,top=968 ,right=1730 ,bottom=1036 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='CURDT3', left=1366, top=538, right=1551, bottom=572 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CURDT', left=1622, top=538, right=1806, bottom=572 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=1567 ,top=1107 ,right=1730 ,bottom=1173 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1567 ,top=1242 ,right=1730 ,bottom=1308 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1567 ,top=1368 ,right=1730 ,bottom=1437 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1567 ,top=1500 ,right=1730 ,bottom=1569 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1567 ,top=1637 ,right=1730 ,bottom=1706 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1567 ,top=1777 ,right=1730 ,bottom=1843 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1567 ,top=1912 ,right=1730 ,bottom=1978 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1567 ,top=2038 ,right=1730 ,bottom=2107 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1567 ,top=2173 ,right=1730 ,bottom=2244 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1567 ,top=2312 ,right=1730 ,bottom=2381 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=1567 ,top=809 ,right=1567 ,bottom=2376 </L>
	<C>id='EMPNO', left=1514, top=124, right=1732, bottom=185, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='공제' ,left=742 ,top=804 ,right=811 ,bottom=844 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>




</R>
</A>

<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='2쪽.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='ds_print'


<B>id=default ,left=0,top=0 ,right=2001 ,bottom=2758 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=29 ,top=156 ,right=1898 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='(2쪽)' ,left=1738 ,top=90 ,right=1893 ,bottom=150 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=156 ,right=29 ,bottom=2642 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=2642 ,right=1898 ,bottom=2642 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1201 ,top=1830 ,right=1201 ,bottom=2571 </L>
	<C>id='{decode(C_AMT1,0,,C_AMT1)}', left=1206, top=2144, right=1398, bottom=2181, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='사용금액' ,left=919 ,top=2144 ,right=1198 ,bottom=2181 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='   ① 신용ㆍ직불ㆍ기명식 선불카드 등' ,left=316 ,top=2144 ,right=882 ,bottom=2181 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='그' ,left=39 ,top=2083 ,right=100 ,bottom=2123 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='밖' ,left=39 ,top=2154 ,right=100 ,bottom=2194 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의' ,left=39 ,top=2207 ,right=100 ,bottom=2246 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=39 ,top=2260 ,right=100 ,bottom=2299 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=39 ,top=2312 ,right=100 ,bottom=2352 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='   ② 현금영수증' ,left=316 ,top=2188 ,right=882 ,bottom=2225 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사용금액' ,left=919 ,top=2188 ,right=1198 ,bottom=2225 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(C_AMT2,0,,C_AMT2)}', left=1206, top=2188, right=1398, bottom=2225, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='   ③ 학원비 지로납부' ,left=316 ,top=2231 ,right=882 ,bottom=2268 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사용금액' ,left=919 ,top=2231 ,right=1198 ,bottom=2268 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(C_AMT3,0,,C_AMT3)}', left=1206, top=2231, right=1398, bottom=2268, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='   ④ 사업관련비용' ,left=316 ,top=2273 ,right=882 ,bottom=2310 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(C_AMT4,0,,C_AMT4)}', left=1206, top=2273, right=1398, bottom=2310, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='계(①+②+③-④)' ,left=316 ,top=2315 ,right=882 ,bottom=2352 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(C_SUM,0,,C_SUM)}', left=1206, top=2315, right=1398, bottom=2352, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FD_AMT3,0,,FD_AMT3)}', left=1206, top=2489, right=1398, bottom=2526, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FD_SUM,0,,FD_SUM)}', left=1206, top=2531, right=1398, bottom=2568, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FD_AMT2,0,,FD_AMT2)}', left=1206, top=2447, right=1398, bottom=2484, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FD_AMT1,0,,FD_AMT1)}', left=1206, top=2405, right=1398, bottom=2442, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='출연금액' ,left=919 ,top=2357 ,right=1198 ,bottom=2394 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(D_SUM,0,,D_SUM)}', left=1206, top=2357, right=1398, bottom=2394, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='우리사주 출연금 소득공제' ,left=116 ,top=2357 ,right=882 ,bottom=2394 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='①납입 1년차' ,left=919 ,top=2405 ,right=1198 ,bottom=2442 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='②납입 2년차' ,left=919 ,top=2447 ,right=1198 ,bottom=2484 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③납입 3년차' ,left=919 ,top=2489 ,right=1198 ,bottom=2526 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납입합계' ,left=919 ,top=2531 ,right=1198 ,bottom=2568 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=121 ,top=701 ,right=292 ,bottom=744 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=214 ,right=1898 ,bottom=214 </L>
	<L> left=906 ,top=156 ,right=906 ,bottom=2642 </L>
	<L> left=29 ,top=567 ,right=1898 ,bottom=567 </L>
	<T>id='제' ,left=37 ,top=480 ,right=97 ,bottom=519 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=37 ,top=440 ,right=97 ,bottom=480 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='료' ,left=37 ,top=401 ,right=97 ,bottom=440 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='험' ,left=37 ,top=361 ,right=97 ,bottom=401 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보' ,left=37 ,top=322 ,right=97 ,bottom=361 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금' ,left=37 ,top=282 ,right=97 ,bottom=322 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연' ,left=37 ,top=243 ,right=97 ,bottom=282 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연금보험료' ,left=121 ,top=253 ,right=292 ,bottom=287 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지출명세' ,left=308 ,top=166 ,right=898 ,bottom=206 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1201 ,top=156 ,right=1201 ,bottom=2642 </L>
	<L> left=1690 ,top=156 ,right=1690 ,bottom=2642 </L>
	<T>id='국민연금보험료' ,left=329 ,top=221 ,right=566 ,bottom=306 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국민연금보험료' ,left=329 ,top=322 ,right=566 ,bottom=364 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='퇴직연금' ,left=329 ,top=425 ,right=566 ,bottom=504 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(국민연금,' ,left=121 ,top=319 ,right=292 ,bottom=353 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공무원연금,' ,left=121 ,top=353 ,right=292 ,bottom=388 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='군인연금,' ,left=121 ,top=388 ,right=292 ,bottom=422 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='교직원연금,' ,left=121 ,top=427 ,right=292 ,bottom=461 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='퇴직연금 등)' ,left=121 ,top=464 ,right=292 ,bottom=498 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)근무지' ,left=600 ,top=219 ,right=898 ,bottom=258 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지출구분' ,left=911 ,top=166 ,right=1195 ,bottom=206 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금액' ,left=1206 ,top=166 ,right=1398 ,bottom=206 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='한도액' ,left=1414 ,top=166 ,right=1688 ,bottom=206 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제액' ,left=1696 ,top=166 ,right=1885 ,bottom=206 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구분' ,left=121 ,top=169 ,right=290 ,bottom=208 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주(현)근무지' ,left=600 ,top=274 ,right=898 ,bottom=314 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)근무지' ,left=600 ,top=322 ,right=898 ,bottom=361 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주(현)근무지' ,left=600 ,top=372 ,right=898 ,bottom=411 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)근무지' ,left=600 ,top=422 ,right=898 ,bottom=461 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주(현)근무지' ,left=600 ,top=469 ,right=898 ,bottom=509 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=919 ,top=219 ,right=1193 ,bottom=258 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BP31000,0,,BP31000)}', left=1206, top=219, right=1398, bottom=258, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='전액' ,left=1414 ,top=219 ,right=1688 ,bottom=258 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BP31000,0,,BP31000)}', left=1696, top=219, right=1885, bottom=258, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='보험료' ,left=919 ,top=274 ,right=1193 ,bottom=314 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1414 ,top=274 ,right=1688 ,bottom=314 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=919 ,top=322 ,right=1193 ,bottom=361 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1414 ,top=322 ,right=1688 ,bottom=361 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=919 ,top=372 ,right=1193 ,bottom=411 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1414 ,top=372 ,right=1688 ,bottom=411 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=919 ,top=422 ,right=1193 ,bottom=461 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1414 ,top=422 ,right=1688 ,bottom=461 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1898 ,top=156 ,right=1898 ,bottom=2642 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=592 ,top=214 ,right=592 ,bottom=512 </L>
	<C>id='{decode(PENSUM,0,,PENSUM)}', left=1206, top=274, right=1398, bottom=314, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP34000,0,,BP34000)}', left=1206, top=422, right=1398, bottom=461, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(F_SUM,0,,F_SUM)}', left=1206, top=469, right=1398, bottom=509, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PENSUM,0,,PENSUM)}', left=1696, top=274, right=1885, bottom=314, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(F_SUMS,0,,F_SUMS)}', left=1696, top=467, right=1885, bottom=506, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=592 ,top=367 ,right=1896 ,bottom=367 </L>
	<L> left=592 ,top=266 ,right=1896 ,bottom=266 </L>
	<X>left=906 ,top=512 ,right=1201 ,bottom=567 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=300 ,top=316 ,right=1898 ,bottom=316 </L>
	<T>id='연금보험료 계' ,left=308 ,top=517 ,right=900 ,bottom=562 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국민건강보험' ,left=308 ,top=575 ,right=587 ,bottom=614 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(노인장기요양보험 포함)' ,left=308 ,top=614 ,right=587 ,bottom=654 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='고용보험' ,left=308 ,top=680 ,right=587 ,bottom=775 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료 계' ,left=308 ,top=899 ,right=900 ,bottom=939 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='장애인전용보장성보험' ,left=308 ,top=846 ,right=900 ,bottom=886 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='일반보장성보험' ,left=308 ,top=786 ,right=900 ,bottom=836 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주(현)근무지' ,left=600 ,top=733 ,right=898 ,bottom=775 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)근무지' ,left=600 ,top=680 ,right=898 ,bottom=720 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주(현)근무지' ,left=600 ,top=630 ,right=898 ,bottom=670 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)근무지' ,left=600 ,top=575 ,right=898 ,bottom=614 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=592 ,top=567 ,right=592 ,bottom=780 </L>
	<L> left=592 ,top=725 ,right=1896 ,bottom=725 </L>
	<L> left=592 ,top=620 ,right=1896 ,bottom=620 </L>
	<L> left=592 ,top=461 ,right=1896 ,bottom=461 </L>
	<T>id='보험료' ,left=919 ,top=472 ,right=1193 ,bottom=512 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=919 ,top=575 ,right=1193 ,bottom=614 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=919 ,top=630 ,right=1193 ,bottom=670 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=919 ,top=680 ,right=1193 ,bottom=720 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=919 ,top=733 ,right=1193 ,bottom=775 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=919 ,top=786 ,right=1193 ,bottom=836 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=919 ,top=846 ,right=1193 ,bottom=886 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1414 ,top=469 ,right=1688 ,bottom=509 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1414 ,top=575 ,right=1688 ,bottom=614 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1414 ,top=630 ,right=1688 ,bottom=670 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1414 ,top=680 ,right=1688 ,bottom=720 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1414 ,top=733 ,right=1688 ,bottom=775 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='100만원' ,left=1414 ,top=786 ,right=1688 ,bottom=836 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='100만원' ,left=1414 ,top=846 ,right=1688 ,bottom=886 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PENTOT,0,,PENTOT)}', left=1206, top=517, right=1398, bottom=562, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP32000,0,,BP32000)}', left=1206, top=575, right=1398, bottom=614, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT01,0,,INSAMT01)}', left=1206, top=630, right=1398, bottom=670, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP33000,0,,BP33000)}', left=1206, top=680, right=1398, bottom=720, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT02,0,,INSAMT02)}', left=1206, top=733, right=1398, bottom=775, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT03,0,,INSAMT03)}', left=1206, top=786, right=1398, bottom=836, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT04,0,,INSAMT04)}', left=1206, top=846, right=1398, bottom=886, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSSUM,0,,INSSUM)}', left=1206, top=899, right=1398, bottom=939, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PENTOT,0,,PENTOT)}', left=1696, top=517, right=1885, bottom=562, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP32000,0,,BP32000)}', left=1696, top=575, right=1885, bottom=614, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT01,0,,INSAMT01)}', left=1696, top=630, right=1885, bottom=670, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP33000,0,,BP33000)}', left=1696, top=680, right=1885, bottom=720, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT02,0,,INSAMT02)}', left=1696, top=733, right=1885, bottom=775, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT03S,0,,INSAMT03S)}', left=1696, top=786, right=1885, bottom=836, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT04S,0,,INSAMT04S)}', left=1696, top=846, right=1885, bottom=886, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSSUMS,0,,INSSUMS)}', left=1696, top=899, right=1885, bottom=939, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=906 ,top=894 ,right=1201 ,bottom=947 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=300 ,top=894 ,right=1898 ,bottom=894 </L>
	<L> left=300 ,top=841 ,right=1898 ,bottom=841 </L>
	<L> left=300 ,top=780 ,right=1898 ,bottom=780 </L>
	<L> left=300 ,top=675 ,right=1898 ,bottom=675 </L>
	<L> left=300 ,top=512 ,right=1898 ,bottom=512 </L>
	<L> left=300 ,top=414 ,right=1898 ,bottom=414 </L>
	<T>id='본인ㆍ65세 이상자ㆍ장애인 의료비' ,left=316 ,top=954 ,right=882 ,bottom=991 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='그 밖의 공제대상자 의료비' ,left=316 ,top=997 ,right=882 ,bottom=1034 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='취학전 아동 ( ' ,left=308 ,top=1126 ,right=479 ,bottom=1165 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='초ㆍ중ㆍ고등학교 ( ' ,left=308 ,top=1173 ,right=563 ,bottom=1210 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대학생(대학원 불포함)  ( ' ,left=308 ,top=1218 ,right=624 ,bottom=1255 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='장애인 ( ' ,left=308 ,top=1260 ,right=421 ,bottom=1297 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주택임차차입금' ,left=316 ,top=1347 ,right=882 ,bottom=1384 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(H_AMT2,0,,H_AMT2)}', left=1206, top=1347, right=1398, bottom=1384, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='장기주택저당차입금' ,left=316 ,top=1392 ,right=882 ,bottom=1429 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(H_AMT3,0,,H_AMT3)}', left=1206, top=1392, right=1398, bottom=1429, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='주택자금 공제액 계' ,left=316 ,top=1437 ,right=882 ,bottom=1474 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(M_AMT1,0,,M_AMT1)}', left=1206, top=954, right=1398, bottom=991, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='작성방법 참조' ,left=1414 ,top=954 ,right=1688 ,bottom=991 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(M_AMT2,0,,M_AMT2)}', left=1206, top=997, right=1398, bottom=1034, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='작성방법 참조' ,left=1414 ,top=997 ,right=1688 ,bottom=1034 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(M_SUM,0,,M_SUM)}', left=1206, top=1042, right=1398, bottom=1078, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_AMT1S,0,,E_AMT1S)}', left=1206, top=1086, right=1398, bottom=1123, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_CNT2,0,,E_CNT2)}', left=482, top=1129, right=532, bottom=1165, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=') 명' ,left=532 ,top=1126 ,right=711 ,bottom=1165 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(E_AMT2,0,,E_AMT2)}', left=1206, top=1126, right=1398, bottom=1165, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_CNT3,0,,E_CNT3)}', left=566, top=1173, right=616, bottom=1210, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=') 명' ,left=613 ,top=1173 ,right=792 ,bottom=1210 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(E_AMT3,0,,E_AMT3)}', left=1206, top=1173, right=1398, bottom=1210, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_CNT4,0,,E_CNT4)}', left=627, top=1216, right=677, bottom=1255, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=') 명' ,left=674 ,top=1218 ,right=853 ,bottom=1255 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(E_AMT4,0,,E_AMT4)}', left=1206, top=1218, right=1398, bottom=1255, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_CNT5,0,,E_CNT5)}', left=424, top=1260, right=474, bottom=1297, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=') 명' ,left=471 ,top=1260 ,right=650 ,bottom=1297 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(E_AMT5,0,,E_AMT5)}', left=1206, top=1260, right=1398, bottom=1297, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='의료비 계' ,left=316 ,top=1042 ,right=882 ,bottom=1078 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='교육비 계' ,left=316 ,top=1303 ,right=882 ,bottom=1339 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=1785 ,right=1898 ,bottom=1785 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='의료비' ,left=121 ,top=957 ,right=292 ,bottom=1071 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='교육비' ,left=121 ,top=1092 ,right=292 ,bottom=1329 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주택자금' ,left=121 ,top=1347 ,right=292 ,bottom=1471 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금' ,left=121 ,top=1490 ,right=292 ,bottom=1777 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(E_SUM,0,,E_SUM)}', left=1206, top=1303, right=1398, bottom=1339, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=906 ,top=1432 ,right=1201 ,bottom=1482 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1201 ,top=1432 ,right=1403 ,bottom=1482 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='소득자 본인' ,left=308 ,top=1086 ,right=882 ,bottom=1123 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1414 ,top=1086 ,right=1688 ,bottom=1123 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1인당 300만원' ,left=1414 ,top=1126 ,right=1688 ,bottom=1165 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1인당 300만원' ,left=1414 ,top=1173 ,right=1688 ,bottom=1210 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1인당 900만원' ,left=1414 ,top=1218 ,right=1688 ,bottom=1255 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1414 ,top=1260 ,right=1688 ,bottom=1297 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1414 ,top=1347 ,right=1688 ,bottom=1384 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1414 ,top=1392 ,right=1688 ,bottom=1429 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(M_SUMS,0,,M_SUMS)}', left=1696, top=1042, right=1885, bottom=1078, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_AMT1S,0,,E_AMT1S)}', left=1696, top=1086, right=1885, bottom=1123, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_AMT2S,0,,E_AMT2S)}', left=1696, top=1126, right=1888, bottom=1165, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_AMT3S,0,,E_AMT3S)}', left=1696, top=1173, right=1885, bottom=1210, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_AMT4S,0,,E_AMT4S)}', left=1696, top=1218, right=1885, bottom=1255, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_AMT5S,0,,E_AMT5S)}', left=1696, top=1260, right=1885, bottom=1297, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(E_SUMS,0,,E_SUMS)}', left=1696, top=1303, right=1885, bottom=1339, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(H_AMT2S,0,,H_AMT2S)}', left=1696, top=1347, right=1885, bottom=1384, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(H_AMT3S,0,,H_AMT3S)}', left=1696, top=1392, right=1885, bottom=1429, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(H_SUMS,0,,H_SUMS)}', left=1696, top=1437, right=1885, bottom=1474, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='지출액' ,left=919 ,top=954 ,right=1198 ,bottom=991 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지출액' ,left=919 ,top=997 ,right=1198 ,bottom=1034 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공납금(대학원포함)' ,left=919 ,top=1086 ,right=1198 ,bottom=1123 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='유치원비ㆍ학원비등' ,left=919 ,top=1126 ,right=1198 ,bottom=1165 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공납금' ,left=919 ,top=1173 ,right=1198 ,bottom=1210 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공납금' ,left=919 ,top=1218 ,right=1198 ,bottom=1255 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특수교육비' ,left=919 ,top=1260 ,right=1198 ,bottom=1297 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='원리금 상환액' ,left=919 ,top=1347 ,right=1198 ,bottom=1384 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이자 상환액' ,left=919 ,top=1392 ,right=1198 ,bottom=1429 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='정치자금기부금(세액공제분 제외)' ,left=316 ,top=1487 ,right=882 ,bottom=1513 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액공제 기부금' ,left=316 ,top=1524 ,right=882 ,bottom=1558 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='50%한도 적용기부금' ,left=316 ,top=1566 ,right=882 ,bottom=1598 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30%한도 적용기부금' ,left=316 ,top=1608 ,right=882 ,bottom=1643 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종교단체 외 지정기부금' ,left=316 ,top=1651 ,right=882 ,bottom=1687 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종교단체 지정기부금' ,left=316 ,top=1695 ,right=882 ,bottom=1732 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금공제액 계' ,left=316 ,top=1743 ,right=882 ,bottom=1780 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금액' ,left=919 ,top=1487 ,right=1198 ,bottom=1513 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금액' ,left=919 ,top=1524 ,right=1198 ,bottom=1558 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금액' ,left=919 ,top=1566 ,right=1198 ,bottom=1598 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금액' ,left=919 ,top=1608 ,right=1198 ,bottom=1643 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금액' ,left=919 ,top=1651 ,right=1198 ,bottom=1687 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금액' ,left=919 ,top=1695 ,right=1198 ,bottom=1732 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(CONAMT02,0,,CONAMT02)}', left=1206, top=1487, right=1398, bottom=1513, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(G_AMT1,0,,G_AMT1)}', left=1206, top=1524, right=1398, bottom=1558, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(G_AMT2,0,,G_AMT2)}', left=1206, top=1566, right=1398, bottom=1598, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(G_AMT3,0,,G_AMT3)}', left=1206, top=1608, right=1398, bottom=1643, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONAMT06,0,,CONAMT06)}', left=1206, top=1651, right=1398, bottom=1687, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONAMT07,0,,CONAMT07)}', left=1206, top=1695, right=1398, bottom=1732, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONAMT02S,0,,CONAMT02S)}', left=1696, top=1487, right=1885, bottom=1513, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(G_AMT1S,0,,G_AMT1S)}', left=1696, top=1524, right=1885, bottom=1558, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(G_AMT2S,0,,G_AMT2S)}', left=1696, top=1566, right=1885, bottom=1598, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(G_AMT3S,0,,G_AMT3S)}', left=1696, top=1608, right=1885, bottom=1643, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONAMT06S,0,,CONAMT06S)}', left=1696, top=1651, right=1885, bottom=1687, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONAMT07S,0,,CONAMT07S)}', left=1696, top=1695, right=1885, bottom=1732, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(G_SUMS,0,,G_SUMS)}', left=1696, top=1743, right=1885, bottom=1780, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1403 ,top=156 ,right=1403 ,bottom=2642 </L>
	<L> left=300 ,top=1519 ,right=1403 ,bottom=1519 </L>
	<L> left=300 ,top=1603 ,right=1403 ,bottom=1603 </L>
	<L> left=300 ,top=1645 ,right=1403 ,bottom=1645 </L>
	<L> left=300 ,top=1690 ,right=1403 ,bottom=1690 </L>
	<T>id='작성방법참조' ,left=1409 ,top=1490 ,right=1682 ,bottom=1732 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1690 ,top=1519 ,right=1896 ,bottom=1519 </L>
	<L> left=300 ,top=1561 ,right=1403 ,bottom=1561 </L>
	<L> left=1690 ,top=1690 ,right=1896 ,bottom=1690 </L>
	<L> left=1690 ,top=1645 ,right=1896 ,bottom=1645 </L>
	<L> left=1690 ,top=1603 ,right=1896 ,bottom=1603 </L>
	<L> left=1690 ,top=1561 ,right=1896 ,bottom=1561 </L>
	<L> left=300 ,top=991 ,right=1898 ,bottom=991 </L>
	<L> left=300 ,top=1297 ,right=1898 ,bottom=1297 </L>
	<L> left=300 ,top=1255 ,right=1898 ,bottom=1255 </L>
	<L> left=300 ,top=1213 ,right=1898 ,bottom=1213 </L>
	<L> left=300 ,top=1168 ,right=1898 ,bottom=1168 </L>
	<L> left=300 ,top=1123 ,right=1898 ,bottom=1123 </L>
	<L> left=300 ,top=1034 ,right=1898 ,bottom=1034 </L>
	<L> left=300 ,top=1432 ,right=1898 ,bottom=1432 </L>
	<L> left=300 ,top=1387 ,right=1898 ,bottom=1387 </L>
	<L> left=300 ,top=1738 ,right=1898 ,bottom=1738 </L>
	<L> left=108 ,top=1482 ,right=1896 ,bottom=1482 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=108 ,top=1339 ,right=1896 ,bottom=1339 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=108 ,top=1081 ,right=1896 ,bottom=1081 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=108 ,top=947 ,right=1896 ,bottom=947 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='특' ,left=37 ,top=1007 ,right=97 ,bottom=1047 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='별' ,left=37 ,top=1147 ,right=97 ,bottom=1187 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=37 ,top=1279 ,right=97 ,bottom=1318 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=37 ,top=1416 ,right=97 ,bottom=1455 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2001년 이후 가입한 연금저축' ,left=316 ,top=1872 ,right=882 ,bottom=1912 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연금저축공제계' ,left=316 ,top=1917 ,right=882 ,bottom=1956 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납입금액' ,left=919 ,top=1788 ,right=1198 ,bottom=1864 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(S_AMT1,0,,S_AMT1)}', left=1206, top=1788, right=1398, bottom=1864, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(S_AMT1S,0,,S_AMT1S)}', left=1696, top=1788, right=1885, bottom=1864, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='납입금액' ,left=919 ,top=1872 ,right=1198 ,bottom=1912 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(S_AMT2,0,,S_AMT2)}', left=1206, top=1872, right=1398, bottom=1912, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='작성방법 참조' ,left=1414 ,top=1872 ,right=1688 ,bottom=1912 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(S_AMT2S,0,,S_AMT2S)}', left=1696, top=1872, right=1885, bottom=1912, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(S_SUMS,0,,S_SUMS)}', left=1696, top=1917, right=1885, bottom=1956, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=300 ,top=1785 ,right=300 ,bottom=1962 </L>
	<L> left=300 ,top=156 ,right=300 ,bottom=1782 </L>
	<L> left=300 ,top=2054 ,right=300 ,bottom=2355 </L>
	<X>left=906 ,top=1034 ,right=1201 ,bottom=1081 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='소기업ㆍ소상공인 공제부금 소득공제' ,left=113 ,top=1967 ,right=903 ,bottom=2004 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주택마련저축 소득공제' ,left=113 ,top=2014 ,right=903 ,bottom=2051 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='불입금액' ,left=919 ,top=1967 ,right=1198 ,bottom=2004 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(SM_AMT1,0,,SM_AMT)}', left=1206, top=1967, right=1398, bottom=2004, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SM_AMTS,0,,SM_AMTS)}', left=1696, top=1967, right=1885, bottom=2004, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='납입금액' ,left=919 ,top=2014 ,right=1198 ,bottom=2051 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(H_AMT1,0,,H_AMT1)}', left=1206, top=2014, right=1398, bottom=2051, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(H_AMT1S,0,,H_AMT1S)}', left=1696, top=2014, right=1885, bottom=2051, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=300 ,top=1912 ,right=1898 ,bottom=1912 </L>
	<L> left=300 ,top=1867 ,right=1898 ,bottom=1867 </L>
	<L> left=108 ,top=2054 ,right=1896 ,bottom=2054 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=108 ,top=2009 ,right=1896 ,bottom=2009 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=108 ,top=1962 ,right=1896 ,bottom=1962 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='2000년 이전 가입한 ' ,left=316 ,top=1793 ,right=882 ,bottom=1830 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='불입액40%와' ,left=1414 ,top=1793 ,right=1688 ,bottom=1830 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='72만원' ,left=1414 ,top=1822 ,right=1688 ,bottom=1859 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='개인연금저축' ,left=316 ,top=1822 ,right=882 ,bottom=1859 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출자 또는 투자' ,left=316 ,top=2062 ,right=882 ,bottom=2136 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출자ㆍ투자금액' ,left=919 ,top=2062 ,right=1198 ,bottom=2136 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(T_SUM,0,,T_SUM)}', left=1206, top=2062, right=1398, bottom=2136, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(T_SUMS,0,,T_SUMS)}', left=1696, top=2062, right=1885, bottom=2136, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='출자공제' ,left=121 ,top=2099 ,right=292 ,bottom=2136 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='투자조합' ,left=121 ,top=2065 ,right=292 ,bottom=2101 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='신용카드' ,left=121 ,top=2173 ,right=292 ,bottom=2212 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='등 사용액' ,left=121 ,top=2210 ,right=292 ,bottom=2249 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득공제' ,left=121 ,top=2249 ,right=292 ,bottom=2289 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='장기주식형저축소득공제' ,left=116 ,top=2410 ,right=882 ,bottom=2563 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1414 ,top=1967 ,right=1688 ,bottom=2004 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1414 ,top=2014 ,right=1688 ,bottom=2051 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1414 ,top=2062 ,right=1688 ,bottom=2136 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1414 ,top=2357 ,right=1688 ,bottom=2394 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(C_SUMS,0,,C_SUMS)}', left=1696, top=2315, right=1885, bottom=2352, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(D_SUMS,0,,D_SUMS)}', left=1696, top=2357, right=1885, bottom=2394, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FD_AMT1S,0,,FD_AMT1S)}', left=1696, top=2405, right=1885, bottom=2442, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FD_AMT2S,0,,FD_AMT2S)}', left=1696, top=2447, right=1885, bottom=2484, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FD_AMT3S,0,,FD_AMT3S)}', left=1696, top=2489, right=1885, bottom=2526, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FD_SUMS,0,,FD_SUMS)}', left=1696, top=2531, right=1885, bottom=2568, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='고용유지 중소기업 근로자 소득공제' ,left=116 ,top=2587 ,right=877 ,bottom=2624 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=108 ,top=2399 ,right=1896 ,bottom=2399 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=108 ,top=2352 ,right=1896 ,bottom=2352 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=108 ,top=2136 ,right=1896 ,bottom=2136 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=300 ,top=2310 ,right=1898 ,bottom=2310 </L>
	<L> left=300 ,top=2268 ,right=1898 ,bottom=2268 </L>
	<L> left=300 ,top=2225 ,right=1898 ,bottom=2225 </L>
	<L> left=300 ,top=2183 ,right=1898 ,bottom=2183 </L>
	<X>left=1403 ,top=512 ,right=1690 ,bottom=567 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=894 ,right=1690 ,bottom=947 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=1034 ,right=1690 ,bottom=1081 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=906 ,top=1740 ,right=1201 ,bottom=1785 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=906 ,top=2268 ,right=1201 ,bottom=2310 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=906 ,top=2310 ,right=1201 ,bottom=2352 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1201 ,top=1740 ,right=1403 ,bottom=1785 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=1432 ,right=1690 ,bottom=1482 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=1740 ,right=1690 ,bottom=1785 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=906 ,top=1912 ,right=1201 ,bottom=1962 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1201 ,top=1912 ,right=1403 ,bottom=1962 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=1912 ,right=1690 ,bottom=1962 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=2136 ,right=1690 ,bottom=2183 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=2183 ,right=1690 ,bottom=2225 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=2225 ,right=1690 ,bottom=2268 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=2268 ,right=1690 ,bottom=2310 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=2310 ,right=1690 ,bottom=2352 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=108 ,top=2573 ,right=1896 ,bottom=2573 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<X>left=1690 ,top=2136 ,right=1898 ,bottom=2183 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1690 ,top=2183 ,right=1898 ,bottom=2225 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1690 ,top=2225 ,right=1898 ,bottom=2268 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1690 ,top=2268 ,right=1898 ,bottom=2310 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=108 ,top=214 ,right=108 ,bottom=2639 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='외의 연금보험료' ,left=329 ,top=359 ,right=566 ,bottom=401 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='저축공제' ,left=118 ,top=1867 ,right=290 ,bottom=1904 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연금' ,left=118 ,top=1835 ,right=290 ,bottom=1872 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=906 ,top=2442 ,right=1403 ,bottom=2442 </L>
	<L> left=906 ,top=2484 ,right=1403 ,bottom=2484 </L>
	<L> left=906 ,top=2526 ,right=1403 ,bottom=2526 </L>
	<T>id='210㎜x297㎜' ,left=1206 ,top=2650 ,right=1893 ,bottom=2692 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1690 ,top=2526 ,right=1896 ,bottom=2526 </L>
	<L> left=1690 ,top=2484 ,right=1896 ,bottom=2484 </L>
	<L> left=1690 ,top=2442 ,right=1896 ,bottom=2442 </L>
	<T>id='%+③x5%)' ,left=1409 ,top=2481 ,right=1685 ,bottom=2515 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(①x20%+②x10' ,left=1409 ,top=2450 ,right=1685 ,bottom=2484 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제액 = ' ,left=1409 ,top=2418 ,right=1685 ,bottom=2452 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=906 ,top=1297 ,right=1201 ,bottom=1339 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=1297 ,right=1690 ,bottom=1339 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1403 ,top=2526 ,right=1690 ,bottom=2573 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
</B>










</R>
</A>





<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='3쪽.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='ds_print'
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=2707 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=29 ,top=156 ,right=1898 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='(3쪽)' ,left=1738 ,top=90 ,right=1893 ,bottom=150 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=156 ,right=29 ,bottom=2642 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=2642 ,right=1898 ,bottom=2642 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1898 ,top=156 ,right=1898 ,bottom=2642 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=906 ,top=298 ,right=1898 ,bottom=298 </L>
	<T>id='제' ,left=37 ,top=472 ,right=97 ,bottom=512 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=37 ,top=425 ,right=97 ,bottom=464 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='액' ,left=37 ,top=374 ,right=97 ,bottom=414 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=37 ,top=327 ,right=97 ,bottom=367 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세액공제' ,left=103 ,top=353 ,right=295 ,bottom=396 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=906 ,top=253 ,right=1898 ,bottom=253 </L>
	<L> left=906 ,top=345 ,right=1898 ,bottom=345 </L>
	<L> left=906 ,top=390 ,right=1898 ,bottom=390 </L>
	<T>id='입국목적' ,left=321 ,top=575 ,right=503 ,bottom=614 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='정부간 협약' ,left=737 ,top=575 ,right=921 ,bottom=614 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=700 ,top=580 ,right=724 ,bottom=606 ,border=true</X>
	<X>left=1003 ,top=580 ,right=1027 ,bottom=606 ,border=true</X>
	<X>left=1327 ,top=580 ,right=1353 ,bottom=606 ,border=true</X>
	<L> left=524 ,top=572 ,right=524 ,bottom=617 </L>
	<L> left=295 ,top=662 ,right=1898 ,bottom=662 </L>
	<T>id='외국인' ,left=103 ,top=617 ,right=295 ,bottom=657 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기술도입계약 또는 근로제공일' ,left=321 ,top=622 ,right=890 ,bottom=662 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='외국인근로소득에 대한 ' ,left=321 ,top=667 ,right=890 ,bottom=707 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='감면기간만료일' ,left=1201 ,top=622 ,right=1403 ,bottom=662 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기술도입계약' ,left=1037 ,top=575 ,right=1219 ,bottom=614 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=295 ,top=617 ,right=1893 ,bottom=617 </L>
	<L> left=103 ,top=570 ,right=1898 ,bottom=570 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='공제종류' ,left=111 ,top=163 ,right=877 ,bottom=200 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내역' ,left=914 ,top=163 ,right=1398 ,bottom=200 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=103 ,top=203 ,right=1898 ,bottom=203 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='기부정치자금' ,left=321 ,top=525 ,right=890 ,bottom=562 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=295 ,top=519 ,right=1898 ,bottom=519 </L>
	<T>id='외국납부세액' ,left=303 ,top=214 ,right=890 ,bottom=464 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     2. 현 근무지의 연금보험료ㆍ국민건강보험료 및 고용보험료 등은 신고인이 작성하지 아니하여도 됩니다.' ,left=39 ,top=1165 ,right=1885 ,bottom=1202 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='         불이익이 따릅니다.' ,left=39 ,top=1129 ,right=1885 ,bottom=1165 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     1. 종(전)근무지 근로소득을 합산하여 신고하지 아니하는 경우에는 종합소득세 신고를 하여야 하며, 신고하지 아니한 경우 가산세 부과 등' ,left=39 ,top=1089 ,right=1885 ,bottom=1129 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ※ 참고사항' ,left=39 ,top=1052 ,right=1885 ,bottom=1092 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='WKNM', left=332, top=952, right=900, bottom=991, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(사업자등록번호)' ,left=39 ,top=994 ,right=316 ,bottom=1034 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)근무지명' ,left=39 ,top=952 ,right=316 ,bottom=991 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       외국인근로자 단일세율적용신청서 제출여부 (O 또는 X 로 적습니다)' ,left=39 ,top=907 ,right=1393 ,bottom=947 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       정확하게 적었음을 확인합니다.    ' ,left=39 ,top=799 ,right=1885 ,bottom=838 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=746 ,right=1898 ,bottom=746 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=103 ,top=156 ,right=103 ,bottom=744 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='국외원천소득' ,left=911 ,top=214 ,right=1190 ,bottom=250 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제율' ,left=1406 ,top=163 ,right=1680 ,bottom=200 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=906 ,top=435 ,right=1898 ,bottom=435 </L>
	<L> left=295 ,top=203 ,right=295 ,bottom=738 </L>
	<T>id='납세액(외화)' ,left=911 ,top=258 ,right=1190 ,bottom=295 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납세액(원화)' ,left=911 ,top=303 ,right=1190 ,bottom=340 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납세국명' ,left=911 ,top=351 ,right=1190 ,bottom=388 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='신청서제출일' ,left=911 ,top=398 ,right=1190 ,bottom=435 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근무기간' ,left=911 ,top=438 ,right=1190 ,bottom=475 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FX_DATE1', left=1688, top=351, right=1877, bottom=388, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='-' ,left=1406 ,top=301 ,right=1680 ,bottom=340 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(FX_AMT1,0,,FX_AMT1)}', left=1198, top=258, right=1390, bottom=295, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FX_AMT2,0,,FX_AMT2)}', left=1198, top=303, right=1390, bottom=340, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FX_NATION', left=1198, top=351, right=1390, bottom=388, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FX_DATE2', left=1198, top=398, right=1390, bottom=435, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FX_FRTO', left=1198, top=438, right=1390, bottom=475, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='납부일' ,left=1406 ,top=351 ,right=1680 ,bottom=388 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국외근무처' ,left=1406 ,top=398 ,right=1680 ,bottom=435 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직책' ,left=1406 ,top=438 ,right=1680 ,bottom=475 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FX_WORK', left=1688, top=398, right=1877, bottom=435, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FX_POSITION', left=1688, top=438, right=1877, bottom=475, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=295 ,top=477 ,right=1893 ,bottom=477 </L>
	<T>id='근로자' ,left=108 ,top=651 ,right=292 ,bottom=691 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주택자금차입금이자세액공제' ,left=321 ,top=483 ,right=890 ,bottom=519 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이자상환액' ,left=911 ,top=483 ,right=1190 ,bottom=519 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(HX_AMT,0,,HX_AMT)}', left=1198, top=483, right=1390, bottom=519, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='30%' ,left=1406 ,top=483 ,right=1680 ,bottom=519 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(HX_AMTS,0,,HX_AMTS)}', left=1688, top=483, right=1877, bottom=519, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='10만원 이하' ,left=911 ,top=525 ,right=1190 ,bottom=562 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(GX_AMT,0,,GX_AMT)}', left=1198, top=525, right=1390, bottom=562, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='100/110' ,left=1406 ,top=525 ,right=1680 ,bottom=562 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(GX_AMTS,0,,GX_AMTS)}', left=1688, top=525, right=1877, bottom=562, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='감면신청서' ,left=321 ,top=699 ,right=890 ,bottom=738 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='접수일' ,left=911 ,top=667 ,right=1190 ,bottom=738 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제출일' ,left=1409 ,top=667 ,right=1682 ,bottom=738 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=906 ,top=617 ,right=906 ,bottom=746 </L>
	<L> left=1195 ,top=617 ,right=1195 ,bottom=746 </L>
	<L> left=1406 ,top=617 ,right=1406 ,bottom=746 </L>
	<L> left=1685 ,top=662 ,right=1685 ,bottom=746 </L>
	<L> left=906 ,top=156 ,right=906 ,bottom=570 </L>
	<L> left=1401 ,top=156 ,right=1401 ,bottom=570 </L>
	<L> left=1685 ,top=156 ,right=1685 ,bottom=570 </L>
	<T>id='       신고인은 「소득세법」 제140조에 따라 위의 내용을 신고하며, 위 내용을 충분히 검토하였고 신고인이 알고 있는 사실 그대로를 ' ,left=39 ,top=759 ,right=1885 ,bottom=799 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  제출 (      )' ,left=1393 ,top=907 ,right=1867 ,bottom=947 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=947 ,right=1898 ,bottom=947 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id=')' ,left=1830 ,top=994 ,right=1856 ,bottom=1034 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=324 ,top=947 ,right=324 ,bottom=1036 </L>
	<L> left=906 ,top=947 ,right=906 ,bottom=1036 </L>
	<L> left=1406 ,top=947 ,right=1406 ,bottom=1036 </L>
	<T>id='종(전)결정세액' ,left=911 ,top=994 ,right=1190 ,bottom=1034 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='징수영수증 제출 여부(' ,left=1409 ,top=994 ,right=1743 ,bottom=1034 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)급여총액' ,left=914 ,top=952 ,right=1193 ,bottom=991 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)근무지 근로소득원천' ,left=1409 ,top=952 ,right=1864 ,bottom=991 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(WK_AMT,0,,WK_AMT)}', left=1203, top=952, right=1395, bottom=991, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(WK_AMTSD,0,,WK_AMTSD)}', left=1203, top=997, right=1395, bottom=1034, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='「조세특레제한법」 상 감면 ' ,left=1364 ,top=575 ,right=1817 ,bottom=614 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=1685 ,top=203 ,right=1898 ,bottom=253 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1401 ,top=203 ,right=1685 ,bottom=253 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1685 ,top=253 ,right=1898 ,bottom=298 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1401 ,top=253 ,right=1685 ,bottom=298 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='인적공제 및 소득공제 명세 작성방법' ,left=45 ,top=1260 ,right=1890 ,bottom=1300 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=26 ,top=1833 ,right=1896 ,bottom=1833 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='특별공제명세 작성방법' ,left=39 ,top=1843 ,right=1885 ,bottom=1883 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     1. 배우자 또는 부양가족의 연간 소득금액이 100만원을 초과하는 경우에는 인적공제 대상에 해당하지 아니하므로 적지 아니합니다.' ,left=42 ,top=1321 ,right=1888 ,bottom=1361 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     2. 배우자 또는 형제자매 등이 부모, 자녀 등을 부양가족으로 신고한 경우 부양가족공제를 중복하여 받을 수 없으므로 적지 아니합니다.' ,left=42 ,top=1361 ,right=1888 ,bottom=1397 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     3. 부녀자공제는 부양가족(소득과 연령제한 있음)이 있는 세대주인 여성근로자 또는 배우자가 있는 여성근로자만 연 50만원을 공제합니다.' ,left=42 ,top=1397 ,right=1888 ,bottom=1434 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     5. 자녀양육비는 근로소득자의 기본공제대상자로서 6세 이하의 직계비속(입양자 포함) 1명당 100만원을 공제합니다.' ,left=42 ,top=1474 ,right=1888 ,bottom=1511 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     4. 장애인공제는 연령제한이 없으며, 장애인 1명당 연 200만원을 공제합니다.' ,left=42 ,top=1434 ,right=1888 ,bottom=1474 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     6. 출산, 입양추가공제는 해당 과세기간에 출생한 직계비속과 입양신고한 입양자에 대하여 출생,입양 1명당 200만원을 공제합니다.' ,left=42 ,top=1511 ,right=1888 ,bottom=1548 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     7. 인적공제항목은 해당란에 O표시를 하며, 각종 소득공제 항목은 공제를 위하여 실제 지출한 금액을 적습니다.' ,left=42 ,top=1545 ,right=1888 ,bottom=1585 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='         - 각종 소득공제 항목에서 보험료는 국민건강보험료, 노인장기요양보험료 및 고용보험료를 포함하고, 피보험자를 기준으로 적습니다.' ,left=42 ,top=1585 ,right=1888 ,bottom=1622 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     8. 국세청자료란은 국세청 홈페이지에서 제공하는 연말정산소득공제 명세의 각 소득공제항목의 금액을 적습니다.' ,left=42 ,top=1622 ,right=1888 ,bottom=1658 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     9. 그 밖의 자료란은 국세청에서 제공하는 증빙서류 외의 것을 적습니다.' ,left=42 ,top=1658 ,right=1888 ,bottom=1695 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     1. [근로자퇴직급여 보장법] 또는 [과학기술인공제회법]에 따라 근로자가 부담한 퇴직연금 불입액 등을 공제합니다' ,left=321 ,top=1714 ,right=1888 ,bottom=1751 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=313 ,top=1706 ,right=313 ,bottom=1835 </L>
	<T>id='퇴직연금소득공제' ,left=45 ,top=1717 ,right=308 ,bottom=1827 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       ( [소득세법] 제 51조의3제1항제3호).' ,left=321 ,top=1751 ,right=1888 ,bottom=1788 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     2. 공제한도는 연금저축공제액( [조세특례제한법] 제86조의2)과 합하여 연 300만원입니다.' ,left=321 ,top=1788 ,right=1888 ,bottom=1825 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=42 ,top=1896 ,right=305 ,bottom=1967 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='일반사항' ,left=118 ,top=1983 ,right=305 ,bottom=2020 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=311 ,top=1891 ,right=311 ,bottom=2645 </L>
	<T>id='료' ,left=34 ,top=2220 ,right=82 ,bottom=2260 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의' ,left=34 ,top=2183 ,right=82 ,bottom=2223 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비' ,left=34 ,top=2254 ,right=82 ,bottom=2294 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=87 ,top=1978 ,right=87 ,bottom=2637 </L>
	<T>id='국민건강보험의 보험료란에는 [노인장기요양보험법]에 따른 노인장기요양보험료 부담액을 포함하여 적습니다. 일반' ,left=321 ,top=1898 ,right=1888 ,bottom=1935 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보장성보험 및 장애인전용보장성보험의 보험료란에는 자동차,생명,상해보험 등 보장성보험에 불입한 금액을 적습니다.' ,left=321 ,top=1935 ,right=1888 ,bottom=1972 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의료비지급명세서의 지급금액 합계액을 적습니다.' ,left=321 ,top=1983 ,right=1888 ,bottom=2020 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       라. 시력보정용 안경 또는 콘택트렌즈 구입비용(1명당 연 50만원이 한도)' ,left=321 ,top=2413 ,right=1888 ,bottom=2450 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       다. 장애인의 보장구 및 의료기기의 구입 또는 임차비용(의료기기의 경우 의료기기를 명시한 의사의 처방전 필요)' ,left=321 ,top=2376 ,right=1888 ,bottom=2413 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       나. 치료, 요양을 위해 [약사법] 제 2조에 따른 의약품(한약 포함)을 구입하고 지급한 비용' ,left=321 ,top=2339 ,right=1888 ,bottom=2376 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       가. 진찰, 진료, 질병예방을 위하여 [의료법] 제3조에 따른 의료기관에 지급한 비용' ,left=321 ,top=2299 ,right=1888 ,bottom=2339 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     4. 의료비공제대상은 다음 각 목에 해당하는 지출액을 말합니다.' ,left=321 ,top=2265 ,right=1888 ,bottom=2302 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     3. 그 밖의 공제대상자 의료비는 총급여액의 3%를 초과하여 지출한 금액을 공제하되, 연 700만원 한도로 공제합니다.' ,left=321 ,top=2228 ,right=1888 ,bottom=2265 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       1월1일부터 12월 31일까지 지급한 금액입니다.' ,left=321 ,top=2115 ,right=1888 ,bottom=2152 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     1. 공제대상은 본인과 기본공제대상자(연령 및 소득금액의 제한을 받지 아니합니다)를 위하여 해당연도 ' ,left=321 ,top=2075 ,right=1888 ,bottom=2115 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       마. 보청기 구입비용' ,left=321 ,top=2450 ,right=1888 ,bottom=2486 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       바. [노인장기요양보험법] 제40조제1항에 따라 실제 지출한 본인일부부담금' ,left=321 ,top=2486 ,right=1888 ,bottom=2523 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       사. 미용, 성형수술 비용 및 건강증진을 위한 의약품 구입비용(2009년 12월 31일까지 지출한 금액에 한정함)' ,left=321 ,top=2523 ,right=1888 ,bottom=2560 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='및 공제금액' ,left=92 ,top=2283 ,right=303 ,bottom=2320 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의료비공제대상' ,left=92 ,top=2246 ,right=303 ,bottom=2283 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=87 ,top=2022 ,right=1896 ,bottom=2025 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='     2. 본인, 65세이상자, 장애인의 의료비는 의료비지급액이 공제액입니다. 다만, 그 밖의 공제대상자의 ' ,left=321 ,top=2152 ,right=1888 ,bottom=2188 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       의료비가 총 급여액의 3%에 미달하는 경우 그 미달하는 금액을 뺍니다.' ,left=321 ,top=2188 ,right=1888 ,bottom=2228 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1195 ,top=206 ,right=1195 ,bottom=570 </L>
	<L> left=1195 ,top=947 ,right=1195 ,bottom=1036 </L>
	<L> left=29 ,top=910 ,right=1898 ,bottom=910 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=1975 ,right=1898 ,bottom=1975 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=1888 ,right=1898 ,bottom=1888 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=1703 ,right=1898 ,bottom=1703 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=1310 ,right=1898 ,bottom=1310 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=1252 ,right=1898 ,bottom=1252 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=1036 ,right=1898 ,bottom=1036 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=1210 ,right=1898 ,bottom=1210 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=906 ,top=991 ,right=1406 ,bottom=991 </L>
	<C>id='WKRESINO', left=332, top=994, right=900, bottom=1034 ,mask='XXX-XX-XXXXX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CURDT2', left=627, top=833, right=1195, bottom=873 ,mask='XXXX년XX월XX일', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='신고인' ,left=1198 ,top=862 ,right=1340 ,bottom=902 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNMK', left=1340, top=862, right=1606, bottom=902, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(서명 또는 인)' ,left=1606 ,top=862 ,right=1877 ,bottom=902 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>


</R>
</A>

 ">
<%=HDConstant.COMMENT_END%>
</FORM>
</BODY>
</HTML>
