/********************************************************************************/
/* ½Ã½ºÅÛ            : GLW (Global Window)
/* ÇÁ·Î±×·¥ ¾ÆÀÌµğ   :
/* ¼Ò½ºÆÄÀÏ ÀÌ¸§     : common.js
/* ¼³¸í              : °øÅë ½ºÅ©¸³Æ®
/* ¹öÀü              : 1.0
/* ÃÖÃÊ ÀÛ¼ºÀÚ       : ÀÓÁ¤±â
/* ÃÖÃÊ ÀÛ¼ºÀÏÀÚ     : 2006-01-17
/* ÃÖ±Ù ¼öÁ¤ÀÚ       :
/* ÃÖ±Ù ¼öÁ¤ÀÏ½Ã     :
/* ÃÖÁ¾ ¼öÁ¤³»¿ë     :
/********************************************************************************/


/* =====================================================================================================
   ÇÔ¼ö¸í : zc_xxxx()
   ¼³  ¸í : Character, StringÃ³¸® (³¯Â¥,±İ¾×Àº Á¦¿Ü)
========================================================================================================= */

// ÇØ´ç Æû °´Ã¼(formObj)ÀÇ ÀÔ·Â ÇÊµå Áß,
// ÇÊ¼öÇ×¸ñÀÇ null Ã¼Å©, ±æÀÌ Ã¼Å©, ÁÖ¹Î¹øÈ£,¹ıÀÎ¹øÈ£, »ç¾÷ÀÚ ¹øÈ£, ±İ¾× ÇüÅÂÀÇ µ¥ÀÌÅ¸ Á¤ÇÕ¼ºÀ» Ã¼Å©ÇÏ´Â Æã¼Ç
// °¢°¢ÀÇ Ã¼Å©¸¦ Åë°ú ¸øÇßÀ»¶§´Â °¢ ÇÊµå¿Í ÀÌ¸§À» alert()¸¦ ÅëÇØ º¸¿©ÁÖ°í false¸¦ ¸®ÅÏÇÏ°í,
// ¸ğµç Ã¼Å©¸¦ Åë°úÇÏ¸é true¸¦ ¸®ÅÏÇÏ¸é¼­, "Ã³¸®ÁßÀÔ´Ï´Ù"¸¦ º¸¿©ÁÖ´Â ÆË¾÷Ã¢À» È£ÃâÇÑ´Ù.


function zcCheckForm(formObj){
	var obj = formObj.all;
	var flag = false;
	var msg = "";
	var focusObj;				// focus¸¦ ÁÖ¾î¾ß ÇÒ ¿ÀºêÁ§Æ®
	var alertFlag = false;		// true ÀÌ¸é alertÃ¢À»
	var confirmFlag = false;	// true ÀÌ¸é confirmÃ¢À»

	for(var i = 0 ; i < obj.length ; i++){

		if(obj.item(i).type=="text" || obj.item(i).type=="textarea"){
			zsDelRLSpace(obj.item(i));
		}

		//  -------------ÇÊ¼ö Ç×¸ñ Ã¼Å©---------------//
		if(obj.item(i).notnull != undefined ){

			if(obj.item(i).type=="radio" || obj.item(i).type=="checkbox"){	//Ã¼Å©¹Ú½º³ª ¶óµğ¿À ¹Ú½º¶ó¸é
				var colObj = document.getElementsByName(obj.item(i).name);
				for(var j = 0 ; j<colObj.length ; j++){	// Ã¼Å©¹Ú½º³ª ¶óµğ¿À ¹Ú½º¿¡¼­ Ã¼Å©µÈ °ÍÀÌ ÀÖ´ÂÁö °Ë»ç
					if(colObj[j].checked){
						flag = true;
						break;
					}
				}
				if(!flag){	// ÇÊ¼ö Ç×¸ñ ´©¶ôÀÌ ÀÖ´Ù¸é ¸Ş½ÃÁö¿¡ Ãß°¡
					setErrorFld(obj.item(i), obj.item(i).msgTitle + " Àº(´Â) ÇÊ¼öÀÔ·Â Ç×¸ñÀÔ´Ï´Ù.\r\n");
				}
				flag = false;	// flag ÃÊ±âÈ­

			}else{	// ±×¿Ü input or textarea ¶ó¸é
				if(obj.item(i).value == ""){	// value°¡ nullÀÌ¶ó¸é
					setErrorFld(obj.item(i), obj.item(i).msgTitle + " Àº(´Â) ÇÊ¼öÀÔ·Â Ç×¸ñÀÔ´Ï´Ù.\r\n");
				}
			}
		}

		//  ------------- ±æÀÌ Ã¼Å©---------------//
		if(obj.item(i).correctLen != undefined && obj.item(i).value != ""){
			var str = zsRmString(obj.item(i).value, "-");	// "-" Á¦°Å
			if(str.length != obj.item(i).correctLen){	// ¿Ã¹Ù¸¥ ±æÀÌ°¡ ¾Æ´Ï¶ó¸é
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "¿¡´Â " +obj.item(i).correctLen+ "ÀÚÀÇ µ¥ÀÌÅ¸¸¦ ÀÔ·ÂÇØ¾ß ÇÕ´Ï´Ù.\r\n");
			}
		}

		if(obj.item(i).minLen != undefined && obj.item(i).value != ""){
			if(zsGetBytesLength(obj.item(i).value)  < parseInt(obj.item(i).minLen)){
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "¿¡´Â " +obj.item(i).minLen+ "ÀÚ ÀÌ»óÀÇ µ¥ÀÌÅÍ¸¦ ÀÔ·ÂÇØ¾ß ÇÕ´Ï´Ù.\r\n");
			}
		}
		
		if(obj.item(i).len != undefined &&  obj.item(i).value != ""){
			
			if(obj.item(i).comma != undefined) {
				var str = obj.item(i).value;
				var arrStr = str.split('.');
				if(arrStr.length > 2) {
					setErrorFld(obj.item(i), obj.item(i).msgTitle + "¿¡´Â ¼Ò¼öÁ¡À» ÇÏ³ª¸¸ ÀÔ·ÂÇØ¾ß ÇÕ´Ï´Ù.\r\n");
				}
				
				if(zsGetBytesLength(arrStr[0])  > (parseInt(obj.item(i).len)-parseInt(obj.item(i).comma))) {
					var commalen = (parseInt(obj.item(i).len)-parseInt(obj.item(i).comma));
					setErrorFld(obj.item(i), obj.item(i).msgTitle + "¿¡´Â ¼Ò¼öÁ¡ ¿Ü¿¡ " +commalen+ "ÀÚ ÀÌÇÏÀÇ µ¥ÀÌÅÍ¸¦ ÀÔ·ÂÇØ¾ß ÇÕ´Ï´Ù.\r\n");
				}
		
				if(arrStr.length == 2) {
					if(zsGetBytesLength(arrStr[1])  > parseInt(obj.item(i).comma)) {
						setErrorFld(obj.item(i), obj.item(i).msgTitle + "¿¡´Â ¼Ò¼öÁ¡ ÀÌÇÏ " +obj.item(i).comma+ "ÀÚ¸®ÀÇ µ¥ÀÌÅÍ¸¦ ÀÔ·ÂÇØ¾ß ÇÕ´Ï´Ù.\r\n");
					}
				}
			
			} else {
				if(zsGetBytesLength(obj.item(i).value)  > parseInt(obj.item(i).len)){	// ¿Ã¹Ù¸¥ ±æÀÌ°¡ ¾Æ´Ï¶ó¸é
					setErrorFld(obj.item(i), obj.item(i).msgTitle + "¿¡´Â " +obj.item(i).len+ "ÀÚ (ÇÑ±Û " + parseInt(obj.item(i).len/2) +"ÀÚ) ÀÌÇÏÀÇ µ¥ÀÌÅÍ¸¦ ÀÔ·ÂÇØ¾ß ÇÕ´Ï´Ù.\r\n");
				}
			}
		}

		// -------------±İ¾×ÀÎÁö Ã¼Å©(¼ıÀÚ, "-", ".", "," ·Î¸¸ ÀÌ·ç¾îÁ³´ÂÁö Ã¼Å©----------------//
		if(obj.item(i).format =="money" && obj.item(i).value !=""){
			if(!zmIsMoney(obj.item(i))) {		// ¿Ã¹Ù¸¥ ±İ¾×ÇüÅÂ°¡ ¾Æ´Ï¶ó¸é
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "¿¡´Â ¼ıÀÚ¸¸ ÀÔ·ÂÇØ¾ß ÇÕ´Ï´Ù.\r\n");
			}
		}
		
		// ------------- ¼ıÀÚ¸¸ Ã¼Å© (// --------------//
		if(obj.item(i).format =="number" && obj.item(i).value !=""){
			if(!zcIsNum(obj.item(i))) {		// ¿Ã¹Ù¸¥ ¼ıÀÚÇüÅÂ°¡ ¾Æ´Ï¶ó¸é
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "¿¡´Â ¼ıÀÚ¸¸ ÀÔ·ÂÇØ¾ß ÇÕ´Ï´Ù.\r\n");
			}
		}

		// -------------ÀÌ¸ŞÀÏÀÎÁö Ã¼Å©----------------//
		if(obj.item(i).format =="email" && obj.item(i).value !=""){
			if(!zcIsEmail(obj.item(i))) {		// ¿Ã¹Ù¸¥ ÀÌ¸ŞÀÏÇüÅÂ°¡ ¾Æ´Ï¶ó¸é
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "ÀÌ(°¡) ¿Ã¹Ù¸£Áö ¾Ê½À´Ï´Ù.\r\n");
			}
		}

		// -------------³¯Â¥ÀÎÁö Ã¼Å©----------------//
		if(obj.item(i).format =="date" && obj.item(i).value !=""){
			if(!zdIsDate(obj.item(i).value)) {		// ¿Ã¹Ù¸¥ ³¯Â¥ÇüÅÂ°¡ ¾Æ´Ï¶ó¸é
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "¿¡´Â ³¯Â¥¸¸ ÀÔ·ÂÇØ¾ß ÇÕ´Ï´Ù.\r\n");
			}
		}

		// -------------³¯Â¥_³â¿ùÀÎÁö Ã¼Å©----------------//
		if(obj.item(i).format =="dateYM" && obj.item(i).value !=""){
			if(!zdIsDateYM(obj.item(i).value)) {		// ¿Ã¹Ù¸¥ ³¯Â¥ÇüÅÂ°¡ ¾Æ´Ï¶ó¸é
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "¿¡´Â ³¯Â¥¸¸ ÀÔ·ÂÇØ¾ß ÇÕ´Ï´Ù.\r\n");
			}
		}

		// -------------½Ã°£ÀÎÁö Ã¼Å©----------------//
		if(obj.item(i).format =="time" && obj.item(i).value !=""){
			if(!zdIsTime(obj.item(i).value)) {		// ¿Ã¹Ù¸¥ ½Ã°£ÇüÅÂ°¡ ¾Æ´Ï¶ó¸é
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "ÀÌ(°¡) ¿Ã¹Ù¸£Áö ¾Ê½À´Ï´Ù.\r\n");
			}
		}

		// -------------ÁÖ¹Î¹øÈ£ Á¤ÇÕ¼º Ã¼Å©----------------//
		if(obj.item(i).format =="jumin" && obj.item(i).value !=""){
			if(!zcIsJumin(obj.item(i))) {		// ¿Ã¹Ù¸¥ ÁÖ¹Î¹øÈ£°¡ ¾Æ´Ï¶ó¸é
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "ÀÌ(°¡) ¿Ã¹Ù¸£Áö ¾Ê½À´Ï´Ù.\r\n");
			}
		}

		// -------------¹ıÀÎ¹øÈ£ Á¤ÇÕ¼º Ã¼Å©----------------//
		if(obj.item(i).format =="cono" && obj.item(i).value !=""){
			if(!zcIsBupin(obj.item(i))) {		// ¿Ã¹Ù¸¥ ¹ıÀÎ¹øÈ£°¡ ¾Æ´Ï¶ó¸é
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "ÀÌ(°¡) ¿Ã¹Ù¸£Áö ¾Ê½À´Ï´Ù.\r\n");
			}
		}

		// -------------ÁÖ¹Î(¹ıÀÎ)¹øÈ£ Á¤ÇÕ¼º Ã¼Å©----------------//
		if(obj.item(i).format =="perid" && obj.item(i).value !=""){
			if(!zcIsPerid(obj.item(i))) {		// ¿Ã¹Ù¸¥ ÁÖ¹Î(¹ıÀÎ)¹øÈ£°¡ ¾Æ´Ï¶ó¸é
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "ÀÌ(°¡) ¿Ã¹Ù¸£Áö ¾Ê½À´Ï´Ù.\r\n");
			}
		}

		// -------------»ç¾÷ÀÚ¹øÈ£ Á¤ÇÕ¼º Ã¼Å©----------------//
		if(obj.item(i).format =="resno" && obj.item(i).value !=""){
			if(!zcIsResno(obj.item(i))) {		// ¿Ã¹Ù¸¥ »ç¾÷ÀÚ¹øÈ£°¡ ¾Æ´Ï¶ó¸é
				setErrorFld(obj.item(i), obj.item(i).msgTitle + "ÀÌ(°¡) ¿Ã¹Ù¸£Áö ¾Ê½À´Ï´Ù.\r\n");
			}
		}

		
		// attach file check...		
		/*
		if(obj.item(i).type == "file") {
			var fileExt = '';
			var realfilename = obj.item(i).value;
			if(realfilename.length > 4 && realfilename.indexOf('.')>0) {
				fileExt = realfilename.substring(realfilename.lastIndexOf('.'));
				if( fileExt=='.asp' || fileExt=='.jsp' || fileExt=='.php'
					|| fileExt=='.html' || fileExt=='.bak' || fileExt=='.inc'
					|| fileExt=='.exe' || fileExt=='.bat' || fileExt=='.com'
					|| fileExt=='.htm' || fileExt=='.bsp' ) {
					//setErrorFld(obj.item(i), "asp, jsp, php, html, bak, inc, exe, bat, com, htm, bsp ÆÄÀÏÀº ¾÷·ÎµåÇÒ ¼ö ¾ø½À´Ï´Ù.\r\n");
					setErrorFld(obj.item(i), alertMsg[13] + "\r\n");
					
				}
			}
		}
		*/

	}

	if (alertFlag) {	// alertÃ¢À» ¶ç¿ï°Ô ÀÖÀ¸¸é,
		alert(msg);

		if ( focusObj.disabled == false )	focusObj.focus();
		return false;
	/*
	} else if (confirmFlag) {	// confirmÃ¢À» ¶ç¿ï°Ô ÀÖÀ¸¸é,
		msg += "Ã³¸®ÇÏ½Ã°Ú½À´Ï±î ?";
		if ( confirm(msg) ) return true;

		if ( focusObj.disabled == false )	focusObj.focus();
		return false;
	*/
	}else	// ¸ğµç Ã¼Å©¸¦ Åë°úÇß´Ù¸é
		return true;

	//	Æ÷Ä¿½º¸¦ ÁÙ ¿ÀºêÁ§Æ® ¼ÂÆÃ, alert ¸Ş½ÃÁö ÅØ½ºÆ® Ãß°¡
	function setErrorFld(obj, str){
		var is_show = 'Y';
		try {
			obj.focus();
		} catch(ee) {
			is_show = 'N';
		}
		
		if(is_show == 'Y') {
			alertFlag = true;
			if(focusObj == undefined)		focusObj = obj;		//focusObj ¼ÂÆÃ
			msg += str;		//¸Ş½ÃÁö ¼ÂÆÃ
		}
	}
}

