<!--

//�Ƿ��Ǽ� ��
function calculatePydcnttot(form, gbn) {
	var pydcn1tot = eval("form.pydcn1tot"); //ī���Ƿ��Ǽ���
	var pydcn2tot = eval("form.pydcn2tot"); //�����Ƿ��Ǽ���
	var pydcn1tot_val = 0;
	var pydcn2tot_val = 0;

	for (var i = 1; i <= 30; i++) {
		var pydcn1 = eval("form.pydcn1_" + i);
		var pydcn2 = eval("form.pydcn2_" + i);
		var pydcn3 = eval("form.pydcn3_" + i);
		var pydcn4 = eval("form.pydcn4_" + i);

		pydcn1tot_val = pydcn1tot_val + chkValue(pydcn1) + chkValue(pydcn2);
		pydcn2tot_val = pydcn2tot_val + chkValue(pydcn3) + chkValue(pydcn4);
	}

	if (gbn == '1')	{
		pydcn1tot.value = addCommaValue(String(pydcn1tot_val));
	} else if (gbn == '2' ) {
		pydcn2tot.value = addCommaValue(String(pydcn2tot_val));
	}
}

//�Ƿ��ݾ� ��
function calculatePydmedtot(form, gbn) {
	var pydmektot = eval("form.pydmektot");	//ī���Ƿ����
	var pydmeetot = eval("form.pydmeetot");	//�����Ƿ����
	var pydme1tot = eval("form.pydme1tot");	//����û�Ƿ����
	var pydme2tot = eval("form.pydme2tot");	//�׹����Ƿ����
	var pydmedtot = eval("form.pydmedtot");	//�Ƿ����
	var pydmektot_val = 0;
	var pydmeetot_val = 0;
	var pydme1tot_val = 0;
	var pydme2tot_val = 0;
	var pydmedtot_val = 0;

	for (var i = 1; i <= 30; i++) {
		var pydme1 = eval("form.pydme1_" + i);
		var pydme2 = eval("form.pydme2_" + i);
		var pydme3 = eval("form.pydme3_" + i);
		var pydme4 = eval("form.pydme4_" + i);

		pydmektot_val = pydmektot_val + chkValue(pydme1) + chkValue(pydme3);
		pydmeetot_val = pydmeetot_val + chkValue(pydme2) + chkValue(pydme4);
		pydme1tot_val = pydme1tot_val + chkValue(pydme1) + chkValue(pydme2);
		pydme2tot_val = pydme2tot_val + chkValue(pydme3) + chkValue(pydme4);
	}

	if (gbn == '1')	{
		pydme1tot.value = addCommaValue(String(pydme1tot_val));
	} else if (gbn == '2') {
		pydme2tot.value = addCommaValue(String(pydme2tot_val));
	}

	pydmektot.value = addCommaValue(String(pydmektot_val));
	pydmeetot.value = addCommaValue(String(pydmeetot_val));
	pydmedtot.value = addCommaValue(String(pydme1tot_val + pydme2tot_val));
}

function getValue(form, cgq) {
	var openerPyccg1 = eval("opener.entry.pyccg1_" + cgq);
	var openerPychnm = eval("opener.entry.pychnm_" + cgq);
	var openerPycju1 = eval("opener.entry.pycju1_" + cgq);
	var openerPycju2 = eval("opener.entry.pycju2_" + cgq);
	var openerPycjan = eval("opener.entry.pycjan_" + cgq);
	var openerPycold = eval("opener.entry.pycold_" + cgq);

	var openerSTS = true;

	for (var i = 1; i <= 30; i++) {
		var Pydcg1 = eval('form.pydcg1_' + i);
		var Pydhnm = eval('form.pydhnm_' + i);
		var Pydju1 = eval('form.pydju1_' + i);
		var Pydju2 = eval('form.pydju2_' + i);
		var Pydcgc = eval('form.pydcgc_' + i);
		var Pydknd = eval('form.pydknd_' + i);
		var Pydkndhnm = eval('form.pydkndhnm_' + i);
		var Pydcg1hnm = eval('form.pydcg1hnm_' + i);

		if (openerPyccg1 == undefined || openerPyccg1.value == "") openerSTS = false;
		else Pydcg1.value = openerPyccg1.value;

		if (openerPychnm == undefined || openerPychnm.value == "") openerSTS = false;
		else Pydhnm.value = openerPychnm.value;

		if (openerPycju1 == undefined || openerPycju1.value == "") openerSTS = false;
		else Pydju1.value = openerPycju1.value;

		if (openerPycju2 == undefined || openerPycju2.value == "") openerSTS = false;
		else Pydju2.value = openerPycju2.value;

		if (getCgcCod(openerPyccg1) == "") openerSTS = false;
		else Pydcgc.value = getCgcCod(openerPyccg1);

		if (getCg1Hnm(openerPyccg1) == "") openerSTS = false;
		else Pydcg1hnm.value = getCg1Hnm(openerPyccg1);

		if (openerPycjan == undefined) openerSTS = false;
		if (openerPycold == undefined) openerSTS = false;

		if (openerSTS) {
			//����/���/����Ƿ��
			if (openerPyccg1.value == '01' || openerPycjan.checked || openerPycold.checked) {
				if (openerPycold.checked) {
					Pydknd.value = "2";
					Pydkndhnm.value = "���";
				}
				if (openerPycjan.checked) {
					Pydknd.value = "3";
					Pydkndhnm.value = "���";
				}
				if (openerPyccg1.value == '01') {
					Pydknd.value = "1";
					Pydkndhnm.value = "����";
				}
			//�Ϲ��Ƿ��
			} else {
				Pydknd.value = "4";
				Pydkndhnm.value = "�Ϲ�";
			}
		}
	}
	if (!openerSTS) {
		alert("���� ����� ������ �߸� �Ǿ����ϴ�. Ȯ���� �ּ���!");
		self.close();
	}
}

