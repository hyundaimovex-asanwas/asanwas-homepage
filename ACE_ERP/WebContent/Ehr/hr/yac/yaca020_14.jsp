<!--
*****************************************************************************
* @source      : yaca020_2014.jsp                                              *
* @description : 귀속2014년도 연말정산자료등록 PAGE                       *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                  *
*----------------------------------------------------------------------------
* 2014/12/17            이동훈             수정중                                             *
* 2013/10/27            이동훈             수정 - Ehr에서 Erp로 넘어 온기 Session이랑 기타 등등 확인 필요              *
*****************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<% String ss_userid   = (String)session.getAttribute("vusrid"); %>
<% String ss_usernm = (String)session.getAttribute("vusrnm");%>

<% String ENO_NO     = request.getParameter("ENO_NO"); %>
<% String ENO_NM     = request.getParameter("ENO_NM"); %>
<html>
<head>

<jsp:include page="/Ehr/common/include/head.jsp"/>

<title>연말정산자료등록(2014년도)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language=javascript src="../../common/common.js"></script>
<script language=javascript src="../../common/result.js"></script>
<script language=javascript src="../../common/input.js"></script>
<script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--**************************************************************************************
    *                                                                                        *
    *   자바스크립트 함수 선언부분                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

<script language="javascript">
        //단축키 순서
        var btnList = "T"   //조회
                    + "F"   //신규
                    + "T"   //저장
                    + "T"   //취소
                    + "F"   //엑셀
                    + "T"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

        var today = getToday();
                    
        var dataClassName = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca020.cmd.YACA020CMD";
        var params = null;

        var dataClassName_01 = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca021.cmd.YACA021CMD";
        var params_01 = null;

		var submit_chk = "N";
		
        var dsTemp = window.dialogArguments;		
		var ENO_NO = "<%=request.getParameter("ENO_NO") %>";
		var ENO_NM = "<%=request.getParameter("ENO_NM") %>";		
		/******************************************************************************
		Description : 페이지 로딩
		******************************************************************************/

		function fnOnLoad(tree_idx){
	
		    fnInit_tree(tree_idx);	//트리초기화 호출

		}

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {

            //연말정산 조회

            params = "&S_MODE=SHR_14"
                   + "&PIS_YY="+document.getElementById("txtPIS_YY_SHR").value
                   + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;

            trT_AC_RETACC.KeyValue = "tr"
                                   + "(O:dsT_AC_RETACC=dsT_AC_RETACC)";
            trT_AC_RETACC.action = dataClassName+params;

            trT_AC_RETACC.post();

            if(dsT_AC_RETACC.CountRow >= 1)
            {

    			if(dsT_AC_RETACC.NameValue(1, "CLS_TAG") == "Y" ){
    				document.getElementById("chkCLS_TAG").checked = true;
    			}else{
    				document.getElementById("chkCLS_TAG").checked = false;
    			}

            fnc_SearchList_01(); //부양가족 현황조회
       
            document.getElementById("txtSALT_AMT").value  = dsT_AC_RETACC.NameValue(1, "SALT_AMT");		//과세대상급여
            document.getElementById("txtFREE_INCOME").value = dsT_AC_RETACC.NameValue(1, "FREE_INCOME");//비과세
            document.getElementById("txtTAX_INCOME").value = dsT_AC_RETACC.NameValue(1, "TAX_INCOME");//총근로소득
            document.getElementById("txtINCM_TAX").value  = dsT_AC_RETACC.NameValue(1, "INCM_TAX");//기납부 소득세
            document.getElementById("txtCITI_TAX").value  = dsT_AC_RETACC.NameValue(1, "CITI_TAX");//기납부 주민세           

            var txtFUN_CNTNM = '';
            
			if(dsT_AC_RETACC.NameValue(1, "FUN_CNT") == "Y"){			
	            
				document.getElementById("txtFUN_CNTNM").value = '제출완료';
				
			}else{
				
				document.getElementById("txtFUN_CNTNM").value = '미제출';
				
			}

            submit_chk  = dsT_AC_RETACC.NameValue(1, "FUN_CNT");		//제출여부           
            
			if(dsT_AC_RETACC.NameValue(1, "FUN_CNT") == "Y" && submit_chk == " N"){			
	            
				fnc_disableInput();
				
			}               

            }

        }

        /********************************************
         * 입력필드 사용 불가능하게(Disable)    								*
         ********************************************/
  		function fnc_disableInput(param){

			alert("전산제출한 상태입니다.\n수정은 불가능합니다.");

			submit_chk = "Y";	

        }

        /********************************************
         * 입력필드 사용 가능하게(Enable)       								*
         ********************************************/
  		function fnc_enableInput(){

  		}

        /********************************************
         * 02. 조회 함수_Item 형태의 조회                *
         ********************************************/
        function fnc_SearchItem() {

        }

        /********************************************
         * 03. 저장 함수                                *
         ********************************************/
        function fnc_Save() {
   
        }

        /********************************************
         * 04. 삭제 함수                                *
         ********************************************/
        function fnc_Delete() {

        }
        
        
        
        /********************************************
         * 04. 삭제 함수                                *
         ********************************************/
        function fnc_UpdateAcc() {

			var pis_yy   = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;

			dsT_AC_MEDICAL2.UseChangeInfo = false;

			dsT_AC_MEDICAL2.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca030.cmd.YACA030CMD&S_MODE=ACC_14&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_AC_MEDICAL2.reset();        	
        	

			dsT_AC_DONATION2.UseChangeInfo = false;

			dsT_AC_DONATION2.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca040.cmd.YACA040CMD&S_MODE=ACC_14&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			dsT_AC_DONATION2.reset();        	
			
			
        }        
        

        /********************************************
         * 05. 인쇄 함수                                *
         ********************************************/
        function fnc_Print() {

			fnc_UpdateAcc();        	
        	
            //출력 직전에 작업을 돌린다.
    		ds_print.ClearAll();

            var row=0;

			var pis_yy   = document.form1.txtPIS_YY_SHR.value;
			var eno_no  = document.form1.txtENO_NO_SHR.value;
            
    		ln_Rpt_SetDataHeader();//데이타 셋헤드 

            ds_print.addrow();

    		//ds_print2.출력모드	
			ds_print2.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca020.cmd.YACA020CMD&S_MODE=SHR2_PRT_14&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			ds_print2.reset();    		
    		
    		//ds_print3.인적공제			
			ds_print3.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca020.cmd.YACA020CMD&S_MODE=SHR3_PRT_14&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			ds_print3.reset(); 			
			
    		//ds_print4. 2.3PAGE			
			ds_print4.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca020.cmd.YACA020CMD&S_MODE=SHR4_PRT_14&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			ds_print4.reset(); 				

    		//ds_print5.연금저축등등등
			ds_print5.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca020.cmd.YACA020CMD&S_MODE=SHR5_PRT_14&PIS_YY="+pis_yy+"&ENO_NO="+eno_no;
			ds_print5.reset(); 
    		
    		
            //인사 기본정보 
    		row = ds_print.rowposition;
			row2 = ds_print2.rowposition;

			ds_print.namevalue(row,"EMPNO")       = ds_print2.namevalue(1,"ENO_NO")
			ds_print.namevalue(row,"EMPNMK")     = ds_print2.namevalue(1,"ENO_NM");
			ds_print.namevalue(row,"EMPJUNO")    = ds_print2.namevalue(1,"CET_NO");
			ds_print.namevalue(row,"HOL_YN")   	= ds_print2.namevalue(1,"HOL_YN"); //세대주여부
			ds_print.namevalue(row,"WORKDAY")   = ds_print2.namevalue(1,"WORKDAY"); //근무기간
			ds_print.namevalue(row,"CLS_TAG")    = ds_print2.namevalue(1,"CLS_TAG");
			ds_print.namevalue(row,"ADDRESS")    = ds_print2.namevalue(1,"ADDRESS");
			ds_print.namevalue(row,"TELNO")    	= ds_print2.namevalue(1,"TELNO");			
			
	        var dblref10=0;			
	        var dblref11=0;
			var dblref12=0;
			var dblref13=0;
			var dblref14=0;
			var dblref15=0;
			var dblref16=0;
	        var dblref17=0; 
			var dblref18=0;
	        var dblref19=0; 	        
	    
			var dblref20=0;	        
			var dblref21=0;
			var dblref22=0;
			var dblref23=0;
			var dblref24=0;
			var dblref25=0;
			var dblref27=0;
			var dblref28=0;
			var dblref29=0;	

			for(i=1;i<=ds_print3.countrow;i++){
	         
	          ds_print.namevalue(row,"RELAT1_"+i)   = ds_print3.namevalue(i,"REL_CD");
		      ds_print.namevalue(row,"EMPNMK_"+i)  = ds_print3.namevalue(i,"NAM_KOR");
			  ds_print.namevalue(row,"EMPJUNO_"+i) = ds_print3.namevalue(i,"CET_NO");

			  if(ds_print3.namevalue(i,"REF1")=="1")
				  ds_print.namevalue(row,"REF1_"+i)="1"; //내국인
			  else 
				  ds_print.namevalue(row,"REF1_"+i)="9"; //외국인

			  if(ds_print3.namevalue(i,"REF2")=="O")
				  ds_print.namevalue(row,"REF2_"+i)="O"; //기본공제
			  else 
				  ds_print.namevalue(row,"REF2_"+i)="";

			  if(ds_print3.namevalue(i,"REF3")=="O")
				  ds_print.namevalue(row,"REF3_"+i)="O"; //부녀자
			  else 
				  ds_print.namevalue(row,"REF3_"+i)="";

			  if(ds_print3.namevalue(i,"REF4")=="O")
				  ds_print.namevalue(row,"REF4_"+i)="O"; //한부모
			  else 
				  ds_print.namevalue(row,"REF4_"+i)=""; 

	          if(ds_print3.namevalue(i,"REF5")=="O")
				ds_print.namevalue(row,"REF5_"+i)="O"; //경로우대
			  else 
				ds_print.namevalue(row,"REF5_"+i)="";

			 if(ds_print3.namevalue(i,"REF6")=="O")
				ds_print.namevalue(row,"REF6_"+i)="O"; //장애인
			 else 
				ds_print.namevalue(row,"REF6_"+i)="";

			  ds_print.namevalue(row,"REF10_"+i)=ds_print3.namevalue(i,"REF10");
			  ds_print.namevalue(row,"REF11_"+i)=ds_print3.namevalue(i,"REF11");
			  ds_print.namevalue(row,"REF12_"+i)=ds_print3.namevalue(i,"REF12");
			  ds_print.namevalue(row,"REF13_"+i)=ds_print3.namevalue(i,"REF13");
			  ds_print.namevalue(row,"REF14_"+i)=ds_print3.namevalue(i,"REF14");
			  ds_print.namevalue(row,"REF15_"+i)=ds_print3.namevalue(i,"REF15");
			  ds_print.namevalue(row,"REF16_"+i)=ds_print3.namevalue(i,"REF16");
			  ds_print.namevalue(row,"REF17_"+i)=ds_print3.namevalue(i,"REF17");
			  ds_print.namevalue(row,"REF18_"+i)=ds_print3.namevalue(i,"REF18");
			  ds_print.namevalue(row,"REF19_"+i)=ds_print3.namevalue(i,"REF19");

			  //ds_print.namevalue(row,"REF20_"+i)=ds_print3.namevalue(i,"REF20");
			  ds_print.namevalue(row,"REF21_"+i)=ds_print3.namevalue(i,"REF21");
			  ds_print.namevalue(row,"REF22_"+i)=ds_print3.namevalue(i,"REF22");
			  ds_print.namevalue(row,"REF23_"+i)=ds_print3.namevalue(i,"REF23");
			  ds_print.namevalue(row,"REF24_"+i)=ds_print3.namevalue(i,"REF24");
			  ds_print.namevalue(row,"REF25_"+i)=ds_print3.namevalue(i,"REF25");
			  ds_print.namevalue(row,"REF27_"+i)=ds_print3.namevalue(i,"REF27");			  
			  ds_print.namevalue(row,"REF28_"+i)=ds_print3.namevalue(i,"REF28");
			  ds_print.namevalue(row,"REF29_"+i)=ds_print3.namevalue(i,"REF29");
			  //alert(ds_print3.namevalue(i,"REF13"));

			  dblref10 += parseInt(ds_print3.namevalue(i,"REF10"));			  
			  dblref11 += parseInt(ds_print3.namevalue(i,"REF11"));
			  dblref12 += parseInt(ds_print3.namevalue(i,"REF12"));
			  dblref13 += parseInt(ds_print3.namevalue(i,"REF13"));
			  dblref14 += parseInt(ds_print3.namevalue(i,"REF14"));
			  dblref15 += parseInt(ds_print3.namevalue(i,"REF15"));
			  dblref16 += parseInt(ds_print3.namevalue(i,"REF16"));
			  dblref17 += parseInt(ds_print3.namevalue(i,"REF17"));
			  dblref18 += parseInt(ds_print3.namevalue(i,"REF18"));
			  dblref19 += parseInt(ds_print3.namevalue(i,"REF19"));

	  
			  dblref21 += parseInt(ds_print3.namevalue(i,"REF21"));
			  dblref22 += parseInt(ds_print3.namevalue(i,"REF22"));
			  dblref23 += parseInt(ds_print3.namevalue(i,"REF23"));
			  dblref24 += parseInt(ds_print3.namevalue(i,"REF24"));
	          dblref25 += parseInt(ds_print3.namevalue(i,"REF25"));
			  dblref27 += parseInt(ds_print3.namevalue(i,"REF27"));
	          dblref28 += parseInt(ds_print3.namevalue(i,"REF28"));
			  dblref29 += parseInt(ds_print3.namevalue(i,"REF29"));			
  
			}

        	ds_print.namevalue(row,"REF10_S") = dblref10;  //보험료(건강 고용등)        
	        ds_print.namevalue(row,"REF11_S") = dblref11;  //보험료(보장성)
			ds_print.namevalue(row,"REF12_S") = dblref12;  //의료비
			ds_print.namevalue(row,"REF13_S") = dblref13;  //교육비
			ds_print.namevalue(row,"REF14_S") = dblref14;  //신용카드
			ds_print.namevalue(row,"REF15_S") = dblref15;  //직불카드
			ds_print.namevalue(row,"REF16_S") = dblref16;  //현금영수증
	        ds_print.namevalue(row,"REF17_S") = dblref17;  //전통시장
			ds_print.namevalue(row,"REF18_S") = dblref18;  //대중교통
	        ds_print.namevalue(row,"REF19_S") = dblref19;  //기부금	        
	        
     
			ds_print.namevalue(row,"REF21_S") = dblref21;  //보험료(보장성)
			ds_print.namevalue(row,"REF22_S") = dblref22;  //의료비            
			ds_print.namevalue(row,"REF23_S") = dblref23;  //교육비            
			ds_print.namevalue(row,"REF24_S") = dblref24;  //신용카드          
			ds_print.namevalue(row,"REF25_S") = dblref25;  //직불카드    
			ds_print.namevalue(row,"REF27_S") = dblref27;  //전통시장			
			ds_print.namevalue(row,"REF28_S") = dblref28;  //대중교통    
			ds_print.namevalue(row,"REF29_S") = dblref29;  //기부금				
			
			/*연금보험료공제*/
	        ds_print.namevalue(row,"JAQ_AMT") 	= ds_print4.namevalue(1,"JAQ_AMT");//종전근무지(국민연금)
			ds_print.namevalue(row,"NPEN_AMT") 	= ds_print4.namevalue(1,"NPEN_AMT");//현근무지(국민연금)
			ds_print.namevalue(row,"JAR_AMT") 	= ds_print4.namevalue(1,"JAR_AMT");//종전 국민연금외
			ds_print.namevalue(row,"PEN_SUM") 	= ds_print4.namevalue(1,"PEN_SUM");//연금보험료계
			
			/*보험료공제*/			
			ds_print.namevalue(row,"JAH_AMT") 	= ds_print4.namevalue(1,"JAH_AMT");//종전 건강보험
			ds_print.namevalue(row,"HEALTH_AMT") 	= ds_print4.namevalue(1,"HEALTH_AMT");//현 건강보험
			ds_print.namevalue(row,"JAP_AMT")    		= ds_print4.namevalue(1,"JAP_AMT");   //종전	고용보험
			ds_print.namevalue(row,"HINS_AMT")    	= ds_print4.namevalue(1,"HINS_AMT");   //현	고용보험			
			ds_print.namevalue(row,"HIN_SUM")    	= ds_print4.namevalue(1,"HIN_SUM");   //보험계			
			/*주택자금*/			
			ds_print.namevalue(row,"LH1_AMT") 	= ds_print4.namevalue(1,"LH1_AMT");//대출기관 주택임차차입금
			ds_print.namevalue(row,"LH2_AMT") 	= ds_print4.namevalue(1,"LH2_AMT");//거주자 주택임차차입금
			ds_print.namevalue(row,"LH3_AMT") 	= ds_print4.namevalue(1,"LH3_AMT");//월세액
			ds_print.namevalue(row,"LH4_AMT") 	= ds_print4.namevalue(1,"LH4_AMT");//15년미만
			ds_print.namevalue(row,"LH5_AMT") 	= ds_print4.namevalue(1,"LH5_AMT");//15년~29년
			ds_print.namevalue(row,"LH6_AMT") 	= ds_print4.namevalue(1,"LH6_AMT");//30년이상
			ds_print.namevalue(row,"LH7_AMT") 	= ds_print4.namevalue(1,"LH7_AMT");//고정금리
			ds_print.namevalue(row,"LH8_AMT") 	= ds_print4.namevalue(1,"LH8_AMT");//기타대출			
			
			/*그밖의*/			
			ds_print.namevalue(row,"PER_AMT") 	= ds_print4.namevalue(1,"PER_AMT");//개인연금저축
			ds_print.namevalue(row,"LHO_AMT") 	= ds_print4.namevalue(1,"LHO_AMT");//청약저축
			ds_print.namevalue(row,"LHR_AMT") 	= ds_print4.namevalue(1,"LHR_AMT");//근로자주택마련저축
			ds_print.namevalue(row,"LHP_AMT") 	= ds_print4.namevalue(1,"LHP_AMT");//주택청약종합저축
			ds_print.namevalue(row,"VEN_AMT") 	= ds_print4.namevalue(1,"VEN_AMT");//2012년 투자
			ds_print.namevalue(row,"VEN2_AMT") 	= ds_print4.namevalue(1,"VEN2_AMT");//2013년 투자
			ds_print.namevalue(row,"VEN3_AMT") 	= ds_print4.namevalue(1,"VEN3_AMT");//2014년 투자
			ds_print.namevalue(row,"CARD_AMT") 	= ds_print4.namevalue(1,"CARD_AMT");//신용카드
			ds_print.namevalue(row,"DIR_CARD_AMT") 	= ds_print4.namevalue(1,"DIR_CARD_AMT");//직불카드
			ds_print.namevalue(row,"CASH_AMT") 			= ds_print4.namevalue(1,"CASH_AMT");//현금영수증
			ds_print.namevalue(row,"MARKET_AMT") 		= ds_print4.namevalue(1,"MARKET_AMT");//전통시장
			ds_print.namevalue(row,"PUBLIC_AMT") 		= ds_print4.namevalue(1,"PUBLIC_AMT");//대중교통
			ds_print.namevalue(row,"CARD_SUM") 			= ds_print4.namevalue(1,"CARD_SUM");//카드 합계		
			ds_print.namevalue(row,"SAJU_AMT") 			= ds_print4.namevalue(1,"SAJU_AMT");//우리사주조합출연금					
			ds_print.namevalue(row,"LSS_AMT") 			= ds_print4.namevalue(1,"LSS_AMT");//장기집합투자증권저축
		
			/*연금계좌, 보험료*/				
			ds_print.namevalue(row,"ANN_AMT") 		= ds_print4.namevalue(1,"ANN_AMT");//연금저축
			ds_print.namevalue(row,"LIN_AMT") 		= ds_print4.namevalue(1,"LIN_AMT");//보장성보험
			ds_print.namevalue(row,"LIH_AMT") 		= ds_print4.namevalue(1,"LIH_AMT");//장애인전용보험		
			ds_print.namevalue(row,"LI_SUM") 			= ds_print4.namevalue(1,"LI_SUM");//보험료계		

			/*의료비*/		
			ds_print.namevalue(row,"HEA_AMT") 		= ds_print4.namevalue(1,"HEA_AMT");//본인, 경로, 장애인의료비
			ds_print.namevalue(row,"OHEA_AMT") 		= ds_print4.namevalue(1,"OHEA_AMT");//그밖의	
			ds_print.namevalue(row,"HEA_SUM") 		= ds_print4.namevalue(1,"HEA_SUM");//의료비 합계

			/*교육비	*/	
			ds_print.namevalue(row,"TAG1_CNT") 		= ds_print4.namevalue(1,"TAG1_CNT");//취학전
			ds_print.namevalue(row,"TAG2_CNT") 		= ds_print4.namevalue(1,"TAG2_CNT");//초중고	
			ds_print.namevalue(row,"TAG3_CNT") 		= ds_print4.namevalue(1,"TAG3_CNT");//대학생			
			ds_print.namevalue(row,"TAG4_CNT") 		= ds_print4.namevalue(1,"TAG4_CNT");//장애인
			ds_print.namevalue(row,"GRA_AMT") 		= ds_print4.namevalue(1,"GRA_AMT");//그밖의
			ds_print.namevalue(row,"EDU_AMT1") 		= ds_print4.namevalue(1,"EDU_AMT1");//취학전
			ds_print.namevalue(row,"EDU_AMT2") 		= ds_print4.namevalue(1,"EDU_AMT2");//초중고	
			ds_print.namevalue(row,"EDU_AMT3") 		= ds_print4.namevalue(1,"EDU_AMT3");//대학생		
			ds_print.namevalue(row,"HED_AMT") 		= ds_print4.namevalue(1,"HED_AMT");//장애인				
			ds_print.namevalue(row,"EDU_SUM") 		= ds_print4.namevalue(1,"EDU_SUM");//교육비 합계		

			/*기부금	*/	
			ds_print.namevalue(row,"GOV1_AMT") 		= ds_print4.namevalue(1,"GOV1_AMT");//정치자금1
			ds_print.namevalue(row,"GOV2_AMT") 		= ds_print4.namevalue(1,"GOV2_AMT");//정치자금2
			ds_print.namevalue(row,"LC1_AMT") 		= ds_print4.namevalue(1,"LC1_AMT");//법정기부금			
			ds_print.namevalue(row,"LC23_AMT") 		= ds_print4.namevalue(1,"LC23_AMT");//(종교단체외+종교단체)지정기부금	
			ds_print.namevalue(row,"LCC_SUM") 		= ds_print4.namevalue(1,"LCC_SUM");//법정기부금				
			
			ds_print.namevalue(row,"MM") 		    	= ds_print4.namevalue(1,"TODAY").substring(4,6);//오늘				
			ds_print.namevalue(row,"DD") 		    	= ds_print4.namevalue(1,"TODAY").substring(6,8);//오늘		

			//연금등등등
			var no2 = 1;
			for(i=1;i<=ds_print5.countrow;i++){
				  if(ds_print5.namevalue(i,"DUDGB")=="21"){
					  ds_print.namevalue(row,"DUDGBNM2_"+no2)="개인연금저축";										//개인연금저축
					  ds_print.namevalue(row,"FINANM2_"+no2)	=ds_print5.namevalue(i,"FINANM");				//금융기관상호
					  ds_print.namevalue(row,"ACCNO2_"+no2)	=ds_print5.namevalue(i,"ACCNO");				//계좌번호
					  ds_print.namevalue(row,"PAYAMT2_"+no2)	=ds_print5.namevalue(i,"PAYAMT");				//불입금액
					  ds_print.namevalue(row,"DEDAMT2_"+no2)	=ds_print5.namevalue(i,"DEDAMT");				//공제금액
					  no2++;
					}else if(ds_print5.namevalue(i,"DUDGB")=="22"){
					  ds_print.namevalue(row,"DUDGBNM2_"+no2)	="연금저축";											//연금저축
					  ds_print.namevalue(row,"FINANM2_"+no2)	=ds_print5.namevalue(i,"FINANM");				//금융기관상호
					  ds_print.namevalue(row,"ACCNO2_"+no2)	=ds_print5.namevalue(i,"ACCNO");				//계좌번호
					  ds_print.namevalue(row,"PAYAMT2_"+no2)	=ds_print5.namevalue(i,"PAYAMT");				//불입금액
					  ds_print.namevalue(row,"DEDAMT2_"+no2)	=ds_print5.namevalue(i,"DEDAMT");				//공제금액
					  no2++;
					}
			}

			var no3 = 1;
			for(i=1;i<=ds_print5.countrow;i++){
				  if(ds_print5.namevalue(i,"DUDGB")=="31"){
					  ds_print.namevalue(row,"DUDGBNM3_"+no3)="청약저축";												//청약저축
					  ds_print.namevalue(row,"FINANM3_"+no3)	=ds_print5.namevalue(i,"FINANM");				//금융기관상호
					  ds_print.namevalue(row,"ACCNO3_"+no3)	=ds_print5.namevalue(i,"ACCNO");				//계좌번호
					  ds_print.namevalue(row,"PAYAMT3_"+no3)	=ds_print5.namevalue(i,"PAYAMT");				//불입금액
					  ds_print.namevalue(row,"DEDAMT3_"+no3)	=ds_print5.namevalue(i,"DEDAMT");				//공제금액
					  no3++;
					}else if(ds_print5.namevalue(i,"DUDGB")=="32"){
					  ds_print.namevalue(row,"DUDGBNM3_"+no3)="주택청약종합저축";									//주택청약종합저축
					  ds_print.namevalue(row,"FINANM3_"+no3)	=ds_print5.namevalue(i,"FINANM");				//금융기관상호
					  ds_print.namevalue(row,"ACCNO3_"+no3)	=ds_print5.namevalue(i,"ACCNO");				//계좌번호
					  ds_print.namevalue(row,"PAYAMT3_"+no3)	=ds_print5.namevalue(i,"PAYAMT");				//불입금액
					  ds_print.namevalue(row,"DEDAMT3_"+no3)	=ds_print5.namevalue(i,"DEDAMT");				//공제금액
					  no3++;
					}else if(ds_print5.namevalue(i,"DUDGB")=="34"){
					  ds_print.namevalue(row,"DUDGBNM3_"+no3)="근로자주택마련저축";								//근로자주택마련저축
					  ds_print.namevalue(row,"FINANM3_"+no3)	=ds_print5.namevalue(i,"FINANM");				//금융기관상호
					  ds_print.namevalue(row,"ACCNO3_"+no3)	=ds_print5.namevalue(i,"ACCNO");				//계좌번호
					  ds_print.namevalue(row,"PAYAMT3_"+no3)	=ds_print5.namevalue(i,"PAYAMT");				//불입금액
					  ds_print.namevalue(row,"DEDAMT3_"+no3)	=ds_print5.namevalue(i,"DEDAMT");				//공제금액
					  no3++;
					}
			}

			var no4 = 1;
			for(i=1;i<=ds_print5.countrow;i++){
				  if(ds_print5.namevalue(i,"DUDGB")=="51"){																	//장기집합투자증권저축
					  ds_print.namevalue(row,"FINANM4_"+no4)	=ds_print5.namevalue(i,"FINANM");				//금융기관상호
					  ds_print.namevalue(row,"ACCNO4_"+no4)	=ds_print5.namevalue(i,"ACCNO");				//계좌번호
					  ds_print.namevalue(row,"YEARLY4_"+no4)	=ds_print5.namevalue(i,"YEARLY");				//납입연차
					  ds_print.namevalue(row,"PAYAMT4_"+no4)	=ds_print5.namevalue(i,"PAYAMT");				//불입금액
					  ds_print.namevalue(row,"DEDAMT4_"+no4)	=ds_print5.namevalue(i,"DEDAMT");				//공제금액
					  no4++;
					}
			}

			gcrp_print.Preview();			
			
        }

        /******************************************************************************
        	Description : 출력format
        ******************************************************************************/
        	function ln_Rpt_SetDataHeader(){ //출력물 데이타 셋헤드 생성
        		
        		var ls_temp = "";
        	
        		if (ds_print.countrow<1){
        			
        			ds_print.SetDataHeader(ls_temp);
        			
			        ls_temp1 = "EMPNO:STRING(7),EMPNMK:STRING(20),EMPJUNO:STRING(14),MM:STRING(2),DD:STRING(2),ADDRESS:STRING(50),TELNO:STRING(15),"
			
			        + "EMPJUNO1:STRING(1),EMPJUNO2:STRING(1),EMPJUNO3:STRING(1),EMPJUNO4:STRING(1),EMPJUNO5:STRING(1),EMPJUNO6:STRING(1),EMPJUNO7:STRING(1),EMPJUNO8:STRING(1),"
			
			        + "ADDRESS:STRING(120),TELNO:STRING(15),HOL_YN:STRING(50),WORKDAY:STRING(50),CLS_TAG:STRING(80),"     
			        + "REF10_S:DECIMAL(9.0),REF11_S:DECIMAL(9.0),REF12_S:DECIMAL(9.0),REF13_S:DECIMAL(9.0),REF14_S:DECIMAL(9.0),REF15_S:DECIMAL(9.0),REF16_S:DECIMAL(9.0),REF17_S:DECIMAL(9.0),REF18_S:DECIMAL(9.0),REF19_S:DECIMAL(9.0),"
			        + "REF21_S:DECIMAL(9.0),REF22_S:DECIMAL(9.0),REF23_S:DECIMAL(9.0),REF24_S:DECIMAL(9.0),REF25_S:DECIMAL(9.0),REF27_S:DECIMAL(9.0),REF28_S:DECIMAL(9.0),REF29_S:DECIMAL(9.0),"
			        + "CNT:INT(2),"	
			        
			        + "EMPNMK_1:STRING(20),EMPJUNO_1:STRING(13),"			        
			        + "RELAT1_1:STRING(1),REF1_1:STRING(1),REF2_1:STRING(1),REF3_1:STRING(1),REF4_1:STRING(1),REF5_1:STRING(1),REF6_1:STRING(1),"
			        + "REF10_1:DECIMAL(9.0),REF11_1:DECIMAL(9.0),REF12_1:DECIMAL(9.0),REF13_1:DECIMAL(9.0),REF14_1:DECIMAL(9.0),REF15_1:DECIMAL(9.0),REF16_1:DECIMAL(9.0),REF17_1:DECIMAL(9.0),REF18_1:DECIMAL(9.0),REF19_1:DECIMAL(9.0),"
			        + "REF21_1:DECIMAL(9.0),REF22_1:DECIMAL(9.0),REF23_1:DECIMAL(9.0),REF24_1:DECIMAL(9.0),REF25_1:DECIMAL(9.0),REF27_1:DECIMAL(9.0),REF28_1:DECIMAL(9.0),REF29_1:DECIMAL(9.0),"
			        
			        + "EMPNMK_2:STRING(20),EMPJUNO_2:STRING(13),"
			        + "RELAT1_2:STRING(1),REF1_2:STRING(1),REF2_2:STRING(1),REF3_2:STRING(1),REF4_2:STRING(1),REF5_2:STRING(1),REF6_2:STRING(1),"
			        + "REF11_2:DECIMAL(9.0),REF12_2:DECIMAL(9.0),REF13_2:DECIMAL(9.0),REF14_2:DECIMAL(9.0),REF15_2:DECIMAL(9.0),REF16_2:DECIMAL(9.0),REF17_2:DECIMAL(9.0),REF18_2:DECIMAL(9.0),REF19_2:DECIMAL(9.0),"
			        + "REF21_2:DECIMAL(9.0),REF22_2:DECIMAL(9.0),REF23_2:DECIMAL(9.0),REF24_2:DECIMAL(9.0),REF25_2:DECIMAL(9.0),REF27_2:DECIMAL(9.0),REF28_2:DECIMAL(9.0),REF29_2:DECIMAL(9.0),"
			        
			        + "EMPNMK_3:STRING(20),EMPJUNO_3:STRING(13),"
			        + "RELAT1_3:STRING(1),REF1_3:STRING(1),REF2_3:STRING(1),REF3_3:STRING(1),REF4_3:STRING(1),REF5_3:STRING(1),REF6_3:STRING(1),"
			        + "REF11_3:DECIMAL(9.0),REF12_3:DECIMAL(9.0),REF13_3:DECIMAL(9.0),REF14_3:DECIMAL(9.0),REF15_3:DECIMAL(9.0),REF16_3:DECIMAL(9.0),REF17_3:DECIMAL(9.0),REF18_3:DECIMAL(9.0),REF19_3:DECIMAL(9.0),"
			        + "REF21_3:DECIMAL(9.0),REF22_3:DECIMAL(9.0),REF23_3:DECIMAL(9.0),REF24_3:DECIMAL(9.0),REF25_3:DECIMAL(9.0),REF27_3:DECIMAL(9.0),REF28_3:DECIMAL(9.0),REF29_3:DECIMAL(9.0),"
			        
			        + "EMPNMK_4:STRING(20),EMPJUNO_4:STRING(13),"
			        + "RELAT1_4:STRING(1),REF1_4:STRING(1),REF2_4:STRING(1),REF3_4:STRING(1),REF4_4:STRING(1),REF5_4:STRING(1),REF6_4:STRING(1),"
			        + "REF11_4:DECIMAL(9.0),REF12_4:DECIMAL(9.0),REF13_4:DECIMAL(9.0),REF14_4:DECIMAL(9.0),REF15_4:DECIMAL(9.0),REF16_4:DECIMAL(9.0),REF17_4:DECIMAL(9.0),REF18_4:DECIMAL(9.0),REF19_4:DECIMAL(9.0),"
			        + "REF21_4:DECIMAL(9.0),REF22_4:DECIMAL(9.0),REF23_4:DECIMAL(9.0),REF24_4:DECIMAL(9.0),REF25_4:DECIMAL(9.0),REF27_4:DECIMAL(9.0),REF28_4:DECIMAL(9.0),REF29_4:DECIMAL(9.0),"
			        
			        + "EMPNMK_5:STRING(20),EMPJUNO_5:STRING(13),"
			        + "RELAT1_5:STRING(1),REF1_5:STRING(1),REF2_5:STRING(1),REF3_5:STRING(1),REF4_5:STRING(1),REF5_5:STRING(1),REF6_5:STRING(1),"
			        + "REF11_5:DECIMAL(9.0),REF12_5:DECIMAL(9.0),REF13_5:DECIMAL(9.0),REF14_5:DECIMAL(9.0),REF15_5:DECIMAL(9.0),REF16_5:DECIMAL(9.0),REF17_5:DECIMAL(9.0),REF18_5:DECIMAL(9.0),REF19_5:DECIMAL(9.0),"
			        + "REF21_5:DECIMAL(9.0),REF22_5:DECIMAL(9.0),REF23_5:DECIMAL(9.0),REF24_5:DECIMAL(9.0),REF25_5:DECIMAL(9.0),REF27_5:DECIMAL(9.0),REF28_5:DECIMAL(9.0),REF29_5:DECIMAL(9.0),"
			        
			        + "EMPNMK_6:STRING(20),EMPJUNO_6:STRING(13),"
			        + "RELAT1_6:STRING(1),REF1_6:STRING(1),REF2_6:STRING(1),REF3_6:STRING(1),REF4_6:STRING(1),REF5_6:STRING(1),REF6_6:STRING(1),"
			        + "REF11_6:DECIMAL(9.0),REF12_6:DECIMAL(9.0),REF13_6:DECIMAL(9.0),REF14_6:DECIMAL(9.0),REF15_6:DECIMAL(9.0),REF16_6:DECIMAL(9.0),REF17_6:DECIMAL(9.0),REF18_6:DECIMAL(9.0),REF19_6:DECIMAL(9.0),"
			        + "REF21_6:DECIMAL(9.0),REF22_6:DECIMAL(9.0),REF23_6:DECIMAL(9.0),REF24_6:DECIMAL(9.0),REF25_6:DECIMAL(9.0),REF27_6:DECIMAL(9.0),REF28_6:DECIMAL(9.0),REF29_6:DECIMAL(9.0),"
			        
			        + "EMPNMK_7:STRING(20),EMPJUNO_7:STRING(13),"
			        + "RELAT1_7:STRING(1),REF1_7:STRING(1),REF2_7:STRING(1),REF3_7:STRING(1),REF4_7:STRING(1),REF5_7:STRING(1),REF6_7:STRING(1),"
			        + "REF11_7:DECIMAL(9.0),REF12_7:DECIMAL(9.0),REF13_7:DECIMAL(9.0),REF14_7:DECIMAL(9.0),REF15_7:DECIMAL(9.0),REF16_7:DECIMAL(9.0),REF17_7:DECIMAL(9.0),REF18_7:DECIMAL(9.0),REF19_7:DECIMAL(9.0),"
			        + "REF21_7:DECIMAL(9.0),REF22_7:DECIMAL(9.0),REF23_7:DECIMAL(9.0),REF24_7:DECIMAL(9.0),REF25_7:DECIMAL(9.0),REF27_7:DECIMAL(9.0),REF28_7:DECIMAL(9.0),REF29_7:DECIMAL(9.0),"
			        
			        + "EMPNMK_8:STRING(20),EMPJUNO_8:STRING(13),"
			        + "RELAT1_8:STRING(1),REF1_8:STRING(1),REF2_8:STRING(1),REF3_8:STRING(1),REF4_8:STRING(1),REF5_8:STRING(1),REF6_8:STRING(1),"
			        + "REF11_8:DECIMAL(9.0),REF12_8:DECIMAL(9.0),REF13_8:DECIMAL(9.0),REF14_8:DECIMAL(9.0),REF15_8:DECIMAL(9.0),REF16_8:DECIMAL(9.0),REF17_8:DECIMAL(9.0),REF18_8:DECIMAL(9.0),REF19_8:DECIMAL(9.0),"
			        + "REF21_8:DECIMAL(9.0),REF22_8:DECIMAL(9.0),REF23_8:DECIMAL(9.0),REF24_8:DECIMAL(9.0),REF25_8:DECIMAL(9.0),REF27_8:DECIMAL(9.0),REF28_8:DECIMAL(9.0),REF29_8:DECIMAL(9.0),"

			        + "JAQ_AMT:DECIMAL(9.0),NPEN_AMT:DECIMAL(9.0),JAR_AMT:DECIMAL(9.0),PEN_SUM:DECIMAL(9.0),"
			        + "JAH_AMT:DECIMAL(9.0),HEALTH_AMT:DECIMAL(9.0),JAP_AMT:DECIMAL(9.0),HINS_AMT:DECIMAL(9.0),HIN_SUM:DECIMAL(9.0),"
			        + "LH1_AMT:DECIMAL(9.0),LH2_AMT:DECIMAL(9.0),LH3_AMT:DECIMAL(9.0),LH4_AMT:DECIMAL(9.0),"
			        + "LH5_AMT:DECIMAL(9.0),LH6_AMT:DECIMAL(9.0),LH7_AMT:DECIMAL(9.0),LH8_AMT:DECIMAL(9.0),LH_SUM:DECIMAL(9.0),"
			        + "PER_AMT:DECIMAL(9.0),LHO_AMT:DECIMAL(9.0),LHR_AMT:DECIMAL(9.0),LHP_AMT:DECIMAL(9.0),"
			        + "VEN_AMT:DECIMAL(9.0),VEN2_AMT:DECIMAL(9.0),VEN3_AMT:DECIMAL(9.0),"
			        + "CARD_AMT:DECIMAL(9.0),DIR_CARD_AMT:DECIMAL(9.0),CASH_AMT:DECIMAL(9.0),MARKET_AMT:DECIMAL(9.0),PUBLIC_AMT:DECIMAL(9.0),CARD_SUM:DECIMAL(9.0),"
			        + "SAJU_AMT:DECIMAL(9.0),LSS_AMT:DECIMAL(9.0),ANN_AMT:DECIMAL(9.0),LIN_AMT:DECIMAL(9.0),LIH_AMT:DECIMAL(9.0),LI_SUM:DECIMAL(9.0),HEA_AMT:DECIMAL(9.0),OHEA_AMT:DECIMAL(9.0),HEA_SUM:DECIMAL(9.0),"
			        + "TAG1_CNT:STRING(5),TAG2_CNT:STRING(5),TAG3_CNT:STRING(5),TAG4_CNT:STRING(5),"			        
			        + "GRA_AMT:DECIMAL(9.0),EDU_AMT1:DECIMAL(9.0),EDU_AMT2:DECIMAL(9.0),EDU_AMT3:DECIMAL(9.0),HED_AMT:DECIMAL(9.0),EDU_SUM:DECIMAL(9.0),"
			        + "GOV1_AMT:DECIMAL(9.0),GOV2_AMT:DECIMAL(9.0),LC1_AMT:DECIMAL(9.0),LC23_AMT:DECIMAL(9.0),LCC_SUM:DECIMAL(9.0),"	        
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
			        + "FINANM4_1:STRING(50),ACCNO4_1:STRING(20),PAYAMT4_1:DECIMAL(9.0),DEDAMT4_1:DECIMAL(9.0),"
			        + "FINANM4_2:STRING(50),ACCNO4_2:STRING(20),PAYAMT4_2:DECIMAL(9.0),DEDAMT4_2:DECIMAL(9.0),"
			        + "FINANM4_3:STRING(50),ACCNO4_3:STRING(20),PAYAMT4_3:DECIMAL(9.0),DEDAMT4_3:DECIMAL(9.0),"
			        + "FINANM4_4:STRING(50),ACCNO4_4:STRING(20),PAYAMT4_4:DECIMAL(9.0),DEDAMT4_4:DECIMAL(9.0)";			        
			        
        			ds_print.SetDataHeader(ls_temp1);
        		}
        	}
        

        
        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {
        	
            if (dsT_AC_RETACC.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_AC_RETACC.GridToExcel("연말정산자료등록", '', 225);
            
        }

        /********************************************
         * 07. 신규 함수                                *
         ********************************************/
        function fnc_AddNew() {

        }

        /********************************************
         * 08. 추가 함수                                *
         ********************************************/
        function fnc_Append() {

        }

        /********************************************
         * 09. 제거 함수                                *
         ********************************************/
        function fnc_Remove() {

        }

        /********************************************
         * 10. 초기화 함수                           *
         ********************************************/
        function fnc_Clear() {
        	
            document.getElementById("resultMessage").innerText = ' ';

            dsT_AC_RETACC.ClearData();
            dsT_AC_FAMILY.ClearData();    //부양가족사항 clear
            
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
        	
			window.close();

        }

        /********************************************
         * 12. 검색 조건 유효성 검사                     *
         ********************************************/
        function fnc_SearchItemCheck() {
        	
            return fnc_CheckElement(oElementList, oElementMsgList, oExceptionList);
            
        }

        /********************************************
         * 13. 저장 유효성 체크                        *
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분         *
         ********************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("txtPIS_YY_SHR").value = '2014';
            
            if(dsTemp != "Modal"){            
            //사번을 로그인한 사번으로 설정한 다음 기본정보를 가져온다.
            document.getElementById("txtENO_NO_SHR").value = gusrid;            
            document.getElementById("txtENO_NM_SHR").value = gusrnm;   
            }else{
            //사번을 전달받은 사번으로 설정한 다음 기본정보를 가져온다.
            document.getElementById("txtENO_NO_SHR").value = ENO_NO;            
            document.getElementById("txtENO_NM_SHR").value = '';
            fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');           	
            }
            

    		//관리자가 아닐 경우 타인은 조회가 되지 않게
			if(gusrid != "6060002" && gusrid != "2030007" && gusrid != "2140002" ){
				
	            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
	            fnc_ChangeStateElement(false, "ImgEnoNo");
	            document.getElementById("ImgEnoNo").style.display = "none";

	            fnc_ChangeStateElement(false, "txtADDRESS");
	            fnc_ChangeStateElement(false, "ImgZipNo");
	            //document.getElementById("ImgZipNo").style.display = "none";
				//document.getElementById("imgPrint").style.display = "none";
				
			}

            fnc_ChangeStateElement(false, "ImgEnoNo");
            document.getElementById("ImgEnoNo").style.display = "none";    		
    		
			//사원정보를 가져오고 등록한 중간정산 리스트를 가져온다.
            fnc_SearchList();

            cfStyleGrid_New(form1.grdT_AC_FAMILY,0,"false","false");      // Grid Style 적용
    		
    		
			if(dsT_AC_RETACC.NameValue(1, "FUN_CNT") == "Y" && submit_chk == "N"){

				fnc_disableInput();
				
			}else{

				fnc_enableInput();
				
			}            
            
			if(dsT_AC_RETACC.NameValue(1, "CLS_TAG") == "Y" ){
				document.getElementById("chkCLS_TAG").checked = true;
			}else{
				document.getElementById("chkCLS_TAG").checked = false;
			}
			
			//alert(dsT_AC_RETACC.NameValue(1, "FUN_CNT") );
			
			//if(dsT_AC_RETACC.NameValue(1, "FUN_CNT") == "Y" ){
			//	alert("전산제출한 상태입니다.\n수정은 불가능합니다.");
			//}




        }

        /********************************************
         * 15. 단축키 처리                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * 기타 함수              *
         ********************************************/
        /**
         * 인적공제 항목 변동 여부
         */
         
        function checkFamily(param) {

            var CLS_TAG;
            var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
 
            if(document.getElementById("chkCLS_TAG").checked == true) {
            	CLS_TAG = 'Y';
            }else{
            	CLS_TAG = 'N';
            }

            // 인적공제 항목 정보 전년과 동일 체크
            params = "&S_MODE=SAV_CLS_14"
                   	+ "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value
            		+ "&CLS_TAG="+CLS_TAG
                    + "&PIS_YY="+PIS_YY;            		
            
            //DataSet을 입력상태로 변경
            dsT_AC_RETACC.UseChangeInfo = false;

            trT_AC_RETACC_SAV.KeyValue = "TR_SAV"
                                       + "(I:dsT_AC_RETACC=dsT_AC_RETACC)";
            trT_AC_RETACC_SAV.action = dataClassName+params;
            trT_AC_RETACC_SAV.post();
            
        }

        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {

        	fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR','','','','','0');

            if (document.getElementById("txtENO_NO_SHR").value  != "") {

            	fnc_SearchList();
            }
            
        }

        /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */
        function fnc_SearchEmpNm() {
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");
            fnc_SearchEmpNo();
        }

        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
        	
            var obj = new String;
            
            // 정규직 전체
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO_SHR").value      = obj.eno_no;
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;

            } else {
                document.getElementById("txtENO_NO_SHR").value      = "";
                document.getElementById("txtENO_NM_SHR").value      = "";

            }
        }

       function fnc_GetNm() {
                fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');
       }

        function fnc_Getcd() {
                fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');
        }


        /********************************************
         * 									전산제출                         				*
         ********************************************/

        function fnc_Submit() {
        	
            var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
            
        	if(submit_chk == "N"){

	            if(confirm("전산제출 하시면 더이상 수정하실 수 없습니다.\n제출하시겠습니까?")) {
	
	                //연말정산 전산제출
	                params = "&S_MODE=SAV_END_14"
	                   	+ "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value
                   	    + "&SUBMIT_TAG=Y"
                        + "&PIS_YY="+PIS_YY;            	                   	    
	            
		            //DataSet을 입력상태로 변경
		            dsT_AC_RETACC.UseChangeInfo = false;
		
		            trT_AC_RETACC_SAV.KeyValue = "TR_SAV"
		                                       + "(I:dsT_AC_RETACC=dsT_AC_RETACC)";
		            trT_AC_RETACC_SAV.action = dataClassName+params;
		            trT_AC_RETACC_SAV.post();
		            
		            submit_chk == "Y"
		
		            }
        	}else{

				alert("이미 전산제출하셨습니다.");

				//관리자 경우
				if(gusrid == "6060002" || gusrid == "2030007" || gusrid == "2140002") {

		            if(confirm("담당자이시군요.\n전산제출을 취소하시겠습니까?")) {

		                //연말정산 전산제출 취소
		                params = "&S_MODE=SAV_END_14"
		                   	+ "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value
	                   	    + "&SUBMIT_TAG=N"
	                        + "&PIS_YY="+PIS_YY;            		                   	    
                   	                
			            //DataSet을 입력상태로 변경
			            dsT_AC_RETACC.UseChangeInfo = false;
			
			            trT_AC_RETACC_SAV.KeyValue = "TR_SAV"
			                                       + "(I:dsT_AC_RETACC=dsT_AC_RETACC)";
			            trT_AC_RETACC_SAV.action = dataClassName+params;
			            trT_AC_RETACC_SAV.post();
		            	
					}
		            submit_chk = "N";
		            fnc_SearchList();
		
        		}

				return;
            }     
        	
    }
        
        /********************************************
         * 부양가족사항 함수                        *
         ********************************************/

        /* 01. 조회 함수_List 형태의 조회  */
        function fnc_SearchList_01() {

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;

            params_01 = "&S_MODE=SHR_14"
                   + "&PIS_YY="+PIS_YY
                   + "&ENO_NO="+ENO_NO;

            dsT_AC_FAMILY.dataid = dataClassName_01+params_01;
            dsT_AC_FAMILY.reset();
         }


        /* 02. 삭제 함수   */
        function fnc_Delete_01() {


            // 삭제 할 자료가 있는지 체크하고
             if (dsT_AC_FAMILY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                alert("* 삭제 할 자료가 없습니다!");
                return;
              }

             if(dsT_AC_FAMILY.NameValue(dsT_AC_FAMILY.RowPosition, "REL_NM") == "본인"){
                alert("본인 자료는 삭제할 수 없습니다.");
                return false;
             }

             // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
             if (confirm(dsT_AC_FAMILY.NameValue(dsT_AC_FAMILY.RowPosition, "NAM_KOR")+" [" + dsT_AC_FAMILY.NameValue(dsT_AC_FAMILY.RowPosition, "CET_NO") + "] 자료를 제거하시겠습니까?") == false) return;

             //DataSet을 입력상태로 변경
             dsT_AC_FAMILY.UseChangeInfo = false;

             var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
             var ENO_NO = document.getElementById("txtENO_NO_SHR").value;

             var tmpCnt = dsT_AC_FAMILY.RowPosition-1;

             params_01 = "&S_MODE=DEL_14"
                     + "&PIS_YY="+PIS_YY
                     + "&ENO_NO="+ENO_NO
                     + "&ROW_ID="+tmpCnt;

             trT_AC_FAMILY.KeyValue = "TR_SAV(I:dsT_AC_FAMILY=dsT_AC_FAMILY)";
             trT_AC_FAMILY.Action = dataClassName_01+params_01;
             trT_AC_FAMILY.post();
             fnc_SearchList_01();
         }

         /* 03. 초기화 함수   */
          function fnc_Clear_01() {
            document.getElementById("resultMessage").innerText = ' ';

            dsT_AC_FAMILY.ClearData();
          }



          /* 05.  부양가족사항등록   */
          function fnc_RegFamily() {

              if(submit_chk == "Y"){
                  alert("전산제출하셨습니다.\n담당자에게 문의바랍니다.");
                  return;
              }  

            var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
            var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
            var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
            var DPT_NM = document.getElementById("txtDPT_NM").value;
            var JOB_NM = document.getElementById("txtJOB_NM").value;
            
            
            var href_page = "yaca022_14.jsp"
                          + "?TYPE=INS"
                          + "&PIS_YY="+PIS_YY
                          + "&ENO_NO="+ENO_NO
                          + "&ENO_NM="+ENO_NM
                          + "&DPT_NM="+DPT_NM
                          + "&JOB_NM="+JOB_NM
                          + "&END_YN="+submit_chk                           
                          + "&gusrid="+gusrid;                          

            window.showModalDialog(href_page, "", "dialogWidth:660px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList_01();
           }

           /* 06.  연금저축공제등록   */
          function fnc_RegPension() {

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
           var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
           var DPT_NM = document.getElementById("txtDPT_NM").value;
           var JOB_NM = document.getElementById("txtJOB_NM").value;

           var href_page = "yaca060_14.jsp"
                      + "?PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&ENO_NM="+ENO_NM
                      + "&DPT_NM="+DPT_NM
                      + "&JOB_NM="+JOB_NM
                      + "&HOL_YN="+dsT_AC_RETACC.NameValue(1, "HOL_YN")
                      + "&END_YN="+submit_chk 
                      + "&gusrid="+gusrid                          
           ;
           
           //prompt(this,href_page);

            window.showModalDialog(href_page, "", "dialogWidth:950px; dialogHeight:650px; help:No; resizable:Yes; status:No; scroll:Yes; center:Yes;");
            
           }


          /* 07.  의료비공제등록   */
          function fnc_RegHospital(row) {

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
           var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
           var DPT_NM = document.getElementById("txtDPT_NM").value;
           var JOB_NM = document.getElementById("txtJOB_NM").value;

           var href_page = "yaca030_14.jsp"
                      + "?PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&ENO_NM="+ENO_NM
                      + "&DPT_NM="+DPT_NM
                      + "&JOB_NM="+JOB_NM
                      + "&REL_CD="+dsT_AC_FAMILY.NameValue(row, "REL_CD")
                      + "&NAM_KOR="+dsT_AC_FAMILY.NameValue(row, "NAM_KOR")                          
                      + "&CET_NO="+dsT_AC_FAMILY.NameValue(row, "CET_NO")
                      + "&TRB_MAN="+dsT_AC_FAMILY.NameValue(row, "TRB_MAN")                      
                      + "&END_YN="+submit_chk  
                      + "&gusrid="+gusrid                        
           ;
          
           //prompt(this,href_page);
            window.showModalDialog(href_page, "", "dialogWidth:950px; dialogHeight:650px; help:No; resizable:Yes; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList_01();
          }
          
          /* 08.  기부금공제등록   */
          function fnc_RegDonation(row) {

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
           var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
           var DPT_NM = document.getElementById("txtDPT_NM").value;
           var JOB_NM = document.getElementById("txtJOB_NM").value;

           var href_page = "yaca040_14.jsp"
                      + "?PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&ENO_NM="+ENO_NM
                      + "&DPT_NM="+DPT_NM
                      + "&JOB_NM="+JOB_NM
                      + "&REL_CD="+dsT_AC_FAMILY.NameValue(row, "REL_CD")
                      + "&NAM_KOR="+dsT_AC_FAMILY.NameValue(row, "NAM_KOR")                      
                      + "&CET_NO="+dsT_AC_FAMILY.NameValue(row, "CET_NO")     
                      + "&END_YN="+submit_chk    
                      + "&gusrid="+gusrid                          
           ;

            window.showModalDialog(href_page, "", "dialogWidth:950px; dialogHeight:650px; help:No; resizable:Yes; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList_01();           
          }

          
          /* 09.  종전근무지등록   */
          function fnc_Dutyplace() {

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
           var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
           var DPT_NM = document.getElementById("txtDPT_NM").value;
           var JOB_NM = document.getElementById("txtJOB_NM").value;

           
           //if(ENO_NO.substring(1,3) != '14'){
        	   
        	//   alert("중도입사자가 아니십니다.\n중도입사자만 입력하는 메뉴입니다.");
			//   return false;           
           //} 
           
  
           var href_page = "yaca023_14.jsp"
                      + "?PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&ENO_NM="+ENO_NM
                      + "&DPT_NM="+DPT_NM
                      + "&JOB_NM="+JOB_NM
                      + "&END_YN="+submit_chk                          
           ;

            window.showModalDialog(href_page, "", "dialogWidth:850px; dialogHeight:650px; help:No; resizable:Yes; status:No; scroll:Yes; center:Yes;");
           }
          
    </script>
</head>

<!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)           *
    *                                                                                        *
    ***************************************************************************************-->

<!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_RETACC)                |
    | 3. 사용되는 Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
<Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<Object ID="dsT_AC_RETACC" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton               |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_RETACC)           |
    | 3. 사용되는 Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
