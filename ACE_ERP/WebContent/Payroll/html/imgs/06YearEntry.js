<!--

//��(��)�ٹ��� �� Popup
function sodOpen(form, eyy, emm, egb, gb1, eno, knd) {
	var openwin;

	if (openwin != null) {
		openwin.focus();
	} else {
		url = "/services/payroll/P030009_ofc.jsp?eyy=" + eyy + "&emm=" + emm + "&egb=" + egb + "&gb1=" + gb1 + "&eno=" + eno;
		openwin = window.open(url, "sod", "top=10, left=10, width=800, height=600, status=yes, scrollbars=yes");
	}
}

//����� Popup
function insOpen(form, eyy, emm, egb, gb1, eno, cgq) {
	var pyccg1 = eval("form.pyccg1_" + cgq);
	var pycjan = eval("form.pycjan_" + cgq);
	var pycsod = eval("form.pycsod_" + cgq);
	var pycju1 = eval("form.pycju1_" + cgq);
	var pycju2 = eval("form.pycju2_" + cgq);
	var pyfchg = eval("form.pyfchg_" + cgq);
	var openable, openwin;

	var yr, mn, dy, gbn;
	var age = 0;

	if (pyccg1.value == "01")	{
		pycsod.checked = true;
	}
	//�ҵ���
	if (pycsod.checked) {
		if (pycjan.checked) {
			openable = "Y";
		} else {
			//����/�����
			if (pyccg1.value == "01" || pyccg1.value == "02") {
				openable = "Y";
			//�ξ簡��
			} else {
				//���ɿ��
				if (pycju1.value.length == 6 && pycju2.value.length == 7) {
					yr = pycju1.value.substring(0, 2);
					mn = pycju1.value.substring(2, 4);
					dy = pycju1.value.substring(4, 6);
					gbn = pycju2.value.substring(0, 1);
					if (gbn == 1 || gbn == 2 || gbn == 5 || gbn == 6) {
						age = eyy - 1900 - yr;
					} else if (gbn == 3 || gbn == 4 || gbn == 7 || gbn == 8) {
						age = eyy - 2000 - yr;
					} else {
						age = 0;
					}
					if (age <= 20 || (gbn == 1 && age >= 60) || (gbn == 2 && age >= 55)) {
						openable = "Y";
					} else {
						openable = "N";
					}
				} else {
					openable = "N";
				}
			}
		}
	} else {
		openable = "N";
	}

	if (openable == "Y") {
		//����üũ
 		checkMDF(form, cgq);
		if (pyfchg.value == "D") {
			alert("���� �� �������� ������ ����Ǿ����ϴ�. ����� ������ �ݿ��˴ϴ�!");
		}
		if (openwin != null) {
			openwin.focus();
		} else {
			url = "06YearEntryIns.jsp?eyy=" + eyy + "&emm=" + emm + "&egb=" + egb + "&gb1=" + gb1 + "&eno=" + eno + "&cgq=" + cgq;
			openwin = window.open(url, "ins", "top=10, left=10, width=800, height=610, status=yes, scrollbars=yes");
		}
	} else {
		alert("�⺻���� ������(���ɡ��ҵ���������)�� ����� ������ ��û�� �� �ֽ��ϴ�!");
		return;
	}
}

//�Ƿ�� Popup
function medOpen(form, eyy, emm, egb, gb1, eno, cgq) {
	var pydchg = eval("form.pydchg_" + cgq);
	var openwin;

	if (openwin != null) {
		openwin.focus();
	} else {
		//����üũ
 		checkMDF(form, cgq);
		if (pydchg.value == "D") {
			alert("���� �� �������� ������ ����Ǿ����ϴ�. ����� ������ �ݿ��˴ϴ�!");
		}
		url = "06YearEntryMed.jsp?eyy=" + eyy + "&emm=" + emm + "&egb=" + egb + "&gb1=" + gb1 + "&eno=" + eno + "&cgq=" + cgq;
		openwin = window.open(url, "med", "top=10, left=3, width=1008, height=610, status=yes, scrollbars=yes");
	}
}

//������ Popup
function eduOpen(form, eyy, emm, egb, gb1, eno, cgq) {
	var pyccg1 = eval("form.pyccg1_" + cgq);
	var pycjan = eval("form.pycjan_" + cgq);
	var pycsod = eval("form.pycsod_" + cgq);
	var pycju1 = eval("form.pycju1_" + cgq);
	var pycju2 = eval("form.pycju2_" + cgq);
	var pygchg = eval("form.pygchg_" + cgq);
	var openable, openwin;

	var yr, mn, dy, gbn, chk;
	var age = 0;

	if (pycju1.value.length == 6 && pycju2.value.length == 7) {
		yr = pycju1.value.substring(0, 2);
		mn = pycju1.value.substring(2, 4);
		dy = pycju1.value.substring(4, 6);
		gbn = pycju2.value.substring(0, 1);
		if (gbn == 1 || gbn == 2 || gbn == 5 || gbn == 6) {
			age = eyy - 1900 - yr;
		} else if (gbn == 3 || gbn == 4 || gbn == 7 || gbn == 8) {
			age = eyy - 2000 - yr;
		} else {
			age = 0;
		}
		if (pyccg1.value == "01")	{
			pycsod.checked = true;
		}
		if (pycsod.checked) {
			openable = "Y";
			//���������� ���
			if (pyccg1.value == "03" || pyccg1.value == "04" || pyccg1.value == "14" || pyccg1.value == "15" ||
				  pyccg1.value == "05" || pyccg1.value == "06" || pyccg1.value == "16" || pyccg1.value == "17" ||
					pyccg1.value == "18" || pyccg1.value == "19" || pyccg1.value == "07" || pyccg1.value == "08") {
				openable = "C";
			}
		} else {
			openable = "N";
		}
		//���л�/������ ����
		if (age >= 8) {
			knd = "A";
 		} else if (age < 8) {
 			knd = "B";
		} else {
			knd = "";
		}
		if (openable == "Y") {
			//����üũ
			checkMDF(form, cgq);
			if (pygchg.value == "D") {
				alert("���� �� �������� ������ ����Ǿ����ϴ�. ����� ������ �ݿ��˴ϴ�!");
				}
			if (openwin != null) {
				openwin.focus();
			} else {
				url = "06YearEntryEdu.jsp?eyy=" + eyy + "&emm=" + emm + "&egb=" + egb + "&gb1=" + gb1 + "&eno=" + eno + "&cgq=" + cgq + "&knd=" + knd;
				openwin = window.open(url, "edu", "top=10, left=10, width=860, height=635, status=yes, scrollbars=yes");
			}
		} else if (openable == "C") {
			alert("���������� ������� ���� ��û�� �� �����ϴ�!");
			return;
		} else if (openable == "N") {
			alert("�����ҵ�ݾ� 100���� �����ڸ� ������ ������ ��û�� �� �ֽ��ϴ�!");
			return;
		}
	}
}

