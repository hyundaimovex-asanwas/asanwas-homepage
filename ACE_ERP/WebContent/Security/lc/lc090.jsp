<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* 시 스 템 명	: 자원>자원예약>차량예약>월별현황
* 프로그램 ID	: lm090.jsp
* 기 능 정 의	: 배차신청
* 작  성   자 : 이 동 훈
* 작 성 일 자 : 2017.7.6
-----------------------------------------------------------------------------
* 수 정 내 용 : 
* 수   정  자 :
* 수 정 일 자 : 
-----------------------------------------------------------------------------
* 서 블 릿 명	: 
* PROCEDURE 	: 
*******************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="security.common.*" %>

<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 변수 설정.
  String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. 
%>

<html>
<head>
<jsp:include page="/Security/common/include/head.jsp"/>
<title>월별현황</title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">


	var kkk;
	
/******************************************************************************
	Description : 페이지 로딩
****************************************************************************/
function fnOnLoad(tree_idx){

	fnInit_tree(tree_idx);	//트리초기화 호출

	gcem_staxdate.text = gcurdate;

    fnInit();

}

/******************************************************************************
	Description : 초기화 
****************************************************************************/
function fnInit(){
		
		    var date = new Date();
		
		    var year = gcurdate.substring(0,4);
		    
		    var month = gcurdate.substring(5,7);
		    
		    var day = gcurdate.substring(7,9);
		    
		    var s_year  = String(year);
		    
		    var s_month = String(month);   

		    fnc_SearchItem(s_year,s_month);
				
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function fnSelect() {

		var date = gcem_staxdate.text;

		var yyyy = date.substring(0,4);

		var mm0 = date.substring(4,6);

        if ( mm0.length != "1" || mm0.length != "2" ){
            mm0 = String(mm0);
        }

        if ( mm0.length == "1"){
        	mm0 = "0"+mm0;
        }	  
		
	    fnc_SearchItem(yyyy,mm0);
   
}

/******************************************************************************
Description : 조회
******************************************************************************/
function fnc_SearchItem(yy, mm) {

		ds_default.ClearAll();
	
        cal1_1[0].innerText = ""; cal1_2[0].innerText = ""; cal1_3[0].innerText = ""; cal1_4[0].innerText = ""; cal1_5[0].innerText = ""; 
        cal2_1[0].innerText = ""; cal2_2[0].innerText = ""; cal2_3[0].innerText = ""; cal2_4[0].innerText = ""; cal2_5[0].innerText = ""; 
        cal3_1[0].innerText = ""; cal3_2[0].innerText = ""; cal3_3[0].innerText = ""; cal3_4[0].innerText = ""; cal3_5[0].innerText = ""; 
        cal4_1[0].innerText = ""; cal4_2[0].innerText = ""; cal4_3[0].innerText = ""; cal4_4[0].innerText = ""; cal4_5[0].innerText = ""; 
        cal5_1[0].innerText = ""; cal5_2[0].innerText = ""; cal5_3[0].innerText = ""; cal5_4[0].innerText = ""; cal5_5[0].innerText = ""; 
        cal6_1[0].innerText = ""; cal6_2[0].innerText = ""; cal6_3[0].innerText = ""; cal6_4[0].innerText = ""; cal6_5[0].innerText = ""; 
        cal7_1[0].innerText = ""; cal7_2[0].innerText = ""; cal7_3[0].innerText = ""; cal7_4[0].innerText = ""; cal7_5[0].innerText = ""; 
        
	    var f = document.form1;

	    var REG_Y = yy;
	    
	    var REG_M = mm;	

        if ( mm.length != "1" || mm.length != "2" ){
            mm = String(mm);
        }

        if ( mm.length == "1"){
            REG_M = "0"+mm;
        }else{
            REG_M = mm;
        }	    
	    
        var REG_YM = REG_Y+REG_M;		

		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,v_staxdate=" + REG_YM;
		
	    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lc090",  "JSP(O:DS_DEFAULT=ds_default)",  param);

	    tr_post(tr1);      

	    //prompt(this, ds_default.text);

        if ( ds_default.CountRow != null || ds_default.CountRow != 0 || ds_default.CountRow != "0" )
        {
            var countRow        = ds_default.OrgValue(1,6);  // 한달중 주의 개수
            var start_day_num   = ds_default.OrgValue(1,5);  // 시작요일구분숫자(달력에서의 j의 차로 데이타셋의 row_num을 구해올 수 있다.)
            var k                   = 8 - start_day_num;

			kkk = start_day_num;

            if ( countRow == 5 ) 
            	biz.style.display = "none";
            else                 
            	biz.style.display = "";      // 6주포함 달일경우 마지막주 테이블 활성화
            	

            if ( start_day_num == 7)
            {
                    cal1_1[0].innerText = ""; cal1_2[0].innerText = ""; cal1_3[0].innerText = ""; cal1_4[0].innerText = ""; cal1_5[0].innerText = "";
                    cal2_1[0].innerText = ""; cal2_2[0].innerText = ""; cal2_3[0].innerText = ""; cal2_4[0].innerText = ""; cal2_5[0].innerText = "";
                    cal3_1[0].innerText = ""; cal3_2[0].innerText = ""; cal3_3[0].innerText = ""; cal3_4[0].innerText = ""; cal3_5[0].innerText = "";
                    cal4_1[0].innerText = ""; cal4_2[0].innerText = ""; cal4_3[0].innerText = ""; cal4_4[0].innerText = ""; cal4_5[0].innerText = "";
                    cal5_1[0].innerText = ""; cal5_2[0].innerText = ""; cal5_3[0].innerText = ""; cal5_4[0].innerText = ""; cal5_5[0].innerText = "";
                    cal6_1[0].innerText = ""; cal6_2[0].innerText = ""; cal6_3[0].innerText = ""; cal6_4[0].innerText = ""; cal6_5[0].innerText = "";

                    cal7_1[0].innerText   = ds_default.OrgValue(1,1);
                    cal7_2[0].innerText   = ds_default.OrgValue(1,8);
                    cal7_3[0].innerText   = ds_default.OrgValue(1,9);
                    cal7_4[0].innerText   = ds_default.OrgValue(1,10);                    
                    cal7_5[0].innerText   = ds_default.OrgValue(1,11);      

                    cal7_1[0].style.color = ds_default.OrgValue(1,7);

             }           	
            else if ( start_day_num == 6 )
            {
                cal1_1[0].innerText = ""; cal1_2[0].innerText = ""; cal1_3[0].innerText = ""; cal1_4[0].innerText = ""; cal1_5[0].innerText = "";
                cal2_1[0].innerText = ""; cal2_2[0].innerText = ""; cal2_3[0].innerText = ""; cal2_4[0].innerText = ""; cal2_5[0].innerText = "";
                cal3_1[0].innerText = ""; cal3_2[0].innerText = ""; cal3_3[0].innerText = ""; cal3_4[0].innerText = ""; cal3_5[0].innerText = "";
                cal4_1[0].innerText = ""; cal4_2[0].innerText = ""; cal4_3[0].innerText = ""; cal4_4[0].innerText = ""; cal4_5[0].innerText = "";
                cal5_1[0].innerText = ""; cal5_2[0].innerText = ""; cal5_3[0].innerText = ""; cal5_4[0].innerText = ""; cal5_5[0].innerText = "";

                cal7_1[0].innerText   = ds_default.OrgValue(2,1);
                cal7_2[0].innerText   = ds_default.OrgValue(2,8);
                cal7_3[0].innerText   = ds_default.OrgValue(2,9);
                cal7_4[0].innerText   = ds_default.OrgValue(2,10);
                cal7_5[0].innerText   = ds_default.OrgValue(2,11);
                
                cal7_1[0].style.color = ds_default.OrgValue(2,7);


                cal6_1[0].innerText   = ds_default.OrgValue(1,1);
                cal6_2[0].innerText   = ds_default.OrgValue(1,8);
                cal6_3[0].innerText   = ds_default.OrgValue(1,9);
                cal6_4[0].innerText   = ds_default.OrgValue(1,10);
                cal6_5[0].innerText   = ds_default.OrgValue(1,11);
                
                cal6_1[0].style.color = ds_default.OrgValue(1,7);

            }            	
            else if ( start_day_num == 5 )
            {
                cal1_1[0].innerText = ""; cal1_2[0].innerText = ""; cal1_3[0].innerText = ""; cal1_4[0].innerText = ""; cal1_5[0].innerText = "";
                cal2_1[0].innerText = ""; cal2_2[0].innerText = ""; cal2_3[0].innerText = ""; cal2_4[0].innerText = ""; cal2_5[0].innerText = "";
                cal3_1[0].innerText = ""; cal3_2[0].innerText = ""; cal3_3[0].innerText = ""; cal3_4[0].innerText = ""; cal3_5[0].innerText = "";
                cal4_1[0].innerText = ""; cal4_2[0].innerText = ""; cal4_3[0].innerText = ""; cal4_4[0].innerText = ""; cal4_5[0].innerText = "";

                cal7_1[0].innerText   = ds_default.OrgValue(3,1);
                cal7_2[0].innerText   = ds_default.OrgValue(3,8);
                cal7_3[0].innerText   = ds_default.OrgValue(3,9);
                cal7_4[0].innerText   = ds_default.OrgValue(3,10);
                cal7_5[0].innerText   = ds_default.OrgValue(3,11);
                
                cal7_1[0].style.color = ds_default.OrgValue(3,7);

                cal6_1[0].innerText   = ds_default.OrgValue(2,1);
                cal6_2[0].innerText   = ds_default.OrgValue(2,8);
                cal6_3[0].innerText   = ds_default.OrgValue(2,9);
                cal6_4[0].innerText   = ds_default.OrgValue(2,10);
                cal6_5[0].innerText   = ds_default.OrgValue(2,11);
                
                cal6_1[0].style.color = ds_default.OrgValue(2,7);


                cal5_1[0].innerText   = ds_default.OrgValue(1,1);
                cal5_2[0].innerText   = ds_default.OrgValue(1,8);
                cal5_3[0].innerText   = ds_default.OrgValue(1,9);
                cal5_4[0].innerText   = ds_default.OrgValue(1,10);
                cal5_5[0].innerText   = ds_default.OrgValue(1,11);
                
                cal5_1[0].style.color = ds_default.OrgValue(1,7);

            }
            else if ( start_day_num == 4 )
            {
                cal1_1[0].innerText = ""; cal1_2[0].innerText = ""; cal1_3[0].innerText = ""; cal1_4[0].innerText = ""; cal1_5[0].innerText = "";
                cal2_1[0].innerText = ""; cal2_2[0].innerText = ""; cal2_3[0].innerText = ""; cal2_4[0].innerText = ""; cal2_5[0].innerText = "";
                cal3_1[0].innerText = ""; cal3_2[0].innerText = ""; cal3_3[0].innerText = ""; cal3_4[0].innerText = ""; cal3_5[0].innerText = "";

                cal7_1[0].innerText   = ds_default.OrgValue(4,1);
                cal7_2[0].innerText   = ds_default.OrgValue(4,8);
                cal7_3[0].innerText   = ds_default.OrgValue(4,9);
                cal7_4[0].innerText   = ds_default.OrgValue(4,10);
                cal7_5[0].innerText   = ds_default.OrgValue(4,11);
                
                cal7_1[0].style.color = ds_default.OrgValue(4,7);


                cal6_1[0].innerText   = ds_default.OrgValue(3,1);
                cal6_2[0].innerText   = ds_default.OrgValue(3,8);
                cal6_3[0].innerText   = ds_default.OrgValue(3,9);
                cal6_4[0].innerText   = ds_default.OrgValue(3,10);
                cal6_5[0].innerText   = ds_default.OrgValue(3,11);
                
                cal6_1[0].style.color = ds_default.OrgValue(3,7);


                cal5_1[0].innerText   = ds_default.OrgValue(2,1);
                cal5_2[0].innerText   = ds_default.OrgValue(2,8);
                cal5_3[0].innerText   = ds_default.OrgValue(2,9);
                cal5_4[0].innerText   = ds_default.OrgValue(2,10);
                cal5_5[0].innerText   = ds_default.OrgValue(2,11);
                
                cal5_1[0].style.color = ds_default.OrgValue(2,7);


                cal4_1[0].innerText   = ds_default.OrgValue(1,1);
                cal4_2[0].innerText   = ds_default.OrgValue(1,8);
                cal4_3[0].innerText   = ds_default.OrgValue(1,9);
                cal4_4[0].innerText   = ds_default.OrgValue(1,10);
                cal4_5[0].innerText   = ds_default.OrgValue(1,11);
                
                cal4_1[0].style.color = ds_default.OrgValue(1,7);

            }
            else if ( start_day_num == 3 )
            {
                cal1_1[0].innerText = ""; cal1_2[0].innerText = ""; cal1_3[0].innerText = ""; cal1_4[0].innerText = ""; cal1_5[0].innerText = "";
                cal2_1[0].innerText = ""; cal2_2[0].innerText = ""; cal2_3[0].innerText = ""; cal2_4[0].innerText = ""; cal2_5[0].innerText = "";

                
				//prompt(this, ds_default.text);             
                
                cal7_1[0].innerText   = ds_default.OrgValue(5,1);
                cal7_2[0].innerText   = ds_default.OrgValue(5,8);
                cal7_3[0].innerText   = ds_default.OrgValue(5,9);
                cal7_4[0].innerText   = ds_default.OrgValue(5,10);
                cal7_5[0].innerText   = ds_default.OrgValue(5,11);
                
                cal7_1[0].style.color = ds_default.OrgValue(5,7);

	
			
				
				
                cal6_1[0].innerText   = ds_default.OrgValue(4,1);
                cal6_2[0].innerText   = ds_default.OrgValue(4,8);
                cal6_3[0].innerText   = ds_default.OrgValue(4,9);
                cal6_4[0].innerText   = ds_default.OrgValue(4,10);
                cal6_5[0].innerText   = ds_default.OrgValue(4,11);
                
                cal6_1[0].style.color = ds_default.OrgValue(4,7);


                cal5_1[0].innerText   = ds_default.OrgValue(3,1);
                cal5_2[0].innerText   = ds_default.OrgValue(3,8);
                cal5_3[0].innerText   = ds_default.OrgValue(3,9);
                cal5_4[0].innerText   = ds_default.OrgValue(3,10);
                cal5_5[0].innerText   = ds_default.OrgValue(3,11);
                
                cal5_1[0].style.color = ds_default.OrgValue(3,7);


                cal4_1[0].innerText   = ds_default.OrgValue(2,1);
                cal4_2[0].innerText   = ds_default.OrgValue(2,8);
                cal4_3[0].innerText   = ds_default.OrgValue(2,9);
                cal4_4[0].innerText   = ds_default.OrgValue(2,10);
                cal4_5[0].innerText   = ds_default.OrgValue(2,11);
                
                cal4_1[0].style.color = ds_default.OrgValue(2,7);


                cal3_1[0].innerText   = ds_default.OrgValue(1,1);
                cal3_2[0].innerText   = ds_default.OrgValue(1,8);
                cal3_3[0].innerText   = ds_default.OrgValue(1,9);
                cal3_4[0].innerText   = ds_default.OrgValue(1,10);
                cal3_5[0].innerText   = ds_default.OrgValue(1,11);
                
                cal3_1[0].style.color = ds_default.OrgValue(1,7);

            }
            else if ( start_day_num == 2 )
            {
                cal1_1[0].innerText = ""; cal1_2[0].innerText = ""; cal1_3[0].innerText = ""; cal1_4[0].innerText = ""; cal1_5[0].innerText = "";

                cal7_1[0].innerText   = ds_default.OrgValue(6,1);
                cal7_2[0].innerText   = ds_default.OrgValue(6,8);
                cal7_3[0].innerText   = ds_default.OrgValue(6,9);
                cal7_4[0].innerText   = ds_default.OrgValue(6,10);
                cal7_5[0].innerText   = ds_default.OrgValue(6,11);
                
                cal7_1[0].style.color = ds_default.OrgValue(6,7);


                cal6_1[0].innerText   = ds_default.OrgValue(5,1);
                cal6_2[0].innerText   = ds_default.OrgValue(5,8);
                cal6_3[0].innerText   = ds_default.OrgValue(5,9);
                cal6_4[0].innerText   = ds_default.OrgValue(5,10);
                cal6_5[0].innerText   = ds_default.OrgValue(5,11);
                
                cal6_1[0].style.color = ds_default.OrgValue(5,7);


                cal5_1[0].innerText   = ds_default.OrgValue(4,1);
                cal5_2[0].innerText   = ds_default.OrgValue(4,8);
                cal5_3[0].innerText   = ds_default.OrgValue(4,9);
                cal5_4[0].innerText   = ds_default.OrgValue(4,10);
                cal5_5[0].innerText   = ds_default.OrgValue(4,11);
                
                cal5_1[0].style.color = ds_default.OrgValue(4,7);


                cal4_1[0].innerText   = ds_default.OrgValue(3,1);
                cal4_2[0].innerText   = ds_default.OrgValue(3,8);
                cal4_3[0].innerText   = ds_default.OrgValue(3,9);
                cal4_4[0].innerText   = ds_default.OrgValue(3,10);
                cal4_5[0].innerText   = ds_default.OrgValue(3,11);
                
                cal4_1[0].style.color = ds_default.OrgValue(3,7);


                cal3_1[0].innerText   = ds_default.OrgValue(2,1);
                cal3_2[0].innerText   = ds_default.OrgValue(2,8);
                cal3_3[0].innerText   = ds_default.OrgValue(2,9);
                cal3_4[0].innerText   = ds_default.OrgValue(2,10);
                cal3_5[0].innerText   = ds_default.OrgValue(2,11);
                
                cal3_1[0].style.color = ds_default.OrgValue(2,7);


                cal2_1[0].innerText   = ds_default.OrgValue(1,1);
                cal2_2[0].innerText   = ds_default.OrgValue(1,8);
                cal2_3[0].innerText   = ds_default.OrgValue(1,9);
                cal2_4[0].innerText   = ds_default.OrgValue(1,10);
                cal2_5[0].innerText   = ds_default.OrgValue(1,11);
                
                cal2_1[0].style.color = ds_default.OrgValue(1,7);

            }
            else if ( start_day_num == 1 )
            {
                cal7_1[0].innerText   = ds_default.OrgValue(7,1);
                cal7_2[0].innerText   = ds_default.OrgValue(7,8);
                cal7_3[0].innerText   = ds_default.OrgValue(7,9);
                cal7_4[0].innerText   = ds_default.OrgValue(7,10);
                cal7_5[0].innerText   = ds_default.OrgValue(7,11);
                
                cal7_1[0].style.color = ds_default.OrgValue(7,7);


                cal6_1[0].innerText   = ds_default.OrgValue(6,1);
                cal6_2[0].innerText   = ds_default.OrgValue(6,8);
                cal6_3[0].innerText   = ds_default.OrgValue(6,9);
                cal6_4[0].innerText   = ds_default.OrgValue(6,10);
                cal6_5[0].innerText   = ds_default.OrgValue(6,11);
                
                cal6_1[0].style.color = ds_default.OrgValue(6,7);


                cal5_1[0].innerText   = ds_default.OrgValue(5,1);
                cal5_2[0].innerText   = ds_default.OrgValue(5,8);
                cal5_3[0].innerText   = ds_default.OrgValue(5,9);
                cal5_4[0].innerText   = ds_default.OrgValue(5,10);
                cal5_5[0].innerText   = ds_default.OrgValue(5,11);
                
                cal5_1[0].style.color = ds_default.OrgValue(5,7);


                cal4_1[0].innerText   = ds_default.OrgValue(4,1);
                cal4_2[0].innerText   = ds_default.OrgValue(4,8);
                cal4_3[0].innerText   = ds_default.OrgValue(4,9);
                cal4_4[0].innerText   = ds_default.OrgValue(4,10);
                cal4_5[0].innerText   = ds_default.OrgValue(4,11);
                
                cal4_1[0].style.color = ds_default.OrgValue(4,7);


                cal3_1[0].innerText   = ds_default.OrgValue(3,1);
                cal3_2[0].innerText   = ds_default.OrgValue(3,8);
                cal3_3[0].innerText   = ds_default.OrgValue(3,9);
                cal3_4[0].innerText   = ds_default.OrgValue(3,10);
                cal3_5[0].innerText   = ds_default.OrgValue(3,11);
                
                cal3_1[0].style.color = ds_default.OrgValue(3,7);


                cal2_1[0].innerText   = ds_default.OrgValue(2,1);
                cal2_2[0].innerText   = ds_default.OrgValue(2,8);
                cal2_3[0].innerText   = ds_default.OrgValue(2,9);
                cal2_4[0].innerText   = ds_default.OrgValue(2,10);
                cal2_5[0].innerText   = ds_default.OrgValue(2,11);
                
                cal2_1[0].style.color = ds_default.OrgValue(2,7);


                cal1_1[0].innerText   = ds_default.OrgValue(1,1);
                cal1_2[0].innerText   = ds_default.OrgValue(1,8);
                cal1_3[0].innerText   = ds_default.OrgValue(1,9);
                cal1_4[0].innerText   = ds_default.OrgValue(1,10);
                cal1_5[0].innerText   = ds_default.OrgValue(1,11);
                
                cal1_1[0].style.color = ds_default.OrgValue(1,7);

            }

            for ( var i=1; i<countRow-1 ;i++ )
            {
                k++;
                cal1_1[i].innerText   = ds_default.OrgValue(k,1);
                cal1_2[i].innerText   = ds_default.OrgValue(k,8);
                cal1_3[i].innerText   = ds_default.OrgValue(k,9);
                cal1_4[i].innerText   = ds_default.OrgValue(k,10);
                cal1_5[i].innerText   = ds_default.OrgValue(k,11);
                
                cal1_1[i].style.color = ds_default.OrgValue(k,7);


                k++;
                cal2_1[i].innerText   = ds_default.OrgValue(k,1);
                cal2_2[i].innerText   = ds_default.OrgValue(k,8);
                cal2_3[i].innerText   = ds_default.OrgValue(k,9);
                cal2_4[i].innerText   = ds_default.OrgValue(k,10);
                cal2_5[i].innerText   = ds_default.OrgValue(k,11);
                
                cal2_1[i].style.color = ds_default.OrgValue(k,7);


                k++;
                cal3_1[i].innerText   = ds_default.OrgValue(k,1);
                cal3_2[i].innerText   = ds_default.OrgValue(k,8);
                cal3_3[i].innerText   = ds_default.OrgValue(k,9);
                cal3_4[i].innerText   = ds_default.OrgValue(k,10);
                cal3_5[i].innerText   = ds_default.OrgValue(k,11);
                
                cal3_1[i].style.color = ds_default.OrgValue(k,7);


                k++;
                cal4_1[i].innerText   = ds_default.OrgValue(k,1);
                cal4_2[i].innerText   = ds_default.OrgValue(k,8);
                cal4_3[i].innerText   = ds_default.OrgValue(k,9);
                cal4_4[i].innerText   = ds_default.OrgValue(k,10);
                cal4_5[i].innerText   = ds_default.OrgValue(k,11);                
                
                cal4_1[i].style.color = ds_default.OrgValue(k,7);


                k++;
                cal5_1[i].innerText   = ds_default.OrgValue(k,1);
                cal5_2[i].innerText   = ds_default.OrgValue(k,8);
                cal5_3[i].innerText   = ds_default.OrgValue(k,9);
                cal5_4[i].innerText   = ds_default.OrgValue(k,10);
                cal5_5[i].innerText   = ds_default.OrgValue(k,11);                
                
                cal5_1[i].style.color = ds_default.OrgValue(k,7);


                k++;
                cal6_1[i].innerText   = ds_default.OrgValue(k,1);
                cal6_2[i].innerText   = ds_default.OrgValue(k,8);
                cal6_3[i].innerText   = ds_default.OrgValue(k,9);
                cal6_4[i].innerText   = ds_default.OrgValue(k,10);
                cal6_5[i].innerText   = ds_default.OrgValue(k,11);                
                
                cal6_1[i].style.color = ds_default.OrgValue(k,7);


                k++;
                cal7_1[i].innerText   = ds_default.OrgValue(k,1);
                cal7_2[i].innerText   = ds_default.OrgValue(k,8);
                cal7_3[i].innerText   = ds_default.OrgValue(k,9);
                cal7_4[i].innerText   = ds_default.OrgValue(k,10);
                cal7_5[i].innerText   = ds_default.OrgValue(k,11);                

                cal7_1[i].style.color = ds_default.OrgValue(k,7);

            }
            
            k++;
            cal1_1[i].innerText   = ds_default.OrgValue(k,1)==null?"":ds_default.OrgValue(k,1);
        	cal1_2[i].innerText   = ds_default.OrgValue(k,8)==null?"":ds_default.OrgValue(k,8);           
            cal1_3[i].innerText   = ds_default.OrgValue(k,9)==null?"":ds_default.OrgValue(k,9);
            cal1_4[i].innerText   = ds_default.OrgValue(k,10)==null?"":ds_default.OrgValue(k,10);          
            cal1_5[i].innerText   = ds_default.OrgValue(k,11)==null?"":ds_default.OrgValue(k,11);
            cal1_1[i].style.color  = ds_default.OrgValue(k,7)==null?"":ds_default.OrgValue(k,7);

            k++;
            cal2_1[i].innerText   = ds_default.OrgValue(k,1)==null?"":ds_default.OrgValue(k,1);
            cal2_2[i].innerText   = ds_default.OrgValue(k,8)==null?"":ds_default.OrgValue(k,8);
            cal2_3[i].innerText   = ds_default.OrgValue(k,9)==null?"":ds_default.OrgValue(k,9);
            cal2_4[i].innerText   = ds_default.OrgValue(k,10)==null?"":ds_default.OrgValue(k,10);
            cal2_5[i].innerText   = ds_default.OrgValue(k,11)==null?"":ds_default.OrgValue(k,11);            
            cal2_1[i].style.color  = ds_default.OrgValue(k,7)==null?"":ds_default.OrgValue(k,7);

            k++;
            cal3_1[i].innerText   = ds_default.OrgValue(k,1)==null?"":ds_default.OrgValue(k,1);
            cal3_2[i].innerText   = ds_default.OrgValue(k,8)==null?"":ds_default.OrgValue(k,8);
            cal3_3[i].innerText   = ds_default.OrgValue(k,9)==null?"":ds_default.OrgValue(k,9);
            cal3_4[i].innerText   = ds_default.OrgValue(k,10)==null?"":ds_default.OrgValue(k,10);            
            cal3_5[i].innerText   = ds_default.OrgValue(k,11)==null?"":ds_default.OrgValue(k,11);
            cal3_1[i].style.color  = ds_default.OrgValue(k,7)==null?"":ds_default.OrgValue(k,7);

            k++;
            cal4_1[i].innerText   = ds_default.OrgValue(k,1)==null?"":ds_default.OrgValue(k,1);
            cal4_2[i].innerText   = ds_default.OrgValue(k,8)==null?"":ds_default.OrgValue(k,8);
            cal4_3[i].innerText   = ds_default.OrgValue(k,9)==null?"":ds_default.OrgValue(k,9);
            cal4_4[i].innerText   = ds_default.OrgValue(k,10)==null?"":ds_default.OrgValue(k,10);            
            cal4_5[i].innerText   = ds_default.OrgValue(k,11)==null?"":ds_default.OrgValue(k,11);
            cal4_1[i].style.color  = ds_default.OrgValue(k,7)==null?"":ds_default.OrgValue(k,7);

            k++;
            cal5_1[i].innerText   = ds_default.OrgValue(k,1)==null?"":ds_default.OrgValue(k,1);
            cal5_2[i].innerText   = ds_default.OrgValue(k,8)==null?"":ds_default.OrgValue(k,8);
            cal5_3[i].innerText   = ds_default.OrgValue(k,9)==null?"":ds_default.OrgValue(k,9);
            cal5_4[i].innerText   = ds_default.OrgValue(k,10)==null?"":ds_default.OrgValue(k,10);            
            cal5_5[i].innerText   = ds_default.OrgValue(k,11)==null?"":ds_default.OrgValue(k,11);
            cal5_1[i].style.color  = ds_default.OrgValue(k,7)==null?"":ds_default.OrgValue(k,7);

            k++;
            cal6_1[i].innerText   = ds_default.OrgValue(k,1)==null?"":ds_default.OrgValue(k,1);
            cal6_2[i].innerText   = ds_default.OrgValue(k,8)==null?"":ds_default.OrgValue(k,8);
            cal6_3[i].innerText   = ds_default.OrgValue(k,9)==null?"":ds_default.OrgValue(k,9);
            cal6_4[i].innerText   = ds_default.OrgValue(k,10)==null?"":ds_default.OrgValue(k,10);            
            cal6_5[i].innerText   = ds_default.OrgValue(k,11)==null?"":ds_default.OrgValue(k,11);
            cal6_1[i].style.color  = ds_default.OrgValue(k,7)==null?"":ds_default.OrgValue(k,7);

            k++;
            cal7_1[i].innerText   = ds_default.OrgValue(k,1)==null?"":ds_default.OrgValue(k,1);
            cal7_2[i].innerText   = ds_default.OrgValue(k,8)==null?"":ds_default.OrgValue(k,8);
            cal7_3[i].innerText   = ds_default.OrgValue(k,9)==null?"":ds_default.OrgValue(k,9);
            cal7_4[i].innerText   = ds_default.OrgValue(k,10)==null?"":ds_default.OrgValue(k,10);            
            cal7_5[i].innerText   = ds_default.OrgValue(k,11)==null?"":ds_default.OrgValue(k,11);
            cal7_1[i].style.color  = ds_default.OrgValue(k,7)==null?"":ds_default.OrgValue(k,7);

        }

}


/****** 달력 클릭시 ******/
function fn_Click(i, j, row) {   
	
	kkk = parseInt(kkk);
	
	var chk = (row)*7 + i - kkk + 1;
	var day;
	var car;
	var yes = 'no';
	
	day = ds_default.OrgValue(chk,4);
    
	
	
	car = ds_default.OrgValue(chk,6+j);
	
	if(car == '그랜져'){
		yes = 'yes';
	}else if(car == '스타렉스'){
		yes = 'yes';
	}else if(car == '코나'){
		yes = 'yes';
	}else if(car == '카니발'){
		yes = 'yes';
	}		
	
	//alert("car="+car);   
	

	
	if(j == '2'){
		car = 'G';  	
	}else if(j == '3'){	
		car = 'S';  
	}else if(j == '4'){
		car	 = 'A';  
	}else if(j == '5'){
		car	 = 'C';  
	}	
	
	if(yes == 'yes'){

		var sendParam	= new Array();
		var arrParam	= new Array();
		var arrResult	= new Array();
		var check;
		
		var strURL;	
		var strPos;	
		
		sendParam[0] = day; 
		sendParam[1] = car; 
		
		//alert(sendParam);
		
		strURL = "../../Security/lc/lc095.jsp";
		strPos = "dialogWidth:800px;dialogHeight:400px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,sendParam,strPos);	
	
	}else{
		
		//alert("꽝");
		
	}
		

}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=ds_default classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   			Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    		value="toinb_dataid4">
    <param name="ServerIP"   			value="">
    <param name="Action"     			value="">
    <param name="KeyValue"   			value="">
    <param name="Parameters" 			value="">
</object>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="ds_default" event="OnLoadStarted()">

</script>

<script language="javascript" for="ds_default" event="onloadCompleted(row,colid)">

	window.status="조회가 완료 되었습니다.";
	
</script>

<script language=JavaScript for=gcem_staxdate event=onKeyDown(kcode,scode)>

	if (kcode == 13){
		
		ds_default.ClearData();
		
		fnSelect();
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
</HEAD>
<jsp:include page="/Common/sys/body_s09.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td align=right >
			<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px;" class="tab25"  bgcolor="#eeeeee" align=center>년월</td> 
		<td class="tab24" >&nbsp;
					<comment id="__NSID__">
					<object  id=gcem_staxdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:5px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      		value=true>
							<param name=Format	      		value="YYYY/MM">
							<param name=PromptChar	  	value="_">
							<param name=Enable				value="true">
					</object>
					</comment><script>__ws__(__NSID__);</script> 
		</td>	
	</tr>
</table>

<BR>

<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center">

            <table  border="1" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="30"><div align="center" class="style1"><b><font color="red">일</font></b></div></td>
                    <td height="30"><div align="center" class="style1"><b>월</b></div></td>
                    <td height="30"><div align="center" class="style1"><b>화</b></div></td>
                    <td height="30"><div align="center" class="style1"><b>수</b></div></td>
                    <td height="30"><div align="center" class="style1"><b>목</b></div></td>
                    <td height="30"><div align="center" class="style1"><b>금</b></div></td>
                    <td height="30"><div align="center" class="style1"><b><font color="blue">토</font></b></div></td>
                </tr>
<%
            int cal_num = 0;   //dataset의 row넘버를 구하기위함.
            for ( int i=0; i<5; i++ ) {
%>
                <tr>
                    <td id="td_index_1" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="70" style='table-layout:fixed'>
                            <tr>
                                <td height="15" width="135"><div id="cal1_1" align="right">&nbsp;</div></td>
                            </tr>  
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(1, 2, <%=i%>);"><div id="cal1_2" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>                                                                           
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(1, 3, <%=i%>);"><div id="cal1_3" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(1, 4, <%=i%>);"><div id="cal1_4" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(1, 5, <%=i%>);"><div id="cal1_5" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>                                                        
                        </table>
                    </td>
                    <td id="td_index_2" style="cursor:hand" valign="top"><div align="right" id="bbcol">
                        <table border="0" height="70" style='table-layout:fixed' valign="top">
                            <tr>
                                <td height="15" width="135"><div id="cal2_1" align="right">&nbsp;</div></td>
                            </tr>  
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(2, 2, <%=i%>);"><div id="cal2_2" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>                                                                           
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(2, 3, <%=i%>);"><div id="cal2_3" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(2, 4, <%=i%>);"><div id="cal2_4" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(2, 5, <%=i%>);"><div id="cal2_5" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>   
                        </table>
                    </td>
                    <td id="td_index_3" style="cursor:hand"  valign="top"><div align="right">
                        <table border="0" height="70" style='table-layout:fixed'>
                            <tr>
                                <td height="15" width="135"><div id="cal3_1" align="right">&nbsp;</div></td>
                            </tr>  
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(3, 2, <%=i%>);"><div id="cal3_2" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>                                                                           
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(3, 3, <%=i%>);"><div id="cal3_3" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(3, 4, <%=i%>);"><div id="cal3_4" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(3, 5, <%=i%>);"><div id="cal3_5" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>   
                        </table>
                    </td>
                    <td  id="td_index_4" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="70" style='table-layout:fixed'>
                            <tr>
                                <td height="15" width="135"><div id="cal4_1" align="right">&nbsp;</div></td>
                            </tr>  
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(4, 2, <%=i%>);"><div id="cal4_2" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>                                                                           
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(4, 3, <%=i%>);"><div id="cal4_3" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(4, 4, <%=i%>);"><div id="cal4_4" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(4, 5, <%=i%>);"><div id="cal4_5" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>   
                        </table>
                    </td>
                    <td  id="td_index_5" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="70" style='table-layout:fixed'>
                            <tr>
                                <td height="15" width="135"><div id="cal5_1" align="right">&nbsp;</div></td>
                            </tr>  
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(5, 2, <%=i%>);"><div id="cal5_2" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>                                                                           
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(5, 3, <%=i%>);"><div id="cal5_3" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(5, 4, <%=i%>);"><div id="cal5_4" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(5, 5, <%=i%>);"><div id="cal5_5" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>   
                        </table>
                    </td>
                    <td  id="td_index_6" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="70" style='table-layout:fixed'>
                            <tr>
                                <td height="15" width="135"><div id="cal6_1" align="right">&nbsp;</div></td>
                            </tr>  
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(6, 2, <%=i%>);"><div id="cal6_2" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>                                                                           
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(6, 3, <%=i%>);"><div id="cal6_3" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(6, 4, <%=i%>);"><div id="cal6_4" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(6, 5, <%=i%>);"><div id="cal6_5" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>   
                        </table>
                    </td>
                    <td  id="td_index_7" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="70" style='table-layout:fixed'>
                            <tr>
                                <td height="15" width="135"><div id="cal7_1" align="right">&nbsp;</div></td>
                            </tr>  
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(7, 2, <%=i%>);"><div id="cal7_2" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>                                                                           
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(7, 3, <%=i%>);"><div id="cal7_3" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(7, 4, <%=i%>);"><div id="cal7_4" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(7, 5, <%=i%>);"><div id="cal7_5" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>   
                        </table>
                    </td>
                </tr>
<%
            }
%>

                <tr id="biz"  style="display:none">
                    <td  id="td_index_1" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="15" width="135"><div id="cal1_1" align="right">&nbsp;</div></td>
                            </tr>  
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(1, 2, 5);"><div id="cal1_2" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>                                                                           
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(1, 3, 5);"><div id="cal1_3" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(1, 4, 5);"><div id="cal1_4" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(1, 5, 5);"><div id="cal1_5" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>   
                        </table>
                    </td>
                    <td  id="td_index_2" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="15" width="135"><div id="cal2_1" align="right">&nbsp;</div></td>
                            </tr>  
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(2, 2, 5);"><div id="cal2_2" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>                                                                           
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(2, 3, 5);"><div id="cal2_3" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(2, 4, 5);"><div id="cal2_4" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135" Onclick="fn_Click(2, 5, 5);"><div id="cal2_5" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>   
                        </table>
                    </td>
                    <td  id="td_index_3" style="cursor:hand" valign="top"><div align="right">
                        <table border="0"v>
                            <tr>
                                <td height="15" width="135"><div id="cal3_1" align="right">&nbsp;</div></td>
                            </tr>  
                            <tr>
                                <td height="15" width="135"><div id="cal3_2" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>                                                                           
                            <tr>
                                <td height="15" width="135"><div id="cal3_3" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135"><div id="cal3_4" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135"><div id="cal3_5" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>   
                        </table>
                    </td>
                    <td  id="td_index_4" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="15" width="135"><div id="cal4_1" align="right">&nbsp;</div></td>
                            </tr>  
                            <tr>
                                <td height="15" width="135"><div id="cal4_2" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>                                                                           
                            <tr>
                                <td height="15" width="135"><div id="cal4_3" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135"><div id="cal4_4" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135"><div id="cal4_5" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>   
                        </table>
                    </td>
                    <td  id="td_index_5" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="15" width="135"><div id="cal5_1" align="right">&nbsp;</div></td>
                            </tr>  
                            <tr>
                                <td height="15" width="135"><div id="cal5_2" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>                                                                           
                            <tr>
                                <td height="15" width="135"><div id="cal5_3" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135"><div id="cal5_4" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135"><div id="cal5_5" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>   
                        </table>
                    </td>
                    <td  id="td_index_6" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="15" width="135"><div id="cal6_1" align="right">&nbsp;</div></td>
                            </tr>  
                            <tr>
                                <td height="15" width="135"><div id="cal6_2" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>                                                                           
                            <tr>
                                <td height="15" width="135"><div id="cal6_3" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135"><div id="cal6_4" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135"><div id="cal6_5" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>   
                        </table>
                    </td>
                    <td  id="td_index_7" style="cursor:hand" valign="top"><div align="right">
                        <table border="0" height="51" style='table-layout:fixed'>
                            <tr>
                                <td height="15" width="135"><div id="cal7_1" align="right">&nbsp;</div></td>
                            </tr>  
                            <tr>
                                <td height="15" width="135"><div id="cal7_2" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>                                                                           
                            <tr>
                                <td height="15" width="135"><div id="cal7_3" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135"><div id="cal7_4" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>
                            <tr>
                                <td height="15" width="135"><div id="cal7_5" align="left"  style='font-size:12px'>&nbsp;</div></td>
                            </tr>   
                        </table>
                    </td>
                </tr>
            </div>
		    <input type="hidden" name="i">
		    <input type="hidden" name="hid_REG_YMD">
		    <input type="hidden" name="row_num">
		    <input type="hidden" name="col_num">
		    <input type="hidden" name="dept">
		    <input type="hidden" name="countRow">
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 데이블 끝-->




</body> 
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



