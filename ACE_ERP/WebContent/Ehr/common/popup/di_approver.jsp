<!--
***********************************************************************
* @source      : di_approver.jsp
* @description : 결재자정보조회 PAGE(근태관련)
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2009/10/16     권혁수        최초작성.
*----------------------------------------------------------------------
* 2016/05/17  |  정영식   | 소스이전                          * 
* 2016/06/23  |  이동훈   | 소스이전                          * 
***********************************************************************
-->
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="Ehr.common.util.JSPUtil" %>
<%
    String gbn_cd     = request.getParameter("GBN_CD");
    String ret_cd     = request.getParameter("RET_CD");
    String str_ymd    = request.getParameter("STR_YMD");
    String end_ymd    = request.getParameter("END_YMD");
    String dpt_cd     = request.getParameter("DPT_CD");
    String eno_no     = request.getParameter("ENO_NO");
    String edu_cst    = request.getParameter("EDU_CST");
    String app_num    = JSPUtil.rns(request.getParameter("APP_NUM"));
    String gun_gbn    = JSPUtil.rns(request.getParameter("GUN_GBN"));
    
    
	if("".equals(app_num)){
		app_num = "10";
	}

%>

<html>

    <head>
    <title>결재자정보조회(di_approver)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="../../css/style.css" rel="stylesheet" type="text/css">
    <link href="../../css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="../../common/result.js"></script>	    
    <script language=javascript src="../../common/common.js"></script>
    <script language="javascript" src="../../common/calendar/calendar.js"></script>
    <base target="_self">
    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var paramDataSet  = window.dialogArguments;
        
        var paramDataSet1 = window.dialogArguments;


        var dutyYN_05_YN = 0;	//부서장 공석 Check
        var dutyYN_41_YN = 0;	//팀장 공석 Check
        
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //데이터셋 전송
            dsT_CM_PERSON.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.empl.cmd.EMPLCMD&S_MODE=SHR01"
											                 + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;
            
            //prompt(this, dsT_CM_PERSON.DataID);
            
            dsT_CM_PERSON.reset();
            
            	//팀장 공석 Check
            	
				for(i=1; i <= dsT_CM_PERSON.countRow; i++){
					
						var dutyCdTemp = dsT_CM_PERSON.NameValue(i,"DUTY_CD");
						
						if(dutyCdTemp == '41'){
							
							dutyYN_41_YN += 1;
							
						}
						
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

            //이곳에 해당 코딩을 입력 하세요

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

            // 엑셀로 변환 할 자료가 있는지 체크하고

            // 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

            // 아무것도 없는 상태에서 추가 하게 되면 처음은 AddNew하고 나중 부터 InsertRow합

            // Pow Append 후 Grid에 Append된 Row의 특정 Column으로 이동하는거

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

            // 삭제 할 자료가 있는지 체크하고

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)

            // 삭제 후 해당 그리드로 Focus 이동

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            //이곳에 해당 코딩을 입력 하세요

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
        	
            cfStyleGrid_New(form1.grdT_CM_PERSON,0,"false","right");      // Grid Style 적용

            cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false");      // Grid Style 적용
 
            //데이터셋 전송
            dsT_CM_DEPT.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.empl.cmd.EMPLCMD&S_MODE=SHR_DPT"
						                                 										+ "&ENO_NO="+"<%=eno_no%>";
            //prompt(this,dsT_CM_DEPT.DataID);
			dsT_CM_DEPT.reset();            

			
            var eno_no  = dsT_CM_DEPT.NameValue(1,"ENO_NO");
            var dpt_cd  = dsT_CM_DEPT.NameValue(1,"DPT_CD");
	        var gbn_cd  = "<%=gbn_cd%>";
	        var ret_cd  = "<%=ret_cd%>";
	        var str_ymd = "<%=str_ymd%>";
	        var end_ymd = "<%=end_ymd%>";
	        
