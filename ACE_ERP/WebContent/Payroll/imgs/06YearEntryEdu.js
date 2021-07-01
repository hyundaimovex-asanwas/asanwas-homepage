<!--

//교육비 계
function calculatePygedutot(form, gbn) {
	var pygedktot = eval("form.pygedktot"); //국세청교육비
	var pygedetot = eval("form.pygedetot"); //그밖의교육비
	var pyged1tot = eval("form.pyged1tot"); //보육비/초중고비
	var pyged2tot = eval("form.pyged2tot"); //학원비/대학생비
	var pyged3tot = eval("form.pyged3tot"); //장애인특수교육비

	var pyged1 = eval("form.pyged1");
	var pyged2 = eval("form.pyged2");
	var pyged3 = eval("form.pyged3");
	var pyged4 = eval("form.pyged4");
	var pyged5 = eval("form.pyged5");
	var pyged6 = eval("form.pyged6");

	if (gbn == '1') {
		var pyged1tot_val = chkValue(pyged1) + chkValue(pyged2);
		pyged1tot.value = addCommaValue(String(pyged1tot_val));
	} else if (gbn == '2') {
		var pyged2tot_val = chkValue(pyged3) + chkValue(pyged4);
		pyged2tot.value = addCommaValue(String(pyged2tot_val));
	} else if (gbn == '3') {
		var pyged3tot_val = chkValue(pyged5) + chkValue(pyged6);
		pyged3tot.value = addCommaValue(String(pyged3tot_val));
	}

	pygedktot_val = chkValue(pyged1) + chkValue(pyged3) + chkValue(pyged5);
	pygedetot_val = chkValue(pyged2) + chkValue(pyged4) + chkValue(pyged6);

	pygedktot.value = addCommaValue(String(pygedktot_val));
	pygedetot.value = addCommaValue(String(pygedetot_val));
}

function getValue(form, cgq, sav) {
	var openerPyccg1 = eval("opener.entry.pyccg1_" + cgq);
	var openerPychnm = eval("opener.entry.pychnm_" + cgq);
	var openerPycju1 = eval("opener.entry.pycju1_" + cgq);
	var openerPycju2 = eval("opener.entry.pycju2_" + cgq);
	var openerPycjan = eval("opener.entry.pycjan_" + cgq);

	//가족사항
	var Pygcg1 = eval("form.pygcg1");
	var Pyghnm = eval("form.pyghnm");
	var Pygju1 = eval("form.pygju1");
	var Pygju2 = eval("form.pygju2");
	var Pygcgc = eval("form.pygcgc");
	var Pygcg1hnm = eval("form.pygcg1hnm");

	var openerSTS = true;

	if (openerPyccg1 == undefined || openerPyccg1.value == "") openerSTS = false;
	else Pygcg1.value = openerPyccg1.value;

	if (openerPychnm == undefined || openerPychnm.value == "") openerSTS = false;
	else Pyghnm.value = openerPychnm.value;

	if (openerPycju1 == undefined || openerPycju1.value == "") openerSTS = false;
	else Pygju1.value = openerPycju1.value;

	if (openerPycju2 == undefined || openerPycju2.value == "") openerSTS = false;
	else Pygju2.value = openerPycju2.value;

	if (getCgcCod(openerPyccg1) == "") openerSTS = false;
	else Pygcgc.value = getCgcCod(openerPyccg1);

	if (getCg1Hnm(openerPyccg1) == "") openerSTS = false;
	else Pygcg1hnm.value = getCg1Hnm(openerPyccg1);

	if (openerPycjan == undefined) openerSTS = false;

	if (!openerSTS) {
		alert("공제 대상자 정보가 잘못 되었습니다. 확인해 주세요!");
		self.close();
	}
}

//관계코드 Return
function getCgcCod(openerPyccg1) {
	var pygcgc;

	if (openerPyccg1.value == '01') {
		pygcgc = "0";
	} else if (openerPyccg1.value == "03" || openerPyccg1.value == "04" || openerPyccg1.value == "14" || openerPyccg1.value == '15' || openerPyccg1.value == '05' || openerPyccg1.value == "06") {
		pygcgc = "1";
	} else if (openerPyccg1.value == "16" || openerPyccg1.value == "17" || openerPyccg1.value == "18" || openerPyccg1.value == '19' || openerPyccg1.value == '07' || openerPyccg1.value == "08") {
		pygcgc = "2";
	} else if (openerPyccg1.value == "02") {
		pygcgc = "3";
	} else if (openerPyccg1.value == "09" || openerPyccg1.value == "12" || openerPyccg1.value == "13") {
		pygcgc = "4";
	} else if (openerPyccg1.value == "10" || openerPyccg1.value == "11") {
		pygcgc = "5";
	} else	pygcgc = "";

	return pygcgc;
}

//관계코드명 Return
function getCg1Hnm(openerPyccg1) {
	var pygcg1hnm;

	if (openerPyccg1.value == '01') {
		pygcg1hnm = "본인";
	} else if(openerPyccg1.value == '02') {
		pygcg1hnm = "배우자";
	} else {
		if (openerPyccg1.selectedIndex != 0) {
			pygcg1hnm = openerPyccg1.options[openerPyccg1.selectedIndex].text;
		} else {
			pygcg1hnm = "";
		}
	}
	return pygcg1hnm;
}

function setValue(form, cgq) {
	var openerPygedktot = eval("opener.entry.pygedktot_" + cgq);
	var openerPygedetot = eval("opener.entry.pygedetot_" + cgq);
	var pygedktot = eval("form.pygedktot");
	var pygedetot = eval("form.pygedetot");
alert(pygedktot.value);
alert(cgq);
	openerPygedktot.value = chkValue(pygedktot);
	openerPygedetot.value = chkValue(pygedetot);
}

function chkValue(obj) {
	var obj_val;

	if (obj == undefined || obj.value == "NaN" || obj.value == "") {
		obj_val = 0;
	} else {
		obj_val = parseInt(removeCommaValue(obj.value));
	}
	return obj_val;
}


function printMsg(knd, num) {
	if (knd == "A") {
		if (num == "1") {
			alert("학생의 사설학원비는 공제 신청할 수 없습니다!");
			return;
		}
		if (num == "2") {
			alert("가족의 사설학원비(본인 포함) 및 대학원비는 공제 신청할 수 없습니다!");
			return;
		}
	} else if (knd == "B") {
		if (num == "1") {
			alert("선교원/문화센터(사회복지관) 이용료, 놀이교육비(짐보리 등), 학습지 구독료\n등은 공제 신청할 수 없습니다!");
			return;
		}
		if (num == "2") {
			alert("태권도장, 수영장, 에어로빅 등 체육시설비는 공제 신청할 수 없습니다!");
			return;
		}
	}
}

function checkJAN(obj, cgq) {
	var openerPycjan = eval("opener.entry.pycjan_" + cgq);

	if (!openerPycjan.checked) {
		alert('장애인 여부 체크란에 선택시만 입력이 가능합니다!');
		obj.blur();
	} else {
		clearZero(obj);
	}
}

function checkForm(form, cgq) {
	var qstn = confirm("[확인]버튼을 누르시면 내용이 저장됩니다!");
	if (qstn == false) return;
	else {
		//교육비 저장
		form.submit();

		setValue(form, cgq);

		//OPENER 저장
		var openerForm = eval("opener.document.entry");
		openerForm.pybchk.value = "T";
		openerForm.submit();

		window.close();
	}
}

//-->