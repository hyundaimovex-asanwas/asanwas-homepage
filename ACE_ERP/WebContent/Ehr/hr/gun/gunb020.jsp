<!--
*****************************************************
* @source       : gunb020.jsp
* @description : 익월근태등록 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/02/09      김학수        최초작성.
* 2007/05/11      김학수        수정
* 2009/11/09      임종태        익월근태용으로 수정
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
String DIL_AUTHO = box.getString("SESSION_DIL_AUTHO");
System.out.println("익월근태 권한 [" + DIL_AUTHO + "]");
%>

<html>
<head>
<title>익월근태등록(gunb020)</title>
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
        var btnList = 'TFTTFFTT';
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var f           = document.form1;
            var str_ymd     = f.txtSTR_YMD_SHR.value;
            var dpt_cd      = f.txtDPT_CD_SHR.value;
            var dpt_nm      = f.txtDPT_NM_SHR.value;
            var eno_no      = f.txtENO_NO_SHR.value;
            var eno_nm      = f.txtENO_NM_SHR.value;

            var holiday_color;
            if ( dpt_nm == "" || dpt_nm == null ) {
                alert("소속를 입력하세요.");
                f.txtDPT_CD_SHR.focus();
                return false;
            }
            /*
            if ( eno_no == "" || eno_nm == null ) {
                alert("사번을 입력하세요.");
                f.txtDPT_CD_SHR.focus();
                return false;
            }
			*/
            //DS_ONE:휴가 계획서  DS_TWO:해당달 연차,휴가 합 DS_FOUR:달력(휴일유무)
            trT_DI_PLAN.KeyValue = "JSP(O:DS_ONE=dsT_DI_PLAN, O:DS_TWO=dsT_DI_PLAN02, O:DS_FOUR=dsT_DI_PLAN04, O:DS_FIVE=dsT_DI_APPROVAL)";
            trT_DI_PLAN.Action   = "/servlet/GauceChannelSVL?cmd=hr.gun.b.gunb020.cmd.GUNB020CMD&S_MODE=SHR&STR_YMD="+str_ymd+"&DPT_CD="+dpt_cd+"&ENO_NO="+eno_no;
            trT_DI_PLAN.post();

            var IndexColCnt     = dsT_DI_PLAN.CountColumn;       //칼럼 총 개수
            // 가져온 데이타셋에서 그리드상 고정 헤더부분을 제외한 가변부분(날짜) 에대한 개수
            // 칼럼총개수 - 앞컬럼개수 - 뒤컬럼
            var Dm_ColCnt   = IndexColCnt - 7 ;       
            var str_m = form1.txtSTR_YMD_SHR.value.substr(5,2);    // 시작일자의 월
            if ( str_m.substr(0,1) == '0' ) {
                str_m = str_m.substr(1,1);
            }


            var str_d;
            var Fix_Col  = "<FC>id={CUROW}	 name=NO             width=30 	align=center               HeadBgColor='#F7DCBB'    value={String(Currow)} </FC>" +
                           "<FC>id=JOB_NM    name=직위           width=35   align=center   Edit=None   HeadBgColor='#F7DCBB' </FC>" + //1번컬럼
                           "<FC>id=ENO_NO    name=사번           width=60   align=center   Edit=None   HeadBgColor='#F7DCBB' </FC>" + //2번컬럼
                           "<FC>id=ENO_NM    name=성명           width=60   align=center   Edit=None   HeadBgColor='#F7DCBB' </FC>" + //3번컬럼
                           "<FC>id=YRP_CNT   name='발생;연차'    width=40   align=right    Edit=None   HeadBgColor='#F7DCBB' DECAO=1 </FC>" + //4번컬럼
                           "<FC>id=NYRP_CNT  name='미사용;연차'  width=40   align=right    Edit=None   HeadBgColor='#F7DCBB' DECAO=1 </FC>" + //5번컬럼
                           "<FC>id=REM_CNT   name='잔여'         width=40   align=right    Edit=None   HeadBgColor='#F7DCBB' DECAO=1 </FC>" ; //6번컬럼

            var Dm_Col = "";   // day 에 해당하는 칼럼(조건에따라 개수가 변하는 칼럼)
			//**********************     day 에 해당하는 칼럼 총 개수만큼 실행하여 grid 나머지 헤더부분을 생성한다.
			for ( var i = 7; i <= Dm_ColCnt + 6; i++ )
			{
				if ( dsT_DI_PLAN.ColumnID(i).length == '29' )     // 1~9까지일경우 칼럼문자길이가 29 , 11~일경우 칼럼문자길이가 30
				{
					str_d = dsT_DI_PLAN.ColumnID(i).substr(23,1);
					if ( i == 7 ) 															// 표기될 첫달
						Dm_Col = Dm_Col + "<G>name="+ str_m +"월 HeadBgColor='#F7DCBB'";
					else if ( dsT_DI_PLAN.ColumnID(i).substr(23,1) == '1' )
						Dm_Col = Dm_Col + "<G>name="+ ++str_m +"월 HeadBgColor='#F7DCBB'";
					if ( dsT_DI_PLAN.ColumnID(i+1) == '1' )
						Dm_Col = Dm_Col + "</G>";
				}
				else if (  dsT_DI_PLAN.ColumnID(i).length == '30' )
				{
					str_d = dsT_DI_PLAN.ColumnID(i).substr(23,2);
				}
					
				//Dm_Col = Dm_Col + "<C>id='"+dsT_DI_PLAN.ColumnID(i)+"'  name="+str_d+"  width=25  align=center</C> ";
				Dm_Col = Dm_Col + "<C>id='"+dsT_DI_PLAN.ColumnID(i)+"'  name="+str_d+"  width=25  align=center edit=AlphaUpper show=true Language=0</C> ";
			}

            form1.grdT_DI_PLAN.Format = Fix_Col + Dm_Col;

            // 최종입력완료 상태에 따른  Grid Style 적용(완료상태일경우 더이상 수정 불가능하게 비활성화 시켜놓음)
            //관리자는 가능하다.
            if (dsT_DI_PLAN.NameValue(1,"END_TAG") != "Y" 
                    || "<%=box.getString("SESSION_DIL_AUTHO") %>" == "M") {
                document.getElementById("imgSave").disabled = false;
                document.getElementById("imgSave").style.display = "";
            
	            //첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
	            //세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)            
                cfStyleGrid(form1.grdT_DI_PLAN,15,"true","false");
                
            //입력완료시 관리자가 아니면 저장, 입력완료 않보이게
            } else {
            
                //버튼도 비활성화
                document.getElementById("imgSave").disabled = true;
                document.getElementById("imgSave").style.display = "none";

                cfStyleGrid(form1.grdT_DI_PLAN,15,"false","false");
                
                document.getElementById("resultMessage").innerText = '입력이 완료되었습니다.';
                
            }
            
            //해당년월 다음달 자료만 입력이 가능하다.(관리자는 모두 가능)
            var n_month = next_month( getToday().substr(0,7) );

            if ( f.txtSTR_YMD_SHR.value == n_month 
                    || "<%=box.getString("SESSION_DIL_AUTHO") %>" == "M") {
                
                document.getElementById("imgSave").disabled = false;
                document.getElementById("imgSave").style.display = "";
            
                //첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
                //세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)            
                cfStyleGrid(form1.grdT_DI_PLAN,15,"true","false");                
                
            }else{

                //버튼도 비활성화
                document.getElementById("imgSave").disabled = true;
                document.getElementById("imgSave").style.display = "none";
                
                cfStyleGrid(form1.grdT_DI_PLAN,15,"false","false");
                
                if(dsT_DI_PLAN.NameValue(1,"END_TAG") != "Y"){
                    document.getElementById("resultMessage").innerText = n_month.substring(0,4)+"년 "+n_month.substring(5,7)+'월 익월근태만 입력이 가능합니다.';
                }
            
            }
            
            
            
            //휴일 설정(토요일, 일요일)
            for ( var i = 7; i <= Dm_ColCnt + 6; i++ ){
                if ( dsT_DI_PLAN04.NameValue(i-6,"HOL_YN") == "Y" ){ 
                    holiday_color = "#F47380";//휴일
                    form1.grdT_DI_PLAN.ColumnProp(dsT_DI_PLAN.ColumnID(i), 'Edit') = 'none';
                }else{
                    holiday_color = "#F7DCBB";
                    form1.grdT_DI_PLAN.ColumnProp(dsT_DI_PLAN.ColumnID(i), 'Edit') = 'AlphaUpper';
                }
                form1.grdT_DI_PLAN.ColumnProp(dsT_DI_PLAN.ColumnID(i), 'HeadBgColor') = holiday_color;
                
            }
            
            
            //조회년월
            f.str_ymd.value = str_ymd;
            
            //우선 첫번째 row의 합계들을 보여준다.
            fnc_Poschange(1,"JOB_NM")
            
            //form1.grdT_DI_PLAN.SelectionColorProp("FocusEditCol", "BgColor") = "";            
            form1.grdT_DI_PLAN.SelectionColorProp("FocusEditRow", "BgColor") = "";
            //form1.grdT_DI_PLAN.SelectionColorProp("FocusCurCol", "BgColor") = "";
            form1.grdT_DI_PLAN.SelectionColorProp("FocusCurRow", "BgColor") = "";
            //form1.grdT_DI_PLAN.SelectionColorProp("EditCol", "BgColor") = "";
            form1.grdT_DI_PLAN.SelectionColorProp("EditRow", "BgColor") = "";
            //form1.grdT_DI_PLAN.SelectionColorProp("CurCol", "BgColor") = "";
            form1.grdT_DI_PLAN.SelectionColorProp("CurRow", "BgColor") = "";
            //form1.grdT_DI_PLAN.IgnoreSelectionColor = "true";
            
            form1.grdT_DI_PLAN.SelectionColorProp("FocusEditRow", "TextColor") = "#000000";
            form1.grdT_DI_PLAN.SelectionColorProp("FocusCurRow", "TextColor") = "#000000";
            form1.grdT_DI_PLAN.SelectionColorProp("EditRow", "TextColor") = "#000000";
            form1.grdT_DI_PLAN.SelectionColorProp("CurRow", "TextColor") = "#000000";
            
          }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************"C:/project000/MASA(back_up)/소스/data2/htdocs2/PMSL/js/comFunction.js"
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {
          var f = document.form1;
          if(!fnc_SaveItemCheck()) return;
          str_ymd = f.str_ymd.value;

          trT_DI_PLAN.KeyValue = "tr01(I:dsT_DI_PLAN=dsT_DI_PLAN)";
          trT_DI_PLAN.action = "/servlet/GauceChannelSVL?cmd=hr.gun.b.gunb020.cmd.GUNB020CMD&S_MODE=SAV&STR_YMD="+str_ymd;
          trT_DI_PLAN.post();
          fnc_SearchList();

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

      // 엑셀로 변환 할 자료가 있는지 체크하고
      // 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

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
            
            document.getElementById("imgSave").disabled = false;
            document.getElementById("imgSave").style.display = "";

            
            f.H_val.value = "0";
            f.P_val.value = "0";
            f.R_val.value = "0";
            
            document.getElementById("resultMessage").innerText = ' ';
            dsT_DI_PLAN.ClearAll();            

            document.form1.txtSTR_YMD_SHR.focus();
        
            
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

          if (dsT_DI_PLAN.IsUpdated)  {

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

          if (!dsT_DI_PLAN.IsUpdated) {
                    alert("저장할 자료가 없습니다.");
                    fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                    return false;
          }
          return true;

        }

        function fnc_SaveItemCheck_01() {

            if (!dsT_DI_PLAN_INPUT.IsUpdated) {
                alert("저장할 자료가 없습니다.");
//                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }
            return true;
        }

        function fnc_SaveItemCheck_02() {

          if (!dsT_DI_PLAN_UPT.IsUpdated) {
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
			/* 익월근태 사용일 매달 20~ 25일까지만사용 */
			/* 근태담당자는    매달 20~ 26일까지만 사용*/			
			var todayDD = getToday().substring(8);
			
			if(todayDD <= "20"){
				alert("익월근태는 매달 20일~25일 사이에만 사용가능합니다.");
				frame = window.external.GetFrame(window);
				frame.CloseFrame();
			}
			
<%
    //마스터는 모든부서 통할
    if(box.getString("SESSION_DIL_AUTHO").equals("M") || box.getString("SESSION_DIL_AUTHO").equals("A")) {
%>
	
			if(todayDD > "30"){
<%
			}else{
%>
			if(todayDD > "25"){
<%
			}
%>			
			
				alert("익월근태는 매달 20일~25일 사이에만 사용가능합니다.");
				frame = window.external.GetFrame(window);
				frame.CloseFrame();
			
			}
	        dsT_DI_APPROVAL.SetDataHeader(
	        					"GUN_YMD:STRING(10),"+			// 근태날짜
	                            "GUN_GBN:STRING(1),"+			// 근태결재구분
								"DPT_CD:STRING(3),"+			// 근태부서
								"DPT_NM:STRING(10),"+			// 근태부서명
								"SEQ_NO:STRING(1),"+			// 결재선
								"ENO_NO:STRING(10),"+			// 결재자사번
								"JOB_CD:STRING(10),"+			// 결재자직위
								"APP_TIME:STRING(10),"+			// 결재시간
								"PENO_NO:STRING(10),"+			// 상신자사번
								"APP_YN:STRING(10),"+			// 결재여부
								"ENO_NM:STRING(10),"+			// 결재자명
								"JOB_NM:STRING(10),"+				// 직위명
								"REQ_NO:STRING(20)"				// 직위명
								);



            cfStyleGrid(form1.grdT_DI_PLAN,15,"true","false");

            document.getElementById("txtSTR_YMD_SHR").value = next_month(getToday().substring(0,7)); 
			document.getElementById("txtSTR_YMD_SHR").focus();
            

            document.getElementById("txtDPT_CD_SHR").value = "<%=box.getString("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.getString("SESSION_DPTNM") %>";

            document.getElementById("txtENO_NO_SHR").value = "<%=box.getString("SESSION_ENONO") %>";
            document.getElementById("txtENO_NM_SHR").value = "<%=box.getString("SESSION_ENONM") %>";


<%
    //마스터는 모든부서 통할
    if(box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
			 document.getElementById("approval_btn").style.display = "";	   
			 document.getElementById("append_btn").style.display = "";

            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";
<%//A 는 자기부서만 통할
	}else if(box.getString("SESSION_DIL_AUTHO").equals("A")) {
%>
			document.getElementById("approval_btn").style.display = "";
			document.getElementById("append_btn").style.display = "";
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");       
			fnc_ChangeStateElement(false, "ImgDptCd");       

            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";
<%
    }else{
%>
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");       
			fnc_ChangeStateElement(false, "ImgDptCd");       

			fnc_ChangeStateElement(false, "txtENO_NO_SHR");       
			fnc_ChangeStateElement(false, "txtENO_NM_SHR");       
			fnc_ChangeStateElement(false, "ImgEnoNoSHR");       

			 document.getElementById("approval_btn").style.display = "none";
			 document.getElementById("append_btn").style.display = "none";
<%
	}
%>

			fnc_OnLoadApproval();

         }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

          fnc_HotKey_Process(btnList, event.keyCode);

        }

        function fnc_Poschange(Row,Colid) {//Colid 미사용

            var f = document.form1;
            f.row_num.value = Row;//현재 row;
            
            if ( dsT_DI_PLAN02.CountRow > 0 ) {
                // X = 한해 총 연차 및 휴가 - 조회해온 기간 동안의 연차 및 휴가
                //     ( X값 더하기 데이타셋에 속한 연차 및 휴가로 한해 총 연차 및 휴가를 표기함)
                f.H_val_fix.value = dsT_DI_PLAN02.NameValue(Row,"H_1") - dsT_DI_PLAN02.NameValue(Row,"H_2");
                f.P_val_fix.value = dsT_DI_PLAN02.NameValue(Row,"P_1") - dsT_DI_PLAN02.NameValue(Row,"P_2");
                f.R_val_fix.value = dsT_DI_PLAN02.NameValue(Row,"R_1") - dsT_DI_PLAN02.NameValue(Row,"R_2");
            } else {
                f.H_val_fix.value = "";
                f.P_val_fix.value = "";
                f.R_val_fix.value = "";
            }
            var IndexColCnt = dsT_DI_PLAN.CountColumn;       //칼럼 총 개수
            var Dm_ColCnt   = IndexColCnt-6;       // 가져온 데이타셋에서 그리드상 고정 헤더부분을 제외한 가변부분(날짜) 에대한 개수

            var H_count = 0;  //데이타셋에 속한 연차 및 휴가 개수를 추출
            var P_count = 0;
            var R_count = 0;

            for ( var i = 7; i <= Dm_ColCnt + 6; i++ )
            {
                if ( dsT_DI_PLAN.NameValue(Row,dsT_DI_PLAN.ColumnID(i)) == "H" )
                    H_count = H_count + 1;
                else if ( dsT_DI_PLAN.NameValue(Row,dsT_DI_PLAN.ColumnID(i)) == "P" )
                    P_count = P_count + 1;
                else if ( dsT_DI_PLAN.NameValue(Row,dsT_DI_PLAN.ColumnID(i)) == "R" )
                    R_count = R_count + 1;
            }

            f.H_val.value = Number(H_count);
            f.P_val.value = Number(P_count);
            f.R_val.value = Number(R_count);
        }

    /********************************************
         * 날짜 형식 유효성 체크                           			*
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('유효한 날짜가 아닙니다.');
                obj.focus();
            }
        }

     /********************************************
         * 종료일자에서 포커스 떠날때 신청일자와 비교       		*
         ********************************************/
        function cfCheckDateTermGUNA040(p_obj,p_stdt,p_endt) {
          if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
            if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
              alert("종료일자가 시작일자보다 큽니다.");
              document.getElementById(p_obj).value = '';
            }
          }
        }

        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopupSHR() {
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "txtDPT_CD_SHR", "3");

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmpNoSHR();
            }
        }

        /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */
        function fnc_SearchEmpNmSHR() {
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "txtDPT_CD_SHR", "3");
            fnc_SearchEmpNoSHR();
        }
        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNoSHR() {
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "txtDPT_CD_SHR", "3");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO_SHR").value      = obj.eno_no;
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
            } else {
                document.getElementById("txtENO_NO_SHR").value      = "";
                document.getElementById("txtENO_NM_SHR").value      = "";
            }
        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {
			
			if(dsT_DI_PLAN.CountRow < 1){
				alert("근태내역을 먼저 조회하십시요.");
				return;
			}
			
            //ds를 리턴받는다.
            //fnc_GetApproverDS(dsT_DI_APPROVAL);

			var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value+"-01";
			var END_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value+"-01";
			//var GUN_STS_SHR = document.getElementById("cmbGUN_STS_SHR").value;
            var EMPL_DPT_CD = document.getElementById("txtDPT_CD_SHR").value;
			var EMP_NO      = "<%=box.getString("SESSION_ENONO") %>";
			dsT_DI_APPROVAL.DeleteAll();
			fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, EMPL_DPT_CD, "1", "1", STR_YMD_SHR, END_YMD_SHR, 10,"P");

            //강제로 IsUpdated 체크하게 만듬
            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_TEMP);
            dsT_DI_APPROVAL.ClearData();


            for(var i=1; i<=dsT_DI_APPROVAL_TEMP.countrow; i++){
                dsT_DI_APPROVAL.addrow();

	            dsT_DI_APPROVAL.NameValue(i,"ENO_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NO");
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NM");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_CD");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_NM");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_CD");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_NM");
	            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"SEQ_NO");
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = "99991231";//dsT_DI_DILIGENCE.NameValue(1,"PIS_YYMMDD");// 서무가쓰즞 일별 근태에서 결재자 뜨지 않게 하기위해서...
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = EMP_NO;
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "P";
				dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = document.getElementById("hidREG_NO").value;

            }
        }
        function fnc_OnLoadApproval() {

			//첫번째 인수 : 그리드명                             두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid(form1.grdT_DI_APPROVAL,15,"true","false")      // Grid Style 적용
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight   = 18;
			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.HiddenVScroll  = true;
			form1.grdT_DI_APPROVAL.DisableNoHScroll = false;
			form1.grdT_DI_APPROVAL.DisableNoVScroll = false;
			form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";

        }
        function fnc_Report() {
			if(confirm("상신하시겠습니까? 익월근태사항을 저장하신후에만 상신이 반영됩니다")){
				var STR_YMD = document.getElementById("txtSTR_YMD_SHR").value;
				var DPT_CD = document.getElementById("txtDPT_CD_SHR").value;
				if(dsT_DI_PLAN.CountRow == 0){
					alert("상신할 데이터를 먼저 조회하십시요");
					return;
				}
				if(dsT_DI_APPROVAL.CountRow == 0){
					alert("결재선을 지정 하십시요");
					return;
				}
				
				trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
				trT_DI_APPROVAL.action = "/servlet/GauceChannelSVL?cmd=hr.gun.b.gunb020.cmd.GUNB020CMD&S_MODE=REP&STR_YMD="+STR_YMD+"&DPT_CD="+DPT_CD;
				trT_DI_APPROVAL.post();
				
			}

        }

       /********************************************
         * form onload시                       			*
         ********************************************/

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------------------------------+
    | 1. 조회용 DataSet (휴가계획서 조회)                            		                |
    | 2. 이름 : dsT_DI_PLAN                                                 |
    | 3. Table List : T_DI_PLAN, VI_T_CM_PERSON2, T_DI_YEARLY, T_DI_REFRESH |
    +----------------------------------------------------------------------->
    <Object ID="dsT_DI_PLAN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name="Language" value=0>
    </Object>

    <!----------------------------------------------+
    | 1. 조회용 DataSet (년별 및 조회기간내의 연차,휴가의 합계를 조회)    |
    | 2. 이름 : dsT_DI_PLAN02                      |
    | 3. Table List : T_DI_PLAN                  |
    +----------------------------------------------->
    <Object ID="dsT_DI_PLAN02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회용 DataSet (일괄생성시 중복을 막기위해 성성되어있는 년(해)을 조회)     |
    | 2. 이름 : dsT_DI_PLAN03                     |
    | 3. Table List : T_DI_PLAN                  |
    +----------------------------------------------->
    <Object ID="dsT_DI_PLAN03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회용 DataSet (휴일날짜 표시)     |
    | 2. 이름 : dsT_DI_PLAN03                     |
    | 3. Table List : T_DI_HOLIDAY                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_PLAN04" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 입력용  DataSet                             |
    | 2. 이름 : dsT_DI_PLAN_INPUT                      |
    | 3. Table List : T_DI_PLAN, VI_T_CM_PERSON, T_DI_HOLIDAY        |
    +----------------------------------------------->
    <Object ID="dsT_DI_PLAN_INPUT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 수정용  DataSet                             |
    | 2. 이름 : dsT_DI_PLAN_UPT                      |
    | 3. Table List : T_DI_PLAN        |
    +----------------------------------------------->
    <Object ID="dsT_DI_PLAN_UPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_APPROVAL)			 	   |
    | 3. 사용되는 Table List(T_DI_APPROVAL) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_APPROVAL_TEMP                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
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

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_PLAN)		|
    | 3. 사용되는 Table List(T_DI_PLAN)	            |
    +--------------------------------------------------->
    <Object ID ="trT_DI_PLAN" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="sample_tr01(I:T_EV_ABLRST=T_EV_ABLRST)">
    </Object>


	<!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_APPROVAL)		|
    | 3. 사용되는 Table List(T_DI_APPROVAL)	            |
    +--------------------------------------------------->
    <Object ID ="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="sample_tr01(I:T_DI_APPROVAL=T_DI_APPROVAL)">
    </Object>
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->
	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		alert("상신이 완료되었습니다.");
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>



    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_PLAN Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

          //alert("검색하신 조건의 자료가 없습니다.");
          fnc_Message(document.getElementById("resultMessage"), "MSG_02");
	dsT_CM_PERSON.DataId="/servlet/GauceChannelSVL?cmd=hr.gun.d.gund020.cmd.GUND020CMD&S_MODE=SHR_01&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;
			dsT_CM_PERSON.Reset();

        } else {

          fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
          document.form1.grdT_DI_PLAN.focus();
        }
    </Script>
    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 1)    {
			document.getElementById("txtDPT_CD_SHR").value = dsT_CM_PERSON.NameValue(1, "GUN_DPT");
			alert("조회 버튼을 다시 한번 Click하여 주십시요");			
        }

    </Script>
    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_PLAN Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_PLAN Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount > 0)    {
			document.getElementById("hidREG_NO").value = dsT_DI_APPROVAL.NameValue(1,"REQ_NO");
        }else{
			document.getElementById("hidREG_NO").value = "";
		}
		var APP_YN = "";
		for(var i = 1; i <= dsT_DI_APPROVAL.CountRow; i++){
            if(dsT_DI_APPROVAL.NameValue(i,"APP_YN")=="Y"){
                APP_YN = "Y";
            }
            if(dsT_DI_APPROVAL.NameValue(i,"APP_YN")=="N"){
                APP_YN = "N";
				break
            }
		}
		if(APP_YN=="Y"){
			document.getElementById("save_btn").style.display = "none";		// 저장버튼
			document.getElementById("append_btn").style.display = "none";	// 상신버튼
			document.getElementById("btn_InsDel").style.display = "none";	// 결재선버튼
		}else{

			document.getElementById("save_btn").style.display = "";
		}
    </Script>


    <!--------------------------+
    | Grid 이벤트 처리  |
    +--------------------------->
    <script language="javascript"  for=grdT_DI_PLAN event=OnColumnPosChanged(Row,Colid)>
         fnc_Poschange(Row,Colid);
    </script>

    <script language="javascript"  for=grdT_DI_PLAN event=onKeyPress(keycode)>
        var form        = document.form1;
        var row_num     = form.row_num.value;
        
        var col_id      = grdT_DI_PLAN.GetColumn();//현재 선택한 컬럼
        form.col_id.value = col_id;
        
        var temp_val = dsT_DI_PLAN.NameValue(row_num,col_id);

        var NYRP_CNT_TOT = Number(form.H_val.value) + (Number(form.P_val.value)*0.5)  + (Number(form.R_val.value)*0.5)  ;
        
        //입력완료 수정불가(관리자는 가능)
        if ( dsT_DI_PLAN.NameValue(row_num,"END_TAG") != "Y" 
                || "<%=box.getString("SESSION_DIL_AUTHO") %>" == "M") {
            
            if ( col_id != "JOB_NM" && col_id != "ENO_NO" && col_id != "ENO_NM" && col_id != "YRP_CNT" && col_id != "NYRP_CNT" && col_id != "REM_CNT" )
            {
                //사용가능한 키코드
                //(             H,               P,               R)
                if (keycode == 72 || keycode == 80 || keycode == 82) {
                    //alert(dsT_DI_PLAN.NameValue(row_num,"NYRP_CNT") +",  "+ NYRP_CNT_TOT);
                                     
                    //연차(H)
                    if ( keycode == "72" ) {
                        if ( dsT_DI_PLAN.NameValue(row_num,"NYRP_CNT") < NYRP_CNT_TOT+1 ) {
                            alert("더이상 연차를 사용하실 수 없습니다.");
                            form.pre_data.value = temp_val;//원래값 복구
                            return;
                        } else {
                            form.pre_data.value = "H";
                        }
                    //오전연반차(P)
                    } else if ( keycode == "80" ) {
                        if ( dsT_DI_PLAN.NameValue(row_num,"NYRP_CNT") < NYRP_CNT_TOT+0.5 ) {
                            alert("더이상 연차를 사용하실 수 없습니다.");
                            form.pre_data.value = temp_val;//원래값 복구
                            return;
                        } else {
                            form.pre_data.value = "P";
                        }
                        
                    //오후연반차(R)
                    } else if ( keycode == "82" ) {
                        if ( dsT_DI_PLAN.NameValue(row_num,"NYRP_CNT") < NYRP_CNT_TOT+0.5 ) {
                            alert("더이상 연차를 사용하실 수 없습니다.");
                            form.pre_data.value = temp_val;//원래값 복구
                            return;
                        } else {
                            form.pre_data.value = "R";
                        }
                        
                    //특별휴가(I)
                    } else if ( keycode == "73" ) {
                        form.pre_data.value = "I";   //특별휴가는 연차가 아님

                    //대체+연반차(V)
                    } else if ( keycode == "86" ) {
                        if ( dsT_DI_PLAN.NameValue(row_num,"NYRP_CNT") < NYRP_CNT_TOT+0.5 ) {
                            alert("더이상 연차를 사용하실 수 없습니다.");
                            form.pre_data.value = temp_val;//원래값 복구
                            return;
                        } else {
                            form.pre_data.value = "V";
                        }
                    }

                } else {
                     form.pre_data.value = "";
                     dsT_DI_PLAN.NameValue(row_num,col_id) = "";
                }
            }
            
        } else {
            alert("최종입력완료된 상태입니다. 수정 불가능합니다.");
            form.pre_data.value = temp_val;//원래값 복구
        }
        
    </script>

    <script language="javascript"  for=grdT_DI_PLAN event=OnExit(row,colid,olddata)>
    
        var f = document.form1;
        var row_num   = f.row_num.value;//row
        var col_id    = f.col_id.value;//컬럼명
        var pre_data  = f.pre_data.value;//코드값
        //alert("row_num:"+row_num+", col_id:"+col_id+", pre_data:"+pre_data)
        
        if ( col_id != "" || col_id != null){
            dsT_DI_PLAN.NameValue(row_num,col_id) = pre_data;
            
            //잔여값 다시계산
	        fnc_Poschange(row,colid);
	        dsT_DI_PLAN.NameValue(row_num,"REM_CNT") = Number(dsT_DI_PLAN.NameValue(row_num,"NYRP_CNT")) -
	                                                   (Number(f.H_val.value)      + (Number(f.P_val.value)*0.5) +
	                                                   (Number(f.R_val.value)*0.5) );

        }
        
        //f.row_num.value = row;
        //f.col_id.value = colid;
        //f.pre_data.value = "";

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
    <input type="hidden" id="hidEMPL_DPT_CD">
	<input type="hidden" id="hidREG_NO">
