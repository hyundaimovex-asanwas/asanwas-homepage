<%@ page contentType="text/xml;charset=euc-kr"%>
<%
  StringBuffer strAd = new StringBuffer();
%>
<%
strAd.append("<?xml version=\"1.0\" encoding=\"EUC-KR\" standalone=\"no\"?>");
strAd.append("<CAU>");
strAd.append("<CAU_LIST>");
strAd.append("<CAU_CMT1>������ ������ ��¥�� �����Ͻ� �� �ֽ��ϴ�.</CAU_CMT1>");
strAd.append("<CAU_CMT1>1ȸ ����� �ִ�4���� ���Ǹ� ���� ���� �մϴ�.</CAU_CMT1>");
strAd.append("<CAU_CMT1>������ ����Ͻ� ���, ���ǿ��(150%)�� �ΰ��˴ϴ�.</CAU_CMT1>");

strAd.append("<CAU_CMT2>������ ������ �ֽʽÿ�.</CAU_CMT2>");
strAd.append("<CAU_CMT2>������ ���� �ϼž� ������ �����Ͻ� �� �ֽ��ϴ�.</CAU_CMT2>");

strAd.append("<CAU_CMT3>���� ���ҿ� ������ �����ϼž� �ο��� �����Ͻ� �� �ֽ��ϴ�.(3)</CAU_CMT3>");
strAd.append("<CAU_CMT3>���Ǵ� �ݵ�� ���� 1���� �ԷµǾ�� �մϴ�.(3)</CAU_CMT3>");

strAd.append("<CAU_CMT4>���� ���ҿ� ������ �����ϼž� �ο��� �����Ͻ� �� �ֽ��ϴ�.(4)</CAU_CMT4>");
strAd.append("<CAU_CMT4>���Ǵ� �ݵ�� ���� 1���� �ԷµǾ�� �մϴ�.(4)</CAU_CMT4>");

strAd.append("<CAU_CMT5>������ ������ �Է��� �ֽʽÿ�.</CAU_CMT5>");
strAd.append("<CAU_CMT5>�� ���Ǵ� 3����� ���� ���� �մϴ�.</CAU_CMT5>");
strAd.append("<CAU_CMT5>������ ���� �������� �ݵ�� �����̿��� �մϴ�.</CAU_CMT5>");
strAd.append("<CAU_CMT5>�Ǹ� �������̴� ������ �Ұ��� �մϴ�.</CAU_CMT5>");
strAd.append("<CAU_CMT5></CAU_CMT5>");

strAd.append("<CAU_CMT6>ȸ������ �Դϴ�.</CAU_CMT6>");
strAd.append("<CAU_CMT6>������ ������ ������ �������� Ȯ�� �Ǵ� �����Ͻ� �� �ݵ�� �ʿ��� �����̹Ƿ�, ��Ȯ�� ������ �����ϼž� �մϴ�.</CAU_CMT6>");
strAd.append("<CAU_CMT6>������ �ݵ�� �Ǹ����� �Է��ϼž� �մϴ�.</CAU_CMT6>");


strAd.append("<CAU_CMT7>��ȸ������ �Դϴ�.</CAU_CMT7>");
strAd.append("<CAU_CMT7>������ ������ ������ �������� Ȯ�� �Ǵ� �����Ͻ� �� �ݵ�� �ʿ��� �����̹Ƿ�, ��Ȯ�� ������ �����ϼž� �մϴ�.</CAU_CMT7>");
strAd.append("<CAU_CMT7>������ �ݵ�� �Ǹ����� �Է��ϼž� �մϴ�.</CAU_CMT7>");

strAd.append("<CAU_CMT8>����� �����ϼž� ������ �˴ϴ�.</CAU_CMT8>");

strAd.append("</CAU_LIST>");
strAd.append("</CAU>");

out.println(strAd.toString());
%>