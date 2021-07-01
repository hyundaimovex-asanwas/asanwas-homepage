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

    <title>개인별상세내역현황(yaca070_142)</title>
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

            params = "&S_MODE=SHR_142"
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

    <!-- 타이틀 바 테이블 시작 -->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="../../images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">개인별상세내역현황_2</td>
                    <td align="right" class="navigator">HOME/정산세무/연말정산/<font color="#000000">개인별상세내역현황_2</font></td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- 타이틀 바 테이블 끝 -->

    <!-- 버튼 테이블 시작 -->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
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


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