//ī��� Popup
function cadOpen(form, eyy, emm, egb, gb1, eno, cgq) {
	var pyccg1 = eval("form.pyccg1_" + cgq);
	var pycsod = eval("form.pycsod_" + cgq);
	var pyhchg = eval("form.pyhchg_" + cgq);
	var openable, openwin;

	if (pyccg1.value == "01")	{
		pycsod.checked = true;
	}
	if (pycsod.checked) {
		openable = "Y";
	} else {
		openable = "N";
	}

	if (pyccg1.value == "10" || pyccg1.value == "11") {
		openable = "C";
	}

	if (openable == "Y") {
		//����üũ
 		checkMDF(form, cgq);
		if (pyhchg.value == "D") {
			alert("���� �� �������� ������ ����Ǿ����ϴ�. ����� ������ �ݿ��˴ϴ�!");
		}
		if (openwin != null) {
			openwin.focus();
		} else {
			url = "06YearEntryCad.jsp?eyy=" + eyy + "&emm=" + emm + "&egb=" + egb + "&gb1=" + gb1 + "&eno=" + eno + "&cgq=" + cgq;
			openwin = window.open(url, "cad", "top=10, left=10, width=860, height=610, status=yes, scrollbars=yes");
		}
	} else if (openable == "C") {
		alert("�������ڸ��� �ſ�ī�� �� ������ ���� ��û�� �� �����ϴ�!");
		return;
	} else if (openable == "N") {
		alert("���� �ҵ�ݾ� 100���� �����ڸ� �ſ�ī�� �� ������ ��û�� �� �ֽ��ϴ�!");
		return;
	}
}

//��λ� Popup
function gibuOpen(form, eyy, emm, egb, gb1, eno, knd) {
	var openwin;

	if (openwin != null) {
		openwin.focus();
	} else {
		url = "06YearEntryGibu.jsp?eyy=" + eyy + "&emm=" + emm + "&egb=" + egb + "&gb1=" + gb1 + "&eno=" + eno + "&knd=" + knd;
		openwin = window.open(url, "", "top=10, left=0, width=1015, height=630, status=yes, scrollbars=yes");
	}
}

function checkSAE(form) {
	if (!form.pycsae_1.checked) {
		form.pybho1.value = 0;
		form.pybho2.value = 0;
		form.pybho3.value = 0;
		form.pybho4.value = 0;
		form.pybho5.value = 0;
		form.pybho6.value = 0;
		form.pybhto.value = 0;
		form.pybhho.value = 0;
	}
	form.pycjan_1.focus();
	return;
}

function checkFRN(form, JU1, JU2, FRN) {
	var pycju1 = eval("form." + JU1);
	var pycju2 = eval("form." + JU2);
	var pycfrn = eval("form." + FRN);

	if (pycju1.value.length == 6 && pycju2.value.length == 7 && pycfrn.checked) {
		if (!IsForeignerSSN(pycju1.value, pycju2.value)) {
			if (FRN == "pycfrn_1") {
				alert("�ܱ��ε�Ϲ�ȣ �Ǵ� ���ǹ�ȣ�� �ƴմϴ�!");
				pycfrn.checked = false;
				return;
			} else {
				alert("�ܱ��ε�Ϲ�ȣ �Ǵ� ���ǹ�ȣ�� �Է¹ٶ��ϴ�!");
				pycfrn.checked = false;
				pycju1.focus();
				return;
			}
		} else {
			pycfrn.checked = true;
		}
	}
}

function checkJMN(form, JU1, JU2, SOD, JAN, OL1, OL2, OLD, YNG) {
	var pycju1 = eval("form." + JU1);
	var pycju2 = eval("form." + JU2);
	var pycsod = eval("form." + SOD);
	var pycjan = eval("form." + JAN);
	var pycol1 = eval("form." + OL1);
	var pycol2 = eval("form." + OL2);
	var pycold = eval("form." + OLD);
	var pycyng = eval("form." + YNG);
	if (pycju1.value.length != 6 || pycju2.value.length != 7) {
		pycsod.checked = false;
		pycjan.checked = false;
		pycol1.checked = false;
		pycol2.checked = false;
		pycold.checked = false;
		pycyng.checked = false;
		pycjan.disabled = true;
		pycyng.disabled = true;
	}
}

