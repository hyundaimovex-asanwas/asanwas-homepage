<!--
*****************************************************************************
* @source      : yaca020_2013.jsp                                              *
* @description : 귀속2013년도 연말정산자료등록 PAGE                       *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                  *
*----------------------------------------------------------------------------
* 2013/12/17            이동훈             수정중                                             *
*****************************************************************************
-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<%

    String ROLE_CD = box.getString("SESSION_ROLE_CD");
    String YAC_AUTHO  = box.getString("SESSION_YAC_AUTHO");
    String ENO_NO    = box.getString("SESSION_ENONO");

    //ROLE_CD가 IT인지 여부
    boolean itMaster = false;

    if(ROLE_CD.equals("1001")) {
    	itMaster = true;
    }

    //관리자인지 아닌지 여부
    boolean isMaster = false;

     if(YAC_AUTHO.equals("M")) {
         isMaster = true;
      }

%>

<html>
<head>
<title>연말정산자료등록(yaca020_2013년도)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<link href="/css/general2.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

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
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca020.cmd.YACA020CMD";
        var params = null;

        var dataClassName_01 = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca021.cmd.YACA021CMD";
        var params_01 = null;

		var submit_chk = "N";
		
        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {

            //연말정산 조회

            params = "&S_MODE=SHR_13"
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
            document.getElementById("txtHOSPT_AMT").value  = dsT_AC_RETACC.NameValue(1, "HOSPT_AMT");//의료비 공제 최소금액
            document.getElementById("txtMIN_CARD_AMT").value  = dsT_AC_RETACC.NameValue(1, "MIN_CARD_AMT");//신용카드 공제 최소금액

			if(dsT_AC_RETACC.NameValue(1, "FUN_CNT") == "Y" && submit_chk == "N"){

				fnc_disableInput();
				
			}else{

				fnc_enableInput();
				
			}

            return;
            
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
        	
                dsT_CM_COMMON_BK.DataID = dataClassName+"&S_MODE=ITM_SHR";
                dsT_CM_COMMON_BK.Reset();
                
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
         * 05. 인쇄 함수                                *
         ********************************************/
        function fnc_Print() {
        	
			var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
			var PIS_YYMM = document.getElementById("txtPIS_YY_SHR").value;

			var url = "yaca020_PV_13.jsp?ENO_NO="+ENO_NO+"&PIS_YYMM=" + PIS_YYMM;
			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;
	        
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

            frame = window.external.GetFrame(window);
            frame.CloseFrame();
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

            //사번을 로그인한 사번으로 설정한 다음 기본정보를 가져온다.
            document.getElementById("txtENO_NO_SHR").value = "<%=ls_UserId %>";

            if(today.substring(5,7) == '01' || today.substring(5,7) =='02'||today.substring(5,7) =='03' )
            {
              document.getElementById("txtPIS_YY_SHR").value =  today.substring(0,4)-1;
            }
            else
            {
              document.getElementById("txtPIS_YY_SHR").value = today.substring(0,4);
            }

<%
    //관리자가 아닐 경우 타인은 조회가 되지 않게
    if(!isMaster) {
%>
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            fnc_ChangeStateElement(false, "ImgEnoNo");
            document.getElementById("ImgEnoNo").style.display = "none";

            fnc_ChangeStateElement(false, "txtADDRESS");
            fnc_ChangeStateElement(false, "ImgZipNo");
            document.getElementById("ImgZipNo").style.display = "none";
			//document.getElementById("imgPrint").style.display = "none";

<%
    }
%>

			if(dsT_AC_RETACC.NameValue(1, "CLS_TAG") == "Y" ){
				document.getElementById("chkCLS_TAG").checked = true;
			}else{
				document.getElementById("chkCLS_TAG").checked = false;
			}
			
			//alert(dsT_AC_RETACC.NameValue(1, "FUN_CNT") );
			
			if(dsT_AC_RETACC.NameValue(1, "FUN_CNT") == "Y" ){
				alert("전산제출한 상태입니다.\n수정은 불가능합니다.");
			}

			//사원정보를 가져오고 등록한 중간정산 리스트를 가져온다.
            fnc_SearchEmpNo();

            cfStyleGrid(form1.grdT_AC_FAMILY,0,"false","false");      // Grid Style 적용
    
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
            params = "&S_MODE=SAV_CLS"
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
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmpNo();
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
	                params = "&S_MODE=SAV_END"
	                   	+ "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value
                   	    + "&SUBMIT_TAG=Y"
                        + "&PIS_YY="+PIS_YY;            	                   	    
	            
		            //DataSet을 입력상태로 변경
		            dsT_AC_RETACC.UseChangeInfo = false;
		
		            trT_AC_RETACC_SAV.KeyValue = "TR_SAV"
		                                       + "(I:dsT_AC_RETACC=dsT_AC_RETACC)";
		            trT_AC_RETACC_SAV.action = dataClassName+params;
		            trT_AC_RETACC_SAV.post();
		
		            }
        	}else{

				alert("이미 전산제출하셨습니다.");

<%
//관리자 경우
if(isMaster) {
%>
		            if(confirm("담당자이시군요.\n전산제출을 취소하시겠습니까?")) {

		                //연말정산 전산제출 취소
		                params = "&S_MODE=SAV_END"
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
			
<%
}
%>
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

            params_01 = "&S_MODE=SHR_13"
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

             params_01 = "&S_MODE=DEL"
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
            
            
            var href_page = "/hr/yac/yaca022_13.jsp"
                          + "?TYPE=INS"
                          + "&PIS_YY="+PIS_YY
                          + "&ENO_NO="+ENO_NO
                          + "&ENO_NM="+ENO_NM
                          + "&DPT_NM="+DPT_NM
                          + "&JOB_NM="+JOB_NM;                          

            window.showModalDialog(href_page, "", "dialogWidth:660px; dialogHeight:690px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList_01();
           }

           /* 06.  연금저축공제등록   */
          function fnc_RegPension() {

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
           var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
           var DPT_NM = document.getElementById("txtDPT_NM").value;
           var JOB_NM = document.getElementById("txtJOB_NM").value;

           var href_page = "/hr/yac/yaca060_13.jsp"
                      + "?TAX_INCOME="+dsT_AC_RETACC.NameValue(1, "TAX_INCOME")
                      + "&HOSPT_AMT="+dsT_AC_RETACC.NameValue(1, "HOSPT_AMT")
                      + "&MIN_CARD_AMT="+dsT_AC_RETACC.NameValue(1, "MIN_CARD_AMT")
                      + "&PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&ENO_NM="+ENO_NM
                      + "&DPT_NM="+DPT_NM
                      + "&JOB_NM="+JOB_NM
                      + "&HOL_YN="+dsT_AC_RETACC.NameValue(1, "HOL_YN")
                      + "&END_YN="+submit_chk                      
           ;

            window.showModalDialog(href_page, "", "dialogWidth:850px; dialogHeight:650px; help:No; resizable:Yes; status:No; scroll:Yes; center:Yes;");
           }


          /* 07.  의료비공제등록   */
          function fnc_RegHospital(row) {

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
           var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
           var DPT_NM = document.getElementById("txtDPT_NM").value;
           var JOB_NM = document.getElementById("txtJOB_NM").value;

           var href_page = "/hr/yac/yaca030_13.jsp"
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
           ;
          
           
            window.showModalDialog(href_page, "", "dialogWidth:850px; dialogHeight:650px; help:No; resizable:Yes; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList_01();
          }
          
          /* 08.  기부금공제등록   */
          function fnc_RegDonation(row) {

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
           var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
           var DPT_NM = document.getElementById("txtDPT_NM").value;
           var JOB_NM = document.getElementById("txtJOB_NM").value;

           var href_page = "/hr/yac/yaca040_13.jsp"
                      + "?PIS_YY="+PIS_YY
                      + "&ENO_NO="+ENO_NO
                      + "&ENO_NM="+ENO_NM
                      + "&DPT_NM="+DPT_NM
                      + "&JOB_NM="+JOB_NM
                      + "&REL_CD="+dsT_AC_FAMILY.NameValue(row, "REL_CD")
                      + "&NAM_KOR="+dsT_AC_FAMILY.NameValue(row, "NAM_KOR")                      
                      + "&CET_NO="+dsT_AC_FAMILY.NameValue(row, "CET_NO")     
                      + "&END_YN="+submit_chk                          
           ;

            window.showModalDialog(href_page, "", "dialogWidth:850px; dialogHeight:650px; help:No; resizable:Yes; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList_01();           
          }

          /* 09.  종전근무지등록   */
          function fnc_Dutyplace() {

           var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;
           var ENO_NO = document.getElementById("txtENO_NO_SHR").value;
           var ENO_NM = document.getElementById("txtENO_NM_SHR").value;
           var DPT_NM = document.getElementById("txtDPT_NM").value;
           var JOB_NM = document.getElementById("txtJOB_NM").value;

           if(ENO_NO.substring(1,3) != '13'){
        	   
        	   alert("중도입사자가 아니십니다.\n중도입사자만 입력하는 메뉴입니다.");
			   return false;           
           }           
  
           var href_page = "/hr/yac/yaca023_13.jsp"
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
<Object ID="dsT_CM_PERSON"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<Object ID="dsT_AC_RETACC"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton               |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_RETACC)           |
    | 3. 사용되는 Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
<Object ID="trT_AC_RETACC"
	ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>

<Object ID="trT_AC_RETACC_SAV"
	ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>

<!-----------------------------------------------------+
    | 부양가족 사항                                         						|
    1 1. 조회용 DataSet                                     			|
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_FAMILY)            |
    | 3. 사용되는 Table List(T_AC_FAMILY)                   	|
    +------------------------------------------------------->
<Object ID="dsT_AC_FAMILY_OLD"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<Object ID="dsT_AC_FAMILY"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<!-----------------------------------------------------+
    | 부양가족 사항                                        |
    1 1. 자료 저장 및 조회용 Data Transacton               |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_FAMILY)           |
    | 3. 사용되는 Table List(T_AC_FAMILY)                  |
    +------------------------------------------------------>
<Object ID="trT_AC_FAMILY"
	ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
            dsT_CM_PERSON.dataid = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca020.cmd.YACA020CMD&S_MODE=SHR_01&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;
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
        //alert("작업을 완료 하였습니다!");
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
        for(var i=1; i<=dsT_AC_RETACC.CountRow; i++) {
            dsT_AC_RETACC.NameValue(i, "STATUS") = bCheck;
        }

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
        fnc_SearchList();
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

	        if(PIS_YY != "2013"){        	
	        var href_page = "/hr/yac/yaca022.jsp"
	                      + "?TYPE=UPT"
	                      + "&PIS_YY="+PIS_YY
	                      + "&ENO_NO="+ENO_NO
	                      + "&CET_NO="+dsT_AC_FAMILY.NameValue(row, "CET_NO")
	                      ;
	        window.showModalDialog(href_page, "", "dialogWidth:660px; dialogHeight:690px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
	        }else if(PIS_YY == "2013"){
		        var href_page = "/hr/yac/yaca022_13.jsp"
                    + "?TYPE=UPT"
                    + "&PIS_YY="+PIS_YY
                    + "&ENO_NO="+ENO_NO
                    + "&CET_NO="+dsT_AC_FAMILY.NameValue(row, "CET_NO")
                    + "&ENO_NM="+ENO_NM
                    + "&DPT_NM="+DPT_NM
                    + "&JOB_NM="+JOB_NM;                           

      			window.showModalDialog(href_page, "", "dialogWidth:660px; dialogHeight:690px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");        	
	        }
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

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15"
	marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();"
	onload="fnc_OnLoadProcess();">
<!-- 파일 전송을 위해 -->
<iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no"></iframe>

<!-- 캘린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0"
	src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no">
</iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="23"><img src="/images/common/barHead.gif" width="23"height="25"></td>
				<td valign="top" background="/images/common/barGreenBg.gif"class="barTitle">연말정산자료등록</td>
				<td align="right" class="navigator">HOME/정산세무/연말정산/<fontcolor="#000000">연말정산자료등록</font></td>
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
	 	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_submit.gif',1)">
		<img src="/images/button/btn_submit.gif" name="imgSave" width="100" height="20" border="0" align="absmiddle" onClick="fnc_Submit()"></a>			

		&nbsp;&nbsp;&nbsp;	
			
		<a href="http://www.yesone.go.kr/index.jsp" target="_blank" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgNts','','/images/button/btn_NtsOver.gif',1)">
		<img src="/images/button/btn_NtsOn.gif" name="imgNts" width="65" height="20" border="0" align="absmiddle"></a> &nbsp;&nbsp; 
			
		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)">
		<img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>

        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">
		<img src="/images/button/btn_PrintOn.gif" name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> 
        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">
		<img src="/images/button/btn_ExitOn.gif" name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 --> 



<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="greenTable">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="200"></col>
						<col width="80"></col>
						<col width="140"></col>
						<col width=""></col>
					</colgroup>
					<tr>
						<td align="right" class="searchState">귀속년도&nbsp;</td>
						<td class="padding2423">
<%
if (!isMaster) {
%> 
				<input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="5" class="input_ReadOnly" readonly> 
<%
 } else {
 %> 
 				<input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="5"> 
 <%
 }
 %>
						</td>
						<td align="right" class="searchState">사번&nbsp;</td>
						<td class="padding2423">
                             <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength="8" onkeypress="javascript:if(event.keyCode==13) {fnc_GetNm();fnc_SearchList();}" style="ime-mode:disabled"> 
							<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="14"onkeypress="javascript:if(event.keyCode==13) {fnc_Getcd();fnc_SearchList();}"> 
							<img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle"
							onclick="fnc_ClickEmpPopup();fnc_SearchList();" onMouseOut="MM_swapImgRestore()"
							onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"style="cursor:hand;"> 
							<input type="hidden" id="hidEMPL_DPT_CD">
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
		<td class="paddingTop8">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 --> 


<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
				<col width="40"></col>
				<col width="80"></col>
				<col width="40"></col>
				<col width="60"></col>
				<col width="55"></col>
				<col width="80"></col>
				<col width="40"></col>
				<col width=""></col>
				</colgroup>
			<tr>
				<td align="center" class="creamBold">소속</td>
				<td class="padding2423">
				<input id="txtDPT_NM" style="width:100%;" class="input_ReadOnly" readonly></td>
				<td align="center" class="creamBold">직위</td>
				<td class="padding2423">
				<input id="txtJOB_NM" style="width:100%;" class="input_ReadOnly" readonly></td>
				<td align="center" class="creamBold">우편번호</td>
				<td class="padding2423">
				<input id="txtZIP_NO" size="10" maxlength="10" class="input_ReadOnly" readonly> 
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgZipNo','','/images/button/btn_HelpOver.gif',1)"></a>
				</td>
				<td align="center" class="creamBold">주소</td>
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

<BR>

<!--버튼테이블시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
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
								<td align="right" valign="bottom" class="searchState">
									<input type="checkbox" name="chkCLS_TAG" id="chkCLS_TAG" onclick="checkFamily(this)" style="border:0">선택
								</td>
								<td align="left" valign="bottom" class="searchState">
								<font color = "blue">※인적공제 항목이 전년과 동일한 경우에만 체크</font>
								</td>
								<td align="right" valign="bottom" class="searchState">
								※상세내역을 원하시면 해당내역을 더블클릭
								</td>
								<td height="25" class="paddingTop5" align="right">
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)">
								<img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete_01()"></a>
								</td>								
							</tr>
				</table>
				<!-- 조회 상태 테이블 끝 --> 
				
				
				<!-- 내용 조회 그리드 테이블 시작-->
				<table width="1090" border="0" cellspacing="0" cellpadding="0">
							<tr align="center">
								<td>
								<comment id="__NSID__"> 
								<object id="grdT_AC_FAMILY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B"
									style="width:1090px;height:435px;">
									<param name="DataID" 				value="dsT_AC_FAMILY">
									<param name="Editable" 			value="false">
									<param name="DragDropEnable" 	value="true">
									<param name="SortView" 			value="Left">
									<param name="Format"
										value='
                                          <FC> id=NO     				width=15        align=center       name=순                suppress=2  </FC>
                                          <FC> id=REL_NM      		width=85      	align=left	       name=관계              	suppress=2  </FC>
                                          <FC> id=NAM_KOR     		width=43        align=left       		name=성명              	suppress=2  </FC>
                                          <C> id=CET_NO       		width=90        align=center       name=주민번호          	suppress=2  </C>
                                          <C> id=BAS_MAN      		width=30        align=center       name="기본;공제"      suppress=2  </C>
                                          <C> id=GOL_70       		width=30        align=center       name=경로              	suppress=2  </C>
                                          <C> id=TRB_MAN      		width=30        align=center       name="장애;인"        suppress=2  </C>
                                          <C> id=WCT_MAN      		width=30        align=center       name="부녀;자"         suppress=2  </C>
                                          <C> id=RCH_MAN      		width=30        align=center       name="6세;이하"      suppress=2  </C>
                                          <C> id=ONE_PARENT      	width=30        align=center       name="한부;모"         suppress=2  </C>
                                          <C> id=INP_MAN      		width=30        align=center       name="출생;입양"      suppress=2  </C>
                                          <C> id=GBN_NM       		width=40        align=left     		name=구분                  </C>
                                          <C> id=LIN_AMT      		width=65        align=right        name=보험료              </C>
                                          <C> id=MED_AMT      		width=65        align=right        name=의료비              </C>
                                          <C> id=EDU_AMT      		width=65        align=right        name=교육비              </C>
                                           
                                          <G> name=신용카드등    HeadBgColor=#F7DCBB                                          
                                          <C> id=CARD_AMT     		width=65       align=right        name="신용카드"   </C>
                                          <C> id=DIR_CARD_AMT 	width=65       align=right        name="직불/선불"  </C>
                                          <C> id=CASH_AMT     		width=65       align=right        name="현금영수증"  </C>
                                          <C> id=MARKET_AMT     	width=65       align=right        name=전통시장   </C>
                                          <C> id=PUBLIC_AMT      	width=65       align=right        name="대중교통" </C>                                          
                                          </G>
                                          <C> id=LC_AMT      		width=65        align=right        name=기부금              </C>                                                                                   

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
               <td class="padding2423">- 총근로소득액은&nbsp;
                        <input name=txtSALT_AMT id=txtSALT_AMT size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       	원이며 이중 비과세(소득외)소득은 
                        <input name=txtFREE_INCOME id=txtFREE_INCOME size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       	원이고 과세대상급여는     
                        <input name=txtTAX_INCOME id=txtTAX_INCOME size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       	원입니다.                                     
                    </td>
                    </tr>
                    <tr>
                    <td class="padding2423">- 의료비 공제를 받을 수 있는 최소금액은&nbsp;
                        <input name=txtHOSPT_AMT id=txtHOSPT_AMT size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       원입니다.
                    </td>
                    </tr>
                    <tr>
                    <td class="padding2423">- 신용카드 공제를 받을 수 있는 최소 사용금액은&nbsp;
                        <input name=txtMIN_CARD_AMT id=txtMIN_CARD_AMT size="15" maxlength="3" style="ime-mode:disabled; text-align:right"  class="input_ReadOnly" readonly>
                       원입니다.
           </td>
      </tr>
</table>

<!--총급여 표시 끝 -->
</form>


<!-- form 끝 -->

</body>
</html>


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
        <C>Col=HOSPT_AMT        		Ctrl=txtHOSPT_AMT           	Param=text      </C>
        <C>Col=MIN_CARD_AMT     	Ctrl=txtMIN_CARD_AMT        	Param=text      </C>
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