<!--

//보험료계
function calculatePyfinstot(form, gbn) {
	var pyfinktot = eval("form.pyfinktot"); //국세청보험료합
	var pyfinetot = eval("form.pyfinetot"); //그밖의보험료합
	var pyfinstot = eval("form.pyfinstot"); //일반보험료합
	var pyfjnstot = eval("form.pyfjnstot"); //장애보험료합

	var pyfin1 = eval("form.pyfin1");
	var pyfin2 = eval("form.pyfin2");
	var pyfin3 = eval("form.pyfin3");
	var pyfin4 = eval("form.pyfin4");

	var pyfinktot_val = chkValue(pyfin1) + chkValue(pyfin3);
	var pyfinetot_val = chkValue(pyfin2) + chkValue(pyfin4);
	var pyfinstot_val = chkValue(pyfin1) + chkValue(pyfin2);
	var pyfjnstot_val = chkValue(pyfin3) + chkValue(pyfin4);

	if (gbn=='1')	{
		pyfinstot.value = addCommaValue(String(pyfinstot_val));
	} else if (gbn=='2') {
		pyfjnstot.value = addCommaValue(String(pyfjnstot_val));
	}

	pyfinktot.value = addCommaValue(String(pyfinktot_val));
	pyfinetot.value = addCommaValue(String(pyfinetot_val));
}

function getValue(form, cgq) {
	var openerPycchg = eval("opener.entry.pycchg_" + cgq);
	var openerPyccg1 = eval("opener.entry.pyccg1_" + cgq);
	var openerPychnm = eval("opener.entry.pychnm_" + cgq);
	var openerPycju1 = eval("opener.entry.pycju1_" + cgq);
	var openerPycju2 = eval("opener.entry.pycju2_" + cgq);
	var openerPycjan = eval("opener.entry.pycjan_" + cgq);

	var Pyfcg1 = eval("form.pyfcg1");
	var Pyfhnm = eval("form.pyfhnm");
	var Pyfju1 = eval("form.pyfju1");
	var Pyfju2 = eval("form.pyfju2");
	var Pyfcgc = eval("form.pyfcgc");
	var Pyfcg1hnm = eval("form.pyfcg1hnm");

	var openerSTS = true;

	if (openerPyccg1 == undefined || openerPyccg1.value == "") openerSTS = false;
	else Pyfcg1.value = openerPyccg1.value;

	if (openerPychnm == undefined || openerPychnm.value == "") openerSTS = false;
	else Pyfhnm.value = openerPychnm.value;

	if (openerPycju1 == undefined || openerPycju1.value == "") openerSTS = false;
	else Pyfju1.value = openerPycju1.value;

	if (openerPycju2 == undefined || openerPycju2.value == "") openerSTS = false;
	else Pyfju2.value = openerPycju2.value;

	if (getCgcCod(openerPyccg1) == "") openerSTS = false;
	else Pyfcgc.value = getCgcCod(openerPyccg1);

	if (getCg1Hnm(openerPyccg1) == "") openerSTS = false;
	else Pyfcg1hnm.value = getCg1Hnm(openerPyccg1);

	if (openerPycjan == undefined) openerSTS = false;

	if (!openerSTS) {
		alert("공제 대상자 정보가 잘못 되었습니다. 확인해 주세요!");
		self.close();
	}
}

//관계코드 Return
function getCgcCod(openerPyccg1) {
	var pyfcgc;

	if (openerPyccg1.value == '01') {
		pyfcgc = "0";
	} else if (openerPyccg1.value == "03" || openerPyccg1.value == "04" || openerPyccg1.value == "14" || openerPyccg1.value == '15' || openerPyccg1.value == '05' || openerPyccg1.value == "06") {
		pyfcgc = "1";
	} else if (openerPyccg1.value == "16" || openerPyccg1.value == "17" || openerPyccg1.value == "18" || openerPyccg1.value == '19' || openerPyccg1.value == '07' || openerPyccg1.value == "08") {
		pyfcgc = "2";
	} else if (openerPyccg1.value == "02") {
		pyfcgc = "3";
	} else if (openerPyccg1.value == "09" || openerPyccg1.value == "12" || openerPyccg1.value == "13") {
		pyfcgc = "4";
	} else if (openerPyccg1.value == "10" || openerPyccg1.value == "11") {
		pyfcgc = "5";
	} else {
		pyfcgc = "";
	}
	return pyfcgc;
}

//관계코드명 Return
function getCg1Hnm(openerPyccg1) {
	var pyfcg1hnm;

	if (openerPyccg1.value == '01') {
		pyfcg1hnm = "본인";
	} else if(openerPyccg1.value == '02') {
		pyfcg1hnm = "배우자";
	} else {
		if (openerPyccg1.selectedIndex != 0) {
			pyfcg1hnm = openerPyccg1.options[openerPyccg1.selectedIndex].text;
		} else {
			pyfcg1hnm = "";
		}
	}
	return pyfcg1hnm;
}

function setValue(form, cgq) {
	var openerPyfinktot = eval("opener.entry.pyfinktot_" + cgq);
	var openerPyfinetot = eval("opener.entry.pyfinetot_" + cgq);
	var pyfinktot = eval("form.pyfinktot");
	var pyfinetot = eval("form.pyfinetot");

	openerPyfinktot.value = chkValue(pyfinktot);
	openerPyfinetot.value = chkValue(pyfinetot);
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

function checkJAN(obj, cgq) {
	var openerPycjan = eval("opener.entry.pycjan_" + cgq);

	if (!openerPycjan.checked) {
		alert('장애인 여부 체크란에 선택시만 입력이 가능합니다!');
		obj.blur();
	} else {
		clearZero(obj);
	}
}

function printMsg(num) {
	if (num == "1") {
		alert("[(개인)연금저축보험료의 소득공제용 연간 합계액]인 경우 공제 신청할 수 없습니다.\n\n기부금 입력란 아래에 위치한 (개인)연금저축 입력란에 기재바랍니다!");
		return;
	}
	if (num == "2") {
		alert("보험료 납입증명서상 [장애인전용]이라고 표시된 금액만 공제 신청할 수 있습니다!");
		return;
	}
}

function checkForm(form, cgq) {
	var qstn = confirm("[확인]버튼을 누르시면 내용이 저장됩니다!");
	if (qstn == false) return;
	else {
		//보험료 저장
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