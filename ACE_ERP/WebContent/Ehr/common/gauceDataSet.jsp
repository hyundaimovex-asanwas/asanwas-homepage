<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="com.shift.gef.support.utility.*" %>
<%@ page import="com.shift.gef.support.collection.*" %>
<%@ page import="com.shift.gef.support.vo.*" %>
<%
	CBox box = CollectionUtility.getGauceDataBox(request);
	box = SessionUtil.getSession(request, box);
%>



	<!-- 가우스 데이터셋 오브젝트 [코드 리스트] : <%=box.get("DATASET_ID")%> -->
	<object id="<%=box.get("DATASET_ID")%>" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<param name="Syncload" value="<%=box.get("SYNCLOAD")%>">
		<param name="DataId"   value="../../../servlet/GauceChannelSVL?cmd=Ehr.common.commnm.cmd.COMMNMCMD&S_MODE=SHR_00&CODE_GUBUN=<%=box.get("CODE_GUBUN")%>">
<%
	if (box.get("USEFILTER").toUpperCase().equals("TRUE")) {
%>
		<param name="UseFilter"   value="true">
<%
	} else {
%>
		<param name="UseFilter"   value="false">
<%
	}
%>
	</object>
