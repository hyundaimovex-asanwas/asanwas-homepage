<%@ page language="java" contentType="text/html;charset=ksc5601" %>
<%
/******************************************************************************
 * 시스템명		: 급여시스템
 * 프로그램ID   : P030010
 * J  S  P		: P030010i
 * 서 블 릿		: 
 * 작 성 자		: 심동현
 * 작 성 일		: 2007-01-11
 * 기능정의		:	ds1) 기본정보 + 기타공제 일부
							ds2) 종전근무지 
							ds3) 인적공제
							ds4) 기부
							ds8) 주택자금
							ds11) 연금저축,등등등
 *                   
 * 최종수정일자 	: 2010-12-16

  * 최종수정일자 	: 2011 -1-12 이동훈

 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy 		 = request.getParameter("eyy");			//귀속년도
    String eno 		 = request.getParameter("eno");			//사번   
    eyy="2010";


%>

<HTML>
<HEAD>
<TITLE><%=eyy%>년 근로소득공제 신고서 입력</TITLE>
<META http-equiv=Content-Type content="text/html; charset=euc-kr">

<LINK href="imgs/css_ehr.css" type=text/css rel=stylesheet>

<!-- 기존 가우스 시작-->
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
 <Script language="javascript" src="../../common/include/PubFun.js"></script>

<script language="javascript" src="js/PubFun.js"></script>
<script language="javascript" src="js/embedControl.js"></script>
<script language="javascript" src="js/menu.js"></script>
<script language="javascript" src="js/common_gauce.js"></script>
<script language="javascript" src="js/common_pop.js"></script>      
<script language="javascript" src="js/common.js"></script>       
<script language=javascript   src="imgs/web.js"></script> 
<script language=javascript   src="imgs/06yearentry.js"></script>
<script language=javascript	src="imgs/ApplyChk.js"></script> 

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	var gstrChk =""; //등록
	var gs_level;
	var gs_treecd;
	
	var gs_temp ="1";
	var gs_temp2 ="1";


	get_cookdata();
	
	var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);

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
			
		fnSelect("<%=eyy%>", "<%=eno%>");		//기본정보 조회 (개인소득 + 잡다)
		fnSelect2("<%=eyy%>", "<%=eno%>");	 	//기본정보 조회 (종전근무)
		fnSelect3("<%=eyy%>", "<%=eno%>");		//기본정보 조회 (인적공제)
		fnSelect4("<%=eyy%>", "<%=eno%>");		//기본정보 조회 (기부금)		
		fnSelect8("<%=eyy%>", "<%=eno%>");		//기본정보 조회 (주택)
		fnSelect11("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (개인연금등등등)

	}
	
	function ln_SetDataHeader(){


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

			v_job = "S";	//select 일듯..

			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030010i",	//		경로 주의할 것!
			    "JSP(O:DS1=ds1)",
			    param);

			tr_post(tr1);

           //prompt(this, ds1.text);
	}



	function fnSelect2(pYear, pEmpno) {	 //종전근무지
			v_job = "S";	//select 일듯..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030010i",	//	
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
			    "/services/servlet/Payroll.p030010i",	//	
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
			    "/services/servlet/Payroll.p030010i",	//	
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
			    "/services/servlet/Payroll.p030010i",	
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
			    "/services/servlet/Payroll.p030010i",	//	
			    "JSP(O:DS6=ds6)",
			    param);

			tr_post(tr1);

	}	
	
	function fnSelect12(pYear, pEmpno) {	 //출력시 연말정산 연금저축등등등

			v_job = "S";	//select 일듯..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;
			
			ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030010i",	//	
			    "JSP(O:DS12=ds12)",
			    param);

			tr_post(tr1);

	}	

	
	function fnSelect8(pYear, pEmpno) {	 //주택

			v_job = "S";	//select 일듯..

			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr3, 
			    "/services/servlet/Payroll.p030010i",	//	
			    "JSP(O:DS8=ds8)",
			    param);

			tr_post(tr3);

	}

	function fnSelect11(pYear, pEmpno) {	 //연금등등

			v_job = "S";	//select 일듯..

			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr3, 
			    "/services/servlet/Payroll.p030010i",	//	
			    "JSP(O:DS11=ds11)",
			    param);

			tr_post(tr3);

	}	


/******************************************************************************
	Description :  저장
******************************************************************************/
    function fnApply() {// 현재 데이터셋 반영
       
		//prompt(this, ds1.namevalue(ds3.rowposition, "HOUSEYN"));

		if(ds1.namevalue(ds1.rowposition, "HOUSEYN") != "1" && ds1.namevalue(ds1.rowposition, "HOUSEYN") != "2") {	//선택안했을 경우

			alert("세대주/세대원 구분을 입력하시기 바랍니다.");
			return;

		}



        if (ds1.IsUpdated) {

			if(!fnSaveChk()){
				alert("전산 제출이 이미 되었습니다. 수정건이 있으면 전산 관리자에게 문의하십시요.");
				return;
			}
         
			v_job = "I";	

			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

            ln_TRSetting(tr1, 
                "/services/servlet/Payroll.p030010i",
                "JSP(I:DS1=ds1,O:RESULT=ds_result)",			//여기의 DS1, RESULT 등이 java 파일의 req.getGauceDataSetKeys() 에서 불러짐.
                param);

			//prompt(this, ds1.text);

            tr_post(tr1);

        } else {
            alert("기본공제 정보의 변경 내역이 없습니다!");
        }
    }
    

/******************************************************************************
	Description : 취소시 undo all
******************************************************************************/
	function fnCancel() {	
		ds1.undoall();
	} 






	function fnApply2() {	 

		gs_temp2 = "";

		fnApply3();


	}


/******************************************************************************
	Description : 인적 공제 저장
******************************************************************************/
	//행추가
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
		ds3.namevalue(ds3.rowposition, "REF8")="F"; 

	}

	//행삭제
	function fnDeleteRow3() {
		/*if (ds1.namevalue(ds1.rowposition,"close_yn") == "Y") {
        	alert("마감된 자료입니다. 삭제할수 없습니다");
        	ds1.undo(ds1.rowposition);
        	return;
        }*/
		ds3.DeleteRow(ds3.RowPosition);
	}



    function fnApply3() {// 현재 데이터셋 반영

		//prompt(this, ds3.text); 

		if(!Basic_Apply_Chk("ds3")) return; //기본 인적공제 체크


		if (ds3.IsUpdated) {

			if(!fnSaveChk()){
				alert("전산 제출이 이미 되었습니다. 수정건이 있으면 전산 관리자에게 문의하십시요.");
				return;
			}

			if(!fnSaveChk2()){
				alert("직계존속의 경우 1950년 이후 출생자는 기본 공제 대상이 아닙니다1!");
				return;
			}

			if(!fnSaveChk3()){
				//alert("직계존속의 경우 1950년 이후 출생자는 기본 공제 대상이 아닙니다!");
				return;
			}

			v_job = "I";	
        
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

            ln_TRSetting(tr1, 
                "/services/servlet/Payroll.p030010i",
                "JSP(I:DS3=ds3,O:RESULT=ds_result)",	//여기의 DS1, RESULT 등이 java 파일의 req.getGauceDataSetKeys() 에서 불러짐.
                param);

			//prompt(this, ds3.text);

            tr_post(tr1);

        } else {
            alert("인적공제 정보의 변경 내역이 없습니다.");
        }
    }


function fnSaveChk2(){

		//prompt(this, ds3.text);

		for(i=1;i<=ds3.countrow;i++){
		//직계존속은 50년 이상
		if( ds3.namevalue(i, "RELAT1") == "1" || ds3.namevalue(i, "RELAT1") == "2" ){	
				if( (ds3.namevalue(i,"RESINO1").substr(0,2)) >="51"){ //2010년도 기준
					if(ds3.namevalue(i,"REF2")=="T"){	 
					ds3.namevalue(i,"REF2")="F";
					return false;
					}else{
					return true;					
					}
					return true;	
				}
					return true;	
			}
					return true;
		}
					return true;	
}


function fnSaveChk3(){
        //주민번호 입력시 자동설정 - 경로우대, 자녀, 형제
    var strResino="";
	var strGb="";
	var strGb2="";

    for(irow=1;irow<=ds3.countrow;irow++){
		if(ds3.namevalue(irow, "REF2")=="T"){
	        // if(empno = 
			//prompt(this, ds3.namevalue(irow, "RESINO1"));
		
			strResino = ds3.namevalue(irow, "RESINO1");
			strGb = strResino.substring(6,7);
			strGb2 = strResino.substring(0,2);

			strResino = strResino.substring(0,6);
			strResino = ln_yyyymmdd(strGb,strGb2,strResino);
		   
		    //장애인 기본공제대상자임. ( 연령불문.

			//직계존속은 50년 이상
			if( ds3.namevalue(irow, "RELAT1") == "1" || ds3.namevalue(irow, "RELAT1") == "2" ){

				//2011.01.20 jys 막음
				/******************************************************************
				if(strGb2>="51" ){ //2010년도 기준
						if(ds3.namevalue(irow,"REF2")=="T"){	 
							alert("직계존속의 경우 1950년 이전 출생 기준입니다");
							//ds3.namevalue(irow,"RESINO1")="";
							return false;
						}
				}
				*******************************************************************/
				//alert("strGb2::"+strGb2);
				if(ds3.namevalue(irow,"REF3")!="T"){
					if(strGb2>="51" ){ //2010년도 기준
						alert("직계존속의 경우 1950년 이전 출생 기준입니다2");
						//ds3.namevalue(irow,"RESINO1")="";
						return false;
					}
				}
			}


			//직계비속은 89년 이하 
			if( strGb != "3" &&  strGb != "4"){
				//2011.01.20 jys 막음
				/******************************************************************
				if( ds3.namevalue(irow, "RELAT1") == "4" || ds3.namevalue(irow, "RELAT1") == "5" || ds3.namevalue(irow, "RELAT1") == "8"){	
					if(strGb2<="89"){ //2010년도 기준
						alert("직계비속의 경우 1990년 이후 출생 기준입니다 .");
						return false;
					}
				}
				*******************************************************************/
                if(ds3.namevalue(irow,"REF3")!="T"){
					if( ds3.namevalue(irow, "RELAT1") == "4" || ds3.namevalue(irow, "RELAT1") == "5" || ds3.namevalue(irow, "RELAT1") == "8"){	
						if(strGb2<="89"){ //2010년도 기준
							alert("직계비속의 경우 1990년 이후 출생 기준입니다3 .");
							return false;
						}
					}
				}
			}


			//형제자매는 89년 이하 또는 51년이상
			if( ds3.namevalue(irow, "RELAT1") == "6"){	
				//2011.01.20 jys 막음
  			    /******************************************************************
				if(strGb2<="89"|| strGb2>="51"){ //2010년도 기준
				alert("형제자매의 경우 1950년 이전 또는 1990년 이후 출생 기준입니다");
				//ds3.namevalue(irow,"RESINO1")="";

				return false;
				
				}
				*******************************************************************/
                if(ds3.namevalue(irow,"REF3")!="T"){
					if(strGb2<="89"&& strGb2>="51"){ //2010년도 기준
						alert("형제자매의 경우 1950년 이전 또는 1990년 이후 출생 기준입니다");
						//ds3.namevalue(irow,"RESINO1")="";
						return false;
					}
				}
			}		
		}
	}//for

	return true;

}




	function fnCancel3() {	//취소시 undo all. 
		ds3.undoall();
	}