function checkOLD(form, dft_yr, JU1, JU2, OL1, OL2, OLD, SOD) {
	var pycju1 = eval("form." + JU1);
	var pycju2 = eval("form." + JU2);
	var pycol1 = eval("form." + OL1);
	var pycol2 = eval("form." + OL2);
	var pycold = eval("form." + OLD);
	var pycsod = eval("form." + SOD);
	var yr, mn, dy, gbn;
	var brth_yr;
	//���� �ҵ������
	if (SOD == "pycsod_1") {
		pycsod.checked = true;
	}
	if (pycju1.value.length == 6 && pycju2.value.length == 7 && pycsod.checked) {
		yr = pycju1.value.substring(0, 2);
		mn = pycju1.value.substring(2, 4);
		dy = pycju1.value.substring(4, 6);
		gbn = pycju2.value.substring(0, 1);
		if (gbn == 1 || gbn == 2 || gbn == 5 || gbn == 6) {
			brth_yr = dft_yr - 1900 - yr;
		} else if (gbn == 3 || gbn == 4 || gbn == 7 || gbn == 8) {
			brth_yr = dft_yr - 2000 - yr;
		} else {
			brth_yr = 0;
		}
		if (brth_yr >= 65 && brth_yr < 70) {
			pycol1.checked = true;
			pycol2.checked = false;
			pycold.checked = true;
		} else if (brth_yr >= 70) {
			pycol1.checked = false;
			pycol2.checked = true;
			pycold.checked = true;
		} else {
			pycol1.checked = false;
			pycol2.checked = false;
			pycold.checked = false;
		}
	} else {
		pycol1.checked = false;
		pycol2.checked = false;
		pycold.checked = false;
	}
}

function checkSOD(form, JU1, JU2, SOD, JAN, CGQ) {
	var pycju1 = eval("form." + JU1);
	var pycju2 = eval("form." + JU2);
	var pycsod = eval("form." + SOD);
	var pycjan = eval("form." + JAN);
	var pyfink = eval("form.pyfinktot_" + CGQ);
	var pyfine = eval("form.pyfinetot_" + CGQ);
	var pygedk = eval("form.pygedktot_" + CGQ);
	var pygede = eval("form.pygedetot_" + CGQ);
	var pyhcak = eval("form.pyhcaktot_" + CGQ);
	var pyhcae = eval("form.pyhcaetot_" + CGQ);

	if (pycju1.value.length == 6 && pycju2.value.length == 7) {
		if (pycsod.checked) {
			if (confirm("���������� �ް��� �ϴ� ������\n���� �Ѽҵ��� ���ų� 100���������� ��쿡�� [Ȯ��]�� �����մϴ�!")) {
				pycsod.checked = true;
				pycjan.disabled = false;
				pycju2.focus();
				return;
			} else {
				pycsod.checked = false;
				pycjan.checked = false;
				pycjan.disabled = true;
				pycju2.focus();
				return;
			}
		} else {
			if (pyfink.value != 0 || pyfine.value != 0 || pygedk.value != 0 || pygede.value != 0 || pyhcak.value != 0 || pyhcae.value != 0) {
				pycsod.checked = true;
				alert("�����ҵ�ݾ� 100���� ���� üũ Ȯ���� ����Ϸ���\n[�����/������/�ſ�ī��(���ݿ�����)] �Է°��� ���� ����(����)�� �� üũ ǥ�ø� ����� �ֽʽÿ�!");
			} else {
				pycsod.checked = false;
				pycjan.checked = false;
				pycjan.disabled = true;
				pycju2.focus();
				return;
			}
		}
	} else {
		pycsod.checked = false;
		pycjan.checked = false;
		pycjan.disabled = true;
	}
}

function checkJAN(form, JAN, CGQ) {
	var pycjan = eval("form." + JAN);
	var pyfjns = eval("form.pyfjnstot_" + CGQ);
	var pygets = eval("form.pygetstot_" + CGQ);
	var pydmek = eval("form.pydmektot_" + CGQ);
	var pydmee = eval("form.pydmeetot_" + CGQ);

	if (!pycjan.checked) {
		if (pyfjns.value != 0 || pygets.value != 0) {
			pycjan.checked = true;
			alert("����� ���� ��û�� ����Ϸ���\n[����� �����/������] �Է°��� ���� ����(����)�� �� �ٽ� üũ ǥ�ø� ����� �ֽʽÿ�!");
			return;
		}
		if (pydmek.value != 0 || pydmee.value != 0) {
			pycjan.checked = false;
			alert("����� ���� ��û�� ����Ϸ���\n[������Ƿ��]�� [�Ϲ�/����/����Ƿ��]�� ��������ǵ��� �Ƿ�� ��â�� �������� �ֽʽÿ�!");
			return;
		}
	}
}

function checkYNG(form, dft_yr, JU1, JU2, YNG) {
	var pycju1 = eval("form." + JU1);
	var pycju2 = eval("form." + JU2);
	var pycyng = eval("form." + YNG);
	var yr, mn, dy, gbn;
	var brth_yr;
	if (pycju1.value.length == 6 && pycju2.value.length == 7) {
		yr = pycju1.value.substring(0, 2);
		mn = pycju1.value.substring(2, 4);
		dy = pycju1.value.substring(4, 6);
		gbn = pycju2.value.substring(0, 1);
		if (gbn == 1 || gbn == 2 || gbn == 5 || gbn == 6) {
			brth_yr = dft_yr - 1900 - yr;
		} else if (gbn == 3 || gbn == 4 || gbn == 7 || gbn == 8) {
			brth_yr = dft_yr - 2000 - yr;
		} else {
			brth_yr = 0;
		}
		if (brth_yr > 6) {
			pycyng.disabled = true;
		} else {
			pycyng.disabled = false;
		}
	} else {
		pycyng.checked = false;
		pycyng.disabled = true;
	}
}