<Object ID="trT_AC_RETACC" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>

<Object ID="trT_AC_RETACC_SAV" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>

<!-----------------------------------------------------+
    | 부양가족 사항                                         						|
    1 1. 조회용 DataSet                                     			|
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_FAMILY)            |
    | 3. 사용되는 Table List(T_AC_FAMILY)                   	|
    +------------------------------------------------------->
<Object ID="dsT_AC_FAMILY_OLD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<Object ID="dsT_AC_FAMILY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<Object ID="dsT_AC_MEDICAL2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 				Value="True">
		<Param Name="UseChangeInfo" 		Value="True">
		<Param Name="ViewDeletedRow" 	Value="False">
        <Param Name="SubsumExpr" 	  		Value="total">
</Object>

<Object ID="dsT_AC_DONATION2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
        <Param Name="SubsumExpr" 	  Value="total">
</Object>

<object id=ds_print ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<param name="SyncLoad" 	value="false">
</object>

<object id=ds_print2 ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<param name="SyncLoad" 	value="true">
</object>

<object id=ds_print3 ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<param name="SyncLoad" 	value="true">
</object>

<object id=ds_print4 ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<param name="SyncLoad" 	value="true">
</object>

<object id=ds_print5 ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<param name="SyncLoad" 	value="true">
</object>
<!-----------------------------------------------------+
    | 부양가족 사항                                        |
    1 1. 자료 저장 및 조회용 Data Transacton               |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_FAMILY)           |
    | 3. 사용되는 Table List(T_AC_FAMILY)                  |
    +------------------------------------------------------>
