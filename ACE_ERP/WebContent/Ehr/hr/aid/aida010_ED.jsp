<!--
***********************************************************************
* @source      : aida010_ED.jsp
* @description : 공조부조금 신청서
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/14      방석호        최초작성.
* 2007/05/08      김학수
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

<%

    String REQ_NO  = request.getParameter("REQ_NO");


	/** 외부 XML에서 SQL을 읽어 온다 **/
	String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR_PRINT");
	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {
			REQ_NO
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);
    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("NO");
    hnwExtQuery.AddField("신청사유");
    hnwExtQuery.AddField("발생일");
    hnwExtQuery.AddField("대상자성명");
    hnwExtQuery.AddField("경조금");
    hnwExtQuery.AddField("공조금");
    hnwExtQuery.AddField("합계");

    hnwExtQuery.AddField("신청번호");
    hnwExtQuery.AddField("발생일자");
    hnwExtQuery.AddField("결재일자");
    hnwExtQuery.AddField("입사일");
    hnwExtQuery.AddField("부서");
    hnwExtQuery.AddField("직위");
    hnwExtQuery.AddField("신청자");
    hnwExtQuery.AddField("신청사유(select)");
    hnwExtQuery.AddField("대상자");
    hnwExtQuery.AddField("근속년");
    hnwExtQuery.AddField("근속월");
    hnwExtQuery.AddField("은행명(select)");
    hnwExtQuery.AddField("계좌번호");
    hnwExtQuery.AddField("예금주");
    hnwExtQuery.AddField("관리번호");
    hnwExtQuery.AddField("경조금");
    hnwExtQuery.AddField("공조금");
    hnwExtQuery.AddField("신청사유명");
    hnwExtQuery.AddField("은행명");
    hnwExtQuery.AddField("직종");


    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;
    int k = 0;
    int row_size = 0;
    row_size = 7 - (voList.size()%7);
    if ( row_size == 7 ) row_size = 0;

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(Integer.toString(i+1));
            hnwExtQuery.AddData(vo.getString("AID_CD"));
            hnwExtQuery.AddData(vo.getString("AID_YMD"));
            hnwExtQuery.AddData(vo.getString("AID_NM"));
            hnwExtQuery.AddData(vo.getString("HLP2_AMT"));
            hnwExtQuery.AddData(vo.getString("HLP1_AMT"));
            hnwExtQuery.AddData(Integer.toString(Integer.parseInt(vo.getString("HLP2_AMT")) + Integer.parseInt(vo.getString("HLP1_AMT"))));

            hnwExtQuery.AddData(vo.getString("REQ_NO"));
            hnwExtQuery.AddData(vo.getString("AID_YMD"));
            hnwExtQuery.AddData(vo.getString("REP_YMD"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("AID_CD"));
            hnwExtQuery.AddData(vo.getString("AID_NM"));
            hnwExtQuery.AddData(vo.getString("LSE_YY"));
            hnwExtQuery.AddData(vo.getString("LSE_MM"));
            hnwExtQuery.AddData(vo.getString("ABA_CD"));
            hnwExtQuery.AddData(vo.getString("ACC_NO"));
            hnwExtQuery.AddData(vo.getString("REC_NAM"));
            hnwExtQuery.AddData(vo.getString("WORK_NO1"));
            hnwExtQuery.AddData(vo.getString("HLP1_AMT"));
            hnwExtQuery.AddData(vo.getString("HLP2_AMT"));
            hnwExtQuery.AddData(vo.getString("COMM_NM"));
            hnwExtQuery.AddData(vo.getString("ABA_NM"));
            hnwExtQuery.AddData(vo.getString("OCC_CD"));

            hnwExtQuery.SendData(response);
        }

    }


%>