/*
	        alert("eno_no::"+eno_no);
	        alert("dpt_cd::"+dpt_cd);
	        alert("gbn_cd::"+gbn_cd);
	        alert("ret_cd::"+ret_cd);
	        alert("str_ymd::"+str_ymd);
	        alert("end_ymd::"+end_ymd);
*/

            //넘어온 사번과 구분을 저장하고
            document.getElementById("txtENO_NO").value      = eno_no;
            document.getElementById("hidGBN_CD").value      = gbn_cd;
            document.getElementById("hidRET_CD").value      = ret_cd;
            document.getElementById("hidSTR_YMD").value     = str_ymd;
            document.getElementById("hidEND_YMD").value     = end_ymd;

            //넘어온 사번으로 사원정보 검색
            var enoObj = fnc_GetCommonEnoNm("txtENO_NO");
            
            if(dsT_CM_DEPT.NameValue(1,"ENO_NO") == "") {
            	
                alert("신청자 정보가 없습니다.");
                
                window.close();
                
                return;
                
            }

            //검색조건(소속)지정
            if(dpt_cd != "") {
            	
                document.getElementById("txtDPT_CD_SHR").value  = dpt_cd;

                fnc_GetCommNm('A4', "txtDPT_CD_SHR", "txtDPT_NM_SHR");
                
            } else {
            	
                document.getElementById("txtDPT_CD_SHR").value  = enoObj.dpt_cd;
        
                document.getElementById("txtDPT_NM_SHR").value  = enoObj.dpt_nm;
                
            }

            //신청자 정보 추가
            document.getElementById("lblJOB_NM_A2").innerText   = dsT_CM_DEPT.NameValue(1,"JOB_NM");
            document.getElementById("lblENO_NO_A2").innerText   = dsT_CM_DEPT.NameValue(1,"ENO_NO");
            document.getElementById("lblENO_NM_A2").innerText   = dsT_CM_DEPT.NameValue(1,"ENO_NM");

            //신청자 정보 저장
            document.getElementById("txtENO_NO").value      = enoObj.eno_no;
            document.getElementById("txtENO_NM").value      = enoObj.eno_nm;
            document.getElementById("txtDPT_CD").value      = enoObj.dpt_cd;
            document.getElementById("txtDPT_NM").value      = enoObj.dpt_nm;
            document.getElementById("txtJOB_CD").value      = enoObj.job_cd;
            document.getElementById("txtJOB_NM").value      = enoObj.job_nm;
            document.getElementById("txtDUTY_CD").value      = enoObj.duty_cd;
            document.getElementById("txtDUTY_NM").value      = enoObj.duty_nm;

            document.getElementById("txtHEAD_TAG").value      = enoObj.head_tag;

            cfCopyDataSet(paramDataSet, dsT_DI_APPROVAL);
            
            //데이터셋 전송
            dsT_CM_PERSON.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.empl.cmd.EMPLCMD&S_MODE=SHR"
						                                 + "&ENO_NO="+"<%=eno_no%>"
						                                 + "&DPT_CD="+dsT_CM_DEPT.NameValue(1,"DPT_CD")
						                                 + "&GBN_CD="+document.getElementById("hidGBN_CD").value
						                                 + "&RET_CD="+document.getElementById("hidRET_CD").value
						                                 + "&STR_YMD="+document.getElementById("hidSTR_YMD").value
						                                 + "&END_YMD="+document.getElementById("hidEND_YMD").value;
            
            dsT_CM_PERSON.reset();
            
            // 부서코드 핸들링할수있게
			document.getElementById("txtDPT_CD_SHR").value = "";
			document.getElementById("txtDPT_NM_SHR").value = "";
			
        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /**
         * 결재자를 선정한 후 확인을 누르면 결재자정보가 넘어감
         * (결재자가 없으면 신청자가 결재자로 넘어감)
         */
        function fnc_Confirm() {

        		// 전결 규정 Check
				var dutyCd = document.getElementById("txtDUTY_CD").value;
				var dutyNm = document.getElementById("txtDUTY_NM").value;
				var dpt_Cd = document.getElementById("txtDPT_CD").value;
				var dutyYN = 0;
				var dutyYN_A4 = 0;  //전무 -> 임시 사장
				var dutyYN_03 = 0;  //본부장
				var dutyYN_B6 = 0;  //사업부장
				var dutyYN_05 = 0;	//부서장
				var dutyYN_41 = 0;	//팀장				
				var headTag = document.getElementById("txtHEAD_TAG").value;
				var Cost = 0;
				
				Cost = "<%=edu_cst%>";

				for(i=1; i <= dsT_DI_APPROVAL.countRow; i++){
						var dutyCdTemp = dsT_DI_APPROVAL.NameValue(i,"GUN_YMD");  //전용
						var JobCdTemp  = dsT_DI_APPROVAL.NameValue(i,"JOB_CD");

						if(dutyCdTemp == '03'){
							dutyYN_03 += 1;
						}else if(dutyCdTemp == 'B6'){
							dutyYN_B6 += 1;
						}else if(dutyCdTemp == '05'){
							dutyYN_05 += 1;
						}else if(dutyCdTemp == '41'){
							dutyYN_41 += 1;							
						}else if(JobCdTemp  == '02'){
							dutyYN_A4 += 1;					
						}
					// 경영지원본부 본부장 전결 대행 팀장대행  -- 임시
					//if((headTag == 'B4' || headTag == '03') && (dutyCdTemp == '05')){
					//	dutyYN_03 += 1;
					//}

				}

				
				
           if("<%=gun_gbn%>" == "D" ||  "<%=gun_gbn%>" == "J"){   //본부장 전결 Check "<%=gun_gbn%>" == "B" ||

					if(dutyCd != "03"){
						
					 if(dutyYN_03 == 0 ){
						 
					   if("<%=gun_gbn%>" == "D" || "<%=gun_gbn%>" == "B"){
						   
							alert("출장 또는  파견관리는 본부장 전결입니다.");
							
					   }else{
						   
						   	alert("휴일근무수당은 본부장 전결입니다.");
						   	
					   }

						return;
					 }
					 
					}

			}else if("<%=gun_gbn%>" == "C" || "<%=gun_gbn%>" == "U" || "<%=gun_gbn%>" == "P"  || "<%=gun_gbn%>" == "A" || "<%=gun_gbn%>" == "M"  || "<%=gun_gbn%>" == "N"|| "<%=gun_gbn%>" == "Q"){

				if(dutyCd != '03' && dutyCd != '05' && dutyCd != '41'){
					
					
					//토목부장 공석이여서 결재 올라갈 수 있었고 건축부는 건축부장까지 올라갔었다.
					
					if(dutyYN_05 == 0 && headTag != 'Q1' && headTag != 'Q2' && dutyYN_05_YN > 0 && dpt_Cd != 'I800' && dpt_Cd != 'I100' && dpt_Cd != 'I200'){
						

						alert("교육/근태/도서구입사항은 팀장 전결입니다.");
						
						
						//////return;  테스트 후 풀자
					}

					// 사업부장 전결
					//if(headTag == 'Q1' || headTag == 'Q2'){
					//
					//	if(dutyYN_B6 == 0){
					//		alert("근태사항은 사업부장 전결입니다.");
					//		return;
					//	}
					//}

				}

			}else if("<%=gun_gbn%>" == "B"){				//출장일 경우

																			//2017.01.23 부서제 -> 팀제로 변경됐으므로 이동훈 수정
				if(dutyCd != '03' && dutyCd != '05' && dutyCd != '41'){		//내 신분이 부서장(팀장)도 아니고 본부장도 아니면 쭉 진행하자

					if(dutyYN_03 > 0 ){						//결재라인중에 본부장 결재자가 있으면 확인 메시지
						
						if(confirm("출장은 팀장 전결입니다. 본부장 결재도 받으시겠습니까?")){

			            } else {
			            	
			                return;
			                
			            }

					}

				
				    //2014.07.22 조은기 과장 요청으로 이동훈 수정
					if(dutyYN_A4 > 0) {
						
						alert("대표이사님 결재는 해당부서에서\n서면으로 출력하여 진행하여 주시기 바랍니다.");
						
						return;
						
					}
				    
				    
				/*
				if(dutyCd != '04'){

					if(dutyYN_05 == 0 && dpt_Cd != 'C841' && dpt_Cd != 'E211' && dpt_Cd != 'C130' && dpt_Cd != 'B500' && dpt_Cd != 'I500' && dpt_Cd != 'I100' && dpt_Cd != 'I130'  && dpt_Cd != 'I143' && dpt_Cd != 'I800'){	//부서장 결재라인이 없으면 없는대로
						
						alert("출장은 부서장 전결입니다. 확인바랍니다.");
					
						return;
					}

				}
				*/

				}


			}else if("<%=gun_gbn%>" == "R" || "<%=gun_gbn%>" == "H" ){

					if(dutyYN_03 == 0){
						alert("휴일근무수당은 본부장 전결입니다.");
						return;
					}
					if(dutyYN_05 == 0 ){
						alert("휴일근무 수당은 팀장 결재 필수사항 입니다.");
						return;
					}

					// 사업부장 전결
					//if(headTag == 'Q1' || headTag == 'Q2'){
					//
					//	if(dutyYN_B6 == 0){
					//		alert("휴일근무 수당은 사업부장 결재 필수사항 입니다.");
					//		return;
					//	}
					//}

			}
            cfCopyDataSet(dsT_DI_APPROVAL, paramDataSet1);
            window.close();

        }

    </script>

    </head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명()      |
    | 3. 사용되는 Table List()             |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_DEPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            alert("검색하신 조건의 자료가 없습니다.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
            document.getElementById("txtENO_NO_SHR").focus();          //검색 1조건에 Focus

        } else {

            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
            grdT_CM_PERSON.SetColumn("ENO_NO");//set focus

        }

    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------+
    | 그리드의 ROW를 더블 클릭 할때  |
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_PERSON event=OnDblClick(row,colid)>

        var i = 0;

		var dutyCd = document.getElementById("txtDUTY_CD").value;
		var dutyNm = document.getElementById("txtDUTY_NM").value;

		//if(dsT_CM_PERSON.NameValue(row,'ENO_NO') == "<%=eno_no%>"){
		//	alert("기안자 본인은 결재자가 될수 없습니다");
		//	return false;
		//}




		if(dsT_DI_APPROVAL.CountRow >= <%=app_num%>){
			alert("결재선은 <%=app_num%>  까지만 지정할수있습니다.");
			return false;
		}
		// 부서장만 본부장에게 신청할수 있다


		var headTag =  document.getElementById("txtHEAD_TAG").value;

		if("<%=gun_gbn%>" == "C" || "<%=gun_gbn%>" == "U" || "<%=gun_gbn%>" == "P"  || "<%=gun_gbn%>" == "A" || "<%=gun_gbn%>" == "M"  || "<%=gun_gbn%>" == "N"){
			if(dutyCd != '03' && dutyCd != '05'){

				if(dsT_CM_PERSON.NameValue(dsT_CM_PERSON.RowPosition,"DUTY_CD")  == "03"  && dutyYN_05_YN > 0){
					alert("교육/근태사항은 부서장 전결입니다.");
					return false;
				}
			//	if(dsT_CM_PERSON.NameValue(dsT_CM_PERSON.RowPosition,"HEAD_TAG")  != headTag){
			//		alert("지정결재선이 아닙니다");
			//		return false;
			//	}
			}
		}
        //중복사번체크
        for(i=1; i<=dsT_DI_APPROVAL.countRow; i++){
            if(dsT_CM_PERSON.NameValue(row,'ENO_NO') == dsT_DI_APPROVAL.NameValue(i,'ENO_NO')){
                alert("해당 결재자는 이미 결재선에 포함되어 있습니다.");
                return false;
            }
        }
        dsT_DI_APPROVAL.InsertRow(1);//위에서부터 넣기 위해 insert
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"ENO_NO") = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"ENO_NM") = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"DPT_CD") = dsT_CM_PERSON.NameValue(row,'DPT_CD');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"DPT_NM") = dsT_CM_PERSON.NameValue(row,'DPT_NM');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"JOB_CD") = dsT_CM_PERSON.NameValue(row,'JOB_CD');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"JOB_NM") = dsT_CM_PERSON.NameValue(row,'JOB_NM');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"GUN_YMD") = dsT_CM_PERSON.NameValue(row,'DUTY_CD');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"SEQ_NO") = dsT_DI_APPROVAL.CountRow;
    </script>

    <!-------------------------------+
    | 그리드의 ROW에서 엔터 입력할때|
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_PERSON event=OnReturn(row,colid)>

        var i = 0;

		//if(dsT_CM_PERSON.NameValue(row,'ENO_NO') == "<%=eno_no%>"){
		//	alert("기안자 본인은 결재자가 될수 없습니다");
		//	return false;
		//}


		if(dsT_DI_APPROVAL.CountRow > <%=app_num%>){
			alert("결재선은 <%=app_num%>  까지만 지정할수있습니다.");
			return false;
		}
		// 부서장만 본부장에게 신처알수 있다
		var dutyCd = document.getElementById("txtDUTY_CD").value;
		var dutyNm = document.getElementById("txtDUTY_NM").value;

		var headTag =  document.getElementById("txtHEAD_TAG").value;

		//alert(dutyCd);
		if("<%=gun_gbn%>" == "D"){

		}else if("<%=gun_gbn%>" == "C" || "<%=gun_gbn%>" == "U" || "<%=gun_gbn%>" == "P"  || "<%=gun_gbn%>" == "A" || "<%=gun_gbn%>" == "M" || "<%=gun_gbn%>" == "N"){
			if(dutyCd != 'B6' && dutyCd != '05'){
				//alert(dsT_CM_PERSON.NameValue(dsT_CM_PERSON.RowPosition,"DUTY_CD"));
				if(dsT_CM_PERSON.NameValue(dsT_CM_PERSON.RowPosition,"DUTY_CD")  == "03"){
					alert("교육/근태사항은 부서장 전결입니다.");
					return false;
				}
				if(dsT_CM_PERSON.NameValue(dsT_CM_PERSON.RowPosition,"HEAD_TAG")  != headTag){
					alert("지정결재선이 아닙니다");
					return false;
				}
			}
		}
        //중복사번체크
        for(i=1; i<=dsT_DI_APPROVAL.countRow; i++){
            if(dsT_CM_PERSON.NameValue(row,'ENO_NO') == dsT_DI_APPROVAL.NameValue(i,'ENO_NO')){
                alert("해당 결재자는 이미 결재선에 포함되어 있습니다.");
                return false;
            }
        }

        dsT_DI_APPROVAL.InsertRow(1);//위에서부터 넣기 위해 insert

        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"ENO_NO") = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"ENO_NM") = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"DPT_CD") = dsT_CM_PERSON.NameValue(row,'DPT_CD');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"DPT_NM") = dsT_CM_PERSON.NameValue(row,'DPT_NM');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"JOB_CD") = dsT_CM_PERSON.NameValue(row,'JOB_CD');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"JOB_NM") = dsT_CM_PERSON.NameValue(row,'JOB_NM');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"GUN_YMD") = dsT_CM_PERSON.NameValue(row,'DUTY_CD');
        dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"SEQ_NO") = dsT_DI_APPROVAL.CountRow;
    </script>

    <!-------------------------------+
    | 그리드의 ROW를 더블 클릭 할때  |
    +-------------------------------->
    <script language=JavaScript for=grdT_DI_APPROVAL event=OnDblClick(row,colid)>

        var j = 0;
        var i = 0;

        // 상신자는 삭제 못한다.
		/*
        if(dsT_DI_APPROVAL.CountRow == row){
            alert("신청자는 결재선에서 삭제할 수 없습니다.");
            return;
        }
		*/
        dsT_DI_APPROVAL.DeleteRow(row);

        i = 0;
        j = 1;

        for(i=dsT_DI_APPROVAL.CountRow-1; i>=1; i--){
            j++;
            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") = j;
        }

    </script>

    <!-------------------------------+
    | 그리드의 ROW에서 엔터 입력할때|
    +-------------------------------->
    <script language=JavaScript for=grdT_DI_APPROVAL event=OnReturn(row,colid)>

        var j = 0;
        var i = 0;

        // 상신자는 삭제 못한다.
        if(dsT_DI_APPROVAL.CountRow == row){
            alert("신청자는 결재선에서 삭제할 수 없습니다.");
            return;
        }

        dsT_DI_APPROVAL.DeleteRow(row);

        i = 0;
        j = 1;

        for(i=dsT_DI_APPROVAL.CountRow-1; i>=1; i--){
            j++;
            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") = j;
        }

    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onload="fnc_OnLoadProcess();">

    <!-- form 시작 -->
    <form name="form1">

    <!-- 타이틀 바 테이블 시작 -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="../../images/common/barBg.gif">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                        <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">결재자정보조회</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 타이틀 바 테이블 끝 -->

    <!-- 버튼 테이블 시작 -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

    <!-- power Search테이블 시작 -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" class="blueTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td align="center" class="searchState">사원 번호/성명&nbsp;</td>
                                    <td class="padding2423">
                                        <input name="txtENO_NO_SHR" id="txtENO_NO_SHR" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList()">
                                        <input type="text" style="display:none">

                                        <input type="hidden" id="hidGBN_CD">
                                        <input type="hidden" id="hidRET_CD">
                                        <input type="hidden" id="hidSTR_YMD">
                                        <input type="hidden" id="hidEND_YMD">

                                        <input type="hidden" id="txtENO_NO">
                                        <input type="hidden" id="txtENO_NM">
                                        <input type="hidden" id="txtDPT_CD">
                                        <input type="hidden" id="txtDPT_NM">
                                        <input type="hidden" id="txtJOB_CD">
                                        <input type="hidden" id="txtJOB_NM">

                                        <input type="hidden" id="txtDUTY_CD">
                                        <input type="hidden" id="txtDUTY_NM">
                                        <input type="hidden" id="txtHEAD_TAG">

                                    </td>

                                    <td align="center" class="searchState">소속&nbsp;</td>
                                    <td class="padding2423">
                                        <input name=txtDPT_CD_SHR size="6" maxlength= "6"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                        <input name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                                        <img src="../../images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
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

    <!-- 조회 상태 테이블 시작 -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 조회 상태 테이블 끝 -->

    <!-- 내용 조회 그리드 테이블 시작-->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:450px;height:157px;">
                                <param name="DataID"            value="dsT_CM_PERSON">
                                <param Name="Editable"          value="false">
                                <param name=HiddenHScroll    value="true">
                                <param name="Format"            value='
                                    <C> id=HEAD_NM           	width=100  	name=본부   align=left   </C>
                                    <C> id=DPT_NM            	width=110   name=소속   align=left   </C>
                                    <C> id=JOB_NM            	width=60   	name=직위   align=left   </C>
                                    <C> id=ENO_NM            	width=70   	name=성명   align=center </C>
                                    <C> id=DUTY_NM            width=80   	name=직책   align=center </C>
                                '>
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState"><font color = "blue">※ 해당항목을 더블클릭 하시면 선택됩니다.</span></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 내용 조회 그리드 데이블 끝-->

    <!-- 내용 조회 그리드 테이블 시작-->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop8">
	            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>결재선</strong>
	        </td>
	    </tr>
	    <tr>
	        <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:450px;height:157px;">
                                <param name="DataID"            value="dsT_DI_APPROVAL">
                                <param Name="Editable"          value="false">
                                <param name=HiddenHScroll    value="true">
                                <param name="Format"            value='
                                    <C> id=SEQ_NO          		width=39    	name=NO     align=center   </C>
                                    <C> id=DPT_NM            	width=110   	name=소속   align=left     </C>
                                    <C> id=JOB_NM            	width=110    name=직위   align=center   </C>
                                    <C> id=ENO_NM           	width=120   	name=성명   align=center   </C>
                                '>
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState"><font color = "blue">※ 해당항목을 더블클릭 하시면 삭제됩니다.</font></span></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 내용 조회 그리드 데이블 끝-->

    <!-- 조회 상태 테이블 시작 -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="60"></col>
                        <col width="50"></col>
                        <col width="70"></col>
                        <col width="50"></col>
                        <col width="70"></col>
                        <col width="50"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="blueBold">신청자</td>
                        <td align="center" class="blueBold">직위</td>
                        <td class="padding2423" id="lblJOB_NM_A2"></td>
                        <td align="center" class="blueBold">사번</td>
                        <td class="padding2423" id="lblENO_NO_A2"></td>
                        <td align="center" class="blueBold">성명</td>
                        <td class="padding2423" id="lblENO_NM_A2"></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="paddingTop8" align="center">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConfirm','','../../images/button/btn_ConfirmOver.gif',1)"><img src="../../images/button/btn_ConfirmOn.gif" name="imgConfirm" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Confirm()"></a>
            </td>
        </tr>
    </table>
    <!-- 조회 상태 테이블 끝 -->

    </form>
    <!-- form 끝 -->

</body>
</html>