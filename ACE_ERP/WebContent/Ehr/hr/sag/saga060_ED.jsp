<!--
***********************************************************************
* @source         : saga060_ED.jsp 				                                                                                     *
* @description   : 급상여지급현황 PAGE.
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/24      김학수        최초작성.
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

    String STR_YYMM_SHR = request.getParameter("STR_YYMM_SHR");
    String END_YYMM_SHR = request.getParameter("END_YYMM_SHR");
    String OCC_CD_SHR   = request.getParameter("OCC_CD_SHR");
    String SAL_GBN_SHR  = request.getParameter("SAL_GBN_SHR");
    String SEQ_SHR      = request.getParameter("SEQ_SHR");
    String SORT_SHR     = request.getParameter("SORT_SHR");

    String sql = "";

    if ( SORT_SHR.equals("1") ) {
       /** 외부 XML에서 SQL을 읽어 온다 **/
        sql = XmlSqlUtils.getSQL("sag", "SAGA060_SHR");
    } else if ( SORT_SHR.equals("2") ) {
        sql = XmlSqlUtils.getSQL("sag", "SAGA060_SHR_01");
    } else {
        sql = XmlSqlUtils.getSQL("sag", "SAGA060_SHR_02");
    }

    StringBuffer sb1 = new StringBuffer();
    StringBuffer sb2 = new StringBuffer();
    if ( !SAL_GBN_SHR.equals("") ) {
        sb1.append("AND (B.SEQ LIKE '"+SEQ_SHR+"') \n");//일련번호
        sb2.append("AND (B.SAL_GBN LIKE '"+SAL_GBN_SHR+"') \n");//급상여구분
    }

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
        sb1.toString(),
        sb2.toString()
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
        OCC_CD_SHR, STR_YYMM_SHR.replaceAll("-", ""), END_YYMM_SHR.replaceAll("-", "")
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
   
    hnwExtQuery.AddField("직급/부서");
    hnwExtQuery.AddField("인원");
    hnwExtQuery.AddField("기본급");
    hnwExtQuery.AddField("직책수당");
    hnwExtQuery.AddField("시간외수당");
    
    hnwExtQuery.AddField("복지수당,기술수당");
    hnwExtQuery.AddField("자기개발비,택배수당");
    hnwExtQuery.AddField("야근수당,운행/작업수당");
    hnwExtQuery.AddField("전산수당,자기개발비");    
    hnwExtQuery.AddField("근속수당");
    hnwExtQuery.AddField("자동지급");
    hnwExtQuery.AddField("고정수당");
    hnwExtQuery.AddField("기타지불액");
    hnwExtQuery.AddField("급여계");    
    hnwExtQuery.AddField("건강보험");
    hnwExtQuery.AddField("국민연금");
    hnwExtQuery.AddField("고용보험");
    hnwExtQuery.AddField("개인연금");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("COMM_NM"));
            hnwExtQuery.AddData(vo.getString("PERSONS_NUM"));
            hnwExtQuery.AddData(vo.getString("BAS_AMT"));
            hnwExtQuery.AddData(vo.getString("DUTY_AMT"));            
            hnwExtQuery.AddData(vo.getString("OT_AMT"));   
            
            hnwExtQuery.AddData(vo.getString("WEL_AMT"));
            hnwExtQuery.AddData(vo.getString("OSE_AMT"));
            hnwExtQuery.AddData(vo.getString("RUN_AMT"));    
            hnwExtQuery.AddData(vo.getString("MH_AMT"));                
            hnwExtQuery.AddData(vo.getString("LSEV_AMT"));
            hnwExtQuery.AddData(vo.getString("TB3_AMT"));
            hnwExtQuery.AddData(vo.getString("SGF_AMT"));            
            hnwExtQuery.AddData(vo.getString("OTH_AMT"));
            hnwExtQuery.AddData(vo.getString("SALT_AMT"));            
            hnwExtQuery.AddData(vo.getString("HINU_AMT"));
            hnwExtQuery.AddData(vo.getString("NPEN_AMT"));
            hnwExtQuery.AddData(vo.getString("HINS_AMT"));
            hnwExtQuery.AddData(vo.getString("PPEN_AMT"));


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