/******************************************************************************
	Description : 전산제출
******************************************************************************/
	function fnSubmit(){ //전산제출


		if(ds1.namevalue(ds1.rowposition, "HOUSEYN") != "1" && ds1.namevalue(ds1.rowposition, "HOUSEYN") != "2") {	//선택안했을 경우

			alert("세대주/세대원 구분을 입력하신 뒤에 저장 버튼을 누르시기 바랍니다.");
			return;

		}

		if(confirm("전산 제출한 후에는 데이타 입력,수정,삭제가 불가합니다.\n\n전산제출을 하시겠습니까?")){

			ln_SetDataHeader_Submit();

			ds7.Addrow();
			ds7.namevalue(ds7.rowposition,"EMPNO")=ds1.namevalue(ds1.rowposition,"EMPNO");
			ds7.namevalue(ds7.rowposition,"APPDT")=ds1.namevalue(ds1.rowposition,"APPDT");

			if (ds7.IsUpdated) {
				v_job = "I";	
				var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

				ln_TRSetting(tr1, 
					"/services/servlet/Payroll.p030010i",
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
			"/services/servlet/Payroll.p030010i",	//		경로 주의할 것!
			"JSP(O:DS9=ds9)",
			param);
		tr_post(tr1);

		if(ds9.namevalue(ds9.rowposition,"SENDFLAG")=="Y"){
			return false;
		}else{
            return true;
	    }
	}





/******************************************************************************
	Description : 출력시
******************************************************************************/

	function fnPrint(){ //출력물
   

	    if(fnSaveChk()){
			alert("전산제출 이전입니다. 전산제출 후 출력하십시요.");
			return;
		}


        //출력 직전에 작업을 돌린다.
		ds_print.ClearAll();

        fnSelect5("<%=eyy%>", "<%=eno%>");   //근로소득신고서 출력-기본(인적공제)
		fnSelect6("<%=eyy%>", "<%=eno%>");   //근로소득신고서 출력-기본
		fnSelect12("<%=eyy%>", "<%=eno%>");   //근로소득신고서 출력-연금등등등

        var row=0;

		ln_Rpt_SetDataHeader();//데이타 셋헤드 

        ds_print.addrow();



		//ds5.인적공제

		//ds6.공제신고서
 
		//ds12.연금저축등등등

        //인사 기본정보 
		row = ds_print.rowposition;
		row1 = ds6.rowposition;
		ds_print.namevalue(row,"EMPNO")    =ds6.namevalue(ds1.rowposition,"EMPNO")
		ds_print.namevalue(row,"YYYY")     =ds6.namevalue(row1,"APPYY");
		ds_print.namevalue(row,"EMPNMK")   =ds6.namevalue(row1,"EMPNMK");
		ds_print.namevalue(row,"EMPJUNO")  = ds6.namevalue(row1,"RESINO");
		ds_print.namevalue(row,"EMPJUNO1")  = ds6.namevalue(row1,"RESINO").substr(0,1);
		ds_print.namevalue(row,"EMPJUNO2")  =ds6.namevalue(row1,"RESINO").substr(1,1);
		ds_print.namevalue(row,"EMPJUNO3")  =ds6.namevalue(row1,"RESINO").substr(2,1);
		ds_print.namevalue(row,"EMPJUNO4")  =ds6.namevalue(row1,"RESINO").substr(3,1);
		ds_print.namevalue(row,"EMPJUNO5")  =ds6.namevalue(row1,"RESINO").substr(4,1);
		ds_print.namevalue(row,"EMPJUNO6")  =ds6.namevalue(row1,"RESINO").substr(5,1);
		ds_print.namevalue(row,"EMPJUNO7")  =ds6.namevalue(row1,"RESINO").substr(6,1);
		ds_print.namevalue(row,"EMPJUNO8")  =ds6.namevalue(row1,"RESINO").substr(7,1);
		ds_print.namevalue(row,"EMPJUNO9")  =ds6.namevalue(row1,"RESINO").substr(8,1);
		ds_print.namevalue(row,"EMPJUNO10")  =ds6.namevalue(row1,"RESINO").substr(9,1);
		ds_print.namevalue(row,"EMPJUNO11")  =ds6.namevalue(row1,"RESINO").substr(10,1);
		ds_print.namevalue(row,"EMPJUNO12")  =ds6.namevalue(row1,"RESINO").substr(11,1);
		ds_print.namevalue(row,"EMPJUNO13")  =ds6.namevalue(row1,"RESINO").substr(12,1);

		//alert(ds_print.namevalue(row,"EMPJUNO"));

		ds_print.namevalue(row,"ADDRESS")  =ds6.namevalue(row1,"ADDR1")+" "+ds6.namevalue(row1,"ADDR2");
		ds_print.namevalue(row,"TELNO")  =ds6.namevalue(row1,"TELNO");
		ds_print.namevalue(row,"COMPANY")  =ds6.namevalue(row1,"WORKPLACE");
		ds_print.namevalue(row,"COMRESINO")=ds6.namevalue(row1,"WORKNO");
		ds_print.namevalue(row,"CURDT3")   =ds6.namevalue(row1,"WORKFR"); //근무시작일
		ds_print.namevalue(row,"CURDT")    =ds6.namevalue(row1,"WORKTO"); //근무종료일
		ds_print.namevalue(row,"CNT")      =ds6.namevalue(row1,"CNT");
		ds_print.namevalue(row,"CURDT2") = gs_date;
        
		
		//세대주여부
		if(ds6.namevalue(row1,"HOUSEYN")=="1"){ //세대주
			ds_print.namevalue(row,"HYN1")="■";   
			ds_print.namevalue(row,"HYN2")="□";
		}else{                                  //세대원
			ds_print.namevalue(row,"HYN1")="□";   
			ds_print.namevalue(row,"HYN2")="■";
		}

        //거주구분
		if(ds6.namevalue(row1,"RESIGB")=="1"){  //거주자
			ds_print.namevalue(row,"RESIGB1")="■";   
			ds_print.namevalue(row,"RESIGB2")="□";
		}else{                                  //비거주자
			ds_print.namevalue(row,"RESIGB1")="□";   
			ds_print.namevalue(row,"RESIGB2")="■";
		}

		//인적공제변동여부
		if(ds6.namevalue(row1,"PEALLOWYN")=="1"){ //전년과동일
			ds_print.namevalue(row,"PEALLOWYN1")="■";   
			ds_print.namevalue(row,"PEALLOWYN2")="□";
		}else{                                  //변동
			ds_print.namevalue(row,"PEALLOWYN1")="□";   
			ds_print.namevalue(row,"PEALLOWYN2")="■";
		}
		
		//국적코드
		ds_print.namevalue(row,"NATIONCD") = ds6.namevalue(row1,"NATIONCD");
		//거주지국코드 
		ds_print.namevalue(row,"RESINACD") = ds6.namevalue(row1,"RESINACD");
		
	


        var dblref11=0;
		var dblref12=0;
		var dblref13=0;
		var dblref14=0;
		var dblref15=0;
		var dblref16=0;
        var dblref17=0; 
		var dblref21=0;
		var dblref22=0;
		var dblref23=0;
		var dblref24=0;
		var dblref26=0;
		var dblref27=0;
  
        var i=0;

		for(i=1;i<=ds5.countrow;i++){
         
          ds_print.namevalue(row,"RELAT1_"+i)=ds5.namevalue(i,"RELAT1");

		  if(ds5.namevalue(i,"REF1")=="T")
			  ds_print.namevalue(row,"REF1_"+i)="9"; //내.외국인
		  else 
			  ds_print.namevalue(row,"REF1_"+i)="1";

		  if(ds5.namevalue(i,"REF2")=="T")
			  ds_print.namevalue(row,"REF2_"+i)="O"; //기본공제
		  else 
			  ds_print.namevalue(row,"REF2_"+i)="";

		  if(ds5.namevalue(i,"REF3")=="T")
			  ds_print.namevalue(row,"REF3_"+i)="O"; //장애인
		  else 
			  ds_print.namevalue(row,"REF3_"+i)="";

		  if(ds5.namevalue(i,"REF5")=="T")
			  ds_print.namevalue(row,"REF5_"+i)="O"; //경로우대
		  else 
			  ds_print.namevalue(row,"REF5_"+i)=""; 

		  if(i>1){
            if(ds5.namevalue(i,"REF4")=="T")
				ds_print.namevalue(row,"REF4_"+i)="O"; //자녀양육비
		    else 
				ds_print.namevalue(row,"REF4_"+i)="";

			if(ds5.namevalue(i,"REF7")=="T")
				ds_print.namevalue(row,"REF7_"+i)="O"; //다자녀
		    else 
				ds_print.namevalue(row,"REF7_"+i)="";

			if(ds5.namevalue(i,"REF8")=="T")
				ds_print.namevalue(row,"REF8_"+i)="O"; //출산입양
		    else 
				ds_print.namevalue(row,"REF8_"+i)="";

            ds_print.namevalue(row,"EMPNMK_"+i) = ds5.namevalue(i,"FAMNM1");
			ds_print.namevalue(row,"EMPJUNO_"+i) = ds5.namevalue(i,"RESINO1");

		  }else if(i==1){
            if(ds5.namevalue(i,"REF6")=="T")
				ds_print.namevalue(row,"REF6_"+i)="O"; //부녀자
		    else 
				ds_print.namevalue(row,"REF6_"+i)=""; 
		  }




		  ds_print.namevalue(row,"REF11_"+i)=ds5.namevalue(i,"REF11");
		  ds_print.namevalue(row,"REF12_"+i)=ds5.namevalue(i,"REF12");
		  ds_print.namevalue(row,"REF13_"+i)=ds5.namevalue(i,"REF13");
		  ds_print.namevalue(row,"REF14_"+i)=ds5.namevalue(i,"REF14");
		  ds_print.namevalue(row,"REF15_"+i)=ds5.namevalue(i,"REF15");
		  ds_print.namevalue(row,"REF16_"+i)=ds5.namevalue(i,"REF16");
		  ds_print.namevalue(row,"REF17_"+i)=ds5.namevalue(i,"REF17");

		  ds_print.namevalue(row,"REF21_"+i)=ds5.namevalue(i,"REF21");
		  ds_print.namevalue(row,"REF22_"+i)=ds5.namevalue(i,"REF22");
		  ds_print.namevalue(row,"REF23_"+i)=ds5.namevalue(i,"REF23");
		  ds_print.namevalue(row,"REF24_"+i)=ds5.namevalue(i,"REF24");
		  ds_print.namevalue(row,"REF26_"+i)=ds5.namevalue(i,"REF26");
		  ds_print.namevalue(row,"REF27_"+i)=ds5.namevalue(i,"REF27");

		  dblref11 += parseInt(ds5.namevalue(i,"REF11"));
		  dblref12 += parseInt(ds5.namevalue(i,"REF12"));
		  dblref13 += parseInt(ds5.namevalue(i,"REF13"));
		  dblref14 += parseInt(ds5.namevalue(i,"REF14"));
		  dblref15 += parseInt(ds5.namevalue(i,"REF15"));
		  dblref16 += parseInt(ds5.namevalue(i,"REF16"));
		  dblref17 += parseInt(ds5.namevalue(i,"REF17"));

		  dblref21 += parseInt(ds5.namevalue(i,"REF21"));
		  dblref22 += parseInt(ds5.namevalue(i,"REF22"));
		  dblref23 += parseInt(ds5.namevalue(i,"REF23"));
		  dblref24 += parseInt(ds5.namevalue(i,"REF24"));
          dblref26 += parseInt(ds5.namevalue(i,"REF26"));
		  dblref27 += parseInt(ds5.namevalue(i,"REF27"));
		}

        ds_print.namevalue(row,"REF11_S") = dblref11;  //보험료(국세청자료)
		ds_print.namevalue(row,"REF12_S") = dblref12;  //의료비
		ds_print.namevalue(row,"REF13_S") = dblref13;  //교육비
		ds_print.namevalue(row,"REF14_S") = dblref14;  //신용카드
		ds_print.namevalue(row,"REF15_S") = dblref15;  //현금영수증
		ds_print.namevalue(row,"REF16_S") = dblref16;  //기부금
        ds_print.namevalue(row,"REF17_S") = dblref17;  //직불카드
		ds_print.namevalue(row,"REF21_S") = dblref21;  //보험료(그밖의자료)
		ds_print.namevalue(row,"REF22_S") = dblref22;  //의료비            
		ds_print.namevalue(row,"REF23_S") = dblref23;  //교육비            
		ds_print.namevalue(row,"REF24_S") = dblref24;  //신용카드          
		ds_print.namevalue(row,"REF26_S") = dblref26;  //기부금     
		ds_print.namevalue(row,"REF27_S") = dblref27;  //직불카드

		/*연금보험료공제*/
        ds_print.namevalue(row,"BPENAMT01") =ds6.namevalue(row1,"BPENAMT01");//종전근무지(국민연금)
		ds_print.namevalue(row,"CPENAMT01") =ds6.namevalue(row1,"CPENAMT01");//현근무지(국민연금)
		ds_print.namevalue(row,"BPENAMT02") =ds6.namevalue(row1,"BPENAMT02");//종전 국민연금외
		ds_print.namevalue(row,"CPENAMT02") =ds6.namevalue(row1,"CPENAMT02");//현 국민연금외
		ds_print.namevalue(row,"BPENAMT03") =ds6.namevalue(row1,"BPENAMT03");//종전 퇴직연금
		ds_print.namevalue(row,"CPENAMT03") =ds6.namevalue(row1,"CPENAMT03");//현 퇴직연금
		ds_print.namevalue(row,"PENSUM")    =ds6.namevalue(row1,"PENSUM");   //연금보험계

		//보험료
		ds_print.namevalue(row,"BINSAMT01") =ds6.namevalue(row1,"BINSAMT01");//
		ds_print.namevalue(row,"CINSAMT01") =ds6.namevalue(row1,"CINSAMT01");//
		ds_print.namevalue(row,"BINSAMT02") =ds6.namevalue(row1,"BINSAMT02");//
		ds_print.namevalue(row,"CINSAMT02") =ds6.namevalue(row1,"CINSAMT02");//
		ds_print.namevalue(row,"INSAMT03")  =ds6.namevalue(row1,"INSAMT03"); //
		ds_print.namevalue(row,"INSAMT04")  =ds6.namevalue(row1,"INSAMT04"); //
		ds_print.namevalue(row,"INSSUM")    =ds6.namevalue(row1,"INSSUM");   //

		//의료비
		ds_print.namevalue(row,"MEDAMT01")  =ds6.namevalue(row1,"MEDAMT01"); //
		ds_print.namevalue(row,"MEDAMT02")  =ds6.namevalue(row1,"MEDAMT02"); //
        ds_print.namevalue(row,"MEDSUM")    =ds6.namevalue(row1,"MEDSUM");   //

		//교육비
		ds_print.namevalue(row,"EDUAMT01")  =ds6.namevalue(row1,"EDUAMT01"); //
		ds_print.namevalue(row,"EDUCNT02")  =ds6.namevalue(row1,"EDUCNT02"); //
        ds_print.namevalue(row,"EDUAMT02")  =ds6.namevalue(row1,"EDUAMT02"); //
        ds_print.namevalue(row,"EDUCNT03")  =ds6.namevalue(row1,"EDUCNT03"); //
		ds_print.namevalue(row,"EDUAMT03")  =ds6.namevalue(row1,"EDUAMT03"); //
        ds_print.namevalue(row,"EDUCNT04")  =ds6.namevalue(row1,"EDUCNT04"); //
		ds_print.namevalue(row,"EDUAMT04")  =ds6.namevalue(row1,"EDUAMT04"); //
		ds_print.namevalue(row,"EDUCNT05")  =ds6.namevalue(row1,"EDUCNT05"); //
		ds_print.namevalue(row,"EDUAMT05")  =ds6.namevalue(row1,"EDUAMT05"); //
		ds_print.namevalue(row,"EDUSUM")    =ds6.namevalue(row1,"EDUSUM");   //
 
        //주택자금
		ds_print.namevalue(row,"HOUAMT01")  =ds6.namevalue(row1,"HOUAMT01"); //
		ds_print.namevalue(row,"HOUAMT02")  =ds6.namevalue(row1,"HOUAMT02"); //
		ds_print.namevalue(row,"HOUSUM")    =ds6.namevalue(row1,"HOUSUM");   //

        //기부금
		ds_print.namevalue(row,"CONAMT01")  =ds6.namevalue(row1,"CONAMT01"); //
		ds_print.namevalue(row,"CONAMT02")  =ds6.namevalue(row1,"CONAMT02"); //
		ds_print.namevalue(row,"CONAMT03")  =ds6.namevalue(row1,"CONAMT03"); //
		ds_print.namevalue(row,"CONAMT04")  =ds6.namevalue(row1,"CONAMT04"); //
		ds_print.namevalue(row,"CONAMT05")  =ds6.namevalue(row1,"CONAMT05"); //
		ds_print.namevalue(row,"CONAMT06")  =ds6.namevalue(row1,"CONAMT06"); //
		ds_print.namevalue(row,"CONAMT07")  =ds6.namevalue(row1,"CONAMT07"); //

		//연금저축
		ds_print.namevalue(row,"PESAMT01")  =ds6.namevalue(row1,"PESAMT01"); //
		ds_print.namevalue(row,"PESAMT02")  =ds6.namevalue(row1,"PESAMT02"); //

		//주택마련저축
		ds_print.namevalue(row,"SAVAMT01")  =ds6.namevalue(row1,"SAVAMT01"); //
		ds_print.namevalue(row,"SAVAMT02")  =ds6.namevalue(row1,"SAVAMT02"); //
		ds_print.namevalue(row,"SAVAMT03")  =ds6.namevalue(row1,"SAVAMT03"); //
		ds_print.namevalue(row,"SAVAMT04")  =ds6.namevalue(row1,"SAVAMT04"); //
		ds_print.namevalue(row,"SAVSUM")    =ds6.namevalue(row1,"SAVSUM");   //

		//신용카드
		ds_print.namevalue(row,"CRDAMT01")  =ds6.namevalue(row1,"CRDAMT01"); //
		ds_print.namevalue(row,"CRDAMT02")  =ds6.namevalue(row1,"CRDAMT02"); //
		ds_print.namevalue(row,"CRDAMT03")  =ds6.namevalue(row1,"CRDAMT03"); //
		ds_print.namevalue(row,"CRDAMT04")  =ds6.namevalue(row1,"CRDAMT04"); //
		ds_print.namevalue(row,"CRDSUM")    =ds6.namevalue(row1,"CRDSUM");   //

		//장기주식형저축소득공제
		ds_print.namevalue(row,"FNDAMT01")  =ds6.namevalue(row1,"FNDAMT01");  //
		ds_print.namevalue(row,"FNDAMT02")  =ds6.namevalue(row1,"FNDAMT02");  //
		ds_print.namevalue(row,"FNDAMT03")  =ds6.namevalue(row1,"FNDAMT03");  //
		ds_print.namevalue(row,"FNDSUM")    =ds6.namevalue(row1,"FNDSUM");    //

		//세액공제
		ds_print.namevalue(row,"CONAMT99")   =ds6.namevalue(row1,"CONAMT99");  //
		ds_print.namevalue(row,"FORPAYAMT")  =ds6.namevalue(row1,"FORPAYAMT"); //
		ds_print.namevalue(row,"TAXAMT01")   =ds6.namevalue(row1,"TAXAMT01");  //
		ds_print.namevalue(row,"TAXAMT02")   =ds6.namevalue(row1,"TAXAMT02");  //

		ds_print.namevalue(row,"TAXNATION")   =ds6.namevalue(row1,"TAXNATION"); //
        ds_print.namevalue(row,"TAXAPPDT")    =ds6.namevalue(row1,"TAXAPPDT");  //
		ds_print.namevalue(row,"TAXDTFR")     =ds6.namevalue(row1,"TAXDTFR");   //
		ds_print.namevalue(row,"TAXDTTO")     =ds6.namevalue(row1,"TAXDTTO");   //
		ds_print.namevalue(row,"TAXPAYDT")    =ds6.namevalue(row1,"TAXPAYDT");  //
		ds_print.namevalue(row,"FORPLACE")    =ds6.namevalue(row1,"FORPLACE");  //
		ds_print.namevalue(row,"FORJOB")      =ds6.namevalue(row1,"FORJOB");    //

		//종전근무지
		ds_print.namevalue(row,"WKNM")        =ds6.namevalue(row1,"WKNM");     //
		ds_print.namevalue(row,"WKRESINO")    =ds6.namevalue(row1,"WKRESINO"); //
		ds_print.namevalue(row,"BP10SUM")     =ds6.namevalue(row1,"BP10SUM");  //
		ds_print.namevalue(row,"BP41000")     =ds6.namevalue(row1,"BP41000");  //




		//연금등등등
		var no = 1;
		for(i=1;i<=ds12.countrow;i++){
			  if(ds12.namevalue(i,"DUDGB")=="11"){
				  ds_print.namevalue(row,"DUDGBNM1_"+no)="퇴직연금";									//퇴직연금
				  ds_print.namevalue(row,"FINANM1_"+no)=ds12.namevalue(i,"FINANM");			//금융기관상호
				  ds_print.namevalue(row,"ACCNO1_"+no)=ds12.namevalue(i,"ACCNO");				//계좌번호
				  ds_print.namevalue(row,"PAYAMT1_"+no)=ds12.namevalue(i,"PAYAMT");			//불입금액
				  ds_print.namevalue(row,"DEDAMT1_"+no)=ds12.namevalue(i,"DEDAMT");			//공제금액
				  no++;
				}else if(ds12.namevalue(i,"DUDGB")=="12"){
				  ds_print.namevalue(row,"DUDGBNM1_"+no)="과학기술인공제";							//과학기술인공제
				  ds_print.namevalue(row,"FINANM1_"+no)=ds12.namevalue(i,"FINANM");			//금융기관상호
				  ds_print.namevalue(row,"ACCNO1_"+no)=ds12.namevalue(i,"ACCNO");				//계좌번호
				  ds_print.namevalue(row,"PAYAMT1_"+no)=ds12.namevalue(i,"PAYAMT");			//불입금액
				  ds_print.namevalue(row,"DEDAMT1_"+no)=ds12.namevalue(i,"DEDAMT");			//공제금액
				  no++;
				}
		}

		var no2 = 1;
		for(i=1;i<=ds12.countrow;i++){
			  if(ds12.namevalue(i,"DUDGB")=="21"){
				  ds_print.namevalue(row,"DUDGBNM2_"+no2)="개인연금저축";								//개인연금저축
				  ds_print.namevalue(row,"FINANM2_"+no2)=ds12.namevalue(i,"FINANM");				//금융기관상호
				  ds_print.namevalue(row,"ACCNO2_"+no2)=ds12.namevalue(i,"ACCNO");				//계좌번호
				  ds_print.namevalue(row,"PAYAMT2_"+no2)=ds12.namevalue(i,"PAYAMT");				//불입금액
				  ds_print.namevalue(row,"DEDAMT2_"+no2)=ds12.namevalue(i,"DEDAMT");			//공제금액
				  no2++;
				}else if(ds12.namevalue(i,"DUDGB")=="22"){
				  ds_print.namevalue(row,"DUDGBNM2_"+no2)="연금저축";										//연금저축
				  ds_print.namevalue(row,"FINANM2_"+no2)=ds12.namevalue(i,"FINANM");				//금융기관상호
				  ds_print.namevalue(row,"ACCNO2_"+no2)=ds12.namevalue(i,"ACCNO");				//계좌번호
				  ds_print.namevalue(row,"PAYAMT2_"+no2)=ds12.namevalue(i,"PAYAMT");				//불입금액
				  ds_print.namevalue(row,"DEDAMT2_"+no2)=ds12.namevalue(i,"DEDAMT");			//공제금액
				  no2++;
				}
		}

		var no3 = 1;
		for(i=1;i<=ds12.countrow;i++){
			  if(ds12.namevalue(i,"DUDGB")=="31"){
				  ds_print.namevalue(row,"DUDGBNM3_"+no3)="청약저축";										//청약저축
				  ds_print.namevalue(row,"FINANM3_"+no3)=ds12.namevalue(i,"FINANM");				//금융기관상호
				  ds_print.namevalue(row,"ACCNO3_"+no3)=ds12.namevalue(i,"ACCNO");				//계좌번호
				  ds_print.namevalue(row,"PAYAMT3_"+no3)=ds12.namevalue(i,"PAYAMT");				//불입금액
				  ds_print.namevalue(row,"DEDAMT3_"+no3)=ds12.namevalue(i,"DEDAMT");			//공제금액
				  no3++;
				}else if(ds12.namevalue(i,"DUDGB")=="32"){
				  ds_print.namevalue(row,"DUDGBNM3_"+no3)="주택청약종합저축";							//주택청약종합저축
				  ds_print.namevalue(row,"FINANM3_"+no3)=ds12.namevalue(i,"FINANM");				//금융기관상호
				  ds_print.namevalue(row,"ACCNO3_"+no3)=ds12.namevalue(i,"ACCNO");				//계좌번호
				  ds_print.namevalue(row,"PAYAMT3_"+no3)=ds12.namevalue(i,"PAYAMT");				//불입금액
				  ds_print.namevalue(row,"DEDAMT3_"+no3)=ds12.namevalue(i,"DEDAMT");			//공제금액
				  no3++;
				}else if(ds12.namevalue(i,"DUDGB")=="33"){
				  ds_print.namevalue(row,"DUDGBNM3_"+no3)="장기주택마련저축";							//장기주택마련저축
				  ds_print.namevalue(row,"FINANM3_"+no3)=ds12.namevalue(i,"FINANM");				//금융기관상호
				  ds_print.namevalue(row,"ACCNO3_"+no3)=ds12.namevalue(i,"ACCNO");				//계좌번호
				  ds_print.namevalue(row,"PAYAMT3_"+no3)=ds12.namevalue(i,"PAYAMT");				//불입금액
				  ds_print.namevalue(row,"DEDAMT3_"+no3)=ds12.namevalue(i,"DEDAMT");			//공제금액
				  no3++;
				}else if(ds12.namevalue(i,"DUDGB")=="34"){
				  ds_print.namevalue(row,"DUDGBNM3_"+no3)="근로자주택마련저축";						//근로자주택마련저축
				  ds_print.namevalue(row,"FINANM3_"+no3)=ds12.namevalue(i,"FINANM");				//금융기관상호
				  ds_print.namevalue(row,"ACCNO3_"+no3)=ds12.namevalue(i,"ACCNO");				//계좌번호
				  ds_print.namevalue(row,"PAYAMT3_"+no3)=ds12.namevalue(i,"PAYAMT");				//불입금액
				  ds_print.namevalue(row,"DEDAMT3_"+no3)=ds12.namevalue(i,"DEDAMT");			//공제금액
				  no3++;
				}
		}

		var no4 = 1;
		for(i=1;i<=ds12.countrow;i++){
			  if(ds12.namevalue(i,"DUDGB")=="41"){																	//장기주식형저축공제
				  ds_print.namevalue(row,"FINANM4_"+no4)=ds12.namevalue(i,"FINANM");			//금융기관상호
				  ds_print.namevalue(row,"ACCNO4_"+no4)=ds12.namevalue(i,"ACCNO");			//계좌번호
				  ds_print.namevalue(row,"YEARLY4_"+no4)=ds12.namevalue(i,"YEARLY");			//납입연차
				  ds_print.namevalue(row,"PAYAMT4_"+no4)=ds12.namevalue(i,"PAYAMT");			//불입금액
				  ds_print.namevalue(row,"DEDAMT4_"+no4)=ds12.namevalue(i,"DEDAMT");			//공제금액
				  no4++;
				}
		}




		getObjectFirst("gcrp_print").preview();



	}











/******************************************************************************
	Description : 출력format
******************************************************************************/
	function ln_Rpt_SetDataHeader(){ //출력물 데이타 셋헤드 생성
		var ls_temp = "";
		if (ds_print.countrow<1){
			ds_print.SetDataHeader(ls_temp);
ls_temp1 = "EMPNO:STRING(7),YYYY:STRING(4),EMPNMK:STRING(20),EMPJUNO:STRING(13),"

+"EMPJUNO1:STRING(1),EMPJUNO2:STRING(1),EMPJUNO3:STRING(1),EMPJUNO4:STRING(1),EMPJUNO5:STRING(1),EMPJUNO6:STRING(1),EMPJUNO7:STRING(1),EMPJUNO8:STRING(1),EMPJUNO9:STRING(1),EMPJUNO10:STRING(1),EMPJUNO11:STRING(1),EMPJUNO12:STRING(1),EMPJUNO13:STRING(1),"

+"ADDRESS:STRING(120),TELNO:STRING(15),COMPANY:STRING(50),COMRESINO:STRING(10),CURDT3:STRING(8),CURDT2:STRING(8),CURDT:STRING(8),"     
+"REF11_S:DECIMAL(9.0),REF12_S:DECIMAL(9.0),REF13_S:DECIMAL(9.0),REF14_S:DECIMAL(9.0),REF15_S:DECIMAL(9.0),REF16_S:DECIMAL(9.0),REF17_S:DECIMAL(9.0),"
+ "REF21_S:DECIMAL(9.0),REF22_S:DECIMAL(9.0),REF23_S:DECIMAL(9.0),REF24_S:DECIMAL(9.0),REF26_S:DECIMAL(9.0),REF27_S:DECIMAL(9.0),"
+ "CNT:INT(2),GIVAMT1_1:DECIMAL(9.0),GIVAMT2_1:DECIMAL(9.0),"		 
+ "RELAT1_1:STRING(1),REF1_1:STRING(1),REF2_1:STRING(1),REF3_1:STRING(1),REF5_1:STRING(1),REF6_1:STRING(1),REF7_1:STRING(1),REF8_1:STRING(1),"
+ "REF11_1:DECIMAL(9.0),REF12_1:DECIMAL(9.0),REF13_1:DECIMAL(9.0),REF14_1:DECIMAL(9.0),REF15_1:DECIMAL(9.0),REF16_1:DECIMAL(9.0),REF17_1:DECIMAL(9.0),"
+ "REF21_1:DECIMAL(9.0),REF22_1:DECIMAL(9.0),REF23_1:DECIMAL(9.0),REF24_1:DECIMAL(9.0),REF26_1:DECIMAL(9.0),REF27_1:DECIMAL(9.0),"
+ "EMPNMK_2:STRING(20),EMPJUNO_2:STRING(13),"
+ "RELAT1_2:STRING(1),REF1_2:STRING(1),REF2_2:STRING(1),REF3_2:STRING(1),REF4_2:STRING(1),REF5_2:STRING(1),REF7_2:STRING(1),REF8_2:STRING(1),"
+ "REF11_2:DECIMAL(9.0),REF12_2:DECIMAL(9.0),REF13_2:DECIMAL(9.0),REF14_2:DECIMAL(9.0),REF15_2:DECIMAL(9.0),REF16_2:DECIMAL(9.0),REF17_2:DECIMAL(9.0),"
+ "REF21_2:DECIMAL(9.0),REF22_2:DECIMAL(9.0),REF23_2:DECIMAL(9.0),REF24_2:DECIMAL(9.0),REF26_2:DECIMAL(9.0),REF27_2:DECIMAL(9.0),"
+ "EMPNMK_3:STRING(20),EMPJUNO_3:STRING(13),"
+ "RELAT1_3:STRING(1),REF1_3:STRING(1),REF2_3:STRING(1),REF3_3:STRING(1),REF4_3:STRING(1),REF5_3:STRING(1),REF7_3:STRING(1),REF8_3:STRING(1),"
+ "REF11_3:DECIMAL(9.0),REF12_3:DECIMAL(9.0),REF13_3:DECIMAL(9.0),REF14_3:DECIMAL(9.0),REF15_3:DECIMAL(9.0),REF16_3:DECIMAL(9.0),REF17_3:DECIMAL(9.0),"
+ "REF21_3:DECIMAL(9.0),REF22_3:DECIMAL(9.0),REF23_3:DECIMAL(9.0),REF24_3:DECIMAL(9.0),REF26_3:DECIMAL(9.0),REF27_3:DECIMAL(9.0),"
+ "EMPNMK_4:STRING(20),EMPJUNO_4:STRING(13),"
+ "RELAT1_4:STRING(1),REF1_4:STRING(1),REF2_4:STRING(1),REF3_4:STRING(1),REF4_4:STRING(1),REF5_4:STRING(1),REF7_4:STRING(1),REF8_4:STRING(1),"
+ "REF11_4:DECIMAL(9.0),REF12_4:DECIMAL(9.0),REF13_4:DECIMAL(9.0),REF14_4:DECIMAL(9.0),REF15_4:DECIMAL(9.0),REF16_4:DECIMAL(9.0),REF17_4:DECIMAL(9.0),"
+ "REF21_4:DECIMAL(9.0),REF22_4:DECIMAL(9.0),REF23_4:DECIMAL(9.0),REF24_4:DECIMAL(9.0),REF26_4:DECIMAL(9.0),REF27_4:DECIMAL(9.0),"
+ "EMPNMK_5:STRING(20),EMPJUNO_5:STRING(13),"
+ "RELAT1_5:STRING(1),REF1_5:STRING(1),REF2_5:STRING(1),REF3_5:STRING(1),REF4_5:STRING(1),REF5_5:STRING(1),REF7_5:STRING(1),REF8_5:STRING(1),"
+ "REF11_5:DECIMAL(9.0),REF12_5:DECIMAL(9.0),REF13_5:DECIMAL(9.0),REF14_5:DECIMAL(9.0),REF15_5:DECIMAL(9.0),REF16_5:DECIMAL(9.0),REF17_5:DECIMAL(9.0),"
+ "REF21_5:DECIMAL(9.0),REF22_5:DECIMAL(9.0),REF23_5:DECIMAL(9.0),REF24_5:DECIMAL(9.0),REF26_5:DECIMAL(9.0),REF27_5:DECIMAL(9.0),"
+ "EMPNMK_6:STRING(20),EMPJUNO_6:STRING(13),"
+ "RELAT1_6:STRING(1),REF1_6:STRING(1),REF2_6:STRING(1),REF3_6:STRING(1),REF4_6:STRING(1),REF5_6:STRING(1),REF7_6:STRING(1),REF8_6:STRING(1),"
+ "REF11_6:DECIMAL(9.0),REF12_6:DECIMAL(9.0),REF13_6:DECIMAL(9.0),REF14_6:DECIMAL(9.0),REF15_6:DECIMAL(9.0),REF16_6:DECIMAL(9.0),REF17_6:DECIMAL(9.0),"
+ "REF21_6:DECIMAL(9.0),REF22_6:DECIMAL(9.0),REF23_6:DECIMAL(9.0),REF24_6:DECIMAL(9.0),REF26_6:DECIMAL(9.0),REF27_6:DECIMAL(9.0),"
+ "EMPNMK_7:STRING(20),EMPJUNO_7:STRING(13),"
+ "RELAT1_7:STRING(1),REF1_7:STRING(1),REF2_7:STRING(1),REF3_7:STRING(1),REF4_7:STRING(1),REF5_7:STRING(1),REF7_7:STRING(1),REF8_7:STRING(1),"
+ "REF11_7:DECIMAL(9.0),REF12_7:DECIMAL(9.0),REF13_7:DECIMAL(9.0),REF14_7:DECIMAL(9.0),REF15_7:DECIMAL(9.0),REF16_7:DECIMAL(9.0),REF17_7:DECIMAL(9.0),"
+ "REF21_7:DECIMAL(9.0),REF22_7:DECIMAL(9.0),REF23_7:DECIMAL(9.0),REF24_7:DECIMAL(9.0),REF26_7:DECIMAL(9.0),REF27_7:DECIMAL(9.0),"
+ "EMPNMK_8:STRING(20),EMPJUNO_8:STRING(13),"
+ "RELAT1_8:STRING(1),REF1_8:STRING(1),REF2_8:STRING(1),REF3_8:STRING(1),REF4_8:STRING(1),REF5_8:STRING(1),REF7_8:STRING(1),REF8_8:STRING(1),"
+ "REF11_8:DECIMAL(9.0),REF12_8:DECIMAL(9.0),REF13_8:DECIMAL(9.0),REF14_8:DECIMAL(9.0),REF15_8:DECIMAL(9.0),REF16_8:DECIMAL(9.0),REF17_8:DECIMAL(9.0),"
+ "REF21_8:DECIMAL(9.0),REF22_8:DECIMAL(9.0),REF23_8:DECIMAL(9.0),REF24_8:DECIMAL(9.0),REF26_8:DECIMAL(9.0),REF27_8:DECIMAL(9.0),"
+ "EMPNMK_9:STRING(20),EMPJUNO_9:STRING(13),"
+ "RELAT1_9:STRING(1),REF1_9:STRING(1),REF2_9:STRING(1),REF3_9:STRING(1),REF4_9:STRING(1),REF5_9:STRING(1),REF7_9:STRING(1),REF8_9:STRING(1),"
+ "REF11_9:DECIMAL(9.0),REF12_9:DECIMAL(9.0),REF13_9:DECIMAL(9.0),REF14_9:DECIMAL(9.0),REF15_9:DECIMAL(9.0),REF16_9:DECIMAL(9.0),REF17_9:DECIMAL(9.0),"
+ "REF21_9:DECIMAL(9.0),REF22_9:DECIMAL(9.0),REF23_9:DECIMAL(9.0),REF24_9:DECIMAL(9.0),REF26_9:DECIMAL(9.0),REF27_9:DECIMAL(9.0),"							 		 
+ "BPENAMT01:DECIMAL(9.0),CPENAMT01:DECIMAL(9.0),BPENAMT02:DECIMAL(9.0),CPENAMT02:DECIMAL(9.0),"
+ "BPENAMT03:DECIMAL(9.0),CPENAMT03:DECIMAL(9.0),PENSUM:DECIMAL(9.0),"
+ "BINSAMT01:DECIMAL(9.0),CINSAMT01:DECIMAL(9.0),BINSAMT02:DECIMAL(9.0),CINSAMT02:DECIMAL(9.0),"
+ "INSAMT03:DECIMAL(9.0),INSAMT04:DECIMAL(9.0),INSSUM:DECIMAL(9.0),"
+ "MEDAMT01:DECIMAL(9.0),MEDAMT02:DECIMAL(9.0),MEDSUM:DECIMAL(9.0),"
+ "EDUAMT01:DECIMAL(9.0),EDUCNT02:DECIMAL(9.0),EDUAMT02:DECIMAL(9.0),EDUCNT03:DECIMAL(9.0),EDUAMT03:DECIMAL(9.0),"
+ "EDUCNT04:DECIMAL(9.0),EDUAMT04:DECIMAL(9.0),EDUCNT05:DECIMAL(9.0),EDUAMT05:DECIMAL(9.0),EDUSUM:DECIMAL(9.0),"
+ "HOUAMT01:DECIMAL(9.0),HOUAMT02:DECIMAL(9.0),HOUSUM:DECIMAL(9.0),"
+ "CONAMT01:DECIMAL(9.0),CONAMT02:DECIMAL(9.0),CONAMT03:DECIMAL(9.0),CONAMT04:DECIMAL(9.0),"
+ "CONAMT05:DECIMAL(9.0),CONAMT06:DECIMAL(9.0),CONAMT07:DECIMAL(9.0),"
+ "PESAMT01:DECIMAL(9.0),PESAMT02:DECIMAL(9.0),"
+ "SAVAMT01:DECIMAL(9.0),SAVAMT02:DECIMAL(9.0),SAVAMT03:DECIMAL(9.0),SAVAMT04:DECIMAL(9.0),SAVSUM:DECIMAL(9.0),"
+ "CRDAMT01:DECIMAL(9.0),CRDAMT02:DECIMAL(9.0),CRDAMT03:DECIMAL(9.0),CRDAMT04:DECIMAL(9.0),CRDSUM:DECIMAL(9.0),"
+ "FNDAMT01:DECIMAL(9.0),FNDAMT02:DECIMAL(9.0),FNDAMT03:DECIMAL(9.0),FNDSUM:DECIMAL(9.0),"
+ "CONAMT99:DECIMAL(9.0),FORPAYAMT:DECIMAL(9.0),TAXAMT01:DECIMAL(9.0),TAXAMT02:DECIMAL(9.0),"
+ "TAXNATION:STRING(30),TAXAPPDT:STRING(8),TAXDTFR:STRING(8),TAXDTTO:STRING(8),"
+ "TAXPAYDT:STRING(8),FORPLACE:STRING(30),FORJOB:STRING(20),"
+ "WKNM:STRING(30),WKRESINO:STRING(10),BP10SUM:DECIMAL(9.0),BP41000:DECIMAL(9.0),"
+ "HYN1:STRING(4),HYN2:STRING(4),RESIGB1:STRING(4),RESIGB2:STRING(4),PEALLOWYN1:STRING(4),PEALLOWYN2:STRING(4),NATIONCD:STRING(4),RESINACD:STRING(4),"
+ "DUDGBNM1_1:STRING(30),FINANM1_1:STRING(50),ACCNO1_1:STRING(20),PAYAMT1_1:DECIMAL(9.0),DEDAMT1_1:DECIMAL(9.0),"
+ "DUDGBNM1_2:STRING(30),FINANM1_2:STRING(50),ACCNO1_2:STRING(20),PAYAMT1_2:DECIMAL(9.0),DEDAMT1_2:DECIMAL(9.0),"
+ "DUDGBNM1_3:STRING(30),FINANM1_3:STRING(50),ACCNO1_3:STRING(20),PAYAMT1_3:DECIMAL(9.0),DEDAMT1_3:DECIMAL(9.0),"
+ "DUDGBNM2_1:STRING(30),FINANM2_1:STRING(50),ACCNO2_1:STRING(20),PAYAMT2_1:DECIMAL(9.0),DEDAMT2_1:DECIMAL(9.0),"
+ "DUDGBNM2_2:STRING(30),FINANM2_2:STRING(50),ACCNO2_2:STRING(20),PAYAMT2_2:DECIMAL(9.0),DEDAMT2_2:DECIMAL(9.0),"
+ "DUDGBNM2_3:STRING(30),FINANM2_3:STRING(50),ACCNO2_3:STRING(20),PAYAMT2_3:DECIMAL(9.0),DEDAMT2_3:DECIMAL(9.0),"
+ "DUDGBNM2_4:STRING(30),FINANM2_4:STRING(50),ACCNO2_4:STRING(20),PAYAMT2_4:DECIMAL(9.0),DEDAMT2_4:DECIMAL(9.0),"
+ "DUDGBNM2_5:STRING(30),FINANM2_5:STRING(50),ACCNO2_5:STRING(20),PAYAMT2_5:DECIMAL(9.0),DEDAMT2_5:DECIMAL(9.0),"
+ "DUDGBNM3_1:STRING(30),FINANM3_1:STRING(50),ACCNO3_1:STRING(20),PAYAMT3_1:DECIMAL(9.0),DEDAMT3_1:DECIMAL(9.0),"
+ "DUDGBNM3_2:STRING(30),FINANM3_2:STRING(50),ACCNO3_2:STRING(20),PAYAMT3_2:DECIMAL(9.0),DEDAMT3_2:DECIMAL(9.0),"
+ "DUDGBNM3_3:STRING(30),FINANM3_3:STRING(50),ACCNO3_3:STRING(20),PAYAMT3_3:DECIMAL(9.0),DEDAMT3_3:DECIMAL(9.0),"
+ "DUDGBNM3_4:STRING(30),FINANM3_4:STRING(50),ACCNO3_4:STRING(20),PAYAMT3_4:DECIMAL(9.0),DEDAMT3_4:DECIMAL(9.0),"
+ "DUDGBNM3_5:STRING(30),FINANM3_5:STRING(50),ACCNO3_5:STRING(20),PAYAMT3_5:DECIMAL(9.0),DEDAMT3_5:DECIMAL(9.0),"	
	
+ "YEARLY4_1:STRING(1),FINANM4_1:STRING(50),ACCNO4_1:STRING(20),PAYAMT4_1:DECIMAL(9.0),DEDAMT4_1:DECIMAL(9.0),"
+ "YEARLY4_2:STRING(1),FINANM4_2:STRING(50),ACCNO4_2:STRING(20),PAYAMT4_2:DECIMAL(9.0),DEDAMT4_2:DECIMAL(9.0),"
+ "YEARLY4_3:STRING(1),FINANM4_3:STRING(50),ACCNO4_3:STRING(20),PAYAMT4_3:DECIMAL(9.0),DEDAMT4_3:DECIMAL(9.0),"
+ "YEARLY4_4:STRING(1),FINANM4_4:STRING(50),ACCNO4_4:STRING(20),PAYAMT4_4:DECIMAL(9.0),DEDAMT4_4:DECIMAL(9.0)";

			
			ds_print.SetDataHeader(ls_temp1);
		}
	}




/******************************************************************************
	Description :    주민번호 년월일 앞에 년도 붙이기
******************************************************************************/
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
	dest = "P030010_ofc1.jsp?eyy=<%=eyy%>&eno=<%=eno%>";
	window.open(dest,"ofc", "left=0,top=0,width=704,height=750,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openInsu(juno){
	dest = "P030010_insu1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"insu", "left=0,top=0,width=800,height=560,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openMedi(juno){
	dest = "P030010_medi1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"edu", "left=0,top=0,width=1000,height=600,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openEdu(juno){
	dest = "P030010_edu1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"ofc", "left=0,top=0,width=850,height=560,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openCard(juno){
	dest = "P030010_card1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"card", "left=0,top=0,width=840,height=660,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openGibu(){
	dest = "P030010_gibu1.jsp?eyy=<%=eyy%>&eno=<%=eno%>";
	window.open(dest,"gibu", "left=0,top=0,width=1004,height=600,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openHouse(){
	dest = "P030010_house1.jsp?eyy=<%=eyy%>&eno=<%=eno%>";
	window.open(dest,"house", "left=0,top=0,width=1004,height=600,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openPension(){
	dest = "P030010_pension1.jsp?eyy=<%=eyy%>&eno=<%=eno%>";
	window.open(dest,"pension", "left=0,top=0,width=1004,height=600,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

//참고사항(기본공제)
function openBasic(){
	dest = "P030010_basic_ref1.jsp?eyy=<%=eyy%>&eno=<%=eno%>";
	window.open(dest,"basic", "left=0,top=0,width=700,height=700,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

//사용자 메뉴얼
function ln_Manual(){
	window.open('./files/2010YearManual.hwp','manual','resizable=yes,width=800,height=600,scrollbars=no,status=no');
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


   // if(empno = 
		//prompt(this, ds3.namevalue(row, "RESINO1"));
	
		strResino = ds3.namevalue(row, "RESINO1");
        strGb = strResino.substring(6,7);
		strGb2 = strResino.substring(0,2);

		strResino = strResino.substring(0,6);
		strResino = ln_yyyymmdd(strGb,strGb2,strResino);
       
/*
		//직계존속은 50년 이상
		if( ds3.namevalue(row, "RELAT1") == "1" || ds3.namevalue(row, "RELAT1") == "2" ){	
				if(strGb2>="51"){ //2010년도 기준
					if(ds3.namevalue(row,"REF2")=="T"){	 

				alert("직계존속의 경우 1950년 이전 출생 기준입니다");

				ds3.namevalue(row,"RESINO1")="";
					}

				}
		}



		//형제자매는 89년 이하 또는 51년이상
		if( ds3.namevalue(row, "RELAT1") == "6"){	
				if(strGb2<="89"|| strGb2>="51"){ //2010년도 기준
				alert("형제자매의 경우 1950년 이전 또는 1990년 이후 출생 기준입니다");
				ds3.namevalue(row,"RESINO1")="";
				}
		}
*/
		//경로우대
		if(strResino<="19401231"){ //2010년도 기준
			ds3.namevalue(row,"REF5")="T";
		}else{
            ds3.namevalue(row,"REF5")="F";
		}

		//자녀양육비 (직계비속,입양자,직계비속외, 위탁아동이면서, 20040101 이후
		if((ds3.namevalue(row, "RELAT1")=="4"||ds3.namevalue(row, "RELAT1")=="5"||ds3.namevalue(row, "RELAT1")=="7")&& strResino>="20040101"){
			ds3.namevalue(row,"REF4")="T";
		}else{
			ds3.namevalue(row,"REF4")="F";
	    }

        //출산 입양
		if((ds3.namevalue(row, "RELAT1")=="4"||ds3.namevalue(row, "RELAT1")=="5")&& strResino>="20100101"){
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
	//직계비속 또는 입양자,위탁아동이며 주민번호가 2004.1.1 이후 출생만 가능
    if((Colid=="REF4")){    
		if(ds3.namevalue(row, "RESINO1")!=""){
			strResino = ds3.namevalue(row, "RESINO1");
			strGb = strResino.substring(6,7);
			strGb2 = strResino.substring(0,2);
			strResino = strResino.substring(0,6);
			strResino = ln_yyyymmdd(strGb,strGb2,strResino);
            
			if(ds3.namevalue(row,"REF4")=="F") return;

			 //자녀양육비 
			if((ds3.namevalue(row, "RELAT1")=="4"||ds3.namevalue(row, "RELAT1")=="5"||ds3.namevalue(row, "RELAT1")=="7")&&strResino>="20040101"){ //2010년도 기준
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
			if(strResino<="19401231"){ //2010년도 기준
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

        if(ds3.namevalue(row,"REF7")=="F") return;

       //기본공제 & 직계비속 & 주민번호가 2010년 이상인 경우만 가능 
	    if(ds3.namevalue(row,"REF2")=="T"&&ds3.namevalue(row,"RELAT1")=="4"){
			if(strResino>="19900101"){ //2010년도 기준
			
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
       //기본공제 & 직계비속 & 주민번호가 2010년 이상인 경우만 가능 
	   if(ds3.namevalue(row,"REF2")=="T"&&(ds3.namevalue(row,"RELAT1")=="4"||ds3.namevalue(row,"RELAT1")=="5")&&strResino=="10"){
		
	   }else{
		   ds3.namevalue(row,"REF8")="F";	
	   }
	}


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
		}
	}

    
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
 
	
	if(v_job=="I") {	//저장


		if(gs_temp2 != "2"){
	    gf_msg();
		}
        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
		fnSelect("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (개인소득 + 잡다)
		fnSelect3("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (인적공제)

    }  else if(v_job == "H" || v_job=="S") {
        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
    }
</script>



<script language="javascript" for="tr2" event="onsuccess()">
    if(v_job=="I") {	//저장
	    gf_msg();
        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
		fnSelect3("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (인적공제)
    }  else if(v_job == "H" || v_job=="S") {
        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
    }
</script>


<script language="javascript" for="tr3" event="onsuccess()">
    if(v_job=="I") {	//저장
	    gf_msg();
        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
		fnSelect("<%=eyy%>", "<%=eno%>");	//기본정보 조회 (개인소득 + 잡다)
    }  else if(v_job == "H" || v_job=="S") {
        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
    }
</script>



<script language=javascript for=gcra_houseyn event="OnSelChange()">

	if(gcra_houcnt.codevalue == "0") {	//무주택
	gcra_houarea.codevalue = "0";
	gcra_houarea.enable = "false";
	gcra_houarea.Reset();
	gcra_houval.codevalue = "0";
	gcra_houval.enable = "false";
	gcra_houval.Reset();
	gcra_houloan.codevalue = "0";
	gcra_houloan.enable = "false";
	gcra_houloan.Reset();
		if(gcra_houseyn.codevalue == "1") {		//무주택 세대주
		HOUAMT01.enable = "true";
		HOUAMT02.enable = "true";
		}else if(gcra_houseyn.codevalue == "2") {		//무주택 세대원
		HOUAMT01.text = "0";
		HOUAMT01.enable = "false";
		HOUAMT02.text = "0";
		HOUAMT02.enable = "false";
		}
	HOUAMT03.text = "0";
	HOUAMT03.enable = "false";
	HOUAMT04.text = "0";
	HOUAMT04.enable = "false";
	HOUAMT05.text = "0";
	HOUAMT05.enable = "false";
	}
	else if(gcra_houcnt.codevalue == "1") {			//1주택 
	gcra_houarea.codevalue = "0";
	gcra_houarea.enable = "true";
	gcra_houarea.Reset();
	gcra_houval.codevalue = "0";
	gcra_houval.enable = "true";
	gcra_houval.Reset();
	gcra_houloan.codevalue = "0";
	gcra_houloan.enable = "true";
	gcra_houloan.Reset();
	HOUAMT01.text = "0";
	HOUAMT01.enable = "false";
	HOUAMT02.text = "0";
	HOUAMT02.enable = "false";
		if(gcra_houseyn.codevalue == "1") {			//세대주
		HOUAMT03.enable = "true";
		HOUAMT04.enable = "true";
		HOUAMT05.enable = "true";
		}
		
	}
	else if(gcra_houcnt.codevalue == "2") {			//2주택 
	gcra_houarea.codevalue = "0";
	gcra_houarea.enable = "true";
	gcra_houarea.Reset();
	gcra_houval.codevalue = "0";
	gcra_houval.enable = "true";
	gcra_houval.Reset();
	gcra_houloan.codevalue = "0";
	gcra_houloan.enable = "true";
	gcra_houloan.Reset();
	HOUAMT01.text = "0";
	HOUAMT01.enable = "false";
	HOUAMT02.text = "0";
	HOUAMT02.enable = "false";
	HOUAMT03.text = "0";
	HOUAMT03.enable = "false";
	HOUAMT04.text = "0";
	HOUAMT04.enable = "false";
	HOUAMT05.text = "0";
	HOUAMT05.enable = "false";
	}

</script>


<script language=javascript for=gcra_houcnt event="OnSelChange()">

	if(gcra_houcnt.codevalue == "0") {	//무주택
	gcra_houarea.codevalue = "0";
	gcra_houarea.enable = "false";
	gcra_houarea.Reset();
	gcra_houval.codevalue = "0";
	gcra_houval.enable = "false";
	gcra_houval.Reset();
	gcra_houloan.codevalue = "0";
	gcra_houloan.enable = "false";
	gcra_houloan.Reset();
		if(gcra_houseyn.codevalue == "1") {		//무주택 세대주
		HOUAMT01.enable = "true";
		HOUAMT02.enable = "true";
		}else if(gcra_houseyn.codevalue == "2") {		//무주택 세대원
		HOUAMT01.text = "0";
		HOUAMT01.enable = "false";
		HOUAMT02.text = "0";
		HOUAMT02.enable = "false";
		}
	HOUAMT03.text = "0";
	HOUAMT03.enable = "false";
	HOUAMT04.text = "0";
	HOUAMT04.enable = "false";
	HOUAMT05.text = "0";
	HOUAMT05.enable = "false";
	}
	else if(gcra_houcnt.codevalue == "1") {			//1주택 
	gcra_houarea.codevalue = "0";
	gcra_houarea.enable = "true";
	gcra_houarea.Reset();
	gcra_houval.codevalue = "0";
	gcra_houval.enable = "true";
	gcra_houval.Reset();
	gcra_houloan.codevalue = "0";
	gcra_houloan.enable = "true";
	gcra_houloan.Reset();
	HOUAMT01.text = "0";
	HOUAMT01.enable = "false";
	HOUAMT02.text = "0";
	HOUAMT02.enable = "false";
		if(gcra_houseyn.codevalue == "1") {			//세대주
		HOUAMT03.enable = "true";
		HOUAMT04.enable = "true";
		HOUAMT05.enable = "true";
		}
		
	}
	else if(gcra_houcnt.codevalue == "2") {			//2주택 
	gcra_houarea.codevalue = "0";
	gcra_houarea.enable = "true";
	gcra_houarea.Reset();
	gcra_houval.codevalue = "0";
	gcra_houval.enable = "true";
	gcra_houval.Reset();
	gcra_houloan.codevalue = "0";
	gcra_houloan.enable = "true";
	gcra_houloan.Reset();
	HOUAMT01.text = "0";
	HOUAMT01.enable = "false";
	HOUAMT02.text = "0";
	HOUAMT02.enable = "false";
	HOUAMT03.text = "0";
	HOUAMT03.enable = "false";
	HOUAMT04.text = "0";
	HOUAMT04.enable = "false";
	HOUAMT05.text = "0";
	HOUAMT05.enable = "false";
	}


</script>


<script language=javascript for=gcra_houval event="OnSelChange()">

	if(gcra_houval.codevalue == "1") {	//3억원 이하
	HOUAMT03.enable = "true";
	HOUAMT04.enable = "true";
	HOUAMT05.enable = "true";
	}else if(gcra_houval.codevalue == "2") {	//3억원 초과
	HOUAMT03.text = "0";
	HOUAMT03.enable = "false";
	HOUAMT04.text = "0";
	HOUAMT04.enable = "false";
	HOUAMT05.text = "0";
	HOUAMT05.enable = "false";
	}

</script>


<script language=javascript for=gcra_houarea event="OnSelChange()">

	if(gcra_houarea.codevalue == "1") {	//85㎡ 이하
	HOUAMT03.enable = "true";
	HOUAMT04.enable = "true";
	HOUAMT05.enable = "true";
	}else if(gcra_houarea.codevalue == "2") {	//85㎡ 초과
	HOUAMT03.text = "0";
	HOUAMT03.enable = "false";
	HOUAMT04.text = "0";
	HOUAMT04.enable = "false";
	HOUAMT05.text = "0";
	HOUAMT05.enable = "false";
	}

</script>





<script language=javascript for=ds3 event="OnLoadCompleted(row)">

	if(row<1 && gs_temp == "1") {

		gs_temp2 = "2";

		ds3.addrow();

		ds3.namevalue(ds3.rowposition,"RELAT1") = "0";
		ds3.namevalue(ds3.rowposition,"APPDT") = ds1.namevalue(ds1.rowposition,"APPDT") + "12";
		ds3.namevalue(ds3.rowposition,"EMPNO") = ds1.namevalue(ds1.rowposition,"EMPNO");
		ds3.namevalue(ds3.rowposition,"FAMNM1") = ds1.namevalue(ds1.rowposition,"EMPNMK");
		ds3.namevalue(ds3.rowposition,"RESINO1") = ds1.namevalue(ds1.rowposition,"EMPJUNO");
		ds3.namevalue(ds3.rowposition,"REF2") = "T";
		
		

		fnApply3();
		gs_temp = "2"; 
		

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


<script language=javascript for=ds8 event="OnLoadCompleted(row)">
	if(row==0) return;
    var intSAVAMT01=ds8.namevalue(row,"SAVAMT01");
	var intSAVAMT02=ds8.namevalue(row,"SAVAMT02");
	var intSAVAMT03=ds8.namevalue(row,"SAVAMT03");
	var intSAVAMT04=ds8.namevalue(row,"SAVAMT04");
    var intSAVSUM = parseInt(intSAVAMT01) + parseInt(intSAVAMT02)+ parseInt(intSAVAMT03) + parseInt(intSAVAMT04);
	getObjectFirst("SAVSUM").text= intSAVSUM;
</script>


<script language=javascript for=ds11 event="OnLoadCompleted(row)">
	if(row==0) return;
    var intPESAMT01=ds11.namevalue(row,"PESAMT01");
	var intPESAMT02=ds11.namevalue(row,"PESAMT02");
	var intCPENAMT03=ds11.namevalue(row,"CPENAMT03");	
    var intFNDAMT01=ds11.namevalue(row,"FNDAMT01");
	var intFNDAMT02=ds11.namevalue(row,"FNDAMT02");
	var intFNDAMT03=ds11.namevalue(row,"FNDAMT03");
    var intFNDSUM = parseInt(intFNDAMT01) + parseInt(intFNDAMT02)+ parseInt(intFNDAMT03);
	getObjectFirst("FNDSUM").text= intFNDSUM;
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
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
<object id=ds8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>

<object id=ds11 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>

<object id=ds12 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>

<object id=ds_print classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
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

<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object id=ds_result3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 메세지 -->
    <param name="SyncLoad"  value="false">
</object>

<object  id="tr4" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object id=ds_result4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 메세지 -->
    <param name="SyncLoad"  value="false">
</object>
<%=HDConstant.COMMENT_END%>













<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>





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
	<C> Name='년월'						ID=APPDT   				Width=60	</C>    
	<C> Name='사번'						ID=EMPNO  				Width=60	</C>    

	<C> Name='세대주'					ID=HOUSEYN 			Width=60	</C>    

	<C> Name='주택임차차입금'		ID=HOUAMT01 			Width=60	</C>    
	<C> Name='월세액'					ID=HOUAMT02 			Width=60	</C>    
	<C> Name='주택저당차임14'		ID=HOUAMT03 			Width=60	</C>    
	<C> Name='주택저당차임15'		ID=HOUAMT04 			Width=60	</C>
	<C> Name='주택저당차임30'		ID=HOUAMT05 			Width=60	</C> 	
	<C> Name='주택자금계'				ID=HOUSUM 	     	Width=60	</C>    

	<C> Name='개인연금'				ID=PESAMT01    		Width=60	</C>    
	<C> Name='연금저축'				ID=PESAMT02 			Width=60	</C>
	<C> Name='퇴직연금'				ID=CPENAMT03 			Width=60	</C>
	<C> Name='납입1년차불입액'		ID=FNDAMT01 			Width=60	</C>    
	<C> Name='납입2년차불입액'		ID=FNDAMT02 			Width=60	</C>    
	<C> Name='납입3년차불입액'		ID=FNDAMT03 			Width=60	</C>    
	<C> Name='정치자금'				ID=CONAMT99 			Width=60	</C>

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
	<C> Name='사업자등'			ID=BF_RESINO				Width=60	</C> 
	<C> Name='과세급여'			ID=BF_TAX_PAY			Width=60	</C>    
	<C> Name='과세상여'			ID=BF_TAX_BNS			Width=60	</C> 
	<C> Name='과세소득'			ID=BF_TAX_SUM 			Width=60	</C>    
	<C> Name='비과세소'			ID=BF_NTAX_SUM 		Width=60	</C> 
	<C> Name='결정소득'			ID=BF_DEDUCT1   		Width=60	</C>    
	<C> Name='결정주민'			ID=BF_DEDUCT2			Width=60	</C> 
	<C> Name='국민연금'			ID=BF_DEDUCT3			Width=60	</C>    
	<C> Name='건강보험'			ID=BF_DEDUCT4			Width=60	</C> 
	<C> Name='고용보험'			ID=BF_DEDUCT5			Width=60	</C>
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
	<C> Name='100%한도 그밖'		ID=GIVAMT_10B	Width=60	</C>    
	<C> Name='50%한도 국세청'	ID=GIVAMT_30A	Width=60	</C>    
	<C> Name='50%한도 그밖'		ID=GIVAMT_30B	Width=60	</C> 
	<C> Name='30%한도 국세청'	ID=GIVAMT_42A	Width=60	</C>    
	<C> Name='30%한도 그밖'		ID=GIVAMT_42B	Width=60	</C> 
	<C> Name='10%한도 국세청'	ID=GIVAMT_40A	Width=60	</C>    
	<C> Name='10%한도 그밖'		ID=GIVAMT_40B 	Width=60	</C>    
	">
</OBJECT>	


<OBJECT id=gr8  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 636px; HEIGHT: 60px;border:1 solid #777777;display:NONE;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds8">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<C> Name='청약저축'					ID=SAVAMT01 	Width=60	</C>    
	<C> Name='근로자주택마련저축'		ID=SAVAMT02	Width=60	</C>    
	<C> Name='장기주택마련저축'		ID=SAVAMT03	Width=60	</C>    
	<C> Name='주택청약종합저축'		ID=SAVAMT04	Width=60	</C> 
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
			 <img src="./imgs/btn_menu9.gif"	style="cursor:hand;position:relative;left:-5px" onmouseover="this.src='./imgs/btn_menu9.gif'"	onmouseout="this.src='./imgs/btn_menu9.gif'"		onclick="ln_Manual()">
		  </TD>
		</TR>
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
          <TD bgColor=#aad2ff colSpan=6><%=eyy%>년 원천징수</TD>
</TR>
        <TR align=CENTER bgColor=#e8f3ff>
          <TD>과세급여</TD>
          <TD>과세상여</TD>
          <TD>과세인정상여</TD>
          <TD>과세소득 계</TD>
          <TD>비과세소득 계</TD>
          <TD>소득세</TD>
          <TD>지방소득세</TD>
          <TD>국민연금</TD>
          <TD>건강보험</TD>
          <TD>고용보험</TD>

		</TR>
        <TR align=CENTER>
          <TD bgColor=#e8f3ff>금액</TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="CP11000" style= "position:relative;left:0px;top:2px;width:75px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
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
			<object id="CP12000" style= "position:relative;left:0px;top:2px;width:75px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
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
			<object id="CP13000" style= "position:relative;left:0px;top:2px;width:75px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
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
			<object id="TAX_SUM" style= "position:relative;left:0px;top:2px;width:75px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">				
					<param name=ReadOnly  	value="true">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="CNTAXSUM" style= "position:relative;left:0px;top:2px;width:75px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
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
			<object id="CP41000" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
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
			<object id="CP42000" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
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
			<object id="CPENAMT01" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
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
			<object id="CINSAMT01" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
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
			<object id="CINSAMT02" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
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
					<param name=FORMAT 			value="000-00-00000">					
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
			
            <BR>&nbsp;&nbsp;&nbsp;※&nbsp;관계 : 
            위탁아동이 부양가족에 추가되었습니다. 동거입양자는 직계비속자녀에 포함 됩니다.
            </FONT>
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
                  만60세 이상 남성,여성 직계존속·형제 - 1950.12.31 이전 
                  生&nbsp;&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;&nbsp;
                  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  만20세 이하 직계비속·형제자매 - 1990.01.01 이후生 </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px"><FONT color=#3366ff>③ 자녀양육 : 
                  만6세 이하 직계비속 - 2004.01.01 이후生 </FONT></TD></TR>
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

<!--
<br><br><br>
-->
<table width=1003>
	<tr>
		<td>&nbsp;</td>


<BR><BR><BR>

          <TD ><B>


		  <FONT color=red>&nbsp;※ 인적공제 가족이 작년과 동일하더라도 행추가하여 각각 입력하셔야 합니다.<br>
		  <FONT color=blue>
		  &nbsp;&nbsp;(인적공제  항목이 전년과 동일한 경우 주민등록등본 미제출)<br></FONT>
		  </FONT>
</B>
		  <comment id="__NSID__">
			<object id=gcra_peallowyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:220">
				<param name=Cols	value="2">
				<param name=Format	value="1^작년과 동일,2^작년과 다름">
			</object>
			<%=HDConstant.COMMENT_END%> 		  
		  
		  



		  </TD> 



		<td align="right"><br>
		<nobr>
			<!-- <img src="../Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()"> -->
			<img src="./imgs/btn_ref2.gif"	style="cursor:hand"	align=absmiddle onClick="openBasic()">
			<img src="../Sales/images/plus.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRow3()">
			<img src="../Sales/images/minus.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRow3()">
			<img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply2()">
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
		 Data='0:본인,1:직계존속,2:배우자직계존속,3:배우자,4:직계비속자녀,5:직계비속자녀외,6:형제자매,7:수급자,8:위탁아동'</C>
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





<!--
		<TR>
		  <td align="right"><br>
			<nobr>
				<img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply()">
				<img src="../Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
			</nobr>&nbsp;</td>
		</TR>
-->

      </TABLE>
            


      <TABLE cellSpacing=1 cellPadding=3 width=1003 align=center bgColor=#666666  border=2>
        
       <TR bgColor=#ffedd2>
          <TD align=CENTER rowSpan=21>특<BR>별<BR><BR>공<BR>제</TD>
          <TD align=CENTER width=50>항 목</TD>
          <TD align=CENTER colSpan=2>지 출 내 역</TD>
          <TD align=CENTER width=130>지 출 구 분</TD>
          <TD align=CENTER width=90>지 출 금 액</TD>
          <TD align=CENTER>참 고 사 항</TD>
	   </TR>

        <TR>
		  <TD align=CENTER bgColor=#fff8ee rowSpan=11>주택자금
		  </TD> 

          <TD align=left  width=110 bgColor=#ffffff colSpan=2>&nbsp;세대주
          </TD>
          <TD align=CENTER bgColor=#ffffff colSpan=2>

		  <comment id="__NSID__">
			<object id=gcra_houseyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:220">
				<param name=Cols	value="2">
				<param name=Format	value="1^세대주,2^세대원">
			</object>
			<%=HDConstant.COMMENT_END%> 

			</TD>
          <TD class=tit_f10 bgColor=#ffffff>&nbsp;* 연말현재(2010.12.31)
		  </TD>
		</TR>

        <TR>
          <TD align=left  width=150 bgColor=#ffffff colSpan=2>&nbsp;연중 소유한 주택의 수
          </TD>
          <TD align=CENTER bgColor=#ffffff colSpan=2>
		  <comment id="__NSID__">
			<object id=gcra_houcnt classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
					style="height:24; width:250">
				<param name=Cols	value="3">
				<param name=Format	value="0^무주택,1^1주택,2^2주택이상">
			</object>
			<%=HDConstant.COMMENT_END%> </TD>
          <TD class=tit_f10 bgColor=#ffffff>&nbsp;* 세대원의 소유주택까지 포함하여 산정
		  </TD>
		</TR>

        <TR>
          <TD align=left  width=110 bgColor=#ffffff colSpan=2>&nbsp;전용면적 85㎡ 이하
          </TD>
          <TD align=CENTER bgColor=#ffffff colSpan=2>
		  <comment id="__NSID__">
			<object id=gcra_houarea classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
					style="height:24; width:220">
				<param name=Cols	value="2">
				<param name=Format	value="1^85㎡ 이하,2^85㎡ 초과">
			</object>
			<%=HDConstant.COMMENT_END%> </TD>
          <TD class=tit_f10 bgColor=#ffffff>&nbsp;* 소유주택 또는 임차주택이 국민주택규모(전용면적 85㎡ 이하) 여부
		  </TD>
		</TR>

        <TR>
          <TD align=left  width=200 bgColor=#ffffff colSpan=2>&nbsp;기준시가 3억원 이하
          </TD>
          <TD align=CENTER bgColor=#ffffff colSpan=2>
		  <comment id="__NSID__">
			<object id=gcra_houval classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
					style="height:24; width:220">
				<param name=Cols	value="2">
				<param name=Format	value="1^3억원 이하,2^3억원 초과">
			</object>
			<%=HDConstant.COMMENT_END%> </TD>
          <TD class=tit_f10 bgColor=#ffffff>&nbsp;* 저축가입당시 또는 주택취득당시 주택의 기준시가
		  </TD>
		</TR>

        <TR>
          <TD align=left  width=200 bgColor=#ffffff colSpan=2>&nbsp;저당차입금 3개월 이내 차입
          </TD>
          <TD align=CENTER bgColor=#ffffff colSpan=2>
		  <comment id="__NSID__">
			<object id=gcra_houloan classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
					style="height:24; width:220">
				<param name=Cols	value="2">
				<param name=Format	value="1^3개월 이내,2^3개월 이후">
			</object>
			<%=HDConstant.COMMENT_END%> </TD>
          <TD class=tit_f10 bgColor=#ffffff>&nbsp;* 저당차입금(모기지론)은 등기접수일로부터 3개월 이내 차입여부
		  </TD>
		</TR>


        <TR>
          <TD align=left  width=110 bgColor=#ffffff rowSpan=2>&nbsp;주택임차<BR>&nbsp;자금공제
          </TD>
          <TD align=left  width=125 bgColor=#ffffff >&nbsp;주택임차<BR>&nbsp;차입금</TD>
          <TD align=CENTER bgColor=#ffffff>근로자 본인명의의<BR>총 원리금상환액<BR>(40%공제  미적용금액)</TD>
          <TD align=CENTER bgColor=#ffffff>
		  <comment id="__NSID__">
			<object id="HOUAMT01" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		  value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																			
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%> </TD>
          <TD class=tit_f10 bgColor=#ffffff>
		     &nbsp;* 연말현재 무주택자로 국민주택규모이하의 주택을 임차하기 위해 <BR>&nbsp;&nbsp;&nbsp;&nbsp;차입한 경우 총 원리금상환 기재 
		  </TD>
		</TR>
        <TR>
          <TD align=left  width=125 bgColor=#ffffff >&nbsp;월세액</TD>
          <TD align=CENTER bgColor=#ffffff>해당연도월세액<BR>(40%공제 
            미적용금액)</TD>
          <TD align=CENTER bgColor=#ffffff>
		  <%=HDConstant.COMMENT_START%>
			<object id="HOUAMT02" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		  value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																			
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%> </TD>
          <TD class=tit_f10 bgColor=#ffffff>
		     &nbsp;* 과세기간말현재 무주택자 세대주
		  </TD>
  	    </TR>   
        <TR>
          <TD align=left  width=110 bgColor=#ffffff rowSpan=3>&nbsp;장기주택<BR>&nbsp;저당차입금 
          </TD>
          <TD align=left  width=125 bgColor=#ffffff>&nbsp;① 상환기간 14년 미만 </TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=3>근로자 본인명의의<BR>&nbsp;총 
          이자상환액</TD>
          <TD align=CENTER bgColor=#ffffff>
		  <%=HDConstant.COMMENT_START%>
			<object id="HOUAMT03" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		  value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																			
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%> </TD>
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
          <TD align=CENTER bgColor=#ffffff>		  
		  <%=HDConstant.COMMENT_START%>
			<object id="HOUAMT04" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		  value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																			
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%> </TD></TR>
        <TR>
          <TD align=left bgColor=#ffffff>&nbsp;③ 상환기간 30년 이상 </TD>
          <TD align=CENTER bgColor=#ffffff>			
		  <%=HDConstant.COMMENT_START%>
			<object id="HOUAMT05" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		  value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																			
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%> </TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee colSpan=3>주택자금 계</TD>
          <TD align=CENTER bgColor=#fff8ee>
			<%=HDConstant.COMMENT_START%>
			<object id="HOUSUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
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
          <TD align=CENTER bgColor=#fff8ee rowSpan=9  width="60" >기부금
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
           <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>→ 10만원 이하 금액은 세액공제 + 10만원 초과 금액은 소득공제 </FONT>

		                              
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
		   <br>&nbsp;* 지정기부금(20%한도)
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


        <TR>
		  <TD align=CENTER bgColor=#ffedd2 rowSpan=14>기<BR>타<BR>소<BR>득<BR>공<BR>제</TD>
          <TD align=CENTER bgColor=#fff8ee rowSpan=9>연금
			<img src="./imgs/btn_write2.gif" style="cursor:hand" align=absmiddle onClick="openPension()"></TD>
          <TD align=CENTER bgColor=#fff8ee rowSpan=2>개인연금</TD>
          <TD align=left bgColor=#ffffff colSpan=1 rowSpan=2>&nbsp;2000년 이전<BR>&nbsp;가입한 저축</TD>
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
			<object id="PESAMT01" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		  value="0">
					<param name=Alignment 	  value=2 >
					<param name=Numeric		  value="true">
					<param name=Border	 	  value="false">		
					<param name=InheritColor  value="true">
					<param name=ReadOnly  	  value="true">
					<param name=SelectAll  	  value="true">
			</object>
			<%=HDConstant.COMMENT_END%>
           </TD>
		</TR>


        <TR>
          <TD align=CENTER bgColor=#fff8ee rowSpan=2>연금저축</TD>
          <TD align=left bgColor=#ffffff colSpan=1 rowSpan=2>&nbsp;2001년 이후<BR> &nbsp;가입한 저축</TD>
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
			<object id="PESAMT02" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">
					<param name=ReadOnly  	value="true">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%>
		  </TD>
		 </TR>




       <TR>
          <TD align=CENTER bgColor=#fff8ee >퇴직연금</TD>
          <TD align=left bgColor=#ffffff colSpan=2 rowSpan=1>&nbsp;퇴직연금 보험료공제</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id="CPENAMT03" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">
					<param name=ReadOnly  	value="true">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%>
		  </TD>
          <TD align=left bgColor=#ffffff colSpan=1 rowSpan=1>&nbsp;</TD>

		 </TR>





		 <TR>
          <TD align=center bgColor=#fff8ee rowSpan=4>&nbsp;펀드</TD>
          <TD align=left colspan=1 rowSpan=3 bgColor=#ffffff>&nbsp; 장기주식형저축소득공제</TD>
          <TD align=left bgColor=#ffffff >&nbsp;① 납입 1년차 불입액</TD>
          <TD align=CENTER bgColor=#ffffff ><%=HDConstant.COMMENT_START%>
			<object id="FNDAMT01" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">	
					<param name=ReadOnly  	value="true">
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
			<object id="FNDAMT02" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
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
          <TD align=left bgColor=#fff8ee colspan=2>&nbsp;장기주식형저축 소득공제 계 </TD>
		  <TD align=CENTER bgColor=#fff8ee ><%=HDConstant.COMMENT_START%>
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
          <TD align=center bgColor=#fff8ee rowSpan=5>&nbsp;주택마련<BR>저축
			<img src="./imgs/btn_write2.gif" style="cursor:hand" align=absmiddle onClick="openHouse()"></TD>
          <TD align=left colspan=3 bgColor=#ffffff>&nbsp;① 청약저축</TD>
          <TD align=CENTER bgColor=#ffffff >
		  <%=HDConstant.COMMENT_START%>
			<object id="SAVAMT01" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">	
					<param name=ReadOnly  	value="true">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff >&nbsp;* 근로자 본인이 세대주이며, 무주택자 <BR></FONT>
		  </TD>
		</TR>
        <TR>
          <TD align=left colspan=3 bgColor=#ffffff>&nbsp;② 근로자주택마련저축</TD>
          <TD align=CENTER bgColor=#ffffff >
		  <%=HDConstant.COMMENT_START%>
			<object id="SAVAMT02" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">	
					<param name=ReadOnly  	value="true">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
		  <TD bgColor=#ffffff rowspan=3>&nbsp;* 근로자 본인이 세대주이며, 국민주택규모 1채 이하 소유자
            <BR>&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>→ 2005.12.31 이전 가입자 : 국민주택규모
            <BR>&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>→ 2006.1.1 이후 가입자 : 국민주택규모+저축가입시점 기준시가 3억이하<BR></FONT>
		  </TD>
		</TR>

        <TR>
          <TD align=left colspan=3 bgColor=#ffffff>&nbsp;③ 장기주택마련저축</TD>
          <TD align=CENTER bgColor=#ffffff >
		  <%=HDConstant.COMMENT_START%>
			<object id="SAVAMT04" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
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
          <TD align=left colspan=3 bgColor=#ffffff>&nbsp;④ 주택청약종합저축</TD>
		  <TD align=CENTER bgColor=#ffffff >
		  <%=HDConstant.COMMENT_START%>
			<object id="SAVAMT03" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
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
          <TD align=left bgColor=#fff8ee colspan=3>&nbsp;주택마련저축 소득공제 계 </TD>
		  <TD align=CENTER bgColor=#fff8ee ><%=HDConstant.COMMENT_START%>
			<object id="SAVSUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
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


<!--
		<TR>
		  <TD align=CENTER bgColor=#ffedd2 >연<BR>금</TD>
		  <TD align=center bgColor=#fff8ee >&nbsp;연금보험</TD>
          <TD align=left bgColor=#ffffff colspan=3>&nbsp;퇴직연금 보험료공제</TD>
		  <TD align=CENTER bgColor=#ffffff ><%=HDConstant.COMMENT_START%>
			<object id="CPENAMT03" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
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

-->
        <TR>
          <TD align=CENTER bgColor=#ffedd2 rowSpan=2>세<BR>액<BR>공<BR>제</TD>
          <TD align=CENTER bgColor=#fff8ee >정치자금</TD>
          <TD align=left bgColor=#ffffff COLSPAN=2>&nbsp;정치자금 기부금</TD>
          <TD align=CENTER bgColor=#ffffff >근로자 본인 명의의<BR>총 기부금액</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id="CONAMT99" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
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
			&nbsp;&nbsp;&nbsp;지역에 국민주택규모 이하의 미분양 주택을 취득하기 위해 국민주택기금<BR>
			&nbsp;&nbsp;&nbsp;또는 주택은행으로부터 1995.11.1 이후 차입한 차입금에 대한 총 이자<BR>
			&nbsp;&nbsp;&nbsp;상환액 기재
		  </TD>
		</TR>
	  </TABLE>


		<TR>
		  <td align="right"><br>
			<nobr>


		       <B><FONT color=red> ※반드시 저장버튼을 눌러 주시기 바랍니다.</FONT></B>     

				<img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply()">

			</nobr>&nbsp;</td>
		</TR>




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
		<C>Col=EMPNO  	  		Ctrl=EMPNO  	   		Param=text</C>
		<C>Col=DEPTCD  	  	Ctrl=DEPTCD  	   		Param=text</C>
		<C>Col=PAYGRD  	  	Ctrl=PAYGRD  	   		Param=text</C>
		<C>Col=JOINDATE   	Ctrl=JOINDATE      	Param=text</C>
		<C>Col=EMPNMK  	  	Ctrl=EMPNMK  	   		Param=text</C>
		<C>Col=EMPJUNO    	Ctrl=EMPJUNO       	Param=text</C>
		<C>Col=TELNUM    		Ctrl=TELNUM       		Param=text</C>
		<C>Col=ADDRESS    	Ctrl=ADDRESS       	Param=text</C>


		<C>Col=PEALLOWYN    Ctrl=gcra_peallowyn			Param=codevalue</C>
		<C>Col=HOUSEYN    	Ctrl=gcra_houseyn			Param=codevalue</C>
		<C>Col=HOUCNT    		Ctrl=gcra_houcnt				Param=codevalue</C>
		<C>Col=HOUAREA    	Ctrl=gcra_houarea       		Param=codevalue</C>
		<C>Col=HOUVAL    		Ctrl=gcra_houval       		Param=codevalue</C>
		<C>Col=HOULOAN    	Ctrl=gcra_houloan       		Param=codevalue</C>

		<C>Col=CP11000    	Ctrl=CP11000       	Param=text</C>
		<C>Col=CP12000    	Ctrl=CP12000       	Param=text</C>
		<C>Col=CP13000    	Ctrl=CP13000       	Param=text</C>
		<C>Col=TAX_SUM    	Ctrl=TAX_SUM       	Param=text</C>
		<C>Col=CNTAXSUM   	Ctrl=CNTAXSUM      	Param=text</C>

		<C>Col=CP41000		Ctrl=CP41000			Param=text</C>
		<C>Col=CP42000   		Ctrl=CP42000			Param=text</C>
		<C>Col=CPENAMT01   	Ctrl=CPENAMT01      Param=text</C>
		<C>Col=CINSAMT01   	Ctrl=CINSAMT01      Param=text</C>
		<C>Col=CINSAMT02   	Ctrl=CINSAMT02      Param=text</C>

		<C>Col=HOUAMT01		Ctrl=HOUAMT01		Param=text</C>
		<C>Col=HOUAMT02   	Ctrl=HOUAMT02		Param=text</C>
		<C>Col=HOUAMT03   	Ctrl=HOUAMT03       Param=text</C>
		<C>Col=HOUAMT04   	Ctrl=HOUAMT04       Param=text</C>
		<C>Col=HOUAMT05   	Ctrl=HOUAMT05       Param=text</C>
		<C>Col=HOUSUM	    	Ctrl=HOUSUM			Param=text</C>

		<C>Col=PESAMT01   	Ctrl=PESAMT01       Param=text</C>
		<C>Col=PESAMT02   	Ctrl=PESAMT02       Param=text</C>
		<C>Col=CPENAMT03   	Ctrl=CPENAMT03     Param=text</C>


		<C>Col=FNDAMT01   	Ctrl=FNDAMT01		Param=text</C>	
		<C>Col=FNDAMT02   	Ctrl=FNDAMT02		Param=text</C>	
		<C>Col=FNDAMT03   	Ctrl=FNDAMT03		Param=text</C>	
		<C>Col=FNDSUM   		Ctrl=FNDSUM			Param=text</C>	

		<C>Col=CONAMT99   	Ctrl=CONAMT99        Param=text</C>	


	'>
</object>

<object id=gcbn_data2 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds2>
	<param name=BindInfo  value='
		<C>Col=BF_WKNM     	  	Ctrl=BF_WKNM     	   	Param=text</C>
		<C>Col=BF_RESINO	  		Ctrl=BF_RESINO	       	Param=text</C>
		<C>Col=BF_TAX_PAY	  	Ctrl=BF_TAX_PAY	       	Param=text</C>
		<C>Col=BF_TAX_BNS	  	Ctrl=BF_TAX_BNS	       	Param=text</C>
		<C>Col=BF_TAX_SUM 	  	Ctrl=BF_TAX_SUM 	   	Param=text</C>
		<C>Col=BF_NTAX_SUM 	Ctrl=BF_NTAX_SUM 	   	Param=text</C>
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

<object id=gcbn_data8 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds8>
	<param name=BindInfo  value='
		<C>Col=SAVAMT01  	Ctrl=SAVAMT01 	   	Param=text</C>
		<C>Col=SAVAMT02  	Ctrl=SAVAMT02       	Param=text</C>
		<C>Col=SAVAMT03  	Ctrl=SAVAMT03       	Param=text</C>
		<C>Col=SAVAMT04  	Ctrl=SAVAMT04       	Param=text</C>
	'>
</object>


<object id=gcbn_data11 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds11>
	<param name=BindInfo  value='
		<C>Col=PESAMT01  	Ctrl=PESAMT01 	   	Param=text</C>
		<C>Col=PESAMT02  	Ctrl=PESAMT02       	Param=text</C>
		<C>Col=CPENAMT03  	Ctrl=CPENAMT03       Param=text</C>

		<C>Col=FNDAMT01  	Ctrl=FNDAMT01 	   	Param=text</C>
		<C>Col=FNDAMT02  	Ctrl=FNDAMT02       	Param=text</C>
		<C>Col=FNDAMT03  	Ctrl=FNDAMT03       	Param=text</C>

	'>
</object>




<object id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="ds_print">  
	<PARAM NAME="DetailDataID"			VALUE="ds_print">
	<PARAM NAME="PaperSize"				VALUE="A4">	
	<PARAM NAME="LandScape"				VALUE="False">
    <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"			VALUE="90">
	<param name="MargineX"              value="30">
	<param name="MargineY"              value="30">

	<PARAM NAME="Format" VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='1쪽.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='ds_print'
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=2787 ,face='Arial' ,size=10 ,penwidth=1

		<L> left=29 ,top=349 ,right=1900 ,bottom=349 </L>
	<L> left=29 ,top=400 ,right=1900 ,bottom=400 </L>
	<L> left=29 ,top=450 ,right=1900 ,bottom=450 </L>
	<L> left=29 ,top=500 ,right=1900 ,bottom=500 </L>
	<L> left=29 ,top=550 ,right=1900 ,bottom=550 </L>
	<L> left=29 ,top=601 ,right=1900 ,bottom=601 </L>
	<L> left=29 ,top=669 ,right=1900 ,bottom=669 </L>
	<L> left=101 ,top=749 ,right=741 ,bottom=749 </L>
	<L> left=101 ,top=889 ,right=1900 ,bottom=889 </L>
	<L> left=101 ,top=900 ,right=1900 ,bottom=900 </L>
	<L> left=101 ,top=1029 ,right=1900 ,bottom=1029 </L>
	<L> left=101 ,top=1040 ,right=1900 ,bottom=1040 </L>
	<L> left=101 ,top=1180 ,right=1900 ,bottom=1180 </L>
	<L> left=101 ,top=1320 ,right=1900 ,bottom=1320 </L>
	<L> left=101 ,top=1461 ,right=1900 ,bottom=1461 </L>
	<L> left=101 ,top=1601 ,right=1900 ,bottom=1601 </L>
	<L> left=101 ,top=1741 ,right=1900 ,bottom=1741 </L>
	<L> left=101 ,top=1881 ,right=1900 ,bottom=1881 </L>
	<L> left=101 ,top=2019 ,right=1900 ,bottom=2019 </L>
	<L> left=349 ,top=820 ,right=421 ,bottom=820 </L>
	<L> left=349 ,top=966 ,right=421 ,bottom=966 </L>
	<L> left=349 ,top=1111 ,right=421 ,bottom=1111 </L>
	<L> left=349 ,top=1249 ,right=421 ,bottom=1249 </L>
	<L> left=349 ,top=1389 ,right=421 ,bottom=1389 </L>
	<L> left=349 ,top=1529 ,right=421 ,bottom=1529 </L>
	<L> left=349 ,top=1670 ,right=421 ,bottom=1670 </L>
	<L> left=349 ,top=1810 ,right=421 ,bottom=1810 </L>
	<L> left=349 ,top=1950 ,right=421 ,bottom=1950 </L>
	<L> left=349 ,top=2090 ,right=421 ,bottom=2090 </L>
	<L> left=741 ,top=966 ,right=849 ,bottom=966 </L>
	<L> left=741 ,top=1111 ,right=849 ,bottom=1111 </L>
	<L> left=741 ,top=1249 ,right=849 ,bottom=1249 </L>
	<L> left=741 ,top=1389 ,right=849 ,bottom=1389 </L>
	<L> left=741 ,top=1529 ,right=849 ,bottom=1529 </L>
	<L> left=741 ,top=1670 ,right=849 ,bottom=1670 </L>
	<L> left=741 ,top=1810 ,right=849 ,bottom=1810 </L>
	<L> left=741 ,top=1950 ,right=849 ,bottom=1950 </L>
	<L> left=741 ,top=2090 ,right=849 ,bottom=2090 </L>
	<L> left=169 ,top=669 ,right=169 ,bottom=889 </L>
	<L> left=169 ,top=1040 ,right=169 ,bottom=2159 </L>
	<L> left=349 ,top=349 ,right=349 ,bottom=2159 </L>
	<L> left=849 ,top=349 ,right=849 ,bottom=601 </L>
	<L> left=849 ,top=669 ,right=849 ,bottom=2159 </L>
	<L> left=849 ,top=749 ,right=1900 ,bottom=749 </L>
	<L> left=1299 ,top=810 ,right=1749 ,bottom=810 </L>
	<L> left=1230 ,top=349 ,right=1230 ,bottom=601 </L>
	<L> left=421 ,top=749 ,right=421 ,bottom=2159 </L>
	<L> left=500 ,top=749 ,right=500 ,bottom=2159 </L>
	<L> left=579 ,top=749 ,right=579 ,bottom=2159 </L>
	<L> left=659 ,top=749 ,right=659 ,bottom=2159 </L>
	<L> left=741 ,top=669 ,right=741 ,bottom=2159 </L>
	<L> left=1000 ,top=749 ,right=1000 ,bottom=2159 </L>
	<L> left=1151 ,top=749 ,right=1151 ,bottom=2159 </L>
	<L> left=1299 ,top=749 ,right=1299 ,bottom=2159 </L>
	<L> left=1450 ,top=810 ,right=1450 ,bottom=2159 </L>
	<L> left=1601 ,top=810 ,right=1601 ,bottom=2159 </L>
	<L> left=1749 ,top=749 ,right=1749 ,bottom=2159 </L>
	<L> left=101 ,top=669 ,right=101 ,bottom=2799 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=130 ,right=1900 ,bottom=130 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=2799 ,right=1900 ,bottom=2799 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=130 ,right=29 ,bottom=2799 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1900 ,top=130 ,right=1900 ,bottom=2799 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=101 ,top=2159 ,right=1900 ,bottom=2159 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=101 ,top=1111 ,right=349 ,bottom=1111 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=101 ,top=1249 ,right=349 ,bottom=1249 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=101 ,top=1389 ,right=349 ,bottom=1389 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=101 ,top=1529 ,right=349 ,bottom=1529 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=101 ,top=1670 ,right=349 ,bottom=1670 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=101 ,top=1810 ,right=349 ,bottom=1810 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=101 ,top=1950 ,right=349 ,bottom=1950 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=101 ,top=2090 ,right=349 ,bottom=2090 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=849 ,top=966 ,right=1900 ,bottom=966 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=849 ,top=1111 ,right=1900 ,bottom=1111 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=849 ,top=1249 ,right=1900 ,bottom=1249 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=849 ,top=1389 ,right=1900 ,bottom=1389 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=849 ,top=1529 ,right=1900 ,bottom=1529 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=849 ,top=1670 ,right=1900 ,bottom=1670 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=849 ,top=1810 ,right=1900 ,bottom=1810 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=849 ,top=1950 ,right=1900 ,bottom=1950 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=849 ,top=2090 ,right=1900 ,bottom=2090 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=114 ,top=2241 ,right=1855 ,bottom=2241 </L>
	<L> left=114 ,top=2281 ,right=1855 ,bottom=2281 </L>
	<L> left=114 ,top=2320 ,right=1855 ,bottom=2320 </L>
	<L> left=114 ,top=2360 ,right=1855 ,bottom=2360 </L>
	<L> left=114 ,top=2400 ,right=1855 ,bottom=2400 </L>
	<L> left=114 ,top=2241 ,right=114 ,bottom=2400 </L>
	<L> left=574 ,top=2241 ,right=574 ,bottom=2400 </L>
	<L> left=696 ,top=2241 ,right=696 ,bottom=2400 </L>
	<L> left=1156 ,top=2241 ,right=1156 ,bottom=2400 </L>
	<L> left=1275 ,top=2241 ,right=1275 ,bottom=2400 </L>
	<L> left=1736 ,top=2241 ,right=1736 ,bottom=2400 </L>
	<L> left=1855 ,top=2241 ,right=1855 ,bottom=2400 </L>
	<X>left=1601 ,top=966 ,right=1749 ,bottom=1029 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=169 ,top=1111 ,right=349 ,bottom=1180 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1601 ,top=1111 ,right=1749 ,bottom=1180 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1601 ,top=1249 ,right=1749 ,bottom=1320 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1601 ,top=1389 ,right=1749 ,bottom=1461 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1601 ,top=1529 ,right=1749 ,bottom=1601 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1601 ,top=1670 ,right=1749 ,bottom=1741 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1601 ,top=1810 ,right=1749 ,bottom=1881 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1601 ,top=1950 ,right=1749 ,bottom=2019 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1601 ,top=2090 ,right=1749 ,bottom=2159 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='[별지 제37호 서식]  (2010.04.30.개정)' ,left=29 ,top=71 ,right=873 ,bottom=132 ,align='left'</T>
	<T>id='(1쪽)' ,left=1738 ,top=71 ,right=1892 ,bottom=132 ,align='right'</T>
	<T>id='소득공제신고서/근로소득자공제신고서 (2010년 소득에 대한 연말정산용)' ,left=151 ,top=148 ,right=1802 ,bottom=220 ,align='left' ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='* 근로소득자는 신고서에 소득공제증빙서류를 첨부하여 원천징수의무자(소속 회사 등)에게 제출하며, 원천징수의무자는 신고서 및 첨부서류를 확인하여 근로소득자에게  ' ,left=40 ,top=249 ,right=1889 ,bottom=291 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='즉시 근로소득원천징수영수증을 발급하여야 합니다. 연말정산 시 근로소득자에게 환급이 발생하는 경우 원천징수의무자는 근로소득자에게 환급세액을 지급하여야 합니다.' ,left=40 ,top=299 ,right=1889 ,bottom=341 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득자 성명' ,left=29 ,top=349 ,right=349 ,bottom=400 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민등록번호' ,left=849 ,top=349 ,right=1230 ,bottom=400 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근무처 명칭' ,left=29 ,top=400 ,right=349 ,bottom=450 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사업자등록번호' ,left=849 ,top=400 ,right=1230 ,bottom=450 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='221-81-13834' ,left=1230 ,top=400 ,right=1900 ,bottom=450 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세대주 여부' ,left=29 ,top=450 ,right=349 ,bottom=500 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근무기간' ,left=29 ,top=500 ,right=349 ,bottom=550 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='~' ,left=579 ,top=500 ,right=601 ,bottom=550 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='감면기간' ,left=849 ,top=500 ,right=1230 ,bottom=550 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='~' ,left=1529 ,top=500 ,right=1601 ,bottom=550 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주구분' ,left=29 ,top=550 ,right=370 ,bottom=601 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='변동 여부' ,left=29 ,top=635 ,right=370 ,bottom=669 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='※ 인적공제 항목이 전년과 동일한 경우에는 주민등록표등본을 제출하지 아니합니다.' ,left=900 ,top=601 ,right=1900 ,bottom=669 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관계' ,left=101 ,top=669 ,right=169 ,bottom=709 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='코드' ,left=101 ,top=709 ,right=169 ,bottom=749 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=169 ,top=669 ,right=349 ,bottom=749 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인적공제 항목' ,left=349 ,top=669 ,right=749 ,bottom=749 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='각종 소득공제 항목' ,left=849 ,top=669 ,right=1900 ,bottom=749 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내·외' ,left=101 ,top=770 ,right=169 ,bottom=820 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국인' ,left=101 ,top=820 ,right=169 ,bottom=860 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민등록' ,left=169 ,top=770 ,right=349 ,bottom=820 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='번호' ,left=169 ,top=820 ,right=349 ,bottom=860 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본' ,left=349 ,top=759 ,right=421 ,bottom=791 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=349 ,top=791 ,right=421 ,bottom=820 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부녀' ,left=349 ,top=826 ,right=421 ,bottom=865 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자' ,left=349 ,top=855 ,right=421 ,bottom=894 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='경로' ,left=421 ,top=770 ,right=500 ,bottom=820 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='우대' ,left=421 ,top=820 ,right=500 ,bottom=860 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출산' ,left=500 ,top=759 ,right=579 ,bottom=799 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='·' ,left=500 ,top=799 ,right=579 ,bottom=815 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='입양' ,left=500 ,top=815 ,right=579 ,bottom=849 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자' ,left=500 ,top=849 ,right=579 ,bottom=889 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='장애' ,left=579 ,top=770 ,right=659 ,bottom=820 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인' ,left=579 ,top=820 ,right=659 ,bottom=860 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6세이' ,left=659 ,top=770 ,right=741 ,bottom=820 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='하자' ,left=659 ,top=820 ,right=741 ,bottom=860 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자료' ,left=741 ,top=759 ,right=849 ,bottom=799 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구분' ,left=741 ,top=799 ,right=849 ,bottom=839 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=849 ,top=749 ,right=1000 ,bottom=794 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(건강보험료' ,left=849 ,top=794 ,right=1000 ,bottom=839 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='등 포함)' ,left=849 ,top=839 ,right=1000 ,bottom=884 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의료비' ,left=1000 ,top=749 ,right=1151 ,bottom=889 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='교육비' ,left=1151 ,top=749 ,right=1299 ,bottom=889 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='신용카드 등 사용액공제' ,left=1349 ,top=749 ,right=1701 ,bottom=820 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='신용카드등' ,left=1299 ,top=810 ,right=1450 ,bottom=889 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직불카드등' ,left=1450 ,top=810 ,right=1601 ,bottom=889 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현금영수증' ,left=1601 ,top=810 ,right=1749 ,bottom=889 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금' ,left=1749 ,top=749 ,right=1900 ,bottom=889 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인적공제 항목에' ,left=101 ,top=910 ,right=349 ,bottom=955 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='해당하는 인원수를' ,left=101 ,top=947 ,right=349 ,bottom=984 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기재(다자녀' ,left=103 ,top=979 ,right=243 ,bottom=1024 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='명)' ,left=299 ,top=979 ,right=349 ,bottom=1024 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='0' ,left=101 ,top=1040 ,right=169 ,bottom=1111 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='O' ,left=349 ,top=1040 ,right=421 ,bottom=1111 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청' ,left=749 ,top=900 ,right=849 ,bottom=960 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=749 ,top=960 ,right=849 ,bottom=1040 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청' ,left=749 ,top=1040 ,right=849 ,bottom=1111 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=749 ,top=1111 ,right=849 ,bottom=1180 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청' ,left=749 ,top=1180 ,right=849 ,bottom=1249 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=749 ,top=1249 ,right=849 ,bottom=1320 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청' ,left=749 ,top=1320 ,right=849 ,bottom=1389 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=749 ,top=1389 ,right=849 ,bottom=1461 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청' ,left=749 ,top=1461 ,right=849 ,bottom=1529 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=749 ,top=1529 ,right=849 ,bottom=1601 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청' ,left=749 ,top=1601 ,right=849 ,bottom=1670 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=749 ,top=1670 ,right=849 ,bottom=1741 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청' ,left=749 ,top=1741 ,right=849 ,bottom=1810 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=749 ,top=1810 ,right=849 ,bottom=1881 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청' ,left=749 ,top=1881 ,right=849 ,bottom=1950 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=749 ,top=1950 ,right=849 ,bottom=2019 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청' ,left=749 ,top=2019 ,right=849 ,bottom=2090 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=749 ,top=2090 ,right=849 ,bottom=2159 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ⅰ.' ,left=34 ,top=1262 ,right=95 ,bottom=1312 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인' ,left=34 ,top=1312 ,right=95 ,bottom=1352 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='적' ,left=34 ,top=1360 ,right=95 ,bottom=1400 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=34 ,top=1408 ,right=95 ,bottom=1447 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=34 ,top=1455 ,right=95 ,bottom=1495 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='및' ,left=34 ,top=1548 ,right=95 ,bottom=1585 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소' ,left=34 ,top=1635 ,right=95 ,bottom=1677 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='득' ,left=34 ,top=1685 ,right=95 ,bottom=1725 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=34 ,top=1733 ,right=95 ,bottom=1773 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=34 ,top=1781 ,right=95 ,bottom=1818 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='명' ,left=34 ,top=1873 ,right=95 ,bottom=1913 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=34 ,top=1921 ,right=95 ,bottom=1958 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='※참고사항' ,left=111 ,top=2180 ,right=291 ,bottom=2209 ,align='left' ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  1. 관계코드' ,left=111 ,top=2209 ,right=1876 ,bottom=2246 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구  분' ,left=114 ,top=2246 ,right=574 ,bottom=2281 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관계코드' ,left=574 ,top=2246 ,right=696 ,bottom=2281 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구  분' ,left=696 ,top=2246 ,right=1156 ,bottom=2281 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관계코드' ,left=1156 ,top=2246 ,right=1275 ,bottom=2281 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구  분' ,left=1275 ,top=2246 ,right=1736 ,bottom=2281 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관계코드' ,left=1736 ,top=2246 ,right=1855 ,bottom=2281 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득자 본인(소법§50①1)' ,left=114 ,top=2286 ,right=574 ,bottom=2320 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='0' ,left=574 ,top=2286 ,right=696 ,bottom=2320 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득자의 직계존속(소법§50③가)' ,left=696 ,top=2286 ,right=1156 ,bottom=2320 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1' ,left=1156 ,top=2286 ,right=1275 ,bottom=2320 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='배우자의 직계존속(소법§50③가)' ,left=1275 ,top=2286 ,right=1736 ,bottom=2320 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2' ,left=1736 ,top=2286 ,right=1855 ,bottom=2320 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='배우자(소법§50①2)' ,left=114 ,top=2326 ,right=574 ,bottom=2360 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3' ,left=574 ,top=2326 ,right=696 ,bottom=2360 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직계비속(자녀·입양자)(소법§50③나)' ,left=696 ,top=2326 ,right=1156 ,bottom=2360 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4˙' ,left=1156 ,top=2326 ,right=1275 ,bottom=2360 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직계비속(코드4제외)(소법§50③나)' ,left=1275 ,top=2326 ,right=1736 ,bottom=2360 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5˙' ,left=1736 ,top=2326 ,right=1855 ,bottom=2360 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='형제자매(소법§50③다)' ,left=114 ,top=2365 ,right=574 ,bottom=2400 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6' ,left=574 ,top=2365 ,right=696 ,bottom=2400 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수급자(코드1~6제외)(소법§50③라)' ,left=696 ,top=2365 ,right=1156 ,bottom=2400 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='7' ,left=1156 ,top=2365 ,right=1275 ,bottom=2400 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='위탁아동(소법§50③마)' ,left=1275 ,top=2365 ,right=1736 ,bottom=2400 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='8' ,left=1736 ,top=2365 ,right=1855 ,bottom=2400 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     * 해당 직계비속과 그 배우자가 장애인인 경우 그 배우자를 포함' ,left=111 ,top=2416 ,right=1873 ,bottom=2450 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ※ 관계코드 4~6는 소득자와 배우자의 각각의 관계를 포함합니다.' ,left=111 ,top=2450 ,right=1873 ,bottom=2484 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  2. 연령기준' ,left=111 ,top=2484 ,right=1876 ,bottom=2519 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  가. 경로우대 : 1940.12.31. 이전 출생(만 70세 이상 : 100만원 공제)' ,left=111 ,top=2519 ,right=1876 ,bottom=2556 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  나. 6세 이하자 : 2004.01.01. 이후 출생(만 6세 이하 : 100만원)' ,left=111 ,top=2556 ,right=1876 ,bottom=2590 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  3. 부녀자 공제란에는 여성근로소득자 본인에 한해 적용여부를 표시합니다.' ,left=111 ,top=2590 ,right=1876 ,bottom=2625 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  4. 내ㆍ외국인 : 내국인 =1, 외국인=9 로 구분하여 적습니다. 근로소득자가 외국인에 해당하는 경우 국적을 기재하며 국적코드는 거주지국코드를' ,left=111 ,top=2625 ,right=1876 ,bottom=2659 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     참조하여 적습니다.' ,left=111 ,top=2659 ,right=1876 ,bottom=2696 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  5. 다자녀란은 근로자 본인의 기본공제대상자에 해당하는 자녀가 2명 이상인 경우에 해당 자녀수를 적습니다.' ,left=108 ,top=2696 ,right=1876 ,bottom=2731 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  6. 신용카드 등에는 학원비 지로납부액이 포함된 금액을 적습니다. 직불카드 등에는 「여신전문금융업법」제2조에 따른 직불카드 등 「조세' ,left=108 ,top=2731 ,right=1876 ,bottom=2765 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    특례제한법」제126조2제1항제4호에 해당하는 금액을 적습니다.' ,left=111 ,top=2765 ,right=1879 ,bottom=2799 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='210㎜x297㎜' ,left=1299 ,top=2805 ,right=1889 ,bottom=2839 ,align='right'</T>
	<C>id='EMPNO', left=1640, top=101, right=1799, bottom=130, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=349, top=349, right=849, bottom=400, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO', left=1230, top=349, right=1900, bottom=400 ,mask='XXXXXX-XXXXXXX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COMPANY', left=349, top=400, right=849, bottom=450, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CURDT3', left=376, top=500, right=577, bottom=550 ,mask='XXXX/XX/XX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CNT', left=249, top=979, right=299, bottom=1024, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_1', left=101, top=1040, right=169, bottom=1101, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_1', left=101, top=1111, right=169, bottom=1180, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_2', left=101, top=1180, right=169, bottom=1249, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_2', left=101, top=1249, right=169, bottom=1320, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_3', left=101, top=1320, right=169, bottom=1389, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_3', left=101, top=1389, right=169, bottom=1461, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_4', left=101, top=1461, right=169, bottom=1529, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_4', left=101, top=1529, right=169, bottom=1601, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_5', left=101, top=1601, right=169, bottom=1670, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_5', left=101, top=1670, right=169, bottom=1741, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_6', left=101, top=1741, right=169, bottom=1810, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_6', left=101, top=1810, right=169, bottom=1881, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_7', left=101, top=1881, right=169, bottom=1950, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_7', left=101, top=1950, right=169, bottom=2019, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_8', left=101, top=2019, right=169, bottom=2090, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_8', left=101, top=2090, right=169, bottom=2159, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=169, top=1040, right=349, bottom=1111, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO', left=169, top=1111, right=349, bottom=1180 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='EMPNMK_2', left=169, top=1180, right=349, bottom=1249, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_2', left=169, top=1249, right=349, bottom=1320 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_3', left=169, top=1320, right=349, bottom=1389, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_3', left=169, top=1389, right=349, bottom=1461 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_4', left=169, top=1461, right=349, bottom=1529, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_4', left=169, top=1529, right=349, bottom=1601 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_5', left=169, top=1601, right=349, bottom=1670, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_5', left=169, top=1670, right=349, bottom=1741 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_6', left=169, top=1741, right=349, bottom=1810, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_6', left=169, top=1810, right=349, bottom=1881 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_7', left=169, top=1881, right=349, bottom=1950, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_7', left=169, top=1950, right=349, bottom=2019 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_8', left=169, top=2019, right=349, bottom=2090, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_8', left=169, top=2090, right=349, bottom=2159 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_1', left=349, top=1040, right=421, bottom=1111, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_2', left=349, top=1180, right=421, bottom=1249, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_3', left=349, top=1320, right=421, bottom=1389, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_4', left=349, top=1461, right=421, bottom=1529, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_5', left=349, top=1601, right=421, bottom=1670, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_6', left=349, top=1741, right=421, bottom=1810, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_7', left=349, top=1881, right=421, bottom=1950, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_8', left=349, top=2019, right=421, bottom=2090, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_1', left=579, top=1040, right=659, bottom=1180, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_2', left=579, top=1180, right=659, bottom=1320, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_3', left=579, top=1320, right=659, bottom=1461, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_4', left=579, top=1461, right=659, bottom=1601, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_5', left=579, top=1601, right=659, bottom=1741, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_6', left=579, top=1741, right=659, bottom=1881, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_7', left=579, top=1881, right=659, bottom=2019, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_8', left=579, top=2019, right=659, bottom=2159, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_1', left=421, top=1040, right=500, bottom=1180, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_2', left=421, top=1180, right=500, bottom=1320, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_3', left=421, top=1320, right=500, bottom=1461, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_4', left=421, top=1461, right=500, bottom=1601, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_5', left=421, top=1601, right=500, bottom=1741, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_6', left=421, top=1741, right=500, bottom=1881, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_7', left=421, top=1881, right=500, bottom=2019, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_8', left=421, top=2019, right=500, bottom=2159, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6_1', left=349, top=1111, right=421, bottom=1180, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_1', left=659, top=1040, right=741, bottom=1180, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_2', left=659, top=1180, right=741, bottom=1320, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_3', left=659, top=1320, right=741, bottom=1461, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_4', left=659, top=1461, right=741, bottom=1601, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_5', left=659, top=1601, right=741, bottom=1741, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_6', left=659, top=1741, right=741, bottom=1881, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_7', left=659, top=1881, right=741, bottom=2019, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_8', left=659, top=2019, right=741, bottom=2159, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_2', left=500, top=1040, right=579, bottom=1180, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_2', left=500, top=1180, right=579, bottom=1320, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_3', left=500, top=1320, right=579, bottom=1461, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_4', left=500, top=1461, right=579, bottom=1601, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_5', left=500, top=1601, right=579, bottom=1741, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_6', left=500, top=1741, right=579, bottom=1881, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_7', left=500, top=1881, right=579, bottom=2019, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF8_8', left=500, top=2019, right=579, bottom=2159, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_S,0,,REF11_S)}', left=849, top=900, right=1000, bottom=960, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_1,0,,REF11_1)}', left=849, top=1040, right=1000, bottom=1111, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_2,0,,REF11_2)}', left=849, top=1180, right=1000, bottom=1249, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_3,0,,REF11_3)}', left=849, top=1320, right=1000, bottom=1389, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_4,0,,REF11_4)}', left=849, top=1461, right=1000, bottom=1529, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_5,0,,REF11_5)}', left=849, top=1601, right=1000, bottom=1670, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_6,0,,REF11_6)}', left=849, top=1741, right=1000, bottom=1810, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_7,0,,REF11_7)}', left=849, top=1881, right=1000, bottom=1950, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_8,0,,REF11_8)}', left=849, top=2019, right=1000, bottom=2090, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_S,0,,REF21_S)}', left=849, top=960, right=1000, bottom=1029, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_1,0,,REF21_1)}', left=849, top=1111, right=1000, bottom=1180, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_2,0,,REF21_2)}', left=849, top=1249, right=1000, bottom=1320, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_3,0,,REF21_3)}', left=849, top=1389, right=1000, bottom=1461, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_4,0,,REF21_4)}', left=849, top=1529, right=1000, bottom=1601, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_5,0,,REF21_5)}', left=849, top=1670, right=1000, bottom=1741, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_6,0,,REF21_6)}', left=849, top=1810, right=1000, bottom=1881, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_7,0,,REF21_7)}', left=849, top=1950, right=1000, bottom=2019, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_8,0,,REF21_8)}', left=849, top=2090, right=1000, bottom=2159, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_S,0,,REF12_S)}', left=1000, top=900, right=1151, bottom=960, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_1,0,,REF12_1)}', left=1000, top=1040, right=1151, bottom=1111, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_2,0,,REF12_2)}', left=1000, top=1180, right=1151, bottom=1249, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_3,0,,REF12_3)}', left=1000, top=1320, right=1151, bottom=1389, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_4,0,,REF12_4)}', left=1000, top=1461, right=1151, bottom=1529, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_5,0,,REF12_5)}', left=1000, top=1601, right=1151, bottom=1670, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_6,0,,REF12_6)}', left=1000, top=1741, right=1151, bottom=1810, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_7,0,,REF12_7)}', left=1000, top=1881, right=1151, bottom=1950, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_8,0,,REF12_8)}', left=1000, top=2019, right=1151, bottom=2090, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_S,0,,REF22_S)}', left=1000, top=960, right=1151, bottom=1029, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_1,0,,REF22_1)}', left=1000, top=1111, right=1151, bottom=1180, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_2,0,,REF22_2)}', left=1000, top=1249, right=1151, bottom=1320, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_3,0,,REF22_3)}', left=1000, top=1389, right=1151, bottom=1461, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_4,0,,REF22_4)}', left=1000, top=1529, right=1151, bottom=1601, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_5,0,,REF22_5)}', left=1000, top=1670, right=1151, bottom=1741, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_6,0,,REF22_6)}', left=1000, top=1810, right=1151, bottom=1881, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_7,0,,REF22_7)}', left=1000, top=1950, right=1151, bottom=2019, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_8,0,,REF22_8)}', left=1000, top=2090, right=1151, bottom=2159, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_S,0,,REF13_S)}', left=1151, top=900, right=1299, bottom=960, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_1,0,,REF13_1)}', left=1151, top=1040, right=1299, bottom=1111, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_2,0,,REF13_2)}', left=1151, top=1180, right=1299, bottom=1249, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_3,0,,REF13_3)}', left=1151, top=1320, right=1299, bottom=1389, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_4,0,,REF13_4)}', left=1151, top=1461, right=1299, bottom=1529, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_5,0,,REF13_5)}', left=1151, top=1601, right=1299, bottom=1670, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_6,0,,REF13_6)}', left=1151, top=1741, right=1299, bottom=1810, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_7,0,,REF13_7)}', left=1151, top=1881, right=1299, bottom=1950, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_8,0,,REF13_8)}', left=1151, top=2019, right=1299, bottom=2090, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_S,0,,REF23_S)}', left=1151, top=960, right=1299, bottom=1029, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_1,0,,REF23_1)}', left=1151, top=1111, right=1299, bottom=1180, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_2,0,,REF23_2)}', left=1151, top=1249, right=1299, bottom=1320, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_3,0,,REF23_3)}', left=1151, top=1389, right=1299, bottom=1461, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_4,0,,REF23_4)}', left=1151, top=1529, right=1299, bottom=1601, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_5,0,,REF23_5)}', left=1151, top=1670, right=1299, bottom=1741, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_6,0,,REF23_6)}', left=1151, top=1810, right=1299, bottom=1881, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_7,0,,REF23_7)}', left=1151, top=1950, right=1299, bottom=2019, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_8,0,,REF23_8)}', left=1151, top=2090, right=1299, bottom=2159, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_S,0,,REF14_S)}', left=1299, top=900, right=1450, bottom=960, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_2,0,,REF14_2)}', left=1299, top=1180, right=1450, bottom=1249, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_3,0,,REF14_3)}', left=1299, top=1320, right=1450, bottom=1389, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_4,0,,REF14_4)}', left=1299, top=1461, right=1450, bottom=1529, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_5,0,,REF14_5)}', left=1299, top=1601, right=1450, bottom=1670, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_6,0,,REF14_6)}', left=1299, top=1741, right=1450, bottom=1810, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_7,0,,REF14_7)}', left=1299, top=1881, right=1450, bottom=1950, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_8,0,,REF14_8)}', left=1299, top=2019, right=1450, bottom=2090, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_S,0,,REF24_S)}', left=1299, top=960, right=1450, bottom=1029, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_1,0,,REF24_1)}', left=1299, top=1111, right=1450, bottom=1180, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_2,0,,REF24_2)}', left=1299, top=1249, right=1450, bottom=1320, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_3,0,,REF24_3)}', left=1299, top=1389, right=1450, bottom=1461, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_4,0,,REF24_4)}', left=1299, top=1529, right=1450, bottom=1601, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_5,0,,REF24_5)}', left=1299, top=1670, right=1450, bottom=1741, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_6,0,,REF24_6)}', left=1299, top=1810, right=1450, bottom=1881, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_7,0,,REF24_7)}', left=1299, top=1950, right=1450, bottom=2019, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_8,0,,REF24_8)}', left=1299, top=2090, right=1450, bottom=2159, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_S,0,,REF15_S)}', left=1601, top=900, right=1749, bottom=960, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_1,0,,REF15_1)}', left=1601, top=1040, right=1749, bottom=1111, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_2,0,,REF15_2)}', left=1601, top=1180, right=1749, bottom=1249, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_3,0,,REF15_3)}', left=1601, top=1320, right=1749, bottom=1389, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_4,0,,REF15_4)}', left=1601, top=1461, right=1749, bottom=1529, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_5,0,,REF15_5)}', left=1601, top=1601, right=1749, bottom=1670, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_6,0,,REF15_6)}', left=1601, top=1741, right=1749, bottom=1810, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_7,0,,REF15_7)}', left=1601, top=1881, right=1749, bottom=1950, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_8,0,,REF15_8)}', left=1601, top=2019, right=1749, bottom=2090, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_S,0,,REF16_S)}', left=1749, top=900, right=1900, bottom=960, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_1,0,,REF16_1)}', left=1749, top=1040, right=1900, bottom=1111, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_2,0,,REF16_2)}', left=1749, top=1180, right=1900, bottom=1249, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_3,0,,REF16_3)}', left=1749, top=1320, right=1900, bottom=1389, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_4,0,,REF16_4)}', left=1749, top=1461, right=1900, bottom=1529, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_5,0,,REF16_5)}', left=1749, top=1601, right=1900, bottom=1670, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_6,0,,REF16_6)}', left=1749, top=1741, right=1900, bottom=1810, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_7,0,,REF16_7)}', left=1749, top=1881, right=1900, bottom=1950, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_8,0,,REF16_8)}', left=1749, top=2019, right=1900, bottom=2090, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_S,0,,REF26_S)}', left=1749, top=960, right=1900, bottom=1029, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_1,0,,REF26_1)}', left=1749, top=1111, right=1900, bottom=1180, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_2,0,,REF26_2)}', left=1749, top=1249, right=1900, bottom=1320, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_3,0,,REF26_3)}', left=1749, top=1389, right=1900, bottom=1461, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_4,0,,REF26_4)}', left=1749, top=1529, right=1900, bottom=1601, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_5,0,,REF26_5)}', left=1749, top=1670, right=1900, bottom=1741, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_6,0,,REF26_6)}', left=1749, top=1810, right=1900, bottom=1881, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_7,0,,REF26_7)}', left=1749, top=1950, right=1900, bottom=2019, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF26_8,0,,REF26_8)}', left=1749, top=2090, right=1900, bottom=2159, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=', 변동    ' ,left=619 ,top=601 ,right=749 ,bottom=669 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PEALLOWYN1', left=537, top=611, right=595, bottom=661, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PEALLOWYN2', left=757, top=611, right=815, bottom=661, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RESIGB2', left=757, top=550, right=815, bottom=601, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RESIGB1', left=537, top=553, right=595, bottom=603, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HYN1', left=537, top=450, right=595, bottom=500, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CURDT', left=606, top=500, right=807, bottom=550 ,mask='XXXX/XX/XX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='인적공제 항목' ,left=29 ,top=603 ,right=370 ,bottom=638 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전년과동일' ,left=378 ,top=601 ,right=527 ,bottom=669 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세대주' ,left=407 ,top=450 ,right=508 ,bottom=500 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=',  세대원 ' ,left=606 ,top=450 ,right=736 ,bottom=500 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국 적' ,left=849 ,top=450 ,right=1230 ,bottom=500 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(국적 코드 :  ' ,left=1400 ,top=450 ,right=1598 ,bottom=500 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주자' ,left=407 ,top=550 ,right=508 ,bottom=601 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=', 비거주자' ,left=590 ,top=550 ,right=741 ,bottom=601 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주지국' ,left=849 ,top=550 ,right=1230 ,bottom=601 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(거주지국 코드 : ' ,left=1397 ,top=550 ,right=1659 ,bottom=601 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='NATIONCD', left=1590, top=452, right=1648, bottom=497, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=')' ,left=1733 ,top=550 ,right=1762 ,bottom=601 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=')' ,left=1675 ,top=450 ,right=1704 ,bottom=500 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RESINACD', left=1646, top=550, right=1704, bottom=595, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HYN2', left=757, top=450, right=815, bottom=500, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_S,0,,REF17_S)}', left=1450, top=900, right=1601, bottom=960, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_S,0,,REF27_S)}', left=1450, top=960, right=1601, bottom=1029, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_1,0,,REF14_1)}', left=1299, top=1040, right=1450, bottom=1111, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_1,0,,REF17_1)}', left=1450, top=1040, right=1601, bottom=1111, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_1,0,,REF27_1)}', left=1450, top=1111, right=1601, bottom=1180, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_2,0,,REF17_2)}', left=1450, top=1180, right=1601, bottom=1249, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_2,0,,REF27_2)}', left=1450, top=1249, right=1601, bottom=1320, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_3,0,,REF17_3)}', left=1450, top=1320, right=1601, bottom=1389, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_3,0,,REF27_3)}', left=1450, top=1389, right=1601, bottom=1461, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_4,0,,REF17_4)}', left=1450, top=1461, right=1601, bottom=1529, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_4,0,,REF27_4)}', left=1450, top=1529, right=1601, bottom=1601, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_5,0,,REF17_5)}', left=1450, top=1601, right=1601, bottom=1670, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_5,0,,REF27_5)}', left=1450, top=1670, right=1601, bottom=1741, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_6,0,,REF17_6)}', left=1450, top=1741, right=1601, bottom=1810, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_6,0,,REF27_6)}', left=1450, top=1810, right=1601, bottom=1881, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_7,0,,REF17_7)}', left=1450, top=1881, right=1601, bottom=1950, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_7,0,,REF27_7)}', left=1450, top=1950, right=1601, bottom=2019, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_8,0,,REF17_8)}', left=1450, top=2019, right=1601, bottom=2090, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_8,0,,REF27_8)}', left=1450, top=2090, right=1601, bottom=2159, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	
	