<Object ID="trT_AC_FAMILY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>


<!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                  *
    *                                                                                        *
    ***************************************************************************************-->

<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>
<Script For=dsT_AC_RETACC Event="OnLoadCompleted(iCount)">


        if (iCount == 0)    {
            document.getElementById("resultMessage").innerText = "해당 자료가 존재하지 않습니다.";
            dsT_AC_RETACC.ClearData();
            dsT_CM_PERSON.ClearData();
            dsT_AC_FAMILY.ClearData();    //부양가족사항 clear

        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            document.getElementById("resultMessage").innerText = "해당 자료를 조회했습니다.";

            //인사기록표 조회
            dsT_CM_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca020.cmd.YACA020CMD&S_MODE=SHR2_14&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;
            dsT_CM_PERSON.reset();

        }
</Script>


<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
<Script For=dsT_AC_RETACC Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
</Script>

<Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
</Script>

<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
<Script For=dsT_AC_RETACC Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
</Script>

<Script For=dsT_CM_PERSON Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
</Script>

<!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
<script for=trT_AC_RETACC event="OnSuccess()">
        //radio 버튼들 선택하기
        fnc_CheckedElement("radHOL_YN", dsT_AC_RETACC.NameValue(1, "HOL_YN"));
        fnc_CheckedElement("radSOU_YN", dsT_AC_RETACC.NameValue(1, "SOU_YN"));
        fnc_CheckedElement("radWCT_YN", dsT_AC_RETACC.NameValue(1, "WCT_YN"));
</script>

<script for=trT_AC_RETACC_SAV event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("작업을 완료 하였습니다!");
        fnc_SearchList();
</script>

<!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
<script for=trT_AC_RETACC event="OnFail()">
        cfErrorMsg(this);
</script>

<script for=trT_AC_RETACC_SAV event="OnFail()">
        cfErrorMsg(this);
</script>

<!-----------------------------------------------------+
    | Grid Head Check event 처리                                   |
    +------------------------------------------------------>
<script language="javascript" for=grdT_AC_RETACC event=OnHeadCheckClick(Col,Colid,bCheck)>
        //for(var i=1; i<=dsT_AC_RETACC.CountRow; i++) {
        //    dsT_AC_RETACC.NameValue(i, "STATUS") = bCheck;
        //}

</script>

<!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                       *
    *                                                                                        *
    ***************************************************************************************-->

<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>

<Script For=dsT_AC_FAMILY Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("검색하신 조건의 자료가 없습니다!");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_01");
        }
</Script>

<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
<Script For=dsT_AC_FAMILY Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
</Script>

<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
<Script For=dsT_AC_FAMILY Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

<!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
<script for=trT_AC_FAMILY event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("작업을 완료 하였습니다!");
        //fnc_SearchList();
</script>

<!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
<script for=trT_AC_FAMILY event="OnFail()">
        cfErrorMsg(this);
</script>


<!-----------------------------------------------------+
    | Grid OnDblClick event 처리                                   |
    +------------------------------------------------------>
<script language="javascript" for=grdT_AC_FAMILY event=OnDblClick(row,colid)>



        var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
        var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
        var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
        var DPT_NM = document.getElementById("txtDPT_NM").value;
        var JOB_NM = document.getElementById("txtJOB_NM").value;
        
        if(colid != "MED_AMT" && colid != "LC_AMT"){
      	
	        var href_page = "yaca022_14.jsp"
	                      + "?TYPE=UPT"
	                      + "&PIS_YY="+PIS_YY
	                      + "&ENO_NO="+ENO_NO
                          + "&ENO_NM="+ENO_NM
                          + "&DPT_NM="+DPT_NM
                          + "&JOB_NM="+JOB_NM	                      
	                      + "&CET_NO="+dsT_AC_FAMILY.NameValue(row, "CET_NO")
                          + "&END_YN="+submit_chk        	                      
	                      + "&gusrid="+gusrid
	                      ;
	        
	        window.showModalDialog(href_page, "", "dialogWidth:660px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

        }else if(colid == "MED_AMT"){
        	fnc_RegHospital(row);	
        }else if(colid == "LC_AMT"){
        	fnc_RegDonation(row);	        	
        }

        fnc_SearchList();
        
    </script>

<!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->


<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>



<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="1050" border="0" cellspacing="0" cellpadding="0" style="position:relative;left:3px">
	<tr>
		<td valign="center" class="searchState"><span id="resultMessage">&nbsp;</span></td> 
		<td height="30" class="paddingTop5" align="right" valign="top">

		<a href="http://www.yesone.go.kr/index.jsp" target="_blank" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgNts','','../../images/button/btn_NtsOver.gif',1)">
		<img src="../../images/button/btn_NtsOn.gif" name="imgNts" width="65" height="20" border="0" align="absmiddle"></a> 
		&nbsp;&nbsp;&nbsp;&nbsp; 		
		
	 	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_submit.gif',1)">
		<img src="../../images/button/btn_submit.gif" name="imgSave" width="100" height="20" border="0" align="absmiddle" onClick="fnc_Submit()"></a>			
		&nbsp;&nbsp;&nbsp;	&nbsp;

		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)">
		<img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>

        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)">
		<img src="../../images/button/btn_PrintOn.gif" name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> 

		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 --> 


