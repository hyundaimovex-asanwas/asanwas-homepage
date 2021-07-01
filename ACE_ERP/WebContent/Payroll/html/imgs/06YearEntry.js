<!--

//종(전)근무지 상세 Popup
function sodOpen(form, eyy, emm, egb, gb1, eno, knd) {
	var openwin;

	if (openwin != null) {
		openwin.focus();
	} else {
		url = "/services/payroll/P030009_ofc.jsp?eyy=" + eyy + "&emm=" + emm + "&egb=" + egb + "&gb1=" + gb1 + "&eno=" + eno;
		openwin = window.open(url, "sod", "top=10, left=10, width=800, height=600, status=yes, scrollbars=yes");
	}
}

//보험상세 Popup
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
	//소득요건
	if (pycsod.checked) {
		if (pycjan.checked) {
			openable = "Y";
		} else {
			//본인/배우자
			if (pyccg1.value == "01" || pyccg1.value == "02") {
				openable = "Y";
			//부양가족
			} else {
				//연령요건
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
		//변경체크
 		checkMDF(form, cgq);
		if (pyfchg.value == "D") {
			alert("인적 및 공제사항 정보가 변경되었습니다. 변경된 사항이 반영됩니다!");
		}
		if (openwin != null) {
			openwin.focus();
		} else {
			url = "06YearEntryIns.jsp?eyy=" + eyy + "&emm=" + emm + "&egb=" + egb + "&gb1=" + gb1 + "&eno=" + eno + "&cgq=" + cgq;
			openwin = window.open(url, "ins", "top=10, left=10, width=800, height=610, status=yes, scrollbars=yes");
		}
	} else {
		alert("기본공제 적용자(연령·소득요건충족자)만 보험료 공제를 신청할 수 있습니다!");
		return;
	}
}

//의료상세 Popup
function medOpen(form, eyy, emm, egb, gb1, eno, cgq) {
	var pydchg = eval("form.pydchg_" + cgq);
	var openwin;

	if (openwin != null) {
		openwin.focus();
	} else {
		//변경체크
 		checkMDF(form, cgq);
		if (pydchg.value == "D") {
			alert("인적 및 공제사항 정보가 변경되었습니다. 변경된 사항이 반영됩니다!");
		}
		url = "06YearEntryMed.jsp?eyy=" + eyy + "&emm=" + emm + "&egb=" + egb + "&gb1=" + gb1 + "&eno=" + eno + "&cgq=" + cgq;
		openwin = window.open(url, "med", "top=10, left=3, width=1008, height=610, status=yes, scrollbars=yes");
	}
}

//교육상세 Popup
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
			//직계존속인 경우
			if (pyccg1.value == "03" || pyccg1.value == "04" || pyccg1.value == "14" || pyccg1.value == "15" ||
				  pyccg1.value == "05" || pyccg1.value == "06" || pyccg1.value == "16" || pyccg1.value == "17" ||
					pyccg1.value == "18" || pyccg1.value == "19" || pyccg1.value == "07" || pyccg1.value == "08") {
				openable = "C";
			}
		} else {
			openable = "N";
		}
		//취학생/취학전 구분
		if (age >= 8) {
			knd = "A";
 		} else if (age < 8) {
 			knd = "B";
		} else {
			knd = "";
		}
		if (openable == "Y") {
			//변경체크
			checkMDF(form, cgq);
			if (pygchg.value == "D") {
				alert("인적 및 공제사항 정보가 변경되었습니다. 변경된 사항이 반영됩니다!");
				}
			if (openwin != null) {
				openwin.focus();
			} else {
				url = "06YearEntryEdu.jsp?eyy=" + eyy + "&emm=" + emm + "&egb=" + egb + "&gb1=" + gb1 + "&eno=" + eno + "&cgq=" + cgq + "&knd=" + knd;
				openwin = window.open(url, "edu", "top=10, left=10, width=860, height=635, status=yes, scrollbars=yes");
			}
		} else if (openable == "C") {
			alert("직계존속의 교육비는 공제 신청할 수 없습니다!");
			return;
		} else if (openable == "N") {
			alert("연간소득금액 100만원 이하자만 교육비 공제를 신청할 수 있습니다!");
			return;
		}
	}
}