</B>
</R>
</A>

<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='2쪽.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='ds_print'
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2712 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=601 ,top=230 ,right=601 ,bottom=651 </L>
	<L> left=601 ,top=299 ,right=1900 ,bottom=299 </L>
	<L> left=299 ,top=370 ,right=1900 ,bottom=370 </L>
	<L> left=601 ,top=439 ,right=1900 ,bottom=439 </L>
	<L> left=299 ,top=511 ,right=1900 ,bottom=511 </L>
	<L> left=601 ,top=579 ,right=1900 ,bottom=579 </L>
	<L> left=299 ,top=651 ,right=1900 ,bottom=651 </L>
	<L> left=29 ,top=741 ,right=1900 ,bottom=741 </L>
	<L> left=601 ,top=741 ,right=601 ,bottom=1021 </L>
	<L> left=601 ,top=810 ,right=1900 ,bottom=810 </L>
	<L> left=299 ,top=881 ,right=1900 ,bottom=881 </L>
	<L> left=601 ,top=950 ,right=1900 ,bottom=950 </L>
	<L> left=299 ,top=1021 ,right=1900 ,bottom=1021 </L>
	<L> left=299 ,top=1090 ,right=1900 ,bottom=1090 </L>
	<L> left=299 ,top=1159 ,right=1900 ,bottom=1159 </L>
	<L> left=101 ,top=1249 ,right=1900 ,bottom=1249 </L>
	<L> left=299 ,top=1320 ,right=1900 ,bottom=1320 </L>
	<L> left=299 ,top=1389 ,right=1900 ,bottom=1389 </L>
	<L> left=101 ,top=1479 ,right=1900 ,bottom=1479 </L>
	<L> left=299 ,top=1550 ,right=1900 ,bottom=1550 </L>
	<L> left=299 ,top=1619 ,right=1900 ,bottom=1619 </L>
	<L> left=299 ,top=1691 ,right=1900 ,bottom=1691 </L>
	<L> left=299 ,top=1759 ,right=1900 ,bottom=1759 </L>
	<L> left=299 ,top=1831 ,right=1900 ,bottom=1831 </L>
	<L> left=101 ,top=1921 ,right=1900 ,bottom=1921 </L>
	<L> left=299 ,top=1990 ,right=1900 ,bottom=1990 </L>
	<L> left=299 ,top=2061 ,right=1900 ,bottom=2061 </L>
	<L> left=299 ,top=2130 ,right=1900 ,bottom=2130 </L>
	<L> left=101 ,top=2220 ,right=1900 ,bottom=2220 </L>
	<L> left=299 ,top=2291 ,right=1400 ,bottom=2291 </L>
	<L> left=1601 ,top=2291 ,right=1900 ,bottom=2291 </L>
	<L> left=299 ,top=2360 ,right=1400 ,bottom=2360 </L>
	<L> left=1601 ,top=2360 ,right=1900 ,bottom=2360 </L>
	<L> left=299 ,top=2429 ,right=1400 ,bottom=2429 </L>
	<L> left=1601 ,top=2429 ,right=1900 ,bottom=2429 </L>
	<L> left=299 ,top=2500 ,right=1400 ,bottom=2500 </L>
	<L> left=1601 ,top=2500 ,right=1900 ,bottom=2500 </L>
	<L> left=299 ,top=2569 ,right=1400 ,bottom=2569 </L>
	<L> left=1601 ,top=2569 ,right=1900 ,bottom=2569 </L>
	<L> left=299 ,top=2641 ,right=1400 ,bottom=2641 </L>
	<L> left=1601 ,top=2641 ,right=1900 ,bottom=2641 </L>
	<L> left=299 ,top=2709 ,right=1900 ,bottom=2709 </L>
	<L> left=900 ,top=130 ,right=900 ,bottom=2799 </L>
	<L> left=101 ,top=230 ,right=101 ,bottom=2799 </L>
	<L> left=299 ,top=130 ,right=299 ,bottom=2799 </L>
	<L> left=1101 ,top=130 ,right=1101 ,bottom=2799 </L>
	<L> left=1400 ,top=130 ,right=1400 ,bottom=2799 </L>
	<L> left=1601 ,top=130 ,right=1601 ,bottom=2799 </L>
	<L> left=29 ,top=230 ,right=1900 ,bottom=230 </L>
	<L> left=29 ,top=130 ,right=29 ,bottom=2799 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=2799 ,right=1900 ,bottom=2799 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=130 ,right=1900 ,bottom=130 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1900 ,top=130 ,right=1900 ,bottom=2799 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<X>left=900 ,top=651 ,right=1101 ,bottom=741 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1400 ,top=651 ,right=1601 ,bottom=741 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=900 ,top=1159 ,right=1101 ,bottom=1249 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1400 ,top=1159 ,right=1601 ,bottom=1249 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=900 ,top=1389 ,right=1101 ,bottom=1479 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1400 ,top=1389 ,right=1601 ,bottom=1479 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=900 ,top=1831 ,right=1101 ,bottom=1921 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1400 ,top=1831 ,right=1601 ,bottom=1921 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=900 ,top=2130 ,right=1101 ,bottom=2220 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1101 ,top=2130 ,right=1400 ,bottom=2220 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1400 ,top=2130 ,right=1601 ,bottom=2220 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=900 ,top=2709 ,right=1101 ,bottom=2799 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1101 ,top=2709 ,right=1400 ,bottom=2799 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1400 ,top=2709 ,right=1601 ,bottom=2799 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='(2쪽)' ,left=1738 ,top=71 ,right=1892 ,bottom=132 ,align='right'</T>
	<T>id='구분' ,left=29 ,top=130 ,right=299 ,bottom=230 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지출명세' ,left=299 ,top=130 ,right=900 ,bottom=230 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지출구분' ,left=900 ,top=130 ,right=1101 ,bottom=230 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금액' ,left=1101 ,top=130 ,right=1400 ,bottom=230 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='한도액' ,left=1400 ,top=130 ,right=1601 ,bottom=230 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제액' ,left=1601 ,top=130 ,right=1900 ,bottom=230 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ⅱ.' ,left=37 ,top=249 ,right=98 ,bottom=299 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연' ,left=37 ,top=299 ,right=98 ,bottom=349 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금' ,left=37 ,top=349 ,right=98 ,bottom=400 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보' ,left=37 ,top=400 ,right=98 ,bottom=450 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='험' ,left=37 ,top=450 ,right=98 ,bottom=500 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='료' ,left=37 ,top=500 ,right=98 ,bottom=550 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=37 ,top=550 ,right=98 ,bottom=601 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=37 ,top=601 ,right=98 ,bottom=651 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=101 ,top=741 ,right=299 ,bottom=1249 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의료비' ,left=101 ,top=1249 ,right=299 ,bottom=1479 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='교육비' ,left=101 ,top=1479 ,right=299 ,bottom=1921 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주택자금' ,left=101 ,top=1921 ,right=299 ,bottom=2220 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금' ,left=101 ,top=2220 ,right=299 ,bottom=2799 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연금보험료' ,left=101 ,top=299 ,right=299 ,bottom=349 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(국민연금,' ,left=101 ,top=349 ,right=299 ,bottom=400 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공무원연금,' ,left=101 ,top=400 ,right=299 ,bottom=450 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='군인연금,' ,left=101 ,top=450 ,right=299 ,bottom=500 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='교직원연금,' ,left=101 ,top=500 ,right=299 ,bottom=550 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='퇴직연금 등)' ,left=101 ,top=550 ,right=299 ,bottom=601 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국민연금보험료' ,left=299 ,top=230 ,right=601 ,bottom=370 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)근무지' ,left=601 ,top=230 ,right=900 ,bottom=299 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=900 ,top=230 ,right=1101 ,bottom=299 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1400 ,top=230 ,right=1601 ,bottom=299 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주(현)근무지' ,left=601 ,top=299 ,right=900 ,bottom=370 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=900 ,top=299 ,right=1101 ,bottom=370 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1400 ,top=299 ,right=1601 ,bottom=370 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)근무지' ,left=601 ,top=370 ,right=900 ,bottom=439 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=900 ,top=370 ,right=1101 ,bottom=439 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1400 ,top=370 ,right=1601 ,bottom=439 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주(현)근무지' ,left=601 ,top=439 ,right=900 ,bottom=511 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=900 ,top=439 ,right=1101 ,bottom=511 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1400 ,top=439 ,right=1601 ,bottom=511 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='퇴직연금' ,left=299 ,top=511 ,right=601 ,bottom=651 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)근무지' ,left=601 ,top=511 ,right=900 ,bottom=579 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=900 ,top=511 ,right=1101 ,bottom=579 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1400 ,top=511 ,right=1601 ,bottom=579 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주(현)근무지' ,left=601 ,top=579 ,right=900 ,bottom=651 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=900 ,top=579 ,right=1101 ,bottom=651 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1400 ,top=579 ,right=1601 ,bottom=651 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연금보험료 계' ,left=299 ,top=651 ,right=900 ,bottom=741 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='고용보험' ,left=299 ,top=881 ,right=601 ,bottom=1021 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='일반보장성보험' ,left=299 ,top=1021 ,right=900 ,bottom=1090 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='장애인전용보장성보험' ,left=299 ,top=1090 ,right=900 ,bottom=1159 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)근무지' ,left=601 ,top=741 ,right=900 ,bottom=810 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주(현)근무지' ,left=601 ,top=810 ,right=900 ,bottom=881 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)근무지' ,left=601 ,top=881 ,right=900 ,bottom=950 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주(현)근무지' ,left=601 ,top=950 ,right=900 ,bottom=1021 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=900 ,top=741 ,right=1101 ,bottom=810 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=900 ,top=810 ,right=1101 ,bottom=881 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=900 ,top=881 ,right=1101 ,bottom=950 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=900 ,top=950 ,right=1101 ,bottom=1021 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=900 ,top=1021 ,right=1101 ,bottom=1090 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=900 ,top=1090 ,right=1101 ,bottom=1159 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1400 ,top=741 ,right=1601 ,bottom=810 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1400 ,top=810 ,right=1601 ,bottom=881 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1400 ,top=881 ,right=1601 ,bottom=950 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1400 ,top=950 ,right=1601 ,bottom=1021 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='100만원' ,left=1400 ,top=1021 ,right=1601 ,bottom=1090 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='100만원' ,left=1400 ,top=1090 ,right=1601 ,bottom=1159 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료 계' ,left=299 ,top=1159 ,right=900 ,bottom=1249 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='본인ㆍ65세 이상자ㆍ장애인 의료비' ,left=299 ,top=1249 ,right=900 ,bottom=1320 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='그 밖의 공제대상자 의료비' ,left=299 ,top=1320 ,right=900 ,bottom=1389 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지출액' ,left=900 ,top=1249 ,right=1101 ,bottom=1320 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지출액' ,left=900 ,top=1320 ,right=1101 ,bottom=1389 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1400 ,top=1249 ,right=1601 ,bottom=1320 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1400 ,top=1320 ,right=1601 ,bottom=1389 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의료비 계' ,left=299 ,top=1389 ,right=900 ,bottom=1479 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득자 본인' ,left=299 ,top=1479 ,right=900 ,bottom=1550 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='취학전 아동 ( ' ,left=299 ,top=1550 ,right=651 ,bottom=1619 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='초ㆍ중ㆍ고등학교 ( ' ,left=299 ,top=1619 ,right=651 ,bottom=1691 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대학생(대학원 불포함)  ( ' ,left=299 ,top=1691 ,right=651 ,bottom=1759 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='장애인 ( ' ,left=299 ,top=1759 ,right=651 ,bottom=1831 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공납금' ,left=900 ,top=1484 ,right=1101 ,bottom=1516 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(대학원포함)' ,left=900 ,top=1516 ,right=1101 ,bottom=1550 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='학원비등' ,left=900 ,top=1585 ,right=1101 ,bottom=1630 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공납금' ,left=900 ,top=1619 ,right=1101 ,bottom=1691 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공납금' ,left=900 ,top=1691 ,right=1101 ,bottom=1759 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특수교육비' ,left=900 ,top=1759 ,right=1101 ,bottom=1831 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1400 ,top=1479 ,right=1601 ,bottom=1550 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1인당 300만원' ,left=1400 ,top=1550 ,right=1601 ,bottom=1619 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1인당 300만원' ,left=1400 ,top=1619 ,right=1601 ,bottom=1691 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1인당 900만원' ,left=1400 ,top=1691 ,right=1601 ,bottom=1759 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1400 ,top=1759 ,right=1601 ,bottom=1831 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='교육비 계' ,left=299 ,top=1831 ,right=900 ,bottom=1921 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주택임차차입금' ,left=299 ,top=1921 ,right=900 ,bottom=1990 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='월세금' ,left=299 ,top=1990 ,right=900 ,bottom=2061 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='장기주택저당차입금' ,left=299 ,top=2061 ,right=900 ,bottom=2130 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='원리금상환액' ,left=900 ,top=1921 ,right=1101 ,bottom=1990 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지출액' ,left=900 ,top=1990 ,right=1101 ,bottom=2061 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이자상환액' ,left=900 ,top=2061 ,right=1101 ,bottom=2130 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법참조' ,left=1400 ,top=1921 ,right=1601 ,bottom=1990 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법참조' ,left=1400 ,top=1990 ,right=1601 ,bottom=2061 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법참조' ,left=1400 ,top=2061 ,right=1601 ,bottom=2130 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주택자금 공제액 계' ,left=299 ,top=2130 ,right=900 ,bottom=2220 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='정치자금기부금(세액공제분 제외)' ,left=299 ,top=2220 ,right=900 ,bottom=2291 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='법정 기부금' ,left=299 ,top=2291 ,right=900 ,bottom=2360 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특례기부금(공익법인신탁 제외)' ,left=299 ,top=2360 ,right=900 ,bottom=2429 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공익법인신탁 특례기부금' ,left=299 ,top=2429 ,right=900 ,bottom=2500 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='우리사주조합 기부금' ,left=299 ,top=2500 ,right=900 ,bottom=2569 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종교단체 외 지정기부금' ,left=299 ,top=2569 ,right=900 ,bottom=2641 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종교단체 지정기부금' ,left=299 ,top=2641 ,right=900 ,bottom=2709 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금공제액 계' ,left=299 ,top=2709 ,right=900 ,bottom=2799 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금액' ,left=900 ,top=2220 ,right=1101 ,bottom=2291 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금액' ,left=900 ,top=2291 ,right=1101 ,bottom=2360 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금액' ,left=900 ,top=2360 ,right=1101 ,bottom=2429 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금액' ,left=900 ,top=2500 ,right=1101 ,bottom=2569 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금액' ,left=900 ,top=2569 ,right=1101 ,bottom=2641 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금액' ,left=900 ,top=2641 ,right=1101 ,bottom=2709 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법참조' ,left=1400 ,top=2220 ,right=1601 ,bottom=2799 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ⅲ.' ,left=37 ,top=1400 ,right=98 ,bottom=1500 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특' ,left=37 ,top=1500 ,right=98 ,bottom=1601 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='별' ,left=37 ,top=1601 ,right=98 ,bottom=1701 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=37 ,top=1701 ,right=98 ,bottom=1799 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=37 ,top=1799 ,right=98 ,bottom=1900 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='210㎜x297㎜' ,left=1299 ,top=2805 ,right=1889 ,bottom=2839 ,align='right'</T>
	<C>id='{decode(BPENAMT01,0,,BPENAMT01)}', left=1106, top=243, right=1397, bottom=291, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CPENAMT01,0,,CPENAMT01)}', left=1106, top=315, right=1397, bottom=362, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BPENAMT02,0,,BPENAMT02)}', left=1106, top=381, right=1397, bottom=429, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CPENAMT02,0,,CPENAMT02)}', left=1106, top=447, right=1397, bottom=495, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BPENAMT03,0,,BPENAMT03)}', left=1106, top=521, right=1397, bottom=569, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CPENAMT03,0,,CPENAMT03)}', left=1106, top=593, right=1397, bottom=640, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PENSUM,0,,PENSUM)}', left=1106, top=675, right=1397, bottom=722, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BINSAMT01,0,,BINSAMT01)}', left=1106, top=757, right=1397, bottom=804, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CINSAMT01,0,,CINSAMT01)}', left=1106, top=826, right=1397, bottom=873, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BINSAMT02,0,,BINSAMT02)}', left=1106, top=894, right=1397, bottom=942, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CINSAMT02,0,,CINSAMT02)}', left=1106, top=960, right=1397, bottom=1008, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT03,0,,INSAMT03)}', left=1106, top=1032, right=1397, bottom=1080, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSAMT04,0,,INSAMT04)}', left=1106, top=1101, right=1397, bottom=1148, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INSSUM,0,,INSSUM)}', left=1106, top=1180, right=1397, bottom=1228, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(MEDAMT01,0,,MEDAMT01)}', left=1106, top=1259, right=1397, bottom=1307, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(MEDAMT02,0,,MEDAMT02)}', left=1106, top=1331, right=1397, bottom=1378, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(MEDSUM,0,,MEDSUM)}', left=1106, top=1410, right=1397, bottom=1458, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDUAMT01,0,,EDUAMT01)}', left=1106, top=1492, right=1397, bottom=1540, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDUAMT02,0,,EDUAMT02)}', left=1106, top=1561, right=1397, bottom=1609, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDUAMT03,0,,EDUAMT03)}', left=1106, top=1632, right=1397, bottom=1680, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDUAMT04,0,,EDUAMT04)}', left=1106, top=1701, right=1397, bottom=1749, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDUAMT05,0,,EDUAMT05)}', left=1106, top=1770, right=1397, bottom=1818, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDUSUM,0,,EDUSUM)}', left=1106, top=1852, right=1397, bottom=1900, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT01,0,,HOUAMT01)}', left=1106, top=1931, right=1397, bottom=1979, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUAMT02,0,,HOUAMT02)}', left=1106, top=2003, right=1397, bottom=2051, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HOUSUM,0,,HOUSUM)}', left=1106, top=2072, right=1397, bottom=2119, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONAMT01,0,,CONAMT01)}', left=1106, top=2233, right=1397, bottom=2281, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONAMT02,0,,CONAMT02)}', left=1106, top=2305, right=1397, bottom=2352, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONAMT03,0,,CONAMT03)}', left=1106, top=2373, right=1397, bottom=2421, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONAMT04,0,,CONAMT04)}', left=1106, top=2442, right=1397, bottom=2490, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONAMT05,0,,CONAMT05)}', left=1106, top=2514, right=1397, bottom=2561, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONAMT06,0,,CONAMT06)}', left=1106, top=2580, right=1397, bottom=2627, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONAMT07,0,,CONAMT07)}', left=1106, top=2656, right=1397, bottom=2704, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=') 명' ,left=648 ,top=1550 ,right=799 ,bottom=1619 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(EDUCNT02,0,,EDUCNT02)}', left=661, top=1561, right=741, bottom=1609, face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=') 명' ,left=654 ,top=1619 ,right=799 ,bottom=1691 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=') 명' ,left=651 ,top=1691 ,right=799 ,bottom=1759 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=') 명' ,left=651 ,top=1759 ,right=799 ,bottom=1831 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(EDUCNT03,0,,EDUCNT03)}', left=661, top=1632, right=741, bottom=1680, face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDUCNT04,0,,EDUCNT04)}', left=661, top=1696, right=741, bottom=1744, face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDUCNT05,0,,EDUCNT05)}', left=661, top=1770, right=741, bottom=1818, face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='유치원비' ,left=900 ,top=1550 ,right=1101 ,bottom=1593 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='외의 연금보험료' ,left=299 ,top=442 ,right=601 ,bottom=492 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국민연금보험료' ,left=299 ,top=392 ,right=601 ,bottom=442 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(노인장기요양보험 포함)' ,left=299 ,top=810 ,right=601 ,bottom=860 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국민건강보험' ,left=299 ,top=759 ,right=601 ,bottom=810 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