// input ÇÊµå °´Ã¼(obj)ÀÇ °ªÀÌ ¼ø¼öÇÑ ¿µ¹®ÀÚ("A"-"Z", or "a"-"z") ÀÎÁö Ã¼Å©
// ¿µ¹®ÀÌ¶ó¸é true, ¾Æ´Ï¶ó¸é false¸¦ ¸®ÅÏ
function zcIsAlphaOnly(obj) {
	var str = obj.value;
	if(zcIsNull(str)) return false;

	var isValid = true;
  	for (var i = 0; i < str.length; i++) {
		if (!(  ((str.charAt(i) >= 'a') && (str.charAt(i) <= 'z')) ||	((str.charAt(i) >= 'A') && (str.charAt(i) <= 'Z')) ) ){
         	isValid = false;
			break;
     	}
   }
	return isValid;
}

//  input ÇÊµå °´Ã¼(obj)ÀÇ °ªÀÌ ¿µ¹®ÀÚ("A"-"Z", or "a"-"z") ¶Ç´Â ¼ıÀÚ ÀÌ¸é true
function zcIsAlphaNum( obj ) {
	var str = obj.value;
	if(zcIsNull(str)) return false;

	var isValid = true;
   	for (var i = 0; i < str.length; i++)
   	{
      	if (!(((str.charAt(i) >= "0") && (str.charAt(i) <= "9")) ||
      			((str.charAt(i) >= "a") && (str.charAt(i) <= "z")) ||
      			((str.charAt(i) >= "A") && (str.charAt(i) <= "Z"))))
			{
				isValid = false;
				break;
			}
   	}
   	return isValid;
}


//  input ÇÊµå °´Ã¼(obj)ÀÇ °ªÀÌ Á¤¼ö(0~9)¸¸ ÀÔ·ÂÇÏ¿´´ÂÁö È®ÀÎ
function zcIsNum(obj) {
	var str = obj.value;
	return zcIsNumStr(obj.value);
}

//	¹®ÀÚ¿­(str)ÀÌ (0-9)¸¸À¸·Î ÀÌ·ç¾îÁ³´ÂÁö Ã¼Å©
function zcIsNumStr(str) {
	if(zcIsNull(str)) return false;

	var temp = "";
	var n = String(str);
	var len = n.length;
	var pos = 0;
  	var ch = '';

	while (pos < len) {
		ch = n.charAt(pos);
		if ((ch >= '0') && (ch <= '9')) {
			temp = temp + ch;
		}else{
			return false;
		}
		pos = pos + 1;
	}
	return true;
}

function zcNotKorean(obj) {
    var deny_pattern = /[^(°¡-ÆR)]/;

	if(!deny_pattern.test(obj.value)) {
		//alert(alertMsg[15]);
		obj.focus();
		obj.select();
		return false;
	}

	return true;
}

//  input ÇÊµå °´Ã¼(obj)ÀÇ °ªÀÌ Á¤¼ö(0~9)¸¸ ÀÔ·ÂÇÏ¿´´ÂÁö È®ÀÎ +  ¹®ÀÚ°¡ ÀÖ´Ù¸é obj °ª ÃÊ±âÈ­
function zcIsNumAndInit(obj) {
	var str = obj.value;

	if(zcIsNumStr(str))
		return true;
	else{
		obj.value="";
		//obj.focus();
		return false;
	}
}

//  input ÇÊµåÀÇ °ªÀÌ Á¤¼ö(0~9)¸¸ ÀÔ·ÂÇÏ¿´´ÂÁö È®ÀÎ +  ¹®ÀÚ°¡ ÀÖ´Ù¸é obj °ª ÃÊ±âÈ­
function zcIsStrNumAndInit(str) {
	//var str = obj.value;

	if(zcIsNumStr(str))
		return true;
	else{
		obj.value="";
		return false;
	}
}

//  input ÇÊµå °´Ã¼(obj)ÀÇ °ªÀÌ Á¤¼ö(0~9), ¼Ò¼öÁ¡('.') ÀÌ¸é true
function zcIsNumDot(obj) {
    var deny_pattern = /[^0-9"."]/;
	var paramValue = obj.value;

	if ( paramValue.substr(0,1) == "-" ) paramValue = paramValue.substr(1,paramValue.length);

	if(deny_pattern.test(paramValue)) {
		//alert(alertMsg[ 8]); // ¼ıÀÚ¸¸ ÀÔ·ÂÇØ¾ß ÇÕ´Ï´Ù.
		alert('¼ıÀÚ¸¸ ÀÔ·ÂÇØ¾ß ÇÕ´Ï´Ù');
		obj.focus();
		obj.select();
		return false;
	}

	return true;
}

//  input ÇÊµå °´Ã¼(obj)ÀÇ °ªÀÌ Á¤¼ö(0~9), ¸¶ÀÌ³Ê½º('-'), ¼Ò¼öÁ¡('.') ÀÌ¸é true
function zcIsNumMinusDot( obj ) {
	var str = obj.value;
	if(zcIsNull(str)) return false;

	var isValid = true;
	var decCount = 0;		// number of decimal points in the string
	//str += "";

	for (var i = 0; i < str.length; i++) {
		// track number of decimal points
		if (str.charAt(i) == ".")
			decCount++;

	    	if (!((str.charAt(i) >= "0") && (str.charAt(i) <= "9") ||
		      (str.charAt(i) == "-") || (str.charAt(i) == "."))) {
	      	 	isValid = false;
	      	 	break;
		} else if ((str.charAt(i) == "-" && i != 0) ||
			   (str.charAt(i) == "." && str.length == 1) ||
			   (str.charAt(i) == "." && decCount > 1)) {
	       		isValid = false;
	      	 	break;
	        }
   	}
   	return isValid;
}
//  input ÇÊµå °´Ã¼(obj)ÀÇ °ªÀÌ Á¤¼ö(0~9), ¸¶ÀÌ³Ê½º('-'), ¼Ò¼öÁ¡(':') ÀÌ¸é true
function zcIsNumMinusDouble( obj ) {
	var str = obj.value;
	if(zcIsNull(str)) return false;

	var isValid = true;
	var decCount = 0;		// number of decimal points in the string
	//str += "";

	for (var i = 0; i < str.length; i++) {
		// track number of decimal points

	    	if (!((str.charAt(i) >= "0") && (str.charAt(i) <= "9") ||
		      (str.charAt(i) == "-") || (str.charAt(i) == ":"))) {
	      	 	isValid = false;
	      	 	break;
		}
   	}
   	return isValid;
}
//  input ÇÊµå °´Ã¼(obj)ÀÇ °ªÀÌ Á¤¼ö(0~9)·Î ÀÌ·ç¾îÁ³´Ù¸é true, allowNegatives°¡ trueÀÏ°æ¿ì À½¼ö(-Æ÷ÇÔµÈ Á¤¼ö)µµ true
function zcIsNumMinus( obj, allowNegatives ) {
	var str = obj.value;
	if(zcIsNull(str)) return false;

	var isValid = true;
	//str += "";

	if (allowNegatives+"" == "undefined" || allowNegatives+"" == "null")
		allowNegatives = true;

	for (var i = 0; i < str.length; i++) {
	    	if (!((str.charAt(i) >= "0") && (str.charAt(i) <= "9") || (str.charAt(i) == "-"))) {
	       		isValid = false;
	       		break;
		} else if ((str.charAt(i) == "-" && i != 0) ||
					(str.charAt(i) == "-" && !allowNegatives)) {
	       		isValid = false;
	       		break;
	        }
   	}
   	return isValid;
}

//  input ÇÊµå °´Ã¼(obj)ÀÇ °ªÀÌ ¿Ã¹Ù¸¥ emailÆ÷¸ËÀÌ¸é true
function zcIsEmail( obj ) {
    var deny_pattern = /[^(--a-zA-Z0-9"@.")]/;
    if (deny_pattern.test(obj.value)) return false;

	var str = "";
	if (typeof obj=="object") str = obj.value;
	else			  str = obj;

	if(zcIsNull(str)) return false;	//°ø¹éÀÌ¶ó¸é

	var isValid = true;
	str += "";

	namestr = str.substring(0, str.indexOf("@"));  // everything before the '@'
	domainstr = str.substring(str.indexOf("@")+1, str.length); // everything after the '@'

	// Rules : @¾Õ¿¡ ±ÛÀÚ°¡ ÀÖ¾î¾ß ÇÏ¸ç, µµ¸ŞÀÎºÎºĞ¿£ ¹İµå½Ã "." ÀÌ ÀÖ¾î¾ß ÇÏ¸ç,
	//				@¿Í . ÀÌ ¿¬¼ÓÇØ¼­ ¿Ã ¼ö ¾ø°í, ¸¶Áö¸· ±ÛÀÚ´Â ¹İµå½Ã ¿µ¹®ÀÌ¾î¾ß ÇÑ´Ù.
   	if (zcIsBlank(obj) || (namestr.length == 0) ||
			(domainstr.indexOf(".") <= 0) ||
			(domainstr.indexOf("@") != -1) ||
			!(	(str.charAt(str.length-1) >= 'a' && str.charAt(str.length-1) <= 'z') || (str.charAt(str.length-1) >= 'A' && str.charAt(str.length-1) <= 'Z')	)
	){
			isValid = false;
	}
   	return isValid;
}

