<%@ page contentType="text/html;charset=euc-kr" %><%@ page import="com.shift.gef.support.collection.*" %><%@ page import="com.shift.gef.support.utility.*" %><%@ page import="com.shift.gef.support.vo.*" %><%@ page import="com.gauce.*" %><%@ page import="com.gauce.io.*" %><%@ page import="com.shift.gef.configuration.Configuration" %><%
		CBox box = CollectionUtility.getGauceDataBox(request);
		box = SessionUtil.getSession( request, box );
		CodeManager cm = CodeManager.getInstance();
		CodeVO voList = cm.getCodeList(box.get("CODE_GUBUN"));
		System.out.println(box.get("CODE_GUBUN"));
		GauceDataSet gds = null;
		if (box.get("OPTION").equals("")) {
			gds = Mapper.getDataSet(voList);
		} else {
			gds = Mapper.getDataSet(voList, box.get("OPTION"));
		}
		Configuration conf = Configuration.getInstance();
		ServiceLoader loader = new ServiceLoader(request, response);
		GauceService service = service = loader.newService();
		// FIRST ROW SIZE를 지정해 준다.
		service.setFirstRowSize(conf.getInt("framework.gauce.firstrow.size"));

		GauceResponse res = service.getGauceResponse();

		if (gds == null || gds.getDataColCnt() == 0) {
			gds.flush();
		} else {
			res.enableFirstRow(gds);
			gds.flush();
		}
		res.flush();
		res.commit();
		res.close();%>