</R>
</A>

<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='3쪽.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='ds_print'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2712 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=29 ,top=130 ,right=29 ,bottom=2799 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=2799 ,right=1900 ,bottom=2799 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=130 ,right=1900 ,bottom=130 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1900 ,top=130 ,right=1900 ,bottom=2799 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=180 ,right=1900 ,bottom=180 </L>
	<L> left=299 ,top=230 ,right=1900 ,bottom=230 </L>
	<L> left=299 ,top=280 ,right=1900 ,bottom=280 </L>
	<L> left=101 ,top=331 ,right=1900 ,bottom=331 </L>
	<L> left=101 ,top=381 ,right=1900 ,bottom=381 </L>
	<L> left=299 ,top=431 ,right=1900 ,bottom=431 </L>
	<L> left=299 ,top=479 ,right=1900 ,bottom=479 </L>
	<L> left=299 ,top=529 ,right=1900 ,bottom=529 </L>
	<L> left=299 ,top=579 ,right=1900 ,bottom=579 </L>
	<L> left=101 ,top=630 ,right=1900 ,bottom=630 </L>
	<L> left=299 ,top=680 ,right=1900 ,bottom=680 </L>
	<L> left=299 ,top=730 ,right=1900 ,bottom=730 </L>
	<L> left=101 ,top=781 ,right=1900 ,bottom=781 </L>
	<L> left=299 ,top=831 ,right=1900 ,bottom=831 </L>
	<L> left=299 ,top=881 ,right=1900 ,bottom=881 </L>
	<L> left=299 ,top=929 ,right=1900 ,bottom=929 </L>
	<L> left=299 ,top=979 ,right=1900 ,bottom=979 </L>
	<L> left=101 ,top=1029 ,right=1900 ,bottom=1029 </L>
	<L> left=101 ,top=1080 ,right=1900 ,bottom=1080 </L>
	<L> left=799 ,top=1130 ,right=1299 ,bottom=1130 </L>
	<L> left=799 ,top=1180 ,right=1299 ,bottom=1180 </L>
	<L> left=799 ,top=1230 ,right=1900 ,bottom=1230 </L>
	<L> left=1601 ,top=1130 ,right=1900 ,bottom=1130 </L>
	<L> left=1601 ,top=1180 ,right=1900 ,bottom=1180 </L>
	<L> left=101 ,top=1281 ,right=1900 ,bottom=1281 </L>
	<L> left=101 ,top=1331 ,right=1900 ,bottom=1331 </L>
	<L> left=29 ,top=1381 ,right=1900 ,bottom=1381 </L>
	<L> left=101 ,top=1429 ,right=1900 ,bottom=1429 </L>
	<L> left=799 ,top=1479 ,right=1900 ,bottom=1479 </L>
	<L> left=799 ,top=1529 ,right=1900 ,bottom=1529 </L>
	<L> left=799 ,top=1580 ,right=1900 ,bottom=1580 </L>
	<L> left=799 ,top=1630 ,right=1900 ,bottom=1630 </L>
	<L> left=799 ,top=1680 ,right=1900 ,bottom=1680 </L>
	<L> left=299 ,top=1730 ,right=1900 ,bottom=1730 </L>
	<L> left=299 ,top=1781 ,right=1900 ,bottom=1781 </L>
	<L> left=101 ,top=1831 ,right=1900 ,bottom=1831 </L>
	<L> left=299 ,top=1881 ,right=1900 ,bottom=1881 </L>
	<L> left=299 ,top=1929 ,right=1900 ,bottom=1929 </L>
	<L> left=29 ,top=1979 ,right=1900 ,bottom=1979 </L>
	<L> left=29 ,top=2199 ,right=1900 ,bottom=2199 </L>
	<L> left=29 ,top=2249 ,right=1900 ,bottom=2249 </L>
	<L> left=29 ,top=2299 ,right=1900 ,bottom=2299 </L>
	<L> left=299 ,top=2350 ,right=1500 ,bottom=2350 </L>
	<L> left=29 ,top=2400 ,right=1900 ,bottom=2400 </L>
	<L> left=29 ,top=2519 ,right=1900 ,bottom=2519 </L>
	<L> left=29 ,top=2569 ,right=1900 ,bottom=2569 </L>
	<L> left=101 ,top=180 ,right=101 ,bottom=1979 </L>
	<L> left=299 ,top=130 ,right=299 ,bottom=331 </L>
	<L> left=299 ,top=381 ,right=299 ,bottom=1029 </L>
	<L> left=299 ,top=1429 ,right=299 ,bottom=1979 </L>
	<L> left=299 ,top=2299 ,right=299 ,bottom=2400 </L>
	<L> left=601 ,top=1831 ,right=601 ,bottom=1881 </L>
	<L> left=550 ,top=2299 ,right=550 ,bottom=2400 </L>
	<L> left=799 ,top=130 ,right=799 ,bottom=1831 </L>
	<L> left=799 ,top=1881 ,right=799 ,bottom=1979 </L>
	<L> left=550 ,top=2519 ,right=550 ,bottom=2569 </L>
	<L> left=1000 ,top=130 ,right=1000 ,bottom=1381 </L>
	<L> left=1000 ,top=1429 ,right=1000 ,bottom=1831 </L>
	<L> left=1000 ,top=1881 ,right=1000 ,bottom=1979 </L>
	<L> left=900 ,top=2299 ,right=900 ,bottom=2519 </L>
	<L> left=1101 ,top=2299 ,right=1101 ,bottom=2400 </L>
	<L> left=1299 ,top=130 ,right=1299 ,bottom=1831 </L>
	<L> left=1299 ,top=1881 ,right=1299 ,bottom=1979 </L>
	<L> left=1601 ,top=130 ,right=1601 ,bottom=1831 </L>
	<L> left=1601 ,top=1929 ,right=1601 ,bottom=1979 </L>
	<L> left=1500 ,top=2249 ,right=1500 ,bottom=2400 </L>
	<X>left=849 ,top=1839 ,right=881 ,bottom=1871 ,border=true</X>
	<X>left=1461 ,top=1839 ,right=1490 ,bottom=1871 ,border=true</X>
	<X>left=799 ,top=280 ,right=1000 ,bottom=331 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1000 ,top=280 ,right=1299 ,bottom=331 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1299 ,top=280 ,right=1601 ,bottom=331 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=799 ,top=579 ,right=1000 ,bottom=630 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1299 ,top=579 ,right=1601 ,bottom=630 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=799 ,top=730 ,right=1000 ,bottom=781 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1299 ,top=730 ,right=1601 ,bottom=781 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1601 ,top=730 ,right=1900 ,bottom=781 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1299 ,top=781 ,right=1601 ,bottom=831 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1601 ,top=781 ,right=1900 ,bottom=831 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1299 ,top=831 ,right=1601 ,bottom=881 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1601 ,top=831 ,right=1900 ,bottom=881 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1299 ,top=881 ,right=1601 ,bottom=929 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1601 ,top=881 ,right=1900 ,bottom=929 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=799 ,top=929 ,right=1000 ,bottom=979 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1299 ,top=929 ,right=1601 ,bottom=979 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1601 ,top=929 ,right=1900 ,bottom=979 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=799 ,top=979 ,right=1000 ,bottom=1029 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1299 ,top=979 ,right=1601 ,bottom=1029 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1299 ,top=1230 ,right=1601 ,bottom=1281 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1299 ,top=1429 ,right=1601 ,bottom=1479 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1601 ,top=1429 ,right=1900 ,bottom=1479 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1299 ,top=1479 ,right=1601 ,bottom=1529 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1601 ,top=1479 ,right=1900 ,bottom=1529 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='(3쪽)' ,left=1738 ,top=71 ,right=1892 ,bottom=132 ,align='right'</T>
	<T>id='구분' ,left=29 ,top=130 ,right=299 ,bottom=180 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지출명세' ,left=299 ,top=130 ,right=900 ,bottom=180 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지출구분' ,left=799 ,top=130 ,right=1000 ,bottom=180 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금액' ,left=1000 ,top=130 ,right=1299 ,bottom=180 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='한도액' ,left=1299 ,top=130 ,right=1601 ,bottom=180 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제액' ,left=1601 ,top=130 ,right=1900 ,bottom=180 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ⅳ.' ,left=37 ,top=550 ,right=98 ,bottom=601 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='그' ,left=37 ,top=601 ,right=98 ,bottom=651 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='밖' ,left=37 ,top=651 ,right=98 ,bottom=701 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의' ,left=37 ,top=701 ,right=98 ,bottom=749 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소' ,left=37 ,top=749 ,right=98 ,bottom=799 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='득' ,left=37 ,top=799 ,right=98 ,bottom=849 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=37 ,top=849 ,right=98 ,bottom=900 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=37 ,top=900 ,right=98 ,bottom=950 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연금저축공제' ,left=101 ,top=180 ,right=299 ,bottom=331 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2000년 이전 가입한 개인연금저축' ,left=299 ,top=180 ,right=799 ,bottom=230 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납입금액' ,left=799 ,top=180 ,right=1000 ,bottom=230 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='불입액40%와72만원' ,left=1299 ,top=180 ,right=1601 ,bottom=230 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2001년 이후 가입한 연금저축' ,left=299 ,top=230 ,right=799 ,bottom=280 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납입금액' ,left=799 ,top=230 ,right=1000 ,bottom=280 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1299 ,top=230 ,right=1601 ,bottom=280 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연금저축공제 계' ,left=299 ,top=280 ,right=799 ,bottom=331 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소기업ㆍ소상공인 공제부금 소득공제' ,left=101 ,top=331 ,right=799 ,bottom=381 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='불입금액' ,left=799 ,top=331 ,right=1000 ,bottom=381 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1299 ,top=331 ,right=1601 ,bottom=381 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주택마련' ,left=101 ,top=431 ,right=299 ,bottom=479 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='저축' ,left=101 ,top=479 ,right=299 ,bottom=529 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득공제' ,left=101 ,top=529 ,right=299 ,bottom=579 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='청약저축' ,left=299 ,top=381 ,right=799 ,bottom=431 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납입금액' ,left=799 ,top=381 ,right=1000 ,bottom=431 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1299 ,top=381 ,right=1601 ,bottom=431 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근로자주택마련저축' ,left=299 ,top=431 ,right=799 ,bottom=479 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납입금액' ,left=799 ,top=431 ,right=1000 ,bottom=479 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1299 ,top=431 ,right=1601 ,bottom=479 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주택청약종합저축' ,left=299 ,top=479 ,right=799 ,bottom=529 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납입금액' ,left=799 ,top=479 ,right=1000 ,bottom=529 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1299 ,top=479 ,right=1601 ,bottom=529 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='장기주택마련저축' ,left=299 ,top=529 ,right=799 ,bottom=579 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납입금액' ,left=799 ,top=529 ,right=1000 ,bottom=579 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1299 ,top=529 ,right=1601 ,bottom=579 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주택마련저축 소득공제 계' ,left=299 ,top=579 ,right=799 ,bottom=630 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='투자조합' ,left=101 ,top=659 ,right=299 ,bottom=701 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출자공제' ,left=101 ,top=701 ,right=299 ,bottom=781 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2008년 이전 출자ㆍ투자분' ,left=299 ,top=630 ,right=799 ,bottom=680 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출자ㆍ투자분' ,left=799 ,top=630 ,right=1000 ,bottom=680 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1299 ,top=630 ,right=1601 ,bottom=680 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2009년 이후 출자ㆍ투자분' ,left=299 ,top=680 ,right=799 ,bottom=730 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출자ㆍ투자분' ,left=799 ,top=680 ,right=1000 ,bottom=730 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1299 ,top=680 ,right=1601 ,bottom=730 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='투자조합 출자공제 계' ,left=299 ,top=730 ,right=799 ,bottom=781 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='신용카드 등' ,left=101 ,top=831 ,right=299 ,bottom=881 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사용액' ,left=101 ,top=881 ,right=299 ,bottom=929 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득공제' ,left=101 ,top=929 ,right=299 ,bottom=979 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='①신용카드' ,left=299 ,top=781 ,right=799 ,bottom=831 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사용금액' ,left=799 ,top=781 ,right=1000 ,bottom=831 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='②직불카드 등' ,left=299 ,top=831 ,right=799 ,bottom=881 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사용금액' ,left=799 ,top=831 ,right=1000 ,bottom=881 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③현금영수증' ,left=299 ,top=881 ,right=799 ,bottom=929 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사용금액' ,left=799 ,top=881 ,right=1000 ,bottom=929 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='④학원비 지로납부' ,left=299 ,top=929 ,right=799 ,bottom=979 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계(①+②+③+④)' ,left=299 ,top=979 ,right=799 ,bottom=1029 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='우리사주 출연금 소득공제' ,left=101 ,top=1029 ,right=799 ,bottom=1080 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출연금액' ,left=799 ,top=1029 ,right=1000 ,bottom=1080 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1299 ,top=1029 ,right=1601 ,bottom=1080 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='장기주식형저축소득공제' ,left=101 ,top=1080 ,right=799 ,bottom=1281 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='①납입 1년차' ,left=799 ,top=1080 ,right=1000 ,bottom=1130 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='②납입 2년차' ,left=799 ,top=1130 ,right=1000 ,bottom=1180 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③납입 3년차' ,left=799 ,top=1180 ,right=1000 ,bottom=1230 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납입합계' ,left=799 ,top=1230 ,right=1000 ,bottom=1281 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제액=' ,left=1299 ,top=1080 ,right=1601 ,bottom=1130 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(①x20%+②x10%' ,left=1299 ,top=1130 ,right=1601 ,bottom=1180 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='+③x5%)' ,left=1299 ,top=1180 ,right=1601 ,bottom=1230 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='고용유지중소기업 근로자 소득공제' ,left=101 ,top=1281 ,right=799 ,bottom=1331 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='임금삭감액' ,left=799 ,top=1281 ,right=1000 ,bottom=1331 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1299 ,top=1281 ,right=1601 ,bottom=1331 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타(                                           )' ,left=101 ,top=1331 ,right=799 ,bottom=1381 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ⅴ.' ,left=37 ,top=1601 ,right=98 ,bottom=1651 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=37 ,top=1651 ,right=98 ,bottom=1701 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='액' ,left=37 ,top=1701 ,right=98 ,bottom=1749 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=37 ,top=1749 ,right=98 ,bottom=1799 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=37 ,top=1799 ,right=98 ,bottom=1849 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공 제 종 류' ,left=101 ,top=1381 ,right=799 ,bottom=1429 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내               역' ,left=799 ,top=1381 ,right=1299 ,bottom=1429 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제율' ,left=1299 ,top=1381 ,right=1601 ,bottom=1429 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세액공제' ,left=101 ,top=1429 ,right=299 ,bottom=1831 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='외국납부세액' ,left=299 ,top=1429 ,right=799 ,bottom=1730 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>

	<T>id='국외원천소득' ,left=799 ,top=1429 ,right=1000 ,bottom=1479 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납세액(외화)' ,left=799 ,top=1479 ,right=1000 ,bottom=1529 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납세액(원화)' ,left=799 ,top=1580 ,right=1000 ,bottom=1529 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='-' ,left=1299 ,top=1529 ,right=1601 ,bottom=1580 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납세국명' ,left=799 ,top=1580 ,right=1000 ,bottom=1630 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납부일' ,left=1299 ,top=1580 ,right=1601 ,bottom=1630 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='신청서제출일' ,left=799 ,top=1630 ,right=1000 ,bottom=1680 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국외근무처' ,left=1299 ,top=1630 ,right=1601 ,bottom=1680 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근무기간' ,left=799 ,top=1680 ,right=1000 ,bottom=1730 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직책' ,left=1299 ,top=1680 ,right=1601 ,bottom=1730 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주택자금차입금이자세액공제' ,left=299 ,top=1730 ,right=799 ,bottom=1781 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이자상환액' ,left=799 ,top=1730 ,right=1000 ,bottom=1781 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30%' ,left=1299 ,top=1730 ,right=1601 ,bottom=1781 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부정치자금' ,left=299 ,top=1781 ,right=799 ,bottom=1831 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10만원 이하' ,left=799 ,top=1781 ,right=1000 ,bottom=1831 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='100/110' ,left=1299 ,top=1781 ,right=1601 ,bottom=1831 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='외국인' ,left=101 ,top=1849 ,right=299 ,bottom=1900 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근로자' ,left=101 ,top=1900 ,right=299 ,bottom=1950 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='입국목적' ,left=299 ,top=1831 ,right=601 ,bottom=1881 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='정부간 협약' ,left=900 ,top=1831 ,right=1050 ,bottom=1881 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기술도입계약' ,left=1191 ,top=1831 ,right=1410 ,bottom=1881 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기술도입계약 또는 근로제공일' ,left=299 ,top=1881 ,right=799 ,bottom=1929 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='감면기간만료일' ,left=1000 ,top=1881 ,right=1299 ,bottom=1929 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='외국인근로소득에 대한 감면신청서' ,left=299 ,top=1929 ,right=799 ,bottom=1979 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='접수일' ,left=799 ,top=1929 ,right=1000 ,bottom=1979 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제출일' ,left=1299 ,top=1929 ,right=1601 ,bottom=1979 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       신고인은 「소득세법」 제140조에 따라 위의 내용을 신고하며, 위 내용을 충분히 검토하였고 신고인이 알고 있는 사실 그대로를 정확하게 ' ,left=40 ,top=2000 ,right=1900 ,bottom=2090 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       적었음을 확인합니다.' ,left=40 ,top=2090 ,right=1900 ,bottom=2130 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     년        월          일' ,left=1201 ,top=2080 ,right=1900 ,bottom=2151 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='신고인' ,left=1000 ,top=2130 ,right=1241 ,bottom=2180 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(서명 또는 인)' ,left=1601 ,top=2130 ,right=1881 ,bottom=2180 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ⅵ. 추가 제출 서류' ,left=29 ,top=2199 ,right=299 ,bottom=2249 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  1. 외국인근로자 단일세율적용신청서 제출 여부( O 또는 X 로 적습니다)' ,left=29 ,top=2249 ,right=921 ,bottom=2299 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제 출 (        )' ,left=1601 ,top=2249 ,right=1900 ,bottom=2299 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  2. 종(전)근무지명세' ,left=29 ,top=2299 ,right=299 ,bottom=2400 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)근무지명' ,left=299 ,top=2299 ,right=550 ,bottom=2350 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)급여총액' ,left=900 ,top=2299 ,right=1101 ,bottom=2350 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사업자등록번호' ,left=299 ,top=2350 ,right=550 ,bottom=2400 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)결정세액' ,left=900 ,top=2350 ,right=1101 ,bottom=2400 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)근무지 근로소득' ,left=1500 ,top=2299 ,right=1900 ,bottom=2350 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='원천징수영수증 제출(        )' ,left=1500 ,top=2350 ,right=1900 ,bottom=2400 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  3. 연금ㆍ저축 등 소득공제 명세서 제출여부' ,left=29 ,top=2400 ,right=900 ,bottom=2461 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ( O 또는 X 로 적습니다)' ,left=29 ,top=2461 ,right=900 ,bottom=2519 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  3. 연금ㆍ저축 등 소득공제 명세서 제출여부' ,left=900 ,top=2400 ,right=1900 ,bottom=2439 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ( O 또는 X 로 적습니다)' ,left=900 ,top=2439 ,right=1900 ,bottom=2479 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ( O 또는 X 로 적습니다)' ,left=900 ,top=2479 ,right=1900 ,bottom=2519 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  4. 그 밖의 추가 제출 서류' ,left=29 ,top=2519 ,right=550 ,bottom=2569 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ① 의료비지급명세서 (   ),           ② 기부금명세서 (   ),          ③ 소득공제 증빙서류' ,left=550 ,top=2519 ,right=1900 ,bottom=2569 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ※ 근로소득자 참고사항' ,left=40 ,top=2580 ,right=1900 ,bottom=2619 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     1. 근로소득자가 종(전)근무지 근로소득을 원천징수의무자에게 신고하지 아니하는 경우에는 근로소득자 본인이 종합소득세 신고를 하여야 하며,' ,left=40 ,top=2619 ,right=1900 ,bottom=2664 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     신고하지 아니한 경우 가산세 부과 등 불이익이 따릅니다.' ,left=40 ,top=2664 ,right=1900 ,bottom=2709 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     2. 현 근무지의 연금보험료ㆍ국민건강보험료 및 고용보험료 등은 신고인이 작성하지 아니하여도 됩니다.' ,left=40 ,top=2709 ,right=1900 ,bottom=2754 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     3. 공제금액란은 근로소득자가 원천징수의무자에게 제출하는 경우 적지 아니할 수 있습니다.' ,left=40 ,top=2754 ,right=1900 ,bottom=2799 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='210㎜x297㎜' ,left=1299 ,top=2805 ,right=1889 ,bottom=2839 ,align='right'</T>
	<C>id='{decode(PESAMT01,0,,PESAMT01)}', left=1005, top=183, right=1296, bottom=230, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PESAMT02,0,,PESAMT02)}', left=1005, top=233, right=1296, bottom=280, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SAVAMT01,0,,SAVAMT01)}', left=1005, top=384, right=1296, bottom=431, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SAVAMT02,0,,SAVAMT02)}', left=1005, top=434, right=1296, bottom=482, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SAVAMT03,0,,SAVAMT03)}', left=1005, top=482, right=1296, bottom=529, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SAVAMT04,0,,SAVAMT04)}', left=1005, top=532, right=1296, bottom=579, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SAVSUM,0,,SAVSUM)}', left=1005, top=582, right=1296, bottom=630, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CRDAMT01,0,,CRDAMT01)}', left=1005, top=783, right=1296, bottom=831, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CRDAMT02,0,,CRDAMT02)}', left=1005, top=833, right=1296, bottom=881, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CRDAMT03,0,,CRDAMT03)}', left=1005, top=884, right=1296, bottom=931, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CRDAMT04,0,,CRDAMT04)}', left=1005, top=931, right=1296, bottom=979, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CRDSUM,0,,CRDSUM)}', left=1005, top=982, right=1296, bottom=1029, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FORPAYAMT,0,,FORPAYAMT)}', left=1005, top=1431, right=1296, bottom=1479, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CONAMT99,0,,CONAMT99)}', left=1005, top=1783, right=1296, bottom=1831, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FNDAMT03,0,,FNDAMT03)}', left=1005, top=1183, right=1296, bottom=1230, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FNDAMT02,0,,FNDAMT02)}', left=1005, top=1132, right=1296, bottom=1180, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FNDSUM,0,,FNDSUM)}', left=1005, top=1233, right=1296, bottom=1281, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(FNDAMT01,0,,FNDAMT01)}', left=1005, top=1082, right=1296, bottom=1130, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='「조세특례제한법」상 감면' ,left=1500 ,top=1831 ,right=1865 ,bottom=1881 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=1159 ,top=1839 ,right=1191 ,bottom=1871 ,border=true</X>
	<C>id='{decode(TAXAMT01,0,,TAXAMT01)}', left=1005, top=1482, right=1296, bottom=1529, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAXPAYDT', left=1606, top=1582, right=1897, bottom=1630, align='left' ,mask='XXXX/XX/XX', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TAXAMT02,0,,TAXAMT02)}', left=1005, top=1532, right=1296, bottom=1580, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAXNATION', left=1005, top=1582, right=1296, bottom=1630, align='left', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAXAPPDT', left=1005, top=1632, right=1296, bottom=1680, align='left' ,mask='XXXX/XX/XX', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FORPLACE', left=1606, top=1632, right=1897, bottom=1680, align='left', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FORJOB', left=1606, top=1683, right=1897, bottom=1730, align='left', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='WKNM', left=556, top=2302, right=894, bottom=2350, align='left', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='WKRESINO', left=556, top=2352, right=894, bottom=2400, align='left', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF ,mask='XXX-XX-XXXXX'</C>
	<C>id='{decode(BP10SUM,0,,BP10SUM)}', left=1106, top=2302, right=1495, bottom=2350, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(BP41000,0,,BP41000)}', left=1106, top=2352, right=1495, bottom=2400, align='right', face='굴림', size=8,  forecolor=#000000, backcolor=#FFFFFF</C>
