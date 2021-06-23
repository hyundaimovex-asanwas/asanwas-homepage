//����, ���ڸ� ������� üũ
var schar = new Array('~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '\\', '+', '|', '{', '}', ':', '"', '<', '>', '?', '*', '-', '`', '-', '=', '[', ']', ';','\'', ',', '.', '/');
function isUserid(name)
{
    strarr = new Array(name.value.length);

    for (i=0; i<name.value.length; i++)
    {
        for (j=0; j<schar.length-1; j++)
        {
            if (schar[j] ==name.value.charAt(i))
                return false;
            else
                continue;
        }

        strarr[i] = name.value.charAt(i)
        if ((strarr[i] >=0) && (strarr[i] <=9))
            continue;
        else if ((strarr[i] >='a') && (strarr[i] <='z'))
            continue;
        else if ((strarr[i] >='A') && (strarr[i] <='Z'))
            continue;
        else
            return false;
    }
    return true;
}


//����, �ѱ۸� ������� üũ
var schar1 = new Array('~', '!', '@', '#', '$', '%', '^', '&', '*', '_', '\\', '+', '|', '{', '}', ':', '"', '<', '>', '?', '*', '-', '`', '-', '=', '[', ']', ';','\'', ',', '.', '/');
function isHan(name) {
    strarr = new Array(name.value.length);


    for (i=0; i<name.value.length; i++)
    {
        for (j=0; j<schar.length; j++)
        {
            if (schar1[j] ==name.value.charAt(i))
                return false;
            else
                continue;
        }

        strarr[i] = name.value.charAt(i)
        if ((strarr[i] >=0) && (strarr[i] <=9))
            return false;
        else if ((strarr[i] >='a') && (strarr[i] <='z'))
            return false;
        else if ((strarr[i] >='A') && (strarr[i] <='Z'))
            return false;
        else if ((escape(strarr[i]) > '%60') && (escape(strarr[i]) <'%80') )
            return false;
        else
			continue;

    }
    return true;
}


//����Ʈ ���
function getBytes(instr) {
    var len = 0;
    for(i=0; i<instr.length; i++) {
        var chr = instr.charAt(i);
        if (escape(chr).length > 4) {
                len += 2;
        }
        else {
                len++;
        }
    }
    return len;
}


//-------------------------------------------------------
// �̸��� �� �̸������� ID�˻�
//-------------------------------------------------------
function CheckEmail(strEmail){
    /** ��������
     - @�� 2���̻�
     - .�� �پ ������ ���
     -  @.��  .@�� �����ϴ� ���
     - ��ó����.�� ��� **/
    var regDoNot = /(@.*@)|(\.\.)|(@\.)|(\.@)|(^\.)/;
    /** �ʼ�����
     - @������ �ϳ��̻��� ���ڰ� �־�� ��
     - @�� �ϳ��־�� ��
     - Domain�� .�� �ϳ� �̻� �־�� ��
     - Domain���� ������ ���ڴ� ������ 2~3���̾�� �� **/
    var regMust = /^[a-zA-Z0-9\-\.\_]+\@[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,3})$/;

    if ( !regDoNot.test(strEmail) && regMust.test(strEmail) )
        return true;
    else
        return false;
}


// �ֹε�Ϲ�ȣ üũ (1 Parameter)

function Jumin_Num_Check(arg_v)
{
	ResNo1 = arg_v.substring(0, 6);
	ResNo2 = arg_v.substring(6);

	var chk = 0;
	var yy  = ResNo1.substring(0,2);
	var mm  = ResNo1.substring(2,4);
	var dd  = ResNo1.substring(4,6);
	var sex = ResNo2.substring(0,1);

	if (ResNo1.length != 6)
	{
		return false;
	}

	if ((sex != 1 && sex != 2 && sex != 3 && sex != 4) || (ResNo2.length != 7))
	{
		return false;
	}

	if ((ResNo1.length == 6) && (ResNo2.length == 7))
	{
		var ich = parseInt(sex, 10);
		switch(ich)
		{
			case 1: break;
			case 2: break;
			case 3: if(yy == 00) break;
			case 4: if(yy == 00) break;
			default:
				return false;
		}
	}

	for(var i = 0; i <=5; i++)
	{
		chk = chk + (((i % 8) + 2) * parseInt(ResNo1.substring(i, i + 1)));
	}

	for(var i = 6; i <= 11; i++)
	{
		chk = chk + (((i % 8) + 2) * parseInt(ResNo2.substring(i - 6, i - 5)));
	}

	chk = 11 - (chk % 11);
	chk = chk % 10;

	if(chk != ResNo2.substring(6, 7))
	{
		return false;
	}

	return true
}