<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="25" background="/images/common/barBg.gif">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
          <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">익월근태등록</td>
          <td align="right" class="navigator">HOME/근태관리/익월근태/<font color="#000000">익월근태등록</font></td>
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
	<span id="append_btn" style="display:none">
	  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRep','','/images/button/btn_ReportOver.gif',1)">  <img src="/images/button/btn_ReportOn.gif"     name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Report()"></a>
	</span>
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	<span id="save_btn" style="display:none">
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
    </span>
	  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                              <col width="10"></col>
                              <col width="80"></col>
                              <col width="100"></col>
                              <col width="30"></col>
                              <col width="80"></col>
                              <col width=""></col>
                            </colgroup>
                            <tr>
                                <td align="center">&nbsp;</td>
                                <td align="right" class="searchState">해당년월&nbsp;</td>
                                <td class="padding2423">
                                    <input type="text" id="txtSTR_YMD_SHR"  name="txtSTR_YMD_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtSTR_YMD_SHR','','108','113');">
                                    <img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>
                                <td align="center">&nbsp;</td>
                                <td align="right" class="searchState">소속&nbsp;</td>
                                <td class="padding2423"><input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3" maxlength="2" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="16" class="input_ReadOnly" readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
                                </td>
                                <td align="center">&nbsp;</td>

							<td class="searchState" align="right">사번</td>
							<td class="padding2423" align="left">
								<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="6" maxlength= "6"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNoSHR()" onchange="fnc_SearchEmpNoSHR()">
                        		<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="10" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNmSHR()" onchange="fnc_SearchEmpNmSHR()">
                        		<img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoSHR" name="ImgEnoNoSHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopupSHR()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
							</td>


                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<div id="approval_btn" style="display:none">
	<!-- 결재선 테이블 시작 -->
	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
							<comment id="__NSID__">
							<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:600px;height:112px;">
								<param name="DataID"				value="dsT_DI_APPROVAL">
								<param name="Format"				value="
									<C> id='REQ_NO'	width=40	name='등록번호'	align=center	show=false</C>
	            					<C> id='SEQ_NO'	width=40	name='NO'		align=center	</C>
	            					<C> id='DPT_NM'	width=96	name='부서'		align=center	</C>
									<C> id='JOB_NM'	width=96	name='직위'		align=center	</C>
									<C> id='ENO_NO'	width=100	name='사번'		align=center	show=false</C>
									<C> id='ENO_NM'	width=100	name='성명'		align=center	</C>
									<C> id='APP_YN'	width=100	name='결재여부'	align=center	Value={DECODE(APP_YN,'Y','결재','N','부결','미결')} </C>
								">
							</object>
							</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>

			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
	                    <td align="right">
	                        <span id="btn_InsDel">
	                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectapproval','','/images/button/btn_SelectapprovalOver.gif',1)"> <img src="/images/button/btn_SelectapprovalOn.gif" name="ImgSelectapproval"  width="90" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>

	                        </span>
			            </td>
					</tr>
				</table>
			</td>


		</tr>
	</table>