</B>
</R>
</A>

<A>id=Area4 ,left=0,top=0 ,right=2000 ,bottom=180
<R>id='7쪽.sbt' ,left=0 ,top=20 ,right=2000 ,bottom=151, DetailDataID='ds_print'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=201 ,face='굴림' ,size=10 ,penwidth=1

<L> left=30 ,top=130 ,right=1900 ,bottom=130 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
<L> left=30 ,top=2800 ,right=1900 ,bottom=2800 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
<L> left=30 ,top=130 ,right=30 ,bottom=2800 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
<L> left=1900 ,top=130 ,right=1900 ,bottom=2800 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>

<L> left=30 ,top=250 ,right=1900 ,bottom=250 </L>
<L> left=30 ,top=350 ,right=1900 ,bottom=350 </L>
<L> left=30 ,top=430 ,right=1900 ,bottom=430 </L>
<L> left=30 ,top=510 ,right=1900 ,bottom=510 </L>
<L> left=30 ,top=610 ,right=1900 ,bottom=610 </L>
<L> left=30 ,top=710 ,right=1900 ,bottom=710 </L>

<L> left=30 ,top=810 ,right=1900 ,bottom=810 </L>
<L> left=30 ,top=870 ,right=1900 ,bottom=870 </L>
<L> left=30 ,top=930 ,right=1900 ,bottom=930 </L>
<L> left=30 ,top=990 ,right=1900 ,bottom=990 </L>
<L> left=30 ,top=1050 ,right=1900 ,bottom=1050 </L>