// �ֹε�Ϲ�ȣ üũ(2 parameter)

function JuminCheck(ResNo1, ResNo2)
{
	var chk = 0;
	var yy  = ResNo1.substring(0,2);
	var mm  = ResNo1.substring(2,4);
	var dd  = ResNo1.substring(4,6);
	var sex = ResNo2.substring(0,1);

	if(ResNo1.length != 6) {
		alert('�ֹε�Ϲ�ȣ �պκ��� �߸��Ǿ����ϴ�.');
		return true;
	}

	if((sex != 1 && sex != 2 && sex != 3 && sex != 4) || (ResNo2.length != 7)) {
		alert ('�ֹε�Ϲ�ȣ �޺κ��� �߸��Ǿ����ϴ�.');
		return true;
	}

	if((ResNo1.length == 6) && (ResNo2.length == 7)) {
		var ich = parseInt(sex, 10);
		switch(ich) {
			case 1: break;
			case 2: break;
			case 3: if(yy == 00) break;
			case 4: if(yy == 00) break;
			default:
				alert('�ֹε�Ϲ�ȣ �޺κ��� �߸��Ǿ����ϴ�.');
				return true;
		}
	}

	for(var i = 0; i <=5; i++) {
		chk = chk + (((i % 8) + 2) * parseInt(ResNo1.substring(i, i + 1)));
	}

	for(var i = 6; i <= 11; i++) {
		chk = chk + (((i % 8) + 2) * parseInt(ResNo2.substring(i - 6, i - 5)));
	}

	chk = 11 - (chk % 11);
	chk = chk % 10;

	if(chk != ResNo2.substring(6, 7)) {
		alert('��ȿ���� ���� �ֹε�Ϲ�ȣ�Դϴ�.');
		return true;
	}
	return false
}


// �̸� üũ

function NameCheck(n)
{
	var charck = '0123456789~!@#$%^&*()_-+=|{}[]<>,./?';
	for(var i = 0; i < n.length; i++) {
		var substr = n.substring(i, i + 1);
		if(charck.indexOf(substr) >= 0) return true;
	}
	return false;
}

// E-Mail Check

function EmailCheck(str)
{
	var checkstr1 = '~!#$%^&*()+=|{}<>,/?';
	var checkstr2 = '@';
	var checkstr3 = '.';
	var alt = 0;
	var dot = 0;

	var st = str.indexOf('@');
	if(st < 1) {
		return true;
	}
	for(var i = 0; i < str.length; i++) {
		var substr = str.substring(i, i + 1);
		if(checkstr1.indexOf(substr) >= 0) {
			return true;
		}
		if(checkstr2.indexOf(substr) >= 0) {
			alt = alt + 1;
		}
		if(checkstr3.indexOf(substr) >= 0) {
			dot = dot + 1;
		}
	}
	if((alt != 1) || (dot > 3) || (dot < 1)) {
		return true;
	}
	return false;
}

// �� --> �빮�� ��ȯ �Լ�

function ToUpper(arg_v)
{
	var upperStr = "";
	var str1 = "abcdefghijklmnopqrstuvwxyz";
	var str2 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

	for(i = 0; i < arg_v.length; i++) {
		value = arg_v.charAt(i);
		index = str1.indexOf(value);
		if(index >= 0) value = str2.charAt(index);
		upperStr = upperStr + value;
	}
	return upperStr;
}

// �� --> �ҹ��� ��ȯ �Լ�

function ToLower(arg_v)
{
	var lowerStr = "";
	var str1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	var str2 = "abcdefghijklmnopqrstuvwxyz";

	for(i = 0; i < arg_v.length; i++) {
		value = arg_v.charAt(i);
		index = str1.indexOf(value);
		if(index >= 0) value = str2.charAt(index);
		lowerStr = lowerStr + value;
	}
	return lowerStr;
}

// ��ȭ ��ȣ Check

function isPhoneCheck(num)
{
	var num_Str = "0123456789( ).-,<>{}[]_~";

	for (var i = 0; i < num.length; i++) {
		var substr = num.substring(i, i + 1);
		if(num_Str.indexOf(substr) < 0) return true;
	}
	return false;
}

// ���� �Ǻ�

function isNumberCheck(num)
{
	var num_Str = "0123456789";

	for (var i = 0; i < num.length; i++) {
		var substr = num.substring(i, i + 1);
		if(num_Str.indexOf(substr) < 0) return true;
	}
	return false;
}

