<%@ page contentType="text/xml;charset=euc-kr"%>
<%
  StringBuffer strAd = new StringBuffer();
%>
<%
strAd.append("<?xml version=\"1.0\" encoding=\"EUC-KR\" standalone=\"no\"?>");
strAd.append("<CAL>");
strAd.append("<REAL_SEV_DATE>");
strAd.append("<DATE_VAL>20060608</DATE_VAL>");
strAd.append("</REAL_SEV_DATE>");
strAd.append("<CAL_LIST>");
strAd.append("<CAL_REV_Y>20060609|20060610|20060611|20060612</CAL_REV_Y>");
strAd.append("<CAL_REV_N>20060605|20060606|20060607|20060608</CAL_REV_N>");
strAd.append("</CAL_LIST>");
strAd.append("</CAL>");

out.println(strAd.toString());
%>