//카드상세 Popup
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
		//변경체크
 		checkMDF(form, cgq);
		if (pyhchg.value == "D") {
			alert("인적 및 공제사항 정보가 변경되었습니다. 변경된 사항이 반영됩니다!");
		}
		if (openwin != null) {
			openwin.focus();
		} else {
			url = "06YearEntryCad.jsp?eyy=" + eyy + "&emm=" + emm + "&egb=" + egb + "&gb1=" + gb1 + "&eno=" + eno + "&cgq=" + cgq;
			openwin = window.open(url, "cad", "top=10, left=10, width=860, height=610, status=yes, scrollbars=yes");
		}
	} else if (openable == "C") {
		alert("형제·자매의 신용카드 등 사용액은 공제 신청할 수 없습니다!");
		return;
	} else if (openable == "N") {
		alert("연간 소득금액 100만원 이하자만 신용카드 등 공제를 신청할 수 있습니다!");
		return;
	}
}

//기부상세 Popup
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
				alert("외국인등록번호 또는 여권번호가 아닙니다!");
				pycfrn.checked = false;
				return;
			} else {
				alert("외국인등록번호 또는 여권번호를 입력바랍니다!");
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
	//본인 소득공제값
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
			if (confirm("인적공제를 받고자 하는 가족의\n연간 총소득이 없거나 100만원이하일 경우에만 [확인]을 선택합니다!")) {
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
				alert("연간소득금액 100만원 이하 체크 확인을 취소하려면\n[보험료/교육비/신용카드(현금영수증)] 입력값을 먼저 삭제(저장)한 후 체크 표시를 취소해 주십시요!");
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
			alert("장애인 공제 신청을 취소하려면\n[장애인 보험료/교육비] 입력값을 먼저 삭제(저장)한 후 다시 체크 표시를 취소해 주십시요!");
			return;
		}
		if (pydmek.value != 0 || pydmee.value != 0) {
			pycjan.checked = false;
			alert("장애인 공제 신청을 취소하려면\n[장애인의료비]가 [일반/본인/경로의료비]로 변경적용되도록 의료비 상세창을 재저장해 주십시요!");
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
		alert("본인 세대주 여부 선택시만 입력이 가능합니다!");
		form.pybhto.focus();
		return;
	} else {
		if (obj.value == "0") {
			obj.value = "";
		}
	}
}

//코드선택
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

//연금보험료 계
function calculatePybsto(form) {
	var pybsto_val = 0;

	var pyisgmtot = eval("form.pyisgmtot"); //국민연금(종)
	var pybsgm = eval("form.pybsgm"); 			//국민연금(현)
	var pybsto = eval("form.pybsto"); 			//계

	pybsto_val = chkValue(pyisgmtot) + chkValue(pybsgm);
	pybsto.value = addCommaValue(String(pybsto_val));
}