//�����ڵ� Return
function getCgcCod(openerPyccg1) {
	var pydcgc;

	if (openerPyccg1.value == '01') {
		pydcgc = "0";
	} else if (openerPyccg1.value == "03" || openerPyccg1.value == "04" || openerPyccg1.value == "14" || openerPyccg1.value == '15' || openerPyccg1.value == '05' || openerPyccg1.value == "06") {
		pydcgc = "1";
	} else if (openerPyccg1.value == "16" || openerPyccg1.value == "17" || openerPyccg1.value == "18" || openerPyccg1.value == '19' || openerPyccg1.value == '07' || openerPyccg1.value == "08") {
		pydcgc = "2";
	} else if (openerPyccg1.value == "02") {
		pydcgc = "3";
	} else if (openerPyccg1.value == "09" || openerPyccg1.value == "12" || openerPyccg1.value == "13") {
		pydcgc = "4";
	} else if (openerPyccg1.value == "10" || openerPyccg1.value == "11") {
		pydcgc = "5";
	} else	pydcgc = "";

	return pydcgc;
}

//�����ڵ�� Return
function getCg1Hnm(openerPyccg1) {
	var pydcg1hnm;

	if (openerPyccg1.value == '01') {
		pydcg1hnm = "����";
	} else if(openerPyccg1.value == '02') {
		pydcg1hnm = "�����";
	} else {
		if (openerPyccg1.selectedIndex != 0) {
			pydcg1hnm = openerPyccg1.options[openerPyccg1.selectedIndex].text;
		} else {
			pydcg1hnm = "";
		}
	}
	return pydcg1hnm;
}

function setValue(form, cgq) {
	var openerPydmektot = eval("opener.entry.pydmektot_" + cgq);
	var openerPydmeetot = eval("opener.entry.pydmeetot_" + cgq);
	var pydmektot = eval("form.pydmektot");
	var pydmeetot = eval("form.pydmeetot");

	openerPydmektot.value = chkValue(pydmektot);
	openerPydmeetot.value = chkValue(pydmeetot);
}

function chkValue(obj) {
	var obj_val;

	obj_val = 0;

	if (obj == undefined || obj.value == "NaN" || obj.value == "") {
		obj_val = 0;
	} else {
		obj_val = parseInt(removeCommaValue(obj.value));
	}

	return obj_val;
}