<L> left=30 ,top=1150 ,right=1900 ,bottom=1150 </L>
<L> left=30 ,top=1210 ,right=1900 ,bottom=1210 </L>
<L> left=30 ,top=1270 ,right=1900 ,bottom=1270 </L>
<L> left=30 ,top=1330 ,right=1900 ,bottom=1330 </L>
<L> left=30 ,top=1390 ,right=1900 ,bottom=1390 </L>
<L> left=30 ,top=1450 ,right=1900 ,bottom=1450 </L>
<L> left=30 ,top=1510 ,right=1900 ,bottom=1510 </L>


<L> left=30 ,top=1610 ,right=1900 ,bottom=1610 </L>
<L> left=30 ,top=1670 ,right=1900 ,bottom=1670 </L>
<L> left=30 ,top=1730 ,right=1900 ,bottom=1730 </L>
<L> left=30 ,top=1790 ,right=1900 ,bottom=1790 </L>
<L> left=30 ,top=1850 ,right=1900 ,bottom=1850 </L>
<L> left=30 ,top=1910 ,right=1900 ,bottom=1910 </L>
<L> left=30 ,top=1970 ,right=1900 ,bottom=1970 </L>


<L> left=30 ,top=2070 ,right=1900 ,bottom=2070 </L>
<L> left=30 ,top=2130 ,right=1900 ,bottom=2130 </L>
<L> left=30 ,top=2190 ,right=1900 ,bottom=2190 </L>
<L> left=30 ,top=2250 ,right=1900 ,bottom=2250 </L>
<L> left=30 ,top=2310 ,right=1900 ,bottom=2310 </L>
<L> left=30 ,top=2370 ,right=1900 ,bottom=2370 </L>


