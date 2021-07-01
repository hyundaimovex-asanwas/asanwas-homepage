<!--
***********************************************************************
* @Source         : eduh100_ED.jsp                                                    *
* @Description    : 실적현황관리 PAGE         
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/02      김학수        최초작성.        
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

    String edu_cd = request.getParameter("edu_cd");
    String seq_no = request.getParameter("seq_no");


    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("edu", "EDUH100_SHR_01");
 
    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
        
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        edu_cd, seq_no
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();
    hnwExtQuery.AddField("과정명");
    hnwExtQuery.AddField("차수");
    hnwExtQuery.AddField("교육구분");
    hnwExtQuery.AddField("학습일정");
    hnwExtQuery.AddField("학습기관");
    hnwExtQuery.AddField("소요비용");
    hnwExtQuery.AddField("환급여부");
    hnwExtQuery.AddField("실비용");
    hnwExtQuery.AddField("학습내용");
   
    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0) 
    {
        for ( i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("EDU_NM"));
            hnwExtQuery.AddData(vo.getString("CHASU_TAG"));
            hnwExtQuery.AddData(vo.getString("PLACE_NM"));
            hnwExtQuery.AddData(vo.getString("EDU_STR_YMD") + " ~ " + vo.getString("EDU_END_YMD"));
            hnwExtQuery.AddData(vo.getString("INT_NAM"));
            hnwExtQuery.AddData(vo.getString("COST_AMT"));
            hnwExtQuery.AddData(vo.getString("INS_NM"));
            hnwExtQuery.AddData(vo.getString("SUM_AMT"));
            hnwExtQuery.AddData(vo.getString("CONTENT_TXT")); 
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