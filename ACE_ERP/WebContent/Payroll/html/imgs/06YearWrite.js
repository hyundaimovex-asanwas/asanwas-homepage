<!--

//출력 Popup
function prtOpen(eyy, emm, egb, gb1, eno) {
	var openwin;
	if (openwin != null) {
		openwin.focus();
	} else {
		var strmsg = "신고서를 출력하시려면 [확인]을, 환경 설정을 하시려면 [취소]를 선택하세요!\n\n"
				strmsg += "1. 신고서 배경색 및 이미지 인쇄 : [도구 → 인터넷옵션 → 고급 → 인쇄] 선택\n";
				strmsg += "2. 신고서 1장으로 인쇄 : [파일 → 페이지설정 → 여백(상하좌우 모두 5mm)] 선택";
		if (confirm(strmsg)) {
			url = '06YearWrite.jsp?eyy=' + eyy + '&emm=' + emm + '&egb=' + egb + '&gb1=' + gb1 + '&eno=' + eno + '&prt=Y';
			openwin = window.open(url, '', 'top=10, left=10, width=750, height=560, status=yes, scrollbars=yes');
		} else {
			return;
		}
	}
}

//-->