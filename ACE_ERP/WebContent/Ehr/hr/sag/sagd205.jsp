<!--
    ************************************************************************************
    * @source         : sagd205.jsp 				                                   *
    * @description   : 신_급여테이블 PAGE.                                             *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2016/01/08  |  이동훈   | 최초작성                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>(임시)개인별 급여지급상세내역</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>


<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >

		window.onresize = fnc_PopupAutoResize;

        var savObj = new Array();

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var APY_YMD_SHR = document.getElementById("txtAPY_YMD_SHR").value; // 적용일자
			var PAY_YMD_SHR = document.getElementById("txtPAY_YMD_SHR").value; // 직위구분
			var JOB_CD_SHR = document.getElementById("txtJOB_CD_SHR").value; // 직위구분
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // 사번
            var SAL_GBN = document.getElementById("cmbSAL_GBN_SHR").value; // 급상여구분


			//기준일자가 없으면 조회 못함.
			if(APY_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("기준일자를 입력하세요.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}

			//적용일자가 잘못되었으면 조회못함.
			if(APY_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("기준일자가 잘못되었습니다.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}

            savObj.type = "";
            savObj.occ_cd = "";
            savObj.apy_ymd = "";


			//급여 소급 구분.
			if(SAL_GBN == 0){
	            //데이터셋 전송
	            dsT_CP_PAYTABLE.UseChangeInfo = true;
	            dsT_CP_PAYTABLE.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.d.sagd205.cmd.SAGD205CMD&S_MODE=SHR&APY_YMD_SHR="+APY_YMD_SHR+"&PAY_YMD="+PAY_YMD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
	            dsT_CP_PAYTABLE.Reset();
			}else if(SAL_GBN == 2){
	            //데이터셋 전송
	            dsT_CP_PAYTABLE.UseChangeInfo = true;
	            dsT_CP_PAYTABLE.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.d.sagd205.cmd.SAGD205CMD&S_MODE=SHR_SO&APY_YMD_SHR="+APY_YMD_SHR+"&PAY_YMD="+PAY_YMD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
	            dsT_CP_PAYTABLE.Reset();

			}





        }
        /***********************************
         * 01. 년간 급여 조회  형태의 조회  *
         ***********************************/
        function fnc_SearchList_Year() {

			var APY_YMD_SHR = "2018%%";
			var PAY_YMD_SHR = document.getElementById("txtPAY_YMD_SHR").value; // 기준년도
			var JOB_CD_SHR = document.getElementById("txtJOB_CD_SHR").value; // 직위구분
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // 사번

			//기준일자가 없으면 조회 못함.
			if(PAY_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("기준년도를 입력하세요.");
					document.getElementById("txtPAY_YMD_SHR").focus();
					return false;
				}
			}

			//적용일자가 잘못되었으면 조회못함.
			if(PAY_YMD_SHR.trim().length != 4){
				if(event.type == "change"){
					return false;
				}else{
					alert("기준년도가 잘못되었습니다.");
					document.getElementById("txtPAY_YMD_SHR").focus();
					return false;
				}
			}

			//사번이 없으면 조회못함.
			if(ENO_NO_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					//alert("사번을 입력하세요.");
					//document.getElementById("txtENO_NO_SHR").focus();
					//return false;
				}
			}

            savObj.type = "";
            savObj.occ_cd = "";
            savObj.apy_ymd = "";

            //데이터셋 전송
            dsT_CP_PAYTABLE.UseChangeInfo = true;
            dsT_CP_PAYTABLE.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.d.sagd205.cmd.SAGD205CMD&S_MODE=SHR&APY_YMD_SHR="+APY_YMD_SHR+"&PAY_YMD="+PAY_YMD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
            dsT_CP_PAYTABLE.Reset();

        }

		/***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

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

			var APY_YMD_SHR = document.getElementById("txtAPY_YMD_SHR").value; // 적용일자
			var PAY_YMD_SHR = document.getElementById("txtPAY_YMD_SHR").value; // 직위구분
			var JOB_CD_SHR = document.getElementById("txtJOB_CD_SHR").value; // 직위구분
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // 사번
            var SAL_GBN = document.getElementById("cmbSAL_GBN_SHR").value; // 급상여구분

			//기준일자가 없으면 조회 못함.
			if(APY_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("기준일자를 입력하세요.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}

			//적용일자가 잘못되었으면 조회못함.
			if(APY_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("기준일자가 잘못되었습니다.");
					document.getElementById("txtAPY_YMD_SHR").focus();
					return false;
				}
			}

            savObj.type = "";
            savObj.occ_cd = "";
            savObj.apy_ymd = "";



			//급여 소급 구분.
			if(SAL_GBN == 0){
	            dsT_Grid_Detail.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.d.sagd205.cmd.SAGD205CMD&S_MODE=SHR_PRINT&APY_YMD_SHR="+APY_YMD_SHR+"&PAY_YMD="+PAY_YMD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
	            dsT_Grid_Detail.Reset();
			}else if(SAL_GBN == 2){
	            dsT_Grid_Detail.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.d.sagd205.cmd.SAGD205CMD&S_MODE=SHR_SO&APY_YMD_SHR="+APY_YMD_SHR+"&PAY_YMD="+PAY_YMD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
	            dsT_Grid_Detail.Reset();
			}

			var ls_temp = "CUDATE:STRING,CTITLE:STRING";

			dsT_RP_PAYTABLE.SetDataHeader(ls_temp);
			dsT_RP_PAYTABLE.Addrow();
			dsT_RP_PAYTABLE.namevalue(1,"CUDATE")=gcurdate;

			var yyyymmdd = document.getElementById("txtAPY_YMD_SHR").value; // 적용일자
			var yyyy = yyyymmdd.substring(0,4);
			var mm = yyyymmdd.substring(5,7);

			dsT_RP_PAYTABLE.namevalue(1,"CTITLE")= " 급여대장 [" + yyyy + "년" + mm + "월]";

			gcrp_print.Preview();

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CP_PAYTABLE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CP_PAYTABLE.GridToExcel("급여테이블", '', 225);

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

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

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

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_CP_PAYTABLE.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

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

        
        /*************************
         *    팝업리사이즈        *
         *************************/
        function fnc_PopupAutoResize() {

        	
        	//alert("1");
        	
        	//window.resizeTo(100, 100);
        	
        	//var thisX = parseInt(document.body.scrollWidth);
        	
        	//thisX = thisX + 30;
        	
        	//var thisY = parseInt(document.body.scrollHeight);
        	
        	var maxThisX = screen.width - 150;
        	
        	var maxThisY = screen.height - 350;
        	
        	//var marginY = 0;
        	   
        	//alert(screen.width + "===" + screen.width);
        	//alert(screen.height + "===" + screen.height);       	   
        	//alert("임시 브라우저 확인 : " + navigator.userAgent);
        	   // 브라우저별 높이 조절.

        	 //alert("확인 : " + navigator.userAgent.indexOf);
        	 /* 

        	 if(navigator.userAgent.indexOf("MSIE 7") > 0){
        		 
        		 alert("MSIE 7");
        		 marginY = 100;    // IE 7.x
        		 
        	 }else if(navigator.userAgent.indexOf("MSIE 8") > 0){ 
        		 
        		 thisY = thisY+60; alert("MSIE 8");
        		 
        	 }else if(navigator.userAgent.indexOf("MSIE 9") > 0){
        		 
        		 thisY = thisY+100;alert("MSIE 9");
        		 
        	 }
        	 */
        	 //alert("thisX===" + thisX);        	 
        	 //alert("maxThisX===" + maxThisX);
        	 
        	 form1.grdT_CP_PAYTABLE.style.width  = maxThisX;
        	 form1.grdT_CP_PAYTABLE.style.height = maxThisY;
        	 
        	 /*
        	 if (thisX > maxThisX) {
        		 
        	     window.document.body.scroll = "yes";
        	     
        	     thisX = maxThisX;
        	 }
        	 
        	 if (thisY > maxThisY - marginY) {
        		 
        	    window.document.body.scroll = "yes";
           	 //alert(thisY + "===" + thisY);
           	 //alert(maxThisY + "===" + maxThisY);   
           	 alert(marginY + "=111111==" + marginY);            	 
        	    thisX += 200;
        	    
        	    thisY = maxThisY - marginY;
        	    
        	   }
        	 */
        	   window.resizeTo(screen.width, screen.height);

			   return true;



        }
       
        
        
        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			fnc_ChangeGrid();      //그리드 변경 처리

			//fnc_PopupAutoResize(); //팝업리사이즈


			
			
			//최근 저장한 기준일 조회
			ds01T_CP_PAYTABLE.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.d.sagd205.cmd.SAGD205CMD&S_MODE=SHR_01";
			ds01T_CP_PAYTABLE.Reset();

			//값이 없어서 하이픈만 나오는거 방지
			var APY_YMD_SHR = (document.getElementById("txtAPY_YMD_SHR").value).replace("-", "").replace("-", "");
			if(APY_YMD_SHR.trim() == ""){
				document.getElementById("txtAPY_YMD_SHR").value = "";
			}

            savObj.type = "";
            savObj.apy_ymd = "";

            fnc_SearchList();
        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}



        /*************************
         * 그리드 변경 처리      *
         ************************/
		function fnc_ChangeGrid(obj) {


			if(obj == undefined || obj.value == "1"){
			form1.grdT_CP_PAYTABLE.Format =
					"<FC> id='{CUROW}'			width=40		name='NO'			align=center	value={String(Currow)}		BgColor='#EEEEEE'	SubSumText=''	</FC>" +
					"<FC> id='DPT_NM'        	width=90        name='소속'         	align=center   </FC>" +
					"<FC> id='TEAM_NM'        	width=120       name='팀'         	align=left     show=false</FC>" +
					"<FC> id='JOB_NM'        	width=65        name='직위'        	align=center   </FC>" +
					"<FC> id='ENO_NM'        	width=60        name='성명'          	align=center   SubSumText='합계' </FC>" +
					"<C> id='ENO_NO'        	width=60        name='사번'          	align=center   </C>" +
					"<C> id='CET_NO'       		width=100       name='주민번호'        align=center   </C>" +
					"<C> id='P01_AMT'       	width=100       name='기본급'        	align=right    </C>" +
					"<C> id='P02_AMT'       	width=100       name='시간외'        	align=right    </C>" +
					"<C> id='P03_AMT'     		width=100       name='휴일근무수당'     align=right     </C>" +
					"<C> id='P04_AMT'      		width=100       name='특수지수당'      	align=right     show=false</C>" +
					"<C> id='P05_AMT'       	width=100       name='조정수당'        align=right     </C>" +
					"<C> id='P06_AMT'     		width=100       name='본사직책수당'     align=right     </C>" +
					"<C> id='CET_AMT'      		width=100       name='자격수당'      	align=right     </C>" +
					"<C> id='CASH_AMT'      	width=100       name='출납수당'     	align=right     show=false</C>" +
					"<C> id='CAR_AMT'    		width=100       name='차량유지비'     	align=right     show=false</C>" +
					"<C> id='MEAL_AMT'    		width=100       name='식대'     		align=right     show=false</C>" +
					"<C> id='STAY_AMT'    		width=100       name='현지체류비'     	align=right     </C>" +
					"<C> id='DRI_AMT'      		width=100       name='운전수당'      	align=right     show=false</C>" +
					"<C> id='BOSS_AMT'      	width=100       name='사장단수당'      	align=right     show=false</C>" +
					"<C> id='DUTY_AMT'     		width=100       name='현장직책수당'     align=right     </C>" +
					"<C> id='PPEN_AMT'       	width=100       name='개인연금'      	align=right     </C>" +
					"<C> id='SCH_AMT'       	width=100       name='학자금'      	align=right     </C>" +
					"<C> id='OTH_AMT'      		width=100       name='기타지불'      	align=right     </C>" +

					"<C> id='SALT_AMT'      	width=100       name='급여총계'      	align=right    BgColor='#99FF99' </C>" +

					"<G> name='공제' 		BgColor='#dae0ee'   "+

					"<C> id='INCM_TAX'       	width=100       name='소득세'      	align=right    </C>" +
					"<C> id='CITI_TAX'       	width=100       name='주민세'        	align=right    </C>" +
					"<C> id='NPEN_DED'       	width=100       name='국민연금'     	align=right    </C>" +
					"<C> id='HINU_DED'       	width=100       name='의료보험료'      	align=right    </C>" +
					"<C> id='OLD_DED'       	width=100       name='장기요양보험'    	align=right    </C>" +
					"<C> id='HINS_DED'       	width=100       name='고용보험'      	align=right    </C>" +
					"<C> id='LAB_DED'       	width=100       name='보증보험'      	align=right    </C>" +
					"<C> id='PPEN_DED'       	width=100       name='개인연금'     	align=right    </C>" +
					"<C> id='O7_DED'      		width=100       name='오세븐공제'     	align=right    </C>" +
					"<C> id='GIM_DED'      		width=100       name='체력단련실'     	align=right    </C>" +
					"<C> id='BUS_DED'      		width=100       name='통근버스'	    align=right    </C>" +
					"<C> id='DHLP_DED'       	width=100       name='공조회비'      	align=right    </C>" +
					"<C> id='COM_DED'       	width=100       name='사내대출'       	align=right    </C>" +
					"<C> id='COM_INT'       	width=100       name='상환이자'     	align=right    </C>" +
					"<C> id='GONG_DED'       	width=100       name='공조대출' 		align=right    </C>" +
					"<C> id='GONG_INT'       	width=100       name='상환이자'  		align=right    </C>" +
					"<C> id='HINU_CAL'     		width=100       name='건강보험정산'  	align=right    </C>" +
					"<C> id='HINS_CAL'      	width=100       name='고용보험정산'  	align=right    </C>" +
					"<C> id='DRE_INTX'     		width=100       name='연말정산소득'  	align=right    	</C>" +
					"<C> id='DRE_CTTX'      	width=100       name='연말정산주민'  	align=right    	</C>" +
					"<C> id='DRE_DFTX'      	width=100       name='연말정산농특'  	align=right    	</C>" +

					"<C> id='OTH_DED'    		width=100       name='기타공제'      	align=right    </C>" +
					"<C> id='SUM_DED'       	width=100       name='공제액계'     	align=right    BgColor='#FFFF99'</C>" +
					"</G>"+
					"<C> id='PAY_AMT'       	width=100       name='실수령액'   		align=right    BgColor='#FF9999'</C>" +

					"<C> id='PIS_YYMM'       	width=75        name='지급년월'     	align=center        </C>"+
					"<C> id='TAX_DPT2'       	width=120       name='회계소속'     	align=left          </C>" +
					"<C> id='GBN_NM'       		width=120       name='근무지'     	align=left          </C>";
			}


			//첫번째 인수 : 그리드명
			//두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)
			//네번째 인수 : sort기능 사용여부(false:미사용, true:sort사용)

			cfStyleGrid_New(form1.grdT_CP_PAYTABLE, 15,"false","true");

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
    | 2. 이름 : dsT_CP_PAYTABLE                     |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name=SubsumExpr        value="total">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : ds01T_CP_PAYTABLE                   |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="ds01T_CP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. 레포트용 DataSet                     		|
    | 2. 이름 : dsT_RP_PAYTABLE                     |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="dsT_RP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 			Value="True">
        <Param Name="UseChangeInfo" 	Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_Grid_Detail" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
    	<param name="SubsumExpr"   		value="1:TAX_DPT">
        <Param Name="Syncload" 			Value="True">
        <Param Name="UseChangeInfo" 	Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>





    <!-- 가우스 파일 오브젝트 -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='첨부파일'>
        <param name="Enable"    value="true">
    </object>

    <!-- 데이터셋 컴포넌트 선언 [파일 첨부용] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

   	<!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!----------------------------------------------+
    | 1. 자료 업로드용 Data Transacton              |
    | 2. 이름 : trFILE_UPLOAD_06                    |
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID ="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : trT_CP_PAYTABLE                                |
    | 3. Table List : T_CP_PAYTABLE                         |
    +----------------------------------------------->
    <Object ID ="trT_CP_PAYTABLE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                      *
    *  Component에서 발생하는 Event 처리부 *
    *                                      *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_CP_PAYTABLE Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=ds01T_CP_PAYTABLE Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
			var oAPY_YMD = ds01T_CP_PAYTABLE.NameValue(1,"APY_YMD").trim();
			document.getElementById("txtAPY_YMD_SHR").value = oAPY_YMD.substring(0,4)+"-"+oAPY_YMD.substring(4,6)+"-"+oAPY_YMD.substring(6,8);
			document.getElementById("txtAPY_YMD_SHR").focus();
			document.getElementById("txtPAY_YMD_SHR").value = oAPY_YMD.substring(0,4);

        }
    </Script>

    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //에러 메세지가 있는 여부를 파악한 후 알림
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowError(dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>



    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYTABLE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=ds01T_CP_PAYTABLE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYTABLE Event="OnDataError()">
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[시작일자/종료일자/직위/사번] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("적용일자/근로구분/직위/호봉에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <Script For=ds01T_CP_PAYTABLE Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_CP_PAYTABLE event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();
    </script>

    <script for=trFILE_UPLOAD event="OnSuccess()">
		document.getElementById("resultMessage").innerText = "파일첨부가 완료되었습니다.";

        //ROW 상태를 다 INSERT 상태로 변경 시켜 놓음 (나중 db 저장을 위해)
        dsT_CP_PAYTABLE.UseChangeInfo = false;

        savObj.type     = "UPLOAD";
        //savObj.occ_cd   = document.getElementById("cmbOCC_CD_SHR").value; // 근로구분구분
        savObj.apy_ymd  = document.getElementById("txtAPY_YMD_SHR").value; // 적용일자
    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_CP_PAYTABLE event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trFILE_UPLOAD event="OnFail()">
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgYearSalary','','../../images/button/btn_YearSalaryOver.gif',1)"><img src="../../images/button/btn_YearSalaryOn.gif" name="imgYearSalary" border="0" align="absmiddle" onClick="fnc_SearchList_Year()"></a>
			&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)"><img src="../../images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="80"></col>
								<col width="200"></col>
								<col width="80"></col>
								<col width="200"></col>
								<col width="80"></col>
								<col width="170"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center" class="searchState">기준년도</td>
								<td>
								<input id="txtPAY_YMD_SHR" style="width:83" maxlength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
								</td>
								<td align="center" class="searchState">기준일자</td>
								<td>
									<input id="txtAPY_YMD_SHR" style="width:83" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPY_YMD_SHR','','535','112');"></a>
									
								</td>
								<td align="center" class="searchState">구분</td>
								<td>
									<select id="cmbSAL_GBN_SHR" style="WIDTH:70" onchange="fnc_SearchList()">
										<option value="0" >급  여</option>
	                                    <option value="2" >소  급</option>
									</select>
								</td>
							</tr>
							<tr>

								<td align="center" class="searchState">직&nbsp;&nbsp;&nbsp;위</td>
								<td>
									<input id="txtJOB_CD_SHR" name="txtJOB_CD_SHR" size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('A2','txtJOB_CD_SHR','txtJOB_NM_SHR');" onChange="fnc_GetCommNm('A2','txtJOB_CD_SHR','txtJOB_NM_SHR');">
									<input id="txtJOB_NM_SHR" name="txtJOB_NM_SHR" size="16" class="input_ReadOnly" readonly>
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgJOB_CD_SHR','','../../images/button/btn_HelpOver.gif',1)">
									<img src="../../images/button/btn_HelpOn.gif" name="imgJOB_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_CD_SHR','txtJOB_NM_SHR','직위','A2');"></a>
								</td>
								<td align="center" class="searchState">사원번호</td>
								<td >
									<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();" style="ime-mode:disabled">
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');fnc_SearchList();">
									<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgENO_NO_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');fnc_SearchList();"></a>
								</td>

								<td align="center" class="searchState"></td>
								<td>

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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    <td width="80" style="padding-right:5px; padding-top:2px;">
                    </td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object 	id="grdT_CP_PAYTABLE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"					value="dsT_CP_PAYTABLE">
							<param name="EdiTABLE"					value="false">
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

</form>
<!-- form 끝 -->




<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   #### 정 기 급 여 ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
	<PARAM NAME="MasterDataID"					VALUE="dsT_RP_PAYTABLE">
	<param name="DetailDataID"	    			value="dsT_Grid_Detail">
	<PARAM NAME="PaperSize"						VALUE="A3">
	<PARAM NAME="LandScape"						VALUE="1">
  	<PARAM NAME="PrintSetupDlgFlag" 			VALUE="true">
	<PARAM NAME="PreviewZoom"					VALUE="110">
	<PARAM NAME="Format" 						VALUE="

<B>id=Header ,left=0,top=0 ,right=4101 ,bottom=170 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='CTITLE', left=1405, top=56, right=2474, bottom=143, face='HY중고딕', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=2, pencolor=#000000, Dec=0</C>
	<T>id='단위 : 원' ,left=3784 ,top=122 ,right=4001 ,bottom=169 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CUDATE', left=3704, top=82, right=4001, bottom=122, align='right', face='굴림', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Print Date:' ,left=3450 ,top=61 ,right=3699 ,bottom=122 ,align='right' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=4101 ,bottom=198 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=3998 ,top=3 ,right=24 ,bottom=3 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='소속' ,left=275 ,top=13 ,right=553 ,bottom=71 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사번' ,left=37 ,top=13 ,right=249 ,bottom=71 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직위' ,left=37 ,top=130 ,right=249 ,bottom=185 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=37 ,top=74 ,right=249 ,bottom=127 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=254 ,top=3 ,right=254 ,bottom=193 </L>
	<L> left=614 ,top=3 ,right=614 ,bottom=196 </L>
	<L> left=2080 ,top=5 ,right=2080 ,bottom=193 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=4003 ,top=3 ,right=4003 ,bottom=193 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=26 ,top=193 ,right=4006 ,bottom=193 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='지급계' ,left=1828 ,top=130 ,right=2069 ,bottom=185 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본급' ,left=619 ,top=13 ,right=889 ,bottom=71 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시간외' ,left=619 ,top=74 ,right=889 ,bottom=127 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='휴일근무수당' ,left=619 ,top=130 ,right=889 ,bottom=185 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='고용보험' ,left=2373 ,top=135 ,right=2672 ,bottom=188 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='건강보험' ,left=2373 ,top=74 ,right=2672 ,bottom=132 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='국민연금' ,left=2373 ,top=21 ,right=2672 ,bottom=71 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보증보험' ,left=2675 ,top=21 ,right=2945 ,bottom=71 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='건강보험 정산' ,left=2675 ,top=74 ,right=2945 ,bottom=132 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='고용보험 정산' ,left=2675 ,top=135 ,right=2945 ,bottom=188 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사내대출' ,left=2947 ,top=21 ,right=3196 ,bottom=71 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공조회대출' ,left=2947 ,top=74 ,right=3196 ,bottom=132 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공조회비' ,left=2947 ,top=135 ,right=3196 ,bottom=188 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득세' ,left=2103 ,top=21 ,right=2355 ,bottom=74 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세' ,left=2103 ,top=77 ,right=2355 ,bottom=132 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연말정산소득' ,left=3450 ,top=21 ,right=3749 ,bottom=71 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연말정산주민' ,left=3450 ,top=74 ,right=3749 ,bottom=132 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연말정산농특' ,left=3450 ,top=135 ,right=3749 ,bottom=188 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='실수령액' ,left=3760 ,top=135 ,right=3990 ,bottom=188 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=24 ,top=3 ,right=24 ,bottom=193 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='개인연금' ,left=2103 ,top=135 ,right=2355 ,bottom=185 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제계' ,left=3760 ,top=79 ,right=3990 ,bottom=130 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타공제' ,left=3760 ,top=21 ,right=3993 ,bottom=74 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='통근버스' ,left=3199 ,top=74 ,right=3448 ,bottom=132 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='복지카페' ,left=3199 ,top=21 ,right=3448 ,bottom=71 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='체력단련실' ,left=3199 ,top=135 ,right=3448 ,bottom=185 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='조정수당' ,left=897 ,top=16 ,right=1122 ,bottom=69 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='본사직책' ,left=897 ,top=74 ,right=1119 ,bottom=127 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자격수당' ,left=897 ,top=130 ,right=1122 ,bottom=185 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현지체류비' ,left=1122 ,top=16 ,right=1344 ,bottom=71 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='학자금' ,left=1339 ,top=16 ,right=1561 ,bottom=69 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타지급' ,left=1336 ,top=74 ,right=1572 ,bottom=130 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='현장직책' ,left=1117 ,top=74 ,right=1341 ,bottom=127 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='개인연금' ,left=1117 ,top=132 ,right=1339 ,bottom=188 ,face='HY중고딕' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

<B>id=default ,left=0,top=0 ,right=4101 ,bottom=175 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='{decode(curlevel,1,,ENO_NO)}', left=37, top=0, right=249, bottom=50, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,ENO_NM)}', left=37, top=56, right=249, bottom=103, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,\'소 계\',JOB_NM)}', left=37, top=106, right=249, bottom=156, supplevel=2, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,subcount(ENO_NO))}', left=265, top=111, right=474, bottom=161, align='right', supplevel=1 ,mask='XXXX/XX/XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,\'명\')}', left=487, top=111, right=532, bottom=161, align='left', supplevel=1, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P01_AMT,0,,P01_AMT)}', left=635, top=5, right=860, bottom=56, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(curlevel,1,,DPT_NM)}', left=265, top=5, right=611, bottom=50, align='left', supplevel=1, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0, Multiline=true</C>
	<C>id='{decode(curlevel,1,,TEAM_NM)}', left=265, top=53, right=611, bottom=156, align='left', supplevel=1, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0, Multiline=true</C>
	<L> left=254 ,top=0 ,right=254 ,bottom=167 </L>
	<C>id='{decode(P03_AMT,0,,P03_AMT)}', left=635, top=111, right=860, bottom=161, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(DUTY_AMT,0,,DUTY_AMT)}', left=1124, top=58, right=1349, bottom=108, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<X>left=1823 ,top=111 ,right=2077 ,bottom=164 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='SALT_AMT', left=1831, top=116, right=2074, bottom=161, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<C>id='{decode(HINS_DED,0,,HINS_DED)}', left=2326, top=108, right=2622, bottom=159, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(HINS_CAL,0,,HINS_CAL)}', left=2625, top=108, right=2892, bottom=159, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(INCM_TAX,0,,INCM_TAX)}', left=2077, top=3, right=2328, bottom=53, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(CITI_TAX,0,,CITI_TAX)}', left=2077, top=56, right=2328, bottom=108, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(COM_DED+COM_INT,0,,COM_DED+COM_INT)}', left=2895, top=3, right=3143, bottom=53, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(GONG_DED+GONG_INT,0,,GONG_DED+GONG_INT)}', left=2895, top=56, right=3143, bottom=106, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(DHLP_DED,0,,DHLP_DED)}', left=2895, top=108, right=3143, bottom=159, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(BUS_DED,0,,BUS_DED)}', left=3146, top=56, right=3395, bottom=106, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(DRE_INTX,0,,DRE_INTX)}', left=3400, top=3, right=3694, bottom=53, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(DRE_CTTX,0,,DRE_CTTX)}', left=3400, top=56, right=3694, bottom=106, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<X>left=3754 ,top=106 ,right=3998 ,bottom=159 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='PAY_AMT', left=3760, top=111, right=3995, bottom=156, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<C>id='{decode(P02_AMT,0,,P02_AMT)}', left=635, top=58, right=860, bottom=108, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=2080 ,top=0 ,right=2080 ,bottom=164 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=614 ,top=0 ,right=614 ,bottom=164 </L>
	<L> left=24 ,top=0 ,right=24 ,bottom=161 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=4003 ,top=0 ,right=4003 ,bottom=164 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=19 ,top=167 ,right=4001 ,bottom=167 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{decode(HINU_CAL,0,,HINU_CAL)}', left=2625, top=56, right=2892, bottom=106, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(LAB_DED,0,,LAB_DED)}', left=2625, top=3, right=2892, bottom=53, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(HINU_DED+OLD_DED,0,,HINU_DED+OLD_DED)}', left=2326, top=56, right=2622, bottom=106, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(NPEN_DED,0,,NPEN_DED)}', left=2326, top=3, right=2622, bottom=53, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(DRE_DFTX,0,,DRE_DFTX)}', left=3400, top=108, right=3694, bottom=159, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(PPEN_DED,0,,PPEN_DED)}', left=2077, top=108, right=2326, bottom=159, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<X>left=3754 ,top=56 ,right=3998 ,bottom=106 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='{decode(SUM_DED,0,,SUM_DED)}', left=3760, top=58, right=3995, bottom=103, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<C>id='{decode(OTH_DED,0,,OTH_DED)}', left=3757, top=3, right=3998, bottom=53, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(O7_DED,0,,O7_DED)}', left=3146, top=3, right=3395, bottom=53, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(GIM_DED,0,,GIM_DED)}', left=3146, top=108, right=3395, bottom=159, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P05_AMT,0,,P05_AMT)}', left=892, top=3, right=1117, bottom=53, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(CET_AMT,0,,CET_AMT)}', left=889, top=111, right=1114, bottom=161, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(P06_AMT,0,,P06_AMT)}', left=863, top=56, right=1111, bottom=106, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(PPEN_AMT,0,,PPEN_AMT)}', left=1124, top=111, right=1349, bottom=161, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(STAY_AMT,0,,STAY_AMT)}', left=1132, top=0, right=1349, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(SCH_AMT,0,,SCH_AMT)}', left=1357, top=0, right=1574, bottom=50, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(OTH_AMT,0,,OTH_AMT)}', left=1355, top=58, right=1572, bottom=108, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>

