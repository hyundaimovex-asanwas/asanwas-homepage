<!--

//카드비 계
function calculatePyhcadtot(form, gbn) {
	var pyhcaktot = eval("form.pyhcaktot");
	var pyhcaetot = eval("form.pyhcaetot");
	var pyhcadtot = eval("form.pyhcadtot");
	var pyhhadtot = eval("form.pyhhadtot");
	var pyhmadtot = eval("form.pyhmadtot");

	var pyhca1 = eval("form.pyhca1");
	var pyhca2 = eval("form.pyhca2");
	var pyhha1 = eval("form.pyhha1");
	var pyhha2 = eval("form.pyhha2");
	var pyhma1 = eval("form.pyhma1");

	if (gbn == '1') {
		var pyhcadtot_val = chkValue(pyhca1) + chkValue(pyhca2);
		pyhcadtot.value = addCommaValue(String(pyhcadtot_val));
	} else if (gbn == '2') {
		var pyhhadtot_val = chkValue(pyhha1) + chkValue(pyhha2);
		pyhhadtot.value = addCommaValue(String(pyhhadtot_val));
	} else if (gbn == '3') {
		var pyhmadtot_val = chkValue(pyhma1);
		pyhmadtot.value = addCommaValue(String(pyhmadtot_val));
	}

	pyhcaktot_val = chkValue(pyhca1) + chkValue(pyhha1) + chkValue(pyhma1);
	pyhcaetot_val = chkValue(pyhca2) + chkValue(pyhha2);

	pyhcaktot.value = addCommaValue(String(pyhcaktot_val));
	pyhcaetot.value = addCommaValue(String(pyhcaetot_val));
}

function getValue(form, cgq) {
	var openerPyccg1 = eval("opener.entry.pyccg1_" + cgq);
	var openerPychnm = eval("opener.entry.pychnm_" + cgq);
	var openerPycju1 = eval("opener.entry.pycju1_" + cgq);
	var openerPycju2 = eval("opener.entry.pycju2_" + cgq);

	var Pyhcg1 = eval("form.pyhcg1");
	var Pyhhnm = eval("form.pyhhnm");
	var Pyhju1 = eval("form.pyhju1");
	var Pyhju2 = eval("form.pyhju2");
	var Pyhcgc = eval("form.pyhcgc");
	var Pyhcg1hnm = eval("form.pyhcg1hnm");

	var openerSTS = true;

	if (openerPyccg1 == undefined || openerPyccg1.value == "") openerSTS = false;
	else Pyhcg1.value = openerPyccg1.value;

	if (openerPychnm == undefined || openerPychnm.value == "") openerSTS = false;
	else Pyhhnm.value = openerPychnm.value;

	if (openerPycju1 == undefined || openerPycju1.value == "") openerSTS = false;
	else Pyhju1.value = openerPycju1.value;

	if (openerPycju2 == undefined || openerPycju2.value == "") openerSTS = false;
	else Pyhju2.value = openerPycju2.value;

	if (getCgcCod(openerPyccg1) == "") openerSTS = false;
	else Pyhcgc.value = getCgcCod(openerPyccg1);

	if (getCg1Hnm(openerPyccg1) == "") openerSTS = false;
	else Pyhcg1hnm.value = getCg1Hnm(openerPyccg1);

	if (!openerSTS) {
		alert("공제 대상자 정보가 잘못 되었습니다. 확인해 주세요!");
		self.close();
	}
}

//관계코드 Return
function getCgcCod(openerPyccg1) {
	var pyhcgc;

	if (openerPyccg1.value == '01') {
		pyhcgc = "0";
	} else if (openerPyccg1.value == "03" || openerPyccg1.value == "04" || openerPyccg1.value == "14" || openerPyccg1.value == '15' || openerPyccg1.value == '05' || openerPyccg1.value == "06") {
		pyhcgc = "1";
	} else if (openerPyccg1.value == "16" || openerPyccg1.value == "17" || openerPyccg1.value == "18" || openerPyccg1.value == '19' || openerPyccg1.value == '07' || openerPyccg1.value == "08") {
		pyhcgc = "2";
	} else if (openerPyccg1.value == "02") {
		pyhcgc = "3";
	} else if (openerPyccg1.value == "09" || openerPyccg1.value == "12" || openerPyccg1.value == "13") {
		pyhcgc = "4";
	} else if (openerPyccg1.value == "10" || openerPyccg1.value == "11") {
		pyhcgc = "5";
	} else	pyhcgc = "";

	return pyhcgc;
}

//관계코드명 Return
function getCg1Hnm(openerPyccg1) {
	var pyhcg1hnm;

	if (openerPyccg1.value == "01") {
		pyhcg1hnm = "본인";
	} else if(openerPyccg1.value == "02") {
		pyhcg1hnm = "배우자";
	} else {
		if (openerPyccg1.selectedIndex != 0) {
			pyhcg1hnm = openerPyccg1.options[openerPyccg1.selectedIndex].text;
		} else {
			pyhcg1hnm = "";
		}
	}
	return pyhcg1hnm;
}

function setValue(form, cgq) {
	var openerPyhcaktot = eval("opener.entry.pyhcaktot_" + cgq);
	var openerPyhcaetot = eval("opener.entry.pyhcaetot_" + cgq);
	var pyhcaktot = eval("form.pyhcaktot");
	var pyhcaetot = eval("form.pyhcaetot");

	openerPyhcaktot.value = chkValue(pyhcaktot);
	openerPyhcaetot.value = chkValue(pyhcaetot);
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

function checkForm(form, cgq) {
	var qstn = confirm("[확인]버튼을 누르시면 내용이 저장됩니다!");
	if (qstn == false) return;
	else {
		//카드비 저장
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