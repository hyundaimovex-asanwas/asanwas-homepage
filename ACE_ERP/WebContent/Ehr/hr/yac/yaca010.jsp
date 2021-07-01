<!--
****************************************************************************
* @source      : yaca010.jsp                                                													*
* @description : 연말정산절차안내 PAGE                                      												*
****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 												*
*----------------------------------------------------------------------------
* 2012/11/23            이동훈             최초작성                         															*
*****************************************************************************
-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>
<%
Configuration configPath = Configuration.getInstance();
String fileDownLoadPath = configPath.getString("framework.file.download");
%>
<HTML><HEAD><TITLE>연말정산절차안내</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<link href="/css/general2.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
        //단축키 순서
        var btnList = "T"   //조회
                    + "F"   //신규
                    + "T"   //저장
                    + "T"   //취소
                    + "F"   //엑셀
                    + "T"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기
        //Layer ID
        var layerList = new Array(  "tabYACA001_01"
                                   ,"tabYACA001_02"
                                   ,"tabYACA001_03"
                                   ,"tabYACA001_04"
                                   ,"tabYACA001_05"
                                   ,"tabYACA001_06"
                                   ,"tabYACA001_07"
                                   ,"tabYACA001_08"
                                   ,"tabYACA001_09"
                                   ,"tabYACA001_10"
                                    );


        //Layer ID
        var LeftlayerList = new Array(  "layer_1"
                                   ,"layer_2"
                                   ,"layer_3"
                                   ,"layer_4"
                                   ,"layer_5"
                                   ,"layer_6"
                                   ,"layer_7"
                                   ,"layer_8"
                                   ,"layer_9"
                                   ,"layer_10"
                                   ,"layer_11"
                                   ,"layer_12"
                                    );

        var LeftTwolayerList = new Array(  "layerTwo_1"
                                   ,"layerTwo_2"
                                   ,"layerTwo_3"
                                   ,"layerTwo_4"
								   );

        /**
         * 해당 레이어 보여주고 닫기
         * @param 클릭한 layer idx
         */
        function TabEvent(idx) {
            ActiveIndex = idx+1;
			fnc_ShowHiddenLayer(layerList, layerList[idx]);
            //Tab 이미지 보여주고 닫기 (문서 권한에 따라 보여주는것과 아닌것이 달라짐)
            for(var i=1; i<=10; i++) {
                if(document.getElementById("TabBtn0"+i) == undefined) {
                    continue;
                }
                document.getElementById("TabLeft0"+i).src = "/images/common/tabGray25Left.gif";
                document.getElementById("TabBtn0"+i).className = "hiddenMenu25";
                document.getElementById("TabRight0"+i).src = "/images/common/tabGray25Right.gif";
            }

            document.getElementById("TabLeft0"+ActiveIndex).src = "/images/common/tab25Left.gif";
            document.getElementById("TabBtn0"+ActiveIndex).className = "overMenu25";
            document.getElementById("TabRight0"+ActiveIndex).src = "/images/common/tab25Right.gif";

            //fnc_TabOnClick(ActiveIndex);

        }
        /**
         * 선택한 창들을 보여주고 닫는 역활
         */
        function fnc_ClickBtn(selectKey) {
            var indexKey;

            //Layer 보여주고 닫기
            fnc_ShowHiddenLayer(LeftlayerList, LeftlayerList[parseInt(selectKey)-1]);

            //Tab 이미지 보여주고 닫기 (문서 권한에 따라 보여주는것과 아닌것이 달라짐)
            for(var i=1; i<=12; i++) {
                indexKey = lpad(i, 2, "0");
                if(document.getElementById("LeftTabBtn"+indexKey) == undefined) {
                    continue;
                }
                document.getElementById("LeftTabLeft"+indexKey).src         = "/images/common/tabTop.gif";
                document.getElementById("LeftTabBtn"+indexKey).background   = "/images/common/tabMiddle.gif";
                document.getElementById("LeftTabBtn"+indexKey).className    = "tabV";
                document.getElementById("LeftTabRight"+indexKey).src        = "/images/common/tabBottom.gif";
            }

            selectKey = lpad(selectKey, 2, "0");

            document.getElementById("LeftTabLeft"+selectKey).src            = "/images/common/tabTop_over.gif";
            document.getElementById("LeftTabBtn"+selectKey).background      = "/images/common/tabMiddle_over.gif";
            document.getElementById("LeftTabBtn"+selectKey).className       = "tabV_over";
            document.getElementById("LeftTabRight"+selectKey).src           = "/images/common/tabBottom_over.gif";
        }
        /**
         * 선택한 창들을 보여주고 닫는 역활
         */
        function fnc_ClickBtnTwo(selectKey) {
            var indexKey;

            //Layer 보여주고 닫기
            fnc_ShowHiddenLayer(LeftTwolayerList, LeftTwolayerList[parseInt(selectKey)-1]);

            //Tab 이미지 보여주고 닫기 (문서 권한에 따라 보여주는것과 아닌것이 달라짐)
            for(var i=1; i<=4; i++) {
                indexKey = lpad(i, 2, "0");
                if(document.getElementById("LeftTwoTabBtn"+indexKey) == undefined) {
                    continue;
                }
                document.getElementById("LeftTwoTabLeft"+indexKey).src         = "/images/common/tabTop.gif";
                document.getElementById("LeftTwoTabBtn"+indexKey).background   = "/images/common/tabMiddle.gif";
                document.getElementById("LeftTwoTabBtn"+indexKey).className    = "tabV";
                document.getElementById("LeftTwoTabRight"+indexKey).src        = "/images/common/tabBottom.gif";
            }

            selectKey = lpad(selectKey, 2, "0");

            document.getElementById("LeftTwoTabLeft"+selectKey).src            = "/images/common/tabTop_over.gif";
            document.getElementById("LeftTwoTabBtn"+selectKey).background      = "/images/common/tabMiddle_over.gif";
            document.getElementById("LeftTwoTabBtn"+selectKey).className       = "tabV_over";
            document.getElementById("LeftTwoTabRight"+selectKey).src           = "/images/common/tabBottom_over.gif";
        }

		function fnc_LeftFlow(paramOne, paramTwo){
			TabEvent(paramOne);
			fnc_ClickBtn(paramTwo);
		}
		function fnc_LeftTwoFlow(paramOne, paramTwo){
			TabEvent(paramOne);
			fnc_ClickBtnTwo(paramTwo);
		}
        /********************************************
         * 15. 단축키 처리                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }
//-->
</SCRIPT>
</HEAD>
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onLoad="TabEvent(5)" >
	<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="23"><img src="/images/common/barHead.gif" width="23"
					height="25"></td>
				<td valign="top" background="/images/common/barGreenBg.gif"
					class="barTitle">연말정산절차안내</td>
				<td align="right" class="navigator">HOME/정산세무/연말정산/<font
					color="#000000">연말정산절차안내</font></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>

	<!-- 타이틀 바 테이블 끝 -->
<TABLE cellSpacing=0 cellPadding=0 width=800 border=0>
	<tr>
		<td>
		  모든 근로자는 연말정산 안내문을 반드시 숙지하고 해당되는 소득공제 사항 등을 체크한 후 <br>
		  그에 필요한 각종 소득공제 등 증빙서류를 제출하여야 합니다.<BR><BR>
          <FONT color=#ff0000>* 부양가족 및 의료비, 교육비 등의 공제 받을 항목이 없는 경우에도 
          <U>"신고서" 저장(출력)후 제출하셔야 합니다.</U>
          </FONT>		
		</td>
	</tr>
</table>


<!-- 탭 사용 컴퍼넌트 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="left">

            <!-- 탭버튼데이블 시작 -->
            <table border="0" cellspacing="0" cellpadding="0">

                <tr>
                    <td width="120">
                        <!-- 탭오버 -->
                        <table width="250" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft06"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(5)" style="cursor:hand" id="TabBtn06">정산절차도</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight06"></td>
                            </tr>
                        </table>
                    </td>

                    <td>
                        <!-- 탭히든 -->
                        <table width="250" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft08"></td>
                                <td align="center" class="hiddenMenu25" onclick="fnc_LeftFlow(7,1)" style="cursor:hand" id="TabBtn08">소득공제</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight08"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                
                    

                
                         <!-- 탭히든 -->
                        <table width="250" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft09"></td>
                                <td align="center" class="hiddenMenu25" onclick="fnc_LeftTwoFlow(8,1)" style="cursor:hand" id="TabBtn09">세액공제</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight09"></td>
                            </tr>
                        </table>
                    </td>
                    
                </tr>
                <tr>                    
                    
                    <td>
                        <!-- 탭히든 -->
                        <table width="250" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft010"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(9)" style="cursor:hand" id="TabBtn010">제출증빙서류</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight010"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- 탭히든 -->
                        <table width="250" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">제출서류 불필요</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight02"></td>
                            </tr>
                        </table>
                    </td>            
                
                    <td width="150">
                        <!-- 탭오버 -->
                        <table width="250" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tab25Left.gif" width="6" height="25" id="TabLeft01"></td>
                                <td align="center" class="overMenu25" onclick="TabEvent(0)" style="cursor:hand" id="TabBtn01">소득금액요건</td>
                                <td width="6"><img src="/images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>
                            </tr>
                        </table>
                    </td>

                    <td>
                        <!-- 탭히든 
                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft03"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(2)" style="cursor:hand" id="TabBtn03">세테크</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight03"></td>
                            </tr>
                        </table>
                    </td>
                    
                    <td>
                         
                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft07"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(6)" style="cursor:hand" id="TabBtn07">
								<A  href="/common/downloadFile.jsp?FILE_NAME=2012.hwp&FILE_URL=<%=fileDownLoadPath%>/2012.hwp"  target=_blank>
								올해의 변경사항
								</a>
								</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight07"></td>
                            </tr>
                        </table>
                    </td>       
                    
                    <td>

                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft04"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(3)" style="cursor:hand" id="TabBtn04">
								<A  href="/common/downloadFile.jsp?FILE_NAME=2012 ox quiz.pdf&FILE_URL=<%=fileDownLoadPath%>/2012 ox quiz.pdf"  target=_blank>OX퀴즈 문제</a>
								</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight04"></td>
                            </tr>
                        </table>
                    </td>
                    <td>

                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft05"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(4)" style="cursor:hand" id="TabBtn05">
								<A  href="/common/downloadFile.jsp?FILE_NAME=2012 ox result.pdf&FILE_URL=<%=fileDownLoadPath%>/2012 ox result.pdf"  target=_blank>
								OX퀴즈 정답
								</a>
								</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight05"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
				-->


            </table>
        </td>
    </tr>
</table>

<hr width="760" size="5" align="left" color="#97C821">

<!-- 탭1 조건 입력 테이블 시작 -->
<div class=page id="tabYACA001_01" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
			<table width="750" border="0" cellspacing="1" cellpadding="4">
				<tr>
					<td colspan="4" height="30"><b><font color="#FF3300">▶ 연간 소득금액 100만원 이하
						소득금액 요건에 대하여</font></b></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td colspan="3"><b>1.소득금액 100만원의 중요성</b></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>①</td>
					<td>소득금액의 개념</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>연간 소득금액이란 종합(근로·사업·이자·배당소득 등)·퇴직·양도 연간 합계액으로써,
						총수입 금액이 아니라 <u>필요경비를 공제한 후의 금액을 말함.</u><br>
						이때, 총수입금액에서 비과세소득 및 분리과세대상 소득금액은 제외함. </td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>②</td>
					<td>소득금액 100만원을 초과하면 공제되지 않는 항목</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td><font color="#3333FF">배우자공제, 직계존/비속·형제자매의 기본공제, 보험료공제, 교육비공제, 신용카드공제, 직계존/비속·형제자매의 혼인·장례비용</font></td>
				</tr>
				<tr>
					<td colspan="4">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td colspan="3"><b>2. 배우자, 부모님, 자녀, 형제자매의 대표적인 직업별 소득금액 100만원</b></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td valign="top">①</td>
					<td>2개 이상의 복수소득이 있으면 소득금액을 합산하여 100만원 초과여부를 고려함.</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td valign="top">②</td>
					<td>연도 중 퇴사자나 폐업자도 취업(사업)중 받은 보수를 기준으로 100만원 초과여부를 고려함.</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td valign="top">③</td>
					<td>소득의 종류를 모르면 보수를 지급하는 회사에 문의하는 것이 좋으며, 4대 보험이 가입된 경우에는 근로자,
						가입이 안된 경우에는 사업자 또는 기타소득자일 가능성이 높음.</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>1) <font color="#3333FF">근로소득자</font> : 총 과세급여 - 근로소득공제 = 100만원<br>
						<font color="#FF0000">&nbsp;&nbsp;&nbsp;&nbsp;※ 총 과세급여가 최대 500만원 이하이면
						공제 신청 가능함</font><br>
						2) <font color="#3333FF">사업자, 프리랜서 인적 용역 사업자</font> <br>
						&nbsp;&nbsp;&nbsp;&nbsp;: 총 수입금액 - 필요경비(업종별 단순경비율 적용 금액) = 100만원<br>
						3) <font color="#3333FF">퇴직소득자</font> <br>
					&nbsp;&nbsp;&nbsp;&nbsp;: 필요경비를 공제하지 않은 퇴직금 총액을 소득금액으로 본다.<br>
						4) <font color="#3333FF">연금소득자</font> <br>
					&nbsp;&nbsp;&nbsp;&nbsp;: 공무원연금인 경우 2001.12.31 이전 퇴직한 공무원이 받는 연금은 비과세소득이므로 부모님에게<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 생활비를 보태주고 있다면 인적공제가 가능함. </td>
				</tr>
			</table>

</div>
<!-- 탭1 조건 입력 테이블 끝 -->
<div class=page id="tabYACA001_02" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
			<table width="750" border="0" cellspacing="1" cellpadding="4">
				<tr>
					<td colspan="3" height="30"><b><font color="#FF0000">▶ 증빙서류를 제출할 필요가
						없는 경우</font></b></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td valign="top">1. </td>
					<td>자동차보험 영수증 하나로 100만원이 넘는다면 생명보험 영수증 등 다른 보장성보험 영수증을 제출해도 추가로 공제 안 됨. (보장성보험 공제한도: 100만원)
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="top" width="130"><font color="#FF0000">＊ 맞벌이부부
									세테크: </font></td>
								<td><font color="#FF0000">남편이 연 100만원이 넘는 종신보험에 가입한 경우에는 자동차보험은 아내 명의로 가입하여 아내가 소득공제 신청하는 것이 유리함 </font></td>
							</tr>
						</table>
						</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td valign="top">2.</td>
					<td>의료비영수증은 합계가 총 과세급여의 3% 이하라면 영수증을 제출할 필요없음.<br>
						예를 들어 연봉이 3,000만원이고 의료비 지출액이 90만원 이하이면 영수증을 제출해도 공제 안 됨.<br>
						(의료비 최저한도는 총 과세급여의 3%임)</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td valign="top">3.</td>
					<td>신용카드 사용금액(현금영수증 사용금액 포함)이 총 과세급여의 25% 이하라면 사용금액확인서를 제출할 필요없음.<br>
						예를 들어 연봉이 3,000만원이고 신용카드사용금액이 450만원 이하이면 확인서를 제출해도 공제 안 됨.<br>
					(신용카드공제 최저한도는 총 과세급여의 25%임)<br>
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="top" width="130"><font color="#FF0000">＊ 맞벌이부부 세테크: </font></td>
								<td><font color="#FF0000">아내의 신용카드 사용액이 연봉의 25% 이하로 예상되면 아내가 남편카드를 사용하는 것이 유리함.</font></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td valign="top">4.</td>
					<td>근로자 본인의 지정기부금(종교단체 등) 최고 한도는 총 과세급여에서 <font color="#0033CC">근로소득공제액</font>을
						차감한 금액의 10%임.<br>
						예를 들어 연봉이 3,000만원이면 17,750,000원의 10%인 1,775,000원을 넘는 기부금 영수증을 제출해도
						1,775,000원만 공제됨.
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="top"><font color="#0033CC">→ </font></td>
								<td><font color="#0033CC">근로소득공제액 : 12,250,000 = 1,000만원 + (연봉 1500만원 초과액 × 15%)</font></td>
							</tr>
						</table>
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="top" width="130"><font color="#FF0000">＊ 맞벌이부부세테크: </font></td>
								<td><font color="#FF0000">남편의 기부금 한도가 초과되면 초과분에 대해 아내 명의로 기부하여 아내가 소득공제 신청하는것이 유리함.</font></td>
							</tr>
						</table>

					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td valign="top">5.</td>
					<td> 보험료·의료비·교육비·주택자금·혼인·이사·장례·신용카드 공제는 근로자인 기간에 지출된 금액만 공제되므로 입사 전에 사용한
						영수증은 제출할 필요없음.</td>
				</tr>
			</table>
</div>

<div class=page id="tabYACA001_03" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
			<table width="750" border="0" cellspacing="1" cellpadding="4">
				<tr>
					<td height="30"><b><font color="#FF0000">▶ 맞벌이 부부 세테크</font></b></td>
				</tr>
				<tr>
					<td>1. 배우자공제의 요건인 <font color="#0033CC">“연간 소득금액 100만원 이하”</font> 개념을 확실히 이해함.</td>
				</tr>
				<tr>
					<td>2. <u><b>연간 소득금액 100만원 초과하는 배우자</b></u>와 관련된 각종 소득공제 가능 여부</td>
				</tr>
				<tr>
					<td><font color="#0033CC">&nbsp;&nbsp;&nbsp;&nbsp;① 배우자의 인적공제 불가능함</font></td>
				</tr>
				<tr>
					<td><font color="#0033CC">&nbsp;&nbsp;&nbsp;&nbsp;② 배우자의 보장성 보험료</font></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;본인이 계약자이고 피보험자가 배우자인 경우에는 남편, 아내 모두 소득공제 불가능함.</td>
				</tr>
				<tr>
					<td><font color="#0033CC">&nbsp;&nbsp;&nbsp;&nbsp;③ 배우자의 의료비</font></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;의료비는 배우자의 소득과 연령에 관계없이 의료비를 지출한 근로자가 공제를 받을 수 있음.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;다만, 의료비공제는 의료비를 직접 지출한 사람이 공제받을 수 있으므로 신용카드(현금영수증 포함)로<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;의료비를 지출하였다면 카드명의자가 공제해야 함.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;그리고 의료비공제는 총 과세급여의 3%를 초과 사용해야 공제되므로 의료비지출이 작은 경우에는 본인보다<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;연봉이 작은 배우자쪽에서 공제하는 것이 유리한 경우도 있을 수 있으므로 유의</td>
				</tr>
				<tr>
					<td><font color="#0033CC">&nbsp;&nbsp;&nbsp;&nbsp;④ 배우자의 교육비</font></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;교육비는 소득제한요건이 있으므로 배우자의 교육비는 소득공제 불가능함</td>
				</tr>
				<tr>
					<td><font color="#0033CC">&nbsp;&nbsp;&nbsp;&nbsp;⑤ 배우자의 신용카드</font></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신용카드(현금영수증 포함)는 소득제한요건이 있으므로 한 쪽으로 몰아서 공제 받을 수 없고, 가족카드는<br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;결제자 기준이 아니라 사용자 기준이므로 각각 공제 받을 수 있음. 따라서 절세비율이 높은 배우자 쪽의<br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;카드를 주로 사용하는 것이 유리함.</td>
				</tr>
				<tr>
					<td>3. <u><b>연간 소득금액이 100만원 이하인 배우자</b></u>와 관련된 각종 소득공제 가능 여부</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;<font color="#0033CC">배우자의 인적공제 및 보장성 보험료, 의료비, 교육비, 신용카드(현금영수증 포함) 소득공제가 가능함.</font></td>
				</tr>
				<tr>
					<td>4. 부모님, 장인·장모, (외)조부모의 신용카드(현금영수증 포함) 사용금액</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;연령에 관계없이 소득이 없고 생계를 같이 하는 직계존속이 사용한 금액은 직계존속을 인적공제자로 신청한 <br>
						&nbsp;&nbsp;&nbsp;&nbsp;배우자가 소득공제를 해야 함.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;예를 들면, 사업자인 남편이 부모님 인적공제를 했다면 근로자인 아내는 카드공제를 받을 수 없음.<br><br></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td><b><font color="#FF0000">▶ 주소지가 다른 형제자매중 대학생이 있는 경우 세테크</font></b></td>
				</tr>
				<tr>
					<td valign="top">
					같이 거주하면서 대학생인 형제자매(연간 소득금액이 100만원 이하인 동생, 처남, 처제, 시동생, 누나, 형님)의
						등록금을 근로자 본인이 지원해준 경우에는 교육비 공제가 가능한데, 이 때 거주의 판정시점은 12.31일 현재이므로
						12.31일 이전에 형제자매의 주민등록을 옮기면 공제 가능함. </td>
				</tr>
				<tr>
					<td valign="top"><font color="#0033CC">- 사례 1 : 주민등록이 따로 되어 있는 처제의 대학등록금에 대한 교육비 공제를 받고자 하는 경우 공제 가능 여부</font><br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;→ 근로자의 주민등록지에서 현실적으로 생계를 같이 해야 하므로 12.31일 이전에 주소지를 옮기면<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;공제 가능함.<br>
						<font color="#0033CC">- 사례 2 : 대학 등록금을 대주고 있는 동생(대학생)과 같이 거주하다가 동생이 지방대학에 입학한 후에 거주지를<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;학교 근처로 따로 옮긴 경우 공제 가능 여부</font><br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;→ 근로자 또는 동거가족이 취학, 질병의 요양, 근무상(사업상) 형편으로 주소를 일시 퇴거한 경우에도<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<u>“일시퇴거상황표(제반 서류 포함)”를 제출</u>하면 생계를 같이 하는 것으로 간주하여 공제 가능함.</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td><b><font color="#FF0000">▶ 배우자와 동반한 자녀가 해외 유학 중일 경우 세테크</font></b></td>
				</tr>
				<tr>
					<td valign="top"> 자녀 유학비 공제 대상은 원칙적으로 <u>중학교를 국내에서 졸업</u>한
						뒤 자비유학을 떠난 학생이어야 함. <br>
						그러나 예외로 교육장이나 국제교육진흥원장으로부터 유학 인정을 받은 유치원생, 초·중등학생이라면 유학비 공제 가능함.</td>
				</tr>
				<tr>
					<td valign="top"><font color="#0033CC"> 예외 대상자: ① 예체능계열 중학생으로 학교장의 추천을 받은 자<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;② 자연과학, 기술, 예능, 체육 분야의 “특별시·광역시·도” 규모 이상 대회에서 입상하여<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;교육인적자원부 장관이 인정한 자<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;③ 외국 정부가 인정한 기관이 선발한 장학생과 특수교육 대상자 등</font><br><br></td>
				</tr>
			</table>
</div>



<!-- 세액공제 -->
<div class=page id="tabYACA001_04" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
</div>


<!-- 제출증빙서류 -->
<div class=page id="tabYACA001_05" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
</div>


<!-- OX퀴즈 문제 -->
<div class=page id="tabYACA001_05" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
</div>


<!-- OX퀴즈 정답 -->
<div class=page id="tabYACA001_05" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
</div>


<div class=page id="tabYACA001_06" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
      <table width="597" border="0" cellspacing="0" cellpadding="0"  bgcolor="#F5FAFE">
        <tr>
          <td colspan="5" height="1">&nbsp;</td>
        </tr>
        <tr>
          <td width="15" height="20">&nbsp;</td>
          <td  width="189" valign="top">
            <table width="189" border="0" cellspacing="0" cellpadding="0">
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b>총 급 여 액<br>
                          (급여총액+상여총액)</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( - )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b><a
                        href="javascript:onClick=fnc_LeftFlow(7,1);">근로소득공제</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( = )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32" valign="top">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b>근로소득금액</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( - )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,2);">인 적 공 제</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( - )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b>연금보험료공제</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( - )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,5);">특별 소득 공제</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( - )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,6);">기타 소득 공제</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( = )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b>과 세 표 준</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( X )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b>기 본 세 율</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( = )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b>산 출 세 액</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( - )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b><a href="javascript:onClick=fnc_LeftTwoFlow(8,1);">세액공제 및 감면</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( = )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b>결 정 세 액</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( - )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b>기 납 부 세 액</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( = )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b>납부 또는 환급세액</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="189"><img src="/images/common/arrow.gif" width="189" height="708"> </td>
          <td  valign="top">
            <table width="189" border="0" cellspacing="0" cellpadding="0">
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b>과세대상급여<br>
                          (총급여액-비과세소득)</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,2);">기 본 공 제<br>
                          (본인,배우자,부양가족)</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,3);">추 가 공 제<br>
                          (경로우대,장애인,부녀자...)</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,4);">다자녀 추가공제</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20">&nbsp;</td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,5);">보험료 공제</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,5);">의료비 공제</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,5);">교육비 공제</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,5);">주택자금 공제</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,5);">기부금 공제</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
					<br>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,6);">개인연금저축공제</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,7);">신용카드공제</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
			  <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,8);">소기업·소상공인 공제부금</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
			  <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,9);">장기주식형펀드소득공제</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,10);">투자조합출자공제</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,11);">우리사주조합출연금공제</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,12);">주택마련저축소득공제 </a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2">&nbsp;</td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div   align=center><b><a href="javascript:onClick=fnc_LeftTwoFlow(8,1);">근로소득세액공제</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftTwoFlow(8,2);">주택자금이자세액공제</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div   align=center><b><a href="javascript:onClick=fnc_LeftTwoFlow(8,4);">정치자금세액공제</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>

            </table>
          </td>
          <td width="15">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="5" height="15">&nbsp;</td>
        </tr>
      </table>
</div>
<!-- 올해 변경사항 -->
<div class=page id="tabYACA001_07" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
</div>
<!-- 소득공제 -->
<div class=page id="tabYACA001_08" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="130" valign="top" style="padding:7 0 0 0"><!--tab테이블시작 -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft01"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn01" onclick="fnc_ClickBtn(1)" style="cursor:hand;">
						근로소득공제
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight01"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft02"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn02" onclick="fnc_ClickBtn(2)" style="cursor:hand;">
						기본공제
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight02"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft03"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn03" onclick="fnc_ClickBtn(3)" style="cursor:hand;">
						추가공제
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight03"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft04"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn04" onclick="fnc_ClickBtn(4)" style="cursor:hand;">
						다자녀추가공제
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight04"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft05"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn05" onclick="fnc_ClickBtn(5)" style="cursor:hand;">
						특별공제
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight05"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft06"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn06" onclick="fnc_ClickBtn(6)" style="cursor:hand;">
						연금저축공제
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight06"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft07"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn07" onclick="fnc_ClickBtn(7)" style="cursor:hand;">
						신용카드사용공제
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight07"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft08"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn08" onclick="fnc_ClickBtn(8)" style="cursor:hand;">
						소기업·<br>소상공인공제
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight08"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft09"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn09" onclick="fnc_ClickBtn(9)" style="cursor:hand;">
						장기주식형펀드<br>소득공제
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight09"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft10"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn10" onclick="fnc_ClickBtn(10)" style="cursor:hand;">
						투자조합소득공제
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight10"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft11"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn11" onclick="fnc_ClickBtn(11)" style="cursor:hand;">
						우리사주조합출연금
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight11"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft12"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn12" onclick="fnc_ClickBtn(12)" style="cursor:hand;">
						주택마련<br>저축소득공제
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight12"></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>

		<!-- 오른쪽 Tab 나오는 부분 -->
		<td>
		<td valign="top"><!-- Layer 들 --> <!--탭의 프레임 시작 -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="5" height="5"><img
					src="/images/common/arcGray01.gif" width="5" height="5"></td>
				<td background="/images/common/arcGray02.gif"></td>
				<td width="5" background="/images/common/arcGray03.gif"></td>
			</tr>
			<tr>
				<td width="5" background="/images/common/arcGray04.gif"></td>
				<!-- 최소 높이가 350은 되어야합니다.높이 조절할필요 없습니다. 패팅이 먹혀 있기 때문에 -->
				<td height="360" valign="top" bgcolor="#FFFFFF" style="padding:15">


				<!-- 근로소득공제공제 -->
				<div id="layer_1" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
        <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;1. 근로소득공제</b></font><font face="휴먼각진그래픽" size="4" color="#333333"><b>
        <br>
        </b></font><font face="휴먼각진그래픽" color="#333333"><b><font face="굴림"><br>
        </font></b></font><font color="#333333" face="굴림"> &nbsp;&nbsp;&nbsp;&nbsp;<font color="#EA5200">▶
        근로소득공제는 모든 근로자에게 적용되며 연간급여액에 따라공제액이 달라집니다<b>.&nbsp;</b></font></font><font face="휴먼각진그래픽" size="2" color="#333333"><b><br>
        </b></font>
        <table width="603" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="264">
              <div align="center"><font color="#333333" face="굴림">급 &nbsp;&nbsp;여
                &nbsp;&nbsp;액</font> </div>
            </td>
            <td width="326" bgcolor="#FFF8EE">
              <div align="center"><font color="#333333" face="굴림">공 &nbsp;제 &nbsp;금 &nbsp;액</font>
              </div>
            </td>
          </tr>
          <tr>
            <td width="264" bgcolor="#FFFFFF">
              <div align="center"><font color="#333333" face="굴림">500만원이하</font>
              </div>
            </td>
            <td width="326" bgcolor="#FFFFFF">
              <div align="center"><font color="#333333" face="굴림">총급여액 X 80%</font></div>
            </td>
          </tr>
          <tr>
            <td width="264" bgcolor="#FFFFFF">
              <div align="center"><font color="#333333" face="굴림">500만원 ~ 1,500만원이하</font></div>
            </td>
            <td width="326" bgcolor="#FFFFFF">
              <div align="center"><font color="#333333" face="굴림">400만원 + (500만원
                초과액의 50%</font><font face="굴림">) </font></div>
            </td>
          </tr>
          <tr>
            <td width="264" bgcolor="#FFFFFF">
              <div align="center"><font color="#333333" face="굴림">1,500만원 ~ 3,000만원이하</font></div>
            </td>
            <td width="326" bgcolor="#FFFFFF">
              <div align="center"><font color="#333333" face="굴림">900만원 + (1,500만원
                초과액의 15%)</font></div>
            </td>
          </tr>
          <tr>
            <td width="264" bgcolor="#FFFFFF">
              <div align="center"><font color="#333333" face="굴림">3,000만원 ~ 4,500만원이하</font></div>
            </td>
            <td width="326" bgcolor="#FFFFFF">
              <div align="center"><font color="#333333" face="굴림">1,125만원 + (3,000만원
                초과액의 10%)</font></div>
            </td>
          </tr>
          <tr>
            <td width="264" bgcolor="#FFFFFF">
              <div align="center"><font face="굴림">4,500만원 초과</font></div>
            </td>
            <td width="326" bgcolor="#FFFFFF">
              <div align="center"><font face="굴림">1,275만원 + (4,500만원 초과액의 5%)</font></div>
            </td>
          </tr>
        </table>
        <br>
        <table width="600" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="#666666">
          <tr>
            <td height="44" width="606" bgcolor="#FFF8EE"><font color="#000000" face="굴림"><font color="#333333"><a name="#4"><b>근로소득의
              범위</b></a>는 ?<br>
              <br>
              &nbsp;&nbsp;&nbsp;아래의 사항에 해당되는 모든금액을 합산한 금액이 <b>연간 총 급여액</b>이 됩니다)
              </font></font></td>
          </tr>
          <tr>
            <td height="664" width="606" bgcolor="#FFF8EE"> <font color="#333333" face="굴림">&nbsp;<br>
              &nbsp;1) &nbsp;근로의 제공으로 인하여 받은 봉급, 급료, 보수, 임금, 상여, 수당 등<br>
              <br>
              &nbsp;&nbsp;2) &nbsp;잉여금 처분에 의한 상여<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;(주주총회 사원총회 또는 이에 준하는 의결기관의
              결의에 의하여 상여로 받는&nbsp;금액)<br>
              <br>
              &nbsp;&nbsp;3) &nbsp;근로수당, 가족수당, 전시수당, 물가수당, 출납수당, 직무수당 기타 이와 유사한
              성질의 급여<br>
              <br>
              &nbsp;&nbsp;4) &nbsp;근속수당, 명절휴가비, 연월차수당, 승무수당, 공무원의 연가보상비, 정근수당
              등<br>
              <br>
              &nbsp;&nbsp;5) &nbsp;보험, 증권회사 또는 금융기관이 내근사원에게 지급하는 집금수당과 보험가입자의
              모집,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;증권매매의 권유 또는 저축의 권장으로 인한 대가,
              기타 이와 유사한 성질의 급여<br>
              <br>
              &nbsp;&nbsp;6) &nbsp;시간외 근무수당, 통근수당, 개근수당, 특별공로금 기타 이와 유사한 성질의 급여<br>
              <br>
              &nbsp;&nbsp;7) &nbsp;출퇴근교통비 명목으로 지급하는 보조금, 체력단련비 명목으로 지급하는 금액<br>
              <br>
              </font> <font color="#333333" face="굴림">&nbsp;&nbsp;8) &nbsp;근로기준법
              제45조에 정한 휴업수당<br>
              <br>
              &nbsp;&nbsp;9) &nbsp;벽지수당, 해외근무수당 기타 이와 유사한 성질의 급여<br>
              <br>
              &nbsp;10) 기밀비, 판공비, 교제비 기타 이와 유사한 명목으로 지급한 것으로서 업무를 위하여 사용된 것이<br>
              &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;분명하지 아니한 급여<br>
              <br>
              &nbsp;11) 종업원에게 지급하는 공로금, 위로금, 개업축하금, 학자금, 장학금 기타 이와 유사한 성질의 급여<br>
              <br>
              &nbsp;12) 대학교 교직원의 자녀가 당해 교직원의 제직사실에 기하여 대학교로부터 받는 장학금,학비면제<br>
              &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;액은 교직원의 근로소득에 해당합니다.<br>
              <br>
              &nbsp;13) 종업원의 수학중인 자녀가 사용자로부터 받는 학자금, 장학금을 포함합니다.<br>
              <br>
              &nbsp;14) 근로자가 기본급여 이외에 광고유치 또는 판매실적 등에 따라 사용자로부터 추가로 &nbsp;지급&nbsp;받는<br>
              &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;수당, 장려금 등은 근로소득에 해당합니다.<br>
              <br>
              &nbsp;15) 여비의 명목으로 지급되는 연액 또는 월액의 급여<br>
              <br>
              &nbsp;16) 퇴직으로 인하여 받는 소득으로서 퇴직 소득에 속하지 아니하는 퇴직위로금, 퇴직공로금기타<br>
              &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;이와 유사한 성질의 급여<br>
              <br>
              &nbsp;17) 퇴직위여지급규정에 의해 지급하더라도 재직시의 특별한 공로에 대한대가로 지급하는&nbsp;금액은<br>
              &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;근로소득에 해당합니다.<br>
              <br>
              &nbsp;18) 휴가비 기타 이와 유사한 성질의 급여<br>
              <br>
              &nbsp;19) 근로소득에 해당하는 급여를 현물로 지급받는 경우에는 그 지급당시의 시가에 의합니다.<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 사립학교 교직원의 자녀에 대한 등록금
              면제액<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 근로자가 부담하여야 할 소득세 등을
              사용자가 부담한 경우 그 소득세액<br>
              &nbsp;&nbsp;&nbsp;&nbsp;</font> <font color="#333333" face="굴림">&nbsp;&nbsp;-
              출자자 또는 출연자인 임원(상장법인 및 장외등록법인의 소액주주인 임원 제외)이 사택을 제공<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 받음으로써 얻는
              이익<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 종업원이 보험계약자이거나 종업원 또는
              그 배우자, 기타의 가족을 보험수익자로하는보험<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;또는 신탁과 관련하여
              보험료를 사용자가 부담하는것<br>
              <br>
              &nbsp;20) 임직원과 그 가족에게 지원되는 금강산 관광비용 회사부담액은 근로소득에 해당<br>
              <br>
              &nbsp;21) 법인의 출연으로 우리사주조합원이 배정받은 자사주<br>
              <br>
              &nbsp;22) 고용보험기금에서 지급받는 육아휴직위여 · 산전후휴가급여 (영수증상의 인정상여란 기재됨)<br>
              </font></td>
          </tr>
        </table>
				</div>
				<div id="layer_2" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        &nbsp; <font size="2" color="#333333"><b>2. 기본공제 (연령, 소득제한 있음)</b></font><font face="휴먼각진그래픽" size="4" color="#333333"><b><br>
        </b></font><font
 face="휴먼각진그래픽" size="4" color="fuchsia"><font size="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></font>
        <table width="600" border="0" cellspacing="1" cellpadding="2" bordercolor="#666666" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="83">
              <div align="center"><font face="굴림">기본공제내역</font></div>
            </td>
            <td colspan="2" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">공 제 대 상 내 역</font></div>
            </td>
            <td width="93">
              <div align="center"><font face="굴림">공제금액</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="83" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">본 인</font></div>
            </td>
            <td colspan="2"><font face="굴림">모든 근로자 <br>
              </font></td>
            <td width="93">
              <div align="center"><font face="굴림">150만원</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="83" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림"> 배우자공제</font></div>
            </td>
            <td colspan="2"><font face="굴림"> 소득금액이 없거나 자산소득(근로,퇴직,이자,배당,기타소득 등)을<br>
              포함한 연간 소득금액의 합계액이 100만원 이하인 자<br>
              </font></td>
            <td width="93">
              <div align="center"><font face="굴림"> 150만원</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td rowspan="6" width="83" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">부양가족 </font></div>
            </td>
            <td colspan="2"><font face="굴림">거주자(배우자 포함)의 부양가족(연령 계산시 초일산입)으로서<br>
              연간 소득금액의 합계액이 100만원 이하인 자<br>
              </font></td>
            <td rowspan="6" width="93">
              <div align="center"><font face="굴림">150만원 </font></div>
              <p align="center"><font face="굴림">(1인당)<br>
                </font></p>
            </td>
          </tr>
          <tr>
            <td width="65" bgcolor="#FFFFFF">
              <div align="center"><font face="굴림">자녀<br>
                </font></div>
            </td>
            <td width="359" bgcolor="#FFFFFF"><font face="굴림">만 20세 이하(1993.1.1
              이후 출생)<br>
              당해연도중에 만 20세에 도달하더라도 공제가능함</font></td>
          </tr>
          <tr>
            <td width="65" bgcolor="#FFFFFF">
              <div align="center"><font face="굴림">부모<br>
                </font></div>
            </td>
            <td width="359" bgcolor="#FFFFFF"><font face="굴림">남.여 모두: 만 60세 이상(1953.12.31 이전 출생) </font></td>
          </tr>
          <tr>
            <td width="65" bgcolor="#FFFFFF">
              <div align="center"><font face="굴림">형제자매<br>
                </font></div>
            </td>
            <td width="359" bgcolor="#FFFFFF"><font face="굴림">만 20세이하(1993.1.1
              이후 출생) 또는 <br>
              남/여 : 만 60세 이상 (1953.12.31 이전출생)</font></td>
          </tr>
          <tr>
            <td width="65" bgcolor="#FFFFFF">
              <div align="center"><font face="굴림">거택보호<br>
                대상자</font></div>
            </td>
            <td width="359" bgcolor="#FFFFFF"><font face="굴림">생활보호법시행령 제6조 제1호
              해당 자 : 연령제한 없음</font></td>
          </tr>
          <tr>
            <td width="65" bgcolor="#FFFFFF">
              <div align="center"><font face="굴림">장애자</font></div>
            </td>
            <td width="359" bgcolor="#FFFFFF"><font face="굴림">연령제한 없음</font></td>
          </tr>
        </table>
		 <div align="left">&nbsp;&nbsp;<br>
          <font color="#FF6600" face="굴림">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#EA5200">※
          공제가능 (2008.1.1 개정) - 장애인인 직계비속의 장애인 배우자 공제 허용</font></font><font color="#EA5200" face="굴림"></font><br>
          </div>
          <div align="left">&nbsp;&nbsp;<br>
          <font color="#FF6600" face="굴림">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#EA5200">※
          공제불능 - 연령, 소득 제한조건에 해당되지 않는자</font></font><font color="#EA5200" face="굴림"><br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-
          형제자매의 배우자<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-
          이종 형제, 고모, 이모, 삼촌, 외삼촌, 조카, 며느리 등<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-
          주민등록표상 비동거가족(단, 실제로 부양을 하고 있으나 주거 형편상 별거인 경우 가족관계증명서 첨부)</font><br>
          </div>
				</div>
				<div id="layer_3" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;<font face="굴림">3. 추가공제(<font color="#EA5200">우선
        기본공제</font></font></b></font><font face="굴림" size="2" color="#EA5200"><b>
        대상에 해당되어야 함<font color="#333333">)</font></b></font><font face="휴먼각진그래픽" size="4" color="#333333"><b><br>
        </b></font><font
 face="휴먼각진그래픽" size="4" color="fuchsia"><font size="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></font>
        <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="80">
              <div align="center"><font face="굴림">추가공제내역</font></div>
            </td>
            <td width="408" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">공 제 대 상 내 역</font></div>
            </td>
            <td width="86">
              <div align="center"><font face="굴림">공제금액</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="80" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">경로우대공제 </font></div>
            </td>
            <td width="408"><font face="굴림">근로자 본인 또는 생계를 같이하는 부양가족 (배우자 포함) 중
              <br><br>&nbsp;&nbsp;&nbsp; ① 만 70세 이상(1943.12.31 이전 출생)<br>&nbsp;
              </font></td>
            <td width="86" valign="top">
              <div align="center"><font face="굴림">
              	<br>100만원
              	<br>(1인당)
              	</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="80" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">장애자공제 </font></div>
            </td>
            <td width="408"><font face="굴림">근로자 본인 또는 생계를 같이하는 부양가족 중 장애자가 있는
              경우<br>
              <br>
              (장애자의 범위) <br>
              - 심신상실자와 정신지체자 <br>
              - 국가유공자 예우 등에 관한 법률에 의한 상이자 <br>
              - 청각장애자와 시각장애자 <br>
              - 군경의료규정(1979.8.29 대통령령 제9588호) 별표1에 규정한 상이군경<br>
              &nbsp;&nbsp;&nbsp;상이구분표의 1급 내지 3급에 기하는 상이자와 같은 정도의 신체장애가<br>
              &nbsp;&nbsp;&nbsp;있는 자 <br>
              - 지병에 의하여 평상시 치료를 요하는 자가 그 치료기간이 1년 이상<br>
              &nbsp;&nbsp;&nbsp;지속될 것이 예상되고 장애치료기간 동안에는 취학·취업이 곤란한 상태에<br>
              &nbsp;&nbsp;&nbsp;있는 자(말기 암, 만성 신부전증환자 등)
              <br>&nbsp;&nbsp;&nbsp;※ 의료기관 발행의 "장애인증명서" 첨부
              </font></td>
            <td  valign="middle" align="center">
              200만원<br>(1인당)
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="80" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">부녀자공제 </font></div>
            </td>
            <td width="408"><font face="굴림"> 배우자가 없는 여성근로자로서 연말 현재 기본공제 대상 부양가족이 있는 <br>
							세대주이거나, 배우자가 있는 여성근로자인 경우(남편 소득 유무 무시)<br>
              </font></td>
            <td width="86">
              <div align="center"><font face="굴림">50만원 <br>
                <br>
                </font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="80" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">자녀양육공제 <br>
                </font></div>
            </td>
            <td width="408" bgcolor="#FFFFFF"><font face="굴림">만6세 이하의 직계비속이 있는 경우 <br>만6세 이하의 위탁아동이 있는 경우 <br>
              (2006. 1. 1 이후 출생자녀) <br>
              </font></td>
            <td width="86">
              <div align="center"><font face="굴림">100만원<br>
                (1인당) <br>
                </font></div>
            </td>
          </tr>
		   <tr bgcolor="#FFFFFF">
            <td width="80" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">출산·입양공제<br>
                </font></div>
            </td>
            <td width="408" bgcolor="#FFFFFF"><font face="굴림">2012년 중 출산·입양한 경우
              </font></td>
            <td width="86">
              <div align="center"><font face="굴림">200만원<br>
                (1인당) <br>
                </font></div>
            </td>
          </tr>
        </table>
				</div>
				<div id="layer_4" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;4. 다자녀 추가공제</b></font><font face="휴먼각진그래픽" size="4" color="#333333"><b><br>
        <br>
        <font size="2">&nbsp;&nbsp;&nbsp;<font face="굴림" color="#EA5200">▶ 기본공제
        대상자</font></font></b><font size="2" face="굴림" color="#EA5200">(소득이 없는 만 20세 이하자)
        에 해당하는 자녀가 2인 이상인 경우에 추가공제 적용됨</font><font size="2">
        </font></font><font face="휴먼각진그래픽" size="4" color="fuchsia"><font size="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></font>
        <table width="600" border="0" cellspacing="1" cellpadding="2" bordercolor="#666666" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="303" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">기본공제 대상 자녀수</font></div>
            </td>
            <td width="316">
              <div align="center"><font face="굴림">공제 금액</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="303" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">2인</font></div>
            </td>
            <td width="316">
              <div align="center"><font face="굴림">연 100만원</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="303" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">3인 이상</font></div>
            </td>
            <td width="316">
              <div align="center"><font face="굴림">연 100만원 + (자녀수 - 2인) X 200만원</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td colspan="2">
              <div align="left"><font face="굴림">※ 참고</font></div>
              <p align="left"><font face="굴림">&nbsp;① 맞벌이 부부가 2명의 20세 미만의 자녀에 대해 각각 1명씩 기본공제를 받을 경우 다자녀 추가 공제를 받을<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;수 없음<br>
			  </font><font face="굴림">&nbsp;② 23세의 자녀가 장애인일 경우에도 장애인 자녀를 기본 공제 대상자로 신청한 경우 다자녀 추가 공제 대상
			  <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자녀에 해당함</font></p>
              </td>
          </tr>
        </table>
				</div>
				<div id="layer_5" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">

        <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b><font face="굴림">&nbsp;5. 특별공제</font></b></font><font face="휴먼각진그래픽" size="4" color="#333333"><b><br>
        <br>
        </b>
		<font size="2" face="휴먼각진그래픽" color="#0000FF">&nbsp;&nbsp;&nbsp;▶
		근로제공기간 동안에 지출한 보험료 등이 있는 경우에 적용합니다.(기부금 제외)</font><br>

		<font size="2">&nbsp;&nbsp;&nbsp;</font></font><font face="휴먼각진그래픽" color="#333333"><font face="굴림" color="#EA5200">▶
        기본공제대상자(본인,배우자,부양가족)를 위한 비용(보험료,의료비,교육비)을 지출하거나, 본인이<br>
        &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;지출한 기부금,주택자금이
        있는 경우 소득금액에서 지출액중 일정한금액을 공제해 주는 것입니다.</font></font>
        <div align="left"><font face="굴림" color="#EA5200">&nbsp;&nbsp;&nbsp;&nbsp;▶
		표준공제 = 특별공제신청을 하지 않았거나 또는 신청했으나 합계액이 100만원 미만인 때에는 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;개별증빙없이
          표준공제 100만원 적용</font><font size="2"><br>
          <br>
          </font><b><font face="굴림">&nbsp;&nbsp;
          <a name="a12_5_1">
          5.1 보험료공제</a></font></b>
          : <b><font face="굴림">고용보험료+의료보험료+노인장기요양보험료+기타보장성보험료+국민연금</font></b>
          <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <b><font color="EA5200"> (공제 대상자 연령, 소득 제한 있음)</font></b>
          <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
            <tr bgcolor="#FFF8EE">
              <td width="115">
                <div align="center"><font face="굴림">구 분</font></div>
              </td>
              <td width="360">
                <div align="center"><font face="굴림">공 제 대 상 내 역</font></div>
              </td>
              <td width="109">
                <div align="center"><font face="굴림">공 제 금 액</font></div>
              </td>
            </tr>
			<tr bgcolor="#FFFFFF">
              <td width="115" bgcolor="#FFF8EE">
                <div align="center"><font face="굴림">전액공제보험료 </font></div>
              </td>
              <td width="360"><font face="굴림">급여에서 징수된 건강보험,고용보험료,노인장기요양보험료 <br>
                </font></td>
              <td width="109">
                <div align="center"><font face="굴림">전 액 </font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="115" bgcolor="#FFF8EE">
                <div align="center"><font face="굴림">장애인전용보장성<br>
                  보험료 </font></div>
              </td>
              <td width="360"><font face="굴림">장애인에 한하여 가능(피보험자가 장애인일 경우)<br>
			  ☞ 보험료 납입증명서 상에 <b><u>"장애인 전용 보험 연간 합계액"</u></b>
			  <br>&nbsp;&nbsp;&nbsp;&nbsp;으로 표시된 금액<br>
                </font></td>
              <td width="109">
                <div align="center"><font face="굴림">100만원 한도</font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="115" bgcolor="#FFF8EE">
                <div align="center"><font face="굴림">일반보장성보험료 </font></div>
              </td>
              <td width="360"><font face="굴림">본인 및 가족명의의 생명보험, 상해보험, 자동차보험,<br>
                화재/도난 기타의 손해를 담보하는 가계 보험<br>
                <br>
                ☞ 보험료납입증명서상에 <b><u>"보장성 보험 연간합계액"</u></b> 으로 표시
				<br>&nbsp;&nbsp;&nbsp;&nbsp;된 금액<br>
                ☞<b><u> 보험계약자와 피보험자</u></b>가 기본공제를 받는 배우자, 부양가족
				<br>&nbsp;&nbsp;&nbsp;&nbsp;일 경우</font></td>
              <td width="109">
                <div align="center"><font face="굴림">100만원 한도 </font></div>
              </td>
            </tr>
          </table>
					<br>
          &nbsp;&nbsp;&nbsp;&nbsp;<font color="#7800BF" face="굴림">&nbsp;※ 장애자
          전용 보장성 보험료공제와 일반 보장성 보험료공제가 동시에 해당되는 경우에는 둘중 하나만 선택<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;하여야 함.</font><br>
          <br>
          <br>
          <b><font face="굴림">&nbsp;&nbsp;
          <a name="a12_5_2">
          5.2 의료비공제</a></font></b>
          <b><font color="EA5200"> (공제 대상자 연령, 소득 제한 없음)</font></b>
          <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
            <tr bgcolor="#FFF8EE">
              <td colspan="2">
                <div align="center"><font face="굴림">공 제 대 상 범 위</font></div>
              </td>
              <td width="132">
                <div align="center"><font face="굴림">공 제 금 액</font></div>
              </td>
              <td width="227">
                <div align="center"><font face="굴림">추 가 공 제</font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td colspan="2" bgcolor="#FFF8EE"><font face="굴림">본인 및 기본공제대상자를
                위해 지출한<br>
                의료비로 총급여액의 3%를 초과하는 금액 <br>
                </font></td>
              <td width="132">
                <div align="center"><font face="굴림">700만원<br>
                  한도</font></div>
              </td>
              <td width="227"><font face="굴림">본인, 장애자, 경로우대자의 의료비는 500만원을
                초과하여 공제받지 못한 금액과 비교하여
                적은 금액을 추가로 공제 </font></td>
            </tr>
          </table>
					<br>
          &nbsp;&nbsp;<font color="#7800BF" face="굴림">&nbsp;&nbsp;※ 의료비 범위<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;① 진찰·진료·질병예방을 위한 의료기관 지출액<br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;② 치료·요양을 위한 의약품(한약)구입비<br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;③ 장애인 보장구 구입·임차비용<br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;④ 의사 등의 처방에 따른 의료기기 구입·임차 비용<br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;⑤ 시력보정용 안경·콘텍트렌즈 구입비(기본공제 대상자 1인당 50만원 한도)<br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;⑥ 보청기 구입비<br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;⑦ 노인장기요양보험법 제40조 제1항에 따라 실제 지급한 본인일부부담금</font><br><br>
          &nbsp;&nbsp;<font color="#7800BF" face="굴림">&nbsp;&nbsp;※ 대표적인 공제불능<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 다른 가족의 기본공제 대상자에 대한 의료비,생계를 같이 하지 않는 직계존속에 대한 의료비<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 의료기관이 아닌 산후조리원비, 장애인 재활치료 사설학원비, 응급환자 이송업체 구급차 이용비,<br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;국외 지출 의료비, 사내 근로 복지기금 지원 의료비 등</font><br>
          <br>
          <br>
          <b><font face="굴림">&nbsp;&nbsp;
          <a name="a12_5_3">
          5.3 교육비공제</a></font></b>
          <b><font color="EA5200"> (공제 대상자 소득 제한 있음)</font></b>
          <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
            <tr bgcolor="#FFF8EE">
              <td colspan="2">
                <div align="center"><font face="굴림">공 제 대 상 교 육 비</font></div>
              </td>
              <td width="292">
                <div align="center"><font face="굴림">공 제 범 위</font></div>
              </td>
              <td width="120">
                <div align="center"><font face="굴림">공 제 금 액</font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td colspan="2" bgcolor="#FFF8EE">
                <div align="center"><font face="굴림">본 인 </font></div>
              </td>
              <td width="292"><font face="굴림">본인의 초,중,고,대학,대학원의 공납금<br>
                </font></td>
              <td width="120">
                <div align="center"><font face="굴림">전 액 공 제 </font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="52" rowspan="3" bgcolor="#FFF8EE">
                <div align="center"><font face="굴림">배우자 </font>
                  <p><font face="굴림">부양</font></p>
                  <p><font face="굴림">가족 <br>
                    </font></p>
                </div>
              </td>
              <td bgcolor="#FFF8EE" width="115">
                <div align="center"><font face="굴림">유치원아,영유아,<br>
                  취학전아동 </font></div>
              </td>
              <td width="292" bgcolor="#FFFFFF"><font face="굴림">국,공,사립유치원아 공납금,
                취학전아동(만6세미만)<br>
                보육비용 및 학원수강료로 지출한 금액<br>
				(2007년부터 체육시설 이용료 포함)
                </font></td>
              <td width="120" bgcolor="#FFFFFF">
                <div align="center"><font face="굴림">1인당 <br>
                  300만원 </font></div>
              </td>
            </tr>
            <tr>
              <td width="115" bgcolor="#FFF8EE">
                <div align="center"><font face="굴림">초,중,고등학교 </font></div>
              </td>
              <td width="292" bgcolor="#FFFFFF"><font face="굴림">기본공제 대상자로 초,중,
                고의 공납금, 급식비, <br>방과 후 학교수업료, 교과서 구입비<br>
                </font></td>
              <td width="120" bgcolor="#FFFFFF">
                <div align="center"><font face="굴림">1인당<br>
                  300만원 </font></div>
              </td>
            </tr>
            <tr>
              <td bgcolor="#FFF8EE" width="115">
                <div align="center"><font face="굴림">대학생 </font></div>
              </td>
              <td width="292" bgcolor="#FFFFFF"><font face="굴림">기본공제 대상자로 대학의
                공납금<br>
                </font></td>
              <td width="120" bgcolor="#FFFFFF">
                <div align="center"><font face="굴림">1인당 <br>
                  900만원 </font></div>
              </td>
            </tr>
			<tr>
				<td bgcolor="#FFF8EE" colspan="2"><div align="center">국외 교육비</div>
				</td>
				<td bgcolor="#FFFFFF" colspan="2">① 국외 근무자 = 국외에서 함께 동거하는 자에 대한 교육비<br>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(영유아·취학전 아동 교육비용 제외)<br>
				② 국내 근무자 = 자비유학 자격자(중학교 졸업 이상자)·유학특례적용자<br>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(부양의무자와 국외에서 1년이상 동거한 자)에 대한 교육비

				</td>
			</tr>
          </table>
					<br>
          &nbsp;&nbsp;<font color="#7800BF" face="굴림">&nbsp;&nbsp;※ 참고<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-장애인 특수교육비 1인당 전액공제<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-사이버대학 포함</font><br><br>
          &nbsp;&nbsp;<font color="#7800BF" face="굴림">&nbsp;&nbsp;※ 대표적인 공제불능<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 직계존속의 교육비, 소득금액 100만원 초과자의 교육비, 다른 가족의 기본 공제 대상자인 자에 대한 교육비 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 초, 중, 고, 대학생의 사설학원 수강료 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 외부 강사에 의한 실기 지도비, 국외 보육시설·학원 및 체육시설 이용료 등<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 학교 버스
          이용료, 자녀 대학원 수업료, 기숙사비, 교과서를 제외한 책값 등<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 각종 학습지(구몬, 눈높이,
          영어교실 등), 짐보리 등<br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 장학금</font><br>
          <br>
          &nbsp;&nbsp;&nbsp;<font color="#9900FF">&nbsp;&nbsp;&lt;학원 범위&gt;<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- '학원의 설립, 운영에 관한 법률'에 의한<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 미술, 음악, 영어,
          바둑, 웅변, 서예, 무용 등 유아를 대상으로 하는 학원</font><br>
          <br>
		  &nbsp;&nbsp;&nbsp;<font color="#9900FF">&nbsp;&nbsp;&lt;체육시설 범위&gt;<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- '체육시설의 설치·이용에 관한 법률'에 의한 체육도장(국선도장·단학장 등 포함)·수영장 등</font><br>

          <br>
		  &nbsp;&nbsp;&nbsp;<font color="#9900FF">&nbsp;&nbsp;&lt;교육비 차감액&gt;<br>

          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 근로복지기본법에 따른 사내근로복지기금으로부터 받은 장학금 등 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 재학 중인 학교로부터 받은 장학금 등 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 근로자인 학생이 직장으로부터 받은 장학금 등 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 국외근무공무원에게 지급되는 자녀 등에 대한 장학금 등 <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 그밖에 각종 단체로부터 받은 장학금 등</font><br><br>

          <b><font face="굴림">&nbsp;&nbsp;
          <a name="a12_5_4">
          5.4 기부금공제</a></font></b><font face="굴림">
          :<b> 법정기부금+특례기부금+지정기부금지급액<br>
          &nbsp;&nbsp;&nbsp;</b><font color="#EA5200">&nbsp;▶ 근로소득자 본인,배우자,직계비속만 공제 가능</font></font><br>
          <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
            <tr bgcolor="#FFF8EE">
              <td width="110">
                <div align="center"><font face="굴림">구 분</font></div>
              </td>
              <td width="354">
                <div align="center"><font face="굴림">공 제 대 상 내 역</font></div>
              </td>
              <td width="120">
                <div align="center"><font face="굴림">공 제 금 액</font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="110" bgcolor="#FFF8EE">
                <div align="center"><font face="굴림">법정<br>
                  기부금 </font></div>
              </td>
              <td width="354"><font face="굴림">- 국가 또는 지방자치단체에 기부한 금품 등<br>
                - 무료 또는 실비로 이용할수 있는 사회복지시설에 기부한 금품<br>
                - 불우이웃돕기 결연기관을 통하여 기부한 금품<br>
                - 사립학교, 기능대학,국립대학교 병원,서울대학교 병원에<br>
                &nbsp;&nbsp; 기부한 시설비,교육비 또는 연구비(사립학교-장학금 포함)<br>
                - 사회복지공동 모금회에 지출한 기부금 <br>
                - 특별재해(재난)지역의 자원봉사 용역
                <br>- <u>10만원 초과액 전액공제</u>)
                </font></td>
              <td width="120">
                <div align="center"><font face="굴림">전 액 </font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="110" bgcolor="#FFF8EE">
                <div align="center"><font face="굴림">지정기부금 </font></div>
              </td>
              <td width="354"><font face="굴림">사회복지법인, 학교, 학술연구단체, 장학단체, 문화예술단체,<br>
                주무 관청에 등록된 종교단체, 대한적십자사, 불우이웃돕기,<br>
                노동조합비, 교원단체회비등 <br>
                </font></td>
              <td width="120">
                <div align="center"><font face="굴림">*한도액<br>
				1. 종교단체기부금이 있는 경우<br>
				한도액=소득금액x10%+Min[소득금액x10%, 종교단체 외 지정기부금]<br>
				2. 종교단체기부금이 없는 경우<br>
				한도액=소득금액x20%<br><br>
				*공제액=Min[지정기부금 해당액, 한도액]</font></div>
              </td>
            </tr>
          </table>
					<br>
          <font color="#7800BF" face="굴림">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;※
          기부자 성명, 금액, 목적, 지급일, 발행자 사업자 등록번호, 서명날인 기재된 증명서 제출</font><br>
          <font face="굴림"><br>
          <br>
          <b>&nbsp;&nbsp;
          <a name="a12_5_5">
          5.5 주택자금공제</a></b><br>
          &nbsp;&nbsp;&nbsp;<font color="#EA5200">&nbsp;▶ 근로소득자 본인명의만 공제 가능<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(개인별 대출/저축의 상품종류가 다양하기 때문에
          아래 내용 이외의 소득공제 대상 여부는 직접 은행에 확인 바람)<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#7800BF">※ "기준시가 3억원 이하" 규정은 2006.1.1 이후 저축가입자와
          차입자만 해당됨.</font></font>
          <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
            <tr bgcolor="#FFF8EE">
              <td width="110">
                <div align="center"><font face="굴림">구 분</font></div>
              </td>
              <td width="358">
                <div align="center"><font face="굴림">공 제 대 상 범 위</font></div>
              </td>
              <td width="116">
                <div align="center"><font face="굴림">공 제 금 액</font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="110" bgcolor="#FFF8EE">
                <div align="center"><font face="굴림">월세액</font></div>
              </td>
              <td width="358"><font face="굴림">1. 12.31. 현재 주택을 소유하지 아니한 법소정 세대의 세대주 일 것<br>
					2. 해당 과세기간의 총급여 액이 5,000만 원이하인 사람일 것<br>
					3. 배우자 또는 기본공제대상 부양가종이 있는 사람일 것<br>
					4. 국민주택규모의 주택을 임차하기 위한 것일 것<br>
					5. 다음의 요건을 모두 충족하는 월세액일 것<br>
					&nbsp;&nbsp;- 월세액 외에 보증금 등을 지급한 경우 임대차계약증서에<br>&nbsp;&nbsp;&nbsp;&nbsp;확정일자를 받을 것<br>
					&nbsp;&nbsp;- 임대차계약증서의 주소지와 주민등록 등본의 주소지가 같을 것
              </font></td>
              <td rowspan="3" width="116">
                <div align="center"><font face="굴림">주택임차관련<br>
                자금 소득공제액<br><br>
				= (주택임차차입금<br>원리금 상환액<br>&nbsp;+ 월세액)x40%<br><br>
				(300만원 한도)
                  <br>
                  </font>

                </div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="110" bgcolor="#FFF8EE">
                <div align="center"><font face="굴림">대부업 등을 경영하지 아니하는 거주자로부터 차입한 주택임차 원리금 상환액 </font></div>
              </td>
              <td width="358"><font face="굴림">1. 과세기간 종료일 현재 주택을 소유하지 아니한 법소정 세대의 세대주 일 것<br>
				2. 법소정 국민주택규모의 주택을 임차하기 위한 것일 것<br>
				3. 해당 과세기간의 총급여액이 5,000만 원이하인 사람으로서 배우자나 기본공제대상 부양가족이 있는 사람이 대부업등의등록및금융이용자보호에관한법률 제2조에 따른 대부업 등을 경영하지 아니하는 거주자로부터 차입한 주택임차자금일 것
</font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="110" bgcolor="#FFF8EE">
                <div align="center"><font face="굴림">주택임차차입금 <br>
                  원리금상환액 <br>
                  공제</font></div>
              </td>
              <td width="358"><font face="굴림">연말 현재 세대주이고 무주택자인 근로자 본인이 기준시가 <br>
                3억 이하 국민주택규모의 주택을 임차하기 위해 <u>주택마련저축과<br>
                연계하여</u> 당해저축기관에 차입한 차입금의 원리금 상환액<br>
                <font color="#EA5200">(폐지된 청약부금과 연계한 차입금은 공제 받을 수 없음)<br>※ 2008.1.1 이후에는 연계제외</font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="110" bgcolor="#FFF8EE">
                <div align="center"><font face="굴림">장기주택저당차입금 이자상환액 공제</font></div>
              </td>
              <td width="358"><font face="굴림">1. 과세기간 종료일 현재 법소정 세대의 세대주 또는 법소정 세대원인 근로자(일용근로자 제외) <br>
2. 세대구성원이 보유한 주택을 포함하여 다음에 해당되지 않을 것 <br>
-과세기간 종료일 현재 2주택 이상을 보유하는 경우 <br>
-해당 과세기간에 2주택 이상을 보유하는 경우 <br>
3. 1., 2. 의 무주택 세대주 등이 국민주택규모의 주택으로서 취득당시 기준시가가 3억 원 이하인 주택을 취득하기 위하여 금융회사 등 또는 국민주택기금으로부터 차입한 다음의 요건을 모두 충족하는 장기주택저당차입금 일 것
-차입금의 상환기간이 15년 이상일 것 <br>
-주택소유권이전등기 또는 보존등기일부터 3월 이내에 차입한 장기주택저당차입금일 것 <br>
-장기주택저당차입금의 채무자가 해당 저당권이 설정된 주택의 소유자 일 것
</font></td>
              <td align=center> 주택자금 공제액=
Min(장기주택저당차입금이자상환액+Min(주택마련저축소득공제액+주택임차차입금 관련 공제액),300만 원),1,000만원(600 or 1,500만원))

              </td>
            </tr>
          </table>
		  </div>

				</div>
				<div id="layer_6" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;6. 개인연금 저축공제</b></font><font size="4" color="#333333"><b><font size="2"><br>
        <font face="Geneva, Arial, Helvetica, san-serif" color="#EA5200"><br>
        </font></font></b><font size="2" face="Geneva, Arial, Helvetica, san-serif" color="#EA5200">&nbsp;&nbsp;&nbsp;</font></font><font color="#333333"><font face="Geneva, Arial, Helvetica, san-serif" color="#EA5200">▶
        근로소득자 본인명의로 가입한 경우에만 공제가 가능합니다.</font></font>
        <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="198" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">공 제 대 상 내 역</font></div>
            </td>
            <td width="146">
              <div align="center"><font face="굴림">공제구분</font></div>
            </td>
            <td width="130" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">공 제 금 액</font></div>
            </td>
            <td width="105">
              <div align="center"><font face="굴림">공 제 한 도</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="198" bgcolor="#FFF8EE" rowspan="2">
              <div align="left"><font face="굴림">- 만20세 이상 가입자 <br>
                - 매월100만원범위내 불입액<br>
                - 저축기간10년이상<br>
                &nbsp;&nbsp;( 만 55세이후부터 5년이상<br>
                &nbsp;&nbsp;&nbsp; 연금형태로 지급받는저축)</font></div>
            </td>
            <td height="19" width="146" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">2000.12.31이전 가입자</font></div>
            </td>
            <td width="130" height="19">
              <div align="center"><font face="굴림">연간불입액의40%</font></div>
            </td>
            <td height="19" width="105">
              <div align="center"><font face="굴림">72만원한도 </font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="146" bgcolor="#FFF8EE" height="15">
              <div align="center"><font face="굴림">2001.01.01이후 가입자</font></div>
            </td>
            <td width="130" height="15">
              <div align="center"><font face="굴림">연간불입액 전액<br>(퇴직연금보험료<br>포함)</font></div>
            </td>
            <td height="15" width="105">
              <div align="center"><font face="굴림">400만원한도</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td colspan="4"><font face="굴림" color="#EA5200">☞ 보장성 보험료와 연금저축은 납입증명서상에
              같이 나타나니 구별해서 기재해 주세요.</font></td>
          </tr>
        </table>
				<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


				</div>
				<div id="layer_7" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;7. 신용카드 사용공제</b></font><font size="4" color="#333333"><b><font size="2"><br>
        <font color="#EA5200"><br>
        </font></font></b><font size="2" color="#EA5200">&nbsp;&nbsp;&nbsp;</font></font><font color="#EA5200"><font face="굴림">▶
        </font></font><font face="굴림" color="#EA5200">근로소득자 또는 연소득 100만원 이하인 배우자, 부양가족이 전년12월∼당해연도 11월까지 사용한<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;금액이 연간 총급여액의
        20％를 초과하는 경우 그 초과금액의 20％를 공제하는 것입니다.</font><br>
        <table width="600" border="0" cellspacing="1" cellpadding="3" height="181" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td bgcolor="#FFF8EE" width="80">
              <div align="center"><font face="굴림">구 분</font></div>
              </td>
            <td width="520">
              <div align="center"><font face="굴림">내 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;역</font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td bgcolor="#FFF8EE">
	              <div align="center"><font face="굴림">사용기간</font></div>
	            </td>
              <td><font face="굴림">당해년도 1월1일~당해년도 12월31일까지 사용분 </font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
	  					<td bgcolor="#FFF8EE">
	              <div align="center"><font face="굴림">소득공제액<br> 계산 </font></div>
	            </td>
	  					<td bgcolor="#FFFFFF">
								1. [신용카드/현금영수증 총사용금액 - (총급여액 X 25%)] X 20%<br>
								2. [직불(체크)카드/선불카드  총사용금액 - (총급여액 X 25%)] X 30%<br>
								3. [전통시장 총사용금액 - (총급여액 X 25%)] X 30% (기업형 슈퍼마켓은 제외)
	            </td>
            </tr>
            <tr bgcolor="#FFFFFF">

            <td bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">공제한도</font></div>
              </td>
              <td><font face="굴림">300만원과 총급여의 20% 중 적은 금액<br>
								전통시장사용분 : 추가 100만원
              </font></td>
            </tr>
            <tr bgcolor="#FFFFFF">

            <td bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">공제대상금액 </font></div>
              </td>
              <td>본인,배우자,부양가족이 사용한 금액(국내) <br>
                - 신용카드, 직불카드, 백화점카드 등<br>
                - 지로납부 학원 수강료<br>
                - 현금영수증 사용금액
							</td>
            </tr>
            <tr bgcolor="#FFFFFF">

            <td bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">공제제외액 </font></div>
              </td>
              <td>
				- 접대비 등 회사 업무경비<br>
                - 각종보험료(연금보험료,의료보험료), 각종교육비(수업료,입학금,보육비용)<br>
                - 국세,지방세,전기료,수도료 등 <br>
                - 국외 사용 금액<br>
                - 형제자매의 사용금액<br>
                - 주소지가 다른 20세 초과 자녀의 사용금액 등
								</td>
            </tr>
            <tr bgcolor="#FFFFFF">

            <td bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">제출서류 </font></div>
              </td>
              <td ><font face="굴림">신용카드소득공제신청서,신용카드사용금액확인서, 현금영수증 사용금액 확인서 </font></td>
             </tr>
          </table>
					<br>
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <font color="#7800BF" face="굴림">※ 현금영수증 사용금액 확인서는<br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;국세청 현금영수증 홈페이지(<a href="http://www.taxsave.go.kr" target="_blank">www.taxsave.go.kr</a>)에서 회원가입 후 본인이 직접 발급 받음.</font>
				</div>
				<div id="layer_8" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;8. 소기업·소상공인공제</b></font><font size="4" color="#333333"><b><font size="2"><br>
        <font color="#EA5200"><br>
        </font></font></b><font size="2" color="#EA5200">&nbsp;&nbsp;&nbsp;</font></font><font color="#EA5200"><font face="굴림">▶
        </font></font><font face="굴림" color="#EA5200">근로자 본인이 입사 전 또는 이전에 소기업,소상공인 공제에 가입하여 2012년 12월 31일까지 납부하는<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;공제부금 공제(연 300만원 한도)</font><br>
				</div>
				<div id="layer_9" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;9. 장기 주식형 펀드 소득공제</b></font><font size="4" color="#333333"><b><font size="2"><br>
        <font color="#EA5200"><br>
        </font></font></b><font size="2" color="#EA5200">&nbsp;&nbsp;&nbsp;</font></font><font color="#EA5200"><font face="굴림">▶
        </font></font><font face="굴림" color="#EA5200">2008년 10월 20일 이후 장기주식형 펀드(적립식)에 가입한 경우 또는 이미 가입한 펀드의 기존계약을 3년이상<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;연장하고 기존계약을 갱신한 경우 공제</font><br><br>
		<font color="#EA5200">
        </font></font></b><font size="2" color="#EA5200">&nbsp;&nbsp;</font></font><font color="#EA5200"><font face="굴림">▶
        </font></font><font face="굴림" color="#EA5200">분기별 300만원 한도, 연 1200만원 한도<br><br>&nbsp;&nbsp;&nbsp;▶
        							2010.1.1.이후 가입자는 소득공제 대상 제외</font>
				</div>
				<div id="layer_10" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;<font face="굴림">10. 투자조합소득공제</font></b></font><br>
        <br>
        <font size="4" color="#333333"><font size="2">&nbsp;&nbsp;&nbsp;</font></font><font color="#333333"><font face="굴림" color="#EA5200">&nbsp;▶
        </font></font><font face="굴림" color="#EA5200">근로소득자 본인 명의만 가능</font><br>
        <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="324" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">공 제 대 상 내 역</font></div>
            </td>
            <td width="261">
              <div align="center"><font face="굴림">공 제 금 액</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="324"><font face="굴림">- 거주자가 창업투자조합 또는 신기술사업투자조합에 <br>
              &nbsp;&nbsp; 출자하는 경우 <br>
              <br>
              - 벤처기업증권투자신탁의 수익증권에 투자하는 경우 <br>
              <br>
              - "벤처기업육성에 관한 특별조치법"에 의한 개인투자<br>
              &nbsp;&nbsp;조합이 거주자로부터 출자받은 금액을 벤처기업에<br>
              &nbsp;&nbsp;투자하는 경우 <br>
              <br>
              - "벤처기업육성에 관한 특별조치법"에 의하여 벤처기업에<br>
              &nbsp;&nbsp; 투자하는 경우 <br>
              </font></td>
            <td width="261" valign="top"><br><br><br>
			- 2012.1.1 이전 투자(출자액) X 10%<br>
			&nbsp;&nbsp;&nbsp;2012.1.1 이후 투자(출자액) X 20%<br><br>
             - 근로소득금액 X 40% 한도<br></font></td>
          </tr>
        </table>
				</div>
				<div id="layer_11" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;<font face="굴림">11. 우리사주조합 출연금 소득공제</font></b></font><br>
        <br>
        <font size="4" color="#333333"><font size="2">&nbsp;&nbsp;&nbsp;</font></font><font color="#333333"><font face="굴림" color="#EA5200">&nbsp;▶
        </font></font><font face="굴림" color="#EA5200">근로소득자 본인 명의만 가능</font><br>
        <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="324" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">공 제 대 상 내 역</font></div>
            </td>
            <td width="261">
              <div align="center"><font face="굴림">공 제 금 액</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td>
              근로자 복지 기본법에 의한 우리사주조합원이 자사주를
              <br>취득하기 위하여 우리사주조합에 출연하는 경우
            </td>
            <td align="center">
              당해 년도의 출연금액
              <br>(400만원 한도)
            </td>
          </tr>
        </table>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <font color="#7800BF" face="굴림">
        ※ 소득공제 혜택을 받은 금액에 대하여 차후 구좌 인출시 근로소득 과세함. (과세이연)</font>
				</div>
				<div id="layer_12" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;<font face="굴림">12. 주택마련저축소득공제 </font></b></font><br>
        <br>
        <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="385" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">공 제 대 상 내 역</font></div>
            </td>
            <td width="200">
              <div align="center"><font face="굴림">공 제 금 액</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td>
              주택마련저축* 불입액의 40% 공제
              <br>- 무주택 세대의 세대주
              <br>-국민주택규모의 주택(가입당시 기준시가 3억 원 이하)을 한 채만<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소유한 세대의 세대주(2009.12.31. 이전 가입만 해당)
              <br>* 주택마련저축
              <br>ㆍ주택법에 의한 청약저축(월 납입액 10만 원 이하)
              <br>ㆍ장기주택마련저축(2009.12.31.이전 가입)
              <br>ㆍ주택청약종합저축(월 납입액 10만 원 이하)
            </td>
            <td align="center">
              <br>연 300만원 한도
            </td>
          </tr>
        </table>

				</div>
				</td>
				<td width="5" background="/images/common/arcGray05.gif"></td>
			</tr>
			<tr>
				<td height="5" background="/images/common/arcGray06.gif"></td>
				<td background="/images/common/arcGray07.gif"></td>
				<td background="/images/common/arcGray08.gif"></td>
			</tr>
		</table>
		<!--탭의 프레임 끝 --> <!-- Layer 들 -->
		</td>
	</tr>
</table>
</div>
<!-- 세액공제 -->
<div class=page id="tabYACA001_09" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="130" valign="top" style="padding:7 0 0 0"><!--tab테이블시작 -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTwoTabLeft01"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTwoTabBtn01" onclick="fnc_ClickBtnTwo(1)" style="cursor:hand;">
						근로소득세액공제
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTwoTabRight01"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTwoTabLeft02"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTwoTabBtn02" onclick="fnc_ClickBtnTwo(2)" style="cursor:hand;">
						주택자금<br>이자세액공제
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTwoTabRight02"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTwoTabLeft03"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTwoTabBtn03" onclick="fnc_ClickBtnTwo(3)" style="cursor:hand;">
						외국납부세액공제
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTwoTabRight03"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTwoTabLeft04"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTwoTabBtn04" onclick="fnc_ClickBtnTwo(4)" style="cursor:hand;">
						정치자금세액공제
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTwoTabRight04"></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>

		<!-- 오른쪽 Tab 나오는 부분 -->
		<td>
		<td valign="top"><!-- Layer 들 --> <!--탭의 프레임 시작 -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="5" height="5"><img
					src="/images/common/arcGray01.gif" width="5" height="5"></td>
				<td background="/images/common/arcGray02.gif"></td>
				<td width="5" background="/images/common/arcGray03.gif"></td>
			</tr>
			<tr>
				<td width="5" background="/images/common/arcGray04.gif"></td>
				<!-- 최소 높이가 350은 되어야합니다.높이 조절할필요 없습니다. 패팅이 먹혀 있기 때문에 -->
				<td height="360" valign="top" bgcolor="#FFFFFF" style="padding:15">


				<!-- 근로소득공제공제 -->
				<div id="layerTwo_1" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;1. 근로소득세액공제</b></font><font face="휴먼각진그래픽" size="4" color="#333333"></font><font
 face="휴먼각진그래픽" size="4" color="fuchsia"><font size="3"><br>
        <br>
        </font></font><font color="#333333" size="2"> </font>
        <table width="600" border="0" cellspacing="1" cellpadding="3" height="124" bordercolor="#666666" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="162">
              <div align="center"><font face="굴림">공제대상자 </font></div>
            </td>
            <td width="324">
              <div align="center"><font face="굴림">공제 방법 </font></div>
            </td>
            <td width="98">
              <div align="center"><font face="굴림">공제 한도 </font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td height="78" width="162" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">근로소득이 있는 모든 근로자 </font></div>
            </td>
            <td height="78" width="324"><font face="굴림">근로소득에 대한 산출세액이<br>
              <br>
              ① 50만원이하 : 산출세액 × 55% <br>
              <br>
              ② 50만원초과: 275,000 + (50만원 초과금액 × 30%) </font></td>
            <td height="78" width="98">
              <div align="center"><font face="굴림">50만원</font></div>
            </td>
          </tr>
        </table>
				</div>


				<div id="layerTwo_2" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b><font size="2" color="#333333"><b>&nbsp;2.
        주택자금 차입금 이자 세액공제</b></font><font
 face="휴먼각진그래픽" size="4" color="fuchsia"><font size="3"><br>
        </font></font></b><font
 face="휴먼각진그래픽" size="4" color="fuchsia"><font size="3"><font color="#FF6600"><br>
        </font></font></font><font size="4" color="#FF6600"><font size="3"><font size="2">&nbsp;&nbsp;&nbsp;</font></font></font></font><font color="#333333"><font color="#FF6600"><font face="굴림">&nbsp;<font color="#EA5200">
        ▶  1998.12.28 조세감면 규제법 폐지시 삭제되어 1999.1.1이후 차입한 경우 공제대상이 아님</font></font></font></font><font size="2" color="#333333"><b><font
 face="휴먼각진그래픽" size="4" color="fuchsia"><font size="3"><br>
        </font></font> </b></font>
        <table width="600" border="0" cellspacing="1" cellpadding="2" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="473">
              <div align="center"><font face="굴림">공 제 대 상 (① ② ③ 조건을 모두충족) </font></div>
              </td>

            <td width="116">
              <div align="center"><font face="굴림">공 제 액 </font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="473">
                <div align="left"><font face="굴림">① 근로소득자 본인이 무주택 또는 1주택만을 소유하는
                  세대주일것 </font></div>
                <p align="left"><font face="굴림"> ② 1995.11.1~ 1997. 12. 31 기간 중 "구조세감면규제법 제 67조의 2의 규정"에 의한
                	<br>&nbsp;&nbsp;&nbsp;&nbsp;미분양주택을 취득
                  <br>&nbsp;&nbsp;&nbsp;&nbsp;▶ 국민주택규모 이하의 주택으로서&nbsp; 서울특별시 외의 지역에
                  소재하는 것 취득<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;▶ 1995.10.31일 현재 시·군·구청장이 미분양주택임을 확인한 것<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;▶ 1997.12.31까지 매매계약을 체결하고 계약금을 납부한 경우 포함<br>
				  &nbsp;&nbsp;&nbsp;&nbsp;▶ 주택건설업자로 부터 최초로 분양받은 주택으로서 당해 주택이 완공된 후 다른<br>
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자가 입주한 사실이 없는 주택일 것<br>
                  </font></p>
                <p align="left"><font face="굴림"> ③ 당해 주택의 취득과 관련하여 1995.11.1이후
                  차입한 차입금에 대한 이자 상환액일 것 </font></p>
              </td>
              <td width="116">
                <div align="center"><font face="굴림">이자상환액의 30% </font></div>
              </td>
            </tr>
          </table>
				</div>


				<div id="layerTwo_3" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;3. 외국납부 세액공제</b></font><font
 face="휴먼각진그래픽" size="4" color="fuchsia"><font size="3"><br>
        <br>
        </font></font>
        <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="255">
              <div align="center"><font face="굴림">공 제 대 상</font></div>
              </td>

            <td width="183">
              <div align="center"><font face="굴림">공 제 액</font></div>
              </td>

            <td width="171">
              <div align="center"><font face="굴림">공 제 한 도 액</font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="255">
                <div align="left"><font face="굴림">국외에서 근로를 제공하고 받은 국외근로<br>
                  소득에 대하여 외국에서 납부하였거나<br>
                  납부할 소득세액이 있는 경우 공제 </font></div>
              </td>
              <td width="183">
                <div align="center"><font face="굴림">외국에서 납부하였거나<br>
                  납부할 세액 </font></div>
              </td>
              <td width="171">
                <div align="center"><font face="굴림">근로소득 산출세액<br>
                  ×<br>
                  국외근로소득<br>
                  ÷<br>
                  근로소득금액 </font></div>
              </td>
            </tr>
          </table>
				</div>
				<div id="layerTwo_4" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;4. 정치자금세액공제</b></font><font face="휴먼각진그래픽" size="4" color="#333333"></font><font
 face="휴먼각진그래픽" size="4" color="fuchsia"><font size="3"><br>
        <br>
        </font></font><font color="#333333" size="2"> </font>
				<font color="#EA5200">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				▶  근로소득자 본인명의만 공제 가능<br></font>
        <table width="600" border="0" cellspacing="1" cellpadding="3" height="124" bordercolor="#666666" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="162">
              <div align="center"><font face="굴림">공제대상자 </font></div>
            </td>
            <td width="324">
              <div align="center"><font face="굴림">공제 방법 </font></div>
            </td>
            <td width="98">
              <div align="center"><font face="굴림">공제 한도 </font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td height="78" width="162" bgcolor="#FFF8EE">
              <div align="center"><font face="굴림">정당(후원회 및
              선거관리위원회 포함)에
              정치자금을 기부한 근로자</font></div>
            </td>
            <td height="78" width="324">
							<u>10만원까지 세액공제</u> + 10만원 초과액 소득공제<br><br>
							<font color="#0000FF">* 기부금 X 100 / 110</font><br><br>
							예) 10만원 기부<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소득세 90,909 + 주민세 9,091 = 100,000 공제
            </td>
            <td height="78" width="98">
              <div align="center"><font face="굴림">10만원<br>(주민세 포함)</font></div>
            </td>
          </tr>
        </table>
				</div>

				</td>
				<td width="5" background="/images/common/arcGray05.gif"></td>
			</tr>
			<tr>
				<td height="5" background="/images/common/arcGray06.gif"></td>
				<td background="/images/common/arcGray07.gif"></td>
				<td background="/images/common/arcGray08.gif"></td>
			</tr>
		</table>
		<!--탭의 프레임 끝 --> <!-- Layer 들 -->
		</td>
	</tr>
</table>
</div>
<div class=page id="tabYACA001_10" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
			<table width="710" border="0" cellspacing="1" cellpadding="4">
				<tr>
					<td colspan="3" height="30"><b><font color="#0033CC">▶ 증빙서류 제출 안내</font></b></td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2"><font color="#0033CC">1. 증빙서류의 발생기간</font></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td>① <u>일반 재직자: 당해 1월~12월</u>  ② 신규 입사자: 입사 후~12월  ③ 해외법인(국외소득자) 국내 귀임자: 귀임 후~12월<br>
						<font color="#FF6600">예외) 신용카드 사용금액 확인서, 의료비 증빙서류 : 당해 1.1 ~ 당해 12.31<br>
						</font>
					</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2"><font color="#0033CC">2. 모든 증빙서류는 “원본제출(Fax, Mail, 인터넷발급
						불가)“이 원칙이나, 아래 서류들은 인터넷 발급이 인정됩니다.</font></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td>① 주민등록등본·외국인등록사실증명  ② 보험료납입증명서  ③ 주택자금 관련 납입/상환 증명서 <br>
						④ (개인)연금저축 납입증명서  ⑤ 신용카드 및 현금영수증 사용금액 확인서⑥ 기부금납입증명서</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2"><font color="#0033CC">3. 근로자 본인 명의로 발급되어야 인정되는 증빙서류</font></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td>① 소득공제 : 주택자금, 개인연금, 연금저축, 투자조합출자, 우리사주<br>
						② 세액공제 : 주택자금차입이자, 기부정치자금</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2"> <font color="#FF0000">4. 국세청 홈페이지를 <a href="http://www.yesone.go.kr" target="_blank">(http://www.yesone.go.kr)</a> 이용하는 경우 반드시 <b><u>"소득공제 내역 집계표 및 각 공제 항목별 상세내역서"</u></b> 를 함께 제출 바랍니다.</font></td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2"> <font color="#0033CC">5. 신고서상 입력항목 순서대로 증빙서류를 정리하여 주시고,
						A5 크기보다 작은 영수증은 분실방지를 위하여 A4 이면지에 <br>
						&nbsp;&nbsp;&nbsp;&nbsp;부착하여 제출 바랍니다.</font></td>
				</tr>
			</table>
			<br>
			<table border="0" cellspacing="1" cellpadding="2" bgcolor="#999999" width="715">
				<tr align="center">
					<td colspan="2" height="20" bgcolor="F8F3DC"><b>구분</b></td>
					<td bgcolor="F8F3DC" width="165"><b>서류명</b></td>
					<td bgcolor="F8F3DC"><b>대상자 및 참고사항</b></td>
					<td bgcolor="F8F3DC" width="140"><b>발급처</b></td>
				</tr>
				<tr>
					<td colspan="2" align="center" height="20" bgcolor="F8F3DC">공통</td>
					<td bgcolor="#FFFFFF">소득공제신고서</td>
					<td bgcolor="#FFFFFF">전 직원</td>
					<td bgcolor="#FFFFFF">- 본인이 작성</td>
				</tr>
				<tr>
					<td colspan="2" align="center" bgcolor="F8F3DC">근무지변경</td>
					<td valign="top" bgcolor="#FFFFFF">
					전(종) 근무지<br>
						근로소득원천징수영수증 및<br>
						근로소득원천징수부</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10">-</td>
								<td>당해년도 중도입사자(경력입사) 및 그룹사 전입자</td>
							</tr>
							<tr>
								<td>-</td>
								<td>하사관급 이상 전역 입사자</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td><font color="#0033CC">
						* 직원이 육상과 해상간의 근무지 변경(전보)을 한 경우는
									<br>
									해당안됨.</font></td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF">- 전(종) 근무회사</td>
				</tr>
				<tr>
					<td rowspan="6" align="center" bgcolor="F8F3DC" width="20">
					인<br>
						적<br>
						소<br>
						득<br>
						공<br>
						제</td>
					<td rowspan="4" align="center" bgcolor="F8F3DC" width="40">
					부<br>
						양<br>
						가<br>
						족</td>
					<td bgcolor="#FFFFFF">주민등록등본</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10">-</td>
								<td>당해년도 신규 또는 경력 입사한 근로자</td>
							</tr>
							<tr>
								<td>-</td>
								<td>당해년도중 공제대상가족의 변동이 있는 근로자</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>(자녀출산 등)</td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF">- 구청 또는 동사무소</td>
				</tr>
				<tr>
					<td valign="top" bgcolor="#FFFFFF">가족관계증명서</td>
					<td valign="top" bgcolor="#FFFFFF">- 가족관계가 주민등록등본으로 확인되지 않는 경우<br>
					<font color="#0033CC">&nbsp;&nbsp;* 부양대상 직계존속이 주거를 함께 하지 않는 경우에 해당<br>
					&nbsp;&nbsp;&nbsp;됨</font></td>

					<td valign="top" bgcolor="#FFFFFF">- 구청 또는 동사무소</td>
				</tr>
				<tr>
					<td valign="top" bgcolor="#FFFFFF">일시퇴거자 동거가족상황표<br>
						<span class="tit_f10">(재학·요양·재직·사업자증명서 첨부)</span></td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10" valign="top">-</td>
								<td>형제자매가 취학, 질병의 요양, 근무상 또는 사업상의
									형편으로 일시퇴거하여 주민등록등본으로 확인되지 않는 경우</td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF">- 본인이 작성<br>* <A  href="/common/downloadFile.jsp?FILE_NAME=2007form.xls&FILE_URL=<%=fileDownLoadPath%>/2007form.xls"  target=_blank><font color="#FF0000">서식보기</font></a></td>
				</tr>
				<tr>
					<td valign="top" bgcolor="#FFFFFF">수급자증명서</td>
					<td valign="top" bgcolor="#FFFFFF">국민기초생활보장 수급자</td>
					<td valign="top" bgcolor="#FFFFFF">- 읍 ·면 ·동사무소</td>
				</tr>
				<tr>
					<td align="center" bgcolor="F8F3DC">
						장<br>애<br>인
					</td>
					<td valign="top" bgcolor="#FFFFFF">
						장애인증명서 또는<br>
						장애인등록증(수첩) 사본,<br>
						상이증명서
					</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10">-</td>
								<td>본인 또는 부양가족이</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>① 장애인복지법에 의한 장애인<br>
									② 상이자 및 항시 치료를 요하는 중증환자로서 근로능력<br>
									&nbsp;&nbsp;&nbsp;&nbsp;이 없는 자<br>
									<font color="#FF0000">* 중증환자의 경우 반드시 담당 의사의 서명이 들어간<br>
									&nbsp;&nbsp;"장애인 증명서" 첨부해야 함<br>
									&nbsp;&nbsp;(건강보험공단 증명서로 대체 불가능함)</font></td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF">
					- 의료기관 또는<br>
						&nbsp;&nbsp;읍 ·면 ·동사무소</td>
				</tr>
				<tr>
					<td align="center" bgcolor="F8F3DC">부녀자</td>
					<td valign="top" bgcolor="#FFFFFF">가족관계증명서</td>
					<td valign="top" bgcolor="#FFFFFF">- 당해년도 12월말 기준으로 혼인신고를 한 여성근로자</td>
					<td valign="top" bgcolor="#FFFFFF">- 구청 또는 동사무소</td>
				</tr>
				<tr>
					<td colspan="2" align="center" bgcolor="F8F3DC">
					연금보험료<br>
						건강/고용<br>
						보험료 </td>
					<td valign="top" bgcolor="#FFFFFF"></td>
					<td bgcolor="#FFFFFF">- 본인부담 불입액에 대하여 회사에서 일괄처리함.
						<br>&nbsp;&nbsp;(전직장의 원천징수 영수증 및 징수부를 제출한 경우<br>
						&nbsp;&nbsp;&nbsp;&nbsp;불입액 합산됨.)</td>
					<td valign="top" bgcolor="#FFFFFF"></td>
				</tr>
				<tr>
					<td rowspan="5" align="center" bgcolor="F8F3DC">
						특<br>
						별<br>
						소<br>
						득<br>
						공<br>
						제
					</td>
					<td align="center" bgcolor="F8F3DC">보험료</td>
					<td bgcolor="#FFFFFF">보험료납입증명서(영수증)</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10" valign="top">-</td>
								<td>생명/상해/손해보험, 생명공제 등 보장성 보험의 보험료를 <br>
									납입한 근로자 </td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>→ 일반보험과 장애인전용보험 구분</td>
							</tr>
						</table>

					</td>
					<td valign="top" bgcolor="#FFFFFF">- 해당 금융기관<br>
					<A  href="/common/downloadFile.jsp?FILE_NAME=2010Iform01.doc&FILE_URL=<%=fileDownLoadPath%>/2010Iform01.doc"  target=_blank><font color="#FF0000">서식보기</font></a></td>
				</tr>
				<tr>
					<td align="center" bgcolor="F8F3DC">의료비</td>
					<td valign="top" bgcolor="#FFFFFF">
					의료비지급명세서 및<br>
						법정의료비영수증,<br>
						장애인 보장구 등<br>
						구입영수증</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10"><font color="#FF6600">-</font></td>
								<td colspan="3"><font color="#FF6600">연간 의료비를 총급여액의 3% 초과하여
									지출한 근로자</font></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td width="10">①</td>
								<td colspan="2">미초과시 제출할 필요없음.</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>②</td>
								<td colspan="2">일반가족의료비와 본인·경로자·장애인의료비구분해야함</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top"><font color="#FF6600">③</font></td>
								<td colspan="2"><font color="#FF6600">2004년 연말정산부터 의료비영수증에
									대한 인정요건이 강화되어 간이영수증 인정안됨.</font></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td valign="top">*</td>
								<td>의료비,약제비: 진료비(약제비) 연간 납입확인서</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><font color="#0033CC">→ &quot;현금지급액, 신용카드결재, 현금영수증 사용액&quot;<br>
									&nbsp;&nbsp;&nbsp; 으로 구분 기재한 것</font></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td valign="top">*</td>
								<td>보청기(장애인 보장구) 구입비용: 구입 영수증</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><font color="#0033CC">→ 판매자가 &quot;사용자의 성명&quot;을 확인 기재한 것</font></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td valign="top">*</td>
								<td>안경(렌즈) 구입비용: 구입 영수증</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><font color="#0033CC">→ 안경사가 &quot;사용자의 성명&quot; 및 &quot;시력교정용&quot;임을
									<br>
									&nbsp;&nbsp;&nbsp; 확인 기재한 것</font></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td valign="top">*</td>
								<td>의료용구 구입(임차)비용: 의사 처방전과 의료비영수증</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><font color="#0033CC">→ 판매자(임대인)이 발행하고 &quot;의료 용구명&quot;이
									<br>
									&nbsp;&nbsp;&nbsp; 기재된 것</font></td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF">
					- 의료기관, 약국, 안경점,<br>
						&nbsp;&nbsp;장애인 보장구 및<br>
						&nbsp;&nbsp;의료용구 판매처<br><br>
					- 국민건강보험공단<br>
					&nbsp;&nbsp;<a href="http://www.nhic.or.kr" target="_blank">(www.nhic.or.kr)</a>
					<br>
					<a  href="/common/downloadFile.jsp?FILE_NAME=2010Iform02.doc&FILE_URL=<%=fileDownLoadPath%>/2010Iform02.doc"  target=_blank><font color="#FF0000">서식보기</font></a></td>
				</tr>
				<tr>
					<td align="center" bgcolor="F8F3DC">교육비</td>
					<td valign="top" bgcolor="#FFFFFF">
					보육비용납입영수증,<br>
						학원교육비납입영수증,<br>
						공납금납입영수증,<br>
						교육비납입증명서</td>
					<td valign="top" bgcolor="#FFFFFF"> - 자녀, 배우자, 형제자매가 유치원 ·보육시설 및 초·중·고·
						<br>&nbsp;&nbsp;대학에 재학중인 근로자 (장애인특수/재활 교육 포함)<br>
						- 취학전 아동이 사설학원 및 체육시설에 수강하는 근로자 <br>
						- 근로자 본인이 대학·대학원에 재학 중인 자(직업능력 개발<br>
						&nbsp;&nbsp;비 포함)<br>
					<td valign="top" bgcolor="#FFFFFF">- 보육기관 및 학교·학원					<br>
					<a  href="/common/downloadFile.jsp?FILE_NAME=2010Iform03.doc&FILE_URL=<%=fileDownLoadPath%>/2010Iform03.doc"  target=_blank><font color="#FF0000">서식보기</font></a></td>
				</tr>
				<tr>
					<td align="center" bgcolor="F8F3DC">
					주<br>
						택<br>
						자<br>
						금</td>
					<td valign="top" bgcolor="#FFFFFF"> 주민등록등본(세대주 증명)<br>
						및 주택마련저축납입증명서,<br>
						주택자금상환증명서,<br>
						<span class="tit_f10">장기주택저당차입금이자상환증명서,</span><br>
						<font color="#0033CC">(취득주택 건물 등기부등본 및 2006.1.1 이후 차입금의 경우 주택기준시가 입증서류 첨부)
						<br><br><br><br><br><br><br>
						※ 기준시가 3억원 이하 규정은 2006.1.1 이후 저축가입자 및 차입자만 해당됨.</font>
					</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10">-</td>
								<td colspan="2">주택마련저축</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top" width="10">①</td>
								<td>무주택자 또는 기준시가 3억원 이하 국민주택규모의 1주택 소유자로서 세대주인 근로자 본인명의로</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top">②</td>
								<td>청약저축(월 불입액 10만원 이하인 것), 근로자주택마련저축, 장기주택마련저축(분기 불입액 	300만원 이하인 것)에 월불입하는 경우</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><font color="#0033CC">* 예외 : 청약부금, 일시예치식 청약예금, 대출용<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;주택부금(주택은행)</font>
								</td>
							</tr>
							<tr>
								<td>-</td>
								<td colspan="2">주택임차차입금 원리금 상환</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>①</td>
								<td>세대주인 근로자 본인명의로 </td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top">②</td>
								<td>위의 주택마련저축과 연계하여 기준시가 3억원 이하 국민주택규모의 주택을 임차하기 위해 차입한 금액을 상환하는 경우(2008.1.1이후 연계제외)</td>
							</tr>
							<tr>
								<td>-</td>
								<td colspan="2">장기주택저당차입금 이자상환 (모기지론)</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>①</td>
								<td>세대주인 근로자 본인명의로 </td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top">②</td>
								<td>기준시가 3억원 이하 국민주택규모의 주택을 취득하기 위하여 주택에 그 저당권을 설정하고 금융기관·국민주택기금으로부터 차입한 금액의 이자상환하는 경우 <br>
								(단, 본인명의의 주택에 본인명의로 저당권 설정 / 상환기간 15년 이상) </td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top"><font color="#0033CC">*</font></td>
								<td><font color="#0033CC">상환증명서 외에 장기주택저당차입금 대상이 되는 주택의 등기부등본 및 가격입증서류를 첨부해야 함</font></td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF">
					- 해당 금융기관, <br>
						&nbsp;&nbsp;읍 ·면 ·동사무소, 등기소<br><br>
					- 건교부 부동산 공시<br>
					&nbsp;&nbsp;가격 알리미<br>
					&nbsp;<a href="http://www.realtyprice.or.kr" target="_blank">(www.realtyprice.or.kr)</a>
					<br>서식보기<br>
					<a  href="/common/downloadFile.jsp?FILE_NAME=2010Iform04.doc&FILE_URL=<%=fileDownLoadPath%>/2010Iform04.doc"  target=_blank><font color="#FF0000">주택자금상환증명서</font></a>
					<br>
					<a  href="/common/downloadFile.jsp?FILE_NAME=2010Iform05.doc&FILE_URL=<%=fileDownLoadPath%>/2010Iform05.doc"  target=_blank><font color="#FF0000">장기주택저당차입금이자상환증명서</font></a></td>
				</tr>
				<tr>
					<td align="center" bgcolor="F8F3DC">기부금</td>
					<td valign="top" bgcolor="#FFFFFF">
					기부금지급명세서 및<br>
						법정기부금영수증,<br>
						주무관청 등록서류</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10">-</td>
								<td colspan="2">근로자 본인명의로 지출한 기부금이 있는 경우</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top">①</td>
								<td>법정기부금(전액공제): 국가·지방자치단체 기부금, 국방<br>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;헌금 등</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top">②</td>
								<td>지정기부금(20%한도적용공제): 종교단체 기부금, 불우<br>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;이웃돕기 등<br>
								※ 종교단체 기부금 (10% 한도공제 적용)</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><font color="#0033CC">* 종교단체의 경우 기부영수증 외에 그 총회 또는 중앙회 등이 주무관청에
									등록되었음을 입증 하는 증빙서류 첨부해야 함</font></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top"><font color="#FF6600">③</font></td>
								<td><font color="#FF6600">2004년 연말정산부터 기부금영수증에 대한 인정요건이 강화되어
									신설한 &quot;별지 제45호의 2 서식&quot;에 의한 법정영수증만 인정됨.</font></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><font color="#0033CC">* 정치자금 기부금은 정치관련 법령에서 정하는 별도의 영수증이 있음.</font></td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF">- 기부금 접수기관<br>
					<a  href="/common/downloadFile.jsp?FILE_NAME=2010Iform06.doc&FILE_URL=<%=fileDownLoadPath%>/2010Iform06.doc"  target=_blank><font color="#FF0000">서식보기</font></a></td>
				</tr>
				<tr>
					<td rowspan="5" align="center" bgcolor="F8F3DC">
					조<br>
						세<br>
						특<br>
						례<br>
						제<br>
						한<br>
						법<br>
						상<br>
						소<br>
						득<br>
						공<br>
						제</td>
					<td align="center" bgcolor="F8F3DC">(개인)<br>
						연금</td>
					<td valign="top" bgcolor="#FFFFFF">(개인)연금저축납입증명서</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10" valign="top">-</td>
								<td>근로자 본인명의로 개인연금 (2000.12.31 이전 가입분) 또는 연금저축(2001.1.1 이후 가입분)에 가입하고 월불입액을 납입한 경우</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td><font color="#FF6600">* 회사에서 단체가입한 (개인)연금저축에 대한 증빙서류는
									<br> &nbsp;&nbsp; 제출하지 않음.</font></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td class="tit_f10">&nbsp;&nbsp;&nbsp;<font color="#FF6600">(대한생명 : 노후적립 55세
									개시 등 / 농협 : 트리플에이 등)</font></td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF">- 해당 금융기관</td>
				</tr>
				<tr>
					<td align="center" bgcolor="F8F3DC">
					     투자<br>
						조합<br>
						출자</td>
					<td valign="top" bgcolor="#FFFFFF">
					출자(투자)확인서,<br>
						출자등소득공제신청서</td>
					<td valign="top" bgcolor="#FFFFFF">
					- 근로자 본인명의로 투자조합 등에 직접 출자(투자)한 경우</td>
					<td valign="top" bgcolor="#FFFFFF">
					- 중소기업청 또는<br>
						&nbsp;&nbsp;투자 조합관리자</td>
				</tr>
				<tr>
					<td align="center" bgcolor="F8F3DC">
					     신<br>
						용<br>
						카<br>
						드</td>
					<td valign="top" bgcolor="#FFFFFF">
					신용카드 등 사용금액 확인서, <br>
						현금영수증 사용금액 확인서, <br>
						학원수강료 지로납부 확인서</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10" valign="top"><font color="#FF6600">-</font></td>
								<td colspan="2"><font color="#FF6600">연간 신용카드(현금영수증 포함)를 총급여액의
									25% 초과하여 지출한 근로자<br>
									연간 직불카드를 총급여의 25%초과하여 지출한 근로자</font></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>①</td>
								<td>미초과시 제출할 필요없음. </td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top">②</td>
								<td>본인과 생계를 같이하며 소득이 100만원 이하인 배우자 및 직계존비속이 사용한 카드(현금영수증 포함)금액 및 학원비 지로납부액이 있는 경우</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><font color="#FF6600">* 형제자매에 대한 사용금액은 제외됨.</font></td>
							</tr>
						</table>
						<br>
					</td>
					<td valign="top" bgcolor="#FFFFFF"> - 해당 카드회사 및 학원,<br>
						&nbsp;&nbsp;현금영수증 홈페이지</td>
				</tr>

				<tr>
					<td align="center" bgcolor="F8F3DC">
					
					     소기업<br>
						/<br>					     
						소상<br>
						공인<br>
						공제<br>
						부금

						</td>
					<td valign="top" bgcolor="#FFFFFF">
					공제부금납입증명서</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10" valign="top">-</td>
								<td colspan="2">근로자 본인이 입사전 또는 이전에 소기업·소상공인 공제에 가입하여 2012년 12월 31일까지 납부하는 공제부금</td>
							</tr>
						</table>
						<br>
					</td>
					<td valign="top" bgcolor="#FFFFFF"> - 중소기업중앙회</td>
				</tr>

				<tr>
					<td align="center" bgcolor="F8F3DC">
						장기<br>
						주식형<br>
						펀드<br>
						소득<br>
						공제<br>
					</td>
					<td valign="top" bgcolor="#FFFFFF">
				    장기주식형펀드<br>소득공제 확인서</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10" valign="top">-</td>
								<td colspan="2">2008년 10월 20일 이후 장기주식형펀드(적립식)에 가입한 경우<br>또는 이미 가입한 펀드의 기존 계약을 3년 이상 연장하고<br>계약을 갱신한 경우 불입액 공제</td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF"> - 해당 금융기관<br>
					2010.01.01. 이후 가입자는 해당 공제대상 제외</td>
				</tr>

				<tr>
					<td align="center" bgcolor="F8F3DC">
					세<br>
						액<br>
						공<br>
						제</td>
					<td align="center" bgcolor="F8F3DC">
					주<br>
						택<br>
						자<br>
						금<br>
					</td>
					<td valign="top" bgcolor="#FFFFFF"> 주택자금이자세액공제신청서 <br>
						<span class="tit_f10">(미분양주택확인서, <br>
						차입금이자상환증명서, <br>
						매매계약서, 등기부등본 첨부)</span></td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10" valign="top">-</td>
								<td>무주택 또는 1주택 소유자로서 세대주인 근로자 본인명의로
									‘95.11.1~‘97.12.31 기간 중 서울 외의 지역에 <u>미분양주택</u>을 취득·임차하기 위하여 받은
									대출액의 이자를 상환하는 경우</td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF"> - 지방자치단체·등기소,<br>
						&nbsp;&nbsp;해당 금융기관</td>
				</tr>
			</table>


</div>

</BODY>
</HTML>