</div>


<!-- power Search테이블 끝 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
       <td class="paddingTop8">
            <table width="800" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" ><span id="resultMessage">&nbsp;</span></td>
                </tr>
             </table>
        </td>
    </tr>
</table>

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="3">
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
            <object	id="grdT_DI_PLAN" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:280px;">
              <param name="DataID"				value="dsT_DI_PLAN">
              <param name="EdiTABLE"				value="true">
              <param name="DragDropEnable"		value="true">
              <param name="SortView"				value="Left">
              <param name="VIEWSUMMARY"			value=0>
              <param name="Format"				value="
                <FC> id='{CUROW}'		width=30		name=NO				       align=center	       value={String(Currow)}</FC>
                <FC> id='JOB_NM'        width=55     	name='직위'		           align=center	        Edit=None	         </FC>
                <FC> id='ENO_NO'		width=50		name='사번'		           align=center	        Edit=None	         </FC>
                <FC> id='ENO_NM'		width=50	    name='성명'		           align=center      	Edit=None	         </FC>
                <FC> id='YRP_CNT'   	width=40		name='발생;연차'     	   align=right 		    Edit=None	DECAO=1  </FC>
                <FC> id='NON_CNT'       width=40        name='미사용;연차'         align=right          Edit=none   DECAO=1  </FC>                
                <FC> id='REM_CNT'	    width=40	    name='잔여'                align=right 		    Edit=none	DECAO=1  </FC>

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
<table width="800" border="0" height="20"><tr><td></td></tr></table>
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="searchState" width="100">연&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;차:H&nbsp;</td>
        <td class="searchState" width="100"><input type="text" name="H_val" size="3" readOnly></td>
        <td class="searchState" width="100">오전 연반차:P&nbsp;</td>
        <td class="searchState" width="100"><input type="text" name="P_val" size="3" readOnly></td>

        <td class="searchState" width="100">오후 연반차:R&nbsp;</td>
        <td class="searchState" width="100"><input type="text" name="R_val" size="3" readOnly></td>

    </tr>
    <tr>

    </tr>
</table>

<input type="hidden" name="H_val_fix" value="">
<input type="hidden" name="P_val_fix" value="">
<input type="hidden" name="R_val_fix" value="">

<input type="hidden" name="row_num" value="">
<input type="hidden" name="col_id" value="UATT_Z">
<input type="hidden" name="pre_data" value="">

<input type="hidden" name="str_ymd" value="">

</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- -->

