<!--
***********************************************************************
* @source        : bona040_PV.jsp 				                                                                                     *
* @description   : 월별급상여지급현황 PAGE.    
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/01      김학수        최초작성.        
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import ="oracle.jdbc.driver.OracleTypes"%>
<%@page import ="com.shift.gef.core.exception.CException"%>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import ="com.shift.gef.gauce.utility.TrBox"%>
<%@page import ="com.shift.gef.support.collection.CBox"%>
<%@page import ="com.gauce.GauceDataSet"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>                
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>  
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%

    String STR_YYMM_SHR = request.getParameter("STR_YYMM_SHR");	
    String END_YYMM_SHR = request.getParameter("END_YYMM_SHR");
    String OCC_CD_SHR   = request.getParameter("OCC_CD_SHR");
    String SORT_SHR     = request.getParameter("SORT_SHR");

    String sql = "";
    String p_sql = "";

        if ( SORT_SHR.equals("1") ) {
            sql = XmlSqlUtils.getSQL("bon", "BONA040_SHR");
        } else if ( SORT_SHR.equals("2") ) {
            sql = XmlSqlUtils.getSQL("bon", "BONA040_SHR_01");
        } else if ( SORT_SHR.equals("3") ) {
            sql = XmlSqlUtils.getSQL("bon", "BONA040_SHR_02");
        } else {
            sql = XmlSqlUtils.getSQL("bon", "BONA040_SHR_03");
        }

        /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
        Object[] sqlParam = new Object[] {
        };

        /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
        sql = SqlUtils.replaceQuery(sql, sqlParam);

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                OCC_CD_SHR,
                STR_YYMM_SHR.replaceAll("-", ""),
                END_YYMM_SHR.replaceAll("-", ""),
        };

        AbstractDAO aaa= new AbstractDAO("default");
        DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

        extquery hnwExtQuery = new extquery();

        hnwExtQuery.AddField("월별");
        hnwExtQuery.AddField("구분");
        hnwExtQuery.AddField("인원");
        hnwExtQuery.AddField("급여");
        hnwExtQuery.AddField("개인연금");
        hnwExtQuery.AddField("기타");
        hnwExtQuery.AddField("계");
        hnwExtQuery.AddField("금액");
        hnwExtQuery.AddField("지급율");

        hnwExtQuery.SendField(response);

    //    System.out.println("voList.size()="+voList.size());
        int i = 0;

        if (voList.size() > 0) 
        {
            for ( i=0; i<voList.size(); i++ ) 
            {
                DynamicValueObject vo = (DynamicValueObject)voList.get(i);

                hnwExtQuery.AddData(vo.getString("PIS_YYMM"));
                hnwExtQuery.AddData(vo.getString("COMM_NM"));
                hnwExtQuery.AddData(vo.getString("ENO_CNT"));
                hnwExtQuery.AddData(vo.getString("PAY_AMT"));
                hnwExtQuery.AddData(vo.getString("PPEN_AMT"));
                hnwExtQuery.AddData(vo.getString("OTH_AMT"));
                hnwExtQuery.AddData(vo.getString("SUM_AMT"));
                hnwExtQuery.AddData(vo.getString("BON_AMT"));
                hnwExtQuery.AddData(vo.getString("PAY_PCT"));

                hnwExtQuery.SendData(response);
            }
        } else {
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



%>