// ���� �Ǻ�

function isAlphaCheck(str)
{
	var alpha_Str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

	for(var i = 0; i < str.length; i++) {
		var substr = str.substring(i, i+1);
		if(alpha_Str.indexOf(substr) < 0) return false;
	}
	return true;
}

// ������ �Ǻ�

function isAlphaNumCheck(arg_v)
{
	var alpha_num_Str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

	for(var i = 0; i < arg_v.length; i++) {
		var substr = arg_v.substring(i, i + 1);
		if(alpha_num_Str.indexOf(substr) < 0) return false;
	}
	return true;
}

//���� �ִ��� ������ �Ǻ�.

function IsEmpty(data) {
	for (var i=0; i<data.length; i++) {
        if (data.charAt(i) != ' '){
            if (data.charAt(i) != '\r'){
                if (data.charAt(i) != '\n'){
                    return false;
                }
            }
        }
    }

    return true;
}

function Trim( value ) {
	var len = value.length;
	if (len == 0) return('');

	var value1 = RTrim(value);
	var value2 = LTrim(value1);
	return(value2);
}

function LTrim( arg ) {
	var len = arg.length;
	if (len == 0) return('');

	var i = 0;
	for (; i < arg.length; i++) {
		var ch = arg.charAt(i);
		if (ch == ' ' || ch == '\t' || ch == '\n' || ch == '\r') {
			continue;
		}
		else
			break;
	}
	return(arg.substr(i));
}

function RTrim( arg ) {
	var len = arg.length;
	if (len == 0) return('');

	var i = len - 1;
	for (; i >= 0; i--) {
		var ch = arg.charAt(i);
		if (ch == ' ' || ch == '\t' || ch == '\n')
			continue;
		else
			break;
	}
	return(arg.substring(0, i+1));
}

function strIsNum(str) {
	str = Trim(str);
	if (str.length == 0) return(false);
	for (var i = 0; i < str.length; i++) {
		if (str.charAt(i) < '0' || str.charAt(i) > '9')
			return(false);
	}
	return(true);
}

function formatNumber(strOrg) {
	strOrg = "" + strOrg;
	if(strOrg == "")	return "";

	var strNum = "";
	for(i=0; i<strOrg.length; i++) {
		if(strOrg.charAt(i) == ",")
			continue;
		strNum += strOrg.charAt(i);
	}

	if(!strIsNum(strNum))	return strOrg;

	var dot = strNum.indexOf(".");
	var strInt = "";
	var strFlt = "";
	if(dot > 0) {
		strInt = strNum.substring(0,dot);
		strFlt = strNum.substring(dot);
	}
	else
		strInt = strNum;

	var smod = strInt.length % 3;
	var strRtn = "";
	if(smod > 0)	strRtn = strInt.substring(0,smod);
	for(i=smod; i<strInt.length; i++) {
		if(smod != 0 && i == smod)	strRtn += ",";
		else if(i > 0 && (i - smod) % 3 == 0)
			strRtn += ","
		strRtn += strInt.charAt(i);
	}
	if(dot > 0)	strRtn += strFlt;

	return strRtn;
}

function validationNumber(obj) {
	var val = obj.value;
	var str = "";
	for(i=0; i<val.length; i++) {
		var chr = val.charAt(i);
		if(chr >= '0' && chr <= '9')
			str += chr;
	}
	//alert(str)
	if(str != "") str = parseInt(str);
	obj.value = formatNumber(str);
}

function rmcomma(str) {
	var len = str.length;
	var rstr = "";
	if (len > 0) {
		for (var i = 0; i < len; i++) {
			var ch = str.charAt(i);
			if (ch != ',') rstr += ch;
		}
	}
	return(rstr);
}

function popup(url, options) {
	window.open(url, "", options);
}

function filepopup(url) {
	window.open(url, "", "left=300,top=300,width=300,height=130");
}


//input tag �̵�,  20051029 �߰�  by ikara
function movenext(obj1,obj2,length){
	if (obj1.value.length == length) obj2.focus();
}

//���ڼ� ���� ,  20051029 �߰�  by ikara
function is_range(val, min, max)
{
	var val_len = val.length;
	var temp;
	for(i = 0; i < val_len; i++) {
		temp = val.charAt(i);
		if(escape(temp).length > 4) val_len++;
	}
	if ((val_len < min) || (val_len > max))	return false;
	else return true;
}