<B>id=LDFooter ,left=0,top=0 ,right=4101 ,bottom=172 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=4006 ,top=0 ,right=29 ,bottom=0 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<T>id='합 계' ,left=50 ,top=50 ,right=222 ,bottom=101 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='Count' ,left=394 ,top=50 ,right=516 ,bottom=101 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<T>id='총원' ,left=278 ,top=50 ,right=423 ,bottom=101 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='명' ,left=521 ,top=50 ,right=574 ,bottom=101 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=4003 ,top=169 ,right=26 ,bottom=169 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=614 ,top=0 ,right=614 ,bottom=172 </L>
	<L> left=254 ,top=0 ,right=254 ,bottom=169 </L>
	<L> left=24 ,top=0 ,right=24 ,bottom=167 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<L> left=2077 ,top=0 ,right=2077 ,bottom=172 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=4003 ,top=0 ,right=4003 ,bottom=169 ,penstyle=solid ,penwidth=7 ,pencolor=#000000 </L>
	<X>left=1820 ,top=111 ,right=2074 ,bottom=164 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=3744 ,top=116 ,right=3998 ,bottom=164 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<S>id='{Sum(CITI_TAX)}' ,left=2077 ,top=61 ,right=2328 ,bottom=111 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(INCM_TAX)}' ,left=2077 ,top=8 ,right=2328 ,bottom=58 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{Sum(P01_AMT)}' ,left=632 ,top=8 ,right=863 ,bottom=58 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{Sum(P02_AMT)}' ,left=632 ,top=61 ,right=863 ,bottom=111 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{Sum(P03_AMT)}' ,left=632 ,top=114 ,right=863 ,bottom=164 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{Sum(DUTY_AMT)}' ,left=1122 ,top=61 ,right=1352 ,bottom=111 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<C>id='{SUM(SALT_AMT)}', left=1828, top=116, right=2072, bottom=161, align='right', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=0</C>
	<S>id='{SUM(NPEN_DED)}' ,left=2331 ,top=8 ,right=2627 ,bottom=58 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<C>id='{SUM(HINU_DED+OLD_DED)}', left=2331, top=61, right=2627, bottom=111, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<S>id='{SUM(HINS_DED)}' ,left=2331 ,top=114 ,right=2627 ,bottom=164 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(LAB_DED)}' ,left=2630 ,top=8 ,right=2895 ,bottom=58 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(HINU_CAL)}' ,left=2630 ,top=61 ,right=2895 ,bottom=111 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(HINS_CAL)}' ,left=2630 ,top=114 ,right=2895 ,bottom=164 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(DHLP_DED)}' ,left=2897 ,top=114 ,right=3151 ,bottom=164 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(BUS_DED)}' ,left=3154 ,top=61 ,right=3400 ,bottom=111 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(PAY_AMT)}' ,left=3749 ,top=119 ,right=3998 ,bottom=161 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<S>id='{SUM(DRE_CTTX)}' ,left=3405 ,top=61 ,right=3688 ,bottom=111 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(DRE_INTX)}' ,left=3405 ,top=8 ,right=3688 ,bottom=58 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(DRE_DFTX)}' ,left=3405 ,top=114 ,right=3688 ,bottom=164 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<X>left=3747 ,top=64 ,right=3998 ,bottom=114 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<S>id='{SUM(SUM_DED)}' ,left=3754 ,top=66 ,right=3995 ,bottom=108 ,align='right' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0, Dec=0</S>
	<S>id='{SUM(OTH_DED)}' ,left=3752 ,top=8 ,right=3998 ,bottom=58 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(PPEN_DED)}' ,left=2082 ,top=114 ,right=2328 ,bottom=164 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(O7_DED)}' ,left=3154 ,top=8 ,right=3400 ,bottom=58 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<S>id='{SUM(GIM_DED)}' ,left=3156 ,top=114 ,right=3403 ,bottom=164 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, Dec=0</S>
	<C>id='{SUM(GONG_DED+GONG_INT)}', left=2897, top=61, right=3151, bottom=111, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{SUM(COM_DED+COM_INT)}', left=2897, top=8, right=3151, bottom=58, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<S>id='{Sum(P05_AMT)}' ,left=884 ,top=8 ,right=1114 ,bottom=58 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{Sum(P06_AMT)}' ,left=884 ,top=61 ,right=1114 ,bottom=111 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{Sum(CET_AMT)}' ,left=884 ,top=114 ,right=1114 ,bottom=164 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{Sum(STAY_AMT)}' ,left=1119 ,top=8 ,right=1349 ,bottom=58 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{Sum(PPEN_AMT)}' ,left=1119 ,top=114 ,right=1349 ,bottom=164 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{Sum(SCH_AMT)}' ,left=1355 ,top=8 ,right=1585 ,bottom=58 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
	<S>id='{Sum(OTH_AMT)}' ,left=1355 ,top=61 ,right=1585 ,bottom=111 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0, Dec=0</S>
</B>

<B>id=Footer ,left=0 ,top=2770 ,right=4101 ,bottom=2870 ,face='Tahoma' ,size=12 ,penwidth=1
	<T>id='#p/#t' ,left=773 ,top=3 ,right=3580 ,bottom=82</T>
</B>





">
</OBJECT>




</body>
</html>