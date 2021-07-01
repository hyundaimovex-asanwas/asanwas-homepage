<%@page import="java.lang.reflect.Array"%>
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          javax.ejb.*,java.util.Vector,
          elsoft.extquery.*"
%>
<%@page import="com.shift.gef.support.utility.*" %>
<%@page import="com.shift.gef.support.vo.*" %>
<%@ include file="/common/sessionCheck.jsp" %>

<%
extquery hnwExtQuery = new extquery();

hnwExtQuery.AddField("전공계열");
hnwExtQuery.AddField("인원");
hnwExtQuery.AddField("비율");

hnwExtQuery.SendField(response);

DynamicValueObject voList = DvoUtil.getDynamicValueObject(request, "RESULT");
DynamicValueObject vo = null;

System.out.println("voList.size() : "+voList.size());
if (voList.size() > 1){
	String arr[][] = new String[voList.size()][3];

	for (int i=0; i<voList.size(); i++) {
		vo = (DynamicValueObject)voList.get(i);
		arr[i][0] = vo.getString("JUN");
		arr[i][1] = vo.getString("NUM");
		arr[i][2] = vo.getString("PER");
		System.out.println(arr[i][0]);
		System.out.println(arr[i][1]);
		System.out.println(arr[i][2]);
	}


	for (int i=0; i<voList.size(); i++) {
		hnwExtQuery.AddData(arr[i][0]);
		hnwExtQuery.AddData(arr[i][1]);
		hnwExtQuery.AddData(arr[i][2]);
		hnwExtQuery.SendData(response);
	}
}else{
	hnwExtQuery.AddData(" ");
	hnwExtQuery.AddData(" ");
	hnwExtQuery.AddData(" ");
	hnwExtQuery.SendData(response);
}

%>