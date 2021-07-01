<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.security.Key"%>
<%@ page import="java.security.Security"%>
<%@ page import="javax.crypto.Cipher"%>
<%@ page import="javax.crypto.CipherInputStream"%>
<%@ page import="javax.crypto.spec.SecretKeySpec"%>
<%@ page import="sun.misc.BASE64Encoder"%>
<%!
private final String SK = "clips.sso.hdasan"; // 16Byte
private final String SA = "AES";              // 문자 암호화 알고리즘c
private final Key cKey = getKey(SK, SA);      // 문자 암호화 KEY

public Key getKey(String strKey, String strAlgorithm) {
	Key myKey = new SecretKeySpec(strKey.getBytes(), strAlgorithm);
	return myKey;
}

/**
 * 문자 암호화
 *
 * @param str
 * @return
 * @throws Exception
 */
public String encrypt(String str) throws Exception {
	return encrypt(str, cKey);
}

/**
 * 파라미터 키로 문자 암호화
 *
 * @param str
 * @param mykey
 * @return
 * @throws Exception
 */
public String encrypt(String str, Key mykey) throws Exception {
	String strResult = null;
	try {
		Security.addProvider(new com.sun.crypto.provider.SunJCE());
		Cipher cipher = Cipher.getInstance(mykey.getAlgorithm());
		cipher.init(Cipher.ENCRYPT_MODE, mykey);
		byte[] bEnc = cipher.doFinal(str.getBytes());

		strResult = new BASE64Encoder().encode(bEnc);

		return strResult;
	} catch (Exception e) {
		throw e;
	}
}
%>
<%
	String bz_ins_no = request.getParameter("bz_ins_no");
	//String bz_ins_no = "2208132444";             // 사업자번호
	//String enc = (String)encrypt(bz_ins_no);     // 사업자번호 암호화
%>
<html>
<script type="text/javascript">
<!--
	function popup_open(param) {
		document.frm.bz_ins_no.value = param;
		document.frm.action = "http://clip.nice.co.kr/rep_nclip/rep_DLink/rep_Link_hdasan.jsp";
		var width = 800;
		var height = 700;
		posx = (screen.width - width) / 2 - 1;
		posy = (screen.height - height) / 2 - 1;
		var rptWin = window .open( "", 'rpt_win', 'toolbar=no,location=no,locationbar=no,personalbar=no,directories=no,status=no,statusbar=no,menubar=no,titlebar=no,scrollbars=yes,resizable=no,menu=no,width=' + width + ',height=' + height + ',left=' + posx + ',top=' + posy);
		document.frm.target = "rpt_win";
		document.frm.submit();
	}

//-->
</script>
<body>
	<form name="frm" method="post">
		<input type="hidden" name="bz_ins_no">
		<div align="center">
			<a href="JavaScript:popup_open('<%=bz_ins_no%>');" onFocus="blur()">Link</a>
		</div>
	</form>
</body>
</html>