<%@ page contentType="text/xml;charset=euc-kr"%>
<%
  StringBuffer strAd = new StringBuffer();
%>
<%
strAd.append("<?xml version=\"1.0\" encoding=\"EUC-KR\" standalone=\"no\"?>");
strAd.append("<CAU>");
strAd.append("<CAU_LIST>");
strAd.append("<CAU_CMT1>예약이 가능한 날짜만 선택하실 수 있습니다.</CAU_CMT1>");
strAd.append("<CAU_CMT1>1회 예약시 최대4개의 객실만 선택 가능 합니다.</CAU_CMT1>");
strAd.append("<CAU_CMT1>독실을 사용하실 경우, 독실요금(150%)가 부가됩니다.</CAU_CMT1>");

strAd.append("<CAU_CMT2>숙박을 선택해 주십시요.</CAU_CMT2>");
strAd.append("<CAU_CMT2>숙박을 선택 하셔야 객실을 선택하실 수 있습니다.</CAU_CMT2>");

strAd.append("<CAU_CMT3>먼저 숙소와 객실을 선택하셔야 인원을 설정하실 수 있습니다.(3)</CAU_CMT3>");
strAd.append("<CAU_CMT3>객실당 반드시 성인 1명이 입력되어야 합니다.(3)</CAU_CMT3>");

strAd.append("<CAU_CMT4>먼저 숙소와 객실을 선택하셔야 인원을 설정하실 수 있습니다.(4)</CAU_CMT4>");
strAd.append("<CAU_CMT4>객실당 반드시 성인 1명이 입력되어야 합니다.(4)</CAU_CMT4>");

strAd.append("<CAU_CMT5>관관객 정보를 입력해 주십시요.</CAU_CMT5>");
strAd.append("<CAU_CMT5>한 객실당 3명까지 투숙 가능 합니다.</CAU_CMT5>");
strAd.append("<CAU_CMT5>객실의 최초 투숙색은 반드시 성인이여야 합니다.</CAU_CMT5>");
strAd.append("<CAU_CMT5>실명 인증없이는 예약이 불가능 합니다.</CAU_CMT5>");
strAd.append("<CAU_CMT5></CAU_CMT5>");

strAd.append("<CAU_CMT6>회원인증 입니다.</CAU_CMT6>");
strAd.append("<CAU_CMT6>예약자 정보는 고객님의 예약결과를 확인 또는 변경하실 때 반드시 필요한 정보이므로, 정확한 내용을 기입하셔야 합니다.</CAU_CMT6>");
strAd.append("<CAU_CMT6>성명은 반드시 실명으로 입력하셔야 합니다.</CAU_CMT6>");


strAd.append("<CAU_CMT7>비회원인증 입니다.</CAU_CMT7>");
strAd.append("<CAU_CMT7>예약자 정보는 고객님의 예약결과를 확인 또는 변경하실 때 반드시 필요한 정보이므로, 정확한 내용을 기입하셔야 합니다.</CAU_CMT7>");
strAd.append("<CAU_CMT7>성명은 반드시 실명으로 입력하셔야 합니다.</CAU_CMT7>");

strAd.append("<CAU_CMT8>약관에 동의하셔야 예약이 됩니다.</CAU_CMT8>");

strAd.append("</CAU_LIST>");
strAd.append("</CAU>");

out.println(strAd.toString());
%>