//보험료 계
function calculatePybito(form) {
	var pyfinstot_val = 0;
	var pyfjnstot_val = 0;
	var pybito_val = 0;

	var pyisbhtot = eval("form.pyisbhtot"); //건강보험료(종)
	var pyisgytot = eval("form.pyisgytot"); //고용보험료(종)
	var pybsbh = eval("form.pybsbh"); 			//건강보험료(현)
	var pybsgy = eval("form.pybsgy"); 			//고용보험료(현)
	var pybins = eval("form.pybins"); 			//일반보험료
	var pybin2 = eval("form.pybin2"); 			//장애인보험료
	var pybito = eval("form.pybito"); 			//계

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

//의료비 계
function calculatePybmto(form) {
	var pybmsd = eval("form.pybmsd"); //본경장의료비
	var pybmgd = eval("form.pybmgd"); //일반의료비
	var pybmtc = eval("form.pybmtc"); //카드의료비
	var pybmtm = eval("form.pybmtm"); //현금의료비
	var pybmto = eval("form.pybmto"); //의료비계

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

//교육비 계
function calculatePybeto(form) {
	var pybsed = eval("form.pybsed"); //본인교육비
	var pybebc = eval("form.pybebc"); //취학전인원
	var pybebt = eval("form.pybebt"); //취학전교육비
	var pybecc = eval("form.pybecc"); //초중고인원
	var pybect = eval("form.pybect"); //초중고교육비
	var pybedc = eval("form.pybedc"); //대학생인원
	var pybedt = eval("form.pybedt"); //대학생교육비
	var pybetc = eval("form.pybetc"); //장애인인원
	var pybets = eval("form.pybets"); //장애인교육비
	var pybeto = eval("form.pybeto"); //교육비계

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

//주택자금 계
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

//신용카드 계
function calculatePybcto(form) {
	var pybcad = eval("form.pybcad"); //신용카드비
	var pybhnd = eval("form.pybhnd"); //현금영수증비
	var pybsgd = eval("form.pybsgd"); //학원비
	var pybmex = eval("form.pybmex"); //의료비중복공제배제
	var pybcto = eval("form.pybcto"); //신용카드등 계

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

	//배우자
	if (pyccg1.value == '02') {
		if (!pychnm.value) {
			alert("배우자 성명을 입력해 주세요!");
			return;
		}
		if (!pycju1.value || !pycju2.value) {
			alert("배우자 주민등록번호를 입력해 주세요!");
			if (!pycju1.value) {
				pycju1.focus();
			} else {
				pycju2.focus();
			}
			return;
		}
		if (pycju1.value) {
			if (!IsIntegerNumber(pycju1.value)) {
				alert("배우자 주민등록번호를 숫자로 입력해 주세요!");
				pycju1.focus();
				return;
			}
			if (pycju1.value.length != 6) {
				alert("배우자 주민등록번호를 올바르게 입력해 주세요!");
				pycju1.focus();
				return;
			}
		}
		if (pycju2.value) {
			if (!IsIntegerNumber(pycju2.value)) {
				alert("배우자 주민등록번호를 숫자로 입력해 주세요!");
				pycju2.focus();
				return;
			}
			if (pycju2.value.length != 7) {
				alert("배우자 주민등록번호를 올바르게 입력해 주세요!");
				pycju2.focus();
				return;
			}
		}
		if (pycju2.value.substring(0, 1) == 1 || pycju2.value.substring(0, 1) == 2 || pycju2.value.substring(0, 1) == 3 || pycju2.value.substring(0, 1) == 4) {
			if (!IsKoreanSSN(pycju1.value, pycju2.value)) {
				alert("배우자 주민등록번호를 올바르게 입력해 주세요!");
				pycju1.focus();
				return;
			}
		} else if (pycju2.value.substring(0, 1) == 5 || pycju2.value.substring(0, 1) == 6 || pycju2.value.substring(0, 1) == 7 || pycju2.value.substring(0, 1) == 8) {
			if (!IsForeignerSSN(pycju1.value, pycju2.value)) {
				alert("배우자 주민등록번호를 올바르게 입력해 주세요!");
				pycju1.focus();
				return;
			}
		}
	}
	//가족
	if (pyccg1.value != 01 && pyccg1.value != 02) {
		if (!pychnm.value) {
			alert("가족 성명을 입력해 주세요!");
			return;
		}
		if (pychnm.value) {
			if (!pyccg1.selectedIndex) {
				alert("가족 관계를 선택해 주세요!");
				pyccg1.focus();
				return;
			}
			if (!pycju1.value || !pycju2.value) {
				alert(pychnm.value + " 님의 주민등록번호를 입력해 주세요!");
				if(!pycju1.value) {
					pycju1.focus();
				} else {
					pycju2.focus();
				}
				return;
			}
			if (pycju1.value) {
				if (!IsIntegerNumber(pycju1.value)) {
					alert(pychnm.value + " 님의 주민등록번호를 숫자로 입력해 주세요!");
					pycju1.focus();
					return;
				}
				if (pycju1.value.length != 6) {
					alert(pychnm.value + " 님의 주민등록번호를 올바르게 입력해 주세요!");
					pycju1.focus();
					return;
				}
			}
			if (pycju2.value) {
				if (!IsIntegerNumber(pycju2.value)) {
					alert(pychnm.value + " 님의 주민등록번호를 숫자로 입력해 주세요!");
					pycju2.focus();
					return;
				}
				if (pycju2.value.length != 7) {
					alert(pychnm.value + " 님의 주민등록번호를 올바르게 입력해 주세요!");
					pycju2.focus();
					return;
				}
			}
			if (pycju2.value.substring(0, 1) == 1 || pycju2.value.substring(0, 1) == 2 || pycju2.value.substring(0, 1) == 3 || pycju2.value.substring(0, 1) == 4) {
				if (!IsKoreanSSN(pycju1.value, pycju2.value)) {
					alert(pychnm.value + " 님의 주민등록번호를 올바르게 입력해 주세요!");
					pycju1.focus();
					return;
				}
			} else if (pycju2.value.substring(0, 1) == 5 || pycju2.value.substring(0, 1) == 6 || pycju2.value.substring(0, 1) == 7 || pycju2.value.substring(0, 1) == 8) {
				if (!IsForeignerSSN(pycju1.value, pycju2.value)) {
					alert(pychnm.value + " 님의 주민등록번호를 올바르게 입력해 주세요!");
					pycju1.focus();
					return;
				}
			}
		}
	}

	//동일 주민번호 체크

	for (var i = 1; i <= 12; i++) {
		var pycju1_1 = eval('form.pycju1_' + i);
		var pycju2_1 = eval('form.pycju2_' + i);
		var pychnm_1 = eval('form.pychnm_' + i);

		if ((i != cgq) && (pycju1.value == pycju1_1.value) && (pycju2.value == pycju2_1.value)) {
			alert(pychnm.value + " 님과 " + pychnm_1.value + " 님의 주민번호가 동일합니다.\n수정해 주십시요!");
			pycju1.focus();
			return;
		}
	}
}

function checkForm(form, chk) {

	form.pybchk.value = chk;

	//인적공제

	//본인부녀자 활성화
	form.pycnea_1.disabled = false;

	//장애인 활성화
	for (var i = 1; i <= 12; i++) {
		var pycjan = eval('form.pycjan_' + i);
		pycjan.disabled = false;
	}

	//경로우대 활성화
	for (var i = 1; i <= 12; i++) {
		var pycol1 = eval('form.pycol1_' + i);
		var pycol2 = eval('form.pycol2_' + i);
		pycol1.disabled = false;
		pycol2.disabled = false;
	}

	//자녀양육 활성화
	var strmsg = "6세 이하 자녀에 대한 자녀양육비 공제를 신청하지 않았습니다.\n\n";
			strmsg += " ① 공제신청 : [확인] 누르고 자녀양육비란에 (√) 표시 바랍니다.\n";
			strmsg += " ② 공제신청 안함 : 동 메세지창 내용을 무시하고 [취소] 누르고 내용저장 하시면 됩니다.";

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

	//혼인, 장례, 이사 활성화
	form.pyba01.disabled = false;
	form.pyba01.disabled = false;
	form.pyba03.disabled = false;

	//배우자
	if (form.pychnm_2.value) {
		if (!form.pycju1_2.value || !form.pycju2_2.value) {
			alert("배우자 주민등록번호를 입력해 주세요!");
			if (!form.pycju1_2.value) {
				form.pycju1_2.focus();
			} else {
				form.pycju2_2.focus();
			}
			return;
		}
		if (form.pycju1_2.value) {
			if (!IsIntegerNumber(form.pycju1_2.value)) {
				alert("배우자 주민등록번호를 숫자로 입력해 주세요!");
				form.pycju1_2.focus();
				return;
			}
			if (form.pycju1_2.value.length != 6) {
				alert("배우자 주민등록번호를 올바르게 입력해 주세요!");
				form.pycju1_2.focus();
				return;
			}
		}
		if (form.pycju2_2.value) {
			if (!IsIntegerNumber(form.pycju2_2.value)) {
				alert("배우자 주민등록번호를 숫자로 입력해 주세요!");
				form.pycju2_2.focus();
				return;
			}
			if (form.pycju2_2.value.length != 7) {
				alert("배우자 주민등록번호를 올바르게 입력해 주세요!");
				form.pycju2_2.focus();
				return;
			}
		}
		if (form.pycju2_2.value.substring(0, 1) == 1 || form.pycju2_2.value.substring(0, 1) == 2 || form.pycju2_2.value.substring(0, 1) == 3 || form.pycju2_2.value.substring(0, 1) == 4) {
			if (!IsKoreanSSN(form.pycju1_2.value, form.pycju2_2.value)) {
				alert("배우자 주민등록번호를 올바르게 입력해 주세요!");
				form.pycju1_2.focus();
				return;
			}
		} else if (form.pycju2_2.value.substring(0, 1) == 5 || form.pycju2_2.value.substring(0, 1) == 6 || form.pycju2_2.value.substring(0, 1) == 7 || form.pycju2_2.value.substring(0, 1) == 8) {
			if (!IsForeignerSSN(form.pycju1_2.value, form.pycju2_2.value)) {
				alert("배우자 주민등록번호를 올바르게 입력해 주세요!");
				form.pycju1_2.focus();
				return;
			}
		}
	}

	//가족
	for (i = 3; i <= 12; i++) {
		var pyccg1 = eval('form.pyccg1_' + i);
		var pychnm = eval('form.pychnm_' + i);
		var pycju1 = eval('form.pycju1_' + i);
		var pycju2 = eval('form.pycju2_' + i);
		var pycadr = eval('form.pycadr_' + i);
		if (pychnm.value) {
			if (!pyccg1.selectedIndex) {
				alert("가족 관계를 선택해 주세요!");
				pyccg1.focus();
				return;
			}
			if (!pycju1.value || !pycju2.value) {
				alert("가족 주민등록번호를 입력해 주세요!");
				if(!pycju1.value) {
					pycju1.focus();
				} else {
					pycju2.focus();
				}
				return;
			}
			if (pycju1.value) {
				if (!IsIntegerNumber(pycju1.value)) {
					alert(pychnm.value + " 님의 주민등록번호를 숫자로 입력해 주세요!");
					pycju1.focus();
					return;
				}
				if (pycju1.value.length != 6) {
					alert(pychnm.value + " 님의 주민등록번호를 올바르게 입력해 주세요!");
					pycju1.focus();
					return;
				}
			}
			if (pycju2.value) {
				if (!IsIntegerNumber(pycju2.value)) {
					alert(pychnm.value + " 님의 주민등록번호를 숫자로 입력해 주세요!");
					pycju2.focus();
					return;
				}
				if (pycju2.value.length != 7) {
					alert(pychnm.value + " 님의 주민등록번호를 올바르게 입력해 주세요!");
					pycju2.focus();
					return;
				}
			}
			if (pycju2.value.substring(0, 1) == 1 || pycju2.value.substring(0, 1) == 2 || pycju2.value.substring(0, 1) == 3 || pycju2.value.substring(0, 1) == 4) {
				if (!IsKoreanSSN(pycju1.value, pycju2.value)) {
					alert(pychnm.value + " 님의 주민등록번호를 올바르게 입력해 주세요!");
					pycju1.focus();
					return;
				}
			} else if (pycju2.value.substring(0, 1) == 5 || pycju2.value.substring(0, 1) == 6 || pycju2.value.substring(0, 1) == 7 || pycju2.value.substring(0, 1) == 8) {
				if (!IsForeignerSSN(pycju1.value, pycju2.value)) {
					alert(pychnm.value + " 님의 주민등록번호를 올바르게 입력해 주세요!");
					pycju1.focus();
					return;
				}
			}
		}
	}

	//동일 주민번호 체크

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
					alert(pychnm_1.value + " 님과 " + pychnm_2.value + " 님의 주민번호가 동일합니다.\n수정해 주십시요!");
					pycju1_2.focus();
					return;
				}
			}
		}
	}

	//변경체크

	for (var i = 1; i <= 12; i++) {
		var pycchg = eval('form.pycchg_' + i);
		var pychnm = eval('form.pychnm_' + i);
		var pyfchg = eval('form.pyfchg_' + i);
		var pygchg = eval('form.pygchg_' + i);
		var pydchg = eval('form.pydchg_' + i);
		var pyhchg = eval('form.pyhchg_' + i);

		checkMDF(form, i);
		if (pycchg.value == "D" || pyfchg.value == "D" || pydchg.value == "D" || pygchg.value == "D" || pyhchg.value == "D") {
			var strmsg =  " " + pychnm.value + " 님의 [인적사항 및 기본/추가 공제] 신청 정보가 변경되었습니다!\n\n";
					strmsg += " 변경된 항목과 관련된 [특별공제] 신청내용이 있는 경우 세부창을 재저장하여 주십시요!\n\n";
					strmsg += " 예) 주민등록번호 수정시 → 변경된 주민등록번호가 적용되도록 특별공제 세부창 재저장\n\n";
					strmsg += " 참고) 신청 내용 삭제 순서\n";
					strmsg += "        " + "『특별공제 입력값 삭제(저장) → 기본(추가)공제 입력값 삭제 → 인적사항 삭제』";
			alert(strmsg);
			if (i > 1) {
				pychnm.focus();
			}
			return;
		}
	}

	calculatePybsto(form); //연금보험료계
	calculatePybito(form); //보험료계
	calculatePybmto(form); //의료비계
	calculatePybeto(form); //교육비계
	calculatePybcto(form); //카드비계
	calculatePybhto(form); //주택자금계

	if (chk == "C") {
		var qstn = confirm("신고서를 제출하시겠습니까? 제출후에는 수정할 수 없습니다!");
		if (qstn == false) return;
		else {
			form.submit();
		}
	} else {
		form.submit();
	}
}

//-->
