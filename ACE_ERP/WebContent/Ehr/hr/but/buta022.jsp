<!--
***********************************************************************
* @source      : buta022.jsp
* @description : 동행인입력 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2016/06/01      이동훈        ERP 이사
***********************************************************************
-->

<%@ page contentType="text/html;charset=euc-kr"%>

<html>
<head>
<title>동행인입력</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>
	<base target="_self">
	
    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

		var dsTemp = window.dialogArguments;


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //이곳에 해당 코딩을 입력 하세요

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

            //이곳에 해당 코딩을 입력 하세요

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

			enableInput2();
			disableInput1();
			document.getElementById("txtCOM_CNT").value = "0";

			//document.getElementById("chkEMP1").checked = false;
			//document.getElementById("chkEMP2").checked = false;
			//document.getElementById("chkEMP3").checked = false;
			//document.getElementById("chkEMP4").checked = false;
			//document.getElementById("chkEMP5").checked = false;

			document.getElementById("resultMessage").innerText = ' ';

			//동행인수
			document.getElementById("txtCOM_CNT").value = "0";

            //동행인1
			document.getElementById("txtENO_NO1").value = "";
			document.getElementById("txtENO_NM1").value = "";
			document.getElementById("cmbJOB_CD1").value = "";

            //동행인2
			document.getElementById("txtENO_NO2").value = "";
			document.getElementById("txtENO_NM2").value = "";
			document.getElementById("cmbJOB_CD2").value = "";

            //동행인3
			document.getElementById("txtENO_NO3").value = "";
			document.getElementById("txtENO_NM3").value = "";
			document.getElementById("cmbJOB_CD3").value = "";

            //동행인4
			document.getElementById("txtENO_NO4").value = "";
			document.getElementById("txtENO_NM4").value = "";
			document.getElementById("cmbJOB_CD4").value = "";

            //동행인5
			document.getElementById("txtENO_NO5").value = "";
			document.getElementById("txtENO_NM5").value = "";
			document.getElementById("cmbJOB_CD5").value = "";

			dsTemp.NameValue(1,"COM_CNT") = "";
			for(var i=1; i<=5; i++){
				dsTemp.NameValue(1,"COM_NM"+i) = "";
            	dsTemp.NameValue(1,"COM_CD"+i) = "";
            	dsTemp.NameValue(1,"COM_NO"+i) = "";
            	dsTemp.NameValue(1,"COM_NAM"+i) = "";
			}


			document.getElementById("txtENO_NO1").focus();

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE")+"  "+dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbJOB_CD1").add(oOption);

            }
            for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE")+"  "+dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbJOB_CD2").add(oOption);

            }
            for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE")+"  "+dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbJOB_CD3").add(oOption);

            }
            for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE")+"  "+dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbJOB_CD4").add(oOption);

            }
            for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE")+"  "+dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbJOB_CD5").add(oOption);

            }

			if(dsTemp.NameValue(1,"COM_CNT") == "" || dsTemp.NameValue(1,"COM_CNT") == "0"){
				enableInput2();
				disableInput1();
				document.getElementById("txtENO_NO1").focus();
			}else{
				fnc_LoadData();
				fnc_UserSum();
			}

        }

        /*************************
         * 15. 확인버튼 Click    *
         *************************/
        function fnc_Confirm() {

            var index1 = document.getElementById("cmbJOB_CD1").selectedIndex;
            var index2 = document.getElementById("cmbJOB_CD2").selectedIndex;
            var index3 = document.getElementById("cmbJOB_CD3").selectedIndex;
            var index4 = document.getElementById("cmbJOB_CD4").selectedIndex;
            var index5 = document.getElementById("cmbJOB_CD5").selectedIndex;

            if(document.getElementById("txtCOM_CNT").value == "0"){
	            document.getElementById("txtCOM_CNT").value = "";
            }

			if(document.getElementById("txtCOM_CNT").value != ""){
				for(var i=1; i<=document.getElementById("txtCOM_CNT").value; i++){
					if(document.getElementById("txtENO_NM"+i).value.length == 0){
						alert("동행인의 입력순서가 올바르지 않습니다.");
						return;
					}
				}
			}

            for(var i=1; i<=5; i++){
            	//if(document.getElementById("chkEMP"+i).checked == true){
				//	if(document.getElementById("cmbJOB_CD"+i).value.length == 0 || document.getElementById("txtENO_NM"+i).value.length == 0){
				//		alert("동행인"+i+"의 데이터를 올바르게 입력하세요.");
				//		return;
				//	}
				//}else{
					if(document.getElementById("txtENO_NO"+i).value.length != 0){
						if(document.getElementById("cmbJOB_CD"+i).value.length == 0 || document.getElementById("txtENO_NM"+i).value.length == 0){
							alert("동행인"+i+"의 데이터를 올바르게 입력하세요.");
							return;
						}
					}
				//}
			}

            dsTemp.NameValue(1,"COM_CNT") = document.getElementById("txtCOM_CNT").value;       //동행인수

            //동행인1
            dsTemp.NameValue(1,"COM_CD1") = document.getElementById("cmbJOB_CD1").value;       //직위코드
            if(index1 > 0){
                dsTemp.NameValue(1,"COM_NM1") = dsT_CM_COMMON_A2.NameValue(index1,"CODE_NAME");//직위명
            }
            dsTemp.NameValue(1,"COM_NO1") = document.getElementById("txtENO_NO1").value;       //사번
            dsTemp.NameValue(1,"COM_NAM1") = document.getElementById("txtENO_NM1").value;      //성명

            //동행인2
            dsTemp.NameValue(1,"COM_CD2") = document.getElementById("cmbJOB_CD2").value;
            if(index2 > 0){
                dsTemp.NameValue(1,"COM_NM2") = dsT_CM_COMMON_A2.NameValue(index2,"CODE_NAME");
            }
            dsTemp.NameValue(1,"COM_NO2") = document.getElementById("txtENO_NO2").value;
            dsTemp.NameValue(1,"COM_NAM2") = document.getElementById("txtENO_NM2").value;

            //동행인3
            dsTemp.NameValue(1,"COM_CD3") = document.getElementById("cmbJOB_CD3").value;
            if(index3 > 0){
                dsTemp.NameValue(1,"COM_NM3") = dsT_CM_COMMON_A2.NameValue(index3,"CODE_NAME");
            }
            dsTemp.NameValue(1,"COM_NO3") = document.getElementById("txtENO_NO3").value;
            dsTemp.NameValue(1,"COM_NAM3") = document.getElementById("txtENO_NM3").value;

            //동행인4
            dsTemp.NameValue(1,"COM_CD4") = document.getElementById("cmbJOB_CD4").value;
            if(index4 > 0){
                dsTemp.NameValue(1,"COM_NM4") = dsT_CM_COMMON_A2.NameValue(index4,"CODE_NAME");
            }
            dsTemp.NameValue(1,"COM_NO4") = document.getElementById("txtENO_NO4").value;
            dsTemp.NameValue(1,"COM_NAM4") = document.getElementById("txtENO_NM4").value;

            //동행인5
            dsTemp.NameValue(1,"COM_CD5") = document.getElementById("cmbJOB_CD5").value;
            if(index5 > 0){
                dsTemp.NameValue(1,"COM_NM5") = dsT_CM_COMMON_A2.NameValue(index5,"CODE_NAME");
            }
            dsTemp.NameValue(1,"COM_NO5") = document.getElementById("txtENO_NO5").value;
            dsTemp.NameValue(1,"COM_NAM5") = document.getElementById("txtENO_NM5").value;

            window.close();

        }

		/**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup(num) {

            fnc_emplPopup("txtENO_NO"+num, "txtENO_NM"+num);

            fnc_GetUserInfo(num);

        }

  		/**
         * fnc_GetEnoNm 다른정보도 가져오게 재정의
         */
        function fnc_GetUserInfo(num) {

            var obj = fnc_GetEnoNm("txtENO_NO"+num);

            document.getElementById("txtENO_NO"+num).value = obj.eno_no;
            document.getElementById("txtENO_NM"+num).value = obj.eno_nm;
            document.getElementById("cmbJOB_CD"+num).value = obj.job_cd;

            fnc_UserSum();

        }

		/********************************************
         * 입력필드 사용 가능하게(Enable)          	        	 *
         ********************************************/
  		function enableInput1(){

  			document.getElementById("cmbJOB_CD1").disabled = false;
			document.form1.txtENO_NM1.readOnly = false;
  			document.form1.txtENO_NM1.className = "";

  			document.getElementById("cmbJOB_CD2").disabled = false;
			document.form1.txtENO_NM2.readOnly = false;
  			document.form1.txtENO_NM2.className = "";

  			document.getElementById("cmbJOB_CD3").disabled = false;
			document.form1.txtENO_NM3.readOnly = false;
  			document.form1.txtENO_NM3.className = "";

  			document.getElementById("cmbJOB_CD4").disabled = false;
			document.form1.txtENO_NM4.readOnly = false;
  			document.form1.txtENO_NM4.className = "";

  			document.getElementById("cmbJOB_CD5").disabled = false;
			document.form1.txtENO_NM5.readOnly = false;
  			document.form1.txtENO_NM5.className = "";

  		}

  		function enableInput2(){

			document.form1.txtENO_NO1.readOnly = false;
  			document.form1.txtENO_NO1.className = "";
  			document.getElementById("imgENO_NO1").disabled = false;

			document.form1.txtENO_NO2.readOnly = false;
  			document.form1.txtENO_NO2.className = "";
  			document.getElementById("imgENO_NO2").disabled = false;

			document.form1.txtENO_NO3.readOnly = false;
  			document.form1.txtENO_NO3.className = "";
  			document.getElementById("imgENO_NO3").disabled = false;

			document.form1.txtENO_NO4.readOnly = false;
  			document.form1.txtENO_NO4.className = "";
  			document.getElementById("imgENO_NO4").disabled = false;

			document.form1.txtENO_NO5.readOnly = false;
  			document.form1.txtENO_NO5.className = "";
  			document.getElementById("imgENO_NO5").disabled = false;

  		}

        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
         ********************************************/
  		function disableInput1(){

  			document.getElementById("cmbJOB_CD1").disabled = true;
			document.form1.txtENO_NM1.readOnly = true;
  			document.form1.txtENO_NM1.className = "input_ReadOnly";

  			document.getElementById("cmbJOB_CD2").disabled = true;
			document.form1.txtENO_NM2.readOnly = true;
  			document.form1.txtENO_NM2.className = "input_ReadOnly";

  			document.getElementById("cmbJOB_CD3").disabled = true;
			document.form1.txtENO_NM3.readOnly = true;
  			document.form1.txtENO_NM3.className = "input_ReadOnly";

  			document.getElementById("cmbJOB_CD4").disabled = true;
			document.form1.txtENO_NM4.readOnly = true;
  			document.form1.txtENO_NM4.className = "input_ReadOnly";

  			document.getElementById("cmbJOB_CD5").disabled = true;
			document.form1.txtENO_NM5.readOnly = true;
  			document.form1.txtENO_NM5.className = "input_ReadOnly";

  		}

  		function disableInput2(){

			document.form1.txtENO_NO1.readOnly = true;
  			document.form1.txtENO_NO1.className = "input_ReadOnly";
  			document.getElementById("imgENO_NO1").disabled = true;

			document.form1.txtENO_NO2.readOnly = true;
  			document.form1.txtENO_NO2.className = "input_ReadOnly";
  			document.getElementById("imgENO_NO2").disabled = true;

			document.form1.txtENO_NO3.readOnly = true;
  			document.form1.txtENO_NO3.className = "input_ReadOnly";
  			document.getElementById("imgENO_NO3").disabled = true;

			document.form1.txtENO_NO4.readOnly = true;
  			document.form1.txtENO_NO4.className = "input_ReadOnly";
  			document.getElementById("imgENO_NO4").disabled = true;

			document.form1.txtENO_NO5.readOnly = true;
  			document.form1.txtENO_NO5.className = "input_ReadOnly";
  			document.getElementById("imgENO_NO5").disabled = true;

  		}

  		function fnc_CheckEMP(obj){

  			var num = obj.name.substring(6,7);
			var chk = obj.checked;

  			document.getElementById("cmbJOB_CD"+num).value = "";
			document.getElementById("txtENO_NM"+num).value = "";
			document.getElementById("txtENO_NO"+num).value = "";
			dsTemp.NameValue(1,"COM_NM"+num) = "";

			fnc_UserSum();

			if(chk == true){
	  			document.getElementById("cmbJOB_CD"+num).disabled = false;
				document.getElementById("txtENO_NM"+num).readOnly = false;
	  			document.getElementById("txtENO_NM"+num).className = "";

				document.getElementById("txtENO_NO"+num).readOnly = true;
	  			document.getElementById("txtENO_NO"+num).className = "input_ReadOnly";
	  			document.getElementById("imgENO_NO"+num).disabled = true;
  			}else{
	  			document.getElementById("cmbJOB_CD"+num).disabled = true;
				document.getElementById("txtENO_NM"+num).readOnly = true;
	  			document.getElementById("txtENO_NM"+num).className = "input_ReadOnly";

				document.getElementById("txtENO_NO"+num).readOnly = false;
	  			document.getElementById("txtENO_NO"+num).className = "";
	  			document.getElementById("imgENO_NO"+num).disabled = false;
  			}

  		}

  		function fnc_UserSum(){

			var eno_nm1 = document.form1.txtENO_NM1.value.length;
			var eno_nm2 = document.form1.txtENO_NM2.value.length;
			var eno_nm3 = document.form1.txtENO_NM3.value.length;
			var eno_nm4 = document.form1.txtENO_NM4.value.length;
			var eno_nm5 = document.form1.txtENO_NM5.value.length;
			var COM_CNT = 0;

			if(eno_nm1 != 0){
				COM_CNT = COM_CNT + 1;
			}

			if(eno_nm2 != 0){
				COM_CNT = COM_CNT + 1;
			}

			if(eno_nm3 != 0){
				COM_CNT = COM_CNT + 1;
			}

			if(eno_nm4 != 0){
				COM_CNT = COM_CNT + 1;
			}

			if(eno_nm5 != 0){
				COM_CNT = COM_CNT + 1;
			}



			document.getElementById("txtCOM_CNT").value = COM_CNT;

		}

		function fnc_LoadData(){

			var cnt = parseInt(dsTemp.NameValue(1,"COM_CNT"));

			document.getElementById("txtCOM_CNT").value = cnt;

			for(var i=1; i<=cnt; i++){
				if(dsTemp.NameValue(1,"COM_NO"+i).trim().length != 8){
					document.getElementById("chkEMP"+i).checked = true;

		  			document.getElementById("cmbJOB_CD"+i).disabled = false;
					document.getElementById("txtENO_NM"+i).readOnly = false;
		  			document.getElementById("txtENO_NM"+i).className = "";

					document.getElementById("txtENO_NO"+i).readOnly = true;
		  			document.getElementById("txtENO_NO"+i).className = "input_ReadOnly";
		  			document.getElementById("imgENO_NO"+i).disabled = true;

		  			document.getElementById("cmbJOB_CD"+i).value = dsTemp.NameValue(1,"COM_CD"+i);
					document.getElementById("txtENO_NM"+i).value = dsTemp.NameValue(1,"COM_NAM"+i);

				}else{
					document.getElementById("chkEMP"+i).checked = false;

		  			document.getElementById("cmbJOB_CD"+i).disabled = true;
					document.getElementById("txtENO_NM"+i).readOnly = true;
		  			document.getElementById("txtENO_NM"+i).className = "input_ReadOnly";

					document.getElementById("txtENO_NO"+i).readOnly = false;
		  			document.getElementById("txtENO_NO"+i).className = "";
		  			document.getElementById("imgENO_NO"+i).disabled = false;

		  			if(dsTemp.NameValue(1,"COM_NO"+i).trim().length == 8){
			  			document.getElementById("cmbJOB_CD"+i).value = dsTemp.NameValue(1,"COM_CD"+i);
						document.getElementById("txtENO_NM"+i).value = dsTemp.NameValue(1,"COM_NAM"+i);
						document.getElementById("txtENO_NO"+i).value = dsTemp.NameValue(1,"COM_NO"+i);
		  			}

				}

			}

			for(var i=cnt+1; i<=5; i++){
				document.getElementById("chkEMP"+i).checked = false;

	  			document.getElementById("cmbJOB_CD"+i).disabled = true;
				document.getElementById("txtENO_NM"+i).readOnly = true;
	  			document.getElementById("txtENO_NM"+i).className = "input_ReadOnly";

				document.getElementById("txtENO_NO"+i).readOnly = false;
	  			document.getElementById("txtENO_NO"+i).className = "";
	  			document.getElementById("imgENO_NO"+i).disabled = false;
			}

		}

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 직위 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="A2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


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
	                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">동행인입력</td>
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
            	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_ConductOver.gif',1)">    <img src="../../images/button/btn_ConductOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Confirm()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>
	        </td>
	    </tr>
	</table>
	<!-- 버튼 테이블 끝 -->

    <!-- 조건 입력 테이블 시작 -->
	<table width="450" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop8"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
				<strong>동행인1</strong>
				<!-- &nbsp;<input type="checkbox" id="chkEMP1" name="chkEMP1" style="border:0" align="absmiddle" onclick="fnc_CheckEMP(this)">외부직원 -->
			</td>
	    </tr>
		<tr>
		    <td>
				<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
					<colgroup>
						<col width="50"></col>
						<col width="110"></col>
						<col width="50"></col>
						<col width="97"></col>
						<col width="50"></col>
						<col width="*"></col>
					</colgroup>
                    <tr>
						<td align="center" class="blueBold">직&nbsp;위</td>
						<td class="padding2423">
                            <select id="cmbJOB_CD1" style="WIDTH:105">
                                <option value=""></option>
                            </select>
						</td>
						<td align="center" class="blueBold">사&nbsp;번</td>
						<td class="padding2423">
							<input id=txtENO_NO1 name=txtENO_NO1 size="9" maxlength="8" style="ime-mode:disabled" onkeypress="cfNumberCheck();" onChange="fnc_GetUserInfo('1');">
							<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO1','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgENO_NO1" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup('1');"></a>
						</td>
						<td align="center" class="blueBold">성&nbsp;명</td>
						<td class="padding2423">
							<input id=txtENO_NM1 name=txtENO_NM1 size="8" onKeyUp="fc_chk_byte(this,8);fnc_UserSum()">
						</td>
                    </tr>
				</table>
			</td>
		</tr>
	</table>

	<table width="450" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop8"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
				<strong>동행인2</strong>
				<!-- &nbsp;<input type="checkbox" id="chkEMP2" name="chkEMP2" style="border:0" align="absmiddle" onclick="fnc_CheckEMP(this)">외부직원 -->
			</td>
	    </tr>
		<tr>
		    <td>
				<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
					<colgroup>
						<col width="50"></col>
						<col width="110"></col>
						<col width="50"></col>
						<col width="97"></col>
						<col width="50"></col>
						<col width="*"></col>
					</colgroup>
                    <tr>
						<td align="center" class="blueBold">직&nbsp;위</td>
						<td class="padding2423">
                            <select id="cmbJOB_CD2" style="WIDTH:105">
                                <option value=""></option>
                            </select>
						</td>
						<td align="center" class="blueBold">사&nbsp;번</td>
						<td class="padding2423">
							<input id=txtENO_NO2 name=txtENO_NO2 size="9" maxlength="8" style="ime-mode:disabled" onkeypress="cfNumberCheck();" onChange="fnc_GetUserInfo('2');">
							<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO2','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgENO_NO2" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup('2');"></a>
						</td>
						<td align="center" class="blueBold">성&nbsp;명</td>
						<td class="padding2423">
							<input id=txtENO_NM2 name=txtENO_NM2 size="8" onKeyUp="fc_chk_byte(this,8);fnc_UserSum()">
						</td>
                    </tr>
				</table>
			</td>
		</tr>
	</table>

	<table width="450" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop8"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>동행인3</strong>
				<!-- &nbsp;<input type="checkbox" id="chkEMP3" name="chkEMP3" style="border:0" align="absmiddle" onclick="fnc_CheckEMP(this)">외부직원 -->
			</td>
	    </tr>
		<tr>
		    <td>
				<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
					<colgroup>
						<col width="50"></col>
						<col width="110"></col>
						<col width="50"></col>
						<col width="97"></col>
						<col width="50"></col>
						<col width="*"></col>
					</colgroup>
                    <tr>
						<td align="center" class="blueBold">직&nbsp;위</td>
						<td class="padding2423">
                            <select id="cmbJOB_CD3" style="WIDTH:105">
                                <option value=""></option>
                            </select>
						</td>
						<td align="center" class="blueBold">사&nbsp;번</td>
						<td class="padding2423">
							<input id=txtENO_NO3 name=txtENO_NO3 size="9" maxlength="8" style="ime-mode:disabled" onkeypress="cfNumberCheck();" onChange="fnc_GetUserInfo('3');">
							<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO3','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgENO_NO3" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup('3');"></a>
						</td>
						<td align="center" class="blueBold">성&nbsp;명</td>
						<td class="padding2423">
							<input id=txtENO_NM3 name=txtENO_NM3 size="8" onKeyUp="fc_chk_byte(this,8);fnc_UserSum()">
						</td>
                    </tr>
				</table>
			</td>
		</tr>
	</table>

	<table width="450" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop8"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
				<strong>동행인4</strong>
				<!-- &nbsp;<input type="checkbox" id="chkEMP4" name="chkEMP4" style="border:0" align="absmiddle" onclick="fnc_CheckEMP(this)">외부직원 -->
				</td>
	    </tr>
		<tr>
		    <td>
				<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
					<colgroup>
						<col width="50"></col>
						<col width="110"></col>
						<col width="50"></col>
						<col width="97"></col>
						<col width="50"></col>
						<col width="*"></col>
					</colgroup>
                    <tr>
						<td align="center" class="blueBold">직&nbsp;위</td>
						<td class="padding2423">
                            <select id="cmbJOB_CD4" style="WIDTH:105">
                                <option value=""></option>
                            </select>
						</td>
						<td align="center" class="blueBold">사&nbsp;번</td>
						<td class="padding2423">
							<input id=txtENO_NO4 name=txtENO_NO4 size="9" maxlength="8" style="ime-mode:disabled" onkeypress="cfNumberCheck();" onChange="fnc_GetUserInfo('4');">
							<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO4','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgENO_NO4" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup('4');"></a>
						</td>
						<td align="center" class="blueBold">성&nbsp;명</td>
						<td class="padding2423">
							<input id=txtENO_NM4 name=txtENO_NM4 size="8" onKeyUp="fc_chk_byte(this,8);fnc_UserSum()">
						</td>
                    </tr>
				</table>
			</td>
		</tr>
	</table>
	<table width="450" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop8"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>동행인5</strong>
				<!-- &nbsp;<input type="checkbox" id="chkEMP5" name="chkEMP5" style="border:0" align="absmiddle" onclick="fnc_CheckEMP(this)">외부직원 -->
			</td>
		</tr>
		<tr>
		    <td>
				<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
					<colgroup>
						<col width="50"></col>
						<col width="110"></col>
						<col width="50"></col>
						<col width="97"></col>
						<col width="50"></col>
						<col width="*"></col>
					</colgroup>
                    <tr>
						<td align="center" class="blueBold">직&nbsp;위</td>
						<td class="padding2423">
                            <select id="cmbJOB_CD5" style="WIDTH:105">
                                <option value=""></option>
                            </select>
						</td>
						<td align="center" class="blueBold">사&nbsp;번</td>
						<td class="padding2423">
							<input id=txtENO_NO5 name=txtENO_NO5 size="9" maxlength="8" style="ime-mode:disabled" onkeypress="cfNumberCheck();" onChange="fnc_GetUserInfo('5');">
							<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO5','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgENO_NO5" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup('5');"></a>
						</td>
						<td align="center" class="blueBold">성&nbsp;명</td>
						<td class="padding2423">
							<input id=txtENO_NM5 name=txtENO_NM5 size="8" onKeyUp="fc_chk_byte(this,8);fnc_UserSum()">
						</td>
                    </tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->

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
		    <td class="paddingTop8" align="right">
		    	<b>&nbsp;인원수 :&nbsp;<input id=txtCOM_CNT name=txtCOM_CNT maxLength="2" style="WIDTH:80;text-align:right;ime-mode:disabled" onkeypress="cfNumberCheck();" class="input_ReadOnly" readOnly> 명</b>
		    </td>
		</tr>
	</table>
	<!-- 조회 상태 테이블 끝 -->

	</form>
	<!-- form 끝 -->

</body>
</html>