<!-- power Search테이블 시작 --> 
<table width="1050" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="blueTable">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="200"></col>
						<col width="80"></col>
						<col width="140"></col>
						<col width="200"></col>
						<col width="140"></col>												
						<col width=""></col>
					</colgroup>
					<tr>
						<td align="right" class="searchState">귀 속 년 도&nbsp;</td>
						<td class="padding2423">
 							<input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="4" class="input_ReadOnly" readonly> 
						</td>
						<td align="right" class="searchState">사  번&nbsp;</td>
						<td class="padding2423">
							<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) {fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();" style="ime-mode:disabled">
							<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) {fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');fnc_SearchList();">						
                            <!--<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength="7" onkeypress="javascript:if(event.keyCode==13) {fnc_GetNm();fnc_SearchList();}" style="ime-mode:disabled"> 
							<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="14"onkeypress="javascript:if(event.keyCode==13) {fnc_Getcd();fnc_SearchList();}">  -->
							<img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle"
							onclick="fnc_ClickEmpPopup();fnc_SearchList();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)"style="cursor:hand;"> 
							<input type="hidden" id="hidEMPL_DPT_CD">
						</td>
						<td align="right" class="searchState">제출여부&nbsp;</td>						
						<td class="padding2423">
 							<input id="txtFUN_CNTNM" name="txtFUN_CNTNM" size="10" class="input_ReadOnly" readonly> 
						</td>						
					</tr>
				</table>
			</td>
		</tr>
</table>
<!-- power Search테이블 끝 --> 

<br>

<!-- 조건 입력 테이블 시작 -->
<table width="1050" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
				<col width="60"></col>
				<col width="80"></col>
				<col width="60"></col>
				<col width="80"></col>
				<col width="60"></col>
				<col width="80"></col>
				<col width="40"></col>
				<col width=""></col>
				</colgroup>
			<tr>
				<td align="center" class="blueBold">소 속</td>
				<td class="padding2423">
				<input id="txtDPT_NM" style="width:100%;" class="input_ReadOnly" readonly></td>
				<td align="center" class="blueBold">직 위</td>
				<td class="padding2423">
				<input id="txtJOB_NM" style="width:100%;" class="input_ReadOnly" readonly></td>
				<td align="center" class="blueBold">우편번호</td>
				<td class="padding2423">
				<input id="txtZIP_NO" size="10" maxlength="10" class="input_ReadOnly" readonly> 
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgZipNo','','/images/button/btn_HelpOver.gif',1)"></a>
				</td>
				<td align="center" class="blueBold">주 소</td>
				<td class="padding2423">
				<input id="txtADR_CT" style="width:45%" class="input_ReadOnly" readonly> 
				<input id="txtADDRESS" maxlength="60" style="width:45%" class="input_ReadOnly" readonly> 
					<input type=hidden id="txtENO_NO"> 
					<input type=hidden id="txtHEAD_CD"> 
					<input type=hidden id="txtDPT_CD">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 --> 

<br>

<!--버튼테이블시작 -->
<table width="1050" border="0" cellspacing="0" cellpadding="0">
			<tr>
	            <td align="center" class="padding2423">
	                   <button id="btnPRO_STS_1"  style="cursor:hand;width:120pt;height:20pt;" onclick="fnc_RegFamily();"><font color="red"><b>부양가족추가 Click!</b></font></button> 
	            </td>	 

	            <td align="center" class="padding2423">
	                   <button id="btnPRO_STS_2"  style="cursor:hand;width:120pt;height:20pt;" onclick="fnc_RegHospital();"><font color="red"><b>의료비입력 Click!</b></font></button> 
	            </td>	  
	            
	            <td align="center" class="padding2423">
	                   <button id="btnPRO_STS_3"  style="cursor:hand;width:120pt;height:20pt;" onclick="fnc_RegDonation();"><font color="red"><b>기부금입력 Click!</b></font></button> 
	            </td>	  
	            	            
	            <td align="center" class="padding2423">
	                   <button id="btnPRO_STS_4"  style="cursor:hand;width:150pt;height:20pt;" onclick="fnc_RegPension();"><font color="red"><b>연금/주택마련저축  Click!</b></font></button> 
	            </td>	  	
	                        
	            <td align="center" class="padding2423">
	                   <button id="btnPRO_STS_5"  style="cursor:hand;width:120pt;height:20pt;" onclick="fnc_Dutyplace();"><font color="red"><b>종전근무지 Click!</b></font></button> 
	            </td>	            
			</tr>			
</table>		
<!--버튼테이블 끝 -->

	
		
<!--조회테이블시작 -->		
<table width="1050" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
	
				<!-- 조회 상태 테이블 시작 -->
				<table width="1050" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="right" valign="center" class="searchState">
									<input type="checkbox" name="chkCLS_TAG" id="chkCLS_TAG" onclick="checkFamily(this)" style="border:0">&nbsp;선 택
								</td>
								<td align="left" valign="center" class="searchState">
								<font color = "blue">※인적공제 항목이 전년과 동일한 경우에만 체크</font>
								</td>
								<td align="right" valign="center" class="searchState">
								※상세내역을 원하시면 해당내역을 더블클릭
								</td>
								<td height="25" class="paddingTop5" align="right">
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','../../images/button/btn_DeleteOver.gif',1)">
								<img src="../../images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete_01()"></a>
								</td>								
							</tr>
				</table>
				<!-- 조회 상태 테이블 끝 --> 
				
				
				<!-- 내용 조회 그리드 테이블 시작-->
				<table width="1060" border="0" cellspacing="0" cellpadding="0">
							<tr align="center">
								<td>
								<comment id="__NSID__"> 
								<object id="grdT_AC_FAMILY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1050px;height:480px;">						
									<param name="DataID" 				value="dsT_AC_FAMILY">
									<param name="Editable" 				value="false">
									<param name=HiddenHScroll    		value="true">
									<param name="Format"					value='

                                          <FC> id=NO     				width=15        align=center       name=순                	suppress=2  </FC>
                                          <FC> id=REL_NM      		width=81      	align=left	       name=관계              	suppress=2  multiline=true</FC>
                                          <FC> id=NAM_KOR     		width=43        align=left       		name=성명              	suppress=2  </FC>
                                          <C> id=CET_NO       		width=90        align=center       name=주민번호          	suppress=2  </C>
                                          
                                          <C> id=BAS_MAN      		width=30        align=center       name="기본;공제"      suppress=2  </C>
                                          <C> id=GOL_70       		width=30        align=center       name=경로              	suppress=2  </C>
                                          <C> id=TRB_MAN      		width=30        align=center       name="장애;인"        suppress=2  </C>
                                          <C> id=WCT_MAN      		width=30        align=center       name="부녀;자"         suppress=2  </C>
                                          <C> id=ONE_MAN      		width=30        align=center       name="한부;모"         suppress=2  </C>
                                          
                                          
                                          <C> id=GBN_NM       		width=40        align=left     		name=구분                  </C>

                                          <G> name=보험료    HeadBgColor=#dae0ee    TextColor=#34578c  HeadFontStyle = "bold"                                            
                                          <C> id=HIN_SUM      		width=61        align=right        name="건강/고용"          </C>
                                          <C> id=LIN_AMT      		width=61        align=right        name=보장성              </C>                                          
                                          </G>               
                                                                     
                                          <C> id=MED_AMT      		width=61        align=right        name=의료비              </C>
                                          <C> id=EDU_AMT      		width=61        align=right        name=교육비              </C>
                                           
                                          <G> name=신용카드등    HeadBgColor=#dae0ee    TextColor=#34578c  HeadFontStyle = "bold"                              
                                          <C> id=CARD_AMT     		width=61       align=right        name="신용카드"   </C>
                                          <C> id=DIR_CARD_AMT 	width=61       align=right        name="직불/선불"  </C>
                                          <C> id=CASH_AMT     		width=61       align=right        name="현금영수증"  </C>
                                          <C> id=MARKET_AMT     	width=61       align=right        name=전통시장   </C>
                                          <C> id=PUBLIC_AMT      	width=61       align=right        name="대중교통" </C>                                          
                                          </G>
                                          <C> id=LC_AMT      		width=61        align=right        name=기부금              </C>                                                                                   

					                   	'>
								</object> </comment><script> __ShowEmbedObject(__NSID__); </script>
							</td>
						</tr>
				</table>
				<!-- 내용 조회 그리드 데이블 끝-->
		</td>
	</tr>
</table>


<!--총급여 표시 --> 
  
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
          <tr>
               <td class="padding2423">- <font color = "blue">총근로소득액</font>은&nbsp;
                        <input name=txtSALT_AMT id=txtSALT_AMT size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       	원이며 이중 <font color = "blue">비과세(소득외)소득</font>은 
                        <input name=txtFREE_INCOME id=txtFREE_INCOME size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       	원이고 <font color = "blue">과세대상급여</font>는     
                        <input name=txtTAX_INCOME id=txtTAX_INCOME size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       	원입니다.                                     

                        <input name=txtINCM_TAX id=txtINCM_TAX size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                        <input name=txtCITI_TAX id=txtCITI_TAX size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
              </td>
         </tr>          
</table>

<!--총급여 표시 끝 -->
</form>


<!-- form 끝 -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   #### 공제 신고서 ####
------------------------------------------------------------------------------>
<OBJECT id=gcrp_print  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>

	<PARAM NAME="MasterDataID"			VALUE="ds_print">  
	<PARAM NAME="DetailDataID"				VALUE="ds_print">
	<PARAM NAME="PaperSize"				VALUE="A4">	
	<PARAM NAME="LandScape"				VALUE="False">
    <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"			VALUE="200">
	<param name="MargineX"              	value="30">
	<param name="MargineY"              	value="30">
	<PARAM NAME="Format" VALUE="
	
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='1쪽.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='ds_print'


<B>id=Header ,left=0,top=0 ,right=4101 ,bottom=170 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=29 ,top=349 ,right=1950 ,bottom=349 </L>
	<L> left=29 ,top=400 ,right=1950 ,bottom=400 </L>
	<L> left=29 ,top=450 ,right=1950 ,bottom=450 </L>
	<L> left=29 ,top=500 ,right=1950 ,bottom=500 </L>
	<L> left=29 ,top=550 ,right=1950 ,bottom=550 </L>
	<L> left=29 ,top=601 ,right=1950 ,bottom=601 </L>
	<L> left=101 ,top=1180 ,right=1950 ,bottom=1180 </L>
	<L> left=101 ,top=1461 ,right=1950 ,bottom=1461 </L>
	<L> left=101 ,top=1601 ,right=1950 ,bottom=1601 </L>
	<L> left=101 ,top=1741 ,right=1950 ,bottom=1741 </L>
	<L> left=101 ,top=1881 ,right=1950 ,bottom=1881 </L>
	<L> left=101 ,top=2019 ,right=1950 ,bottom=2019 </L>
	<L> left=849 ,top=349 ,right=849 ,bottom=601 </L>
	<L> left=1230 ,top=349 ,right=1230 ,bottom=601 </L>
	<L> left=29 ,top=130 ,right=1950 ,bottom=130 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=2799 ,right=1950 ,bottom=2799 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=130 ,right=29 ,bottom=2799 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1950 ,top=130 ,right=1950 ,bottom=2799 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=209 ,right=1950 ,bottom=209 </L>
	<L> left=87 ,top=2381 ,right=1828 ,bottom=2381 </L>
	<L> left=87 ,top=2223 ,right=1828 ,bottom=2223 </L>
	<L> left=1828 ,top=2223 ,right=1828 ,bottom=2381 </L>
	<L> left=500 ,top=741 ,right=500 ,bottom=2159 </L>
	<L> left=579 ,top=669 ,right=579 ,bottom=2159 </L>
	<L> left=29 ,top=669 ,right=1950 ,bottom=669 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=347 ,top=743 ,right=347 ,bottom=2162 </L>
	<L> left=101 ,top=1320 ,right=1950 ,bottom=1320 </L>
	<L> left=101 ,top=1249 ,right=1950 ,bottom=1249 </L>
	<L> left=101 ,top=1389 ,right=1950 ,bottom=1389 </L>
	<L> left=101 ,top=1529 ,right=1950 ,bottom=1529 </L>
	<L> left=101 ,top=1670 ,right=1950 ,bottom=1670 </L>
	<L> left=101 ,top=1810 ,right=1950 ,bottom=1810 </L>
	<L> left=101 ,top=1950 ,right=1950 ,bottom=1950 </L>
	<L> left=101 ,top=2090 ,right=1950 ,bottom=2090 </L>
	<L> left=103 ,top=741 ,right=1950 ,bottom=741 </L>
	<L> left=101 ,top=669 ,right=101 ,bottom=2156 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1349 ,top=2561 ,right=1349 ,bottom=2662 </L>
	<L> left=85 ,top=2559 ,right=85 ,bottom=2659 </L>
	<L> left=85 ,top=2625 ,right=1844 ,bottom=2625 </L>
	<L> left=82 ,top=2662 ,right=1842 ,bottom=2662 </L>
	<L> left=262 ,top=2561 ,right=262 ,bottom=2662 </L>
	<L> left=706 ,top=2559 ,right=706 ,bottom=2662 </L>
	<L> left=85 ,top=2559 ,right=1847 ,bottom=2559 </L>
	<L> left=1844 ,top=2559 ,right=1844 ,bottom=2662 </L>
	<L> left=1691 ,top=804 ,right=1691 ,bottom=2159 </L>
	<L> left=339 ,top=349 ,right=339 ,bottom=667 </L>
	<L> left=1429 ,top=804 ,right=1429 ,bottom=2159 </L>
	<L> left=1561 ,top=804 ,right=1561 ,bottom=2159 </L>
	<L> left=1820 ,top=741 ,right=1820 ,bottom=2159 </L>
	<L> left=26 ,top=2159 ,right=1950 ,bottom=2159 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1299 ,top=804 ,right=1299 ,bottom=2154 </L>
	<L> left=1169 ,top=741 ,right=1169 ,bottom=2162 </L>
	<L> left=1169 ,top=804 ,right=1820 ,bottom=804 </L>
	<L> left=101 ,top=820 ,right=579 ,bottom=820 </L>
	<L> left=423 ,top=820 ,right=423 ,bottom=910 </L>
	<L> left=169 ,top=1045 ,right=169 ,bottom=2159 </L>
	<L> left=423 ,top=976 ,right=423 ,bottom=1045 </L>
	<L> left=421 ,top=1111 ,right=421 ,bottom=1180 </L>
	<L> left=423 ,top=1249 ,right=423 ,bottom=1323 </L>
	<L> left=423 ,top=1392 ,right=423 ,bottom=1461 </L>
	<L> left=423 ,top=1529 ,right=423 ,bottom=1598 </L>
	<L> left=423 ,top=1670 ,right=423 ,bottom=1738 </L>
	<L> left=423 ,top=1810 ,right=423 ,bottom=1879 </L>
	<L> left=423 ,top=1950 ,right=423 ,bottom=2019 </L>
	<L> left=423 ,top=2090 ,right=423 ,bottom=2159 </L>
	<L> left=654 ,top=804 ,right=910 ,bottom=804 </L>
	<L> left=1709 ,top=2223 ,right=1709 ,bottom=2381 </L>
	<L> left=1040 ,top=743 ,right=1040 ,bottom=2156 </L>
	<L> left=910 ,top=741 ,right=910 ,bottom=2154 </L>
	<L> left=651 ,top=738 ,right=651 ,bottom=2159 </L>
	<L> left=781 ,top=804 ,right=781 ,bottom=2154 </L>
	<L> left=98 ,top=1111 ,right=1950 ,bottom=1111 </L>
	<L> left=347 ,top=974 ,right=1950 ,bottom=974 </L>
	<L> left=103 ,top=908 ,right=1950 ,bottom=908 </L>
	<L> left=98 ,top=1045 ,right=1950 ,bottom=1045 </L>
	<L> left=172 ,top=741 ,right=172 ,bottom=908 </L>
	<L> left=1249 ,top=2223 ,right=1249 ,bottom=2381 </L>
	<L> left=1130 ,top=2223 ,right=1130 ,bottom=2381 </L>
	<L> left=669 ,top=2223 ,right=669 ,bottom=2381 </L>
	<L> left=548 ,top=2223 ,right=548 ,bottom=2381 </L>
	<L> left=87 ,top=2223 ,right=87 ,bottom=2381 </L>
	<L> left=87 ,top=2342 ,right=1828 ,bottom=2342 </L>
	<L> left=87 ,top=2302 ,right=1828 ,bottom=2302 </L>
	<L> left=87 ,top=2262 ,right=1828 ,bottom=2262 </L>
	<X>left=169 ,top=1111 ,right=349 ,bottom=1180 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1429 ,top=1249 ,right=1561 ,bottom=1320 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1429 ,top=1389 ,right=1561 ,bottom=1461 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1429 ,top=1529 ,right=1561 ,bottom=1601 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1429 ,top=1950 ,right=1561 ,bottom=2019 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1429 ,top=2090 ,right=1561 ,bottom=2159 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1429 ,top=1670 ,right=1561 ,bottom=1741 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1429 ,top=1810 ,right=1561 ,bottom=1881 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1429 ,top=1111 ,right=1561 ,bottom=1180 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1429 ,top=974 ,right=1561 ,bottom=1045 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='소득자 성명' ,left=29 ,top=349 ,right=349 ,bottom=400 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민등록번호' ,left=849 ,top=349 ,right=1230 ,bottom=400 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근무처 명칭' ,left=29 ,top=400 ,right=349 ,bottom=450 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사업자등록번호' ,left=849 ,top=400 ,right=1230 ,bottom=450 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='221 - 81 - 13834' ,left=1230 ,top=400 ,right=1950 ,bottom=450 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세대주 여부' ,left=29 ,top=450 ,right=349 ,bottom=500 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근무기간' ,left=29 ,top=500 ,right=349 ,bottom=550 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='감면기간' ,left=849 ,top=500 ,right=1230 ,bottom=550 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
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
	<T>id='210㎜x297㎜' ,left=1299 ,top=2805 ,right=1889 ,bottom=2839 ,align='right'</T>
	<T>id='국 적' ,left=849 ,top=450 ,right=1230 ,bottom=500 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주지국' ,left=849 ,top=550 ,right=1230 ,bottom=601 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='■ 소득세법 시행규칙 [별지 제37호 서식]  <2014.03.14.개정>' ,left=26 ,top=61 ,right=1058 ,bottom=122 ,align='left'</T>
	<T>id='소득·세액 공제신고서/근로소득자 소득·세액 공제신고서 (2014년 소득에 대한 연말정산용)' ,left=148 ,top=135 ,right=1857 ,bottom=206 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(1쪽)' ,left=1791 ,top=66 ,right=1894 ,bottom=122 ,align='right'</T>
	<T>id=' 연말정산 시 근로소득자에게 환급이 발생하는 경우 원천징수의무자는 근로소득자에게 환급세액을 지급해야 합니다.' ,left=37 ,top=304 ,right=1886 ,bottom=347 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' 근로소득 세액 계산을 하고 근로소득자에게 즉시 근로소득원천징수영수증을 발급하여야 합니다.' ,left=37 ,top=257 ,right=1886 ,bottom=299 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='* 근로소득자는 신고서에 소득·세액 공제 증명서류를 첨부하여 원천징수의무자(소속 회사 등)에게 제출하며, 원천징수의무자는 신고서 및 첨부서류를 확인하여' ,left=37 ,top=212 ,right=1886 ,bottom=254 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( 국적 코드 :  KR )' ,left=1400 ,top=450 ,right=1707 ,bottom=500 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( 거주지국 코드 : KR )' ,left=1397 ,top=550 ,right=1725 ,bottom=601 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='※ 인적공제 항목이 전년과 동일한 경우에는 주민등록표등본을 제출하지 않습니다.' ,left=826 ,top=609 ,right=1950 ,bottom=659 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주구분' ,left=29 ,top=550 ,right=347 ,bottom=601 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인적공제 항목' ,left=29 ,top=603 ,right=341 ,bottom=638 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본' ,left=384 ,top=754 ,right=455 ,bottom=786 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=384 ,top=783 ,right=455 ,bottom=812 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='변동 여부' ,left=29 ,top=635 ,right=341 ,bottom=669 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='경로' ,left=505 ,top=751 ,right=572 ,bottom=786 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국인' ,left=101 ,top=855 ,right=169 ,bottom=886 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내·외' ,left=101 ,top=823 ,right=169 ,bottom=855 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관계' ,left=106 ,top=751 ,right=167 ,bottom=783 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민등록번호' ,left=175 ,top=833 ,right=344 ,bottom=878 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부녀' ,left=349 ,top=828 ,right=421 ,bottom=860 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자' ,left=349 ,top=855 ,right=421 ,bottom=884 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='한' ,left=426 ,top=823 ,right=497 ,bottom=855 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부모' ,left=426 ,top=855 ,right=497 ,bottom=886 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='우대' ,left=505 ,top=786 ,right=572 ,bottom=818 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인' ,left=505 ,top=852 ,right=572 ,bottom=884 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='코드' ,left=106 ,top=781 ,right=167 ,bottom=815 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성 명' ,left=180 ,top=767 ,right=336 ,bottom=812 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인적공제 항목' ,left=159 ,top=675 ,right=542 ,bottom=730 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='각종 소득·세액 공제 항목' ,left=767 ,top=677 ,right=1640 ,bottom=736 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구분' ,left=579 ,top=831 ,right=651 ,bottom=870 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청' ,left=579 ,top=913 ,right=651 ,bottom=966 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=582 ,top=984 ,right=651 ,bottom=1035 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=579 ,top=1111 ,right=651 ,bottom=1180 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청' ,left=579 ,top=1180 ,right=651 ,bottom=1249 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=579 ,top=1249 ,right=651 ,bottom=1320 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청' ,left=579 ,top=1320 ,right=651 ,bottom=1389 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청' ,left=582 ,top=1461 ,right=651 ,bottom=1529 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=582 ,top=1529 ,right=651 ,bottom=1601 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청' ,left=582 ,top=1601 ,right=651 ,bottom=1670 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=582 ,top=1389 ,right=651 ,bottom=1461 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=582 ,top=1670 ,right=651 ,bottom=1741 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청' ,left=582 ,top=1741 ,right=651 ,bottom=1810 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=582 ,top=1810 ,right=651 ,bottom=1881 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청' ,left=582 ,top=1881 ,right=651 ,bottom=1950 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=582 ,top=1950 ,right=651 ,bottom=2019 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청' ,left=582 ,top=2019 ,right=651 ,bottom=2090 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=582 ,top=2090 ,right=651 ,bottom=2159 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='※참고사항' ,left=42 ,top=2164 ,right=222 ,bottom=2193 ,align='left' ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='신용카드 등 사용액공제' ,left=1294 ,top=751 ,right=1646 ,bottom=804 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=706 ,top=751 ,right=855 ,bottom=791 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기재(다자녀 :' ,left=106 ,top=995 ,right=267 ,bottom=1040 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='명)' ,left=294 ,top=995 ,right=344 ,bottom=1040 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='해당하는 인원수를' ,left=101 ,top=953 ,right=349 ,bottom=995 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인적공제 항목에' ,left=106 ,top=908 ,right=336 ,bottom=953 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  1. 관계코드' ,left=42 ,top=2193 ,right=1807 ,bottom=2223 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='7' ,left=1130 ,top=2347 ,right=1249 ,bottom=2381 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수급자(코드1~6제외)(소법§50①3라)' ,left=669 ,top=2347 ,right=1130 ,bottom=2381 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6' ,left=548 ,top=2347 ,right=669 ,bottom=2381 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='형제자매(소법§50③다)' ,left=87 ,top=2347 ,right=548 ,bottom=2381 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4˙' ,left=1130 ,top=2307 ,right=1249 ,bottom=2342 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직계비속(자녀·입양자)(소법§50①3나)' ,left=669 ,top=2307 ,right=1130 ,bottom=2342 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3' ,left=548 ,top=2307 ,right=669 ,bottom=2342 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='배우자(소법§50①2)' ,left=87 ,top=2307 ,right=548 ,bottom=2342 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1' ,left=1130 ,top=2267 ,right=1249 ,bottom=2302 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득자의 직계존속(소법§50①3가)' ,left=669 ,top=2267 ,right=1130 ,bottom=2302 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='0' ,left=548 ,top=2267 ,right=669 ,bottom=2302 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득자 본인(소법§50①1)' ,left=87 ,top=2267 ,right=548 ,bottom=2302 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관계코드' ,left=1130 ,top=2228 ,right=1249 ,bottom=2262 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구  분' ,left=669 ,top=2228 ,right=1130 ,bottom=2262 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관계코드' ,left=548 ,top=2228 ,right=669 ,bottom=2262 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구  분' ,left=87 ,top=2228 ,right=548 ,bottom=2262 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금액 ( 전통시장 사용분과 대중교통비용분 포함된 금액은 제외 ) 을 적습니다.' ,left=74 ,top=2762 ,right=1842 ,bottom=2797 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  6. 직불카드 등란에는 「여신전문금융업법」제2조에 따른 직불카드 등 「조세 특례제한법」제126조2제1항제4호에 해당하는' ,left=53 ,top=2728 ,right=1820 ,bottom=2762 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     참조하여 적습니다.' ,left=71 ,top=2699 ,right=1836 ,bottom=2728 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  5. 내ㆍ외국인 : 내국인 =1, 외국인=9 로 구분하여 적습니다. 근로소득자가 외국인에 해당하는 경우 국적을 적으며 국적코드는 거주지국코드를' ,left=48 ,top=2667 ,right=1876 ,bottom=2696 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2' ,left=960 ,top=2625 ,right=1080 ,bottom=2659 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3' ,left=1500 ,top=2625 ,right=1619 ,bottom=2659 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     * 해당 직계비속과 그 배우자가 장애인인 경우 그 배우자를 포함' ,left=87 ,top=2384 ,right=1849 ,bottom=2413 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     ※ 관계코드 4~6는 소득자와 배우자의 각각의 관계를 포함합니다.' ,left=87 ,top=2413 ,right=1849 ,bottom=2439 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  2. 연령기준' ,left=40 ,top=2439 ,right=1804 ,bottom=2469 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  - 경로우대 : 1943.12.31. 이전 출생 ( 만 70세 이상 : 100만원 공제 )' ,left=82 ,top=2469 ,right=1847 ,bottom=2495 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  3. 부녀자 공제란에는 여성근로소득자 본인에 한정하여 그 적용여부를 표시합니다.' ,left=42 ,top=2495 ,right=1807 ,bottom=2524 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  4. 장애인 공제란에는 다음의 해당 코드를 적습니다.' ,left=42 ,top=2521 ,right=1810 ,bottom=2548 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='그 밖의 항시 치료를 요하는 중증환자' ,left=1357 ,top=2582 ,right=1839 ,bottom=2611 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구  분' ,left=90 ,top=2572 ,right=259 ,bottom=2606 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='해당코드' ,left=90 ,top=2627 ,right=251 ,bottom=2662 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='「장애인복지법」에 따른 장애인' ,left=267 ,top=2574 ,right=704 ,bottom=2606 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1' ,left=392 ,top=2627 ,right=511 ,bottom=2662 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='「국가유공자 등 예우 및 지원에 관한 법률」에 따른 ' ,left=712 ,top=2564 ,right=1344 ,bottom=2593 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상이자 및 이와 유사한 자로서 근로능력이 없는 자' ,left=712 ,top=2593 ,right=1349 ,bottom=2619 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='장애' ,left=505 ,top=823 ,right=572 ,bottom=855 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(주) 현대 아산' ,left=447 ,top=405 ,right=759 ,bottom=447 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(근로자 본인)' ,left=172 ,top=1122 ,right=347 ,bottom=1167 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='거주자 ■ , 비거주자□' ,left=442 ,top=550 ,right=759 ,bottom=601 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국세청' ,left=579 ,top=1050 ,right=651 ,bottom=1111 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금' ,left=1831 ,top=759 ,right=1942 ,bottom=886 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대중교통' ,left=1701 ,top=815 ,right=1807 ,bottom=852 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이용액' ,left=1715 ,top=849 ,right=1791 ,bottom=886 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전통시장' ,left=1572 ,top=812 ,right=1683 ,bottom=849 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사용액' ,left=1572 ,top=849 ,right=1683 ,bottom=886 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현금영수증' ,left=1431 ,top=812 ,right=1558 ,bottom=849 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(전통시장·대' ,left=1434 ,top=849 ,right=1550 ,bottom=878 ,face='굴림' ,size=5 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='중교통비 제외)' ,left=1434 ,top=878 ,right=1550 ,bottom=908 ,face='굴림' ,size=5 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직불카드등' ,left=1304 ,top=812 ,right=1426 ,bottom=847 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(전통시장·대' ,left=1307 ,top=849 ,right=1423 ,bottom=878 ,face='굴림' ,size=5 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='중교통비 제외)' ,left=1307 ,top=876 ,right=1423 ,bottom=905 ,face='굴림' ,size=5 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='신용카드' ,left=1183 ,top=810 ,right=1289 ,bottom=849 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(전통시장·대' ,left=1177 ,top=849 ,right=1294 ,bottom=878 ,face='굴림' ,size=5 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='중교통비 제외)' ,left=1177 ,top=878 ,right=1294 ,bottom=908 ,face='굴림' ,size=5 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='교육비' ,left=1058 ,top=765 ,right=1156 ,bottom=889 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의료비' ,left=929 ,top=765 ,right=1024 ,bottom=892 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='건강·' ,left=667 ,top=818 ,right=765 ,bottom=855 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='고용등' ,left=664 ,top=863 ,right=770 ,bottom=900 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보장성' ,left=802 ,top=831 ,right=892 ,bottom=876 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='위탁아동(소법§50①3마)' ,left=1249 ,top=2347 ,right=1709 ,bottom=2381 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직계비속(코드4제외)(소법§50①3나)' ,left=1249 ,top=2307 ,right=1709 ,bottom=2342 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='배우자의 직계존속(소법§50①3가)' ,left=1249 ,top=2267 ,right=1709 ,bottom=2302 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구  분' ,left=1249 ,top=2228 ,right=1709 ,bottom=2262 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='8' ,left=1709 ,top=2347 ,right=1828 ,bottom=2381 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5˙' ,left=1709 ,top=2307 ,right=1828 ,bottom=2342 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2' ,left=1709 ,top=2267 ,right=1828 ,bottom=2302 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관계코드' ,left=1709 ,top=2228 ,right=1828 ,bottom=2262 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자료' ,left=585 ,top=778 ,right=651 ,bottom=818 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNO', left=1619, top=69, right=1786, bottom=111, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CNT', left=246, top=1000, right=294, bottom=1037, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_1', left=106, top=1050, right=164, bottom=1106, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_1', left=106, top=1117, right=164, bottom=1175, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_1', left=177, top=1050, right=341, bottom=1106, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF2_1', left=360, top=1050, right=489, bottom=1109, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_1', left=357, top=1117, right=413, bottom=1175, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_1', left=429, top=1117, right=492, bottom=1175, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	
	<C>id='{decode(REF10_1,0,,REF10_1)}', left=650, top=915, right=780, bottom=965, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_S,0,,REF11_S)}', left=780, top=915, right=910, bottom=965, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_S,0,,REF12_S)}', left=910, top=915, right=1040, bottom=965, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_S,0,,REF13_S)}', left=1040, top=915, right=1170, bottom=965, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_S,0,,REF14_S)}', left=1170, top=915, right=1300, bottom=965, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_S,0,,REF15_S)}', left=1300, top=915, right=1430, bottom=965, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_S,0,,REF16_S)}', left=1430, top=915, right=1560, bottom=965, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_S,0,,REF17_S)}', left=1560, top=915, right=1690, bottom=965, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF18_S,0,,REF18_S)}', left=1690, top=915, right=1820, bottom=965, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF19_S,0,,REF19_S)}', left=1820, top=915, right=1950, bottom=965, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_S,0,,REF21_S)}', left=780, top=980, right=910, bottom=1035, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_S,0,,REF22_S)}', left=910, top=980, right=1040, bottom=1035, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_S,0,,REF23_S)}', left=1040, top=980, right=1170, bottom=1035, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_S,0,,REF24_S)}', left=1170, top=980, right=1300, bottom=1035, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25_S,0,,REF25_S)}', left=1300, top=980, right=1430, bottom=1035, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_S,0,,REF27_S)}', left=1560, top=980, right=1690, bottom=1035, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF28_S,0,,REF28_S)}', left=1690, top=980, right=1820, bottom=1035, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF29_S,0,,REF29_S)}', left=1820, top=980, right=1950, bottom=1035, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	
	
	<C>id='{decode(REF10_1,0,,REF10_1)}', left=651, top=1050, right=781, bottom=1109, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF11_1,0,,REF11_1)}', left=781, top=1050, right=910, bottom=1109, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_1,0,,REF12_1)}', left=910, top=1050, right=1040, bottom=1109, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_1,0,,REF13_1)}', left=1040, top=1050, right=1169, bottom=1109, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_1,0,,REF14_1)}', left=1169, top=1050, right=1299, bottom=1109, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_1,0,,REF15_1)}', left=1299, top=1050, right=1429, bottom=1109, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_1,0,,REF16_1)}', left=1429, top=1050, right=1561, bottom=1109, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_1,0,,REF17_1)}', left=1561, top=1050, right=1691, bottom=1109, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF18_1,0,,REF18_1)}', left=1691, top=1050, right=1820, bottom=1109, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF19_1,0,,REF19_1)}', left=1820, top=1050, right=1950, bottom=1109, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_1,0,,REF21_1)}', left=781, top=1117, right=910, bottom=1175, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_1,0,,REF22_1)}', left=910, top=1117, right=1040, bottom=1175, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_1,0,,REF23_1)}', left=1040, top=1117, right=1169, bottom=1175, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_1,0,,REF24_1)}', left=1169, top=1117, right=1299, bottom=1175, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25_1,0,,REF25_1)}', left=1299, top=1117, right=1429, bottom=1175, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_1,0,,REF27_1)}', left=1561, top=1117, right=1691, bottom=1175, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF28_1,0,,REF28_1)}', left=1691, top=1117, right=1820, bottom=1175, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF29_1,0,,REF29_1)}', left=1820, top=1117, right=1950, bottom=1175, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		
	<C>id='REF2_2', left=360, top=1185, right=489, bottom=1245, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_2', left=357, top=1255, right=413, bottom=1315, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_2', left=429, top=1255, right=492, bottom=1315, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_2', left=505, top=1185, right=572, bottom=1245, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6_2', left=505, top=1255, right=572, bottom=1315, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	
	<C>id='{decode(REF11_2,0,,REF11_2)}', left=780, top=1185, right=910, bottom=1245, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_2,0,,REF12_2)}', left=910, top=1185, right=1040, bottom=1245, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_2,0,,REF13_2)}', left=1040, top=1185, right=1170, bottom=1245, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_2,0,,REF14_2)}', left=1170, top=1185, right=1300, bottom=1245, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_2,0,,REF15_2)}', left=1300, top=1185, right=1430, bottom=1245, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_2,0,,REF16_2)}', left=1430, top=1185, right=1560, bottom=1245, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_2,0,,REF17_2)}', left=1560, top=1185, right=1690, bottom=1245, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF18_2,0,,REF18_2)}', left=1690, top=1185, right=1820, bottom=1245, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF19_2,0,,REF19_2)}', left=1820, top=1185, right=1950, bottom=1245, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_2,0,,REF21_2)}', left=780, top=1255, right=910, bottom=1315, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_2,0,,REF22_2)}', left=910, top=1255, right=1040, bottom=1315, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_2,0,,REF23_2)}', left=1040, top=1255, right=1170, bottom=1315, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_2,0,,REF24_2)}', left=1170, top=1255, right=1300, bottom=1315, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25_2,0,,REF25_2)}', left=1300, top=1255, right=1430, bottom=1315, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_2,0,,REF27_2)}', left=1560, top=1255, right=1690, bottom=1315, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF28_2,0,,REF28_2)}', left=1690, top=1255, right=1820, bottom=1315, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF29_2,0,,REF29_2)}', left=1820, top=1255, right=1950, bottom=1315, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	
	<C>id='REF2_3', left=360, top=1325, right=489, bottom=1385, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_3', left=357, top=1395, right=413, bottom=1455, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_3', left=429, top=1395, right=492, bottom=1455, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_3', left=505, top=1325, right=572, bottom=1385, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6_3', left=505, top=1395, right=572, bottom=1455, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>


	<C>id='{decode(REF11_3,0,,REF11_3)}', left=780, top=1325, right=910, bottom=1385, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_3,0,,REF12_3)}', left=910, top=1325, right=1040, bottom=1385, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_3,0,,REF13_3)}', left=1040, top=1325, right=1170, bottom=1385, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_3,0,,REF14_3)}', left=1170, top=1325, right=1300, bottom=1385, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_3,0,,REF15_3)}', left=1300, top=1325, right=1430, bottom=1385, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_3,0,,REF16_3)}', left=1430, top=1325, right=1560, bottom=1385, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_3,0,,REF17_3)}', left=1560, top=1325, right=1690, bottom=1385, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF18_3,0,,REF18_3)}', left=1690, top=1325, right=1820, bottom=1385, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF19_3,0,,REF19_3)}', left=1820, top=1325, right=1950, bottom=1385, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_3,0,,REF21_3)}', left=780, top=1395, right=910, bottom=1455, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_3,0,,REF22_3)}', left=910, top=1395, right=1040, bottom=1455, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_3,0,,REF23_3)}', left=1040, top=1395, right=1170, bottom=1455, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_3,0,,REF24_3)}', left=1170, top=1395, right=1300, bottom=1455, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25_3,0,,REF25_3)}', left=1300, top=1395, right=1430, bottom=1455, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_3,0,,REF27_3)}', left=1560, top=1395, right=1690, bottom=1455, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF28_3,0,,REF28_3)}', left=1690, top=1395, right=1820, bottom=1455, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF29_3,0,,REF29_3)}', left=1820, top=1395, right=1950, bottom=1455, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>

	<C>id='REF2_4', left=360, top=1465, right=489, bottom=1525, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_4', left=357, top=1535, right=413, bottom=1595, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_4', left=429, top=1535, right=492, bottom=1595, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_4', left=505, top=1465, right=572, bottom=1525, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6_4', left=505, top=1535, right=572, bottom=1595, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>

	<C>id='{decode(REF11_4,0,,REF11_4)}', left=780, top=1465, right=910, bottom=1525, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_4,0,,REF12_4)}', left=910, top=1465, right=1040, bottom=1525, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_4,0,,REF13_4)}', left=1040, top=1465, right=1170, bottom=1525, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_4,0,,REF14_4)}', left=1170, top=1465, right=1300, bottom=1525, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_4,0,,REF15_4)}', left=1300, top=1465, right=1430, bottom=1525, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_4,0,,REF16_4)}', left=1430, top=1465, right=1560, bottom=1525, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_4,0,,REF17_4)}', left=1560, top=1465, right=1690, bottom=1525, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF18_4,0,,REF18_4)}', left=1690, top=1465, right=1820, bottom=1525, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF19_4,0,,REF19_4)}', left=1820, top=1465, right=1950, bottom=1525, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_4,0,,REF21_4)}', left=780, top=1535, right=910, bottom=1595, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_4,0,,REF22_4)}', left=910, top=1535, right=1040, bottom=1595, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_4,0,,REF23_4)}', left=1040, top=1535, right=1170, bottom=1595, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_4,0,,REF24_4)}', left=1170, top=1535, right=1300, bottom=1595, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25_4,0,,REF25_4)}', left=1300, top=1535, right=1430, bottom=1595, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_4,0,,REF27_4)}', left=1560, top=1535, right=1690, bottom=1595, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF28_4,0,,REF28_4)}', left=1690, top=1535, right=1820, bottom=1595, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF29_4,0,,REF29_4)}', left=1820, top=1535, right=1950, bottom=1595, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>

	<C>id='REF2_5', left=360, top=1605, right=489, bottom=1665, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_5', left=357, top=1675, right=413, bottom=1735, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_5', left=429, top=1675, right=492, bottom=1735, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_5', left=505, top=1605, right=572, bottom=1665, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6_5', left=505, top=1675, right=572, bottom=1735, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>


	<C>id='{decode(REF11_5,0,,REF11_5)}', left=780, top=1605, right=910, bottom=1665, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_5,0,,REF12_5)}', left=910, top=1605, right=1040, bottom=1665, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_5,0,,REF13_5)}', left=1040, top=1605, right=1170, bottom=1665, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_5,0,,REF14_5)}', left=1170, top=1605, right=1300, bottom=1665, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_5,0,,REF15_5)}', left=1300, top=1605, right=1430, bottom=1665, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_5,0,,REF16_5)}', left=1430, top=1605, right=1560, bottom=1665, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_5,0,,REF17_5)}', left=1560, top=1605, right=1690, bottom=1665, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF18_5,0,,REF18_5)}', left=1690, top=1605, right=1820, bottom=1665, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF19_5,0,,REF19_5)}', left=1820, top=1605, right=1950, bottom=1665, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_5,0,,REF21_5)}', left=780, top=1675, right=910, bottom=1735, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_5,0,,REF22_5)}', left=910, top=1675, right=1040, bottom=1735, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_5,0,,REF23_5)}', left=1040, top=1675, right=1170, bottom=1735, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_5,0,,REF24_5)}', left=1170, top=1675, right=1300, bottom=1735, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25_5,0,,REF25_5)}', left=1300, top=1675, right=1430, bottom=1735, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_5,0,,REF27_5)}', left=1560, top=1675, right=1690, bottom=1735, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF28_5,0,,REF28_5)}', left=1690, top=1675, right=1820, bottom=1735, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF29_5,0,,REF29_5)}', left=1820, top=1675, right=1950, bottom=1735, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	
	<C>id='REF2_6', left=360, top=1745, right=489, bottom=1805, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_6', left=357, top=1815, right=413, bottom=1875, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_6', left=429, top=1815, right=492, bottom=1875, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_6', left=505, top=1745, right=572, bottom=1805, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6_6', left=505, top=1815, right=572, bottom=1875, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>


	<C>id='{decode(REF11_6,0,,REF11_6)}', left=780, top=1745, right=910, bottom=1805, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_6,0,,REF12_6)}', left=910, top=1745, right=1040, bottom=1805, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_6,0,,REF13_6)}', left=1040, top=1745, right=1170, bottom=1805, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_6,0,,REF14_6)}', left=1170, top=1745, right=1300, bottom=1805, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_6,0,,REF15_6)}', left=1300, top=1745, right=1430, bottom=1805, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_6,0,,REF16_6)}', left=1430, top=1745, right=1560, bottom=1805, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_6,0,,REF17_6)}', left=1560, top=1745, right=1690, bottom=1805, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF18_6,0,,REF18_6)}', left=1690, top=1745, right=1820, bottom=1805, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF19_6,0,,REF19_6)}', left=1820, top=1745, right=1950, bottom=1805, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_6,0,,REF21_6)}', left=780, top=1815, right=910, bottom=1875, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_6,0,,REF22_6)}', left=910, top=1815, right=1040, bottom=1875, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_6,0,,REF23_6)}', left=1040, top=1815, right=1170, bottom=1875, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_6,0,,REF24_6)}', left=1170, top=1815, right=1300, bottom=1875, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25_6,0,,REF25_6)}', left=1300, top=1815, right=1430, bottom=1875, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_6,0,,REF27_6)}', left=1560, top=1815, right=1690, bottom=1875, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF28_6,0,,REF28_6)}', left=1690, top=1815, right=1820, bottom=1875, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF29_6,0,,REF29_6)}', left=1820, top=1815, right=1950, bottom=1875, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>

	<C>id='REF2_7', left=360, top=1885, right=489, bottom=1945, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_7', left=357, top=1945, right=413, bottom=2015, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_7', left=429, top=1945, right=492, bottom=2015, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_7', left=505, top=1885, right=572, bottom=1945, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6_7', left=505, top=1945, right=572, bottom=2015, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>

	<C>id='{decode(REF11_7,0,,REF11_7)}', left=780, top=1885, right=910, bottom=1945, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_7,0,,REF12_7)}', left=910, top=1885, right=1040, bottom=1945, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_7,0,,REF13_7)}', left=1040, top=1885, right=1170, bottom=1945, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_7,0,,REF14_7)}', left=1170, top=1885, right=1300, bottom=1945, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_7,0,,REF15_7)}', left=1300, top=1885, right=1430, bottom=1945, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_7,0,,REF16_7)}', left=1430, top=1885, right=1560, bottom=1945, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_7,0,,REF17_7)}', left=1560, top=1885, right=1690, bottom=1945, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF18_7,0,,REF18_7)}', left=1690, top=1885, right=1820, bottom=1945, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF19_7,0,,REF19_7)}', left=1820, top=1885, right=1950, bottom=1945, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_7,0,,REF21_7)}', left=780, top=1945, right=910, bottom=2015, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_7,0,,REF22_7)}', left=910, top=1945, right=1040, bottom=2015, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_7,0,,REF23_7)}', left=1040, top=1945, right=1170, bottom=2015, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_7,0,,REF24_7)}', left=1170, top=1945, right=1300, bottom=2015, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25_7,0,,REF25_7)}', left=1300, top=1945, right=1430, bottom=2015, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_7,0,,REF27_7)}', left=1560, top=1945, right=1690, bottom=2015, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF28_7,0,,REF28_7)}', left=1690, top=1945, right=1820, bottom=2015, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF29_7,0,,REF29_7)}', left=1820, top=1945, right=1950, bottom=2015, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>

	<C>id='REF2_8', left=360, top=2025, right=489, bottom=2085, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF3_8', left=357, top=2095, right=413, bottom=2155, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF4_8', left=429, top=2095, right=492, bottom=2155, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_8', left=505, top=2025, right=572, bottom=2085, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6_8', left=505, top=2095, right=572, bottom=2155, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>


	<C>id='{decode(REF11_8,0,,REF11_8)}', left=780, top=2025, right=910, bottom=2085, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF12_8,0,,REF12_8)}', left=910, top=2025, right=1040, bottom=2085, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF13_8,0,,REF13_8)}', left=1040, top=2025, right=1170, bottom=2085, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF14_8,0,,REF14_8)}', left=1170, top=2025, right=1300, bottom=2085, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF15_8,0,,REF15_8)}', left=1300, top=2025, right=1430, bottom=2085, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF16_8,0,,REF16_8)}', left=1430, top=2025, right=1560, bottom=2085, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF17_8,0,,REF17_8)}', left=1560, top=2025, right=1690, bottom=2085, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF18_8,0,,REF18_8)}', left=1690, top=2025, right=1820, bottom=2085, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF19_8,0,,REF19_8)}', left=1820, top=2025, right=1950, bottom=2085, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF21_8,0,,REF21_8)}', left=780, top=2095, right=910, bottom=2155, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF22_8,0,,REF22_8)}', left=910, top=2095, right=1040, bottom=2155, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF23_8,0,,REF23_8)}', left=1040, top=2095, right=1170, bottom=2155, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF24_8,0,,REF24_8)}', left=1170, top=2095, right=1300, bottom=2155, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF25_8,0,,REF25_8)}', left=1300, top=2095, right=1430, bottom=2155, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF27_8,0,,REF27_8)}', left=1560, top=2095, right=1690, bottom=2155, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF28_8,0,,REF28_8)}', left=1690, top=2095, right=1820, bottom=2155, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REF29_8,0,,REF29_8)}', left=1820, top=2095, right=1950, bottom=2155, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>

	
	
	<C>id='RELAT1_2', left=106, top=1185, right=164, bottom=1244, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_2', left=106, top=1254, right=164, bottom=1312, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_2', left=177, top=1185, right=341, bottom=1244, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_3', left=106, top=1326, right=164, bottom=1386, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_3', left=106, top=1394, right=164, bottom=1458, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_3', left=177, top=1326, right=341, bottom=1386, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_4', left=106, top=1466, right=164, bottom=1524, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_4', left=106, top=1532, right=164, bottom=1598, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_4', left=177, top=1466, right=341, bottom=1524, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_5', left=106, top=1603, right=164, bottom=1664, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_5', left=106, top=1675, right=164, bottom=1736, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_5', left=177, top=1603, right=341, bottom=1664, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_6', left=106, top=1746, right=164, bottom=1804, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_6', left=106, top=1815, right=164, bottom=1876, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_6', left=177, top=1746, right=341, bottom=1804, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_7', left=106, top=1886, right=164, bottom=1945, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_7', left=106, top=1955, right=164, bottom=2016, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_7', left=177, top=1886, right=341, bottom=1945, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RELAT1_8', left=106, top=2024, right=164, bottom=2088, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF1_8', left=106, top=2096, right=164, bottom=2154, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK_8', left=177, top=2024, right=341, bottom=2088, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HOL_YN', left=357, top=458, right=839, bottom=495, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='WORKDAY', left=360, top=508, right=841, bottom=545, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CLS_TAG', left=344, top=616, right=826, bottom=654, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='WORKDAY', left=1315, top=508, right=1797, bottom=545, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO', left=1341, top=357, right=1802, bottom=394, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_7', left=172, top=1953, right=347, bottom=2013 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_6', left=172, top=1812, right=347, bottom=1873 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_5', left=172, top=1672, right=347, bottom=1733 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_4', left=172, top=1529, right=347, bottom=1595 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_3', left=172, top=1392, right=347, bottom=1455 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_2', left=172, top=1251, right=347, bottom=1310 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPJUNO_8', left=172, top=2096, right=347, bottom=2154 ,mask='XXXXXX-XXXXXXX', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF6_1', left=508, top=1117, right=574, bottom=1175, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REF5_1', left=508, top=1050, right=574, bottom=1109, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=458, top=352, right=754, bottom=397, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>