//  input ÇÊµå °´Ã¼(obj)ÀÇ °ªÀÌ blankÀÌ¸é true
function zcIsBlank( obj ) {
	var str = obj.value;
	return zcIsNull(str);
}


// strÀÌ null, undefined, NaN, °ø¹é("") ÀÌ¸é true
function zcIsNull(str) {
 	if (str+"" == "undefined" || str+"" == "NaN" || str+"" == "null" || str+"" == "")
 		return true;
	return false;
}

//  input ÇÊµå °´Ã¼(obj)ÀÇ °ªÀÌ ¿Ã¹Ù¸¥ ÁÖ¹Î¹øÈ£ÀÎÁö Ã¼Å©(123456-1234567 ÇüÅÂ, 1234561234567 ¸ğµÎ Ã¼Å© °¡´É)
function zcIsJumin( obj ) {
	var str = "";
	if (typeof obj=="object") str = obj.value;
	else			  str = obj;

	if(zcIsNull(str)) return false;	//°ø¹éÀÌ¶ó¸é

	str = zsRmString(str, "-");	// "-" Á¦°Å
	var  j=9
	var  id_chk=0

	object =  new Array(13)
	for(var i=0;i < 13;i++) {
		object[i] = str.substring(i,i+1)
	}
	var chkdigit = str.substring(12, 13)
	for(var i=0;i < 12;i++){
	    if( i == 8 )
	    j = 9
	    object[i]=object[i]*j
	    j--
	    id_chk +=object[i]
	}
    if(((id_chk%11 == 0) && (chkdigit == 1)) || ((id_chk%11 ==10)&& (chkdigit ==0))){
         return true;
    }
    else if((id_chk %11 != 0) && (id_chk % 11 != 10 ) && (id_chk % 11 == chkdigit)){
         return true;
    }
    else{
         return false;
    }
}

//  input ÇÊµå °´Ã¼(obj)ÀÇ °ªÀÌ ¿Ã¹Ù¸¥ ¹ıÀÎ¹øÈ£ÀÎÁöÃ¼Å©
function zcIsBupin(obj) {
	var str = "";
	if (typeof obj=="object") str = obj.value;
	else			  str = obj;

	if(zcIsNull(str)) return false;	//°ø¹éÀÌ¶ó¸é

	str = zsRmString(str, "-");	// "-" Á¦°Å

	var check = 1;
	var no = new Array(13);
	var sum = 0;
	var rem = 0;
	var m = 0;

	m = parseInt(str.charAt(12),10); // ¹øÈ£ÀÇ ¸¶Áö¸· ¼ıÀÚ ¾ò±â

	for(var i=0; i<12; i++) no[i] = parseInt(str.charAt(i),10); // 1~12±îÁö ¼ıÀÚ ¾ò±â

	for(var i=0; i<12; i++) {
		sum += (check * no[i]);
		check = (check==1) ? 2 : 1;
	}

	rem = sum % 10; // ³ª¸ÓÁö ±¸ÇÏ±â
	rem = 10 - rem;
	rem = (rem >= 10) ? rem - 10 : rem;

	// ¸¶Áö¸·¹øÂ°¿Í 10-remÀÇ °ªÀ» ºñ±³
	if(m == rem) return true; // Á¤È®
	else return false; // ºÎÁ¤È®
}

//  input ÇÊµå °´Ã¼(obj)ÀÇ °ªÀÌ ¿Ã¹Ù¸¥ ÁÖ¹Î(¹ıÀÎ)¹øÈ£ÀÎÁö Ã¼Å©(123456-1234567 ÇüÅÂ, 1234561234567 ¸ğµÎ Ã¼Å© °¡´É)
function zcIsPerid( obj ) {
	if(zcIsJumin(obj) || zcIsBupin(obj))	return true;
    	else  return false;
}

// input ÇÊµå °´Ã¼(obj)ÀÇ °ªÀÌ ¿Ã¹Ù¸¥ »ç¾÷ÀÚµî·Ï¹øÈ£ÀÎÁö Ã¼Å©
function zcIsResno(obj){
	var str = "";
	if (typeof obj=="object") str = obj.value;
	else			  str = obj;

	if(zcIsNull(str)) return false;	//°ø¹éÀÌ¶ó¸é

	str = zsRmString(str, "-");	// "-" Á¦°Å

	var check = 0;
	var no = new Array(10);
	var sum = 0;
	var tmpNo = 0;
	var tmpStr = 0;

	for(var i=0; i<10; i++) no[i] = parseInt(str.charAt(i),10); // 1~10±îÁö ¼ıÀÚ ¾ò±â

	for(var i=0; i<10; i++) {
		if((i%3)==0)
			tmpNo = no[i] + 0;
		else if ( (i%3) == 1)
			tmpNo = no[i] * 3;
		else if ( (i%3) == 2)
			tmpNo = no[i] * 7;

		if(i==8)
		{
			tmpNo = no[i] * 5;
			if(tmpNo > 9) {
				tmpStr = tmpNo + "";
				tmpNo = parseInt(tmpStr.charAt(0),10) + parseInt(tmpStr.charAt(1),10);
			}
		}
		sum += tmpNo;
	}
	if( (sum % 10) == 0) return true; // Á¤È®
	else return false; // ºÎÁ¤È®
}

// input ÇÊµå °´Ã¼(obj)ÀÇ °ªÀÌ ÁÖ¾îÁø ±æÀÌ(lengthInt)¿Í °°ÀºÁö Ã¼Å©
function zcIsCorrectLen(obj, lengthInt){
	var str = obj.value;
	if(zcIsNull(str)) return false;	//°ø¹éÀÌ¶ó¸é

	if( str.length == lengthInt)		// ¹®ÀÚ¿­ÀÇ ±æÀÌ¿Í lengthInt °¡ °°´Ù¸é
		return true;
	else return false;
}

// ÃÖ¼Ò Ã·ºÎÀÚ·á ÇÑ°³ ÀÌ»ó ¼±ÅÃÇÏ°Ô ÇÏ±â À§ÇØ ÆÄÀÏ Á¸Àç ¿©ºÎ Ã¼Å©
/*
function zcExistFile() {

	if(frmWrite.file1.value=="" && frmWrite.file2.value==""  && frmWrite.file3.value=="" ){
		alert(" Ã·ºÎ ÀÚ·á¸¦ ¼±ÅÃÇØ ÁÖ¼¼¿ä(ÃÖ¼ÒÇÑ°³ÀÌ»ó)");
		return;
	}

	frmWrite.action = "/ComnWeb/jsp/util/SaveFile.jsp";
	frmWrite.submit();
}
*/

