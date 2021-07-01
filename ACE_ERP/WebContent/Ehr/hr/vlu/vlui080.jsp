<!--
*****************************************************
* @source       : vlui080.jsp
* @description  : 고과자지정(상향) PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2012/04/02      이동훈        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>고과자지정(상향)(vlui080)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'TFTTTFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";
		var cntchk = "N";
		var j=0;


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

          //검색조건 4가지
          var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //해당년도
          var DPT_CD_SHR = document.form1.txtDPT_CD_SHR.value;        //소속
          var JOB_CD_SHR = document.form1.txtJOB_CD_SHR.value;        //직위
          var ENO_NO_SHR = document.form1.txtENO_NO_SHR.value;        //사번s

		  dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui080.cmd.VLUI080CMD&S_MODE=SHR&REG_YM_SHR="+REG_YM_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
		  dsT_EV_ABLRST.reset();

        }

        function fnc_SearchList2() {

          //검색조건 6가지
          var REG_YM_SHR = document.form1.txtREG_YM_SHR.value;        //해당년도
          var DPT_CD_SHR = document.form1.txtDPT_CD_SHR.value;        //소속
          var JOB_CD_SHR = document.form1.txtJOB_CD_SHR.value;        //직위
          var ENO_NO_SHR = document.form1.txtENO_NO_SHR.value;        //사번
          var ENO_NOH = document.form1.txtENO_NO.value;        		  //고과자
          var EVA_SEQ = document.form1.cmbEVA_SEQ.value;        	  //차수

		  dsT_EV_ABLRST2.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui080.cmd.VLUI080CMD&S_MODE=SHR_01&REG_YM_SHR="+REG_YM_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR+"&ENO_NOH="+ENO_NOH+"&EVA_SEQ="+EVA_SEQ;
		  dsT_EV_ABLRST2.reset();

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

			if (dsT_EV_ABLRST2.countrow<1){
				alert ("저장할 정보가 없습니다.");
			}else {
				if(fnc_Chk()){

					if(fnc_Chk2()){

					  if (confirm("저장하시겠습니까?")) {

			            trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST2=dsT_EV_ABLRST2)";
			            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.i.vlui080.cmd.VLUI080CMD&S_MODE=SAV";
			            trT_EV_ABLRST.post();
						}
					}
				}
        	}
        }

		/******************************************************************************
			Description : 고과자 지정 저장시 체크
		    dsT_EV_ABLRST2.namevalue(i, "CHKOUT")=="T"  : 고과자 제외
		    UserStatus(i)=2  -- Delete
		******************************************************************************/

		function fnc_Chk(){

			for(i=1; i<=dsT_EV_ABLRST2.countrow;i++){
				if (dsT_EV_ABLRST2.namevalue(i, "CHKOUT")=="T") {
					dsT_EV_ABLRST2.UserStatus(i)=2;
				}
			}
			return true;
		}

		/******************************************************************************
			Description : 고과자 수정시 발생
		******************************************************************************/
		function fnc_Chk2(){

			for(i=1; i<=dsT_EV_ABLRST2.countrow;i++){
				for ( j=1;j<=dsT_EV_ABLRST2.countrow;j++){
					if(i!=j){
						if ((dsT_EV_ABLRST2.namevalue(i,"EMPNO"))==(dsT_EV_ABLRST2.namevalue(j,"EMPNO")) && (dsT_EV_ABLRST2.namevalue(i,"EVASEQ"))==(dsT_EV_ABLRST2.namevalue(j,"EVASEQ"))){
								alert("동일 피고과자의  고과자 차수가 동일합니다.");
								return false;
								break;
						}
					}
		    	}
			}
			return true;
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

            if (dsT_EV_ABLRST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("고과자지정(상향)", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            //이곳에 해당 코딩을 입력 하세요

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

            var f = document.form1;

            f.txtJOB_CD_SHR.value = '';
            f.txtJOB_NM_SHR.value = '';
            f.txtDPT_CD_SHR.value = '';
            f.txtDPT_NM_SHR.value = '';
            f.txtENO_NO_SHR.value = '';
            f.txtENO_NM_SHR.value = '';
            f.txtENO_NO.value = '';
            f.txtENO_NM.value = '';
            f.cmbEVA_SEQ.value = '';

            dsT_EV_ABLRST.ClearData();
            dsT_EV_ABLRST2.ClearData();

            document.getElementById("resultMessage").innerText = ' ';

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_ABLRST.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck(year) {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            if (!dsT_EV_ABLRST.IsUpdated) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }
            return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

		document.getElementById("loctitle").innerText = "HOME/인사평가/고과평가/";

		document.getElementById("txtREG_YM_SHR").value = getToday().substring(0,7);

        cfStyleGrid(form1.grdT_EV_ABLRST,15,"true","false");      // Grid Style 적용
        cfStyleGrid(form1.grdT_EV_ABLRST2,15,"true","false");      // Grid Style 적용


        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }


        /******************************
         * 16. 초기화                  *
         ******************************/
        function fnc_Reset(p) {

			if(p=="r"){
				if (dsT_EV_ABLRST2.countrow>=1){
					dsT_EV_ABLRST2.ClearData();
		            document.form1.txtJOB_CD_SHR.value = '';
		            document.form1.txtJOB_NM_SHR.value = '';
		            document.form1.txtDPT_CD_SHR.value = '';
		            document.form1.txtDPT_NM_SHR.value = '';
		            document.form1.txtENO_NO_SHR.value = '';
		            document.form1.txtENO_NM_SHR.value = '';
		            document.form1.txtENO_NO.value = '';
		            document.form1.txtENO_NM.value = '';
		            document.form1.cmbEVA_SEQ.value = '';
				}else{
		            document.form1.txtJOB_CD_SHR.value = '';
		            document.form1.txtJOB_NM_SHR.value = '';
		            document.form1.txtDPT_CD_SHR.value = '';
		            document.form1.txtDPT_NM_SHR.value = '';
		            document.form1.txtENO_NO_SHR.value = '';
		            document.form1.txtENO_NM_SHR.value = '';
		            document.form1.txtENO_NO.value = '';
		            document.form1.txtENO_NM.value = '';
		            document.form1.cmbEVA_SEQ.value = '';
					alert("초기화 할 데이터가 존재하지 않습니다.");
				}
			}else if(p=="q"){
				if (dsT_EV_ABLRST2.countrow>=1) dsT_EV_ABLRST2.ClearData();
			}

        }

        /******************************
         * 17. 고과자 지정             *
         ******************************/
        function fnc_Appoint() {

					if (dsT_EV_ABLRST.countrow > 0 ) {

						if  (fnc_Appoint_Chk()){

							for ( i=1;i<=dsT_EV_ABLRST.countrow;i++){

								if (dsT_EV_ABLRST.namevalue(i,"CHK") =="T"){

												fnc_Header_create();

												dsT_EV_ABLRST2.addrow();

												j = dsT_EV_ABLRST2.countrow;

												dsT_EV_ABLRST2.namevalue(j,"CHKOUT") = "F";
												dsT_EV_ABLRST2.namevalue(j,"EVAYM") =  document.form1.txtREG_YM_SHR.value.replace("-","");
												dsT_EV_ABLRST2.namevalue(j,"EMPNOH") = document.form1.txtENO_NO.value ;        			//고과자
												dsT_EV_ABLRST2.namevalue(j,"EMPNMKH") = document.form1.txtENO_NM.value ;       			//고과자명
												dsT_EV_ABLRST2.namevalue(j,"EVASEQ"  ) = document.getElementById("cmbEVA_SEQ").value;   //차수
												dsT_EV_ABLRST2.namevalue(j,"EMPNO") = dsT_EV_ABLRST.namevalue(i,"EMPNO") ;   			//피고과자
												dsT_EV_ABLRST2.namevalue(j,"EMPNMK") = dsT_EV_ABLRST.namevalue(i,"EMPNMK") ; 			//피고과자명

							                    //고과자정보
												dsT_EV_ABLRST2.namevalue(j,"DEPTCD") = document.form1.txtDPT_CD.value ; 			//소속코드
												dsT_EV_ABLRST2.namevalue(j,"DEPTNM") = document.form1.txtDPT_NM.value ; 			//소속명
												dsT_EV_ABLRST2.namevalue(j,"PAYGRD") = document.form1.txtJOB_CD.value ; 			//직위코드
												dsT_EV_ABLRST2.namevalue(j,"PAYGRDNM") = document.form1.txtJOB_NM.value ; 			//직위명
												//dsT_EV_ABLRST2.namevalue(j,"STRTDT") = txt_strtdt.value; 			//입사일

												fnc_Evaseq(i, document.getElementById("cmbEVA_SEQ").value, document.form1.txtENO_NM.value);

								}
							} //for
						}

					}else{
						alert("데이터가 존재하지 않습니다");
					}

        }

        /******************************
         * 18. 고과자 지정 체크       *
         ******************************/

		function fnc_Appoint_Chk(){

			var seq1="9",seq2="9",seq3="9",seq4="9",seq5="9",seq6="9",seq7="9",seq8="9",seq9="9",seq10="9" ;
		  	var seq11="9", seq12="9",seq13="9",seq14="9",seq15="9", seq16="9",seq17="9",seq18="9",seq19="9", seq20="9" ;
		  	var seq21="9", seq22="9",seq23="9",seq24="9",seq25="9", seq26="9",seq27="9",seq28="9",seq29="9", seq30="9";
		  	var seq31="9", seq32="9",seq33="9",seq34="9",seq35="9", seq36="9",seq37="9",seq38="9",seq39="9", seq40="9";
		  	var seq41="9", seq42="9",seq43="9",seq44="9",seq45="9", seq46="9",seq47="9",seq48="9",seq49="9", seq50="9";
		  	var seq51="9", seq52="9",seq53="9",seq54="9",seq55="9", seq56="9",seq57="9",seq58="9",seq59="9", seq60="9";

			var seq_val = document.getElementById("cmbEVA_SEQ").value;

			for ( i=1;i<=dsT_EV_ABLRST.countrow;i++){
				if (dsT_EV_ABLRST.namevalue(i,"CHK") =="T")
					cntchk = "Y";
			}

			i= 0 ;

			if (cntchk =="N"){
				alert("선택된 피고과자가 없습니다.");
				return;
			}

			cntchk = "N";

			if (document.form1.txtENO_NO.value == "" &&  document.form1.txtENO_NM.value == "") {
				alert( "고과자가 존재하지 않습니다.")
				return false;
			}

			if (seq_val=="0") {
				alert( "차수가 존재하지 않습니다.")
				return false;
			}

			for ( i=1;i<=dsT_EV_ABLRST.countrow;i++){

				if ( dsT_EV_ABLRST.namevalue(i,"CHK") =="T"){

					if(dsT_EV_ABLRST.namevalue(i,"EMPNO") == document.form1.txtENO_NO.value){

						alert("피고과자와 고과자가 동일합니다");

						return false ;

					}else{

						if  (dsT_EV_ABLRST2.countrow>0 ){

							for ( j=1;j<=dsT_EV_ABLRST2.countrow;j++){

								if((dsT_EV_ABLRST2.namevalue(j,"EVASEQ")==document.getElementById("cmbEVA_SEQ").value) &&   (dsT_EV_ABLRST2.namevalue(j,"EMPNO")==dsT_EV_ABLRST.namevalue(i,"EMPNO"))) {

									alert("동일 피고과자의  고과자 차수가 동일합니다.");

									return false;

									break;

								 }//if

								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK1")!="")) seq1="1";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK2")!="")) seq2="2";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK3")!="")) seq3="3";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK4")!="")) seq4="4";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK5")!="")) seq5="5";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK6")!="")) seq6="6";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK7")!="")) seq7="7";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK8")!="")) seq8="8";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK9")!="")) seq9="9";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK10")!="")) seq10="10";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK11")!="")) seq11="11";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK12")!="")) seq12="12";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK13")!="")) seq13="13";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK14")!="")) seq14="14";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK15")!="")) seq15="15";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK16")!="")) seq16="16";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK17")!="")) seq17="17";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK18")!="")) seq18="18";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK19")!="")) seq19="19";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK20")!="")) seq20="20";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK21")!="")) seq21="21";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK22")!="")) seq22="22";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK23")!="")) seq23="23";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK24")!="")) seq24="24";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK25")!="")) seq25="25";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK26")!="")) seq26="26";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK27")!="")) seq27="27";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK28")!="")) seq28="28";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK29")!="")) seq28="29";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK30")!="")) seq30="30";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK31")!="")) seq31="31";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK32")!="")) seq32="32";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK33")!="")) seq33="33";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK34")!="")) seq44="34";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK35")!="")) seq35="35";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK36")!="")) seq36="36";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK37")!="")) seq37="37";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK38")!="")) seq38="38";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK39")!="")) seq39="39";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK40")!="")) seq40="40";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK41")!="")) seq41="41";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK42")!="")) seq42="42";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK43")!="")) seq43="43";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK44")!="")) seq44="44";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK45")!="")) seq45="45";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK46")!="")) seq46="46";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK47")!="")) seq47="47";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK48")!="")) seq48="48";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK49")!="")) seq49="49";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK50")!="")) seq50="50";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK51")!="")) seq51="51";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK52")!="")) seq52="52";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK53")!="")) seq53="53";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK54")!="")) seq54="54";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK55")!="")) seq55="55";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK56")!="")) seq56="56";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK57")!="")) seq57="57";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK58")!="")) seq58="58";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK59")!="")) seq59="59";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK60")!="")) seq60="60";

								if ((seq1==seq_val)||(seq2==seq_val)||(seq3==seq_val)||(seq4==seq_val)||(seq5==seq_val)||(seq6==seq_val)||(seq7==seq_val)
								||(seq8==seq_val)||(seq9==seq_val)||(seq10==seq_val)||(seq11==seq_val)||(seq12==seq_val)||(seq13==seq_val)||(seq14==seq_val)
								||(seq15==seq_val)||(seq16==seq_val)||(seq17==seq_val)||(seq18==seq_val)||(seq19==seq_val)||(seq20==seq_val)||(seq21==seq_val)
								||(seq22==seq_val)||(seq23==seq_val)||(seq24==seq_val)||(seq25==seq_val)||(seq26==seq_val)||(seq27==seq_val)||(seq28==seq_val)
								||(seq29==seq_val)||(seq30==seq_val)||(seq31==seq_val)||(seq32==seq_val)||(seq33==seq_val)||(seq34==seq_val)||(seq35==seq_val)
								||(seq36==seq_val)||(seq37==seq_val)||(seq38==seq_val)||(seq39==seq_val)||(seq40==seq_val)||(seq41==seq_val)||(seq42==seq_val)
								||(seq43==seq_val)||(seq44==seq_val)||(seq45==seq_val)||(seq46==seq_val)||(seq47==seq_val)||(seq48==seq_val)||(seq49==seq_val)
								||(seq50==seq_val)||(seq51==seq_val)||(seq52==seq_val)||(seq53==seq_val)||(seq54==seq_val)||(seq55==seq_val)||(seq56==seq_val)
								||(seq57==seq_val)||(seq58==seq_val)||(seq59==seq_val)||(seq60==seq_val)){
									alert("동일 차수가 존재합니다.");
									return false ;

								}
							}//for
						}else if(dsT_EV_ABLRST2.countrow<=0){

								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK1")!="")) seq1="1";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK2")!="")) seq2="2";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK3")!="")) seq3="3";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK4")!="")) seq4="4";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK5")!="")) seq5="5";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK6")!="")) seq6="6";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK7")!="")) seq7="7";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK8")!="")) seq8="8";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK9")!="")) seq9="9";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK10")!="")) seq10="10";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK11")!="")) seq11="11";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK12")!="")) seq12="12";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK13")!="")) seq13="13";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK14")!="")) seq14="14";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK15")!="")) seq15="15";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK16")!="")) seq16="16";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK17")!="")) seq17="17";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK18")!="")) seq18="18";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK19")!="")) seq19="19";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK20")!="")) seq20="20";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK21")!="")) seq21="21";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK22")!="")) seq22="22";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK23")!="")) seq23="23";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK24")!="")) seq24="24";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK25")!="")) seq25="25";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK26")!="")) seq26="26";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK27")!="")) seq27="27";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK28")!="")) seq28="28";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK29")!="")) seq28="29";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK30")!="")) seq30="30";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK31")!="")) seq31="31";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK32")!="")) seq32="32";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK33")!="")) seq33="33";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK34")!="")) seq44="34";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK35")!="")) seq35="35";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK36")!="")) seq36="36";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK37")!="")) seq37="37";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK38")!="")) seq38="38";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK39")!="")) seq39="39";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK40")!="")) seq40="40";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK41")!="")) seq41="41";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK42")!="")) seq42="42";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK43")!="")) seq43="43";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK44")!="")) seq44="44";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK45")!="")) seq45="45";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK46")!="")) seq46="46";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK47")!="")) seq47="47";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK48")!="")) seq48="48";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK49")!="")) seq49="49";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK50")!="")) seq50="50";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK51")!="")) seq51="51";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK52")!="")) seq52="52";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK53")!="")) seq53="53";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK54")!="")) seq54="54";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK55")!="")) seq55="55";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK56")!="")) seq56="56";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK57")!="")) seq57="57";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK58")!="")) seq58="58";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK59")!="")) seq59="59";
								if ((dsT_EV_ABLRST.namevalue(i,"EMPNMK60")!="")) seq60="60";

								if ((seq1==seq_val)||(seq2==seq_val)||(seq3==seq_val)||(seq4==seq_val)||(seq5==seq_val)||(seq6==seq_val)||(seq7==seq_val)
								||(seq8==seq_val)||(seq9==seq_val)||(seq10==seq_val)||(seq11==seq_val)||(seq12==seq_val)||(seq13==seq_val)||(seq14==seq_val)
								||(seq15==seq_val)||(seq16==seq_val)||(seq17==seq_val)||(seq18==seq_val)||(seq19==seq_val)||(seq20==seq_val)||(seq21==seq_val)
								||(seq22==seq_val)||(seq23==seq_val)||(seq24==seq_val)||(seq25==seq_val)||(seq26==seq_val)||(seq27==seq_val)||(seq28==seq_val)
								||(seq29==seq_val)||(seq30==seq_val)||(seq31==seq_val)||(seq32==seq_val)||(seq33==seq_val)||(seq34==seq_val)||(seq35==seq_val)
								||(seq36==seq_val)||(seq37==seq_val)||(seq38==seq_val)||(seq39==seq_val)||(seq40==seq_val)||(seq41==seq_val)||(seq42==seq_val)
								||(seq43==seq_val)||(seq44==seq_val)||(seq45==seq_val)||(seq46==seq_val)||(seq47==seq_val)||(seq48==seq_val)||(seq49==seq_val)
								||(seq50==seq_val)||(seq51==seq_val)||(seq52==seq_val)||(seq53==seq_val)||(seq54==seq_val)||(seq55==seq_val)||(seq56==seq_val)
								||(seq57==seq_val)||(seq58==seq_val)||(seq59==seq_val)||(seq60==seq_val)){

									alert("동일 차수가 존재합니다.");
									return false ;
							}
						}
					}
				}
			}

			if (document.form1.txtENO_NO.value=="") {
				alert( "차수가 존재하지 않습니다.")
				return false;
			}
			return true;
		}

        /******************************
         * 19. 데이타셋 헤드 설정       *
         ******************************/

		function fnc_Header_create(){

			if (dsT_EV_ABLRST2.countrow<1){
				var Header1= "CHKOUT:STRING,EVAYM:STRING, EMPNOH:STRING,EMPNMKH:STRING,EMPNO:STRING,EMPNMK:STRING,EVASEQ:DECIMAL,DEPTCD:STRING,DEPTNM:STRING,STRTDT:STRING, PAYGRD:STRING,PAYGRDNM:STRING, ODLEMPNOH:STRING, OLDEVASEQ:DECIMAL";
				dsT_EV_ABLRST2.SetDataHeader(Header1);
			}
		}

         /******************************
         * 19. 피고과자 차수 자동 설정 *
         ******************************/

		function fnc_Evaseq(i,seq, name){

			if (seq == "1" ) {
				dsT_EV_ABLRST.namevalue(i,"EMPNMK1") = name;
			}else if (seq == "2" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK2") = name;
			}else if (seq == "3" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK3") = name;
		    }else if (seq == "4" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK4") = name;
			}else if (seq == "5" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK5") = name;
			}else if (seq == "6" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK6") = name;
			}else if (seq == "7" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK7") = name;
		    }else if (seq == "8" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK8") = name;
			}else if (seq == "9" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK9") = name;
		    }else if (seq == "10" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK10") = name;
		    }else if (seq == "11" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK11") = name;
			}else if (seq == "12" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK12") = name;
		    }else if (seq == "13" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK13") = name;
			}else if (seq == "14" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK14") = name;
			}else if (seq == "15" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK15") = name;
			}else if (seq == "16" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK16") = name;
		    }else if (seq == "17" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK17") = name;
			}else if (seq == "18" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK18") = name;
		    }else if (seq == "19" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK19") = name;
		    }else if (seq == "20" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK20") = name;
		    }else if (seq == "21" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK21") = name;
			}else if (seq == "22" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK22") = name;
		    }else if (seq == "23" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK23") = name;
			}else if (seq == "24" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK24") = name;
			}else if (seq == "25" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK25") = name;
			}else if (seq == "26" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK26") = name;
		    }else if (seq == "27" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK27") = name;
			}else if (seq == "28" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK28") = name;
		    }else if (seq == "29" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK29") = name;
		    }else if (seq == "30" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK30") = name;
		    }else if (seq == "31" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK31") = name;
			}else if (seq == "32" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK32") = name;
		    }else if (seq == "33" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK33") = name;
			}else if (seq == "34" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK34") = name;
			}else if (seq == "35" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK35") = name;
			}else if (seq == "36" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK36") = name;
		    }else if (seq == "37" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK37") = name;
			}else if (seq == "38" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK38") = name;
		    }else if (seq == "39" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK39") = name;
		    }else if (seq == "40" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK40") = name;
		    }else if (seq == "41" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK41") = name;
			}else if (seq == "42" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK42") = name;
		    }else if (seq == "43" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK43") = name;
			}else if (seq == "44" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK44") = name;
			}else if (seq == "45" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK45") = name;
			}else if (seq == "46" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK46") = name;
		    }else if (seq == "47" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK47") = name;
			}else if (seq == "48" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK48") = name;
		    }else if (seq == "49" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK49") = name;
		    }else if (seq == "50" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK50") = name;
		    }else if (seq == "51" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK51") = name;
			}else if (seq == "52" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK52") = name;
		    }else if (seq == "53" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK53") = name;
			}else if (seq == "54" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK54") = name;
			}else if (seq == "55" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK55") = name;
			}else if (seq == "56" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK56") = name;
		    }else if (seq == "57" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK57") = name;
			}else if (seq == "58" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK58") = name;
		    }else if (seq == "59" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK59") = name;
		    }else if (seq == "60" ){
				dsT_EV_ABLRST.namevalue(i,"EMPNMK60") = name;

		  }

		}


       /***********************
       * 사원조회용 팝업 *
       **********************/
        function fnc_EmplPopp() {
			var obj = new String();
            obj.shr_kind = "SHR_01";
            obj.eno_nm = "";
            window.showModalDialog("/common/popup/empl2.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
            document.getElementById("txtENO_NO").value = obj.eno_no;
            document.getElementById("txtENO_NM").value = obj.eno_nm;
            document.getElementById("txtDPT_CD").value = obj.dpt_cd;
            document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            document.getElementById("txtJOB_CD").value = obj.job_cd;
            document.getElementById("txtJOB_NM").value = obj.job_nm;
		}

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->
    <!-----------------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                        |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ABLRST)                       |
    | 3. 사용되는 Table List(T_EV_ABLRST)                              |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ABLRST2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton            |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_ABLRST)        |
    | 3. 사용되는 Table List(T_EV_ABLRST)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_ABLRST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="sample_tr01(I:T_EV_ABLRST=T_EV_ABLRST)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->
    <!-----------------------------------------------------+
    | header를 클릭했을때 미반영 데이타 모두 체크
    +------------------------------------------------------>
    <script language="javascript"  for=grdT_EV_ABLRST event=OnHeadCheckClick(Col,Colid,bCheck)>

        if(Colid == "CHK" && dsT_EV_ABLRST.CountRow > 0) {
            for(var i=1; i<=dsT_EV_ABLRST.CountRow; i++) {
                if(dsT_EV_ABLRST.NameString(i, "CHK") == "F") {
                    dsT_EV_ABLRST.NameString(i, "CHK") = "T";
                } else if(dsT_EV_ABLRST.NameString(i, "CHK") == "T") {
                    dsT_EV_ABLRST.NameString(i, "CHK") = "F";
                }
            }
        }
    </script>


	<!-- 고과자지정에서 제외-->
	<script language=JavaScript for=grdT_EV_ABLRST2 event=OnClick(row,colid)>

		if (dsT_EV_ABLRST2.countrow<1) {
			return;
		}

		for(i=1;i<=dsT_EV_ABLRST2.countrow;i++){

			if(dsT_EV_ABLRST2.namevalue(i,"CHKOUT")=="T"){

				for(j=1;j<=dsT_EV_ABLRST.countrow;j++){

					if((dsT_EV_ABLRST2.namevalue(i,"EVAYM")==dsT_EV_ABLRST.namevalue(j,"EVAYM")) && (dsT_EV_ABLRST2.namevalue(i,"EMPNO")==dsT_EV_ABLRST.namevalue(j,"EMPNO"))){

						fnc_Evaseq(j, dsT_EV_ABLRST2.namevalue(i,"EVASEQ"), '');

						break;

				    }
				}
			}
		}
	</script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            alert("검색하신 조건의 자료가 없습니다.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
        } else {
            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">
        fnc_SearchList();
        fnc_SearchList2();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">
            cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">고과자지정(상향)</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">고과자지정(상향)</font></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image0','','/images/button/btn_CancelOver.gif',0)"><img src="/images/button/btn_CancelOn.gif" name="Image0" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','/images/button/btn_DeleteOver.gif',1)"> <img src="/images/button/btn_DeleteOn.gif"  name="Image9" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <colgroup>

	                            <col width="70"></col>
	                            <col width="60"></col>
	                            <col width="50"></col>
	                            <col width="130"></col>
	                            <col width="50"></col>
	                            <col width="130"></col>
	                            <col width="50"></col>
	                            <col width="*"></col>

                                </colgroup>
                            <tr>
                                <td class="searchState" align="right">고과년월&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onkeypress="cfDateHyphen(this);cfCheckNumber();" value="">
                               </td>
	                            <td class="searchState" align="right">소속별</td>
	                            <td class="padding2423" align="left">
	                                <input id="txtDPT_CD_SHR" size="3" maxlength="4">
	                                <input id="txtDPT_NM_SHR" style="width:50%" class="input_ReadOnly"  readonly>
	                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)">
	                                <img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
	                            </td>
	                            <td class="searchState" align="right">직위별</td>
	                            <td class="padding2423" align="left">
	                                <input id="txtJOB_CD_SHR" size="3" maxlength="4">
	                                <input id="txtJOB_NM_SHR" style="width:50%" class="input_ReadOnly"  readonly>
	                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJobCd','','/images/button/btn_HelpOver.gif',1)">
	                                <img src="/images/button/btn_HelpOn.gif" id="ImgJobCd" name="ImgJobCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_CD_SHR','txtJOB_NM_SHR','직위','A2')"></a>
	                            </td>
                                <td align="right" class="searchState">사번</td>
                                <td class="padding2423">
                                    <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10"  maxlength="10" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();"  onChange="fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR');">
                                    <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="12" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)">
                                    <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width="77%"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:395px;">
                                <param name="DataID"                 value="dsT_EV_ABLRST">
                                <param name="EdiTABLE"               value="true">
                                <param name="DragDropEnable"         value="true">
                                <param name="SortView"               value="Left">
                                <param name="VIEWSUMMARY"            value=0>
                                <param name="AutoReSizing"           value="true">
                                <param name=ColSizing  				 value="true">
                                <param name="Format"                 value="
                                    <FC> id='CHK'     		width=45   	name='선택'   Edit=True  		align=center    EditStyle=CheckBox  Pointer=Hand  Edit={IF(CHK='','false','true')}  HeadCheckShow=true </FC>
                                    <FG> name='피고과자'    HeadAlign=Center HeadBgColor=#F7DCBB
	                                    <FC> id='EMPNO'    	width=50   	name='사번'   		align=left    	edit=none </FC>
	                                    <FC> id='EMPNMK'   	width=50  	name='성명'  		align=left      edit=none </FC>
	                                </FG>
                                    <FC> id='DEPTNM'    	width=100  	name='소속'     align=left      edit=none </FC>
                                    <C> id='EMPNMK1'   		width=45  	name='1차;고과자'      	align=center    edit=none </C>
                                    <C> id='EMPNMK2'   		width=45  	name='2차;고과자'   	align=center    edit=none </C>
                                    <C> id='EMPNMK3'    	width=45   	name='3차;고과자'      	align=center    edit=none </C>
                                    <C> id='EMPNMK4'   		width=45  	name='4차;고과자'      	align=center    edit=none </C>
                                    <C> id='EMPNMK5'   		width=45  	name='5차;고과자'   	align=center    edit=none </C>
                                    <C> id='EMPNMK6'    	width=45   	name='6차;고과자'      	align=center    edit=none </C>
                                    <C> id='EMPNMK7'   		width=45  	name='7차;고과자'      	align=center    edit=none </C>
                                    <C> id='EMPNMK8'   		width=45  	name='8차;고과자'   	align=center    edit=none </C>
                                    <C> id='EMPNMK9'    	width=45   	name='9차;고과자'      	align=center    edit=none </C>
                                    <C> id='EMPNMK10'   	width=45  	name='10차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK11'   	width=45  	name='11차;고과자'   	align=center    edit=none </C>
                                    <C> id='EMPNMK12'    	width=45   	name='12차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK13'   	width=45  	name='13차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK14'   	width=45  	name='14차;고과자'   	align=center    edit=none </C>
                                    <C> id='EMPNMK15'    	width=45   	name='15차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK16'   	width=45  	name='16차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK17'   	width=45  	name='17차;고과자'   	align=center    edit=none </C>
                                    <C> id='EMPNMK18'    	width=45   	name='18차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK19'   	width=45  	name='19차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK20'   	width=45  	name='20차;고과자'   	align=center    edit=none </C>
                                    <C> id='EMPNMK21'    	width=45   	name='21차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK22'   	width=45  	name='22차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK23'   	width=45  	name='23차;고과자'   	align=center    edit=none </C>
                                    <C> id='EMPNMK24'    	width=45   	name='24차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK25'   	width=45  	name='25차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK26'   	width=45  	name='26차;고과자'   	align=center    edit=none </C>
                                    <C> id='EMPNMK27'    	width=45   	name='27차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK28'   	width=45  	name='28차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK29'   	width=45  	name='29차;고과자'   	align=center    edit=none </C>
                                    <C> id='EMPNMK30'    	width=45   	name='30차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK31'   	width=45  	name='31차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK32'   	width=45  	name='32차;고과자'   	align=center    edit=none </C>
                                    <C> id='EMPNMK33'    	width=45   	name='33차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK34'   	width=45  	name='34차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK35'   	width=45  	name='35차;고과자'   	align=center    edit=none </C>
                                    <C> id='EMPNMK36'    	width=45   	name='36차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK37'   	width=45  	name='37차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK38'   	width=45  	name='38차;고과자'   	align=center    edit=none </C>
                                    <C> id='EMPNMK39'    	width=45   	name='39차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK40'   	width=45  	name='40차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK41'   	width=45  	name='41차;고과자'   	align=center    edit=none </C>
                                    <C> id='EMPNMK42'    	width=45   	name='42차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK43'   	width=45  	name='43차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK44'   	width=45  	name='44차;고과자'   	align=center    edit=none </C>
                                    <C> id='EMPNMK45'    	width=45   	name='45차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK46'   	width=45  	name='46차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK47'   	width=45  	name='47차;고과자'   	align=center    edit=none </C>
                                    <C> id='EMPNMK48'    	width=45   	name='48차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK49'   	width=45  	name='49차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK50'   	width=45  	name='50차;고과자'   	align=center    edit=none </C>
                                    <C> id='EMPNMK51'    	width=45   	name='51차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK52'    	width=45   	name='52차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK53'   	width=45  	name='53차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK54'   	width=45  	name='54차;고과자'   	align=center    edit=none </C>
                                    <C> id='EMPNMK55'    	width=45   	name='55차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK56'   	width=45  	name='56차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK57'   	width=45  	name='57차;고과자'   	align=center    edit=none </C>
                                    <C> id='EMPNMK58'    	width=45   	name='58차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK59'   	width=45  	name='59차;고과자'      align=center    edit=none </C>
                                    <C> id='EMPNMK60'   	width=45  	name='60차;고과자'   	align=center    edit=none </C>

                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
            <td width=3>
            </td>



            <td class="paddingTop3">
                <table border="1" cellspacing="0" cellpadding="0">

                                <colgroup>

	                            <col width="50"></col>
	                            <col width="150"></col>
	                            <col width="50"></col>
	                            <col width="150"></col>

                    </colgroup>
					<tr>
						<td width=50  class="creamBold" border="1"><nobr>&nbsp;고과자지정</nobr></td>
						<td align=right  colspan=3><nobr>
				            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_Clear.gif',1)"><img src="/images/button/btn_Clear.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Reset('r')"></a>
				            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_Set.gif',1)"><img src="/images/button/btn_Set.gif" name="Image2" width="50" height="20" border="0" align="absmiddle" onClick="fnc_Appoint()"></a>
				            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList2()"></a>

					</tr>
					<tr>
						<td width=50  class="creamBold"><nobr>&nbsp;고과자&nbsp;</nobr></td>
						<td width=150>
							<input id="txtENO_NO" name="txtENO_NO" size="7" maxlength="7" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO','txtENO_NM');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO','txtENO_NM')" style="ime-mode:disabled">
							<input id="txtENO_NM" name="txtENO_NM" size="6" maxlength="10" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM','txtENO_NO');" onchange="fnc_GetEnoNo('txtENO_NM','txtENO_NO');fnc_SearchList();">
							<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgENO_NO','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgENO_NO" name="imgENO_NO" width="21" height="20" border="0" align="absmiddle" onclick="fnc_EmplPopp();"></a>
							<input type="hidden"  id="txtDPT_CD">
							<input type="hidden"  id="txtDPT_NM">
							<input type="hidden"  id="txtJOB_CD">
							<input type="hidden"  id="txtJOB_NM">
						<td width=50 class="creamBold"><nobr>&nbsp;차수</nobr></td>
						<td width=150>
								<select id="cmbEVA_SEQ" style="width:100">
									<option value=""> </option>
									<option value="1">1차</option>
									<option value="2">2차</option>
									<option value="3">3차</option>
									<option value="4">4차</option>
									<option value="5">5차</option>
									<option value="6">6차</option>
									<option value="7">7차</option>
									<option value="8">8차</option>
									<option value="9">9차</option>
									<option value="10">10차</option>
									<option value="11">11차</option>
									<option value="12">12차</option>
									<option value="13">13차</option>
									<option value="14">14차</option>
									<option value="15">15차</option>
									<option value="16">16차</option>
									<option value="17">17차</option>
									<option value="18">18차</option>
									<option value="19">19차</option>
									<option value="20">20차</option>
									<option value="21">21차</option>
									<option value="22">22차</option>
									<option value="23">23차</option>
									<option value="24">24차</option>
									<option value="25">25차</option>
									<option value="26">26차</option>
									<option value="27">27차</option>
									<option value="28">28차</option>
									<option value="29">29차</option>
									<option value="30">30차</option>
									<option value="31">31차</option>
									<option value="32">32차</option>
									<option value="33">33차</option>
									<option value="34">34차</option>
									<option value="35">35차</option>
									<option value="36">36차</option>
									<option value="37">37차</option>
									<option value="38">38차</option>
									<option value="39">39차</option>
									<option value="40">40차</option>
									<option value="41">41차</option>
									<option value="42">42차</option>
									<option value="43">43차</option>
									<option value="44">44차</option>
									<option value="45">45차</option>
									<option value="46">46차</option>
									<option value="47">47차</option>
									<option value="48">48차</option>
									<option value="49">49차</option>
									<option value="50">50차</option>
									<option value="51">51차</option>
									<option value="52">52차</option>
									<option value="53">53차</option>
									<option value="54">54차</option>
									<option value="55">55차</option>
									<option value="56">56차</option>
									<option value="57">57차</option>
									<option value="58">58차</option>
									<option value="59">59차</option>
									<option value="60">60차</option>
								</select>
						</td>
					</tr>


                    <tr align="center">
                        <td colspan=4>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_ABLRST2" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:340px;">
                                <param name="DataID"                 value="dsT_EV_ABLRST2">
                                <param name="EdiTABLE"               value="true">
                                <param name="DragDropEnable"         value="true">
                                <param name="SortView"               value="Left">
                                <param name="VIEWSUMMARY"            value=0>
                                <param name="AutoReSizing"           value="true">
                                <param name=ColSizing  				 value="true">
                                <param name="Format"                 value="
                                    <FC>id='CHKOUT'     		width=30   	name='제외'    		align=center    EditStyle=CheckBox  </FC>
                                    <FG>name='피고과자'    	HeadAlign=Center HeadBgColor=#F7DCBB
	                                    <FC> id='EMPNO'    		width=50   	name='사번'   		align=left    	edit=none </FC>
	                                    <FC> id='EMPNMK'   		width=50  	name='성명'  		align=left      edit=none </FC>
	                                </FG>
		                            <FG>name='고과자'    	HeadAlign=Center HeadBgColor=#F7DCBB
	                                    <FC>id='EMPNMKH'    	width=50  	name='성명'     	align=left      edit=none </FC>
	                                    <C>id='EVASEQ'   		width=50  	name='차수'      	align=center    edit=none </C>
	                                    <C>id='DEPTNM'   		width=80  	name='소속'   		align=left    	edit=none </C>
	                                    <C>id='PAYGRDNM'    	width=50   	name='직위'      	align=center    edit=none </C>
                                    </FG>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>

        </tr>
</table>
<!-- 내용 조회 그리드 데이블 끝-->

</form>
<!-- form 끝 -->
</body>
</html>


