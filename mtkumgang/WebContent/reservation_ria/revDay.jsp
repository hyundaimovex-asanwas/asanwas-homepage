<%@ page contentType="text/xml;charset=euc-kr"%>
<%
  StringBuffer strAd = new StringBuffer();
%>
<%
strAd.append("<?xml version=\"1.0\" encoding=\"EUC-KR\" standalone=\"no\"?>");
strAd.append("<DAY>");
strAd.append("<DAY_LIST>");
strAd.append("<D_TIT>À°·Î2¹Ú</D_TIT>");
strAd.append("<D_VAL>1111201</D_VAL>");
strAd.append("</DAY_LIST>");
strAd.append("<DAY_LIST>");
strAd.append("<D_TIT>À°·Î1¹Ú</D_TIT>");
strAd.append("<D_VAL>1111200</D_VAL>");
strAd.append("</DAY_LIST>");
strAd.append("</DAY>");

out.println(strAd.toString());
%>