function checkJJG(form, obj) {
	if (!form.pycsae_1.checked) {
		alert("���� ������ ���� ���ýø� �Է��� �����մϴ�!");
		form.pybhto.focus();
		return;
	} else {
		if (obj.value == "0") {
			obj.value = "";
		}
	}
}

//�ڵ弱��
function selectCOD (form, CG1) {
	var pyccg1 = eval("form." + CG1);
	var idx = pyccg1.selectedIndex;

	if (idx == 0) {
		return;
	} else {
		pyccg1.options[idx].selected = true;
	}
}

function showDiv(id, img1, img2) {
	if (document.all(id).style.display == "none")	{
		document.all.imgsrc.src = img1;
		document.all(id).style.display = "block";
	} else {
		document.all.imgsrc.src = img2;
		document.all(id).style.display = "none";
	}
}

function scrollWin(chk, sav) {
	if (chk == "T" && sav == "T") {
		window.scroll(150, 620);
	}
}

function writableFLD(form, cgq, pychnm) {
	var pyfink = eval("form.pyfinktot_" + cgq);
	var pyfine = eval("form.pyfinetot_" + cgq);
	var pydmek = eval("form.pydmektot_" + cgq);
	var pydmee = eval("form.pydmeetot_" + cgq);
	var pygedk = eval("form.pygedktot_" + cgq);
	var pygede = eval("form.pygedetot_" + cgq);
	var pyhcak = eval("form.pyhcaktot_" + cgq);
	var pyhcae = eval("form.pyhcaetot_" + cgq);

	if (!pychnm.value) {
		pyfink.disabled = true;
		pyfine.disabled = true;
		pydmek.disabled = true;
		pydmee.disabled = true;
		pygedk.disabled = true;
		pygede.disabled = true;
		pyhcak.disabled = true;
		pyhcae.disabled = true;
		pyfink.style.background = "#F5F5F5";
		pyfine.style.background = "#F5F5F5";
		pydmek.style.background = "#F5F5F5";
		pydmee.style.background = "#F5F5F5";
		pygedk.style.background = "#F5F5F5";
		pygede.style.background = "#F5F5F5";
		pyhcak.style.background = "#F5F5F5";
		pyhcae.style.background = "#F5F5F5";
		pyfink.style.border = "1 solid #CCCCCC";
		pyfine.style.border = "1 solid #CCCCCC";
		pydmek.style.border = "1 solid #CCCCCC";
		pydmee.style.border = "1 solid #CCCCCC";
		pygedk.style.border = "1 solid #CCCCCC";
		pygede.style.border = "1 solid #CCCCCC";
		pyhcak.style.border = "1 solid #CCCCCC";
		pyhcae.style.border = "1 solid #CCCCCC";
	} else {
		pyfink.disabled = false;
		pyfine.disabled = false;
		pydmek.disabled = false;
		pydmee.disabled = false;
		pygedk.disabled = false;
		pygede.disabled = false;
		pyhcak.disabled = false;
		pyhcae.disabled = false;
		pyfink.style.background = "#FFFFFF";
		pyfine.style.background = "#FFFFFF";
		pydmek.style.background = "#FFFFFF";
		pydmee.style.background = "#FFFFFF";
		pygedk.style.background = "#FFFFFF";
		pygede.style.background = "#FFFFFF";
		pyhcak.style.background = "#FFFFFF";
		pyhcae.style.background = "#FFFFFF";
		pyfink.style.border = "1 solid #FF6600";
		pyfine.style.border = "1 solid #FF6600";
		pydmek.style.border = "1 solid #FF6600";
		pydmee.style.border = "1 solid #FF6600";
		pygedk.style.border = "1 solid #FF6600";
		pygede.style.border = "1 solid #FF6600";
		pyhcak.style.border = "1 solid #FF6600";
		pyhcae.style.border = "1 solid #FF6600";
	}
}

//���ݺ���� ��
function calculatePybsto(form) {
	var pybsto_val = 0;

	var pyisgmtot = eval("form.pyisgmtot"); //���ο���(��)
	var pybsgm = eval("form.pybsgm"); 			//���ο���(��)
	var pybsto = eval("form.pybsto"); 			//��

	pybsto_val = chkValue(pyisgmtot) + chkValue(pybsgm);
	pybsto.value = addCommaValue(String(pybsto_val));
}

//����� ��
function calculatePybito(form) {
	var pyfinstot_val = 0;
	var pyfjnstot_val = 0;
	var pybito_val = 0;

	var pyisbhtot = eval("form.pyisbhtot"); //�ǰ������(��)
	var pyisgytot = eval("form.pyisgytot"); //��뺸���(��)
	var pybsbh = eval("form.pybsbh"); 			//�ǰ������(��)
	var pybsgy = eval("form.pybsgy"); 			//��뺸���(��)
	var pybins = eval("form.pybins"); 			//�Ϲݺ����
	var pybin2 = eval("form.pybin2"); 			//����κ����
	var pybito = eval("form.pybito"); 			//��

	var pyisbhtot_val = chkValue(pyisbhtot);
	var pyisgytot_val = chkValue(pyisgytot);
	var pybsbh_val = chkValue(pybsbh);
	var pybsgy_val = chkValue(pybsgy);

	for (var i = 1; i <= 12; i++) {
		var pyfinstot = eval("form.pyfinstot_" + i);
		var pyfjnstot = eval("form.pyfjnstot_" + i);
		pyfinstot_val = pyfinstot_val + chkValue(pyfinstot);
		pyfjnstot_val = pyfjnstot_val + chkValue(pyfjnstot);
	}

	pybito_val = (pyisbhtot_val + pybsbh_val) + (pyisgytot_val + pybsgy_val) + (pyfinstot_val + pyfjnstot_val);

	pybins.value = addCommaValue(String(pyfinstot_val));
	pybin2.value = addCommaValue(String(pyfjnstot_val));
	pybito.value = addCommaValue(String(pybito_val));
}