</R>
</A>





<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='2쪽.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='ds_print'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2712 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=29 ,top=2799 ,right=1900 ,bottom=2799 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='210㎜x297㎜' ,left=1299 ,top=2805 ,right=1889 ,bottom=2839 ,align='right'</T>
	<L> left=29 ,top=103 ,right=1900 ,bottom=103 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='한도액' ,left=1410 ,top=116 ,right=1588 ,bottom=159 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제액' ,left=1617 ,top=116 ,right=1886 ,bottom=159 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금액' ,left=1117 ,top=114 ,right=1381 ,bottom=159 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지출구분' ,left=918 ,top=114 ,right=1090 ,bottom=159 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지출명세' ,left=349 ,top=111 ,right=860 ,bottom=159 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구분' ,left=53 ,top=111 ,right=275 ,bottom=159 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=164 ,right=1900 ,bottom=164 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='국민연금보험료' ,left=318 ,top=172 ,right=582 ,bottom=262 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)근무지' ,left=624 ,top=169 ,right=884 ,bottom=222 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=921 ,top=169 ,right=1087 ,bottom=220 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=603 ,top=225 ,right=1902 ,bottom=225 </L>
	<L> left=601 ,top=347 ,right=1900 ,bottom=347 </L>
	<L> left=299 ,top=286 ,right=1900 ,bottom=286 </L>
	<T>id='국민연금보험료 외의' ,left=310 ,top=291 ,right=595 ,bottom=341 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공적연금보험료' ,left=323 ,top=339 ,right=585 ,bottom=389 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=601 ,top=164 ,right=601 ,bottom=410 </L>
	<T>id='연금보험료 계' ,left=384 ,top=415 ,right=818 ,bottom=458 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연금보험료' ,left=111 ,top=180 ,right=283 ,bottom=230 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(국민연금,' ,left=111 ,top=228 ,right=283 ,bottom=278 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공무원연금,' ,left=106 ,top=275 ,right=291 ,bottom=325 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='군인연금,' ,left=106 ,top=320 ,right=283 ,bottom=370 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='교직원연금 등)' ,left=106 ,top=368 ,right=294 ,bottom=418 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주(현)근무지' ,left=624 ,top=230 ,right=884 ,bottom=283 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1897 ,top=407 ,right=299 ,bottom=407 </L>
	<T>id='국민건강보험' ,left=328 ,top=474 ,right=548 ,bottom=516 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=598 ,top=529 ,right=1897 ,bottom=529 </L>
	<L> left=1900 ,top=587 ,right=302 ,bottom=587 </L>
	<T>id='(노인장기요양보험 포함)' ,left=302 ,top=529 ,right=579 ,bottom=579 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1894 ,top=714 ,right=296 ,bottom=714 </L>
	<L> left=598 ,top=654 ,right=1897 ,bottom=654 </L>
	<L> left=101 ,top=781 ,right=1900 ,bottom=781 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='고용보험' ,left=344 ,top=619 ,right=545 ,bottom=691 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=468 ,right=1902 ,bottom=468 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<X>left=900 ,top=407 ,right=1101 ,bottom=468 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1400 ,top=407 ,right=1601 ,bottom=468 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=900 ,top=103 ,right=900 ,bottom=2799 </L>
	<L> left=1400 ,top=106 ,right=1400 ,bottom=2799 </L>
	<L> left=1601 ,top=103 ,right=1601 ,bottom=2799 </L>
	<L> left=29 ,top=103 ,right=29 ,bottom=2799 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=598 ,top=468 ,right=598 ,bottom=714 </L>
	<T>id='보험료 계' ,left=463 ,top=722 ,right=736 ,bottom=773 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=905 ,right=1900 ,bottom=905 </L>
	<T>id='주택임차차입금' ,left=325 ,top=818 ,right=582 ,bottom=873 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=968 ,right=1902 ,bottom=968 </L>
	<T>id='월세액' ,left=474 ,top=915 ,right=712 ,bottom=963 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1103 ,top=841 ,right=1900 ,bottom=841 </L>
	<L> left=601 ,top=844 ,right=900 ,bottom=844 </L>
	<T>id='대출기관차입' ,left=632 ,top=788 ,right=870 ,bottom=836 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='거주자 차입' ,left=630 ,top=852 ,right=868 ,bottom=900 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='원리금상환액' ,left=913 ,top=812 ,right=1090 ,bottom=881 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지출액' ,left=921 ,top=910 ,right=1082 ,bottom=966 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=691 ,top=1027 ,right=900 ,bottom=1027 </L>
	<L> left=691 ,top=1087 ,right=900 ,bottom=1087 </L>
	<T>id='차입분' ,left=479 ,top=1072 ,right=685 ,bottom=1122 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2011년 이전' ,left=479 ,top=1008 ,right=685 ,bottom=1058 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15년 미만' ,left=704 ,top=974 ,right=892 ,bottom=1024 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15년~29년' ,left=696 ,top=1035 ,right=897 ,bottom=1085 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30년 이상' ,left=696 ,top=1093 ,right=897 ,bottom=1143 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=691 ,top=1207 ,right=900 ,bottom=1207 </L>
	<L> left=299 ,top=1265 ,right=1900 ,bottom=1265 </L>
	<L> left=471 ,top=968 ,right=471 ,bottom=1265 </L>
	<T>id='저당차입금' ,left=312 ,top=1162 ,right=460 ,bottom=1212 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='장기주택' ,left=318 ,top=1090 ,right=452 ,bottom=1140 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2012년 이후' ,left=479 ,top=1151 ,right=685 ,bottom=1201 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차입분(15년이상)' ,left=474 ,top=1209 ,right=691 ,bottom=1259 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타 대출' ,left=696 ,top=1212 ,right=897 ,bottom=1262 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이자상환액' ,left=910 ,top=1090 ,right=1087 ,bottom=1151 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주택자금 공제액 계' ,left=360 ,top=1270 ,right=828 ,bottom=1312 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=119 ,top=529 ,right=283 ,bottom=709 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주택자금' ,left=124 ,top=934 ,right=283 ,bottom=1236 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1601 ,top=1029 ,right=1900 ,bottom=1029 </L>
	<L> left=1101 ,top=1087 ,right=1400 ,bottom=1087 </L>
	<L> left=1101 ,top=1209 ,right=1400 ,bottom=1209 </L>
	<L> left=1601 ,top=1207 ,right=1900 ,bottom=1207 </L>
	<L> left=1601 ,top=1146 ,right=1900 ,bottom=1146 </L>
	<L> left=1601 ,top=1087 ,right=1900 ,bottom=1087 </L>
	<L> left=1103 ,top=1029 ,right=1402 ,bottom=1029 </L>
	<L> left=1103 ,top=1151 ,right=1402 ,bottom=1151 </L>
	<T>id='작성방법 참조' ,left=1416 ,top=1090 ,right=1593 ,bottom=1151 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=900 ,top=1265 ,right=1601 ,bottom=1323 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=1902 ,top=103 ,right=1902 ,bottom=2794 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=691 ,top=968 ,right=691 ,bottom=1265 </L>
	<L> left=32 ,top=1323 ,right=1902 ,bottom=1323 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=299 ,top=106 ,right=299 ,bottom=1326 </L>
	<T>id='개인연금저축(2000년 이전 가입)' ,left=246 ,top=1331 ,right=754 ,bottom=1376 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사용액' ,left=106 ,top=2183 ,right=296 ,bottom=2265 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='신용카드 등' ,left=106 ,top=2074 ,right=296 ,bottom=2156 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=101 ,top=164 ,right=101 ,bottom=2802 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='공제' ,left=34 ,top=405 ,right=95 ,bottom=455 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='료' ,left=34 ,top=352 ,right=95 ,bottom=402 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험' ,left=34 ,top=299 ,right=95 ,bottom=349 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연금' ,left=34 ,top=246 ,right=95 ,bottom=296 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ⅱ.' ,left=34 ,top=193 ,right=95 ,bottom=243 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ⅲ.' ,left=34 ,top=513 ,right=95 ,bottom=614 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특' ,left=34 ,top=614 ,right=95 ,bottom=714 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='별' ,left=34 ,top=712 ,right=95 ,bottom=812 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=34 ,top=1016 ,right=95 ,bottom=1114 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=34 ,top=1111 ,right=95 ,bottom=1212 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소' ,left=34 ,top=812 ,right=95 ,bottom=913 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='득' ,left=34 ,top=913 ,right=95 ,bottom=1013 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=34 ,top=2350 ,right=95 ,bottom=2450 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=34 ,top=2252 ,right=95 ,bottom=2352 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='득' ,left=34 ,top=2154 ,right=95 ,bottom=2254 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소' ,left=34 ,top=2056 ,right=95 ,bottom=2156 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의' ,left=34 ,top=1860 ,right=95 ,bottom=1961 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='밖' ,left=34 ,top=1759 ,right=95 ,bottom=1860 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='그' ,left=34 ,top=1662 ,right=95 ,bottom=1762 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ⅳ.' ,left=34 ,top=1561 ,right=95 ,bottom=1662 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(2쪽)' ,left=1749 ,top=37 ,right=1902 ,bottom=98 ,align='right'</T>
	<T>id='보험료' ,left=918 ,top=352 ,right=1085 ,bottom=402 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=921 ,top=291 ,right=1087 ,bottom=341 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=921 ,top=230 ,right=1087 ,bottom=280 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1413 ,top=352 ,right=1582 ,bottom=402 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1413 ,top=291 ,right=1582 ,bottom=341 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1413 ,top=230 ,right=1582 ,bottom=280 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1416 ,top=169 ,right=1585 ,bottom=220 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=915 ,top=659 ,right=1082 ,bottom=709 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=915 ,top=595 ,right=1082 ,bottom=646 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=915 ,top=534 ,right=1082 ,bottom=585 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=918 ,top=474 ,right=1085 ,bottom=524 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1418 ,top=659 ,right=1588 ,bottom=709 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1418 ,top=595 ,right=1588 ,bottom=646 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1418 ,top=534 ,right=1588 ,bottom=585 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전액' ,left=1421 ,top=474 ,right=1590 ,bottom=524 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1405 ,top=788 ,right=1598 ,bottom=836 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='고정금리 ㆍ비거치' ,left=696 ,top=1148 ,right=897 ,bottom=1175 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상환 대출' ,left=696 ,top=1175 ,right=897 ,bottom=1201 ,face='굴림' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=601 ,top=781 ,right=601 ,bottom=905 </L>
	<T>id='작성방법 참조' ,left=1405 ,top=849 ,right=1598 ,bottom=897 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1405 ,top=913 ,right=1598 ,bottom=960 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납입금액' ,left=908 ,top=1328 ,right=1090 ,bottom=1378 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1101 ,top=101 ,right=1101 ,bottom=2799 </L>
	<L> left=101 ,top=2733 ,right=1900 ,bottom=2733 </L>
	<L> left=101 ,top=2667 ,right=1900 ,bottom=2667 </L>
	<L> left=101 ,top=2598 ,right=1900 ,bottom=2598 </L>
	<L> left=101 ,top=2529 ,right=1900 ,bottom=2529 </L>
	<L> left=106 ,top=2463 ,right=1905 ,bottom=2463 </L>
	<T>id='납입금액' ,left=910 ,top=2675 ,right=1093 ,bottom=2725 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1405 ,top=2678 ,right=1598 ,bottom=2725 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='장기집합투자증권저축' ,left=230 ,top=2678 ,right=765 ,bottom=2725 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기 타 (                                         )' ,left=230 ,top=2744 ,right=765 ,bottom=2791 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='목돈 안 드는 전세 이자상환액' ,left=233 ,top=2609 ,right=767 ,bottom=2656 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='고용유지중소기업 근로자' ,left=235 ,top=2543 ,right=770 ,bottom=2590 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='우리사주조합 기부금' ,left=235 ,top=2474 ,right=770 ,bottom=2521 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='우리사주조합 출연금' ,left=238 ,top=2408 ,right=773 ,bottom=2455 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이자상환액' ,left=913 ,top=2611 ,right=1095 ,bottom=2662 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='임금삭감액' ,left=910 ,top=2543 ,right=1093 ,bottom=2593 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금액' ,left=910 ,top=2474 ,right=1093 ,bottom=2521 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1405 ,top=2611 ,right=1598 ,bottom=2659 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1405 ,top=2543 ,right=1598 ,bottom=2590 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1408 ,top=2477 ,right=1601 ,bottom=2521 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1405 ,top=2413 ,right=1598 ,bottom=2461 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출연금액' ,left=910 ,top=2408 ,right=1093 ,bottom=2458 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=101 ,top=2397 ,right=1900 ,bottom=2397 </L>
	<T>id='계( ① + ② + ③ + ④ + ⑤ )' ,left=323 ,top=2342 ,right=857 ,bottom=2389 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=2331 ,right=1902 ,bottom=2331 </L>
	<L> left=299 ,top=2265 ,right=1900 ,bottom=2265 </L>
	<L> left=302 ,top=2193 ,right=1902 ,bottom=2193 </L>
	<L> left=299 ,top=2122 ,right=1900 ,bottom=2122 </L>
	<T>id='⑤ 대중교통이용분' ,left=307 ,top=2275 ,right=841 ,bottom=2323 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='④ 전통시장사용분' ,left=307 ,top=2209 ,right=841 ,bottom=2257 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='③ 현금영수증(전통시장ㆍ대중교통사용분 제외)' ,left=304 ,top=2140 ,right=894 ,bottom=2188 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='② 직불ㆍ선불카드(전통시장ㆍ대중교통사용분 제외)' ,left=307 ,top=2066 ,right=897 ,bottom=2114 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=302 ,top=2056 ,right=1902 ,bottom=2056 </L>
	<T>id='① 신용카드(전통시장ㆍ대중교통사용분 제외)' ,left=307 ,top=2003 ,right=897 ,bottom=2051 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=101 ,top=1990 ,right=1900 ,bottom=1990 </L>
	<X>left=900 ,top=2265 ,right=1101 ,bottom=2331 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=299 ,top=1924 ,right=1900 ,bottom=1924 </L>
	<T>id='투자조합 출자 등 소득공제 계' ,left=357 ,top=1931 ,right=847 ,bottom=1982 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=900 ,top=1924 ,right=1101 ,bottom=1990 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1400 ,top=1924 ,right=1601 ,bottom=2397 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1601 ,top=1990 ,right=1902 ,bottom=2265 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='2014년 이후 출자ㆍ투자분' ,left=357 ,top=1868 ,right=847 ,bottom=1918 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1405 ,top=1871 ,right=1598 ,bottom=1918 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=1857 ,right=1900 ,bottom=1857 </L>
	<T>id='출자ㆍ투자금액' ,left=905 ,top=1868 ,right=1101 ,bottom=1913 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2013년 출자ㆍ투자분' ,left=357 ,top=1802 ,right=847 ,bottom=1852 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출자ㆍ투자금액' ,left=902 ,top=1804 ,right=1098 ,bottom=1849 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1405 ,top=1804 ,right=1598 ,bottom=1852 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=1791 ,right=1900 ,bottom=1791 </L>
	<T>id='2012년 출자ㆍ투자분' ,left=360 ,top=1733 ,right=849 ,bottom=1783 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출자ㆍ투자금액' ,left=902 ,top=1738 ,right=1098 ,bottom=1783 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1405 ,top=1738 ,right=1598 ,bottom=1786 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=103 ,top=1722 ,right=1902 ,bottom=1722 </L>
	<T>id='출자등' ,left=106 ,top=1860 ,right=296 ,bottom=1942 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='투자조합' ,left=106 ,top=1775 ,right=296 ,bottom=1857 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주택마련저축' ,left=106 ,top=1495 ,right=296 ,bottom=1712 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주택마련저축 소득공제 계' ,left=357 ,top=1670 ,right=847 ,bottom=1720 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=1656 ,right=1900 ,bottom=1656 </L>
	<X>left=1400 ,top=1656 ,right=1601 ,bottom=1722 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=900 ,top=1656 ,right=1101 ,bottom=1722 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='주택청약종합저축' ,left=418 ,top=1598 ,right=783 ,bottom=1648 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납입금액' ,left=910 ,top=1598 ,right=1093 ,bottom=1648 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1405 ,top=1603 ,right=1598 ,bottom=1651 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=1585 ,right=1900 ,bottom=1585 </L>
	<T>id='납입금액' ,left=910 ,top=1532 ,right=1093 ,bottom=1582 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근로자주택마련저축' ,left=421 ,top=1529 ,right=786 ,bottom=1580 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1405 ,top=1535 ,right=1598 ,bottom=1582 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=1519 ,right=1900 ,bottom=1519 </L>
	<T>id='작성방법 참조' ,left=1405 ,top=1466 ,right=1598 ,bottom=1513 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납입금액' ,left=910 ,top=1463 ,right=1093 ,bottom=1513 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='청약저축' ,left=497 ,top=1463 ,right=699 ,bottom=1513 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=101 ,top=1453 ,right=1900 ,bottom=1453 </L>
	<L> left=299 ,top=1455 ,right=299 ,bottom=2400 </L>
	<T>id='소기업ㆍ소상공인 공제부금' ,left=243 ,top=1402 ,right=751 ,bottom=1447 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납입금액' ,left=910 ,top=1400 ,right=1093 ,bottom=1450 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법 참조' ,left=1405 ,top=1402 ,right=1598 ,bottom=1450 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1902 ,top=1386 ,right=106 ,bottom=1386 </L>
	<X>left=900 ,top=714 ,right=1101 ,bottom=781 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1400 ,top=714 ,right=1601 ,bottom=781 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='종(전)근무지' ,left=624 ,top=291 ,right=884 ,bottom=344 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)근무지' ,left=624 ,top=474 ,right=884 ,bottom=527 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주(현)근무지' ,left=624 ,top=352 ,right=884 ,bottom=405 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주(현)근무지' ,left=624 ,top=532 ,right=884 ,bottom=585 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주(현)근무지' ,left=624 ,top=659 ,right=884 ,bottom=712 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)근무지' ,left=624 ,top=595 ,right=884 ,bottom=648 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=474 ,top=1146 ,right=900 ,bottom=1146 </L>
	
	<C>id='{decode(JAQ_AMT,0,,JAQ_AMT)}', left=1117, top=169, right=1397, bottom=222, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(NPEN_AMT,0,,NPEN_AMT)}',  left=1117,top=230, right=1397, bottom=283, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAR_AMT,0,,JAR_AMT)}', left=1117, top=291, right=1397, bottom=344, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PEN_SUM,0,,PEN_SUM)}', left=1117, top=413, right=1397, bottom=466, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAH_AMT,0,,JAH_AMT)}', left=1117, top=474, right=1397, bottom=527, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HEALTH_AMT,0,,HEALTH_AMT)}', left=1117, top=532, right=1397, bottom=585, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAP_AMT,0,,JAP_AMT)}', left=1117, top=595, right=1397, bottom=648, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HINS_AMT,0,,HINS_AMT)}', left=1117, top=659, right=1397, bottom=712, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HIN_SUM,0,,HIN_SUM)}', left=1117, top=722, right=1397, bottom=775, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LH1_AMT,0,,LH1_AMT)}', left=1117, top=786, right=1397, bottom=839, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LH2_AMT,0,,LH2_AMT)}', left=1117, top=847, right=1397, bottom=900, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LH3_AMT,0,,LH3_AMT)}', left=1117, top=910, right=1397, bottom=963, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LH4_AMT,0,,LH4_AMT)}', left=1117, top=974, right=1397, bottom=1027, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LH5_AMT,0,,LH5_AMT)}', left=1117, top=1032, right=1397, bottom=1085, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LH6_AMT,0,,LH6_AMT)}', left=1117, top=1093, right=1397, bottom=1146, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LH7_AMT,0,,LH7_AMT)}', left=1117, top=1154, right=1397, bottom=1207, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LH8_AMT,0,,LH8_AMT)}', left=1117, top=1212, right=1397, bottom=1265, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(VEN3_AMT,0,,VEN3_AMT)}', left=1117, top=1865, right=1397, bottom=1918, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(VEN_SUM,0,,VEN_SUM)}', left=1117, top=1931, right=1397, bottom=1984, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CARD_AMT,0,,CARD_AMT)}', left=1117, top=1995, right=1397, bottom=2048, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DIR_CARD_AMT,0,,DIR_CARD_AMT)}', left=1117, top=2064, right=1397, bottom=2117, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CASH_AMT,0,,CASH_AMT)}', left=1117, top=2135, right=1397, bottom=2188, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(MARKET_AMT,0,,MARKET_AMT)}', left=1117, top=2207, right=1397, bottom=2260, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PUBLIC_AMT,0,,PUBLIC_AMT)}', left=1117, top=2273, right=1397, bottom=2326, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CARD_SUM,0,,CARD_SUM)}', left=1117, top=2339, right=1397, bottom=2392, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LLL_SUM,0,,LLL_SUM)}', left=1117, top=1667, right=1397, bottom=1720, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LHP_AMT,0,,LHP_AMT)}', left=1117, top=1598, right=1397, bottom=1651, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LHR_AMT,0,,LHR_AMT)}', left=1114, top=1529, right=1394, bottom=1582, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LHO_AMT,0,,LHO_AMT)}', left=1114, top=1463, right=1394, bottom=1516, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PER_AMT,0,,PER_AMT)}', left=1114, top=1331, right=1394, bottom=1384, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(VEN_AMT,0,,VEN_AMT)}', left=1117, top=1733, right=1397, bottom=1786, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(VEN2_AMT,0,,VEN2_AMT)}', left=1117, top=1799, right=1397, bottom=1852, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SAJU_AMT,0,,SAJU_AMT)}', left=1117, top=2405, right=1397, bottom=2458, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LSS_AMT,0,,LSS_AMT)}', left=1117, top=2672, right=1397, bottom=2725, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>

