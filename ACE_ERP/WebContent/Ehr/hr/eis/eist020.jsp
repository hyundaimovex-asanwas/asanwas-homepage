<!--
***********************************************************************
* @source      : eist020.jsp
* @description : 타임시트 승인 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2017/01/04            이동훈            	ERP이사						
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>타임시트 승인</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >


        var today = gcurdate;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList(e) {

			var pis_ym = (document.getElementById("txtPIS_YM_SHR").value).replace(/-/g, "");
			var team_cd = document.getElementById('txtTEAM_CD_SHR').value;			
			var eno_no = document.getElementById('txtENO_NO_SHR').value;
			var sts_shr = document.getElementById("cmbTS_STS_SHR").value;
			//alert(ActiveIndex);
			
			if(e == "1" || ActiveIndex == "1"){

				dsT_TS_DAY.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=SHR_DAY&PIS_YM="+pis_ym+"&TEAM_CD="+team_cd+"&ENO_NO="+eno_no+"&STS="+sts_shr;

				dsT_TS_DAY.reset();
   		
			}else if(e == "2" || ActiveIndex == "2"){
				
				dsT_TS_PROJECT.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=SHR_PJT&PIS_YM="+pis_ym+"&TEAM_CD="+team_cd+"&ENO_NO="+eno_no+"&STS="+sts_shr;

				dsT_TS_PROJECT.reset();				
				
			}else if(e == "3" || ActiveIndex == "3"){
				
				dsT_TS_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=SHR_PER&PIS_YM="+pis_ym+"&TEAM_CD="+team_cd+"&ENO_NO="+eno_no+"&STS="+sts_shr;

				dsT_TS_PERSON.reset();				
				
			}

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {



        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {


        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

			if(ActiveIndex == "1"){
				
				//이곳에 해당 코딩을 입력 하세요
	            if (dsT_TS_DAY.CountRow < 1) {
	                alert("엑셀로 변환할 자료가 없습니다!");
	                return;
	            }
	
	            form1.grdT_TS_DAY.GridToExcel("일자별", '', 225);
				
			}
			
			if(ActiveIndex == "2"){
				
				//이곳에 해당 코딩을 입력 하세요
	            if (dsT_TS_PROJECT.CountRow < 1) {
	                alert("엑셀로 변환할 자료가 없습니다!");
	                return;
	            }
	
	            form1.grdT_TS_PROJECT.GridToExcel("프로젝트별", '', 225);
				
			}			
			
			if(ActiveIndex == "3"){
				
				//이곳에 해당 코딩을 입력 하세요
	            if (dsT_TS_PERSON.CountRow < 1) {
	                alert("엑셀로 변환할 자료가 없습니다!");
	                return;
	            }
	
	            form1.grdT_TS_PERSON.GridToExcel("직원별", '', 225);
				
			}			
			
			
        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {


        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {



        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {


        	window.close();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

        	
        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {


        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById('txtPIS_YM_SHR').value = today.substring(0,7);

            dsT_CM_TEAM.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=SHR_TEAM&ENO_NO="+gusrid;
            dsT_CM_TEAM.reset();            
            
            document.getElementById("txtTEAM_CD_SHR").value = dsT_CM_TEAM.NameValue(1,"TEAM_CD");   
            document.getElementById("txtTEAM_NM_SHR").value = dsT_CM_TEAM.NameValue(1,"TEAM_NM");          
            
            //document.getElementById("txtENO_NO_SHR").value = gusrid;
            //document.getElementById("txtENO_NM_SHR").value = gusrnm;            
            
            //관리자, IT + 김효중, 김인호
            if(gusrid != "6060002" && gusrid != "6070001" && gusrid != "6050006" && gusrid != "2020009" && gusrid != "2080044"){ 

	         	fnc_ChangeStateElement(false, "txtTEAM_CD_SHR");
	         	fnc_ChangeStateElement(false, "txtTEAM_NM_SHR");
	         	fnc_ChangeStateElement(false, "ImgTeam");            	
            	
	         	//fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	         	//fnc_ChangeStateElement(false, "txtENO_NM_SHR");
	         	//fnc_ChangeStateElement(false, "ImgEnoNo");

			  }            

			cfStyleGrid_New(form1.grdT_TS_DAY,15,"true","true");      		// Grid Style 적용
			cfStyleGrid_New(form1.grdT_TS_PROJECT,15,"true","true");      	// Grid Style 적용
			cfStyleGrid_New(form1.grdT_TS_PERSON,15,"true","true");      	// Grid Style 적용			
        
			document.getElementById("divEIST020_01").style.display = "";
			document.getElementById("divEIST020_02").style.display = "none";
			document.getElementById("divEIST020_03").style.display = "none";        
        
        
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		
        /*************************
         * 16. 그리드 변경 처리  *
         ************************/
		function fnc_ChangeGrid(kind) {

			if(kind == '1'){

					document.getElementById("divEIST020_01").style.display = "";
					document.getElementById("divEIST020_02").style.display = "none";
					document.getElementById("divEIST020_03").style.display = "none";

					fnc_SearchList('1');					
					
            }else if(kind == '2'){

					document.getElementById("divEIST020_01").style.display = "none";
					document.getElementById("divEIST020_02").style.display = "";
					document.getElementById("divEIST020_03").style.display = "none";

					fnc_SearchList('2');
					
            }else if(kind == '3'){
         	
					document.getElementById("divEIST020_01").style.display = "none";
					document.getElementById("divEIST020_02").style.display = "none";
					document.getElementById("divEIST020_03").style.display = "";

					fnc_SearchList('3');					
            }

		}		
		
        /********************************
         * 17. 탭버튼 클릭에 따른 처리  *
         *******************************/

        /**
         * 해당 레이어 보여주고 닫기
         * @param 클릭한 layer idx
         */
        function TabEvent(idx) {
        	
            ActiveIndex = idx+1;

            //Tab 이미지 보여주고 닫기 (문서 권한에 따라 보여주는것과 아닌것이 달라짐)
            for(var i=1; i<=3; i++) {
                if(document.getElementById("TabBtn0"+i) == undefined) {
                    continue;
                }

                document.getElementById("TabLeft0"+i).src = "../../images/common/tabGray25Left.gif";
                document.getElementById("TabBtn0"+i).className = "hiddenMenu25";
                document.getElementById("TabRight0"+i).src = "../../images/common/tabGray25Right.gif";
            }

            document.getElementById("TabLeft0"+ActiveIndex).src = "../../images/common/tab25Left.gif";
            document.getElementById("TabBtn0"+ActiveIndex).className = "overMenu25";
            document.getElementById("TabRight0"+ActiveIndex).src = "../../images/common/tab25Right.gif";
            
            //fnc_TabOnClick(ActiveIndex);
            
            fnc_ChangeGrid(ActiveIndex);
        }        
		
		
		
        /********************************
         * 18. 승인/반려 처리                 *
         *******************************/        

         function fnc_YES() {
				
             if (!confirm("승인하시겠습니까?")){
 	            
             	return;
             	
             }else{

	 			var pis_ym = (document.getElementById("txtPIS_YM_SHR").value).replace(/-/g, "");
				var team_cd = document.getElementById('txtTEAM_CD_SHR').value;		 			
	 			var eno_no = document.getElementById('txtENO_NO_SHR').value;			

 				if(document.getElementById("divEIST020_01").style.display == "") {

  		            for(var i=1; i<=dsT_TS_DAY.CountRow; i++) {
 					
  		            	if(dsT_TS_DAY.NameValue(i, "STATUS") != "상신"){
 		            		
  		            		alert("상신 상태가 아닌 행이 존재합니다.");
  		            		return false;
  		            	}

  						dsT_TS_DAY.UserStatus(i) = 1; //결재 갱신을 위한 설정
					
  		            }

  		 			dsT_TS_DAY_02.setDataHeader("ENO_NO:STRING(7)");

 		            var count = 1;
 		            var aaa = 1;
 		            
  		            for(var i=1; i<dsT_TS_DAY.CountRow; i++) {
 	 					
  		            	if(dsT_TS_DAY.NameValue(i, "ENO_NO") == dsT_TS_DAY.NameValue(i+1, "ENO_NO")){
 		            		
  		            		//alert("같은 사람");
  		            		if(i == "1"){
  		            			
  		            			dsT_TS_DAY_02.addrow();
 	            				dsT_TS_DAY_02.NameValue(dsT_TS_DAY_02.RowPosition,"ENO_NO") = dsT_TS_DAY.NameValue(i,"ENO_NO");
 	            				
  		            		}

  		            	}else{

  	 		            	//다른 사람
 	            			for(var j=1; j<=count; j++) {
 		            		
 		            			if(dsT_TS_DAY.NameValue(i+1, "ENO_NO") == dsT_TS_DAY_02.NameValue(j, "ENO_NO")){

 		            				aaa = aaa + 1;

 		            			}else{


 		            			}

 	            			}
  	 		            	
 	            			if(aaa == 1){
 	            				
 	            				dsT_TS_DAY_02.addrow();
 	            				dsT_TS_DAY_02.NameValue(dsT_TS_DAY_02.RowPosition,"ENO_NO") = dsT_TS_DAY.NameValue(i+1,"ENO_NO");
 	            				aaa = 1;
 	            			}

 	            			count = count + 1;

  		            	}

  		            }
           
  		            //prompt(this,dsT_TS_DAY_02.text);
  		            
  					trT_TS_DAY.KeyValue = "tr01(I:dsT_TS_DAY_02=dsT_TS_DAY_02)";
  					trT_TS_DAY.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=UPT_DAY"
  																								            + "&PIS_YM="+pis_ym
  																								            + "&TEAM_CD="+team_cd
  																								            + "&ENO_NO="+eno_no
  																								            + "&STATUS=Y";																							            
  					trT_TS_DAY.post();	
	
 		 			fnc_SearchList('1');
					

 				}else if(document.getElementById("divEIST020_02").style.display == "") {
 					
 		            for(var i=1; i<=dsT_TS_PROJECT.CountRow; i++) {
 	 					
 		            	if(dsT_TS_PROJECT.NameValue(i, "STATUS") != "상신"){
 		            		
 		            		alert("상신 상태가 아닌 행이 존재합니다.");
 		            		return false;
 		            	} 		            	
 		            	
 		            	dsT_TS_PROJECT.UserStatus(i) = 1; //결재 갱신을 위한 설정		
					
 		            } 					
 					
 		            
 		            dsT_TS_PROJECT_02.setDataHeader("ENO_NO:STRING(7)");

 		            var count = 1;
 		            var aaa = 1;
 		            
  		            for(var i=1; i<dsT_TS_PROJECT.CountRow; i++) {
 	 					
  		            	if(dsT_TS_PROJECT.NameValue(i, "ENO_NO") == dsT_TS_PROJECT.NameValue(i+1, "ENO_NO")){
 		            		
  		            		//alert("같은 사람");
  		            		if(i == "1"){
  		            			
  		            			dsT_TS_PROJECT_02.addrow();
  		            			dsT_TS_PROJECT_02.NameValue(dsT_TS_PROJECT_02.RowPosition,"ENO_NO") = dsT_TS_PROJECT.NameValue(i,"ENO_NO");
 	            				
  		            		}
  		            		
  		            		
  		            	}else{

  	 		            	//다른 사람
 	            			for(var j=1; j<=count; j++) {
 		            		
 		            			if(dsT_TS_PROJECT.NameValue(i+1, "ENO_NO") == dsT_TS_PROJECT_02.NameValue(j, "ENO_NO")){

 		            				aaa = aaa + 1;

 		            			}else{


 		            			}

 	            			}
  	 		            	
 	            			if(aaa == 1){
 	            				
 	            				dsT_TS_PROJECT_02.addrow();
 	            				dsT_TS_PROJECT_02.NameValue(dsT_TS_PROJECT_02.RowPosition,"ENO_NO") = dsT_TS_PROJECT.NameValue(i+1,"ENO_NO");
 	            				aaa = 1;
 	            			}

 	            			count = count + 1;

  		            	}

  		            } 		            
 		            
 		            
 		            
					trT_TS_PROJECT.KeyValue = "tr01(I:dsT_TS_PROJECT_02=dsT_TS_PROJECT_02)";

					trT_TS_PROJECT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=UPT_PJT"
																							            + "&PIS_YM="+pis_ym
																							            + "&TEAM_CD="+team_cd																							            
																							            + "&ENO_NO="+eno_no
																							            + "&STATUS=Y";							

					trT_TS_PROJECT.post(); 					

		 			fnc_SearchList('2');
		 			
 				}else if(document.getElementById("divEIST020_03").style.display == "") {
 					
 		            for(var i=1; i<=dsT_TS_PERSON.CountRow; i++) {
 	 					
 		            	if(dsT_TS_PERSON.NameValue(i, "STATUS") != "상신"){
 		            		
 		            		alert("상신 상태가 아닌 행이 존재합니다.");
 		            		return false;
 		            	} 	 		            	
 		            	
 		            	dsT_TS_PERSON.UserStatus(i) = 1; //결재 갱신을 위한 설정		
					
 		            } 	 					

 		            
 		            
 		            dsT_TS_PERSON_02.setDataHeader("ENO_NO:STRING(7)");

 		            var count = 1;
 		            var aaa = 1;
 		            
  		            for(var i=1; i<dsT_TS_PERSON.CountRow; i++) {
 	 					
  		            	if(dsT_TS_PERSON.NameValue(i, "ENO_NO") == dsT_TS_PERSON.NameValue(i+1, "ENO_NO")){
 		            		
  		            		//alert("같은 사람");
  		            		if(i == "1"){
  		            			
  		            			dsT_TS_PERSON_02.addrow();
  		            			dsT_TS_PERSON_02.NameValue(dsT_TS_PERSON_02.RowPosition,"ENO_NO") = dsT_TS_PERSON.NameValue(i,"ENO_NO");
 	            				
  		            		}
  		            		
  		            	}else{

  	 		            	//다른 사람
 	            			for(var j=1; j<=count; j++) {
 		            		
 		            			if(dsT_TS_PERSON.NameValue(i+1, "ENO_NO") == dsT_TS_PERSON_02.NameValue(j, "ENO_NO")){

 		            				aaa = aaa + 1;

 		            			}else{


 		            			}

 	            			}
  	 		            	
 	            			if(aaa == 1){
 	            				
 	            				dsT_TS_PERSON_02.addrow();
 	            				dsT_TS_PERSON_02.NameValue(dsT_TS_PERSON_02.RowPosition,"ENO_NO") = dsT_TS_PERSON.NameValue(i+1,"ENO_NO");
 	            				aaa = 1;
 	            			}

 	            			count = count + 1;

  		            	}

  		            } 		 		            
 		            
					trT_TS_PERSON.KeyValue = "tr01(I:dsT_TS_PERSON_02=dsT_TS_PERSON_02)";

					trT_TS_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=UPT_PER"
																							            + "&PIS_YM="+pis_ym
																							            + "&TEAM_CD="+team_cd																							            
																							            + "&ENO_NO="+eno_no
																							            + "&STATUS=Y";	
					trT_TS_PERSON.post(); 		 					

		 			fnc_SearchList('3');					
 				}

             }
             
         }        
        
        
         function fnc_NO() {
          	
             if (!confirm("반려하시겠습니까?")){
  	            
              	return;
              	
              }else{
              	
	  			var pis_ym = (document.getElementById("txtPIS_YM_SHR").value).replace(/-/g, "");
				var team_cd = document.getElementById('txtTEAM_CD_SHR').value;	  			
	  			var eno_no = document.getElementById('txtENO_NO_SHR').value;			
	  			

				if(document.getElementById("divEIST020_01").style.display == "") {

 		            for(var i=1; i<=dsT_TS_DAY.CountRow; i++) {
 					
 		            	if(dsT_TS_DAY.NameValue(i, "STATUS") != "상신"){

 		            		alert("상신 상태가 아닌 행이 존재합니다.");
 		            		return false;
 		            	}

 		            	dsT_TS_DAY.UserStatus(i) = 1; //결재 갱신을 위한 설정	
 		            	
 		            }
 		            
 		            
  		 			dsT_TS_DAY_02.setDataHeader("ENO_NO:STRING(7)");

 		            var count = 1;
 		            var aaa = 1;
 		            
  		            for(var i=1; i<dsT_TS_DAY.CountRow; i++) {
 	 					
  		            	if(dsT_TS_DAY.NameValue(i, "ENO_NO") == dsT_TS_DAY.NameValue(i+1, "ENO_NO")){
 		            		
  		            		//alert("같은 사람");
  		            		if(i == "1"){
  		            			
  		            			dsT_TS_DAY_02.addrow();
 	            				dsT_TS_DAY_02.NameValue(dsT_TS_DAY_02.RowPosition,"ENO_NO") = dsT_TS_DAY.NameValue(i,"ENO_NO");
 	            				
  		            		}
  		            		
  		            		
  		            	}else{

  	 		            	//다른 사람
 	            			for(var j=1; j<=count; j++) {
 		            		
 		            			if(dsT_TS_DAY.NameValue(i+1, "ENO_NO") == dsT_TS_DAY_02.NameValue(j, "ENO_NO")){

 		            				aaa = aaa + 1;

 		            			}else{


 		            			}

 	            			}
  	 		            	
 	            			if(aaa == 1){
 	            				
 	            				dsT_TS_DAY_02.addrow();
 	            				dsT_TS_DAY_02.NameValue(dsT_TS_DAY_02.RowPosition,"ENO_NO") = dsT_TS_DAY.NameValue(i+1,"ENO_NO");
 	            				aaa = 1;
 	            			}

 	            			count = count + 1;

  		            	}

  		            } 		            
 		            
 		            
						trT_TS_DAY.KeyValue = "tr01(I:dsT_TS_DAY_02=dsT_TS_DAY_02)";

						trT_TS_DAY.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=UPT_DAY"
																								            + "&PIS_YM="+pis_ym
																								            + "&TEAM_CD="+team_cd
																								            + "&ENO_NO="+eno_no
																								            + "&STATUS=S";																							            
						//prompt(this, dsT_TS_DAY.text);
						trT_TS_DAY.post();	
              
			 			fnc_SearchList('1'); 		            
 		            
				}else if(document.getElementById("divEIST020_02").style.display == "") {
 					
 		            for(var i=1; i<=dsT_TS_PROJECT.CountRow; i++) {
 	 					
 		            	if(dsT_TS_PROJECT.NameValue(i, "STATUS") != "상신"){
 		            		
 		            		alert("상신 상태가 아닌 행이 존재합니다.");
 		            		return false;
 		            	} 		            	
 		            	
 		            	dsT_TS_PROJECT.UserStatus(i) = 1; //결재 갱신을 위한 설정		
					
 		            } 					
 					
 		            
 		            dsT_TS_PROJECT_02.setDataHeader("ENO_NO:STRING(7)");

 		            var count = 1;
 		            var aaa = 1;
 		            
  		            for(var i=1; i<dsT_TS_PROJECT.CountRow; i++) {
 	 					
  		            	if(dsT_TS_PROJECT.NameValue(i, "ENO_NO") == dsT_TS_PROJECT.NameValue(i+1, "ENO_NO")){
 		            		
  		            		//alert("같은 사람");
  		            		if(i == "1"){
  		            			
  		            			dsT_TS_PROJECT_02.addrow();
  		            			dsT_TS_PROJECT_02.NameValue(dsT_TS_PROJECT_02.RowPosition,"ENO_NO") = dsT_TS_PROJECT.NameValue(i,"ENO_NO");
 	            				
  		            		}
  		            		
  		            		
  		            	}else{

  	 		            	//다른 사람
 	            			for(var j=1; j<=count; j++) {
 		            		
 		            			if(dsT_TS_PROJECT.NameValue(i+1, "ENO_NO") == dsT_TS_PROJECT_02.NameValue(j, "ENO_NO")){

 		            				aaa = aaa + 1;

 		            			}else{


 		            			}

 	            			}
  	 		            	
 	            			if(aaa == 1){
 	            				
 	            				dsT_TS_PROJECT_02.addrow();
 	            				dsT_TS_PROJECT_02.NameValue(dsT_TS_PROJECT_02.RowPosition,"ENO_NO") = dsT_TS_PROJECT.NameValue(i+1,"ENO_NO");
 	            				aaa = 1;
 	            			}

 	            			count = count + 1;

  		            	}

  		            } 	 		            
 		            
					trT_TS_PROJECT.KeyValue = "tr01(I:dsT_TS_PROJECT_02=dsT_TS_PROJECT_02)";

					trT_TS_PROJECT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=UPT_PJT"
																							            + "&PIS_YM="+pis_ym
																							            + "&TEAM_CD="+team_cd																							            
																							            + "&ENO_NO="+eno_no
																							            + "&STATUS=S";							

					trT_TS_PROJECT.post(); 					

		 			fnc_SearchList('2');					
					
 				}else if(document.getElementById("divEIST020_03").style.display == "") {
 					
 		            for(var i=1; i<=dsT_TS_PERSON.CountRow; i++) {
 	 					
 		            	if(dsT_TS_PERSON.NameValue(i, "STATUS") != "상신"){
 		            		
 		            		alert("상신 상태가 아닌 행이 존재합니다.");
 		            		return false;
 		            	} 	 		            	
 		            	
 		            	dsT_TS_PERSON.UserStatus(i) = 1; //결재 갱신을 위한 설정		
					
 		            } 	 					

 		            
 		            dsT_TS_PERSON_02.setDataHeader("ENO_NO:STRING(7)");

 		            var count = 1;
 		            var aaa = 1;
 		            
  		            for(var i=1; i<dsT_TS_PERSON.CountRow; i++) {
 	 					
  		            	if(dsT_TS_PERSON.NameValue(i, "ENO_NO") == dsT_TS_PERSON.NameValue(i+1, "ENO_NO")){
 		            		
  		            		//alert("같은 사람");
  		            		if(i == "1"){
  		            			
  		            			dsT_TS_PERSON_02.addrow();
  		            			dsT_TS_PERSON_02.NameValue(dsT_TS_PERSON_02.RowPosition,"ENO_NO") = dsT_TS_PERSON.NameValue(i,"ENO_NO");
 	            				
  		            		}
  		            		
  		            		
  		            	}else{

  	 		            	//다른 사람
 	            			for(var j=1; j<=count; j++) {
 		            		
 		            			if(dsT_TS_PERSON.NameValue(i+1, "ENO_NO") == dsT_TS_PERSON_02.NameValue(j, "ENO_NO")){

 		            				aaa = aaa + 1;

 		            			}else{


 		            			}

 	            			}
  	 		            	
 	            			if(aaa == 1){
 	            				
 	            				dsT_TS_PERSON_02.addrow();
 	            				dsT_TS_PERSON_02.NameValue(dsT_TS_PERSON_02.RowPosition,"ENO_NO") = dsT_TS_PERSON.NameValue(i+1,"ENO_NO");
 	            				aaa = 1;
 	            			}

 	            			count = count + 1;

  		            	}

  		            } 		 		            
 		            
 		            
					trT_TS_PERSON.KeyValue = "tr01(I:dsT_TS_PERSON_02=dsT_TS_PERSON_02)";

					trT_TS_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist020.cmd.EIST020CMD&S_MODE=UPT_PER"
																							            + "&PIS_YM="+pis_ym
																							            + "&TEAM_CD="+team_cd																							            
																							            + "&ENO_NO="+eno_no
																							            + "&STATUS=S";	
					trT_TS_PERSON.post(); 		 					

		 			fnc_SearchList('3');					
					
 				}
			  			
			  			
            }

  			
         }  

        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
        	
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

        }
         /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */

        function fnc_GetNm() {
        	 
                fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','1','0');

        }

        function fnc_Getcd() {
        	
                fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');
        }		
		
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_TS_TIMESHEET)   |
    | 3. 사용되는 Table List()		     |
    +------------------------------------------------>
    <Object ID="dsT_TS_DAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_TS_DAY_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_TS_PROJECT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <Object ID="dsT_TS_PROJECT_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
        
    <Object ID="dsT_TS_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
        
    <Object ID="dsT_TS_PERSON_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
        
    <Object ID="dsT_CM_TEAM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_TS_TIMESHEET)	    |
    | 3. 사용되는 Table List()	            |
    +--------------------------------------------------->
    <Object ID ="trT_TS_TIMESHEET" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_TS_DAY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    
    <Object ID ="trT_TS_PROJECT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    
    <Object ID ="trT_TS_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
            
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_TS_TIMESHEET Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_TS_TIMESHEET Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_TS_TIMESHEET Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
	    cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_TS_DAY event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        alert("성공적으로 처리되었습니다.");
    </script>
    
    <script for=trT_TS_PROJECT event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        alert("성공적으로 처리되었습니다.");
    </script>    
    
    <script for=trT_TS_PERSON event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        alert("성공적으로 처리되었습니다.");
    </script>    
    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_TS_TIMESHEET event="OnFail()">
        cfErrorMsg(this);
    </script>



<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
		
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_ConsentOver.gif',1)"><img src="../../images/button/btn_ConsentOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_YES()"></a>
			&nbsp;
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../images/button/btn_SendbackOver.gif',1)"><img src="../../images/button/btn_SendbackOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_NO()"></a>
			&nbsp;
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList('1')"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
									<col width="60"></col>
									<col width="100"></col>
									<col width="60"></col>
									<col width="200"></col>
									<col width="60"></col>	
									<col width="200"></col>
									<col width="60"></col>																	
									<col width="*"></col>									
								</colgroup>
							<tr>
								<td align="right" class="searchState">년 월&nbsp;</td>
								<td class="padding2423">
                                     <input type="text" id="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength= "7"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
								</td>
								<td align="right" class="searchState">팀&nbsp;</td>
								<td class="padding2423">					
					                <input id="txtTEAM_CD_SHR" name="txtTEAM_CD_SHR" size="9"  maxlength= "8"   onChange="fnc_GetCommNm('A4','txtTEAM_CD_SHR','txtTEAM_NM_SHR');" style="ime-mode:disabled"   >
					                <input id="txtTEAM_NM_SHR" name="txtTEAM_NM_SHR" size="12" maxlength= "14"  >
					                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTeam','','../../images/button/btn_HelpOver.gif',1)">
					                <img src="../../images/button/btn_HelpOn.gif" id="ImgTeam" name="ImgTeam" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commnmPopup('txtTEAM_CD_SHR','txtTEAM_NM_SHR','소속','DEPT')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTeam','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
					            </td>									
								
								<td align="right" class="searchState">사 번&nbsp;</td>
								<td class="padding2423">								
					                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9"  maxlength= "8"   onkeypress="javascript:if(event.keyCode==13) {fnc_GetNm();fnc_SearchList();}" style="ime-mode:disabled"   >
					                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength= "14"  onkeypress="javascript:if(event.keyCode==13) {fnc_Getcd();fnc_SearchList();}" >
					                <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup();fnc_SearchList();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                                    <input type="hidden" id="hidEMPL_DPT_CD">
					            </td>								
								
								<td class="searchState" align="right">조회조건</td>
								<td class="padding2423" align="left">
									<select id="cmbTS_STS_SHR" style="WIDTH: 60px" onChange="fnc_SearchList()">
										<option value="">모두</option>
										<option value="S">저장</option>
										<option value="R">상신</option>
										<option value="Y">완료</option>
									</select>
								</td>								
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- power Search테이블 끝 -->

<BR>

<!-- 탭 사용 컴퍼넌트 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>

        <td align="left">

            <!-- 탭버튼데이블 시작 -->
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="120">
                        <!-- 탭오버 -->
                        <table width="120" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tab25Left.gif" width="6" height="25" id="TabLeft01"></td>
                                <td align="center" class="overMenu25" onclick="TabEvent(0)" style="cursor:hand" id="TabBtn01">일자별</td>
                                <td width="6"><img src="../../images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>                            
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- 탭히든 -->
                        <table width="120" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">프로젝트별</td>
                                <td width="6"><img src="../../images/common/tabGray25Right.gif" width="7" height="25" id="TabRight02"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- 탭히든 -->
                        <table width="120" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft03"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(2)" style="cursor:hand" id="TabBtn03">개인별</td>
                                <td width="6"><img src="../../images/common/tabGray25Right.gif" width="7" height="25" id="TabRight03"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>

</table>




<!-- 일자별 내용 조회 그리드 테이블 시작-->
<div id="divEIST020_01" style="position:absolute; left:20; top:200; width:1000; height:500; z-index:1;" >
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_TS_DAY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"					value="dsT_TS_DAY">
                            <param name="Editable"    				value="true">							
                            <param name="Format"					value="
								<C> id={currow}			width=30    name='NO'		    	align=center </C>	
								<C> id='REG_YMD'	    width=200	name='일자'	        	align=center suppress=1 MASK='XXXX-XX-XX'</C>															
								<C> id='ENO_NM'	    	width=150	name='성명'	        	align=center suppress=2</C>							
								<C> id='PJT_NM'	    	width=250	name='프로젝트명'	        align=left </C>								
								<C> id='WTIME'	    	width=80	name='시간'	        	align=center </C>	
								<C> id='TEAM_NM'	    width=120	name='팀명'	        	align=center </C>	
								<C> id='STATUS'	    	width=100	name='상태'	        	align=center </C>																															
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<!-- 안내 내용 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top"><br>
		            ※  1. "일자별", "프로젝트별", "개인별" 탭을 클릭하여 조회할 수 있습니다.<br>  
		     &nbsp;&nbsp;&nbsp;2. 상태가 <font color="red"><b>저장</b></font>인 경우 승인 및 반송이 안됩니다. <font color="red"><b>상신</b></font>상태일 경우에만 가능합니다.<br> 
			 &nbsp;&nbsp;&nbsp;3. 시간을 변경해야할 경우 팀장님께서는 반송 처리한 뒤 팀원이 수정 후 재상신하면 됩니다.<br> 
            </td>
        </tr>
</table>
<!-- 안내 내용 끝-->

</div>
<!-- 내용 조회 그리드 데이블 끝-->




<!-- 프로젝트별 내용 조회 그리드 테이블 시작-->
<div id="divEIST020_02" style="position:absolute; left:20; top:200; width:1000; height:500; z-index:1;" >
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_TS_PROJECT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"					value="dsT_TS_PROJECT">
                            <param name="Editable"    				value="true">							
                            <param name="Format"					value="
								<C> id={currow}			width=30    name='NO'		    	align=center </C>								
								<C> id='PJT_NM'	    	width=250	name='프로젝트명'	        align=left   suppress=1</C>									
								<C> id='REG_YMD'	    width=200	name='일자'	        	align=center suppress=2 MASK='XXXX-XX-XX'</C>															
								<C> id='ENO_NM'	    	width=150	name='성명'	        	align=center </C>							
								<C> id='WTIME'	    	width=80	name='시간'	        	align=center </C>	
								<C> id='TEAM_NM'	    width=120	name='팀명'	        	align=center </C>
								<C> id='STATUS'	    	width=100	name='상태'	        	align=center </C>																																
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<!-- 안내 내용 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top"><br>
		            ※  1. "일자별", "프로젝트별", "개인별" 탭을 클릭하여 조회할 수 있습니다.<br>  
		     &nbsp;&nbsp;&nbsp;2. 상태가 <font color="red"><b>저장</b></font>인 경우 승인 및 반송이 안됩니다. <font color="red"><b>상신</b></font>상태일 경우에만 가능합니다.<br> 
			 &nbsp;&nbsp;&nbsp;3. 시간을 변경해야할 경우 팀장님께서는 반송 처리한 뒤 팀원이 수정 후 재상신하면 됩니다.<br> 
            </td>
        </tr>
</table>
<!-- 안내 내용 끝-->

</div>
<!-- 내용 조회 그리드 데이블 끝-->



<!-- 개인별 내용 조회 그리드 테이블 시작-->
<div id="divEIST020_03" style="position:absolute; left:20; top:200; width:1000; height:500; z-index:1;" >
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_TS_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"					value="dsT_TS_PERSON">
                            <param name="Editable"    				value="true">							
                            <param name="Format"					value="
								<C> id={currow}			width=30    name='NO'		    	align=center </C>	
								<C> id='ENO_NM'	    	width=150	name='성명'	        	align=center suppress=1</C>																
								<C> id='REG_YMD'	    width=200	name='일자'	        	align=center suppress=2 MASK='XXXX-XX-XX'</C>															
								<C> id='PJT_NM'	    	width=250	name='프로젝트명'	        align=left   </C>
								<C> id='WTIME'	    	width=80	name='시간'	        	align=center </C>	
								<C> id='TEAM_NM'	    width=120	name='팀명'	        	align=center </C>
								<C> id='STATUS'	    	width=100	name='상태'	        	align=center </C>																															
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<!-- 안내 내용 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top"><br>
		            ※  1. "일자별", "프로젝트별", "개인별" 탭을 클릭하여 조회할 수 있습니다.<br>  
		     &nbsp;&nbsp;&nbsp;2. 상태가 <font color="red"><b>저장</b></font>인 경우 승인 및 반송이 안됩니다. <font color="red"><b>상신</b></font>상태일 경우에만 가능합니다.<br> 
			 &nbsp;&nbsp;&nbsp;3. 시간을 변경해야할 경우 팀장님께서는 반송 처리한 뒤 팀원이 수정 후 재상신하면 됩니다.<br> 
            </td>
        </tr>
</table>
<!-- 안내 내용 끝-->

</div>
<!-- 내용 조회 그리드 데이블 끝-->




</form>
<!-- form 끝 -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 