<L> left=750 ,top=350 ,right=750 ,bottom=510 </L>

<L> left=1228 ,top=350 ,right=1228 ,bottom=510 </L>
<L> left=1284 ,top=350 ,right=1284 ,bottom=430 </L>
<L> left=1340 ,top=350 ,right=1340 ,bottom=430 </L>
<L> left=1396 ,top=350 ,right=1396 ,bottom=430 </L>
<L> left=1452 ,top=350 ,right=1452 ,bottom=430 </L>
<L> left=1508 ,top=350 ,right=1508 ,bottom=430 </L>
<L> left=1564 ,top=350 ,right=1564 ,bottom=430 </L>
<L> left=1620 ,top=350 ,right=1620 ,bottom=430 </L>
<L> left=1676 ,top=350 ,right=1676 ,bottom=430 </L>
<L> left=1732 ,top=350 ,right=1732 ,bottom=430 </L>
<L> left=1788 ,top=350 ,right=1788 ,bottom=430 </L>
<L> left=1844 ,top=350 ,right=1844 ,bottom=430 </L>

<L> left=1276 ,top=430 ,right=1276 ,bottom=510 </L>
<L> left=1324 ,top=430 ,right=1324 ,bottom=510 </L>
<L> left=1372 ,top=430 ,right=1372 ,bottom=510 </L>
<L> left=1420 ,top=430 ,right=1420 ,bottom=510 </L>
<L> left=1468 ,top=430 ,right=1468 ,bottom=510 </L>
<L> left=1516 ,top=430 ,right=1516 ,bottom=510 </L>
<L> left=1564 ,top=430 ,right=1564 ,bottom=510 </L>
<L> left=1612 ,top=430 ,right=1612 ,bottom=510 </L>
<L> left=1660 ,top=430 ,right=1660 ,bottom=510 </L>
<L> left=1708 ,top=430 ,right=1708 ,bottom=510 </L>
<L> left=1756 ,top=430 ,right=1756 ,bottom=510 </L>
<L> left=1804 ,top=430 ,right=1804 ,bottom=510 </L>
<L> left=1852 ,top=430 ,right=1852 ,bottom=510 </L>