</R>
</A>

<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='3쪽.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='ds_print'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2812 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='(3쪽)' ,left=1741 ,top=0 ,right=1894 ,bottom=42 ,align='right'</T>
	<T>id='신청한 경우 해당 명세서를 제출해야 합니다.' ,left=1035 ,top=2463 ,right=1736 ,bottom=2495 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='명세서를 제출해야 합니다.' ,left=921 ,top=2389 ,right=1622 ,bottom=2421 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제 출 (    ) ※ 연금계좌, 주택마련저축 등 소득 세액공제를 신청한 경우' ,left=908 ,top=2357 ,right=1844 ,bottom=2389 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제 출 (    ) ※ 월세액, 거주자 간 주택임차차입금 원리금 상환액 소득공제를' ,left=908 ,top=2432 ,right=1894 ,bottom=2463 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1500 ,top=2223 ,right=1500 ,bottom=2355 </L>
	<L> left=1101 ,top=2270 ,right=1101 ,bottom=2355 </L>
	<T>id=' 명세서 제출 여부    ( O 또는 X 로 적습니다)' ,left=90 ,top=2463 ,right=894 ,bottom=2490 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  4. 월세액ㆍ거주자 간 주택임차차입금 원리금상환액 소득공제' ,left=42 ,top=2432 ,right=894 ,bottom=2463 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ① 의료비지급명세서 (   ),           ② 기부금명세서 (   ),          ③ 소득공제 증빙서류' ,left=558 ,top=2503 ,right=1876 ,bottom=2540 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' 5. 그 밖의 추가 제출 서류' ,left=48 ,top=2500 ,right=468 ,bottom=2540 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  3. 연금ㆍ저축 등 소득공제 명세서 제출여부' ,left=42 ,top=2357 ,right=770 ,bottom=2394 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ( O 또는 X 로 적습니다)' ,left=87 ,top=2397 ,right=556 ,bottom=2429 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='원천징수영수증 제출(        )' ,left=1516 ,top=2307 ,right=1884 ,bottom=2350 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)근무지 근로소득' ,left=1516 ,top=2273 ,right=1881 ,bottom=2310 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  2. 종(전)근무지명세' ,left=40 ,top=2273 ,right=294 ,bottom=2352 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사업자등록번호' ,left=302 ,top=2315 ,right=540 ,bottom=2350 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)결정세액' ,left=908 ,top=2315 ,right=1095 ,bottom=2352 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='종(전)급여총액' ,left=908 ,top=2273 ,right=1095 ,bottom=2307 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=296 ,top=2310 ,right=1498 ,bottom=2310 </L>
	<T>id='종(전)근무지명' ,left=302 ,top=2273 ,right=537 ,bottom=2310 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1003 ,top=1693 ,right=1003 ,bottom=2006 </L>
	<T>id='제 출 (        )' ,left=1566 ,top=2228 ,right=1860 ,bottom=2265 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  1. 외국인근로자 단일세율적용신청서 제출 여부( O 또는 X 로 적습니다)' ,left=42 ,top=2228 ,right=1193 ,bottom=2265 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금' ,left=344 ,top=1537 ,right=437 ,bottom=1585 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=958 ,top=434 ,right=958 ,bottom=1693 </L>
	<L> left=1701 ,top=392 ,right=1701 ,bottom=1693 </L>
	<L> left=1908 ,top=1691 ,right=238 ,bottom=1691 </L>
	<T>id='외국납부세액' ,left=355 ,top=1744 ,right=691 ,bottom=1913 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국외원천소득' ,left=810 ,top=1696 ,right=997 ,bottom=1733 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=804 ,top=1733 ,right=1905 ,bottom=1733 </L>
	<T>id='납세액(외화)' ,left=815 ,top=1746 ,right=995 ,bottom=1778 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납세액(원화)' ,left=812 ,top=1789 ,right=995 ,bottom=1823 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근무기간' ,left=815 ,top=1916 ,right=987 ,bottom=1953 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이자상환액' ,left=815 ,top=1958 ,right=987 ,bottom=1998 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주택자금차입금이자세액공제' ,left=296 ,top=1958 ,right=754 ,bottom=1998 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='교육비' ,left=344 ,top=1183 ,right=437 ,bottom=1230 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제' ,left=243 ,top=1045 ,right=333 ,bottom=1090 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세액' ,left=243 ,top=987 ,right=333 ,bottom=1032 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특별' ,left=243 ,top=926 ,right=333 ,bottom=971 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='의료비' ,left=344 ,top=958 ,right=437 ,bottom=1005 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=344 ,top=736 ,right=434 ,bottom=783 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계좌' ,left=243 ,top=566 ,right=333 ,bottom=611 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연금' ,left=243 ,top=503 ,right=333 ,bottom=548 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납입금액' ,left=804 ,top=439 ,right=953 ,bottom=487 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=344 ,top=101 ,right=344 ,bottom=325 </L>
	<T>id='공제세액' ,left=1717 ,top=397 ,right=1916 ,bottom=429 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제율' ,left=1574 ,top=394 ,right=1691 ,bottom=431 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='한도액' ,left=1177 ,top=394 ,right=1336 ,bottom=429 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=799 ,top=161 ,right=799 ,bottom=2003 </L>
	<L> left=1344 ,top=392 ,right=1344 ,bottom=2008 </L>
	<L> left=238 ,top=48 ,right=238 ,bottom=2006 </L>
	<T>id='신고인' ,left=1085 ,top=2114 ,right=1326 ,bottom=2164 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세액공제' ,left=108 ,top=1106 ,right=230 ,bottom=1151 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제' ,left=37 ,top=1217 ,right=98 ,bottom=1267 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공' ,left=37 ,top=1140 ,right=98 ,bottom=1191 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='및' ,left=37 ,top=1064 ,right=98 ,bottom=1114 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='면' ,left=37 ,top=979 ,right=98 ,bottom=1029 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='감' ,left=37 ,top=902 ,right=98 ,bottom=953 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='액' ,left=37 ,top=828 ,right=98 ,bottom=876 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세' ,left=37 ,top=751 ,right=98 ,bottom=802 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ⅴ.' ,left=37 ,top=675 ,right=98 ,bottom=725 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=50 ,right=29 ,bottom=2773 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='세액감면ㆍ공제명세' ,left=1151 ,top=56 ,right=1487 ,bottom=95 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구분' ,left=71 ,top=58 ,right=209 ,bottom=95 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='감면기간 종료일' ,left=1386 ,top=333 ,right=1656 ,bottom=384 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제출일' ,left=1421 ,top=278 ,right=1622 ,bottom=325 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='제출일' ,left=1421 ,top=222 ,right=1622 ,bottom=270 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1701 ,top=214 ,right=1701 ,bottom=392 </L>
	<T>id='접수일' ,left=831 ,top=333 ,right=1032 ,bottom=381 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='접수일' ,left=831 ,top=278 ,right=1032 ,bottom=325 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='접수일' ,left=831 ,top=222 ,right=1032 ,bottom=270 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기술도입계약 또는 근로제공일' ,left=370 ,top=167 ,right=773 ,bottom=212 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='외국인 근로소득에 대한 감면' ,left=368 ,top=222 ,right=770 ,bottom=267 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근로소득에 대한 조세조약 상 면제' ,left=352 ,top=280 ,right=799 ,bottom=325 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='외국인' ,left=243 ,top=146 ,right=333 ,bottom=191 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근로자' ,left=243 ,top=191 ,right=333 ,bottom=235 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='중소기업 취업자 감면' ,left=294 ,top=333 ,right=730 ,bottom=378 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세액감면' ,left=108 ,top=164 ,right=230 ,bottom=209 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='입국목적' ,left=434 ,top=106 ,right=619 ,bottom=151 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='[ ] 정부간 협약   [ ] 기술도입계약   [ ] 「조세특례제한법」상 감면   [ ] 조세조약상 감면' ,left=699 ,top=108 ,right=1889 ,bottom=151 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세액감면ㆍ공제명세' ,left=384 ,top=56 ,right=720 ,bottom=95 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=796 ,top=53 ,right=796 ,bottom=103 </L>
	<T>id='210㎜x297㎜' ,left=1299 ,top=2778 ,right=1889 ,bottom=2813 ,align='right'</T>
	<T>id='     3. 공제금액란은 근로소득자가 원천징수의무자에게 제출하는 경우 적지 않을 수 있습니다.' ,left=40 ,top=2728 ,right=1900 ,bottom=2773 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     2. 현 근무지의 연금보험료ㆍ국민건강보험료 및 고용보험료 등은 신고인이 작성하지 않아도 됩니다.' ,left=40 ,top=2683 ,right=1900 ,bottom=2728 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     신고하지 않은 경우 가산세 부과 등 불이익이 따릅니다.' ,left=40 ,top=2638 ,right=1900 ,bottom=2683 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='     1. 근로소득자가 종(전)근무지 근로소득을 원천징수의무자에게 신고하지 아니하는 경우에는 근로소득자 본인이 종합소득세 신고를 하여야 하며,' ,left=40 ,top=2593 ,right=1900 ,bottom=2638 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='    ※ 근로소득자 참고사항' ,left=40 ,top=2553 ,right=1900 ,bottom=2593 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1162 ,top=389 ,right=1162 ,bottom=1688 </L>
	<L> left=1950 ,top=50 ,right=1950 ,bottom=2770 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=336 ,top=437 ,right=336 ,bottom=1693 </L>
	<T>id='신청서제출일' ,left=815 ,top=1873 ,right=992 ,bottom=1905 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납세국명' ,left=826 ,top=1828 ,right=990 ,bottom=1863 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=101 ,top=101 ,right=101 ,bottom=2000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='명세' ,left=870 ,top=392 ,right=1072 ,bottom=429 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제대상금액' ,left=1360 ,top=394 ,right=1561 ,bottom=429 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공 제 종 류' ,left=291 ,top=394 ,right=728 ,bottom=429 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=50 ,right=1950 ,bottom=50 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1953 ,top=101 ,right=26 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=344 ,top=214 ,right=1945 ,bottom=214 </L>
	<L> left=344 ,top=159 ,right=1947 ,bottom=159 </L>
	<L> left=347 ,top=273 ,right=1945 ,bottom=273 </L>
	<L> left=238 ,top=328 ,right=1945 ,bottom=328 </L>
	<L> left=98 ,top=389 ,right=1947 ,bottom=389 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1945 ,top=431 ,right=235 ,bottom=431 </L>
	<T>id='과학기술인공제' ,left=368 ,top=439 ,right=738 ,bottom=484 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1564 ,top=487 ,right=1344 ,bottom=487 </L>
	<L> left=1947 ,top=489 ,right=1701 ,bottom=489 </L>
	<L> left=1564 ,top=392 ,right=1564 ,bottom=2006 </L>
	<L> left=241 ,top=1953 ,right=1950 ,bottom=1953 </L>
	<L> left=802 ,top=1908 ,right=1950 ,bottom=1908 </L>
	<T>id='국외근무처' ,left=1357 ,top=1871 ,right=1550 ,bottom=1902 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납부일' ,left=1363 ,top=1828 ,right=1556 ,bottom=1863 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='-' ,left=1368 ,top=1786 ,right=1545 ,bottom=1820 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직책' ,left=1376 ,top=1916 ,right=1543 ,bottom=1947 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='30%' ,left=1368 ,top=1961 ,right=1543 ,bottom=2000 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=802 ,top=1865 ,right=1947 ,bottom=1865 </L>
	<L> left=802 ,top=1823 ,right=1947 ,bottom=1823 </L>
	<X>left=1344 ,top=1691 ,right=1947 ,bottom=1778 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=1950 ,top=2773 ,right=29 ,bottom=2773 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=2167 ,right=1950 ,bottom=2167 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=26 ,top=2006 ,right=1950 ,bottom=2006 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=29 ,top=2267 ,right=1947 ,bottom=2267 </L>
	<L> left=29 ,top=2352 ,right=1947 ,bottom=2352 </L>
	<L> left=32 ,top=2429 ,right=1947 ,bottom=2429 </L>
	<L> left=29 ,top=2543 ,right=1950 ,bottom=2543 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1945 ,top=2498 ,right=29 ,bottom=2498 </L>
	<L> left=545 ,top=2267 ,right=545 ,bottom=2352 </L>
	<L> left=29 ,top=2223 ,right=1953 ,bottom=2223 </L>
	<T>id='       신고인은 「소득세법」 제140조에 따라 위의 내용을 신고하며, 위 내용을 충분히 검토하였고 신고인이 알고 있는 사실 그대로를 정확하게 ' ,left=66 ,top=2011 ,right=1934 ,bottom=2058 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='       적었음을 확인합니다.' ,left=66 ,top=2058 ,right=923 ,bottom=2098 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='월' ,left=1569 ,top=2064 ,right=1625 ,bottom=2109 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' 2015 년   ' ,left=1365 ,top=2064 ,right=1487 ,bottom=2109 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='MM', left=1490, top=2064, right=1566, bottom=2109, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DD', left=1625, top=2064, right=1701, bottom=2109, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='일' ,left=1701 ,top=2064 ,right=1757 ,bottom=2109 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(서명 또는 인)' ,left=1603 ,top=2109 ,right=1884 ,bottom=2159 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=802 ,top=1778 ,right=1947 ,bottom=1778 </L>
	<L> left=336 ,top=487 ,right=1164 ,bottom=487 </L>
	<T>id='「근로자퇴직급여 보장법」에' ,left=368 ,top=489 ,right=751 ,bottom=527 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='따른 퇴직연금' ,left=373 ,top=524 ,right=743 ,bottom=548 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납입금액' ,left=807 ,top=492 ,right=955 ,bottom=540 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='참조' ,left=1177 ,top=524 ,right=1336 ,bottom=574 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1159 ,top=550 ,right=336 ,bottom=550 </L>
	<T>id='12%' ,left=1574 ,top=513 ,right=1691 ,bottom=564 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1564 ,top=548 ,right=1347 ,bottom=548 </L>
	<L> left=1950 ,top=548 ,right=1704 ,bottom=548 </L>
	<T>id='연금저축' ,left=376 ,top=556 ,right=746 ,bottom=606 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납입금액' ,left=807 ,top=556 ,right=955 ,bottom=603 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=336 ,top=611 ,right=1564 ,bottom=611 </L>
	<L> left=1947 ,top=614 ,right=1701 ,bottom=614 </L>
	<X>left=1162 ,top=611 ,right=1344 ,bottom=677 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=799 ,top=611 ,right=958 ,bottom=677 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=241 ,top=677 ,right=1947 ,bottom=677 </L>
	<T>id='연금계좌 계' ,left=376 ,top=622 ,right=746 ,bottom=672 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보장성' ,left=542 ,top=683 ,right=691 ,bottom=730 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=818 ,top=683 ,right=942 ,bottom=730 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='100만원' ,left=1175 ,top=683 ,right=1334 ,bottom=733 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=442 ,top=738 ,right=1561 ,bottom=738 </L>
	<L> left=442 ,top=677 ,right=442 ,bottom=1691 </L>
	<T>id='장애인전용보장성' ,left=505 ,top=746 ,right=751 ,bottom=794 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료' ,left=818 ,top=746 ,right=942 ,bottom=794 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='100만원' ,left=1172 ,top=743 ,right=1331 ,bottom=794 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=442 ,top=802 ,right=1564 ,bottom=802 </L>
	<X>left=1162 ,top=802 ,right=1344 ,bottom=865 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=799 ,top=802 ,right=958 ,bottom=865 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=1701 ,top=741 ,right=1950 ,bottom=741 </L>
	<L> left=1701 ,top=804 ,right=1950 ,bottom=804 </L>
	<T>id='12%' ,left=1572 ,top=743 ,right=1688 ,bottom=794 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보험료 계' ,left=503 ,top=807 ,right=743 ,bottom=863 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=336 ,top=865 ,right=1947 ,bottom=865 </L>
	<T>id='본인ㆍ65세 이상자ㆍ장애인' ,left=447 ,top=870 ,right=796 ,bottom=918 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지출액' ,left=815 ,top=870 ,right=939 ,bottom=918 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법' ,left=1180 ,top=876 ,right=1331 ,bottom=926 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='참조' ,left=1180 ,top=926 ,right=1331 ,bottom=976 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15%' ,left=1577 ,top=921 ,right=1693 ,bottom=971 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=442 ,top=926 ,right=1162 ,bottom=926 </L>
	<L> left=1564 ,top=926 ,right=1344 ,bottom=926 </L>
	<T>id='그 밖의 공제대상자' ,left=479 ,top=931 ,right=786 ,bottom=979 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지출액' ,left=815 ,top=931 ,right=939 ,bottom=979 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1561 ,top=987 ,right=442 ,bottom=987 </L>
	<L> left=1947 ,top=987 ,right=1701 ,bottom=987 </L>
	<L> left=1947 ,top=926 ,right=1701 ,bottom=926 </L>
	<L> left=336 ,top=1050 ,right=1947 ,bottom=1050 </L>
	<X>left=1162 ,top=987 ,right=1344 ,bottom=1050 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=799 ,top=987 ,right=958 ,bottom=1050 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='의료비 계' ,left=476 ,top=995 ,right=788 ,bottom=1045 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득자 본인' ,left=476 ,top=1058 ,right=783 ,bottom=1101 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공납금(대' ,left=818 ,top=1056 ,right=942 ,bottom=1080 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1564 ,top=1111 ,right=442 ,bottom=1111 </L>
	<T>id='전액' ,left=1180 ,top=1064 ,right=1331 ,bottom=1103 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='유치원/' ,left=818 ,top=1117 ,right=942 ,bottom=1140 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='학원비 등' ,left=818 ,top=1140 ,right=942 ,bottom=1164 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1명당 300만원' ,left=1164 ,top=1117 ,right=1341 ,bottom=1167 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1564 ,top=1169 ,right=442 ,bottom=1169 </L>
	<L> left=1947 ,top=1172 ,right=1701 ,bottom=1172 </L>
	<L> left=1947 ,top=1114 ,right=1701 ,bottom=1114 </L>
	<T>id='1명당 300만원' ,left=1164 ,top=1175 ,right=1341 ,bottom=1225 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공납금' ,left=818 ,top=1175 ,right=942 ,bottom=1222 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1561 ,top=1228 ,right=442 ,bottom=1228 </L>
	<T>id='대학생(대학원불포함)' ,left=447 ,top=1236 ,right=685 ,bottom=1288 ,face='굴림' ,size=7 ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공납금' ,left=815 ,top=1233 ,right=939 ,bottom=1281 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1명당 900만원' ,left=1167 ,top=1233 ,right=1344 ,bottom=1283 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15%' ,left=1574 ,top=1167 ,right=1691 ,bottom=1217 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1947 ,top=1228 ,right=1701 ,bottom=1228 </L>
	<L> left=442 ,top=1289 ,right=1564 ,bottom=1289 </L>
	<L> left=1947 ,top=1289 ,right=1701 ,bottom=1289 </L>
	<T>id='전액' ,left=1180 ,top=1294 ,right=1331 ,bottom=1334 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특수교육비' ,left=802 ,top=1296 ,right=955 ,bottom=1339 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=445 ,top=1347 ,right=1950 ,bottom=1347 </L>
	<T>id='장애인 ' ,left=458 ,top=1299 ,right=675 ,bottom=1341 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=799 ,top=1347 ,right=958 ,bottom=1405 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=339 ,top=1405 ,right=1953 ,bottom=1405 </L>
	<X>left=1162 ,top=1347 ,right=1344 ,bottom=1405 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='교육비 계' ,left=466 ,top=1352 ,right=778 ,bottom=1397 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10만원 이하' ,left=579 ,top=1410 ,right=786 ,bottom=1458 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금액' ,left=804 ,top=1410 ,right=955 ,bottom=1450 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=566 ,top=1458 ,right=1162 ,bottom=1458 </L>
	<T>id='10만원 초과' ,left=579 ,top=1463 ,right=786 ,bottom=1511 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='정치자금' ,left=447 ,top=1413 ,right=564 ,bottom=1461 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금' ,left=458 ,top=1463 ,right=550 ,bottom=1511 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=442 ,top=1516 ,right=1162 ,bottom=1516 </L>
	<L> left=566 ,top=1405 ,right=566 ,bottom=1516 </L>
	<T>id='기부금액' ,left=804 ,top=1471 ,right=955 ,bottom=1511 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='100/110' ,left=1574 ,top=1410 ,right=1691 ,bottom=1450 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='법정기부금' ,left=537 ,top=1521 ,right=714 ,bottom=1564 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=442 ,top=1569 ,right=1162 ,bottom=1569 </L>
	<T>id='지정기부금' ,left=537 ,top=1580 ,right=714 ,bottom=1619 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금액' ,left=804 ,top=1580 ,right=955 ,bottom=1619 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(25%)' ,left=1572 ,top=1558 ,right=1688 ,bottom=1609 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15%' ,left=1572 ,top=1508 ,right=1688 ,bottom=1558 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기부금 계' ,left=474 ,top=1638 ,right=786 ,bottom=1680 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=439 ,top=1630 ,right=1942 ,bottom=1630 </L>
	<X>left=1162 ,top=1630 ,right=1344 ,bottom=1691 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=799 ,top=1630 ,right=958 ,bottom=1691 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='기부금액' ,left=804 ,top=1524 ,right=955 ,bottom=1564 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='참조' ,left=1180 ,top=1524 ,right=1331 ,bottom=1574 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법' ,left=1180 ,top=1471 ,right=1331 ,bottom=1521 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1564 ,top=1569 ,right=1344 ,bottom=1569 </L>
	<L> left=1564 ,top=1513 ,right=1347 ,bottom=1513 </L>
	<L> left=1947 ,top=1458 ,right=1344 ,bottom=1458 </L>
	<L> left=1950 ,top=1513 ,right=1704 ,bottom=1513 </L>
	<L> left=1947 ,top=1572 ,right=1701 ,bottom=1572 </L>
	<T>id='Ⅵ. 추가 제출 서류' ,left=37 ,top=2175 ,right=307 ,bottom=2220 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=892 ,top=2270 ,right=892 ,bottom=2426 </L>
	<L> left=524 ,top=2498 ,right=524 ,bottom=2540 </L>
	<T>id='초중고등학교 ' ,left=450 ,top=1177 ,right=667 ,bottom=1225 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='취학전 아동 ' ,left=452 ,top=1122 ,right=669 ,bottom=1164 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작성방법' ,left=1180 ,top=474 ,right=1331 ,bottom=524 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(HEA_AMT,0,,HEA_AMT)}', left=963, top=873, right=1162, bottom=921, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(OHEA_AMT,0,,OHEA_AMT)}', left=963, top=934, right=1162, bottom=982, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HEA_SUM,0,,HEA_SUM)}', left=963, top=995, right=1162, bottom=1042, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(GRA_AMT,0,,GRA_AMT)}', left=963, top=1058, right=1162, bottom=1106, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDU_AMT1,0,,EDU_AMT1)}', left=963, top=1117, right=1162, bottom=1164, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDU_AMT2,0,,EDU_AMT2)}', left=963, top=1175, right=1162, bottom=1222, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDU_AMT3,0,,EDU_AMT3)}', left=966, top=1233, right=1162, bottom=1286, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HED_AMT,0,,HED_AMT)}', left=966, top=1294, right=1162, bottom=1347, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDU_SUM,0,,EDU_SUM)}', left=966, top=1349, right=1162, bottom=1402, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='학원 포함)' ,left=818 ,top=1085 ,right=942 ,bottom=1109 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LC1_AMT,0,,LC1_AMT)}', left=966, top=1521, right=1162, bottom=1566, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LCC_SUM,0,,LCC_SUM)}', left=966, top=1638, right=1162, bottom=1683, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LC23_AMT,0,,LC23_AMT)}', left=966, top=1577, right=1162, bottom=1622, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(GOV1_AMT,0,,GOV1_AMT)}', left=966, top=1410, right=1162, bottom=1455, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(GOV2_AMT,0,,GOV2_AMT)}', left=966, top=1466, right=1162, bottom=1511, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LIN_AMT,0,,LIN_AMT)}', left=963, top=685, right=1162, bottom=733, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LIH_AMT,0,,LIH_AMT)}', left=963, top=749, right=1162, bottom=796, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LI_SUM,0,,LI_SUM)}', left=963, top=810, right=1162, bottom=857, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ANN_AMT,0,,ANN_AMT)}', left=963, top=558, right=1162, bottom=606, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ANN_AMT,0,,ANN_AMT)}', left=963, top=622, right=1162, bottom=669, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='감면기간 종료일' ,left=1064 ,top=161 ,right=1334 ,bottom=209 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TAG1_CNT', left=664, top=1119, right=796, bottom=1167, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAG2_CNT', left=664, top=1177, right=796, bottom=1225, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAG3_CNT', left=683, top=1236, right=796, bottom=1288, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAG4_CNT', left=664, top=1296, right=796, bottom=1344, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=1344, top=2104, right=1588, bottom=2162, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	
	<L> left=1344 ,top=159 ,right=1344 ,bottom=386 </L>
	<L> left=1048 ,top=159 ,right=1048 ,bottom=386 </L>