//�Ƿ�� ��
function calculatePybmto(form) {
	var pybmsd = eval("form.pybmsd"); //�������Ƿ��
	var pybmgd = eval("form.pybmgd"); //�Ϲ��Ƿ��
	var pybmtc = eval("form.pybmtc"); //ī���Ƿ��
	var pybmtm = eval("form.pybmtm"); //�����Ƿ��
	var pybmto = eval("form.pybmto"); //�Ƿ���

	var pydme1tot_val = 0;
	var pydme2tot_val = 0;
	var pydmsdtot_val = 0;
	var pydmgdtot_val = 0;

	for (var i = 1; i <= 12; i++) {
		var pydme1tot = eval("form.pydme1tot_" + i);
		var pydme2tot = eval("form.pydme2tot_" + i);
		var pydmsdtot = eval("form.pydmsdtot_" + i);
		var pydmgdtot = eval("form.pydmgdtot_" + i);

		pydme1tot_val = pydme1tot_val + chkValue(pydme1tot);
		pydme2tot_val = pydme2tot_val + chkValue(pydme2tot);
		pydmsdtot_val = pydmsdtot_val + chkValue(pydmsdtot);
		pydmgdtot_val = pydmgdtot_val + chkValue(pydmgdtot);
	}

	pybmsd.value = addCommaValue(String(pydmsdtot_val));
	pybmgd.value = addCommaValue(String(pydmgdtot_val));
	pybmtc.value = addCommaValue(String(pydme1tot_val));
	pybmtm.value = addCommaValue(String(pydme2tot_val));
	pybmto.value = addCommaValue(String(pydmsdtot_val + pydmgdtot_val));
}

//������ ��
function calculatePybeto(form) {
	var pybsed = eval("form.pybsed"); //���α�����
	var pybebc = eval("form.pybebc"); //�������ο�
	var pybebt = eval("form.pybebt"); //������������
	var pybecc = eval("form.pybecc"); //���߰��ο�
	var pybect = eval("form.pybect"); //���߰�����
	var pybedc = eval("form.pybedc"); //���л��ο�
	var pybedt = eval("form.pybedt"); //���л�������
	var pybetc = eval("form.pybetc"); //������ο�
	var pybets = eval("form.pybets"); //����α�����
	var pybeto = eval("form.pybeto"); //�������

	var pygsedtot_val = 0;
	var pygebctot_val = 0;
	var pygebttot_val = 0;
	var pygecctot_val = 0;
	var pygecttot_val = 0;
	var pygedctot_val = 0;
	var pygedttot_val = 0;
	var pygetctot_val = 0;
	var pygetstot_val = 0;
	var pybeto_val = 0;

	for (var i = 1; i <= 12; i++) {
		var pygsedtot = eval("form.pygsedtot_" + i);
		var pygebctot = eval("form.pygebctot_" + i);
		var pygebttot = eval("form.pygebttot_" + i);
		var pygecctot = eval("form.pygecctot_" + i);
		var pygecttot = eval("form.pygecttot_" + i);
		var pygedctot = eval("form.pygedctot_" + i);
		var pygedttot = eval("form.pygedttot_" + i);
		var pygetctot = eval("form.pygetctot_" + i);
		var pygetstot = eval("form.pygetstot_" + i);

		pygsedtot_val = pygsedtot_val + chkValue(pygsedtot);
		pygebctot_val = pygebctot_val + chkValue(pygebctot);
		pygebttot_val = pygebttot_val + chkValue(pygebttot);
		pygecctot_val = pygecctot_val + chkValue(pygecctot);
		pygecttot_val = pygecttot_val + chkValue(pygecttot);
		pygedctot_val = pygedctot_val + chkValue(pygedctot);
		pygedttot_val = pygedttot_val + chkValue(pygedttot);
		pygetctot_val = pygetctot_val + chkValue(pygetctot);
		pygetstot_val = pygetstot_val + chkValue(pygetstot);
	}

	pybeto_val = (pygsedtot_val + pygebttot_val + pygecttot_val + pygedttot_val + pygetstot_val);

	pybsed.value = addCommaValue(String(pygsedtot_val));
	pybebc.value = addCommaValue(String(pygebctot_val));
	pybebt.value = addCommaValue(String(pygebttot_val));
	pybecc.value = addCommaValue(String(pygecctot_val));
	pybect.value = addCommaValue(String(pygecttot_val));
	pybedc.value = addCommaValue(String(pygedctot_val));
	pybedt.value = addCommaValue(String(pygedttot_val));
	pybetc.value = addCommaValue(String(pygetctot_val));
	pybets.value = addCommaValue(String(pygetstot_val));
	pybeto.value = addCommaValue(String(pybeto_val));
}

//�����ڱ� ��
function calculatePybhto(form) {
	var pybhto_val = 0;
	var pybho1 = eval("form.pybho1");
	var pybho2 = eval("form.pybho2");
	var pybho3 = eval("form.pybho3");
	var pybho4 = eval("form.pybho4");
	var pybho5 = eval("form.pybho5");
	var pybho6 = eval("form.pybho6");
	var pybhto = eval("form.pybhto");

	pybhto_val = chkValue(pybho1) + chkValue(pybho2) + chkValue(pybho3) + chkValue(pybho4) + chkValue(pybho5) + chkValue(pybho6);
	pybhto.value = addCommaValue(String(pybhto_val));
}

