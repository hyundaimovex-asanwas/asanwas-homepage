<!--
***********************************************************************
* @source      : idta020_ED.jsp
* @description : 증명서발급처리
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/02      방석호        최초작성.
***********************************************************************
-->

<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>

<%@page import ="com.shift.gef.core.exception.CException"%>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import ="com.shift.gef.gauce.utility.TrBox"%>
<%@page import ="com.shift.gef.support.collection.CBox"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>
<%@ include file="/common/sessionCheck.jsp" %>

<%

	String SESSION_ENONO     = box.get("SESSION_ENONO");

    String sql = null;
    sql = XmlSqlUtils.getSQL("idt", "IDTA020_SHR_PRINT");
  	System.out.println(sql);

	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {
			SESSION_ENONO,
			SESSION_ENONO
	};


	  System.out.println("7777 "+SESSION_ENONO+" 77");


	/** 조회 조건(사용일자)에 따른 처리 **/


	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/


    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);
    DynamicValueObject vo = null;

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("발급번호");
    hnwExtQuery.AddField("부서");
    hnwExtQuery.AddField("직위");
    hnwExtQuery.AddField("사번");
    hnwExtQuery.AddField("이름");

    hnwExtQuery.AddField("증명서종류");
    hnwExtQuery.AddField("용도");
    hnwExtQuery.AddField("매수");
    hnwExtQuery.AddField("발급일");
    hnwExtQuery.AddField("출력구분");
    hnwExtQuery.AddField("마지막발급일");

    hnwExtQuery.SendField(response);


    int temp = 0;

    if (voList.size() > 0)
    {
    	temp = 10 - voList.size()%10;

        for (int i=0; i<voList.size(); i++)
        {
            vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("CEF_NO"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("CEF_SEC"));
            hnwExtQuery.AddData(vo.getString("CEF_RSN"));
            hnwExtQuery.AddData(vo.getString("CEF_CNT"));
            hnwExtQuery.AddData(vo.getString("SPL_YMD"));
            hnwExtQuery.AddData(vo.getString("CEF_STS"));
            hnwExtQuery.AddData(vo.getString("MAX_YMD"));

            hnwExtQuery.SendData(response);
        }

        for(int i=0; i<temp; i++) {

            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");

            hnwExtQuery.SendData(response);
        }
    }
    hnwExtQuery.EndData(response);
%>