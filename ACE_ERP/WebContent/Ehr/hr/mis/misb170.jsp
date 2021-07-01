<!--
*****************************************************
* @source       : misb170.jsp
* @description  : 직원변동조회 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/04/13      이승욱        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>직원변동조회(misb170)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >
    var nscp = (navigator.appName == "Netscape")

	//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
    var btnList = 'TFTTTTFT';

    /***********************************
     * 01. 조회 함수_List 형태의 조회  *
     ***********************************/
    function fnc_SearchList() {
        var f = document.form1;

        var OCC_CD   = document.getElementById("cmbOCC_CD_SHR").value;
        var str_ymd = f.txtSTR_YMD_SHR.value;
        var end_ymd = f.txtEND_YMD_SHR.value;
        var acc_cd  = f.hidGBN_OCC_CD.value;
        var gbn_case = f.hidGBN_GBN_CASE.value;
        var param;
        var check_place = '';

			//시작년월이 없으면 조회못함.
			if(str_ymd.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작년월을 입력하세요.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}
			//시작년월이 잘못되었으면 조회못함.
			if(str_ymd.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작년월이 잘못되었습니다.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}

			//종료년월이 없으면 조회못함.
			if(end_ymd.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("종료년월을 입력하세요.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}
			//종료년월이 잘못되었으면 조회못함.
			if(end_ymd.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("종료년월이 잘못되었습니다.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}

			//종료년월이 시작년월보다 크면 않된다.
			if(parseInt(end_ymd.replaceStr("-","")) < parseInt(str_ymd.replaceStr("-",""))){
				alert("종료년월이 시작년월보다 빠릅니다.");
				document.getElementById("txtEND_YMD_SHR").focus();
				return false;
			}

			document.body.style.cursor='wait';

            //데이터셋 전송
            dsT_CM_PERSON.DataID = "/servlet/GauceChannelSVL?cmd=hr.mis.b.misb170.cmd.MISB170CMD&S_MODE=SHR&STR_YMD_SHR="+str_ymd+"&END_YMD_SHR="+end_ymd+"&GBN_CASE="+gbn_case+"&OCC_CD="+OCC_CD;
            dsT_CM_PERSON.Reset();

            document.body.style.cursor='auto';

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

		if( !fnc_SaveItemCheck() )	return;

        var f = document.form1;
        var gbn_case = f.hidGBN_GBN_CASE.value;

        if(gbn_case == "R"){
			//트랜잭션 전송
			trT_CM_PERSON.KeyValue = "SVL(I:SAV=dsT_CM_PERSON)";
			trT_CM_PERSON.Action = "/servlet/GauceChannelSVL?cmd=hr.mis.b.misb170.cmd.MISB170CMD&S_MODE=SAV";
			trT_CM_PERSON.Post();
        }

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
        var f = document.form1;

        /*if ( f.flag.value == "Y" )
        {
             form1.aaa.RunButton('print_go');
        }
        else alert("문서조회 후 인쇄 하시기 바랍니다.");*/

        var OCC_CD   = document.getElementById("cmbOCC_CD_SHR").value;
        var str_ymd = f.txtSTR_YMD_SHR.value;
        var end_ymd = f.txtEND_YMD_SHR.value;
        var acc_cd  = f.hidGBN_OCC_CD.value;
        var gbn_case = f.hidGBN_GBN_CASE.value;
        var param;


			//시작년월이 없으면 조회못함.
			if(str_ymd.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작년월을 입력하세요.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}
			//시작년월이 잘못되었으면 조회못함.
			if(str_ymd.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작년월이 잘못되었습니다.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}

			//종료년월이 없으면 조회못함.
			if(end_ymd.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("종료년월을 입력하세요.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}
			//종료년월이 잘못되었으면 조회못함.
			if(end_ymd.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("종료년월이 잘못되었습니다.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}

			//종료년월이 시작년월보다 크면 않된다.
			if(parseInt(end_ymd.replaceStr("-","")) < parseInt(str_ymd.replaceStr("-",""))){
					alert("종료년월이 시작년월보다 빠릅니다.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
			}



        var url = "misb170_PV.jsp?str_ymd="+str_ymd+"&end_ymd="+end_ymd+"&OCC_CD="+OCC_CD+"&acc_cd="+acc_cd+"&gbn_case="+gbn_case;
        window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

    }

    /***********************
     * 06. 엑셀 저장 함수  *
     ***********************/
    function fnc_ToExcel() {

		var gbn_case = document.form1.hidGBN_GBN_CASE.value;

		if (dsT_CM_PERSON.CountRow < 1) {
		    alert("엑셀로 변환할 자료가 없습니다!");
		    return;
		}

		if(gbn_case == "H"){
			form1.grdT_CM_PERSON.GridToExcel("입사자현황", '', 225);
		}else if(gbn_case == "R"){
			form1.grdT_CM_PERSON.GridToExcel("퇴사자현황", '', 225);
		}else if(gbn_case == "J"){
			form1.grdT_CM_PERSON.GridToExcel("전보자현황", '', 225);
		}else if(gbn_case == "K"){
            form1.grdT_CM_PERSON.GridToExcel("휴직자현황", '', 225);
        }else if(gbn_case == "L"){
            form1.grdT_CM_PERSON.GridToExcel("근로구분변경자현황",'',225);
        }else if(gbn_case == "C"){
            form1.grdT_CM_PERSON.GridToExcel("조직개편대상자현황",'',225);
        }

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

		fnc_OnLoadProcess();
		dsT_CM_PERSON.ClearData();
		document.getElementById("resultMessage").innerText = ' ';
		document.getElementById('cmbOCC_CD_SHR').value = "";
		document.form1.rdoGBN_GBN_CASE[0].checked = true;
		document.form1.txtSTR_YMD_SHR.focus();

    }

    /************************
     * 11. 화면 종료(닫기)  *
     ***********************/
    function fnc_Exit() {

      frame = window.external.GetFrame(window);
      frame.CloseFrame();

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

		if (!dsT_CM_PERSON.IsUpdated) {
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

		fnc_ChangeGrid();      //그리드 변경 처리

		document.getElementById('txtSTR_YMD_SHR').value = getToday().substring(0,7)+"-01";
		document.getElementById('txtEND_YMD_SHR').value = getToday();

		//조치코드
		if(document.getElementById("cmbRETM_CD").length == 0){
			for( var i = 1; i <= dsT_CM_COMMON_CB.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
           	 	oOption.value = dsT_CM_COMMON_CB.NameValue(i,"CODE");
        	    oOption.text  = dsT_CM_COMMON_CB.NameValue(i,"CODE_NAME");
				document.getElementById("cmbRETM_CD").add(oOption);
			}
		}

     }

    /********************
    * 15. 단축키 처리  *
    *******************/
    function fnc_HotKey() {

      fnc_HotKey_Process(btnList, event.keyCode);

    }

    /********************************************
    * 날짜 형식 유효성 체크                     *
    ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('유효한 날짜가 아닙니다.');
                obj.focus();
            }
        }

    /********************************************
    * ez-gen 버튼 클릭 이벤트                   *
    ********************************************/
    function winclose()
    {
        window.close();
    }
    function goclick(x)
    {
        if( !document.form1.aaa.RunButton(x)) alert("개체가 없습니다.");
    }

        /*************************
         * 그리드 변경 처리               *
         ************************/
		function fnc_ChangeGrid() {
			var gbn_case = document.form1.hidGBN_GBN_CASE.value;
			dsT_CM_PERSON.ClearData();

			disableInput();

			if(gbn_case == "H"){  // 입사자
				form1.grdT_CM_PERSON.Format =   "<FC> id='{CUROW}'			width=29		name='NO'				align=center		value={String(Currow)}			</FC>" +
												"<FC> id='DPT_NM'			width=100		name='소속'				align=center										</FC>" +
												"<FC> id='JOB_NM'			width=60		name='직위'				align=center										</FC>" +
												"<FC> id='ENO_NO'			width=70		name='사번'				align=center										</FC>" +
												"<FC> id='ENO_NM'			width=70		name='성명' 			align=center										</FC>" +
												"<C> id='HOB_NM'			width=60		name='근로구분'			align=center										</C>" +
												"<C> id='CET_NO'            width=100       name='주민번호'         align=center                                        </C>" +
												"<C> id='AGE'				width=60		name='나이'				align=center										</C>" +
												"<C> id='SCH_NM'			width=120		name='학교'				align=center										</C>" +
												"<C> id='MAJ_NM'			width=120		name='전공'				align=center										</C>" +
												"<C> id='HIR_YMD'			width=80		name='입사일'			align=center										</C>" +
											    "<C> id='RET_YMD'			width=80		name='퇴사일'			align=center										</C>" +
												"<C> id='HIR_NM'			width=100		name='입사구분'			align=center										</C>" +
												"<C> id='ABA_NM'			width=90		name='은행명'			align=center										</C>" +
												"<C> id='ACC_NO'			width=120		name='계좌번호'			align=center										</C>";

				//첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
				//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
				cfStyleGrid(form1.grdT_CM_PERSON,0,"false","false");

			}else if(gbn_case == "R"){  // 퇴사자
				form1.grdT_CM_PERSON.Format =   "<FC> id='{CUROW}'			width=29		name='NO'				align=center		value={String(Currow)}			</FC>" +
												"<FC> id='DPT_NM'			width=100		name='소속'				align=center										</FC>" +
												"<FC> id='JOB_NM'			width=60		name='직위'				align=center										</FC>" +
												"<FC> id='ENO_NO'			width=70		name='사번'				align=center										</FC>" +
												"<FC> id='ENO_NM'			width=70		name='성명' 			align=center										</FC>" +
												"<C> id='HOB_NM'			width=60		name='근로구분'			align=center										</C>" +
												"<C> id='CET_NO'            width=100       name='주민번호'         align=center                                        </C>" +
												"<C> id='AGE'				width=60		name='나이'				align=center										</C>" +
												"<C> id='SCH_NM'			width=120		name='학교'				align=center										</C>" +
												"<C> id='MAJ_NM'			width=120		name='전공'				align=center										</C>" +
												"<C> id='HIR_YMD'			width=80		name='입사일'			align=center										</C>" +
												"<C> id='RET_YMD'			width=80		name='퇴사일'			align=center										</C>" +
												"<C> id='RET_NM'			width=100		name='퇴사구분'			align=center										</C>" +
                                                "<C> id='ABA_NM'            width=90       name='은행명'            align=center                                        </C>" +
                                                "<C> id='ACC_NO'            width=120       name='계좌번호'         align=center                                        </C>" +
												"<C> id='RETM_CD'			width=80		name='조치구분'			align=center		EditStyle=Lookup  Data='dsT_CM_COMMON_CB:CODE:CODE_NAME'	</C>" +
												"<C> id='RETM_REM'			width=120		name='조치자사번'		align=center										</C>" +
												"<C> id='RETM_REM_NM'		width=120		name='조치자성명'		align=center										</C>" +
												"<C> id='RETM_YMD'			width=80		name='조치일자'			align=center										</C>" +
												"<C> id='UPT_YMD'			width=80		name='수정일자'			align=center		show=false						</C>" ;

				//첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
				//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
				cfStyleGrid(form1.grdT_CM_PERSON,15,"false","false");

            }else if(gbn_case == "J"){  // 전보자
				form1.grdT_CM_PERSON.Format =   "<FC> id='{CUROW}'			width=29		name='NO'				align=center		value={String(Currow)}			</FC>" +
												"<FC> id='DPT_NM'			width=100		name='소속'				align=center							            </FC>" +
												"<FC> id='JOB_NM'			width=60		name='직위'				align=center	    				            	</FC>" +
												"<FC> id='ENO_NO'			width=70		name='사번'				align=center		                 				</FC>" +
												"<FC> id='ENO_NM'			width=70		name='성명' 			align=center										</FC>" +
												"<C> id='HOB_NM'			width=60		name='근로구분'				align=center										</C>" +
												"<C> id='CET_NO'            width=100       name='주민번호'         align=center                                        </C>" +
												"<C> id='AGE'				width=60		name='나이'				align=center										</C>" +
												"<C> id='SCH_NM'			width=120		name='학교'				align=center										</C>" +
												"<C> id='MAJ_NM'			width=120		name='전공'				align=center										</C>" +
												"<C> id='BF_DPT_NM'			width=120		name='이전부서'			align=center										</C>" +
												"<C> id='ADD_YMD'			width=80		name='발령일'			align=center										</C>" +
												"<C> id='HIR_YMD'			width=80		name='입사일'			align=center										</C>" +
												"<C> id='RET_YMD'			width=80		name='퇴사일'			align=center										</C>";

				//첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
				//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
				cfStyleGrid(form1.grdT_CM_PERSON,0,"false","false");

            }else if(gbn_case == "K"){  // 휴직자
                form1.grdT_CM_PERSON.Format =   "<C> id='{CUROW}'          width=30        name='NO'                align=center        value={String(Currow)}         </C>" +
                                                "<C> id='DPT_NM'           width=110       name='소속'              align=center        suppress = '6'                 </C>" +
                                                "<C> id='JOB_NM'           width=70        name='직위'              align=center        suppress = '5'                 </C>" +
                                                "<C> id='ENO_NO'           width=70        name='사번'              align=center        suppress = '4'                 </C>" +
                                                "<C> id='ENO_NM'           width=80        name='성명'              align=center        suppress = '3'                 </C>" +
                                                "<C> id='HIR_YMD'          width=80        name='입사일'            align=center        suppress = '2'                 </C>" +
                                                "<C> id='RET_YMD'          width=80        name='퇴사일'            align=center        suppress = '1'                 </C>" +
                                                "<C> id='STR_YMD'          width=80        name='시작일'            align=center                                       </C>" +
                                                "<C> id='END_YMD'          width=80        name='종료일'            align=center                                       </C>" +
                                                "<C> id='REMARK'           width=100       name='구분'              align=center                                       </C>";

                //첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
                //세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
                cfStyleGrid(form1.grdT_CM_PERSON,0,"false","false");

             }else if(gbn_case == "L"){  //근로구분변경자
                  form1.grdT_CM_PERSON.Format = "<C> id='{CUROW}'          width=30        name='NO'                align=center        value={String(Currow)}         </C>" +
                                                "<C> id='DPT_NM'           width=110       name='소속'              align=center                                       </C>" +
                                                "<C> id='JOB_NM'           width=70        name='직위'              align=center                                       </C>" +
                                                "<C> id='ENO_NO'           width=70        name='사번'              align=center                                       </C>" +
                                                "<C> id='ENO_NM'           width=80        name='성명'              align=center                                       </C>" +
                                                "<C> id='HIR_YMD'          width=80        name='입사일'            align=center                                       </C>" +
                                                "<C> id='RET_YMD'          width=80        name='퇴사일'            align=center                                       </C>" +
                                                "<C> id='APP_YMD'          width=80        name='근로구분변경일'        align=center                                       </C>" +
                                                "<C> id='OCC_CD'           width=180       name='내역'              align=center       value={decode(OCC_CD,'A','택배직->사무직','M','사무직->택배직')}  </C>" ;
                cfStyleGrid(form1.grdT_CM_PERSON,0,"false","false");

             }else if(gbn_case == "C"){  //조직개편대상자
				form1.grdT_CM_PERSON.Format =   "<FC> id='{CUROW}'			width=29		name='NO'				align=center		value={String(Currow)}			</FC>" +
												"<FC> id='DPT_NM'			width=100		name='소속'				align=center							            </FC>" +
												"<FC> id='JOB_NM'			width=60		name='직위'				align=center	    				            	</FC>" +
												"<FC> id='ENO_NO'			width=70		name='사번'				align=center		                 				</FC>" +
												"<FC> id='ENO_NM'			width=70		name='성명' 			align=center										</FC>" +
												"<C> id='HOB_NM'			width=60		name='근로구분'				align=center										</C>" +
												"<C> id='CET_NO'            width=100       name='주민번호'         align=center                                        </C>" +
												"<C> id='AGE'				width=60		name='나이'				align=center										</C>" +
												"<C> id='SCH_NM'			width=120		name='학교'				align=center										</C>" +
												"<C> id='MAJ_NM'			width=120		name='전공'				align=center										</C>" +
												"<C> id='BF_DPT_NM'			width=120		name='이전부서'			align=center										</C>" +
												"<C> id='ADD_YMD'			width=80		name='발령일'			align=center										</C>" +
												"<C> id='HIR_YMD'			width=80		name='입사일'			align=center										</C>" +
												"<C> id='RET_YMD'			width=80		name='퇴사일'			align=center										</C>";

				//첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
				//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
				cfStyleGrid(form1.grdT_CM_PERSON,0,"false","false");
             }

		}

		/**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup('txtRETM_REM', 'txtRETM_REM_NM');

            fnc_GetUserInfo();
        }

  		/**
         * fnc_GetEnoNm 다른정보도 가져오게 재정의
         */
        function fnc_GetUserInfo() {

            var obj = fnc_GetEnoNm("txtRETM_REM");

            document.getElementById("txtRETM_REM").value = obj.eno_no;
            document.getElementById("txtRETM_REM_NM").value = obj.eno_nm;

        }



		/********************************************
         * 입력필드 사용 가능하게(Enable)          		 *
         ********************************************/
  		function enableInput(){
 			document.getElementById("cmbRETM_CD").disabled = false;
			document.form1.txtRETM_REM.readOnly = false;
  			document.form1.txtRETM_REM.className = "";
			document.getElementById("imgRETM_REM").disabled = false;
			document.form1.txtRETM_YMD.readOnly = false;
  			document.form1.txtRETM_YMD.className = "";
  			document.getElementById("imgRETM_YMD").disabled = false;
  		}


        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
         ********************************************/
  		function disableInput(){
 			document.getElementById("cmbRETM_CD").disabled = true;
			document.form1.txtRETM_REM.readOnly = true;
  			document.form1.txtRETM_REM.className = "input_ReadOnly";
			document.getElementById("imgRETM_REM").disabled = true;
			document.form1.txtRETM_YMD.readOnly = true;
  			document.form1.txtRETM_YMD.className = "input_ReadOnly";
  			document.getElementById("imgRETM_YMD").disabled = true;
  		}

		/****
		 * 퇴사자 조치내역에 따른 RETM_CD 코드의 사용
		 ***********************************************/
		function retminput() {
		    var oTODAY   = getToday();
		    var oTODAY   = oTODAY.replaceStr("-", "/");  //getToday의 경우 "-"로 날짜 표기하여 변경해줌.
			var gbn_case = document.form1.hidGBN_GBN_CASE.value;
			var oRETM_CD = document.getElementById("cmbRETM_CD").value;
			var oUPT_YMD = document.getElementById("txtUPT_YMD").value;
			var oTODAY
			if(gbn_case == "R") {

				if(oRETM_CD == "" || oRETM_CD == "1") {
					enableInput();
				} else if(oUPT_YMD == oTODAY) {
					enableInput();
				} else {
					disableInput();
				}
			}
		}

        function fnc_PrintBtn() {
            if(document.getElementById("hidGBN_GBN_CASE").value == "K"||document.getElementById("hidGBN_GBN_CASE").value == "L"||document.getElementById("hidGBN_GBN_CASE").value == "C")
              fnc_HiddenElement("imgPrint");
            else fnc_ShowElement("imgPrint");
        }


    </script>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

   	<!-- 공통 콤보를 위한 DataSet -->
    <!-- 조치코드 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_CB"/>
       <jsp:param name="CODE_GUBUN"    value="CB"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton               |
    | 2. 이름은 tr_ + 주요 테이블명(T_CM_PERSON)           |
    | 3. 사용되는 Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
        <param name=TimeOut value=2000000>
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {
			var gbn_case = document.form1.hidGBN_GBN_CASE.value;

			if(gbn_case == "R"){
	   			enableInput();//입력필드 활성화
   			}
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>


    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_CM_PERSON event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_CM_PERSON event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script language="javascript"  for=dsT_CM_PERSON event=OnRowPosChanged(row)>
		retminput();
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
          <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">직원변동조회</td>
          <td align="right" class="navigator">HOME/인사관리/인원정보/<font color="#000000">직원변동조회</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
    </td>
  </tr>
</table>
<!-- 버튼 테이블 끝 -->


<!-- power Search테이블 시작 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="45"></col>
                                <col width="150 "></col>
                                <col width="45 "></col>
                                <col width="70"></col>
                                <col width="45"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">기 간&nbsp;</td>
                                <td class="padding2423" width = "220">
                                    <input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','55','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                     ~
                                    <input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','170','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>
								<td class="searchState" align="right">근로구분&nbsp;</td>
								<td class="padding2423" align="left">
                                    <select id="cmbOCC_CD_SHR" style="width:100%" >
                                        <option value="">모  두</option>
                                        <option value="A">사무직</option>
                                        <option value="M">예비</option>
                                    </select>
                                </td>
								<td class="searchState" align="right">종류&nbsp;</td>
								<td class="padding2423" align="left">
									<input type="radio" name="rdoGBN_GBN_CASE" id="rdoGBN_GBN_CASE" style="margin-bottom:-2px;border:0;" onClick="document.form1.hidGBN_GBN_CASE.value = 'H';fnc_ChangeGrid();fnc_PrintBtn();" checked>입사자
									<input type="radio" name="rdoGBN_GBN_CASE" id="rdoGBN_GBN_CASE" style="margin-bottom:-2px;border:0;" onClick="document.form1.hidGBN_GBN_CASE.value = 'R';fnc_ChangeGrid();fnc_PrintBtn();">퇴사자
									<input type="radio" name="rdoGBN_GBN_CASE" id="rdoGBN_GBN_CASE" style="margin-bottom:-2px;border:0;" onClick="document.form1.hidGBN_GBN_CASE.value = 'J';fnc_ChangeGrid();fnc_PrintBtn();">전보자
                                    <input type="radio" name="rdoGBN_GBN_CASE" id="rdoGBN_GBN_CASE" style="margin-bottom:-2px;border:0;" onClick="document.form1.hidGBN_GBN_CASE.value = 'K';fnc_ChangeGrid();fnc_PrintBtn();">휴직자
                                    <input type="radio" name="rdoGBN_GBN_CASE" id="rdoGBN_GBN_CASE" style="margin-bottom:-2px;border:0;" onClick="document.form1.hidGBN_GBN_CASE.value = 'L';fnc_ChangeGrid();fnc_PrintBtn();">근로구분변경자
                                    <input type="radio" name="rdoGBN_GBN_CASE" id="rdoGBN_GBN_CASE" style="margin-bottom:-2px;border:0;" onClick="document.form1.hidGBN_GBN_CASE.value = 'C';fnc_ChangeGrid();fnc_PrintBtn();">조직개편대상자
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


<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="140"></col>
					<col width="80"></col>
					<col width="240"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">조치구분</td>
					<td class="padding2423">
						<select id="cmbRETM_CD" style="width='100'"></select>
					</td>
					<td align="center" class="creamBold">조치자</td>
					<td class="padding2423">
						<input id="txtRETM_REM" name="txtRETM_REM" size="10" maxlength="8" onChange="fnc_GetUserInfo();">
						<input id="txtRETM_REM_NM" name="txtRETM_REM_NM" size="15" maxlength="14" class="input_ReadOnly"  readOnly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRETM_REM','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgRETM_REM" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup();"></a>
					</td>
					<td align="center" class="creamBold">조치일자</td>
					<td class="padding2423">
						<input type="text" id="txtRETM_YMD" name="txtRETM_YMD" style="ime-mode:disabled" style="width:80" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRETM_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgRETM_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtRETM_YMD','','630','152');"></a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
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
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
							<param name="DataID"					value="dsT_CM_PERSON">
			                <param name="EdiTABLE"                  value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 내용 조회 그리드 데이블 끝-->

<table border="0"><tr><td height="5"></td></tr></table>

<!--************************************************************** ezgen -->
<table border=0>
    <tr height="1">
        <td width="1">
            <table border="00" bordercolordark="white" bordercolorlight="gray" bordercolor="gray">
<!--
                <comment id="__NSID__">
                    <object id="aaa" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="1" height="1" codebase="<%=hnwcodebase%>">
                    <param name="hnwsrc"    VALUE="memb100.hnw"
                    <param name="initvalue" VALUE="[:flag]=N">
                    <param name="hidewnd"   VALUE="N">
                    <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
                    </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>
-->
           </table>
        </td>
    </tr>
</table>
<!--************************************************************** ezgen -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center" id="biz"  style="display:none">
            <input type="button" name="btnREG_nxt_SHR" value="<<" onclick="goclick('firstPage');" style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            <input type="button" name="btnREG_nxt_SHR" value="<"  onclick="goclick('prePage');"   style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            &nbsp;
            <input type="button" name="btnREG_nxt_SHR" value=">"  onclick="goclick('nextPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            <input type="button" name="btnREG_nxt_SHR" value=">>" onclick="goclick('lastPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
        </td>
    </tr>
</table>

<input type="hidden" name="txtDOC_AUTHO" value="1">
<input type="hidden" name="flag">
<input type="hidden" name="hidGBN_OCC_CD" value="A">
<input type="hidden" name="hidGBN_GBN_CASE" value="H">
<input type="hidden" id="txtUPT_YMD" name="txtUPT_YMD">
</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<object id="bndT_CM_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CM_PERSON">
	<Param Name="BindInfo", Value='
		<C>Col=RETM_CD     		 	Ctrl=cmbRETM_CD     		 	Param=value 		</C>
		<C>Col=RETM_REM     	 	Ctrl=txtRETM_REM     		 	Param=value 		</C>
		<C>Col=RETM_REM_NM			Ctrl=txtRETM_REM_NM    	 		Param=value	 		</C>
		<C>Col=RETM_YMD				Ctrl=txtRETM_YMD    	 		Param=value	 		</C>
		<C>Col=UPT_YMD				Ctrl=txtUPT_YMD 	   	 		Param=value		 	</C>
    '>
</object>