//�ſ�ī�� ��
function calculatePybcto(form) {
	var pybcad = eval("form.pybcad"); //�ſ�ī���
	var pybhnd = eval("form.pybhnd"); //���ݿ�������
	var pybsgd = eval("form.pybsgd"); //�п���
	var pybmex = eval("form.pybmex"); //�Ƿ���ߺ���������
	var pybcto = eval("form.pybcto"); //�ſ�ī��� ��

	var pyhcadtot_val = 0;
	var pyhhadtot_val = 0;
	var pyhmadtot_val = 0;
	var pybcto_val = 0;

	for (var i = 1; i <= 12; i++) {
		var pyhcadtot = eval("form.pyhcadtot_" + i);
		var pyhhadtot = eval("form.pyhhadtot_" + i);
		var pyhmadtot = eval("form.pyhmadtot_" + i);

		pyhcadtot_val = pyhcadtot_val + chkValue(pyhcadtot);
		pyhhadtot_val = pyhhadtot_val + chkValue(pyhhadtot);
		pyhmadtot_val = pyhmadtot_val + chkValue(pyhmadtot);
	}

	pybcto_val = pyhcadtot_val + pyhhadtot_val + pyhmadtot_val;

	pybcad.value = addCommaValue(String(pyhcadtot_val));
	pybhnd.value = addCommaValue(String(pyhmadtot_val));
	pybsgd.value = addCommaValue(String(pyhhadtot_val));
	pybcto.value = addCommaValue(String(pybcto_val));
}

function chkValue(obj) {
	var obj_val = 0;

	if (obj == undefined || obj.value == "NaN" || obj.value == "")	obj_val = 0;
	else	obj_val = parseInt(removeCommaValue(obj.value));

	return obj_val;
}

function checkIJK(form, cgq) {
	var pychnm = eval("form.pychnm_" + cgq);
	var pycju1 = eval("form.pycju1_" + cgq);
	var pycju2 = eval("form.pycju2_" + cgq);
	var pyccg1 = eval("form.pyccg1_" + cgq);

	//�����
	if (pyccg1.value == '02') {
		if (!pychnm.value) {
			alert("����� ������ �Է��� �ּ���!");
			return;
		}
		if (!pycju1.value || !pycju2.value) {
			alert("����� �ֹε�Ϲ�ȣ�� �Է��� �ּ���!");
			if (!pycju1.value) {
				pycju1.focus();
			} else {
				pycju2.focus();
			}
			return;
		}
		if (pycju1.value) {
			if (!IsIntegerNumber(pycju1.value)) {
				alert("����� �ֹε�Ϲ�ȣ�� ���ڷ� �Է��� �ּ���!");
				pycju1.focus();
				return;
			}
			if (pycju1.value.length != 6) {
				alert("����� �ֹε�Ϲ�ȣ�� �ùٸ��� �Է��� �ּ���!");
				pycju1.focus();
				return;
			}
		}
		if (pycju2.value) {
			if (!IsIntegerNumber(pycju2.value)) {
				alert("����� �ֹε�Ϲ�ȣ�� ���ڷ� �Է��� �ּ���!");
				pycju2.focus();
				return;
			}
			if (pycju2.value.length != 7) {
				alert("����� �ֹε�Ϲ�ȣ�� �ùٸ��� �Է��� �ּ���!");
				pycju2.focus();
				return;
			}
		}
		if (pycju2.value.substring(0, 1) == 1 || pycju2.value.substring(0, 1) == 2 || pycju2.value.substring(0, 1) == 3 || pycju2.value.substring(0, 1) == 4) {
			if (!IsKoreanSSN(pycju1.value, pycju2.value)) {
				alert("����� �ֹε�Ϲ�ȣ�� �ùٸ��� �Է��� �ּ���!");
				pycju1.focus();
				return;
			}
		} else if (pycju2.value.substring(0, 1) == 5 || pycju2.value.substring(0, 1) == 6 || pycju2.value.substring(0, 1) == 7 || pycju2.value.substring(0, 1) == 8) {
			if (!IsForeignerSSN(pycju1.value, pycju2.value)) {
				alert("����� �ֹε�Ϲ�ȣ�� �ùٸ��� �Է��� �ּ���!");
				pycju1.focus();
				return;
			}
		}
	}
	//����
	if (pyccg1.value != 01 && pyccg1.value != 02) {
		if (!pychnm.value) {
			alert("���� ������ �Է��� �ּ���!");
			return;
		}
		if (pychnm.value) {
			if (!pyccg1.selectedIndex) {
				alert("���� ���踦 ������ �ּ���!");
				pyccg1.focus();
				return;
			}
			if (!pycju1.value || !pycju2.value) {
				alert(pychnm.value + " ���� �ֹε�Ϲ�ȣ�� �Է��� �ּ���!");
				if(!pycju1.value) {
					pycju1.focus();
				} else {
					pycju2.focus();
				}
				return;
			}
			if (pycju1.value) {
				if (!IsIntegerNumber(pycju1.value)) {
					alert(pychnm.value + " ���� �ֹε�Ϲ�ȣ�� ���ڷ� �Է��� �ּ���!");
					pycju1.focus();
					return;
				}
				if (pycju1.value.length != 6) {
					alert(pychnm.value + " ���� �ֹε�Ϲ�ȣ�� �ùٸ��� �Է��� �ּ���!");
					pycju1.focus();
					return;
				}
			}
			if (pycju2.value) {
				if (!IsIntegerNumber(pycju2.value)) {
					alert(pychnm.value + " ���� �ֹε�Ϲ�ȣ�� ���ڷ� �Է��� �ּ���!");
					pycju2.focus();
					return;
				}
				if (pycju2.value.length != 7) {
					alert(pychnm.value + " ���� �ֹε�Ϲ�ȣ�� �ùٸ��� �Է��� �ּ���!");
					pycju2.focus();
					return;
				}
			}
			if (pycju2.value.substring(0, 1) == 1 || pycju2.value.substring(0, 1) == 2 || pycju2.value.substring(0, 1) == 3 || pycju2.value.substring(0, 1) == 4) {
				if (!IsKoreanSSN(pycju1.value, pycju2.value)) {
					alert(pychnm.value + " ���� �ֹε�Ϲ�ȣ�� �ùٸ��� �Է��� �ּ���!");
					pycju1.focus();
					return;
				}
			} else if (pycju2.value.substring(0, 1) == 5 || pycju2.value.substring(0, 1) == 6 || pycju2.value.substring(0, 1) == 7 || pycju2.value.substring(0, 1) == 8) {
				if (!IsForeignerSSN(pycju1.value, pycju2.value)) {
					alert(pychnm.value + " ���� �ֹε�Ϲ�ȣ�� �ùٸ��� �Է��� �ּ���!");
					pycju1.focus();
					return;
				}
			}
		}
	}

	//���� �ֹι�ȣ üũ

	for (var i = 1; i <= 12; i++) {
		var pycju1_1 = eval('form.pycju1_' + i);
		var pycju2_1 = eval('form.pycju2_' + i);
		var pychnm_1 = eval('form.pychnm_' + i);

		if ((i != cgq) && (pycju1.value == pycju1_1.value) && (pycju2.value == pycju2_1.value)) {
			alert(pychnm.value + " �԰� " + pychnm_1.value + " ���� �ֹι�ȣ�� �����մϴ�.\n������ �ֽʽÿ�!");
			pycju1.focus();
			return;
		}
	}
}

