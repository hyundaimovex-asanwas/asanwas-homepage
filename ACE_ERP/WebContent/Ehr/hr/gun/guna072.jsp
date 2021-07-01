<!--
***********************************************************************
* @source      : guna072.jsp
* @description : 연차촉진제 결재세부사항 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2016/07/08      이동훈        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>연차촉진제</title>
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

	<script language="javascript">



        var dsTemp = window.dialogArguments;

		var obj = new String();

		obj.app_cmt = "";

		var pis_mm  = "070809101112";	//해당분기

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         *******************************************/
        function fnc_SearchList() {


            //결재세부사항 조회(변경신청)
            if(dsTemp.NameValue(1,"GUN_GBN")=="A"){//연차촉진제



				//결재자 조회
	            fnc_SearchApprover();

				pis_mm = "070809101112";


				trT_DI_CHANGE.KeyValue = "JSP( O:dsT_DI_ACCELERATE=dsT_DI_CHANGE,O:dsT_DI_HOLIDAY=dsT_DI_HOLIDAY)";
				trT_DI_CHANGE.Action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna072.cmd.GUNA072CMD&S_MODE=SHR_ACC&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&ENO_NO="+dsTemp.NameValue(1,"ENO_NO")+"&DPT_CD="+dsTemp.NameValue(1,"DPT_CD")+"&PIS_MM="+pis_mm;
				trT_DI_CHANGE.post();

            }
        }

        /**
         * 결재자 정보를 조회한다.
         */
        function fnc_SearchApprover() {

            dsT_DI_APPROVAL.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna072.cmd.GUNA072CMD&S_MODE=SHR_APP&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&GUN_GBN="+dsTemp.NameValue(1,"GUN_GBN");
            
            //prompt(this, dsT_DI_APPROVAL.DataID);
            
            dsT_DI_APPROVAL.Reset();
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			*
         ********************************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 03. 저장 함수							*
         ********************************************/
        function fnc_Save() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {

        	//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 05. 인쇄 함수  							*
         ********************************************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {
			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)
        }

		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 08. 추가 함수 							*
         ********************************************/
        function fnc_Append() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 09. 제거 함수 							*
         ********************************************/
        function fnc_Remove() {

        	//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 10. 초기화 함수  						*
         ********************************************/
        function fnc_Clear() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			window.close();

        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         ********************************************/
        function fnc_OnLoadProcess() {

        	cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false");     // Grid Style 적용

			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;
			form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";
			form1.grdT_DI_CHANGE.IgnoreSelectionColor = "true";

            if(dsTemp.NameValue(1,"GUN_GBN")=="A"){

                document.getElementById("txtGUN_GBN").value = "연차촉진제";

            }

            if(dsTemp.NameValue(1,"APP_TIME")!=""){

			}else{
                document.getElementById("btn_approval").style.display = "";
            }
			if(dsTemp.NameValue(1,"APP_TIME")!=""){
				document.getElementById("btn_approval").style.display = "none";
			}else{
				document.getElementById("btn_approval").style.display = "";
			}
			// 결재자만 버튼이 활성화
            if(dsTemp.NameValue(1,"ENO_NO")!= gusrid){
                document.getElementById("btn_approval").style.display = "none";
            }else{

            }

            var nowDate = getToday().replace("-","").replace("-","");

            fnc_SearchList();

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /*************************
         * 16. 그리드 변경 처리  *
         ************************/
		function fnc_ChangeGrid() {

			if(dsTemp.NameValue(1,"GUN_GBN")=="A"){

			  form1.grdT_DI_CHANGE.Format = "" +
"						<FC> id='{CUROW}'			width=34			name='NO'			align=center			value={String(Currow)}		</FC>	"+
"						<FC> id='DPT_NM'			width=80			name='소속'			align=center			Edit=None					</FC>   "+
"						<FC> id='JOB_NM'			width=50			name='직위'			align=center			Edit=None					</FC>   "+
"						<FC> id='ENO_NO'			width=60			name='사번'			align=center			Edit=None		show=false	</FC>   "+
"						<FC> id='ENO_NM'			width=60			name='성명'			align=center			Edit=None					</FC>    "+
"                     	<C> id='YRP_CNT'			width=50			name='총 연차'		align=center			Edit=None	DECAO=1					</C>        "+
"                     	<C> id='YRP_REM'			width=50			name='입력;연차'	align=center			Edit=None	DECAO=1				</C>        "+
"                     	<C> id='REM_CNT'		    width=40			name='잔여'	        show=false	align=center			Edit=None	DECAO=1			Value={YRP_REM-(ATT_OCT+ATT_NOV+ATT_DEC)}	</C>      "+
"                     	<G>  id='MM_JUL' name='7월'  HeadBgColor='#dae0ee'                                                                                                                              "+
"                         <C> id='AT1_JUL'		width=20		name='1'				align=center	edit='None'       bgcolor={Decode(AT1_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT2_JUL'		width=20		name='2'				align=center	edit='None'       bgcolor={Decode(AT2_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"                         <C> id='AT3_JUL'		width=20		name='3'				align=center	edit='None'       bgcolor={Decode(AT3_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT4_JUL'		width=20		name='4'				align=center	edit='None'       bgcolor={Decode(AT4_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"                         <C> id='AT5_JUL'		width=20		name='5'				align=center	edit='None'       bgcolor={Decode(AT5_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT6_JUL'		width=20		name='6'				align=center	edit='None'       bgcolor={Decode(AT6_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"                         <C> id='AT7_JUL'		width=20		name='7'				align=center	edit='None'       bgcolor={Decode(AT7_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT8_JUL'		width=20		name='8'				align=center	edit='None'       bgcolor={Decode(AT8_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"                         <C> id='AT9_JUL'		width=20		name='9'				align=center	edit='None'       bgcolor={Decode(AT9_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT10_JUL'		width=20		name='10'				align=center	edit='None'       bgcolor={Decode(AT10_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT11_JUL'		width=20		name='11'				align=center	edit='None'       bgcolor={Decode(AT11_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT12_JUL'		width=20		name='12'				align=center	edit='None'       bgcolor={Decode(AT12_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT13_JUL'		width=20		name='13'				align=center	edit='None'       bgcolor={Decode(AT13_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT14_JUL'		width=20		name='14'				align=center	edit='None'       bgcolor={Decode(AT14_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT15_JUL'		width=20		name='15'				align=center	edit='None'       bgcolor={Decode(AT15_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT16_JUL'		width=20		name='16'				align=center	edit='None'       bgcolor={Decode(AT16_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT17_JUL'		width=20		name='17'				align=center	edit='None'       bgcolor={Decode(AT17_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT18_JUL'		width=20		name='18'				align=center	edit='None'       bgcolor={Decode(AT18_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT19_JUL'		width=20		name='19'				align=center	edit='None'       bgcolor={Decode(AT19_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT20_JUL'		width=20		name='20'				align=center	edit='None'       bgcolor={Decode(AT20_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT21_JUL'		width=20		name='21'				align=center	edit='None'       bgcolor={Decode(AT21_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT22_JUL'		width=20		name='22'				align=center	edit='None'       bgcolor={Decode(AT22_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT23_JUL'		width=20		name='23'				align=center	edit='None'       bgcolor={Decode(AT23_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT24_JUL'		width=20		name='24'				align=center	edit='None'       bgcolor={Decode(AT24_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT25_JUL'		width=20		name='25'				align=center	edit='None'       bgcolor={Decode(AT25_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT26_JUL'		width=20		name='26'				align=center	edit='None'       bgcolor={Decode(AT26_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT27_JUL'		width=20		name='27'				align=center	edit='None'       bgcolor={Decode(AT27_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT28_JUL'		width=20		name='28'				align=center	edit='None'       bgcolor={Decode(AT28_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT29_JUL'		width=20		name='29'				align=center	edit='None'       bgcolor={Decode(AT29_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT30_JUL'		width=20		name='30'				align=center	edit='None'       bgcolor={Decode(AT30_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT31_JUL'		width=20		name='31'				align=center	edit='None'       bgcolor={Decode(AT31_JUL,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"	</G>                                                                                                                                                                                    "+
"                     <G> id='MM_AUG' name='8월'  HeadBgColor='#dae0ee'                                                                                                                              "+
"                         <C> id='AT1_AUG'		width=20		name='1'				align=center	edit='None'       bgcolor={Decode(AT1_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT2_AUG'		width=20		name='2'				align=center	edit='None'       bgcolor={Decode(AT2_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"                         <C> id='AT3_AUG'		width=20		name='3'				align=center	edit='None'       bgcolor={Decode(AT3_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT4_AUG'		width=20		name='4'				align=center	edit='None'       bgcolor={Decode(AT4_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"                         <C> id='AT5_AUG'		width=20		name='5'				align=center	edit='None'       bgcolor={Decode(AT5_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT6_AUG'		width=20		name='6'				align=center	edit='None'       bgcolor={Decode(AT6_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"                         <C> id='AT7_AUG'		width=20		name='7'				align=center	edit='None'       bgcolor={Decode(AT7_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT8_AUG'		width=20		name='8'				align=center	edit='None'       bgcolor={Decode(AT8_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"                         <C> id='AT9_AUG'		width=20		name='9'				align=center	edit='None'       bgcolor={Decode(AT9_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT10_AUG'		width=20		name='10'				align=center	edit='None'       bgcolor={Decode(AT10_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT11_AUG'		width=20		name='11'				align=center	edit='None'       bgcolor={Decode(AT11_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT12_AUG'		width=20		name='12'				align=center	edit='None'       bgcolor={Decode(AT12_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT13_AUG'		width=20		name='13'				align=center	edit='None'       bgcolor={Decode(AT13_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT14_AUG'		width=20		name='14'				align=center	edit='None'       bgcolor={Decode(AT14_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT15_AUG'		width=20		name='15'				align=center	edit='None'       bgcolor={Decode(AT15_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT16_AUG'		width=20		name='16'				align=center	edit='None'       bgcolor={Decode(AT16_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT17_AUG'		width=20		name='17'				align=center	edit='None'       bgcolor={Decode(AT17_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT18_AUG'		width=20		name='18'				align=center	edit='None'       bgcolor={Decode(AT18_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT19_AUG'		width=20		name='19'				align=center	edit='None'       bgcolor={Decode(AT19_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT20_AUG'		width=20		name='20'				align=center	edit='None'       bgcolor={Decode(AT20_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT21_AUG'		width=20		name='21'				align=center	edit='None'       bgcolor={Decode(AT21_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT22_AUG'		width=20		name='22'				align=center	edit='None'       bgcolor={Decode(AT22_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT23_AUG'		width=20		name='23'				align=center	edit='None'       bgcolor={Decode(AT23_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT24_AUG'		width=20		name='24'				align=center	edit='None'       bgcolor={Decode(AT24_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT25_AUG'		width=20		name='25'				align=center	edit='None'       bgcolor={Decode(AT25_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT26_AUG'		width=20		name='26'				align=center	edit='None'       bgcolor={Decode(AT26_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT27_AUG'		width=20		name='27'				align=center	edit='None'       bgcolor={Decode(AT27_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT28_AUG'		width=20		name='28'				align=center	edit='None'       bgcolor={Decode(AT28_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT29_AUG'		width=20		name='29'				align=center	edit='None'       bgcolor={Decode(AT29_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT30_AUG'		width=20		name='30'				align=center	edit='None'       bgcolor={Decode(AT30_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT31_AUG'		width=20		name='31'				align=center	edit='None'       bgcolor={Decode(AT31_AUG,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"	</G>                                                                                                                                                "+



"                     <G> id='MM_SEP' name='9월'  HeadBgColor='#dae0ee'                                                                                                                              "+
"                         <C> id='AT1_SEP'		width=20		name='1'				align=center	edit='None'       bgcolor={Decode(AT1_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT2_SEP'		width=20		name='2'				align=center	edit='None'       bgcolor={Decode(AT2_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"                         <C> id='AT3_SEP'		width=20		name='3'				align=center	edit='None'       bgcolor={Decode(AT3_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT4_SEP'		width=20		name='4'				align=center	edit='None'       bgcolor={Decode(AT4_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"                         <C> id='AT5_SEP'		width=20		name='5'				align=center	edit='None'       bgcolor={Decode(AT5_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT6_SEP'		width=20		name='6'				align=center	edit='None'       bgcolor={Decode(AT6_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"                         <C> id='AT7_SEP'		width=20		name='7'				align=center	edit='None'       bgcolor={Decode(AT7_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT8_SEP'		width=20		name='8'				align=center	edit='None'       bgcolor={Decode(AT8_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"                         <C> id='AT9_SEP'		width=20		name='9'				align=center	edit='None'       bgcolor={Decode(AT9_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT10_SEP'		width=20		name='10'				align=center	edit='None'       bgcolor={Decode(AT10_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT11_SEP'		width=20		name='11'				align=center	edit='None'       bgcolor={Decode(AT11_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT12_SEP'		width=20		name='12'				align=center	edit='None'       bgcolor={Decode(AT12_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT13_SEP'		width=20		name='13'				align=center	edit='None'       bgcolor={Decode(AT13_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT14_SEP'		width=20		name='14'				align=center	edit='None'       bgcolor={Decode(AT14_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT15_SEP'		width=20		name='15'				align=center	edit='None'       bgcolor={Decode(AT15_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT16_SEP'		width=20		name='16'				align=center	edit='None'       bgcolor={Decode(AT16_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT17_SEP'		width=20		name='17'				align=center	edit='None'       bgcolor={Decode(AT17_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT18_SEP'		width=20		name='18'				align=center	edit='None'       bgcolor={Decode(AT18_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT19_SEP'		width=20		name='19'				align=center	edit='None'       bgcolor={Decode(AT19_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT20_SEP'		width=20		name='20'				align=center	edit='None'       bgcolor={Decode(AT20_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT21_SEP'		width=20		name='21'				align=center	edit='None'       bgcolor={Decode(AT21_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT22_SEP'		width=20		name='22'				align=center	edit='None'       bgcolor={Decode(AT22_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT23_SEP'		width=20		name='23'				align=center	edit='None'       bgcolor={Decode(AT23_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT24_SEP'		width=20		name='24'				align=center	edit='None'       bgcolor={Decode(AT24_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT25_SEP'		width=20		name='25'				align=center	edit='None'       bgcolor={Decode(AT25_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT26_SEP'		width=20		name='26'				align=center	edit='None'       bgcolor={Decode(AT26_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT27_SEP'		width=20		name='27'				align=center	edit='None'       bgcolor={Decode(AT27_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT28_SEP'		width=20		name='28'				align=center	edit='None'       bgcolor={Decode(AT28_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT29_SEP'		width=20		name='29'				align=center	edit='None'       bgcolor={Decode(AT29_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT30_SEP'		width=20		name='30'				align=center	edit='None'       bgcolor={Decode(AT30_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT31_SEP'		width=20		name='31'				align=center	edit='None'       bgcolor={Decode(AT31_SEP,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"	</G>                                                                                                                                                "+
"                     <G> id='MM_OCT' name='10월'  HeadBgColor='#dae0ee'                                                                                                                              "+
"                         <C> id='AT1_OCT'		width=20		name='1'				align=center	edit='None'       bgcolor={Decode(AT1_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT2_OCT'		width=20		name='2'				align=center	edit='None'       bgcolor={Decode(AT2_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"                         <C> id='AT3_OCT'		width=20		name='3'				align=center	edit='None'       bgcolor={Decode(AT3_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT4_OCT'		width=20		name='4'				align=center	edit='None'       bgcolor={Decode(AT4_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"                         <C> id='AT5_OCT'		width=20		name='5'				align=center	edit='None'       bgcolor={Decode(AT5_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT6_OCT'		width=20		name='6'				align=center	edit='None'       bgcolor={Decode(AT6_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"                         <C> id='AT7_OCT'		width=20		name='7'				align=center	edit='None'       bgcolor={Decode(AT7_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT8_OCT'		width=20		name='8'				align=center	edit='None'       bgcolor={Decode(AT8_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"                         <C> id='AT9_OCT'		width=20		name='9'				align=center	edit='None'       bgcolor={Decode(AT9_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT10_OCT'		width=20		name='10'				align=center	edit='None'       bgcolor={Decode(AT10_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT11_OCT'		width=20		name='11'				align=center	edit='None'       bgcolor={Decode(AT11_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT12_OCT'		width=20		name='12'				align=center	edit='None'       bgcolor={Decode(AT12_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT13_OCT'		width=20		name='13'				align=center	edit='None'       bgcolor={Decode(AT13_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT14_OCT'		width=20		name='14'				align=center	edit='None'       bgcolor={Decode(AT14_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT15_OCT'		width=20		name='15'				align=center	edit='None'       bgcolor={Decode(AT15_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT16_OCT'		width=20		name='16'				align=center	edit='None'       bgcolor={Decode(AT16_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT17_OCT'		width=20		name='17'				align=center	edit='None'       bgcolor={Decode(AT17_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT18_OCT'		width=20		name='18'				align=center	edit='None'       bgcolor={Decode(AT18_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT19_OCT'		width=20		name='19'				align=center	edit='None'       bgcolor={Decode(AT19_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT20_OCT'		width=20		name='20'				align=center	edit='None'       bgcolor={Decode(AT20_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT21_OCT'		width=20		name='21'				align=center	edit='None'       bgcolor={Decode(AT21_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT22_OCT'		width=20		name='22'				align=center	edit='None'       bgcolor={Decode(AT22_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT23_OCT'		width=20		name='23'				align=center	edit='None'       bgcolor={Decode(AT23_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT24_OCT'		width=20		name='24'				align=center	edit='None'       bgcolor={Decode(AT24_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT25_OCT'		width=20		name='25'				align=center	edit='None'       bgcolor={Decode(AT25_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT26_OCT'		width=20		name='26'				align=center	edit='None'       bgcolor={Decode(AT26_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT27_OCT'		width=20		name='27'				align=center	edit='None'       bgcolor={Decode(AT27_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT28_OCT'		width=20		name='28'				align=center	edit='None'       bgcolor={Decode(AT28_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT29_OCT'		width=20		name='29'				align=center	edit='None'       bgcolor={Decode(AT29_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT30_OCT'		width=20		name='30'				align=center	edit='None'       bgcolor={Decode(AT30_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT31_OCT'		width=20		name='31'				align=center	edit='None'       bgcolor={Decode(AT31_OCT,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"	</G>                                                                                                                                                                                    "+
"                     <G> id='MM_NOV' name='11월'  HeadBgColor='#dae0ee'                                                                                                                              "+
"                         <C> id='AT1_NOV'		width=20		name='1'				align=center	edit='None'       bgcolor={Decode(AT1_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT2_NOV'		width=20		name='2'				align=center	edit='None'       bgcolor={Decode(AT2_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                                              "+
"                         <C> id='AT3_NOV'		width=20		name='3'				align=center	edit='None'       bgcolor={Decode(AT3_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT4_NOV'		width=20		name='4'				align=center	edit='None'       bgcolor={Decode(AT4_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                                              "+
"                         <C> id='AT5_NOV'		width=20		name='5'				align=center	edit='None'       bgcolor={Decode(AT5_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT6_NOV'		width=20		name='6'				align=center	edit='None'       bgcolor={Decode(AT6_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                                              "+
"                         <C> id='AT7_NOV'		width=20		name='7'				align=center	edit='None'       bgcolor={Decode(AT7_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT8_NOV'		width=20		name='8'				align=center	edit='None'       bgcolor={Decode(AT8_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                                              "+
"                         <C> id='AT9_NOV'		width=20		name='9'				align=center	edit='None'       bgcolor={Decode(AT9_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                        "+
"						  <C> id='AT10_NOV'		width=20		name='10'				align=center	edit='None'       bgcolor={Decode(AT10_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                                             "+
"                         <C> id='AT11_NOV'		width=20		name='11'				align=center	edit='None'       bgcolor={Decode(AT11_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT12_NOV'		width=20		name='12'				align=center	edit='None'       bgcolor={Decode(AT12_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT13_NOV'		width=20		name='13'				align=center	edit='None'       bgcolor={Decode(AT13_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT14_NOV'		width=20		name='14'				align=center	edit='None'       bgcolor={Decode(AT14_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT15_NOV'		width=20		name='15'				align=center	edit='None'       bgcolor={Decode(AT15_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT16_NOV'		width=20		name='16'				align=center	edit='None'       bgcolor={Decode(AT16_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT17_NOV'		width=20		name='17'				align=center	edit='None'       bgcolor={Decode(AT17_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT18_NOV'		width=20		name='18'				align=center	edit='None'       bgcolor={Decode(AT18_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT19_NOV'		width=20		name='19'				align=center	edit='None'       bgcolor={Decode(AT19_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT20_NOV'		width=20		name='20'				align=center	edit='None'       bgcolor={Decode(AT20_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT21_NOV'		width=20		name='21'				align=center	edit='None'       bgcolor={Decode(AT21_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>                       "+
"                         <C> id='AT22_NOV'		width=20		name='22'				align=center	edit='None'       bgcolor={Decode(AT22_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT23_NOV'		width=20		name='23'				align=center	edit='None'       bgcolor={Decode(AT23_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT24_NOV'		width=20		name='24'				align=center	edit='None'       bgcolor={Decode(AT24_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT25_NOV'		width=20		name='25'				align=center	edit='None'       bgcolor={Decode(AT25_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>            "+
"                         <C> id='AT26_NOV'		width=20		name='26'				align=center	edit='None'       bgcolor={Decode(AT26_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>           "+
"                         <C> id='AT27_NOV'		width=20		name='27'				align=center	edit='None'       bgcolor={Decode(AT27_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>           "+
"                         <C> id='AT28_NOV'		width=20		name='28'				align=center	edit='None'       bgcolor={Decode(AT28_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT29_NOV'		width=20		name='29'				align=center	edit='None'       bgcolor={Decode(AT29_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>          "+
"                         <C> id='AT30_NOV'		width=20		name='30'				align=center	edit='None'       bgcolor={Decode(AT30_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>            "+
"                         <C> id='AT31_NOV'		width=20		name='31'				align=center	edit='None'       bgcolor={Decode(AT31_NOV,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>            "+
"	</G>                                                                                                                                                "+


"                     <G> id='MM_DEC' name='12월'  HeadBgColor='#dae0ee'                                                                                          "+

"                         <C> id='AT1_DEC'	width=20		name='1'				align=center	edit='None'       bgcolor={Decode(AT1_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>     "+
"						  <C> id='AT2_DEC'	width=20		name='2'				align=center	edit='None'       bgcolor={Decode(AT2_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>     "+
"                         <C> id='AT3_DEC'	width=20		name='3'				align=center	edit='None'       bgcolor={Decode(AT3_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>     "+
"						  <C> id='AT4_DEC'	width=20		name='4'				align=center	edit='None'       bgcolor={Decode(AT4_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>     "+
"                         <C> id='AT5_DEC'	width=20		name='5'				align=center	edit='None'       bgcolor={Decode(AT5_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>     "+
"						  <C> id='AT6_DEC'	width=20		name='6'				align=center	edit='None'       bgcolor={Decode(AT6_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>     "+
"                         <C> id='AT7_DEC'	width=20		name='7'				align=center	edit='None'       bgcolor={Decode(AT7_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>     "+
"						  <C> id='AT8_DEC'	width=20		name='8'				align=center	edit='None'       bgcolor={Decode(AT8_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>     "+
"                         <C> id='AT9_DEC'	width=20		name='9'				align=center	edit='None'       bgcolor={Decode(AT9_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>     "+
"						  <C> id='AT10_DEC'	width=20		name='10'				align=center	edit='None'       bgcolor={Decode(AT10_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>    "+
"                         <C> id='AT11_DEC'	width=20		name='11'				align=center	edit='None'       bgcolor={Decode(AT11_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>       "+
"                         <C> id='AT12_DEC'	width=20		name='12'				align=center	edit='None'       bgcolor={Decode(AT12_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>        "+
"                         <C> id='AT13_DEC'	width=20		name='13'				align=center	edit='None'       bgcolor={Decode(AT13_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>        "+
"                         <C> id='AT14_DEC'	width=20		name='14'				align=center	edit='None'       bgcolor={Decode(AT14_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>        "+
"                         <C> id='AT15_DEC'	width=20		name='15'				align=center	edit='None'       bgcolor={Decode(AT15_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>       "+
"                         <C> id='AT16_DEC'	width=20		name='16'				align=center	edit='None'       bgcolor={Decode(AT16_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>        "+
"                         <C> id='AT17_DEC'	width=20		name='17'				align=center	edit='None'       bgcolor={Decode(AT17_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>       "+
"                         <C> id='AT18_DEC'	width=20		name='18'				align=center	edit='None'       bgcolor={Decode(AT18_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>      "+
"                         <C> id='AT19_DEC'	width=20		name='19'				align=center	edit='None'       bgcolor={Decode(AT19_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>        "+
"                         <C> id='AT20_DEC'	width=20		name='20'				align=center	edit='None'       bgcolor={Decode(AT20_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>       "+
"                         <C> id='AT21_DEC'	width=20		name='21'				align=center	edit='None'       bgcolor={Decode(AT21_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>        "+
"                         <C> id='AT22_DEC'	width=20		name='22'				align=center	edit='None'       bgcolor={Decode(AT22_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>        "+
"                         <C> id='AT23_DEC'	width=20		name='23'				align=center	edit='None'       bgcolor={Decode(AT23_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>       "+
"                         <C> id='AT24_DEC'	width=20		name='24'				align=center	edit='None'       bgcolor={Decode(AT24_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>       "+
"                         <C> id='AT25_DEC'	width=20		name='25'				align=center	edit='None'       bgcolor={Decode(AT25_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>       "+
"                         <C> id='AT26_DEC'	width=20		name='26'				align=center	edit='None'       bgcolor={Decode(AT26_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>       "+
"                         <C> id='AT27_DEC'	width=20		name='27'				align=center	edit='None'       bgcolor={Decode(AT27_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>       "+
"                         <C> id='AT28_DEC'	width=20		name='28'				align=center	edit='None'       bgcolor={Decode(AT28_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>       "+
"                         <C> id='AT29_DEC'	width=20		name='29'				align=center	edit='None'       bgcolor={Decode(AT29_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>       "+
"                         <C> id='AT30_DEC'	width=20		name='30'				align=center	edit='None'       bgcolor={Decode(AT30_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>       "+
"                         <C> id='AT31_DEC'	width=20		name='31'				align=center	edit='None'       bgcolor={Decode(AT31_DEC,'H','#F2AC47','P','#46B8FF','R','#80AD80','M','#101D80','#FEEFEF')} </C>       "+
"	</G>                                                                                                                                                                                    ";
		   }











			cfStyleGrid_New(form1.grdT_DI_CHANGE,15,"false","false");




		}

        /********************************************
         * 17. 승인, 기각 버튼 처리					*
         ********************************************/
		function fnc_Append(yn_var) {

            var msg = "";

			// 데이터셋의 헤더 정보 설정.
			dsT_CM_DUMMY.setDataHeader("APP_CMT:STRING, "+		//  결재자 의견 Container
										"APP_CMT1:STRING");		// 예비
			dsT_CM_DUMMY.AddRow();


            if(yn_var == "Y"){
                msg = "결재처리를";
            }else{
				if(obj.app_cmt == ""){

		            window.showModalDialog("../../../Ehr/hr/gun/gunc092.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

		            if(obj.app_cmt == ""){
		                    alert("부결 사유를 입력후 처리바랍니다.\n \n작업은 취소되었습니다.");
			            	return false;
					}
				}
                msg = "부결처리를";
            }

			dsT_CM_DUMMY.NameValue(1,"APP_CMT") = obj.app_cmt;   // 결재의견 Container

            if (confirm(msg+" 하시겠습니까?")) {

				dsT_DI_CHANGE.UserStatus(1) = 1;

				trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_CHANGE=dsT_DI_CHANGE,I:dsT_CM_DUMMY=dsT_CM_DUMMY)";

				// DPT_CD 가져오는 차이
				// 가변적으로  Column을 가져와야함으로 DPT_CD을 안가져옴....
				// 그러나 나머지것은 다른 부서것을 가져올수도 있게 하였음....

				 	trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_CM_DUMMY=dsT_CM_DUMMY)";
					
					trT_DI_APPROVAL.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna072.cmd.GUNA072CMD&S_MODE=SAV&APP_YN="+yn_var+"&GUN_GBN="+dsTemp.NameValue(1,"GUN_GBN")+"&GUN_DPT="+dsTemp.NameValue(1,"GUN_DPT")+"&PENO_NO="+dsTemp.NameValue(1,"PENO_NO")+"&SEQ_NO="+dsTemp.NameValue(1,"SEQ_NO")+"&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&DPT_CD="+dsT_DI_CHANGE.NameValue(1,"DPT_CD");
					
					//prompt(this, trT_DI_APPROVAL.action);
					
					trT_DI_APPROVAL.post();

            }

            window.close();

		}

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_CHANGE)		   |
    | 3. 사용되는 Table List(T_DI_CHANGE) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_CHANGE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. 조회용 DataSet (휴일날짜 표시)     |
    | 2. 이름 : dsT_DI_PLAN04                     |
    | 3. Table List : T_DI_HOLIDAY                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_APPROVAL)	   |
    | 3. 사용되는 Table List(T_DI_APPROVAL) 			   |
    +------------------------------------------------------>
	<Object ID="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_PLAN)		|
    | 3. 사용되는 Table List(T_DI_PLAN)	            |
    +--------------------------------------------------->
    <Object ID ="trT_DI_CHANGE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="sample_tr01(I:T_DI_CHANGE=T_DI_CHANGE)">
    </Object>
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_DI_APPROVAL                                      |
    | 3. Table List : T_DI_APPROVAL                                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <Object ID="dsT_CM_DUMMY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_CHANGE Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
		fnc_ChangeGrid();//그리드 변경 처리


            //결재자 조회  --  연차촉진제는 조회시 이미 수행 완료되었슴.
            fnc_SearchApprover();


            document.getElementById("txtORD_NO").innerText      = dsT_DI_APPROVAL.NameValue(1, "REQ_NO");
            document.getElementById("txtENO_NM").innerText      = dsT_DI_APPROVAL.NameValue(1, "IENO_NM");
            document.getElementById("txtDPT_NM").innerText      = dsT_DI_APPROVAL.NameValue(1, "IDPT_NM");
            document.getElementById("txtJOB_NM").innerText      = dsT_DI_APPROVAL.NameValue(1, "IJOB_NM");

            		document.getElementById("btn_approval").style.display = "none";
        var eno_no = "";
		var app_yn = "";

                for(var i= 1; i <= dsT_DI_APPROVAL.CountRow; i++){
                    eno_no = dsT_DI_APPROVAL.NameValue(i,"ENO_NO");		//결재자
					app_yn = dsT_DI_APPROVAL.NameValue(i,"APP_YN");		//결재여부

			            //해당 결재자 의견입력 준비.
					if(eno_no == gusrid &&  app_yn == "" ){
						document.getElementById("btn_approval").style.display = "";
						dsT_DI_APPROVAL.NameValue(i,"REMARK1") = "의견입력";
						break;
					}
                }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_DI_CHANGE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<Script For=dsT_DI_HOLIDAY Event="OnLoadCompleted(iCount)">

		if(dsTemp.NameValue(1,"GUN_GBN")=="A"){

					        var pis_yy = dsTemp.NameValue(1,"REQ_NO").substr(0,4);	//해당년도
							var lday = 31;


							grdT_DI_CHANGE.ColumnProp('MM_JUL', 'Name') = pis_mm.substr(0,2) +"월";
							grdT_DI_CHANGE.ColumnProp('MM_AUG', 'Name') = pis_mm.substr(2,2) +"월";
							grdT_DI_CHANGE.ColumnProp('MM_SEP', 'Name') = pis_mm.substr(4,2) +"월";

							grdT_DI_CHANGE.ColumnProp('MM_OCT', 'Name') = pis_mm.substr(6,2) +"월";
							grdT_DI_CHANGE.ColumnProp('MM_NOV', 'Name') = pis_mm.substr(8,2) +"월";
							grdT_DI_CHANGE.ColumnProp('MM_DEC', 'Name') = pis_mm.substr(10,2) +"월";

					            //휴일 설정(토요일, 일요일)
								for(i=1;i<=iCount;i++){
					                grdT_DI_CHANGE.ColumnProp(dsT_DI_HOLIDAY.NameValue(i,"COL_NM")+"", 'HeadBgColor') = "#F47380";
					            }

							//LAST Day 이후 불가 - 1st
					        lday = fnc_Lastday(pis_yy,pis_mm.substr(0,2)) ;
								for(i=lday+1;i<=31;i++){
					                grdT_DI_CHANGE.ColumnProp("AT"+i+"_OCT_V", 'HeadBgColor') = "#F47380";
					            }

							//LAST Day 이후 불가 - 2nd
					        lday = fnc_Lastday(pis_yy,pis_mm.substr(2,2)) ;
								for(i=lday+1;i<=31;i++){
					                grdT_DI_CHANGE.ColumnProp("AT"+i+"_NOV_V", 'HeadBgColor') = "#F47380";
					            }

							//LAST Day 이후 불가 -3th
					        lday = fnc_Lastday(pis_yy,pis_mm.substr(4,2)) ;
								for(i=lday+1;i<=31;i++){
					                grdT_DI_CHANGE.ColumnProp("AT"+i+"_DEC_V", 'HeadBgColor') = "#F47380";
					            }
		}


    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
        document.getElementById("btn_approval").style.display = "none";
        fnc_SearchApprover();
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>
	<!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick 처리 - 부결사유 조회        |
    +------------------------------------------------------>
  <script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){

		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		window.showModalDialog("../../../Ehr/hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	}

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "의견입력" ){

		window.showModalDialog("../../../Ehr/hr/but/buta023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

	}
  </script>
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">


    </Script>

<!--**************************************************************************************
*                                       												 *
*	BODY START																			 *
*                                       												 *
***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- 캘린더 프레임-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

	<!-- form 시작 -->
	<form name="form1">



	<!-- 버튼 테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35"  width="83" class="searchState" align="center">근태구분</td>
			<td  width="120">
			<input id="txtGUN_GBN" size="20"  class="input_ReadOnly" readOnly>
            </td>
			<td height="35" class="paddingTop5" align="right">
                <span id="btn_approval" style="display:none">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','../../images/button/btn_ApprovalOver.gif',1)">  <img src="../../images/button/btn_ApprovalOn.gif"   name="imgApproval" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('Y');"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','../../images/button/btn_RejectionOver.gif',1)">  <img src="../../images/button/btn_RejectionOn.gif"   name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('N');"></a>
                </span>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->
<!-- 결재 정보  시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
		<td>
			<!-- 기안자 정보 시작 -->
			<table width="220" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td>
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
							<colgroup>
								<col width="100"></col>
								<col width="*"></col>
							</colgroup>
							<tr height="28">
								<td align="center" class="blueBold">품의번호</td>
								<td class="padding2423">
									<input id="txtORD_NO" size="20" class="input_ReadOnly" readOnly>
								</td>
                            </tr>
                            <tr height="27">
								<td align="center" class="blueBold">소속</td>
								<td class="padding2423">
                                    <input id="txtDPT_NM" size="20" class="input_ReadOnly" readOnly>
								</td>
							</tr>
                            <tr height="27">
								<td align="center" class="blueBold">직위</td>
								<td class="padding2423">
                                    <input id="txtJOB_NM" size="20" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							<tr height="27">
								<td align="center" class="blueBold">상신자</td>
								<td class="padding2423">
                                    <input id="txtENO_NM" size="20" class="input_ReadOnly" readOnly>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- 기안자 정보 끝 -->
        </td>
        <td width="30">&nbsp;&nbsp;&nbsp;</td>
        <td>
        	<!-- 결재선 정보 테이블 시작 -->
			<table width="750" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:750px;height:110px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Format"				value="
            					<C> id='SEQ_NO'		width=100	name='구분'		align=center	Value={DECODE(ENO_NO,'100019','협조','결재')}</C>
								<C> id='ENO_NM'		width=120	name='결재자'	align=center</C>
								<C> id='JOB_NM'		width=110	name='직위'		align=center	</C>
                                <C> id='DPT_NM'		width=150	name='부서'		align=left		</C>
								<C> id='APP_YN'		width=160	name='결재상태'	align=left		Value={DECODE(APP_YN,'Y','승인','N','부결','미결')&' '&APP_YMD} </C>
								<C> id='REMARK1'	width=87	name='의견'		align=center 	Color='Blue'	</C>
							">
							<param name="wmode" value="transparent" >
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                </tr>
            </table>
        	<!-- 결재선 정보 테이블 끝 -->
        </td>
    </tr>
</table>
<!-- 결재 정보  끝 -->
<br>
	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_CHANGE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:450px;">
						<param name="DataID" value="dsT_DI_CHANGE">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td  width="100%" align="left" class="paddingTop5">
			<!-- 조회 상태 테이블 시작 -->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td colspan = "9" valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
							</tr>
						    <tr>
						        <td  align="right" class="searchState" width="100" >연&nbsp;&nbsp;&nbsp;차:H&nbsp;</td>
						        <td  width="80" bgcolor="#F2AC47"></td>
						        <td  width="80" >&nbsp;</td>
						        <td  align="right" class="searchState" width="100" >오전 반차:P&nbsp;</td>
						        <td  width="80" bgcolor="#46B8FF"></td>
						        <td  width="80" >&nbsp;</td>
						        <td  align="right" class="searchState" width="100" >오후 반차:R&nbsp;</td>
						        <td  width="80" bgcolor="#80AD80"></td>
						        <td  width="80" >&nbsp;</td>
						        <td  align="right" class="searchState" width="100" >월&nbsp;&nbsp;&nbsp;차:M&nbsp;</td>					        
        						<td  width="80" bgcolor="#101D80">
						    </tr>

						</table>
					</td>
				</tr>
			</table>
			<!-- 조회 상태 테이블 끝 -->
			</td>
		</tr>
	</table>
	<!-- 내용 조회 그리드 데이블 끝-->


	</form>
	<!-- form 끝 -->

</body>
</html>