// StringÀ» ¹Ş¾Æ¼­ 0~9 ±îÁöÀÇ ¼ıÀÚ¸¸ ¸®ÅÏÇØÁØ´Ù.
function zcReturnTelNo(str) {
	var retStr = "";

 	if (str+"" == "undefined" || str+"" == "NaN" || str+"" == "null" || str+"" == "") return retStr;

	for (var i = 0; i < str.length; i++) {
		if ( (str.charAt(i) >= '0') && (str.charAt(i) <= '9') ) {
			retStr = retStr + str.charAt(i);
		}
	}
	return retStr;
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////
//		¼öÁ¤ÆäÀÌÁö¿¡¼­ º¯°æµÈ °ÍÀÌ ÀÖ´ÂÁö Ã¼Å©
//			ÇÔ¼ö¸í : zcIsChanged() ÃÖÃÊ onload ½Ã zcInitData() ÇÔ¼ö°¡ È£ÃâµÇ°í var oData = new Array() ; °¡ Àü¿ªº¯¼ö·Î ¼±¾ğµÇ¾ßÇÔ
//			¼³  ¸í : Form ³»¿ëÁß º¯°æ»çÇ×À» Ã¼Å©ÇÏ¿© submit½Ã alertÇÔ scriptFormTest.html ¿¡¼­ È®ÀÎ
///////////////////////////////////////////////////////////////////////////////////////////////////////////
var oData = new Array() ; //ÃÖÃÊ form ¿¡ set µÇ´Â µ¥ÀÌÅ¸¸¦ ÀĞÀ» array

//Æû(diffForm¿¡ °¨½ÎÁø ÇÊµå)ÀÇ µ¥ÀÌÅ¸¸¦ ÀĞ¾î¼­ array¿¡ ÀúÀåÇÑ´Ù.
/*
function zcInitData(){
	for (i=0;i <document.diffForm.length;i++)
	{

		if(document.diffForm.elements[i].type=='button' || document.diffForm.elements[i].type=='submit'){
		}
		else if (document.diffForm.elements[i].type == 'checkbox'||document.diffForm.elements[i].type == 'radio') {
		    if (document.diffForm.elements[i].checked)
		    oData = oData.concat(document.diffForm.elements[i].value);
		}
		else if (document.diffForm.elements[i].type == 'select-one') {
		    if (document.diffForm.elements[i].value=="" ){
				return;
			}
			else{
				//ÀÔ·ÂÇÊµå¸¦ String¿¡ ºÙÀÌÀÚ
				oData = oData.concat(document.diffForm.elements[i].value);
			}
		}
		else if (document.diffForm.elements[i].type == 'textarea') {
		    if (document.diffForm.elements[i].value=="" ){
				return;
			}
			else{
				oData = oData.concat(document.diffForm.elements[i].value);
			}
		}
		else {
			if (document.diffForm.elements[i].value=="" ){
				return;
			}
			else{
				//ÀÔ·ÂÇÊµå¸¦ String¿¡ ºÙÀÌÀÚ
				oData = oData.concat(document.diffForm.elements[i].value);
			}
		}
	}
}
*/

/*
//ÃÖÃÊ ÀÔ·ÂµÈ °ª°ú submit ½Ã º¯°æµÈ °ªÀ» ºñ±³ÇÏ¿© °á°ú¸¦ ¸®ÅÏÇÑ´Ù.
function zcIsChanged(){
var chFlag = false;
var textVal = new Array() ;

	for (i=0;i <document.diffForm.length;i++)
	{

		if(document.diffForm.elements[i].type=='button' || document.diffForm.elements[i].type=='submit'){
		}
		else if (document.diffForm.elements[i].type == 'checkbox'||document.diffForm.elements[i].type == 'radio') {
		    if (document.diffForm.elements[i].checked)
		    textVal = textVal.concat(document.diffForm.elements[i].value);
		}
		else if (document.diffForm.elements[i].type == 'select-one') {
		    if (document.diffForm.elements[i].value=="" ){
				return;
			}
			else{
				//ÀÔ·ÂÇÊµå¸¦ String¿¡ ºÙÀÌÀÚ
				textVal = textVal.concat(document.diffForm.elements[i].value);
			}
		}
		else if (document.diffForm.elements[i].type == 'textarea') {
		    if (document.diffForm.elements[i].value=="" ){
				return;
			}
			else{
				textVal = textVal.concat(document.diffForm.elements[i].value);
			}
		}
		else {
			if (document.diffForm.elements[i].value=="" ){
				return;
			}
			else{
				//ÀÔ·ÂÇÊµå¸¦ String¿¡ ºÙÀÌÀÚ
				textVal = textVal.concat(document.diffForm.elements[i].value);
			}
		}
	}

	for (j=0;j <textVal.length;j++)
	{
		if (textVal[j] == oData[j])
		{
		}
		else
		{
		chFlag = true
		}
	}
	if (chFlag)
		alert("º¯°æµÈ ÇÊµå°¡ ÀÖ½À´Ï´Ù. ¼öÁ¤»çÇ×À»\n º¯°æÇÏ½Ã°Ú½À´Ï±î?");//submit(); À¸·Î ´ëÄ¡!
	else
		alert("º¯°æµÈ »çÇ×ÀÌ ¾ø½À´Ï´Ù.");
}
*/

// DDD ¹øÈ£¸¦ ³Ö¾î¼­ ¸Â´Â ¹øÈ£ÀÎÁö Ã¼Å©ÇÑ´Ù.
// ddd : DDD¹øÈ£
// gubun : 'tel'ÀÏ¹İÀüÈ­, 'mobile'ÈŞ´ëÀüÈ­
/*
function zcIsDDD(ddd, gubun) {
	if ( gubun == 'tel') {
		if ( ddd=="02"  || ddd=="031"  || ddd=="032" || ddd=="033" || ddd=="041" || ddd=="042" || ddd=="043" || ddd=="051" || ddd=="052" || ddd=="053"  || ddd=="054" || ddd=="055" || ddd=="061" || ddd=="062" || ddd=="063" || ddd=="064" || ddd=="060" || ddd=="080" )
			return true;
		else return false;
	} else if ( gubun == 'mobile') {
		if ( ddd=="010" || ddd=="011"  || ddd=="012" || ddd=="015" || ddd=="016" || ddd=="017" || ddd=="018" || ddd=="019" ) return true;
		else return false;
	} else if ( gubun == 'total') {
		if ( ddd=="02"  || ddd=="031"  || ddd=="032" || ddd=="033" || ddd=="041" || ddd=="042" || ddd=="043" || ddd=="051" || ddd=="052" || ddd=="053"  || ddd=="054" || ddd=="055" || ddd=="061" || ddd=="062" || ddd=="063" || ddd=="064" || ddd=="060" || ddd=="080" ||
		     ddd=="010" || ddd=="011"  || ddd=="012" || ddd=="015" || ddd=="016" || ddd=="017" || ddd=="018" || ddd=="019" )
			return true;
		else return false;
	} else {
		return false;
	}
}
*/



/* =====================================================================================================
   ÇÔ¼ö¸í : zd_xxxx()
   ¼³  ¸í : ³¯Â¥°ü·Ã Ã³¸®
========================================================================================================= */

// formatÀÇ ÇüÅÂ·Î Å¬¶óÀÌ¾ğÆ® pcÀÇ ÇöÀç ³¯ÀÚ¸¦ ¸®ÅÏÇÑ´Ù.
// format:  'ymd'(yyyymmdd), 'ymd_f'(yyyy-mm-dd), 'ymdhms'(yyyymmddhhmmss), 'ymdhms_f'(yyyy-mm-dd hh:mm:ss)
function zdGetToday(format) {
	var dNow = new Date();
	var yyyy = "";
	var MM   = "";
	var dd   = "";
	var hh = "";
	var mm   = "";
	var sss   = "";

	yyyy = dNow.getYear();
	MM   = dNow.getMonth()+1;
	dd   = dNow.getDate();
	hh   = dNow.getHours();
	mm   = dNow.getMinutes();
	sss  = dNow.getSeconds();

	yyyy = zdSetZero( yyyy, 4 );
	MM   = zdSetZero( MM,   2 );
	dd   = zdSetZero( dd,   2 );
	hh   = zdSetZero( hh,   2 );
	mm   = zdSetZero( mm,   2 );
	sss  = zdSetZero( sss,  2 );

	if (format == "ymd")
		return (yyyy + MM + dd);
	else if (format == "ymd_f")
		return (yyyy + "-" + MM + "-" + dd);
	else if (format == "ymdhms")
		return (yyyy + MM + dd + hh + mm + sss);
	else if (format == "ymdhms_f")
		return (yyyy + "-" + MM + "-" + dd + " " + hh + ":" + mm + ":" + sss);
}

// ¹®ÀÚ¿­(str)À» ³¯Â¥Çü½Ä¿¡ ÀÇÇØ '-' »ğÀÔÇÏ¿© ¸®ÅÏ
function zdSetDateDashStr(str) {
	//alert(zdIsDate(str));
	if(!zdIsDate(str)){		//¿Ã¹Ù¸¥ ÇüÅÂ°¡ ¾Æ´Ï¶ó¸é
		return false;
	}
	str = str.substr(0,4)+"-"+str.substr(4,2)+"-"+str.substr(6,2);
	return str;
}

// input ÇÊµå(obj)ÀÇ °ªÀ» ³¯Â¥Çü½Ä¿¡ ÀÇÇØ  4ÀÚ-2ÀÚ-2ÀÚ ÇüÅÂ·Î Áß°£¿¡ dash »ğÀÔ(20030101 -> 2003-01-01)
function zdSetDateDash(obj){
	var str = obj.value;
	if(zcIsNull(str)) return;	//°ø¹éÀÌ¶ó¸é
	obj.value = zdSetDateDashStr(str);
}

// ¹®ÀÚ¿­ÀÌ ³âµµÇüÅÂ ÀÌ¸é true
function zdIsYear(str){
	if(zcIsNull(str)) return false;	//°ø¹éÀÌ¶ó¸é
	var isValid=false;

	if(zcIsNumStr(str)){
		if(str.length==4 && (str.charAt(0)==1 || str.charAt(0)==2) && (str.charAt(1)==0 || str.charAt(1)==1 ||str.charAt(1)==9)){
			if(str>1000) isValid = true;
			}
	}
	return isValid;
}

//19000909ÇüÅÂ, 1900-09-09ÇüÅÂÀÇ ³¯Â¥(str)°¡  ¿Ã¹Ù¸¥ ³¯Â¥ÀÎÁö Ã¼Å©
function zdIsDate(str) {
	if(zcIsNull(str)) return false;	//°ø¹éÀÌ¶ó¸é

	var valid = true;
	var msg="";
	str =  zsRmString(str, "-");
	var birth = str;
	var yyyy = birth.substring(0,4);
	var mm = birth.substring(4,6);
	var dd = birth.substring(6,8);

	if ( birth.length != 8 || !zcIsNumStr(birth) ) {
		//alert("¿Ã¹Ù¸¥ ÀÏÀÚÇü½ÄÀÌ ¾Æ´Õ´Ï´Ù.\n¿¹) 20040101");
		return false;
	}

	if (!(yyyy.substring(0,2)=="19" || yyyy.substring(0,2)=="20" || yyyy.substring(0,4)=="9999")) {
		//msg+="³â ÀÔ·Â¿À·ù!\n";
		valid= false;
	}

	if (mm > 12 || mm < 1) {
		//msg+="¿ù ÀÔ·Â¿À·ù! (1~12)\n";
		valid =  false;
	}

	var chkdt = new Date( yyyy, mm-1, dd );
	if( chkdt.getYear() > 1900 && (chkdt.getYear() != yyyy || chkdt.getMonth() != (mm-1) || chkdt.getDate() != dd) ){
		//alert( msg+"³¯Â¥ÀÇ ÀÔ·ÂÀÌ Àß¸øµÇ¾ú½À´Ï´Ù.");
		return false;
	}
	else if( chkdt.getYear() < 1900 && ( chkdt.getYear() != yyyy.substring(2) || chkdt.getMonth() != (mm-1) || chkdt.getDate() != dd )){
		//alert( msg+"³¯Â¥ÀÇ ÀÔ·ÂÀÌ Àß¸øµÇ¾ú½À´Ï´Ù.");
		return false;
	}
	return true;
}


//190009ÇüÅÂ, 1900-09ÇüÅÂÀÇ ³¯Â¥(str)°¡  ¿Ã¹Ù¸¥ ³â¿ùÀÎÁö Ã¼Å©
function zdIsDateYM(str) {
	if(zcIsNull(str)) return false;	//°ø¹éÀÌ¶ó¸é

	var valid = true;
	var msg="";
	var birth = zsRmString(str, "-");
	var yyyy = birth.substring(0,4);
	var mm = birth.substring(4,6);

	if ((zcIsNull(birth) || birth.length != 6) || !zcIsNumStr(birth)) {
		//alert("¿Ã¹Ù¸¥ ³â¿ùÇü½ÄÀÌ ¾Æ´Õ´Ï´Ù.\n¿¹) 200401");
		return false;
	}

	if (!(yyyy.substring(0,2)=="19" || yyyy.substring(0,2)=="20")) {
		msg+="³â ÀÔ·Â¿À·ù!\n";
		valid= false;
	}

	if (mm > 12 || mm < 1) {
		msg+="¿ù ÀÔ·Â¿À·ù! (1~12)\n";
		valid =  false;
	}

	if (valid==false) alert(msg);

	return valid;
}

//235959ÇüÅÂ, 23.59.59ÇüÅÂÀÇ ½Ã°£(str)ÀÌ  ¿Ã¹Ù¸¥ ½Ã°£ÀÎÁö Ã¼Å©
function zdIsTime(str) {
	if(zcIsNull(str)) return false;	//°ø¹éÀÌ¶ó¸é

	var valid = true;
	var msg="";
	str =  zsRmString(str, ".");
	var time = str;
	var hour 	= time.substring(0,2);
	var minute 	= time.substring(2,4);
	var second 	= time.substring(4,6);

	if ((zcIsNull(time) || time.length != 6) || !zcIsNumStr(time)) {
		alert("¿Ã¹Ù¸¥ ½Ã°£Çü½ÄÀÌ ¾Æ´Õ´Ï´Ù.\n¿¹) 235959");
		return false;
	}

	if (hour > 23 || hour < 0) {
		msg+="½Ã(Hour) ÀÔ·Â¿À·ù! (00~23)\n";
		valid= false;
	}

	if (minute > 59 || minute < 0) {
		msg+="ºĞ(Minute) ÀÔ·Â¿À·ù! (00~59)\n";
		valid =  false;
	}

	if (second > 59 || second < 0) {
		msg+="ÃÊ(Second) ÀÔ·Â¿À·ù! (00~59)\n";
		valid =  false;
	}

	if (valid==false) alert(msg);

	return valid;
}

// ¹®ÀÚ¿­(str) À±³âÀÎÁö Ã¼Å©
function zdIsLeafYear(str) {
	if(zcIsNull(str)) return false;	//°ø¹éÀÌ¶ó¸é
	var YYYY = parseInt(str,10);
	//alert(YYYY);
	if ( ( (YYYY%4 == 0) && (YYYY%100 != 0) ) || (YYYY%400 == 0) ) {
		return true;
	}
	return false;
}





//	Date°´Ã¼¸¦  yyyy-mm-dd  hh:mm:ss ÀÇ ¹®ÀÚ¿­·Î ¸®ÅÏÇÑ´Ù.
// paramDateTimeÀÇ Å¸ÀÔÀº Date(³»Àå°´Ã¼)ÀÌ´Ù.
function zdGetDateTime(paramDateTime)
{
	var myDate = paramDateTime;
	var yy, mm, dd; // ³¯Â¥
	var ho, mi, se; // ½Ã°£

	yy=(myDate.getYear()<100) ? "19" + myDate.getYear() : myDate.getYear();
	mm = myDate.getMonth() + 1 ;
	mm = (mm < 10) ? "0" + mm : mm;
	dd = myDate.getDate();
	dd = (dd < 10) ? "0" + dd : dd;

	ho = myDate.getHours();
	mi = myDate.getMinutes();
	se = myDate.getSeconds();

	return (yy + "-" + mm + "-" + dd + " " + zdSetZero(ho,2) + ":" + zdSetZero(mi,2) + ":" + zdSetZero(se,2));
}

 /*---------------------------------------------------------------------------
    ÀÔ·ÂÇÊµå¿¡ ÀÔ·ÂÇÏ¸é¼­ ³¯Â¥ Çü½Ä ¸¸µé¾î ÁÖ±â
    ----------------------------------------------------------------------------*/
    function fn_date_format(obj, flag) {
        if (obj.value == null || obj.value == "" ) return;
        ls_val = (obj.value).substring((obj.value).length-1, (obj.value).length);
        //alert("before");
        zcIsNumAndInit(obj);
        str = zsRmObj(obj, '-');
        if (zcIsStrNumAndInit(str) == false) {
            obj.value = (obj.value).substring(0, (obj.value).length-1);
            obj.focus();
            return;    
        }
        ls_num = zsRmObj(obj, '-')
        //alert(ls_num);
        if (ls_num.length > 8) {
            obj.value = (obj.value).substring(0, (obj.value).length-1);
            obj.focus();
            return;    
        }
        if (ls_num.length == 8) {
            if (zdIsDate(ls_num) == false)    {
                obj.value = "";
                obj.focus();
                return;
            }
        }
        if (ls_num.length > 6) {
            obj.value = ls_num.substring(0,4) +flag+ls_num.substring(4,6)+flag+ls_num.substring(6,ls_num.length);
        }
        else if (ls_num.length > 4) {
            obj.value = ls_num.substring(0,4) +flag+ls_num.substring(4,ls_num.length);
        }
    }





// ¹®ÀÚ¿­ sValÀ» iLen±æÀÌ°¡ µÉ¶§±îÁö sValÀÇ ¾Õ¿¡ "0"À» ºÙÀÎ ¹®ÀÚ¿­À» ¸®ÅÏÇÑ´Ù. ±â¾÷Ã¼¹øÈ£µî¿¡¼­ ÀÚ¸®¼ö ¸¸Å­ 0À» ºÙ¿©¼­ ¹İÈ¯, ³¯Â¥ ¹®ÀÚ¿­ÀÇ ¿ù°ú ÀÏ¿¡ ¾²ÀÓ( 01¿ù 02ÀÏ)
// sVal - ¹®ÀÚ¿­
// iLen - ±æÀÌ(integer)
// ¿¹) sVal¿¡ '23'À» iLen¿¡ 5¸¦ ÁÖ¸é ¸®ÅÏ°ªÀº '00023' ÀÌ´Ù.
function zdSetZero(sVal, iLen){
	var sStr = "";
	if (typeof sVal=="object") {
		sStr = sVal.value;
		sStr = zsDelRLSpace(sStr);
	} else	sStr = String(sVal);

	if(zcIsNull(sStr)) return;	//°ø¹éÀÌ¶ó¸é

	for (ii = sStr.length; ii < iLen; ii++) {
		sStr =  "0" + sStr;
	}
	return sStr;
}

// µÎ ³¯Â¥ÀÇ Â÷ÀÌ¸¦ ³¯(ìí)¼ö·Î ¸®ÅÏÇÑ´Ù.
// basicDayStr¿¡¼­ compareDayStrÀ» »« ³¯Â¥¼ö ¸®ÅÏ
// ³¯Â¥ Çü½ÄÀº "YYYY-MM-DD" ¶Ç´Â "YYYYMMDD"ÀÌ´Ù.
function zdGetDifTodayInputday(basicDayStr, compareDayStr) {
	basicDayStr = zsRmString(basicDayStr, '-');		// '-'°¡ ÀÖ´Ù¸é Á¦°Å
	compareDayStr = zsRmString(compareDayStr, '-');
	if(!zdIsDate(basicDayStr) ||!zdIsDate(compareDayStr)) return false;		//³¯Â¥ Çü½ÄÀÌ ¾Æ´Ï¶ó¸é

	var date1  = new Date(basicDayStr.substring(0,4), basicDayStr.substring(4,6)-1, basicDayStr.substring(6,8) );
	var date2  = new Date(compareDayStr.substring(0,4), compareDayStr.substring(4,6)-1,compareDayStr.substring(6,8));

	return Math.floor(( date1 - date2 )*(1/(1000*60*60*24)));
}

// toDate°¡ fromDateº¸´Ù Å©¸é(ÃÖ±ÙÀÏÀÚ) true ¸®ÅÏ
function zdIsBig(toDate, fromDate) {
	toDate = zsRmString(toDate, '-');		// '-'°¡ ÀÖ´Ù¸é Á¦°Å
	fromDate = zsRmString(fromDate, '-');
	if(!zdIsDate(toDate) ||!zdIsDate(fromDate)) return false;		//³¯Â¥ Çü½ÄÀÌ ¾Æ´Ï¶ó¸é
	var fromYear = fromDate.substring(0,4);
	var fromMonth = fromDate.substring(4,6);
	var fromDay = fromDate.substring(6,8);
	var toYear = toDate.substring(0,4);
	var toMonth = toDate.substring(4,6);
	var toDay = toDate.substring(6,8);

	if (toYear > fromYear) return true
	else if (toYear < fromYear) return false

	if (toMonth > fromMonth) return true
	else if (toMonth < fromMonth) return false

	if (toDay > fromDay) return true

	return false
}

//±âÁØÀÏ  - ºñ±³ÀÏ ¿¡¼­ Â÷ÀÌ¸¦ ³â ¿ù ·Î ³Ñ°ÜÁØ´Ù.
/*
function zdDaysBetweenTwoDate(obj){

   	var yr,mo,ayr,amo, ry,rm,r1,r2,r3;            //º¯¼ö¸¦ ¼±¾ğÇÕ´Ï´Ù.


   	yr = obj.syear.value;
   	mo = obj.smonth.value;

   	ayr = obj.ayear.value;
   	amo = obj.amonth.value;
	if (isNaN(yr) || isNaN(mo) || isNaN(ayr) || isNaN(amo)) {
		window.alert("¼ıÀÚ¸¸ ÀÔ·Â ÇÏ¼¼¿ä");
		return;
	}

	if (zcIsNull(yr) || zcIsNull(mo) || zcIsNull(ayr) || zcIsNull(amo) ) {
		window.alert("³¯Â¥¸¦ ÀÔ·ÂÇÏ¼¼¿ä");
		return;
	}

	if (mo<1 || mo>12) {
		window.alert("À¯È¿ÇÑ ³¯Â¥°¡ ¾Æ´Õ´Ï´Ù");
		return ;
	}
	if (amo<1 || amo>12) {
		window.alert("À¯È¿ÇÑ ³¯Â¥°¡ ¾Æ´Õ´Ï´Ù");
		return ;
	}

   	r1 = parseInt((ayr - yr),10) ;
   	r2 = parseInt((amo - mo),10) ;
   	r3 = (r1 * 12) + r2

    if (r3 > 11) {
        ry = parseInt((r3/12),10);
        rm = r3%12 ;
    }
    else if (-12<r3< 0 ) {
		ry = 0;
		rm = r3%12 ;
    }
    else if (-12>r3 ) {
		ry = parseInt((r3/12),10);
        rm = r3%12 ;
    }
    else {
    		ry = 0;
		rm = r3 ;
    }
    alert (ry+"³â  "+rm+"°³¿ù Â÷ÀÌ");
   	//return(r);	                       //Â÷ÀÌ¸¦ ¹İÈ¯ÇÕ´Ï´Ù.
}
*/


/*
//  ±âÁØ³â¿ùÀÏ ¿¡¼­ ¸î³â ¸î°³¿ù ÈÄÀÇ ³¯Â¥ °ªÀ» ¹İÈ¯ÇÑ´Ù.
function zdGetChangeMonth(obj) {

	var yr,mo,dy,ayr,amo ;

   	yr = obj.bdate.value;
   	mo = obj.bdate1.value;
   	dy = obj.bdate2.value;

   	ayr = obj.bdate3.value;
   	amo = obj.bdate4.value;


    mo = zuToLen2(mo);
    dy = zuToLen2(dy);
    amo = zuToLen2(amo);

    if(amo < 0 || amo > 11) {
    	alert ('1 ~ 11 ¿ù ±îÁö¸¸ ÀÔ·ÂÇÏ¼¼¿ä');
    	return;
    }

   	fday = yr;
   	fday += mo;
   	fday += dy;
   	if (!zdIsDate(fday)){
   	   	return ;
	}

   	add = parseInt((ayr * 12),10) + parseInt(amo,10) ;

    var _dateObj = yr +""+mo+""+dy;

    var date_length =  _dateObj.length;

        dateYear  = _dateObj.substring(0, 4);
        dateMonth = parseInt( _dateObj.substring(4, 6) ,10);
        dateDay = _dateObj.substring(6, 8);

       var _dateYear  = dateYear
       var _dateMonth = dateMonth
       var _dateDay   = dateDay

    var add_month_time = 0;

    add_month_time += (zdGetEndOfMonthDay(_dateYear,_dateMonth)-_dateDay)*24*60*60*1000;

    for(var i=1; i < add;i++)
    {
        //alert(getEndOfMonthDay(_dateYear,_dateMonth))
        _dateMonth++;
        if(_dateMonth==13)
        {
          _dateYear ++;
          _dateMonth = 1;
        }
        add_month_time += zdGetEndOfMonthDay(_dateYear,_dateMonth)*24*60*60*1000;
    }

    add_month_time +=_dateDay*24*60*60*1000;


    var addDate = new Date(dateYear,dateMonth-1,dateDay);
    //alert(addDate);

    var newtimems=addDate.getTime()+add_month_time;
    addDate.setTime(newtimems);


    var newYear = addDate.getYear();
    if (newYear < 2000) newYear += 1900; // Y2K fix
    var newMonth = addDate.getMonth()+1;
    var newDay = addDate.getDate();

    alert( newYear.toString()+zuToLen2 (newMonth.toString())+ zuToLen2( newDay.toString()));
}
*/

//³â¿ù ÀÔ·Â½Ã ¸¶Áö¸· ÀÏÀÚ
function  zdGetEndOfMonthDay(  yy,  mm )
{

    var max_days=0;

    if (mm == 1)        max_days = 31 ;
    else if (mm == 2) {

        if ((( yy % 4 == 0) && (yy % 100 != 0)) || (yy % 400 == 0))
                        max_days = 29;
        else
                        max_days = 28;
    }
    else if (mm == 3)   max_days = 31;
    else if (mm == 4)   max_days = 30;
    else if (mm == 5)   max_days = 31;
    else if (mm == 6)   max_days = 30;
    else if (mm == 7)   max_days = 31;
    else if (mm == 8)   max_days = 31;
    else if (mm == 9)   max_days = 30;
    else if (mm == 10)  max_days = 31;
    else if (mm == 11)  max_days = 30;
    else if (mm == 12)  max_days = 31;
    else {

        return '';
    }
        return max_days;
}



/* =====================================================================================================
   ÇÔ¼ö¸í : zm_xxxx()
   ¼³  ¸í : ±İ¾× Ã³¸®
========================================================================================================= */

//  input ÇÊµå °´Ã¼(obj)ÀÇ °ªÀÌ ±İ¾×ÇüÅÂ(Á¤¼ö(0~9), ¸¶ÀÌ³Ê½º('-'), ¼Ò¼öÁ¡('.'), ÄŞ¸¶(',') )ÀÌ¸é true
function zmIsMoney( obj ) {
	var str = obj.value;
	if(zcIsNull(str)) return false;

	var isValid = true;
	var decCount = 0;		// number of decimal points in the string

	for (var i = 0; i < str.length; i++) {
		// track number of decimal points
		if (str.charAt(i) == ".") decCount++;

    	if ( !((str.charAt(i) >= "0" && str.charAt(i) <= "9") || str.charAt(i) == "-" || str.charAt(i) == "." || str.charAt(i) ==",")  ) {
      	 	isValid = false;
      	 	break;
		} else if ((str.charAt(i) == "-" && i != 0) ||
			   (str.charAt(i) == "." && str.length == 1) ||
			   (str.charAt(i) == "." && decCount > 1)) {
	       		isValid = false;
	      	 	break;
	    }
   	}
   	return isValid;
}

// input ÇÊµå °´Ã¼(obj)¿¡ ±İ¾× ÀÔ·Â½Ã, ½Ç½Ã°£À¸·Î 3ÀÚ¸® ¸¶´Ù ,¸¦ »ğÀÔ
// onkeyup¿¡ ÀÌº¥Æ® ¹ß»ı½Ã Æã¼ÇÀ» È£ÃâÇÑ´Ù!
//  	**CustomTag¿¡¼­ »ç¿ëÇÏ°í ÀÖÀ¸¹Ç·Î Æã¼Ç º¯°æ(Æ¯È÷ ÀÌ¸§)¿¡ ÁÖÀÇ¸¦ ¿äÇÔ!
function zmSetCommaRT(obj){
	var str = obj.value;
	var rtVal;

	if( event.keyCode == 37 || event.keyCode == 39 ) return;
	if ( obj.format == 'money' || obj.format == 'moneyDot' || obj.format == 'bigDecimal') rtVal = zmSetMoneyComma(str);
	else if ( obj.format == 'moneyZero' ) 			rtVal = zmSetMoneyZero(str);
	else if ( obj.format == 'millionMoney' ) 		rtVal = zmWon2Million(str);
	else if ( obj.format == 'millionMoneyZero' ) 	rtVal = zmWon2MillionZero(str);
	else if ( obj.format == 'thousandMoney' ) 		rtVal = zmWon2Thousand(str);
	else if ( obj.format == 'thousandMoneyZero' ) 	rtVal = zm_won2ThousandZero(str);

	if(rtVal != str)
		obj.value = rtVal;

}

// ±İ¾× ¹®ÀÚ¿­(str)¿¡ ÄŞ¸¶(,) °¡ ÀÖÀ¸¸é ¾ø¾Ö°í ½Ç¼ö ¹®ÀÚ¿­À» ¸®ÅÏ
function zmDelComma(str){
	if(zcIsNull(str)) return "";		//°ªÀÌ nullÀÌ¶ó¸é
	str = zsRmString(str, ',');				// , Á¦°Å
	return str;
}

// ±İ¾× ¹®ÀÚ¿­(str)¿¡ 3ÀÚ¸®¸¶´Ù ÄŞ¸¶Ãß°¡ÇÑ ¹®ÀÚ¿­À» ¸®ÅÏ
function zmSetMoneyComma(str){
	var rtStr;	// ¸®ÅÏÇÒ ¹®ÀÚ¿­

	//°ªÀÌ null ÀÌ³ª 0 ÀÌ¸é blank
	if(zcIsNull(str) ) return "";

	//Ã¹ÀÚ°¡ -ÀÏ¶§ -¸¦ »«±İ¾×À¸·Î Ã³¸®ÇÏ°í ³ªÁß¿¡ -ºÙÀÓ
	var minus = "";
	if(str.substring(0,1) == "-"){
		rtStr = str.substring(1);		// '-' »« ¹®ÀÚ ÀúÀå
		minus = "-";
	}else								// ±×¿ÜÀÇ ¸ğµç °æ¿ì
		rtStr = str;

	//¼Ò¼öÁ¡ ÀÖÀ»¶§ ¾ÕºÎºĞ¸¸ rtStr¿¡ ³Ö¾îÃ³¸®ÇÏ°í µŞºÎºĞÀº µû·Î ¶¼ µÎ¾ú´Ù°¡ ³ªÁß¿¡ ºÙÀÓ.
	var belowzero = "";
	if (zmChkDot(rtStr)==true){
		arr = rtStr.split(".");
		rtStr = arr[0];		     	//¼Ò¼öÁ¡ ¾ÕºÎºĞ
		belowzero = "." + arr[1];   //¼Ò¼öÁ¡°ú ±× µŞºÎºĞ
	}

	// ±âÁ¸ÄŞ¸¶Á¦°Å
	rtStr = zsRmString(rtStr, ',');

	var len = rtStr.length ;
	var result ="";

	if (len > 1 && str.substring(0,1)=="0") rtStr = rtStr.substring(1); // Ã¹¹øÂ° 0ÀÌ ÀÖÀ¸¸é Á¦°Å

	for (var i=0; i < len;i++){  // ÀÌÁ¦ ½ÇÁ¦·Î ÄŞ¸¶ Ç¥½ÃÇÔ
		comma="";
		var schar = rtStr.charAt(i);
		where = len - 1 - i;
		if ((where % 3) == 0 && len > 3 && where != 0) comma = ",";
		result = result +   schar + comma ;
	}
    rtStr = minus + result + belowzero;	// - ¿Í ¼Ò¼öÁ¡ ÀÌÇÏ¸¦ ºÙÀÓ

	return rtStr;
}

// ±İ¾× ¹®ÀÚ¿­(str)¿¡ 3ÀÚ¸®¸¶´Ù ÄŞ¸¶Ãß°¡ÇÑ ¹®ÀÚ¿­À» ¸®ÅÏ
function zmSetMoneyZero(str){
	var rtStr;	// ¸®ÅÏÇÒ ¹®ÀÚ¿­

	//°ªÀÌ nullÀÌ¶ó¸é blank
	if ( zcIsNull(str) ) return "";
	//°ªÀÌ 0ÀÌ¸é ±×´ë·Î 0
	if ( str=="0" || str=="0.0") return str;

	//Ã¹ÀÚ°¡ -ÀÏ¶§ -¸¦ »«±İ¾×À¸·Î Ã³¸®ÇÏ°í ³ªÁß¿¡ -ºÙÀÓ
	var minus = "";
	if(str.substring(0,1) == "-"){
		rtStr = str.substring(1);	// '-' »« ¹®ÀÚ ÀúÀå
		minus = "-";
	}else							// ±×¿ÜÀÇ ¸ğµç °æ¿ì
		rtStr = str;

	//¼Ò¼öÁ¡ ÀÖÀ»¶§ ¾ÕºÎºĞ¸¸ rtStr¿¡ ³Ö¾îÃ³¸®ÇÏ°í µŞºÎºĞÀº µû·Î ¶¼ µÎ¾ú´Ù°¡ ³ªÁß¿¡ ºÙÀÓ.
	var belowzero = "";
	if (zmChkDot(rtStr)==true){
		arr = rtStr.split(".");
		rtStr = arr[0];		     	//¼Ò¼öÁ¡ ¾ÕºÎºĞ
		belowzero = "." + arr[1];   //¼Ò¼öÁ¡°ú ±× µŞºÎºĞ
	}

	// ±âÁ¸ÄŞ¸¶Á¦°Å
	rtStr = zsRmString(rtStr, ',');

	var len = rtStr.length ;
	var result ="";

	if (len > 1 && str.substring(0,1)=="0") rtStr = rtStr.substring(1); // Ã¹¹øÂ° 0ÀÌ ÀÖÀ¸¸é Á¦°Å

	for (var i=0; i < len;i++){  // ÀÌÁ¦ ½ÇÁ¦·Î ÄŞ¸¶ Ç¥½ÃÇÔ
		comma="";
		var schar = rtStr.charAt(i);
		where = len - 1 - i;
		if ((where % 3) == 0 && len > 3 && where != 0) comma = ",";
		result = result +   schar + comma ;
	}
    rtStr = minus + result + belowzero;	// - ¿Í ¼Ò¼öÁ¡ ÀÌÇÏ¸¦ ºÙÀÓ
	return rtStr;
}

// "¿ø"´ÜÀ§ ±İ¾×(str)À» ÄŞ¸¶±îÁö Ãß°¡ÇÑ "¹é¸¸" ´ÜÀ§·Î º¯È¯ÇÑ ¹®ÀÚ¿­À» ¸®ÅÏ(5000900000 => 5,000)
function zmWon2Million(str) {
	//°ªÀÌ nullÀÌ¶ó¸é blank ¸®ÅÏ
	if(zcIsNull(str)) return "";

	if (zmChkDot(str)==true){	//¼Ò¼öÁ¡ ÀÌÇÏºÎºĞÀº »èÁ¦ÇÔ
		arr = str.split(".");
		str = arr[0];			//¼Ò¼öÁ¡ ¾ÕºÎºĞ
	}
	var len = str.length;

	if(len > 6){
		var outputDataLen = len - 6; //Ãâ·Â ±İ¾×ÀÇ ÀÚ¸®¼ö : Ç¥ÇöÇÏ´Â ±İ¾×ÀÇ ´ÜÀ§°¡ ¹é¸¸¿ø ÀÌ¹Ç·Î 000000À» »©±â À§ÇØ "ÀüÃ¼±æÀÌ-6"À» ÇÑ´Ù.
		var outputData = str.substr(0, outputDataLen);
		if(outputData.length > 3){
			outputData = zmSetMoneyComma(outputData);   // 3ÀÚ¸®¸¶´Ù ","¸¦ Ãß°¡ÇÏ´Â ½ºÅ©¸³Æ® È£Ãâ
		}
		return outputData;
	}else{
		return "0"; //³Ñ¾î¿Â µ¥ÀÌÅ¸°¡ 6ÀÚ¸® ÀÌÇÏÀÏ °æ¿ì 0 »Ñ¸².
	}
}

// "¿ø"´ÜÀ§ ±İ¾×(str)À» ÄŞ¸¶±îÁö Ãß°¡ÇÑ "¹é¸¸" ´ÜÀ§·Î º¯È¯ÇÑ ¹®ÀÚ¿­À» ¸®ÅÏ(5000900000 => 5,000)
function zmWon2MillionZero(str) {
	//°ªÀÌ nullÀÌ¶ó¸é 0 ¸®ÅÏ
	if(zcIsNull(str)) return "0";

	if (zmChkDot(str)==true){          //¼Ò¼öÁ¡ ÀÌÇÏºÎºĞÀº »èÁ¦ÇÔ
		arr = str.split(".");
		str = arr[0];		     //¼Ò¼öÁ¡ ¾ÕºÎºĞ
	}
	var len = str.length;

	if(len > 6){
		var outputDataLen = len - 6; //Ãâ·Â ±İ¾×ÀÇ ÀÚ¸®¼ö : Ç¥ÇöÇÏ´Â ±İ¾×ÀÇ ´ÜÀ§°¡ ¹é¸¸¿ø ÀÌ¹Ç·Î 000000À» »©±â À§ÇØ "ÀüÃ¼±æÀÌ-6"À» ÇÑ´Ù.
		var outputData = str.substr(0, outputDataLen);
		if(outputData.length > 3){
			outputData = zmSetMoneyComma(outputData);   // 3ÀÚ¸®¸¶´Ù ","¸¦ Ãß°¡ÇÏ´Â ½ºÅ©¸³Æ® È£Ãâ
		}
		return outputData;
	}else{
		return "0"; //³Ñ¾î¿Â µ¥ÀÌÅ¸°¡ 6ÀÚ¸® ÀÌÇÏÀÏ °æ¿ì 0 »Ñ¸².
	}
}

// "¿ø"´ÜÀ§ ±İ¾×(str)À» ÄŞ¸¶±îÁö Ãß°¡ÇÑ "Ãµ" ´ÜÀ§·Î º¯È¯ÇÑ ¹®ÀÚ¿­À» ¸®ÅÏ(5000900900 => 5,000,900)
function zmWon2Thousand(str) {
	//°ªÀÌ nullÀÌ¶ó¸é blank ¸®ÅÏ
	if(zcIsNull(str)) return "";

	if (zmChkDot(str)==true){          //¼Ò¼öÁ¡ ÀÌÇÏºÎºĞÀº »èÁ¦ÇÔ
		arr = str.split(".");
		str = arr[0];		     //¼Ò¼öÁ¡ ¾ÕºÎºĞ
	}
	var len = str.length;

	if(len > 3){
		var outputDataLen = len - 3; //Ãâ·Â ±İ¾×ÀÇ ÀÚ¸®¼ö : Ç¥ÇöÇÏ´Â ±İ¾×ÀÇ ´ÜÀ§°¡ ¹é¸¸¿ø ÀÌ¹Ç·Î 000000À» »©±â À§ÇØ "ÀüÃ¼±æÀÌ-6"À» ÇÑ´Ù.
		var outputData = str.substr(0, outputDataLen);
		if(outputData.length > 3){
			outputData = zmSetMoneyComma(outputData);   // 3ÀÚ¸®¸¶´Ù ","¸¦ Ãß°¡ÇÏ´Â ½ºÅ©¸³Æ® È£Ãâ
		}
		return outputData;
	}else{
		return "0"; //³Ñ¾î¿Â µ¥ÀÌÅ¸°¡ 3ÀÚ¸® ÀÌÇÏÀÏ °æ¿ì 0 »Ñ¸².
	}
}

// "¿ø"´ÜÀ§ ±İ¾×(str)À» ÄŞ¸¶±îÁö Ãß°¡ÇÑ "Ãµ" ´ÜÀ§·Î º¯È¯ÇÑ ¹®ÀÚ¿­À» ¸®ÅÏ(5000900900 => 5,000,900)
function zm_won2ThousandZero(str) {
	//°ªÀÌ nullÀÌ¶ó¸é 0 ¸®ÅÏ
	if(zcIsNull(str)) return "0";

	if (zmChkDot(str)==true){          //¼Ò¼öÁ¡ ÀÌÇÏºÎºĞÀº »èÁ¦ÇÔ
		arr = str.split(".");
		str = arr[0];		     //¼Ò¼öÁ¡ ¾ÕºÎºĞ
	}
	var len = str.length;

	if(len > 3){
		var outputDataLen = len - 3; //Ãâ·Â ±İ¾×ÀÇ ÀÚ¸®¼ö : Ç¥ÇöÇÏ´Â ±İ¾×ÀÇ ´ÜÀ§°¡ ¹é¸¸¿ø ÀÌ¹Ç·Î 000000À» »©±â À§ÇØ "ÀüÃ¼±æÀÌ-6"À» ÇÑ´Ù.
		var outputData = str.substr(0, outputDataLen);
		if(outputData.length > 3){
			outputData = zmSetMoneyComma(outputData);   // 3ÀÚ¸®¸¶´Ù ","¸¦ Ãß°¡ÇÏ´Â ½ºÅ©¸³Æ® È£Ãâ
		}
		return outputData;
	}else{
		return "0"; //³Ñ¾î¿Â µ¥ÀÌÅ¸°¡ 3ÀÚ¸® ÀÌÇÏÀÏ °æ¿ì 0 »Ñ¸².
	}
}

// ±İ¾×¿¡ ¼Ò¼öÁ¡ ÀÖ´ÂÁö Ã¼Å©. Á¸ÀçÇÑ´Ù¸é true, ¾ø´Ù¸é false
function zmChkDot(str){
	for (var i=0; i< str.length; i++) {
		if(str.charAt(i) == "." )	return true;
	}
	return false;
}


/* =====================================================================================================
   ÇÔ¼ö¸í : zs_xxxx()
   ¼³  ¸í : Character, String, number Ã³¸®(Ã¼Å©/°è»êÀº Á¦¿Ü - check.js¿¡ Æ÷ÇÔ)
========================================================================================================= */

/**
 *  ÀÔ·ÂµÈ ½ºÆ®¸µÀÇ ¹ÙÀÌÆ®¼ö¸¦ ¸®ÅÏÇÑ´Ù.
 *  @val       : ±æÀÌ¸¦ Ã¼Å©ÇÒ ½ºÆ®¸µ
 */
function zsGetBytesLength(val) {
    // ÀÔ·Â¹ŞÀº ¹®ÀÚ¿­À» escape() ¸¦ ÀÌ¿ëÇÏ¿© º¯È¯ÇÑ´Ù.
    // º¯È¯ÇÑ ¹®ÀÚ¿­ Áß À¯´ÏÄÚµå(ÇÑ±Û µî)´Â °øÅëÀûÀ¸·Î %uxxxx·Î º¯È¯µÈ´Ù.
    var temp_estr = escape(val);
    var s_index   = 0;
    var e_index   = 0;
    var temp_str  = "";
    var cnt       = 0;

    // ¹®ÀÚ¿­ Áß¿¡¼­ À¯´ÏÄÚµå¸¦ Ã£¾Æ Á¦°ÅÇÏ¸é¼­ °¹¼ö¸¦ ¼¾´Ù.
    while ((e_index = temp_estr.indexOf("%u", s_index)) >= 0)  // Á¦°ÅÇÒ ¹®ÀÚ¿­ÀÌ Á¸ÀçÇÑ´Ù¸é
    {
      temp_str += temp_estr.substring(s_index, e_index);
      s_index = e_index + 6;
      cnt ++;
    }

    temp_str += temp_estr.substring(s_index);

    temp_str = unescape(temp_str);  // ¿ø·¡ ¹®ÀÚ¿­·Î ¹Ù²Û´Ù.

    // À¯´ÏÄÚµå´Â 2¹ÙÀÌÆ® ¾¿ °è»êÇÏ°í ³ª¸ÓÁö´Â 1¹ÙÀÌÆ®¾¿ °è»êÇÑ´Ù.
    
    return ((cnt * 2) + temp_str.length) + "";
    
    //return ((cnt * 3) + temp_str.length) + "";
}

/**
 *  ÀÔ·ÂµÈ ½ºÆ®¸µÀÇ ¹ÙÀÌÆ®¼ö¸¦ Ã¼Å©ÇÏ¿© ÇÑ°èÄ¡º¸´Ù Å©¸é
 *  alert ¸Ş¼¼Áö¸¦ ¶ç¿î´Ù.
 *  onkeypress ÀÌº¥Æ®¿¡ Àû¿ëÇÑ´Ù.
 *  @obj       : ±æÀÌ¸¦ Ã¼Å©ÇÒ °´Ã¼
 *  @limitLen  : ÃÖ´ë±æÀÌ
 *  @msgFlag   : alert ¸Ş¼¼Áö Ãâ·Â¿©ºÎ
 */
function zsGetBytesLengthRT(obj, limitLen, msgFlag) {
    var val = obj.value;
    var leng = zsGetBytesLength(val);
    var result = true;
    var msg = '';

    // ÃÖ´ë±æÀÌ¿Í ÇöÀç ½ºÆ®¸µÀÇ ¹ÙÀÌÆ®¼ö°¡ °°À¸¸é.
    if (leng == limitLen) {
        msg = "´õ ÀÌ»ó ÀÔ·ÂÇÏ½Ç ¼ö ¾ø½À´Ï´Ù.\n\n" +
              "ÀÔ·ÂÇÏ½Ç ¼ö ÀÖ´Â ÃÖ´ë ¹®ÀÚ¿­ ±æÀÌ°¡ ÀÌ¹Ì ÀÔ·ÂµÇ¾ú½À´Ï´Ù.";
        result = false;
    }

    if (msgFlag) alert(msg);
    event.returnValue = result;
}

/**
 *  ÀÔ·ÂµÈ ½ºÆ®¸µÀÇ ¹ÙÀÌÆ®¼ö¸¦ Ã¼Å©ÇÏ¿© ÇÑ°èÄ¡º¸´Ù Å©¸é
 *  alert ¸Ş¼¼Áö¸¦ ¶ç¿î´Ù.
 *  onblur ÀÌº¥Æ®¿¡ Àû¿ëÇÑ´Ù.
 *  @obj       : ±æÀÌ¸¦ Ã¼Å©ÇÒ °´Ã¼
 *  @limitLen  : ÃÖ´ë±æÀÌ
 *  @msgFlag   : alert ¸Ş¼¼Áö Ãâ·Â¿©ºÎ
 */
function zsGetBytesLengthRTBlur(obj, limitLen, msgFlag) {
    var val = obj.value;
    var leng = zsGetBytesLength(val);
    var result = true;
    var msg = '';

    if (leng > limitLen) {
        msg = "ÀÔ·ÂÇÏ½Ç ¼ö ÀÖ´Â ÃÖ´ë ¹®ÀÚ¿­ ±æÀÌ¸¦ ÃÊ°úÇÏ¿´½À´Ï´Ù.\n\n" +
              "ÃÖ´ë ÀÔ·Â°¡´É ¹®ÀÚ¿­ ±æÀÌ => " + limitLen + "\n" +
              "ÀÔ·ÂÇÏ½Å ¹®ÀÚ¿­ ±æÀÌ => " + leng;
        result = false;
    }

    if (!result) {
        if (msgFlag) alert(msg);
        obj.focus();
    }
}

/**
 *  ÇØ´ç textareaÀÇ ¶óÀÎ¼ö¸¦ ¸®ÅÏÇÕ´Ï´Ù.
 *  @sourceObject  textarea °´Ã¼
 *  @columnSize    ÇÑ lineÀ¸·Î °£ÁÖÇÒ ÄÃ·³ »çÀÌÁî
 *
 *  @columnSize °¡ ÀÔ·ÂµÇÁö ¾ÊÀ¸¸é ÇØ´ç °´Ã¼ÀÇ cols¼Ó¼º°ªÀ» »ç¿ëÇÕ´Ï´Ù.
 */
function zsGetLineCount(sourceObject, columnSize) {
    var sourceString = sourceObject.value;
    var colSize = (arguments.length == 1) ? (new Number(sourceObject.cols)) : columnSize;
    var strArr = sourceString.split('\r\n');
    var arrCnt = strArr.length;
    var tempLeng = 0;
    var tempMod  = 0;
    var append = 0;
    var result = 0;

    for (var i=0; i<arrCnt; i++) {
        append = 0;
        tempLeng = zsGetBytesLength(strArr[i]);

        // ºó ¶óÀÎÀÏ¶§
        if (tempLeng == 0) {
            append = 1;
        }
        else {
            if ((tempLeng % colSize) > 0) append = 1;
            append = append + Math.floor(tempLeng / colSize);
        }
        result = result + append;
    }

    return result;
}

// input ÇÊµå °´Ã¼ÀÇ °ª(obj)¿¡¼­  Æ¯Á¤¹®ÀÚ(org)¸¦ rep¹®ÀÚ·Î º¯È¯
function zsChgChar(obj,orgStr,repStr){
	str = obj.value;
	re = new RegExp(orgStr, "g");
	obj.value = str.replace(re, repStr);
}

// ÆûÀüÃ¼ ¹®ÀÚ¿­¿¡ ÀÖ´Â ´õºíÄõÅ×ÀÌ¼Ç(")À» ½ÌÅ¬ÄõÅ×ÀÌ¼Ç(')À¸·Î º¯°æÇÑ´Ù.
function zsDouble2SingleQuatForm(formObj) {
	var len=formObj.elements.length;
	var i=0;

	for ( i=0; i<len; i++ ) {
		formObj.elements[i].value = top.zsDouble2SingleQuat(formObj.elements[i].value);
	}
}
// ´õºíÄõÅ×ÀÌ¼Ç(")À» ½ÌÅ¬ÄõÅ×ÀÌ¼Ç(')À¸·Î º¯°æÇÑ´Ù.
function zsDouble2SingleQuat(Str) {
	while (true) {
	   if ( Str.indexOf("\"") < 0)
	      break;
	   Str = Str.replace("\"", "'");
	}
	return Str;
}



// RealTimeÀ¸·Î »ç¿ëÀÚ°¡ ¼ıÀÚ¸¦ ÀÔ·ÂÇÏ´Â¼ø°£ .(dot)¸¦ Áß°£¿¡ ¹Ù·Î Ãß°¡
//	onkeyup ÀÌº¥Æ®¿¡ È£ÃâÇÏµµ·Ï ÇÑ´Ù!
// gubun : dash »ğÀÔÆĞÅÏ ±¸ºĞÀÚ ¹®ÀÚ¿­
//	"time":½Ã°£(½Ã.ºĞ.ÃÊ)
//				*** CustomTag¿¡¼­ »ç¿ëÇÏ°í ÀÖÀ¸¹Ç·Î Æã¼Ç º¯°æ(Æ¯È÷ Æã¼Ç¸í°ú gubun)¿¡ ÁÖÀÇ¸¦ ¿äÇÔ!
function zsSetDotRT(obj, gubun) {
	if ( gubun == "time" && (!(event.keyCode == 8 || event.keyCode <= 46)) ) zsSetDot(obj, gubun);
}

// RealTimeÀÌ ¾Æ´Ñ°æ¿ì¿¡ ´ëÇØ .(dot)¸¦ Áß°£¿¡ Ãß°¡ÇØÁØ´Ù
function zsSetDot(obj, gubun) {
	obj.value = zsSetDotStr(obj.value, gubun);
}

// RealTimeÀÌ ¾Æ´Ñ°æ¿ì¿¡ ´ëÇØ .(dot)¸¦ Áß°£¿¡ Ãß°¡ÇÑ ¹®ÀÚ¿­À» ¸®ÅÏ
function zsSetDotStr(str, gubun) {
	var retStr = str;
	data = str.toUpperCase();
	data_1 = zsRmString(data, ".");	// "." Á¦°Å

	// ½Ã°£ 2ÀÚ.2ÀÚ.2ÀÚ ÇüÅÂ·Î Áß°£¿¡ .(dot) »ğÀÔ
	if (gubun == "time") {
		if (data.length > 8) {
			retStr = data_1.substring(0,2) + "." + data_1.substring(2,4) + "." + data_1.substring(4,6);
		} else if (data.length > 5) {
			if (data.substring(2,3)=="." && data.substring(4,5)==".") return str;
			else retStr = data_1.substring(0,2) + "." + data_1.substring(2,4) + "." + data_1.substring(4,6);
		} else if (data.length > 2) {
			if (data.substring(2,3)==".") return str;
			else retStr = data_1.substring(0,2) + "." + data_1.substring(2);
		}
	}

	return retStr;
}




// strÀÇ ¹®ÀÚ¿­Áß rmCharÀÇ Æ¯Á¤ ¹®ÀÚ¸¸ »èÁ¦ÇÑ ¹®ÀÚ¿­À» ¸®ÅÏ.
//	rmChar´Â ±æÀÌ 1ÀÇ ¹®ÀÚ
function zsRmString(str, rmChar){
	//nullÀÌ ÀÖ´Ù¸é
	if(zcIsNull(str) || zcIsNull(rmChar)) return false;

	// ÇÑÀÚ¸®ÀÇ rmCharÀÎÁö Ã¼Å©
	if(rmChar.length != 1){
		alert("[½ºÅ©¸³Æ® »ç¿ë ¿À·ù]\r\n rmStr¿¡´Â 1ÀÚ¸®ÀÇ ¹®ÀÚ¸¸ ¿Ã ¼ö ÀÖ½À´Ï´Ù.");
		return;
	}
	var len = str.length;
	var rtValue = "";

	for(var i =0 ; i < len ; i++){
		if(str.charAt(i) != rmChar && str.charAt(i) != " "){
			rtValue += str.charAt(i);
		}
	}
	return rtValue;
}

// objÀÇ value ¹®ÀÚ¿­Áß rmCharÀÇ Æ¯Á¤ ¹®ÀÚ¸¸ »èÁ¦ÇÑ ¹®ÀÚ¿­À» ¸®ÅÏ.
//	rmChar´Â ±æÀÌ 1ÀÇ ¹®ÀÚ
function zsRmObj(obj, rmChar){
	str = obj.value;
	//nullÀÌ ÀÖ´Ù¸é
	if(zcIsNull(str) || zcIsNull(rmChar)) return false;

	// ÇÑÀÚ¸®ÀÇ rmCharÀÎÁö Ã¼Å©
	if(rmChar.length != 1){
		alert("[½ºÅ©¸³Æ® »ç¿ë ¿À·ù]\r\n rmStr¿¡´Â 1ÀÚ¸®ÀÇ ¹®ÀÚ¸¸ ¿Ã ¼ö ÀÖ½À´Ï´Ù.");
		return;
	}
	var len = str.length;
	var rtValue = "";

	for(var i =0 ; i < len ; i++){
		if(str.charAt(i) != rmChar && str.charAt(i) != " "){
			rtValue += str.charAt(i);
		}
	}
	return rtValue;
}

// input ÇÊµå °´Ã¼ÀÇ °ª(obj)¿¡¼­  ¾çÂÊ ½ºÆäÀÌ½ºµé Á¦°Å
function zsDelRLSpace(obj) {
		str = zsDelLSpace( obj );
		str = zsDelRSpace( obj );
}

// input ÇÊµå °´Ã¼ÀÇ °ª(obj)¿¡¼­  ¿ŞÂÊ½ºÆäÀÌ½ºµé Á¦°Å
function zsDelLSpace(obj) {
	var str = obj.value;

	if(str != ""){
		var iLen = str.length;
		var idx = 0;
		for(idx=0 ; idx<iLen; idx++)
		{
			if(str.charAt(idx)!=' ') break;
		}
		obj.value = str.substring(idx, iLen);
	}
}

// input ÇÊµå °´Ã¼ÀÇ °ª(obj)¿¡¼­ ¿À¸¥ÂÊ ½ºÆäÀÌ½ºµé Á¦°Å
function zsDelRSpace(obj) {
	var str = obj.value;

	if(str != ""){
		var iLen = str.length;
		var idx = 0;
		for(idx=iLen-1 ; idx>=0; idx--)
		{
			if(str.charAt(idx)!=' ') break;
		}
		obj.value = str.substring( 0,idx+1 );
	}
}

function zsRLTrim(str) {
	str = zsLTrim(str);
	str = zsRTrim(str);
	return str;
}
function zsLTrim(str) {
	if (str == "") return "";

	var iLen = str.length;
	var idx = 0;
	for(idx=0 ; idx<iLen; idx++)
	{
		if(str.charAt(idx)!=' ') break;
	}
	return str.substring(idx, iLen);

}
function zsRTrim(str) {
	if (str == "") return "";

	var iLen = str.length;
	var idx = 0;
	for(idx=iLen-1 ; idx>=0; idx--)
	{
		if(str.charAt(idx)!=' ') break;
	}
	return str.substring( 0,idx+1 );
}


/* =====================================================================================================
   ÇÔ¼ö¸í : zu_xxxx() , ÀÌ¹ÌÁöÃ³¸®ºÎºĞÀº Á¦¿Ü MM_xxxx
   ¼³  ¸í : À¯Æ¿¼º ½ºÅ©¸³Æ® Æã¼Ç
========================================================================================================= */

// ¿ÀÁ÷ ¼ıÀÚ¸¸ ÀÔ·Â°¡´ÉÇÏ°Ô ¸¸µå´Â Æã¼Ç.(onkeypress ÀÌº¥Æ®¿¡ È£ÃâÇÑ´Ù)
function zuInputNumRT(obj){
	var keycode = event.keyCode;

	if( !((48 <= keycode && keycode <=57) || keycode == 13 || keycode == 45) )
		event.keyCode = 0;		// ÀÌº¥Æ® cancel
}

// Æû°´Ã¼(formObj) ³»¿¡ ÀÖ´Â text(read onlyÁ¦¿Ü) ¹Ú½º, radio , single select box °ªÀ» ÃÊ±âÈ­½ÃÅ²´Ù.
// readonlyµµ ÃÊ±âÈ­ button skip hidden textarea ÃÊ±âÈ­ Ã³¸® - 2004.08.17
function zuClearTRS(formObj){
	var len=formObj.elements.length;
	var i=0;
	var message="";
	for(i=0;i<len;i++){
		if( formObj.elements[i].tagName=="INPUT" ) {
			//if(formObj.elements[i].type=="text" && !formObj.elements[i].readOnly) formObj.elements[i].value="";
			if(formObj.elements[i].type=="text" || formObj.elements[i].type == "hidden" ) formObj.elements[i].value="";
			else if(formObj.elements[i].type=="select-one") formObj.elements[i].selectedIndex=0;
			else if(formObj.elements[i].type=="radio") formObj.elements[i].checked=false;
			else if(formObj.elements[i].type=="button") continue;
		} else if( formObj.elements[i].tagName=="TEXTAREA" ) {
			formObj.elements[i].innerText="";
		} else if( formObj.elements[i].tagName=="SELECT" ) {
			formObj.elements[i].selectedIndex=0;
			//formObj.elements[i].value="";
		}
	}
	window.defaultStatus = "ÁØºñ(Ready)";
}

//ÆäÀÌÁö ¸ğµç ÀÔ·ÂÇÊµåµéÀ» disabled ½ÃÅ²´Ù.
//bln : boolean type (trueºñÈ°¼º,false È°¼º)
function zuMakeDisable(bln) {
	for (var i=0;i <document.transform.length;i++){
    	document.transform.elements[i].disabled=bln;
    }
}

// 1ÀÚ¸® ¼ıÀÚ¿¡ 0ºÙ¿©¼­ 2ÀÚ¸® ¹İÈ¯
function zuToLen2  ( nums ) {
        var num=0;

        if ( nums >= 1 && nums <=9 )
            num = '0' + nums;
        else
            num=nums;
        return num;
    }


function setCalDate(targetName, returnStr) {
    eval(targetName).value = returnStr;
}


function calPopForCMon(name, target){
    dateName = target;
    var dateVal = name.value;

    if(dateVal == "")
    {
        callCalPop(name, target);
    }
    else
    {
        var chk = zdIsDate(dateVal, 'YYYY-MM-DD');
        if(!chk) {

			var dNow = new Date();
			var yyyy = dNow.getYear();
			var MM   = dNow.getMonth()+1;
			if(MM < 10) MM = '0' + MM;
			var dd   = dNow.getDate();
			name.value = yyyy + '-' + MM + '-' + dd;

            callCalPopForCMon(name, target, yyyy, MM, dd);
        } else {
        	//callCalPopForCMon(name, target, dateVal.substring(0,4), dateVal.substring(5,7), dateVal.substring(8));
        	dateVal = zsRmString(dateVal, "-");
        	callCalPopForCMon(name, target, dateVal.substring(0,4), dateVal.substring(4,6), dateVal.substring(6));
        }
    }
}

function checkSpecial(target) {
                //~$@#'_- ., + »èÁ¦
                var eng = new String("!%^&()={}[]|?><");
                var t = new String(target);                             
                var tempStr;
                for(i=0;i<t.length;i++) {
                        tempStr = t.substring(i,i+1);
                        //34(") 39(') 92(\)
                        if(eng.indexOf(tempStr) >= 0 || tempStr.charCodeAt(0) ==
 34 || tempStr.charCodeAt(0) == 92) {                                
                             //alert(alertMsg[16]);//"Æ¯¼ö¹®ÀÚ´Â »ç¿ëÇÒ ¼ö ¾ø½À´Ï´Ù."
                             alert('Æ¯¼ö¹®ÀÚ´Â »ç¿ëÇÒ ¼ö ¾ø½À´Ï´Ù.');
                             return false;
                        }
                }
                return true;
}

// °´Ã¼ÀÇ Á¸Àç À¯¹« return
function chkExist( args ){
	if( args != "undefined" &&  args != "NaN" &&  args != null )
		return true;
	else
		return false;
}


// checkboxÀÇ ÀüÃ¼ ¼±ÅÃ½Ã ÀüÃ¼ º¯°æ
function allChk(arg_str){
	var chk = "";

    if( chkExist(arg_str) ){
		if( chkExist(arg_str.length) ){
			var len = arg_str.length;

			for( i = 0 ; i < len; i ++){
				if( arg_str[i].checked == true ){
      	  	    	chk = "YES";
      	  	    	break;
      	  	    }
			}

			if( chk == "YES" ){
				for( i = 0 ; i < len; i ++){
					arg_str[i].checked = false;
				}
			}else{
				for( i = 0 ; i < len; i ++){
					arg_str[i].checked = true;
				}
			}
		}else{
			if( arg_str.checked == true ){
      		    arg_str.checked = false;
      		}else{
      			arg_str.checked = true;
      		}
		}
    }
}


	function print_view(image) {
		var imgwin = window.open("", 'wall', 'scrollbars=yes, status=no, toolbar=no, resizable=0, location=no, menu=no, width=100, height=100');
		imgwin.focus();
		imgwin.document.open();
		imgwin.document.write("<html>\n");
		imgwin.document.write("<head>\n");
		imgwin.document.write("<title></title>\n");
		imgwin.document.write("<sc"+"ript>\n");
		imgwin.document.write("function resize() {\n");
		imgwin.document.write("pic = document.il;\n");
		imgwin.document.write("if(eval(pic).height) { var name = navigator.appName\n");
		imgwin.document.write(" if(name == 'Microsoft Internet Explorer'){ myHeight = eval(pic).height + 49; myWidth = eval(pic).width + 27;\n");
		imgwin.document.write(" } else { myHeight = eval(pic).height + 9; myWidth = eval(pic).width; }\n");
		imgwin.document.write(" clearTimeout();\n");
		imgwin.document.write(" var height = screen.height;\n");
		imgwin.document.write(" var width = screen.width;\n  ");
		imgwin.document.write(" var leftpos = width / 2 - myWidth / 2;\n");
		imgwin.document.write(" var toppos = height / 2 - myHeight / 2; \n");
		imgwin.document.write(" if( leftpos < 0) leftpos = 0; \n ");
		imgwin.document.write(" if( toppos < 0) toppos = 0; \n ");
		imgwin.document.write(" self.moveTo(leftpos, toppos);\n");
		imgwin.document.write(" self.resizeTo(myWidth, myHeight);\n");
		imgwin.document.write("} else setTimeOut(resize(), 100);}\n");
		imgwin.document.write("</sc"+"ript>\n");
		
		imgwin.document.write("</head>\n");
		imgwin.document.write('<body topmargin="0" leftmargin="0" marginheight="0" bottommargin="0" rightmargin="0" marginwidth="0" bgcolor="#FFFFFF">\n');
		
		imgwin.document.write("<img border=0 src="+image+" xwidth=100 xheight=9 name=il onload='resize();' onClick='javascript:window.close();' style='cursor:hand;'><br>\n");
		imgwin.document.write("</body>\n");
		imgwin.document.close();
	}