function checkForm(form, chk) {

	form.pybchk.value = chk;

	//��������

	//���κγ��� Ȱ��ȭ
	form.pycnea_1.disabled = false;

	//����� Ȱ��ȭ
	for (var i = 1; i <= 12; i++) {
		var pycjan = eval('form.pycjan_' + i);
		pycjan.disabled = false;
	}

	//��ο�� Ȱ��ȭ
	for (var i = 1; i <= 12; i++) {
		var pycol1 = eval('form.pycol1_' + i);
		var pycol2 = eval('form.pycol2_' + i);
		pycol1.disabled = false;
		pycol2.disabled = false;
	}

	//�ڳ���� Ȱ��ȭ
	var strmsg = "6�� ���� �ڳ࿡ ���� �ڳ������ ������ ��û���� �ʾҽ��ϴ�.\n\n";
			strmsg += " �� ������û : [Ȯ��] ������ �ڳ��������� (��) ǥ�� �ٶ��ϴ�.\n";
			strmsg += " �� ������û ���� : �� �޼���â ������ �����ϰ� [���] ������ �������� �Ͻø� �˴ϴ�.";

	for (var i = 3; i <= 12; i++) {
		var pycyng = eval('form.pycyng_' + i);

		if (!pycyng.disabled && !pycyng.checked) {
			if (confirm(strmsg)) {
				pycyng.focus();
				return;
			} else {
			}
		}
	}

	//ȥ��, ���, �̻� Ȱ��ȭ
	form.pyba01.disabled = false;
	form.pyba01.disabled = false;
	form.pyba03.disabled = false;

	//�����
	if (form.pychnm_2.value) {
		if (!form.pycju1_2.value || !form.pycju2_2.value) {
			alert("����� �ֹε�Ϲ�ȣ�� �Է��� �ּ���!");
			if (!form.pycju1_2.value) {
				form.pycju1_2.focus();
			} else {
				form.pycju2_2.focus();
			}
			return;
		}
		if (form.pycju1_2.value) {
			if (!IsIntegerNumber(form.pycju1_2.value)) {
				alert("����� �ֹε�Ϲ�ȣ�� ���ڷ� �Է��� �ּ���!");
				form.pycju1_2.focus();
				return;
			}
			if (form.pycju1_2.value.length != 6) {
				alert("����� �ֹε�Ϲ�ȣ�� �ùٸ��� �Է��� �ּ���!");
				form.pycju1_2.focus();
				return;
			}
		}
		if (form.pycju2_2.value) {
			if (!IsIntegerNumber(form.pycju2_2.value)) {
				alert("����� �ֹε�Ϲ�ȣ�� ���ڷ� �Է��� �ּ���!");
				form.pycju2_2.focus();
				return;
			}
			if (form.pycju2_2.value.length != 7) {
				alert("����� �ֹε�Ϲ�ȣ�� �ùٸ��� �Է��� �ּ���!");
				form.pycju2_2.focus();
				return;
			}
		}
		if (form.pycju2_2.value.substring(0, 1) == 1 || form.pycju2_2.value.substring(0, 1) == 2 || form.pycju2_2.value.substring(0, 1) == 3 || form.pycju2_2.value.substring(0, 1) == 4) {
			if (!IsKoreanSSN(form.pycju1_2.value, form.pycju2_2.value)) {
				alert("����� �ֹε�Ϲ�ȣ�� �ùٸ��� �Է��� �ּ���!");
				form.pycju1_2.focus();
				return;
			}
		} else if (form.pycju2_2.value.substring(0, 1) == 5 || form.pycju2_2.value.substring(0, 1) == 6 || form.pycju2_2.value.substring(0, 1) == 7 || form.pycju2_2.value.substring(0, 1) == 8) {
			if (!IsForeignerSSN(form.pycju1_2.value, form.pycju2_2.value)) {
				alert("����� �ֹε�Ϲ�ȣ�� �ùٸ��� �Է��� �ּ���!");
				form.pycju1_2.focus();
				return;
			}
		}
	}

	//����
	for (i = 3; i <= 12; i++) {
		var pyccg1 = eval('form.pyccg1_' + i);
		var pychnm = eval('form.pychnm_' + i);
		var pycju1 = eval('form.pycju1_' + i);
		var pycju2 = eval('form.pycju2_' + i);
		var pycadr = eval('form.pycadr_' + i);
		if (pychnm.value) {
			if (!pyccg1.selectedIndex) {
				alert("���� ���踦 ������ �ּ���!");
				pyccg1.focus();
				return;
			}
			if (!pycju1.value || !pycju2.value) {
				alert("���� �ֹε�Ϲ�ȣ�� �Է��� �ּ���!");
				if(!pycju1.value) {
					pycju1.focus();
				} else {
					pycju2.focus();
				}
				return;
			}
			if (pycju1.value) {
				if (!IsIntegerNumber(pycju1.value)) {
					alert(pychnm.value + " ���� �ֹε�Ϲ�ȣ�� ���ڷ� �Է��� �ּ���!");
					pycju1.focus();
					return;
				}
				if (pycju1.value.length != 6) {
					alert(pychnm.value + " ���� �ֹε�Ϲ�ȣ�� �ùٸ��� �Է��� �ּ���!");
					pycju1.focus();
					return;
				}
			}
			if (pycju2.value) {
				if (!IsIntegerNumber(pycju2.value)) {
					alert(pychnm.value + " ���� �ֹε�Ϲ�ȣ�� ���ڷ� �Է��� �ּ���!");
					pycju2.focus();
					return;
				}
				if (pycju2.value.length != 7) {
					alert(pychnm.value + " ���� �ֹε�Ϲ�ȣ�� �ùٸ��� �Է��� �ּ���!");
					pycju2.focus();
					return;
				}
			}
			if (pycju2.value.substring(0, 1) == 1 || pycju2.value.substring(0, 1) == 2 || pycju2.value.substring(0, 1) == 3 || pycju2.value.substring(0, 1) == 4) {
				if (!IsKoreanSSN(pycju1.value, pycju2.value)) {
					alert(pychnm.value + " ���� �ֹε�Ϲ�ȣ�� �ùٸ��� �Է��� �ּ���!");
					pycju1.focus();
					return;
				}
			} else if (pycju2.value.substring(0, 1) == 5 || pycju2.value.substring(0, 1) == 6 || pycju2.value.substring(0, 1) == 7 || pycju2.value.substring(0, 1) == 8) {
				if (!IsForeignerSSN(pycju1.value, pycju2.value)) {
					alert(pychnm.value + " ���� �ֹε�Ϲ�ȣ�� �ùٸ��� �Է��� �ּ���!");
					pycju1.focus();
					return;
				}
			}
		}
	}

	//���� �ֹι�ȣ üũ

	for (var i = 1; i <= 12; i++) {
		var pycju1_1 = eval('form.pycju1_' + i);
		var pycju2_1 = eval('form.pycju2_' + i);
		var pychnm_1 = eval('form.pychnm_' + i);

		if (pychnm_1.value) {
			for (var j = 1; j <= 12; j++) {
				var pycju1_2 = eval('form.pycju1_' + j);
				var pycju2_2 = eval('form.pycju2_' + j);
				var pychnm_2 = eval('form.pychnm_' + j);

				if ((i != j) && (pycju1_1.value == pycju1_2.value) && (pycju2_1.value == pycju2_2.value)) {
					alert(pychnm_1.value + " �԰� " + pychnm_2.value + " ���� �ֹι�ȣ�� �����մϴ�.\n������ �ֽʽÿ�!");
					pycju1_2.focus();
					return;
				}
			}
		}
	}

	//����üũ

	for (var i = 1; i <= 12; i++) {
		var pycchg = eval('form.pycchg_' + i);
		var pychnm = eval('form.pychnm_' + i);
		var pyfchg = eval('form.pyfchg_' + i);
		var pygchg = eval('form.pygchg_' + i);
		var pydchg = eval('form.pydchg_' + i);
		var pyhchg = eval('form.pyhchg_' + i);

		checkMDF(form, i);
		if (pycchg.value == "D" || pyfchg.value == "D" || pydchg.value == "D" || pygchg.value == "D" || pyhchg.value == "D") {
			var strmsg =  " " + pychnm.value + " ���� [�������� �� �⺻/�߰� ����] ��û ������ ����Ǿ����ϴ�!\n\n";
					strmsg += " ����� �׸�� ���õ� [Ư������] ��û������ �ִ� ��� ����â�� �������Ͽ� �ֽʽÿ�!\n\n";
					strmsg += " ��) �ֹε�Ϲ�ȣ ������ �� ����� �ֹε�Ϲ�ȣ�� ����ǵ��� Ư������ ����â ������\n\n";
					strmsg += " ����) ��û ���� ���� ����\n";
					strmsg += "        " + "��Ư������ �Է°� ����(����) �� �⺻(�߰�)���� �Է°� ���� �� �������� ������";
			alert(strmsg);
			if (i > 1) {
				pychnm.focus();
			}
			return;
		}
	}

	calculatePybsto(form); //���ݺ�����
	calculatePybito(form); //������
	calculatePybmto(form); //�Ƿ���
	calculatePybeto(form); //�������
	calculatePybcto(form); //ī����
	calculatePybhto(form); //�����ڱݰ�

	if (chk == "C") {
		var qstn = confirm("�Ű��� �����Ͻðڽ��ϱ�? �����Ŀ��� ������ �� �����ϴ�!");
		if (qstn == false) return;
		else {
			form.submit();
		}
	} else {
		form.submit();
	}
}

//-->
