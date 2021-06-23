<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<html> 
<head> 
<title> 금강산관광   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
<script language="javascript">
 function savePds(val) {
     location.href="../center/download/download.jsp?file="+val;
 }
</script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
  	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td height="87" valign="top">
			<!-- top menu flash -->
              <script language="javascript">
                  show_flash_F("topFlash","<%=imageServer%>/tour_swf/topMenu1.swf?aaa=<%=aaa%>&bbb=<%=bbb%>","910","87","transparent","")
              </script>
            </td>
		</tr>
		<tr>
			<td height="165" valign="top">
				<!-- top flash -->
              <script language="javascript">
                  show_flash_F("topFlash13","<%=imageServer%>/tour_swf/topFlash13.swf","100%","165","transparent","")
              </script>
			</td>
		</tr>
		</table>		
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174"><!--  left menu --><img src="<%=imageServer%>/tour_img/leftMenu82.gif" width="174"></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/footer/tit_footer02.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">여행약관</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="24"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="19" class="bg_dblue" valign="top"><img src="<%=imageServer%>/tour_img/footer/txt_agreement01.gif" style="margin:4 0 0 12px;"></td></tr>
						<tr>
							<td style="padding:7 2 7 7px;">
								<div style="width:678px;height:274px;overflow:auto;" class="div06">
								<table width="640" cellpadding="0" cellspacing="1" border="0">
								<tr><td colspan="2"><strong>제 1 장 총 칙</strong></td></tr>
								<tr><td colspan="2">제1조(목적)</td></tr>
								<tr>
									<td colspan="2">이 약관은 현대아산(주)가 제공하는 웹서비스(<a href="http://www.hdasan.com" target="new">www.hdasan.com</a>/ <a href="http://www.mtKumgang.com" target="new">www.mtKumgang.com</a>)(이하 서비스라 합니다.)의 이용조건 및 절차에 관한 사항과 기타 필요한 사항을 규정함을 목적으로 합니다.</td>
								</tr>
								<tr><td colspan="2">제 2 조 (이용약관의 효력 및 변경)</td></tr>
								<tr valign="top">
									<td width="15">①</td>
									<td width="625">이 약관은 서비스 메뉴 및 회사에 게시하여 공시함으로써 효력이 발생합니다.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>회사는 합리적인 사유가 발생될 경우에는 이 약관을 변경할 수 있으며, 약관이 변경된 경우에는 지체 없이 이를 공시합니다.</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>회원제서비스 이용고객은 변경된 약관 사항에 동의하지 않으면 서비스 이용을 중단하고 이용계약을 해지할 수 있습니다. 변경된 약관의 효력발생일 이후의 계속적인 서비스 이용은 약관의 변경사항에 동의 한 것으로 간주합니다.</td>
								</tr>
								<tr><td colspan="2">제 3 조 (약관외 준칙)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>이 약관은 회사가 제공하는 개별서비스에 관한 이용안내(이하 서비스별 안내라 합니다)와 함께 적용합니다</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>이 약관에 명시되지 아니한 사항에 대해서는 관계법령 및 서비스별 안내의 취지에 따라 적용할 수 있습니다.</td>
								</tr>
								<tr><td colspan="2">제 4 조 (용어의 정의)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>이 약관에서 사용하는 용어의 정의는 다음과 같습니다. </td>
								</tr>
								<tr>
									<td></td>
									<td>1. '이용고객'이라 함은 회원제서비스를 이용하는 이용자를 말합니다. </td>
								</tr>
								<tr>
									<td></td>
									<td>2. '이용계약'이라 함은 서비스 이용과 관련하여 회사와 이용고객 간에 체결 하는 계약 말합니다.</td>
								</tr>
								<tr>
									<td></td>
									<td>3. '이용자번호(ID)'라 함은 이용고객의 식별과 이용고객의 서비스 이용을 위하여 이용고객이 선정하고 회사가 부여하는 문자와 숫자의 조합을 말합니다.</td>
								</tr>
								<tr>
									<td></td>
									<td>4. '비밀번호'라 함은 이용고객이 부여 받은 이용자번호와 일치된 이용고객 임을 확인하고 이용 고객의 권익보호를 위하여 이용고객이 선정한 문자와 숫자의 조합을 말합니다.</td>
								</tr>
								<tr>
									<td></td>
									<td>5. '단말기'라 함은 회사가 제공하는 서비스를 이용하기 위해 이용고객이 설치한 개인용 컴퓨터 및 모뎀 등을 말합니다.</td>
								</tr>
								<tr>
									<td></td>
									<td>6. '해지'라 함은 회사 또는 회원이 이용계약을 해약하는 것을 말합니다.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>이 약관에서 사용하는 용어의 정의는 제1항에서 정하는 것을 제외하고는 관계법령 및 서비스별 안내에서 정하는 바에 의합니다.</td>
								</tr>
								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>제 2 장 이용계약 체결</strong></td></tr>
								<tr><td colspan="2">제 5 조 (이용 계약의 성립)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>이용계약은 이용고객의 본 이용약관 내용에 대한 동의와 이용신청에 대하여 회사의 이용승낙으로 성립합니다.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>본 이용약관에 대한 동의는 이용신청 당시 해당 현대아산 웹의 '동의함' 버튼을 누름으로써 의사표시를 합니다.</td>
								</tr>
								<tr><td colspan="2">제 6 조 (서비스 이용 신청)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>회원으로 가입하여 본 서비스를 이용하고자 하는 이용고객은 회사에서 요청하는 제반정보(이름, 주민등록번호, 연락처 등)를 제공하여야 합니다.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>모든 회원은 반드시 회원 본인의 이름과 주민등록번호를 제공하여야만 서비스를 이용할 수 있으며, 실명으로 등록하지 않은 사용자는 일체의 권리를 주장할 수 없습니다.</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>회원가입은 반드시 실명으로만 가입할 수 있으며 회사는 실명확인조치를 할 수 있습니다.</td>
								</tr>
								<tr valign="top">
									<td>④</td>
									<td>타인의 명의(이름 및 주민등록번호)를 도용하여 이용신청을 한 회원의 모든 ID는 삭제되며, 관계법령에 따라 처벌을 받을 수 있습니다. </td>
								</tr>
								<tr valign="top">
									<td>⑤</td>
									<td>회사는 본 서비스를 이용하는 회원에 대하여 등급별로 구분하여 이용시간, 이용회수, 서비스 메뉴 등을 세분하여 이용에 차등을 둘 수 있습니다.</td>
								</tr>
								<tr><td colspan="2">제 7 조 (개인정보의 보호 및 사용) </td></tr>
								<tr>
									<td colspan="2">회사는 관계법령이 정하는 바에 따라 이용자 등록정보를 포함한 이용자의 개인정보를 보호하기 위해 노력합니다. 이용자 개인정보의 보호 및 사용에 대해서는 관련법령 및 회사의 개인정보 보호정책이 적용됩니다. 단, 회사의 공식사이트이외의 웹에서 링크된 사이트에서는 회사의 개인정보 보호정책이 적용되지 않습니다. 또한 회사는 이용자의 귀책사유로 인해 노출된 정보에 대해서 일체의 책임을 지지 않습니다..</td>
								</tr>
								<tr><td colspan="2">제 8 조 (이용 신청의 승낙과 제한) </td></tr>
								<tr valign="top">
									<td>①</td>
									<td>회사는 제 6조의 규정에 의한 이용신청고객에 대하여 업무 수행상 또는 기술상 지장이 없는 경우에 원칙적으로 접수순서에 따라 서비스 이용을 승낙합니다.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>회사는 아래사항에 해당하는 경우에 대해서 승낙하지 아니 합니다.<br>
									- 실명이 아니거나 타인의 명의를 이용하여 신청한 경우<br>
									- 이용계약 신청서의 내용을 허위로 기재한 경우<br>
									- 사회의 안녕과 질서, 미풍양속을 저해할 목적으로 신청한 경우<br>
									- 부정한 용도로 본 서비스를 이용하고자 하는 경우<br>
									- 영리를 추구할 목적으로 본 서비스를 이용하고자 하는 경우<br>
									- 기타 규정한 제반사항을 위반하며 신청하는 경우<br>
									- 본 서비스와 경쟁관계에 있는 이용자가 신청하는 경우<br>
									- 기타 규정한 제반사항을 위반하며 신청하는 경우 </td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>회사는 서비스 이용신청이 다음 각 호에 해당하는 경우에는 그 신청에 대하여 승낙 제한사유가 해소될 때까지 승낙을 유보할 수 있습니다.<br>
									- 회사가 설비의 여유가 없는 경우<br>
									- 회사의 기술상 지장이 있는 경우<br>
									- 기타 사유로 이용승낙이 곤란한 경우</td>
								</tr>
								<tr valign="top">
									<td>④</td>
									<td>회사는 이용신청고객이 관계법령에서 규정하는 미성년자일 경우에 서비스별 안내에서 정하는 바에 따라 승낙을 보류할 수 있습니다.</td>
								</tr>
								<tr><td colspan="2">제 9 조 (이용자ID 부여 및 변경 등)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>회사는 이용고객에 대하여 약관에 정하는 바에 따라 이용자 ID를 부여합니다.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>이용자ID는 원칙적으로 변경이 불가하며 부득이한 사유로 인하여 변경 하고자 하는 경우에는 해당 ID를 해지하고 재가입해야 합니다.</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>현대아산의 이용자ID는 이용자 본인의 동의하에 현대아산이 운영하는 자사 사이트의 회원ID와 연결될 수 있습니다.</td>
								</tr>
								<tr valign="top">
									<td>④</td>
									<td>이용자ID는 다음 각 호에 해당하는 경우에는 이용고객 또는 회사의 요청으로 변경할 수 있습니다.<br>
									- 이용자ID가 이용자의 전화번호 또는 주민등록번호 등으로 등록되어 사생활침해가 우려되는 경우<br>
									- 타인에게 혐오감을 주거나 미풍양속에 어긋나는 경우<br>
									- 기타 합리적인 사유가 있는 경우</td>
								</tr>
								<tr valign="top">
									<td>⑤</td>
									<td>서비스 이용자ID 및 비밀번호의 관리책임은 이용자에게 있습니다. 이를 소홀이 관리하여 발생하는 서비스 이용상의 손해 또는 제3자에 의한 부정이용 등에 대한 책임은 이용자에게 있으며 회사는 그에 대한 책임을 일체 지지 않습니다.</td>
								</tr>
								<tr valign="top">
									<td>⑥</td>
									<td>기타 이용자 개인정보 관리 및 변경 등에 관한 사항은 서비스별 안내에 정하는 바에 의합니다.</td>
								</tr>

								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>제 3 장 계약 당사자의 의무</strong></td></tr>
								<tr><td colspan="2">제 10 조 (회사의 의무)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>회사는 이용고객이 희망한 서비스 제공 개시일에 특별한 사정이 없는 한 서비스를 이용할 수 있도록 하여야 합니다.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>회사는 계속적이고 안정적인 서비스의 제공을 위하여 설비에 장애가 생기거나 멸실된 때에는 부득이한 사유가 없는 한 지체없이 이를 수리 또는 복구합니다.</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>회사는 개인정보 보호를 위해 보안시스템을 구축하며 개인정보 보호정책을 공시하고 준수합니다.</td>
								</tr>
								<!-- <tr valign="top">
									<td>④</td>
									<td>회사는 개인정보 보호를 위해 보안시스템을 구축하며 개인정보 보호정책을 공시하고 준수합니다.</td>
								</tr> -->
								<tr><td colspan="2">제 11 조 (이용자의 의무)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>이용자는 회원가입 신청 또는 회원정보 변경 시 실명으로 모든 사항을 사실에 근거하여 작성하여야 하며, 허위 또는 타인의 정보를 등록할 경우 일체의 권리를 주장할 수 없습니다.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>회원은 본 약관에서 규정하는 사항과 기타 회사가 정한 제반 규정, 공지사항 등 회사가 공지하는 사항 및 관계법령을 준수하여야 하며, 기타 회사의 업무에 방해가 되는 행위, 회사의 명예를 손상시키는 행위를 해서는 안됩니다.</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>회원은 주소, 연락처, 전자우편 주소 등 이용계약사항이 변경된 경우에 해당 절차를 거쳐 이를 회사에 즉시 알려야 합니다.</td>
								</tr>
								<tr valign="top">
									<td>④</td>
									<td>회사가 관계법령 및 '개인정보 보호정책'에 의거하여 그 책임을 지는 경우를 제외하고 회원에게 부여된 ID의 비밀번호 관리소홀, 부정사용에 의하여 발생하는 모든 결과에 대한 책임은 회원에게 있습니다.</td>
								</tr>
								<tr valign="top">
									<td>⑤</td>
									<td>회원은 회사의 사전 승낙 없이 서비스를 이용하여 영업활동을 할 수 없으며, 그 영업활동의 결과에 대해 회사는 책임을 지지 않습니다. 또한 회원은 이와 같은 영업활동으로 회사가 손해를 입은 경우, 회원은 회사에 대해 손해배상의무를 지며, 회사는 해당 회원에 대해 서비스 이용제한 및 적법한 절차를 거쳐 손해배상 등을 청구할 수 있습니다.</td>
								</tr>
								<tr valign="top">
									<td>⑥</td>
									<td>회원은 회사의 명시적 동의가 없는 한 서비스의 이용권한, 기타 이용계약상의 지위를 타인에게 양도, 증여할 수 없으며 이를 담보로 제공할 수 없습니다.</td>
								</tr>
								<tr valign="top">
									<td>⑦</td>
									<td>회원은 회사 및 제 3자의 지적 재산권을 침해해서는 안됩니다.</td>
								</tr>
								<tr valign="top">
									<td>⑧</td>
									<td>회원은 다음 각 호에 해당하는 행위를 하여서는 안되며, 해당 행위를 하는 경우에 회사는 회원의 서비스 이용제한 및 적법 조치를 포함한 제재를 가할 수 있습니다.<br>
									- 회원가입 신청 또는 회원정보 변경 시 허위내용을 등록하는 행위<br>
									- 다른 이용자의 ID, 비밀번호, 주민등록번호를 도용하는 행위<br>
									- 이용자 ID를 타인과 거래하는 행위<br>
									- 회사의 임직원 또는 관계자를 사칭하는 행위<br>
									- 회사로부터 특별한 권리를 부여받지 않고 회사의 클라이언트 프로그램을 변경하거나, 회사의 서버를 해킹하거나, 웹사이트 또는 게시된 정보의일부분 또는 전체를 임의로 변경하는 행위<br>
									- 서비스에 위해를 가하거나 고의로 방해하는 행위<br>
									- 본 서비스를 통해 얻은 정보를 회사의 사전 승낙 없이 서비스 이용 외의 목적으로 복제하거나, 이를 출판 및 방송 등에 사용하거나, 제 3자에게 제공하는 행위<br>
									- 공공질서 및 미풍양속에 위반되는 저속, 음란한 내용의 정보, 문장, 도형, 음향, 동영상을 전송, 게시, 전자우편 또는 기타의 방법으로 타인에게 유포하는 행위<br>
									- 모욕적이거나 개인신상에 대한 내용이어서 타인의 명예나 프라이버시를 침해할 수 있는 내용을 전송, 게시, 전자우편 또는 기타의 방법으로 타인에게 유포하는 행위<br>
									- 다른 이용자를 희롱 또는 위협하거나, 특정 이용자에게 지속적으로 고통 또는 불편을 주는 행위<br>
									- 회사의 승인을 받지 않고 다른 사용자의 개인정보를 수집 또는 저장하는 행위<br>
									- 범죄와 결부된다고 객관적으로 판단되는 행위<br>
									- 본 약관을 포함하여 기타 회사가 정한 제반 규정 또는 이용 조건을 위반하는 행위<br>
									- 기타 관계법령에 위배되는 행위</td>
								</tr>

								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>제 4 장 서비스의 이용</strong></td></tr>
								<tr><td colspan="2">제 12 조 (서비스 이용 시간)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>서비스 이용은 회사의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴, 1일 24시간 운영을 원칙으로 합니다. 단, 회사는 시스템 정기점검, 증설 또는 교체를 위해 회사가 정한 날이나 시간에 서비스를 일시중단할 수 있으며, 예정되어 있는 작업으로 인한 서비스 일시중단은 현대아산 웹을 통해 사전에 공지합니다.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>회사는 긴급한 시스템 점검, 증설 또는 교체 등 부득이한 사유로 인하여 예고없이 일시적으로 서비스를 중단할 수 있으며, 새로운 서비스로의 교체 등 회사가 적절하다고 판단하는 사유에 의하여 현재 제공되는 서비스를 완전히 중단할 수 있습니다.</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>회사는 국가비상사태, 정전, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 정상적인 서비스 제공이 불가능할 경우, 서비스의 전부 또는 일부를 제한하거나 중지할 수 있습니다. 다만 이 경우 그 사유 및 기간 등을 회원에게 사전 또는 사후에 공지합니다.</td>
								</tr>
								<tr valign="top">
									<td>④</td>
									<td>회사는 회사가 통제할 수 없는 사유로 인한 서비스중단의 경우(시스템관리자의 고의, 과실없는 디스크장애, 시스템다운 등)에 사전통지가 불가능하며 타인(PC통신회사, 기간통신사업자 등)의 고의,과실로 인한 시스템중단 등의 경우에는 통지하지 않습니다.</td>
								</tr>
								<tr valign="top">
									<td>⑤</td>
									<td>회사는 서비스를 특정범위로 분할하여 각 범위별로 이용가능시간을 별도로 지정할 수 있습니다. 다만 이 경우 그 내용을 공지합니다.</td>
								</tr>
								<tr><td colspan="2">제 13 조 (이용자ID 관리)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>이용자ID와 비밀번호에 관한 모든 관리책임은 회원에게 있습니다.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>회사는 이용자 ID에 의하여 제반 이용자 관리업무를 수행 하므로 회원이 이용자 ID를 변경하고자 하는 경우 회사가 인정할 만한 사유가 없는 한 이용자 ID의 변경을 제한할 수 있습니다.</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>이용고객이 등록한 이용자 ID 및 비밀번호에 의하여 발생되는 사용상의 과실 또는 제 3자에 의한 부정사용 등에 대한 모든 책임은 해당 이용고객에게 있습니다.</td>
								</tr>
								<tr><td colspan="2">제 14 조 (게시물의 관리)</td></tr>
								<tr>
									<td colspan="2">회사는 다음 각 호에 해당하는 게시물이나 자료를 사전통지 없이 삭제하거나 이동 또는 등록 거부를 할 수 있습니다.<br>
									- 다른 회원 또는 제 3자에게 심한 모욕을 주거나 명예를 손상시키는 내용인 경우<br>
									- 공공질서 및 미풍양속에 위반되는 내용을 유포하거나 링크시키는 경우<br>
									- 불법복제 또는 해킹을 조장하는 내용인 경우<br>
									- 영리를 목적으로 하는 광고일 경우<br>
									- 범죄와 결부된다고 객관적으로 인정되는 내용일 경우<br>
									- 다른 이용자 또는 제 3자의 저작권 등 기타 권리를 침해하는 내용인 경우<br>
									- 회사에서 규정한 게시물 원칙에 어긋나거나, 게시판 성격에 부합하지 않는 경우<br>
									- 기타 관계법령에 위배된다고 판단되는 경우</td>
								</tr>
								<tr><td colspan="2">제 15 조 (게시물에 대한 저작권)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>회원이 서비스 화면 내에 게시한 게시물의 저작권은 게시한 회원에게 귀속됩니다. 또한 회사는 게시자의 동의 없이 게시물을 상업적으로 이용할 수 없습니다. 다만 비영리 목적인 경우는 그러하지 아니하며, 또한 서비스내의 게재권을 갖습니다.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>회원은 서비스를 이용하여 취득한 정보를 임의 가공, 판매하는 행위 등 서비스에 게재된 자료를 상업적으로 사용할 수 없습니다.</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>회사는 회원이 게시하거나 등록하는 서비스 내의 내용물, 게시 내용에 대해 제 14조 각 호에 해당된다고 판단되는 경우 사전통지 없이 삭제하거나 이동 또는 등록 거부할 수 있습니다.</td>
								</tr>
								<tr><td colspan="2">제 16 조 (정보의 제공)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>회사는 회원에게 서비스 이용에 필요가 있다고 인정되는 각종 정보에 대해서 전자우편이나 서신우편 등의 방법으로 회원에게 제공할 수 있습니다.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>회사는 서비스 개선 및 회원 대상의 서비스 소개 등의 목적으로 회원의 동의 하에 추가적인 개인 정보를 요구할 수 있습니다.</td>
								</tr>
								<tr><td colspan="2">제 17 조 (광고게재 및 광고주와의 거래)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>회사가 회원에게 서비스를 제공할 수 있는 서비스 투자기반의 일부는 광고게재를 통한 수익으로부터 나옵니다. 회원은 서비스 이용시 노출되는 광고게재에 대해 동의합니다.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>회사는 서비스상에 게재되어 있거나 본 서비스를 통한 광고주의 판촉활동에 회원이 참여하거나 교신 또는 거래를 함으로써 발생하는 손실과 손해에 대해 책임을 지지 않습니다. </td>
								</tr>
								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>제 5 장 계약 해지 및 이용 제한</strong></td></tr>
								<tr><td colspan="2">제 18 조 (계약 변경 및 해지)</td></tr>
								<tr>
									<td colspan="2">회원이 이용계약을 해지하고자 하는 때에는 회원 본인이 현대아산 웹 내의 [도움말] 메뉴를 이용해 가입해지를 해야 합니다.</td>
								</tr>
								<tr><td colspan="2">제 19 조 (서비스 이용제한) </td></tr>
								<tr valign="top">
									<td>①</td>
									<td>회사는 회원이 서비스 이용내용에 있어서 본 약관 제 11조 내용을 위반하거나, 다음 각 호에 해당하는 경우 서비스 이용을 제한할 수 있습니다.<br>
									- 미풍양속을 저해하는 비속한 ID 및 별명 사용<br>
									- 타 이용자에게 심한 모욕을 주거나, 서비스 이용을 방해한 경우<br>
									- 기타 정상적인 서비스 운영에 방해가 될 경우<br>
									- 정보통신 윤리위원회 등 관련 공공기관의 시정 요구가 있는 경우<br>
									- 3개월 이상 서비스를 이용한 적이 없는 경우 </td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>상기 이용제한 규정에 따라 서비스를 이용하는 회원에게 서비스 이용에 대하여 별도 공지 없이 서비스 이용의 일시정지, 초기화, 이용계약 해지 등을 불량이용자 처리규정에 따라 취할 수 있습니다.</td>
								</tr>
								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>제 6 장 손해배상 및 기타사항</strong></td></tr>
								<tr><td colspan="2">제 20 조 (손해배상)</td></tr>
								<tr><td colspan="2">회사는 서비스에서 무료로 제공하는 서비스의 이용과 관련하여 개인정보보호정책에서 정하는 내용에 해당하지 않는 사항에 대하여는 어떠한 손해도 책임을 지지 않습니다.</td></tr>
								<tr><td colspan="2">제 21 조 (면책조항)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>회사는 천재지변, 전쟁 및 기타 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 대한 책임이 면제됩니다.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>회사는 기간통신 사업자가 전기통신 서비스를 중지하거나 정상적으로 제공하지 아니하여 손해가 발생한 경우 책임이 면제됩니다.</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>회사는 서비스용 설비의 보수, 교체, 정기점검, 공사 등 부득이한 사유로 발생한 손해에 대한 책임이 면제됩니다.</td>
								</tr>
								<tr valign="top">
									<td>④</td>
									<td>회사는 회원의 귀책사유로 인한 서비스 이용의 장애 또는 손해에 대하여 책임을 지지 않습니다.</td>
								</tr>
								<tr valign="top">
									<td>⑤</td>
									<td>회사는 이용자의 컴퓨터 오류에 의해 손해가 발생한 경우, 또는 회원이 신상정보 및 전자우편 주소를 부실하게 기재하여 손해가 발생한 경우 책임을 지지 않습니다.</td>
								</tr>
								<tr valign="top">
									<td>⑥</td>
									<td>회사는 회원이 서비스를 이용하여 기대하는 수익을 얻지 못하거나 상실한 것에 대하여 책임을 지지 않습니다.</td>
								</tr>
								<tr valign="top">
									<td>⑦</td>
									<td>회사는 회원이 서비스를 이용하면서 얻은 자료로 인한 손해에 대하여 책임을 지지 않습니다. 또한 회사는 회원이 서비스를 이용하며 타 회원으로 인해 입게 되는 정신적, 물질적 피해에 대하여 보상할 책임을 지지 않습니다.</td>
								</tr>
								<tr valign="top">
									<td>⑧</td>
									<td>회사는 회원이 서비스에 게재한 각종 정보, 자료, 사실의 신뢰도, 정확성 등 내용에 대하여 책임을 지지 않습니다.</td>
								</tr>
								<tr valign="top">
									<td>⑨</td>
									<td>회사는 이용자 상호간 및 이용자와 제 3자 상호 간에 서비스를 매개로 발생한 분쟁에 대해 개입할 의무가 없으며, 이로 인한 손해를 배상할 책임도 없습니다.</td>
								</tr>
								<tr valign="top">
									<td>⑩</td>
									<td>회사에서 회원에게 무료로 제공하는 서비스의 이용과 관련해서는 어떠한 손해도 책임을 지지 않습니다.</td>
								</tr>
								<tr><td colspan="2">제 22 조 (기타)</td></tr>
								<tr valign="top">
									<td>①</td>
									<td>회사의 정액 서비스 회원 및 기타 유료 서비스 이용 회원의 경우 회사가 별도로 정한 약관 및 정책에 따릅니다.</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>서비스 이용으로 발생한 분쟁에 대해 소송이 제기되는 경우 서울중앙지방법원을 관할 법원으로 합니다.</td>
								</tr>
								<tr>
									<td colspan="2">&lt;부 칙&gt;</td>
								</tr>
								<tr>
									<td colspan="2">(시행일) 이 약관은 2005년 11월 01일부터 시행합니다.2003년 4월 01일부터 시행되던 종전의 약관은 본 약관으로 대체합니다.</td>
								</tr>
								</table>
</div>
							</td>
						</tr>
						<tr><td height="1" class="line_dg"></td></tr>
						<tr><td height="50"></td></tr>
						</table>

						<table width="690" cellpadding="0" cellspacing="0" border="0" align="center">
						<tr>
							<td align="left">
								<!-- 금강산관광  표준약관 -->
								<table width="169" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><img src="<%=imageServer%>/tour_img/footer/txt_agreement02.gif" align="absmiddle"><img src="<%=imageServer%>/tour_img/bu/ico_pdf.gif"  hspace="3" align="absmiddle"></td>
								</tr>
								<tr>
									<td class="tpad_10"><a href="javascript:savePds('금강산관광표준약관.pdf')"><img src="<%=imageServer%>/tour_img/btn/btn_footer_pdfdown.gif"></a><!-- PDF다운로드 --></td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
				<!--  content / -->
			</td>
		</tr>
		</table>
		<!--------  center area /-------->
	</td>
</tr>
<tr>
	<td valign="bottom">
		<!--/ footer -->           
        <%@ include file="footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>