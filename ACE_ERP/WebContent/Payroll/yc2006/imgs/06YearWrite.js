<!--

//��� Popup
function prtOpen(eyy, emm, egb, gb1, eno) {
	var openwin;
	if (openwin != null) {
		openwin.focus();
	} else {
		var strmsg = "�Ű��� ����Ͻ÷��� [Ȯ��]��, ȯ�� ������ �Ͻ÷��� [���]�� �����ϼ���!\n\n"
				strmsg += "1. �Ű� ���� �� �̹��� �μ� : [���� �� ���ͳݿɼ� �� ��� �� �μ�] ����\n";
				strmsg += "2. �Ű� 1������ �μ� : [���� �� ���������� �� ����(�����¿� ��� 5mm)] ����";
		if (confirm(strmsg)) {
			url = '06YearWrite.jsp?eyy=' + eyy + '&emm=' + emm + '&egb=' + egb + '&gb1=' + gb1 + '&eno=' + eno + '&prt=Y';
			openwin = window.open(url, '', 'top=10, left=10, width=750, height=560, status=yes, scrollbars=yes');
		} else {
			return;
		}
	}
}

//-->