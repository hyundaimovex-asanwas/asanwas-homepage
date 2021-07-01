<!--
function MM_findObj(n, d) { //v4.0
	var p,i,x; if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
		d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
	if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
	if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_showHideLayers() { //v3.0
	var i,p,v,obj,args=MM_showHideLayers.arguments;
	for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
		if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v='hide')?'hidden':v; }
		obj.visibility=v; }
}

function MM_swapImgRestore() { //v3.0
	var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
	var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
		var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
		if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImage() { //v3.0
	var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
	if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function MM_jumpMenu(targ,selObj,restore){ //v3.0
	eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
	if (restore) selObj.selectedIndex=0;
}

function preStep() {
	history.back(-1);
}

function tip(txt) {
	if (txt) {
		document.all.tipbox.innerHTML = "<table><tr><td>" + txt + "</td></tr></table>";
		tipbox.style.pixelLeft = (event.x + document.body.scrollLeft + 40);
		tipbox.style.pixelTop = (event.y + document.body.scrollTop);
		tipbox.style.visibility = "visible";
	} else {
		tipbox.style.visibility = "hidden";
	}
}

function tip1(txt) {
	if (txt) {
		tipbox.innerText = txt;
		tipbox.style.left = event.x + 40;
		tipbox.style.top = document.body.scrollTop + event.clientY - 30;
		tipbox.style.height = 18;
		tipbox.style.display = '';
	} else {
		tipbox.style.display='none';
	}
}

//날짜에 "-" 를 자동으로 넣는다.
function formatYYYYMMDD(form) {
	var frmval = form.value;
	if (window.event.keyCode != "8") {
		if (frmval.length == 4) {
			form.value = frmval + "-";
		}
		if (frmval.length == 7) {
			if (parseInt(frmval.substring(5, 7)) > 12) {
				alert("월을 정확히 입력해 주세요!");
				form.value = frmval.substring(0, 5)
				form.focus();
			} else{
				form.value = frmval + "-";
			}
		}
		if (frmval.length == 10) {
			if (parseInt(frmval.substring(8, 10)) > 31) {
				alert("일을 정확히 입력해 주세요!");
				form.value = frmval.substring(0, 8)
				form.focus();
			}
		}
	}
}

//사업자번호형식 "-" 를 자동으로 넣는다.
function formatCompany(form) {
	var frmval = form.value;
	if (window.event.keyCode != "8") {
		if (frmval.length == 3) {
			form.value = frmval + "-";
		}
		if (frmval.length == 6) {
			form.value = frmval + "-";
		}
	}
}

//주민번호형식 "-" 를 자동으로 넣는다.
function formatKorean(form) {
	var frmval = form.value;
	if (window.event.keyCode != "8") {
		if (frmval.length == 6) {
			form.value = frmval + "-";
		}
	}
}

function formatRealNumber(form) {
	var frmval = form.value;
	if (frmval.length == 1) {
		form.value = frmval + ".";
	}
}

function setZero(form) {
	form.value = "0";
}

function clearZero(form) {
	if (form.value == "0") {
		form.value = "";
	}
}

function addComma(form) {
	var frmval = form.value;
	if (frmval.length >= 4) {
		re = /^$|,/g;
		frmval = frmval.replace(re, "");
		fl = "";
		if (isNaN(frmval)) {
			alert("문자는 사용할 수 없습니다.");
			return 0;
		}
		if (frmval == 0) return frmval;
		if (frmval < 0) {
			frmval = frmval * (-1);
			fl = "-";
		} else {
			frmval = frmval * 1; //처음 입력값이 0부터 시작할때 이것을 제거한다.
		}
		frmval = new String(frmval);
		temp = "";
		co = 3;
		var frmval_len = frmval.length;
		while (frmval_len > 0) {
			frmval_len = frmval_len - co;
			if (frmval_len < 0) {
				co = frmval_len + co;
				frmval_len = 0;
			}
			temp = "," + frmval.substr(frmval_len, co) + temp;
		}
		form.value = fl + temp.substr(1);
	}
}

/**
 * 입력값에서 콤마를 없앤다.
 */
function removeComma(form) {
	return form.value.replace(/,/gi, "");
}

function removeMinus(form) {
	return form.value.replace(/-/gi, "");
}

function addCommaValue(formvalue) {
	var frmval = formvalue;
	if (frmval.length >= 4) {
		re = /^$|,/g;
		frmval = frmval.replace(re, "");
		fl = "";
		if (isNaN(frmval)) {
			alert("문자는 사용할 수 없습니다.");
			return 0;
		}
		if (frmval == 0) return frmval;
		if (frmval < 0) {
			frmval = frmval * (-1);
			fl = "-";
		} else {
			frmval = frmval * 1; //처음 입력값이 0부터 시작할때 이것을 제거한다.
		}
		frmval = new String(frmval);
		temp = "";
		co = 3;
		var frmval_len = frmval.length;
		while (frmval_len > 0) {
			frmval_len = frmval_len - co;
			if (frmval_len < 0) {
				co = frmval_len + co;
				frmval_len = 0;
			}
			temp = "," + frmval.substr(frmval_len, co) + temp;
		}
		return fl + temp.substr(1);
	} else {
		return formvalue;
	}
}

/**
 * 입력값에서 콤마를 없앤다.
 */
function removeCommaValue(formvalue) {
	return formvalue.replace(/,/gi, "");
}

function removeMinusValue(formvalue) {
	return formvalue.replace(/-/gi, "");
}

function vertifyYYYYMMDD(form) {
	var frmval = form.value;
	if (frmval.length == 10) {
		if (frmval.substring(4, 5) != "-" || frmval.substring(7, 8) != "-") {
			alert("형식을 정확히 입력해 주세요!");
			form.value = "";
			form.focus();
		}
	}
}

function vertifyRealNumber(form) {
	var frmval = form.value;
	if (frmval.length == 3) {
		if (frmval.substring(1, 2) != ".") {
			alert("형식을 정확히 입력해 주세요!");
			form.value = "";
			form.focus();
		}
	}
}

function LengthCheck(formvalue, maxlength) {
	var frmval = formvalue;
	strlength = 0;
	for (i = 0; i < frmval.length; i++) {
		if (frmval.charCodeAt(i) > 255) strlength += 2;
		else strlength++;
	}
	if (strlength > maxlength) {
		if (strlength % 2 != 0) strlength = Math.ceil(strlength / 2);
		else strlength = strlength / 2;
		return false;
	}
	return true;
}

function IsNumber(formvalue) {
	var frmval = formvalue;
	for(var i = 0; i < frmval.length; i++) {
		var chr = frmval.substr(i, 1);
		if ((chr < '0' || chr > '9') && (chr != '-') && (chr != '.')) {
			return false;
		} else {
		}
	}
	return true;
}

function IsRealNumber(formvalue) {
	var frmval = formvalue;
	for(var i = 0; i < frmval.length; i++) {
		var chr = frmval.substr(i, 1);
		if ((chr < '0' || chr > '9') && (chr != '.')) {
			return false;
		} else {
		}
	}
	return true;
}

function IsIntegerNumber(formvalue) {
	var frmval = formvalue;
	for (var i = 0; i < frmval.length; i++) {
		var chr = frmval.substr(i, 1);
		if ((chr < '0' || chr > '9')) {
			return false;
		} else {
		}
	}
	return true;
}

function IsKor(formvalue) {
	var frmval = formvalue;
	for (var i = 0; i < frmval.length; i++) {
		var chr = frmval.substr(i, 1);
		if ((chr >= 'A' && chr <= 'Z') || (chr >= 'a' && chr <= 'z') || (chr == '@') || (chr == '.') || (chr == '_') || (chr == '-') || (chr >= '0' && chr <= '9')) {
			return false;
		}
	}
	return true;
}

function IsEmail(formvalue) {
	var frmval = formvalue;
	if (frmval.indexOf('@') == -1) {
		return false;
	} else {
		if (frmval.indexOf('.') == -1) {
			return false;
		} else return true;
	}
}

function getFileSize (fileName) {
	if (document.layers) {
		if (navigator.javaEnabled()) {
			var file = new java.io.File(fileName);
			if (location.protocol.toLowerCase() != 'file:') {
				netscape.security.PrivilegeManager.enablePrivilege('UniversalFileRead');
			}
			return file.length();
		} else {
			return -1;
		}
	} else if (document.all) {
		window.oldOnError = window.onerror;
		window.onerror = function (err) {
			if (err.indexOf('utomation') != -1) {
				alert('file access not possible');
				return true;
			} else {
				return false;
			}
		}
		var fso = new ActiveXObject('Scripting.FileSystemObject');
		var file = fso.GetFile(fileName);
		window.onerror = window.oldOnError;
		return file.Size;
	}
}

function IsCOMPANYSSN(ssn) {
	var sum = 0;
	var getlist = new Array(10);
	var chkvalue = new Array("1", "3", "7", "1", "3", "7", "1", "3", "5");
	for(var i = 0; i < 10; i++) { getlist[i] = ssn.substring(i, i + 1); }
	for(var i = 0; i < 9; i++) { sum += getlist[i] * chkvalue[i]; }
	sum = sum + parseInt((getlist[8] * 5) / 10);
	sidliy = sum % 10;
	sidchk = 0;
	if (sidliy != 0) { sidchk = 10 - sidliy; }
	else { sidchk = 0; }
	if (sidchk != getlist[9]) { return false; }
	return true;
}

function IsKoreanSSN(ssn1, ssn2) {
	var sum = 0;
	sum += ssn1.charAt(0)*2;
	sum += ssn1.charAt(1)*3;
	sum += ssn1.charAt(2)*4;
	sum += ssn1.charAt(3)*5;
	sum += ssn1.charAt(4)*6;
	sum += ssn1.charAt(5)*7;
	sum += ssn2.charAt(0)*8;
	sum += ssn2.charAt(1)*9;
	sum += ssn2.charAt(2)*2;
	sum += ssn2.charAt(3)*3;
	sum += ssn2.charAt(4)*4;
	sum += ssn2.charAt(5)*5;
	check = 11 - sum % 11;
	if (check > 9) check = check % 10;
	if (check != ssn2.charAt(6)) {
		return false;
	} else {
		return true;
	}
}

function IsKoreanSSN2(ssn) {
	var sum = 0;
	sum += ssn.charAt(0)*2;
	sum += ssn.charAt(1)*3;
	sum += ssn.charAt(2)*4;
	sum += ssn.charAt(3)*5;
	sum += ssn.charAt(4)*6;
	sum += ssn.charAt(5)*7;
	sum += ssn.charAt(6)*8;
	sum += ssn.charAt(7)*9;
	sum += ssn.charAt(8)*2;
	sum += ssn.charAt(9)*3;
	sum += ssn.charAt(10)*4;
	sum += ssn.charAt(11)*5;
	check = 11 - sum % 11;
	if (check > 9) check = check % 10;
	if (check != ssn.charAt(12)) {
		return false;
	} else {
		return true;
	}
}

function IsForeignerSSN(ssn1, ssn2) {
	var ssn = ssn1 + ssn2;
	var sum = 0;
	var odd = 0;
	buf = new Array(13);
	for (i = 0; i < 13; i++) buf[i] = parseInt(ssn.charAt(i));
	odd = buf[7] * 10 + buf[8];
	if (odd % 2 != 0) {
		return false;
	}
	if ((buf[11] != 6) && (buf[11] != 7) && (buf[11] != 8) && (buf[11] != 9)) {
		return false;
	}
	multipliers = [2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5];
	for (i = 0, sum = 0; i < 12; i++) sum += (buf[i] *= multipliers[i]);
	sum = 11 - (sum % 11);
	if (sum >= 10) sum -= 10;
	sum += 2;
	if (sum >= 10) sum -= 10;
	if (sum != buf[12]) {
		return false;
	} else {
		return true;
	}
}

/**
 * 현재 시각을 Time 형식으로 리턴
 */
function getCurrentTime() {
	return toTimeString(new Date());
}

/**
 * 현재 年을 YYYY형식으로 리턴
 */
function getYear() {
	return getCurrentTime().substr(0, 4);
}

/**
 * 현재 月을 MM형식으로 리턴
 */
function getMonth() {
	return getCurrentTime().substr(4, 2);
}

/**
 * 현재 日을 DD형식으로 리턴
 */
function getDay() {
	return getCurrentTime().substr(6, 2);
}

/**
 * 현재 時를 HH형식으로 리턴
 */
function getHour() {
	return getCurrentTime().substr(8, 2);
}

function TabNext(form, event, len, ThisField, NextField) {
	var ths_frm = eval("form." + ThisField);
	var nxt_frm = eval("form." + NextField);
	var fld_len = 0;
	if (event == "down") {
		fld_len = ths_frm.value.length;
	} else if (event == "up") {
		if (ths_frm.value.length != fld_len) {
			fld_len = ths_frm.value.length;
			if (fld_len == len) {
				nxt_frm.focus();
			}
		}
	}
}

//-->