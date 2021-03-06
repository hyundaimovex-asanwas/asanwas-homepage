<!--*************************************************
* @source      : yaca070_14.jsp                                                *
* @description : 개인별상세내역현황 PAGE                                         *
****************************************************
* DATE            AUTHOR        DESCRIPTION                                  *
*-----------------------------------------------------------------
* 2015/01/27            이동훈             최초작성                                         *
****************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>

<jsp:include page="/Ehr/common/include/head.jsp"/>

    <title>개인별상세내역현황(yaca070_14)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<script language=javascript src="../../common/common.js"></script> 
	<script language=javascript src="../../common/result.js"></script>	
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   자바스크립트 함수 선언부분                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">
        //단축키 순서
        var btnList = "T"   //조회
                    + "F"   //신규
                    + "F"   //저장
                    + "T"   //취소
                    + "T"   //엑셀
                    + "T"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

        var dataClassName = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca070.cmd.YACA070CMD";
        var params = null;


        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            //검색유효성 검사
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList)) return;

            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR");
            var oENO_NO     = document.getElementById("txtENO_NO_SHR");


            //날짜 가져오기
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);

            params = "&S_MODE=SHR"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&ENO_NO="+oENO_NO.value
            	   + "&USESTS_SHR="+document.getElementById("cmbUSESTS_SHR").value; 
            
            dsT_AC_RETACC.dataid = dataClassName+params;
            dsT_AC_RETACC.reset();
        }

        /********************************************
         * 02. 조회 함수_Item 형태의 조회                *
         ********************************************/
        function fnc_SearchItem() {

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

        	//데이터셋 초기화 
        	gcds_print.ClearAll();


			var eno_no  = dsT_AC_RETACC.NameValue(dsT_AC_RETACC.RowPosition, "ENO_NO");
			
			
			
        	//1,2pgae
        	gcds_print.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca050.cmd.YACA050CMD&S_MODE=YACA050_PRT_142&PIS_YY=2014&ENO_NO="+eno_no;
        	//prompt('gcds_print.dataid',gcds_print.dataid );
        	gcds_print.reset();
            
            
			gcrp_print.Preview();			

        }

        

        
        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_RETACC.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_AC_RETACC.GridToExcel("개인별상세내역현황", '', 225);
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

        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
        	
			window.close();
        }

        /********************************************
         * 12. 검색 조건 유효성 검사                     *
         ********************************************/
        function fnc_SearchItemCheck() {

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

            cfStyleGrid_New(form1.grdT_AC_RETACC,0,"false","true");      // Grid Style 적용

			form1.grdT_AC_RETACC.TitleHeight = 45;
            
            document.getElementById("txtPIS_YM_SHR").value = '2014-12';

            fnc_SearchList();
            
        }

        /********************************************
         * 15. 단축키 처리                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * 16. Form이 Active 될 때 처리 할 일          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {

        }

        /********************************************
         * 기타 함수              *
         ********************************************/

        //지금 정의되어 있는 항목들
        var oElementList = new Array(    "txtPIS_YM_SHR"
                                        ,"cmbOCC_CD_SHR");

        //항목들의 메세지
        var oElementMsgList = new Array( "정산년월"
                                        ,"근로구분"
                                        ,"정산구분");

        //예외 항목들
        var oExceptionList = new Array(  "cmbOCC_CD_SHR");


        function fnc_GetNm() {
            fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');
	   }
	
	    function fnc_Getcd() {
	            fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');
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
    <Object ID="dsT_AC_RETACC" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=SubsumExpr          value="total">
    </Object>

    <Object ID="gcds_print" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
    </Object>
    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_RETACC)                |
    | 3. 사용되는 Table List(T_AC_RETACC)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETACC" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("검색하신 조건의 자료가 없습니다!");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
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

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnSuccess()">

    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

    <!-- form 시작 -->
    <form name="form1">

    <!-- 버튼 테이블 시작 -->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
            
		        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)"><img src="../../images/button/btn_PrintOn.gif" name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>&nbsp;&nbsp;&nbsp;&nbsp;             
            
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

    <!-- power Search테이블 시작 -->
	<table width="1050" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="blueTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
                    <col width="100"></col>
                    <col width="180"></col>
                    <col width="90"></col>
                    <col width="180"></col>
                    <col width="90"></col>
                    <col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">정산년월</td>
					<td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM_SHR" name="txtPIS_YM_SHR" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','134','108');"></a>
					</td>
                    <td align="right" class="searchState">사번</td>
                    <td class="padding2423" colspan="3">
							<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) {fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();" style="ime-mode:disabled">
							<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) {fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');fnc_SearchList();">						
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
                    </td>
					<td align="center" class="searchState">재직여부</td>
					<td>
							<select id="cmbUSESTS_SHR" style="WIDTH:100" onChange="fnc_SearchList();">
									<option value="" >전체</option>
									<option value="Y">재직</option>
									<option value="N">퇴직</option>
							</select>
					</td>	                    
                </tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- power Search테이블 끝 -->

    <!-- 조회 상태 테이블 시작 -->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
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

    <!-- 내용 조회 그리드 테이블 시작-->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                    <comment id="__NSID__">
                    <object id="grdT_AC_RETACC" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1050px;height:550px;">
                        <param name="DataID" value="dsT_AC_RETACC">
                        <param name="Editable" value="true">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <FC> id="{CUROW}"        width=40    height =150 align=center    name="NO"         value={String(Currow)}    SubSumText=""</FC>
                            <FC> id=RET_YN           width=60   align=center    name=재직     SubSumText="" Value={Decode(RET_YN,"","재직","퇴직")}</FC>
                            <FC> id=RET_YMD         width=70   align=center    name=퇴직일     SubSumText="" </FC>                       
                            <FC> id=DPT_NM           width=100   align=left    name=소속                          SubSumText=""</FC>
                            <FC> id=ENO_NO           width=55   align=center    name=사번                          SubSumText=""</C>
                            <FC> id=ENO_NM           width=55   align=center    name=성명                          SubSumText=""</FC>
                            <C> id=CET_NO           width=100   align=center    name=주민번호                          SubSumText=""</C>
                            <C> id=JOB_NM           width=75   align=center    name=직위                          SubSumText=" 합 계 "</FC>
                            <C> id=TAX_INCOME       width=100   align=right     rightmargin=10    name="과세대상급여"                 BgColor=#FAFAD2 </C>
                            <C> id=MGR_AMT          width=100   align=right     rightmargin=10    name="근로소득;공제액"                </C>
                            <C> id=MNI_AMT          width=100   align=right     rightmargin=10    name="근로소득금액"                  BgColor=#FABBCC </C>
                            <C> id=BADD_AMT         width=100   align=right     rightmargin=10    name="본인공제"                    </C>
                            <C> id=SPSB_AMT         width=100   align=right     rightmargin=10    name="배우자공제"                  </C>
                            <C> id=GDED_AMT         width=100   align=right     rightmargin=10    name="부양가족;공제"                </C>
                            <C> id=GOL_AMT          width=100   align=right     rightmargin=10    name="경로우대;공제"                </C>
                            <C> id=TBL_DED          width=100   align=right     rightmargin=10    name="장애자공제"                  </C>
                            <C> id=WDD_AMT          width=100   align=right     rightmargin=10    name="부녀자공제"                  </C>
                            <C> id=OTX_DED          width=100   align=right     rightmargin=10    name="한부모공제"                  </C>
                            <C> id=NPEN_DED         width=100   align=right     rightmargin=10    name="국민연금보험;공제"   </C>
                            <C> id=HIN_DED          width=100   align=right     rightmargin=10    name="건강,고용보험료;공제"         /C>   
                            <C> id=LOAN_DED          width=100   align=right     rightmargin=10    name="주택임차;차입금;원리금상환액"     </C>
                            <C> id=LONG_DED          width=100   align=right     rightmargin=10    name="장기주택저당;차입금;이자지급액"  </C>                                                     
                            <C> id=DON_FWD          width=100   align=right     rightmargin=10    name="기부금;이월"  </C>                                                      
                            <C> id=VEN_DED          width=100   align=right     rightmargin=10    name="특별소득;공제"  </C>                                                        
                            <C> id=INDED_TOT          width=100   align=right     rightmargin=10    name="차감소득금액"                  BgColor=#FAFAD2</C>                                             
                            <C> id=PER_DED          width=100   align=right     rightmargin=10    name="개인연금;저축공제"          </C>                                             
                            <C> id=SAVE_DED          width=100   align=right     rightmargin=10    name="주택마련;공제"              </C>                                             
                            <C> id=CARD_DED         width=100   align=right     rightmargin=10    name="신용카드;공제"                </C>                                             
                            <C> id=SAJU_DED         width=100   align=right     rightmargin=10    name="우리사주출연;공제"              </C>                                             
                            <C> id=LSS_DED         width=100   align=right     rightmargin=10    name="장기집합투자;증권저축공제"         </C>  
                            <C> id=INDED_EXC         width=100   align=right     rightmargin=10    name="소득공제;종합한도;초과액"         </C>                            
                            <C> id=TTAX_STD         width=100   align=right     rightmargin=10    name="종합소득;과세표준"                  </C>
                            <C> id=TAX_AMT          width=100   align=right     rightmargin=10    name="산출세액"                        BgColor=#AAFAD2</C>                                                                                  
 
                           <G> name=세액공제 BgColor="#dae0ee"
                            <C> id=HGR_DED          width=100   align=right     rightmargin=10    name="근로소득;세액공제"      </C> 
                            <C> id=AGE_AMT          width=100   align=right     rightmargin=10    name="자녀;세액공제"             </C>  
                            <C> id=ANN_DED          width=100   align=right     rightmargin=10    name="연금계좌;공제"         </C>
                            <C> id=MIN_DED          width=100   align=right     rightmargin=10    name="보장성보험;세액공제"          </C>                                                                                                         
                            <C> id=MMA_DED          width=100   align=right     rightmargin=10    name="의료비;세액공제"          </C>
                            <C> id=EDU_DED          width=100   align=right     rightmargin=10    name="교육비;세액공제"           </C>
                            <C> id=GOV1_DED         width=100   align=right     rightmargin=10    name="정치자금;(10만원이하)"     </C>
                            <C> id=GOV2_DED          width=100   align=right     rightmargin=10    name="정치자금;(10만원초과)"    </C>
                            <C> id=LC1_DED           width=100   align=right     rightmargin=10    name="법정기부금"                    </C>
                            <C> id=LC23_DED          width=100   align=right     rightmargin=10    name="지정기부금"                    </C>
                            <C> id=CPC_DED          width=100   align=right     rightmargin=10    name="기부금;세액공제"           </C>
                            <C> id=NSE_TOT          width=100   align=right     rightmargin=10    name="특별세액;공제계"             BgColor=#99FF22</C>
                            <C> id=STA_TOT          width=100   align=right     rightmargin=10    name="표준세액공제"              </C>   
                            <C> id=MRENT_DED       width=100   align=right     rightmargin=10    name="월세액;세액공제"         </C>                                                       
                            <C> id=TDED_TOT         width=100   align=right     rightmargin=10    name="세액공제계 "                   BgColor=#FAFAD2</C>
                           </G> 

                           <G> name=결정세액 BgColor="#dae0ee"                            
                            <C> id=DGG_TAX          width=100   align=right     rightmargin=10    name=결정소득세                   </C>
                            <C> id=DJM_TAX          width=100   align=right     rightmargin=10    name=결정주민세                   </C>
                            <C> id=DBW_TAX          width=100   align=right     rightmargin=10    name=결정농특세                   </C>                            
                            <C> id=AAA_TOT          width=100   align=right     rightmargin=10    name=결정세액계                    value={DGG_TAX+DJM_TAX+DBW_TAX}   BgColor=#FAFAD2</C>
                            
                           <G> name=기납부세액 BgColor="#dae0ee"                            

                            <C> id=AGG_TAX         width=100   align=right     rightmargin=10    name=납부소득세                    </C>
                            <C> id=AJM_TAX         width=100   align=right     rightmargin=10    name=납부주민세                    </C>
                            <C> id=CONT_TAX         width=100   align=right     rightmargin=10    name=납부농특세                    </C>                            
                            <C> id=CCC_TOT          width=100   align=right     rightmargin=10    name=납부세액계                        value={AGG_TAX +AJM_TAX+CONT_TAX} BgColor=#FAFAD2</C>
                            </G>                            

                           <G> name=환급세액 BgColor="#dae0ee"                                                    
                            
                            <C> id=DRE_INTX        width=100   align=right     rightmargin=10    name=환급소득세                    </C>
                            <C> id=DRE_CTTX        width=100   align=right     rightmargin=10    name=환급주민세                    </C>
                            <C> id=DRE_DFTX        width=100   align=right     rightmargin=10    name=환급농특세                    </C>                            
                            <C> id=EEE_TOT          width=100   align=right     rightmargin=10    name=환급세액계                    value={DRE_INTX+DRE_CTTX+DRE_DFTX} BgColor=#FFAADD</C>
                            </G>                         
                        
                        '>
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




    <!-----------------------------------------------------------------------------
			R E P O R T   C O M P O N E N T S   D E F I N I T I O N
------------------------------------------------------------------------------>
<object  ID="gcrp_print" CLASSID="CLSID:CC26E2A9-760B-4EA6-8DDF-DB423FD24089" >  
 
	<PARAM NAME="MasterDataID"		VALUE="gcds_print">  
	<PARAM NAME="DetailDataID"		VALUE="gcds_print">
    <param name="PaperSize"         value="A4">
    <param name="Landscape"         value="false">
    <param name="NullRecordFlag"    value="true">
    <param name="PrintSetupDlgFlag" value="true">
    <param name="PreviewZoom"       value="120">
    <param name="Format"            value=" 
    
    <A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='1.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_print' 
	<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=2741 ,face='Arial' ,size=10 ,penwidth=1
		<X>left=101 ,top=185 ,right=482 ,bottom=275 ,border=true</X>
		<L> left=64 ,top=159 ,right=66 ,bottom=2696 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='(제1쪽)' ,left=1725 ,top=90 ,right=1881 ,bottom=151 ,align='right' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='[별지 제24호 서식(1)]  ' ,left=64 ,top=90 ,right=1471 ,bottom=151 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=64 ,top=156 ,right=1886 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<X>left=585 ,top=243 ,right=614 ,bottom=278 ,border=true</X>
		<X>left=585 ,top=193 ,right=614 ,bottom=228 ,border=true</X>
		<T>id='관리' ,left=106 ,top=191 ,right=220 ,bottom=230 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=228 ,top=185 ,right=228 ,bottom=275 </L>
		<L> left=64 ,top=672 ,right=1886 ,bottom=672 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='', left=1016, top=915, right=1114, bottom=960, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=873, top=915, right=971, bottom=960, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1381, top=857, right=1479, bottom=902, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1381, top=915, right=1479, bottom=960, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1521, top=857, right=1619, bottom=902, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1521, top=915, right=1619, bottom=960, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(TAX_INCOME,0,,TAX_INCOME)}', left=630, top=976, right=855, bottom=1021, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1638, top=857, right=1730, bottom=902, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1773, top=857, right=1863, bottom=902, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1638, top=915, right=1730, bottom=960, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1773, top=915, right=1863, bottom=960, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1130, top=915, right=1222, bottom=960, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1257, top=915, right=1355, bottom=960, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JAS_NM3', left=1392, top=741, right=1614, bottom=786, face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=630, top=1320, right=855, bottom=1365, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=884, top=1320, right=1106, bottom=1365, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1140, top=1320, right=1365, bottom=1365, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1392, top=1320, right=1614, bottom=1365, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1632, top=1320, right=1873, bottom=1365, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=630, top=1265, right=855, bottom=1310, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=884, top=1265, right=1106, bottom=1310, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1140, top=1265, right=1365, bottom=1310, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1392, top=1265, right=1614, bottom=1310, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1632, top=1265, right=1873, bottom=1310, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=630, top=1204, right=855, bottom=1249, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=884, top=1204, right=1106, bottom=1249, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1140, top=1204, right=1365, bottom=1249, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1392, top=1204, right=1614, bottom=1249, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1632, top=1204, right=1873, bottom=1249, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=630, top=1148, right=855, bottom=1193, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=884, top=1148, right=1106, bottom=1193, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1140, top=1148, right=1365, bottom=1193, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1392, top=1148, right=1614, bottom=1193, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1632, top=1148, right=1873, bottom=1193, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=127 ,top=733 ,right=1886 ,bottom=733 </L>
		<L> left=127 ,top=791 ,right=1886 ,bottom=791 </L>
		<L> left=127 ,top=852 ,right=1886 ,bottom=852 </L>
		<L> left=127 ,top=908 ,right=1886 ,bottom=908 </L>
		<L> left=127 ,top=1371 ,right=1886 ,bottom=1371 </L>
		<L> left=127 ,top=1315 ,right=1886 ,bottom=1315 </L>
		<L> left=127 ,top=1257 ,right=1886 ,bottom=1257 </L>
		<L> left=127 ,top=1201 ,right=1886 ,bottom=1201 </L>
		<L> left=127 ,top=1143 ,right=1886 ,bottom=1143 </L>
		<L> left=127 ,top=1082 ,right=1886 ,bottom=1082 </L>
		<L> left=127 ,top=1027 ,right=1886 ,bottom=1027 </L>
		<L> left=127 ,top=968 ,right=1886 ,bottom=968 </L>
		<L> left=124 ,top=672 ,right=124 ,bottom=2516 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='STR', left=624, top=857, right=741, bottom=902, face='Arial Narrow', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JAS_NM2', left=1124, top=741, right=1371, bottom=786, face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id=' ~' ,left=730 ,top=857 ,right=759 ,bottom=902 ,face='Arial' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='END', left=757, top=857, right=863, bottom=902, face='Arial Narrow', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=64 ,top=1431 ,right=1886 ,bottom=1431 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='', left=884, top=1439, right=1106, bottom=1484, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='16)-1납세조합' ,left=1394 ,top=683 ,right=1617 ,bottom=728 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ⅰ' ,left=71 ,top=868 ,right=124 ,bottom=908 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='근' ,left=71 ,top=915 ,right=124 ,bottom=955 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='무' ,left=71 ,top=960 ,right=124 ,bottom=1000 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='처' ,left=71 ,top=1003 ,right=124 ,bottom=1042 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='별' ,left=71 ,top=1045 ,right=124 ,bottom=1085 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='소' ,left=71 ,top=1087 ,right=124 ,bottom=1124 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='득' ,left=71 ,top=1132 ,right=124 ,bottom=1169 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='명' ,left=71 ,top=1175 ,right=124 ,bottom=1212 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세' ,left=71 ,top=1220 ,right=124 ,bottom=1257 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='근로소득원천징수영수증' ,left=624 ,top=193 ,right=1244 ,bottom=241 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='근로소득 지급명세서' ,left=624 ,top=243 ,right=1244 ,bottom=288 ,align='left' ,face='문체부 바탕체' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1328 ,top=161 ,right=1865 ,bottom=161 </L>
		<T>id='번호' ,left=106 ,top=235 ,right=220 ,bottom=273 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='2014 -' ,left=230 ,top=191 ,right=333 ,bottom=270 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='HTITLE', left=683, top=310, right=1101, bottom=352, face='바탕', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=1328 ,top=161 ,right=1328 ,bottom=405 </L>
		<T>id='거주구분' ,left=1331 ,top=164 ,right=1543 ,bottom=198 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1328 ,top=198 ,right=1865 ,bottom=198 </L>
		<T>id='외국인단일세율적용' ,left=1331 ,top=267 ,right=1601 ,bottom=302 ,align='left' ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1328 ,top=233 ,right=1865 ,bottom=233 </L>
		<L> left=1328 ,top=265 ,right=1865 ,bottom=265 </L>
		<T>id='국적' ,left=1331 ,top=302 ,right=1450 ,bottom=336 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1328 ,top=299 ,right=1865 ,bottom=299 </L>
		<L> left=1331 ,top=333 ,right=1868 ,bottom=333 </L>
		<L> left=1331 ,top=370 ,right=1868 ,bottom=370 </L>
		<L> left=1328 ,top=405 ,right=1865 ,bottom=405 </L>
		<L> left=1865 ,top=161 ,right=1865 ,bottom=405 </L>
		<L> left=64 ,top=410 ,right=1886 ,bottom=410 </L>
		<L> left=1545 ,top=161 ,right=1545 ,bottom=267 </L>
		<L> left=1765 ,top=198 ,right=1765 ,bottom=233 </L>
		<L> left=1453 ,top=198 ,right=1453 ,bottom=233 </L>
		<L> left=1453 ,top=302 ,right=1453 ,bottom=336 </L>
		<L> left=1603 ,top=265 ,right=1603 ,bottom=299 </L>
		<L> left=1765 ,top=299 ,right=1765 ,bottom=333 </L>
		<L> left=249 ,top=410 ,right=249 ,bottom=672 </L>
		<L> left=249 ,top=460 ,right=1886 ,bottom=460 </L>
		<T>id='(1)법 인 명 (상 호)' ,left=254 ,top=415 ,right=540 ,bottom=458 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='현대아산(주)' ,left=627 ,top=415 ,right=918 ,bottom=458 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(2)대 표 자 (성     명)' ,left=1040 ,top=415 ,right=1384 ,bottom=458 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='조 건 식' ,left=1410 ,top=415 ,right=1730 ,bottom=458 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(3)사업자등록번호' ,left=251 ,top=466 ,right=537 ,bottom=508 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='140111-0011714' ,left=1408 ,top=466 ,right=1728 ,bottom=508 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(4)주 민 등 록 번 호' ,left=1037 ,top=466 ,right=1381 ,bottom=508 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='221-81-13834' ,left=627 ,top=466 ,right=918 ,bottom=508 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=249 ,top=511 ,right=1886 ,bottom=511 </L>
		<T>id='(5)소 재 지 (주소)' ,left=254 ,top=516 ,right=540 ,bottom=561 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=64 ,top=564 ,right=1886 ,bottom=564 </L>
		<T>id='(6)성명' ,left=254 ,top=569 ,right=540 ,bottom=614 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=249 ,top=616 ,right=1886 ,bottom=616 </L>
		<T>id='(8)주소' ,left=254 ,top=622 ,right=540 ,bottom=667 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='ENO_NM', left=627, top=569, right=918, bottom=614, align='left', face='바탕', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='(7)주 민 등 록  번 호' ,left=1037 ,top=569 ,right=1381 ,bottom=614 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='CET_NO', left=1410, top=569, right=1844, bottom=614, align='left' ,mask='XXXXXX-XXXXXXX', face='바탕', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=1029 ,top=410 ,right=1029 ,bottom=511 </L>
		<L> left=1400 ,top=410 ,right=1400 ,bottom=511 </L>
		<C>id='ADDRESS_HOME', left=627, top=622, right=1852, bottom=667, align='left', face='바탕', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=1400 ,top=564 ,right=1400 ,bottom=616 </L>
		<T>id='징   수' ,left=71 ,top=450 ,right=243 ,bottom=495 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='의무자' ,left=71 ,top=495 ,right=243 ,bottom=540 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='소득자' ,left=71 ,top=574 ,right=243 ,bottom=661 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='구   분' ,left=130 ,top=683 ,right=601 ,bottom=728 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(10)사업자등록번호' ,left=130 ,top=802 ,right=601 ,bottom=847 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(11)근무기간' ,left=130 ,top=860 ,right=601 ,bottom=905 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(12)감면기간' ,left=130 ,top=918 ,right=601 ,bottom=963 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(13)급               여' ,left=130 ,top=979 ,right=601 ,bottom=1024 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(14)상               여' ,left=130 ,top=1035 ,right=601 ,bottom=1080 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(15)인   정   상   여' ,left=130 ,top=1093 ,right=601 ,bottom=1135 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(15)-1주식매수선택권 행사이익' ,left=130 ,top=1151 ,right=601 ,bottom=1193 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(15)-2우리사주조합인출금' ,left=130 ,top=1209 ,right=601 ,bottom=1251 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(15)-3임원 퇴직소득금액 한도초과액' ,left=130 ,top=1265 ,right=601 ,bottom=1310 ,align='left' ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='15)-4' ,left=130 ,top=1320 ,right=601 ,bottom=1365 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='16)계' ,left=130 ,top=1378 ,right=601 ,bottom=1423 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='종(전)' ,left=886 ,top=683 ,right=1109 ,bottom=728 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='종(전)' ,left=1143 ,top=683 ,right=1368 ,bottom=728 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='합  계' ,left=1635 ,top=683 ,right=1876 ,bottom=728 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1886 ,top=156 ,right=1886 ,bottom=2693 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=127 ,top=2426 ,right=1886 ,bottom=2426 </L>
		<T>id='(76)주(현)근무지' ,left=230 ,top=2379 ,right=553 ,bottom=2424 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=228 ,top=2373 ,right=1886 ,bottom=2373 </L>
		<L> left=127 ,top=2230 ,right=1886 ,bottom=2230 </L>
		<T>id='기납부' ,left=130 ,top=2289 ,right=222 ,bottom=2320 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세   액' ,left=130 ,top=2320 ,right=220 ,bottom=2352 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(74)결     정     세     액' ,left=127 ,top=2183 ,right=609 ,bottom=2228 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=122 ,top=2178 ,right=1881 ,bottom=2178 </L>
		<L> left=699 ,top=2230 ,right=699 ,bottom=2371 </L>
		<L> left=532 ,top=2233 ,right=532 ,bottom=2373 </L>
		<L> left=64 ,top=2125 ,right=1886 ,bottom=2125 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='(75)종(전)근무지' ,left=257 ,top=2249 ,right=511 ,bottom=2283 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(결정세액란의' ,left=257 ,top=2286 ,right=511 ,bottom=2320 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='  세액 기재)' ,left=257 ,top=2323 ,right=511 ,bottom=2357 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세' ,left=69 ,top=2389 ,right=122 ,bottom=2426 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='명' ,left=69 ,top=2334 ,right=122 ,bottom=2371 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='액' ,left=69 ,top=2278 ,right=122 ,bottom=2318 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세' ,left=69 ,top=2225 ,right=122 ,bottom=2262 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ⅲ' ,left=69 ,top=2172 ,right=122 ,bottom=2212 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(18) 국외근로' ,left=135 ,top=1442 ,right=434 ,bottom=1487 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=1495 ,right=1886 ,bottom=1495 </L>
		<T>id='(18)-1 야간근로수당' ,left=135 ,top=1505 ,right=434 ,bottom=1550 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=1558 ,right=1886 ,bottom=1558 </L>
		<T>id='(18)-2 출산보육수당' ,left=132 ,top=1572 ,right=431 ,bottom=1617 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=1625 ,right=1886 ,bottom=1625 </L>
		<T>id='(18)-4 연구보조비' ,left=135 ,top=1635 ,right=434 ,bottom=1680 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=1688 ,right=1886 ,bottom=1688 </L>
		<T>id='(18)-5' ,left=135 ,top=1699 ,right=434 ,bottom=1744 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=1752 ,right=1886 ,bottom=1752 </L>
		<T>id='(18)-6' ,left=135 ,top=1762 ,right=434 ,bottom=1804 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=119 ,top=1812 ,right=1879 ,bottom=1812 </L>
		<T>id='~' ,left=135 ,top=1823 ,right=434 ,bottom=1865 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=1871 ,right=1886 ,bottom=1871 </L>
		<T>id='(18)-(25)' ,left=135 ,top=1881 ,right=434 ,bottom=1926 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=1931 ,right=1886 ,bottom=1931 </L>
		<T>id='(19)수련보조수당' ,left=135 ,top=1942 ,right=434 ,bottom=1987 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=1998 ,right=1886 ,bottom=1998 </L>
		<T>id='(20)비과세소득 계' ,left=132 ,top=2008 ,right=603 ,bottom=2053 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=2061 ,right=1886 ,bottom=2061 </L>
		<T>id='(20)-1감면소득 계' ,left=130 ,top=2072 ,right=601 ,bottom=2117 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='M0X' ,left=442 ,top=1442 ,right=611 ,bottom=1487 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='O0X' ,left=442 ,top=1505 ,right=611 ,bottom=1550 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Q0X' ,left=442 ,top=1572 ,right=611 ,bottom=1617 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='H0X' ,left=442 ,top=1635 ,right=611 ,bottom=1680 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='', left=1140, top=1442, right=1365, bottom=1487, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1392, top=1442, right=1614, bottom=1487, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1632, top=1505, right=1873, bottom=1550, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1392, top=1505, right=1614, bottom=1550, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1140, top=1505, right=1365, bottom=1550, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=884, top=1505, right=1106, bottom=1550, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=630, top=1505, right=855, bottom=1550, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=630, top=1572, right=855, bottom=1617, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=884, top=1572, right=1106, bottom=1617, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1140, top=1572, right=1365, bottom=1617, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1392, top=1572, right=1614, bottom=1617, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1632, top=1572, right=1873, bottom=1617, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=630, top=1635, right=855, bottom=1680, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=878, top=1635, right=1103, bottom=1680, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1138, top=1635, right=1363, bottom=1680, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1386, top=1635, right=1611, bottom=1680, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1630, top=1635, right=1871, bottom=1680, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=630, top=1699, right=855, bottom=1744, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=884, top=1699, right=1106, bottom=1744, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1140, top=1699, right=1365, bottom=1744, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1392, top=1699, right=1614, bottom=1744, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1632, top=1699, right=1873, bottom=1744, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=630, top=1762, right=855, bottom=1807, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=884, top=1762, right=1106, bottom=1807, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1140, top=1762, right=1365, bottom=1807, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1392, top=1762, right=1614, bottom=1807, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='', left=1632, top=1762, right=1873, bottom=1807, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=865 ,top=672 ,right=865 ,bottom=2125 </L>
		<L> left=1122 ,top=672 ,right=1122 ,bottom=2125 </L>
		<L> left=1373 ,top=672 ,right=1373 ,bottom=2125 </L>
		<L> left=1625 ,top=672 ,right=1625 ,bottom=2125 </L>
		<T>id='강원도 고성군 현내면 화진포서길 10' ,left=627 ,top=516 ,right=1852 ,bottom=561 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=437 ,top=1431 ,right=437 ,bottom=2000 </L>
		<T>id='비' ,left=69 ,top=1550 ,right=122 ,bottom=1590 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='과' ,left=69 ,top=1593 ,right=122 ,bottom=1632 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세' ,left=69 ,top=1635 ,right=122 ,bottom=1675 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='및' ,left=69 ,top=1696 ,right=122 ,bottom=1736 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='감' ,left=69 ,top=1759 ,right=122 ,bottom=1812 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='면' ,left=69 ,top=1815 ,right=122 ,bottom=1855 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='소' ,left=69 ,top=1857 ,right=122 ,bottom=1897 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='득' ,left=69 ,top=1900 ,right=122 ,bottom=1939 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ⅱ' ,left=69 ,top=1500 ,right=122 ,bottom=1540 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='명' ,left=69 ,top=1961 ,right=122 ,bottom=2000 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세' ,left=69 ,top=2003 ,right=122 ,bottom=2043 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=942 ,top=2125 ,right=942 ,bottom=2519 </L>
		<T>id='구          분' ,left=130 ,top=2130 ,right=931 ,bottom=2175 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='소득세' ,left=947 ,top=2130 ,right=1254 ,bottom=2175 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='지방소득세' ,left=1262 ,top=2130 ,right=1569 ,bottom=2175 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='농어촌특별세' ,left=1577 ,top=2130 ,right=1884 ,bottom=2175 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='{decode(DGG_TAX,0,,DGG_TAX)}', left=947, top=2183, right=1254, bottom=2228, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=699 ,top=2326 ,right=1886 ,bottom=2326 </L>
		<L> left=622 ,top=418 ,right=622 ,bottom=2127 </L>
		<T>id='거주지국코드' ,left=1553 ,top=204 ,right=1759 ,bottom=233 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='거주지국' ,left=1331 ,top=204 ,right=1450 ,bottom=233 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='내·외국인' ,left=1331 ,top=235 ,right=1543 ,bottom=265 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='국적코드' ,left=1553 ,top=304 ,right=1762 ,bottom=333 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1545 ,top=302 ,right=1545 ,bottom=407 </L>
		<T>id='세대주여부' ,left=1331 ,top=339 ,right=1543 ,bottom=368 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='연말정산구분' ,left=1331 ,top=373 ,right=1543 ,bottom=402 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1029 ,top=566 ,right=1029 ,bottom=616 </L>
		<L> left=64 ,top=2519 ,right=1886 ,bottom=2519 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='위의 원천징수액(근로소득)을 정히 영수(지급)합니다.' ,left=122 ,top=2524 ,right=1707 ,bottom=2564 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(77)납부특례세액' ,left=124 ,top=2429 ,right=606 ,bottom=2474 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(78)차  감  징  수  세  액[(74)-(75)-(76)-(77)]' ,left=127 ,top=2471 ,right=926 ,bottom=2516 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=127 ,top=2469 ,right=1886 ,bottom=2469 </L>
		<L> left=1257 ,top=2125 ,right=1257 ,bottom=2519 </L>
		<L> left=1572 ,top=2125 ,right=1572 ,bottom=2519 </L>
		<L> left=225 ,top=2230 ,right=225 ,bottom=2426 </L>
		<T>id='건강보험:' ,left=98 ,top=296 ,right=254 ,bottom=336 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='ENO_NO', left=336, top=191, right=474, bottom=270, face='바탕', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='거주자①/비거주자2' ,left=1550 ,top=164 ,right=1860 ,bottom=198 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='TYPE', left=1553, top=235, right=1860, bottom=265, align='left', face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='여1 / 부②' ,left=1611 ,top=267 ,right=1857 ,bottom=302 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='HOL_YN_1', left=1553, top=339, right=1860, bottom=368, align='left', face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='계속근로① , 중도퇴사2' ,left=1553 ,top=370 ,right=1863 ,bottom=405 ,face='바탕' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='고용보험:' ,left=98 ,top=333 ,right=254 ,bottom=373 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='JAS_NM1', left=870, top=741, right=1119, bottom=786, face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='(9)근   무   처   명' ,left=130 ,top=741 ,right=601 ,bottom=786 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='주(현)' ,left=632 ,top=683 ,right=857 ,bottom=728 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='COMP_NM', left=632, top=741, right=857, bottom=786, face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='TAX_NO', left=632, top=802, right=857, bottom=847 ,mask='XXX-XX-XXXXX', face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JAO_NO1', left=870, top=802, right=1119, bottom=847 ,mask='XXX-XX-XXXXX', face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JAO_NO2', left=1124, top=802, right=1371, bottom=847 ,mask='XXX-XX-XXXXX', face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JAO_NO3', left=1392, top=802, right=1614, bottom=847 ,mask='XXX-XX-XXXXX', face='바탕', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAA_AMT1,0,,JAA_AMT1)}', left=884, top=976, right=1106, bottom=1021, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAA_AMT2,0,,JAA_AMT2)}', left=1138, top=976, right=1360, bottom=1021, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAA_AMT3,0,,JAA_AMT3)}', left=1392, top=976, right=1614, bottom=1021, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAC_AMT1,0,,JAC_AMT1)}', left=884, top=1035, right=1106, bottom=1080, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAC_AMT2,0,,JAC_AMT2)}', left=1138, top=1035, right=1360, bottom=1080, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAC_AMT3,0,,JAC_AMT3)}', left=1392, top=1035, right=1614, bottom=1080, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(TAX_INCOME,0,,TAX_INCOME)}', left=630, top=1381, right=855, bottom=1426, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAE_AMT1,0,,JAE_AMT1)}', left=881, top=1381, right=1103, bottom=1426, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAE_AMT2,0,,JAE_AMT2)}', left=1140, top=1381, right=1363, bottom=1426, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAE_AMT3,0,,JAE_AMT3)}', left=1392, top=1381, right=1614, bottom=1426, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SUM,0,,SUM)}', left=1632, top=1381, right=1873, bottom=1426, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAI_AMT1,0,,JAI_AMT1)}', left=884, top=1093, right=1106, bottom=1138, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAI_AMT2,0,,JAI_AMT2)}', left=1138, top=1093, right=1360, bottom=1138, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAI_AMT3,0,,JAI_AMT3)}', left=1392, top=1093, right=1614, bottom=1138, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SUM_JAI_AMT,0,,SUM_JAI_AMT)}', left=1632, top=1093, right=1873, bottom=1138, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(FREE_INCOME,0,,FREE_INCOME)}', left=630, top=2008, right=855, bottom=2053, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAG_AMT3,0,,JAG_AMT3)}', left=1392, top=2008, right=1614, bottom=2053, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAG_AMT2,0,,JAG_AMT2)}', left=1140, top=2008, right=1363, bottom=2053, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAG_AMT1,0,,JAG_AMT1)}', left=881, top=2008, right=1103, bottom=2053, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JAO_NO1', left=706, top=2238, right=939, bottom=2278 ,mask='XXX-XX-XXXXX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='JAO_NO2', left=706, top=2283, right=939, bottom=2323 ,mask='XXX-XX-XXXXX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(REA_TAX,0,,REA_TAX)}', left=945, top=2471, right=1251, bottom=2516, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(REB_TAX,0,,REB_TAX)}', left=1259, top=2471, right=1566, bottom=2516, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(REC_TAXX,0,,REC_TAX)}', left=1574, top=2471, right=1881, bottom=2516, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(CITI_TAX,0,,CITI_TAX)}', left=1259, top=2379, right=1566, bottom=2424, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(INCM_TAX,0,,INCM_TAX)}', left=945, top=2379, right=1251, bottom=2424, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAL_AMT2,0,,JAL_AMT2)}', left=945, top=2283, right=1251, bottom=2328, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAL_AMT1,0,,JAL_AMT1)}', left=945, top=2233, right=1251, bottom=2278, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAN_AMT1,0,,JAN_AMT1)}', left=1257, top=2233, right=1564, bottom=2278, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAN_AMT2,0,,JAN_AMT2)}', left=1259, top=2283, right=1566, bottom=2328, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAN_AMT2,0,,JAN_AMT2)}', left=1574, top=2283, right=1881, bottom=2328, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(JAM_AMT1,0,,JAM_AMT1)}', left=1572, top=2233, right=1879, bottom=2278, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(DBW_TAX,0,,DBW_TAX)}', left=1574, top=2183, right=1881, bottom=2228, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(DJM_TAX,0,,DJM_TAX)}', left=1259, top=2183, right=1566, bottom=2228, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SUM_HINU,0,,SUM_HINU)}', left=257, top=296, right=482, bottom=336, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SUM_HINS,0,,SUM_HINS)}', left=257, top=333, right=482, bottom=373, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SUM_JAA_AMT,0,,SUM_JAA_AMT)}', left=1632, top=976, right=1873, bottom=1021, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SUM_JAC_AMT,0,,SUM_JAC_AMT)}', left=1632, top=1035, right=1873, bottom=1080, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SUM_JAG_AMT,0,,SUM_JAG_AMT)}', left=1632, top=2008, right=1873, bottom=2053, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='210㎜x297㎜(일반용지 60g/㎡)' ,left=1241 ,top=2704 ,right=1881 ,bottom=2738 ,align='right' ,face='바탕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=64 ,top=2699 ,right=1886 ,bottom=2699 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='(서명 또는 인)' ,left=1519 ,top=2617 ,right=1786 ,bottom=2651 ,align='right' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='현대아산(주)' ,left=1236 ,top=2617 ,right=1466 ,bottom=2651 ,align='right' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='징수(보고)의무자' ,left=796 ,top=2617 ,right=1151 ,bottom=2651 ,align='right' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='TAX_OFFICE', left=413, top=2641, right=487, bottom=2686, align='left', face='바탕', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='세무서장  귀하' ,left=492 ,top=2643 ,right=773 ,bottom=2686 ,align='left' ,face='바탕' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='CURDT', left=720, top=2572, right=1130, bottom=2609 ,mask='XXXX년  XX월  XX일', face='바탕', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<I>id='../../images/common/asan_dojang.gif' ,left=1656 ,top=2524 ,right=1831 ,bottom=2699</I>
		<L> left=699 ,top=2278 ,right=1886 ,bottom=2278 </L>
		<T>id='사업자' ,left=566 ,top=2249 ,right=667 ,bottom=2283 ,align='left' ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='등록' ,left=566 ,top=2286 ,right=667 ,bottom=2320 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='번호' ,left=566 ,top=2323 ,right=667 ,bottom=2357 ,face='바탕' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	</B>
	</R>
	</A>
	
	<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='2.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 MasterDataID='gcds_print' 
	<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=2760 ,face='Arial' ,size=10 ,penwidth=1
		<L> left=45 ,top=2651 ,right=1868 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=45 ,top=159 ,right=45 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<T>id='(제2쪽)' ,left=1707 ,top=90 ,right=1863 ,bottom=151 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=45 ,top=156 ,right=1868 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=1868 ,top=156 ,right=1868 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=106 ,top=156 ,right=106 ,bottom=2651 </L>
		<T>id='Ⅳ' ,left=56 ,top=1159 ,right=101 ,bottom=1201 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='정' ,left=56 ,top=1275 ,right=101 ,bottom=1312 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='산' ,left=56 ,top=1386 ,right=101 ,bottom=1423 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='명' ,left=56 ,top=1484 ,right=101 ,bottom=1521 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세' ,left=56 ,top=1606 ,right=101 ,bottom=1643 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1656 ,top=159 ,right=1656 ,bottom=2651 </L>
		<L> left=987 ,top=159 ,right=987 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<L> left=778 ,top=159 ,right=778 ,bottom=2651 </L>
		<T>id='[(16), 다만 외국인단일세율 적용시에는 ' ,left=291 ,top=161 ,right=743 ,bottom=201 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id=' 연간 근로소득)' ,left=291 ,top=198 ,right=743 ,bottom=238 ,align='left' ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=106 ,top=238 ,right=1871 ,bottom=238 </L>
		<T>id='(21)총급여' ,left=114 ,top=180 ,right=275 ,bottom=217 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=106 ,top=1847 ,right=987 ,bottom=1847 </L>
		<T>id='(36)계' ,left=209 ,top=1804 ,right=524 ,bottom=1842 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=204 ,top=1794 ,right=987 ,bottom=1794 </L>
		<T>id='(35)기부금(이월분)' ,left=209 ,top=1749 ,right=524 ,bottom=1786 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=204 ,top=1738 ,right=987 ,bottom=1738 </L>
		<T>id='이자상환액' ,left=318 ,top=1598 ,right=463 ,bottom=1635 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='저당차입금' ,left=318 ,top=1564 ,right=463 ,bottom=1601 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='장기주택' ,left=318 ,top=1529 ,right=463 ,bottom=1566 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(나)' ,left=318 ,top=1495 ,right=463 ,bottom=1532 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='2012년' ,left=482 ,top=1566 ,right=577 ,bottom=1603 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='고정금리/' ,left=614 ,top=1558 ,right=762 ,bottom=1595 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='비거치' ,left=614 ,top=1598 ,right=762 ,bottom=1635 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='상환대출' ,left=614 ,top=1640 ,right=762 ,bottom=1677 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=471 ,top=1548 ,right=987 ,bottom=1548 </L>
		<T>id='그 밖의 대출' ,left=611 ,top=1693 ,right=775 ,bottom=1730 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=606 ,top=1683 ,right=987 ,bottom=1683 </L>
		<T>id='이전' ,left=489 ,top=1461 ,right=585 ,bottom=1498 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='30년 이상' ,left=614 ,top=1505 ,right=762 ,bottom=1543 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=606 ,top=1498 ,right=987 ,bottom=1498 </L>
		<L> left=606 ,top=1447 ,right=987 ,bottom=1447 </L>
		<T>id='15년~29년' ,left=614 ,top=1455 ,right=762 ,bottom=1492 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='15년 미만' ,left=614 ,top=1405 ,right=762 ,bottom=1442 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='차입분' ,left=489 ,top=1495 ,right=585 ,bottom=1532 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='2011년' ,left=489 ,top=1426 ,right=585 ,bottom=1463 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='이후' ,left=482 ,top=1601 ,right=577 ,bottom=1638 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='차입분' ,left=482 ,top=1635 ,right=577 ,bottom=1672 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(15년이상)' ,left=479 ,top=1670 ,right=603 ,bottom=1707 ,face='굴림' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=310 ,top=1394 ,right=990 ,bottom=1394 </L>
		<L> left=471 ,top=1394 ,right=471 ,bottom=1738 </L>
		<T>id='자금' ,left=209 ,top=1519 ,right=304 ,bottom=1556 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='주택' ,left=209 ,top=1484 ,right=304 ,bottom=1521 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(34)' ,left=209 ,top=1450 ,right=304 ,bottom=1487 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=307 ,top=1172 ,right=987 ,bottom=1172 </L>
		<T>id='(노인장기요양 보험료포함)' ,left=312 ,top=1124 ,right=736 ,bottom=1162 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(가)건강보험료' ,left=312 ,top=1093 ,right=736 ,bottom=1130 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=156 ,top=1077 ,right=987 ,bottom=1077 </L>
		<T>id='보험료' ,left=209 ,top=1154 ,right=304 ,bottom=1191 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(33)' ,left=209 ,top=1119 ,right=304 ,bottom=1156 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='제' ,left=161 ,top=1508 ,right=201 ,bottom=1537 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공' ,left=161 ,top=1471 ,right=201 ,bottom=1500 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='득' ,left=161 ,top=1434 ,right=201 ,bottom=1463 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='소' ,left=161 ,top=1397 ,right=201 ,bottom=1426 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='별' ,left=161 ,top=1360 ,right=201 ,bottom=1389 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='특' ,left=161 ,top=1323 ,right=201 ,bottom=1352 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(라)별정우체국연금' ,left=312 ,top=1032 ,right=640 ,bottom=1069 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=307 ,top=1019 ,right=987 ,bottom=1019 </L>
		<T>id='(다)사립학교교직원연금' ,left=312 ,top=974 ,right=640 ,bottom=1011 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=307 ,top=960 ,right=987 ,bottom=960 </L>
		<T>id='(나)군인연금' ,left=312 ,top=915 ,right=640 ,bottom=953 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=307 ,top=905 ,right=987 ,bottom=905 </L>
		<T>id='(가)공무원연금' ,left=312 ,top=857 ,right=640 ,bottom=894 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공   제' ,left=209 ,top=1013 ,right=304 ,bottom=1050 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='보험료' ,left=209 ,top=982 ,right=304 ,bottom=1019 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='연   금' ,left=209 ,top=950 ,right=304 ,bottom=987 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공   적' ,left=209 ,top=918 ,right=304 ,bottom=955 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(32)' ,left=209 ,top=884 ,right=304 ,bottom=921 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=204 ,top=844 ,right=987 ,bottom=844 </L>
		<L> left=307 ,top=844 ,right=307 ,bottom=1738 </L>
		<T>id='(31)국민연금보험료공제' ,left=212 ,top=796 ,right=540 ,bottom=833 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='제' ,left=161 ,top=1011 ,right=201 ,bottom=1040 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공' ,left=161 ,top=982 ,right=201 ,bottom=1011 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='험' ,left=161 ,top=923 ,right=201 ,bottom=953 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='료' ,left=161 ,top=953 ,right=201 ,bottom=982 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='보' ,left=161 ,top=894 ,right=201 ,bottom=923 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='금' ,left=161 ,top=865 ,right=201 ,bottom=894 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='연' ,left=161 ,top=836 ,right=201 ,bottom=865 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(30)한부모가족' ,left=212 ,top=736 ,right=508 ,bottom=773 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=204 ,top=722 ,right=987 ,bottom=722 </L>
		<T>id='(29)부   녀   자' ,left=212 ,top=675 ,right=508 ,bottom=712 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(28)장 애 인 ' ,left=212 ,top=614 ,right=413 ,bottom=651 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=204 ,top=601 ,right=987 ,bottom=601 </L>
		<T>id='(27)경로우대' ,left=212 ,top=553 ,right=413 ,bottom=590 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='제' ,left=161 ,top=701 ,right=201 ,bottom=728 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공' ,left=161 ,top=669 ,right=201 ,bottom=699 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='가' ,left=161 ,top=638 ,right=201 ,bottom=667 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='추' ,left=161 ,top=606 ,right=201 ,bottom=635 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=156 ,top=540 ,right=987 ,bottom=540 </L>
		<T>id='(26)부양가족' ,left=212 ,top=492 ,right=413 ,bottom=529 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=204 ,top=476 ,right=987 ,bottom=476 </L>
		<T>id='(25)배   우   자' ,left=212 ,top=429 ,right=497 ,bottom=466 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='제' ,left=161 ,top=482 ,right=201 ,bottom=511 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공' ,left=161 ,top=452 ,right=201 ,bottom=482 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='본' ,left=161 ,top=423 ,right=201 ,bottom=452 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='기' ,left=161 ,top=394 ,right=201 ,bottom=423 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=156 ,top=355 ,right=156 ,bottom=1847 </L>
		<L> left=204 ,top=357 ,right=204 ,bottom=1849 </L>
		<T>id='(23)근로소득금액' ,left=114 ,top=310 ,right=680 ,bottom=347 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(22)근로소득공제' ,left=114 ,top=251 ,right=680 ,bottom=288 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=106 ,top=2585 ,right=1868 ,bottom=2585 </L>
		<T>id='그' ,left=114 ,top=2064 ,right=153 ,bottom=2101 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='밖' ,left=114 ,top=2167 ,right=153 ,bottom=2207 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='의' ,left=114 ,top=2223 ,right=153 ,bottom=2260 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='소' ,left=114 ,top=2299 ,right=153 ,bottom=2336 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='득' ,left=114 ,top=2344 ,right=153 ,bottom=2381 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공' ,left=114 ,top=2392 ,right=153 ,bottom=2432 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='제' ,left=114 ,top=2439 ,right=153 ,bottom=2482 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=106 ,top=1897 ,right=987 ,bottom=1897 </L>
		<T>id='(37)차감소득금액' ,left=119 ,top=1855 ,right=434 ,bottom=1892 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=156 ,top=1900 ,right=156 ,bottom=2585 </L>
		<T>id='(38)개인연금저축' ,left=164 ,top=1905 ,right=479 ,bottom=1942 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=156 ,top=1998 ,right=987 ,bottom=1998 </L>
		<T>id='(39)소기업 소상공인 공제부금' ,left=164 ,top=1955 ,right=677 ,bottom=1992 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=156 ,top=1947 ,right=987 ,bottom=1947 </L>
		<T>id='(40)' ,left=164 ,top=2003 ,right=302 ,bottom=2040 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='주택마련' ,left=164 ,top=2037 ,right=302 ,bottom=2074 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='저축소득' ,left=164 ,top=2072 ,right=302 ,bottom=2109 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제' ,left=164 ,top=2106 ,right=302 ,bottom=2143 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(나)주택청약종합저축' ,left=318 ,top=2056 ,right=635 ,bottom=2093 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(가)청약저축' ,left=318 ,top=2006 ,right=635 ,bottom=2043 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=307 ,top=1998 ,right=307 ,bottom=2146 </L>
		<L> left=307 ,top=2048 ,right=987 ,bottom=2048 </L>
		<L> left=307 ,top=2098 ,right=987 ,bottom=2098 </L>
		<L> left=159 ,top=2146 ,right=990 ,bottom=2146 </L>
		<T>id='(다)근로자주택마련저축' ,left=318 ,top=2106 ,right=635 ,bottom=2143 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(41)투자조합출자 등' ,left=164 ,top=2156 ,right=677 ,bottom=2193 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=156 ,top=2199 ,right=987 ,bottom=2199 </L>
		<L> left=156 ,top=2252 ,right=987 ,bottom=2252 </L>
		<L> left=159 ,top=2310 ,right=990 ,bottom=2310 </L>
		<L> left=156 ,top=2365 ,right=987 ,bottom=2365 </L>
		<L> left=156 ,top=2421 ,right=987 ,bottom=2421 </L>
		<L> left=156 ,top=2479 ,right=987 ,bottom=2479 </L>
		<L> left=156 ,top=2532 ,right=987 ,bottom=2532 </L>
		<T>id='(49)소득공제 종합한도 초과액' ,left=119 ,top=2601 ,right=632 ,bottom=2638 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(42)신용카드 등 사용액' ,left=164 ,top=2207 ,right=677 ,bottom=2244 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(43)우리사주조합 출연금' ,left=164 ,top=2262 ,right=677 ,bottom=2299 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(45)고용유지 중소기업 근로자' ,left=164 ,top=2376 ,right=677 ,bottom=2413 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(46)목돈 안드는 전세 이자상환액' ,left=164 ,top=2432 ,right=677 ,bottom=2469 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(47)장기집합투자증권저축' ,left=164 ,top=2487 ,right=677 ,bottom=2524 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(48)그 밖의 소득공제 계' ,left=164 ,top=2543 ,right=677 ,bottom=2580 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(50)종합소득 과세표준' ,left=992 ,top=183 ,right=1471 ,bottom=220 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=204 ,top=415 ,right=987 ,bottom=415 </L>
		<L> left=106 ,top=352 ,right=1871 ,bottom=352 </L>
		<T>id='(51)산출세액' ,left=995 ,top=280 ,right=1474 ,bottom=318 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=106 ,top=299 ,right=987 ,bottom=299 </L>
		<L> left=1037 ,top=603 ,right=1865 ,bottom=603 </L>
		<T>id='(56)세액감면계' ,left=1040 ,top=616 ,right=1519 ,bottom=654 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(55)조세조약' ,left=1040 ,top=556 ,right=1519 ,bottom=593 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(53)[조세특례제한법] (54 제외)' ,left=1040 ,top=426 ,right=1519 ,bottom=463 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(52)[소득세법]' ,left=1040 ,top=368 ,right=1519 ,bottom=405 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1037 ,top=415 ,right=1865 ,bottom=415 </L>
		<T>id='(54)[조세특례제한법]  제30조' ,left=1040 ,top=495 ,right=1519 ,bottom=532 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1037 ,top=476 ,right=1865 ,bottom=476 </L>
		<L> left=1037 ,top=542 ,right=1865 ,bottom=542 </L>
		<L> left=204 ,top=661 ,right=1868 ,bottom=661 </L>
		<T>id='면' ,left=992 ,top=550 ,right=1032 ,bottom=579 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='감' ,left=992 ,top=511 ,right=1032 ,bottom=540 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='액' ,left=990 ,top=471 ,right=1029 ,bottom=500 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세' ,left=990 ,top=431 ,right=1029 ,bottom=460 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(57)근로소득' ,left=1040 ,top=675 ,right=1519 ,bottom=712 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1035 ,top=722 ,right=1868 ,bottom=722 </L>
		<L> left=1082 ,top=873 ,right=1082 ,bottom=2289 </L>
		<T>id='(59)과학기술인공제' ,left=1087 ,top=908 ,right=1360 ,bottom=945 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1035 ,top=870 ,right=1868 ,bottom=870 </L>
		<L> left=1386 ,top=923 ,right=1868 ,bottom=923 </L>
		<L> left=1085 ,top=979 ,right=1868 ,bottom=979 </L>
		<L> left=1386 ,top=1037 ,right=1868 ,bottom=1037 </L>
		<L> left=1085 ,top=1093 ,right=1868 ,bottom=1093 </L>
		<T>id='(60)[근로자퇴직급여' ,left=1087 ,top=984 ,right=1360 ,bottom=1021 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='보장법]에 따른' ,left=1087 ,top=1019 ,right=1360 ,bottom=1056 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='퇴직연금' ,left=1087 ,top=1050 ,right=1360 ,bottom=1087 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1386 ,top=1146 ,right=1868 ,bottom=1146 </L>
		<T>id='(61)연금저축' ,left=1087 ,top=1130 ,right=1360 ,bottom=1167 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1037 ,top=1196 ,right=1865 ,bottom=1196 </L>
		<L> left=1386 ,top=1246 ,right=1868 ,bottom=1246 </L>
		<L> left=1225 ,top=1296 ,right=1871 ,bottom=1296 </L>
		<T>id='(62)보험료' ,left=1087 ,top=1270 ,right=1217 ,bottom=1307 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1386 ,top=1347 ,right=1868 ,bottom=1347 </L>
		<L> left=1085 ,top=1400 ,right=1868 ,bottom=1400 </L>
		<L> left=1384 ,top=1458 ,right=1865 ,bottom=1458 </L>
		<T>id='(63)의료비' ,left=1087 ,top=1445 ,right=1360 ,bottom=1482 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1082 ,top=1519 ,right=1865 ,bottom=1519 </L>
		<L> left=1386 ,top=1574 ,right=1868 ,bottom=1574 </L>
		<T>id='(64)교육비' ,left=1087 ,top=1553 ,right=1360 ,bottom=1590 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1085 ,top=1630 ,right=1868 ,bottom=1630 </L>
		<L> left=1386 ,top=1685 ,right=1868 ,bottom=1685 </L>
		<L> left=1386 ,top=1794 ,right=1868 ,bottom=1794 </L>
		<L> left=1386 ,top=1908 ,right=1868 ,bottom=1908 </L>
		<L> left=1386 ,top=2021 ,right=1868 ,bottom=2021 </L>
		<L> left=1386 ,top=2127 ,right=1868 ,bottom=2127 </L>
		<T>id='(73)결정세액[(51)-(56)-(72)]' ,left=1003 ,top=2601 ,right=1516 ,bottom=2638 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1032 ,top=352 ,right=1032 ,bottom=2585 </L>
		<T>id='제' ,left=990 ,top=1640 ,right=1029 ,bottom=1683 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공' ,left=990 ,top=1577 ,right=1029 ,bottom=1617 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='액' ,left=990 ,top=1513 ,right=1029 ,bottom=1550 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세' ,left=990 ,top=1453 ,right=1029 ,bottom=1490 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1085 ,top=2178 ,right=1868 ,bottom=2178 </L>
		<T>id='금' ,left=1087 ,top=1947 ,right=1127 ,bottom=1987 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='부' ,left=1087 ,top=1905 ,right=1127 ,bottom=1942 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='기' ,left=1087 ,top=1863 ,right=1127 ,bottom=1900 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(65)' ,left=1087 ,top=1823 ,right=1127 ,bottom=1860 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1132 ,top=1630 ,right=1132 ,bottom=2178 </L>
		<L> left=1085 ,top=2233 ,right=1868 ,bottom=2233 </L>
		<T>id='(67) 표준세액공제' ,left=1090 ,top=2244 ,right=1355 ,bottom=2281 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(66) 계' ,left=1090 ,top=2188 ,right=1355 ,bottom=2225 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1132 ,top=1849 ,right=1871 ,bottom=1849 </L>
		<L> left=1132 ,top=1963 ,right=1871 ,bottom=1963 </L>
		<L> left=1132 ,top=2077 ,right=1871 ,bottom=2077 </L>
		<T>id='공제대상금액' ,left=1389 ,top=878 ,right=1569 ,bottom=915 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1230 ,top=722 ,right=1230 ,bottom=870 </L>
		<L> left=1230 ,top=773 ,right=1868 ,bottom=773 </L>
		<L> left=1230 ,top=823 ,right=1868 ,bottom=823 </L>
		<T>id='공제대상자    ' ,left=1238 ,top=730 ,right=1434 ,bottom=767 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='6세 이하        ' ,left=1238 ,top=781 ,right=1434 ,bottom=818 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='출산·입양자   ' ,left=1238 ,top=831 ,right=1434 ,bottom=868 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=1154 ,right=1569 ,bottom=1191 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=1101 ,right=1569 ,bottom=1138 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=1048 ,right=1569 ,bottom=1085 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=990 ,right=1569 ,bottom=1027 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=934 ,right=1569 ,bottom=971 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=1204 ,right=1569 ,bottom=1241 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=1254 ,right=1569 ,bottom=1291 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=1304 ,right=1569 ,bottom=1341 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=1355 ,right=1569 ,bottom=1392 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=1410 ,right=1569 ,bottom=1447 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=1468 ,right=1569 ,bottom=1505 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=1527 ,right=1569 ,bottom=1564 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=1585 ,right=1569 ,bottom=1622 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=1638 ,right=1569 ,bottom=1675 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=1696 ,right=1569 ,bottom=1733 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=1746 ,right=1569 ,bottom=1783 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=1804 ,right=1569 ,bottom=1842 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=1860 ,right=1569 ,bottom=1897 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=1918 ,right=1569 ,bottom=1955 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=1974 ,right=1569 ,bottom=2011 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=2032 ,right=1569 ,bottom=2069 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공제대상금액' ,left=1389 ,top=2085 ,right=1569 ,bottom=2122 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세액공제액' ,left=1389 ,top=2135 ,right=1569 ,bottom=2172 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(58)자녀' ,left=1040 ,top=778 ,right=1167 ,bottom=815 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='연' ,left=1040 ,top=968 ,right=1080 ,bottom=997 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='금' ,left=1040 ,top=1008 ,right=1080 ,bottom=1037 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='계' ,left=1040 ,top=1048 ,right=1080 ,bottom=1077 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='좌' ,left=1040 ,top=1087 ,right=1080 ,bottom=1117 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1225 ,top=1196 ,right=1225 ,bottom=1400 </L>
		<T>id='보장성' ,left=1233 ,top=1228 ,right=1341 ,bottom=1265 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='장애인전용' ,left=1233 ,top=1312 ,right=1376 ,bottom=1349 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='보장성' ,left=1233 ,top=1349 ,right=1341 ,bottom=1386 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1249 ,top=1630 ,right=1249 ,bottom=1849 </L>
		<L> left=1249 ,top=1738 ,right=1868 ,bottom=1738 </L>
		<T>id='이하' ,left=1259 ,top=1685 ,right=1352 ,bottom=1722 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='10만원' ,left=1259 ,top=1648 ,right=1352 ,bottom=1685 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='초과' ,left=1259 ,top=1794 ,right=1352 ,bottom=1831 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='10만원' ,left=1259 ,top=1757 ,right=1352 ,bottom=1794 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='기부금' ,left=1138 ,top=1767 ,right=1241 ,bottom=1804 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='자금' ,left=1138 ,top=1725 ,right=1241 ,bottom=1762 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(가)정치' ,left=1138 ,top=1683 ,right=1241 ,bottom=1720 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(나)법정기부금' ,left=1138 ,top=1889 ,right=1363 ,bottom=1926 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(다)우리사주조합' ,left=1138 ,top=1969 ,right=1363 ,bottom=2006 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='기부금(2015년' ,left=1138 ,top=2003 ,right=1363 ,bottom=2040 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='이후 기부분)' ,left=1138 ,top=2037 ,right=1363 ,bottom=2074 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(나)지정기부금' ,left=1138 ,top=2111 ,right=1363 ,bottom=2148 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1384 ,top=873 ,right=1384 ,bottom=2178 </L>
		<L> left=1032 ,top=2289 ,right=1868 ,bottom=2289 </L>
		<T>id='(68)납세조합공제' ,left=1040 ,top=2297 ,right=1561 ,bottom=2334 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1032 ,top=2339 ,right=1868 ,bottom=2339 </L>
		<L> left=1032 ,top=2389 ,right=1868 ,bottom=2389 </L>
		<L> left=1032 ,top=2439 ,right=1868 ,bottom=2439 </L>
		<L> left=1032 ,top=2535 ,right=1868 ,bottom=2535 </L>
		<T>id='공제대상금액' ,left=1389 ,top=2445 ,right=1569 ,bottom=2482 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1386 ,top=2487 ,right=1868 ,bottom=2487 </L>
		<T>id='세액공제액' ,left=1389 ,top=2495 ,right=1569 ,bottom=2532 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(69)주택차입금' ,left=1040 ,top=2347 ,right=1561 ,bottom=2384 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(70)외국납부' ,left=1040 ,top=2397 ,right=1561 ,bottom=2434 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(71)월세액' ,left=1040 ,top=2474 ,right=1378 ,bottom=2511 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(72)세액공제계' ,left=1040 ,top=2543 ,right=1561 ,bottom=2580 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1384 ,top=2439 ,right=1384 ,bottom=2535 </L>
		<L> left=204 ,top=1249 ,right=987 ,bottom=1249 </L>
		<T>id='(나)고용보험료' ,left=312 ,top=1193 ,right=736 ,bottom=1230 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='거주자' ,left=614 ,top=1336 ,right=749 ,bottom=1373 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='대출기관' ,left=614 ,top=1275 ,right=749 ,bottom=1312 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=606 ,top=1251 ,right=606 ,bottom=1741 </L>
		<L> left=603 ,top=1323 ,right=987 ,bottom=1323 </L>
		<T>id='원리금상환액' ,left=312 ,top=1323 ,right=572 ,bottom=1360 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='(가)주택임차차입금' ,left=312 ,top=1289 ,right=572 ,bottom=1326 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='제' ,left=111 ,top=1643 ,right=151 ,bottom=1685 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공' ,left=111 ,top=1582 ,right=151 ,bottom=1622 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='득' ,left=111 ,top=1521 ,right=151 ,bottom=1558 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='소' ,left=111 ,top=1461 ,right=151 ,bottom=1498 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='합' ,left=111 ,top=1394 ,right=151 ,bottom=1434 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='종' ,left=111 ,top=1331 ,right=151 ,bottom=1371 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='특' ,left=1040 ,top=1519 ,right=1080 ,bottom=1558 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='별' ,left=1040 ,top=1582 ,right=1080 ,bottom=1622 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='세' ,left=1040 ,top=1648 ,right=1080 ,bottom=1685 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='액' ,left=1040 ,top=1709 ,right=1080 ,bottom=1746 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='공' ,left=1040 ,top=1770 ,right=1080 ,bottom=1810 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='제' ,left=1040 ,top=1831 ,right=1080 ,bottom=1873 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=156 ,top=783 ,right=987 ,bottom=783 </L>
		<C>id='{decode(SUM,0,,SUM)}', left=783, top=177, right=984, bottom=222, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LOAN_DED,0,,LOAN_DED)}', left=783, top=1267, right=984, bottom=1312, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(TTAX_STD,0,,TTAX_STD)}', left=1664, top=172, right=1865, bottom=217, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(TAX_AMT,0,,TAX_AMT)}', left=1664, top=270, right=1865, bottom=315, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(HGR_DED,0,,HGR_DED)}', left=1664, top=672, right=1865, bottom=717, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(AGE_AMT,0,,AGE_AMT)}', left=1664, top=728, right=1865, bottom=773, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(AGE_INP,0,,AGE_INP)}', left=1664, top=828, right=1865, bottom=873, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(ANN_DED,0,,ANN_DED)}', left=1664, top=1151, right=1865, bottom=1196, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(MMA_DED,0,,MMA_DED)}', left=1664, top=1468, right=1865, bottom=1513, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(GOV_DED,0,,GOV_DED)}', left=1664, top=1691, right=1865, bottom=1736, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LC23_DED,0,,LC23_DED)}', left=1664, top=2130, right=1865, bottom=2175, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(MRENT_AMT,0,,MRENT_AMT)}', left=1664, top=2490, right=1865, bottom=2535, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SUM_HINS,0,,SUM_HINS)}', left=783, top=1193, right=984, bottom=1238, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SUM_HINU,0,,SUM_HINU)}', left=783, top=1106, right=984, bottom=1151, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(NPEN_DED,0,,NPEN_DED)}', left=783, top=791, right=984, bottom=836, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(OTX_DED,0,,OTX_DED)}', left=783, top=730, right=984, bottom=775, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(WDD_AMT,0,,WDD_AMT)}', left=783, top=672, right=984, bottom=717, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(TBL_DED,0,,TBL_DED)}', left=783, top=611, right=984, bottom=656, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(GOL_AMT,0,,GOL_AMT)}', left=783, top=550, right=984, bottom=595, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(GDED_AMT,0,,GDED_AMT)}', left=783, top=487, right=984, bottom=532, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SPSB_AMT,0,,SPSB_AMT)}', left=783, top=426, right=984, bottom=471, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(MNI_AMT,0,,MNI_AMT)}', left=783, top=307, right=984, bottom=352, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(MGR_AMT,0,,MGR_AMT)}', left=783, top=249, right=984, bottom=294, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(PLOAN_DED,0,,PLOAN_DED)}', left=783, top=1339, right=984, bottom=1384, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LH4_AMT,0,,LONG_DED)}', left=783, top=1402, right=984, bottom=1447, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LH6_AMT,0,,LONG_DED)}', left=783, top=1503, right=984, bottom=1548, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LH7_AMT,0,,LONG_DED)}', left=783, top=1595, right=984, bottom=1640, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LH8_AMT,0,,LONG_DED)}', left=783, top=1691, right=984, bottom=1736, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(DON_FWD,0,,DON_FWD)}', left=783, top=1744, right=984, bottom=1789, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(VEN_DED,0,,VEN_DED)}', left=783, top=1797, right=984, bottom=1842, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(INDED_TOT,0,,INDED_TOT)}', left=783, top=1852, right=984, bottom=1897, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(PER_DED,0,,PER_DED)}', left=783, top=1900, right=984, bottom=1945, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SSO_DED,0,,SSO_DED)}', left=783, top=1953, right=984, bottom=1998, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SAVE2_DED,0,,SAVE2_DED)}', left=783, top=2053, right=984, bottom=2098, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SAVE3_DED,0,,SAVE3_DED)}', left=783, top=2101, right=984, bottom=2146, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(CARD_DED,0,,CARD_DED)}', left=783, top=2207, right=984, bottom=2252, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SAJU_DED,0,,SAJU_DED)}', left=783, top=2260, right=984, bottom=2305, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LSS_DED,0,,LSS_DED)}', left=783, top=2484, right=984, bottom=2529, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(INDED_EXC,0,,INDED_EXC)}', left=783, top=2601, right=984, bottom=2646, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='(24)본         인' ,left=212 ,top=368 ,right=497 ,bottom=405 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='{decode(BADD_AMT,0,,BADD_AMT)}', left=783, top=362, right=984, bottom=407, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LH5_AMT,0,,LONG_DED)}', left=783, top=1453, right=984, bottom=1498, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(SAVE1_DED,0,,SAVE1_DED)}', left=783, top=2003, right=984, bottom=2048, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(DGG_TAX,0,,DGG_TAX)}', left=1664, top=2596, right=1865, bottom=2641, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(TDED_TOT,0,,TDED_TOT)}', left=1664, top=2540, right=1865, bottom=2585, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(STA_TOT,0,,STA_TOT)}', left=1664, top=2238, right=1865, bottom=2283, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(NSE_TOT,0,,NSE_TOT)}', left=1664, top=2183, right=1865, bottom=2228, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LC1_DED,0,,LC1_DED)}', left=1664, top=1916, right=1865, bottom=1961, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(GOV2_DED,0,,GOV2_DED)}', left=1664, top=1802, right=1865, bottom=1847, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(EDU_DED,0,,EDU_DED)}', left=1664, top=1582, right=1865, bottom=1627, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(LIH_DED,0,,LIH_DED)}', left=1664, top=1352, right=1865, bottom=1397, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(MIN_DED,0,,MIN_DED)}', left=1664, top=1249, right=1865, bottom=1294, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(AGE_RCH,0,,AGE_RCH)}', left=1664, top=778, right=1865, bottom=823, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(TAX_DED,0,,TAX_DED)}', left=1664, top=614, right=1865, bottom=659, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(VEN2_DED,0,,VEN2_DED)}', left=783, top=2154, right=984, bottom=2199, align='right', face='바탕체', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='(44)우리사주조합 기부금(2014년 이전 기부분)' ,left=164 ,top=2320 ,right=770 ,bottom=2357 ,align='left' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='{decode(DFM_CNT,0,,DFM_CNT)}', left=415, top=492, right=545, bottom=529 ,mask='(XX명)', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(GOL_CNT,0,,GOL_CNT)}', left=415, top=553, right=545, bottom=590 ,mask='(XX명)', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(TRB_CNT,0,,TRB_CNT)}', left=415, top=614, right=545, bottom=651 ,mask='(XX명)', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(CHI_INP,0,,CHI_INP)}', left=1439, top=831, right=1569, bottom=868 ,mask='(XX명)', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(CHI_RCH,0,,CHI_RCH)}', left=1439, top=781, right=1569, bottom=818 ,mask='(XX명)', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{decode(CHI_CNT,0,,CHI_CNT)}', left=1439, top=730, right=1569, bottom=767 ,mask='(XX명)', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	</B>
	</R>
	</A>

">
</OBJECT>



<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