function checkForm(form, cgq) {
	for (var i = 1; i <= 30; i++) {
		var pydsno = eval('form.pydsno_' + i);
		var pydshm = eval('form.pydshm_' + i);
		var pydcn1 = eval('form.pydcn1_' + i);
		var pydme1 = eval('form.pydme1_' + i);
		var pydcn2 = eval('form.pydcn2_' + i);
		var pydme2 = eval('form.pydme2_' + i);
		var pydcn3 = eval('form.pydcn3_' + i);
		var pydme3 = eval('form.pydme3_' + i);
		var pydcn4 = eval('form.pydcn4_' + i);
		var pydme4 = eval('form.pydme4_' + i);
		var pydhnm = eval('form.pydhnm_' + i);
		var pydcg1 = eval('form.pydcg1_' + i);
		var pydju1 = eval('form.pydju1_' + i);
		var pydju2 = eval('form.pydju2_' + i);

		if ((pydme1.value && pydme1.value != 0) || (pydme2.value && pydme2.value != 0) || (pydme3.value && pydme3.value != 0) || (pydme4.value && pydme4.value != 0)) {
			if (!pydsno.value) {
				alert('����ڹ�ȣ�� �Է��� �ּ���!');
				pydsno.focus();
				return;
			}
			if (pydsno.value.length != 12) {
				alert('����ڹ�ȣ�� ���Ŀ� �°� �Է��� �ּ���!\n����)XXX-XX-XXXXX');
				pydsno.focus();
				return;
			}
			if (!IsNumber(pydsno.value) || pydsno.value.substring(3, 4) != '-' || pydsno.value.substring(6, 7) != '-') {
				alert('����ڹ�ȣ�� ���Ŀ� �°� �Է��� �ּ���!\n����)XXX-XX-XXXXX');
				pydsno.focus();
				return;
			}
			if (!IsCOMPANYSSN(removeMinus(pydsno))) {
				alert('����ڹ�ȣ�� �ùٸ��� �Է��� �ּ���!');
				pydsno.focus();
				return;
			}
			if (!pydshm.value) {
				alert('��ȣ�� �Է��� �ּ���!');
				pydshm.focus();
				return;
			}
			if (pydshm.value == "��" || pydshm.value == "����" || pydshm.value == "\"") {
				alert('��ȣ�� �ùٸ��� �Է��� �ּ���!');
				pydshm.focus();
				return;
			}
			if (!IsKor(pydshm.value)) {
				alert('��ȣ�� �ѱ۷� �Է��� �ּ���!');
				pydshm.focus();
				return;
			}
			if ((pydme1.value && pydme1.value != 0)) {
				if (!pydcn1.value || pydcn1.value == 0) {
					alert('����û�ڷ� �ſ�ī��Ǽ��� �Է��� �ּ���!');
					pydcn1.focus();
					return;
				}
			}
			if ((pydme2.value && pydme2.value != 0)) {
				if (!pydcn2.value || pydcn2.value == 0) {
					alert('�׹����ڷ� �ſ�ī��Ǽ��� �Է��� �ּ���!');
					pydcn2.focus();
					return;
				}
			}
			if ((pydme3.value && pydme3.value != 0)) {
				if (!pydcn3.value || pydcn3.value == 0) {
					alert('����û�ڷ� ���ݰǼ��� �Է��� �ּ���!');
					pydcn3.focus();
					return;
				}
			}
			if ((pydme4.value && pydme4.value != 0)) {
				if (!pydcn4.value || pydcn4.value == 0) {
					alert('�׹����ڷ� ���ݰǼ��� �Է��� �ּ���!');
					pydcn3.focus();
					return;
				}
			}
			if (!pydhnm.value) {
				alert('����� �̸��� �Է��� �ּ���!');
				pydhnm.focus();
				return;
			}
			if (pydhnm.value == "��" || pydhnm.value == "����" || pydhnm.value == "\"") {
				alert('����� �̸��� ��Ȯ�ϰ� �Է��� �ּ���!');
				pydhnm.focus();
				return;
			}
			if (!pydju1.value || !pydju2.value) {
				alert('����� �ֹε�Ϲ�ȣ�� �Է��� �ּ���!');
				if(!pydju1.value) {
					pydju1.focus();
				} else {
					pydju2.focus();
				}
				return;
			}
			if (pydju1.value) {
				if (!IsIntegerNumber(pydju1.value)) {
					alert('����� �ֹε�Ϲ�ȣ�� ���ڷ� �Է��� �ּ���!');
					pydju1.focus();
					return;
				}
				if (pydju1.value.length != 6) {
					alert('����� �ֹε�Ϲ�ȣ�� �ùٸ��� �Է��� �ּ���!');
					pydju1.focus();
					return;
				}
			}
			if (pydju2.value) {
				if (!IsIntegerNumber(pydju2.value)) {
					alert('����� �ֹε�Ϲ�ȣ�� ���ڷ� �Է��� �ּ���!');
					pydju2.focus();
					return;
				}
				if (pydju2.value.length != 7) {
					alert('����� �ֹε�Ϲ�ȣ�� �ùٸ��� �Է��� �ּ���!');
					pydju2.focus();
					return;
				}
			}
			if (!IsKoreanSSN(pydju1.value, pydju2.value)) {
				alert('����� �ֹε�Ϲ�ȣ�� �ùٸ��� �Է��� �ּ���!');
				pydju1.focus();
				return;
			}
		}
	} //for

	var qstn = confirm("[Ȯ��]��ư�� �����ø� ������ ����˴ϴ�!");
	if (qstn == false) return;
	else {
		//�Ƿ�� ����
		form.submit();

		setValue(form, cgq);

		//OPENER ����
		var openerForm = eval("opener.document.entry");
		openerForm.pybchk.value = "T";
		openerForm.submit();

		window.close();
	}
}

//-->