</B>

</R>
</A>

<A>id=Area4 ,left=0,top=0 ,right=2000 ,bottom=180
<R>id='7쪽.sbt' ,left=0 ,top=20 ,right=2000 ,bottom=151, DetailDataID='ds_print'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=201 ,face='굴림' ,size=10 ,penwidth=1
	<L> left=82 ,top=130 ,right=1953 ,bottom=130 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=82 ,top=2799 ,right=1953 ,bottom=2799 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=82 ,top=130 ,right=82 ,bottom=2799 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1953 ,top=130 ,right=1953 ,bottom=2799 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=82 ,top=249 ,right=1953 ,bottom=249 </L>
	<L> left=82 ,top=349 ,right=1953 ,bottom=349 </L>
	<L> left=82 ,top=431 ,right=1953 ,bottom=431 </L>
	<L> left=82 ,top=511 ,right=1953 ,bottom=511 </L>
	<L> left=802 ,top=349 ,right=802 ,bottom=511 </L>
	<L> left=1281 ,top=349 ,right=1281 ,bottom=511 </L>
	<L> left=1336 ,top=349 ,right=1336 ,bottom=431 </L>
	<L> left=1392 ,top=349 ,right=1392 ,bottom=431 </L>
	<L> left=1450 ,top=349 ,right=1450 ,bottom=431 </L>
	<L> left=1505 ,top=349 ,right=1505 ,bottom=431 </L>
	<L> left=1561 ,top=349 ,right=1561 ,bottom=431 </L>
	<L> left=1617 ,top=349 ,right=1617 ,bottom=431 </L>
	<L> left=1672 ,top=349 ,right=1672 ,bottom=431 </L>
	<L> left=1728 ,top=349 ,right=1728 ,bottom=431 </L>
	<L> left=1786 ,top=349 ,right=1786 ,bottom=431 </L>
	<L> left=1842 ,top=349 ,right=1842 ,bottom=431 </L>
	<L> left=1897 ,top=349 ,right=1897 ,bottom=431 </L>
	<C>id='EMPNMK', left=352, top=431, right=802, bottom=511</C>
	<T>id='(7쪽)' ,left=1791 ,top=71 ,right=1945 ,bottom=132 ,align='right'</T>
	<T>id='1. 인적사항' ,left=103 ,top=249 ,right=352 ,bottom=349 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='①상            호' ,left=82 ,top=349 ,right=352 ,bottom=431 ,align='left'</T>
	<T>id='현대아산 주식회사' ,left=352 ,top=349 ,right=802 ,bottom=431</T>
	<T>id='②사  업  자  등  록  번  호' ,left=802 ,top=349 ,right=1281 ,bottom=431 ,align='left'</T>
	<T>id='2' ,left=1281 ,top=349 ,right=1336 ,bottom=431</T>
	<T>id='2' ,left=1336 ,top=349 ,right=1392 ,bottom=431</T>
	<T>id='1' ,left=1392 ,top=349 ,right=1450 ,bottom=431</T>
	<T>id='-' ,left=1450 ,top=349 ,right=1505 ,bottom=431</T>
	<T>id='8' ,left=1505 ,top=349 ,right=1561 ,bottom=431</T>
	<T>id='1' ,left=1561 ,top=349 ,right=1617 ,bottom=431</T>
	<T>id='-' ,left=1617 ,top=349 ,right=1672 ,bottom=431</T>
	<T>id='1' ,left=1672 ,top=349 ,right=1728 ,bottom=431</T>
	<T>id='3' ,left=1728 ,top=349 ,right=1786 ,bottom=431</T>
	<T>id='8' ,left=1786 ,top=349 ,right=1842 ,bottom=431</T>
	<T>id='3' ,left=1842 ,top=349 ,right=1897 ,bottom=431</T>
	<T>id='4' ,left=1897 ,top=349 ,right=1953 ,bottom=431</T>
	<T>id='③성            명' ,left=82 ,top=431 ,right=352 ,bottom=511 ,align='left'</T>
	<T>id='④주   민   등   록   번   호' ,left=802 ,top=431 ,right=1281 ,bottom=511 ,align='left'</T>
	<T>id='5. 공제금액란은 근로소득자가 적지 아니할 수 있습니다.' ,left=93 ,top=2731 ,right=1953 ,bottom=2781 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='210㎜x297㎜' ,left=1352 ,top=2805 ,right=1942 ,bottom=2839 ,align='right'</T>
	<T>id='4. 주택마련저축 공제의 저축구분란은 청약저축, 주택청약종합저축 및 근로자주택마련저축으로 구분하여 적습니다.' ,left=93 ,top=2683 ,right=1953 ,bottom=2733 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3. 연금저축계좌에서 연금저축구분란은 개인연금저축과 연금저축으로 구분하여 적습니다.' ,left=93 ,top=2633 ,right=1953 ,bottom=2683 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2. 퇴직연금계좌에서 퇴직연금구분란은 퇴직연금(DC, IRP), 과학기술인공제회로 구분하여 적습니다.' ,left=93 ,top=2582 ,right=1953 ,bottom=2633 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' 작성하여야 합니다. 해당 계좌별로 불입금액과 소득,세액 공제금액을 적고, 공제금액이 0인 경우에는 적지 않습니다.' ,left=93 ,top=2532 ,right=1953 ,bottom=2582 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1. 연금계좌 세액공제, 주택마련저축·장기집합투자증권저축 소득공제를 받는 소득자에 대해서는 해당 소득, 세액공제에 대한 명세를' ,left=93 ,top=2482 ,right=1953 ,bottom=2532 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='※ 작성요령' ,left=93 ,top=2434 ,right=1953 ,bottom=2482 ,align='left'</T>
	<L> left=82 ,top=2424 ,right=1953 ,bottom=2424 </L>
	<T>id='소득공제금액' ,left=1654 ,top=2122 ,right=1953 ,bottom=2183</T>
	<T>id='납입금액' ,left=1352 ,top=2122 ,right=1654 ,bottom=2183</T>
	<T>id='계좌번호' ,left=945 ,top=2122 ,right=1344 ,bottom=2183</T>
	<T>id='금융회사 등' ,left=214 ,top=2122 ,right=786 ,bottom=2183</T>
	<T>id='     * 장기집합투자증권저축 소득공제에 대한 명세를 작성합니다.' ,left=93 ,top=2072 ,right=1153 ,bottom=2122 ,align='left'</T>
	<T>id='세액공제금액' ,left=1654 ,top=1664 ,right=1953 ,bottom=1722</T>
	<T>id='납입금액' ,left=1352 ,top=1664 ,right=1654 ,bottom=1722</T>
	<T>id='계좌번호' ,left=902 ,top=1664 ,right=1352 ,bottom=1722</T>
	<T>id='금융회사 등' ,left=352 ,top=1664 ,right=902 ,bottom=1722</T>
	<T>id='저축 구분' ,left=82 ,top=1664 ,right=352 ,bottom=1722</T>
	<T>id='     * 주택마련저축 소득공제에 대한 명세를 작성합니다.' ,left=93 ,top=1614 ,right=1053 ,bottom=1664 ,align='left'</T>
	<T>id='3. 주택마련저축 소득공제' ,left=103 ,top=1564 ,right=553 ,bottom=1614 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDAMT4_4,0,,DEDAMT4_4)}', left=1654, top=2363, right=1953, bottom=2424, align='right'</C>
	<C>id='{decode(PAYAMT4_4,0,,PAYAMT4_4)}', left=1352, top=2363, right=1654, bottom=2424, align='right'</C>
	<C>id='{decode(DEDAMT4_3,0,,DEDAMT4_3)}', left=1654, top=2302, right=1953, bottom=2363, align='right'</C>
	<C>id='{decode(PAYAMT4_3,0,,PAYAMT4_3)}', left=1352, top=2302, right=1654, bottom=2363, align='right'</C>
	<C>id='{decode(DEDAMT4_2,0,,DEDAMT4_2)}', left=1654, top=2244, right=1953, bottom=2302, align='right'</C>
	<C>id='{decode(PAYAMT4_2,0,,PAYAMT4_2)}', left=1352, top=2244, right=1654, bottom=2302, align='right'</C>
	<C>id='{decode(DEDAMT4_1,0,,DEDAMT4_1)}', left=1654, top=2183, right=1953, bottom=2244, align='right'</C>
	<C>id='{decode(PAYAMT4_1,0,,PAYAMT4_1)}', left=1352, top=2183, right=1654, bottom=2244, align='right'</C>
	<C>id='{decode(DEDAMT3_5,0,,DEDAMT3_5)}', left=1654, top=1963, right=1953, bottom=2024, align='right'</C>
	<C>id='{decode(PAYAMT3_5,0,,PAYAMT3_5)}', left=1352, top=1963, right=1654, bottom=2024, align='right'</C>
	<C>id='ACCNO3_5', left=902, top=1963, right=1352, bottom=2024</C>
	<C>id='FINANM3_5', left=352, top=1963, right=902, bottom=2024, align='left'</C>
	<C>id='DUDGBNM3_5', left=82, top=1963, right=352, bottom=2024</C>
	<C>id='{decode(DEDAMT3_4,0,,DEDAMT3_4)}', left=1654, top=1902, right=1953, bottom=1963, align='right'</C>
	<C>id='{decode(PAYAMT3_4,0,,PAYAMT3_4)}', left=1352, top=1902, right=1654, bottom=1963, align='right'</C>
	<C>id='ACCNO3_4', left=902, top=1902, right=1352, bottom=1963</C>
	<C>id='FINANM3_4', left=352, top=1902, right=902, bottom=1963, align='left'</C>
	<C>id='DUDGBNM3_4', left=82, top=1902, right=352, bottom=1963</C>
	<C>id='{decode(DEDAMT3_3,0,,DEDAMT3_3)}', left=1654, top=1844, right=1953, bottom=1902, align='right'</C>
	<C>id='{decode(PAYAMT3_3,0,,PAYAMT3_3)}', left=1352, top=1844, right=1654, bottom=1902, align='right'</C>
	<C>id='ACCNO3_3', left=902, top=1844, right=1352, bottom=1902</C>
	<C>id='FINANM3_3', left=352, top=1844, right=902, bottom=1902, align='left'</C>
	<C>id='DUDGBNM3_3', left=82, top=1844, right=352, bottom=1902</C>
	<C>id='{decode(DEDAMT3_2,0,,DEDAMT3_2)}', left=1654, top=1783, right=1953, bottom=1844, align='right'</C>
	<C>id='{decode(PAYAMT3_2,0,,PAYAMT3_2)}', left=1352, top=1783, right=1654, bottom=1844, align='right'</C>
	<C>id='ACCNO3_2', left=902, top=1783, right=1352, bottom=1844</C>
	<C>id='FINANM3_2', left=352, top=1783, right=902, bottom=1844, align='left'</C>
	<C>id='DUDGBNM3_2', left=82, top=1783, right=352, bottom=1844</C>
	<C>id='{decode(DEDAMT3_1,0,,DEDAMT3_1)}', left=1654, top=1722, right=1953, bottom=1783, align='right'</C>
	<C>id='{decode(PAYAMT3_1,0,,PAYAMT3_1)}', left=1352, top=1722, right=1654, bottom=1783, align='right'</C>
	<C>id='ACCNO3_1', left=902, top=1722, right=1352, bottom=1783</C>
	<C>id='FINANM3_1', left=352, top=1722, right=902, bottom=1783, align='left'</C>
	<C>id='DUDGBNM3_1', left=82, top=1722, right=352, bottom=1783</C>
	<C>id='{decode(DEDAMT2_5,0,,DEDAMT2_5)}', left=1654, top=1503, right=1953, bottom=1564, align='right'</C>
	<C>id='{decode(PAYAMT2_5,0,,PAYAMT2_5)}', left=1352, top=1503, right=1654, bottom=1564, align='right'</C>
	<C>id='ACCNO2_5', left=902, top=1503, right=1352, bottom=1564</C>
	<C>id='FINANM2_5', left=352, top=1503, right=902, bottom=1564, align='left'</C>
	<C>id='DUDGBNM2_5', left=82, top=1503, right=352, bottom=1564</C>
	<L> left=1654 ,top=2122 ,right=1654 ,bottom=2424 </L>
	<L> left=1654 ,top=1664 ,right=1654 ,bottom=2024 </L>
	<L> left=1352 ,top=2122 ,right=1352 ,bottom=2424 </L>
	<L> left=1352 ,top=1664 ,right=1352 ,bottom=2024 </L>
	<L> left=902 ,top=1664 ,right=902 ,bottom=2024 </L>
	<L> left=352 ,top=1664 ,right=352 ,bottom=2024 </L>
	<L> left=82 ,top=2363 ,right=1953 ,bottom=2363 </L>
	<L> left=82 ,top=2302 ,right=1953 ,bottom=2302 </L>
	<L> left=82 ,top=2244 ,right=1953 ,bottom=2244 </L>
	<L> left=82 ,top=2183 ,right=1953 ,bottom=2183 </L>
	<L> left=82 ,top=2122 ,right=1953 ,bottom=2122 </L>
	<L> left=82 ,top=2024 ,right=1953 ,bottom=2024 </L>
	<L> left=82 ,top=1963 ,right=1953 ,bottom=1963 </L>
	<L> left=82 ,top=1902 ,right=1953 ,bottom=1902 </L>
	<L> left=82 ,top=1844 ,right=1953 ,bottom=1844 </L>
	<L> left=82 ,top=1783 ,right=1953 ,bottom=1783 </L>
	<L> left=82 ,top=1722 ,right=1953 ,bottom=1722 </L>
	<L> left=82 ,top=1664 ,right=1953 ,bottom=1664 </L>
	<L> left=82 ,top=1564 ,right=1953 ,bottom=1564 </L>
	<T>id='세액공제금액' ,left=1654 ,top=1204 ,right=1953 ,bottom=1262</T>
	<T>id='납입금액' ,left=1352 ,top=1204 ,right=1654 ,bottom=1262</T>
	<T>id='계좌번호' ,left=902 ,top=1204 ,right=1352 ,bottom=1262</T>
	<T>id='금융회사 등' ,left=352 ,top=1204 ,right=902 ,bottom=1262</T>
	<T>id='연금저축구분' ,left=82 ,top=1204 ,right=352 ,bottom=1262</T>
	<T>id='     * 연금저축계좌에 대한 명세를 작성합니다.' ,left=93 ,top=1154 ,right=953 ,bottom=1204 ,align='left'</T>
	<T>id='2) 연금저축계좌' ,left=103 ,top=1103 ,right=452 ,bottom=1154 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='세액공제금액' ,left=1654 ,top=863 ,right=1953 ,bottom=923</T>
	<T>id='납입금액' ,left=1352 ,top=863 ,right=1654 ,bottom=923</T>
	<T>id='계좌번호' ,left=902 ,top=863 ,right=1352 ,bottom=923</T>
	<T>id='금융회사 등' ,left=352 ,top=863 ,right=902 ,bottom=923</T>
	<T>id='퇴직연금구분' ,left=82 ,top=863 ,right=352 ,bottom=923</T>
	<T>id='     * 퇴직연금계좌에 대한 명세를 작성합니다.' ,left=93 ,top=812 ,right=953 ,bottom=863 ,align='left'</T>
	<T>id='1) 퇴직연금계좌' ,left=103 ,top=762 ,right=452 ,bottom=812 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DEDAMT2_4,0,,DEDAMT2_4)}', left=1654, top=1442, right=1953, bottom=1503, align='right'</C>
	<C>id='{decode(PAYAMT2_4,0,,PAYAMT2_4)}', left=1352, top=1442, right=1654, bottom=1503, align='right'</C>
	<C>id='ACCNO2_4', left=902, top=1442, right=1352, bottom=1503</C>
	<C>id='FINANM2_4', left=352, top=1442, right=902, bottom=1503, align='left'</C>
	<C>id='DUDGBNM2_4', left=82, top=1442, right=352, bottom=1503</C>
	<C>id='{decode(DEDAMT2_3,0,,DEDAMT2_3)}', left=1654, top=1384, right=1953, bottom=1442, align='right'</C>
	<C>id='{decode(PAYAMT2_3,0,,PAYAMT2_3)}', left=1352, top=1384, right=1654, bottom=1442, align='right'</C>
	<C>id='ACCNO2_3', left=902, top=1384, right=1352, bottom=1442</C>
	<C>id='FINANM2_3', left=352, top=1384, right=902, bottom=1442, align='left'</C>
	<C>id='DUDGBNM2_3', left=82, top=1384, right=352, bottom=1442</C>
	<C>id='{decode(DEDAMT2_2,0,,DEDAMT2_2)}', left=1654, top=1323, right=1953, bottom=1384, align='right'</C>
	<C>id='{decode(PAYAMT2_2,0,,PAYAMT2_2)}', left=1352, top=1323, right=1654, bottom=1384, align='right'</C>
	<C>id='ACCNO2_2', left=902, top=1323, right=1352, bottom=1384</C>
	<C>id='FINANM2_2', left=352, top=1323, right=902, bottom=1384, align='left'</C>
	<C>id='DUDGBNM2_2', left=82, top=1323, right=352, bottom=1384</C>
	<C>id='{decode(DEDAMT2_1,0,,DEDAMT2_1)}', left=1654, top=1262, right=1953, bottom=1323, align='right'</C>
	<C>id='{decode(PAYAMT2_1,0,,PAYAMT2_1)}', left=1352, top=1262, right=1654, bottom=1323, align='right'</C>
	<C>id='ACCNO2_1', left=902, top=1262, right=1352, bottom=1323</C>
	<C>id='FINANM2_1', left=352, top=1262, right=902, bottom=1323, align='left'</C>
	<C>id='DUDGBNM2_1', left=82, top=1262, right=352, bottom=1323</C>
	<C>id='{decode(DEDAMT1_3,0,,DEDAMT1_3)}', left=1654, top=1042, right=1953, bottom=1103, align='right'</C>
	<C>id='{decode(PAYAMT1_3,0,,PAYAMT1_3)}', left=1352, top=1042, right=1654, bottom=1103, align='right'</C>
	<C>id='ACCNO1_3', left=902, top=1042, right=1352, bottom=1103</C>
	<C>id='FINANM1_3', left=352, top=1042, right=902, bottom=1103, align='left'</C>
	<C>id='DUDGBNM1_3', left=82, top=1042, right=352, bottom=1103</C>
	<C>id='{decode(DEDAMT1_2,0,,DEDAMT1_2)}', left=1654, top=982, right=1953, bottom=1042, align='right'</C>
	<C>id='{decode(PAYAMT1_2,0,,PAYAMT1_2)}', left=1352, top=982, right=1654, bottom=1042, align='right'</C>
	<C>id='ACCNO1_2', left=902, top=982, right=1352, bottom=1042</C>
	<C>id='FINANM1_2', left=352, top=982, right=902, bottom=1042, align='left'</C>
	<C>id='DUDGBNM1_2', left=82, top=982, right=352, bottom=1042</C>
	<C>id='{decode(DEDAMT1_1,0,,DEDAMT1_1)}', left=1654, top=923, right=1953, bottom=982, align='right'</C>
	<C>id='{decode(PAYAMT1_1,0,,PAYAMT1_1)}', left=1352, top=923, right=1654, bottom=982, align='right'</C>
	<C>id='ACCNO1_1', left=902, top=923, right=1352, bottom=982</C>
	<C>id='FINANM1_1', left=352, top=923, right=902, bottom=982, align='left'</C>
	<C>id='DUDGBNM1_1', left=82, top=923, right=352, bottom=982</C>
	<L> left=902 ,top=863 ,right=902 ,bottom=1103 </L>
	<L> left=352 ,top=863 ,right=352 ,bottom=1103 </L>
	<L> left=82 ,top=1503 ,right=1953 ,bottom=1503 </L>
	<L> left=82 ,top=1442 ,right=1953 ,bottom=1442 </L>
	<L> left=82 ,top=1384 ,right=1953 ,bottom=1384 </L>
	<L> left=82 ,top=1323 ,right=1953 ,bottom=1323 </L>
	<L> left=82 ,top=1262 ,right=1953 ,bottom=1262 </L>
	<L> left=82 ,top=1204 ,right=1953 ,bottom=1204 </L>
	<L> left=82 ,top=1103 ,right=1953 ,bottom=1103 </L>
	<L> left=82 ,top=1042 ,right=1953 ,bottom=1042 </L>
	<L> left=82 ,top=982 ,right=1953 ,bottom=982 </L>
	<L> left=82 ,top=923 ,right=1953 ,bottom=923 </L>
	<L> left=82 ,top=863 ,right=1953 ,bottom=863 </L>
	<L> left=1352 ,top=1204 ,right=1352 ,bottom=1564 </L>
	<T>id='⑤주            소' ,left=82 ,top=511 ,right=352 ,bottom=590 ,align='left'</T>
	<T>id='(전화번호:' ,left=1453 ,top=511 ,right=1622 ,bottom=590 ,align='left'</T>
	<C>id='TELNO', left=1617, top=511, right=1905, bottom=590, align='left'</C>
	<T>id=')' ,left=1892 ,top=511 ,right=1924 ,bottom=590 ,align='left'</T>
	<L> left=82 ,top=593 ,right=1953 ,bottom=593 </L>
	<T>id='⑥사업장소재지' ,left=82 ,top=593 ,right=352 ,bottom=675 ,align='left'</T>
	<T>id=' 서울 종로구 연지동 1-7 현대그룹빌딩' ,left=360 ,top=601 ,right=1003 ,bottom=669 ,align='left'</T>
	<L> left=82 ,top=675 ,right=1953 ,bottom=675 </L>
	<T>id='( 전화번호:02-3669-3700    )' ,left=1463 ,top=601 ,right=1945 ,bottom=667 ,align='left'</T>
	<L> left=352 ,top=349 ,right=352 ,bottom=677 </L>
	<T>id='2. 연금계좌 세액공제' ,left=90 ,top=683 ,right=781 ,bottom=749 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4. 장기집합투자증권저축 소득공제' ,left=103 ,top=2024 ,right=815 ,bottom=2072 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1352 ,top=863 ,right=1352 ,bottom=1101 </L>
	<C>id='ADDRESS', left=362, top=516, right=1447, bottom=590, align='left'</C>
	<L> left=1654 ,top=863 ,right=1654 ,bottom=1103 </L>
	<C>id='EMPJUNO', left=1318, top=439, right=1926, bottom=503</C>
	<T>id='연금 · 저축 등 소득·세액공제 명세서' ,left=82 ,top=135 ,right=1953 ,bottom=238 ,face='맑은 고딕' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=902 ,top=2122 ,right=902 ,bottom=2424 </L>
	<C>id='FINANM4_2', left=82, top=2244, right=897, bottom=2302</C>
	<C>id='FINANM4_4', left=82, top=2363, right=897, bottom=2424</C>
	<C>id='FINANM4_3', left=82, top=2302, right=897, bottom=2363</C>
	<C>id='FINANM4_1', left=82, top=2183, right=897, bottom=2244</C>
	<C>id='ACCNO4_1', left=913, top=2183, right=1344, bottom=2244</C>
	<C>id='ACCNO4_2', left=913, top=2244, right=1344, bottom=2302</C>
	<C>id='ACCNO4_3', left=915, top=2302, right=1344, bottom=2363</C>
	<C>id='ACCNO4_4', left=915, top=2363, right=1344, bottom=2424</C>
	<L> left=352 ,top=1204 ,right=352 ,bottom=1564 </L>
	<L> left=1654 ,top=1204 ,right=1654 ,bottom=1564 </L>
	<L> left=902 ,top=1204 ,right=902 ,bottom=1564 </L>