<L> left=300 ,top=350 ,right=300 ,bottom=710 </L>
<L> left=300 ,top=810 ,right=300 ,bottom=1050 </L>
<L> left=300 ,top=1150 ,right=300 ,bottom=1510 </L>
<L> left=300 ,top=1610 ,right=300 ,bottom=1970 </L>
<L> left=600 ,top=2070 ,right=600 ,bottom=2370 </L>

<L> left=850 ,top=810 ,right=850 ,bottom=1050 </L>
<L> left=850 ,top=1150 ,right=850 ,bottom=1510 </L>
<L> left=850 ,top=1610 ,right=850 ,bottom=1970 </L>
<L> left=1000 ,top=2070 ,right=1000 ,bottom=2370 </L>

<L> left=1300 ,top=810 ,right=1300 ,bottom=1050 </L>
<L> left=1300 ,top=1150 ,right=1300 ,bottom=1510 </L>
<L> left=1300 ,top=1610 ,right=1300 ,bottom=1970 </L>
<L> left=1300 ,top=2070 ,right=1300 ,bottom=2370 </L>

<L> left=1600 ,top=810 ,right=1600 ,bottom=1050 </L>
<L> left=1600 ,top=1150 ,right=1600 ,bottom=1510 </L>
<L> left=1600 ,top=1610 ,right=1600 ,bottom=1970 </L>
<L> left=1600 ,top=2070 ,right=1600 ,bottom=2370 </L>




<C>id='EMPNMK', left=300, top=430, right=750, bottom=510, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>

<C>id='ADDRESS', left=310, top=510, right=1900, bottom=610, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>

<C>id='TELNO', left=1564, top=510, right=1852, bottom=610, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>


<C>id='EMPJUNO1', left=1228, top=430, right=1276, bottom=510, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO2', left=1276, top=430, right=1324, bottom=510, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO3', left=1324, top=430, right=1372, bottom=510, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO4', left=1372, top=430, right=1420, bottom=510, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO5', left=1420, top=430, right=1468, bottom=510, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO6', left=1468, top=430, right=1516, bottom=510, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<T>id='-' ,left=1516 ,top=430 ,right=1564 ,bottom=510 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<C>id='EMPJUNO7', left=1564, top=430, right=1612, bottom=510, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO8', left=1612, top=430, right=1660, bottom=510, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO9', left=1660, top=430, right=1708, bottom=510, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO10', left=1708, top=430, right=1756, bottom=510, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO11', left=1756, top=430, right=1804, bottom=510, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO12', left=1804, top=430, right=1852, bottom=510, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>
<C>id='EMPJUNO13', left=1852, top=430, right=1900, bottom=510, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF</C>


<C>id='DUDGBNM1_1', left=30, top=870, right=300, bottom=930, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM1_1', left=300, top=870, right=850, bottom=930, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO1_1', left=850, top=870, right=1300, bottom=930, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT1_1,0,,PAYAMT1_1)}', left=1300, top=870, right=1600, bottom=930, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT1_1,0,,DEDAMT1_1)}', left=1600, top=870, right=1900, bottom=930, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM1_2', left=30, top=930, right=300, bottom=990, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM1_2', left=300, top=930, right=850, bottom=990, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO1_2', left=850, top=930, right=1300, bottom=990, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT1_2,0,,PAYAMT1_2)}', left=1300, top=930, right=1600, bottom=990, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT1_2,0,,DEDAMT1_2)}', left=1600, top=930, right=1900, bottom=990, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM1_3', left=30, top=990, right=300, bottom=1050, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM1_3', left=300, top=990, right=850, bottom=1050, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO1_3', left=850, top=990, right=1300, bottom=1050, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT1_3,0,,PAYAMT1_3)}', left=1300, top=990, right=1600, bottom=1050, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT1_3,0,,DEDAMT1_3)}', left=1600, top=990, right=1900, bottom=1050, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM2_1', left=30, top=1210, right=300, bottom=1270, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM2_1', left=300, top=1210, right=850, bottom=1270, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO2_1', left=850, top=1210, right=1300, bottom=1270, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT2_1,0,,PAYAMT2_1)}', left=1300, top=1210, right=1600, bottom=1270, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT2_1,0,,DEDAMT2_1)}', left=1600, top=1210, right=1900, bottom=1270, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM2_2', left=30, top=1270, right=300, bottom=1330, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM2_2', left=300, top=1270, right=850, bottom=1330, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO2_2', left=850, top=1270, right=1300, bottom=1330, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT2_2,0,,PAYAMT2_2)}', left=1300, top=1270, right=1600, bottom=1330, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT2_2,0,,DEDAMT2_2)}', left=1600, top=1270, right=1900, bottom=1330, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM2_3', left=30, top=1330, right=300, bottom=1390, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM2_3', left=300, top=1330, right=850, bottom=1390, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO2_3', left=850, top=1330, right=1300, bottom=1390, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT2_3,0,,PAYAMT2_3)}', left=1300, top=1330, right=1600, bottom=1390, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT2_3,0,,DEDAMT2_3)}', left=1600, top=1330, right=1900, bottom=1390, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>


<C>id='DUDGBNM2_4', left=30, top=1390, right=300, bottom=1450, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM2_4', left=300, top=1390, right=850, bottom=1450, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO2_4', left=850, top=1390, right=1300, bottom=1450, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT2_4,0,,PAYAMT2_4)}', left=1300, top=1390, right=1600, bottom=1450, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT2_4,0,,DEDAMT2_4)}', left=1600, top=1390, right=1900, bottom=1450, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM2_5', left=30, top=1450, right=300, bottom=1510, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM2_5', left=300, top=1450, right=850, bottom=1510, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO2_5', left=850, top=1450, right=1300, bottom=1510, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT2_5,0,,PAYAMT2_5)}', left=1300, top=1450, right=1600, bottom=1510, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT2_5,0,,DEDAMT2_5)}', left=1600, top=1450, right=1900, bottom=1510, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>



<C>id='DUDGBNM3_1', left=30, top=1670, right=300, bottom=1730, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM3_1', left=300, top=1670, right=850, bottom=1730, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO3_1', left=850, top=1670, right=1300, bottom=1730, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT3_1,0,,PAYAMT3_1)}', left=1300, top=1670, right=1600, bottom=1730, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT3_1,0,,DEDAMT3_1)}', left=1600, top=1670, right=1900, bottom=1730, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM3_2', left=30, top=1730, right=300, bottom=1790, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM3_2', left=300, top=1730, right=850, bottom=1790, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO3_2', left=850, top=1730, right=1300, bottom=1790, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT3_2,0,,PAYAMT3_2)}', left=1300, top=1730, right=1600, bottom=1790, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT3_2,0,,DEDAMT3_2)}', left=1600, top=1730, right=1900, bottom=1790, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM3_3', left=30, top=1790, right=300, bottom=1850, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM3_3', left=300, top=1790, right=850, bottom=1850, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO3_3', left=850, top=1790, right=1300, bottom=1850, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT3_3,0,,PAYAMT3_3)}', left=1300, top=1790, right=1600, bottom=1850, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT3_3,0,,DEDAMT3_3)}', left=1600, top=1790, right=1900, bottom=1850, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM3_4', left=30, top=1850, right=300, bottom=1910, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM3_4', left=300, top=1850, right=850, bottom=1910, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO3_4', left=850, top=1850, right=1300, bottom=1910, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT3_4,0,,PAYAMT3_4)}', left=1300, top=1850, right=1600, bottom=1910, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT3_4,0,,DEDAMT3_4)}', left=1600, top=1850, right=1900, bottom=1910, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='DUDGBNM3_5', left=30, top=1910, right=300, bottom=1970, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='FINANM3_5', left=300, top=1910, right=850, bottom=1970, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='left'</C>
<C>id='ACCNO3_5', left=850, top=1910, right=1300, bottom=1970, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT3_5,0,,PAYAMT3_5)}', left=1300, top=1910, right=1600, bottom=1970, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT3_5,0,,DEDAMT3_5)}', left=1600, top=1910, right=1900, bottom=1970, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='FINANM4_1', left=30, top=2130, right=600, bottom=2190, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='ACCNO4_1', left=600, top=2130, right=1000, bottom=2190, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='YEARLY4_1', left=1000, top=2130, right=1300, bottom=2190, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT4_1,0,,PAYAMT4_1)}', left=1300, top=2130, right=1600, bottom=2190, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT4_1,0,,DEDAMT4_1)}', left=1600, top=2130, right=1900, bottom=2190, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='FINANM4_2', left=30, top=2190, right=600, bottom=2250, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='ACCNO4_2', left=600, top=2190, right=1000, bottom=2250, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='YEARLY4_2', left=1000, top=2190, right=1300, bottom=2250, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT4_2,0,,PAYAMT4_2)}', left=1300, top=2190, right=1600, bottom=2250, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT4_2,0,,DEDAMT4_2)}', left=1600, top=2190, right=1900, bottom=2250, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='FINANM4_3', left=30, top=2250, right=600, bottom=2310, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='ACCNO4_3', left=600, top=2250, right=1000, bottom=2310, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='YEARLY4_3', left=1000, top=2250, right=1300, bottom=2310, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT4_3,0,,PAYAMT4_3)}', left=1300, top=2250, right=1600, bottom=2310, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT4_3,0,,DEDAMT4_3)}', left=1600, top=2250, right=1900, bottom=2310, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>

<C>id='FINANM4_4', left=30, top=2310, right=600, bottom=2370, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='ACCNO4_4', left=600, top=2310, right=1000, bottom=2370, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='YEARLY4_4', left=1000, top=2310, right=1300, bottom=2370, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='center'</C>
<C>id='{decode(PAYAMT4_4,0,,PAYAMT4_4)}', left=1300, top=2310, right=1600, bottom=2370, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>
<C>id='{decode(DEDAMT4_4,0,,DEDAMT4_4)}', left=1600, top=2310, right=1900, bottom=2370, face='굴림', size=10,  forecolor=#000000, backcolor=#FFFFFF, align='right'</C>





<T>id='(7쪽)' ,left=1738 ,top=71 ,right=1892 ,bottom=132 ,align='right'</T>

<T>id='연금 · 저축 등 소득공제 명세서' ,left=30 ,top=100 ,right=1900 ,bottom=250 ,face='맑은 고딕' ,bold=true, size=20 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='1. 인적사항' ,left=50 ,top=250 ,right=300 ,bottom=350 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='①상            호' ,left=30 ,top=350 ,right=300 ,bottom=430 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='현대아산 주식회사' ,left=300 ,top=350 ,right=750 ,bottom=430 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>

<T>id='②사  업  자  등  록  번  호' ,left=750 ,top=350 ,right=1228 ,bottom=430 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T> id='2' , left=1228 ,top=350 ,right=1284 ,bottom=430 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>
<T> id='2' , left=1284 ,top=350 ,right=1340 ,bottom=430 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>
<T> id='1' , left=1340 ,top=350 ,right=1396 ,bottom=430 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>
<T> id='-' , left=1396 ,top=350 ,right=1452 ,bottom=430 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T> id='8' , left=1452 ,top=350 ,right=1508 ,bottom=430 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>
<T> id='1' , left=1508 ,top=350 ,right=1564 ,bottom=430 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>
<T> id='-' , left=1564 ,top=350 ,right=1620 ,bottom=430 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T> id='1' , left=1620 ,top=350 ,right=1676 ,bottom=430 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>
<T> id='3' , left=1676 ,top=350 ,right=1732 ,bottom=430 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>
<T> id='8' , left=1732 ,top=350 ,right=1788 ,bottom=430 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>
<T> id='3' , left=1788 ,top=350 ,right=1844 ,bottom=430 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>
<T> id='4' , left=1844 ,top=350 ,right=1900 ,bottom=430 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center' </L>

<T>id='③성            명' ,left=30 ,top=430 ,right=300 ,bottom=510 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='④주   민   등   록   번   호' ,left=750 ,top=430 ,right=1228 ,bottom=510 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='⑤주            소' ,left=30 ,top=510 ,right=300 ,bottom=610 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='⑥사업장소재지' ,left=30 ,top=610 ,right=300 ,bottom=710 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id=' 서울 종로구 연지동 1-7 현대그룹빌딩' ,left=300 ,top=610 ,right=900 ,bottom=710 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='(전화번호:' ,left=1400 ,top=510 ,right=1570 ,bottom=610 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='( 전화번호:02-3669-3867     )' ,left=1400 ,top=610 ,right=1880 ,bottom=710 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id=')' ,left=1840 ,top=510 ,right=1870 ,bottom=610 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='2. 퇴직연금 공제' ,left=50 ,top=710 ,right=400 ,bottom=760 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF ,align='left'</T>
<T>id='     * 퇴직연금 공제에 대한 명세를 작성합니다.' ,left=40 ,top=760 ,right=900 ,bottom=810 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='퇴직연금구분' ,left=30 ,top=810 ,right=300 ,bottom=870 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='금융기관' ,left=300 ,top=810 ,right=850 ,bottom=870 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='계좌번호' ,left=850 ,top=810 ,right=1300 ,bottom=870 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='불입금액' ,left=1300 ,top=810 ,right=1600 ,bottom=870 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='공제금액' ,left=1600 ,top=810 ,right=1900 ,bottom=870 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>

<T>id='3. 연금저축 공제' ,left=50 ,top=1050 ,right=400 ,bottom=1100 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='     * 연금저축 공제에 대한 명세를 작성합니다.' ,left=40 ,top=1100 ,right=900 ,bottom=1150 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='연금저축구분' ,left=30 ,top=1150 ,right=300 ,bottom=1210 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='금융기관' ,left=300 ,top=1150 ,right=850 ,bottom=1210 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='계좌번호' ,left=850 ,top=1150 ,right=1300 ,bottom=1210 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='불입금액' ,left=1300 ,top=1150 ,right=1600 ,bottom=1210 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='공제금액' ,left=1600 ,top=1150 ,right=1900 ,bottom=1210 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>


<T>id='4. 주택마련저축 공제' ,left=50 ,top=1510 ,right=500 ,bottom=1560 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='     * 주택마련저축 공제에 대한 명세를 작성합니다.' ,left=40 ,top=1560 ,right=1000 ,bottom=1610 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='저축 구분' ,left=30 ,top=1610 ,right=300 ,bottom=1670 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='금융기관' ,left=300 ,top=1610 ,right=850 ,bottom=1670 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='계좌번호' ,left=850 ,top=1610 ,right=1300 ,bottom=1670 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='불입금액' ,left=1300 ,top=1610 ,right=1600 ,bottom=1670 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='공제금액' ,left=1600 ,top=1610 ,right=1900 ,bottom=1670 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>


<T>id='5. 장기주식형저축 공제' ,left=50 ,top=1970 ,right=500 ,bottom=2020 ,face='굴림' ,size=11 ,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>
<T>id='     * 장기주식형저축 공제에 대한 명세를 작성합니다.' ,left=40 ,top=2020 ,right=1000 ,bottom=2070 ,face='굴림' ,size=10,forecolor=#000000 ,backcolor=#FFFFFF,align='left'</T>

<T>id='금융기관' ,left=30 ,top=2070 ,right=600 ,bottom=2130 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='계좌번호' ,left=600 ,top=2070 ,right=1000 ,bottom=2130 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='납입연차' ,left=1000 ,top=2070 ,right=1300 ,bottom=2130 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='불입금액' ,left=1300 ,top=2070 ,right=1600 ,bottom=2130 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>
<T>id='공제금액' ,left=1600 ,top=2070 ,right=1900 ,bottom=2130 ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF,align='center'</T>

<T>id='※ 작성요령' ,left=40 ,top=2380 ,right=1900 ,bottom=2430 ,align='left' ,face='굴림' ,size=10 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='1. 퇴직연금·연금저축·주택마련저축·장기주식형저축 공제를 신청하고자 하는 근로소득자는 해당 소득공제에 대한 명세를' ,left=40 ,top=2430 ,right=1900 ,bottom=2480 ,align='left' ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id=' 작성하여야 합니다.' ,left=40 ,top=2480 ,right=1900 ,bottom=2530 ,align='left' ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>

<T>id='2. 퇴직연금 공제에서 퇴직연금구분란은 퇴직연금·과학기술인공제회로 구분하여 적습니다.' ,left=40 ,top=2530 ,right=1900 ,bottom=2580 ,align='left' ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='3. 연금저축 공제의 연금저축구분란은 개인연금저축과 연금저축으로 구분하여 적습니다.' ,left=40 ,top=2580 ,right=1900 ,bottom=2630 ,align='left' ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='4. 주택마련저축 공제의 저축구분란은 청약저축, 주택청약종합저축, 장기주택마련저축 및 근로자주택마련저축으로 구분하여 적습니다.' ,left=40 ,top=2630 ,right=1900 ,bottom=2680 ,align='left' ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='5. 장기주식형저축 공제의 경우 동일 계좌라 하더라도 해당 과세기간에 납입연차가 달라지는 경우 구분하여 적습니다.' ,left=40 ,top=2680 ,right=1900 ,bottom=2730 ,align='left' ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='6. 근로자가 원천징수의무자에게 제출시 공제금액란은 근로소득자가 적지 아니할 수 있습니다.' ,left=40 ,top=2730 ,right=1900 ,bottom=2780 ,align='left' ,face='굴림' ,size=9 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
<T>id='210㎜x297㎜' ,left=1300 ,top=2805 ,right=1890 ,bottom=2840 ,align='right'</T>


</B>
</R>
</A>


 ">
<%=HDConstant.COMMENT_END%>
</FORM>

</BODY>
</HTML>
