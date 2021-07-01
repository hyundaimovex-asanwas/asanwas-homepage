<!--
    ************************************************************************************
    * @Source         : edue020.jsp                                                    
    * @Description    : 과정개설요청서 PAGE                                            
    * @Developer Desc :                                                                
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                           
    *-------------+-----------+--------------------------------------------------------+
    * 2016/05/23 |  정영식   | 소스이전                                              
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>



<html>

    <head>
    <title>과정개설요청서</title>
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


        var year    = gcurdate.substr(0,4);
        
        var ord_no;
        
        var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
        	
        	var STR_YMD  = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD  = document.getElementById("txtEND_YMD_SHR").value;
            
            var EDU_NM   = document.getElementById("txtEDU_NM_SHR").value;
            var ENO_NO   = document.getElementById("txtENO_NO_SHR").value;
            var ENO_NM   = document.getElementById("txtENO_NM_SHR").value;
            var DPT_CD   = document.getElementById("hidEMPL_DPT_CD").value;
            
            
            cfCheckDate(document.getElementById("txtSTR_YMD_SHR"));
            cfCheckDate(document.getElementById("txtEND_YMD_SHR"));

          
            if(STR_YMD != "" && END_YMD != "") {
                // 교육시작일의 FROM ~ TO일자 비교
                if(removeChar(STR_YMD,'-') > removeChar(END_YMD,'-')) {
                    alert("교육시작일 FROM일자는 반드시 교육시작일 TO일자보다 작아야합니다.");
                    document.getElementById("txtSTR_YMD_SHR").focus();
                    return;
                }
            }

            if(ENO_NO != "" && ENO_NM == "") {
                alert("잘못된 사번입니다.");
                document.getElementById("txtENO_NO_SHR").focus();
                return;
            }

            dsT_ED_OPENRQST.ClearData();

            dsT_ED_OPENRQST.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue020.cmd.EDUE020CMD&S_MODE=SHR_01&STR_YMD="+STR_YMD+"&END_YMD="+END_YMD+"&EDU_NM="+EDU_NM+"&ENO_NO="+ENO_NO+"&DPT_CD="+DPT_CD;

            dsT_ED_OPENRQST.Reset();

            form1.grdT_ED_OPENRQST.Focus();

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

            var dpt_cd   = document.getElementById("txtDPT_CD").value;
            var job_cd   = document.getElementById("txtJOB_CD").value;

            trT_ED_OPENRQST.KeyValue = "tr01(I:SAV=dsT_ED_OPENRQST)";
            
            trT_ED_OPENRQST.action  = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue020.cmd.EDUE020CMD"
					                                    + "&S_MODE=SAV"
					                                    + "&DPT_CD="+dpt_cd
					                                    + "&JOB_CD="+job_cd;

            trT_ED_OPENRQST.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            var status = 0;

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_ED_OPENRQST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            if(document.getElementById("cmbSTS_GBN").value != "1") {
                alert("상태가 신청 상태일때만 삭제가 가능합니다.");
                return;
            }

            status = dsT_ED_OPENRQST.RowStatus(dsT_ED_OPENRQST.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_ED_OPENRQST.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("과정명[" + dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition,"EDU_TXT") + "] 사번 [" + dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition,"ENO_NO") + "] 자료를 제거하시겠습니까?") == false) return;
            	dsT_ED_OPENRQST.DeleteRow(dsT_ED_OPENRQST.RowPosition);

            if (status != 1) {

               trT_ED_OPENRQST1.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue020.cmd.EDUE020CMD&S_MODE=DEL";
               trT_ED_OPENRQST1.post();

             }

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_ED_OPENRQST.SetColumn(form1.grdT_ED_OPENRQST.GetColumnID(0));
            form1.grdT_ED_OPENRQST.Focus();

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

            if (dsT_ED_OPENRQST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_ED_OPENRQST.GridToExcel("과정개설요청서", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_ED_OPENRQST.CountColumn == 0) {
                dsT_ED_OPENRQST.setDataHeader("ORD_NO:STRING, ENO_NO:STRING:NOTNULL, ENO_NM:STRING:NOTNULL, DPT_CD:STRING, DPT_NM:STRING, JOB_CD:STRING, JOB_NM:STRING, EDU_STR_YMD:STRING, EDU_END_YMD:STRING, EDU_TXT:STRING, EDU_NM:STRING, EDU_GBN_CD:STRING, EDU_GBN_NM:STRING, EDU_GBN_TXT:STRING, PLACE_TXT:STRING, FIX_NO:INT, GOAL_TXT:STRING, CONTENT_TXT:STRING, COST_AMT:INT, INS_YN:STRING, INS_NM:STRING, SUM_AMT:INT, RTN_AMT:INT, STS_GBN:STRING");
            }
            
            //개인정보 불러오기 추가  ( 직위, 소속   때문에 사용함.)
            dsVI_T_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta030.cmd.IDTA030CMD&S_MODE=SHR_02&ENO_NO="+gusrid;
            dsVI_T_PERSON.reset();

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_ED_OPENRQST.AddRow();

            dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition, "ENO_NO")  = gusrid;
            dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition, "ENO_NM")  = gusrnm;
            dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition, "DPT_CD")  = dsVI_T_PERSON.NameValue(0,"DPT_CD");
            dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition, "DPT_NM")  = dsVI_T_PERSON.NameValue(0,"DPT_NM");
            dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition, "JOB_CD")  = dsVI_T_PERSON.NameValue(0,"JOB_CD");
            dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition, "JOB_NM")  = dsVI_T_PERSON.NameValue(0,"JOB_NM");
            dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition, "STS_GBN") = "1";

            document.getElementById("cmbSTS_GBN").disabled     = true;

            form1.grdT_ED_OPENRQST.setColumn(form1.grdT_ED_OPENRQST.getColumnID(0));

            document.getElementById("txtEDU_TXT").focus();

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

            document.getElementById("txtSTR_YMD_SHR").value = '';
            document.getElementById("txtEND_YMD_SHR").value = '';
            document.getElementById("txtENO_NO_SHR").value = '';
            document.getElementById("txtENO_NM_SHR").value = '';
            document.getElementById("txtEDU_NM_SHR").value = '';
            
            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_ED_OPENRQST.ClearData();

        }

        /******************************
         * 11. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 12. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            //DataSet의 변경 여부 확인
            if (!dsT_ED_OPENRQST.IsUpdated ) {
            	
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                
                return false;
                
            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
        
            //모든 입력창 막기
            fnc_DisableElementAll(elementList);
            fnc_ChangeStateElement(false, "cmbSTS_GBN");
            fnc_ChangeStateElement(false, "txtENO_NO");
            fnc_ChangeStateElement(false, "txtENO_NM");
            fnc_ChangeStateElement(false, "ImgEnoNo");

            //Grid Style 적용
            cfStyleGrid_New(form1.grdT_ED_OPENRQST,0,"false","false");

            fnc_SetDateTerm();  
          
             //교육장소
            for( var i = 1; i <= dsCOMMON_Q9.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q9.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q9.NameValue(i,"CODE_NAME");
                document.getElementById("cmbEDU_GBN_CD").add(oOption);

            }
             

			fnc_SearchList();
			
			if(gusrid != "6060002" && gusrid != "6180001" && gusrid != "2070019" && gusrid != "2030007" && gusrid != "2070020" && gusrid != "2180001" ){ 

				   document.getElementById("txtENO_NO_SHR").value = gusrid;
		           document.getElementById("txtENO_NM_SHR").value = gusrnm;

		           fnc_ChangeStateElement(false, "txtENO_NO_SHR");
		           fnc_ChangeStateElement(false, "txtENO_NM_SHR");
		           fnc_ChangeStateElement(false, "ImgEnoNoShr");
		           
		           
		           document.getElementById("hidEMPL_DPT_CD").value =gdeptcd;

			}
			
			
			document.getElementById("txtSTR_YMD_SHR").focus();
			
        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

        	window.close();

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/


        // 교육기간 SET
        function fnc_SetDateTerm() {
            //var dateinfo = getToday().split("-");
            
            var dateinfo = gs_date;
            
            //from - to 날짜값 설정하기
            //var schDate  = new Date(dateinfo[0], dateinfo[1]-1, dateinfo[2]);
            var fromDate = null;
            var toDate   = null;
            
            //fromDate = new Date(schDate.getFullYear(), schDate.getMonth(), "01");
            //toDate   = new Date(schDate.getFullYear(), schDate.getMonth(), fnc_Lastday(schDate.getFullYear(), schDate.getMonth()+1));

            fromDate = gcurdate.substring(0,4) + gcurdate.substring(5,7)+"01";
            toDate = gs_date;
            
            // FROM 일자
            document.getElementById("txtSTR_YMD_SHR").value = fromDate;
            
            // TO 일자
            //document.getElementById("txtEND_YMD_SHR").value = fnc_MakeDateString(toDate);
            //document.getElementById("txtEND_YMD_SHR").value = toDate;

            //월의 마지막 일자 가져오기 
            var _firstDayofMon = [gcurdate.substring(0,4),gcurdate.substring(5,7),'01'].join('-');  
            var arrDate = _firstDayofMon.split("-");
            var lastDate =new Date(arrDate[0],arrDate[1],0);
            var lastDay =lastDate.getDate();
            
            document.getElementById("txtEND_YMD_SHR").value = gcurdate.substring(0,4) + gcurdate.substring(5,7)+ lastDay;
                        
        }

        // DATE형을 STRING(YYYY-MM-DD)형태 일자로 변환
        function fnc_MakeDateString(date) {
            var year  = date.getYear();
            var month = date.getMonth() + 1;
            var date  = date.getDate();

            if (month < 10) {
                month = "0" + month;
            }

            if (date < 10) {
                date = "0" + date;
            }

            return year + "-" + month + "-" + date
        }

        //등록입력창
        var elementList = new Array( "txtEDU_STR_YMD"
                                    ,"txtEDU_END_YMD"
                                    ,"ImgEduStrYmd"
                                    ,"ImgEduEndYmd"
                                    ,"txtEDU_TXT"
                                    ,"ImgEduCd"
                                    ,"cmbEDU_GBN_CD"
                                    ,"txtGOAL_TXT"
                                    ,"txtEDU_NM"
                                    ,"txtCONTENT_TXT"
                                    ,"txtOBJ_TAG"
                                    ,"txtEDU_GBN_TXT"
                                    ,"txtPLACE_TXT"
                                    ,"medCOST_AMT"
                                    ,"txtFIX_NO"
                                    ,"cmbINS_YN"
                                    ,"txtEFFECT_TAG"
                                    ,"txtCPT_TAG"
                                    ,"txtSITE_TAG"
                                    ,"medRTN_AMT");


        /**
         * 입력금액과 총액을 계산함
         */
        function fnc_BindTOT() {
            var cost_amt = 0;
            var rtn_amt  = 0;
            var fix_no   = 0;

            cost_amt = fnc_covNumber(document.getElementById("medCOST_AMT").Text);
            fix_no = fnc_covNumber(document.getElementById("txtFIX_NO").value);

            //환급여부 적용, 미적용
            if(document.getElementById("cmbINS_YN").value == "Y") {
                rtn_amt = fnc_covNumber(document.getElementById("medRTN_AMT").Text);
                document.getElementById("medRTN_AMT").readOnly =false;
                document.getElementById("medRTN_AMT").className="";
                document.getElementById("medRTN_AMT").Enable = true;
                document.getElementById("medRTN_AMT").disabled = true;
            }
            else {
            document.getElementById("medRTN_AMT").Text= 0;
            document.getElementById("medRTN_AMT").readOnly =true;
            document.getElementById("medRTN_AMT").className="input_ReadOnly";
            document.getElementById("medRTN_AMT").Enable = false;
            document.getElementById("medRTN_AMT").disabled = true;
            }


        }


       /***********************
       * 사원조회용 팝업 *
       **********************/

        function fnc_EmplPop() {

			var obj = new String();

            obj.shr_kind = "SHR_02";
            obj.eno_nm = "";

            window.showModalDialog("/common/popup/empl2.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            document.getElementById("txtENO_NO").value = obj.eno_no;
            document.getElementById("txtENO_NM").value = obj.eno_nm;
            document.getElementById("txtDPT_CD").value = obj.dpt_cd;
            document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            document.getElementById("txtJOB_CD").value = obj.job_cd;
            document.getElementById("txtJOB_NM").value = obj.job_nm;
		}

        /**
         *사원정보를 조회한다.
         *사원명으로 검색
         */
         function fnc_SearchEmpNm() {
              //사번을 찾아오고 상세 내역 가져오기
              fnc_GetEnoNo('txtENO_NM', 'txtENO_NO', '1');
              fnc_SearchEmpNo();
         }


        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetEnoNm("txtENO_NO","","1");
            if(document.getElementById("txtENO_NO").value != "") {

                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtDPT_CD").value      = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
                document.getElementById("txtJOB_CD").value      = obj.job_cd;
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_CD").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
                document.getElementById("txtJOB_CD").value      = "";
            }

        }




       function fnc_CheckDate(){

            var EDU_STR_YMD = document.getElementById("txtEDU_STR_YMD").value.replace("-","").replace("-","");
            
            var today = gcurdate.replace("-","").replace("-","");

	      }

	   function fnc_CheckDate1(){
		   
	        var EDU_END_YMD = document.getElementById("txtEDU_END_YMD").value.replace("-","").replace("-","");
	        
            var today = gcurdate.replace("-","").replace("-","");
	        
		 }

		 function execCreationEdu(){

		 	var status = document.getElementById("cmbSTS_GBN").value;

            if(status==4){
            	
	            var sORD_NO     = dsT_ED_OPENRQST.NameValue(dsT_ED_OPENRQST.RowPosition, "ORD_NO");

	            if (confirm("요청 과정을 생성하시겠습니까? ") == false) return;

	            params = "&S_MODE=PROC"
			                   + "&ORD_NO="+sORD_NO;

	            dsRESULT.ClearData();

	            trT_ED_OPENRQST.KeyValue = "tr04(O:dsRESULT=dsRESULT)";
	            
	            trT_ED_OPENRQST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue020.cmd.EDUE020CMD"+params;
	            
	            trT_ED_OPENRQST.post();
	            
	        }
		 	
	        trT_ED_OPENRQST.KeyValue = "tr05(I:STS=dsT_ED_OPENRQST)";
	        
            trT_ED_OPENRQST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue020.cmd.EDUE020CMD&S_MODE=STS";
            
            trT_ED_OPENRQST.post();

		 }
		 
		// Link
		function fnc_SiteTag(){
			
			var siteTag = document.getElementById("txtSITE_TAG").value;
			
			if(siteTag == ""){
				return;
			}
			
			window.open('http://'+siteTag,'imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
			
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
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_OPENRQST)  |
    | 3. 사용되는 Table List(T_ED_OPENRQST)         |
    +----------------------------------------------->
    <Object ID="dsT_ED_OPENRQST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_EMPLIST)   |
    | 3. 사용되는 Table List(T_CM_EMPLIST)          |
    +----------------------------------------------->
    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>
    
    
    <!-----------------------------------------------------+
    | 1. 조회용 DataSet(주소)							       |
    | 2. 이름은 ds_ + 주요 테이블명(VI_T_CM_PERSON)			   |
    | 3. 사용되는 Table List(VI_T_CM_PERSON) 				   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 				Value="True">
		<Param Name="UseChangeInfo" 		Value="True">
		<Param Name="ViewDeletedRow" 	Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_ED_OPENRQST                     |
    | 3. Table List : T_ED_OPENRQST                 |
    +----------------------------------------------->
    <Object ID ="trT_ED_OPENRQST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_ED_OPENRQST1" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:DEL=dsT_ED_OPENRQST)">
    </Object>

    <!-- 교육과정 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q1"/>
       <jsp:param name="CODE_GUBUN"    value="Q1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 교육장소 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q9"/>
       <jsp:param name="CODE_GUBUN"    value="Q8"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <Script For=grdT_ED_OPENRQST Event="OnDblClick(row, col)">
    
    /*
	 	var status = document.getElementById("cmbSTS_GBN").value;

        if(status==3 || status==4){
        	
           alert("승인 또는 부결 완료된 요청서입니다.\n\n승인된 요청서는 교육신청서 메뉴에서 신청바랍니다.");
           
           return;
           
        }
        
        ord_no      = dsT_ED_OPENRQST.NameValue(row, "ORD_NO");

        window.showModalDialog("../../hr/edu/edue021.jsp", self, "dialogHeight:620px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	*/

    </Script>

    <!-------------------------------------------------+
    | 해당 값이 변경될 때 합계 값을 구함               |
    +-------------------------------------------------->
    <script language=JavaScript for= medCOST_AMT event="OnKillFocus()">
        fnc_BindTOT();
    </script>

    <!-------------------------------------------------+
    | 해당 값이 변경될 때 합계 값을 구함               |
    +-------------------------------------------------->
    <script language=JavaScript for= medRTN_AMT event="OnKillFocus()">
        fnc_BindTOT();
    </script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_OPENRQST Event="OnLoadCompleted(iCount)">
    
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_OPENRQST.CountRow );
        }
        
    </Script>
    
    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
    
        if(iCount == 0) {
            //alert("해당 자료가 존재하지 않습니다.");
        } else {
            //결과 메세지 보여주기
            alert(dsRESULT.NameString(1, "RTN_MSG"));

            if(dsRESULT.NameString(1, "RTN_CD") == "0") {
                //조회가 성공적으로 이루어 졌을때 다시 worklog를 조회시킴
                fnc_SearchList();
            }
        }
        
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_OPENRQST Event="OnLoadError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
            alert("해당 필수입력항목[담당업무/시작일자] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50020) {
            alert("담당업무/시작일자에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>
    <Script For=dsRESULT Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_OPENRQST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>
    <Script For=dsRESULT Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_ED_OPENRQST event="OnSuccess()">
        fnc_SearchList();

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_ED_OPENRQST event="OnFail()">

        cfErrorMsg(this);

    </script>

    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_ED_OPENRQST event=OnRowPosChanged(row)>

        fnc_BindTOT();
        
        fnc_DisableElementAll(elementList);
        
        fnc_ChangeStateElement(false, "txtENO_NO");
        fnc_ChangeStateElement(false, "txtENO_NM");
        fnc_ChangeStateElement(false, "ImgEnoNo");

        var typeList;
     
        if(row > 0) {
        	
        	 //관리자일 경우 상태를 변경할수 있다.
        	if(gusrid == "6060002" || gusrid == "6180001" || gusrid == "2070019" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "2180001" ){ 
        		
        		 fnc_ChangeStateElement(true, "cmbSTS_GBN");
        		 
        	}

            //신규일 경우
            if(dsT_ED_OPENRQST.RowStatus(row) == "1" || dsT_ED_OPENRQST.NameString(row, "STS_GBN") == "1") {
            	
                fnc_EnableElementAll(elementList);
                
                //관리자일 경우 입력상태의 사번을 변경 시킬수 있다.
        		if(gusrid == "6060002" || gusrid == "6180001" || gusrid == "2070019" || gusrid == "2030007" || gusrid == "2070020"  || gusrid == "2180001" ){ 
                	
                	fnc_ChangeStateElement(true, "txtENO_NO");
                    fnc_ChangeStateElement(true, "txtENO_NM");
                    fnc_ChangeStateElement(true, "ImgEnoNo");
                }

            }
        }
    </script>

    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_ED_OPENRQST event=CanRowPosChange(row)>

        //유효성 검증
        if(row > 0) {
            if(dsT_ED_OPENRQST.RowStatus(row) == "1" || dsT_ED_OPENRQST.NameString(row, "STS_GBN") == "1") {


                // 과정명
                if( dsT_ED_OPENRQST.NameValue(row, "EDU_TXT") == '' ) {
                	
                    alert("교육과정은 필수 입력사항입니다.");
                    
                    document.getElementById("txtEDU_TXT").focus();
                    
                    return false;
                    
                }

                // 교육형태
                if( dsT_ED_OPENRQST.NameValue(row, "EDU_GBN_CD") == '' ) {
                	
                    alert("교육형태은 필수 입력사항입니다.");
                    
                    document.getElementById("cmbEDU_GBN_CD").focus();
                    
                    return false;
                    
                }

                // 교육시작일자
                if( dsT_ED_OPENRQST.NameValue(row, "EDU_STR_YMD") == '' ) {
                	
                    alert("교육시작일자는 필수 입력사항입니다.");
                    
                    document.getElementById("txtEDU_STR_YMD").focus();
                    
                    return false;
                }

                // 교육시작일자 CHECK
                if (!fnc_CheckDate2(dsT_ED_OPENRQST.NameValue(row, "EDU_STR_YMD"), "교육시작일자") && dsT_ED_OPENRQST.NameValue(row, "EDU_STR_YMD") != "") {
                	
                    document.getElementById("txtEDU_STR_YMD").focus();
                    
                    return false;
                }

                // 교육종료일자
                if( dsT_ED_OPENRQST.NameValue(row, "EDU_END_YMD") == '' ) {
                	
                    alert("교육종료일자는 필수 입력사항입니다.");
                    
                    document.getElementById("txtEDU_END_YMD").focus();
                    
                    return false;
                    
                }

                // 교육종료일자 CHECK
                if (!fnc_CheckDate2(dsT_ED_OPENRQST.NameValue(row, "EDU_END_YMD"), "교육종료일자") && dsT_ED_OPENRQST.NameValue(row, "EDU_END_YMD") != "") {
                	
                    document.getElementById("txtEDU_END_YMD").focus();
                    
                    return false;
                    
                }


                // 교육시작일자와 교육종료일자 비교
                if(dsT_ED_OPENRQST.NameValue(row, "EDU_STR_YMD") != '' && dsT_ED_OPENRQST.NameValue(row, "EDU_END_YMD") != '') {
                	
                    if(removeChar(dsT_ED_OPENRQST.NameValue(row, "EDU_STR_YMD"),'-') > removeChar(dsT_ED_OPENRQST.NameValue(row, "EDU_END_YMD"),'-')) {
                    	
                        alert("교육시작일자는 반드시 교육종료일자보다 작아야합니다.");
                        
                        document.getElementById("txtEDU_STR_YMD").focus();
                        
                        return false;
                    }
                }

                // 환급여부
                if( dsT_ED_OPENRQST.NameValue(row, "INS_YN") == '' ) {
                	
                    alert("환급여부는 필수 입력사항입니다.");
                    
                    document.getElementById("cmbINS_YN").focus();
                    
                    return false;
                    
                }

            }
        }
    </script>


<!--
***********************************************************************
* BODY START
***********************************************************************
-->
<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/> 
<!--  <body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">-->

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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
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

                            <tr>
                                <td align="right" class="searchState">과정 </td>
                                <td class="padding2423">
                                    <input id="txtEDU_CD_SHR" size="10" maxlength= "10" onkeypress="if(event.keyCode==13) fnc_eduCodeSearchPopup('txtEDU_CD_SHR','txtEDU_NM_SHR');" >
                                    <input id="txtEDU_NM_SHR" size="20" maxlength= "200" class="input_ReadOnly" onkeypress="if(event.keyCode==13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEduCd" name="ImgEduCd" width="21" height="20" border="0" align="absmiddle" onclick="fnc_eduCodeSearchPopup('txtEDU_CD_SHR','txtEDU_NM_SHR');"></a>
                                </td>
                                <td align="right" class="searchState">교육일자 </td>
                                <td class="padding2423">
                                    <input id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();" onfocusout="fnc_compareFromTo('txtSTR_YMD_SHR', 'txtEND_YMD_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd1','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEduStrYmd1" name="ImgEduStrYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','280','120');"></a> ~
                                    <input id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();" onfocusout="fnc_compareFromTo('txtSTR_YMD_SHR', 'txtEND_YMD_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduEndYmd1','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEduEndYmd1" name="ImgEduEndYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','650','120');"></a>
                                </td>
                                <td class="searchState" align="right">사번</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
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

<!-- 조회 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100 "></col>
                    <col width="200"></col>
                    <col width="100 "></col>
                    <col width="200"></col>
                    <col width="100 "></col>
                    <col width="200"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">신 청 자</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtENO_NO" name="txtENO_NO" size="9" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" size="9" maxlength= "9"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_EmplPop();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                        <b>
                        &nbsp;&nbsp;부서
                        <input id="txtDPT_NM" size="12" class="input_ReadOnly" readonly>
                        <input type="hidden" id="txtDPT_CD">
                        &nbsp;&nbsp;직위
                        <input id="txtJOB_NM" size="15" class="input_ReadOnly" readonly>
                        <input type="hidden" id="txtJOB_CD">
                        </b>
                    </td>
                    <td align="center" class="blueBold">처리상황</td>
                    <td class="padding2423" colspan="2">
                        <select id="cmbSTS_GBN" style="width:50%" onChange="execCreationEdu();">
                            <option value="1">신청</option>
                            <option value="3">부결</option>
                            <option value="4">승인</option>
                        </select>
                       인원
                        <input id="txtFIX_NO" name="txtFIX_NO" maxlength="5" style="width:20%;text-align:right;" >

                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" >교육과정</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtEDU_TXT" name="txtEDU_TXT"  maxlength="200" style="width:100%" >
                    </td>
                    <td align="center" class="blueBold" >교육대상</td>
                    <td class="padding2423" colspan="2">
                        <input id="txtOBJ_TAG" name="txtOBJ_TAG"  maxlength="200" style="width:100%" >
                    </td>

                </tr>
                <tr>
                    <td align="center" class="blueBold" >교육목적</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtGOAL_TXT" name="txtGOAL_TXT" maxlength="60" style="width:100%">
                    </td>
                    <td align="center" class="blueBold" >교육형태</td>
                    <td class="padding2423" align="left" colspan="2">
                        <select id="cmbEDU_GBN_CD" style="width:100px" >
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육일시</td>
                    <td class="padding2423">
                        <input id="txtEDU_STR_YMD" name="txtEDU_STR_YMD" style="ime-mode:disabled" size="10" maxlength="10"  onblur="fnc_CheckDate(this);" onChange="fnc_CheckDate(this, '교육시작일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtEDU_STR_YMD', 'txtEDU_END_YMD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEduStrYmd" name="ImgEduStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEDU_STR_YMD','','0','252');"></a> ~
                        <input id="txtEDU_END_YMD" name="txtEDU_END_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate1(this);" onChange="fnc_CheckDate(this, '교육종료일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtEDU_STR_YMD', 'txtEDU_END_YMD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduEndYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEduEndYmd" name="ImgEduEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEDU_END_YMD','','112','252');"></a>
                    </td>
                    <td align="center" class="blueBold">교육기관</td>
                    <td class="padding2423" >
                        <input id="txtEDU_GBN_TXT" name="txtEDU_GBN_TXT" maxlength="28" style="width:100%">
                    </td>
                    <td align="center" class="blueBold">교육장소</td>
                    <td class="padding2423" colspan="2">
                        <input id="txtPLACE_TXT" name="txtPLACE_TXT" maxlength="20" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육내용</td>
                    <td class="padding2423" colspan="6">
                        <textarea id="txtCONTENT_TXT"  name="txtCONTENT_TXT" cols="117" rows="4" onKeyUp="fc_chk_byte(this,300)"></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">소요비용</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medCOST_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            		value=2>
                            <param name=Border               		value=true>
                            <param name=ClipMode             		value=true>
                            <param name=DisabledBackColor    	value="#EEEEEE">
                            <param name=Enable               		value=true>
                            <param name=IsComma              	value=true>
                            <param name=Language             		value=0>
                            <param name=MaxLength            	value=9>
                            <param name=Numeric              		value=true>
                            <param name=ShowLiteral          		value="false">
                            <param name=Visible              			value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>

					<td align="center" class="blueBold">환급여부</td>
                    <td class="padding2423">
                        <select id="cmbINS_YN" style="width:100%" onchange="fnc_BindTOT()">
                            <option value="N">미적용</option>
                            <option value="Y">적용</option>
                        </select>
                    </td>
                    <td align="center" class="blueBold">환급예상액</td>
                    <td class="padding2423" colspan="2">
                        <comment id="__NSID__"><object id="medRTN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:99%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>

                    </td>
                </tr>
                    <td align="center" class="blueBold">참고 URL</td>
                    <td class="padding2423" >
                        http://<input id="txtSITE_TAG"  name="txtSITE_TAG" size="17" maxlength="300" >&nbsp;<input type="button" value="연결" size="6" align="right" onClick="fnc_SiteTag()">
                    </td>
                    <td align="center" class="blueBold" >교육효과</td>
                    <td class="padding2423" >
                        <input id="txtEFFECT_TAG" name="txtEFFECT_TAG"  maxlength="50" style="width:100%" >
                    </td>
                    <td align="center" class="blueBold" >수료기준</td>
                    <td class="padding2423" colspan="2">
                        <input id="txtCPT_TAG" name="txtCPT_TAG"  maxlength="150" style="width:100%" >
                    </td>
                <tr>


                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_ED_OPENRQST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:300px;">
                            <param name="DataID"                  value="dsT_ED_OPENRQST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     		width=40    name='순번'         align=center </C>
                                <C> id='EDU_TXT'      		width=150   name='교육과정'     align=left   </C>
                                <C> id='EDU_STR_YMD'  	width=80    name='시작일자'     align=left   </C>
                                <C> id='EDU_END_YMD'  	width=80    name='종료일자'     align=center </C>
                                <C> id='EDU_GBN_CD'   	width=60    name='교육형태'     align=center EditStyle=Lookup Data='dsCOMMON_Q9:CODE:CODE_NAME' </C>
                                <C> id='GOAL_TXT'     		width=150   name='교육목적'     align=left   </C>
                                <C> id='EDU_GBN_TXT'  	width=100   name='교육기관'     align=left   </C>
                                <C> id='PLACE_TXT'    		width=100   name='교육장소'     align=left   </C>
                                <C> id='CONTENT_TXT'  	width=120   name='교육내용'     align=left  multiline=true </C>
                                <C> id='COST_AMT'     	width=80    name='소요비용'     align=right  </C>
                                <C> id='FIX_NO'       		width=50    name='인원'         align=right  </C>

                                <C> id='ENO_NM'       		width=70    name='성명'         align=center </C>
                                <C> id='DPT_NM'       		width=80    name='부서'         align=left   </C>
                                <C> id='JOB_NM'       		width=70    name='직위'         align=center </C>
                                <C> id='INS_YN'       		width=70    name='환급여부'     align=center   Value={Decode(INS_YN,'Y','적용','N','미적용')}</C>
                                <C> id='RTN_AMT'      		width=70    name='환급예상액'   align=right </C>

                                <C> id='STS_GBN_NM'   	width=70    name='처리상황'     align=center value={DECODE(STS_GBN,'1','신청','2','접수','3','부결','4','승인')}</C>
                                <C> id='OBJ_TAG'      		width=120   name='교육대상'     align=left   </C>
                                <C> id='EFFECT_TAG'   	width=120   name='교육효과'     align=left   </C>
                                <C> id='CPT_TAG'  	  		width=120   name='수료기준'     align=left   </C>
                                <C> id='SITE_TAG'     		width=120   name='참고사이트'   align=left   </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 테이블 끝-->

<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState">* 신규로 개설요청 하시고 과정정보를 저장하신 경우라도 교육을 신청 하셔야 대기자 명단에 등록됩니다.</td>
                </tr>
            </table>
        </td>
    </tr>
</table>


</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 인사기록표 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ED_OPENRQST">
    <Param Name="BindInfo", Value='

        <C> Col=EDU_STR_YMD   Ctrl=txtEDU_STR_YMD   Param=value </C>
        <C> Col=EDU_END_YMD   Ctrl=txtEDU_END_YMD   Param=value </C>
        <C> Col=ENO_NO        Ctrl=txtENO_NO        Param=value </C>
        <C> Col=ENO_NM        Ctrl=txtENO_NM        Param=value </C>
        <C> Col=DPT_NM        Ctrl=txtDPT_NM        Param=value </C>
        <C> Col=JOB_NM        Ctrl=txtJOB_NM        Param=value </C>
        <C> Col=EDU_TXT       Ctrl=txtEDU_TXT       Param=value </C>
        <C> Col=EDU_NM        Ctrl=txtEDU_NM        Param=value </C>
        <C> Col=EDU_GBN_CD    Ctrl=cmbEDU_GBN_CD    Param=value </C>
        <C> Col=GOAL_TXT      Ctrl=txtGOAL_TXT      Param=value </C>
        <C> Col=EDU_GBN_TXT   Ctrl=txtEDU_GBN_TXT   Param=value </C>
        <C> Col=PLACE_TXT     Ctrl=txtPLACE_TXT     Param=value </C>
        <C> Col=CONTENT_TXT   Ctrl=txtCONTENT_TXT   Param=value </C>
        <C> Col=COST_AMT      Ctrl=medCOST_AMT      Param=text  </C>
        <C> Col=FIX_NO        Ctrl=txtFIX_NO        Param=value </C>
        <C> Col=INS_YN        Ctrl=cmbINS_YN        Param=value </C>
        <C> Col=RTN_AMT       Ctrl=medRTN_AMT       Param=text  </C>
        <C> Col=STS_GBN       Ctrl=cmbSTS_GBN       Param=value </C>
        <C> Col=OBJ_TAG       Ctrl=txtOBJ_TAG       Param=value </C>
        <C> Col=EFFECT_TAG    Ctrl=txtEFFECT_TAG    Param=value </C>
        <C> Col=CPT_TAG       Ctrl=txtCPT_TAG       Param=value </C>
        <C> Col=SITE_TAG      Ctrl=txtSITE_TAG      Param=value </C>
    '>
</object>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 