</B>


</R>
</A>


























">
</OBJECT>




<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<object id="bndT_AC_RETACC"
	classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID" ,   Value="dsT_AC_RETACC">
	<Param Name="BindInfo"
		, Value='
        <C>Col=DFM_CNT          Ctrl=txtDFM_CNT             Param=value     </C>
        <C>Col=GOL_CNT70        Ctrl=txtGOL_CNT70           Param=value     </C>
        <C>Col=GOL_CNT65        Ctrl=txtGOL_CNT65           Param=value     </C>
        <C>Col=TRB_CNT          Ctrl=txtTRB_CNT             Param=value     </C>
        <C>Col=RCH_CNT          Ctrl=txtRCH_CNT             Param=value     </C>
        <C>Col=CHI_CNT          Ctrl=txtCHI_CNT             Param=value     </C>
        <C>Col=INP_CNT          Ctrl=txtINP_CNT             Param=value     </C>
        <C>Col=INP_AMT          	Ctrl=txtINP_AMT             		Param=text      </C>        
        <C>Col=NPEN_AMT         Ctrl=txtNPEN_AMT            Param=text      </C>
        <C>Col=EPEN_AMT         Ctrl=txtEPEN_AMT            Param=text      </C>
        <C>Col=HINU_AMT         Ctrl=txtHINU_AMT            Param=text      </C>
        <C>Col=HINS_AMT         Ctrl=txtHINS_AMT            Param=text      </C>
        <C>Col=LIN_AMT          Ctrl=txtLIN_AMT             Param=text      </C>
        <C>Col=LIH_AMT          Ctrl=txtLIH_AMT             Param=text      </C>
        
        <C>Col=MHEA_AMT         Ctrl=txtMHEA_AMT            Param=text      </C>
        <C>Col=OHEA_AMT         Ctrl=txtOHEA_AMT            Param=text      </C>
        <C>Col=LF2_AMT          Ctrl=txtLF2_AMT             Param=text      </C>
        
        <C>Col=LEN_AMT          Ctrl=txtLEN_AMT             Param=text      </C>
        <C>Col=LEN_AMT2         Ctrl=txtLEN_AMT2            Param=text      </C>
        <C>Col=LEN_AMT3         Ctrl=txtLEN_AMT3            Param=text      </C>
        <C>Col=LEN_AMT4         Ctrl=txtLEN_AMT4            Param=text      </C>
        <C>Col=LEN_AMT5         Ctrl=txtLEN_AMT5            Param=text      </C>
        <C>Col=GRA_AMT          Ctrl=txtGRA_AMT             Param=text      </C>
        <C>Col=EDU_TAG1         Ctrl=cmbEDU_TAG1            Param=value     </C>
        <C>Col=EDU_TAG2         Ctrl=cmbEDU_TAG2            Param=value      </C>
        <C>Col=EDU_TAG3         Ctrl=cmbEDU_TAG3            Param=value      </C>
        <C>Col=EDU_TAG4         Ctrl=cmbEDU_TAG4            Param=value      </C>
        <C>Col=EDU_TAG5         Ctrl=cmbEDU_TAG5            Param=value      </C>
        <C>Col=EDU_AMT1         Ctrl=txtEDU_AMT1            Param=text      </C>
        <C>Col=EDU_AMT2         Ctrl=txtEDU_AMT2            Param=text      </C>
        <C>Col=EDU_AMT3         Ctrl=txtEDU_AMT3            Param=text      </C>
        <C>Col=EDU_AMT4         Ctrl=txtEDU_AMT4            Param=text      </C>
        <C>Col=EDU_AMT5         Ctrl=txtEDU_AMT5            Param=text      </C>
        <C>Col=HED_AMT          Ctrl=txtHED_AMT             Param=text      </C>
        
        <C>Col=LHO_AMT          Ctrl=txtLHO_AMT             Param=text      </C>
        <C>Col=LHP_AMT          Ctrl=txtLHP_AMT             Param=text      </C>
        <C>Col=LHQ_AMT          Ctrl=txtLHQ_AMT             Param=text      </C>
        <C>Col=LHR_AMT          Ctrl=txtLHR_AMT             Param=text      </C>
        
        <C>Col=LH1_AMT          Ctrl=txtLH1_AMT             Param=text      </C>
        <C>Col=LH2_AMT          Ctrl=txtLH2_AMT             Param=text      </C>
        <C>Col=LH2_AMT04       Ctrl=txtLH2_AMT04         Param=text      </C>        
        <C>Col=LH4_AMT          Ctrl=txtLH4_AMT             Param=text      </C>
        <C>Col=LH5_AMT          Ctrl=txtLH5_AMT             Param=text      </C>
        <C>Col=LH6_AMT          Ctrl=txtLH6_AMT             Param=text      </C>
        <C>Col=LH7_AMT          Ctrl=txtLH7_AMT             Param=text      </C>
        <C>Col=LH8_AMT          Ctrl=txtLH8_AMT             Param=text      </C>        

        <C>Col=GOV_AMT          	Ctrl=txtGOV_AMT             	Param=text      </C>
        <C>Col=LC1_AMT          	Ctrl=txtLC1_AMT             		Param=text      </C>
        <C>Col=LC2_AMT          	Ctrl=txtLC2_AMT             		Param=text      </C>
        <C>Col=LC3_AMT          	Ctrl=txtLC3_AMT            	 	Param=text      </C>
        <C>Col=LC4_AMT          	Ctrl=txtLC4_AMT             		Param=text      </C>                

        <C>Col=GOV_NTS          	Ctrl=txtGOV_NTS             		Param=text      </C>
        <C>Col=LC1_NTS          	Ctrl=txtLC1_NTS             		Param=text      </C>
        <C>Col=LC2_NTS          	Ctrl=txtLC2_NTS             		Param=text      </C>
        <C>Col=LC3_NTS          	Ctrl=txtLC3_NTS             		Param=text      </C>        
        <C>Col=GOV_DED          	Ctrl=txtGOV_DED             		Param=text      </C>

        <C>Col=FUN_CNT          	Ctrl=txtFUN_CNT             		Param=value     </C>
        <C>Col=LF1_AMT          	Ctrl=txtLF1_AMT             		Param=text      </C>
        <C>Col=VEN2_AMT         	Ctrl=txtVEN2_AMT            	Param=text      </C>
        
        <C>Col=CARD_AMT         	Ctrl=txtCARD_AMT            	Param=text      </C>
        <C>Col=DIR_CARD_AMT    	Ctrl=txtDIR_CARD_AMT        	Param=text      </C>
        <C>Col=CASH_AMT         	Ctrl=txtCASH_AMT            	Param=text      </C>
        <C>Col=MARKET_AMT      	Ctrl=txtMARKET_AMT        	Param=text      </C>   
        <C>Col=PUBLIC_AMT         Ctrl=txtPUBLIC_AMT            	Param=text      </C>
           
        <C>Col=LST_AMT          	Ctrl=txtLST_AMT             		Param=text      </C>

        <C>Col=PAYO_SUM         	Ctrl=txtPAYO_SUM            	Param=text      </C>
        <C>Col=LSQ_AMT          	Ctrl=txtLSQ_AMT             		Param=text      </C>

        <C>Col=WEL_CARD         	Ctrl=txtWEL_CARD            	Param=text      </C>
        <C>Col=CLS_TAG         		Ctrl=chkCLS_TAG            		Param=value     </C>

        <C>Col=SALT_AMT        		Ctrl=txtSALT_AMT           		Param=text      </C>
        <C>Col=FREE_INCOME       	Ctrl=txtFREE_INCOME          	Param=text      </C>        
        <C>Col=TAX_INCOME       		Ctrl=txtTAX_INCOME          	Param=text      </C>
        <C>Col=INCM_TAX        		Ctrl=txtINCM_TAX           		Param=text      </C>
        <C>Col=CITI_TAX     			Ctrl=txtCITI_TAX        			Param=text      </C>
        <C>Col=OLD_MED_AMT      	Ctrl=txtOLD_MED_AMT         	Param=text      </C>
        <C>Col=OLD_AMT          		Ctrl=txtOLD_AMT             		Param=text      </C>
        '>
</object>


<object id="bndT_CM_PERSON"
	classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID" ,   Value="dsT_CM_PERSON">
	<Param Name="BindInfo"
		, Value='
        <C>Col=OCC_NM          Ctrl=txtOCC_NM             Param=value     </C>
        <C>Col=DPT_NM          Ctrl=txtDPT_NM             Param=value     </C>
        <C>Col=JOB_NM          Ctrl=txtJOB_NM             Param=value     </C>
        <C>Col=CET_NO          Ctrl=txtCET_NO             Param=value     </C>
        <C>Col=ZIP_NO          Ctrl=txtZIP_NO             Param=value     </C>
        <C>Col=ADDRESS         Ctrl=txtADDRESS            Param=value     </C>
        <C>Col=ADR_CT          Ctrl=txtADR_CT             Param=value     </C>
        <C>Col=ENO_NO          Ctrl=txtENO_NO             Param=value     </C>
        <C>Col=HEAD_CD         Ctrl=txtHEAD_CD            Param=value     </C>
        <C>Col=DPT_CD          Ctrl=txtDPT_CD             Param=value     </C>
    '>
</object>